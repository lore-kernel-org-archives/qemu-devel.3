Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A3DC021A4
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 09:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tis2k-0002I6-Cm; Fri, 14 Feb 2025 04:31:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tis2h-0002Gj-1z
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 04:31:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tis2f-0000jc-4T
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 04:31:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739525482;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ImEA3ZSYHuBW0012KMglA/kzLk+KNYBQeSrdRExTdOU=;
 b=D0bbCdHGp2O3i+b/vGRVDBSuOUZbQmMS2p5otzWpowYB5nY9kgrDHxVfjbY5nYlu+TBg/j
 EEYpkViAQDOkfmQ3eyUn+LnQwU998DsMumpamV5eD+GpSN3v1vXHZALxa+b6Gr41mbuqXX
 7ZyJUe99HkhKihYeMk6O54sh+HkshTY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-245-4il_q-vtP_-dpLpC90Am8g-1; Fri,
 14 Feb 2025 04:31:20 -0500
X-MC-Unique: 4il_q-vtP_-dpLpC90Am8g-1
X-Mimecast-MFC-AGG-ID: 4il_q-vtP_-dpLpC90Am8g_1739525479
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6ED419783B6
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 09:31:18 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.77])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D530B19373C4; Fri, 14 Feb 2025 09:31:13 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laine Stump <laine@redhat.com>
Subject: [PATCH v2] net: vhost-user: add QAPI events to report connection state
Date: Fri, 14 Feb 2025 10:31:10 +0100
Message-ID: <20250214093112.1045586-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
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

Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v2:
      - remove duplicate line info.frontend_open

 qapi/char.json   | 43 +++++++++++++++++++++++++++++++++++++++++++
 net/vhost-user.c |  7 +++++++
 2 files changed, 50 insertions(+)

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
index 12555518e838..049174f704cd 100644
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
@@ -300,6 +303,10 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
                                          net_vhost_user_watch, s);
         qmp_set_link(name, true, &err);
         s->started = true;
+        info.label = chr->label;
+        info.filename = chr->filename;
+        info.frontend_open = chr->be && chr->be->fe_is_open;
+        qapi_event_send_netdev_vhost_user_connected(name, &info);
         break;
     case CHR_EVENT_CLOSED:
         /* a close event may happen during a read/write, but vhost
-- 
2.48.1


