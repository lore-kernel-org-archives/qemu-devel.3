Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B2EC369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mvV-0000XH-Sa; Tue, 15 Apr 2025 16:30:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mv7-00009v-C6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 16:30:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4muL-0007mS-Ft
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 16:30:12 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224019ad9edso80009965ad.1
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 13:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744748963; x=1745353763; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OrOn7+9TJsicowllHagkEdKj6M8MrpZcFBUpXgzh/J4=;
 b=DBcpYTdt2qPw/bzc3Dnteiarugl5+i+NXD9uhmwc6n0AKY19XjhXTMdSpSi/5JgkID
 Qs4ccn4z56VoUzUzyOBYo9NXNlpRs0HNOyy4xaqu5PVa213Oj132QxkUUbLvNNQIELSF
 53VjvrWZgAUVgHMBtZS8b+GkTal66SJ6l7rxx6Vy9HVeS6sWFnheWzJwYWdGnBBUpwaZ
 tG6+QfqmA+BBTu7gEM1p0ZVqy/dji5lvRn/SBz6SofqtkAstwypy9w2BWJsLE/icLF1e
 Cqb9hHDh3YdINlvwRqVOg272xe/EauaMK3t2IGexfw+3HUS4rfzunLvNceDZPioGvz3I
 PGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744748963; x=1745353763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OrOn7+9TJsicowllHagkEdKj6M8MrpZcFBUpXgzh/J4=;
 b=lRZcs0XvQCrynUScxwNxorMQoScoOFwa8jwBA731CpaQLg3xxCfgpdiMbg1Xdmn9CX
 krYj/LU+72EGqAmEdVCl8PqYVuMo51aFxahKPns7yCRSDfRRPB0BbVo8u4laiXlIgMdF
 dWc7NOn3JtWNyxstdaRzqn+UsOD6ixlW9mt7A8iJm/CnP/fK9BZl78DyCboqdDBIfWLy
 v8C2JC2m4lIvIcknpRENrgC+1yZjJ3wxPcwYRpClQQWon1Dc+tzNAThYf2UZpXuK4dzz
 UUP/sqvcJ9YiF/+YEZWXrR45XQrGcGVM07KgabWBSZQjRllGaXpmkO1/PYS8OPgHtZRB
 39bA==
X-Gm-Message-State: AOJu0Yyp2HPi8RM0FJWN6JY4mNSNY+MBK7qUaMac4MUYs/YfyKvRIkse
 RZ3ss20p6XZt8CVQz6owb8nySX22cC8L7Xvr2MUtuFYMCL6IjWb8+RKCBtuj6T8ecYh/U2aDd6t
 Z
X-Gm-Gg: ASbGncu0/+d//yVkZjdq85pqt8yfv+gHppYmZW3/R+dpTtR+ziVedHllcABuE7nterV
 ZZGI0QMqICXrdIcn8s/SdeoOYnLClXPSf8yjHbvTV9umdD03nhXj+fpmmdGF1AmfGEUo+Ipk76R
 Mq5sO/tQI9A7LEdRMP4wb2DWyccpXn3HxT2Q4X6kzJCSUMKZSrSiwrP4WZ8upf3YrWEWtjVjWzU
 RGJVrzRrLLfT9sxsiH8VejBYBfHSw6FwjgQNTzswtBSmws0yVRwpPX2FaKl7moXgylYmHjbWbQV
 oGk9jizT7SvgwZm+4Rhus9sqwxA8WhpP2aNKPpHUWeydSiYqSFyWukMSbNpuivtnuQp2REBb4sA
 =
X-Google-Smtp-Source: AGHT+IGjWeRpRFHmR1b30Y0SocogN5TFir/Mwo1KUfg7poT7S+MYort5Nk4qypCa7CrhraSTlaQomg==
X-Received: by 2002:a17:903:41c3:b0:227:e74a:a057 with SMTP id
 d9443c01a7336-22c31ab0f8emr5530125ad.44.1744745568641; 
 Tue, 15 Apr 2025 12:32:48 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccbd5esm122062355ad.248.2025.04.15.12.32.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:32:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 109/163] tcg/mips: Drop support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:20 -0700
Message-ID: <20250415192515.232910-110-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
index 7fae1c51e9..e69781b871 100644
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
@@ -2370,15 +2318,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2420,10 +2359,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


