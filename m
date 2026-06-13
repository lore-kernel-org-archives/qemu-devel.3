Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C035CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV9Q-000140-A7; Sat, 13 Jun 2026 16:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9K-0000t5-Kv; Sat, 13 Jun 2026 16:40:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9I-0004VE-S5; Sat, 13 Jun 2026 16:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=hruUjaXdQAdvaQCyFc5bpqH3UnncxRCYx7iu6J++zHc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y5YW5ldHpqSeEQOe+ZJ7iHwYHBIMWamDxy37xHqCFBmReB2Y//O6pq5/oJxnGV7Cc
 0NUYzKIE2JXYsZ77YFTq3GHuMd7ujwqa50W1ae3N5mIAx1R4BVXQnXYZSM/yerQGHJ
 Vxxsg1Yfs5sARtQ8xI0MexeqXOtZiSF8nlw02jRwswJ54+8IWWrIDqM4O8x2RJyFFR
 ZZde7v3aptbzAUk2VnYNN60E+FMjRzJxduTy8L/Am8qGteCf5TxDPEDk8gwZdKQaUf
 UCQIUAtnOq7rVmr61i0N97ekk8t38cholkllTBeya8NS84QucIW0TCHmrud4P2rO4X
 wNnpIhOFINFzg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2D6201B6F08;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9856B3CE958;
 Sat, 13 Jun 2026 23:36:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 44/72] hw/9pfs: change V9fsPath.size to size_t and
 v9fs_path_sprintf() return type
Date: Sat, 13 Jun 2026 23:35:10 +0300
Message-ID: <20260613203542.1809153-44-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

- Change V9fsPath.size from uint16_t to size_t to support paths larger
  than 65536 bytes.

- Change v9fs_path_sprintf() return type from void to int to allow error
  reporting.

Link: https://lore.kernel.org/qemu-devel/2d2348d94ff43fbe4cc0aea24fb312c5c15ee809.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit dbaf84e148b0c8b66dcb47788a6bb13806e401e4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/fsdev/file-op-9p.h b/fsdev/file-op-9p.h
index b85c9934de..e8d0661c4b 100644
--- a/fsdev/file-op-9p.h
+++ b/fsdev/file-op-9p.h
@@ -112,7 +112,7 @@ struct FsContext {
 };
 
 struct V9fsPath {
-    uint16_t size;
+    size_t size;
     char *data;
 };
 P9ARRAY_DECLARE_TYPE(V9fsPath);
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e590c414ab..88894ec9d2 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -203,16 +203,24 @@ void v9fs_path_free(V9fsPath *path)
 }
 
 
-void v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
+int v9fs_path_sprintf(V9fsPath *path, const char *fmt, ...)
 {
     va_list ap;
+    int ret;
 
     v9fs_path_free(path);
 
     va_start(ap, fmt);
-    /* Bump the size for including terminating NULL */
-    path->size = g_vasprintf(&path->data, fmt, ap) + 1;
+    ret = g_vasprintf(&path->data, fmt, ap);
     va_end(ap);
+    if (ret < 0) {
+        error_report_once("9pfs: unusual path formatting failure; "
+                         "invalidating associated FID");
+        return -1;
+    }
+    /* Bump the size for including terminating NULL */
+    path->size = ret + 1;
+    return 0;
 }
 
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src)
diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 65cc45e344..b2df659b0e 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -456,8 +456,8 @@ static inline uint8_t v9fs_request_cancelled(V9fsPDU *pdu)
 void coroutine_fn v9fs_reclaim_fd(V9fsPDU *pdu);
 void v9fs_path_init(V9fsPath *path);
 void v9fs_path_free(V9fsPath *path);
-void G_GNUC_PRINTF(2, 3) v9fs_path_sprintf(V9fsPath *path, const char *fmt,
-                                           ...);
+int G_GNUC_PRINTF(2, 3) v9fs_path_sprintf(V9fsPath *path, const char *fmt,
+                                          ...);
 void v9fs_path_copy(V9fsPath *dst, const V9fsPath *src);
 size_t v9fs_readdir_response_size(V9fsString *name);
 int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
-- 
2.47.3


