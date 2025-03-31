Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDC27C3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 15:55:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzHTc-0001CW-U8; Mon, 31 Mar 2025 11:55:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHTB-00017h-O4; Mon, 31 Mar 2025 11:54:37 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tzHT9-0005HQ-Tl; Mon, 31 Mar 2025 11:54:37 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso83845935ad.1; 
 Mon, 31 Mar 2025 08:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743436474; x=1744041274; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GPm0HEVj/5XtqCVFVrqVVxFLck+tf0rECB7NfAJLETY=;
 b=XzMeyGOiDIpYXOvTQdEU857F8P0TNdXStQNAL+OvtZyJ5oaFIqDGZ87q5ZSG/Qn59X
 zcRD2fA7y5qKH5fM3TM7d19PxNtuHrlaKITJeqENxRRroxR34nvsYwZAgtAuPH45br/O
 sicO4eOM5PjyuxIk39J6i91St3YG+TKmMJRxq/xHL/CwjOlvbxEYf/3WSwZo0riYd8ZM
 iOBmwh7WinlGtH+ZUUWQ6VevwXRCh+Q1jNFvcCFVT1UPEGFrhrkEoEpG2RGuEgas1R6E
 mINelOCOu7yq5jKbNfjy60tRXw0xIQZCdQqyVCBKA2+KJPJCLaA3UAeBhPkEPZxOMDob
 3zIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743436474; x=1744041274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPm0HEVj/5XtqCVFVrqVVxFLck+tf0rECB7NfAJLETY=;
 b=OCphpjhptCY2SvIP/FLFI/0LcAm0TDtjJq0+upK3fvoUNThx5dueZ82ACMcacnfQBg
 QWbWGXvktjMYYvx/RTJe5OITLyZs/LFZ9dYjKjD4wzIlkaeW9bZZt2f4mxu3GLfRLcdc
 HrmGs0jzqyJpgoh+JZGSCXIIacqxGavvc6VMO/2IOCx3n2/EE2+uxjsK/FHrQvr9axuG
 fHUZzUaWMS1sla84P7eVELPqX9Ax3QtYGhQdQ5QczliBZn3jMS9E+IudClnHmiqKANls
 +9CY+SBmovnkLzW/DyEMzBCnVQx4f16e5WEChFzxiKyqrNm/Gluoo4QpUei1g1R9ET1F
 0GEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUObjurdW8WhO8Wamr/Q06bL/uvg7Qw/IgeRG/dKTCX5oEzsGn39hNsvbosyqLlpui4jVOvV2e2mYBh@nongnu.org
X-Gm-Message-State: AOJu0YwIKdQZeQXGXbwdSkeSptK29isG7elHWXddr1QQJdnpQ8Q1TVhg
 LQ9aWBUhQJM02zkD0q8BtGqSoQ4y85fCSNPjaCfiOWExsQrQ47UTGNG+Og==
X-Gm-Gg: ASbGncuv9TjeR8xJY15MVyNKUzAE74qKqfNKmDy7IDjTZTjqgJYy5R0KHZdCzxLSpjq
 xRfcO+onUeo1xDZffKuaL8XIrljrq7VfQAQ4ZVwyI+/mLVOvgKkpGWidsLH8OJouq74sywsHVQ7
 RVvwWLRzjUMygP3blphtYqVm4+4S2RxtODn2EighlhIiqkLaatM/pjKZDt/WGsZA33bEnVIGEs2
 lA1AjjsjCNlsx1QtjiTLxHaoS4qqGX6vqeepkO9WpiQ9jASyPwIV6X0yubZX9zgr8KQ1iRYln+G
 5Q2lGYN50sheVVrY7gmdk3uVn+nHc4ZWsrLUzgNpvBcW7d0SraiSiJOng6tX
X-Google-Smtp-Source: AGHT+IFRnAnF1BilpJu2PVRIndeQMQDlFPoqHcyeVarpSz09ZaPY8FmLgh1cEKParZnyhjwYAe5D5A==
X-Received: by 2002:a17:902:d485:b0:223:fb95:b019 with SMTP id
 d9443c01a7336-22921d4fc97mr185646065ad.24.1743436473749; 
 Mon, 31 Mar 2025 08:54:33 -0700 (PDT)
