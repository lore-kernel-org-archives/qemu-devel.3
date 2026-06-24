Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FDE1CDE002
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNlQ-0003bD-GW; Wed, 24 Jun 2026 09:35:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNlM-0003TK-HM; Wed, 24 Jun 2026 09:35:32 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNlK-0000pS-Tk; Wed, 24 Jun 2026 09:35:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307997; bh=6xlNGyXQ+fCOU4K82Yr9pLl9TrVrEkNSH6c86ZKUM2U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YlM15+CLRoelmgiKLe4KVgKOlBa0TLegkOwIHuPk/cDED0TONcI6gtXCKu8IXIhL7
 uklltNMIYTVnTl50t+oqnD4EnJ01BYj6jsXs/i/hrk3QF6BOJdYT67x8zKcWXKhZoi
 BTKpUJuj0Ccq6ywlQKDwjmJr2upnSbKtwFfM2866IomUMX+qRWkj9UhZwYXdW1teAt
 0pxHH9b1nSsdNIUL7eTNWnNPj1YSbf160BPgaRQXPpfTmPq2VSjF5kpxBZ5gbiSk6M
 WRQxhobUyk4mlI+3vHrF+6k9Oc7STxI79LW3kCl1+xXY4c8qE76AmvQCthvj7zImB+
 QmiO9aj89IxEg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 11DD91BA9CE;
 Wed, 24 Jun 2026 16:33:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A136D3DEA1D;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 028/107] target/arm: Use FPST_A64_F16 for SVE FCVTLT_hs
Date: Wed, 24 Jun 2026 16:30:33 +0300
Message-ID: <20260624133301.403266-28-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

We should be using the F16-specific float_status for conversions from
half-precision, because halfprec inputs never set Input Denormal.  If
we use the FPST_A64 fpstatus then we will incorrectly set FPCR.IDC
for input-denormals when FPCR.AH=1.

In commit e07b48995aaa we updated most of the halfprec-to-other
conversion insns to use FPST_A64_F16 as part of implementing
FEAT_AHP.  However we missed the SVE FCVTLT instruction, which has a
halfprec-to-single encoding.

Correct the FPST we use for the hs variant of FCVTLT.

Cc: qemu-stable@nongnu.org
Fixes: e07b48995aaa ("target/arm: Use FPST_A64_F16 for halfprec-to-other conversions")a
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260521122913.1565011-3-peter.maydell@linaro.org
(cherry picked from commit aa42300f86d172d7252f0cb95c2efd7570ad6b8f)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 6a5c508743..f9dfda4a7a 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7826,7 +7826,7 @@ TRANS_FEAT(BFCVTNT, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
-           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64)
+           gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
 TRANS_FEAT(FCVTLT_sd, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
 
-- 
2.47.3


