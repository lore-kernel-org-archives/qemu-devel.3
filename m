Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E872C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgd-0005p8-3S; Wed, 28 May 2025 06:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDgO-0004rG-Iz
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDgI-0007Iy-Ni
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426795;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LUMQ2s0adqb0824GaQ5lu0r6aD3qTFWNdBDBR5nDao=;
 b=ac4xDmL2+iDgtmGiRwklVyzFapuQ2+YzfY88fEdaoFWtM4/JanmNuEWDSZHhFmwYPZmXU0
 BBc589xBBldk110keZa8B9uP8uiK41Dse4ZkhvAudspX+AYQJgH4NXoefyzcaxGF8452Qn
 r8Y8ueNQd6Bwex4VYlFnypK1WK0tNaE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-LWuLtyb_N0y3oYho6EwZVg-1; Wed,
 28 May 2025 06:06:31 -0400
X-MC-Unique: LWuLtyb_N0y3oYho6EwZVg-1
X-Mimecast-MFC-AGG-ID: LWuLtyb_N0y3oYho6EwZVg_1748426790
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E38551800258; Wed, 28 May 2025 10:06:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D6EB7180049D; Wed, 28 May 2025 10:06:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 23/27] hw/scsi/vmw_pvscsi: Convert DeviceRealize -> InstanceInit
Date: Wed, 28 May 2025 12:05:03 +0200
Message-ID: <20250528100507.313906-24-thuth@redhat.com>
In-Reply-To: <20250528100507.313906-1-thuth@redhat.com>
References: <20250528100507.313906-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Simplify replacing pvscsi_realize() by pvscsi_instance_init(),
removing the need for device_class_set_parent_realize().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-17-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index e163023d14c..7c98b1b8ea6 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1267,21 +1267,15 @@ static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
 };
 
-static void pvscsi_realize(DeviceState *qdev, Error **errp)
+static void pvscsi_instance_init(Object *obj)
 {
-    PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
-    PCIDevice *pci_dev = PCI_DEVICE(qdev);
-
-    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-
-    pvs_c->parent_dc_realize(qdev, errp);
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static void pvscsi_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
-    PVSCSIClass *pvs_k = PVSCSI_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
     k->realize = pvscsi_realizefn;
@@ -1290,8 +1284,6 @@ static void pvscsi_class_init(ObjectClass *klass, const void *data)
     k->device_id = PCI_DEVICE_ID_VMWARE_PVSCSI;
     k->class_id = PCI_CLASS_STORAGE_SCSI;
     k->subsystem_id = 0x1000;
-    device_class_set_parent_realize(dc, pvscsi_realize,
-                                    &pvs_k->parent_dc_realize);
     device_class_set_legacy_reset(dc, pvscsi_reset);
     dc->vmsd = &vmstate_pvscsi;
     device_class_set_props(dc, pvscsi_properties);
@@ -1306,6 +1298,7 @@ static const TypeInfo pvscsi_info = {
     .class_size    = sizeof(PVSCSIClass),
     .instance_size = sizeof(PVSCSIState),
     .class_init    = pvscsi_class_init,
+    .instance_init = pvscsi_instance_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { INTERFACE_PCIE_DEVICE },
-- 
2.49.0


