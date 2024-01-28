Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E09FC47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 17:55:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rU9It-0002Rx-S3; Sun, 28 Jan 2024 12:50:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9I5-0001s5-MD; Sun, 28 Jan 2024 12:50:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rU9I3-0000Uc-Ty; Sun, 28 Jan 2024 12:49:57 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7FB7D480F3;
 Sun, 28 Jan 2024 20:49:46 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 140E26D51A;
 Sun, 28 Jan 2024 20:48:55 +0300 (MSK)
Received: (nullmailer pid 811729 invoked by uid 1000);
 Sun, 28 Jan 2024 17:48:46 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.1.5 36/36] target/arm: Fix A64 scalar SQSHRN and SQRSHRN
Date: Sun, 28 Jan 2024 20:48:41 +0300
Message-Id: <20240128174845.811654-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.1.5-20240128204753@cover.tls.msk.ru>
References: <qemu-stable-8.1.5-20240128204753@cover.tls.msk.ru>
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

In commit 1b7bc9b5c8bf374dd we changed handle_vec_simd_sqshrn() so
that instead of starting with a 0 value and depositing in each new
element from the narrowing operation, it instead started with the raw
result of the narrowing operation of the first element.

This is fine in the vector case, because the deposit operations for
the second and subsequent elements will always overwrite any higher
bits that might have been in the first element's result value in
tcg_rd.  However in the scalar case we only go through this loop
once.  The effect is that for a signed narrowing operation, if the
result is negative then we will now return a value where the bits
above the first element are incorrectly 1 (because the narrowfn
returns a sign-extended result, not one that is truncated to the
element size).

Fix this by using an extract operation to get exactly the correct
bits of the output of the narrowfn for element 1, instead of a
plain move.

Cc: qemu-stable@nongnu.org
Fixes: 1b7bc9b5c8bf374dd3 ("target/arm: Avoid tcg_const_ptr in handle_vec_simd_sqshrn")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2089
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240123153416.877308-1-peter.maydell@linaro.org
(cherry picked from commit 6fffc8378562c7fea6290c430b4f653f830a4c1a)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 7267f172d7..4e54cb7502 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -8116,7 +8116,7 @@ static void handle_vec_simd_sqshrn(DisasContext *s, bool is_scalar, bool is_q,
         narrowfn(tcg_rd_narrowed, cpu_env, tcg_rd);
         tcg_gen_extu_i32_i64(tcg_rd, tcg_rd_narrowed);
         if (i == 0) {
-            tcg_gen_mov_i64(tcg_final, tcg_rd);
+            tcg_gen_extract_i64(tcg_final, tcg_rd, 0, esize);
         } else {
             tcg_gen_deposit_i64(tcg_final, tcg_final, tcg_rd, esize * i, esize);
         }
-- 
2.39.2


