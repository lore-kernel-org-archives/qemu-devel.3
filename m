Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9493C47DDF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 03:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSqQX-0004T4-MI; Wed, 24 Jan 2024 22:29:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqQQ-0004Px-W7
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:29:12 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoyao.li@intel.com>)
 id 1rSqQO-0001Dy-Dx
 for qemu-devel@nongnu.org; Wed, 24 Jan 2024 22:29:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1706153348; x=1737689348;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AYw75Pw83Xl6z3/72/UUQl/0Yl2ep50dVhLqomSF5BQ=;
 b=hKM5cl/+0EX8E84aPYjY2nGVvgjxppJSVIZlTYYtABo1jOrrMnJRI8ZA
 buJgidBsWFl0IMs2J1+MSMJSU66aCFaV7/cF3pKV4DsjjOTGI62F6tyZB
 z35iqfjndEgVwXdw2lTvfvtVAQUpaEwDM4R2hMaW0JWfj1uQgzGTZ1Dyt
 0JAEIgWNZy/rDB83EGaOJ1ocpBWXKNN9nDZgeu6UoxScL2zo7QKuX7zcE
 X6kEDFuS9QXopM5F3ktjs7XDVWIF7bYZ2lzb1i8JH5JFgHnfAnlZBFWnH
 6bfs6qZMltMKMub5/CgpWOLVFCTauKdxgYJgqyB/UVvw53a4OlYohtSA+ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="9428651"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9428651"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Jan 2024 19:25:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2085556"
Received: from lxy-clx-4s.sh.intel.com ([10.239.48.52])
 by orviesa005.jf.intel.com with ESMTP; 24 Jan 2024 19:25:33 -0800
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
Subject: [PATCH v4 22/66] i386/kvm: Move architectural CPUID leaf generation
 to separate helper
Date: Wed, 24 Jan 2024 22:22:44 -0500
Message-Id: <20240125032328.2522472-23-xiaoyao.li@intel.com>
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the architectural (for lack of a better term) CPUID leaf generation
to a separate helper so that the generation code can be reused by TDX,
which needs to generate a canonical VM-scoped configuration.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
---
 target/i386/kvm/kvm.c      | 459 +++++++++++++++++++------------------
 target/i386/kvm/kvm_i386.h |   3 +
 2 files changed, 240 insertions(+), 222 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 64dfa6c36a88..8e3b491fb071 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1732,6 +1732,241 @@ static void kvm_init_nested_state(CPUX86State *env)
     }
 }
 
