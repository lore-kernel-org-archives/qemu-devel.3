Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0BCCD3447
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 17:17:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLlHu-00064j-Fg; Sat, 09 May 2026 13:16:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlHl-0005dz-Sp
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wLlHk-0005GS-2K
 for qemu-devel@nongnu.org; Sat, 09 May 2026 13:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778346974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rSl6Qg2kHxj3sLHlW8PKIqc8zqLChLXQKGoH238Ktd0=;
 b=D6FIx+wh/4/c1iAVgpMFfpqpnMKQEs5nNKLjXU6ZQYNW41Gg84ewY0wYr3GAOit+vSuKKi
 FCzM6DKakri2alP98MiOIPMnwk/RfgZlkwTZ4fHzP28wpucJRjGkyb7FA7noDgVunykYqt
 VCsPLav51/iJlSlI1bnR738rDV0zH/Q=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-70-E09RaorTORC-FQ_Bs_6Zxg-1; Sat,
 09 May 2026 13:16:13 -0400
X-MC-Unique: E09RaorTORC-FQ_Bs_6Zxg-1
X-Mimecast-MFC-AGG-ID: E09RaorTORC-FQ_Bs_6Zxg_1778346972
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6890318005B8; Sat,  9 May 2026 17:16:12 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57E8918004A3; Sat,  9 May 2026 17:16:10 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 22/33] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
Date: Sat,  9 May 2026 21:13:43 +0400
Message-ID: <20260509171356.1157879-23-marcandre.lureau@redhat.com>
In-Reply-To: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
References: <20260509171356.1157879-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Combine the two-step vnc_display_init()/vnc_display_open() sequence
into a single vnc_display_new() function that returns VncDisplay*.
This simplifies the API by making vnc_display_open() an
internal detail and will allow further code simplification.

vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
Add vnc_display_free() for consistency, and it will be later used.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  2 --
 ui/vnc.h             |  3 ++
 ui/vnc.c             | 79 ++++++++++++++++++--------------------------
 3 files changed, 36 insertions(+), 48 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 7224b8142f3..550a5e08e46 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -438,8 +438,6 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_help(void);
 
 /* vnc.c */
-bool vnc_display_init(const char *id, Error **errp);
-bool vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password, Error **errp);
 int vnc_display_pw_expire(const char *id, time_t expires);
