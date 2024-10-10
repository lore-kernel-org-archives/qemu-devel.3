Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC06CF11C6
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 10:21:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syqHh-0006T9-Tu; Thu, 10 Oct 2024 06:20:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHg-0006Sq-2n
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:40 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1syqHd-0003Yl-4W
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 06:20:39 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-539983beb19so808265e87.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 03:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728555635; x=1729160435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zQWgWwVNAcci9xN5Q9kKzz6kS9fxlr0KyGlQkV4Cjz0=;
 b=ONXDhvvX4oeD6OSaZIK3KBuPkTpnJltNbTPdR4tMOCNONqf/KuRYc2rRp7LiiLtf4B
 HP5cV0HWm0pqQxgPQ/8XMTOCSFo3rJmqplw2q/Y72BX6SBKCgdf1gdijMNMLrBYONzCm
 LZEfcPd5qpiJs0PPGOYo4c+25q4QpAhGCXag36PkqIDOG8AqC4gDTSq3VV3dKGlXuBsL
 pqiLEX0gZCN+JKs2YCArxuM0kWaY6PGlEh8IRR/650zCeuwgNYR3US0dxVdLjZ57pNv4
 VFVamgXF3m9tTzbfkgWa01KYd09lrC/ISj1MRxZCDKPFjfIt8h31sxcL2nX3ea8U3uJv
 mUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728555635; x=1729160435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zQWgWwVNAcci9xN5Q9kKzz6kS9fxlr0KyGlQkV4Cjz0=;
 b=pncvAuA50GBEcz/yocVxm5OcXCsiI/4AhUcBasbgJVfxMcm69lWg8Rs8DlMhivazXI
 VPpdwa82EZyPaXs8UOh1ozjoT8HGwtCcD+v8P6m8ebRbkA2IPFBY9jcsZbKdyeJM7ytf
 NEKKEoJc70exlWYnZZe8Whk8LPZg6LjQHjEQxNki+NJ1/+MD0Gfi4EF3nppmpu2U+5zS
 Y78PUXHl8f6Vlow7WFCDFFAE40ygwR7EWkoRn7jwQRDMiUxwierg9MAWzVFYW/owUXUv
 xlP5jRPT7lSNHIpciokvhq1kFWtysmabDrQr/4+nsh5uY7BZSi+AHrwrN3r1C6+o6ddZ
 JCDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV34Tzw0ENRvxUc+cn5vt6Z3inRPIxjrG/9cFHSkb4ZVMG3IYfcblSl8ahzPidkpObzMjQSbLtSB1NL@nongnu.org
X-Gm-Message-State: AOJu0YxCdifpWGIau/DYZmJynABPicpzZbYRZ69PQyQ5pQaKncE03FyF
 HS5yv1gLluL1rdp0YUH8+sM4SMjdynxLd29U+dAd8ydekTFfki1g
X-Google-Smtp-Source: AGHT+IH85tbRjPP1pnWWFzODAFx+xX1ElraD5pJFvk7/3QwwcQ3jRfgI78ylAukbx57Uw8o7FihjJA==
X-Received: by 2002:a05:6512:3096:b0:539:93b2:1373 with SMTP id
 2adb3069b0e04-539c4898a04mr3403020e87.20.1728555634987; 
 Thu, 10 Oct 2024 03:20:34 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2436fsm68240266b.53.2024.10.10.03.20.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 03:20:34 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 5/7] chardev/char-mux: implement backend chardev
 multiplexing
Date: Thu, 10 Oct 2024 12:18:36 +0200
Message-Id: <20241010101838.331032-6-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241010101838.331032-1-r.peniaev@gmail.com>
References: <20241010101838.331032-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=r.peniaev@gmail.com; helo=mail-lf1-x135.google.com
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

Patch implements another multiplexer type `mux-be`. The following
is QEMU command line example:

   -chardev mux-be,id=mux0 \
   -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0,mux-be-id=mux0 \
   -chardev vc,id=vc0,mux-be-id=mux0 \
   -device virtconsole,chardev=mux0 \
   -vnc 0.0.0.0:0

