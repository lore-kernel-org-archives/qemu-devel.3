Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38106C5DF66
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgKR-0007TH-0T; Sun, 16 Aug 2026 15:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKO-0007J9-Ez
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgKI-0008Dx-O2
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:15:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/tSTH9Fcc7PWh6vPeau9/c5WlR100WbWT1IoGN0aZLM=;
 b=dHShGd8voIur2am/R59tLc5shot+qBVp+B0o3Xs59Hfll1KyOuVFcFchgkFJ27a+AyLQaz
 UnFNj0mhIEqlLxYp/5+wZwQjyXQoH61WC6DO2gXOP+8BwtDDG4HBdw+cpWn7bl4MhW4C9o
 yW4PqR1wih9c93s+OWlQhYHz8NnCvxM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-203-_5dz3Kc-OD-tlyrWCbgoQA-1; Sun,
 16 Aug 2026 15:15:17 -0400
X-MC-Unique: _5dz3Kc-OD-tlyrWCbgoQA-1
X-Mimecast-MFC-AGG-ID: _5dz3Kc-OD-tlyrWCbgoQA_1786907714
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5699C1956088; Sun, 16 Aug 2026 19:15:14 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA48730001A2; Sun, 16 Aug 2026 19:15:12 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:13:03 +0400
Subject: [PATCH v3 36/49] monitor: tighten monitor_set_cpu()/get_cpu()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-36-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, 
 Yoshinori Sato <yoshinori.sato@nifty.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=18297;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=MfzBWXcdO7bR1T0ihwCdwz5mnsGcj9uvrIxKyGP2/2o=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguz2jcx55GFt9l5uo2cFg3gz55HZb8p3DcJS
 h4WCJ5gfuaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILswAKCRDa6OEJdZac
 5cO6D/9fLutiOxMcRfcFo2Osm1xjIcNrpYAXsLBOJGBK5xnzCqI/8fKPeTxh2g5DsETxoZD8y8d
 Jr5JMh9R7NkMdavg8VC/s/z2gNfrWwEyC7lWKdiv/OhRRpE1rcaS73YADdiFVJ+4TANJw0G9jiZ
 yqn+H22l7a685KawWgBmnZBVdgkiPeQf1nHmfP7qeqy2OUq4S221g1Vu2fOe2Wx7f4wKkg8Odho
 dzJ2iY6WNHMhV5y4fUZJY/9P2XxKEtbjNuieXIxe1243rG4UhjS+3DsdlyB/RdTTSSVj5W2iLEF
 T0Lf2ZfFTdX72O2zvYR6/lQW49k6QtEZ4lWkfrO3VIF18HTznkRpw7Qqhp8alvDAmIJ+K7kUmMV
 TBjvV4B5pmBRAehCLeQyW3SSx8M0iIvsmK4h0IQasu5HLCZheWMgfNWh7pq4Av/dDzm9ONfv51H
 0TuxJ4ViO0+uAsJH8Hrkt9IP9T8XQl5kaHEhYobivpy/eBMX0dCcpiBgqga2W6yLH8Kc3Tq4XXX
 yE/RqrZR+H70zMKSw27D4t0ESauUMWKZgeX4/l1pErJHro9RMc19gJ8MTNWmNqu49OVp9gclmGk
 lo4C6CwFHIZTyX2b67NB2X8+JjngXAlnK/y8NxntM1/DBMUxZLuLXVTl6vifJtBLlaicKDvmfeh
 WCfnNaFEvi27LJQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

These functions access mon_cpu_path, which is a MonitorHMP-specific
field. Narrowing their signatures from Monitor* to MonitorHMP* makes the
type system enforce what was already true at runtime: every caller is in
an HMP context. The expression parser's MONITOR_HMP() casts are safe
because it is only reachable from handle_hmp_command(), they will be
dropped with later patches.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/core/machine-hmp-cmds.c |  4 ++--
 include/monitor/hmp.h      |  7 +++---
 include/monitor/monitor.h  |  1 -
 monitor/hmp-cmds.c         | 53 ++++++++++++++++++++++------------------------
 monitor/hmp.c              | 18 ++++++++--------
 monitor/monitor-internal.h |  2 +-
 monitor/qmp-cmds.c         |  2 +-
 stats/stats-hmp-cmds.c     |  2 +-
 target/i386/cpu-apic.c     |  2 +-
 target/i386/cpu.c          |  4 ++--
 target/i386/monitor.c      |  4 ++--
 target/m68k/monitor.c      |  2 +-
 target/ppc/monitor.c       |  2 +-
 target/riscv/monitor.c     |  2 +-
 target/sh4/monitor.c       |  2 +-
 target/sparc/monitor.c     |  2 +-
 target/xtensa/monitor.c    |  2 +-
 17 files changed, 54 insertions(+), 57 deletions(-)

diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 4e2f0c212b0d..702c798ccc56 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -36,7 +36,7 @@ void hmp_info_cpus(MonitorHMP *hmp, const QDict *qdict)
         g_autofree char *cpu_model = cpu_model_from_type(cpu->value->qom_type);
         int active = ' ';
 
-        if (cpu->value->cpu_index == monitor_get_cpu_index(mon)) {
+        if (cpu->value->cpu_index == monitor_hmp_get_cpu_index(hmp)) {
             active = '*';
         }
 
@@ -228,7 +228,7 @@ void hmp_memsave(MonitorHMP *hmp, const QDict *qdict)
     const char *filename = qdict_get_str(qdict, "filename");
     uint64_t addr = qdict_get_int(qdict, "val");
     Error *err = NULL;
-    int cpu_index = monitor_get_cpu_index(mon);
+    int cpu_index = monitor_hmp_get_cpu_index(hmp);
 
     if (cpu_index < 0) {
         monitor_printf(mon, "No CPU available\n");
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 6aa562ddbaa2..3fd17048b319 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -30,7 +30,7 @@ OBJECT_DECLARE_TYPE(MonitorHMP, MonitorHMPClass, MONITOR_HMP);
 struct MonitorDef {
     const char *name;
     int offset;
-    int64_t (*get_value)(Monitor *mon, const MonitorDef *md, int offset);
+    int64_t (*get_value)(MonitorHMP *hmp, const MonitorDef *md, int offset);
 };
 
 void monitor_new_hmp(const char *id, const char *chardev_id,
@@ -53,8 +53,9 @@ void monitor_register_hmp_info_hrt(const char *name,
                                    HumanReadableText *(*handler)(Error **errp));
 
 
-CPUArchState *mon_get_cpu_env(Monitor *mon);
-CPUState *mon_get_cpu(Monitor *mon);
+CPUArchState *monitor_hmp_get_cpu_env(MonitorHMP *hmp);
+CPUState *monitor_hmp_get_cpu(MonitorHMP *hmp);
+int monitor_hmp_get_cpu_index(MonitorHMP *hmp);
 
 bool hmp_handle_error(MonitorHMP *hmp, Error *err);
 void hmp_help_cmd(Monitor *mon, const char *name);
diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 72a8f6ea5b4f..2a550aec023f 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -39,7 +39,6 @@ int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp);
 
 int monitor_puts(Monitor *mon, const char *str);
 void monitor_flush(Monitor *mon);
-int monitor_get_cpu_index(Monitor *mon);
 
 int monitor_puts_locked(Monitor *mon, const char *str);
 void monitor_flush_locked(Monitor *mon);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d1e7e4de6585..89cc19c2431d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -182,10 +182,10 @@ void hmp_cpu(MonitorHMP *hmp, const QDict *qdict)
     Monitor *mon = MONITOR(hmp);
     int64_t cpu_index;
 
-    /* XXX: drop the monitor_set_cpu() usage when all HMP commands that
+    /* XXX: drop the monitor_hmp_set_cpu() usage when all HMP commands that
             use it are converted to the QAPI */
     cpu_index = qdict_get_int(qdict, "index");
-    if (monitor_set_cpu(mon, cpu_index) < 0) {
+    if (monitor_hmp_set_cpu(hmp, cpu_index) < 0) {
         monitor_printf(mon, "invalid CPU index\n");
     }
 }
@@ -512,39 +512,37 @@ void hmp_dumpdtb(MonitorHMP *hmp, const QDict *qdict)
 #endif
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
-int monitor_set_cpu(Monitor *mon, int cpu_index)
+int monitor_hmp_set_cpu(MonitorHMP *hmp, int cpu_index)
 {
-    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
     CPUState *cpu;
 
     cpu = qemu_get_cpu(cpu_index);
     if (cpu == NULL) {
         return -1;
     }
-    g_free(hmp_mon->mon_cpu_path);
-    hmp_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
+    g_free(hmp->mon_cpu_path);
+    hmp->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
     return 0;
 }
 
 /* Callers must hold BQL. */
-static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
+static CPUState *monitor_hmp_get_cpu_sync(MonitorHMP *hmp, bool synchronize)
 {
-    MonitorHMP *hmp_mon = MONITOR_HMP(mon);
     CPUState *cpu = NULL;
 
-    if (hmp_mon->mon_cpu_path) {
-        cpu = (CPUState *) object_resolve_path_type(hmp_mon->mon_cpu_path,
+    if (hmp->mon_cpu_path) {
+        cpu = (CPUState *) object_resolve_path_type(hmp->mon_cpu_path,
                                                     TYPE_CPU, NULL);
         if (!cpu) {
-            g_free(hmp_mon->mon_cpu_path);
-            hmp_mon->mon_cpu_path = NULL;
+            g_free(hmp->mon_cpu_path);
+            hmp->mon_cpu_path = NULL;
         }
     }
-    if (!hmp_mon->mon_cpu_path) {
+    if (!hmp->mon_cpu_path) {
         if (!first_cpu) {
             return NULL;
         }
-        monitor_set_cpu(mon, first_cpu->cpu_index);
+        monitor_hmp_set_cpu(hmp, first_cpu->cpu_index);
         cpu = first_cpu;
     }
     assert(cpu != NULL);
@@ -554,21 +552,21 @@ static CPUState *mon_get_cpu_sync(Monitor *mon, bool synchronize)
     return cpu;
 }
 
-CPUState *mon_get_cpu(Monitor *mon)
+CPUState *monitor_hmp_get_cpu(MonitorHMP *hmp)
 {
-    return mon_get_cpu_sync(mon, true);
+    return monitor_hmp_get_cpu_sync(hmp, true);
 }
 
-CPUArchState *mon_get_cpu_env(Monitor *mon)
+CPUArchState *monitor_hmp_get_cpu_env(MonitorHMP *hmp)
 {
-    CPUState *cs = mon_get_cpu(mon);
+    CPUState *cs = monitor_hmp_get_cpu(hmp);
 
     return cs ? cpu_env(cs) : NULL;
 }
 
-int monitor_get_cpu_index(Monitor *mon)
+int monitor_hmp_get_cpu_index(MonitorHMP *hmp)
 {
-    CPUState *cs = mon_get_cpu_sync(mon, false);
+    CPUState *cs = monitor_hmp_get_cpu_sync(hmp, false);
 
     return cs ? cs->cpu_index : UNASSIGNED_CPU_INDEX;
 }
@@ -586,7 +584,7 @@ void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
             cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
         }
     } else {
-        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
+        cs = vcpu >= 0 ? qemu_get_cpu(vcpu) : monitor_hmp_get_cpu(hmp);
 
         if (!cs) {
             if (vcpu >= 0) {
@@ -602,13 +600,14 @@ void hmp_info_registers(MonitorHMP *hmp, const QDict *qdict)
     }
 }
 
-static void memory_dump(Monitor *mon, int count, int format, int wsize,
+static void memory_dump(MonitorHMP *hmp, int count, int format, int wsize,
                         uint64_t addr, bool is_physical)
 {
+    Monitor *mon = MONITOR(hmp);
     int l, line_size, i, max_digits, len;
     uint8_t buf[16];
     uint64_t v;
-    CPUState *cs = mon_get_cpu(mon);
+    CPUState *cs = monitor_hmp_get_cpu(hmp);
     const unsigned int addr_width = is_physical ? 8 : (target_long_bits() / 4);
     const bool big_endian = target_big_endian();
 
@@ -712,24 +711,22 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
 
 void hmp_memory_dump(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
     int size = qdict_get_int(qdict, "size");
     vaddr addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, false);
+    memory_dump(hmp, count, format, size, addr, false);
 }
 
 void hmp_physical_memory_dump(MonitorHMP *hmp, const QDict *qdict)
 {
-    Monitor *mon = MONITOR(hmp);
     int count = qdict_get_int(qdict, "count");
     int format = qdict_get_int(qdict, "format");
     int size = qdict_get_int(qdict, "size");
     hwaddr addr = qdict_get_int(qdict, "addr");
 
-    memory_dump(mon, count, format, size, addr, true);
+    memory_dump(hmp, count, format, size, addr, true);
 }
 
 void hmp_gpa2hva(MonitorHMP *hmp, const QDict *qdict)
@@ -757,7 +754,7 @@ void hmp_gva2gpa(MonitorHMP *hmp, const QDict *qdict)
 {
     Monitor *mon = MONITOR(hmp);
     vaddr addr = qdict_get_int(qdict, "addr");
-    CPUState *cs = mon_get_cpu(mon);
+    CPUState *cs = monitor_hmp_get_cpu(hmp);
     TranslateForDebugResult tres;
 
     if (!cs) {
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 47fb7cef6de2..2484a2310dff 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -411,10 +411,10 @@ void hmp_help_cmd(Monitor *mon, const char *name)
  * Set @pval to the value in the register identified by @name.
  * return %true if the register is found, %false otherwise.
  */
-static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
+static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
 {
     g_autoptr(GArray) regs = NULL;
-    CPUState *cs = mon_get_cpu(mon);
+    CPUState *cs = monitor_hmp_get_cpu(hmp);
 
     if (cs == NULL) {
         return false;
@@ -452,7 +452,7 @@ static bool gdb_get_register(Monitor *mon, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
-static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name);
+static int get_monitor_def(MonitorHMP *mon, int64_t *pval, const char *name);
 
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(Monitor *mon, const char *fmt, ...)
@@ -535,8 +535,8 @@ static int64_t expr_unary(Monitor *mon)
                 pch++;
             }
             *q = 0;
-            if (!gdb_get_register(mon, &reg, buf)
-                && get_monitor_def(mon, &reg, buf) < 0) {
+            if (!gdb_get_register(MONITOR_HMP(mon), &reg, buf)
+                && get_monitor_def(MONITOR_HMP(mon), &reg, buf) < 0) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
@@ -1733,9 +1733,9 @@ void monitor_register_hmp_info_hrt(const char *name,
  * Set @pval to the value in the register identified by @name.
  * return 0 if OK, -1 if not found
  */
-static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
+static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
 {
-    CPUState *cs = mon_get_cpu(mon);
+    CPUState *cs = monitor_hmp_get_cpu(hmp);
     const MonitorDef *md;
     void *ptr;
 
@@ -1750,9 +1750,9 @@ static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
     for (; md->name != NULL; md++) {
         if (hmp_compare_cmd(name, md->name)) {
             if (md->get_value) {
-                *pval = md->get_value(mon, md, md->offset);
+                *pval = md->get_value(hmp, md, md->offset);
             } else {
-                CPUArchState *env = mon_get_cpu_env(mon);
+                CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
                 ptr = (uint8_t *)env + md->offset;
                 *pval = *(int32_t *)ptr;
             }
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index a0fa37c887ed..afdda1386080 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -215,7 +215,7 @@ int monitor_can_read(void *opaque);
 void monitor_cancel_out_watch(Monitor *mon);
 void monitor_list_append(Monitor *mon);
 void monitor_fdsets_cleanup(void);
-int monitor_set_cpu(Monitor *mon, int cpu_index);
+int monitor_hmp_set_cpu(MonitorHMP *mon, int cpu_index);
 
 void qmp_send_response(MonitorQMP *mon, const QDict *rsp);
 void monitor_data_destroy_qmp(MonitorQMP *mon);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 6cb0b587fbd4..b16119f4858c 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -169,7 +169,7 @@ char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
     MonitorHMP *hmp = MONITOR_HMP(object_new(TYPE_MONITOR_HMP));
 
     if (has_cpu_index) {
-        int ret = monitor_set_cpu(&hmp->parent_obj, cpu_index);
+        int ret = monitor_hmp_set_cpu(hmp, cpu_index);
         if (ret < 0) {
             error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "cpu-index",
                        "a CPU number");
diff --git a/stats/stats-hmp-cmds.c b/stats/stats-hmp-cmds.c
index f280ad8c4314..cd1f1deb58bc 100644
--- a/stats/stats-hmp-cmds.c
+++ b/stats/stats-hmp-cmds.c
@@ -226,7 +226,7 @@ void hmp_info_stats(MonitorHMP *hmp, const QDict *qdict)
         filter = stats_filter(target, names, -1, provider);
         break;
     case STATS_TARGET_VCPU: {}
-        int cpu_index = monitor_get_cpu_index(mon);
+        int cpu_index = monitor_hmp_get_cpu_index(hmp);
         filter = stats_filter(target, names, cpu_index, provider);
         break;
     case STATS_TARGET_CRYPTODEV:
diff --git a/target/i386/cpu-apic.c b/target/i386/cpu-apic.c
index 2cb3147837d1..3ae20f004b64 100644
--- a/target/i386/cpu-apic.c
+++ b/target/i386/cpu-apic.c
@@ -93,7 +93,7 @@ void hmp_info_local_apic(MonitorHMP *hmp, const QDict *qdict)
             cpu_synchronize_state(cs);
         }
     } else {
-        cs = mon_get_cpu(mon);
+        cs = monitor_hmp_get_cpu(hmp);
     }
 
 
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e5ffb10d1565..f0687b5c482d 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10853,10 +10853,10 @@ static const Property x86_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
-static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
+static int64_t monitor_get_pc(MonitorHMP *hmp, const struct MonitorDef *md,
                               int offset)
 {
-    CPUArchState *env = mon_get_cpu_env(mon);
+    CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
     int64_t ret = env->eip + env->segs[R_CS].base;
 
     if (!(env->hflags & HF_CS64_MASK)) {
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index f68dd38ac225..72bcab131f77 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -215,7 +215,7 @@ void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
     CPUArchState *env;
     AddressSpace *as;
 
-    env = mon_get_cpu_env(mon);
+    env = monitor_hmp_get_cpu_env(hmp);
     if (!env) {
         monitor_printf(mon, "No CPU available\n");
         return;
@@ -542,7 +542,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
     CPUArchState *env;
     AddressSpace *as;
 
-    env = mon_get_cpu_env(mon);
+    env = monitor_hmp_get_cpu_env(hmp);
     if (!env) {
         monitor_printf(mon, "No CPU available\n");
         return;
diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
index 0414474f2ffb..5645a5d4d4f5 100644
--- a/target/m68k/monitor.c
+++ b/target/m68k/monitor.c
@@ -13,7 +13,7 @@
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     Monitor *mon = MONITOR(hmp);
-    CPUArchState *env1 = mon_get_cpu_env(mon);
+    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
     if (!env1) {
         monitor_printf(mon, "No CPU available\n");
diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
index 99eda7351877..5769829bdd7e 100644
--- a/target/ppc/monitor.c
+++ b/target/ppc/monitor.c
@@ -14,7 +14,7 @@
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     Monitor *mon = MONITOR(hmp);
-    CPUArchState *env1 = mon_get_cpu_env(mon);
+    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
     if (!env1) {
         monitor_printf(mon, "No CPU available\n");
diff --git a/target/riscv/monitor.c b/target/riscv/monitor.c
index 496d519c978d..4c9c0c793b36 100644
--- a/target/riscv/monitor.c
+++ b/target/riscv/monitor.c
@@ -220,7 +220,7 @@ void hmp_info_mem(MonitorHMP *hmp, const QDict *qdict)
     Monitor *mon = MONITOR(hmp);
     CPUArchState *env;
 
-    env = mon_get_cpu_env(mon);
+    env = monitor_hmp_get_cpu_env(hmp);
     if (!env) {
         monitor_printf(mon, "No CPU available\n");
         return;
diff --git a/target/sh4/monitor.c b/target/sh4/monitor.c
index 50da650b2e04..4e443152bf56 100644
--- a/target/sh4/monitor.c
+++ b/target/sh4/monitor.c
@@ -41,7 +41,7 @@ static void print_tlb(Monitor *mon, int idx, tlb_t *tlb)
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     Monitor *mon = MONITOR(hmp);
-    CPUArchState *env = mon_get_cpu_env(mon);
+    CPUArchState *env = monitor_hmp_get_cpu_env(hmp);
     int i;
 
     if (!env) {
diff --git a/target/sparc/monitor.c b/target/sparc/monitor.c
index 09a15b821a1a..e826e584a918 100644
--- a/target/sparc/monitor.c
+++ b/target/sparc/monitor.c
@@ -30,7 +30,7 @@
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     Monitor *mon = MONITOR(hmp);
-    CPUArchState *env1 = mon_get_cpu_env(mon);
+    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
     if (!env1) {
         monitor_printf(mon, "No CPU available\n");
diff --git a/target/xtensa/monitor.c b/target/xtensa/monitor.c
index a1082c44e11c..b7b7387706f3 100644
--- a/target/xtensa/monitor.c
+++ b/target/xtensa/monitor.c
@@ -29,7 +29,7 @@
 void hmp_info_tlb(MonitorHMP *hmp, const QDict *qdict)
 {
     Monitor *mon = MONITOR(hmp);
-    CPUArchState *env1 = mon_get_cpu_env(mon);
+    CPUArchState *env1 = monitor_hmp_get_cpu_env(hmp);
 
     if (!env1) {
         monitor_printf(mon, "No CPU available\n");

-- 
2.55.0.543.g5ebe2ebe4ea8


