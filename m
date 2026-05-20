Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1C8CD4F3D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPorY-0000GU-4H; Wed, 20 May 2026 17:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorM-0008EQ-Ko
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wPorK-00054n-UL
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779314026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rbde7J4noGUK2MfUX87k3osUtabW4MGls+AziR37TyQ=;
 b=b3uWXguCSAqF5/EYUL4EAEv+A/9sWV4c6ef3i2XH8qs3HO3N2yGue2T2JvOMJBG3rjzEIt
 NgwVon1rQCn9eAvNZIgB4NdPoTPRXIzNUEjAwf9MFHDWl/KqRv8RFLxgHSJeTBbtsuxn8I
 w9YCPI2fq04KcLk4RF3YiRvBkfu53fY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-4dT9_m78MOmb9BizJbRJtg-1; Wed,
 20 May 2026 17:53:44 -0400
X-MC-Unique: 4dT9_m78MOmb9BizJbRJtg-1
X-Mimecast-MFC-AGG-ID: 4dT9_m78MOmb9BizJbRJtg_1779314024
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9036195608F
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 21:53:43 +0000 (UTC)
Received: from localhost (unknown [10.44.24.26])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8592C1684; Wed, 20 May 2026 21:53:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 21 May 2026 01:49:38 +0400
Subject: [PATCH 37/40] target: guard MonitorDef tables with CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-qemu-no-hmp-v1-37-d104f809e145@redhat.com>
References: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
In-Reply-To: <20260521-qemu-no-hmp-v1-0-d104f809e145@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3872;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=fPLNL/qowoRbvoQJmVKnuNiLGgQtbWe5YeI8gm0Ziuk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqDiyEPz9pQbwdWIMwSy1QzxoQDaaw5wIEmlnPg
 6x/XGCZrYCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCag4shAAKCRDa6OEJdZac
 5T8xD/9n3bBVkdIc0hEX7x6Z6rq9vds23H7oABMuvngzoinCljQ2ETJrbipqkFBOM8snmhosP/Y
 SRvIkjCvPwmHpwR+j9QMjdV8uKsRia2u2PrRDu1e69ENp3erz12dGLndBwUl8Sr51/HSTz+EWut
 11Y3armcfp1B0E6l6K0ZZcavvc5JcplYhZ0Rz2R+9eggXrQINJkZm2bl1WVRrpxMwcN12+StrPc
 V7HGAVjf5xuyHalyQMMrY6VAzBx2E918OvrTOeXi7rFoBWVidWFEpgv2zxbbNjXRPgKSnvEip5h
 gFMDyqSGLYVpp0I9qxiYzDm8U2thrhuvx+9HljsFBQXehE0mgrSDIqtIwBk+UXOD8JUI7IJNG+1
 f8610U9sALjfjZRuEwmllVvFoO9+WGc9d3OX3NfqMBmvyJjVZX55sX3dc1UTdEU2vXyMsXYvCmo
 UAc/nc34CDrkfK8vyJU3g9UKEnMGyND8GiE4/SLHSRrEjZc5bbKeowXecCWV+RSRq61wfGh7js6
 OiLUH/AmpgC1Q23TjXD40MVf0lvcmBMFdq5zbjT7kimkwPYTfYvlo/rt2tKntsmnYBLynTx6j5Q
 whWMwNcEdbO1Q0BxMrGgLEpUAkS/yxlrMdY3SeVwmPO7qtn/WuvKlWeT3oyRDRIH+4Zf7vwdiaZ
 zM4248o5CtdqPXQ==
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 target/i386/cpu.c                | 4 ++++
 target/m68k/cpu.c                | 4 ++++
 target/sparc/cpu.c               | 5 +++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 441901fae8e..1d7d3700c93 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -120,11 +120,13 @@ typedef struct SysemuCPUOps {
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
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7248720a0eb..7efc223c787 100644
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
index 3df199ada7b..46af64c6a86 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -996,7 +996,7 @@ static const Property sparc_cpu_properties[] = {
 
 #ifdef TARGET_SPARC64
 #include "monitor/hmp.h"
-
+#ifdef CONFIG_HMP
 static const MonitorDef sparc64_monitor_defs[] = {
     { "asi", offsetof(CPUSPARCState, asi) },
     { "pstate", offsetof(CPUSPARCState, pstate) },
@@ -1008,6 +1008,7 @@ static const MonitorDef sparc64_monitor_defs[] = {
     { NULL },
 };
 #endif
+#endif
 
 #include "hw/core/sysemu-cpu-ops.h"
 
@@ -1015,7 +1016,7 @@ static const struct SysemuCPUOps sparc_sysemu_ops = {
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


