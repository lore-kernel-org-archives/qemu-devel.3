Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE483C71130
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 19:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYrYN-0005e0-Jz; Mon, 07 Jul 2025 15:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uYrXd-0005Nx-CS
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:30:22 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uYrXa-0005Nx-Jr
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 15:30:16 -0400
Received: from fwd75.aul.t-online.de (fwd75.aul.t-online.de [10.223.144.101])
 by mailout07.t-online.de (Postfix) with SMTP id 4D07FE368;
 Mon,  7 Jul 2025 21:30:10 +0200 (CEST)
Received: from linpower.localnet ([93.236.150.188]) by fwd75.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uYrXV-3wDd2H0; Mon, 7 Jul 2025 21:30:09 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 7DDDF200361; Mon,  7 Jul 2025 21:30:09 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/audio/sb16: introduce DMA helper functions
Date: Mon,  7 Jul 2025 21:30:07 +0200
Message-ID: <20250707193009.12901-1-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
References: <48576e83-54ba-4ebd-8a3e-6b8306655483@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1751916609-5D7F84D5-16BDC014/0/0 CLEAN NORMAL
X-TOI-MSGID: 0a6436af-4c1c-4d1d-9060-dd868c3af84c
Received-SPF: pass client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
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

Introduce the hold_DREQ() and release_DREQ() functions to ease
the review of the next patch.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/sb16.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/audio/sb16.c b/hw/audio/sb16.c
index bac64118fe..5c51940596 100644
--- a/hw/audio/sb16.c
+++ b/hw/audio/sb16.c
@@ -154,6 +154,22 @@ static int irq_of_magic (int magic)
     }
 }
 
+static void hold_DREQ(SB16State *s, int nchan)
+{
+    IsaDma *isa_dma = nchan == s->dma ? s->isa_dma : s->isa_hdma;
+    IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
+
+    k->hold_DREQ(isa_dma, nchan);
+}
+
+static void release_DREQ(SB16State *s, int nchan)
+{
+    IsaDma *isa_dma = nchan == s->dma ? s->isa_dma : s->isa_hdma;
+    IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
+
+    k->release_DREQ(isa_dma, nchan);
+}
+
 #if 0
 static void log_dsp (SB16State *dsp)
 {
@@ -177,19 +193,18 @@ static void speaker (SB16State *s, int on)
 
 static void control (SB16State *s, int hold)
 {
-    int dma = s->use_hdma ? s->hdma : s->dma;
-    IsaDma *isa_dma = s->use_hdma ? s->isa_hdma : s->isa_dma;
-    IsaDmaClass *k = ISADMA_GET_CLASS(isa_dma);
+    int nchan = s->use_hdma ? s->hdma : s->dma;
+
     s->dma_running = hold;
 
-    ldebug ("hold %d high %d dma %d\n", hold, s->use_hdma, dma);
+    ldebug("hold %d high %d nchan %d\n", hold, s->use_hdma, nchan);
 
     if (hold) {
-        k->hold_DREQ(isa_dma, dma);
+        hold_DREQ(s, nchan);
         AUD_set_active_out (s->voice, 1);
     }
     else {
-        k->release_DREQ(isa_dma, dma);
+        release_DREQ(s, nchan);
         AUD_set_active_out (s->voice, 0);
     }
 }
-- 
2.43.0


