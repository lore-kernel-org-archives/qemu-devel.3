Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33675C36014
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbtc-0008Jw-B4; Tue, 01 Apr 2025 09:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtZ-0008B4-0M
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:13 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tzbtW-0006Zf-2Q
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:43:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1743514990; x=1775050990;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=08H6dI0xe3rRjgkMiP4DtiKFJFaABuJh3KQcsj+dGvk=;
 b=RmejjbJTNEyz8HhRzNuQBZSmQSNmRll9JJK0GQI/3QV4lnV1Oko/tv5o
 RMFl+kGDkB22QNN9O5xBc6Iqhc9+7IJu2nKKuH+RMlmx7XDCJL2Wh0t25
 LCT7ZBZqYzpnAMmuepgfYh2rl8ZMsZr1mcBnVAYZb45kstq/MxgyTNxw+
 tyBTBJjby7J01C999VhhlCHfJ0Aj1mF0Hs48E4aklq3yJpfp+ZGMA111+
 CkzoxfVboWCOXrW8EW5AQgygc3GBnMbJ0hdnhvqIF2tKgguIaJu9EAdvt
 o6XCeKVwHJVUiQj8AccWfloudR2JWzg73LbCtCFnxt5nxRHT+zvkDWqKs Q==;
X-CSE-ConnectionGUID: zql0ky9aR5OaVoeX8HP8bg==
X-CSE-MsgGUID: UH5xPBkeSHuuP3Kf1nXsLg==
X-IronPort-AV: E=McAfee;i="6700,10204,11391"; a="32433396"
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="32433396"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2025 06:42:23 -0700
X-CSE-ConnectionGUID: JbbVKOKJRPKRjr/Rr+Oyig==
X-CSE-MsgGUID: JF0ZinGhQGy4aeA3xoIG4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,293,1736841600"; d="scan'208";a="126640083"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa008.fm.intel.com with ESMTP; 01 Apr 2025 06:42:20 -0700
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PATCH v8 28/55] i386/tdx: Handle KVM_SYSTEM_EVENT_TDX_FATAL
Date: Tue,  1 Apr 2025 09:01:38 -0400
Message-Id: <20250401130205.2198253-29-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250401130205.2198253-1-xiaoyao.li@intel.com>
References: <20250401130205.2198253-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.16; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_MED=-2.3,
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

TD guest can use TDG.VP.VMCALL<REPORT_FATAL_ERROR> to request
termination. KVM translates such request into KVM_EXIT_SYSTEM_EVENT with
type of KVM_SYSTEM_EVENT_TDX_FATAL.

Add hanlder for such exit. Parse and print the error message, and
terminate the TD guest in the handler.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v8:
 - update to the new data ABI of KVM_SYSTEM_EVENT_TDX_FATAL;

Changes in v6:
 - replace the patch " i386/tdx: Handle TDG.VP.VMCALL<REPORT_FATAL_ERROR>"
   in v5;
---
 target/i386/kvm/kvm.c      | 10 +++++++++
 target/i386/kvm/tdx-stub.c |  5 +++++
 target/i386/kvm/tdx.c      | 45 ++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.h      |  2 ++
 4 files changed, 62 insertions(+)

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
index f8953f598584..74b7e3ac85fe 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -607,6 +607,51 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
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
+/*
+ * Only 8 registers can contain valid ASCII byte stream to form the fatal
+ * message, and their sequence is: R14, R15, RBX, RDI, RSI, R8, R9, RDX
+ */
+#define TDX_FATAL_MESSAGE_MAX        64
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
2.34.1


