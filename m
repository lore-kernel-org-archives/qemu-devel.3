Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CABB106ACE7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mOo-0004eC-6J; Thu, 12 Mar 2026 16:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w0mOl-0004ah-1X
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:12:47 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w0mOj-0006Xv-9S
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:12:46 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D4DD460142;
 Thu, 12 Mar 2026 20:12:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FA7C4CEF7;
 Thu, 12 Mar 2026 20:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773346363;
 bh=V3pKuIKReYWC1E9/VW0Lj3lZ20wq73KCxdtWeUT2TXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ig5by/RELUZYxcJT8E/V8v//5SMdmMCR39/uKpv+qeLw/UpsnK4m+m8JvfNNe4sym
 /bU/ewwfifGTzfd0y4He6v03AjCL/FtH4vFw3FL9/APqkRS7ZzLt81xtwwjSLfTqio
 Qfj1WzId1Oizv9cz9r86uIvplizR6kl+5Vo4izjqf27KK1S1r/Uj6tttcqyz72ExYs
 rqHuNaBbtlsEsgBkFY2vFwbnLLGsamjc7b4llvEVLBX+vBFUPbc0cpIOslZyavXub7
 PIcXjsfs42CUcpPkaBKtDFuzC/2DSVzTARDJb3sMPuhKl41BBfrsl6yXogtrALdcpe
 l+8ZIEz2D7lHQ==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 1/2] linux-user: Fix zero_bss for RX PT_LOAD segments
Date: Thu, 12 Mar 2026 21:12:38 +0100
Message-ID: <20260312201239.2976-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201239.2976-1-deller@kernel.org>
References: <20260312201239.2976-1-deller@kernel.org>
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

From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>

zero_bss() incorrectly assumed that any PT_LOAD containing .bss must be
writable, rejecting valid ELF binaries where .bss overlaps the tail of
an RX file-backed page.

Instead of failing, temporarily enable write access on the overlapping
page to zero the fractional bss range, then restore the original page
permissions once initialization is complete.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3179
Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 linux-user/elfload.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 35471c0c9a..59b543f740 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -449,12 +449,6 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
 {
     abi_ulong align_bss;
 
-    /* We only expect writable bss; the code segment shouldn't need this. */
-    if (!(prot & PROT_WRITE)) {
-        error_setg(errp, "PT_LOAD with non-writable bss");
-        return false;
-    }
-
     align_bss = TARGET_PAGE_ALIGN(start_bss);
     end_bss = TARGET_PAGE_ALIGN(end_bss);
 
@@ -472,20 +466,35 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
              */
             align_bss -= TARGET_PAGE_SIZE;
         } else {
+            abi_ulong start_page_aligned = start_bss & TARGET_PAGE_MASK;
             /*
-             * The start of the bss shares a page with something.
-             * The only thing that we expect is the data section,
-             * which would already be marked writable.
-             * Overlapping the RX code segment seems malformed.
+             * The logical OR between flags and PAGE_WRITE works because
+             * in include/exec/page-protection.h they are defined as PROT_*
+             * values, matching mprotect().
+             * Temporarily enable write access to zero the fractional bss.
+             * target_mprotect() handles TB invalidation if needed.
              */
             if (!(flags & PAGE_WRITE)) {
-                error_setg(errp, "PT_LOAD with bss overlapping "
-                           "non-writable page");
-                return false;
+                if (target_mprotect(start_page_aligned,
+                                    TARGET_PAGE_SIZE,
+                                    prot | PAGE_WRITE) == -1) {
+                    error_setg_errno(errp, errno,
+                                    "Error enabling write access for bss");
+                    return false;
+                }
             }
 
-            /* The page is already mapped and writable. */
+            /* The page is already mapped and now guaranteed writable. */
             memset(g2h_untagged(start_bss), 0, align_bss - start_bss);
+
+            if (!(flags & PAGE_WRITE)) {
+                if (target_mprotect(start_page_aligned,
+                                    TARGET_PAGE_SIZE, prot) == -1) {
+                    error_setg_errno(errp, errno,
+                                    "Error restoring bss first permissions");
+                    return false;
+                }
+            }
         }
     }
 
-- 
2.53.0


