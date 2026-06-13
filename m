Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2229ECD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUR6-0005qs-FC; Sat, 13 Jun 2026 15:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQy-0005Qk-1e; Sat, 13 Jun 2026 15:54:25 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUQw-0004E8-4t; Sat, 13 Jun 2026 15:54:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380260; bh=qiPCt8dMH0b5By4gC1b3e2aCBQ8A4A8/xqo8O3Qw5f4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WqlWydbJIKYPTOez8K5KCcFvhI/mIVurEar46iP7X4cCHnuP1xJTWqOw6k3R9OwOR
 +56bfmiv8xLbtW9tLymIwUtrw5h5o0PSZAZroiesjreEOflIpes5FZWjFJ+QW3HSfT
 /Znvh5Lv+7Mu1W84fBgDp/qb7voL12Lr6xmwudnLNVKcSk2KGzMsI2yE5QCDXBApUl
 3guI/35gvQmwPR5ZHvL1v2op3FcHvHwB9FP+dZOwCupEsCIgEZaY/bQBnSED6kownj
 fpUwVUc38gljhSQcHC2fDkpAs/RsDEGinKJ0KBoS1P+c+A1UWRz3GCOQXZ9wonXB71
 DKjJsTY+UDVnQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 401721B6E32;
 Sat, 13 Jun 2026 22:51:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 90AA23CE8AC;
 Sat, 13 Jun 2026 22:51:18 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 35/56] hw/9pfs: add NULL check in
 v9fs_path_is_ancestor()
Date: Sat, 13 Jun 2026 22:50:49 +0300
Message-ID: <20260613195116.1807273-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

Add NULL check for s1->data and s2->data before using them in
string operations. This prevents potential crashes when dealing
with uninitialized paths.

This is just a defensive measure. We are currently never passing
NULL to this function.

Link: https://lore.kernel.org/qemu-devel/3348c4d683f061c23083bd45994d527be4fb7cbc.1779126034.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit abb0cc02fb56e2432837e34b80fe68768f95e774)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index bf05b1b6c5..018402c1a1 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -239,6 +239,9 @@ int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
  */
 static int v9fs_path_is_ancestor(V9fsPath *s1, V9fsPath *s2)
 {
+    if (!s1->data || !s2->data) {
+        return 0;
+    }
     if (!strncmp(s1->data, s2->data, s1->size - 1)) {
         if (s2->data[s1->size - 1] == '\0' || s2->data[s1->size - 1] == '/') {
             return 1;
-- 
2.47.3


