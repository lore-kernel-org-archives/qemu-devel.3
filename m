Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C16CA9ED0
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 20:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGMkL-0004Kb-Qz; Mon, 12 Oct 2026 16:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMk4-0003gm-U7
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xGMk1-0003QH-HC
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 16:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791837324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5vbtFf72T0N48LuB/QC6JVL+EfNDPldJPgJc3nOj6g=;
 b=SiJEJmqYVpcVLAtLTSrp3t1GM098ILeEEMsf5hjAb6nj/jRg6upyw3Ts1fJow1iUgQQ/Fq
 tncYraZAECI2yWsOltyhkIe/zdKMn5iK7b7TomhRrVvka3wZRZkRKF0KovvZDe6NPkazSD
 qYtyJTVDoGliu0/bsTvADs2p7XfhfZs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-FfKfkT6hOaqlaHfmsdpzAw-1; Mon,
 12 Oct 2026 20:35:20 +0000
X-MC-Unique: FfKfkT6hOaqlaHfmsdpzAw-1
X-Mimecast-MFC-AGG-ID: FfKfkT6hOaqlaHfmsdpzAw_1791837317
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0F2381800611; Mon, 12 Oct 2026 20:35:17 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C5D430000E7; Mon, 12 Oct 2026 20:35:15 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 13 Oct 2026 00:34:13 +0400
Subject: [PATCH v2 10/10] monitor/hmp: remove legacy MonitorDef infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261013-query-reg-v2-10-6f95a2e139a9@redhat.com>
References: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
In-Reply-To: <20261013-query-reg-v2-0-6f95a2e139a9@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=15612;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PIz68Lravk3qogWLrBKuIAOtp0uxbqDWrDgGR8VnrQI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqzURBCSdbWFJyWXskWBWVdSGtRKG2EMwk/Li5v
 hEI03yhU5aJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCas1EQQAKCRDa6OEJdZac
 5UExD/9ZSsgcnvgTOQUeAM7B/+SrfPu5iJAO/J6Kf+iwUg4QR5NkCQqJJ/s+cAvLT3CTl6YxDhA
 bVRw4UUMvXvmWpEiMYlsukiL30jDc6zYatVbtkefbSSI06iniegmSf2YUuTpIMuETrOn+Yg6t3B
 zsFMe0AzW+RcDqutWmdAG3D52kouDdcAr7kPeL3tGYPjjfuSokn6CdB7ItNJQbmbAuEfJ4t1sXf
 gfpRgcwpZ028l4vNP9R1BsqAiBuEtQeN5a6pSPzDIF3ahmMmLtnaCIau8X8Xi0MA4/ZvrDr3ctI
 DXYsM7MRCalMMjf9OmLi4nHFeDsb6z2DsK3fpeLio4uwXkh026aj58/fL1sc53s12vtP0R6Rb92
 x2K1dlNFLF3lJGx2rIi75kn6Y6K38T/Dus/Hxi9JqR3OUDDmNk5NReVFLzV0jVq2Sq897bfqcqm
 16smVuIjn+QLGyj3CQXfijwwI+tObjBVBfBIhGrF691yKy8gM7qdRQj7Ls1L9Edjir5FlBttqRX
 yIo/vJyWw9g38DMoTNfNq1kPjEP2bNQ4QuaZDtAM2fZu994P/+pcxLVDs6pZvyT8npLmgUD2bD8
 unuXKuNeog8gZCcjdEXAxtDjrRJUOjj5EtwXYOFPN484VyjER9DyTqsorUHTJbyvu0boDUQHkBX
 zBWCtwFMZSbO0Hg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Now that all targets expose their system registers via internal GDB
register descriptions (i386 segment limits, m68k, sparc64, RISC-V
aliases), the legacy MonitorDef table and
SysemuCPUOps::monitor_get_register callback are no longer needed.

Remove MonitorDef struct, the per-target monitor_defs arrays (i386,
m68k, sparc64), riscv_monitor_get_register_legacy(), and the
get_monitor_def() fallback in expr_unary(). HMP $register expressions
now use gdb_get_register_list() exclusively.

Known behavioural changes:

- x86: $pc no longer works; use $eip or $rip instead. The old
  MonitorDef provided a synthetic $pc alias, but a generic $pc is
  misleading on x86 and the new GDB-based lookup does not synthesize
  it.

