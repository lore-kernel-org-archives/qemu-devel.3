Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472DEC88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 12:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x50Ms-0008Un-3O; Fri, 11 Sep 2026 08:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50Mh-00089W-53
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x50Me-0007HK-Es
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 08:28:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789129699;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=979zCwnkRmygSGxKCH9J8vAZd03xV5BAo/pRxfuWj3g=;
 b=CTU8NQJnbUZexlhZ4lSBwSPy15xx/xNqzvPWSjpzB+kM6W3qawKuDaD2/7cN4yyDaCwD5O
 aZUKUmxyGqz3MKzho+jKMzel6etg0mEzhaUsGIbmILypWgJpn6P/4JJtyE/YpEQqJYaYZY
 NdYoDMOtaUcDA3TXdlq7KT4JvXG5lGU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-375-mWtMpTyyOgaQ7lzQqKiJIg-1; Fri,
 11 Sep 2026 08:28:15 -0400
X-MC-Unique: mWtMpTyyOgaQ7lzQqKiJIg-1
X-Mimecast-MFC-AGG-ID: mWtMpTyyOgaQ7lzQqKiJIg_1789129692
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F0AE818000A3; Fri, 11 Sep 2026 12:28:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 36AD53000229; Fri, 11 Sep 2026 12:28:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 16:27:33 +0400
Subject: [PATCH 10/10] monitor/hmp: remove legacy MonitorDef infrastructure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-query-reg-v1-10-0c04f0c02cf3@redhat.com>
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15504;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=eC8SEw4hvU/2RRVj6aOJp8vbLtR3fgOXXoOcFaHz75k=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqo/Ovk0q7FEydTWFavObsVehZpYnpVIKZzvwqV
 xIFFIztIpOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqPzrwAKCRDa6OEJdZac
 5WeRD/91SA/JyKRb0iH6bk7ENaeC8BfH7BJ1ajkpADBR+wrMJDkmYyfPu0/B59CfmtPwC22P1z/
 6ITn1nFIWJYGYGDNf6+FxwGimC9MHCY9oiQ10ulDPvovuDVHeYiePg9lI6wMNNrgTh7jMX3hkYZ
 myGQ4nuHhR+T0seWvP7gLfcfR0vsXZsHix2YiNPipSXweesoBiCB9/aIRHX0Di1DBkEgsQXgJ4F
 FNqKuBrm9nR0tYkT2Y3onXfJ8nF8mE5Cql4+qtkFaDYWqh9HDIoALgSW75fzKuhWlar4+8anrhd
 mr8Dnw3vqzcLRtqTkg1hBo9uHEms4GrBG9DzT/uKH6UYlDK7I8g6oKouVl09Zrhy1H/Bx7dUnoO
 PQtWmFG9PBBXMpnQz6MBzt4zUDHfxGSlt9H35x7NEDSDsJah8XemzzKOS6jDPdFLMm3ZOIAvKEP
 OJIEXtKM+dxbVVsOzeev6QTYPcxjY2Iot1p65V8PTvySraLPtWqchXPtqiFJuE8fF3Uho8Ep0ic
 ipSNLeY1uLHo3pDIpJinrxlXmTwXgI3hJ51FpgLErndmlnHLtUL/yCKc67Bz2mvbduE+RJz4HZ4
 ZAKqQuRIAmgOe6mxDrhH+Lak9P6LRKpVu/D8rHpkhO62D0hJ+hG5iXq9sd5gPBSuTBni3AV6fgj
 NxIqeiPRf4h6ZUQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Now that all targets expose their system registers via GDB register
descriptions (i386 segment limits, m68k, sparc64) and $pc is handled by
the CPUClass::get_pc fallback, the legacy MonitorDef table and
SysemuCPUOps::monitor_get_register callback are no longer needed.

Remove MonitorDef struct, the per-target monitor_defs arrays (i386,
m68k, sparc64), riscv_monitor_get_register_legacy(), and the
get_monitor_def() fallback in expr_unary(). HMP $register expressions
now use gdb_get_register_list() exclusively.

For RISC-V, the legacy callback provided case-insensitive register name
matching (e.g. $Mstatus) and a special message for vector
registers ("Unable to print the value of vector vreg"). The GDB-based
lookup is case-sensitive (consistent with all other targets) and reports
oversized registers as "unknown register" instead.

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
index e56eea18b785..3a85aa47e243 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -101,22 +101,6 @@ typedef struct SysemuCPUOps {
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
index 0a74247ca66a..f9621ce90aaf 100644
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
@@ -447,8 +447,6 @@ static bool get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
-static int get_monitor_def(MonitorHMP *mon, int64_t *pval, const char *name);
-
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(MonitorHMP *mon, const char *fmt, ...)
 {
@@ -530,8 +528,7 @@ static int64_t expr_unary(MonitorHMP *mon)
                 pch++;
             }
             *q = 0;
-            if (!get_register(mon, &reg, buf)
-                && get_monitor_def(mon, &reg, buf) < 0) {
+            if (!get_register(mon, &reg, buf)) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
@@ -1723,43 +1720,6 @@ void monitor_register_hmp_info_hrt(const char *name,
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
index b97f144aea5a..3218eae62854 100644
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
@@ -10852,34 +10851,6 @@ static const Property x86_cpu_properties[] = {
 
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
@@ -10893,9 +10864,6 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
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
index 5fff9d745e9b..9a57873ea5d3 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -3015,7 +3015,6 @@ static const struct SysemuCPUOps riscv_sysemu_ops = {
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
2.55.0.543.g5ebe2ebe4ea8


