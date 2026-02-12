Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D654EE3691
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvT-00061y-Lu; Thu, 12 Feb 2026 09:44:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvH-0005lH-Lc
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvF-0006Es-UU
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcpWkpn50Ck93z02v0fM6JJavzwotApdJbS9F2TxzKM=;
 b=MQswgGd2vXI1eTqvdvOuRRsUBq8HvcvOYn1D765KHvzzCZfcZQ2F5ktDaOOd4Y2v+Gam4Z
 aOOc1Jf1jN964nUzj+ykzMkAWbqhF9F86kwA4qpUCqfKjJ3mpSujEzBQviTJ0lV02htk+v
 YpFNG7rV2w+GGlFtEUPDcv2OiYvvTZk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-JVrkV2LkPUKX7hABqGz3_Q-1; Thu, 12 Feb 2026 09:43:59 -0500
X-MC-Unique: JVrkV2LkPUKX7hABqGz3_Q-1
X-Mimecast-MFC-AGG-ID: JVrkV2LkPUKX7hABqGz3_Q_1770907439
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836cd6dfe6so4553225e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907438; x=1771512238; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcpWkpn50Ck93z02v0fM6JJavzwotApdJbS9F2TxzKM=;
 b=Cku+KMlf6UOQlSzDhjac61psCgb+CQbMWZGGyUtJjAYri1ZcNy69D2xMCW8Dg6k/X5
 J+pgYUx53Lbc4TIPggthm0JiqCLxB1JZ7C7ZRtCnjQYFGUqsPS7YLsbB1kibZBwg2g/y
 t25VNdHNjYkDDQZ8L6WNEAuJkR1/DNCf5ZzyXpKPguvKQhejOauMaMxzwmFJgsF8VPdB
 mliwBD+W9+Hw2bqkQSPgT0TOARLQepeR/8Cz5/ls5rE+iaX7bEUDY56zQ5DHmtxG8PeB
 iJly2EcOq4dseTpwAXdxtwo5S7pgw75goX24foooFYo0z2ZxncMRfzH485yGPzEyHNKt
 ernQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907438; x=1771512238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bcpWkpn50Ck93z02v0fM6JJavzwotApdJbS9F2TxzKM=;
 b=aBK2UB9rvKUh7n71QcDN4lKyJMMmx77dfERksrzoyEoylap3NjAm5qhqjFOYuX+ju6
 ViiUnlHzW+n9SG7HWiZWS4q66mvSFxMhzcR3hV+XPPRaO8psOIpQGn/HB8NQQJc1QKK5
 ls7AYcp05NSGksHwk1369eqUrO2op4mpbgv8lTNxDXgj8638lr7i/YKOdpTvgb4vtGI5
 cHvtnvBJa3LIPFqLfOxjMuLbkt+GSuXITckM+KwJo6ojhf8xWGSmN2kAlx/6URtaGYAA
 oGLVGa4d7h/tbq5bvWmpBPXW2GFSIG88/N4l3lXUmURfNWcygzGCqUUZ0mnU9is/nVhQ
 oPDQ==
X-Gm-Message-State: AOJu0Yz4t7onxeVrgjrt01hG8aqVbsLOSdyf05UW9eVdZkAgG6FvJEMJ
 s949QCp6X2SqB1dEs6eUnMQ7RMKcUJezZWi3b8nPOXY1R90cSI4SXjWWddt8VAzUJk2+oVoYtoe
 6igUr5xedCfXeuaaa11Ey9yiITySEtLnluREfG72NtTRT9pnKLTthWHN6FcmCik+TSVu6wGbUPh
 a8LNIiVSir6qOdUcPBG9lRICftseezrdGHe4X/4NEU
