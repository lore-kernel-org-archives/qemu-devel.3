Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 163CFCD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuJ1-0005iM-BU; Tue, 12 May 2026 17:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIj-00055D-Ne; Tue, 12 May 2026 17:06:04 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIg-0000wz-4F; Tue, 12 May 2026 17:06:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619299; bh=wKBCypXp1HQfvmuaKMS70Qh0AHVEyfZLIzqR2UKu/YI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DwhzBi3JJC3Z99HMOsekgttnWSTyb5ZWN6s90KIwwGHojqS/sVy7FVq3hrJ4LlyBd
 oBBq2g4RNeK1yVLPLd+XFMjWQ2XqGekWgqkkIGBrPdY9+pYh0KWKYvAvpD6rTk14lW
 04tSHukL22hs4Yb3R3cO9UHt+rCTjFSevmK50p44HfYxI5qSQ3AwTIsh2P4NwIc8L9
 LsMfhuXCMdHHWj10/Y+Uflwq6q69R6FrTRh5Q/AdO1aABCr9s9qgspfel1rcnPozU4
 uQA1UzQzgS9R37PXAUh94OHwCuz7U7CajsyDqPWOslCFEUNBRlmimyzOxzfxW6Rdja
 lEHAXhtTc22ZA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D91621AA33D;
 Tue, 12 May 2026 23:54:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id E61133ABCAF;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 002/117] linux-user: Fix zero_bss for RX PT_LOAD
 segments
Date: Tue, 12 May 2026 23:53:04 +0300
Message-ID: <20260512205503.361097-2-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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
2.47.3


