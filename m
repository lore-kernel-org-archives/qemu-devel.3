Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB22E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 18:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTPfU-0004FC-EM; Thu, 02 Jan 2025 13:11:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPeg-0007Qg-1x
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:47 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tTPed-0006Fa-3r
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 13:10:45 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21649a7bcdcso154755955ad.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 10:10:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735841442; x=1736446242; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qRTRGU6k78zuTqZxSVPRDcDDC4xOL8LEthPY2mCtCXw=;
 b=FMbJuThjEJiVWBDew0iW7EpNqua3ZqMqz/5BoiEsJNTkwwufXcjnJH7X1n55L1SJ4/
 yfEegLUmwPG3v943Rpr+KfbnjLYcehlZoya3YYKqO27EacXkgRHqHtLCh11Ayj56Hrvh
 yDtgX0dnlsJ4SbDuLcdeRJVuraFR14NZKYy8CNrjuVoDGvPUOSkZxPDoLrNQQlfo3T0P
 oR6TJOsRQ/T2X72Qv3YAgtw0NUY/FpQfOHQTQh2YqijbVCiY0BIFE1E/Huk/TVuGg8xz
 vfJWY/c0dMZjiNf/UUDqAbiys+Mra4M9+6FiQKv4Uqogpr76lXDEYAu6vLgSlsWrQZZv
 rXPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735841442; x=1736446242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRTRGU6k78zuTqZxSVPRDcDDC4xOL8LEthPY2mCtCXw=;
 b=Glt2S+gzM6rLWGKmdeL/YvwTJoIpHvIivm8zmZ5TCEUIbfk52UuBP6l4FjrpytMJvc
 Qlj7p5VUXgnG9MUjJ1tdvgHM9Pjc7Wz9iCghUbA41feVAVMdGiz2zT0KMy7jGJ2BVeus
 eOdt7uNr/JgZTJEni4eRoJ6Q7BCFxawwomhQveo4fw0brzTnPRBKKygu9vDJE3AIhs7+
 /Dsf8XRiXzUIHemhrBf2fgj0Yf9Ui2ni25RqizgOW9H2IALHzIw5jKrTQGmvF2XLoWzP
 XmuzZ0GJNjSebNfSoL3F2pAH012ycMxk1X9D/v+vgfwPUxjtzzOjRu+aVVc90i5dRKZ4
 ol6A==
X-Gm-Message-State: AOJu0YxqJZIRoUeKmBG3CgsaNmzpleSYSZcPOx5m/X921AJPelHArIFF
 BgpEqmAByYYge+JgY9xI1a7m9J2LKc6yhEXc0ri9p5jIxBsxg91NnMthhjSZhF2wG4/1rhy2U/q
 Z
X-Gm-Gg: ASbGncsNL5IK/MzhCbl9fahpLoL3c3KF9YKpvZ0EC88cWCcHJmhRWdw3aPf8YX+Y7Ej
 s9MAP3VkX+7BX/7e8tVLRkMxsd7ejii3Pnh8jEBcQWbcu51KbiB6nGNZiEvawd7mjg7tkDaslYw
 SvjhI4NrCMjkxLwfMi9g70Px4o5Ocqy9svpVfw7CfMEOVp4Uf8EUQWzMUe4jf98BvRHsSvD2hNa
 ZpLWlkyl/+unPPVBsdoK9k8OeQDg2pHA+x/gXgkL8LPa/yiL0oBxQaIXlvlvg==
X-Google-Smtp-Source: AGHT+IEj7/HYK+M1UGlu2Inq9/DzwAL6k/XDfVRbjN5cQYvkeJ34SdVb/CVmJ4agw83unaNaqUti4Q==
X-Received: by 2002:a05:6a21:e96:b0:1e0:f390:f300 with SMTP id
 adf61e73a8af0-1e5e082f951mr64459404637.44.1735841441816; 
 Thu, 02 Jan 2025 10:10:41 -0800 (PST)
Received: from stoup.. ([63.239.63.212]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8dbaf1sm24620827b3a.112.2025.01.02.10.10.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2025 10:10:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 60/73] tcg: Change have_vec to has_type in tcg_op_supported
Date: Thu,  2 Jan 2025 10:06:40 -0800
Message-ID: <20250102180654.1420056-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250102180654.1420056-1-richard.henderson@linaro.org>
References: <20250102180654.1420056-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