- RISC-V: CSR lookup is now case-sensitive (consistent with all other
  targets). Vector registers report "unknown register" instead of the
  target-specific "Unable to print the value of vector vreg" message.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/sysemu-cpu-ops.h |  16 -----
 include/monitor/hmp.h            |   6 --
 include/qemu/typedefs.h          |   1 -
 monitor/hmp.c                    |  44 +-----------
 target/i386/cpu.c                |  32 ---------
 target/m68k/cpu.c                |  22 ------
 target/riscv/cpu.c               |   1 -
 target/riscv/internals.h         |   3 -
 target/riscv/monitor.c           | 140 ---------------------------------------
 target/sparc/cpu.c               |  19 ------
 10 files changed, 2 insertions(+), 282 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index d125540262d2..daac2a3b13b1 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -103,22 +103,6 @@ typedef struct SysemuCPUOps {
      */
     bool (*internal_is_big_endian)(CPUState *cpu);
 
-    /**
-     * @monitor_get_register: Callback to fill @pval with register @name value.
-     *                        This field is legacy, use @gdb_core_xml_file
-     *                        to dump registers instead.
-     * Returns: 0 on success or negative errno on failure.
-     */
-    int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
-
-#ifdef CONFIG_HMP
-    /**
-     * @monitor_defs: Array of MonitorDef entries. This field is legacy,
-     *                use @gdb_core_xml_file to dump registers instead.
-     */
-    const MonitorDef *monitor_defs;
-#endif
-
     /**
      * @legacy_vmsd: Legacy state for migration.
      *               Do not use in new targets, use #DeviceClass::vmsd instead.
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ef53e87f7608..950dd931d452 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -31,12 +31,6 @@ MonitorHMP *monitor_cur_hmp(void);
         g_assert_not_reached(); \
     }
 
-struct MonitorDef {
-    const char *name;
-    int offset;
-    int64_t (*get_value)(MonitorHMP *hmp, const MonitorDef *md, int offset);
-};
-
 void monitor_new_hmp(const char *id, const char *chardev_id,
                      bool use_readline, Error **errp);
 
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 2344c92182ea..5580e1fc4aba 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -72,7 +72,6 @@ typedef struct MemoryRegionSection MemoryRegionSection;
 typedef struct MigrationIncomingState MigrationIncomingState;
 typedef struct MigrationState MigrationState;
 typedef struct Monitor Monitor;
-typedef struct MonitorDef MonitorDef;
 typedef struct MSIMessage MSIMessage;
 typedef struct NetClientState NetClientState;
 typedef struct NetFilterState NetFilterState;
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 10e19e417aba..ab8465ebb0d7 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -24,8 +24,8 @@
 
 #include "qemu/osdep.h"
 #include <dirent.h>
+#include "hw/core/cpu.h"
 #include "hw/core/qdev.h"
-#include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
 #include "monitor-hmp-internal.h"
 #include "monitor/hmp.h"
@@ -443,8 +443,6 @@ static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
-static int get_monitor_def(MonitorHMP *mon, int64_t *pval, const char *name);
-
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(MonitorHMP *mon, const char *fmt, ...)
 {
@@ -526,8 +524,7 @@ static int64_t expr_unary(MonitorHMP *mon)
                 pch++;
             }
             *q = 0;
-            if (!gdb_get_register(mon, &reg, buf)
-                && get_monitor_def(mon, &reg, buf) < 0) {
+            if (!gdb_get_register(mon, &reg, buf)) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
@@ -1719,43 +1716,6 @@ void monitor_register_hmp_info_hrt(const char *name,
     g_assert_not_reached();
 }
 
-/*
- * Set @pval to the value in the register identified by @name.
- * return 0 if OK, -1 if not found
- */
-static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
-{
-    CPUState *cs = monitor_hmp_get_cpu(hmp);
-    const MonitorDef *md = NULL;
-    void *ptr;
-
-    if (cs == NULL) {
-        return -1;
-    }
-    md = cs->cc->sysemu_ops->monitor_defs;
-    if (md == NULL) {
-        return -1;
-    }
-
-    for (; md->name != NULL; md++) {
-        if (hmp_compare_cmd(name, md->name)) {
-            if (md->get_value) {
-                *pval = md->get_value(hmp, md, md->offset);
-            } else {
-                CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
-                ptr = (uint8_t *)env + md->offset;
-                *pval = *(int32_t *)ptr;
-            }
-            return 0;
-        }
-    }
-
-    if (!cs->cc->sysemu_ops->monitor_get_register) {
-        return -1;
-    }
-    return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
-}
-
 int monitor_hmp_vprintf(MonitorHMP *hmp, const char *fmt, va_list ap)
 {
     g_autofree char *buf = g_strdup_vprintf(fmt, ap);
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 74eebeabd7a7..191837a586d4 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -42,7 +42,6 @@
 #include "exec/watchpoint.h"
 #ifndef CONFIG_USER_ONLY
 #include "confidential-guest.h"
-#include "monitor/hmp.h"
 #include "system/reset.h"
 #include "qapi/qapi-commands-machine.h"
 #include "system/address-spaces.h"
@@ -10878,34 +10877,6 @@ static const Property x86_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
-#ifdef CONFIG_HMP
-static int64_t monitor_get_pc(MonitorHMP *hmp, const struct MonitorDef *md,
-                              int offset)
-{
-    CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
-    int64_t ret = env->eip + env->segs[R_CS].base;
-
-    if (!(env->hflags & HF_CS64_MASK)) {
-        ret = (int32_t)ret;
-    }
-    return ret;
-}
-
-static const MonitorDef x86_monitor_defs[] = {
-#define SEG(name, seg) \
-    { name ".limit", offsetof(CPUX86State, segs[seg].limit) },
-    SEG("cs", R_CS)
-    SEG("ds", R_DS)
-    SEG("es", R_ES)
-    SEG("ss", R_SS)
-    SEG("fs", R_FS)
-    SEG("gs", R_GS)
-    { "pc", 0, monitor_get_pc, },
-    { NULL },
-#undef SEG
-};
-#endif
-
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps i386_sysemu_ops = {
@@ -10919,9 +10890,6 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
-#ifdef CONFIG_HMP
-    .monitor_defs = x86_monitor_defs,
-#endif
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9b52ad5fc234..ad7303305848 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -25,7 +25,6 @@
 #include "disas/capstone.h"
 #ifndef CONFIG_USER_ONLY
 #include "migration/vmstate.h"
-#include "monitor/hmp.h"
 #endif
 
 #include "cpu.h"
@@ -666,32 +665,11 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
-#ifdef CONFIG_HMP
-static const MonitorDef m68k_monitor_defs[] = {
-    { "ssp", offsetof(CPUM68KState, sp[0]) },
-    { "usp", offsetof(CPUM68KState, sp[1]) },
-    { "isp", offsetof(CPUM68KState, sp[2]) },
-    { "sfc", offsetof(CPUM68KState, sfc) },
-    { "dfc", offsetof(CPUM68KState, dfc) },
-    { "urp", offsetof(CPUM68KState, mmu.urp) },
-    { "srp", offsetof(CPUM68KState, mmu.srp) },
-    { "dttr0", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR0]) },
-    { "dttr1", offsetof(CPUM68KState, mmu.ttr[M68K_DTTR1]) },
-    { "ittr0", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR0]) },
-    { "ittr1", offsetof(CPUM68KState, mmu.ttr[M68K_ITTR1]) },
-    { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
-    { NULL },
-};
-#endif
-
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
-#ifdef CONFIG_HMP
-    .monitor_defs = m68k_monitor_defs,
-#endif
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index da4c1a090b9b..7c4cadfc44b2 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3018,7 +3018,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
     .legacy_vmsd = &vmstate_riscv_cpu,
 #ifdef CONFIG_TCG
     .translate_for_debug = riscv_cpu_translate_for_debug,
