Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015B6C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 05:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdDc-0001HW-8S; Tue, 29 Jul 2025 01:49:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdDH-00019z-Rg
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 01:49:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdDD-0003Nr-T8
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 01:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753768161; x=1785304161;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GOKCYwx2RCr4doGpQ8AsUnhu6AiGN6L25y/R/eRMdB0=;
 b=DLSHfjnAsu0KP+zA22Fm75uGJVrkpLKv//QGg8ax8cDyNdwpHEy5rVVk
 VHFUfBtZ+jiOIUIPKyKGOYXIwRYYgdkBq79P0thsundh3puXNVXT4pQGj
 djDiEy3cvj2AHsN1Q8LBZZM3RoJ+A9ED5F3sUqHY8p4hmqmdh+pUvrEOP
 FaElFw+OCBoQb71eoyD48SV24qmW3hHMavwe3W4GhkhJyUEylWhOcDpb1
 byAHt7aUeDl8Q3QDQ0iQWaU2AZeiOCKSpy9CQXFTqkEzP44oNPE6YH3kj
 XA3v0fAok8nzAqJNMI/b2ydoXdSclj2+wbGInOKTwtT5DO6l1eQnXQsJ+ w==;
X-CSE-ConnectionGUID: 9k13LGguSEukXtSojEdnuA==
X-CSE-MsgGUID: zb5ymlvxSlyIi34BXP2esA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="55907952"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="55907952"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 22:49:19 -0700
X-CSE-ConnectionGUID: J+h27KwuSxCo+urtlPbQrA==
X-CSE-MsgGUID: /tHy06PwQqmP/Rz1izKTkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="199750964"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa001.jf.intel.com with ESMTP; 28 Jul 2025 22:49:16 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Kirill Martynov <stdcalllevi@yandex-team.ru>,
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/2] i386/cpu: Enable SMM cpu addressspace
Date: Tue, 29 Jul 2025 13:40:22 +0800
Message-ID: <20250729054023.1668443-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729054023.1668443-1-xiaoyao.li@intel.com>
References: <20250729054023.1668443-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.21; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.299, RCVD_IN_DNSWL_MED=-2.3,
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

The root cause is that QEMU i386 never enables the SMM addressspace for cpu
since kvm SMM support has been added.

Enable the SMM cpu address space under KVM when the SMM is enabled for
the x86machine.

[*] https://lore.kernel.org/qemu-devel/20250523154431.506993-1-stdcalllevi@yandex-team.ru/

Reported-by: Kirill Martynov <stdcalllevi@yandex-team.ru>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
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
index 89a795365945..aa657c2a4627 100644
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
+     * Only init address space 0 here, the second one for SMM is initialized at
+     * register_smram_listener() after machine init done.
+     */
+    cs->num_ases = x86_machine_is_smm_enabled(X86_MACHINE(current_machine)) ? 2 : 1;
+    cpu_address_space_init(cs, 0, "cpu-mmeory", cs->memory);
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


