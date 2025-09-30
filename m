Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9D9CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 20:48:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3hF1-0000X2-A4; Tue, 30 Sep 2025 16:46:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEy-0000Sv-05
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v3hEn-0004Gk-Sv
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 16:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759265171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WBqk0CwZK1zHhdhWy93OSfCtnksmdkNPmtF5Z3YJ+50=;
 b=UBic/GCW6ph4prMVKSjF9aZwD+v0oEiKIIyFbdWpXkMYSeT+ziinzyGgeR5yMCH3Zav8K5
 5PQ/datchpYeHYZ/tLIR6iZn/lGEl1QNflKivJkWdVbpEm3twQw5ukgvGvznjiw+Dxknqj
 X1Y2UHIsp5d7Y//Z8PcK0P2kCijR3o8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-669-hW_jhAo0OcO-qAfK-WjsyA-1; Tue,
 30 Sep 2025 16:46:08 -0400
X-MC-Unique: hW_jhAo0OcO-qAfK-WjsyA-1
X-Mimecast-MFC-AGG-ID: hW_jhAo0OcO-qAfK-WjsyA_1759265167
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D218180048E; Tue, 30 Sep 2025 20:46:07 +0000 (UTC)
Received: from localhost (unknown [10.2.16.110])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B80321800452; Tue, 30 Sep 2025 20:46:06 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, <qemu-block@nongnu.org>,
 Hanna Reitz <hreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Yingshun Cui <yicui@redhat.com>
Subject: [PATCH 4/4] block: update inserted/removed nodes from
 BlockRAMRegistrar
Date: Tue, 30 Sep 2025 16:45:55 -0400
Message-ID: <20250930204555.162133-5-stefanha@redhat.com>
In-Reply-To: <20250930204555.162133-1-stefanha@redhat.com>
References: <20250930204555.162133-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

BlockRAMRegistrar ensures that RAMBlocks are registered with
BlockDriverStates. This is essential for vdpa-blk because they need to
know the memory mappings of I/O buffers. However, BlockRAMRegistrar is
currently unaware of changes to the block graph and newly inserted nodes
have no RAMBlocks registered.

Use the new blk_add_attach_notifier() and blk_add_detach_notifier() APIs
to bring nodes up to speed when the graph changes. This fixes vdpa-blk
across mirror and other operations that modify the block graph.
Previously I/O would not succeed after a new node was inserted due to
missing memory mappings.

Buglink: https://issues.redhat.com/browse/RHEL-88175
Reported-by: Yingshun Cui <yicui@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/system/block-ram-registrar.h |  2 +
 block/block-ram-registrar.c          | 63 +++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/include/system/block-ram-registrar.h b/include/system/block-ram-registrar.h
index 76c157bd54..292c197d1c 100644
--- a/include/system/block-ram-registrar.h
+++ b/include/system/block-ram-registrar.h
@@ -22,6 +22,8 @@
 typedef struct {
     BlockBackend *blk;
     RAMBlockNotifier ram_block_notifier;
+    Notifier blk_attach_notifier;
+    Notifier blk_detach_notifier;
     bool ok;
 } BlockRAMRegistrar;
 
diff --git a/block/block-ram-registrar.c b/block/block-ram-registrar.c
index d5b84667a1..a46b5a723f 100644
--- a/block/block-ram-registrar.c
+++ b/block/block-ram-registrar.c
@@ -7,7 +7,9 @@
 #include "qemu/osdep.h"
 #include "system/block-backend.h"
 #include "system/block-ram-registrar.h"
+#include "system/ramblock.h"
 #include "qapi/error.h"
+#include "trace.h"
 
 static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
                             size_t max_size)
@@ -22,8 +24,8 @@ static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
 
     if (!blk_register_buf(r->blk, host, max_size, &err)) {
         error_report_err(err);
-        ram_block_notifier_remove(n);
-        r->ok = false;
+        blk_ram_registrar_destroy(r);
+        return;
     }
 }
 
@@ -35,6 +37,52 @@ static void ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
     blk_unregister_buf(r->blk, host, max_size);
 }
 
+static void blk_attached(Notifier *n, void *data)
+{
+    BlockRAMRegistrar *r =
+        container_of(n, BlockRAMRegistrar, blk_attach_notifier);
+    BlockBackendAttachDetachArgs *args = data;
+    BlockDriverState *bs = args->bs;
+    Error *err = NULL;
+
+    WITH_RCU_READ_LOCK_GUARD() {
+        RAMBlock *rb;
+
+        RAMBLOCK_FOREACH(rb) {
+            ram_addr_t max_size = qemu_ram_get_max_length(rb);
+            void *host = qemu_ram_get_host_addr(rb);
+
+            if (!bdrv_register_buf(bs, host, max_size, &err)) {
+                goto err;
+            }
+        }
+    }
+
+    return;
+
+err:
+    error_report_err(err);
+    blk_ram_registrar_destroy(r);
+}
+
+static void blk_detached(Notifier *n, void *data)
+{
+    BlockRAMRegistrar *r =
+        container_of(n, BlockRAMRegistrar, blk_attach_notifier);
+    BlockBackendAttachDetachArgs *args = data;
+    BlockDriverState *bs = args->bs;
+    RAMBlock *rb;
+
+    RCU_READ_LOCK_GUARD();
+
+    RAMBLOCK_FOREACH(rb) {
+        ram_addr_t max_size = qemu_ram_get_max_length(rb);
+        void *host = qemu_ram_get_host_addr(rb);
+
+        bdrv_unregister_buf(bs, host, max_size);
+    }
+}
+
 void blk_ram_registrar_init(BlockRAMRegistrar *r, BlockBackend *blk)
 {
     r->blk = blk;
@@ -47,14 +95,25 @@ void blk_ram_registrar_init(BlockRAMRegistrar *r, BlockBackend *blk)
          * value that does not change across resize.
          */
     };
+    r->blk_attach_notifier = (Notifier){
+        .notify = blk_attached,
+    };
+    r->blk_detach_notifier = (Notifier){
+        .notify = blk_detached,
+    };
     r->ok = true;
 
     ram_block_notifier_add(&r->ram_block_notifier);
+    blk_add_attach_notifier(blk, &r->blk_attach_notifier);
+    blk_add_detach_notifier(blk, &r->blk_detach_notifier);
 }
 
 void blk_ram_registrar_destroy(BlockRAMRegistrar *r)
 {
     if (r->ok) {
+        notifier_remove(&r->blk_detach_notifier);
+        notifier_remove(&r->blk_attach_notifier);
         ram_block_notifier_remove(&r->ram_block_notifier);
+        r->ok = false;
     }
 }
-- 
2.51.0


