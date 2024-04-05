Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C379EC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:27:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsglD-00060x-JZ; Fri, 05 Apr 2024 06:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl6-0005z5-A0
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:20 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl4-0004iK-71
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:19 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6e9eccfc4b7so895321a34.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312716; x=1712917516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sXJp68IxXRRxWP6mAKqccZKI80JRQyGpOUIyXQjxXn0=;
 b=SfFOrpX4nIQ8D7xk/5Wny/Te5hyr4MW1yMtxy3wugV4QVLNniO5eFKUTJbFWrPsz1T
 A5pfiAEhRgMHjpN1vGR9SPaO8M8Zw7HhjD+6hC74qd8h+zJ1gaRgjrde/Y1KRaHdbYgC
 7w95yCNvhnHJskcPu8Uhn67udmh6gn28bU3RNB/t2M5XapNX4UW3io5d1kCFrSotxRU4
 +a+me4y8Upv+SFRpAfOlXrOHNaxlq0kXZPVj+xtQ63gnvwe91ol+ioGIeqDzIl/L3ADP
 VZ/eRylEjfIy/jRjMVyDSyXYpWiufqPqqPOpluT0C3lEkeCZFVHnt29UJwS5i0HNi7VL
 VFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312716; x=1712917516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXJp68IxXRRxWP6mAKqccZKI80JRQyGpOUIyXQjxXn0=;
 b=bGpgLWXQHnnN89MbAO8WE9FZlubIgnppQ7ZXtbNADAPr+Oh5A7I1mOZRhPLldXruDj
 GfXWaP1yBl3OcGY2ZDvIQwIOSjErwFfb3ExWcAABtVVD12stAYR45DVFamT8IOy6DGIP
 4hBe+qiDxFo8WnQizB/QR1hZTx+Potr56dhQ5ldxrdIflLQQIdt/vk7PsZibjsvE+tzf
 CVi+SPFhzCnnyhwADMaCn7IjDPV/vlp3r8Awpg/KvFLjbPimAQbF3jetTBseaMX1ryPr
 sCu/2Alb3Pq7P1gzJOEl2Hz4gaqwdpZECvY8dKJaMw1/DeJm+uNAq5/lA7a+dCGO8+C3
 Jkiw==
X-Gm-Message-State: AOJu0YzlXdnbNC5YnNl++HAQiKSGL56tE55JVQ2Ac12NNs1TA/fWKy0o
 18XM1Xp2Dmqfy/jXwIyZ9WYeA5p7VqTGWotetCNv5z2YLLbjC3dkEvIQThAx9li4woS53gAl6rL
 j
X-Google-Smtp-Source: AGHT+IEGTp6zoBWxULTLCPVGpsZxfqsigjeska7CBI8jZPAJnXiIgzZQzC9BSy53QrPzN7C2qc/Wmw==
X-Received: by 2002:a05:6870:3753:b0:22e:b952:6d2a with SMTP id
 a19-20020a056870375300b0022eb9526d2amr1200806oak.34.1712312715966; 
 Fri, 05 Apr 2024 03:25:15 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.15
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/32] plugins: Use translator_st for qemu_plugin_insn_data
Date: Fri,  5 Apr 2024 00:24:38 -1000
Message-Id: <20240405102459.462551-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
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

