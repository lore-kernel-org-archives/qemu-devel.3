Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112DC606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PjQ8m55v
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMMME-0006qv-GA; Thu, 29 Oct 2026 05:23:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMMMB-0006qC-NA
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:23:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMMM9-0005jp-LD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 05:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793265813;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8tLECKrRw247ZtzjCGrpqsxDis3vplooT+wcro9twnE=;
 b=PjQ8m55v8JgQT+jZmXtZVF4bR0Zz1izfyYzt3Ww2CPYdK9YEkYw2lHHE/r+dasBCDwECeK
 qCD08daoFE9Pmv3FbkrfrYFzMShAnSZcH+0wzN+BEm/GusWjrAS7T08GhF21gTjQjoAOHt
 53fwj42lImBIRnkCaW/vtBeWucHvEtc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-GVlUan64M4yu4LtbHfy0ag-1; Thu,
 29 Oct 2026 05:23:29 -0400
X-MC-Unique: GVlUan64M4yu4LtbHfy0ag-1
X-Mimecast-MFC-AGG-ID: GVlUan64M4yu4LtbHfy0ag_1793265807
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8A731956096; Thu, 29 Oct 2026 09:23:26 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 284ED30002CF; Thu, 29 Oct 2026 09:23:21 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH for-11.2 2/9] target/arm: Move REVIDR into isar.idregs[]
 storage
Date: Thu, 29 Oct 2026 10:20:14 +0100
Message-ID: <20261029092307.281287-3-eric.auger@redhat.com>
In-Reply-To: <20261029092307.281287-1-eric.auger@redhat.com>
References: <20261029092307.281287-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move REVIDR into the isar.idregs[] array as other ID registers.
This will allow to overwrite it as others.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h             |  1 -
 target/arm/cpu-sysregs.h.inc |  1 +
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-max.c         |  2 +-
 target/arm/cpu64.c           |  2 +-
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu-v7m.c     |  4 ++--
 target/arm/tcg/cpu32.c       |  4 ++--
 target/arm/tcg/cpu64.c       | 20 ++++++++++----------
 9 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index add993ef10..c811369e63 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1126,7 +1126,6 @@ struct ArchCPU {
         uint64_t idregs[NUM_ID_IDX];
     } isar;
     uint64_t midr;
-    uint32_t revidr;
     uint32_t reset_fpsid;
     uint64_t ctr;
     uint32_t reset_sctlr;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index b5c7970971..580d88d1f4 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -44,3 +44,4 @@ DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
 DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
 DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
+DEF(REVIDR_EL1, 3, 0, 0, 0, 6)
diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index 6bc392b0e3..1f56fff046 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1051,7 +1051,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         if (!arm_feature(&cpu->env, ARM_FEATURE_V8_1M)) {
             goto bad_offset;
         }
-        return cpu->revidr;
+        return GET_IDREG(isar, REVIDR);
     case 0xd00: /* CPUID Base.  */
         return cpu->midr;
     case 0xd04: /* Interrupt Control State (ICSR) */
diff --git a/target/arm/cpu-max.c b/target/arm/cpu-max.c
index 2ed1cfef9b..b4e57a167d 100644
--- a/target/arm/cpu-max.c
+++ b/target/arm/cpu-max.c
@@ -37,7 +37,7 @@ void aarch64_aa32_a57_init(ARMCPU *cpu, bool aarch64_enabled)
         cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A57;
     }
     cpu->midr = 0x411fd070;
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index dcd0d698b3..80c9c9e5b3 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -717,7 +717,7 @@ static void aarch64_a53_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->kvm_target = QEMU_KVM_ARM_TARGET_CORTEX_A53;
     cpu->midr = 0x410fd034;
-    cpu->revidr = 0x00000100;
+    SET_IDREG(isar, REVIDR, 0x00000100);
     cpu->reset_fpsid = 0x41034070;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index b540705e63..8c78370626 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7453,7 +7453,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .access = PL1_R,
               .accessfn = access_tid1,
               .fgt = FGT_REVIDR_EL1,
