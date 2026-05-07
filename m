Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E4CD3439
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 15:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL11T-0003c7-Ht; Thu, 07 May 2026 11:52:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11R-0003bA-P7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:21 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wL11P-0003s4-M7
 for qemu-devel@nongnu.org; Thu, 07 May 2026 11:52:21 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488b8bc6bc9so6698155e9.3
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 08:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778169138; x=1778773938; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6q7pBUaHj3cZmE/VEkADC04g+6hoWqOG0CYGdIYTkwM=;
 b=ZOj/z/eBIwnYe1nXL/s15Q0f/l8eRKUPDGOhpgTiNM1fO5UNoSwBuo3oMbg+wYqHQa
 aboIy+8GCj6PBXj+OyP6ugsMlerDmL/U/X75s+lQa6Fjwmzp5TIhOobojyFUvRVWtj+k
 l31aRlJWbM3rjY86tvvuiSwSFJNHJMB43pJpf+F4GY5khpFlyw9+9JWLG3Ly8lfsB/NY
 A+jAe6B+25k5Sgp8Wf8APTn2WVZQhe2p/qmWWvsFVxCpU5g5Vutix/kWmADflksU3bXT
 BiaBUZUAmyPzDT6o61GdEKKtTWKDNx6NLkuxTtJOF/1DaD6iCgKp1QkITLr/WKLISksa
 vJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778169138; x=1778773938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6q7pBUaHj3cZmE/VEkADC04g+6hoWqOG0CYGdIYTkwM=;
 b=jWmy08rBt0EEVWPwfbXd+oXUNVNF4MjLtLHzPCieijCEjmOwdR+e665suqzIl/j1jS
 8yZzPfHmqI9siWt4bF9bmG6RHNsDP8G6in6zI2n1+tfWQghgj/uVdIczzQtok2S9UE5Y
 Vmz+AuRDzdQEhxCda/Be+x7pPNN0/bdUxXKDY9KbvugmvK0XmjDthf6ODthLASTlM2Kh
 qzOvt6jqr8DX7xAf9NJDCUd2cOpzmGOWHwV02AR4jqSb8e369lYeCOBpPAbt6TMiMl0f
 218YX3pCuhBR8KYD707QxM6o6IoCev2XMT0cNqu64zaZI9OBj89JrtqWFxh96s1cWT70
 1EQw==
X-Gm-Message-State: AOJu0YympA80Y07s+yN2WUdKByM8Uy7olVRsKvZR9jWziyliZnZSxpJ8
 iKLDMU6uzGI6/wSVPilEvdQacz3vSPlGS+Uh6RtexPqD+wgM1VlId6LnjdP0uUqFBh+hjmvNGAe
 /mtqN
X-Gm-Gg: AeBDieuW4iG9P/eneYiukfKiZi2Cj5blyRQnDxru2ilSSuatY1+UoF2ANb5UVVS0INB
 z7sV47fl4eik4nzbV3mjj0Zi1B+60HczepF0IzqCNLqpUprnHFBhnI7eDgtdZA2f92KDtxbA/wA
 mBsJs3KLNtqv+RE/q5+Ee2wB6/lAOisZqMyqXRMiX+bcOJ+tEpF9gJwCYTNDnVCg1Q+yYf2OHtk
 jttwMkvbaJj5SzuSd+DgJEEgVXcL0WQkp7bd7jGBjOAMiglhVLNmFKZN0dEFCB1xPgtGuoUkYG4
 gW50uVrkU7KylzirQizPAXPP2xTSNhLT2JgPKWSFX+o+cHaE2DB5U3mnQSk4tjFAwtv9LS3qcRW
 35d4kDX/e01Jb3rTjJLrQ/dGduqyX8bsyi2Qm3j6zJFID8jvFb99J4tIWTDUTA0SNMXV2jl2iHD
 9xAHYjjhprjM3S2ANPZR7re1mYWq/kZZ4dzQdkr0QBDaVMfrcKM4vOvOBf0sh5YMONQ/6TgoGqe
 auonCEE6FWY0hs6+5nNC2UgZgOLIK3ghnZ92vlYug==
X-Received: by 2002:a05:600c:8485:b0:48d:364:e236 with SMTP id
 5b1f17b1804b1-48e51f30493mr147758785e9.18.1778169138093; 
 Thu, 07 May 2026 08:52:18 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e5312df8dsm41552195e9.18.2026.05.07.08.52.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 08:52:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/67] target/arm: GICv5 cpuif: Implement GIC CD* insns for
 setting config
Date: Thu,  7 May 2026 16:51:09 +0100
Message-ID: <20260507155154.1886557-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507155154.1886557-1-peter.maydell@linaro.org>
References: <20260507155154.1886557-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Implement the GIC CDDIS, GIC CDEN, GIC CDAFF, GIC CDPEND and GIC CDHM
system instructions.  These are all simple wrappers around the
equivalent gicv5_set_* functions, like GIC CDPRI.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Message-id: 20260327111700.795099-23-peter.maydell@linaro.org
---
 target/arm/tcg/gicv5-cpuif.c | 108 +++++++++++++++++++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/target/arm/tcg/gicv5-cpuif.c b/target/arm/tcg/gicv5-cpuif.c
