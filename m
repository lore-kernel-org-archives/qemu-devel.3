Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EBE3E77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:32:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNkd-0002UA-8y; Wed, 11 Dec 2024 09:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLNkZ-0002TZ-DY
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:31:39 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <craig.blackmore@embecosm.com>)
 id 1tLNkU-0001rC-VU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:31:39 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434a766b475so65158675e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=embecosm.com; s=google; t=1733927493; x=1734532293; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FkhAb6XWdcUVPQN7u/akm5gsE8B+w0RWYKLeoc64EHg=;
 b=aA8ggWhHDDmWbGCWYyKmLtwG+MO8LS+L5S4Yd4soloRRe+mRtZQmYxdFvTo+yyOERr
 r+q4yfhp6Y6XdB/KrttuLAGY3fl8hjx31IIvtWRk2/w074ZoNESE7WUm+3Vakrer34If
 drzV9ITSwpga3qQ8o0UFkT36WNjShojR3F/VJJnsRa99ZpSEY1wWexR1ZnMRXsESCJUN
 H1KI99gT/hS8XavJ88rlk5HOoV0vcGunKjGZzRahKpjhNPeZ9pMStRf9C5DT4f7uW7w4
 I9tRm7Kt6Bqguff0vXiSoTj6u66ji7vbwSjAPA/9VnUzjTJid7jF4TkgJ0MD2JpeTfos
 FtPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733927493; x=1734532293;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FkhAb6XWdcUVPQN7u/akm5gsE8B+w0RWYKLeoc64EHg=;
 b=lJAznJ5Uxc9/vJkj5mUQU5fRYa6iL8EdfhEq+oD1vxWMjpJq1h6B6h5lGO5VOqOW+0
 oYRJYLhyM/s8g3YOOgaPQaNxktzqQI1hbS5hD/9Zzxh/YNFrFpLhR1TRE5Q8YrGDGfeN
 jevMpqHKtFCLSKc3YTthSP7zpiVx28b/5noDhKjCw0JNNk9b80gmdwUCrKPPtqU/MpPn
 w56AlD+PaDT1miQtoTevvUW5+TLUj7lMCAlFyG/srvdTH3ogo7i0WxdkHQDw9lPrJvk3
 2ORlLOzJMMg0AM0LxTGs38Zua9qiwws1IDO2aBEMh+LGNa2+Dx9FsPQZ6URj4w9pDuw9
 v5Rg==
X-Gm-Message-State: AOJu0YyiHs88ZK2THpncgyFT7PdFbpY1pOhU8kOHZKF4Z3UgoEQoxFLu
 oSq6F+8/5Fo5+uGqqcX2lqaajh9wF9cbxOnNUvwlGr/uPvrUDRKdVZ8m08lYTWHqv7U89VbcyoX
 GXtQ=
X-Gm-Gg: ASbGnctYi0MAWcKmiRL+ObSxeRwZjy6WmfglEiNNkRFNpdR+I2NkzW7njFd5v6DIA32
 XhaHKCZquNEMEA1bDsdVHDv2Q3KKmodL+uCLU4sWPpfp00vN5Z94LTapZ7iXsiajUK96Sa1CweB
 5iNRlEyXmZXYn90MoZhl1Vrz373ERuqILu6OilI412WWdmjlDzkFa+hYFthdgrkq72wqPcdvtBJ
 o2BVCwuDE6ehQT8QiaYQvoQb+U6TBH5e5I6qGsBY6RtYVgiX8SQ6MuwZU7NzNlVE59V8wVnx5rT
 cQR8cyC7kQ3zcGq22n4H1vUXkD7FSoFB1wbeia4Se3hTeA==
X-Google-Smtp-Source: AGHT+IF1+shcds8SZy3f7b7zGJcUMiGguvDS9X6DsFDrr35nbBJcUalLIvhtVhJfiYmLbVDpuJNgjg==
X-Received: by 2002:a05:600c:350a:b0:434:a684:9b1 with SMTP id
 5b1f17b1804b1-4361c344cb7mr25337145e9.4.1733927492962; 
 Wed, 11 Dec 2024 06:31:32 -0800 (PST)
Received: from dorian..
 (sals-04-b2-v4wan-167965-cust660.vm36.cable.virginm.net. [80.3.10.149])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434e8ec8072sm153602425e9.18.2024.12.11.06.31.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:31:32 -0800 (PST)
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
Subject: [RFC PATCH v5 0/1] target/riscv: rvv: Use wider accesses for unit
 stride load/store
Date: Wed, 11 Dec 2024 14:31:17 +0000
Message-ID: <20241211143118.661268-1-craig.blackmore@embecosm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=craig.blackmore@embecosm.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Changes since v4:
- Split into a seperate submission to simplify review
- Use load/store atomic functions as suggested by Richard Henderson
- Do 8, 4, 2 byte atomic ldst for sizes smaller than 16 bytes

This patch now uses the atomic ldst functions from
accel/tcg/ldst_atomicity.c.inc to ensure element size atomicity.  I was
not sure of the best way to make these functions accessible from the
riscv target, so any suggestions are very welcome.

Previous versions:
- v1: https://lore.kernel.org/all/20240717153040.11073-1-paolo.savini@embecosm.com/
- v2: https://lore.kernel.org/all/20241002135708.99146-1-paolo.savini@embecosm.com/
- v3: https://lore.kernel.org/all/20241014220153.196183-1-paolo.savini@embecosm.com/
- v4: https://lore.kernel.org/all/20241029194348.59574-1-paolo.savini@embecosm.com/

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

 target/riscv/trace-events    | 12 +++++
 target/riscv/vector_helper.c | 95 +++++++++++++++++++++++++++++++++---
 2 files changed, 101 insertions(+), 6 deletions(-)

-- 
2.43.0


