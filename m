Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87FFEEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvS-00061B-Qg; Thu, 12 Feb 2026 09:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvQ-0005wP-10
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvM-0006GE-Qj
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7MAK39Fchg9SvJj6pNbo856+vTQzOZL0gnweEU9gzss=;
 b=TockhLh80z38E9LfW+3TRcsnZVt6s5HTKpZBUllP7vRC9B2bTWhACld3nB14/DP3KF4ND4
 9H0kyIG31+pVFAqYNboDVTP6JFkHeoPM09nGrv984e1k98L6Cum2wuvrSo6BM3AhALgz1c
 pZ4V1ja9d4xP/i7ovvnEBDH/09ZHGaA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-n_WQBHmqO4-JgALnoIZP_A-1; Thu, 12 Feb 2026 09:44:06 -0500
X-MC-Unique: n_WQBHmqO4-JgALnoIZP_A-1
X-Mimecast-MFC-AGG-ID: n_WQBHmqO4-JgALnoIZP_A_1770907446
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4831192e66aso70117345e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907445; x=1771512245; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7MAK39Fchg9SvJj6pNbo856+vTQzOZL0gnweEU9gzss=;
 b=Kz9LV1NkkOwrORs/o1dBmb6JUDxPAotCCbHO6mZ24DJrX8Xqfr5AdxkhRvM8YRmKHq
 mPCkU+0osP1RgrsdKVh4niHpRjnQshAiwOrEc+bPHDzNjOGJJvdO2iuutIVuWkW9OQqJ
 jWZOa7O3/W9mh+3/27sFMZQ+txpA9/HcDZRh3Ji+5T2p42XxlhoAwbWe60P6VYSthTX/
 L4yZ48APnBqXLdenDfOuq4PrWs8lXr6ssPPdhoDMRcBIIAUanMrlD94FAIgi2QNDKLNg
 SM0FVigCW0AIMhJGNmvQqbzrN3sXTxrKbUYph4QCPdBOKNVyfgsGwzhmRhIdYd+wiCJm
 Z21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907445; x=1771512245;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7MAK39Fchg9SvJj6pNbo856+vTQzOZL0gnweEU9gzss=;
 b=HttJBcK3yHV5I76PO1OLBALjKC1J8lb0qAKCJNitYvK73rc5i/sSF1Uy+nuJBRSFC6
 PZsyIncLjApCLSTbJUxQOwxRDOk4NGhJwLZoUBuL/bI0mS0JADfYxGX3jWfv+WkWi33a
 8tjoKuCVer7yVRiuKRLC8vIdB8Hgm7GDtiLi3ee9iq6EJ+UAj1zUmPpHMdySoW3wutmy
 OPpUL7lXazCPJqLwSqak8BwzUh859zb1MqeOyJwl2yihRd1R9ZJDwU2vsYjoT41ynQ1o
 tA8p/tFWq3o5DzSbrCn9iyvJvudda0D7abIqf310O22R992DrdZXKo9tsLiYKyAkKL6Z
 Y2xg==
X-Gm-Message-State: AOJu0YzAAihGA3ecUQa6sEFE4zetKvKW7CGZmO1uJ0VEBigjofw5DADE
 mxQRC15OWLrpaySJpRytdRdWGknMqkK2FllcHSvL8QMSolDJl3Dk5YLReg6FPWrUsK/mdpzp66T
 94feBvnh4KZ6Mce13C8ck4qE8E+jFsenDlZY870bmcL5HZ1HazvCT0zJXYxa2P5pqiQ2XBwaUT5
 BuW30NnsR7qbAUOuyjJo0p5Xs/TWThRto6unnYstGn
X-Gm-Gg: AZuq6aJ41jr1sZe4Uw1yV3PKewoUUf8s8GKUgj3SLdNWB7ZbQ4Yp+l78ahCp2j7TET1
 xJtzqLQWtFY2AJDbcPiKf0OMfKjNP0Uq0aSTyqQXaRmcUsbm0m4UjJSQJSBhK+JWkI+I1ukCkvm
 tsYbwC3XU3tjLDlqCTvg0fVuKnJgXjuajd0QasB8Q+6Z/4OOlQXMqiqFJDhaN2yR0Mcy5cDzsEK
 2H98GTtuEJB+2NSXAO/rl4f1t/tWVYIJji553osk4WT8AzVPkrgw9ehoMXlotz4ZBpNOVzIGjzT
 L9SttXryG8xa71N4ZXMcVUGFk+D2ZOoUQHi9A6HZhXZymujmGfxcJlGKw0PQe0JBttFu5u75q6U
 wx2/GkZXHNqgiwUYzsN0I7ArJRKW941qF6SG8K9tOp1mqE4hvvEbJMLPoYZfNbplzKnOAKzktHv
 LsZtQKk23Gs5RdXQFbpHtffhQTfMggcl26PQqKiOTFV1y3iALPo7c=
X-Received: by 2002:a05:600c:4e91:b0:483:ea6:8767 with SMTP id
 5b1f17b1804b1-4836571fe86mr47862555e9.36.1770907444544; 
 Thu, 12 Feb 2026 06:44:04 -0800 (PST)
X-Received: by 2002:a05:600c:4e91:b0:483:ea6:8767 with SMTP id
 5b1f17b1804b1-4836571fe86mr47861925e9.36.1770907443879; 
 Thu, 12 Feb 2026 06:44:03 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835a5bf1efsm93529385e9.0.2026.02.12.06.44.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Sandipan Das <sandipan.das@amd.com>, Zide Chen <zide.chen@intel.com>
Subject: [PULL 34/41] target/i386/kvm: support perfmon-v2 for reset
Date: Thu, 12 Feb 2026 15:42:36 +0100
Message-ID: <20260212144244.22579-35-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Dongli Zhang <dongli.zhang@oracle.com>

