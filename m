Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A78C6CD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 23:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVHoI-0006sN-Pb; Thu, 04 Jun 2026 19:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoE-0006mR-DJ
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:10 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wVHoB-0007wq-T5
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 19:49:10 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2c0bb4a94b8so10408655ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 16:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780616946; x=1781221746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vwe1BKhTDm6Lb2c1Tvgh4n00uncLiVqYDlZzQyMqaaU=;
 b=CxHfxiG489zFpB7IAxQ6QyJBm8+0NAqrsIc4RczyxNYvBdoU4dQfzZ1qI9SAobw/lF
 Qt/CE1J5Z8cXJDk6TWZ0/AKJ8ZIrl5DROJS3FSmEf752KFHIGOxQAsOpFDsU15Gv/bUZ
 KR4JTe2NfwfU/l2EmV0Z0LelEOAGayVJYPwgjx4cpwHz4GkV0/smy6BciOda5PqltWg8
 cTRlB8P2xSqzeAFbq2+dRq0Gj/fM33MNMS2trfZb0e8T3nCg6F2WeBIJykZQRZaVMprz
 SGZjN9XDYinlfs7rslhIVNr2Q+K7wyfDxB82LYamvB/NWi9nG68U21AG/P2P3W8Z5k82
 vusg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780616946; x=1781221746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vwe1BKhTDm6Lb2c1Tvgh4n00uncLiVqYDlZzQyMqaaU=;
 b=JzkwfslPMR+f7/yRSh75gsTxYpkvsO5FC+rpRKRMuNdXRAikYW/YaDRBWTfoGi1ufq
 n/fRQLUVmG8MwFFMoZTzAUhIVRSxxxPXWeYlZDU3JLnjzj+8M/SnVwqXNF+N9YEwAYFz
 IiONLlW/WgtF4M1ZnF+b8SbWTwz/2tp6PL4hMBTeIIc5vwHCnf05ylEQ7oqOCiUfMheQ
 Vg5suLQyF8O+9gPUkq6lNM5+YEEZfQ6yu7j+CJIOBRpP1AYF21RBgtX3xOvpY64m9RMm
 LaoYZywOOfwu0N0z2xsDABNNm9/SHKu4EnKNyArlzFbG8eNKS63EoDUDmEi2DQacqgYj
 75lg==
X-Gm-Message-State: AOJu0Yyo5DL2YltEeA68+CR606oTOddEiJhnvcH/Qfa/Onnl4vSkqybL
 h9EggPsVHdlnVK1ZrKc2aNBxEVIQuaW6cdtGsH8xGoaNr5L7BTS5N091mJjctHgBmkVpZOx2qJe
 nEp9MiKU=
X-Gm-Gg: Acq92OGMA2iXo2DbFVsXnpEZMyEboKoTnyH96aVHTSN0oWE5jpUxrTkHghf9N/NuOyJ
 cC3gMS37bX0RAnHJl6BLh309xKAlZs5x1Qua2jWFn9vtT7Gbt6z1HEemUNp9AEERJJRMmK7fTO0
 SPqoYXtjTGPWP5+LEzNDAbt38IW8Ky4UCPD0qttgWACXHoLC+HiqtNNsO0fiRdIytEL0T7Yb0Mo
 kyvkpOJpDBjytV2ZZcr7pNsT0xUE35oohx/tagSyoJjp10doGZEyOtNJ9s5ViZSejrBBsY7XGOo
 JO/VJX0o2gE9p4ppU/dCPR+Wg8k/+ewZgnKjfMLuoPOensVjAJ5a8AKi9mmDbrkpn/HhWDajj2Z
 aaM8UJmXhvIzYtPKWlXBgwEAaqbnxYuQUqdkLctFvitdAPKo1tgWq5SIR8q8YxbHzg4GA2IG7XI
 fsLRqUsm6T42ExYMnwFwhPV4mejm8td1Aj75Ahvuk=
X-Received: by 2002:a17:903:240f:b0:2bc:db35:96c7 with SMTP id
 d9443c01a7336-2c1e822121cmr6643185ad.28.1780616946463; 
 Thu, 04 Jun 2026 16:49:06 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c1664950aesm66541465ad.69.2026.06.04.16.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 16:49:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 17/25] target/arm: Implement SVE floating-point convert (top,
 predicated, zeroing)
