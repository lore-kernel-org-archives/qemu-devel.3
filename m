Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCBFC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:49:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubLQ4-0004kS-FQ; Mon, 14 Jul 2025 11:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKB7-00080U-RI; Mon, 14 Jul 2025 10:29:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1ubKB5-0002fb-MS; Mon, 14 Jul 2025 10:29:13 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56E9Z5rg018811;
 Mon, 14 Jul 2025 14:27:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2025-04-25; bh=y6Nmd3tVgLtNyhYPxy1OmFOi5aAoV//jGNLOQhVL6/k=; b=
 Zp+yAdm2v3lN3bIfLF5Xw59cdui5aO7M/nqzi3Zk2A4cLOedAQVxPgRkYByokA7c
 d0fAjapBt6W1kJajjkQ/FuriKU4fXocftwjwn++xdAnbjrcwnHgKya77xfc7Qril
 KiaoUXjm8U6jCkSgl0PEd2L9e5RIo4WwyS9OpJtSqq4CF2aOad7SkOPqU7OX2lM5
 phinMY7WjtOq09dPM/MWn85PbtmCkpJ3L4iTliI41iP37LgzVjQGlCcOwSkpBUaG
 gcgtEB/UTYKoK6Jl3n61E8fZ3/ReLDgqhowD/CGk+TLI2NlHCP1y+oeagyS71Vjk
 8XDF1VPvzDk8N4sI9g9ctQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ufnqn14a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:24 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 56EDdFP1011597; Mon, 14 Jul 2025 14:27:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 47ue58kgqp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Jul 2025 14:27:23 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 56EERLK6040396;
 Mon, 14 Jul 2025 14:27:22 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with
 ESMTP id 47ue58kgnu-3; Mon, 14 Jul 2025 14:27:22 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Cedric Le Goater <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V1 2/2] hw/intc/arm_gicv3_kvm: preserve pending interrupts
 during cpr
Date: Mon, 14 Jul 2025 07:27:19 -0700
Message-Id: <1752503239-222714-3-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
References: <1752503239-222714-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507140085
X-Proofpoint-GUID: 0i1nAnriJwqYc6tACAu7tqMuV5JCDIVu
X-Proofpoint-ORIG-GUID: 0i1nAnriJwqYc6tACAu7tqMuV5JCDIVu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDA4NSBTYWx0ZWRfX5Zlkg0zbi4K8
 Irk6rBMUEBkLtIgaRlVuwz28VEyKAdDXgWbUghJYdYt9vipstKbBx4I9TJWppu6flN/ZQ1t8Uc1
 WYef2VvFC6F6vyNfxwB3z3KBAx9HJtKonnQTcQM0nzKQZXaqfEmauVbybSd3HHi103of8QGASz3
 xVPCTI1mMAEOqQ2VC7okUZylrcu00QH4ad6pTlFOXycp4dlS7q3qrAM1dU8wmsZN7qjZKhI2xLl
 LsN4SRyTSPpQGPur81CiVZJB2jT7nIU43Rd8VomCE1S669q10n31H1MKvo7z+yCmiEN9I6rv7aL
 cAcPU8Ib5beBOYDL2XtEGNCFX0URiucPn/gpqlQ5BLmA8GvSdCpbpru5Sr0zVoK6PIdY1FmZEW8
 u+fEO8t+9sMLtlvhzcIEAWL6YR+dCQYuOOfrPo1LaH+zkH0fLlSoPxFNHebb+kkdTTRMjQH+
X-Authority-Analysis: v=2.4 cv=U9ySDfru c=1 sm=1 tr=0 ts=687513cc b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=Wb1JkmetP80A:10 a=yPCof4ZbAAAA:8 a=-1ppJrQcysB06QCxmjEA:9 cc=ntf
 awl=host:12062
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

Close a race condition that causes cpr-transfer to lose VFIO
interrupts on ARM.

CPR stops VCPUs but does not disable VFIO interrupts, which may continue
to arrive throughout the transition to new QEMU.

CPR calls kvm_irqchip_remove_irqfd_notifier_gsi in old QEMU to force
future interrupts to the producer eventfd, where they are preserved.
Old QEMU then destroys the old KVM instance.  However, interrupts may
already be pended in KVM state.  To preserve them, call ioctl
KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES to flush them to guest RAM, where
they will be picked up when the new KVM+VCPU instance is created.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hw/intc/arm_gicv3_kvm.c            | 16 +++++++++++++++-
 include/hw/intc/arm_gicv3_common.h |  3 +++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 43cba6e3f1..15245af2fd 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -30,6 +30,7 @@
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -783,6 +784,15 @@ static void vm_change_state_handler(void *opaque, bool running,
     }
 }
 
+static int kvm_arm_gicv3_notifier(NotifierWithReturn *notifier,
+                                  MigrationEvent *e, Error **errp)
+{
+    if (e->type == MIG_EVENT_PRECOPY_DONE) {
+        GICv3State *s = container_of(notifier, GICv3State, cpr_notifier);
+        kvm_arm_save_pending_tables(s);
+    }
+    return 0;
+}
 
 static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
 {
@@ -889,13 +899,17 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
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


