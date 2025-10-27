Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16D19CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 15:19:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDOtb-0001zq-R1; Mon, 27 Oct 2025 11:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOtS-0001uF-0A
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vDOtO-0003hm-UX
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 11:12:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761577937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AtyKwWInGjMQa13I0aU5SVdhFBc+UH3Hxc/0w9qjB3I=;
 b=RbZVqmyYqnR0NOkUrXBVf9xqjNUvJR+FH9FZ/ealwptT+MM/99ruOQNw1Rck57yvH4T31G
 NcHIV2n0QvGjgFbf/VBs1SswU1nmY+CH+Zmhk0xhqhhr/mz37YmyxRk+lUSJupIofPrbql
 6HNkb0glqoq1fJ8q5nvquJF2kaYQ1rM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-s-c1sNTQPju3TWLBjsdV5Q-1; Mon,
 27 Oct 2025 11:12:12 -0400
X-MC-Unique: s-c1sNTQPju3TWLBjsdV5Q-1
X-Mimecast-MFC-AGG-ID: s-c1sNTQPju3TWLBjsdV5Q_1761577929
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1378018001E4; Mon, 27 Oct 2025 15:12:09 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2755830001A2; Mon, 27 Oct 2025 15:12:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jan Kiszka <jan.kiszka@web.de>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v3 11/35] audio: use /audiodevs QOM container
Date: Mon, 27 Oct 2025 19:10:18 +0400
Message-ID: <20251027151045.2863176-12-marcandre.lureau@redhat.com>
In-Reply-To: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

audio_cleanup() is already called at exit (similar to chardev)

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/audio_int.h |  2 --
 audio/audio.c     | 38 +++++++++++++-------------------------
 2 files changed, 13 insertions(+), 27 deletions(-)

diff --git a/audio/audio_int.h b/audio/audio_int.h
index b2b4d2d10e..4187a2dbfc 100644
--- a/audio/audio_int.h
+++ b/audio/audio_int.h
@@ -235,8 +235,6 @@ typedef struct AudioState {
 
     bool timer_running;
     uint64_t timer_last;
-
-    QTAILQ_ENTRY(AudioState) list;
 } AudioState;
 
 extern const struct mixeng_volume nominal_volume;
diff --git a/audio/audio.c b/audio/audio.c
index c291fd3e65..5bf4307fbd 100644
--- a/audio/audio.c
+++ b/audio/audio.c
@@ -102,8 +102,6 @@ static audio_driver *audio_driver_lookup(const char *name)
     return NULL;
 }
 
-static QTAILQ_HEAD(AudioStateHead, AudioState) audio_states =
-    QTAILQ_HEAD_INITIALIZER(audio_states);
 static AudioState *default_audio_state;
 
 const struct mixeng_volume nominal_volume = {
@@ -1684,11 +1682,8 @@ static Object *get_audiodevs_root(void)
 void audio_cleanup(void)
 {
     default_audio_state = NULL;
-    while (!QTAILQ_EMPTY(&audio_states)) {
-        AudioState *s = QTAILQ_FIRST(&audio_states);
-        QTAILQ_REMOVE(&audio_states, s, list);
-        object_unref(s);
-    }
+
+    object_unparent(get_audiodevs_root());
 }
 
 static bool vmstate_audio_needed(void *opaque)
@@ -1739,7 +1734,6 @@ void audio_create_default_audiodevs(void)
  */
 static AudioState *audio_init(Audiodev *dev, Error **errp)
 {
-    static bool atexit_registered;
     int done = 0;
     const char *drvname;
     VMChangeStateEntry *vmse;
@@ -1747,14 +1741,6 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
     struct audio_driver *driver;
 
     s = AUDIO_STATE(object_new(TYPE_AUDIO_STATE));
-    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
-        goto out;
-    }
-
-    if (!atexit_registered) {
-        atexit(audio_cleanup);
-        atexit_registered = true;
-    }
 
     if (dev) {
         /* -audiodev option */
@@ -1802,7 +1788,10 @@ static AudioState *audio_init(Audiodev *dev, Error **errp)
                "(Audio can continue looping even after stopping the VM)\n");
     }
 
-    QTAILQ_INSERT_TAIL(&audio_states, s, list);
+    if (!object_property_try_add_child(get_audiodevs_root(), dev->id, OBJECT(s), errp)) {
+        goto out;
+    }
+    object_unref(s);
     QLIST_INIT (&s->card_head);
     vmstate_register_any(NULL, &vmstate_audio, s);
     return s;
@@ -2249,15 +2238,14 @@ int audio_buffer_bytes(AudiodevPerDirectionOptions *pdo,
 
 AudioState *audio_state_by_name(const char *name, Error **errp)
 {
-    AudioState *s;
-    QTAILQ_FOREACH(s, &audio_states, list) {
-        assert(s->dev);
-        if (strcmp(name, s->dev->id) == 0) {
-            return s;
-        }
+    Object *obj = object_resolve_path_component(get_audiodevs_root(), name);
+
+    if (!obj) {
+        error_setg(errp, "audiodev '%s' not found", name);
+        return NULL;
+    } else {
+        return AUDIO_STATE(obj);
     }
-    error_setg(errp, "audiodev '%s' not found", name);
-    return NULL;
 }
 
 const char *audio_get_id(QEMUSoundCard *card)
-- 
2.51.0


