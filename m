Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB05C5B559
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 08:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMMiQ-0000mo-4U; Tue, 03 Jun 2025 04:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiO-0000lP-5r
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:44 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uMMiL-0005T3-9P
 for qemu-devel@nongnu.org; Tue, 03 Jun 2025 04:09:43 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-450ce3a2dd5so46197155e9.3
 for <qemu-devel@nongnu.org>; Tue, 03 Jun 2025 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748938179; x=1749542979; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sTSTjcuH6N3aWQwpF6uVc7bfNUPVXbJSpmTvFWDJcJc=;
 b=KR+5eLF9+YoGkmNV+8AvJowxzVVPBov5xUbOlGyWFeH3ttPq4F5o4oeEcU9nyJnHGh
 QyutVW9glKeimE8x2/vlfiwnwEoMHzexO7+ipbiRgKBc+8aHUms+Srj7mYAB886g8JsD
 P+WhOBQxYTA/V8MVRiYS10quGmJk/9KZ6XHspuXGnxnnSQrDwnL47jlonvFb0sOu2Voj
 uEbNJ0MDmAWtg1J05uB7cLZ1U1TkCDRqWtyA5yJnMS3l3LrYhurXOyuIkRcpkgs5Fe5h
 wRVBUm3re60RoDFY//R3Nnbuu2S6aY6/hDTS56ZfJ5pjUvkjrGTxTb0cVvVkI02KXWEI
 w82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748938179; x=1749542979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sTSTjcuH6N3aWQwpF6uVc7bfNUPVXbJSpmTvFWDJcJc=;
 b=tz7eQahojn76bnYMG7TvFphu0us0rOTcSXmT89XQU6hW2tuFvd7M/PFgTARhQpiwFe
 phGU2WrwF1oh2V2lkdAjsVAcYPKm1owts0RaadHl1VK3y5gG19kKWyMHvQYPXe/WHqVZ
 U6vE/bGBxa1mVm37SBJnpUxk9HxOPdM188XlZXFSVyCw0zyGlisaIYNMXtrGxrihzKBN
 Ur4Em0LUhsPN4rCNjp6usy+LCJYFIf6jArWL6ogUddg0b+8wpTs2A3a5mhyL6QleeFXp
 iiOSqkfzMjxbbUzg//zgYFxlFIz4/0bLof3eM4Uvwl9CWxuPz/EghfLgSeMaxUU3vLkw
 bB3A==
X-Gm-Message-State: AOJu0Yx9mD447ZiWAaCwp6zgdWHHm5llgOoDGljfs8oSPzE3cLkEF38A
 2a8+z8KYZ8tHDwai7RDpMJk1bXevipAJojR2ab8LACPJNkIhM/8DeA0L/VI3FLpnbuw/STwPo/U
 90SFeIB8=
X-Gm-Gg: ASbGnctu7zeiOESR+tmquO2V2jKT9UpVRItR8wDJqeZoHXUAVrPCvb2f5SSY9o3b0Ze
 osgSPzKTP35LHPB2WKH/o3kcBLyHnJVmdz3k6OOFsLOZTn+Dv/0lxOHzSDOHTAPQl0ws9HUwvTp
 PVlkpTC72RFh0XdBjUW6z/L/PmFffeSr3wmGhpwRco9RkNysok/daVMChOUrALuQ5mXW1NgaNPR
 RL4d70Vk6F8/ulFLpjDuxIs5QwvEMuoSItto2J1EH9IK7lie4qaQxFk7e18KocFPjo3WAhaBq+Y
 uFwaqddtRpONtrwIamfCvucltmSQhKpGVMUHGe/TjNx4P1xIiDzQ23wViyStv083jaIs0JvdJac
 2nYOoxOEZBewMBzTtwmttzXI=
X-Google-Smtp-Source: AGHT+IGNBmqwLjgewQwWdWg5ukF0Ml1lCorvnGUapYl2zE/uqBwAIgS2QbxdrqKdDWGGDmqwd8iiHQ==
X-Received: by 2002:a05:600c:3510:b0:441:d438:505c with SMTP id
 5b1f17b1804b1-45126574c37mr81634935e9.32.1748938179473; 
 Tue, 03 Jun 2025 01:09:39 -0700 (PDT)
Received: from stoup.lan (host-80-41-64-133.as13285.net. [80.41.64.133])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4f009ff7asm17668852f8f.90.2025.06.03.01.09.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 01:09:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 02/27] tcg/optimize: Add one's mask to TempOptInfo
Date: Tue,  3 Jun 2025 09:08:43 +0100
Message-ID: <20250603080908.559594-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250603080908.559594-1-richard.henderson@linaro.org>
References: <20250603080908.559594-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x336.google.com
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


