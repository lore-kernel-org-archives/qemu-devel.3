Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8205BCD98DC
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:09:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUf6-0000Mv-LS; Sat, 13 Jun 2026 16:09:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeq-0006aY-3m; Sat, 13 Jun 2026 16:08:44 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUeo-0002ei-2L; Sat, 13 Jun 2026 16:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781381070; bh=ubdO+zpxQThsSC68lkwISaMv3bI5tKubzpj/X8KopDg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GPOlGnl82gQUKRVcxdGUJuM3RB712979N+yEd/UACA67ufPO9Vc0wAyQ9vkgjzcrS
 KmaoZsrqmN/UQpyc60lMtSzS4R7EsA9DZkihBX1WwRg73f8W1mL1/uhRjI/dVM4i3P
 D8h5QTNHqXMv1DQWKTpvQSZR1vrf9BM3F4c6R0gSFj/2Bl4YDSsj6+4E2FAASyTGcy
 KxZ2/dVkhET/dZDN0hK+K5CiwsgEgBSz4DuXHnVIuGC3blMbQJB9hP5SJrFe+etUnh
 usRbtgBKdqrwlXu05vj/k70Sgcuxl7+b7hUX9uk53zINTCuOgS6r2Gi+ngeDhtyzAA
 ClwXzGTxleL2w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 033161B6E9C;
 Sat, 13 Jun 2026 23:04:30 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 617F53CE8F8;
 Sat, 13 Jun 2026 23:04:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, sin99xx <sin99xx@proton.me>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 46/61] 9pfs: fix missing rename lock in
 v9fs_co_readdir_many (CVE-2026-48004)
Date: Sat, 13 Jun 2026 23:03:29 +0300
Message-ID: <20260613200411.1808021-46-mjt@tls.msk.ru>
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

From: sin99xx <sin99xx@proton.me>

v9fs_co_readdir_many() dispatches do_readdir_many() to a worker thread
that reads V9fsFidState's path.data without holding a rename lock.

A concurrent rename request, e.g. of its parent dir, causes the FID's
absolute path to be altered by freeing the old path string and
assigning a new one. This causes a heap-use-after-free race condition
while do_readdir_many() is still accessing the old object.

This allows a DoS by an unprivileged guest user.

Fix this by wrapping the worker thread dispatch block within a pair of
v9fs_path_read_lock() and v9fs_path_unlock() calls, like it's done at
other places.

Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
Fixes: CVE-2026-48004
Reported-by: sin99xx <sin99xx@proton.me>
Signed-off-by: sin99xx <sin99xx@proton.me>
[Christian Schoenebeck: add commit log message]
Link: https://lore.kernel.org/qemu-devel/E1wPkYi-000adH-4E@kylie.crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 5a8da7e979f1f56b1cab82c2354833f309f1a78f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/codir.c b/hw/9pfs/codir.c
index bce7dd96e9..5568399343 100644
--- a/hw/9pfs/codir.c
+++ b/hw/9pfs/codir.c
@@ -220,13 +220,16 @@ int coroutine_fn v9fs_co_readdir_many(V9fsPDU *pdu, V9fsFidState *fidp,
                                       bool dostat)
 {
     int err = 0;
+    V9fsState *s = pdu->s;
 
     if (v9fs_request_cancelled(pdu)) {
         return -EINTR;
     }
+    v9fs_path_read_lock(s);
     v9fs_co_run_in_worker({
         err = do_readdir_many(pdu, fidp, entries, offset, maxsize, dostat);
     });
+    v9fs_path_unlock(s);
     return err;
 }
 
-- 
2.47.3


