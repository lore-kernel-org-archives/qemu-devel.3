Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DD6CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:15:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFrt-0004sV-Tq; Wed, 24 Jun 2026 01:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFro-0004S6-89; Wed, 24 Jun 2026 01:09:40 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFrm-000600-9h; Wed, 24 Jun 2026 01:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277623; bh=p5AEGS3SKxDmRUCLovmzjCXX+arkhlES3my84Wzmvbs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=T8v0d32jdS52TRaLnb9c+V7/2cUr5ngxf6sUZFYOY4hkB0eq8Fhv0TkyWt4rLkDN4
 hHWpugqCKWce3K2VTPppOXEqy9Lt/62TU5TXKxnyoaOmuId0DU7UswJQHxC+O8fiaX
 TsbFeDKGMQq3aYFvPd9ndTIowEUkJYqGeeT5ruesRxYiO8+bLrf/PszmtdtbJSWp4x
 5fbJWwrc0UwHyuCxiQCxg8gjTnqWmJ61l6sBmUrQkxYbvGcSWEJ88xDFyPKSNgWoiQ
 8Gi75I27lo3QF3OSnEO2B0dRPET/aYx62IA3qtAX3k+t/jXWAS8TxuK83OLz/n3WBt
 pVyIh7xtV6fvQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CA2EA1BA675;
 Wed, 24 Jun 2026 08:07:03 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B62B53DDB12;
 Wed, 24 Jun 2026 08:07:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 87/95] hw/9pfs: reject . and .. in Twstat rename
Date: Wed, 24 Jun 2026 08:05:22 +0300
Message-ID: <20260624050541.395079-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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
index 7c65d4f7d1..abc54e169c 100644
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


