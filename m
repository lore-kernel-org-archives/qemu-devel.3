Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77B53CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 08:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v23Y2-00077U-7b; Fri, 26 Sep 2025 04:11:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Xy-00075v-Te; Fri, 26 Sep 2025 04:11:18 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1v23Xs-0000DF-JY; Fri, 26 Sep 2025 04:11:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1C7C1157D4D;
 Fri, 26 Sep 2025 11:10:31 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2D1E4290C31;
 Fri, 26 Sep 2025 11:10:32 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Steve Sistare <steven.sistare@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.1 05/60] hw/intc/arm_gicv3_kvm: preserve pending
 interrupts during cpr
Date: Fri, 26 Sep 2025 11:09:33 +0300
Message-ID: <20250926081031.2214971-5-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
References: <qemu-stable-10.1.1-20250926101857@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Steve Sistare <steven.sistare@oracle.com>

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

Cc: qemu-stable@nongnu.org
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-id: 1754936384-278328-1-git-send-email-steven.sistare@oracle.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 376cdd7e9c94f1e03b2c58e068e8ebfe78b49514)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 6166283cd1..0cd14d78a7 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -31,6 +31,7 @@
 #include "gicv3_internal.h"
 #include "vgic_common.h"
 #include "migration/blocker.h"
+#include "migration/misc.h"
 #include "qom/object.h"
 #include "target/arm/cpregs.h"
 
@@ -776,6 +777,17 @@ static void vm_change_state_handler(void *opaque, bool running,
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
@@ -917,6 +929,9 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
     if (kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
                               KVM_DEV_ARM_VGIC_SAVE_PENDING_TABLES)) {
         qemu_add_vm_change_state_handler(vm_change_state_handler, s);
+        migration_add_notifier_mode(&s->cpr_notifier,
+                                    kvm_arm_gicv3_notifier,
+                                    MIG_MODE_CPR_TRANSFER);
     }
 }
 
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index c18503869f..572d971d22 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -27,6 +27,7 @@
 #include "hw/sysbus.h"
 #include "hw/intc/arm_gic_common.h"
 #include "qom/object.h"
+#include "qemu/notify.h"
 
 /*
  * Maximum number of possible interrupts, determined by the GIC architecture.
@@ -271,6 +272,8 @@ struct GICv3State {
     GICv3CPUState *cpu;
     /* List of all ITSes connected to this GIC */
     GPtrArray *itslist;
+
+    NotifierWithReturn cpr_notifier;
 };
 
 #define GICV3_BITMAP_ACCESSORS(BMP)                                     \
-- 
2.47.3


