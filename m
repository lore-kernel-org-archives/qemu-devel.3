Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBF93C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 22:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1torQ7-0004U5-0u; Sun, 02 Mar 2025 17:04:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1torQ1-0004Sh-Sl
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 17:04:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongli.zhang@oracle.com>)
 id 1torPy-0001at-KP
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 17:04:17 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 522GSGvk028599;
 Sun, 2 Mar 2025 22:03:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=corp-2023-11-20; bh=I8NYK
 4T9yFniWGIt9bnTkOhNwFp/46Xz29dVFOJrqTY=; b=U1FE8dhF1Ie18PIxucLdw
 9VGV8ICZkFH+wvHsFQyv0dtyE5mBqSmgrLM6eN45ur8+MsIl3ouSEMO3MXKf3ly6
 zhiMElAM8exwZlaVY9DiOC+IRMeJhoLqZvUZZbL11/fSJJmxVXyCAik8C6jg/jrX
 u/AjcCijbu/wQQ3Ecw6PM/wq1PVcQxR2oK+OOhwRHP6Hq6DFK72I6Z3iRYZeaeiA
 bhQi2PA8yKQd5DaKjbzmXXjYU6MW895Rt0o/nDTcvobl03+gJ2bJ3dMkBJ/uo0/a
 uJ2qetvyhuwp6QFslcoGoZosKn9DUuviqOQlx64V47iFjbe1KvwX19fwKh+3Ctxl
 A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8whkm8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 02 Mar 2025 22:03:30 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 522GTG0Q015691; Sun, 2 Mar 2025 22:03:29 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 453rp803cd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 02 Mar 2025 22:03:29 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 522M3QoV040088;
 Sun, 2 Mar 2025 22:03:29 GMT
Received: from localhost.localdomain (ca-dev80.us.oracle.com [10.211.9.80])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id
 453rp80353-4; Sun, 02 Mar 2025 22:03:29 +0000
From: Dongli Zhang <dongli.zhang@oracle.com>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: pbonzini@redhat.com, zhao1.liu@intel.com, mtosatti@redhat.com,
 sandipan.das@amd.com, babu.moger@amd.com, likexu@tencent.com,
 like.xu.linux@gmail.com, zhenyuw@linux.intel.com, groug@kaod.org,
 khorenko@virtuozzo.com, alexander.ivanov@virtuozzo.com,
 den@virtuozzo.com, davydov-max@yandex-team.ru, xiaoyao.li@intel.com,
 dapeng1.mi@linux.intel.com, joe.jin@oracle.com
Subject: [PATCH v2 03/10] [DO NOT MERGE] kvm: Introduce
 kvm_arch_pre_create_vcpu()
Date: Sun,  2 Mar 2025 14:00:11 -0800
Message-ID: <20250302220112.17653-4-dongli.zhang@oracle.com>
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
X-Proofpoint-ORIG-GUID: HR5R4V33VI4KXAa3yr_JJx9o93vqv5U5
X-Proofpoint-GUID: HR5R4V33VI4KXAa3yr_JJx9o93vqv5U5
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

Introduce kvm_arch_pre_create_vcpu(), to perform arch-dependent
work prior to create any vcpu. This is for i386 TDX because it needs
call TDX_INIT_VM before creating any vcpu.

The specific implemnet of i386 will be added in the future patch.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Gerd Hoffmann <kraxel@redhat.com>
---
I used to send a version:
https://lore.kernel.org/all/20221119122901.2469-2-dongli.zhang@oracle.com/
Just pick the one from Xiaoyao's patchset as Dapeng may use this version
as well.
https://lore.kernel.org/all/20250124132048.3229049-8-xiaoyao.li@intel.com/

 accel/kvm/kvm-all.c        | 5 +++++
 include/system/kvm.h       | 1 +
 target/arm/kvm.c           | 5 +++++
 target/i386/kvm/kvm.c      | 5 +++++
 target/loongarch/kvm/kvm.c | 5 +++++
 target/mips/kvm.c          | 5 +++++
 target/ppc/kvm.c           | 5 +++++
 target/riscv/kvm/kvm-cpu.c | 5 +++++
 target/s390x/kvm/kvm.c     | 5 +++++
 9 files changed, 41 insertions(+)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f89568bfa3..df9840e53a 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -540,6 +540,11 @@ int kvm_init_vcpu(CPUState *cpu, Error **errp)
 
     trace_kvm_init_vcpu(cpu->cpu_index, kvm_arch_vcpu_id(cpu));
 
+    ret = kvm_arch_pre_create_vcpu(cpu, errp);
+    if (ret < 0) {
+        goto err;
+    }
+
     ret = kvm_create_vcpu(cpu);
     if (ret < 0) {
         error_setg_errno(errp, -ret,
diff --git a/include/system/kvm.h b/include/system/kvm.h
index ab17c09a55..d7dfa25493 100644
--- a/include/system/kvm.h
+++ b/include/system/kvm.h
@@ -374,6 +374,7 @@ int kvm_arch_get_default_type(MachineState *ms);
 
 int kvm_arch_init(MachineState *ms, KVMState *s);
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp);
 int kvm_arch_init_vcpu(CPUState *cpu);
 int kvm_arch_destroy_vcpu(CPUState *cpu);
 
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index da30bdbb23..93f1a7245b 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1874,6 +1874,11 @@ static int kvm_arm_sve_set_vls(ARMCPU *cpu)
 
 #define ARM_CPU_ID_MPIDR       3, 0, 0, 0, 5
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret;
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 6c749d4ee8..f41e190fb8 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -2051,6 +2051,11 @@ full:
     abort();
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     struct {
diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index a3f55155b0..91c3c67cdb 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -973,6 +973,11 @@ static int kvm_cpu_check_pmu(CPUState *cs, Error **errp)
     return 0;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     uint64_t val;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index d67b7c1a8e..ec53acb51a 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -61,6 +61,11 @@ int kvm_arch_irqchip_create(KVMState *s)
     return 0;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     CPUMIPSState *env = cpu_env(cs);
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 966c2c6572..758298d565 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -477,6 +477,11 @@ static void kvmppc_hw_debug_points_init(CPUPPCState *cenv)
     }
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
index 23ce779359..55be7542e7 100644
--- a/target/riscv/kvm/kvm-cpu.c
+++ b/target/riscv/kvm/kvm-cpu.c
@@ -1362,6 +1362,11 @@ static int kvm_vcpu_enable_sbi_dbcn(RISCVCPU *cpu, CPUState *cs)
     return kvm_set_one_reg(cs, kvm_sbi_dbcn.kvm_reg_id, &reg);
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     int ret = 0;
diff --git a/target/s390x/kvm/kvm.c b/target/s390x/kvm/kvm.c
index 4d56e653dd..1f592733f4 100644
--- a/target/s390x/kvm/kvm.c
+++ b/target/s390x/kvm/kvm.c
@@ -404,6 +404,11 @@ unsigned long kvm_arch_vcpu_id(CPUState *cpu)
     return cpu->cpu_index;
 }
 
+int kvm_arch_pre_create_vcpu(CPUState *cpu, Error **errp)
+{
+    return 0;
+}
+
 int kvm_arch_init_vcpu(CPUState *cs)
 {
     unsigned int max_cpus = MACHINE(qdev_get_machine())->smp.max_cpus;
-- 
2.43.5


