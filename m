Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98FCFC77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:42:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwp5-0003Fz-I2; Wed, 02 Jul 2025 08:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwk6-0004rg-NP
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:19 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjm-0002HZ-7G
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:13 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-2ea58f008e9so3760501fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459933; x=1752064733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHqvh21OXE4vjukTTqMZ2JA/l8VM2GH0ZoSM4ub9qlg=;
 b=X2hTW7dXzbrtNikYliWhHL1RVGX0NJ6dnxu5YjogiDpm/Sg4RdUi4RzaIV1lBXRjqn
 fffJ4LzITBYGYgEDUD4mo6TTHdg1/oYWC4jaAAavApgawJVVZZ8bKSstN8HA1fauwHwx
 fQ8ZzcV6ZzSREbpRcaKhK1tL4SawS2oPZl0XoCotpH6Jb9f7+caVoeyFk9hrI0N9pcXY
 5rpUOYoQRKyuWNng6hqfdRBN+xtc+5gvqeD5rJdXphUq2CNZG4rmcYjJInzFuAgCSVlS
 6/G0ObzKVgDBjej6qedSeAVQeumHQ04BBkSY/gh+HjMIIgWxVnQLQh2fqw2GtHhliekt
 4Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459933; x=1752064733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yHqvh21OXE4vjukTTqMZ2JA/l8VM2GH0ZoSM4ub9qlg=;
 b=TLOn+mcKfIU0iCTvvCJax43wlAdtVvO3bxbrQ0FgH9k3yxUR72GCzB1bhe1QJDE2T2
 91IOEMdeZZwHp6HxhdH5cJcuNaqqGBu/wWIWv2KxAKK7APxIL2cEO/XjYWYRSBKWVVhu
 bPB7lDLISN3GPkrFGhtDCot28QHax/Nl0ba6mPTNv23IoQ+1YYpXm52aaV+oixBJXcoa
 H5KmZ+4pU0SJIX+SBRfK934E5+ZxW1QskOBAaerniGy40ypfryfhSxXj8Kke8NITTXGo
 8OkSO5/64G0e4+JS9lZz8x7KrUfGgfTgcBnvLMxsNwkQuDuD8Ok9NIxzDXcgWT4jzdSg
 dxXQ==
X-Gm-Message-State: AOJu0YzL+Tj8dlk4eHxpjmTlifz70ZaSvWzo+29DB0kIM6rFHuwrJZUH
 mmzS/VugbyGfHXxzC1kxBB3b93ogzCxdH1kiqETrE00DysxS5vutsv2e58zhNu4tIya2eFdrnLx
 plAf0Iuk=
X-Gm-Gg: ASbGncuHALP8sVuRM7968Iey9xNeV4PXbZaaglqP2uD8C3Il1KBs6Bk4WnCx2KyI2wR
 7ZA95hq2hoVAEl0HvNfzo3BAGLsk+5ICwax5gHaDXreFbq5Reb7fKZoqXc/2fIOvjFuk1fDvzk0
 p6wWrM3tn6Lc+c1yeLXwjcK02wVCnFY+cdS+T1V6xhW/3NfBBloJcWDxGbJJ3ID+PN3kCr4j5PD
 KixPzNQbs8D+NTrjWKWNOog1S3fd84ljxjttCbumvK5YA6qJNZ9M/FuKNlbAAx/6iYaElqgKADA
 k7gs4IriNpHQUN1Tjx8OP3E8OPA/5Fu8FQuq5wN3KUzi9SkEDhu2yolaLlBI8i5al+HGLOXm479
 7U+gz
X-Google-Smtp-Source: AGHT+IHz3/F2dNnMZ+W+qxq5/54MT7ubAJU7vmIxNgXXJeTrVszEZx7MSVwtMvInZAhnb7682wHT7Q==
X-Received: by 2002:a05:6870:d03:b0:2ea:87d7:5a35 with SMTP id
 586e51a60fabf-2f5a8cdd633mr1819269fac.36.1751459932729; 
 Wed, 02 Jul 2025 05:38:52 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:52 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 78/97] target/arm: Implement EXTQ for SME2p1/SVE2p1
Date: Wed,  2 Jul 2025 06:33:51 -0600
Message-ID: <20250702123410.761208-79-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2b.google.com
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
 target/arm/tcg/translate-sve.c | 49 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  2 ++
 2 files changed, 51 insertions(+)

diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index e33b2eb2a4..a918da31fe 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -2202,6 +2202,55 @@ static bool do_EXT(DisasContext *s, int rd, int rn, int rm, int imm)
 TRANS_FEAT(EXT, aa64_sve, do_EXT, a->rd, a->rn, a->rm, a->imm)
 TRANS_FEAT(EXT_sve2, aa64_sve2, do_EXT, a->rd, a->rn, (a->rn + 1) % 32, a->imm)
 
+static bool trans_EXTQ(DisasContext *s, arg_EXTQ *a)
+{
+    unsigned vl, dofs, sofs0, sofs1, sofs2, imm;
+
+    if (!dc_isar_feature(aa64_sme2p1_or_sve2p1, s)) {
+        return false;
+    }
+    if (!sve_access_check(s)) {
+        return true;
+    }
+
+    imm = a->imm;
+    if (imm == 0) {
+        /* So far we never optimize Zdn with MOVPRFX, so zd = zn is a nop. */
+        return true;
+    }
+
+    vl = vec_full_reg_size(s);
+    dofs = vec_full_reg_offset(s, a->rd);
+    sofs2 = vec_full_reg_offset(s, a->rn);
+
+    if (imm & 8) {
+        sofs0 = dofs + 8;
+        sofs1 = sofs2;
+        sofs2 += 8;
+    } else {
+        sofs0 = dofs;
+        sofs1 = dofs + 8;
+    }
+    imm = (imm & 7) << 3;
+
+    for (unsigned i = 0; i < vl; i += 16) {
+        TCGv_i64 s0 = tcg_temp_new_i64();
+        TCGv_i64 s1 = tcg_temp_new_i64();
+        TCGv_i64 s2 = tcg_temp_new_i64();
+
+        tcg_gen_ld_i64(s0, tcg_env, sofs0 + i);
+        tcg_gen_ld_i64(s1, tcg_env, sofs1 + i);
+        tcg_gen_ld_i64(s2, tcg_env, sofs2 + i);
+
+        tcg_gen_extract2_i64(s0, s0, s1, imm);
+        tcg_gen_extract2_i64(s1, s1, s2, imm);
+
+        tcg_gen_st_i64(s0, tcg_env, dofs + i);
+        tcg_gen_st_i64(s1, tcg_env, dofs + i + 8);
+    }
+    return true;
+}
+
 /*
  *** SVE Permute - Unpredicated Group
  */
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 2650e00f80..af4fb966bf 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -583,6 +583,8 @@ DUPQ            00000101 001 imm:3   10 001001 rn:5 rd:5        &rri_esz esz=1
 DUPQ            00000101 001 imm:2  100 001001 rn:5 rd:5        &rri_esz esz=2
 DUPQ            00000101 001 imm:1 1000 001001 rn:5 rd:5        &rri_esz esz=3
 
+EXTQ            00000101 0110 imm:4 001001 rn:5 rd:5            &rri
+
 # SVE insert SIMD&FP scalar register
 INSR_f          00000101 .. 1 10100 001110 ..... .....          @rdn_rm
 
-- 
2.43.0


