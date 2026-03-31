Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A242AFF60FB
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Vmw-0000WT-JV; Tue, 31 Mar 2026 05:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmu-0000W5-Nw
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmt-00085e-A3
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950810;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DCd5vbV6w9R6yKj4V/czrdfnnJcVB5pJMCCePIO1TVw=;
 b=K2GFwJYTnoVq1rhkXdYUNnRGGYzfmyU175BQLquVLTfHXP8jXLkSeCew1kaNwbY+EeRG8F
 OTcByK5R9Yizkx3FgBWeOzvMVwk/D3qFAOGxTTY1frUO5xkkvuPKfIwoT8Eg0cO18d9cC6
 1L6ZZs8tsqsHjX/72ypncvrIEFs7T20=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-or04q_v8Pm-qbfExPnd_PA-1; Tue,
 31 Mar 2026 05:53:27 -0400
X-MC-Unique: or04q_v8Pm-qbfExPnd_PA-1
X-Mimecast-MFC-AGG-ID: or04q_v8Pm-qbfExPnd_PA_1774950806
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4400180044D; Tue, 31 Mar 2026 09:53:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4319E1955F42; Tue, 31 Mar 2026 09:53:23 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 3/6] ui/dbus: tear down clipboard callbacks on display finalize
Date: Tue, 31 Mar 2026 13:52:59 +0400
Message-ID: <20260331095302.644608-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260331095302.644608-1-marcandre.lureau@redhat.com>
References: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
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

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

The clipboard D-Bus teardown path currently runs when the peer
disappears, but not when DBusDisplay itself is finalized.

That leaves pending clipboard requests and signal handlers associated
with the clipboard proxy active past display teardown.

Add an explicit clipboard fini hook and invoke it from
dbus_display_finalize() so the clipboard teardown also runs during
display destruction.

bixes: ff1a5810f61f ("ui/dbus: add clipboard interface")
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Message-ID: <20260330091310.42868-1-zhaoguohan@kylinos.cn>
[ Marc-André - Move clipobard finalization to the function]
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/dbus.h           |  1 +
 ui/dbus-clipboard.c | 16 ++++++++++++++++
 ui/dbus.c           |  3 +--
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/ui/dbus.h b/ui/dbus.h
index 1e8c24a48e3..986d7774601 100644
--- a/ui/dbus.h
+++ b/ui/dbus.h
@@ -150,5 +150,6 @@ void dbus_display_notify(DBusDisplayEvent *event);
 void dbus_chardev_init(DBusDisplay *dpy);
 
 void dbus_clipboard_init(DBusDisplay *dpy);
+void dbus_clipboard_fini(DBusDisplay *dpy);
 
 #endif /* UI_DBUS_H */
diff --git a/ui/dbus-clipboard.c b/ui/dbus-clipboard.c
index 6787a776687..935b6b1a2ac 100644
--- a/ui/dbus-clipboard.c
+++ b/ui/dbus-clipboard.c
@@ -191,6 +191,7 @@ static void
 dbus_clipboard_unregister_proxy(DBusDisplay *dpy)
 {
     const char *name = NULL;
+    GDBusConnection *connection = NULL;
     int i;
 
     for (i = 0; i < G_N_ELEMENTS(dpy->clipboard_request); ++i) {
@@ -201,6 +202,13 @@ dbus_clipboard_unregister_proxy(DBusDisplay *dpy)
         return;
     }
 
+    connection = g_dbus_proxy_get_connection(
+        G_DBUS_PROXY(dpy->clipboard_proxy));
+    if (connection) {
+        g_signal_handlers_disconnect_by_data(connection, dpy);
+    }
+    g_signal_handlers_disconnect_by_data(dpy->clipboard_proxy, dpy);
+
     name = g_dbus_proxy_get_name(G_DBUS_PROXY(dpy->clipboard_proxy));
     trace_dbus_clipboard_unregister(name);
     g_clear_object(&dpy->clipboard_proxy);
@@ -425,6 +433,14 @@ dbus_clipboard_request(
     return DBUS_METHOD_INVOCATION_HANDLED;
 }
 
+void
+dbus_clipboard_fini(DBusDisplay *dpy)
+{
+    dbus_clipboard_unregister_proxy(dpy);
+    qemu_clipboard_peer_unregister(&dpy->clipboard_peer);
+    g_clear_object(&dpy->clipboard);
+}
+
 void
 dbus_clipboard_init(DBusDisplay *dpy)
 {
diff --git a/ui/dbus.c b/ui/dbus.c
index 7c54b6a502d..794b65c4ada 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -145,8 +145,7 @@ dbus_display_finalize(Object *o)
         dbus_display_notifier_remove(&dd->notifier);
     }
 
-    qemu_clipboard_peer_unregister(&dd->clipboard_peer);
-    g_clear_object(&dd->clipboard);
+    dbus_clipboard_fini(dd);
 
     g_clear_object(&dd->server);
     g_clear_pointer(&dd->consoles, g_ptr_array_unref);
-- 
2.53.0


