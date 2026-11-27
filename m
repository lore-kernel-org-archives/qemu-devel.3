Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2489606A31E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=KiT27DmF
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWp96-0002Tz-5h; Fri, 27 Nov 2026 01:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8m-00006C-0J; Fri, 27 Nov 2026 01:09:00 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWp8j-0001oq-PF; Fri, 27 Nov 2026 01:08:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795759048; bh=KnOJnLy9SNFeLjJPSdFW0RUrr3Q2FmiydDZKQufxSiY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KiT27DmFb/iUcN9aD8fBkSshzA0D3DPDv93i8XwVk794mGzYqS8R2gL1a+NisqjSS
 oFNKKdBrAaKc34w+iuyTLzrX2GDXvZf0deqgUlGFPsbRGReNyoUB7KEMKIQ2wSTnc2
 b36BtqKiMuBBecAVvndXLk2Q+BDCF4hTtY/pS8TsACDTwbd7mKsPX0depWWb7XcI3E
 fgvfMxBr7OTlzKLDlahP+QIV/APwW0kKmjcdAYm61OizC2ylJ3hwbILFZdfOgN1WfR
 Hsc42vYDjyHnhzkNHf060RPshteIir012GkFPiB92f0YrP70oQZc8JWUo+fu8CIY35
 bvxbV8vwyBKGQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4E3491EA371;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4C35746999C;
 Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 22EC7CF330; Fri, 27 Nov 2026 08:57:28 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.4 v2 127/152] hw/nvme: bound zrwa flush by the write
 area and zone write boundary
Date: Fri, 27 Nov 2026 08:54:25 +0300
Message-ID: <20261127055709.39630-64-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
References: <qemu-stable-11.1.4-20261127085309@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Klaus Jensen <k.jensen@samsung.com>

nvme_zone_mgmt_send_zrwa_flush incorrectly accepts a flush up to and
including one LBA past the zone random write area. Fix the comparison.

Additionally, there is no check that the last LBA to be flushed falls
within the zone boundary (i.e., the *capacity* of the zone). That is, if
a zone has a small capacity than size, the write pointer can be pushed
past it. Fix with a check on the zone write boundary.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4520
Fixes: e321b4cdc2dd ("hw/nvme: add support for zoned random write area")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit d31a68f013bf901c29c55d34d756c5fbbdc02657)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index f7973bbc701..36053f5eb86 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4258,7 +4258,8 @@ static uint16_t nvme_zone_mgmt_send_zrwa_flush(NvmeCtrl *n, NvmeZone *zone,
         return NVME_INVALID_FIELD | NVME_DNR;
     }
 
-    if (elba < wp || elba > wp + ns->zns.zrwas) {
+    if (elba < wp || elba >= wp + ns->zns.zrwas ||
+        elba >= nvme_zone_wr_boundary(zone)) {
         return NVME_ZONE_BOUNDARY_ERROR | NVME_DNR;
     }
 
-- 
2.47.3


