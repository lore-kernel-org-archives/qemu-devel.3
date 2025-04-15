Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACF8C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:26:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mBm-0001Nl-3k; Tue, 15 Apr 2025 15:43:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5k-0008Tb-8A
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:18 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m4r-0004Mb-LA
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:07 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736a7e126c7so5196896b3a.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745760; x=1745350560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rdL/nJvaFvGesQEXPrFnMcsnPRIPWLphsos0Op/Pykw=;
 b=kNeUJnUumFx9hA4wAW3/C2qBClOJjWf/gQRjUYtjMmlOFRmRXOyofivwGotM5lRxmV
 d1yu7ihWUr2JLLqgcEtoWP4s4jA5xFZlXZUZbgekp1oABswppNRd6+0SOo4U72qD9aWH
 1Za+ZEEZhf92M94CFapMGDafc0o5UDcjvEBhLyZspjEjTEjBu6Qta3JGFVOuDJ8OvkgE
 +dznMDy4Dl06GrueVHJ3/EevDIDg9vqvsM2r8CV06SmIP5CHZjLjYgdTSmPkP1MAkzcN
 3WpgCcGUfUKSY4+ScfoWcdbBYMUidmcsNqz+PpI9O8NsUFa4pPPpoBH/vRKNqWbSHF/f
 szog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745760; x=1745350560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rdL/nJvaFvGesQEXPrFnMcsnPRIPWLphsos0Op/Pykw=;
 b=IRjLfw3ZgXFwDaMWrW0+3//QvOtBXeWvnUKNvJJDbeqxHmF9EvosjSiNX7h5mgN+US
 74hHtFLjvXaPjaxcDcnXDe9+dpVRKaRjEA3aA7y5Bs9uB+IddaunWspuNErZ1ZEfaCgH
 E42S1blslfMzqSeXMUF2y7CDPDofD2gAy3S0ivhlPnfAjeY93lycXpmvQOdPkY0BUslo
 7KZb1j5OoW/XTh7n+dQ4rRYaCwfVrzVAGcusDuNUSA9yR2gPD7A9rTQWedWDenhObxd+
 8k9FpBHO6kGSBQ88j5NZ6FBywC/be6L7WO1YQvVE66xGqgPIK21JQOSW9CHpfY/iKUaP
 I3BQ==
X-Gm-Message-State: AOJu0YwSmIvgN7dkVsBLtxkTg2fjhGGJwVKEfx4MFYq8FLF2P3P08Cai
 8TilyRWtWfAVSQGWWodqdwJHH1IUXO4SSHB0Ee1CtM2fQCRfI8CZud1wNOIHcmmMkxyZCgrXjdD
 7
X-Gm-Gg: ASbGncszj/FT6XjyGaxHnut26rSB3qSZ8+2795MZTD3hUn4BwYv1UrH7bxIl+0uKvAT
 372UStlQ8Hxmn6ptYnoG17S8gRgOqm84tDSLB+qk9yzoUEjDDRrIQ9bCIx5CceliG6hZyO/k7x2
 9THR6NC01vVKGZ4DWiG/OcagzDQYl0JDTwbSO3clT9fmikb9/9/GmwGg1JqHmDrQ0earKglG1rx
 c/t43Vea+w9ovJNcbPEBdhd8zviF35e3/xdvUO00uWJcU5Dfu7Qg/v9zcGyErj7TrPyYa7hgK4O
 Wf80vzI7uRd7cZonUTnib8WZyCS7Jae6g6JeqTPYMKncwEOKuEp+yjnFZDEwN16/6to3I5k7hJI
 =
X-Google-Smtp-Source: AGHT+IGaMwRtRupxuIXd+/w16opUI42JxlcYW5LzDcSuFL9nJb44Q5qKqzdFrLyMs/c/VeRKKESpow==
X-Received: by 2002:a05:6a00:2e1b:b0:736:4fe0:2661 with SMTP id
 d2e1a72fcca58-73c1f9235b2mr846267b3a.11.1744745759723; 
 Tue, 15 Apr 2025 12:35:59 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.35.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:35:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 122/163] tcg/i386: Special case addci r, 0, 0
Date: Tue, 15 Apr 2025 12:24:33 -0700
Message-ID: <20250415192515.232910-123-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
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

Using addci with two zeros as input in order to capture the value
of the carry-in bit is common.  Special case this with sbb+neg so
that we do not have to load 0 into a register first.

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