Test each vector type, not just lumping them all together.
Add tests for I32 (always true) and I64 (64-bit hosts).

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 66 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index c604785d39..3d641d6d00 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2136,8 +2136,28 @@ TCGTemp *tcgv_i32_temp(TCGv_i32 v)
  */
 bool tcg_op_supported(TCGOpcode op, TCGType type)
 {
-    const bool have_vec
-        = TCG_TARGET_HAS_v64 | TCG_TARGET_HAS_v128 | TCG_TARGET_HAS_v256;
+    bool has_type;
+
+    switch (type) {
+    case TCG_TYPE_I32:
+        has_type = true;
+        break;
+    case TCG_TYPE_I64:
+        has_type = TCG_TARGET_REG_BITS == 64;
+        break;
+    case TCG_TYPE_V64:
+        has_type = TCG_TARGET_HAS_v64;
+        break;
+    case TCG_TYPE_V128:
+        has_type = TCG_TARGET_HAS_v128;
+        break;
+    case TCG_TYPE_V256:
+        has_type = TCG_TARGET_HAS_v256;
+        break;
+    default:
+        has_type = false;
+        break;
+    }
 
     switch (op) {
     case INDEX_op_discard:
@@ -2327,60 +2347,60 @@ bool tcg_op_supported(TCGOpcode op, TCGType type)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_cmp_vec:
-        return have_vec;
+        return has_type;
     case INDEX_op_dup2_vec:
-        return have_vec && TCG_TARGET_REG_BITS == 32;
+        return has_type && TCG_TARGET_REG_BITS == 32;
     case INDEX_op_not_vec:
-        return have_vec && TCG_TARGET_HAS_not(type);
+        return has_type && TCG_TARGET_HAS_not(type);
     case INDEX_op_neg_vec:
-        return have_vec && TCG_TARGET_HAS_neg_vec;
+        return has_type && TCG_TARGET_HAS_neg_vec;
     case INDEX_op_abs_vec:
-        return have_vec && TCG_TARGET_HAS_abs_vec;
+        return has_type && TCG_TARGET_HAS_abs_vec;
     case INDEX_op_andc_vec:
-        return have_vec && TCG_TARGET_HAS_andc(type);
+        return has_type && TCG_TARGET_HAS_andc(type);
     case INDEX_op_orc_vec:
-        return have_vec && TCG_TARGET_HAS_orc(type);
+        return has_type && TCG_TARGET_HAS_orc(type);
     case INDEX_op_nand_vec:
-        return have_vec && TCG_TARGET_HAS_nand(type);
+        return has_type && TCG_TARGET_HAS_nand(type);
     case INDEX_op_nor_vec:
-        return have_vec && TCG_TARGET_HAS_nor(type);
+        return has_type && TCG_TARGET_HAS_nor(type);
     case INDEX_op_eqv_vec:
-        return have_vec && TCG_TARGET_HAS_eqv(type);
+        return has_type && TCG_TARGET_HAS_eqv(type);
     case INDEX_op_mul_vec:
-        return have_vec && TCG_TARGET_HAS_mul_vec;
+        return has_type && TCG_TARGET_HAS_mul_vec;
     case INDEX_op_shli_vec:
     case INDEX_op_shri_vec:
     case INDEX_op_sari_vec:
-        return have_vec && TCG_TARGET_HAS_shi_vec;
+        return has_type && TCG_TARGET_HAS_shi_vec;
     case INDEX_op_shls_vec:
     case INDEX_op_shrs_vec:
     case INDEX_op_sars_vec:
-        return have_vec && TCG_TARGET_HAS_shs_vec;
+        return has_type && TCG_TARGET_HAS_shs_vec;
     case INDEX_op_shlv_vec:
     case INDEX_op_shrv_vec:
     case INDEX_op_sarv_vec:
-        return have_vec && TCG_TARGET_HAS_shv_vec;
+        return has_type && TCG_TARGET_HAS_shv_vec;
     case INDEX_op_rotli_vec:
-        return have_vec && TCG_TARGET_HAS_roti_vec;
+        return has_type && TCG_TARGET_HAS_roti_vec;
     case INDEX_op_rotls_vec:
-        return have_vec && TCG_TARGET_HAS_rots_vec;
+        return has_type && TCG_TARGET_HAS_rots_vec;
     case INDEX_op_rotlv_vec:
     case INDEX_op_rotrv_vec:
-        return have_vec && TCG_TARGET_HAS_rotv_vec;
+        return has_type && TCG_TARGET_HAS_rotv_vec;
     case INDEX_op_ssadd_vec:
     case INDEX_op_usadd_vec:
     case INDEX_op_sssub_vec:
     case INDEX_op_ussub_vec:
-        return have_vec && TCG_TARGET_HAS_sat_vec;
+        return has_type && TCG_TARGET_HAS_sat_vec;
     case INDEX_op_smin_vec:
     case INDEX_op_umin_vec:
     case INDEX_op_smax_vec:
     case INDEX_op_umax_vec:
-        return have_vec && TCG_TARGET_HAS_minmax_vec;
+        return has_type && TCG_TARGET_HAS_minmax_vec;
     case INDEX_op_bitsel_vec:
-        return have_vec && TCG_TARGET_HAS_bitsel_vec;
+        return has_type && TCG_TARGET_HAS_bitsel_vec;
     case INDEX_op_cmpsel_vec:
-        return have_vec && TCG_TARGET_HAS_cmpsel_vec;
+        return has_type && TCG_TARGET_HAS_cmpsel_vec;
 
     default:
         tcg_debug_assert(op > INDEX_op_last_generic && op < NB_OPS);
-- 
2.43.0


