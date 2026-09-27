Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CE0CC98324
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Sep 2026 09:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAks5-0005lk-4O; Sun, 27 Sep 2026 05:08:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrL-00027t-3E
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:49 -0400
Received: from mail-pj2-x0d.google.com ([2607:f8b0:4864:39::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xAkrJ-0008Fy-49
 for qemu-devel@nongnu.org; Sun, 27 Sep 2026 05:07:46 -0400
Received: by mail-pj2-x0d.google.com with SMTP id
 98e67ed59e1d1-3a0b6200eb0so1603289a91.2
 for <qemu-devel@nongnu.org>; Sun, 27 Sep 2026 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790500064; x=1791104864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jJviLshxn4QQ0NUyEr0bDDWphQikuBszs40RWdJ/xjM=;
 b=OVspBs3xgVN4mXrJeQUMW/Rur25g280G/ePRpDT4wfkn67F089Xh8sM+rUGm1Eu1Oi
 9ov2Yoj5LsDs60hpS3W+tUKvr7fUAXUo06CxrPYI02Qs7qXOgdeVQPozdJRJE5uOQnSV
 sEsl4i8g7uo+yQbvDdR7HcREE0mz1QtrUfpNsJ+6qQp2RwQ3DN/tLsfp18fqusT9sJr8
 lx0P2XC01Qt55b+stUYw6PcP1INx9TWkknE6hw0mf3jka+23jDYzV7sQfvf3O7BhVwr3
 CwU6czdPYreolLs7MUkfR0Dk4M4kpUjZVxdqLrIBUqbRqGpzxSfD8oC6Dv4lGr+1YKI0
 FraQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790500064; x=1791104864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jJviLshxn4QQ0NUyEr0bDDWphQikuBszs40RWdJ/xjM=;
 b=a+gRGI4jiqmbm60bd2q10xJHdXRp7EH2BkjweOvhqcB7Q96QK7fg+59giXELwqJfov
 lT0NgBpUpXx+T1OLIlD5AIuGg1fZVVe0980Jhy1YYsmS47vAObu+AddwJh5OfEByvSS+
 VjHsEPO5voJ5eC5iORHMRWGa5ewNiqsy7CoEBXv5lA49b9uIY4f1pvgpddiUWl9zJDMv
 ns2IedmO1Gr3DzvBURJxp4B+v4R7/pfHPEs75WWz0s1t+cGVYkbTi9ZuZbpUcSYromv9
 JePdVDofLGN0sM3CDdL4vgJGHUbEsKrhAN5HdrOaSKdv8S0oxyRIEs8kNBnkZcoSYuHq
 9cYQ==
X-Gm-Message-State: AFq9FYL4vCI4JElFIl/+IeIoXH/SUlrMDf1b1CpouLJf5TfADZDYsboO
 j6y2v7m2GCw/cc3uw7tCz0cEi8g44WIXFCOAmXY/Hx/HcvaSKhJxyjJjtYAakgmG/1+GHA/WmaY
 j+YSz
X-Gm-Gg: AYBFou1qKEHjkIvVpc/dfxjzBKTsunKQB7wUg/xPk4VMKaBsgOYHucHiw/iWWZbWO+p
 4Kfgv72tsMFXCsBl+qhvp6Ts7tSwmt2Nf4kMVs+J4djZvBOYZYWIdsqGTWcHHVubQOliElF9MAV
 ApyvCi3M0XtQtnc/1XQTrkLgPu6HvVklsImJM6CY2CiVjkcYGXoUVGJ43sgI8OZ+kew5kWX+5iF
 HcuaXeEaQV/evhszK6V4LyPNsotjrMF5BelJkc+Y2iS5EV1c4/bMHHGkBOQ2wuArOxvoZI3cQTu
 FXrK8Hk38I+BUTjeXB2IFxjJkPhAn915ruakK1zgAkxeBtynr5W9wrREMNH9EQIPiKh+RWqat1f
 AJYY3KEGj1ktTuj6UeQKm2+qQ8b0/IoYDDA3iwS3x4dK2SPWco3vJ7bcDuYjZiQJpscPlSaqpvB
 whhsQ+WKXEHZJYH7aWqKQcbMHmBPNJSHsDD4XFbSvVzN5OlzXRSPQdEvxNRCMRun4YW7bxzqf+s
 5/gjNn+6crCWlShYIqGqQMbhBGialUNmPChFpep
X-Received: by 2002:a17:90b:3c8b:b0:39d:f064:3a68 with SMTP id
 98e67ed59e1d1-3a0bb57874fmr5580902a91.21.1790500063383; 
 Sun, 27 Sep 2026 02:07:43 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0e7036e3bsm7144984a91.13.2026.09.27.02.07.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 02:07:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mattst88@gmail.com
Subject: [PATCH v5 083/101] tcg: Generic expansion of tcg_gen_muls2_*
Date: Sun, 27 Sep 2026 01:59:53 -0700
Message-ID: <20260927090011.10724-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927090011.10724-1-richard.henderson@linaro.org>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x0d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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
 include/tcg/tcg-op-common.h  |   2 -
 include/tcg/tcg-op-def.h.inc |   1 +
 tcg/tcg-op.c                 | 131 +++++++++++++----------------------
 3 files changed, 51 insertions(+), 83 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 41a4d52d497..5f73601ddf7 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,7 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
@@ -156,7 +155,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index b24122173a2..b606aaab128 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -35,6 +35,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(muls2, TCGV, TCGV, TCGV, TCGV)
 DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index f107e3a85ea..61d50294a68 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -129,13 +129,6 @@ static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
     tcg_gen_op2(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2));
 }
 
