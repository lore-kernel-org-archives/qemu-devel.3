Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 327D6C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjEX-0000iL-H0; Fri, 04 Jul 2025 12:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEW-0000hl-6v
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjEU-0006JM-MA
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:25:51 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a54690d369so1116360f8f.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646349; x=1752251149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KViCSv4uoShwRvBrHu/x5dSvyBEtPh8EP04OjHj43FU=;
 b=yO41g2FaNfTPcZl5aO8O3uB7BgOa99CuDot474rf5Ij/bJ+BH3E1n3c52pxUrvQDth
 yNheoTwkhs5lT05MRaq4/Uv4ZjPne3kxCaoUfntqzcXLTNqdpS82xkrip6rhhIvXFLeD
 htNEnq8GLnkzNN2vO4+a2jxZgLojt0LG6Ev5cWyAgZhFn9tshzYTpB8Z8rCoPES1rXiX
 VX9hx9FkomU3WBREmYKVD//0tF9zTq+bP0mz350LnPyWFGR/ldRI2+OzGs6MHGl7CqBZ
 +Hx27xpBtcQjtlZ5t9aqzb36JgwXNuKpTv1/WFvNUmF/BsYmW+atCwuI1JUlpGkJ/Gc0
 3ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646349; x=1752251149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KViCSv4uoShwRvBrHu/x5dSvyBEtPh8EP04OjHj43FU=;
 b=GmmjGE3YaM2q1oqD117vNGOhZLR3lbeAfuzM6wIgn9qVSjMQarBQp2i7oavkrqaBZ2
 +5xakienkDWz5YNnrfj/fYBy0AHjPDcqKNz6GaoNv2r2suPjUYrXlivjoLqnpGOaJcaM
 uqGEtqR99RbUvrdvQAhv/J1cLqDEOdN6sZvSOkaLki5jfkFlhdKwERQM1MGgCRLyo92e
 0NszZEulf+LLxCjValP8xZhlmtgfAsYvmvjkH4RLBnqX45FOZnCTaP6uQHSnzz333m7E
 tsuRp+6+Rukdt9It9TQXp7oidZ4lwKYJ4Tw/2VnGBsqRcKSjIqGcVHRZs5XlhlTK4Ms2
 Z6rQ==
X-Gm-Message-State: AOJu0Yytne24i/HLOJTZJ+H64msIe8uS7JM6L88QOERzOgEPMcjpk+1s
 H3WhLMCh8RWf1Na3G/4+Id8fa+tvleefruWZoRBvC9/odh3T0BDbnFB+vHuDUCKbEyEjJpkT2SY
 Ej7PL
X-Gm-Gg: ASbGnctUWo5SaUpXGcoXge+Y6UA6EkdfS6fvIQMOstga8cImjMEtT+nWbtWajfBVO7v
 IEdvn/NQFa6OCQCT5dA/9Thvz3+FKfIHB23RgqLjEUAZPNPTJD94ElUlZEUXamDWbQuRx5q4sEb
 qeTPkKaB9nJRt6EY/RQ20QHn05zCKknK6QbNfVGkrjfHR7lffvhy9zF6v4EDDtERNGP9THUg4rE
 Ay0CHmnqCZIBQKPdWV4AgsWZby6iZf76ry6Nkf+Uw5NvXqTWDy8f3PJx2+0R6X7aJnALYBgs2Hm
 dq5GpaxcTU5Uy7XRn0XIn9XzFFlcnVRPqEwi1496RtuqMOGTzH7b1iZvuE0Mv7lmHln0OyXfb/2
 Lb6E=
X-Google-Smtp-Source: AGHT+IECVfI/s5GsWf9VBRPFa8JzLSVFKEY2VB1Jtmjl7ZyfDH9BIumjaBRpmDMe+YoA+/loWT7ayQ==
X-Received: by 2002:a05:6000:2dc1:b0:3a4:fc07:f453 with SMTP id
 ffacd0b85a97d-3b496fef732mr2258410f8f.8.1751646348921; 
 Fri, 04 Jul 2025 09:25:48 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.25.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:25:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 050/119] target/arm: Implement SME2 BFDOT
Date: Fri,  4 Jul 2025 17:23:50 +0100
Message-ID: <20250704162501.249138-51-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-39-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      |  9 +++++++++
 target/arm/tcg/translate-sme.c | 17 +++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index a2b93519c48..18e625605fb 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -288,6 +288,9 @@ BFMLSL_n1       11000001 001 1 .... 0 .. 010 ..... 110 ..   @azz_nx1_o2x2 n=4
 FDOT_n1         11000001 001 0 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=2
 FDOT_n1         11000001 001 1 .... 0 .. 100 ..... 00 ...   @azz_nx1_o3 n=4
 
+BFDOT_n1        11000001 001 0 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=2
+BFDOT_n1        11000001 001 1 .... 0 .. 100 ..... 10 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -328,6 +331,9 @@ BFMLSL_nn       11000001 101 ...01 0 .. 010 ...00 110 ..    @azz_4x4_o2x2
 FDOT_nn         11000001 101 ....0 0 .. 100 ....0 00 ...    @azz_2x2_o3
 FDOT_nn         11000001 101 ...01 0 .. 100 ...00 00 ...    @azz_4x4_o3
 
+BFDOT_nn        11000001 101 ....0 0 .. 100 ....0 10 ...    @azz_2x2_o3
+BFDOT_nn        11000001 101 ...01 0 .. 100 ...00 10 ...    @azz_4x4_o3
+
 ### SME2 Multi-vector Indexed
 
 &azx_n          n off rv zn zm idx
@@ -365,3 +371,6 @@ BFMLSL_nx       11000001 1001 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_o2x2
 
 FDOT_nx         11000001 0101 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_i2_o3
 FDOT_nx         11000001 0101 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_i2_o3
+
+BFDOT_nx        11000001 0101 .... 0 .. 1 .. ....0 11 ...   @azx_2x1_i2_o3
+BFDOT_nx        11000001 0101 .... 1 .. 1 .. ...00 11 ...   @azx_4x1_i2_o3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 761584c90b1..965a49465e4 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -921,3 +921,20 @@ static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 }
 
 TRANS_FEAT(FDOT_nx, aa64_sme2, do_fdot_nx, a)
+
+static bool do_bfdot(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 0, 0,
+                         multi, FPST_ENV, gen_helper_gvec_bfdot);
+}
+
+TRANS_FEAT(BFDOT_n1, aa64_sme2, do_bfdot, a, false)
+TRANS_FEAT(BFDOT_nn, aa64_sme2, do_bfdot, a, true)
+
+static bool do_bfdot_nx(DisasContext *s, arg_azx_n *a)
+{
+    return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, a->idx, 0,
+                         false, FPST_ENV, gen_helper_gvec_bfdot_idx);
+}
+
+TRANS_FEAT(BFDOT_nx, aa64_sme2, do_bfdot_nx, a)
-- 
2.43.0


