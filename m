Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818E8E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 12:20:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDue-0001Vt-C4; Fri, 10 Jan 2025 07:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDud-0001Vk-7g
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:51 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDub-0003NN-0x
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:50 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFF1221176;
 Fri, 10 Jan 2025 12:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDx1STeCdbkhKG03t63T4RiBTggPH9KXZugQirGqihw=;
 b=LpQLMUp/y0WLqQ2h/vqae+/eN6RH/NRQXdCiyHuWi6xM3X1JOTytjuLhXxBXLScwstUw6k
 sR9uwjLJbpU1Ef5DyPbJeSDMSzzXhgGBz8EMnz1iJU6TcQNMdkzssa5MEt7uHk7DnwptOA
 e8Vp0e04UmioIVc7I3kc9toPgYRnlP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDx1STeCdbkhKG03t63T4RiBTggPH9KXZugQirGqihw=;
 b=ZQ0MweFwWRSSt9UsjA1JM18GVJA1fqYo0tclHfTHgWjizoKRu36MZTA1OKULkCZhtZOHUz
 VJW2YShNzUwEtzCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDx1STeCdbkhKG03t63T4RiBTggPH9KXZugQirGqihw=;
 b=LpQLMUp/y0WLqQ2h/vqae+/eN6RH/NRQXdCiyHuWi6xM3X1JOTytjuLhXxBXLScwstUw6k
 sR9uwjLJbpU1Ef5DyPbJeSDMSzzXhgGBz8EMnz1iJU6TcQNMdkzssa5MEt7uHk7DnwptOA
 e8Vp0e04UmioIVc7I3kc9toPgYRnlP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511286;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LDx1STeCdbkhKG03t63T4RiBTggPH9KXZugQirGqihw=;
 b=ZQ0MweFwWRSSt9UsjA1JM18GVJA1fqYo0tclHfTHgWjizoKRu36MZTA1OKULkCZhtZOHUz
 VJW2YShNzUwEtzCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D632C13A86;
 Fri, 10 Jan 2025 12:14:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4OJ1JjUPgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:45 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 20/25] migration: Dump correct JSON format for nullptr
 replacement
Date: Fri, 10 Jan 2025 09:14:08 -0300
Message-Id: <20250110121413.12336-21-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

QEMU plays a trick with null pointers inside an array of pointers in a VMSD
field.  See 07d4e69147 ("migration/vmstate: fix array of ptr with
nullptrs") for more details on why.  The idea makes sense in general, but
it may overlooked the JSON writer where it could write nothing in a
"struct" in the JSON hints section.

We hit some analyze-migration.py issues on s390 recently, showing that some
of the struct field contains nothing, like:

{"name": "css", "array_len": 256, "type": "struct", "struct": {}, "size": 1}

As described in details by Fabiano:

https://lore.kernel.org/r/87pll37cin.fsf@suse.de

It could be that we hit some null pointers there, and JSON was gone when
they're null pointers.

To fix it, instead of hacking around only at VMStateInfo level, do that
from VMStateField level, so that JSON writer can also be involved.  In this
case, JSON writer will replace the pointer array (which used to be a
"struct") to be the real representation of the nullptr field.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-6-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c | 118 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 91 insertions(+), 27 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index aa2821dec6..52704c822c 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -51,6 +51,36 @@ vmstate_field_exists(const VMStateDescription *vmsd, const VMStateField *field,
     return result;
 }
 
+/*
+ * Create a fake nullptr field when there's a NULL pointer detected in the
+ * array of a VMS_ARRAY_OF_POINTER VMSD field.  It's needed because we
+ * can't dereference the NULL pointer.
+ */
+static const VMStateField *
+vmsd_create_fake_nullptr_field(const VMStateField *field)
+{
+    VMStateField *fake = g_new0(VMStateField, 1);
+
+    /* It can only happen on an array of pointers! */
+    assert(field->flags & VMS_ARRAY_OF_POINTER);
+
+    /* Some of fake's properties should match the original's */
+    fake->name = field->name;
+    fake->version_id = field->version_id;
+
+    /* Do not need "field_exists" check as it always exists (which is null) */
+    fake->field_exists = NULL;
+
+    /* See vmstate_info_nullptr - use 1 byte to represent nullptr */
+    fake->size = 1;
+    fake->info = &vmstate_info_nullptr;
+    fake->flags = VMS_SINGLE;
+
+    /* All the rest fields shouldn't matter.. */
+
+    return (const VMStateField *)fake;
+}
+
 static int vmstate_n_elems(void *opaque, const VMStateField *field)
 {
     int n_elems = 1;
@@ -143,23 +173,39 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
+                const VMStateField *inner_field;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
                 }
+
                 if (!curr_elem && size) {
-                    /* if null pointer check placeholder and do not follow */
-                    assert(field->flags & VMS_ARRAY_OF_POINTER);
-                    ret = vmstate_info_nullptr.get(f, curr_elem, size, NULL);
-                } else if (field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
-                                             field->vmsd->version_id);
-                } else if (field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_load_state(f, field->vmsd, curr_elem,
-                                             field->struct_version_id);
+                    /*
+                     * If null pointer found (which should only happen in
+                     * an array of pointers), use null placeholder and do
+                     * not follow.
+                     */
+                    inner_field = vmsd_create_fake_nullptr_field(field);
                 } else {
-                    ret = field->info->get(f, curr_elem, size, field);
+                    inner_field = field;
                 }
