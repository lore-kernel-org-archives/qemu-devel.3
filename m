Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B974AFCC9C8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:58:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzq67-0001Yv-8C; Tue, 10 Mar 2026 01:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5b-0000rz-Ko
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vzq5X-0006LV-Pp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:57:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773122222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFTM6x/HkKccer2jVaVlp2BBiwHHgfzvPHNZdcz7q1M=;
 b=anwdZdyn5FX++DqudtyfH+34tWTbJI/IUDEEMLtsWF4/AMQR+UtkOWtndeAFNhnuuidp23
 QbT1kHgAj/JMYxk0XM6LSXnRhddReKdrLbJvIZyJzrOhssOHAR6LaxIIotVrm8l3r09mjw
 mWdDMZD27XlMsVLZsfDPN4XgSJxe5Jg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-zoitBFP_PfGD4agU6YLv-Q-1; Tue,
 10 Mar 2026 01:56:59 -0400
X-MC-Unique: zoitBFP_PfGD4agU6YLv-Q-1
X-Mimecast-MFC-AGG-ID: zoitBFP_PfGD4agU6YLv-Q_1773122218
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A7FA18005B2; Tue, 10 Mar 2026 05:56:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.32.69])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CAC191956095; Tue, 10 Mar 2026 05:56:56 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
	Jared Rossi <jrossi@linux.ibm.com>
Subject: [PULL 22/25] hw: Add "loadparm" property to virtio block PCI devices
 booting on s390x
Date: Tue, 10 Mar 2026 06:55:27 +0100
Message-ID: <20260310055530.8893-23-thuth@redhat.com>
In-Reply-To: <20260310055530.8893-1-thuth@redhat.com>
References: <20260310055530.8893-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jared Rossi <jrossi@linux.ibm.com>

The loadparm is required on s390x to pass the information to the boot loader
such as which kernel should be started or whether the boot menu should be shown.

Because PCI devices do not naturally allocate space for this, the property is
added on an architecture specific basis for supported device types.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
Message-ID: <20260309003601.242634-15-jrossi@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/pci/pci.h        |  1 +
 include/hw/pci/pci_device.h |  3 +++
 hw/pci/pci.c                | 38 +++++++++++++++++++++++++++++++++++++
 hw/s390x/ipl.c              | 11 +++++++++--
 hw/virtio/virtio-blk-pci.c  |  1 +
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 64141e92fec..5b179091dee 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -380,6 +380,7 @@ const char *pci_root_bus_path(PCIDevice *dev);
 bool pci_bus_bypass_iommu(PCIBus *bus);
 PCIDevice *pci_find_device(PCIBus *bus, int bus_num, uint8_t devfn);
 int pci_qdev_find_device(const char *id, PCIDevice **pdev);
+void pci_qdev_property_add_specifics(DeviceClass *dc);
 void pci_bus_get_w64_range(PCIBus *bus, Range *range);
 
 void pci_device_deassert_intx(PCIDevice *dev);
diff --git a/include/hw/pci/pci_device.h b/include/hw/pci/pci_device.h
index 88ccea50113..5cac6e16886 100644
--- a/include/hw/pci/pci_device.h
+++ b/include/hw/pci/pci_device.h
@@ -62,6 +62,9 @@ struct PCIDevice {
     bool partially_hotplugged;
     bool enabled;
 
+    /* only for s390x */
+    char *loadparm;
+
     /* PCI config space */
     uint8_t *config;
 
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 6399ebd41cb..2c3657d00de 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -36,6 +36,7 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "net/net.h"
+#include "system/arch_init.h"
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
@@ -2843,6 +2844,43 @@ int pci_qdev_find_device(const char *id, PCIDevice **pdev)
     return rc;
 }
 
+static char *pci_qdev_property_get_loadparm(Object *obj, Error **errp)
+{
+    return g_strdup(PCI_DEVICE(obj)->loadparm);
+}
+
+static void pci_qdev_property_set_loadparm(Object *obj, const char *value,
+                                       Error **errp)
+{
+    void *lp_str;
+
+    if (object_property_get_int(obj, "bootindex", NULL) < 0) {
+        error_setg(errp, "'loadparm' is only valid for boot devices");
+        return;
+    }
+
+    lp_str = g_malloc0(strlen(value) + 1);
+    if (!qdev_prop_sanitize_s390x_loadparm(lp_str, value, errp)) {
+        g_free(lp_str);
+        return;
+    }
+    PCI_DEVICE(obj)->loadparm = lp_str;
+}
+
+void pci_qdev_property_add_specifics(DeviceClass *dc)
+{
+    ObjectClass *oc = OBJECT_CLASS(dc);
+
+    /* The loadparm property is only supported on s390x */
+    if (target_s390x()) {
+        object_class_property_add_str(oc, "loadparm",
+                                      pci_qdev_property_get_loadparm,
+                                      pci_qdev_property_set_loadparm);
+        object_class_property_set_description(oc, "loadparm",
+                                              "load parameter (s390x only)");
+    }
+}
+
 MemoryRegion *pci_address_space(PCIDevice *dev)
 {
     return pci_get_bus(dev)->address_space_mem;
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 7e09a8cf80d..1babcd2b7dd 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -461,6 +461,7 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
     int devtype;
     uint8_t *lp;
     g_autofree void *scsi_lp = NULL;
+    g_autofree void *pci_lp = NULL;
 
     ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     if (ccw_dev) {
@@ -513,6 +514,14 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
 
     pbdev = s390_get_pci_device(dev_st, &devtype);
     if (pbdev) {
+        pci_lp = object_property_get_str(OBJECT(pbdev->pdev), "loadparm", NULL);
+        if (pci_lp && strlen(pci_lp) > 0) {
+            lp = pci_lp;
+        } else {
+            /* Use machine loadparm as a place holder if PCI LP is unset */
+            lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
+        }
+
         switch (devtype) {
         case PCI_DEVTYPE_VIRTIO:
             iplb->len = cpu_to_be32(S390_IPLB_MIN_PCI_LEN);
@@ -523,8 +532,6 @@ static bool s390_build_iplb(DeviceState *dev_st, IplParameterBlock *iplb)
             return false;
         }
 
-        /* Per-device loadparm not yet supported for non-ccw IPL */
-        lp = S390_CCW_MACHINE(qdev_get_machine())->loadparm;
         s390_ipl_convert_loadparm((char *)lp, iplb->loadparm);
         iplb->flags |= DIAG308_FLAGS_LP_VALID;
 
diff --git a/hw/virtio/virtio-blk-pci.c b/hw/virtio/virtio-blk-pci.c
index 64a434c81b5..3eecc23a657 100644
--- a/hw/virtio/virtio-blk-pci.c
+++ b/hw/virtio/virtio-blk-pci.c
@@ -71,6 +71,7 @@ static void virtio_blk_pci_class_init(ObjectClass *klass, const void *data)
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     device_class_set_props(dc, virtio_blk_pci_properties);
+    pci_qdev_property_add_specifics(dc);
     k->realize = virtio_blk_pci_realize;
     pcidev_k->vendor_id = PCI_VENDOR_ID_REDHAT_QUMRANET;
     pcidev_k->device_id = PCI_DEVICE_ID_VIRTIO_BLOCK;
-- 
2.53.0


