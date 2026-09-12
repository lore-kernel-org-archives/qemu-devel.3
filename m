Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271CDC79FB6
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Sep 2026 10:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x5L1x-0005rA-Kc; Sat, 12 Sep 2026 06:32:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1c-00055L-Qs
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:00 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x5L1a-0007Lo-PM
 for qemu-devel@nongnu.org; Sat, 12 Sep 2026 06:32:00 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-398a5aad413so1820740a91.3
 for <qemu-devel@nongnu.org>; Sat, 12 Sep 2026 03:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789209117; x=1789813917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ZWFsGOxwzuMXFS+YuvDrYxeDPljPi6znK+D3k/YdNZk=;
 b=AXrABCVhBXNRui2OUVPinIrAaYcbu6oLBkWIAYR8tzRA0N8Bbk5x2y52deHTK35cmR
 XSVX4YRy8tIkMkmO538FI9xM8UO7gdEJkNtscJqvB6kRSPrWNYheT+kAgOqmmGnKdDh7
 rHyAVkf5D5zsG9Fgd0QD/AMkRcrL8glaum4hclPkTEpNACBaAeaEW3VH7i7y3O2QdQM/
 u8BkWmZXwjLIddjyoDL2JjMh1N7wAFJQI+xBnbLNuicELtTpSLlyCYY7KC3MLkX6m81G
 HM8MJRARRADjAY+ryRnxmctw0b2jjTvi8fo+o/F0lONl2AlfT/TePmhdMLiCR58TgRyk
 KLrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789209117; x=1789813917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=ZWFsGOxwzuMXFS+YuvDrYxeDPljPi6znK+D3k/YdNZk=;
 b=HGI3Dc1nlOGNiGA0tgnvguqJ2FdMoPPTRPtA1GGsfKUWeZxEvNmUhD+eYkA28UMmjW
 /20YRam5aWaA2nshjG4xl7ZEex3jPWp5iW9IeqsQf2x1qrhj828AzuYVp6/frFdeVX5W
 veRto2MCT+jbNvn+Jbf1weefSa9VBy+v+6gZk8AJ0GPdK7AVgbNUG+YA9hQeMCbOINIe
 1vOBWsbX/w55wFi+Wni3qLit2tUcsjvHGu2r+eLkU432o3XEmlHv6pG1v7gCTUmjwnTp
 miCwtcXucNMEirtP0XgxCTZSPo+wE14ZJabBP1hUVzpvzZhD95O7xcR8dGmdcfz/D7/J
 hI+A==
X-Gm-Message-State: AFuF++kO/ulUWMtwaaN+9ICE25J8Z857snMbYF3SSMy6W4cYyEl25Sb4
 E0Ik9SG6IYNqmtpR8DsT99VoarZONKNPQNczmjfV9FtO1i/qREMt2k5Wz1TXPkq9VRLXp44T4M6
 2Tzpy/Uw=
X-Gm-Gg: AYBFou0ARabhT4LWb17v1T82JZvzsjJGQHPCS5L+tdnry4X50xuMs9BcbKij0jG9btD
 0ZhiYwGMsJTLMnj4MgTmv4CyFBzlVcBC5g0FjjwSYvZdgGOK6zWq3fdS7lCqUHcEqDrryClfKB1
 OU1tsPuHJliyjmD80b1KKLzEFQBs5J6WGJ9CNyFYEt35RZue4aCwW7p1uVuhRyR0oZf87P5u61r
 9MgzkKkVyMKo0Gtkr+2zeJfI6vpLwZShi2xyXtA1xV+cOKkW1bbkMi8QV+PiwBrYd7GBTLR531k
 VuEFZLpFfCxCPB5rWF5RTHLi5J+2GbLNiKcMIAJqzylQQiIozKP5eAUKu+0EXPLKJ92gma5SFdO
 NgqSDXOYTfVmCg6+mz7n4fxpGWTmrGidX1u1vyosJLkgUvUQt4rVSxQh/O1rAjJO6FLjUJmtjHN
 ml663G1N/j+Of31rpCghaIsmkXCimt8YZacdHLwwFGuErQF49w+7HJERKaiIWHCiqJ5EtT43bsC
 80V44Y=
X-Received: by 2002:a17:90b:53d0:b0:398:9bd1:3216 with SMTP id
 98e67ed59e1d1-39d9c3597b5mr12549048a91.23.1789209117172; 
 Sat, 12 Sep 2026 03:31:57 -0700 (PDT)
