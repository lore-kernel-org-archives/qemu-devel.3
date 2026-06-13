Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2798CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:32:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYQJe-00084V-Vh; Sat, 13 Jun 2026 11:30:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <357c20fc244c04dcbd36b13aa20a5c9b2034e9f0@kylie.crudebyte.com>)
 id 1wYQJd-00083m-0g; Sat, 13 Jun 2026 11:30:33 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <357c20fc244c04dcbd36b13aa20a5c9b2034e9f0@kylie.crudebyte.com>)
 id 1wYQJb-0005Qy-KG; Sat, 13 Jun 2026 11:30:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=CJCZqEwpDo0kNpINRxGPflnSQ7lBBvvEzLU2Ny1xHJQ=; b=bz3uJ
 4oIpJm06elFs0Ct33WN+Oh9TU2PoK+/gQgsX4Wx4ePflfak16er0WqACffmpNjXau5j6O+Tt56qgl
 bFHwCwF4gLXJ0wpDyCv55xWaJpsSaYOhNCzIa1KYBCDvD1km42LCRP3ZoORO0/FK6txEj1Wj7bpn5
 ZPhXrK216s4DoDzVTtFOcYTsV4DIjIJ0MFmof/6Qd1As0LAloAxPDpU6exsYQE5Liy33UpWwJGxRS
 PArcst/HyAIQjXRVrnNSXqDBB/CaZ+9ya0XPrMLAd1Ftl+scaBNYviMnOMygne0zLKq0MhwRGUSbN
 z6jDFQEc8X2z4a0cs9yVYhCP9ahvaHRmBl0kMJTXJeNvZp1Ro4m7JmFl6oLXELXJOC60bakaQkOW2
 MqqHiPhgIv9CZwK3wd3DIbq31FNPCfZQgsZ9DxlArZ7YYdOkE2HExB+rDPJmSdlKc3mInbVQjz8vd
 Zu1BKZVzzeUqIo4agnYeTkENK+IW5Czng+fptO/5bomoAF3DTjnxm2xinkyPbMY0Xui9QL79kx2RK
 lCZBk3yFalNI6/+AsRFZTRI+e0fWJXIoug9SdEPpnwqrfnahmtHmdSHnNcNa7uwTMrTNzKpKdlbXK
 OZvLKRzgIZ3YHpfk8LMhGB/t3poJ8jqdyy0toKN74uKAN8nr1V+ltKQT47GAL0=;
Message-ID: <357c20fc244c04dcbd36b13aa20a5c9b2034e9f0.1781361555.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781361555.git.qemu_oss@crudebyte.com>
References: <cover.1781361555.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Sat, 13 Jun 2026 16:55:49 +0200
Subject: [PATCH v3 08/12] hw/9pfs: add xattr count query interface to fs synth
 driver
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=357c20fc244c04dcbd36b13aa20a5c9b2034e9f0@kylie.crudebyte.com;
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

Add a synthetic "/stat/xattr_count" file path that, if being read
by 9p client, returns the 9p server internal xattr FID counter to
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


