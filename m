Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCE9C7EE2A
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:00:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85o-00068z-1v; Sat, 21 Jun 2025 19:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85c-0005Ng-96
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:40 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85a-0006bz-3h
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:39 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2363e973db1so21209195ad.0
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550256; x=1751155056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=94eN2/+hr4yQMwjTplbGW4fRmz5C2Lr2iKkNQZzstUY=;
 b=SxYgjTKfAK5SUyJcjbYLuSv5K7xY1BpSA7hjW6QUOO+n6BkaWIbGinI4w/F5L/7Ymb
 sIqazfMCRGBvRnnCmYhJoXmmlgJNvXcdd6L3yisIaBzs1EApLbgy+BdaWavKJpSAlhdE
 CbKy2CiPearBnRdeVYN12BZDuIAJnBXEM+rP4zj1ShSdAnRVTwyeoyyjbWcZpPmt6YYv
 FoAdFoFA7Hi5wOyie7omnVCpA/YppehdQHouZJ8F/r2CYa15RAy5mr+1EkBpgaHsGSCW
 WPczqdntxRpfADvzgZJT3jvgCCBtsAFufXKWFIq9gKo9T/nFLXX0Fkx6LjeV11dofc7C
 eieA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550256; x=1751155056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=94eN2/+hr4yQMwjTplbGW4fRmz5C2Lr2iKkNQZzstUY=;
 b=haquGkoMnPn9ciJckJC/SzT+hFj7QpXOpdfB0HJMpIujAzEQtM7KHaVv47nl4m2Lc8
 inMPeP91+E+3DtDxJ5kQbkQOFLfClHIevh4qdXejHtYohVtxudy89PuXg0Ku9T9eKhJ4
 ujOOQyjEz8gthHg5daG/by6M03r0yJ3BhOgLnAHuhW4IUZ7Lhs6x+qG47yBhV1mh0dib
 tRRZR91ma2DHv98hzXBxpCpHuY3Q+cR2xIMLKSEwcq4ehA8w5cpb5KwWeMDR1jfGywPz
 xBoOmgwMVZV9XrYpdtDhY5Ibfyh4wuA17uSTfCmbNUX4sqAeGC3XKM4MAZ233+oTeiAq
 jpjQ==
X-Gm-Message-State: AOJu0YwC5QGA0YPFXQLRfCBUJnfD6lXZFBVlQ40ms3y1//8WUxI73rt2
 b5Lo3l7Iufn27zl0aTJYYmNYVPf8Eiwmi1cCe0NVv1B7chsNzgkp8hvKEfpFD5bBRUIJecRSJJe
 7Haz8dFQ=
X-Gm-Gg: ASbGncsHExkuA+OLN3OGVGqNYLCOvzAia+gqdXpdzEkl7cjzBCjCaemTgdi6uMgSbPA
 SGYKkOM5oBzBKSrNns6vZCpw6dVf4+VawQaRXc2ywQrwnPsEvwiEPZObRChdUl6nPMjtBzLd5Ab
 OQZgJ+0ZfAaLYpHv1kMY3+OccPYRtg0WmiP+u1ICsgIsWLmz8DsBwl9GeFF1SlWd02TXCfFzQq7
 i+SboQqIKxRr0eT/Eo4HckFrcnU97Q7KKGH0sFpR51cTYQpHN2J83hWhyEj20neD76mE0JdIdMZ
 M+rgLCjXOKrbtVVFbxR61jSQo8xRKLWQZJcGOt+NmB7AEvRS/9MUAc4frQcHGC9dMslN7z4MHjN
 k6nw9tVGpPjIjW+Wyj+wQ
X-Google-Smtp-Source: AGHT+IGQ4uS2Q+pXmctqTW2pY/41509Mh22ya17lOQZ5lCMlcHaemvNuBLqfQ4i1aN2jiLmkXh8KEQ==
X-Received: by 2002:a17:902:ea04:b0:22e:457d:3989 with SMTP id
 d9443c01a7336-237dad62e05mr104926855ad.0.1750550256479; 
 Sat, 21 Jun 2025 16:57:36 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 090/101] target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
Date: Sat, 21 Jun 2025 16:50:26 -0700
Message-ID: <20250621235037.74091-91-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    | 10 ++++++++++
 target/arm/tcg/sve_helper.c    | 10 ++++++++++
 target/arm/tcg/translate-sve.c | 14 ++++++++++++++
 target/arm/tcg/sve.decode      |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 0f510ea610..5f4b4aa036 100644
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
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ed5147031f..a6410d8fc4 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3844,6 +3844,16 @@ DO_PERSEG_ZZZ(sve2p1_zipq_h, helper_sve_zip_h)
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
index bbb424b738..f0c00d8ace 100644
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
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 623c6f2520..4e5a927f1b 100644
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
-- 
2.43.0


