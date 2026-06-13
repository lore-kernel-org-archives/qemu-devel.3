Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22FECD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUen-00066Y-1v; Sat, 13 Jun 2026 16:08:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUei-0005Kn-G4; Sat, 13 Jun 2026 16:08:36 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeg-0002Yx-Id; Sat, 13 Jun 2026 16:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381069; bh=GuFVx0cmuNzha1cFRS6vzUxrjZMJrsQl4zqv0yrBrKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lCrbLIo/uPUwpH3KTbTGeEDGeGcE2Dm3CjP9kt+igM1PyCUjwdIoQZ/XG+TAbzj+X
 j2YWzH7wlAIhJGzwFWIsCzaPSMCBkrFB7RkRz77DYV6LPeIOIX1W55QsROaQyFoL31
 afwh9ATaEePEW4GtvPhHzMpot+PTstmARc/bz9Z1/Sp/ZBBAhlFL8jLWik/Y0ZooKa
 RQaRF3hiongvlEfQNKAiEGtsbJ/4TrgA3xmVN22syaVOAZiaag7oRlRqYuwGPgIqk1
 H5+/Vp1MpJeJLp2ZVN6m1uOzrxQT6gqSjTEQt2ue0/GjSCH1Dve1pnuCU4wVeN1BuX
 xIcImXTAS1IRQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BD6641B6E94;
 Sat, 13 Jun 2026 23:04:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1F0F73CE8F4;
 Sat, 13 Jun 2026 23:04:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 42/61] hw/9pfs: add error handling to v9fs_fix_path()
Date: Sat, 13 Jun 2026 23:03:25 +0300
Message-ID: <20260613200411.1808021-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260613224639@cover.tls.msk.ru>
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

Update v9fs_fix_path() to return int and propagate errors from
v9fs_path_sprintf(). This allows callers to detect and handle
path formatting failures.

Link: https://lore.kernel.org/qemu-devel/a0592741a918b7cbe751980ec7ec0c03f505924c.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 54dd352c59269fdb5241e7b6dbcecaff107e7f5a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index ec493f74a8..0800ac12a4 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1417,13 +1417,15 @@ static void print_sg(struct iovec *sg, int cnt)
 }
 
 /* Will call this only for path name based fid */
-static void v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
+static int v9fs_fix_path(V9fsPath *dst, V9fsPath *src, int len)
 {
     V9fsPath str;
+    int ret;
     v9fs_path_init(&str);
     v9fs_path_copy(&str, dst);
-    v9fs_path_sprintf(dst, "%s%s", src->data, str.data + len);
+    ret = v9fs_path_sprintf(dst, "%s%s", src->data, str.data + len);
     v9fs_path_free(&str);
+    return ret;
 }
 
 static inline bool is_ro_export(FsContext *ctx)
-- 
2.47.3