+uint32_t kvm_x86_arch_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
+                            uint32_t cpuid_i)
+{
+    uint32_t limit, i, j;
+    uint32_t unused;
+    struct kvm_cpuid_entry2 *c;
+
+    if (cpuid_i >  KVM_MAX_CPUID_ENTRIES) {
+        error_report("exceeded cpuid index (%d) for entries[]", cpuid_i);
+        abort();
+    }
+
+    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
+
+    for (i = 0; i <= limit; i++) {
+        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+            fprintf(stderr, "unsupported level value: 0x%x\n", limit);
+            abort();
+        }
+        c = &entries[cpuid_i++];
+
+        switch (i) {
+        case 2: {
+            /* Keep reading function 2 till all the input is received */
+            int times;
+
+            c->function = i;
+            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
+                       KVM_CPUID_FLAG_STATE_READ_NEXT;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            times = c->eax & 0xff;
+
+            for (j = 1; j < times; ++j) {
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                            "cpuid(eax:2):eax & 0xf = 0x%x\n", times);
+                    abort();
+                }
+                c = &entries[cpuid_i++];
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
+                cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            }
+            break;
+        }
+        case 0x1f:
+            if (env->nr_dies < 2) {
+                cpuid_i--;
+                break;
+            }
+            /* fallthrough */
+        case 4:
+        case 0xb:
+        case 0xd:
+            for (j = 0; ; j++) {
+                if (i == 0xd && j == 64) {
+                    break;
+                }
+
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (i == 4 && c->eax == 0) {
+                    break;
+                }
+                if (i == 0xb && !(c->ecx & 0xff00)) {
+                    break;
+                }
+                if (i == 0x1f && !(c->ecx & 0xff00)) {
+                    break;
+                }
+                if (i == 0xd && c->eax == 0) {
+                    continue;
+                }
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                    abort();
+                }
+                c = &entries[cpuid_i++];
+            }
+            break;
+        case 0x12:
+            for (j = 0; ; j++) {
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (j > 1 && (c->eax & 0xf) != 1) {
+                    break;
+                }
+
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                                "cpuid(eax:0x12,ecx:0x%x)\n", j);
+                    abort();
+                }
+                c = &entries[cpuid_i++];
+            }
+            break;
+        case 0x7:
+        case 0x14:
+        case 0x1d:
+        case 0x1e: {
+            uint32_t times;
+
+            c->function = i;
+            c->index = 0;
+            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            times = c->eax;
+
+            for (j = 1; j <= times; ++j) {
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                                "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                    abort();
+                }
+                c = &entries[cpuid_i++];
+                c->function = i;
+                c->index = j;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            }
+            break;
+        }
+        default:
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
+                /*
+                 * KVM already returns all zeroes if a CPUID entry is missing,
+                 * so we can omit it and avoid hitting KVM's 80-entry limit.
+                 */
+                cpuid_i--;
+            }
+            break;
+        }
+    }
+
+    if (limit >= 0x0a) {
+        uint32_t eax, edx;
+
+        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
+
+        has_architectural_pmu_version = eax & 0xff;
+        if (has_architectural_pmu_version > 0) {
+            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
+
+            /* Shouldn't be more than 32, since that's the number of bits
+             * available in EBX to tell us _which_ counters are available.
+             * Play it safe.
+             */
+            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
+                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
+            }
+
+            if (has_architectural_pmu_version > 1) {
+                num_architectural_pmu_fixed_counters = edx & 0x1f;
+
+                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
+                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+                }
+            }
+        }
+    }
+
+    cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
+
+    for (i = 0x80000000; i <= limit; i++) {
+        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+            fprintf(stderr, "unsupported xlevel value: 0x%x\n", limit);
+            abort();
+        }
+        c = &entries[cpuid_i++];
+
+        switch (i) {
+        case 0x8000001d:
+            /* Query for all AMD cache information leaves */
+            for (j = 0; ; j++) {
+                c->function = i;
+                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
+                c->index = j;
+                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
+
+                if (c->eax == 0) {
+                    break;
+                }
+                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                    fprintf(stderr, "cpuid_data is full, no space for "
+                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+                    abort();
+                }
+                c = &entries[cpuid_i++];
+            }
+            break;
+        default:
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
+                /*
+                 * KVM already returns all zeroes if a CPUID entry is missing,
+                 * so we can omit it and avoid hitting KVM's 80-entry limit.
+                 */
+                cpuid_i--;
+            }
+            break;
+        }
+    }
+
+    /* Call Centaur's CPUID instructions they are supported. */
+    if (env->cpuid_xlevel2 > 0) {
+        cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
+
+        for (i = 0xC0000000; i <= limit; i++) {
+            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                fprintf(stderr, "unsupported xlevel2 value: 0x%x\n", limit);
+                abort();
+            }
+            c = &entries[cpuid_i++];
+
+            c->function = i;
+            c->flags = 0;
+            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
+        }
+    }
+
+    return cpuid_i;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -1748,8 +1983,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    uint32_t limit, i, j, cpuid_i;
-    uint32_t unused;
+    uint32_t cpuid_i;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
@@ -1902,8 +2136,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->edx = env->features[FEAT_KVM_HINTS];
     }
 
-    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
-
     if (cpu->kvm_pv_enforce_cpuid) {
         r = kvm_vcpu_enable_cap(cs, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 0, 1);
         if (r < 0) {
@@ -1914,224 +2146,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         }
     }
 
