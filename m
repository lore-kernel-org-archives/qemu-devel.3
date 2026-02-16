Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06B5AE7BD9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfX-0007rg-AB; Mon, 16 Feb 2026 06:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbv-0006EF-V1
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbq-00086x-5r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240665;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZAePRO9iX/CdNZl5mbtEzsh4UrYfxMJmJv42slqeaKE=;
 b=InubpNMfFFamqOdXQkfxHz9umZk4QQtbBKA0WJVjYB41+ichPJIq3pK9slcwqpoFeEBLLW
 TzvvX5F8SrBgtgd26XvM8G0wT1AW995Sm9oO9Ha+jTtaYR0b3WhQHqDAJe2XQvBA9a2QeN
 wcjywYgYAXx7XDeFrYrAjkm6jQ3X/50=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-jmIuXMb8MmCISZFgiasbOQ-1; Mon,
 16 Feb 2026 06:17:41 -0500
X-MC-Unique: jmIuXMb8MmCISZFgiasbOQ-1
X-Mimecast-MFC-AGG-ID: jmIuXMb8MmCISZFgiasbOQ_1771240659
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43D7119560AA; Mon, 16 Feb 2026 11:17:39 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C96B119560A2; Mon, 16 Feb 2026 11:17:37 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:32 +0100
Subject: [PATCH 43/85] audio/spice: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-43-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Rcs408lO9P4mK3uz8yvMkyVGqD72XWjzygJPEae432E=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQAwF6m/TkCaYFng41JyP1I6mFplns1w39M
 VCyg9F1V7yJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5dXTD/4roKmuR4JVDbGSh1B2Tv7YYNc+wLiMg6Vo5Oum72fx4eaGMB/jDzjpWl1tcYyUeHZRydY
 yF5FSzdhdVz+gvs53HwXhwyKcbEt1jJPAim14RehF7e5Y2ZOp1VSQ1XS9VcdTUPvaw4BtmIMbUU
 LJCI2SLTzLYyt2/wgKhYmB3NmedVG3n1ljRyPSq7zF1gTjsct6X7d7jAW+qQd/sYDsgfK7ANrDG
 7g/oaWYhLP6F7lscbZOrboROm1u4OQY0JaXruNETx6xb+DyJF4khxKvNL9z/rRkeI8v3eKqUXvr
 RkaTJM6WmWv4GSV0BVRHoo3IPz6hPBQ478s2nihRbNFAtf/7qhVHRV1jXk6SjlGbeRxEj6fmeVF
 6iy2cdA48jsyGIFXYEaf/NDKr2nR7L6dSwvMCSv0dRNrcW+ux5BZjBdBvSxPPgMDJn6i5XW3UVw
 3wMnVoB1guas3YAioQW4wb/pE7M0GzwktYauLXKk/I0UYvFJZ2yczpes1p3f3U0SOvvPLQ33/CY
 Z6xZo2JYiGEFGtkZiUPtpb2O++cSBT44eTn6Tu0mu8xMvuphALaC8lY8S67Q6sy3Q8j0aHB2QpC
 K/izWRigAhPbugB0kfMtLL1uKsxdK93BWkchDYQ0b3MAIuqKen/w8oaA9IftG/D3fXiIyv4t62x
 TczxZ1PJLLgvXzw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Migrate the SPICE audio backend from the legacy driver init/fini
callbacks to proper QOM realize method.

The spice_audio_init() function is replaced with spice_audio_realize(),
which validates that SPICE is enabled before delegating to the parent
class realize method. The empty spice_audio_fini() is removed as no
cleanup is needed.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


