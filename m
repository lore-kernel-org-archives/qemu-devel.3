Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F56D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 17:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOfSh-0006mq-1A; Thu, 27 Nov 2025 12:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vOfSf-0006mH-HQ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:07:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vOfSc-0004jd-QF
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 12:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764263233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cPfqcK7NqlDfWawkBMkHKNcB26B8LOpI/+JkZA8WvBY=;
 b=Zlel1YLOJobKckklHkXz3P86hPkBPlxk65vf8zYoQYasMYweNzKdiQPWzlA7t0xCWzCCqF
 7W45w70wIxb9+z+MrzWKYqAvV5dVr4p+0Gq+q0TzNWUY9Rht1c2qllJWkCU9eud8OaGFRc
 y8p4TmiAaI7CHaJEaUsPMCgL1xGYL04=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-M2RhJoC1PWOIl8BLbBRNDA-1; Thu,
 27 Nov 2025 12:07:09 -0500
X-MC-Unique: M2RhJoC1PWOIl8BLbBRNDA-1
X-Mimecast-MFC-AGG-ID: M2RhJoC1PWOIl8BLbBRNDA_1764263228
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98DFA1956051; Thu, 27 Nov 2025 17:07:08 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.32.245])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6739A18004A3; Thu, 27 Nov 2025 17:07:06 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH for-11.0 v2] arm: add DCZID_EL0 to idregs array
Date: Thu, 27 Nov 2025 18:06:57 +0100
Message-ID: <20251127170657.3335112-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This requires a bit of care, since we still have to handle the EL
specific part (DCZID_EL0.DZP). Callers can set/access dcz_blocksize
via a wrapper working on DCZID_EL.BS.

KVM currently does not support DCZID_EL0 via ONE_REG, assert that
we're not trying to do anything with it until it does.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
Changes v1 -> v2:
- use extract64/deposit64, tweak helper names
- assert that we're not using the reg while running under kvm, instead
  of providing an incorrect dummy value
---
 target/arm/cpu-sysregs.h.inc   |  1 +
 target/arm/cpu.c               |  2 +-
 target/arm/cpu.h               | 14 ++++++++++++--
 target/arm/cpu64.c             |  4 ++--
 target/arm/helper.c            |  5 ++++-
 target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
 target/arm/tcg/helper-a64.c    |  2 +-
 target/arm/tcg/mte_helper.c    |  4 ++--
 target/arm/tcg/translate-a64.c |  2 +-
 target/arm/tcg/translate.h     |  2 +-
 10 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 2bb2861c6234..7f3aa8b991aa 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -39,3 +39,4 @@ DEF(ID_MMFR5_EL1, 3, 0, 0, 3, 6)
 DEF(CLIDR_EL1, 3, 1, 0, 0, 1)
 DEF(ID_AA64ZFR0_EL1, 3, 0, 0, 4, 4)
 DEF(CTR_EL0, 3, 3, 0, 0, 1)
+DEF(DCZID_EL0, 3, 3, 0, 0, 7)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 39292fb9bc1f..557af43a9709 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2184,7 +2184,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 #endif
 
     if (tcg_enabled()) {
-        int dcz_blocklen = 4 << cpu->dcz_blocksize;
+        int dcz_blocklen = 4 << get_dczid_bs(cpu);
 
         /*
          * We only support DCZ blocklen that fits on one page.
diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 39f2b2e54deb..32f003705551 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1111,8 +1111,6 @@ struct ArchCPU {
     bool prop_pauth_qarma5;
     bool prop_lpa2;
 
-    /* DCZ blocksize, in log_2(words), ie low 4 bits of DCZID_EL0 */
-    uint8_t dcz_blocksize;
     /* GM blocksize, in log_2(words), ie low 4 bits of GMID_EL0 */
     uint8_t gm_blocksize;
 
@@ -1178,6 +1176,18 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
+static inline uint8_t get_dczid_bs(ARMCPU *cpu)
+{
+    return extract64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4);
+}
+
+static inline void set_dczid_bs(ARMCPU *cpu, uint8_t bs)
+{
+    /* keep dzp unchanged */
+    cpu->isar.idregs[DCZID_EL0_IDX] =
+        deposit64(cpu->isar.idregs[DCZID_EL0_IDX], 0, 4, bs);
+}
+
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index ae84d8e42050..151698fa0472 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -689,7 +689,7 @@ static void aarch64_a57_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 2048KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 2 * MiB, 7);
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
@@ -751,7 +751,7 @@ static void aarch64_a53_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 1, 64, 32 * KiB, 2);
     /* 1024KB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 27ebc6f29b82..aa111ce9c047 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3320,11 +3320,14 @@ static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
     ARMCPU *cpu = env_archcpu(env);
     int dzp_bit = 1 << 4;
 
+    assert(!kvm_enabled());
+
     /* DZP indicates whether DC ZVA access is allowed */
     if (aa64_zva_access(env, NULL, false) == CP_ACCESS_OK) {
         dzp_bit = 0;
     }
