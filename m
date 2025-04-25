Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D40C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 21:35:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8Qgf-0000Rh-FM; Fri, 25 Apr 2025 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u8Qfj-0007pu-K3; Fri, 25 Apr 2025 17:33:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1u8Qfg-0005sA-Jc; Fri, 25 Apr 2025 17:33:23 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PL1wKm004902;
 Fri, 25 Apr 2025 21:32:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=u33Z8
 CD6mVAqNgkQiyrinHTr5bH/OZP7baIy6hB1Pl8=; b=SEdJKL/GebNIUzxhCsePD
 AsmIqsP0uFZQ/8ejMAXVSZDxY2DL2JX1sBXPMwPcfOhTG8Jkcb+7nbh2B8J0IJSX
 1g94/NpGv79jf89gWsertEiT8ho+CZUxbEX9Pc5t+qkbvpgpzQ7OAGAmOKFerZvs
 TonWpYH1V7GLzkDVcvfkpfIgW97F0UKTgC+4uVi9FQRhPcVgv6gITMxXM2LPPUrG
 CvIsy6X7T6RioPyYjEzgP6+K1aMitEfSYe1CJt5wfWQCVa9Q3VEZr6i9Lniw6P8O
 zEAAIXViNqyPfCQimsgE83tsUPuZp/ghdGQyzvAE/PjCgNwZOK1iRUT+NmspyipM
 g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468hxvg943-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:32:47 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 53PL0WVt031074; Fri, 25 Apr 2025 21:31:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 466k095va8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Apr 2025 21:31:58 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 53PLVdAj039597;
 Fri, 25 Apr 2025 21:31:57 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 466k095v2d-8; Fri, 25 Apr 2025 21:31:57 +0000
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
Subject: [PATCH v5 07/10] target/i386/kvm: query kvm.enable_pmu parameter
Date: Fri, 25 Apr 2025 14:30:04 -0700
Message-ID: <20250425213037.8137-8-dongli.zhang@oracle.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDE1NSBTYWx0ZWRfX+fmK7Dbc9FJ4
 266sRUwAXc5z8X3dG8uqewEe9mZWkF/AXomZB79ZYw6JyLwPlYlSjHfBsvRt63IAubqQXlsZ4z8
 zf3zolFY9rEqIU/bmwK+Sdl3JezRrEs6HrmeLc96+bnPCVRvokRPJfNtkHKKU/WblbfzTjFJeCL
 2BqXm8vy7YPZFkF/3d2Usgr7QVMJsvVRJg51LOJyT4a+2IzW7PPPWPhuKT0TRNDQP/HuzkMXB58
 /kiuNh0lhKdFmrYF273IOS0TToSytfwEs0Xxf46jzj3/BX+xwN0mIHUP2cRPznbN6uXpu7ACtSl
 zNBtbZ33D51ySsleggbRoeNPjjFd3G2mrVWaDFTBgl4b5S+vKN9ajj1Z9K5RNileDpEXS2DQxMR
 0zYje8Ng
X-Proofpoint-GUID: 1dgnmEaHaWOopUc8p2B73hhTQtRWMfyc
X-Proofpoint-ORIG-GUID: 1dgnmEaHaWOopUc8p2B73hhTQtRWMfyc
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

When PMU is enabled in QEMU, there is a chance that PMU virtualization is
completely disabled by the KVM module parameter kvm.enable_pmu=N.

The kvm.enable_pmu parameter is introduced since Linux v5.17.
Its permission is 0444. It does not change until a reload of the KVM
module.

Read the kvm.enable_pmu value from the module sysfs to give a chance to
provide more information about vPMU enablement.

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
Changed since v2:
  - Rework the code flow following Zhao's suggestion.
  - Return error when:
    (*kvm_enable_pmu == 'N' && X86_CPU(cpu)->enable_pmu)
Changed since v3:
  - Re-split the cases into enable_pmu and !enable_pmu, following Zhao's
    suggestion.
  - Rework the commit messages.
  - Bring back global static variable 'kvm_pmu_disabled' from v2.
Changed since v4:
  - Add Reviewed-by from Zhao.

 target/i386/kvm/kvm.c | 61 +++++++++++++++++++++++++++++++------------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index a3c9324d6c..a173b345b9 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -185,6 +185,10 @@ static int has_triple_fault_event;
 static bool has_msr_mcg_ext_ctl;
 
 static int pmu_cap;
+/*
+ * Read from /sys/module/kvm/parameters/enable_pmu.
+ */
+static bool kvm_pmu_disabled;
 
 static struct kvm_cpuid2 *cpuid_cache;
 static struct kvm_cpuid2 *hv_cpuid_cache;
@@ -2042,23 +2046,30 @@ int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
     if (first) {
         first = false;
 
-        /*
-         * Since Linux v5.18, KVM provides a VM-level capability to easily
-         * disable PMUs; however, QEMU has been providing PMU property per
-         * CPU since v1.6. In order to accommodate both, have to configure
-         * the VM-level capability here.
-         *
-         * KVM_PMU_CAP_DISABLE doesn't change the PMU
-         * behavior on Intel platform because current "pmu" property works
-         * as expected.
-         */
-        if ((pmu_cap & KVM_PMU_CAP_DISABLE) && !X86_CPU(cpu)->enable_pmu) {
-            ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
-                                    KVM_PMU_CAP_DISABLE);
-            if (ret < 0) {
-                error_setg_errno(errp, -ret,
-                                 "Failed to set KVM_PMU_CAP_DISABLE");
-                return ret;
+        if (X86_CPU(cpu)->enable_pmu) {
+            if (kvm_pmu_disabled) {
+                warn_report("Failed to enable PMU since "
+                            "KVM's enable_pmu parameter is disabled");
+            }
+        } else {
+            /*
+             * Since Linux v5.18, KVM provides a VM-level capability to easily
+             * disable PMUs; however, QEMU has been providing PMU property per
+             * CPU since v1.6. In order to accommodate both, have to configure
+             * the VM-level capability here.
+             *
+             * KVM_PMU_CAP_DISABLE doesn't change the PMU
+             * behavior on Intel platform because current "pmu" property works
+             * as expected.
+             */
+            if (pmu_cap & KVM_PMU_CAP_DISABLE) {
+                ret = kvm_vm_enable_cap(kvm_state, KVM_CAP_PMU_CAPABILITY, 0,
+                                        KVM_PMU_CAP_DISABLE);
+                if (ret < 0) {
+                    error_setg_errno(errp, -ret,
+                                     "Failed to set KVM_PMU_CAP_DISABLE");
+                    return ret;
+                }
             }
         }
     }
@@ -3253,6 +3264,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     int ret;
     struct utsname utsname;
     Error *local_err = NULL;
+    g_autofree char *kvm_enable_pmu;
 
     /*
      * Initialize SEV context, if required
@@ -3398,6 +3410,21 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     pmu_cap = kvm_check_extension(s, KVM_CAP_PMU_CAPABILITY);
 
+    /*
+     * The enable_pmu parameter is introduced since Linux v5.17,
+     * give a chance to provide more information about vPMU
+     * enablement.
+     *
+     * The kvm.enable_pmu's permission is 0444. It does not change
+     * until a reload of the KVM module.
+     */
+    if (g_file_get_contents("/sys/module/kvm/parameters/enable_pmu",
+                            &kvm_enable_pmu, NULL, NULL)) {
+        if (*kvm_enable_pmu == 'N') {
+            kvm_pmu_disabled = true;
+        }
+    }
+
     return 0;
 }
 
-- 
2.39.3


