Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE3AC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgV-0007oD-0t; Mon, 29 Jun 2026 08:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg2-000742-OR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:26 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg0-0007c1-DF
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:26 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-473dc4cf238so530188f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734483; x=1783339283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AY/Zg167iyETgJrAOhr/QKX7fX+TQmouyuIS/VgQMSA=;
 b=Xvg4fHNf6ev+OSvtVsIxhBkuhqL8mXF9smhWT0x6YU7fAAy60pQvTTu58Qi28wCYTg
 ALDZP3bnLmnFL6YiWBBG64lY9Y9sp88XKULgmhewVppXVkYjy9cWH1JQ1reLs9SDglyC
 3hRLOM0uvNDHvGVpqE8FTpxJu+9oPfPyQZKHVitS+52nvFWuPY7mHwg1QPBz9slJHH+8
 CGc9mXDvFGLq9XYFWWNsBiTPfRgogFO7CmmJnbTaAj69WiB1NH33bxUpZfmETRlvg1J/
 cBGwG5LCddb7KAm4jhXvw3wM4otMd6hUQw/WuRo+WQTLs5sOdOH4p4nrSgJ9RNkuQnCN
 ONgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734483; x=1783339283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AY/Zg167iyETgJrAOhr/QKX7fX+TQmouyuIS/VgQMSA=;
 b=H03sV2P66BS1TCTqEv/i+mWt9bGnxOGyYnNH8mHrnCiYgLF0pOMcAZHSrg2XlLla5n
 svKoQOjLStUQnm83UdknKYgyE5CoYwqYhQz+L5HkzYpbu5vHrvkTeurymZgmyl4W7Q0I
 BNl2r2pR1aEbsa/c5zZDkRfiGcyAxc18Je9fv3M50XUIp0PAlFYlR4X453yPia53cKn2
 ifH8oUuCzBU6mHXZsRBoonxpnV9tWWcuP032sanx7mSSrkavCb6N25xsY5gvGxfCQKZ0
 LoS5sh/lHsE01pJurTjszoSeYZh1usELzqc+R3Cpjx3T9ELLLxfMkslVdmQGIE8m8gvy
 zeZw==
X-Gm-Message-State: AOJu0YwmmhaLvhWxuxdMu2zc0BLOAxlsKdBkjtP7g1vlEafJ/E8L/s5G
 kblWbtar0VK0Hz2jDkAkBh+zdnrANJeTqhfljbO2NzfBplxT28T7d4MlZodwdc65ggqWPRC/1vG
 pPIoq
X-Gm-Gg: AfdE7cnl41lVqoPEquB83hf6rBlxKlLPthopW0DRsV+R4Jqp4Ji51QZolEZNjACqTtM
 9giJgXy8tCbYob4Zl/LyIEa8da6lo0mIia1HDfOIlmTTnwYKRohPffHdVJPObP7COdh1cSlgVfs
 EMghRGnVIaZJEKpSsCJNB3Xn9T5s+OdXJLgsZToiJ6KoCcUwymDNKJSYFOK8aqn8XXiM9qjFQwB
 DJRHmxzAN1tyL67ktwSQRT1av8O71CTReHe5gdt/+GEr9JRH3BsDdRE44i/FTKWMQNJArtVkfMf
 X3hubqo+dpV/z9T9a9nWcBfCQONNk3dyqKu4sTeJdKaqjp5hQ1V4nl/hiru2HloiJfYNjlQFOjX
 QFV7G9NMdRgnmxkNd7l52MndCH5qkJcMzu6CGzI84/wOp1FxvGeqGrAWmcoI93oT3PC1q+jmbyM
 cMOEiHY+wYxHpMxIPbXUsZhyNeTkxBssd+X7XFKeQqKP+RSvubKkkLyMebW7Z+7Rsku79ooS9J+
 ApcAyv15MlDZP8Vkc9HiQ==
X-Received: by 2002:a05:6000:4692:b0:472:76ad:b329 with SMTP id
 ffacd0b85a97d-474feeb1b3emr219048f8f.6.1782734482958; 
 Mon, 29 Jun 2026 05:01:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/54] target/arm: Implement FMLAL (multiple and indexed,
 FP8 to FP16)
Date: Mon, 29 Jun 2026 13:00:25 +0100
Message-ID: <20260629120032.1645265-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260625015159.719300-5-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 13 +++++++++++++
 target/arm/tcg/translate-sme.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index b735f3de82..c6e22c4999 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -791,6 +791,19 @@ FMLALL_nx_b     11000001 0001 .... 1 .. 0.. ...10 00.. .    @azx_4x1_i4_o1
 FDOT_nx_b       11000001 0101 .... 0 .. 0.. ....1 11 ...    @azx_2x1_i2_o3
 FDOT_nx_b       11000001 0101 .... 1 .. 0.. ...00 01 ...    @azx_4x1_i2_o3
 
+%idx4_15_10_3   15:1 10:2 3:1
+%idx4_10_2      10:2 2:2
+@azx_1x1_i4_o3x2 ........ .... zm:4 . .. . .. zn:5 .. ...    \
+                 &azx_n n=1 rv=%mova_rv off=%off3_x2 idx=%idx4_15_10_3
+@azx_2x2_i4_o3x2 ........ .... zm:4 . .. . .. .... .. .. ..  \
+                 &azx_n n=2 rv=%mova_rv zn=%zn_ax2 off=%off2_x2 idx=%idx4_10_2
+@azx_4x4_i4_o3x2 ........ .... zm:4 . .. . .. ... ... .. ..  \
+                 &azx_n n=4 rv=%mova_rv zn=%zn_ax4 off=%off2_x2 idx=%idx4_10_2
+
+FMLAL_nx_hb     11000001 1100 .... . .. 0.. ..... 0. ...    @azx_1x1_i4_o3x2
+FMLAL_nx_hb     11000001 1001 .... 0 .. 1.. ....1 1.. ..    @azx_2x2_i4_o3x2
+FMLAL_nx_hb     11000001 1001 .... 1 .. 1.. ...01 0.. ..    @azx_4x4_i4_o3x2
+
 %idx2_10_3      10:1 3:1
 @azx_4x2_i2_o3  ........ .... zm:4 . .. ... .... ... off:3 \
                 &azx_n n=4 rv=%mova_rv zn=%zn_ax2 idx=%idx2_10_3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7cb7b71e74..98f6eb0b70 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1140,6 +1140,10 @@ static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 TRANS_FEAT(FMLAL_nx_sh, aa64_sme2, do_fmlal_nx, a, false)
 TRANS_FEAT(FMLSL_nx_sh, aa64_sme2, do_fmlal_nx, a, true)
 
+TRANS_FEAT(FMLAL_nx_hb, aa64_sme_f8f16, do_azz_acc_fp8,
+           a->n, 2, a->rv, a->off, a->zn, a->zm,
+           a->idx << 2, 0, false, gen_helper_gvec_fmla_idx_hb)
+
 static bool do_bfmlal(DisasContext *s, arg_azz_n *a, bool sub, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
-- 
2.43.0