Date: Thu,  4 Jun 2026 16:48:44 -0700
Message-ID: <20260604234852.573178-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604234852.573178-1-richard.henderson@linaro.org>
References: <20260604234852.573178-1-richard.henderson@linaro.org>
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

This includes FCVTXNT, BFCVTNT, FCVTNT, FCVTLT.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-sve.c | 13 +++++++++++++
 target/arm/tcg/sve.decode      |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 842ef96221..841f625c25 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -8097,17 +8097,28 @@ static bool trans_RAX1(DisasContext *s, arg_RAX1 *a)
 
 TRANS_FEAT(FCVTNT_sh_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_sh, a, 0, FPST_A64)
+TRANS_FEAT(FCVTNT_sh_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtnt_sh, a, 1, FPST_A64)
 TRANS_FEAT(FCVTNT_ds_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtnt_ds, a, 0, FPST_A64)
+TRANS_FEAT(FCVTNT_ds_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtnt_ds, a, 1, FPST_A64)
 
 TRANS_FEAT(BFCVTNT_m, aa64_sme_sve_bf16, gen_gvec_fpst_arg_zpz,
            gen_helper_sve_bfcvtnt, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64)
+TRANS_FEAT(BFCVTNT_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve_bfcvtnt, a, 1,
+           s->fpcr_ah ? FPST_AH : FPST_A64)
 
 TRANS_FEAT(FCVTLT_hs_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_hs, a, 0, FPST_A64_F16)
+TRANS_FEAT(FCVTLT_hs_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtlt_hs, a, 1, FPST_A64_F16)
 TRANS_FEAT(FCVTLT_sd_m, aa64_sme_or_sve2, gen_gvec_fpst_arg_zpz,
            gen_helper_sve2_fcvtlt_sd, a, 0, FPST_A64)
+TRANS_FEAT(FCVTLT_sd_z, aa64_sme2p2_or_sve2p2, gen_gvec_fpst_arg_zpz,
+           gen_helper_sve2_fcvtlt_sd, a, 1, FPST_A64)
 
 TRANS_FEAT(FCVTX_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, 0, gen_helper_sve_fcvt_ds)
@@ -8116,6 +8127,8 @@ TRANS_FEAT(FCVTX_ds_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
 
 TRANS_FEAT(FCVTXNT_ds_m, aa64_sme_or_sve2, do_frint_mode, a,
            FPROUNDING_ODD, 0, gen_helper_sve2_fcvtnt_ds)
+TRANS_FEAT(FCVTXNT_ds_z, aa64_sme2p2_or_sve2p2, do_frint_mode, a,
+           FPROUNDING_ODD, 1, gen_helper_sve2_fcvtnt_ds)
 
 static gen_helper_gvec_3_ptr * const flogb_fns[] = {
     NULL,               gen_helper_flogb_h,
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 5c814c7769..673cbaae57 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -1941,6 +1941,13 @@ FCVTLT_hs_m     01100100 10 0010 01 101 ... ..... .....  @rd_pg_rn_e0
 FCVTNT_ds_m     01100100 11 0010 10 101 ... ..... .....  @rd_pg_rn_e0
 FCVTLT_sd_m     01100100 11 0010 11 101 ... ..... .....  @rd_pg_rn_e0
 
+FCVTXNT_ds_z    01100100 00 0000 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_sh_z     01100100 10 0000 00 101 ... ..... .....  @rd_pg_rn_e0
+FCVTNT_ds_z     01100100 11 0000 10 101 ... ..... .....  @rd_pg_rn_e0
+BFCVTNT_z       01100100 10 0000 10 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_hs_z     01100100 10 0000 01 101 ... ..... .....  @rd_pg_rn_e0
+FCVTLT_sd_z     01100100 11 0000 11 101 ... ..... .....  @rd_pg_rn_e0
+
 ### SVE2 floating-point convert to integer
 FLOGB_m         01100101 00 011 esz:2 0101 pg:3 rn:5 rd:5  &rpr_esz
 
-- 
2.43.0


