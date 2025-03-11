Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C78C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzeI-0003Na-Iv; Tue, 11 Mar 2025 09:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdP-0002Mf-LN
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzdK-0005Eb-NZ
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:27:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741699614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CE1im9Bjq31X9Eaxj30dsdZEIRgev+UbxVXubrTF5n4=;
 b=MflfqOafsB9ZQ6eqK/goquqzFfLzTJfqotLeMQrkhNaaKBGty8o3RjyNWK0YF+74yQnrTS
 l+LfBomPmVK2vTpXJt+LZcCh8e+CrPm3zUDNT5R6R1u7D/Qu165TsdAVCvQ4u/Y6u8dMlv
 1TGPi8HXQeBPjj5ljOTMmNlIZitHcZo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-07ky7UkHO3aMNU2DoXvYwg-1; Tue,
 11 Mar 2025 09:26:51 -0400
X-MC-Unique: 07ky7UkHO3aMNU2DoXvYwg-1
X-Mimecast-MFC-AGG-ID: 07ky7UkHO3aMNU2DoXvYwg_1741699610
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F35491955D67; Tue, 11 Mar 2025 13:26:49 +0000 (UTC)
Received: from localhost (unknown [10.2.16.118])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBBE518001DE; Tue, 11 Mar 2025 13:26:48 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 pkrempa@redhat.com, Fam Zheng <fam@euphon.net>, <qemu-block@nongnu.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH v4 06/13] virtio-scsi: protect events_dropped field
Date: Tue, 11 Mar 2025 21:26:09 +0800
Message-ID: <20250311132616.1049687-7-stefanha@redhat.com>
In-Reply-To: <20250311132616.1049687-1-stefanha@redhat.com>
References: <20250311132616.1049687-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
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


