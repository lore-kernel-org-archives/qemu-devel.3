Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFA6D3A66C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 15:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5nsJ-0000zd-IO; Tue, 29 Oct 2024 11:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nry-0000Yu-1b
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t5nrv-0007fH-NX
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 11:10:53 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4315baa51d8so55048985e9.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 08:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730214650; x=1730819450; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z8dIBl0LkJCTyUes6NYbmKBhyJ1/0+z//5T4D7y2AdY=;
 b=lD/XU1IlpRIo2uIp7m5sY6Uty78AmR3GrHsDXALyOnicqhMVGEAPMjMhtzItgmkrjA
 G5JEShzYVRighC82plMp7dm1XNZqu4BPjD4H/EGsF+N6RmrcCAVPmvSdnCnOwBFJ5CPa
 k2rw0g5KkBFmBRCh/U1882pLtYJLvlx/cmb7f+R7G1zjsRdx8AIgZwQ4vaGjkVBLfhkn
 HMWf3aLusYP78t9lFTZDVD0t4pj/KWdmS4pPsoy99tJBvl/nsVtxIoR0ePoxwUVUC0v6
 ngh1tqyPHAP+Osj0rPzm55rCkdbTANnnz+bg7KDSVkch+zyD4RXhnIpE5QFpoZkYDS3N
 hAEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730214650; x=1730819450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z8dIBl0LkJCTyUes6NYbmKBhyJ1/0+z//5T4D7y2AdY=;
 b=jPnEYexWPLWhv1Aihhbdu/Zq/YnOekkrATuT2Eo7djGLU1dJsQP94uVi27PaXeDIYn
 dTqFy9g0KGgY3+KFwcsYlXB0fz68r5l9AUyucFnKfHNRd5oHfZ4cDerq1RMvFEhbQx++
 RRRkP8KvKg1srbNVmtsmEHb4zK4o4YP26cPts6xJ0LIzaOpSgxV25fOgtxbo3ch9AmH8
 sQaEsLrXkxfZ4ZSbZ0EVWPRM6ZaQ3drUhvcQE2hj8DXd9SEq7W4rI8DkRv9YONsFjp21
 6oJ0gVrQVZ1cPgi6VVkLKlOq4v5m6Gniiv+BDlusL3LQsdIj75LzwdYiXCoSQbmk82rc
 d7oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPSb0tkrZy5bAV4idrSUnuaMeK+dki9LmonOCzb7eUbMjIW/+xk9gM2c+bxG1O5ozPeAYBDsUN1iD7@nongnu.org
X-Gm-Message-State: AOJu0YyiTdqScbF0DGwDyIzEYow1BHR/PS/7m6TmQ43D5zZ93TOX+k5L
 IoqNXGA99XfFMvW+X3S6ajxFKeXpEipAPiufi/shSNxsgl6Pr/1d7ONRmZe2APY=
X-Google-Smtp-Source: AGHT+IG9T8yLyHTsSA5x4CAUjPjWegyBafneSqG7lWEoRz7Qsu1aWcBfP8hpmL7a6TwWAlrz9xEM2g==
X-Received: by 2002:a05:600c:1989:b0:42c:b52b:4335 with SMTP id
 5b1f17b1804b1-4319aca40d9mr110502665e9.10.1730214650173; 
 Tue, 29 Oct 2024 08:10:50 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4319360cc2esm146835865e9.44.2024.10.29.08.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 08:10:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PULL 01/18] arm/kvm: add support for MTE
Date: Tue, 29 Oct 2024 15:10:31 +0000
Message-Id: <20241029151048.1047247-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029151048.1047247-1-peter.maydell@linaro.org>
References: <20241029151048.1047247-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Cornelia Huck <cohuck@redhat.com>

Extend the 'mte' property for the virt machine to cover KVM as
well. For KVM, we don't allocate tag memory, but instead enable
the capability.

If MTE has been enabled, we need to disable migration, as we do not
yet have a way to migrate the tags as well. Therefore, MTE will stay
off with KVM unless requested explicitly.

