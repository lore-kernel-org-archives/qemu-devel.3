Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F821C36002
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 09:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2S2n-0001ZR-BS; Wed, 09 Apr 2025 05:48:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2S2g-0001Z0-5I
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:48:23 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u2S2c-0004c1-NG
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 05:48:21 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:ca1:0:640:740c:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 053C6609F2;
 Wed,  9 Apr 2025 12:48:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7304::1:2d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 0mapSM0FX8c0-S3DXjdrb; Wed, 09 Apr 2025 12:48:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744192091;
 bh=dZMAUJ28UMyT0leNdXao1bKCkRhuoXVNH4SF8i7wsaU=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=ey7tm1iRX1DzDZDouzHTxZS/SexuwFpNAoZpgKu83G8HCMPLkjaQR7JcSxCmHjUr1
 rmyW/G0zaTjvZSqApHbfEzJZWJLH9b7w2pymbeGh1brxqg6165/bwqIwiYF8nQ78oN
 P6CWJ+f1q4Y1qfZvY05zZK+wByMl2Hg0T5bD4imw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: eblake@redhat.com, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, dave@treblig.org, armbru@redhat.com,
 sgarzare@redhat.com, den-plotnikov@yandex-team.ru,
 vsementsov@yandex-team.ru
Subject: [PATCH v6] [for-10.1] virtio: add VIRTQUEUE_ERROR QAPI event
Date: Wed,  9 Apr 2025 12:47:58 +0300
Message-ID: <20250409094758.58232-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For now we only log the vhost device error, when virtqueue is actually
stopped. Let's add a QAPI event, which makes possible:

 - collect statistics of such errors
 - make immediate actions: take core dumps or do some other debugging
 - inform the user through a management API or UI, so that (s)he can
  react somehow, e.g. reset the device driver in the guest or even
  build up some automation to do so

Note that basically every inconsistency discovered during virtqueue
processing results in a silent virtqueue stop.  The guest then just
sees the requests getting stuck somewhere in the device for no visible
reason.  This event provides a means to inform the management layer of
this situation in a timely fashion.

The event could be reused for some other virtqueue problems (not only
for vhost devices) in future. For this it gets a generic name and
structure.

We keep original VHOST_OPS_DEBUG(), to keep original debug output as is
here, it's not the only call to VHOST_OPS_DEBUG in the file.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---

v6: rename path to qom-path, and improve throttling of the event
    improve wording

 hw/virtio/vhost.c | 12 +++++++++---
 monitor/monitor.c | 14 ++++++++++++++
 qapi/qdev.json    | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..0b205cef73 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -15,6 +15,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qapi/qapi-events-qdev.h"
 #include "hw/virtio/vhost.h"
 #include "qemu/atomic.h"
 #include "qemu/range.h"
@@ -1442,11 +1443,16 @@ static void vhost_virtqueue_error_notifier(EventNotifier *n)
     struct vhost_virtqueue *vq = container_of(n, struct vhost_virtqueue,
                                               error_notifier);
     struct vhost_dev *dev = vq->dev;
-    int index = vq - dev->vqs;
 
     if (event_notifier_test_and_clear(n) && dev->vdev) {
-        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d",
-                        dev->vq_index + index);
+        int ind = vq - dev->vqs + dev->vq_index;
+        DeviceState *ds = &dev->vdev->parent_obj;
+
+        VHOST_OPS_DEBUG(-EINVAL,  "vhost vring error in virtqueue %d", ind);
+        qapi_event_send_virtqueue_error(ds->id, ds->canonical_path, ind,
+                                        VIRTQUEUE_ERROR_VHOST_VRING_ERROR,
+                                        "vhost reported failure through vring "
+                                        "error fd");
     }
 }
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index c5a5d30877..11c8859703 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -313,6 +313,7 @@ static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] = {
     [QAPI_EVENT_BALLOON_CHANGE]    = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_REPORT_BAD] = { 1000 * SCALE_MS },
     [QAPI_EVENT_QUORUM_FAILURE]    = { 1000 * SCALE_MS },
+    [QAPI_EVENT_VIRTQUEUE_ERROR]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_VSERPORT_CHANGE]   = { 1000 * SCALE_MS },
     [QAPI_EVENT_MEMORY_DEVICE_SIZE_CHANGE] = { 1000 * SCALE_MS },
     [QAPI_EVENT_HV_BALLOON_STATUS_REPORT] = { 1000 * SCALE_MS },
@@ -499,6 +500,12 @@ static unsigned int qapi_event_throttle_hash(const void *key)
         hash += g_str_hash(qdict_get_str(evstate->data, "qom-path"));
     }
 
+    if (evstate->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
+        uint64_t virtqueue = qdict_get_int(evstate->data, "virtqueue");
+        hash += g_str_hash(qdict_get_str(evstate->data, "qom-path")) ^
+            g_int64_hash(&virtqueue);
+    }
+
     return hash;
 }
 
@@ -527,6 +534,13 @@ static gboolean qapi_event_throttle_equal(const void *a, const void *b)
                        qdict_get_str(evb->data, "qom-path"));
     }
 
+    if (eva->event == QAPI_EVENT_VIRTQUEUE_ERROR) {
+        return !strcmp(qdict_get_str(eva->data, "qom-path"),
+                       qdict_get_str(evb->data, "qom-path")) &&
+            (qdict_get_int(eva->data, "virtqueue") ==
+             qdict_get_int(evb->data, "virtqueue"));
+    }
+
     return TRUE;
 }
 
diff --git a/qapi/qdev.json b/qapi/qdev.json
index 25cbcf977b..ddfae18761 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -187,3 +187,35 @@
 { 'command': 'device-sync-config',
   'features': [ 'unstable' ],
   'data': {'id': 'str'} }
+
+##
+# @VirtqueueError:
+#
+# @vhost-vring-error: the vhost device has communicated failure via
+#     the vring error file descriptor
+#
+# Since: 10.1
+##
+{ 'enum': 'VirtqueueError',
+  'data': [ 'vhost-vring-error' ] }
+
+##
+# @VIRTQUEUE_ERROR:
+#
+# Emitted when a device virtqueue fails at runtime.
+#
+# @device: the device's ID if it has one
+#
+# @qom-path: the device's QOM path
+#
+# @virtqueue: the index of the virtqueue that failed
+#
+# @error: error identifier
+#
+# @description: human readable description
+#
+# Since: 10.1
+##
+{ 'event': 'VIRTQUEUE_ERROR',
+ 'data': { '*device': 'str', 'qom-path': 'str', 'virtqueue': 'int',
+            'error': 'VirtqueueError', 'description': 'str'} }
-- 
2.48.1


