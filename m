Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 815BBE7BDA2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:27:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfI-0005lw-JQ; Mon, 16 Feb 2026 06:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbx-0006Fw-8r
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbt-00087U-Pd
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ED51RwFH+aXGygOFGeGe3zuDHJ0atkgjQmDOXgsvEnQ=;
 b=efr7E51F65cqQdX2I/yQLOssrGaTfa/2FiJV5Gjk6VLjgVLwc7My91qKZcWG+uYbKJl/21
 2gFuwKVQTdhst5t0272RPO4KinPvWsmUsoR+XTbo9JcwA7x/CuZd4277t4Rhx9orFj55pf
 fnV6KpBH9jaNhlnVrSJFKS77GoDRxkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-ClKJmrmwM2y-wgxdFVeEEg-1; Mon,
 16 Feb 2026 06:17:44 -0500
X-MC-Unique: ClKJmrmwM2y-wgxdFVeEEg-1
X-Mimecast-MFC-AGG-ID: ClKJmrmwM2y-wgxdFVeEEg_1771240662
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6434C195DE50; Mon, 16 Feb 2026 11:17:42 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 321961955F43; Mon, 16 Feb 2026 11:17:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:33 +0100
Subject: [PATCH 44/85] audio/wav: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-44-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1879;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=pK/y5/lIOqV/i/C8zTOt7k3t0ZUfllKojrAoxzndaVs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQc9z2ZrvrAwwhcbx++h1SQzswtQZT+D0VW
 QjuGDu3pF+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5SZ5D/4yJTryyW/MgVu5aSz9nN6AchcMsmjoMVTOlrkW1JTQ0fsL76EsSlFqrTDxArsTHNIlp8A
 mS5/uB4MggAVR6OfD5N7gfdki093/9Ttft992UcFM9FoO0rZiCT8GOIn7TVB5D71z2stp3r39WT
 NsVEmAlIcWfAbhqqsXN0wCY0hqUfFqLVnVKrPFJOHuGXXe7MYW/s1lggBTp0Ly+j/JhRwBVWu4K
 uVJ/NVoI9Icx5bb6t6CUbwUz2jSs1yZkSQoudGUHqrY9zCFSLv6SfzTuZRV3/nD7+u8e31SNUxn
 KNtlVju/4veQTfb/ucUMIfJwpwbZ6e2ajq6no1Usf2UQ5Co1WpmvPCrWzVfFilIeX9DGDUKsvMw
 71yBHQxchHsQ4Kvm3yH1LxO9PSiKVjX0DkMgfhZ5SoaOcs/ZdmGk4nFAeB2IK7bERfn6QT5BvTp
 B0YcTIVqevkxqREkRkx7YhWMdoPjHQh0l67Ic0tWCKAhSt1U/Ydsd7aFdZjZvLEAbW2T4gf/T5V
 6lqsLdhKgtYz/OZNN+abTup/mbk87orAzKRvjKeyAZFZxnveYV4dFssm6HaJSXVIpDklpwWUoz3
 UAlVglpt+1LHc17Fg6O6IXwuBM/zJs+wk7qBKvAr3Kb8dHZTHrslPdrzFd+BvjXCoWfU+2DvwR+
 18VGwPKhUEcLloA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Remove the legacy driver init/fini callbacks from the WAV audio backend.

The wav_audio_init() just returned the Audiodev pointer and
wav_audio_fini() only logged a debug message. Access to the Audiodev
is now through hw->s->dev instead of the drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
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


