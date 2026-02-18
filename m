Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3799CE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:11:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdVj-0007sB-4Z; Wed, 18 Feb 2026 04:06:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVX-0007Fg-N1
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVV-0001V9-OR
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:06:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405564;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GK+InVNU3f2hcJXrsb/od2DfNR27U7o4tVRJnn/aSD8=;
 b=I+XsMQzUzB68n+gUMgWqNsML7soLrMcTmL4STPdYvV7lXPfK2pzhY/Dsb48clx6omfVu7F
 s1Fzt1di2dLDTkEqnyhDfIz6PxoMlv2KIQm4DFls1gLOXCZaf3s5s8NwNS087m6I8p6rxo
 Vcpvam51zYMkP4W2Pgp6m9g1A0QmONA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-W1OOMgXaNWe1m4PGN0XoSA-1; Wed,
 18 Feb 2026 04:06:00 -0500
X-MC-Unique: W1OOMgXaNWe1m4PGN0XoSA-1
X-Mimecast-MFC-AGG-ID: W1OOMgXaNWe1m4PGN0XoSA_1771405559
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71F86180057E; Wed, 18 Feb 2026 09:05:59 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9851319560AD; Wed, 18 Feb 2026 09:05:58 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 48/85] audio/pa: convert to QOM lifecycle methods
Date: Wed, 18 Feb 2026 10:02:48 +0100
Message-ID: <20260218090330.1476169-49-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Migrate the PulseAudio backend from the legacy driver init/fini
callbacks to proper QOM realize and finalize methods.

The paaudio struct fields are now embedded directly in the AudioPa
QOM object instead of being allocated separately as drv_opaque. This
allows accessing the backend state through proper QOM type casting
with AUDIO_PA() rather than casting drv_opaque pointers.

The PulseAudio connection is now managed through the QOM lifecycle,
with the connection reference acquired in realize and released in
finalize.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/paaudio.c | 109 +++++++++++++++++++++++++-----------------------
 1 file changed, 57 insertions(+), 52 deletions(-)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 331da4f2ed6..97e6c0d1794 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -14,19 +14,10 @@
 #define TYPE_AUDIO_PA "audio-pa"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioPa, AUDIO_PA)
 
-struct AudioPa {
-    AudioMixengBackend parent_obj;
-};
+static AudioBackendClass *audio_pa_parent_class;
 
 static struct audio_driver pa_audio_driver;
 
-static void audio_pa_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &pa_audio_driver;
-}
-
 typedef struct PAConnection {
     char *server;
     int refcount;
@@ -36,18 +27,19 @@ typedef struct PAConnection {
     pa_context *context;
 } PAConnection;
 
-static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =
-    QTAILQ_HEAD_INITIALIZER(pa_conns);
+struct AudioPa {
+    AudioMixengBackend parent_obj;
 
-typedef struct {
-    Audiodev *dev;
     PAConnection *conn;
-} paaudio;
+};
+
+static QTAILQ_HEAD(PAConnectionHead, PAConnection) pa_conns =
+    QTAILQ_HEAD_INITIALIZER(pa_conns);
 
 typedef struct {
     HWVoiceOut hw;
     pa_stream *stream;
-    paaudio *g;
+    AudioPa *g;
 } PAVoiceOut;
 
 typedef struct {
@@ -55,7 +47,7 @@ typedef struct {
     pa_stream *stream;
     const void *read_data;
     size_t read_length;
-    paaudio *g;
+    AudioPa *g;
 } PAVoiceIn;
 
 static void qpa_conn_fini(PAConnection *c);
@@ -529,23 +521,25 @@ fail:
 static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
                         void *drv_opaque)
 {
+    AudioMixengBackend *amb = hw->s;
+    AudioPa *apa = AUDIO_PA(amb);
     int error;
     pa_sample_spec ss;
     pa_buffer_attr ba;
     struct audsettings obt_as = *as;
     PAVoiceOut *pa = (PAVoiceOut *) hw;
-    paaudio *g = pa->g = drv_opaque;
-    AudiodevPaOptions *popts = &g->dev->u.pa;
+    AudiodevPaOptions *popts = &amb->dev->u.pa;
     AudiodevPaPerDirectionOptions *ppdo = popts->out;
-    PAConnection *c = g->conn;
+    PAConnection *c = apa->conn;
 
+    pa->g = apa;
     ss.format = audfmt_to_pa (as->fmt, as->endianness);
     ss.channels = as->nchannels;
     ss.rate = as->freq;
 
     ba.tlength = pa_usec_to_bytes(ppdo->latency, &ss);
     ba.minreq = pa_usec_to_bytes(MIN(ppdo->latency >> 2,
-                                     (g->dev->timer_period >> 2) * 3), &ss);
+                                     (amb->dev->timer_period >> 2) * 3), &ss);
     ba.maxlength = -1;
     ba.prebuf = -1;
 
