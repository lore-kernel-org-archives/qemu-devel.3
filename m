Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF78EDE9A7
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:49:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41k-00072G-9N; Tue, 10 Sep 2024 12:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0006jh-Lv
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41T-0007Ye-BG
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U/GyNdP3SCPmm98PzjfyGhHCVDHjKCxS619UzLclrnA=;
 b=ULDbHgj2gJqOa3TgUCOJrJNimFd7gaL9GWFMmO3vfV8mlMOwh4+zKPtTe86J1csRTv4FPS
 JJGEQEVd/UTHafvaYdXAKhXqHbiVFdk9JLqBXGOfW/FdbfIUUQzOyjrketK5pnXlIie3+j
 RbBp/Y2SBjR6Mb7j4hue/bE+2ndESAg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-2988NX_cMAyI8bJ1e76rXA-1; Tue,
 10 Sep 2024 12:47:18 -0400
X-MC-Unique: 2988NX_cMAyI8bJ1e76rXA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 150EE19560B7; Tue, 10 Sep 2024 16:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8711D30001A1; Tue, 10 Sep 2024 16:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7F39B21E6889; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 04/19] qapi/common: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:46:59 +0200
Message-ID: <20240910164714.1993531-5-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added a temporary 'prefix' to delay changing the generated
code.

Revert it.  This improves OffAutoPCIBAR's generated enumeration
constant prefix from OFF_AUTOPCIBAR to OFF_AUTO_PCIBAR.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-ID: <20240904111836.3273842-5-armbru@redhat.com>
---
 qapi/common.json |  1 -
 hw/vfio/pci.c    | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/qapi/common.json b/qapi/common.json
index 25726d3113..7558ce5430 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -92,7 +92,6 @@
 # Since: 2.12
 ##
 { 'enum': 'OffAutoPCIBAR',
-  'prefix': 'OFF_AUTOPCIBAR',   # TODO drop
   'data': [ 'off', 'auto', 'bar0', 'bar1', 'bar2', 'bar3', 'bar4', 'bar5' ] }
 
 ##
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 2407720c35..0a99e55247 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -1452,7 +1452,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
     int target_bar = -1;
     size_t msix_sz;
 
-    if (!vdev->msix || vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
+    if (!vdev->msix || vdev->msix_relo == OFF_AUTO_PCIBAR_OFF) {
         return true;
     }
 
@@ -1464,7 +1464,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
     /* PCI BARs must be a power of 2 */
     msix_sz = pow2ceil(msix_sz);
 
-    if (vdev->msix_relo == OFF_AUTOPCIBAR_AUTO) {
+    if (vdev->msix_relo == OFF_AUTO_PCIBAR_AUTO) {
         /*
          * TODO: Lookup table for known devices.
          *
@@ -1479,7 +1479,7 @@ static bool vfio_pci_relocate_msix(VFIOPCIDevice *vdev, Error **errp)
             return false;
         }
     } else {
-        target_bar = (int)(vdev->msix_relo - OFF_AUTOPCIBAR_BAR0);
+        target_bar = (int)(vdev->msix_relo - OFF_AUTO_PCIBAR_BAR0);
     }
 
     /* I/O port BARs cannot host MSI-X structures */
@@ -1624,7 +1624,7 @@ static bool vfio_msix_early_setup(VFIOPCIDevice *vdev, Error **errp)
         } else if (vfio_pci_is(vdev, PCI_VENDOR_ID_BAIDU,
                                PCI_DEVICE_ID_KUNLUN_VF)) {
             msix->pba_offset = 0xb400;
-        } else if (vdev->msix_relo == OFF_AUTOPCIBAR_OFF) {
+        } else if (vdev->msix_relo == OFF_AUTO_PCIBAR_OFF) {
             error_setg(errp, "hardware reports invalid configuration, "
                        "MSIX PBA outside of specified BAR");
             g_free(msix);
@@ -3403,7 +3403,7 @@ static Property vfio_pci_dev_properties[] = {
                                    nv_gpudirect_clique,
                                    qdev_prop_nv_gpudirect_clique, uint8_t),
     DEFINE_PROP_OFF_AUTO_PCIBAR("x-msix-relocation", VFIOPCIDevice, msix_relo,
-                                OFF_AUTOPCIBAR_OFF),
+                                OFF_AUTO_PCIBAR_OFF),
 #ifdef CONFIG_IOMMUFD
     DEFINE_PROP_LINK("iommufd", VFIOPCIDevice, vbasedev.iommufd,
                      TYPE_IOMMUFD_BACKEND, IOMMUFDBackend *),
-- 
2.46.0


