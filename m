Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336A3C369CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:42:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LlD-0007k1-CN; Thu, 17 Apr 2025 05:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u5Ll9-0007dg-E3
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:42:16 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u5Ll7-0007xF-Bl
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:42:15 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22435603572so5923305ad.1
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 02:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1744882931; x=1745487731;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CJoboHjY6J+jdcgbJlQKuZWK2SjqrcVgmsi0cNijwro=;
 b=pPSbt1yWWep+U2iuYUU7AZ+ir5Al7huE9NuorQmyNTmJl+0FKyqzheAB9iQ7Aq1i13
 d0PeSV8TDJEiiTAAebr2XRL385TiK08l+gXeLKJLdq+/Op69sQ3dkvg4cWHk8AS0UV9O
 y1cZQBypmVEWFNKolNNLVzBGbeoymYis4v/f0VgCOijtHOGpffPEVYcNRkpS9aLzczAn
 Yt2XXx/NzA7RNQf/EGP43m/x4u/yGQ21NEqVKsTbPYPbf/xVG9uvw1rzNvd+GqdCqUsb
 DIRgvIUmp8kJNGWPQM1wv5jkOS/6dEpRXSqvzn4lcZe9q/N7UgLqv7p9EtLZG/rkOx8f
 B7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744882931; x=1745487731;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CJoboHjY6J+jdcgbJlQKuZWK2SjqrcVgmsi0cNijwro=;
 b=TZQV/1WaGHm9Kh2wbzw9BsWJco4Gj4DBkhdX7CqmC0E+RLlRLCL9UP7qI7ZxnD4BcH
 qxzIMZfozu7iiJSQKozbh9Aij79Vi/XPy1d4BI6X7/5x1lU8iSNFDE4UPmyzho1oH4vi
 qxz0Dv905FGcIKiNzLAwr0BXit5A1aKSv5t5pNu6/sgz9Y80rBZS3jEv0qDKkbr30P0j
 VnkUHgnT4SX73cn9aVDJjWEB5cBLXuaGeblXnPK2NMvOV5YWILHIMRs8pvo0Msq74zu1
 a+voofdmsd5waPmsjLh35CSjWEE3KjAQmexXjr8GrjFqbQLSm4JFDyZyzX/jw5rV/yFB
 O8ug==
X-Gm-Message-State: AOJu0YyG5/dma6Q/1vdsc8/jrLqPo1slWPkyOgNAP/KlKvygn43uk4dB
 njyDmOuuD7lbfx+XIHze3QjpPD7a29d2e3BrJdbko+o0VROi2lO7UA0IBPVXt7fNvQ9GXdfKm2O
 W+/k=
X-Gm-Gg: ASbGncuchKf+flIbYH1u62HCJnor+o3/YqHbezUPN5CQhlacnogEHFzTOFk26dGBDvI
 XNpuqLbSQJxUF0m9k40EbQi6IvTYq2yor6oq0Z5zuO+McIrr5TsoLMwhtmuj/ZefOtciSDqcqbc
 I57cGNhthXSNQgw59dW4b4xJlzwOv8R6cqmc7IjkmrZNuZhnnIB92Ub/9tq5VYSCMqV8tcR0Nak
 T9P4/zeAFvTJrwyAxmNvrDbTZnc4bWx7xAAydpXEMT+WS3kHRMB1zXAZZvbLjXBU70ShjKj8byp
 xe6QaA5U2v5SOgNnit0TTzdorHkd8pSYPjfJ9fCAgf4wzK9NqCVthrflAw==
X-Google-Smtp-Source: AGHT+IFPKpVZ7B6Q+BslnifdAlqBMI/sddIoY1J+TEctzVr3eF8QK49v8kuJgaaYXmsLslVrdjhATA==
X-Received: by 2002:a17:902:f68b:b0:211:e812:3948 with SMTP id
 d9443c01a7336-22c3579bae9mr84711395ad.0.1744882931337; 
 Thu, 17 Apr 2025 02:42:11 -0700 (PDT)
Received: from localhost ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-73bd21e1957sm11841296b3a.78.2025.04.17.02.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 02:42:11 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Thu, 17 Apr 2025 18:42:01 +0900
Subject: [PATCH 2/2] ui/vnc: Do not copy z_stream
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250417-zlib-v1-2-34fad73b843b@daynix.com>
References: <20250417-zlib-v1-0-34fad73b843b@daynix.com>
In-Reply-To: <20250417-zlib-v1-0-34fad73b843b@daynix.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 devel@daynix.com, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

vnc_worker_thread_loop() copies z_stream stored in its local VncState to
the persistent VncState, and the copied one is freed with deflateEnd()
later. However, deflateEnd() refuses to operate with a copied z_stream
and returns Z_STREAM_ERROR, leaking the allocated memory.

Avoid copying the zlib state to fix the memory leak.

Fixes: bd023f953e5e ("vnc: threaded VNC server")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 ui/vnc.h          |  2 +-
 ui/vnc-enc-zlib.c | 30 +++++++++++++++---------------
 ui/vnc-jobs.c     |  2 --
 ui/vnc.c          |  2 +-
 4 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 1dc76c270c35..78a5fdfdc0d0 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -265,6 +265,7 @@ typedef struct VncWorker {
     uint8_t lossy_rect[VNC_STAT_ROWS][VNC_STAT_COLS];
 
     VncTight tight;
+    VncZlib zlib;
     VncZrle zrle;
 } VncWorker;
 
