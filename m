Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA2C0218B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 12:27:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbImL-0000Vq-I8; Fri, 24 Jan 2025 07:27:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tbImJ-0000Vi-Nl
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:27:15 -0500
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1tbImH-0001l3-EA
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 07:27:15 -0500
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id 892F8233C7;
 Fri, 24 Jan 2025 15:27:09 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org, philmd@linaro.org, richard.henderson@linaro.org,
 Denis Rastyogin <gerben@altlinux.org>, Dmitriy Fedin <d.fedin@fobos-nt.ru>
Subject: [PATCH] target/mips: fix possible int overflow
Date: Fri, 24 Jan 2025 15:26:32 +0300
Message-ID: <20250124122707.54264-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Denis Rastyogin <gerben@altlinux.org>

Fix possible overflow in 1 << (DF_BITS(df) - 2) when DF_BITS(df) 
is 64 by using a 64-bit integer for the shift operation.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: Dmitriy Fedin <d.fedin@fobos-nt.ru>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 target/mips/tcg/msa_helper.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/mips/tcg/msa_helper.c b/target/mips/tcg/msa_helper.c
index 1d40383ca4..5ced3168b4 100644
--- a/target/mips/tcg/msa_helper.c
+++ b/target/mips/tcg/msa_helper.c
@@ -5577,7 +5577,7 @@ static inline int64_t msa_mulr_q_df(uint32_t df, int64_t arg1, int64_t arg2)
 {
     int64_t q_min = DF_MIN_INT(df);
     int64_t q_max = DF_MAX_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit = 1LL << (DF_BITS(df) - 2);
 
     if (arg1 == q_min && arg2 == q_min) {
         return q_max;
@@ -5685,7 +5685,7 @@ static inline int64_t msa_maddr_q_df(uint32_t df, int64_t dest, int64_t arg1,
 
     int64_t q_max = DF_MAX_INT(df);
     int64_t q_min = DF_MIN_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit = 1LL << (DF_BITS(df) - 2);
 
     q_prod = arg1 * arg2;
     q_ret = ((dest << (DF_BITS(df) - 1)) + q_prod + r_bit) >> (DF_BITS(df) - 1);
@@ -5700,7 +5700,7 @@ static inline int64_t msa_msubr_q_df(uint32_t df, int64_t dest, int64_t arg1,
 
     int64_t q_max = DF_MAX_INT(df);
     int64_t q_min = DF_MIN_INT(df);
-    int64_t r_bit = 1 << (DF_BITS(df) - 2);
+    int64_t r_bit = 1LL << (DF_BITS(df) - 2);
 
     q_prod = arg1 * arg2;
     q_ret = ((dest << (DF_BITS(df) - 1)) - q_prod + r_bit) >> (DF_BITS(df) - 1);
-- 
2.42.2


