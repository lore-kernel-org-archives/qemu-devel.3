Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0459AFDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcM-0003HC-Gd; Thu, 23 Apr 2026 15:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcF-0002X6-Df
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:37 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcD-00025B-7t
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBE0B6A8A8;
 Thu, 23 Apr 2026 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjeGSJmCeH6X7iob4o4x+DB7RJK/iTyXeF+vFeqKpmo=;
 b=J6+gqmpQwbLzAXMnnt66q8Ki8nS1CFtjJ85JSrFZfZDqvrE/6QRgXJQoCMqLxS+yTquwt+
 rfrJgjMtMnFS9Db+CSzx1jJXjJteLGbDn4rzUaSfK3fllfo7mJhiGgLpqPMxFoRPDQo1ie
 dyGUuT8QmFY4s01IQRoA78rpaAIS5ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjeGSJmCeH6X7iob4o4x+DB7RJK/iTyXeF+vFeqKpmo=;
 b=4yvQQDrGa4eap6OKRxyt0Lq8kqnjoaRO1j/La5VPfnwWhrZE1ICgnhcozjcJioFil7o/wd
 Tiiy3KHipAWnVxCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972025; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjeGSJmCeH6X7iob4o4x+DB7RJK/iTyXeF+vFeqKpmo=;
 b=J6+gqmpQwbLzAXMnnt66q8Ki8nS1CFtjJ85JSrFZfZDqvrE/6QRgXJQoCMqLxS+yTquwt+
 rfrJgjMtMnFS9Db+CSzx1jJXjJteLGbDn4rzUaSfK3fllfo7mJhiGgLpqPMxFoRPDQo1ie
 dyGUuT8QmFY4s01IQRoA78rpaAIS5ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972025;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YjeGSJmCeH6X7iob4o4x+DB7RJK/iTyXeF+vFeqKpmo=;
 b=4yvQQDrGa4eap6OKRxyt0Lq8kqnjoaRO1j/La5VPfnwWhrZE1ICgnhcozjcJioFil7o/wd
 Tiiy3KHipAWnVxCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3CB1593A3;
 Thu, 23 Apr 2026 19:20:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wDe9J/hw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 17/43] migration/savevm: move to new migration APIs
Date: Thu, 23 Apr 2026 16:19:31 -0300
Message-ID: <20260423191958.1440-18-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-16-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/savevm.c | 105 ++++++++++++++++++++++++---------------------
 1 file changed, 55 insertions(+), 50 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 699d2c9f8b..8115203b51 100644
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
@@ -1050,10 +1059,8 @@ static int vmstate_save(QEMUFile *f, SaveStateEntry *se, JSONWriter *vmdesc,
     if (!se->vmsd) {
         vmstate_save_old_style(f, se, vmdesc);
     } else {
-        ret = vmstate_save_state(f, se->vmsd, se->opaque, vmdesc,
-                                 errp);
-        if (ret) {
-            return ret;
+        if (!vmstate_save_vmsd(f, se->vmsd, se->opaque, vmdesc, errp)) {
+            return -EINVAL;
         }
     }
 
@@ -1311,8 +1318,8 @@ static void qemu_savevm_send_configuration(MigrationState *s, QEMUFile *f)
         json_writer_start_object(vmdesc, "configuration");
     }
 
-    vmstate_save_state(f, &vmstate_configuration, &savevm_state,
-                       vmdesc, &local_err);
+    vmstate_save_vmsd(f, &vmstate_configuration, &savevm_state,
+                      vmdesc, &local_err);
     if (local_err) {
         error_report_err(local_err);
     }
@@ -2721,7 +2728,6 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
 {
     unsigned int v;
-    int ret;
 
     v = qemu_get_be32(f);
     if (v != QEMU_VM_FILE_MAGIC) {
@@ -2752,10 +2758,9 @@ static int qemu_loadvm_state_header(QEMUFile *f, Error **errp)
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
2.51.0


