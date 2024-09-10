Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0197AEDE9BF
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 21:24:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so8L8-0002WR-Jx; Tue, 10 Sep 2024 17:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8L7-0002SX-LM
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:23:57 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1so8L5-0001wB-Sy
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 17:23:57 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so1020998a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 14:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726003434; x=1726608234; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JrrQrwkjzFljgzMx/X6RMiMfxp4p6p9uhxYwZvInmsY=;
 b=mesJ0H4fE+YHkaCCOpSY34nSsIQFWw6yvMHDPm6ts/f4UjSKaVEoYtjWGl+E6njLa3
 XE6E3CX6xkSnTwy8pjhgSEvI/MBse9pFSnyK7m53kKtQft0l9FnaZANWuFhcqocXo9GS
 Uic1IJvYGCuRQcIgGhyd9BYBWiiZgUQjrMDGZO+1g2mdl+XXblHbjaA/k1gB3+R8n6XX
 ee5/87p+Ncwg0pyZ5StpQz5ntrFwKrksqdpS1R9nGAhCRzrJKT2DNXT8nk7lNibZ9Vq0
 lJzvH+G1VbIzE/loYGjvIuiCIkSP+R4TJMBEn8qGH/ZwzkEpoxM0K625bcK1BAJBTl5x
 Cw0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726003434; x=1726608234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JrrQrwkjzFljgzMx/X6RMiMfxp4p6p9uhxYwZvInmsY=;
 b=bhcklF8GA078O041USadDwPpYxNp48Leh6YNBeWE0czdb25bHsuaz0utVGSHN5IZ6V
 6mNnAecWpxAj+5hlHzYc927FIqmfpvy+j/xdeBSDrB/krKfRTwY/2JX/w3TrlFyu7Hy5
 n4fUPXe4NC+kRFTB2hWj4rQP8sMX1ymxstjI8oDhlHd8QK1JucUncyiw2+g/Z+qpBQpL
 o1byeyWoAjh95YtMin2xQzCNK4L8UI7Ryn4Ew/m91z7LSaG+YoRN/O8PeSXaMT/8K6Xu
 ogm8TDFg7XiZAoJsQCHXe/amIjKcChKLzgQZI6E/dSJqzCZxriyretqUAdk6UMgGQe39
 jrrA==
X-Gm-Message-State: AOJu0YyEdlH92GQeT6VheUaVJtZ440P+vEsf5dCIceUYnxetJdDSKJ8S
 rLmKZYxtsTnN4r3OTOTlvpCijvgDn5c5SOrwOANEXDJb+zWe1lsXGqWrPMduGpqaXWmqFmdrYUf
 f
X-Google-Smtp-Source: AGHT+IHCqt7SwLwoGwh5/XrkVBZD5b5wyFT2Fi++0dXIhUSpYDa0TN7y90pr541tv+knSwPhILrYrQ==
X-Received: by 2002:a05:6a21:168b:b0:1c4:23f0:9665 with SMTP id
 adf61e73a8af0-1cf62cea105mr1956098637.29.1726003434289; 
 Tue, 10 Sep 2024 14:23:54 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7d825ba616bsm6089661a12.93.2024.09.10.14.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 14:23:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org,
 Elisha Hollander <just4now666666@gmail.com>
Subject: [PATCH 2/2] tcg: Propagate new TCGOp to add_as_label_use
Date: Tue, 10 Sep 2024 14:23:51 -0700
Message-ID: <20240910212351.977753-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240910212351.977753-1-richard.henderson@linaro.org>
References: <20240910212351.977753-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

The use of tcg_last_op does not interact well with
TCGContext.emit_before_op, resulting in the label
being linked to something other than the branch op.

In this case it is easier to simply collect the emitted
branch op and pass it directly to add_as_label_use.

Reported-by: Elisha Hollander <just4now666666@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.c | 63 ++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 28c41b37a4..4a7e705367 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -117,9 +117,9 @@ static void DNI tcg_gen_op1_i64(TCGOpcode opc, TCGv_i64 a1)
     tcg_gen_op1(opc, tcgv_i64_arg(a1));
 }
 
-static void DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
+static TCGOp * DNI tcg_gen_op1i(TCGOpcode opc, TCGArg a1)
 {
-    tcg_gen_op1(opc, a1);
+    return tcg_gen_op1(opc, a1);
 }
 
 static void DNI tcg_gen_op2_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2)
@@ -196,16 +196,16 @@ static void DNI tcg_gen_op4i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), a4);
 }
 
-static void DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGArg a3, TCGArg a4)
+static TCGOp * DNI tcg_gen_op4ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                     TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2), a3, a4);
 }
 
