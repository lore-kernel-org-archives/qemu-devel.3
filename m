Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68F7CD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:55:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu8r-0004Gx-Pt; Tue, 12 May 2026 16:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu8A-0003uO-0I; Tue, 12 May 2026 16:55:06 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu87-0002mu-D6; Tue, 12 May 2026 16:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619273; bh=oVpMHYrOe1hVRsgnmvIQkNX6E8D9+i02immjOp//NHw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g9g/gS1e3A3x40d5LuX8m7TJ6GhAhIsMXPLe2iC+LQaR7WpLg/HeFbHIk6ctcy0dS
 iVGYUZRp90sLCr82wbU2TLjQommuh37ZRStP2k9Jv9LQ3EfmWrM3/7Y0f09+hhahLg
 PCsLqQr+BqM60a6D8VzqLzgbSzwic5yq5jlrgW4cHQ8+MgnfFfaFn3OdcEu8KGs59G
 WnB1jMsBVxP1Eps9hmVa/zCUtC1VJbCAxq4G+IsUXJm0YssHURqC4GOWnYEqYtqmHF
 Kucj4l5mh5eJAmMq3houUvWgTdee+dciuYTGR7GlmkZa5DmZHTtiSxKX1GUzXxwFUm
 PGPz4QGc4yrow==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 77F5B1AA2CE;
 Tue, 12 May 2026 23:54:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8369A3ABC3F;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 002/107] linux-user: Fix zero_bss for RX PT_LOAD
 segments
Date: Tue, 12 May 2026 23:52:49 +0300
Message-ID: <20260512205437.360850-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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
(cherry picked from commit 2ff529c6f64b706213339d4bbce76c7788243ddb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fa83d78667..0f05db4715 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -2377,12 +2377,6 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
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
 
@@ -2400,20 +2394,35 @@ static bool zero_bss(abi_ulong start_bss, abi_ulong end_bss,
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
2.47.3


