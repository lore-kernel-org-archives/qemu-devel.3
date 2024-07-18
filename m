Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7EA0C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 23:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUadC-0007eO-GR; Thu, 18 Jul 2024 19:33:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sUaEv-0004GA-Uz
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 19:08:46 -0400
Received: from ma-mailsvcp-mx-lapp02.apple.com ([17.32.222.23])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danny_canter@apple.com>)
 id 1sUaEs-0003P5-CJ
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 19:08:45 -0400
Received: from rn-mailsvcp-mta-lapp03.rno.apple.com
 (rn-mailsvcp-mta-lapp03.rno.apple.com [10.225.203.151])
 by ma-mailsvcp-mx-lapp02.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SGU00E0PDE2OQ20@ma-mailsvcp-mx-lapp02.apple.com> for
 qemu-devel@nongnu.org; Thu, 18 Jul 2024 16:03:40 -0700 (PDT)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_16,2024-07-18_01,2024-05-17_01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=apple.com; h=cc :
 content-transfer-encoding : date : from : message-id : mime-version : subject
 : to; s=20180706; bh=xM2My2CpFSpxpZ8xvzGeWwjdqDBHcSSM+ehVHuofNi8=;
 b=Q08Et3u0R/qcObOWYhisRvJz0zSAosUWQMHT4KJeE3gi7WB6sHvbrohQazU9RxoOT/gg
 EI67e72cDdVtK6SAgZ4q7/3JrE8Hz6xO/He6t/IDqKRW767dseSFL7H8esJU3zKEiyIb
 HxbgdY1ewbL1w0UjJGMPMthHONFv0x2+HZObHHefl2UuCXZvtQboBwD3ovjOGwlGlnGu
 JdMqOYyhgg3do9HCmETdHeO9tnmJJ1iZ8WW+BocNNj/fKA4uJ3IHcjEs5do7eJDowhe+
 WXRkG7QQi3QXrcxSdcQFnhoFv+EMknOhvmddRSKx1zldHdgc9wEX6n69dQUFm8qii8Ux +A==
Received: from mr55p01nt-mmpp08.apple.com
 (mr55p01nt-mmpp08.apple.com [10.170.185.194])
 by rn-mailsvcp-mta-lapp03.rno.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPS id <0SGU00Q6PDDX8K30@rn-mailsvcp-mta-lapp03.rno.apple.com>; 
 Thu, 18 Jul 2024 16:03:33 -0700 (PDT)
Received: from process_milters-daemon.mr55p01nt-mmpp08.apple.com by
 mr55p01nt-mmpp08.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) id <0SGU29L00DAGGW00@mr55p01nt-mmpp08.apple.com>; Thu,
 18 Jul 2024 23:03:33 +0000 (GMT)
X-Va-A: 
X-Va-T-CD: 18a8a04ab20a1763aa377ff80017b310
X-Va-E-CD: 2613b8c8034cb5a61a04b6c668a29090
X-Va-R-CD: e78074632ef6ef6a13b96867e0c41d26
X-Va-ID: c30033a0-e304-4701-abfe-32522f9c9d6e
X-Va-CD: 0
X-V-A: 
X-V-T-CD: 18a8a04ab20a1763aa377ff80017b310
X-V-E-CD: 2613b8c8034cb5a61a04b6c668a29090
X-V-R-CD: e78074632ef6ef6a13b96867e0c41d26
X-V-ID: 3fbefbe6-9f83-4afe-b146-4b6a6fb34716
X-V-CD: 0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_16,2024-07-18_01,2024-05-17_01
Received: from mr41p01nt-relayp01.apple.com ([17.115.0.71])
 by mr55p01nt-mmpp08.apple.com
 (Oracle Communications Messaging Server 8.1.0.23.20230328 64bit (built Mar 28
 2023)) with ESMTPSA id <0SGU28Q88DDWK200@mr55p01nt-mmpp08.apple.com>; Thu,
 18 Jul 2024 23:03:33 +0000 (GMT)
From: Danny Canter <danny_canter@apple.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, agraf@csgraf.de,
 peter.maydell@linaro.org
Subject: [PATCH] hvf: arm: Allow creating VMs with > 63GB of RAM on macOS 15+
Date: Thu, 18 Jul 2024 16:00:31 -0700
Message-id: <20240718230031.69641-1-danny_canter@apple.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-151)
MIME-version: 1.0
Content-transfer-encoding: 8bit
Received-SPF: pass client-ip=17.32.222.23; envelope-from=danny_canter@apple.com;
 helo=ma-mailsvcp-mx-lapp02.apple.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jul 2024 19:33:49 -0400
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

