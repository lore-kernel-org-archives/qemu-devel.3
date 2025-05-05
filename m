Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6AEC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 20:29:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC2Q4-0006kF-E7; Mon, 05 May 2025 16:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pw-0006iX-Rg
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:28:01 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC2Pt-0000N0-B6
 for qemu-devel@nongnu.org; Mon, 05 May 2025 16:27:59 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so4471786b3a.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 13:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746476875; x=1747081675; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gJLo1eS3K73iIv9rFRGELbydvBB92PuWm+E7Ujpbuuw=;
 b=Ra1+BvT6BXq2U+Xfr2cVbbZTMtqT9Askg0sTGRMr3WVZm3MTLgfQH66m7odFc3hWxi
 9fUTlRIP/QAMvBjhjATIqnhgXQ0dDvA9knynN9KVs7yKCn+B164Ucg0zJb7ITPPTparN
 Juy1YWY0d9DyL8D6ztyuwrplacPoZAbJx+s7F+J9z7qUh87xXzU8vozKsG84N8iHaCfN
 UE2Gc+tnK8EyU3WajUH2YiGZ/N60eWeapLs8+ml2JIbyEuWxgCUa6s2Mi0L1kjKSG3b4
 Fpqmo9iJFdrnqhc/Vth6N/K2cJUGATp/qyUohJV6N+My3jC4VeNSBxji3HkMXfUtoZm2
 t0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746476875; x=1747081675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gJLo1eS3K73iIv9rFRGELbydvBB92PuWm+E7Ujpbuuw=;
 b=jNgn190OkhaircykouGxvj74neMv3sSrSzDt5uCMqDBDOYCHQzkSESJhLG0ClQVW85
 8bQESkzOqOIQX0bEA7avYNP7OmCuNDNlCH9Kq53ZqiM7APyNwQDTw1njl31+ss34aOqY
 TE6m3ZOOweo1T1sSMnIsnfHyAgUgAvqsjQR0hFiq8+VCuQ8W4ccEeD9WI2ugGITYzhRM
 jCvShv8T/hz49qRpTlPOTQ6zLYuXvadfab49p5f4M2DqrOap7JhY4Zus79e2UvbwbhMt
 0X3pVoLNgGf7mn1xpFr9RVtrvMzqZRIQpiJySX2i7G46QL9es0lHUH9yBrBSEZ+UtJC+
 0Pdg==
X-Gm-Message-State: AOJu0YxOSvCTRW889p0hxo15i8zWbANu84ap0Kygu75JFoI04acLxG+T
 WH8TqYjoX6UwYQwOArp542opO2Z38FCgFIpZkjPGOrAvTAKQyGmkC7oL7GHmuutfJivOD49O+Os
 J
X-Gm-Gg: ASbGncuaGNNPFz9VzZdCXXW8/asK6FDeX3RxkWP65kKk+Qkn6yRMClZ3iA8UpEYKj49
 vApWFM5fqkIqarS6vI1jDQXZfNHHgdJvjOQ/KMIseqJc+xICvl4ebMVC95rWdw9J3iJZ68NMG2/
 zEGTGDbvyK/j6ZhTKfUjffSoTdqsZeu8IldgBPEl9sfI9b4TU4YQdvVzGV+kqWh8UwAXIRwnody
 NIV9Mh2XOk6UMCO+kEfca36jwaKSc0gqP4/VcCRtHIPMbOPfF0NdTqRCkDGinSPsc44cBaQmaCP
 AzJLu/mh8u2NAA1ZlcPO/gKPDIF6wc94zICfP+WBzi3urbayJX+/URchYdCXe+Iq3Qu8fcu+WN0
 =
X-Google-Smtp-Source: AGHT+IGhoH66mtZzPvBSLkj62gBWOJt+8cdQ6nh8BrHdhQ3tZD5hNDjbaUcmMKWuLRmGUOzDZEtb4g==
X-Received: by 2002:a05:6a00:3693:b0:730:9801:d3e2 with SMTP id
 d2e1a72fcca58-74091a23879mr834018b3a.8.1746476875367; 
 Mon, 05 May 2025 13:27:55 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm7516485b3a.107.2025.05.05.13.27.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 13:27:54 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/20] tcg/optimize: Add one's mask to TempOptInfo
Date: Mon,  5 May 2025 13:27:33 -0700
Message-ID: <20250505202751.3510517-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505202751.3510517-1-richard.henderson@linaro.org>
References: <20250505202751.3510517-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Add o_mask mirroring z_mask, but for 1's instead of 0's.
Drop is_const and val fields, which now logically overlap.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 51 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 73a272eeb3..395ad8232a 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -39,12 +39,11 @@ typedef struct MemCopyInfo {
 } MemCopyInfo;
 
 typedef struct TempOptInfo {
-    bool is_const_;
     TCGTemp *prev_copy;
     TCGTemp *next_copy;
     QSIMPLEQ_HEAD(, MemCopyInfo) mem_copy;
-    uint64_t val_;
     uint64_t z_mask;  /* mask bit is 0 if and only if value bit is 0 */
+    uint64_t o_mask;  /* mask bit is 1 if and only if value bit is 1 */
     uint64_t s_mask;  /* mask bit is 1 if value bit matches msb */
 } TempOptInfo;
 
