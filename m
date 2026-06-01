Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013F0CD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 10:38:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU013-0004V9-1l; Mon, 01 Jun 2026 06:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5a8da7e979f1f56b1cab82c2354833f309f1a78f@kylie.crudebyte.com>)
 id 1wU011-0004Ux-Pn; Mon, 01 Jun 2026 06:37:03 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <5a8da7e979f1f56b1cab82c2354833f309f1a78f@kylie.crudebyte.com>)
 id 1wU010-00078R-Bb; Mon, 01 Jun 2026 06:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=TxLaprz4ri2hkiNHwMAtO8UBAL7QE48u/lmxmv/skBo=; b=TOxfr
 Raqc3vivR98bPzi8rSh6rCst6ABqvwvn9F2esW09uLHyYuj7T0z4XMagm5aUIWFbpB5wyf+ZQiEgM
 sYZQl0CQHd7LQKT5ZasLvfvCNzLYBS2PP37YcsF9npb8+UoxZL415KzS0EwSoSCAmOxJe/lpeYIUl
 OEHK9c6OsdbAFlpz4tbJBzkgALhgtN2jNdKfOFVsLga3ReNLk3UZ8qqlF5teZrzTO73XU71J7+ALn
 BEECfIDEr7XpUYelnl8L8olkleYYs6jNQ7/lCSb5YDxJviRYWp8m5SkzVEfOMDXCR8gdSxhdaoiMC
 DfIkpPfHKHtHkk89NwDM5iCFDlSJeQ3T2XEQx+K4WEM/0vsa1sp1sBhZPbXRCtMxKHTbv1Mt3YCWl
 ACPbsYM+xO3RjHcTyXL/68hiPVUUltT+TGfGaOEbsF8LX8S+0K+pTQrPDgMO4GykJjFiSml8+WOOz
 Vb8kxDo6Qz9gvefdg30o4S9A3eH83TuHh7QDHmtTCPzwrh+mLyKuw8h8xYV5OjGhCIQwBzuUqSZzF
 phvci3uFPqST6Mi1ihUx+ZiwS44LZaiu92PhVM8kBRpXoFRD2yVUTMbZzjOJxE2Yq5HCd12wy9j4h
 2CQxeCU2RMb0qv0aMmd8wrxUPNGxf32yIRuEm+7mkCTPuUJugy2/lkt1pgXoiM=;
Message-ID: <5a8da7e979f1f56b1cab82c2354833f309f1a78f.1780307575.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1780307575.git.qemu_oss@crudebyte.com>
References: <cover.1780307575.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 01 Jun 2026 11:52:56 +0200
Subject: [PULL 7/7] 9pfs: fix missing rename lock in v9fs_co_readdir_many
 (CVE-2026-48004)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, sin99xx <sin99xx@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=5a8da7e979f1f56b1cab82c2354833f309f1a78f@kylie.crudebyte.com;
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


