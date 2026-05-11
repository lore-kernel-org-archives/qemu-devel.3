Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43589CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 14:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMRHM-00028p-2G; Mon, 11 May 2026 10:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG4-0000Pq-Jx
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <zhangckid@gmail.com>)
 id 1wMRG0-0007F3-2D
 for qemu-devel@nongnu.org; Mon, 11 May 2026 10:05:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2b9e9a6802aso16803165ad.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 07:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778508314; x=1779113114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QKSigj797q5Eby1xdqeeW+3X9FWlNgDKbDV4584UafM=;
 b=gvpULlOABg+UvTDTbN62pdsaipH61IRuQEj7ZPOaEG9+YUDJfX4bjWtU+yyy55MrMV
 LlbbXC6OAsoWKt9fGG/w1O8VhOAx55G8dmS6WlUrr/HZkb3KJC9baIqI37NPWBwVerYU
 Y1ecPDGnBymVQsPq0W00hIXc0yFQFpNj06lhRu0iEphbKUo4VuTGujZ5gwykfTwlKnDT
 eXkTQTOYKKbaI5r3G90HJOWs5O5wuNoZB3w42sUdeiVXJp7gwFd9EpDDXNsvU/2mXp/L
 Srr1DGbxOzFTG587hekhDw+8MQOUCqZHU13jbNIEAU/MPGbU7w2C/+PasirtuG5GlsoG
 LG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778508314; x=1779113114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QKSigj797q5Eby1xdqeeW+3X9FWlNgDKbDV4584UafM=;
 b=B4SeMIaLy63YlUgvRwPaWyiEZxFmN1Dga1FGH72YbDKea2gs1WssBBg8YexYmI5J7z
 Uy9OsmtBqYzheuy+UgrLCfdi26SBmDZu5Ta/9X6vrHb2sZOV8AWkzrx+yDf1kjEgC78p
 +r43wSPJ/WxWtD1WqGAJN94TQUdOnQNLuOV3FvgSUuv1Vl6vlXX25I7VArytbgJ6IdK9
 P13VSMJf2EH0012/TFuPql8bXnin6Ia6dfBlwZD9KI5e6owHpMbTAW/Ekgqog5lVXWCm
 vXvz5ZBiQXnzmJ99eVTb/pgOE9DMbnhB69S7T74CiFNNwgcVjbcXN/bEJLhOJ2+k17b0
 LyRA==
X-Gm-Message-State: AOJu0YxyCWbYkDcJHpZ35MIiwhsYFR28OVHiw9Jmtz5lOsTOsTrXSHvi
 2l6JU0LB6CFdeCqdeV5/8KQBJzx04cqQ7fDV6R274PR9rygFGzn+tVW+KgaLFpmVpCs=
X-Gm-Gg: Acq92OGpaywqAgBat4OBZAXh+itvvy6SsNszBq2x/xUzZyHWrhnZd1qgIlox82BNmjU
 wUeHo+BwG9GYLHN/+SmQmkYkUwHzCztA0HRjfKTEFrirLx3o483mvdhifCtt6AQiqZf1e4xi+f0
 kGi8XdVXrnUM3ibFu0peTUE783D97HrXeg1hQEQe+BBw4HBjefVNukkFqoWXdL1Z5OWID3D9sVV
 BTtHvvLWaIJwbNtNEqiu+SRSFkthxXqKo4K6/vNagswTVHiUF1Yd4VH5fp7ekpOQ2nCcCVPqsI+
 I7z150dn4aGRE4pwDAImjnV8ikFT21vmkov9064dglce/qC9kanIS3+XFv54U+xbMxwUcSklXoU
 Sqa5WP6oUKUFX3TpPJDHCxBtrSLcleA9CR2JlpSujbukX3ebyXnIpHY98C8hWwxCy60/N8sta3Y
 K3Veanw8cSYcRrkzw42poPPu51t6e3tKZwTq3gNYETFwLG2g==
X-Received: by 2002:a17:902:e751:b0:2b2:ebed:7afc with SMTP id
 d9443c01a7336-2baf0e045damr162167775ad.27.1778508313607; 
 Mon, 11 May 2026 07:05:13 -0700 (PDT)