X-Gm-Gg: AZuq6aJDmCeymyK7noCoKFLJYhBGcMcdxUEyFB424ehDRnD66CIJ4uLJ7mvLo+vKAJ/
 ZdHSCF1ZMNPCICQVIFUdV3CxdTB05nVEXRfltYsPuASxAK9FjkmfV/2eCEGC/W58zaQJKAOY1EA
 8nk1jhpZcOwDo3Et7oY/JPkhMp4howoiXGzZfoivl0y10cEQ7Lmimv4jTf1S8oghSFvuKQBUmp9
 GN0bqDdXb/Tkp5BSDSc2+fkmvXqj4UbIKJC1FlRZCeeoZRodmSlZWfH6dLTXxsFwz5H6YhHNAa+
 RQuLKitStN15cLQjXARO8OT4hDPWeauf9Z51RnTaO4nB6P/chi/2lSszqGdYg2tJxNZXsIUtnnm
 W5xo/LypJKD7kp5ZfUD0TWGuEKVNyJBTMLCUyS67SJBfKciGc9B2NAr4RGq8MeZ58ebg1lSvgq9
 +/O160uSLDndPFDHdOnWY9rP2nBWusQQuj4+7U7H04/ljFJazf0OA=
X-Received: by 2002:a05:600c:3f1b:b0:482:ef72:5787 with SMTP id
 5b1f17b1804b1-483656ae605mr38410175e9.1.1770907437668; 
 Thu, 12 Feb 2026 06:43:57 -0800 (PST)
X-Received: by 2002:a05:600c:3f1b:b0:482:ef72:5787 with SMTP id
 5b1f17b1804b1-483656ae605mr38409695e9.1.1770907437101; 
 Thu, 12 Feb 2026 06:43:57 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d82a4c4sm353885065e9.10.2026.02.12.06.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:43:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Dongli Zhang <dongli.zhang@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, Zide Chen <zide.chen@intel.com>
Subject: [PULL 31/41] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
Date: Thu, 12 Feb 2026 15:42:33 +0100
Message-ID: <20260212144244.22579-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The initialization of 'has_architectural_pmu_version',
'num_architectural_pmu_gp_counters', and
'num_architectural_pmu_fixed_counters' is unrelated to the process of
building the CPUID.

Extract them out of kvm_x86_build_cpuid().

In addition, use cpuid_find_entry() instead of cpu_x86_cpuid(), because
CPUID has already been filled at this stage.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Reviewed-by: Zide Chen <zide.chen@intel.com>
Link: https://lore.kernel.org/r/20260109075508.113097-3-dongli.zhang@oracle.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 69748420fd6..31e8ef87aab 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1985,33 +1985,6 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
         }
     }
 
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
     cpu_x86_cpuid(env, 0x80000000, 0, &limit, &unused, &unused, &unused);
 
     for (i = 0x80000000; i <= limit; i++) {
@@ -2115,6 +2088,39 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     return 0;
 }
 
+static void kvm_init_pmu_info(struct kvm_cpuid2 *cpuid)
+{
+    struct kvm_cpuid_entry2 *c;
+
+    c = cpuid_find_entry(cpuid, 0xa, 0);
+
+    if (!c) {
+        return;
+    }
+
+    has_architectural_pmu_version = c->eax & 0xff;
+    if (has_architectural_pmu_version > 0) {
+        num_architectural_pmu_gp_counters = (c->eax & 0xff00) >> 8;
+
+        /*
+         * Shouldn't be more than 32, since that's the number of bits
+         * available in EBX to tell us _which_ counters are available.
+         * Play it safe.
+         */
+        if (num_architectural_pmu_gp_counters > MAX_GP_COUNTERS) {
+            num_architectural_pmu_gp_counters = MAX_GP_COUNTERS;
+        }
+
+        if (has_architectural_pmu_version > 1) {
+            num_architectural_pmu_fixed_counters = c->edx & 0x1f;
+
+            if (num_architectural_pmu_fixed_counters > MAX_FIXED_COUNTERS) {
+                num_architectural_pmu_fixed_counters = MAX_FIXED_COUNTERS;
+            }
+        }
+    }
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
@@ -2305,6 +2311,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
+    kvm_init_pmu_info(&cpuid_data.cpuid);
+
     if (x86_cpu_family(env->cpuid_version) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)) {
-- 
2.52.0


