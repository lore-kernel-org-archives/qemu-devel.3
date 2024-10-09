Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE9A5CEE33A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 17:48:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syamS-0005Ym-Kt; Wed, 09 Oct 2024 13:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamJ-0005We-CA
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:16 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syamF-0003Ki-Ig
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 13:47:15 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a9957588566so6468466b.3
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 10:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728496030; x=1729100830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEUm85hSa9bvw4KEEkbFAE9IJyxe+bZtA1ybQDw21Iw=;
 b=RFBTEWkj0GS/k1BZggYCd4DBAZPMUFN+XrBNwBUCQc3YBeqgSxkZIDTG3sIUjtVcre
 qPDfleIjmK41mFRiXKd/dRvWp6NDMp602VJa1dGuCVnLTORjkna+X+5gAppBqyX4uVJN
 WKNCcOV1Gx50nvLcr6Jtn7l0v/2L6WNDG/tFEiVfsVZtGSTV6CLwwSv3GTi1JhjkqT2o
 CUMsDajz3albFJO/ZJFhJHZldvO8H+Jfa73ljgKkwtCLiBPc1tt7r9ujhJ+iIukl68yX
 fe/Lne0ZKDxRPteoEOr7ia/yc5zfx7HuMvTDVNzQG/w1b8C8MPu8TNAgWTnEZgQXtE6M
 nxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728496030; x=1729100830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEUm85hSa9bvw4KEEkbFAE9IJyxe+bZtA1ybQDw21Iw=;
 b=wiQM4bHgDgz50j1GgiWuqSmD84sxZqJo9XuvFWw7IKpKm9xk5J1VQwfGXp8VKFXqpi
 2chVNmT2GPYuB2os9VAey2ARbaEuXOme/b3b1Wt6kMghewWEaEV7c7pWhlMC+cmssb78
 eYA2qgJ4FipfbCIp1JPvFuzl3Vp0dppGwNRCcb9jq4LmJM1RJcqp9Q27bQB0nuMKIvuF
 gCK02d4k3ywZEHu7HTRWeJKnHqY2Ip9BjPDmxJSTdmcRdu0v8N3ZvBJN5s5f1f/aXgrz
 Aog53/iBQL9wqn+jg0YAb85b9PoWz0aeRxufJXMaEcc5F8P0Gt7Xpry6UsVpGhH8SfW3
 exBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNw9+9QWRiha6eWgPHhhm6T+NSzkdIryHGomoRm1ps5ZPsx063fLZLGmBgx8ChhcFx9dDUYYG1Z9Qy@nongnu.org
X-Gm-Message-State: AOJu0Ywyn8vwlZVzBQbWR3Kb5z2mg5QQgwfj/Wwl8mm7fcRjrkU6zwg1
 TFyXk8L3MQJWQykqJpN7q9iGk/1Y2P65aaFVTiSWwFXWV30vg1bihEBKvQ==
X-Google-Smtp-Source: AGHT+IGq8/uMKEfSupkV0SPnJWW65HGt09b1O7ulVtxBO7vcU9lD1QlPI8p+8HwIuQVPCBDtqeJXvw==
X-Received: by 2002:a17:906:6a2a:b0:a99:4fb4:ea30 with SMTP id
 a640c23a62f3a-a998d1ac05fmr300284966b.19.1728496029774; 
 Wed, 09 Oct 2024 10:47:09 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a994f38068fsm491667666b.40.2024.10.09.10.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 10:47:09 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] chardev/char-mux: implement backend chardev
 multiplexing
Date: Wed,  9 Oct 2024 19:45:15 +0200
Message-Id: <20241009174517.286935-4-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241009174517.286935-1-r.peniaev@gmail.com>
References: <20241009174517.286935-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x629.google.com
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

This patch implements multiplexing capability of several backend
devices, which opens up an opportunity to use a single frontend
device on the guest, which can be manipulated from several
backend devices.

The idea of the change is trivial: keep list of backend devices
(up to 4), init them on demand and forward data buffer back and
forth.