Received: from wheely.local0.net ([203.185.207.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2291eec6fbdsm70742045ad.16.2025.03.31.08.54.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 08:54:33 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 1/3] accel/tcg: Option to permit incoherent translation
 block cache vs stores
Date: Tue,  1 Apr 2025 01:54:21 +1000
Message-ID: <20250331155423.619451-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331155423.619451-1-npiggin@gmail.com>
References: <20250331155423.619451-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Add an option TARGET_HAS_LAZY_ICACHE that does not invalidate TBs upon
store, but instead tracks that the icache has become incoherent, and
provides a tb_flush_incoherent() function that the target may call to
bring the TB back to coherency.

XXX: docs/devel/tcg.rst says that this is not permitted because TB must
be coherent with memory to handle exceptions correctly... I'm not sure
where this is, maybe it can be worked around and is not a showstopper?
---
 accel/tcg/tb-internal.h  | 10 ++++++
 include/exec/tb-flush.h  |  3 ++
 accel/tcg/cputlb.c       | 15 +++++++--
 accel/tcg/tb-maint.c     | 73 ++++++++++++++++++++++++++++++++++++++++
 system/memory_ldst.c.inc |  2 +-
 5 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/tb-internal.h b/accel/tcg/tb-internal.h
index 68aa8d17f41..ccc59eac3f5 100644
--- a/accel/tcg/tb-internal.h
+++ b/accel/tcg/tb-internal.h
@@ -82,6 +82,16 @@ void tb_unlock_pages(TranslationBlock *);
 void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
                                    unsigned size,
                                    uintptr_t retaddr);
+#ifdef TARGET_HAS_LAZY_ICACHE
+void tb_store_to_phys_range(ram_addr_t ram_addr,
+                            unsigned size, uintptr_t retaddr);
+#else
+static inline void tb_store_to_phys_range(ram_addr_t ram_addr,
+                            unsigned size, uintptr_t retaddr)
+{
+    tb_invalidate_phys_range_fast(ram_addr, size, retaddr);
+}
+#endif
 #endif /* CONFIG_SOFTMMU */
 
 bool tb_invalidate_phys_page_unwind(tb_page_addr_t addr, uintptr_t pc);
diff --git a/include/exec/tb-flush.h b/include/exec/tb-flush.h
index 142c240d94c..1f8b718be57 100644
--- a/include/exec/tb-flush.h
+++ b/include/exec/tb-flush.h
@@ -23,6 +23,9 @@
  */
 void tb_flush(CPUState *cs);
 
+/* like tb_flush() but only flush incoherent blocks */
+void tb_flush_incoherent(CPUState *cpu);
+
 void tcg_flush_jmp_cache(CPUState *cs);
 
 #endif /* _TB_FLUSH_H_ */
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 500c8d3adc0..2a19c82e5d4 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1338,18 +1338,27 @@ static void notdirty_write(CPUState *cpu, vaddr mem_vaddr, unsigned size,
                            CPUTLBEntryFull *full, uintptr_t retaddr)
 {
     ram_addr_t ram_addr = mem_vaddr + full->xlat_section;
+    uint8_t mask;
 
     trace_memory_notdirty_write_access(mem_vaddr, ram_addr, size);
 
     if (!cpu_physical_memory_get_dirty_flag(ram_addr, DIRTY_MEMORY_CODE)) {
-        tb_invalidate_phys_range_fast(ram_addr, size, retaddr);
+        tb_store_to_phys_range(ram_addr, size, retaddr);
     }
 
     /*
      * Set both VGA and migration bits for simplicity and to remove
-     * the notdirty callback faster.
+     * the notdirty callback faster. Incoherent icache also sets the
+     * code bit because incoherency is tracked and resolved in the TB
+     * code.
      */
-    cpu_physical_memory_set_dirty_range(ram_addr, size, DIRTY_CLIENTS_NOCODE);
+#ifdef TARGET_HAS_LAZY_ICACHE
+    mask = DIRTY_CLIENTS_ALL;
+#else
+    mask = DIRTY_CLIENTS_NOCODE;
+#endif
+
+    cpu_physical_memory_set_dirty_range(ram_addr, size, mask);
 
     /* We remove the notdirty callback only if the code has been flushed. */
     if (!cpu_physical_memory_is_clean(ram_addr)) {
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3f1bebf6ab5..4f634469456 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -60,10 +60,20 @@ static bool tb_cmp(const void *ap, const void *bp)
             tb_page_addr1(a) == tb_page_addr1(b));
 }
 
