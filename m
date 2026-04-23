Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13027FDEE3F
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcM-0003Fj-1C; Thu, 23 Apr 2026 15:21:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzc8-0002O8-V2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzc6-0001xm-GJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F1556A8A6;
 Thu, 23 Apr 2026 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtUkCGsNiesst2i1bvrl5h5U1TI8T4XQdvIydALDlWc=;
 b=Olxu/mrj4BgxuahMT6bSIpxfh37YAOcjUIsTx3JJGur+/PGdtmYKLHRP49ToY0idscML6C
 MEFazHSQIripAVg+jY/1I5/TkCThLnPoBkO1+sbAgfREbNmZPnOWO/H+CL05KgcbtvThPd
 ZejaTL6oAumNg2Jf3DtNlzbJe1K76Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtUkCGsNiesst2i1bvrl5h5U1TI8T4XQdvIydALDlWc=;
 b=WBszDAVG89IxwatMGXhE3nIegEdZwhtgYiIn6uD+oGy7Qrvqv1JhuAkQJMj643Ld6K91yk
 DGTW/nsdzDMPu5Ag==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Olxu/mrj";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=WBszDAVG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtUkCGsNiesst2i1bvrl5h5U1TI8T4XQdvIydALDlWc=;
 b=Olxu/mrj4BgxuahMT6bSIpxfh37YAOcjUIsTx3JJGur+/PGdtmYKLHRP49ToY0idscML6C
 MEFazHSQIripAVg+jY/1I5/TkCThLnPoBkO1+sbAgfREbNmZPnOWO/H+CL05KgcbtvThPd
 ZejaTL6oAumNg2Jf3DtNlzbJe1K76Es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtUkCGsNiesst2i1bvrl5h5U1TI8T4XQdvIydALDlWc=;
 b=WBszDAVG89IxwatMGXhE3nIegEdZwhtgYiIn6uD+oGy7Qrvqv1JhuAkQJMj643Ld6K91yk
 DGTW/nsdzDMPu5Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A7EA593A3;
 Thu, 23 Apr 2026 19:20:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kFo4MvVw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 15/43] migration: introduce vmstate_load_vmsd() and
 vmstate_save_vmsd()
Date: Thu, 23 Apr 2026 16:19:29 -0300
Message-ID: <20260423191958.1440-16-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 0F1556A8A6
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

Introduce new APIs, returning bool.
The analysis
https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
shows, that vmstate_load_state() return value actually only
used to check for success, specific errno values doesn't make
sense.

With this commit we introduce new functions with modern bool
interface, and in following commits we'll update the
code base to use them, starting from migration/ code, and
finally we will remove old vmstate_load_state() and
vmstate_save_state().

This patch reworks existing functions to new one, so that
old interfaces are simple wrappers, which will be easy to
remove later.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-14-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 include/migration/vmstate.h |  9 ++++
 migration/vmstate.c         | 89 ++++++++++++++++++++-----------------
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 65683d8d87..66c2e87bd3 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1257,10 +1257,19 @@ extern const VMStateInfo vmstate_info_qlist;
         .flags = VMS_END, \
     }
 
+/*
+ * vmstate_load_state() and vmstate_save_state() are
+ * depreacated, use vmstate_load_vmsd() and vmstate_save_vmsd()
+ * instead.
+ */
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
 int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
+bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, int version_id, Error **errp);
+bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc, Error **errp);
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index f16626d7d1..e98b5f5346 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -26,7 +26,7 @@ static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                     Error **errp);
 static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                     void *opaque, Error **errp);
-static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp);
 
@@ -165,11 +165,11 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
                                const VMStateField *field, Error **errp)
 {
     if (field->flags & VMS_STRUCT) {
-        return vmstate_load_state(f, field->vmsd, pv, field->vmsd->version_id,
-                                  errp) >= 0;
+        return vmstate_load_vmsd(f, field->vmsd, pv, field->vmsd->version_id,
+                                 errp);
     } else if (field->flags & VMS_VSTRUCT) {
-        return vmstate_load_state(f, field->vmsd, pv, field->struct_version_id,
-                                  errp) >= 0;
+        return vmstate_load_vmsd(f, field->vmsd, pv, field->struct_version_id,
+                                 errp);
     } else if (field->info->load) {
         return field->info->load(f, pv, size, field, errp);
     }
@@ -211,12 +211,11 @@ static bool vmstate_post_load(const VMStateDescription *vmsd,
     return true;
 }
 
-int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
+bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
     ERRP_GUARD();
     const VMStateField *field = vmsd->fields;
-    int ret = 0;
 
     trace_vmstate_load_state(vmsd->name, version_id);
 
@@ -225,7 +224,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                    "for local version_id %d",
                    vmsd->name, version_id, vmsd->version_id);
         trace_vmstate_load_state_fail(vmsd->name, "too new");
-        return -EINVAL;
+        return false;
     }
 
     if  (version_id < vmsd->minimum_version_id) {
@@ -233,11 +232,11 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                    "for local minimum version_id %d",
                    vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_fail(vmsd->name, "too old");
-        return -EINVAL;
+        return false;
     }
 
     if (!vmstate_pre_load(vmsd, opaque, errp)) {
-        return -EINVAL;
+        return false;
     }
 
     while (field->name) {
@@ -257,6 +256,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
+                bool ok;
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
 
@@ -275,33 +275,32 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                     inner_field = field;
                 }
 