+
+                if (inner_field->flags & VMS_STRUCT) {
+                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
+                                             inner_field->vmsd->version_id);
+                } else if (inner_field->flags & VMS_VSTRUCT) {
+                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
+                                             inner_field->struct_version_id);
+                } else {
+                    ret = inner_field->info->get(f, curr_elem, size,
+                                                 inner_field);
+                }
+
+                /* If we used a fake temp field.. free it now */
+                if (inner_field != field) {
+                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                }
+
                 if (ret >= 0) {
                     ret = qemu_file_get_error(f);
                 }
@@ -387,29 +433,50 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
             }
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
+                const VMStateField *inner_field;
 
-                vmsd_desc_field_start(vmsd, vmdesc_loop, field, i, n_elems);
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     assert(curr_elem);
                     curr_elem = *(void **)curr_elem;
                 }
+
                 if (!curr_elem && size) {
-                    /* if null pointer write placeholder and do not follow */
-                    assert(field->flags & VMS_ARRAY_OF_POINTER);
-                    ret = vmstate_info_nullptr.put(f, curr_elem, size, NULL,
-                                                   NULL);
-                } else if (field->flags & VMS_STRUCT) {
-                    ret = vmstate_save_state(f, field->vmsd, curr_elem,
-                                             vmdesc_loop);
-                } else if (field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_save_state_v(f, field->vmsd, curr_elem,
-                                               vmdesc_loop,
-                                               field->struct_version_id, errp);
+                    /*
+                     * If null pointer found (which should only happen in
+                     * an array of pointers), use null placeholder and do
+                     * not follow.
+                     */
+                    inner_field = vmsd_create_fake_nullptr_field(field);
                 } else {
-                    ret = field->info->put(f, curr_elem, size, field,
-                                     vmdesc_loop);
+                    inner_field = field;
                 }
+
+                vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
+                                      i, n_elems);
+
+                if (inner_field->flags & VMS_STRUCT) {
+                    ret = vmstate_save_state(f, inner_field->vmsd,
+                                             curr_elem, vmdesc_loop);
+                } else if (inner_field->flags & VMS_VSTRUCT) {
+                    ret = vmstate_save_state_v(f, inner_field->vmsd,
+                                               curr_elem, vmdesc_loop,
+                                               inner_field->struct_version_id,
+                                               errp);
+                } else {
+                    ret = inner_field->info->put(f, curr_elem, size,
+                                                 inner_field, vmdesc_loop);
+                }
+
+                written_bytes = qemu_file_transferred(f) - old_offset;
+                vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
+                                    written_bytes);
+
+                /* If we used a fake temp field.. free it now */
+                if (inner_field != field) {
+                    g_clear_pointer((gpointer *)&inner_field, g_free);
+                }
+
                 if (ret) {
                     error_setg(errp, "Save of field %s/%s failed",
                                 vmsd->name, field->name);
@@ -419,9 +486,6 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     return ret;
                 }
 
-                written_bytes = qemu_file_transferred(f) - old_offset;
-                vmsd_desc_field_end(vmsd, vmdesc_loop, field, written_bytes);
-
                 /* Compressed arrays only care about the first element */
                 if (vmdesc_loop && vmsd_can_compress(field)) {
                     vmdesc_loop = NULL;
-- 
2.35.3


