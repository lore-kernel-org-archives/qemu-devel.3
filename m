Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14831C43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:04:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiflT-0005YA-QR; Sat, 11 Jul 2026 18:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflS-0005VO-Cj; Sat, 11 Jul 2026 18:01:38 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wiflQ-0008Jw-KW; Sat, 11 Jul 2026 18:01:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=ZFfgkNxlWufqHUICXktaiqzClipERZQRiCv3/dePY2M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=d61ww69yuhtqmsZpmYANj1f08zQUnxRW4KQtlJbwxMVdvZc4CGmfY/6rFmTi0KJip
 CNrHMN6fMQFHs/TBeOCni5yUkh8N4fKWqxUl3z+hzyDOOQJKnGpZDan4DSKgYcQNF5
 5t+skWX9s+W7/UDIJCB1aStu2PaVPFDaPgLvst/QWP8P2jjsqcg22t+szJGzzThuJ2
 QZIDnK+xB6iKNYMYCgRfrtuLUxKR0Mp7OQraHFHzI1AUurS6jDn7Zh41XwiIyWuIaB
 roRAhZ70yUKVzsy/gjGxgSwi7dlf1e9jrHAmJF0YgGbDeEL7OCi8k4vuLKWqsofNLT
 DaOdp0vUIeKnA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A3BBB1C0AA4;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 59E123EAF2F;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 7025E13315; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 25/81] hw/9pfs: fix invalid union access by
 v9fs_co_fstat()
Date: Sun, 12 Jul 2026 00:58:03 +0300
Message-ID: <20260711215904.3757-25-mjt@tls.msk.ru>
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

Fix this in v9fs_lock() and v9fs_getlock() by checking if FID has a valid
file descriptor before calling v9fs_co_fstat().

Fixes: 10b468bdc533 ("virtio-9p: Implement TXATTRCREATE")
Link: https://lore.kernel.org/qemu-devel/4b33cd1aaa2551efda220a6f651e3660d27f4746.1781621428.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit c3aa2491cd2cd89e2f484d32f323ee447e782984)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 162cd6e6486..85565a014e3 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3925,6 +3925,10 @@ static void coroutine_fn v9fs_lock(void *opaque)
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
@@ -3970,6 +3974,10 @@ static void coroutine_fn v9fs_getlock(void *opaque)
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


