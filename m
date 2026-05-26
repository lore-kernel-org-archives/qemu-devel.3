Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAF20CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsoW-0003ca-9I; Tue, 26 May 2026 10:31:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmw-0001c3-Kq
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:46 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmu-0001VT-Rb
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:46 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so4722330f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805783; x=1780410583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i/q2wfhAByWiYzfnLkFT+2vC1TzNOMSgQe7MpYCYhW0=;
 b=c4+LS7vnKAxvYQDLGa0GdFUfHXXc1JDx++3GxgTvATpcjaPSEwPiDLiEdIsosMgupR
 culQpn8QQvFd4OEOUumbfraUX5DatpRu9fONwKz1GEWGtKeeQYZBwaTO8ZTqgaQPhup/
 immcPN5JY3DBoKsgj9Gcz1+zqyZj1WoJHYJtDvGw0tg9134kjo1kInFLH7Ylv0q0/gEG
 BSz4MnHPYrqtUtt/T0fLb5rQ4Mhl3hHiYqjHma+dY3zrsHQNzsqpqRn3aErb1I2GCfjA
 Fo4ZqKYpHEi5yfZ3T2DKfyn2r43vWHKPlWBZZYsbCYc226/Uuj/hxBfZCrDGCXcMK/RC
 Fe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805783; x=1780410583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i/q2wfhAByWiYzfnLkFT+2vC1TzNOMSgQe7MpYCYhW0=;
 b=Nrhhc6AnTGQz5nIjjRD5e/cCGh8NsSAoecm8aJq72bPsrx/g7v5A3/d0qd302GtyRm
 dIylLlFJTOrLjRcK0NCx2+w9LJQbefVOQURi/zJwBaYVy1KPsTxstknMRHycIqVYYTFR
 +3/N3sKCTeBajmF/MhBWctiXpX7oChvyV8EosR/tEO5wjrTOPsBMweNC5ayGYMMdirkg
 CttKWsZ/ILTNg/2tOjW/UvkOgb8XYasw4tzVOF5JC6j7dslj57iRSmymEq1Z6h9IR6oM
 5BLC2G/EA2eymb7BorqE0eAuAGYAZm+Qz9tiOh/qtM6arAPn16mfDsvthwUSEj1X/NmJ
 +LUQ==
X-Gm-Message-State: AOJu0YwpSxSh4NM3BguuIx2f6kf1PlvJRXhc9/IRAmcp9Oa3bxMEThke
 UkgnBC8YykKClkIbF9PP/QmvVsaKpvC/rASCQUrXSKH+41E+I9MhQpOJc1lRwa67lM3wtiRA21T
 l0f+V
X-Gm-Gg: Acq92OFbt8SNdL2sxOQrmecIKSdr2QnB8fzOEcrs/K79oZwOytCAHY+iVDm4am0VkCj
 n3yndyWe/BsYZ8RGPuOFVAxrESCwK/CiXDIgr/5PVlL6rhIugpgIxE67PaYYtG+gdGLPbQrHfzu
 qE0Yq+169AY1SelRDcwFQeZSUUQEupQ79bKHYqbwl1ME1HMqAEOAj8JbDd4Cd+FhjcabYBTM1xf
 hVueUKdThgGkvh309I67pUCnRrst3PyXECs8s9ShDT3dCHNQWs02Qj/W4OvvsM6UVDkKXxeVbGh
 E8aFv2tyPxSXFaVGQyQ2DxxSpyRgEh3PriFMH/E25GzRQJJzG/2F7Kb2V5xlcESOWl5jqql6qwM
 2r61wYTbCiBMjywfMv/Cik1bkRGx686JuSYir7fDCqlIWaktR8qPPJpG7EsuSMCvydlJW8Sm+y7
 AyKTGmKFKY7ChmKVYSVe3LOGKgOEN8Q586NpRy0FWj3ghyM2uo2nq1Cx29IK/nM1TMC00hMBEd2
 tpFEqTyJjHAMG2UYevB8bBpYWM92gd7tniMq7lxqg==
X-Received: by 2002:a5d:64c2:0:b0:44b:5398:4e85 with SMTP id
 ffacd0b85a97d-45eb38afb20mr30851967f8f.22.1779805783385; 
 Tue, 26 May 2026 07:29:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 53/54] target/arm: Split vector-type.h from cpu.h
