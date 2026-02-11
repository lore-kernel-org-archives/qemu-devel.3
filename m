Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ED7EA8125
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:03:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq73Z-0001UX-DG; Wed, 11 Feb 2026 05:02:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73V-00015A-Rx
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq73U-0002zo-7E
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770804163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O1yPiV6/tD/XRWgMlrMoMoyq+hWEGWK4xROVUU6ku/s=;
 b=YD1IvgrGzvXs6bGViHWizyEqmBI3XVfZA85rdV5VWC+n/84sm/ocPFXihghbB9rmqtZaJs
 kxaB92obrsE3Lf4nZmZ7sHVgpaEJDieYlcfgKlna+61c+uSRDTgM4medY2ChINgL7/DE1l
 XlrUFzoihponB50TDk3bXsuBkVvflzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-hiKoJu7hP_OgXtG0Qrf9tg-1; Wed,
 11 Feb 2026 05:02:40 -0500
X-MC-Unique: hiKoJu7hP_OgXtG0Qrf9tg-1
X-Mimecast-MFC-AGG-ID: hiKoJu7hP_OgXtG0Qrf9tg_1770804159
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43D5A18003F6; Wed, 11 Feb 2026 10:02:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D85601956053; Wed, 11 Feb 2026 10:02:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 11 Feb 2026 14:01:45 +0400
Subject: [PATCH 5/7] audio: require spice >= 0.15
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260211-cleanups-v1-5-e63c96572389@redhat.com>
References: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
In-Reply-To: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=5284;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=u9Xu4eBPvh5df7XfEv+bIF6n0ePy5VZVQtW0TQCzngk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpjFOV0MMlWEqlYTVEyz32xN6cynqy3bpSkWaW7
 hZS+9xOlkyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaYxTlQAKCRDa6OEJdZac
 5Z9eEAC30tXbDmxK1fT1rfU/1ClMbQMg4H0ln6G9J94wLZTzhwjAmSciRFhMD4uZi3IJrJf1HJ6
 F+AVDWSUlJ4+wrNuP824yodxkBRS14YXfj+irFHRhn+bwGSxnMH9QRox6zHeWlC4YWVQ+XAcRKl
 18DaCaIFH5z8uGjLR65UZi3MFqmnyrttZuz++N2VY6D486U2zBoWk6fhdEdYSRt8k+92LevDQ2W
 gwxs65zIl3bR0kS+N8aACHBe6tDsql5aheje7chnvAw/f4kP2Gholw2QNGdMkWEBVGl7q8osPHD
 q8cUyLs7B1EQQ/T8J016tK6UJoBbDgQEsozfMFxmB3IfrF5mvsIHBl/bsrEobQig4L95OGKpSK8
 WV4z2w1UeVSJCqs7nUJmU7pFkhgUgeCIERimMZOEhTDIArYlnkzjhlwb6pwHTxRCUDaFC4NY+1F
 9lMAZtNnAc7MvHLXHK1Nr0Pxc0clnPZzBuAcbO+Q92h28eOVJZGeY494fHQ73zVuV5zBC+vhLsd
 SoLVzhwkRSYlV+kIa1WdhQuVU2AFMwr3l1CL2KNy15ulgKWezVBBLUVopapxQoEJ/oeDjfw8hpK
 oGbrd7nVV/xWfRDBce3y3vhd1aVsVl0y+mXZ1uVnm/zjn/DIRMz+z6QxUA/WBs6m2+XAriQWkKG
 dkM8jN20KIrO3jw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Spice server 0.15.0 was released on 2021-04-16. It is part of all our
