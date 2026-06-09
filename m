Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE40CD8CB9
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 14:28:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWxPA-0002hU-T5; Tue, 09 Jun 2026 10:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <46e28e8fea419cc93bdfccb6f5c4af6c86cfc25e@kylie.crudebyte.com>)
 id 1wWxOy-0002Z7-Do; Tue, 09 Jun 2026 10:26:01 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <46e28e8fea419cc93bdfccb6f5c4af6c86cfc25e@kylie.crudebyte.com>)
 id 1wWxOw-0001Lu-N0; Tue, 09 Jun 2026 10:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=xW/DPGJd1kcaXKX7UWvwp4TuiSMmM2UJikdF3Y9+z5U=; b=f07kq
 yvgGSWqGqELzWStuom9BFoDETEw6II7pJCfxSReBIRXjsvu19XMk5btsNxYf9t3ZOhHVaT/2VyPr8
 AYgi8OZ9ITFzCZ6eQ4O1frRaxPRUWKfZC0VlNyFRvk8ruLtRf9K4W0Q7ykozWhFAytRlhntpFP/ZX
 qJsyZsZCeAQVFA6DE+Tk6LYhdS/DGuinydED+0QQzYmgSWnUqeXhoNw9k5zH+NxK1NSYvQP+ilfjw
 kaPr1COFVAw5wNSVDtjIT/hrVUKxwCAG5oKa9HWqjPF7E24N5jdLDkznQFJ3Uj6kVpz2FzKzNHKb1
 GW9P3zXpgcwCv+P6quyX/1UCn1Lu4Ul48z1zPGolhNujVgplOTOD1aeL1ByWERkgpCDDg5/zcAFVg
 +TVvb2HI5SFbS9UaeNQvR0eYE1voi200+9nLN46UIQmfGVNNzlAkB5XaRc1RtM15dlbT/KXKm9JAA
 CmpzI0aljw6/JWWjz+g+Ab31WsQtaMTaZpyVLFXUeEZFMu5P3hufXkmhtmYiXbQlQnsYtq0fkl/kY
 K4A+0eaHIw9J9L+9H8CyAcs7D45cCLAGa+zaxaeTqKWXrfjE/AsBqR9lPW5ox45oi0x4SA4RfbWK2
 SBfKcQJQEzxfKIA+WHLZ9hUTf+pLoyyKc4xeK0sggkcyALg4CtkxSuplQBF57I=;
Message-ID: <46e28e8fea419cc93bdfccb6f5c4af6c86cfc25e.1781012549.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 09 Jun 2026 15:47:06 +0200
Subject: [PATCH v2 08/12] hw/9pfs: add xattr count query interface fo fs synth
 driver
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=46e28e8fea419cc93bdfccb6f5c4af6c86cfc25e@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Add a synthetic /stat/xattr_count file path that, if being read by 9p
client, returns the the 9p server internal xattr FID counter to
client.

This allows to test and verify that the xattr FID limit is being
enforced correctly.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-synth.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 4b0732e093..3b3654b282 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -565,6 +565,19 @@ static ssize_t v9fs_synth_qtest_flush_write(void *buf, int len, off_t offset,
     return 1;
 }
 
+/* transmits internal xattr counter to client */
+static ssize_t v9fs_synth_read_xattr_count(void *buf, int len, off_t offset,
+                                           void *arg)
+{
+    FsContext *ctx = arg;
+    size_t local_count = ctx->xattr_fid_count;
+    if (len < (int)sizeof(size_t)) {
+        return -ENOSPC;
+    }
+    memcpy(buf, &local_count, sizeof(size_t));
+    return sizeof(size_t);
+}
+
 static int synth_init(FsContext *ctx, Error **errp)
 {
     QLIST_INIT(&synth_root.child);
@@ -626,6 +639,19 @@ static int synth_init(FsContext *ctx, Error **errp)
                 g_free(name);
             }
         }
+
+        /* Directory for internal statistic queries */
+        {
+            V9fsSynthNode *stat_dir = NULL;
+            ret = qemu_v9fs_synth_mkdir(NULL, 0755, "stat", &stat_dir);
+            assert(!ret);
+
+            /* File for internal xattr count query */
+            ret = qemu_v9fs_synth_add_file(stat_dir, 0444, "xattr_count",
+                                           v9fs_synth_read_xattr_count,
+                                           NULL, ctx);
+            assert(!ret);
+        }
     }
 
     return 0;
-- 
2.47.3


