Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54F1C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:21:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzOb-0000hb-KN; Tue, 11 Mar 2025 09:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzM8-0004rU-3T
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:09:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzM3-0001jG-UP
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741698538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DLBedgRZsFWvjgHM/ekL46tibum9+c7DeNR4LfA+/ng=;
 b=W4qWX936N4YupH2NcrTrVSazLk7s243U0zuUmWTM64OCr0VqSkm0EW8cERyRC0UY47fFgW
 CG6wwKV27xunIffoujxQc48RhcgO2O9+SLPsEk9GUE0GF1pgENNEJ9JT8F01Ztdu0QkaIb
 XT//SSJM1Aur94GYmkW/fbt/W5NSqJw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-BGOJxZnYNFiAWGn5o86w7Q-1; Tue,
 11 Mar 2025 09:08:55 -0400
X-MC-Unique: BGOJxZnYNFiAWGn5o86w7Q-1
X-Mimecast-MFC-AGG-ID: BGOJxZnYNFiAWGn5o86w7Q_1741698533
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C53B1956050; Tue, 11 Mar 2025 13:08:53 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D9AA91800944; Tue, 11 Mar 2025 13:08:51 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, pkrempa@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 14/14] virtio-scsi: only expose cmd vqs via
 iothread-vq-mapping
Date: Tue, 11 Mar 2025 21:07:41 +0800
Message-ID: <20250311130741.1047903-15-stefanha@redhat.com>
In-Reply-To: <20250311130741.1047903-1-stefanha@redhat.com>
References: <20250311130741.1047903-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Peter Krempa and Kevin Wolf observed that iothread-vq-mapping is
confusing to use because the control and event virtqueues have a fixed
location before the command virtqueues but need to be treated
differently.

Only expose the command virtqueues via iothread-vq-mapping so that the
command-line parameter is intuitive: it controls where SCSI requests are
processed.

The control virtqueue needs to be hardcoded to the main loop thread for
technical reasons anyway. Kevin also pointed out that it's better to
place the event virtqueue in the main loop thread since its no poll
behavior would prevent polling if assigned to an IOThread.

This change is its own commit to avoid squashing the previous commit.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Suggested-by: Peter Krempa <pkrempa@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/scsi/virtio-scsi-dataplane.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/hw/scsi/virtio-scsi-dataplane.c b/hw/scsi/virtio-scsi-dataplane.c
index 2d37fa6712..95f13fb7c2 100644
--- a/hw/scsi/virtio-scsi-dataplane.c
+++ b/hw/scsi/virtio-scsi-dataplane.c
@@ -28,7 +28,6 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
     VirtIODevice *vdev = VIRTIO_DEVICE(s);
     BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
-    uint16_t num_vqs = vs->conf.num_queues + VIRTIO_SCSI_VQ_NUM_FIXED;
 
     if (vs->conf.iothread && vs->conf.iothread_vq_mapping_list) {
         error_setg(errp,
@@ -50,35 +49,43 @@ void virtio_scsi_dataplane_setup(VirtIOSCSI *s, Error **errp)
         }
     }
 
-    s->vq_aio_context = g_new(AioContext *, num_vqs);
+    s->vq_aio_context = g_new(AioContext *, vs->conf.num_queues +
+                                            VIRTIO_SCSI_VQ_NUM_FIXED);
+
+    /*
+     * Handle the ctrl virtqueue in the main loop thread where device resets
+     * can be performed.
+     */
+    s->vq_aio_context[0] = qemu_get_aio_context();
+
+    /*
+     * Handle the event virtqueue in the main loop thread where its no_poll
+     * behavior won't stop IOThread polling.
+     */
+    s->vq_aio_context[1] = qemu_get_aio_context();
 
     if (vs->conf.iothread_vq_mapping_list) {
         if (!iothread_vq_mapping_apply(vs->conf.iothread_vq_mapping_list,
-                                       s->vq_aio_context, num_vqs, errp)) {
+                    &s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED],
+                    vs->conf.num_queues, errp)) {
             g_free(s->vq_aio_context);
             s->vq_aio_context = NULL;
             return;
         }
     } else if (vs->conf.iothread) {
         AioContext *ctx = iothread_get_aio_context(vs->conf.iothread);
-        for (uint16_t i = 0; i < num_vqs; i++) {
-            s->vq_aio_context[i] = ctx;
+        for (uint16_t i = 0; i < vs->conf.num_queues; i++) {
+            s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
 
         /* Released in virtio_scsi_dataplane_cleanup() */
         object_ref(OBJECT(vs->conf.iothread));
     } else {
         AioContext *ctx = qemu_get_aio_context();
-        for (unsigned i = 0; i < num_vqs; i++) {
-            s->vq_aio_context[i] = ctx;
+        for (unsigned i = 0; i < vs->conf.num_queues; i++) {
+            s->vq_aio_context[VIRTIO_SCSI_VQ_NUM_FIXED + i] = ctx;
         }
     }
-
-    /*
-     * Always handle the ctrl virtqueue in the main loop thread where device
-     * resets can be performed.
-     */
-    s->vq_aio_context[0] = qemu_get_aio_context();
 }
 
 /* Context: BQL held */
-- 
2.48.1


