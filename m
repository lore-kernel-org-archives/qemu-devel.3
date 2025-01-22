Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFC1C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 15:19:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tacUK-0004cV-AN; Wed, 22 Jan 2025 10:17:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUH-0004c3-A7
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tacUE-0004Ye-Vo
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 10:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737559066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=++9SJZ2wWg4Pbvd90BZMzoeNDlPsajzo7tBFGHJvvZU=;
 b=HCCfCk0sVKKmMi0RQpWMQa9GaDIIPcmWXPSS8BCXGEnoTKX1iogp14EDsxLjkAcyNyo75U
 HMUat6HV4boya4qgBzUVmCDjHqumzJz9M50wOeFQMS/y1eq+mOCkYIesKpP956A0fkaVWS
 hosTiCZKwQHFVSPOKLgJfk1UTao2ZYo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-Z2lNY_ThMi6fCFKiCqt9Vg-1; Wed,
 22 Jan 2025 10:17:44 -0500
X-MC-Unique: Z2lNY_ThMi6fCFKiCqt9Vg-1
X-Mimecast-MFC-AGG-ID: Z2lNY_ThMi6fCFKiCqt9Vg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D8F211955D53
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 15:17:43 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2196D19560AA; Wed, 22 Jan 2025 15:17:40 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH 3/5] vfio: Improve error reporting when MMIO region mapping
 fails
Date: Wed, 22 Jan 2025 16:17:30 +0100
Message-ID: <20250122151732.1351821-4-clg@redhat.com>
In-Reply-To: <20250122151732.1351821-1-clg@redhat.com>
References: <20250122151732.1351821-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When the IOMMU address space width is smaller than the physical
address width, a MMIO region of a device can fail to map because the
region is outside the supported IOVA ranges of the VM. In this case,
PCI peer-to-peer transactions on BARs are not supported.

This can occur with the 39-bit IOMMU address space width, as can be
the case on consumer processors or when using a vIOMMU device with
default settings.

The current error message is unclear. Change the error report to a
warning because it is a non fatal condition for the VM, clarify the
induced limitations for the user and provide advice on how to possibly
resolve this issue: setting the CPU address space width of the IOMMU
address space width accordingly.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 3ca5dbf883ed2262e36952fcc47e717ff4154f12..561be7f57cf903e6e2bcbbb708be9e4d4ee8941c 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -569,6 +569,20 @@ static bool vfio_get_section_iova_range(VFIOContainerBase *bcontainer,
     return true;
 }
 
+static void vfio_container_p2p_error_append(VFIOContainerBase *bcontainer,
+                                            Error **errp)
+{
+    error_append_hint(errp, "PCI peer-to-peer transactions on BARs "
+                      "are not supported. ");
+    if (vfio_viommu_preset(bcontainer)) {
+        error_append_hint(errp, "Try setting the vIOMMU \"aw-bits\" "
+                          "property to match CPU address space width\n");
+    } else {
+        error_append_hint(errp, "Try setting the CPU \"phys-bits\" "
+                          "property to match IOMMU address space width\n");
+    }
+}
+
 static void vfio_listener_region_add(MemoryListener *listener,
                                      MemoryRegionSection *section)
 {
@@ -685,9 +699,13 @@ static void vfio_listener_region_add(MemoryListener *listener,
                    "0x%"HWADDR_PRIx", %p) = %d (%s)",
                    bcontainer, iova, int128_get64(llsize), vaddr, ret,
                    strerror(-ret));
+        /*
+         * MMIO region mapping failures are not fatal but in this case
+         * PCI peer-to-peer transactions are broken.
+         */
         if (memory_region_is_ram_device(section->mr)) {
-            /* Allow unexpected mappings not to be fatal for RAM devices */
-            error_report_err(err);
+            vfio_container_p2p_error_append(bcontainer, &err);
+            warn_report_err(err);
             return;
         }
         goto fail;
-- 
2.48.1


