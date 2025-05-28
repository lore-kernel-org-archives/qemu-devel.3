Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD717C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 10:08:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDgZ-0005U4-5h; Wed, 28 May 2025 06:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg4-0004KM-3i
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uKDg2-0007H7-Ht
 for qemu-devel@nongnu.org; Wed, 28 May 2025 06:06:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748426785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OHCI9bUlMc1zhmH226iMPrisn8+fAxn1VK6cPkHMjcY=;
 b=FYWQSGxWUaLfJPupBYWNj20dUQHzv3LR8DLB8NYdl5d6Y/6j6jqto5XPRy91tA5Z9M4v1s
 NqLyQlfK6/W8ecg+9bmPV9nICE/tT/OgdRVyPZUwvIAwzqeTMOZsWocfeYUhXkx6CCNOrm
 NdK/rW14YiE4OZxl5s9NpZ3Y4afPgrk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-318-qcGn4wf2MW2qnEhokEun_Q-1; Wed,
 28 May 2025 06:06:23 -0400
X-MC-Unique: qcGn4wf2MW2qnEhokEun_Q-1
X-Mimecast-MFC-AGG-ID: qcGn4wf2MW2qnEhokEun_Q_1748426782
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B367318007E1; Wed, 28 May 2025 10:06:22 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.44.34.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56CAC180049D; Wed, 28 May 2025 10:06:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: [PULL 21/27] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_OLD_PCI_CONFIGURATION definition
Date: Wed, 28 May 2025 12:05:01 +0200
Message-ID: <20250528100507.313906-22-thuth@redhat.com>
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

PVSCSI_COMPAT_OLD_PCI_CONFIGURATION was only used by the
hw_compat_2_5[] array, via the 'x-old-pci-configuration=on'
property. We removed all machines using that array, lets remove
all the code around PVSCSI_COMPAT_OLD_PCI_CONFIGURATION.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <20250512083948.39294-15-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/scsi/vmw_pvscsi.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d5825b67868..34de59a7cf6 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -69,17 +69,11 @@ OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
 
 
 /* Compatibility flags for migration */
-#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT 0
-#define PVSCSI_COMPAT_OLD_PCI_CONFIGURATION \
-    (1 << PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT)
 #define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
 #define PVSCSI_COMPAT_DISABLE_PCIE \
     (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
 
-#define PVSCSI_USE_OLD_PCI_CONFIGURATION(s) \
-    ((s)->compat_flags & PVSCSI_COMPAT_OLD_PCI_CONFIGURATION)
-#define PVSCSI_MSI_OFFSET(s) \
-    (PVSCSI_USE_OLD_PCI_CONFIGURATION(s) ? 0x50 : 0x7c)
+#define PVSCSI_MSI_OFFSET    (0x7c)
 #define PVSCSI_EXP_EP_OFFSET (0x40)
 
 typedef struct PVSCSIRingInfo {
@@ -1110,7 +1104,7 @@ pvscsi_init_msi(PVSCSIState *s)
     int res;
     PCIDevice *d = PCI_DEVICE(s);
 
-    res = msi_init(d, PVSCSI_MSI_OFFSET(s), PVSCSI_MSIX_NUM_VECTORS,
+    res = msi_init(d, PVSCSI_MSI_OFFSET, PVSCSI_MSIX_NUM_VECTORS,
                    PVSCSI_USE_64BIT, PVSCSI_PER_VECTOR_MASK, NULL);
     if (res < 0) {
         trace_pvscsi_init_msi_fail(res);
@@ -1158,15 +1152,11 @@ pvscsi_realizefn(PCIDevice *pci_dev, Error **errp)
     trace_pvscsi_state("init");
 
     /* PCI subsystem ID, subsystem vendor ID, revision */
-    if (PVSCSI_USE_OLD_PCI_CONFIGURATION(s)) {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID, 0x1000);
-    } else {
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
-                     PCI_VENDOR_ID_VMWARE);
-        pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
-                     PCI_DEVICE_ID_VMWARE_PVSCSI);
-        pci_config_set_revision(pci_dev->config, 0x2);
-    }
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID,
+                 PCI_VENDOR_ID_VMWARE);
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_ID,
+                 PCI_DEVICE_ID_VMWARE_PVSCSI);
+    pci_config_set_revision(pci_dev->config, 0x2);
 
     /* PCI latency timer = 255 */
     pci_dev->config[PCI_LATENCY_TIMER] = 0xff;
@@ -1298,8 +1288,6 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-old-pci-configuration", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_OLD_PCI_CONFIGURATION_BIT, false),
     DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
                     PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
-- 
2.49.0


