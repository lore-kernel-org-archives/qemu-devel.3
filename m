Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C32CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Oct 2025 20:21:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7g3n-0007Y1-0n; Sat, 11 Oct 2025 16:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlugg@mlugg.co.uk>)
 id 1v7fp1-000540-2W; Sat, 11 Oct 2025 16:04:07 -0400
Received: from mlugg.co.uk ([104.238.170.239] helo=mail.mlugg.co.uk)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlugg@mlugg.co.uk>)
 id 1v7fox-0006n9-UH; Sat, 11 Oct 2025 16:04:06 -0400
Received: from localhost.localdomain
 (7.1.8.2.8.1.e.f.f.f.e.d.0.b.e.f.f.b.9.2.0.c.b.a.0.b.8.0.1.0.0.2.ip6.arpa
 [IPv6:2001:8b0:abc0:29bf:feb0:deff:fe18:2817])
 by mail.mlugg.co.uk (Postfix) with ESMTPSA id 93F4535324;
 Sat, 11 Oct 2025 20:04:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mlugg.co.uk; s=20200703;
 t=1760213041; h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iIXFL4xk4x30Y5a7OuQM/O0iDcWc+2aUW58n+TpLjT8=;
 b=gYLXuyDjBx5/6l2zpzPq5Am2xeUnixpzzpKaJDLVoTfeUjaYClNeWeeskCfTf63wz0zoUw
 ktDfzPW/eM+8XYuQzkSu+d0L5PfdGSBzLCy4Ou+0foBlnfED922o58l59zD7Xe9EOtK4Kh
 ki/1SnT6qtjjl5XK3fySy/EMAHaKodQ=
From: Matthew Lugg <mlugg@mlugg.co.uk>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, qemu-stable@nongnu.org, Matthew Lugg <mlugg@mlugg.co.uk>
Subject: [PATCH 2/4] linux-user: fix mremap errors for invalid ranges
Date: Sat, 11 Oct 2025 21:03:35 +0100
Message-ID: <20251011200337.30258-3-mlugg@mlugg.co.uk>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251011200337.30258-1-mlugg@mlugg.co.uk>
References: <20251011200337.30258-1-mlugg@mlugg.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=104.238.170.239; envelope-from=mlugg@mlugg.co.uk;
 helo=mail.mlugg.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

If an address range given to `mremap` is invalid (exceeds addressing
bounds on the guest), we were previously returning `ENOMEM`, which is
not correct. The manpage and the Linux kernel implementation both agree
that if `old_addr`/`old_size` refer to an invalid address, `EFAULT` is
returned, and if `new_addr`/`new_size` refer to an invalid address,
`EINVAL` is returned.

Signed-off-by: Matthew Lugg <mlugg@mlugg.co.uk>
---
 linux-user/mmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index ec8392b35b..4c5fe832ad 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1103,12 +1103,15 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
     int prot;
     void *host_addr;
 
-    if (!guest_range_valid_untagged(old_addr, old_size) ||
-        ((flags & MREMAP_FIXED) &&
+    if (!guest_range_valid_untagged(old_addr, old_size)) {
+        errno = EFAULT;
+        return -1;
+    }
+    if (((flags & MREMAP_FIXED) &&
          !guest_range_valid_untagged(new_addr, new_size)) ||
         ((flags & MREMAP_MAYMOVE) == 0 &&
          !guest_range_valid_untagged(old_addr, new_size))) {
-        errno = ENOMEM;
+        errno = EINVAL;
         return -1;
     }
 
-- 
2.51.0


