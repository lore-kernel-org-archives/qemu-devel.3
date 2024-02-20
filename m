Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EA7C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:44:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYom-0003Wg-9P; Tue, 20 Feb 2024 17:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYok-0003QS-Iu
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:26 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoh-0006M1-JZ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 478C022266;
 Tue, 20 Feb 2024 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvJm8I1xBXaGK0Zp2EyoFRQ4F01lLsPXXzvB131Og8Q=;
 b=ozp4hK7nr3R2hwqZL2nAcvb88evWoEEML75LTepl1EMwFuPrAe2HUkg2K/g2r13NkzgkbK
 Z3ECn2mRq/Mr33OiaxyyEI/MByqI+CpTtwCEslOAj63grf0xv4iz3xUXaiT9MEhpBBHobW
 Z+REQSytW6j/o7fRHS6xpuvLtagLyPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvJm8I1xBXaGK0Zp2EyoFRQ4F01lLsPXXzvB131Og8Q=;
 b=w7epwd7wYU/HdKsAPWzccHmIsuRqKPMvKqH/WNkZgXxMYXMpMbOi7HFgXMTZGSN7LRhYSh
 cBLboWwUjNiP5wAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvJm8I1xBXaGK0Zp2EyoFRQ4F01lLsPXXzvB131Og8Q=;
 b=ozp4hK7nr3R2hwqZL2nAcvb88evWoEEML75LTepl1EMwFuPrAe2HUkg2K/g2r13NkzgkbK
 Z3ECn2mRq/Mr33OiaxyyEI/MByqI+CpTtwCEslOAj63grf0xv4iz3xUXaiT9MEhpBBHobW
 Z+REQSytW6j/o7fRHS6xpuvLtagLyPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468942;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvJm8I1xBXaGK0Zp2EyoFRQ4F01lLsPXXzvB131Og8Q=;
 b=w7epwd7wYU/HdKsAPWzccHmIsuRqKPMvKqH/WNkZgXxMYXMpMbOi7HFgXMTZGSN7LRhYSh
 cBLboWwUjNiP5wAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4B9E139D0;
 Tue, 20 Feb 2024 22:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4JagGswq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 17/34] migration/multifd: Decouple recv method from pages
Date: Tue, 20 Feb 2024 19:41:21 -0300
Message-Id: <20240220224138.24759-18-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ozp4hK7n;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w7epwd7w
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 478C022266
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Next patch will abstract the type of data being received by the
channels, so do some cleanup now to remove references to pages and
dependency on 'normal_num'.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c |  6 +++---
 migration/multifd-zstd.c |  6 +++---
 migration/multifd.c      | 13 ++++++++-----
 migration/multifd.h      |  4 ++--
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 2a8f5fc9a6..6120faad65 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -234,7 +234,7 @@ static void zlib_recv_cleanup(MultiFDRecvParams *p)
 }
 
 /**
- * zlib_recv_pages: read the data from the channel into actual pages
+ * zlib_recv: read the data from the channel into actual pages
  *
  * Read the compressed buffer, and uncompress it into the actual
  * pages.
@@ -244,7 +244,7 @@ static void zlib_recv_cleanup(MultiFDRecvParams *p)
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
-static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
+static int zlib_recv(MultiFDRecvParams *p, Error **errp)
 {
     struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
@@ -319,7 +319,7 @@ static MultiFDMethods multifd_zlib_ops = {
     .send_prepare = zlib_send_prepare,
     .recv_setup = zlib_recv_setup,
     .recv_cleanup = zlib_recv_cleanup,
-    .recv_pages = zlib_recv_pages
+    .recv = zlib_recv
 };
 
 static void multifd_zlib_register(void)
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 593cf290ad..cac236833d 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -232,7 +232,7 @@ static void zstd_recv_cleanup(MultiFDRecvParams *p)
 }
 
 /**
- * zstd_recv_pages: read the data from the channel into actual pages
+ * zstd_recv: read the data from the channel into actual pages
  *
  * Read the compressed buffer, and uncompress it into the actual
  * pages.
@@ -242,7 +242,7 @@ static void zstd_recv_cleanup(MultiFDRecvParams *p)
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
-static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
+static int zstd_recv(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t in_size = p->next_packet_size;
     uint32_t out_size = 0;
@@ -310,7 +310,7 @@ static MultiFDMethods multifd_zstd_ops = {
     .send_prepare = zstd_send_prepare,
     .recv_setup = zstd_recv_setup,
     .recv_cleanup = zstd_recv_cleanup,
-    .recv_pages = zstd_recv_pages
+    .recv = zstd_recv
 };
 
 static void multifd_zstd_register(void)
diff --git a/migration/multifd.c b/migration/multifd.c
index 43f0820996..5a38cb222f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -197,7 +197,7 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
 }
 
 /**
- * nocomp_recv_pages: read the data from the channel into actual pages
+ * nocomp_recv: read the data from the channel
  *
  * For no compression we just need to read things into the correct place.
  *
@@ -206,7 +206,7 @@ static void nocomp_recv_cleanup(MultiFDRecvParams *p)
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
-static int nocomp_recv_pages(MultiFDRecvParams *p, Error **errp)
+static int nocomp_recv(MultiFDRecvParams *p, Error **errp)
 {
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
 
@@ -228,7 +228,7 @@ static MultiFDMethods multifd_nocomp_ops = {
     .send_prepare = nocomp_send_prepare,
     .recv_setup = nocomp_recv_setup,
     .recv_cleanup = nocomp_recv_cleanup,
-    .recv_pages = nocomp_recv_pages
+    .recv = nocomp_recv
 };
 
 static MultiFDMethods *multifd_ops[MULTIFD_COMPRESSION__MAX] = {
@@ -1216,6 +1216,8 @@ static void *multifd_recv_thread(void *opaque)
 
     while (true) {
         uint32_t flags;
+        bool has_data = false;
+        p->normal_num = 0;
 
         if (multifd_recv_should_exit()) {
             break;
@@ -1237,10 +1239,11 @@ static void *multifd_recv_thread(void *opaque)
         flags = p->flags;
         /* recv methods don't know how to handle the SYNC flag */
         p->flags &= ~MULTIFD_FLAG_SYNC;
+        has_data = !!p->normal_num;
         qemu_mutex_unlock(&p->mutex);
 
-        if (p->normal_num) {
-            ret = multifd_recv_state->ops->recv_pages(p, &local_err);
+        if (has_data) {
+            ret = multifd_recv_state->ops->recv(p, &local_err);
             if (ret != 0) {
                 break;
             }
diff --git a/migration/multifd.h b/migration/multifd.h
index 6c18732827..9a6a7a72df 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -199,8 +199,8 @@ typedef struct {
     int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
     /* Cleanup for receiving side */
     void (*recv_cleanup)(MultiFDRecvParams *p);
-    /* Read all pages */
-    int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
+    /* Read all data */
+    int (*recv)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
-- 
2.35.3


