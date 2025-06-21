Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3410AC71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:02:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT85g-0005ir-S7; Sat, 21 Jun 2025 19:57:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85Z-00051F-ET
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:38 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT85W-0006bE-VG
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:57:37 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-7490702fc7cso1381595b3a.1
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550253; x=1751155053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W32swdV2nckBHqv8l5CkBb7zNBbfjSUebdNet5BpRJc=;
 b=iDfr4T2pmV77I0Hasi6RbmVh1lCGIRlUzBLIsUu1msAn0uq1HteGVU4vATFwHgdjcX
 z4ESA5r//p/ChUkruyxXuV1Xc/uRZKCykCdziTjVra0HskuAUfcrdxQejxyRaGJT40TE
 vnyFtdksIWZvlan65wuLH8j5V8u0sQlxdCISH9DqdeStgE/DcXxrJOUkpJboQ2dwxBok
 ZkZWWD9kf9ji4YWEA7lo4GituNwnc0oS0GQSEnnj08uvr7tMXpAfjqJFH16YtVrAUc+i
 PdK4z56XNROiICC61w/VPkjKxaUBRuWO0ES7A/q8lZwslA/H9N7nqGz82XUoH4wATgTM
 CbEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550253; x=1751155053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W32swdV2nckBHqv8l5CkBb7zNBbfjSUebdNet5BpRJc=;
 b=t1za3OyPRYo0jJWMEw17xItdh/0fhtjQMPWjZBzs+E3nFCJ+DSnKuYBz2R+8MPe1gL
 kUtWnNhkbd4D97/3i2Mz/2+lfr3eXf4Jwzb7z5UIVhWFWNHQVTZ4SeYwMHV9wNU0QGFB
 qURtODp4Khk+wuplDGiLvbX95izGiu6h8Nt7nKYYLcZmEtM7oguSkrUlIVpL9ptWZCiX
 i7FF4DqcFHYZFxZ13nCBmdvzlxbAwmHxsJTO55tQ+5KPTadgH5hsyjudsD0nxds4K/y2
 SgOUUHn0EbkeKukozA0pINHMDKko+XbQORyCPumjktZIvhUIO6aHGHcMqcta6tV19vkK
 4DUQ==
X-Gm-Message-State: AOJu0YxhUvXrL+UEXe3xfMDpeP7DIudit6aXLitFCf6x17GUP4/lkf7M
 c9ywxC4jtNI6GyhpAIw9KJH4XMkgoI816ESZ0nmzy4Gd0ieZJB+jAqZLp+im4hF5OwilC+GSm2T
 G1WWdgn4=
X-Gm-Gg: ASbGncu48rqDRJlXWX99RuFyG7sAfoEA/g6Pg3+vmBJE2SixryLK+0PVqrae2z6jOO7
 xEI3Hj2W6wUIYhFMeco2uhbIwq0sfnpaoavF+A+DaDIshSQn9cEbIFNf7w1h9FxDmdQ84+38hKO
 8GTl/9nTCCeY/KKh6mMl8MBGPWpB4wb2rixsXAE/weYfK+XOcBx6x1VlTNHnmb9YzhIfpscH/SM
 a5isTtTd1/5BiX43qD72STIqLW/8MwUw5V05XcDcb66P02Tb0v/3E+fj1bezFRRZfkTSCLfQnro
 RWzjTJ5ijHnmE1zzHRBGFpjLECNJEKJuHdBVAuQaBlcUWStC/Ho57x8s65GMx72I8YYRHMNHHo8
 7QZq6qc0X8Yxu4kzd8/WL
X-Google-Smtp-Source: AGHT+IE0N9VM4vW5ckbA4dEKyqVOOuL9XcaT7gjGrdCcdQkuKq43wRk/8aarbs8AP2u9pmDVKQwoew==
X-Received: by 2002:a05:6a20:7f8a:b0:220:eef:e8f0 with SMTP id
 adf61e73a8af0-22026e479cdmr12810485637.23.1750550253516; 
 Sat, 21 Jun 2025 16:57:33 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b31f12584cbsm4551790a12.55.2025.06.21.16.57.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:57:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 085/101] target/arm: Implement CNTP (predicate as counter)
 for SME2/SVE2p1
Date: Sat, 21 Jun 2025 16:50:21 -0700
Message-ID: <20250621235037.74091-86-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
 target/arm/tcg/helper-sve.h    |  1 +
 target/arm/tcg/sve_helper.c    | 59 ++++++++++++++++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 30 +++++++++++++++++
 target/arm/tcg/sve.decode      |  3 +-
 4 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/helper-sve.h b/target/arm/tcg/helper-sve.h
