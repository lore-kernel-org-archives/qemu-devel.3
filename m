Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F54CC6B08
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY4L-0000kE-NE; Tue, 13 Oct 2026 04:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3b-0007UP-9j
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:23 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3V-0007tf-E0
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:19 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso3001641f8f.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880816; x=1792485616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Y8q71JbmtGZDvZaAdzWnKGUCtm5nx9NvXNrI90s4PFM=;
 b=DvzvNN8jECCQDSRyUL5rjWrPIMoK2ILMonvragJQuVPJew20Ojo7eptN/DUd0q3s4z
 iQJFWyDbWfO+aoQwL2Bi599cX36Qenk42QZzhEyUPrD5utsVRUDEWXEKcMvD4kJTiYz+
 mUcxVQ2rd2mWDDU+lwQqpX6XFLzgZNyF6phudzNGD9ByKWwtDUVq6L4WlemH5OW2zidj
 PtHFGDDtRSPt6emuz3BowIQKJJSPxPkWjEg35Lt59wa36aRlWrstcthaEndSlAJCl1Ib
 gkmz9KvIQ3AZC0f1K0mWEmth7SNfJ/MSciqZxlkl+VyOVYJsoQWXVeXRVb+gey7+I0i0
 Zcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880816; x=1792485616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Y8q71JbmtGZDvZaAdzWnKGUCtm5nx9NvXNrI90s4PFM=;
 b=GGZuufjB9Y2yys1X3pCUKRBNGYFxaiOpFYOtzbUIcrqoNF/qi0cRUi5E3MhDXItZKQ
 wt+6+gYOBFXQY9Q/e9ty+MSNhsyEHLNHpFmHyBWaS1wn8+cxc4gY0Gr+UYnaFW86A1Z7
 lkvEDKI2qaaXL0+0SBW8VLOpaDIZvDlHEKdWMzfRhhnt8ySlMALbPBYXoYjxIwxkG6BA
 37aDlTwNaQnL5301PJEsiBE2jN1M93OS1IBCyVLRzPUivJVl4v7AjzDQtbns9sJ2sD+3
 0RXmMDVsxxdjEVBZkXWk6d/W9S/taWR3ZVn9D9+Z19YQ6wliPcLvzvCT1ztCNVfiUX7B
 yplg==
X-Forwarded-Encrypted: i=1;
 AKwUvBztkZOM50xqtjEHK8rwiriCTgRNAl5d+iom01uN46J2GdNCmUx9xzU4wCgVGThN2UKfmi7lx+UQ5UeX@nongnu.org
X-Gm-Message-State: AFq9FYInE+AOFhFcfoaxQQfJvhzQW+ro3SK9bInJs2+Lh66ypbaJh8a9
 5ORaO0iAsrJG0TlvObcclTvYzX/4MCQ+8L85wwZhT8kUQoO3SiLjBMZ/ciEPSB0qDSM=
X-Gm-Gg: AYBFou3eahwkjbjAuo+1IHn5TqCKI2LqMVmgW0UCYbvzH9xyWTc9n6nUf6a27I8VAEj
 Ar4D0lAWKLdDj0AVIyIsfQhkzDKcddoqvYXxwJVdj4iFDpoZxFwl7zQBbfD6Q3MWLhbFonDN7QA
 7R8fJORZwV2Tp9nYFi+UYWPf5BrlEwZdiANiqvq3ZEAFSznqGqSjX6poaw97LQx3sPR0MexdnfL
 EUrWOwsjus2v/pOe7ICNqGSR6lreXfGuqV2+DDTrQg8AjluXxSFiqYcnj9Kk4/FowWpqjDfDjmi
 p1QNPqdeUqNTfNDSddfuGllM6/HPRgXbGnGZi6QjmmroHr2WzrEgy4z3mOpAzEPW3MuiskQZmKa
 HJSLLC29Fv0OThGsQA1gBqu6kSGT+RYY390Q7Bpgdv9sVrIpGrgahOhDcLAukx43ASDSUdtnM/s
 Fg5d1zOmXvtA5OP2oWf0b0xf7+NPxlm0BM6BNr5AFG3i8mYQBFemWcFcgWy/1mUSvPU5MWCpEFE
 t2Vd5ljNIQPHGilbinM6vnmVs7gQyZsQMdDMG+5Uaq78wjLJiM9THpS1KzQac2snJxn/U3CrZIs
 idc=
