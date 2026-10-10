Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D506CA9EBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2026 13:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFXGz-0001Z4-4K; Sat, 10 Oct 2026 09:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXGx-0001YF-Iz
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:37:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1xFXGw-0004XF-0s
 for qemu-devel@nongnu.org; Sat, 10 Oct 2026 09:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791639476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iWQgwG64LSjw/q9IlyJDOWXuDx5P7x5+Mk1gkqqoXd4=;
 b=XJvY7Oh+cBUAXprG9pVi2QxpGkS4ua8rvwpXxLeAvxAthWGotByAJEr3QuJ+llXbAZi8eH
 XnIoK/jJ82QjakO0M5v9iaRYXoZnrq2GueHP/D4X+Au6tskTKWEY56yHM8G9C/s1qkSN4A
 tZh3hpXDfZHVlp5EDOY64J10j041KG8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-463-l7bGL70SNLqaCXgtZg-jfA-1; Sat,
 10 Oct 2026 13:37:52 +0000
X-MC-Unique: l7bGL70SNLqaCXgtZg-jfA-1
X-Mimecast-MFC-AGG-ID: l7bGL70SNLqaCXgtZg-jfA_1791639470
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5742B19560B7; Sat, 10 Oct 2026 13:37:50 +0000 (UTC)
Received: from laptop.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4B06630001BB; Sat, 10 Oct 2026 13:37:45 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 shaju.abraham@nutanix.com, khushit.shah@nutanix.com,
 yangjinqian1@huawei.com, cohuck@redhat.com, richard.henderson@linaro.org,
 sebott@redhat.com, skolothumtho@nvidia.com, philmd@oss.qualcomm.com
Cc: maz@kernel.org, oliver.upton@linux.dev, pbonzini@redhat.com,
 armbru@redhat.com, berrange@redhat.com, abologna@redhat.com,
 jdenemar@redhat.com
Subject: [PATCH v10 03/26] target/arm: Enforce MPIDR into isar.idregs[] storage
Date: Sat, 10 Oct 2026 15:36:07 +0200
Message-ID: <20261010133725.642498-4-eric.auger@redhat.com>
In-Reply-To: <20261010133725.642498-1-eric.auger@redhat.com>
References: <20261010133725.642498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

At the moment MPIDR_EL1 has no real storage. Instead cpu
mp_affinity field stores the Aff0-Aff2 bits only and the
ID register is reconstructed when needed. There is also
an mp-affinity property used for TCG only.

Keep the mp-affinity property and its associated storage
while making sure the MPIDR_EL1 full register is stored
in cpu->isar.idregs[] as other ID registers.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
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
index dcdd4eb18e..639be0713e 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1128,7 +1128,13 @@ struct ArchCPU {
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
index 2f545482bc..bee74c0f94 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2174,6 +2174,23 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
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
index dfd71f1b51..36e8119f79 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3176,20 +3176,8 @@ static uint64_t midr_read(CPUARMState *env, const ARMCPRegInfo *ri)
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
index 3d905f8565..9d68801c26 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -2096,6 +2096,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
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


