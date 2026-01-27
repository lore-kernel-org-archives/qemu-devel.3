Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E76FD2FED4
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:35:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vknp5-0003bT-61; Tue, 27 Jan 2026 13:29:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknnQ-0008RW-W2
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vknnP-0003M0-BD
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769538490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReNyxfS/w4yJD8swiQpRIsDZn0gx2m9kwhO585AUjpQ=;
 b=UC4ktU+IWn4iS6PC38KqSLi2JZWKNNTDGEtJUhz5aJPsXmxFICYRNDzOz83BxGdZHPI7Ie
 3qHIyzbXRLhyGuuPP61v48Qzq2XH+YPS+LUsYtoYwUsHwOJd8rrpkawBNPrjZsci4GMg6p
 88mZoVpWyCvZZiH5GkN+zOHeQ1IhUgM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-RtjzGYRONqm3O5sf1tEBiQ-1; Tue,
 27 Jan 2026 13:28:08 -0500
X-MC-Unique: RtjzGYRONqm3O5sf1tEBiQ-1
X-Mimecast-MFC-AGG-ID: RtjzGYRONqm3O5sf1tEBiQ_1769538487
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3D2418002C2; Tue, 27 Jan 2026 18:28:07 +0000 (UTC)
Received: from localhost (unknown [10.45.242.23])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D0C8730002D6; Tue, 27 Jan 2026 18:28:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Ratchov <alex@caoua.org>
Subject: [PATCH 28/43] audio/sndio: replace custom logging with error_report
Date: Tue, 27 Jan 2026 22:24:55 +0400
Message-ID: <20260127182516.289834-29-marcandre.lureau@redhat.com>
In-Reply-To: <20260127182516.289834-1-marcandre.lureau@redhat.com>
References: <20260127182516.289834-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/sndioaudio.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/audio/sndioaudio.c b/audio/sndioaudio.c
index bc62f670a33..be491895532 100644
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
2.52.0


