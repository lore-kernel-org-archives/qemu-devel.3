Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F82FCAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hEv-0000RH-Vn; Tue, 30 Sep 2025 16:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEu-0000Qd-8n
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEg-0004CE-Pc
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759265165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eu7XUIB56qE+E3bUTWxkMbbsl4P6ahbxfR8YPn5lggM=;
 b=XX0ws1AM4Lf1xpMOcl8z64aisBOBJhYxh+U1EQfCTo0RGJ5/o+wVGWmJF5XFfxmkPTbpCU
 2bS2qryBiBpOjEHmeRpQd9w4XaoQ+yu1KOmux20fbRSqO1R4bMupwkDcPVogeeSPIsid0K
 yTtG3ZxwC7gkFgMrZ/m7QNAt44rOoQQ=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-8zGdZMnfMiqJtdxPetn5QA-1; Tue,
 30 Sep 2025 16:46:04 -0400
X-MC-Unique: 8zGdZMnfMiqJtdxPetn5QA-1
X-Mimecast-MFC-AGG-ID: 8zGdZMnfMiqJtdxPetn5QA_1759265163
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1D5419560A2; Tue, 30 Sep 2025 20:46:02 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 887B61800577; Tue, 30 Sep 2025 20:46:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 2/4] block: add blk_add_attach/detach_notifier() APIs
Date: Tue, 30 Sep 2025 16:45:53 -0400
Message-ID: <20250930204555.162133-3-stefanha@redhat.com>
In-Reply-To: <20250930204555.162133-1-stefanha@redhat.com>
References: <20250930204555.162133-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Add an API to receive a callback when a BlockDriverState is attached or
detached from the block graph. This allows callers to track insert,
remove, and replace operations.

Note that this API might be able to replace the
blk_add_remove_bs_notifier() API if the callback checks that the root
BDS is being removed and ignores all other calls. I think this is a bit
messy though, so I kept blk_add_remove_bs_notifier().

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/system/block-backend-global-state.h |   9 ++
 block/block-backend.c                       |  44 ++++++
 tests/unit/test-block-backend.c             | 164 ++++++++++++++++++++
 3 files changed, 217 insertions(+)

diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index c3849640df..e828f271ee 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -97,6 +97,15 @@ void blk_remove_aio_context_notifier(BlockBackend *blk,
                                      void (*detach_aio_context)(void *),
                                      void *opaque);
 void blk_add_remove_bs_notifier(BlockBackend *blk, Notifier *notify);
+
+typedef struct {
+    BlockBackend *blk;
+    BlockDriverState *bs;
+} BlockBackendAttachDetachArgs;
+
+void blk_add_attach_notifier(BlockBackend *blk, Notifier *notify);
+void blk_add_detach_notifier(BlockBackend *blk, Notifier *notify);
+
 BlockBackendRootState *blk_get_root_state(BlockBackend *blk);
 void blk_update_root_state(BlockBackend *blk);
 bool blk_get_detect_zeroes_from_root_state(BlockBackend *blk);
diff --git a/block/block-backend.c b/block/block-backend.c
index f8d6ba65c1..45e31f0079 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -76,6 +76,7 @@ struct BlockBackend {
 
     /* Protected by BQL */
     NotifierList remove_bs_notifiers, insert_bs_notifiers;
+    NotifierList attach_notifiers, detach_notifiers;
     QLIST_HEAD(, BlockBackendAioNotifier) aio_notifiers;
 
     int quiesce_counter; /* atomic: written under BQL, read by other threads */
@@ -280,6 +281,30 @@ static int GRAPH_RDLOCK blk_root_inactivate(BdrvChild *child)
     return 0;
 }
 
