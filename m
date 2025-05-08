Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB06AC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 15:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD2oG-0001CA-9Q; Thu, 08 May 2025 11:05:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2oE-0001A0-3Z
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:14 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1uD2oB-0007RW-7u
 for qemu-devel@nongnu.org; Thu, 08 May 2025 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1746716711; x=1778252711;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6zjzxZ36ZpLCHxUaVNTeoqy3IP35XZo69poU2bBv4ZI=;
 b=GSmIr3QuNaXQ7l0n/pmctIZA/Dll0d7rulSKc+530hZivI3dRPOd4zxk
 kxD4N0VHNzZcIModes2pfwGENWawDTZhO2hhIKo3wUkzw6GxaeFkWed3L
 0C44Bdf2DZn/9BgrdySeZ4L5AN5sz7pBk70v9Gq6+lHzpRY54tmx7oDxq
 YATZt7nbRQYI/xSd5CQof/IcJ2OOavFiOvAhGk6kWOiw2AeIow8NjisH/
 WYM9JL1LlJ8LG1WTz3sdzWs9cuasqe2CpaeZAvkN1SrwgZYt2N1siZ8nL
 s24/2yvCJuF9O+svEzLsUU6DuoA4MRVzUrkuDIiH3NY/TqSnNpQdOrJmT Q==;
X-CSE-ConnectionGUID: 358AgvyERT+8lygZSE/aag==
X-CSE-MsgGUID: XO1wDzmAQmm0BMPetoSHOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="73888015"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="73888015"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 May 2025 08:05:09 -0700
X-CSE-ConnectionGUID: O/oI6tobTZ6eweq2gxSJdQ==
X-CSE-MsgGUID: 8TS4X2uVRKmjAYa18PEBLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; d="scan'208";a="141439797"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 08 May 2025 08:05:05 -0700
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
Subject: [PATCH v9 05/55] i386/tdx: Get tdx_capabilities via
 KVM_TDX_CAPABILITIES
Date: Thu,  8 May 2025 10:59:11 -0400
Message-ID: <20250508150002.689633-6-xiaoyao.li@intel.com>
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

KVM provides TDX capabilities via sub command KVM_TDX_CAPABILITIES of
IOCTL(KVM_MEMORY_ENCRYPT_OP). Get the capabilities when initializing
TDX context. It will be used to validate user's setting later.

Since there is no interface reporting how many cpuid configs contains in
KVM_TDX_CAPABILITIES, QEMU chooses to try starting with a known number
and abort when it exceeds KVM_MAX_CPUID_ENTRIES.

Besides, introduce the interfaces to invoke TDX "ioctls" at VCPU scope
in preparation.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
Changes in v7:
- refine and unifiy the error handling; (Daniel)

Changes in v6:
- Pass CPUState * to tdx_vcpu_ioctl();
- update commit message to remove platform scope thing;
- dump hw_error when it's non-zero to help debug;

Changes in v4:
- use {} to initialize struct kvm_tdx_cmd, to avoid memset();
- remove tdx_platform_ioctl() because no user;

Changes in v3:
- rename __tdx_ioctl() to tdx_ioctl_internal()
- Pass errp in get_tdx_capabilities();

changes in v2:
  - Make the error message more clear;

changes in v1:
  - start from nr_cpuid_configs = 6 for the loop;
  - stop the loop when nr_cpuid_configs exceeds KVM_MAX_CPUID_ENTRIES;
---
 target/i386/kvm/kvm.c      |   2 -
 target/i386/kvm/kvm_i386.h |   2 +
 target/i386/kvm/tdx.c      | 107 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 108 insertions(+), 3 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 1af4710556ad..b4fa35405fe1 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1779,8 +1779,6 @@ static int hyperv_init_vcpu(X86CPU *cpu)
 
 static Error *invtsc_mig_blocker;
 
