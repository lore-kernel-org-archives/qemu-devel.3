Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D6CCDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:21:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrUT-000790-LM; Thu, 25 Jun 2026 17:20:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUR-00077x-1d
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrUP-0003LS-1s
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LuCsShhTUcXkPvuRrIUWWf8+KME2pbEfuwyApeJAwTw=;
 b=WVm5r4at8jygmW1VN8s3gdxK1GAAqRoao+OqGraUyPK168IcKecCEx7sZRHGF6gFkjJcOo
 ndmkfDLcbkv8Frvs4sAmO1rGMHxDVQKyy7ugB/6uqNls0vd4KA4AqjvmD10e+HDf4db/PM
 hab1RKHdtLUrrXs2QYRytkwaITYe+98=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-320-8yP761GOP2qCf44mxBZQmA-1; Thu,
 25 Jun 2026 17:19:57 -0400
X-MC-Unique: 8yP761GOP2qCf44mxBZQmA-1
X-Mimecast-MFC-AGG-ID: 8yP761GOP2qCf44mxBZQmA_1782422396
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 104311955F61; Thu, 25 Jun 2026 21:19:56 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2580F31D2; Thu, 25 Jun 2026 21:19:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:05 +0400
Subject: [PATCH v2 04/39] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-4-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7700;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=SCYHVO5Eci/m8A7sFldyMKqE8fRanoK15i2XOoRQedw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZtcAzY/BQ0Dl6XH/F4KELfqw0p6PaWO9tzWm
 vBHPw0KDnSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXAAKCRDa6OEJdZac
 5XfJEACCPkHdbvtwapvMW+1xGe5MCvbQQLK+nv8YC2jrJOo6J0m5XW8jkzuEX7bZvd/OV3AtuOe
 UrE5dJ5a7eWDS7jSl3qdrfULugjUbrrvhTwQ/oXyqskV/QNzcHPgjCyJkW9ASNf+7SU0H1SYAms
 vcaP4GGtko/1F2ErhlQp2SAqfiGz7ez2q7/1PTz3ugmnae3sbAXxBzRHZ2+OX9jX7NsPGnk40fo
 upjeHW+5+zosx5qeL9AMezujyRp2ggfQgDHrJd1uWXN/P0tzEkoY9DIvGjXKBj34FiBfXyqfijH
 DtHC4UVkN33EH3xpCy57M11q03+T0XDdsp3f7MII4Apf6kXhFO5445BIp1ebRNRDINDdweft0/r
 bGg8P3UehGRC6JKPmQPOfcbf3hY3GnRTGmGFxYQ7aiXqPh4BfPLatx+NA89afLz7IlWr3dEEVEU
 /sqF/kACKA1bGZVTLX9HbCn2L1kOs7zOOaGweC90rM/9rzJxEj0IeTThTDKsOs11eoc8xFglMkB
 tjojq4S5Y3elxdGEUehB10uME1BTm0rU3r+BmY65+BUAqqJg2F9zRsQFT3jsspJkAf6EEbUjocZ
 PQcdINYLYWJnPn2l1htOLp14Qt5W6exP+K9k/gF+O/t09wOzMBpYL7JKApDqzxKHKpYpK0NO+Z2
 Avw07ZHhUOJA9vg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Replace monitor_printf() error reporting with the standard **errp
pattern. Drop the Monitor *mon parameter and return bool to indicate
success, improving the function usage from non-HMP contexts. Update the
KVM MCE injection path and hmp_mce() accordingly.

Notes:
 - we may want to print the error in KVM path too
 - multiple error prints are now accumulated with error hints

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.h     |  4 ++--
 target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------------
 target/i386/kvm/kvm.c |  4 ++--
 target/i386/monitor.c |  6 ++++--
 4 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 67e2ecf3251..a8b211cf6c9 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2842,9 +2842,9 @@ void do_cpu_init(X86CPU *cpu);
 #define MCE_INJECT_BROADCAST    1
 #define MCE_INJECT_UNCOND_AO    2
 
-void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
+bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
                         uint64_t status, uint64_t mcg_status, uint64_t addr,
-                        uint64_t misc, int flags);
+                        uint64_t misc, int flags, Error **errp);
 
 uint32_t cpu_cc_compute_all(CPUX86State *env1);
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 68362141621..10d4ac03072 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -18,6 +18,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qapi/error.h"
 #include "qapi/qapi-events-run-state.h"
 #include "cpu.h"
 #include "exec/cputlb.h"
@@ -27,7 +28,6 @@
 #ifndef CONFIG_USER_ONLY
 #include "system/hw_accel.h"
 #include "system/memory.h"
-#include "monitor/monitor.h"
 #include "kvm/kvm_i386.h"
 #endif
 #include "qemu/log.h"