This patch's main focus is to enable creating VMs with > 63GB
of RAM on Apple Silicon machines by using some new HVF APIs. In
pursuit of this a couple of things related to how we handle the
physical address range we expose to guests were altered:

The default IPA size on all Apple Silicon machines for HVF is
currently 36 bits. This bars making a VM with > 63GB (as RAM
starts at 1GB in the memory map) of RAM. Currently, to get the
IPA size we were reading id_aa64mmfr0_el1's PARange field
from a newly made vcpu. Unfortunately HVF just returns the
hosts PARange directly for the initial value and not the IPA
size that will actually back the VM, so we believe we have much
more address space than we actually do today it seems.

Starting in macOS 13.0 some APIs were introduced to be able to
query the maximum IPA size the kernel supports, and to set the IPA
size for a given VM. However, this still has a couple of issues
on < macOS 15. Up until macOS 15 (and if the hardware supported
it) the max IPA size was 39 bits which is not a valid PARange
value, so we can't clamp down what we advertise in the vcpu's
id_aa64mmfr0_el1 to our IPA size. Starting in macOS 15 however,
the maximum IPA size is 40 bits (if it's supported in the hardware
as well) which is also a valid PARange value, so we can set our IPA
size to the maximum as well as clamp down the PARange we advertise
to the guest. This allows VMs with 63+ GB of ram and should fix the
oddness of the PARange situation as well.

For the implementation of this I've decided to only bump the IPA
size if the amount of RAM requested is encroaching on the default IPA
size of 36 bits, as at 40 bits of IPA space we have to have one extra
level of stage2 page tables.

Signed-off-by: Danny Canter <danny_canter@apple.com>
Reviewed-by: Cameron Esfahani <dirty@apple.com>
---
 accel/hvf/hvf-accel-ops.c |   6 +-
 include/sysemu/hvf_int.h  |   1 +
 target/arm/hvf/hvf.c      | 113 ++++++++++++++++++++++++++++++++++++++
 target/arm/internals.h    |  19 +++++++
 target/arm/ptw.c          |  20 +++++++
 target/i386/hvf/hvf.c     |   5 ++
 6 files changed, 159 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-accel-ops.c b/accel/hvf/hvf-accel-ops.c
index ac08cfb9f3..aa9ea4489b 100644
--- a/accel/hvf/hvf-accel-ops.c
+++ b/accel/hvf/hvf-accel-ops.c
@@ -61,10 +61,6 @@
 
 HVFState *hvf_state;
 
-#ifdef __aarch64__
-#define HV_VM_DEFAULT NULL
-#endif
-
 /* Memory slots */
 
 hvf_slot *hvf_find_overlap_slot(uint64_t start, uint64_t size)
@@ -324,7 +320,7 @@ static int hvf_accel_init(MachineState *ms)
     hv_return_t ret;
     HVFState *s;
 
-    ret = hv_vm_create(HV_VM_DEFAULT);
+    ret = hvf_arch_vm_create(ms);
     assert_hvf_ok(ret);
 
     s = g_new0(HVFState, 1);