-              .type = ARM_CP_CONST, .resetvalue = cpu->revidr },
+              .type = ARM_CP_CONST, .resetvalue = GET_IDREG(&cpu->isar, REVIDR) },
         };
         ARMCPRegInfo id_v8_midr_alias_cp_reginfo = {
             .name = "MIDR", .type = ARM_CP_ALIAS | ARM_CP_CONST | ARM_CP_NO_GDB,
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index 1093c6cbf6..9a5512aa55 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -211,7 +211,7 @@ static void cortex_m55_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x410fd221; /* r0p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
     /* These are the MVFR* values for the FPU + full MVE configuration */
@@ -249,7 +249,7 @@ static void cortex_m85_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_M_SECURITY);
     set_feature(&cpu->env, ARM_FEATURE_THUMB_DSP);
     cpu->midr = 0x411fd231; /* r1p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->pmsav7_dregion = 16;
     cpu->sau_sregion = 8;
     /* These are the MVFR* values for the FPU + full MVE configuration */
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index f95051458d..c02b737fc0 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -456,7 +456,7 @@ static void cortex_a15_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     /* r4p0 cpu, not requiring expensive tlb flush errata */
     cpu->midr = 0x414fc0f0;
-    cpu->revidr = 0x0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x410430f0;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x11111111;
@@ -647,7 +647,7 @@ static void cortex_r52_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_CBAR_RO);
     set_feature(&cpu->env, ARM_FEATURE_AUXCR);
     cpu->midr = 0x411fd133; /* r1p3 */
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x41034023;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index c92e331e73..7af29978c6 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -48,7 +48,7 @@ static void aarch64_a35_initfn(Object *obj)
 
     /* From B2.2 AArch64 identification registers. */
     cpu->midr = 0x411fd040;
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->ctr = 0x84448004;
     SET_IDREG(isar, ID_PFR0, 0x00000131);
     SET_IDREG(isar, ID_PFR1, 0x00011011);
@@ -248,7 +248,7 @@ static void aarch64_a55_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00011011);
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x412FD050;          /* r2p0 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From B2.23 CCSIDR_EL1 */
     /* 32KB L1 dcache */
@@ -292,7 +292,7 @@ static void aarch64_a72_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x410fd083;
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->reset_fpsid = 0x41034080;
     cpu->isar.mvfr0 = 0x10110222;
     cpu->isar.mvfr1 = 0x12111111;
@@ -383,7 +383,7 @@ static void aarch64_a76_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x414fd0b1;          /* r4p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From B2.18 CCSIDR_EL1 */
     /* 64KB L1 dcache */
@@ -456,7 +456,7 @@ static void aarch64_a78ae_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x410fd423;          /* r0p3 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From 3.2.33 CCSIDR_EL1 */
     /* 64KB L1 dcache */
@@ -501,7 +501,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_EL3);
     set_feature(&cpu->env, ARM_FEATURE_PMU);
     cpu->midr = 0x461f0010;
-    cpu->revidr = 0x00000000;
+    SET_IDREG(isar, REVIDR, 0);
     cpu->ctr = 0x86668006;
     cpu->reset_sctlr = 0x30000180;
     SET_IDREG(isar, ID_AA64PFR0, 0x0000000101111111); /* No RAS Extensions */
@@ -707,7 +707,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x414fd0c1;          /* r4p1 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /* From B2.23 CCSIDR_EL1 */
     /* 64KB L1 dcache */
@@ -787,7 +787,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_PFR2, 0x00000011);
     cpu->midr = 0x411FD402;          /* r1p2 */
-    cpu->revidr = 0;
+    SET_IDREG(isar, REVIDR, 0);
 
     /*
      * The Neoverse-V1 r1p2 TRM lists 32-bit format CCSIDR_EL1 values,
@@ -984,7 +984,7 @@ static void aarch64_a710_initfn(Object *obj)
 
     /* Ordered by Section B.4: AArch64 registers */
     cpu->midr          = 0x412FD471; /* r2p1 */
-    cpu->revidr        = 0;
+    SET_IDREG(isar, REVIDR, 0);
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
@@ -1087,7 +1087,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
 
     /* Ordered by Section B.5: AArch64 ID registers */
     cpu->midr          = 0x410FD493; /* r0p3 */
-    cpu->revidr        = 0;
+    SET_IDREG(isar, REVIDR, 0);
     SET_IDREG(isar, ID_PFR0, 0x21110131);
     SET_IDREG(isar, ID_PFR1, 0x00010000); /* GIC filled in later */
     SET_IDREG(isar, ID_DFR0, 0x16011099);
-- 
2.53.0


