Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6AEC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgQ-0007YN-A3; Mon, 29 Jun 2026 08:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg1-00073x-Gn
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:26 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfy-0007bR-Rg
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47231f1f8f3so2284586f8f.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734481; x=1783339281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c1CLvQpxi98w8hCCGMuReQm8cigrXYogjEHOmllUeYE=;
 b=nL3qATjdfDykB+JdT7SCr00T3/hR9aP4fIJQqqOm7JVSA6PHhCWIvlcmiwkqZA/eAh
 gDBy4J/q1+/u5t746jM+7oNM738wfM3eTu2MiNGFc3euPZ1ODkGajLjANZDeSH8sRBzQ
 KPElxRDGgEbSrwwIC+1Yeyb7cMeKC75fcepmjlvH6ZfDJw1GfBrkiBuFhyBqnVQjzEGM
 tXcVqTZKhazO1f6pW8R63ab1+YYgrJSaE3b679N/6CzjYeq8r/Pc/lAZVljQE6QYRY/h
 nwFziv8w4M4VC5QdiEvrpLuIj/QoNWDpEYPcQCPL57yaxWYs5RC50KuRrd20AM0TRtWg
 FICA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734481; x=1783339281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c1CLvQpxi98w8hCCGMuReQm8cigrXYogjEHOmllUeYE=;
 b=TZKMnc3ovT0IRGpD6eiVVABX3hI9hakEiB3/UFu+ezMnFjpCG4MTdhXYHSDx7YD0VG
 lUiDqfjL+/5p9Nw2gK4r9fNKOtHxUN5rJeG+MpdeAThEtflSmE+OPyRT6z+VC6wulXYL
 eV2OTK4BgHWBgCJ6Ijhw217lV6u32T6jsTq/z93/Lmkm4SxiLVg6aiXbCMfe8V0P3VpJ
 n0JeNK/NpQyoON4gOwLVAXvGdyg1dmEiW5pMEplJTahFyDAw9o3+vk09H4FQEmuC8jFL
 so8+kFHHy2y0SkNn0LzlfomgWqx3Q+JL0UC9Q4ifkfFfVQ22uHVAoykkKNN6ESjrNqiH
 v5EQ==
X-Gm-Message-State: AOJu0YxAYdmaUBDXduHrcssXhZXBJZamCfoVQaWQgRWfBc/+Nxb2q4XB
 VZY4s0WlcxpA+0vafgZbNDI8QBryy7A6Ni2ewwH9WlMSOy7B9PZi5mhqUX1Oq6roU7ir0SkVEt3
 WkWsj
X-Gm-Gg: AfdE7clnZMdwMdroaia4E3dWZ1cFYg714Oa6rslw8+IVxdWTIgl73998/w1NLK3lmi8
 OE+gsqO4ARiOI5GwC8hqFLM5Yq4mUgJ40tCXj9et2US3UMPa+6Yby+Vq0oENIjzx+fcZIvNiaIj
 QUMM2ELc0f+ZMUgnMaOnjct2863jnzf7PSw2X5DVNscAPIT4i+GQjSYwz3LhP/0ZIJm9CTmmVlF
 1ONKURfFxFRThYhBykG+7EMb5QMImt6PzDwiCgo0paQfmA0KHABBBe7ovOL7rCRRbH/hktKdHM0
 rk+3ehAvZcwu6vnWRhunIPYkUmxOBuTgBjQR8ORx3XND4CwryoQ44yLRLriRhlqWNyPAtxcpTTM
 flN8eNIHGAvq51JO54WP8H0ZsdWc88zjAAkDi30GcxJ/SBRD+eB8kXyNPRn2oY50qDPgZaWaQej
 u6WIhDcUkB8sWHVoiX+C4CjtQdkfKFyTeDAXNKNQFblhnQkCeaFHHMIQB1iPAJdeOPkvfmH04pl
 nocdbtmdXJeF6/3NZnrWg==
X-Received: by 2002:a05:6000:1882:b0:462:7add:607 with SMTP id
 ffacd0b85a97d-46dc0e059e8mr26388231f8f.25.1782734480980; 
 Mon, 29 Jun 2026 05:01:20 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/54] target/arm: Rename SME FMLAL/FMLSL patterns
Date: Mon, 29 Jun 2026 13:00:23 +0100
Message-ID: <20260629120032.1645265-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

Rename patterns to include _sh suffix, so that we can
distinguish insns of the same name from FEAT_SME_F8F16.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260625015159.719300-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 32 ++++++++++++++++----------------
 target/arm/tcg/translate-sme.c | 12 ++++++------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 1de5f341ef..90ee161461 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -324,13 +324,13 @@ SUB_azz_n1_d    11000001 0111 .... 0 .. 110 ..... 11 ...    @azz_nx1_o3 n=4
 @azz_nx1_o2x2   ........ ... . zm:4 . .. ... zn:5 ... ..    \
                 &azz_n off=%off2_x2 rv=%mova_rv
 
-FMLAL_n1        11000001 001 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
-FMLAL_n1        11000001 001 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
-FMLAL_n1        11000001 001 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
+FMLAL_n1_sh     11000001 001 0 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+FMLAL_n1_sh     11000001 001 0 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=2
+FMLAL_n1_sh     11000001 001 1 .... 0 .. 010 ..... 000 ..   @azz_nx1_o2x2 n=4
 
