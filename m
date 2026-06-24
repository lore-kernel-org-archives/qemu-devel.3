Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909B5CDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:06:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFoT-0007Bm-Ox; Wed, 24 Jun 2026 01:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFoL-00073X-7Y; Wed, 24 Jun 2026 01:06:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFoJ-0005Zy-Gj; Wed, 24 Jun 2026 01:06:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277465; bh=/fPUUu3k6sxOAiPY7znsBTJYposfoMb4ycWskbpVyQg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GTEBqzrE1ghfsri4h94xOKkqNSz4sxVfq+OAHeXcZmsb0kWBCFXHhRoyjtBtOoStY
 4gILaUB6twi5hROPR3eUJnwNMhSAMCWKdCNlGL0txzqyy9HSJ2sypL1m/gEWYB52VD
 XtQCAWFP/1wNr/eMaRoOePSSVigFkXA+Ju9PzOQ+KUwASXdbpXG4rkqV/V3wGuhRnc
 nWCUnvT4F5Os7dMkLXivuOA+P3eY3c5kCxlC3DH5h++wBXcyu4YLjAP4A++W0vDnM1
 A7+0If5q/2esrGm1FyZae2hon6r/4rXLTg8MXSJnN09JGAENt5FTPZz0K3P+b17a4v
 1kwvXCIXNIcYQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 975291BA640;
 Wed, 24 Jun 2026 08:04:25 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 80F6A3DDACB;
 Wed, 24 Jun 2026 08:04:30 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Feifan Qian <bea1e@proton.me>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 77/86] hw/9pfs: fix abort due to illegal name with
 Twstat rename
Date: Wed, 24 Jun 2026 08:02:48 +0300
Message-ID: <20260624050404.394225-21-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260624080222@cover.tls.msk.ru>
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

The legacy Twstat 9p request can be used to rename files and directories.
Unlike the other, more recent rename requests like Trename and Trenameat,
Twstat does not validate the submitted new name before passing it to
v9fs_complete_rename().

A priviliged guest user with direct communication access to 9p server
could pass a string containing '/' as new name, which causes an assertion
fault (DoS) in local_name_to_path().

Fix this by rejecting such strings by checking the client supplied new
name with name_is_illegal(), similar to how Trename and Trenameat handlers
do already.

Reported-by: Feifan Qian <bea1e@proton.me>
Fixes: 8cf89e007a ("virtio-9p: Add P9_TWSTAT support")
Link: https://lore.kernel.org/qemu-devel/ba09716828e82992f9d8cac7f00eee0bc1c43c61.1780072238.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 7f5445e7e4050cc117ed4b137bb7dd1474e49d57)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 7d53f070cc..0d58a5a74c 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3617,6 +3617,11 @@ static void coroutine_fn v9fs_wstat(void *opaque)
             err = -EOPNOTSUPP;
             goto out;
         }
+        if (name_is_illegal(v9stat.name.data)) {
+            err = -ENOENT;
+            goto out;
+        }
+
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
         v9fs_path_unlock(s);
-- 
2.47.3


