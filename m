Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C7AC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 15:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfLkz-0006bg-Kn; Wed, 28 Feb 2024 10:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLky-0006bO-3N
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:04 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfLkv-00056c-Je
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 10:22:03 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F19DF1F7D4;
 Wed, 28 Feb 2024 15:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=SWhRB/Pop5XQIwZ5bL2zZwJsKsiCe+YLRchIntTviAhsn3lAr+cV4UbLVqg9m/qSkqupxv
 6YvMod8xRt8n9Cps0W36jLyDEzD2YH554R9hq9ACyalZYa53HCi9VS1p46e1Kb/t/Ev4Ht
 R3/xugIgAR3SpPSxovJvczwOu7BGSzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=IqL0fhtSGxlEz9vCxg9dqf9fMNlNGZckAD6we3uGHAtPTeivGo9h3D9/c4Udr9/34uVG3C
 +e6KJVTln2gY3GDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709133719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=MAOBOLjrSd9N2Tne+aUSEkB7Vxm25oP7dE57NnQIIisBw7eR4G31rHqgMMGfmNXSn0Q6+d
 FlNyQjAKHaJtIqxybGTe/h4/P9BX+VHXgwlNMAnczGso86PvM7wr2c5hyMzwegTmE1XaFN
 aBFUG5RTWGgK+nra10j+W7reQBODGV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709133719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2X4H+ZCs3Wx1x9/74xjRwy8vzzKCGAZEsCUpqGoGzMI=;
 b=sJyTFFG0S3nw6+IWgkMS/elu1jUCgOw2uX3qfX3GggqKPBXlOHKbKwbV/4lxkvtmmoY4xU
 WXc++iO+670Hb/BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E25013A5D;
 Wed, 28 Feb 2024 15:21:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SFS0CZZP32UPAwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Feb 2024 15:21:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, Peter Xu <peterx@redhat.com>,
 Claudio Fontana <cfontana@suse.de>
Subject: [PATCH v5 12/23] migration/multifd: Rename
 MultiFDSend|RecvParams::data to compress_data
Date: Wed, 28 Feb 2024 12:21:16 -0300
Message-Id: <20240228152127.18769-13-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240228152127.18769-1-farosas@suse.de>
References: <20240228152127.18769-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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