-static void DNI tcg_gen_op3_i32(TCGOpcode opc, TCGv_i32 a1,
-                                TCGv_i32 a2, TCGv_i32 a3)
-{
-    tcg_gen_op3(opc, TCG_TYPE_I32, tcgv_i32_arg(a1),
-                tcgv_i32_arg(a2), tcgv_i32_arg(a3));
-}
-
 static void DNI tcg_gen_op3_i64(TCGOpcode opc, TCGv_i64 a1,
                                 TCGv_i64 a2, TCGv_i64 a3)
 {
@@ -169,20 +162,6 @@ static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
                 tcgv_ptr_arg(base), offset);
 }
 
-static void DNI tcg_gen_op4_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                TCGv_i32 a3, TCGv_i32 a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I32, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4));
-}
-
-static void DNI tcg_gen_op4_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                TCGv_i64 a3, TCGv_i64 a4)
-{
-    tcg_gen_op4(opc, TCG_TYPE_I64, tcgv_i64_arg(a1), tcgv_i64_arg(a2),
-                tcgv_i64_arg(a3), tcgv_i64_arg(a4));
-}
-
 /* Generic ops.  */
 
 void gen_set_label(TCGLabel *l)
@@ -778,6 +757,56 @@ void tcg_gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+void tcg_gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                   TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_muls2, type, 0)) {
+        tcg_gen_op_tttt(INDEX_op_muls2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(type, t, src1, src2);
+        tcg_gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
+        tcg_gen_mov(type, rl, t);
+    } else if (type == TCG_TYPE_I32) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        /* Simply extend and use host 64-bit multiply. */
+        tcg_gen_exts(t0, src1);
+        tcg_gen_exts(t1, src2);
+        tcg_gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        tcg_gen_extrl(rl, t0);
+        tcg_gen_extrh(rh, t0);
+    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+        g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+        g_autoptr(TCGTemp) t2 = NULL;
+        g_autoptr(TCGTemp) t3 = NULL;
+
+        tcg_gen_mulu2(TCG_TYPE_I64, t0, t1, src1, src2);
+
+        /* Adjust for negative inputs.  */
+        t2 = tcg_temp_new_ebb(type);
+        t3 = tcg_temp_new_ebb(type);
+        tcg_gen_sari(TCG_TYPE_I64, t2, src1, 63);
+        tcg_gen_sari(TCG_TYPE_I64, t3, src2, 63);
+        tcg_gen_and(TCG_TYPE_I64, t2, t2, src2);
+        tcg_gen_and(TCG_TYPE_I64, t3, t3, src1);
+        tcg_gen_sub(TCG_TYPE_I64, rh, t1, t2);
+        tcg_gen_sub(TCG_TYPE_I64, rh, rh, t3);
+        tcg_gen_mov(TCG_TYPE_I64, rl, t0);
+    } else {
+        g_autoptr(TCGTemp) t = tcg_temp_new_ebb(type);
+
+        tcg_gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        tcg_gen_mov(TCG_TYPE_I64, rl, t);
+    }
+}
+
 void tcg_gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                    TCGTemp *src1, TCGTemp *src2)
 {
@@ -1217,28 +1246,6 @@ void tcg_gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I32, 0)) {
-        tcg_gen_op4_i32(INDEX_op_muls2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i32(INDEX_op_mulsh, rh, arg1, arg2);
-        tcg_gen_mov_i32(rl, t);
-        tcg_temp_free_i32(t);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_ext_i32_i64(t0, arg1);
-        tcg_gen_ext_i32_i64(t1, arg2);
-        tcg_gen_mul_i64(t0, t0, t1);
-        tcg_gen_extr_i64_i32(rl, rh, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
@@ -1702,44 +1709,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
     }
 }
 
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_muls2, TCG_TYPE_I64, 0)) {
-        tcg_gen_op4_i64(INDEX_op_muls2, rl, rh, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t = tcg_temp_ebb_new_i64();
-        tcg_gen_op3_i64(INDEX_op_mul, t, arg1, arg2);
-        tcg_gen_op3_i64(INDEX_op_mulsh, rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t);
-        tcg_temp_free_i64(t);
-    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
-               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t2 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t3 = tcg_temp_ebb_new_i64();
-        tcg_gen_mulu2_i64(t0, t1, arg1, arg2);
-        /* Adjust for negative inputs.  */
-        tcg_gen_sari_i64(t2, arg1, 63);
-        tcg_gen_sari_i64(t3, arg2, 63);
-        tcg_gen_and_i64(t2, t2, arg2);
-        tcg_gen_and_i64(t3, t3, arg1);
-        tcg_gen_sub_i64(rh, t1, t2);
-        tcg_gen_sub_i64(rh, rh, t3);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-        tcg_temp_free_i64(t2);
-        tcg_temp_free_i64(t3);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_mul_i64(t0, arg1, arg2);
-        gen_helper_mulsh_i64(rh, arg1, arg2);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-- 
2.53.0


