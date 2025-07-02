Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6350AC8303F
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:53:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwhZ-0001jy-Do; Wed, 02 Jul 2025 08:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwgH-0008ED-6h
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:17 -0400
Received: from mail-oa1-x2d.google.com ([2001:4860:4864:20::2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwfz-00017K-1y
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:35:16 -0400
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-2efdd5c22dfso2467907fac.3
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459692; x=1752064492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KSHykoMbntdKCV7ON1jZJaLFKnxkO6WGHgQsyobJ4D0=;
 b=knxoyE1ZrRD1U9QNvUIcvr5YqKQEzZTHLJ2+GqMYmiMLYzoakLf9jVILQf0Z1uaeiF
 0uc7n2uEW1x3h7Bp2jhUMTSPTybH2CtEFxxsVd042bTjNbxTr77A8QderPiaC/76T3wF
 zbcMtom4lHZ1SZmufJdaoyOI2OApecB7NoOlhkWj8ZETs8j3BZePyF829dcIsyouY5mi
 zuSZpzxc3F5rdK+r80lgAgz+rJKrFax8fn+LEoHofoB1Oiwxd1CdfoAqKVeXq4ZL11VH
 S8oBD7GWlyUws1q9Eu7HREGhwr+DHPZXu80crhLIX71GHmgm1r30isgxiH7av+XlPEaS
 hwgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459692; x=1752064492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KSHykoMbntdKCV7ON1jZJaLFKnxkO6WGHgQsyobJ4D0=;
 b=C0mUYUSErlaWaDQApinCgtOrUuk/I8euA7mNrFHExvUmjm2f3Sm3mM+CYezJmkMuII
 bU7Un7+hlD90DWKazp95CAiDiJ8q6wsRRgpsk6gBsHTMi8vDzXSIenSxGrwd9DxtAro2
 7UiGQz0unxui8t+t1PNDaqu0HixQ7KucrfSwcdQwzu8HwQ4dfqoQ0nh4dJ9s8ANT1hw3
 JOWjw8EyAsKJi3mxY8uCt3zUbNDXPrnJxDSFa/NoSS6asmYrB8jbRHmTBYYuYSBv0flv
 3EUBBVrHeyb2VOgcx7VTrLI2G8PJM5VpjtNd0OtGB+UDFsolhHpwrs0XjhWrtJPEfB0u
 zEBg==
X-Gm-Message-State: AOJu0YxxiK22ZunCZqrjrfEUHDWus2IvBU3utuOg4h1D0T2orvTTjkcS
 2lcT8TPwpbUlDkE39Y5czYfCPfHUHheJdQtXjJ2rTtKWw+J8OZSvD04tiWKirwCy5qw8FjMlaAe
 V9j6pTKQ=
X-Gm-Gg: ASbGncurVmmotlJlJLc5kgKpjGsLFhEVqWSpGfPFGfoMUphSBfkxZ+dhEK2L6lNtEnq
 i/jpcyVy90IgColpxpqQLpBgfahbBFSKYreBRHW8Qlb8gFtbg9iimRw803Kq9/Tajbp1VM32I/k
 uG1WiUF4EtHy7LYEIuD/x4hfgEr9GogIJATg2cEZ1iyC+OugvMJwPq3E9FpejCr6ZvxF82hy7wi
 GZIeANzvjKh8o6peyNVlfRzMJGhCbikvs2P5fRSlYkgu2hqIZEeqmh6aV3n6AalHqdY0x/d6ndm
 RgmwiwS60TZLPBGarkiR63pNqrfs1Mvg+7dkgaBlNFD2cmXjd1MlmWePdPqHEOvc+p94YdctbQ+
 XtMP8
X-Google-Smtp-Source: AGHT+IHSu8YdZt3AyyiChZf+E6PYxS+b//JKga2JGA24vtmt2LhdFUG/IXbFFXMiiwA5s1MFo7UAyQ==
X-Received: by 2002:a05:6871:9d1e:b0:2d4:ef88:97af with SMTP id
 586e51a60fabf-2f5a8d27c9fmr2031716fac.3.1751459692318; 
 Wed, 02 Jul 2025 05:34:52 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 32/97] target/arm: Rename SVE SDOT and UDOT patterns
Date: Wed,  2 Jul 2025 06:33:05 -0600
Message-ID: <20250702123410.761208-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2d;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2d.google.com
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

Emphasize the 4-way nature of these dot products.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 12 ++++++------
 target/arm/tcg/sve.decode      | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 1564ee2558..56353b3bb4 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3412,18 +3412,18 @@ TRANS_FEAT(DOT_zzzz, aa64_sve, gen_gvec_ool_zzzz,
  * SVE Multiply - Indexed
  */
 
-TRANS_FEAT(SDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4b, a)
-TRANS_FEAT(SDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sdot_idx_4h, a)
-TRANS_FEAT(UDOT_zzxw_s, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4s, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4b, a)
-TRANS_FEAT(UDOT_zzxw_d, aa64_sve, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(UDOT_zzxw_4d, aa64_sve, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_udot_idx_4h, a)
 
-TRANS_FEAT(SUDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(SUDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_sudot_idx_4b, a)
-TRANS_FEAT(USDOT_zzxw_s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
+TRANS_FEAT(USDOT_zzxw_4s, aa64_sve_i8mm, gen_gvec_ool_arg_zzxz,
            gen_helper_gvec_usdot_idx_4b, a)
 
 #define DO_SVE2_RRX(NAME, FUNC) \
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5970ed9ac4..51847ea56e 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -851,10 +851,10 @@ CDOT_zzzz       01000100 esz:2 0 rm:5 0001 rot:2 rn:5 rd:5  ra=%reg_movprfx
 #### SVE Multiply - Indexed
 
 # SVE integer dot product (indexed)
-SDOT_zzxw_s     01000100 10 1 ..... 000000 ..... .....   @rrxr_2 esz=2
-SDOT_zzxw_d     01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
-UDOT_zzxw_s     01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
-UDOT_zzxw_d     01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
+SDOT_zzxw_4s    01000100 10 1 ..... 000000 ..... .....   @rrxr_2 esz=2
+SDOT_zzxw_4d    01000100 11 1 ..... 000000 ..... .....   @rrxr_1 esz=3
+UDOT_zzxw_4s    01000100 10 1 ..... 000001 ..... .....   @rrxr_2 esz=2
+UDOT_zzxw_4d    01000100 11 1 ..... 000001 ..... .....   @rrxr_1 esz=3
 
 # SVE2 integer multiply-add (indexed)
 MLA_zzxz_h      01000100 0. 1 ..... 000010 ..... .....   @rrxr_3 esz=1
@@ -873,8 +873,8 @@ SQRDMLSH_zzxz_s 01000100 10 1 ..... 000101 ..... .....   @rrxr_2 esz=2
 SQRDMLSH_zzxz_d 01000100 11 1 ..... 000101 ..... .....   @rrxr_1 esz=3
 
 # SVE mixed sign dot product (indexed)
-USDOT_zzxw_s    01000100 10 1 ..... 000110 ..... .....   @rrxr_2 esz=2
-SUDOT_zzxw_s    01000100 10 1 ..... 000111 ..... .....   @rrxr_2 esz=2
+USDOT_zzxw_4s   01000100 10 1 ..... 000110 ..... .....   @rrxr_2 esz=2
+SUDOT_zzxw_4s   01000100 10 1 ..... 000111 ..... .....   @rrxr_2 esz=2
 
 # SVE2 saturating multiply-add (indexed)
 SQDMLALB_zzxw_s 01000100 10 1 ..... 0010.0 ..... .....   @rrxr_3a esz=2
-- 
2.43.0


