Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B58C3ABC5
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 07:40:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uE1H5-0005IZ-4L; Sun, 11 May 2025 03:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uE1H3-0005Hu-2T
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:39:01 -0400
Received: from mailout07.t-online.de ([194.25.134.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <volker.ruemelin@t-online.de>)
 id 1uE1H1-00043M-AH
 for qemu-devel@nongnu.org; Sun, 11 May 2025 03:39:00 -0400
Received: from fwd74.aul.t-online.de (fwd74.aul.t-online.de [10.223.144.100])
 by mailout07.t-online.de (Postfix) with SMTP id 8D99B81E;
 Sun, 11 May 2025 09:38:57 +0200 (CEST)
Received: from linpower.localnet ([84.175.230.13]) by fwd74.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1uE1Gw-0irikL0; Sun, 11 May 2025 09:38:54 +0200
Received: by linpower.localnet (Postfix, from userid 1000)
 id 0CF6D200361; Sun, 11 May 2025 09:38:47 +0200 (CEST)
From: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/7] hw/audio/asc: fix SIGSEGV in asc_realize()
Date: Sun, 11 May 2025 09:38:43 +0200
Message-ID: <20250511073846.8713-4-vr_qemu@t-online.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <d456c188-0463-4dc2-9178-469f840eaebe@t-online.de>
References: <d456c188-0463-4dc2-9178-469f840eaebe@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1746949134-EF7FC541-AE128503/0/0 CLEAN NORMAL
X-TOI-MSGID: 0f014ad2-e2a8-4523-b773-b06d66c2ebdc
Received-SPF: pass client-ip=194.25.134.83;
 envelope-from=volker.ruemelin@t-online.de; helo=mailout07.t-online.de
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
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

AUD_open_out() may fail and return NULL. This may then lead to
a segmentation fault in memset() below. The memset() behaviour
is undefined if the pointer to the destination object is a null
pointer.

Add the missing error handling code.

Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
---
 hw/audio/asc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index 18382ccf6a..03dee0fcc7 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
+#include "qapi/error.h"
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "audio/audio.h"
@@ -653,6 +654,12 @@ static void asc_realize(DeviceState *dev, Error **errp)
 
     s->voice = AUD_open_out(&s->card, s->voice, "asc.out", s, asc_out_cb,
                             &as);
+    if (!s->voice) {
+        asc_unrealize(dev);
+        error_setg(errp, "Initializing audio stream failed");
+        return;
+    }
+
     s->shift = 1;
     s->samples = AUD_get_buffer_size_out(s->voice) >> s->shift;
     s->mixbuf = g_malloc0(s->samples << s->shift);
-- 
2.43.0


