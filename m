Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7B66CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 17:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9T-00083w-H5; Mon, 08 Sep 2025 12:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9Q-00080U-E9
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9M-0001uJ-NB
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tk/z8tBX1EhZyT86hd2bvnQ/UP6G4WHHkayDdzWaLoE=;
 b=ES+Pul0BVoyz3X0LP8JXU01PIB+84cBDxvhBsG7ba5BDDbwpB9qJtkoSKzf39A1AmsMC0W
 MO4nUWIEjB7jEB21R759WZWk9wIZFH27VTXQ+jdHcIiIHtL0J8wLU3xCA7lpZIqD1sJ/wg
 3CTtgqvuMa1UD1dteG4yjoIs1ZQcoJ0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-utz4Pf6QP4mCzYWIQeyO9A-1; Mon,
 08 Sep 2025 12:55:18 -0400
X-MC-Unique: utz4Pf6QP4mCzYWIQeyO9A-1
X-Mimecast-MFC-AGG-ID: utz4Pf6QP4mCzYWIQeyO9A_1757350518
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D90F118002CE; Mon,  8 Sep 2025 16:55:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B8780300018D; Mon,  8 Sep 2025 16:55:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 30/31] s390x/s390-pci-vfio.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:53 +0200
Message-ID: <20250908165354.1731444-31-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Use QOM casts to cast to VFIOPCIDevice instead of using container_of().

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-22-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/s390x/s390-pci-vfio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index aaf91319b4e3cfacf3ca3a91e71d9d6d2fbda13f..938a5511713dade46740dca79a8c4c738799a1ce 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -62,7 +62,7 @@ S390PCIDMACount *s390_pci_start_dma_count(S390pciState *s,
 {
     S390PCIDMACount *cnt;
     uint32_t avail;
-    VFIOPCIDevice *vpdev = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpdev = VFIO_PCI_BASE(pbdev->pdev);
     int id;
 
     assert(vpdev);
@@ -108,7 +108,7 @@ static void s390_pci_read_base(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
     uint64_t vfio_size;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
@@ -162,7 +162,7 @@ static bool get_host_fh(S390PCIBusDevice *pbdev, struct vfio_device_info *info,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_base *cap;
-    VFIOPCIDevice *vpci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_BASE);
 
@@ -185,7 +185,7 @@ static void s390_pci_read_group(S390PCIBusDevice *pbdev,
     struct vfio_device_info_cap_zpci_group *cap;
     S390pciState *s = s390_get_phb();
     ClpRspQueryPciGrp *resgrp;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
     uint8_t start_gid = pbdev->zpci_fn.pfgid;
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_GROUP);
@@ -264,7 +264,7 @@ static void s390_pci_read_util(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_util *cap;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_UTIL);
 
@@ -291,7 +291,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 {
     struct vfio_info_cap_header *hdr;
     struct vfio_device_info_cap_zpci_pfip *cap;
-    VFIOPCIDevice *vpci =  container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vpci = VFIO_PCI_BASE(pbdev->pdev);
 
     hdr = vfio_get_device_info_cap(info, VFIO_DEVICE_INFO_CAP_ZPCI_PFIP);
 
@@ -314,7 +314,7 @@ static void s390_pci_read_pfip(S390PCIBusDevice *pbdev,
 
 static struct vfio_device_info *get_device_info(S390PCIBusDevice *pbdev)
 {
-    VFIOPCIDevice *vfio_pci = container_of(pbdev->pdev, VFIOPCIDevice, pdev);
+    VFIOPCIDevice *vfio_pci = VFIO_PCI_BASE(pbdev->pdev);
 
     return vfio_get_device_info(vfio_pci->vbasedev.fd);
 }
-- 
2.51.0


