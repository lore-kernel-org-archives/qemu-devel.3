Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB6CC48291
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:31:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqp9-000290-C8; Fri, 02 Feb 2024 05:31:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqp7-000225-VC
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:31:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqp5-00021n-SN
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/PVv7xIjUW8mdAijekNJw3s/h7WnKlv6rg47X2gdcY=;
 b=FYQXFJ+A/GZHmQ5Z65lj6IjepQYeV0EuAKFYETsphg9COWkS2aJ24c2TsTpjxSVueUf6WY
 TydCIsBIzh9FRETpni3dtFSOXOwYBc69BBwbLkCN2Nl6UfPCyovwO3igzEQCk9/o67kLyE
 axJszQhLIWNZOOoIh9HlvA0+L+AuPgI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-295-67lN0alUO9mMoM2mVyE7CQ-1; Fri,
 02 Feb 2024 05:30:59 -0500
X-MC-Unique: 67lN0alUO9mMoM2mVyE7CQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 167271C05AAD;
 Fri,  2 Feb 2024 10:30:59 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF5CA40C95AD;
 Fri,  2 Feb 2024 10:30:54 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 20/23] migration/multifd: Cleanup multifd_load_cleanup()
Date: Fri,  2 Feb 2024 18:28:54 +0800
Message-ID: <20240202102857.110210-21-peterx@redhat.com>
In-Reply-To: <20240202102857.110210-1-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

Use similar logic to cleanup the recv side.

Note that multifd_recv_terminate_threads() may need some similar rework
like the sender side, but let's leave that for later.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 52 ++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4cb0d2cc17..e2dd2f6e04 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -1070,6 +1070,34 @@ void multifd_load_shutdown(void)
     }
 }
 
+static void multifd_recv_cleanup_channel(MultiFDRecvParams *p)
+{
+    migration_ioc_unregister_yank(p->c);
+    object_unref(OBJECT(p->c));
+    p->c = NULL;
+    qemu_mutex_destroy(&p->mutex);
+    qemu_sem_destroy(&p->sem_sync);
+    g_free(p->name);
+    p->name = NULL;
+    p->packet_len = 0;
+    g_free(p->packet);
+    p->packet = NULL;
+    g_free(p->iov);
+    p->iov = NULL;
+    g_free(p->normal);
+    p->normal = NULL;
+    multifd_recv_state->ops->recv_cleanup(p);
+}
+
+static void multifd_recv_cleanup_state(void)
+{
+    qemu_sem_destroy(&multifd_recv_state->sem_sync);
+    g_free(multifd_recv_state->params);
+    multifd_recv_state->params = NULL;
+    g_free(multifd_recv_state);
+    multifd_recv_state = NULL;
+}
+
 void multifd_load_cleanup(void)
 {
     int i;
@@ -1092,29 +1120,9 @@ void multifd_load_cleanup(void)
         qemu_thread_join(&p->thread);
     }
     for (i = 0; i < migrate_multifd_channels(); i++) {
-        MultiFDRecvParams *p = &multifd_recv_state->params[i];
-
-        migration_ioc_unregister_yank(p->c);
-        object_unref(OBJECT(p->c));
-        p->c = NULL;
-        qemu_mutex_destroy(&p->mutex);
-        qemu_sem_destroy(&p->sem_sync);
-        g_free(p->name);
-        p->name = NULL;
-        p->packet_len = 0;
-        g_free(p->packet);
-        p->packet = NULL;
-        g_free(p->iov);
-        p->iov = NULL;
-        g_free(p->normal);
-        p->normal = NULL;
-        multifd_recv_state->ops->recv_cleanup(p);
+        multifd_recv_cleanup_channel(&multifd_recv_state->params[i]);
     }
-    qemu_sem_destroy(&multifd_recv_state->sem_sync);
-    g_free(multifd_recv_state->params);
-    multifd_recv_state->params = NULL;
-    g_free(multifd_recv_state);
-    multifd_recv_state = NULL;
+    multifd_recv_cleanup_state();
 }
 
 void multifd_recv_sync_main(void)
-- 
2.43.0


