Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F5FD4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgack-0003HU-FF; Thu, 15 Jan 2026 22:35:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgaci-0003CI-Tr
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:44 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgach-0006QN-4d
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:35:44 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a1388cdac3so11202715ad.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534542; x=1769139342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SRTKY77Q5AGOWWtgWUqll/eZ5kBhHSvVz6RI7rqXw3s=;
 b=zigX0eIgNveDzhZA26qPxpKjHpwpFmnt4XrwwZwWyblywpRNBFfDuDoDO9X/jMvf7E
 ZX+hWNbJ1iScnUHSIfqtld22SqoH8euqiFUbyg+GT9/9SARj47/daSJnjSdkki1qMUIa
 ce6ZcHD00DzWfd0qk4bY2bA6aXktRu0pcKjjmZFmsV7A7MbP169KtZiky7uT1X7oWgsn
 hZIVaEN+49Q0zZK2aBHcPbe5Fz225etFLf8w9k+GsLM7McHx7Rj79J336tFj6bjvpadf
 3zigDk7Nwa8Yr10EnplKvKjbhctTfwTS04IR7LXAPSmxmeEzfDP7Sz6+h2s4iL72aaQ2
 f4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534542; x=1769139342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SRTKY77Q5AGOWWtgWUqll/eZ5kBhHSvVz6RI7rqXw3s=;
 b=MXPiNkorGB0042tPFLSur+x27fVKOD/QDcCdTSmzdo+JQ4TGrKpelkZrrYjFkaCvAk
 fF0BMbfNLjjO5SLcsa2/HNb4H49L2fwyuZNNQK1ng9g+RMuEg2Ya5/7lSUA3kY/Y04f8
 wWuNin+ccyEm/hMb4OiP/NGik+8WDmv221RzhbeaH5X41PEDTigUyzziaSuL6MMBPVi+
 Busg7cLDe3kkK1e5wMbdb/oPOStvnBj/K5uFpOMVvyyVO7R7NkQ+W0aE7LU3f4AWMhOn
 e/Ej6y+0454x2oUNbmzhwdXg3x5SO2d1sQvo9FU2AibN7ySiytSSRf2wzrj49T43Y8OL
 UlDQ==
X-Gm-Message-State: AOJu0YyQJvXNExvTtRIM8tX7YsHpdhZy4cpTizCmzNPZwyD2Q1bZlX60
 9oH3G1BEEGZIsleiWz9SN5gKrUAFEY2/LT2lE/AxuyZNIyNXHiu8BebXkCiSNbzfzf2OfoIEFB+
 QakAOVUZx2Q==
X-Gm-Gg: AY/fxX4wH+Vpe+F4A4A3dqlJkxZjOxTQPtWGeF5uIiG3l0kXo7o9i8oDvYCVlavfPSL
 QOG+8rjkl9CnRXpQVGFffAxBvd4fmTiAOaH3EODdmTQJh9Qz8FLD12yKdYIOMcvDvVthFVhjknE
 PpHpq8Jvr8yoHQro5Rgxs1A7RiPyTZICP8yGRD86Q9gllr7Pu77OSVlWjfmMlbURn8crm4vDIoK
 y8JrqJVkpaWp4XBPAc+gIGfajB+Ufk2/0UoA3gaksZTqi+9j328/r/7KwxW8l0RVHXCG1hWetul
 unYrVgV9APQvPZWNKGDluFU+JKZW4z879CEi7JER/D2S1/tcWaDNYLGdDDZzrTl44PdZUYBdL31
 r3mayV4KIZNtG90sgb9rDKIKZU+YXXChCd8NFRogMOtieTRy1vhorO+tRBokaZus3lg+04VRpGE
 SJZRdKDVYp2RaW8dfYKQ==
X-Received: by 2002:a17:903:120c:b0:2a0:b44e:9ab6 with SMTP id
 d9443c01a7336-2a7174f0bacmr18280295ad.7.1768534541574; 
 Thu, 15 Jan 2026 19:35:41 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81fa12b5c67sm683372b3a.69.2026.01.15.19.35.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:35:41 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 38/58] include/tcg: Drop TCG_TARGET_REG_BITS tests
Date: Fri, 16 Jan 2026 14:32:44 +1100
Message-ID: <20260116033305.51162-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-op.h  |  9 +++------
 include/tcg/tcg-opc.h |  5 +----
 include/tcg/tcg.h     | 27 ++-------------------------
 3 files changed, 6 insertions(+), 35 deletions(-)

