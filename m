Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9216CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsgl5-0005xn-C3; Fri, 05 Apr 2024 06:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgl1-0005xB-Kt
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:15 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rsgkw-0004YW-Dk
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:25:15 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6e6b22af648so2323833b3a.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712312707; x=1712917507; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5ibAm5kxv+pEhpJp4At58jRSN3sWMTqwF+92dVbLS0I=;
 b=g1DnHM3P7VNGayCl/ZXw91UmCVD9Wliexr5u7AsbFqdfBMdZTFqIOjZFGgGWazftDz
 GFbrnx6YBGFbMJX6Knq887HT2M4a9oGuKYEtjnUpXJfcNKBVBcNYIDnMMqMplKpdVQ4a
 v+VPsJn45FvaftOdwKiqGrbkSOHMKTmuccJ4TbwtZsGe94x4Kgv0XgQNMc5O4ATnD6aN
 0qunkJ8gAVFV0WWqYGVPGiBmZohOz4VWY+rIl+CEQceoSe5+HsQDrXiVzRUtIwcrwksI
 jyPco06FCviRmz2FTWrpTykVW4/XjivLPvyvxksDEFr6L1mOfGDgVpUgiJ+as+efalWV
 T/5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712312707; x=1712917507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ibAm5kxv+pEhpJp4At58jRSN3sWMTqwF+92dVbLS0I=;
 b=nJZp3qiLo6U7c6jP1Gcppb5+G4PcE18BsuVzGnmV/GuG08TyBkLiNSnrpXx7exAGhX
 FCB7vZBSpOfVEWlcAVoAI7Z+bE7uKGV19hDhYwmYMZi/F2g4ZDqHlK1liXu3Z6E1UT5f
 JGCmU8F6asJ5A2ZQBMdUAEMRuxSBOP+nj9l0NyEUxRF3CnRGOP583woXZXd/Go4NCaOw
 d/U597MDJHuDxD165zzjyK419VMDdyPxtxYFC/w0cEZWxCaQkJTcVuS2TdGJgTiNaJ/x
 bRnQDSEK4UIyB1AEVvM2LkP/vo0Rqt3TYZkMwWuP34cB90kPihe1RqRAodta+lqLMQKD
 HXKQ==
X-Gm-Message-State: AOJu0YygkMidW+vq1NsA4gOIHl3B3QxbLrPdCtI29HwxhKw94EYF3D/E
 kQjAG0BNNYIxYiz/glWf9I8iuBznyOS8TpB6ysDjejhCoYgs6aahhVY+AytnRAHN0I1Tf1GrIF5
 g
X-Google-Smtp-Source: AGHT+IHuVmbN6hyBgt70TxR7cVZdhjlw6v+/mHDZtVwVtvH8p9FPi41/bI+PiFRun4b6SRP1kJP3kQ==
X-Received: by 2002:a05:6a20:2585:b0:1a5:6a94:7641 with SMTP id
 k5-20020a056a20258500b001a56a947641mr2877957pzd.7.1712312706896; 
 Fri, 05 Apr 2024 03:25:06 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 h10-20020a63f90a000000b005e438fe702dsm1104304pgi.65.2024.04.05.03.25.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:25:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/32] accel/tcg: Reorg translator_ld*
Date: Fri,  5 Apr 2024 00:24:31 -1000
Message-Id: <20240405102459.462551-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405102459.462551-1-richard.henderson@linaro.org>
References: <20240405102459.462551-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
index 64cfa4e003..42beb1c9b7 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -226,69 +226,88 @@ void translator_loop(CPUState *cpu, TranslationBlock *tb, int *max_insns,
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
@@ -314,61 +333,55 @@ static void plugin_insn_append(vaddr pc, const void *from, size_t size)
 
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