which creates 2 backend devices: text virtual console (`vc0`) and a
socket (`sock0`) connected to the single virtio hvc console with the
backend multiplexer (`mux0`) help. `vc0` renders text to an image,
which can be shared over the VNC protocol.  `sock0` is a socket
backend which provides biderectional communication to the virtio hvc
console.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  14 ++
 chardev/char-mux-be.c      | 272 +++++++++++++++++++++++++++++++++++++
 chardev/char.c             |  56 ++++++--
 chardev/chardev-internal.h |  27 +++-
 chardev/meson.build        |   1 +
 include/chardev/char.h     |   1 +
 qapi/char.json             |  25 ++++
 7 files changed, 383 insertions(+), 13 deletions(-)
 create mode 100644 chardev/char-mux-be.c

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 71d6212b13f8..33f7a04b3c60 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -207,6 +207,17 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 
             d->backends[d->mux_cnt] = b;
             tag = d->mux_cnt++;
+        } else if (CHARDEV_IS_MUX_BE(s)) {
+            MuxBeChardev *d = MUX_BE_CHARDEV(s);
+
+            if (d->frontend) {
+                error_setg(errp,
+                           "multiplexed chardev '%s' is already used "
+                           "for multiplexing", s->label);
+                return false;
+            }
+            d->frontend = b;
+
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
@@ -233,6 +244,9 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         if (CHARDEV_IS_MUX_FE(b->chr)) {
             MuxFeChardev *d = MUX_FE_CHARDEV(b->chr);
             d->backends[b->tag] = NULL;
+        } else if (CHARDEV_IS_MUX_BE(b->chr)) {
+            MuxBeChardev *d = MUX_BE_CHARDEV(b->chr);
+            d->frontend = NULL;
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
diff --git a/chardev/char-mux-be.c b/chardev/char-mux-be.c
new file mode 100644
index 000000000000..2f8a55b0dcce
--- /dev/null
+++ b/chardev/char-mux-be.c
@@ -0,0 +1,272 @@
+/*
+ * QEMU Character Backend Multiplexer
+ *
+ * Author: Roman Penyaev <r.peniaev@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu/module.h"
+#include "qemu/option.h"
+#include "qemu/cutils.h"
+#include "chardev/char.h"
+#include "sysemu/block-backend.h"
+#include "qapi/qapi-commands-control.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-builtin-visit.h"
+#include "chardev-internal.h"
+
+/*
+ * MUX-BE driver for multiplexing 1 frontend device with N backend devices
+ */
+
+/*
+ * Write to all backends. Different backend devices accept data with
+ * various rate, so it is quite possible that one device returns less,
+ * then others. In this case we return minimum to the caller,
+ * expecting caller will repeat operation soon. When repeat happens
+ * send to the devices which consume data faster must be avoided
+ * for obvious reasons not to send data, which was already sent.
+ */
+static int mux_be_chr_write_to_all(MuxBeChardev *d, const uint8_t *buf, int len)
+{
+    int r, i, ret = len;
+    unsigned int written;
+
+    for (i = 0; i < d->mux_cnt; i++) {
+        written = d->be_written[i] - d->be_min_written;
+        if (written) {
+            /* Written in the previous call so take into account */
+            ret = MIN(written, ret);
+            continue;
+        }
+        r = qemu_chr_fe_write(&d->backends[i], buf, len);
+        if (r < 0 && errno == EAGAIN) {
+            /*
+             * Fail immediately if write would block. Expect to be called
+             * soon on watch wake up.
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
+        d->be_written[i] += r;
+        ret = MIN(r, ret);
+    }
+    d->be_min_written += ret;
+
+    return ret;
+}
+
+/* Called with chr_write_lock held.  */
+static int mux_be_chr_write(Chardev *chr, const uint8_t *buf, int len)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+    return mux_be_chr_write_to_all(d, buf, len);
+}
+
+static void mux_be_chr_send_event(MuxBeChardev *d, QEMUChrEvent event)
+{
+    CharBackend *fe = d->frontend;
+
+    if (fe && fe->chr_event) {
+        fe->chr_event(fe->opaque, event);
+    }
+}
+
+static void mux_be_chr_be_event(Chardev *chr, QEMUChrEvent event)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+
+    mux_be_chr_send_event(d, event);
+}
+
+static int mux_be_chr_can_read(void *opaque)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(opaque);
+    CharBackend *fe = d->frontend;
+
+    if (fe && fe->chr_can_read) {
+        return fe->chr_can_read(fe->opaque);
+    }
+
+    return 0;
+}
+
+static void mux_be_chr_read(void *opaque, const uint8_t *buf, int size)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(opaque);
+    CharBackend *fe = d->frontend;
+
+    if (fe && fe->chr_read) {
+        fe->chr_read(fe->opaque, buf, size);
+    }
+}
+
+void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event)
+{
+    mux_be_chr_send_event(d, event);
+}
+
+static void mux_be_chr_event(void *opaque, QEMUChrEvent event)
+{
+    mux_chr_send_all_event(CHARDEV(opaque), event);
+}
+
+static GSource *mux_be_chr_add_watch(Chardev *s, GIOCondition cond)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(s);
+    Chardev *chr;
+    ChardevClass *cc;
+    unsigned int written;
+    int i;
+
+    for (i = 0; i < d->mux_cnt; i++) {
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
+        chr = qemu_chr_fe_get_driver(&d->backends[i]);
+        cc = CHARDEV_GET_CLASS(chr);
+
+        if (!cc->chr_add_watch) {
+            return NULL;
+        }
+
+        return cc->chr_add_watch(chr, cond);
+    }
+
+    return NULL;
+}
+
+bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **errp)
+{
+    bool ret;
+
+    if (d->mux_cnt >= MAX_MUX) {
+        error_setg(errp, "too many uses of multiplexed chardev '%s'"
+                   " (maximum is " stringify(MAX_MUX) ")",
+                   d->parent.label);
+        return false;
+    }
+    ret = qemu_chr_fe_init(&d->backends[d->mux_cnt], chr, errp);
+    if (ret) {
+        /* Catch up with what was already written */
+        d->be_written[d->mux_cnt] = d->be_min_written;
+        d->mux_cnt += 1;
+    }
+
+    return ret;
+}
+
+static void char_mux_be_finalize(Object *obj)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(obj);
+    CharBackend *fe = d->frontend;
+    int i;
+
+    if (fe) {
+        fe->chr = NULL;
+    }
+    for (i = 0; i < d->mux_cnt; i++) {
+        qemu_chr_fe_deinit(&d->backends[i], false);
+    }
+}
+
+static void mux_be_chr_update_read_handlers(Chardev *chr)
+{
+    MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+    int i;
+
+    for (i = 0; i < d->mux_cnt; i++) {
+        /* Fix up the real driver with mux routines */
+        qemu_chr_fe_set_handlers_full(&d->backends[i],
+                                      mux_be_chr_can_read,
+                                      mux_be_chr_read,
+                                      mux_be_chr_event,
+                                      NULL,
+                                      chr,
+                                      chr->gcontext, true, false);
+    }
+}
+
+static void qemu_chr_open_mux_be(Chardev *chr,
+                                 ChardevBackend *backend,
+                                 bool *be_opened,
+                                 Error **errp)
+{
+    /*
+     * Only default to opened state if we've realized the initial
+     * set of muxes
+     */
+    *be_opened = mux_is_opened();
+}
+
+static void qemu_chr_parse_mux_be(QemuOpts *opts, ChardevBackend *backend,
+                                  Error **errp)
+{
+    ChardevMuxBe *mux;
+
+    backend->type = CHARDEV_BACKEND_KIND_MUX_BE;
+    mux = backend->u.mux_be.data = g_new0(ChardevMuxBe, 1);
+    qemu_chr_parse_common(opts, qapi_ChardevMuxBe_base(mux));
+}
+
+static void char_mux_be_class_init(ObjectClass *oc, void *data)
+{
+    ChardevClass *cc = CHARDEV_CLASS(oc);
+
+    cc->parse = qemu_chr_parse_mux_be;
+    cc->open = qemu_chr_open_mux_be;
+    cc->chr_write = mux_be_chr_write;
+    cc->chr_add_watch = mux_be_chr_add_watch;
+    cc->chr_be_event = mux_be_chr_be_event;
+    cc->chr_update_read_handler = mux_be_chr_update_read_handlers;
+}
+
+static const TypeInfo char_mux_be_type_info = {
+    .name = TYPE_CHARDEV_MUX_BE,
+    .parent = TYPE_CHARDEV,
+    .class_init = char_mux_be_class_init,
+    .instance_size = sizeof(MuxBeChardev),
+    .instance_finalize = char_mux_be_finalize,
+};
+
+static void register_types(void)
+{
+    type_register_static(&char_mux_be_type_info);
+}
+
+type_init(register_types);
diff --git a/chardev/char.c b/chardev/char.c
index ec9a6c4d2499..c010679b64f7 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -341,6 +341,9 @@ static bool qemu_chr_is_busy(Chardev *s)
     if (CHARDEV_IS_MUX_FE(s)) {
         MuxFeChardev *d = MUX_FE_CHARDEV(s);
         return d->mux_cnt > 0;
+    } else if (CHARDEV_IS_MUX_BE(s)) {
+        MuxBeChardev *d = MUX_BE_CHARDEV(s);
+        return d->mux_cnt > 0;
     } else {
         return s->be != NULL;
     }
