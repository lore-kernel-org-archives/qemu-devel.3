Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CC7C79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L8K-0006ka-L9; Sat, 12 Sep 2026 06:38:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L8H-0006jn-Gv
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:38:54 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L8E-0000bP-4J
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:38:53 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-39647184c73so2529155a91.1
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209528; x=1789814328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HwAs2OR8nUvFBiGlkWRFxLOHkFlpIsSfaweC9OIlPtc=;
 b=zCxFLGfmjY7WTzaqKWqIY57aUXk94fhb5AZ3qaSUZTSGprld0gnxh5AbWlzd53SbdU
 dm8P9TCeOadOSqIk8uL9shECR0nfMmePqevvPWZ/CNyGbRyVR9PPMLvxSs1N6OImeEPq
 tB6qrQAku15qcvMUqfvM7qkm/dYhpjv/wunIfW6oWytCaXf+gv2SSt55hEvh7kv+AZK4
 HfIgpOR0dkQ0udNretfZE+1nkKnYgRsYcTHYwdY5oRQlxNeIHnVmoKBujKCsHt+FXqLS
 0Xxvjx+pYYxb+efkZxt8INjRzmzsUXSQCVjJJuhSYLldmqm3FsWOgPSLHPkqIZn3wsut
 i+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209528; x=1789814328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HwAs2OR8nUvFBiGlkWRFxLOHkFlpIsSfaweC9OIlPtc=;
 b=WVPidKqeAbSyDGxP3o9IXtHq2PKdV2fuVOggGn+E0wrUczjc0ZmYxC1LLeHif9vp7z
 oB7yWf+x7T5Rd0ebM0BeeXyLI8tVbl7Ysdv/bJduSFrQCam5qM78ZvdZEogf4CLL3Xzz
 wMfJexQKy1G1RTlOHiq6EPZfnUqFY9BJEMfjkpyde9LkI7K6KhDus9H0z90WEKXNMBXx
 yzQPhIT4LmYmdb9w6JP6QOr8/oWeH11ythTSypJmiLCF9qMX6OK4Y+ifs2RtzBoh8x90
 FImps68fj41U2xchsNbzTBhERe65Evy5NGzpBkM+UH2GFnHTzN5IzCX1FzVi8PS6Ab8C
 dCKg==
X-Gm-Message-State: AFuF++knEZvBugFGdBlifBt4DK7Bni0nDcpdfAlgZlyAdrZZKAdUClGy
 XKAw1GJB+laeZ6TQ5nDDG4uePRva66y90uWjFT4FeghpZUBLSdaPV5VAl2SeGTKpfQhvbhibqfY
 T01eWSiE=
X-Gm-Gg: AYBFou0/i4c/5LGoVkuNGj8k6Vcpdv4Y1dRY2MV2I9kEbrNDkZDlyq6qsFbbGTNQO/1
 4U0OOq+rv1l5uLWz+XShcyssBoy5j6IzbSFR73G6uEcFDCASpAwiUdEI1g2Mqk8YuywZ0bOq0+i
 yhxAi6rm8TPhB8jbJlXCmBw2CO+0YT8NrgsaEeopoWMe7j0eFJYTNCGLYdlevCutwmsRPtUjH+a
 Qd7o5dWlSgECFLeVfMlTsasGZU8d+ZAwT44Qdav5DAb5U/DnSR4cZlJI8OA79PvS+DX55wra9te
 DJ+mEUFns6WBri6akjAuGbglHU4RXDr5R0arkjYe9zUmEmThPXhuScvW4jlnwd6WXGO+U5OzPCy
 qCvCYsuO7kgeOikNG68EbXf5Q7Wv8RGCdUSporBw8x1RoP5wHP1pRlSSHmvAP88ayqY+loGF/wo
 MqDqrRIyZzmooKdqRpUFnt9amawIVfkIp3mZnqbwx3oLEfDeBOURdLRg0TL+JqS4ojS+1NWxfwO
 3pzmPc=
X-Received: by 2002:a17:90b:1d51:b0:39b:3b03:8a32 with SMTP id
 98e67ed59e1d1-39d77bf643bmr15718172a91.29.1789209528338; 
 Sat, 12 Sep 2026 03:38:48 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4e9b359sm12702231eec.14.2026.09.12.03.38.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:38:47 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 81/82] tcg: Generic expansion of tcg_gen_muls2_*
Date: Sat, 12 Sep 2026 00:31:25 -1000
Message-ID: <20260912103126.598030-82-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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
 include/tcg/tcg-op-common.h   |   2 -
 include/tcg/tcg-op-def2.h.inc |   1 +
 tcg/tcg-op.c                  | 141 +++++++++++++++-------------------
 3 files changed, 61 insertions(+), 83 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f8d65cc98ef..a46dac9abd5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -168,7 +168,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_muls2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ext_i32(TCGv_i32 ret, TCGv_i32 val, MemOp opc);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
@@ -193,7 +192,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 /* 64 bit ops */
 
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
-void tcg_gen_muls2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_mulsu2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ext32s_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_ext32u_i64(TCGv_i64 ret, TCGv_i64 arg);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 24a7f5592ed..48d9270f3d0 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -60,6 +60,7 @@ DEF_RRR(umax)
 DEF_RRR(umin)
 DEF_RRR(ussub)
 DEF_RRR(xor)
+DEF_RRRR(muls2)
 DEF_RRRR(mulu2)
 DEF_RRRRR(addcio)
 DEF_RRRRRR(add2)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index a12147367ac..829a400ff1b 100644
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
@@ -866,6 +845,66 @@ static void gen_muli(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
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
@@ -1437,28 +1476,6 @@ void tcg_gen_ext_i64(TCGv_i64 dst, TCGv_i64 src, MemOp mop)
 
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
@@ -1922,44 +1939,6 @@ void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
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