[gankulkarni: This patch is rework of commit b320e21c48
which broke TCG since it made the TCG -cpu max
report the presence of MTE to the guest even if the board hadn't
enabled MTE by wiring up the tag RAM. This meant that if the guest
then tried to use MTE QEMU would segfault accessing the
non-existent tag RAM.]

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Message-id: 20241008114302.4855-1-gankulkarni@os.amperecomputing.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h     |  2 ++
 target/arm/kvm_arm.h | 19 +++++++++++
 hw/arm/virt.c        | 76 +++++++++++++++++++++++++-------------------
 target/arm/cpu.c     | 14 ++++++--
 target/arm/kvm.c     | 58 +++++++++++++++++++++++++++++++++
 5 files changed, 134 insertions(+), 35 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index f065756c5c7..8fc8b6398f7 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -922,6 +922,8 @@ struct ArchCPU {
 
     /* CPU has memory protection unit */
     bool has_mpu;
+    /* CPU has MTE enabled in KVM mode */
+    bool kvm_mte;
     /* PMSAv7 MPU number of supported regions */
     uint32_t pmsav7_dregion;
     /* PMSAv8 MPU number of supported hyp regions */
diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
index cfaa0d9bc71..4d293618a78 100644
--- a/target/arm/kvm_arm.h
+++ b/target/arm/kvm_arm.h
@@ -188,6 +188,13 @@ bool kvm_arm_pmu_supported(void);
  */
 bool kvm_arm_sve_supported(void);
 
+/**
+ * kvm_arm_mte_supported:
+ *
+ * Returns: true if KVM can enable MTE, and false otherwise.
+ */
+bool kvm_arm_mte_supported(void);
+
 /**
  * kvm_arm_get_max_vm_ipa_size:
  * @ms: Machine state handle
@@ -214,6 +221,8 @@ void kvm_arm_pvtime_init(ARMCPU *cpu, uint64_t ipa);
 
 int kvm_arm_set_irq(int cpu, int irqtype, int irq, int level);
 
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp);
+
 #else
 
 /*
@@ -235,6 +244,11 @@ static inline bool kvm_arm_sve_supported(void)
     return false;
 }
 
+static inline bool kvm_arm_mte_supported(void)
+{
+    return false;
+}
+
 /*
  * These functions should never actually be called without KVM support.
  */
@@ -283,6 +297,11 @@ static inline uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
     g_assert_not_reached();
 }
 
