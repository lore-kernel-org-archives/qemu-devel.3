Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A9606A325
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 12:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LZYs2+id
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNUL6-0007xE-7P; Sun, 01 Nov 2026 07:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUL0-0007wH-AQ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xNUKy-0003Yk-7u
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 07:07:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793534819;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KKZNkPurnsixgCG+iI2UK2v8YyNheyZcp5HjsaqDYT0=;
 b=LZYs2+idtLxE1gHq2howLvK4bAfbkdMAiUoi5YjgsKzZr7DM8QZYOb4OGcaZ/Ba2so6BWp
 ec5IaZ5//zAbBc+9gh9KiGLPa6+QqlfMt2G3o1qfVzBlDBPxqUc1xkEgEqB60i/bHAgqoE
 PrlPK5+scL6KtQUvvxlb3G9V1b8vjwE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-592-Uf_ZPot1MAS3lqMjIRrRzw-1; Sun,
 01 Nov 2026 07:06:58 -0500
X-MC-Unique: Uf_ZPot1MAS3lqMjIRrRzw-1
X-Mimecast-MFC-AGG-ID: Uf_ZPot1MAS3lqMjIRrRzw_1793534817
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2513518001FB; Sun,  1 Nov 2026 12:06:57 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 100DF767; Sun,  1 Nov 2026 12:06:55 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 01 Nov 2026 16:06:37 +0400
Subject: [GIT PULL 4/9] ui/vnc: notify client of clipboard availability
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261101-ui-v1-4-8af305cef69a@redhat.com>
References: <20261101-ui-v1-0-8af305cef69a@redhat.com>
In-Reply-To: <20261101-ui-v1-0-8af305cef69a@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8680;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=jv6PBu2liTwOEjymAnq22f7sojFCFZ4gjZ3BesuAWPM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq5ytOz71kvSZNXL4DeNME/mpGFSlkYfOhCnBi4
 rhikMgn9Y2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaucrTgAKCRDa6OEJdZac
 5bPtEACbcIaXLEbP5s85GMljiWM+8aXCXWWSKNMQouzyqESUkZXllSQPH2EU1fLJ55g4Yt4aUrw
 luTmcTm5oM7H1waBvfl/B9Yu1m+g/27oBstctJeZHcQh6obpQNNMMjPLbghjaAtBKTvxtnQHWKI
 ae03q7Ur5RlyY26vIy22F88KeBWeIUPWB6akOyCi+UpV7GTrRWfCZmU0eKT8gFAEUl+XYrj7bO2
 o0nScz8DEgBXTuifpjcE7cVK1TBAN4a+CgtBKmKyfRERONN2YlaMMgLkoj1Ca4GV+98M1bBWD04
 O6unHPsm7j+ZtXLyyHe56W6c9Oz20apWx9JrVKv72XnwCawf+zlFddoZXOtoBp/WQAsWII0UeIj
 i/0KjB95hgyzjcRpGK9x9KQmWRBjH/ArUY/6bFTM/XY8cCL24Lp8VBw0Qy7O7COhdq8nMi62ijI
 M5ZCuyVUdSrKJT8idFWBoTUKolktfOzvN3BSZ2VtKE44BEcIAHFPWXjkvGZApTG7cg1eJvvSOxf
 c2Wt3HhbUuDZa0voGFmab1H2/xZeTIPbyM52IsnpcUm3lLB6jT3QICyxAR6X/0jlpEXAQF0wIWh
 lIzKUxVXaqBCJND6l81PsyCr7dOoyxuVFbQukpZV3v8YquAafog0H2SLwz+lLD3djk5+NyZmBje
 YMyPm2MpdGior3Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lukasz Kornicki <lucas.kornicki@nutanix.com>

Adds support for vnc ClipboardAvailability pseudo-encoding.

When a client requests this feature, the server will inform the client
whether a guest clipboard peer is present. The server will repeat the
notification each time availability of a guest clipboard peer changes.

This change enables the VNC client to determine if a guest side
clipboard peer is available for clipboard exchange and react to
changes of its availability.

Until now the VNC clipboard peer was only registered when
VNC_FEATURE_CLIPBOARD_EXT was enabled. With this change the VNC peer
can be registered just for the purpose of receiving peer status
updates. This requires introducing a VNC_FEATURE_CLIPBOARD_EXT guard
before the QEMU_CLIPBOARD_UPDATE_INFO handler which previously only ran
if VNC_FEATURE_CLIPBOARD_EXT was enabled.

