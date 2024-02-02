Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9AAC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 21:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rW1UK-0008Tp-Sj; Fri, 02 Feb 2024 16:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1UI-0008N4-TF
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1rW1UH-0004v8-6E
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 16:54:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706910856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ri6FoSJmzypYKy1MV4ZPdfCalka49kBuEYsBMKwQ3zg=;
 b=G1sKoER768bRUpoB/QwDr8LMxQ66dlkTz1R+fouAKoONVZnUdAxyl10Sn923dl0EMSaCzV
 mGdHZ/qRsR3W96R7ZQ367+YrPH5gwpHmKZo/AhOHDnt3mm7Wk6ErBRYLndXc0738Ddejsh
 WemiEbKfF56Q2VekfxBnxnW1KepYQsk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-U9Rpi69mNs-DQ7wLGBitlw-1; Fri, 02 Feb 2024 16:54:13 -0500
X-MC-Unique: U9Rpi69mNs-DQ7wLGBitlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D09DC10665A2;
 Fri,  2 Feb 2024 21:54:12 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C182A2166B33;
 Fri,  2 Feb 2024 21:54:10 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Subject: [PATCH v1 14/15] libvhost-user: Dynamically remap rings after
 (temporarily?) removing memory regions
Date: Fri,  2 Feb 2024 22:53:31 +0100
Message-ID: <20240202215332.118728-15-david@redhat.com>
In-Reply-To: <20240202215332.118728-1-david@redhat.com>
References: <20240202215332.118728-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.276,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Currently, we try to remap all rings whenever we add a single new memory
region. That doesn't quite make sense, because we already map rings when
setting the ring address, and panic if that goes wrong. Likely, that
handling was simply copied from set_mem_table code, where we actually
have to remap all rings.

Remapping all rings might require us to walk quite a lot of memory
regions to perform the address translations. Ideally, we'd simply remove
that remapping.

However, let's be a bit careful. There might be some weird corner cases
where we might temporarily remove a single memory region (e.g., resize
it), that would have worked for now. Further, a ring might be located on
hotplugged memory, and as the VM reboots, we might unplug that memory, to
hotplug memory before resetting the ring addresses.

So let's unmap affected rings as we remove a memory region, and try
dynamically mapping the ring again when required.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 107 ++++++++++++++++------
 1 file changed, 78 insertions(+), 29 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index febeb2eb89..738e84ab63 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -283,10 +283,75 @@ vu_remove_all_mem_regs(VuDev *dev)
     dev->nregions = 0;
 }
 
+static bool
+map_ring(VuDev *dev, VuVirtq *vq)
+{
+    vq->vring.desc = qva_to_va(dev, vq->vra.desc_user_addr);
+    vq->vring.used = qva_to_va(dev, vq->vra.used_user_addr);
+    vq->vring.avail = qva_to_va(dev, vq->vra.avail_user_addr);
+
+    DPRINT("Setting virtq addresses:\n");
+    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
+    DPRINT("    vring_used  at %p\n", vq->vring.used);
+    DPRINT("    vring_avail at %p\n", vq->vring.avail);
+
+    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
+}
+
 static bool
 vu_is_vq_usable(VuDev *dev, VuVirtq *vq)
 {
-    return likely(!dev->broken) && likely(vq->vring.avail);
+    if (unlikely(dev->broken)) {
+        return false;
+    }
+
+    if (likely(vq->vring.avail)) {
+        return true;
+    }
+
+    /*
+     * In corner cases, we might temporarily remove a memory region that
+     * mapped a ring. When removing a memory region we make sure to
+     * unmap any rings that would be impacted. Let's try to remap if we
+     * already succeeded mapping this ring once.
+     */
+    if (!vq->vra.desc_user_addr || !vq->vra.used_user_addr ||
+        !vq->vra.avail_user_addr) {
+        return false;
+    }
+    if (map_ring(dev, vq)) {
+        vu_panic(dev, "remapping queue on access");
+        return false;
+    }
+    return true;
+}
+
+static void
+unmap_rings(VuDev *dev, VuDevRegion *r)
+{
+    int i;
+
+    for (i = 0; i < dev->max_queues; i++) {
+        VuVirtq *vq = &dev->vq[i];
+        const uintptr_t desc = (uintptr_t)vq->vring.desc;
+        const uintptr_t used = (uintptr_t)vq->vring.used;
+        const uintptr_t avail = (uintptr_t)vq->vring.avail;
+
+        if (desc < r->mmap_addr || desc >= r->mmap_addr + r->size) {
+            continue;
+        }
+        if (used < r->mmap_addr || used >= r->mmap_addr + r->size) {
+            continue;
+        }
+        if (avail < r->mmap_addr || avail >= r->mmap_addr + r->size) {
+            continue;
+        }
+
+        DPRINT("Unmapping rings of queue %d\n", i);
+        vq->vring.desc = NULL;
+        vq->vring.used = NULL;
+        vq->vring.avail = NULL;
+    }
 }
 
 static size_t
@@ -784,21 +849,6 @@ vu_reset_device_exec(VuDev *dev, VhostUserMsg *vmsg)
     return false;
 }
 
-static bool
-map_ring(VuDev *dev, VuVirtq *vq)
-{
-    vq->vring.desc = qva_to_va(dev, vq->vra.desc_user_addr);
-    vq->vring.used = qva_to_va(dev, vq->vra.used_user_addr);
-    vq->vring.avail = qva_to_va(dev, vq->vra.avail_user_addr);
-
-    DPRINT("Setting virtq addresses:\n");
-    DPRINT("    vring_desc  at %p\n", vq->vring.desc);
-    DPRINT("    vring_used  at %p\n", vq->vring.used);
-    DPRINT("    vring_avail at %p\n", vq->vring.avail);
-
-    return !(vq->vring.desc && vq->vring.used && vq->vring.avail);
-}
-
 static bool
 generate_faults(VuDev *dev) {
     unsigned int i;
@@ -882,7 +932,6 @@ generate_faults(VuDev *dev) {
 
 static bool
 vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
-    int i;
     VhostUserMemoryRegion m = vmsg->payload.memreg.region, *msg_region = &m;
 
     if (vmsg->fd_num != 1) {
@@ -928,19 +977,9 @@ vu_add_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         vmsg->fd_num = 0;
         DPRINT("Successfully added new region in postcopy\n");
         return true;
-    } else {
-        for (i = 0; i < dev->max_queues; i++) {
-            if (dev->vq[i].vring.desc) {
-                if (map_ring(dev, &dev->vq[i])) {
-                    vu_panic(dev, "remapping queue %d for new memory region",
-                             i);
-                }
-            }
-        }
-
-        DPRINT("Successfully added new region\n");
-        return false;
     }
+    DPRINT("Successfully added new region\n");
+    return false;
 }
 
 static inline bool reg_equal(VuDevRegion *vudev_reg,
@@ -993,6 +1032,16 @@ vu_rem_mem_reg(VuDev *dev, VhostUserMsg *vmsg) {
         return false;
     }
 
+    /*
+     * There might be valid cases where we temporarily remove memory regions
+     * to readd them again, or remove memory regions and don't use the rings
+     * anymore before we set the ring addresses and restart the device.
+     *
+     * Unmap all affected rings, remapping them on demand later. This should
+     * be a corner case.
+     */
+    unmap_rings(dev, r);
+
     munmap((void *)(uintptr_t)r->mmap_addr, r->size + r->mmap_offset);
 
     idx = r - dev->regions;
-- 
2.43.0


