Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDD3BCD4F54
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2026 23:13:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTSrB-0008TI-Va; Sat, 30 May 2026 19:12:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr9-0008RO-JU
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:39 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wTSr7-0007R5-Jt
 for qemu-devel@nongnu.org; Sat, 30 May 2026 19:12:39 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-36d5fd50d20so575712a91.1
 for <qemu-devel@nongnu.org>; Sat, 30 May 2026 16:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780182756; x=1780787556; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2AvY8+cKE233vmsOc5JoO5199jYX0ZhoNsXxnkTJ6o=;
 b=W6otLpIybyGI/eknX5SM5ynNkk1c4yiCiv5uaWZYdsWMrIvdg3LDJuqQh3MV2tBHJE
 WhrSK/+D7dao0uv02vJIKFTe7/tO2PwvwjXlLGD/PL8zGAvMaCLHGbYKDcWniK+GB0WX
 SRwi1+ndz61azv8FIN5XQPH84dEO+dMgmMJO0djUVgXRTSkSUHbCCAlioiSGvCl943Rc
 wtLUYXr1KpotLv9UlM6HPPouYKSbB2FnkQDnR38e7aLviRBGCRRPR6pJjcrNotFVpBA7
 tfjxmCqpjUr8S2vAjnm+utHDyczSTSKOGNgeVVrHILxI9pFHuQNYVVRfcDG+sAo3RiYW
 G/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780182756; x=1780787556;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R2AvY8+cKE233vmsOc5JoO5199jYX0ZhoNsXxnkTJ6o=;
 b=BHhwbaBZGZ+uzN0pqLZS9kyZY0AoQUn00NH0ooRaQfxRn1jf6XaMkarBWXzb0VY+bI
 mlwKZQPyVup7Zvoz/0cUgCfvsiyYw6J85yWDTNUClw2TVtDBEib4JzyKC70JQ3fn9Lmx
 pnPz9F1L9hfcRdwOAd/hbDO0slbCjESx2uK3NLOVdgd9Ch2Q/AgPvsObJikgypjECx3S
 4kz1SWOQBLxWyr9NHvbXNTc0jBfspJWTLTesqoe0KCozn/CTw3r5adBSm3aEdnTh6rwe
 tuTvLTRPRAnpfhCZf3ilhLTzsKcszXu85z0u1hdtNBkxbvsAUl42vvE2xXT9O8ad7BJ3
 +yiQ==
X-Gm-Message-State: AOJu0Yz72mHfaFZ1gHW8/9lsi7Bfzk6G6mGht+fmuz3KB6vtb5jOzLVD
 S1NqRvVcORuHfr6AeB1KLpmBFHd9PVJw/Xw6lQKEsxATer+TTm2KHSoNiLVDuGf4DJ1xVIU82jz
 oT43Fui0=
X-Gm-Gg: Acq92OHMFRPKqRm3SmV13LkuvgmOdZpGGb9hEUe376v08L6tLuE4iOrnT6V71z5Sllb
 dEo/Ffd11asm98aw6zWFzf3bcciisH+j8flCxiUpx3lXMvfXJorfJa2v0e+bksZNy3M8F3lnPHQ
 qFY93w67z4hHgSlBV6diwOqnKIELM+PmgVGYz0GvjadUEvSbqp4jA1vgJgJnRWyFC7LO84WyLhd
 +Owfpy1g61xLYxaKqh0OjE6rQbvByI7KTOoiYveIH3ynWLBGJq0X/fbhbA7gNuw+u4JMKsFWUoc
 8D9+QPSiwo42Hfzhmz6uLV6cCrIRlXYRn5TcykBJz74YkWhQRKG+0/6ASzju+lfIxRm7FrbC4UL
 OFl/DGa0t2I4/PPduw92f+hHXa7KkpZ73+F42nU/bmFF7FN9GrxUi4KqDZQaSH8jAvNYvhERh3s
 WhyNuIAS/PKO1QUZf+g3qUL6IhujLoHx8A87hJ1mM=
X-Received: by 2002:a05:6a21:6089:b0:398:a33a:71c9 with SMTP id
 adf61e73a8af0-3b428213800mr5558722637.43.1780182755903; 
 Sat, 30 May 2026 16:12:35 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c857729d3d1sm5634356a12.21.2026.05.30.16.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 16:12:35 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v8 05/41] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Sat, 30 May 2026 16:11:53 -0700
Message-ID: <20260530231229.400441-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260530231229.400441-1-richard.henderson@linaro.org>
References: <20260530231229.400441-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
index 0055e97a2b..a0f03c4671 100644
--- a/target/arm/tcg/sme_helper.c
+++ b/target/arm/tcg/sme_helper.c
@@ -1742,7 +1742,7 @@ DO_MLALL_IDX(sme2_sumlall_idx_s, uint32_t, int8_t, uint8_t, H4, H1, +)
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


