Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5A1E7FDC7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzuw-00045q-6t; Mon, 02 Feb 2026 14:49:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzut-0003tF-JM; Mon, 02 Feb 2026 14:48:59 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzus-0003TU-1M; Mon, 02 Feb 2026 14:48:59 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B3D761850AF;
 Mon, 02 Feb 2026 22:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6704935B291;
 Mon, 02 Feb 2026 22:46:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Lugg <mlugg@mlugg.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 29/69] linux-user: fix reserved_va page leak in
 do_munmap
Date: Mon,  2 Feb 2026 22:45:52 +0300
Message-ID: <20260202194638.939438-29-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Matthew Lugg <mlugg@mlugg.co.uk>

The old logic had an off-by-one bug. For instance, assuming 4k pages on
host and guest, if 'len' is '4097' (indicating to unmap 2 pages), then
'last = start + 4096', so 'real_last = start + 4095', so ultimately
'real_len = 4096'. I do not believe this could cause any observable bugs
in guests, because `target_munmap` page-aligns the length it passes in.
However, calls to this function in `target_mremap` do not page-align the
length, so those calls could "drop" pages, leading to a part of the
reserved region becoming unmapped. At worst, a host allocation could get
mapped into that hole, then clobbered by a new guest mapping.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-4-mlugg@mlugg.co.uk>
(cherry picked from commit 81ceab30492ed251addae8539f7b69a069b0f984)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index dc28470054..568538d833 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1027,9 +1027,9 @@ static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
     void *host_start;
     int prot;
 
-    last = start + len - 1;
+    last = ROUND_UP(start + len, TARGET_PAGE_SIZE) - 1;
     real_start = start & -host_page_size;
-    real_last = ROUND_UP(last, host_page_size) - 1;
+    real_last = ROUND_UP(last + 1, host_page_size) - 1;
 
     /*
      * If guest pages remain on the first or last host pages,
-- 
2.47.3


