Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D73CD343F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtGv-0006xL-Qs; Fri, 15 May 2026 10:12:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGp-0006mZ-Rs
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:09 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNtGn-0004DA-LO
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:12:07 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so152709085e9.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778854324; x=1779459124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cud1EvGK9OKgm2wbbXO0Tg7zjgqWh8fpMgEbSaEWLIc=;
 b=ZkTiTdYX1J6Xl82lBrsIvOHkiZ1IOFdGcpQX4lRQHE/WB38zkrSlx4QFCqu5u+oghD
 g3aL7fqPhdBYCD6VvtykVYYb927rBdzvDnHEnb+xb0dn6jlgalA6W0RjEdjk70XI6sQ+
 BjpGuKKVEBTQ+GIxibpE5a/kLpSbZsBi3E83L1zMFF4NraTm5+kFtyXnLOH0EHN/8gHz
 42rtajyV6SfEJ4dvFxFtPqSQ8jE7nwZcqvIS1AcpotL1efd6TMVQzqGvRuY5td8IOBv/
 wVuT0syeTwwCCcyTMNMqXZDSjGhJiX90LyfZbp1T5rfcfl8B/DWajCyaFly/Qt8K85n8
 XeOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778854324; x=1779459124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cud1EvGK9OKgm2wbbXO0Tg7zjgqWh8fpMgEbSaEWLIc=;
 b=IYVIK1gkGZRSmn3bweMXHeHSDhP2KzEEIEFYIeVOMbiQfRfLV8n8GOhlrQnh9ZL8hV
 E8p3OBRLv5O73U9VPmFPj4qw+XrUbvETqkAcmVK+3jQnchUrEiqlGAnKRjc1iOzpgPiR
 OiSJPeFAM+QtNtgPQcrTZnaCXG7CTyi1erK0/GH3ysI/OspXCpxmCID6xwKUIDPLf93s
 iHuaIaTutd7BjRSlQlHTMFsmr5Tw1sGogrJQ7F4D4RQHChYhghyEJg9XzhACwfLi4fg9
 tk1w8Ov5qHFxsa1zu/QtO+7rXAEgvZbGfzMS1slCqMVsYMcWOS6nr6lRuwCujizFKRlY
 NbLQ==
X-Gm-Message-State: AOJu0Yx/EZ94ky6ZPg6C9mhMVmfEPn+5Hta+nd9Eu+FEE7lYpjd1hJFi
 oeFFt1xUKCNab3jj706ECc5zSS6l5z0sU3VAAQhKisTNayqBfafIgPi55leNmDbUzQA4BiMwilc
 D4Tzxu1g=
X-Gm-Gg: Acq92OHAL7/C3KXObqRrYVpO+HSd5H6Iu0ST2XIBrlPl4XjkrPIMHnzXKk/5TKXYK8y
 v78bO0qXaKn8xmnkvGYd7pYUf6TLDDJwYh7B+NJFICA4/pYbztrIYN13XHzSgZ0qenWOBdnSdHT
 o6YRzB4QNlCNDg1Q/OeVWuQEvZKr+V0Xb8x8hrLpbWK00vVKtAz/Gy1lz9w/PWke8aI+UBJi9VT
 HktlAEINJQ0CHp/lPnVTgXBpSjUDMXpqN7J6l6GqkaZ2kVxNjK+sWIGC7hBJ6CQaqT96hp4VsGd
 Ws+C+KFb69kBlFH42CII/+j7dyWsLZ9NL8F9xLI09Avzt3IJULcab/q6MK0N0MZtImNXOPQiYhM
 QEav+oSCHXjTSzgUu5HYFV1UTwQwfRz2CWGzrWCuodLZSBNRKYVET8h8CA3h8te51SkFopbybXo
 Fsm+QssvC+4tOb1DVOL58Y8sGG1lu0WuwQ3aOZMz3YNT2QaASwaLk1nLsO62/57f3EoYGMesw2
X-Received: by 2002:a05:600c:a417:b0:488:a882:c7 with SMTP id
 5b1f17b1804b1-48fe65168a7mr49249255e9.25.1778854323912; 
 Fri, 15 May 2026 07:12:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe81b2dsm14433155e9.34.2026.05.15.07.12.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 15 May 2026 07:12:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v6 12/20] target/arm: Extract common code related to 'max' CPU
Date: Fri, 15 May 2026 16:10:23 +0200
Message-ID: <20260515141032.3271-13-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260515141032.3271-1-philmd@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu-max.c   | 106 +++++++++++++++++++++++++++++++++++++++++
 target/arm/tcg/cpu32.c |  96 -------------------------------------
 target/arm/meson.build |   1 +
 3 files changed, 107 insertions(+), 96 deletions(-)
 create mode 100644 target/arm/cpu-max.c

diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
new file mode 100644
index 00000000000..9fd48ce46e2
--- /dev/null
+++ b/target/arm/cpu-max.c
@@ -0,0 +1,106 @@
+/*
+ * QEMU ARM 'max' CPU
+ *
+ * Copyright (c) 2018 Linaro Ltd
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "target/arm/internals.h"
+
+/* Share AArch32 -cpu max features with AArch64. */
+void aa32_max_features(ARMCPU *cpu)
+{
+    uint32_t t;
+    ARMISARegisters *isar = &cpu->isar;
+
+    /* Add additional features supported by QEMU */
+    t = GET_IDREG(isar, ID_ISAR5);
+    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
+    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
+    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
+    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
+    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
+    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
+    SET_IDREG(isar, ID_ISAR5, t);
+
+    t = GET_IDREG(isar, ID_ISAR6);
+    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
+    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
+    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
+    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
+    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
+    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
+    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
+    SET_IDREG(isar, ID_ISAR6, t);
+
+    t = cpu->isar.mvfr1;
+    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
+    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
+    cpu->isar.mvfr1 = t;
+
+    t = cpu->isar.mvfr2;
+    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
+    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
+    cpu->isar.mvfr2 = t;
+
+    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
+
+    t = GET_IDREG(isar, ID_MMFR4);
+    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
+    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
+    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
+    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
+    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
+    SET_IDREG(isar, ID_MMFR4, t);
+
+    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
+
+    t = GET_IDREG(isar, ID_PFR0);
+    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
+    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
+    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
+    SET_IDREG(isar, ID_PFR0, t);
+
+    t = GET_IDREG(isar, ID_PFR2);
+    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
+    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
+    SET_IDREG(isar, ID_PFR2, t);
+
+    t = GET_IDREG(isar, ID_DFR0);
+    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
+    SET_IDREG(isar, ID_DFR0, t);
+
+    /* Debug ID registers. */
+
+    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
+    t = 0x00008000;
+    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
+    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
+    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
+    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
+    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
+    cpu->isar.dbgdidr = t;
+
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
+    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
+    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
+    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
+    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
+    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
+    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
+    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
+    cpu->isar.dbgdevid = t;
+
+    /* Bits[31:4] are RES0. */
+    t = 0;
+    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
+    cpu->isar.dbgdevid1 = t;
+
+    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
+}
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 73d21c6cf7d..919ed8a6cf8 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -18,102 +18,6 @@
 #include "cpregs.h"
 
 
