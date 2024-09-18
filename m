Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 652A6CCD1B3
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2024 14:25:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqvcS-0001xV-76; Wed, 18 Sep 2024 10:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqvcP-0001wf-Ab
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:25:21 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@treblig.org>) id 1sqvcN-000665-5O
 for qemu-devel@nongnu.org; Wed, 18 Sep 2024 10:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
 :Subject; bh=zzKoXLNSbgT4ekD+Si/uyzQ7GGkoBXyqSY4TRsOQpd8=; b=bhSZkq1JHVjwNc8O
 M7IgIhaIR4qI9dpmw0CivUD0FE9c125g5oPypOv8NfhXU71o32789Kj1yx0rqjHCsrAwXauPX/wPI
 onrUQ6MDzArL4+mhi3jgpWu1vr7Cggepem6Ge0nQtDGfgpHo9ZXTY39teGhaOQMJcGIsWMIn6uT4z
 j/+kAdIwkru6NkOTCscEMfnwSIpNw0wgQOx3GkDeXOOqv75oL9Vw6DAqTFmJGroWDm8By8ibLq72G
 w0QLPFZHz7Co6tJbGNRJdiTnzPIs0pPelx+b8ZayEnjIHkBkPWa6trxdJQTOvjRD0sV+sWHcbtOmS
 0q1gsLB/MKrJuwG1kA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
 by mx.treblig.org with esmtp (Exim 4.96)
 (envelope-from <dave@treblig.org>) id 1sqvcK-006Ixf-1N;
 Wed, 18 Sep 2024 14:25:16 +0000
From: dave@treblig.org
To: peterx@redhat.com
Cc: qemu-devel@nongnu.org,
	"Dr. David Alan Gilbert" <dave@treblig.org>
Subject: [PATCH] util/iova-tree: Remove deadcode
Date: Wed, 18 Sep 2024 15:25:15 +0100
Message-ID: <20240918142515.153074-1-dave@treblig.org>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dave@treblig.org;
 helo=mx.treblig.org
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

iova_tree_find_address, and iova_tree_foreach have never been
used since the code was originally added by:
  eecf5eedbd ("util: implement simple iova tree")

Remove them.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
---
 include/qemu/iova-tree.h | 25 -------------------------
 util/iova-tree.c         | 23 -----------------------
 2 files changed, 48 deletions(-)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 2a10a7052e..44a45931d5 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -111,31 +111,6 @@ const DMAMap *iova_tree_find(const IOVATree *tree, const DMAMap *map);
  */
 const DMAMap *iova_tree_find_iova(const IOVATree *tree, const DMAMap *map);
 
-/**
- * iova_tree_find_address:
- *
- * @tree: the iova tree to search from
- * @iova: the iova address to find
- *
- * Similar to iova_tree_find(), but it tries to find mapping with
- * range iova=iova & size=0.
- *
- * Return: same as iova_tree_find().
- */
-const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova);
-
-/**
- * iova_tree_foreach:
- *
- * @tree: the iova tree to iterate on
- * @iterator: the iterator for the mappings, return true to stop
- *
- * Iterate over the iova tree.
- *
- * Return: 1 if found any overlap, 0 if not, <0 if error.
- */
-void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator);
-
 /**
  * iova_tree_alloc_map:
  *
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 536789797e..06295e2755 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -115,13 +115,6 @@ const DMAMap *iova_tree_find_iova(const IOVATree *tree, const DMAMap *map)
     return args.result;
 }
 
-const DMAMap *iova_tree_find_address(const IOVATree *tree, hwaddr iova)
-{
-    const DMAMap map = { .iova = iova, .size = 0 };
-
-    return iova_tree_find(tree, &map);
-}
-
 static inline void iova_tree_insert_internal(GTree *gtree, DMAMap *range)
 {
     /* Key and value are sharing the same range data */
@@ -148,22 +141,6 @@ int iova_tree_insert(IOVATree *tree, const DMAMap *map)
     return IOVA_OK;
 }
 
-static gboolean iova_tree_traverse(gpointer key, gpointer value,
-                                gpointer data)
-{
-    iova_tree_iterator iterator = data;
-    DMAMap *map = key;
-
-    g_assert(key == value);
-
-    return iterator(map);
-}
-
-void iova_tree_foreach(IOVATree *tree, iova_tree_iterator iterator)
-{
-    g_tree_foreach(tree->tree, iova_tree_traverse, iterator);
-}
-
 void iova_tree_remove(IOVATree *tree, DMAMap map)
 {
     const DMAMap *overlap;
-- 
2.46.0


