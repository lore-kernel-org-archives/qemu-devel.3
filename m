Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDC7C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:03:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiflS-0005Va-LO; Sat, 11 Jul 2026 18:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflR-0005Rd-21; Sat, 11 Jul 2026 18:01:37 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflP-0008Ja-3H; Sat, 11 Jul 2026 18:01:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=kKwU2/gwY4uoL79RTPGfSUbSgRquyUwaMfK6S4tVAVk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=H/aXOd6lmwNwbnXFRYESE7G7/3+rAhO/vEI7Avb0/duvsVD5ZX3PKHYVpAp7rhkeC
 JhRwlDfjl+flhropilnUiznByKIEJtItW0qqcNnFt5XrxwR6ORtcyN/vUd6Rcmt7QM
 QGKikfIRbUP1EbmK8XiObuDf2GYrCDovNmPjzH+E+Oq1xAQtTlnJ0oEFe4uhXcscN5
 KBG+srML7qqqqe8UB/yOL4ymc1Ewh62jZTS0iiruLq/b8HpCm3M8sBmCqhsu8lNB3+
 uhgNsB8bedVxUhYHNhfz1yDun6HtbE15ers6WMlAyYXipCqKRy8f7mDiv2GVHAlbcU
 IJhR+f5CTRD4Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9C4F31C0AA3;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 52F463EAF2E;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6DEC113313; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Feifan Qian <bea1e@proton.me>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 24/81] hw/9pfs: fix invalid union access by
 v9fs_co_fsync()
Date: Sun, 12 Jul 2026 00:58:02 +0300
Message-ID: <20260711215904.3757-24-mjt@tls.msk.ru>
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
index 1b064a27fc5..162cd6e6486 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2291,10 +2291,15 @@ static void coroutine_fn v9fs_fsync(void *opaque)
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
@@ -3648,6 +3653,10 @@ static void coroutine_fn v9fs_wstat(void *opaque)
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


