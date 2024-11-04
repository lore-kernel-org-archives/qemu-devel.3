Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D3AD132A3
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 09:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7tbI-0004gV-DO; Mon, 04 Nov 2024 04:42:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1t7tbC-0004ex-PM
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:42:15 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1t7tbA-0000lJ-I0
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 04:42:14 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A48g0Op009185;
 Mon, 4 Nov 2024 09:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=c/gUe
 N/1UHuvwH/MPvRLZ4qA0zjIgO5JFJ7PpI3xCiU=; b=CqpSVp6tJFzhiySQe760a
 LJaRs9dfROgHmYpwwrbC5S4f3gSLEQCT3NkXb57FoIdlW6fsYGG81AtZ/07fBlAm
 ljObIvQGrN3ZLwTVJRf0YYNB44iJGGmLchgu7vcGrH0tan46yZCDHXR9tBQ7Ivg4
 zUDy9BtaESA0ybFIEcCDiW2rvP4Nejm1/8zG00BeG4fZEMKxg0OeU9rPQ23EnJ3E
 rb6J8P8eDQR/4GtYN+6v6EzspfANE5W/S7h10oglG7YePdyVTerFA8Q8etI4ramX
 Kufg0irESMwtCrOBqgwn81elzinqxR6bQxm25yX1YFrns5gM+TdDidtAEIoDwsQ9
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpsj98e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 09:41:58 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4A49YcLD009089; Mon, 4 Nov 2024 09:41:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 42nahbt0ar-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 04 Nov 2024 09:41:58 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A49fqfi018519;
 Mon, 4 Nov 2024 09:41:57 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 42nahbt06k-4; Mon, 04 Nov 2024 09:41:57 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, sandipan.das@amd.com,
 babu.moger@amd.com, zhao1.liu@intel.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 lyan@digitalocean.com, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com, joe.jin@oracle.com,
 davydov-max@yandex-team.ru
Subject: [PATCH 3/7] target/i386/kvm: init PMU information only once
Date: Mon,  4 Nov 2024 01:40:18 -0800
Message-ID: <20241104094119.4131-4-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241104094119.4131-1-dongli.zhang@oracle.com>
References: <20241104094119.4131-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_07,2024-11-01_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411040085
X-Proofpoint-ORIG-GUID: pqWGiGQkLfgBDNyXutvfFe4Epf2g77F1
X-Proofpoint-GUID: pqWGiGQkLfgBDNyXutvfFe4Epf2g77F1
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, the 'has_architectural_pmu_version',
'num_architectural_pmu_gp_counters', and
'num_architectural_pmu_fixed_counters' are shared globally across all vCPUs
and are initialized during the setup of each vCPU.

To optimize, initialize PMU information only once for the first vCPU.

Additionally, the code extracted from kvm_x86_build_cpuid() is unrelated to
the process of building the CPUID.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 target/i386/kvm/kvm.c | 71 +++++++++++++++++++++++++++----------------
 1 file changed, 44 insertions(+), 27 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index ed73b1e7e0..5c0276f889 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1961,33 +1961,6 @@ static uint32_t kvm_x86_build_cpuid(CPUX86State *env,
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
@@ -2055,6 +2028,43 @@ full:
     abort();
 }
 
+static void kvm_init_pmu_info(CPUX86State *env)
+{
+    uint32_t eax, edx;
+    uint32_t unused;
+    uint32_t limit;
+
+    cpu_x86_cpuid(env, 0, 0, &limit, &unused, &unused, &unused);
+
+    if (limit < 0x0a) {
+        return;
+    }
+
+    cpu_x86_cpuid(env, 0x0a, 0, &eax, &unused, &unused, &edx);
+
+    has_architectural_pmu_version = eax & 0xff;
+    if (has_architectural_pmu_version > 0) {
+        num_architectural_pmu_gp_counters = (eax & 0xff00) >> 8;
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
+            num_architectural_pmu_fixed_counters = edx & 0x1f;
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
@@ -2237,6 +2247,13 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
+    /*
+     * Initialize PMU information only once for the first vCPU.
+     */
+    if (cs == first_cpu) {
+        kvm_init_pmu_info(env);
+    }
+
     if (((env->cpuid_version >> 8)&0xF) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)) {
-- 
2.39.3


