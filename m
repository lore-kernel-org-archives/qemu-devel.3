Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22371FB5180
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 02:31:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9wAy-0007iC-Fj; Mon, 06 Apr 2026 22:28:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAp-0007cr-Bk
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:15 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w9wAl-00070d-7h
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 22:28:14 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso22686075ad.0
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 19:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775528889; x=1776133689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WyMKYp1d+WdQl2v2MXCqwK+7p4+iQyCYGX3/7kD9JIk=;
 b=kE+XF4DpN9qzJhO3iUYVYbu7cotwEBuNB0eo9vpTwVLxJjYXZtowXQc631q/Wc8hhK
 AEP8d/r2fW5iA2wgh8kxZ1mL0m/7CDe2bPlA36rM4MNtf4yeghimzURXxMpz7T/oa6Pk
 QfwuVk1gbyW6jILySzx5bW+ih97qXQb6T5iqXWzmh13uQevq7BH/E2S3fH+cqlX+PvrU
 DC7ojSaI3v2ebsOPredLTJt+nKh1WACP0pUt+9ZkPQSThL8ANL61ZOk3V1mCdBOIYMn3
 CysfYkFdjEDPtl2jADvdUHw+8uz7ASY6fVGWhUSHF1ZHYEhP/lrgFN9rRi052icXg+Tc
 GuvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775528889; x=1776133689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WyMKYp1d+WdQl2v2MXCqwK+7p4+iQyCYGX3/7kD9JIk=;
 b=kHukFAw2Ne9X8M8Vr5mLOvrHO18/KJuZ6phjWbjcome94pYMB76Gshr5z+4eS4zuxo
 6dMnf/bwSVDKM2r7LGuPXh/jUwPrkKT0bULXfUzZ0bI7ne3ytAYb5U8rBE2fI2Pe4ZO2
 GBPptOnmSYoiiGFX4QDKQobGqOyZlO1HCHFI7ICwTmGjlVL6fHmYHrWbdTGpSX0SzAH2
 S9T3Flme3yO4l+xo/lXzNRdpSmNj+fqhRGtPu97Q4eoqI8daQ7boQgoFtBonbBmZewhF
 BhHPA0G6/sg1FRZcfYFN7khqaaRQWmqjhO0GJzNEO1g0bOcFDRAvV6HKZZ8UAV5QMFeG
 9AvA==
X-Gm-Message-State: AOJu0YzK13FaV5/IMtvC449HGET+ki/P5BJwu9nerXld3bHV++anTK4A
 2vdlaLianFekWlwgQBAFyMWfzpeBKIitv5XPwizDPA6o+ob/F6PQXXsccEttxhrx/59qe1euS76
 0hW++c5Erjg==
X-Gm-Gg: AeBDievo98d6o5nRhx8PhI+dkhbyRN8T4bBEudY/KdZN2g2J/Y4zSEdiZgYTevdH+G9
 kmhKFReSzuer+7wRY2gwZfuNp/LDKyYEPnhoufVKVxGuLrf9lpjzM9SxYo/SYqq/h5cDDhkNJ/f
 MQ8Iox5gZCwrOQStuOq5MRCGGgg/Fb2LtGFUkkpl2flY1VG/EjyGvtBKUoXBDbSuwXXRAXD+PoU
 NKPgYuO6uLL+hBgUL7eZmVbbODqN0axx5GSd3qfvnseCuIQseGE0AMXIy1s3XS2WMhWJ+qS3dKs
 nHWq2iZ3cMLQsr4B327hwjGjPsTeMdFAi3Fria/wKXcwuU9ryj55BY382kZ1ZWy4oI74MkaV+Qa
 A6IaaIe63nAg+hXQhhlBBY+rU8quLnrq9ptOR34ESiPaxQkWEQ2T+CLmZMrfuVkBbic3y8MYE0Y
 VBu72d4WD7lctpvAFaWWMQk41sPQMSsIwFWGI+1DAgPxDvTBCDdTB1QyLCtgQaziBiWzDEEtp3V
 gbU
X-Received: by 2002:a17:902:f545:b0:2b2:4fc1:f653 with SMTP id
 d9443c01a7336-2b281b8b96bmr125046195ad.3.1775528888970; 
 Mon, 06 Apr 2026 19:28:08 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2749794e8sm161423685ad.53.2026.04.06.19.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 19:28:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, jim.macarthur@linaro.org,
 qemu-arm@nongnu.org
