Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D43C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifl0-00042w-Ev; Sat, 11 Jul 2026 18:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifkx-0003uX-VS; Sat, 11 Jul 2026 18:01:07 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifkw-0008GD-9L; Sat, 11 Jul 2026 18:01:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=N8fw3larQKBeYlCddhOQdJElfCUvvc4yPAFQsxc8eKg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ccxuQ5o75mnk1TKiQFXs/3yJ2x3Rm0aKN8spZUD+dKgz/j1zxH+v3vqUG1vykjO3S
 RZycMCO/Pzucmxpr90TOCrVzHQUlwHHziOPRUTTZiZjdMnWibTSbiq7WkJASfo46v+
 /wREXSLHSomIaiIZVbm8jF3ID45dyiqa732nl7pyRfCRvQmp1YeU1bF+7Jwgp013Nb
 grlidIwfT5S5+fWoDyAiLiPXm+O26ws06IDoxtQ3Z1wKt2KLMSIKqteq2zrPW+7Mk8
 g64PkqbxuNd9uiuXPj9f9b2D8iGll0wvluxxr17rGdN2jt+i055Yopxp5Mprc6xYXw
 Hd6xRXWCyae+w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7FC041C0A9E;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 375AE3EAF29;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6266113309; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 19/81] hw/9pfs: add xattr count query interface to fs
 synth driver
Date: Sun, 12 Jul 2026 00:57:57 +0300
Message-ID: <20260711215904.3757-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a synthetic "/stat/xattr_count" file path that, if being read
by 9p client, returns the 9p server internal xattr FID counter to
client.

This allows to test and verify that the xattr FID limit is being
enforced correctly.

Link: https://lore.kernel.org/qemu-devel/357c20fc244c04dcbd36b13aa20a5c9b2034e9f0.1781361555.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 7e42d569a68aec6b0b6f1f068328c5c4ff20bc72)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 4b0732e0936..3b3654b2820 100644
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


