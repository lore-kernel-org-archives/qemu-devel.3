Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB621C10F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:16:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHnh-0007Ze-RR; Tue, 23 Apr 2024 11:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHms-0004WE-Po
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rzHmo-00009y-Iz
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:10:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713885021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTEbc5jgVQXZ/RZv75H5z1eYYw1HNJWbE4/8Ao49CcA=;
 b=iuM9HzZiadNfGk2f86wLdWt+czUJODq5cgaIZtL4oWBwSrx0Jzy2HmSbWO5O9C7BspRkVR
 wyAIgFOeMdzaj2Y2iAQgq8lX9ziBWdChcNuKkogrLuq4In/aiHTJ7+igjt30DM4I/RKtRb
 bZbBVPdzDVRbmlcqO8d24Vj7yoFCe3U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-VKMIdX4oP8ucc4A-vMMZ_Q-1; Tue,
 23 Apr 2024 11:10:19 -0400
X-MC-Unique: VKMIdX4oP8ucc4A-vMMZ_Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A4423C23FCB;
 Tue, 23 Apr 2024 15:10:19 +0000 (UTC)
Received: from avogadro.lan (unknown [10.39.192.70])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 72DFD2026D0A;
 Tue, 23 Apr 2024 15:10:18 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sean Christopherson <sean.j.christopherson@intel.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 25/63] i386/kvm: Move architectural CPUID leaf generation to
 separate helper
Date: Tue, 23 Apr 2024 17:09:13 +0200
Message-ID: <20240423150951.41600-26-pbonzini@redhat.com>
In-Reply-To: <20240423150951.41600-1-pbonzini@redhat.com>
References: <20240423150951.41600-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Sean Christopherson <sean.j.christopherson@intel.com>

Move the architectural (for lack of a better term) CPUID leaf generation
to a separate helper so that the generation code can be reused by TDX,
which needs to generate a canonical VM-scoped configuration.

For now this is just a cleanup, so keep the function static.

Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20240229063726.610065-23-xiaoyao.li@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 449 +++++++++++++++++++++---------------------
 1 file changed, 227 insertions(+), 222 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e68cbe92930..fcf9603d3e6 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1706,6 +1706,231 @@ static void kvm_init_nested_state(CPUX86State *env)
     }
 }
 
+static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
+                                    struct kvm_cpuid_entry2 *entries,
+                                    uint32_t cpuid_i)
+{
+    uint32_t limit, i, j;
+    uint32_t unused;
+    struct kvm_cpuid_entry2 *c;
+
+    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
+
+    for (i = 0; i <= limit; i++) {
+        j = 0;
+        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+            goto full;
+        }
+        c = &entries[cpuid_i++];
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
+                    goto full;
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
+                    goto full;
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
+                    goto full;
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
+                    goto full;
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
+        j = 0;
+        c = &entries[cpuid_i++];
+        if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+            goto full;
+        }
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
+                    goto full;
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
+            j = 0;
+            if (cpuid_i == KVM_MAX_CPUID_ENTRIES) {
+                goto full;
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
+
+full:
+    fprintf(stderr, "cpuid_data is full, no space for "
+            "cpuid(eax:0x%x,ecx:0x%x)\n", i, j);
+    abort();
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -1722,8 +1947,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
 
     X86CPU *cpu = X86_CPU(cs);
     CPUX86State *env = &cpu->env;
-    uint32_t limit, i, j, cpuid_i;
-    uint32_t unused;
+    uint32_t cpuid_i;
     struct kvm_cpuid_entry2 *c;
     uint32_t signature[3];
     int kvm_base = KVM_CPUID_SIGNATURE;
@@ -1876,8 +2100,6 @@ int kvm_arch_init_vcpu(CPUState *cs)
         c->edx = env->features[FEAT_KVM_HINTS];
     }
 
-    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
-
     if (cpu->kvm_pv_enforce_cpuid) {
         r = kvm_vcpu_enable_cap(cs, KVM_CAP_ENFORCE_PV_FEATURE_CPUID, 0, 1);
         if (r < 0) {
@@ -1888,224 +2110,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
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
+    cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
     if (((env->cpuid_version >> 8)&0xF) >= 6
-- 
2.44.0



