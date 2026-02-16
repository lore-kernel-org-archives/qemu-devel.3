Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6592E7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfY-00082z-Pw; Mon, 16 Feb 2026 06:21:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcF-0006b1-I8
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwcE-0008CQ-48
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:18:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Qj7tPbVqgOlKJ+Ll6M3+6JaJu6YSwwchSgbBCeu4O1M=;
 b=TwDyq/pnlKNRYGOfBa2pvN1MkcQdjqzV69iRE6acHGPUbB+abN56aFgiZgevsHroRaJKeS
 3jqJD5dZ76gYRWwXl25gWTv4UNkw7+8nwga7cpsQkn/MUqjrTGs+t82FZyo4URljC+1YkE
 RligsrwXuO8UnGUStkSHdUPI35r0wZM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-5O8WJ4ZdM0ysddx2svczBw-1; Mon,
 16 Feb 2026 06:18:06 -0500
X-MC-Unique: 5O8WJ4ZdM0ysddx2svczBw-1
X-Mimecast-MFC-AGG-ID: 5O8WJ4ZdM0ysddx2svczBw_1771240684
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA62D1956094; Mon, 16 Feb 2026 11:18:03 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD06019560A2; Mon, 16 Feb 2026 11:18:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:41 +0100
Subject: [PATCH 52/85] audio/sndio: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-52-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2039;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=idLQbKa19YwiU46EtQoQP2sry84lA/BHtl+BQc+SfU0=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQyvJ5Sp0lr4p334/waquRoLpaMl8d00Wl1
 B/yZSTqLt+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5aooD/4geXbnZ4hfJpI2CicCN/NSOcSTacyRuSYM/YdRVob1CoJvAqrcF1lXYsioTOO1tqHXsZR
 1ulGUnmdOK/Qb0sRVhmmZLHLuanzw4j1iUTyJCIvxQYatdyPSRn1ZR3yvQ4tIdxz5Ep8wHNP5MT
 to886YMHX5xr7bN4Gx8Gjz5/0168kf2HAKtH3ZU+8XbbcBEYx2JXHe/jYRDhFsCPxaN8f+NrBXq
 ZkepiDTjmeq2OhWw5IZxEhwf2MYH3HO/4rSajPVMBxgjHFyQvIxBN2Y3c7gPwI9zM0T8Xf1k/Vm
 ANIBUvKGBYOzR7nszGDRqjDUHndCe17oDllP66Tc9MPOVy66W+ctz7EBO4XKVaerGVNwkcme8g4
 2SrMDK+gol5ZLu078XRYNaxoXk+zk40Iv/ZXwdZcoagOOIOdWM8hYHr6unr5Dcv5oIMtRyZLY8f
 YgsGaSHSIHZ8B0rXSe+tdwnhbg18FfKCs5i+s6InQUiaK6SNjJ/3dfkp0cbK4KGf4bK9CkF2fgx
 TDdODJNjCa6IkYwrI+kaQR6o7GUEEi5OjhaU83MVNS0o8qvjTtTxYGPZztLtVp52GBDLB/RUoIv
 8VNcyZmljnFU/o+BihgY5jGberEpyoa3CzHtXXOOiT/Y+cwtHaAhPnxXKhns/9t3blPxSvHujZm
 gtA/0qJCHVPbFKw==
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

Remove the legacy driver init/fini callbacks from the sndio audio backend.

Both sndio_audio_init() and sndio_audio_fini() were no-ops that
performed no real initialization or cleanup work. Access to the
Audiodev is now through hw->s->dev instead of the drv_opaque pointer.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/sndioaudio.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 2a9ae42992b..c15d8b6684a 100644
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
2.53.0