-    return cpu->dcz_blocksize | dzp_bit;
+
+    return cpu->isar.idregs[DCZID_EL0_IDX] | dzp_bit;
 }
 
 static CPAccessResult sp_el0_access(CPUARMState *env, const ARMCPRegInfo *ri,
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 6871956382f7..91b1c53aeb9c 100644
--- a/target/arm/tcg/cpu64.c
+++ b/target/arm/tcg/cpu64.c
@@ -72,7 +72,7 @@ static void aarch64_a35_initfn(Object *obj)
     SET_IDREG(isar, ID_AA64MMFR0, 0x00101122);
     SET_IDREG(isar, ID_AA64MMFR1, 0);
     SET_IDREG(isar, CLIDR, 0x0a200023);
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
 
     /* From B2.4 AArch64 Virtual Memory control registers */
     cpu->reset_sctlr = 0x00c50838;
@@ -219,7 +219,7 @@ static void aarch64_a55_initfn(Object *obj)
     /* Ordered by B2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x84448004; /* L1Ip = VIPT */
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
@@ -325,7 +325,7 @@ static void aarch64_a72_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 3, 64, 48 * KiB, 2);
     /* 1MB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 64, 1 * MiB, 7);
-    cpu->dcz_blocksize = 4; /* 64 bytes */
+    set_dczid_bs(cpu, 4); /* 64 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
@@ -352,7 +352,7 @@ static void aarch64_a76_initfn(Object *obj)
     /* Ordered by B2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x8444C004;
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000010305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
@@ -424,7 +424,7 @@ static void aarch64_a78ae_initfn(Object *obj)
     /* Ordered by 3.2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x9444c004;
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0010100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000001200031ull);
@@ -517,7 +517,7 @@ static void aarch64_a64fx_initfn(Object *obj)
     cpu->ccsidr[1] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 4, 256, 64 * KiB, 2);
     /* 8MB L2 cache */
     cpu->ccsidr[2] = make_ccsidr(CCSIDR_FORMAT_LEGACY, 16, 256, 8 * MiB, 7);
-    cpu->dcz_blocksize = 6; /* 256 bytes */
+    set_dczid_bs(cpu, 6); /* 256 bytes */
     cpu->gic_num_lrs = 4;
     cpu->gic_vpribits = 5;
     cpu->gic_vprebits = 5;
@@ -673,7 +673,7 @@ static void aarch64_neoverse_n1_initfn(Object *obj)
     /* Ordered by B2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0x8444c004;
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64DFR0, 0x0000000110305408ull);
     SET_IDREG(isar, ID_AA64ISAR0, 0x0000100010211120ull);
     SET_IDREG(isar, ID_AA64ISAR1, 0x0000000000100001ull);
@@ -749,7 +749,7 @@ static void aarch64_neoverse_v1_initfn(Object *obj)
     /* Ordered by 3.2.4 AArch64 registers by functional group */
     SET_IDREG(isar, CLIDR, 0x82000023);
     cpu->ctr = 0xb444c004; /* With DIC and IDC set */
-    cpu->dcz_blocksize = 4;
+    set_dczid_bs(cpu, 4);
     SET_IDREG(isar, ID_AA64AFR0, 0x00000000);
     SET_IDREG(isar, ID_AA64AFR1, 0x00000000);
     SET_IDREG(isar, ID_AA64DFR0, 0x000001f210305519ull);
@@ -1011,7 +1011,7 @@ static void aarch64_a710_initfn(Object *obj)
     SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x000000049444c004ull;
