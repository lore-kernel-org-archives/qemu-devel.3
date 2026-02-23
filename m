Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6EDAE98E10
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 09:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuSZu-0001vA-Ex; Mon, 23 Feb 2026 04:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZQ-0000pb-6i
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuSZO-00075s-Py
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 04:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771840178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8wDShJ+X7UTn+POkwYGZJe1+5q3HI8Li/EquJ/0PdMQ=;
 b=Pj4MNQn3nbPIgAdEING+6KwLjgh/F11jMei1tWOrnwbBiqjjwQ79gXCoMSLmtN9Jkak7Lv
 3Ba3oNEqE0pYLC0HPsoRhqwyH+AUiyQL+w9YTK1yjc4Mz145P9Oe8dewoC8GQYMURgq3oj
 rfr8MXvfCbTk+d1ZGGn6SS6ZsU49mxU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-TQ2nqU61NnOcMd0t4MDYFA-1; Mon,
 23 Feb 2026 04:49:32 -0500
X-MC-Unique: TQ2nqU61NnOcMd0t4MDYFA-1
X-Mimecast-MFC-AGG-ID: TQ2nqU61NnOcMd0t4MDYFA_1771840171
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4225B1956050; Mon, 23 Feb 2026 09:49:31 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 761211800668; Mon, 23 Feb 2026 09:49:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL v2 53/85] audio/coreaudio: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 10:46:11 +0100
Message-ID: <20260223094649.2005118-54-marcandre.lureau@redhat.com>
In-Reply-To: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
References: <20260223094649.2005118-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

Remove the legacy driver init/fini callbacks from the CoreAudio backend.

Both coreaudio_audio_init() and coreaudio_audio_fini() were no-ops that
performed no real initialization or cleanup work. Access to the
Audiodev is now through hw->s->dev instead of the drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 audio/coreaudio.m | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/audio/coreaudio.m b/audio/coreaudio.m
index 862cb9dd9b0..4a0904f0073 100644
--- a/audio/coreaudio.m
+++ b/audio/coreaudio.m
@@ -579,7 +579,7 @@ static int coreaudio_init_out(HWVoiceOut *hw, struct audsettings *as,
     OSStatus status;
     coreaudioVoiceOut *core = (coreaudioVoiceOut *) hw;
     int err;
-    Audiodev *dev = drv_opaque;
+    Audiodev *dev = hw->s->dev;
     AudiodevCoreaudioPerDirectionOptions *cpdo = dev->u.coreaudio.out;
     struct audsettings obt_as;
 
@@ -656,15 +656,6 @@ static void coreaudio_enable_out(HWVoiceOut *hw, bool enable)
     update_device_playback_state(core);
 }
 
-static void *coreaudio_audio_init(Audiodev *dev, Error **errp)
-{
-    return dev;
-}
-
-static void coreaudio_audio_fini (void *opaque)
-{
-}
-
 static struct audio_pcm_ops coreaudio_pcm_ops = {
     .init_out = coreaudio_init_out,
     .fini_out = coreaudio_fini_out,
@@ -681,8 +672,6 @@ static void coreaudio_audio_fini (void *opaque)
 
 static struct audio_driver coreaudio_audio_driver = {
     .name           = "coreaudio",
-    .init           = coreaudio_audio_init,
-    .fini           = coreaudio_audio_fini,
     .pcm_ops        = &coreaudio_pcm_ops,
     .max_voices_out = 1,
     .max_voices_in  = 0,
-- 
2.53.0


