Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B23E9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:10:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdVI-0006aA-05; Wed, 18 Feb 2026 04:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVG-0006PO-GP
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVE-0000wZ-P5
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405548;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bAOgBxSVBxg4rG7YAbPn+jORLT0sScr7l61x0jGcsvw=;
 b=Rbpke9Vx7ZVZSh7NvP1+sQ76kL7gspwEpRZfbYHwAJ+CyaUpAR0iPxv5brlTgb3ucDxVTu
 BK+niZcHt/c+kmAUbvnxdW8Wb7hBtK5g5zzP2y+c4B4XlK38i25uIEojLLxdjqYtl5EH1k
 ZgDJ2hVTQwhvLlhw40cXTO4stTfuXhY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-J5MW_1W-NTu19ndcgrao-Q-1; Wed,
 18 Feb 2026 04:05:44 -0500
X-MC-Unique: J5MW_1W-NTu19ndcgrao-Q-1
X-Mimecast-MFC-AGG-ID: J5MW_1W-NTu19ndcgrao-Q_1771405544
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCEF51955F1F; Wed, 18 Feb 2026 09:05:43 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 40B2A19560AD; Wed, 18 Feb 2026 09:05:43 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 43/85] audio/spice: convert to QOM lifecycle methods
Date: Wed, 18 Feb 2026 10:02:43 +0100
Message-ID: <20260218090330.1476169-44-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


