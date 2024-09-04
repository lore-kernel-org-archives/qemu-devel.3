Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5337CCA0ED3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sln2W-0004W9-Gq; Wed, 04 Sep 2024 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sln2M-0003sz-Aa
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:14:54 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@kernel.org>) id 1sln2J-0002iQ-PJ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:14:54 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 03BE45C3A62;
 Wed,  4 Sep 2024 10:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0566BC4CEC8;
 Wed,  4 Sep 2024 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725444890;
 bh=Ww/ATg0fq9oyEeA7X9+YCqmySLFlQRuRy6f2ZA7sHds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=AvNZZAbr2KXTToRhx5uDVA5wqMNJoGtJO0v5Zfl9QIOJKKcCcBNzKs1KjBBZtbyUO
 NyQpXpye68zP/3lUZYxKhKtz3k0TQGgJkXZqZ+aMpW3xzxLS4zyAfmgwJ5UegLMQj8
 rc2e9mKvlgjf/iZKAID5Sjr8i55ni/Je9d6R+2g+eMpa/0B0a54mWugoKKjJlhHvEN
 wMEZTChLJAQPkr1tr/K0JJKS+8VJ2hqj1h7wVufZ+E7QzP0CoR60uZdf9nzJ7OEGNk
 37cxfjx1fbXz3HvKYwvq22niAvViEiHi9dSJPIc29WqqVW8m+swhf4BbmB5DCtZlv9
 aWr+CEIIgrMdg==
From: deller@kernel.org
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Cc: deller@gmx.de
Subject: [PULL 1/2] target/hppa: Fix PSW V-bit packaging in cpu_hppa_get for
 hppa64
Date: Wed,  4 Sep 2024 12:14:44 +0200
Message-ID: <20240904101445.4127-2-deller@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240904101445.4127-1-deller@kernel.org>
References: <20240904101445.4127-1-deller@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=deller@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Helge Deller <deller@gmx.de>

While adding hppa64 support, the psw_v variable got extended from 32 to 64
bits.  So, when packaging the PSW-V bit from the psw_v variable for interrupt
processing, check bit 31 instead the 63th (sign) bit.

This fixes a hard to find Linux kernel boot issue where the loss of the PSW-V
bit due to an ITLB interruption in the middle of a series of ds/addc
instructions (from the divU milicode library) generated the wrong division
result and thus triggered a Linux kernel crash.

Link: https://lore.kernel.org/lkml/718b8afe-222f-4b3a-96d3-93af0e4ceff1@roeck-us.net/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa64")
Cc: qemu-stable@nongnu.org # v8.2+
---
 target/hppa/cpu.h    | 2 +-
 target/hppa/helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 2bcb3b602b..5478b183dc 100644
--- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -211,7 +211,7 @@ typedef struct CPUArchState {
     uint32_t psw;            /* All psw bits except the following:  */
     uint32_t psw_xb;         /* X and B, in their normal positions */
     target_ulong psw_n;      /* boolean */
-    target_long psw_v;       /* in most significant bit */
+    target_long psw_v;       /* in bit 31 */
 
     /* Splitting the carry-borrow field into the MSB and "the rest", allows
      * for "the rest" to be deleted when it is unused, but the MSB is in use.
diff --git a/target/hppa/helper.c b/target/hppa/helper.c
index b79ddd8184..d4b1a3cd5a 100644
--- a/target/hppa/helper.c
+++ b/target/hppa/helper.c
@@ -53,7 +53,7 @@ target_ulong cpu_hppa_get_psw(CPUHPPAState *env)
     }
 
     psw |= env->psw_n * PSW_N;
-    psw |= (env->psw_v < 0) * PSW_V;
+    psw |= ((env->psw_v >> 31) & 1) * PSW_V;
     psw |= env->psw | env->psw_xb;
 
     return psw;
-- 
2.46.0


