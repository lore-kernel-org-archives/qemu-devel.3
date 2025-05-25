Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84334C54E90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 May 2025 13:29:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJBOP-0007bj-Gy; Sun, 25 May 2025 09:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBON-0007ZY-2U
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1uJBOL-0003MN-1y
 for qemu-devel@nongnu.org; Sun, 25 May 2025 09:27:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748179672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uGQQjmsFQDOZCLUWla4tbc9wwaNUFpGpLEggjyCxOWY=;
 b=gzODGqx79j/u2HMGuBccj8acf6D8l9dfmPEaUziCZnwPRRnn+kIVo1Sq2I3I7e6SlCZZVb
 rxijbGj/knjue0fEfBTtS0QVIFF8pSof6ollUytoWIjQsBf6J8AM2XIqsTv3wJLAtEp5W6
 b29cIAQ+JaQGbj08YDZhTezPCdVaXGA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-cOcm32kANVOAQcg5ACGA_A-1; Sun,
 25 May 2025 09:27:48 -0400
X-MC-Unique: cOcm32kANVOAQcg5ACGA_A-1
X-Mimecast-MFC-AGG-ID: cOcm32kANVOAQcg5ACGA_A_1748179667
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 131E61800446; Sun, 25 May 2025 13:27:47 +0000 (UTC)
Received: from localhost (unknown [10.45.242.5])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 763B719560AF; Sun, 25 May 2025 13:27:45 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PULL 8/9] alsaaudio: Set try-poll to false by default
Date: Sun, 25 May 2025 15:27:15 +0200
Message-ID: <20250525132717.527392-9-marcandre.lureau@redhat.com>
In-Reply-To: <20250525132717.527392-1-marcandre.lureau@redhat.com>
References: <20250525132717.527392-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -59
X-Spam_score: -6.0
X-Spam_bar: ------
X-Spam_report: (-6.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

From: BALATON Zoltan <balaton@eik.bme.hu>

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
Acked-by: Marc-André Lureau <marcandre.lureau@redhat.com>
[ Marc-André - Updated QAPI and CLI doc ]
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250316002046.D066A4E6004@zero.eik.bme.hu>
---
 qapi/audio.json   | 2 +-
 audio/alsaaudio.c | 2 +-
 qemu-options.hx   | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/audio.json b/qapi/audio.json
index dd5a58d13e..49633cf317 100644
--- a/qapi/audio.json
+++ b/qapi/audio.json
@@ -96,7 +96,7 @@
 # @period-length: the period length in microseconds
 #
 # @try-poll: attempt to use poll mode, falling back to non-polling
-#     access on failure (default true)
+#     access on failure (default false)
 #
 # Since: 4.0
 ##
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
diff --git a/qemu-options.hx b/qemu-options.hx
index aab53bcfe8..7eb8e02b4b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -965,7 +965,7 @@ SRST
         Sets the period length in microseconds.
 
     ``in|out.try-poll=on|off``
-        Attempt to use poll mode with the device. Default is on.
+        Attempt to use poll mode with the device. Default is off.
 
     ``threshold=threshold``
         Threshold (in microseconds) when playback starts. Default is 0.
@@ -1002,7 +1002,7 @@ SRST
     ``in|out.buffer-count=count``
         Sets the count of the buffers.
 
-    ``in|out.try-poll=on|of``
+    ``in|out.try-poll=on|off``
         Attempt to use poll mode with the device. Default is on.
 
     ``try-mmap=on|off``
-- 
2.49.0


