Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B85C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 13:46:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbJuN-0007qq-CT; Fri, 24 Jan 2025 08:39:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJtp-0006ru-2u
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:07 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1tbJtn-00041c-1E
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 08:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737725943; x=1769261943;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=85XePJaofoFgh2exxL+wI9EtRIBe+GFG6YbreIJ1ZbA=;
 b=DJJx2ROIYQZceuemaPGKjxCMjy4CGaiCyB/5WpDTWz/TJ2wkwxc6FQdk
 NKsT86kOqJnCtcuFC+Bb6Kn5WBqlnEA80soR5n1qaD1so9k2Jlzux7zS1
 Kn8eVAyGbITPKzqdFTX0OsWjHqHe5i42kaNfmwMIT/Xhx4/xlzFqrM98C
 X4tvzu+afEFNhlbIfjiX3/39PYP+Es1hwZWbdDcdbY5PeylPAVQO6wQkk
 Qc9Budvzn17PVWNPOCiVo8C7FQ5eM1p4t9jten8LeZx5u/Z4v9E9IVSza
 vU/AQtSHwhVcIQGKnFMuszM2xtboEDjLoueUonM6MHuAz8b+RwSquLMhf w==;
X-CSE-ConnectionGUID: f/QpukVlTrGfN33GT2d7bA==
X-CSE-MsgGUID: dQx8MPTBTeCUxKLS3aBEog==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="49246458"
X-IronPort-AV: E=Sophos;i="6.13,231,1732608000"; d="scan'208";a="49246458"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2025 05:38:48 -0800
X-CSE-ConnectionGUID: mMNcARQFQ2m0Qdea8T315A==
X-CSE-MsgGUID: CcvpFmjiSHeAN8kNvKqavA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="111804358"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2025 05:38:44 -0800
From: Xiaoyao Li <xiaoyao.li@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Francesco Lavra <francescolavra.fl@gmail.com>, xiaoyao.li@intel.com,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH v7 28/52] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
Date: Fri, 24 Jan 2025 08:20:24 -0500
Message-Id: <20250124132048.3229049-29-xiaoyao.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124132048.3229049-1-xiaoyao.li@intel.com>
References: <20250124132048.3229049-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.13; envelope-from=xiaoyao.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.998, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility

Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v6:
- change error_code of GuestPanicInformationTdx from uint64_t to
  uint32_t, to only contains the bit 31:0 returned in r12.

Changes in v5:
- mention additional error information in gpa when it presents;
- refine the documentation; (Markus)

Changes in v4:
- refine the documentation; (Markus)

Changes in v3:
- Add docmentation of new type and struct; (Daniel)
- refine the error message handling; (Daniel)
---
 qapi/run-state.json   | 31 ++++++++++++++++++--
 system/runstate.c     | 67 +++++++++++++++++++++++++++++++++++++++++++
 target/i386/kvm/tdx.c | 24 +++++++++++++++-
 3 files changed, 119 insertions(+), 3 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index ce95cfa46b73..e63611780a2c 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -501,10 +501,12 @@
 #
 # @s390: s390 guest panic information type (Since: 2.12)
 #
+# @tdx: tdx guest panic information type (Since: 9.0)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v', 's390' ] }
+  'data': [ 'hyper-v', 's390', 'tdx' ] }
 
 ##
 # @GuestPanicInformation:
@@ -519,7 +521,8 @@
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
  'data': {'hyper-v': 'GuestPanicInformationHyperV',
-          's390': 'GuestPanicInformationS390'}}
+          's390': 'GuestPanicInformationS390',
+          'tdx' : 'GuestPanicInformationTdx'}}
 
 ##
 # @GuestPanicInformationHyperV:
@@ -598,6 +601,30 @@
           'psw-addr': 'uint64',
           'reason': 'S390CrashReason'}}
 
+##
+# @GuestPanicInformationTdx:
+#
+# TDX Guest panic information specific to TDX, as specified in the
+# "Guest-Hypervisor Communication Interface (GHCI) Specification",
+# section TDG.VP.VMCALL<ReportFatalError>.
+#
+# @error-code: TD-specific error code
+#
+# @message: Human-readable error message provided by the guest. Not
+#     to be trusted.
+#
+# @gpa: guest-physical address of a page that contains more verbose
+#     error information, as zero-terminated string.  Present when the
+#     "GPA valid" bit (bit 63) is set in @error-code.
+#
+#
+# Since: 10.0
+##
+{'struct': 'GuestPanicInformationTdx',
+ 'data': {'error-code': 'uint32',
+          'message': 'str',
+          '*gpa': 'uint64'}}
+
 ##
 # @MEMORY_FAILURE:
 #
