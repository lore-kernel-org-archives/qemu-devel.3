Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8983EC8302B
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 15:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWGRa-0000QM-4r; Mon, 30 Jun 2025 11:29:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRW-0000Ma-QI
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:14 -0400
Received: from mail-oo1-xc29.google.com ([2607:f8b0:4864:20::c29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWGRL-0008Bz-GR
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 11:29:10 -0400
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-60d63174f05so502202eaf.0
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751297339; x=1751902139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M12tAd32b4j4J9tYOUE2ZqQJWZcff/+m5slN6I8JAp0=;
 b=YwB6OnWYcUKAfzkG8LGPJZO5fOQHwGN8jTmOfspdXSKFX/huHFNdvSB4m3TC4FjrKg
 ZuMjrjTdz4V9nGa44mcrGN4QhXGWipxWRfqRE64vwrTa9cXrIM/la5VKA9V8nEs5KmTv
 NjxUVvm78pBkK4jV71TtLBJM6jriDNdGxz3jU3Zrl6ajr172HNgEC9icKNr8nXKTFXI/
 AY8Uptozj19ADFkJRy1N+RcIQkU5wNvSfl6oTIKjuYI6z60NrG+2rgRegtuhLWtinjVy
 8jtEgCNAdIAM/723m13fomgYJ/1OYk08SrHZ535HGa7Gfv6NgUTQYVoBEU/A21FGMx/Z
 ekfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751297339; x=1751902139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=M12tAd32b4j4J9tYOUE2ZqQJWZcff/+m5slN6I8JAp0=;
 b=kGDpEJXC6ioMP3poAICRxQUZasvXcf9ddyEAUe34OvGZyrBbKRlv1pDIc41nA6ntZQ
 mWijB6UX4Vjbb3VwHaLV3fDuQp6pKjY8h6mEJ+eLfulx7mT9OPdjEG9UazPQjlSf1V8r
 zxspRQGUzA98QLO2WCtWEWaBDRj5brS1Xyh0nJrWJCrUjweDyeVdwt2yTkZqJKHUpCjl
 O93eGGSgMmeUPplzcOe011HPjrUnh+tltJUNIgyu0XJBai81ryuLiesAVaxYjajK6CGo
 c1Lfdd2JLSvzyNZLm6TvqpV8TewK1z9ZnY48TmPUDvcLCi4pblDzGUqE22GXHinlyI2j
 +sGA==
X-Gm-Message-State: AOJu0YwYt9Xxbf+qUM2samBuy6lote4wWTZgHc/qgH47EPbQ5J5sTqpP
 xx4tvG0A/oz9dbPBncd7SXmUkvW0keZnOMw8c4k8G9aaLL3wufcKhjBfyhmNIiBVjgHrjUvtxRr
 8DE9h
X-Gm-Gg: ASbGncuxQRg/MJSEfYCXJQecuh2NtP1vpLCxs9XYNhy0MEuCl7xReIyRbnP6mpH7FcI
 SAz9f+1zN0CHJj3L/nKlXdSsxRaBMPWbvHkB6XNP63c6ilYW2w+44VuMs8iRpfDgE6uGFVf+BV1
 7ynwMHm1FDaUbMw5HGVpMIRaFAAumCPtV4FwupFA41Do4ZLp0Y/D65xoq2MBG/jOOeaxY5TRR0j
 cFh17J/YVzeepyJ8TlVBFIM0oFPKyrL7kKcjkURttLUI/ca2+5oQ3DVjTAw/umbMlzbpzJbI4jg
 +QCdzi1pHL/F5y2x91f4Nzpv5IzXF+yJxA+MuK9P9HxkqD5M1pIZcnYDVIAoeBgE/bnSxg==
X-Google-Smtp-Source: AGHT+IE6iN6wCvs6SA5USnRkYkzCZfiX+BYq54eNNT+0jbKtyOo478uuUe5TnX4ZYsZZMKNQCPScbQ==
X-Received: by 2002:a05:6871:451:b0:2c2:4e19:1cdf with SMTP id
 586e51a60fabf-2efed6bc3d9mr9577489fac.25.1751297339129; 
 Mon, 30 Jun 2025 08:28:59 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73afb00c48asm1712478a34.27.2025.06.30.08.28.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 08:28:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/29] tcg/optimize: Add one's mask to TempOptInfo
Date: Mon, 30 Jun 2025 09:28:28 -0600
Message-ID: <20250630152855.148018-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250630152855.148018-1-richard.henderson@linaro.org>
References: <20250630152855.148018-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c29;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc29.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 51 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 73a272eeb3..ce3cb4d7bc 100644
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
@@ -1052,11 +1059,16 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
      */
     if (ctx->type == TCG_TYPE_I32) {
         z_mask = (int32_t)z_mask;
+        o_mask = (int32_t)o_mask;
         s_mask |= INT32_MIN;
     }
 
-    if (z_mask == 0) {
-        return tcg_opt_gen_movi(ctx, op, op->args[0], 0);
+    /* Bits that are known 1 and bits that are known 0 must not overlap. */
+    tcg_debug_assert((o_mask & ~z_mask) == 0);
+
+    /* All bits that are not known zero are known one is a constant. */
+    if (z_mask == o_mask) {
+        return tcg_opt_gen_movi(ctx, op, op->args[0], o_mask);
     }
 
     ts = arg_temp(op->args[0]);
@@ -1068,20 +1080,27 @@ static bool fold_masks_zs(OptContext *ctx, TCGOp *op,
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


