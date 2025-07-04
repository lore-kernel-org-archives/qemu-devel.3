Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4116FC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFG-0003J5-IX; Fri, 04 Jul 2025 12:26:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF1-00020U-DE
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEz-0006ot-02
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:23 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a4ef2c2ef3so920277f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646379; x=1752251179; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uvLxwbCupAK+3EpFNB3NftRQL8haeiWoSId0SmdVDeU=;
 b=UcU848pnLrEE3fihTRBf9panIgCN2wZonA16LYnVO3+Bw80vL5PlUY4YkULTE0QFVd
 bhkI2+PE2gKVNS3P/fGHCSqPzFxD+H8Z9sqytHacZIfmyQapH3K2J5VdDkE5ZsJ1hLqN
 pfy2btNvfGtzHD8jXuIkcEBSQbljMXUnNFLAiZ5JH2H15NgQltXm3ntIT6vjY6a//ohh
 PzjauEV8iwYEmVGeYQ7wzeLjtdOlVVGsK2venLionfRXWeK5qUmSuRlp6wHSPoAiKA4o
 nm/EI5ImCzxodPLpDcqHxY5cvxn3lVCT/wuhq1XqjnhFKK5i1qCikbIdZK8quBlEHP4N
 MVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646379; x=1752251179;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uvLxwbCupAK+3EpFNB3NftRQL8haeiWoSId0SmdVDeU=;
 b=UVfuSuDqfceKbeWVm+tCpLlJonf/QMMixnwXxECaNh0RBEr6aiSbFX9DULnuVSWhXT
 QGOkVqPSJWK185l2J7oL3DJYruIISAP0RzBdlXJ1BlUyH13yZSCiScXhfMStoC4Bno1h
 T/S4fpCSe73W9bmlc9j0dOs105tepwlVA2gDxWgS4s0o7b4+zyjQ71zL6WWlnAxxdZ7f
 Vor7hPpIzwlJngJ5c2W2IxMz0aANEi/zMwmJ0htD1LYTDNoaXDKoe0X6kNIXg/k0vIKP
 AA3K53+/RZ95LhYY01uqLvG9lJQdQHWGXaJAoIlyYW205G1Ff+RrHqJUcTt6JsQUET0s
 BU0Q==
X-Gm-Message-State: AOJu0Ywlbte6b4hy7oS5KX9pMApZ32JV2csiGyBLQ3xX5PTyB523Bepb
 eVqd5nURtwt9juSs4qqYPjDGxRRrNpA39mxWzZjw5t1tqR7F4SCLUE8xMlHNiVNoeOPc5wpPLwJ
 J9N/P
X-Gm-Gg: ASbGnct0a0WEw+KGR+BhGTH83x35nuVMfq9K9UPpk/SpnRPn34L/y+PyxXQR0olp4AR
 dOzWWpPSDUzm2LI0FodoDldpF7JB4FLbbnMwA6JiWRbygYRIw7nLjq2WdC5KRfoDmARIVWgP26Y
 Ag9fof+tw7VXgIoi11c1PylVQ9KF6LruGXgDb2FkGv3SSkgGvN5O826QIXUc+SRR+lekFypfwfj
 kdEDgiD8b6cu0424Ek8nfJjfdkDU2DbmvbfQctyTMqcomQeBa+11M63B7JP30MiE51l96XKodUG
 lCc92j6ghRplJaeIJPSeWvoIq4EkTy76xlOOOr7DewLQj3N7k1N5hTMv+B0a4eN71S8P
X-Google-Smtp-Source: AGHT+IHQAqTgbwWDp8Z7XS4nqu9GKSB8hoRs9/ejATyEpimLzqrnoH3QBNUvpUpP9niBCrMu4y7WkA==
X-Received: by 2002:a5d:5f87:0:b0:3a4:ebc4:45a9 with SMTP id
 ffacd0b85a97d-3b49700f171mr2069133f8f.19.1751646378772; 
 Fri, 04 Jul 2025 09:26:18 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:18 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 079/119] target/arm: Enable SCLAMP, UCLAMP for SVE2p1
Date: Fri,  4 Jul 2025 17:24:19 +0100
Message-ID: <20250704162501.249138-80-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

These instructions are present in both SME(1) and SVE2.1 extensions.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-68-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-sve.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index ac4dc7db461..ff70bf27b01 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -7375,7 +7375,7 @@ static void gen_sclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(SCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
+TRANS_FEAT(SCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_sclamp, a)
 
 static void gen_uclamp_i32(TCGv_i32 d, TCGv_i32 n, TCGv_i32 m, TCGv_i32 a)
 {
@@ -7426,7 +7426,7 @@ static void gen_uclamp(unsigned vece, uint32_t d, uint32_t n, uint32_t m,
     tcg_gen_gvec_4(d, n, m, a, oprsz, maxsz, &ops[vece]);
 }
 
-TRANS_FEAT(UCLAMP, aa64_sme, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
+TRANS_FEAT(UCLAMP, aa64_sme_or_sve2p1, gen_gvec_fn_arg_zzzz, gen_uclamp, a)
 
 TRANS_FEAT(SQCVTN_sh, aa64_sme2_or_sve2p1, gen_gvec_ool_zz,
            gen_helper_sme2_sqcvtn_sh, a->rd, a->rn, 0)
-- 
2.43.0


