Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8209E1125895
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 19:41:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0POs-0000Zc-Fk; Wed, 11 Mar 2026 15:39:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POn-00006x-OD; Wed, 11 Mar 2026 15:39:17 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0POl-0000gI-DF; Wed, 11 Mar 2026 15:39:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773257669; bh=GJqdBp7FyqpOsMWf0Wl48B99vmu74JoTHJjV5TuchzY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ESZ+29wVdHPNVi0Z0InIO7hw+fJpVPomUSBsMo3KMxwO5zSG6xATOOKvUqih9Rkqi
 CNbVSRrvU/Nm6ySn7sBKPl7dLZ/1VBWbPwWbU5TRgW4fzVNeDIEeGP5akh9HnJfcVT
 OXuPSF8w+FqQm4NWL8emBGqUGiLxSFS7thIOK9gcTGGeo1wXh+KvhovPiJl6V6QORk
 VcRU6WuwcwWgLjMJdQdwKbe3C9C89ZreYllLuyyg6+WRtBXX7KyHmS9cwggMyFgNu7
 OwgNDa4b6O22I8vK4uH2GjQjkmy80G69AoNGgB4nhSL9ZDNlfepz3/V7XViioovu7I
 8hxYcYk1ScDDQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E9F5C192116;
 Wed, 11 Mar 2026 22:34:29 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3813537C47B;
 Wed, 11 Mar 2026 22:35:08 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Bingwu Zhang <xtex@astrafall.org>,
 Helge Deller <deller@gmx.de>, Warner Losh <imp@bsdimp.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.2 46/53] bsd-user: Deal with mmap where start >
 reserved_va
Date: Wed, 11 Mar 2026 22:34:39 +0300
Message-ID: <20260311193449.1096110-46-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
References: <qemu-stable-10.2.2-20260311164242@cover.tls.msk.ru>
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

Fixes: f12294b5bd21 ("bsd-user: Use page_find_range_empty for mmap_find_vma_reserved")
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit e8e7d1f97785be2fd81fc520e0c7b9d228c10a56)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index 24ba1728eb..fe77eceb48 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -258,12 +258,14 @@ abi_ulong mmap_next_start = TASK_UNMAPPED_BASE;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong alignment)
 {
-    abi_ulong ret;
+    abi_ulong ret = -1;
 
-    ret = page_find_range_empty(start, reserved_va, size, alignment);
+    if (start <= reserved_va) {
+        ret = page_find_range_empty(start, reserved_va, size, alignment);
+    }
     if (ret == -1 && start > TARGET_PAGE_SIZE) {
         /* Restart at the beginning of the address space. */
-        ret = page_find_range_empty(TARGET_PAGE_SIZE, start - 1,
+        ret = page_find_range_empty(TARGET_PAGE_SIZE, MIN(start - 1, reserved_va),
                                     size, alignment);
     }
 
-- 
2.47.3


