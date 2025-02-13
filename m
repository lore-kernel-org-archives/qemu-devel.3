Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE3D3C021A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 18:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tidZI-0001x9-2i; Thu, 13 Feb 2025 13:04:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWT-0007qZ-RI
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tidWR-0006SU-6A
 for qemu-devel@nongnu.org; Thu, 13 Feb 2025 13:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739469670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6hDIk/GCeH0GyjCAVJxPnfpp/0/yWj+uRBsdKeWULGI=;
 b=APW7OVYQhIinXbicEYi8y+WloopJ4b70UYOHSy8QMZyvIvsCSJpqot8MRks7Uf4ofCVeCB
 aPhWBEXFC6PWoqn8w/5HXNilrj7HU2rwYlWpGTwAuvffOe0ocFEJnlVEP3TyxABJDaZSBm
 /6gyRowIOw5P2D68B85EE4E8lvzyWSk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-ae-7-2iPPmSctw8YyUmdmQ-1; Thu,
 13 Feb 2025 13:01:05 -0500
X-MC-Unique: ae-7-2iPPmSctw8YyUmdmQ-1
X-Mimecast-MFC-AGG-ID: ae-7-2iPPmSctw8YyUmdmQ_1739469664
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 00F2819373DC; Thu, 13 Feb 2025 18:01:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.157])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 926AF1800359; Thu, 13 Feb 2025 18:01:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Fam Zheng <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 David Hildenbrand <david@redhat.com>, pkrempa@redhat.com,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH 06/12] virtio-scsi: protect events_dropped field
Date: Thu, 13 Feb 2025 13:00:37 -0500
Message-ID: <20250213180043.713434-7-stefanha@redhat.com>
In-Reply-To: <20250213180043.713434-1-stefanha@redhat.com>
References: <20250213180043.713434-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The block layer can invoke the resize callback from any AioContext that
is processing requests. The virtqueue is already protected but the
events_dropped field also needs to be protected against races. Cover it
using the event virtqueue lock because it is closely associated with
accesses to the virtqueue.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/hw/virtio/virtio-scsi.h |  3 ++-
 hw/scsi/virtio-scsi.c           | 29 ++++++++++++++++++++---------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 4ee98ebf63..7b7e3ced7a 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -82,10 +82,11 @@ struct VirtIOSCSI {
 
     SCSIBus bus;
     int resetting; /* written from main loop thread, read from any thread */
+
+    QemuMutex event_lock; /* protects event_vq and events_dropped */
     bool events_dropped;
 
     QemuMutex ctrl_lock; /* protects ctrl_vq */
-    QemuMutex event_lock; /* protects event_vq */
 
     /*
      * TMFs deferred to main loop BH. These fields are protected by
diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
index 073ccd3d5b..2d796a861b 100644
--- a/hw/scsi/virtio-scsi.c
+++ b/hw/scsi/virtio-scsi.c
@@ -948,7 +948,10 @@ static void virtio_scsi_reset(VirtIODevice *vdev)
 
     vs->sense_size = VIRTIO_SCSI_SENSE_DEFAULT_SIZE;
     vs->cdb_size = VIRTIO_SCSI_CDB_DEFAULT_SIZE;
-    s->events_dropped = false;
+
+    WITH_QEMU_LOCK_GUARD(&s->event_lock) {
+        s->events_dropped = false;
+    }
 }
 
 typedef struct {
@@ -978,14 +981,16 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
     }
 
     req = virtio_scsi_pop_req(s, vs->event_vq, &s->event_lock);
-    if (!req) {
-        s->events_dropped = true;
-        return;
-    }
+    WITH_QEMU_LOCK_GUARD(&s->event_lock) {
+        if (!req) {
+            s->events_dropped = true;
+            return;
+        }
 
-    if (s->events_dropped) {
-        event |= VIRTIO_SCSI_T_EVENTS_MISSED;
-        s->events_dropped = false;
+        if (s->events_dropped) {
+            event |= VIRTIO_SCSI_T_EVENTS_MISSED;
+            s->events_dropped = false;
+        }
     }
 
     if (virtio_scsi_parse_req(req, 0, sizeof(VirtIOSCSIEvent))) {
@@ -1014,7 +1019,13 @@ static void virtio_scsi_push_event(VirtIOSCSI *s,
 
 static void virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
 {
-    if (s->events_dropped) {
+    bool events_dropped;
+
+    WITH_QEMU_LOCK_GUARD(&s->event_lock) {
+        events_dropped = s->events_dropped;
+    }
+
+    if (events_dropped) {
         VirtIOSCSIEventInfo info = {
             .event = VIRTIO_SCSI_T_NO_EVENT,
         };
-- 
2.48.1


