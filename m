Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052EBD68B33
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 16:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBcHt-0004uV-35; Thu, 14 Nov 2024 11:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHp-0004tr-FZ
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:37 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBcHn-0002Av-5x
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 11:01:36 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7206304f93aso657607b3a.0
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 08:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731600093; x=1732204893; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gGugcia7xIHYiO2oiJjHlSRtV4JGvYxNcTYF4XQ4e4A=;
 b=CArrUWp3kCgUI0dpBxSBIZw8za/+WIEJFor9gLCw5ho5Glxra1/xJu2CUqSR/0WOR4
 YTjsvwEPeiijbAtq/Ew9kWQh4MuDeWVuBvvoQtMNXv/SKAVskHDn2yM3AnI4PmuEkN1H
 n9t70VFQBhlNXajOFjH6JDtN5/E3mHE875EYOP4AVpyE2oQP27dfmdSOP9wL9gFhyKqT
 NIYJQ8ivK/GVkdKaVtL38JzzOtcAaJ8Ib/CiDGOEa1sJQOf1Aq554dMvoQ19GkyqQC8F
 BadIEj6tyDu1r2yJvEEpjDpy7SVWwFysVgjPA8H3YjCMKaZ1Bda3Hj82DozCOEnFr7et
 Qhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731600093; x=1732204893;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gGugcia7xIHYiO2oiJjHlSRtV4JGvYxNcTYF4XQ4e4A=;
 b=B4hrMj03hHh9CeSFfKOC8NMvD90HTCZfoE4YaAHh4ciurt7ls6dEBs+9Az/umAWBi2
 jN3QnqTZ7Q5b7vKZDV7vzXgwvqDNE3afROTS2p+eFf5YWXLd+58mhmbMOdPmkbIfKoFS
 Ab43I24/ZZSlUu2I/nqlNV55T5hNehaPq7aBYwwIPSwQQ0lYv/xjwpW0sJAjH01h26g8
 7/S1p0UkJh/1pKMemQ5yLJflLfLAtjuJR5jyQCca2j+f9MBWDzW4dxTVp3eTIA8KGEXg
 XzedLAb2iab1U5zEl6HecVAEdbIBFJOISZMGSVKGB1EjxvDYKmZx+ndrEepqthjv6UkU
 oj3g==
X-Gm-Message-State: AOJu0YygJvhLE8u5ZYeikgVcsTXFOxyvr/Vn5G5PmgYNaSZ+cN8uKUOj
 WK8G9YxryV5o/cWpTyY04MEtJvzeTEYILC7zu4go3fracoLgdf9jfIQqXLLhKHJ8gqwzYc87DX9
 f
X-Google-Smtp-Source: AGHT+IEU0J+mWXRFECjKORFcPUCCkpmyiemTjYiQwKr6HpM7dRdd+H8jcIT/5H2by5bJyEsnm5rMog==
X-Received: by 2002:a17:90b:1d81:b0:2e2:b41b:854e with SMTP id
 98e67ed59e1d1-2ea0631e509mr3129501a91.20.1731600093063; 
 Thu, 14 Nov 2024 08:01:33 -0800 (PST)
Received: from stoup.. ([71.212.136.242]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea024ec723sm1484438a91.46.2024.11.14.08.01.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 08:01:32 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 01/54] util/interval-tree: Introduce
 interval_tree_free_nodes
Date: Thu, 14 Nov 2024 08:00:37 -0800
Message-ID: <20241114160131.48616-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241114160131.48616-1-richard.henderson@linaro.org>
References: <20241114160131.48616-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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