-FMLSL_n1        11000001 001 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
-FMLSL_n1        11000001 001 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
-FMLSL_n1        11000001 001 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
+FMLSL_n1_sh     11000001 001 0 .... 0 .. 011 ..... 01 ...   @azz_nx1_o3x2 n=1
+FMLSL_n1_sh     11000001 001 0 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=2
+FMLSL_n1_sh     11000001 001 1 .... 0 .. 010 ..... 010 ..   @azz_nx1_o2x2 n=4
 
 BFMLAL_n1       11000001 001 0 .... 0 .. 011 ..... 10 ...   @azz_nx1_o3x2 n=1
 BFMLAL_n1       11000001 001 0 .... 0 .. 010 ..... 100 ..   @azz_nx1_o2x2 n=2
@@ -477,11 +477,11 @@ SUB_azz_nn_d    11000001 111 ...01 0 .. 110 ...00 11 ...    @azz_4x4_o3
 @azz_4x4_o2x2   ........ ... ..... . .. ... ..... ... ..    \
                 &azz_n n=4 rv=%mova_rv zn=%zn_ax4 zm=%zm_ax4 off=%off2_x2
 
-FMLAL_nn        11000001 101 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
-FMLAL_nn        11000001 101 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
+FMLAL_nn_sh     11000001 101 ....0 0 .. 010 ....0 000 ..    @azz_2x2_o2x2
+FMLAL_nn_sh     11000001 101 ...01 0 .. 010 ...00 000 ..    @azz_4x4_o2x2
 
-FMLSL_nn        11000001 101 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
-FMLSL_nn        11000001 101 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
+FMLSL_nn_sh     11000001 101 ....0 0 .. 010 ....0 010 ..    @azz_2x2_o2x2
+FMLSL_nn_sh     11000001 101 ...01 0 .. 010 ...00 010 ..    @azz_4x4_o2x2
 
 BFMLAL_nn       11000001 101 ....0 0 .. 010 ....0 100 ..    @azz_2x2_o2x2
 BFMLAL_nn       11000001 101 ...01 0 .. 010 ...00 100 ..    @azz_4x4_o2x2
@@ -617,13 +617,13 @@ BFSUB_nn        11000001 111 00101 0 .. 111 ...00 01 ...    @az_4x4_o3
 @azx_4x1_o2x2   ........ .... zm:4 . .. . .. ..... .. ...   \
                 &azx_n n=4 rv=%mova_rv off=%off2_x2 zn=%zn_ax4 idx=%idx2_10_2
 
-FMLAL_nx        11000001 1000 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
-FMLAL_nx        11000001 1001 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
-FMLAL_nx        11000001 1001 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
+FMLAL_nx_sh     11000001 1000 .... . .. 1 .. ..... 00 ...   @azx_1x1_o3x2
+FMLAL_nx_sh     11000001 1001 .... 0 .. 1 .. ....0 00 ...   @azx_2x1_o2x2
+FMLAL_nx_sh     11000001 1001 .... 1 .. 1 .. ...00 00 ...   @azx_4x1_o2x2
 
-FMLSL_nx        11000001 1000 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
-FMLSL_nx        11000001 1001 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
-FMLSL_nx        11000001 1001 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
+FMLSL_nx_sh     11000001 1000 .... . .. 1 .. ..... 01 ...   @azx_1x1_o3x2
+FMLSL_nx_sh     11000001 1001 .... 0 .. 1 .. ....0 01 ...   @azx_2x1_o2x2
+FMLSL_nx_sh     11000001 1001 .... 1 .. 1 .. ...00 01 ...   @azx_4x1_o2x2
 
 BFMLAL_nx       11000001 1000 .... . .. 1 .. ..... 10 ...   @azx_1x1_o3x2
 BFMLAL_nx       11000001 1001 .... 0 .. 1 .. ....0 10 ...   @azx_2x1_o2x2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index b8dde80c20..7aa270d3ec 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1107,10 +1107,10 @@ static bool do_fmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
                          multi, FPST_ENV, gen_helper_sve2_fmlal_zzzw_s);
 }
 
-TRANS_FEAT(FMLAL_n1, aa64_sme2, do_fmlal, a, false, false)
-TRANS_FEAT(FMLSL_n1, aa64_sme2, do_fmlal, a, true, false)
-TRANS_FEAT(FMLAL_nn, aa64_sme2, do_fmlal, a, false, true)
-TRANS_FEAT(FMLSL_nn, aa64_sme2, do_fmlal, a, true, true)
+TRANS_FEAT(FMLAL_n1_sh, aa64_sme2, do_fmlal, a, false, false)
+TRANS_FEAT(FMLSL_n1_sh, aa64_sme2, do_fmlal, a, true, false)
+TRANS_FEAT(FMLAL_nn_sh, aa64_sme2, do_fmlal, a, false, true)
+TRANS_FEAT(FMLSL_nn_sh, aa64_sme2, do_fmlal, a, true, true)
 
 static bool do_fmlall_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 {
@@ -1128,8 +1128,8 @@ static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
                          false, FPST_ENV, gen_helper_sve2_fmlal_zzxw_s);
 }
 
-TRANS_FEAT(FMLAL_nx, aa64_sme2, do_fmlal_nx, a, false)
-TRANS_FEAT(FMLSL_nx, aa64_sme2, do_fmlal_nx, a, true)
+TRANS_FEAT(FMLAL_nx_sh, aa64_sme2, do_fmlal_nx, a, false)
+TRANS_FEAT(FMLSL_nx_sh, aa64_sme2, do_fmlal_nx, a, true)
 
 static bool do_bfmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
 {
-- 
2.43.0


