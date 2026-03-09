Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E8CDF3C25E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxg-00044e-65; Mon, 09 Mar 2026 09:47:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxU-0003yS-3p
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxO-00067a-4E
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:43 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 553FD60133
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878A0C4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064040;
 bh=cXfFHAsd3SNFbK+y4uunPJeG053eQtIxwzALDggDNXs=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=PaZz+4xRKovKrJNw93Yh6/h1gR0Rxwd5XbY1Gd8TxFm/+ZYQKXdccRM2fc3eSamo6
 QjZ31uG/fqJGY6MArpahIFwybOaHQTbQbuajPEKrNAleUx4H/ujVPrs2JfDVX7x+HZ
 PqbDXPOBGaZLqByB6VjAjJIZ7th86yus61aQ3HdAxkjVC7qCMf5OGr8pSyOLcU1FgN
 m5FRT1TXbW4BXuA6jkSfgT80G2awcRM9t153+AheXhTyooanYHJX0VXkUg8a4mPY4Z
 pSY+xfn4isDhmg9rLU9bTWURBlOrZJX686QslAlKit3mL4eiGMpPmeGA24MldD1G3H
 gPcde9N7ZduQg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/10] linux-user: Deal with mmap where start > reserved_va
Date: Mon,  9 Mar 2026 14:47:07 +0100
Message-ID: <20260309134711.5312-7-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bingwu Zhang <xtex@astrafall.org>

Fixes: 4c13048e02d9 ("linux-user: Use page_find_range_empty for mmap_find_vma_reserved")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3310
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/mmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 07175e11d5..76978a56a8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -423,12 +423,15 @@ abi_ulong mmap_next_start;
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
2.53.0