@@ -648,7 +651,8 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
     ChardevBackend *backend = NULL;
     const char *name = qemu_opt_get(opts, "backend");
     const char *id = qemu_opts_id(opts);
-    char *bid = NULL;
+    const char *mux_be_id = NULL;
+    char *mux_fe_id = NULL;
 
     if (name && is_help_option(name)) {
         GString *str = g_string_new("");
@@ -676,10 +680,16 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
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
@@ -687,25 +697,40 @@ static Chardev *__qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
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
         mux = qemu_chardev_new(id, TYPE_CHARDEV_MUX_FE, backend, context, errp);
         if (mux == NULL) {
-            object_unparent(OBJECT(chr));
-            chr = NULL;
-            goto out;
+            goto unparent_and_out;
         }
         chr = mux;
+    } else if (mux_be_id) {
+        Chardev *s;
+
+        s = qemu_chr_find(mux_be_id);
+        if (!s) {
+            error_setg(errp, "chardev: mux-be device can't be found by id '%s'",
+                       mux_be_id);
+            goto unparent_and_out;
+        }
+        if (!CHARDEV_IS_MUX_BE(s)) {
+            error_setg(errp, "chardev: device '%s' is not a multiplexer device"
+                       " of 'mux-de' type", mux_be_id);
+            goto unparent_and_out;
+        }
+        if (!mux_be_chr_attach_chardev(MUX_BE_CHARDEV(s), chr, errp)) {
+            goto unparent_and_out;
+        }
     }
 
 out:
     qapi_free_ChardevBackend(backend);
