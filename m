Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707DCD2FED8
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:27:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknmD-0005hj-Dy; Tue, 27 Jan 2026 13:26:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknln-00058r-TR
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:26:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknlm-0003By-Gj
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:26:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=09TL7tvh6lOv6CeNPlS0z5iL5YXibgmDP7u50Fd1/sY=;
 b=Nisuk0KRgaqufI5YsD2NQPxvd+6w7zov4eHzKyzSu7joX1DeaG/KQckBKRYRLfFq45ywyl
 KUJQOzTNwADNsS7qHHK9PANXRY3zy6/OqY/tCbcIJ3krcxROY+WbodvR0pulVl65Zo4Pmb
 iq1Y7bSs6dffymA1t1PoG9ohbfDz/X0=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-iSSYoTZ4MPqDQUvvHyd8_Q-1; Tue,
 27 Jan 2026 13:26:28 -0500
X-MC-Unique: iSSYoTZ4MPqDQUvvHyd8_Q-1
X-Mimecast-MFC-AGG-ID: iSSYoTZ4MPqDQUvvHyd8_Q_1769538387
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB91319775A9; Tue, 27 Jan 2026 18:26:26 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 76A491800665; Tue, 27 Jan 2026 18:26:24 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Ratchov <alex@caoua.org>
Subject: [PATCH 11/43] audio/sndio: convert to QOM lifecycle methods
Date: Tue, 27 Jan 2026 22:24:38 +0400
Message-ID: <20260127182516.289834-12-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Remove the legacy driver init/fini callbacks from the sndio audio backend.

Both sndio_audio_init() and sndio_audio_fini() were no-ops that
performed no real initialization or cleanup work. Access to the
Audiodev is now through hw->s->dev instead of the drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/sndioaudio.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 2fa519e3eab..4c2acbcbb4b 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -499,7 +499,7 @@ static int sndio_init_out(HWVoiceOut *hw, struct audsettings *as, void *opaque)
 {
     SndioVoice *self = (SndioVoice *) hw;
 
-    if (sndio_init(self, as, SIO_PLAY, opaque) == -1) {
+    if (sndio_init(self, as, SIO_PLAY, hw->s->dev) == -1) {
         return -1;
     }
 
@@ -512,7 +512,7 @@ static int sndio_init_in(HWVoiceIn *hw, struct audsettings *as, void *opaque)
 {
     SndioVoice *self = (SndioVoice *) hw;
 
-    if (sndio_init(self, as, SIO_REC, opaque) == -1) {
+    if (sndio_init(self, as, SIO_REC, hw->s->dev) == -1) {
         return -1;
     }
 
@@ -535,16 +535,6 @@ static void sndio_fini_in(HWVoiceIn *hw)
     sndio_fini(self);
 }
 
-static void *sndio_audio_init(Audiodev *dev, Error **errp)
-{
-    assert(dev->driver == AUDIODEV_DRIVER_SNDIO);
-    return dev;
-}
-
-static void sndio_audio_fini(void *opaque)
-{
-}
-
 static struct audio_pcm_ops sndio_pcm_ops = {
     .init_out        = sndio_init_out,
     .fini_out        = sndio_fini_out,
@@ -563,8 +553,6 @@ static struct audio_pcm_ops sndio_pcm_ops = {
 
 static struct audio_driver sndio_audio_driver = {
     .name           = "sndio",
-    .init           = sndio_audio_init,
-    .fini           = sndio_audio_fini,
     .pcm_ops        = &sndio_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,
-- 
2.52.0


