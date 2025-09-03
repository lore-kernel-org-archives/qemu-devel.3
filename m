Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B00CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 13:03:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utn7g-00059w-Cx; Wed, 03 Sep 2025 09:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7Z-00055Y-4e
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:01:53 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1utn7X-0000Us-9i
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 09:01:52 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-32b70820360so513298a91.2
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 06:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1756904509; x=1757509309; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a5HBE4kGgHVv5ddGcsNk2eOhjM/e0af34LDVEryaLhU=;
 b=dmOA3ErJlFQLr6dvZxnd8Gl7ZdOAuHY5+NgEsZ9VWmfOoXbdTkYTx2fS2uQOqWm84g
 yz3K1LFOcVqb7RGxDl2pTNhPo0Eyi4qNGFjqlwKUMbXH4b474vamVTtlAaQhUMAHV2S7
 J15zqgqm1Xnp8tyEYpRQIdqJFLmrWSgfQbrrqBzuhPYcdWWtunJsGwmCsotSoZQ5zS/g
 1Tm+QKe5Y2ytQcROJUk9aCSnRvP91K7LopSj6vV8EJ8jn5NYFkD8AivgfN332XKWMXTg
 LmMCPPMzCHHLy1jgNaoVOA1FTwowrSWODgPAZUZHsXAJLhIW42VowLAF4806eVvJncby
 keRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756904509; x=1757509309;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a5HBE4kGgHVv5ddGcsNk2eOhjM/e0af34LDVEryaLhU=;
 b=EBdF3zlDE1J7TcLKoUxaJTPCXhhyFemI50a4Gr64ithQllBwUcDUm65yC0aSwUjQ8f
 mJOQcJj97t4jbYIL0noTpcMu4Xz/dmqj564EUXC3UNGa7NehtZKZiR5q8QrUwRJ5WJ27
 Eb9u5jXYihINmfGnmYFR7g3uzzEsb+bxoXk292x0cxPWxAuQGKfjo8RjhBL/QjDc2/dn
 Q6/7YBeysOfs7hrcgiJkeV9RsgPyIxhDi1dWolTRSGrlGmAxdb+zW+GziOcMxbT86wI2
 o9xOlLIXiAd7stxlnppBainqgqYYpGEyLefYtmzM6YfCqeLl4BLpOCsIRQW138eXuQ5d
 +8+w==
X-Gm-Message-State: AOJu0YzmoCz/ROjjJcfXgcEgefpSw3gOy+yfitUQyg3BshFdVWIa23w2
 28Tb8tqr/Jy9A/BzK+y1ivpzoAJcPW0BV1kYiPoX0+oXaqV1A5jpHWzo0DAiRgLea9Zd+zi+m6P
 FotG+YNI0mRX8+TOOJQ+g9CEYm51GVw7XMk+/ehZ4pYqesjhSZ2ybdr0ciA49fPMtMKi0oEctvb
 AsOFK4IEKj+XMVSRvj7wZEMVnohWJv/PpUffEmVD3CBg==
X-Gm-Gg: ASbGncv6wzU567mvD84GTHUTv8fl6MewNV6U4GOGyNrsRgewoeNKmcJ/nT66dMtjvus
 jx6TGmBfQH2EGtJ8BrGYL8W5o0Vzz9R0s21zXBHzXOHZ+oC46two6f30+O8EqNuG+5f8eEuwvhw
 zYnhd/g+XTF9Yhqrbzx3Y9GgE7kLgl6l8n/2eI9K4jMM9HeWJV9ecTn5FGQBBuEqTmxc3ZdexKK
 Gg8WyhCPYmg5LfS/IuYxhD9RWc13499N7r6hBngyQg2rCRq8Iz8075IsyOVVhUQmjxpnXn/W/Pl
 Sid6OEoPz0GSp8Nu51Gkb/09/zpZsB4UIx/wuu6psbDVkgnL+YZGuPNeLQ/BKvCsidVxlDWpD74
 cAjicvGcm/8qAdLlJwWK7U7+hsE5CaA9Os/x/Lw6dc9nRCeQ1yxMEYtFtNf0RNp3sC0On732NXi
 jWIg==
X-Google-Smtp-Source: AGHT+IHhWSOOYiOkcPRhJAVTlaM+xESFcT8Qo77wqYZmR3jF1T1RFHevuaicR6xrxPJXgb+mw6+p9w==
X-Received: by 2002:a17:90b:5205:b0:329:cb75:fef2 with SMTP id
 98e67ed59e1d1-329cb761185mr10499582a91.3.1756904509046; 
 Wed, 03 Sep 2025 06:01:49 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-329e23858ecsm5472278a91.14.2025.09.03.06.01.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Sep 2025 06:01:48 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v2 0/3] Add Zvqdotq support
Date: Wed,  3 Sep 2025 21:01:22 +0800
Message-ID: <20250903130125.1701363-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x102d.google.com
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

This patch series adds Zvqdotq support.

The isa spec of Zvqdotq extension is not ratified yet, so this patch series
is based on the latest draft of the spec (v0.0.2) and make the Zvqdotq
extension as an experimental extension.

The draft of the Zvqdotq isa spec:
https://github.com/riscv/riscv-dot-product

v2:
* Remove unnecessary variable and mask (Thanks for Richard Henderson's
  suggestion)

Max Chou (3):
  target/riscv: Add Zvqdotq cfg property
  target/riscv: rvv: Add Zvqdotq support
  target/riscv: Expose Zvqdotq extension as a cpu property

 target/riscv/cpu.c                            |  2 +
 target/riscv/cpu_cfg_fields.h.inc             |  1 +
 target/riscv/helper.h                         | 10 +++
 target/riscv/insn32.decode                    |  9 +++
 target/riscv/insn_trans/trans_rvzvqdotq.c.inc | 61 +++++++++++++++++++
 target/riscv/tcg/tcg-cpu.c                    |  5 ++
 target/riscv/translate.c                      |  1 +
 target/riscv/vector_helper.c                  | 61 +++++++++++++++++++
 8 files changed, 150 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

--
2.39.3


