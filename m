Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 419F5C44527
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:03:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlkqF-0005m5-G0; Mon, 20 Jul 2026 06:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlkqE-0005lr-H6
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:03:18 -0400
Received: from mail-wm2-x09.google.com ([2a00:1450:4864:31::9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wlkqC-0004XI-R9
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 06:03:18 -0400
Received: by mail-wm2-x09.google.com with SMTP id
 5b1f17b1804b1-4955674321eso1491025e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 03:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784541794; x=1785146594; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UCzsbxOA1DD/yR4hu7ljFp5A6eMHwLpWpqbtz4UzRC8=;
 b=z8DMlnQw1C7azClelLEgrD5WFE42AKaVtxHD9YVnmvArzkBIQsyA2ABN8NT3IbvB92
 xvUR++okPPGCf1lZypIsEqv4uLFVVWeqJxvmvLqESA21trMZUpnoRm4vzKKoI3q0Cwir
 9SHxefru3plCzXig3cPeeNbLy1qpbXM0lfc4AoqptxNAvWktNEJz9zzcimNWk//00VE6
 /gWgWbe1Fyixcj2ciT+gJ3g3DdwhHw1F17yBLfOmXIdMtUOH3yttzbKS1Wm96l5CIwOZ
 fLVqMx/UcJMSwBVQGZIXaE27sFALYmPtCbhfJG7J5yogshfBggBoBTycw5Rf+6ubmrpg
 Z9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784541794; x=1785146594;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UCzsbxOA1DD/yR4hu7ljFp5A6eMHwLpWpqbtz4UzRC8=;
 b=ULBpt8sAiFZtLmTs0YAs1/gQV0bSWB4TzPiifr6WVV5pstZdXIr4L1J77GymLnAsA8
 wNrLlTmtRfjPTgeluTO8eqzvdbFiwzQhUrBRg3YHN0lQdsErOLwokyhwMzIGVXa65njz
 cD5dVidCphkf6fcreLrmu7/2i6GaCw530AsUvGPjQyS9X1lK4d/UtW6u78jbJkw3Dtcv
 4hOZ786SwBdD4zw9b5mQbJGVqGwBt4JzoNePSlY94mqhsp5TroLq4GkexXeDMf7Fp9kM
 82rsNmIoqSIi6dfAzObVzSXNjmGpA0b+iCd/R8xhRzBkmEHkcCy2nTmF1gkMrHCEujW+
 86Zw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrDeMu+uW7iy/DGIRo0Xg/R/AjD9q8bvPyfCU7SKRJ9j/IIewP2fci+x7aY7v3HoygGeNzRhNHCWHNI@nongnu.org
X-Gm-Message-State: AOJu0YxqaVtW86KYtaPGJ2bjKRMYqOBpn7EBJ6n3BIgpowVQZ07YW7T1
 H4LoM40PQ0b2RO3NclIlQhPfYVyfpTrhAeBkuChsba3hfH4LaxMtWIXEDybDX6R5WUY=
X-Gm-Gg: AfdE7cl7v4c8RLcc8styOmnwvBeaX1YLicjTFD0xSRkI1WEVdQfGg67fmUIQiJ5UChI
 v5O1ivsMdjzbEF3hKvw327DLWwiDh2OG/Jwh9B7BgOMvahQ0aambO58a4Bg6pZi3QGxgoilIAnB
 kUYeHTldEohFwNApKnE9pCpaAbmu6hzBTk+Gt0gfGq6ZdmdeozcSGGFP1Pp7RN2WkMNRiK+Rr4J
 lfqolHXeBHMCLsFoj5VcWCwNyCf96FYb0C8OrkuL0ghicVLX6/P+0Y/SNuIGVSSXfAbwQwAFe2r
 0M83eXy4axEqkILlvugWcPAGaND90IRUr/w2AiHhq4NQebaFBGenVqkF/SnlMFYy2j/BuWiuiNb
 zgPJwBUgvKlwHynDznNyTXePRYD7DCGjEMJmyET2Z0XDz2Mb3qq5ZQR1yzJYgp06KGXRK7oLk+T
 ZLujevlTB54k+bpT/AdmXOzAyKHObnQkySW9VUthmfJ3N70AbzwjuTNUxalrMW3gmVecRwDvgWJ
 rFOWFVoWTU=
X-Received: by 2002:a05:600c:4515:b0:495:4689:7147 with SMTP id
 5b1f17b1804b1-4954a3f4a34mr175948505e9.12.1784541794352; 
 Mon, 20 Jul 2026 03:03:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49549a3f07esm260421945e9.6.2026.07.20.03.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 03:03:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH] Revert "target/arm: Build cpu32-system.o as common object"
Date: Mon, 20 Jul 2026 11:03:12 +0100
Message-ID: <20260720100312.119894-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::9;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x09.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

In c8bea1276c we moved cpu32.c and built it as a common object.  The
commit message says "cpu32.c only contains CPU types used in 32-bit
system emulation".  However, this is incorrect -- it contains 32-bit
CPU types used in both system and usermode emulation.  (The case
where we don't need these CPUs and which we were using ifdefs to
avoid is specifically the AArch64 usermode qemu-aarch64 binary.)

The effect is that qemu-arm lost all the named CPU types except
the M-profile ones (which are in cpu-v7m.c).

This reverts commit c8bea1276c85855b2e088b740737d043c8556d58.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3962
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
The commit reverts cleanly, and looking at the git history
I don't think we have anything that depends on it, so a simple
revert seems best to me, especially given that cpu32-system.c
doesn't reflect the fact that we do need these CPUs in
usermode too.
---
 target/arm/tcg/{cpu32-system.c => cpu32.c} | 10 +++++++++-
 target/arm/tcg/meson.build                 |  5 ++++-
 2 files changed, 13 insertions(+), 2 deletions(-)
 rename target/arm/tcg/{cpu32-system.c => cpu32.c} (99%)

diff --git a/target/arm/tcg/cpu32-system.c b/target/arm/tcg/cpu32.c
similarity index 99%
rename from target/arm/tcg/cpu32-system.c
rename to target/arm/tcg/cpu32.c
index 6e983900899..8220d785f5b 100644
--- a/target/arm/tcg/cpu32-system.c
+++ b/target/arm/tcg/cpu32.c
@@ -1,5 +1,5 @@
 /*
- * QEMU ARM TCG-only CPUs (not needed for the AArch64 linux-user build)
+ * QEMU ARM TCG-only CPUs.
  *
  * Copyright (c) 2012 SUSE LINUX Products GmbH
  *
@@ -13,9 +13,15 @@
 #include "cpu.h"
 #include "accel/tcg/cpu-ops.h"
 #include "internals.h"
+#if !defined(CONFIG_USER_ONLY)
 #include "hw/core/boards.h"
+#endif
 #include "cpregs.h"
 
+
+/* CPU models. These are not needed for the AArch64 linux-user build. */
+#if !defined(CONFIG_USER_ONLY) || !defined(TARGET_AARCH64)
+
 static void arm926_initfn(Object *obj)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -740,3 +746,5 @@ static void arm_tcg_cpu_register_types(void)
 }
 
 type_init(arm_tcg_cpu_register_types)
+
+#endif /* !CONFIG_USER_ONLY || !TARGET_AARCH64 */
diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 573e8b5af48..227e674ae2f 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -30,6 +30,10 @@ translate32_d = [
 arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 arm_stubs_ss.add(files('stubs32.c'))
 
+arm_ss.add(files(
+  'cpu32.c',
+))
+
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'gengvec64.c',
   'translate-a64.c',
@@ -82,7 +86,6 @@ arm_common_user_system_ss.add(when: 'TARGET_AARCH64', if_true: files(
 
 arm_common_system_ss.add(files(
   'cpregs-at.c',
-  'cpu32-system.c',
   'gicv5-cpuif.c',
   'psci.c',
   'tlb_helper.c',
-- 
2.43.0


