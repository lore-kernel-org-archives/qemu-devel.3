Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01814EA4FC5
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWKE-0004Xs-N0; Mon, 23 Feb 2026 08:50:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWK1-0003ND-Jm
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWJx-0007Fy-8v
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:49:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aeLvVFUbBqEI+LRYHP7O9XPoCzRHYKuwsHItmspHacQ=;
 b=WxHNdYYKe4Rjipas2esVIjD65Z3Go6a1WQA1Uymvjzqwjk4WqxHjTb44VaEKh2XqTwjPM/
 j7c6Y3/W20Vby/QIjh3g6XTofd6r5Ix8gKe8Zpz7py/FG6u9IoJtsXZS5rGWfu2Iz2oDBC
 8FYx0gm2/zEu5AEQfOxFx1tC2mBC07E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-fbWiKWp0MS2bkbYoTKaARg-1; Mon,
 23 Feb 2026 08:49:55 -0500
X-MC-Unique: fbWiKWp0MS2bkbYoTKaARg-1
X-Mimecast-MFC-AGG-ID: fbWiKWp0MS2bkbYoTKaARg_1771854594
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4352B1956053; Mon, 23 Feb 2026 13:49:54 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6684B1800670; Mon, 23 Feb 2026 13:49:53 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: [PULL v3 51/85] audio/jack: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 14:46:52 +0100
Message-ID: <20260223134731.2377432-52-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1.179, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.717,
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

Remove the legacy driver init/fini callbacks from the JACK audio backend.

Both qjack_init() and qjack_fini() were no-ops that performed no real
initialization or cleanup work. Access to the Audiodev is now through
hw->s->dev instead of the drv_opaque pointer.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


