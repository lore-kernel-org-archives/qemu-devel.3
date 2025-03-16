Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E711C28B28
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Mar 2025 00:21:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ttbkU-0004fq-49; Sat, 15 Mar 2025 20:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ttbkP-0004fH-Uc
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 20:20:58 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1ttbkN-0004uv-KR
 for qemu-devel@nongnu.org; Sat, 15 Mar 2025 20:20:57 -0400
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B99C44E6014;
 Sun, 16 Mar 2025 01:20:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id Ku5TAPA9U-Ie; Sun, 16 Mar 2025 01:20:46 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D066A4E6004; Sun, 16 Mar 2025 01:20:46 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] alsaaudio: Set try-poll to false by default
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Volker Ruemelin <vr_qemu@t-online.de>, Gerd Hoffmann <kraxel@redhat.com>
Message-Id: <20250316002046.D066A4E6004@zero.eik.bme.hu>
Date: Sun, 16 Mar 2025 01:20:46 +0100 (CET)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Quoting Volker Rümelin: "try-poll=on tells the ALSA backend to try to
use an event loop instead of the audio timer. This works most of the
time. But the poll event handler in the ALSA backend has a bug. For
example, if the guest can't provide enough audio frames in time, the
ALSA buffer is only partly full and the event handler will be called
again and again on every iteration of the main loop. This increases
the processor load and the guest has less processor time to provide
new audio frames in time. I have two examples where a guest can't
recover from this situation and the guest seems to hang."

One reproducer I've found is booting MorphOS demo iso on
qemu-system-ppc -machine pegasos2 -audio alsa which should play a
startup sound but instead it freezes. Even when it does not hang it
plays choppy sound. Volker suggested using command line to set
try-poll=off saying: "The try-poll=off arguments are typically
necessary, because the alsa backend has a design issue with
try-poll=on. If the guest can't provide enough audio frames, it's
really unhelpful to ask for new audio frames on every main loop
iteration until the guest can provide enough audio frames. Timer based
playback doesn't have that problem."

But users cannot easily find this option and having a non-working
default is really unhelpful so to make life easier just set it to
false by default which works until the issue with the alsa backend can
be fixed.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
This fixes my issue but if somebody has a better fix I'm open to that
too.

 audio/alsaaudio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index cacae1ea59..9b6c01c0ef 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -899,7 +899,7 @@ static void alsa_enable_in(HWVoiceIn *hw, bool enable)
 static void alsa_init_per_direction(AudiodevAlsaPerDirectionOptions *apdo)
 {
     if (!apdo->has_try_poll) {
-        apdo->try_poll = true;
+        apdo->try_poll = false;
         apdo->has_try_poll = true;
     }
 }
-- 
2.41.3


