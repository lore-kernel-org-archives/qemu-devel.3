Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 240B3C61DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:15:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywZr-0003a4-JJ; Tue, 25 Aug 2026 15:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZp-0003Q4-PD
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywZm-0004UT-OP
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:12:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9T6RaGwiQ6RIqSqxskSTyz+FMmYOIOpZr0dqTULlFiM=;
 b=KxSRuRUdpB3TGyRONle0cOzJ+TbarrSJNzhXBTOEXRSvAQhYV2kn0L921xC2u5jNqT5ejp
 GaRRao/hvgejhNhPuXh4fGgBbzcWpXKchSvjWub/Enuo2fnnWYoE7RBfrP6DnBQ3hyz6Je
 mssWds1mbUtTwjH5lf4zPH3TlT8f8ok=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-628-opN8Fv_sO7-qBHvlE_kjLA-1; Tue,
 25 Aug 2026 15:12:45 -0400
X-MC-Unique: opN8Fv_sO7-qBHvlE_kjLA-1
X-Mimecast-MFC-AGG-ID: opN8Fv_sO7-qBHvlE_kjLA_1787685164
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8E1119774E1; Tue, 25 Aug 2026 19:12:43 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B6261800765; Tue, 25 Aug 2026 19:12:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:48 +0400
Subject: [PATCH v4 41/49] target: guard MonitorDef tables with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-41-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=4721;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=h5FgoNjZJ7je4rF+cX6DwK/vCwNzqzMapRKbSonoaXg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiIIooTBxpwGTAtgEf9u0MUUFvOKQVrUFA+X
 gAPpALOutSJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3oiAAKCRDa6OEJdZac
 5UACEACXPKv0N7v4/HS0QorSOPW7JXAgBw6tDgDxnjvpvoVFXy4nHgaeOfW0EgGQ0rylSVrSH4A
 LUVzlcqbn1f7MBfNYn+aXE2xHGfRERae6L4ufGZZ6qGirthA6U2CbJU9uo8udpqnG/dDTjF34jY
 XrRIHPrN3Xx3cXSZ0hpr/4aNLxt2LWzqx34UbmbpTPJX5oqhtXHDiPgRphNODrMbF74taHanr/m
 HO+7L3QwSGOLoXpBTo/mZRMb5c9Hd9jU8I7DbTfZhSWUwt1QxNN3cOf1StdMw+82BdT12acaYDC
 tZYnUo1r//mLkQX8jf1t+EcRzJbvJZ0oF8xO85OYr4NPgkNMSkfS770pWxQlqpaTPt8HtX2hr6Z
 XhfXPJX5fPFeU7/a/WZP3jUefPEofIV3vwHawUcNHwI+u1udLiJPNJ0fLxKpphiWRb2fOkJTxsJ
 hriA5S6kqPowntNCJCIFDrm7lWu6ZXUEgrB+gBtGITt2zKijJ/KPxiluJNBEWANtoQ18xK9dqf6
 EdZwDzZeKk75VYn6QJHUeM0APFQHBSwcnPyr0dMtLsCiGyWblg1jbvx8z42u2eiflgY2vWp1uyZ
 3QAXMh9KMek5fJlCV8hI32GTc4PaaaN6aVaQ8uw0hhr0sFayIvMCX6gn/O0IpdYS5n0eNbQGnT6
 jsYqzpJFwWM4vVg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Note that the #ifdef in hmp.c is not optimal, but will be removed
later once the unit is built conditionally.

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/sysemu-cpu-ops.h | 2 ++
 monitor/hmp.c                    | 4 +++-
 target/i386/cpu.c                | 4 ++++
 target/m68k/cpu.c                | 4 ++++
 target/sparc/cpu.c               | 5 +++--
 5 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 9a45596169a3..e56eea18b785 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -109,11 +109,13 @@ typedef struct SysemuCPUOps {
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
index e5f8b9c576e0..3c70adcd35bb 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -1725,13 +1725,15 @@ void monitor_register_hmp_info_hrt(const char *name,
 static int get_monitor_def(MonitorHMP *hmp, int64_t *pval, const char *name)
 {
     CPUState *cs = monitor_hmp_get_cpu(hmp);
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
index f0687b5c482d..84e805ee85e2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -10853,6 +10853,7 @@ static const Property x86_cpu_properties[] = {
 
 #ifndef CONFIG_USER_ONLY
 
+#ifdef CONFIG_HMP
 static int64_t monitor_get_pc(MonitorHMP *hmp, const struct MonitorDef *md,
                               int offset)
 {
@@ -10878,6 +10879,7 @@ static const MonitorDef x86_monitor_defs[] = {
     { NULL },
 #undef SEG
 };
+#endif
 
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -10892,7 +10894,9 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
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
index 6012dc3186c7..9b52ad5fc234 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -666,6 +666,7 @@ static const VMStateDescription vmstate_m68k_cpu = {
     },
 };
 
+#ifdef CONFIG_HMP
 static const MonitorDef m68k_monitor_defs[] = {
     { "ssp", offsetof(CPUM68KState, sp[0]) },
     { "usp", offsetof(CPUM68KState, sp[1]) },
@@ -681,13 +682,16 @@ static const MonitorDef m68k_monitor_defs[] = {
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
index 1bc14b586bb9..ae9bdca9df82 100644
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
2.55.0.543.g5ebe2ebe4ea8


