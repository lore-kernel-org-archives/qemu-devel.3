Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC107C83013
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwdP-0005PP-DO; Wed, 02 Jul 2025 08:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWwdN-0005OF-Nc; Wed, 02 Jul 2025 08:32:17 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWwdL-0000RR-SJ; Wed, 02 Jul 2025 08:32:17 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7035747550;
 Wed,  2 Jul 2025 14:32:10 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH v3 2/2] block/qapi: make @node-name in @BlockDeviceInfo
 non-optional
Date: Wed,  2 Jul 2025 14:31:28 +0200
Message-ID: <20250702123204.325470-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702123204.325470-1-f.ebner@proxmox.com>
References: <20250702123204.325470-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Since commit 15489c769b ("block: auto-generated node-names"), if the
node name of a block driver state is not explicitly specified, it
will be auto-generated.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

New in v3.

 block/qapi.c         | 4 +---
 qapi/block-core.json | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index e08a1e970f..12fbf8d1b7 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -75,9 +75,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         .no_flush       = !!(bs->open_flags & BDRV_O_NO_FLUSH),
     };
 
-    if (bs->node_name[0]) {
-        info->node_name = g_strdup(bs->node_name);
-    }
+    info->node_name = g_strdup(bs->node_name);
 
     children_list_tail = &info->children;
     QLIST_FOREACH(child, &bs->children, next) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 3e720af5ad..9d36927fc1 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -573,7 +573,7 @@
 # Since: 0.14
 ##
 { 'struct': 'BlockDeviceInfo',
-  'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str',
+  'data': { 'file': 'str', 'node-name': 'str', 'ro': 'bool', 'drv': 'str',
             '*backing_file': 'str', 'backing_file_depth': 'int',
             'children': ['BlockdevChild'],
             'active': 'bool', 'encrypted': 'bool',
-- 
2.47.2



