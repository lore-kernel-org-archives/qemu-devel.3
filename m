Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3CCC88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:14:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pNl-0007dI-PC; Wed, 16 Sep 2026 09:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNY-00071y-54
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:48 -0400
Received: from mail-oo2-x0e.google.com ([2607:f8b0:4864:31::e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6pNW-0001Wf-A4
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:08:47 -0400
Received: by mail-oo2-x0e.google.com with SMTP id
 006d021491bc7-6b1ae6b2010so672214eaf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789564125; x=1790168925; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=CrGKcOH+b3vtXiaqkZW0WTGXzEC6kzDENJmOVSwMcEQ=;
 b=WKew+ltfj3G01jv+cETibVGXJqeLDILy9rEi//yc6x/Pd5ZHfzxYPcnxLNKhE1wvoz
 9m0FxQoHXWpe0SWOjzX03HWr0drWMbDOwbMQjACN+ODeQlcRq12YW98SaM42h1eITiDE
 oQA5czu9TxmnbY2NC0WFAQRDph+eIiDdJRMDA+vINg888JpulRV9EmttTqScXXzozviY
 qOPfiHwzGf03GoX4phUPIRnbamDdMJzpv3JUK0LyGmzE8IzYRvKPs2Dz5sG8qq68ZQsW
 KDtdVHXhM3ZhJT8i/uL9p2n2qxCnLOfKo/Mu0/f4F9wwS252GqgZQ1HxhuLWj4b2ZS+j
 s9PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564125; x=1790168925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=CrGKcOH+b3vtXiaqkZW0WTGXzEC6kzDENJmOVSwMcEQ=;
 b=jRyIUQa11aEHT79UHzQaMsueryPEosCYt9NDJfeFoA7k3vYzWQLUjZ/6EMp7Wm1HS3
 VbhcmON5d5xWbmSc7D5Gx48yfCkEvjAUdgFGtGK5ziSYMoFKAv9AxZ7kS+q7BHUlOjrq
 qAILl+QUPkDetMFnGd9ilbAJc7La9RMtLBWplld+zGi4CP+8jsPUD4ZkaiMXv1+klgpF
 t6kMqlfIYp+D3TY3wPpqmnvo/PDbYiVtmMcem8/XPDLLNUz85RlIGYcaPvLy7vbRQIuY
 pXv2me4Gjegg7dI8cu/uqXhIbSTl8LFoCIzPsvUo9iyeGxXk1iGzyfz9fhmtM/fjvR2v
 gPRg==
X-Gm-Message-State: AFuF++kF3qhhE2xkx6G3T0UFOsLTItpq4HxrAL/6kUWUsXePody0GeAU
 vgWVnhgrdF7NR2DDUHI7F40ajdqwUAOqkmsmrzvqGOtjYWHJzn4P9Wt7kCzJ3svyhy0h7EI/FxQ
 Jha8gs/k=
X-Gm-Gg: AYBFou3cB5ev4WtL5lxoW4QQmFEbC+6Wz0T+stpm984u17NFGgob+N5ryChNvDT8GVU
 FeKF/W2qC19qpQkaoDJWR38+Y9T1mO/z8E5ciiE+PZcORYGVJJMcoQE0AA4rEV4/kMAT/BKX0Ab
 Tw57Uv1x25RmwRcdFupur29zvqBnZsbtregt6MfX726BTljHrsW956/vRhgGaKWPdTaDxW1Tci2
 VwZm7oa/AOvVdzjRmU0D6tdfUghiPFWm2rjZ5PKXzcHsz8d1c6k/k61IvgFpDuRfABjeOlOA15i
 onRJHjSGvGMO2MK/Ufaxlid/0Wsmyghof4thAdu/Wgl5o7hIaOE6WIRkc9ODSGLDbZqBqB/kc5e
 rxhTAXhDaCHeMA0V2ceY4XWx+RJlyHOFLOtlhIgcHvmf4yfcR51S3zJMzLplxqQgLBhHA8FJEFn
 GFjqFdcKWy5lYHU1o9sdcIjZgAGQaVu0NRyH6SbAJdrtoFHU2d5EWm9IBpSpm5C38aU53ZguOpo
 y7vbv4=
X-Received: by 2002:a05:6820:4dc9:b0:6c4:6699:53cf with SMTP id
 006d021491bc7-6c7d45e6be6mr2522464eaf.49.1789564125019; 
 Wed, 16 Sep 2026 06:08:45 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:845c:f507:397b:9b72])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33bf5aa1194sm9398056eec.14.2026.09.16.06.08.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:08:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 72/92] tcg: Generic expansion of tcg_gen_smax_*
