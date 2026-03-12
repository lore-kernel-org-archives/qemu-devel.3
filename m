Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135EB106ACE4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 20:13:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0mOq-0004fk-Bk; Thu, 12 Mar 2026 16:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w0mOm-0004dU-LQ
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:12:48 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1w0mOk-0006Yl-Po
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 16:12:48 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0605E42A5C;
 Thu, 12 Mar 2026 20:12:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04754C4CEF7;
 Thu, 12 Mar 2026 20:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773346364;
 bh=IoVriGbsFQSGgBcb5APt3WGdcnQHDFn1QXcp46ncTuE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Q9fLDkMcuX6XPLFxOOMYKrUoPgUHnIoWmpCArRmJDHaPDAi9581FqFj3im3mfpcv/
 GHVc6bY1tdMxXLmNvTGi8bvyhRCJ4/r0ai/9qMQTFbhF8BJnVcwSlSPscbPx0tlzOW
 XoL56+nQm+2GRckRbekalF3SlpmmNwgHKpPqZnHQx+LNQuBj8k5ckk1DotpxqzUgfu
 8L6P1cpUiYPfOblZuFY23Tv0FIIcXzO2xSCrFVMStJ/Ux9iFzahs5YQNMxwHgU7Sza
 4Y6S2QUUIYqGgus5fUrPoEj8IGTnCsXbisOwW7waHlCc+fLH8x3xCT30xc4SpZvB4y
 y4hpfNYhCOFCg==
From: Helge Deller <deller@kernel.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
	Helge Deller <deller@gmx.de>
Subject: [PATCH 2/2] linux-user: fix mremap with old_size=0 for shared mappings
Date: Thu, 12 Mar 2026 21:12:39 +0100
Message-ID: <20260312201239.2976-3-deller@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201239.2976-1-deller@kernel.org>
References: <20260312201239.2976-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=deller@kernel.org; helo=sea.source.kernel.org
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
---
 linux-user/mmap.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 76978a56a8..b635b6a21c 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1120,6 +1120,58 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
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
+                       prot | PAGE_VALID, PAGE_VALID);
+        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
+        mmap_unlock();
+        return new_addr;
+    }
+
     if (!guest_range_valid_untagged(old_addr, old_size)) {
         errno = EFAULT;
         return -1;
-- 
2.53.0


