Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CE44C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzNv-00076G-6S; Tue, 11 Mar 2025 09:11:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzLM-0004NN-Hd
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1trzLK-0001bX-Me
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 09:08:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741698501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CE1im9Bjq31X9Eaxj30dsdZEIRgev+UbxVXubrTF5n4=;
 b=brz/YfqNEgLUT7WDpYr1S8iqB/K3zaSz4Sv6AYdHQ/lHVRjcKhmJ29hiFRZCi/hv5yhqJv
 UUVWrWENY4hk7GYY/90b9gM0IfBl58OayyrKgp7MYF33gYzF20Vz9F5U+wLxhNgHUaHoUB
 NFITMA2KPgIg3gwT5YZRoTJvCCGZp/I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-ESw7CSc-P9uLxqfrbqYHvA-1; Tue,
 11 Mar 2025 09:08:18 -0400
X-MC-Unique: ESw7CSc-P9uLxqfrbqYHvA-1
X-Mimecast-MFC-AGG-ID: ESw7CSc-P9uLxqfrbqYHvA_1741698496
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F8961800EC5; Tue, 11 Mar 2025 13:08:16 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1E2B31956094; Tue, 11 Mar 2025 13:08:14 +0000 (UTC)
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
Subject: [PATCH v3 06/14] virtio-scsi: protect events_dropped field
Date: Tue, 11 Mar 2025 21:07:33 +0800
Message-ID: <20250311130741.1047903-7-stefanha@redhat.com>
In-Reply-To: <20250311130741.1047903-1-stefanha@redhat.com>
References: <20250311130741.1047903-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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


