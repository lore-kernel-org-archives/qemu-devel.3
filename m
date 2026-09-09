Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565A8C79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:05:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4HzU-0008BO-PJ; Wed, 09 Sep 2026 09:05:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4HvR-0007NV-2f
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:01:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <afishman@redhat.com>)
 id 1x4HvO-0000rr-Ot
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 09:01:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788958873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TV163kW3Fobmqo7x0624NcFXqqdAAQaFQTHIgRkHjsU=;
 b=SBS8EINnJr/CH8L6UgJrOsSnDzonG7aTeWFELfKtoxwmYl2rgQJpzjI5gxNIeKW7FwEnKs
 0c6+4JLBZ+rL2FEKt7uM36EtTO+Hcm7+AUoUqo44pZ3sB+2ZyF2PDbd1NBEsHjCUai99/Y
 SguSNMEICKIvohTeZ5QkxhLgNGlZkE0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-Jxllj7LPPSy7sZP5hUmPIw-1; Wed,
 09 Sep 2026 09:00:05 -0400
X-MC-Unique: Jxllj7LPPSy7sZP5hUmPIw-1
X-Mimecast-MFC-AGG-ID: Jxllj7LPPSy7sZP5hUmPIw_1788958804
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3A941955F3C; Wed,  9 Sep 2026 13:00:04 +0000 (UTC)
Received: from Alexs-MacBook-Air.redhat.corp
 (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82BD83000223; Wed,  9 Sep 2026 13:00:02 +0000 (UTC)
From: Alex Fishman <afishman@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, sgarzare@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, Alex Fishman <afishman@redhat.com>
Subject: [PATCH v1 1/2] vhost: coalesce unmergeable sections across vring
 boundaries
Date: Wed,  9 Sep 2026 15:59:22 +0300
Message-ID: <20260909125923.75340-2-afishman@redhat.com>
In-Reply-To: <20260909125923.75340-1-afishman@redhat.com>
References: <20260909125923.75340-1-afishman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=afishman@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 09 Sep 2026 09:05:26 -0400
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

Virtio-mem dynamic memslots are marked unmergeable so listeners can
track their lifetimes independently. A vring part crossing the boundary
between two such slots consequently cannot be contained in a single
vhost memory region.

Coalesce adjacent unmergeable sections only when a descriptor table,
available ring, or used ring spans their boundary and the sections
preserve a coherent GPA-to-HVA translation. Keep unrelated slots
separate so activating them does not reshape the region containing the
vring.

Fixes: 533f5d667909 ("memory,vhost: Allow for marking memory device memory regions unmergeable")

Buglink: https://redhat.atlassian.net/browse/RHEL-146583

Signed-off-by: Alex Fishman <afishman@redhat.com>
---
 hw/virtio/vhost.c | 72 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 5 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 371dca17dd..76910e2628 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -796,6 +796,70 @@ out:
     g_free(old_sections);
 }
 
+static bool vhost_vring_part_crosses_boundary(uint64_t ring_gpa,
+                                              uint64_t ring_size,
+                                              uint64_t boundary)
+{
+    return ring_size && ring_gpa < boundary &&
+           range_get_last(ring_gpa, ring_size) >= boundary;
+}
+
+static bool vhost_vring_crosses_boundary(struct vhost_dev *dev,
+                                         uint64_t boundary)
+{
+    int i;
+
+    if (vhost_dev_has_iommu(dev)) {
+        return false;
+    }
+
+    for (i = 0; i < dev->nvqs; i++) {
+        struct vhost_virtqueue *vq = &dev->vqs[i];
+
+        if (vhost_vring_part_crosses_boundary(vq->desc_phys, vq->desc_size,
+                                              boundary) ||
+            vhost_vring_part_crosses_boundary(vq->avail_phys, vq->avail_size,
+                                              boundary) ||
+            vhost_vring_part_crosses_boundary(vq->used_phys, vq->used_size,
+                                              boundary)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+static bool vhost_sections_can_merge(struct vhost_dev *dev,
+                                     const MemoryRegionSection *prev_sec,
+                                     const MemoryRegionSection *section,
+                                     uint64_t section_gpa,
+                                     uintptr_t section_host)
+{
+    uint64_t prev_gpa_start = prev_sec->offset_within_address_space;
+    uintptr_t prev_host_start =
+        (uintptr_t)memory_region_get_ram_ptr(prev_sec->mr) +
+        prev_sec->offset_within_region;
+    uint64_t offset;
+
+    if (section->mr != prev_sec->mr || section_gpa < prev_gpa_start) {
+        return false;
+    }
+
+    offset = section_gpa - prev_gpa_start;
+
+    if (prev_host_start + offset != section_host) {
+        return false;
+    }
+
+    if (!prev_sec->unmergeable && !section->unmergeable) {
+        return true;
+    }
+
+    /* Only override an unmergeable boundary when a ring part spans it. */
+    return vhost_vring_crosses_boundary(
+        dev, section->offset_within_address_space);
+}
+
 /* Adds the section data to the tmp_section structure.
  * It relies on the listener calling us in memory address order
  * and for each region (via the _add and _nop methods) to
@@ -833,7 +897,7 @@ static void vhost_region_add_section(struct vhost_dev *dev,
                                                mrs_size, mrs_host);
     }
 
-    if (dev->n_tmp_sections && !section->unmergeable) {
+    if (dev->n_tmp_sections) {
         /* Since we already have at least one section, lets see if
          * this extends it; since we're scanning in order, we only
          * have to look at the last one, and the FlatView that calls
@@ -862,11 +926,9 @@ static void vhost_region_add_section(struct vhost_dev *dev,
                 /* A way to cleanly fail here would be better */
                 return;
             }
-            /* Offset from the start of the previous GPA to this GPA */
-            size_t offset = mrs_gpa - prev_gpa_start;
 
-            if (prev_host_start + offset == mrs_host &&
-                section->mr == prev_sec->mr && !prev_sec->unmergeable) {
+            if (vhost_sections_can_merge(dev, prev_sec, section,
+                                         mrs_gpa, mrs_host)) {
                 uint64_t max_end = MAX(prev_host_end, mrs_host + mrs_size);
                 need_add = false;
                 prev_sec->offset_within_address_space =
-- 
2.52.0


