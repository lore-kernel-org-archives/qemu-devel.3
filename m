Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F869CCF9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:20:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDsu5-00038Q-9w; Tue, 28 Oct 2025 19:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstu-00037T-4Y
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:50 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstZ-00018J-M2
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:49 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id ACEF08177A;
 Wed, 29 Oct 2025 02:14:04 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-VelCEPAQ; Wed, 29 Oct 2025 02:14:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693244;
 bh=+knwUWedSlJ+bK+l2EihRlaK7GqDMvgSpwZc7/hhY3I=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=KikwEammD27/em0yhEXxLPq6hnnG8tqY0kkdA38skcA1/D77hrmMyIJWEMMVzKepH
 hC2vkVcEQBIOss2+pP1/MwKOttM5ikvqcp3h/PImk8bqIfBtaRx4i4JS6GXe8DUgvp
 7klJ8qsCvWVMKG/CLBGz0ohkxKqLxXXVycp7QkJw=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 18/22] migration/savevm: move to new migration APIs
Date: Wed, 29 Oct 2025 02:13:42 +0300
Message-ID: <20251028231347.194844-19-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
 migration/savevm.c | 108 +++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 7b35ec4dd0..e2681880f0 100644
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
 
 
@@ -298,7 +299,7 @@ static uint32_t get_validatable_capabilities_count(void)
     return result;
 }
 
-static int configuration_pre_save(void *opaque)
+static bool configuration_pre_save(void *opaque, Error **errp)
 {
     SaveState *state = opaque;
     const char *current_name = MACHINE_GET_CLASS(current_machine)->name;
@@ -319,7 +320,7 @@ static int configuration_pre_save(void *opaque)
     }
     state->uuid = qemu_uuid;
 
-    return 0;
+    return true;
 }
 
 static int configuration_post_save(void *opaque)
@@ -332,7 +333,7 @@ static int configuration_post_save(void *opaque)
     return 0;
 }
 
-static int configuration_pre_load(void *opaque)
+static bool configuration_pre_load(void *opaque, Error **errp)
 {
     SaveState *state = opaque;
 
@@ -341,7 +342,7 @@ static int configuration_pre_load(void *opaque)
      * minimum possible value for this CPU.
      */
     state->target_page_bits = migration_legacy_page_bits();
-    return 0;
+    return true;
 }
 
 static bool configuration_validate_capabilities(SaveState *state)
@@ -378,28 +379,31 @@ static bool configuration_validate_capabilities(SaveState *state)
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
 
@@ -411,11 +415,12 @@ out:
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
@@ -428,15 +433,16 @@ static int get_capability(QEMUFile *f, void *pv, size_t size,
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
@@ -445,13 +451,13 @@ static int put_capability(QEMUFile *f, void *pv, size_t size,
 
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
@@ -541,9 +547,9 @@ static const VMStateDescription vmstate_uuid = {
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
@@ -975,8 +981,13 @@ static int vmstate_load(QEMUFile *f, SaveStateEntry *se, Error **errp)
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
@@ -1034,8 +1045,6 @@ static void save_section_footer(QEMUFile *f, SaveStateEntry *se)
 static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
                         Error **errp)
 {
-    int ret;
-
     if ((!se->ops || !se->ops->save_state) && !se->vmsd) {
         return 0;
     }
@@ -1055,12 +1064,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
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
@@ -1304,9 +1309,8 @@ void qemu_savevm_state_header(QEMUFile *f)
             json_writer_start_object(vmdesc, "configuration");
         }
 
-        vmstate_save_state(f, &vmstate_configuration, &savevm_state,
-                           vmdesc, &local_err);
-        if (local_err) {
+        if (!vmstate_save_vmsd(f, &vmstate_configuration, &savevm_state,
+                                vmdesc, &local_err)) {
             error_report_err(local_err);
         }
 
@@ -2850,7 +2854,6 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
-    int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
@@ -2881,10 +2884,9 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
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
2.48.1


