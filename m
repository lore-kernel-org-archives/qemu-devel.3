Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A6CE98E11
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:52:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSZF-0000Eo-3c; Mon, 23 Feb 2026 04:49:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSYw-0007cU-7h
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSYu-00072g-B4
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAOgBxSVBxg4rG7YAbPn+jORLT0sScr7l61x0jGcsvw=;
 b=DHAi6576Om96TWdsbO08qoOsB5l/Y6aZIczCH9ZBrXPF5ScsrC34X1nMVj4aOc2EbXEOTw
 OCkPaIS/a7lOaW1NnFeyCYwOa+GUV03LfTXEl/BPdirokJQGV00AuCB5UoqZ2WRhYAlCqE
 18LBuGhOL1RTlcJEbzg6Tacplmw0lPU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-444-_r4X3mRrOKOhJmk5vkrK8w-1; Mon,
 23 Feb 2026 04:49:02 -0500
X-MC-Unique: _r4X3mRrOKOhJmk5vkrK8w-1
X-Mimecast-MFC-AGG-ID: _r4X3mRrOKOhJmk5vkrK8w_1771840141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB4661956096; Mon, 23 Feb 2026 09:49:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F34D81800465; Mon, 23 Feb 2026 09:49:00 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL v2 43/85] audio/spice: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 10:46:01 +0100
Message-ID: <20260223094649.2005118-44-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Migrate the SPICE audio backend from the legacy driver init/fini
callbacks to proper QOM realize method.

The spice_audio_init() function is replaced with spice_audio_realize(),
which validates that SPICE is enabled before delegating to the parent
class realize method. The empty spice_audio_fini() is removed as no
cleanup is needed.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/spiceaudio.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/audio/spiceaudio.c b/audio/spiceaudio.c
index ad7cb69673b..953dbf6c308 100644
--- a/audio/spiceaudio.c
+++ b/audio/spiceaudio.c
@@ -33,16 +33,33 @@
 #define TYPE_AUDIO_SPICE "audio-spice"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioSpice, AUDIO_SPICE)
 
+static AudioBackendClass *audio_spice_parent_class;
+
 struct AudioSpice {
     AudioMixengBackend parent_obj;
 };
 
 static struct audio_driver spice_audio_driver;
 
+static bool spice_audio_realize(AudioBackend *abe, Audiodev *dev, Error **errp)
+{
+    if (!using_spice) {
+        error_setg(errp, "Cannot use spice audio without -spice");
+        qapi_free_Audiodev(dev);
+        return false;
+    }
+
+    return audio_spice_parent_class->realize(abe, dev, errp);
+}
+
 static void audio_spice_class_init(ObjectClass *klass, const void *data)
 {
+    AudioBackendClass *b = AUDIO_BACKEND_CLASS(klass);
     AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
 
+    audio_spice_parent_class = AUDIO_BACKEND_CLASS(object_class_get_parent(klass));
+
+    b->realize = spice_audio_realize;
     k->driver = &spice_audio_driver;
 }
 
@@ -89,21 +106,6 @@ static const SpiceRecordInterface record_sif = {
     .base.minor_version = SPICE_INTERFACE_RECORD_MINOR,
 };
 
-static void *spice_audio_init(Audiodev *dev, Error **errp)
-{
-    if (!using_spice) {
-        error_setg(errp, "Cannot use spice audio without -spice");
-        return NULL;
-    }
-
-    return &spice_audio_init;
-}
-
-static void spice_audio_fini (void *opaque)
-{
-    /* nothing */
-}
-
 /* playback */
 
 static int line_out_init(HWVoiceOut *hw, struct audsettings *as,
@@ -333,8 +335,6 @@ static struct audio_pcm_ops audio_callbacks = {
 
 static struct audio_driver spice_audio_driver = {
     .name           = "spice",
-    .init           = spice_audio_init,
-    .fini           = spice_audio_fini,
     .pcm_ops        = &audio_callbacks,
     .max_voices_out = 1,
     .max_voices_in  = 1,
-- 
2.53.0


