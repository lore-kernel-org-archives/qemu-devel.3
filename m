Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FCC8C48286
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Feb 2024 21:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWkFL-0002XD-4X; Sun, 04 Feb 2024 16:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFH-0002WX-KB
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:47 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rWkFF-0003YW-6j
 for qemu-devel@nongnu.org; Sun, 04 Feb 2024 16:41:46 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d780a392fdso32533585ad.3
 for <qemu-devel@nongnu.org>; Sun, 04 Feb 2024 13:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707082903; x=1707687703; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CxoD/ygedGQlZZ8hQ+rOVALVQqC62zieEa9yKFNrZc=;
 b=U7UcnqYrqOm8eF34pC/W3tmb6nM7Zm4XqydlyaogPsFtzIFL4iYEH76VImqRWQxjda
 OYkg2hweShtz5yOj62TYTaE0EqsDgBqif9C5B+DPfnCCEvadE0oNy3DY+U5DjbUO9OA6
 jakXqA3KyvOJS2Fk9oggShZ8KzqD+gcpOPTNu+g1pOwiMAaNGSh5kuEkrmfkxWSFxu9t
 gOMIELvZR6IBvkhrgCuCNiEEQc67xYqAviXs7Au7q1mdnMYVicxHL8X851zCdPjD2psK
 2aEdezvYUlPC+xPkxnrBl/UdzKsoqsBQ+HPBqS6Ij+Qzmk1RxKrf5RRCBr+oFYMeqLsF
 wzLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707082903; x=1707687703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CxoD/ygedGQlZZ8hQ+rOVALVQqC62zieEa9yKFNrZc=;
 b=D2I05lP4PdMT1zz85XcOVV6CU8iQCR+VaMQGlREziymEgWD55S7V8XeCH+ktWOKDAB
 xgoNsyCAT9KWhMI20PWNZNuCBTF5PgxFALyhZU8Othzo5H4tDBiCEx6kq+/3fQ34oLz0
 6s+ONeYNJJ3vK9yJPw/dY1sgEQeVR4u4aT0Dzbub2LHU8EQjoUOt7OylQBVOmlHlz4p/
 /nfcaPL5+TX2/KAuIJFp+5FgJxjuPF+lHgUPNGMCLD4AhO3joj1KeUKMCfQuhQkyVe5Z
 tKTR8wBnGA1DRBA8diA2DQ0afen5IkXWibRK5y48ELkb1GjbU9dleVhbkybeaBIv+T3t
 rzFw==
X-Gm-Message-State: AOJu0YwOHNxVcUbPHcuv1ZYaPPiZyfiVWDH70uWaxQ/vdIqPJATe9Gqu
 Zt/GYGQBJmtqVr84XGg7xRatJx507ITLRvkHLuYp7RQsshJA+AzKkEvifVsGGnSFauq+p32+IlC
 Z2RU=
X-Google-Smtp-Source: AGHT+IFxkKST9ECYf+kas3oMcACATYsIIpenZj29d/FUOGkutCzWkXoBRMj/QDdmqIBP+QuyjCuucw==
X-Received: by 2002:a17:902:e88f:b0:1d9:bc11:66e with SMTP id
 w15-20020a170902e88f00b001d9bc11066emr703029plg.37.1707082902853; 
 Sun, 04 Feb 2024 13:41:42 -0800 (PST)
Received: from stoup.. ([43.252.112.156]) by smtp.gmail.com with ESMTPSA id
 mf11-20020a170902fc8b00b001d8f5560503sm4953670plb.222.2024.02.04.13.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Feb 2024 13:41:42 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/39] tcg/arm: Support TCG_COND_TST{EQ,NE}
Date: Mon,  5 Feb 2024 07:40:35 +1000
Message-Id: <20240204214052.5639-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240204214052.5639-1-richard.henderson@linaro.org>
References: <20240204214052.5639-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231028194522.245170-12-richard.henderson@linaro.org>
[PMD: Split from bigger patch, part 2/2]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20231108145244.72421-2-philmd@linaro.org>
---
 tcg/arm/tcg-target.h     |  2 +-
 tcg/arm/tcg-target.c.inc | 29 ++++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/tcg/arm/tcg-target.h b/tcg/arm/tcg-target.h
index 7bf42045a7..a43875cb09 100644
--- a/tcg/arm/tcg-target.h
+++ b/tcg/arm/tcg-target.h
@@ -125,7 +125,7 @@ extern bool use_neon_instructions;
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
-#define TCG_TARGET_HAS_tst              0
+#define TCG_TARGET_HAS_tst              1
 
 #define TCG_TARGET_HAS_v64              use_neon_instructions
 #define TCG_TARGET_HAS_v128             use_neon_instructions
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index 4ea17845bb..ffd23ef789 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -1194,7 +1194,27 @@ static void tcg_out_mb(TCGContext *s, TCGArg a0)
 static TCGCond tcg_out_cmp(TCGContext *s, TCGCond cond, TCGReg a,
                            TCGArg b, int b_const)
 {
-    tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+    if (!is_tst_cond(cond)) {
+        tcg_out_dat_rIN(s, COND_AL, ARITH_CMP, ARITH_CMN, 0, a, b, b_const);
+        return cond;
+    }
+
+    cond = tcg_tst_eqne_cond(cond);
+    if (b_const) {
+        int imm12 = encode_imm(b);
+
+        /*
+         * The compare constraints allow rIN, but TST does not support N.
+         * Be prepared to load the constant into a scratch register.
+         */
+        if (imm12 >= 0) {
+            tcg_out_dat_imm(s, COND_AL, ARITH_TST, 0, a, imm12);
+            return cond;
+        }
+        tcg_out_movi32(s, COND_AL, TCG_REG_TMP, b);
+        b = TCG_REG_TMP;
+    }
+    tcg_out_dat_reg(s, COND_AL, ARITH_TST, 0, a, b, SHIFT_IMM_LSL(0));
     return cond;
 }
 
@@ -1225,6 +1245,13 @@ static TCGCond tcg_out_cmp2(TCGContext *s, const TCGArg *args,
         tcg_out_dat_rI(s, COND_EQ, ARITH_CMP, 0, al, bl, const_bl);
         return cond;
 
+    case TCG_COND_TSTEQ:
+    case TCG_COND_TSTNE:
+        /* Similar, but with TST instead of CMP. */
+        tcg_out_dat_rI(s, COND_AL, ARITH_TST, 0, ah, bh, const_bh);
+        tcg_out_dat_rI(s, COND_EQ, ARITH_TST, 0, al, bl, const_bl);
+        return tcg_tst_eqne_cond(cond);
+
     case TCG_COND_LT:
     case TCG_COND_GE:
         /* We perform a double-word subtraction and examine the result.
-- 
2.34.1


