Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9422ECD8CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 11:01:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXGew-0006gO-Sz; Wed, 10 Jun 2026 06:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGes-0006Aw-NA
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wXGer-0000rN-1X
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:59:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781089168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DjnAxC/Mc7CJiqlOeCM3RQtg+Isi+MArKrw26TJllhg=;
 b=BFtShg25EG1+5FFeLzD/dHz13rRKy/TGnNa0W2nwQW9YT2bq529js1/BF2wgI+OrSfsfav
 AzZvyKUcKvFssKhsIdoR6hVwP316586WG3MaAQPjUbjD72o7xeO7kGT95aocH1pc7/3h1X
 aXQF5q63fZxKY2hYA3PlsmNFXI3S+J4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-S1bNUaZnPp2ZT8k5ayIGZQ-1; Wed,
 10 Jun 2026 06:59:25 -0400
X-MC-Unique: S1bNUaZnPp2ZT8k5ayIGZQ-1
X-Mimecast-MFC-AGG-ID: S1bNUaZnPp2ZT8k5ayIGZQ_1781089164
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30A721835E2A; Wed, 10 Jun 2026 10:59:24 +0000 (UTC)
Received: from localhost (unknown [10.44.24.21])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DC4E33000223; Wed, 10 Jun 2026 10:59:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jun 2026 14:57:04 +0400
Subject: [PATCH v2 22/22] ui/input: remove old LED handler broadcast queue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260610-ui-input-v2-22-f68452dd6a22@redhat.com>
References: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
In-Reply-To: <20260610-ui-input-v2-0-f68452dd6a22@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Peter Maydell <peter.maydell@linaro.org>, 
 qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 qemu-ppc@nongnu.org, Thomas Huth <th.huth+qemu@posteo.eu>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2215;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=NHaVAaoIWOcPRSUWYUSpmvX80VOfS5rhWCqfzhbLc/A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqKUMCLa/fQk8dnW2uYSSOvc5y5KgibiFfDhFaf
 K0WAUTlbjCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCailDAgAKCRDa6OEJdZac
 5YIHD/45615a+w90gRGk8EzG58eppx0B2URftz5YLSh7NzXY5w+8AFFTiJUo+jbAp8k1yjd+GuP
 e2M5U0C2TWVCy44ywKJKELCRYLtBWhmwFyCeaSOtop3ql0ahEfHCH8bYpRKrhrBRHVdFOFJcrkY
 PPWHpx8goVuyRCLPfTYkTFK5OrMscpGw/ePDilc6XwElJNPPbjevLByjir5nkePHWyo0hGojty9
 c89bgnl+NmsH32ACPe17qDpfPUK9aALQYGeUBKXY9zI+i7hK338KB9ei8qY7EUCgf/PenKzUcMD
 GepNICpQMDMev5USo5cmZzTDRtub1ldKDBxZBPbPSkpUrP8ww3d39CGp5v6b6QbSjRuZxUmQ9a9
 ll0Kyy/1uzJkXhwEg+Ob+3pGP49+BPsRNf94/iU36SeikSgWQMaexfGLp1aXZpX2z3HVwPPLy8R
 P4Q+Q9515h+ZrprkE9s6AADnoQM3PHEUOPXGFJjbBCqmnPpdhlcoA6aqlTYW78gPDVoyaUVu9Is
 615XZmAsMED8AZwqlFz/jGunhgiMck7WletKziJPCqKKo98Sm9hlJ8wz0MFCaTDCgeMQtZL7QsY
 eAf9DlphAcX0QLthoJuIY+0lKyfr/mM1Ebjt6VB//Qt82T0lYK7keX0W2vMQMfoIYplQokm+FSS
 /tH4yxHSD2oMu/A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


