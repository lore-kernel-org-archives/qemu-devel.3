Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6121CC48292
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 10:30:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVqnj-00088A-Rr; Fri, 02 Feb 2024 05:29:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqnh-00087m-QB
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rVqng-0001Yh-BA
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 05:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706869775;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMVA61FG00o5F2sgpzvPDSC3j1syRcvDYKyMGntilGw=;
 b=BWGfF8Fzabyr0B0smj5qU/vPRwTejDDccrRkI5v9qEJrZWS+qye8Tur/NYUpbxA6xEE/sq
 GvijLsg0fJQ2dOTloJ4Kmoa1PMwuSGliS5UBvb0D2nKAS1TVI/kaq15/n0YVmeycIm3Ozf
 DPpNQ7H0Z65XEi2tN6J20I1y0Nhq7qo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-fbHjxloxPQKcoi_qmKVORg-1; Fri, 02 Feb 2024 05:29:33 -0500
X-MC-Unique: fbHjxloxPQKcoi_qmKVORg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D4E24868901;
 Fri,  2 Feb 2024 10:29:32 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.87])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28CAA400D783;
 Fri,  2 Feb 2024 10:29:28 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>,
 Bryan Zhang <bryan.zhang@bytedance.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Avihai Horon <avihaih@nvidia.com>,
 Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit <ppandit@redhat.com>
Subject: [PATCH v2 02/23] migration/multifd: multifd_send_kick_main()
Date: Fri,  2 Feb 2024 18:28:36 +0800
Message-ID: <20240202102857.110210-3-peterx@redhat.com>
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

When a multifd sender thread hit errors, it always needs to kick the main
thread by kicking all the semaphores that it can be waiting upon.

Provide a helper for it and deduplicate the code.

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index eee2586770..b8d2c96533 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -372,6 +372,18 @@ struct {
     MultiFDMethods *ops;
 } *multifd_send_state;
 
+/*
+ * The migration thread can wait on either of the two semaphores.  This
+ * function can be used to kick the main thread out of waiting on either of
+ * them.  Should mostly only be called when something wrong happened with
+ * the current multifd send thread.
+ */
+static void multifd_send_kick_main(MultiFDSendParams *p)
+{
+    qemu_sem_post(&p->sem_sync);
+    qemu_sem_post(&multifd_send_state->channels_ready);
+}
+
 /*
  * How we use multifd_send_state->pages and channel->pages?
  *
@@ -739,8 +751,7 @@ out:
         assert(local_err);
         trace_multifd_send_error(p->id);
         multifd_send_terminate_threads(local_err);
-        qemu_sem_post(&p->sem_sync);
-        qemu_sem_post(&multifd_send_state->channels_ready);
+        multifd_send_kick_main(p);
         error_free(local_err);
     }
 
@@ -781,8 +792,7 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
      * is not created, and then tell who pay attention to me.
      */
     p->quit = true;
-    qemu_sem_post(&multifd_send_state->channels_ready);
-    qemu_sem_post(&p->sem_sync);
+    multifd_send_kick_main(p);
     error_free(err);
 }
 
@@ -852,8 +862,7 @@ static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
 {
      migrate_set_error(migrate_get_current(), err);
      /* Error happen, we need to tell who pay attention to me */
-     qemu_sem_post(&multifd_send_state->channels_ready);
-     qemu_sem_post(&p->sem_sync);
+     multifd_send_kick_main(p);
      /*
       * Although multifd_send_thread is not created, but main migration
       * thread need to judge whether it is running, so we need to mark
-- 
2.43.0