The following is QEMU command line example:

   -chardev mux-be,id=mux0 \
   -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
   -chardev vc,id=vc0,mux-be-id=mux0 \
   -device virtconsole,chardev=mux0 \
   -vnc 0.0.0.0:0

Which creates 2 backend devices: text virtual console (`vc0`) and a
socket (`sock0`) connected to the single virtio hvc console with the
backend multiplexer (`mux0`) help. `vc0` renders text to an image,
which can be shared over the VNC protocol.  `sock0` is a socket
backend which provides biderectional communication to the virtio hvc
console.

New type of multiplexer `mux-be` actually is an alias for the same
`MuxChardev` struct, which uses same functions as for the original
`mux` type, but supports multiplexing N backends with 1 frontend.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |   7 ++
 chardev/char-mux.c         | 200 +++++++++++++++++++++++++++++++++----
 chardev/char.c             |  52 ++++++++--
 chardev/chardev-internal.h |  31 +++++-
 4 files changed, 258 insertions(+), 32 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index e6f44801162a..d1f67338084d 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -204,6 +204,13 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
                            s->label);
                 return false;
             }
+            if (d->fe_cnt > 0 && d->be_cnt > 1) {
+                error_setg(errp,
+                           "multiplexed chardev '%s' is already used "
+                           "for backend multiplexing",
+                           s->label);
+                return false;
+            }
             d->backends[d->fe_cnt] = b;
             tag = d->fe_cnt++;
         } else if (s->be) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index eb72b3cdb80b..c79cee008c17 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/cutils.h"
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "qapi/qapi-commands-control.h"
@@ -40,13 +41,71 @@
  */
 static bool muxes_opened = true;
 
+/*
+ * Write to all backends. Different backend devices accept data with
+ * various rate, so it is quite possible that one device returns less,
+ * then others. In this case we return minimum to the caller,
+ * expecting caller will repeat operation soon. When repeat happens
+ * send to the devices which consume data faster must be avoided
+ * for obvious reasons not to send data, which was already sent.
+ */
+static int mux_chr_fe_write_to_all(MuxChardev *mux, const uint8_t *buf, int len,
+                                   int (*write_func)(CharBackend *,
+                                                     const uint8_t *buf,
+                                                     int len))
+{
+    int r, i, ret = len;
+    unsigned int written;
+
+    for (i = 0; i < mux->be_cnt; i++) {
+        written = mux->be_written[i] - mux->be_min_written;
+        if (written) {
+            /* Written in the previous call so take into account */
+            ret = MIN(written, ret);
+            continue;
+        }
+        r = write_func(&mux->chrs[i], buf, len);
+        if (!mux->is_mux_be || (r < 0 && errno == EAGAIN)) {
+            /*
+             * Fail immediately if this is a frontend multiplexer or
+             * write would block. Expect to be called soon on watch
+             * wake up.
+             */
+            return r;
+        } else if (r < 0) {
+            /*
+             * Ignore all other errors and pretend the entire buffer is
+             * written to avoid this chardev being watched. This device
+             * becomes disabled until the following write succeeds, but
+             * writing continues to others.
+             */
+            r = len;
+        }
+        mux->be_written[i] += r;
+        ret = MIN(r, ret);
+    }
+    mux->be_min_written += ret;
+
+    return ret;
+}
+
+static int mux_chr_fe_write(MuxChardev *mux, const uint8_t *buf, int len)
+{
+    return mux_chr_fe_write_to_all(mux, buf, len, qemu_chr_fe_write);
+}
+
+static int mux_chr_fe_write_all(MuxChardev *mux, const uint8_t *buf, int len)
+{
+    return mux_chr_fe_write_to_all(mux, buf, len, qemu_chr_fe_write_all);
+}
+
 /* Called with chr_write_lock held.  */
 static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
     int ret;
     if (!d->timestamps) {
-        ret = qemu_chr_fe_write(&d->chr, buf, len);
+        ret = mux_chr_fe_write(d, buf, len);
     } else {
         int i;
 
@@ -71,11 +130,11 @@ static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
                          (int)(ti % 1000));
                 /* XXX this blocks entire thread. Rewrite to use
                  * qemu_chr_fe_write and background I/O callbacks */
