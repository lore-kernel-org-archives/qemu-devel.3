Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664DAE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 17:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM9ZM-0006Cn-Tv; Fri, 13 Dec 2024 12:35:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xs-00086L-0v
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:44 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tM9Xl-0001hF-VG
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 12:33:42 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-385ef8b64b3so1689811f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 09:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734111216; x=1734716016; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S5Wm3RpvNF8IYsHZpf+XJ72p8A+XwA+4f5r+Dvitclo=;
 b=vMQeWv9RM5lzj9to/AtvHw1AycCUJ1HDhie+6crPm3lW3LrLviGN/lwCx8Ea7LylRw
 ArY7aXM9qrOTYB9y4I2P0a+cT/jBOW5k4Qo6o9p9h/SK3b1h9ibjk3ulnkyleR/C32UA
 /6dSnDc0552f+YkqmeAMF3zAGCNba43PtwOq+Bufilstb+yhssgieoLiCfJtPfwFuADO
 LwvrJLdQe6o66eqVG5OZtiAj17boA+ztUi3oYuw0s5mq4Dg577z+OAqutOxYEpYlUiNG
 f7BaSIxmjajlNRHko20R5dIC4uBiFn6tZypJ1Q8Zeu/J1nrG5NZN0djz6aqeAxjO4e0E
 SMTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734111216; x=1734716016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=S5Wm3RpvNF8IYsHZpf+XJ72p8A+XwA+4f5r+Dvitclo=;
 b=tMueYpUyHa+5Q2d6J0mwabPfdBxzdZBVG96jJcGdLVPFCabBaxu606373dAsAzs1mu
 k3ctuR78TSJxylOz/Quw0ROmm3Ae/87kLh+hLaLBDUmHxw+IEBLSx9yuqqHlfXodtZEt
 FadJvM8ZdVykKfItMr9l6GfIS6bBQ8oUXCzBBnHCZjsfzYwBQrdxvf0bsCX0l1gKU37n
 LF6PDBdDwa/YWFtoOCcTGc9njG0R4JHmaJoprrXqJROzriYOfB8gc0JKE5IQjFysAjU3
 iYx6TZZnQWgPumAb8ZNCYST0SFC4vZU+UVjG02HwGAuc1rXGNsVxBX/1Cx0liZkOAOnc
 9rqw==
X-Gm-Message-State: AOJu0YwMNGjFMCRBBcI3fGMUty1fzFxZcuiMD/0evu0FtYjcXWexNVfQ
 bfUzegRwzr7uipDl4iDNvL+j8Ut8Wkh+Xqi16SbJVsvnuBbahJZsbA8ev8yh6ir7wOVkh4pGSnC
 i
X-Gm-Gg: ASbGnct2BhCjY03vJNYWRKPfKGqaFtYt5KKn7TMgbIONrVVQPMvnGDhC8HqNiOYabNV
 RAIb9aVqbESAW39NU2444aVwfbOEe9cbeAm3mi/swGPfxEFcblzXw/aTsihhBqaODjvbzHRfjee
 yGoNgXRphVL0vdu2n82vYqfagKXnNjFPBIBslQIdGQUffOPYR9PKkzQGXrY3JTj8rZHwnnLqCgi
 8RMvA5ylsbJBIPgbFTcHMAKp8eCUd5PC4o1iHM4Q+Lc5iSmyjwWdVqZT8KJ8Q==
X-Google-Smtp-Source: AGHT+IGqLqgKpOdEyiQyucW3aOXMfM1+FD1+jYXs+ha2jAB27RbEnuVHEuzT9agSjX0WXvPOLBvhog==
X-Received: by 2002:a05:6000:1a8a:b0:385:f89a:402e with SMTP id
 ffacd0b85a97d-3888dcd468amr2911417f8f.14.1734111216530; 
 Fri, 13 Dec 2024 09:33:36 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c80162ddsm87026f8f.37.2024.12.13.09.33.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 09:33:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/85] target/arm: Rename helper_gvec_vcvt_[hf][su] with _rz
