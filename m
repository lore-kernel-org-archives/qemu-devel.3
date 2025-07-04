Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E3FC83F09
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:54:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhUE-0002zt-By; Fri, 04 Jul 2025 10:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPG-0002WC-3T
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:52 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhPE-0001Sc-8r
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:28:49 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2edec6c5511so332932fac.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639326; x=1752244126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AxAxIZ6VFbRMgHTAjv0FjgNRbnxh2+Wy+VDRxyj4mIo=;
 b=mQidaMWvw2HT0j05e7FES9Y+lshRgPTRVofTEQzFgMTmTzm16IB3H4FYnP4NDNHyM3
 EXcDGL10hkCTM7oso98YG+OqMuM+FTqv6PD0GwwiUMoC+kPp1kLXW3N7LwDGWHnPuTo/
 kelv5YlSLEhcfbFHH0mxBtGGzZd4anMnJRI2D3lnbpZwNmFWrkfdpybKaIxiJcjZl7ID
 0WnQOav5jJOLetw9P9iE2O6hcIztyqi5aXsWbuC17QuH7rqbe4XrTvJxN63ZmICg1kQo
 9/Z1c3xr6K6lls66JklCtCmdJzToKVzY57fcjgFj898qTcS2/ow7k+xSn77CtP8m6OKr
 vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639326; x=1752244126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AxAxIZ6VFbRMgHTAjv0FjgNRbnxh2+Wy+VDRxyj4mIo=;
 b=Ftnq4MSHbsvcgzIrU9e8zyHt6ea6Ubtjz5ZJh8+R6SpAf4raIcE6Gm9+NuGzlQHk8a
 MP2Z+Iq+2BhIDV1Iw6rRd5OhN5+tUq87sQ9SaUbUPrOlfcnLUd7YSfU6RjN1gYBpeWUV
 HI1Muaa9tWjdPgD/r79XrG9ZxvqSF6NClW+kWQ4MAHdJveCWLNG3HaOEOsW2GQ250BUP
 XM7iu12JNQswMiuCgPT14QXPwqcKZIitlzKGIwI+hIRd2+AiL9nOwQekJrToPU8C/tzb
 n7b5KQrw4AEic71PswVD/bULoDv1ECUK5HbXO0E3Yd5yuGs+ZmtW35f6ULu9chV0OXnu
 FLbw==
X-Gm-Message-State: AOJu0Yxmfx7mnMekasq8LIVhKsIi9H5C8G/q8y/s6F+qqUqQWwndwHlm
 au703WwLQSNGqAwt69RI1sziWun9P3XWHDAOuo8Pb/B0r3CszzQW+vef0+RM7mAB5arGkc6qWJy
 yIokPzWU=
X-Gm-Gg: ASbGncv/HhNEue6y3OEph66fhYNd123jDjEE3o4BiomAww/Kqm5rUYOgmZumK3+kz7T
 86Odq+qJPhh0y6uVr6/0brABg7yDDziQaQ+7tS7oSFPEuYKEW957MupICJiNY2kbZEhQ6hwVUwn
 HvkeCTnNqNWu6KWZEo9SogYLRvLMf0H7gUmf1gTLPIFhmFh2hui8aknohMMV7vuVZix0hq4rYAd
 w6leA31xqRnfZe8rvJS9mq3vDSraRtB9+9ocn/XO0yjnLNhP8r8fNe2Z1qOvMqxdJN+XR55V/xU
 QCWY0nexQB5k20nfMDFGCvN/oZNqUlTgH3u4NrwDKI2HA8ymhR8lO/elkBqkpRV6V8SuaWRSVSa
 4oDB7MochqeMKARXTavx29vTxHjCdwNFVgh54kzrHdI87V9eA
X-Google-Smtp-Source: AGHT+IHYETCRhj3IAtPiSCFg93VqcCWphcNCwkL8dzYC7W/Hk3u1bldxpkJJLC/XB428sCLLNOXUrw==
X-Received: by 2002:a05:6871:69c4:b0:2d6:af0:8d8e with SMTP id
 586e51a60fabf-2f79696b293mr1780664fac.2.1751639326490; 
 Fri, 04 Jul 2025 07:28:46 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2f78ff55633sm531448fac.20.2025.07.04.07.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:28:46 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 087/108] target/arm: Implement CNTP (predicate as counter)
 for SME2/SVE2p1
Date: Fri,  4 Jul 2025 08:20:50 -0600
Message-ID: <20250704142112.1018902-88-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x35.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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
index 6512df54e6..def841fd52 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4178,6 +4178,27 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
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
+    return count >> p.lg2_stride;
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


