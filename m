Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA939C83F0C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 13:29:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYluF-0005Rx-Dx; Mon, 07 Jul 2025 09:29:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYlhK-00024D-18
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:16:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYlhH-0001Hs-Vn
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 09:15:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751894147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZsHiLyesL0Y/NnctlwgnwdP450YRPgXWU1voGY5y8VA=;
 b=UemIbN0dX8BB3vAO53cNZy8JYZS7SJvRJHSYYp6aqFRLlxonqzmnKayO0Z2md2pS7TTyLr
 8PzL5O9OU+SgfQgdsNaqKEFRlNWn+AmB/zL74MuBFiNfKLjN/NP0QqBztiO6ZCCkQHK+HT
 GP9JcCGXsIz8qbcRo26gQ745ODVP/NY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-fvxMgJxlPV-_jVza_QnzfA-1; Mon,
 07 Jul 2025 09:15:44 -0400
X-MC-Unique: fvxMgJxlPV-_jVza_QnzfA-1
X-Mimecast-MFC-AGG-ID: fvxMgJxlPV-_jVza_QnzfA_1751894142
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6260F1955F38; Mon,  7 Jul 2025 13:15:42 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.44.32.187])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF8E119560AD; Mon,  7 Jul 2025 13:15:38 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Cc: hi@alyssa.is
Subject: [PATCH v8 1/4] hw/arm: Allow setting KVM vGIC maintenance IRQ
Date: Mon,  7 Jul 2025 15:14:48 +0200
Message-ID: <20250707131530.1141759-2-eric.auger@redhat.com>
In-Reply-To: <20250707131530.1141759-1-eric.auger@redhat.com>
References: <20250707131530.1141759-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Haibo Xu <haibo.xu@linaro.org>

Allow virt arm machine to set the interrupt ID for the KVM
GIC maintenance interrupt.

This setting must be done before the KVM_DEV_ARM_VGIC_CTRL_INIT
hence the choice to perform the setting in the GICv3 realize
instead of proceeding the same way as kvm_arm_pmu_set_irq().

Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
Signed-off-by: Miguel Luis <miguel.luis@oracle.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v3 -> v4:
- only set maint_irq if vms->virt

v2 -> v3:
- tweak the commit message and explain why we do not proceed
  the same way as kvm_arm_pmu_set_irq (Peter)

v1 -> v2:
- [Miguel] replaced the has_virt_extensions by the maintenance irq
  intid property. [Eric] restored kvm_device_check_attr and
  kvm_device_access standard usage and conditionally call those
  if the prop is set.
---
 include/hw/intc/arm_gicv3_common.h |  1 +
 hw/arm/virt.c                      |  3 +++
 hw/intc/arm_gicv3_common.c         |  1 +
 hw/intc/arm_gicv3_kvm.c            | 21 +++++++++++++++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index a3d6a0e507..c18503869f 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -231,6 +231,7 @@ struct GICv3State {
     uint32_t num_cpu;
     uint32_t num_irq;
     uint32_t revision;
+    uint32_t maint_irq;
     bool lpi_enable;
     bool nmi_support;
     bool security_extn;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 3bcdf92e2f..550a272fbb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -828,6 +828,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
                                          OBJECT(mem), &error_fatal);
                 qdev_prop_set_bit(vms->gic, "has-lpi", true);
             }
+        } else if (vms->virt) {
+            qdev_prop_set_uint32(vms->gic, "maintenance-interrupt-id",
+                                 ARCH_GIC_MAINT_IRQ);
         }
     } else {
         if (!kvm_irqchip_in_kernel()) {
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 1cee68193c..e438d8c042 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -612,6 +612,7 @@ static const Property arm_gicv3_common_properties[] = {
     DEFINE_PROP_BOOL("has-lpi", GICv3State, lpi_enable, 0),
     DEFINE_PROP_BOOL("has-nmi", GICv3State, nmi_support, 0),
     DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
+    DEFINE_PROP_UINT32("maintenance-interrupt-id", GICv3State, maint_irq, 0),
     /*
      * Compatibility property: force 8 bits of physical priority, even
      * if the CPU being emulated should have fewer.
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3be3bf6c28..b30aac7aee 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -22,6 +22,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/intc/arm_gicv3_common.h"
+#include "hw/arm/virt.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "system/kvm.h"
@@ -825,6 +826,26 @@ static void kvm_arm_gicv3_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    if (s->maint_irq) {
+        int ret;
+
+        ret = kvm_device_check_attr(s->dev_fd,
+                                    KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0);
+        if (!ret) {
+            error_setg_errno(errp, errno,
+                             "VGICv3 setting maintenance IRQ is not "
+                             "supported by this host kernel");
+            return;
+        }
+
+        ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_MAINT_IRQ, 0,
+                                &s->maint_irq, true, errp);
+        if (ret) {
+            error_setg_errno(errp, errno, "Failed to set VGIC maintenance IRQ");
+            return;
+       }
+    }
+
     multiple_redist_region_allowed =
         kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ADDR,
                               KVM_VGIC_V3_ADDR_TYPE_REDIST_REGION);
-- 
2.49.0


