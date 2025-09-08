Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F5ECA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:58:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9P-0007wI-4x; Mon, 08 Sep 2025 12:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9L-0007q3-LE
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf99-0001sF-Ud
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FlZzZrjzCpbN3RMK+uCMvYdvJ6K/gsub/1q6bJe+ud4=;
 b=OzX0Jn5POqvAdux8qkgqBeGCloYl6T9RiZcGnbXyyBb3xp+2B18EnDrv4dlyb5vVFZA+o7
 99uyoAbo/sN51ZNUrGMpDHNYHP8UQLPu9Wqk5S4YHEYKlAQY6Nf2r4khgf3CsH01JFZ/b0
 PRSFabRjFZAslziCEvkE/WMbt4YldY8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-440-2-MimYYCNbW44J2e4LtXEg-1; Mon,
 08 Sep 2025 12:55:10 -0400
X-MC-Unique: 2-MimYYCNbW44J2e4LtXEg-1
X-Mimecast-MFC-AGG-ID: 2-MimYYCNbW44J2e4LtXEg_1757350510
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF6C5180057E; Mon,  8 Sep 2025 16:55:09 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7342B3000198; Mon,  8 Sep 2025 16:55:07 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/31] vfio/cpr.c: use QOM casts where appropriate
Date: Mon,  8 Sep 2025 18:53:50 +0200
Message-ID: <20250908165354.1731444-28-clg@redhat.com>
In-Reply-To: <20250908165354.1731444-1-clg@redhat.com>
References: <20250908165354.1731444-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Use QOM casts to convert between VFIOPCIDevice and PCIDevice instead of
accessing pdev directly.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-19-mark.caveayland@nutanix.com
[ clg: Updated vfio_cpr_set_msi_virq() ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/cpr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index a831243e0207112a9357d7d718bd915a26411e06..f911988adddfdc1c8e8f87d66d1647c81f633570 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -56,7 +56,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
 {
     int i, fd;
     bool pending = false;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
 
     vdev->nr_vectors = nr_vectors;
     vdev->msi_vectors = g_new0(VFIOMSIVector, nr_vectors);
@@ -99,7 +99,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
 static int vfio_cpr_pci_pre_load(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int size = MIN(pci_config_size(pdev), vdev->config_size);
     int i;
 
@@ -113,7 +113,7 @@ static int vfio_cpr_pci_pre_load(void *opaque)
 static int vfio_cpr_pci_post_load(void *opaque, int version_id)
 {
     VFIOPCIDevice *vdev = opaque;
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int nr_vectors;
 
     vfio_sub_page_bar_update_mappings(vdev);
@@ -214,7 +214,7 @@ static int set_irqfd_notifier_gsi(KVMState *s, EventNotifier *n,
 static int vfio_cpr_set_msi_virq(VFIOPCIDevice *vdev, Error **errp, bool enable)
 {
     const char *op = (enable ? "enable" : "disable");
-    PCIDevice *pdev = &vdev->pdev;
+    PCIDevice *pdev = PCI_DEVICE(vdev);
     int i, nr_vectors, ret = 0;
 
     if (msix_enabled(pdev)) {
-- 
2.51.0