@@ -381,7 +381,7 @@ out:
 }
 
 typedef struct MCEInjectionParams {
-    Monitor *mon;
+    GString *err;
     int bank;
     uint64_t status;
     uint64_t mcg_status;
@@ -428,9 +428,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
          * reporting is disabled
          */
         if ((cenv->mcg_cap & MCG_CTL_P) && cenv->mcg_ctl != ~(uint64_t)0) {
-            monitor_printf(params->mon,
-                           "CPU %d: Uncorrected error reporting disabled\n",
-                           cs->cpu_index);
+            g_string_append_printf(params->err,
+                "CPU %d: Uncorrected error reporting disabled\n",
+                cs->cpu_index);
             return;
         }
 
@@ -439,10 +439,9 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
          * reporting is disabled for the bank
          */
         if (banks[0] != ~(uint64_t)0) {
-            monitor_printf(params->mon,
-                           "CPU %d: Uncorrected error reporting disabled for"
-                           " bank %d\n",
-                           cs->cpu_index, params->bank);
+            g_string_append_printf(params->err,
+                "CPU %d: Uncorrected error reporting disabled for bank %d\n",
+                cs->cpu_index, params->bank);
             return;
         }
 
@@ -459,7 +458,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_printf(params->mon, "%s", msg);
+            g_string_append_printf(params->err, "%s\n", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
@@ -488,14 +487,16 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
     emit_guest_memory_failure(MEMORY_FAILURE_ACTION_INJECT, ar, recursive);
 }
 
-void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
+bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
                         uint64_t status, uint64_t mcg_status, uint64_t addr,
-                        uint64_t misc, int flags)
+                        uint64_t misc, int flags, Error **errp)
 {
+    ERRP_GUARD();
     CPUState *cs = CPU(cpu);
     CPUX86State *cenv = &cpu->env;
+    g_autoptr(GString) err = g_string_new(NULL);
     MCEInjectionParams params = {
-        .mon = mon,
+        .err = err,
         .bank = bank,
         .status = status,
         .mcg_status = mcg_status,
@@ -506,21 +507,21 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
     unsigned bank_num = cenv->mcg_cap & 0xff;
 
     if (!cenv->mcg_cap) {
-        monitor_printf(mon, "MCE injection not supported\n");
-        return;
+        error_setg(errp, "MCE injection not supported");
+        return false;
     }
     if (bank >= bank_num) {
-        monitor_printf(mon, "Invalid MCE bank number\n");
-        return;
+        error_setg(errp, "Invalid MCE bank number");
+        return false;
     }
     if (!(status & MCI_STATUS_VAL)) {
-        monitor_printf(mon, "Invalid MCE status code\n");
-        return;
+        error_setg(errp, "Invalid MCE status code");
+        return false;
     }
     if ((flags & MCE_INJECT_BROADCAST)
         && !cpu_x86_support_mca_broadcast(cenv)) {
-        monitor_printf(mon, "Guest CPU does not support MCA broadcast\n");
-        return;
+        error_setg(errp, "Guest CPU does not support MCA broadcast");
+        return false;
     }
 
     run_on_cpu(cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
@@ -539,6 +540,12 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
             run_on_cpu(other_cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
         }
     }
+    if (params.err->len) {
+        error_setg(errp, "Failed to inject MCE");
+        error_append_hint(errp, "%s", params.err->str);
+        return false;
+    }
+    return true;
 }
 
 static inline target_ulong get_memio_eip(CPUX86State *env)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9e352882c8c..d01519ef2f3 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -747,8 +747,8 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
         flags = 0;
     }
 
-    cpu_x86_inject_mce(NULL, cpu, 9, status, mcg_status, paddr,
-                       (MCM_ADDR_PHYS << 6) | 0xc, flags);
+    cpu_x86_inject_mce(cpu, 9, status, mcg_status, paddr,
+                       (MCM_ADDR_PHYS << 6) | 0xc, flags, NULL);
 }
 
 static void emit_hypervisor_memory_failure(MemoryFailureAction action, bool ar)
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a536712c755..785a13dd710 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -580,6 +580,7 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     uint64_t addr = qdict_get_int(qdict, "addr");
     uint64_t misc = qdict_get_int(qdict, "misc");
     int flags = MCE_INJECT_UNCOND_AO;
+    Error *err = NULL;
 
     if (qdict_get_try_bool(qdict, "broadcast", false)) {
         flags |= MCE_INJECT_BROADCAST;
@@ -587,7 +588,8 @@ void hmp_mce(Monitor *mon, const QDict *qdict)
     cs = qemu_get_cpu(cpu_index);
     if (cs != NULL) {
         cpu = X86_CPU(cs);
-        cpu_x86_inject_mce(mon, cpu, bank, status, mcg_status, addr, misc,
-                           flags);
+        cpu_x86_inject_mce(cpu, bank, status, mcg_status, addr, misc,
+                           flags, &err);
+        hmp_handle_error(mon, err);
     }
 }

-- 
2.54.0


