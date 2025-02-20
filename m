Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F31C021AD
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 04:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkxpA-0003xD-D9; Wed, 19 Feb 2025 23:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkxot-0003w9-9R
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 23:05:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1tkxop-0000zb-IH
 for qemu-devel@nongnu.org; Wed, 19 Feb 2025 23:05:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740024346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OoB0yBiVjNHJV+NYyxL+fXz06sWFB7f1khOQILrXoog=;
 b=gpVT9B9VR0j/6TmyJ+LwOEo+nK8UWrvCZZ65+UZoiUaVudvQTgW2mAD6zjqZy/sMIr5jFG
 GeOg23W4B6/AXZxc9hlGuJ3Z8eGUTSKLRZks09H6TtJdxz5YfDGjyQFV4W+i6k3tD9Gu4J
 uIHIAqRizmvwhnqbVHjj5lmJlNDPnbw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-323-LxCPlk-aPdaGAM3rrOPyKg-1; Wed,
 19 Feb 2025 23:05:43 -0500
X-MC-Unique: LxCPlk-aPdaGAM3rrOPyKg-1
X-Mimecast-MFC-AGG-ID: LxCPlk-aPdaGAM3rrOPyKg_1740024342
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28F1019560AF; Thu, 20 Feb 2025 04:05:42 +0000 (UTC)
Received: from localhost (unknown [10.2.16.35])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D593F1955BCB; Thu, 20 Feb 2025 04:05:39 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] iothread: defer AioContext GSource usage
Date: Thu, 20 Feb 2025 12:05:36 +0800
Message-ID: <20250220040536.195180-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.191,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Getting the GSource for the AioContext stops fdmon-io_uring from working
because it is not compatible with the glib event loop. Defer the GSource
code until the glib event loop is actually used. For typical IOThreads
this may never be the case and we can use fdmon-io_uring.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/system/iothread.h |  1 +
 iothread.c                | 22 +++++++++++++---------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/system/iothread.h b/include/system/iothread.h
index d95c17a645..51ae2f1a78 100644
--- a/include/system/iothread.h
+++ b/include/system/iothread.h
@@ -33,6 +33,7 @@ struct IOThread {
     bool stopping;              /* has iothread_stop() been called? */
     bool running;               /* should iothread_run() continue? */
     int thread_id;
+    char *g_source_name;
 
     /* AioContext poll parameters */
     int64_t poll_max_ns;
diff --git a/iothread.c b/iothread.c
index 589bcd3552..2c2b27208d 100644
--- a/iothread.c
+++ b/iothread.c
@@ -67,7 +67,14 @@ static void *iothread_run(void *opaque)
          * changed in previous aio_poll()
          */
         if (iothread->running && qatomic_read(&iothread->run_gcontext)) {
+            GSource *source = aio_get_g_source(iothread->ctx);
+
+            g_source_set_name(source, iothread->g_source_name);
+            g_source_attach(source, iothread->worker_context);
+            g_source_unref(source);
+
             g_main_loop_run(iothread->main_loop);
+            assert(!iothread->running);
         }
     }
 
@@ -136,18 +143,14 @@ static void iothread_instance_finalize(Object *obj)
         iothread->main_loop = NULL;
     }
     qemu_sem_destroy(&iothread->init_done_sem);
+
+    g_free(iothread->g_source_name);
+    iothread->g_source_name = NULL;
 }
 
-static void iothread_init_gcontext(IOThread *iothread, const char *thread_name)
+static void iothread_init_gcontext(IOThread *iothread)
 {
-    GSource *source;
-    g_autofree char *name = g_strdup_printf("%s aio-context", thread_name);
-
     iothread->worker_context = g_main_context_new();
-    source = aio_get_g_source(iothread_get_aio_context(iothread));
-    g_source_set_name(source, name);
-    g_source_attach(source, iothread->worker_context);
-    g_source_unref(source);
     iothread->main_loop = g_main_loop_new(iothread->worker_context, TRUE);
 }
 
@@ -192,12 +195,13 @@ static void iothread_init(EventLoopBase *base, Error **errp)
 
     thread_name = g_strdup_printf("IO %s",
                         object_get_canonical_path_component(OBJECT(base)));
+    iothread->g_source_name = g_strdup_printf("%s aio-context", thread_name);
 
     /*
      * Init one GMainContext for the iothread unconditionally, even if
      * it's not used
      */
-    iothread_init_gcontext(iothread, thread_name);
+    iothread_init_gcontext(iothread);
 
     iothread_set_aio_context_params(base, &local_error);
     if (local_error) {
-- 
2.48.1


