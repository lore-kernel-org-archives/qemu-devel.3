Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B209EFCE37
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 18:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxqkl-0005Pg-Is; Wed, 04 Mar 2026 13:15:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqkk-0005Oy-3q
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:22 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zide.chen@intel.com>)
 id 1vxqki-0004QO-4U
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 13:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772648121; x=1804184121;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=X0RhNp4kFh3eTI5/C0Btaql1BvfL9t2YBq/nYxoIqMY=;
 b=TMxwSRYAhlPXrgb2BYhTwm7N+ZLS6paYN6JnAHtW6L4bOm5gzHo1NimA
 a/wW/1GXy9ZuGyenGOaB7OACyVW4iZaB80etcaLjXCZRczNGJThUfGvRi
 UAUsF4BD2W4x6VB1kzInqkJuZ2zyU35flyM/XJy04jdCiHkp7OCuMe047
 /m/2tnEmW/HPOs2d94zJ18nx/OvmrGSeSGk0sj9gO2nH7jb5yvfqy2p/U
 MSmHFJXJnCV30QMECAYHX16esxDKT1ujjRJdxjYE5uJdxz8Nfpyu3qnpO
 ao9sgwUpUey50QUX7AXWNA0GkElbsjd4+Dgme90NhSnrYUuEP630eGvrs w==;
X-CSE-ConnectionGUID: 9D+zlf4gRLibzx4dLlfuKQ==
X-CSE-MsgGUID: ZVERVciiRDKXnWeF1aBYJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="73909326"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="73909326"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:15 -0800
X-CSE-ConnectionGUID: 3kSr4sIlSxGMip9pgPb8jg==
X-CSE-MsgGUID: 7WJ63Z9eQkepkTpA1uHA1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; d="scan'208";a="214542808"
Received: from 9cc2c43eec6b.jf.intel.com ([10.54.77.43])
 by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 10:15:14 -0800
From: Zide Chen <zide.chen@intel.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Sandipan Das <sandipan.das@amd.com>
Cc: Xiaoyao Li <xiaoyao.li@intel.com>, Dongli Zhang <dongli.zhang@oracle.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PATCH V3 06/13] target/i386: Increase MSR_BUF_SIZE and split
 KVM_[GET/SET]_MSRS calls
Date: Wed,  4 Mar 2026 10:07:05 -0800
Message-ID: <20260304180713.360471-7-zide.chen@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304180713.360471-1-zide.chen@intel.com>
References: <20260304180713.360471-1-zide.chen@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=198.175.65.16; envelope-from=zide.chen@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Zide Chen <zide.chen@intel.com>
---
v3:
- Address Dapeng's comments.
---
 target/i386/kvm/kvm.c | 110 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 92 insertions(+), 18 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 39a67c58ac22..4ba54151320f 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -97,9 +97,12 @@
 #define KVM_APIC_BUS_CYCLE_NS       1
 #define KVM_APIC_BUS_FREQUENCY      (1000000000ULL / KVM_APIC_BUS_CYCLE_NS)
 
-/* A 4096-byte buffer can hold the 8-byte kvm_msrs header, plus
- * 255 kvm_msr_entry structs */
-#define MSR_BUF_SIZE 4096
+/* A 8192-byte buffer can hold the 8-byte kvm_msrs header, plus
+ * 511 kvm_msr_entry structs */
+#define MSR_BUF_SIZE      8192
+
+/* Maximum number of MSRs in one single KVM_[GET/SET]_MSRS call. */
+#define KVM_MAX_IO_MSRS   255
 
 typedef bool QEMURDMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t *val);
 typedef bool QEMUWRMSRHandler(X86CPU *cpu, uint32_t msr, uint64_t val);
@@ -4016,21 +4019,99 @@ static void kvm_msr_entry_add_perf(X86CPU *cpu, FeatureWordArray f)
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
@@ -4066,7 +4147,7 @@ static void kvm_init_msrs(X86CPU *cpu)
     if (has_msr_ucode_rev) {
         kvm_msr_entry_add(cpu, MSR_IA32_UCODE_REV, cpu->ucode_rev);
     }
-    assert(kvm_buf_set_msrs(cpu) == 0);
+    kvm_buf_set_msrs(cpu);
 }
 
 static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
@@ -4959,18 +5040,11 @@ static int kvm_get_msrs(X86CPU *cpu)
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
2.53.0


