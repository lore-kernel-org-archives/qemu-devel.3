Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7658C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 22:05:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1torPk-0004RK-OY; Sun, 02 Mar 2025 17:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1torPb-0004Pt-Tr
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 17:03:52 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1torPZ-0001d4-Ic
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 17:03:51 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522LMCJs003317;
 Sun, 2 Mar 2025 22:03:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=qYamF
 w2LhUb6NZycSLPuiD4OaENsBW2PqzvkADGcg2s=; b=IcBaXsOB59pCkUwkldSz2
 XZ5w/7Cf+O8O6XOoVDO7jr7/n5D5Wkm9RULN3XuVDLph+9ItGgIT3PBzuIbIllB7
 frcCBQdMeGscRiKPSszruteaQtauqg1SvfK8VyLys4VVh7eW/yPn9Ag7b34WW/u3
 vhyK4KTPRRg+dtIw61kPyuhInQ8/2fKvhgGxFfmlA5GOCPWS2MVddkLaihAylFOH
 I6bHg3v2Gmf0Oj2oe37UJToah9M9izpRJ7fBFyygFIP4TJusJRzIMWrtDU1f3igy
 X0C1NfKCKmenpFI5m+yb1xHz17nUGqYRLO7WGlROkT/fhsFCBJJuB3gVd6Gxx2Yd
 Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86hm28-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 02 Mar 2025 22:03:37 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 522JC9kr015772; Sun, 2 Mar 2025 22:03:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp803fm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 02 Mar 2025 22:03:36 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 522M3Qoj040088;
 Sun, 2 Mar 2025 22:03:35 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 453rp80353-11; Sun, 02 Mar 2025 22:03:35 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: [PATCH v2 10/10] target/i386/kvm: don't stop Intel PMU counters
Date: Sun,  2 Mar 2025 14:00:18 -0800
Message-ID: <20250302220112.17653-11-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250302220112.17653-1-dongli.zhang@oracle.com>
References: <20250302220112.17653-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-02_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503020180
X-Proofpoint-ORIG-GUID: fcG2tYD14NBusWqgi361T_u3mqxCmJm5
X-Proofpoint-GUID: fcG2tYD14NBusWqgi361T_u3mqxCmJm5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The kvm_put_msrs() sets the MSRs using KVM_SET_MSRS. The x86 KVM processes
these MSRs one by one in a loop, only saving the config and triggering the
KVM_REQ_PMU request. This approach does not immediately stop the event
before updating PMC.

In additional, PMU MSRs are set only at levels >= KVM_PUT_RESET_STATE,
excluding runtime. Therefore, updating these MSRs without stopping events
should be acceptable.

Finally, KVM creates kernel perf events with host mode excluded
(exclude_host = 1). While the events remain active, they don't increment
the counter during QEMU vCPU userspace mode.

No Fixed tag is going to be added for the commit 0d89436786b0 ("kvm:
migrate vPMU state"), because this isn't a bugfix.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 target/i386/kvm/kvm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index c5911baef0..4902694129 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -4160,13 +4160,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
         }
 
         if (IS_INTEL_CPU(env) && has_pmu_version > 0) {
-            if (has_pmu_version > 1) {
-                /* Stop the counter.  */
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR_CTRL, 0);
-                kvm_msr_entry_add(cpu, MSR_CORE_PERF_GLOBAL_CTRL, 0);
-            }
-
-            /* Set the counter values.  */
             for (i = 0; i < num_pmu_fixed_counters; i++) {
                 kvm_msr_entry_add(cpu, MSR_CORE_PERF_FIXED_CTR0 + i,
                                   env->msr_fixed_counters[i]);
@@ -4182,8 +4175,6 @@ static int kvm_put_msrs(X86CPU *cpu, int level)
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


