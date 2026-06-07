Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A6AACD8C92
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jun 2026 18:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWHmk-0000XF-Od; Sun, 07 Jun 2026 13:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <88245fc6852d430ae4b76157ab9d3b92a4767bdf@kylie.crudebyte.com>)
 id 1wWHmk-0000Wj-0b; Sun, 07 Jun 2026 13:59:46 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <88245fc6852d430ae4b76157ab9d3b92a4767bdf@kylie.crudebyte.com>)
 id 1wWHmi-0004Pp-IV; Sun, 07 Jun 2026 13:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=xW/DPGJd1kcaXKX7UWvwp4TuiSMmM2UJikdF3Y9+z5U=; b=E/E3p
 J2Ns3jB3Ds3vsUk+q3rF2AlOC19q2QBn7ZH4AILtNvoeu8VAfI9DD+EOBDfXEm1pQPy9/T5wCm0RJ
 cHSgsNcGXs4U9880mD4MSVEbh8bAICJqtAusKQgnX4/rnu9HoqBPpQnBoJtzYViNglo0WZVMUTLpS
 sgmJRyexw5yg6MGXWMd7lmOzGDm6QT1ZVu/9eG8N/nv47tFZJHmzY8tU0VBpixotp1VPBel43He1Y
 K0IZu5Hd2pAUv14BMZoxCiJ3U4J6d0LDQ4hWxHs3xXnxjmUSODfMowRNJF1hpotaYbfVfXk4t0l0b
 InTmKkQLoC6xWd6MmQNmGle+jUJePpDzsaPBp5ZTNbR/Z0r+p6T4WMloyNJ5QVIttULvPr6YoZojd
 SLvVjWbqVCZURt84GWx/n5ON10XAdAxupc/073K90/rPx3M42uN1iHbu2KHG0JDAL0I0ooHzn6vtN
 fl7W7YL+bodxvSdDie4ZtUi5GXhOuFh2Pu/TMTeIA1SkNnqMV++a7VjRdUC0XGDgo7sbGxt0cUnrc
 65GnCTs42OO7HhcccOCGsigxTbjyi3Uc0T1L0Ep7oUNA3yTZjlZY5J/imfv/nR5VRZEIkJ++Be9sR
 og777Qbi+sMFPx/ezZgT03VtRXfdkp2fpLt1/n/B8Ejws9zBDAgUJYXYlkehmw=;
Message-ID: <88245fc6852d430ae4b76157ab9d3b92a4767bdf.1780851947.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780851947.git.qemu_oss@crudebyte.com>
References: <cover.1780851947.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sun, 07 Jun 2026 19:22:19 +0200
Subject: [PATCH 08/12] hw/9pfs: add xattr count query interface fo fs synth
 driver
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=88245fc6852d430ae4b76157ab9d3b92a4767bdf@kylie.crudebyte.com;
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