diff --git a/ui/vnc.h b/ui/vnc.h
index 780fd39469f..d2ebb0f7f45 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -549,6 +549,9 @@ enum VncFeatures {
 #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
 #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
 
+VncDisplay *vnc_display_new(const char *id, Error **errp);
+void vnc_display_free(VncDisplay *vd);
+
 /*****************************************************************************
  *
  * Internal APIs
diff --git a/ui/vnc.c b/ui/vnc.c
index 067f534cf08..1c649e7bccf 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3423,17 +3423,15 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
 }
 
-static void vnc_display_free(VncDisplay *vd);
+static bool vnc_display_open(VncDisplay *vd, Error **errp);
 
-bool vnc_display_init(const char *id, Error **errp)
+VncDisplay *vnc_display_new(const char *id, Error **errp)
 {
     VncDisplay *vd;
 
-    if (vnc_display_find(id) != NULL) {
-        return true;
-    }
-    vd = g_malloc0(sizeof(*vd));
+    assert(!vnc_display_find(id));
 
+    vd = g_new0(VncDisplay, 1);
     qemu_mutex_init(&vd->mutex);
     vd->id = g_strdup(id);
     vd->dcl.ops = &dcl_ops;
@@ -3451,7 +3449,7 @@ bool vnc_display_init(const char *id, Error **errp)
 
     if (!vd->kbd_layout) {
         vnc_display_free(vd);
-        return false;
+        return NULL;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -3464,8 +3462,13 @@ bool vnc_display_init(const char *id, Error **errp)
     vd->vmstate_handler_entry = qemu_add_vm_change_state_handler(
         &vmstate_change_handler, vd);
 
+    if (!vnc_display_open(vd, errp)) {
+        vnc_display_free(vd);
+        return NULL;
+    }
+
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
-    return true;
+    return vd;
 }
 
 static void vnc_display_close(VncDisplay *vd)
@@ -3506,7 +3509,7 @@ static void vnc_display_close(VncDisplay *vd)
 #endif
 }
 
-static void vnc_display_free(VncDisplay *vd)
+void vnc_display_free(VncDisplay *vd)
 {
     if (!vd) {
         return;
@@ -3528,7 +3531,6 @@ static void vnc_display_free(VncDisplay *vd)
     g_free(vd);
 }
 
-
 int vnc_display_password(const char *id, const char *password, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
@@ -4071,10 +4073,9 @@ bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp)
     return true;
 }
 
-bool vnc_display_open(const char *id, Error **errp)
+static bool vnc_display_open(VncDisplay *vd, Error **errp)
 {
-    VncDisplay *vd = vnc_display_find(id);
-    QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, id);
+    QemuOpts *opts = qemu_opts_find(&qemu_vnc_opts, vd->id);
     g_autoptr(SocketAddressList) saddr_list = NULL;
     g_autoptr(SocketAddressList) wsaddr_list = NULL;
     const char *share, *device_id;
@@ -4093,26 +4094,23 @@ bool vnc_display_open(const char *id, Error **errp)
     assert(vd);
     assert(opts);
 
-    vnc_display_close(vd);
-
     reverse = qemu_opt_get_bool(opts, "reverse", false);
     if (vnc_display_get_addresses(opts, reverse, &saddr_list, &wsaddr_list,
                                   errp) < 0) {
-        goto fail;
+        return false;
     }
 
-
     passwordSecret = qemu_opt_get(opts, "password-secret");
     if (passwordSecret) {
         if (qemu_opt_get(opts, "password")) {
             error_setg(errp,
                        "'password' flag is redundant with 'password-secret'");
-            goto fail;
+            return false;
         }
         vd->password = qcrypto_secret_lookup_as_utf8(passwordSecret,
                                                      errp);
         if (!vd->password) {
-            goto fail;
+            return false;
         }
         password = true;
     } else {
@@ -4123,7 +4121,7 @@ bool vnc_display_open(const char *id, Error **errp)
                 QCRYPTO_CIPHER_ALGO_DES, QCRYPTO_CIPHER_MODE_ECB)) {
             error_setg(errp,
                        "Cipher backend does not support DES algorithm");
-            goto fail;
+            return false;
         }
     }
 
@@ -4133,7 +4131,7 @@ bool vnc_display_open(const char *id, Error **errp)
 #ifndef CONFIG_VNC_SASL
     if (sasl) {
         error_setg(errp, "VNC SASL auth requires cyrus-sasl support");
-        goto fail;
+        return false;
     }
 #endif /* CONFIG_VNC_SASL */
     credid = qemu_opt_get(opts, "tls-creds");
@@ -4144,7 +4142,7 @@ bool vnc_display_open(const char *id, Error **errp)
         if (!creds) {
             error_setg(errp, "No TLS credentials with id '%s'",
                        credid);
-            goto fail;
+            return false;
         }
         vd->tlscreds = (QCryptoTLSCreds *)
             object_dynamic_cast(creds,
@@ -4152,26 +4150,26 @@ bool vnc_display_open(const char *id, Error **errp)
         if (!vd->tlscreds) {
             error_setg(errp, "Object with id '%s' is not TLS credentials",
                        credid);
-            goto fail;
+            return false;
         }
         object_ref(OBJECT(vd->tlscreds));
 
         if (!qcrypto_tls_creds_check_endpoint(vd->tlscreds,
                                               QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
                                               errp)) {
-            goto fail;
+            return false;
         }
     }
     tlsauthz = qemu_opt_get(opts, "tls-authz");
     if (tlsauthz && !vd->tlscreds) {
         error_setg(errp, "'tls-authz' provided but TLS is not enabled");
-        goto fail;
+        return false;
     }
 
     saslauthz = qemu_opt_get(opts, "sasl-authz");
     if (saslauthz && !sasl) {
         error_setg(errp, "'sasl-authz' provided but SASL auth is not enabled");
-        goto fail;
+        return false;
     }
 
     share = qemu_opt_get(opts, "share");
@@ -4184,7 +4182,7 @@ bool vnc_display_open(const char *id, Error **errp)
             vd->share_policy = VNC_SHARE_POLICY_FORCE_SHARED;
         } else {
             error_setg(errp, "unknown vnc share= option");
-            goto fail;
+            return false;
         }
     } else {
         vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -4218,20 +4216,20 @@ bool vnc_display_open(const char *id, Error **errp)
     if (vnc_display_setup_auth(&vd->auth, &vd->subauth,
                                vd->tlscreds, password,
                                sasl, false, errp) < 0) {
-        goto fail;
+        return false;
     }
     trace_vnc_auth_init(vd, 0, vd->auth, vd->subauth);
 
     if (vnc_display_setup_auth(&vd->ws_auth, &vd->ws_subauth,
                                vd->tlscreds, password,
                                sasl, true, errp) < 0) {
-        goto fail;
+        return false;
     }
     trace_vnc_auth_init(vd, 1, vd->ws_auth, vd->ws_subauth);
 
 #ifdef CONFIG_VNC_SASL
     if (sasl && !vnc_sasl_server_init(errp)) {
-        goto fail;
+        return false;
     }
 #endif
     vd->lock_key_sync = lock_key_sync;
@@ -4244,7 +4242,7 @@ bool vnc_display_open(const char *id, Error **errp)
     if (audiodev) {
         vd->audio_be = audio_be_by_name(audiodev, errp);
         if (!vd->audio_be) {
-            goto fail;
+            return false;
         }
     } else {
         vd->audio_be = audio_get_default_audio_be(NULL);
@@ -4258,7 +4256,7 @@ bool vnc_display_open(const char *id, Error **errp)
         con = qemu_console_lookup_by_device_name(device_id, head, &err);
         if (err) {
             error_propagate(errp, err);
-            goto fail;
+            return false;
         }
     } else {
         con = qemu_console_lookup_default();
@@ -4279,11 +4277,11 @@ bool vnc_display_open(const char *id, Error **errp)
 
     if (reverse) {
         if (vnc_display_connect(vd, saddr_list, wsaddr_list, errp) < 0) {
-            goto fail;
+            return false;
         }
     } else {
         if (vnc_display_listen(vd, saddr_list, wsaddr_list, errp) < 0) {
-            goto fail;
+            return false;
         }
     }
 
@@ -4291,12 +4289,7 @@ bool vnc_display_open(const char *id, Error **errp)
         vnc_display_print_local_addr(vd);
     }
 
-    /* Success */
     return true;
-
-fail:
-    vnc_display_close(vd);
-    return false;
 }
 
 void vnc_display_add_client(const char *id, int csock, bool skipauth)
@@ -4352,13 +4345,7 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
         id = vnc_auto_assign_id(opts);
     }
 
-    if (!vnc_display_init(id, errp)) {
-        return -1;
-    }
-    if (!vnc_display_open(id, errp)) {
-        return -1;
-    }
-    return 0;
+    return vnc_display_new(id, errp) != NULL ? 0 : -1;
 }
 
 static void vnc_register_config(void)
-- 
2.54.0


