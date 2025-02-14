Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03402C02198
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:19:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tivb1-00056l-AA; Fri, 14 Feb 2025 08:19:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tivay-00056Z-71
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:19:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tivaw-00043N-4k
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739539140;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=IiOtxODuQV5TvWsuhzTXt9OZ/adRbCI/dokbCeU4A4M=;
 b=XPR1kzmc9Dta6GwEbOysnW3MHWJv/itpCe6ZYHxQ8Gv+MWQJrrYNlDPo54yJl75iIyqJIN
 vn4+k8CVSsGplJw7nUyqVHaoR5fqaAmTHxqC4U9wo471lWrvYlFMXMgVmMeSoHbTu3PZZI
 dXlnR8WYdZgVnsurvmTxKZqG91seaD4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-191-RZiy_cH7OJaQneZyAMkBVg-1; Fri,
 14 Feb 2025 08:18:58 -0500
X-MC-Unique: RZiy_cH7OJaQneZyAMkBVg-1
X-Mimecast-MFC-AGG-ID: RZiy_cH7OJaQneZyAMkBVg_1739539138
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAAED19560B9
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 13:18:57 +0000 (UTC)
Received: from lenovo-t14s.redhat.com (unknown [10.45.225.77])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E7262300018D; Fri, 14 Feb 2025 13:18:52 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Laine Stump <laine@redhat.com>
Subject: [PATCH v3] net: vhost-user: add QAPI events to report connection state
Date: Fri, 14 Feb 2025 14:18:51 +0100
Message-ID: <20250214131851.1069008-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
    v3:
      - remove ChardevInfo, provides only the chardev id
    
    v2:
      - remove duplicate line info.frontend_open

 qapi/char.json   | 40 ++++++++++++++++++++++++++++++++++++++++
 net/vhost-user.c |  3 +++
 2 files changed, 43 insertions(+)

diff --git a/qapi/char.json b/qapi/char.json
index f02b66c06b3e..ef4fa95eec39 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -902,3 +902,43 @@
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
index 12555518e838..d754e4239e7f 100644
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


