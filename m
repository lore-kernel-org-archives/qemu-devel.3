Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16CF3F3026E
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2026 20:18:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w1ruC-0006Lg-3t; Sun, 15 Mar 2026 16:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rty-0006Kc-3C
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:31 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1w1rtS-0002LJ-Qu
 for qemu-devel@nongnu.org; Sun, 15 Mar 2026 16:17:02 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 4FDC2C015C;
 Sun, 15 Mar 2026 23:16:54 +0300 (MSK)
Received: from localhost (unknown [2a02:6bf:8080:b49::1:d])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id pGRLE71AgKo0-yXl5N0r4; Sun, 15 Mar 2026 23:16:53 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1773605813;
 bh=gR/N2gXkosXfX3Wxj7U9nweNWgA7ppbfRxk8S6VfUJw=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=quTIWC1l7zx+S8Cc9JtcMs+ImeL3ju6kALHVko2rK2MbqVZJsW2CVYdRd4AYWM9gV
 NBom3z3/W/YB2L6jBthbddAHXMd6A9Sq07HrjwjzpNwgIgB1uKjUYHP8x6hiJCxnuD
 bwA3VZy4FJSzpPz24i/OZD5mAL5PtG+DNheu/fQ0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Sergei Heifetz <heifetz@yandex-team.com>
Subject: [PATCH v3 02/11] ui/vnc: disable audio feature when configured with
 --disable-audio
Date: Mon, 16 Mar 2026 01:16:37 +0500
Message-Id: <20260315201646.96862-3-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315201646.96862-1-heifetz@yandex-team.com>
References: <20260315201646.96862-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Disable the audio feature in VNC when QEMU is configured with
`--disable-audio`. Do not compile the corresponding audio-related
code.

The audio feature is disabled in a way that makes a QEMU server behave
like a non-QEMU server (as far as audio is concerned). The client sends
the audio pseudo-encoding, but the server does not respond with
confirmation, because send_ext_audio_ack is now behind an #ifdef.
A well-behaved client should handle this accordingly and continue
using VNC without sending any audio-related messages to the server.
If a client misbehaves and sends VNC_MSG_CLIENT_QEMU_AUDIO while
the audio feature is disabled, the server will close the connection with
an error.

The behaviour described above is already present when there is no audiodev
(`vs->vd->audio_be` is NULL).

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 qemu-options.hx |  3 +++
 ui/vnc.c        | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 890c4f1d230..04ea2239296 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2723,6 +2723,9 @@ SRST
         must be omitted, otherwise is must be present and specify a
         valid audiodev.
 
+        If QEMU is configured with ``--disable-audio``, this parameter
+        is not present and audio is not transmitted over VNC.
+
     ``power-control=on|off``
         Permit the remote client to issue shutdown, reboot or reset power
         control requests.
diff --git a/ui/vnc.c b/ui/vnc.c
index 952976e9649..0ee5502d1e6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1072,6 +1072,7 @@ static void vnc_update_throttle_offset(VncState *vs)
     size_t offset =
         vs->client_width * vs->client_height * vs->client_pf.bytes_per_pixel;
 
+#ifdef CONFIG_AUDIO
     if (vs->audio_cap) {
         int bps;
         switch (vs->as.fmt) {
@@ -1091,6 +1092,7 @@ static void vnc_update_throttle_offset(VncState *vs)
         }
         offset += vs->as.freq * bps * vs->as.nchannels;
     }
+#endif
 
     /* Put a floor of 1MB on offset, so that if we have a large pending
      * buffer and the display is resized to a small size & back again
@@ -1214,6 +1216,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
     return n;
 }
 
+#ifdef CONFIG_AUDIO
 /* audio */
 static void audio_capture_notify(void *opaque, audcnotification_e cmd)
 {
@@ -1293,6 +1296,7 @@ static void audio_del(VncState *vs)
         vs->audio_cap = NULL;
     }
 }