Since perfmon-v2, the AMD PMU supports additional registers. This update
includes get/put functionality for these extra registers.

Similar to the implementation in KVM:

- MSR_CORE_PERF_GLOBAL_STATUS and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS both
use env->msr_global_status.
- MSR_CORE_PERF_GLOBAL_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_CTL both use
env->msr_global_ctrl.
- MSR_CORE_PERF_GLOBAL_OVF_CTRL and MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR
both use env->msr_global_ovf_ctrl.

No changes are needed for vmstate_msr_architectural_pmu or
pmu_enable_needed().

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20260109075508.113097-6-dongli.zhang@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h     |  4 ++++
 target/i386/kvm/kvm.c | 48 +++++++++++++++++++++++++++++++++++--------
 2 files changed, 43 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index cf02472fc79..9f222a0c9fe 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -506,6 +506,10 @@ typedef enum X86Seg {
 #define MSR_CORE_PERF_GLOBAL_CTRL       0x38f
 #define MSR_CORE_PERF_GLOBAL_OVF_CTRL   0x390
 
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS       0xc0000300
+#define MSR_AMD64_PERF_CNTR_GLOBAL_CTL          0xc0000301
+#define MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR   0xc0000302
+
 #define MSR_K7_EVNTSEL0                 0xc0010000
 #define MSR_K7_PERFCTR0                 0xc0010004
 #define MSR_F15H_PERF_CTL0              0xc0010200
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7ebb96c66f2..9f1a4d4cbb2 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2157,6 +2157,16 @@ static void kvm_init_pmu_info_amd(struct kvm_cpuid2 *cpuid, X86CPU *cpu)
     }
 
     num_pmu_gp_counters = AMD64_NUM_COUNTERS_CORE;
+
+    c = cpuid_find_entry(cpuid, 0x80000022, 0);
+    if (c && (c->eax & CPUID_8000_0022_EAX_PERFMON_V2)) {
+        pmu_version = 2;
+        num_pmu_gp_counters = c->ebx & 0xf;
+
+        if (num_pmu_gp_counters > MAX_GP_COUNTERS) {
+            num_pmu_gp_counters = MAX_GP_COUNTERS;
+        }
+    }
 }
 
 static bool is_host_compat_vendor(CPUX86State *env)
@@ -4219,13 +4229,14 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
             uint32_t step = 1;
 
             /*
-             * When PERFCORE is enabled, AMD PMU uses a separate set of
-             * addresses for the selector and counter registers.
-             * Additionally, the address of the next selector or counter
-             * register is determined by incrementing the address of the
-             * current register by two.
+             * When PERFCORE or PerfMonV2 is enabled, AMD PMU uses a
+             * separate set of addresses for the selector and counter
+             * registers. Additionally, the address of the next selector or
+             * counter register is determined by incrementing the address
+             * of the current register by two.
              */
-            if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
+            if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE ||
+                pmu_version > 1) {
                 sel_base = MSR_F15H_PERF_CTL0;
                 ctr_base = MSR_F15H_PERF_CTR0;
                 step = 2;
@@ -4237,6 +4248,15 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                 kvm_msr_entry_add(cpu, sel_base + i * step,
                                   env->msr_gp_evtsel[i]);
             }
+
+            if (pmu_version > 1) {
+                kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS,
+                                  env->msr_global_status);
+                kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+                                  env->msr_global_ovf_ctrl);
+                kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL,
+                                  env->msr_global_ctrl);
+            }
         }
 
         /*
@@ -4771,13 +4791,14 @@ static int kvm_get_msrs(X86CPU *cpu)
         uint32_t step = 1;
 
         /*
-         * When PERFCORE is enabled, AMD PMU uses a separate set of
-         * addresses for the selector and counter registers.
+         * When PERFCORE or PerfMonV2 is enabled, AMD PMU uses a separate
+         * set of addresses for the selector and counter registers.
          * Additionally, the address of the next selector or counter
          * register is determined by incrementing the address of the
          * current register by two.
          */
-        if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE) {
+        if (num_pmu_gp_counters == AMD64_NUM_COUNTERS_CORE ||
+            pmu_version > 1) {
             sel_base = MSR_F15H_PERF_CTL0;
             ctr_base = MSR_F15H_PERF_CTR0;
             step = 2;
@@ -4787,6 +4808,12 @@ static int kvm_get_msrs(X86CPU *cpu)
             kvm_msr_entry_add(cpu, ctr_base + i * step, 0);
             kvm_msr_entry_add(cpu, sel_base + i * step, 0);
         }
+
+        if (pmu_version > 1) {
+            kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+            kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS, 0);
+            kvm_msr_entry_add(cpu, MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, 0);
+        }
     }
 
     if (env->mcg_cap) {
@@ -5102,12 +5129,15 @@ static int kvm_get_msrs(X86CPU *cpu)
             env->msr_fixed_ctr_ctrl = msrs[i].data;
             break;
         case MSR_CORE_PERF_GLOBAL_CTRL:
+        case MSR_AMD64_PERF_CNTR_GLOBAL_CTL:
             env->msr_global_ctrl = msrs[i].data;
             break;
         case MSR_CORE_PERF_GLOBAL_STATUS:
+        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS:
             env->msr_global_status = msrs[i].data;
             break;
         case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
+        case MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR:
             env->msr_global_ovf_ctrl = msrs[i].data;
             break;
         case MSR_CORE_PERF_FIXED_CTR0 ... MSR_CORE_PERF_FIXED_CTR0 + MAX_FIXED_COUNTERS - 1:
-- 
2.52.0


