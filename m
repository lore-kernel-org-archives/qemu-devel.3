Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7C5C5DF70
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 10:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvuqM-0001MH-Tx; Mon, 17 Aug 2026 06:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqG-0001A2-05; Mon, 17 Aug 2026 06:45:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wvuqD-0003yC-Ia; Mon, 17 Aug 2026 06:45:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786963486; bh=z24j5fUvbF6FMuah81uaPJqujR3AO1r6+MwUxCj2UbU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=c0U3z2QDr6kruOdGQHiUZKxG0DFOJ9mXdXyXI1HuyrD9DuwtjLR7ut8DSC32ETjY4
 7fQegf6tfgq5PNZ9qZYQnULAN3wmdXv5YKIEFBwCJaXc/im4/5Ad1vCaL273zo0gj1
 Kgm4BzsyGG7gllndDoobDY/GX1uPzNF9qreX8wPQ3nznXex2PxMUAP5hEVeB2mT7y1
 qm3WUuh8Cbc/h5ZRQSE0oNDDpmdn1d7WA+9GEsvbJ7y+XZmqEUd5XE/6t6LYLQjtBD
 3G52nRWdxQaiHmIKhzh7BvNutZ3BFq/AJIe0n6+9by+Z8nIveJUyt2CmDk/CuwxmXO
 5xYxQFdp5pdWg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 69D551CBB6C;
 Mon, 17 Aug 2026 13:44:46 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 6AF9F40D1FD;
 Mon, 17 Aug 2026 13:45:07 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 00D9530E50; Mon, 17 Aug 2026 13:44:40 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eric Farman <farman@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 v2 127/161] target/s390x: Fix DR/D INT64_MIN / -1 host
 crash
Date: Mon, 17 Aug 2026 13:42:41 +0300
Message-ID: <20260817104344.2047346-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260817125055@cover.tls.msk.ru>
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
index fbda396f5b4..5aedd1405bf 100644
--- a/target/s390x/tcg/int_helper.c
+++ b/target/s390x/tcg/int_helper.c
@@ -39,7 +39,8 @@ uint64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
     int32_t b = b64;
     int64_t q, r;
 
-    if (b == 0) {
+    /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
+    if (b == 0 || (b == -1 && a == (1ll << 63))) {
         tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
     }
 
-- 
2.47.3


