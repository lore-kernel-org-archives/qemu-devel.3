Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1AB1C02192
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 17:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tf07B-0000F3-K2; Mon, 03 Feb 2025 12:20:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06w-0008QN-BA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1tf06u-00040v-Bu
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 12:19:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738603187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFKEKcJkQP6TLhsSd75IBxW6lKBY9g2I1/M4QF4f0yE=;
 b=f8sbDqmmnuTX42pTqB2UzYrp/KRauKisUEHjw0kJWG761IwMmUzK8zgc4wt53edJERT5fi
 e7CKj/hOW8vPXTUh3EdMH+VQnYqY0sgvY98cgoykKQUQSSt/g2s4qMiL598+h34OUdwfVz
 ME2v4OLZEgZVvuPPVUIFkM/s3gR3eb4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-T09ZOQEbMMerR3P7N9fAPw-1; Mon,
 03 Feb 2025 12:19:43 -0500
X-MC-Unique: T09ZOQEbMMerR3P7N9fAPw-1
X-Mimecast-MFC-AGG-ID: T09ZOQEbMMerR3P7N9fAPw
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 35B781800370; Mon,  3 Feb 2025 17:19:42 +0000 (UTC)
Received: from localhost (unknown [10.39.208.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D55F18008C0; Mon,  3 Feb 2025 17:19:40 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org, Alexandre Iooss <erdnaxe@crans.org>
Subject: [PULL v2 8/8] dbus: add -audio dbus nsamples option
Date: Mon,  3 Feb 2025 21:18:48 +0400
Message-ID: <20250203171848.686582-9-marcandre.lureau@redhat.com>
In-Reply-To: <20250203171848.686582-1-marcandre.lureau@redhat.com>
References: <20250203171848.686582-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Allow to set the number of audio samples per read/write to dbus.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 qapi/audio.json      | 22 +++++++++++++++++++++-
 audio/dbusaudio.c    | 21 ++++++++++++++++++---
 ui/dbus-display1.xml | 12 ++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index 519697c0cd..dd5a58d13e 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -65,6 +65,26 @@
     '*in':  'AudiodevPerDirectionOptions',
     '*out': 'AudiodevPerDirectionOptions' } }
 
+##
+# @AudiodevDBusOptions:
+#
+# Options of the D-Bus audio backend.
+#
+# @in: options of the capture stream
+#
+# @out: options of the playback stream
+#
+# @nsamples: set the number of samples per read/write calls (default to 480,
+# 10ms at 48kHz).
+#
+# Since: 10.0
+##
+{ 'struct': 'AudiodevDBusOptions',
+  'data': {
+    '*in':  'AudiodevPerDirectionOptions',
+    '*out': 'AudiodevPerDirectionOptions',
+    '*nsamples': 'uint32'} }
+
 ##
 # @AudiodevAlsaPerDirectionOptions:
 #
@@ -490,7 +510,7 @@
                    'if': 'CONFIG_AUDIO_ALSA' },
     'coreaudio': { 'type': 'AudiodevCoreaudioOptions',
                    'if': 'CONFIG_AUDIO_COREAUDIO' },
-    'dbus':      { 'type': 'AudiodevGenericOptions',
+    'dbus':      { 'type': 'AudiodevDBusOptions',
                    'if': 'CONFIG_DBUS_DISPLAY' },
     'dsound':    { 'type': 'AudiodevDsoundOptions',
                    'if': 'CONFIG_AUDIO_DSOUND' },
diff --git a/audio/dbusaudio.c b/audio/dbusaudio.c
index af77e7cc33..b44fdd1511 100644
--- a/audio/dbusaudio.c
+++ b/audio/dbusaudio.c
@@ -43,9 +43,10 @@
 
 #define DBUS_DISPLAY1_AUDIO_PATH DBUS_DISPLAY1_ROOT "/Audio"
 
-#define DBUS_AUDIO_NSAMPLES 1024 /* could be configured? */
+#define DBUS_DEFAULT_AUDIO_NSAMPLES 480
 
 typedef struct DBusAudio {
+    Audiodev *dev;
     GDBusObjectManagerServer *server;
     bool p2p;
     GDBusObjectSkeleton *audio;
@@ -151,6 +152,18 @@ dbus_init_out_listener(QemuDBusDisplay1AudioOutListener *listener,
         G_DBUS_CALL_FLAGS_NONE, -1, NULL, NULL, NULL);
 }
 
+static guint
+dbus_audio_get_nsamples(DBusAudio *da)
+{
+    AudiodevDBusOptions *opts = &da->dev->u.dbus;
+
+    if (opts->has_nsamples && opts->nsamples) {
+        return opts->nsamples;
+    } else {
+        return DBUS_DEFAULT_AUDIO_NSAMPLES;
+    }
+}
+
 static int
 dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
 {
@@ -160,7 +173,7 @@ dbus_init_out(HWVoiceOut *hw, struct audsettings *as, void *drv_opaque)
     QemuDBusDisplay1AudioOutListener *listener = NULL;
 
     audio_pcm_init_info(&hw->info, as);
-    hw->samples = DBUS_AUDIO_NSAMPLES;
+    hw->samples = dbus_audio_get_nsamples(da);
     audio_rate_start(&vo->rate);
 
     g_hash_table_iter_init(&iter, da->out_listeners);
@@ -274,7 +287,7 @@ dbus_init_in(HWVoiceIn *hw, struct audsettings *as, void *drv_opaque)
     QemuDBusDisplay1AudioInListener *listener = NULL;
 
     audio_pcm_init_info(&hw->info, as);
-    hw->samples = DBUS_AUDIO_NSAMPLES;
+    hw->samples = dbus_audio_get_nsamples(da);
     audio_rate_start(&vo->rate);
 
     g_hash_table_iter_init(&iter, da->in_listeners);
@@ -399,6 +412,7 @@ dbus_audio_init(Audiodev *dev, Error **errp)
 {
     DBusAudio *da = g_new0(DBusAudio, 1);
 
+    da->dev = dev;
     da->out_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
                                                 g_free, g_object_unref);
     da->in_listeners = g_hash_table_new_full(g_str_hash, g_str_equal,
@@ -652,6 +666,7 @@ dbus_audio_set_server(AudioState *s, GDBusObjectManagerServer *server, bool p2p)
                      "swapped-signal::handle-register-out-listener",
                      dbus_audio_register_out_listener, s,
                      NULL);
+    qemu_dbus_display1_audio_set_nsamples(da->iface, dbus_audio_get_nsamples(da));
 
     g_dbus_object_skeleton_add_interface(G_DBUS_OBJECT_SKELETON(da->audio),
                                          G_DBUS_INTERFACE_SKELETON(da->iface));
diff --git a/ui/dbus-display1.xml b/ui/dbus-display1.xml
index d702253431..72deefa455 100644
--- a/ui/dbus-display1.xml
+++ b/ui/dbus-display1.xml
@@ -773,6 +773,18 @@
       <?endif?>
     </method>
 
+    <!--
+        NSamples:
+
+        The number of samples per read/write frames. (for example the default is
+        480, or 10ms at 48kHz)
+
+        (earlier version of the display interface do not provide this property)
+    -->
+    <property name="NSamples" type="u" access="read">
+      <annotation name="org.freedesktop.DBus.Property.EmitsChangedSignal" value="const"/>
+    </property>
+
     <!--
         Interfaces:
 
-- 
2.47.0


