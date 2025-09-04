Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D604CA101F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Sep 2025 16:12:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuCY0-0002Tz-C2; Thu, 04 Sep 2025 12:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uuCXx-0002T6-0b
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 12:10:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uuCXq-0001NK-5d
 for qemu-devel@nongnu.org; Thu, 04 Sep 2025 12:10:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=sydaIQXWDcJvZFDqnCOF4NsTDZeP+BOGQa6B2fbrJRQ=; b=Fyv4U5IU/VmDS7eMc7ML8xxIDm
 c5U+sFnMwBtmG0Xe1DhcUkF8+zRlAliL6bNqVGFD/x9/xE1FfLaEngZK+UWWIMv+QWDD/Qcktckuf
 4rhwOUgz6BfOkTTN1h9+qqD5hSVtqzS5byWUfAJ4ttcqOHITsmEhctQ25o/IiODWeipTve7N9zkQc
 /OsL1PMsgO+0u3Ix25Po4NHSA5ZpiN9/ZFFj4/T76MrlDHAb2/ZBes81wTQapvvJIaWYh1Eqz3C68
 p9o+ScDy6cmnqFysFIBTfYzTC6Bj+6yuEw8aZDZPtAfNTHS6VeVXsWm+asvf4YwNT7SNA7p5ajh78
 s0VcHrNnue89Co/sG/CLqj22eaSG2azG0zQo6G9pCEkYFVKrrZFMN+gY+kWrDrhdddHSWxTsQjbjD
 IEWbZii4yf2BR3df4oRD5zZKSzq7S3oPmYkJz3Z5mXYZB7XxSOZGoc1QJZrELogerGwwAnzdxX5K2
 qjXQ5OfhcH9TYpKfe6Gc6KtJ07ZBcdzBvyIY6TvP4R0QYAeDOkJo3iJ0uK6wCzFdFju62G/l2xfap
 ipuCEbYRDUiKyaRpArMdqRW69ezeOfXlpB69Vq4PGQOR1RuSNSOFJIWWBoU20bKuBN6wTVyxubzs4
 ZrV0kBIgS6kbZp5AuKKpyWskHCZ5fRXoNjdJJ36a8=;
Received: from [131.175.126.3] (helo=cheesecake.dot1x.polimi.it)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1uuCVm-0001Zv-Nb; Thu, 04 Sep 2025 17:08:35 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Date: Thu,  4 Sep 2025 17:10:26 +0100
Message-Id: <20250904161026.804239-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 131.175.126.3
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] target/sparc: allow partial decode of v8 STBAR instructions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
---
 target/sparc/translate.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index b922e53bf1..9efefe41c6 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -2832,7 +2832,15 @@ static bool trans_STBAR(DisasContext *dc, arg_STBAR *a)
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
+        tcg_gen_mb(TCG_MO_ST_ST | TCG_BAR_SC);
+        return advance_pc(dc);
     }
     if (a->mmask) {
         /* Note TCG_MO_* was modeled on sparc64, so mmask matches. */
-- 
2.39.5


