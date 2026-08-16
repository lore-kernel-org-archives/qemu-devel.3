Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DE8C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIk-0008QX-O2; Sun, 16 Aug 2026 15:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIU-0008N3-0c
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIS-0007LA-73
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+5wpuBZXAGueWMmgc7XSO8gFuXPjkb9QB1fhiVwJj/Q=;
 b=BDgHJUk1SNfLAikPqxYBUuh61njzdT2W8JOZkfmMwgq4O49uYBWI9A01eURfuXpkEY7MK9
 XqXZS7CprrF1t1IWzaB1BTFD/Wce2hNAX0lb6RUJKJG4JqSffOaO5wLBIGhEMfI4LkeIge
 ec/lIgpG+26sbC/ty69/ucjHUqxrU5k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-8siE_Vi6M-287743nMDNgA-1; Sun,
 16 Aug 2026 15:13:13 -0400
X-MC-Unique: 8siE_Vi6M-287743nMDNgA-1
X-Mimecast-MFC-AGG-ID: 8siE_Vi6M-287743nMDNgA_1786907592
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCF231800471; Sun, 16 Aug 2026 19:13:12 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7718718005BB; Sun, 16 Aug 2026 19:13:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:31 +0400
Subject: [PATCH v3 04/49] target/i386: decouple cpu_x86_inject_mce() from
 Monitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-4-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 kvm@vger.kernel.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7649;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=o/yEwsZkXnbE4yqKZMMJ1dRx5P6T3KLfXBYSN+saGmk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguw/K+6+Wb9ySL/wnYLu5qf6JBMHQdY2tXNP
 VxBIKL3BauJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsAAKCRDa6OEJdZac
 5S6+D/9p5VmubM0NyBiQerNIxYrPJ3uhqE5TBYq5YReIM6GfwQ6g7aPmIf19hoYReKkQyPmr+aS
 dwMB3FvsB2H/hZiJqHn4DQo+7WeYIDdkLiNCem1jK2iIUKyExZo2G2CIzYHN55pVQ+OU2bffnPP
 xMVkbYv3eKVOZJBMm03FNwRfbeinpZ+XPgsAWytQ0F3Yc2DmVerK0UhhmWKWSd7ktWI9WaFfd0t
 ihitg+AY8oKUlfIUPslTKGqLJ+CN4qFZGzT29BaBHmLPnSa99SNrQm2l60dutYhMGsnEQNWHcu4
 8HHWCulkyMz0RPtijPv+YYB9L3UEV/MjUMft203Q6yd+Yk5UMDuz6LoHJ3erzk8iquWqgHow/Tz
 aeeztJ126yNZRFbBWyTTJXookfh5iuvg02tsGrigewxx0xW+rkR+pmEM4c68eujaLfNlPBjBq5i
 Hmlp+gaLhjUOzl004g/KrS7ZNiP4GDb05eOy8qNJeNe7bbA3m4y+EJ+/vpdEarhy7SixYxrymI5
 sLyjOUcvF21kExh7eayYhMR2/6769Vtg7r7ygcjLDcceFfer0BXnwf53edTmjo4teAP8acm55AR
 lQVNUIXIU/ThhS6ta9OQ0B4VDtNgDvx7GPcYXXd+WbvHrk2XCpjUpEYCMwwXGF4nj//upx9BDjK
 XSskOL3YhU9mfgA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 target/i386/cpu.h     |  4 ++--
 target/i386/helper.c  | 49 ++++++++++++++++++++++++++++---------------------
 target/i386/kvm/kvm.c |  4 ++--
 target/i386/monitor.c |  6 ++++--
 4 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e6a197602d87..4f342b69f471 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2847,9 +2847,9 @@ void do_cpu_init(X86CPU *cpu);
 #define MCE_INJECT_BROADCAST    1
 #define MCE_INJECT_UNCOND_AO    2
 
-void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
+bool cpu_x86_inject_mce(X86CPU *cpu, int bank,
                         uint64_t status, uint64_t mcg_status, uint64_t addr,
-                        uint64_t misc, int flags);
+                        uint64_t misc, int flags, Error **errp);
 
 uint32_t cpu_cc_compute_all(CPUX86State *env1);
 
diff --git a/target/i386/helper.c b/target/i386/helper.c
index 683621416213..4133b5f244c6 100644
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
+    Error **errp;
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
+            error_setg(params->errp,
+                "CPU %d: Uncorrected error reporting disabled",
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
+            error_setg(params->errp,
+                "CPU %d: Uncorrected error reporting disabled for bank %d",
+                cs->cpu_index, params->bank);
             return;
         }
 
@@ -459,7 +458,7 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
         if (need_reset) {
             emit_guest_memory_failure(MEMORY_FAILURE_ACTION_RESET, ar,
                                       recursive);
-            monitor_printf(params->mon, "%s", msg);
+            error_setg(params->errp, "%s", msg);
             qemu_log_mask(CPU_LOG_RESET, "%s\n", msg);
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
             return;
@@ -488,14 +487,15 @@ static void do_inject_x86_mce(CPUState *cs, run_on_cpu_data data)
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
     MCEInjectionParams params = {
-        .mon = mon,
+        .errp = errp,
         .bank = bank,
         .status = status,
         .mcg_status = mcg_status,
@@ -506,24 +506,27 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
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
+    if (*errp) {
+        return false;
+    }
     if (flags & MCE_INJECT_BROADCAST) {
         CPUState *other_cs;
 
@@ -537,8 +540,12 @@ void cpu_x86_inject_mce(Monitor *mon, X86CPU *cpu, int bank,
                 continue;
             }
             run_on_cpu(other_cs, do_inject_x86_mce, RUN_ON_CPU_HOST_PTR(&params));
+            if (*errp) {
+                return false;
+            }
         }
     }
+    return true;
 }
 
 static inline target_ulong get_memio_eip(CPUX86State *env)
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 644c45fb0a02..1eeadb99adac 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -748,8 +748,8 @@ static void kvm_mce_inject(X86CPU *cpu, hwaddr paddr, int code)
         flags = 0;
     }
 
-    cpu_x86_inject_mce(NULL, cpu, 9, status, mcg_status, paddr,
-                       (MCM_ADDR_PHYS << 6) | 0xc, flags);
+    cpu_x86_inject_mce(cpu, 9, status, mcg_status, paddr,
+                       (MCM_ADDR_PHYS << 6) | 0xc, flags, NULL);
 }
 
 static void emit_hypervisor_memory_failure(MemoryFailureAction action, bool ar)
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a536712c755a..785a13dd7107 100644
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
2.55.0.543.g5ebe2ebe4ea8