index 906da384dc..733828a880 100644
--- a/target/arm/tcg/helper-sve.h
+++ b/target/arm/tcg/helper-sve.h
@@ -937,6 +937,7 @@ DEF_HELPER_FLAGS_4(sve_brkn, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
 DEF_HELPER_FLAGS_4(sve_brkns, TCG_CALL_NO_RWG, i32, ptr, ptr, ptr, i32)
 
 DEF_HELPER_FLAGS_3(sve_cntp, TCG_CALL_NO_RWG, i64, ptr, ptr, i32)
+DEF_HELPER_FLAGS_2(sve2p1_cntp_c, TCG_CALL_NO_RWG_SE, i64, i32, i32)
 
 DEF_HELPER_FLAGS_3(sve_whilel, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
 DEF_HELPER_FLAGS_3(sve_whileg, TCG_CALL_NO_RWG, i32, ptr, i32, i32)
diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index ac38d62f04..7d6f5fbb58 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4184,6 +4184,65 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
+uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
+{
+    int pl = FIELD_EX32(desc, PREDDESC, OPRSZ);
+    int vl = pl * 8;
+    unsigned v_esz = FIELD_EX32(desc, PREDDESC, ESZ);
+    int lg2_width = FIELD_EX32(desc, PREDDESC, DATA) + 1;
+    unsigned p_esz;
+    int p_count, maxelem;
+    bool p_invert;
+
+    /* C.f. Arm pseudocode CounterToPredicate. */
+    if ((png & 0xf) == 0) {
+        /* Canonical false predicate. */
+        return 0;
+    }
+    p_esz = ctz32(png);
+
+    /*
+     * maxbit = log2(pl * 4)
+     *        = log2(vl / 8 * 4)
+     *        = log2(vl / 2)
+     *        = log2(vl) - 1
+     * maxbit_mask = ones<maxbit:0>
+     *             = (1 << (maxbit + 1)) - 1
+     *             = (1 << (log2(vl) - 1 + 1)) - 1
+     *             = (1 << log2(vl)) - 1
+     *             = pow2ceil(vl) - 1
+     * Note that we keep count in bytes, not elements.
+     */
+    p_count = (png & (pow2ceil(vl) - 1)) >> 1;
+    p_invert = (png >> 15) & 1;
+
+    /*
+     * If the esz encoded into the predicate is not larger than the
+     * vector operation esz, then the expanded predicate bit will
+     * be true for all vector elements.  If the predicate esz is
+     * larger than the vector esz, then only even multiples can be
+     * true, and the rest will be false.
+     */
+    v_esz = MAX(v_esz, p_esz);
+    maxelem = (vl << lg2_width) >> v_esz;
+
+    if (p_count == 0) {
+        if (p_invert) {
+            /* Canonical true predicate: invert count zero. */
+            return maxelem;
+        }
+        /* Non-canonical false predicate. */
+        return 0;
+    }
+    if (p_invert) {
+        p_count = DIV_ROUND_UP(p_count, 1 << v_esz);
+        p_count = maxelem - p_count;
+        return MAX(0, p_count);
+    }
+    p_count >>= v_esz;
+    return MIN(p_count, maxelem);
+}
+
 /* C.f. Arm pseudocode EncodePredCount */
 static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
                                   uint32_t esz, bool invert)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index f3ac0f6300..62ace5d300 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3035,6 +3035,36 @@ static bool trans_CNTP(DisasContext *s, arg_CNTP *a)
     return true;
 }
 
+static bool trans_CNTP_c(DisasContext *s, arg_CNTP_c *a)
+{
+    TCGv_i32 t_png;
+    uint32_t desc = 0;
+
+    if (dc_isar_feature(aa64_sve2p1, s)) {
+        if (!sve_access_check(s)) {
+            return true;
+        }
+    } else if (dc_isar_feature(aa64_sme2, s)) {
+        if (!sme_sm_enabled_check(s)) {
+            return true;
+        }
+    } else {
+        return false;
+    }
+
+    t_png = tcg_temp_new_i32();
+    tcg_gen_ld16u_i32(t_png, tcg_env,
+                      pred_full_reg_offset(s, a->rn) ^
+                      (HOST_BIG_ENDIAN ? 6 : 0));
+
+    desc = FIELD_DP32(desc, PREDDESC, OPRSZ, pred_full_reg_size(s));
+    desc = FIELD_DP32(desc, PREDDESC, ESZ, a->esz);
+    desc = FIELD_DP32(desc, PREDDESC, DATA, a->vl);
+
+    gen_helper_sve2p1_cntp_c(cpu_reg(s, a->rd), t_png, tcg_constant_i32(desc));
+    return true;
+}
+
 static bool trans_INCDECP_r(DisasContext *s, arg_incdec_pred *a)
 {
     if (!dc_isar_feature(aa64_sve, s)) {
diff --git a/target/arm/tcg/sve.decode b/target/arm/tcg/sve.decode
index 0eb4fd9667..f3db790460 100644
--- a/target/arm/tcg/sve.decode
+++ b/target/arm/tcg/sve.decode
@@ -784,7 +784,8 @@ BRKN            00100101 0. 01100001 .... 0 .... 0 ....         @pd_pg_pn_s
 ### SVE Predicate Count Group
 
 # SVE predicate count
-CNTP            00100101 .. 100 000 10 .... 0 .... .....        @rd_pg4_pn
+CNTP            00100101 ..    100 000 10 ....     0 .... ..... @rd_pg4_pn
+CNTP_c          00100101 esz:2 100 000 10 000 vl:1 1 rn:4 rd:5
 
 # SVE inc/dec register by predicate count
 INCDECP_r       00100101 .. 10110 d:1 10001 00 .... .....     @incdec_pred u=1
-- 
2.43.0


