Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136E5E9411C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 07:56:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaUZf-0006XB-4R; Tue, 30 Dec 2025 02:55:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vaUZc-0006WF-2b
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 02:55:21 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1vaUZZ-0007Rc-Fi
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 02:55:18 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5BU612pX3626008; Tue, 30 Dec 2025 07:55:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2025-04-25; bh=A4VuO
 i5V/u2/47ABsdM0K5gmHM2jEfr/+HCMsnrkztQ=; b=ER5Pdv0dh6mD8eW3umfgE
 zYWSRNyV2U+0uh4FznpFUazEtW535ij6UkwBfje4d4f1zAmsS7i+cy3m2MSoVlct
 6vzARZexmTRq3cnfxwKghZ3ZVnpg0vPzPYqCk9QhyKnRcE+ZD9vVI4mjlpZ1QV/N
 ufmoaKxqxSyt2NuOWc4s+WhmFIUP5kvbqi9ocq9BS605ZIavOJN6eCmL1P/vdh6k
 OrSMdUBNJqRXltHxRxTAHPgfzRW34OKIIighaiUYvToNweOz699fCeObddDHYsI3
 Y52TUBcw6keLeiTjNULiUMa/hYRcfNAJNcAb8Ue0OqPcnZi+Qtg/LlERdlpN54nk
 A==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4ba7b5j9m0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Dec 2025 07:55:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 5BU40BU3017259; Tue, 30 Dec 2025 07:55:03 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4ba5wbp6fu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Dec 2025 07:55:03 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5BU7smZx005421;
 Tue, 30 Dec 2025 07:55:03 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4ba5wbp6aa-8; Tue, 30 Dec 2025 07:55:03 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com, ewanhai-oc@zhaoxin.com,
 ewanhai@zhaoxin.com
Subject: [PATCH v8 7/7] target/i386/kvm: don't stop Intel PMU counters
Date: Mon, 29 Dec 2025 23:42:46 -0800
Message-ID: <20251230074354.88958-8-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251230074354.88958-1-dongli.zhang@oracle.com>
References: <20251230074354.88958-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_07,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 suspectscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512300070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDA3MCBTYWx0ZWRfX4TRJegSSiHj3
 Rt82NvAGLJ4EDlWN2T2JT1nNshDbwrdrzjAzCYAsgKDNXrqU8kLPHbRPvtmopRMADzPormwjv8Z
 27Q80huL0UcOIUExp7D2gvWG/JRrAa33RDiL9WAMiwutiVHxWa7MJj0cBb3NP+9qIbhPMnlY+lY
 MGFtL4uNmFZvf9sx4eCZe/llnxh+tJM1RY4jTNB+MXGSHj1AYPYoEmzgL29dxpBA/vqC1Hweghn
 nGbIoRIZkljPBM2BwyI3aJaZ/tVl3E8cb0ArTXCRYLZaG4eksIke1SsX3OEUcq1hdieU+vy+X9j
 IcJjCAoZ89+OzkmpXwUOW9Ro4k6z3X+ePBkKRP3CV5F/UiAdLbvVsHJo00TQoNU1xHhczAkIrk1
 dyG0qEjSoELdU6FDeZ90owT773f/DWOpNMLFgdysB7QZFkaqGFCpIo+kqTAVWUyOA2Gc7mw3ja7
 P9bdg+HVgjAm2U8OUhZEQyRmtYvARewBF/gXEE4I=
X-Proofpoint-GUID: zKkeHLrTXwZvxqrXIS27uvJJE-ocOni_
X-Authority-Analysis: v=2.4 cv=ccjfb3DM c=1 sm=1 tr=0 ts=69538559 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117
 a=zPCbziy225d3KhSqZt3L1A==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8
 a=A3X0-5CtyMG_TZ3YDawA:9 cc=ntf awl=host:12109
X-Proofpoint-ORIG-GUID: zKkeHLrTXwZvxqrXIS27uvJJE-ocOni_
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0a-00069f02.pphosted.com
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
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
---
Changed since v3:
  - Re-order reasons in commit messages.
  - Mention KVM's commit 68fb4757e867 (v6.2).
  - Keep Zhao's review as there isn't code change.
Changed since v6:
  - Add Reviewed-by from Dapeng Mi.

 target/i386/kvm/kvm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 99837048b8..742dc6ac0d 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4222,13 +4222,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
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
@@ -4244,8 +4237,6 @@ static int kvm_put_msrs(X86CPU *cpu, KvmPutState level)
                                   env->msr_global_status);
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_OVF_CTRL,
                                   env->msr_global_ovf_ctrl);
-
-                /* Now start the PMU.  */
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL,
                                   env->msr_fixed_ctr_ctrl);
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL,
-- 
2.39.3


