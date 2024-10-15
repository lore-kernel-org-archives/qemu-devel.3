Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329E9CFC276
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dI6-00074j-VG; Tue, 15 Oct 2024 04:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dI3-00073y-Fb
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dI2-0008Aq-1M
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982344;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PxC9hmQbpuisQv0zzh5GHiArddQNkm0yVIPpV/eZueE=;
 b=NldoWOOwSHbXWsIiQ80s5y0pZ/X7PRbTR434HpDm8NlIZbTGbcdkQo1eSz88MDvqHR7qkh
 a9+KYU3i7gdO3na/f39ZxzhKwRjFu8b+WARkioEq6sOQzPRSzKf/d3NeMJs+CeN52PQqKh
 3hL9JjsfgX+0QXL68VMoYqJWBeDEhPk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-GiDg4mbjPWev8VRC8EC0QA-1; Tue,
 15 Oct 2024 04:52:20 -0400
X-MC-Unique: GiDg4mbjPWev8VRC8EC0QA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1CE351955D5B; Tue, 15 Oct 2024 08:52:19 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1DC251956056; Tue, 15 Oct 2024 08:52:17 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 5/8] chardev/mux: introduce `mux_chr_attach_frontend() call
Date: Tue, 15 Oct 2024 12:51:47 +0400
Message-ID: <20241015085150.219486-6-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Move away logic which attaches frontend device to a mux
from `char-fe.c` to actual `char-mux.c` implementation
and make it a separate function.

No logic changes are made.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20241014152408.427700-6-r.peniaev@gmail.com>
---
 chardev/chardev-internal.h |  2 ++
 chardev/char-fe.c          |  9 +--------
 chardev/char-mux.c         | 17 +++++++++++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index ab93f6ea17..8126ce1806 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -59,6 +59,8 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 #define CHARDEV_IS_MUX(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
 
+bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
+                             unsigned int *tag, Error **errp);
 void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index 69b47d16bd..3b8771ca2a 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -197,16 +197,9 @@ bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
         if (CHARDEV_IS_MUX(s)) {
             MuxChardev *d = MUX_CHARDEV(s);
 
-            if (d->mux_cnt >= MAX_MUX) {
-                error_setg(errp,
-                           "too many uses of multiplexed chardev '%s'"
-                           " (maximum is " stringify(MAX_MUX) ")",
-                           s->label);
+            if (!mux_chr_attach_frontend(d, b, &tag, errp)) {
                 return false;
             }
-
-            d->backends[d->mux_cnt] = b;
-            tag = d->mux_cnt++;
         } else if (s->be) {
             error_setg(errp, "chardev '%s' is already in use", s->label);
             return false;
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index b2d7abf2fc..9294f95546 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -301,6 +301,23 @@ static void mux_chr_update_read_handlers(Chardev *chr)
                                   chr->gcontext, true, false);
 }
 
+bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
+                             unsigned int *tag, Error **errp)
+{
+    if (d->mux_cnt >= MAX_MUX) {
+        error_setg(errp,
+                   "too many uses of multiplexed chardev '%s'"
+                   " (maximum is " stringify(MAX_MUX) ")",
+                   d->parent.label);
+        return false;
+    }
+
+    d->backends[d->mux_cnt] = b;
+    *tag = d->mux_cnt++;
+
+    return true;
+}
+
 void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
-- 
2.47.0


