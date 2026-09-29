Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 603D8CA5FAD
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:04:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBUfD-0007Wc-W5; Tue, 29 Sep 2026 06:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUfA-0007SD-S8
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:17 -0400
Received: from mail-ej2-x0d.google.com ([2a00:1450:4864:34::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBUf8-0008Dm-Ph
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 06:02:16 -0400
Received: by mail-ej2-x0d.google.com with SMTP id
 a640c23a62f3a-c2e01f5c0aeso4402266b.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 03:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790676133; x=1791280933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=spYIh9pyhVcO6HeigayUWPJWrRXyKwBCckHqXhigO8Y=;
 b=uxRM5dzfWPN1xs8t9qjTDvVpF33oaaXQ4hXGjgvo54R0Ct/cpesHn8W39QMAILIfsL
 x/eDmnErRb6IPcK7egU/l/FOvCipVGlginkyUSfcTUAL6RMaqaaim+/Dfzg75fYlRhRq
 Mxhymmtw/g4dzJa+An1c/GrS5mXe95hEhUXRMaVEgfIwGd10EUFRvoKgO3NZlrrZ0Pu1
 LWJ9+339NksnEA6h9NIieegJ+t1b8yS1ZMu9asfpidYOqXgzQQajjNg3HYHRM2Y6yQXl
 k5uycyN7I7URFAlLtapeIp4+2jtbVl1GRW6GHRr8AH1gUEW100+m2mz3/bodCxQf5BSV
 8icA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790676133; x=1791280933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=spYIh9pyhVcO6HeigayUWPJWrRXyKwBCckHqXhigO8Y=;
 b=rU2FQhQeQ9B/71f0ogUXFcT2vvLzYhxtXz4h5bjCeyIGqtmHb6Mcp3KN0R1hJojzs4
 zUpFSyqkcuZExjDrP4SdtA85mlCvn4Lp0k6ACLyAyLzNwyfDYcLFv1u+rqi36FF4nIFj
 2v8/G3ow5TG2tUO6VbfQlNAj/piBz6hWQC3eWN6oOu236ytIlGV5+GBRZxb4KywccNs+
 SIBO3G7NSTP+g6/r8pKdYvOzRBzEY5CMGTGQkA8DXvqeyziTa/MBW17lEfEHQYGKSQAA
 f36F7g54Ux5H4t4A3K1mhMZ6+OPbacpncdYnw8gsZSpUOf5KZtBuzKguDZnMGmbsnWv8
 GvKA==
X-Gm-Message-State: AFuF++kWMeiAzxwz3aA8hi+aESzqddmJflJiOYVib4TZu9zXuFpkHnIX
 aESZDFduIvyjR82jfa52+IEV+iomVUiP6W9gyq5XPZQhGbX7IxldkCpfYi2MOyKeiKF+Bgz2Mv8
 eJ3Do
X-Gm-Gg: AYBFou3q0xzuhT/es+RN1sdpKUs9uLnEwwoSrCzPZY+QoNTCoQVDp8FQHojf40v3wbx
 fadmxXwQV0JZqnkIeD4f7EGM1nMdBlBuizdH1K5wJxOTbRDglTZvXIB4XxlVvSRo/ZCA1gjGig+
 /3D9PRhQ2jHVVprpU0v+gecVINUq3ZxrcD9HL9DT+z4u5HJJKM2Y+GVCpb9yRfZkWzvTNe+DDMU
 ABpvsobk3EkZsQU2iws58qmve41JnGUxJCs704c5YdtNnvHsAEKuCpTWdXWaTzQHh72OV5R/nj2
 SlD0T8mSw3/loVvGO7k/VKTGfsvlpnMUyvrSjrpAbGkijgyTh/XyBrLpd2lAi4PkP0I/yEfHptN
 fF7m9SF0YywQhgUdsR1Obixj3RVUcI6qhS8YzrvqXXPdFtjjsVaSGBZ6TQcFYRfzFJK98zcRC+p
 xjCytvZTlYrQWteTPPhi34WlFQaUiU5ChHPiAuNhJxnglkESxCp6Gf+X1p0BD0fUAVxfnjtSBY/
 QS3eAsRLD0JiyTy9Bl1DLI53yNTHsAToNU1RWnISdnE6plJQR8Pkjj2EBC/GBMDhaEMXXCqB/MI
 mas=
X-Received: by 2002:a17:907:da6:b0:c2d:ca8d:435a with SMTP id
 a640c23a62f3a-c2dca8d5492mr485697066b.38.1790676132615; 
 Tue, 29 Sep 2026 03:02:12 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af4f88b37sm3091412f8f.5.2026.09.29.03.02.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 03:02:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/37] target/arm: Reorg rebuild_hflags_common*
Date: Tue, 29 Sep 2026 11:01:18 +0100
Message-ID: <20260929100133.2598676-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929100133.2598676-1-peter.maydell@linaro.org>
References: <20260929100133.2598676-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej2-x0d.google.com
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

Invert the call ordering of rebuild_hflags_common_32 and
rebuild_hflags_common vs the rest of the flags setting.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260925215004.456336-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/hflags.c | 44 +++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/target/arm/tcg/hflags.c b/target/arm/tcg/hflags.c
index c7739fc61b2..eb1aff91d5f 100644
--- a/target/arm/tcg/hflags.c
+++ b/target/arm/tcg/hflags.c
@@ -87,9 +87,10 @@ bool access_secure_reg(CPUARMState *env)
 }
 
 static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