Date: Tue, 26 May 2026 15:28:49 +0100
Message-ID: <20260526142850.2326589-54-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

We want to be able to reference ARMVectorType etc from
common code, so move it out of cpu.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260522220306.235200-23-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h         | 38 +---------------------------------
 target/arm/vector-type.h | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 target/arm/vector-type.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 2a93de4132..85552b573c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -35,6 +35,7 @@
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
 #include "hw/intc/arm_gicv5_types.h"
+#include "target/arm/vector-type.h"
 
 #define EXCP_UDEF            1   /* undefined instruction */
 #define EXCP_SWI             2   /* software interrupt */
@@ -140,43 +141,6 @@ typedef struct ARMGenericTimer {
     uint64_t ctl; /* Timer Control register */
 } ARMGenericTimer;
 
-/* Define a maximum sized vector register.
- * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
- * For 64-bit, this is a 2048-bit SVE register.
- *
- * Note that the mapping between S, D, and Q views of the register bank
- * differs between AArch64 and AArch32.
- * In AArch32:
- *  Qn = regs[n].d[1]:regs[n].d[0]
- *  Dn = regs[n / 2].d[n & 1]
- *  Sn = regs[n / 4].d[n % 4 / 2],
- *       bits 31..0 for even n, and bits 63..32 for odd n
- *       (and regs[16] to regs[31] are inaccessible)
- * In AArch64:
- *  Zn = regs[n].d[*]
- *  Qn = regs[n].d[1]:regs[n].d[0]
- *  Dn = regs[n].d[0]
- *  Sn = regs[n].d[0] bits 31..0
- *  Hn = regs[n].d[0] bits 15..0
- *
- * This corresponds to the architecturally defined mapping between
- * the two execution states, and means we do not need to explicitly
- * map these registers when changing states.
- *
- * Align the data for use with TCG host vector operations.
- */
-
-#define ARM_MAX_VQ    16
-
-typedef struct ARMVectorReg {
-    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
-} ARMVectorReg;
-
-/* In AArch32 mode, predicate registers do not exist at all.  */
-typedef struct ARMPredicateReg {
-    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
-} ARMPredicateReg;
-
 /* In AArch32 mode, PAC keys do not exist at all.  */
 typedef struct ARMPACKey {
     uint64_t lo, hi;
diff --git a/target/arm/vector-type.h b/target/arm/vector-type.h
new file mode 100644
index 0000000000..d94c0d986e
--- /dev/null
+++ b/target/arm/vector-type.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef TARGET_ARM_VECTOR_TYPE_H
+#define TARGET_ARM_VECTOR_TYPE_H
+
+/*
+ * Define a maximum sized vector register.
+ * For 32-bit, this is a 128-bit NEON/AdvSIMD register.
+ * For 64-bit, this is a 2048-bit SVE register.
+ *
+ * Note that the mapping between S, D, and Q views of the register bank
+ * differs between AArch64 and AArch32.
+ * In AArch32:
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n / 2].d[n & 1]
+ *  Sn = regs[n / 4].d[n % 4 / 2],
+ *       bits 31..0 for even n, and bits 63..32 for odd n
+ *       (and regs[16] to regs[31] are inaccessible)
+ * In AArch64:
+ *  Zn = regs[n].d[*]
+ *  Qn = regs[n].d[1]:regs[n].d[0]
+ *  Dn = regs[n].d[0]
+ *  Sn = regs[n].d[0] bits 31..0
+ *  Hn = regs[n].d[0] bits 15..0
+ *
+ * This corresponds to the architecturally defined mapping between
+ * the two execution states, and means we do not need to explicitly
+ * map these registers when changing states.
+ *
+ * Align the data for use with TCG host vector operations.
+ */
+
+#define ARM_MAX_VQ    16
+
+typedef struct ARMVectorReg {
+    uint64_t d[2 * ARM_MAX_VQ] QEMU_ALIGNED(16);
+} ARMVectorReg;
+
+/* In AArch32 mode, predicate registers do not exist at all.  */
+typedef struct ARMPredicateReg {
+    uint64_t p[DIV_ROUND_UP(2 * ARM_MAX_VQ, 8)] QEMU_ALIGNED(16);
+} ARMPredicateReg;
+
+#endif
-- 
2.43.0


