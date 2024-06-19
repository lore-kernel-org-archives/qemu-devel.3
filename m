Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE30C41513
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 21:02:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sK2PS-0002Bh-ON; Wed, 19 Jun 2024 17:00:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PQ-0002Ad-P7
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:00 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sK2PP-0000Jb-0z
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 17:00:00 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f6fabe9da3so1747425ad.0
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 13:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718830797; x=1719435597; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hRI+iU8AoyX8CSaqkMr42RrHAGDYxA7DtYX1JOZeQXQ=;
 b=o8aDzx1sEFnKy7+asrBgPek3J3U0+D8o+A/9Fo8l7B66o8xOPaM4Cr8pA5OakA/0G3
 fB74MtxuTb8VCcFDtRAuank6G+5NfGZBtIfTGexT4OLPEcjoPZuasnMKYZCrdQzu4QG0
 LTJ5G3x4UTq6PXdOzxV+ao9/q25oRkI6hqXfweaxqzub0KfWargkQNrt/v5WOH/HPXjw
 6o2ybKdzqNFrqI2aCCDbFdWtk0PJFQghP5q5OiTT1Wx3PGNrV5Y92v5i97vxBJ5I0noH
 VC9P3WBuFJ6LjzyAdEI79mlGlf8t505w9r68bsQ9FKGv6ypl1pXkwst/mbmGeTECbxAu
 yoyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718830797; x=1719435597;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hRI+iU8AoyX8CSaqkMr42RrHAGDYxA7DtYX1JOZeQXQ=;
 b=GBPiqt8iz6X81+lE4RRqBpCnNukI0TuED2AS1rorLjAR0+s3MkiQdCjrewzGCT9dLF
 tlS3twB3qxKYg3e5i5iVL0Az3v1eb1hymYq2vZ2rBf5UA9/aIdiFJbTwuhFv+TpcwWIy
 H8fFmlANTVU9V57nBUruRuh/Aquh2Q2fUm5N4LXgBPhI5vypVCAXSKH+XOl1wqC4jOux
 inD/Qb6CnE0sVV//qVHyBwms2rmtyLMbI1/mFqwMVQFKLGgQS0CGI/oa/C8Fc1M/tiAD
 3fY1WasftA7PCE0FpqOYz/HMa3OHMq7lOGrB9wk8UMXlLwjsuFVzn64hl9Z3HRJcmE1O
 OHYQ==
X-Gm-Message-State: AOJu0YyNGHYFMmhalJHWTwFIPmlfp01Yuvr7QupKbGFmKfDSVx00gFeZ
 Dh+KPgzxifYNhryELmsia/cG5WXsjv5o4GoSOKtEIhX7da6dPfv6YR1H/0Rkcr4cz7dMCztdqB2
 a
X-Google-Smtp-Source: AGHT+IGIGXzjtKqqN1tc3yHA3aOPWmsoeMcKUn3cGHNBmmoLBn6P49PpJMX4fU2gbs50WEb+WSyOzQ==
X-Received: by 2002:a17:903:22d1:b0:1f6:e20f:86ab with SMTP id
 d9443c01a7336-1f9aa44c98cmr37708065ad.40.1718830797361; 
 Wed, 19 Jun 2024 13:59:57 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f98f8f8c42sm39183765ad.162.2024.06.19.13.59.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 13:59:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 04/24] tcg/loongarch64: Support TCG_TYPE_V64
Date: Wed, 19 Jun 2024 13:59:32 -0700
Message-Id: <20240619205952.235946-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240619205952.235946-1-richard.henderson@linaro.org>
References: <20240619205952.235946-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We can implement this with fld_d, fst_d for load and store,
and then use the normal v128 operations in registers.
This will improve support for guests which use v64.

Reviewed-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target.h     | 2 +-
 tcg/loongarch64/tcg-target.c.inc | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tcg/loongarch64/tcg-target.h b/tcg/loongarch64/tcg-target.h
index 29e4860d20..990bad1d51 100644
--- a/tcg/loongarch64/tcg-target.h
+++ b/tcg/loongarch64/tcg-target.h
@@ -171,7 +171,7 @@ typedef enum {
 
 #define TCG_TARGET_HAS_tst              0
 
-#define TCG_TARGET_HAS_v64              0
+#define TCG_TARGET_HAS_v64              (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v128             (cpuinfo & CPUINFO_LSX)
 #define TCG_TARGET_HAS_v256             0
 
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index de5369536e..980ea10211 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -321,6 +321,7 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
             }
         }
         break;
+    case TCG_TYPE_V64:
     case TCG_TYPE_V128:
         tcg_out_opc_vori_b(s, ret, arg, 0);
         break;
@@ -838,6 +839,7 @@ static void tcg_out_ld(TCGContext *s, TCGType type, TCGReg dest,
         }
         break;
     case TCG_TYPE_I64:
+    case TCG_TYPE_V64:
         if (dest < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_LD_D, dest, base, offset);
         } else {
@@ -869,6 +871,7 @@ static void tcg_out_st(TCGContext *s, TCGType type, TCGReg src,
         }
         break;
     case TCG_TYPE_I64:
+    case TCG_TYPE_V64:
         if (src < TCG_REG_V0) {
             tcg_out_ldst(s, OPC_ST_D, src, base, offset);
         } else {
@@ -1880,8 +1883,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
     a3 = args[3];
 
-    /* Currently only supports V128 */
-    tcg_debug_assert(type == TCG_TYPE_V128);
+    /* Currently only supports V64 & V128 */
+    tcg_debug_assert(type == TCG_TYPE_V64 || type == TCG_TYPE_V128);
 
     switch (opc) {
     case INDEX_op_st_vec:
@@ -2394,6 +2397,7 @@ static void tcg_target_init(TCGContext *s)
     tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_S9);
 
     if (cpuinfo & CPUINFO_LSX) {
+        tcg_target_available_regs[TCG_TYPE_V64] = ALL_VECTOR_REGS;
         tcg_target_available_regs[TCG_TYPE_V128] = ALL_VECTOR_REGS;
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V24);
         tcg_regset_reset_reg(tcg_target_call_clobber_regs, TCG_REG_V25);
-- 
2.34.1


