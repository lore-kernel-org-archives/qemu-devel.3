Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31447C54787
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 22:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcYoj-0003L6-Cd; Tue, 20 Feb 2024 17:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYoh-0003KZ-BQ
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:23 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rcYof-0006Lq-G2
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 17:42:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2ED6F22260;
 Tue, 20 Feb 2024 22:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgoMAKXxfuxsoYEwezCWyudDOGjW1OZjXZ8SKMknqd8=;
 b=jnR4v8XMs/qsvULFV8K3FmVrS2+SRyIRr0mG7ukGTLPB10PfjqSSW62pn6irPv3AncTLw+
 nIwfjW7AtxMHDtETCWKXVyg32jMg50rIgTn22of9g6pwhuQzBOeg0qyljul1qR7iCSOHA5
 K0VZID5ARv1dhyydxdr8gvw9OLWdZIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgoMAKXxfuxsoYEwezCWyudDOGjW1OZjXZ8SKMknqd8=;
 b=i4bBQz1kvdlNiER0B98oa/p+ouQc60Uih4AKJevBVFm8X7eOz/ClisqCGHEkwyYSSoFXsF
 Lb6GDwCaUDZv5lDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708468940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgoMAKXxfuxsoYEwezCWyudDOGjW1OZjXZ8SKMknqd8=;
 b=jnR4v8XMs/qsvULFV8K3FmVrS2+SRyIRr0mG7ukGTLPB10PfjqSSW62pn6irPv3AncTLw+
 nIwfjW7AtxMHDtETCWKXVyg32jMg50rIgTn22of9g6pwhuQzBOeg0qyljul1qR7iCSOHA5
 K0VZID5ARv1dhyydxdr8gvw9OLWdZIs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708468940;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JgoMAKXxfuxsoYEwezCWyudDOGjW1OZjXZ8SKMknqd8=;
 b=i4bBQz1kvdlNiER0B98oa/p+ouQc60Uih4AKJevBVFm8X7eOz/ClisqCGHEkwyYSSoFXsF
 Lb6GDwCaUDZv5lDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8C707139D0;
 Tue, 20 Feb 2024 22:42:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YIv6FMoq1WUlKwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 20 Feb 2024 22:42:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v4 16/34] migration/multifd: Rename
 MultiFDSend|RecvParams::data to compress_data
Date: Tue, 20 Feb 2024 19:41:20 -0300
Message-Id: <20240220224138.24759-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240220224138.24759-1-farosas@suse.de>
References: <20240220224138.24759-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jnR4v8XM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=i4bBQz1k
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2ED6F22260
X-Spamd-Bar: +
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

Use a more specific name for the compression data so we can use the
generic for the multifd core code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/multifd-zlib.c | 20 ++++++++++----------
 migration/multifd-zstd.c | 20 ++++++++++----------
 migration/multifd.h      |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 012e3bdea1..2a8f5fc9a6 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -69,7 +69,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
         err_msg = "out of memory for buf";
         goto err_free_zbuff;
     }
-    p->data = z;
+    p->compress_data = z;
     return 0;
 
 err_free_zbuff:
@@ -92,15 +92,15 @@ err_free_z:
  */
 static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
 
     deflateEnd(&z->zs);
     g_free(z->zbuff);
     z->zbuff = NULL;
     g_free(z->buf);
     z->buf = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -117,7 +117,7 @@ static void zlib_send_cleanup(MultiFDSendParams *p, Error **errp)
 static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     MultiFDPages_t *pages = p->pages;
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t out_size = 0;
     int ret;
@@ -194,7 +194,7 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
     struct zlib_data *z = g_new0(struct zlib_data, 1);
     z_stream *zs = &z->zs;
 
-    p->data = z;
+    p->compress_data = z;
     zs->zalloc = Z_NULL;
     zs->zfree = Z_NULL;
     zs->opaque = Z_NULL;
@@ -224,13 +224,13 @@ static int zlib_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void zlib_recv_cleanup(MultiFDRecvParams *p)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
 
     inflateEnd(&z->zs);
     g_free(z->zbuff);
     z->zbuff = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -246,7 +246,7 @@ static void zlib_recv_cleanup(MultiFDRecvParams *p)
  */
 static int zlib_recv_pages(MultiFDRecvParams *p, Error **errp)
 {
-    struct zlib_data *z = p->data;
+    struct zlib_data *z = p->compress_data;
     z_stream *zs = &z->zs;
     uint32_t in_size = p->next_packet_size;
     /* we measure the change of total_out */
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index dc8fe43e94..593cf290ad 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -52,7 +52,7 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int res;
 
-    p->data = z;
+    p->compress_data = z;
     z->zcs = ZSTD_createCStream();
     if (!z->zcs) {
         g_free(z);
@@ -90,14 +90,14 @@ static int zstd_send_setup(MultiFDSendParams *p, Error **errp)
  */
 static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
 
     ZSTD_freeCStream(z->zcs);
     z->zcs = NULL;
     g_free(z->zbuff);
     z->zbuff = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -114,7 +114,7 @@ static void zstd_send_cleanup(MultiFDSendParams *p, Error **errp)
 static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
 {
     MultiFDPages_t *pages = p->pages;
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
     int ret;
     uint32_t i;
 
@@ -183,7 +183,7 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
     struct zstd_data *z = g_new0(struct zstd_data, 1);
     int ret;
 
-    p->data = z;
+    p->compress_data = z;
     z->zds = ZSTD_createDStream();
     if (!z->zds) {
         g_free(z);
@@ -221,14 +221,14 @@ static int zstd_recv_setup(MultiFDRecvParams *p, Error **errp)
  */
 static void zstd_recv_cleanup(MultiFDRecvParams *p)
 {
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
 
     ZSTD_freeDStream(z->zds);
     z->zds = NULL;
     g_free(z->zbuff);
     z->zbuff = NULL;
-    g_free(p->data);
-    p->data = NULL;
+    g_free(p->compress_data);
+    p->compress_data = NULL;
 }
 
 /**
@@ -248,7 +248,7 @@ static int zstd_recv_pages(MultiFDRecvParams *p, Error **errp)
     uint32_t out_size = 0;
     uint32_t expected_size = p->normal_num * p->page_size;
     uint32_t flags = p->flags & MULTIFD_FLAG_COMPRESSION_MASK;
-    struct zstd_data *z = p->data;
+    struct zstd_data *z = p->compress_data;
     int ret;
     int i;
 
diff --git a/migration/multifd.h b/migration/multifd.h
index 8a1cad0996..6c18732827 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -129,7 +129,7 @@ typedef struct {
     /* number of iovs used */
     uint32_t iovs_num;
     /* used for compression methods */
-    void *data;
+    void *compress_data;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -185,7 +185,7 @@ typedef struct {
     /* num of non zero pages */
     uint32_t normal_num;
     /* used for de-compression methods */
-    void *data;
+    void *compress_data;
 } MultiFDRecvParams;
 
 typedef struct {
-- 
2.35.3


