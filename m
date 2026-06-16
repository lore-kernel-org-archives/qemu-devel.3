Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733EDCD98E1
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZCD-0002GR-RP; Tue, 16 Jun 2026 15:11:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8W-0004jT-Sp
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:51 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8T-0001E0-Mb
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:48 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso37694145e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636863; x=1782241663; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q0v3JcOtGra5T2P8x7jT2gjDT/0evPGezEh4zg5AF2E=;
 b=Gmy/a9B9YqHWn34HlPGJgge5ZwEnfnvY03SmwKs7PGCzshmDa0Oa5jUZ0UcrqG/jl2
 rKdkcHuFFoirGpSDrAOY69kZ9BZ/3agSQdsU/NvUmNg+HZ2XtCt8gZ5t9Y2eXLeI2BFO
 GNheiWMN364pQtOt08rQO4lpLBqUuGJ3M+OPsJJW0GqoCl9YpT4GdI9EWD0sGoTLaDK6
 /aue+FnOPAxDHOIFowVUsCXS0+3ndU4vwclbjsJSOjuNHAusPK5wCv1JiblSUvc+g3WI
 L3dG9HM8lb0QJbSnQLT1qX0d1gh4vXlHW+7vkANHC4Oppy4LMKW9m7pnwwwX9bylARbm
 2NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636863; x=1782241663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=q0v3JcOtGra5T2P8x7jT2gjDT/0evPGezEh4zg5AF2E=;
 b=cQUhsdxjzGcQfFioOLJmP2vodkGWumH3CjNc4mxLFmUMjpwFsjfU3G+Nt/HyOZTqxp
 esq36SWFJEpzEc3hyfpKG5CTnhlDW2JoIVJdBi4LtRjQNzfOl63PEM8NRU0SruQ+kYb+
 4sRsxYIijvBxM6VbfCVUW9yesuztZtMC2oipn+wt0jyxgSxnouxluZBLVksxaPWWBdRY
 QHQPce+G97HoZkkSJYgo6Rko0avHC5exULtSpkN6wWKAoyaY7O0WGM0uaIZTenZgclnh
 /wYoJGaKp8DNQKm8Vo1hdmtc4ZPj79DQ6dB75qVfZqUB1U9NWRUEjI4eO5L1AWIQ/BUm
 6l7A==
X-Gm-Message-State: AOJu0YwUz36mR//B36zxY/18wrQxyaP7SyqvDWw+gicPVV7AjlOiYdyF
 I5ILlZn/GUWhMx5IC6jBORoycETLs/TPRGQlohSEqb9sq9x2chdM10K9VMWPjwNgivelISB03f5
 en2QT
X-Gm-Gg: Acq92OFirnH3b88Exuje0WKgAItqF7x0Mozv32oSGz7Mn08NliBC4AW3X+NlH0mxxPD
 sYZQvxQcyvhfNOnPqDqccIavarbkVayLm5gabzzVXSdbHhRZRsPEQgFmk139pJxN/To0VPeYIYM
 /TvpqEOWfFTSNZk6Tsje478Znyadj6gWWwTWkBB8GnDJVL/8s5vHFvaEAhe039DRd5DwxNa19oI
 IksWjA9K2nevye66S858JwiUf8RhzBLTauYERCnAgu/8oakbtwoR91KH7RAl+w7+ahGGgAf5IY9
 T/TlU14/VSx3blIisNzy4WB/s4boeAFNM94B7UOMBvsS7rSABZ0wUpLc6wfUqTUVVXwzZ3Z/hs9
 zESHWr8pzW3TBadt4UKxSmM/2W0dLGOHnBuO1OZQZ5YdqIG06vS4ZpklI6NwGWZocEfqEntkAlQ
 yOj5wuLj9JOqUuV29nuQFJ8wgjQukQckL9PUkjRXka3toqYflNZ86zY25G5e74y5ZQOpuYm0v/D
 4cvy6IhLaqiQmfXORKq67bt4UM2lhd7
X-Received: by 2002:a05:600c:8189:b0:490:688b:f9f8 with SMTP id
 5b1f17b1804b1-492333dd136mr14472375e9.27.1781636863228; 
 Tue, 16 Jun 2026 12:07:43 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:42 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 56/61] target/arm: Implement Floating-point square root
 (predicated, zeroing)
Date: Tue, 16 Jun 2026 20:06:33 +0100
Message-ID: <20260616190639.3462006-57-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Richard Henderson <richard.henderson@linaro.org>

This is FRECPX and FSQRT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-14-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 3 +++
 target/arm/tcg/translate-sve.c | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 889ff85f72..c39d80360f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1263,6 +1263,9 @@ FRINTI_z        01100100 .. 011 001 111 ... ..... .....         @rd_pg_rn
 FRECPX_m        01100101 .. 001 100 101 ... ..... .....         @rd_pg_rn
 FSQRT_m         01100101 .. 001 101 101 ... ..... .....         @rd_pg_rn
 
+FRECPX_z        01100100 .. 011 011 100 ... ..... .....         @rd_pg_rn
+FSQRT_z         01100100 .. 011 011 101 ... ..... .....         @rd_pg_rn
+
 # SVE integer convert to floating-point
 SCVTF_hh_m      01100101 01 010 01 0 101 ... ..... .....        @rd_pg_rn_e0
 SCVTF_sh_m      01100101 01 010 10 0 101 ... ..... .....        @rd_pg_rn_e0
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d610ea561d..1ea9454267 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4736,6 +4736,8 @@ static gen_helper_gvec_3_ptr * const frecpx_fns[] = {
 };
 TRANS_FEAT(FRECPX_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            frecpx_fns[a->esz], a, 0, select_ah_fpst(s, a->esz))
+TRANS_FEAT(FRECPX_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           frecpx_fns[a->esz], a, 1, select_ah_fpst(s, a->esz))
 
 static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
     NULL,                   gen_helper_sve_fsqrt_h,
@@ -4744,6 +4746,9 @@ static gen_helper_gvec_3_ptr * const fsqrt_fns[] = {
 TRANS_FEAT(FSQRT_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            fsqrt_fns[a->esz], a, 0,
            a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FSQRT_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           fsqrt_fns[a->esz], a, 1,
+           a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 TRANS_FEAT(SCVTF_hh_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_scvt_hh, a, 0, FPST_A64_F16)
-- 
2.43.0


