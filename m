Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE64CEDDA7
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 15:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syYJI-0001LP-1c; Wed, 09 Oct 2024 11:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJC-0001JG-ND
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:02 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syYJ9-0007w3-M5
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 11:09:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-71dfc78d6ddso3666726b3a.0
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2024 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728486538; x=1729091338; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gGugcia7xIHYiO2oiJjHlSRtV4JGvYxNcTYF4XQ4e4A=;
 b=yGUhcHC+isQy/pN+U8znOlD8csXL0NThVlnORNwIZuiqKCJjTL5Mdb8cKxS6pmgVeC
 pBfXSamVxeAUI2ttvat4nwlAalR9cKqL1goEfh59K5BSkvu1uIcpVNID3VOj5jHDRQgQ
 cWNeHQyURMZi3WLvRRgnkXqgCc5sfq3HaIT3/MOZUNzAszBtIWaLU8GZxLg6f8LyhLj3
 KRaD1IIP14L1tbap1FWt9LBKRmZE0TJ+Lr7IS17LYnVsTJBXjVv6YzogeHAk4XSpv8Ec
 wxrvaYUrlwV47NRP3dmmqGn/HDx33nARC8eZIFcdVMTTdQ5wMGCf+mvgD1g2DHwSKb8a
 +mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728486538; x=1729091338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGugcia7xIHYiO2oiJjHlSRtV4JGvYxNcTYF4XQ4e4A=;
 b=vUt5zToOMihuNgnhBflFLraWqxRNKVKg85CL7b5bZXM27dbDKByaCeTMem/CRcNDsz
 WYE1Q0n5XYXBrfhEZYo+HNNpnukBFN1WZ8/jxxf8mjArAVICfWMOfyxwZkeWJt4zC0Rx
 7VLgJbsrlCxsnNqClrFGnKIVnj6ilVjnPELm2O6lWQVPT3GXE4hKdKeK7cMuAOKWwgoN
 iU81XZa7u72dSKYozcrz7pjH2s1HN6yz/tTPcchFRw3qvb2/2b+R51PLN5L7rGU45vYp
 oPVXXief3ccYqyfJS6ydp8Kw9xZv8ts8ycOhznW9/Gb6KDVCFNpakvSC4Lo8LTxdLHMc
 d9Mg==
X-Gm-Message-State: AOJu0YwjF2WeKhriAQC2fOOR4Ksa9m4NcXG936x40FNibuZd74Q1nr8N
 cE8oAVFBf3qT606HFv0nhfe+j+0YQn7QASMpBpfJ9YejvlP7R8VkKmlJV3t7UcZC7nvm+U8dIQQ
 r
X-Google-Smtp-Source: AGHT+IHTsP/44AfTBj9tBPEteHYobH5wP5qyYZEOM5DId2QpTc/CUusVD/yPrklj6PidnhzLzIG3zg==
X-Received: by 2002:a05:6a00:928a:b0:71e:104d:6316 with SMTP id
 d2e1a72fcca58-71e1dbc20c0mr4894864b3a.21.1728486538095; 
 Wed, 09 Oct 2024 08:08:58 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d65278sm7881094b3a.160.2024.10.09.08.08.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Oct 2024 08:08:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 01/23] util/interval-tree: Introduce interval_tree_free_nodes
Date: Wed,  9 Oct 2024 08:08:33 -0700
Message-ID: <20241009150855.804605-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009150855.804605-1-richard.henderson@linaro.org>
References: <20241009150855.804605-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Provide a general-purpose release-all-nodes operation, that allows
for the IntervalTreeNode to be embeded within a larger structure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/interval-tree.h | 11 +++++++++++
 util/interval-tree.c         | 20 ++++++++++++++++++++
 util/selfmap.c               | 13 +------------
 3 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/include/qemu/interval-tree.h b/include/qemu/interval-tree.h
index 25006debe8..d90ea6d17f 100644
--- a/include/qemu/interval-tree.h
+++ b/include/qemu/interval-tree.h
@@ -96,4 +96,15 @@ IntervalTreeNode *interval_tree_iter_first(IntervalTreeRoot *root,
 IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
                                           uint64_t start, uint64_t last);
 
+/**
+ * interval_tree_free_nodes:
+ * @root: root of the tree
+ * @it_offset: offset from outermost type to IntervalTreeNode
+ *
+ * Free, via g_free, all nodes under @root.  IntervalTreeNode may
+ * not be the true type of the nodes allocated; @it_offset gives
+ * the offset from the outermost type to the IntervalTreeNode member.
+ */
+void interval_tree_free_nodes(IntervalTreeRoot *root, size_t it_offset);
+
 #endif /* QEMU_INTERVAL_TREE_H */
diff --git a/util/interval-tree.c b/util/interval-tree.c
index 53465182e6..663d3ec222 100644
--- a/util/interval-tree.c
+++ b/util/interval-tree.c
@@ -639,6 +639,16 @@ static void rb_erase_augmented_cached(RBNode *node, RBRootLeftCached *root,
     rb_erase_augmented(node, &root->rb_root, augment);
 }
 
+static void rb_node_free(RBNode *rb, size_t rb_offset)
+{
+    if (rb->rb_left) {
+        rb_node_free(rb->rb_left, rb_offset);
+    }
+    if (rb->rb_right) {
+        rb_node_free(rb->rb_right, rb_offset);
+    }
+    g_free((void *)rb - rb_offset);
+}
 
 /*
  * Interval trees.
@@ -870,6 +880,16 @@ IntervalTreeNode *interval_tree_iter_next(IntervalTreeNode *node,
     }
 }
 
+void interval_tree_free_nodes(IntervalTreeRoot *root, size_t it_offset)
+{
+    if (root && root->rb_root.rb_node) {
+        rb_node_free(root->rb_root.rb_node,
+                     it_offset + offsetof(IntervalTreeNode, rb));
+        root->rb_root.rb_node = NULL;
+        root->rb_leftmost = NULL;
+    }
+}
+
 /* Occasionally useful for calling from within the debugger. */
 #if 0
 static void debug_interval_tree_int(IntervalTreeNode *node,
diff --git a/util/selfmap.c b/util/selfmap.c
index 483cb617e2..d2b86da301 100644
--- a/util/selfmap.c
+++ b/util/selfmap.c
@@ -87,23 +87,12 @@ IntervalTreeRoot *read_self_maps(void)
  * @root: an interval tree
  *
  * Free a tree of MapInfo structures.
- * Since we allocated each MapInfo in one chunk, we need not consider the
- * contents and can simply free each RBNode.
  */
 
-static void free_rbnode(RBNode *n)
-{
-    if (n) {
-        free_rbnode(n->rb_left);
-        free_rbnode(n->rb_right);
-        g_free(n);
-    }
-}
-
 void free_self_maps(IntervalTreeRoot *root)
 {
     if (root) {
-        free_rbnode(root->rb_root.rb_node);
+        interval_tree_free_nodes(root, offsetof(MapInfo, itree));
         g_free(root);
     }
 }
-- 
2.43.0


