Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E917CA1013
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 02:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvRz1-0004oS-3H; Sun, 07 Sep 2025 22:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uvRyx-0004o3-F9
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 22:51:51 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uvRyh-0003jF-DF
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 22:51:50 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-77251d7cca6so3172803b3a.3
 for <qemu-devel@nongnu.org>; Sun, 07 Sep 2025 19:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757299884; x=1757904684; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xP9a8Kw49JWphmuuT6z7629GJ1vhcNYD+R1e6O3zS5s=;
 b=MhaI00NyElft157OdU539civVtgTyLtEos0rJwYSs6r/b/k+85eNhAkz9wXXM8jk+W
 qLk4rP1cIylFPewOmbmKUaperDRp7y3bNmJzVGKqgAX6k7tTkKmi76jyYyD+TUKCon6e
 4y0sn6w8OWBzserxkLyt9YPfM73vNNZFEMzasUaFpwBC4thENQUhxhFR4TRPynWo2Iur
 32Zb4YaIlTMcdUWH0eEbw0QQYt1L9qQhGUrsPC9a32y3OlKRRyXZkGCNBljKR/U2Vch2
 sJvoCemA8i5chg6T1pAAWycfSTSnWixydbDVP99eQZq9p6jcfsz/PpzJF1dmfVHEQDDv
 Ny4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757299884; x=1757904684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xP9a8Kw49JWphmuuT6z7629GJ1vhcNYD+R1e6O3zS5s=;
 b=YEhDGfBA4va03w1/NSm+5NA4CVUp1UBskB8vNtv7r3T831j5gFI0K2k9eL18U01vM7
 LEU1vrKxS9OA9i5DmjRE0rZwG+gLEMrbR0ODRwwqNw9nyNmX/EwCJYGK1NR5ZXsb1g/u
 nEfiSo0hY9nbcfPGh2vcHfOLDBHZCjWKQLLBlDmaaBCQGlihkYkx5opshGjRMwpMeffo
 JaFKL+zQTh0E45I3JsraDXaq8mPP5/Kdw+Cya1Z/pGiWIM9pVrz0/JL7//aKrIYfbBT7
 hq699tN8TS5EHesyU+4N9G7niT/iQ+SqPQWBHagFAZm2r27ufx+Dow/NKhkMUzpkEHpD
 9s2A==
X-Gm-Message-State: AOJu0YwsOy6dE9+tHCbbi/s+OpZ86hP/PTvni3LnFojRKGHiTHP7mdto
 EuUA3ReQXFGJllfiGeO/qgjX5A1eQgS2v8oKApNbSsx9JCwtC0d0uRvnYfpyFxZ526Xx5zQZJf8
 IW/YEvBcxiyXTE93wa22/+YDEG/NLvfVIO5u4zCklUPWdFz6MlzClOEASxuApJlYBJM3+kAJrkY
 57CzCAKt/Mb3etCx2c5CL9HfOO72GyPGihAFymzXzcXQ==
X-Gm-Gg: ASbGncuIH3ktHM8XA/ZdKuDtv5Ii2q3TfDqUBHQEq6FL6PBfzxUCCXl84hDMUUL0XYm
 O3M4riSdu4uOIJstfAsG5VOqreXf26V6ImLnBY9hiPTV44kRikd4gI4aJWNR8YCL9kza5yfSUYQ
 Wwpowzne18Z0CwZZYXRL+fP+3cjYsuxjYicBUJrDHXcsGOUtzTM2Xzo40i+jjBiscPYdlkO9S+b
 xp1LrIgqYqbOtUPD35HELilxoFHjEg9GeX69Gx1bAV4tlysKcmEfnV+kCn2qUTX88yc0+0a8geT
 /WcG1Iu0xZGGHQV0T7fbFzA5vGvzzZ26QfMq7G8Vgzi9J1VBvBRM4AUalQJ86Oa+bCQU48apKKZ
 v9HSHMGCDM8kXMbb/xpFT4F8pHEk+h7aprUdS9EmWJvtYY2gp4yo1LIP09vJyLSGAQ9OBhqTte3
 UFpQ==
X-Google-Smtp-Source: AGHT+IFgOmjiGAXzD5dJjA9n1n8ZJI1uTj6N5/XQ9idKdtMRIA2l0muAQTj0zPucvjjp4RX4ADA6tA==
X-Received: by 2002:a05:6a00:17a8:b0:772:5165:3f68 with SMTP id
 d2e1a72fcca58-7742de615c8mr6479526b3a.27.1757299884246; 
 Sun, 07 Sep 2025 19:51:24 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-772306a1870sm26823834b3a.75.2025.09.07.19.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Sep 2025 19:51:23 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 0/3] Add Zvqdotq support
Date: Mon,  8 Sep 2025 10:51:14 +0800
Message-ID: <20250908025117.1728895-1-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

v4:
* Update the PRIV_VERSION (Thanks for Daniel Henrique Barboza's suggestion)

v3:
* Fix casting and simplify vs1/vs2 access (Thanks for Richard Henderson's
  suggestion)

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
 target/riscv/vector_helper.c                  | 57 +++++++++++++++++
 8 files changed, 146 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzvqdotq.c.inc

--
2.39.3


