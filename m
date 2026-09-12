Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC9DC88E53
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:35:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L20-0005zz-Ah; Sat, 12 Sep 2026 06:32:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1e-00057Y-C6
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:02 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1c-0007MB-J9
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:02 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-396ccda24a3so457868a91.0
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209119; x=1789813919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Vy7AEaSvyUUu58wBVkFr8aNHn0nDowvZVe9u1r65rTw=;
 b=qZ9Hj4EoV0+GJTTiMTH//SjCTz+sZs2MK4ReIRxqwMF43SKQaQy+lipKFL6ubUKae9
 ydveftGMri0QkVQPtKNULPPCyaLd+Hk0iSDSOLLzol7CmDBh9KKodj6M55n6lBrfCxWq
 lZyKY8c1LaenJvNEmfAWVOGqLFwZFn1G/MAmIJEFuIZlfrH2gI5MniJvGFVTXU66uPu4
 cv8TOpfKLMGSH5hjqvFmX+b/oNxZvKpx5TEoMZKoMzPUtoQSJRjuUSnZ3ouv7HhTQs+9
 sps7bRv1oAotH+aSMb9qh+W+TvL+qPC0nLNnq+pD0o9My/bydkv1A1ieyaFkYP3UrwNu
 oijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209119; x=1789813919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Vy7AEaSvyUUu58wBVkFr8aNHn0nDowvZVe9u1r65rTw=;
 b=OyW63MTzOdEincfDcQSblzrp3pk54LcJoIx9+mf7voHYE+0kQ1RTiE4+bFeFgogaDh
 oRSbFy3QV12ZaVVEfFKgOGKjN+kAg6t/Kzv6TIaoYX5fgoJtqfdyJdZwO+SggcFrZdLh
 7nKd4TQDaA9j4qhRByDCwI3NLZK25XKc8qeWFnG4ZmZIYUzpmF9lTPEoe/vZ9553evMG
 PrV4jvhlD5yPXHhM4Bkq/cOF/MhAiRWfFMvGOd+lmzalC0w+ea1LNh+7QIGvc9P7HZR8
 q8cl1fQIxrrxBoG9NF47Quj7WtS8NIgO4RgZlo9rQuUpJ4dsFOqOS8RdXYYOQihgQxSo
 ZuSg==
X-Gm-Message-State: AFuF++mSgKrzBcNx8GIChzEzGWJS78tnY0NunDfPrron+O087A+ff2tN
 /sn9GdoO2NUTfEU0TtJDbeHsgCjuUt6Fd9R4fflcdGaatPKlH8J+PCQU4KrynivJfuDCFjSifEC
 f7zvZ
X-Gm-Gg: AYBFou37kuWeXhYrBbZWzpaz0YHtQU8/8irlHQ9LLq4NhdDtoFRawJH80KqPkrZB/wZ
 hdEiHy/hNMYj4rNQ8x+f7kt+W9IaWneylLFHQ38a4efuUIM4RtVrh1ZjdOtdsPyzJa+rZp9aBpH
 Ylb/Khb47SiqvD5LDSH9YYsL49Fsb7YCMNGa3Ql3pWX4NjfEZrlrwGRTGNZllbvQKy1D62H1SMl
 GX7oAQ6642Dl/qPxZT3E11EFXmSeNDAfO+gkbkB1UHAWL8Tdlfl1WroWRwTDdKezy7eDyhMVXv3
 wF7T+15d0w2KsOqOCsI7CUZTf+J+Tydv1aFQo45XUgroCU+pW0tmCOUX898DtOtuof38rlGboZn
 GCMItJ6a5UVMqhNcEJv9QiivJOm6HR3Jk73c8F5/1DzXfgf73M0bSyj1HRrGCQ9959Z3ydAHO/q
 YEObE2rD7h0GVAKWvHLJMiNGkx0zso6VK/ecDRop/nxjDt+Oq92ZRaQT9TD0i+4/XVaiJudfjo7
 Ka+ysI=
X-Received: by 2002:a17:90b:380d:b0:398:d93a:b343 with SMTP id
 98e67ed59e1d1-39d9bbf866emr12029903a91.3.1789209118992; 
 Sat, 12 Sep 2026 03:31:58 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 32/82] tcg: Generic expansion of tcg_gen_andc_*
Date: Sat, 12 Sep 2026 00:30:36 -1000
Message-ID: <20260912103126.598030-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 37 ++++++++++++-----------------------
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 15c24010828..b458b1a0b64 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nand_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_nor_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -199,7 +198,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nand_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_nor_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index b92fdc8126a..54c3c51ed29 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -17,6 +17,7 @@ DEF_RRI(subi)
 DEF_RRI(xori)
 DEF_RRR(add)
 DEF_RRR(and)
+DEF_RRR(andc)
 DEF_RRR(div)
 DEF_RRR(divu)
 DEF_RRR(mul)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 4253e3eaaec..ca383e44b59 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -396,6 +396,19 @@ static void gen_andi(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
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
@@ -710,18 +723,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
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
@@ -1769,18 +1770,6 @@ void tcg_gen_revbit64_i64(TCGv_i64 ret, TCGv_i64 arg)
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


