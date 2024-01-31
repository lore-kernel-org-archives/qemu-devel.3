Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47591C47258
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 10:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV7sU-00055V-R8; Wed, 31 Jan 2024 05:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV7sS-000542-La
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:31:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV7sQ-0005aP-W6
 for qemu-devel@nongnu.org; Wed, 31 Jan 2024 05:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706697090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SMVA61FG00o5F2sgpzvPDSC3j1syRcvDYKyMGntilGw=;
 b=dRWjTHXnEcrLbQCOhUKLF+PYn3LEhS5/tfXHnmGvB4WJyhbX4Of5ds0PtuI0y3/yudD8Fa
 JZsOsleq8yVlk35lMx43Hm3EB+p4nvXFu14H6nu3IioKkvB1O4SH7gvNAnW7fYJXFR6Mi5
 BKTCWRyk9GxIyeUt9EJlIcknGRZMX6A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-Ut7W_kosN9S4j-kDh3G0eQ-1; Wed,
 31 Jan 2024 05:31:28 -0500
X-MC-Unique: Ut7W_kosN9S4j-kDh3G0eQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3B431C05154;
 Wed, 31 Jan 2024 10:31:27 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.11])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 018801BDB1;
 Wed, 31 Jan 2024 10:31:23 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Bryan Zhang <bryan.zhang@bytedance.com>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 peterx@redhat.com, Yuan Liu <yuan1.liu@intel.com>,
 Avihai Horon <avihaih@nvidia.com>, Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 02/14] migration/multifd: multifd_send_kick_main()
Date: Wed, 31 Jan 2024 18:30:59 +0800
Message-ID: <20240131103111.306523-3-peterx@redhat.com>
In-Reply-To: <20240131103111.306523-1-peterx@redhat.com>
References: <20240131103111.306523-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


