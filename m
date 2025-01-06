Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A28E77198
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 20:05:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUtK5-0002hz-8i; Mon, 06 Jan 2025 15:03:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtK1-0002do-1t
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:33 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tUtJx-0003CX-Rp
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 15:03:32 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43618283d48so106994855e9.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 12:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736193808; x=1736798608; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CfaBEiOdRjHzzwUS3kiFtedqZxggxEJ4hucj9YdleWw=;
 b=vUFUXIgYaZ13C/B9EU9+VVK9D9LStH6BKoOq0cr+XrBDkNEBm6Okidv3TZgxAKa65K
 iClacdlfa7wzw93lGiSzOjlWzc7wqe3fhJX0PCMZtys0tl/8whGpIecPY08cih91hCqF
 ny4h3lLsdpxv6YwX340zyWjsOUEQEE+qP0/5KNrlhOJJHUlHIaboZR+IC2mCnxnuwHDu
 h9gX5mRUWQO/rObXkeZuuUf0b/ZKX9WA8TbGPjmleogWFUFISNTzpXTuGlKSdDofB7Sq
 1GnGN5uISm+dZ1mXwE243YFU8zMwKAMkdTCHs5QN3BS1BKO4iuHGa+Dkqo4EWj/FPuJK
 KzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736193808; x=1736798608;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CfaBEiOdRjHzzwUS3kiFtedqZxggxEJ4hucj9YdleWw=;
 b=hNq9yhXssGIb88K0z+mys8WnNaZmjPlQe/9pUXcdAxHuTjG02OuZroK+PLihSoGrVi
 MGtd4RMTYwh+I0rPQk9lwLUlmZAi+pDES/ifJHOVfA/iKmOS3U64VBfTE+o6u21hsyWp
 cihZFnnqsD1YpcHELGUTys1r3QnUlxZAxABXHIvBAK82LBDhK4K/Qjb4vVBOR5YHtFh7
 3BlE9y0YmV1nb3PZphMODDDhuc77ET2zE6fX+g1Ya7ErBjgevDTub5prH8HLRVUImzVd
 h7fK9/GCUMseRw4NlbVwnfi7XcA46IiiQbCvDyvMjTSt7XufIuPmQRSGd0dxhB5u0VA2
 Xkxg==
X-Gm-Message-State: AOJu0Yy6Y/DuVuwn6/fe+A396Ye4npcADYPFnAg2Ia+T6LgKAD5Z3Kz1
 ynlNmHGnw+MldNsc4B3dHlQjm8AFKAa5TJDJN6OjAu7i6gjWmKiAGjThc6IHVlcZ1BIdWelff65
 fsPI=
X-Gm-Gg: ASbGncv9xH5PBiDQ0bhkcfVM3BA4xW70z+KR6UYhp5UlcE9twPsRAO9UHSgv+wDBB/D
 AzLwbznp4JBLPZk3AlbNz2LwPG27BIx03X4t+g/zKCSnqKbTm/DRpa7GRU5gnNAJtArcEsWN12i
 aj9RdTSXZj5wk73TwY2pg0jZAap4mzT43PWO7MLCw4pU2IRa439S8NIzWfCac2heCYeVNv7OM3Q
 UM8HPQwImJsnO9mJetaxYAvRolNMJ0RG49KjsXuQg4MNT156gwt50vts3vFHDORVTLWR03inbYr
 Ogl3ahVid35HvB3F5zODo00MFuUHk9M=
X-Google-Smtp-Source: AGHT+IF3+buEkSMAzhBuTtka5TQV/I34nAgDx1rHh3g80/cDyG64W7K1EH4+aemix37pseTOETajew==
X-Received: by 2002:a05:600c:4f94:b0:434:f871:1b96 with SMTP id
 5b1f17b1804b1-43668b7a1dfmr474821135e9.29.1736193807616; 
 Mon, 06 Jan 2025 12:03:27 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656af6cbbsm610646205e9.3.2025.01.06.12.03.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Jan 2025 12:03:26 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Cameron Esfahani <dirty@apple.com>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Alexander Graf <agraf@csgraf.de>, Paul Durrant <paul@xen.org>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Riku Voipio <riku.voipio@iki.fi>, Anthony PERARD <anthony@xenproject.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Zhao Liu <zhao1.liu@intel.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw2@infradead.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Anton Johansson <anjo@rev.ng>
Subject: [RFC PATCH 4/7] accel/tcg: Use CPU_FOREACH_TCG()
Date: Mon,  6 Jan 2025 21:02:55 +0100
Message-ID: <20250106200258.37008-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106200258.37008-1-philmd@linaro.org>
References: <20250106200258.37008-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Only iterate over TCG vCPUs when running TCG specific code.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/cputlb.c           |  7 ++++---
 accel/tcg/monitor.c          |  3 ++-
 accel/tcg/tb-maint.c         |  7 ++++---
 accel/tcg/tcg-accel-ops-rr.c | 10 +++++-----
 accel/tcg/tcg-accel-ops.c    |  8 ++++----
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index b4ccf0cdcb7..06f34df808b 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -48,6 +48,7 @@
 #endif
 #include "tcg/tcg-ldst.h"
 #include "tcg/oversized-guest.h"
+#include "tcg-accel-ops.h"
 
 /* DEBUG defines, enable DEBUG_TLB_LOG to log to the CPU_LOG_MMU target */
 /* #define DEBUG_TLB */
