Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96133D49771
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 15:18:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHlck-0007IP-9b; Sun, 01 Dec 2024 10:12:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaV-0008Ea-Ct
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:19 -0500
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tHlaS-0005Ga-TX
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 10:10:18 -0500
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5ee645cf763so1399466eaf.2
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 07:10:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733065816; x=1733670616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/f6Pn+cHL5BJAJGrD9PlXmg1oEjZ57keqW6WBa5VT3M=;
 b=RLAfLMfE+2spi4cZecUlOo2DeWJa7EQllCcnKriK3xOUfkocX5e3kZ4ZN3v5N9SCdL
 G9p888pYUERr/+UBRedoC3KbId8uhNs9vqVL70JOVPUbVXVhoSIhiqfOEqGbz8k0LRRR
 OW/Sj2A2i0EUB3+neajH1YoqqDQtz0nFyzW4kboX3Rps7vPblSp/197E2cYzztvFxfgP
 HHNfxRQSt1J76r8x/ILaIkmpTOT+Qcf8vB+LqwyWVlJ6xbfIUrtLf363P7z7C5WLulAs
 uXeSz28rDsTv216YerHFxiyCpWcn0sbnS/Bmj4bZQCcNzkxPBn77Mp8SeB9Uf2LFItZK
 kgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733065816; x=1733670616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/f6Pn+cHL5BJAJGrD9PlXmg1oEjZ57keqW6WBa5VT3M=;
 b=YXKNbYArnanrewsz/dJGb1MHQH5z9zgewdJxFEs9G0bpCii0Zlv0O6rZUUkym8iX9T
 v+U0V1904FgREqBiS34IeyqhfcAVUdlDBwXrTm7YxBeHm39a2HrlxjQgHTTa4IWVMdKH
 R0jQMlcLjHHbSu94jqMu9Tj/GUr5obOHbf6YgIalhCrTxkIyiVCT/71gZ6auv3elorWU
 Uur8pDxR/uttMN4A5eI2U4tO3InO/kzwNkp5/IB/YnikuMI07g/NnusKFweZgGxO3UqK
 E8fcNGjC+KcQXyLZOiEFjMg2lHcLxTUp7BQMMfgnPiqbFxmZaAi+ORbQciZ6QypDnrPy
 EZtQ==
X-Gm-Message-State: AOJu0YxUyUWpRQkppnTSs32o482UOgeDao4SEuXCFjyOtRTlCdV8gEgh
 +R0uNYBwBpWbSX+yybMMRehARoFPmQ6TZjDq/L2k9YCSUS4Y6ErQz4+joUTllS2RI+AhOg6mGum
 MjTo=
X-Gm-Gg: ASbGncuQdykt0D0It/+VnKmOgNH/cQwpwy22OYTjl104QxN6ok0Vb2MLB9vCoU3kquS
 qD/HpkBH2BAiTZQ81QLDFNqtwBkk/ziA/X3TZKKCTzoaJWA7TcvEqoqRzm2wZWvRLbZruVgB4qV
 +MkvEZedvdF8bcuOSodmBLsVEOkgjOgEuUpBZnatWR6B/4Ny0KUBbQ690KhTnjSEubA3nv2vPhO
 s5eHWYSK/Vp36eFZ3ZFiQSCDMLTIb2zN/W2z9EJC+bWfDOf27pLz5BCRnt7LQ5PKxuKy0zi8l5j
 EP5FmNW4dLAbNsRWhJbKBOa7SrPkuLQ1B9Y5
X-Google-Smtp-Source: AGHT+IFBYQboAOnSfyX+8ueW3KXJnuvSW+7FlT7KdIcX7SnHI4XlALghY6ra/PFTZPLHbn56bhoLzg==
X-Received: by 2002:a4a:ee82:0:b0:5f1:f897:1dcf with SMTP id
 006d021491bc7-5f20a076dd0mr10208525eaf.2.1733065815852; 
 Sun, 01 Dec 2024 07:10:15 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5f21a4cd78fsm1807008eaf.32.2024.12.01.07.10.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Dec 2024 07:10:15 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 59/67] target/arm: Rename helper_gvec_vcvt_[hf][su] with _rz
Date: Sun,  1 Dec 2024 09:05:58 -0600
Message-ID: <20241201150607.12812-60-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
References: <20241201150607.12812-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Emphasize that these functions use round-to-zero mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.h             | 8 ++++----
 target/arm/tcg/translate-neon.c | 8 ++++----
 target/arm/tcg/vec_helper.c     | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 04e422ab08..f2cfee40de 100644
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
index 0821f10fad..cea400e1f5 100644
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
index 60381258cf..282dba4bfd 100644
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
2.43.0


