Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451B9CD98E4
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 19:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZZDg-0003Zk-Ub; Tue, 16 Jun 2026 15:13:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8b-0004nD-3J
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:55 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wZZ8Y-0001Hn-4G
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 15:07:52 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso3413300f8f.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 12:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781636868; x=1782241668; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dheMmu+0unel+GTEMjXNAMvglHoJHnIs68/xfZg7lu0=;
 b=DuNtag9Lvff4PIWu4C7Ys0c7cDZDBIwJAkSI3sHIAZtGOEh1ZIvFgmAjXfy1WQuPNq
 3pvHlihcACgGbZddTwWvn+vvZnrTlRvUm4GlcWw0DiAY+NKcfsswoKF7dvDZNS+gogjO
 Pt+Ku8fjhiG05sITuPe2bqGKb/sJFuqEpqx265YpGZImKLh35Ay+ZQPdQGSqIxzMW+87
 WI/e+Cc+pQLfPDbGkUpT8fjxEPLHaz2UD9RTZX0NPfx+cWIahsiRc3ceWRtqI4dMbxxr
 WbhyJPI3Sg0e+3p5whYD/4yPJj8frNJ5HN9TOWm4UE4SLff3cHWEkXDDQZANXbzNXu1O
 UjjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781636868; x=1782241668;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dheMmu+0unel+GTEMjXNAMvglHoJHnIs68/xfZg7lu0=;
 b=cduzhwjNwKlfoJwxSHh71j6xk+93cNuaK4BITGQ64I+kPHrmnnAk4hRUquNvGvOoec
 BnA+VQklx8/3xmdIphWismQpF4ujuKSMpsAIVtdfk9rNhwyHm+wMmskbCZjVwDMRxKsO
 kjHcgE8pNRsRxvRedn8S4z7V1c7gUmq67e+ERpdI2xueaMGkDPpfJvQ9WIr0wNCrTqH0
 N1n4bwyo5QioUyE97jvGiX3wHEXrlO3SJHoEREopu0Iay95jcNzJKby5gBBNK0XbBgYj
 peW110GJ6q6QDGWiPro+DAiHIBiJapR/ILw2SMRHm4ewOMK6O/T6xQA5unHMfJt3f0/8
 ULKQ==
X-Gm-Message-State: AOJu0YzST7dfTMgfxamD+UTcTIf/N/FfPVoEnClKSEG9/qJVJhjqGZ+8
 JMic/9aRJNj9pPysBoU5xWSCIW2TLEVJMyC3wLKnQgMEKltVnrODDb+zjJvTYsEX/hnvEZZm6p8
 F08iT
X-Gm-Gg: Acq92OFYuynhU/rRiP2CkB7TfeUxknr8GpLZkKrdg3ZgwfqPqhZetKsupXiS4zIe6iA
 fZ8qc43ZNCf1ga+tlPR3d7NSwe7XWDVTr9MZxe4eEcCdYkG1wk5N2P5f8I1Z4LgjAovhzwEfoMz
 RGe8ICzvedj1Lq0Lm8VWjTWPoeJHXJ21MEvGvMM2yGJIzCXHD0AlZN/AYOFSxr9XZ+4AOeOFMhC
 wOIwF8KaR7/yQ1HnHm10lVtpu/XXAqAkv8cDmcqFsYCzezy8i/OfIF0pnQ+qOFNHX7SOJnziKzE
 ISozCLg2wk6L663Z5s81FTXX1mpFaPxJb1hKF2NYSEulCTzSm/XqQLCljzjszZVGc35zHW+wwEr
 ggcvJJaAZRSW5PLhj6DUMpprDSv1HocvhUlVhuiFssjGvuoFLafh/MExvM0BoYU6ZuBocYMp6sr
 Cvk7kcsCZrSbMc3BnbdKMSjdKb9emel6lQngLrAvgOQfWaw5WYFOLNm+w8JGsJZOdZnMGwt++46
 kqL10+Ek8lTbmLxuEZ6RIh20EdUtSPW
X-Received: by 2002:a05:6000:2913:b0:460:1987:7bb9 with SMTP id
 ffacd0b85a97d-46238132d53mr1329851f8f.29.1781636868563; 
 Tue, 16 Jun 2026 12:07:48 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2d9becsm45078765f8f.34.2026.06.16.12.07.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 12:07:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 61/61] target/arm: Implement floating-point log and convert to
 integer (zeroing)
Date: Tue, 16 Jun 2026 20:06:38 +0100
Message-ID: <20260616190639.3462006-62-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616190639.3462006-1-peter.maydell@linaro.org>
References: <20260616190639.3462006-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