@@ -368,7 +369,7 @@ static void flush_all_helper(CPUState *src, run_on_cpu_func fn,
 {
     CPUState *cpu;
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_TCG(cpu) {
         if (cpu != src) {
             async_run_on_cpu(cpu, fn, d);
         }
@@ -646,7 +647,7 @@ void tlb_flush_page_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
         TLBFlushPageByMMUIdxData *d;
 
         /* Allocate a separate data block for each destination cpu.  */
-        CPU_FOREACH(dst_cpu) {
+        CPU_FOREACH_TCG(dst_cpu) {
             if (dst_cpu != src_cpu) {
                 d = g_new(TLBFlushPageByMMUIdxData, 1);
                 d->addr = addr;
@@ -839,7 +840,7 @@ void tlb_flush_range_by_mmuidx_all_cpus_synced(CPUState *src_cpu,
     d.bits = bits;
 
     /* Allocate a separate data block for each destination cpu.  */
-    CPU_FOREACH(dst_cpu) {
+    CPU_FOREACH_TCG(dst_cpu) {
         if (dst_cpu != src_cpu) {
             p = g_memdup(&d, sizeof(d));
             async_run_on_cpu(dst_cpu, tlb_flush_range_by_mmuidx_async_1,
diff --git a/accel/tcg/monitor.c b/accel/tcg/monitor.c
index ae1dbeb79f8..98bd937ae20 100644
--- a/accel/tcg/monitor.c
+++ b/accel/tcg/monitor.c
@@ -19,6 +19,7 @@
 #include "tcg/tcg.h"
 #include "internal-common.h"
 #include "tb-context.h"
+#include "tcg-accel-ops.h"
 
 
 static void dump_drift_info(GString *buf)
@@ -131,7 +132,7 @@ static void tlb_flush_counts(size_t *pfull, size_t *ppart, size_t *pelide)
     CPUState *cpu;
     size_t full = 0, part = 0, elide = 0;
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_TCG(cpu) {
         full += qatomic_read(&cpu->neg.tlb.c.full_flush_count);
         part += qatomic_read(&cpu->neg.tlb.c.part_flush_count);
         elide += qatomic_read(&cpu->neg.tlb.c.elide_flush_count);
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3f1bebf6ab5..8598c59654f 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -36,6 +36,7 @@
 #ifdef CONFIG_USER_ONLY
 #include "user/page-protection.h"
 #endif
+#include "tcg-accel-ops.h"
 
 
 /* List iterators for lists of tagged pointers in TranslationBlock. */
@@ -771,7 +772,7 @@ static void do_tb_flush(CPUState *cpu, run_on_cpu_data tb_flush_count)
     }
     did_flush = true;
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_TCG(cpu) {
         tcg_flush_jmp_cache(cpu);
     }
 
@@ -885,13 +886,13 @@ static void tb_jmp_cache_inval_tb(TranslationBlock *tb)
 
     if (tb_cflags(tb) & CF_PCREL) {
         /* A TB may be at any virtual address */
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             tcg_flush_jmp_cache(cpu);
         }
     } else {
         uint32_t h = tb_jmp_cache_hash_func(tb->pc);
 
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             CPUJumpCache *jc = cpu->tb_jmp_cache;
 
             if (qatomic_read(&jc->array[h].tb) == tb) {
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 028b385af9a..e5ce285efb9 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -42,7 +42,7 @@ void rr_kick_vcpu_thread(CPUState *unused)
 {
     CPUState *cpu;
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_TCG(cpu) {
         cpu_exit(cpu);
     };
 }
@@ -116,7 +116,7 @@ static void rr_wait_io_event(void)
 
     rr_start_kick_timer();
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_TCG(cpu) {
         qemu_wait_io_event_common(cpu);
     }
 }
@@ -129,7 +129,7 @@ static void rr_deal_with_unplugged_cpus(void)
 {
     CPUState *cpu;
 
-    CPU_FOREACH(cpu) {
+    CPU_FOREACH_TCG(cpu) {
         if (cpu->unplug && !cpu_can_run(cpu)) {
             tcg_cpu_destroy(cpu);
             break;
@@ -160,7 +160,7 @@ static int rr_cpu_count(void)
 
     if (cpu_list_generation_id_get() != last_gen_id) {
         cpu_count = 0;
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             ++cpu_count;
         }
         last_gen_id = cpu_list_generation_id_get();
@@ -201,7 +201,7 @@ static void *rr_cpu_thread_fn(void *arg)
         qemu_cond_wait_bql(first_cpu->halt_cond);
 
         /* process any pending work */
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             current_cpu = cpu;
             qemu_wait_io_event_common(cpu);
         }
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 1fb077f7b38..371bbaa0307 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -144,7 +144,7 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     switch (type) {
     case GDB_BREAKPOINT_SW:
     case GDB_BREAKPOINT_HW:
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             err = cpu_breakpoint_insert(cpu, addr, BP_GDB, NULL);
             if (err) {
                 break;
@@ -154,7 +154,7 @@ static int tcg_insert_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             err = cpu_watchpoint_insert(cpu, addr, len,
                                         xlat_gdb_type(cpu, type), NULL);
             if (err) {
@@ -175,7 +175,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     switch (type) {
     case GDB_BREAKPOINT_SW:
     case GDB_BREAKPOINT_HW:
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             err = cpu_breakpoint_remove(cpu, addr, BP_GDB);
             if (err) {
                 break;
@@ -185,7 +185,7 @@ static int tcg_remove_breakpoint(CPUState *cs, int type, vaddr addr, vaddr len)
     case GDB_WATCHPOINT_WRITE:
     case GDB_WATCHPOINT_READ:
     case GDB_WATCHPOINT_ACCESS:
-        CPU_FOREACH(cpu) {
+        CPU_FOREACH_TCG(cpu) {
             err = cpu_watchpoint_remove(cpu, addr, len,
                                         xlat_gdb_type(cpu, type));
             if (err) {
-- 
2.47.1