Subject: [PATCH v9 15/20] target/arm/tcg/translate.c: replace TCGv with TCGv_va
Date: Mon,  6 Apr 2026 19:27:43 -0700
Message-ID: <20260407022748.57629-16-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
References: <20260407022748.57629-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We know this file is for 32-bit runtime target, so we can set
TCG_ADDRESS_BITS. TCG_TYPE_VA is derived accordingly and is already
passed to translator_loop.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/translate.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 7bdf46dd899..b3c95fb66cb 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -22,7 +22,8 @@
 
 #include "translate.h"
 #include "translate-a32.h"
-#include "tcg/tcg-op.h"
+#define TCG_ADDRESS_BITS 32
+#include "tcg/tcg-op-mem.h"
 #include "qemu/log.h"
 #include "arm_ldst.h"
 #include "semihosting/semihost.h"
@@ -909,14 +910,14 @@ MemOp pow2_align(unsigned i)
  * that the address argument is TCGv_i32 rather than TCGv.
  */
 
-static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
+static TCGv_va gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 {
-    TCGv addr = tcg_temp_new();
-    tcg_gen_extu_i32_tl(addr, a32);
+    TCGv_va addr = tcgv_va_temp_new();
+    tcg_gen_mov_i32(addr, a32);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (op & MO_SIZE) < MO_32) {
-        tcg_gen_xori_tl(addr, addr, 4 - (1 << (op & MO_SIZE)));
+        tcg_gen_xori_i32(addr, addr, 4 - (1 << (op & MO_SIZE)));
     }
     return addr;
 }
@@ -928,21 +929,21 @@ static TCGv gen_aa32_addr(DisasContext *s, TCGv_i32 a32, MemOp op)
 void gen_aa32_ld_internal_i32(DisasContext *s, TCGv_i32 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_ld_i32(val, addr, index, opc);
 }
 
 void gen_aa32_st_internal_i32(DisasContext *s, TCGv_i32 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
     tcg_gen_qemu_st_i32(val, addr, index, opc);
 }
 
 void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     tcg_gen_qemu_ld_i64(val, addr, index, opc);
 
@@ -955,7 +956,7 @@ void gen_aa32_ld_internal_i64(DisasContext *s, TCGv_i64 val,
 void gen_aa32_st_internal_i64(DisasContext *s, TCGv_i64 val,
                               TCGv_i32 a32, int index, MemOp opc)
 {
-    TCGv addr = gen_aa32_addr(s, a32, opc);
+    TCGv_va addr = gen_aa32_addr(s, a32, opc);
 
     /* Not needed for user-mode BE32, where we use MO_BE instead.  */
     if (!IS_USER_ONLY && s->sctlr_b && (opc & MO_SIZE) == MO_64) {
@@ -2035,7 +2036,7 @@ static void gen_load_exclusive(DisasContext *s, int rt, int rt2,
          * architecturally 64-bit access, but instead do a 64-bit access
          * using MO_BE if appropriate and then split the two halves.
          */
-        TCGv taddr = gen_aa32_addr(s, addr, opc);
+        TCGv_va taddr = gen_aa32_addr(s, addr, opc);
 
         tcg_gen_qemu_ld_i64(t64, taddr, get_mem_index(s), opc);
         tcg_gen_mov_i64(cpu_exclusive_val, t64);
@@ -2064,7 +2065,7 @@ static void gen_store_exclusive(DisasContext *s, int rd, int rt, int rt2,
 {
     TCGv_i32 t0, t1, t2;
     TCGv_i64 extaddr;
-    TCGv taddr;
+    TCGv_va taddr;
     TCGLabel *done_label;
     TCGLabel *fail_label;
     MemOp opc = size | MO_ALIGN | s->be_data;
@@ -3791,7 +3792,7 @@ static void do_ldrd_load(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i64 t64 = tcg_temp_new_i64();
     TCGv_i32 tmp = tcg_temp_new_i32();
     TCGv_i32 tmp2 = tcg_temp_new_i32();
@@ -3846,7 +3847,7 @@ static void do_strd_store(DisasContext *s, TCGv_i32 addr, int rt, int rt2)
      */
     int mem_idx = get_mem_index(s);
     MemOp opc = MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN | s->be_data;
-    TCGv taddr = gen_aa32_addr(s, addr, opc);
+    TCGv_va taddr = gen_aa32_addr(s, addr, opc);
     TCGv_i32 t1 = load_reg(s, rt);
     TCGv_i32 t2 = load_reg(s, rt2);
     TCGv_i64 t64 = tcg_temp_new_i64();
@@ -4067,7 +4068,7 @@ DO_LDST(STRH, store, MO_UW)
 static bool op_swp(DisasContext *s, arg_SWP *a, MemOp opc)
 {
     TCGv_i32 addr, tmp;
-    TCGv taddr;
+    TCGv_va taddr;
 
     opc |= s->be_data;
     addr = load_reg(s, a->rn);
-- 
2.47.3


