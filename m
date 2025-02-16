Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91CCC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:08:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6g-0007mJ-Uk; Sat, 15 Feb 2025 19:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6K-0007ej-7z
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:36 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6A-0006Ha-7T
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:35 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-2fc292b3570so3423920a91.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664084; x=1740268884; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zjENz02CQDbkRalonzQouff56ChSpitsxbPWI9dSHgw=;
 b=da9bMfbI64tE2TD0M4FzZ8DnTRaMfhlur4nS2LLNX8UiwCMsTWWfDaPHEc5vNwZAiO
 aIMfuSuVCfjpZKKsHIYapEtjLxzRy9F0XQ7wwk9mYuFgvdkBn8aqrQYikalSFaWHVxdR
 1F9297MCgQCEWRmDthgOTKHzKukkqHy8QL5l87QM93HSD34RijROUqJLQeFpICT+LlJk
 ys/QKABdiaEKmuxcWLl7d4YvIZ2JM5FGPy1CcSB6HxaXqvmePJwn4hql2bXpOHeP7FNP
 JkzYAh/ItSSy8wQf4i7DF9yKF5ufLVRDrs3dmQq46iXUOsLI23JgXgEKRMCMAQEQc7/H
 XiLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664084; x=1740268884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zjENz02CQDbkRalonzQouff56ChSpitsxbPWI9dSHgw=;
 b=JBwBkTIlM92LErWKjX6+BoLBY90nD0I7e717bq1s0BxqRaCLb0GutZpnnmub9goMoh
 eXBH5HfT0zqxmqykXWaTu2dnby5jG3gTL34lIxLK2FzdmlyObaQg7HzXxEDL/BuF5CFU
 wbUrFzYOHdVC4IdWioZGIjsLYHZ2XRfU7AoBiP26CeDFIZRpDsADsp6ABtBYuP60c7ON
 7lOsO7JWddT4c2p1St7TIoQZP7KdVluXglvFy2A5/Ukm9jWggmXFawgjgAPn7M9561n4
 XcTvciAW0py33P5kb25sJTNzIbMLvRHhsWXvCfquoF36whBRtZMo+jk7LPOnNIvU9/Or
 BSbg==
X-Gm-Message-State: AOJu0YwkQ1FKRfjJYeObUlxk3YdWTScHM3j0SYLKbM0CoJILFqojwK76
 e8XxGx2+UxVJriaMZa5W6SjV5TCleyeBMBvv/+fPmdDDlE4eCQT4QcZyGn5uBPg2HQ+E28NvaVv
 8
X-Gm-Gg: ASbGncvv8vF3Z4xlvqY3W8ZSBGbA1/fAZp+VSna4VrwgTYDYqM+xaPidwXIG7kT4y5p
 SALo5nLeaWhOv3F2GzTpnX8L2i0s6bpq8AUmZnllCk1qhejEb8sOOP6OKD+u3HOxqUP9nDagELZ
 TRt8u0VxTYSD81KInGmO0fwU+g5Df3AsiX5bNSIFFfcXxgABsYplMNxjsq1lmKCqKrelR1ndWL1
 4lPPWTrqvViEXRR+BBhmCSKkxHQXyA7Xca91y0EZWnqqJ0sjI2wZNZgPgpRDivXAUvKvdfcYLW5
 h0FsrM/USnFAwLvPYhbWsC4ejlEw16opQKJogYfK/3BWpFk=
X-Google-Smtp-Source: AGHT+IFxl9RtO/55Ca2MMXORYLkGm2QZutV4PhKMa/P+9sF4u38to1u5ZoLVRXvLpbGKkwD8AYeW+A==
X-Received: by 2002:a17:90b:1a87:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2fc40f10271mr6129561a91.8.1739664084197; 
 Sat, 15 Feb 2025 16:01:24 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/24] tcg/mips: Use 'z' constraint
Date: Sat, 15 Feb 2025 16:01:01 -0800
Message-ID: <20250216000109.2606518-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

Replace target-specific 'Z' with generic 'z'.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/mips/tcg-target-con-set.h | 26 ++++++++++-----------
 tcg/mips/tcg-target-con-str.h |  1 -
 tcg/mips/tcg-target.c.inc     | 44 ++++++++++++++---------------------
 3 files changed, 31 insertions(+), 40 deletions(-)

diff --git a/tcg/mips/tcg-target-con-set.h b/tcg/mips/tcg-target-con-set.h
index 864034f468..06ab04cc4d 100644
--- a/tcg/mips/tcg-target-con-set.h
+++ b/tcg/mips/tcg-target-con-set.h
@@ -10,24 +10,24 @@
  * tcg-target-con-str.h; the constraint combination is inclusive or.
  */
 C_O0_I1(r)
-C_O0_I2(rZ, r)
-C_O0_I2(rZ, rZ)
-C_O0_I3(rZ, r, r)
-C_O0_I3(rZ, rZ, r)
-C_O0_I4(rZ, rZ, rZ, rZ)
-C_O0_I4(rZ, rZ, r, r)
+C_O0_I2(rz, r)
+C_O0_I2(rz, rz)
+C_O0_I3(rz, r, r)
+C_O0_I3(rz, rz, r)
+C_O0_I4(rz, rz, rz, rz)
+C_O0_I4(rz, rz, r, r)
 C_O1_I1(r, r)
-C_O1_I2(r, 0, rZ)
+C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_O1_I2(r, r, rIK)
 C_O1_I2(r, r, rJ)
