Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA4FC369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8QfL-0007Wl-K3; Fri, 25 Apr 2025 17:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u8QfC-0007Gv-4t; Fri, 25 Apr 2025 17:32:50 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u8Qf9-0005oA-4O; Fri, 25 Apr 2025 17:32:49 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PL20Ar004930;
 Fri, 25 Apr 2025 21:32:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=Bzrco
 Lj3FUauGhRuhMvObRQGR8wTepMgICT5j9/wAts=; b=NFRmjVnwpFibpFuPcFshy
 Farh4MtNW6jQ3cnbifFmkAFjzwTqczoQqgyJOHk3nSew1gnAE1ZQcLaSWisj7/Oj
 sE9SWa6JM3/o3tBHQeZMQyTqbZX2Qu9BD99ipQieqKjXXnXYQzWTueSkVPJW+z+z
 uFe7bQwRYuNlD7LDq4vRHFmHr4qDXJ/tqvXaXDqK8ZRbPTIeq4IZ2Y09ZSjN9ZGK
 6hWAkTnSquTwxKF8AuO2UG3moCF31mAYBkULqZrzvRUeigBW/Q8P8YoqJ0gGuiNg
 2i0YvTpBlQF114TXHZ69Xor9s5hGhOVI9FvgsDiW0cKmn0RV6dH3ubmwCFYByv5M
 w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468hxvg90t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:32:12 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53PK1hSd031089; Fri, 25 Apr 2025 21:31:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 466k095v7h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:31:50 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53PLVdAd039597;
 Fri, 25 Apr 2025 21:31:49 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 466k095v2d-5; Fri, 25 Apr 2025 21:31:49 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, groug@kaod.org, khorenko@virtuozzo.com,
 alexander.ivanov@virtuozzo.com, den@virtuozzo.com,
 davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com,
 peter.maydell@linaro.org, gaosong@loongson.cn, chenhuacai@kernel.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, npiggin@gmail.com, danielhb413@gmail.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, richard.henderson@linaro.org,
 david@redhat.com, iii@linux.ibm.com, thuth@redhat.com,
 flavra@baylibre.com, ewanhai-oc@zhaoxin.com, ewanhai@zhaoxin.com,
 cobechen@zhaoxin.com, louisqi@zhaoxin.com, liamni@zhaoxin.com,
 frankzhu@zhaoxin.com, silviazhao@zhaoxin.com, kraxel@redhat.com,
 berrange@redhat.com
Subject: [PATCH v5 04/10] target/i386/kvm: set KVM_PMU_CAP_DISABLE if "-pmu"
 is configured
Date: Fri, 25 Apr 2025 14:30:01 -0700
Message-ID: <20250425213037.8137-5-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250425213037.8137-1-dongli.zhang@oracle.com>
References: <20250425213037.8137-1-dongli.zhang@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_07,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 bulkscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE1NSBTYWx0ZWRfX5vDDqGKO5nIi
 bphCY+xvfJRF2TZqFG3EKt1I1C88AuNqJiyMmjajwp1kACZ5+pBDpCkoIvdXzU744zNyxgvXWrA
 K3r710GKjnjEgprxPFTIgWIYsKI3or5G5cIrWdo7buyhZkeqdjoq4cbFATA3XOUd/iG/CvAPhpf
 PjbfLDQ4ItI0f/ryL5FmuDZjD8L0OO9fEVLZgPWSLQmKxIUcT7ChdUJwBhyyH+GFVcryIz6KYjY
 rIYH41JNWOpbt7KPLctkX+o21DaJpTKDai4m54yLPDDMuPaqjf6KZaFCTRkafZJC1xvv3wncGSX
 3xEfsFI7DhXV/n6Sk8YRs0L7kuy2kH6S/kDkbTBpzHSyRCn3p3kltLBIyY4Zxg2ClKVSzsy6C8t
 MN/jAARp
X-Proofpoint-GUID: 4O9KCc7eBOdUWtAAQCFtcOGAJGxDs8oO
X-Proofpoint-ORIG-GUID: 4O9KCc7eBOdUWtAAQCFtcOGAJGxDs8oO
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=dongli.zhang@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Although AMD PERFCORE and PerfMonV2 are removed when "-pmu" is configured,
there is no way to fully disable KVM AMD PMU virtualization. Neither
"-cpu host,-pmu" nor "-cpu EPYC" achieves this.

As a result, the following message still appears in the VM dmesg:

[    0.263615] Performance Events: AMD PMU driver.

However, the expected output should be:

[    0.596381] Performance Events: PMU not available due to virtualization, using software events only.
[    0.600972] NMI watchdog: Perf NMI watchdog permanently disabled

This occurs because AMD does not use any CPUID bit to indicate PMU
availability.

To address this, KVM_CAP_PMU_CAPABILITY is used to set KVM_PMU_CAP_DISABLE
when "-pmu" is configured.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changed since v1:
  - Switch back to the initial implementation with "-pmu".
https://lore.kernel.org/all/20221119122901.2469-3-dongli.zhang@oracle.com
  - Mention that "KVM_PMU_CAP_DISABLE doesn't change the PMU behavior on
    Intel platform because current "pmu" property works as expected."
Changed since v2:
  - Change has_pmu_cap to pmu_cap.
  - Use (pmu_cap & KVM_PMU_CAP_DISABLE) instead of only pmu_cap in if
    statement.
  - Add Reviewed-by from Xiaoyao and Zhao as the change is minor.

 target/i386/kvm/kvm.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 7cd418b59d..96d87821a3 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -177,6 +177,8 @@ static int has_triple_fault_event;
 
 static bool has_msr_mcg_ext_ctl;
 
+static int pmu_cap;
+
 static struct kvm_cpuid2 *cpuid_cache;
 static struct kvm_cpuid2 *hv_cpuid_cache;
 static struct kvm_msr_list *kvm_feature_msrs;
@@ -2054,6 +2056,33 @@ full:
 
 int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
 {
+    static bool first = true;
+    int ret;
+
+    if (first) {
+        first = false;
+
+        /*
+         * Since Linux v5.18, KVM provides a VM-level capability to easily
+         * disable PMUs; however, QEMU has been providing PMU property per
+         * CPU since v1.6. In order to accommodate both, have to configure
+         * the VM-level capability here.
+         *
+         * KVM_PMU_CAP_DISABLE doesn't change the PMU
+         * behavior on Intel platform because current "pmu" property works
+         * as expected.
+         */
+        if ((pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu) {
+            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
+                                    KVM_PMU_CAP_DISABLE);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Failed to set KVM_PMU_CAP_DISABLE");
+                return ret;
+            }
+        }
+    }
+
     return 0;
 }
 
@@ -3352,6 +3381,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
         }
     }
 
+    pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
+
     return 0;
 }
 
-- 
2.39.3


