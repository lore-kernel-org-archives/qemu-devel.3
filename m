Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7099CC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjG0-0006lO-NJ; Fri, 04 Jul 2025 12:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFM-00047R-Sg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:45 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjFK-0006v9-Rq
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:44 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so793299f8f.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646401; x=1752251201; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QhcbhThxEkhtCB7f3egNLkEqw9xFyXJHz19uqfLo854=;
 b=EWSjdfTceQdlm8LmFeKsogaJCZxMsKb5ocsE8cWkCZ+OVbwTDQxz8zQdJQVkA6o17B
 EdCaCUkgY0CTiC0KtO0GDDhKNPlsydv063vCK9BCvQzL88V6Jy3jZTK880BSsqjh1qAF
 Kf/9AuD0zaXgGUdQ3FYvIWciaaV2k+kvQLIt3/hitXWWq8P/On5ZnRMnQ83wCE/0bbpE
 ad7veHq5j/gW0A9QM4FRxZGkxdiLfG1kylNizJMLpyBfx4WTbHIBEEX6612LsoZMAkgC
 LLjSFq6pgpW2uNdTc29dzUTZzsesku6tGZR1OnFHUXvW9MJO4Zj83aPKPy4OS+Zrlml7
 GTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646401; x=1752251201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QhcbhThxEkhtCB7f3egNLkEqw9xFyXJHz19uqfLo854=;
 b=au7tH1EhQmFCA97LLzzB8DZhYRiQ68ffpDkgYTEnBIdSzPrRI2WkTSoNS/P5Ui1AKz
 mcxSo0RPRC1qGR4LQUTZ3vosamDe+A8bFZP2abeeiIQYmaBq/4eq6UQ9Ut+Notu2W4tJ
 Q0l1UZvSPCIoVkXb7erMLM5nrC9aR0ppF9AoFWXsdpcgdSPPoil3QesgIvR/JngpBkkt
 VBOcsH0U5huZlaYMnRnvdkL0caDu6pYAFD8Bjf1IyxHirpq1Wq3fga9qmaGoZC3etJkK
 tpz7nI6Eda82B7z63/rZA8v1mzO9H1DEygl1SbuFLrSVzPQgE+K7PTIp+4unqurN1D1g
 bS+g==
X-Gm-Message-State: AOJu0YzRyrgscR4JIDtubWtSaogom4BTcLkrqFjMhs4WCymArlvNeuSZ
 DxJi0vd4BQ/0K87sS0roN+RxViylr0Grw4RItn4lTVzv56v4C7k00N5s0DGOn8lHygEG+z2gt60
 +EdB/
X-Gm-Gg: ASbGncvIlQh5QwuxS2HtVdJ93lBaYgwZ2V6B5lFYdLlQn9d64c6Qq4XTEu5OoXjVIC0
 3K2ngDr4Yrz7ZSzD+5DtDsor5WcbkETKhBCDP2aod9aHvjK2LtNK9YlRC0RmdGZZHazkMfXSju0
 E2e+lAMCEuVEZX2xobHHA4y4+FL4/zzU3adGHXrqG/GwbP9B/1h8tIZWRgA/r6t038N77hFdITg
 cnUBeWCy1rfmlJpuDSRtZ3yKh6KTVO8zk54mohBNI+VyA/1NEKSqbmbGU5r1psxgExmyzpvJ6ZO
 o4WYiVPau9HlSJdXOwk33fKukwKt09XLGruhmfZ436v6GjmZ2oLJ5V0C/wF7uZ1PK8ij
X-Google-Smtp-Source: AGHT+IG/PIxAJJrx1H24CYmkRm8UhtyLTxXCqRryiLudcfE/Flx8xkzKowuV7ZKaa0+e3MLhFLqgVw==
X-Received: by 2002:a05:6000:200c:b0:3b3:9c56:b825 with SMTP id
 ffacd0b85a97d-3b4955895fbmr3521586f8f.22.1751646401176; 
 Fri, 04 Jul 2025 09:26:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:40 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 104/119] target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 17:24:44 +0100
