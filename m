Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1F5C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 23:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzm5d-0005qS-D5; Wed, 24 Apr 2024 19:31:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5W-0005m1-3U
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:42 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzm5S-0003Qy-8K
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 19:31:41 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-53fa455cd94so317031a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 16:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714001497; x=1714606297; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Zi6Hpm0Fqh5LXd8IFQ8rccUkOSCRSCULZssenmqa9PA=;
 b=WvzFw31QxE6cnWxz9gn7tGk8PR+M3zytGH9BtkZa3YiUk3poesq3ZTR8PsQ6GhjdOK
 CUxHh0y6AIq9HvJhfBxQaV5IWBB7nHFzkiAFV89LXqmD3DuBGLTC7PI7bErH/lm192dJ
 BhtYkRAlIJD2dWEMH9tTppDc2ZgaEKhR9hfXXDiYLOdj53D5wgSaYg+mPnXJzT1rNWUY
 +foXLS6gmzCRRuIuJS2e2ZEkii+kLjORgc6+elOqujJVx1p1HRb69TjtRy6eGyi03LtO
 5/FW+4Jm6isrr2TKeI7+ldpKkjjsfgewy2zOk1hTYZD+vUZXEYwM60Yrwh5K1EmQB2f7
 sYQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714001497; x=1714606297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zi6Hpm0Fqh5LXd8IFQ8rccUkOSCRSCULZssenmqa9PA=;
 b=hxr3gix0pkMxQ9+/5dEQXO/SZAfPNuGerfImR7oLEMnuVrUWMrEkyAS2mP2vKR5bk/
 ox//Mgs0/GYO8Xn7+otePqwC1F0HAPDxu6oofyYNUBrOmjrC3bDuSsZNKmhOdnVoC1Sl
 1yOB/txl3uxKNxWZD1icfSQoMylbYKGKz5b5tSFKBO5RIk9bkn+qqf8mA2N1HrbawQw3
 UjYogNNi90KVDgdEeKEWsGM9xUyWofnPg/hx6C9gsViMimaZte8btAaYYykcsGomLOq/
 UWAVUOGsfk81sHSf1ldhLgt1vok3EjdbzdFK3VrrXr/TMuN5nS8sW5AP6zakT822EFbD
 ruIA==
X-Gm-Message-State: AOJu0YzvX60Kkj0R0ODXOF1kpW4628sxILGmrV4iCDxr0Joz90UF1v4P
 YqkOOAXlaLf7xBnRG0V9LVKDeTLC9pPLBc5lUf40eSipWQY6qP826SBTPvtDpS/4QD6mZR78vzj
 8
X-Google-Smtp-Source: AGHT+IHwhR5xfin9iA7YLGctgCqAWSM/M//hYZvt9jejyXJbjaFPjkd/CCg1POtFSHTzEb6drUm55A==
X-Received: by 2002:a17:90a:1f46:b0:2a4:6a31:600c with SMTP id
 y6-20020a17090a1f4600b002a46a31600cmr3626461pjy.14.1714001496675; 
 Wed, 24 Apr 2024 16:31:36 -0700 (PDT)
Received: from stoup.. ([156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 z24-20020a17090abd9800b002a56b3931dfsm11737859pjr.49.2024.04.24.16.31.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Apr 2024 16:31:36 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 04/33] accel/tcg: Reorg translator_ld*
Date: Wed, 24 Apr 2024 16:31:02 -0700
Message-Id: <20240424233131.988727-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424233131.988727-1-richard.henderson@linaro.org>
References: <20240424233131.988727-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

Reorg translator_access into translator_ld, with a more
memcpy-ish interface.  If both pages are in ram, do not
go through the caller's slow path.

Assert that the access is within the two pages that we are
prepared to protect, per TranslationBlock.  Allow access
prior to pc_first, so long as it is within the first page.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translator.c | 189 ++++++++++++++++++++++-------------------
 1 file changed, 101 insertions(+), 88 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 92eb77c3a0..dbd54e25a2 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -229,69 +229,88 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
     }
 }
 