+#ifdef TARGET_HAS_LAZY_ICACHE
+static QemuSpin icache_incoherent_lock;
+static bool icache_incoherent;
+static ram_addr_t icache_incoherent_start;
+static ram_addr_t icache_incoherent_end;
+#endif
+
 void tb_htable_init(void)
 {
     unsigned int mode = QHT_MODE_AUTO_RESIZE;
 
+#ifdef TARGET_HAS_LAZY_ICACHE
+    qemu_spin_init(&icache_incoherent_lock);
+#endif
     qht_init(&tb_ctx.htable, tb_cmp, CODE_GEN_HTABLE_SIZE, mode);
 }
 
@@ -803,6 +813,35 @@ void tb_flush(CPUState *cpu)
     }
 }
 
+#ifdef TARGET_HAS_LAZY_ICACHE
+static void do_tb_flush_incoherent(CPUState *cpu, run_on_cpu_data data)
+{
+    /* Should be no other CPUs running */
+    assert(!qemu_spin_trylock(&icache_incoherent_lock));
+    if (icache_incoherent) {
+        unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
+
+        tb_invalidate_phys_range(icache_incoherent_start,
+                                 icache_incoherent_end);
+        icache_incoherent = false;
+        icache_incoherent_start = 0;
+        icache_incoherent_end = 0;
+        qemu_spin_unlock(&icache_incoherent_lock);
+
+        do_tb_flush(cpu, RUN_ON_CPU_HOST_INT(tb_flush_count));
+    } else {
+        qemu_spin_unlock(&icache_incoherent_lock);
+    }
+}
+
+void tb_flush_incoherent(CPUState *cpu)
+{
+    if (tcg_enabled() && icache_incoherent) {
+        async_safe_run_on_cpu(cpu, do_tb_flush_incoherent, RUN_ON_CPU_NULL);
+    }
+}
+#endif
+
 /* remove @orig from its @n_orig-th jump list */
 static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
 {
@@ -1231,4 +1270,38 @@ void tb_invalidate_phys_range_fast(ram_addr_t ram_addr,
     page_collection_unlock(pages);
 }
 
+
+void tb_store_to_phys_range(ram_addr_t ram_addr,
+                            unsigned size, uintptr_t retaddr)
+{
+#ifndef TARGET_HAS_LAZY_ICACHE
+    tb_invalidate_phys_range_fast(ram_addr, size, retaddr);
+#else
+    ram_addr_t start, end;
+
+    /*
+     * Address comes in as byte-wise, but the cputlb dirty tracking operates
+     * on a page basis and will not be called a second time on the same page,
+     * so must cover a full page here.
+     */
+    start = ROUND_DOWN(ram_addr, TARGET_PAGE_SIZE);
+    end = ROUND_UP(ram_addr + size, TARGET_PAGE_SIZE) - 1;
+
+    qemu_spin_lock(&icache_incoherent_lock);
+    if (icache_incoherent) {
+        if (start < icache_incoherent_start) {
+            icache_incoherent_start = start;
+        }
+        if (end > icache_incoherent_end) {
+            icache_incoherent_end = end;
+        }
+    } else {
+        icache_incoherent = true;
+        icache_incoherent_start = start;
+        icache_incoherent_end = end;
+    }
+    qemu_spin_unlock(&icache_incoherent_lock);
+#endif
+}
+
 #endif /* CONFIG_USER_ONLY */
diff --git a/system/memory_ldst.c.inc b/system/memory_ldst.c.inc
index 7f32d3d9ff3..029d9749d57 100644
--- a/system/memory_ldst.c.inc
+++ b/system/memory_ldst.c.inc
@@ -286,7 +286,7 @@ void glue(address_space_stl_notdirty, SUFFIX)(ARG1_DECL,
         stl_p(ptr, val);
 
         dirty_log_mask = memory_region_get_dirty_log_mask(mr);
-        dirty_log_mask &= ~(1 << DIRTY_MEMORY_CODE);
+        dirty_log_mask &= DIRTY_CLIENTS_NOCODE;
         cpu_physical_memory_set_dirty_range(memory_region_get_ram_addr(mr) + addr,
                                             4, dirty_log_mask);
         r = MEMTX_OK;
-- 
2.47.1


