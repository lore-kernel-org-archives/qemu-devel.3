Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22684C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:00:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R4k-0003R0-0W; Fri, 25 Apr 2025 17:59:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4N-0001u5-4g
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:51 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4J-0000rT-IU
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:50 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-af523f4511fso2679817a12.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618326; x=1746223126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G5B1NhT1NLtzeEyaxgj+29nZj33fOhCnOrtRj5aXTv4=;
 b=ZDbDYlAlFwplhTy7+DvQHx9L5DRY+/W3jorU9cxZluys51W/cF7W7ALKO7MrTwb0Y7
 cU+f/6W0IoXvbxM9WEGje4Wz26QDE7Pg4v35PNDBqFOHcXlAOLrzEPanxVXByOXfcjnd
 N50FjkyUb5A2eJBu7uo9svKg1xuFcb1RNK+NiiJzceF9R3zqboMfzuONKktcjgOqKupZ
 gMS7mDdR5yD4HKusjwPIYUijOCfTy/KdEuvMn3hoIBM0ytGjVYx3hrilSKYY6ykVNZSV
 WSd6JBEBItWbBenH0ENtN8We9zbxKcpSbKuXKgyT/JZG/hYlTUq8lH2CRDonIDqrG2hL
 H3uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618326; x=1746223126;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5B1NhT1NLtzeEyaxgj+29nZj33fOhCnOrtRj5aXTv4=;
 b=nd1dVG6Dl+aEx2tmU4lAizEMn6/Ut/0m2fCifyTatdmEoqx6cNQfSzoONeEHys4vhB
 xwzQyMH1CSDXbMevOBaztJXslfD0xMZnThrE4chfcFaFhO0bUbQZ32/CkbLPnHTEldyX
 kQ+zdKfUnAM6yteFEz0448okBltmBz4HuuAXRAjwZayQQuI0n7Xk/vKK9Tpsrmgsk/79
 iaOogSK9spRw2XPi6AQT0qYdf7DXXDyS6mnCDn/N2xGYDijR7NR0lCGPqiBC+SomGbfj
 CIRw2+svcv01rTUTVIpanZafm5F3ieEit4dApbEWcII5/n3k2dFe+rAupRIYHNJgAo3B
 rBzw==
X-Gm-Message-State: AOJu0YyeUPjuMZThXsME2hvf9dX3xn+FG/lFWJsQXFgzbGR06pADuKtr
 uT6FvoUoecKbTjp6tSp4Fd4lzOSdO4kE+fOK9i9rTYkElL0ydCh2VVQeS28vL9s1M2evPScdXL6
 J
X-Gm-Gg: ASbGncvjKLaHJrr6+jb9t0zRi/cbm7LfdmVeKR1YcBCQWrmSdTHhxlN65VaUnyzFGHI
 kequ9JIoHxssC7Az03LsOmHB7K11ninKM2BYMZw6FkjPloJjQzbqR+OXwJfEuowWis5bJIVcPN8
 ZBbzZH9CpNSobuefWCC6ped5OqyYUvw12Q5CG9UsnFw5MTheDBI9oYn/tRIC9eLGEYFIzVPoeB2
 ovWCy1y6LzI4OX5D29hUrs5SCikBAFo6MJ/5mKp7UR5qJGrB4I6r54zZF5YoVJtMKvVD2VSWw7Q
 qtWCEaVviTrGM78jOA08AIUKX0yakHzyIDiKJa9f4NNMm5bjK0jLyGqaEjJGRmvywtMVTdepwCR
 H8pqyQJLOlw==
X-Google-Smtp-Source: AGHT+IEjD/VBWaWif2Md0/b/qC9G/+0kJkMP+J6EjckgkObBEYIwAD2yYOX4T5Cj8EIShuyNkxdpww==
X-Received: by 2002:a17:90b:52c7:b0:2ff:693a:7590 with SMTP id
 98e67ed59e1d1-309f7ec20famr6589085a91.33.1745618325872; 
 Fri, 25 Apr 2025 14:58:45 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 065/159] tcg: Merge INDEX_op_rot{l,r}_{i32,i64}
Date: Fri, 25 Apr 2025 14:53:19 -0700
Message-ID: <20250425215454.886111-66-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h    |  6 ++---
 tcg/optimize.c           | 20 ++++++++---------
 tcg/tcg-op.c             | 48 ++++++++++++++++++++--------------------
 tcg/tcg.c                | 12 ++++------
 tcg/tci.c                |  8 +++----
 docs/devel/tcg-ops.rst   |  8 +++----
 tcg/tci/tcg-target.c.inc |  4 ++--
 7 files changed, 50 insertions(+), 56 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index cb8c134e94..25fd93eb28 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -58,6 +58,8 @@ DEF(or, 1, 2, 0, TCG_OPF_INT)
 DEF(orc, 1, 2, 0, TCG_OPF_INT)
 DEF(rems, 1, 2, 0, TCG_OPF_INT)
 DEF(remu, 1, 2, 0, TCG_OPF_INT)
