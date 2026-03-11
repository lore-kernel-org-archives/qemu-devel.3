Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49AB3112584D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:18:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LBo-0001Ux-Ht; Wed, 11 Mar 2026 11:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LAK-00055q-VP; Wed, 11 Mar 2026 11:08:09 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1w0LAJ-0005Sw-DC; Wed, 11 Mar 2026 11:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1773241481; bh=E3cGNeFeUOznE9BBJTE5+LSH/VZ5Z74D9SNno9Uqbrg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TEG1gsecXPEhLb/TBppUtkMRVtQtiNx9/fkNtRyzskcUuGAcgOCTU+I3tkShB4mqg
 PcACnJDtAyZqQ5shGpI+YkcUpHaMuww7UGT/3q8efbm4zoeWbcd0QmDhvzZFrwLr4A
 uG/GjjBF638O/5l4lHuTHNAtnruIVAQztwaKs7p48m7JmP34bVNAx/JvGqsUfSqPWK
 qg5KmwR2WiLJd/6fuxkEvFjP7k9rg/Il4pDRmMtDQ1ybU0Pf96p6fM1vRRKw1FSxLm
 COIiKx6V8yMe8aowlnbHbtHLppTrqp2hkjesRznqpCSg6PjTstGe/v1w8JTjISBkUc
 HlraiVubJdOCg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DA990191E90;
 Wed, 11 Mar 2026 18:04:41 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C8D0237C2D1;
 Wed, 11 Mar 2026 18:05:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.1.5 13/46] target/arm/tcg: Allow SVE RAX1 in SME2p1
 streaming mode
Date: Wed, 11 Mar 2026 18:02:49 +0300
Message-ID: <20260311150327.1084669-13-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
References: <qemu-stable-10.1.5-20260311180252@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

The SVE RAX1 instruction is permitted in SME streaming mode starting
from SME2p1.  We forgot to allow this relaxation when we implemented
SME2p1.

Cc: qemu-stable@nongnu.org
Fixes: 7b1613a1020d2 ("target/arm: Enable FEAT_SME2p1 on -cpu max")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260202133353.2231685-5-peter.maydell@linaro.org
(cherry picked from commit 433097a2242120918090201129e5fbb8e16b3e34)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d69a2f5d75..76e4a6c52c 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7803,8 +7803,17 @@ TRANS_FEAT_NONSTREAMING(SM4E, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
 TRANS_FEAT_NONSTREAMING(SM4EKEY, aa64_sve2_sm4, gen_gvec_ool_arg_zzz,
                         gen_helper_crypto_sm4ekey, a, 0)
 
-TRANS_FEAT_NONSTREAMING(RAX1, aa64_sve2_sha3, gen_gvec_fn_arg_zzz,
-                        gen_gvec_rax1, a)
+static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
+{
+    if (!dc_isar_feature(aa64_sve2_sha3, s)) {
+        return false;
+    }
+    if (!dc_isar_feature(aa64_sme2p1, s)) {
+        /* SME2p1 adds this as valid in streaming SVE mode */
+        s->is_nonstreaming = true;
+    }
+    return gen_gvec_fn_arg_zzz(s, gen_gvec_rax1, a);
+}
 
 TRANS_FEAT(FCVTNT_sh, aa64_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
-- 
2.47.3


