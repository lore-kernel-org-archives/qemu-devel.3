Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC8EC5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:28:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7x-0002Jd-CS; Sun, 03 Mar 2024 20:28:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7U-0001om-Kw
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7P-0002ON-QB
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S83wTD16OpizBGfq5LLkvGAx1j3LYbEznOklSWsN13U=;
 b=QysZPT5903Yst/CtrMYF2ZlOlQM4tBp6vG89+9gAG1NyCgFKWcDH4XgZtjmDrz2siy6zaN
 0uxzXnfe8vnYth52eS5TOPa4wcA95Cz3Xx81lzCyst1R7qN+od0D+fC6V1A5xN4a1ixxur
 jHEfEh/iCKRZPOsJ3WzAps8kQbwoycM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-QEp2vR6ZOLWjeGebh-sF0w-1; Sun,
 03 Mar 2024 20:27:48 -0500
X-MC-Unique: QEp2vR6ZOLWjeGebh-sF0w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2D2C1C05AB7;
 Mon,  4 Mar 2024 01:27:47 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 49C0840C6EBA;
 Mon,  4 Mar 2024 01:27:43 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 15/27] migration/multifd: Rename MultiFDSend|RecvParams::data
 to compress_data
Date: Mon,  4 Mar 2024 09:26:22 +0800
Message-ID: <20240304012634.95520-16-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Fabiano Rosas <farosas@suse.de>

Use a more specific name for the compression data so we can use the
generic for the multifd core code.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-13-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h      |  4 ++--
 migration/multifd-zlib.c | 20 ++++++++++----------
 migration/multifd-zstd.c | 20 ++++++++++----------
 3 files changed, 22 insertions(+), 22 deletions(-)

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
 
-- 
2.44.0


