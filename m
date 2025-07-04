Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9294C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:35:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUR-0003po-Rd; Fri, 04 Jul 2025 10:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPK-0002dh-N9
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:55 -0400
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPI-0001Zr-11
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:54 -0400
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-2ea6dd628a7so806008fac.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639331; x=1752244131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YWyPqMqMItiN1bYNx29FmyoNvhqQhz2XxM1Ps77ao94=;
 b=d7kbg8LogEuKlL8KBuJWYxKBB8JGEDwTZ/vK0TRyLLlC3er++VNGmquunDhwxtkOPu
 MO7VUaCTvBwvC4X/n8KnD4nrgA+7Oy0hbDand2TTLx2uXrLnXNbKFrT8i+vLYhrjcH6l
 W9XDouj6fq9UUHNOs1olCASfx8PEozD7WWf2qevCvM+da4EYE1Jhim9xEMoSIBUDiQ4H
 PLtc+dtIJBxhUotOyFkeKJrDjbZ/cSPaxb4IcNePk4ApDNZa3rSFIpG9d/qyGvHCxg2j
 r89b4aXs9EFpWzHrvMYSoaHkOV3wpWZY3Eer09sjUQC5EiW6nYCGcmnrTK4iFvOvvwY1
 wF6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639331; x=1752244131;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YWyPqMqMItiN1bYNx29FmyoNvhqQhz2XxM1Ps77ao94=;
 b=J3khJYemhMJlvaA029i/WX/zT1uuzFOGa8UPGMY7x8XJwUcFCXOG61S20BOAV6xlhb
 xohdbKrQNM8NWM26PVFZN5LIi3cZ8ldIqChYChwb3MM6CUKqe81VE4haKuSDDpczXRCm
 hdkwnYxhTx0tYWGi0sUHvqxYl2QsoTZuNt7ISl/zR4NhSsseoPMl02xXpYCSghQXxj/2
 yopzE9dQP+X3J0azLSVLB31bDmxLLjoyo+F/IFBYKGu57Q5DxfZCTdWM8cpMWe6HlWG/
 k9ipToOrx+yqp1aULQDyEBLAQZzbNbm1yx3PgqAkILz/mC9SUMkjdwIJKzHqN1PIWv0g
 TzQA==
X-Gm-Message-State: AOJu0YzHJtdZB1NHJZnLtT8SUm73u2YsaSBPG28xBxmzcwzYvG4vN9eK
 AWZUsCVb6FRQTUErglWh/QhoXQ93U+f9JUwQTyIrW4EhM3laHaGOIw639wCm8+fkapqcWEMGhXt
 onCdt0hc=
X-Gm-Gg: ASbGncsdGVUJOKeEWv30e8aX2CulBR97caCzGbXhy79IbhDH3DPfMXvE5AA+l3WlsV3
 Ic/3yePX92HwDWMXUtuHjtXBagK6CTBV+Is4ufBGrvts9uhJduoVhmTpKKYHRXlN6aG9L2UPJ4X
 SXmH48/W+HdcxziSwbUNBdoePKvrIeeOmpr1MMUCrbGeJ66zeEWhH5tbTdCUxS3wX976wjKFYTJ
 tzWDDLsUkxokbh13pQ05wVoFV/KKPC1eHy40nMB4wAdwM9tvrsmB+6vgQq3bihU5NUyx7KoWEQr
 OzL8fh+8tvimmk0lrvrJORPQuWGO+Y1RL9kvREMFYEgKr+vVt6W/QgAHHSrdIrgjP6isoCIosmR
 FNEHOTSYuG/o8Coi1IBNLBKiTXxTie4xNASCSTlLmODWt5OtR
X-Google-Smtp-Source: AGHT+IG7nhkb2KsbNJ9klHAKAJs1EFEsqXFcAKsIn1Ke00RrQnzQ3txHjihe79jxDD2W3Xlhah48IQ==
X-Received: by 2002:a05:6870:829e:b0:2e4:68ee:4f21 with SMTP id
 586e51a60fabf-2f796c34cdbmr1852542fac.20.1751639330668; 
 Fri, 04 Jul 2025 07:28:50 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 092/108] target/arm: Implement TBLQ, TBXQ for SME2p1/SVE2p1
Date: Fri,  4 Jul 2025 08:20:55 -0600
Message-ID: <20250704142112.1018902-93-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x30.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index dbbfbc12b9..42b05756a9 100644
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
index 28cfcb9cb4..02f885dd48 100644
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


