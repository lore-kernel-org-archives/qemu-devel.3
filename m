Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A35EC48BF6
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Mar 2024 07:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rggRv-0001ny-Rd; Sun, 03 Mar 2024 02:39:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRv-0001nO-3X; Sun, 03 Mar 2024 02:39:55 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rggRt-0001lJ-7j; Sun, 03 Mar 2024 02:39:54 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3632752758;
 Sun,  3 Mar 2024 10:40:18 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id D239D8E84D;
 Sun,  3 Mar 2024 10:39:34 +0300 (MSK)
Received: (nullmailer pid 1350610 invoked by uid 1000);
 Sun, 03 Mar 2024 07:39:34 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 51/54] test-vmstate: fix bad GTree usage,
 use-after-free
Date: Sun,  3 Mar 2024 10:39:30 +0300
Message-Id: <20240303073934.1350568-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240303092734@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Eric Auger <eric.auger@redhat.com>

According to g_tree_foreach() documentation:
"The tree may not be modified while iterating over it (you can't
add/remove items)."

compare_trees()/diff_tree() fail to respect this rule.
Historically GLib2 used a slice allocator for the GTree APIs
which did not immediately release the memory back to the system
allocator. As a result QEMU's use-after-free bug was not visible.
With GLib > 2.75.3 however, GLib2 has switched to using malloc
and now a SIGSEGV can be observed while running test-vmstate.

Get rid of the node removal within the tree traversal. Also
check the trees have the same number of nodes before the actual
diff.

Fixes: 9a85e4b8f6 ("migration: Support gtree migration")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1518
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reported-by: Richard W.M. Jones <rjones@redhat.com>
Tested-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
(cherry picked from commit abe2c4bdb65e8dd9cb2f01c355baa394bf49a8af)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/tests/unit/test-vmstate.c b/tests/unit/test-vmstate.c
index 541bb4f63e..aae32bbf91 100644
--- a/tests/unit/test-vmstate.c
+++ b/tests/unit/test-vmstate.c
@@ -1074,7 +1074,6 @@ static gboolean diff_tree(gpointer key, gpointer value, gpointer data)
     struct match_node_data d = {tp->tree2, key, value};
 
     g_tree_foreach(tp->tree2, tp->match_node, &d);
-    g_tree_remove(tp->tree1, key);
     return false;
 }
 
@@ -1083,9 +1082,9 @@ static void compare_trees(GTree *tree1, GTree *tree2,
 {
     struct tree_cmp_data tp = {tree1, tree2, function};
 
+    assert(g_tree_nnodes(tree1) == g_tree_nnodes(tree2));
     g_tree_foreach(tree1, diff_tree, &tp);
-    assert(g_tree_nnodes(tree1) == 0);
-    assert(g_tree_nnodes(tree2) == 0);
+    g_tree_destroy(g_tree_ref(tree1));
 }
 
 static void diff_domain(TestGTreeDomain *d1, TestGTreeDomain *d2)
-- 
2.39.2


