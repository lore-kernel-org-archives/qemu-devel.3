Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0BCE7BD9E
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweJ-0003GR-Oj; Mon, 16 Feb 2026 06:20:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcE-0006ak-BL
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcC-0008CB-E8
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aSw0+nWfREHkM9D3OEgLFV+S+9mgN4B1YEV84KexTb8=;
 b=baETH920E1k/gOmzlN5QH7Nn45biI+VSwzxoKU1Ef7AJX8c9DURqFsBbTb6OnMcTOMXg8i
 mrMF4TDrJ3nx9+bJFIdeIlcnZvDOnaAp0KBUocGWm/aaFrwaYnuG1gFkjl9suwnAxQTW4B
 i7Mi0DP6j99jRdBUMvBjAd2RxoowI0A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-187-Nf_NEw_UMeih7CYbTExd2Q-1; Mon,
 16 Feb 2026 06:18:02 -0500
X-MC-Unique: Nf_NEw_UMeih7CYbTExd2Q-1
X-Mimecast-MFC-AGG-ID: Nf_NEw_UMeih7CYbTExd2Q_1771240680
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ED021800454; Mon, 16 Feb 2026 11:18:00 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E54C518003F5; Mon, 16 Feb 2026 11:17:59 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:40 +0100
Subject: [PATCH 51/85] audio/jack: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-51-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=t0ucslZSKbGcBRFeyrKr2G8Lh/S+UoRUSUp+0FAVQBY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQ5zrVbVSPL/xI25NQc7n5DQc/dYT/XBYH6
 jGtBjQPRGOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5WzOEACqKsIXAM9F0PkZZn+jgTBQSEewvNiNgfEvoF6pvr4SPmK3rKBkBVcm2Qv1k9uGOjmOyiY
 4Ql6Xq8Iw8lfcJa9VOz9O254OuuM4rqp9g6ydM+fQlTsv+p4pDMztk5vN+IbQlzgFIz7OKr2OBa
 nTgEpU/ymBj4ynkfbSPuze0f4O8jlPQ2FyPVO/var1rsHGiXl43Wolr0kuYx4DPLgjhobpg20Ug
 ReWFwfEdMEnJ1tmVvPGKYCv4dkLsFNkg5SJLfgmnOig2Gtkq2dgV4iK8bKAshHRK10R0BTmmx2X
 CXf8SgxL6lxpTQjTY5gsYOp1WOgImz9BqlqXqaCmwXY0gjefx1SWZX8e/p5Ys5yM7t6Ml5j1Jp2
 j2aFncipEjiEYzS7qmaneSezzThU7KP6Q0dOk29uYAp+TMV1gJML5j1Xk6OdUUDpluk8ODbJ1s+
 xBwM99P9PbDrjum5voco10gOCYfFLWbTazqO0u7JJsGoSL5uaiJEXQbu+zhQTH7jE7D9AtjQznJ
 nvqdfb3g4V0xAm4Cv2UMwTR8NeZM9fbPwswin8o6iiUagrK75YJzLjEj9iH5HluGZNLtmwDdNXS
 meGyOq9YLD0vTrxGPbmzc+Pa1U0ZprYpo9R5Vs0UW3AtDw7YQrgPHpbMW85mul0z9Y66T7x5GxL
 bQKS5h5MBYY87ow==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Remove the legacy driver init/fini callbacks from the JACK audio backend.

Both qjack_init() and qjack_fini() were no-ops that performed no real
initialization or cleanup work. Access to the Audiodev is now through
hw->s->dev instead of the drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/jackaudio.c | 30 +++++++++---------------------
 1 file changed, 9 insertions(+), 21 deletions(-)

diff --git a/audio/jackaudio.c b/audio/jackaudio.c
index 972b158f023..31e3da6a7fe 100644
--- a/audio/jackaudio.c
+++ b/audio/jackaudio.c
@@ -44,13 +44,6 @@ struct AudioJack {
 
 static struct audio_driver jack_driver;
 
-static void audio_jack_class_init(ObjectClass *klass, const void *data)
-{
-    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
-
-    k->driver = &jack_driver;
-}
-
 struct QJack;
 
 typedef enum QJackState {
@@ -518,7 +511,7 @@ static int qjack_init_out(HWVoiceOut *hw, struct audsettings *as,
     void *drv_opaque)
 {
     QJackOut *jo  = (QJackOut *)hw;
-    Audiodev *dev = (Audiodev *)drv_opaque;
+    Audiodev *dev = hw->s->dev;
 
     jo->c.out       = true;
     jo->c.enabled   = false;
@@ -555,7 +548,7 @@ static int qjack_init_in(HWVoiceIn *hw, struct audsettings *as,
     void *drv_opaque)
 {
     QJackIn  *ji  = (QJackIn *)hw;
-    Audiodev *dev = (Audiodev *)drv_opaque;
+    Audiodev *dev = hw->s->dev;
 
     ji->c.out       = false;
     ji->c.enabled   = false;
@@ -662,16 +655,6 @@ static int qjack_thread_creator(jack_native_thread_t *thread,
 }
 #endif
 
-static void *qjack_init(Audiodev *dev, Error **errp)
-{
-    assert(dev->driver == AUDIODEV_DRIVER_JACK);
-    return dev;
-}
-
-static void qjack_fini(void *opaque)
-{
-}
-
 static struct audio_pcm_ops jack_pcm_ops = {
     .init_out       = qjack_init_out,
     .fini_out       = qjack_fini_out,
@@ -689,8 +672,6 @@ static struct audio_pcm_ops jack_pcm_ops = {
 
 static struct audio_driver jack_driver = {
     .name           = "jack",
-    .init           = qjack_init,
-    .fini           = qjack_fini,
     .pcm_ops        = &jack_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
@@ -708,6 +689,13 @@ static void qjack_info(const char *msg)
     dolog("I: %s\n", msg);
 }
 
+static void audio_jack_class_init(ObjectClass *klass, const void *data)
+{
+    AudioMixengBackendClass *k = AUDIO_MIXENG_BACKEND_CLASS(klass);
+
+    k->driver = &jack_driver;
+}
+
 static const TypeInfo audio_types[] = {
     {
         .name = TYPE_AUDIO_JACK,

-- 
2.53.0


