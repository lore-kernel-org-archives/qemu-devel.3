Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 329C4C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 17:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg69f-00061j-49; Thu, 06 Feb 2025 12:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69d-000602-6o
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:09 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tg69a-0001Iz-QE
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 12:59:08 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6DC5421163;
 Thu,  6 Feb 2025 17:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uj3+4vT+r3gcmrfCQf2FV7hyuyLTCKP99o+crV6xgqs=;
 b=QSYXfyhu/DJg1adcJjN3jrniOcYKL8YpFP9eK6Cg+OpNuejXcICbDSqUtjd/unwqHplOwC
 SYQCwLbFKONgUdk7SE5mP2ACi80ftOyPiuP425YlLBV03TFx1gwMqL6qFx1J51Jt9445Kf
 cqKXHxeXIklBooKuJ/cMbltgT4/TFMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uj3+4vT+r3gcmrfCQf2FV7hyuyLTCKP99o+crV6xgqs=;
 b=affm9DIrNj+ifooo5FUwTbGPSVgQp18vnx9IlgdFAS9fEIYD2NopZOWT+m33eWLGG48Z5i
 h1obLw7yUcKLrFBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QSYXfyhu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=affm9DIr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738864745; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uj3+4vT+r3gcmrfCQf2FV7hyuyLTCKP99o+crV6xgqs=;
 b=QSYXfyhu/DJg1adcJjN3jrniOcYKL8YpFP9eK6Cg+OpNuejXcICbDSqUtjd/unwqHplOwC
 SYQCwLbFKONgUdk7SE5mP2ACi80ftOyPiuP425YlLBV03TFx1gwMqL6qFx1J51Jt9445Kf
 cqKXHxeXIklBooKuJ/cMbltgT4/TFMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738864745;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Uj3+4vT+r3gcmrfCQf2FV7hyuyLTCKP99o+crV6xgqs=;
 b=affm9DIrNj+ifooo5FUwTbGPSVgQp18vnx9IlgdFAS9fEIYD2NopZOWT+m33eWLGG48Z5i
 h1obLw7yUcKLrFBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC4AE13697;
 Thu,  6 Feb 2025 17:59:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KM/WHWf4pGeVZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 06 Feb 2025 17:59:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH 2/4] io: tls: Add qio_channel_tls_bye
Date: Thu,  6 Feb 2025 14:58:22 -0300
Message-Id: <20250206175824.22664-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250206175824.22664-1-farosas@suse.de>
References: <20250206175824.22664-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6DC5421163
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a task dispatcher for gnutls_bye similar to the
qio_channel_tls_handshake_task(). The gnutls_bye() call might be
interrupted and so it needs to be rescheduled.

The migration code will make use of this to help the migration
destination identify a premature EOF. Once the session termination is
in place, any EOF that happens before the source issued gnutls_bye()
will be considered an error.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/io/channel-tls.h | 12 ++++++
 io/channel-tls.c         | 84 ++++++++++++++++++++++++++++++++++++++++
 io/trace-events          |  5 +++
 3 files changed, 101 insertions(+)

diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 26c67f17e2..7e9023570d 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -49,8 +49,20 @@ struct QIOChannelTLS {
     QCryptoTLSSession *session;
     QIOChannelShutdown shutdown;
     guint hs_ioc_tag;
+    guint bye_ioc_tag;
 };
 