diff --git a/system/runstate.c b/system/runstate.c
index 272801d30769..c4244c8915c6 100644
--- a/system/runstate.c
+++ b/system/runstate.c
@@ -565,6 +565,60 @@ static void qemu_system_wakeup(void)
     }
 }
 
+static char *tdx_parse_panic_message(char *message)
+{
+    bool printable = false;
+    char *buf = NULL;
+    int len = 0, i;
+
+    /*
+     * Although message is defined as a json string, we shouldn't
+     * unconditionally treat it as is because the guest generated it and
+     * it's not necessarily trustable.
+     */
+    if (message) {
+        /* The caller guarantees the NULL-terminated string. */
+        len = strlen(message);
+
+        printable = len > 0;
+        for (i = 0; i < len; i++) {
+            if (!(0x20 <= message[i] && message[i] <= 0x7e)) {
+                printable = false;
+                break;
+            }
+        }
+    }
+
+    if (len == 0) {
+        buf = g_malloc(1);
+        buf[0] = '\0';
+    } else {
+        if (!printable) {
+            /* 3 = length of "%02x " */
+            buf = g_malloc(len * 3);
+            for (i = 0; i < len; i++) {
+                if (message[i] == '\0') {
+                    break;
+                } else {
+                    sprintf(buf + 3 * i, "%02x ", message[i]);
+                }
+            }
+            if (i > 0) {
+                /* replace the last ' '(space) to NULL */
+                buf[i * 3 - 1] = '\0';
+            } else {
+                buf[0] = '\0';
+            }
+
+        } else {
+            buf = g_malloc(len);
+            memcpy(buf, message, len);
+        }
+    }
+
+    return buf;
+}
+
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
@@ -606,7 +660,20 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           S390CrashReason_str(info->u.s390.reason),
                           info->u.s390.psw_mask,
                           info->u.s390.psw_addr);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_TDX) {
+            char *message = tdx_parse_panic_message(info->u.tdx.message);
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "\nTDX guest reports fatal error:"
+                          " error code: 0x%" PRIx32 " error message:\"%s\"\n",
+                          info->u.tdx.error_code, message);
+            g_free(message);
+            if (info->u.tdx.gpa != -1ull) {
+                qemu_log_mask(LOG_GUEST_ERROR, "Additional error information "
+                              "can be found at gpa page: 0x%" PRIx64 "\n",
+                              info->u.tdx.gpa);
+            }
         }
+
         qapi_free_GuestPanicInformation(info);
     }
 }
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index f857fddd839b..591de30eedf4 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
+#include "system/runstate.h"
 #include "system/system.h"
 #include "exec/ramblock.h"
 
@@ -601,10 +602,25 @@ int tdx_parse_tdvf(void *flash_ptr, int size)
     return tdvf_parse_metadata(&tdx_guest->tdvf, flash_ptr, size);
 }
 
+static void tdx_panicked_on_fatal_error(X86CPU *cpu, uint64_t error_code,
+                                        char *message, uint64_t gpa)
+{
+    GuestPanicInformation *panic_info;
+
+    panic_info = g_new0(GuestPanicInformation, 1);
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_TDX;
+    panic_info->u.tdx.error_code = (uint32_t) error_code;
+    panic_info->u.tdx.message = message;
+    panic_info->u.tdx.gpa = gpa;
+
+    qemu_system_guest_panicked(panic_info);
+}
+
 int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
 {
     uint64_t error_code = run->system_event.data[0];
     char *message = NULL;
+    uint64_t gpa = -1ull;
 
     if (error_code & 0xffff) {
         error_report("TDX: REPORT_FATAL_ERROR: invalid error code: 0x%lx",
@@ -621,7 +637,13 @@ int tdx_handle_report_fatal_error(X86CPU *cpu, struct kvm_run *run)
         message[TDX_FATAL_MESSAGE_MAX] = '\0';
     }
 
-    error_report("TD guest reports fatal error. %s", message ? : "");
+#define TDX_REPORT_FATAL_ERROR_GPA_VALID    BIT_ULL(63)
+    if (error_code & TDX_REPORT_FATAL_ERROR_GPA_VALID) {
+        gpa = run->system_event.data[1];
+    }
+
+    tdx_panicked_on_fatal_error(cpu, error_code, message, gpa);
+
     return -1;
 }
 
-- 
2.34.1