@@ -553,7 +547,7 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
     pa->stream = qpa_simple_new (
         c,
-        ppdo->stream_name ?: g->dev->id,
+        ppdo->stream_name ?: amb->dev->id,
         PA_STREAM_PLAYBACK,
         ppdo->name,
         &ss,
@@ -578,23 +572,25 @@ static int qpa_init_out(HWVoiceOut *hw, struct audsettings *as,
 
 static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 {
+    AudioMixengBackend *amb = hw->s;
+    AudioPa *apa = AUDIO_PA(amb);
     int error;
     pa_sample_spec ss;
     pa_buffer_attr ba;
     struct audsettings obt_as = *as;
     PAVoiceIn *pa = (PAVoiceIn *) hw;
-    paaudio *g = pa->g = drv_opaque;
-    AudiodevPaOptions *popts = &g->dev->u.pa;
+    AudiodevPaOptions *popts = &amb->dev->u.pa;
     AudiodevPaPerDirectionOptions *ppdo = popts->in;
-    PAConnection *c = g->conn;
+    PAConnection *c = apa->conn;
 
+    pa->g = apa;
     ss.format = audfmt_to_pa (as->fmt, as->endianness);
     ss.channels = as->nchannels;
     ss.rate = as->freq;
 
-    ba.fragsize = pa_usec_to_bytes((g->dev->timer_period >> 1) * 3, &ss);
+    ba.fragsize = pa_usec_to_bytes((amb->dev->timer_period >> 1) * 3, &ss);
     ba.maxlength = pa_usec_to_bytes(
-        MAX(ppdo->latency, g->dev->timer_period * 3), &ss);
+        MAX(ppdo->latency, amb->dev->timer_period * 3), &ss);
     ba.minreq = -1;
     ba.prebuf = -1;
 
@@ -602,7 +598,7 @@ static int qpa_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
 
     pa->stream = qpa_simple_new (
         c,
-        ppdo->stream_name ?: g->dev->id,
+        ppdo->stream_name ?: amb->dev->id,
         PA_STREAM_RECORD,
         ppdo->name,
         &ss,
@@ -834,15 +830,20 @@ fail:
     return NULL;
 }
 
-static void *qpa_audio_init(Audiodev *dev, Error **errp)
+static bool
+audio_pa_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
 {
-    paaudio *g;
+    AudioPa *apa = AUDIO_PA(abe);
     AudiodevPaOptions *popts = &dev->u.pa;
     const char *server;
     PAConnection *c;
 
     assert(dev->driver == AUDIODEV_DRIVER_PA);
 
+    if (!audio_pa_parent_class->realize(abe, dev, errp)) {
+        return false;
+    }
+
     if (!popts->server) {
         char pidfile[64];
         char *runtime;
@@ -851,42 +852,38 @@ static void *qpa_audio_init(Audiodev *dev, Error **errp)
         runtime = getenv("XDG_RUNTIME_DIR");
         if (!runtime) {
             error_setg(errp, "XDG_RUNTIME_DIR not set");
-            return NULL;
+            return false;
         }
         snprintf(pidfile, sizeof(pidfile), "%s/pulse/pid", runtime);
         if (stat(pidfile, &st) != 0) {
             error_setg_errno(errp, errno, "could not stat pidfile %s", pidfile);
-            return NULL;
+            return false;
         }
     }
 
     qpa_validate_per_direction_opts(dev, popts->in);
     qpa_validate_per_direction_opts(dev, popts->out);
 
-    g = g_new0(paaudio, 1);
     server = popts->server;
-
-    g->dev = dev;
-
     QTAILQ_FOREACH(c, &pa_conns, list) {
         if (server == NULL || c->server == NULL ?
             server == c->server :
             strcmp(server, c->server) == 0) {
-            g->conn = c;
+            apa->conn = c;
             break;
         }
     }
-    if (!g->conn) {
-        g->conn = qpa_conn_init(server);
+    if (!apa->conn) {
+        apa->conn = qpa_conn_init(server);
     }
-    if (!g->conn) {
-        g_free(g);
+    if (!apa->conn) {
         error_setg(errp, "could not connect to PulseAudio server");
-        return NULL;
+        return false;
     }
 
-    ++g->conn->refcount;
-    return g;
+    ++apa->conn->refcount;
+
+    return true;
 }
 
 static void qpa_conn_fini(PAConnection *c)
@@ -908,16 +905,14 @@ static void qpa_conn_fini(PAConnection *c)
     g_free(c);
 }
 
-static void qpa_audio_fini (void *opaque)
+static void audio_pa_finalize(Object *obj)
 {
-    paaudio *g = opaque;
-    PAConnection *c = g->conn;
+    AudioPa *apa = AUDIO_PA(obj);
+    PAConnection *c = apa->conn;
 
-    if (--c->refcount == 0) {
+    if (c && --c->refcount == 0) {
         qpa_conn_fini(c);
     }
-
-    g_free(g);
 }
 
 static struct audio_pcm_ops qpa_pcm_ops = {
@@ -939,8 +934,6 @@ static struct audio_pcm_ops qpa_pcm_ops = {
 
 static struct audio_driver pa_audio_driver = {
     .name           = "pa",
-    .init           = qpa_audio_init,
-    .fini           = qpa_audio_fini,
     .pcm_ops        = &qpa_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
@@ -948,12 +941,24 @@ static struct audio_driver pa_audio_driver = {
     .voice_size_in  = sizeof (PAVoiceIn),
 };
 
+static void audio_pa_class_init(ObjectClass *klass, const void *data)
+{
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    audio_pa_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = audio_pa_realize;
+    k->driver = &pa_audio_driver;
+}
+
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_PA,
         .parent = TYPE_AUDIO_MIXENG_BACKEND,
         .instance_size = sizeof(AudioPa),
         .class_init = audio_pa_class_init,
+        .instance_finalize = audio_pa_finalize,
     },
 };
 
-- 
2.53.0


