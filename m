Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C3E7E9A03E
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:09:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdVZ-0007F2-Jz; Wed, 18 Feb 2026 04:06:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVN-00073A-HF
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdVM-0001BF-2V
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:05:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMFSVuo+MgQICi6NX6A9uaEwtkVzqzcuqzOtwdmRNb8=;
 b=EcuSmwSq6w2n0076q/HvWM7UGfKpPwDxIzaLyvVFcStRq2zEO6B41DMIX7qg9qwd0RJJOf
 TgLYCnHNbNppYVkJND10kIuKVWwzH6WqAnR5KhV3r6fClaikjHIC/RcW5gMGPhuXWVZotJ
 FCQCQLHJUU58nZeQ8rpsHBfxl9/mNcg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-M-Yy9_-4Me2GoiVndILMVQ-1; Wed,
 18 Feb 2026 04:05:49 -0500
X-MC-Unique: M-Yy9_-4Me2GoiVndILMVQ-1
X-Mimecast-MFC-AGG-ID: M-Yy9_-4Me2GoiVndILMVQ_1771405546
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D48151956046; Wed, 18 Feb 2026 09:05:46 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AFF751800672; Wed, 18 Feb 2026 09:05:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL 44/85] audio/wav: convert to QOM lifecycle methods
Date: Wed, 18 Feb 2026 10:02:44 +0100
Message-ID: <20260218090330.1476169-45-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
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

Remove the legacy driver init/fini callbacks from the WAV audio backend.

The wav_audio_init() just returned the Audiodev pointer and
wav_audio_fini() only logged a debug message. Access to the Audiodev
is now through hw->s->dev instead of the drv_opaque pointer.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/wavaudio.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/audio/wavaudio.c b/audio/wavaudio.c
index cd2ceffd42b..f1a414f208c 100644
--- a/audio/wavaudio.c
+++ b/audio/wavaudio.c
@@ -89,7 +89,7 @@ static int wav_init_out(HWVoiceOut *hw, struct audsettings *as,
         0x02, 0x00, 0x44, 0xac, 0x00, 0x00, 0x10, 0xb1, 0x02, 0x00, 0x04,
         0x00, 0x10, 0x00, 0x64, 0x61, 0x74, 0x61, 0x00, 0x00, 0x00, 0x00
     };
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
     AudiodevWavOptions *wopts = &dev->u.wav;
     struct audsettings wav_as = audiodev_to_audsettings(dev->u.wav.out);
     const char *wav_path = wopts->path ?: "qemu.wav";
@@ -200,17 +200,6 @@ static void wav_enable_out(HWVoiceOut *hw, bool enable)
     }
 }
 
-static void *wav_audio_init(Audiodev *dev, Error **errp)
-{
-    assert(dev->driver == AUDIODEV_DRIVER_WAV);
-    return dev;
-}
-
-static void wav_audio_fini (void *opaque)
-{
-    ldebug ("wav_fini");
-}
-
 static struct audio_pcm_ops wav_pcm_ops = {
     .init_out = wav_init_out,
     .fini_out = wav_fini_out,
@@ -222,8 +211,6 @@ static struct audio_pcm_ops wav_pcm_ops = {
 
 static struct audio_driver wav_audio_driver = {
     .name           = "wav",
-    .init           = wav_audio_init,
-    .fini           = wav_audio_fini,
     .pcm_ops        = &wav_pcm_ops,
     .max_voices_out = 1,
     .max_voices_in  = 0,
-- 
2.53.0


