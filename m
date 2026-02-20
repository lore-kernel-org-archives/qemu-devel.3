Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC54C5B55D
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXe4-0000GJ-A2; Fri, 20 Feb 2026 16:02:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXe3-0000Fp-Cb
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:39 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXe0-0002mR-KU
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:39 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1734EC0235;
 Sat, 21 Feb 2026 00:02:25 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-FCqasedN; Sat, 21 Feb 2026 00:02:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621344;
 bh=tRBiQLKGo79cOro6QIhl/sbnCELCvPkPlcbxTt62d7c=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lBlIz2Km+/l0hwQtpC0y/OOV0h05IgTGyhRv9Gv1OYslYE9QSp4/hNO+a18VgCi4L
 JBnHTIl5nlecTicrXvaVCzj2aKHXfDIape4kqdFeVfR2GddTKXQFpsOh2xygZTlQkF
 ZZOWpIUdU5qc2tZp+EjzHQyYYXJDecLY4rzgy4KM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 15/16] migration/savevm: move to new migration APIs
Date: Sat, 21 Feb 2026 00:02:13 +0300
Message-ID: <20260220210214.800050-16-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220210214.800050-1-vsementsov@yandex-team.ru>
References: <20260220210214.800050-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/savevm.c | 107 +++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 52 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index c5236e71ba..8c001d7468 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -205,27 +205,28 @@ void timer_get(QEMUFile *f, QEMUTimer *ts)
  * Not in vmstate.c to not add qemu-timer.c as dependency to vmstate.c
  */
 
-static int get_timer(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field)
+static bool load_timer(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, Error **errp)
 {
     QEMUTimer *v = pv;
     timer_get(f, v);
-    return 0;
+    return true;
 }
 
-static int put_timer(QEMUFile *f, void *pv, size_t size,
-                     const VMStateField *field, JSONWriter *vmdesc)
+static bool save_timer(QEMUFile *f, void *pv, size_t size,
+                       const VMStateField *field, JSONWriter *vmdesc,
+                       Error **errp)
 {
     QEMUTimer *v = pv;
     timer_put(f, v);
 
-    return 0;
+    return true;
 }
 
 const VMStateInfo vmstate_info_timer = {
     .name = "timer",
-    .get  = get_timer,
-    .put  = put_timer,
+    .load  = load_timer,
+    .save  = save_timer,
 };
 
 
@@ -297,7 +298,7 @@ static uint32_t get_validatable_capabilities_count(void)
     return result;
 }
 
-static int configuration_pre_save(void *opaque)
+static bool configuration_pre_save(void *opaque, Error **errp)
 {
     SaveState *state = opaque;
     const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
@@ -318,7 +319,7 @@ static int configuration_pre_save(void *opaque)
     }
     state->uuid = qemu_uuid;
 
-    return 0;
+    return true;
 }
 
 static void configuration_post_save(void *opaque)
@@ -330,7 +331,7 @@ static void configuration_post_save(void *opaque)
     state->caps_count = 0;
 }
 
-static int configuration_pre_load(void *opaque)
+static bool configuration_pre_load(void *opaque, Error **errp)
 {
     SaveState *state = opaque;
 
@@ -339,7 +340,7 @@ static int configuration_pre_load(void *opaque)
      * minimum possible value for this CPU.
      */
     state->target_page_bits = migration_legacy_page_bits();
-    return 0;
+    return true;
 }
 
 static bool configuration_validate_capabilities(SaveState *state)
@@ -376,28 +377,31 @@ static bool configuration_validate_capabilities(SaveState *state)
     return ret;
 }
 
-static int configuration_post_load(void *opaque, int version_id)
+static bool configuration_post_load(void *opaque, int version_id, Error **errp)
 {
     SaveState *state = opaque;
     const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
-    int ret = 0;
+    bool ok = true;
 
     if (strncmp(state->name, current_name, state->len) != 0) {
-        error_report("Machine type received is '%.*s' and local is '%s'",
-                     (int) state->len, state->name, current_name);
-        ret = -EINVAL;
+        error_setg(errp,
+                   "Machine type received is '%.*s' and local is '%s'",
+                   (int) state->len, state->name, current_name);
+        ok = false;
         goto out;
     }
 
     if (state->target_page_bits != qemu_target_page_bits()) {
-        error_report("Received TARGET_PAGE_BITS is %d but local is %d",
-                     state->target_page_bits, qemu_target_page_bits());
-        ret = -EINVAL;
+        error_setg(errp,
+                   "Received TARGET_PAGE_BITS is %d but local is %d",
+                   state->target_page_bits, qemu_target_page_bits());
+        ok = false;
         goto out;
     }
 
     if (!configuration_validate_capabilities(state)) {
-        ret = -EINVAL;
+        error_setg(errp, "Failed to validate capabilities");
+        ok = false;
         goto out;
     }
 
@@ -409,11 +413,12 @@ out:
     state->capabilities = NULL;
     state->caps_count = 0;
 
-    return ret;
+    return ok;
 }
 
