Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC041CAC585
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:56:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf9W-0008F3-W8; Mon, 08 Sep 2025 12:55:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9U-00088K-8Q
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf9N-0001uB-4n
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:55:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VzDQeLZJ1xnmfmw5TdfMdMrhfUNwDAO/ZuNdnSYO7uQ=;
 b=b8TTBMqnLG3eVSW4w1sqxkq/wrrtUtpBjWLL91PPlNJ8iOFOz+BRGQ5eODlocell+T2OJc
 B4Tg3R1hv0fFcJMn0UXOza9/Wc4i0ZHtnXyPShjwKgcIjOLpp75lN9eldXXEiXbCIU+URN
 gcr+uHANZUPJla+4b6aIFZ77JHR4Zfs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-oR2Vfg0COL-5-jAmJ4K48Q-1; Mon,
 08 Sep 2025 12:55:21 -0400
X-MC-Unique: oR2Vfg0COL-5-jAmJ4K48Q-1
X-Mimecast-MFC-AGG-ID: oR2Vfg0COL-5-jAmJ4K48Q_1757350520
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 810DC1800291; Mon,  8 Sep 2025 16:55:20 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 612EA30001A4; Mon,  8 Sep 2025 16:55:18 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/31] vfio/pci.h: rename VFIOPCIDevice pdev field to parent_obj
Date: Mon,  8 Sep 2025 18:53:54 +0200
Message-ID: <20250908165354.1731444-32-clg@redhat.com>
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

Now that nothing accesses the pdev field directly, rename pdev to
parent_obj as per our current coding guidelines.

Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20250715093110.107317-23-mark.caveayland@nutanix.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/pci.h | 2 +-
 hw/vfio/cpr.c | 4 ++--
 hw/vfio/pci.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 2db76b6f4fb58679d65b651f0507c474e5c05857..e0aef82a8931c78a5504411a912acddda1fd6549 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -123,7 +123,7 @@ typedef struct VFIOMSIXInfo {
 OBJECT_DECLARE_SIMPLE_TYPE(VFIOPCIDevice, VFIO_PCI_BASE)
 
 struct VFIOPCIDevice {
-    PCIDevice pdev;
+    PCIDevice parent_obj;
 
     VFIODevice vbasedev;
     VFIOINTx intx;
diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
index f911988adddfdc1c8e8f87d66d1647c81f633570..2c71fc1e8ef7b0765d015b0f423cb6a30f273f0f 100644
--- a/hw/vfio/cpr.c
+++ b/hw/vfio/cpr.c
@@ -173,8 +173,8 @@ const VMStateDescription vfio_cpr_pci_vmstate = {
     .post_load = vfio_cpr_pci_post_load,
     .needed = cpr_incoming_needed,
     .fields = (VMStateField[]) {
-        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
-        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, pci_msix_present),
+        VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, pci_msix_present),
         VMSTATE_VFIO_INTX(intx, VFIOPCIDevice),
         VMSTATE_END_OF_LIST()
     }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 052591d2c970a1668db390f31ea06cd90e6a420f..d14e96b2f82d78746d361fc86ccbf14f6275a8de 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2811,8 +2811,8 @@ static const VMStateDescription vmstate_vfio_pci_config = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_PCI_DEVICE(pdev, VFIOPCIDevice),
-        VMSTATE_MSIX_TEST(pdev, VFIOPCIDevice, vfio_msix_present),
+        VMSTATE_PCI_DEVICE(parent_obj, VFIOPCIDevice),
+        VMSTATE_MSIX_TEST(parent_obj, VFIOPCIDevice, vfio_msix_present),
         VMSTATE_END_OF_LIST()
     },
     .subsections = (const VMStateDescription * const []) {
-- 
2.51.0


