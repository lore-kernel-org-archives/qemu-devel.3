Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6ACC47DB3
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 23:02:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUadJ-0005v7-B9; Mon, 29 Jan 2024 18:01:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUadC-0005uY-U8
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:38 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rUad8-0008Md-TW
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 18:01:33 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-290ec261a61so1815127a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 15:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706569289; x=1707174089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qYS/soxWe3h+ML5uFbbfcdAcoE+eOI+G62ajUSGtp3A=;
 b=fRCfdjhZNLeHGxftzyGomW7hJ8q7o5RZyH9eyOaAbs+yTn+mXsSntVdZ7Nr0BZGGfi
 fduN9gh79kDtD/fV7qntQ1KExr7MlyijAuJlAhNgSalZqqzqy1uW/cpeTExXdVuJsDoE
 6v9GqszrkQAmd9Xj9aOahM9082FSHsJeg/rcZaJYiryRx44DP+wzWIvblIgNYlDUXZUK
 8KnoWtQtfU3jIwfHBPsOdHyLH/dx2V43kyO4g803k/jEGeONin3LpXrCKy/FXsGeyLLY
 sICrRGYI6ZcAYBH9i6HsPANet2tzCzhKSUF5Q+sWsKzGw7WLGYB+WHD+q3KjsLcAfM19
 +eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706569289; x=1707174089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYS/soxWe3h+ML5uFbbfcdAcoE+eOI+G62ajUSGtp3A=;
 b=cQNPZ4c0VckUmPgvqwnOGo94+7anAEPuSYrN7oZx61tPO4j4WfDT1NMWVkZsRtsC46
 1gtLP7Z/EU8c6br6GmSbq5ACl9fYSFZxAUehIz/0whhZPYAOZTYSgSqTRRNcF9m77Pzk
 gnd1siL5tP3KR3amS+OAayN/gWM1iIYDZoM0NfjXodZ3QS3QWCozAmtMhiD4ZXz8zUF9
 SFozaNs6V7fQgDzNLXlJ0xoODB42u7fLPnTKK3lkU5mgGzjWXS0n5mNG5Xy7j2WpTWXz
 NMXH8lapS9eJB+L4v/GhNJkIDe2eo5j0vSs96u3goAjZNTvtCzcHSkS+FzKc43rcmOQs
 naHg==
X-Gm-Message-State: AOJu0Ywie9ME66Ojjv1v99Xuqhfr29++FWDdCa3YTOidVhAQcfT8VaXj
 h0vQfqNOpcKBTuR+bdlzRIy4WVuIbvbBzldyIZRN3n+peilSUlUk4r6csr6AR2NKlotu3B5anCK
 IC+c=
X-Google-Smtp-Source: AGHT+IGE6xkRhpJSI4MC1CfLpR+fDXbchjjPRPG4ziPrbNjOmEtdul3EBPYmgx/QRmZ4SlVejC9F3Q==
X-Received: by 2002:a17:902:d50a:b0:1d7:5f1b:49f3 with SMTP id
 b10-20020a170902d50a00b001d75f1b49f3mr4750928plg.120.1706569289265; 
 Mon, 29 Jan 2024 15:01:29 -0800 (PST)
Received: from stoup.. ([103.210.27.218]) by smtp.gmail.com with ESMTPSA id
 r10-20020aa78b8a000000b006ddcf56fb78sm6419368pfd.62.2024.01.29.15.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 15:01:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 01/31] cpu-exec: simplify jump cache management
Date: Tue, 30 Jan 2024 09:00:51 +1000
Message-Id: <20240129230121.8091-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129230121.8091-1-richard.henderson@linaro.org>
References: <20240129230121.8091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Unless I'm missing something egregious, the jmp cache is only every
populated with a valid entry by the same thread that reads the cache.
Therefore, the contents of any valid entry are always consistent and
there is no need for any acquire/release magic.

Indeed ->tb has to be accessed with atomics, because concurrent
invalidations would otherwise cause data races.  But ->pc is only ever
accessed by one thread, and accesses to ->tb and ->pc within tb_lookup
can never race with another tb_lookup.  While the TranslationBlock
(especially the flags) could be modified by a concurrent invalidation,
store-release and load-acquire operations on the cache entry would
not add any additional ordering beyond what you get from performing
the accesses within a single thread.

Because of this, there is really nothing to win in splitting the CF_PCREL
and !CF_PCREL paths.  It is easier to just always use the ->pc field in
the jump cache.

