Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B910E7FDCD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 19:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmzus-0003kH-IT; Mon, 02 Feb 2026 14:48:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzur-0003fq-Ik; Mon, 02 Feb 2026 14:48:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1vmzup-0003Sg-Qb; Mon, 02 Feb 2026 14:48:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A57121850AE;
 Mon, 02 Feb 2026 22:46:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 56C5735B290;
 Mon, 02 Feb 2026 22:46:46 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Matthew Lugg <mlugg@mlugg.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.8 28/69] linux-user: fix mremap errors for invalid ranges
Date: Mon,  2 Feb 2026 22:45:51 +0300
Message-ID: <20260202194638.939438-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
References: <qemu-stable-10.0.8-20260202173053@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Matthew Lugg <mlugg@mlugg.co.uk>

If an address range given to `mremap` is invalid (exceeds addressing
bounds on the guest), we were previously returning `ENOMEM`, which is
not correct. The manpage and the Linux kernel implementation both agree
that if `old_addr`/`old_size` refer to an invalid address, `EFAULT` is
returned, and if `new_addr`/`new_size` refer to an invalid address,
`EINVAL` is returned.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251117170954.31451-3-mlugg@mlugg.co.uk>
(cherry picked from commit 2422884ec5a12037d2378f45ca1411d3f37c7081)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 703f8ca3cd..dc28470054 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1108,12 +1108,15 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     int prot;
     void *host_addr;
 
-    if (!guest_range_valid_untagged(old_addr, old_size) ||
-        ((flags & MREMAP_FIXED) &&
+    if (((flags & MREMAP_FIXED) &&
          !guest_range_valid_untagged(new_addr, new_size)) ||
         ((flags & MREMAP_MAYMOVE) == 0 &&
          !guest_range_valid_untagged(old_addr, new_size))) {
-        errno = ENOMEM;
+        errno = EINVAL;
+        return -1;
+    }
+    if (!guest_range_valid_untagged(old_addr, old_size)) {
+        errno = EFAULT;
         return -1;
     }
 
-- 
2.47.3


