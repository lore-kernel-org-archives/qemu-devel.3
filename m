Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC93EC4828E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 18:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVbVf-0006i4-4R; Thu, 01 Feb 2024 13:09:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVbVZ-0006fA-1h
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:09:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eperezma@redhat.com>)
 id 1rVbVX-00044E-Cd
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 13:09:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706810987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=niXj9OCErQLuoXtxz7xBCDDPgxEdaMBzVC4lM7ANUoU=;
 b=BHdTs7e0h0j/+UFtu9/0oGn7zE+hvzFSYb0Sikj4Ek0ubCyCpKSEEb4t1T0BnAiKFrtiq4
 KD9FU1/uphyjDaEBgSR+PnlA6fbNLqAS6e4AauUQahmmcFkFXOA/puWxHkvnzmEifSLS3E
 QSuWdtsofOIzcqXx8ZvSPDlGzX5yzn8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-P33NzO0RMlO7QXsGGHZfGg-1; Thu, 01 Feb 2024 13:09:43 -0500
X-MC-Unique: P33NzO0RMlO7QXsGGHZfGg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B472827D89;
 Thu,  1 Feb 2024 18:09:43 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.103])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C8FD2026D66;
 Thu,  1 Feb 2024 18:09:41 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Dragos Tatulea <dtatulea@nvidia.com>, Lei Yang <leiyang@redhat.com>,
 Parav Pandit <parav@mellanox.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>, Zhu Lingshan <lingshan.zhu@intel.com>
Subject: [PATCH v2 6/7] vdpa: move iova_tree allocation to net_vhost_vdpa_init
Date: Thu,  1 Feb 2024 19:09:23 +0100
Message-ID: <20240201180924.487579-7-eperezma@redhat.com>
In-Reply-To: <20240201180924.487579-1-eperezma@redhat.com>
References: <20240201180924.487579-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eperezma@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As we are moving to keep the mapping through all the vdpa device life
instead of resetting it at VirtIO reset, we need to move all its
dependencies to the initialization too.  In particular devices with
x-svq=on need a valid iova_tree from the beginning.

Simplify the code also consolidating the two creation points: the first
data vq in case of SVQ active and CVQ start in case only CVQ uses it.

Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h | 16 ++++++++++++++-
 net/vhost-vdpa.c               | 36 +++-------------------------------
 2 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 03ed2f2be3..ad754eb803 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -37,7 +37,21 @@ typedef struct vhost_vdpa_shared {
     struct vhost_vdpa_iova_range iova_range;
     QLIST_HEAD(, vdpa_iommu) iommu_list;
 
-    /* IOVA mapping used by the Shadow Virtqueue */
+    /*
+     * IOVA mapping used by the Shadow Virtqueue
+     *
+     * It is shared among all ASID for simplicity, whether CVQ shares ASID with
+     * guest or not:
+     * - Memory listener need access to guest's memory addresses allocated in
+     *   the IOVA tree.
+     * - There should be plenty of IOVA address space for both ASID not to
+     *   worry about collisions between them.  Guest's translations are still
+     *   validated with virtio virtqueue_pop so there is no risk for the guest
+     *   to access memory that it shouldn't.
+     *
+     * To allocate a iova tree per ASID is doable but it complicates the code
+     * and it is not worth it for the moment.
+     */
     VhostIOVATree *iova_tree;
 
     /* Copy of backend features */
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index cc589dd148..57edcf34d0 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -232,6 +232,7 @@ static void vhost_vdpa_cleanup(NetClientState *nc)
         return;
     }
     qemu_close(s->vhost_vdpa.shared->device_fd);
+    g_clear_pointer(&s->vhost_vdpa.shared->iova_tree, vhost_iova_tree_delete);
     g_free(s->vhost_vdpa.shared);
 }
 
@@ -329,16 +330,8 @@ static void vdpa_net_migration_state_notifier(Notifier *notifier, void *data)
 
 static void vhost_vdpa_net_data_start_first(VhostVDPAState *s)
 {
-    struct vhost_vdpa *v = &s->vhost_vdpa;
-
     migration_add_notifier(&s->migration_state,
                            vdpa_net_migration_state_notifier);
-
-    /* iova_tree may be initialized by vhost_vdpa_net_load_setup */
-    if (v->shadow_vqs_enabled && !v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
-                                                   v->shared->iova_range.last);
-    }
 }
 
 static int vhost_vdpa_net_data_start(NetClientState *nc)
@@ -383,19 +376,12 @@ static int vhost_vdpa_net_data_load(NetClientState *nc)
 static void vhost_vdpa_net_client_stop(NetClientState *nc)
 {
     VhostVDPAState *s = DO_UPCAST(VhostVDPAState, nc, nc);
-    struct vhost_dev *dev;
 
     assert(nc->info->type == NET_CLIENT_DRIVER_VHOST_VDPA);
 
     if (s->vhost_vdpa.index == 0) {
         migration_remove_notifier(&s->migration_state);
     }
-
-    dev = s->vhost_vdpa.dev;
-    if (dev->vq_index + dev->nvqs == dev->vq_index_end) {
-        g_clear_pointer(&s->vhost_vdpa.shared->iova_tree,
-                        vhost_iova_tree_delete);
-    }
 }
 
 static NetClientInfo net_vhost_vdpa_info = {
@@ -557,24 +543,6 @@ out:
         return 0;
     }
 
-    /*
-     * If other vhost_vdpa already have an iova_tree, reuse it for simplicity,
-     * whether CVQ shares ASID with guest or not, because:
-     * - Memory listener need access to guest's memory addresses allocated in
-     *   the IOVA tree.
-     * - There should be plenty of IOVA address space for both ASID not to
-     *   worry about collisions between them.  Guest's translations are still
-     *   validated with virtio virtqueue_pop so there is no risk for the guest
-     *   to access memory that it shouldn't.
-     *
-     * To allocate a iova tree per ASID is doable but it complicates the code
-     * and it is not worth it for the moment.
-     */
-    if (!v->shared->iova_tree) {
-        v->shared->iova_tree = vhost_iova_tree_new(v->shared->iova_range.first,
-                                                   v->shared->iova_range.last);
-    }
-
     r = vhost_vdpa_cvq_map_buf(&s->vhost_vdpa, s->cvq_cmd_out_buffer,
                                vhost_vdpa_net_cvq_cmd_page_len(), false);
     if (unlikely(r < 0)) {
@@ -1674,6 +1642,8 @@ static NetClientState *net_vhost_vdpa_init(NetClientState *peer,
         s->vhost_vdpa.shared->device_fd = vdpa_device_fd;
         s->vhost_vdpa.shared->iova_range = iova_range;
         s->vhost_vdpa.shared->shadow_data = svq;
+        s->vhost_vdpa.shared->iova_tree = vhost_iova_tree_new(iova_range.first,
+                                                              iova_range.last);
     } else if (!is_datapath) {
         s->cvq_cmd_out_buffer = mmap(NULL, vhost_vdpa_net_cvq_cmd_page_len(),
                                      PROT_READ | PROT_WRITE,
-- 
2.43.0


