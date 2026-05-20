Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3535CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:33:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPleY-0008RD-AZ; Wed, 20 May 2026 14:28:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlcB-00049C-Bp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:26:02 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlc8-00025W-QD
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:25:54 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2bd9c3b550aso35451735ad.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301551; x=1779906351; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AeHqaA4eUNZ/cnZls9YTWTYizcqfhEo9ShP2VlzzQbM=;
 b=OWuXbeFELvgPs4d0WiVstqggcTIUHLLv3MhH6uf15m4jyOOlo87a05540ctiwjsTxl
 2/9xEGwNGrx0lJ/lW6tWaFaI4YxbttH+JjAkK4UhUIOrJfC8mgANZaMSCCuKCdT86rRU
 8IwGnUM36zY/auViZC3AUcCIHG5L5E0fT19XFeclg6nMrQnU2md7snEoS0hQmNYzBBMa
 jWasEqAwYbhXPBQJUNIzMYlQRMb0Z9HnZ/1w45U3ygb9hCXWS35kMAJMpBXQy9+c/ADT
 D5sLWxU1TGlvcxFXGWMGzXJ10+Odnd2HiJSJ3jBbIqz4T6/F+d8qshzuHh4sYkdZgDct
 rh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301551; x=1779906351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AeHqaA4eUNZ/cnZls9YTWTYizcqfhEo9ShP2VlzzQbM=;
 b=JFIUbqojkIYKL9rWUfyUxWHp7jCEdPgjjYe/rUf4IOwP9yxfKEuu6rnfHCHWIjPlK0
 ED3wAgz+m6SXmdhJcwuzT8lyBh+lWYXLDGdBJPrqdUDPvAJqV52700MWUsh63aauRUDg
 H0akx48tH86CZ4RnT7Ws5++zEfAMCNdhb3LScPDziI3EOeuUzedc45oVhSd8sYkdvnLP
 /EzZG0X0tQ56tsxG4hHwHiW/z9eNIi9gZP854eLsnd+51sNS71pNC7VR7wk8k5MJgVBe
 WZJ6RNTi1yqv5sTrm2f6MDmwcSeBgoMvMjp0pH0W+FPA8JpVyF0gTyPvROrZRmlsdGOR
 saXw==
X-Gm-Message-State: AOJu0YwR2WCc5P5ES74aHre+FaqZfgwtGmglu2MYLxliPkEIFea/h4tz
 jfpSnGkxqZI6E2FLs28HN7c3TKtRC3Irj5q2pLN9HfAjUZiDdmQ7GxU6SHGojgFwA4h2GK7ggzE
 1jZBoYTk=
X-Gm-Gg: Acq92OFaemuzuG4droaV+PmWluETGAMQ44MpveR0iWVT6VBWuikKEOQtbwGN8e72YiX
 FgaS3wBC/BWjpP2CefUk0/tEgZPE55BLrxPoBzmoguwedmY6AaRfwEPE5QBYYFH92nqd60FY9bx
 ydcQ8Uxg50D3qogAlc0SCO/hUPZTshaB1b/TNZMXbNauxygSp98llRSzytb2bmjzNq+ln/CiWZp
 PuHDYcAdXU27xVUNjPWURzUzIh6/jYztDPWoBOoA/LhqWHMdxWSghtalYXNhMxry1a+wJT1yQNf
 6poG/0uCiF2TpcNkj4MpItTdg4sY0bXz6Kl/VqliwDyLOrAkhFxsMxpkF4Wjam5WqPO9EUd3vwM
 GD4J7//ClC36O9YUDBJf9qlsMmDd0SKIuar197iiWfpvAJWW3E864GMh+NKUe1WwDsqYFCx7hO9
 GotV/sJb9t0WrhtimDS+Urp/yN0U95
X-Received: by 2002:a17:903:2c8:b0:2b9:5d1b:73da with SMTP id
 d9443c01a7336-2bd7e8ae68bmr293526315ad.30.1779301551194; 
 Wed, 20 May 2026 11:25:51 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c0605ddsm217413925ad.32.2026.05.20.11.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:25:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 49/64] target/arm: Implement FMLALL{BB,BT,TB,TT} for SVE
Date: Wed, 20 May 2026 11:21:58 -0700
Message-ID: <20260520182213.872945-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 3 +++
 target/arm/tcg/sve.decode      | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index aa785fa0c3..e23ca43f55 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8369,3 +8369,6 @@ static bool do_fmla_fp8(DisasContext *s, arg_rxx *a, gen_helper_gvec_3_ptr *fn)
 
 TRANS(FMLAL_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_hb)
 TRANS(FMLAL_idx_hb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_hb)
+
+TRANS(FMLALL_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_sb)
+TRANS(FMLALL_idx_sb, do_fmla_fp8, a, gen_helper_gvec_fmla_idx_sb)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 71ec09393c..06bbd7fa63 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1868,6 +1868,8 @@ BFMLSLT_zzzw    01100100 11 1 ..... 10 1 00 1 ..... .....  @rda_rn_rm_ex esz=2
 
 FMLAL_hb        01100100 10 1 rm:5 100 idxn:1 10 rn:5 rd:5 &rxx idxm=0
 
+FMLALL_sb       01100100 00 1 rm:5 10 idxn:2  10 rn:5 rd:5 &rxx idxm=0
+
 ### SVE2 floating-point dot-product
 FDOT_zzzz       01100100 00 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
 BFDOT_zzzz      01100100 01 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
@@ -1887,6 +1889,9 @@ BFMLSLT_zzxw    01100100 11 1 ..... 0110.1 ..... .....     @rrxr_3a esz=2
 FMLAL_idx_hb    01100100 idxn:1 01 .. rm:3 0101 .. rn:5 rd:5 \
                 &rxx idxm=%index4_19_10
 
+FMLALL_idx_sb   01100100 idxn:2  1 .. rm:3 1100 .. rn:5 rd:5 \
+                &rxx idxm=%index4_19_10
+
 ### SVE2 floating-point dot-product (indexed)
 
 FDOT_zzxz       01100100 00 1 ..... 010000 ..... .....     @rrxr_2 esz=2
-- 
2.43.0


