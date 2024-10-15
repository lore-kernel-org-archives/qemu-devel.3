Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69B7CFC278
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:53:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dIE-00075b-Gz; Tue, 15 Oct 2024 04:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dID-00075S-5v
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dIB-0008BS-M2
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=elooLbY7k2M6MVGuTlkYRMqNz5nxbtsoK5pOiPAY6jg=;
 b=bfWw620qKar/eVp7HXF/77MDhN3ExxALUzcpZzGEAXC0T0PW6EOvwEunj3s+5PLs9PAnBm
 RaOKClvFjVnSQO8XeiG/FtJDAmxILfY20CSLcu3VD8pWn7Qrn/qQcppCEMEJ0aQ1k49yAV
 WJ10AE4Y2Vycrsx6HHQxyC/vubLMo28=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-NStpHPb-OY2FBPKHYgefZQ-1; Tue,
 15 Oct 2024 04:52:30 -0400
X-MC-Unique: NStpHPb-OY2FBPKHYgefZQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EC6281955D5D; Tue, 15 Oct 2024 08:52:29 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E55C03000198; Tue, 15 Oct 2024 08:52:27 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 7/8] chardev/mux: implement detach of frontends from mux
Date: Tue, 15 Oct 2024 12:51:49 +0400
Message-ID: <20241015085150.219486-8-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

With bitset management now it becomes feasible to implement
the logic of detaching frontends from multiplexer.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20241014152408.427700-8-r.peniaev@gmail.com>
---
 chardev/chardev-internal.h |  1 +
 chardev/char-fe.c          |  2 +-
 chardev/char-mux.c         | 21 ++++++++++++++++++---
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index b89aada541..853807f3cb 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -61,6 +61,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 
 bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
                              unsigned int *tag, Error **errp);
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 3b8771ca2a..8ac6bebb6f 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -225,7 +225,7 @@ void qemu_chr_fe_deinit(CharBackend *b, bool del)
         }
         if (CHARDEV_IS_MUX(b->chr)) {
             MuxChardev *d = MUX_CHARDEV(b->chr);
-            d->backends[b->tag] = NULL;
+            mux_chr_detach_frontend(d, b->tag);
         }
         if (del) {
             Object *obj = OBJECT(b->chr);
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 4fc619b2da..bda5c45e60 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -290,10 +290,10 @@ static void char_mux_finalize(Object *obj)
     bit = -1;
     while ((bit = find_next_bit(&d->mux_bitset, MAX_MUX, bit + 1)) < MAX_MUX) {
         CharBackend *be = d->backends[bit];
-        if (be) {
-            be->chr = NULL;
-        }
+        be->chr = NULL;
+        d->backends[bit] = NULL;
     }
+    d->mux_bitset = 0;
     qemu_chr_fe_deinit(&d->chr, false);
 }
 
@@ -332,6 +332,21 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
     return true;
 }
 
+bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
+{
+    unsigned int bit;
+
+    bit = find_next_bit(&d->mux_bitset, MAX_MUX, tag);
+    if (bit != tag) {
+        return false;
+    }
+
+    d->mux_bitset &= ~(1 << bit);
+    d->backends[bit] = NULL;
+
+    return true;
+}
+
 void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
-- 
2.47.0


