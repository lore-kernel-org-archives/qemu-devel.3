Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A96B1CA0EC4
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 18:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulX81-00042s-Hb; Mon, 11 Aug 2025 14:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ulX7y-00041S-51; Mon, 11 Aug 2025 14:20:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ulX7p-0006sY-1Y; Mon, 11 Aug 2025 14:20:07 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BFN2gM001947;
 Mon, 11 Aug 2025 18:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:message-id:subject:to; s=corp-2025-04-25; bh=J0HRRxBO
 WautnBrJsZ/fNJ65jqF32OKMfy3uY3cE6g8=; b=IyNZ8pfhRmOK+92SOi2yAr7c
 O9b1obiEkjWtnZakLDZibUXXB9dWUf0i/+Fr+of8dg5KXiJopyUBvjHD8HQ/k7qA
 h+wC8+scGx38mCkIcuuDRdEko0swSLANuSZsdjW5PYShx9M+3+0EQ+V+KrErRPz9
 aMWW//PykC2isglJBj+aB4M+eJi96zsTd9XVdfoZrG9pG3+JOUsRIhyo69WNRsMK
 UNh+q2IsbkFKnPLaZPrN0VIeVf6oN3bNIcNuep4sLS5WS6m4v3YutahJVrPczuje
 Nh8Q/KtegltELxBWN4SSDGDh2q+KOEydyOWe81/jpizm7/mHBUibLfvU0+t9fw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf37fa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 18:19:46 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57BHsfGL006535; Mon, 11 Aug 2025 18:19:46 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvs8re2k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 Aug 2025 18:19:46 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57BIJjaR029896;
 Mon, 11 Aug 2025 18:19:45 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 48dvs8re1y-1; Mon, 11 Aug 2025 18:19:45 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V3 1/1] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
Date: Mon, 11 Aug 2025 11:19:44 -0700
Message-Id: <1754936384-278328-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_03,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 malwarescore=0
 spamscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110120
X-Proofpoint-GUID: gGkOSsw3dOF2oWGTutVPcqM90QHESDpK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDExOSBTYWx0ZWRfX7a4I7QO3mpmr
 GUpE7prQRgLE6krbTyyyFSN3FzeFOYLSIVhQoMkzX8S5NM7l1InYNIbgvn8lADylIrd6cyoJwr5
 jeiB8Eoot1KCrWLfEBcBRWepgrODOArUgkkN6zzp9vr4TwTc9kC8EKAb5XHnklA5Y42OkiGRfjz
 lqUW4SVX49kWjWBoSqUbwfCge40XSg55Y8X0KyDQoX4CpROSjO82RIJV4pbmF87xsab34A3XsId
 FdO1EhKPB2ik47hKwax9VgDurky8hJfLuo7Bz6pLPfI3hj+toEs9ItYl5nqaU9l1MWm6FcWybJb
 Ld/uM1pUlAJNwzPuUT0MVXuK7EehYsUIXcZMgybDZsE8rv8arIy7SKBEPUb/7kGZJdISuhBbcbr
 pT+STu6CJ2yl/ydoIsYUj3it+OqVhd/62vTcJQrHoJYy6Dnsg0wUfbzSiqt1Ibw1do/b9vF9
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689a3442 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=-1ppJrQcysB06QCxmjEA:9 cc=ntf
 awl=host:13600
X-Proofpoint-ORIG-GUID: gGkOSsw3dOF2oWGTutVPcqM90QHESDpK
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.299,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 hw/intc/arm_gicv3_kvm.c            | 15 +++++++++++++++
 include/hw/intc/arm_gicv3_common.h |  3 +++
 2 files changed, 18 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28..5e63e69e14 100644
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
@@ -890,6 +902,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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


