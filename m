Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F65A107BCD3
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 18:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w17IJ-0008LQ-TP; Fri, 13 Mar 2026 14:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w17H8-0007c8-0W
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:22 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w17H6-0005SK-27
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 14:30:17 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7F2CE6013C;
 Fri, 13 Mar 2026 18:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6B4C19421;
 Fri, 13 Mar 2026 18:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773426614;
 bh=V3pKuIKReYWC1E9/VW0Lj3lZ20wq73KCxdtWeUT2TXQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Wq4wXKdGRhDQTMTFGly+hNSpnw6IhfNl3dtkIGnOeCd48rXE0yvd3cKuqkD1MQ5in
 Vcbj/gH/rfLSQVYDnfsyowPp8dQChL7BI2kNPu1cWHjdUXvG/bM0XP8nXAM6nKp129
 dB9ETJIVzA7oLebRY7bU/8qiwDELDr8HJQpQUQCexg00DefUMionUw+nCejsBhhQvM
 FHuJsIOiU1hBf2w/MmWG1KKiU4oHl3wF8QUP5bqc0N6YwsRLRw07lmhYmDiAW4ShVB
 hMtcWQsHVQD6FP3x2JjxavZlnHV2eXus8seGi3WZA5+7prT4vgyNPULeIfjB/F+8rT
 p0Vvs5g0qMRJg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>, Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PULL 1/2] linux-user: Fix zero_bss for RX PT_LOAD segments
Date: Fri, 13 Mar 2026 19:30:08 +0100
Message-ID: <20260313183009.34221-2-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260313183009.34221-1-deller@kernel.org>
References: <20260313183009.34221-1-deller@kernel.org>
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


