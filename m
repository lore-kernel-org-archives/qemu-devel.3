Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26CBC4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:07:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulJ-0000H6-QO; Wed, 07 Feb 2024 22:07:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukR-0006is-Vj
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukO-0004Oj-RH
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:06:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p+rWOiKRGfKYYD4s1CHnnYWpK5RIZrtTAQJmSTL7WeM=;
 b=WxpRdtBB86r/j0PjHAleuK5HjGT/H4BER6VybbVKco3mjx7ujZaJMdoV4rzjsotzrray5s
 MSTISSRXRisqtboSWpGfOn8hc9onMYKsPiusjv+XTfh99zrj3k8rFTEaNrZG3fg9/BrTOp
 sCYfdpcgHxHazBZvYO50F8cBl4BXkcM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-386-ozsVZ_xCO7WTkUf-mRaTRA-1; Wed,
 07 Feb 2024 22:06:38 -0500
X-MC-Unique: ozsVZ_xCO7WTkUf-mRaTRA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6FC2D1C051A6;
 Thu,  8 Feb 2024 03:06:38 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 15A66492BC7;
 Thu,  8 Feb 2024 03:06:35 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 21/34] migration/multifd: Cleanup multifd_load_cleanup()
Date: Thu,  8 Feb 2024 11:05:15 +0800
Message-ID: <20240208030528.368214-22-peterx@redhat.com>
In-Reply-To: <20240208030528.368214-1-peterx@redhat.com>
References: <20240208030528.368214-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
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

Use similar logic to cleanup the recv side.

Note that multifd_recv_terminate_threads() may need some similar rework
like the sender side, but let's leave that for later.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240202102857.110210-21-peterx@redhat.com
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


