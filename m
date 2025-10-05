Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD64CAC5B8
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 17:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5Si5-0001fS-IY; Sun, 05 Oct 2025 13:39:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sh7-0000rp-5U; Sun, 05 Oct 2025 13:38:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v5Sh0-0004h3-1h; Sun, 05 Oct 2025 13:38:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B17CC15AA94;
 Sun, 05 Oct 2025 20:37:31 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B38CA29973F;
 Sun,  5 Oct 2025 20:37:35 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.5 56/58] physmem: Destroy all CPU AddressSpaces on
 unrealize
Date: Sun,  5 Oct 2025 20:37:05 +0300
Message-ID: <20251005173712.445160-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
References: <qemu-stable-10.0.5-20251005203554@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

When we unrealize a CPU object (which happens on vCPU hot-unplug), we
should destroy all the AddressSpace objects we created via calls to
cpu_address_space_init() when the CPU was realized.

Commit 24bec42f3d6eae added a function to do this for a specific
AddressSpace, but did not add any places where the function was
called.

Since we always want to destroy all the AddressSpaces on unrealize,
regardless of the target architecture, we don't need to try to keep
track of how many are still undestroyed, or make the target
architecture code manually call a destroy function for each AS it
created.  Instead we can adjust the function to always completely
destroy the whole cpu->ases array, and arrange for it to be called
during CPU unrealize as part of the common code.

Without this fix, AddressSanitizer will report a leak like this
from a run where we hot-plugged and then hot-unplugged an x86 KVM
vCPU:

Direct leak of 416 byte(s) in 1 object(s) allocated from:
    #0 0x5b638565053d in calloc (/data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/qemu-system-x86_64+0x1ee153d) (BuildId: c1cd6022b195142106e1bffeca23498c2b752bca)
    #1 0x7c28083f77b1 in g_malloc0 (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x637b1) (BuildId: 1eb6131419edb83b2178b682829a6913cf682d75)
    #2 0x5b6386999c7c in cpu_address_space_init /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../system/physmem.c:797:25
    #3 0x5b638727f049 in kvm_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/kvm/kvm-cpu.c:102:5
    #4 0x5b6385745f40 in accel_cpu_common_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../accel/accel-common.c:101:13
    #5 0x5b638568fe3c in cpu_exec_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/cpu-common.c:232:10
    #6 0x5b63874a2cd5 in x86_cpu_realizefn /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../target/i386/cpu.c:9321:5
    #7 0x5b6387a0469a in device_set_realized /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:494:13
    #8 0x5b6387a27d9e in property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:2375:5
    #9 0x5b6387a2090b in object_property_set /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1450:5
    #10 0x5b6387a35b05 in object_property_set_qobject /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/qom-qobject.c:28:10
    #11 0x5b6387a21739 in object_property_set_bool /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../qom/object.c:1520:15
    #12 0x5b63879fe510 in qdev_realize /data_nvme1n1/linaro/qemu-from-laptop/qemu/build/x86-tgts-asan/../../hw/core/qdev.c:276:12

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2517
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Link: https://lore.kernel.org/r/20250929144228.1994037-4-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 300a87c502c4ba7ffc7720d8f3583e3d1a68348a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 9064dd24f8..51a3b84afd 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -248,6 +248,7 @@ void cpu_exec_unrealizefn(CPUState *cpu)
      * accel_cpu_common_unrealize, which may free fields using call_rcu.
      */
     accel_cpu_common_unrealize(cpu);
+    cpu_destroy_address_spaces(cpu);
 }
 
 static void cpu_common_initfn(Object *obj)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 3771b2130c..c48469c47b 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -132,13 +132,13 @@ size_t qemu_ram_pagesize_largest(void);
 void cpu_address_space_init(CPUState *cpu, int asidx,
                             const char *prefix, MemoryRegion *mr);
 /**
- * cpu_address_space_destroy:
- * @cpu: CPU for which address space needs to be destroyed
- * @asidx: integer index of this address space
+ * cpu_destroy_address_spaces:
+ * @cpu: CPU for which address spaces need to be destroyed
  *
- * Note that with KVM only one address space is supported.
+ * Destroy all address spaces associated with this CPU; this
+ * is called as part of unrealizing the CPU.
  */