Received: from ZBMac-LWN10QXKQ0.taila0cd24.ts.net ([115.108.63.147])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e90854sm105113435ad.66.2026.05.11.07.05.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 11 May 2026 07:05:13 -0700 (PDT)
From: Zhang Chen <zhangckid@gmail.com>
To: qemu-devel <qemu-devel@nongnu.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>
Subject: [PATCH V7 08/14] virtio: use iothread_get/put_aio_context for thread
 pinning
Date: Mon, 11 May 2026 22:04:10 +0800
Message-ID: <20260511140416.28271-9-zhangckid@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260511140416.28271-1-zhangckid@gmail.com>
References: <20260511140416.28271-1-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=zhangckid@gmail.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Refactor virtio-blk and virtio-scsi to use the new iothread_get/put
APIs for AioContext management. This ensures IOThread references
are tracked via the device's canonical QOM path.

Summary of changes:
- Lift 'path' scope to cover both vq_mapping and single iothread cases.
- Replace raw object_ref/unref with iothread_get/put_aio_context.
- Ensure consistent memory cleanup of the QOM path string.

Signed-off-by: Zhang Chen <zhangckid@gmail.com>
---
 hw/block/virtio-blk.c           | 16 +++++-----------
 hw/scsi/virtio-scsi-dataplane.c | 15 +++++----------
 2 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 30e9fcf870..e9f1dd5f8d 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -1463,6 +1463,7 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     VirtIOBlkConf *conf = &s->conf;
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(vdev)));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (conf->iothread && conf->iothread_vq_mapping_list) {
         error_setg(errp,
@@ -1487,8 +1488,6 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
     s->vq_aio_context = g_new(AioContext *, conf->num_queues);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(conf->iothread_vq_mapping_list,
                                        s->vq_aio_context,
                                        conf->num_queues,
@@ -1499,13 +1498,11 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
             return false;
         }
     } else if (conf->iothread) {
-        AioContext *ctx = iothread_get_aio_context(conf->iothread);
+        AioContext *ctx = iothread_ref_and_get_aio_context(conf->iothread,
+                                                           path);
         for (unsigned i = 0; i < conf->num_queues; i++) {
             s->vq_aio_context[i] = ctx;
         }
-
-        /* Released in virtio_blk_vq_aio_context_cleanup() */
-        object_ref(OBJECT(conf->iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < conf->num_queues; i++) {
@@ -1520,21 +1517,18 @@ static bool virtio_blk_vq_aio_context_init(VirtIOBlock *s, Error **errp)
 static void virtio_blk_vq_aio_context_cleanup(VirtIOBlock *s)
 {
     VirtIOBlkConf *conf = &s->conf;
+    g_autofree char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     assert(!s->ioeventfd_started);
 
     if (conf->iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(
-                                OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(conf->iothread_vq_mapping_list, path);
     }
 
     if (conf->iothread) {
-        object_unref(OBJECT(conf->iothread));
+        iothread_put_aio_context(conf->iothread, path);
     }
 
-    g_free(s->vq_aio_context);
     s->vq_aio_context = NULL;
 }
 
diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 26ecefd547..cc318162f5 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -28,6 +28,7 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+    g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
 
     if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
         error_setg(errp,
@@ -65,8 +66,6 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(OBJECT(vdev));
-
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
                     &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
                     vs->conf.num_queues, path, errp)) {
@@ -75,13 +74,11 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
             return;
         }
     } else if (vs->conf.iothread) {
-        AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
+        AioContext *ctx = iothread_ref_and_get_aio_context(vs->conf.iothread,
+                                                           path);
         for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
             s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
-
-        /* Released in virtio_scsi_dataplane_cleanup() */
-        object_ref(OBJECT(vs->conf.iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
         for (unsigned i = 0; i < vs->conf.num_queues; i++) {
@@ -94,16 +91,14 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
 void virtio_scsi_dataplane_cleanup(VirtIOSCSI *s)
 {
     VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(s);
+    g_autofree char *path = object_get_canonical_path(OBJECT(VIRTIO_DEVICE(s)));
 
     if (vs->conf.iothread_vq_mapping_list) {
-        g_autofree char *path = object_get_canonical_path(
-                                OBJECT(VIRTIO_DEVICE(s)));
-
         iothread_vq_mapping_cleanup(vs->conf.iothread_vq_mapping_list, path);
     }
 
     if (vs->conf.iothread) {
-        object_unref(OBJECT(vs->conf.iothread));
+        iothread_put_aio_context(vs->conf.iothread, path);
     }
 
     g_free(s->vq_aio_context);
-- 
2.49.0


