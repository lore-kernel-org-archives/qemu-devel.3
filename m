Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785ABCD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 03:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUyNv-0001Wa-5X; Wed, 03 Jun 2026 23:04:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNt-0001T0-4I
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:41 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1wUyNr-0007sV-5v
 for qemu-devel@nongnu.org; Wed, 03 Jun 2026 23:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780542279; x=1812078279;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7IrbNTGaHeKOVrxzFjq7meMvrGXDzTJWWuaUASD7OJ8=;
 b=Pl9KpnBmLmn1MZL4VJ50hHrfvqPwovN9wT26Uhv9HtL0cHfvh/tX3gPU
 jTZIkvA8hsnpCjPzZGJajmdINFqN8UbiPNPgTcyk8qfkjEBhNhsSZ4GAS
 lvf8ioGOvvKJXLNwkQaeFMMx48Z53svMpse1NKOS8GR74NJl+DE9gZu5z
 ta56Ueb4PhjavyysJU7mVsSQLJjhUFdbtU6GSINKFu5I79D0igg5UYsFS
 N/bapxqu7GDsrHfUJWQgrA/yn9HE9qxy+azWQ78R81KCnLO1mqL1Zb+0W
 GWUFYANYYxPw8DXdmU1miRdavgnN/xCxkx6LIdEi4tVlE9jVr6lnavCPq w==;
X-CSE-ConnectionGUID: pozFYZR1QQuRJBAhuRRJEA==
X-CSE-MsgGUID: FJZzUm5BTyan/KdkUcRUUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="80399649"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="80399649"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:29 -0700
X-CSE-ConnectionGUID: R55l5KQNT7ujpkmLghg67g==
X-CSE-MsgGUID: 17oPsdMmRqCpBHtIAuf1yg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; d="scan'208";a="241915849"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.29])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2026 20:04:28 -0700
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH v4 5/6] target/i386: Increase MSR_BUF_SIZE and split
 KVM_[GET/SET]_MSRS calls
Date: Wed,  3 Jun 2026 19:55:45 -0700
Message-ID: <20260604025546.19378-6-zide.chen@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604025546.19378-1-zide.chen@intel.com>
References: <20260604025546.19378-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.198.163.19; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Newer Intel server CPUs support a large number of PMU MSRs.  Currently,
QEMU allocates cpu->kvm_msr_buf as a single-page buffer, which is not
sufficient to hold all possible MSRs.

Increase MSR_BUF_SIZE to 8192 bytes, providing space for up to 511 MSRs.
This is sufficient even for the theoretical worst case, such as
architectural LBR with a depth of 64.

KVM_[GET/SET]_MSRS is limited to 255 MSRs per call.  Raising this limit
to 511 would require changes in KVM and would introduce backward
compatibility issues.  Instead, split requests into multiple
KVM_[GET/SET]_MSRS calls when the number of MSRs exceeds the API limit.

Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v4:
- Add assert on kvm_init_msrs() to catch the error of KVM_SET_MSRS
  has negative return.
v3:
- Address Dapeng's comments.
---
 target/i386/kvm/kvm.c | 110 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a99c1dba83f2..9b6407794e43 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -97,9 +97,12 @@
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
 
-/* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
- * 255 kvm_msr_entry structs */
-#define MSR_BUF_SIZE 4096
+/* An 8192-byte buffer can hold the 8-byte kvm_msrs header, plus
+ * 511 kvm_msr_entry structs */
+#define MSR_BUF_SIZE      8192
+
+/* Maximum number of MSRs in one single KVM_[GET/SET]_MSRS call. */
+#define KVM_MAX_IO_MSRS   255
 
 typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
 typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
@@ -4099,21 +4102,99 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
     }
 }
 
-static int kvm_buf_set_msrs(X86CPU *cpu)
+static int __kvm_buf_set_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
 {
-    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, cpu->kvm_msr_buf);
+    int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MSRS, msrs);
     if (ret < 0) {
         return ret;
     }
 