+static inline void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    g_assert_not_reached();
+}
+
 #endif
 
 #endif
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 8b2b991d978..1a381e9a2bd 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2213,7 +2213,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->mte && (kvm_enabled() || hvf_enabled())) {
+    if (vms->mte && hvf_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "MTE to the guest CPU",
                      current_accel_name());
@@ -2283,39 +2283,51 @@ static void machvirt_init(MachineState *machine)
         }
 
         if (vms->mte) {
-            /* Create the memory region only once, but link to all cpus. */
-            if (!tag_sysmem) {
-                /*
-                 * The property exists only if MemTag is supported.
-                 * If it is, we must allocate the ram to back that up.
-                 */
-                if (!object_property_find(cpuobj, "tag-memory")) {
-                    error_report("MTE requested, but not supported "
-                                 "by the guest CPU");
+            if (tcg_enabled()) {
+                /* Create the memory region only once, but link to all cpus. */
+                if (!tag_sysmem) {
+                    /*
+                     * The property exists only if MemTag is supported.
+                     * If it is, we must allocate the ram to back that up.
+                     */
+                    if (!object_property_find(cpuobj, "tag-memory")) {
+                        error_report("MTE requested, but not supported "
+                                     "by the guest CPU");
+                        exit(1);
+                    }
+
+                    tag_sysmem = g_new(MemoryRegion, 1);
+                    memory_region_init(tag_sysmem, OBJECT(machine),
+                                       "tag-memory", UINT64_MAX / 32);
+
+                    if (vms->secure) {
+                        secure_tag_sysmem = g_new(MemoryRegion, 1);
+                        memory_region_init(secure_tag_sysmem, OBJECT(machine),
+                                           "secure-tag-memory",
+                                           UINT64_MAX / 32);
+
+                        /* As with ram, secure-tag takes precedence over tag. */
+                        memory_region_add_subregion_overlap(secure_tag_sysmem,
+                                                            0, tag_sysmem, -1);
+                    }
+                }
+
+                object_property_set_link(cpuobj, "tag-memory",
+                                         OBJECT(tag_sysmem), &error_abort);
+                if (vms->secure) {
+                    object_property_set_link(cpuobj, "secure-tag-memory",
+                                             OBJECT(secure_tag_sysmem),
+                                             &error_abort);
+                }
+            } else if (kvm_enabled()) {
+                if (!kvm_arm_mte_supported()) {
+                    error_report("MTE requested, but not supported by KVM");
                     exit(1);
                 }
-
-                tag_sysmem = g_new(MemoryRegion, 1);
-                memory_region_init(tag_sysmem, OBJECT(machine),
-                                   "tag-memory", UINT64_MAX / 32);
-
-                if (vms->secure) {
-                    secure_tag_sysmem = g_new(MemoryRegion, 1);
-                    memory_region_init(secure_tag_sysmem, OBJECT(machine),
-                                       "secure-tag-memory", UINT64_MAX / 32);
-
-                    /* As with ram, secure-tag takes precedence over tag.  */
-                    memory_region_add_subregion_overlap(secure_tag_sysmem, 0,
-                                                        tag_sysmem, -1);
-                }
-            }
-
-            object_property_set_link(cpuobj, "tag-memory", OBJECT(tag_sysmem),
-                                     &error_abort);
-            if (vms->secure) {
-                object_property_set_link(cpuobj, "secure-tag-memory",
-                                         OBJECT(secure_tag_sysmem),
-                                         &error_abort);
+                kvm_arm_enable_mte(cpuobj, &error_abort);
+            } else {
+                    error_report("MTE requested, but not supported ");
+                    exit(1);
             }
         }
 
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 1320fd8c8fe..5b751439bdc 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2390,14 +2390,22 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
 
 #ifndef CONFIG_USER_ONLY
         /*
-         * If we do not have tag-memory provided by the machine,
-         * reduce MTE support to instructions enabled at EL0.
+         * If we run with TCG and do not have tag-memory provided by
+         * the machine, then reduce MTE support to instructions enabled at EL0.
          * This matches Cortex-A710 BROADCASTMTE input being LOW.
          */
-        if (cpu->tag_memory == NULL) {
+        if (tcg_enabled() && cpu->tag_memory == NULL) {
             cpu->isar.id_aa64pfr1 =
                 FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 1);
         }
+
+        /*
+         * If MTE is supported by the host, however it should not be
+         * enabled on the guest (i.e mte=off), clear guest's MTE bits."
+         */
+        if (kvm_enabled() && !cpu->kvm_mte) {
+                FIELD_DP64(cpu->isar.id_aa64pfr1, ID_AA64PFR1, MTE, 0);
+        }
 #endif
     }
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index f1f1b5b375a..000afa03631 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -39,6 +39,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/ghes.h"
 #include "target/arm/gtimer.h"
+#include "migration/blocker.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -119,6 +120,21 @@ bool kvm_arm_create_scratch_host_vcpu(const uint32_t *cpus_to_try,
     if (vmfd < 0) {
         goto err;
     }
+
+    /*
+     * The MTE capability must be enabled by the VMM before creating
+     * any VCPUs in order to allow the MTE bits of the ID_AA64PFR1
+     * register to be probed correctly, as they are masked if MTE
+     * is not enabled.
+     */
+    if (kvm_arm_mte_supported()) {
+        KVMState kvm_state;
+
+        kvm_state.fd = kvmfd;
+        kvm_state.vmfd = vmfd;
+        kvm_vm_enable_cap(&kvm_state, KVM_CAP_ARM_MTE, 0);
+    }
+
     cpufd = ioctl(vmfd, KVM_CREATE_VCPU, 0);
     if (cpufd < 0) {
         goto err;
@@ -1793,6 +1809,11 @@ bool kvm_arm_sve_supported(void)
     return kvm_check_extension(kvm_state, KVM_CAP_ARM_SVE);
 }
 
+bool kvm_arm_mte_supported(void)
+{
+    return kvm_check_extension(kvm_state, KVM_CAP_ARM_MTE);
+}
+
 QEMU_BUILD_BUG_ON(KVM_ARM64_SVE_VQ_MIN != 1);
 
 uint32_t kvm_arm_sve_get_vls(ARMCPU *cpu)
@@ -2417,3 +2438,40 @@ int kvm_arch_remove_sw_breakpoint(CPUState *cs, struct kvm_sw_breakpoint *bp)
     }
     return 0;
 }
+
+void kvm_arm_enable_mte(Object *cpuobj, Error **errp)
+{
+    static bool tried_to_enable;
+    static bool succeeded_to_enable;
+    Error *mte_migration_blocker = NULL;
+    ARMCPU *cpu = ARM_CPU(cpuobj);
+    int ret;
+
+    if (!tried_to_enable) {
+        /*
+         * MTE on KVM is enabled on a per-VM basis (and retrying doesn't make
+         * sense), and we only want a single migration blocker as well.
+         */
+        tried_to_enable = true;
+
+        ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_ARM_MTE, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret, "Failed to enable KVM_CAP_ARM_MTE");
+            return;
+        }
+
+        /* TODO: Add migration support with MTE enabled */
+        error_setg(&mte_migration_blocker,
+                   "Live migration disabled due to MTE enabled");
+        if (migrate_add_blocker(&mte_migration_blocker, errp)) {
+            error_free(mte_migration_blocker);
+            return;
+        }
+
+        succeeded_to_enable = true;
+    }
+
+    if (succeeded_to_enable) {
+        cpu->kvm_mte = true;
+    }
+}
-- 
2.34.1


