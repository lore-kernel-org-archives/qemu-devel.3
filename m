Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5545E7BD9B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:26:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfI-0005ky-Gy; Mon, 16 Feb 2026 06:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcL-0006i3-Og
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcI-0008D2-PR
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uH9F5ZbfheqEuQKcQaxVN621xVlRLtEAcdHBWTCahY4=;
 b=NSaQlktooaxvaPEq+12d7y8ViY3r8GhfdpLd8YDj5ZFVziaGLYccLDAhCe1/EO0hcN00mG
 uM2sAj68lUzwv5urti74Z/+7n80N6M8glseLvrX4QgT9Jhv9i5xGzpXZts3oV4NCxgYu43
 uYatZhx8Mo0wlhXdYCYOuX5NI6QYzzQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Stq9VjIlP7qh-Q1F_XVTLA-1; Mon,
 16 Feb 2026 06:18:09 -0500
X-MC-Unique: Stq9VjIlP7qh-Q1F_XVTLA-1
X-Mimecast-MFC-AGG-ID: Stq9VjIlP7qh-Q1F_XVTLA_1771240687
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E956E1956058; Mon, 16 Feb 2026 11:18:06 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EF7B230001A5; Mon, 16 Feb 2026 11:18:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:42 +0100
Subject: [PATCH 53/85] audio/coreaudio: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-53-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1859;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vQiHwzIc9rV8//NbzAafizGFjxFI5+TEF7+H85FTPW8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQsEj/x84XZ2zrVn1c7YV6t77/ljjT9YCwC
 JsYIyqPEyeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5fVVD/4p1ZxH28XdPxkA+QQ2lt2h4PAapFFsNv7e480/s5PeKu78gV9oO7RANBomYL6Lst26reU
 xdbR4UlIHQbEHEqTUITsPBLex2EBf3g6DUbVVrZtdRkXUqD+tha5dNNfXgEBb4MU6UtcKZvQolX
 8ZbSEbDLWmayLkwTAPwRduDr6H/hpZ0An54UC+YeKgCdgo4Q9Aikttfqd/w6fKRZX41oPoiQK5S
 J+BwO2qH3WXTG4N8ZkFIUPs26RedCggjeYa5SDAtmUY7VID0ukQBpzanZ8Yo4zl3FvB0AsFKU26
 phXYUF85kWV+6itdoGICZNBIdDi9cHqZwkU1E+1Di1mdBaxbq1m2uBx2MS45moyeBSdeeOOL+CZ
 u1k2cX3yev5qsJqpWrOWBuWZbdu6TKBxjYYRdYUOsz+6JvCHWafXDYJO6pbX+fPmFDCMnNYWkEF
 XQZnVEkaGLMANY3zujxHWa/gkmZtAwIDRsuOgBL6OEy8q9OdUHL6m7ZYvW0UCm0qrwfnaHYZ4Ju
 lUn5z6+XW1TrJvlSdeTzxD6KnsxZHoZl4VZpQAbwl6k3Wk/peSmkytAHa93a0Uef2OavU8CDLln
 1+wIWNRvvzD+FIOps5cWQwi0nRIwxwTDsr6hS4xcVMwVcgG+cKyIEi4ugPmaIs6gRsX9PfK8+Na
 DhMIiUNRXFay7lA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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


