Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21022C88E5C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 06:25:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5dek-0000Nd-9e; Sun, 13 Sep 2026 02:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5dei-0000NT-Uu
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:37 -0400
Received: from va-1-113.ptr.blmpb.com ([209.127.230.113])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yanfei.xu@bytedance.com>)
 id 1x5deh-0002nT-9l
 for qemu-devel@nongnu.org; Sun, 13 Sep 2026 02:25:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1789280730; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=rgSYZtlmiY5NJdMpd9oRG7QhQ62tMG20JkaP9+NpoEU=;
 b=qFl2d6S//0guplYAqE496+pUIJ89e5oWddSCnCy21RskfPaNUEVtZM8+DptQfF7/XqBlsW
 XV6iIu68SY/vnIvlCZJB9O93tK/sOLQuWc0Oh7NBhbB7UOV3G6bh2Z8wzz2pT7Y1wxHdDo
 iS/lgsU+tVJMxGwNn05WipmkRA4hoViwTtdNF+qzvNRh5jlZOuEsyDtu78yFZyMmOoap8L
 FwY0Tc6o+PzKPQvXcQZpswdNk2++MS28yQgAQo8O4b24DFIQ+QH/6w1sEvnEjegkKfMeF8
 f94uNzCuq96NW+wZaLDGZibupqx73mSalcac9SIhg1WGNoCSM/+UUpOLi6BZHw==
Message-Id: <20260913062455.940447-3-yanfei.xu@bytedance.com>
X-Mailer: git-send-email 2.20.1
X-Lms-Return-Path: <lba+26aa641d8+0326b3+nongnu.org+yanfei.xu@bytedance.com>
References: <20260913062455.940447-1-yanfei.xu@bytedance.com>
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
In-Reply-To: <20260913062455.940447-1-yanfei.xu@bytedance.com>
X-Original-From: Yanfei Xu <yanfei.xu@bytedance.com>
Content-Type: text/plain; charset=UTF-8
To: <qemu-devel@nongnu.org>, <peterx@redhat.com>
Cc: <farosas@suse.de>, <lizhijian@fujitsu.com>, <isyanfei.xu@gmail.com>, 
 <jinpu.wang@cloud.ionos.com>, "Yanfei Xu" <yanfei.xu@bytedance.com>
Subject: [PATCH v3 2/4] migration/rdma: Drain writes at RAM round boundaries
From: "Yanfei Xu" <yanfei.xu@bytedance.com>
Date: Sun, 13 Sep 2026 14:24:53 +0800
Received-SPF: pass client-ip=209.127.230.113;
 envelope-from=yanfei.xu@bytedance.com; helo=va-1-113.ptr.blmpb.com
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
Reviewed-by: Peter Xu <peterx@redhat.com>
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

