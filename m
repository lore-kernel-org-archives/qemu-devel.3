Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0602AC021A0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 09:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjxOI-0000uh-R4; Mon, 17 Feb 2025 04:26:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tjxO9-0000uN-SU
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:26:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tjxO7-0000jl-5S
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 04:26:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739784361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=YWubsgm/C33yheY1Ji5XgcY/1CjNFDqiuX6ixhWgwyg=;
 b=BBi9isTs6fJ/Rsuav7VQLidtS7Pu4TP8X2DN1AG2FTt2iPU2Pjgy+CD4niZXbmPCHxs1gm
 SsmHo5mumnkxoZQL6jpCRvCBQD3uIE984J714WAvrjV46WPy5s0Aq9F5WazWbqlJwgRvbS
 cWWjBqU0K/6dF1JYnzF5skw5PHoK0S4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-_2fFA0o2NhicA3gWzrwbtA-1; Mon,
 17 Feb 2025 04:25:56 -0500
X-MC-Unique: _2fFA0o2NhicA3gWzrwbtA-1
X-Mimecast-MFC-AGG-ID: _2fFA0o2NhicA3gWzrwbtA_1739784355
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB1A919783BA
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 09:25:55 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.77])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EDFD719560AE; Mon, 17 Feb 2025 09:25:51 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefano Brivio <sbrivio@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Laine Stump <laine@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v4] net: vhost-user: add QAPI events to report connection state
Date: Mon, 17 Feb 2025 10:25:50 +0100
Message-ID: <20250217092550.1172055-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

The NETDEV_VHOST_USER_CONNECTED event includes the chardev id.

This allows a system manager like libvirt to detect when the server
fails.

For instance with passt:

{ 'execute': 'qmp_capabilities' }
{ "return": { } }

[killing passt here]

{ "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
  "event": "NETDEV_VHOST_USER_DISCONNECTED",
  "data": { "netdev-id": "netdev0" } }

[automatic reconnection with reconnect-ms]

{ "timestamp": { "seconds": 1739538638, "microseconds": 354181 },
  "event": "NETDEV_VHOST_USER_CONNECTED",
  "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }

Tested-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---

Notes:
    v4:
      - as ChardevInfo is not needed, move events definition from
        qapi/char.json to qapi/net.json
    
    v3:
      - remove ChardevInfo, provides only the chardev id
    
    v2:
      - remove duplicate line info.frontend_open

 qapi/net.json    | 40 ++++++++++++++++++++++++++++++++++++++++
 net/vhost-user.c |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/qapi/net.json b/qapi/net.json
index 2739a2f42332..310cc4fd1907 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1031,3 +1031,43 @@
 ##
 { 'event': 'NETDEV_STREAM_DISCONNECTED',
   'data': { 'netdev-id': 'str' } }
+
+##
+# @NETDEV_VHOST_USER_CONNECTED:
+#
+# Emitted when the vhost-user chardev is connected
+#
+# @netdev-id: QEMU netdev id that is connected
+#
+# @chardev-id: The character device id used by the QEMU netdev
+#
+# Since: 10.0
+#
+# .. qmp-example::
+#
+#     <- { "timestamp": {"seconds": 1739538638, "microseconds": 354181 },
+#          "event": "NETDEV_VHOST_USER_CONNECTED",
+#          "data": { "netdev-id": "netdev0", "chardev-id": "chr0" } }
+#
+##
+{ 'event': 'NETDEV_VHOST_USER_CONNECTED',
+  'data': { 'netdev-id': 'str', 'chardev-id': 'str' } }
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
+#     <- { "timestamp": { "seconds": 1739538634, "microseconds": 920450 },
+#          "event": "NETDEV_VHOST_USER_DISCONNECTED",
+#          "data": { "netdev-id": "netdev0" } }
+#
+##
+{ 'event': 'NETDEV_VHOST_USER_DISCONNECTED',
+  'data': { 'netdev-id': 'str' } }
diff --git a/net/vhost-user.c b/net/vhost-user.c
index 12555518e838..0b235e50c650 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -16,6 +16,7 @@
 #include "chardev/char-fe.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-events-net.h"
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
@@ -300,6 +302,7 @@ static void net_vhost_user_event(void *opaque, QEMUChrEvent event)
                                          net_vhost_user_watch, s);
         qmp_set_link(name, true, &err);
         s->started = true;
+        qapi_event_send_netdev_vhost_user_connected(name, chr->label);
         break;
     case CHR_EVENT_CLOSED:
         /* a close event may happen during a read/write, but vhost
-- 
2.48.1