Signed-off-by: Lukasz Kornicki <lucas.kornicki@nutanix.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261030141442.264308-5-lucas.kornicki@nutanix.com>
---
 tools/qemu-vnc/qemu-vnc.c |  7 ++++++-
 ui/trace-events           |  1 +
 ui/vnc-clipboard.c        | 34 +++++++++++++++++++++++++++++++++-
 ui/vnc.c                  |  9 +++++++++
 ui/vnc.h                  |  8 ++++++++
 5 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/tools/qemu-vnc/qemu-vnc.c b/tools/qemu-vnc/qemu-vnc.c
index 5c2ba3b7a564..c915589ca7e1 100644
--- a/tools/qemu-vnc/qemu-vnc.c
+++ b/tools/qemu-vnc/qemu-vnc.c
@@ -95,6 +95,7 @@ on_manager_ready(GObject *source_object,
     g_autoptr(GPtrArray) console_paths = NULL;
     bool found = false;
     Error *local_err = NULL;
+    VncDisplay *vd;
 
     manager = G_DBUS_OBJECT_MANAGER(
         g_dbus_object_manager_client_new_finish(res, &err));
@@ -145,13 +146,17 @@ on_manager_ready(GObject *source_object,
      * Create the VNC display now that consoles exist, so that the
      * display change listener is registered against a valid console.
      */
-    if (!vnc_display_new("default", &local_err)) {
+    vd = vnc_display_new("default", &local_err);
+    if (!vd) {
         error_report("Failed to create VNC display: %s",
                      error_get_pretty(local_err));
         g_assert_not_reached();
         return;
     }
 
+    /* guest clipboard peer presence is not exposed over D-Bus */
+    vd->clipboard_availability = false;
+
     vnc_dbus_setup(state->bus);
 
     clipboard_setup(manager, state->bus);
diff --git a/ui/trace-events b/ui/trace-events
index 917d116d90e1..f5f82c75db0b 100644
--- a/ui/trace-events
+++ b/ui/trace-events
@@ -45,6 +45,7 @@ vnc_msg_server_audio_end(void *state, void *ioc) "VNC server msg audio end state
 vnc_msg_server_audio_data(void *state, void *ioc, const void *buf, size_t len) "VNC server msg audio data state=%p ioc=%p buf=%p len=%zd"
 vnc_msg_server_desktop_resize(void *state, void *ioc, int width, int height) "VNC server msg ext resize state=%p ioc=%p size=%dx%d"
 vnc_msg_server_ext_desktop_resize(void *state, void *ioc, int width, int height, int reason) "VNC server msg ext resize state=%p ioc=%p size=%dx%d reason=%d"
+vnc_msg_server_clipboard_availability(void *state, void *ioc, bool available) "VNC server msg clipboard availability state=%p ioc=%p available=%d"
 vnc_msg_client_audio_enable(void *state, void *ioc) "VNC client msg audio enable state=%p ioc=%p"
 vnc_msg_client_audio_disable(void *state, void *ioc) "VNC client msg audio disable state=%p ioc=%p"
 vnc_msg_client_audio_format(void *state, void *ioc, int fmt, int channels, int freq) "VNC client msg audio format state=%p ioc=%p fmt=%d channels=%d freq=%d"
diff --git a/ui/vnc-clipboard.c b/ui/vnc-clipboard.c
index 67f710f6ed80..7c5bd94cb62d 100644
--- a/ui/vnc-clipboard.c
+++ b/ui/vnc-clipboard.c
@@ -26,6 +26,7 @@
 #include "qemu/error-report.h"
 #include "vnc.h"
 #include "vnc-jobs.h"
+#include "trace.h"
 
 static uint8_t *inflate_buffer(uint8_t *in, uint32_t in_len, uint32_t *size)
 {
@@ -224,6 +225,26 @@ static void vnc_clipboard_update_info(VncState *vs, QemuClipboardInfo *info)
     }
 }
 
+void vnc_clipboard_availability_send(VncState *vs, bool available)
+{
+    if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_AVAILABILITY)) {
+        return;
+    }
+
+    trace_vnc_msg_server_clipboard_availability(vs, vs->ioc, available);
+
+    vnc_lock_output(vs);
+    vnc_write_u8(vs, VNC_MSG_SERVER_FRAMEBUFFER_UPDATE);
+    vnc_write_u8(vs, 0);
+    vnc_write_u16(vs, 1);
+    vnc_framebuffer_update(vs, 0, 0, 0, 0,
+                           VNC_ENCODING_CLIPBOARD_AVAILABILITY);
+    vnc_write_u8(vs, available ? VNC_CLIPBOARD_AVAILABLE
+                               : VNC_CLIPBOARD_UNAVAILABLE);
+    vnc_unlock_output(vs);
+    vnc_flush(vs);
+}
+
 static void vnc_clipboard_notify(Notifier *notifier, void *data)
 {
     VncState *vs = container_of(notifier, VncState, cbpeer.notifier);
@@ -231,13 +252,24 @@ static void vnc_clipboard_notify(Notifier *notifier, void *data)
 
     switch (notify->type) {
     case QEMU_CLIPBOARD_UPDATE_INFO:
+        /* ignore the update if client does not want ext messages */
+        if (!vnc_has_feature(vs, VNC_FEATURE_CLIPBOARD_EXT)) {
+            return;
+        }
+
         vnc_clipboard_update_info(vs, notify->info);
         return;
     case QEMU_CLIPBOARD_RESET_SERIAL:
         /* ignore */
         return;
     case QEMU_CLIPBOARD_PEER_UPDATE:
-        /* ignore */
+        /* only guest side peers affect the status we relay to the client */
+        if (!notify->peer_update.peer->guest) {
+            return;
+        }
+
+        vnc_clipboard_availability_send(vs,
+            qemu_clipboard_guest_peer_present());
         return;
     }
 }