Received: from stoup ([2603:800c:7900:ed00:bf2d:a6f5:e308:cd27])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14365b8ead8sm12628226c88.10.2026.09.12.03.31.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Sep 2026 03:31:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 30/82] tcg: Generic expansion of tcg_gen_divu_*
Date: Sat, 12 Sep 2026 00:30:34 -1000
Message-ID: <20260912103126.598030-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912103126.598030-1-richard.henderson@linaro.org>
References: <20260912103126.598030-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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
 include/tcg/tcg-op-common.h   |  2 --
 include/tcg/tcg-op-def2.h.inc |  1 +
 tcg/tcg-op.c                  | 43 ++++++++++++-----------------------
 3 files changed, 16 insertions(+), 30 deletions(-)

diff --git a/include/tcg/tcg-op-common.h b/include/tcg/tcg-op-common.h
index 20ccdbd0c95..cd9d6f17003 100644
--- a/include/tcg/tcg-op-common.h
+++ b/include/tcg/tcg-op-common.h
@@ -121,7 +121,6 @@ void tcg_gen_plugin_mem_cb(TCGv_i64 addr, unsigned meminfo);
 
 /* 32 bit ops */
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_andc_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
 void tcg_gen_eqv_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2);
@@ -201,7 +200,6 @@ void tcg_gen_st_i32(TCGv_i32 arg1, TCGv_ptr arg2, tcg_target_long offset);
 
 /* 64 bit ops */
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_andc_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
 void tcg_gen_eqv_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2);
diff --git a/include/tcg/tcg-op-def2.h.inc b/include/tcg/tcg-op-def2.h.inc
index 56d7d2c6bfc..d7fca267eea 100644
--- a/include/tcg/tcg-op-def2.h.inc
+++ b/include/tcg/tcg-op-def2.h.inc
@@ -18,6 +18,7 @@ DEF_RRI(xori)
 DEF_RRR(add)
 DEF_RRR(and)
 DEF_RRR(div)
+DEF_RRR(divu)
 DEF_RRR(mul)
 DEF_RRR(or)
 DEF_RRR(rem)
diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index bdbd9244864..a01056fe3a7 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -431,6 +431,21 @@ static void gen_div(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
     }
 }
 
+static void gen_divu(TCGType type, TCGTemp *dst, TCGTemp *src1, TCGTemp *src2)
+{
+    if (tcg_op_supported(INDEX_op_divu, type, 0)) {
+        gen_op_ttt(INDEX_op_divu, type, dst, src1, src2);
+    } else if (tcg_op_supported(INDEX_op_divu2, type, 0)) {
+        TCGTemp *tmp = tcg_temp_new_internal(type, TEMP_EBB);
+        TCGTemp *zero = tcg_constant_internal(type, 0);
+
+        gen_op_ttttt(INDEX_op_divu2, type, dst, tmp, src1, zero, src2);
+        tcg_temp_free_internal(tmp);
+    } else {
+        g_assert_not_reached();
+    }
+}
+
 static void gen_mov(TCGType type, TCGTemp *dst, TCGTemp *src)
 {
     if (src != dst) {
@@ -688,20 +703,6 @@ void tcg_gen_negsetcondi_i32(TCGCond cond, TCGv_i32 ret,
     tcg_gen_negsetcond_i32(cond, ret, arg1, tcg_constant_i32(arg2));
 }
 
-void tcg_gen_divu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I32, 0)) {
-        tcg_gen_op3_i32(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I32, 0)) {
-        TCGv_i32 t0 = tcg_temp_ebb_new_i32();
-        TCGv_i32 zero = tcg_constant_i32(0);
-        tcg_gen_op5_i32(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i32(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i32(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I32, 0)) {
@@ -1582,20 +1583,6 @@ void tcg_gen_negsetcond_i64(TCGCond cond, TCGv_i64 ret,
     }
 }
 
-void tcg_gen_divu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
-{
-    if (tcg_op_supported(INDEX_op_divu, TCG_TYPE_I64, 0)) {
-        tcg_gen_op3_i64(INDEX_op_divu, ret, arg1, arg2);
-    } else if (tcg_op_supported(INDEX_op_divu2, TCG_TYPE_I64, 0)) {
-        TCGv_i64 t0 = tcg_temp_ebb_new_i64();
-        TCGv_i64 zero = tcg_constant_i64(0);
-        tcg_gen_op5_i64(INDEX_op_divu2, ret, t0, arg1, zero, arg2);
-        tcg_temp_free_i64(t0);
-    } else {
-        g_assert_not_reached();
-    }
-}
-
 void tcg_gen_remu_i64(TCGv_i64 ret, TCGv_i64 arg1, TCGv_i64 arg2)
 {
     if (tcg_op_supported(INDEX_op_remu, TCG_TYPE_I64, 0)) {
-- 
2.53.0


