Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED12EC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:42:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwq5-00068N-SU; Wed, 02 Jul 2025 08:45:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwn0-0008Ss-90
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:16 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwmn-00036m-2M
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:42:07 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2e9071e3706so2781930fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751460117; x=1752064917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZW5ZQQmdbfswXGecma+4/2R/EatacCWoSALlXr8oeFs=;
 b=v1PQBAEifyrAw2J1/IfRjPyDKdgNHiwwr3Uonv3KljrW3wHaN4DBJ1bQJB93Cn60QH
 tN+yxWN2qKzFa2pg59JK4y3TTtjboOLIjdH4QWBztLuD5FMjMWkFZ46Oc3KVXyZhA30N
 dpO3Yhy0cvsDwuiTMIiBJWZqarNJNdh73U7XDcvp49kCHld798cOdBgRSDSzkSrjHmLj
 PJtcnWGnkEmV9QFf8AO6mfdBpun62P9GY0miGaDXC5a8EOyzAj6SNH+IXjUriJyVFKGd
 UiY67UshEgpvnwGISK1oUPkliU2xSNosoCurttpEGMaflPzDrL2lrdLYhTQYLCvcdn+d
 EO1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751460117; x=1752064917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZW5ZQQmdbfswXGecma+4/2R/EatacCWoSALlXr8oeFs=;
 b=euqcBqSVMRBy33Mtz8Mr4H/BxcKBHTVtIQfplCWvnW0/AUTHPvVPXawjhGwA7iCVat
 MbeAcvUspRkimewu/UA8eIl8AeQjE/HKO4UutMPmB1ilJn3S1WKlL0L78p0/i+bzQCpX
 p3A8FsH0CLKAZVPT11wESfLM5IH+sYjsoKyaouffco5lEdvzftESTECSrQBQ8jfUd8R8
 cPldlyn+AnZvZmvhGeGFZItBYIB1QQrmWEqzzYnnZ84MYot4GVWF5YG9dJ13hg5hjs5Q
 lZKWuLAsp5DeW1kgAE5IoghJHY8wRi9OviWgXf/h/FyDxf0Jcp39/CR2GoYLbGfpqxQL
 vriQ==
X-Gm-Message-State: AOJu0Yxhj7cYGF8VlqwY/jD917zg8GnO+65eXBRmwgjYXYn/2+Xg4bDJ
 QCfyMvFu50bsjVq//UJ8EyTTfv+YmOuVn+xspkh8N3g+ttmiOYV+VZ1SKrJ8U72Ad7N7ttya1mf
 F4R0ym+c=
X-Gm-Gg: ASbGncupO4pDuLi7yIWJ9i0coCdqySHJiSGinnTxqN+wX9kKwEOm8uwiZyoRgBqj36J
 vaw1Me2vprCEk6msNHSDLyorlEiNE4/X5fhMuDXZbsiCC7+761fTLtdrtYtD+bX9CNR8K38KDmo
 tIxBVX+DhyjiQcaCH8/maN6of30S1iEtVkL8/wuDpcfdSQKQmDdcMhkTIJjumgXHkDPvz6U7GnG
 gMTwgvLvHn/65fJZvsVmaGif9RCSYvotm0nUDpSzK+kg2yGYrC7mtsJCC15EctK3Vi9s3G5a2GO
 oFDZC7k+QC0mbmZARJZ+RMAz/4E4DaQIttAAlWNqSEDcu1nwSJA9+3Spwza0OUwXGyUA+w==
X-Google-Smtp-Source: AGHT+IE+l0TgxS+ZZPnHKy0sL0/phJ9a+e107ywFEysyKyb7j5yDoeOtSvP10Wzv0UB918hXpE/4uA==
X-Received: by 2002:a05:6870:1655:b0:289:2126:6826 with SMTP id
 586e51a60fabf-2f5a8d3d508mr2099711fac.30.1751460117418; 
 Wed, 02 Jul 2025 05:41:57 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd50f7d89sm3907004fac.34.2025.07.02.05.41.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:41:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 81/97] target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
Date: Wed,  2 Jul 2025 06:33:54 -0600
Message-ID: <20250702123410.761208-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
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
index 0fc602fb12..c45d36433c 100644
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
index 4ed0fe0480..cf8497a388 100644
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
index e98275eec1..52a56d3341 100644
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


