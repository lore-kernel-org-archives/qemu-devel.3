Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8701FCFC50C
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 04:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdTr-0007Nj-Sg; Fri, 21 Nov 2025 21:36:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdTJ-0006pp-1S; Fri, 21 Nov 2025 21:35:46 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vMdSK-0000vR-Uo; Fri, 21 Nov 2025 21:35:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D144916C6F0;
 Fri, 21 Nov 2025 16:51:55 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 34C6432198D;
 Fri, 21 Nov 2025 16:52:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Xiaoyao Li <xiaoyao.li@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.3 24/76] i386/kvm/cpu: Init SMM cpu address space for
 hotplugged CPUs
Date: Fri, 21 Nov 2025 16:51:02 +0300
Message-ID: <20251121135201.1114964-24-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
References: <qemu-stable-10.1.3-20251121155857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The SMM cpu address space is initialized in a machine_init_done
notifier. It only runs once when QEMU starts up, which leads to the
issue that for any hotplugged CPU after the machine is ready, SMM
cpu address space doesn't get initialized.

Fix the issue by initializing the SMM cpu address space in x86_cpu_plug()
when the cpu is hotplugged.

Fixes: 591f817d819f ("target/i386: Define enum X86ASIdx for x86's address spaces")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Closes: https://lore.kernel.org/qemu-devel/CAFEAcA_3kkZ+a5rTZGmK8W5K6J7qpYD31HkvjBnxWr-fGT2h_A@mail.gmail.com/
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Link: https://lore.kernel.org/r/20251014094216.164306-2-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit 639a29422754f62b4bfd26cff936b3c981758010)
(Mjt: the original Fixes: line is wrong:
 https://lore.kernel.org/qemu-devel/57d3c5b2-8b07-41ee-bf41-a9eac16eb6da@intel.com/T/#u )
Fixes: 0516f4b70264 ("i386/cpu: Enable SMM cpu address space under KVM")
Fixes: 6130ab24d03e ("i386/cpu: Enable SMM cpu address space under KVM"), 10.1.1
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index b1b5f11e73..4b14be98c2 100644
--- a/hw/i386/x86-common.c
+++ b/hw/i386/x86-common.c
@@ -183,6 +183,17 @@ void x86_cpu_plug(HotplugHandler *hotplug_dev,
         fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
     }
 
+    /*
+     * Non-hotplugged CPUs get their SMM cpu address space initialized in
+     * machine init done notifier: register_smram_listener().
+     *
+     * We need initialize the SMM cpu address space for the hotplugged CPU
+     * specifically.
+     */
+    if (kvm_enabled() && dev->hotplugged && x86_machine_is_smm_enabled(x86ms)) {
+        kvm_smm_cpu_address_space_init(cpu);
+    }
+
     found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
     found_cpu->cpu = CPU(dev);
 out:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7a62eb728e..994b9712a8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2748,6 +2748,12 @@ static void register_smram_listener(Notifier *n, void *unused)
     }
 }
 
+/* It should only be called in cpu's hotplug callback */
+void kvm_smm_cpu_address_space_init(X86CPU *cpu)
+{
+    cpu_address_space_init(CPU(cpu), X86ASIdx_SMM, "cpu-smm", &smram_as_root);
+}
+
 static void *kvm_msr_energy_thread(void *data)
 {
     KVMState *s = data;
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 5f83e8850a..35017ba07a 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -74,6 +74,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
 
+void kvm_smm_cpu_address_space_init(X86CPU *cpu);
 void kvm_pc_setup_irq_routing(bool pci_enabled);
 
 #endif
-- 
2.47.3