index 0c2bba5ce9..0c4349f8a7 100644
--- a/target/arm/tcg/gicv5-cpuif.c
+++ b/target/arm/tcg/gicv5-cpuif.c
@@ -16,6 +16,25 @@ FIELD(GIC_CDPRI, ID, 0, 24)
 FIELD(GIC_CDPRI, TYPE, 29, 3)
 FIELD(GIC_CDPRI, PRIORITY, 35, 5)
 
+FIELD(GIC_CDDIS, ID, 0, 24)
+FIELD(GIC_CDDIS, TYPE, 29, 3)
+
+FIELD(GIC_CDEN, ID, 0, 24)
+FIELD(GIC_CDEN, TYPE, 29, 3)
+
+FIELD(GIC_CDAFF, ID, 0, 24)
+FIELD(GIC_CDAFF, IRM, 28, 1)
+FIELD(GIC_CDAFF, TYPE, 29, 3)
+FIELD(GIC_CDAFF, IAFFID, 32, 16)
+
+FIELD(GIC_CDPEND, ID, 0, 24)
+FIELD(GIC_CDPEND, TYPE, 29, 3)
+FIELD(GIC_CDPEND, PENDING, 32, 1)
+
+FIELD(GIC_CDHM, ID, 0, 24)
+FIELD(GIC_CDHM, TYPE, 29, 3)
+FIELD(GIC_CDHM, HM, 32, 1)
+
 static GICv5Common *gicv5_get_gic(CPUARMState *env)
 {
     return env->gicv5state;
@@ -51,6 +70,30 @@ static GICv5Domain gicv5_current_phys_domain(CPUARMState *env)
     return gicv5_logical_domain(env);
 }
 
+static void gic_cddis_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDDIS, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDDIS, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_enabled(gic, id, false, domain, type, virtual);
+}
+
+static void gic_cden_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDEN, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDEN, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_enabled(gic, id, true, domain, type, virtual);
+}
+
 static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
                             uint64_t value)
 {
@@ -64,6 +107,46 @@ static void gic_cdpri_write(CPUARMState *env, const ARMCPRegInfo *ri,
     gicv5_set_priority(gic, id, priority, domain, type, virtual);
 }
 
+static void gic_cdaff_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                            uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    uint32_t iaffid = FIELD_EX64(value, GIC_CDAFF, IAFFID);
+    GICv5RoutingMode irm = FIELD_EX64(value, GIC_CDAFF, IRM);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDAFF, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDAFF, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_target(gic, id, iaffid, irm, domain, type, virtual);
+}
+
+static void gic_cdpend_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                             uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    bool pending = FIELD_EX64(value, GIC_CDPEND, PENDING);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDPEND, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDPEND, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_pending(gic, id, pending, domain, type, virtual);
+}
+
+static void gic_cdhm_write(CPUARMState *env, const ARMCPRegInfo *ri,
+                           uint64_t value)
+{
+    GICv5Common *gic = gicv5_get_gic(env);
+    GICv5HandlingMode hm = FIELD_EX64(value, GIC_CDHM, HM);
+    GICv5IntType type = FIELD_EX64(value, GIC_CDAFF, TYPE);
+    uint32_t id = FIELD_EX64(value, GIC_CDAFF, ID);
+    bool virtual = false;
+    GICv5Domain domain = gicv5_current_phys_domain(env);
+
+    gicv5_set_handling(gic, id, hm, domain, type, virtual);
+}
+
 static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
     /*
      * Barrier: wait until the effects of a cpuif system register
@@ -86,11 +169,36 @@ static const ARMCPRegInfo gicv5_cpuif_reginfo[] = {
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 0, .opc2 = 1,
         .access = PL1_W, .type = ARM_CP_NOP,
     },
+    {   .name = "GIC_CDDIS", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 0,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cddis_write,
+    },
+    {   .name = "GIC_CDEN", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 1,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cden_write,
+    },
     {   .name = "GIC_CDPRI", .state = ARM_CP_STATE_AA64,
         .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 2,
         .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
         .writefn = gic_cdpri_write,
     },
+    {   .name = "GIC_CDAFF", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 3,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdaff_write,
+    },
+    {   .name = "GIC_CDPEND", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 1, .opc2 = 4,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdpend_write,
+    },
+    {   .name = "GIC_CDHM", .state = ARM_CP_STATE_AA64,
+        .opc0 = 1, .opc1 = 0, .crn = 12, .crm = 2, .opc2 = 1,
+        .access = PL1_W, .type = ARM_CP_IO | ARM_CP_NO_RAW,
+        .writefn = gic_cdhm_write,
+    },
 };
 
 void define_gicv5_cpuif_regs(ARMCPU *cpu)
-- 
2.43.0


