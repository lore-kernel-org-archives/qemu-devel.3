Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 719B1C4828F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 03:08:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXulU-0001qV-C0; Wed, 07 Feb 2024 22:07:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXuki-00075s-Kp
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rXukg-0004RZ-Oz
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 22:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707361619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vGIrHIQU+h6EjMRrQgJmpPfxPr2te/s8Zc7EDzP32+E=;
 b=KIfuCEd20yOpXY91Vs2UQ4Z3UUUiI1ZZ6ZT0Xwe7eTvqgi8J4chs2QPvVx2vVvC0OL/ELA
 PgW5MuETNnggQiayFpdz2Dvg+26y+AisIXAP3kdZSvkGqzGDFE9Uu6O4yzkDoVIgLGkgut
 zdtxz7dhImm8BD1NdUmRwSlmyndJLPk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-vRVOLyu4PGGLe5a1qic1YA-1; Wed, 07 Feb 2024 22:06:55 -0500
X-MC-Unique: vRVOLyu4PGGLe5a1qic1YA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E86A185A78E;
 Thu,  8 Feb 2024 03:06:55 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5A2AE492BC7;
 Thu,  8 Feb 2024 03:06:51 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 qemu-stable <qemu-stable@nongnu.org>
Subject: [PULL 26/34] migration/multifd: Join the TLS thread
Date: Thu,  8 Feb 2024 11:05:20 +0800
Message-ID: <20240208030528.368214-27-peterx@redhat.com>
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
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We're currently leaking the resources of the TLS thread by not joining
it and also overwriting the p->thread pointer altogether.

Fixes: a1af605bd5 ("migration/multifd: fix hangup with TLS-Multifd due to blocking handshake")
Cc: qemu-stable <qemu-stable@nongnu.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20240206215118.6171-2-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.h | 2 ++
 migration/multifd.c | 8 +++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/multifd.h b/migration/multifd.h
index 78a2317263..720c9d50db 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -73,6 +73,8 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    QemuThread tls_thread;
+    bool tls_thread_created;
     /* communication channel */
     QIOChannel *c;
     /* is the yank function registered */
diff --git a/migration/multifd.c b/migration/multifd.c
index fbdb129088..5551711a2a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -630,6 +630,10 @@ static void multifd_send_terminate_threads(void)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
+        if (p->tls_thread_created) {
+            qemu_thread_join(&p->tls_thread);
+        }
+
         if (p->running) {
             qemu_thread_join(&p->thread);
         }
@@ -921,7 +925,9 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
     p->c = QIO_CHANNEL(tioc);
-    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
+
+    p->tls_thread_created = true;
+    qemu_thread_create(&p->tls_thread, "multifd-tls-handshake-worker",
                        multifd_tls_handshake_thread, p,
                        QEMU_THREAD_JOINABLE);
     return true;
-- 
2.43.0


