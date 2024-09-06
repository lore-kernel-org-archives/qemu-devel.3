Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35FBCD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 11:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smWxY-0007pt-53; Fri, 06 Sep 2024 07:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwF-0001yL-2s; Fri, 06 Sep 2024 07:15:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smWwB-0007zB-KJ; Fri, 06 Sep 2024 07:15:38 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3700E8C489;
 Fri,  6 Sep 2024 14:12:08 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 43F501336F3;
 Fri,  6 Sep 2024 14:13:26 +0300 (MSK)
Received: (nullmailer pid 353621 invoked by uid 1000);
 Fri, 06 Sep 2024 11:13:24 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.3 25/69] target/arm: Don't assert for 128-bit tile
 accesses when SVL is 128
Date: Fri,  6 Sep 2024 14:12:34 +0300
Message-Id: <20240906111324.353230-25-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
References: <qemu-stable-9.0.3-20240906141259@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Peter Maydell <peter.maydell@linaro.org>

For an instruction which accesses a 128-bit element tile when
the SVL is also 128 (for example MOV z0.Q, p0/M, ZA0H.Q[w0,0]),
we will assert in get_tile_rowcol():

qemu-system-aarch64: ../../tcg/tcg-op.c:926: tcg_gen_deposit_z_i32: Assertion `len > 0' failed.

This happens because we calculate
    len = ctz32(streaming_vec_reg_size(s)) - esz;$
but if the SVL and the element size are the same len is 0, and
the deposit operation asserts.

In this case the ZA storage contains exactly one 128 bit
element ZA tile, and the horizontal or vertical slice is just
that tile. This means that regardless of the index value in
the Ws register, we always access that tile. (In pseudocode terms,
we calculate (index + offset) MOD 1, which is 0.)

Special case the len == 0 case to avoid hitting the assertion
in tcg_gen_deposit_z_i32().

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240722172957.1041231-2-peter.maydell@linaro.org
(cherry picked from commit 56f1c0db928aae0b83fd91c89ddb226b137e2b21)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 185a8a917b..a50a419af2 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -49,7 +49,15 @@ static TCGv_ptr get_tile_rowcol(DisasContext *s, int esz, int rs,
     /* Prepare a power-of-two modulo via extraction of @len bits. */
     len = ctz32(streaming_vec_reg_size(s)) - esz;
 
-    if (vertical) {
+    if (!len) {
+        /*
+         * SVL is 128 and the element size is 128. There is exactly
+         * one 128x128 tile in the ZA storage, and so we calculate
+         * (Rs + imm) MOD 1, which is always 0. We need to special case
+         * this because TCG doesn't allow deposit ops with len 0.
+         */
+        tcg_gen_movi_i32(tmp, 0);
+    } else if (vertical) {
         /*
          * Compute the byte offset of the index within the tile:
          *     (index % (svl / size)) * size
-- 
2.39.2