Message-ID: <20250704162501.249138-105-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250704142112.1018902-93-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 10 ++++++++++
 target/arm/tcg/sve.decode      |  3 +++
 target/arm/tcg/sve_helper.c    | 10 ++++++++++
 target/arm/tcg/translate-sve.c | 14 ++++++++++++++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 0f510ea6103..5f4b4aa0364 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -676,11 +676,21 @@ DEF_HELPER_FLAGS_5(sve2_tbl_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_tbl_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_5(sve2_tbl_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p1_tblq_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_tblq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_tblq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_tblq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_4(sve2_tbx_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_tbx_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_tbx_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve2_tbx_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 
+DEF_HELPER_FLAGS_4(sve2p1_tbxq_b, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_tbxq_h, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_tbxq_s, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+DEF_HELPER_FLAGS_4(sve2p1_tbxq_d, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
+
 DEF_HELPER_FLAGS_3(sve_sunpk_h, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_sunpk_s, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
 DEF_HELPER_FLAGS_3(sve_sunpk_d, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index e98275eec15..52a56d33413 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -663,6 +663,9 @@ ZIPQ2           01000100 .. 0 ..... 111 001 ..... .....         @rd_rn_rm
 UZPQ1           01000100 .. 0 ..... 111 010 ..... .....         @rd_rn_rm
 UZPQ2           01000100 .. 0 ..... 111 011 ..... .....         @rd_rn_rm
 
+TBLQ            01000100 .. 0 ..... 111 110 ..... .....         @rd_rn_rm
+TBXQ            00000101 .. 1 ..... 001 101 ..... .....         @rd_rn_rm
+
 ### SVE Permute - Predicated Group
 
 # SVE compress active elements
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index dbbfbc12b97..42b05756a9d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3577,6 +3577,16 @@ DO_PERSEG_ZZZ(sve2p1_zipq_h, helper_sve_zip_h)
 DO_PERSEG_ZZZ(sve2p1_zipq_s, helper_sve_zip_s)
 DO_PERSEG_ZZZ(sve2p1_zipq_d, helper_sve_zip_d)
 
+DO_PERSEG_ZZZ(sve2p1_tblq_b, helper_sve_tbl_b)
+DO_PERSEG_ZZZ(sve2p1_tblq_h, helper_sve_tbl_h)
+DO_PERSEG_ZZZ(sve2p1_tblq_s, helper_sve_tbl_s)
+DO_PERSEG_ZZZ(sve2p1_tblq_d, helper_sve_tbl_d)
+
+DO_PERSEG_ZZZ(sve2p1_tbxq_b, helper_sve2_tbx_b)
+DO_PERSEG_ZZZ(sve2p1_tbxq_h, helper_sve2_tbx_h)
+DO_PERSEG_ZZZ(sve2p1_tbxq_s, helper_sve2_tbx_s)
+DO_PERSEG_ZZZ(sve2p1_tbxq_d, helper_sve2_tbx_d)
+
 #undef DO_PERSEG_ZZZ
 
 #define DO_TRN(NAME, TYPE, H) \
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 28cfcb9cb4c..02f885dd48f 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2380,12 +2380,26 @@ static gen_helper_gvec_4 * const sve2_tbl_fns[4] = {
 TRANS_FEAT(TBL_sve2, aa64_sve2, gen_gvec_ool_zzzz, sve2_tbl_fns[a->esz],
            a->rd, a->rn, (a->rn + 1) % 32, a->rm, 0)
 
+static gen_helper_gvec_3 * const tblq_fns[4] = {
+    gen_helper_sve2p1_tblq_b, gen_helper_sve2p1_tblq_h,
+    gen_helper_sve2p1_tblq_s, gen_helper_sve2p1_tblq_d
+};
+TRANS_FEAT(TBLQ, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           tblq_fns[a->esz], a, 0)
+
 static gen_helper_gvec_3 * const tbx_fns[4] = {
     gen_helper_sve2_tbx_b, gen_helper_sve2_tbx_h,
     gen_helper_sve2_tbx_s, gen_helper_sve2_tbx_d
 };
 TRANS_FEAT(TBX, aa64_sve2, gen_gvec_ool_arg_zzz, tbx_fns[a->esz], a, 0)
 
+static gen_helper_gvec_3 * const tbxq_fns[4] = {
+    gen_helper_sve2p1_tbxq_b, gen_helper_sve2p1_tbxq_h,
+    gen_helper_sve2p1_tbxq_s, gen_helper_sve2p1_tbxq_d
+};
+TRANS_FEAT(TBXQ, aa64_sme2p1_or_sve2p1, gen_gvec_ool_arg_zzz,
+           tbxq_fns[a->esz], a, 0)
+
 static bool trans_PMOV_pv(DisasContext *s, arg_PMOV_pv *a)
 {
     static gen_helper_gvec_2 * const fns[4] = {
-- 
2.43.0


