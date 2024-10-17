Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A52BED374A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 14:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Rkz-0003Ux-RV; Thu, 17 Oct 2024 10:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rkx-0003Tf-6g
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:39 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t1Rku-0005cl-UE
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 10:45:38 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c984352742so1188671a12.1
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 07:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729176335; x=1729781135; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H3MhWVz35MEVxLAgf+2Rpi6iKRqTz/Rily/8Q2fKy2U=;
 b=Mhs5OiuF77kuGUaFZJ2f5B51MrnBBXQFIunBcNmnGYq9CwzWz4gsdu7UOIjgKF2TP2
 M4KmAYtwb11JyMkShkwWve9AW1T3c1+kjUcgZWWCuPnofqVLmD5/bFTKCpI3jvVHBXva
 GGnpwGK0SJOJ2wRAoARd2/DYbj9B8njYiLqZksyW//OzJSaOkuQ2XBgnX0S5rp658Hm+
 rM8QL2hTYhBKTTG6IekajQmg5QZLbd5lFLz45VcHubTZvb3z77NBIFJj6fxcKyrsl560
 d420KlfBNWnP6MXDH6EK+0VZ9yyM7UZmmzGL+CktO1INbTGciJsk5KG9CKbiMGO4gUzH
 Yn5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729176335; x=1729781135;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H3MhWVz35MEVxLAgf+2Rpi6iKRqTz/Rily/8Q2fKy2U=;
 b=MJoNN+lSkZceLKhMzy4Ta5weddQpNJbXz2xpZ6xt3fIVTbsvLQcSdb5JTSGkGLbq8o
 RdOOeGyWYCiZpcidz/+kR+HMWf0+Y37yNMn66sGSzEum2Y70xogvk372ICgEdGhnVSlE
 jPi6hAIn/vOVT1MIgnRN+UXaVUW0UJ9A1GIbw1Y69ITyO9r5xeYqUXF1+sB8FyOEy/US
 J36jZlUFNFWlXiyNTer+eDUG8jUyt+RQ7cm/ARRGaoIVxSRkg9kH+xjgWfg5wI5xLtzm
 YBbIwOBSGO+U7G2j8h9fGABMDSULc/SLkmi+Lc8O61Jlt3WMh4b7WzY0ra3kqFKdRqF2
 GIFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVa7Oy+N+v+gw7e47EKe0160M70wlBHdzTjhEWsqeKiOO5MBPR5R7VpMjZYY0vnj/qRHoZqowWcqGH@nongnu.org
X-Gm-Message-State: AOJu0YxNs4qEMmFSDwicppsyAJKwfjkd6deIonrhn4sokMvDxPSwSbnt
 56cIb1ct9oYRmpLPA486D5DEnCcKSFQre8Nq+QZ785kz9cbiPQbnWX0EqIhY
X-Google-Smtp-Source: AGHT+IHc/D7yCSD5mjcpw/BQnXjpbZiPvSHDTwlKvfuM2NBZra64dLb6/ik3Ts6+Pt+yjzPaRYalyg==
X-Received: by 2002:a05:6402:4308:b0:5c4:14fe:971e with SMTP id
 4fb4d7f45d1cf-5c9951ce829mr5155428a12.23.1729176334822; 
 Thu, 17 Oct 2024 07:45:34 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:9c4:b066:486:f408])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c98d507a14sm2867581a12.49.2024.10.17.07.45.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 07:45:34 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 1/8] chardev/char: rename `MuxChardev` struct to
 `MuxFeChardev`
Date: Thu, 17 Oct 2024 16:43:09 +0200
Message-Id: <20241017144316.517709-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017144316.517709-1-r.peniaev@gmail.com>
References: <20241017144316.517709-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x535.google.com
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

In the following patches backend multiplexer will be
introduced. This patch renames the structure and a
few mux macros to reflect that this mux is responsible
only for multiplexing of frontend devices.

This patch does the following:

  s/MuxChardev/MuxFeChardev/g
  s/CHARDEV_IS_MUX/CHARDEV_IS_MUX_FE/g
  s/MUX_CHARDEV/MUX_FE_CHARDEV/g
  s/TYPE_CHARDEV_MUX/TYPE_CHARDEV_MUX_FE/g

