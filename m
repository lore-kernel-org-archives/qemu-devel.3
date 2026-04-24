Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17094FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8Cs-0000HN-9T; Fri, 24 Apr 2026 00:31:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Co-0008QI-Ey
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:54 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8Cm-00036n-Bz
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:31:54 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-42fe552aedeso528659fac.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005111; x=1777609911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=24k+WndXoiq0k6mJkQd6Ra7B0sSV6OLr1icDt0ng834=;
 b=kU7sPBwodQMFdtmJRcBilF9YkaV306Q+DDBoRU/t8WfgdYHOzfoohqjavXO4bMb+Ud
 dj1zAnuU28DsW5yYx9/UH/1JBL28sUzFu7v+rHJNEBzyqFFCRFkogEc2yh9cfbKedexY
 fd5I/ODAopzmbHFEAeA870axtJRidUB8ZKbfdRmHP7bZoXLfedbu84q+iO4c0fSKrHd5
 XBEQNaTNsZR6nN7oH6KBKU1ooHAvdMBiHYBnnSxtRLIS+lAaV5AmOo5Nz9ERUT5LUv3n
 6gYmJwiV7zBi/AqKxmhkrxDr3/IlxCrLbbXP7EZifNl92PmCBWQny0qHC4ud3D7tUlTJ
 WNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005111; x=1777609911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=24k+WndXoiq0k6mJkQd6Ra7B0sSV6OLr1icDt0ng834=;
 b=KdJVjeA533gGzXgK3IjFNPVBTUYy3v31Op7r30nwGUvaQoIJnoKGUH1eL7C/wfoOnM
 Zqi0vs+z+BMWI9wimj9XBWaYyokeNFhyjkrpGiEhhJ09SBv5P3wLuDAB1IiSL8kb5QWC
 4pyYjnnK8UUv7qhWZ23pdTaXc4Gz+qat5DtRWnSv80vFRgY19XUzUp6PuwxSaeG40s+v
 Gv2qrHq1O9B7B8hbrxqliP5Ejc1P7NIvdQacSotCQq+YSpYh9To6/Q/jhymNAf19icsM
 L08aTLP8WjmP2WY8O2u71HNfuyJEv3mRz4TRH6rm/hDyJfSx+ezcsU4WBjWH12QgqkV+
 +zTA==
X-Gm-Message-State: AOJu0YwtXZyh9yd8Kj4uTH6g/F6KSY4YQMBuKE/kjZLvIFWYOvpdXEoP
 pKbQriWz66I5BPBakBp6zkkk/Hqe3Eox+ocOMz7fF/StjZAeaElGxcvYVPKM+68eVtfG5QH85WL
 0AtsyANU=
X-Gm-Gg: AeBDiesIn9/I2h+eYi8nyk0NOKe8+COAIS9gVQn8SwKl5UgwgkwifwwXpJi4PUJ1KOE
 5AV1nSDGjSltZDFgzIsC1YLzsMudGVVwYtpm71xRzxgw4dgbyEIaXmvG9XbafXcLX/33YsjKXgd
 ZDy3w93vTSrARmEawQLl0caNirhGMo8MOxzG31Q5pW5BY1UBstvvIHYC61aui1bZcWFha96v5uh
 KVUfXMoyG74c2HhvUk0l4pcn5wmwm9Je0zIMdPv/KfsaUpSK4adkAgC7r2VTzmuRNylXluxTjD+
 dU6fSuFVA/1WLjBC6k+SR06lrqDNuM+8r3lGTjTK4whJDeMBU8z6Wq6om0K8+vHFr1qsuc9eT9a
 pMaqVw6O+4odlJdQarav1gEpEGxGf0FA7lTE3okuxGCUyN6YkQqNfIBzdv4uEzt47eW+NYN0kr7
 OYBQtLEnlG79lcJJosLB39hOe678eEvYTqCGtNvrau9HsAwHZ66z0lPBuYX7TucmtHV70K0ts3
X-Received: by 2002:a05:6870:304a:b0:42d:c200:4204 with SMTP id
 586e51a60fabf-42dc2007ab8mr8791166fac.18.1777005110929; 
 Thu, 23 Apr 2026 21:31:50 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.31.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:31:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 21/40] target/arm: Split vector-type.h from cpu.h
Date: Fri, 24 Apr 2026 14:29:55 +1000
Message-ID: <20260424043014.46305-22-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2a.google.com
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


