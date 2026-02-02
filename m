Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F2EE7FDF7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 22:10:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vn27O-0006Ng-Aj; Mon, 02 Feb 2026 17:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn26H-0004zB-G3; Mon, 02 Feb 2026 17:08:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vn26G-0002c2-39; Mon, 02 Feb 2026 17:08:53 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B6B0C1852B9;
 Tue, 03 Feb 2026 01:07:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8A8D335B3CC;
 Tue, 03 Feb 2026 01:08:16 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Lugg <mlugg@mlugg.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.1 12/56] linux-user: fix mremap unmapping adjacent region
Date: Tue,  3 Feb 2026 01:07:17 +0300
Message-ID: <20260202220805.945271-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
References: <qemu-stable-10.2.1-20260202173336@cover.tls.msk.ru>
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

This typo meant that calls to `mremap` which shrink a mapping by some N
bytes would, when the virtual address space was pre-reserved (e.g.
32-bit guest on 64-bit host), unmap the N bytes following the *original*
mapping.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-2-mlugg@mlugg.co.uk>
(cherry picked from commit aaed9ca1797d70a507371aea688c5cd60b074e2d)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 423c77856a..ef3833a2bb 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1171,7 +1171,8 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                     errno = ENOMEM;
                     host_addr = MAP_FAILED;
                 } else if (reserved_va && old_size > new_size) {
-                    mmap_reserve_or_unmap(old_addr + old_size,
+                    /* Re-reserve pages we just shrunk out of the mapping */
+                    mmap_reserve_or_unmap(old_addr + new_size,
                                           old_size - new_size);
                 }
             }
-- 
2.47.3


