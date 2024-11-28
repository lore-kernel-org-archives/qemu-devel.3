Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33121D70DEE
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 19:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGkKx-0005pU-Qb; Thu, 28 Nov 2024 14:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c81e7219e0736f80bfd3553676a19e2992cff41d@kylie.crudebyte.com>)
 id 1tGkKq-0005nh-Ii; Thu, 28 Nov 2024 14:37:57 -0500
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c81e7219e0736f80bfd3553676a19e2992cff41d@kylie.crudebyte.com>)
 id 1tGkKp-0001ai-0Y; Thu, 28 Nov 2024 14:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-Id:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=sZ1E9BcYHFsRPyZxFsRdJMwSjmBFK1SLraoUCBW0/70=; b=ZhMPu
 j39Ti84RLdDnZat4MKffb/WE/Bq3mYl0pKgav84zVbbWbQ0YobugTZ2sURuvtA42LCbVjU8r2rzLr
 l/+GT2HOtj9vyiasj4xGmlkr70nlRW25AsHo8X9g3npfcV0HJZhdZpkzNWU8AVIb0cGWUxZW6Ujgb
 524Ts9YGl9uhQD7ZX+2LcWHkkFhrdmcl4b5DtjjISff5w5gGMspS4T14cWPDl8ApKpI7DREOqGfsa
 2e4szqcS4FgQthRDFU17yLw2iQSBT1M1SAlxBH5nZrGCYAUoptzlS4himyfWa5ut25IOEbT9sTV8e
 IixA1MbTsMyCviABXd/ySR9zJxUkp5Y0Ll7Q1pR9AJ9Gp4pi73xXiXP3b5GoMummvh3EZ9Dmc5KHb
 MUhprQG0/mVOUvRei0wB40ALcXCzCjys2inIy8THYc+bAqqBKxy1f9JxP2dXb68/dk5kawS07nidS
 as+Lbw2zTg490b7Poswf7IUxwUKslCa4XQABX9vTmrEIh8xxbnBEZ+FK4f9qSCJ4FRbVW+Epq/cFj
 D2Dc33uM6ZqSD55DsgVxtujzsIBhp5f5PeZok9JEUO0bKF8BZC2oosnkbtNdjHByeuJxqvhNGMgpv
 IIlZxj5IO2Kc40bVxfnzU48qI0IB2jfZQ6qssFDm7kEdjen5aBikNIO6MG4rro=;
Message-Id: <c81e7219e0736f80bfd3553676a19e2992cff41d.1732820037.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1732820037.git.qemu_oss@crudebyte.com>
References: <cover.1732820037.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 28 Nov 2024 19:53:58 +0100
Subject: [PULL for-9.2 6/7] 9pfs: fix 'Tgetattr' after unlink
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-stable@nongnu.org,
    Greg Kurz <groug@kaod.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c81e7219e0736f80bfd3553676a19e2992cff41d@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

With a valid file ID (FID) of an open file, it should be possible to send
a 'Tgettattr' 9p request and successfully receive a 'Rgetattr' response,
even if the file has been removed in the meantime. Currently this would
fail with ENOENT.

I.e. this fixes the following misbehaviour with a 9p Linux client:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
  unlink("/home/tst/filename") = 0
  fstat(3, 0x23aa1a8) = -1 ENOENT (No such file or directory)

Expected results:

  open("/home/tst/filename", O_RDWR|O_CREAT|O_EXCL, 0600) = 3
  unlink("/home/tst/filename") = 0
  fstat(3, {st_mode=S_IFREG|0600, st_size=0, ...}) = 0

This is because 9p server is always using a path name based lstat() call
which fails as soon as the file got removed. So to fix this, use fstat()
whenever we have an open file descriptor already.

Fixes: 00ede4c2529b ("virtio-9p: getattr server implementation...")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/103
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Message-Id: <4c41ad47f449a5cc8bfa9285743e029080d5f324.1732465720.git.qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 851e36b9a1..578517739a 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1596,7 +1596,13 @@ static void coroutine_fn v9fs_getattr(void *opaque)
         retval = -ENOENT;
         goto out_nofid;
     }
-    retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
+    if ((fidp->fid_type == P9_FID_FILE && fidp->fs.fd != -1) ||
+        (fidp->fid_type == P9_FID_DIR && fidp->fs.dir.stream))
+    {
+        retval = v9fs_co_fstat(pdu, fidp, &stbuf);
+    } else {
+        retval = v9fs_co_lstat(pdu, &fidp->path, &stbuf);
+    }
     if (retval < 0) {
         goto out;
     }
-- 
2.30.2


