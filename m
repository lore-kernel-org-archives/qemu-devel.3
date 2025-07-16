Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BE7C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 18:09:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uc6Z3-0005lh-Af; Wed, 16 Jul 2025 14:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6Xx-0005Dq-KZ; Wed, 16 Jul 2025 14:08:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uc6Xv-0006jj-KK; Wed, 16 Jul 2025 14:08:01 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GHfij2028571;
 Wed, 16 Jul 2025 18:07:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=L/oRZEbA
 cqddJhCnNsVzBa8dwS1u4KdUFHNJzKQGVVY=; b=P6UCPVLSYMqTmUYp56HJPyER
 9znnTWE2yAE9HbvcM4bS2ntc8arUxQRP+J5/PCaUnBoFqw+BxLsNVAfIR2TTDCPU
 BP3O8lEM3aEC5FPL/74SFG/Ktlg/UYWfqTq5HlbNySnxOLc+Klom4XRLvoSudwwF
 A07cHSIysFrR4VtVSfpFWfpmvlrN3X6o3g59yBySicxesnttRBrsxdQzj17XmbK6
 +LE/kYvvE8WfYdAnBe1KSjWHNiiU9MeBQAMaM4b36G4K3pHnXARXGHdo26d1dt0i
 wZFi4M1OF5VutAI8Av2CRAJHhwQkOyUIW01rn+UNmaSxumIp2x/CvPowdtO1zw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx81qcq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 18:07:56 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56GHbU9Q023762; Wed, 16 Jul 2025 18:07:55 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue5bnruk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 16 Jul 2025 18:07:55 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56GI7sso034678;
 Wed, 16 Jul 2025 18:07:54 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue5bnru7-1; Wed, 16 Jul 2025 18:07:54 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V2 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
Date: Wed, 16 Jul 2025 11:07:54 -0700
Message-Id: <1752689274-233526-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_03,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160163
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6877ea7c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=-1ppJrQcysB06QCxmjEA:9
X-Proofpoint-ORIG-GUID: Dsdl-g_yw22xNVgdBHhoSkWDG35JdvOP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE2MyBTYWx0ZWRfX3reW2g83vLmz
 UMwMD9/obIFKHp/AwrxnGk5gwUDclXArAimeUg5lsMH0m/Xxp/0e2tsvYDQOYmDZVoTC0wIuntP
 z63Hrn2iz8EAhjhnQlMq3HKINtxo4UsayuiAh46/LDuUr55xU2Wc7knYqQKocUnahel6rjZIvcQ
 8S04nV/+foUjOlaNKnk+jl3KIjWSeSQUilpDUVOaSMYwKL+SlJ/JHNtOypZzBwoFVSzfFjqMlN6
 /f/XUEWGT3wXjuLtAUwZfeqXwl85GLIjpi44korRDdUTDFQKCYN7HQT1GUzw8H+UIljqRgMpaHZ
 3mMWxBib2kIL1hot2JaY96drJXYmkBTX/rBBnmfl1FeydspMT2FFQYk2p+EvZjyfmGFTf/Gtic1
 mzQkMwlI2wMPtcUSOT2fF3AjW16Ijv9YB/90fngzUffrZ7+7lq/VoA/3L7KGKZF8SsnVWuvJ
X-Proofpoint-GUID: Dsdl-g_yw22xNVgdBHhoSkWDG35JdvOP
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
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

Close a race condition that causes cpr-transfer to lose VFIO
interrupts on ARM.

CPR stops VCPUs but does not disable VFIO interrupts, which may continue
to arrive throughout the transition to new QEMU.

CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
future interrupts to the producer eventfd, where they are preserved.
Old QEMU then destroys the old KVM instance.  However, interrupts may
already be pending in KVM state.  To preserve them, call ioctl
KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
they will be picked up when the new KVM+VCPU instance is created.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/intc/arm_gicv3_kvm.c            | 18 +++++++++++++++++-
 include/hw/intc/arm_gicv3_common.h |  3 +++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28..3d12c846ce 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -30,6 +30,7 @@
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -777,6 +778,17 @@ static void vm_change_state_handler(void *opaque, bool running,
     }
 }
 
+static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
+        return kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                                 KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES,
+                                 NULL, true, errp);
+    }
+    return 0;
+}
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
@@ -883,13 +895,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
                                GICD_CTLR)) {
         error_setg(&s->migration_blocker, "This operating system kernel does "
                                           "not support vGICv3 migration");
-        if (migrate_add_blocker(&s->migration_blocker, errp) < 0) {
+        if (migrate_add_blocker_modes(&s->migration_blocker, MIG_MODE_NORMAL,
+                                      MIG_MODE_CPR_TRANSFER, errp) < 0) {
             return;
         }
     }
     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                               KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
         qemu_add_vm_change_state_handler(vm_change_state_handler, s);
+        migration_add_notifier_mode(&s->cpr_notifier,
+                                    kvm_arm_gicv3_notifier,
+                                    MIG_MODE_CPR_TRANSFER);
     }
 }
 
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a3d6a0e507..75bbc403c7 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "qom/object.h"
+#include "qemu/notify.h"
 
 /*
  * Maximum number of possible interrupts, determined by the GIC architecture.
@@ -270,6 +271,8 @@ struct GICv3State {
     GICv3CPUState *cpu;
     /* List of all ITSes connected to this GIC */
     GPtrArray *itslist;
+
+    NotifierWithReturn cpr_notifier;
 };
 
 #define GICV3_BITMAP_ACCESSORS(BMP)                                     \
-- 
2.39.3


