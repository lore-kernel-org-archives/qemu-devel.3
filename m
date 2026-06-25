Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7658ACDB479
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wckNF-00048R-9f; Thu, 25 Jun 2026 09:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wckNE-00048J-LR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wckNC-00037u-QW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782395045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TPpgC5O15P2LULte+WpODwIChg0PcMWR6JGALM56068=;
 b=hOt0f4ySZTBGipJ3cKnOSOaeIaFXwYOH+fmh8RnyRh+1R2x75vN3URz3Ba67GIi1PPDNol
 VmGtzBdpZtMR+TfmDd4V/Wlp32iLYYn1kUiCsSpBXQAt+9tEbnoMNQ6lhtvKIaJ/e1Dtmq
 KIWS+A80kpF8CKHxrQx7gi4GX4rHAP8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-578-VOnd8YdKPC-fQ0XZnTE7wA-1; Thu,
 25 Jun 2026 09:44:01 -0400
X-MC-Unique: VOnd8YdKPC-fQ0XZnTE7wA-1
X-Mimecast-MFC-AGG-ID: VOnd8YdKPC-fQ0XZnTE7wA_1782395039
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B0B4719772EB; Thu, 25 Jun 2026 13:43:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.83])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 39ED51956041; Thu, 25 Jun 2026 13:43:54 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Giovannio Cabiddu <giovanni.cabiddu@intel.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: [PATCH] vfio/listener: Fix translated_addr for non-identity-mapped
 RAM sections
Date: Thu, 25 Jun 2026 15:43:51 +0200
Message-ID: <20260625134352.3122572-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In vfio_listener_region_del(), when dirty tracking is active and a
writable RAM section is deleted, a synthetic IOMMUTLBEntry is built to
flush dirty pages. Setting translated_addr to the IOVA (GPA) is only
correct for identity-mapped regions where GPA == ram_addr_t.

For RAM sections with GPA far above main RAM (e.g., nested VT-d interrupt
remapping table at 58 TB), translated_addr is too large, causing a crash
in physical_memory_set_dirty_lebitmap() when indexing beyond the allocated
dirty memory blocks array :

  bitmap_set_atomic(map=NULL, start=1, nr=1)
  physical_memory_set_dirty_range(start=0x380004040000, length=4096)
  physical_memory_set_dirty_lebitmap(start=0x380004040000, pages=3)
  vfio_container_query_dirty_bitmap(translated_addr=0x380004040000)
  vfio_legacy_dma_unmap_one(iova=0x380004040000, size=12288)
  vfio_listener_region_del()

Fix this by setting translated_addr to the ram_addr_t of the section, which
is consistent with other vfio dirty tracking code:

  translated_addr = memory_region_get_ram_addr(section->mr) +
                    section->offset_within_region;

Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
Fixes: 6e360c06176c ("vfio/listener: Add missing dirty tracking in region_del")
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/listener.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
index 14cca678aea788c23ea5c6ed4a3aceec5fe21484..785a6eef8d812123fcecf82e3716f5577d7c61e1 100644
--- a/hw/vfio/listener.c
+++ b/hw/vfio/listener.c
@@ -731,7 +731,7 @@ static void vfio_listener_region_del(MemoryListener *listener,
         }
 
         /*
-         * Fake an IOTLB entry for writable identity mapping which is needed
+         * Fake an IOTLB entry for writable RAM sections which is needed
          * by dirty tracking when switch out of PT domain. In fact, in
          * unmap_bitmap, only translated_addr field is used to set dirty
          * bitmap.
@@ -746,7 +746,8 @@ static void vfio_listener_region_del(MemoryListener *listener,
         if (global_dirty_tracking && memory_region_is_ram(section->mr) &&
             !section->readonly) {
             entry.iova = iova;
-            entry.translated_addr = iova;
+            entry.translated_addr = memory_region_get_ram_addr(section->mr) +
+                                    section->offset_within_region;
             iotlb = &entry;
         }
 
-- 
2.54.0


