Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7633E9E311
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqC7m-0007kS-6w; Wed, 11 Feb 2026 10:27:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC73-0006jq-R3
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vqC71-0005yg-A0
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:26:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770823602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5X80YirqVbdBeezsX1Xx2uS/KBTswwOh/p3/QZ8PMc8=;
 b=Vb9B0oAw0n/s05AC/33umOdUsof2r2YnVguyw+bhcf058qWu5Y7/xVcLWjeGxrAMWakZoM
 mv4GPWGZQBoT1HkbeKxd4pvPt/u8TufEF4VsKrziRUfbRY+iOjp0pVq2Eii7p12QnCecI4
 ugHPYVKauumsGcJN7Gvigr3+OvVkP20=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-z2u0O0uqMTiSltl6P3I0HQ-1; Wed,
 11 Feb 2026 10:26:39 -0500
X-MC-Unique: z2u0O0uqMTiSltl6P3I0HQ-1
X-Mimecast-MFC-AGG-ID: z2u0O0uqMTiSltl6P3I0HQ_1770823597
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E4651800370; Wed, 11 Feb 2026 15:26:37 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.45.227.9])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BF11A30001A8; Wed, 11 Feb 2026 15:26:32 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v6 14/27] ui: add proper error reporting for password changes
Date: Wed, 11 Feb 2026 15:24:55 +0000
Message-ID: <20260211152508.732487-15-berrange@redhat.com>
In-Reply-To: <20260211152508.732487-1-berrange@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Neither the VNC or SPICE code for password changes provides error
reporting at source, leading the callers to report a largely useless
generic error message.

Fixing this removes one of the two remaining needs for the undesirable
error_printf_unless_qmp() method.

While fixing this the error message hint is improved to recommend the
'password-secret' option which allows securely passing a password at
startup.

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/ui/console.h                 |  2 +-
 include/ui/qemu-spice-module.h       |  3 ++-
 tests/functional/generic/test_vnc.py |  4 ++--
 ui/spice-core.c                      | 25 ++++++++++++++++++-------
 ui/spice-module.c                    |  7 ++++---
 ui/ui-qmp-cmds.c                     | 19 ++++++-------------
 ui/vnc-stubs.c                       |  6 +++---
 ui/vnc.c                             | 10 +++++++---
 8 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 98feaa58bd..3677a9d334 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -457,7 +457,7 @@ void qemu_display_help(void);
 void vnc_display_init(const char *id, Error **errp);
 void vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
-int vnc_display_password(const char *id, const char *password);
+int vnc_display_password(const char *id, const char *password, Error **errp);
 int vnc_display_pw_expire(const char *id, time_t expires);
 void vnc_parse(const char *str);
 int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp);
diff --git a/include/ui/qemu-spice-module.h b/include/ui/qemu-spice-module.h
index 1f22d557ea..072efa0c83 100644
--- a/include/ui/qemu-spice-module.h
+++ b/include/ui/qemu-spice-module.h
@@ -29,7 +29,8 @@ struct QemuSpiceOps {
     void (*display_init)(void);
     int (*migrate_info)(const char *h, int p, int t, const char *s);
     int (*set_passwd)(const char *passwd,
-                      bool fail_if_connected, bool disconnect_if_connected);
+                      bool fail_if_connected, bool disconnect_if_connected,
+                      Error **errp);
     int (*set_pw_expire)(time_t expires);
     int (*display_add_client)(int csock, int skipauth, int tls);
 #ifdef CONFIG_SPICE
diff --git a/tests/functional/generic/test_vnc.py b/tests/functional/generic/test_vnc.py
index f1dd1597cf..097f858ca1 100755
--- a/tests/functional/generic/test_vnc.py
+++ b/tests/functional/generic/test_vnc.py
@@ -48,7 +48,7 @@ def test_no_vnc_change_password(self):
         self.assertEqual(set_password_response['error']['class'],
                          'GenericError')
         self.assertEqual(set_password_response['error']['desc'],
-                         'Could not set password')
+                         'No VNC display is present');
 
     def launch_guarded(self):
         try:
@@ -73,7 +73,7 @@ def test_change_password_requires_a_password(self):
         self.assertEqual(set_password_response['error']['class'],
                          'GenericError')
         self.assertEqual(set_password_response['error']['desc'],
-                         'Could not set password')
+                         'VNC password authentication is disabled')
 
     def test_change_password(self):
         self.set_machine('none')
diff --git a/ui/spice-core.c b/ui/spice-core.c
index 8a6050f4ae..cdcec34f67 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -756,7 +756,7 @@ static void qemu_spice_init(void)
                              tls_ciphers);
     }
     if (password) {
-        qemu_spice.set_passwd(password, false, false);
+        qemu_spice.set_passwd(password, false, false, NULL);
     }
     if (qemu_opt_get_bool(opts, "sasl", 0)) {
         if (spice_server_set_sasl(spice_server, 1) == -1) {
@@ -919,8 +919,10 @@ int qemu_spice_add_display_interface(QXLInstance *qxlin, QemuConsole *con)
     return qemu_spice_add_interface(&qxlin->base);
 }
 
-static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_conn)
+static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_conn,
+                                 Error **errp)
 {
+    int ret;
     time_t lifetime, now = time(NULL);
     char *passwd;
 
@@ -934,26 +936,35 @@ static int qemu_spice_set_ticket(bool fail_if_conn, bool disconnect_if_conn)
         passwd = NULL;
         lifetime = 1;
     }
