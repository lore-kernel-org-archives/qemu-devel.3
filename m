Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCC1C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 18:29:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYr5E-0003lH-TF; Fri, 17 Jan 2025 13:28:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr5C-0003iH-9u
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:38 -0500
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tYr59-00005E-Oi
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 13:28:37 -0500
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2ee86a1a92dso3574267a91.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 10:28:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737138514; x=1737743314; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lkg9fxzYnG4S81y8aBxwl4d3ZJN+dnyX/D5oQckVa00=;
 b=ph5gSqgc71dfoaFmnxi+7wOHOqomW2An5qVyi8Ptx93Z7M4WmCdvOJ/axPpz6uKSrc
 AYTwOE+xDxOUUbM62PctR+49RLrXGwVF7JXzw+LcbHcjObReNp26mVDH17kZqiG8MRUM
 NwIW+WBJoiYR8oYVYGTsPuq0Tq0CNqSqsMLqubhnDlO3vP5+m2gXB5hBP1qaZ9e8qJl3
 QsMVYYNNO9EV8YAlKwkixRzNz1oP2jyAfTtS4ATagxcmke0C3UdgflA9DqrmB2PxCwAi
 96c0RQVkfVxoKwxzMSgLEaUGAbZe1WUkYGuU4nWpqp+shjAtS7ME0dmabr5qnzg4MQ4B
 7iEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737138514; x=1737743314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lkg9fxzYnG4S81y8aBxwl4d3ZJN+dnyX/D5oQckVa00=;
 b=JMGqCJWWTVP95wJkAkuGWt/aTZ7cjeubLKjuQ7QsubOMRE6rxtXyY7uE5LVI87Aavx
 ARIB1qtrzplscitnSDUSZrtuNGJmK/Gy45ISw8cjGoZHeiDmF/ODdg9EznP25h333qkl
 krhFkV6Mz4p+s5xtqzTTB2UNlWChCHOTeZ7gDrO1H/1z0uOaG7kmi2RrS02Zp8w/Nq+F
 ps8qJLTIz/1b3+y38yT7vYB8sS2XNJZAfgK3mWEp5qbXg+SZNTH8hTUruusYNE88DaYn
 63OOpSkoErLo+LPpurSVhHBT7n99SnprAbn9Rknca1UJWnST5MpC7mUtZQtiZgqRYZ9Q
 ic7w==
X-Gm-Message-State: AOJu0Yz64c/2eNjxkQiiaWTztg7f28a9nMcqAj82VbWfhbcJ187PEt1m
 INnhFz48JltIKpKxVyKrJaAEEaoMJhuR7HOIFmg9lALsBzYET/FRoB1XaalB+jEJlSbAtzMQX0r
 1
X-Gm-Gg: ASbGncvufUmNVc2d+BBsICyUk1s42LtmyVgqzewkxpy/vvS6fjzOthJJsa7QB9brVrZ
 REV1lMHDp6ZoVrC4gp6ff4Ha1kzSfpZiVcreZp3JwjuhO//gLFOMTTlbdCsBH5Pn/ZHVpswI88v
 0waILd4GVnCdgZMCAxk7GkDpBJoSLdGBFcpQhtFTgVjsEEb0SBYgz4fA3dxYmSdtcCip11tEW51
 6GKlgd5cpOmCUO7MMdzWQfoJ/NuX0FbJYf52BYru2SoYJTTXraVPsHOdMr15XyOLMK6F2J7Z68M
 0TDWPk/+IDGVmxs=
X-Google-Smtp-Source: AGHT+IHWgGJHok0EEcuxRJXx5wUN6VcbS2u+/0iGx2YfunX4CQNq4o1DPnfdeTWhF/iczK5Q2EmbmQ==
X-Received: by 2002:a17:90a:e18f:b0:2ee:693e:ed7a with SMTP id
 98e67ed59e1d1-2f782d8651amr5122327a91.35.1737138514015; 
 Fri, 17 Jan 2025 10:28:34 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f77629bf96sm2614105a91.36.2025.01.17.10.28.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 10:28:33 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/68] tcg: Pass type and flags to tcg_target_op_def
