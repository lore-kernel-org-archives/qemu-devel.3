Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCECC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAT8-0004ek-DR; Wed, 12 Aug 2026 11:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARi-00043m-5M; Wed, 12 Aug 2026 11:00:46 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARf-00029v-Tj; Wed, 12 Aug 2026 11:00:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=nvtJA9ypj+ZhaPi7pd3T2HSZCjIPTUVsDO+Hbgm5n4U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ozHoCpmdaKXmkgDjBrcKFHYCv3YBf5MKLf0XW6Klf1D7h1aBy3fyPwjpByu7VIzUH
 tIlS+EUKlRGZXklo4F3rDXWiWpBB2e709RHeScSfN7ag1bOUSIUxDJOoe43OCRBFaH
 jjgTzEknKJ/Bjqnp8W900Rl3kTIcQqI2jnlC1nBxZf3L7yqhLG6Mb0wJ4UC9vOOoW6
 NFtkHtrNFNqFfyxkJfxVQdAPzom0o4SUV2m+kf8tORR+UpbXq3ZXVM17YWAVz5Fb4r
 LeI2RldqgRtsYuAf6VpddHCS+TfiWiKPlM6HlHYqu+eOU4oYRxvQvx0kuZiA6k2394
 VROshs0dxMaFQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A1B091CA66A;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 08576409DAF;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 673D52FA2F; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 102/120] block/export/fuse: fix regression with
 O_TRUNC when export is not growable
Date: Wed, 12 Aug 2026 17:49:25 +0300
Message-ID: <20260812144955.649205-102-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Fiona Ebner <f.ebner@proxmox.com>

Before commit a94a1d7699 ("fuse: Manually process requests (without
libfuse)"), the O_TRUNC flag when open()-ing an export would be
ignored. This is because libfuse sets FUSE_CAP_ATOMIC_O_TRUNC, so the
kernel lets user space handle the O_TRUNC flag, which is ignored by
the fuse code for export. After the commit, FUSE_CAP_ATOMIC_O_TRUNC is
not set anymore, so the O_TRUNC flag is handled by the kernel, which
executes a truncate.

For blockdev-based exports, this causes a regression, because opening
with O_TRUNC would previously work, but results in an ENOTSUP after
commit a94a1d7699. For file-based exports, the fact that truncate is
executed can be considered an improvement in general. However, in
combination with growable=off, this still results in a practical
regression in combination with virt-fw-vars, which opens its output
file with O_TRUNC and previously worked with a file-based export with
growable=off. After commit a94a1d7699, the file is truncated upon open
and then cannot grow, meaning virt-fw-vars won't be able to write the
output.

To fix these regressions, while keeping the improved behavior for
file-based exports with growable=on, set the FUSE_CAP_ATOMIC_O_TRUNC
flag again if growable=off.

Cc: qemu-stable@nongnu.org
Fixes: a94a1d7699 ("fuse: Manually process requests (without libfuse)")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Message-ID: <20260702132256.661429-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b9ad1c4396e7eb376f0f8dc7d20538980cfa08f2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/export/fuse.c b/block/export/fuse.c
index c0e8dfb6430..9ae22a2e003 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -859,6 +859,18 @@ fuse_co_init(FuseExport *exp, struct fuse_init_out *out,
     uint32_t supported_flags = FUSE_ASYNC_READ | FUSE_ASYNC_DIO;
     uint32_t flags2 = 0;
 
+    if (!exp->growable) {
+        /*
+         * Back when libfuse was used, it would always set this flag and thus
+         * the kernel did not execute a truncate itself and passed along O_TRUNC
+         * to user space. Continue setting the flag for backwards compatibility
+         * when the export is not growable to avoid issues with O_TRUNC, i.e.
+         * blockdev-based exports running into ENOTSUP and file-based exports
+         * with growable=off to be truncated and then stuck with size 0.
+         */
+        supported_flags = FUSE_ATOMIC_O_TRUNC;
+    }
+
     if (in->major != 7) {
         error_report("FUSE major version mismatch: We have 7, but kernel has %"
                      PRIu32, in->major);
-- 
2.47.3


