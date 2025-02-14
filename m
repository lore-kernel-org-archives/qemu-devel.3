Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30359C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 07:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiq6B-0003mI-Ty; Fri, 14 Feb 2025 02:26:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tiq61-0003lu-1n
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 02:26:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tiq5x-0004qh-D5
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 02:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739517998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=xR5CxJmrVF+duPI4z5nygLIw+eS9r18PSYYdCl57Ua0=;
 b=aNM5/9MXMa3pH8J1FAiPrXgsTaoEZAt1D7SPyA0XhTyiF2EQmvq8tlsVDASdoY4UPQ7eZt
 U7JhkDG3LCRRyqadV5VZKX3AJ5i/Q33R5jebKPv88EGJ2xxeaExEi+8FF7ej+XjJM6+QyR
 wPm8pY94MGYUYiZ5JTYSw5E2qmbNRa4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-RCz0sZ-LOzyFau6vVg_Zag-1; Fri,
 14 Feb 2025 02:26:35 -0500
X-MC-Unique: RCz0sZ-LOzyFau6vVg_Zag-1
X-Mimecast-MFC-AGG-ID: RCz0sZ-LOzyFau6vVg_Zag_1739517995
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 128C01800875
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 07:26:34 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.77])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C01E4180034D; Fri, 14 Feb 2025 07:26:30 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laine Stump <laine@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] net: vhost-user: add QAPI events to report connection state
Date: Fri, 14 Feb 2025 08:26:25 +0100
Message-ID: <20250214072629.1033314-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

The netdev reports NETDEV_VHOST_USER_CONNECTED event when
the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
when it is disconnected.

The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
(label, filename and frontend_open).

This allows a system manager like libvirt to detect when the server
fails.

For instance with passt:

{ 'execute': 'qmp_capabilities' }
{ "return": { } }

[killing passt here]

{ "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
  "event": "NETDEV_VHOST_USER_DISCONNECTED",
  "data": { "netdev-id": "netdev0" } }

[automatic reconnection with reconnect-ms]

{ "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
  "event": "NETDEV_VHOST_USER_CONNECTED",
  "data": { "netdev-id": "netdev0",
            "info": { "frontend-open": true,
                      "filename": "unix:",
                      "label": "chr0" } } }

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 qapi/char.json   | 43 +++++++++++++++++++++++++++++++++++++++++++
 net/vhost-user.c |  8 ++++++++
 2 files changed, 51 insertions(+)

diff --git a/qapi/char.json b/qapi/char.json
index f02b66c06b3e..a8094c86fb49 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -902,3 +902,46 @@
 { 'event': 'VSERPORT_CHANGE',
   'data': { 'id': 'str',
             'open': 'bool' } }
+
+##
+# @NETDEV_VHOST_USER_CONNECTED:
+#
+# Emitted when the vhost-user chardev is connected
+#
+# @netdev-id: QEMU netdev id that is connected
+#
+# @info: The chardev information
+#
+# Since: 10.0
+#
+# .. qmp-example::
+#
+#     <- { "timestamp": { "seconds": 1739469793, "microseconds": 683713 },
+#          "event": "NETDEV_VHOST_USER_CONNECTED",
+#          "data": { "netdev-id": "netdev0",
+#                   "info": { "frontend-open": true,
+#                             "filename": "unix:",
+#                             "label": "chr0" } } }
+#
+##
+{ 'event': 'NETDEV_VHOST_USER_CONNECTED',
+  'data': { 'netdev-id': 'str', 'info': 'ChardevInfo' } }
+
+##
+# @NETDEV_VHOST_USER_DISCONNECTED:
+#
+# Emitted when the vhost-user chardev is disconnected
+#
+# @netdev-id: QEMU netdev id that is disconnected
+#
+# Since: 10.0
+#
+# .. qmp-example::
+#
+#     <- { "timestamp": { "seconds": 1739469786, "microseconds": 822220 },
+#          "event": "NETDEV_VHOST_USER_DISCONNECTED",
+#          "data": { "netdev-id": "netdev0" } }
+#
+##
+{ 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
+  'data': { 'netdev-id': 'str' } }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 12555518e838..841b94e785a4 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -16,6 +16,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-events-char.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -271,6 +272,7 @@ static void chr_closed_bh(void *opaque)
     if (err) {
         error_report_err(err);
     }
+    qapi_event_send_netdev_vhost_user_disconnected(name);
 }
 
 static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
@@ -278,6 +280,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
     const char *name = opaque;
     NetClientState *ncs[MAX_QUEUE_NUM];
     NetVhostUserState *s;
+    ChardevInfo info;
     Chardev *chr;
     Error *err = NULL;
     int queues;
@@ -300,6 +303,11 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
                                          net_vhost_user_watch, s);
         qmp_set_link(name, true, &err);
         s->started = true;
+        info.label = chr->label;
+        info.filename = chr->filename;
+        info.frontend_open = chr->filename;
+        info.frontend_open = chr->be && chr->be->fe_is_open;
+        qapi_event_send_netdev_vhost_user_connected(name, &info);
         break;
     case CHR_EVENT_CLOSED:
         /* a close event may happen during a read/write, but vhost
-- 
2.48.1


