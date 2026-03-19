Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A97E1075276
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 08:37:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w38sY-0002vh-0d; Thu, 19 Mar 2026 04:37:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w38sN-0002us-F4
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w38sL-0001RU-7j
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 04:37:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773909424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DflBsotVf/NXATM1Ii279KK7JYfmpuXCwBFKUhgDyAo=;
 b=KEmGZHU07fVnwY+IsFVt5+eBRy+LComqyxfzrzU8wOCy7KbR82ELs4+ipWcxcUWby/ODJ6
 53ir/zXin0FsXtDVSa9j5ui1ntQjJxcoVLZqC6rq0TVA0DP7FQNraueezXN90gyZHzoWbW
 3ZGPGobq8hgeC0rfdD6xqEKFnQs9Evw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-HaTMG6RKOwi4_wV1aVcx3w-1; Thu,
 19 Mar 2026 04:37:02 -0400
X-MC-Unique: HaTMG6RKOwi4_wV1aVcx3w-1
X-Mimecast-MFC-AGG-ID: HaTMG6RKOwi4_wV1aVcx3w_1773909420
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D23E41956046; Thu, 19 Mar 2026 08:36:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EEC4530001A1; Thu, 19 Mar 2026 08:36:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E77E21E6937; Thu, 19 Mar 2026 09:36:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Sergei Heifetz <heifetz@yandex-team.com>
Cc: qemu-devel@nongnu.org,  Eric Blake <eblake@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Marcel
 Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,
 Yanan Wang <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,  "Dr. David Alan
 Gilbert" <dave@treblig.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v3 09/11] audio: do not build audio-related sources with
 --disable-audio
In-Reply-To: <20260315201646.96862-10-heifetz@yandex-team.com> (Sergei
 Heifetz's message of "Mon, 16 Mar 2026 01:16:44 +0500")
References: <20260315201646.96862-1-heifetz@yandex-team.com>
 <20260315201646.96862-10-heifetz@yandex-team.com>
Date: Thu, 19 Mar 2026 09:36:55 +0100
Message-ID: <87fr5wcj14.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Sergei Heifetz <heifetz@yandex-team.com> writes:

> When QEMU is configured with `--disable-audio`, do not build any
> audio-related sources.
>
> - audio/meson.build and replay/meson.build:
>   Exclude audio-related sources when audio is disabled.
>
> - replay/replay-audio-stub.c:
>   Move the existing stubs from replay/stubs-system.c into a separate
>   file.
>
> - qapi/audio.json:
>   Remove the QMP `query-audiodevs` command.
>
> - hmp-commands*.hx:
>   Remove the HMP `info capture`, `stopcapture` and `wavcapture`
>   commands.
>
> - Other source files:
>   Wrap audio-related code in ifdefs.
>
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>

[...]

> diff --git a/qapi/audio.json b/qapi/audio.json
> index 2df87b97101..28fda7c8ac3 100644
> --- a/qapi/audio.json
> +++ b/qapi/audio.json
> @@ -540,4 +540,5 @@
>  # Since: 8.0
>  ##
>  { 'command': 'query-audiodevs',
> -  'returns': ['Audiodev'] }
> +  'returns': ['Audiodev'],
> +  'if': 'CONFIG_AUDIO' }

Could we disable all the audio stuff here?

I tried, patch appended.  What do you think?

