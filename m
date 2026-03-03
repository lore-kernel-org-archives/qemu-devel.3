Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDDAEDA6B7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2026 17:30:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxTZJ-00008C-WB; Tue, 03 Mar 2026 12:30:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vxTZH-00007M-Cc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:29:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vxTZF-0005UV-BV
 for qemu-devel@nongnu.org; Tue, 03 Mar 2026 12:29:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772558994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KtJP/jguIFKde9rRUJ0UbrChrFZ64Us15Ltb92pQXtM=;
 b=fWPwi/8H3X1IK1BcOmOqdGtDnR1pDB3gyyhTUeWYmeVL8pEynZvcG/xc79+M+gkR+NRqbk
 ShAmFC+XEjOAiRlTg+uZjlzgZPoqhTxzEed4mqwcBaoKQwIBAC5PHlJ3TdDw3oYwdSMzyu
 QVgnlOyzI0XcL/aeBsBHxPneFOm8x2Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-V6xyC4zKPvONrIF-ttrXwQ-1; Tue,
 03 Mar 2026 12:29:53 -0500
X-MC-Unique: V6xyC4zKPvONrIF-ttrXwQ-1
X-Mimecast-MFC-AGG-ID: V6xyC4zKPvONrIF-ttrXwQ_1772558992
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D1891956050
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2026 17:29:52 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 927BF30001A5; Tue,  3 Mar 2026 17:29:51 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH] ui/dbus-listener: remove dbus_filter on connection close
Date: Tue,  3 Mar 2026 18:29:49 +0100
Message-ID: <20260303172949.291052-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The dbus filter holds a strong reference to the DBusDisplayListener
(via GDestroyNotify) to ensure the listener remains alive while the
filter may still be running in another thread. This creates a
reference cycle (ddl -> conn -> filter -> ddl) that prevents the
listener from being freed.

Break the cycle by connecting to the connection's "closed" signal
and removing the filter when the connection closes.

Fixes: commit fa88b85dea96 ("ui/dbus: filter out pending messages when scanout")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus-listener.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index fff7cf83274..37945236e11 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -1181,6 +1181,20 @@ static void dbus_display_listener_setup_scanout_dmabuf_v2(DBusDisplayListener *d
 #endif
 }
 
+static void
+dbus_conn_closed(GDBusConnection *conn,
+                 gboolean remote_peer_vanished,
+                 GError *error,
+                 gpointer user_data)
+{
+    DBusDisplayListener *ddl = DBUS_DISPLAY_LISTENER(user_data);
+
+    if (ddl->dbus_filter) {
+        g_dbus_connection_remove_filter(ddl->conn, ddl->dbus_filter);
+        ddl->dbus_filter = 0;
+    }
+}
+
 static GDBusMessage *
 dbus_filter(GDBusConnection *connection,
             GDBusMessage    *message,
@@ -1262,6 +1276,7 @@ dbus_display_listener_new(const char *bus_name,
     }
 
     ddl->dbus_filter = g_dbus_connection_add_filter(conn, dbus_filter, g_object_ref(ddl), g_object_unref);
+    g_signal_connect(conn, "closed", G_CALLBACK(dbus_conn_closed), ddl);
     ddl->bus_name = g_strdup(bus_name);
     ddl->conn = conn;
     ddl->console = console;
-- 
2.53.0