@@ -73,12 +72,14 @@ static inline TempOptInfo *arg_info(TCGArg arg)
 
 static inline bool ti_is_const(TempOptInfo *ti)
 {
-    return ti->is_const_;
+    /* If all bits that are not known zeros are known ones, it's constant. */
+    return ti->z_mask == ti->o_mask;
 }
 
 static inline uint64_t ti_const_val(TempOptInfo *ti)
 {
-    return ti->val_;
+    /* If constant, both z_mask and o_mask contain the value. */
+    return ti->z_mask;
 }
 
 static inline bool ti_is_const_val(TempOptInfo *ti, uint64_t val)
@@ -142,13 +143,12 @@ static void init_ts_info(OptContext *ctx, TCGTemp *ts)
     ti->prev_copy = ts;
     QSIMPLEQ_INIT(&ti->mem_copy);
     if (ts->kind == TEMP_CONST) {
-        ti->is_const_ = true;
-        ti->val_ = ts->val;
         ti->z_mask = ts->val;
+        ti->o_mask = ts->val;
         ti->s_mask = INT64_MIN >> clrsb64(ts->val);
     } else {
-        ti->is_const_ = false;
         ti->z_mask = -1;
+        ti->o_mask = 0;
         ti->s_mask = 0;
     }
 }
@@ -234,8 +234,8 @@ static void reset_ts(OptContext *ctx, TCGTemp *ts)
     pi->next_copy = ti->next_copy;
     ti->next_copy = ts;
     ti->prev_copy = ts;
-    ti->is_const_ = false;
     ti->z_mask = -1;
+    ti->o_mask = 0;
     ti->s_mask = 0;
 
     if (!QSIMPLEQ_EMPTY(&ti->mem_copy)) {
@@ -390,6 +390,7 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
     op->args[1] = src;
 
     di->z_mask = si->z_mask;
+    di->o_mask = si->o_mask;
     di->s_mask = si->s_mask;
 
     if (src_ts->type == dst_ts->type) {
@@ -399,13 +400,19 @@ static bool tcg_opt_gen_mov(OptContext *ctx, TCGOp *op, TCGArg dst, TCGArg src)
         di->prev_copy = src_ts;
         ni->prev_copy = dst_ts;
         si->next_copy = dst_ts;
-        di->is_const_ = si->is_const_;
-        di->val_ = si->val_;
 
         if (!QSIMPLEQ_EMPTY(&si->mem_copy)
             && cmp_better_copy(src_ts, dst_ts) == dst_ts) {
             move_mem_copies(dst_ts, src_ts);
         }
+    } else if (dst_ts->type == TCG_TYPE_I32) {
+        di->z_mask = (int32_t)di->z_mask;
+        di->o_mask = (int32_t)di->o_mask;
+        di->s_mask |= INT32_MIN;
+    } else {
+        di->z_mask |= MAKE_64BIT_MASK(32, 32);
+        di->o_mask = (uint32_t)di->o_mask;
+        di->s_mask = INT64_MIN;
     }
     return true;
 }
@@ -1032,8 +1039,8 @@ static bool fold_const2_commutative(OptContext *ctx, TCGOp *op)
  * If z_mask allows, fold the output to constant zero.
  * The passed s_mask may be augmented by z_mask.
  */
-static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
-                          uint64_t z_mask, int64_t s_mask)
+static bool fold_masks_zos(OptContext *ctx, TCGOp *op, uint64_t z_mask,
+                           uint64_t o_mask, int64_t s_mask)
 {
     const TCGOpDef *def = &tcg_op_defs[op->opc];
     TCGTemp *ts;
@@ -1052,9 +1059,18 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
      */
     if (ctx->type == TCG_TYPE_I32) {
         z_mask = (int32_t)z_mask;
+        o_mask = (int32_t)o_mask;
         s_mask |= INT32_MIN;
     }
 
+    /* Bits that are known 1 and bits that are known 0 must not overlap. */
+    tcg_debug_assert((o_mask & ~z_mask) == 0);
+
+    /* All bits that are not known zero are known one is a constant. */
+    if (z_mask == o_mask) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], o_mask);
+    }
+    /* All bits known zero is zero. */
     if (z_mask == 0) {
         return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
     }
@@ -1068,20 +1084,27 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
     /* Canonicalize s_mask and incorporate data from z_mask. */
     rep = clz64(~s_mask);
     rep = MAX(rep, clz64(z_mask));
+    rep = MAX(rep, clz64(~o_mask));
     rep = MAX(rep - 1, 0);
     ti->s_mask = INT64_MIN >> rep;
 
     return true;
 }
 
+static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
+                          uint64_t z_mask, uint64_t s_mask)
+{
+    return fold_masks_zos(ctx, op, z_mask, 0, s_mask);
+}
+
 static bool fold_masks_z(OptContext *ctx, TCGOp *op, uint64_t z_mask)
 {
-    return fold_masks_zs(ctx, op, z_mask, 0);
+    return fold_masks_zos(ctx, op, z_mask, 0, 0);
 }
 
 static bool fold_masks_s(OptContext *ctx, TCGOp *op, uint64_t s_mask)
 {
-    return fold_masks_zs(ctx, op, -1, s_mask);
+    return fold_masks_zos(ctx, op, -1, 0, s_mask);
 }
 
 /*
-- 
2.43.0


