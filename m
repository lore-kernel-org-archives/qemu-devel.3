Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE337606A339
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b/49WzGH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMRI5-00079e-1y; Thu, 29 Oct 2026 10:39:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMRGr-0006NM-Q8
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:38:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xMRGp-0007Q8-JD
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 10:38:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793284702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PoQNe54zxPa1RyFl+zm/Uzbvagx6U+xZ+2kF/c0AhcQ=;
 b=b/49WzGHbvrl12Vhsx38onOy3mPyJvW1rz6Vi8LqOV9rtaNGW4QLG1LIIvHpmWnZEOE8xz
 hGqr0Z76c0T7HCg/0XsAnPVqUjFN6qoMFod1+3L0wzxJl+CAdP4Hl768x6hHvWOfLNj1y5
 K7rqA0RQnRYcXtOnWnuNXV/TFVN2XCo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-B6af7j1FPzWKz9W57yXttA-1; Thu,
 29 Oct 2026 10:38:17 -0400
X-MC-Unique: B6af7j1FPzWKz9W57yXttA-1
X-Mimecast-MFC-AGG-ID: B6af7j1FPzWKz9W57yXttA_1793284692
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9632B1955F0B; Thu, 29 Oct 2026 14:38:12 +0000 (UTC)
Received: from laptop.redhat.corp (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E943D1955F01; Thu, 29 Oct 2026 14:38:07 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, peter.maydell@linaro.org, shaju.abraham@nutanix.com,
 khushit.shah@nutanix.com, richard.henderson@linaro.org,
 pbonzini@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com,
 7746591750@163.com, maobibo@loongson.cn, harshpb@linux.ibm.com,
 amachhiw@linux.ibm.com, daniel.barboza@oss.qualcomm.com,
 milesg@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 alireza.sanaee@huawei.com
Cc: armbru@redhat.com,
	mbawa@redhat.com
Subject: [PATCH v2 for-11.2 4/9] target/arm: Enforce MPIDR into isar.idregs[]
 storage
Date: Thu, 29 Oct 2026 15:36:51 +0100
Message-ID: <20261029143742.294275-5-eric.auger@redhat.com>
In-Reply-To: <20261029143742.294275-1-eric.auger@redhat.com>
References: <20261029143742.294275-1-eric.auger@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

At the moment MPIDR_EL1 has no real storage. Instead cpu
mp_affinity field stores the Aff0-Aff2 bits only and the
ID register is reconstructed when needed. There is also
an mp-affinity property used for TCG only.

Keep the mp-affinity property and its associated storage
while making sure the MPIDR_EL1 full register is stored
in cpu->isar.idregs[] as other ID registers.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Suggested-by: Khushit Shah <khushit.shah@nutanix.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Sebastian Ott <sebott@redhat.com>
Reviewed-by: Khushit Shah <khushit.shah@nutanix.com>
---
 target/arm/cpu.h             |  8 +++++++-
 target/arm/cpu-sysregs.h.inc |  1 +
 target/arm/cpu.c             | 17 +++++++++++++++++
 target/arm/helper.c          | 14 +-------------
 target/arm/hvf/hvf.c         |  2 +-
 target/arm/kvm.c             |  1 +
 target/arm/whpx/whpx-all.c   |  2 +-
 7 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e6b4000127..5c5f551dac 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1130,7 +1130,13 @@ struct ArchCPU {
     uint32_t reset_sctlr;
     uint64_t pmceid0;
     uint64_t pmceid1;
-    uint64_t mp_affinity; /* MP ID without feature bits */
+    /*
+     * MP ID without feature bits, ie. Aff0..Aff3 only
+     * used to store the corresponding property value for TCG vcpus.
+     * The MPIDR_EL1 value (affinity + feature bits) is stored in a
+     * consistent manner in isar.idregs[MPIDR_EL1_IDX].
+     */
+    uint64_t mp_affinity;
     uint64_t reset_cbar;
     uint32_t reset_auxcr;
     bool reset_hivecs;
diff --git a/target/arm/cpu-sysregs.h.inc b/target/arm/cpu-sysregs.h.inc
index 709dc8fc97..f148f6f565 100644
--- a/target/arm/cpu-sysregs.h.inc
+++ b/target/arm/cpu-sysregs.h.inc
@@ -42,6 +42,7 @@ DEF(ID_PFR0_EL1, 3, 0, 0, 1, 0)
 DEF(ID_PFR1_EL1, 3, 0, 0, 1, 1)
 DEF(ID_PFR2_EL1, 3, 0, 0, 3, 4)
 DEF(MIDR_EL1, 3, 0, 0, 0, 0)
+DEF(MPIDR_EL1, 3, 0, 0, 0, 5)
 DEF(MVFR0_EL1, 3, 0, 0, 3, 0)
 DEF(MVFR1_EL1, 3, 0, 0, 3, 1)
 DEF(MVFR2_EL1, 3, 0, 0, 3, 2)
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index e337462a7e..aba45b66f8 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2170,6 +2170,23 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
                                                  ARM_DEFAULT_CPUS_PER_CLUSTER);
     }
 
