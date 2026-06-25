Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C977CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 21:23:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcrX7-0007i1-Kc; Thu, 25 Jun 2026 17:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrX5-0007gV-Mw
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wcrX4-00045t-2J
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 17:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782422565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Yg/4vpe/VIpC1IVkv/gpb2hEGj5BTSTBQNgDPD8xpG4=;
 b=hckb8UxDRDRqt3PKYJvVjwJH9Ezq7X4YtPy6uG8WV0t2PuJTb/B779OE3amNCFW7anQ3VV
 +Kj4w+acM9dn37LFJFkbtHHYu+dyyGnkM5oaeR5qVgL7J8gdxrLH0Ie6OYXUHOKA3RrQTM
 XmDMkZErHFN9xXVdWxyp1YcYc+ykKTQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-EH0J8SM2P-evD6I7XqJG-w-1; Thu,
 25 Jun 2026 17:22:42 -0400
X-MC-Unique: EH0J8SM2P-evD6I7XqJG-w-1
X-Mimecast-MFC-AGG-ID: EH0J8SM2P-evD6I7XqJG-w_1782422561
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B2161955DA3; Thu, 25 Jun 2026 21:22:41 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16FA4195608D; Thu, 25 Jun 2026 21:22:39 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 26 Jun 2026 01:19:36 +0400
Subject: [PATCH v2 35/39] target: guard MonitorDef tables with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260626-qemu-no-hmp-v2-35-8af31bc54c61@redhat.com>
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
In-Reply-To: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4501;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sZOBLMbuxr+KBjkNww4oQRWP2H2MtPQHjO8YsjtUmXs=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPZteLiBbia/tEW1Nr4EGcJuJPH5r+CP2f0B2D
 fHl9i9UKc6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj2bXgAKCRDa6OEJdZac
 5V7lD/9gJXt8/OzfnjLb9tCDyWj9DiSy8EMsTPHDNvjMFPKGr8eqagGkOV5vNcprGvBHTnWXIaX
 2vYDiw1kz3ZcMmVPP6aekEWAQYvufDmmU4I2pN3z1pXyFWOY55QepCeJCO7FqTzL4ECYo18rK5S
 F7LkoF+m85B+4QetxbdOfAPi3wfaYnpZFEsraAO0VZ7+AMPwHDz3sfenlN9zVlZUWCBAneoIUw6
 hViBJsUOjucQqZOG80iwH4BKtJQTgV7VbdGz67F1B6qS1CCbAYwLDq9q3h/Cz5wiZTGaleYrJ9C
 /ji1x22J0ch+47Tor8sESyLENm40BApjHMpWgqVZX2YpPGamQCG1hMazivVpD6jhaC7dlriXN7+
 ms+gmplYPuKhdyZgV6oXpC1LfBAy57/wYBwe0maUELHuuRMcL9d4z+Ux1/pVtbOrHe1mhGP+3Fc
 P1q/EmSW51OVsVVuqwC0DZgD6/4MlHH4vBrFzOcJ+DjC4FIE097gbXjeX0YyjLpBiQYxqU9FyYA
 8ht9+Dnt4PWzUdSzhw/dgehrAmD2s9NOnJlVet8Uj19HAQJTlduFqHSjt4nqLRmvqtslsc9CSmi
 KYv1rRKwPdeienrdpibPa/6SCEiwUI3aYAcVQbWz+QOaXl1TE4B+zy4ul5jbrb22RSL1nfYWHkd
 zQnJLSc1UUlxurQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Guard SysemuCPUOps::monitor_defs field and the per-target MonitorDef
