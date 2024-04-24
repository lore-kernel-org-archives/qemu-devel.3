Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2149EC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5f-0005rW-QZ; Wed, 24 Apr 2024 19:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5a-0005ou-17
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:47 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5T-0003RS-VL
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:45 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6ed2dc03df6so437651b3a.1
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001498; x=1714606298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0Qhc53DOAmZcesPvgUyNzStW9YhjXBj6yX17MzJRrao=;
 b=HQ0lj69SqTN34oJfWoBEKqP4hmKNnLdFWZwTdmIK8eQms2WnYY85AlOsiNA0BAxlxM
 uemtkI1Pz4kdaVekKasmaWPQLxnz3nCOB0gbNfcjdgr+slm2ROsAXNJTrNFPL2YuPO9x
 QK6kisLtxEKT9M11GYoI1Ot4QToDPjh2RWTf/QROhDrGdIfkkJKabebEw3dZRDLsEiTI
 PEC8wpquFG/LVV8vnyFfQEsPoKKzUIbSfVDHavjn7U/ROoTFYKhHejoeoP3ropFrJEZv
 Ea4hlYXFntHFaCMSUF+JmOZ0RQF/jwfYQQMaQ3HcccIf19FlVbxpYqVACO9c3F2o/1gF
 fUNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001498; x=1714606298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0Qhc53DOAmZcesPvgUyNzStW9YhjXBj6yX17MzJRrao=;
 b=YltXnWlD6hJcqrTOacCFfxKc3T7XakTMdF5RzRkzJYJsljKvEM7VS51H9drGCMVJJg
 VfAlp5pnPcWh0UprSX+KhObJ32/bRz3CT4rBtXtRsP3KsMWQ+79zfJzFNE6F6yFlLqYm
 7GHxStOJpvDlhucWOgfABIT8zL2iO16GI90brwZ2r5pJQfh/eZppf/olkhu/jVuzm74U
 LgVxL1ZaiygNOqL2/9L3t8l+qedQGGanZ+ROf3chPBQ7zSRhg9w87lJXfS+k9PuRAonP
 COzW012lTp+VVnONVk/7coJrTO1xnGFp4ewXK/qpShPy32TCTtuKuP/CzO7laYHFjEIh
 6YDw==
X-Gm-Message-State: AOJu0YykekYT+UMS0tLgVA0iR60j0siVnO183A/ues7AaDHpti+KU7dV
 IpBhfSBkxayGwob3THo/Z8rYgfAi76G0ddE1sMvr25FPo4XHvteD5naB5VKlV4GuTABz9D/k0gk
 L
X-Google-Smtp-Source: AGHT+IE8VzxDMcRw9sfcN1fs3KkNFeXy8JasO4An3xNZteE+Ad5TsRr+6GUbSUoBnxTN5wmfHuQVKw==
X-Received: by 2002:a05:6a21:6d9c:b0:1a7:3d2a:7383 with SMTP id
 wl28-20020a056a216d9c00b001a73d2a7383mr5641781pzb.18.1714001498387; 
 Wed, 24 Apr 2024 16:31:38 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 06/33] accel/tcg: Record mmio bytes during translation
Date: Wed, 24 Apr 2024 16:31:04 -0700
Message-Id: <20240424233131.988727-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

This will be able to replace plugin_insn_append, and will
be usable for disassembly.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 12 ++++++++++++
 accel/tcg/translator.c    | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 83fe66cba0..974cc4f9c4 100644
--- a/include/exec/translator.h
+++ b/include/exec/translator.h
@@ -90,6 +90,18 @@ typedef struct DisasContextBase {
     bool plugin_enabled;
     struct TCGOp *insn_start;
     void *host_addr[2];
+
+    /*
+     * Record insn data that we cannot read directly from host memory.
+     * There are only two reasons we cannot use host memory:
+     * (1) We are executing from I/O,
+     * (2) We are executing a synthetic instruction (s390x EX).
+     * In both cases we need record exactly one instruction,
+     * and thus the maximum amount of data we record is limited.
+     */
+    int record_start;
+    int record_len;
+    uint8_t record[32];
 } DisasContextBase;
 
 /**
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index c3f4d0e252..a3c246ea37 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -131,6 +131,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
+    db->record_start = 0;
+    db->record_len = 0;
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
@@ -317,6 +319,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
     return true;
 }
 
+static void record_save(DisasContextBase *db, vaddr pc,
+                        const void *from, int size)
+{
+    int offset;
+
+    /* Do not record probes before the start of TB. */
+    if (pc < db->pc_first) {
+        return;
+    }
+
+    /*
+     * In translator_access, we verified that pc is within 2 pages
+     * of pc_first, thus this will never overflow.
+     */
+    offset = pc - db->pc_first;
+
+    /*
+     * Either the first or second page may be I/O.  If it is the second,
+     * then the first byte we need to record will be at a non-zero offset.
+     * In either case, we should not need to record but a single insn.
+     */
+    if (db->record_len == 0) {
+        db->record_start = offset;
+        db->record_len = size;
+    } else {
+        assert(offset == db->record_start + db->record_len);
+        assert(db->record_len + size <= sizeof(db->record));
+        db->record_len += size;
+    }
+
+    memcpy(db->record + (offset - db->record_start), from, size);
+}
+
 static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 {
 #ifdef CONFIG_PLUGIN
@@ -344,6 +379,7 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 
     if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
         raw = cpu_ldub_code(env, pc);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return raw;
@@ -358,6 +394,7 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_lduw_code(env, pc);
         raw = tswap16(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -372,6 +409,7 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_ldl_code(env, pc);
         raw = tswap32(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -386,6 +424,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_ldl_code(env, pc);
         raw = tswap64(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -393,5 +432,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
+    assert(pc >= db->pc_first);
+    record_save(db, pc, &insn8, sizeof(insn8));
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
-- 
2.34.1


