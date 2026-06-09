Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC00BCD8CAD
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:27:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX25s-0006ry-RE; Tue, 09 Jun 2026 15:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21s-0003Z8-D9
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:31 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wX21j-000430-7Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 15:22:25 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2c0c3315c5dso62661915ad.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 12:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781032878; x=1781637678; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NmWu/sDAtkDjl8gAPTj3dJ28zzesg5TWuoVZT/pgdHk=;
 b=F7giLOIALRnhJGUCKYqpJpoIXmnZiHm2+EVrMpQuVHbVsExr4U93WGw8zNz6O7j1wx
 JshxmK3Vp3WZJdYxbUM92GxmgE1LmTL13yqikDNO6s1v0HucyvrBbJ75pa2XWP4mwtsd
 EB5/kvM1Y22eJ4xVaENFM98kfWMNIKGJcsUINRoW7LkQDALcGB1a7DB/rqUfHZf8oNtW
 dnc7OF/HoTL5Y7bJWwTwZO6cOt7q/Bk/fY7oQqLwuMAKLkDrPBlPF8awzMPck9rTGdi0
 u0OgRJmVKOqKaX6jyp267rCssxcg7OLfEkTp6n65hgrlvmzm44fBwuIGVzdMSNwXtjEa
 jhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781032878; x=1781637678;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NmWu/sDAtkDjl8gAPTj3dJ28zzesg5TWuoVZT/pgdHk=;
 b=CcWCTGFwpzQX4f3O/+9thrRhLhHa3HT1Al5qNSeodWSf2QkP1iRjoBWSkXWmXBWz0v
 cDOITZSzAwI3pDM6pXmybULzVsm1AtpHkK0QNelyi7TSzJpuLuEnT5NC7QpdEtP8jGK7
 6EqfPy5dtVBPaU9aKYw4AqtL+dK/WiuU1SNgGt6gPUz6RhL3ZfgLDvFifMsg0/QCO8lZ
 EioMYQOJXkjW104HEj3Oo4DW1oOxBf8f2/7UPWZqaFG/ssIyN54BC47gk+gh+Jo+9BCG
 Ia3cHuNnKgBbQUuzM7cQisgevTrkZRuqnkxvFJVd7V6PPx/m1d8B5hV0gT+WPDvE4vgT
 Z+pA==
X-Gm-Message-State: AOJu0YyXk46ohdFfn0nnFq6k1XozkZeEDM9B8RLBw/uHwGYX7CubD6fD
 5MKaxZ1OUDZWK+NsZBQoIgPwi/eIqziNXD5HjTrDeAFga4guEnVnggZcppXvWhJeS7cvRvfsX4/
 /vzq8crY=
X-Gm-Gg: Acq92OEnVyKLvfBjVn/5VPKt86a22VXyemvhVP5zBYaPLZv2nbCsOCk5C4dazjgj9V8
 hLEip9rm4HU8MteO1S3AUgs1Y8K26wZgqRjw980q34Kr10/QcdrZa4uR7McSAToq8ku3+7LNJVL
 7wyOiYlBBPu9UMbnilvgCm6rrOavoN38+YE6PlC8lpbj594rFXEccB13r8nezzY44/oaSO0KkGT
 NDJxAnd04YIAK/UXM18ml7TFTT2kkdeee97U1Y/BmryPMZkIZi1YmGdEwIuOPUGgkNsyHb4h8U+
 LSgFATj4v/pGWHEpEon+JSoIUyhOAu0Qiw6NNuZuw2DcTVs4FTwxePT+ui1/uliNl9AtJ9Ewe2c
 Dem7HNwrP/csbY+ii8Su/kgRJJjmANu49zD54b7Ul6z8bYXw/whUpLFIgdC7fyTYPM1eeue42Ys
 Z1RAWjjB7X4P012gDWt2sS9OMygkuJ7LGpn13n6qE=
X-Received: by 2002:a17:902:ef08:b0:2b9:6458:1a2c with SMTP id
 d9443c01a7336-2c1e820e30bmr273218515ad.13.1781032877829; 
 Tue, 09 Jun 2026 12:21:17 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164f88473sm240806095ad.25.2026.06.09.12.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 12:21:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v10 09/45] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Tue,  9 Jun 2026 12:20:33 -0700
Message-ID: <20260609192110.752384-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609192110.752384-1-richard.henderson@linaro.org>
References: <20260609192110.752384-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

The existing pattern is BFCVT (single-precision to BFloat16).
In preparation for introducing more insns of the same name,
append the operand sizes.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sme-defs.h | 2 +-
 target/arm/tcg/sme_helper.c      | 2 +-
 target/arm/tcg/translate-sme.c   | 4 ++--
 target/arm/tcg/sme.decode        | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/helper-sme-defs.h b/target/arm/tcg/helper-sme-defs.h
index c551797c6f..01aad4c231 100644
--- a/target/arm/tcg/helper-sme-defs.h
+++ b/target/arm/tcg/helper-sme-defs.h
@@ -250,7 +250,7 @@ DEF_HELPER_FLAGS_5(sme2_umlsll_idx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr,
 DEF_HELPER_FLAGS_5(sme2_usmlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sme2_sumlall_idx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
-DEF_HELPER_FLAGS_4(sme2_bfcvt, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
+DEF_HELPER_FLAGS_4(sme2_bfcvt_hs, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_bfcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvt_n, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
 DEF_HELPER_FLAGS_4(sme2_fcvtn, TCG_CALL_NO_RWG, void, ptr, ptr, fpst, i32)
diff --git a/target/arm/tcg/sme_helper.c b/target/arm/tcg/sme_helper.c
index f508baed8a..07f86ddad9 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1725,7 +1725,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
 #undef DO_MLALL_IDX
 
 /* Convert and compress */
-void HELPER(sme2_bfcvt)(void *vd, void *vs, float_status *fpst, uint32_t desc)
+void HELPER(sme2_bfcvt_hs)(void *vd, void *vs, float_status *fpst, uint32_t desc)
 {
     ARMVectorReg scratch;
     size_t oprsz = simd_oprsz(desc);
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 82aa14131b..652a72e972 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1448,8 +1448,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            s->fpcr_ah ? FPST_AH : FPST_A64, gen_helper_sme2_bfcvtn)
 TRANS_FEAT(FCVT_n, aa64_sme2, do_zz_fpst, a, 0,
diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index ee874be1a6..7a8e1abb59 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -789,7 +789,7 @@ SUB_aaz_d       11000001 111 000010 .. 111 ...00 11 ...     @az_4x4_o3
 @zz_4x2_n1      ........ ... ..... ...... .... . .....      \
                 &zz_n n=1 zd=%zd_ax4 zn=%zn_ax2
 
-BFCVT           11000001 011 00000 111000 ....0 .....       @zz_1x2
+BFCVT_hs        11000001 011 00000 111000 ....0 .....       @zz_1x2
 BFCVTN          11000001 011 00000 111000 ....1 .....       @zz_1x2
 
 FCVT_n          11000001 001 00000 111000 ....0 .....       @zz_1x2
-- 
2.43.0


