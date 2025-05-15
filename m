Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ACDFC3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 11:30:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFWmH-0006zW-Uh; Thu, 15 May 2025 07:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFWmF-0006yZ-QL; Thu, 15 May 2025 07:29:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uFWmD-0007Yh-5A; Thu, 15 May 2025 07:29:27 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7CD4742999;
 Thu, 15 May 2025 13:29:14 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, pl@dlhnet.de, idryomov@gmail.com
Subject: [PATCH 2/2] block/rbd: support keyring option via QAPI
Date: Thu, 15 May 2025 13:29:08 +0200
Message-Id: <20250515112908.383693-3-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250515112908.383693-1-f.ebner@proxmox.com>
References: <20250515112908.383693-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

In Proxmox VE, it is not always required to have a dedicated Ceph
configuration file, and using the 'key-secret' QAPI option would
require obtaining a key from the keyring first. The keyring location
is readily available however, so having support for the 'keyring'
configuration option is most convenient.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/rbd.c          | 8 ++++++++
 qapi/block-core.json | 5 ++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/block/rbd.c b/block/rbd.c
index 2924f23093..660224c6c8 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -306,6 +306,14 @@ static int qemu_rbd_set_key_value_pairs(rados_t cluster,
         return 0;
     }
 
+    if (key_value_pairs->keyring) {
+        int r = rados_conf_set(cluster, "keyring", key_value_pairs->keyring);
+        if (r < 0) {
+            error_setg_errno(errp, -r, "could not set 'keyring'");
+            return -EINVAL;
+        }
+    }
+
     if (key_value_pairs->has_rbd_cache_policy) {
         RbdCachePolicy value = key_value_pairs->rbd_cache_policy;
         int r = rados_conf_set(cluster, "rbd_cache_policy",
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4666765e66..3253c6e6e9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4327,12 +4327,15 @@
 #
 # Key-value pairs for Ceph configuration.
 #
+# @keyring: Ceph configuration option 'keyring'.
+#
 # @rbd-cache-policy: Ceph configuration option 'rbd_cache_policy'.
 #
 # Since 10.1
 ##
 { 'struct': 'RbdKeyValuePairs',
-  'data': { '*rbd-cache-policy': 'RbdCachePolicy' } }
+  'data': { '*keyring': 'str',
+            '*rbd-cache-policy': 'RbdCachePolicy' } }
 
 ##
 # @BlockdevOptionsRbd:
-- 
2.39.5



