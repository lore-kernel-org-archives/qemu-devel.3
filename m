Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743A7CA1016
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 16:57:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvf8m-0006qp-AT; Mon, 08 Sep 2025 12:54:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8Y-0006e9-2A
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvf8N-0001ag-Q7
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 12:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757350465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yy0UHB5UY3SkW0YZ23dbCFp+M/mYAit6r4Hadl6Hdj8=;
 b=KtWwaAmPqhwUzm5YWH/lL3fJrBjRvdEObq2GXyeSXupvrJNHd1+t1sNCOh3te1ptZW1reY
 hUwsGp39zEYnPIByairwAFguw/cBHaMVt8kZpPAff9KkBKgVSvEeBwmMFCnqvDC6Iyb/rz
 +STWuMMzzHkuL/I4ZV0h2zDyhkmhCzU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-367-z690hmoZPVWCDC8iA0nOFQ-1; Mon,
 08 Sep 2025 12:54:24 -0400
X-MC-Unique: z690hmoZPVWCDC8iA0nOFQ-1
X-Mimecast-MFC-AGG-ID: z690hmoZPVWCDC8iA0nOFQ_1757350463
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D9BD1800365; Mon,  8 Sep 2025 16:54:23 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.50])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBC99300018D; Mon,  8 Sep 2025 16:54:21 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yi Liu <yi.l.liu@intel.com>
Subject: [PULL 08/31] vfio: Report an error when the 'dma_max_mappings' limit
 is reached
Date: Mon,  8 Sep 2025 18:53:31 +0200
Message-ID: <20250908165354.1731444-9-clg@redhat.com>
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

The VFIO IOMMU Type1 kernel driver enforces a default IOMMU mapping
limit of 65535, which is configurable via the 'dma_max_mappings'
module parameter. When this limit is reached, QEMU issues a warning
and fails the mapping operation, but allows the VM to continue
running, potentially causing issues later. This scenario occurs with
SEV-SNP guests, which must update all IOMMU mappings during
initialization.

To address this, update vfio_ram_discard_register_listener() to accept
an 'Error **' parameter and propagate the error to the caller. This
change will halt the VM immediately, at init time, with the same error
message.

Additionally, the same behavior will be enforced at runtime. While
this might be considered too brutal, the rarity of this case and the
planned removal of the dma_max_mappings module parameter make it a
reasonable approach.

Cc: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Alex Williamson <alex.williamson@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250814153419.1643897-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 5ebafaa07ea15070dfbe299d3f2c0f265959fb7d..c244be5e218ae60e2b9c8a29d2d4b9dad86fc77a 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -250,8 +250,9 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
     return 0;
 }
 
-static void vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
-                                               MemoryRegionSection *section)
+static bool vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
+                                               MemoryRegionSection *section,
+                                               Error **errp)
 {
     RamDiscardManager *rdm = memory_region_get_ram_discard_manager(section->mr);
     int target_page_size = qemu_target_page_size();
@@ -316,13 +317,15 @@ static void vfio_ram_discard_register_listener(VFIOContainerBase *bcontainer,
 
         if (vrdl_mappings + max_memslots - vrdl_count >
             bcontainer->dma_max_mappings) {
-            warn_report("%s: possibly running out of DMA mappings. E.g., try"
+            error_setg(errp, "%s: possibly running out of DMA mappings. E.g., try"
                         " increasing the 'block-size' of virtio-mem devies."
                         " Maximum possible DMA mappings: %d, Maximum possible"
                         " memslots: %d", __func__, bcontainer->dma_max_mappings,
                         max_memslots);
+            return false;
         }
     }
+    return true;
 }
 
 static void vfio_ram_discard_unregister_listener(VFIOContainerBase *bcontainer,
@@ -571,7 +574,9 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
      */
     if (memory_region_has_ram_discard_manager(section->mr)) {
         if (!cpr_remap) {
-            vfio_ram_discard_register_listener(bcontainer, section);
+            if (!vfio_ram_discard_register_listener(bcontainer, section, &err)) {
+                goto fail;
+            }
         } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
                                                            section)) {
             error_setg(&err,
-- 
2.51.0


