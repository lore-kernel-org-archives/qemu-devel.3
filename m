Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8786EC61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyyr7-0005sD-Ij; Tue, 25 Aug 2026 17:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr6-0005rw-DW
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:52 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wyyr4-000551-IH
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:38:52 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:39a2:0:640:ae2d:0])
 by forwardcorp1b.mail.yandex.net (postfix) with ESMTPS id 0068180873;
 Wed, 26 Aug 2026 00:38:49 +0300 (MSK)
Received: from i115954770.yandex-team.ru (unknown [2a02:6bf:8080:630::1:39])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id QckKa93ZVmI0-zTuvfrzm; Wed, 26 Aug 2026 00:38:48 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787693928;
 bh=BQHD+htt80RuZlwxjLMP/6d874aU12YAehXceZl63Tk=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ap38GXMIgcjjNFoUKL8YK6VQ8IIbFjdSQL7kJp+e0zIbvOZRMqFTSordUtNc68aLu
 UVyms7MOphaCOaQFLDQaHZZ7LQsPHUBXvSUDenDhl1IKfvA+xiyV+ko+w0Nj/7zQ4f
 CofX2JtwRLdGnt7/zgH+f1pt631du27YDgJaSSBM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, qemu-devel@nongnu.org, vsementsov@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Matthew Penney <matt@matthewpenney.net>
Subject: [PATCH 18/30] hw/usb/redirect.c: move to new migration APIs
Date: Wed, 26 Aug 2026 00:37:58 +0300
Message-ID: <20260825213811.3725682-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
References: <20260825213811.3725682-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 hw/usb/redirect.c | 59 ++++++++++++++++++++++++++---------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/hw/usb/redirect.c b/hw/usb/redirect.c
index dfd9e8bb50c..f4196b944d5 100644
--- a/hw/usb/redirect.c
+++ b/hw/usb/redirect.c
@@ -2267,8 +2267,9 @@ static int usbredir_post_load(void *priv, int version_id)
 }
 
 /* For usbredirparser migration */
-static int usbredir_put_parser(QEMUFile *f, void *priv, size_t unused,
-                               const VMStateField *field, JSONWriter *vmdesc)
+static bool usbredir_save_parser(QEMUFile *f, void *priv, size_t unused,
+                                 const VMStateField *field,
+                                 JSONWriter *vmdesc, Error **errp)
 {
     USBRedirDevice *dev = priv;
     uint8_t *data;
@@ -2276,7 +2277,7 @@ static int usbredir_put_parser(QEMUFile *f, void *priv, size_t unused,
 
     if (dev->parser == NULL) {
         qemu_put_be32(f, 0);
-        return 0;
+        return true;
     }
 
     usbredirparser_serialize(dev->parser, &data, &len);
@@ -2290,11 +2291,11 @@ static int usbredir_put_parser(QEMUFile *f, void *priv, size_t unused,
 
     free(data);
 
-    return 0;
+    return true;
 }
 
-static int usbredir_get_parser(QEMUFile *f, void *priv, size_t unused,
-                               const VMStateField *field)
+static bool usbredir_load_parser(QEMUFile *f, void *priv, size_t unused,
+                               const VMStateField *field, Error **errp)
 {
     USBRedirDevice *dev = priv;
     uint8_t *data;
@@ -2302,7 +2303,7 @@ static int usbredir_get_parser(QEMUFile *f, void *priv, size_t unused,
 
     len = qemu_get_be32(f);
     if (len == 0) {
-        return 0;
+        return true;
     }
 
     /*
@@ -2326,19 +2327,25 @@ static int usbredir_get_parser(QEMUFile *f, void *priv, size_t unused,
 
     g_free(data);
 
-    return ret;
+    if (ret) {
+        error_setg(errp, "usbredirparser_unserialize failed");
+        return false;
+    }
+
+    return true;
 }
 
 static const VMStateInfo usbredir_parser_vmstate_info = {
     .name = "usb-redir-parser",
-    .put  = usbredir_put_parser,
-    .get  = usbredir_get_parser,
+    .save = usbredir_save_parser,
+    .load = usbredir_load_parser,
 };
 
 
 /* For buffered packets (iso/irq) queue migration */
-static int usbredir_put_bufpq(QEMUFile *f, void *priv, size_t unused,
-                              const VMStateField *field, JSONWriter *vmdesc)
+static bool usbredir_save_bufpq(QEMUFile *f, void *priv, size_t unused,
+                                const VMStateField *field,
+                                JSONWriter *vmdesc, Error **errp)
 {
     struct endp_data *endp = priv;
     USBRedirDevice *dev = endp->dev;
@@ -2357,11 +2364,11 @@ static int usbredir_put_bufpq(QEMUFile *f, void *priv, size_t unused,
     }
     assert(i == endp->bufpq_size);
 
-    return 0;
+    return true;
 }
 
-static int usbredir_get_bufpq(QEMUFile *f, void *priv, size_t unused,
-                              const VMStateField *field)
+static bool usbredir_load_bufpq(QEMUFile *f, void *priv, size_t unused,
+                              const VMStateField *field, Error **errp)
 {
     struct endp_data *endp = priv;
     USBRedirDevice *dev = endp->dev;
@@ -2385,13 +2392,13 @@ static int usbredir_get_bufpq(QEMUFile *f, void *priv, size_t unused,
         DPRINTF("get_bufpq %d/%d len %d status %d\n", i + 1, endp->bufpq_size,
                 bufp->len, bufp->status);
     }
-    return 0;
+    return true;
 }
 
 static const VMStateInfo usbredir_ep_bufpq_vmstate_info = {
     .name = "usb-redir-bufpq",
-    .put  = usbredir_put_bufpq,
-    .get  = usbredir_get_bufpq,
+    .save = usbredir_save_bufpq,
+    .load = usbredir_load_bufpq,
 };
 
 
@@ -2468,9 +2475,9 @@ static const VMStateDescription usbredir_ep_vmstate = {
 
 
 /* For PacketIdQueue migration */
-static int usbredir_put_packet_id_q(QEMUFile *f, void *priv, size_t unused,
+static bool usbredir_save_packet_id_q(QEMUFile *f, void *priv, size_t unused,
                                     const VMStateField *field,
-                                    JSONWriter *vmdesc)
+                                    JSONWriter *vmdesc, Error **errp)
 {
     struct PacketIdQueue *q = priv;
     USBRedirDevice *dev = q->dev;
@@ -2485,11 +2492,11 @@ static int usbredir_put_packet_id_q(QEMUFile *f, void *priv, size_t unused,
     }
     assert(remain == 0);
 
-    return 0;
+    return true;
 }
 
-static int usbredir_get_packet_id_q(QEMUFile *f, void *priv, size_t unused,
-                                    const VMStateField *field)
+static bool usbredir_load_packet_id_q(QEMUFile *f, void *priv, size_t unused,
+                                    const VMStateField *field, Error **errp)
 {
     struct PacketIdQueue *q = priv;
     USBRedirDevice *dev = q->dev;
@@ -2503,13 +2510,13 @@ static int usbredir_get_packet_id_q(QEMUFile *f, void *priv, size_t unused,
         packet_id_queue_add(q, id);
     }
     assert(q->size == size);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo usbredir_ep_packet_id_q_vmstate_info = {
     .name = "usb-redir-packet-id-q",
-    .put  = usbredir_put_packet_id_q,
-    .get  = usbredir_get_packet_id_q,
+    .save = usbredir_save_packet_id_q,
+    .load = usbredir_load_packet_id_q,
 };
 
 static const VMStateDescription usbredir_ep_packet_id_queue_vmstate = {
-- 
2.43.0