-                ret = vmstate_load_field(f, curr_elem, size, inner_field,
-                                         errp) ? 0 : -EINVAL;
+                ok = vmstate_load_field(f, curr_elem, size, inner_field, errp);
 
                 /* If we used a fake temp field.. free it now */
                 if (inner_field != field) {
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-                if (ret >= 0) {
-                    ret = qemu_file_get_error(f);
+                if (ok) {
+                    int ret = qemu_file_get_error(f);
                     if (ret < 0) {
                         error_setg(errp,
                                    "Failed to load %s state: stream error: %d",
                                    vmsd->name, ret);
                         trace_vmstate_load_field_error(field->name, ret);
-                        return ret;
+                        return false;
                     }
                 } else {
-                    qemu_file_set_error(f, ret);
-                    trace_vmstate_load_field_error(field->name, ret);
-                    return ret;
+                    qemu_file_set_error(f, -EINVAL);
+                    trace_vmstate_load_field_error(field->name, -EINVAL);
+                    return false;
                 }
             }
         } else if (field->flags & VMS_MUST_EXIST) {
             error_setg(errp, "Input validation failed: %s/%s version_id: %d",
                        vmsd->name, field->name, vmsd->version_id);
-            return -1;
+            return false;
         }
         field++;
     }
@@ -309,17 +308,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
     if (!vmstate_subsection_load(f, vmsd, opaque, errp)) {
         qemu_file_set_error(f, -EINVAL);
-        return -EINVAL;
+        return false;
     }
 
     if (!vmstate_post_load(vmsd, opaque, version_id, errp)) {
         trace_vmstate_load_state_fail(vmsd->name, "post-load");
-        return -EINVAL;
+        return false;
     }
 
     trace_vmstate_load_state_success(vmsd->name);
-
-    return 0;
+    return true;
 }
 
 static int vmfield_name_num(const VMStateField *start,
@@ -492,11 +490,10 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
                                JSONWriter *vmdesc, Error **errp)
 {
     if (field->flags & VMS_STRUCT) {
-        return vmstate_save_state(f, field->vmsd, pv, vmdesc, errp) >= 0;
+        return vmstate_save_vmsd(f, field->vmsd, pv, vmdesc, errp);
     } else if (field->flags & VMS_VSTRUCT) {
-        return vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
-                                    field->struct_version_id,
-                                    errp) >= 0;
+        return vmstate_save_vmsd_v(f, field->vmsd, pv, vmdesc,
+                                   field->struct_version_id, errp);
     } else if (field->info->save) {
         return field->info->save(f, pv, size, field, vmdesc, errp);
     }
@@ -509,19 +506,19 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
-static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
 {
     ERRP_GUARD();
-    int ret = 0;
+    bool ok = true;
     const VMStateField *field = vmsd->fields;
 
     trace_vmstate_save_state_top(vmsd->name);
 
     if (!vmstate_pre_save(vmsd, opaque, errp)) {
         trace_vmstate_save_state_pre_save_fail(vmsd->name);
-        return -EINVAL;
+        return false;
     }
 
     trace_vmstate_save_state_pre_save_success(vmsd->name);
@@ -602,8 +599,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
                                       i, max_elems);
 
-                ret = vmstate_save_field(f, curr_elem, size, inner_field,
-                                         vmdesc_loop, errp) ? 0 : -EINVAL;
+                ok = vmstate_save_field(f, curr_elem, size, inner_field,
+                                        vmdesc_loop, errp);
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
@@ -614,7 +611,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-                if (ret) {
+                if (!ok) {
                     error_prepend(errp, "Save of field %s/%s failed: ",
                                   vmsd->name, field->name);
                     goto out;
@@ -640,13 +637,13 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp) ? 0 : -EINVAL;
+    ok = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
 out:
     if (vmsd->post_save) {
         vmsd->post_save(opaque);
     }
-    return ret;
+    return ok;
 }
 
 static const VMStateDescription *
@@ -663,11 +660,11 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
     return NULL;
 }
 
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc_id, Error **errp)
 {
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id,
-                                errp);
+    return vmstate_save_vmsd_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id,
+                               errp);
 }
 
 static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
@@ -712,7 +709,7 @@ static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        if (vmstate_load_state(f, sub_vmsd, opaque, version_id, errp) < 0) {
+        if (!vmstate_load_vmsd(f, sub_vmsd, opaque, version_id, errp)) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
             error_prepend(errp,
                           "Loading VM subsection '%s' in '%s' failed: ",
@@ -754,7 +751,7 @@ static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            if (vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp) < 0) {
+            if (!vmstate_save_vmsd(f, vmsdsub, opaque, vmdesc, errp)) {
                 return false;
             }
 
@@ -771,3 +768,15 @@ static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
 
     return true;
 }
+
+int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_vmsd(f, vmsd, opaque, vmdesc_id, errp) ? 0 : -EINVAL;
+}
+
+int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
+                        void *opaque, int version_id, Error **errp)
+{
+    return vmstate_load_vmsd(f, vmsd, opaque, version_id, errp) ? 0 : -EINVAL;
+}
-- 
2.51.0


