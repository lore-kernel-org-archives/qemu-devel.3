Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA43FCFC279
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 08:53:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0dI4-00074A-Lt; Tue, 15 Oct 2024 04:52:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dHz-00072Q-5m
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1t0dHw-00089e-3u
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 04:52:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728982337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kanwf6jpaulQ85eKNKkpizPtZrgkkFI/YQtvjEV895Q=;
 b=fRK/qpc7TmjwPiL/APmr4f7E0PfLoZqEiOt8Z3skjaqb3y2nH+gwwb3Ldh9Mc3+yxvX2iH
 tfCKpad2LIshvyFC/Nk3fZSF4BRAJyBfPSYH3XDR9fbZKAfLo/j1G5kAzvcn8c6jMcje2f
 Qtz4H1Z8pdzIv+tc7N/UN98W9IV3qYE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-ccfmMU78PyeiYtFHr-aWFQ-1; Tue,
 15 Oct 2024 04:52:15 -0400
X-MC-Unique: ccfmMU78PyeiYtFHr-aWFQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53E211956048; Tue, 15 Oct 2024 08:52:14 +0000 (UTC)
Received: from localhost (unknown [10.39.208.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F93519560A2; Tue, 15 Oct 2024 08:52:12 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 4/8] chardev/mux: convert size members to unsigned int
Date: Tue, 15 Oct 2024 12:51:46 +0400
Message-ID: <20241015085150.219486-5-marcandre.lureau@redhat.com>
In-Reply-To: <20241015085150.219486-1-marcandre.lureau@redhat.com>
References: <20241015085150.219486-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

There is no sense to keep `focus`, `mux_cnt`, `prod`, `cons`
and `tag` variables as signed, those represent either size,
either position in array, which both are unsigned.

`focus` member of `MuxChardev` is kept signed, because initially
set to -1.

Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Cc: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20241014152408.427700-5-r.peniaev@gmail.com>
---
 chardev/chardev-internal.h |  8 ++++----
 include/chardev/char-fe.h  |  2 +-
 chardev/char-fe.c          |  2 +-
 chardev/char-mux.c         | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/chardev/chardev-internal.h b/chardev/chardev-internal.h
index 975c16de80..ab93f6ea17 100644
--- a/chardev/chardev-internal.h
+++ b/chardev/chardev-internal.h
@@ -38,14 +38,14 @@ struct MuxChardev {
     CharBackend *backends[MAX_MUX];
     CharBackend chr;
     int focus;
-    int mux_cnt;
+    unsigned int mux_cnt;
     bool term_got_escape;
     /* Intermediate input buffer catches escape sequences even if the
        currently active device is not accepting any input - but only until it
        is full as well. */
     unsigned char buffer[MAX_MUX][MUX_BUFFER_SIZE];
-    int prod[MAX_MUX];
-    int cons[MAX_MUX];
+    unsigned int prod[MAX_MUX];
+    unsigned int cons[MAX_MUX];
     int timestamps;
 
     /* Protected by the Chardev chr_write_lock.  */
@@ -59,7 +59,7 @@ DECLARE_INSTANCE_CHECKER(MuxChardev, MUX_CHARDEV,
 #define CHARDEV_IS_MUX(chr)                             \
     object_dynamic_cast(OBJECT(chr), TYPE_CHARDEV_MUX)
 
-void mux_set_focus(Chardev *chr, int focus);
+void mux_set_focus(Chardev *chr, unsigned int focus);
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event);
 
 Object *get_chardevs_root(void);
diff --git a/include/chardev/char-fe.h b/include/chardev/char-fe.h
index 3310449eaf..8ef05b3dd0 100644
--- a/include/chardev/char-fe.h
+++ b/include/chardev/char-fe.h
@@ -20,7 +20,7 @@ struct CharBackend {
     IOReadHandler *chr_read;
     BackendChangeHandler *chr_be_change;
     void *opaque;
-    int tag;
+    unsigned int tag;
     bool fe_is_open;
 };
 
diff --git a/chardev/char-fe.c b/chardev/char-fe.c
index b214ba3802..69b47d16bd 100644
--- a/chardev/char-fe.c
+++ b/chardev/char-fe.c
@@ -191,7 +191,7 @@ bool qemu_chr_fe_backend_open(CharBackend *be)
 
 bool qemu_chr_fe_init(CharBackend *b, Chardev *s, Error **errp)
 {
-    int tag = 0;
+    unsigned int tag = 0;
 
     if (s) {
         if (CHARDEV_IS_MUX(s)) {
diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 728596c6f3..b2d7abf2fc 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -124,7 +124,8 @@ static void mux_print_help(Chardev *chr)
     }
 }
 
-static void mux_chr_send_event(MuxChardev *d, int mux_nr, QEMUChrEvent event)
+static void mux_chr_send_event(MuxChardev *d, unsigned int mux_nr,
+                               QEMUChrEvent event)
 {
     CharBackend *be = d->backends[mux_nr];
 
@@ -242,7 +243,7 @@ static void mux_chr_read(void *opaque, const uint8_t *buf, int size)
 void mux_chr_send_all_event(Chardev *chr, QEMUChrEvent event)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
-    int i;
+    unsigned int i;
 
     if (!muxes_opened) {
         return;
@@ -275,7 +276,7 @@ static GSource *mux_chr_add_watch(Chardev *s, GIOCondition cond)
 static void char_mux_finalize(Object *obj)
 {
     MuxChardev *d = MUX_CHARDEV(obj);
-    int i;
+    unsigned int i;
 
     for (i = 0; i < d->mux_cnt; i++) {
         CharBackend *be = d->backends[i];
@@ -300,11 +301,10 @@ static void mux_chr_update_read_handlers(Chardev *chr)
                                   chr->gcontext, true, false);
 }
 
-void mux_set_focus(Chardev *chr, int focus)
+void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(focus >= 0);
     assert(focus < d->mux_cnt);
 
     if (d->focus != -1) {
-- 
2.47.0


