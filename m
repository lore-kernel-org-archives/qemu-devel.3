Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADABBCCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 20:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7g3n-0007Xm-0w; Sat, 11 Oct 2025 16:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1v7fp4-00054i-Ra; Sat, 11 Oct 2025 16:04:10 -0400
Received: from mlugg.co.uk ([2001:19f0:7401:8244:5400:ff:fe24:ff33]
 helo=mail.mlugg.co.uk) by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1v7fox-0006nG-RC; Sat, 11 Oct 2025 16:04:10 -0400
Received: from localhost.localdomain
 (7.1.8.2.8.1.e.f.f.f.e.d.0.b.e.f.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:feb0:deff:fe18:2817])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id A01B035326;
 Sat, 11 Oct 2025 20:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1760213042; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vPQSa7WA7dbzwXbgPnxO0UP9bshojnnbTD+nPr31J0=;
 b=pvjRt9p7kYbW1Y7H3O5PVbUhQkCLh1Wl9sRCsCJe43A3QY3FMwj51uRNMFvKT94sWHUJN6
 IQeN2SViKvXX3ZclbRSn+jEbdhDrXD4fBA7sCy/WxctEgx6MBJ5XyVZpBtkXGRM5QIaJWo
 KJA/Y0bTqQi/95q9NCXIyhZ3rc/Rbg4=
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-stable@nongnu.org, Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PATCH 3/4] linux-user: fix reserved_va page leak in do_munmap
Date: Sat, 11 Oct 2025 21:03:36 +0100
Message-ID: <20251011200337.30258-4-mlugg@mlugg.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011200337.30258-1-mlugg@mlugg.co.uk>
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:19f0:7401:8244:5400:ff:fe24:ff33;
 envelope-from=mlugg@mlugg.co.uk; helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 11 Oct 2025 16:19:20 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The previous logic here had an off-by-one error: assuming 4k pages on
host and guest, if `len == 4097` (indicating to unmap 2 pages), then
`last = start + 4096`, so `real_last = start + 4095`, so ultimately
`real_len = 4096`. I do not believe this could cause any observable bugs
in guests, because `target_munmap` page-aligns the length it passes in.
However, calls to this function in `target_mremap` do not page-align the
length, so those calls could "drop" pages, leading to a part of the
reserved region becoming unmapped. At worst, a host allocation could get
mapped into that hole, then clobbered by a new guest mapping.

A simple fix didn't feel ideal here, because I think this function was
not written as well as it could be. Instead, the logic is simpler if we
use `end = start + len` instead of `last = start + len - 1` (overflow
does not cause any problem here), and use offsets in the loops (avoiding
overflows since the offset is never larger than the host page size).

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 63 ++++++++++++++++-------------------------------
 1 file changed, 21 insertions(+), 42 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4c5fe832ad..e1ed9085c7 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1014,59 +1014,38 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
 static int mmap_reserve_or_unmap(abi_ulong start, abi_ulong len)
 {
     int host_page_size = qemu_real_host_page_size();
+    abi_ulong end;
     abi_ulong real_start;
-    abi_ulong real_last;
-    abi_ulong real_len;
-    abi_ulong last;
-    abi_ulong a;
+    abi_ulong real_end;
+    abi_ulong off;
     void *host_start;
     int prot;
 
-    last = start + len - 1;
+    end = ROUND_UP(start + len, TARGET_PAGE_SIZE);
+
     real_start = start & -host_page_size;
-    real_last = ROUND_UP(last, host_page_size) - 1;
+    real_end = ROUND_UP(end, host_page_size);
 
-    /*
-     * If guest pages remain on the first or last host pages,
-     * adjust the deallocation to retain those guest pages.
-     * The single page special case is required for the last page,
-     * lest real_start overflow to zero.
-     */
-    if (real_last - real_start < host_page_size) {
-        prot = 0;
-        for (a = real_start; a < start; a += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(a);
-        }
-        for (a = last; a < real_last; a += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(a + 1);
-        }
-        if (prot != 0) {
-            return 0;
-        }
-    } else {
-        for (prot = 0, a = real_start; a < start; a += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(a);
-        }
-        if (prot != 0) {
-            real_start += host_page_size;
-        }
+    /* end or real_end may have overflowed to 0, but that's okay. */
 
-        for (prot = 0, a = last; a < real_last; a += TARGET_PAGE_SIZE) {
-            prot |= page_get_flags(a + 1);
-        }
-        if (prot != 0) {
-            real_last -= host_page_size;
-        }
+    /* If [real_start,start) contains a mapped guest page, retain the first page. */
+    for (prot = 0, off = 0; off < start - real_start; off += TARGET_PAGE_SIZE) {
+        prot |= page_get_flags(real_start + off);
+    }
+    if (prot != 0) {
+        real_start += host_page_size;
+    }
 
-        if (real_last < real_start) {
-            return 0;
-        }
+    /* If [end,real_end) contains a mapped guest page, retain the last page. */
+    for (prot = 0, off = 0; off < real_end - end; off += TARGET_PAGE_SIZE) {
+        prot |= page_get_flags(end + off);
+    }
+    if (prot != 0) {
+        real_end -= host_page_size;
     }
 
-    real_len = real_last - real_start + 1;
     host_start = g2h_untagged(real_start);
-
-    return do_munmap(host_start, real_len);
+    return do_munmap(host_start, real_end - real_start);
 }
 
 int target_munmap(abi_ulong start, abi_ulong len)
-- 
2.51.0