-                                           ARMMMUIdx mmu_idx,
-                                           CPUARMTBFlags flags)
+                                           ARMMMUIdx mmu_idx)
 {
+    CPUARMTBFlags flags = {};
+
     DP_TBFLAG_ANY(flags, FPEXC_EL, fp_el);
     DP_TBFLAG_ANY(flags, MMUIDX, arm_to_core_mmu_idx(mmu_idx));
 
@@ -100,28 +101,27 @@ static CPUARMTBFlags rebuild_hflags_common(CPUARMState *env, int fp_el,
     return flags;
 }
 
-static CPUARMTBFlags rebuild_hflags_common_32(CPUARMState *env, int fp_el,
-                                              ARMMMUIdx mmu_idx,
-                                              CPUARMTBFlags flags)
+static void rebuild_hflags_common_32(CPUARMTBFlags *flags, CPUARMState *env)
 {
     bool sctlr_b = arm_sctlr_b(env);
 
     if (sctlr_b) {
-        DP_TBFLAG_A32(flags, SCTLR__B, 1);
+        DP_TBFLAG_A32(*flags, SCTLR__B, 1);
     }
     if (arm_cpu_data_is_big_endian_a32(env, sctlr_b)) {
-        DP_TBFLAG_ANY(flags, BE_DATA, 1);
+        DP_TBFLAG_ANY(*flags, BE_DATA, 1);
     }
-    DP_TBFLAG_A32(flags, NS, !access_secure_reg(env));
-
-    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+    DP_TBFLAG_A32(*flags, NS, !access_secure_reg(env));
 }
 
 static CPUARMTBFlags rebuild_hflags_m32(CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
-    CPUARMTBFlags flags = {};
-    uint32_t ccr = env->v7m.ccr[env->v7m.secure];
+    CPUARMTBFlags flags = rebuild_hflags_common(env, fp_el, mmu_idx);
+    uint32_t ccr;
+
+    rebuild_hflags_common_32(&flags, env);
+    ccr = env->v7m.ccr[env->v7m.secure];
 
     /* Without HaveMainExt, CCR.UNALIGN_TRP is RES1. */
     if (ccr & R_V7M_CCR_UNALIGN_TRP_MASK) {
@@ -146,8 +146,7 @@ static CPUARMTBFlags rebuild_hflags_m32(CPUARMState *env, int fp_el,
     if (arm_feature(env, ARM_FEATURE_M_SECURITY) && env->v7m.secure) {
         DP_TBFLAG_M32(flags, SECURE, 1);
     }
-
-    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
+    return flags;
 }
 
 /* This corresponds to the ARM pseudocode function IsFullA64Enabled(). */
@@ -277,10 +276,14 @@ static bool arm_d32dis(CPUARMState *env, int cur_el)
 static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
-    CPUARMTBFlags flags = {};
-    int el = arm_current_el(env);
-    uint64_t sctlr = arm_sctlr(env, el);
+    CPUARMTBFlags flags = rebuild_hflags_common(env, fp_el, mmu_idx);
+    int el;
+    uint64_t sctlr;
 
+    rebuild_hflags_common_32(&flags, env);
+
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
     if (aprofile_require_alignment(env, el, sctlr)) {
         DP_TBFLAG_ANY(flags, ALIGN_MEM, 1);
     }
@@ -323,7 +326,7 @@ static CPUARMTBFlags rebuild_hflags_a32(CPUARMState *env, int fp_el,
 
     DP_TBFLAG_A32(flags, D32DIS, arm_d32dis(env, el));
 
-    return rebuild_hflags_common_32(env, fp_el, mmu_idx, flags);
+    return flags;
 }
 
 /*
@@ -392,7 +395,7 @@ static int fpmr_exception_el(CPUARMState *env, int el)
 static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
                                         ARMMMUIdx mmu_idx)
 {
-    CPUARMTBFlags flags = {};
+    CPUARMTBFlags flags = rebuild_hflags_common(env, fp_el, mmu_idx);
     ARMMMUIdx stage1 = stage_1_mmu_idx(mmu_idx);
     uint64_t tcr = regime_tcr(env, mmu_idx);
     uint64_t hcr = arm_hcr_el2_eff(env);
@@ -672,8 +675,7 @@ static CPUARMTBFlags rebuild_hflags_a64(CPUARMState *env, int el, int fp_el,
     if (cpu_isar_feature(aa64_fpmr, env_archcpu(env))) {
         DP_TBFLAG_A64(flags, FPMR_EL, fpmr_exception_el(env, el));
     }
-
-    return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
+    return flags;
 }
 
 static CPUARMTBFlags rebuild_hflags_internal(CPUARMState *env)
-- 
2.43.0