+    /* Consistently update MPIDR_EL1 in isar.idregs[] by adding feature bits */
+    {
+        uint64_t mpidr = cpu->mp_affinity;
+
+        if (arm_feature(env, ARM_FEATURE_V7MP)) {
+            mpidr |= (1U << 31);
+            /*
+             * Uniprocessor (non-coherent) cores that still implement the MP
+             * extensions set U (bit 30), e.g. Cortex-R5.
+             */
+            if (cpu->mp_is_up) {
+                mpidr |= (1u << 30);
+            }
+        }
+        SET_IDREG(&cpu->isar, MPIDR, mpidr);
+    }
+
     if (cpu->reset_hivecs) {
             cpu->reset_sctlr |= (1 << 13);
     }
diff --git a/target/arm/helper.c b/target/arm/helper.c
index afaac33f2a..f413b15eb7 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3180,20 +3180,8 @@ static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
 static uint64_t mpidr_read_val(CPUARMState *env)
 {
     ARMCPU *cpu = env_archcpu(env);
-    uint64_t mpidr = cpu->mp_affinity;
 
-    if (arm_feature(env, ARM_FEATURE_V7MP)) {
-        mpidr |= (1U << 31);
-        /*
-         * Cores which are uniprocessor (non-coherent)
-         * but still implement the MP extensions set
-         * bit 30. (For instance, Cortex-R5).
-         */
-        if (cpu->mp_is_up) {
-            mpidr |= (1u << 30);
-        }
-    }
-    return mpidr;
+    return GET_IDREG(&cpu->isar, MPIDR);
 }
 
 static uint64_t mpidr_read(CPUARMState *env, const ARMCPRegInfo *ri)
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f9f3d22014..4b947e9ba5 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1476,7 +1476,7 @@ int hvf_arch_init_vcpu(CPUState *cpu)
     assert_hvf_ok(ret);
 
     ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_MPIDR_EL1,
-                              arm_cpu->mp_affinity);
+                              GET_IDREG(&arm_cpu->isar, MPIDR));
     assert_hvf_ok(ret);
 
     pfr = GET_IDREG(&arm_cpu->isar, ID_AA64PFR0);
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index de09d63d2e..724bc08edf 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2103,6 +2103,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
     if (ret) {
         return ret;
     }
+    SET_IDREG(&cpu->isar, MPIDR, mpidr);
     cpu->mp_affinity = mpidr & ARM64_AFFINITY_MASK;
 
     return kvm_arm_init_cpreg_list(cpu);
diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 18009d6c8d..024d18df04 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -842,7 +842,7 @@ int whpx_init_vcpu(CPUState *cpu)
 
     clean_whv_register_value(&val);
 
-    val.Reg64 = deposit64(arm_cpu->mp_affinity, 31, 1, 1 /* RES1 */);
+    val.Reg64 = GET_IDREG(&arm_cpu->isar, MPIDR);
     whpx_set_reg(cpu, WHvArm64RegisterMpidrEl1, val);
 
     clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar);
-- 
2.53.0


