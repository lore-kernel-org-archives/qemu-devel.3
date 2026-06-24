Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F75CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:49:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNsb-0002mq-OI; Wed, 24 Jun 2026 09:43:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsV-0002Yk-OT; Wed, 24 Jun 2026 09:42:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNsU-00021l-6P; Wed, 24 Jun 2026 09:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782308002; bh=J0rHM6wTNz+A/ze9gmNWyp+H/Vifrhgz0ISNPvz8rK8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=heOqvoPx2LM7KYkkgfuqSJi8Fw20cRZIbPIaxMNTfcp1/pB81FA9UD1ImklCJCnoX
 eVx/ic3pOOcAo9T5IKsoNoKNSxZh91/LMTBPFQw8/K3UnTaiJXKpFU++JGTB3+gali
 SZLHtWa6RH/idFEqa0LPz0JkVOrQ7Dcp02vne5PHI4a+zYRBcWDi4mpffP1MB0f4HB
 EmuyikTd1fyvaCDzIwDfiLm0lNxy+rirHbqfgt+BNOv4u9H/t0N0+PVUjjskbh3xH7
 CK7k4wQmkzDIl6l5j5LDOK75p3bHkjGZpC/wD9gfmwrFgm1CNkpN/6KRvYsZFyypK7
 W7N91JUTBOsTA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 19B2E1BAA14;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id AC9853DEA63;
 Wed, 24 Jun 2026 16:33:27 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 098/107] hw/9pfs: reject . and .. in Twstat rename
Date: Wed, 24 Jun 2026 16:31:43 +0300
Message-ID: <20260624133301.403266-98-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

The other Trename and Trenameat handlers already reject "." and ".."
as new name on rename requests by returning -EISDIR in this case.

The legacy Twstat rename handler is missing this validation. While passing
"." or ".." does not trigger a crash as fixed by the previous patch (since
the fs backend driver's system calls handle these gracefully), it creates
a behavioral inconsistency, as it is semantically meaningless to rename a
file to a directory reference in the first place.

Fix this by rejecting "." and ".." in Twstat rename handler with -EISDIR
to match behavior of Trename and Trenameat handlers.

Fixes: 8cf89e007a ("virtio-9p: Add P9_TWSTAT support")
Link: https://lore.kernel.org/qemu-devel/662333331d371c6c343c8091161de8eaa121880e.1780072238.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 08750e31fcdccf5352dc3b44475ed5ba6bc80221)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index f84698bfcc..936e4e9349 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3642,6 +3642,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
             err = -ENOENT;
             goto out;
         }
+        if (!strcmp(".", v9stat.name.data) || !strcmp("..", v9stat.name.data)) {
+            err = -EISDIR;
+            goto out;
+        }
 
         v9fs_path_write_lock(s);
         err = v9fs_complete_rename(pdu, fidp, -1, &v9stat.name);
-- 
2.47.3


