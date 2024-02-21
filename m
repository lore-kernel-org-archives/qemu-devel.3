Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E262C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoZk-0003hx-9G; Wed, 21 Feb 2024 10:32:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcoOS-0002DX-Kq; Wed, 21 Feb 2024 10:20:20 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rchuQ-0002g6-Cq; Wed, 21 Feb 2024 03:24:55 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C00764F3E8;
 Wed, 21 Feb 2024 11:21:22 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 8B2BB860C7;
 Wed, 21 Feb 2024 11:21:01 +0300 (MSK)
Received: (nullmailer pid 2142115 invoked by uid 1000);
 Wed, 21 Feb 2024 08:20:58 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.2 42/60] target/arm: Adjust and validate mtedesc sizem1
Date: Wed, 21 Feb 2024 11:20:30 +0300
Message-Id: <20240221082058.2141850-42-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
References: <qemu-stable-8.2.2-20240221110049@cover.tls.msk.ru>
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

From: Richard Henderson <richard.henderson@linaro.org>

When we added SVE_MTEDESC_SHIFT, we effectively limited the
maximum size of MTEDESC.  Adjust SIZEM1 to consume the remaining
bits (32 - 10 - 5 - 12 == 5).  Assert that the data to be stored
fits within the field (expecting 8 * 4 - 1 == 31, exact fit).

Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit b12a7671b6099a26ce5d5ab09701f151e21c112c)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 143d57c0fe..8342f4651f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1273,7 +1273,7 @@ FIELD(MTEDESC, TBI,   4, 2)
 FIELD(MTEDESC, TCMA,  6, 2)
 FIELD(MTEDESC, WRITE, 8, 1)
 FIELD(MTEDESC, ALIGN, 9, 3)
-FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - 12)  /* size - 1 */
+FIELD(MTEDESC, SIZEM1, 12, SIMD_DATA_BITS - SVE_MTEDESC_SHIFT - 12)  /* size - 1 */
 
 bool mte_probe(CPUARMState *env, uint32_t desc, uint64_t ptr);
 uint64_t mte_check(CPUARMState *env, uint32_t desc, uint64_t ptr, uintptr_t ra);
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 7108938251..a88e523cba 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4443,17 +4443,18 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
 {
     unsigned vsz = vec_full_reg_size(s);
     TCGv_ptr t_pg;
+    uint32_t sizem1;
     int desc = 0;
 
     assert(mte_n >= 1 && mte_n <= 4);
+    sizem1 = (mte_n << dtype_msz(dtype)) - 1;
+    assert(sizem1 <= R_MTEDESC_SIZEM1_MASK >> R_MTEDESC_SIZEM1_SHIFT);
     if (s->mte_active[0]) {
-        int msz = dtype_msz(dtype);
-
         desc = FIELD_DP32(desc, MTEDESC, MIDX, get_mem_index(s));
         desc = FIELD_DP32(desc, MTEDESC, TBI, s->tbid);
         desc = FIELD_DP32(desc, MTEDESC, TCMA, s->tcma);
         desc = FIELD_DP32(desc, MTEDESC, WRITE, is_write);
-        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, (mte_n << msz) - 1);
+        desc = FIELD_DP32(desc, MTEDESC, SIZEM1, sizem1);
         desc <<= SVE_MTEDESC_SHIFT;
     } else {
         addr = clean_data_tbi(s, addr);
-- 
2.39.2


