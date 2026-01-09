Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EA1D232EE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 08:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7X4-0006qP-RG; Fri, 09 Jan 2026 03:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1ve7X1-0006gg-LG
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:07:40 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1ve7Wz-0006rG-B7
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 03:07:39 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6097faq02518049; Fri, 9 Jan 2026 08:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=LB2Vj
 /MWHUNtV6h54DkHNSWb4nqk6QJBlJZJjtacKdo=; b=Z3sGNiFoOgjW8bQi8w9/H
 ENYsMZerbSESgiLhlSC4994oJDkucjFFwLbh7cvQFoCHRlHD/DDTLLwLx6iCixjB
 wNieqwko5QNCzQr5fUMrNZ5tuBoApkb9M4YQG48/aN2IxlIslJoUmuLlXO8giKaz
 5/xspkiEQhLHK6XdyuPLfB5NFzgTJREVhs+XHAV3CI6ubZQlxLWWrbxNs078hewa
 9oUewUWopLnDcKnaa6DOl9ogEMZkWnfqcBbf0p1kja1ezS4ot3ObQs2eYzrj1sYS
 qjSgMNhsx06pXn0oq/zl6lN6rGx37fyBKAgf+Jrlj7Uk0A6wa/o3MK46uoGPhRfi
 w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjwgrg0rk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jan 2026 08:07:26 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 6095BESL026338; Fri, 9 Jan 2026 08:07:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4besjpcbnm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 09 Jan 2026 08:07:25 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 60987KrR009653;
 Fri, 9 Jan 2026 08:07:24 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4besjpcbj1-3; Fri, 09 Jan 2026 08:07:24 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com, zide.chen@intel.com
Subject: [PATCH v9 2/5] target/i386/kvm: extract unrelated code out of
 kvm_x86_build_cpuid()
Date: Thu,  8 Jan 2026 23:53:57 -0800
Message-ID: <20260109075508.113097-3-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260109075508.113097-1-dongli.zhang@oracle.com>
References: <20260109075508.113097-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_02,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090056
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA1NiBTYWx0ZWRfX1k8edPay+K0d
 Ke/uQIquExDgHrKCPuE5jm/Yh2ajeVHbce/wOyrd3nyMgrA1YBvg1UgE9IG7g15p3Yhcys22NyV
 /UyZu7z67OT9Qx1EpVJg0yHJGeZTs+mRMYpQ75fRkQoXOKh296qZLQLUfgYl8vmUSEPRu04dbkh
 Hh4pyQlFi2PR8GHDMJ26jw0Vi/3sqLiqoPpY5fZiqrkbJzKdeEWsO09uXJabljMq+zolm+P0akY
 QOgSmrTGNMN21K1jwZ0Ww8fq+TjgzD18g6XMAwhbuIcXiPLtThajGv5/EVvCpazdIoKmRVl8E5P
 rUuxv9BsJb4T65hSPeu4XzArA51KmJCMGWquvOc6Wrv1vESnJTT4sBXMieSnnduxY+UaJNzKo2I
 /cvAMPCwTMZyd9Eru7sJgYtiSFhuVrCKSvZEwu0/+ojwSMvNoJoz7ndpNmGR/wIDcZKurBC3Ivp
 E606tio1qrVWfjgUcVd6GcuWr5Cz6kzwMDF5VKAQ=
X-Proofpoint-ORIG-GUID: IXgIWjRxi4YP6ZyWqPd9n-LQHH0_wEJ7
X-Authority-Analysis: v=2.4 cv=ab5sXBot c=1 sm=1 tr=0 ts=6960b73e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117
 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=PfVMnciqd94fTzcZrM0A:9 cc=ntf awl=host:12110
X-Proofpoint-GUID: IXgIWjRxi4YP6ZyWqPd9n-LQHH0_wEJ7
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
index c98832f423..08d80ff677 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1986,33 +1986,6 @@ uint32_t kvm_x86_build_cpuid(CPUX86State *env, struct kvm_cpuid_entry2 *entries,
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
@@ -2116,6 +2089,39 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
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
@@ -2306,6 +2312,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
     cpuid_i = kvm_x86_build_cpuid(env, cpuid_data.entries, cpuid_i);
     cpuid_data.cpuid.nent = cpuid_i;
 
+    kvm_init_pmu_info(&cpuid_data.cpuid);
+
     if (x86_cpu_family(env->cpuid_version) >= 6
         && (env->features[FEAT_1_EDX] & (CPUID_MCE | CPUID_MCA)) ==
            (CPUID_MCE | CPUID_MCA)) {
-- 
2.39.3


