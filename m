Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71D2C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrYR-0005of-L8; Mon, 07 Jul 2025 15:31:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uYrXf-0005OW-ET
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:30:23 -0400
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uYrXd-0005PK-3Z
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:30:18 -0400
Received: from fwd81.aul.t-online.de (fwd81.aul.t-online.de [10.223.144.107])
 by mailout01.t-online.de (Postfix) with SMTP id 0F4081CA8C;
 Mon,  7 Jul 2025 21:30:13 +0200 (CEST)
Received: from linpower.localnet ([93.236.150.188]) by fwd81.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uYrXY-1BvgEj0; Mon, 7 Jul 2025 21:30:12 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 8030F20040B; Mon,  7 Jul 2025 21:30:09 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 2/3] hw/audio/sb16: improve DMA handling
Date: Mon,  7 Jul 2025 21:30:08 +0200
Message-ID: <20250707193009.12901-2-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
References: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751916612-EFFFD5F1-D533DC14/0/0 CLEAN NORMAL
X-TOI-MSGID: 7b5c8950-1d0c-413c-9aae-24cb0873ddbd
Received-SPF: pass client-ip=194.25.134.80;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout01.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The Soundblaster 16 audio device is strange and works differently
compared to the other audio frontends. For audio playback, a BH
routine copies the audio samples from the DMA buffer to the audio
backend. The BH routine then immediately reschedules itself. As far
fewer samples are required from the backend than the BH routine can
supply, this means that most of the BH routine calls don't copy any
audio samples. The buffers of the audio backend are simply full.
This is a very inefficient design.

Use the DREQ signal of the ISA DMA controller to throttle the audio
stream. The callback routine of the audio subsystem raises the DREQ
signal as soon as new samples are needed and also starts the DMA
callback routine.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/469
Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/sb16.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index 5c51940596..714144eb61 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -200,7 +200,9 @@ static void control (SB16State *s, int hold)
     ldebug("hold %d high %d nchan %d\n", hold, s->use_hdma, nchan);
 
     if (hold) {
-        hold_DREQ(s, nchan);
+        if (!s->voice) {
+            hold_DREQ(s, nchan);
+        }
         AUD_set_active_out (s->voice, 1);
     }
     else {
@@ -890,6 +892,8 @@ static void legacy_reset (SB16State *s)
     s->fmt_bits = 8;
     s->fmt_stereo = 0;
 
+    s->audio_free = 0;
+
     as.freq = s->freq;
     as.nchannels = 1;
     as.fmt = AUDIO_FORMAT_U8;
@@ -1243,8 +1247,12 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     }
 
     if (s->voice) {
+        if (!dma_len) {
+            return dma_pos;
+        }
         free = s->audio_free & ~s->align;
-        if ((free <= 0) || !dma_len) {
+        if (free <= 0) {
+            release_DREQ(s, nchan);
             return dma_pos;
         }
     }
@@ -1269,6 +1277,7 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
     written = write_audio (s, nchan, dma_pos, dma_len, copy);
     dma_pos = (dma_pos + written) % dma_len;
     s->left_till_irq -= written;
+    s->audio_free -= written;
 
     if (s->left_till_irq <= 0) {
         s->mixer_regs[0x82] |= (nchan & 4) ? 2 : 1;
@@ -1289,13 +1298,23 @@ static int SB_read_DMA (void *opaque, int nchan, int dma_pos, int dma_len)
         s->left_till_irq = s->block_size + s->left_till_irq;
     }
 
+    if (s->voice) {
+        free = s->audio_free & ~s->align;
+        if (free <= 0) {
+            release_DREQ(s, nchan);
+        }
+    }
     return dma_pos;
 }
 
 static void SB_audio_callback (void *opaque, int free)
 {
     SB16State *s = opaque;
+    int nchan = s->use_hdma ? s->hdma : s->dma;
+
     s->audio_free = free;
+    /* run the DMA engine to call SB_read_DMA immediately */
+    hold_DREQ(s, nchan);
 }
 
 static int sb16_post_load (void *opaque, int version_id)
-- 
2.43.0


