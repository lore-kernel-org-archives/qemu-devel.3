Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C5A0C30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMREA-0006KM-TD; Wed, 26 Jun 2024 07:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMRE8-0006Io-Km; Wed, 26 Jun 2024 07:54:16 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMRE6-0007I7-39; Wed, 26 Jun 2024 07:54:16 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7582A60DF8;
 Wed, 26 Jun 2024 14:54:12 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id prOe6Z0rMmI0-MJCzt2oG; Wed, 26 Jun 2024 14:54:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719402852;
 bh=qvWYqS4f2DNusvrY+jo8XyNuToSaQtroc57GXqvMQw8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=n0BMhm/yJ74iLHjocigXeMvme2zmvARNuQVk7um02dpVTlJ4mLCfprYFlm2pUoRW/
 7c/VZOkKRR04elKp15TOYhAU1WeGzKl9M80PmQTrtwfT5imphIfcNyCm8R7c5Tbdi1
 AubIatTAn0kWvuy9ABjEOgA/b9yg7elmuFE3hnHc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v9 6/7] iotests.py: introduce VM.assert_edges_list() method
Date: Wed, 26 Jun 2024 14:53:49 +0300
Message-Id: <20240626115350.405778-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626115350.405778-1-vsementsov@yandex-team.ru>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Add an alternative method to check block graph, to be used in further
commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 tests/qemu-iotests/iotests.py | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index ea48af4a7b..8a5fd01eac 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -1108,6 +1108,23 @@ def check_bitmap_status(self, node_name, bitmap_name, fields):
 
         return fields.items() <= ret.items()
 
+    def get_block_graph(self):
+        """
+        Returns block graph in form of edges list, where each edge is a tuple:
+          (parent_node_name, child_name, child_node_name)
+        """
+        graph = self.qmp('x-debug-query-block-graph')['return']
+
+        nodes = {n['id']: n['name'] for n in graph['nodes']}
+        # Check that all names are unique:
+        assert len(set(nodes.values())) == len(nodes)
+
+        return [(nodes[e['parent']], e['name'], nodes[e['child']])
+                for e in graph['edges']]
+
+    def assert_edges_list(self, edges):
+        assert sorted(edges) == sorted(self.get_block_graph())
+
     def assert_block_path(self, root, path, expected_node, graph=None):
         """
         Check whether the node under the given path in the block graph
-- 
2.34.1


