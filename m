Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00B9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgm-0007q4-9N; Mon, 29 Jun 2026 08:02:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg4-00074W-47
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:30 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg2-0007cJ-GJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso41625465e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734484; x=1783339284; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5sk8KjY8y8ofylvHG8Mu0oSbiXIKhLBIzeBi6ZEKPfI=;
 b=RGtqwjtF1gc2YeXboX2EMjNGOltlGX/mFXmA2n7ksoZXd5+2i9Yojn79eI9jr8dS4n
 55GgTLp8/lBkYyUpHP0Mn4KPrJgGCQC36UdZIUgTgRl0f3ifuYDKil5IIt4ilNmZiF+y
 WT0Sf7onj/S4pYGlwOQTQ0S4Gsn5lvO9/4aXGqsPNlNHxFFFqI+fh/XLgyq2zK5pBHap
 n9fHp/pNylwkB5MNkASj4Ba5xQePL9GgaxbeugJlnNQ2ZBx58tZW1Bp4ewEJL908UC6b
 S4p5D3lpfg4SXtUmVy7dP0yjK86lsEtORYHa/+yENUKTyn7jx5wphGtfnY5KSrsWXxW1
 WwEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734484; x=1783339284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5sk8KjY8y8ofylvHG8Mu0oSbiXIKhLBIzeBi6ZEKPfI=;
 b=A1OFJDLMk6QY1lQc5qTNGYRe/4V/Lea8ATOsUPjSQu5XXdD/7HzOLLRzzuolbtqFwG
 +xTbFHDn0eLdL6knSuvHiZJaKGcrLNhGsC9J14YkAmp44A3qeNXVkPi7eJt+JuZuc9j/
 CBpV6nBWDh82FgxRAfLdDfvmt1a3Ru3gmzLgc+CHEzTQpDzKZe86IELmOH5v2l5CMWOa
 zfuyWAbp+SpH7RmRlX5ZlpefAa4cjxZHtceoatse7+5r6yMqsyPdcL5o2PWFN0IPmmwk
 udrmrRdlks3aNt9nrtKytm3h0pLWMtB25+HJwC1bI/eKVtIzizdlv67lbyzwDXqmOotb
 LbKg==
X-Gm-Message-State: AOJu0Yx+Iqu6+U4u/7O8h9qQa4H3PIBFs4ldfiWhpOnTfSgMiYoCD2bd
 LCSfPtc7RHMqj2kI2+wpHIrPW2NIcAFlRptbcZcFLWy9zATlqzERJajjq502reJEUa9NH+l2bLN
 JIyeu
X-Gm-Gg: AfdE7cna5/swHbmwHX1gKVQ90oVHZG7hpWCdcRqByFH/1qdJl2T6tfIEq7xukmq+TWk
 tei1vjF93FnX4ius6+MuEQjvL6fWXpOkAVOMbOft2OZonMBi2O7lap35+dW3/1HUd8tDFE0PU+s
 i6+DOyBTlwpAl0ojayFbxI3Rt4qFcisblQ6bZOATEk4Yu6+IqyHxNCw2UPePUi//p2+OqO+DUFl
 YxMPq1aNutVgvsFqoj6nN6C9z+GcIjSTiMNE7SeEAaICOZ5xrFJkrJE2YDGF1pColZKWE7eSkqD
 BWV2gK4jJGiJjFc2d8GQJVKA9t0F387QGxjbNyoYlM2o27jIhZHxK5n8KD/PNlP3hqPJfCLJ6sx
 1XviA56Phf9k04BuyGRT5DxrwLri9vlGeBfG9M3L2BgGFltYVQZ0STfQGPEyeBzYvt1CAtjcjI3
 Au/hdVUlI6rZO66C8GnAh2YiSLmc/4mUR0uR4jRQvpryK20E6nz8Go4GTRop0UQSV13l/ExzZBR
 RVCuIvvOn2ZJYwNVuxCNA==
X-Received: by 2002:a05:600c:3b85:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-4926683231fmr253198205e9.2.1782734483883; 
 Mon, 29 Jun 2026 05:01:23 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 48/54] target/arm: Implement FDOT (multiple, multiple and single,
 FP8 to FP16)
Date: Mon, 29 Jun 2026 13:00:26 +0100
Message-ID: <20260629120032.1645265-49-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260625015159.719300-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 6 ++++++
 target/arm/tcg/translate-sme.c | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index c6e22c4999..fbf5f3720d 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -456,6 +456,9 @@ FMLAL_n1_hb     11000001 001 1 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
 FMLAL_n1_hb     11000001 001 0 .... 0 .. 010 ..... 001 ..   @azz_nx1_o2x2 n=2
 FMLAL_n1_hb     11000001 001 1 .... 0 .. 010 ..... 001 ..   @azz_nx1_o2x2 n=4
 
+FDOT_n1_hb      11000001 001 0 .... 0 .. 100 ..... 01 ...   @azz_nx1_o3 n=2
+FDOT_n1_hb      11000001 001 1 .... 0 .. 100 ..... 01 ...   @azz_nx1_o3 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -585,6 +588,9 @@ FDOT_nn_sb      11000001 101 ...01 0 .. 100 ...01 10 ...    @azz_4x4_o3
 FMLAL_nn_hb     11000001 101 ....0 0 .. 010 ....1 000 ..    @azz_2x2_o2x2
 FMLAL_nn_hb     11000001 101 ...01 0 .. 010 ...01 000 ..    @azz_4x4_o2x2
 
+FDOT_nn_hb      11000001 101 ....0 0 .. 100 ....1 00 ...    @azz_2x2_o3
+FDOT_nn_hb      11000001 101 ...01 0 .. 100 ...01 00 ...    @azz_4x4_o3
+
 &az_n           n off rv zm
 @az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
                 &az_n n=2 rv=%mova_rv zm=%zn_ax2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 98f6eb0b70..3174b10c30 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1196,6 +1196,15 @@ static bool do_fdot_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 TRANS_FEAT(FDOT_n1_sb, aa64_sme_f8f32, do_fdot_fp8, a, false)
 TRANS_FEAT(FDOT_nn_sb, aa64_sme_f8f32, do_fdot_fp8, a, true)
 
+static bool do_fdot_hb(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fdot_hb);
+}
+
+TRANS_FEAT(FDOT_n1_hb, aa64_sme_f8f16, do_fdot_hb, a, false)
+TRANS_FEAT(FDOT_nn_hb, aa64_sme_f8f16, do_fdot_hb, a, true)
+
 static bool do_fdot_nx(DisasContext *s, arg_azx_n *a)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm,
-- 
2.43.0


