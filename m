Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D56C7CCD195
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 18:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAY96-00059L-PB; Sun, 19 Oct 2025 14:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY95-00058x-N0
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:43 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vAY92-0000ZP-9S
 for qemu-devel@nongnu.org; Sun, 19 Oct 2025 14:28:42 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-290ac2ef203so34512245ad.1
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 11:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760898518; x=1761503318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+klw1qSTazAtmpLZcTp4xmaIM2w3pdybISxZjtuBn6w=;
 b=HkKKXcCzFnyf6lS070d07NX716Z4wqaZvs1C29hYLKDX5+b9iXbH4PtSHxIfERvkcF
 W451kuy4wVIka200PiXR+/DboRbbt1U0nJtoMxLXYHQYMgWZzkCvDBIoXMIV5MF61nsi
 eMrk59MDkYqk2HCuh0mfWF4i3NgkTUzfavGDkQdVoEHYo5lbNjRcj4oe/ht0FegnN2qd
 7yfqZBz4y7UfiXUZs/pcRVp5OLnOmsJzxlCXxgtHpiNfsA8GEXTwDUbW6Uoyn41Hxm5C
 1TwvUlUNGl0RNGN6Aa+HtnifS5KtTOjbXI+k8tAjoQkBy4yIewtwAU1qxa/Xineb1Ix3
 cTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760898518; x=1761503318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+klw1qSTazAtmpLZcTp4xmaIM2w3pdybISxZjtuBn6w=;
 b=eLtMk7+y1Sll5vwcIK5NoJDUuOY+HdMBlEACmp3ZSO1ufDJViLuVBqzBOEbNWCvyCm
 l1sji5mEy5m1U07toSfjnaH3sCqLBY+tSP7JFhA+qpk+4hC+/owKCBOwQhr/oSlzG4yc
 NHM4DiSZsG0EI1tqzyG6xwrjXPD+yEe6OTl7ISPr8q1CUw5vfc/hEi4MF2H7bEATxGbm
 HCCdHx+pCzAwTGjKG7pQQTCP4PMedO1K8VLIRZ4RkToUys2qNe/z5A8P7fACIwcevy7p
 w3Ve+wNw7Lrc6d3eHr7VtV7xOn4oqwH3CR0TwKfm3y9q17bU/G4EbKG6sNvJfA6RHgIi
 ZPmA==
X-Gm-Message-State: AOJu0YzkopU14EUqW2J7o+l6nZGoT41khoXvuTWcbLfXRSLykJ2APa2y
 uetjUItyqg0p1BqViYEqe0iS6gvsMGSnCYMObc7ZFVaSdEKMJgx3xFUbMT/RjkSQCzubKsaUAxW
 4udYuv3M=
X-Gm-Gg: ASbGncvuewNYUByR+DPMBNprA5DFn8F0TP4GbaXmtNwVOBOS3uW1IYV/neNfjHRUmj/
 uB8Rv6p+3eOrrNU2ndzS3y4dSUVWKylmeCbjiXLrp+rEUT7WMwzdCTP8Qvlxe+m0G97rFCEezgO
 iVwMsnDZZpmKRUW7w+7iypWjgTKgSNwN9J+FEhalDa+Xu/+k7in5BnOz7McRCnrIzneoQDDWM03
 ZpkXJHTE3vSjp0TStw4rRgpHWlbrR2Ce91va0Ccuy2WD/+TvciogwDKsd5jMbk2W0i0Uyvrmq96
 b7zSshCzY0ZdxOF8R0EkAv2Jr+/OFhtFYhU4lejgZBHxcDDcQs/beIDYO35PzRn1dCjTQ1dZSnj
 d9JTM7nXhix6SFEWHdIetKBMPL7/kjbsUZ9a3ny3fffzkIuaHzkKqAMM6s2gsr36WtWNE87/1C7
 ltG6dCxcfNVxU75SyO
X-Google-Smtp-Source: AGHT+IGo+UP26dFHhUxD2YZmI8pWarIH54DEWupyCvV743y98VsXi1k1YlDHtEH9EBR/kvnKGowZkQ==
X-Received: by 2002:a17:903:2408:b0:27e:ea82:5ce8 with SMTP id
 d9443c01a7336-290c9ca6afbmr141854675ad.14.1760898518513; 
 Sun, 19 Oct 2025 11:28:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29246ebccf3sm58985775ad.1.2025.10.19.11.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 11:28:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/9] tcg/mips: Remove support for O32 and N32 ABIs
Date: Sun, 19 Oct 2025 11:28:29 -0700
Message-ID: <20251019182834.481541-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251019182834.481541-1-richard.henderson@linaro.org>
References: <20251019182834.481541-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

See previous commit for rationale.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20251009195210.33161-5-philmd@linaro.org>
---
 tcg/mips/tcg-target-reg-bits.h           |  8 ++----
 common-user/host/mips/safe-syscall.inc.S | 35 ------------------------
 tcg/mips/tcg-target.c.inc                | 26 ++++--------------
 3 files changed, 9 insertions(+), 60 deletions(-)

diff --git a/tcg/mips/tcg-target-reg-bits.h b/tcg/mips/tcg-target-reg-bits.h
index 56fe0a725e..ee346a3f25 100644
--- a/tcg/mips/tcg-target-reg-bits.h
+++ b/tcg/mips/tcg-target-reg-bits.h
@@ -7,12 +7,10 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if _MIPS_SIM == _ABIO32
-# define TCG_TARGET_REG_BITS 32
-#elif _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
-# define TCG_TARGET_REG_BITS 64
-#else
+#if !defined(_MIPS_SIM) || _MIPS_SIM != _ABI64
 # error "Unknown ABI"
 #endif
 
