Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC6A9C021A1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Feb 2025 03:33:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tgy3z-0005qV-4o; Sat, 08 Feb 2025 22:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3p-0005p9-Hh
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 22:32:45 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1tgy3m-0001Pk-90
 for qemu-devel@nongnu.org; Sat, 08 Feb 2025 22:32:43 -0500
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-21f48ab13d5so49139005ad.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2025 19:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739071960; x=1739676760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bASirKS+zBZ/cXg1G6SS+ljxL6qPKc/2+Hbke0UzVIc=;
 b=m7S+1I5apFAaL7b+fjP8x/wTykDbZ2NANqo1S86md22Pd/i0kQ5MPIgEKzmhAvbYis
 YyAsuIQ/vhs0UenTlNAJwBza2l7AkUU/uptnHjrAdcYGPHzZK3hmojKw2dWal0xh9cOd
 5soGPtvGONP7Y3MH5szwXt4CvIsCLZyLqBN0UnAjcjeyivQTcXBb5tc5RHSt++uk5sP2
 0Iz77SDLklvGI3z9U8H1pqT/ZOm2yWMICajCOhsvvythMhlZ9NUPesN4HExKiUVcavot
 0N+RQRL3s7KZOCmgsSLBOiNbh+P6UUGXE0mAvhKAa1DWtiEnS9mLFXRzrwMGP3Mmqo5M
 TZow==
X-Gm-Message-State: AOJu0YzTRhLlYpQPLq7+9FJ9mLQF/nejreucx1K0nQvFoyjpwA/w9YA4
 iFWnAK1nhrBQDRTkNIqgR9hEHbYdoffZast3Ee5FXHX0Z91Y9cIIQHFHaLmF
X-Gm-Gg: ASbGncvx12Bv0L0lnWZFb89kzPPXSAmMkSez0SuX6xvkZeE9zQnIKt3Q36PxWIRlYHS
 yIX0DzejuUDv1wqU1L6RfEr5MC+u+RIOjp6G1rQGur1HyMAMbJTNTaYuGqcDk88ua+lnmG38EjI
 ZBi2K/tqwsSmmpwTpamSq5LjcorSwmROPVtiratwONXAAhoyKcSXDWFFpDGJGmLP6ukd1ij7rtY
 ZNuX6ZVv+p1xol9NUHcHwEd6FIgssbHjml+GfiEPKwy3xA/nivGCozaJ7ZakbzGzpA++K10RatG
 4p7vnRXXOcNxBiuwiZcQOUbZdDtjZLM6w8a7BX/1Ks04DA4=
X-Google-Smtp-Source: AGHT+IET3ItL6IwDQSW+LvvjAuQEHgmLznl5BqwpKqZzxtN48FxwOD0XQyawSkogY4qzFs1DgPxqgA==
X-Received: by 2002:a05:6a21:9205:b0:1e1:aa24:2e58 with SMTP id
 adf61e73a8af0-1ee03a22ce7mr17546406637.7.1739071960591; 
 Sat, 08 Feb 2025 19:32:40 -0800 (PST)
