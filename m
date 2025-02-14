Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CE1C02198
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Feb 2025 01:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tj74b-00043f-RL; Fri, 14 Feb 2025 20:34:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2MB-0006Si-Vj
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:32:21 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tj2MA-0002AT-05
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 15:32:15 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4EB41F385;
 Fri, 14 Feb 2025 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJaxIoaIwwVEqMpumZlQRNSiUpoW128yjQ9npoemM5w=;
 b=hVJXZ2yI3vuZyO/kyrLSfJyTD9KL/WjgOSNgxKyY5lqSn4NOES5gJ0GinHp9aBY9lcll/F
 M+VFpcCWhjCBJwlfHjdU2tBMxUYqbjwH2aTJDOoGZmvDGBPKcUnJvF7CS2pZ+eveSnNO90
 l0KuI0yEfGsIG2aQlglcAHIDituyXoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJaxIoaIwwVEqMpumZlQRNSiUpoW128yjQ9npoemM5w=;
 b=ot7WBMmXY5HM/C2J2pVqly2HkYYuxs+PF/hGzVIBnLjH9YlbnqKUgvuAGX8dIfIlMwkYqm
 1OlxBVJmhXh6lpAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1739565127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJaxIoaIwwVEqMpumZlQRNSiUpoW128yjQ9npoemM5w=;
 b=hVJXZ2yI3vuZyO/kyrLSfJyTD9KL/WjgOSNgxKyY5lqSn4NOES5gJ0GinHp9aBY9lcll/F
 M+VFpcCWhjCBJwlfHjdU2tBMxUYqbjwH2aTJDOoGZmvDGBPKcUnJvF7CS2pZ+eveSnNO90
 l0KuI0yEfGsIG2aQlglcAHIDituyXoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1739565127;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IJaxIoaIwwVEqMpumZlQRNSiUpoW128yjQ9npoemM5w=;
 b=ot7WBMmXY5HM/C2J2pVqly2HkYYuxs+PF/hGzVIBnLjH9YlbnqKUgvuAGX8dIfIlMwkYqm
 1OlxBVJmhXh6lpAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5B71D13AEB;
 Fri, 14 Feb 2025 20:32:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qNSuBkaor2cgEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 14 Feb 2025 20:32:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/22] io: tls: Add qio_channel_tls_bye
Date: Fri, 14 Feb 2025 17:31:39 -0300
Message-Id: <20250214203159.30168-3-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250214203159.30168-1-farosas@suse.de>
References: <20250214203159.30168-1-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
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