+DEF(rotl, 1, 2, 0, TCG_OPF_INT)
+DEF(rotr, 1, 2, 0, TCG_OPF_INT)
 DEF(sar, 1, 2, 0, TCG_OPF_INT)
 DEF(shl, 1, 2, 0, TCG_OPF_INT)
 DEF(shr, 1, 2, 0, TCG_OPF_INT)
@@ -77,8 +79,6 @@ DEF(st8_i32, 0, 2, 1, 0)
 DEF(st16_i32, 0, 2, 1, 0)
 DEF(st_i32, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(rotl_i32, 1, 2, 0, 0)
-DEF(rotr_i32, 1, 2, 0, 0)
 DEF(deposit_i32, 1, 2, 2, 0)
 DEF(extract_i32, 1, 1, 2, 0)
 DEF(sextract_i32, 1, 1, 2, 0)
@@ -115,8 +115,6 @@ DEF(st16_i64, 0, 2, 1, 0)
 DEF(st32_i64, 0, 2, 1, 0)
 DEF(st_i64, 0, 2, 1, 0)
 /* shifts/rotates */
-DEF(rotl_i64, 1, 2, 0, 0)
-DEF(rotr_i64, 1, 2, 0, 0)
 DEF(deposit_i64, 1, 2, 2, 0)
 DEF(extract_i64, 1, 1, 2, 0)
 DEF(sextract_i64, 1, 1, 2, 0)
diff --git a/tcg/optimize.c b/tcg/optimize.c
index f94be19b72..97a566a617 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -464,16 +464,16 @@ static uint64_t do_constant_folding_2(TCGOpcode op, TCGType type,
         }
         return (int64_t)x >> (y & 63);
 
-    case INDEX_op_rotr_i32:
-        return ror32(x, y & 31);
-
-    case INDEX_op_rotr_i64:
+    case INDEX_op_rotr:
+        if (type == TCG_TYPE_I32) {
+            return ror32(x, y & 31);
+        }
         return ror64(x, y & 63);
 
-    case INDEX_op_rotl_i32:
-        return rol32(x, y & 31);
-
-    case INDEX_op_rotl_i64:
+    case INDEX_op_rotl:
+        if (type == TCG_TYPE_I32) {
+            return rol32(x, y & 31);
+        }
         return rol64(x, y & 63);
 
     case INDEX_op_not:
@@ -3025,8 +3025,8 @@ void tcg_optimize(TCGContext *s)
         case INDEX_op_remu:
             done = fold_remainder(&ctx, op);
             break;
-        CASE_OP_32_64(rotl):
-        CASE_OP_32_64(rotr):
+        case INDEX_op_rotl:
+        case INDEX_op_rotr:
         case INDEX_op_sar:
         case INDEX_op_shl:
         case INDEX_op_shr:
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8c8b9d179b..1989d8d12c 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -829,12 +829,12 @@ void tcg_gen_ctpop_i32(TCGv_i32 ret, TCGv_i32 arg1)
 
 void tcg_gen_rotl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
+    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
         tcg_temp_free_i32(t0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -854,12 +854,12 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i32(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_constant_i32(arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_constant_i32(32 - arg2);
-        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, t0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         TCGv_i32 t1 = tcg_temp_ebb_new_i32();
@@ -873,12 +873,12 @@ void tcg_gen_rotli_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 
 void tcg_gen_rotr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    if (tcg_op_supported(INDEX_op_rotr_i32, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_rotr_i32, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl_i32, TCG_TYPE_I32, 0)) {
+    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I32, 0)) {
+        tcg_gen_op3_i32(INDEX_op_rotr, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I32, 0)) {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
         tcg_gen_neg_i32(t0, arg2);
-        tcg_gen_op3_i32(INDEX_op_rotl_i32, ret, arg1, t0);
+        tcg_gen_op3_i32(INDEX_op_rotl, ret, arg1, t0);
         tcg_temp_free_i32(t0);
     } else {
         TCGv_i32 t0 = tcg_temp_ebb_new_i32();
@@ -2441,12 +2441,12 @@ void tcg_gen_ctpop_i64(TCGv_i64 ret, TCGv_i64 arg1)
 
 void tcg_gen_rotl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
         tcg_temp_free_i64(t0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -2466,12 +2466,12 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
     /* some cases can be optimized here */
     if (arg2 == 0) {
         tcg_gen_mov_i64(ret, arg1);
-    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_constant_i64(arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
-    } else if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
+    } else if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_constant_i64(64 - arg2);
-        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, t0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         TCGv_i64 t1 = tcg_temp_ebb_new_i64();
@@ -2485,12 +2485,12 @@ void tcg_gen_rotli_i64(TCGv_i64 ret, TCGv_i64 arg1, int64_t arg2)
 
 void tcg_gen_rotr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
-    if (tcg_op_supported(INDEX_op_rotr_i64, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_rotr_i64, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_rotl_i64, TCG_TYPE_I64, 0)) {
+    if (tcg_op_supported(INDEX_op_rotr, TCG_TYPE_I64, 0)) {
+        tcg_gen_op3_i64(INDEX_op_rotr, ret, arg1, arg2);
+    } else if (tcg_op_supported(INDEX_op_rotl, TCG_TYPE_I64, 0)) {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
         tcg_gen_neg_i64(t0, arg2);
-        tcg_gen_op3_i64(INDEX_op_rotl_i64, ret, arg1, t0);
+        tcg_gen_op3_i64(INDEX_op_rotl, ret, arg1, t0);
         tcg_temp_free_i64(t0);
     } else {
         TCGv_i64 t0 = tcg_temp_ebb_new_i64();
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 40a3e44b7c..182f19e5f0 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -1042,10 +1042,8 @@ static const TCGOutOp * const all_outop[NB_OPS] = {
     OUTOP(INDEX_op_orc, TCGOutOpBinary, outop_orc),
     OUTOP(INDEX_op_rems, TCGOutOpBinary, outop_rems),
     OUTOP(INDEX_op_remu, TCGOutOpBinary, outop_remu),
-    OUTOP(INDEX_op_rotl_i32, TCGOutOpBinary, outop_rotl),
-    OUTOP(INDEX_op_rotl_i64, TCGOutOpBinary, outop_rotl),
-    OUTOP(INDEX_op_rotr_i32, TCGOutOpBinary, outop_rotr),
-    OUTOP(INDEX_op_rotr_i64, TCGOutOpBinary, outop_rotr),
+    OUTOP(INDEX_op_rotl, TCGOutOpBinary, outop_rotl),
+    OUTOP(INDEX_op_rotr, TCGOutOpBinary, outop_rotr),
     OUTOP(INDEX_op_sar, TCGOutOpBinary, outop_sar),
     OUTOP(INDEX_op_shl, TCGOutOpBinary, outop_shl),
     OUTOP(INDEX_op_shr, TCGOutOpBinary, outop_shr),
@@ -5418,10 +5416,8 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
-    case INDEX_op_rotl_i32:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i32:
-    case INDEX_op_rotr_i64:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
     case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
diff --git a/tcg/tci.c b/tcg/tci.c
index 0fb13ff61d..b1ee14e65f 100644
--- a/tcg/tci.c
+++ b/tcg/tci.c
@@ -786,11 +786,11 @@ uintptr_t QEMU_DISABLE_CFI tcg_qemu_tb_exec(CPUArchState *env,
 
             /* Shift/rotate operations (64 bit). */
 
-        case INDEX_op_rotl_i64:
+        case INDEX_op_rotl:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = rol64(regs[r1], regs[r2] & 63);
             break;
-        case INDEX_op_rotr_i64:
+        case INDEX_op_rotr:
             tci_args_rrr(insn, &r0, &r1, &r2);
             regs[r0] = ror64(regs[r1], regs[r2] & 63);
             break;
@@ -1066,13 +1066,13 @@ int print_insn_tci(bfd_vma addr, disassemble_info *info)
     case INDEX_op_orc:
     case INDEX_op_rems:
     case INDEX_op_remu:
+    case INDEX_op_rotl:
+    case INDEX_op_rotr:
     case INDEX_op_sar:
     case INDEX_op_shl:
     case INDEX_op_shr:
     case INDEX_op_sub:
     case INDEX_op_xor:
-    case INDEX_op_rotl_i64:
-    case INDEX_op_rotr_i64:
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
     case INDEX_op_ctz_i32:
diff --git a/docs/devel/tcg-ops.rst b/docs/devel/tcg-ops.rst
index be82fed41a..c3a6499d01 100644
--- a/docs/devel/tcg-ops.rst
+++ b/docs/devel/tcg-ops.rst
@@ -394,15 +394,15 @@ Shifts/Rotates
      - | *t0* = *t1* >> *t2* (signed)
        | Unspecified behavior for negative or out-of-range shifts.
 
-   * - rotl_i32/i64 *t0*, *t1*, *t2*
+   * - rotl *t0*, *t1*, *t2*
 
      - | Rotation of *t2* bits to the left
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
-   * - rotr_i32/i64 *t0*, *t1*, *t2*
+   * - rotr *t0*, *t1*, *t2*
 
      - | Rotation of *t2* bits to the right.
-       | Unspecified behavior if *t2* < 0 or *t2* >= 32 (resp 64)
+       | Unspecified behavior for negative or out-of-range shifts.
 
 
 Misc
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 0a2da3ba47..0d15547c9f 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -773,7 +773,7 @@ static void tgen_rotl(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_rotl32
-                     : INDEX_op_rotl_i64);
+                     : INDEX_op_rotl);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
@@ -787,7 +787,7 @@ static void tgen_rotr(TCGContext *s, TCGType type,
 {
     TCGOpcode opc = (type == TCG_TYPE_I32
                      ? INDEX_op_tci_rotr32
-                     : INDEX_op_rotr_i64);
+                     : INDEX_op_rotr);
     tcg_out_op_rrr(s, opc, a0, a1, a2);
 }
 
-- 
2.43.0


