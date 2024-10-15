Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718CDCFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dI8-000752-0k; Tue, 15 Oct 2024 04:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dI4-00074N-Rl
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dI2-0008Av-TX
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FX5rkXQSv2JrIBOkEoNjse+4RoZV6uSbYizMs/zWw7Q=;
 b=M0JD7Iq3O66vXee6BOjz9mGG7l9bjb1Dn3szvdnVh5R20p5hzrdR4DYCNY+ItaFy4JSPoz
 F0r8tnHa+6MGDloZ72KMxPRkGLNR8CaBzPqfjVWHyXPnWH/4hPsyTrkEr7OELYykO+8Cdo
 ob8S+QjCixjDt+PED87mgbw6mAkGaNM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-497-3C1CkyTCMIWe9754Q_7TyA-1; Tue,
 15 Oct 2024 04:52:24 -0400
X-MC-Unique: 3C1CkyTCMIWe9754Q_7TyA-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 125231955F0B; Tue, 15 Oct 2024 08:52:24 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AEF7119560AE; Tue, 15 Oct 2024 08:52:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 6/8] chardev/mux: switch mux frontends management to bitset
Date: Tue, 15 Oct 2024 12:51:48 +0400
Message-ID: <20241015085150.219486-7-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.076,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Roman Penyaev <r.peniaev@gmail.com>

Frontends can be attached and detached during run-time (although detach
is not implemented, but will follow). Counter variable of muxes is not
enough for proper attach/detach management, so this patch implements
bitset: if bit is set for the `mux_bitset` variable, then frontend
device can be found in the `backend` array (yes, huge confusion with
backend and frontends names).

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20241014152408.427700-7-r.peniaev@gmail.com>
---
 chardev/chardev-internal.h |  2 +-
 chardev/char-mux.c         | 42 +++++++++++++++++++++++++-------------
 chardev/char.c             |  2 +-
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 8126ce1806..b89aada541 100644
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
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 9294f95546..4fc619b2da 100644
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
@@ -243,15 +251,16 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
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
 
@@ -276,10 +285,11 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
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
@@ -304,7 +314,10 @@ static void mux_chr_update_read_handlers(Chardev *chr)
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
@@ -312,8 +325,9 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
         return false;
     }
 
-    d->backends[d->mux_cnt] = b;
-    *tag = d->mux_cnt++;
+    d->mux_bitset |= (1 << bit);
+    d->backends[bit] = b;
+    *tag = bit;
 
     return true;
 }
@@ -322,7 +336,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(focus < d->mux_cnt);
+    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) == focus);
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
diff --git a/chardev/char.c b/chardev/char.c
index f54dc3a862..a1722aa076 100644
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
-- 
2.47.0


