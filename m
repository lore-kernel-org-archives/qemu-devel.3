Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BED9C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:37:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqSQ-0003mV-16; Wed, 24 Jan 2024 22:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqSM-0003KA-24
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:31:10 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqSH-0001Dy-2F
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:31:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153465; x=1737689465;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=u9KMXUEQeXh0mI5sy6l0uCUlYOKP73JuhfrwPW/W4eo=;
 b=LGtOruO9uKFKaIAvxjYAJ15v2XnzhN7n1pBwo0vMYRLVTw69E6qmmzCL
 CGIPeAPQuhDQOmpysNm7dDO2IKiIEW1ikn25yR+Vba1+uDyUhEPn4iv0W
 RCIoBg0V+6X8qXXtmyEGGglc5WZsc+dv5xbzdQVjp1twwXoMVSdUZ3Y/o
 EzacVEReH2P+4WWd5y7pY+eF4NLu2T3buRIeN4gzJgzs44dXl4xTlgB6M
 YCO2N+ckl60OsWjJrsNIfka9FXESxyavvcHU1d3aTPyGRzzynq1GVofB6
 Y6/wYX32WTv1tpZI/GL33qr7i2XqlS/PYAi0Fbcq/a3P/Ql58zHF/p8jw Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9429959"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9429959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:28:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2086106"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:28:01 -0800
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
Subject: [PATCH v4 49/66] i386/tdx: handle
 TDG.VP.VMCALL<SetupEventNotifyInterrupt>
Date: Wed, 24 Jan 2024 22:23:11 -0500
Message-Id: <20240125032328.2522472-50-xiaoyao.li@intel.com>
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

From: Isaku Yamahata <isaku.yamahata@intel.com>

For SetupEventNotifyInterrupt, record interrupt vector and the apic id
of the vcpu that received this TDVMCALL.

Later it can inject interrupt with given vector to the specific vcpu
that received SetupEventNotifyInterrupt.

Signed-off-by: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c      |  8 ++++++
 target/i386/kvm/tdx-stub.c |  5 ++++
 target/i386/kvm/tdx.c      | 53 ++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h      | 14 ++++++++++
 4 files changed, 80 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 348f76a9cb81..e36ece874246 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -5426,6 +5426,14 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         ret = kvm_xen_handle_exit(cpu, &run->xen);
         break;
 #endif
+    case KVM_EXIT_TDX:
+        if (!is_tdx_vm()) {
+            error_report("KVM: get KVM_EXIT_TDX for a non-TDX VM.");
+            ret = -1;
+            break;
+        }
+        ret = tdx_handle_exit(cpu, &run->tdx);
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 587dbeeed196..ffaf659bc9be 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -16,3 +16,8 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
 {
     return -EINVAL;
 }
+
+int tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 69a697608219..602b5656d462 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -852,6 +852,56 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static int tdx_handle_setup_event_notify_interrupt(X86CPU *cpu,
+                                                   struct kvm_tdx_vmcall *vmcall)
+{
+    int vector = vmcall->in_r12;
+
+    if (32 <= vector && vector <= 255) {
+        qemu_mutex_lock(&tdx_guest->lock);
+        tdx_guest->event_notify_vector = vector;
+        tdx_guest->event_notify_apicid = cpu->apic_id;
+        qemu_mutex_unlock(&tdx_guest->lock);
+        vmcall->status_code = TDG_VP_VMCALL_SUCCESS;
+    } else {
+        vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
+    }
+
+    return 0;
+}
+
+static int tdx_handle_vmcall(X86CPU *cpu, struct kvm_tdx_vmcall *vmcall)
+{
+    vmcall->status_code = TDG_VP_VMCALL_INVALID_OPERAND;
+
+    /* For now handle only TDG.VP.VMCALL leaf defined in TDX GHCI */
+    if (vmcall->type != 0) {
+        error_report("Unknown TDG.VP.VMCALL type 0x%llx subfunction 0x%llx",
+                     vmcall->type, vmcall->subfunction);
+        return -1;
+    }
+
+    switch (vmcall->subfunction) {
+    case TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
+        return tdx_handle_setup_event_notify_interrupt(cpu, vmcall);
+    default:
+        error_report("Unknown TDG.VP.VMCALL type 0x%llx subfunction 0x%llx",
+                     vmcall->type, vmcall->subfunction);
+        return -1;
+    }
+}
+
+int tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit)
+{
+    switch (tdx_exit->type) {
+    case KVM_EXIT_TDX_VMCALL:
+        return tdx_handle_vmcall(cpu, &tdx_exit->u.vmcall);
+    default:
+        error_report("unknown tdx exit type 0x%x", tdx_exit->type);
+        return -1;
+    }
+}
+
 static void tdx_guest_region_add(MemoryListener *listener,
                                  MemoryRegionSection *section)
 {
@@ -961,6 +1011,9 @@ static void tdx_guest_init(Object *obj)
     object_property_add_str(obj, "mrownerconfig",
                             tdx_guest_get_mrownerconfig,
                             tdx_guest_set_mrownerconfig);
+
+    tdx->event_notify_vector = -1;
+    tdx->event_notify_apicid = -1;
 }
 
 static void tdx_guest_finalize(Object *obj)
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 5fb20a5f06bb..992916e4c905 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -7,6 +7,7 @@
 
 #include "exec/confidential-guest-support.h"
 #include "hw/i386/tdvf.h"
+#include "sysemu/kvm.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
 #define TDX_GUEST(obj)  OBJECT_CHECK(TdxGuest, (obj), TYPE_TDX_GUEST)
@@ -15,6 +16,14 @@ typedef struct TdxGuestClass {
     ConfidentialGuestSupportClass parent_class;
 } TdxGuestClass;
 
+#define TDG_VP_VMCALL_SETUP_EVENT_NOTIFY_INTERRUPT      0x10004ULL
+
+#define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
+#define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
+#define TDG_VP_VMCALL_INVALID_OPERAND   0x8000000000000000ULL
+#define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
+#define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
+
 enum TdxRamType{
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
@@ -42,6 +51,10 @@ typedef struct TdxGuest {
 
     uint32_t nr_ram_entries;
     TdxRamEntry *ram_entries;
+
+    /* runtime state */
+    uint32_t event_notify_vector;
+    uint32_t event_notify_apicid;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -56,5 +69,6 @@ void tdx_get_supported_cpuid(uint32_t function, uint32_t index, int reg,
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_region);
 int tdx_parse_tdvf(void *flash_ptr, int size);
+int tdx_handle_exit(X86CPU *cpu, struct kvm_tdx_exit *tdx_exit);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.34.1