-                qemu_chr_fe_write_all(&d->chr,
+                mux_chr_fe_write_all(d,
                                       (uint8_t *)buf1, strlen(buf1));
                 d->linestart = 0;
             }
-            ret += qemu_chr_fe_write(&d->chr, buf + i, 1);
+            ret += mux_chr_fe_write(d, buf + i, 1);
             if (buf[i] == '\n') {
                 d->linestart = 1;
             }
@@ -262,14 +321,35 @@ static void mux_chr_event(void *opaque, QEMUChrEvent event)
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
     MuxChardev *d = MUX_CHARDEV(s);
-    Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    Chardev *chr;
+    ChardevClass *cc;
+    unsigned int written;
+    int i;
+
+    for (i = 0; i < d->be_cnt; i++) {
+        written = d->be_written[i] - d->be_min_written;
+        if (written) {
+            /* We skip the device with already written buffer */
+            continue;
+        }
+
+        /*
+         * The first device that has no data written to it must be
+         * the device that recently returned EAGAIN and should be
+         * watched.
+         */
+
+        chr = qemu_chr_fe_get_driver(&d->chrs[i]);
+        cc = CHARDEV_GET_CLASS(chr);
+
+        if (!cc->chr_add_watch) {
+            return NULL;
+        }
 
-    if (!cc->chr_add_watch) {
-        return NULL;
+        return cc->chr_add_watch(chr, cond);
     }
 
-    return cc->chr_add_watch(chr, cond);
+    return NULL;
 }
 
 static void char_mux_finalize(Object *obj)
@@ -283,21 +363,26 @@ static void char_mux_finalize(Object *obj)
             be->chr = NULL;
         }
     }
-    qemu_chr_fe_deinit(&d->chr, false);
+    for (i = 0; i < d->be_cnt; i++) {
+        qemu_chr_fe_deinit(&d->chrs[i], false);
+    }
 }
 
 static void mux_chr_update_read_handlers(Chardev *chr)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
+    int i;
 
-    /* Fix up the real driver with mux routines */
-    qemu_chr_fe_set_handlers_full(&d->chr,
-                                  mux_chr_can_read,
-                                  mux_chr_read,
-                                  mux_chr_event,
-                                  NULL,
-                                  chr,
-                                  chr->gcontext, true, false);
+    for (i = 0; i < d->be_cnt; i++) {
+        /* Fix up the real driver with mux routines */
+        qemu_chr_fe_set_handlers_full(&d->chrs[i],
+                                      mux_chr_can_read,
+                                      mux_chr_read,
+                                      mux_chr_event,
+                                      NULL,
+                                      chr,
+                                      chr->gcontext, true, false);
+    }
 }
 
 void mux_set_focus(Chardev *chr, int focus)
@@ -316,6 +401,33 @@ void mux_set_focus(Chardev *chr, int focus)
     mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
 }
 
+bool mux_chr_attach_chardev(MuxChardev *d, Chardev *chr, Error **errp)
+{
+    bool r;
+
+    if (d->fe_cnt > 1) {
+        error_setg(errp,
+                   "multiplexed chardev '%s' is already used "
+                   "for frontend multiplexing",
+                   chr->label);
+        return false;
+    }
+    if (d->be_cnt >= MAX_MUX) {
+        error_setg(errp, "too many uses of multiplexed chardev '%s'"
+                   " (maximum is " stringify(MAX_MUX) ")",
+                   d->parent.label);
+        return false;
+    }
+    r = qemu_chr_fe_init(&d->chrs[d->be_cnt], chr, errp);
+    if (r) {
+        /* Catch up with what was already written */
+        d->be_written[d->be_cnt] = d->be_min_written;
+        d->be_cnt += 1;
+    }
+
+    return r;
+}
+
 static void qemu_chr_open_mux(Chardev *chr,
                               ChardevBackend *backend,
                               bool *be_opened,
@@ -336,7 +448,7 @@ static void qemu_chr_open_mux(Chardev *chr,
      * set of muxes
      */
     *be_opened = muxes_opened;
-    qemu_chr_fe_init(&d->chr, drv, errp);
+    mux_chr_attach_chardev(d, drv, errp);
 }
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
@@ -355,6 +467,31 @@ static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
     mux->chardev = g_strdup(chardev);
 }
 
