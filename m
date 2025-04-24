Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5519CC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7knI-0005ns-67; Wed, 23 Apr 2025 20:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmy-0005TO-LS
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:04 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmt-0004N3-Bt
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:50:00 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7376dd56f8fso498650b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455798; x=1746060598; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wBYxT4EZlPkn7bKzklLjARHvSiI+QmQyMRdt3yUNx28=;
 b=mK7UHdER1Nil2Ri6hXyOTtC2BkYPUjxFSD/qmzoqhO+hY1upAahWOSoLY9KN5zX2fV
 GYcnFJhozZeT3pr3Myy0vzXAwRyYwm/rMT4C0Jgt5ZUWk2Q8mzDr2hMRPDQf2LIIcsYB
 pxBdLIq7fXunL3+n1Yb0ZbeY2/nTMKNBSOcWkoIvVuW0VtTQt3JNChodMGqguliFksrm
 gTd9I0b4nchBc0msiNgBveuy1gXko5otikndbg4tDDO6xHCcfV7YqbTCchDNNwPzxaNr
 SCIWVOgzd1jhacq7otxiiirtUvlqHMYhW1PXSUkqux8Ui9waNxv+AcGeYOPNRG55kcC0
 iCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455798; x=1746060598;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wBYxT4EZlPkn7bKzklLjARHvSiI+QmQyMRdt3yUNx28=;
 b=f5OCPLt/4YgEWseZEMB7KcwrJga9MVeR+iysCtewR2z3oT309xLAu7gRKK6UfUAE8G
 XyvKVPE08UzZxesydfe7Iehyyx/87R6iUsFf0BfZ57jTyZ7UUoD5B2XUzLf1eZ3aUmFy
 FmxALCOfqP35vD+BICCNSEKG8EUp4vge5bpVK0a01exA+zW3jhPaZrWCDHRQOe2OhlAh
 TAnpJ1l4IJMmBxjVnBKfpHxy9vtvAGIdOuD2C/n4YsIFbNH/r6mOoWA1HP6TIA4Pvuw4
 l3ndRl1LjQpcVVpbm6eFnj59DKK8ulN4AF+YelFMeyKJhynr2zypDuvp/dQD9bdq1chX
 J22Q==
X-Gm-Message-State: AOJu0YwQAQUQHsgU7/Ljxmp4Y5/YprMvUWCQPECaf6sIftJV5SjYZYs/
 x9AA0+2szwpEUFV4us7GIVsAMsW3MEk22Vdg6EaG/oCSWokYSlLbtBMKfUMOteMbI8RRKLlYWM7
 +
X-Gm-Gg: ASbGnct6Rgc83JnODvR5ggPWBzC5f/GU2JEw/noTGUuXHGRhWnQIUGODv7/CAgnSj52
 W0FL3LAJ04FXgp8PGaBASV4Lkaqk1WwWM2aVyb4QjkjkYpiRjdiSVlmi6IQZg3r94+MuMvg7b6l
 OzSFG9a6/wA25Cl/9NTozaZd5R3m74YAoMSTnjWmxHLeDxCsHzLX9USkswCWKeeRVLvLJsYGuSd
 luhBoVC0XSk/deb38ADPNsSQgTnxUbAiDI+U3pMegTlkBPZmHgUtH6Twcj17VRvLwqcoP8HOzOr
 KIq7Ztc/zd2PDiWy3HbNpx8DOj/CC8iTXWmeFSoVWMOhLngdjj5uGLHIVEd0ybZxce1NwNPFURE
 =
X-Google-Smtp-Source: AGHT+IFJtzak2rL4SlZTCND5YK5Ekds2zcKfhEUIjGkHCgXWPIW1vA9eFl98z3n91ZgdWM7+/t9Glg==
X-Received: by 2002:a05:6a21:6da4:b0:203:bb65:995a with SMTP id
 adf61e73a8af0-20444f25041mr861150637.30.1745455798037; 
 Wed, 23 Apr 2025 17:49:58 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 030/148] accel/tcg: Use cpu_ld*_code_mmu in translator.c
Date: Wed, 23 Apr 2025 17:47:35 -0700
Message-ID: <20250424004934.598783-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
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

Cache the mmu index in DisasContextBase.
Perform the read on host endianness, which lets us
share code with the translator_ld fast path.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


