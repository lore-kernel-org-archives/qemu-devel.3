Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1F9C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr2N-0004NZ-5Q; Fri, 17 Jan 2025 13:25:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr29-0004AN-5H
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:29 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr27-0007uz-7w
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:25:28 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2166022c5caso43159885ad.2
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:25:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138325; x=1737743125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jrF/n7KBeARlzDdAnf5wLY/6SKHxmfqpW88RYm3jHsU=;
 b=v598refaZBk3OpcEhs9UPe0ukI3GALqplY/GVTyZxODh5gpmX9heaMFPeHKY/AQqGw
 NS0bhFMFgxfWi5AwoNs6ktwEEjA6aSy9e50vFqOi2WG84j6UvJPN9FPG5RH2XKjSdaQU
 bd3pnn0FUCUF9wAgvN5XEOs7GSn9rszN7Lw0EJxpg6N+zGddLSoFAwbbFCnd6BN3SK8h
 T2MqZvMf/t4D0YQLwz/RSMBqT64zvF/fj2tN/dvEEwU4d5fPpcG2Owe8Yn5C917XsFdQ
 Off9X1HOCAkoZUGH9I1CSAByJxVlss5rExeYws9NVf9+VJLduP6yv/w9XwYZyltCrTkH
 hH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138325; x=1737743125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jrF/n7KBeARlzDdAnf5wLY/6SKHxmfqpW88RYm3jHsU=;
 b=EwelbrX7pSeVBAwDXpWGdd+knOIPe4aiWZ08sgFpuv3ioeG4X5+80mAW5W3wpVh8S8
 B+zqWLSnWW802XyQ5m4OAfbd5XY1s2INXN8UUGRr+Y2GjkkQEkku+4i7xoDi6xwh1NAc
 ebN1PvXBUW4ik5lYVBsqvmfGEOuLk4JAW0ETabdJJxKXzuiS5dUXY1P4IGGxtkYsefdc
 MsHYtKt0RTjTG8m9/fw99uPTe54oZj0u2ICKhrSmhdwD5CAuiUNgBElleNI9RzUU2oiU
 ieOvk16PwZeRQTgKNQ4t30cr700Cw0VcQHLUx2dSmS3xmx/Ya/+a6iqWQHLlAVOBkFCP
 XGUA==
X-Gm-Message-State: AOJu0YwmSsq9T5bCndbDojXbgMqT6TntZWkaKLbi1D/D4kNC4xDcvNOy
 2ZBONI6dh/766FokHlTy/1dhR4aNaOcmuEgwSjqH46d9Qgh4ftyO5B0/TEZUdX1vP+eBGtBztEM
 g
X-Gm-Gg: ASbGncs1TqpEMl/jYfw6kVBqixMc0N9uUeyhb5CsS+Xt0NU0kmRnDskpo9YGtFdeGBN
 fABZy+S7VgmGPKySS9DAJ3MwvwCsT4JX5OfyS5Oe2zVNkHs7flZ8RsTErYsJjY6Ug5huaRsvOu+
 q5YF60enKZw1EsSjF6LmWWYQEaHBazzntf4Nhyp3dcbPO1XrPgBeGlZK1ohrYxx8o00+4Ops+gB
 Jufpj/Dodzk/TgsEVr2g0T8E9C29yY1mLa5kBvs/bzhPZRIPoskbo1KQUQD5FEf4U9dFSJ8uH5e
 WmpslNOkGpO9X9g=
X-Google-Smtp-Source: AGHT+IHDbc/fsnvclMkBgeMH3M10llw9nT8ErGEHcsWCW49eUzOcxFRRr9L1em2clAIEweUFNh+dQw==
X-Received: by 2002:a17:902:f105:b0:216:7c33:8994 with SMTP id
 d9443c01a7336-21c3561fef9mr40014485ad.53.1737138324705; 
 Fri, 17 Jan 2025 10:25:24 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3acccesm18879005ad.123.2025.01.17.10.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:25:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/68] tcg: Change have_vec to has_type in tcg_op_supported
Date: Fri, 17 Jan 2025 10:24:23 -0800
Message-ID: <20250117182456.2077110-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 66 ++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 23 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 05bb464940..915a181596 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -2136,8 +2136,28 @@ TCGTemp *tcgv_i32_temp(TCGv_i32 v)
  */
 bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
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
@@ -2376,60 +2396,60 @@ bool tcg_op_supported(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_or_vec:
     case INDEX_op_xor_vec:
     case INDEX_op_cmp_vec:
-        return have_vec;
+        return has_type;
     case INDEX_op_dup2_vec:
-        return have_vec && TCG_TARGET_REG_BITS == 32;
+        return has_type && TCG_TARGET_REG_BITS == 32;
     case INDEX_op_not_vec:
-        return have_vec && TCG_TARGET_HAS_not_vec;
+        return has_type && TCG_TARGET_HAS_not_vec;
     case INDEX_op_neg_vec:
-        return have_vec && TCG_TARGET_HAS_neg_vec;
+        return has_type && TCG_TARGET_HAS_neg_vec;
     case INDEX_op_abs_vec:
-        return have_vec && TCG_TARGET_HAS_abs_vec;
+        return has_type && TCG_TARGET_HAS_abs_vec;
     case INDEX_op_andc_vec:
-        return have_vec && TCG_TARGET_HAS_andc_vec;
+        return has_type && TCG_TARGET_HAS_andc_vec;
     case INDEX_op_orc_vec:
-        return have_vec && TCG_TARGET_HAS_orc_vec;
+        return has_type && TCG_TARGET_HAS_orc_vec;
     case INDEX_op_nand_vec:
-        return have_vec && TCG_TARGET_HAS_nand_vec;
+        return has_type && TCG_TARGET_HAS_nand_vec;
     case INDEX_op_nor_vec:
-        return have_vec && TCG_TARGET_HAS_nor_vec;
+        return has_type && TCG_TARGET_HAS_nor_vec;
     case INDEX_op_eqv_vec:
-        return have_vec && TCG_TARGET_HAS_eqv_vec;
+        return has_type && TCG_TARGET_HAS_eqv_vec;
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


