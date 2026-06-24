Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4490CDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:39:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNmD-0005yC-5F; Wed, 24 Jun 2026 09:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNmC-0005wT-5d; Wed, 24 Jun 2026 09:36:24 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNmA-0000t0-Jz; Wed, 24 Jun 2026 09:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307997; bh=i+yfxhU/CaItktIbTAcONgxmHDsA/PtMAephYUbH82s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=tfTVz6/PP4KR6YDUOI7QLWNyxoeABoKo0o0M/WiYPP/f4hRyeqaH6QwL5kEnblmF4
 szNko3BLte9Pw2tvziG7G3skoZRAQRjTCZZxF0w+YZUun1M/bd0sc81/V6I8KIBK30
 DgO6/7ma8ip1Hd3QcByP/9NCVtds7hUmXmjVDqYJnFolnivBoqs8w6fBtY3+plxilU
 cWqhcn/Pexkc5PQXlGRDDULjHB2HZZxwNWJLxotNV5f4TVEcHQBcKGu+jvbjL5YP+Z
 JEgr4wFFk0F2Zl06LNiCC/Jc3h39+umVDO6WWTyKHdc3c6DQlHwcgzzn4gJB64r6Kc
 ruwMQeXEaMSxw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8D8D51BA9D5;
 Wed, 24 Jun 2026 16:33:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2A9CA3DEA24;
 Wed, 24 Jun 2026 16:33:23 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 035/107] target/arm: SME BFCVT,
 BFCVTN have "Alternate BFloat16 behaviors"
Date: Wed, 24 Jun 2026 16:30:40 +0300
Message-ID: <20260624133301.403266-35-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The Arm ARM A1.5.10 notes that some instructions have "Alternate
Bfloat16 behaviors" when FPCR.AH == 1.  We implement these using the
FPST_AH and FPST_AH_F16 fp_status words.  The list includes the SME
BFVCT (single-precision to BFloat16) and BFCVTN, but we forgot to
make those use FPST_AH_F16 when we implemented them. (We get the
ASIMD and SVE insns on the list right.)

Add the missing logic to select the right FPST.

Cc: qemu-stable@nongnu.org
Fixes: 465d36db0e1 ("target/arm: Implement SME2 BFCVT, BFCVTN, FCVT, FCVTN")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260521180854.1744788-1-peter.maydell@linaro.org
(cherry picked from commit ca33de98447c2c2825c1af73cfacf4f65a9bc6c6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7d25ac5a51..6064ed8697 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1418,9 +1418,9 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
 }
 
 TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvtn)
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_fcvt_n)
 TRANS_FEAT(FCVTN, aa64_sme2, do_zz_fpst, a, 0,
-- 
2.47.3