diff --git a/include/tcg/tcg-op.h b/include/tcg/tcg-op.h
index 232733cb71..ee379994e7 100644
--- a/include/tcg/tcg-op.h
+++ b/include/tcg/tcg-op.h
@@ -31,8 +31,7 @@
 #if TARGET_INSN_START_EXTRA_WORDS == 0
 static inline void tcg_gen_insn_start(target_ulong pc)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, 0);
     tcg_set_insn_start_param(op, 2, 0);
@@ -40,8 +39,7 @@ static inline void tcg_gen_insn_start(target_ulong pc)
 #elif TARGET_INSN_START_EXTRA_WORDS == 1
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, 0);
@@ -50,8 +48,7 @@ static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1)
 static inline void tcg_gen_insn_start(target_ulong pc, target_ulong a1,
                                       target_ulong a2)
 {
-    TCGOp *op = tcg_emit_op(INDEX_op_insn_start,
-                            INSN_START_WORDS * 64 / TCG_TARGET_REG_BITS);
+    TCGOp *op = tcg_emit_op(INDEX_op_insn_start, INSN_START_WORDS);
     tcg_set_insn_start_param(op, 0, pc);
     tcg_set_insn_start_param(op, 1, a1);
     tcg_set_insn_start_param(op, 2, a2);
diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 28806057c5..61f1c28858 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -109,9 +109,7 @@ DEF(extu_i32_i64, 1, 1, 0, 0)
 DEF(extrl_i64_i32, 1, 1, 0, 0)
 DEF(extrh_i64_i32, 1, 1, 0, 0)
 
-#define DATA64_ARGS  (TCG_TARGET_REG_BITS == 64 ? 1 : 2)
-
-DEF(insn_start, 0, 0, DATA64_ARGS * INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
+DEF(insn_start, 0, 0, INSN_START_WORDS, TCG_OPF_NOT_PRESENT)
 
 DEF(exit_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
 DEF(goto_tb, 0, 0, 1, TCG_OPF_BB_EXIT | TCG_OPF_BB_END | TCG_OPF_NOT_PRESENT)
@@ -184,5 +182,4 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
-#undef DATA64_ARGS
 #undef DEF
diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 067150c542..60942ce05c 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -43,19 +43,10 @@
 #define CPU_TEMP_BUF_NLONGS 128
 #define TCG_STATIC_FRAME_SIZE  (CPU_TEMP_BUF_NLONGS * sizeof(long))
 
-#if TCG_TARGET_REG_BITS == 32
-typedef int32_t tcg_target_long;
-typedef uint32_t tcg_target_ulong;
-#define TCG_PRIlx PRIx32
-#define TCG_PRIld PRId32
-#elif TCG_TARGET_REG_BITS == 64
 typedef int64_t tcg_target_long;
 typedef uint64_t tcg_target_ulong;
 #define TCG_PRIlx PRIx64
 #define TCG_PRIld PRId64
-#else
-#error unsupported
-#endif
 
 #if TCG_TARGET_NB_REGS <= 32
 typedef uint32_t TCGRegSet;
@@ -147,11 +138,7 @@ typedef enum TCGType {
 #define TCG_TYPE_COUNT  (TCG_TYPE_V256 + 1)
 
     /* An alias for the size of the host register.  */
-#if TCG_TARGET_REG_BITS == 32
-    TCG_TYPE_REG = TCG_TYPE_I32,
-#else
     TCG_TYPE_REG = TCG_TYPE_I64,
-#endif
 
     /* An alias for the size of the native pointer.  */
 #if UINTPTR_MAX == UINT32_MAX
@@ -605,23 +592,13 @@ static inline void tcg_set_insn_param(TCGOp *op, unsigned arg, TCGArg v)
 static inline uint64_t tcg_get_insn_start_param(TCGOp *op, unsigned arg)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
-    if (TCG_TARGET_REG_BITS == 64) {
-        return tcg_get_insn_param(op, arg);
-    } else {
-        return deposit64(tcg_get_insn_param(op, arg * 2), 32, 32,
-                         tcg_get_insn_param(op, arg * 2 + 1));
-    }
+    return tcg_get_insn_param(op, arg);
 }
 
 static inline void tcg_set_insn_start_param(TCGOp *op, unsigned arg, uint64_t v)
 {
     tcg_debug_assert(arg < INSN_START_WORDS);
-    if (TCG_TARGET_REG_BITS == 64) {
-        tcg_set_insn_param(op, arg, v);
-    } else {
-        tcg_set_insn_param(op, arg * 2, v);
-        tcg_set_insn_param(op, arg * 2 + 1, v >> 32);
-    }
+    tcg_set_insn_param(op, arg, v);
 }
 
 /* The last op that was emitted.  */
-- 
2.43.0


