Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A86C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgQ-0007ZM-CJ; Mon, 29 Jun 2026 08:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg1-00073v-E8
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:26 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAfz-0007bm-OR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:25 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493a5392c60so7730165e9.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734482; x=1783339282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=euOifZv4zIupbBxnsY/yHZQ8MEsDplE3FddbdiVqJek=;
 b=llRobJhBiDG9x113lxG0fWcenKsuDG9Uo/GQaY0S9vwctTGgbVcHtGRTUOL5WEVMcX
 2z5gbDW3PuhC3ODv269T0LIZaFappsoWKj3qXRSULLoqKUC+u3a/55JVSb8pIwFhnpq8
 PecofHs5K0auz+YR2ekb7vN7V/hIlss16k8Alm1heV0N3hyArb68URGmPrkNz0ZIsfZc
 fzwnhGQBobBBg4hKlKNqhTOHQYNVIdU0y1b52vMesi2lxmpen7LCrfaT15rKliJGsJ25
 rVZJYU3MFXQJfXElyICKuWsdYrg116Ot3DqDxzRuD/qoNAoVIeRRucrKDFLrT9E3cQ2Q
 U4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734482; x=1783339282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=euOifZv4zIupbBxnsY/yHZQ8MEsDplE3FddbdiVqJek=;
 b=idpe7pwzv++s937PtjTmF+T0ZGjMJ5GnWmQZZNbnwsATKh/N98WAjVwssWidxcS1DQ
 R4icMWTqgMipssW8bkPM0u2YMfho6OAu03PqKNu9vQPONoPWu01FL+dhCGuWpX3YG6fW
 ckbjJ+DZmxQdue5anOGqMFm+1KFKZXME/4Loax6yn1YbtX0Akm7pd+5BGZtFymFW70TE
 Ci+xu4c2jdJtJA3FIq2veplbzVNh0UyC3g0NdcFbmBJx3+PYyW8Eovj83JqIPhbj69J5
 X8+V3J/r7TfWyHmt0S8vq9zrHarGoc/zEm91E160/Huw7mqpLGU64KAndCB0HdDV08d9
 C/YQ==
X-Gm-Message-State: AOJu0YwMLrhFk0jcpgYgCGH7PAfYXqzyw+48v5zs5nUsJhD9eP5ddYct
 8+wLyWhVoG81hpK1s/MwJVr2xfy24EmoKg+pQA9Il5kMI/JFZnXuRPWD09qGfwE6UtaEmtk+b+U
 UcVqs
X-Gm-Gg: AfdE7cm11rQbogQLyNEnh/SKeMz80ZC0eozCTxyFEw2/7mhE4NJyqbwi7jbQ3PT8MF9
 nP7pdcZc5PCJ8+qkYbA7QNi6FY4EPsVZ8S1NE0meFv9r7SVhgpAsc1UrHzY8b2CEbN0JNTgeZGo
 jQt1m1ArtZ0QTdKwIOu4TcRT/VAjr2YQbHNdeRAOrZ7CTO5Oh6Mka04aCp4DwMycvI9Qbx7mOG9
 cXcuti69nVQdCOHmIY6iaPuXEf6B97E8V9dViJ1pN3a4ofwdDQm6kIwLNlX6IHKBz42LHKSO21A
 1mUfJWW3HgT9DOzYGnCHCc+1POQ+MwWSwF0j6XMkjQR1X+DgyGH2tEGT/Ht+xwETgEO8LYFTryN
 UxxkWjFCY66nw7OXwrw7omZWUCV630A4lklgrkfBp4urHVhpalVBWyMfX82a4ThezxGlYwqhTYO
 rQteW7O12jiZy9GD/a8cixce1R/DENMtD+7mOnrz0WTfTGlU5Xy32Nzh23D0otiju8o4humzEGX
 k3apZajTBB+2zW8njha8w==
X-Received: by 2002:a05:600c:6385:b0:490:e190:3b50 with SMTP id
 5b1f17b1804b1-493b71971e9mr9193475e9.9.1782734481958; 
 Mon, 29 Jun 2026 05:01:21 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.21
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:21 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 46/54] target/arm: Implement FMLAL (multiple,
 multiple and single, FP8 to FP16)
Date: Mon, 29 Jun 2026 13:00:24 +0100
Message-ID: <20260629120032.1645265-47-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x335.google.com
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
Message-id: 20260625015159.719300-4-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 7 +++++++
 target/arm/tcg/translate-sme.c | 9 +++++++++
 2 files changed, 16 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index 90ee161461..b735f3de82 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -452,6 +452,10 @@ FMLALL_n1_b     11000001 001 1 .... 0 .. 000 ..... 0001 .   @azz_nx1_o1x4 n=4
 FDOT_n1_sb      11000001 001 0 .... 0 .. 100 ..... 11 ...   @azz_nx1_o3 n=2
 FDOT_n1_sb      11000001 001 1 .... 0 .. 100 ..... 11 ...   @azz_nx1_o3 n=4
 
+FMLAL_n1_hb     11000001 001 1 .... 0 .. 011 ..... 00 ...   @azz_nx1_o3x2 n=1
+FMLAL_n1_hb     11000001 001 0 .... 0 .. 010 ..... 001 ..   @azz_nx1_o2x2 n=2
+FMLAL_n1_hb     11000001 001 1 .... 0 .. 010 ..... 001 ..   @azz_nx1_o2x2 n=4
+
 ### SME2 Multi-vector Multiple Array Vectors
 
 %zn_ax2         6:4 !function=times_2
@@ -578,6 +582,9 @@ FMLALL_nn_b     11000001 101 ...01 0 .. 000 ...01 0000 .    @azz_4x4_o1x4
 FDOT_nn_sb      11000001 101 ....0 0 .. 100 ....1 10 ...    @azz_2x2_o3
 FDOT_nn_sb      11000001 101 ...01 0 .. 100 ...01 10 ...    @azz_4x4_o3
 
+FMLAL_nn_hb     11000001 101 ....0 0 .. 010 ....1 000 ..    @azz_2x2_o2x2
+FMLAL_nn_hb     11000001 101 ...01 0 .. 010 ...01 000 ..    @azz_4x4_o2x2
+
 &az_n           n off rv zm
 @az_2x2_o3      ........ ... ..... . .. ... ..... .. off:3  \
                 &az_n n=2 rv=%mova_rv zm=%zn_ax2
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 7aa270d3ec..7cb7b71e74 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1121,6 +1121,15 @@ static bool do_fmlall_fp8(DisasContext *s, arg_azz_n *a, bool multi)
 TRANS_FEAT(FMLALL_n1_b, aa64_sme_f8f32, do_fmlall_fp8, a, false)
 TRANS_FEAT(FMLALL_nn_b, aa64_sme_f8f32, do_fmlall_fp8, a, true)
 
+static bool do_fmlal_fp8(DisasContext *s, arg_azz_n *a, bool multi)
+{
+    return do_azz_acc_fp8(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
+                          0, 0, multi, gen_helper_gvec_fmla_hb);
+}
+
+TRANS_FEAT(FMLAL_n1_hb, aa64_sme_f8f16, do_fmlal_fp8, a, false)
+TRANS_FEAT(FMLAL_nn_hb, aa64_sme_f8f16, do_fmlal_fp8, a, true)
+
 static bool do_fmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 {
     return do_azz_acc_fp(s, a->n, 2, a->rv, a->off, a->zn, a->zm,
-- 
2.43.0