Date: Fri, 13 Dec 2024 17:32:05 +0000
Message-Id: <20241213173229.3308926-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213173229.3308926-1-peter.maydell@linaro.org>
References: <20241213173229.3308926-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Emphasize that these functions use round-to-zero mode.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241211163036.2297116-62-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.h             | 8 ++++----
 target/arm/tcg/translate-neon.c | 8 ++++----
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 04e422ab081..f2cfee40de3 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -650,13 +650,13 @@ DEF_HELPER_FLAGS_4(gvec_touizs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_vcvt_sf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_uf, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_fu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_vcvt_sh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_uh, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
-DEF_HELPER_FLAGS_4(gvec_vcvt_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hs, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(gvec_vcvt_rz_hu, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_ss, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(gvec_vcvt_rm_us, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
diff --git a/target/arm/tcg/translate-neon.c b/target/arm/tcg/translate-neon.c
index b9b3d1c1fbc..f9ca889beca 100644
--- a/target/arm/tcg/translate-neon.c
+++ b/target/arm/tcg/translate-neon.c
@@ -1409,13 +1409,13 @@ static bool do_fp_2sh(DisasContext *s, arg_2reg_shift *a,
 
 DO_FP_2SH(VCVT_SF, gen_helper_gvec_vcvt_sf)
 DO_FP_2SH(VCVT_UF, gen_helper_gvec_vcvt_uf)
-DO_FP_2SH(VCVT_FS, gen_helper_gvec_vcvt_fs)
-DO_FP_2SH(VCVT_FU, gen_helper_gvec_vcvt_fu)
+DO_FP_2SH(VCVT_FS, gen_helper_gvec_vcvt_rz_fs)
+DO_FP_2SH(VCVT_FU, gen_helper_gvec_vcvt_rz_fu)
 
 DO_FP_2SH(VCVT_SH, gen_helper_gvec_vcvt_sh)
 DO_FP_2SH(VCVT_UH, gen_helper_gvec_vcvt_uh)
-DO_FP_2SH(VCVT_HS, gen_helper_gvec_vcvt_hs)
-DO_FP_2SH(VCVT_HU, gen_helper_gvec_vcvt_hu)
+DO_FP_2SH(VCVT_HS, gen_helper_gvec_vcvt_rz_hs)
+DO_FP_2SH(VCVT_HU, gen_helper_gvec_vcvt_rz_hu)
 
 static bool do_1reg_imm(DisasContext *s, arg_1reg_imm *a,
                         GVecGen2iFn *fn)
diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 91a9130641f..ec6b640fdad 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2507,12 +2507,12 @@ DO_3OP_PAIR(gvec_uminp_s, MIN, uint32_t, H4)
 
 DO_VCVT_FIXED(gvec_vcvt_sf, helper_vfp_sltos, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_uf, helper_vfp_ultos, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_fs, helper_vfp_tosls_round_to_zero, uint32_t)
-DO_VCVT_FIXED(gvec_vcvt_fu, helper_vfp_touls_round_to_zero, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_fs, helper_vfp_tosls_round_to_zero, uint32_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_fu, helper_vfp_touls_round_to_zero, uint32_t)
 DO_VCVT_FIXED(gvec_vcvt_sh, helper_vfp_shtoh, uint16_t)
 DO_VCVT_FIXED(gvec_vcvt_uh, helper_vfp_uhtoh, uint16_t)
-DO_VCVT_FIXED(gvec_vcvt_hs, helper_vfp_toshh_round_to_zero, uint16_t)
-DO_VCVT_FIXED(gvec_vcvt_hu, helper_vfp_touhh_round_to_zero, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_hs, helper_vfp_toshh_round_to_zero, uint16_t)
+DO_VCVT_FIXED(gvec_vcvt_rz_hu, helper_vfp_touhh_round_to_zero, uint16_t)
 
 #undef DO_VCVT_FIXED
 
-- 
2.34.1


