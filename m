Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7612CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:52:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8bgh-0004g4-62; Tue, 14 Oct 2025 05:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v8bgc-0004fu-D6
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:18 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1v8bgY-0005WO-Gt
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:51:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760435475; x=1791971475;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lsd+HeGJLyHTmOx/FJA4TEA9vcuzEdjoafp24cU5pqM=;
 b=DPEGwck05UaiiV3aXZ3c7tgx2shgafiB7jDNs6Yuh3hn5chc/fSyk1NJ
 ODMrqaViMWHnm7s+LUnEVIV8KPBigShpgIWQgH2fOkAPyETBcsN6xXa+3
 oPT9DBb1s9SubAIUdobFzD4I8BJxxgXal9qoI5hw5J8JIELo8pYoHate2
 DwSW8PsYEgOdkYblssLSBz/xU0OepYiqEzS+ThTF7Q1F7HQLVF8wgGuyY
 vBlHkKv3EaIcTxt8Ve/vRqNNLF5Dmrzk2rw/ZLptGAxcluRWOlOlcDhGc
 yQKRWsrk1hiIldCK9opgx5s6bODnQ2pYZHflI0/DOagqfbB2JoDhIBjYC Q==;
X-CSE-ConnectionGUID: YZrrFValQSKUYfTN98e7Ig==
X-CSE-MsgGUID: P3oEJ97bT8CswOag0Oigmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="61627805"
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="61627805"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 02:51:10 -0700
X-CSE-ConnectionGUID: vx58wDbAQfG1Oi5h7p5mJw==
X-CSE-MsgGUID: m+zOQqRtRyKFobd25ioK0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,227,1754982000"; d="scan'208";a="181068415"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.22])
 by orviesa010.jf.intel.com with ESMTP; 14 Oct 2025 02:51:08 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH 1/2] i386/kvm/cpu: Init SMM cpu address space for hotplugged
 CPUs
Date: Tue, 14 Oct 2025 17:42:14 +0800
Message-ID: <20251014094216.164306-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014094216.164306-1-xiaoyao.li@intel.com>
References: <20251014094216.164306-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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
---
 hw/i386/x86-common.c       | 11 +++++++++++
 target/i386/kvm/kvm.c      |  6 ++++++
 target/i386/kvm/kvm_i386.h |  1 +
 3 files changed, 18 insertions(+)

diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
index 7512be64d67b..dd6ac3f3b741 100644
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
+    if (dev->hotplugged && kvm_enabled() && x86_machine_is_smm_enabled(x86ms)) {
+        kvm_smm_cpu_address_space_init(cpu);
+    }
+
     found_cpu = x86_find_cpu_slot(MACHINE(x86ms), cpu->apic_id, NULL);
     found_cpu->cpu = CPU(dev);
 out:
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index db40caa3412f..c339d8c84434 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2731,6 +2731,12 @@ static void register_smram_listener(Notifier *n, void *unused)
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
index 5f83e8850a2b..35017ba07a4a 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -74,6 +74,7 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
                              uint32_t cpuid_i);
 #endif /* CONFIG_KVM */
 
+void kvm_smm_cpu_address_space_init(X86CPU *cpu);
 void kvm_pc_setup_irq_routing(bool pci_enabled);
 
 #endif
-- 
2.43.0


