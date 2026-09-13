Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258A2C88E53
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Sep 2026 02:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5a8H-0001jY-D5; Sat, 12 Sep 2026 22:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7p-0008VY-DU
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:25 -0400
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5a7j-00015E-IO
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 22:39:23 -0400
Received: by mail-pj2-x10.google.com with SMTP id
 98e67ed59e1d1-396ccafb752so1044829a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789267157; x=1789871957; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=I2qS1YyYzgCfFKOBNCr+1JaKHJbMER1oOjl4ZZxBJHs=;
 b=fU/Vl2AYOv+GgsszStA2SWdW5KZ3duMoOXVYAsfEI91lzu4atlo5eaeQLPc7DSmY1i
 ASolrlvIzH7lSEBTgsknv0ceBFBMcu4tHuhPIMm7yui6PDS4HSVIAPEYsrzw8rZDGyY3
 OuvpOfFu6Q7wJckp6GU9qNth1pe6gT4nFbox35DlLHs+TPC4Nyh8SJbmLUqT13yY5k8P
 /6jp4swNpW6lf8V2UgATMttmEC+5W7wPYQ6EP3zX8GVzbVeVwLZi0fZlrffVK4xdRZzH
 Wfziwyy3ZGiI+TejWMVm5Lmj0kuGveDsWj9/WgMN+84p9R5oRftcj/GciJ9Yzt7kGmHs
 KHGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789267157; x=1789871957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=I2qS1YyYzgCfFKOBNCr+1JaKHJbMER1oOjl4ZZxBJHs=;
 b=Rvmk3Aj6tM87FQBj+mqo5JNtBsL/MP8FZrtAoWpVKsVJQstMBllrKTEr9Z5aBKDVn/
 JKtzZ4MfDKthcVVS3MulzVESCwsHxkTojY5Us4heXdPC4wC+Q8LbnAgKkFhfB/n+f8JC
 Wm5aRkHa7+0FOrRDpyfv0no02UUr/nrTWOlfbEKitFphuboxgDwYcUSnLFOzdqXGmJZQ
 B5I0kJg8tCmaTGYKMVmzuR9R1Sl3dKBnrWUT9R8YzI/61e2+PxKqBCepJNbQrluzW8t2
 2A18KalYzMQdZE0VOTjFMYUa/duOtEcf6iDxcZBmBMx1n8/npOH+48ymGvRs+xocVrKV
 FIxg==
X-Gm-Message-State: AFuF++njFZnYaL1kEIooBzqe/bRxHTQwoav53+cCAH4kYEp7zOfcECbf
 NpmTPhWC4vlF3EJNPh42sgrz5X+Hz2YgfYiUhTkvKqZrFHpbLSJ2hPx9VSmcUt18fZvYMYqS7yF
 YwoQX4cQ=
X-Gm-Gg: AYBFou2YJnjkrIAXJCmiMKgFptcNuIU15CTo6jhMlHxF+Tn/qsqIfDL3iMb9sJR2Fx5
 Agal24E2pTM9f/dGtWrTF8+CMxtnvYTJRcdt0YWbFMVJeU68XQr6vuTtgzuJGheUPTZ7g8jLpzA
 F7GYz1Qx3rl7n7bg1TqhYAfdj0nSyPJ3gLsz0lqj0ntUYA7+vhgnzOYKF2ZPuZMSrMBpqU8zR1F
 wWZ6wfkWcV19hvRIDe+PiKLRsJVCac45WTiQ2xoTs6JGv3Rw42c6cGMBbSNMNKi4i85UhxgQvtY
 MmrsrljrU4NYWTl3xQtFudVMxx9csTccRirtlcClrYV4qga5xZFjNspLP+4ACyJ8yqo+Kvk6ynq
 S5w7ee/9gmupQWcysVMXqUjNM0HgQRJ9YA659xyJ6xjxv6NJHiZZeKoI5NYddhtMs6GzRWI2VTI
 ZZCs8jtj5yk7ZmP1MguodVCPJu2U7EBSFVBRaoiz+RTGeMo6W0HjMzjC7VSunbrc14nMQfjZkSj
 uQp81jqE2yVbGHCqA==
X-Received: by 2002:a17:90b:580e:b0:396:40e6:f631 with SMTP id
 98e67ed59e1d1-39d9bbe47a7mr21378263a91.3.1789267156897; 
 Sat, 12 Sep 2026 19:39:16 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm16174535c88.10.2026.09.12.19.39.16
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 19:39:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 32/86] tcg: Generic expansion of tcg_gen_andc_*
Date: Sat, 12 Sep 2026 16:37:43 -1000
Message-ID: <20260913023837.741866-33-richard.henderson@linaro.org>
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
 tcg/tcg-op.c                 | 37 +++++++++++++-----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 4bcc8890af3..ebbdec6cab5 100644
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
index 89b62d1d526..361c9207b64 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -440,6 +440,19 @@ static void gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_andc(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_andc, type, 0)) {
+        gen_op_ttt(INDEX_op_andc, type, dst, src1, src2);
+    } else {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+
+        gen_not(type, tmp, src2);
+        gen_and(type, dst, src1, tmp);
+        tcg_temp_free_internal(tmp);
+    }
+}
+
 static void gen_discard(TCGType type, TCGTemp *src)
 {
     tcg_gen_op1(INDEX_op_discard, type, temp_arg(src));
@@ -717,18 +730,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1776,18 +1777,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