-    if (ret < cpu->kvm_msr_buf->nmsrs) {
-        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
+    if (ret < msrs->nmsrs) {
+        struct kvm_msr_entry *e = &msrs->entries[ret];
         error_report("error: failed to set MSR 0x%" PRIx32 " to 0x%" PRIx64,
                      (uint32_t)e->index, (uint64_t)e->data);
     }
 
-    assert(ret == cpu->kvm_msr_buf->nmsrs);
-    return 0;
+    assert(ret == msrs->nmsrs);
+    return ret;
+}
+
+static int __kvm_buf_get_msrs(X86CPU *cpu, struct kvm_msrs *msrs)
+{
+    int ret;
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, msrs);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (ret < msrs->nmsrs) {
+        struct kvm_msr_entry *e = &msrs->entries[ret];
+        error_report("error: failed to get MSR 0x%" PRIx32,
+                     (uint32_t)e->index);
+    }
+
+    assert(ret == msrs->nmsrs);
+    return ret;
+}
+
+static int kvm_buf_set_or_get_msrs(X86CPU *cpu, bool is_write)
+{
+    struct kvm_msr_entry *entries = cpu->kvm_msr_buf->entries;
+    struct kvm_msrs *buf = NULL;
+    int current, remaining, ret = 0;
+    size_t buf_size;
+
+    buf_size = KVM_MAX_IO_MSRS * sizeof(struct kvm_msr_entry) +
+               sizeof(struct kvm_msrs);
+    buf = g_malloc(buf_size);
+
+    remaining = cpu->kvm_msr_buf->nmsrs;
+    current = 0;
+    while (remaining) {
+        size_t size;
+
+        memset(buf, 0, buf_size);
+
+        if (remaining > KVM_MAX_IO_MSRS) {
+            buf->nmsrs = KVM_MAX_IO_MSRS;
+        } else {
+            buf->nmsrs = remaining;
+        }
+
+        size = buf->nmsrs * sizeof(entries[0]);
+        memcpy(buf->entries, &entries[current], size);
+
+        if (is_write) {
+            ret = __kvm_buf_set_msrs(cpu, buf);
+        } else {
+            ret = __kvm_buf_get_msrs(cpu, buf);
+        }
+
+        if (ret < 0) {
+            goto out;
+        }
+
+        if (!is_write)
+            memcpy(&entries[current], buf->entries, size);
+
+        current += buf->nmsrs;
+        remaining -= buf->nmsrs;
+    }
+
+out:
+    g_free(buf);
+    return ret < 0 ? ret : cpu->kvm_msr_buf->nmsrs;
+}
+
+static inline int kvm_buf_set_msrs(X86CPU *cpu)
+{
+    return kvm_buf_set_or_get_msrs(cpu, true);
+}
+
+static inline int kvm_buf_get_msrs(X86CPU *cpu)
+{
+    return kvm_buf_set_or_get_msrs(cpu, false);
 }
 
 static void kvm_init_msrs(X86CPU *cpu)
@@ -4149,7 +4230,7 @@ static void kvm_init_msrs(X86CPU *cpu)
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-    assert(kvm_buf_set_msrs(cpu) == 0);
+    assert(kvm_buf_set_msrs(cpu) == cpu->kvm_msr_buf->nmsrs);
 }
 
 static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
@@ -5042,18 +5123,11 @@ static int kvm_get_msrs(X86CPU *cpu)
         }
     }
 
-    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_MSRS, cpu->kvm_msr_buf);
+    ret = kvm_buf_get_msrs(cpu);
     if (ret < 0) {
         return ret;
     }
 
-    if (ret < cpu->kvm_msr_buf->nmsrs) {
-        struct kvm_msr_entry *e = &cpu->kvm_msr_buf->entries[ret];
-        error_report("error: failed to get MSR 0x%" PRIx32,
-                     (uint32_t)e->index);
-    }
-
-    assert(ret == cpu->kvm_msr_buf->nmsrs);
     /*
      * MTRR masks: Each mask consists of 5 parts
      * a  10..0: must be zero
-- 
2.54.0


