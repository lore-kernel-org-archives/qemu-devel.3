Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D1BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlFR-0002hL-A9; Wed, 20 May 2026 14:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fded2c648f0d39367ace49c7ce56433ec6c5ba70@kylie.crudebyte.com>)
 id 1wPlF6-0002g4-K0
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:02:07 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <fded2c648f0d39367ace49c7ce56433ec6c5ba70@kylie.crudebyte.com>)
 id 1wPlF4-00041y-OU
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=YrViNUl0kk5pNxyczeZpVNv9oMtV/Lu1Mt4drGo5OM0=; b=U0Rea
 PBojKu67acvoJC8HX+vfac+w89K+q2jjgOOrREJ5aNqnS7hi4a+2mTQesrlYJNEU1YfUIrtznyQAR
 DfJjbYpeZXrEXBRR/n98XFqI9tfT0e7hu1tetGdY+yfoBg5oO2Mn5ppEKgdVR4BIaUvjyKghXmYrm
 CMu7sm3PzMy32mPYPKYggqUGbBGuXjuPw7YPDzadS4vaIPQXa+Eztd21OPogrMbRFnoopu6l3O5aw
 A9LqfnS4MmgujmxbN+Duun7gtM2UbzjfLWwlQQ1X1LlB1Ue1o5Z23NA1jeK457kutaKO4OCEZuRpL
 Xqtw+NcIxMwfX+QGdmqnuYS4+oOhZzhAwIcW6z0UlqUOv7T66eIo1++iYtmiihaVQCONhb4Wjk2NM
 lqMRAAQKdv+1ocWqflmVhEnpLC3DhSrUgIqrXbIBgp9B51bqq55MDcn7IiSfGt/Aqwn84ofag+FCB
 zxQVNujwMFg8enyCZEj/QLOHnKlwF55PAgY+SAmcZJ89QFLieO1dQj9jnEL/4qzJyLUvuCKgeMQo7
 TIQFCTXIv6b/2dYf5Rzhh7uk3wjVqQ+nRxglWjq5hFYYfVJ9hovTinc2ddSCIFac4jDU4Vpz3pM+9
 urzGraithC3zj+7WInUW9AuefJO5lkQWqR1oeLYK0mPCy8FhAdgoUNV5WUEBF4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 20 May 2026 19:11:25 +0200
Subject: [PATCH] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    sin99xx <sinxx198@gmail.com>
Message-Id: <E1wPkYi-000adH-4E@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=fded2c648f0d39367ace49c7ce56433ec6c5ba70@kylie.crudebyte.com;
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

From: sin99xx <sinxx198@gmail.com>

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
Reported-by: sin99xx <sinxx198@gmail.com>
[Christian Schoenebeck: add commit log message]
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/codir.c | 3 +++
 1 file changed, 3 insertions(+)

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


