Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869CFCD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:36:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxZ1-0005Yu-41; Tue, 09 Jun 2026 10:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYy-0005TP-LX
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wWxYx-0007Yh-5Y
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 10:36:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781015778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjnAxC/Mc7CJiqlOeCM3RQtg+Isi+MArKrw26TJllhg=;
 b=b/IFUvPUF6bR+yL55Snx9rhYtSLdLYihDKBlXg/p/E5BlEUMwBCnD/Y/XUA6GDnHmbM15L
 1vL5FB8uhQQ9IouhKirBUMbZHyVN1U5WmbBnMqhDIbh6eJX6/EM6ctmsovH2vRskfiQkVO
 msrKlYSwOBgHkTKfbk9z7W3HmfmFt9M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-B5KdD12sPSuB30pBcfuKxQ-1; Tue,
 09 Jun 2026 10:36:14 -0400
X-MC-Unique: B5KdD12sPSuB30pBcfuKxQ-1
X-Mimecast-MFC-AGG-ID: B5KdD12sPSuB30pBcfuKxQ_1781015773
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 637C2195C268; Tue,  9 Jun 2026 14:36:13 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DF40D1954B02; Tue,  9 Jun 2026 14:36:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 09 Jun 2026 18:34:36 +0400
Subject: [PATCH 17/17] ui/input: remove old LED handler broadcast queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260609-ui-input-v1-17-42615deb818e@redhat.com>
References: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
In-Reply-To: <20260609-ui-input-v1-0-42615deb818e@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NHaVAaoIWOcPRSUWYUSpmvX80VOfS5rhWCqfzhbLc/A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKCR5+wamHn/U3GWgK/fyG8WzC72DYLJrVq/Ii
 f9PbSDCsy2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaigkeQAKCRDa6OEJdZac
 5XjbD/95rNhc6ceJd49DQQ4oejkRlP9MaFbb488PDCTWGM4htQA9vQWlwpNyMmK71gD5bzC9MWq
 aAbgke64qnyFhEdnWLWKQIcKbihPLCNvIlxcFRb6eaMYRiphvvTp25qy9HzBaMHWoiWPuhoCzdM
 jmQWAEKZjB+K+1PX4pFygOYXHXbg5SPowOIjNDiy87IYEpi/JPy9nzYrysC5KF5pYDFAt//NVgf
 8r0TF5Imy50Sc2Dq6JGhmfvgGOHJ/JjMYNwDgtzzYF/HAKWpQEh1gfewfoOGzueeUS7XjgShjQ/
 U3z9uxNV2VdKroZki1HCp9VsReKuA7cQpZkqmUQbdyqJtZrLgQbTDUNqGQFgXV7GL8rfUPovK1R
 aeNEBK3qBPAA6ropkiTCTlJ6WoJYSp0636nJSY8Ism1uFjJQVJcqySYFPs77Ep+BzbSobPhM5Q9
 TmCEHuOtyjM1DQd7kPjiN8w50hG+8tg6r3vPlPzAxWem8AIyhwFCzzpDZENr1MQn4U7Ync6mRfw
 DWmZ8opG27y7s5EXRIWxDI2h7BsAIJQ0BzwGp8LKtwci2kv7MS7eEQUl43lP6Q/2s7SKTO7fxHI
 Q6juojfragt+XAvKa4avC/n6OOEPgAbHekG7YNor3nN3Bi9uBb8bY39ll9cQE0ZcYzsTzwPY/9Z
 NErSgGB4Fm111Xw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
index 99a1090f8c3..b6bbfa8f128 100644
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


