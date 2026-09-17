Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C031AC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73qs-0003Sp-3m; Thu, 17 Sep 2026 00:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73qn-0003EK-LQ
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:57 -0400
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73ql-0007vE-Q8
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:35:57 -0400
Received: by mail-pz2-x10.google.com with SMTP id
 41be03b00d2f7-cc4c08393b0so335944a12.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619754; x=1790224554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=X37aO0DVHtGqRrYmr1sgHY4ieFdsWL1C1cOZVM0sRR8=;
 b=qnLz1+D/g8LaKKu3NkGImdsaNHe0RHWxd8HctaYFYHaQpoHNJoQo+EcbBWHpmd9RrJ
 S2HPygxqv8rA3UxT1WfsNlPfOa9bvNxbKAtJcAztPyrNzwJrHzK1yMQR20MH13TZqb8v
 gHHnuKgW4XR/xsG+EOjtWHJc2mtAIeRx8kBy0WJjT0VMEhwvaKpAlmIONShp8TM8g+m9
 dOKOCW3PUfgIrYXOyXKMX78rrcgWQlMgc5NJSOtekqzBWWWQ5cJ/1Q0X3IuiQ4RqTUAl
 jaI1bJeZfQGck1q7LuxoIzUK5rwLyaM4++8iWREmqTO4o+Nm/qmKoyqSEBS6H5VFJ+Vi
 quwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619754; x=1790224554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=X37aO0DVHtGqRrYmr1sgHY4ieFdsWL1C1cOZVM0sRR8=;
 b=gFlr4Gw+OcnVK1b7uxRG5EPhzp3kzqiIe/pIfE1gKfElHwTgFzHajBYsUeJqEJwCXz
 AqTmB1fJSKn7vpLqPXmMiZ/uIqEu24povSgE/gwRpSFEacxzqT029rEP8MLgR1jO+ZyN
 OATdEx9seGMnvTT2KYmxEepFNQfcV+0TDx2gAf8dS6OarprNrfmk1TxLXMncu7pRwtd8
 EpSRjQOPgw+14V1Sk6VByQF1CFjhMAJKXvjJbNCu9v4T8FMuZe+g89D9pwhCHfaPz3TA
 tHDW7N2cZFzWXeYQ/R9h/E7oCxxmhuO0Gg3vktOkAJERA+FBBgvbhlCtMJKX9GqHbo+C
 5CHQ==
X-Gm-Message-State: AFuF++m7wcMOInKyW7BpZyrUxlWckr2jZTd9EK2sf8ghh7+5Gx0HGl/A
 VXcbmlfaFhD1DcpDY7feEh0wbK1Wwr+hVWhjnf3p0JDVmuhiyQtZleM1jBV0XH8O2u4+F5v0PPn
 z+IxhPX8=
X-Gm-Gg: AYBFou0ZjcJUHUPxF1m40rXO8IqwrAFXcLF4QTAFwBVcwyXBMF0AE/vO91jdH6xUD42
 u+5zANyH2fiRdTt6ndnpydGUst0JJNoqzMY/8xSODESoGna7ggzwF7HIdzHjz+JRDVIePR9mX8W
 wmUM6jMH7AERvzo3cfR66ot5p49M63PHRgGSzEPyxlnrWSunU6Fy+yAygFa2T/Lb6qlNmYHMt4X
 QJHnM8Q/Qx+0L+wGjqpqtDK+JVnPEgMrK3eIjRXcsAMRX9abShMSnFrNS/yt77PfbhxV3bXc7RM
 VkcCSGDXss93PupZTnRSMwxOcKPBvt4BroHqcGK0HEF9jEy85WgBb5+FvQAsfuz9HjL/8MZJqrq
 tgpGu3SNcEflI4FwdC/P6pp6IgrCtHXr1AyW6RAZTwvwUMNDoysOWw4ucZsjju2NU4XO2adrPqn
 VN1aAaeRWipZ2bLyGr/Tr/ayc0Ynk6531PtXMYNMH7Os64NlY1x4ZmsgsjC1nZZlcyhOULFHeh7
 iFYJVOX
