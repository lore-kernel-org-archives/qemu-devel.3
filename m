Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55224CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 18:36:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6CXJ-000631-Ib; Tue, 07 Oct 2025 14:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6CWe-0005ie-7Q
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:35:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1v6CWb-0002e0-R7
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 14:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759862100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pJXNRnHEOV8SoZ+YBFNRT9lJhGALX9mzhYDz9HUAN9I=;
 b=g2LIpOlsCGD6MmJN8H3b80di3BCvFshdEvZ9z9YEymQV4JOMMOFeps+bmpOPyeQU2T/jkT
 NcWnNXpmFxfyaZTQVgFJWb1U+Itoz1g6BXXPUpn4zpbFrEHOD+LX6XSYhTQHomegxuka14
 aRRnhutbbV4EXw2CqCTKvOe8BnNHS5E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-280-yurKvxbuPCmU1ftsN_1JHA-1; Tue,
 07 Oct 2025 14:34:58 -0400
X-MC-Unique: yurKvxbuPCmU1ftsN_1JHA-1
X-Mimecast-MFC-AGG-ID: yurKvxbuPCmU1ftsN_1JHA_1759862097
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A711800366; Tue,  7 Oct 2025 18:34:57 +0000 (UTC)
Received: from localhost (unknown [10.2.16.87])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3BD818004D8; Tue,  7 Oct 2025 18:34:56 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 3/5] block: rename RAMBlockRegistrar->notifier field
Date: Tue,  7 Oct 2025 14:34:45 -0400
Message-ID: <20251007183447.93120-4-stefanha@redhat.com>
In-Reply-To: <20251007183447.93120-1-stefanha@redhat.com>
References: <20251007183447.93120-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The 'notifier' field name will be confusing when the BlockBackend attach
and detach notifiers are added in the next commit. Rename the field so
it's clear that this is the RAMBlock notifier.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 include/system/block-ram-registrar.h |  2 +-
 block/block-ram-registrar.c          | 14 ++++++++------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/system/block-ram-registrar.h b/include/system/block-ram-registrar.h
index d8b2f7942b..76c157bd54 100644
--- a/include/system/block-ram-registrar.h
+++ b/include/system/block-ram-registrar.h
@@ -21,7 +21,7 @@
  */
 typedef struct {
     BlockBackend *blk;
-    RAMBlockNotifier notifier;
+    RAMBlockNotifier ram_block_notifier;
     bool ok;
 } BlockRAMRegistrar;
 
diff --git a/block/block-ram-registrar.c b/block/block-ram-registrar.c
index fcda2b86af..d5b84667a1 100644
--- a/block/block-ram-registrar.c
+++ b/block/block-ram-registrar.c
@@ -12,7 +12,8 @@
 static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
                             size_t max_size)
 {
-    BlockRAMRegistrar *r = container_of(n, BlockRAMRegistrar, notifier);
+    BlockRAMRegistrar *r =
+        container_of(n, BlockRAMRegistrar, ram_block_notifier);
     Error *err = NULL;
 
     if (!r->ok) {
@@ -21,7 +22,7 @@ static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
 
     if (!blk_register_buf(r->blk, host, max_size, &err)) {
         error_report_err(err);
-        ram_block_notifier_remove(&r->notifier);
+        ram_block_notifier_remove(n);
         r->ok = false;
     }
 }
@@ -29,14 +30,15 @@ static void ram_block_added(RAMBlockNotifier *n, void *host, size_t size,
 static void ram_block_removed(RAMBlockNotifier *n, void *host, size_t size,
                               size_t max_size)
 {
-    BlockRAMRegistrar *r = container_of(n, BlockRAMRegistrar, notifier);
+    BlockRAMRegistrar *r =
+        container_of(n, BlockRAMRegistrar, ram_block_notifier);
     blk_unregister_buf(r->blk, host, max_size);
 }
 
 void blk_ram_registrar_init(BlockRAMRegistrar *r, BlockBackend *blk)
 {
     r->blk = blk;
-    r->notifier = (RAMBlockNotifier){
+    r->ram_block_notifier = (RAMBlockNotifier){
         .ram_block_added = ram_block_added,
         .ram_block_removed = ram_block_removed,
 
@@ -47,12 +49,12 @@ void blk_ram_registrar_init(BlockRAMRegistrar *r, BlockBackend *blk)
     };
     r->ok = true;
 
-    ram_block_notifier_add(&r->notifier);
+    ram_block_notifier_add(&r->ram_block_notifier);
 }
 
 void blk_ram_registrar_destroy(BlockRAMRegistrar *r)
 {
     if (r->ok) {
-        ram_block_notifier_remove(&r->notifier);
+        ram_block_notifier_remove(&r->ram_block_notifier);
     }
 }
-- 
2.51.0