Date: Wed, 16 Sep 2026 03:03:47 -1000
Message-ID: <20260916130409.3382710-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916130409.3382710-1-richard.henderson@linaro.org>
References: <20260916130409.3382710-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:31::e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo2-x0e.google.com
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
 tcg/tcg-op.c                 | 27 +++++++++------------------
 3 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index ada613805fe..997f04ba3a4 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -146,7 +146,6 @@ void tcg_gen_mulsu2_i32(TCGv_i32 rl, TCGv_i32 rh, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_bswap16_i32(TCGv_i32 ret, TCGv_i32 arg, int flags);
 void tcg_gen_bswap32_i32(TCGv_i32 ret, TCGv_i32 arg);
 void tcg_gen_hswap_i32(TCGv_i32 ret, TCGv_i32 arg);
-void tcg_gen_smax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umin_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_umax_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_ussub_i32(TCGv_i32, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -188,7 +187,6 @@ void tcg_gen_bswap32_i64(TCGv_i64 ret, TCGv_i64 arg, int flags);
 void tcg_gen_bswap64_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_hswap_i64(TCGv_i64 ret, TCGv_i64 arg);
 void tcg_gen_wswap_i64(TCGv_i64 ret, TCGv_i64 arg);
-void tcg_gen_smax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umin_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_umax_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_ussub_i64(TCGv_i64, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def.h.inc b/include/tcg/tcg-op-def.h.inc
index 2ccdddc8eeb..a5330ab6a1d 100644
--- a/include/tcg/tcg-op-def.h.inc
+++ b/include/tcg/tcg-op-def.h.inc
@@ -54,6 +54,7 @@ DEF3(shl, TCGV, TCGV, TCGV)
 DEF3(shli, TCGV, TCGV, TINT)
 DEF3(shr, TCGV, TCGV, TCGV)
 DEF3(shri, TCGV, TCGV, TINT)
+DEF3(smax, TCGV, TCGV, TCGV)
 DEF3(smin, TCGV, TCGV, TCGV)
 DEF3(sub, TCGV, TCGV, TCGV)
 DEF3(subi, TCGV, TCGV, TINT)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 2882593d909..1af0f284d02 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -1133,6 +1133,15 @@ static void gen_shri(TCGType type, TCGTemp *dst, TCGTemp *src1, int64_t src2)
     }
 }
 
+static void gen_smax(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_smax, type, 0)) {
+        gen_op_ttt(INDEX_op_smax, type, dst, src1, src2);
+    } else {
+        gen_movcond(type, TCG_COND_GT, dst, src1, src2, src1, src2);
+    }
+}
+
 static void gen_smin(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
 {
     if (tcg_op_supported(INDEX_op_smin, type, 0)) {
@@ -1467,15 +1476,6 @@ void tcg_gen_umin_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
     }
 }
 
-void tcg_gen_smax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i32(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i32(TCGv_i32 ret, TCGv_i32 a, TCGv_i32 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I32, 0)) {
@@ -1998,15 +1998,6 @@ void tcg_gen_umin_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
     }
 }
 
-void tcg_gen_smax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
-{
-    if (tcg_op_supported(INDEX_op_smax, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_smax, ret, a, b);
-    } else {
-        tcg_gen_movcond_i64(TCG_COND_LT, ret, a, b, b, a);
-    }
-}
-
 void tcg_gen_umax_i64(TCGv_i64 ret, TCGv_i64 a, TCGv_i64 b)
 {
     if (tcg_op_supported(INDEX_op_umax, TCG_TYPE_I64, 0)) {
-- 
2.53.0