+/**
+ * qio_channel_tls_bye:
+ * @ioc: the TLS channel object
+ * @errp: pointer to a NULL-initialized error object
+ *
+ * Perform the TLS session termination. This method will return
+ * immediately and the termination will continue in the background,
+ * provided the main loop is running.
+ */
+void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
+
 /**
  * qio_channel_tls_new_server:
  * @master: the underlying channel object
diff --git a/io/channel-tls.c b/io/channel-tls.c
index aab630e5ae..517ce190a4 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -247,6 +247,85 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
     qio_channel_tls_handshake_task(ioc, task, context);
 }
 
+static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
+                                       gpointer user_data);
+
+static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
+                                     GMainContext *context)
+{
+    GIOCondition condition;
+    QIOChannelTLSData *data;
+    int status;
+    Error *err = NULL;
+
+    status = qcrypto_tls_session_bye(ioc->session, &err);
+
+    if (status < 0) {
+        trace_qio_channel_tls_bye_fail(ioc);
+        qio_task_set_error(task, err);
+        qio_task_complete(task);
+        return;
+    }
+
+    if (status == QCRYPTO_TLS_BYE_COMPLETE) {
+        qio_task_complete(task);
+        return;
+    }
+
+    data = g_new0(typeof(*data), 1);
+    data->task = task;
+    data->context = context;
+
+    if (context) {
+        g_main_context_ref(context);
+    }
+
+    if (status == QCRYPTO_TLS_BYE_SENDING) {
+        condition = G_IO_OUT;
+    } else {
+        condition = G_IO_IN;
+    }
+
+    trace_qio_channel_tls_bye_pending(ioc, status);
+    ioc->bye_ioc_tag = qio_channel_add_watch_full(ioc->master, condition,
+                                                  qio_channel_tls_bye_io,
+                                                  data, NULL, context);
+}
+
+
+static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
+                                       gpointer user_data)
+{
+    QIOChannelTLSData *data = user_data;
+    QIOTask *task = data->task;
+    GMainContext *context = data->context;
+    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(qio_task_get_source(task));
+
+    tioc->bye_ioc_tag = 0;
+    g_free(data);
+    qio_channel_tls_bye_task(tioc, task, context);
+
+    if (context) {
+        g_main_context_unref(context);
+    }
+
+    return FALSE;
+}
+
+static void propagate_error(QIOTask *task, gpointer opaque)
+{
+    qio_task_propagate_error(task, opaque);
+}
+
+void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
+{
+    QIOTask *task;
+
+    task = qio_task_new(OBJECT(ioc), propagate_error, errp, NULL);
+
+    trace_qio_channel_tls_bye_start(ioc);
+    qio_channel_tls_bye_task(ioc, task, NULL);
+}
 
 static void qio_channel_tls_init(Object *obj G_GNUC_UNUSED)
 {
@@ -379,6 +458,11 @@ static int qio_channel_tls_close(QIOChannel *ioc,
         g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
     }
 
+    if (tioc->bye_ioc_tag) {
+        trace_qio_channel_tls_bye_cancel(ioc);
+        g_clear_handle_id(&tioc->bye_ioc_tag, g_source_remove);
+    }
+
     return qio_channel_close(tioc->master, errp);
 }
 
diff --git a/io/trace-events b/io/trace-events
index d4c0f84a9a..dc3a63ba1f 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -44,6 +44,11 @@ qio_channel_tls_handshake_pending(void *ioc, int status) "TLS handshake pending
 qio_channel_tls_handshake_fail(void *ioc) "TLS handshake fail ioc=%p"
 qio_channel_tls_handshake_complete(void *ioc) "TLS handshake complete ioc=%p"
 qio_channel_tls_handshake_cancel(void *ioc) "TLS handshake cancel ioc=%p"
+qio_channel_tls_bye_start(void *ioc) "TLS termination start ioc=%p"
+qio_channel_tls_bye_pending(void *ioc, int status) "TLS termination pending ioc=%p status=%d"
+qio_channel_tls_bye_fail(void *ioc) "TLS termination fail ioc=%p"
+qio_channel_tls_bye_complete(void *ioc) "TLS termination complete ioc=%p"
+qio_channel_tls_bye_cancel(void *ioc) "TLS termination cancel ioc=%p"
 qio_channel_tls_credentials_allow(void *ioc) "TLS credentials allow ioc=%p"
 qio_channel_tls_credentials_deny(void *ioc) "TLS credentials deny ioc=%p"
 
-- 
2.35.3


