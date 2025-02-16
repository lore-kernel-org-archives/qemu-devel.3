Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DACAC021A4
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnx6-00051Y-C6; Sun, 16 Feb 2025 18:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwS-000411-Mo
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:54 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwN-0006Q4-7P
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:20:52 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fc042c9290so5766680a91.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748045; x=1740352845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=oweoh/ly2xxaqtOtY0fO+GuPfxQDYg6/wwMLRxJoe6s=;
 b=dV/N16DaW3qavpM/9c8Tui4E67i5p1YGBz0j9cXxWLLA13e5Aj1sKKDYr7fsRQF9Dy
 QFEm4FkVOxkIcnBQ0YDfSeBX6xgzDwLUhsG+14G9VOqerCtnY6RBJJFMyJA06QvE3IgY
 biQSrEFu/ZnuwYXhrNlg4ott1yvqgyw7HVCnu5KY7QeMxgurGADcUJkbJsh6AZ8ve8sQ
 Qq51xSBwZ6ywVUoYNzD7dIMC6td31CgY6sacB1M81QyXBdaKed7eziS5BPffQB+8fJpJ
 rioAsXV9maJenfqYg3PI7hxBItP7uG7LUYdtWg0r4rX8SlLdFdcDLp/dYUWkdtHId4YD
 U02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748045; x=1740352845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oweoh/ly2xxaqtOtY0fO+GuPfxQDYg6/wwMLRxJoe6s=;
 b=CIJ73hIzQjStB8kxQx3+uAGgbvWGsmtlTNnmx4PW09tZ9O9MviTzyGNzpHNdU63i4t
 Qy3tCGa84ulZHz27iM1M7OJy4h6za6xUtfb3bKYH778vV0C9h2Px62yoHBeB032siGbq
 15P2+AtH37GJCO/EMRucXMcTY3wk9RRhQojOSTWaSORVL6jK+Eg6UV+APq+Q2vl4hBDq
 MPlRjTpwsMivqYzIHB1QBcULpCO8i3cDCCSpe5nAnVuix8Es0dNtpfzYb+T+acyekdM4
 3j0Vj+I+2M7X2gUzIHVeeV4uCMXrM6Y6WrwNBJL+it21utgYkAC6/Dew8KcT9OiE8+Qm
 H8Vw==
X-Gm-Message-State: AOJu0Yz6tjTCoEA7d9ou31AKaeW8YvfV9rM6GUh9VJsLX+1froLrN+tb
 +1l5NTbAxrFGDSOOMtzrlafdFHtE1oTxM0ODF/ZiNYvlfuYqGgq9/Qn02cVqiA7HKFBPBeEFPUB
 4
X-Gm-Gg: ASbGnct+X5xwg4FQ3WhTYDL7PzIJGrzhsQ+gPCGO+53agRcKTOglwjj5UWeI7E/lgGA
 sxw0a5rl/1GJslhIljwym6hEcKfUQ2gs0qLyCY7f/hM9eqBPqlMnW0h0b/0sZ3m79EOw+gw5x2g
 lCT5Qp5DLVrU7rcw5aMRiUPbrvDhORM2pv1+tltyOsVXzz33Z7YgaGqGqW+zwa6xIxZ0vmKwmFN
 q2ORWCgWkx8c3ky6gBp3V4Lj9ortr41D1bPqk6Ue7i7OaNHHgqdr3k5fdLaiuEX/cquijGqkJ5I
 C2IkKqe6kfB4xna5P/5HZ/7dgQnPgGn5UtNxVcAcmsJDjMw=
X-Google-Smtp-Source: AGHT+IEwdKAxdmK2RiDbSnQpXyXCN10xURPE/06r7OzlVOym75A0UE4UtvVNfRklKE1/Y5DvTh4HCg==
X-Received: by 2002:a17:90a:d604:b0:2f2:a664:df19 with SMTP id
 98e67ed59e1d1-2fc40d13ed9mr13116000a91.7.1739748045256; 
 Sun, 16 Feb 2025 15:20:45 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 121/162] tcg/i386: Special case addci r, 0, 0
Date: Sun, 16 Feb 2025 15:09:30 -0800
Message-ID: <20250216231012.2808572-122-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
index ef5f9e3f48..6bfa344e94 100644
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


