Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 086DBC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:44:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwgD-00087a-Mk; Wed, 02 Jul 2025 08:35:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwft-0007fH-GV
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:54 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwff-000123-6R
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:34:52 -0400
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-611a7c617a7so967161eaf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459677; x=1752064477; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LMdweUCeXr0ws90t7Pfr3ZnPLeSvedfSjs9EhIvlp+U=;
 b=ov5z95/Xc5l3ZRL43yVqzWK7WMXNMeGnjr6/d9Yy4AFDD6k5M5NJuib2gcRko0NRk/
 bPbMjDqhb2ePZ4VpvErM+AW/jXCLFer6E3o0g8Ddw6HkM5P/+tsNmFNv6sTuPNyMJX7A
 J0IQz6ByR8aw+dA+6dlAlYKyKI1eMScNd3YsSVGzW+4HFds6o/Jb3+kJgjE3JZi9Ri3h
 TSTuft3UhBnYu+HFlX3cEa5VZj5Mx50+ilXK+1EUPaaOaWpgZuNcurVZWe8RB65lFdKm
 8sF/OcLMgVbv2iTv/3XHuFJ2aG5oxrvzEci5SLYBJgtk1jHMNly+Sb2FfhjXOOte6H30
 HkjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459677; x=1752064477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LMdweUCeXr0ws90t7Pfr3ZnPLeSvedfSjs9EhIvlp+U=;
 b=hNj+ZlY/OJC11vJGv1wKAgWZBAJAeTfI/5ESNmvJrTBsN2tIPlMv0MsIvniKjsdPUH
 8feLhcyehBKShC1dPbqujXklEIs6MzkkvanQVu65/iFGTVW3leDKd169vOgL7Dk6G8lJ
 gcNalnymu5R8bFg0Ago1tQ0nOgSEECI8V0RLRGset9PvJywZicJNjABDvt6IScVSeGNL
 xIITf28OSSWzu7hybyJMIQz6YZd/Qy3DPqEfY+ztIveu5lZGfRFGbzy/BG5ecLP2pEY7
 uUKDMl2uSpKMpR7tJKIZDLu8vRbGO85MbNdHc+pNQkjVr388atORVgUmckAFv7OSmqTC
 bA6Q==
X-Gm-Message-State: AOJu0YwsSmnDZEFBrX4A+oNCHgpxHUw4Btdj6g7lrv3yvKqmYZ9TsAkm
 KWj5T+MrD6awWo2AVUy1DX+metJT07WWF7VD72nc0FYqXqj02vFDCFNYJg/lUOOAMQirHT29rTr
 Z8cBxKF0=
X-Gm-Gg: ASbGnctXfKyxuD4cGt6l4x4nCYgWspCoqt45PK95Pxxvwu2xqosK0g9iEzt0W19qfM7
 u5NfSftXyh2tsIrmtMY60Au5TpSApMbKfFDPIPtVWXRM9eOv8+ORiwC9y/sT52A6wH7XvPQkj2f
 pkPg21W7m6QYW+L+qLWhESPGYno6U2bRa8VWkW1SQvn5zBO+7Xjf/gk1Fl0SaUehOs7QESpBI+4
 Vuk1sUKU8sx3oDuwRNXNHOGhN3wttoInFgO20nOWm5qCUWbryboTsC1l1N03XysiYdXEVgrwx6O
 zOIgE/4WmjbyCt44shDUgft/rqudXdehe9s+4YnEY0MWxUzAQEQHhMLhdflZyeCALt61+g==
X-Google-Smtp-Source: AGHT+IHP/rVccERcQHC4WsfHM2KAMHPGt2KIVAS+YjAYv3xIy5dRCLbBgzzaOY8oLCDhorWu8Q+Thg==
X-Received: by 2002:a05:6870:2313:b0:2d5:1725:f529 with SMTP id
 586e51a60fabf-2f5c7cfb19emr2005170fac.27.1751459677156; 
 Wed, 02 Jul 2025 05:34:37 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50b1b2fsm3864281fac.32.2025.07.02.05.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:34:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 19/97] target/arm: Introduce gen_gvec_sve2_sqdmulh
