Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40BBC79FA0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 15:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vcmiN-0005D6-JP; Mon, 05 Jan 2026 10:41:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vcmiA-0005BS-8i
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:41:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vcmi5-0005Bz-Bd
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 10:41:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767627692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l05uy8EIscq45g8fvyF/YaUz6y8wH6xLtOs+SSL4TVU=;
 b=cebnigWGEUqNeeyqJClWa810uJb0W9aaC07gQxV4HMZitZdzI6/LY7IHMiwrafwX0pCvc1
 FLn+AP1keLURjyTRURX2h5U1ebZ+rdeIZzE5bicwZOy5Wjbe3bviJOGzXFEtSPv0/BSkV6
 Rv8igCBADIWIj3PFFCZjMVgKH5mXqtE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-bI3_-tuvN4KiQeGPvOZKjA-1; Mon,
 05 Jan 2026 10:41:30 -0500
X-MC-Unique: bI3_-tuvN4KiQeGPvOZKjA-1
X-Mimecast-MFC-AGG-ID: bI3_-tuvN4KiQeGPvOZKjA_1767627689
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2A6501801207; Mon,  5 Jan 2026 15:41:29 +0000 (UTC)
Received: from gondolin.redhat.com (unknown [10.44.33.132])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1A5A330001A7; Mon,  5 Jan 2026 15:41:26 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eric Auger <eric.auger@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH v3 1/2] arm: add {get,set}_dczid_bs helpers
Date: Mon,  5 Jan 2026 16:41:18 +0100
Message-ID: <20260105154119.59853-2-cohuck@redhat.com>
In-Reply-To: <20260105154119.59853-1-cohuck@redhat.com>
References: <20260105154119.59853-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Most accesses to cpu->dcz_blocksize really care about
DCZID_EL0.BS (i.e. the part of the register that does not change at
different EL.) Wean them off directly dealing with cpu->dcz_blocksize
so that we can switch to handling DCZID_EL0 differently in a followup
patch.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/arm/cpu.c               |  2 +-
 target/arm/cpu.h               | 10 ++++++++++
 target/arm/cpu64.c             |  4 ++--
 target/arm/helper.c            |  1 +
 target/arm/tcg/cpu64.c         | 22 +++++++++++-----------
 target/arm/tcg/helper-a64.c    |  2 +-
 target/arm/tcg/mte_helper.c    |  4 ++--
 target/arm/tcg/translate-a64.c |  2 +-
 8 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index caf7980b1fc5..59e4c4f6fc2e 100644
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
index 9579d43ba338..c0dae1a891a7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1178,6 +1178,16 @@ struct ARMCPUClass {
     ResettablePhases parent_phases;
 };
 
+static inline uint8_t get_dczid_bs(ARMCPU *cpu)
+{
+    return cpu->dcz_blocksize;
+}
+
+static inline void set_dczid_bs(ARMCPU *cpu, uint8_t bs)
+{
+    cpu->dcz_blocksize = bs;
+}
+
 /* Callback functions for the generic timer's timers. */
 void arm_gt_ptimer_cb(void *opaque);
 void arm_gt_vtimer_cb(void *opaque);
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index bf3038137019..4dfc03973e17 100644
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
index 263ca29d92b4..61b3b90b63c0 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3324,6 +3324,7 @@ static uint64_t aa64_dczid_read(CPUARMState *env, const ARMCPRegInfo *ri)
     if (aa64_zva_access(env, NULL, false) == CP_ACCESS_OK) {
         dzp_bit = 0;
     }
+
     return cpu->dcz_blocksize | dzp_bit;
 }
 
diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
index 917db5bb09a0..3db8d4694a7d 100644
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
index cde22a5cca73..7a8cd99e004d 100644
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
-- 
2.52.0


