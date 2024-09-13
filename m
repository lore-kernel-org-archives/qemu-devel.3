Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFB1FC6172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:20:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spCls-0007GF-Ks; Fri, 13 Sep 2024 16:20:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sp9Ir-0005fs-9R
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:37:49 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1sp9Io-0000gB-1e
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 12:37:48 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so292052066b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 09:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726245464; x=1726850264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ag6qOqMaXph1T0IRRg/LvOaZYtEe5OQtIKW2UDboHXg=;
 b=TbrjrWCG0kUJdP9ZRY34tSJ3rrZNGr/mLbQoECn36lCsfQ/eJFhinvSDfW3WINM9E+
 QrW+OHAFvVA/7B70oMLgbqdC7C7zc7TJ7sBp2W5z3G1L+7OyD+mPapFSE9rkPJN/k1VR
 Mwu/GTMiposJR9QWgFs6ryyP6yUanJ+c+xpfkri3tnKZQWNswhIMEDSRaxNVz7FX+GP3
 mg9BKWs47/35EexG4YDDQlPYCZRIEonLtWdy3I5k9sSjD9U0aGYQXLUGdbKrctWCh0er
 JRkQkzkwAX23ZPZsF7BtwRf80nzh/bcZBSgDoS+s5MYBLZz6O18q1GPIxHHXC92t5g6E
 X9pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726245464; x=1726850264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ag6qOqMaXph1T0IRRg/LvOaZYtEe5OQtIKW2UDboHXg=;
 b=uUSXCtvUavr3x3vVIRyoJ+xPqtqQpc2xHFQKTHzqjBuqmaH/86fUzQiQsiPdbzO4qC
 AS1K+cEqhsMNL5V9EiQ4emlNalodKmkTYlgnmmB4CUGOor1JbyCxjTyqqVQ6lQI5WZBE
 KUjPswQU20iF8yDcw/RVktZzD2XAP5kcfmpwQ/dN+RqqVcXZByp+H/1ta4hJhP0udiza
 M6TgVZdveSBXazSWp92D2eyBfvlCnBy4HNorFzcofPWP26KraANGr6CvdS7uRad6O77H
 fSzLy9+doCVtABVheGCy87hZYdREutM5g2GCwWfLc2V7ocffEUt3aD0S1wqM+d3LuAOF
 81hQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ02GI4wAndTDOhNtLstDk8csary4zBmPWFU9HnZoJM6Xh9PEUtVeP0TWvev6JhJUkkx2e8nbL/Ell@nongnu.org
X-Gm-Message-State: AOJu0YzfYsd44n13aF6LgWQJNzifKWU47KUWgEBd8S3FX/QnHlblPsyq
 LKi/+yEgd0UKYQW5UR5151GzbRbWQohkD1jhuEjXlwR4KgNVbL4V/ElR6w==
X-Google-Smtp-Source: AGHT+IFwtmqERl7xRcUo+UjjTwgI9zuBxWuIDU5N0prWdodOsE/tkUQ64y9jphrQrWpfU3uFnUAGNw==
X-Received: by 2002:a17:906:794b:b0:a86:a4b1:d2b8 with SMTP id
 a640c23a62f3a-a90293b1860mr646213566b.4.1726245462676; 
 Fri, 13 Sep 2024 09:37:42 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:24fe:3d15:e808:f6ec])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25c7286esm878983366b.138.2024.09.13.09.37.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 09:37:42 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: [PATCH 1/2] chardev: implement backend chardev multiplexing
Date: Fri, 13 Sep 2024 18:36:35 +0200
Message-Id: <20240913163636.253949-2-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913163636.253949-1-r.peniaev@gmail.com>
References: <20240913163636.253949-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=r.peniaev@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 13 Sep 2024 16:19:54 -0400
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

  -chardev socket,path=/tmp/sock,server=on,wait=off,id=sock0 \
  -chardev vc,id=vc0 \
  -chardev mux,id=mux0,chardev=vc0,,sock0 \
  -device virtconsole,chardev=mux0 \
  -vnc 0.0.0.0:0

Which creates 2 backend devices: text virtual console (`vc0`)
and a socket (`sock0`) connected to the single virtio hvc
console with the multiplexer (`mux0`) help. `vc0` renders
text to an image, which can be shared over the VNC protocol.
`sock0` is a socket backend which provides biderectional
communication to the virtio hvc console.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-fe.c          |  14 +++--
 chardev/char-mux.c         | 120 +++++++++++++++++++++++++++++--------
 chardev/char.c             |   2 +-
 chardev/chardev-internal.h |   7 ++-
 4 files changed, 111 insertions(+), 32 deletions(-)

diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b214ba3802b1..d1f67338084d 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -197,16 +197,22 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
         if (CHARDEV_IS_MUX(s)) {
             MuxChardev *d = MUX_CHARDEV(s);
 
-            if (d->mux_cnt >= MAX_MUX) {
+            if (d->fe_cnt >= MAX_MUX) {
                 error_setg(errp,
                            "too many uses of multiplexed chardev '%s'"
                            " (maximum is " stringify(MAX_MUX) ")",
                            s->label);
                 return false;
             }
-
-            d->backends[d->mux_cnt] = b;
-            tag = d->mux_cnt++;
+            if (d->fe_cnt > 0 && d->be_cnt > 1) {
+                error_setg(errp,
+                           "multiplexed chardev '%s' is already used "
+                           "for backend multiplexing",
+                           s->label);
+                return false;
+            }
+            d->backends[d->fe_cnt] = b;
+            tag = d->fe_cnt++;
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index ee2d47b20d9b..82f728b5caf8 100644
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
@@ -40,13 +41,39 @@
  */
 static bool muxes_opened = true;
 
+/* Write to all backends  */
+static int mux_chr_fe_write(MuxChardev *mux, const uint8_t *buf, int len)
+{
+        int r, ret = -1, i;
+
+        for (i = 0; i < mux->be_cnt; i++) {
+                r = qemu_chr_fe_write(&mux->chrs[i], buf, len);
+                ret = ret < 0 ? r : MAX(r, ret);
+        }
+
+        return ret;
+}
+
+/* Write to all backends  */
+static int mux_chr_fe_write_all(MuxChardev *mux, const uint8_t *buf, int len)
+{
+        int r, ret = -1, i;
+
+        for (i = 0; i < mux->be_cnt; i++) {
+                r = qemu_chr_fe_write_all(&mux->chrs[i], buf, len);
+                ret = ret < 0 ? r : MAX(r, ret);
+        }
+
+        return ret;
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
 
@@ -71,11 +98,11 @@ static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
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
@@ -168,9 +195,9 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
             qemu_chr_be_event(chr, CHR_EVENT_BREAK);
             break;
         case 'c':
-            assert(d->mux_cnt > 0); /* handler registered with first fe */
+            assert(d->fe_cnt > 0); /* handler registered with first fe */
             /* Switch to the next registered device */
-            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
+            mux_set_focus(chr, (d->focus + 1) % d->fe_cnt);
             break;
         case 't':
             d->timestamps = !d->timestamps;
@@ -248,8 +275,8 @@ void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
         return;
     }
 
-    /* Send the event to all registered listeners */
-    for (i = 0; i < d->mux_cnt; i++) {
+    /* Send the event to all registered frontend listeners */
+    for (i = 0; i < d->fe_cnt; i++) {
         mux_chr_send_event(d, i, event);
     }
 }
@@ -262,8 +289,16 @@ static void mux_chr_event(void *opaque, QEMUChrEvent event)
 static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 {
     MuxChardev *d = MUX_CHARDEV(s);
-    Chardev *chr = qemu_chr_fe_get_driver(&d->chr);
-    ChardevClass *cc = CHARDEV_GET_CLASS(chr);
+    Chardev *chr;
+    ChardevClass *cc;
+
+    if (d->be_cnt > 1) {
+            /* TODO: multiple backends have to be combined on a single watch */
+            return NULL;
+    }
+
+    chr = qemu_chr_fe_get_driver(&d->chrs[0]);
+    cc = CHARDEV_GET_CLASS(chr);
 
     if (!cc->chr_add_watch) {
         return NULL;
@@ -277,27 +312,32 @@ static void char_mux_finalize(Object *obj)
     MuxChardev *d = MUX_CHARDEV(obj);
     int i;
 
-    for (i = 0; i < d->mux_cnt; i++) {
+    for (i = 0; i < d->fe_cnt; i++) {
         CharBackend *be = d->backends[i];
         if (be) {
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
@@ -305,7 +345,7 @@ void mux_set_focus(Chardev *chr, int focus)
     MuxChardev *d = MUX_CHARDEV(chr);
 
     assert(focus >= 0);
-    assert(focus < d->mux_cnt);
+    assert(focus < d->fe_cnt);
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
@@ -324,19 +364,49 @@ static void qemu_chr_open_mux(Chardev *chr,
     ChardevMux *mux = backend->u.mux.data;
     Chardev *drv;
     MuxChardev *d = MUX_CHARDEV(chr);
-
-    drv = qemu_chr_find(mux->chardev);
-    if (drv == NULL) {
-        error_setg(errp, "mux: base chardev %s not found", mux->chardev);
+    const char *offset, *chardevs;
+    int length, i;
+
+    if (d->fe_cnt > 1) {
+        error_setg(errp,
+                   "multiplexed chardev '%s' is already used "
+                   "for frontend multiplexing",
+                   chr->label);
         return;
     }
 
+    chardevs = mux->chardev;
+    for (i = 0; i < MAX_MUX; i++) {
+        char *chardev;
+
+        offset = qemu_strchrnul(chardevs, ',');
+        length = offset - chardevs;
+        if (!length) {
+            break;
+        }
+        chardev = strndupa(chardevs, length);
+        chardevs += length + 1;
+        drv = qemu_chr_find(chardev);
+        if (drv == NULL) {
+            error_setg(errp, "mux: base chardev %s not found", chardev);
+            goto deinit_on_error;
+        }
+        qemu_chr_fe_init(&d->chrs[i], drv, errp);
+        d->be_cnt += 1;
+    }
     d->focus = -1;
     /* only default to opened state if we've realized the initial
      * set of muxes
      */
     *be_opened = muxes_opened;
-    qemu_chr_fe_init(&d->chr, drv, errp);
+
+    return;
+
+deinit_on_error:
+    for (i = 0; i < d->be_cnt; i++) {
+        qemu_chr_fe_deinit(&d->chrs[i], false);
+    }
+    d->be_cnt = 0;
 }
 
 static void qemu_chr_parse_mux(QemuOpts *opts, ChardevBackend *backend,
diff --git a/chardev/char.c b/chardev/char.c
index ba847b6e9eff..2643c79e5749 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
-        return d->mux_cnt >= 0;
+        return d->fe_cnt >= 0;
     } else {
         return s->be != NULL;
     }
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 4e03af31476c..72c2e4da7552 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -35,10 +35,13 @@
 
 struct MuxChardev {
     Chardev parent;
+    /* Linked frontends */
     CharBackend *backends[MAX_MUX];
-    CharBackend chr;
+    /* Linked backends */
+    CharBackend chrs[MAX_MUX];
     int focus;
-    int mux_cnt;
+    int fe_cnt;
+    int be_cnt;
     int term_got_escape;
     int max_size;
     /* Intermediate input buffer catches escape sequences even if the
-- 
2.34.1


