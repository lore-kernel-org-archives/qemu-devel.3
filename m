Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE24C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 18:22:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkSDs-0006Dn-8I; Tue, 18 Feb 2025 13:21:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDJ-0005z7-CO
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:21:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tkSDH-0007b7-NY
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 13:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739902854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL6MhAWrd4tLPqhBzrw0oeGzfhv+jDg7uLxyhTF7330=;
 b=DJQAKWVBsscJML9PETeBnFMxY1qes+f+T6U7wFI+/Hcypux1iX78maNbUlqdUniToNW8uT
 jJVasFvFhKvuNE9L+OOptBWm2qyDAEnagtrcm3WjhYArsZRxdnGZVnIkD/kesCywSh1jQa
 LKknDa8Iogxd4eUqmPYA+lkWaM+1+G4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-6O4hdOprNFaAE-NCmWYf-Q-1; Tue,
 18 Feb 2025 13:20:51 -0500
X-MC-Unique: 6O4hdOprNFaAE-NCmWYf-Q-1
X-Mimecast-MFC-AGG-ID: 6O4hdOprNFaAE-NCmWYf-Q_1739902850
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 063021801A24; Tue, 18 Feb 2025 18:20:50 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.45.226.66])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7BADD180034D; Tue, 18 Feb 2025 18:20:47 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 manos.pitsidianakis@linaro.org, philmd@linaro.org, qemu-devel@nongnu.org,
 qemu-rust@nongnu.org
Subject: [PATCH v2 07/11] block: Add bdrv_open_blockdev_ref_file()
Date: Tue, 18 Feb 2025 19:20:15 +0100
Message-ID: <20250218182019.111467-8-kwolf@redhat.com>
In-Reply-To: <20250218182019.111467-1-kwolf@redhat.com>
References: <20250218182019.111467-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is the equivalent of bdrv_open_file_child() to be used in cases
where the caller is QAPI based and has a BlockdevRef rather than a
filename and an options QDict.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-global-state.h |  4 ++++
 block.c                            | 31 +++++++++++++++++++++++++++---
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index 9be34b3c99..861e19cfe6 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -100,6 +100,10 @@ bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 BlockDriverState * coroutine_fn no_co_wrapper
 bdrv_co_open_blockdev_ref(BlockdevRef *ref, Error **errp);
 
+BlockDriverState * no_coroutine_fn
+bdrv_open_blockdev_ref_file(BlockdevRef *ref, BlockDriverState *parent,
+                            Error **errp);
+
 int bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                         Error **errp);
 int GRAPH_WRLOCK
diff --git a/block.c b/block.c
index 0ece805e41..cd53c84f84 100644
--- a/block.c
+++ b/block.c
@@ -3847,7 +3847,11 @@ int bdrv_open_file_child(const char *filename,
  * TODO Future callers may need to specify parent/child_class in order for
  * option inheritance to work. Existing callers use it for the root node.
  */
-BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
+static BlockDriverState * no_coroutine_fn
+bdrv_open_blockdev_ref_common(BlockdevRef *ref, BlockDriverState *parent,
+                              const BdrvChildClass *child_class,
+                              BdrvChildRole child_role, bool parse_filename,
+                              Error **errp)
 {
     BlockDriverState *bs = NULL;
     QObject *obj = NULL;
@@ -3880,14 +3884,35 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 
     }
 
-    bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, 0, false,
-                           errp);
+    bs = bdrv_open_inherit(NULL, reference, qdict, 0, parent, child_class,
+                           child_role, parse_filename, errp);
     obj = NULL;
     qobject_unref(obj);
     visit_free(v);
     return bs;
 }
 
+BlockDriverState *bdrv_open_blockdev_ref_file(BlockdevRef *ref,
+                                              BlockDriverState *parent,
+                                              Error **errp)
+{
+    BdrvChildRole role;
+
+    /* commit_top and mirror_top don't use this function */
+    assert(!parent->drv->filtered_child_is_backing);
+    role = parent->drv->is_filter
+           ? (BDRV_CHILD_FILTERED | BDRV_CHILD_PRIMARY)
+           : BDRV_CHILD_IMAGE;
+
+    return bdrv_open_blockdev_ref_common(ref, parent, &child_of_bds, role,
+                                         true, errp);
+}
+
+BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
+{
+    return bdrv_open_blockdev_ref_common(ref, NULL, NULL, 0, false, errp);
+}
+
 static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
                                                    int flags,
                                                    QDict *snapshot_options,
-- 
2.48.1