+#define TCG_TARGET_REG_BITS 64
+
 #endif
diff --git a/common-user/host/mips/safe-syscall.inc.S b/common-user/host/mips/safe-syscall.inc.S
index 6a44614970..3b196cc634 100644
--- a/common-user/host/mips/safe-syscall.inc.S
+++ b/common-user/host/mips/safe-syscall.inc.S
@@ -30,15 +30,9 @@
          * arguments being syscall arguments (also 'long').
          */
 
-#if _MIPS_SIM == _ABIO32
-/* 8 * 4 = 32 for outgoing parameters; 1 * 4 for s0 save; 1 * 4 for align. */
-#define FRAME    40
-#define OFS_S0   32
-#else
 /* 1 * 8 for s0 save; 1 * 8 for align. */
 #define FRAME    16
 #define OFS_S0   0
-#endif
 
 
 NESTED(safe_syscall_base, FRAME, ra)
@@ -47,34 +41,6 @@ NESTED(safe_syscall_base, FRAME, ra)
         .cfi_adjust_cfa_offset FRAME
         REG_S   s0, OFS_S0(sp)
         .cfi_rel_offset s0, OFS_S0
-#if _MIPS_SIM == _ABIO32
-        /*
-         * The syscall calling convention is nearly the same as C:
-         * we enter with a0 == &signal_pending
-         *               a1 == syscall number
-         *               a2, a3, stack == syscall arguments
-         *               and return the result in a0
-         * and the syscall instruction needs
-         *               v0 == syscall number
-         *               a0 ... a3, stack == syscall arguments
-         *               and returns the result in v0
-         * Shuffle everything around appropriately.
-         */
-        move    s0, a0          /* signal_pending pointer */
-        move    v0, a1          /* syscall number */
-        move    a0, a2          /* syscall arguments */
-        move    a1, a3
-        lw      a2, FRAME+16(sp)
-        lw      a3, FRAME+20(sp)
-        lw      t4, FRAME+24(sp)
-        lw      t5, FRAME+28(sp)
-        lw      t6, FRAME+32(sp)
-        lw      t7, FRAME+40(sp)
-        sw      t4, 16(sp)
-        sw      t5, 20(sp)
-        sw      t6, 24(sp)
-        sw      t7, 28(sp)
-#else
         /*
          * The syscall calling convention is nearly the same as C:
          * we enter with a0 == &signal_pending
@@ -95,7 +61,6 @@ NESTED(safe_syscall_base, FRAME, ra)
         move    a3, a5
         move    a4, a6
         move    a5, a7
-#endif
 
         /*
          * This next sequence of code works in conjunction with the
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 400eafbab4..4d9d029844 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -26,16 +26,10 @@
 
 /* used for function call generation */
 #define TCG_TARGET_STACK_ALIGN        16
-#if _MIPS_SIM == _ABIO32
-# define TCG_TARGET_CALL_STACK_OFFSET 16
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_EVEN
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_BY_REF
-#else
-# define TCG_TARGET_CALL_STACK_OFFSET 0
-# define TCG_TARGET_CALL_ARG_I64      TCG_CALL_ARG_NORMAL
-# define TCG_TARGET_CALL_RET_I128     TCG_CALL_RET_NORMAL
-#endif
+#define TCG_TARGET_CALL_STACK_OFFSET  0
 #define TCG_TARGET_CALL_ARG_I32       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_ARG_I64       TCG_CALL_ARG_NORMAL
+#define TCG_TARGET_CALL_RET_I128      TCG_CALL_RET_NORMAL
 #define TCG_TARGET_CALL_ARG_I128      TCG_CALL_ARG_EVEN
 
 #if TCG_TARGET_REG_BITS == 32
@@ -135,12 +129,10 @@ static const TCGReg tcg_target_call_iarg_regs[] = {
     TCG_REG_A1,
     TCG_REG_A2,
     TCG_REG_A3,
-#if _MIPS_SIM == _ABIN32 || _MIPS_SIM == _ABI64
     TCG_REG_T0,
     TCG_REG_T1,
     TCG_REG_T2,
     TCG_REG_T3,
-#endif
 };
 
 static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
@@ -1053,17 +1045,11 @@ static void tcg_out_call_int(TCGContext *s, const tcg_insn_unit *arg, bool tail)
      * Note that __mips_abicalls requires the called function's address
      * to be loaded into $25 (t9), even if a direct branch is in range.
      *
-     * For n64, always drop the pointer into the constant pool.
-     * We can re-use helper addresses often and do not want any
-     * of the longer sequences tcg_out_movi may try.
+     * We can re-use helper addresses often; always drop the pointer
+     * into the constant pool.
      */
-    if (sizeof(uintptr_t) == 8) {
-        tcg_out_movi_pool(s, TCG_REG_T9, (uintptr_t)arg, TCG_REG_TB);
-    } else {
-        tcg_out_movi(s, TCG_TYPE_PTR, TCG_REG_T9, (uintptr_t)arg);
-    }
+    tcg_out_movi_pool(s, TCG_REG_T9, (uintptr_t)arg, TCG_REG_TB);
 
-    /* But do try a direct branch, allowing the cpu better insn prefetch.  */
     if (tail) {
         if (!tcg_out_opc_jmp(s, OPC_J, arg)) {
             tcg_out_opc_reg(s, OPC_JR, 0, TCG_REG_T9, 0);
-- 
2.43.0


