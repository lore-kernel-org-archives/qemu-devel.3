Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BDA2C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:35:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLKN-0007SH-Rn; Thu, 16 Jan 2025 03:34:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tYLKM-0007S4-TA
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:34:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1tYLKK-0005VI-3Q
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 03:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737016447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qM//RAvAkFTsI/+a1Sl4PLdWlz637bvbmjvEBgHeszc=;
 b=bCZ+oIQQKQho/1gM+DVRdCGtsLUFnRtRP9cJZd/lrla7h6/DfwvLsE6/YEwF549g1sgP9m
 qE7qoOvIJ2SMolHHOtY0ixpFvp94Mf3ysSl4CPt7G3xf5HFWk19Q2V4OwZfIOKusvpr1EF
 E7cwnTkavx0bfsF2CJ3TS9d52wnGzWA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-7c5rvkWzOxG43-VMp5TK2Q-1; Thu,
 16 Jan 2025 03:34:02 -0500
X-MC-Unique: 7c5rvkWzOxG43-VMp5TK2Q-1
X-Mimecast-MFC-AGG-ID: 7c5rvkWzOxG43-VMp5TK2Q
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D6041955DB8; Thu, 16 Jan 2025 08:34:00 +0000 (UTC)
Received: from laptop.redhat.com (unknown [10.39.193.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CC34B30001BE; Thu, 16 Jan 2025 08:33:54 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, miguel.luis@oracle.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com
Subject: [RFC v4 2/5] hw/arm: Allow setting KVM vGIC maintenance IRQ
Date: Thu, 16 Jan 2025 09:32:15 +0100
Message-ID: <20250116083339.674344-3-eric.auger@redhat.com>
In-Reply-To: <20250116083339.674344-1-eric.auger@redhat.com>
References: <20250116083339.674344-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 99e0a68b6c..55b0bb24ba 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -827,6 +827,9 @@ static void create_gic(VirtMachineState *vms, MemoryRegion *mem)
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
index 76b2283c92..2ed50d7d07 100644
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
index 8e17cab2a0..7248055a02 100644
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
2.47.1


