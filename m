Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35389C88E56
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:40:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a7y-0000Ju-P6; Sat, 12 Sep 2026 22:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7V-0008QD-0x
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:05 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7O-0000zz-Vh
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:02 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccc09d65so968238a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267136; x=1789871936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CGkv0c1Uf/8ln+4Wm7XG63afCWqfyTE9LG36Dynvf+A=;
 b=r+tehH+urZJpK3hHqiIEe1lE8G/W4gfvP1AZrNQAV9XbVXuHVp7xV+mDCBCmmD4/sM
 ULpPm/VLYiDaf7MTYfAqgyygLq38hy0Va/j9GuaE27ite5xmdWK0JKJaSHXSG2jatdsu
 F9VmXzhKPqEu/FMItlnjCqOLr5Zo1H0POeCU3Ls2RGXZMibrmT/PCcwbpEb8Pi+0kla6
 xc/lyDjAsKSNsqsnV/qO64ICiUfwZbcnZYl4+i1Ez1xJFgTu/ca68HCT/E2zDY+pNdwP
 2lhMPhkG4twrgLM9rCTfL0BUf6r5TDy2k3pwOu3tZsVEpG/aKvRDWIeWzDB/qc9+MK63
 mfBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267136; x=1789871936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CGkv0c1Uf/8ln+4Wm7XG63afCWqfyTE9LG36Dynvf+A=;
 b=cb2zAoiA4nQMs7JNNs8m03jYHeMoIvTYyR2VOCE+Xz0SNt1Xpz8k1bXlvAIY4+1RYp
 9eQSn5w2lExO87liY5hiKb0OtTbXHO06HSfP7fmpYJ7yxkzeo2q/qN9LjDM20taPM72N
 KYqYdRgt39A8q+3DX0JlLQaH9Pj89Zl7NotwKKV75bC4UgtEAfismMx3j97zH5chE8kg
 oRciWYp42RmIQY3M1xiunipqE29Wt11vtINXnar0eprmSUmiYjOAMeK84KmKXOE4cOvs
 GApVkbb0u+qaf1FGDFiqrnMzHDOGaxHcrbTY5Qmu+dXfaXLwAjgmnZt2avtU0MaesWQs
 aP6g==
X-Gm-Message-State: AFuF++koPtU+0RABM5SYysQv2oDUw7e6WpM7KJY4cG91G5txzpzwtL9e
 rniBm/StPpTplMFWuIh/uxfu3WGf0PmbapMWwoaz/2RXDWhpGIBcuLfhiPAlsgc22TsDQ1kF3P7
 XShkpELo=
X-Gm-Gg: AYBFou1J47kqG9vvSByhZQC0B6V+7pu9jOD1xpdVU1SQt9DLLASqbtfEpH9BYhiuco7
 5nvgHZ4NueXQpkPo1vOt8uIQbXlNivLVcGS4eIw9SciGHU+G9phwSAAS2DYqSOTMeyCTg5IFdtr
 PXZ+DXDTyQg4bS+9ifdrVZswVWbNsYdqwDZOV5jUtzXsh5sL/qnmiw51gp4CSmdxg33EewGjAke
 oTS3gzylj3bg8G9iLj1Nx4X2NNcUoemP9Apm62RiQTj4ibSoV/UzCuXUIRa8QjnNblOxUNNlwWw
 DKyWFiifKQdfbbVjBtXp9n4uPdR9D3qXnntPq08NXKV1KYUFr7pKKP/PkxzT+RJQbtwYK6P6+kz
 zpa5Jqzhwxk/c7Xt1k1ylZ9M3H0HP+MmmAryGOOAcWowtkG2S76M1iEDNpHRAc5tEBM7DUwNYH4
 Kg+a0OnSYJ30chrmUAXwrklBowHq24IpZ2TEOKAdUyT3+/ayLqxupAiZ+OxJqpC1eF7blogkvRK
 TH5lqY=
X-Received: by 2002:a17:90b:3844:b0:398:e969:87ef with SMTP id
 98e67ed59e1d1-39d9c3f8c2dmr19400411a91.24.1789267136277; 
 Sat, 12 Sep 2026 19:38:56 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.38.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:38:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/86] tcg: Generic expansion of tcg_gen_xor_*
Date: Sat, 12 Sep 2026 16:37:25 -1000
Message-ID: <20260913023837.741866-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260913023837.741866-1-richard.henderson@linaro.org>
References: <20260913023837.741866-1-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 15 +++++----------
 3 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 1159bfa5233..765a7ba013e 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -210,7 +210,6 @@ void tcg_gen_st8_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st16_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shl_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_shr_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_sar_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -315,7 +314,6 @@ void tcg_gen_ld32u_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld32s_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_ld_i64(TCGv_i64 ret, TCGv_ptr arg2, tcg_target_long offset);
 void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset);
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_shr_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_sar_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 513505e35fa..47d3e6f6990 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -11,3 +11,4 @@ DEF3(or, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
 DEF3(subfi, TCGV, TINT, TCGV)
+DEF3(xor, TCGV, TCGV, TCGV)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 34b3f9ba96b..1c9943cb082 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -462,6 +462,11 @@ static void gen_subfi(TCGType type, TCGTemp *dst, int64_t src1, TCGTemp *src2)
     }
 }
 
+static void gen_xor(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    gen_op_ttt(INDEX_op_xor, type, dst, src1, src2);
+}
+
 /* 32 bit ops */
 
 void tcg_gen_andi_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
@@ -506,11 +511,6 @@ void tcg_gen_ori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
     }
 }
 
-void tcg_gen_xor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    tcg_gen_op3_i32(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_xori_i32(TCGv_i32 ret, TCGv_i32 arg1, int32_t arg2)
 {
     /* Some cases can be optimized here.  */
@@ -1527,11 +1527,6 @@ void tcg_gen_st_i64(TCGv_i64 arg1, TCGv_ptr arg2, tcg_target_long offset)
     tcg_gen_ldst_op_i64(INDEX_op_st, arg1, arg2, offset);
 }
 
-void tcg_gen_xor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    tcg_gen_op3_i64(INDEX_op_xor, ret, arg1, arg2);
-}
-
 void tcg_gen_shl_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     tcg_gen_op3_i64(INDEX_op_shl, ret, arg1, arg2);
-- 
2.53.0


