Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF27C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 06:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugdq3-00036i-63; Tue, 29 Jul 2025 02:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdpu-0002nO-Rx
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:29:20 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1ugdpn-0007gV-OZ
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 02:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753770551; x=1785306551;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lR/YY0/aX4syEVym2+itHRV8YlPReKbeqO9r091K3hk=;
 b=ASgCcKaiWgaK21WjtaoG4p02V5JK1E8STm55jEEO35x8BNxc081q/EJQ
 bwnnGQrec920eB9+biHEOqNCb74zrUWa14Yy6ORlHVf/gA1pZlL7M3ZFl
 LE7uSNcZAAqONPXc0JYE9jmGdELgUQ1kVnQ/I1LWc4UsdsQ5MfNNmLVNb
 twPdnhnj2q4Y/XtWQk51FLhdVC8IWqbmQbifJt2XpXP0bqLMnwTyH0wEB
 5M/GFT7tkiBjYRmDpWJgBRq8v8vVaSP6Xb/0lkluY8y4BH3CSiwEP6wI+
 JY9hNvOM3Hw10L52iUBHcOwSEqhXr6TqIRVTQgzPsTSGmr4NtPORxBowQ Q==;
X-CSE-ConnectionGUID: 7g9biKZZRRCdU9h4M1kc1Q==
X-CSE-MsgGUID: 5vRIjW3HR1KnFuu6R0sWtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11505"; a="59854973"
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="59854973"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2025 23:29:08 -0700
X-CSE-ConnectionGUID: T36iCGCIT9WOYuPdb8zdmQ==
X-CSE-MsgGUID: TnrKY6jOQ8ir4pUNpfDEFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,348,1744095600"; d="scan'208";a="162492678"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa006.fm.intel.com with ESMTP; 28 Jul 2025 23:29:07 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Xiaoyao Li <xiaoyao.li@intel.com>, Chenyi Qiang <chenyi.qiang@intel.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/2] i386/kvm: Get X86MachineState in kvm_arch_init() without
 the cast check
Date: Tue, 29 Jul 2025 14:20:13 +0800
Message-ID: <20250729062014.1669578-2-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729062014.1669578-1-xiaoyao.li@intel.com>
References: <20250729062014.1669578-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.12; envelope-from=xiaoyao.li@intel.com;
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

Commit 8f54bbd0b4d9 ("x86: Check for machine state object class before
typecasting it") added back the object_dynamic_cast() check before
casting MachineState to X86MachineState. And commit 035d1ef26565 ("i386:
Add ratelimit for bus locks acquired in guest") followed it.

The reason to check object_dynamic_cast(OBJECT(ms), TYPE_PC_MACHINE)
before commit 8f54bbd0b4d9 was that smm was not supported for microvm
machine at that time. But after commit 8f54bbd0b4d9, smm is supported
for all x86 machines (both pc and microvm). And since it's the
target-specifc implementation of kvm_arch_init() in target/i386/kvm/kvm.c,
I don't see how it would be called for other machines than x86machine,
and why the check of object_dynamic_cast() is needed.

Drop the object_dynamic_cast() check and simplify the code.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 369626f8c8d7..d145ad49e4e5 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -3230,6 +3230,7 @@ static int kvm_vm_enable_energy_msrs(KVMState *s)
 
 int kvm_arch_init(MachineState *ms, KVMState *s)
 {
+    X86MachineState *x86ms = X86_MACHINE(ms);
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
@@ -3311,8 +3312,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_SMM) &&
-        object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE) &&
-        x86_machine_is_smm_enabled(X86_MACHINE(ms))) {
+        x86_machine_is_smm_enabled(x86ms)) {
         smram_machine_done.notify = register_smram_listener;
         qemu_add_machine_init_done_notifier(&smram_machine_done);
     }
@@ -3326,18 +3326,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
-    if (object_dynamic_cast(OBJECT(ms), TYPE_X86_MACHINE)) {
-        X86MachineState *x86ms = X86_MACHINE(ms);
-
-        if (x86ms->bus_lock_ratelimit > 0) {
-            ret = kvm_vm_enable_bus_lock_exit(s);
-            if (ret < 0) {
-                return ret;
-            }
-            ratelimit_init(&bus_lock_ratelimit_ctrl);
-            ratelimit_set_speed(&bus_lock_ratelimit_ctrl,
-                                x86ms->bus_lock_ratelimit, BUS_LOCK_SLICE_TIME);
+    if (x86ms->bus_lock_ratelimit > 0) {
+        ret = kvm_vm_enable_bus_lock_exit(s);
+        if (ret < 0) {
+            return ret;
         }
+        ratelimit_init(&bus_lock_ratelimit_ctrl);
+        ratelimit_set_speed(&bus_lock_ratelimit_ctrl,
+                            x86ms->bus_lock_ratelimit, BUS_LOCK_SLICE_TIME);
     }
 
     if (kvm_check_extension(s, KVM_CAP_X86_NOTIFY_VMEXIT)) {
-- 
2.43.0


