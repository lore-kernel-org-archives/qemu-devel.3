Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33001C3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2q8-00058z-ET; Thu, 08 May 2025 11:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pt-0004OJ-TP
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:06:57 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2pr-0007UR-4d
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716815; x=1778252815;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ULaUPFgAxDsLHz3qW1U4r8DmCBmHXlIyTtbwtrVIr8k=;
 b=OAFa5TMe1AQGSMZSEyGOKXZmFgCT5xdMfGF1RW42S8vNZb1hbaI1LFvL
 3Oj0WLc+8syxe7nYDVhFaQxAOiwUA3nINSdjFv2mbyiohi66prufiAn98
 pksgB7G9Dpp4hQDvR/6yRv4lsoV+JjqZ+/j+01WaiqqcBqGKpA/YZP5OG
 YB1VKY4jizYzfirxk7gAeVyMxn4f2KgRgt4oi1jFyYh4pO8RnpL53d7dJ
 r98j5ppDAJzNMs9EFVwd4ItHqfNjwOd5cwc35C4LS5egSCEppCniBHC+c
 Ebjy2gL/UCQ4KcqeqEqaPhWjSD9lVD5Z+Q6wswRZ7yX2pQa/K5JW5V3Eq w==;
X-CSE-ConnectionGUID: lwdts/tnS8+jJ0THDFIbMw==
X-CSE-MsgGUID: dyuBjmwhRZaShFEKP82yDw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888238"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888238"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:06:22 -0700
X-CSE-ConnectionGUID: RcgWsWjHTY6PVf70nf2rpw==
X-CSE-MsgGUID: Rsm7gqm0SCWp6suZb7Dugw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141440097"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:06:18 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v9 28/55] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
Date: Thu,  8 May 2025 10:59:34 -0400
Message-ID: <20250508150002.689633-29-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508150002.689633-1-xiaoyao.li@intel.com>
References: <20250508150002.689633-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.7; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
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

TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request
termination. KVM translates such request into KVM_EXIT_SYSTEM_EVENT with
type of KVM_SYSTEM_EVENT_TDX_FATAL.

Add hanlder for such exit. Parse and print the error message, and
terminate the TD guest in the handler.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changes in v9:
 - Move the definition of MACRO TDX_FATAL_MESSAGE_MAX out of the
   function; (Zhao Liu)

Changes in v8:
 - update to the new data ABI of KVM_SYSTEM_EVENT_TDX_FATAL;

Changes in v6:
 - replace the patch " i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>"
   in v5;
---
 target/i386/kvm/kvm.c      | 10 +++++++++
 target/i386/kvm/tdx-stub.c |  5 +++++
 target/i386/kvm/tdx.c      | 46 ++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h      |  2 ++
 4 files changed, 63 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7de5014051eb..a76f34537908 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -6128,6 +6128,16 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
     case KVM_EXIT_HYPERCALL:
         ret = kvm_handle_hypercall(run);
         break;
+    case KVM_EXIT_SYSTEM_EVENT:
+        switch (run->system_event.type) {
+        case KVM_SYSTEM_EVENT_TDX_FATAL:
+            ret = tdx_handle_report_fatal_error(cpu, run);
+            break;
+        default:
+            ret = -1;
+            break;
+        }
+        break;
     default:
         fprintf(stderr, "KVM: unknown exit reason %d\n", run->exit_reason);
         ret = -1;
diff --git a/target/i386/kvm/tdx-stub.c b/target/i386/kvm/tdx-stub.c
index 7748b6d0a446..720a4ff046ee 100644
--- a/target/i386/kvm/tdx-stub.c
+++ b/target/i386/kvm/tdx-stub.c
@@ -13,3 +13,8 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
 {
     return -EINVAL;
 }
+
+int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
+{
+    return -EINVAL;
+}
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 0a6db6095e3e..5a140e88eb92 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -622,6 +622,52 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+/*
+ * Only 8 registers can contain valid ASCII byte stream to form the fatal
+ * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
+ */
+#define TDX_FATAL_MESSAGE_MAX        64
+
+int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
+{
+    uint64_t error_code = run->system_event.data[R_R12];
+    uint64_t reg_mask = run->system_event.data[R_ECX];
+    char *message = NULL;
+    uint64_t *tmp;
+
+    if (error_code & 0xffff) {
+        error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
+                     error_code);
+        return -1;
+    }
+
+    if (reg_mask) {
+        message = g_malloc0(TDX_FATAL_MESSAGE_MAX + 1);
+        tmp = (uint64_t *)message;
+
+#define COPY_REG(REG)                               \
+    do {                                            \
+        if (reg_mask & BIT_ULL(REG)) {              \
+            *(tmp++) = run->system_event.data[REG]; \
+        }                                           \
+    } while (0)
+
+        COPY_REG(R_R14);
+        COPY_REG(R_R15);
+        COPY_REG(R_EBX);
+        COPY_REG(R_EDI);
+        COPY_REG(R_ESI);
+        COPY_REG(R_R8);
+        COPY_REG(R_R9);
+        COPY_REG(R_EDX);
+        *((char *)tmp) = '\0';
+    }
+#undef COPY_REG
+
+    error_report("TD guest reports fatal error. %s", message ? : "");
+    return -1;
+}
+
 static bool tdx_guest_get_sept_ve_disable(Object *obj, Error **errp)
 {
     TdxGuest *tdx = TDX_GUEST(obj);
diff --git a/target/i386/kvm/tdx.h b/target/i386/kvm/tdx.h
index 36a7400e7480..04b5afe199f9 100644
--- a/target/i386/kvm/tdx.h
+++ b/target/i386/kvm/tdx.h
@@ -8,6 +8,7 @@
 #endif
 
 #include "confidential-guest.h"
+#include "cpu.h"
 #include "hw/i386/tdvf.h"
 
 #define TYPE_TDX_GUEST "tdx-guest"
@@ -59,5 +60,6 @@ bool is_tdx_vm(void);
 int tdx_pre_create_vcpu(CPUState *cpu, Error **errp);
 void tdx_set_tdvf_region(MemoryRegion *tdvf_mr);
 int tdx_parse_tdvf(void *flash_ptr, int size);
+int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run);
 
 #endif /* QEMU_I386_TDX_H */
-- 
2.43.0


