Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94438C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:55:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rf-00047o-Cw; Wed, 15 May 2024 03:53:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ra-00044i-PR
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:00 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79RY-0001Yc-6L
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:52:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41fd5dc04f0so41586675e9.0
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759574; x=1716364374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHBV7vFxAWndnD846QEnn6hvoRiyYa0vJI3T3k5IEYM=;
 b=HBncV/yU9gRVxpjxNumTFH48o5LIsr4hfQ+zWaB1CfNZ+74VNrPijblIwCuGAmyGdK
 +uVKQCOYDbifP9QTaiin5clw7yvXyQodnMPIEeHMc4C4Id9tI6Yv+Ucp16u/bAkMH4dJ
 CPrRwi1/+1I3Uq7T3sLshKXC1Apva39SFHywRIGeX4dGldxMlhDzZwzs4Qg7NmQbF6Tm
 BKA96rF+vjxO0Mi5PeoXKWK11mEMacF7p6Vh5tVwXwjbmccdAwwZYVL8f4neiEM44TS/
 FBdiWiok20W4CKTjItLtDhB0W9FO+trjKSupbLXWUB4ux8Axag3o/rnZv2o6U4VVPxL+
 YSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759574; x=1716364374;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHBV7vFxAWndnD846QEnn6hvoRiyYa0vJI3T3k5IEYM=;
 b=Pux/K2OELLgzD6f+4KAFEceUTUk1TS5DDL9e29nEGESYObANBKwR9lVaABSIjEx54p
 UoIb+P+6WlD/fLbS00bHJU9V0UTXJnSEBHuhJ/N/Z+cCJloyV7O6GSfatd/V7j8RqOxc
 p3qhku4uvPDP9ECEsibWZxsW09qa29cN5HmR9kZU3LsSt+3lhlkKe1PU9xyNPUbyp/FU
 rR4P48BRrri7Uq/ph28Q86G9sOTVeMlixs+t3cezLwSYsKLW8kgub3ke1vk6MzlOF52f
 Fmn3ZGilFT/k9/kespsk82hVTkbkU3xN8DVIPllm4TnsEXzTN9VkM5mn+813lX+SrDEX
 0Wyw==
X-Gm-Message-State: AOJu0YxRng1iD68KXhb78a+/ln6TvXqXqV6SZwr9l5OMOhXarfGtQ/YQ
 /8abCcQa5dGEd16X5ZueOo0OaZkexJlxN224d3To3tRYiQN04lirqPuI/mwkOH0Bh8ltK5jNZIk
 9BOc=
X-Google-Smtp-Source: AGHT+IFSwlp4fkHioTMh8wCKKhD6fvCPeU+VWB+QFLijcj5wqOJcBQwImd7VlyxdxwcGSYeYnA5UPg==
X-Received: by 2002:a05:600c:4f0c:b0:420:1f0f:fe19 with SMTP id
 5b1f17b1804b1-4201f0fff56mr51343725e9.13.1715759574108; 
 Wed, 15 May 2024 00:52:54 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/34] accel/tcg: Record mmio bytes during translation
Date: Wed, 15 May 2024 09:52:19 +0200
Message-Id: <20240515075247.68024-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/translator.h | 12 ++++++++++++
 accel/tcg/translator.c    | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+)

diff --git a/include/exec/translator.h b/include/exec/translator.h
index 348985c3a3..4a86907ecc 100644
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
index 18138c61e1..86a1fe17a0 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -132,6 +132,8 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     db->insn_start = NULL;
     db->host_addr[0] = host_pc;
     db->host_addr[1] = NULL;
+    db->record_start = 0;
+    db->record_len = 0;
 
     ops->init_disas_context(db, cpu);
     tcg_debug_assert(db->is_jmp == DISAS_NEXT);  /* no early exit */
@@ -318,6 +320,39 @@ static bool translator_ld(CPUArchState *env, DisasContextBase *db,
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
@@ -345,6 +380,7 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 
     if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
         raw = cpu_ldub_code(env, pc);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return raw;
@@ -359,6 +395,7 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_lduw_code(env, pc);
         raw = tswap16(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -373,6 +410,7 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_ldl_code(env, pc);
         raw = tswap32(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -387,6 +425,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
     } else {
         tgt = cpu_ldq_code(env, pc);
         raw = tswap64(tgt);
+        record_save(db, pc, &raw, sizeof(raw));
     }
     plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
@@ -394,5 +433,7 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
 {
+    assert(pc >= db->pc_first);
+    record_save(db, pc, &insn8, sizeof(insn8));
     plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
-- 
2.34.1


