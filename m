Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF78D1624B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2024 11:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0JUg-0006fI-3z; Mon, 14 Oct 2024 07:44:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUY-0006dF-7B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:02 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1t0JUU-00057K-PT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2024 07:44:01 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a99e3b3a411so323818166b.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2024 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728906229; x=1729511029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ynoC6ZNN5x0Gxdxw4knRNVaB7HA31bvhIUGL+XlLnyY=;
 b=nJeClDOvpRNfu1RjFnqKJtNgfUBRMMOKdTgykwG+zzy1l8gZGYLI7S45fQRQCQJEjz
 on1BRbi08Mj86pILQZ1EIlPCTwhR/SxFOn0LOfrOx4jEWjNyvJtEyZ+JZz+B6MdCkMxv
 2/9Lo+WyVGkH0YCGsSJn0B1/0qYhZhPWMPlrlqOQY+jWSYmwKaRO9BHKSIE/jMYHQ3Y3
 dIB0X35lWAhxYPde6iYo6lPh6XMSRsY4BZDgA/Y+SWuadEmdCPo2+EUnJR4MfEAap4Gj
 VQcxgqFiHS7p/c7xU7gpRqUeNGod8me9TXfRrMD5ADKwMBc8cYx+VA9G4/w/G+YuWR9F
 gIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728906229; x=1729511029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ynoC6ZNN5x0Gxdxw4knRNVaB7HA31bvhIUGL+XlLnyY=;
 b=GaqxK1Ssomy8ztPcZpdC4KQarZkb1DYa39l7nINoTSa0V+yJY6S+qDcGBDecicCLHJ
 cwNx233hdufRMdf8s8A9cKuvv3O3m494ipNgCrxzuNYFXMTCZ4DoWY8YoLC6gEYECmyY
 NWXHq60eriHkcqVHepTBBxNxiywDMRqAhPpFa3AhkyzosGUI6LWdL8iQgtZZAE3IgFax
 eUCzNfT7Kq1A2UuJ8htTFrXqjjYDDe50iyGpbzRxcuUMDbAimzMTGRYLIKqj6jtK6JkS
 NBe5BKhvENGQlPpQiYNzW+t2H5JlNak03bPCrWsZryNJRxmHcSRvUGcNi2DVVraXmM/n
 5m5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdcNLxIMzwiJdYfvDA1cwq+ljHtEcVn1TaM7SM8H1nUiwN2bpJl1mKqJZmrPIg92XT9ExPRinvhwdA@nongnu.org
X-Gm-Message-State: AOJu0YxjEbZrbr/BRL29KSXtWAYJlzp2fuLdEmk1o2fnYnKPNx6K/Vzk
 r6lTRAGgoCX15iprl8j+SNkkM1nPKGv8WKHw0dCEamXYvePG0TlP
X-Google-Smtp-Source: AGHT+IHwC2xVd5zH5TEvQBkcwn0IkJHngCZH9dFrZ649JIze5rlb28Q9KhL+srVEN3Fz6McPIvQ05g==
X-Received: by 2002:a17:906:4fd1:b0:a99:4e74:52aa with SMTP id
 a640c23a62f3a-a99b89f3f6bmr932651666b.33.1728906229237; 
 Mon, 14 Oct 2024 04:43:49 -0700 (PDT)
Received: from finn.fritz.box ([2a02:8109:8384:1400:eb7f:8fd0:f96c:766b])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99fcb2765asm247764666b.64.2024.10.14.04.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 04:43:48 -0700 (PDT)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Subject: [PATCH 6/8] chardev/mux: switch mux frontends management to bitset
Date: Mon, 14 Oct 2024 13:41:33 +0200
Message-Id: <20241014114135.389766-7-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014114135.389766-1-r.peniaev@gmail.com>
References: <20241014114135.389766-1-r.peniaev@gmail.com>
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