@@ -345,7 +346,6 @@ struct VncState
     /* Encoding specific, if you add something here, don't forget to
      *  update vnc_async_encoding_start()
      */
-    VncZlib zlib;
     VncHextile hextile;
     VncZywrle zywrle;
 
diff --git a/ui/vnc-enc-zlib.c b/ui/vnc-enc-zlib.c
index 605030730a44..d8b4cf038b02 100644
--- a/ui/vnc-enc-zlib.c
+++ b/ui/vnc-enc-zlib.c
@@ -48,21 +48,21 @@ void vnc_zlib_zfree(void *x, void *addr)
 
 static void vnc_zlib_start(VncState *vs)
 {
-    buffer_reset(&vs->zlib.zlib);
+    buffer_reset(&vs->worker->zlib.zlib);
 
     // make the output buffer be the zlib buffer, so we can compress it later
-    vs->zlib.tmp = vs->output;
-    vs->output = vs->zlib.zlib;
+    vs->worker->zlib.tmp = vs->output;
+    vs->output = vs->worker->zlib.zlib;
 }
 
 static int vnc_zlib_stop(VncState *vs)
 {
-    z_streamp zstream = &vs->zlib.stream;
+    z_streamp zstream = &vs->worker->zlib.stream;
     int previous_out;
 
     // switch back to normal output/zlib buffers
-    vs->zlib.zlib = vs->output;
-    vs->output = vs->zlib.tmp;
+    vs->worker->zlib.zlib = vs->output;
+    vs->output = vs->worker->zlib.tmp;
 
     // compress the zlib buffer
 
@@ -85,24 +85,24 @@ static int vnc_zlib_stop(VncState *vs)
             return -1;
         }
 
-        vs->zlib.level = vs->worker->tight.compression;
+        vs->worker->zlib.level = vs->worker->tight.compression;
         zstream->opaque = vs;
     }
 
-    if (vs->worker->tight.compression != vs->zlib.level) {
+    if (vs->worker->tight.compression != vs->worker->zlib.level) {
         if (deflateParams(zstream, vs->worker->tight.compression,
                           Z_DEFAULT_STRATEGY) != Z_OK) {
             return -1;
         }
-        vs->zlib.level = vs->worker->tight.compression;
+        vs->worker->zlib.level = vs->worker->tight.compression;
     }
 
     // reserve memory in output buffer
-    buffer_reserve(&vs->output, vs->zlib.zlib.offset + 64);
+    buffer_reserve(&vs->output, vs->worker->zlib.zlib.offset + 64);
 
     // set pointers
-    zstream->next_in = vs->zlib.zlib.buffer;
-    zstream->avail_in = vs->zlib.zlib.offset;
+    zstream->next_in = vs->worker->zlib.zlib.buffer;
+    zstream->avail_in = vs->worker->zlib.zlib.offset;
     zstream->next_out = vs->output.buffer + vs->output.offset;
     zstream->avail_out = vs->output.capacity - vs->output.offset;
     previous_out = zstream->avail_out;
@@ -147,8 +147,8 @@ int vnc_zlib_send_framebuffer_update(VncState *vs, int x, int y, int w, int h)
 
 void vnc_zlib_clear(VncState *vs)
 {
-    if (vs->zlib.stream.opaque) {
-        deflateEnd(&vs->zlib.stream);
+    if (vs->worker->zlib.stream.opaque) {
+        deflateEnd(&vs->worker->zlib.stream);
     }
-    buffer_free(&vs->zlib.zlib);
+    buffer_free(&vs->worker->zlib.zlib);
 }
diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index d019d88536b7..dbbf62212c79 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -189,7 +189,6 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
     local->write_pixels = orig->write_pixels;
     local->client_pf = orig->client_pf;
     local->client_be = orig->client_be;
-    local->zlib = orig->zlib;
     local->hextile = orig->hextile;
     local->client_width = orig->client_width;
     local->client_height = orig->client_height;
@@ -198,7 +197,6 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
     buffer_free(&local->output);
-    orig->zlib = local->zlib;
     orig->hextile = local->hextile;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index ce0538f3654f..2203312fcbc9 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3260,7 +3260,7 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
 #ifdef CONFIG_PNG
     buffer_init(&vs->worker->tight.png,      "vnc-tight-png/%p", sioc);
 #endif
-    buffer_init(&vs->zlib.zlib,              "vnc-zlib/%p", sioc);
+    buffer_init(&vs->worker->zlib.zlib,      "vnc-zlib/%p", sioc);
     buffer_init(&vs->worker->zrle.zrle,      "vnc-zrle/%p", sioc);
     buffer_init(&vs->worker->zrle.fb,        "vnc-zrle-fb/%p", sioc);
     buffer_init(&vs->worker->zrle.zlib,      "vnc-zrle-zlib/%p", sioc);

-- 
2.49.0