-    return spice_server_set_ticket(spice_server, passwd, lifetime,
-                                   fail_if_conn, disconnect_if_conn);
+    ret = spice_server_set_ticket(spice_server, passwd, lifetime,
+                                  fail_if_conn, disconnect_if_conn);
+    if (ret < 0) {
+        error_setg(errp, "Unable to set SPICE server ticket");
+        return -1;
+    }
+    return 0;
 }
 
 static int qemu_spice_set_passwd(const char *passwd,
-                                 bool fail_if_conn, bool disconnect_if_conn)
+                                 bool fail_if_conn, bool disconnect_if_conn,
+                                 Error **errp)
 {
     if (strcmp(auth, "spice") != 0) {
+        error_setg(errp, "SPICE authentication is disabled");
+        error_append_hint(errp,
+                          "To enable it use '-spice ...,password-secret=ID'");
         return -1;
     }
 
     g_free(auth_passwd);
     auth_passwd = g_strdup(passwd);
-    return qemu_spice_set_ticket(fail_if_conn, disconnect_if_conn);
+    return qemu_spice_set_ticket(fail_if_conn, disconnect_if_conn, errp);
 }
 
 static int qemu_spice_set_pw_expire(time_t expires)
 {
     auth_expires = expires;
-    return qemu_spice_set_ticket(false, false);
+    return qemu_spice_set_ticket(false, false, NULL);
 }
 
 static int qemu_spice_display_add_client(int csock, int skipauth, int tls)
diff --git a/ui/spice-module.c b/ui/spice-module.c
index 3222335872..7651c85885 100644
--- a/ui/spice-module.c
+++ b/ui/spice-module.c
@@ -45,14 +45,15 @@ static int qemu_spice_migrate_info_stub(const char *h, int p, int t,
 
 static int qemu_spice_set_passwd_stub(const char *passwd,
                                       bool fail_if_connected,
-                                      bool disconnect_if_connected)
+                                      bool disconnect_if_connected,
+                                      Error **errp)
 {
-    return -1;
+    g_assert_not_reached();
 }
 
 static int qemu_spice_set_pw_expire_stub(time_t expires)
 {
-    return -1;
+    g_assert_not_reached();
 }
 
 static int qemu_spice_display_add_client_stub(int csock, int skipauth,
diff --git a/ui/ui-qmp-cmds.c b/ui/ui-qmp-cmds.c
index b49b636152..1173c82cf7 100644
--- a/ui/ui-qmp-cmds.c
+++ b/ui/ui-qmp-cmds.c
@@ -31,15 +31,14 @@
 
 void qmp_set_password(SetPasswordOptions *opts, Error **errp)
 {
-    int rc;
-
     if (opts->protocol == DISPLAY_PROTOCOL_SPICE) {
         if (!qemu_using_spice(errp)) {
             return;
         }
-        rc = qemu_spice.set_passwd(opts->password,
-                opts->connected == SET_PASSWORD_ACTION_FAIL,
-                opts->connected == SET_PASSWORD_ACTION_DISCONNECT);
+        qemu_spice.set_passwd(opts->password,
+                              opts->connected == SET_PASSWORD_ACTION_FAIL,
+                              opts->connected == SET_PASSWORD_ACTION_DISCONNECT,
+                              errp);
     } else {
         assert(opts->protocol == DISPLAY_PROTOCOL_VNC);
         if (opts->connected != SET_PASSWORD_ACTION_KEEP) {
@@ -52,11 +51,7 @@ void qmp_set_password(SetPasswordOptions *opts, Error **errp)
          * Note that setting an empty password will not disable login
          * through this interface.
          */
-        rc = vnc_display_password(opts->u.vnc.display, opts->password);
-    }
-
-    if (rc != 0) {
-        error_setg(errp, "Could not set password");
+        vnc_display_password(opts->u.vnc.display, opts->password, errp);
     }
 }
 
@@ -107,9 +102,7 @@ void qmp_expire_password(ExpirePasswordOptions *opts, Error **errp)
 #ifdef CONFIG_VNC
 void qmp_change_vnc_password(const char *password, Error **errp)
 {
-    if (vnc_display_password(NULL, password) < 0) {
-        error_setg(errp, "Could not set password");
-    }
+    vnc_display_password(NULL, password, errp);
 }
 #endif
 
diff --git a/ui/vnc-stubs.c b/ui/vnc-stubs.c
index a96bc86236..5de9bf9d70 100644
--- a/ui/vnc-stubs.c
+++ b/ui/vnc-stubs.c
@@ -2,11 +2,11 @@
 #include "ui/console.h"
 #include "qapi/error.h"
 
-int vnc_display_password(const char *id, const char *password)
+int vnc_display_password(const char *id, const char *password, Error **errp)
 {
-    return -ENODEV;
+    g_assert_not_reached();
 }
 int vnc_display_pw_expire(const char *id, time_t expires)
 {
-    return -ENODEV;
+    g_assert_not_reached();
 };
diff --git a/ui/vnc.c b/ui/vnc.c
index a61a4f937d..833e0e2e68 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3526,16 +3526,20 @@ static void vnc_display_close(VncDisplay *vd)
 #endif
 }
 
-int vnc_display_password(const char *id, const char *password)
+int vnc_display_password(const char *id, const char *password, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
 
     if (!vd) {
+        error_setg(errp, "No VNC display is present");
+        error_append_hint(errp,
+                          "To enable it, use '-vnc ...'");
         return -EINVAL;
     }
     if (vd->auth == VNC_AUTH_NONE) {
-        error_printf_unless_qmp("If you want use passwords please enable "
-                                "password auth using '-vnc ${dpy},password'.\n");
+        error_setg(errp, "VNC password authentication is disabled");
+        error_append_hint(errp,
+                          "To enable it, use '-vnc ...,password-secret=ID'");
         return -EINVAL;
     }
 
-- 
2.53.0


