Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C51ACD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV9K-0000t2-WF; Sat, 13 Jun 2026 16:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9H-0000bX-A9; Sat, 13 Jun 2026 16:40:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV9F-0004TR-C1; Sat, 13 Jun 2026 16:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382965; bh=lRK4NhiR2fBV89rabH41NE98LJMgN+fdDW4JciwJ5Yk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JSBnMafgnCFyDo4xz3HxzhLHTBPIicfTnmoyTQBlImFCPG/bkq9riI4bBfygjKWlP
 E8wkiGuAyMjACOQhTl2TGvByyW8cIzQ0xpMdhtSheBByMgiOq4R3GtnsTXs1tXdMA1
 MwdGuM2VUquw1AQU4os2ZXCjKqDnmAWXJWPkAedgPSQrGjFQRI+WcFLKoczoO0TzfF
 qK8Dp/QmV5Q9hbn3ZRSO9MqKvb3V2kmtT6whOB5PNvZJVbL+Ek5N++xyLY80W7esmz
 h7OhWEJPYjKX1MVg0veLdFob/9jRFkIz36fUiCdv7p5GQeB4ntE0Owl1Rgvcbdj1TW
 IRDYsDmZXSFOQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20CAD1B6F06;
 Sat, 13 Jun 2026 23:36:05 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 802943CE957;
 Sat, 13 Jun 2026 23:36:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 43/72] hw/9pfs: add NULL check in
 v9fs_path_is_ancestor()
Date: Sat, 13 Jun 2026 23:35:09 +0300
Message-ID: <20260613203542.1809153-43-mjt@tls.msk.ru>
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
index e2713b9eee..e590c414ab 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -241,6 +241,9 @@ int v9fs_name_to_path(V9fsState *s, V9fsPath *dirpath,
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


