Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBCCC54788
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:49:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcuSk-00076p-Ip; Wed, 21 Feb 2024 16:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSi-0006y5-0g; Wed, 21 Feb 2024 16:49:08 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rcuSg-0007Xf-5X; Wed, 21 Feb 2024 16:49:07 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 539A74F870;
 Thu, 22 Feb 2024 00:47:47 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id F0F16869F1;
 Thu, 22 Feb 2024 00:47:24 +0300 (MSK)
Received: (nullmailer pid 2339883 invoked by uid 1000);
 Wed, 21 Feb 2024 21:47:23 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.10 20/33] target/arm: Fix nregs computation in do_{ld,
 st}_zpa
Date: Thu, 22 Feb 2024 00:47:03 +0300
Message-Id: <20240221214723.2339742-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
References: <qemu-stable-7.2.10-20240221121815@cover.tls.msk.ru>
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

The field is encoded as [0-3], which is convenient for
indexing our array of function pointers, but the true
value is [1-4].  Adjust before calling do_mem_zpa.

Add an assert, and move the comment re passing ZT to
the helper back next to the relevant code.

Cc: qemu-stable@nongnu.org
Fixes: 206adacfb8d ("target/arm: Add mte helpers for sve scalar + int loads")
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20240207025210.8837-3-richard.henderson@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 64c6e7444dff64b42d11b836b9aec9acfbe8ecc2)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 621a2abb22..7388e1dbc7 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -4587,11 +4587,7 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     TCGv_ptr t_pg;
     int desc = 0;
 
-    /*
-     * For e.g. LD4, there are not enough arguments to pass all 4
-     * registers as pointers, so encode the regno into the data field.
-     * For consistency, do this even for LD1.
-     */
+    assert(mte_n >= 1 && mte_n <= 4);
     if (s->mte_active[0]) {
         int msz = dtype_msz(dtype);
 
@@ -4605,6 +4601,11 @@ static void do_mem_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
         addr = clean_data_tbi(s, addr);
     }
 
+    /*
+     * For e.g. LD4, there are not enough arguments to pass all 4
+     * registers as pointers, so encode the regno into the data field.
+     * For consistency, do this even for LD1.
+     */
     desc = simd_desc(vsz, vsz, zt | desc);
     t_pg = tcg_temp_new_ptr();
 
@@ -4744,7 +4745,7 @@ static void do_ld_zpa(DisasContext *s, int zt, int pg,
      * accessible via the instruction encoding.
      */
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, dtype, nreg, false, fn);
+    do_mem_zpa(s, zt, pg, addr, dtype, nreg + 1, false, fn);
 }
 
 static bool trans_LD_zprr(DisasContext *s, arg_rprr_load *a)
@@ -5320,14 +5321,13 @@ static void do_st_zpa(DisasContext *s, int zt, int pg, TCGv_i64 addr,
     if (nreg == 0) {
         /* ST1 */
         fn = fn_single[s->mte_active[0]][be][msz][esz];
-        nreg = 1;
     } else {
         /* ST2, ST3, ST4 -- msz == esz, enforced by encoding */
         assert(msz == esz);
         fn = fn_multiple[s->mte_active[0]][be][nreg - 1][msz];
     }
     assert(fn != NULL);
-    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg, true, fn);
+    do_mem_zpa(s, zt, pg, addr, msz_dtype(s, msz), nreg + 1, true, fn);
 }
 
 static bool trans_ST_zprr(DisasContext *s, arg_rprr_store *a)
-- 
2.39.2


