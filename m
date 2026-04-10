Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 335EEF45A0A
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:25:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBHSG-0006L8-W1; Fri, 10 Apr 2026 15:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSF-0006Kt-1y
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wBHSD-00029s-CY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 15:23:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775849024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YSrakXYMXwFeSDbn9jY/8QGvj0ZPy2rloyVnNF6g3gY=;
 b=RxlKm8SupcXdKJ+h1NUdoRfSJJVI5fd5CP11Gc8lLnFk7y3UYu51Xtdt3wMQib7Jl5ou6h
 qxuTyg0WCRUTEyN8gpsYhyO4UkPDGjIWmDEfVOPQzlmL6MdzkAm2huDCVq36mAmg3Dng6x
 rySux1NsGLTzICXZy8gngBMRSMiSZak=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-9VIBMDrMPmmqcWcPNJtK_A-1; Fri,
 10 Apr 2026 15:23:43 -0400
X-MC-Unique: 9VIBMDrMPmmqcWcPNJtK_A-1
X-Mimecast-MFC-AGG-ID: 9VIBMDrMPmmqcWcPNJtK_A_1775849022
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B7D71956095
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 19:23:42 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3F75D3000C1E; Fri, 10 Apr 2026 19:23:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 10 Apr 2026 23:19:10 +0400
Subject: [PATCH v2 48/67] ui/vnc: merge vnc_display_init() and
 vnc_display_open()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260410-qemu-vnc-v2-48-231416f76dc3@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
In-Reply-To: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=10141;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=X1RJV0NG/5XqiGMSOYPHs1GAGis6hGBRk8CiPjVZy4w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp2U0W0IAxvLhYM3Lwf0K28h/xSd/djF/rwalk2
 tNw6Itpo5aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCadlNFgAKCRDa6OEJdZac
 5V29D/9sjoUymNWzccKx4Yj3a/gwuS9B5M/xyPTZFmSQQr2keIJySgW584l+WouXJDyKgamOp7e
 KK3XsyARZuxSTIFfCLrqy/Pl4W4+t+zZTn43xBUIqT6ORal0LMjSlZPM4UmEKq+9vRnVH2qXCgu
 aOWct7uIFh4SsMBl/uj2mg3bXDdi5Ek1SkTW5BYGOEkiDWp98TUBmb2Oy6PKu65v/t66d2+gZkS
 tCiYi7+OsIwx3EyZK2URFTD9WNlrpVR8kMyNAc5fz8SayDjkis8v2h7EBEGh26eCqzCXyQMJ/4a
 i/DztyAy9McZn6/v0ONPGBfh4OpG6Wc/Hqf1pKKckDEA7nO4QHibGLHw3je8HSF2+/EwJv7nN99
 O0Q2zmvMqv5BNECMkc87G2crWvwYbozcKaxxNmMd7sJudoPZLpIS+mx2WsZajIOOzciEbMASdqW
 oM44uIiXhEQka6a33KSnE0/uEofwH8ngq129ZqsV2mThdUgg+gqS74ljuIAALz5m3V8fnrfCAJn
 q+KCkQVxkhhpgEme3z1JkF8zuqtll/utZPkc5vZCK2p3Cqj3CrhcMEurY4U5d8GX+5CoMA7QBpe
 AFpjiIrs1Tp3WomwCnMLD6lMaHd+oRcVPQG38XUg+EGQEYaRxLHsYfLYim8MNmq5W9KIxTcw92i
 LI2E+QA8iCZp3tA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Combine the two-step vnc_display_init()/vnc_display_open() sequence
into a single vnc_display_new() function that returns VncDisplay*.
This simplifies the API by making vnc_display_open() an
internal detail and will allow further code simplification.

vnc_display_new() is moved to vnc.h, since it returns VncDisplay* now.
Add vnc_display_free() for consistency, and it will be later used.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  2 --
 ui/vnc.h             |  3 +++
 ui/vnc.c             | 75 ++++++++++++++++++++++------------------------------
 3 files changed, 35 insertions(+), 45 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index f9b4665cb90..1794f1a2cf0 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -448,8 +448,6 @@ const char *qemu_display_get_vc(DisplayOptions *opts);
 void qemu_display_help(void);
 
 /* vnc.c */
-bool vnc_display_init(const char *id, Error **errp);
-bool vnc_display_open(const char *id, Error **errp);
 void vnc_display_add_client(const char *id, int csock, bool skipauth);
 int vnc_display_password(const char *id, const char *password, Error **errp);
 int vnc_display_pw_expire(const char *id, time_t expires);
