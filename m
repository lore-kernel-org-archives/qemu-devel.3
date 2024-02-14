Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57679C48BC1
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 15:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raH0o-0007ma-7O; Wed, 14 Feb 2024 10:17:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0n-0007lG-1O
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1raH0l-0000MD-AF
 for qemu-devel@nongnu.org; Wed, 14 Feb 2024 10:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707923842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nnZdB938cYCDit76BNbGQDIjKNGJFkUbtEJRpThuoMg=;
 b=dXnbwiSxRdPUtfEAIehc3bF/MgZdtyBBl3fgooUaNRa5bdU2hCMMdrndxQArMu8vT8DxSb
 cKp/bxdrOnpHxhHqw8bSD35512liPxRleXNfx6EGlP6DAdxQYk82b9BdxMH7l40VFKiWee
 VzS5Vili+y2rv9BrFLTdObD8oqtOJ2c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-CXlwDM50Nne6VR-M7gsMIA-1; Wed, 14 Feb 2024 10:17:19 -0500
X-MC-Unique: CXlwDM50Nne6VR-M7gsMIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A506B83F266;
 Wed, 14 Feb 2024 15:17:18 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.194.174])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE9A1C066A9;
 Wed, 14 Feb 2024 15:17:15 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Germano Veit Michel <germano@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Raphael Norwitz <raphael@enfabrica.net>
Subject: [PATCH v2 04/14] libvhost-user: Merge
 vu_set_mem_table_exec_postcopy() into vu_set_mem_table_exec()
Date: Wed, 14 Feb 2024 16:16:51 +0100
Message-ID: <20240214151701.29906-5-david@redhat.com>
In-Reply-To: <20240214151701.29906-1-david@redhat.com>
References: <20240214151701.29906-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let's reduce some code duplication and prepare for further changes.

Reviewed-by: Raphael Norwitz <raphael@enfabrica.net>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 subprojects/libvhost-user/libvhost-user.c | 119 +++++++---------------
 1 file changed, 39 insertions(+), 80 deletions(-)

diff --git a/subprojects/libvhost-user/libvhost-user.c b/subprojects/libvhost-user/libvhost-user.c
index e4907dfc26..a7bd7de3cd 100644
--- a/subprojects/libvhost-user/libvhost-user.c
+++ b/subprojects/libvhost-user/libvhost-user.c
@@ -937,95 +937,23 @@ vu_get_shared_object(VuDev *dev, VhostUserMsg *vmsg)
 }
 
 static bool
-vu_set_mem_table_exec_postcopy(VuDev *dev, VhostUserMsg *vmsg)
+vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
 {
-    unsigned int i;
     VhostUserMemory m = vmsg->payload.memory, *memory = &m;
-    dev->nregions = memory->nregions;
-
-    DPRINT("Nregions: %u\n", memory->nregions);
-    for (i = 0; i < dev->nregions; i++) {
-        void *mmap_addr;
-        VhostUserMemoryRegion *msg_region = &memory->regions[i];
-        VuDevRegion *dev_region = &dev->regions[i];
-
-        DPRINT("Region %d\n", i);
-        DPRINT("    guest_phys_addr: 0x%016"PRIx64"\n",
-               msg_region->guest_phys_addr);
-        DPRINT("    memory_size:     0x%016"PRIx64"\n",
-               msg_region->memory_size);
-        DPRINT("    userspace_addr   0x%016"PRIx64"\n",
-               msg_region->userspace_addr);
-        DPRINT("    mmap_offset      0x%016"PRIx64"\n",
-               msg_region->mmap_offset);
-
-        dev_region->gpa = msg_region->guest_phys_addr;
-        dev_region->size = msg_region->memory_size;
-        dev_region->qva = msg_region->userspace_addr;
-        dev_region->mmap_offset = msg_region->mmap_offset;
+    int prot = PROT_READ | PROT_WRITE;
+    unsigned int i;
 
-        /* We don't use offset argument of mmap() since the
-         * mapped address has to be page aligned, and we use huge
-         * pages.
+    if (dev->postcopy_listening) {
+        /*
          * In postcopy we're using PROT_NONE here to catch anyone
          * accessing it before we userfault
          */
-        mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_NONE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[i], 0);
-
-        if (mmap_addr == MAP_FAILED) {
-            vu_panic(dev, "region mmap error: %s", strerror(errno));
-        } else {
-            dev_region->mmap_addr = (uint64_t)(uintptr_t)mmap_addr;
-            DPRINT("    mmap_addr:       0x%016"PRIx64"\n",
-                   dev_region->mmap_addr);
-        }
-
-        /* Return the address to QEMU so that it can translate the ufd
-         * fault addresses back.
-         */
-        msg_region->userspace_addr = (uintptr_t)(mmap_addr +
-                                                 dev_region->mmap_offset);
-        close(vmsg->fds[i]);
-    }
-
-    /* Send the message back to qemu with the addresses filled in */
-    vmsg->fd_num = 0;
-    if (!vu_send_reply(dev, dev->sock, vmsg)) {
-        vu_panic(dev, "failed to respond to set-mem-table for postcopy");
-        return false;
-    }
-
-    /* Wait for QEMU to confirm that it's registered the handler for the
-     * faults.
-     */
-    if (!dev->read_msg(dev, dev->sock, vmsg) ||
-        vmsg->size != sizeof(vmsg->payload.u64) ||
-        vmsg->payload.u64 != 0) {
-        vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
-        return false;
+        prot = PROT_NONE;
     }
 
