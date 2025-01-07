Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B88E77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 19:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVFbJ-00039w-Lw; Tue, 07 Jan 2025 14:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb7-00038N-5N
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:41 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVFb5-0002Eo-4X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 14:50:40 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ABB3521158;
 Tue,  7 Jan 2025 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIP/6o+rKhv4khLch6PKY9TiDrv/CklNSeV4d0gYPtY=;
 b=URrhT095zVbhnPpo8MVV4AV/skuAUajdV4EAl/pPs4GvxBheXrXvpRRUiV6k7fEcAj2FO3
 yrICkiD8fYg972gWsVXhPgUhQipnCSVtF2fogy6T7Ep9qqdPwOdDom3drgiAATSEf7ljhV
 G3bZpbFCHHjZ1t+dKMdhbZRHCa01J0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIP/6o+rKhv4khLch6PKY9TiDrv/CklNSeV4d0gYPtY=;
 b=LnCtQMIl2NsR/lnUK8LeYtBU4+et1qmOd7lMProrfTijmCjGWBh8BKgChg6YI81dCulYVN
 GkorlNzqqxkhxWDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=URrhT095;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LnCtQMIl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736279437; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIP/6o+rKhv4khLch6PKY9TiDrv/CklNSeV4d0gYPtY=;
 b=URrhT095zVbhnPpo8MVV4AV/skuAUajdV4EAl/pPs4GvxBheXrXvpRRUiV6k7fEcAj2FO3
 yrICkiD8fYg972gWsVXhPgUhQipnCSVtF2fogy6T7Ep9qqdPwOdDom3drgiAATSEf7ljhV
 G3bZpbFCHHjZ1t+dKMdhbZRHCa01J0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736279437;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XIP/6o+rKhv4khLch6PKY9TiDrv/CklNSeV4d0gYPtY=;
 b=LnCtQMIl2NsR/lnUK8LeYtBU4+et1qmOd7lMProrfTijmCjGWBh8BKgChg6YI81dCulYVN
 GkorlNzqqxkhxWDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A29013A6A;
 Tue,  7 Jan 2025 19:50:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0Lv/D4yFfWeCGAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 07 Jan 2025 19:50:36 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH 5/7] migration: Dump correct JSON format for nullptr
 replacement
Date: Tue,  7 Jan 2025 16:50:23 -0300
Message-Id: <20250107195025.9951-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250107195025.9951-1-farosas@suse.de>
References: <20250107195025.9951-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ABB3521158
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,analyze-migration.py:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


