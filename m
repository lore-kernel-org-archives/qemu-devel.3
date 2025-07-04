Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9AC3C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhGn-0003Yl-Iv; Fri, 04 Jul 2025 10:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGY-0003Ua-FO
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1uXhGV-0003Nf-Qm
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751638786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yy1hKXSa6LkqgdPFbOtswchgAoPwqa7vUToOcXqAGA=;
 b=Dw8TJXnR3alvJxG/exA26KVXXUK0CFYTpm65ecvehIpiSRPVxFm33hZZoJZy164DSfQVmc
 YnOBEAc6V2zXOCFKZBPaAW/ZPMhHLtV479knCDnwneeJvC+vhAsezWzrgaaTeKz0IxDGh6
 6+qsjF2IPvVg1Kq44TB57mrAYR8E48I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-361-wPSVXze2PfiCCBWViVK8bw-1; Fri,
 04 Jul 2025 10:19:45 -0400
X-MC-Unique: wPSVXze2PfiCCBWViVK8bw-1
X-Mimecast-MFC-AGG-ID: wPSVXze2PfiCCBWViVK8bw_1751638784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C24D180034E; Fri,  4 Jul 2025 14:19:44 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.34.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6D36B195608F; Fri,  4 Jul 2025 14:19:42 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Sebastian Ott <sebott@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 4/5] arm/cpu: store clidr into the idregs array
Date: Fri,  4 Jul 2025 16:19:26 +0200
Message-ID: <20250704141927.38963-5-cohuck@redhat.com>
In-Reply-To: <20250704141927.38963-1-cohuck@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.218, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.h             |  3 +--
 target/arm/cpu64.c           |  4 ++--
 target/arm/helper.c          |  2 +-
 target/arm/tcg/cpu-v7m.c     |  4 ++--
 target/arm/tcg/cpu32.c       | 12 ++++++------
 target/arm/tcg/cpu64.c       | 22 +++++++++++-----------
 8 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
index d93e593fcba8..7c78961040ec 100644
--- a/hw/intc/armv7m_nvic.c
+++ b/hw/intc/armv7m_nvic.c
@@ -1331,7 +1331,7 @@ static uint32_t nvic_readl(NVICState *s, uint32_t offset, MemTxAttrs attrs)
         }
         return GET_IDREG(&cpu->isar, ID_ISAR5);
     case 0xd78: /* CLIDR */
-        return cpu->clidr;
+        return GET_IDREG(&cpu->isar, CLIDR);
     case 0xd7c: /* CTR */
         return cpu->ctr;
     case 0xd80: /* CSSIDR */
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 44c877245eea..f48a9daa7c14 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -35,5 +35,6 @@ DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
 DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(ID_DFR1_EL1, 3, 0, 0, 3, 5)
 DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
+DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
 DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(CTR_EL0, 3, 3, 0, 0, 1)
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 793c157d873e..60b6fbdcabbf 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1066,7 +1066,6 @@ struct ArchCPU {
     uint32_t reset_sctlr;
     uint64_t pmceid0;
     uint64_t pmceid1;
-    uint64_t clidr;
     uint64_t mp_affinity; /* MP ID without feature bits */
     /* The elements of this array are the CCSIDR values for each cache,
      * in the order L1DCache, L1ICache, L2DCache, L2ICache, etc.
@@ -2926,7 +2925,7 @@ static inline bool arm_v7m_csselr_razwi(ARMCPU *cpu)
     /* If all the CLIDR.Ctypem bits are 0 there are no caches, and
      * CSSELR is RAZ/WI.
      */
-    return (cpu->clidr & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
+    return (GET_IDREG(&cpu->isar, CLIDR) & R_V7M_CLIDR_CTYPE_ALL_MASK) != 0;
 }
 
 static inline bool arm_sctlr_b(CPUARMState *env)
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 28b8f7db949d..9e6d1c7e4b86 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -675,7 +675,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41013000;
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
     /* 48KB L1 icache */
@@ -737,7 +737,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x00110f13;
     cpu->isar.dbgdevid1 = 0x1;
     cpu->isar.reset_pmcr_el0 = 0x41033000;
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
     /* 32KB L1 icache */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 6acbb2bcd9bd..0b6631399bf1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -7885,7 +7885,7 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .access = PL1_R, .type = ARM_CP_CONST,
             .accessfn = access_tid4,
             .fgt = FGT_CLIDR_EL1,
-            .resetvalue = cpu->clidr
+            .resetvalue = GET_IDREG(isar, CLIDR)
         };
         define_one_arm_cp_reg(cpu, &clidr);
         define_arm_cp_regs(cpu, v7_cp_reginfo);
