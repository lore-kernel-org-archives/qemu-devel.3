Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642C4C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wileJ-0005KM-BA; Sun, 12 Jul 2026 00:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildz-0004Vy-88; Sun, 12 Jul 2026 00:18:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wildx-0006WE-25; Sun, 12 Jul 2026 00:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=7EMrUXPB7ZaJo6Qxenp01a256ZZT8o5HU5j7/FIoGok=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xgTvCb5lFaTlzxEF8B+XtF/aaiNFhUkxfsBy71QXgqc5R753qbrb3b7/ZqNxFhnei
 epeEdFEylBFKad1TR851cu2X73ux7hL1W9/lXaWJoMxwR5A1NeBlac5ww/tfvtXwtJ
 vzjaJlRCDM450UEtrTxtiQYqp8S7TkhLAVlSUjgCBQ7m4Mrd8l0URGBkMQ6bBL4D1l
 X1LLKmEfqUp3MWBMXG4TOy8nkoJPjXdOP9mzx8RkHImjsOHqf7HJqazSp8IngwZryA
 sfJ2g/MGxGqLc+oHxk3KA0300IoVQqAITLb98hiwvAWKFkrxCFpDkYV+exLHlO7mJK
 X4aFYmfCAXb/g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 437D61C0BF4;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 76AF73EB954;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4F0E8133EB; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Feifan Qian <bea1e@proton.me>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 25/75] hw/9pfs: fix invalid union access by
 v9fs_co_fsync()
Date: Sun, 12 Jul 2026 07:14:43 +0300
Message-ID: <20260712041539.108341-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The individual FID types (P9_FID_NONE, P9_FID_FILE, P9_FID_DIR, P9_FID_XATTR)
share union V9fsFidOpenState with FID-type specific fields. Accessing any of
the union fields must comply with the FID-type to avoid undefined behaviour
or information disclosure.

Fix this in v9fs_fsync() and v9fs_wstat() by checking if FID has a valid file
descriptor before calling v9fs_co_fsync().

Fixes: 10b468bdc533 ("virtio-9p: Implement TXATTRCREATE")
Reported-by: Feifan Qian <bea1e@proton.me>
Link: https://lore.kernel.org/qemu-devel/b583e29d5a0776e41263732c93ac9f0da0a6016d.1781621428.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 32cae47c332f88241632905e0a3abcbb35b019c3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 51de5b8aa92..06ee09cccbe 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2273,10 +2273,15 @@ static void coroutine_fn v9fs_fsync(void *opaque)
         err = -ENOENT;
         goto out_nofid;
     }
+    if (!fid_has_valid_file_handle(pdu->s, fidp)) {
+        err = -EBADF;
+        goto out;
+    }
     err = v9fs_co_fsync(pdu, fidp, datasync);
     if (!err) {
         err = offset;
     }
+out:
     put_fid(pdu, fidp);
 out_nofid:
     pdu_complete(pdu, err);
@@ -3630,6 +3635,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
     }
     /* do we need to sync the file? */
     if (donttouch_stat(&v9stat)) {
+        if (!fid_has_valid_file_handle(s, fidp)) {
+            err = -EBADF;
+            goto out;
+        }
         err = v9fs_co_fsync(pdu, fidp, 0);
         goto out;
     }
-- 
2.47.3


