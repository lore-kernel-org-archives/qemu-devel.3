Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50679C5DF66
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:36:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxVe-0003Fg-Hf; Mon, 17 Aug 2026 09:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVP-00036T-PJ; Mon, 17 Aug 2026 09:36:01 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvxVN-0007JU-Vk; Mon, 17 Aug 2026 09:35:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786973727; bh=q44llB35Ltz/01CjSFu3R4zrapC8fKPsV2bIO3JuWNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=uU1r/8HgGDGUHz45TYHa0QpJmKo9u9P2v9s/LDY7KIaBspKOHsdJUxJcFEPMKQHsV
 Xb4vJeKWWAaaWfKhTcIsqm8c3DfRHi9rla/AnrS2C/9IhYSFEQN+wkKX030f2rsXCB
 h61vfax//NaqkJfvt/1XOyMs5+2WwySub8HfpdLIfC2naYahDGFJrkUevAbf0CwcOO
 qYhnwfmr9CINBGgxpLUpXjnpg6oA8mCjAny5Jd+6/7McQR9I98gnvANsbpXHq57OR5
 m+WLrLJUdPuou830mDRJfAFTT0n2TSYbf+ju/cG/8LSGTpF5mZlmoTTuMGr227wXgh
 q2AiKB3+wnmCg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 189FB1CBCBB;
 Mon, 17 Aug 2026 16:35:27 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5234340D418;
 Mon, 17 Aug 2026 16:35:48 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 9830530F80; Mon, 17 Aug 2026 16:35:21 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 v2 108/135] target/s390x: Fix DR/D INT64_MIN / -1
 host crash
Date: Mon, 17 Aug 2026 16:34:18 +0300
Message-ID: <20260817133451.2384630-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260817151855@cover.tls.msk.ru>
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

From: Ilya Leoshkevich <iii@linux.ibm.com>

helper_divs32() divides the 64-bit dividend by the 32-bit divisor as a 64-bit
host operation, guarding only against a zero divisor. INT64_MIN / -1 therefore
overflows the host division before the representability check runs; on hosts
that trap this, QEMU is killed with SIGFPE instead of raising the
fixed-point-divide exception the guest expects:

    qemu-s390x: QEMU internal SIGFPE {code=INTDIV, addr=...}

helper_divs64() already guards the same case; add the missing check to
helper_divs32().

Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Fixes: b4e2bd3563af ("target-s390: Send signals for divide")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260714190351.337923-2-iii@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
(cherry picked from commit 0103cb1cd175a070f52ed0ca4fe0712c2ba2befc)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/s390x/tcg/int_helper.c b/target/s390x/tcg/int_helper.c
index 2af970f2c8b..b3fe572e546 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -40,7 +40,8 @@ uint64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
     int32_t b = b64;
     int64_t q, r;
 
-    if (b == 0) {
+    /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
+    if (b == 0 || (b == -1 && a == (1ll << 63))) {
         tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
-- 
2.47.3


