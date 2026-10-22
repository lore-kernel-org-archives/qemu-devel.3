Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723AE606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fs3ENMU3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJqVM-0004WD-1r; Thu, 22 Oct 2026 06:58:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUk-00041Y-5k
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xJqUh-0001f3-Ba
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 06:58:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792666678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1gah91+wf8CPlKNBkPoB+vdQS+y3ma/UGPxFNHcQ3XE=;
 b=Fs3ENMU3DwZCgfeeCmz1++aMGjm/ymXwX3YDNY4lWj8d82MkdPzMgFLpy6bTlTXYM0TWGi
 x5mgRHRfTzmtmT6D5gXUqDoV4IvnYkwiwGUhxk2+sHMgSEUxUVB43XFBIygHIvffNwCDwG
 M8bAlr+SmiLRH2qj9oJzQpe6POYKXB0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-T_Ja87l5NyKhVqslGNi62A-1; Thu,
 22 Oct 2026 10:57:54 +0000
X-MC-Unique: T_Ja87l5NyKhVqslGNi62A-1
X-Mimecast-MFC-AGG-ID: T_Ja87l5NyKhVqslGNi62A_1792666671
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED4111955F7F; Thu, 22 Oct 2026 10:57:50 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1BEBA3000735; Thu, 22 Oct 2026 10:57:49 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Oct 2026 14:56:45 +0400
Subject: [PATCH v3 18/18] monitor/hmp: remove legacy MonitorDef infrastructure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261022-query-reg-v3-18-7ad902b9a7cf@redhat.com>
References: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
In-Reply-To: <20261022-query-reg-v3-0-7ad902b9a7cf@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5271;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=vI275i0qqXvhIWtGQBAYGltm9mR56E84ZbZmF5Hhirw=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq2evnM2OqOxXvXq3/7mTZvxwRawsbeC/Z5cwx9
 y8Ssk7O+oeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCatnr5wAKCRDa6OEJdZac
 5eeID/99PUntCdByU4jtuQXuJwrchm/gmTaP7xD0TcNezj0Ci73r8PyoAK4iREWppaJISf3pVen
 uNzjNQKEM8gVcZUCfRfYR2w5T0fPBHPdrkMeyRvY8Y+DiVWQTBa8RX+VYyLfRko8sxWVaICC9vO
 KCmqrrOfMxUR2l8DRUKxysnPtrww6jn4lGQOhXDLjuSawuturqvZmibCDXMLL07/+5Ru14oXgsQ
 LnfwI5dUIiCOLR/e+qmjNQZcgFYsOZ4O3rPdWHdvIaZA4XLwKCJZP0dk0eO+w/XApWbo8h81Nxp
 eWpUH5tt4Rj5tVuFleQ9AcrvWjkcywX226rfi1ty0A57LhCLFocbf5ph7mjXhRKKzRcML0Wk8It
 qxp/wCCT66sxSDnpSJZGtGRgDA2jBvY1xSKxvlIpaZpmJvA72TNe0v0y74qfHvEs9Cjb2eQHv0w
 xvhVAIdubrO6+DqqUaDrRxgb5Uz2NF29/rdamDD2b9FxkFwX40lLCEH1M/Sm6JTPZjPne/WRWKF
 pQTbZ3qQ7A70No5yYF9Z+XIEpWDwYdViwf5QTXpfRxDvsZRKnWpoc92Lx3pFAT4Y/pGBYOQwES0
 SOmhPeUUK6CIMVyFFzms6LkVqho/5pJ12QAnKCHnr0kuSqdDAltXnCz8wqOFc5xWeUTlZ/tR1b9
 FXq4HfNKMS+SHvA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 2
X-Spam_score: 0.2
X-Spam_bar: /
X-Spam_report: (0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that all targets expose their system registers via internal GDB
register descriptions (i386 segment limits, m68k, sparc64, RISC-V
aliases), the legacy MonitorDef table and
SysemuCPUOps::monitor_get_register callback are no longer needed.

HMP $register expressions now use gdb_get_register_list() exclusively.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/hw/core/sysemu-cpu-ops.h | 16 ---------------
 include/monitor/hmp.h            |  6 ------
 include/qemu/typedefs.h          |  1 -
 monitor/hmp.c                    | 43 +---------------------------------------
 4 files changed, 1 insertion(+), 65 deletions(-)

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
index e97e0a9ff0d7..feb604da27f2 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -25,7 +25,6 @@
 #include "qemu/osdep.h"
 #include <dirent.h>
 #include "hw/core/qdev.h"
-#include "hw/core/sysemu-cpu-ops.h"
 #include "monitor-internal.h"
 #include "monitor-hmp-internal.h"
 #include "monitor/hmp.h"
@@ -443,8 +442,6 @@ static bool gdb_get_register(MonitorHMP *hmp, int64_t *pval, const char *name)
 static const char *pch;
 static sigjmp_buf expr_env;
 
-static int get_monitor_def(MonitorHMP *mon, int64_t *pval, const char *name);
-
 static G_NORETURN G_GNUC_PRINTF(2, 3)
 void expr_error(MonitorHMP *mon, const char *fmt, ...)
 {
@@ -526,8 +523,7 @@ static int64_t expr_unary(MonitorHMP *mon)
                 pch++;
             }
             *q = 0;
-            if (!gdb_get_register(mon, &reg, buf)
-                && get_monitor_def(mon, &reg, buf) < 0) {
+            if (!gdb_get_register(mon, &reg, buf)) {
                 expr_error(mon, "unknown register");
             }
             n = reg;
@@ -1720,43 +1716,6 @@ void monitor_register_hmp_info_hrt(const char *name,
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

-- 
2.56.0.116.g6de20f6092dc


