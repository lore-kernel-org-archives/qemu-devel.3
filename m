Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870B2C369D1
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIl-0002ej-Qe; Tue, 22 Apr 2025 15:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIW-0002WF-Ft
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIR-0006DN-7Z
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:48 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso6027180a91.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350120; x=1745954920; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T2VFGDCYeUXugtnoDK4L20D4ZqSx0NDgVw90btmYdaY=;
 b=pby+hWVGwqgGvYhgcSJTfj0nM9rubtdYkQaVbqSzbDksXBilVbkhMMbYZ/896IyXNU
 hekn9cMbnG/DV3oGOmcdJkfrgogSITy123hkeGTIY/6sSoQ0dxj4YI0+YC6QKDB77LFR
 +3ZjORhLsgfjG+uewyrmvCXRZdV1UnQ4JXuulzP2KN1sUTJvHvHxuX4394F8J81V5X6q
 w074VuOQoAgmzXtNTUWPCGmDewMbGz87xdBJja6gRfVfq/S5HoF/OZUyonixzKUVeiO7
 n47tFWcQ1vYXfkQvR928m37iIYOxwZQ4cW4CT22mmsDTuoRhx8g402/ZF1akgFV5H2QG
 xHXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350120; x=1745954920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2VFGDCYeUXugtnoDK4L20D4ZqSx0NDgVw90btmYdaY=;
 b=I+1U3omkg0R+lR5dmayp3xvHw3mWQnYTSWqKLdMzUFvNikwC0Id3/F4fE/9QnOkDdi
 HA/CDOdjBuOz5Ccg031VCjRr1SQFhxq4Cho8xHrKyEjYgGdqLDhQ/rdVa0ATxxLC0y9P
 yrlsjJkExnYGQ3pn1ovDJOLbBmUgyH3Z3nORyCK6blaHr5SC9B4n/UozVMOBqTSbpkBx
 ENS/T6FWi59PD4izUu+SZgZMI2WidAnJ18kq2TWkYJtA+BfrsxgqIa6d/A7YQADJ87TX
 bM6dd9qHOIgGYCN5dZVWQfKiFOEdoc0yB6iXxZij9Tdp1aCMgUK/Me7DEzh1QlFIYg2+
 S94w==
X-Gm-Message-State: AOJu0YwcZcZIj1P94HoT+wyxke6B8ve8dg82Dr+DZXg5xI0F5xP17Xio
 dM/ScYF7mUpstRBA3m3UVAeUn9Pxyob8fvPSSoA9rhCI1l4dogR1/769gfTvC8hh2Yu58TX903Y
 m
X-Gm-Gg: ASbGncvzGII6eI+/FEvK1Ly/hIG1irFgaI8ksF6JoYSiXuXw9hiOQR3ju6PB1N+njxt
 eDj0Y+szmi5k88W6OF/JOlQR7NhpiYS02UUs4xeD1k+RQajwuMHlWk4NQq76MbB/2xLr0F7zAj2
 i9QEbbWWMyUUJ8eb9a1HEafpl43e4wUH9RUUfsfmQ1Xtm74qHgnz2jkoHJsx4PpY2v4yVkP35MQ
 rLr4lBNe3ozse8c44i8xLqIZtjOCMkAEJnMmBN16HxaX99q0y90ucKbc0T5Q30Af7FzFgMvJB8i
 RkKEiqNNqhXkm+8OKBE2S3gwksGELnEqJwd6uaH4OyttmuEWqcdzgMLZL1SfkiKSf3FMsJ1gFFo
 =
X-Google-Smtp-Source: AGHT+IEoSN06BiUWaHKCFynQCceObz/Qa/lu/l+wrQyDuVxw6u9nHyH5eMU/ZRjVeF2ODOwMhaesFw==
X-Received: by 2002:a17:90a:d888:b0:2fa:137f:5c61 with SMTP id
 98e67ed59e1d1-3087bb53ee8mr28737474a91.12.1745350120323; 
 Tue, 22 Apr 2025 12:28:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 030/147] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Date: Tue, 22 Apr 2025 12:26:19 -0700
Message-ID: <20250422192819.302784-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

Cache the mmu index in DisasContextBase.
Perform the read on host endianness, which lets us
share code with the translator_ld fast path.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h |  1 +
 accel/tcg/translator.c    | 58 ++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 31 deletions(-)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index d70942a10f..205dd85bba 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -73,6 +73,7 @@ struct DisasContextBase {
     int max_insns;
     bool plugin_enabled;
     bool fake_insn;
+    uint8_t code_mmuidx;
     struct TCGOp *insn_start;
     void *host_addr[2];
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 157be33bf6..4c320ab9c3 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,10 +11,10 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-ldst-common.h"
+#include "accel/tcg/cpu-mmu-index.h"
 #include "exec/translator.h"
-#include "exec/cpu_ldst.h"
 #include "exec/plugin-gen.h"
-#include "exec/cpu_ldst.h"
 #include "exec/tswap.h"
 #include "tcg/tcg-op-common.h"
 #include "internal-target.h"
@@ -142,6 +142,7 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->host_addr[1] = NULL;
     db->record_start = 0;
     db->record_len = 0;
+    db->code_mmuidx = cpu_mmu_index(cpu, true);
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
@@ -457,55 +458,50 @@ bool translator_st(const DisasContextBase *db, void *dest,
 
 uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint8_t raw;
+    uint8_t val;
 
-    if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        raw = cpu_ldub_code(env, pc);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UB, db->code_mmuidx);
+        val = cpu_ldb_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return raw;
+    return val;
 }
 
 uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint16_t raw, tgt;
+    uint16_t val;
 
-    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        tgt = tswap16(raw);
-    } else {
-        tgt = cpu_lduw_code(env, pc);
-        raw = tswap16(tgt);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UW, db->code_mmuidx);
+        val = cpu_ldw_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return tgt;
+    return tswap16(val);
 }
 
 uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint32_t raw, tgt;
+    uint32_t val;
 
-    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        tgt = tswap32(raw);
-    } else {
-        tgt = cpu_ldl_code(env, pc);
-        raw = tswap32(tgt);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UL, db->code_mmuidx);
+        val = cpu_ldl_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return tgt;
+    return tswap32(val);
 }
 
 uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint64_t raw, tgt;
+    uint64_t val;
 
-    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
-        tgt = tswap64(raw);
-    } else {
-        tgt = cpu_ldq_code(env, pc);
-        raw = tswap64(tgt);
-        record_save(db, pc, &raw, sizeof(raw));
+    if (!translator_ld(env, db, &val, pc, sizeof(val))) {
+        MemOpIdx oi = make_memop_idx(MO_UQ, db->code_mmuidx);
+        val = cpu_ldq_code_mmu(env, pc, oi, 0);
+        record_save(db, pc, &val, sizeof(val));
     }
-    return tgt;
+    return tswap64(val);
 }
 
 void translator_fake_ld(DisasContextBase *db, const void *data, size_t len)
-- 
2.43.0


