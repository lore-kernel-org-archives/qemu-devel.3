Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD48FB44A4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 04:35:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wG8DD-0001IR-Fw; Fri, 24 Apr 2026 00:32:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8D7-0000tm-NX
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:15 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wG8D6-0003Ln-2u
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 00:32:13 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-409de4132b5so4764872fac.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 21:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777005130; x=1777609930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=127uBHcVT1oBIbFF2ckf3+yTVZK3U9JgwdEZdx7lwQY=;
 b=l5iOg6spdZlkKflXZ8GmxNV4CachQw2csm9AZGcrK7sv7DyLMjXh76l6zyGO4uIO91
 da3HKrTo4kuXuntOFdMI5IjruWM5x/Ip+UL1B3uTwr+ikNTtGePf1tKZ6NsBX8/UgM3j
 CeAdU3QWnh63bsTFcobMigZxU41gOykcnaZ3uQKOp1V76SqsN3VQhuHSQAJVJWYW8w2i
 kXdw9OELuCKy2IEQIgGu9EPYli98GN5IIXRuT1gdKg1MvR++uIBITR4KqkCw/FGrM50q
 SsjBMR0TphDZxMvntwoH0PctDNoUWEDvsmyDm2L/wZy0Xp0XSiyl2zSTiVI/Dgb41Ic1
 2GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777005130; x=1777609930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=127uBHcVT1oBIbFF2ckf3+yTVZK3U9JgwdEZdx7lwQY=;
 b=iVrPYDNd0VWjymNKAgiXQwFl4tnYFOK5EuSz8T/HHvxT+Fv/U4MtOdKHk/7LbGS8LQ
 G07UQpYpKUG2YceE8EpW/bUISVkJTDRGSB23U78rG728PnMyAnZneTzdt8JWm0qgKmw5
 d4BMpbaGBsY7jX0Kz1grhaAr11EHyboDVM9xqfBnVY1XtykbA1KRteeH6PHnwwEdXnLo
 +fNbDcekByq30KN4svGGLTkGfspi864ndnqfAz1cikN4g1n47xdOLp5DaIw5tHS25Xuu
 flQDu8UqNVKFvuL4SUjvu83xIu6l8rsnGd0kDhICBylrVSjga9AZzEJSEkGRfj8RX8EW
 fWOA==
X-Gm-Message-State: AOJu0YwhiQdi698RiObKle9wvEaFqB/HejDnmfOFyb5UUlwiGQYDdCpU
 j6VZp+LlXDsXOja3f0F5KG/YDnr3nL+b7fpLKRC2ueFq959ywg7u60LtPAprfXEw8Crcba1iSyu
 pPaZs8Uk=
X-Gm-Gg: AeBDiev8EZs2bkrucaD5554ROoS//pgGLZdcuu68RzpSC67SOrsciL1szfALYDKQkTo
 R758SgiWLAjyZEqiGIAOmO+Eyl0U7OgOgDti/+v3jbMZub6FMZizDtYbMIR5NG52fg6g1jq9Mup
 4q90QyTmRt9o3FyHpdDAwuYddPRVkryBSYdJaLn+9Kd66OSS/wVOFxuhw85GAF3CMs5AXvpl9Hr
 /mnxrfVyz91HoL87CsDtOCHjcg3Bz9R+VeTj2q79ne0gGhTVKzSfeG/NsBNuEIzz5c0mfsF9uSu
 +86x6dmnBcr8SYuydO7UZUd0+ZmEjoADX+8psDxYg8776DX1igkIihlciagwdlJJv1zZhYhCSsp
 U07oF0NqVHuOk5s/qNN+R5RdK74ANGh0UrHuYqwGGb7WhH3LFLtWy/j/5sL9LDL4P/aeObpv9tx
 bcfhGOdn+bKn9FsG7w+0Abk9hW6VPlC5HaiLr2JGWSdlYCO83Xi6UtYVxPKShyEg==
X-Received: by 2002:a05:6870:174c:b0:430:a:4f3d with SMTP id
 586e51a60fabf-430000a5256mr1129827fac.4.1777005129811; 
 Thu, 23 Apr 2026 21:32:09 -0700 (PDT)
Received: from stoup.. ([172.58.183.19]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b9ac54ec5sm18880864fac.13.2026.04.23.21.32.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 21:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v2 25/40] target/arm: Rename SME BFCVT patterns to BFCVT_hs
Date: Fri, 24 Apr 2026 14:29:59 +1000
Message-ID: <20260424043014.46305-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260424043014.46305-1-richard.henderson@linaro.org>
References: <20260424043014.46305-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

The existing pattern is BFCVT (BFloat16 to 8-bit floating-point).
In preparation for introducing more insns of the same name,
append the operand sizes.

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
index c6a8eec32c..1267d3e65f 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1447,8 +1447,8 @@ static bool do_zz_fpst(DisasContext *s, arg_zz_n *a, int data,
     return true;
 }
 
-TRANS_FEAT(BFCVT, aa64_sme2, do_zz_fpst, a, 0,
-           FPST_A64, gen_helper_sme2_bfcvt)
+TRANS_FEAT(BFCVT_hs, aa64_sme2, do_zz_fpst, a, 0,
+           FPST_A64, gen_helper_sme2_bfcvt_hs)
 TRANS_FEAT(BFCVTN, aa64_sme2, do_zz_fpst, a, 0,
            FPST_A64, gen_helper_sme2_bfcvtn)
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


