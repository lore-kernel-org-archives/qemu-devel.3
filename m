Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECDF2C5475B
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 01:29:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rgx7t-0002IJ-L5; Sun, 03 Mar 2024 20:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7X-0001sC-VN
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:28:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rgx7U-0002Ot-3v
 for qemu-devel@nongnu.org; Sun, 03 Mar 2024 20:27:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709515675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VK1uP/nEMdPC5iQ/u3BYD3q+AeCBZCrpjNKly+B83s8=;
 b=eIWqhPj9mEurcAm7nKMQXJ4LsaTE55nkiSii4FXw7bmydbFnx1LYp0HxDsPuYpDW2J2O2E
 +YMLzgDxhfDPDmKmsYfqAClu+es7jJO06v+cpEQoIYdmHM9i4fzwagLHBepR77IuvnFAQM
 Zf3h/VrYSF+R0BdlbBbISWSLVkwAkI0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-YjG5-FCxOS6Zuw9_VzD8Mw-1; Sun, 03 Mar 2024 20:27:52 -0500
X-MC-Unique: YjG5-FCxOS6Zuw9_VzD8Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AA69E8820C3;
 Mon,  4 Mar 2024 01:27:51 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 845FE40C6EBA;
 Mon,  4 Mar 2024 01:27:48 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: peterx@redhat.com,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: [PULL 16/27] migration/multifd: Decouple recv method from pages
Date: Mon,  4 Mar 2024 09:26:23 +0800
Message-ID: <20240304012634.95520-17-peterx@redhat.com>
In-Reply-To: <20240304012634.95520-1-peterx@redhat.com>
References: <20240304012634.95520-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Next patches will abstract the type of data being received by the
channels, so do some cleanup now to remove references to pages and
dependency on 'normal_num'.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240229153017.2221-14-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h      |  4 ++--
 migration/multifd-zlib.c |  6 +++---
 migration/multifd-zstd.c |  6 +++---
 migration/multifd.c      | 13 ++++++++-----
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index adccd3532f..6a54377cc1 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -197,8 +197,8 @@ typedef struct {
     int (*recv_setup)(MultiFDRecvParams *p, Error **errp);
     /* Cleanup for receiving side */
     void (*recv_cleanup)(MultiFDRecvParams *p);
-    /* Read all pages */
-    int (*recv_pages)(MultiFDRecvParams *p, Error **errp);
+    /* Read all data */
+    int (*recv)(MultiFDRecvParams *p, Error **errp);
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
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
index c7389bf833..3a8520097b 100644
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
@@ -1227,6 +1227,8 @@ static void *multifd_recv_thread(void *opaque)
 
     while (true) {
         uint32_t flags;
+        bool has_data = false;
+        p->normal_num = 0;
 
         if (multifd_recv_should_exit()) {
             break;
@@ -1248,10 +1250,11 @@ static void *multifd_recv_thread(void *opaque)
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
-- 
2.44.0


