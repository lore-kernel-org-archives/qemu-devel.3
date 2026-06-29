Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1597DC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCF0-0008Ly-53; Mon, 29 Jun 2026 09:41:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c3aa2491cd2cd89e2f484d32f323ee447e782984@kylie.crudebyte.com>)
 id 1weCEi-0008Ce-P1; Mon, 29 Jun 2026 09:41:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <c3aa2491cd2cd89e2f484d32f323ee447e782984@kylie.crudebyte.com>)
 id 1weCEh-0005Nm-9W; Mon, 29 Jun 2026 09:41:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=zIK5xwOzU2OkUrM5JSFz9ht0XvrYw6wrNhpI1E1fCjI=; b=Fsppn
 FtIH8Mwo8UlXxeBSyw/nlAxMLFIDWmpnlMfPzp1CJVgaeu9T5PcYwMQ/SI3jPbFm1vDN6jKy6k22n
 HoldnUnIv/JpxHI7X30rP32UJKdNnRmU96J8WT7KTxmUB1Sif9sp1AlCnrF6jBJvN5pEm5o9su86R
 Ai3OzXzYqxMWkjDanEVE9sK2JGWpVIMzEmTGES9Wtwj3YxeQ1PQZ6niKh6Ky3nBjE249loG6fiTPX
 qQY/z/sHTQdVvWYIjom8NjfCWWReOORKzZs9bT4NcBR1/PKhlAl69SIga3V3cYDIq961qOb9bH4WG
 qYWVNWHdzB4tZ2cWvixwOMkkX3PZSjXh58zMYyw4NRebqj3h62vnoM3Ez+dI2m9H/ClPoLEo+I+Fr
 QZS+AG+AL0zXUpADHe7JjouaJeMmUAlgqwM3DteGAR9LkseeSPoOlDgG7Sz5byqDSSz3L6plRuLFI
 tNol/hxMp78xJwwbmMLvX6g40AIssPf/Zhrv/1tDKvAFl5FyZMlPdfbXPHA8fC25lWzlZHACwQmWW
 bbrUjLhGRO5zCJeO05yXFzkrrqvOFVoJeYflAWYX1c1gxA9T1l9VFR8QBtlrrvVmvZDIBFhXfrt9d
 zCDgeIsckrNTgP/Ddxt3qtalnEJ+JimjA66hlB1HcSHVzYSO/6eAiIKVMBJ9d4=;
Message-ID: <c3aa2491cd2cd89e2f484d32f323ee447e782984.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 22/23] hw/9pfs: fix invalid union access by v9fs_co_fstat()
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=c3aa2491cd2cd89e2f484d32f323ee447e782984@kylie.crudebyte.com;
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

The individual FID types (P9_FID_NONE, P9_FID_FILE, P9_FID_DIR, P9_FID_XATTR)
share union V9fsFidOpenState with FID-type specific fields. Accessing any of
the union fields must comply with the FID-type to avoid undefined behaviour
or information disclosure.

Fix this in v9fs_lock() and v9fs_getlock() by checking if FID has a valid
file descriptor before calling v9fs_co_fstat().

Fixes: 10b468bdc533 ("virtio-9p: Implement TXATTRCREATE")
Link: https://lore.kernel.org/qemu-devel/4b33cd1aaa2551efda220a6f651e3660d27f4746.1781621428.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index a2b7335515..3119f01117 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3908,6 +3908,10 @@ static void coroutine_fn v9fs_lock(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fstat(pdu, fidp, &stbuf);
     if (err < 0) {
         goto out;
@@ -3953,6 +3957,10 @@ static void coroutine_fn v9fs_getlock(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fstat(pdu, fidp, &stbuf);
     if (err < 0) {
         goto out;
-- 
2.47.3


