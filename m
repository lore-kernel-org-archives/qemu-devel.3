Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF4C77B7C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 02:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX9zd-0002bF-9A; Wed, 02 Jul 2025 22:48:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9za-0002ZH-0d
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:48:06 -0400
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uX9zV-0007sP-9q
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 22:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1751510880; x=1783046880;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=3JEtPLNDpteWO0MXdkQc36eFxvc/61TwA72slbgFSTI=;
 b=F0bp9aClU0ZZdz8Od7DicQ2W8RtmwPEPtyKUxvU3dFFoY6nBfREay0BB
 CyTKEbZTmYiCa0kk5wg5g8Bd3v10FwxItHXrYEnthvNtCRC8kBRqDjLNC
 7UuMLgO78Iay3pDfB3SEoJt+9AkX+oI2C9tls3HjPH/v18RiBg/9+CAAe
 nQ5i5MWZcOnI5vSsn7F3T1seee3iw33Kkz/hnXnpvaFQCTF55Pes43vu1
 Z83oBF7SlV3uTdXUiyaZKNICqFMjy8WTuXug/oT74UZP0rSoCNJW9ok2+
 yksNJ6YxpTlf2xVs4cRLOVXAyuUe0pzoSSzdqlfrbjR4+Wk8W3RLsv6aJ Q==;
X-CSE-ConnectionGUID: o18W3OHnTueLIHjHBHplww==
X-CSE-MsgGUID: xvyncF8mQYGkFzKRsYIdnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11482"; a="57499457"
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="57499457"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2025 19:47:58 -0700
X-CSE-ConnectionGUID: JAco4SqMTCGkM18rW4QavA==
X-CSE-MsgGUID: qaInI2rxSMuZN/CwjrilYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,283,1744095600"; d="scan'208";a="153880373"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa007.fm.intel.com with ESMTP; 02 Jul 2025 19:47:57 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 xiaoyao.li@intel.com
Subject: [PATCH 4/4] i386/tdx: handle TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT
Date: Thu,  3 Jul 2025 10:40:20 +0800
Message-ID: <20250703024021.3559286-5-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703024021.3559286-1-xiaoyao.li@intel.com>
References: <20250703024021.3559286-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.15; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Record the interrupt vector and the apic id of the vcpu that calls
TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT.

Inject the interrupt to TD guest to notify the completion of <GetQuote>
when notify interrupt vector is valid.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c      |  3 +++
 target/i386/kvm/tdx-stub.c |  4 ++++
 target/i386/kvm/tdx.c      | 48 +++++++++++++++++++++++++++++++++++++-
 target/i386/kvm/tdx.h      |  7 ++++++
 4 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 234878c613f6..fc58a23b30dd 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6182,6 +6182,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         case TDVMCALL_GET_TD_VM_CALL_INFO:
             tdx_handle_get_tdvmcall_info(cpu, run);
             break;
+        case TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT:
+            tdx_handle_setup_event_notify_interrupt(cpu, run);
+            break;
         }
         ret = 0;
         break;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 76fee49eff05..1f0e108a69ea 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -26,3 +26,7 @@ void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run)
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
 {
 }
+
+void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
+{
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 10dfb80d22e2..fb31071dd81b 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -28,10 +28,13 @@
 #include "cpu.h"
 #include "cpu-internal.h"
 #include "host-cpu.h"
+#include "hw/i386/apic_internal.h"
+#include "hw/i386/apic-msidef.h"
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/tdvf-hob.h"
+#include "hw/pci/msi.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 #include "tdx-quote-generator.h"
@@ -1123,6 +1126,28 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static void tdx_inject_interrupt(uint32_t apicid, uint32_t vector)
+{
+    int ret;
+
+    if (vector < 32 || vector > 255) {
+        return;
+    }
+
+    MSIMessage msg = {
+        .address = ((apicid & 0xff) << MSI_ADDR_DEST_ID_SHIFT) |
+                   (((uint64_t)apicid & 0xffffff00) << 32),
+        .data = vector | (APIC_DM_FIXED << MSI_DATA_DELIVERY_MODE_SHIFT),
+    };
+
+    ret = kvm_irqchip_send_msi(kvm_state, msg);
+    if (ret < 0) {
+        /* In this case, no better way to tell it to guest. Log it. */
+        error_report("TDX: injection interrupt %d failed, interrupt lost (%s).",
+                     vector, strerror(-ret));
+    }
+}
+
 static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
 {
     TdxGuest *tdx = task->opaque;
@@ -1154,6 +1179,9 @@ static void tdx_get_quote_completion(TdxGenerateQuoteTask *task)
         error_report("TDX: get-quote: failed to update GetQuote header.");
     }
 
+    tdx_inject_interrupt(tdx_guest->event_notify_apicid,
+                         tdx_guest->event_notify_vector);
+
     g_free(task->send_data);
     g_free(task->receive_buf);
     g_free(task);
@@ -1256,7 +1284,7 @@ out_free:
     g_free(task);
 }
 
