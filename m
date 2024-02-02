Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46402C48292
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqob-0000G8-78; Fri, 02 Feb 2024 05:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoX-00008K-VZ
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqoV-0001wS-Dt
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AzPCPfqn31xVp/9rnVzMd6IeZdsqsES5fCSVKyWK5rc=;
 b=A8paeTIn/aUdFGnVC4PO8A1sQj7wspKwSblVTNxnW/E8axvy0tyhyEcJiJpKeDKpE9GM4/
 ixFa7l7ILmw9mGAdzRSWdZYdWXRfCU0i/nxMQGnklSmK3IDSJBoFrTYK6OYmWFYlxt+yhI
 AkMx6bJs2b0qoskVjcnLa7KogqKFtQc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-38-zkwcFuleNlmKJrlAGcoYlg-1; Fri, 02 Feb 2024 05:30:25 -0500
X-MC-Unique: zkwcFuleNlmKJrlAGcoYlg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C12BA106D100;
 Fri,  2 Feb 2024 10:30:24 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF88340C9444;
 Fri,  2 Feb 2024 10:30:20 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 13/23] migration/multifd: Move header prepare/fill into
 send_prepare()
Date: Fri,  2 Feb 2024 18:28:47 +0800
Message-ID: <20240202102857.110210-14-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Peter Xu <peterx@redhat.com>

This patch redefines the interfacing of ->send_prepare().  It further
simplifies multifd_send_thread() especially on zero copy.

Now with the new interface, we require the hook to do all the work for
preparing the IOVs to send.  After it's completed, the IOVs should be ready
to be dumped into the specific multifd QIOChannel later.

So now the API looks like:

  p->pages ----------->  send_prepare() -------------> IOVs

This also prepares for the case where the input can be extended to even not
any p->pages.  But that's for later.

This patch will achieve similar goal of what Fabiano used to propose here:

https://lore.kernel.org/r/20240126221943.26628-1-farosas@suse.de

However the send() interface may not be necessary.  I'm boldly attaching a
"Co-developed-by" for Fabiano.

