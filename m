Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87C17E83855
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 05:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsDcs-0002cb-5k; Tue, 17 Feb 2026 00:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDcm-0002ac-Pj
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heifetz@yandex-team.com>)
 id 1vsDci-0006cE-Ok
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 00:27:52 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 75B6E8078A;
 Tue, 17 Feb 2026 08:27:44 +0300 (MSK)
Received: from heifetz-lin.yandex-team.ru (unknown [2a02:6bf:8080:b54::1:2f])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (smtpcorp/Yandex) with ESMTPSA id eRRjrX2Ak0U0-khrc0VDj; 
 Tue, 17 Feb 2026 08:27:43 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.com;
 s=default; t=1771306064;
 bh=fYgqFZ4oPOcspu6TbeYRGEKZTYe+Bf86zf84nP7o7zQ=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=hAcY0duxyb4wFoqatHaIJG+Xch4pm0lnEhfTU5NxDt4oL7/EM0vYjVPLcSEEFJczF
 guUouZLXmU9eHT2UpOuIbF1CItnmq90VEwRt3N/4EHihwUvNU7HkQ6kBVlxDCpogAD
 QdS8d1SSxfn7Cqi/vzT7S35QAfj/q6snr0mczHYU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.com
From: Sergei Heifetz <heifetz@yandex-team.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Subject: [PATCH 2/8] ui/vnc: disable audio feature when configured with
 --disable-audio
Date: Tue, 17 Feb 2026 10:27:34 +0500
Message-Id: <20260217052740.114117-3-heifetz@yandex-team.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260217052740.114117-1-heifetz@yandex-team.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=heifetz@yandex-team.com; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
---
 ui/vnc.c | 31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index a61a4f937d..8212d3ce81 100644
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
-    uint32_t freq;
+    #ifdef CONFIG_AUDIO
+        uint32_t freq;
+    #endif
     VncDisplay *vd = vs->vd;
 
     if (data[0] > 3) {
@@ -2571,7 +2586,9 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 vnc_client_error(vs);
                 break;
             }
-
+#ifndef CONFIG_AUDIO
+            abort();
+#else
             if (len == 2)
                 return 4;
 
@@ -2626,7 +2643,7 @@ static int protocol_client_msg(VncState *vs, uint8_t *data, size_t len)
                 break;
             }
             break;
-
+#endif
         default:
             VNC_DEBUG("Msg: %d\n", read_u16(data, 0));
             vnc_client_error(vs);
@@ -3369,10 +3386,12 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
     vs->last_x = -1;
     vs->last_y = -1;
 
+#ifdef CONFIG_AUDIO
     vs->as.freq = 44100;
     vs->as.nchannels = 2;
     vs->as.fmt = AUDIO_FORMAT_S16;
     vs->as.endianness = 0;
+#endif
 
     qemu_mutex_init(&vs->output_mutex);
     vs->bh = qemu_bh_new(vnc_jobs_bh, vs);
@@ -3645,9 +3664,11 @@ static QemuOptsList qemu_vnc_opts = {
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
@@ -4080,7 +4101,9 @@ void vnc_display_open(const char *id, Error **errp)
     const char *saslauthz;
     int lock_key_sync = 1;
     int key_delay_ms;
+#ifdef CONFIG_AUDIO
     const char *audiodev;
+#endif
     const char *passwordSecret;
 
     if (!vd) {
@@ -4238,6 +4261,7 @@ void vnc_display_open(const char *id, Error **errp)
     }
     vd->ledstate = 0;
 
+#ifdef CONFIG_AUDIO
     audiodev = qemu_opt_get(opts, "audiodev");
     if (audiodev) {
         vd->audio_be = audio_be_by_name(audiodev, errp);
@@ -4247,6 +4271,7 @@ void vnc_display_open(const char *id, Error **errp)
     } else {
         vd->audio_be = audio_get_default_audio_be(NULL);
     }
+#endif
 
     device_id = qemu_opt_get(opts, "display");
     if (device_id) {
-- 
2.34.1


