Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A022CD4F3D
	for <qemu-devel@archiver.kernel.org>; Sun, 17 May 2026 00:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOPPd-0007wY-KH; Sat, 16 May 2026 20:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOm-0007E2-4T
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:36 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wOPOh-00052S-Vn
 for qemu-devel@nongnu.org; Sat, 16 May 2026 20:30:27 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-c80203b9d7bso364692a12.0
 for <qemu-devel@nongnu.org>; Sat, 16 May 2026 17:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778977822; x=1779582622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ad95Qfvf39Y/pJtpBMnjf6EUI1HAMLBfD/Kn4uxVX0Y=;
 b=PAxshp5ZXqRV/ihf143B8zWEx89s5frHPIml1PH7YfDfqI5fd2n4lsf3wE1ejizUzD
 hruymdhNMBqeIpq2K2ynfki3WQ6g5x5K6SNDbUbzAI3u7Etev+ism+nU2BJtcK0GEOiW
 sYLUGpWbRLvzObMU/Plv53sHROUeduVbsx6fbA1tUNGNHH7we46QkyHptFh+EqTVJEtU
 IzWZywUTCAblA5BQi2dUN/dMUeuVCBB6Fl3lcsEgsi1Ref1kgXTku0A3qHYKF5lXYnC5
 Tb9VCq2H+74h29rpzzi7Sfbu6bwI44T2LZo90NXZ/MqT5fjKPg5VrWvmDDFUlGwr8wOx
 rUZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778977822; x=1779582622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ad95Qfvf39Y/pJtpBMnjf6EUI1HAMLBfD/Kn4uxVX0Y=;
 b=DcT1sQILk5ixD9JMQp/nj4xARpJCSB7Zrlr6EqYecgzJKLngXgjU3hps6AimcaxRz1
 TBUBzpsmHuYta78u+3EYZlzZi5mIFTcAK+FDADdjuuPh5KYejz4ZawRU0zCID1m9RygR
 stU4TI1hvb7she2GXdsJvGJjf6uBp7pQb6/WxweFsFR/daKR+2siLFcKcR/MC0jhHzdG
 L6r/fHdrRnlGUnkZkYZ1vOZ8okCYuvhhEeDBp4iSPj5V9/6LImtGgN+bxTXofTR0L2fA
 f2TUpARhv0SMFWVGo6Y8Y1yfFbHr4sS5MotpGtRjyyShCFE2Env/T8vF4zNlWZyxo1bY
 IjoQ==
X-Gm-Message-State: AOJu0YxWHzrIRuNdudG0k9TUQO3oCnVvajR3ceqQrIopuUeNodYQy8oG
 cNvfScuIF0eRFSybdQPUpJD4qZkgAni3qO/l7nhlS30J+zZJIOEMxRE2nwId9pzXpUTt45+c2LU
 S+1qb
X-Gm-Gg: Acq92OEsaBS9KNx1CP1liGjKXpWg8TcD+wZTgI6r7xkdYsHcPOvt4K0SPFFD6oEPX/+
 VQwEdH01AxBeNn0Gm+yLr9qpOaAInIthZiAMqECG3kSwpYnYrJfUhnxHVV2MuhJT5MIT7aZVms8
 PIoxcs3NqVchIbJHfg/eG7X3MjaK/VN9AfL5dNTCLaGNkpmDp/NnUuvp5gdBH4Y+4D+a6NbZBlS
 xpq3zqFaz9sdNQ3qx+tAdhcb08GoKQHftmS8mC+uyLKn9UBVu36sbJQ6533nFpqSyLdwrZ7f6T8
 nwKBLNfnSrpsVnnKKDGf+EZq1o4OPnAqMfTYPrxYApJtOte9SJBFAF8SEXHMPsGR8V2XVhEke8Z
 PfE5rzOntCecS/tFDMukSMs3x1+lAju+kJkvQcGUlpEyfRRW1kTfI6DJzGA0WUDWhAy9946TFhP
 5ZTjm46zllDYUVW5aW84SDgS68XPAPm1bYY182MiE=
X-Received: by 2002:a05:6a00:429b:b0:82f:d34c:ccc6 with SMTP id
 d2e1a72fcca58-83f33ab6689mr10007366b3a.10.1778977821914; 
 Sat, 16 May 2026 17:30:21 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19663cfdsm12272745b3a.9.2026.05.16.17.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 17:30:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 21/63] target/arm: Split vector-type.h from cpu.h
Date: Sat, 16 May 2026 17:29:20 -0700
Message-ID: <20260517003002.321430-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517003002.321430-1-richard.henderson@linaro.org>
References: <20260517003002.321430-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x533.google.com
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

We want to be able to reference ARMVectorType etc from
common code, so move it out of cpu.h.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h         | 38 +---------------------------------
 target/arm/vector-type.h | 44 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 37 deletions(-)
 create mode 100644 target/arm/vector-type.h

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 9e637c1d80..9f5da3d863 100644
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


