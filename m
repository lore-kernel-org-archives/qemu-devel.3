Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9FC4F3C25E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 13:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzaxf-00044O-HT; Mon, 09 Mar 2026 09:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxR-0003yF-D6
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:47 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1vzaxO-00067f-3l
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 09:47:40 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 449AD60138
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76C38C4CEF7
 for <qemu-devel@nongnu.org>; Mon,  9 Mar 2026 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773064041;
 bh=OOKfroUsa/NmmKFDrQXJY1cwDi1GkvGCyavkONtRuAE=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=K/rF7XCpESpCNBglvm7BsBgBvETTZmym5zkVmL6+ucGoJZglZfQlHMRDTJrs1c/FT
 A8U+Jfn7QR1tOzZpPJRTyEAgNGZXzaXwnqmPdYQLdqFhk9Bm+vgO3+kD/DO/nB5KUI
 KRd3M3N7JEjpMgr7KT7/SPOA0ijtA1pFHwx5/lwWfMOKLux4L4QW9lu6pFIc64DNsw
 vU+gNy/jw29uq+MQKjsQ2yA2qDDc+HghMfvU39G87Z7jGoR2IalcEojBS1KEjxXgmb
 laIS9Hrk6Oknqq4IPIw/Kdj57QlFFEZKXyZRbSoxPHemuXjEchz/T0NS1J4v/yVM/o
 10u6T3gHPG92g==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/10] bsd-user: Deal with mmap where start > reserved_va
Date: Mon,  9 Mar 2026 14:47:08 +0100
Message-ID: <20260309134711.5312-8-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309134711.5312-1-deller@kernel.org>
References: <20260309134711.5312-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=deller@kernel.org;
 helo=tor.source.kernel.org
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

Fixes: f12294b5bd21 ("bsd-user: Use page_find_range_empty for mmap_find_vma_reserved")
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 bsd-user/mmap.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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
2.53.0


