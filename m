Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE465CD98F7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:26:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZs8z-0002dl-PH; Wed, 17 Jun 2026 11:25:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8x-0002T1-6v
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wZs8u-0004ru-7k
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 11:25:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781709927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vRgRmoSAIkzTdc0JlaaJODhVRFFDyYiny91wEeRJfd8=;
 b=Y/vhaZHC/MKC8XHp35HJJT+o1GrSRpSac+9HxNi8NQKD5SBMJVQOf7NLiJy5R0dbooZ9/S
 QXngeM2jm5gi+BFmMT72n7xHOo/MQSRZSF/6n8SMDjvfhbmBrCKJwgbqc4c0hWUj3z94/A
 1WwRF+y0clp18E6TjollNaPXcvgpE8c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-211-5neDSDp7Pq2FWo6da9OKxw-1; Wed,
 17 Jun 2026 11:25:26 -0400
X-MC-Unique: 5neDSDp7Pq2FWo6da9OKxw-1
X-Mimecast-MFC-AGG-ID: 5neDSDp7Pq2FWo6da9OKxw_1781709925
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 824FA1801305
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 15:25:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86F3A3008B3D; Wed, 17 Jun 2026 15:25:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 17 Jun 2026 19:23:19 +0400
Subject: [GIT PULL 22/27] ui/input: remove old LED handler broadcast queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260617-ui-input-v1-22-79e9aedc5899@redhat.com>
References: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
In-Reply-To: <20260617-ui-input-v1-0-79e9aedc5899@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2279;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=e5HT58sFFCUEIWIY5Or/MSvHFBjwxe4l3HiTriRj3Uo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqMrvp291D7x/PzED/iJEtfMr3FjG9uoDdMF9nR
 YuFXlXl1OGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCajK76QAKCRDa6OEJdZac
 5bWpD/kBM5mOevKpNNaOGUqwtYXp080tPy1JOCIHd01oVUe4Pz8zzuejAIN565aE985xoGS6Sgd
 AoUjiyI/UKTkgcUpTi5XN8f5EKHNUWKe8J1VRGNo5xoEtiRi0whrie3tz2aE80u+XpwBND/eE4c
 EavDgo+Qg9BcmSGWbIKLJ0Xlm0nCxZMWW8w4exHHil82HYHsgCrA2vcygnPQO4ZGzzheHEQLC6j
 Yr/OMK7n4Oxykgj4Nf13IVG/N6Y4g6t0WGYy3d3rOiIeWI2639rbR8HBxjhXStNn1XaNCTrfdg/
 DfnzW/Bby/xKedcQKwVVizEHGWY49S3WueLXkTGu7MbN9rmoBUCHt3iwvoCjaVOorZUOlYVqMaV
 t1Q4A4orCLfRjI7PrCLCZxW+c+FRXO8YT2Aw4PQ/9ssPvZZIm8BDgG3SB0BAt5z+vJj/t6YReGW
 koPgf2V7ChhyByBuqP1x2+FeNAu9EFnu7ec88dcHzed5qbYeSGwDejVBIS05C970vE2NGRR2y6Z
 fMD5acW5XuYqrT9xvwG0cm3ER6RtgHt9edAJrB7QR0CW6b4zBW7X0aqtivGsp0lVEZcG58dEsTg
 aFZocoZPpiF2Uyf2m/hUsAarB5Y7InU3VUlOFHBY3+9eplax+/+mavl/HDxibMbyLfShNYXFQFs
 l+FGxMqxBxOz4VA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/ui/console.h |  9 ---------
 ui/input.c           | 40 ----------------------------------------
 2 files changed, 49 deletions(-)

diff --git a/include/ui/console.h b/include/ui/console.h
index 0299ed4b566..b7bfecb6ee9 100644
--- a/include/ui/console.h
+++ b/include/ui/console.h
@@ -54,15 +54,6 @@ enum qemu_color_names {
 #define ATTR2CHTYPE(c, fg, bg, bold) \
     ((bold) << 21 | (bg) << 11 | (fg) << 8 | (c))
 
-typedef void QEMUPutLEDEvent(void *opaque, int ledstate);
-
-typedef struct QEMUPutLEDEntry QEMUPutLEDEntry;
-
-QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func, void *opaque);
-void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry);
-
-void kbd_put_ledstate(int ledstate);
-
 bool qemu_mouse_set(int index, Error **errp);
 
 /* keysym is a unicode code except for special keys (see QEMU_KEY_xxx
diff --git a/ui/input.c b/ui/input.c
index 3e362c05787..40a0d507de5 100644
--- a/ui/input.c
+++ b/ui/input.c
@@ -689,46 +689,6 @@ void qemu_input_touch_event(QemuConsole *con,
     }
 }
 
-struct QEMUPutLEDEntry {
-    QEMUPutLEDEvent *put_led;
-    void *opaque;
-    QTAILQ_ENTRY(QEMUPutLEDEntry) next;
-};
-
-static QTAILQ_HEAD(, QEMUPutLEDEntry) led_handlers =
-    QTAILQ_HEAD_INITIALIZER(led_handlers);
-
-QEMUPutLEDEntry *qemu_add_led_event_handler(QEMUPutLEDEvent *func,
-                                            void *opaque)
-{
-    QEMUPutLEDEntry *s;
-
-    s = g_new0(QEMUPutLEDEntry, 1);
-
-    s->put_led = func;
-    s->opaque = opaque;
-    QTAILQ_INSERT_TAIL(&led_handlers, s, next);
-    return s;
-}
-
-void qemu_remove_led_event_handler(QEMUPutLEDEntry *entry)
-{
-    if (entry == NULL) {
-        return;
-    }
-    QTAILQ_REMOVE(&led_handlers, entry, next);
-    g_free(entry);
-}
-
-void kbd_put_ledstate(int ledstate)
-{
-    QEMUPutLEDEntry *cursor;
-
-    QTAILQ_FOREACH(cursor, &led_handlers, next) {
-        cursor->put_led(cursor->opaque, ledstate);
-    }
-}
-
 void qmp_send_key(KeyValueList *keys, bool has_hold_time, int64_t hold_time,
                   Error **errp)
 {

-- 
2.54.0