diff --git a/target/arm/tcg/cpu-v7m.c b/target/arm/tcg/cpu-v7m.c
index a65b83fe9905..dc249ce1f145 100644
--- a/target/arm/tcg/cpu-v7m.c
+++ b/target/arm/tcg/cpu-v7m.c
@@ -195,7 +195,7 @@ static void cortex_m33_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x01310132);
     SET_IDREG(isar, ID_ISAR5, 0x00000000);
     SET_IDREG(isar, ID_ISAR6, 0x00000000);
-    cpu->clidr = 0x00000000;
+    SET_IDREG(isar, CLIDR, 0x00000000);
     cpu->ctr = 0x8000c000;
 }
 
@@ -233,7 +233,7 @@ static void cortex_m55_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x01310132);
     SET_IDREG(isar, ID_ISAR5, 0x00000000);
     SET_IDREG(isar, ID_ISAR6, 0x00000000);
-    cpu->clidr = 0x00000000; /* caches not implemented */
+    SET_IDREG(isar, CLIDR, 0x00000000); /* caches not implemented */
     cpu->ctr = 0x8303c003;
 }
 
diff --git a/target/arm/tcg/cpu32.c b/target/arm/tcg/cpu32.c
index 03cbe42f22f8..a2a23eae0d7b 100644
--- a/target/arm/tcg/cpu32.c
+++ b/target/arm/tcg/cpu32.c
@@ -371,7 +371,7 @@ static void cortex_a8_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR3, 0x11112131);
     SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x15141000;
-    cpu->clidr = (1 << 27) | (2 << 24) | 3;
+    SET_IDREG(isar, CLIDR, (1 << 27) | (2 << 24) | 3);
     cpu->ccsidr[0] = 0xe007e01a; /* 16k L1 dcache. */
     cpu->ccsidr[1] = 0x2007e01a; /* 16k L1 icache. */
     cpu->ccsidr[2] = 0xf0000000; /* No L2 icache. */
@@ -447,7 +447,7 @@ static void cortex_a9_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR3, 0x11112131);
     SET_IDREG(isar, ID_ISAR4, 0x00111142);
     cpu->isar.dbgdidr = 0x35141000;
-    cpu->clidr = (1 << 27) | (1 << 24) | 3;
+    SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 3);
     cpu->ccsidr[0] = 0xe00fe019; /* 16k L1 dcache. */
     cpu->ccsidr[1] = 0x200fe019; /* 16k L1 icache. */
     cpu->isar.reset_pmcr_el0 = 0x41093000;
@@ -519,7 +519,7 @@ static void cortex_a7_initfn(Object *obj)
     cpu->isar.dbgdidr = 0x3515f005;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x1;
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
     cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
@@ -567,7 +567,7 @@ static void cortex_a15_initfn(Object *obj)
     cpu->isar.dbgdidr = 0x3515f021;
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x0;
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     cpu->ccsidr[0] = 0x701fe00a; /* 32K L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32K L1 icache */
     cpu->ccsidr[2] = 0x711fe07a; /* 4096K L2 unified cache */
@@ -758,7 +758,7 @@ static void cortex_r52_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR4, 0x00010142);
     SET_IDREG(isar, ID_ISAR5, 0x00010001);
     cpu->isar.dbgdidr = 0x77168000;
-    cpu->clidr = (1 << 27) | (1 << 24) | 0x3;
+    SET_IDREG(isar, CLIDR, (1 << 27) | (1 << 24) | 0x3);
     cpu->ccsidr[0] = 0x700fe01a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe00a; /* 32KB L1 icache */
 