-    for (i = 0; i <= limit; i++) {
-        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-            fprintf(stderr, "unsupported level value: 0x%x\n", limit);
-            abort();
-        }
-        c = &cpuid_data.entries[cpuid_i++];
-
-        switch (i) {
-        case 2: {
-            /* Keep reading function 2 till all the input is received */
-            int times;
-
-            c->function = i;
-            c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC |
-                       KVM_CPUID_FLAG_STATE_READ_NEXT;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            times = c->eax & 0xff;
-
-            for (j = 1; j < times; ++j) {
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:2):eax & 0xf = 0x%x\n", times);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_STATEFUL_FUNC;
-                cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            }
-            break;
-        }
-        case 0x1f:
-            if (env->nr_dies < 2) {
-                cpuid_i--;
-                break;
-            }
-            /* fallthrough */
-        case 4:
-        case 0xb:
-        case 0xd:
-            for (j = 0; ; j++) {
-                if (i == 0xd && j == 64) {
-                    break;
-                }
-
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                c->index = j;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-
-                if (i == 4 && c->eax == 0) {
-                    break;
-                }
-                if (i == 0xb && !(c->ecx & 0xff00)) {
-                    break;
-                }
-                if (i == 0x1f && !(c->ecx & 0xff00)) {
-                    break;
-                }
-                if (i == 0xd && c->eax == 0) {
-                    continue;
-                }
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-            }
-            break;
-        case 0x12:
-            for (j = 0; ; j++) {
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                c->index = j;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-
-                if (j > 1 && (c->eax & 0xf) != 1) {
-                    break;
-                }
-
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                                "cpuid(eax:0x12,ecx:0x%x)\n", j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-            }
-            break;
-        case 0x7:
-        case 0x14:
-        case 0x1d:
-        case 0x1e: {
-            uint32_t times;
-
-            c->function = i;
-            c->index = 0;
-            c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            times = c->eax;
-
-            for (j = 1; j <= times; ++j) {
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                                "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-                c->function = i;
-                c->index = j;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            }
-            break;
-        }
-        default:
-            c->function = i;
-            c->flags = 0;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
-                /*
-                 * KVM already returns all zeroes if a CPUID entry is missing,
-                 * so we can omit it and avoid hitting KVM's 80-entry limit.
-                 */
-                cpuid_i--;
-            }
-            break;
-        }
-    }
-
-    if (limit >= 0x0a) {
-        uint32_t eax, edx;
-
-        cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
-
-        has_architectural_pmu_version = eax & 0xff;
-        if (has_architectural_pmu_version > 0) {
-            num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
-
-            /* Shouldn't be more than 32, since that's the number of bits
-             * available in EBX to tell us _which_ counters are available.
-             * Play it safe.
-             */
-            if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
-                num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
-            }
-
-            if (has_architectural_pmu_version > 1) {
-                num_architectural_pmu_fixed_counters = edx & 0x1f;
-
-                if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
-                    num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
-                }
-            }
-        }
-    }
-
-    cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
-
-    for (i = 0x80000000; i <= limit; i++) {
-        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-            fprintf(stderr, "unsupported xlevel value: 0x%x\n", limit);
-            abort();
-        }
-        c = &cpuid_data.entries[cpuid_i++];
-
-        switch (i) {
-        case 0x8000001d:
-            /* Query for all AMD cache information leaves */
-            for (j = 0; ; j++) {
-                c->function = i;
-                c->flags = KVM_CPUID_FLAG_SIGNIFCANT_INDEX;
-                c->index = j;
-                cpu_x86_cpuid(env, i, j, &c->eax, &c->ebx, &c->ecx, &c->edx);
-
-                if (c->eax == 0) {
-                    break;
-                }
-                if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                    fprintf(stderr, "cpuid_data is full, no space for "
-                            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
-                    abort();
-                }
-                c = &cpuid_data.entries[cpuid_i++];
-            }
-            break;
-        default:
-            c->function = i;
-            c->flags = 0;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-            if (!c->eax && !c->ebx && !c->ecx && !c->edx) {
-                /*
-                 * KVM already returns all zeroes if a CPUID entry is missing,
-                 * so we can omit it and avoid hitting KVM's 80-entry limit.
-                 */
-                cpuid_i--;
-            }
-            break;
-        }
-    }
-
-    /* Call Centaur's CPUID instructions they are supported. */
-    if (env->cpuid_xlevel2 > 0) {
-        cpu_x86_cpuid(env, 0xC0000000, 0, &limit, &unused, &unused, &unused);
-
-        for (i = 0xC0000000; i <= limit; i++) {
-            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
-                fprintf(stderr, "unsupported xlevel2 value: 0x%x\n", limit);
-                abort();
-            }
-            c = &cpuid_data.entries[cpuid_i++];
-
-            c->function = i;
-            c->flags = 0;
-            cpu_x86_cpuid(env, i, 0, &c->eax, &c->ebx, &c->ecx, &c->edx);
-        }
-    }
-
+    cpuid_i = kvm_x86_arch_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index c3ef46a97a7b..cbf52c1c6d17 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -24,6 +24,9 @@
 #define kvm_ioapic_in_kernel() \
     (kvm_irqchip_in_kernel() && !kvm_irqchip_is_split())
 
+uint32_t kvm_x86_arch_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
+                            uint32_t cpuid_i);
+
 #else
 
 #define kvm_pit_in_kernel()      0
-- 
2.34.1