Date: Wed,  2 Jul 2025 06:32:52 -0600
Message-ID: <20250702123410.761208-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc36.google.com
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

To be used by both SVE2 and SME2.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/translate-a64.h |  4 ++++
 target/arm/tcg/gengvec64.c     | 11 +++++++++++
 target/arm/tcg/translate-sve.c |  8 +-------
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/target/arm/tcg/translate-a64.h b/target/arm/tcg/translate-a64.h
index 8a9f4b2053..993dde61a4 100644
--- a/target/arm/tcg/translate-a64.h
+++ b/target/arm/tcg/translate-a64.h
@@ -225,6 +225,10 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
                         uint32_t rn_ofs, uint32_t rm_ofs,
                         uint32_t opr_sz, uint32_t max_sz);
 
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz);
+
 void gen_sve_ldr(DisasContext *s, TCGv_ptr, int vofs,
                  int len, int rn, int imm, MemOp align);
 void gen_sve_str(DisasContext *s, TCGv_ptr, int vofs,
diff --git a/target/arm/tcg/gengvec64.c b/target/arm/tcg/gengvec64.c
index 2617cde0a5..2429cab1b8 100644
--- a/target/arm/tcg/gengvec64.c
+++ b/target/arm/tcg/gengvec64.c
@@ -369,3 +369,14 @@ void gen_gvec_usqadd_qc(unsigned vece, uint32_t rd_ofs,
     tcg_gen_gvec_4(rd_ofs, offsetof(CPUARMState, vfp.qc),
                    rn_ofs, rm_ofs, opr_sz, max_sz, &ops[vece]);
 }
+
+void gen_gvec_sve2_sqdmulh(unsigned vece, uint32_t rd_ofs,
+                           uint32_t rn_ofs, uint32_t rm_ofs,
+                           uint32_t opr_sz, uint32_t max_sz)
+{
+    static gen_helper_gvec_3 * const fns[4] = {
+        gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
+        gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
+    };
+    tcg_gen_gvec_3_ool(rd_ofs, rn_ofs, rm_ofs, opr_sz, max_sz, 0, fns[vece]);
+}
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index d2cd298b5b..7e304245c6 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -5948,6 +5948,7 @@ TRANS_FEAT(MOVPRFX_z, aa64_sve, do_movz_zpz, a->rd, a->rn, a->pg, a->esz, false)
  */
 
 TRANS_FEAT(MUL_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, tcg_gen_gvec_mul, a)
+TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_fn_arg_zzz, gen_gvec_sve2_sqdmulh, a)
 
 static gen_helper_gvec_3 * const smulh_zzz_fns[4] = {
     gen_helper_gvec_smulh_b, gen_helper_gvec_smulh_h,
@@ -5966,13 +5967,6 @@ TRANS_FEAT(UMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
 TRANS_FEAT(PMUL_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
            gen_helper_gvec_pmul_b, a, 0)
 
-static gen_helper_gvec_3 * const sqdmulh_zzz_fns[4] = {
-    gen_helper_sve2_sqdmulh_b, gen_helper_sve2_sqdmulh_h,
-    gen_helper_sve2_sqdmulh_s, gen_helper_sve2_sqdmulh_d,
-};
-TRANS_FEAT(SQDMULH_zzz, aa64_sve2, gen_gvec_ool_arg_zzz,
-           sqdmulh_zzz_fns[a->esz], a, 0)
-
 static gen_helper_gvec_3 * const sqrdmulh_zzz_fns[4] = {
     gen_helper_sve2_sqrdmulh_b, gen_helper_sve2_sqrdmulh_h,
     gen_helper_sve2_sqrdmulh_s, gen_helper_sve2_sqrdmulh_d,
-- 
2.43.0