+static void GRAPH_WRLOCK
+blk_root_propagate_attach(BdrvChild *self, BdrvChild *descendant)
+{
+    BlockBackend *blk = self->opaque;
+    BlockBackendAttachDetachArgs args = {
+        .blk = blk,
+        .bs = descendant->bs,
+    };
+
+    notifier_list_notify(&blk->attach_notifiers, &args);
+}
+
+static void GRAPH_WRLOCK
+blk_root_propagate_detach(BdrvChild *self, BdrvChild *descendant)
+{
+    BlockBackend *blk = self->opaque;
+    BlockBackendAttachDetachArgs args = {
+        .blk = blk,
+        .bs = descendant->bs,
+    };
+
+    notifier_list_notify(&blk->detach_notifiers, &args);
+}
+
 static void blk_root_attach(BdrvChild *child)
 {
     BlockBackend *blk = child->opaque;
@@ -333,6 +358,9 @@ static const BdrvChildClass child_root = {
     .activate           = blk_root_activate,
     .inactivate         = blk_root_inactivate,
 
+    .propagate_attach   = blk_root_propagate_attach,
+    .propagate_detach   = blk_root_propagate_detach,
+
     .attach             = blk_root_attach,
     .detach             = blk_root_detach,
 
@@ -374,6 +402,8 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
     qemu_co_queue_init(&blk->queued_requests);
     notifier_list_init(&blk->remove_bs_notifiers);
     notifier_list_init(&blk->insert_bs_notifiers);
+    notifier_list_init(&blk->attach_notifiers);
+    notifier_list_init(&blk->detach_notifiers);
     QLIST_INIT(&blk->aio_notifiers);
 
     QTAILQ_INSERT_TAIL(&block_backends, blk, link);
@@ -492,6 +522,8 @@ static void blk_delete(BlockBackend *blk)
     }
     assert(QLIST_EMPTY(&blk->remove_bs_notifiers.notifiers));
     assert(QLIST_EMPTY(&blk->insert_bs_notifiers.notifiers));
+    assert(QLIST_EMPTY(&blk->attach_notifiers.notifiers));
+    assert(QLIST_EMPTY(&blk->detach_notifiers.notifiers));
     assert(QLIST_EMPTY(&blk->aio_notifiers));
     assert(qemu_co_queue_empty(&blk->queued_requests));
     qemu_mutex_destroy(&blk->queued_requests_lock);
@@ -2512,6 +2544,18 @@ void blk_add_remove_bs_notifier(BlockBackend *blk, Notifier *notify)
     notifier_list_add(&blk->remove_bs_notifiers, notify);
 }
 
+void blk_add_attach_notifier(BlockBackend *blk, Notifier *notify)
+{
+    GLOBAL_STATE_CODE();
+    notifier_list_add(&blk->attach_notifiers, notify);
+}
+
+void blk_add_detach_notifier(BlockBackend *blk, Notifier *notify)
+{
+    GLOBAL_STATE_CODE();
+    notifier_list_add(&blk->detach_notifiers, notify);
+}
+
 BlockAcctStats *blk_get_stats(BlockBackend *blk)
 {
     IO_CODE();
diff --git a/tests/unit/test-block-backend.c b/tests/unit/test-block-backend.c
index 4257b3f815..693383f029 100644
--- a/tests/unit/test-block-backend.c
+++ b/tests/unit/test-block-backend.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block.h"
+#include "block/block_int.h"
 #include "system/block-backend.h"
 #include "qapi/error.h"
 #include "qemu/main-loop.h"
@@ -70,6 +71,167 @@ static void test_drain_all_aio_error(void)
     blk_unref(blk);
 }
 
