Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C02BCCFA18
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Nov 2025 06:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIhjd-0001iu-EV; Tue, 11 Nov 2025 01:20:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vIhjb-0001fE-Tc
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:20:07 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vIhjY-0001WJ-6b
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 01:20:07 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB5lKe8010856;
 Tue, 11 Nov 2025 06:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=Oy+Bz
 41mk51H4l/PwP7c7q7j84GKvjI78ixYVp9g/I8=; b=m1LHZ/Q8uf1b30qdpzAmR
 /fviToQmKnJ9HkbAMnYOULvJXR1mvxbJmP/XtAVOyJPdRTM98ybxkY6vo//0UW2o
 uNIEYS2m2vYLDm9De8BaK3GeK0tD2G3CPDwtnWt/GCnumesH/T1rTMfCw4f77KMD
 dwVAv8sMIZFGMhTi1oHu5dmiDEu+uQ09gco3eXzOFZ3BXh7brbmnUk31AkW7/TTh
 GzUHk5Qx8ubKuCNZN0uee7zZWb9wqA4pD4j5COvdYQebKvbTlPcSHYze+OiJUw0a
 Qxb4cHldlaCgweTDiDYBCFh0fUVbBapL/cF11yfons1uDfnRZ/NZGNjqH1JoV7OU
 g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4abwn7r5pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:19:58 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5AB54UlE007356; Tue, 11 Nov 2025 06:19:57 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 4a9va9mkb6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 11 Nov 2025 06:19:57 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5AB6C6qp029277;
 Tue, 11 Nov 2025 06:19:56 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 4a9va9mk84-5; Tue, 11 Nov 2025 06:19:56 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v7 4/9] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
Date: Mon, 10 Nov 2025 22:14:53 -0800
Message-ID: <20251111061532.36702-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251111061532.36702-1-dongli.zhang@oracle.com>
References: <20251111061532.36702-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_01,2025-11-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 malwarescore=0 spamscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511110047
X-Proofpoint-ORIG-GUID: ZVUJ7vK1vsDVXOGyugdtbK9KqctgoTPl
X-Proofpoint-GUID: ZVUJ7vK1vsDVXOGyugdtbK9KqctgoTPl
X-Authority-Analysis: v=2.4 cv=YIGSCBGx c=1 sm=1 tr=0 ts=6912d58e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=PfVMnciqd94fTzcZrM0A:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDAyNiBTYWx0ZWRfX38RLeyHki27E
 U0+TQyUPdCjPP6SOA246drPIBtJPxic6TAqSL7XV3iaWp0xU9i1QgE9NPZiF+vtsyYwJGkiKHWH
 Uoqeixek5JVrsM+vGO25CQkXMC5bK89fSKX2awxc4RlPHrz82EWbJMWsg5hY9v7SspFeZrvrduE
 fWENYw3JDccnGUZSz8t1p5a82Jhlaei7X/FRFy3qmyUQItP6WrKzDKUV1j4BWhCset+8E3MZxAF
 fLe/EWhEEcgI3QQ5/cK1oze9WHbHU+SqhzM3ga5rRTBmFQwYlB6rwDlrkK1Df1lBm/LZyS3cYdx
 AZ2GteUGXB7psVd1HtYgU5dRO3TxUCRLiNCChTw8PLSGH0r4DEXQHulMdO/G04usPWBhH7CijBm
 o1QvN2q8Lk7le1Z9Tq/9Z4Rx3kY/6w==
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
---
Changed since v1:
  - Still extract the code, but call them for all CPUs.
Changed since v2:
  - Use cpuid_find_entry() instead of cpu_x86_cpuid().
  - Didn't add Reviewed-by from Dapeng as the change isn't minor.
Changed since v6:
  - Add Reviewed-by from Dapeng Mi.

 target/i386/kvm/kvm.c | 62 ++++++++++++++++++++++++-------------------
 1 file changed, 35 insertions(+), 27 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index e5daa8c9fe..487647271c 100644
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
2.39.3


