Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F82EE57C6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:52:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQYY-0002Lw-Dt; Wed, 11 Sep 2024 12:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYX-0002IT-Md
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:01 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQYV-0003fv-VL
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:51:01 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7191ee537cbso644796b3a.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073458; x=1726678258; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mDvGY07edr19JucuS9HGBne2HdSXpx09i/5YVq2X/eo=;
 b=rSLE1204Pj1Aw7mH5qj1F9S1E+QdWCTeD29iWfTY1TyY/+tQt5KRSWOHnXpR6tY2RI
 P0TwkBxtuhpW9g+S/JWpPWAAu45JxJrYPhGVlaxzVXlqecsZPlZo62SnUAnSRQFE8bln
 Z8vK1ZGDcUAoqk4HzOHgx84sOQcj/XekccTctjWKRCm0UM1kxy7XvhIpcmbi7E4AUamm
 h7VVLE/Cpu8AsMfSJkozyGltG2z5dnb/BMgb1aD+W+JcdoAry+ptRnMejE+ZC1hQMOkF
 IK38OisPQWnIp/oBeuZ1JB+KREV44d1iOCu6mEcJzZwcQ4DCuuUhTmNKl5r6kbYq1EYr
 KqwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073458; x=1726678258;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mDvGY07edr19JucuS9HGBne2HdSXpx09i/5YVq2X/eo=;
 b=rxyTqyFe4JgrArWtSTlASW8Jprj5viK2kX3Nx/BwNkxB6oKGyQC72JDK0DiLmJz1uz
 zOkx6kTs3rmDMSlBLblgcTj8NqMl5JJix93NNGYWHvQXO7cWukRv+1cR0kuVAoqJiGDb
 54Eiw0MR8KWjvJ5cb2QYFAOZMAJCrk0v2f2m6OxB8FeDmiapb2kHbr/C2tT2eM8COGMM
 xV5LylbodT8Xm99GPRXR/gSk4cL8K2QmLwCQwFL7wsr+MWSVlyyyETwjGV/kFgxvBkNB
 g7NyxFcZX08bUxmx8ynSJp+DfFiUwSqZwM7o0T4YMroejrkIuzqxz3Y8ST4HaOnwguHs
 6QLA==
X-Gm-Message-State: AOJu0Yxb/3zVewVl6usxUrIuM8kjVDbJ7y/wVoimXML8LHMkYk48XJH5
 r8b24QEoVITV5V2/xnYbwJCJy6TDO0cBydhih/Hoqn8leOGeOLDZye3pof7iTHyhYXKkMgaXsVK
 P
X-Google-Smtp-Source: AGHT+IHExn+eElbtJnT0u7zmfxKvxJE3VJQimjRXK1Ud3KG83Kzx4SBdzwO42aOGCEdaBa7mGEAfXg==
X-Received: by 2002:a05:6a21:39b:b0:1bd:2214:e92f with SMTP id
 adf61e73a8af0-1cf5e075b42mr7085470637.14.1726073458526; 
 Wed, 11 Sep 2024 09:50:58 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fe4e7esm3186947b3a.80.2024.09.11.09.50.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 09:50:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: zhiwei_liu@linux.alibaba.com, tangtiancheng.ttc@alibaba-inc.com,
 philmd@linaro.org
Subject: [PATCH v2 10/18] tcg/i386: Optimize cmpsel with constant 0 operand 3.
Date: Wed, 11 Sep 2024 09:50:39 -0700
Message-ID: <20240911165047.1035764-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240911165047.1035764-1-richard.henderson@linaro.org>
References: <20240911165047.1035764-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

These can be simplified to and/andc, avoiding the load of
the zero into a register.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  2 +-
 tcg/i386/tcg-target-con-str.h |  1 +
 tcg/i386/tcg-target.c.inc     | 32 +++++++++++++++++++++++++-------
 3 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index da4411d96b..06e6521001 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -50,7 +50,7 @@ C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
 C_O1_I3(x, 0, x, x)
 C_O1_I3(x, x, x, x)
-C_O1_I4(x, x, x, x, x)
+C_O1_I4(x, x, x, xO, x)
 C_O1_I4(r, r, reT, r, 0)
 C_O1_I4(r, r, r, ri, ri)
 C_O2_I1(r, r, L)
diff --git a/tcg/i386/tcg-target-con-str.h b/tcg/i386/tcg-target-con-str.h
index cc22db227b..52142ab121 100644
--- a/tcg/i386/tcg-target-con-str.h
+++ b/tcg/i386/tcg-target-con-str.h
@@ -28,6 +28,7 @@ REGS('s', ALL_BYTEL_REGS & ~SOFTMMU_RESERVE_REGS)    /* qemu_st8_i32 data */
  */
 CONST('e', TCG_CT_CONST_S32)
 CONST('I', TCG_CT_CONST_I32)
+CONST('O', TCG_CT_CONST_ZERO)
 CONST('T', TCG_CT_CONST_TST)
 CONST('W', TCG_CT_CONST_WSZ)
 CONST('Z', TCG_CT_CONST_U32)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index a04dc7d270..210389955d 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -133,6 +133,7 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
 #define TCG_CT_CONST_I32 0x400
 #define TCG_CT_CONST_WSZ 0x800
 #define TCG_CT_CONST_TST 0x1000
+#define TCG_CT_CONST_ZERO 0x2000
 
 /* Registers used with L constraint, which are the first argument
    registers on x86_64, and two random call clobbered registers on
@@ -226,6 +227,9 @@ static bool tcg_target_const_match(int64_t val, int ct,
     if ((ct & TCG_CT_CONST_WSZ) && val == (type == TCG_TYPE_I32 ? 32 : 64)) {
         return 1;
     }
+    if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
+        return 1;
+    }
     return 0;
 }
 
@@ -3119,13 +3123,27 @@ static void tcg_out_cmpsel_vec(TCGContext *s, TCGType type, unsigned vece,
                                TCGReg v0, TCGReg c1, TCGReg c2,
                                TCGReg v3, TCGReg v4, TCGCond cond)
 {
-    if (tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond)) {
-        TCGReg swap = v3;
-        v3 = v4;
-        v4 = swap;
+    bool inv = tcg_out_cmp_vec_noinv(s, type, vece, TCG_TMP_VEC, c1, c2, cond);
+
+    /*
+     * Since XMM0 is 16, the only way we get 0 into V3
+     * is via the constant zero constraint.
+     */
+    if (!v3) {
+        if (inv) {
+            tcg_out_vex_modrm_type(s, OPC_PAND, v0, TCG_TMP_VEC, v4, type);
+        } else {
+            tcg_out_vex_modrm_type(s, OPC_PANDN, v0, TCG_TMP_VEC, v4, type);
+        }
+    } else {
+        if (inv) {
+            TCGReg swap = v3;
+            v3 = v4;
+            v4 = swap;
+        }
+        tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, v0, v4, v3, type);
+        tcg_out8(s, (TCG_TMP_VEC - TCG_REG_XMM0) << 4);
     }
-    tcg_out_vex_modrm_type(s, OPC_VPBLENDVB, v0, v4, v3, type);
-    tcg_out8(s, (TCG_TMP_VEC - TCG_REG_XMM0) << 4);
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3716,7 +3734,7 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
     case INDEX_op_bitsel_vec:
         return C_O1_I3(x, x, x, x);
     case INDEX_op_cmpsel_vec:
-        return C_O1_I4(x, x, x, x, x);
+        return C_O1_I4(x, x, x, xO, x);
 
     default:
         g_assert_not_reached();
-- 
2.43.0


