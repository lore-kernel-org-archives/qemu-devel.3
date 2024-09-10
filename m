Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99941EDE99A
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 16:50:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so41n-0007LE-VE; Tue, 10 Sep 2024 12:47:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41a-0006pk-F2
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1so41V-0007YE-Hl
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 12:47:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725986840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxJ87lsjswNomZOhBoYjMc6BZ+sgw659BedRk/JNaSI=;
 b=FkWZTV1jrALP0MxpaZ/q7cuYGeDN4GMMGGY3R50fUHGdhNdMDphez/mN9rBDZsGwdbJOma
 T4qeDVU9GdnYGkBZzWMlYU5Au5UJkp+pV7sAsVk/RSxzIrBLAQtGT6IMQ5c33/OEbW2GHN
 krqcaHwNrC2LaK7n/eF/siZ6thkBwNM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-k-Go2SSZORe6qGDz1H8MBQ-1; Tue,
 10 Sep 2024 12:47:18 -0400
X-MC-Unique: k-Go2SSZORe6qGDz1H8MBQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0DB161955F2E; Tue, 10 Sep 2024 16:47:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.112])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A16493000239; Tue, 10 Sep 2024 16:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C4E121E6939; Tue, 10 Sep 2024 18:47:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 03/19] qapi/block-core: Drop temporary 'prefix'
Date: Tue, 10 Sep 2024 18:46:58 +0200
Message-ID: <20240910164714.1993531-4-armbru@redhat.com>
In-Reply-To: <20240910164714.1993531-1-armbru@redhat.com>
References: <20240910164714.1993531-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.145,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Recent commit "qapi: Smarter camel_to_upper() to reduce need for
'prefix'" added a temporary 'prefix' to delay changing the generated
code.

Revert it.  This improves XDbgBlockGraphNodeType's generated
enumeration constant prefix from
X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_BACKEND to
XDBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_BACKEND.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240904111836.3273842-4-armbru@redhat.com>
---
 qapi/block-core.json | 1 -
 block.c              | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 452047102a..a7ae2da47b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2011,7 +2011,6 @@
 # Since: 4.0
 ##
 { 'enum': 'XDbgBlockGraphNodeType',
-  'prefix': 'X_DBG_BLOCK_GRAPH_NODE_TYPE', # TODO drop
   'data': [ 'block-backend', 'block-job', 'block-driver' ] }
 
 ##
diff --git a/block.c b/block.c
index c317de9eaa..7d90007cae 100644
--- a/block.c
+++ b/block.c
@@ -6351,7 +6351,7 @@ XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
         if (!*name) {
             name = allocated_name = blk_get_attached_dev_id(blk);
         }
-        xdbg_graph_add_node(gr, blk, X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_BACKEND,
+        xdbg_graph_add_node(gr, blk, XDBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_BACKEND,
                            name);
         g_free(allocated_name);
         if (blk_root(blk)) {
@@ -6364,7 +6364,7 @@ XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
              job = block_job_next_locked(job)) {
             GSList *el;
 
-            xdbg_graph_add_node(gr, job, X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_JOB,
+            xdbg_graph_add_node(gr, job, XDBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_JOB,
                                 job->job.id);
             for (el = job->nodes; el; el = el->next) {
                 xdbg_graph_add_edge(gr, job, (BdrvChild *)el->data);
@@ -6373,7 +6373,7 @@ XDbgBlockGraph *bdrv_get_xdbg_block_graph(Error **errp)
     }
 
     QTAILQ_FOREACH(bs, &graph_bdrv_states, node_list) {
-        xdbg_graph_add_node(gr, bs, X_DBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_DRIVER,
+        xdbg_graph_add_node(gr, bs, XDBG_BLOCK_GRAPH_NODE_TYPE_BLOCK_DRIVER,
                            bs->node_name);
         QLIST_FOREACH(child, &bs->children, next) {
             xdbg_graph_add_edge(gr, bs, child);
-- 
2.46.0