diff --git a/include/sysemu/hvf_int.h b/include/sysemu/hvf_int.h
index 5b28d17ba1..4a4bb4c768 100644
--- a/include/sysemu/hvf_int.h
+++ b/include/sysemu/hvf_int.h
@@ -65,6 +65,7 @@ void assert_hvf_ok_impl(hv_return_t ret, const char *file, unsigned int line,
 #define assert_hvf_ok(EX) assert_hvf_ok_impl((EX), __FILE__, __LINE__, #EX)
 const char *hvf_return_string(hv_return_t ret);
 int hvf_arch_init(void);
+hv_return_t hvf_arch_vm_create(MachineState *ms);
 int hvf_arch_init_vcpu(CPUState *cpu);
 void hvf_arch_vcpu_destroy(CPUState *cpu);
 int hvf_vcpu_exec(CPUState *);
diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index ef9bc42738..1d7f4750d4 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -10,6 +10,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/error-report.h"
 
 #include "sysemu/runstate.h"
@@ -23,6 +24,7 @@
 
 #include "exec/address-spaces.h"
 #include "hw/irq.h"
+#include "hw/boards.h"
 #include "qemu/main-loop.h"
 #include "sysemu/cpus.h"
 #include "arm-powerctl.h"
@@ -30,6 +32,7 @@
 #include "target/arm/internals.h"
 #include "target/arm/multiprocessing.h"
 #include "target/arm/gtimer.h"
+#include "target/arm/internals.h"
 #include "trace/trace-target_arm_hvf.h"
 #include "migration/vmstate.h"
 
@@ -295,6 +298,8 @@ void hvf_arm_init_debug(void)
 #define TMR_CTL_IMASK   (1 << 1)
 #define TMR_CTL_ISTATUS (1 << 2)
 
+#define FIRST_HIGHMEM_PARANGE 40
+
 static void hvf_wfi(CPUState *cpu);
 
 typedef struct HVFVTimer {
@@ -319,6 +324,8 @@ struct hvf_reg_match {
     uint64_t offset;
 };
 
+static uint32_t chosen_ipa_bit_size;
+
 static const struct hvf_reg_match hvf_reg_match[] = {
     { HV_REG_X0,   offsetof(CPUARMState, xregs[0]) },
     { HV_REG_X1,   offsetof(CPUARMState, xregs[1]) },
@@ -839,6 +846,45 @@ static uint64_t hvf_get_reg(CPUState *cpu, int rt)
     return val;
 }
 
+static uint32_t hvf_get_default_ipa_bit_size(void)
+{
+    uint32_t default_ipa_size = 36;
+#if defined(MAC_OS_VERSION_13_0) && \
+    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_13_0
+    hv_return_t ret = hv_vm_config_get_default_ipa_size(&default_ipa_size);
+    assert_hvf_ok(ret);
+#endif
+    return default_ipa_size;
+}
+
+static uint32_t hvf_get_max_ipa_bit_size(void)
+{
+    uint32_t max_ipa_size = hvf_get_default_ipa_bit_size();
+#if defined(MAC_OS_VERSION_13_0) && \
+    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_13_0
+    hv_return_t ret = hv_vm_config_get_max_ipa_size(&max_ipa_size);
+    assert_hvf_ok(ret);
+
+    /*
+     * We clamp any IPA size we want to back the VM with to a valid PARange
+     * value so the guest doesn't try and map memory outside of the valid range.
+     * This logic just clamps the passed in IPA bit size to the first valid
+     * PARange value <= to it.
+     */
+    max_ipa_size = round_down_to_parange_bit_size(max_ipa_size);
+#endif
+    return max_ipa_size;
+}
+
+static void clamp_id_aa64mmfr0_parange_to_ipa_size(uint64_t *id_aa64mmfr0)
+{
+    uint32_t ipa_size = chosen_ipa_bit_size ?
+            chosen_ipa_bit_size : hvf_get_max_ipa_bit_size();
+    /* Clamp down id_aa64mmfr0's PARange to the IPA size the kernel supports. */
+    uint8_t index = round_down_to_parange_index(ipa_size);
+    *id_aa64mmfr0 = (*id_aa64mmfr0 & ~R_ID_AA64MMFR0_PARANGE_MASK) | index;
+}
+
 static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
 {
     ARMISARegisters host_isar = {};
@@ -882,6 +928,8 @@ static bool hvf_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
     r |= hv_vcpu_get_sys_reg(fd, HV_SYS_REG_MIDR_EL1, &ahcf->midr);
     r |= hv_vcpu_destroy(fd);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&host_isar.id_aa64mmfr0);
+
     ahcf->isar = host_isar;
 
     /*
@@ -929,6 +977,66 @@ void hvf_arch_vcpu_destroy(CPUState *cpu)
 {
 }
 
+hv_return_t hvf_arch_vm_create(MachineState *ms)
+{
+    uint32_t default_ipa_size = hvf_get_default_ipa_bit_size();
+    uint32_t max_ipa_size = hvf_get_max_ipa_bit_size();
+    hv_return_t ret;
+
+    chosen_ipa_bit_size = default_ipa_size;
+
+    /*
+     * Set the IPA size for the VM:
+     *
+     * Starting from macOS 13 a new set of APIs were introduced that allow you
+     * to query for the maximum IPA size that is supported on your system. macOS
+     * 13 and 14's kernel both return a value less than 40 bits (typically 39,
+     * but depends on hardware), however starting in macOS 15 and up the IPA
+     * size supported (in the kernel at least) is up to 40 bits. A common scheme
+     * for attempting to get the IPA size prior to the introduction of these new
+     * APIs was to read ID_AA64MMFR0.PARange from a vcpu in the hopes that HVF
+     * was returning the maximum IPA size in that. However, this was not the
+     * case. HVF would return the host's PARange value directly which is
+     * generally larger than 40 bits.
+     *
+     * Using that value we could set up our memory map with regions much outside
+     * the actually supported IPA size, and also advertise a much larger
+     * physical address space to the guest. On the hardware+OS combos where
+     * the IPA size is less than 40 bits, but greater than 36, we also don't
+     * have a valid PARange value to round down to before 36 bits which is
+     * already the default.
+     *
+     * With that in mind, before we make the VM lets grab the maximum supported
+     * IPA size and clamp it down to the first valid PARange value so we can
+     * advertise the correct address size for the guest later on. Then if it's
+     * >= 40 set this as the IPA size for the VM using the new APIs. There's a
+     * small heuristic for actually altering the IPA size for the VM which is
+     * if our requested RAM is encroaching on the top of our default IPA size.
+     * This is just an optimization, as at 40 bits we need to create one more
+     * level of stage2 page tables.
+     */
+#if defined(MAC_OS_VERSION_13_0) && \
+    MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_13_0
+    hv_vm_config_t config = hv_vm_config_create();
+
+    /* In our memory map RAM starts at 1GB. */
+    uint64_t threshold = (1ull << default_ipa_size) - (1 * GiB);
+    if (ms->ram_size >= threshold && max_ipa_size >= FIRST_HIGHMEM_PARANGE) {
+        ret = hv_vm_config_set_ipa_size(config, max_ipa_size);
+        assert_hvf_ok(ret);
+
+        chosen_ipa_bit_size = max_ipa_size;
+    }
+
+    ret = hv_vm_create(config);
+    os_release(config);
+#else
+    ret = hv_vm_create(NULL);
+#endif
+
+    return ret;
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     ARMCPU *arm_cpu = ARM_CPU(cpu);
@@ -995,6 +1103,11 @@ int hvf_arch_init_vcpu(CPUState *cpu)
                               &arm_cpu->isar.id_aa64mmfr0);
     assert_hvf_ok(ret);
 
+    clamp_id_aa64mmfr0_parange_to_ipa_size(&arm_cpu->isar.id_aa64mmfr0);
+    ret = hv_vcpu_set_sys_reg(cpu->accel->fd, HV_SYS_REG_ID_AA64MMFR0_EL1,
+                              arm_cpu->isar.id_aa64mmfr0);
+    assert_hvf_ok(ret);
+
     return 0;
 }
 
