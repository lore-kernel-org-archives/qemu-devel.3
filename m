Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E77AC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqp4-0001Oc-6j; Fri, 02 Feb 2024 05:31:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqot-0000yo-Ad
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqor-00020G-PW
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:30:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o85LQo0ULDTqdfBYOJEh8DjyVCHlsVN4yMo2YOyBmOU=;
 b=ZidFxorZKsnxCFkGBNIHwyLFipMY0QldLyhouPB13hvALG3q5BDPLgtpWwRlR9ATvrDMav
 ZQLDJTdQgLtGJklf6lxRW7EKsU7kqcq5YvGTOCWL4Hl/LWz8uVqyS6Q4ExxOhcUEUiSl4B
 N9Hmsc5RAArPXuZu+kE4l3OkFXUhq38=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-Rb7XUWABNG6HB7ssHuXsmw-1; Fri,
 02 Feb 2024 05:30:44 -0500
X-MC-Unique: Rb7XUWABNG6HB7ssHuXsmw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6DD7D1C04B7B;
 Fri,  2 Feb 2024 10:30:44 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52D6240CD14B;
 Fri,  2 Feb 2024 10:30:39 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 17/23] migration/multifd: Change retval of
 multifd_send_pages()
Date: Fri,  2 Feb 2024 18:28:51 +0800
Message-ID: <20240202102857.110210-18-peterx@redhat.com>
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

Using int is an overkill when there're only two options.  Change it to a
boolean.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 12e587fda8..35d4e8ad1f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -449,9 +449,10 @@ static void multifd_send_kick_main(MultiFDSendParams *p)
  * thread is using the channel mutex when changing it, and the channel
  * have to had finish with its own, otherwise pending_job can't be
  * false.
+ *
+ * Returns true if succeed, false otherwise.
  */
-
-static int multifd_send_pages(void)
+static bool multifd_send_pages(void)
 {
     int i;
     static int next_channel;
@@ -459,7 +460,7 @@ static int multifd_send_pages(void)
     MultiFDPages_t *pages = multifd_send_state->pages;
 
     if (multifd_send_should_exit()) {
-        return -1;
+        return false;
     }
 
     /* We wait here, until at least one channel is ready */
@@ -473,7 +474,7 @@ static int multifd_send_pages(void)
     next_channel %= migrate_multifd_channels();
     for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
         if (multifd_send_should_exit()) {
-            return -1;
+            return false;
         }
         p = &multifd_send_state->params[i];
         /*
@@ -502,7 +503,7 @@ static int multifd_send_pages(void)
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
-    return 1;
+    return true;
 }
 
 /* Returns true if enqueue successful, false otherwise */
@@ -526,7 +527,7 @@ bool multifd_queue_page(RAMBlock *block, ram_addr_t offset)
         changed = true;
     }
 
-    if (multifd_send_pages() < 0) {
+    if (!multifd_send_pages()) {
         return false;
     }
 
@@ -666,7 +667,7 @@ int multifd_send_sync_main(void)
         return 0;
     }
     if (multifd_send_state->pages->num) {
-        if (multifd_send_pages() < 0) {
+        if (!multifd_send_pages()) {
             error_report("%s: multifd_send_pages fail", __func__);
             return -1;
         }
-- 
2.43.0


