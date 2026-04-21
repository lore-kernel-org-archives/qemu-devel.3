Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF79EA7184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 05:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wF3SB-0008Tt-4f; Tue, 21 Apr 2026 01:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rg-00084q-Mx
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:52 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wF3Rc-0006ZI-Jk
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 01:14:47 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so2530294a91.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776748482; x=1777353282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Ct+14ngv5gKl9pMW8z2QX17zhRqbcV0PCtNvY/bX4E=;
 b=BS5UFjQ+HrtH/SqSqEyYrai4a++46FIYvat/VA2JRt2ftKroGRahhcHyIWnk9lrEnQ
 Rq9TUcqjpBU2S8++H+etRPKfQQWq2jnuJ4LuX86a8x8WBXX1StYjQjwTMTYxTVQgU867
 nVuVsBQ1QGgXARgMo5MwVArVy9QFSi0nDw0cvNqJr2miXpIiy6qhDiNuD0AENXBCH7G5
 z1pWOgsuWUISMfRiB4+mT6vmp1P5q05MvVklbMdEpCBQFNUXMpNm/gOJVTG2nSaVljuW
 FbWKCbtmySe2MtPzj4syVKlOkiG7munVCaZFijkzkehKt+jx7lc67N/28GL9nN9J2tM4
 iHhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776748482; x=1777353282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Ct+14ngv5gKl9pMW8z2QX17zhRqbcV0PCtNvY/bX4E=;
 b=KYhZ7KM6y48U8g2ltvmQleuc8ty4VbOBXp1FtUG3V4tbpvEWRRi/mEj0qeRjmvcJYk
 tVmSxxt3gdizkp7ChImLxQ7ysI+Or13Hypplh/fS4lIqMOXwuAm6a2BtJaAg2QLQkmSK
 M4jySczpQD9mGUxCKn+qY6B0EcAEdLnCDJb/qd+dUXnY9gUNTNx6/75TWKjHD92kTZMj
 2hu9viDchMbOM8hZc+admV/dhwiRamUv6139fk2KUfDT7MWuyOMIoRkQyz0bxHTXM7Ah
 9JudeQ7X77PnryDUbgaqtXnFeQjZm1Qfof25l/lYDMzVm8DETav9Z8aTTUvOsDYnkNjt
 uU1w==
X-Gm-Message-State: AOJu0Yyw1NjVC4yVoMPtyILTIwgVhJV1x60zydeZ/SzCxb/zYg2/UiOW
 8d4BpgfD5YwKN8ZvQTPSDLnx6R4N8l57MV3kqm1xmDQMADXJslcHmbOZVZadjx9rssu8TD3RtYL
 hcNUUTYY=
X-Gm-Gg: AeBDiev0gtpB7YTxvNLNOEYa2ntAmjJUMFB/3dNFWl/jVJn6l7UOAbkxzQt+VCD5wJP
 h6+brksq85GbAAXpYL4+MP8taTqmFIXaBVREIqCLMOJGzqsdeXNaLTrb85cdPoTfHcStVFKitje
 /KJGQirvjYe4B5l3SsyU1D4vcrWQYbI7my29GMAF3e0g7wTiDfgdBblnpUk6QrFY+nrDFWwOafd
 ElR059+n1ShXTbhvHTKqYntQ7hqDXRpUs1yzWViPfxoJ5A2fI3NXcNuYpeqGZAZ/CgVHuXaHJZo
 ieFJ7l8Ji2BzUT7BzKDklzDEpymtUQBWrFiNK3nuagcHD95+1RDDbn66bo0gjwCIZyjb2/9ynTG
 1OcvMH0G5EcPc//q5viA9KleNcIFT3ifyZBtboYV9MGa8CSEzwLQ/DIGZOEn2YgtBzXysImVwqA
 aG+TATnavrAtmaZjXZkkmBzn5Yyxf1uHH3EvePO2x5
X-Received: by 2002:a17:90b:5845:b0:35f:c46f:2b0 with SMTP id
 98e67ed59e1d1-36140473f70mr16759989a91.14.1776748481742; 
 Mon, 20 Apr 2026 22:14:41 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab0cddfsm174631715ad.49.2026.04.20.22.14.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 22:14:41 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 21/37] target/arm: Split vector-type.h from cpu.h
Date: Tue, 21 Apr 2026 15:13:30 +1000
Message-ID: <20260421051346.41106-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421051346.41106-1-richard.henderson@linaro.org>
References: <20260421051346.41106-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

We want to be able to reference ARMVectorType etc from
common code, so move it out of cpu.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h         | 38 +---------------------------------
 target/arm/vector-type.h | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 target/arm/vector-type.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e78bc1737d..c0c13d37b9 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -35,6 +35,7 @@
 #include "target/arm/gtimer.h"
 #include "target/arm/cpu-sysregs.h"
 #include "target/arm/mmuidx.h"
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


