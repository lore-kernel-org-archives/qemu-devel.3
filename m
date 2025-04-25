Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECC2C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:22:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RCj-00005h-My; Fri, 25 Apr 2025 18:07:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAq-0003er-HH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:39 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8RAn-0001q4-II
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:05:31 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-736c277331eso3830461b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618728; x=1746223528; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iIgsM45b/QDIOPbNEdZby6PszUYx14mn+jSOMJ0q4ik=;
 b=Rp2mDmqqpEsVGZWRMjD4vpuaVABx4KBMxC6pKs3b8rc4CNUjBNviU3ee+jVTOSM4TC
 hiikpIz2qZU2+xpaPsseh6m+PzcOeL1jihNshsbhmvM/hmezqt/6LKKd+/qfaZgLpOF/
 dO3zSvYI6GAK4fVfztViU8/3WQKTggal9gNNa1H8VCqODEpatcW2vq6GRNeX6s8NagiG
 pVvadsa5C7Qz4AqG+lEZgKYwuGbhNVs9/Ag6cvhpb2X5aQr8WLPe7KFXZzlCFDzy//tL
 SMTK5WIt4zGGMgk9C706IQ9S4jdJ4LS10y2xGh20Jwjq5fxzCn651JbcPPtP08+8JS+e
 RLIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618728; x=1746223528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iIgsM45b/QDIOPbNEdZby6PszUYx14mn+jSOMJ0q4ik=;
 b=xK/JjO2vDH+IDoxVaHx57L+0o4Q/xYCcaKRlCXFyV4F4XBgt0qQownR8ZjTPsOoE5u
 t3n5imdUBszmVPC3+bLCwlT0GENW36sdl+pLzIXxIq0Rzh9cWHoDoD8cWuPwtITledHP
 TFz0v7k/rcF9yB5rv8Zzm8DJGiqS3lTBCGeRe6n0WbqtKt37s3K1MrXt1khUdQ8VRp4/
 Cz6BehigDe917GWuiNIO9ryNX8LvNZSgJP4yvpw51Dvfujh+Pq/rZw/2LpbrIZDZGXSy
 0wq4X9xzQoshLs0sIbiBJwmnsCqzBiglgjaGv+S6doTqGO9Q+4T6dAWOmkt/LnsyFGlD
 8aPQ==
X-Gm-Message-State: AOJu0Yzwkz6gS40SGHq5/jI4CxOkQ27jDf5ARzC9st42b8l6qiq7QAb6
 Qm9DGhq2j6i4j7uwC5V4x7cW1fL+zsxgOzut7wc/yWAYIsed0UKKNEXOgAE4X9bXwX4ttWtB/tg
 p
X-Gm-Gg: ASbGncuLYwHJv71A615T/qWq6EWYaYABS2jyp48iHQX8wCV7NS+Y7Nmkc7Rm9yKtw2p
 dwQr6EclaQsnukvHh4pGZj77Tza+9A9MfHXwExmohy+i1abRy8ilInG7rpad4/M9ll+f0r2mGY7
 w6aHUSwF5aQ2Q8lZa9qXiM2YQCewoExEailOnA3kHDg8XJkPeXccH5ZQSK8qsqMXgaZc63kF2yc
 yg59Z4V4zAkVK8OxBxBqFH22z7b/+Jc11H1e31omndm/9UWAv2qI5b1GDP8eI6nMZEdiz4vqt08
 DfYr0+G9JAlPKTcfuGVmnfzFzmUp2HVKb37qaT1t1c8QazWp8bCgbuQNt8JFESyeN0yMqETJWU8
 =
X-Google-Smtp-Source: AGHT+IE1QeqfTop7YxZPpKgI6mLr485e6R4CJgpyHIKxvB1GHKmHHvcz6cqlztend6IuDLRHK8EjUg==
X-Received: by 2002:a05:6a21:9993:b0:1f3:3864:bbe0 with SMTP id
 adf61e73a8af0-2045b40ff06mr5175332637.8.1745618727879; 
 Fri, 25 Apr 2025 15:05:27 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a49esm3796573b3a.106.2025.04.25.15.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:05:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 125/159] tcg/i386: Special case addci r, 0, 0
Date: Fri, 25 Apr 2025 14:54:19 -0700
Message-ID: <20250425215454.886111-126-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Using addci with two zeros as input in order to capture the value
of the carry-in bit is common.  Special case this with sbb+neg so
that we do not have to load 0 into a register first.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/i386/tcg-target-con-set.h |  1 +
 tcg/i386/tcg-target.c.inc     | 46 ++++++++++++++++++++++++++++++++---
 2 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/tcg/i386/tcg-target-con-set.h b/tcg/i386/tcg-target-con-set.h
index 85c93836bb..458d69c3c0 100644
--- a/tcg/i386/tcg-target-con-set.h
+++ b/tcg/i386/tcg-target-con-set.h
@@ -45,6 +45,7 @@ C_O1_I2(r, L, L)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, re)
 C_O1_I2(r, r, ri)
+C_O1_I2(r, rO, re)
 C_O1_I2(x, x, x)
 C_N1_I2(r, r, r)
 C_N1_I2(r, r, rW)
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 44f9afc0d6..da05f13b21 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -2670,10 +2670,50 @@ static const TCGOutOpBinary outop_addcio = {
     .out_rri = tgen_addcio_imm,
 };
 
+static void tgen_addci_rrr(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, TCGReg a2)
+{
+    /* Because "0O" is not a valid constraint, we must match ourselves. */
+    if (a0 == a2) {
+        tgen_addcio(s, type, a0, a0, a1);
+    } else {
+        tcg_out_mov(s, type, a0, a1);
+        tgen_addcio(s, type, a0, a0, a2);
+    }
+}
+
+static void tgen_addci_rri(TCGContext *s, TCGType type,
+                           TCGReg a0, TCGReg a1, tcg_target_long a2)
+{
+    tcg_out_mov(s, type, a0, a1);
+    tgen_addcio_imm(s, type, a0, a0, a2);
+}
+
+static void tgen_addci_rir(TCGContext *s, TCGType type,
+                           TCGReg a0, tcg_target_long a1, TCGReg a2)
+{
+    tgen_addci_rri(s, type, a0, a2, a1);
+}
+
+static void tgen_addci_rii(TCGContext *s, TCGType type, TCGReg a0,
+                           tcg_target_long a1, tcg_target_long a2)
+{
+    if (a2 == 0) {
+        /* Implement 0 + 0 + C with -(x - x - c). */
+        tgen_arithr(s, ARITH_SBB, a0, a0);
+        tcg_out_modrm(s, OPC_GRP3_Ev, EXT3_NEG, a0);
+    } else {
+        tcg_out_movi(s, type, a0, a2);
+        tgen_addcio_imm(s, type, a0, a0, a1);
+    }
+}
+
 static const TCGOutOpAddSubCarry outop_addci = {
-    .base.static_constraint = C_O1_I2(r, 0, re),
-    .out_rrr = tgen_addcio,
-    .out_rri = tgen_addcio_imm,
+    .base.static_constraint = C_O1_I2(r, rO, re),
+    .out_rrr = tgen_addci_rrr,
+    .out_rri = tgen_addci_rri,
+    .out_rir = tgen_addci_rir,
+    .out_rii = tgen_addci_rii,
 };
 
 static void tcg_out_set_carry(TCGContext *s)
-- 
2.43.0


