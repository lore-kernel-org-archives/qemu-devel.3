Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58816CE7B02
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:22:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWxI-0006yK-Hf; Fri, 06 Sep 2024 07:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwF-0001yM-6W; Fri, 06 Sep 2024 07:15:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwC-0007zO-Vh; Fri, 06 Sep 2024 07:15:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 4548B8C48A;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 51F411336F4;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353624 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 26/69] target/arm: Fix UMOPA/UMOPS of 16-bit values
Date: Fri,  6 Sep 2024 14:12:35 +0300
Message-Id: <20240906111324.353230-26-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -57
X-Spam_score: -5.8
X-Spam_bar: -----
X-Spam_report: (-5.8 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, THIS_AD=1.099,
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

From: Peter Maydell <peter.maydell@linaro.org>

The UMOPA/UMOPS instructions are supposed to multiply unsigned 8 or
16 bit elements and accumulate the products into a 64-bit element.
In the Arm ARM pseudocode, this is done with the usual
infinite-precision signed arithmetic.  However our implementation
doesn't quite get it right, because in the DEF_IMOP_64() macro we do:
  sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);

where NTYPE and MTYPE are uint16_t or int16_t.  In the uint16_t case,
the C usual arithmetic conversions mean the values are converted to
"int" type and the multiply is done as a 32-bit multiply.  This means
that if the inputs are, for example, 0xffff and 0xffff then the
result is 0xFFFE0001 as an int, which is then promoted to uint64_t
for the accumulation into sum; this promotion incorrectly sign
extends the multiply.

Avoid the incorrect sign extension by casting to int64_t before
the multiply, so we do the multiply as 64-bit signed arithmetic,
which is a type large enough that the multiply can never
overflow into the sign bit.

(The equivalent 8-bit operations in DEF_IMOP_32() are fine, because
the 8-bit multiplies can never overflow into the sign bit of a
32-bit integer.)

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2372
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-3-peter.maydell@linaro.org
(cherry picked from commit ea3f5a90f036734522e9af3bffd77e69e9f47355)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index 5a6dd76489..f9001f5213 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1146,10 +1146,10 @@ static uint64_t NAME(uint64_t n, uint64_t m, uint64_t a, uint8_t p, bool neg) \
     uint64_t sum = 0;                                                       \
     /* Apply P to N as a mask, making the inactive elements 0. */           \
     n &= expand_pred_h(p);                                                  \
-    sum += (NTYPE)(n >> 0) * (MTYPE)(m >> 0);                               \
-    sum += (NTYPE)(n >> 16) * (MTYPE)(m >> 16);                             \
-    sum += (NTYPE)(n >> 32) * (MTYPE)(m >> 32);                             \
-    sum += (NTYPE)(n >> 48) * (MTYPE)(m >> 48);                             \
+    sum += (int64_t)(NTYPE)(n >> 0) * (MTYPE)(m >> 0);                      \
+    sum += (int64_t)(NTYPE)(n >> 16) * (MTYPE)(m >> 16);                    \
+    sum += (int64_t)(NTYPE)(n >> 32) * (MTYPE)(m >> 32);                    \
+    sum += (int64_t)(NTYPE)(n >> 48) * (MTYPE)(m >> 48);                    \
     return neg ? a - sum : a + sum;                                         \
 }
 
-- 
2.39.2