-    cpu->dcz_blocksize     = 4;
+    set_dczid_bs(cpu, 4);
     /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_0006_003f */
 
     /* Section B.5.2: PMCR_EL0 */
@@ -1113,7 +1113,7 @@ static void aarch64_neoverse_n2_initfn(Object *obj)
     SET_IDREG(isar, CLIDR, 0x0000001482000023ull);
     cpu->gm_blocksize      = 4;
     cpu->ctr               = 0x00000004b444c004ull;
-    cpu->dcz_blocksize     = 4;
+    set_dczid_bs(cpu, 4);
     /* TODO FEAT_MPAM: mpamidr_el1 = 0x0000_0001_001e_01ff */
 
     /* Section B.7.2: PMCR_EL0 */
@@ -1377,7 +1377,7 @@ void aarch64_max_tcg_initfn(Object *obj)
      * blocksize since we don't have to follow what the hardware does.
      */
     cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
-    cpu->dcz_blocksize = 7; /*  512 bytes */
+    set_dczid_bs(cpu, 7); /*  512 bytes */
 #endif
     cpu->gm_blocksize = 6;  /*  256 bytes */
 
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index ba1d775d818e..e4d2c2e3928c 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -792,7 +792,7 @@ void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
      * (which matches the usual QEMU behaviour of not implementing either
      * alignment faults or any memory attribute handling).
      */
-    int blocklen = 4 << env_archcpu(env)->dcz_blocksize;
+    int blocklen = 4 << get_dczid_bs(env_archcpu(env));
     uint64_t vaddr = vaddr_in & ~(blocklen - 1);
     int mmu_idx = arm_env_mmu_index(env);
     void *mem;
diff --git a/target/arm/tcg/mte_helper.c b/target/arm/tcg/mte_helper.c
index bb48fe359b8c..08b8e7176a6a 100644
--- a/target/arm/tcg/mte_helper.c
+++ b/target/arm/tcg/mte_helper.c
@@ -545,7 +545,7 @@ void HELPER(stzgm_tags)(CPUARMState *env, uint64_t ptr, uint64_t val)
      * i.e. 32 bytes, which is an unreasonably small dcz anyway,
      * to make sure that we can access one complete tag byte here.
      */
-    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
+    log2_dcz_bytes = get_dczid_bs(env_archcpu(env)) + 2;
     log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
     dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
     tag_bytes = (intptr_t)1 << log2_tag_bytes;
@@ -945,7 +945,7 @@ uint64_t HELPER(mte_check_zva)(CPUARMState *env, uint32_t desc, uint64_t ptr)
      * i.e. 32 bytes, which is an unreasonably small dcz anyway, to make
      * sure that we can access one complete tag byte here.
      */
-    log2_dcz_bytes = env_archcpu(env)->dcz_blocksize + 2;
+    log2_dcz_bytes = get_dczid_bs(env_archcpu(env)) + 2;
     log2_tag_bytes = log2_dcz_bytes - (LOG2_TAG_GRANULE + 1);
     dcz_bytes = (intptr_t)1 << log2_dcz_bytes;
     tag_bytes = (intptr_t)1 << log2_tag_bytes;
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 08b21d7dbfa6..3ae3faaeed4b 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -10712,7 +10712,7 @@ static void aarch64_tr_init_disas_context(DisasContextBase *dcbase,
     dc->vec_stride = 0;
     dc->cp_regs = arm_cpu->cp_regs;
     dc->features = env->features;
-    dc->dcz_blocksize = arm_cpu->dcz_blocksize;
+    dc->dcz_blocksize = get_dczid_bs(arm_cpu);
     dc->gm_blocksize = arm_cpu->gm_blocksize;
 
 #ifdef CONFIG_USER_ONLY
diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
index b62104b4ae88..1e30d7c77c37 100644
--- a/target/arm/tcg/translate.h
+++ b/target/arm/tcg/translate.h
@@ -193,7 +193,7 @@ typedef struct DisasContext {
      *  < 0, set by the current instruction.
      */
     int8_t btype;
-    /* A copy of cpu->dcz_blocksize. */
+    /* A copy of DCZID_EL0.BS. */
     uint8_t dcz_blocksize;
     /* A copy of cpu->gm_blocksize. */
     uint8_t gm_blocksize;
-- 
2.51.1


