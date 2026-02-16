Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8C9E7BD92
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:21:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfV-0007aW-7J; Mon, 16 Feb 2026 06:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwd3-0007Sp-UF
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwd1-0008Pv-62
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZPwP50pYxUr6MP+yYvCFJCeqAndqgUmshxGKnX4ZHc=;
 b=bY3/3rUoUuvd6WdNtEbpT3v9Z8APV4CV782cX9cOIuLcjkb5OkP2zcRUmU1L6alq7GnLxV
 MGjMFqr5XoRLRqgqJA8/7I16hXkvWArvzsZ2R9EWjvOHsL+kcbkeGpIQtfIkH8oQ2ZOPP/
 Z+ThBY1Wq7J60/Ss3UhEm4SDN/Bwe64=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-8W2w716eMz2pe1Ymxx73KA-1; Mon,
 16 Feb 2026 06:18:54 -0500
X-MC-Unique: 8W2w716eMz2pe1Ymxx73KA-1
X-Mimecast-MFC-AGG-ID: 8W2w716eMz2pe1Ymxx73KA_1771240732
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD35C1956089; Mon, 16 Feb 2026 11:18:51 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 546601800464; Mon, 16 Feb 2026 11:18:51 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:58 +0100
Subject: [PATCH 69/85] audio/sndio: replace custom logging with
 error_report
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-69-e676662e4514@redhat.com>
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
 Thomas Huth <thuth@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3292;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=8yW9wJ3mIfAWUvsc6PEfigNiDWoTGEQkRlzr3mI/fbs=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGmS/FGj/RWAwCaalX3Sad3mihLN/7gHO9AimlvuTKXg6QHZW
 IkCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJpkvxRAAoJENro4Ql1lpzlf+AP/0Hf
 9dfWzN4T09rWtuvAlg1E/wN4VBXt0eI3AatGe5dpxfHfpDTW8Gf1zggK5Qx7mNMyI2KMJUJJwDM
 UTXQ5P7Y1Ic6ZXnEpfdCb/DIJl1Pf4YrGcItguC5V5aOoi6PpjZEwfDnotJRPyJkJDNYJEnYpdR
 zfkd7dVkVSrWfN3NU91ql4qSJgp/0p1qvHeUeLCtzdqux6NUiyT8QQqLfHnuRlf+hKXDP3qeLoS
 H/jylL1pNwpj86uuWs/d6zo2+SzI/X+ZV+tk7rzB1h5g7xiBYY//U7iKMsOf5JD/R/URdsKG74C
 kUavivCFGwenRs38C5IdjZA14Ux520EYvlipOUd3D77am1d5fmsZk7VWCfwMZF0b121LJ/ubwSw
 dovC0BR2Xzu1tigP7BYQQDg38dCLxtuhXICuOFeraMJrFRI0jRJiB/DJdgMEEI1D4lT8EiXu9Vo
 raL2REVIggU7YvUbB3aDVdFObTivxJhssArngKrEvUeKRPiBT2ZcJoAxgNyCJktyqir1hwkMECW
 QViUnBOFVaoQM+dhnK9XO9bIKTGS1NyXSbK9dNJsoolFyJxjLuRDat5U9DawIKfxrEfMuLsJV9A
 tEQq8fWxNIhZBtdRnSOPAiSxCgExnHzhM+ZtloJ6Ya8IELrwEcQrij7HcUyjD5CqQg9DXM41f3b
 U0XhE
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 audio/sndioaudio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index 21f43836fd1..766eceeeefe 100644
--- a/audio/sndioaudio.c
+++ b/audio/sndioaudio.c
@@ -18,12 +18,12 @@
 #include <poll.h>
 #include <sndio.h>
 #include "qemu/main-loop.h"
+#include "qemu/error-report.h"
 #include "qemu/audio.h"
-#include "trace.h"
 #include "qom/object.h"
 
-#define AUDIO_CAP "sndio"
 #include "audio_int.h"
+#include "trace.h"
 
 #define TYPE_AUDIO_SNDIO "audio-sndio"
 OBJECT_DECLARE_SIMPLE_TYPE(AudioSndio, AUDIO_SNDIO)
@@ -348,7 +348,7 @@ static int sndio_init(SndioVoice *self,
     /* open the device in non-blocking mode */
     self->hdl = sio_open(dev_name, mode, 1);
     if (self->hdl == NULL) {
-        dolog("failed to open device\n");
+        error_report("sndio: failed to open device");
         return -1;
     }
 
@@ -382,7 +382,7 @@ static int sndio_init(SndioVoice *self,
         req.sig = 0;
         break;
     default:
-        dolog("unknown audio sample format\n");
+        error_report("sndio: unknown audio sample format");
         return -1;
     }
 
@@ -401,12 +401,12 @@ static int sndio_init(SndioVoice *self,
     req.appbufsz = req.rate * latency / 1000000;
 
     if (!sio_setpar(self->hdl, &req)) {
-        dolog("failed set audio params\n");
+        error_report("sndio: failed to set audio params");
         goto fail;
     }
 
     if (!sio_getpar(self->hdl, &self->par)) {
-        dolog("failed get audio params\n");
+        error_report("sndio: failed to get audio params");
         goto fail;
     }
 
@@ -419,7 +419,7 @@ static int sndio_init(SndioVoice *self,
     if (self->par.bits != req.bits || self->par.bps != req.bits / 8 ||
         self->par.sig != req.sig || (req.bits > 8 && self->par.le != req.le) ||
         self->par.rate != as->freq || nch != as->nchannels) {
-        dolog("unsupported audio params\n");
+        error_report("sndio: unsupported audio params");
         goto fail;
     }
 
@@ -431,7 +431,7 @@ static int sndio_init(SndioVoice *self,
 
     self->buf = g_malloc(self->buf_size);
     if (self->buf == NULL) {
-        dolog("failed to allocate audio buffer\n");
+        error_report("sndio: failed to allocate audio buffer");
         goto fail;
     }
 
@@ -439,13 +439,13 @@ static int sndio_init(SndioVoice *self,
 
     self->pfds = g_malloc_n(nfds, sizeof(struct pollfd));
     if (self->pfds == NULL) {
-        dolog("failed to allocate pollfd structures\n");
+        error_report("sndio: failed to allocate pollfd structures");
         goto fail;
     }
 
     self->pindexes = g_malloc_n(nfds, sizeof(struct pollindex));
     if (self->pindexes == NULL) {
-        dolog("failed to allocate pollindex structures\n");
+        error_report("sndio: failed to allocate pollindex structures");
         goto fail;
     }
 

-- 
2.53.0