No json or string types are changed for the sake of
compatibility.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          | 10 +++++-----
 chardev/char-mux.c         | 36 ++++++++++++++++++------------------
 chardev/char.c             |  8 ++++----
 chardev/chardev-internal.h | 16 ++++++++--------
 include/chardev/char.h     |  2 +-
 5 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 8ac6bebb6f74..7b1ae16c62a4 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -194,8 +194,8 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
     unsigned int tag = 0;
 
     if (s) {
-        if (CHARDEV_IS_MUX(s)) {
-            MuxChardev *d = MUX_CHARDEV(s);
+        if (CHARDEV_IS_MUX_FE(s)) {
+            MuxFeChardev *d = MUX_FE_CHARDEV(s);
 
             if (!mux_chr_attach_frontend(d, b, &tag, errp)) {
                 return false;
@@ -223,8 +223,8 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         if (b->chr->be == b) {
             b->chr->be = NULL;
         }
-        if (CHARDEV_IS_MUX(b->chr)) {
-            MuxChardev *d = MUX_CHARDEV(b->chr);
+        if (CHARDEV_IS_MUX_FE(b->chr)) {
+            MuxFeChardev *d = MUX_FE_CHARDEV(b->chr);
             mux_chr_detach_frontend(d, b->tag);
         }
         if (del) {
@@ -305,7 +305,7 @@ void qemu_chr_fe_take_focus(CharBackend *b)
         return;
     }
 
-    if (CHARDEV_IS_MUX(b->chr)) {
+    if (CHARDEV_IS_MUX_FE(b->chr)) {
         mux_set_focus(b->chr, b->tag);
     }
 }
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index bda5c45e6058..dfaea5aefac3 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -44,7 +44,7 @@ static bool muxes_opened = true;
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int ret;
     if (!d->timestamps) {
         ret = qemu_chr_fe_write(&d->chr, buf, len);
@@ -125,7 +125,7 @@ static void mux_print_help(Chardev *chr)
     }
 }
 
-static void mux_chr_send_event(MuxChardev *d, unsigned int mux_nr,
+static void mux_chr_send_event(MuxFeChardev *d, unsigned int mux_nr,
                                QEMUChrEvent event)
 {
     CharBackend *be = d->backends[mux_nr];
@@ -137,14 +137,14 @@ static void mux_chr_send_event(MuxChardev *d, unsigned int mux_nr,
 
 static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, event);
     }
 }
 
-static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
+static int mux_proc_byte(Chardev *chr, MuxFeChardev *d, int ch)
 {
     if (d->term_got_escape) {
         d->term_got_escape = false;
@@ -198,7 +198,7 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 
 static void mux_chr_accept_input(Chardev *chr)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -211,7 +211,7 @@ static void mux_chr_accept_input(Chardev *chr)
 
 static int mux_chr_can_read(void *opaque)
 {
-    MuxChardev *d = MUX_CHARDEV(opaque);
+    MuxFeChardev *d = MUX_FE_CHARDEV(opaque);
     int m = d->focus;
     CharBackend *be = d->backends[m];
 
@@ -229,7 +229,7 @@ static int mux_chr_can_read(void *opaque)
 static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 {
     Chardev *chr = CHARDEV(opaque);
-    MuxChardev *d = MUX_CHARDEV(opaque);
+    MuxFeChardev *d = MUX_FE_CHARDEV(opaque);
     int m = d->focus;
     CharBackend *be = d->backends[m];
     int i;
@@ -250,7 +250,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
     int bit;
 
     if (!muxes_opened) {
@@ -271,7 +271,7 @@ static void mux_chr_event(void *opaque, QEMUChrEvent event)
 
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
-    MuxChardev *d = MUX_CHARDEV(s);
+    MuxFeChardev *d = MUX_FE_CHARDEV(s);
     Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
     ChardevClass *cc = CHARDEV_GET_CLASS(chr);
 
@@ -284,7 +284,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 
 static void char_mux_finalize(Object *obj)
 {
-    MuxChardev *d = MUX_CHARDEV(obj);
+    MuxFeChardev *d = MUX_FE_CHARDEV(obj);
     int bit;
 
     bit = -1;
@@ -299,7 +299,7 @@ static void char_mux_finalize(Object *obj)
 
 static void mux_chr_update_read_handlers(Chardev *chr)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     /* Fix up the real driver with mux routines */
     qemu_chr_fe_set_handlers_full(&d->chr,
@@ -311,7 +311,7 @@ static void mux_chr_update_read_handlers(Chardev *chr)
                                   chr->gcontext, true, false);
 }
 
-bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
+bool mux_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp)
 {
     unsigned int bit;
@@ -332,7 +332,7 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
     return true;
 }
 
-bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
+bool mux_chr_detach_frontend(MuxFeChardev *d, unsigned int tag)
 {
     unsigned int bit;
 
@@ -349,7 +349,7 @@ bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
 
 void mux_set_focus(Chardev *chr, unsigned int focus)
 {
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) == focus);
 
@@ -369,7 +369,7 @@ static void qemu_chr_open_mux(Chardev *chr,
 {
     ChardevMux *mux = backend->u.mux.data;
     Chardev *drv;
-    MuxChardev *d = MUX_CHARDEV(chr);
+    MuxFeChardev *d = MUX_FE_CHARDEV(chr);
 
     drv = qemu_chr_find(mux->chardev);
     if (drv == NULL) {
@@ -434,7 +434,7 @@ static int chardev_options_parsed_cb(Object *child, void *opaque)
 {
     Chardev *chr = (Chardev *)child;
 
-    if (!chr->be_open && CHARDEV_IS_MUX(chr)) {
+    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
         open_muxes(chr);
     }
 
@@ -462,10 +462,10 @@ static void char_mux_class_init(ObjectClass *oc, void *data)
 }
 
 static const TypeInfo char_mux_type_info = {
-    .name = TYPE_CHARDEV_MUX,
+    .name = TYPE_CHARDEV_MUX_FE,
     .parent = TYPE_CHARDEV,
     .class_init = char_mux_class_init,
-    .instance_size = sizeof(MuxChardev),
+    .instance_size = sizeof(MuxFeChardev),
     .instance_finalize = char_mux_finalize,
 };
 
diff --git a/chardev/char.c b/chardev/char.c
index a1722aa076d9..e077773cdece 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -331,8 +331,8 @@ static const TypeInfo char_type_info = {
 
 static bool qemu_chr_is_busy(Chardev *s)
 {
-    if (CHARDEV_IS_MUX(s)) {
-        MuxChardev *d = MUX_CHARDEV(s);
+    if (CHARDEV_IS_MUX_FE(s)) {
+        MuxFeChardev *d = MUX_FE_CHARDEV(s);
         return d->mux_bitset != 0;
     } else {
         return s->be != NULL;
@@ -687,7 +687,7 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
         backend->type = CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data = g_new0(ChardevMux, 1);
         backend->u.mux.data->chardev = g_strdup(bid);
-        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
+        mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX_FE, backend, context, errp);
         if (mux == NULL) {
             object_unparent(OBJECT(chr));
             chr = NULL;
@@ -1104,7 +1104,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    if (CHARDEV_IS_MUX(chr)) {
+    if (CHARDEV_IS_MUX_FE(chr)) {
         error_setg(errp, "Mux device hotswap not supported yet");
         return NULL;
     }
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 853807f3cb88..321051bb9cc5 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -33,7 +33,7 @@
 #define MUX_BUFFER_SIZE 32 /* Must be a power of 2.  */
 #define MUX_BUFFER_MASK (MUX_BUFFER_SIZE - 1)
 
-struct MuxChardev {
+struct MuxFeChardev {
     Chardev parent;
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
@@ -52,16 +52,16 @@ struct MuxChardev {
     bool linestart;
     int64_t timestamps_start;
 };
-typedef struct MuxChardev MuxChardev;
+typedef struct MuxFeChardev MuxFeChardev;
 
-DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
-                         TYPE_CHARDEV_MUX)
-#define CHARDEV_IS_MUX(chr)                             \
-    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
+DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
+                         TYPE_CHARDEV_MUX_FE)
+#define CHARDEV_IS_MUX_FE(chr)                             \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
 
-bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
+bool mux_chr_attach_frontend(MuxFeChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp);
-bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);
+bool mux_chr_detach_frontend(MuxFeChardev *d, unsigned int tag);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 01df55f9e8c8..d9d23b6232db 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -231,7 +231,7 @@ int qemu_chr_wait_connected(Chardev *chr, Error **errp);
 OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
-#define TYPE_CHARDEV_MUX "chardev-mux"
+#define TYPE_CHARDEV_MUX_FE "chardev-mux"
 #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
 #define TYPE_CHARDEV_PTY "chardev-pty"
 #define TYPE_CHARDEV_CONSOLE "chardev-console"
-- 
2.34.1


