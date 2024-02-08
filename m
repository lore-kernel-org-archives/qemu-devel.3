Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B0DC4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:07:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXujf-00068U-32; Wed, 07 Feb 2024 22:05:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujZ-00061F-0Q
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXujX-0004Ku-Bj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:05:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rxZHrPajLtIGHeZjEajUe4yfONFZ2JGFrfzt8+Ew5WI=;
 b=Cb6QaCfe2/9Jo+ypL882OZE9m1Uo/Pk2XQ76wuwwNbL2wcxRW5ooeVSLqAWIGqx6513IF4
 mluw66VAUTcoCYW/l9d7oIxHmDPdyZzwHq6r9eFdrNOjHfgbi1PRIGatbCoPkznCfQLRS8
 IdJ3YUd7xShah1S99oCRXhTzJYlGu08=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-3nwhbgwXN3uDdaVD9ZUOEg-1; Wed, 07 Feb 2024 22:05:48 -0500
X-MC-Unique: 3nwhbgwXN3uDdaVD9ZUOEg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90273185A780;
 Thu,  8 Feb 2024 03:05:48 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1C56F492BC7;
 Thu,  8 Feb 2024 03:05:45 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 05/34] migration/multifd: Postpone reset of MultiFDPages_t
Date: Thu,  8 Feb 2024 11:04:59 +0800
Message-ID: <20240208030528.368214-6-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

From: Peter Xu <peterx@redhat.com>

Now we reset MultiFDPages_t object in the multifd sender thread in the
middle of the sending job.  That's not necessary, because the "*pages"
struct will not be reused anyway until pending_job is cleared.

Move that to the end after the job is completed, provide a helper to reset
a "*pages" object.  Use that same helper when free the object too.

This prepares us to keep using p->pages in the follow up patches, where we
may drop p->normal[].

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-5-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 2c98023d67..5633ac245a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -172,6 +172,17 @@ void multifd_register_ops(int method, MultiFDMethods *ops)
     multifd_ops[method] = ops;
 }
 
+/* Reset a MultiFDPages_t* object for the next use */
+static void multifd_pages_reset(MultiFDPages_t *pages)
+{
+    /*
+     * We don't need to touch offset[] array, because it will be
+     * overwritten later when reused.
+     */
+    pages->num = 0;
+    pages->block = NULL;
+}
+
 static int multifd_send_initial_packet(MultiFDSendParams *p, Error **errp)
 {
     MultiFDInit_t msg = {};
@@ -248,9 +259,8 @@ static MultiFDPages_t *multifd_pages_init(uint32_t n)
 
 static void multifd_pages_clear(MultiFDPages_t *pages)
 {
-    pages->num = 0;
+    multifd_pages_reset(pages);
     pages->allocated = 0;
-    pages->block = NULL;
     g_free(pages->offset);
     pages->offset = NULL;
     g_free(pages);
@@ -704,8 +714,6 @@ static void *multifd_send_thread(void *opaque)
             p->flags = 0;
             p->num_packets++;
             p->total_normal_pages += p->normal_num;
-            p->pages->num = 0;
-            p->pages->block = NULL;
             qemu_mutex_unlock(&p->mutex);
 
             trace_multifd_send(p->id, packet_num, p->normal_num, flags,
@@ -732,6 +740,8 @@ static void *multifd_send_thread(void *opaque)
 
             stat64_add(&mig_stats.multifd_bytes,
                        p->next_packet_size + p->packet_len);
+
+            multifd_pages_reset(p->pages);
             p->next_packet_size = 0;
             qemu_mutex_lock(&p->mutex);
             p->pending_job--;
-- 
2.43.0


