Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0046ACD98F8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 04:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wa4AM-0005Yt-3Q; Thu, 18 Jun 2026 00:15:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A4-0005V3-Vw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:29 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wa4A2-0005b0-Ug
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 00:15:28 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2c6be9cd7afso2190225ad.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 21:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781756125; x=1782360925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3chygMCcsKBu4o67vLIyPSrCAz2YQp8nqMW9makXS+Q=;
 b=qY/oMymPWRCq31OxnG8YdFOR0nN2onIsS8Vy52WzNXs877/Cd+nKk+jDwWSSY9qMTX
 h6eSTosqZRx7z+0vTMpJdkxSks1vqbWhmOtpCR+3g8uqOvA4tk0REnDzuQZktVCFooBa
 jRUb244ytYkZcoCYRs3MpXPUtUwruq0kQFR34MPyLBLbbNH8eNjz5uHt+NGLtVT0n2mV
 2dRH/ZGg7HcezGlt/KZZCYv/rW5v7d2PRnAKzVIwJ+XOKOtk5ZnBAPPjnHXINZYkuPgG
 HL0gqXH3d/W5BIqMiOUyPWc+J/cKpo9wTHtB9iz+zWDnAYYplb3e7OmAo1C4FCemkkaK
 +mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781756125; x=1782360925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3chygMCcsKBu4o67vLIyPSrCAz2YQp8nqMW9makXS+Q=;
 b=rYYjE4CzJEt5pFPlezzC5VrBYyPc9vdlBrtcB/HYvtSQ7h44Fv9w/7mIRdm7GiXK69
 89b1ulJ3whM7yfnB/acrPb2C0uO9vkEABrIRQNI1j7EiGZJ1G/4OP+8TSFsbE5ZMvVbc
 jTbCWffpLGhYll7So26Wu3j/yWOgI98aAfrCzuL1Ao9lvccfIuK2BQvyUr9mtL6EZ2Xh
 3ISFaG2gWkJLHYtL40kbDBHkEmNEnG65ADHjBPbq3mPk0pUyfNBm6pZGho43/4X2RePm
 XHtFChuaNDxr7lR1zlu1DlHghUUzZCKN19BVPNNUthI7P+9BAxepcgq4gyrS6m8kc7EF
 o80A==
X-Gm-Message-State: AOJu0YwOe3CFXKRZsqh1HADbxIG05xEGqm/i0sORRYoGXjA/vefC8Yum
 +oEWxiYEO/lD/uQUfzStObcC34dzTwh4GIZw1GfFqn/jLpHf+cDJGHBsUUCiIhY0Ztl/TIbLZPL
 fsxd8
X-Gm-Gg: AfdE7ckDCJI7b+bw28J+7fV3RUj9Ulix+WTpNnKGQljSqQrSpa+IaRcx/G/WjSI+iT8
 bH/oTw1LeQYLk+MvqSG3BH0B2O6Ph69dTXwWTQyQPWS3lmpzVCc6o+RR+I18Dlpvqciw6q10hDp
 K/7l2YNib3Uzu+RqTLZNUkvEmeIeTAmWfIzJpXOi1WLdPa/F6ky36WVw9WmZsli1x0pHUoK7jpq
 g9U9jBbLlsDewlIONulzA7pK4MKoJrvsb84hj3QrKpMJoJgi/YLUM7eJgPYCS6bJ/vIFXG4/LbG
 b8I/kT4kq6+S0IV3sRWWDHG+IGzNQCOB3F7/usD7mBNmVRq5uCy1xm1rCfXV0+Y6mo8E+68piVX
 5MMyguE2cmmgeokosgacAdfSxueEV7oNAxIv6WSb0GBnioFHS4twmaT51VAzns874dwtkwhqkiy
 +FcyCcwB2jO0d9IJdUm5d0EpUFnpUtjnuGiDOcSJwJFy7FCLCFKpPQTCHloqKy
X-Received: by 2002:a17:902:e54b:b0:2bc:b80f:6782 with SMTP id
 d9443c01a7336-2c6e484a87fmr19979335ad.11.1781756125450; 
 Wed, 17 Jun 2026 21:15:25 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42f2e535csm173905935ad.6.2026.06.17.21.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 21:15:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 05/10] target/arm: Implement FMLALL (multiple and indexed
 vector)
Date: Wed, 17 Jun 2026 21:15:12 -0700
Message-ID: <20260618041517.573469-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618041517.573469-1-richard.henderson@linaro.org>
References: <20260618041517.573469-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
 target/arm/tcg/translate-sme.c | 4 ++++
 target/arm/tcg/sme.decode      | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index ae1dbd0528..cc85c6d6e0 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1157,6 +1157,10 @@ static bool do_bfmlal_nx(DisasContext *s, arg_azx_n *a, bool sub)
 TRANS_FEAT(BFMLAL_nx, aa64_sme2, do_bfmlal_nx, a, false)
 TRANS_FEAT(BFMLSL_nx, aa64_sme2, do_bfmlal_nx, a, true)
 
+TRANS_FEAT(FMLALL_nx_b, aa64_sme_f8f32, do_azz_acc_fp8,
+           a->n, 4, a->rv, a->off, a->zn, a->zm,
+           a->idx << 2, 0, false, gen_helper_gvec_fmla_idx_sb)
+
 static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 1, 0,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ccc33463c2..80ad674cf2 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -771,6 +771,10 @@ FMLS_nx_h       11000001 0001 .... 1 .. 1.. ...00 1 ....    @azx_4x1_i3_o3
 FMLS_nx_s       11000001 0101 .... 1 .. 0.. ...00 10 ...    @azx_4x1_i2_o3
 FMLS_nx_d       11000001 1101 .... 1 .. 00. ...00 10 ...    @azx_4x1_i1_o3
 
+FMLALL_nx_b     11000001 0100 .... . .. ... ..... 000 ..    @azx_1x1_i4_o2
+FMLALL_nx_b     11000001 1001 .... 0 .. 0.. ....1 00.. .    @azx_2x1_i4_o1
+FMLALL_nx_b     11000001 0001 .... 1 .. 0.. ...10 00.. .    @azx_4x1_i4_o1
+
 ### SME2 Add / Sub array accumulators
 
 ADD_aaz_s       11000001 101 000000 .. 111 ....0 10 ...     @az_2x2_o3
-- 
2.43.0


