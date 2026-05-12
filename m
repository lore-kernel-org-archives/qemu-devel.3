Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C61CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuIy-0005Gg-9W; Tue, 12 May 2026 17:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIh-0004yU-Qz; Tue, 12 May 2026 17:06:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIf-0001HW-GI; Tue, 12 May 2026 17:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619299; bh=YrXr0kbYOsSM0k0PKXm+uH1Ie1ylPTpGPRFLbpDSZW0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=SKJAfrk0LmbpnsDwdOv9Sq7M3ciNpterir/+XiG1JbJ6MpKS5FCllQ2InzCoQvt5t
 a/CTyXV6jFe6ilVqinD5scOZNvF0lrP6UJMr5jmKPP4YAyyFqP07VJhnjuwpy5Ufu7
 7kxEFyElDbggP6ZWPfAdpo6rz5dzgi8oD4zfjnqk1lCrM+cf6M5Wg1cjZ8m8lm6FF1
 +IxRDWXBpR7hi7T2oGxwE6btHBuHC7XQVaRRybxw/WlErQl862BDNdWkYJ6Mk2mqSM
 azLNthViVX6vi/jPa9LPaqj7XtxnovFnjonXm8fVnJ/7KVJPhbZr1WV6onDaH9OGH8
 s/sJMLdx7Rqkw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E8AF11AA33F;
 Tue, 12 May 2026 23:54:59 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 00C923ABCB0;
 Tue, 12 May 2026 23:55:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Razvan Ghiorghe <razvanghiorghe16@gmail.com>,
 Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 003/117] linux-user: fix mremap with old_size=0 for
 shared mappings
Date: Tue, 12 May 2026 23:53:05 +0300
Message-ID: <20260512205503.361097-3-mjt@tls.msk.ru>
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
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 281082c2d0..502f582f97 100644
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
2.47.3


