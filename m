Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D034DC77B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Jun 2025 07:50:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTyPH-0000A8-VH; Tue, 24 Jun 2025 03:49:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyPG-00009i-4y
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1uTyPE-0007TR-2L
 for qemu-devel@nongnu.org; Tue, 24 Jun 2025 03:49:25 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55O7fcHu004442;
 Tue, 24 Jun 2025 07:49:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=mwGai
 +swXUezK9ch7S7sQITcBZhPasSRDX8P3fzb340=; b=WK442E5R+ESTVKgqtuuhK
 bG8+hrsS5BHQTFRyXsGIHb5ozSX1AoSkW8j8aMnp232D97mFYWoC76FaO/am5hFV
 QXGtCKAp1PfnMBrXEy/xksRjirmm87+HkNbTM6hAv3VfR7GjyOnqD9JHfe6dcUVW
 6t/86P9x7D1IVgV7qghRlsHyin/AdWVHJlwUsxR+aDq1uBSyoaLSC6fKpYm2poqR
 rBG79rqb1fNPseMZXWSf2TTmwSnghJbETdAzJ1PD1s+nkH6CVpsbK35eB1TJagKo
 YZF5AsjfXCJdA273SMJgTCt/bzxfN4EaqUXxXlXbb4Q2OZPh9bXz251nD0ktu/ww
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds87vh6e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:16 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 55O5vdXo007396; Tue, 24 Jun 2025 07:49:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ehq3ar8x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 24 Jun 2025 07:49:16 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 55O7n5Y0006279;
 Tue, 24 Jun 2025 07:49:15 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 47ehq3ar1g-10; Tue, 24 Jun 2025 07:49:15 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v6 9/9] target/i386/kvm: don't stop Intel PMU counters
Date: Tue, 24 Jun 2025 00:43:28 -0700
Message-ID: <20250624074421.40429-10-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250624074421.40429-1-dongli.zhang@oracle.com>
References: <20250624074421.40429-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-24_02,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506240066
X-Authority-Analysis: v=2.4 cv=a8gw9VSF c=1 sm=1 tr=0 ts=685a587c cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6IFa9wvqVegA:10 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=A3X0-5CtyMG_TZ3YDawA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI0MDA2NiBTYWx0ZWRfX7C+T9Zi+C4K9
 ScTHj/hElWLut40UHmaFK4XOXgil6/qNFxY9/fy6ydjqdqiFlfDEPGWJkUziZGpOhdFGiF1aF1p
 fPCAhUwZOQkAWW0iWxIslA/hIq81VzGO6djVSbBSXO43DEQ14offYXM9TNkY/0kaTtrMfJAHR0t
 nYS0h2J9MG5u+R3XosZl4I7m/Oz8JdrerOjIqRSd+kabM/DAXGa4/nmfiOQBqH4rNstY2TKcEbz
 uueT5BPBd/uNvStXfz/8oF/DcwAWArGwen9s4s/7essE9eIVAILTWDOE6jAAFEI2lJkBSjjulEg
 sdV50NRdXl/HYeC/DO4fgOor0kKs/fHIUAIHD72IjugI36+piDxQv2jIaox21rLAw41jo/Q7bi5
 nDD4bXbfwd5ZZM2klRu9ZJLGmeA5ZHnd/SafumfrF1EQyLMVwL8MwxZJI/ZUlaPpn7RT6gqZ
X-Proofpoint-GUID: Gge7PKN9G43aRziA-EkstGe2F76cgGvi
X-Proofpoint-ORIG-GUID: Gge7PKN9G43aRziA-EkstGe2F76cgGvi
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

PMU MSRs are set by QEMU only at levels >= KVM_PUT_RESET_STATE,
excluding runtime. Therefore, updating these MSRs without stopping events
should be acceptable.

In addition, KVM creates kernel perf events with host mode excluded
(exclude_host = 1). While the events remain active, they don't increment
the counter during QEMU vCPU userspace mode.

Finally, The kvm_put_msrs() sets the MSRs using KVM_SET_MSRS. The x86 KVM
processes these MSRs one by one in a loop, only saving the config and
triggering the KVM_REQ_PMU request. This approach does not immediately stop
the event before updating PMC. This approach is true since Linux kernel
commit 68fb4757e867 ("KVM: x86/pmu: Defer reprogram_counter() to
kvm_pmu_handle_event"), that is, v6.2.

No Fixed tag is going to be added for the commit 0d89436786b0 ("kvm:
migrate vPMU state"), because this isn't a bugfix.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changed since v3:
  - Re-order reasons in commit messages.
  - Mention KVM's commit 68fb4757e867 (v6.2).
  - Keep Zhao's review as there isn't code change.

 target/i386/kvm/kvm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 4bbdf996ef..207de21404 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4186,13 +4186,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         }
 
         if ((IS_INTEL_CPU(env) || IS_ZHAOXIN_CPU(env)) && pmu_version > 0) {
-            if (pmu_version > 1) {
-                /* Stop the counter.  */
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
-            }
-
-            /* Set the counter values.  */
             for (i = 0; i < num_pmu_fixed_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
                                   env->msr_fixed_counters[i]);
@@ -4208,8 +4201,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
                                   env->msr_global_status);
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
                                   env->msr_global_ovf_ctrl);
-
-                /* Now start the PMU.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
                                   env->msr_fixed_ctr_ctrl);
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
-- 
2.43.5


