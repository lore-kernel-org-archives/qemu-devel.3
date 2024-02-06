Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F11FC48297
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 21:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTMh-0000gF-Ih; Tue, 06 Feb 2024 16:52:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLs-0008E2-MB
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:39 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rXTLq-00089y-2Y
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 16:51:36 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C46211FB98;
 Tue,  6 Feb 2024 21:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWjOuEBMSM14dm/0EWXiK1u85r7duv2JIVEUTZ33GH8=;
 b=Ozk2fr+MdpDTk+bjt/kjESyHIIoWfw6XWbNMtVr3y3ToG66RpfyYCuqLnwAvyc5qq6n/1I
 p1cDIQII63+F9qHaBiYaCpQNND4+HehjAjk1Pzb5giAGrC8UYUSrEUOsz0PjMoONzOlDkN
 pRIvC8Zj5fWQW1CzsObfhZhv9L8btRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWjOuEBMSM14dm/0EWXiK1u85r7duv2JIVEUTZ33GH8=;
 b=0wg6cqP4AQVvk5Ca8wf911m20izymSvA3ZMPSXO//4VGPQ8ErKSzbn169qDj5M23de3WP+
 P9nIjkWx9NIO0/Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1707256292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWjOuEBMSM14dm/0EWXiK1u85r7duv2JIVEUTZ33GH8=;
 b=Ozk2fr+MdpDTk+bjt/kjESyHIIoWfw6XWbNMtVr3y3ToG66RpfyYCuqLnwAvyc5qq6n/1I
 p1cDIQII63+F9qHaBiYaCpQNND4+HehjAjk1Pzb5giAGrC8UYUSrEUOsz0PjMoONzOlDkN
 pRIvC8Zj5fWQW1CzsObfhZhv9L8btRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1707256292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SWjOuEBMSM14dm/0EWXiK1u85r7duv2JIVEUTZ33GH8=;
 b=0wg6cqP4AQVvk5Ca8wf911m20izymSvA3ZMPSXO//4VGPQ8ErKSzbn169qDj5M23de3WP+
 P9nIjkWx9NIO0/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 65EA2132DD;
 Tue,  6 Feb 2024 21:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EGkwC+OpwmWzQAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 06 Feb 2024 21:51:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 5/6] migration/multifd: Unify multifd and TLS connection
 paths
Date: Tue,  6 Feb 2024 18:51:17 -0300
Message-Id: <20240206215118.6171-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240206215118.6171-1-farosas@suse.de>
References: <20240206215118.6171-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [1.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; R_MISSING_CHARSET(2.50)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
---
 migration/multifd.c | 83 ++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index cc10be2c3f..339f2428f3 100644
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
+    }
+
+    if (ret) {
+        return;
     }
 
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
2.35.3