X-Received: by 2002:a05:600c:3512:b0:49f:c5aa:9ef4 with SMTP id
 5b1f17b1804b1-4a18e4913c3mr198777055e9.8.1791880815822; 
 Tue, 13 Oct 2026 01:40:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.40.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:40:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 29/86] target/arm: GICv5 cpuif: Implement
 ICV_PPI_CACTIVER<n>_EL1, ICV_PPI_SACTIVER<n>_EL1
Date: Tue, 13 Oct 2026 09:38:36 +0100
Message-ID: <20261013083933.1024405-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Implement the redirection of ICC_PPI_CACTIVER<n>_EL1 and
ICC_PPI_SACTIVER<n>_EL1 to the virtual ICV_ versions of these
registers.  The underlying state here is held in
ICH_PPI_ACTIVER<n>_EL2, but the inner-guest facing view has set/clear
semantics.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/gicv5-cpuif.c | 38 ++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index b55fe4991ba..876f5813d5a 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -442,20 +442,42 @@ static uint64_t gic_ppi_hmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
     return value;
 }
 
+static uint64_t gic_ppi_active_read(CPUARMState *env, const ARMCPRegInfo *ri)
+{
+    if (gicv5_icv_access(env)) {
+        uint64_t value = env->gicv5_cpuif.ich_ppi_active[ri->opc2 & 1];
+
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        return value;
+    } else {
+        return raw_read(env, ri);
+    }
+}
+
 static void gic_ppi_cactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    uint64_t old = raw_read(env, ri);
-    raw_write(env, ri, old & ~value);
-    gic_recalc_ppi_hppi(env);
+    if (gicv5_icv_access(env)) {
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        env->gicv5_cpuif.ich_ppi_active[ri->opc2 & 1] &= ~value;
+    } else {
+        uint64_t old = raw_read(env, ri);
+        raw_write(env, ri, old & ~value);
+        gic_recalc_ppi_hppi(env);
+    }
 }
 
 static void gic_ppi_sactive_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    uint64_t old = raw_read(env, ri);
-    raw_write(env, ri, old | value);
-    gic_recalc_ppi_hppi(env);
+    if (gicv5_icv_access(env)) {
+        value &= ~env->gicv5_cpuif.ich_ppi_hvi[ri->opc2 & 1];
+        env->gicv5_cpuif.ich_ppi_active[ri->opc2 & 1] |= value;
+    } else {
+        uint64_t old = raw_read(env, ri);
+        raw_write(env, ri, old | value);
+        gic_recalc_ppi_hppi(env);
+    }
 }
 
 static void gic_ppi_cpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -1043,6 +1065,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .readfn = gic_ppi_active_read,
         .writefn = gic_ppi_cactive_write,
     },
     {   .name = "ICC_PPI_CACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
@@ -1050,6 +1073,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_ALIAS | ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .readfn = gic_ppi_active_read,
         .writefn = gic_ppi_cactive_write,
     },
     {   .name = "ICC_PPI_SACTIVER0_EL1", .state = ARM_CP_STATE_AA64,
@@ -1057,6 +1081,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[0]),
+        .readfn = gic_ppi_active_read,
         .writefn = gic_ppi_sactive_write,
     },
     {   .name = "ICC_PPI_SACTIVER1_EL1", .state = ARM_CP_STATE_AA64,
@@ -1064,6 +1089,7 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .access = PL1_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .fgt = FGT_ICC_PPI_ACTIVERN_EL1,
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ppi_active[1]),
+        .readfn = gic_ppi_active_read,
         .writefn = gic_ppi_sactive_write,
     },
     {   .name = "ICC_PPI_HMR0_EL1", .state = ARM_CP_STATE_AA64,
-- 
2.43.0


