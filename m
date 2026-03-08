Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11617EA853F
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHyQ-0004lJ-8G; Sun, 08 Mar 2026 13:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHxA-0003mP-VB
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:14 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzHx7-0003pN-HF
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:30:08 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 72ACE44099;
 Sun,  8 Mar 2026 17:30:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90CCCC116C6;
 Sun,  8 Mar 2026 17:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772991000;
 bh=cXfFHAsd3SNFbK+y4uunPJeG053eQtIxwzALDggDNXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=d8NFl0DUgs4AI8pT3FP4SPFqSa4Lcqdr7Iybg3u2I5xWEhKmrbCgtPVcS2vgXiERj
 cvGiD7uDLurfPcdcTE8712x5PMcG8GzjQTVSELn5xjJiz9HyH3b/kQOIxWgoCxrN0j
 PytY58D9PURBmTMczPKHSAt2pcnFGir9jWYQM4mIh30j7Uz759rgXjR9uc64MJUVcV
 lAFT5X/qffhem5sIHcxo+1QjMXiwZKyJjjdhssYMEyMsi+94c1oANV956C0Jkqsiay
 eieyqubP2GKh4WP526eOehVKGmBdC3DPces1Iw4eaRosUcdEzrxRiytRNWM+4XVmkl
 nJ2YD3p0hQGEQ==
From: deller@kernel.org
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 deller@gmx.de, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/12] linux-user: Deal with mmap where start > reserved_va
Date: Sun,  8 Mar 2026 18:29:32 +0100
Message-ID: <20260308172936.2835-9-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260308172936.2835-1-deller@kernel.org>
References: <20260308172936.2835-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.234.252.31; envelope-from=deller@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


