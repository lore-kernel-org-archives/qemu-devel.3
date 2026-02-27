Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28485FEFB6A
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 17:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vw1Sy-0004OR-Q0; Fri, 27 Feb 2026 12:17:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw109-0004Bd-I5
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:41 -0500
Received: from mail.envs.net ([157.180.15.194])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xtex@envs.net>) id 1vw107-0004P8-Bz
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 11:47:41 -0500
Received: from localhost (mail.envs.net [127.0.0.1])
 by mail.envs.net (Postfix) with ESMTP id 60A721C00E3;
 Fri, 27 Feb 2026 16:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=envs.net; s=modoboa;
 t=1772210855; bh=Uk9wA2yM3y796Jo8lyWMW2veY7XOlDD6nkMTwS+ne5s=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MnQ7gYtHH9Arl14Wa5xoT13rxaaYYkdQSvZi/mIiBkXn5eqcUBBqmhtCqIhzujl5f
 OMDCT9+fqG/W7SRnqKo9+u9pwuARVXS+GkI3DR8R5IRe2wvg9a/eR1YyJmaiKFTN85
 7o0bq70xPfsZJ1b8mPSZbSPp+KIyYZQ04HYw/OjT5viV0PRezkmnh0QA2bE/9iC6+q
 TywT+KNSl991f3Lzcqd5Goax00SGZuayBO4F8m4MyQXShysVH7E3UQ9gd6GJuxDYwZ
 uIpR8hwcGXuCG46VkztfTGnsn0fgWjAwlkQQQmQWzyMx82VGqFvFnYZeHsIxwTy1N2
 218c5KQGFAJNRXQ23kXxJSaqhazOWYA2ODMHiQVU99RQzHVcab62px20pVFznuWD5d
 0vHGyL2cBB8xYMM7FoFESbBObf49NHZTiRtFyjfUd4vlGkuNvI2Rq81462CZ0GXL1b
 ImTux34cVsYTk2DEdIlClQN14fbpdeo60FysEf/t0uYrydb5BwnzFeEN1d23oOO2Qe
 iQ8z5oXsIrpfVEUtmnwGcWyvi3ENPFYyHOdBbbGDeVw6ZF0kM8IpbnccMVc1zT8h+V
 DDQnh7r0qkjN6ao97JMZ/nKy/v/TTZwalyJXYwH/Az2BdDUDnzJkQSHYrcs0slBgIf
 f6YsHZ7k5QCjeJFh400yIHyg=
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
 by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id nMDFTgMfgXIp; Fri, 27 Feb 2026 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (unknown [142.248.151.117])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.envs.net (Postfix) with ESMTPSA;
 Fri, 27 Feb 2026 16:47:28 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
Date: Sat, 28 Feb 2026 00:46:30 +0800
Subject: [PATCH 1/4] linux-user: Deal with mmap where start > reserved_va
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260228-abyss-mmap-relocation-v1-1-c8ec0476894b@astrafall.org>
References: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
In-Reply-To: <20260228-abyss-mmap-relocation-v1-0-c8ec0476894b@astrafall.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Warner Losh <imp@bsdimp.com>, 
 =?utf-8?q?Alex_R=C3=B8nne_Petersen?= <alex@alexrp.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Bingwu Zhang <xtex@astrafall.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=xtex@astrafall.org;
 h=from:subject:message-id; bh=rTfZmcXB35KVF+0oZQFtWTXqSC2+Z2NKT1fd0IuSDek=;
 b=owGbwMvMwCW2U4Ij7wZL9ETG02pJDJkLT00V6LIQm7jx38qKPYoT75cuUpxT0+286Uns0+NJR
 zcFm3271zGRhUGMi8FSTJGlyLDBm1UnnV90WbkszBxWJpAh0iINDAwMDCwMfLmJeaVGOkZ6ptqG
 eoaGOkY6RgxcnAIw1R9eMPx3OTGRoTF04aXLGUKHC3TWXPzwcmd82dQdScfnPZDVVeDfxsjwTFj
 i3xQjgRKnKDHVY981Em3OMTeuWmm9nM11xtTeye08AA==
X-Developer-Key: i=xtex@astrafall.org; a=openpgp;
 fpr=7231804B052C670F15A6771DB918086ED8045B91
Received-SPF: pass client-ip=157.180.15.194; envelope-from=xtex@envs.net;
 helo=mail.envs.net
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.706, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.401,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 27 Feb 2026 12:17:25 -0500
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

From: Bingwu Zhang <xtex@astrafall.org>

Fixes: 4c13048e02d9 ("linux-user: Use page_find_range_empty for mmap_find_vma_reserved")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3310
Signed-off-by: Bingwu Zhang <xtex@astrafall.org>
---
 linux-user/mmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 07175e11d576..76978a56a859 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -423,12 +423,15 @@ abi_ulong mmap_next_start;
 static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
                                         abi_ulong align)
 {
-    target_ulong ret;
+    target_ulong ret = -1;
 
-    ret = page_find_range_empty(start, reserved_va, size, align);
+    if (start <= reserved_va) {
+        ret = page_find_range_empty(start, reserved_va, size, align);
+    }
     if (ret == -1 && start > mmap_min_addr) {
         /* Restart at the beginning of the address space. */
-        ret = page_find_range_empty(mmap_min_addr, start - 1, size, align);
+        ret = page_find_range_empty(mmap_min_addr, MIN(start - 1, reserved_va),
+                                    size, align);
     }
 
     return ret;

-- 
2.52.0