I noticed this while working on splitting commit 8ed558ec0cb
("accel/tcg: Introduce TARGET_TB_PCREL", 2022-10-04) into multiple
pieces, for the sake of finding a more fine-grained bisection
result for https://gitlab.com/qemu-project/qemu/-/issues/2092.
It does not (and does not intend to) fix that issue; therefore
it may make sense to not commit it until the root cause
of issue #2092 is found.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240122153409.351959-1-pbonzini@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tb-jmp-cache.h |  8 +++--
 accel/tcg/cpu-exec.c     | 66 ++++++++++++++--------------------------
 2 files changed, 28 insertions(+), 46 deletions(-)

diff --git a/accel/tcg/tb-jmp-cache.h b/accel/tcg/tb-jmp-cache.h
index bb424c8a05..4ab8553afc 100644
--- a/accel/tcg/tb-jmp-cache.h
+++ b/accel/tcg/tb-jmp-cache.h
@@ -13,9 +13,11 @@
 #define TB_JMP_CACHE_SIZE (1 << TB_JMP_CACHE_BITS)
 
 /*
- * Accessed in parallel; all accesses to 'tb' must be atomic.
- * For CF_PCREL, accesses to 'pc' must be protected by a
- * load_acquire/store_release to 'tb'.
+ * Invalidated in parallel; all accesses to 'tb' must be atomic.
+ * A valid entry is read/written by a single CPU, therefore there is
+ * no need for qatomic_rcu_read() and pc is always consistent with a
+ * non-NULL value of 'tb'.  Strictly speaking pc is only needed for
+ * CF_PCREL, but it's used always for simplicity.
  */
 struct CPUJumpCache {
     struct rcu_head rcu;
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 67eda9865e..40c268bfa1 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -253,43 +253,29 @@ static inline TranslationBlock *tb_lookup(CPUState *cpu, vaddr pc,
     hash = tb_jmp_cache_hash_func(pc);
     jc = cpu->tb_jmp_cache;
 
-    if (cflags & CF_PCREL) {
-        /* Use acquire to ensure current load of pc from jc. */
-        tb = qatomic_load_acquire(&jc->array[hash].tb);
-
-        if (likely(tb &&
-                   jc->array[hash].pc == pc &&
-                   tb->cs_base == cs_base &&
-                   tb->flags == flags &&
-                   tb_cflags(tb) == cflags)) {
-            return tb;
-        }
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
-        if (tb == NULL) {
-            return NULL;
-        }
-        jc->array[hash].pc = pc;
-        /* Ensure pc is written first. */
-        qatomic_store_release(&jc->array[hash].tb, tb);
-    } else {
-        /* Use rcu_read to ensure current load of pc from *tb. */
-        tb = qatomic_rcu_read(&jc->array[hash].tb);
-
-        if (likely(tb &&
-                   tb->pc == pc &&
-                   tb->cs_base == cs_base &&
-                   tb->flags == flags &&
-                   tb_cflags(tb) == cflags)) {
-            return tb;
-        }
-        tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
-        if (tb == NULL) {
-            return NULL;
-        }
-        /* Use the pc value already stored in tb->pc. */
-        qatomic_set(&jc->array[hash].tb, tb);
+    tb = qatomic_read(&jc->array[hash].tb);
+    if (likely(tb &&
+               jc->array[hash].pc == pc &&
+               tb->cs_base == cs_base &&
+               tb->flags == flags &&
+               tb_cflags(tb) == cflags)) {
+        goto hit;
     }
 
+    tb = tb_htable_lookup(cpu, pc, cs_base, flags, cflags);
+    if (tb == NULL) {
+        return NULL;
+    }
+
+    jc->array[hash].pc = pc;
+    qatomic_set(&jc->array[hash].tb, tb);
+
+hit:
+    /*
+     * As long as tb is not NULL, the contents are consistent.  Therefore,
+     * the virtual PC has to match for non-CF_PCREL translations.
+     */
+    assert((tb_cflags(tb) & CF_PCREL) || tb->pc == pc);
     return tb;
 }
 
@@ -1012,14 +998,8 @@ cpu_exec_loop(CPUState *cpu, SyncClocks *sc)
                  */
                 h = tb_jmp_cache_hash_func(pc);
                 jc = cpu->tb_jmp_cache;
-                if (cflags & CF_PCREL) {
-                    jc->array[h].pc = pc;
-                    /* Ensure pc is written first. */
-                    qatomic_store_release(&jc->array[h].tb, tb);
-                } else {
-                    /* Use the pc value already stored in tb->pc. */
-                    qatomic_set(&jc->array[h].tb, tb);
-                }
+                jc->array[h].pc = pc;
+                qatomic_set(&jc->array[h].tb, tb);
             }
 
 #ifndef CONFIG_USER_ONLY
-- 
2.34.1


