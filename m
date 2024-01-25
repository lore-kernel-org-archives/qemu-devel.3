Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9F67C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqPn-00039c-Pr; Wed, 24 Jan 2024 22:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqPl-00038u-Or
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:28:29 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqPj-0001Dr-VV
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:28:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153308; x=1737689308;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qWOj2eQbQqTTvHD6HtJwRO1jTfYXQp1i9dIrNkCuZCA=;
 b=N7LguVZpx/kQRQKCkkFmgXHCM+FQIxusIXdXDVjAThCL8URCYSZAMi9K
 pDcznht0WDaJnxWNpkZuEBHW6r4Wia4y0tTvmI9O1lny/F4JsunR7Lgzi
 zCzUilrXCw+RsnQ+Dz9+fL0mXNYy6zZby+2t8Fiv/reP2p/EUgmPD082M
 9VtTBCcBbmXcvHwQPXzPodd1gF2eLFY3c9OGYvwY6bh4P18LoFtv4JPcN
 8jrxwFuYdjvs5Bf8r0pYQymfYp+UqFQ5/vGaeP2M3q1zqoN5h+TbHdPUa
 kKWM1ynpLIpsYr7RdHMYJX67FAd7wVFmnA3fvZmwkXz61PLmUC+y02sK4 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9428197"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9428197"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:24:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2084870"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:24:38 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, xiaoyao.li@intel.com,
 Michael Roth <michael.roth@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 Claudio Fontana <cfontana@suse.de>, Gerd Hoffmann <kraxel@redhat.com>,
 Isaku Yamahata <isaku.yamahata@gmail.com>,
 Chenyi Qiang <chenyi.qiang@intel.com>
Subject: [PATCH v4 12/66] target/i386: Implement mc->kvm_type() to get VM type
Date: Wed, 24 Jan 2024 22:22:34 -0500
Message-Id: <20240125032328.2522472-13-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125032328.2522472-1-xiaoyao.li@intel.com>
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.10; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

TDX VM requires VM type KVM_X86_TDX_VM to be passed to
kvm_ioctl(KVM_CREATE_VM). Hence implement mc->kvm_type() for i386
architecture.

If tdx-guest object is specified to confidential-guest-support, like,

  qemu -machine ...,confidential-guest-support=tdx0 \
       -object tdx-guest,id=tdx0,...

it parses VM type as KVM_X86_TDX_VM. Otherwise, it's KVM_X86_DEFAULT_VM.

Also store the vm_type in MachineState for other code to query what the
VM type is.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
Changes in v4:
 - fix the build error of kvm_get_vm_type() when --disable-kvm;
---
 hw/i386/x86.c              | 12 ++++++++++++
 include/hw/i386/x86.h      |  1 +
 target/i386/kvm/kvm.c      | 30 ++++++++++++++++++++++++++++++
 target/i386/kvm/kvm_i386.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 2b6291ad8d5f..f66a92f6c9cc 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1386,6 +1386,17 @@ static void machine_set_sgx_epc(Object *obj, Visitor *v, const char *name,
     qapi_free_SgxEPCList(list);
 }
 
+static int x86_kvm_type(MachineState *ms, const char *vm_type)
+{
+    X86MachineState *x86ms = X86_MACHINE(ms);
+    int kvm_type;
+
+    kvm_type = kvm_enabled() ? kvm_get_vm_type(ms, vm_type) : 0;
+    x86ms->vm_type = kvm_type;
+
+    return kvm_type;
+}
+
 static void x86_machine_initfn(Object *obj)
 {
     X86MachineState *x86ms = X86_MACHINE(obj);
@@ -1410,6 +1421,7 @@ static void x86_machine_class_init(ObjectClass *oc, void *data)
     mc->cpu_index_to_instance_props = x86_cpu_index_to_props;
     mc->get_default_cpu_node_id = x86_get_default_cpu_node_id;
     mc->possible_cpu_arch_ids = x86_possible_cpu_arch_ids;
+    mc->kvm_type = x86_kvm_type;
     x86mc->save_tsc_khz = true;
     x86mc->fwcfg_dma_enabled = true;
     nc->nmi_monitor_handler = x86_nmi;
diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
index da19ae15463a..ab1d38569019 100644
--- a/include/hw/i386/x86.h
+++ b/include/hw/i386/x86.h
@@ -41,6 +41,7 @@ struct X86MachineState {
     MachineState parent;
 
     /*< public >*/
+    unsigned int vm_type;
 
     /* Pointers to devices and objects: */
     ISADevice *rtc;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 42970ab046fa..c961846777cc 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -32,6 +32,7 @@
 #include "sysemu/runstate.h"
 #include "kvm_i386.h"
 #include "sev.h"
+#include "tdx.h"
 #include "xen-emu.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -161,6 +162,35 @@ static KVMMSRHandlers msr_handlers[KVM_MSR_FILTER_MAX_RANGES];
 static RateLimit bus_lock_ratelimit_ctrl;
 static int kvm_get_one_msr(X86CPU *cpu, int index, uint64_t *value);
 
+static const char *vm_type_name[] = {
+    [KVM_X86_DEFAULT_VM] = "default",
+    [KVM_X86_TDX_VM] = "tdx",
+};
+
+int kvm_get_vm_type(MachineState *ms, const char *vm_type)
+{
+    int kvm_type = KVM_X86_DEFAULT_VM;
+
+    if (ms->cgs && object_dynamic_cast(OBJECT(ms->cgs), TYPE_TDX_GUEST)) {
+        kvm_type = KVM_X86_TDX_VM;
+    }
+
+    /*
+     * old KVM doesn't support KVM_CAP_VM_TYPES and KVM_X86_DEFAULT_VM
+     * is always supported
+     */
+    if (kvm_type == KVM_X86_DEFAULT_VM) {
+        return kvm_type;
+    }
+
+    if (!(kvm_check_extension(KVM_STATE(ms->accelerator), KVM_CAP_VM_TYPES) & BIT(kvm_type))) {
+        error_report("vm-type %s not supported by KVM", vm_type_name[kvm_type]);
+        exit(1);
+    }
+
+    return kvm_type;
+}
+
 bool kvm_has_smm(void)
 {
     return kvm_vm_check_extension(kvm_state, KVM_CAP_X86_SMM);
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 30fedcffea3e..55fb25fa8e2e 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -37,6 +37,7 @@ bool kvm_hv_vpindex_settable(void);
 bool kvm_enable_sgx_provisioning(KVMState *s);
 bool kvm_hyperv_expand_features(X86CPU *cpu, Error **errp);
 
+int kvm_get_vm_type(MachineState *ms, const char *vm_type);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_after_reset_vcpu(X86CPU *cpu);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
-- 
2.34.1