diff --git a/target/arm/internals.h b/target/arm/internals.h
index da22d04121..3aa804bfe8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -436,6 +436,25 @@ static inline void update_spsel(CPUARMState *env, uint32_t imm)
  */
 unsigned int arm_pamax(ARMCPU *cpu);
 
+/*
+ * round_down_to_parange_index
+ * @bit_size: uint8_t
+ *
+ * Rounds down the bit_size supplied to the first supported ARM physical
+ * address range and returns the index for this. The index is intended to
+ * be used to set ID_AA64MMFR0_EL1's PARANGE bits.
+ */
+uint8_t round_down_to_parange_index(uint8_t bit_size);
+
+/*
+ * round_down_to_parange_bit_size
+ * @bit_size: uint8_t
+ *
+ * Rounds down the bit_size supplied to the first supported ARM physical
+ * address range bit size and returns this.
+ */
+uint8_t round_down_to_parange_bit_size(uint8_t bit_size);
+
 /* Return true if extended addresses are enabled.
  * This is always the case if our translation regime is 64 bit,
  * but depends on TTBCR.EAE for 32 bit.
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 4476b32ff5..c4abbe5c3d 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -96,6 +96,26 @@ static const uint8_t pamax_map[] = {
     [6] = 52,
 };
 
+uint8_t round_down_to_parange_index(uint8_t bit_size)
+{
+    for (int i = ARRAY_SIZE(pamax_map) - 1; i >= 0; i--) {
+        if (pamax_map[i] <= bit_size) {
+            return i;
+        }
+    }
+    g_assert_not_reached();
+}
+
+uint8_t round_down_to_parange_bit_size(uint8_t bit_size)
+{
+    for (int i = ARRAY_SIZE(pamax_map) - 1; i >= 0; i--) {
+        if (pamax_map[i] <= bit_size) {
+            return pamax_map[i];
+        }
+    }
+    g_assert_not_reached();
+}
+
 /*
  * The cpu-specific constant value of PAMax; also used by hw/arm/virt.
  * Note that machvirt_init calls this on a CPU that is inited but not realized!
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index c9c64e2978..99e1915efa 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -223,6 +223,11 @@ int hvf_arch_init(void)
     return 0;
 }
 
+hv_return_t hvf_arch_vm_create(MachineState *ms)
+{
+    return hv_vm_create(HV_VM_DEFAULT);
+}
+
 int hvf_arch_init_vcpu(CPUState *cpu)
 {
     X86CPU *x86cpu = X86_CPU(cpu);
-- 
2.39.5 (Apple Git-151)