Co-developed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h      |  1 +
 migration/multifd-zlib.c |  4 +++
 migration/multifd-zstd.c |  4 +++
 migration/multifd.c      | 61 ++++++++++++++++++----------------------
 4 files changed, 37 insertions(+), 33 deletions(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 4ec005f53f..34a2ecb9f4 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -208,6 +208,7 @@ typedef struct {
 } MultiFDMethods;
 
 void multifd_register_ops(int method, MultiFDMethods *ops);
+void multifd_send_fill_packet(MultiFDSendParams *p);
 
 static inline void multifd_send_prepare_header(MultiFDSendParams *p)
 {
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 100809abc1..012e3bdea1 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -123,6 +123,8 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
+    multifd_send_prepare_header(p);
+
     for (i = 0; i < pages->num; i++) {
         uint32_t available = z->zbuff_len - out_size;
         int flush = Z_NO_FLUSH;
@@ -172,6 +174,8 @@ static int zlib_send_prepare(MultiFDSendParams *p, Error **errp)
     p->next_packet_size = out_size;
     p->flags |= MULTIFD_FLAG_ZLIB;
 
+    multifd_send_fill_packet(p);
+
     return 0;
 }
 
diff --git a/migration/multifd-zstd.c b/migration/multifd-zstd.c
index 2023edd8cc..dc8fe43e94 100644
--- a/migration/multifd-zstd.c
+++ b/migration/multifd-zstd.c
@@ -118,6 +118,8 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     int ret;
     uint32_t i;
 
+    multifd_send_prepare_header(p);
+
     z->out.dst = z->zbuff;
     z->out.size = z->zbuff_len;
     z->out.pos = 0;
@@ -161,6 +163,8 @@ static int zstd_send_prepare(MultiFDSendParams *p, Error **errp)
     p->next_packet_size = z->out.pos;
     p->flags |= MULTIFD_FLAG_ZSTD;
 
+    multifd_send_fill_packet(p);
+
     return 0;
 }
 
diff --git a/migration/multifd.c b/migration/multifd.c
index cd4467aff4..6aa44340de 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -50,15 +50,15 @@ typedef struct {
 /**
  * nocomp_send_setup: setup send side
  *
- * For no compression this function does nothing.
- *
- * Returns 0 for success or -1 for error
- *
  * @p: Params for the channel that we are using
  * @errp: pointer to an error
  */
 static int nocomp_send_setup(MultiFDSendParams *p, Error **errp)
 {
+    if (migrate_zero_copy_send()) {
+        p->write_flags |= QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
+    }
+
     return 0;
 }
 
@@ -88,7 +88,17 @@ static void nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
  */
 static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 {
+    bool use_zero_copy_send = migrate_zero_copy_send();
     MultiFDPages_t *pages = p->pages;
+    int ret;
+
+    if (!use_zero_copy_send) {
+        /*
+         * Only !zerocopy needs the header in IOV; zerocopy will
+         * send it separately.
+         */
+        multifd_send_prepare_header(p);
+    }
 
     for (int i = 0; i < pages->num; i++) {
         p->iov[p->iovs_num].iov_base = pages->block->host + pages->offset[i];
@@ -98,6 +108,18 @@ static int nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
 
     p->next_packet_size = pages->num * p->page_size;
     p->flags |= MULTIFD_FLAG_NOCOMP;
+
+    multifd_send_fill_packet(p);
+
+    if (use_zero_copy_send) {
+        /* Send header first, without zerocopy */
+        ret = qio_channel_write_all(p->c, (void *)p->packet,
+                                    p->packet_len, errp);
+        if (ret != 0) {
+            return -1;
+        }
+    }
+
     return 0;
 }
 
@@ -266,7 +288,7 @@ static void multifd_pages_clear(MultiFDPages_t *pages)
     g_free(pages);
 }
 
-static void multifd_send_fill_packet(MultiFDSendParams *p)
+void multifd_send_fill_packet(MultiFDSendParams *p)
 {
     MultiFDPacket_t *packet = p->packet;
     MultiFDPages_t *pages = p->pages;
@@ -688,7 +710,6 @@ static void *multifd_send_thread(void *opaque)
     MigrationThread *thread = NULL;
     Error *local_err = NULL;
     int ret = 0;
-    bool use_zero_copy_send = migrate_zero_copy_send();
 
     thread = migration_threads_add(p->name, qemu_get_thread_id());
 
@@ -713,15 +734,6 @@ static void *multifd_send_thread(void *opaque)
             MultiFDPages_t *pages = p->pages;
 
             p->iovs_num = 0;
-
-            if (!use_zero_copy_send) {
-                /*
-                 * Only !zerocopy needs the header in IOV; zerocopy will
-                 * send it separately.
-                 */
-                multifd_send_prepare_header(p);
-            }
-
             assert(pages->num);
 
             ret = multifd_send_state->ops->send_prepare(p, &local_err);
@@ -730,17 +742,6 @@ static void *multifd_send_thread(void *opaque)
                 break;
             }
 
-            multifd_send_fill_packet(p);
-
-            if (use_zero_copy_send) {
-                /* Send header first, without zerocopy */
-                ret = qio_channel_write_all(p->c, (void *)p->packet,
-                                            p->packet_len, &local_err);
-                if (ret != 0) {
-                    break;
-                }
-            }
-
             ret = qio_channel_writev_full_all(p->c, p->iov, p->iovs_num, NULL,
                                               0, p->write_flags, &local_err);
             if (ret != 0) {
@@ -945,13 +946,7 @@ int multifd_save_setup(Error **errp)
         p->iov = g_new0(struct iovec, page_count + 1);
         p->page_size = qemu_target_page_size();
         p->page_count = page_count;
-
-        if (migrate_zero_copy_send()) {
-            p->write_flags = QIO_CHANNEL_WRITE_FLAG_ZERO_COPY;
-        } else {
-            p->write_flags = 0;
-        }
-
+        p->write_flags = 0;
         multifd_new_send_channel_create(p);
     }
 
-- 
2.43.0


