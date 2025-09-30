Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1202CCA470
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 12:49:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3ZlM-00081X-Bx; Tue, 30 Sep 2025 08:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3ZlJ-00080G-2d
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3Zl8-0002MX-CR
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 08:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759236426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6s1dKWKvKLSY89j0CwAEhdQCKqhWKw+Iv4QPbejN4A=;
 b=ciGFN5480W4NFqapBgevCzCtJFntgNuzZFmBexsr5ETJHoARqMdnfvREpJyzKInUUn3L+q
 HpdYtJ8Zo3EVQLtforHWmoKbSDYY7ZRADPmARusBcf1wDgwYxy9ZbzYNDU1jLM71O9EAL/
 OMqVOqOxwEiQuWWf97Bh6oS7jVyem6s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-86-WVGxOrmlONWZjQ1Z3m9aYg-1; Tue,
 30 Sep 2025 08:47:02 -0400
X-MC-Unique: WVGxOrmlONWZjQ1Z3m9aYg-1
X-Mimecast-MFC-AGG-ID: WVGxOrmlONWZjQ1Z3m9aYg_1759236422
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58AB31977502; Tue, 30 Sep 2025 12:47:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D660F1955F1A; Tue, 30 Sep 2025 12:47:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B1E721E66AB; Tue, 30 Sep 2025 14:46:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 11/13] ui/dbus: Consistent handling of texture mutex failure
Date: Tue, 30 Sep 2025 14:46:51 +0200
Message-ID: <20250930124653.321609-12-armbru@redhat.com>
In-Reply-To: <20250930124653.321609-1-armbru@redhat.com>
References: <20250930124653.321609-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We report d3d_texture2d_acquire0() and d3d_texture2d_release0()
failure as error, except in dbus_update_gl_cb(), where we report it as
warning.  Report it as error there as well.

Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20250923091000.3180122-12-armbru@redhat.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 ui/dbus-listener.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/ui/dbus-listener.c b/ui/dbus-listener.c
index 09d7a319b1..b82e7c7115 100644
--- a/ui/dbus-listener.c
+++ b/ui/dbus-listener.c
@@ -214,26 +214,31 @@ static void dbus_update_gl_cb(GObject *source_object,
                               GAsyncResult *res,
                               gpointer user_data)
 {
-    g_autoptr(GError) err = NULL;
+    g_autoptr(GError) gerr = NULL;
+#ifdef WIN32
+    Error **err = NULL;
+#endif
     DBusDisplayListener *ddl = user_data;
     bool success;
 
 #ifdef CONFIG_GBM
     success = qemu_dbus_display1_listener_call_update_dmabuf_finish(
-        ddl->proxy, res, &err);
+        ddl->proxy, res, &gerr);
     if (!success) {
-        error_report("Failed to call update: %s", err->message);
+        error_report("Failed to call update: %s", gerr->message);
     }
 #endif
 
 #ifdef WIN32
     success = qemu_dbus_display1_listener_win32_d3d11_call_update_texture2d_finish(
-        ddl->d3d11_proxy, res, &err);
+        ddl->d3d11_proxy, res, &gerr);
     if (!success) {
-        error_report("Failed to call update: %s", err->message);
+        error_report("Failed to call update: %s", gerr->message);
     }
 
-    d3d_texture2d_acquire0(ddl->d3d_texture, &error_warn);
+    if (!d3d_texture2d_acquire0(ddl->d3d_texture, &err)) {
+        error_report_err(err);
+    }
 #endif
 
     graphic_hw_gl_block(ddl->dcl.con, false);
-- 
2.49.0