-    /* OK, now we can go and register the memory and generate faults */
-    (void)generate_faults(dev);
-
-    return false;
-}
-
-static bool
-vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
-{
-    unsigned int i;
-    VhostUserMemory m = vmsg->payload.memory, *memory = &m;
-
     vu_remove_all_mem_regs(dev);
     dev->nregions = memory->nregions;
 
-    if (dev->postcopy_listening) {
-        return vu_set_mem_table_exec_postcopy(dev, vmsg);
-    }
-
     DPRINT("Nregions: %u\n", memory->nregions);
     for (i = 0; i < dev->nregions; i++) {
         void *mmap_addr;
@@ -1051,8 +979,7 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
          * mapped address has to be page aligned, and we use huge
          * pages.  */
         mmap_addr = mmap(0, dev_region->size + dev_region->mmap_offset,
-                         PROT_READ | PROT_WRITE, MAP_SHARED | MAP_NORESERVE,
-                         vmsg->fds[i], 0);
+                         prot, MAP_SHARED | MAP_NORESERVE, vmsg->fds[i], 0);
 
         if (mmap_addr == MAP_FAILED) {
             vu_panic(dev, "region mmap error: %s", strerror(errno));
@@ -1062,9 +989,41 @@ vu_set_mem_table_exec(VuDev *dev, VhostUserMsg *vmsg)
                    dev_region->mmap_addr);
         }
 
+        if (dev->postcopy_listening) {
+            /*
+             * Return the address to QEMU so that it can translate the ufd
+             * fault addresses back.
+             */
+            msg_region->userspace_addr = (uintptr_t)(mmap_addr +
+                                                     dev_region->mmap_offset);
+        }
         close(vmsg->fds[i]);
     }
 
+    if (dev->postcopy_listening) {
+        /* Send the message back to qemu with the addresses filled in */
+        vmsg->fd_num = 0;
+        if (!vu_send_reply(dev, dev->sock, vmsg)) {
+            vu_panic(dev, "failed to respond to set-mem-table for postcopy");
+            return false;
+        }
+
+        /*
+         * Wait for QEMU to confirm that it's registered the handler for the
+         * faults.
+         */
+        if (!dev->read_msg(dev, dev->sock, vmsg) ||
+            vmsg->size != sizeof(vmsg->payload.u64) ||
+            vmsg->payload.u64 != 0) {
+            vu_panic(dev, "failed to receive valid ack for postcopy set-mem-table");
+            return false;
+        }
+
+        /* OK, now we can go and register the memory and generate faults */
+        (void)generate_faults(dev);
+        return false;
+    }
+
     for (i = 0; i < dev->max_queues; i++) {
         if (dev->vq[i].vring.desc) {
             if (map_ring(dev, &dev->vq[i])) {
-- 
2.43.0


