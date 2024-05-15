Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F2B8C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2024 07:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s79Rt-0004Ic-94; Wed, 15 May 2024 03:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ro-0004FW-Fd
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:13 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s79Ra-0001Zc-Bh
 for qemu-devel@nongnu.org; Wed, 15 May 2024 03:53:09 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4200ee78e56so27942295e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 May 2024 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715759577; x=1716364377; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GBtVDB/HuYfnJ/hMo9HZFYBFCYQzVqAd1rDtPXWhcLA=;
 b=fUBy/HMM3UtB5cEwi/FmHGe3nMPn1dseEIiOA+ZouOgwnoy93a7kb8/WXS6dRXbOb0
 KGEY/ZmmZICqwWYkQzEbXt0tc4i0pFR7hKpW/MTXgptWHrW6Otiuz2mQ8Z5BkKSe1EyB
 kh9NkCKT6+m1QRaey8ovjpKBz9OoIk38+aOxfi+hZOoG7cYKgvtTgTlWbO6OcLeZWYac
 mEFHDPXYENTlwMBi8+4oIvT+sY26Awar4aOZyXOiE13mYXDIoOeBll4dRwUyL24MBipF
 2jUa/mvYRk5Fk19inPzaezgEXSMrauZaAzoWfG+FVHF7qbLCjXvuPHsFqCZngVYu6UEu
 spRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715759577; x=1716364377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GBtVDB/HuYfnJ/hMo9HZFYBFCYQzVqAd1rDtPXWhcLA=;
 b=tL+XOTob98OUDIqZAzxxdNF0JnjyTGK8CgK3o9XFjPIgnGSqjgHq8+g29Kik5AmWgm
 L9nNNL7qD5sWjsOALECIJdIHyVLXu1JGVQOt0OnPmKUVklfs+YfOdsWnSzWhi2g8cO+g
 ya4+pibbSpAJP+RE+GMO2f6dmUpAGWC8u3M+O6R6L143X1xXcc9NAHfG9PkcQ/Uegl4O
 l0ocr695Di2fbJ8im2NuM3Li5HO40rLgfCb20ojx+7cdpnFEC1vq5HrHQ6Yr/PQMka48
 gk878frbbGiDWV43pICBeB0l76zSq/K+OWvjXFCN1MXvdPKs1A4V7daWbmWJ7hEyj3C5
 KVeA==
X-Gm-Message-State: AOJu0YwXLF29124vk0/RMfldqf/rrfibgPee7rjsMoKJT4ZhcdItDk89
 Ffn1LRsLoDgPyRW32e2S5Ynppu65XcXqyY2mCMZkfijZ3yBMG1fF8d4I/CrL3mKajbt14B6dFKp
 scsA=
X-Google-Smtp-Source: AGHT+IEX6mGm03RJUFTJH1L46JupByRTBwMubvHEBxkSnhdqFi0aqwCnXmF6DGSOUQd9pRra6QMv6Q==
X-Received: by 2002:a05:600c:1914:b0:420:112e:6c1 with SMTP id
 5b1f17b1804b1-420112e06d1mr80027025e9.13.1715759576979; 
 Wed, 15 May 2024 00:52:56 -0700 (PDT)
Received: from stoup.. ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-41fccee9292sm222611855e9.37.2024.05.15.00.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 00:52:56 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 11/34] plugins: Use translator_st for qemu_plugin_insn_data
Date: Wed, 15 May 2024 09:52:24 +0200
Message-Id: <20240515075247.68024-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515075247.68024-1-richard.henderson@linaro.org>
References: <20240515075247.68024-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32d.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/plugin.h  | 14 +-------------
 accel/tcg/plugin-gen.c |  7 +++++--
 accel/tcg/translator.c | 26 --------------------------
 plugins/api.c          | 12 +++++++-----
 tcg/tcg.c              |  3 +--
 5 files changed, 14 insertions(+), 48 deletions(-)

diff --git a/include/qemu/plugin.h b/include/qemu/plugin.h
index b535bfd5de..c8dd2c42fa 100644
--- a/include/qemu/plugin.h
+++ b/include/qemu/plugin.h
@@ -98,11 +98,11 @@ struct qemu_plugin_dyn_cb {
 
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
@@ -117,18 +117,6 @@ struct qemu_plugin_scoreboard {
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
index 842da97204..716c8ec753 100644
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
index 01e1f0977b..986045154c 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -409,27 +409,6 @@ bool translator_st(const DisasContextBase *db, void *dest,
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
@@ -438,7 +417,6 @@ uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = cpu_ldub_code(env, pc);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return raw;
 }
 
@@ -453,7 +431,6 @@ uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap16(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -468,7 +445,6 @@ uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap32(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -483,7 +459,6 @@ uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
         raw = tswap64(tgt);
         record_save(db, pc, &raw, sizeof(raw));
     }
-    plugin_insn_append(pc, &raw, sizeof(raw));
     return tgt;
 }
 
@@ -492,5 +467,4 @@ void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
     assert(pc >= db->pc_first);
     db->fake_insn = true;
     record_save(db, pc, &insn8, sizeof(insn8));
-    plugin_insn_append(pc, &insn8, sizeof(insn8));
 }
diff --git a/plugins/api.c b/plugins/api.c
index 5ff4e9d325..15467acdfd 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -42,6 +42,7 @@
 #include "tcg/tcg.h"
 #include "exec/exec-all.h"
 #include "exec/gdbstub.h"
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
index d827c6d431..71daa5d268 100644
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


