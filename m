Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC1F1CAC58E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 21:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwomE-0002ii-AX; Thu, 11 Sep 2025 17:24:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom7-0002h1-V2
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uwom5-0008QQ-Bk
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 17:24:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757625852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x+mQzcBNcIdFANreHLy90tT/Nh2HwBTHifc2In8UdMM=;
 b=hJWIHVh83qzNmA/AOUzGwMCy1cLfbZkXCokofQ9oTC8d/VEOVmnv0NWLsm4Fla3zVWcCoL
 qmBvxGc/Hf6dWeDU3jdqgT+fiQPQbmDswEF0fJQX/MvIKt+WKGZpWReeHVTmRL8L9WbgQc
 4usfCMBOCvNuM1YeaI+veDf6GjyYJaQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-EJ1Dh1aaMG2v9oRnWZ-DWw-1; Thu, 11 Sep 2025 17:24:11 -0400
X-MC-Unique: EJ1Dh1aaMG2v9oRnWZ-DWw-1
X-Mimecast-MFC-AGG-ID: EJ1Dh1aaMG2v9oRnWZ-DWw_1757625851
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7e870623cdaso263676985a.2
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 14:24:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757625850; x=1758230650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x+mQzcBNcIdFANreHLy90tT/Nh2HwBTHifc2In8UdMM=;
 b=oK9XTWJywJ5QYbK8zrnDSDWkVTwyELddb4VC1M1GvpoNeSXklWH59V665WjzeF1CHQ
 WiMp9cYAHOTHZ+2egmtitUaJQrTspwS36YYp5IAZjsr6JPs9nmOsXbK7zACR5t6S1KXm
 QBe0ze4HiOReugGBb2T8OoMoLF6NpUeCiBMqzZJcs9LiLSMDvpgkweGIx/LefDAl4zhO
 56h+vXzD0/e3xmjJTZn/st8faHorMYgjnx0FvTKanIzqVYJdg6exbTt88m9XmkwVJP4A
 ZqIYNWsmQsdmYewLPZPowPH8dizDWLTMYRTLJN/LTdHl4yRrxx9ZUVLLQsu6mu2SOGhY
 6cWA==
X-Gm-Message-State: AOJu0YyLpPAh2OQckcIZwIc1wMVv9dy00NJiEhnEekb/w/Q+axVVqwJq
 I35a72RJwaxvG4xAgmwbAtS34T0Q7E8eoqjEsSkBfApP8usPLw5kPTGrP4KIyONNxCNDYV2dQSQ
 MN3FlXq7DEmBpas5i59s2tDYvNnWK0NdP7XKwMTCyiD1fx7qDsx+pPjbF+0TIxR/pVoD8b+o3jP
 rtIyc93gGM2cOX3Dsvl+m5IC+jJ5+VGxWHFwXC9w==
X-Gm-Gg: ASbGnctrDOZD5MUT4Pmt3Oam2bn8MAc+s1AxFlfbpRzvubSf+mwrUvLjKFih8xDAszo
 j2kxzgRuvCjKDZZtz4klW1rzc4Rk4AJvwIRtXBYl11gYtFPa8W+GKGVkeY8G9j4gw8yv5PbyYjB
 tNjuuYjIeeFiM9ePC1e/ToS5QvJnmZVwHmAwY6lcNcF9agW7xuV8NFoET20ltXoywtQ3hnDabsj
 UvZIY98/Fcf4O5H9bKIbTC4FreWZxcO8HhBQFjRJ5FzBwM2SISoITU5Q+0mNlRm6YY94BWKfA7Y
 0jQlDPkNTyFFt50ytK6zru+XccJpCg==
X-Received: by 2002:a05:620a:44c4:b0:810:69dc:6e with SMTP id
 af79cd13be357-824032b00b6mr109965285a.58.1757625850308; 
 Thu, 11 Sep 2025 14:24:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGORlmUezVTkXzefb94IHJ4Mq5bzWIFkEbTyVVPBSxxOTmsLhImL3iiIduH/FYKY7v/VJ+w9Q==