arrays with CONFIG_HMP. These tables are only used by HMP 'print' and
'info registers' commands.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/sysemu-cpu-ops.h | 2 ++
 monitor/hmp.c                    | 4 +++-
 target/i386/cpu.c                | 4 ++++
 target/m68k/cpu.c                | 4 ++++
 target/sparc/cpu.c               | 5 +++--
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 8be6a84bd54..09bb193e453 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -106,11 +106,13 @@ typedef struct SysemuCPUOps {
      */
     int (*monitor_get_register)(CPUState *cs, const char *name, int64_t *pval);
 
+#ifdef CONFIG_HMP
     /**
      * @monitor_defs: Array of MonitorDef entries. This field is legacy,
      *                use @gdb_core_xml_file to dump registers instead.
      */
     const MonitorDef *monitor_defs;
+#endif
 
     /**
      * @legacy_vmsd: Legacy state for migration.
diff --git a/monitor/hmp.c b/monitor/hmp.c
index de8804af51a..c9e207c7a30 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1610,13 +1610,15 @@ void monitor_register_hmp_info_hrt(const char *name,
 static int get_monitor_def(Monitor *mon, int64_t *pval, const char *name)
 {
     CPUState *cs = mon_get_cpu(mon);
-    const MonitorDef *md;
+    const MonitorDef *md = NULL;
     void *ptr;
 
     if (cs == NULL) {
         return -1;
     }
+#ifdef CONFIG_HMP
     md = cs->cc->sysemu_ops->monitor_defs;
+#endif
     if (md == NULL) {
         return -1;
     }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 8929a75c7c9..9fc7677735e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10845,6 +10845,7 @@ static const Property x86_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
+#ifdef CONFIG_HMP
 static int64_t monitor_get_pc(Monitor *mon, const struct MonitorDef *md,
                               int offset)
 {
@@ -10870,6 +10871,7 @@ static const MonitorDef x86_monitor_defs[] = {
     { NULL },
 #undef SEG
 };
+#endif
 
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -10884,7 +10886,9 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf64_note = x86_cpu_write_elf64_note,
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
+#ifdef CONFIG_HMP
     .monitor_defs = x86_monitor_defs,
+#endif
     .legacy_vmsd = &vmstate_x86_cpu,
 };
 #endif
diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 9ad3057d91c..9955acb6c8d 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -603,6 +603,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
+#ifdef CONFIG_HMP
 static const MonitorDef m68k_monitor_defs[] = {
     { "ssp", offsetof(CPUM68KState, sp[0]) },
     { "usp", offsetof(CPUM68KState, sp[1]) },
@@ -618,13 +619,16 @@ static const MonitorDef m68k_monitor_defs[] = {
     { "mmusr", offsetof(CPUM68KState, mmu.mmusr) },
     { NULL },
 };
+#endif
 
 #include "hw/core/sysemu-cpu-ops.h"
 
 static const struct SysemuCPUOps m68k_sysemu_ops = {
     .has_work = m68k_cpu_has_work,
     .get_phys_addr_debug = m68k_cpu_get_phys_addr_debug,
+#ifdef CONFIG_HMP
     .monitor_defs = m68k_monitor_defs,
+#endif
 };
 #endif /* !CONFIG_USER_ONLY */
 
diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 13ebb122a38..51c720bdbc0 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -997,7 +997,7 @@ static const Property sparc_cpu_properties[] = {
 
 #ifdef TARGET_SPARC64
 #include "monitor/hmp.h"
-
+#ifdef CONFIG_HMP
 static const MonitorDef sparc64_monitor_defs[] = {
     { "asi", offsetof(CPUSPARCState, asi) },
     { "pstate", offsetof(CPUSPARCState, pstate) },
@@ -1009,6 +1009,7 @@ static const MonitorDef sparc64_monitor_defs[] = {
     { NULL },
 };
 #endif
+#endif
 
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -1016,7 +1017,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
     .has_work = sparc_cpu_has_work,
     .get_phys_addr_debug = sparc_cpu_get_phys_addr_debug,
     .legacy_vmsd = &vmstate_sparc_cpu,
-#if defined(TARGET_SPARC64)
+#if defined(TARGET_SPARC64) && defined(CONFIG_HMP)
     .monitor_defs = sparc64_monitor_defs,
 #endif
 };

-- 
2.54.0


