Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B71FDE7BD98
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrweH-00031Z-Iq; Mon, 16 Feb 2026 06:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbx-0006Gm-Ct
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbv-00087p-4v
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bp0mskgHmvB97enRMSdlOJ4I9kcDKm/gxqwRVuVQsRc=;
 b=iitDGNsIJhaW+vDy+FDd+dcokGdTE/qRqoM/WDT3hR9K5F1z+3zVs+LVtM0Dz4JuApaN9Q
 sUpICe30jbbabQQU0HlMlD3kLckIrBnoaqyMDaIGGOMA2TobAZP7O5MrDB5PyqRCW1GD7O
 WFxVaCWPM4MyAqPvO/PvbjLguEUEDR8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-riZ0SfBzOXiE2vcjXnM2hw-1; Mon,
 16 Feb 2026 06:17:47 -0500
X-MC-Unique: riZ0SfBzOXiE2vcjXnM2hw-1
X-Mimecast-MFC-AGG-ID: riZ0SfBzOXiE2vcjXnM2hw_1771240665
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01B081956050; Mon, 16 Feb 2026 11:17:45 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E91A21800464; Mon, 16 Feb 2026 11:17:43 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:34 +0100
Subject: [PATCH 45/85] audio/noaudio: convert to QOM lifecycle methods
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-45-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1239;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=KzRYkvsfVLo5yTsnTsx6InHmXoSpaT1Oo7AoHbV0etw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxQtofhQE7cmv8UOdKZBPGI8grKTxrVekcEk
 tcZsqjH8FCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8UAAKCRDa6OEJdZac
 5bKwD/9lHLtMG0zexrzysNPtsNdka0qi2Zx5/a4MhIpkPo47fi823P48paxO28JQE2TGylgb1Oe
 8HpkwkAy5LKrYVnRXHxD2RdAMEr62mIXmWVrAqiU+n72fLzUkEDIkG6oNUOI12ulZuVeIjHkNMj
 3e6IUsL08zyycOftHvT8kEYgKfkuKMcm06bZFfy/6C9ZmGumECA0BC4UNW8QHwlI3hIzR3eqgha
 ACYJRXBtNhZXG9QuoBht6SnEzCp8ckaGDrduNha4OUEF5z2HVJsUE6Tu1zlDgP57JGCV1z0UIfw
 wvUgWpSfuYP4WEVAms3002bodJdQsvfJOdjJoCc3rCnh945qmcJsBGknamHayfQ+skWGvIcAgV4
 XiGC+spWlU6qgb9hWCyfcUW/GmJfI85nb/tQpV54u/Zfrf70Ht/tswEtS1sH+SXCKtkJ60YIOhN
 SuS6EMsaGLCCqh7sYnA14844PZVQYw59W5l9pLDzT0Gf4RlpMzcVJEolhowrRfqU+uPrCQj1cvB
 j8koEdO3y5FNzKOYzTgg7U4tLS3IM6pP15IUM5swSrRHTDGW64yRBK2luvBYlhAaMOZghcchNDS
 C0ldSHf8Iod/47N09eQLfC3ip3ETicLayh24I8rH5WGTtmVtBLL5LeU8ycNjpVBxRQGe9Zansw/
 q9kC7bD73xs/tQQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Remove the legacy driver init/fini callbacks from the null audio backend.

Both no_audio_init() and no_audio_fini() were no-ops that performed
no real initialization or cleanup work.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/noaudio.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/audio/noaudio.c b/audio/noaudio.c
index 65679b8b13d..2bd110caac4 100644
--- a/audio/noaudio.c
+++ b/audio/noaudio.c
@@ -119,16 +119,6 @@ static void no_enable_in(HWVoiceIn *hw, bool enable)
     }
 }
 
-static void *no_audio_init(Audiodev *dev, Error **errp)
-{
-    return &no_audio_init;
-}
-
-static void no_audio_fini (void *opaque)
-{
-    (void) opaque;
-}
-
 static struct audio_pcm_ops no_pcm_ops = {
     .init_out = no_init_out,
     .fini_out = no_fini_out,
@@ -146,8 +136,6 @@ static struct audio_pcm_ops no_pcm_ops = {
 
 static struct audio_driver no_audio_driver = {
     .name           = "none",
-    .init           = no_audio_init,
-    .fini           = no_audio_fini,
     .pcm_ops        = &no_pcm_ops,
     .max_voices_out = INT_MAX,
     .max_voices_in  = INT_MAX,

-- 
2.53.0