X-Received: by 2002:a05:620a:44c4:b0:810:69dc:6e with SMTP id
 af79cd13be357-824032b00b6mr109962385a.58.1757625849812; 
 Thu, 11 Sep 2025 14:24:09 -0700 (PDT)
Received: from x1.com ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-820c9845c47sm166032285a.28.2025.09.11.14.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 14:24:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 peterx@redhat.com, Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 2/3] io/tls: Make qio_channel_tls_bye() always synchronous
Date: Thu, 11 Sep 2025 17:23:54 -0400
Message-ID: <20250911212355.1943494-3-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250911212355.1943494-1-peterx@redhat.com>
References: <20250911212355.1943494-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

No issue I hit, the change is only from code observation when I am looking
at a TLS premature termination issue.

qio_channel_tls_bye() API needs to be synchronous.  When it's not, the
previous impl will attach an asynchronous task retrying but only until when
the channel gets the relevant GIO event. It may be problematic, because the
caller of qio_channel_tls_bye() may have invoked channel close() before
that, leading to premature termination of the TLS session.

Remove the asynchronous handling, instead retry it immediately.  Currently,
the only two possible cases that may lead to async task is either INTERRUPT
or EAGAIN.  It should be suffice to spin retry as of now, until a solid
proof showing that a more complicated retry logic is needed.

With that, we can remove the whole async model for the bye task.

When at it, making the function return bool, which looks like a common
pattern in QEMU when errp is used.

Side note on the tracepoints: previously the tracepoint bye_complete()
isn't used.  Start to use it in this patch.  bye_pending() and bye_cancel()
can be dropped now.  Adding bye_retry() instead.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/io/channel-tls.h |  5 ++-
 io/channel-tls.c         | 86 +++++-----------------------------------
 io/trace-events          |  3 +-
 3 files changed, 15 insertions(+), 79 deletions(-)

diff --git a/include/io/channel-tls.h b/include/io/channel-tls.h
index 7e9023570d..bcd14ffbd6 100644
--- a/include/io/channel-tls.h
+++ b/include/io/channel-tls.h
@@ -49,7 +49,6 @@ struct QIOChannelTLS {
     QCryptoTLSSession *session;
     QIOChannelShutdown shutdown;
     guint hs_ioc_tag;
-    guint bye_ioc_tag;
 };
 
 /**
@@ -60,8 +59,10 @@ struct QIOChannelTLS {
  * Perform the TLS session termination. This method will return
  * immediately and the termination will continue in the background,
  * provided the main loop is running.
+ *
+ * Returns: true on success, false on error (with errp set)
  */
