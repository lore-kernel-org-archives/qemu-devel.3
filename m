Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C2CC35FF8
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueY6-0001Kc-Bv; Tue, 18 Mar 2025 17:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXv-0001Fh-BV
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:26 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueXs-0000kn-PI
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:22 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2240b4de12bso24409415ad.2
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333539; x=1742938339; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nSn0WohsE0EYobxYvvs0WEl3hmTMlKy5q8Ka9aS9xl0=;
 b=n9lISRGJGltqVfX48qFOLvustay+18gw8RQ4f2xaB9ibvgOdCBMgvYfpM/T9apMrLC
 RzPOj0h+wnVs9MAPEOOkhWiqMNcrQf6wjeEzI66MpJbjPHyb++Ic10Y156JKy9OpAHTM
 Ko2wEEbEfC4GM+t5eFO89mi2h9hrnZXBTCwyy+49I9AfHDl7xsJ0SihzcLu+UT31xaBs
 RCLJpK9PD/0LrZFwMyMeXAJ1apCGRLqMkJC6Ths0FfS2RUkvEhiTVZ1KoqoBw1f9mz2J
 vLcFETTNxfyiyE8yE2LxjYfif1YKsIceeDjeNwYiQdMqwxrY79pyItjWKW49k5kwLlhd
 5+3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333539; x=1742938339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nSn0WohsE0EYobxYvvs0WEl3hmTMlKy5q8Ka9aS9xl0=;
 b=V5rSZiid1C9cAO0vbrWmRfQHoALAchZVTvFQjgXXocUPHMtVrcWzXczauZeiAvSc5R
 M06m5qeXNKnvci2PZOHU2urYM0SDYIsGB/q1+gfb7yAIKoz32sn4JbXdVSBjVOlkky3F
 e2Lz+z1dnx1vcX+JxOrQrN4EAF3PSeMCTjLNQeQ8YVxS6eD4mugRZCFse2E8TSdx9ESO
 YZar0aFf+bMR2Kpl3/Y0sRdBX6szAKvi6yzs9W6VohzJS4GdhhKw3etjxZBtVO7r2Ca/
 U1n2AeWiI7IpBaNxLtnZgehms5TqURDo16uUATFtlOtmqfVvwUsirbnIw+gvESRhnIzG
 n2Vw==
X-Gm-Message-State: AOJu0Ywas6wWBGQYZQBoVtA5aWAHEUSWW44YpVbH9QYFrdFOtJMncBqz
 vVDUoZWhjWuI0p6mtbQhNCUhuf/RGW1UBtdP5r/Cv39AXXLkPgj1k55tBG1BkYiwpj5QrZwoMDi
 y
X-Gm-Gg: ASbGnctCe2fyROW4qbAgGsystsRMyyQqOd6f09XgP8yF84SdkyDzAJV98uT3EYujozE
 vfldOdXAYqWrrXL/XdghitFx/UHT7XP2wfgLKC3sm0trT0ibduNL2IujKDAS23MUW/KYTQlPouP
 PvYinJDjkoJAX+mtKO1hR70pNZNpm786W0gn/CgLjouxgdRxEzQPzL5we2BCZt2D2urIiBqXJUB
 AuWxWpt38VfGZFPlY6FRjz6BwIWoxL/WVfdYBdzgwLWLOCR7FOQj7KLHDtVPs59tgfzhbhc+OsM
 5RDPyyZVGocA7FEbQ5iRDj6hDBUU1iqo0EnAYWj8CimWEKAPCiZmazSGWLk56HD/Aqd9CuIP/7Z
 m
X-Google-Smtp-Source: AGHT+IGrElYbieIK+lL6oxvYwWjhybqOiyB3BZ5GhNOjQok6NNjmYCw8xW3Kgf+zgFLT20IL2uMVHw==
X-Received: by 2002:a05:6a20:9f43:b0:1f5:63f9:9eb4 with SMTP id
 adf61e73a8af0-1fbed40cec4mr297497637.35.1742333538892; 
 Tue, 18 Mar 2025 14:32:18 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 12/42] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Date: Tue, 18 Mar 2025 14:31:37 -0700
Message-ID: <20250318213209.2579218-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
index 157be33bf6..6fd9237298 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -11,10 +11,10 @@
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include "exec/exec-all.h"
+#include "exec/cpu-ldst-common.h"
+#include "exec/cpu-mmu-index.h"
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


