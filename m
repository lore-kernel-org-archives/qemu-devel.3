Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119ABC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuB-0003yu-Bd; Sun, 16 Feb 2025 18:18:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntN-0002x4-Mw
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:42 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntK-00064S-6b
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:41 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-220f4dd756eso39373025ad.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747855; x=1740352655; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8q1YzLt/x49B+1OByL0TccXG4VybqcdLDmfXHyhs03Q=;
 b=rA4V7vpGSnJq1L0V++5N7xZjlwBIDSDjYiW7gNsIud1UCSTyBYpa03ibSXbq1ZKccC
 OyL9xy+1zQfZjxb6DObapiud5N78rzibnQPNaKXeZqA/Q8BzLUa88YQBvUuRcW6uq/6R
 XLBoBP5ifilgBz2IXpf/XiD5TfvjRVAMjzsJvwkaUyfmbeEVgfWb8HLoy/iY4yIqefM+
 7hOlnz/djxrFY2IRNRy8o7j6GsrcY/AKd5FiJriONN1tzv+m6lg7ss+NGNewCJ2ci70J
 F8qLYIDLcYgggvXfL1YGdupZTwsrHqSj1Apjktt0Vul9/L1u0oBOuOTAC0c9n8adgWig
 tNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747855; x=1740352655;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8q1YzLt/x49B+1OByL0TccXG4VybqcdLDmfXHyhs03Q=;
 b=krrCr2s4y//V6j7bgpQU0qiiWNi+B8C7JC8VSQcFAdV1dEuXunjm1YsktgmwI6+SiZ
 xdPojc+TLqBZMQ5e9j0vv+6CO2X7lkE9knTkpk5zNsz8dhQgdiYotvuKO8S6LaSGQiga
 dIFaMDi4l/CPvnSY8dnt4uska7AsrNMwl1Sg6jU+hgrLN9U6JquVzQaPHCU4oLWN2jt8
 0KRfy3StmEutOs9cnScMMNBwLXT8n3OkTf/j3deGMoARpiGE3JARsi5D7+A1FdtlbA41
 4x3OH/Sfwf4FN4/VOSTAmcc0+tDLy9eAZjtRjrgY/KZ5YYg5KZEmJ2fH/ZcmIWJpic+a
 Wi5w==
X-Gm-Message-State: AOJu0YwVVJRNAV9meJNGHQRSYKOs4Bwq76iKvGeKWBrGaEP89q2Y1i0w
 WrcXGUagku76VRr3c2tq+skDK2GhJe0fVkecWiNo5W4a+wH5DOB4aWVvUxouZUM3iChO3w7HoWy
 i
X-Gm-Gg: ASbGncuTTFYOh2go3iDJfi+d9dsU3aL7VKUwAqxQBgHyESnSIN233C/2N/uulZzn2YV
 nJwOyDjI7Ur2xthHaTOkTZhdq82dKHbpKbJ1Ap16I3XN6Kqdulvt85t+HTXoPTvLAAxK4MMOzFj
 vVngW7mBVvw9jPZCgeGNQbZo8P/gyilX8x7pmeKBXSCYKngVMI9VH/97sqQkhlYkkQ7W4yULfwL
 nryaPOdye1EswRePoYePs0DsZYyiGDFcpKcqz2LQSx75CxnfM4hX9y5swTo5G2tViCUAKtqdAvB
 IWf5hoKrnlURlIOJiCNYV7V1dvhwZDt3GvowNv7lp1QSqLE=
X-Google-Smtp-Source: AGHT+IGCfGvls4moHSrH0bqi7hQ+ItbwEbURm/lrJFNQ6QXWh6ELG5nU3D+LQFzbdI+Noi3ztQUgGw==
X-Received: by 2002:a17:902:da8e:b0:21f:2ded:76ea with SMTP id
 d9443c01a7336-221040bd2a8mr115777485ad.36.1739747855504; 
 Sun, 16 Feb 2025 15:17:35 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 108/162] tcg/mips: Drop support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:17 -0800
Message-ID: <20250216231012.2808572-109-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
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

We now produce exactly the same code via generic expansion.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-con-set.h |  1 -
 tcg/mips/tcg-target-con-str.h |  1 -
 tcg/mips/tcg-target-has.h     |  7 ++--
 tcg/mips/tcg-target.c.inc     | 67 +----------------------------------
 4 files changed, 3 insertions(+), 73 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 4e09c9a400..5304691dc1 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -28,4 +28,3 @@ C_O1_I4(r, r, rz, rz, rz)
 C_O1_I4(r, r, r, rz, rz)
 C_O2_I1(r, r, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rz, rz, rN, rN)
diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips/tcg-target-con-str.h
index dfe2b156df..db2b225e4a 100644
--- a/tcg/mips/tcg-target-con-str.h
+++ b/tcg/mips/tcg-target-con-str.h
@@ -17,5 +17,4 @@ REGS('r', ALL_GENERAL_REGS)
 CONST('I', TCG_CT_CONST_U16)
 CONST('J', TCG_CT_CONST_S16)
 CONST('K', TCG_CT_CONST_P2M1)
