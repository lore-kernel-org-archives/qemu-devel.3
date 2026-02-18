Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA88EE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsdXH-00020W-2W; Wed, 18 Feb 2026 04:07:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdWV-0000iZ-NB
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vsdWS-0002Qn-Nc
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:07:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771405624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sjruiADZLPP8r0KetuQzZJsFWpLAik5UDokSmcYCF4s=;
 b=RaAzuwp5yAXW36ySbL7JikyVkBX4vRynZD1kateQeeKs8wgR2qRS7PQIvR5QW8yFFBE75y
 YhMvwG7F6CE+hjSWHa3jkXn3ewW9oD1U4KASB2pHHvsJmplh9laqnraA/qv/8bv5TpA25E
 l0/Z+rTOnQWbu1Yhiv8znjI86qtkXSI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-NHEkdn9-MUufyGRcEunZeA-1; Wed,
 18 Feb 2026 04:07:02 -0500
X-MC-Unique: NHEkdn9-MUufyGRcEunZeA-1
X-Mimecast-MFC-AGG-ID: NHEkdn9-MUufyGRcEunZeA_1771405621
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1B6AA1956067; Wed, 18 Feb 2026 09:07:01 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 28F0B19560AD; Wed, 18 Feb 2026 09:06:59 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Alexandre Ratchov <alex@caoua.org>
Subject: [PULL 69/85] audio/sndio: replace custom logging with error_report
Date: Wed, 18 Feb 2026 10:03:09 +0100
Message-ID: <20260218090330.1476169-70-marcandre.lureau@redhat.com>
In-Reply-To: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
References: <20260218090330.1476169-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Replace the custom audio logging infrastructure (dolog macro) with
standard QEMU error reporting (error_report).

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