+static int bdrv_test_co_change_backing_file(BlockDriverState *bs,
+                                            const char *backing_file,
+                                            const char *backing_fmt)
+{
+    return 0; /* just return success so bdrv_set_backing_hd() works */
+}
+
+static BlockDriver bdrv_test = {
+    .format_name = "test",
+    .supports_backing = true,
+    .bdrv_child_perm  = bdrv_default_perms,
+    .bdrv_co_change_backing_file = bdrv_test_co_change_backing_file,
+};
+
+typedef struct {
+    Notifier attach_notifier;
+    Notifier detach_notifier;
+    GArray *notifications;
+} AttachDetach;
+
+typedef enum {
+    NOTIFY_END = 0,
+    NOTIFY_ATTACH,
+    NOTIFY_DETACH,
+} NotificationType;
+
+typedef struct {
+    NotificationType type;
+    BlockDriverState *bs;
+} Notification;
+
+static void attach_detach_append(AttachDetach *ad, NotificationType type,
+                                 BlockBackendAttachDetachArgs *args)
+{
+    Notification n = {
+        .type = type,
+        .bs = args->bs,
+    };
+
+    g_array_append_vals(ad->notifications, &n, 1);
+}
+
+static void attach_notify(Notifier *notifier, void *data)
+{
+    AttachDetach *ad = container_of(notifier, AttachDetach, attach_notifier);
+    attach_detach_append(ad, NOTIFY_ATTACH, data);
+}
+
+static void detach_notify(Notifier *notifier, void *data)
+{
+    AttachDetach *ad = container_of(notifier, AttachDetach, attach_notifier);
+    attach_detach_append(ad, NOTIFY_DETACH, data);
+}
+
+static void attach_detach_init(AttachDetach *ad, BlockBackend *blk)
+{
+    ad->attach_notifier.notify = attach_notify;
+    ad->detach_notifier.notify = detach_notify;
+    ad->notifications = g_array_new(true, true, sizeof(Notification));
+
+    blk_add_attach_notifier(blk, &ad->attach_notifier);
+    blk_add_detach_notifier(blk, &ad->detach_notifier);
+}
+
+static void attach_detach_cleanup(AttachDetach *ad)
+{
+    g_array_free(ad->notifications, true);
+    notifier_remove(&ad->detach_notifier);
+    notifier_remove(&ad->attach_notifier);
+}
+
+/*
+ * Check that the expected notifications occurred. @expected is terminated by a
+ * NOTIFY_END element.
+ */
+static void attach_detach_expect(AttachDetach *ad, const Notification *expected)
+{
+    GArray *array = ad->notifications;
+
+    /* The array is zero terminated so there is at least one element */
+    Notification *actual = (Notification *)array->data;
+
+    while (expected->type != NOTIFY_END) {
+        g_assert_cmpint(actual->type, ==, expected->type);
+        g_assert(actual->bs == expected->bs);
+        expected++;
+        actual++;
+    }
+
+    g_assert_cmpint(actual->type, ==, NOTIFY_END);
+
+    g_array_remove_range(array, 0, array->len);
+}
+
+static void test_attach_detach_notifier(void)
+{
+    AttachDetach ad;
+    BlockDriverState *format;
+    BlockDriverState *file;
+    BlockDriverState *file2;
+    BlockBackend *blk = blk_new(qemu_get_aio_context(),
+                                BLK_PERM_ALL, BLK_PERM_ALL);
+
+    attach_detach_init(&ad, blk);
+
+    format = bdrv_new_open_driver(&bdrv_test, "format", BDRV_O_RDWR,
+                                  &error_abort);
+    file = bdrv_new_open_driver(&bdrv_test, "file", BDRV_O_RDWR, &error_abort);
+    file2 = bdrv_new_open_driver(&bdrv_test, "file2", BDRV_O_RDWR,
+                                 &error_abort);
+
+    bdrv_graph_wrlock_drained();
+    bdrv_attach_child(format, file, "file", &child_of_bds,
+                      BDRV_CHILD_PRIMARY | BDRV_CHILD_DATA, &error_abort);
+    bdrv_graph_wrunlock();
+
+    /* Insert format -> file */
+    blk_insert_bs(blk, format, &error_abort);
+    attach_detach_expect(&ad, (Notification[]){
+        (Notification){NOTIFY_ATTACH, format},
+        {},
+    });
+
+    /* Replace format -> file with file2 */
+    blk_replace_bs(blk, file2, &error_abort);
+    attach_detach_expect(&ad, (Notification[]){
+        (Notification){NOTIFY_DETACH, format},
+        (Notification){NOTIFY_ATTACH, file2},
+        {},
+    });
+
+    /* Remove file2 */
+    blk_remove_bs(blk);
+    attach_detach_expect(&ad, (Notification[]){
+        (Notification){NOTIFY_DETACH, file2},
+        {},
+    });
+
+    /* These BDSes were unrefed so we need new instances */
+    file = bdrv_new_open_driver(&bdrv_test, "file", BDRV_O_RDWR, &error_abort);
+    file2 = bdrv_new_open_driver(&bdrv_test, "file2", BDRV_O_RDWR,
+                                 &error_abort);
+
+    /* Replace a non-root node */
+    bdrv_graph_wrlock_drained();
+    bdrv_attach_child(format, file, "file", &child_of_bds,
+                      BDRV_CHILD_PRIMARY | BDRV_CHILD_DATA, &error_abort);
+    bdrv_replace_node(file, file2, &error_abort);
+    bdrv_graph_wrunlock();
+    attach_detach_expect(&ad, (Notification[]){
+        (Notification){NOTIFY_ATTACH, file},
+        (Notification){NOTIFY_DETACH, file},
+        (Notification){NOTIFY_ATTACH, file2},
+        {},
+    });
+
+    attach_detach_cleanup(&ad);
+    blk_unref(blk);
+    bdrv_unref(format);
+}
+
 int main(int argc, char **argv)
 {
     bdrv_init();
@@ -80,6 +242,8 @@ int main(int argc, char **argv)
     g_test_add_func("/block-backend/drain_aio_error", test_drain_aio_error);
     g_test_add_func("/block-backend/drain_all_aio_error",
                     test_drain_all_aio_error);
+    g_test_add_func("/block-backend/attach_detach_notifier",
+                    test_attach_detach_notifier);
 
     return g_test_run();
 }
-- 
2.51.0


