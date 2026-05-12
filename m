Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE0FCD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu8k-00047p-2y; Tue, 12 May 2026 16:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu89-0003uB-2n; Tue, 12 May 2026 16:55:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu86-0002mt-SD; Tue, 12 May 2026 16:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619273; bh=2UUgR8FXm+KpvO3CMsyF0r3dDsABIBfClWVOSx0Yxl8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FTBdBAuqdV4qwvoTMdKRvxVxMamiSAcAuE0gzvB07Mol/Tk/v60iDlG4aUOF+2JI4
 bdHNP4wqjzcflSKP7pmy40th0BD0yZMEtCqPWOmgoiYzKbSB6iu43HxuKlcC9o+4SV
 pp3MYOtDP+aSxNhOxRD40RzwvMav1zw9ORixGAbpDtDlT9R1JwYz7Cww5mbQhMuahR
 jVnPbd0DD8rI9dwyGDVuxGGXjww6G2pFlrZb37sFgw4/Ov575RA8XHrpL4itGEVYcn
 VtW8oSevub/toWnQsrGBke0dwUXxz9/ja/ptEC8ISJuTYMdo4354QgoLxSqdfxAIPX
 RBhntCB1y4AJQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8881C1AA2CF;
 Tue, 12 May 2026 23:54:33 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 93F4D3ABC40;
 Tue, 12 May 2026 23:54:37 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 003/107] linux-user: fix mremap with old_size=0 for
 shared mappings
Date: Tue, 12 May 2026 23:52:50 +0300
Message-ID: <20260512205437.360850-3-mjt@tls.msk.ru>
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

When old_size is zero and old_address refers to a shareable mapping,
mremap() should create a new mapping of the same pages according to the
mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this case.

Previously, QEMU's target_mremap() rejected this valid case with EFAULT
during the initial validation, before checking for the special
old_size == 0 behaviour.

This patch adds proper handling for old_size == 0:
- Validates that MREMAP_MAYMOVE flag is set (required by man spec)
- Passes the call through to the host mremap()
- Creates a new mapping without invalidating the original, with both
  being valid and sharing the same physical memory frames.
- Ensures the new mapping address falls within the valid guest address
  region before returning it to the guest.

Tested with the reproducer from the issue on qemu-riscv64, qemu-hppa,
and qemu-aarch64.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Helge Deller <deller@gmx.de>
Signed-off-by: Helge Deller <deller@gmx.de>
(cherry picked from commit 5e5b278d2b1b81fc2b5ca09dba4848f81cd3a718)
(mjt, rth: backport to pre-f55fc1c092
 "accel/tcg: Add clear_flags argument to page_set_flags")
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 5622a01123..230bc2c094 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1118,6 +1118,58 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         errno = EINVAL;
         return -1;
     }
+
+    if (!old_size) {
+        if (!(flags & MREMAP_MAYMOVE)) {
+            errno = EINVAL;
+            return -1;
+        }
+        mmap_lock();
+        if (flags & MREMAP_FIXED) {
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags, g2h_untagged(new_addr));
+        } else {
+            /*
+             * We ensure that the new mapping stands in the
+             * region of guest mappable addresses.
+             */
+            abi_ulong mmap_start;
+
+            mmap_start = mmap_find_vma(0, new_size, TARGET_PAGE_SIZE);
+
+            if (mmap_start == -1) {
+                errno = ENOMEM;
+                mmap_unlock();
+                return -1;
+            }
+
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags | MREMAP_FIXED, g2h_untagged(mmap_start));
+
+            new_addr = mmap_start;
+        }
+
+        if (host_addr == MAP_FAILED) {
+            mmap_unlock();
+            return -1;
+        }
+
+        if (flags & MREMAP_FIXED) {
+            new_addr = h2g(host_addr);
+        }
+
+        prot = page_get_flags(old_addr);
+        /*
+         * For old_size zero, there is nothing to clear at old_addr.
+         * Only set the flags for the new mapping. They both are valid.
+         */
+        page_set_flags(new_addr, new_addr + new_size - 1,
+                       prot | PAGE_VALID | PAGE_RESET);
+        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
+        mmap_unlock();
+        return new_addr;
+    }
+
     if (!guest_range_valid_untagged(old_addr, old_size)) {
         errno = EFAULT;
         return -1;
-- 
2.47.3


