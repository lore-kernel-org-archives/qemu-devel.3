Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C0C9112583F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:09:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LAC-0004qa-Ml; Wed, 11 Mar 2026 11:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8F-00028F-T8; Wed, 11 Mar 2026 11:05:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0L8A-0004hb-Sz; Wed, 11 Mar 2026 11:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241306; bh=ey24FL2WtAviVBhBLUavUi+PlzeDOpL1ByagnJYcMNE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A0Q2uoUrbla+iq8h9xtCXt9Hw6dvdf91O/AYeO7VGEJnOEIweJrXO/DuvJ1RLf76B
 G4OLMru7Bw/157H/3iJBIRZ8MoG00G36W6mCHp5VVRjG7Ffu0iqHyGnAzs8iKq9+hs
 8mm84XsfYi9nOvhaEyonvqdF9buJZiqQ86Jj3AI9CuKRPmc3j9XSx/gZHM/TNoThbO
 nF8ntBzTuFNQBUztrZLuMKyxWkzqwmBtM66NBqk1uuCGGNAHF4LJTpaSOqChxjsd0z
 Y3dNuTrvdhSlNcWy2bWUzZ+8DQBgWCnF+S2TVHo7PHVxWwFU30Xtmd3CFyG0YGNDdn
 tpfNDd7EBB9NQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1969E191E64;
 Wed, 11 Mar 2026 18:01:46 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 07EC937C2B6;
 Wed, 11 Mar 2026 18:02:24 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bingwu Zhang <xtex@astrafall.org>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.9 38/44] linux-user: Deal with mmap where start >
 reserved_va
Date: Wed, 11 Mar 2026 18:02:10 +0300
Message-ID: <20260311150221.1084186-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
References: <qemu-stable-10.0.9-20260311180113@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Bingwu Zhang <xtex@astrafall.org>

Fixes: 4c13048e02d9 ("linux-user: Use page_find_range_empty for mmap_find_vma_reserved")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3310
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit f2813e13fe910e01127271a87177a477b9438bc6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 568538d833..5622a01123 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -417,12 +417,15 @@ abi_ulong mmap_next_start;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong align)
 {
-    target_ulong ret;
+    target_ulong ret = -1;
 
-    ret = page_find_range_empty(start, reserved_va, size, align);
+    if (start <= reserved_va) {
+        ret = page_find_range_empty(start, reserved_va, size, align);
+    }
     if (ret == -1 && start > mmap_min_addr) {
         /* Restart at the beginning of the address space. */
-        ret = page_find_range_empty(mmap_min_addr, start - 1, size, align);
+        ret = page_find_range_empty(mmap_min_addr, MIN(start - 1, reserved_va),
+                                    size, align);
     }
 
     return ret;
-- 
2.47.3