Received: from localhost.localdomain
 ([2607:fb90:9e97:4903:dc10:4530:8a3f:fdb6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad5453e2366sm1333610a12.47.2025.02.08.19.32.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Feb 2025 19:32:40 -0800 (PST)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 2/4] cpu-target: support emulation from non-TCG accels
Date: Sat,  8 Feb 2025 19:32:31 -0800
Message-ID: <20250209033233.53853-3-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20250209033233.53853-1-j@getutm.app>
References: <20250209033233.53853-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.178; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f178.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.07, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

We create a toggle to allow TCG emulation to be used dynamically when
running other accelerators. Tracking dirty code can be expensive so we
need to flush the TLBs and TBs every time we toggle emulation mode. Plugin
support is currently disabled when running in this mode.

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 include/hw/core/cpu.h     | 10 ++++++++++
 accel/tcg/plugin-gen.c    |  4 ++++
 accel/tcg/tb-maint.c      |  2 +-
 accel/tcg/tcg-accel-ops.c |  3 ++-
 cpu-target.c              | 13 +++++++++++++
 plugins/core.c            | 12 ++++++++++++
 system/physmem.c          |  5 +++--
 7 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index e3c8450f8f..dbbaca06ee 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -569,6 +569,9 @@ struct CPUState {
     /* track IOMMUs whose translations we've cached in the TCG TLB */
     GArray *iommu_notifiers;
 
+    /* doing emulation when not in TCG backend */
+    bool emulation_enabled;
+
     /*
      * MUST BE LAST in order to minimize the displacement to CPUArchState.
      */
@@ -1083,6 +1086,13 @@ void qemu_init_vcpu(CPUState *cpu);
  */
 void cpu_single_step(CPUState *cpu, int enabled);
 
+/**
+ * cpu_emulate:
+ * @cpu: CPU to set to emulation mode
+ * @enabled: enable emulation mode
+ */
+void cpu_emulate(CPUState *cpu, bool enabled);
+
 /* Breakpoint/watchpoint flags */
 #define BP_MEM_READ           0x01
 #define BP_MEM_WRITE          0x02
diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 7e5f040bf7..e07dffeb00 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -388,6 +388,10 @@ bool plugin_gen_tb_start(CPUState *cpu, const DisasContextBase *db)
 {
     struct qemu_plugin_tb *ptb;
 
+    if (cpu->emulation_enabled) {
+        return false;
+    }
+
     if (!test_bit(QEMU_PLUGIN_EV_VCPU_TB_TRANS,
                   cpu->plugin_state->event_mask)) {
         return false;
diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 3f1bebf6ab..14d4bed347 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -791,7 +791,7 @@ done:
 
 void tb_flush(CPUState *cpu)
 {
-    if (tcg_enabled()) {
+    if (tcg_enabled() || unlikely(cpu->emulation_enabled)) {
         unsigned tb_flush_count = qatomic_read(&tb_ctx.tb_flush_count);
 
         if (cpu_in_serial_context(cpu)) {
diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index 6e3f1fa92b..3c07407ccf 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -32,6 +32,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/guest-random.h"
 #include "qemu/timer.h"
+#include "exec/cpu-common.h"
 #include "exec/exec-all.h"
 #include "exec/hwaddr.h"
 #include "exec/tb-flush.h"
@@ -74,7 +75,7 @@ void tcg_cpu_destroy(CPUState *cpu)
 int tcg_cpu_exec(CPUState *cpu)
 {
     int ret;
-    assert(tcg_enabled());
+    assert(tcg_enabled() || cpu->emulation_enabled);
     cpu_exec_start(cpu);
     ret = cpu_exec(cpu);
     cpu_exec_end(cpu);
diff --git a/cpu-target.c b/cpu-target.c
index 6293477ed9..8df75e915a 100644
--- a/cpu-target.c
+++ b/cpu-target.c
@@ -339,6 +339,19 @@ void cpu_single_step(CPUState *cpu, int enabled)
     }
 }
 
+void cpu_emulate(CPUState *cpu, bool enabled)
+{
+    if (cpu->emulation_enabled != enabled) {
+        cpu->emulation_enabled = enabled;
+
+        if (enabled) {
+            /* FIXME: track dirty code to improve performance */
+            tb_flush(cpu);
+            tlb_flush(cpu);
+        }
+    }
+}
+
 void cpu_abort(CPUState *cpu, const char *fmt, ...)
 {
     va_list ap;
diff --git a/plugins/core.c b/plugins/core.c
index bb105e8e68..dee6ffd722 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -55,6 +55,10 @@ struct qemu_plugin_ctx *plugin_id_to_ctx_locked(qemu_plugin_id_t id)
 
 static void plugin_cpu_update__async(CPUState *cpu, run_on_cpu_data data)
 {
+    if (cpu->emulation_enabled) {
+        return;
+    }
+
     bitmap_copy(cpu->plugin_state->event_mask,
                 &data.host_ulong, QEMU_PLUGIN_EV_MAX);
     tcg_flush_jmp_cache(cpu);
@@ -499,6 +503,10 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL;
 
+    if (cpu->emulation_enabled) {
+        return;
+    }
+
     if (!test_bit(ev, cpu->plugin_state->event_mask)) {
         return;
     }
@@ -521,6 +529,10 @@ void qemu_plugin_vcpu_syscall_ret(CPUState *cpu, int64_t num, int64_t ret)
     struct qemu_plugin_cb *cb, *next;
     enum qemu_plugin_event ev = QEMU_PLUGIN_EV_VCPU_SYSCALL_RET;
 
+    if (cpu->emulation_enabled) {
+        return;
+    }
+
     if (!test_bit(ev, cpu->plugin_state->event_mask)) {
         return;
     }
diff --git a/system/physmem.c b/system/physmem.c
index 67c9db9daa..4bb2976646 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2696,7 +2696,9 @@ static void tcg_commit_cpu(CPUState *cpu, run_on_cpu_data data)
     CPUAddressSpace *cpuas = data.host_ptr;
 
     cpuas->memory_dispatch = address_space_to_dispatch(cpuas->as);
-    tlb_flush(cpu);
+    if (tcg_enabled() || cpu->emulation_enabled) {
+        tlb_flush(cpu);
+    }
 }
 
 static void tcg_commit(MemoryListener *listener)
@@ -2704,7 +2706,6 @@ static void tcg_commit(MemoryListener *listener)
     CPUAddressSpace *cpuas;
     CPUState *cpu;
 
-    assert(tcg_enabled());
     /* since each CPU stores ram addresses in its TLB cache, we must
        reset the modified entries */
     cpuas = container_of(listener, CPUAddressSpace, tcg_as_listener);
-- 
2.41.0