-#define KVM_MAX_CPUID_ENTRIES  100
-
 static void kvm_init_xsave(CPUX86State *env)
 {
     if (has_xsave2) {
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index 88565e8dbac1..ed1e61fb8ba9 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,6 +13,8 @@
 
 #include "system/kvm.h"
 
+#define KVM_MAX_CPUID_ENTRIES  100
+
 /* always false if !CONFIG_KVM */
 #define kvm_pit_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 4ff94860815d..c67be5e618e2 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -10,17 +10,122 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
 #include "qom/object_interfaces.h"
 
 #include "hw/i386/x86.h"
 #include "kvm_i386.h"
 #include "tdx.h"
 
+static struct kvm_tdx_capabilities *tdx_caps;
+
+enum tdx_ioctl_level {
+    TDX_VM_IOCTL,
+    TDX_VCPU_IOCTL,
+};
+
+static int tdx_ioctl_internal(enum tdx_ioctl_level level, void *state,
+                              int cmd_id, __u32 flags, void *data,
+                              Error **errp)
+{
+    struct kvm_tdx_cmd tdx_cmd = {};
+    int r;
+
+    const char *tdx_ioctl_name[] = {
+        [KVM_TDX_CAPABILITIES] = "KVM_TDX_CAPABILITIES",
+        [KVM_TDX_INIT_VM] = "KVM_TDX_INIT_VM",
+        [KVM_TDX_INIT_VCPU] = "KVM_TDX_INIT_VCPU",
+        [KVM_TDX_INIT_MEM_REGION] = "KVM_TDX_INIT_MEM_REGION",
+        [KVM_TDX_FINALIZE_VM] = "KVM_TDX_FINALIZE_VM",
+        [KVM_TDX_GET_CPUID] = "KVM_TDX_GET_CPUID",
+    };
+
+    tdx_cmd.id = cmd_id;
+    tdx_cmd.flags = flags;
+    tdx_cmd.data = (__u64)(unsigned long)data;
+
+    switch (level) {
+    case TDX_VM_IOCTL:
+        r = kvm_vm_ioctl(kvm_state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+        break;
+    case TDX_VCPU_IOCTL:
+        r = kvm_vcpu_ioctl(state, KVM_MEMORY_ENCRYPT_OP, &tdx_cmd);
+        break;
+    default:
+        error_setg(errp, "Invalid tdx_ioctl_level %d", level);
+        return -EINVAL;
+    }
+
+    if (r < 0) {
+        error_setg_errno(errp, -r, "TDX ioctl %s failed, hw_errors: 0x%llx",
+                         tdx_ioctl_name[cmd_id], tdx_cmd.hw_error);
+    }
+    return r;
+}
+
+static inline int tdx_vm_ioctl(int cmd_id, __u32 flags, void *data,
+                               Error **errp)
+{
+    return tdx_ioctl_internal(TDX_VM_IOCTL, NULL, cmd_id, flags, data, errp);
+}
+
+static inline int tdx_vcpu_ioctl(CPUState *cpu, int cmd_id, __u32 flags,
+                                 void *data, Error **errp)
+{
+    return  tdx_ioctl_internal(TDX_VCPU_IOCTL, cpu, cmd_id, flags, data, errp);
+}
+
+static int get_tdx_capabilities(Error **errp)
+{
+    struct kvm_tdx_capabilities *caps;
+    /* 1st generation of TDX reports 6 cpuid configs */
+    int nr_cpuid_configs = 6;
+    size_t size;
+    int r;
+
+    do {
+        Error *local_err = NULL;
+        size = sizeof(struct kvm_tdx_capabilities) +
+                      nr_cpuid_configs * sizeof(struct kvm_cpuid_entry2);
+        caps = g_malloc0(size);
+        caps->cpuid.nent = nr_cpuid_configs;
+
+        r = tdx_vm_ioctl(KVM_TDX_CAPABILITIES, 0, caps, &local_err);
+        if (r == -E2BIG) {
+            g_free(caps);
+            nr_cpuid_configs *= 2;
+            if (nr_cpuid_configs > KVM_MAX_CPUID_ENTRIES) {
+                error_report("KVM TDX seems broken that number of CPUID entries"
+                             " in kvm_tdx_capabilities exceeds limit: %d",
+                             KVM_MAX_CPUID_ENTRIES);
+                error_propagate(errp, local_err);
+                return r;
+            }
+            error_free(local_err);
+        } else if (r < 0) {
+            g_free(caps);
+            error_propagate(errp, local_err);
+            return r;
+        }
+    } while (r == -E2BIG);
+
+    tdx_caps = caps;
+
+    return 0;
+}
+
 static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
 {
+    int r = 0;
+
     kvm_mark_guest_state_protected();
 
-    return 0;
+    if (!tdx_caps) {
+        r = get_tdx_capabilities(errp);
+    }
+
+    return r;
 }
 
 static int tdx_kvm_type(X86ConfidentialGuest *cg)
-- 
2.43.0