Date: Fri, 17 Jan 2025 10:24:29 -0800
Message-ID: <20250117182456.2077110-42-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117182456.2077110-1-richard.henderson@linaro.org>
References: <20250117182456.2077110-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Allow the backend to make constraint choices based on more parameters.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c                        | 4 ++--
 tcg/aarch64/tcg-target.c.inc     | 3 ++-
 tcg/arm/tcg-target.c.inc         | 3 ++-
 tcg/i386/tcg-target.c.inc        | 3 ++-
 tcg/loongarch64/tcg-target.c.inc | 3 ++-
 tcg/mips/tcg-target.c.inc        | 3 ++-
 tcg/ppc/tcg-target.c.inc         | 3 ++-
 tcg/riscv/tcg-target.c.inc       | 3 ++-
 tcg/s390x/tcg-target.c.inc       | 3 ++-
 tcg/sparc64/tcg-target.c.inc     | 3 ++-
 tcg/tci/tcg-target.c.inc         | 3 ++-
 11 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index e9ecdc5eeb..83356d932d 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -866,7 +866,7 @@ typedef enum {
 #include "tcg-target-con-set.h"
 } TCGConstraintSetIndex;
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode);
+static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode, TCGType, unsigned);
 
 #undef C_O0_I1
 #undef C_O0_I2
@@ -3375,7 +3375,7 @@ static const TCGArgConstraint *opcode_args_ct(const TCGOp *op)
         return empty_cts;
     }
 
-    con_set = tcg_target_op_def(op->opc);
+    con_set = tcg_target_op_def(op->opc, TCGOP_TYPE(op), TCGOP_FLAGS(op));
     tcg_debug_assert(con_set >= 0 && con_set < ARRAY_SIZE(constraint_sets));
 
     /* The constraint arguments must match TCGOpcode arguments. */
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index d1e08def60..9116f85667 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2962,7 +2962,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index b4cd36a9b8..182cac1a8a 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2124,7 +2124,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/i386/tcg-target.c.inc b/tcg/i386/tcg-target.c.inc
index 813c12ca0e..64826c7419 100644
--- a/tcg/i386/tcg-target.c.inc
+++ b/tcg/i386/tcg-target.c.inc
@@ -3627,7 +3627,8 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index 686b94ccda..2f0d4d01ff 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -2191,7 +2191,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     g_assert_not_reached();
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/mips/tcg-target.c.inc b/tcg/mips/tcg-target.c.inc
index 199bd97c0e..b89b279a0e 100644
--- a/tcg/mips/tcg-target.c.inc
+++ b/tcg/mips/tcg-target.c.inc
@@ -2151,7 +2151,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 3ce4fa1db6..1e7b8a204c 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -4140,7 +4140,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 51cd7e7586..432a2fe26f 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -2583,7 +2583,8 @@ int tcg_can_emit_vec_op(TCGOpcode opc, TCGType type, unsigned vece)
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/s390x/tcg-target.c.inc b/tcg/s390x/tcg-target.c.inc
index 98925b1d5d..e09a726ecf 100644
--- a/tcg/s390x/tcg-target.c.inc
+++ b/tcg/s390x/tcg-target.c.inc
@@ -3207,7 +3207,8 @@ void tcg_expand_vec_op(TCGOpcode opc, TCGType type, unsigned vece,
     va_end(va);
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/sparc64/tcg-target.c.inc b/tcg/sparc64/tcg-target.c.inc
index 1201607722..48de490120 100644
--- a/tcg/sparc64/tcg-target.c.inc
+++ b/tcg/sparc64/tcg-target.c.inc
@@ -1532,7 +1532,8 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc,
     }
 }
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
diff --git a/tcg/tci/tcg-target.c.inc b/tcg/tci/tcg-target.c.inc
index 74b649c902..662acbdcb6 100644
--- a/tcg/tci/tcg-target.c.inc
+++ b/tcg/tci/tcg-target.c.inc
@@ -36,7 +36,8 @@
 #endif
 #define TCG_TARGET_CALL_RET_I128        TCG_CALL_RET_NORMAL
 
-static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
+static TCGConstraintSetIndex
+tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 {
     switch (op) {
     case INDEX_op_goto_ptr:
-- 
2.43.0


