Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD31BE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 12:22:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOc0X-0002lL-3A; Fri, 20 Dec 2024 07:21:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tOc0T-0002km-Rf
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 07:21:26 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tOc0Q-0006Lx-Q0
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 07:21:24 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4361f65ca01so17797675e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 04:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1734697279; x=1735302079; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4RZjW1ZzfWtFNM7Fo6PWNkQd9tSs+Wm+SAia6AdYns=;
 b=Z7+tiaPA2oTbmMJtzJL5s6u/a6XXNsf/cGYL0OglAnuOQO0kl7vEmsxf1zbtgJfPkD
 D4gOWDYWAbImnqXchEo+u+GeV4dbPtJ6uB6+Ay16O4W6zsle3blHZPnFj7CkNYtE6hVJ
 ly9WMSYB9CG0DZ1o64GTeL9Acz49aS+ctMhHXcSc9HDq11RsT84uba9wgkLR6X5MaFAO
 MepbWqqsNKCtXNQ0KKoWlsf1jG/8knoJBE5KIM7XJxo6XNhGmwnDEoxxt29f7fWU3Ggd
 x7YmtpOf6opdCB8s87Ty2+OwxOln5pgh7tw7TID6wkPqU6zs0rC8GKIZ5MqGoLV/zi/N
 gZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734697279; x=1735302079;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=K4RZjW1ZzfWtFNM7Fo6PWNkQd9tSs+Wm+SAia6AdYns=;
 b=KxDlXtQvFPgl7XzSXnivM1oRvaUXqoZrn//T0zJ6Hl6PRz2e9MRCkJdYCwkZYucLu1
 EIOi6nLkeVRX2X4ROk+KpCos3qg1yau4HwbWIqtCKRAHOh3REHxIOv4NYlWWEWwLoifP
 d92lN+orBXuapA8W3WHQpxczbwel/Iwpw0wB8961vm/7KWq3Cy6G+mQik6xpcqqVeqPA
 Wie3Xwshcb1NveZsWwD9a1iLaM9+FDK728uZ2InGyM2kmtfNndzZ4us5odD6zXhjX5Pi
 5n87lnIpVUmrxDkQKvQ6EGmqWkifX9mwAz4Hc7dmeflKqqf94qa+JPgAPbBxnu/eCDe7
 GGJw==
X-Gm-Message-State: AOJu0YzibQO8uFpRFTAXzDLjvVhFMP6Kvzmv7NNSxmIJjeC3WrnE/nQc
 YsiIoRfLbODdxIyyUFTUiIi+DHg8aB6iwJtjiDvTQRGO9UhmlHgJYdKbI7z6QQ1igKiUEq59ZpI
 Yhqs=
X-Gm-Gg: ASbGncuNZt80HtWhtbldIcd33Dig4XmJEs7UfyK0xXDEDOzg5+d06MzcQ1kssxGew5r
 Zy2CL7KToWHVDw/V89/D56J40PRMndlyNpTa3pgZ5B9flJL96ln7jfrjARLiMvKvQF3qJrDHpDW
 zklzamU7iECe5/TuVYzxKoyHburY848hWiioK3JWWEvVPuquZsZ0z2EJEOxdrMmhzaUI8Gwo0KL
 8RktyYFhQQWG9pmikp54/aOLfZ/cjh9TS6zfOhaeF31Ho9IxHvhhXH0jeBtFqqTJ1WZbV7rPPF5
 DsaHqSmAdJqZBuchxK+t1MUYcfk9qB9kpt/OjIbGQS6U8qwW
X-Google-Smtp-Source: AGHT+IGSev90TnkO1fSId4WqiStBjGUL2AHt1UTekhfEmhw3l3Y40BjNCpX3M0q1WgnjHjjeBenMtA==
X-Received: by 2002:a05:600c:4fd3:b0:436:5165:f1ec with SMTP id
 5b1f17b1804b1-43668b769f8mr24366605e9.30.1734697279136; 
 Fri, 20 Dec 2024 04:21:19 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43661289e0fsm44903785e9.39.2024.12.20.04.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 04:21:18 -0800 (PST)
From: Craig Blackmore <craig.blackmore@embecosm.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Craig Blackmore <craig.blackmore@embecosm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Helene Chelin <helene.chelin@embecosm.com>, Nathan Egge <negge@google.com>,
 Max Chou <max.chou@sifive.com>
Subject: [PATCH v7 0/1] target/riscv: rvv: Use wider accesses for unit stride
 load/store
Date: Fri, 20 Dec 2024 12:21:08 +0000
Message-ID: <20241220122109.2083215-1-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Thanks Richard Henderson for the review on v6.

Changes since v6:
- Use atomic.h and atomic128.h functions
- Fix incorrect indentation in ok_for_atomic

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/
- v5: https://lore.kernel.org/all/20241211143118.661268-1-craig.blackmore@embecosm.com/
- v6: https://lore.kernel.org/all/20241218142937.1028602-1-craig.blackmore@embecosm.com/

Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Alistair Francis <alistair.francis@wdc.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Weiwei Li <liwei1518@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: Helene Chelin <helene.chelin@embecosm.com>
Cc: Nathan Egge <negge@google.com>
Cc: Max Chou <max.chou@sifive.com>

Craig Blackmore (1):
  target/riscv: rvv: Use wider accesses for unit stride load/store

 target/riscv/vector_helper.c | 107 +++++++++++++++++++++++++++++++++--
 1 file changed, 101 insertions(+), 6 deletions(-)

-- 
2.43.0


