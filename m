Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4978CA9ED2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGY3f-0007bp-4q; Tue, 13 Oct 2026 04:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3Q-00075P-Ps
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:15 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xGY3L-0007cs-IR
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 04:40:12 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so22518215e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2026 01:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791880798; x=1792485598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=K/fazeDrj1SJvW+QNVTTmk1BBmWOISZMReEdlQ3HE/s=;
 b=vCLsdyaBxcUANmL5UPuu+dTDqhaIs8BAQ8jTzu34/RhvRE7+rmBmnCxbRiHE5MrQZy
 eJ3DDrwPBJRFtKNNZWNgEvmgd9rrPhHggI3DzxbxglSieqNeaYcF01qArPP66H268j1e
 ORGWprrcuTwYT8iFEvoemnStbFE1+UeqUQH9VFTogGCbAFTLuE1+eu12a+5Qa8FGuKf8
 O2OwJDbCiVmphVHlPmnsai0zE+TetXcXCUp8XxxQM2moxtuJoeASsXiM8C9Wpf/6l9Nm
 89XBy3O76401L1oJPSgcRbyDCS/RwLwQ7iKTpcbItLoY4A3wmH+bALwJplvdScX+S5Mx
 eMtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791880798; x=1792485598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=K/fazeDrj1SJvW+QNVTTmk1BBmWOISZMReEdlQ3HE/s=;
 b=G7rt6C+QVdARP1GYyPRpiRl9BFXYi4QdwIQ+wLVut8mKXPpDOdemY1D86Xd8hHyzSu
 Bp0l5ZHQFBgs70vhk3KYPMweDKL2I8SiaSHWV2sqjT7KevipIVa14HfuUxpgC66+hWok
 M7AP4n3PA/V0a5WvJWe/hWx4LaIYEhS/aOwdE5BUygTp6ancsiXCKAoh1lx3WJOQupdY
 vpiXA7ZSDDdecmpFvUMrQzKDkeboQGLB5rbNiIxvAVDPS90L1ThXbGE4bXFUJR9r8RWn
 c1pLzgzXSEhy1SinhLVmelcLeUAh6Fao9GeNvl+T3HwZuaCiU0A52Vig4+MWX6eWpwCR
 xALA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxi+tSZcA9dNK6PL/F/wQ5O4ON2uMTovmbwN9+y3yFvngiwWyMjgrjv0KeZNRYIA4u2rzGWwiwxTIz0@nongnu.org
X-Gm-Message-State: AFq9FYLBsvcJJGAISLq6rqj4dq0RNbtWDzuwgPPFm9Jov+RPV8n+vBZR
 pNxS9smrNANPkLk9Wcw/4j6nZqHDzNzYzGbRddAkubOBiqtnl5dOfkjRD/Hb+KyZslvlLqKtoGP
 Zcnz3LtQ=
X-Gm-Gg: AYBFou2xm2+Tas78kUxLgKqs3dX3Gr2fNrgO9Am2Q95N0GN552q4DYT4Z/6Qn4OB1it
 KrH4L8U3djdBlv4DRVFR+4giBrP/ThpGyaSjkIPybfqjAgFwBYCiLSlvrGtMdpIOVYZFO+nsE50
 i+gTsIvWihE82Z6XKGpLARVdGrJMalyPQ2SbYClLS/3rYxErcYEmgJ5QoCqdfMAWdnuEdm1rZ1j
 IUcu3Vc0ej5T5hFv2cmmuFywq4Ynay53TZYopO8rXALnAa/Ef6REoL5LCdEQPxM1fSwS/2QlRx1
 LTs7uAE7nCM/bIXRsY/WpenV/MECWH9plBRiGhAS8aAJOqGMtZ9k0tiLK9aMfY5PG+v5yI+do/x
 dAh5lfTvwiw55lmAGLpExEFpxyak04wXCkoKFT9CABdInU4CRcvVk4Z3m2mM+0gRKw6k4u4OzwJ
 EM3p2QL4Jlmatx7ou1JGrA65yXnAvNtGEty1H/pOfbAssBBuoeVnmhbKmnj8xz2EF1SCPh7QIU8
 I5fTwOLlM1K3llGJZBf/fhhadHGwDyALNUW2PtlJAnqgECOmKrEv8LeLUjpo4FN5TyDPYHqCUtC
 XCxNvrpsCOHZfw==
X-Received: by 2002:a05:600c:1e0f:b0:4a1:7b87:8d34 with SMTP id
 5b1f17b1804b1-4a18e4b46e1mr212143875e9.21.1791880797929; 
 Tue, 13 Oct 2026 01:39:57 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18be96549sm495086735e9.6.2026.10.13.01.39.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:39:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 17/86] target/arm: GICv5 cpuif: Implement ICH_VCTLR_EL2 and
 ICH_VCMR_EL2
Date: Tue, 13 Oct 2026 09:38:24 +0100
Message-ID: <20261013083933.1024405-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013083933.1024405-1-peter.maydell@linaro.org>
References: <20261013083933.1024405-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

Implement the ICH_VCTLR_EL2 and ICH_VMCR_EL2 registers, which hold
hypervisor state for controlling its guest's GICv5 virtual cpu
interface.

We give these write functions and mark them as ARM_CP_IO even though
they currently don't do anything special on write, because later on
we will need changes to fields in these registers to trigger a
recalculation of whether the VIRQ and VFIQ interrupts are signalled.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  2 ++
 target/arm/tcg/gicv5-cpuif.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 5d3587739d7..4e7076a5339 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -596,6 +596,8 @@ typedef struct CPUArchState {
         GICv5PendingIrq ppi_hppi[NUM_GICV5_DOMAINS];
 
         uint64_t ich_apr_el2;
+        uint64_t ich_vctlr_el2;
+        uint64_t ich_vmcr_el2;
         uint64_t ich_ppi_active[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_pend[GICV5_NUM_PPIS / 64];
         uint64_t ich_ppi_enable[GICV5_NUM_PPIS / 64];
diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 2141f1d8e2c..ac667c84c2f 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -493,6 +493,18 @@ static void gic_ich_ppi_dvi_write(CPUARMState *env, const ARMCPRegInfo *ri,
     raw_write(env, ri, value);
 }
 
+static void gic_ich_vctlr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                                uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
+static void gic_ich_vmcr_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                               uint64_t value)
+{
+    raw_write(env, ri, value);
+}
+
 /*
  * ICC_APR_EL1 is banked and reads/writes as the version for the
  * current logical interrupt domain.
@@ -1034,6 +1046,22 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_ppi_active[1]),
         .writefn = gic_ich_ppi_active_write,
     },
+    {   .name = "ICH_VCTLR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 4,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0xb28,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_vctlr_el2),
+        .writefn = gic_ich_vctlr_write,
+    },
+    {   .name = "ICH_VMCR_EL2", .state = ARM_CP_STATE_AA64,
+        .opc0 = 3, .opc1 = 4, .crn = 12, .crm = 11, .opc2 = 7,
+        .access = PL2_RW, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .nv2_redirect_offset = 0x4c8,
+        .accessfn = access_gicv5_ich_reg,
+        .fieldoffset = offsetof(CPUARMState, gicv5_cpuif.ich_vmcr_el2),
+        .writefn = gic_ich_vmcr_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


