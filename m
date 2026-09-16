Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713B0C88E77
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:15:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pQm-0006zN-28; Wed, 16 Sep 2026 09:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQi-0006dH-DH
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:04 -0400
Received: from mail-oa2-x10.google.com ([2607:f8b0:4864:30::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pQf-0001zl-RY
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:12:04 -0400
Received: by mail-oa2-x10.google.com with SMTP id
 586e51a60fabf-47be948a50fso756201fac.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564320; x=1790169120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=4O7ugbydKPGgWxIoFojK4yQHnX/2/nzAqZYKej5Hl6Q=;
 b=OPJUepxELfaq+avaWMM2XLHJhkgc74kL8j7NJf1fjdrQLnaq0oQpBGRidK3dlafOCE
 rKD1fmffOtByIJiAGgSLhC7lLYarqu1nfHFhQ/9BWpx+UdabhP3p/aZQCqVVCe016zuR
 Yxg0qSrePO5at9bbB665BKXrsmxVCTDKpgV6EozuyUZudAQ0sJ6ntHfk/MMsQcwzzWYY
 SDdRlEgPV9BPHxn6PKqDWx/OAdKFP+dnPzaOwPu6KLhOFwgsk+CyqwYAWau6cqZQqbuA
 oh/kXOZF+3C/fv2S8nyH7+zkqVrFc8Mk2ioN+VdizkeEo1uczyf0uWU9pUrxlbR89P0C
 kSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564320; x=1790169120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=4O7ugbydKPGgWxIoFojK4yQHnX/2/nzAqZYKej5Hl6Q=;
 b=wF5Gc8eD05ga87xdHG03RoTa4PNZdpvqu2NDEHHu33xG8uIukMnK6jHDuTuQ7lg+Jv
 BWXXNdIn35kmcSrtSndmFgi5ZRSW8jggy4a6SdSVNS8FIElKIVlAfzlRQBtnut3pKDQY
 iOrt0MQE/8WvIDmfjBqqDskbmjSkDMPFJ4izcLgUBwSO3gN5yU0dcOs/EUdt4LhmwFxA
 uSzflkXaAbnFv3GLGWRRkNoe0oeB+DqyhZWXOadqLbWz858X85H3LoDmdOMsJX2sKE4j
 p51JvBn3Bo7k8F09If035M2ePvUBuJa0mGek5tskunfR7m2fyFvVa3QFM0pvd+Bi/cqZ
 3QUA==
X-Gm-Message-State: AFuF++kY5cPOViX1flxcHYa9NFNAnQy2YZfaz6rVA1i71vY5zXON1eTu
 C3wqls/IUD6Xu4WmNot/cVEJjheHJW1WNP2mfeDzwxWlMNVtpubcpX96PMUKayvoV4/IfjxAm9n
 2amk3r98=
X-Gm-Gg: AYBFou0J2u25wwi1P5RCxfKq/ao5sePoOy8hWIL3rNUvf7xNbYaUB8pV5Fq8Xd5anA/
 zBCcdb+GsYcMHoswh3LlrVhaMMUwOHw4dBvMP7YEI1hrYQ4gQ36Iajzt8/vCTrZpZzLAA/iimlV
 Owj95S3jv2YQh/rldPNwpGsPvdhiAUXnOgfOotwLkrS0ikg7yrEqo5FBjiUBAO9fgh+BfGwfgCB
 8rtexrDOxHdpQ6X6HeHS7iwKrPgLeb+7zUSIDPsc+6YUzTbgkW0AKjN0uOSBp2y024xkiYu5s29
 mGBuVabAsJvvJaQs7Eoiq5FNFkrtE7xUyQY8uGioHKNdq15FHd6HhUfMHpTUbaKUFIG6Vd8OznW
 Qychn3vnC+mACRVwav8OmWk7YnXr2arjwrnXtJ4QjLveY2Pq4ovIOxXgxZKANx0lZZjTzgR8M/K
 dV28FR1LDgA0qkgMq7BKqnLZk+5vORTHAeuHK0HP/hjFGcYnP5ejMXIRZJPACUIfkSt4+js5f28
 7ac0v8qkWCXAHnSug==
X-Received: by 2002:a4a:e848:0:b0:6b7:83c5:fde3 with SMTP id
 006d021491bc7-6c7d3defbdcmr2908413eaf.36.1789564320159; 
 Wed, 16 Sep 2026 06:12:00 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5b22b74sm7873110eec.30.2026.09.16.06.11.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:11:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 84/92] tcg: Generic expansion of tcg_gen_muls2_*
Date: Wed, 16 Sep 2026 03:03:59 -1000
Message-ID: <20260916130409.3382710-85-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:30::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa2-x10.google.com
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
 tcg/tcg-op.c                 | 141 +++++++++++++++--------------------
 3 files changed, 61 insertions(+), 83 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 3ad966b72c1..b0ce35df411 100644
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
index 75ada0d0473..5e169258ea3 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -34,6 +34,7 @@ DEF2(movi, TCGV, TINT)
 DEF6(movcond, TCGCond, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(mul, TCGV, TCGV, TCGV)
 DEF3(muli, TCGV, TCGV, TINT)
+DEF4(muls2, TCGV, TCGV, TCGV, TCGV)
 DEF4(mulu2, TCGV, TCGV, TCGV, TCGV)
 DEF3(nand, TCGV, TCGV, TCGV)
 DEF2(neg, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index dbdb3bfbe20..27fd7469545 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -183,13 +183,6 @@ static void DNI tcg_gen_op2_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2)
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
@@ -223,20 +216,6 @@ static void DNI tcg_gen_ldst_op_i64(TCGOpcode opc, TCGv_i64 val,
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
@@ -906,6 +885,66 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_muls2(TCGType type, TCGTemp *rl, TCGTemp *rh,
+                      TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_muls2, type, 0)) {
+        gen_op_tttt(INDEX_op_muls2, type, rl, rh, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_mulsh, TCG_TYPE_I32, 0)) {
+        TCGTemp *t = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_mul(type, t, src1, src2);
+        gen_op_ttt(INDEX_op_mulsh, type, rh, src1, src2);
+        gen_mov(type, rl, t);
+
+        tcg_temp_free_internal(t);
+    } else if (type == TCG_TYPE_I32) {
+        TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        /* Simply extend and use host 64-bit multiply. */
+        gen_ext_i32_i64(t0, src1);
+        gen_ext_i32_i64(t1, src2);
+        gen_mul(TCG_TYPE_I64, t0, t0, t1);
+        gen_extrl_i64_i32(rl, t0);
+        gen_extrh_i64_i32(rh, t0);
+
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+    } else if (tcg_op_supported(INDEX_op_mulu2, TCG_TYPE_I64, 0) ||
+               tcg_op_supported(INDEX_op_muluh, TCG_TYPE_I64, 0)) {
+        TCGTemp *t0 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t1 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t2 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+        TCGTemp *t3 = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_mulu2(TCG_TYPE_I64, t0, t1, src1, src2);
+
+        /* Adjust for negative inputs.  */
+        gen_sari(TCG_TYPE_I64, t2, src1, 63);
+        gen_sari(TCG_TYPE_I64, t3, src2, 63);
+        gen_and(TCG_TYPE_I64, t2, t2, src2);
+        gen_and(TCG_TYPE_I64, t3, t3, src1);
+        gen_sub(TCG_TYPE_I64, rh, t1, t2);
+        gen_sub(TCG_TYPE_I64, rh, rh, t3);
+        gen_mov(TCG_TYPE_I64, rl, t0);
+
+        tcg_temp_free_internal(t0);
+        tcg_temp_free_internal(t1);
+        tcg_temp_free_internal(t2);
+        tcg_temp_free_internal(t3);
+    } else {
+        TCGTemp *t = tcg_temp_new_internal(TCG_TYPE_I64, TEMP_EBB);
+
+        gen_mul(TCG_TYPE_I64, t, src1, src2);
+        gen_helper_mulsh_i64(temp_tcgv_i64(rh), temp_tcgv_i64(src1),
+                             temp_tcgv_i64(src2));
+        gen_mov(TCG_TYPE_I64, rl, t);
+
+        tcg_temp_free_internal(t);
+    }
+}
+
 static void gen_mulu2(TCGType type, TCGTemp *rl, TCGTemp *rh,
                       TCGTemp *src1, TCGTemp *src2)
 {
@@ -1356,28 +1395,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
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
@@ -1841,44 +1858,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
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


