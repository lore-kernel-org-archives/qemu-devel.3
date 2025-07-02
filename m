Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D71BFC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwpE-0003vX-JX; Wed, 02 Jul 2025 08:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwk7-0004re-L0
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:19 -0400
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjk-0002Gj-N9
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:14 -0400
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2f766a60df9so30349fac.0
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459930; x=1752064730; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o5X0BjU/lJUYVmPVR5P6poFbAHJMz7lZaZPAzH3PdJs=;
 b=x4C/Ka0rxtSEbmWmC2IZ7IijW2xKQtW6H04E62DyzpsasYrnA42c8vdVJEPzDwTge+
 VaYQa14TYjqfxwlX8Z9zwoFCWKiBrZPwdoFwWHsnTT/IKUrQz3lDBpAabploT8/eEawW
 oW9ZsVIaoHJ9zgR6JnEftlCtknFxVd2MmMfQwrIe3ww6mL5VySDJfSxZTpEiNvQS26wy
 jWme3LcbTLqa7savgAWpczZ5S/Ht1W/k0dVJSw6+NPPs2EMfCeuSLj9BdlrjLpHdwEiG
 Y1GlBB4am6sZFWMXnxR3bmxNeBwpyjT3X2mqpMMqBCF7lLOWHvHwLjX3qCv1QE806K2R
 rI7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459930; x=1752064730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5X0BjU/lJUYVmPVR5P6poFbAHJMz7lZaZPAzH3PdJs=;
 b=BPPyc4m8kN+n4GR5+rXju/FApiHD6vfmmS6DUby4VrYOKTmoGKj33Dd3ONWRZh6cqH
 qG/KfNdR5qpCWLsUklcwS2vjVQiatgpXAjKL28F83T0SWtNUS6hmOK5W067haE700onr
 R/eSQIJusbuVbah0+0u0XNmDu7aK/qzEkhGooObAgwzG/zgJM9WJhb6SMa60x9lTawtl
 uGyNqh7B/zbkeIx2lnNIkx6316pi/joMsGB9eZFU2G2gO64ccrD0YIUfQ6FI1HQlmN5i
 yaAWiVnD/bUid6RBEmIZsTcjQScxXsQ2RjguV9t14hElygj1LyXIgObNrzE+Z8ZMQ/08
 Eu8A==
X-Gm-Message-State: AOJu0YyjkRxn5uAU39wv/EWM6ZorHP/Kumf/M1szGWDNzB5vOi7bkTCb
 AeElZ2eSAQG2SdMCERvLSND6/YKTQuv+7NGMQltT1bimQy5wELj75uGQnw9KgeCh6tq7+eRgT28
 N+gN4hHk=
X-Gm-Gg: ASbGnct3iLvR3nAI5o75gA21DAfLkCU+zXFhT1kosu5Lt3HKU+/A/y0FZvoZpqM6jpy
 9cI5WQv/uIVgYw+oDnMhym5w2C2NGraKZB9tFRSkKJ5i9N71d1hl/sHkvfaKi81vQZVwD/lRIqJ
 KDzvZilPPtUGZINi9veZUJ0lzZ0v/UF0jXX5p4ybMR+KUb0aSXMTP/5v9jP0AHW4YKH/JBoAVoh
 yzIfdWm7ZbJZOHbUtGL+Uw0Eb/NEK0B6vKSZSyDTegwM8CpEGjtwbbtFohS4vWM2BLyU0lEcuPD
 6tS7L04q1fAXxDF5J2szwwu2ei85Rbnw8tUBGQ86FZWdxPmUFGEtpjbTofN6/55NvOl/vA==
X-Google-Smtp-Source: AGHT+IGtijAc3fZ8hPdpFSeu5gZN+bEHnxZ4TuvSKwy1xOjyzBEVO0moA2eRKElTCjTQuk1S0o7NWg==
X-Received: by 2002:a05:6870:55d0:b0:2b7:f8d9:d5f7 with SMTP id
 586e51a60fabf-2f5c7abc9admr1954699fac.19.1751459930283; 
 Wed, 02 Jul 2025 05:38:50 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 76/97] target/arm: Implement CNTP (predicate as counter)
 for SME2/SVE2p1
Date: Wed,  2 Jul 2025 06:33:49 -0600
Message-ID: <20250702123410.761208-77-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/helper-sve.h    |  1 +
 target/arm/tcg/sve_helper.c    | 21 +++++++++++++++++++++
 target/arm/tcg/translate-sve.c | 30 ++++++++++++++++++++++++++++++
 target/arm/tcg/sve.decode      |  3 ++-
 4 files changed, 54 insertions(+), 1 deletion(-)

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
index 11139e6405..c41143468a 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4184,6 +4184,27 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
+uint64_t HELPER(sve2p1_cntp_c)(uint32_t png, uint32_t desc)
+{
+    int pl = FIELD_EX32(desc, PREDDESC, OPRSZ);
+    int vl = pl * 8;
+    unsigned v_esz = FIELD_EX32(desc, PREDDESC, ESZ);
+    int lg2_width = FIELD_EX32(desc, PREDDESC, DATA) + 1;
+    DecodeCounter p = decode_counter(png, vl, v_esz);
+    unsigned maxelem = (vl << lg2_width) >> v_esz;
+    unsigned count = p.count;
+
+    if (p.invert) {
+        if (count >= maxelem) {
+            return 0;
+        }
+        count = maxelem - count;
+    } else {
+        count = MIN(count, maxelem);
+    }
+    return count / p.stride;
+}
+
 /* C.f. Arm pseudocode EncodePredCount */
 static uint64_t encode_pred_count(uint32_t elements, uint32_t count,
                                   uint32_t esz, bool invert)
diff --git a/target/arm/tcg/translate-sve.c b/target/arm/tcg/translate-sve.c
index 079d310960..53db8851bf 100644
--- a/target/arm/tcg/translate-sve.c
+++ b/target/arm/tcg/translate-sve.c
@@ -3052,6 +3052,36 @@ static bool trans_CNTP(DisasContext *s, arg_CNTP *a)
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
index 0df3312739..db16849731 100644
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