+static void qemu_chr_open_mux_be(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
+{
+    MuxChardev *d = MUX_CHARDEV(chr);
+
+    /*
+     * only default to opened state if we've realized the initial
+     * set of muxes
+     */
+    *be_opened = muxes_opened;
+    d->is_mux_be = true;
+}
+
+static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backend,
+                                  Error **errp)
+{
+    ChardevMux *mux;
+
+    backend->type = CHARDEV_BACKEND_KIND_MUX_BE;
+    mux = backend->u.mux.data = g_new0(ChardevMux, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevMux_base(mux));
+}
+
 /**
  * Called after processing of default and command-line-specified
  * chardevs to deliver CHR_EVENT_OPENED events to any FEs attached
@@ -415,7 +552,19 @@ static void char_mux_class_init(ObjectClass *oc, void *data)
     cc->chr_update_read_handler = mux_chr_update_read_handlers;
 }
 
-static const TypeInfo char_mux_type_info = {
+static void char_mux_be_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    char_mux_class_init(oc, data);
+
+    /* Callbacks related to the mux-be device */
+    cc->parse = qemu_chr_parse_mux_be;
+    cc->open = qemu_chr_open_mux_be;
+}
+
+/* Multiplexes 1 backend to N frontends */
+static const TypeInfo char_mux_fe_type_info = {
     .name = TYPE_CHARDEV_MUX,
     .parent = TYPE_CHARDEV,
     .class_init = char_mux_class_init,
@@ -423,9 +572,20 @@ static const TypeInfo char_mux_type_info = {
     .instance_finalize = char_mux_finalize,
 };
 
+/* Multiplexes N backends to 1 frontend */
+static const TypeInfo char_mux_be_type_info = {
+    .name = TYPE_CHARDEV_MUX_BE,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_mux_be_class_init,
+    .instance_size = sizeof(MuxChardev),
+    .instance_finalize = char_mux_finalize,
+};
+
 static void register_types(void)
 {
-    type_register_static(&char_mux_type_info);
+    /* Register two multiplexers */
+    type_register_static(&char_mux_fe_type_info);
+    type_register_static(&char_mux_be_type_info);
 }
 
 type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index 3f0fcc8b16f6..20f4e2bdd3e6 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -636,7 +636,8 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     ChardevBackend *backend = NULL;
     const char *name = qemu_opt_get(opts, "backend");
     const char *id = qemu_opts_id(opts);
-    char *bid = NULL;
+    const char *mux_be_id = NULL;
+    char *mux_fe_id = NULL;
 
     if (name && is_help_option(name)) {
         GString *str = g_string_new("");
@@ -664,10 +665,16 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     }
 
     if (qemu_opt_get_bool(opts, "mux", 0)) {
-        bid = g_strdup_printf("%s-base", id);
+        mux_fe_id = g_strdup_printf("%s-base", id);
+    }
+    mux_be_id = qemu_opt_get(opts, "mux-be-id");
+    if (mux_be_id && mux_fe_id) {
+        error_setg(errp, "chardev: mux and mux-be can't be used for the same "
+                   "device");
+        goto out;
     }
 
-    chr = qemu_chardev_new(bid ? bid : id,
+    chr = qemu_chardev_new(mux_fe_id ? mux_fe_id : id,
                            object_class_get_name(OBJECT_CLASS(cc)),
                            backend, context, errp);
     if (chr == NULL) {
@@ -675,25 +682,47 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     }
 
     base = chr;
-    if (bid) {
+    if (mux_fe_id) {
         Chardev *mux;
         qapi_free_ChardevBackend(backend);
         backend = g_new0(ChardevBackend, 1);
         backend->type = CHARDEV_BACKEND_KIND_MUX;
         backend->u.mux.data = g_new0(ChardevMux, 1);
-        backend->u.mux.data->chardev = g_strdup(bid);
+        backend->u.mux.data->chardev = g_strdup(mux_fe_id);
         mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX, backend, context, errp);
         if (mux == NULL) {
-            object_unparent(OBJECT(chr));
-            chr = NULL;
-            goto out;
+            goto unparent_chr;
         }
         chr = mux;
+    } else if (mux_be_id) {
+        MuxChardev *d;
+        Chardev *s;
+
+        s = qemu_chr_find(mux_be_id);
+        if (!s) {
+            error_setg(errp, "chardev: mux-be device can't be found by id '%s'",
+                       mux_be_id);
+            goto unparent_chr;
+        }
+        if (!CHARDEV_IS_MUX(s)) {
+            error_setg(errp, "chardev: device '%s' is not a multiplexer device",
+                       mux_be_id);
+            goto unparent_chr;
+        }
+        d = MUX_CHARDEV(s);
+        if (!d->is_mux_be) {
+            error_setg(errp, "chardev: device '%s' is not a multiplexer device"
+                       " of 'mux-de' type", mux_be_id);
+            goto unparent_chr;
+        }
+        if (!mux_chr_attach_chardev(d, chr, errp)) {
+            goto unparent_chr;
+        }
     }
 
 out:
     qapi_free_ChardevBackend(backend);
-    g_free(bid);
+    g_free(mux_fe_id);
 
     if (replay && base) {
         /* RR should be set on the base device, not the mux */
@@ -701,6 +730,11 @@ out:
     }
 
     return chr;
+
+unparent_chr:
+    object_unparent(OBJECT(chr));
+    chr = NULL;
+    goto out;
 }
 
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index e8c3c29d1a59..07a917737fc3 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -35,10 +35,14 @@
 
 struct MuxChardev {
     Chardev parent;
+    /* Linked frontends ("mux" type) */
     CharBackend *backends[MAX_MUX];
-    CharBackend chr;
+    /* Linked backends ("mux-be" type) */
+    CharBackend chrs[MAX_MUX];
+    bool is_mux_be;
     int focus;
     int fe_cnt;
+    int be_cnt;
     int term_got_escape;
     int max_size;
     /* Intermediate input buffer catches escape sequences even if the
@@ -52,16 +56,37 @@ struct MuxChardev {
     /* Protected by the Chardev chr_write_lock.  */
     int linestart;
     int64_t timestamps_start;
+
+    /*
+     * Counters of written bytes from a single frontend device
+     * to multiple backend devices ("mux-be" type).
+     */
+    unsigned int be_written[MAX_MUX];
+    unsigned int be_min_written;
 };
 typedef struct MuxChardev MuxChardev;
 
-DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
+/* Two different names correspond to similar struct */
+DECLARE_INSTANCE_CHECKER(MuxChardev, __MUX_CHARDEV,
                          TYPE_CHARDEV_MUX)
-#define CHARDEV_IS_MUX(chr)                             \
+DECLARE_INSTANCE_CHECKER(MuxChardev, __MUX_BE_CHARDEV,
+                         TYPE_CHARDEV_MUX_BE)
+
+#define __CHARDEV_IS_MUX(chr) \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
+#define __CHARDEV_IS_MUX_BE(chr) \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)
+
+#define CHARDEV_IS_MUX(chr) \
+    (__CHARDEV_IS_MUX(chr) || __CHARDEV_IS_MUX_BE(chr))
+
+/* Either "mux", either "mux-be" */
+#define MUX_CHARDEV(chr) \
+    (__CHARDEV_IS_MUX(chr) ? __MUX_CHARDEV(chr) : __MUX_BE_CHARDEV(chr))
 
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
+bool mux_chr_attach_chardev(MuxChardev *d, Chardev *chr, Error **errp);
 
 Object *get_chardevs_root(void);
 
-- 
2.43.0


