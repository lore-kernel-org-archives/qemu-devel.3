Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3328AC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwiC-0002tv-39; Wed, 02 Jul 2025 08:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgJ-0008Gk-SB
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:21 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfz-000182-Jg
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:18 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-2f75f1c7206so106081fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459695; x=1752064495; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=phmIfMds8E5RxRVs9U5IB61cQYJsfJm2GIn7j+DSAc4=;
 b=uAE1pCQ1YxPMrZ4pIkVmcj5csk2LQX2TB2ijppYvIsw99JwBSkk4v7NgUxwdDWY1Il
 iYJruvAf9jzZOGs9Ws92vnFUbydhkcfIdUJGJapjaAepChfWXQu0mtftXGQIL8IJL0BK
 mIbWLXRZGlc6uXVWMoHxQBsQAdi8hB/YnQv+sWJ7gT+kCyNFVdXQca77yTSYmUjbPUF3
 mnkZ5fa37qVLQwCcrcV619c4xsgqY30VIG54bm7Dnhg/BZRXDbobfasfkaif9zL6B7sm
 3VBabiXYzdMHRV72zw+nKlkRrEgtG4MsyRtIajrfzLXlGgcz5FjaC4eKxwrs/9YRwXFg
 0Dtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459695; x=1752064495;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=phmIfMds8E5RxRVs9U5IB61cQYJsfJm2GIn7j+DSAc4=;
 b=seD8dgAnLH40m6yl3WXKkSVSBFiqz010kLhVEGc4gxzTfLJUklxdoQgXGj9WwJ9der
 i7egKPmnU62TStOfSSluGp9xmL/7iidMBHCuzXwP7ZyJF24jqBTOGESzj9J+vJyxwdXa
 Bu3unuacbp8iX0JWteSYnjQFFsNrB9EiSSfWrk2VWq+XdQBr9NS97vgTXySV0Qq8pQb4
 SXSUx05kSg3Aa41g5ysTVz5Zh7pWg4Cx24/jZcW2gp+jJGnP5RWfTk1/dtIeSpOSwIy7
 l6pk5FXPuP1s1AQt8Jol46bANUy6sWq8rlo+QJOV9btaPo5FH7b8Kg7AmhVM9R1kkbvf
 PUmg==
X-Gm-Message-State: AOJu0Yy81q8fy/AnjcgSztynd57aBa+GZu4EYuopd6qVuJkh/RWkQwkp
 Pk6ARcX2Yxg2TnyEtwwMJV/IcmY88Bo8S7Wl5awYB+gg6MpN3uYVksikWaRMwGbS9dB3hPy61Fk
 O2chcHwA=
X-Gm-Gg: ASbGnctmZoEg8JvZVPxTN8d0hFynWpa/JPYw55bsVkvZXcYs5jgof/OmEmQLBLtGNZv
 JYD2uKvzwJ4SqM88W+DlWDqYkzGQybWsZSUOf6b9eRBqVFspRd+2UdE0ECbvQ0N+6EHQCVY4JPH
 +cDd1gSddelC6alAm6uucr/n8+VUkKXjWXuNlrijSmLKMdKyTuvoUDPs351otZhOy9WcznJD++z
 Oz8yPWaZYJkzPcb/mHD/102m5k0w8yQyXj81Ls8ORA8qp8zfIXu9SiTIlTTrZ4nkTX+/6wju9Pk
 NUmFSohL0yEqlL1cIxv6MHTw/URKaDmmcgMSm8zMI8Tt8dN+p03H/uW4gTXbHpam8JmjdQ==
X-Google-Smtp-Source: AGHT+IH/EqjwJu24E9ybHB1jvrutgSduatjmuDz9A0sY0vIesFqOwy7Is1iOKde5g7JyiHRPq9uS6g==
X-Received: by 2002:a05:6870:1b15:b0:2eb:87a9:7fc1 with SMTP id
 586e51a60fabf-2f5a8d27727mr2047246fac.27.1751459694942; 
 Wed, 02 Jul 2025 05:34:54 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 34/97] target/arm: Implement SDOT,
 UDOT (2-way) for SME2/SVE2p1
Date: Wed,  2 Jul 2025 06:33:07 -0600
Message-ID: <20250702123410.761208-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 10 ++++++++++
 target/arm/tcg/sve.decode      |  8 +++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index c82a0f771d..10261e25f9 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3426,6 +3426,11 @@ TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
 TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
+TRANS_FEAT(SDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_sdot_idx_2h, a)
+TRANS_FEAT(UDOT_zzxw_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzxz,
+           gen_helper_gvec_udot_idx_2h, a)
+
 #define DO_SVE2_RRX(NAME, FUNC) \
     TRANS_FEAT(NAME, aa64_sve, gen_gvec_ool_zzz, FUNC,          \
                a->rd, a->rn, a->rm, a->index)
@@ -7154,6 +7159,11 @@ TRANS_FEAT(SQRDCMLAH_zzzz, aa64_sve2, gen_gvec_ool_zzzz,
 TRANS_FEAT(USDOT_zzzz_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzzz,
            gen_helper_gvec_usdot_4b, a, 0)
 
+TRANS_FEAT(SDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_sdot_2h, a, 0)
+TRANS_FEAT(UDOT_zzzz_2s, aa64_sme2_or_sve2p1, gen_gvec_ool_arg_zzzz,
+           gen_helper_gvec_udot_2h, a, 0)
+
 TRANS_FEAT_NONSTREAMING(AESMC, aa64_sve2_aes, gen_gvec_ool_zz,
                         gen_helper_crypto_aesmc, a->rd, a->rd, 0)
 TRANS_FEAT_NONSTREAMING(AESIMC, aa64_sve2_aes, gen_gvec_ool_zz,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 401c025852..83c259def6 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -856,6 +856,9 @@ SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
 UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
 UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
+SDOT_zzxw_2s    01000100 10 0 ..... 110010 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_2s    01000100 10 0 ..... 110011 ..... .....   @rrxr_2 esz=2
+
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
 MLA_zzxz_s      01000100 10 1 ..... 000010 ..... .....   @rrxr_2 esz=2
@@ -1597,7 +1600,10 @@ UMLSLT_zzzw     01000100 .. 0 ..... 010 111 ..... .....  @rda_rn_rm
 CMLA_zzzz       01000100 esz:2 0 rm:5 0010 rot:2 rn:5 rd:5  ra=%reg_movprfx
 SQRDCMLAH_zzzz  01000100 esz:2 0 rm:5 0011 rot:2 rn:5 rd:5  ra=%reg_movprfx
 
-## SVE mixed sign dot product
+## SVE dot product
+
+SDOT_zzzz_2s    01000100 00 0 ..... 110 010 ..... .....  @rda_rn_rm_ex esz=2
+UDOT_zzzz_2s    01000100 00 0 ..... 110 011 ..... .....  @rda_rn_rm_ex esz=2
 
 USDOT_zzzz_4s   01000100 10 0 ..... 011 110 ..... .....  @rda_rn_rm_ex esz=2
 
-- 
2.43.0