-#define SUPPORTED_TDVMCALLINFO_1_R11    (0)
+#define SUPPORTED_TDVMCALLINFO_1_R11    (TDG_VP_VMCALL_SUBFUNC_SET_EVENT_NOTIFY_INTERRUPT)
 #define SUPPORTED_TDVMCALLINFO_1_R12    (0)
 
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
@@ -1277,6 +1305,21 @@ void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run)
     run->tdx.get_tdvmcall_info.ret = TDG_VP_VMCALL_SUCCESS;
 }
 
+void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run)
+{
+    uint64_t vector = run->tdx.setup_event_notify.vector;
+
+    if (vector >= 32 && vector < 256) {
+        qemu_mutex_lock(&tdx_guest->lock);
+        tdx_guest->event_notify_vector = vector;
+        tdx_guest->event_notify_apicid = cpu->apic_id;
+        qemu_mutex_unlock(&tdx_guest->lock);
+        run->tdx.setup_event_notify.ret = TDG_VP_VMCALL_SUCCESS;
+    } else {
+        run->tdx.setup_event_notify.ret = TDG_VP_VMCALL_INVALID_OPERAND;
+    }
+}
+
 static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
                                         char *message, uint64_t gpa)
 {
@@ -1477,6 +1520,9 @@ static void tdx_guest_init(Object *obj)
                             NULL, NULL);
 
     qemu_mutex_init(&tdx->lock);
+
+    tdx->event_notify_vector = -1;
+    tdx->event_notify_apicid = -1;
 }
 
 static void tdx_guest_finalize(Object *obj)
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index d439078a8761..1c38faf9834c 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -25,6 +25,7 @@ typedef struct TdxGuestClass {
 
 #define TDVMCALL_GET_TD_VM_CALL_INFO    0x10000
 #define TDVMCALL_GET_QUOTE		 0x10002
+#define TDVMCALL_SETUP_EVENT_NOTIFY_INTERRUPT   0x10004
 
 #define TDG_VP_VMCALL_SUCCESS           0x0000000000000000ULL
 #define TDG_VP_VMCALL_RETRY             0x0000000000000001ULL
@@ -32,6 +33,8 @@ typedef struct TdxGuestClass {
 #define TDG_VP_VMCALL_GPA_INUSE         0x8000000000000001ULL
 #define TDG_VP_VMCALL_ALIGN_ERROR       0x8000000000000002ULL
 
+#define TDG_VP_VMCALL_SUBFUNC_SET_EVENT_NOTIFY_INTERRUPT BIT_ULL(1)
+
 enum TdxRamType {
     TDX_RAM_UNACCEPTED,
     TDX_RAM_ADDED,
@@ -64,6 +67,9 @@ typedef struct TdxGuest {
     /* GetQuote */
     SocketAddress *qg_sock_addr;
     int num;
+
+    uint32_t event_notify_vector;
+    uint32_t event_notify_apicid;
 } TdxGuest;
 
 #ifdef CONFIG_TDX
@@ -78,5 +84,6 @@ int tdx_parse_tdvf(void *flash_ptr, int size);
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
 void tdx_handle_get_quote(X86CPU *cpu, struct kvm_run *run);
 void tdx_handle_get_tdvmcall_info(X86CPU *cpu, struct kvm_run *run);
+void tdx_handle_setup_event_notify_interrupt(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.43.0


