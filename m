Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7933606B00B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=crudebyte.com header.i=@crudebyte.com header.a=rsa-sha256 header.s=kylie header.b=eACH28p7
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVn7U-0007Z0-51; Tue, 24 Nov 2026 04:47:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e96cfe900e1ad4e379732903f80020ba16146fde@kylie.crudebyte.com>)
 id 1xVn7R-0007Yn-MJ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:47:22 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e96cfe900e1ad4e379732903f80020ba16146fde@kylie.crudebyte.com>)
 id 1xVn7Q-0006VY-1m
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 04:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Message-Id:Cc:To:Subject:Date:From:Content-Type:
 Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Content-ID:
 Content-Description; bh=8Gi+YTpI96mgoP8B+3FZE9/yNPc2+zq0GsIQreB5Aw0=; b=eACH2
 8p7ZmWCixEgZmVJdSqWS5ML0dxBHmZ1cL/QRZ0TenwFoWYcx3rToiW1ZRYX3wP75C8I8CTYSV6TP0
 OzRJsbOzax4cgp/rszkkhOawDYFYXRFfiCDzkdNqM8IcmP9f0HuLCm/Oa0AV+NqvpcAzyqDZDTrJf
 KtLfA1hHwVtnOvdv1rEb33ZxvOtxfkPZPaOmfO5g1znImZrqK71OyjxG74e6HWrInCAchFoNGUe1r
 5ELhRhH+jWCWF/tv3Ofe5n2FTYKsT4fuanKvXg7UbNo17FsEBlOksTzm0Px/ilityuRDUiMxU+GqZ
 YualfffCpR/4e4xfnEBt9s73vhVhqgDSN5Ly3YXAarJzfVA3H48Hl7m5w3k6NkB0Z9bWfPRgNgaJt
 uX8fcoGNjWidmAXRsTTBphakzCrMfEb9XugVqEFrNyWFupGXtDU034J+bIWYM8nzsm8ijs9VAUOQx
 0iZE4xdCvEfsU0/LOJn1Fy0iW1dz+H01WtQ3rqVJ6vntryvCRk6ibbMpNNf3XIDp289H0oi8JGkyX
 sgUEi/I90JsGkqIp4P+JEH7gcOR3rJ3Wbig90L/Rzb2QBBPsOllJIr8siXUGDdhz+fQAnwMLXzcB6
 ey06DKg/zG6JKPkXreoLcPMyRt8a37RTUSyRI0/pTjmur9x6hkBMPKEY4lTPcw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 24 Nov 2026 10:43:40 +0100
Subject: [PATCH] hw/9pfs: reduce contention in v9fs_co_open2()
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>
Message-Id: <E1xVn7M-00000000CTc-1YBF@kylie.crudebyte.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=e96cfe900e1ad4e379732903f80020ba16146fde@kylie.crudebyte.com;
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Optimize CVE-2026-93834 fix fe9e30899ff, which used a conservative
approach by holding an exclusive write-lock throughout the entire
execution time of the dispatched background worker thread, which
has the negative consequence though that it stalls every other
path-based fs operation as long as the background worker thread is
still running.

The worker block only needs to read the FID path. Exclusive write
access is required for path mutation only. The CVE fix however already
moved the path mutation out of the worker block. So a read-lock is
actually sufficient for the worker block.

The reason why the original fix still used a single, atomic
write-lock though, was to rule out a small lock-free window when
unlocking and relocking.

This patch circumvents this potential unlocked window problem by
upgrading the read-lock via qemu_co_rwlock_upgrade() directly to
a write lock, i.e. without a re-acquire lock gap. So still no other
concurrent request could mutate the path in between.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.h     |  8 ++++++++
 hw/9pfs/cofile.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 0e52ffbdf3..df01d99bad 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -448,6 +448,14 @@ v9fs_path_unlock(V9fsState *s)
     }
 }
 
+static inline void coroutine_fn
+v9fs_path_write_lock_upgrade(V9fsState *s)
+{
+    if (s->ctx.export_flags & V9FS_PATHNAME_FSCONTEXT) {
+        qemu_co_rwlock_upgrade(&s->rename_lock);
+    }
+}
+
 static inline uint8_t v9fs_request_cancelled(V9fsPDU *pdu)
 {
     return pdu->cancelled;
diff --git a/hw/9pfs/cofile.c b/hw/9pfs/cofile.c
index 27fe5bfb20..5095218b29 100644
--- a/hw/9pfs/cofile.c
+++ b/hw/9pfs/cofile.c
@@ -147,10 +147,11 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
     v9fs_path_init(&path);
     /*
      * Hold the directory fid lock so that directory path name
-     * don't change. Take the write lock since the fid path is
-     * mutated below on success.
+     * don't change. The worker thread only reads the fid path, so
+     * a read-lock is sufficient (avoiding an exclusive lock being
+     * held across the entire worker block).
      */
-    v9fs_path_write_lock(s);
+    v9fs_path_read_lock(s);
     v9fs_co_run_in_worker(
         {
             err = s->ops->open2(&s->ctx, &fidp->path,
@@ -174,10 +175,12 @@ int coroutine_fn v9fs_co_open2(V9fsPDU *pdu, V9fsFidState *fidp,
      * The fid path must not be mutated from the worker thread: other
      * requests may access the same fid on the main thread, and the main
      * thread never takes the path lock for reads. Mutate the new path
-     * here, on the main thread and still under the held write lock, like
-     * every other mutation of a fid path.
+     * here, on the main thread, after upgrading the held read lock to
+     * a write lock (i.e. no unlock and relock, to avoid a potential
+     * short unlocked gap).
      */
     if (!err) {
+        v9fs_path_write_lock_upgrade(s);
         v9fs_path_copy(&fidp->path, &path);
     }
     v9fs_path_unlock(s);
-- 
2.47.3


