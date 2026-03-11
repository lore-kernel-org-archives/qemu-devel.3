Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE15A104951A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0GOK-0005u3-RI; Wed, 11 Mar 2026 06:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luzhipeng@cestc.cn>)
 id 1w0GOB-0005tb-Ci
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:02:05 -0400
Received: from smtp-pop-umt-2.cecloud.com ([1.203.97.240]
 helo=smtp.cecloud.com) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luzhipeng@cestc.cn>) id 1w0GO1-0001dO-CZ
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 06:01:59 -0400
Received: from localhost (localhost [127.0.0.1])
 by smtp.cecloud.com (Postfix) with ESMTP id 39BF1900113;
 Wed, 11 Mar 2026 18:01:40 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from localhost.localdomain
 (131.25.209.222.broad.cd.sc.dynamic.163data.com.cn [222.209.25.131])
 by smtp.cecloud.com (postfix) whith ESMTP id
 P123638T281464759185776S1773223295647935_; 
 Wed, 11 Mar 2026 18:01:38 +0800 (CST)
X-RL-SENDER: luzhipeng@cestc.cn
X-SENDER: luzhipeng@cestc.cn
X-LOGIN-NAME: luzhipeng@cestc.cn
X-FST-TO: qemu-devel@nongnu.org
X-RCPT-COUNT: 6
X-LOCAL-RCPT-COUNT: 1
X-MUTI-DOMAIN-COUNT: 0
X-SENDER-IP: 222.209.25.131
X-ATTACHMENT-NUM: 0
X-UNIQUE-TAG: <3ee74330ccb3472224cd4e60e00f8ac7>
X-System-Flag: 0
From: luzhipeng <luzhipeng@cestc.cn>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 luzhipeng <luzhipeng@cestc.cn>
Subject: [PATCH] qmp: Add ram-block-set/get-migratable commands
Date: Wed, 11 Mar 2026 18:01:16 +0800
Message-ID: <20260311100116.984-1-luzhipeng@cestc.cn>
X-Mailer: git-send-email 2.45.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=1.203.97.240; envelope-from=luzhipeng@cestc.cn;
 helo=smtp.cecloud.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce two new QMP commands to manage RAMBlock migratable state:
1. ram-block-set-migratable: Dynamically set a RAMBlock's migratable state
2. ram-block-get-migratable: Query a RAMBlock's migratable state

Signed-off-by: luzhipeng <luzhipeng@cestc.cn>
---
 migration/ram.c     | 48 +++++++++++++++++++++++++++++++++++++++++++++
 qapi/migration.json | 39 ++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index 979751f61b..8b4fd8226d 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -234,6 +234,54 @@ bool migrate_ram_is_ignored(RAMBlock *block)
                                     && qemu_ram_is_named_file(block));
 }
 
+void qmp_ram_block_set_migratable(const char *name,
+                                  bool migratable, Error **errp)
+{
+    RAMBlock *rb = qemu_ram_block_by_name(name);
+    if (!rb) {
+        error_setg(errp, "RAMBlock '%s' not found", name);
+        return;
+    }
+
+    if (migration_is_running()) {
+        error_setg(errp, "Cannot modify RAMBlock migratable state
+                   during migration");
+        return;
+    }
+
+    if (migratable) {
+        qemu_ram_set_migratable(rb);
+        info_report("RAMBlock '%s' marked as migratable", name);
+    } else {
+        qemu_ram_unset_migratable(rb);
+        info_report("RAMBlock '%s' marked as non-migratable", name);
+    }
+}
+
+/**
+ * qmp_ram_block_get_migratable:
+ * @name: Name of RAMBlock to query
+ * @errp: Error object
+ *
+ * Return: RamBlockMigratableInfo
+ */
+RamBlockMigratableInfo *qmp_ram_block_get_migratable(const char *name,
+                                                     Error **errp)
+{
+    RAMBlock *rb;
+    RamBlockMigratableInfo *info = g_new0(RamBlockMigratableInfo, 1);
+    rb = qemu_ram_block_by_name(name);
+    if (!rb) {
+        g_free(info);
+        error_setg(errp, "RAMBlock '%s' not found", name);
+        return NULL;
+    }
+    info->migratable = qemu_ram_is_migratable(rb);
+    info_report("RAMBlock '%s' migratable state: %s", name,
+                 info->migratable ? "true" : "false");
+    return info;
+}
+
 #undef RAMBLOCK_FOREACH
 
 int foreach_not_ignored_block(RAMBlockIterFunc func, void *opaque)
diff --git a/qapi/migration.json b/qapi/migration.json
index 7134d4ce47..483116db49 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -2233,3 +2233,42 @@
   'data': { 'job-id': 'str',
             'tag': 'str',
             'devices': ['str'] } }
+
+##
+# @ram-block-set-migratable:
+#
+# Set the migratable state of a specific RAMBlock.
+#
+# @name: Name of the RAMBlock to modify
+# @migratable: true to enable migration for the RAMBlock,
+# false to disable
+#
+# Since: 11.1
+##
+{ 'command': 'ram-block-set-migratable',
+  'data': { 'name': 'str', 'migratable': 'bool' } }
+
+##
+# @RamBlockMigratableInfo:
+#
+# Information about a RAMBlock's migratable state
+#
+# @migratable: true if the RAMBlock is migratable, false otherwise
+#
+# Since: 11.1
+##
+{ 'struct': 'RamBlockMigratableInfo', 'data': { 'migratable': 'bool' } }
+
+##
+# @ram-block-get-migratable:
+#
+# Get the migratable state of a specific RAMBlock.
+#
+# @name: Name of the RAMBlock to query
+#
+# Returns: RamBlockMigratableInfo containing the migratable state
+#
+# Since: 11.1
+##
+{ 'command': 'ram-block-get-migratable', 'data': { 'name': 'str' },
+                                         'returns': 'RamBlockMigratableInfo' }
-- 
2.31.1




