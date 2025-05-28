Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C0EC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:07:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgT-00058p-9G; Wed, 28 May 2025 06:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg9-0004P2-AD
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg7-0007I6-EH
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w56H/ZiBqfsqtT6hrO28JZqCjilGvXll/+3BUcPwYmU=;
 b=AHW5URdj0+G3fJYSc9Lv3+uKQjw+nBwg8wRxZt68w+6NEh8pLH8du9NwMy8sR3mzBY2dwI
 vy/Cvn3nSom8pZowc3zuik4OpaQdp9XOienm1lWtWlUfQMRnfWgSksAk3/57E/6wCM+av+
 CaH/PC1sWWKAnIKoJ40bDy6EzKYUgwo=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-klHbmcc2OD6FpRWcgaWWfQ-1; Wed,
 28 May 2025 06:06:27 -0400
X-MC-Unique: klHbmcc2OD6FpRWcgaWWfQ-1
X-Mimecast-MFC-AGG-ID: klHbmcc2OD6FpRWcgaWWfQ_1748426786
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AE671800446; Wed, 28 May 2025 10:06:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5F5CC180049D; Wed, 28 May 2025 10:06:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 22/27] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
Date: Wed, 28 May 2025 12:05:02 +0200
Message-ID: <20250528100507.313906-23-thuth@redhat.com>
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

PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around PVSCSI_COMPAT_DISABLE_PCIE_BIT, including the now
unused PVSCSIState::compat_flags field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-16-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 34de59a7cf6..e163023d14c 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -68,11 +68,6 @@ struct PVSCSIClass {
 OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
 
 
-/* Compatibility flags for migration */
-#define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
-#define PVSCSI_COMPAT_DISABLE_PCIE \
-    (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
-
 #define PVSCSI_MSI_OFFSET    (0x7c)
 #define PVSCSI_EXP_EP_OFFSET (0x40)
 
@@ -123,8 +118,6 @@ struct PVSCSIState {
     uint8_t msi_used;                    /* For migration compatibility      */
     PVSCSIRingInfo rings;                /* Data transfer rings manager      */
     uint32_t resetting;                  /* Reset in progress                */
-
-    uint32_t compat_flags;
 };
 
 typedef struct PVSCSIRequest {
@@ -1224,21 +1217,8 @@ pvscsi_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pvscsi_vmstate_need_pcie_device(void *opaque)
-{
-    PVSCSIState *s = PVSCSI(opaque);
-
-    return !(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE);
-}
-
-static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
-{
-    return !pvscsi_vmstate_need_pcie_device(opaque);
-}
-
 static const VMStateDescription vmstate_pvscsi_pcie_device = {
     .name = "pvscsi/pcie",
-    .needed = pvscsi_vmstate_need_pcie_device,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
         VMSTATE_END_OF_LIST()
@@ -1252,9 +1232,6 @@ static const VMStateDescription vmstate_pvscsi = {
     .pre_save = pvscsi_pre_save,
     .post_load = pvscsi_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
-                            pvscsi_vmstate_test_pci_device, 0,
-                            vmstate_pci_device, PCIDevice),
         VMSTATE_UINT8(msi_used, PVSCSIState),
         VMSTATE_UINT32(resetting, PVSCSIState),
         VMSTATE_UINT64(reg_interrupt_status, PVSCSIState),
@@ -1288,19 +1265,14 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
 
 static void pvscsi_realize(DeviceState *qdev, Error **errp)
 {
     PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
-    PVSCSIState *s = PVSCSI(qdev);
 
-    if (!(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE)) {
-        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    }
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 
     pvs_c->parent_dc_realize(qdev, errp);
 }
-- 
2.49.0


