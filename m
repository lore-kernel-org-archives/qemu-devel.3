Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C65C87FCA
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Aug 2025 16:03:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ul8UW-0001RW-RQ; Sun, 10 Aug 2025 12:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UG-0001KW-SS
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ul8UD-0008K7-Eu
 for qemu-devel@nongnu.org; Sun, 10 Aug 2025 12:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754841688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmlDAyNEs1gvhtmX+7NrN+bSP9kqKus7+Y2NGGcQDsc=;
 b=KISep+7s/YmhJA7aeEeLqllyAXUNumRonu8LP5w+mlDTcIBu1/sJDjn80CGjBtEj9iW5BZ
 uLq8Uz/YueTlzgOVahax2uYdW83djnkZzGZHFGP627pIRv2t9Amnmhdcj2vVKSdaptt0x+
 g6terKwEBGbBN+LwcykaMzCHfnmYPZM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-79-9-bgqjZrPoOcSXpMiyw6Fg-1; Sun,
 10 Aug 2025 12:01:26 -0400
X-MC-Unique: 9-bgqjZrPoOcSXpMiyw6Fg-1
X-Mimecast-MFC-AGG-ID: 9-bgqjZrPoOcSXpMiyw6Fg_1754841685
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7D119560B1; Sun, 10 Aug 2025 16:01:25 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.11])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60E46300145A; Sun, 10 Aug 2025 16:01:24 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 1/3] vfio/pci: augment set_handler
Date: Sun, 10 Aug 2025 18:01:16 +0200
Message-ID: <20250810160118.450430-2-clg@redhat.com>
In-Reply-To: <20250810160118.450430-1-clg@redhat.com>
References: <20250810160118.450430-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Steve Sistare <steven.sistare@oracle.com>

Extend vfio_pci_msi_set_handler() so it can set or clear the handler.
Add a similar accessor for INTx.  No functional change.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/1752689169-233452-2-git-send-email-steven.sistare@oracle.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h |  3 ++-
 hw/vfio/cpr.c |  2 +-
 hw/vfio/pci.c | 13 +++++++++++--
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 81465a8214a4008716806ae85c7f320f6b198bb2..2b564baf88640a4fe2e78b5ec4c4eb3ba3141357 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -209,8 +209,9 @@ void vfio_pci_add_kvm_msi_virq(VFIOPCIDevice *vdev, VFIOMSIVector *vector,
 void vfio_pci_prepare_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 void vfio_pci_commit_kvm_msi_virq_batch(VFIOPCIDevice *vdev);
 bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp);
+void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable);
 void vfio_pci_msix_set_notifiers(VFIOPCIDevice *vdev);
-void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr);
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable);
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
 void vfio_pci_write_config(PCIDevice *pdev,
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index 384b56c4c74d8224df0ceecb2b8ea4e1a1f40562..ade7ff745dc26e13712dbdafda38e1875a016505 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -70,7 +70,7 @@ static void vfio_cpr_claim_vectors(VFIOPCIDevice *vdev, int nr_vectors,
         fd = vfio_cpr_load_vector_fd(vdev, "interrupt", i);
         if (fd >= 0) {
             vfio_pci_vector_init(vdev, i);
-            vfio_pci_msi_set_handler(vdev, i);
+            vfio_pci_msi_set_handler(vdev, i, true);
         }
 
         if (vfio_cpr_load_vector_fd(vdev, "kvm_interrupt", i) >= 0) {
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 4fa692c1a32bcfa4e4939e5fcb64f2bf19905b3b..4cd6894ca81731258ad10a5f9f894289e671a3db 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -413,6 +413,14 @@ bool vfio_pci_intx_enable(VFIOPCIDevice *vdev, Error **errp)
     return vfio_intx_enable(vdev, errp);
 }
 
+void vfio_pci_intx_set_handler(VFIOPCIDevice *vdev, bool enable)
+{
+    int fd = event_notifier_get_fd(&vdev->intx.interrupt);
+    IOHandler *handler = (enable ? vfio_intx_interrupt : NULL);
+
+    qemu_set_fd_handler(fd, handler, NULL, vdev);
+}
+
 /*
  * MSI/X
  */
@@ -451,12 +459,13 @@ static void vfio_msi_interrupt(void *opaque)
     notify(&vdev->pdev, nr);
 }
 
-void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr)
+void vfio_pci_msi_set_handler(VFIOPCIDevice *vdev, int nr, bool enable)
 {
     VFIOMSIVector *vector = &vdev->msi_vectors[nr];
     int fd = event_notifier_get_fd(&vector->interrupt);
+    IOHandler *handler = (enable ? vfio_msi_interrupt : NULL);
 
-    qemu_set_fd_handler(fd, vfio_msi_interrupt, NULL, vector);
+    qemu_set_fd_handler(fd, handler, NULL, vector);
 }
 
 /*
-- 
2.50.1