Use the bytes that we record for the entire TB, rather than
a per-insn GByteArray.  Record the length of the insn in
plugin_gen_insn_end rather than infering from the length
of the array.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 14 +-------------
 accel/tcg/plugin-gen.c |  7 +++++--
 accel/tcg/translator.c | 26 --------------------------
 plugins/api.c          | 12 +++++++-----
 tcg/tcg.c              |  3 +--
 5 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index 07b1755990..c32bb97667 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -97,11 +97,11 @@ struct qemu_plugin_dyn_cb {
 
 /* Internal context for instrumenting an instruction */
 struct qemu_plugin_insn {
-    GByteArray *data;
     uint64_t vaddr;
     void *haddr;
     GArray *insn_cbs;
     GArray *mem_cbs;
+    uint8_t len;
     bool calls_helpers;
 
     /* if set, the instruction calls helpers that might access guest memory */
@@ -116,18 +116,6 @@ struct qemu_plugin_scoreboard {
     QLIST_ENTRY(qemu_plugin_scoreboard) entry;
 };
 
-/*
- * qemu_plugin_insn allocate and cleanup functions. We don't expect to
- * cleanup many of these structures. They are reused for each fresh
- * translation.
- */
-
-static inline void qemu_plugin_insn_cleanup_fn(gpointer data)
-{
-    struct qemu_plugin_insn *insn = (struct qemu_plugin_insn *) data;
-    g_byte_array_free(insn->data, true);
-}
-
 /* Internal context for this TranslationBlock */
 struct qemu_plugin_tb {
     GPtrArray *insns;
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 94bbad6dc7..be2451be58 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -346,11 +346,9 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
     ptb->n = n;
     if (n <= ptb->insns->len) {
         insn = g_ptr_array_index(ptb->insns, n - 1);
-        g_byte_array_set_size(insn->data, 0);
     } else {
         assert(n - 1 == ptb->insns->len);
         insn = g_new0(struct qemu_plugin_insn, 1);
-        insn->data = g_byte_array_sized_new(4);
         g_ptr_array_add(ptb->insns, insn);
     }
 
@@ -389,6 +387,11 @@ void plugin_gen_insn_start(CPUState *cpu, const DisasContextBase *db)
 
 void plugin_gen_insn_end(void)
 {
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+    struct qemu_plugin_insn *pinsn = tcg_ctx->plugin_insn;
+
+    pinsn->len = db->fake_insn ? db->record_len : db->pc_next - pinsn->vaddr;
+
     tcg_gen_plugin_cb(PLUGIN_GEN_AFTER_INSN);
 }
 
diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 3421469a31..0a1d26b2e8 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -405,27 +405,6 @@ bool translator_st(const DisasContextBase *db, void *dest,
     return false;
 }
 
-static void plugin_insn_append(vaddr pc, const void *from, size_t size)
-{
-#ifdef CONFIG_PLUGIN
-    struct qemu_plugin_insn *insn = tcg_ctx->plugin_insn;
-    size_t off;
-
-    if (insn == NULL) {
-        return;
-    }
-    off = pc - insn->vaddr;
-    if (off < insn->data->len) {
-        g_byte_array_set_size(insn->data, off);
-    } else if (off > insn->data->len) {
-        /* we have an unexpected gap */
-        g_assert_not_reached();
-    }
-
-    insn->data = g_byte_array_append(insn->data, from, size);
-#endif
-}
-
 uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
     uint8_t raw;
@@ -434,7 +413,6 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = cpu_ldub_code(env, pc);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return raw;
 }
 
@@ -449,7 +427,6 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap16(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -464,7 +441,6 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap32(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -479,7 +455,6 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap64(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -488,5 +463,4 @@ void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
     assert(pc >= db->pc_first);
     db->fake_insn = true;
     record_save(db, pc, &insn8, sizeof(insn8));
-    plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
diff --git a/plugins/api.c b/plugins/api.c
index 4e9125ea29..7b8b7523b3 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -43,6 +43,7 @@
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
 #include "exec/ram_addr.h"
+#include "exec/translator.h"
 #include "disas/disas.h"
 #include "plugin.h"
 #ifndef CONFIG_USER_ONLY
@@ -219,14 +220,15 @@ qemu_plugin_tb_get_insn(const struct qemu_plugin_tb *tb, size_t idx)
 size_t qemu_plugin_insn_data(const struct qemu_plugin_insn *insn,
                              void *dest, size_t len)
 {
-    len = MIN(len, insn->data->len);
-    memcpy(dest, insn->data->data, len);
-    return len;
+    const DisasContextBase *db = tcg_ctx->plugin_db;
+
+    len = MIN(len, insn->len);
+    return translator_st(db, dest, insn->vaddr, len) ? len : 0;
 }
 
 size_t qemu_plugin_insn_size(const struct qemu_plugin_insn *insn)
 {
-    return insn->data->len;
+    return insn->len;
 }
 
 uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
@@ -242,7 +244,7 @@ void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 char *qemu_plugin_insn_disas(const struct qemu_plugin_insn *insn)
 {
     CPUState *cpu = current_cpu;
-    return plugin_disas(cpu, insn->vaddr, insn->data->len);
+    return plugin_disas(cpu, insn->vaddr, insn->len);
 }
 
 const char *qemu_plugin_insn_symbol(const struct qemu_plugin_insn *insn)
diff --git a/tcg/tcg.c b/tcg/tcg.c
index d248c52e96..691b2342a2 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -765,8 +765,7 @@ static void alloc_tcg_plugin_context(TCGContext *s)
 {
 #ifdef CONFIG_PLUGIN
     s->plugin_tb = g_new0(struct qemu_plugin_tb, 1);
-    s->plugin_tb->insns =
-        g_ptr_array_new_with_free_func(qemu_plugin_insn_cleanup_fn);
+    s->plugin_tb->insns = g_ptr_array_new();
 #endif
 }
 
-- 
2.34.1