-    .monitor_get_register = riscv_monitor_get_register_legacy,
 #endif
 };
 #endif
diff --git a/target/riscv/internals.h b/target/riscv/internals.h
index 5d84e4de960a..09aa2701197e 100644
--- a/target/riscv/internals.h
+++ b/target/riscv/internals.h
@@ -263,7 +263,4 @@ static inline int insn_len(uint16_t first_word)
     return (first_word & 3) == 3 ? 4 : 2;
 }
 
-int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
-                                      int64_t *pval);
-
 #endif
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 7e61ae2a4717..20f3ba57ae57 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -19,10 +19,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/ctype.h"
-#include "qemu/qemu-print.h"
 #include "cpu.h"
-#include "target/riscv/tcg/csr.h"
 #include "cpu_bits.h"
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
@@ -247,140 +244,3 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
     mem_info_svxx(hmp, env);
 }
 #endif /* CONFIG_HMP */
-
-#ifdef CONFIG_TCG
-static bool reg_is_ulong_integer(CPURISCVState *env, const char *name,
-                                 target_ulong *val, bool is_gprh)
-{
-    const char * const *reg_names;
-    uint64_t *vals;
-
-    if (is_gprh) {
-        reg_names = riscv_int_regnamesh;
-        vals = env->gprh;
-    } else {
-        reg_names = riscv_int_regnames;
-        vals = env->gpr;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(reg_names[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = vals[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_u64_fpu(CPURISCVState *env, const char *name, uint64_t *val)
-{
-    if (qemu_tolower(name[0]) != 'f') {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        g_auto(GStrv) reg_name = g_strsplit(riscv_fpr_regnames[i], "/", 2);
-
-        g_assert(reg_name[0]);
-        g_assert(reg_name[1]);
-
-        if (g_ascii_strcasecmp(reg_name[0], name) == 0 ||
-            g_ascii_strcasecmp(reg_name[1], name) == 0) {
-            *val = env->fpr[i];
-            return true;
-        }
-    }
-
-    return false;
-}
-
-static bool reg_is_vreg(const char *name)
-{
-    if (qemu_tolower(name[0]) != 'v' || strlen(name) > 3) {
-        return false;
-    }
-
-    for (int i = 0; i < 32; i++) {
-        if (g_ascii_strcasecmp(name, riscv_rvv_regnames[i]) == 0) {
-            return true;
-        }
-    }
-
-    return false;
-}
-
-int riscv_monitor_get_register_legacy(CPUState *cs, const char *name,
-                                      int64_t *pval)
-{
-    RISCVCPU *hart = RISCV_CPU(cs);
-    CPURISCVState *env = cpu_env(cs);
-    target_ulong val = 0;
-    uint64_t val64 = 0;
-    int i;
-
-    if (reg_is_ulong_integer(env, name, &val, false) ||
-        reg_is_ulong_integer(env, name, &val, true)) {
-        *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
-        return 0;
-    }
-
-    if (reg_is_u64_fpu(env, name, &val64)) {
-        *pval = val64;
-        return 0;
-    }
-
-    if (reg_is_vreg(name)) {
-        if (!riscv_cpu_cfg(env)->ext_zve32x) {
-            return -EINVAL;
-        }
-
-        qemu_printf("Unable to print the value of vector "
-                    "vreg '%s' from this API\n", name);
-
-        /*
-         * We're returning 0 because returning -EINVAL triggers
-         * an 'unknown register' message in exp_unary() later,
-         * which feels ankward after our own error message.
-         */
-        *pval = 0;
-        return 0;
-    }
-
-    for (i = 0; i < ARRAY_SIZE(csr_ops); i++) {
-        RISCVException res;
-        int csrno = i;
-
-        /*
-         * Early skip when possible since we're going
-         * through a lot of NULL entries.
-         */
-        if (csr_ops[csrno].predicate == NULL) {
-            continue;
-        }
-
-        if (g_ascii_strcasecmp(csr_ops[csrno].name, name) != 0) {
-            continue;
-        }
-
-        res = riscv_csrrw_debug(env, csrno, &val, 0, 0);
-
-        /*
-         * Rely on the smode, hmode, etc, predicates within csr.c
-         * to do the filtering of the registers that are present.
-         */
-        if (res == RISCV_EXCP_NONE) {
-            *pval = riscv_cpu_is_32bit(hart) ? (int32_t)val : val;
-            return 0;
-        }
-    }
-
-    return -EINVAL;
-}
-#endif
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index ae9bdca9df82..89dfb091ca87 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -995,31 +995,12 @@ static const Property sparc_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
-#ifdef TARGET_SPARC64
-#include "monitor/hmp.h"
-#ifdef CONFIG_HMP
-static const MonitorDef sparc64_monitor_defs[] = {
-    { "asi", offsetof(CPUSPARCState, asi) },
-    { "pstate", offsetof(CPUSPARCState, pstate) },
-    { "cansave", offsetof(CPUSPARCState, cansave) },
-    { "canrestore", offsetof(CPUSPARCState, canrestore) },
-    { "otherwin", offsetof(CPUSPARCState, otherwin) },
-    { "wstate", offsetof(CPUSPARCState, wstate) },
-    { "cleanwin", offsetof(CPUSPARCState, cleanwin) },
-    { NULL },
-};
-#endif
-#endif
-
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
     .get_phys_addr_debug = sparc_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
-#if defined(TARGET_SPARC64) && defined(CONFIG_HMP)
-    .monitor_defs = sparc64_monitor_defs,
-#endif
 };
 #endif
 

-- 
2.56.0.116.g6de20f6092dc