diff --git a/ui/vnc.h b/ui/vnc.h
index 9a09fcdad8b..de41517be48 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -550,6 +550,9 @@ enum VncFeatures {
 #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
 #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
 
+VncDisplay *vnc_display_new(const char *id, Error **errp);
+void vnc_display_free(VncDisplay *vd);
+
 /*****************************************************************************
  *
  * Internal APIs
diff --git a/ui/vnc.c b/ui/vnc.c
index 0775417c418..4d5b36a6fa8 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3423,14 +3423,14 @@ static void vmstate_change_handler(void *opaque, bool running, RunState state)
     update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
 }
 
-static void vnc_display_free(VncDisplay *vd);
+static bool vnc_display_open(VncDisplay *vd, Error **errp);
 
-bool vnc_display_init(const char *id, Error **errp)
+VncDisplay *vnc_display_new(const char *id, Error **errp)
 {
     VncDisplay *vd;
 
     if (vnc_display_find(id) != NULL) {
-        return true;
+        return NULL;
     }
     vd = g_malloc0(sizeof(*vd));
 
@@ -3451,7 +3451,7 @@ bool vnc_display_init(const char *id, Error **errp)
 
     if (!vd->kbd_layout) {
         vnc_display_free(vd);
-        return false;
+        return NULL;
     }
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -3464,8 +3464,13 @@ bool vnc_display_init(const char *id, Error **errp)
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
@@ -3510,7 +3515,7 @@ static void vnc_display_close(VncDisplay *vd)
 #endif
 }
 
-static void vnc_display_free(VncDisplay *vd)
+void vnc_display_free(VncDisplay *vd)
 {
     if (!vd) {
         return;
@@ -3532,7 +3537,6 @@ static void vnc_display_free(VncDisplay *vd)
     g_free(vd);
 }
 
-
 int vnc_display_password(const char *id, const char *password, Error **errp)
 {
     VncDisplay *vd = vnc_display_find(id);
@@ -4075,10 +4079,9 @@ bool vnc_display_update(DisplayUpdateOptionsVNC *arg, Error **errp)
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
@@ -4097,26 +4100,23 @@ bool vnc_display_open(const char *id, Error **errp)
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
@@ -4127,7 +4127,7 @@ bool vnc_display_open(const char *id, Error **errp)
                 QCRYPTO_CIPHER_ALGO_DES, QCRYPTO_CIPHER_MODE_ECB)) {
             error_setg(errp,
                        "Cipher backend does not support DES algorithm");
-            goto fail;
+            return false;
         }
     }
 
@@ -4137,7 +4137,7 @@ bool vnc_display_open(const char *id, Error **errp)
 #ifndef CONFIG_VNC_SASL
     if (sasl) {
         error_setg(errp, "VNC SASL auth requires cyrus-sasl support");
-        goto fail;
+        return false;
     }
 #endif /* CONFIG_VNC_SASL */
     credid = qemu_opt_get(opts, "tls-creds");
@@ -4148,7 +4148,7 @@ bool vnc_display_open(const char *id, Error **errp)
         if (!creds) {
             error_setg(errp, "No TLS credentials with id '%s'",
                        credid);
-            goto fail;
+            return false;
         }
         vd->tlscreds = (QCryptoTLSCreds *)
             object_dynamic_cast(creds,
@@ -4156,26 +4156,26 @@ bool vnc_display_open(const char *id, Error **errp)
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
@@ -4188,7 +4188,7 @@ bool vnc_display_open(const char *id, Error **errp)
             vd->share_policy = VNC_SHARE_POLICY_FORCE_SHARED;
         } else {
             error_setg(errp, "unknown vnc share= option");
-            goto fail;
+            return false;
         }
     } else {
         vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
@@ -4222,20 +4222,20 @@ bool vnc_display_open(const char *id, Error **errp)
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
@@ -4248,7 +4248,7 @@ bool vnc_display_open(const char *id, Error **errp)
     if (audiodev) {
         vd->audio_be = audio_be_by_name(audiodev, errp);
         if (!vd->audio_be) {
-            goto fail;
+            return false;
         }
     } else {
         vd->audio_be = audio_get_default_audio_be(NULL);
@@ -4262,7 +4262,7 @@ bool vnc_display_open(const char *id, Error **errp)
         con = qemu_console_lookup_by_device_name(device_id, head, &err);
         if (err) {
             error_propagate(errp, err);
-            goto fail;
+            return false;
         }
     } else {
         con = qemu_console_lookup_default();
@@ -4283,11 +4283,11 @@ bool vnc_display_open(const char *id, Error **errp)
 
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
 
@@ -4295,12 +4295,7 @@ bool vnc_display_open(const char *id, Error **errp)
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
@@ -4356,13 +4351,7 @@ int vnc_init_func(void *opaque, QemuOpts *opts, Error **errp)
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
2.53.0