-static void DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
-                                  TCGArg a3, TCGArg a4)
+static TCGOp * DNI tcg_gen_op4ii_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
+                                     TCGArg a3, TCGArg a4)
 {
-    tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
+    return tcg_gen_op4(opc, tcgv_i64_arg(a1), tcgv_i64_arg(a2), a3, a4);
 }
 
 static void DNI tcg_gen_op5_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
@@ -270,12 +270,12 @@ static void DNI tcg_gen_op6i_i64(TCGOpcode opc, TCGv_i64 a1, TCGv_i64 a2,
                 tcgv_i64_arg(a3), tcgv_i64_arg(a4), tcgv_i64_arg(a5), a6);
 }
 
-static void DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
-                                  TCGv_i32 a3, TCGv_i32 a4,
-                                  TCGArg a5, TCGArg a6)
+static TCGOp * DNI tcg_gen_op6ii_i32(TCGOpcode opc, TCGv_i32 a1, TCGv_i32 a2,
+                                     TCGv_i32 a3, TCGv_i32 a4,
+                                     TCGArg a5, TCGArg a6)
 {
-    tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
-                tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
+    return tcg_gen_op6(opc, tcgv_i32_arg(a1), tcgv_i32_arg(a2),
+                       tcgv_i32_arg(a3), tcgv_i32_arg(a4), a5, a6);
 }
 
 /* Generic ops.  */
@@ -286,18 +286,17 @@ void gen_set_label(TCGLabel *l)
     tcg_gen_op1(INDEX_op_set_label, label_arg(l));
 }
 
-static void add_last_as_label_use(TCGLabel *l)
+static void add_as_label_use(TCGLabel *l, TCGOp *op)
 {
     TCGLabelUse *u = tcg_malloc(sizeof(TCGLabelUse));
 
-    u->op = tcg_last_op();
+    u->op = op;
     QSIMPLEQ_INSERT_TAIL(&l->branches, u, next);
 }
 
 void tcg_gen_br(TCGLabel *l)
 {
-    tcg_gen_op1(INDEX_op_br, label_arg(l));
-    add_last_as_label_use(l);
+    add_as_label_use(l, tcg_gen_op1(INDEX_op_br, label_arg(l)));
 }
 
 void tcg_gen_mb(TCGBar mb_type)
@@ -514,8 +513,9 @@ void tcg_gen_brcond_i32(TCGCond cond, TCGv_i32 arg1, TCGv_i32 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_op4ii_i32(INDEX_op_brcond_i32, arg1, arg2, cond, label_arg(l));
-        add_last_as_label_use(l);
+        TCGOp *op = tcg_gen_op4ii_i32(INDEX_op_brcond_i32,
+                                      arg1, arg2, cond, label_arg(l));
+        add_as_label_use(l, op);
     }
 }
 
@@ -1934,15 +1934,16 @@ void tcg_gen_brcond_i64(TCGCond cond, TCGv_i64 arg1, TCGv_i64 arg2, TCGLabel *l)
     if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
+        TCGOp *op;
         if (TCG_TARGET_REG_BITS == 32) {
-            tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
-                              TCGV_HIGH(arg1), TCGV_LOW(arg2),
-                              TCGV_HIGH(arg2), cond, label_arg(l));
+            op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32, TCGV_LOW(arg1),
+                                   TCGV_HIGH(arg1), TCGV_LOW(arg2),
+                                   TCGV_HIGH(arg2), cond, label_arg(l));
         } else {
-            tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
-                              label_arg(l));
+            op = tcg_gen_op4ii_i64(INDEX_op_brcond_i64, arg1, arg2, cond,
+                                   label_arg(l));
         }
-        add_last_as_label_use(l);
+        add_as_label_use(l, op);
     }
 }
 
@@ -1953,12 +1954,12 @@ void tcg_gen_brcondi_i64(TCGCond cond, TCGv_i64 arg1, int64_t arg2, TCGLabel *l)
     } else if (cond == TCG_COND_ALWAYS) {
         tcg_gen_br(l);
     } else if (cond != TCG_COND_NEVER) {
-        tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
-                          TCGV_LOW(arg1), TCGV_HIGH(arg1),
-                          tcg_constant_i32(arg2),
-                          tcg_constant_i32(arg2 >> 32),
-                          cond, label_arg(l));
-        add_last_as_label_use(l);
+        TCGOp *op = tcg_gen_op6ii_i32(INDEX_op_brcond2_i32,
+                                      TCGV_LOW(arg1), TCGV_HIGH(arg1),
+                                      tcg_constant_i32(arg2),
+                                      tcg_constant_i32(arg2 >> 32),
+                                      cond, label_arg(l));
+        add_as_label_use(l, op);
     }
 }
 
-- 
2.43.0


