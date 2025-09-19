Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F7CACAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZfQ-0002xo-Pu; Fri, 19 Sep 2025 07:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZen-0002cT-Pf
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uzZel-0000sp-5z
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:52:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758282717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0mk2+5odIxLDvJ8M3BZaxRVZ+iWKW+dUIpWQQsle4E=;
 b=Yz9L9SvuWPsJkRFRSW0T3BLxcYlFAD/J+F4PjYi03xB4eq1xQuzvnTYP+b7hKdctLDsIGh
 7VrZ6k3+1apz1ftoTc9AVIl9qFIf5PrIj2v4vpKdopJTOEy5tVakUSZmfhjrTB1QKVLsQg
 wdwC7DSE/jNd7WcRkNCTN+uoSWOitrE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-311-UuI39O5qO6yFgKM27TwZnQ-1; Fri,
 19 Sep 2025 07:51:54 -0400
X-MC-Unique: UuI39O5qO6yFgKM27TwZnQ-1
X-Mimecast-MFC-AGG-ID: UuI39O5qO6yFgKM27TwZnQ_1758282712
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BEA451800288; Fri, 19 Sep 2025 11:51:51 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.187])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C76351955F21; Fri, 19 Sep 2025 11:51:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Peter Xu <peterx@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John Levon <john.levon@nutanix.com>, Fam Zheng <fam@euphon.net>,
 Alexander Bulekov <alxndr@bu.edu>, Stefan Weil <sw@weilnetz.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Qiuhao Li <Qiuhao.Li@outlook.com>, Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Bandan Das <bsd@redhat.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Hailiang Zhang <zhanghailiang@xfusion.com>
Subject: [PULL 08/16] migration: qemu_file_set_blocking(): add errp parameter
Date: Fri, 19 Sep 2025 12:50:09 +0100
Message-ID: <20250919115017.1536203-9-berrange@redhat.com>
In-Reply-To: <20250919115017.1536203-1-berrange@redhat.com>
References: <20250919115017.1536203-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

qemu_file_set_blocking() is a wrapper on qio_channel_set_blocking(),
so let's passthrough the errp.

Note the migration should not be using &error_abort in these calls,
however, this is done to expedite the API conversion.

The original code would have eventually ended up calling either
qemu_socket_set_nonblock which would asset on Linux, or
g_unix_set_fd_nonblocking which would propagate errors. We never
saw asserts in practice, and conceptually they should not happen,
but ideally this code will be later adapted to remove use of
&error_abort.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/colo.c         | 5 ++++-
 migration/migration.c    | 8 +++++---
 migration/postcopy-ram.c | 2 +-
 migration/qemu-file.c    | 4 ++--
 migration/qemu-file.h    | 2 +-
 migration/savevm.c       | 4 ++--
 6 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index e0f713c837..cf4d71d9ed 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -859,7 +859,10 @@ static void *colo_process_incoming_thread(void *opaque)
      * coroutine, and here we are in the COLO incoming thread, so it is ok to
      * set the fd back to blocked.
      */
-    qemu_file_set_blocking(mis->from_src_file, true);
+    if (!qemu_file_set_blocking(mis->from_src_file, true, &local_err)) {
+        error_report_err(local_err);
+        goto out;
+    }
 
     colo_incoming_start_dirty_log();
 
diff --git a/migration/migration.c b/migration/migration.c
index 10c216d25d..e1ac4d73c2 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -951,7 +951,7 @@ static void migration_incoming_setup(QEMUFile *f)
 
     assert(!mis->from_src_file);
     mis->from_src_file = f;
-    qemu_file_set_blocking(f, false);
+    qemu_file_set_blocking(f, false, &error_abort);
 }
 
 void migration_incoming_process(void)
@@ -971,7 +971,7 @@ static bool postcopy_try_recover(void)
         /* This should be set already in migration_incoming_setup() */
         assert(mis->from_src_file);
         /* Postcopy has standalone thread to do vm load */
-        qemu_file_set_blocking(mis->from_src_file, true);
+        qemu_file_set_blocking(mis->from_src_file, true, &error_abort);
 
         /* Re-configure the return path */
         mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
@@ -4002,7 +4002,9 @@ void migration_connect(MigrationState *s, Error *error_in)
     }
 
     migration_rate_set(rate_limit);
-    qemu_file_set_blocking(s->to_dst_file, true);
+    if (!qemu_file_set_blocking(s->to_dst_file, true, &local_err)) {
+        goto fail;
+    }
 
     /*
      * Open the return path. For postcopy, it is used exclusively. For
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 45af9a361e..0172172343 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1909,7 +1909,7 @@ void postcopy_preempt_new_channel(MigrationIncomingState *mis, QEMUFile *file)
      * The new loading channel has its own threads, so it needs to be
      * blocked too.  It's by default true, just be explicit.
      */
-    qemu_file_set_blocking(file, true);
+    qemu_file_set_blocking(file, true, &error_abort);
     mis->postcopy_qemufile_dst = file;
     qemu_sem_post(&mis->postcopy_qemufile_dst_done);
     trace_postcopy_preempt_new_channel();
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index d5c6e7ec61..0f4280df21 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -888,9 +888,9 @@ void qemu_put_counted_string(QEMUFile *f, const char *str)
  *       both directions, and thus changing the blocking on the main
  *       QEMUFile can also affect the return path.
  */
-void qemu_file_set_blocking(QEMUFile *f, bool block)
+bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp)
 {
-    qio_channel_set_blocking(f->ioc, block, NULL);
+    return qio_channel_set_blocking(f->ioc, block, errp);
 }
 
 /*
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index f5b9f430e0..c13c967167 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -71,7 +71,7 @@ void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 int qemu_fflush(QEMUFile *f);
-void qemu_file_set_blocking(QEMUFile *f, bool block);
+bool qemu_file_set_blocking(QEMUFile *f, bool block, Error **errp);
 int qemu_file_get_to_fd(QEMUFile *f, int fd, size_t size);
 void qemu_set_offset(QEMUFile *f, off_t off, int whence);
 off_t qemu_get_offset(QEMUFile *f);
diff --git a/migration/savevm.c b/migration/savevm.c
index fabbeb296a..abe0547f9b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2095,7 +2095,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
      * Because we're a thread and not a coroutine we can't yield
      * in qemu_file, and thus we must be blocking now.
      */
-    qemu_file_set_blocking(f, true);
+    qemu_file_set_blocking(f, true, &error_fatal);
 
     /* TODO: sanity check that only postcopiable data will be loaded here */
     load_res = qemu_loadvm_state_main(f, mis);
@@ -2108,7 +2108,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     f = mis->from_src_file;
 
     /* And non-blocking again so we don't block in any cleanup */
-    qemu_file_set_blocking(f, false);
+    qemu_file_set_blocking(f, false, &error_fatal);
 
     trace_postcopy_ram_listen_thread_exit();
     if (load_res < 0) {
-- 
2.50.1


