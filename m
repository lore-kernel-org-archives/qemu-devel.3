Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB5EEC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5f-0005rT-N4; Wed, 24 Apr 2024 19:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5b-0005oz-Qt
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:48 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5Y-0003Se-Gc
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:46 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-6001399f22bso308165a12.0
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001503; x=1714606303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=spELkUKERJaUgQmzIV25Fn+zqZ87OeTfDF4MrbqHfVg=;
 b=HGCo7v48Uy1cUFlBSbRzkyAABXU0//CsC2EZ5jRgge8+P86kCBZ/DKUAR6FT5OSgrC
 EmIt6mbU+bVffcEuPafNFVIpZ0nay3Bk+QwK2KmIm66V283e5GIOxfdYHGvJ7CPhzBKR
 80RWLj47MDwKkGU7F4Ydfm/6tULhj0gyyCJREDdCHBsj453aJ35tACKkJM2dpPX5VRgk
 LqYG1ZbRvUPapB5Mu5Z+AyAr2I9KP7VzEbJOCZUuR+L3Y84m3QzL/qXWTmjibs3fujLv
 IlFp18X/JlBZyLTgPqPEi9t0UvRaFAWknrcFoiUiSXrocrwDcQh0CGuJMsp/pzq0KQTq
 qfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001503; x=1714606303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=spELkUKERJaUgQmzIV25Fn+zqZ87OeTfDF4MrbqHfVg=;
 b=ekFl8q9ruYn/imEc7+sm3dzeUn/5xmo/FfkueDjWj6/6Bm3sdLuy3ZaoWjoEIOTNeC
 O3sn/0TkJnqmbGSCRZjNIzl+wMjO8lpYOzkTcL2pJ0T91D0F+7AIPgbSJxUIEE2zqscb
 0Nk6p2pm+UU8K/Q96gnq5+2LOgDgOpBtgT05SEHut3BfSkW+QPNqeY25X/+4UN5p1558
 9RYrzQHoH3kZ81BOq8HBWLvRYxGXtcBmLA5XWvVSafYEwVebJr+CuwIXkksTiXrOzk3Z
 NnlCSsK3VvdBOSvAm8vZ7dNla8lg2uGPZK6fJGgtqj5pZweAMlPNkqiSNJQQ3gEq5vjz
 ph1A==
X-Gm-Message-State: AOJu0YzBo7g3mpnIWjaw2t+gmviI+zIy/kgjbRAiXE4mIU91/ngtC2gD
 c+7W8P2PxU8ZwRPQ5GdQRWefKX8oYMirRFCrtFUHzngKmLCPzd4tThK5uohGzer3Bfctr8edaRg
 h
X-Google-Smtp-Source: AGHT+IFriozXI1N7NRD2Y8FUnALTTyJFN7ge5Ysl9OWOAJ/sCPUnrDRs0pnR4kW8zzHosex31owGWA==
X-Received: by 2002:a17:90b:b12:b0:2ab:a991:6eb8 with SMTP id
 bf18-20020a17090b0b1200b002aba9916eb8mr3876600pjb.42.1714001502905; 
 Wed, 24 Apr 2024 16:31:42 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/33] plugins: Use translator_st for qemu_plugin_insn_data
Date: Wed, 24 Apr 2024 16:31:09 -0700
Message-Id: <20240424233131.988727-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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
index 7f63a8085d..df73312f99 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -408,27 +408,6 @@ bool translator_st(const DisasContextBase *db, void *dest,
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
@@ -437,7 +416,6 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = cpu_ldub_code(env, pc);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return raw;
 }
 
@@ -452,7 +430,6 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap16(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -467,7 +444,6 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap32(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -482,7 +458,6 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap64(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -491,5 +466,4 @@ void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
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