-void cpu_address_space_destroy(CPUState *cpu, int asidx);
+void cpu_destroy_address_spaces(CPUState *cpu);
 
 void cpu_physical_memory_rw(hwaddr addr, void *buf,
                             hwaddr len, bool is_write);
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e136b067cd..2be01bcee9 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -500,7 +500,6 @@ struct CPUState {
     QSIMPLEQ_HEAD(, qemu_work_item) work_list;
 
     struct CPUAddressSpace *cpu_ases;
-    int cpu_ases_count;
     int num_ases;
     AddressSpace *as;
     MemoryRegion *memory;
diff --git a/stubs/cpu-destroy-address-spaces.c b/stubs/cpu-destroy-address-spaces.c
new file mode 100644
index 0000000000..dc6813f5bd
--- /dev/null
+++ b/stubs/cpu-destroy-address-spaces.c
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "exec/cpu-common.h"
+
+/*
+ * user-mode CPUs never create address spaces with
+ * cpu_address_space_init(), so the cleanup function doesn't
+ * need to do anything. We need this stub because cpu-common.c
+ * is built-once so it can't #ifndef CONFIG_USER around the
+ * call; the real function is in physmem.c which is system-only.
+ */
+void cpu_destroy_address_spaces(CPUState *cpu)
+{
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 63392f5e78..8b5387601f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -55,6 +55,7 @@ endif
 if have_user
   # Symbols that are used by hw/core.
   stub_ss.add(files('cpu-synchronize-state.c'))
+  stub_ss.add(files('cpu-destroy-address-spaces.c'))
 
   # Stubs for QAPI events.  Those can always be included in the build, but
   # they are not built at all for --disable-system builds.
diff --git a/system/physmem.c b/system/physmem.c
index 82d453ddde..0c2652c25a 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -765,7 +765,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
 
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
-        cpu->cpu_ases_count = cpu->num_ases;
     }
 
     newas = &cpu->cpu_ases[asidx];
@@ -779,30 +778,29 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
     }
 }
 
-void cpu_address_space_destroy(CPUState *cpu, int asidx)
+void cpu_destroy_address_spaces(CPUState *cpu)
 {
     CPUAddressSpace *cpuas;
+    int asidx;
 
     assert(cpu->cpu_ases);
-    assert(asidx >= 0 && asidx < cpu->num_ases);
 
-    cpuas = &cpu->cpu_ases[asidx];
-    if (tcg_enabled()) {
-        memory_listener_unregister(&cpuas->tcg_as_listener);
-    }
+    /* convenience alias just points to some cpu_ases[n] */
+    cpu->as = NULL;
 
-    address_space_destroy(cpuas->as);
-    g_free_rcu(cpuas->as, rcu);
-
-    if (asidx == 0) {
-        /* reset the convenience alias for address space 0 */
-        cpu->as = NULL;
+    for (asidx = 0; asidx < cpu->num_ases; asidx++) {
+        cpuas = &cpu->cpu_ases[asidx];
+        if (!cpuas->as) {
+            /* This index was never initialized; no deinit needed */
+            continue;
+        }
+        if (tcg_enabled()) {
+            memory_listener_unregister(&cpuas->tcg_as_listener);
+        }
+        g_clear_pointer(&cpuas->as, address_space_destroy_free);
     }
 
-    if (--cpu->cpu_ases_count == 0) {
-        g_free(cpu->cpu_ases);
-        cpu->cpu_ases = NULL;
-    }
+    g_clear_pointer(&cpu->cpu_ases, g_free);
 }
 
 AddressSpace *cpu_get_address_space(CPUState *cpu, int asidx)
-- 
2.47.3