> diff --git a/replay/meson.build b/replay/meson.build
> index 4b4175e8dd4..dc2e94e8975 100644
> --- a/replay/meson.build
> +++ b/replay/meson.build
> @@ -7,7 +7,14 @@ system_ss.add(when: 'CONFIG_TCG', if_true: files(
>    'replay-char.c',
>    'replay-snapshot.c',
>    'replay-net.c',
> -  'replay-audio.c',
>    'replay-random.c',
>    'replay-debugging.c',
>  ), if_false: files('stubs-system.c'))
> +
> +if have_audio
> +  system_ss.add(when: 'CONFIG_TCG',
> +  if_true: files('replay-audio.c'),
> +  if_false: files('replay-audio-stub.c'))
> +else
> +  system_ss.add(files('replay-audio-stub.c'))
> +endif
> diff --git a/replay/replay-audio-stub.c b/replay/replay-audio-stub.c
> new file mode 100644
> index 00000000000..b3da8e15583
> --- /dev/null
> +++ b/replay/replay-audio-stub.c
> @@ -0,0 +1,21 @@
> +/*
> + * Stub for replay-audio.c
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/replay.h"
> +
> +void replay_audio_in_start(size_t *nsamples)
> +{
> +}
> +void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
> +{
> +}
> +void replay_audio_in_finish(void)
> +{
> +}
> +void replay_audio_out(size_t *played)
> +{
> +}

Should this go into stubs/ instead?  Genuine question!  I can't tell
when we use stubs/foo*.c and when we use foo/*stub.c.

> diff --git a/replay/stubs-system.c b/replay/stubs-system.c
> index b2c52bc4043..454415ae8e4 100644
> --- a/replay/stubs-system.c
> +++ b/replay/stubs-system.c
> @@ -15,18 +15,6 @@ void replay_input_sync_event(void)
>  void replay_add_blocker(const char *feature)
>  {
>  }
> -void replay_audio_in_start(size_t *nsamples)
> -{
> -}
> -void replay_audio_in_sample_lr(uint64_t *left, uint64_t *right)
> -{
> -}
> -void replay_audio_in_finish(void)
> -{
> -}
> -void replay_audio_out(size_t *played)
> -{
> -}
>  void replay_breakpoint(void)
>  {
>  }

[...]

Note on the appended patch: the change to ui/dbus.c should be a separate
cleanup patch.


diff --git a/qapi/audio.json b/qapi/audio.json
index 28fda7c8ac..4f5f5dd988 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -49,7 +49,8 @@
     '*channels':       'uint32',
     '*voices':         'uint32',
     '*format':         'AudioFormat',
-    '*buffer-length':  'uint32' } }
+    '*buffer-length':  'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevGenericOptions:
@@ -65,7 +66,8 @@
 { 'struct': 'AudiodevGenericOptions',
   'data': {
     '*in':  'AudiodevPerDirectionOptions',
-    '*out': 'AudiodevPerDirectionOptions' } }
+    '*out': 'AudiodevPerDirectionOptions' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevDBusOptions:
@@ -85,7 +87,8 @@
   'data': {
     '*in':  'AudiodevPerDirectionOptions',
     '*out': 'AudiodevPerDirectionOptions',
-    '*nsamples': 'uint32'} }
+    '*nsamples': 'uint32'},
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevAlsaPerDirectionOptions:
@@ -107,7 +110,8 @@
   'data': {
     '*dev':           'str',
     '*period-length': 'uint32',
-    '*try-poll':      'bool' } }
+    '*try-poll':      'bool' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevAlsaOptions:
@@ -126,7 +130,8 @@
   'data': {
     '*in':        'AudiodevAlsaPerDirectionOptions',
     '*out':       'AudiodevAlsaPerDirectionOptions',
-    '*threshold': 'uint32' } }
+    '*threshold': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevSndioOptions:
@@ -148,7 +153,8 @@
     '*in':        'AudiodevPerDirectionOptions',
     '*out':       'AudiodevPerDirectionOptions',
     '*dev':       'str',
-    '*latency':   'uint32'} }
+    '*latency':   'uint32'},
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevCoreaudioPerDirectionOptions:
@@ -163,7 +169,8 @@
 { 'struct': 'AudiodevCoreaudioPerDirectionOptions',
   'base': 'AudiodevPerDirectionOptions',
   'data': {
-    '*buffer-count': 'uint32' } }
+      '*buffer-count': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevCoreaudioOptions:
@@ -179,7 +186,8 @@
 { 'struct': 'AudiodevCoreaudioOptions',
   'data': {
     '*in':  'AudiodevCoreaudioPerDirectionOptions',
-    '*out': 'AudiodevCoreaudioPerDirectionOptions' } }
+    '*out': 'AudiodevCoreaudioPerDirectionOptions' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevDsoundOptions:
@@ -199,7 +207,8 @@
   'data': {
     '*in':      'AudiodevPerDirectionOptions',
     '*out':     'AudiodevPerDirectionOptions',
-    '*latency': 'uint32' } }
+    '*latency': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevJackPerDirectionOptions:
@@ -233,7 +242,8 @@
     '*client-name':   'str',
     '*connect-ports': 'str',
     '*start-server':  'bool',
-    '*exact-name':    'bool' } }
+    '*exact-name':    'bool' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevJackOptions:
@@ -249,7 +259,8 @@
 { 'struct': 'AudiodevJackOptions',
   'data': {
     '*in':  'AudiodevJackPerDirectionOptions',
-    '*out': 'AudiodevJackPerDirectionOptions' } }
+    '*out': 'AudiodevJackPerDirectionOptions' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevOssPerDirectionOptions:
@@ -271,7 +282,8 @@
   'data': {
     '*dev':          'str',
     '*buffer-count': 'uint32',
-    '*try-poll':     'bool' } }
+    '*try-poll':     'bool' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevOssOptions:
@@ -301,7 +313,8 @@
     '*out':        'AudiodevOssPerDirectionOptions',
     '*try-mmap':   'bool',
     '*exclusive':  'bool',
-    '*dsp-policy': 'uint32' } }
+    '*dsp-policy': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevPaPerDirectionOptions:
@@ -326,7 +339,8 @@
   'data': {
     '*name': 'str',
     '*stream-name': 'str',
-    '*latency': 'uint32' } }
+    '*latency': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevPaOptions:
@@ -345,7 +359,8 @@
   'data': {
     '*in':     'AudiodevPaPerDirectionOptions',
     '*out':    'AudiodevPaPerDirectionOptions',
-    '*server': 'str' } }
+    '*server': 'str' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevPipewirePerDirectionOptions:
@@ -370,7 +385,8 @@
   'data': {
     '*name': 'str',
     '*stream-name': 'str',
-    '*latency': 'uint32' } }
+    '*latency': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevPipewireOptions:
@@ -386,7 +402,8 @@
 { 'struct': 'AudiodevPipewireOptions',
   'data': {
     '*in':     'AudiodevPipewirePerDirectionOptions',
-    '*out':    'AudiodevPipewirePerDirectionOptions' } }
+    '*out':    'AudiodevPipewirePerDirectionOptions' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevSdlPerDirectionOptions:
@@ -401,7 +418,8 @@
 { 'struct': 'AudiodevSdlPerDirectionOptions',
   'base': 'AudiodevPerDirectionOptions',
   'data': {
-    '*buffer-count': 'uint32' } }
+    '*buffer-count': 'uint32' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevSdlOptions:
@@ -417,7 +435,8 @@
 { 'struct': 'AudiodevSdlOptions',
   'data': {
     '*in':  'AudiodevSdlPerDirectionOptions',
-    '*out': 'AudiodevSdlPerDirectionOptions' } }
+    '*out': 'AudiodevSdlPerDirectionOptions' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevWavOptions:
@@ -436,7 +455,8 @@
   'data': {
     '*in':   'AudiodevPerDirectionOptions',
     '*out':  'AudiodevPerDirectionOptions',
-    '*path': 'str' } }
+    '*path': 'str' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudioFormat:
@@ -460,7 +480,8 @@
 # Since: 4.0
 ##
 { 'enum': 'AudioFormat',
-  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ] }
+  'data': [ 'u8', 's8', 'u16', 's16', 'u32', 's32', 'f32' ],
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @AudiodevDriver:
@@ -484,7 +505,8 @@
             { 'name': 'sdl', 'if': 'CONFIG_AUDIO_SDL' },
             { 'name': 'sndio', 'if': 'CONFIG_AUDIO_SNDIO' },
             { 'name': 'spice', 'if': 'CONFIG_SPICE' },
-            'wav' ] }
+            'wav' ],
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @Audiodev:
@@ -530,7 +552,8 @@
                    'if': 'CONFIG_AUDIO_SNDIO' },
     'spice':     { 'type': 'AudiodevGenericOptions',
                    'if': 'CONFIG_SPICE' },
-    'wav':       'AudiodevWavOptions' } }
+    'wav':       'AudiodevWavOptions' },
+  'if': 'CONFIG_AUDIO' }
 
 ##
 # @query-audiodevs:
diff --git a/audio/mixeng.h b/audio/mixeng.h
index f63283f408..0dfd5204a6 100644
--- a/audio/mixeng.h
+++ b/audio/mixeng.h
@@ -25,6 +25,8 @@
 #ifndef QEMU_MIXENG_H
 #define QEMU_MIXENG_H
 
+#ifdef CONFIG_AUDIO
+
 #ifdef FLOAT_MIXENG
 typedef float mixeng_real;
 struct mixeng_volume { int mute; mixeng_real r; mixeng_real l; };
@@ -56,4 +58,5 @@ uint32_t st_rate_frames_in(void *opaque, uint32_t frames_out);
 void mixeng_clear (struct st_sample *buf, int len);
 void mixeng_volume (struct st_sample *buf, int len, struct mixeng_volume *vol);
 
+#endif
 #endif /* QEMU_MIXENG_H */
