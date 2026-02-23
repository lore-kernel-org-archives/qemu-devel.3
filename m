Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F94EA4FC3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 13:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuWK9-0003ys-Td; Mon, 23 Feb 2026 08:50:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWK1-0003Ln-2h
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:50:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vuWJi-0007Dz-Hz
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 08:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771854581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xlYgVBp4rfEz5yRZZFEr+/zGXWEq4y/2XCxEe+g3GVo=;
 b=UV0+/GdhET3vnbm4f+gXGnWuI0VMsKqBz4Dn0j6S6Y+DRBiKtrs7kVtOYY/j2eQ7ko1dB5
 Mct5gE/UOWH5iArq36QmR3N7Y3CDRm63siU0+5gof5UMskiAj2f7mh0t2g591rRs40Ewkq
 2NAoJ9WLJOZ1+1aKKiwE7T9ZxYwgTaU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-jFtbffeyNXG3GndClUTioA-1; Mon,
 23 Feb 2026 08:49:38 -0500
X-MC-Unique: jFtbffeyNXG3GndClUTioA-1
X-Mimecast-MFC-AGG-ID: jFtbffeyNXG3GndClUTioA_1771854577
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6AB31800630; Mon, 23 Feb 2026 13:49:37 +0000 (UTC)
Received: from localhost (unknown [10.45.242.25])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 52A1B3000C26; Mon, 23 Feb 2026 13:49:37 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PULL v3 45/85] audio/noaudio: convert to QOM lifecycle methods
Date: Mon, 23 Feb 2026 14:46:46 +0100
Message-ID: <20260223134731.2377432-46-marcandre.lureau@redhat.com>
In-Reply-To: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
References: <20260223134731.2377432-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Remove the legacy driver init/fini callbacks from the null audio backend.

Both no_audio_init() and no_audio_fini() were no-ops that performed
no real initialization or cleanup work.

Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


