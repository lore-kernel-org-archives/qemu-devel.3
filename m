Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB567CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23dC-0006kQ-Uc; Fri, 26 Sep 2025 04:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23d9-0006hW-Ds; Fri, 26 Sep 2025 04:16:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23cw-0001o0-FK; Fri, 26 Sep 2025 04:16:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4B699157D73;
 Fri, 26 Sep 2025 11:10:34 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 59821290C57;
 Fri, 26 Sep 2025 11:10:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 43/60] i386/cpu: Enable SMM cpu address space under KVM
Date: Fri, 26 Sep 2025 11:10:11 +0300
Message-ID: <20250926081031.2214971-43-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Kirill Martynov reported assertation in cpu_asidx_from_attrs() being hit
when x86_cpu_dump_state() is called to dump the CPU state[*]. It happens
when the CPU is in SMM and KVM emulation failure due to misbehaving
guest.

The root cause is that QEMU i386 never enables the SMM address space for
cpu since KVM SMM support has been added.

Enable the SMM cpu address space under KVM when the SMM is enabled for
the x86machine.

[*] https://lore.kernel.org/qemu-devel/20250523154431.506993-1-stdcalllevi@yandex-team.ru/

Reported-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Tested-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20250730095253.1833411-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 0516f4b70264b9710a25718d21bd35ef463c875e)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/system/physmem.c b/system/physmem.c
index e5dd760e0b..8705fadc01 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -793,9 +793,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
         cpu->as = as;
     }
 
-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
-
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
         cpu->cpu_ases_count = cpu->num_ases;
@@ -818,8 +815,6 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx)
 
     assert(cpu->cpu_ases);
     assert(asidx >= 0 && asidx < cpu->num_ases);
-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
 
     cpuas = &cpu->cpu_ases[asidx];
     if (tcg_enabled()) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 89a7953659..1dc1ba9b48 100644
--- a/target/i386/kvm/kvm-cpu.c
+++ b/target/i386/kvm/kvm-cpu.c
@@ -13,6 +13,7 @@
 #include "qapi/error.h"
 #include "system/system.h"
 #include "hw/boards.h"
+#include "hw/i386/x86.h"
 
 #include "kvm_i386.h"
 #include "accel/accel-cpu-target.h"
@@ -91,6 +92,15 @@ static bool kvm_cpu_realizefn(CPUState *cs, Error **errp)
         kvm_set_guest_phys_bits(cs);
     }
 
+    /*
+     * When SMM is enabled, there is 2 address spaces. Otherwise only 1.
+     *
+     * Only initialize address space 0 here, the second one for SMM is
+     * initialized at register_smram_listener() after machine init done.
+     */
+    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
+    cpu_address_space_init(cs, 0, "cpu-memory", cs->memory);
+
     return true;
 }
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8..47fb5c673c 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2704,6 +2704,7 @@ static MemoryRegion smram_as_mem;
 
 static void register_smram_listener(Notifier *n, void *unused)
 {
+    CPUState *cpu;
     MemoryRegion *smram =
         (MemoryRegion *) object_resolve_path("/machine/smram", NULL);
 
@@ -2728,6 +2729,10 @@ static void register_smram_listener(Notifier *n, void *unused)
     address_space_init(&smram_address_space, &smram_as_root, "KVM-SMRAM");
     kvm_memory_listener_register(kvm_state, &smram_listener,
                                  &smram_address_space, 1, "kvm-smram");
+
+    CPU_FOREACH(cpu) {
+        cpu_address_space_init(cpu, 1, "cpu-smm", &smram_as_root);
+    }
 }
 
 static void *kvm_msr_energy_thread(void *data)
-- 
2.47.3


