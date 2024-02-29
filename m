Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 290D7C54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfiN9-0005aB-Sh; Thu, 29 Feb 2024 10:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiN2-0005Z7-R6
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:57 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfiN1-0005yr-2Q
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 10:30:52 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BCA27221DA;
 Thu, 29 Feb 2024 15:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=ZBfwSFGYklg4sQ+D7F5IaK4CLQetXA6LWxx6P32fYTSREkttLfnb7YEyp3jpbCAZW2YJ5N
 wWDKrfVm3GTNbhzQzLEHQ9HjRQtsYJgZRnqUPiZfnyOA93MmceJ8HzG+QrSgJm58TdjftU
 1B69dHy7wILEG8Yo3x3oQ73lfIszQ+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=9N9raIuirEm7Upwx5Yl1dRfpg9T1yat4LMlcHdvmoZ+980N/JvsyabkDtYTZzBJgod4z08
 IhrUVhIDNYvxqoBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709220649; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=ZBfwSFGYklg4sQ+D7F5IaK4CLQetXA6LWxx6P32fYTSREkttLfnb7YEyp3jpbCAZW2YJ5N
 wWDKrfVm3GTNbhzQzLEHQ9HjRQtsYJgZRnqUPiZfnyOA93MmceJ8HzG+QrSgJm58TdjftU
 1B69dHy7wILEG8Yo3x3oQ73lfIszQ+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709220649;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=9N9raIuirEm7Upwx5Yl1dRfpg9T1yat4LMlcHdvmoZ+980N/JvsyabkDtYTZzBJgod4z08
 IhrUVhIDNYvxqoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2644513503;
 Thu, 29 Feb 2024 15:30:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WByVNyej4GU/MAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 15:30:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v6 12/23] migration/multifd: Rename
 MultiFDSend|RecvParams::data to compress_data
Date: Thu, 29 Feb 2024 12:30:06 -0300
Message-Id: <20240229153017.2221-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240229153017.2221-1-farosas@suse.de>
References: <20240229153017.2221-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
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
index b3fe27ae93..adccd3532f 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -127,7 +127,7 @@ typedef struct {
     /* number of iovs used */
     uint32_t iovs_num;
     /* used for compression methods */
-    void *data;
+    void *compress_data;
 }  MultiFDSendParams;
 
 typedef struct {
@@ -183,7 +183,7 @@ typedef struct {
     /* num of non zero pages */
     uint32_t normal_num;
     /* used for de-compression methods */
-    void *data;
+    void *compress_data;
 } MultiFDRecvParams;
 
 typedef struct {
-- 
2.35.3


