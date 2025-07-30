Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E53C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Jul 2025 10:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uh3hO-0003Ph-NS; Wed, 30 Jul 2025 06:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3dF-0000TB-04
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:01:57 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uh3dC-0000FJ-F9
 for qemu-devel@nongnu.org; Wed, 30 Jul 2025 06:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753869715; x=1785405715;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Y6M6uvXpm5pvNX5pUHPI2otQ236JV24CqfUnRxkb3XA=;
 b=n3iJTFprzSRlQrG2e4bWLx5g65iZXpGYIpy0L2ENNSU7pxpw5M3AWFI1
 2jgMATnmomS1gcyzRo4qQFXGuCZfE/2iE/9exG8oi3e1SdECkzf4Yyj5O
 p7tONt/FsthkmyJCQwXGy2Wmj7vNz1gFS7du/RPxxuQ1Kuwb3z7A9cqrf
 VXMcOCZLZlWq+zszDkN7RJbkQrfYK6LqhSEZbVRQoakO318uBFOfeoGmS
 1XggDvkHL83GOLPEtvtSzMLOLUkrdTminPTIxATIyKXUJLljqAm2X671S
 Bpk0BRRysWKfopr3+EjU36Uxuy+cWdAnTnHRQyEUohEZEbhm7nTNbVm5T Q==;
X-CSE-ConnectionGUID: ghcvOItGS1at29C2gPRrpQ==
X-CSE-MsgGUID: tp2wFPd8TEempBi07FQ2Eg==
X-IronPort-AV: E=McAfee;i="6800,10657,11506"; a="59992077"
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="59992077"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2025 03:01:51 -0700
X-CSE-ConnectionGUID: lIo1hytZRpSP6Q2bN1iSyw==
X-CSE-MsgGUID: OVMhUu00SdCrzvL8VVrDUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,350,1744095600"; d="scan'208";a="162971746"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa007.jf.intel.com with ESMTP; 30 Jul 2025 03:01:49 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v2 1/2] i386/cpu: Enable SMM cpu address space under KVM
Date: Wed, 30 Jul 2025 17:52:52 +0800
Message-ID: <20250730095253.1833411-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250730095253.1833411-1-xiaoyao.li@intel.com>
References: <20250730095253.1833411-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.244, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
---
Changes in v2:
- fix the typos; (Philippe)
---
 system/physmem.c          |  5 -----
 target/i386/kvm/kvm-cpu.c | 10 ++++++++++
 target/i386/kvm/kvm.c     |  5 +++++
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 130c148ffb5c..76e1c33aab5c 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -795,9 +795,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
         cpu->as = as;
     }
 
-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
-
     if (!cpu->cpu_ases) {
         cpu->cpu_ases = g_new0(CPUAddressSpace, cpu->num_ases);
         cpu->cpu_ases_count = cpu->num_ases;
@@ -820,8 +817,6 @@ void cpu_address_space_destroy(CPUState *cpu, int asidx)
 
     assert(cpu->cpu_ases);
     assert(asidx >= 0 && asidx < cpu->num_ases);
-    /* KVM cannot currently support multiple address spaces. */
-    assert(asidx == 0 || !kvm_enabled());
 
     cpuas = &cpu->cpu_ases[asidx];
     if (tcg_enabled()) {
diff --git a/target/i386/kvm/kvm-cpu.c b/target/i386/kvm/kvm-cpu.c
index 89a795365945..1dc1ba9b4869 100644
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
index 369626f8c8d7..47fb5c673c8e 100644
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
2.43.0