Frontends can be attached and detached during run-time (although detach
is not implemented, but will follow). Counter variable of muxes is not
enough for proper attach/detach management, so this patch implements
bitset: if bit is set for the `mux_bitset` variable, then frontend
device can be found in the `backend` array (yes, huge confusion with
backend and frontends names).

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c         | 41 +++++++++++++++++++++++++-------------
 chardev/char.c             |  2 +-
 chardev/chardev-internal.h |  2 +-
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 9294f955462e..9c3cacb2fecd 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
+#include "qemu/bitops.h"
 #include "chardev/char.h"
 #include "sysemu/block-backend.h"
 #include "qapi/qapi-commands-control.h"
@@ -168,12 +169,19 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
         case 'b':
             qemu_chr_be_event(chr, CHR_EVENT_BREAK);
             break;
-        case 'c':
-            assert(d->mux_cnt > 0); /* handler registered with first fe */
+        case 'c': {
+            unsigned int bit;
+
+            /* Handler registered with first fe */
+            assert(d->mux_bitset != 0);
             /* Switch to the next registered device */
-            mux_set_focus(chr, (d->focus + 1) % d->mux_cnt);
+            bit = find_next_bit(&d->mux_bitset, MAX_MUX, d->focus + 1);
+            if (bit >= MAX_MUX) {
+                bit = find_next_bit(&d->mux_bitset, MAX_MUX, 0);
+            }
+            mux_set_focus(chr, bit);
             break;
-        case 't':
+        } case 't':
             d->timestamps = !d->timestamps;
             d->timestamps_start = -1;
             d->linestart = false;
@@ -243,15 +250,16 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
-    unsigned int i;
+    int bit;
 
     if (!muxes_opened) {
         return;
     }
 
     /* Send the event to all registered listeners */
-    for (i = 0; i < d->mux_cnt; i++) {
-        mux_chr_send_event(d, i, event);
+    bit = -1;
+    while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
+        mux_chr_send_event(d, bit, event);
     }
 }
 
@@ -276,10 +284,11 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 static void char_mux_finalize(Object *obj)
 {
     MuxChardev *d = MUX_CHARDEV(obj);
-    unsigned int i;
+    int bit;
 
-    for (i = 0; i < d->mux_cnt; i++) {
-        CharBackend *be = d->backends[i];
+    bit = -1;
+    while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
+        CharBackend *be = d->backends[bit];
         if (be) {
             be->chr = NULL;
         }
@@ -304,7 +313,10 @@ static void mux_chr_update_read_handlers(Chardev *chr)
 bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp)
 {
-    if (d->mux_cnt >= MAX_MUX) {
+    unsigned int bit;
+
+    bit = find_next_zero_bit(&d->mux_bitset, MAX_MUX, 0);
+    if (bit >= MAX_MUX) {
         error_setg(errp,
                    "too many uses of multiplexed chardev '%s'"
                    " (maximum is " stringify(MAX_MUX) ")",
@@ -312,8 +324,9 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
         return false;
     }
 
-    d->backends[d->mux_cnt] = b;
-    *tag = d->mux_cnt++;
+    d->mux_bitset |= (1 << bit);
+    d->backends[bit] = b;
+    *tag = bit;
 
     return true;
 }
@@ -322,7 +335,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(focus < d->mux_cnt);
+    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) < MAX_MUX);
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
diff --git a/chardev/char.c b/chardev/char.c
index f54dc3a86286..a1722aa076d9 100644
--- a/chardev/char.c
+++ b/chardev/char.c
@@ -333,7 +333,7 @@ static bool qemu_chr_is_busy(Chardev *s)
 {
     if (CHARDEV_IS_MUX(s)) {
         MuxChardev *d = MUX_CHARDEV(s);
-        return d->mux_cnt > 0;
+        return d->mux_bitset != 0;
     } else {
         return s->be != NULL;
     }
diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 8126ce180690..b89aada5413b 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -37,8 +37,8 @@ struct MuxChardev {
     Chardev parent;
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
+    unsigned long mux_bitset;
     int focus;
-    unsigned int mux_cnt;
     bool term_got_escape;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
-- 
2.34.1


