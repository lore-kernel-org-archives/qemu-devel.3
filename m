Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCBC8C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:07:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiflv-0006uI-6i; Sat, 11 Jul 2026 18:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflt-0006r9-29; Sat, 11 Jul 2026 18:02:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflm-0008KK-Kl; Sat, 11 Jul 2026 18:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=nlwJLEgIZohsUuXj8fvaTL3TA7wDnojjwiNrHTniPRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Noqmqo/jRySHM5kP5L1mUz13yzEgRS8cOfy/XeszkfmJy5mth+ppA4lZ4OsGYZLgR
 uyhQeJV+0C8YfpEgHtYYTL+d95G5iHOu53B2IN8GhLzNTkl3eb7QCuTWU4bawUGL+3
 ZV0+JmxkntR3btk4wYALGJhPhyPD4gYEfKsmKCYAA3At2C3jXEWTn12W30sJJRBHZg
 pB2rNUbI/zVVfdhGh61q7ZWbwKvDzmpNdXkS8N0jJ+RNpnAqQHHW2YNbNOH1GWFN9U
 H1vUwWdqo0dNSG5mmkDDEpmMOzCFHX97VwOIewSs0KWIOEaEOJsTx2LjKL0dgWk5Up
 HUlYp07Y2cCAA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A99321C0AA5;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 60AD93EAF30;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7257013317; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 26/81] hw/9pfs/local: harden local_fid_fd() on FID
 types
Date: Sun, 12 Jul 2026 00:58:04 +0300
Message-ID: <20260711215904.3757-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
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

Link: https://lore.kernel.org/qemu-devel/531f6b81bc1bf1a48c3d4afaa60a65db10511041.1781621428.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 75893c058b21d87d1ec66bbd4e8bf84e1fd616d1)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4708e170a42..ee592b62f81 100644
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