This is FLOGB, FCVTZS, FCVTZU.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260604234852.573178-19-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve.decode      | 16 +++++++++++++++
 target/arm/tcg/translate-sve.c | 37 ++++++++++++++++++++++++++++++++--
 2 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 673cbaae57..2795c2ec7f 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1242,6 +1242,21 @@ FCVTZU_sd_m     01100101 11 011 10 1 101 ... ..... .....        @rd_pg_rn_e0
 FCVTZS_dd_m     01100101 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
 FCVTZU_dd_m     01100101 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
 
+FCVTZS_hh_z     01100100 01 011 11 0 110 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hh_z     01100100 01 011 11 0 111 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hs_z     01100100 01 011 11 1 100 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hs_z     01100100 01 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_hd_z     01100100 01 011 11 1 110 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_hd_z     01100100 01 011 11 1 111 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ss_z     01100100 10 011 11 1 100 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ss_z     01100100 10 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_sd_z     01100100 11 011 11 1 100 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_sd_z     01100100 11 011 11 1 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_ds_z     01100100 11 011 11 0 100 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_ds_z     01100100 11 011 11 0 101 ... ..... .....        @rd_pg_rn_e0
+FCVTZS_dd_z     01100100 11 011 11 1 110 ... ..... .....        @rd_pg_rn_e0
+FCVTZU_dd_z     01100100 11 011 11 1 111 ... ..... .....        @rd_pg_rn_e0
+
 # SVE floating-point round to integral value
 FRINTN_m        01100101 .. 000 000 101 ... ..... .....         @rd_pg_rn
 FRINTP_m        01100101 .. 000 001 101 ... ..... .....         @rd_pg_rn
@@ -1950,6 +1965,7 @@ FCVTLT_sd_z     01100100 11 0000 11 101 ... ..... .....  @rd_pg_rn_e0
 
 ### SVE2 floating-point convert to integer
 FLOGB_m         01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
+FLOGB_z         01100100 00 011 1101 esz:2 pg:3 rn:5 rd:5  &rpr_esz
 
 ### SVE2 floating-point multiply-add long (vectors)
 FMLALB_zzzw     01100100 10 1 ..... 10 0 00 0 ..... .....  @rda_rn_rm_ex esz=2
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 21ee10ee5c..9a72e03513 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -4654,6 +4654,37 @@ TRANS_FEAT(FCVTZS_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
 TRANS_FEAT(FCVTZU_dd_m, aa64_sme_or_sve, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_fcvtzu_dd, a, 0, FPST_A64)
 
+TRANS_FEAT(FCVTZS_hh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_hh, a, 1, FPST_A64_F16)
+TRANS_FEAT(FCVTZU_hh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_hh, a, 1, FPST_A64_F16)
+TRANS_FEAT(FCVTZS_hs_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_hs, a, 1, FPST_A64_F16)
+TRANS_FEAT(FCVTZU_hs_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_hs, a, 1, FPST_A64_F16)
+TRANS_FEAT(FCVTZS_hd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_hd, a, 1, FPST_A64_F16)
+TRANS_FEAT(FCVTZU_hd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_hd, a, 1, FPST_A64_F16)
+
+TRANS_FEAT(FCVTZS_ss_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_ss, a, 1, FPST_A64)
+TRANS_FEAT(FCVTZU_ss_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_ss, a, 1, FPST_A64)
+TRANS_FEAT(FCVTZS_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_sd, a, 1, FPST_A64)
+TRANS_FEAT(FCVTZU_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_sd, a, 1, FPST_A64)
+TRANS_FEAT(FCVTZS_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_ds, a, 1, FPST_A64)
+TRANS_FEAT(FCVTZU_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_ds, a, 1, FPST_A64)
+
+TRANS_FEAT(FCVTZS_dd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzs_dd, a, 1, FPST_A64)
+TRANS_FEAT(FCVTZU_dd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_fcvtzu_dd, a, 1, FPST_A64)
+
 static gen_helper_gvec_3_ptr * const frint_fns[] = {
     NULL,
     gen_helper_sve_frint_h,
@@ -8134,8 +8165,10 @@ static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
     gen_helper_flogb_s, gen_helper_flogb_d
 };
-TRANS_FEAT(FLOGB_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz, flogb_fns[a->esz],
-           a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FLOGB_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
+           flogb_fns[a->esz], a, 0, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
+TRANS_FEAT(FLOGB_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           flogb_fns[a->esz], a, 1, a->esz == MO_16 ? FPST_A64_F16 : FPST_A64)
 
 static bool do_FMLAL_zzzw(DisasContext *s, arg_rrrr_esz *a, bool sub, bool sel)
 {
-- 
2.43.0