-void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
+bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp);
 
 /**
  * qio_channel_tls_new_server:
diff --git a/io/channel-tls.c b/io/channel-tls.c
index 5a2c8188ce..8510a187a8 100644
--- a/io/channel-tls.c
+++ b/io/channel-tls.c
@@ -253,84 +253,25 @@ void qio_channel_tls_handshake(QIOChannelTLS *ioc,
     qio_channel_tls_handshake_task(ioc, task, context);
 }
 
-static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
-                                       gpointer user_data);
-
-static void qio_channel_tls_bye_task(QIOChannelTLS *ioc, QIOTask *task,
-                                     GMainContext *context)
+bool qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
 {
-    GIOCondition condition;
-    QIOChannelTLSData *data;
     int status;
-    Error *err = NULL;
 
-    status = qcrypto_tls_session_bye(ioc->session, &err);
+    trace_qio_channel_tls_bye_start(ioc);
+retry:
+    status = qcrypto_tls_session_bye(ioc->session, errp);
 
     if (status < 0) {
         trace_qio_channel_tls_bye_fail(ioc);
-        qio_task_set_error(task, err);
-        qio_task_complete(task);
-        return;
-    }
-
-    if (status == QCRYPTO_TLS_BYE_COMPLETE) {
-        qio_task_complete(task);
-        return;
-    }
-
-    data = g_new0(typeof(*data), 1);
-    data->task = task;
-    data->context = context;
-
-    if (context) {
-        g_main_context_ref(context);
-    }
-
-    if (status == QCRYPTO_TLS_BYE_SENDING) {
-        condition = G_IO_OUT;
-    } else {
-        condition = G_IO_IN;
-    }
-
-    trace_qio_channel_tls_bye_pending(ioc, status);
-    ioc->bye_ioc_tag = qio_channel_add_watch_full(ioc->master, condition,
-                                                  qio_channel_tls_bye_io,
-                                                  data, NULL, context);
-}
-
-
-static gboolean qio_channel_tls_bye_io(QIOChannel *ioc, GIOCondition condition,
-                                       gpointer user_data)
-{
-    QIOChannelTLSData *data = user_data;
-    QIOTask *task = data->task;
-    GMainContext *context = data->context;
-    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(qio_task_get_source(task));
-
-    tioc->bye_ioc_tag = 0;
-    g_free(data);
-    qio_channel_tls_bye_task(tioc, task, context);
-
-    if (context) {
-        g_main_context_unref(context);
+        return false;
+    } else if (status != QCRYPTO_TLS_BYE_COMPLETE) {
+        /* BYE event must be synchronous, retry immediately */
+        trace_qio_channel_tls_bye_retry(ioc, status);
+        goto retry;
     }
 
-    return FALSE;
-}
-
-static void propagate_error(QIOTask *task, gpointer opaque)
-{
-    qio_task_propagate_error(task, opaque);
-}
-
-void qio_channel_tls_bye(QIOChannelTLS *ioc, Error **errp)
-{
-    QIOTask *task;
-
-    task = qio_task_new(OBJECT(ioc), propagate_error, errp, NULL);
-
-    trace_qio_channel_tls_bye_start(ioc);
-    qio_channel_tls_bye_task(ioc, task, NULL);
+    trace_qio_channel_tls_bye_complete(ioc);
+    return true;
 }
 
 static void qio_channel_tls_init(Object *obj G_GNUC_UNUSED)
@@ -482,11 +423,6 @@ static int qio_channel_tls_close(QIOChannel *ioc,
         g_clear_handle_id(&tioc->hs_ioc_tag, g_source_remove);
     }
 
-    if (tioc->bye_ioc_tag) {
-        trace_qio_channel_tls_bye_cancel(ioc);
-        g_clear_handle_id(&tioc->bye_ioc_tag, g_source_remove);
-    }
-
     return qio_channel_close(tioc->master, errp);
 }
 
diff --git a/io/trace-events b/io/trace-events
index dc3a63ba1f..67b3814192 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -45,10 +45,9 @@ qio_channel_tls_handshake_fail(void *ioc) "TLS handshake fail ioc=%p"
 qio_channel_tls_handshake_complete(void *ioc) "TLS handshake complete ioc=%p"
 qio_channel_tls_handshake_cancel(void *ioc) "TLS handshake cancel ioc=%p"
 qio_channel_tls_bye_start(void *ioc) "TLS termination start ioc=%p"
-qio_channel_tls_bye_pending(void *ioc, int status) "TLS termination pending ioc=%p status=%d"
+qio_channel_tls_bye_retry(void *ioc, int status) "TLS termination pending ioc=%p status=%d"
 qio_channel_tls_bye_fail(void *ioc) "TLS termination fail ioc=%p"
 qio_channel_tls_bye_complete(void *ioc) "TLS termination complete ioc=%p"
-qio_channel_tls_bye_cancel(void *ioc) "TLS termination cancel ioc=%p"
 qio_channel_tls_credentials_allow(void *ioc) "TLS credentials allow ioc=%p"
 qio_channel_tls_credentials_deny(void *ioc) "TLS credentials deny ioc=%p"
 
-- 
2.50.1