@@ -990,7 +990,7 @@ static void arm_max_initfn(Object *obj)
     SET_IDREG(isar, ID_ISAR5, 0x00011121);
     SET_IDREG(isar, ID_ISAR6, 0);
     cpu->isar.reset_pmcr_el0 = 0x41013000;
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     cpu->ccsidr[0] = 0x701fe00a; /* 32KB L1 dcache */
     cpu->ccsidr[1] = 0x201fe012; /* 48KB L1 icache */
     cpu->ccsidr[2] = 0x70ffe07a; /* 2048KB L2 cache */
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index d2f743fb3913..04a6b277e242 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -71,7 +71,7 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64ISAR1, 0);
     SET_IDREG(isar, ID_AA64MMFR0, 0x00101122);
     SET_IDREG(isar, ID_AA64MMFR1, 0);
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     cpu->dcz_blocksize = 4;
 
     /* From B2.4 AArch64 Virtual Memory control registers */
@@ -216,7 +216,7 @@ static void aarch64_a55_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
 
     /* Ordered by B2.4 AArch64 registers by functional group */
-    cpu->clidr = 0x82000023;
+    SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
     cpu->dcz_blocksize = 4; /* 64 bytes */
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
@@ -317,7 +317,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->isar.dbgdevid = 0x01110f13;
     cpu->isar.dbgdevid1 = 0x2;
     cpu->isar.reset_pmcr_el0 = 0x41023000;
-    cpu->clidr = 0x0a200023;
+    SET_IDREG(isar, CLIDR, 0x0a200023);
     /* 32KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 64, 32 * KiB, 7);
     /* 48KB L1 dcache */
@@ -349,7 +349,7 @@ static void aarch64_a76_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
 
     /* Ordered by B2.4 AArch64 registers by functional group */
-    cpu->clidr = 0x82000023;
+    SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x8444C004;
     cpu->dcz_blocksize = 4;
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
@@ -436,7 +436,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000000010211120);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000010001);
     SET_IDREG(isar, ID_AA64ZFR0, 0x0000000000000000);
-    cpu->clidr = 0x0000000080000023;
+    SET_IDREG(isar, CLIDR, 0x0000000080000023);
     /* 64KB L1 dcache */
     cpu->ccsidr[0] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 7);
     /* 64KB L1 icache */
@@ -597,7 +597,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
 
     /* Ordered by B2.4 AArch64 registers by functional group */
-    cpu->clidr = 0x82000023;
+    SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x8444c004;
     cpu->dcz_blocksize = 4;
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
@@ -673,7 +673,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     set_feature(&cpu->env, ARM_FEATURE_PMU);
 
     /* Ordered by 3.2.4 AArch64 registers by functional group */
-    cpu->clidr = 0x82000023;
+    SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0xb444c004; /* With DIC and IDC set */
     cpu->dcz_blocksize = 4;
     SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
@@ -934,7 +934,7 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101122ull);
     SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
     SET_IDREG(isar, ID_AA64MMFR2, 0x1221011110101011ull);
-    cpu->clidr             = 0x0000001482000023ull;
+    SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x000000049444c004ull;
     cpu->dcz_blocksize     = 4;
@@ -1036,7 +1036,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR0, 0x0000022200101125ull);
     SET_IDREG(isar, ID_AA64MMFR1, 0x0000000010212122ull);
     SET_IDREG(isar, ID_AA64MMFR2, 0x1221011112101011ull);
-    cpu->clidr             = 0x0000001482000023ull;
+    SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x00000004b444c004ull;
     cpu->dcz_blocksize     = 4;
@@ -1125,10 +1125,10 @@ void aarch64_max_tcg_initfn(Object *obj)
      * We're going to set FEAT_S2FWB, which mandates that CLIDR_EL1.{LoUU,LoUIS}
      * are zero.
      */
-    u = cpu->clidr;
+    u = GET_IDREG(isar, CLIDR);
     u = FIELD_DP32(u, CLIDR_EL1, LOUIS, 0);
     u = FIELD_DP32(u, CLIDR_EL1, LOUU, 0);
-    cpu->clidr = u;
+    SET_IDREG(isar, CLIDR, u);
 
     /*
      * Set CTR_EL0.DIC and IDC to tell the guest it doesnt' need to
-- 
2.50.0