-static void *translator_access(CPUArchState *env, DisasContextBase *db,
-                               vaddr pc, size_t len)
+static bool translator_ld(CPUArchState *env, DisasContextBase *db,
+                          void *dest, vaddr pc, size_t len)
 {
+    TranslationBlock *tb = db->tb;
+    vaddr last = pc + len - 1;
     void *host;
-    vaddr base, end;
-    TranslationBlock *tb;
-
-    tb = db->tb;
+    vaddr base;
 
     /* Use slow path if first page is MMIO. */
     if (unlikely(tb_page_addr0(tb) == -1)) {
-        return NULL;
+        return false;
     }
 
-    end = pc + len - 1;
-    if (likely(is_same_page(db, end))) {
-        host = db->host_addr[0];
-        base = db->pc_first;
-    } else {
+    host = db->host_addr[0];
+    base = db->pc_first;
+
+    if (likely(((base ^ last) & TARGET_PAGE_MASK) == 0)) {
+        /* Entire read is from the first page. */
+        memcpy(dest, host + (pc - base), len);
+        return true;
+    }
+
+    if (unlikely(((base ^ pc) & TARGET_PAGE_MASK) == 0)) {
+        /* Read begins on the first page and extends to the second. */
+        size_t len0 = -(pc | TARGET_PAGE_MASK);
+        memcpy(dest, host + (pc - base), len0);
+        pc += len0;
+        dest += len0;
+        len -= len0;
+    }
+
+    /*
+     * The read must conclude on the second page and not extend to a third.
+     *
+     * TODO: We could allow the two pages to be virtually discontiguous,
+     * since we already allow the two pages to be physically discontiguous.
+     * The only reasonable use case would be executing an insn at the end
+     * of the address space wrapping around to the beginning.  For that,
+     * we would need to know the current width of the address space.
+     * In the meantime, assert.
+     */
+    base = (base & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+    assert(((base ^ pc) & TARGET_PAGE_MASK) == 0);
+    assert(((base ^ last) & TARGET_PAGE_MASK) == 0);
+    host = db->host_addr[1];
+
+    if (host == NULL) {
+        tb_page_addr_t page0, old_page1, new_page1;
+
+        new_page1 = get_page_addr_code_hostp(env, base, &db->host_addr[1]);
+
+        /*
+         * If the second page is MMIO, treat as if the first page
+         * was MMIO as well, so that we do not cache the TB.
+         */
+        if (unlikely(new_page1 == -1)) {
+            tb_unlock_pages(tb);
+            tb_set_page_addr0(tb, -1);
+            return false;
+        }
+
+        /*
+         * If this is not the first time around, and page1 matches,
+         * then we already have the page locked.  Alternately, we're
+         * not doing anything to prevent the PTE from changing, so
+         * we might wind up with a different page, requiring us to
+         * re-do the locking.
+         */
+        old_page1 = tb_page_addr1(tb);
+        if (likely(new_page1 != old_page1)) {
+            page0 = tb_page_addr0(tb);
+            if (unlikely(old_page1 != -1)) {
+                tb_unlock_page1(page0, old_page1);
+            }
+            tb_set_page_addr1(tb, new_page1);
+            tb_lock_page1(page0, new_page1);
+        }
         host = db->host_addr[1];
-        base = TARGET_PAGE_ALIGN(db->pc_first);
-        if (host == NULL) {
-            tb_page_addr_t page0, old_page1, new_page1;
-
-            new_page1 = get_page_addr_code_hostp(env, base, &db->host_addr[1]);
-
-            /*
-             * If the second page is MMIO, treat as if the first page
-             * was MMIO as well, so that we do not cache the TB.
-             */
-            if (unlikely(new_page1 == -1)) {
-                tb_unlock_pages(tb);
-                tb_set_page_addr0(tb, -1);
-                return NULL;
-            }
-
-            /*
-             * If this is not the first time around, and page1 matches,
-             * then we already have the page locked.  Alternately, we're
-             * not doing anything to prevent the PTE from changing, so
-             * we might wind up with a different page, requiring us to
-             * re-do the locking.
-             */
-            old_page1 = tb_page_addr1(tb);
-            if (likely(new_page1 != old_page1)) {
-                page0 = tb_page_addr0(tb);
-                if (unlikely(old_page1 != -1)) {
-                    tb_unlock_page1(page0, old_page1);
-                }
-                tb_set_page_addr1(tb, new_page1);
-                tb_lock_page1(page0, new_page1);
-            }
-            host = db->host_addr[1];
-        }
-
-        /* Use slow path when crossing pages. */
-        if (is_same_page(db, pc)) {
-            return NULL;
-        }
     }
 
-    tcg_debug_assert(pc >= base);
-    return host + (pc - base);
+    memcpy(dest, host + (pc - base), len);
+    return true;
 }
 
 static void plugin_insn_append(vaddr pc, const void *from, size_t size)
@@ -317,61 +336,55 @@ static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 
 uint8_t translator_ldub(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint8_t ret;
-    void *p = translator_access(env, db, pc, sizeof(ret));
+    uint8_t raw;
 
-    if (p) {
-        plugin_insn_append(pc, p, sizeof(ret));
-        return ldub_p(p);
+    if (!translator_ld(env, db, &raw, pc, sizeof(raw))) {
+        raw = cpu_ldub_code(env, pc);
     }
-    ret = cpu_ldub_code(env, pc);
-    plugin_insn_append(pc, &ret, sizeof(ret));
-    return ret;
+    plugin_insn_append(pc, &raw, sizeof(raw));
+    return raw;
 }
 
 uint16_t translator_lduw(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint16_t ret, plug;
-    void *p = translator_access(env, db, pc, sizeof(ret));
+    uint16_t raw, tgt;
 
-    if (p) {
-        plugin_insn_append(pc, p, sizeof(ret));
-        return lduw_p(p);
+    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
+        tgt = tswap16(raw);
+    } else {
+        tgt = cpu_lduw_code(env, pc);
+        raw = tswap16(tgt);
     }
-    ret = cpu_lduw_code(env, pc);
-    plug = tswap16(ret);
-    plugin_insn_append(pc, &plug, sizeof(ret));
-    return ret;
+    plugin_insn_append(pc, &raw, sizeof(raw));
+    return tgt;
 }
 
 uint32_t translator_ldl(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint32_t ret, plug;
-    void *p = translator_access(env, db, pc, sizeof(ret));
+    uint32_t raw, tgt;
 
-    if (p) {
-        plugin_insn_append(pc, p, sizeof(ret));
-        return ldl_p(p);
+    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
+        tgt = tswap32(raw);
+    } else {
+        tgt = cpu_ldl_code(env, pc);
+        raw = tswap32(tgt);
     }
-    ret = cpu_ldl_code(env, pc);
-    plug = tswap32(ret);
-    plugin_insn_append(pc, &plug, sizeof(ret));
-    return ret;
+    plugin_insn_append(pc, &raw, sizeof(raw));
+    return tgt;
 }
 
 uint64_t translator_ldq(CPUArchState *env, DisasContextBase *db, vaddr pc)
 {
-    uint64_t ret, plug;
-    void *p = translator_access(env, db, pc, sizeof(ret));
+    uint64_t raw, tgt;
 
-    if (p) {
-        plugin_insn_append(pc, p, sizeof(ret));
-        return ldq_p(p);
+    if (translator_ld(env, db, &raw, pc, sizeof(raw))) {
+        tgt = tswap64(raw);
+    } else {
+        tgt = cpu_ldl_code(env, pc);
+        raw = tswap64(tgt);
     }
-    ret = cpu_ldq_code(env, pc);
-    plug = tswap64(ret);
-    plugin_insn_append(pc, &plug, sizeof(ret));
-    return ret;
+    plugin_insn_append(pc, &raw, sizeof(raw));
+    return tgt;
 }
 
 void translator_fake_ldb(DisasContextBase *db, vaddr pc, uint8_t insn8)
-- 
2.34.1