-static int get_capability(QEMUFile *f, void *pv, size_t size,
-                          const VMStateField *field)
+static bool load_capability(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field,
+                            Error **errp)
 {
     MigrationCapability *capability = pv;
     char capability_str[UINT8_MAX + 1];
@@ -426,15 +431,16 @@ static int get_capability(QEMUFile *f, void *pv, size_t size,
     for (i = 0; i < MIGRATION_CAPABILITY__MAX; i++) {
         if (!strcmp(MigrationCapability_str(i), capability_str)) {
             *capability = i;
-            return 0;
+            return true;
         }
     }
-    error_report("Received unknown capability %s", capability_str);
-    return -EINVAL;
+    error_setg(errp, "Received unknown capability %s", capability_str);
+    return false;
 }
 
-static int put_capability(QEMUFile *f, void *pv, size_t size,
-                          const VMStateField *field, JSONWriter *vmdesc)
+static bool save_capability(QEMUFile *f, void *pv, size_t size,
+                            const VMStateField *field, JSONWriter *vmdesc,
+                            Error **errp)
 {
     MigrationCapability *capability = pv;
     const char *capability_str = MigrationCapability_str(*capability);
@@ -443,13 +449,13 @@ static int put_capability(QEMUFile *f, void *pv, size_t size,
 
     qemu_put_byte(f, len);
     qemu_put_buffer(f, (uint8_t *)capability_str, len);
-    return 0;
+    return true;
 }
 
 static const VMStateInfo vmstate_info_capability = {
     .name = "capability",
-    .get  = get_capability,
-    .put  = put_capability,
+    .load = load_capability,
+    .save = save_capability,
 };
 
 /* The target-page-bits subsection is present only if the
@@ -539,9 +545,9 @@ static const VMStateDescription vmstate_uuid = {
 static const VMStateDescription vmstate_configuration = {
     .name = "configuration",
     .version_id = 1,
-    .pre_load = configuration_pre_load,
-    .post_load = configuration_post_load,
-    .pre_save = configuration_pre_save,
+    .pre_load_errp = configuration_pre_load,
+    .post_load_errp = configuration_post_load,
+    .pre_save_errp = configuration_pre_save,
     .post_save = configuration_post_save,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32(len, SaveState),
@@ -969,8 +975,13 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
         }
         return ret;
     }
-    return vmstate_load_state(f, se->vmsd, se->opaque, se->load_version_id,
-                              errp);
+
+    if (!vmstate_load_vmsd(f, se->vmsd, se->opaque, se->load_version_id,
+                           errp)) {
+        return -EINVAL;
+    }
+
+    return 0;
 }
 
 static void vmstate_save_old_style(QEMUFile *f, SaveStateEntry *se,
@@ -1028,8 +1039,6 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
                         Error **errp)
 {
-    int ret;
-
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
     }
@@ -1049,12 +1058,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     trace_vmstate_save(se->idstr, se->vmsd ? se->vmsd->name : "(old)");
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
-    } else {
-        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
-                                 errp);
-        if (ret) {
-            return ret;
-        }
+    } else if (!vmstate_save_vmsd(f, se->vmsd, se->opaque, vmdesc, errp)) {
+        return -EINVAL;
     }
 
     trace_savevm_section_end(se->idstr, se->section_id, 0);
@@ -1317,8 +1322,8 @@ static void qemu_savevm_send_configuration(MigrationState *s, QEMUFile *f)
         json_writer_start_object(vmdesc, "configuration");
     }
 
-    vmstate_save_state(f, &vmstate_configuration, &savevm_state,
-                       vmdesc, &local_err);
+    vmstate_save_vmsd(f, &vmstate_configuration, &savevm_state,
+                      vmdesc, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
@@ -2748,7 +2753,6 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
-    int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
@@ -2779,10 +2783,9 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
             return -EINVAL;
         }
 
-        ret = vmstate_load_state(f, &vmstate_configuration, &savevm_state, 0,
-                                 errp);
-        if (ret) {
-            return ret;
+        if (!vmstate_load_vmsd(f, &vmstate_configuration, &savevm_state, 0,
+                               errp)) {
+            return -EINVAL;
         }
     }
     return 0;
-- 
2.52.0