X-Received: by 2002:a17:90b:4b83:b0:398:9bd5:490b with SMTP id
 98e67ed59e1d1-39e1e4c4687mr12015690a91.18.1789619753990; 
 Wed, 16 Sep 2026 21:35:53 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d13ee7sm10764267c88.8.2026.09.16.21.35.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:35:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 083/101] tcg: Generic expansion of tcg_gen_add2_*
Date: Wed, 16 Sep 2026 18:28:05 -1000
Message-ID: <20260917042823.542588-84-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  4 ---
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 64 +++++++++++-------------------------
 3 files changed, 20 insertions(+), 49 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 60a0dfddf25..d6e185580c5 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -132,8 +132,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh);
 void tcg_gen_mulu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -160,8 +158,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_sub2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
                       TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh);
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 141c18061e8..f42aeb7d8f5 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -3,6 +3,7 @@
 DEF2(abs, TCGV, TCGV)
 DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
+DEF6(add2, TCGV, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF5(addcio, TCGV, TCGV, TCGV, TCGV, TCGV)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index c534acbdc74..aa8c3f4b0d2 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -430,6 +430,25 @@ static void gen_addi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_add2(TCGType type, TCGTemp *rl, TCGTemp *rh, TCGTemp *al,
+                     TCGTemp *ah, TCGTemp *bl, TCGTemp *bh)
+{
+    g_autoptr(TCGTemp) t0 = tcg_temp_new_ebb(type);
+
+    if (tcg_op_supported(INDEX_op_addci, type, 0)) {
+        gen_op_ttt(INDEX_op_addco, type, t0, al, bl);
+        gen_op_ttt(INDEX_op_addci, type, rh, ah, bh);
+    } else {
+        g_autoptr(TCGTemp) t1 = tcg_temp_new_ebb(type);
+
+        gen_add(type, t0, al, bl);
+        gen_setcond(type, TCG_COND_LTU, t1, t0, al);
+        gen_add(type, rh, ah, bh);
+        gen_add(type, rh, rh, t1);
+    }
+    gen_mov(type, rl, t0);
+}
+
 static void gen_addcio(TCGType type, TCGTemp *r, TCGTemp *co,
                        TCGTemp *a, TCGTemp *b, TCGTemp *ci)
 {
@@ -1251,28 +1270,6 @@ static void gen_xori(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
 
 /* 32 bit ops */
 
-void tcg_gen_add2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
-                      TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_op3_i32(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i32(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 t1 = tcg_temp_ebb_new_i32();
-        tcg_gen_add_i32(t0, al, bl);
-        tcg_gen_setcond_i32(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i32(rh, ah, bh);
-        tcg_gen_add_i32(rh, rh, t1);
-        tcg_gen_mov_i32(rl, t0);
-        tcg_temp_free_i32(t0);
-        tcg_temp_free_i32(t1);
-    }
-}
-
 void tcg_gen_sub2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 al,
                       TCGv_i32 ah, TCGv_i32 bl, TCGv_i32 bh)
 {
@@ -1760,29 +1757,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_add2_i64(TCGv_i64 rl, TCGv_i64 rh, TCGv_i64 al,
-                      TCGv_i64 ah, TCGv_i64 bl, TCGv_i64 bh)
-{
-    if (tcg_op_supported(INDEX_op_addci, TCG_TYPE_REG, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-
-        tcg_gen_op3_i64(INDEX_op_addco, t0, al, bl);
-        tcg_gen_op3_i64(INDEX_op_addci, rh, ah, bh);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 t1 = tcg_temp_ebb_new_i64();
-        tcg_gen_add_i64(t0, al, bl);
-        tcg_gen_setcond_i64(TCG_COND_LTU, t1, t0, al);
-        tcg_gen_add_i64(rh, ah, bh);
-        tcg_gen_add_i64(rh, rh, t1);
-        tcg_gen_mov_i64(rl, t0);
-        tcg_temp_free_i64(t0);
-        tcg_temp_free_i64(t1);
-    }
-}
-
 void tcg_gen_addN_i64(int n, TCGv_i64 *r, TCGv_i64 *a, TCGv_i64 *b)
 {
     tcg_debug_assert(n > 2);
-- 
2.53.0


