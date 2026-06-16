Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF51CD98E3
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 15:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZW0X-00078k-VF; Tue, 16 Jun 2026 11:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <531f6b81bc1bf1a48c3d4afaa60a65db10511041@kylie.crudebyte.com>)
 id 1wZW0U-00077l-HG; Tue, 16 Jun 2026 11:47:18 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <531f6b81bc1bf1a48c3d4afaa60a65db10511041@kylie.crudebyte.com>)
 id 1wZW0T-0000DG-81; Tue, 16 Jun 2026 11:47:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=Ike6TkXVNwA63st+thYc7epozG8pldJu6pFRJVDCGsM=; b=Ti9uj
 fnJvdJEO8l11XhpQcA+boR+EuPFK0uaNc0nxRUfquGEb2tDs24V+2oAlNz+9Z71KeXOczLPb3v3+Q
 5pxiH1rv7B9kx6c8QH1Ox/a8yW0v5Myvi4vAaYZ30Pkd5hk1s+wLW2Zd7dO5k9wONhaOw7pAL70Sz
 aPro3pAWQj98p+edHKlfN1vcj2+PudTEZH6sS2Edbupwj4DUMkVJPXHdQoTpX7pJWxRRrXlcu6MO+
 R2Zcm8Ntr+NSDypGQ/rmjPr7HDq/BPNchR//B6xHMW5HPX3Q0IPdEiShpz5eQ+HcRqLwYvEL3ZGpP
 KP2c/8RoB0tSnZ9gBRa9fqMBh6MkXNCRWhFuAc/pifyglinKW5LjVEQX0ybZt+ZNev2BVXyv1ie00
 sI2WM9+9XFr2nFIeVqsslmohhU5iF2qcW45iiKPyvDlCrCaCStWcwx02ncBcHqQs6l5hpzLYwaNC/
 tU9mlzFUYSziLxSxA8CzbFhxkR3SKF76KVPQCAFKk+dlv3Qigm70Q0y6rb+DJHJRikvgnE3HyOe67
 //NP3R8cEbfb4u213F1B/Ws+dToq1aGXahH0F8E5l1w0zTxZR4ujudjjn2g0lP0V2+UybvXOkMUY7
 6FwPo4L8y9fF76jyT0pew7zZm1iKA+XsuL6oVbjCW2EgsQ/HUl/yGw5fphUF/E=;
Message-ID: <531f6b81bc1bf1a48c3d4afaa60a65db10511041.1781621428.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781621428.git.qemu_oss@crudebyte.com>
References: <cover.1781621428.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Tue, 16 Jun 2026 17:00:11 +0200
Subject: [PATCH 3/3] hw/9pfs/local: harden local_fid_fd() on FID types
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>,
    Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=531f6b81bc1bf1a48c3d4afaa60a65db10511041@kylie.crudebyte.com;
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

local_fid_fd() returns fs->fd for any FID type that is not P9_FID_DIR.

Since P9_FID_XATTR and P9_FID_NONE share union V9fsFidOpenState, calling
local_fid_fd() on these types misinterprets xattr state as a file
descriptor, potentially leading to undefined behaviour or information
disclosure.

Even though we are catching these FID type mismatches on protocol level
in 9p.c already, previous patches proofed this to be error prone.

So let's add another safety layer in local_fid_fd() that would return -1
if the FID type would not possess a valid file descriptor, to prevent
wrong file descriptors from reaching fs backend calls.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p-local.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index aa48306b0e..724f57dc3d 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -775,8 +775,11 @@ static int local_fid_fd(int fid_type, V9fsFidOpenState *fs)
 {
     if (fid_type == P9_FID_DIR) {
         return dirfd(fs->dir.stream);
-    } else {
+    } else if (fid_type == P9_FID_FILE) {
         return fs->fd;
+    } else {
+        errno = EBADF;
+        return -1;
     }
 }
 
-- 
2.47.3


