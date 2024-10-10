Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B44CF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHf-0006Rx-95; Thu, 10 Oct 2024 06:20:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHd-0006Qz-6p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:37 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHb-0003Xx-1p
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:36 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-539885dd4bcso958599e87.0
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555633; x=1729160433; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G7795s3+Tby/c7sooRXSohBfy29e7ZGsDck71B2OYAg=;
 b=S87rCP/f/JIWDEFuxV1gPoFQ1yi9sLWFcdFLlOsH2M7F+aaGLIs5GjFavGQw8JfBcC
 LR3JJezeAG+i/hJQS2K3ASIj/NZzCSRltpNlq+MUGjJPd9hapVCDVwNuzsmd53TXogmk
 S97iNKW3FPJ2RUyE4RfoItVZMp5AWPO8HnbuO5jV0aECQ8dx3ukQjiDdSFZdiNPuyoaU
 KyVUbH4quASRfHgVLHHZWy3bMXbqjNOye3Yay5uDZQAn5Z003TfGdE0l0AhhdDn7+ECy
 67oqt1I4Bq/52vLCX8oO6G3COlCO/oMoVPEuojNiS/aRmKaPvSbyR0WU7J3rFJEGivTO
 p0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555633; x=1729160433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G7795s3+Tby/c7sooRXSohBfy29e7ZGsDck71B2OYAg=;
 b=NSE2Ik4qQckI0Gkah/2sreGBNBkxp4XhkPQGCIWYIiv5WT69won0ph9cR443XbU/N3
 L5o+nMc3a8OswYsEbkgMhEd/9exdZJwcD92QT3o6CXaAlIaWVx0VlWzTFgeKhhvY0PxR
 OrAh/GvXE5ZBXG1V4WWrb7/73VJi97Vjmu6fJYUxc5DVd/8E2yMsyPbDFi6FoxU/Nt+o
 cFAgRFVus7vy2G5qvUIAvIRnZr3lkBKkKHB47rl+InwPjtT8TFKV2rhqk7ruaSghNCh7
 LRqTA0ioSsjfr7igzgJrflMADzIFY9mp8A22nyiu0GRZU/TWj0BOsXmIg4ATb97h8rm+
 +0GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOypc0AIm/2I8M+yTl5vYVoL8nWgmAWoUovrVrjVT73CdUAArd7sE/e3I/mPXMGZtZaboBWrXCXOxp@nongnu.org
X-Gm-Message-State: AOJu0YzeIfUPOjTjXT+zmBtDwuQhRVsUYYwFFkTLINckiZeCScooGj+0
 4JAcZjWTaI77nTvMrcpxQfzPYHRTpIDgX+/iu26mPyPgDDIdoo8x
X-Google-Smtp-Source: AGHT+IFrtRXZztqCU344Sc+aoTtin1a2jZRYj2vvmCXWshIQc0iuENuUifSJeZjxeesWbjJR/kuWYg==
X-Received: by 2002:a05:6512:1244:b0:539:9092:809e with SMTP id
 2adb3069b0e04-539c49691a8mr3686387e87.50.1728555632912; 
 Thu, 10 Oct 2024 03:20:32 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2436fsm68240266b.53.2024.10.10.03.20.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 03:20:32 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/7] chardev/char: rename frontend mux calls
Date: Thu, 10 Oct 2024 12:18:34 +0200
Message-Id: <20241010101838.331032-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010101838.331032-1-r.peniaev@gmail.com>
References: <20241010101838.331032-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

This patch renames calls in the frontend mux implementation
to reflect its frontend nature. Patch does the following:

  s/mux_chr/mux_fe_chr/g

No functional changes are made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux-fe.c | 57 ++++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 28 deletions(-)

diff --git a/chardev/char-mux-fe.c b/chardev/char-mux-fe.c
index cd9ff0c5dc12..5a8860b4310e 100644
--- a/chardev/char-mux-fe.c
+++ b/chardev/char-mux-fe.c
@@ -34,7 +34,7 @@
 /* MUX driver for serial I/O splitting */
 
 /* Called with chr_write_lock held.  */
-static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
+static int mux_fe_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int ret;
@@ -117,7 +117,8 @@ static void mux_print_help(Chardev *chr)
     }
 }
 
-static void mux_chr_send_event(MuxFeChardev *d, int mux_nr, QEMUChrEvent event)
+static void mux_fe_chr_send_event(MuxFeChardev *d, int mux_nr,
+                                  QEMUChrEvent event)
 {
     CharBackend *be = d->backends[mux_nr];
 
@@ -126,12 +127,12 @@ static void mux_chr_send_event(MuxFeChardev *d, int mux_nr, QEMUChrEvent event)
     }
 }
 