diff --git a/include/qemu/audio-capture.h b/include/qemu/audio-capture.h
index f1319c9002..5774967c0e 100644
--- a/include/qemu/audio-capture.h
+++ b/include/qemu/audio-capture.h
@@ -8,6 +8,8 @@
 
 #include "audio.h"
 
+#ifdef CONFIG_AUDIO
+
 struct capture_ops {
     void (*info) (void *opaque);
     void (*destroy) (void *opaque);
@@ -30,4 +32,5 @@ void audio_be_del_capture(
     CaptureVoiceOut *cap,
     void *cb_opaque);
 
+#endif
 #endif /* QEMU_AUDIO_CAPTURE_H */
diff --git a/include/qemu/audio.h b/include/qemu/audio.h
index cff8a334f3..1788a54877 100644
--- a/include/qemu/audio.h
+++ b/include/qemu/audio.h
@@ -32,6 +32,8 @@
 #include "gio/gio.h"
 #endif
 
+#ifdef CONFIG_AUDIO
+
 typedef void (*audio_callback_fn) (void *opaque, int avail);
 
 typedef struct audsettings {
@@ -240,4 +242,7 @@ static inline bool audio_format_is_signed(AudioFormat fmt)
 #define TYPE_AUDIO_BACKEND "audio-backend"
 OBJECT_DECLARE_TYPE(AudioBackend, AudioBackendClass, AUDIO_BACKEND)
 
+#else
+//#define audio_cleanup() ((void)0)
+#endif
 #endif /* QEMU_AUDIO_H */
diff --git a/ui/vnc.h b/ui/vnc.h
index ec8d0c91b5..89e0199be1 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -184,7 +184,9 @@ struct VncDisplay
     VncDisplaySASL sasl;
 #endif
 
+#ifdef CONFIG_AUDIO
     AudioBackend *audio_be;
+#endif
 
     VMChangeStateEntry *vmstate_handler_entry;
 };
@@ -325,8 +327,10 @@ struct VncState
     pixman_format_code_t client_format;
     int client_endian; /* G_LITTLE_ENDIAN or G_BIG_ENDIAN */
 
+#ifdef CONFIG_AUDIO
     CaptureVoiceOut *audio_cap;
     struct audsettings as;
+#endif
 
     VncReadEvent *read_handler;
     size_t read_handler_expect;
diff --git a/ui/dbus.c b/ui/dbus.c
index 99dac3e7fe..6086efd017 100644
--- a/ui/dbus.c
+++ b/ui/dbus.c
@@ -35,7 +35,6 @@
 #include "ui/egl-context.h"
 #endif
 #include "qemu/audio.h"
-#include "audio/audio_int.h" /* FIXME: use QOM dynamic cast instead of drv->name */
 #include "qapi/error.h"
 #include "trace.h"
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 0ee5502d1e..7004c875a1 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1103,7 +1103,13 @@ static void vnc_update_throttle_offset(VncState *vs)
     if (vs->throttle_output_offset != offset) {
         trace_vnc_client_throttle_threshold(
             vs, vs->ioc, vs->throttle_output_offset, offset, vs->client_width,
-            vs->client_height, vs->client_pf.bytes_per_pixel, vs->audio_cap);
+            vs->client_height, vs->client_pf.bytes_per_pixel,
+#ifdef CONFIG_AUDIO
+            vs->audio_cap
+#else
+            NULL
+#endif
+            );
     }
 
     vs->throttle_output_offset = offset;