-    g_free(bid);
+    g_free(mux_fe_id);
 
     if (replay && base) {
         /* RR should be set on the base device, not the mux */
@@ -713,6 +738,11 @@ out:
     }
 
     return chr;
+
+unparent_and_out:
+    object_unparent(OBJECT(chr));
+    chr = NULL;
+    goto out;
 }
 
 Chardev *qemu_chr_new_from_opts(QemuOpts *opts, GMainContext *context,
@@ -1114,7 +1144,7 @@ ChardevReturn *qmp_chardev_change(const char *id, ChardevBackend *backend,
         return NULL;
     }
 
-    if (CHARDEV_IS_MUX_FE(chr)) {
+    if (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr)) {
         error_setg(errp, "Mux device hotswap not supported yet");
         return NULL;
     }
@@ -1302,7 +1332,7 @@ static int chardev_options_parsed_cb(Object *child, void *opaque)
 {
     Chardev *chr = (Chardev *)child;
 
-    if (!chr->be_open && CHARDEV_IS_MUX_FE(chr)) {
+    if (!chr->be_open && (CHARDEV_IS_MUX_FE(chr) || CHARDEV_IS_MUX_BE(chr))) {
         open_muxes(chr);
     }
 
@@ -1329,8 +1359,10 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 
     if (CHARDEV_IS_MUX_FE(chr)) {
         MuxFeChardev *d = MUX_FE_CHARDEV(chr);
-
         mux_fe_chr_send_all_event(d, event);
+    } else if (CHARDEV_IS_MUX_BE(chr)) {
+        MuxBeChardev *d = MUX_BE_CHARDEV(chr);
+        mux_be_chr_send_all_event(d, event);
     }
 }
 
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index a77f0bdaccfa..60b41048ddd7 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -35,7 +35,9 @@
 
 struct MuxFeChardev {
     Chardev parent;
+    /* Linked frontends */
     CharBackend *backends[MAX_MUX];
+    /* Linked backend */
     CharBackend chr;
     int focus;
     int mux_cnt;
@@ -55,16 +57,39 @@ struct MuxFeChardev {
 };
 typedef struct MuxFeChardev MuxFeChardev;
 
+struct MuxBeChardev {
+    Chardev parent;
+    /* Linked frontend */
+    CharBackend *frontend;
+    /* Linked backends */
+    CharBackend backends[MAX_MUX];
+    unsigned int mux_cnt;
+    /*
+     * Counters of written bytes from a single frontend device
+     * to multiple backend devices.
+     */
+    unsigned int be_written[MAX_MUX];
+    unsigned int be_min_written;
+};
+typedef struct MuxBeChardev MuxBeChardev;
+
 DECLARE_INSTANCE_CHECKER(MuxFeChardev, MUX_FE_CHARDEV,
                          TYPE_CHARDEV_MUX_FE)
-#define CHARDEV_IS_MUX_FE(chr)                             \
+DECLARE_INSTANCE_CHECKER(MuxBeChardev, MUX_BE_CHARDEV,
+                         TYPE_CHARDEV_MUX_BE)
+
+#define CHARDEV_IS_MUX_FE(chr)                              \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_FE)
+#define CHARDEV_IS_MUX_BE(chr)                              \
+    object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX_BE)
 
 void mux_set_focus(Chardev *chr, int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
 /* Mux type dependent calls */
 void mux_fe_chr_send_all_event(MuxFeChardev *d, QEMUChrEvent event);
+void mux_be_chr_send_all_event(MuxBeChardev *d, QEMUChrEvent event);
+bool mux_be_chr_attach_chardev(MuxBeChardev *d, Chardev *chr, Error **errp);
 
 Object *get_chardevs_root(void);
 
diff --git a/chardev/meson.build b/chardev/meson.build
index 778444a00ca6..3a9f5565372b 100644
--- a/chardev/meson.build
+++ b/chardev/meson.build
@@ -3,6 +3,7 @@ chardev_ss.add(files(
   'char-file.c',
   'char-io.c',
   'char-mux-fe.c',
+  'char-mux-be.c',
   'char-null.c',
   'char-pipe.c',
   'char-ringbuf.c',
diff --git a/include/chardev/char.h b/include/chardev/char.h
index 0bec974f9d73..c58c11c4eeaf 100644
--- a/include/chardev/char.h
+++ b/include/chardev/char.h
@@ -232,6 +232,7 @@ OBJECT_DECLARE_TYPE(Chardev, ChardevClass, CHARDEV)
 
 #define TYPE_CHARDEV_NULL "chardev-null"
 #define TYPE_CHARDEV_MUX_FE "chardev-mux"
+#define TYPE_CHARDEV_MUX_BE "chardev-mux-be"
 #define TYPE_CHARDEV_RINGBUF "chardev-ringbuf"
 #define TYPE_CHARDEV_PTY "chardev-pty"
 #define TYPE_CHARDEV_CONSOLE "chardev-console"
diff --git a/qapi/char.json b/qapi/char.json
index fb0dedb24383..cdec8f9cf4e2 100644
--- a/qapi/char.json
+++ b/qapi/char.json
@@ -336,6 +336,17 @@
   'data': { 'chardev': 'str' },
   'base': 'ChardevCommon' }
 
+##
+# @ChardevMuxBe:
+#
+# Configuration info for mux-be chardevs.
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevMuxBe',
+  'data': { },
+  'base': 'ChardevCommon' }
+
 ##
 # @ChardevStdio:
 #
@@ -483,6 +494,8 @@
 #
 # @mux: (since 1.5)
 #
+# @mux-be: (since 9.2)
+#
 # @msmouse: emulated Microsoft serial mouse (since 1.5)
 #
 # @wctablet: emulated Wacom Penpartner serial tablet (since 2.9)
@@ -525,6 +538,7 @@
             'pty',
             'null',
             'mux',
+            'mux-be',
             'msmouse',
             'wctablet',
             { 'name': 'braille', 'if': 'CONFIG_BRLAPI' },
@@ -599,6 +613,16 @@
 { 'struct': 'ChardevMuxWrapper',
   'data': { 'data': 'ChardevMux' } }
 
+##
+# @ChardevMuxBeWrapper:
+#
+# @data: Configuration info for mux-be chardevs
+#
+# Since: 9.2
+##
+{ 'struct': 'ChardevMuxBeWrapper',
+  'data': { 'data': 'ChardevMuxBe' } }
+
 ##
 # @ChardevStdioWrapper:
 #
@@ -707,6 +731,7 @@
             'pty': 'ChardevPtyWrapper',
             'null': 'ChardevCommonWrapper',
             'mux': 'ChardevMuxWrapper',
+            'mux-be': 'ChardevMuxBeWrapper',
             'msmouse': 'ChardevCommonWrapper',
             'wctablet': 'ChardevCommonWrapper',
             'braille': { 'type': 'ChardevCommonWrapper',
-- 
2.34.1


