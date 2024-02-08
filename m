Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C94C4829B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulN-0000my-MR; Wed, 07 Feb 2024 22:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukt-0007Lg-Jg
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukr-0004Sp-Pc
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q4Vnj6oBPJEBsdh78JffL2RsD5I0M/JGFxJ+1Q6n0PI=;
 b=ZaawgheYBSJTPHxhEB+Ld5x3ckTD/cLmuj7MWpXGHwoC68UrN+a4Xo+51qwdaB3Nas264I
 VbGsm1MKXIK7uMZecm4M3Jn15S17NjPXvLgyTYOjWUION6OZBYm9y10FwgyzRVLLdadjLV
 rbdbI9YYPko7ATc3ucyucJ+9lqRhsm4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-yYCQOGfLOu2LshR2va399A-1; Wed, 07 Feb 2024 22:07:09 -0500
X-MC-Unique: yYCQOGfLOu2LshR2va399A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44A6C185A780;
 Thu,  8 Feb 2024 03:07:09 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 03033492BC7;
 Thu,  8 Feb 2024 03:07:06 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	Fabiano Rosas <farosas@suse.de>
Subject: [PULL 30/34] migration/multifd: Unify multifd and TLS connection paths
Date: Thu,  8 Feb 2024 11:05:24 +0800
Message-ID: <20240208030528.368214-31-peterx@redhat.com>
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

From: Fabiano Rosas <farosas@suse.de>

During multifd channel creation (multifd_send_new_channel_async) when
TLS is enabled, the multifd_channel_connect function is called twice,
once to create the TLS handshake thread and another time after the
asynchrounous TLS handshake has finished.

This creates a slightly confusing call stack where
multifd_channel_connect() is called more times than the number of
channels. It also splits error handling between the two callers of
multifd_channel_connect() causing some code duplication. Lastly, it
gets in the way of having a single point to determine whether all
channel creation tasks have been initiated.

Refactor the code to move the reentrancy one level up at the
multifd_new_send_channel_async() level, de-duplicating the error
handling and allowing for the next patch to introduce a
synchronization point common to all the multifd channel creation,
regardless of TLS.

Note that the previous code would never fail once p->c had been set.
This patch changes this assumption, which affects refcounting, so add
comments around object_unref to explain the situation.

Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240206215118.6171-6-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 83 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index cf865edba0..3db18dc79e 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -869,30 +869,7 @@ out:
     return NULL;
 }
 
-static bool multifd_channel_connect(MultiFDSendParams *p,
-                                    QIOChannel *ioc,
-                                    Error **errp);
-
-static void multifd_tls_outgoing_handshake(QIOTask *task,
-                                           gpointer opaque)
-{
-    MultiFDSendParams *p = opaque;
-    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
-    Error *err = NULL;
-
-    if (!qio_task_propagate_error(task, &err)) {
-        trace_multifd_tls_outgoing_handshake_complete(ioc);
-        if (multifd_channel_connect(p, ioc, &err)) {
-            return;
-        }
-    }
-
-    trace_multifd_tls_outgoing_handshake_error(ioc, error_get_pretty(err));
-
-    multifd_send_set_error(err);
-    multifd_send_kick_main(p);
-    error_free(err);
-}
+static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque);
 
 static void *multifd_tls_handshake_thread(void *opaque)
 {
@@ -900,7 +877,7 @@ static void *multifd_tls_handshake_thread(void *opaque)
     QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
 
     qio_channel_tls_handshake(tioc,
-                              multifd_tls_outgoing_handshake,
+                              multifd_new_send_channel_async,
                               p,
                               NULL,
                               NULL);
@@ -920,6 +897,10 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
         return false;
     }
 
+    /*
+     * Ownership of the socket channel now transfers to the newly
+     * created TLS channel, which has already taken a reference.
+     */
     object_unref(OBJECT(ioc));
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
@@ -936,18 +917,7 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
                                     QIOChannel *ioc,
                                     Error **errp)
 {
-    trace_multifd_set_outgoing_channel(
-        ioc, object_get_typename(OBJECT(ioc)),
-        migrate_get_current()->hostname);
-
-    if (migrate_channel_requires_tls_upgrade(ioc)) {
-        /*
-         * tls_channel_connect will call back to this
-         * function after the TLS handshake,
-         * so we mustn't call multifd_send_thread until then
-         */
-        return multifd_tls_channel_connect(p, ioc, errp);
-    }
+    qio_channel_set_delay(ioc, false);
 
     migration_ioc_register_yank(ioc);
     p->registered_yank = true;
@@ -959,24 +929,51 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     return true;
 }
 
+/*
+ * When TLS is enabled this function is called once to establish the
+ * TLS connection and a second time after the TLS handshake to create
+ * the multifd channel. Without TLS it goes straight into the channel
+ * creation.
+ */
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
 {
     MultiFDSendParams *p = opaque;
     QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
     Error *local_err = NULL;
+    bool ret;
 
     trace_multifd_new_send_channel_async(p->id);
-    if (!qio_task_propagate_error(task, &local_err)) {
-        qio_channel_set_delay(ioc, false);
-        if (multifd_channel_connect(p, ioc, &local_err)) {
-            return;
-        }
+
+    if (qio_task_propagate_error(task, &local_err)) {
+        ret = false;
+        goto out;
+    }
+
+    trace_multifd_set_outgoing_channel(ioc, object_get_typename(OBJECT(ioc)),
+                                       migrate_get_current()->hostname);
+
+    if (migrate_channel_requires_tls_upgrade(ioc)) {
+        ret = multifd_tls_channel_connect(p, ioc, &local_err);
+    } else {
+        ret = multifd_channel_connect(p, ioc, &local_err);
     }
 
+    if (ret) {
+        return;
+    }
+
+out:
     trace_multifd_new_send_channel_async_error(p->id, local_err);
     multifd_send_set_error(local_err);
     multifd_send_kick_main(p);
-    object_unref(OBJECT(ioc));
+    if (!p->c) {
+        /*
+         * If no channel has been created, drop the initial
+         * reference. Otherwise cleanup happens at
+         * multifd_send_channel_destroy()
+         */
+        object_unref(OBJECT(ioc));
+    }
     error_free(local_err);
 }
 
-- 
2.43.0


