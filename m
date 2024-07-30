Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A4FC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 08:12:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYhwf-000558-7I; Tue, 30 Jul 2024 04:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwc-0004w3-Sz
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:10:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sYhwZ-0001Fa-DY
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 04:10:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722327050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEo38lpj5pKroMhTmXhAg9xdI4a0uSu2selrCgZQTVY=;
 b=QBf39HhqrlFP/jZlitXuvwwW8Roenvn3FNY24e5q5rw+LQ10v3QUZBYdJh06lshB3oJ+4r
 HMyunaeMhwqE1WV/A9SHVF7aW6iJmn76ZrB79zOkufrXC5E0dqonAsfRTfpmCwc7fmrpD/
 PQBzm3PEa17DFZjQxMIAIFy/JtY0Aqw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-365-uYIN_LaRPM2GTvQ-9jPnAA-1; Tue,
 30 Jul 2024 04:10:44 -0400
X-MC-Unique: uYIN_LaRPM2GTvQ-9jPnAA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66A411956095; Tue, 30 Jul 2024 08:10:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 08C131955D47; Tue, 30 Jul 2024 08:10:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D59B921F4B8E; Tue, 30 Jul 2024 10:10:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, andrew@codeconstruct.com.au, andrew@daynix.com,
 arei.gonglei@huawei.com, berrange@redhat.com, berto@igalia.com,
 borntraeger@linux.ibm.com, clg@kaod.org, david@redhat.com, den@openvz.org,
 eblake@redhat.com, eduardo@habkost.net, farman@linux.ibm.com,
 farosas@suse.de, hreitz@redhat.com, idryomov@gmail.com, iii@linux.ibm.com,
 jamin_lin@aspeedtech.com, jasowang@redhat.com, joel@jms.id.au,
 jsnow@redhat.com, kwolf@redhat.com, leetroy@gmail.com,
 marcandre.lureau@redhat.com, marcel.apfelbaum@gmail.com,
 michael.roth@amd.com, mst@redhat.com, mtosatti@redhat.com,
 nsg@linux.ibm.com, pasic@linux.ibm.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, peterx@redhat.com, philmd@linaro.org,
 pizhenwei@bytedance.com, pl@dlhnet.de, richard.henderson@linaro.org,
 stefanha@redhat.com, steven_lee@aspeedtech.com, thuth@redhat.com,
 vsementsov@yandex-team.ru, wangyanan55@huawei.com,
 yuri.benditovich@daynix.com, zhao1.liu@intel.com, qemu-block@nongnu.org,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org
Subject: [PATCH 04/18] qapi/common: Drop temporary 'prefix'
Date: Tue, 30 Jul 2024 10:10:18 +0200
Message-ID: <20240730081032.1246748-5-armbru@redhat.com>
In-Reply-To: <20240730081032.1246748-1-armbru@redhat.com>
References: <20240730081032.1246748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
constant prefix from OFF_AUTOPCIBAR_OFF to OFF_AUTO_PCIBAR_OFF.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
2.45.0


