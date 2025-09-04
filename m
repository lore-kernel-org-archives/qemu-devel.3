Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44473CA1013
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 21:22:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuHO6-0007iE-1M; Thu, 04 Sep 2025 17:20:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uuHO3-0007g9-JA
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 17:20:55 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uuHNv-0005yZ-Ai
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 17:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=CqZKN2V4hwaZ5FUJBRvx0Noeg5vpZwODnnWiuz7jV+4=; b=VYVZDFQoK1USfNamsj7BxLWkHT
 3NchfqhwiFsPD5icDRiSsH/pVO7Cpx/k0CLfC+rLTe0gTnwtaTFQlL9NXnCyA69fOaAbSK/qW8arl
 kHnM0NDbF479ogfy9f6OjGyv5mh5krZBdNdOJ1f6yvGzJeQLy+bPtrovJk4z5OXUvJWbWgGzr5rJj
 ScPAbXo4RbuF/4yDaKcN5M1ipsYqbe/r/yOG/hW5Jstjtsm2K1rIjEWjgbBL0FRGHPS+NUZxvHFYE
 j2ykZIUn9HKBZwkQ/H7uaKyWU1TPGeiRVKiztqCu5ANgWfeQ2MaFeat5n2k9LcEFvnv7aObv4sZiY
 tfItg+RL+aEvi4t2nlZ8XbB3rl/c8NvsxALc/bLh42BPmKxL5Wb7v6zLo7JwN0XaZdNvvta5JqlNx
 YkbTbeDm1MAu44r1XJTD4GRrrbjMR5zXlhyi+juGJL0f8Z4gr0mlflKSPN2zBwhYTcU4VM6meVp2t
 WRBjwZ5nD6/BWUC2q+IWmMlwYFD0N5kf8aa4kPouOpQefcDhJLRQSpfpCK6aQikTqJZsEX0FUx26O
 ay10qdMETqqk+iCKy3TRVJQdYXECZfWJ9bE+1+ml9ghNobhwGTvxcXCVYI3kYUxmrNkXE90Q25dDx
 f3bbeK2YG53/xUSjDC1lXv95yC9El+H4uPo1P0CR4=;
Received: from [217.155.175.48] (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uuHLx-0003ZP-SW; Thu, 04 Sep 2025 22:18:46 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Sep 2025 22:20:39 +0100
Message-Id: <20250904212039.811623-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.155.175.48
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v2] target/sparc: allow partial decode of v8 STBAR instructions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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

Solaris 8 appears to have a bug whereby it executes v9 MEMBAR instructions
when booting a freshly installed image. According to the SPARC v8
architecture manual, whilst bits 14 and bits 13-0 of the "Read State Register
Instructions" are notionally zero, they are marked as unused (i.e. ignored).
In effect the v9 MEMBAR instruction becomes a v8 STBAR instruction on a 32-bit
SPARC CPU.

Adjust the avail_32() logic in trans_MEMBAR() so that if a v9 MEMBAR
instruction is executed on 32-bit SPARC, the equivalent of a v8 STBAR
instruction is executed instead.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: af25071c1d ("target/sparc: Move RDASR, STBAR, MEMBAR to decodetree")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3097
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/translate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

v2:
- Call trans_STBAR() directly instead of inlining it
- Add R-B tag from Richard


diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b922e53bf1..735f5aae06 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2832,7 +2832,14 @@ static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
 static bool trans_MEMBAR(DisasContext *dc, arg_MEMBAR *a)
 {
     if (avail_32(dc)) {
-        return false;
+        /*
+         * At least Solaris 8 executes v9 MEMBAR instructions such as
+         * 0x8143e008 during boot. According to the SPARC v8 architecture
+         * manual, bits 13 and 12-0 are unused (notionally zero) so in
+         * this case if we assume the unused bits are not decoded then
+         * the instruction becomes 0x8143c000, or the equivalent of STBAR.
+         */
+        return trans_STBAR(dc, NULL);
     }
     if (a->mmask) {
         /* Note TCG_MO_* was modeled on sparc64, so mmask matches. */
-- 
2.39.5


