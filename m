Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C6BC30653
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 21:29:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLrCr-0005J9-1e; Mon, 24 Jun 2024 17:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCe-0004Vt-Ls
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sLrCd-0006k9-01
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 17:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719264377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D/SXafrkxkGy5NHSEh+oO7aSMmnWN6TGs4wA0taGcYA=;
 b=hQEwcJfOyYAol8zC0PESN1PZHsbZqnAIVmiYp8io0Zosrn9wwHlGA8QkvF/TWQ1OWBkbcG
 FFGLFcQfdRj/AsHihTitU9aXUjS1Jqj1syy56pn6Ndwe4wMcgmAuBRfyifwoPt8JqY1du2
 ZVf7FColtyEzyreBEQLqFBtgBKl0RDk=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-166-uowE10n6Nf2PLA63yW728Q-1; Mon,
 24 Jun 2024 17:26:13 -0400
X-MC-Unique: uowE10n6Nf2PLA63yW728Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B71DE19560AE; Mon, 24 Jun 2024 21:26:12 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.49])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id ABF021956051; Mon, 24 Jun 2024 21:26:10 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 28/42] vfio/common: Move dirty tracking ranges update to helper
Date: Mon, 24 Jun 2024 23:24:42 +0200
Message-ID: <20240624212456.350919-29-clg@redhat.com>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Joao Martins <joao.m.martins@oracle.com>

Separate the changes that update the ranges from the listener, to
make it reusable in preparation to expand its use to vIOMMU support.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
[ clg: - Rebased on upstream
       - Introduced vfio_dirty_tracking_update_range()
       - Fixed typ in commit log ]
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/common.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index d48cd9b9361a92d184e423ffc60aabaff40fb487..fe215918bdf66ddbe3c5db803e10ce1aa9756b90 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -839,20 +839,11 @@ static bool vfio_section_is_vfio_pci(MemoryRegionSection *section,
     return false;
 }
 
-static void vfio_dirty_tracking_update(MemoryListener *listener,
-                                       MemoryRegionSection *section)
+static void vfio_dirty_tracking_update_range(VFIODirtyRanges *range,
+                                             hwaddr iova, hwaddr end,
+                                             bool update_pci)
 {
-    VFIODirtyRangesListener *dirty = container_of(listener,
-                                                  VFIODirtyRangesListener,
-                                                  listener);
-    VFIODirtyRanges *range = &dirty->ranges;
-    hwaddr iova, end, *min, *max;
-
-    if (!vfio_listener_valid_section(section, "tracking_update") ||
-        !vfio_get_section_iova_range(dirty->bcontainer, section,
-                                     &iova, &end, NULL)) {
-        return;
-    }
+    hwaddr *min, *max;
 
     /*
      * The address space passed to the dirty tracker is reduced to three ranges:
@@ -873,8 +864,7 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
      * The alternative would be an IOVATree but that has a much bigger runtime
      * overhead and unnecessary complexity.
      */
-    if (vfio_section_is_vfio_pci(section, dirty->bcontainer) &&
-        iova >= UINT32_MAX) {
+    if (update_pci && iova >= UINT32_MAX) {
         min = &range->minpci64;
         max = &range->maxpci64;
     } else {
@@ -889,7 +879,23 @@ static void vfio_dirty_tracking_update(MemoryListener *listener,
     }
 
     trace_vfio_device_dirty_tracking_update(iova, end, *min, *max);
-    return;
+}
+
+static void vfio_dirty_tracking_update(MemoryListener *listener,
+                                       MemoryRegionSection *section)
+{
+    VFIODirtyRangesListener *dirty =
+        container_of(listener, VFIODirtyRangesListener, listener);
+    hwaddr iova, end;
+
+    if (!vfio_listener_valid_section(section, "tracking_update") ||
+        !vfio_get_section_iova_range(dirty->bcontainer, section,
+                                     &iova, &end, NULL)) {
+        return;
+    }
+
+    vfio_dirty_tracking_update_range(&dirty->ranges, iova, end,
+                      vfio_section_is_vfio_pci(section, dirty->bcontainer));
 }
 
 static const MemoryListener vfio_dirty_tracking_listener = {
-- 
2.45.2


