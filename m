Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC34CCFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dI3-00073w-18; Tue, 15 Oct 2024 04:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dHz-00072P-5x
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dHw-00089j-3q
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982338;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k/XRfwmcrhHo6bRBMo1Ajn6i9VizFBtid5loVU0rVxc=;
 b=ITfcSKH33c+pLPLvHsLhlbTZKiclx6KPvIVc3XWM/d/T4PK7T3L7evqv37SWorBDJT6JQk
 pAM117jmJTXTIjWBrRSez1ikPZC322g1t9Qo9OARNFlPBVNkvSIv7bgOarLuWV5gj1a+6X
 Zke+oANJiEoIhiGsbi/xkyJw7fmLtuE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-YUu35J8KMC-KySGf--fTRQ-1; Tue,
 15 Oct 2024 04:52:10 -0400
X-MC-Unique: YUu35J8KMC-KySGf--fTRQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 816C71955EEA; Tue, 15 Oct 2024 08:52:09 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 59EC91956089; Tue, 15 Oct 2024 08:52:07 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 3/8] chardev/mux: use bool type for `linestart` and
 `term_got_escape`
Date: Tue, 15 Oct 2024 12:51:45 +0400
Message-ID: <20241015085150.219486-4-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
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

Those are boolean variables, not signed integers.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20241014152408.427700-4-r.peniaev@gmail.com>
---
 chardev/chardev-internal.h |  4 ++--
 chardev/char-mux.c         | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index c3024b51fd..975c16de80 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -39,7 +39,7 @@ struct MuxChardev {
     CharBackend chr;
     int focus;
     int mux_cnt;
-    int term_got_escape;
+    bool term_got_escape;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
@@ -49,7 +49,7 @@ struct MuxChardev {
     int timestamps;
 
     /* Protected by the Chardev chr_write_lock.  */
-    int linestart;
+    bool linestart;
     int64_t timestamps_start;
 };
 typedef struct MuxChardev MuxChardev;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index ee2d47b20d..728596c6f3 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -73,11 +73,11 @@ static int mux_chr_write(Chardev *chr, const uint8_t *buf, int len)
                  * qemu_chr_fe_write and background I/O callbacks */
                 qemu_chr_fe_write_all(&d->chr,
                                       (uint8_t *)buf1, strlen(buf1));
-                d->linestart = 0;
+                d->linestart = false;
             }
             ret += qemu_chr_fe_write(&d->chr, buf + i, 1);
             if (buf[i] == '\n') {
-                d->linestart = 1;
+                d->linestart = true;
             }
         }
     }
@@ -145,7 +145,7 @@ static void mux_chr_be_event(Chardev *chr, QEMUChrEvent event)
 static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
 {
     if (d->term_got_escape) {
-        d->term_got_escape = 0;
+        d->term_got_escape = false;
         if (ch == term_escape_char) {
             goto send_char;
         }
@@ -175,11 +175,11 @@ static int mux_proc_byte(Chardev *chr, MuxChardev *d, int ch)
         case 't':
             d->timestamps = !d->timestamps;
             d->timestamps_start = -1;
-            d->linestart = 0;
+            d->linestart = false;
             break;
         }
     } else if (ch == term_escape_char) {
-        d->term_got_escape = 1;
+        d->term_got_escape = true;
     } else {
     send_char:
         return 1;
-- 
2.47.0