-C_O1_I2(r, r, rWZ)
-C_O1_I2(r, rZ, rN)
-C_O1_I2(r, rZ, rZ)
-C_O1_I4(r, rZ, rZ, rZ, 0)
-C_O1_I4(r, rZ, rZ, rZ, rZ)
+C_O1_I2(r, r, rzW)
+C_O1_I2(r, rz, rN)
+C_O1_I2(r, rz, rz)
+C_O1_I4(r, rz, rz, rz, 0)
+C_O1_I4(r, rz, rz, rz, rz)
 C_O2_I1(r, r, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rZ, rZ, rN, rN)
+C_O2_I4(r, r, rz, rz, rN, rN)
diff --git a/tcg/mips/tcg-target-con-str.h b/tcg/mips/tcg-target-con-str.h
index 413c280a7a..dfe2b156df 100644
--- a/tcg/mips/tcg-target-con-str.h
+++ b/tcg/mips/tcg-target-con-str.h
@@ -19,4 +19,3 @@ CONST('J', TCG_CT_CONST_S16)
 CONST('K', TCG_CT_CONST_P2M1)
 CONST('N', TCG_CT_CONST_N16)
 CONST('W', TCG_CT_CONST_WSZ)
-CONST('Z', TCG_CT_CONST_ZERO)
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 14b3cb1eba..f8c105ba37 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -184,12 +184,11 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
     g_assert_not_reached();
 }
 
-#define TCG_CT_CONST_ZERO 0x100
-#define TCG_CT_CONST_U16  0x200    /* Unsigned 16-bit: 0 - 0xffff.  */
-#define TCG_CT_CONST_S16  0x400    /* Signed 16-bit: -32768 - 32767 */
-#define TCG_CT_CONST_P2M1 0x800    /* Power of 2 minus 1.  */
-#define TCG_CT_CONST_N16  0x1000   /* "Negatable" 16-bit: -32767 - 32767 */
-#define TCG_CT_CONST_WSZ  0x2000   /* word size */
+#define TCG_CT_CONST_U16  0x100    /* Unsigned 16-bit: 0 - 0xffff.  */
+#define TCG_CT_CONST_S16  0x200    /* Signed 16-bit: -32768 - 32767 */
+#define TCG_CT_CONST_P2M1 0x400    /* Power of 2 minus 1.  */
+#define TCG_CT_CONST_N16  0x800    /* "Negatable" 16-bit: -32767 - 32767 */
+#define TCG_CT_CONST_WSZ  0x1000   /* word size */
 
 #define ALL_GENERAL_REGS  0xffffffffu
 
@@ -204,8 +203,6 @@ static bool tcg_target_const_match(int64_t val, int ct,
 {
     if (ct & TCG_CT_CONST) {
         return 1;
-    } else if ((ct & TCG_CT_CONST_ZERO) && val == 0) {
-        return 1;
     } else if ((ct & TCG_CT_CONST_U16) && val == (uint16_t)val) {
         return 1;
     } else if ((ct & TCG_CT_CONST_S16) && val == (int16_t)val) {
@@ -1666,11 +1663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
     TCGArg a0, a1, a2;
     int c2;
 
-    /*
-     * Note that many operands use the constraint set "rZ".
-     * We make use of the fact that 0 is the ZERO register,
-     * and hence such cases need not check for const_args.
-     */
     a0 = args[0];
     a1 = args[1];
     a2 = args[2];
@@ -2181,14 +2173,14 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
         return C_O1_I2(r, r, rJ);
     case INDEX_op_sub_i32:
     case INDEX_op_sub_i64:
-        return C_O1_I2(r, rZ, rN);
+        return C_O1_I2(r, rz, rN);
     case INDEX_op_mul_i32:
     case INDEX_op_mulsh_i32:
     case INDEX_op_muluh_i32:
@@ -2207,7 +2199,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_remu_i64:
     case INDEX_op_nor_i64:
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
     case INDEX_op_muls2_i32:
     case INDEX_op_mulu2_i32:
     case INDEX_op_muls2_i64:
@@ -2234,35 +2226,35 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, r, ri);
     case INDEX_op_clz_i32:
     case INDEX_op_clz_i64:
-        return C_O1_I2(r, r, rWZ);
+        return C_O1_I2(r, r, rzW);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rZ);
+        return C_O1_I2(r, 0, rz);
     case INDEX_op_brcond_i32:
     case INDEX_op_brcond_i64:
-        return C_O0_I2(rZ, rZ);
+        return C_O0_I2(rz, rz);
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
         return (use_mips32r6_instructions
-                ? C_O1_I4(r, rZ, rZ, rZ, rZ)
-                : C_O1_I4(r, rZ, rZ, rZ, 0));
+                ? C_O1_I4(r, rz, rz, rz, rz)
+                : C_O1_I4(r, rz, rz, rz, 0));
     case INDEX_op_add2_i32:
     case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rZ, rZ, rN, rN);
+        return C_O2_I4(r, r, rz, rz, rN, rN);
     case INDEX_op_setcond2_i32:
-        return C_O1_I4(r, rZ, rZ, rZ, rZ);
+        return C_O1_I4(r, rz, rz, rz, rz);
     case INDEX_op_brcond2_i32:
-        return C_O0_I4(rZ, rZ, rZ, rZ);
+        return C_O0_I4(rz, rz, rz, rz);
 
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_st_i32:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
     case INDEX_op_qemu_ld_i64:
         return TCG_TARGET_REG_BITS == 64 ? C_O1_I1(r, r) : C_O2_I1(r, r, r);
     case INDEX_op_qemu_st_i64:
-        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rZ, r) : C_O0_I3(rZ, rZ, r);
+        return TCG_TARGET_REG_BITS == 64 ? C_O0_I2(rz, r) : C_O0_I3(rz, rz, r);
 
     default:
         return C_NotImplemented;
-- 
2.43.0