-CONST('N', TCG_CT_CONST_N16)
 CONST('W', TCG_CT_CONST_WSZ)
diff --git a/tcg/mips/tcg-target-has.h b/tcg/mips/tcg-target-has.h
index 9f6fa194b9..9d86906bf3 100644
--- a/tcg/mips/tcg-target-has.h
+++ b/tcg/mips/tcg-target-has.h
@@ -39,18 +39,15 @@ extern bool use_mips32r2_instructions;
 #endif
 
 /* optional instructions */
-
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
+
+#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_add2_i64         0
 #define TCG_TARGET_HAS_sub2_i64         0
 #define TCG_TARGET_HAS_ext32s_i64       1
 #define TCG_TARGET_HAS_ext32u_i64       1
-#else
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #endif
 
 /* optional instructions detected at runtime */
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 35554369cd..f2d03cb6f9 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -187,8 +187,7 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
 #define TCG_CT_CONST_U16  0x100    /* Unsigned 16-bit: 0 - 0xffff.  */
 #define TCG_CT_CONST_S16  0x200    /* Signed 16-bit: -32768 - 32767 */
 #define TCG_CT_CONST_P2M1 0x400    /* Power of 2 minus 1.  */
-#define TCG_CT_CONST_N16  0x800    /* "Negatable" 16-bit: -32767 - 32767 */
-#define TCG_CT_CONST_WSZ  0x1000   /* word size */
+#define TCG_CT_CONST_WSZ  0x800    /* word size */
 
 #define ALL_GENERAL_REGS  0xffffffffu
 
@@ -207,8 +206,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
         return 1;
     } else if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_N16) && val >= -32767 && val <= 32767) {
-        return 1;
     } else if ((ct & TCG_CT_CONST_P2M1)
                && use_mips32r2_instructions && is_p2m1(val)) {
         return 1;
@@ -765,55 +762,6 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
-static void tcg_out_addsub2(TCGContext *s, TCGReg rl, TCGReg rh, TCGReg al,
-                            TCGReg ah, TCGArg bl, TCGArg bh, bool cbl,
-                            bool cbh, bool is_sub)
-{
-    TCGReg th = TCG_TMP1;
-
-    /* If we have a negative constant such that negating it would
-       make the high part zero, we can (usually) eliminate one insn.  */
-    if (cbl && cbh && bh == -1 && bl != 0) {
-        bl = -bl;
-        bh = 0;
-        is_sub = !is_sub;
-    }
-
-    /* By operating on the high part first, we get to use the final
-       carry operation to move back from the temporary.  */
-    if (!cbh) {
-        tcg_out_opc_reg(s, (is_sub ? OPC_SUBU : OPC_ADDU), th, ah, bh);
-    } else if (bh != 0 || ah == rl) {
-        tcg_out_opc_imm(s, OPC_ADDIU, th, ah, (is_sub ? -bh : bh));
-    } else {
-        th = ah;
-    }
-
-    /* Note that tcg optimization should eliminate the bl == 0 case.  */
-    if (is_sub) {
-        if (cbl) {
-            tcg_out_opc_imm(s, OPC_SLTIU, TCG_TMP0, al, bl);
-            tcg_out_opc_imm(s, OPC_ADDIU, rl, al, -bl);
-        } else {
-            tcg_out_opc_reg(s, OPC_SLTU, TCG_TMP0, al, bl);
-            tcg_out_opc_reg(s, OPC_SUBU, rl, al, bl);
-        }
-        tcg_out_opc_reg(s, OPC_SUBU, rh, th, TCG_TMP0);
-    } else {
-        if (cbl) {
-            tcg_out_opc_imm(s, OPC_ADDIU, rl, al, bl);
-            tcg_out_opc_imm(s, OPC_SLTIU, TCG_TMP0, rl, bl);
-        } else if (rl == al && rl == bl) {
-            tcg_out_opc_sa(s, OPC_SRL, TCG_TMP0, al, TCG_TARGET_REG_BITS - 1);
-            tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
-        } else {
-            tcg_out_opc_reg(s, OPC_ADDU, rl, al, bl);
-            tcg_out_opc_reg(s, OPC_SLTU, TCG_TMP0, rl, (rl == bl ? al : bl));
-        }
-        tcg_out_opc_reg(s, OPC_ADDU, rh, th, TCG_TMP0);
-    }
-}
-
 #define SETCOND_INV    TCG_TARGET_NB_REGS
 #define SETCOND_NEZ    (SETCOND_INV << 1)
 #define SETCOND_FLAGS  (SETCOND_INV | SETCOND_NEZ)
@@ -2376,15 +2324,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         }
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], false);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], true);
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, a0);
         break;
@@ -2426,10 +2365,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rz, rz, rN, rN);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
-- 
2.43.0