+#endif
 
 static void vnc_disconnect_start(VncState *vs)
 {
@@ -1332,7 +1336,9 @@ void vnc_disconnect_finish(VncState *vs)
 #ifdef CONFIG_VNC_SASL
     vnc_sasl_client_cleanup(vs);
 #endif /* CONFIG_VNC_SASL */
+#ifdef CONFIG_AUDIO
     audio_del(vs);
+#endif
     qkbd_state_lift_all_keys(vs->vd->kbd);
 
     if (vs->mouse_mode_notifier.notify != NULL) {
@@ -2097,6 +2103,7 @@ static void send_ext_key_event_ack(VncState *vs)
     vnc_flush(vs);
 }
 
+#ifdef CONFIG_AUDIO
 static void send_ext_audio_ack(VncState *vs)
 {
     vnc_lock_output(vs);
@@ -2110,6 +2117,7 @@ static void send_ext_audio_ack(VncState *vs)
     vnc_unlock_output(vs);
     vnc_flush(vs);
 }
+#endif
 
 static void send_xvp_message(VncState *vs, int code)
 {
@@ -2197,10 +2205,15 @@ static void set_encodings(VncState *vs, int32_t *encodings, size_t n_encodings)
             send_ext_key_event_ack(vs);
             break;
         case VNC_ENCODING_AUDIO:
+#ifdef CONFIG_AUDIO
             if (vs->vd->audio_be) {
                 vnc_set_feature(vs, VNC_FEATURE_AUDIO);
                 send_ext_audio_ack(vs);
             }
+#else
+            VNC_DEBUG("Audio encoding received with audio subsystem "
+                      "disabled\n");
+#endif
             break;
         case VNC_ENCODING_WMVi:
             vnc_set_feature(vs, VNC_FEATURE_WMVI);
@@ -2394,7 +2407,9 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
 {
     int i;
     uint16_t limit;
+#ifdef CONFIG_AUDIO
     uint32_t freq;
+#endif
     VncDisplay *vd = vs->vd;
 
     if (data[0] > 3) {
@@ -2572,6 +2587,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 break;
             }
 
+#ifdef CONFIG_AUDIO
             if (len == 2)
                 return 4;
 
@@ -2626,6 +2642,9 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 break;
             }
             break;
+#else
+            abort();
+#endif
 
         default:
             VNC_DEBUG("Msg: %d\n", read_u16(data, 0));
@@ -3369,10 +3388,12 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     vs->last_x = -1;
     vs->last_y = -1;
 
+#ifdef CONFIG_AUDIO
     vs->as.freq = 44100;
     vs->as.nchannels = 2;
     vs->as.fmt = AUDIO_FORMAT_S16;
     vs->as.big_endian = false;
+#endif
 
     qemu_mutex_init(&vs->output_mutex);
     vs->bh = qemu_bh_new(vnc_jobs_bh, vs);
@@ -3649,9 +3670,11 @@ static QemuOptsList qemu_vnc_opts = {
         },{
             .name = "non-adaptive",
             .type = QEMU_OPT_BOOL,
+#ifdef CONFIG_AUDIO
         },{
             .name = "audiodev",
             .type = QEMU_OPT_STRING,
+#endif
         },{
             .name = "power-control",
             .type = QEMU_OPT_BOOL,
@@ -4084,7 +4107,9 @@ void vnc_display_open(const char *id, Error **errp)
     const char *saslauthz;
     int lock_key_sync = 1;
     int key_delay_ms;
+#ifdef CONFIG_AUDIO
     const char *audiodev;
+#endif
     const char *passwordSecret;
 
     if (!vd) {
@@ -4242,6 +4267,7 @@ void vnc_display_open(const char *id, Error **errp)
     }
     vd->ledstate = 0;
 
+#ifdef CONFIG_AUDIO
     audiodev = qemu_opt_get(opts, "audiodev");
     if (audiodev) {
         vd->audio_be = audio_be_by_name(audiodev, errp);
@@ -4251,6 +4277,7 @@ void vnc_display_open(const char *id, Error **errp)
     } else {
         vd->audio_be = audio_get_default_audio_be(NULL);
     }
+#endif
 
     device_id = qemu_opt_get(opts, "display");
     if (device_id) {
-- 
2.34.1