-/* Share AArch32 -cpu max features with AArch64. */
-void aa32_max_features(ARMCPU *cpu)
-{
-    uint32_t t;
-    ARMISARegisters *isar = &cpu->isar;
-
-    /* Add additional features supported by QEMU */
-    t = GET_IDREG(isar, ID_ISAR5);
-    t = FIELD_DP32(t, ID_ISAR5, AES, 2);          /* FEAT_PMULL */
-    t = FIELD_DP32(t, ID_ISAR5, SHA1, 1);         /* FEAT_SHA1 */
-    t = FIELD_DP32(t, ID_ISAR5, SHA2, 1);         /* FEAT_SHA256 */
-    t = FIELD_DP32(t, ID_ISAR5, CRC32, 1);
-    t = FIELD_DP32(t, ID_ISAR5, RDM, 1);          /* FEAT_RDM */
-    t = FIELD_DP32(t, ID_ISAR5, VCMA, 1);         /* FEAT_FCMA */
-    SET_IDREG(isar, ID_ISAR5, t);
-
-    t = GET_IDREG(isar, ID_ISAR6);
-    t = FIELD_DP32(t, ID_ISAR6, JSCVT, 1);        /* FEAT_JSCVT */
-    t = FIELD_DP32(t, ID_ISAR6, DP, 1);           /* Feat_DotProd */
-    t = FIELD_DP32(t, ID_ISAR6, FHM, 1);          /* FEAT_FHM */
-    t = FIELD_DP32(t, ID_ISAR6, SB, 1);           /* FEAT_SB */
-    t = FIELD_DP32(t, ID_ISAR6, SPECRES, 1);      /* FEAT_SPECRES */
-    t = FIELD_DP32(t, ID_ISAR6, BF16, 1);         /* FEAT_AA32BF16 */
-    t = FIELD_DP32(t, ID_ISAR6, I8MM, 1);         /* FEAT_AA32I8MM */
-    SET_IDREG(isar, ID_ISAR6, t);
-
-    t = cpu->isar.mvfr1;
-    t = FIELD_DP32(t, MVFR1, FPHP, 3);            /* FEAT_FP16 */
-    t = FIELD_DP32(t, MVFR1, SIMDHP, 2);          /* FEAT_FP16 */
-    cpu->isar.mvfr1 = t;
-
-    t = cpu->isar.mvfr2;
-    t = FIELD_DP32(t, MVFR2, SIMDMISC, 3);        /* SIMD MaxNum */
-    t = FIELD_DP32(t, MVFR2, FPMISC, 4);          /* FP MaxNum */
-    cpu->isar.mvfr2 = t;
-
-    FIELD_DP32_IDREG(isar, ID_MMFR3, PAN, 2);          /* FEAT_PAN2 */
-
-    t = GET_IDREG(isar, ID_MMFR4);
-    t = FIELD_DP32(t, ID_MMFR4, HPDS, 2);         /* FEAT_HPDS2 */
-    t = FIELD_DP32(t, ID_MMFR4, AC2, 1);          /* ACTLR2, HACTLR2 */
-    t = FIELD_DP32(t, ID_MMFR4, CNP, 1);          /* FEAT_TTCNP */
-    t = FIELD_DP32(t, ID_MMFR4, XNX, 1);          /* FEAT_XNX */
-    t = FIELD_DP32(t, ID_MMFR4, EVT, 2);          /* FEAT_EVT */
-    SET_IDREG(isar, ID_MMFR4, t);
-
-    FIELD_DP32_IDREG(isar, ID_MMFR5, ETS, 2);          /* FEAT_ETS2 */
-
-    t = GET_IDREG(isar, ID_PFR0);
-    t = FIELD_DP32(t, ID_PFR0, CSV2, 2);          /* FEAT_CSV2 */
-    t = FIELD_DP32(t, ID_PFR0, DIT, 1);           /* FEAT_DIT */
-    t = FIELD_DP32(t, ID_PFR0, RAS, 1);           /* FEAT_RAS */
-    SET_IDREG(isar, ID_PFR0, t);
-
-    t = GET_IDREG(isar, ID_PFR2);
-    t = FIELD_DP32(t, ID_PFR2, CSV3, 1);          /* FEAT_CSV3 */
-    t = FIELD_DP32(t, ID_PFR2, SSBS, 1);          /* FEAT_SSBS */
-    SET_IDREG(isar, ID_PFR2, t);
-
-    t = GET_IDREG(isar, ID_DFR0);
-    t = FIELD_DP32(t, ID_DFR0, COPDBG, 10);       /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, ID_DFR0, COPSDBG, 10);      /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, ID_DFR0, PERFMON, 6);       /* FEAT_PMUv3p5 */
-    SET_IDREG(isar, ID_DFR0, t);
-
-    /* Debug ID registers. */
-
-    /* Bit[15] is RES1, Bit[13] and Bits[11:0] are RES0. */
-    t = 0x00008000;
-    t = FIELD_DP32(t, DBGDIDR, SE_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, NSUHD_IMP, 1);
-    t = FIELD_DP32(t, DBGDIDR, VERSION, 10);      /* FEAT_Debugv8p8 */
-    t = FIELD_DP32(t, DBGDIDR, CTX_CMPS, 1);
-    t = FIELD_DP32(t, DBGDIDR, BRPS, 5);
-    t = FIELD_DP32(t, DBGDIDR, WRPS, 3);
-    cpu->isar.dbgdidr = t;
-
-    t = 0;
-    t = FIELD_DP32(t, DBGDEVID, PCSAMPLE, 3);
-    t = FIELD_DP32(t, DBGDEVID, WPADDRMASK, 1);
-    t = FIELD_DP32(t, DBGDEVID, BPADDRMASK, 15);
-    t = FIELD_DP32(t, DBGDEVID, VECTORCATCH, 0);
-    t = FIELD_DP32(t, DBGDEVID, VIRTEXTNS, 1);
-    t = FIELD_DP32(t, DBGDEVID, DOUBLELOCK, 1);
-    t = FIELD_DP32(t, DBGDEVID, AUXREGS, 0);
-    t = FIELD_DP32(t, DBGDEVID, CIDMASK, 0);
-    cpu->isar.dbgdevid = t;
-
-    /* Bits[31:4] are RES0. */
-    t = 0;
-    t = FIELD_DP32(t, DBGDEVID1, PCSROFFSET, 2);
-    cpu->isar.dbgdevid1 = t;
-
-    FIELD_DP32_IDREG(isar, ID_DFR1, HPMN0, 1);         /* FEAT_HPMN0 */
-}
-
 /* CPU models. These are not needed for the AArch64 linux-user build. */
 #if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
 
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 5376be2e3bc..3e02941d0d5 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -9,6 +9,7 @@ arm_user_ss = ss.source_set()
 arm_common_system_ss.add(files('gdbstub.c'))
 arm_user_ss.add(files('gdbstub.c'))
 
+arm_ss.add(files('cpu-max.c'))
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
 ))
-- 
2.53.0