supported distro (except CentOS 9, which doesn't include it).

It has all the new required audio APIs/interfaces.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build        |  2 +-
 audio/spiceaudio.c | 30 ------------------------------
 2 files changed, 1 insertion(+), 31 deletions(-)

diff --git a/meson.build b/meson.build
index fb89fbd1cc5..5c3e138309f 100644
--- a/meson.build
+++ b/meson.build
@@ -1320,7 +1320,7 @@ if get_option('spice') \
              .require(pixman.found(),
                       error_message: 'cannot enable SPICE if pixman is not available') \
              .allowed()
-  spice = dependency('spice-server', version: '>=0.14.0',
+  spice = dependency('spice-server', version: '>=0.15.0',
                      required: get_option('spice'),
                      method: 'pkg-config')
 endif
diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index 7db2d1f0dfd..9974e038574 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -29,17 +29,8 @@
 #include "qemu/audio.h"
 #include "audio_int.h"
 
-#if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
 #define LINE_OUT_SAMPLES (480 * 4)
-#else
-#define LINE_OUT_SAMPLES (256 * 4)
-#endif
-
-#if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
 #define LINE_IN_SAMPLES (480 * 4)
-#else
-#define LINE_IN_SAMPLES (256 * 4)
-#endif
 
 typedef struct SpiceVoiceOut {
     HWVoiceOut            hw;
@@ -95,11 +86,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
     SpiceVoiceOut *out = container_of (hw, SpiceVoiceOut, hw);
     struct audsettings settings;
 
-#if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
     settings.freq       = spice_server_get_best_playback_rate(NULL);
-#else
-    settings.freq       = SPICE_INTERFACE_PLAYBACK_FREQ;
-#endif
     settings.nchannels  = SPICE_INTERFACE_PLAYBACK_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
     settings.endianness = HOST_BIG_ENDIAN;
@@ -110,9 +97,7 @@ static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
 
     out->sin.base.sif = &playback_sif.base;
     qemu_spice.add_interface(&out->sin.base);
-#if SPICE_INTERFACE_PLAYBACK_MAJOR > 1 || SPICE_INTERFACE_PLAYBACK_MINOR >= 3
     spice_server_set_playback_rate(&out->sin, settings.freq);
-#endif
     return 0;
 }
 
@@ -190,7 +175,6 @@ static void line_out_enable(HWVoiceOut *hw, bool enable)
     }
 }
 
-#if ((SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && (SPICE_INTERFACE_PLAYBACK_MINOR >= 2))
 static void line_out_volume(HWVoiceOut *hw, Volume *vol)
 {
     SpiceVoiceOut *out = container_of(hw, SpiceVoiceOut, hw);
@@ -202,7 +186,6 @@ static void line_out_volume(HWVoiceOut *hw, Volume *vol)
     spice_server_playback_set_volume(&out->sin, 2, svol);
     spice_server_playback_set_mute(&out->sin, vol->mute);
 }
-#endif
 
 /* record */
 
@@ -211,11 +194,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     SpiceVoiceIn *in = container_of (hw, SpiceVoiceIn, hw);
     struct audsettings settings;
 
-#if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
     settings.freq       = spice_server_get_best_record_rate(NULL);
-#else
-    settings.freq       = SPICE_INTERFACE_RECORD_FREQ;
-#endif
     settings.nchannels  = SPICE_INTERFACE_RECORD_CHAN;
     settings.fmt        = AUDIO_FORMAT_S16;
     settings.endianness = HOST_BIG_ENDIAN;
@@ -226,9 +205,7 @@ static int line_in_init(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     in->sin.base.sif = &record_sif.base;
     qemu_spice.add_interface(&in->sin.base);
-#if SPICE_INTERFACE_RECORD_MAJOR > 2 || SPICE_INTERFACE_RECORD_MINOR >= 3
     spice_server_set_record_rate(&in->sin, settings.freq);
-#endif
     return 0;
 }
 
@@ -277,7 +254,6 @@ static void line_in_enable(HWVoiceIn *hw, bool enable)
     }
 }
 
-#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
 static void line_in_volume(HWVoiceIn *hw, Volume *vol)
 {
     SpiceVoiceIn *in = container_of(hw, SpiceVoiceIn, hw);
@@ -289,7 +265,6 @@ static void line_in_volume(HWVoiceIn *hw, Volume *vol)
     spice_server_record_set_volume(&in->sin, 2, svol);
     spice_server_record_set_mute(&in->sin, vol->mute);
 }
-#endif
 
 static struct audio_pcm_ops audio_callbacks = {
     .init_out = line_out_init,
@@ -299,19 +274,14 @@ static struct audio_pcm_ops audio_callbacks = {
     .get_buffer_out = line_out_get_buffer,
     .put_buffer_out = line_out_put_buffer,
     .enable_out = line_out_enable,
-#if (SPICE_INTERFACE_PLAYBACK_MAJOR >= 1) && \
-        (SPICE_INTERFACE_PLAYBACK_MINOR >= 2)
     .volume_out = line_out_volume,
-#endif
 
     .init_in  = line_in_init,
     .fini_in  = line_in_fini,
     .read     = line_in_read,
     .run_buffer_in = audio_generic_run_buffer_in,
     .enable_in = line_in_enable,
-#if ((SPICE_INTERFACE_RECORD_MAJOR >= 2) && (SPICE_INTERFACE_RECORD_MINOR >= 2))
     .volume_in = line_in_volume,
-#endif
 };
 
 static struct audio_driver spice_audio_driver = {

-- 
2.52.0