diff --git a/ui/vnc.c b/ui/vnc.c
index 656768f9c998..8b1d03ef2434 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -2191,6 +2191,14 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_EXT);
             vnc_server_cut_text_caps(vs);
             break;
+        case VNC_ENCODING_CLIPBOARD_AVAILABILITY:
+            if (vs->vd->clipboard_availability) {
+                vnc_set_feature(vs, VNC_FEATURE_CLIPBOARD_AVAILABILITY);
+                vnc_clipboard_peer_register(vs);
+                vnc_clipboard_availability_send(vs,
+                    qemu_clipboard_guest_peer_present());
+            }
+            break;
         case VNC_ENCODING_COMPRESSLEVEL0 ... VNC_ENCODING_COMPRESSLEVEL0 + 9:
             vc->worker.tight.compression = (enc & 0x0F);
             break;
@@ -3459,6 +3467,7 @@ VncDisplay *vnc_display_new(const char *id, Error **errp)
 
     vd->share_policy = VNC_SHARE_POLICY_ALLOW_EXCLUSIVE;
     vd->connections_limit = 32;
+    vd->clipboard_availability = true;
 
     vnc_start_worker_thread(vd);
 
diff --git a/ui/vnc.h b/ui/vnc.h
index d8b0070396dc..8eae550c96d6 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -171,6 +171,7 @@ struct VncDisplay
     bool lossy;
     bool non_adaptive;
     bool power_control;
+    bool clipboard_availability;
     QCryptoTLSCreds *tlscreds;
     char *tlsauthzid;
 #ifdef CONFIG_VNC_SASL
@@ -422,6 +423,7 @@ enum {
 #define VNC_ENCODING_DESKTOP_RESIZE_EXT   0XFFFFFECC /* -308 */
 #define VNC_ENCODING_XVP                  0XFFFFFECB /* -309 */
 #define VNC_ENCODING_ALPHA_CURSOR         0XFFFFFEC6 /* -314 */
+#define VNC_ENCODING_CLIPBOARD_AVAILABILITY  0XFFFFFEC2 /* -318 */
 #define VNC_ENCODING_WMVi                 0x574D5669
 #define VNC_ENCODING_CLIPBOARD_EXT        0xc0a1e5ce
 
@@ -466,6 +468,7 @@ enum VncFeatures {
     VNC_FEATURE_LED_STATE,
     VNC_FEATURE_XVP,
     VNC_FEATURE_CLIPBOARD_EXT,
+    VNC_FEATURE_CLIPBOARD_AVAILABILITY,
     VNC_FEATURE_AUDIO,
 };
 
@@ -541,6 +544,10 @@ enum VncFeatures {
 #define VNC_CLIPBOARD_NOTIFY   (1 << 27)
 #define VNC_CLIPBOARD_PROVIDE  (1 << 28)
 
+/* ClipboardAvailability pseudo-encoding values */
+#define VNC_CLIPBOARD_UNAVAILABLE  0
+#define VNC_CLIPBOARD_AVAILABLE    1
+
 VncDisplay *vnc_display_new(const char *id, Error **errp);
 void vnc_display_free(VncDisplay *vd);
 
@@ -637,6 +644,7 @@ void vnc_zrle_clear(VncWorker *worker);
 
 /* vnc-clipboard.c */
 void vnc_clipboard_peer_register(VncState *vs);
+void vnc_clipboard_availability_send(VncState *vs, bool available);
 void vnc_server_cut_text_caps(VncState *vs);
 void vnc_client_cut_text(VncState *vs, size_t len, uint8_t *text);
 void vnc_client_cut_text_ext(VncState *vs, int32_t len, uint32_t flags, uint8_t *data);

-- 
2.56.0.116.g6de20f6092dc


