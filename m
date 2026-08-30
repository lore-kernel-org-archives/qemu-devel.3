Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E003C61DE1
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Aug 2026 01:29:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0ULo-0000OA-H4; Sat, 29 Aug 2026 21:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x0ULc-0000NM-Jl
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 21:28:36 -0400
Received: from va-1-114.ptr.blmpb.com ([209.127.230.114])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x0ULa-000225-Ve
 for qemu-devel@nongnu.org; Sat, 29 Aug 2026 21:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1788053305; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Sf1uKXPcK9/VhfK4bhxwCrNKo59bCIfoZfWweLzo+rw=;
 b=mAcKSvXykZZJGfPxhV+NhHXb9bfOk1+gLfXYUxvURVqS4HLo+IXqqVMHTZ6ZiaM1XSYH64
 +myljLzofejIAyZIn/RwoyW0HJEKjIOyLeyifUfI8DN+73u2eE38czW8E7YlCpoQd70Fux
 KD1tE8D7wD7r0iztk0mSx34aFOmgHwJhkj0Bs4FJQyiDLJtD2jr0k6ekPEa9hWJytAmDxK
 SciaJovJLpaD6J6t2iI7Lsezl1fd5PAdnQTsfqvlp/m+inB438iBlljD8en/exnjgxk3st
 CUvnDhmxt0X//7MRwn0n9JCv5mMsMDffOoYycBK+mwAvzzCybrRHqLWnnbH2Vw==
Content-Transfer-Encoding: 7bit
References: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
Cc: <peterx@redhat.com>, <farosas@suse.de>, <lizhijian@fujitsu.com>, 
 <jinpu.wang@cloud.ionos.com>, <isyanfei.xu@gmail.com>, 
 "Yanfei Xu" <yanfei.xu@bytedance.com>
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Sun, 30 Aug 2026 09:27:48 +0800
In-Reply-To: <20260830012750.1567524-1-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
To: <qemu-devel@nongnu.org>
Subject: [PATCH v2 2/4] migration/rdma: Drain writes at RAM round boundaries
Message-Id: <20260830012750.1567524-3-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a938738+8f537e+nongnu.org+yanfei.xu@bytedance.com>
Received-SPF: pass client-ip=209.127.230.114;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-114.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

rdma_registration_stop() runs after every ram_save_iterate() call, which
can stop before a complete RAM scan because of rate limiting.  Draining
there ties the completion barrier to a SaveVM section rather than the
point where the scan wraps and a newer page version can be sent.

Register an RDMA RAM round notifier that drains all outstanding writes.
Keep posting the buffered tail in rdma_registration_stop() so it remains
ordered before REGISTER_FINISHED.

Signed-off-by: Yanfei Xu <yanfei.xu@bytedance.com>
---
 migration/rdma.c | 58 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index b8a0e39d2a..16e9c6c30e 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -2627,21 +2627,16 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
     return done;
 }
 
-/*
- * Block until all the outstanding chunks have been delivered by the hardware.
- */
-static int qemu_rdma_drain_cq(RDMAContext *rdma)
+/* Block until all outstanding writes have been delivered by the hardware. */
+static int qemu_rdma_drain_cq(RDMAContext *rdma, Error **errp)
 {
-    Error *err = NULL;
-
-    if (qemu_rdma_write_flush(rdma, &err) < 0) {
-        error_report_err(err);
+    if (qemu_rdma_write_flush(rdma, errp) < 0) {
         return -1;
     }
 
     while (rdma->nb_sent) {
         if (qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE, NULL) < 0) {
-            error_report("rdma migration: complete polling error!");
+            error_setg(errp, "rdma migration: completion polling error");
             return -1;
         }
     }
@@ -2649,6 +2644,38 @@ static int qemu_rdma_drain_cq(RDMAContext *rdma)
     return 0;
 }
 
+static int rdma_ram_round_notify(NotifierWithReturn *n G_GNUC_UNUSED,
+                                 void *data, Error **errp)
+{
+    RAMRoundNotifyData *round_data = data;
+    QEMUFile *f;
+    QIOChannelRDMA *rioc;
+    RDMAContext *rdma;
+
+    if (!migrate_rdma()) {
+        return 0;
+    }
+
+    f = round_data->file;
+    RCU_READ_LOCK_GUARD();
+    rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));
+    rdma = qatomic_rcu_read(&rioc->rdmaout);
+    if (!rdma) {
+        error_setg(errp, "RDMA output context is not set");
+        return -1;
+    }
+
+    if (rdma_errored(rdma)) {
+        error_setg(errp, "RDMA is in an error state");
+        return -1;
+    }
+
+    return qemu_rdma_drain_cq(rdma, errp);
+}
+
+static NotifierWithReturn rdma_ram_round_notifier = {
+    .notify = rdma_ram_round_notify,
+};
 
 static int qio_channel_rdma_set_blocking(QIOChannel *ioc,
                                          bool blocking,
@@ -3549,7 +3576,8 @@ int rdma_registration_start(QEMUFile *f, uint64_t flags)
 
 /*
  * Inform dest that dynamic registrations are done for now.
- * First, flush writes, if any.
+ * Post any buffered write before sending the control marker. Outstanding
+ * writes are drained at the RAM scan round boundary.
  */
 int rdma_registration_stop(QEMUFile *f, uint64_t flags)
 {
@@ -3575,9 +3603,10 @@ int rdma_registration_stop(QEMUFile *f, uint64_t flags)
     }
 
     qemu_fflush(f);
-    ret = qemu_rdma_drain_cq(rdma);
+    ret = qemu_rdma_write_flush(rdma, &err);
 
     if (ret < 0) {
+        error_report_err(err);
         goto err;
     }
 
@@ -3711,6 +3740,13 @@ static void qio_channel_rdma_register_types(void)
 
 type_init(qio_channel_rdma_register_types);
 
+static void rdma_register_migration_notifiers(void)
+{
+    ram_round_add_notifier(&rdma_ram_round_notifier);
+}
+
+migration_init(rdma_register_migration_notifiers);
+
 static QIOChannel *rdma_new_input(RDMAContext *rdma)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
-- 
2.20.1