-static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
+static void mux_fe_chr_be_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     if (d->focus != -1) {
-        mux_chr_send_event(d, d->focus, event);
+        mux_fe_chr_send_event(d, d->focus, event);
     }
 }
 
@@ -180,7 +181,7 @@ static int mux_proc_byte(Chardev *chr, MuxFeChardev *d, int ch)
     return 0;
 }
 
-static void mux_chr_accept_input(Chardev *chr)
+static void mux_fe_chr_accept_input(Chardev *chr)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int m = d->focus;
@@ -193,7 +194,7 @@ static void mux_chr_accept_input(Chardev *chr)
     }
 }
 
-static int mux_chr_can_read(void *opaque)
+static int mux_fe_chr_can_read(void *opaque)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(opaque);
     int m = d->focus;
@@ -210,7 +211,7 @@ static int mux_chr_can_read(void *opaque)
     return 0;
 }
 
-static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
+static void mux_fe_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     Chardev *chr = CHARDEV(opaque);
     MuxFeChardev *d = MUX_FE_CHARDEV(opaque);
@@ -218,7 +219,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
     CharBackend *be = d->backends[m];
     int i;
 
-    mux_chr_accept_input(opaque);
+    mux_fe_chr_accept_input(opaque);
 
     for (i = 0; i < size; i++)
         if (mux_proc_byte(chr, d, buf[i])) {
@@ -238,16 +239,16 @@ void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event)
 
     /* Send the event to all registered listeners */
     for (i = 0; i < d->mux_cnt; i++) {
-        mux_chr_send_event(d, i, event);
+        mux_fe_chr_send_event(d, i, event);
     }
 }
 
-static void mux_chr_event(void *opaque, QEMUChrEvent event)
+static void mux_fe_chr_event(void *opaque, QEMUChrEvent event)
 {
     mux_chr_send_all_event(CHARDEV(opaque), event);
 }
 
-static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
+static GSource *mux_fe_chr_add_watch(Chardev *s, GIOCondition cond)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(s);
     Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
@@ -260,7 +261,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
     return cc->chr_add_watch(chr, cond);
 }
 
-static void char_mux_finalize(Object *obj)
+static void char_mux_fe_finalize(Object *obj)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(obj);
     int i;
@@ -274,15 +275,15 @@ static void char_mux_finalize(Object *obj)
     qemu_chr_fe_deinit(&d->chr, false);
 }
 
-static void mux_chr_update_read_handlers(Chardev *chr)
+static void mux_fe_chr_update_read_handlers(Chardev *chr)
 {
     MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers_full(&d->chr,
-                                  mux_chr_can_read,
-                                  mux_chr_read,
-                                  mux_chr_event,
+                                  mux_fe_chr_can_read,
+                                  mux_fe_chr_read,
+                                  mux_fe_chr_event,
                                   NULL,
                                   chr,
                                   chr->gcontext, true, false);
@@ -296,12 +297,12 @@ void mux_set_focus(Chardev *chr, int focus)
     assert(focus < d->mux_cnt);
 
     if (d->focus != -1) {
-        mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
+        mux_fe_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
     }
 
     d->focus = focus;
     chr->be = d->backends[focus];
-    mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
+    mux_fe_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
 static void qemu_chr_open_mux(Chardev *chr,
@@ -343,30 +344,30 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
-static void char_mux_class_init(ObjectClass *oc, void *data)
+static void char_mux_fe_class_init(ObjectClass *oc, void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
 
     cc->parse = qemu_chr_parse_mux;
     cc->open = qemu_chr_open_mux;
-    cc->chr_write = mux_chr_write;
-    cc->chr_accept_input = mux_chr_accept_input;
-    cc->chr_add_watch = mux_chr_add_watch;
-    cc->chr_be_event = mux_chr_be_event;
-    cc->chr_update_read_handler = mux_chr_update_read_handlers;
+    cc->chr_write = mux_fe_chr_write;
+    cc->chr_accept_input = mux_fe_chr_accept_input;
+    cc->chr_add_watch = mux_fe_chr_add_watch;
+    cc->chr_be_event = mux_fe_chr_be_event;
+    cc->chr_update_read_handler = mux_fe_chr_update_read_handlers;
 }
 
-static const TypeInfo char_mux_type_info = {
+static const TypeInfo char_mux_fe_type_info = {
     .name = TYPE_CHARDEV_MUX_FE,
     .parent = TYPE_CHARDEV,
-    .class_init = char_mux_class_init,
+    .class_init = char_mux_fe_class_init,
     .instance_size = sizeof(MuxFeChardev),
-    .instance_finalize = char_mux_finalize,
+    .instance_finalize = char_mux_fe_finalize,
 };
 
 static void register_types(void)
 {
-    type_register_static(&char_mux_type_info);
+    type_register_static(&char_mux_fe_type_info);
 }
 
 type_init(register_types);
-- 
2.34.1


