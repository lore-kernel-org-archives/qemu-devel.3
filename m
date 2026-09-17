Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5494C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 04:31:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x73m5-0005T9-GD; Thu, 17 Sep 2026 00:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kD-0003F7-CE
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:10 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x73kB-0006ri-OD
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 00:29:09 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so328961a91.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 21:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789619346; x=1790224146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vQOwEqLDGgfElesYbWjWHMNbsHHjSy84xRakyQG+gX8=;
 b=wNbhebSfrlFMU4cwm17ASN+R7DtycFCAVoUohOpqLYSD3PUgntVwY0fAiEJe6SE0W3
 A/yBzuIImMlxWR/xckJkrbfU6HAkZ1JgJgSAuKBSzB/xBSaTWSUXPP4ib4tdlnTEX6q2
 ljsZD02nzhNhbA7VJuq7PtJwWtcUYuO0IYLK5hr8oefWhpBczKkr9aTA15SrfF/NtMRG
 sCqMnhm3xkanz7RdO4JSBtndqLrK3GGLf1CWPodY5bGvIi0TghLXVq65+cdI+7g1BnAf
 4+VAAAgG8zPmHd3akjQH0ZEsPtS+uuFUj9FsacdwqFFT+XK0I2s/bKcuC8bsZoJim7EF
 wAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789619346; x=1790224146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vQOwEqLDGgfElesYbWjWHMNbsHHjSy84xRakyQG+gX8=;
 b=jCsvnJciMmqeBm1tIQe7aGr3u6pJGdEGWOlE419fVqDdD8PF8JCIglZvckhF/uOu2R
 LeVNeObJ0c0yHO/lLnLPf9buEnotrGNwDga42dCVbJGpzOShTd16tFQokLW+Cvo97Wcm
 TAYbatwKaqAW1SsvV0ydBBe5T/7d+PTctrkPE1hU8gWc1+V6dtaXpRfCmUXfaatfXFV1
 c7mboqsgGnM+NahJrX7kv8hc0OQmGJ2Ad+iWLGHIA54Yt0WB0kjyE83WALLkiJkX4EnY
 08Ldy9zSvO9NB24qJcXciGVujJ+8HBzG1mfQVhJXoE5vKEHUmX6QdsHsRX8vEcFI/WZv
 tpcA==
X-Gm-Message-State: AFuF++lwQKOaag8VcblHY5lT56kTLYrArbLGuYaFZPvFu0PQnHIJ6BXZ
 RMdaEKvrbnl1hiVyOBFELNzyWjiTTu/bwNdC0gfYyINoJfAwth0Y7B6M+Tx6bnFEzpNNP4G06R3
 w4rWBZk4=
X-Gm-Gg: AYBFou2PqkQlxGHL2bFktb0DroMzGgNfnAXk/c8f8IrvviCe4aIBkuQBncbX3fRs47B
 0ZkZ0qZH/0zuQKVhzMDy1W/g330qIixdSDMzWbH2m67xdE3pVG+Dxx8O5zU84ao0Lp14+p3OptR
 E1QYL3Qtar+I0G4iRpALKR4Beh2YqaQl3nOPW1xLYf20pogCg8BRF/0HDBBtGuNdPtpI7Zg7Dv4
 B3mYj5/ztDq/9DXpJ7oBxRWO0c+gFuBhSJlAw/J9hZ7rHa8QPaWLcox8GR9B9LV+bb9NVSgcqJ5
 KlOzhz4PtLtlw4wTKsmv+4PxWDszd9JnKHgI7gmskfoPkHGA3IASlDD++dsvGgIVDtrbUOjnckd
 8vE+QBA5qUHcekE5E9bwejB3PKHoxazt2lUIXGhxHbL37USNu6ZrmaZ2q7xPARplY/Vl2L3Mn9g
 sqU+94UkzIvy4XOPshzNBDSZ2Nt1KciTr3b1Z15iRHiAPIKfvr5j7manyoODGK9kOwyyQtqL0tg
 Jl2PhM=
X-Received: by 2002:a17:90a:1c97:b0:39e:1fb6:9659 with SMTP id
 98e67ed59e1d1-39e1fb6994cmr7689976a91.22.1789619346328; 
 Wed, 16 Sep 2026 21:29:06 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:325f:1938:d075:8c13])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14395d771e5sm10458984c88.15.2026.09.16.21.29.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 21:29:05 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 038/101] tcg: Generic expansion of tcg_gen_andc_*
Date: Wed, 16 Sep 2026 18:27:20 -1000
Message-ID: <20260917042823.542588-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917042823.542588-1-richard.henderson@linaro.org>
References: <20260917042823.542588-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::10;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x10.google.com
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
 include/tcg/tcg-op-common.h  |  2 --
 include/tcg/tcg-op-def.h.inc |  1 +
 tcg/tcg-op.c                 | 36 ++++++++++++------------------------
 3 files changed, 13 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index f0572df01cf..7517e8d9d9e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -123,7 +123,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -201,7 +200,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index cffbb4d08a8..b05a1782513 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -4,6 +4,7 @@ DEF3(add, TCGV, TCGV, TCGV)
 DEF3(addi, TCGV, TCGV, TINT)
 DEF3(and, TCGV, TCGV, TCGV)
 DEF3(andi, TCGV, TCGV, TINT)
+DEF3(andc, TCGV, TCGV, TCGV)
 DEF1(discard, TCGV)
 DEF3(div, TCGV, TCGV, TCGV)
 DEF3(divu, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4b94bba91f0..262d2cbe2c1 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -440,6 +440,18 @@ static void gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_andc, type, 0)) {
+        gen_op_ttt(INDEX_op_andc, type, dst, src1, src2);
+    } else {
+        g_autoptr(TCGTemp) tmp = tcg_temp_new_ebb(type);
+
+        gen_not(type, tmp, src2);
+        gen_and(type, dst, src1, tmp);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -713,18 +725,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        tcg_gen_not_i32(t0, arg2);
-        tcg_gen_and_i32(ret, arg1, t0);
-        tcg_temp_free_i32(t0);
-    }
-}
-
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I32, 0)) {
@@ -1772,18 +1772,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
     }
 }
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_andc, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_andc, ret, arg1, arg2);
-    } else {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        tcg_gen_not_i64(t0, arg2);
-        tcg_gen_and_i64(ret, arg1, t0);
-        tcg_temp_free_i64(t0);
-    }
-}
-
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_eqv, TCG_TYPE_I64, 0)) {
-- 
2.53.0


