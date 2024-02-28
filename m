Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA755C54E4A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 05:14:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfCGh-0006AN-Mm; Wed, 28 Feb 2024 00:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCGf-0006A2-TN
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfCGd-0006Zg-Ma
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 00:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709097247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/YsYcd0edDyziUKc6khHo12W22MFhpxORoWGUlgvu5s=;
 b=i9spdH2Sz2DBppxUysaPoM59Bt26Y/ZRLtFl076vcjCNjBxFKJVlDO9Rad5DaKJjalLFNe
 +LL9BdNamsTdlJJQ2c9sE6iJTPny2jWVefrTX9Tc3s5AodkPVv7vmAdiHH0hbIBEd6HnC2
 CDVu3BUypAveg93sylRJsfMOjBQpai8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-ngPV9SR9P8WuJuxHtJ5_yg-1; Wed,
 28 Feb 2024 00:14:03 -0500
X-MC-Unique: ngPV9SR9P8WuJuxHtJ5_yg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E70A438212D8;
 Wed, 28 Feb 2024 05:14:02 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9E6911C060AF;
 Wed, 28 Feb 2024 05:13:54 +0000 (UTC)
From: peterx@redhat.com
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PULL 04/25] migration/multifd: Remove p->quit from recv side
Date: Wed, 28 Feb 2024 13:12:54 +0800
Message-ID: <20240228051315.400759-5-peterx@redhat.com>
In-Reply-To: <20240228051315.400759-1-peterx@redhat.com>
References: <20240228051315.400759-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

From: Fabiano Rosas <farosas@suse.de>

Like we did on the sending side, replace the p->quit per-channel flag
with a global atomic 'exiting' flag.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20240220224138.24759-5-farosas@suse.de
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 41 ++++++++++++++++++++++++-----------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index adfe8c9a0a..fba00b9e8f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -79,6 +79,19 @@ struct {
     MultiFDMethods *ops;
 } *multifd_send_state;
 
+struct {
+    MultiFDRecvParams *params;
+    /* number of created threads */
+    int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+    /* global number of generated multifd packets */
+    uint64_t packet_num;
+    int exiting;
+    /* multifd ops */
+    MultiFDMethods *ops;
+} *multifd_recv_state;
+
 /* Multifd without compression */
 
 /**
@@ -440,6 +453,11 @@ static bool multifd_send_should_exit(void)
     return qatomic_read(&multifd_send_state->exiting);
 }
 
+static bool multifd_recv_should_exit(void)
+{
+    return qatomic_read(&multifd_recv_state->exiting);
+}
+
 /*
  * The migration thread can wait on either of the two semaphores.  This
  * function can be used to kick the main thread out of waiting on either of
@@ -1063,24 +1081,16 @@ bool multifd_send_setup(void)
     return true;
 }
 
-struct {
-    MultiFDRecvParams *params;
-    /* number of created threads */
-    int count;
-    /* syncs main thread and channels */
-    QemuSemaphore sem_sync;
-    /* global number of generated multifd packets */
-    uint64_t packet_num;
-    /* multifd ops */
-    MultiFDMethods *ops;
-} *multifd_recv_state;
-
 static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
 
     trace_multifd_recv_terminate_threads(err != NULL);
 
+    if (qatomic_xchg(&multifd_recv_state->exiting, 1)) {
+        return;
+    }
+
     if (err) {
         MigrationState *s = migrate_get_current();
         migrate_set_error(s, err);
@@ -1094,8 +1104,6 @@ static void multifd_recv_terminate_threads(Error *err)
     for (i = 0; i < migrate_multifd_channels(); i++) {
         MultiFDRecvParams *p = &multifd_recv_state->params[i];
 
-        qemu_mutex_lock(&p->mutex);
-        p->quit = true;
         /*
          * We could arrive here for two reasons:
          *  - normal quit, i.e. everything went fine, just finished
@@ -1105,7 +1113,6 @@ static void multifd_recv_terminate_threads(Error *err)
         if (p->c) {
             qio_channel_shutdown(p->c, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         }
-        qemu_mutex_unlock(&p->mutex);
     }
 }
 
@@ -1210,7 +1217,7 @@ static void *multifd_recv_thread(void *opaque)
     while (true) {
         uint32_t flags;
 
-        if (p->quit) {
+        if (multifd_recv_should_exit()) {
             break;
         }
 
@@ -1274,6 +1281,7 @@ int multifd_recv_setup(Error **errp)
     multifd_recv_state = g_malloc0(sizeof(*multifd_recv_state));
     multifd_recv_state->params = g_new0(MultiFDRecvParams, thread_count);
     qatomic_set(&multifd_recv_state->count, 0);
+    qatomic_set(&multifd_recv_state->exiting, 0);
     qemu_sem_init(&multifd_recv_state->sem_sync, 0);
     multifd_recv_state->ops = multifd_ops[migrate_multifd_compression()];
 
@@ -1282,7 +1290,6 @@ int multifd_recv_setup(Error **errp)
 
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem_sync, 0);
-        p->quit = false;
         p->id = i;
         p->packet_len = sizeof(MultiFDPacket_t)
                       + sizeof(uint64_t) * page_count;
-- 
2.43.0


