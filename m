Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA15CCD1BF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDsty-00037f-Cf; Tue, 28 Oct 2025 19:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstt-00037L-21
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:49 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstb-000194-7P
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:48 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id A869E81783;
 Wed, 29 Oct 2025 02:14:07 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-QBXgxjNx; Wed, 29 Oct 2025 02:14:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693247;
 bh=1PkYR+WTNmRU23OU/YYsEUvRuQ70o5MoU24qYzgUXGc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UxMKqDcrW5k8EoG3y2Kay3bYthzL4u2yEEoTOSD1t8rdf9Pym5VGv1TgmILkJ1ngJ
 5Uxjds/mEF/PmSXYRMZ2EACmvvH9DVCv62qi/SQ1YqkIbDmYG21iHkE6z5wo5n3mxm
 0IvpGgDMeCcFaH4oQNEXFRIkZgxgKacPa7B0yXq0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 22/22] migration: finally convert vmstate_save/load_state()
 functions
Date: Wed, 29 Oct 2025 02:13:46 +0300
Message-ID: <20251028231347.194844-23-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Now they are used only to relize their wrappers
vmstate_save/load_vmsd(). So, let's do final convertion.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/migration/vmstate.h |  21 +-----
 migration/vmstate.c         | 141 ++++++++++++++++++------------------
 2 files changed, 74 insertions(+), 88 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index aaeb33045e..b2fda750e3 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1222,27 +1222,10 @@ extern const VMStateInfo vmstate_info_qlist;
         .flags = VMS_END, \
     }
 
-int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
+bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp);
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
+bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, JSONWriter *vmdesc, Error **errp);
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc,
-                         int version_id, Error **errp);
-
-static inline bool vmstate_load_vmsd(
-    QEMUFile *f, const VMStateDescription *vmsd,
-    void *opaque, int version_id, Error **errp)
-{
-    return vmstate_load_state(f, vmsd, opaque, version_id, errp) >= 0;
-}
-
-static inline bool vmstate_save_vmsd(
-    QEMUFile *f, const VMStateDescription *vmsd,
-    void *opaque, JSONWriter *vmdesc, Error **errp)
-{
-    return vmstate_save_state(f, vmsd, opaque, vmdesc, errp) >= 0;
-}
 
 bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque);
 
diff --git a/migration/vmstate.c b/migration/vmstate.c
index 2298f190de..b8fb1d0a40 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -131,12 +131,11 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
     }
 }
 
-int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
+bool vmstate_load_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
     ERRP_GUARD();
     const VMStateField *field = vmsd->fields;
-    int ret = 0;
 
     trace_vmstate_load_state(vmsd->name, version_id);
     if (version_id > vmsd->version_id) {
@@ -144,14 +143,14 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                    "for local version_id %d",
                    vmsd->name, version_id, vmsd->version_id);
         trace_vmstate_load_state_end(vmsd->name, "too new", -EINVAL);
-        return -EINVAL;
+        return false;
     }
     if  (version_id < vmsd->minimum_version_id) {
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
                    vmsd->name, version_id, vmsd->minimum_version_id);
         trace_vmstate_load_state_end(vmsd->name, "too old", -EINVAL);
-        return -EINVAL;
+        return false;
     }
     if (vmsd->pre_load_errp) {
         if (!vmsd->pre_load_errp(opaque, errp)) {
@@ -159,16 +158,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                           "version_id: %d, minimum version_id: %d: ",
                           vmsd->name, vmsd->version_id,
                           vmsd->minimum_version_id);
-            return -EINVAL;
+            return false;
         }
     } else if (vmsd->pre_load) {
-        ret = vmsd->pre_load(opaque);
+        int ret = vmsd->pre_load(opaque);
         if (ret) {
             error_setg(errp, "pre load hook failed for: '%s', "
                        "version_id: %d, minimum version_id: %d, ret: %d",
                        vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
                        ret);
-            return ret;
+            return false;
         }
     }
     while (field->name) {
@@ -187,6 +186,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
+                bool ok;
 
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
                     curr_elem = *(void **)curr_elem;
@@ -204,21 +204,20 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                 }
 
                 if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->vmsd->version_id,
-                                             errp);
+                    ok = vmstate_load_vmsd(f, inner_field->vmsd, curr_elem,
+                                           inner_field->vmsd->version_id,
+                                           errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->struct_version_id,
-                                             errp);
+                    ok = vmstate_load_vmsd(f, inner_field->vmsd, curr_elem,
+                                           inner_field->struct_version_id,
+                                           errp);
                 } else {
-                    if (!inner_field->info->load(
-                        f, curr_elem, size, inner_field, errp)) {
-                            error_prepend(
-                                errp,
-                                "Failed to load element of type %s for %s: ",
-                                inner_field->info->name, inner_field->name);
-                            ret = -EINVAL;
+                    ok = inner_field->info->load(f, curr_elem, size,
+                                                 inner_field, errp);
+                    if (!ok) {
+                        error_prepend(errp,
+                            "Failed to load element of type %s for %s: ",
+                            inner_field->info->name, inner_field->name);
                     }
                 }
 
@@ -227,24 +226,25 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-                if (ret >= 0) {
-                    ret = qemu_file_get_error(f);
+                if (ok) {
+                    int ret = qemu_file_get_error(f);
                     if (ret < 0) {
+                        ok = false;
                         error_setg(errp,
                                    "Failed to load %s state: stream error: %d",
                                    vmsd->name, ret);
                     }
                 }
-                if (ret < 0) {
-                    qemu_file_set_error(f, ret);
-                    trace_vmstate_load_field_error(field->name, ret);
-                    return ret;
+                if (!ok) {
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
@@ -258,20 +258,24 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             error_prepend(errp, "post load hook failed for: %s, version_id: "
                           "%d, minimum_version: %d: ", vmsd->name,
                           vmsd->version_id, vmsd->minimum_version_id);
-            ret = -EINVAL;
+            trace_vmstate_load_state_end(vmsd->name, "end", -EINVAL);
+            return false;
         }
     } else if (vmsd->post_load) {
-        ret = vmsd->post_load(opaque, version_id);
+        int ret = vmsd->post_load(opaque, version_id);
         if (ret < 0) {
             error_setg(errp,
                        "post load hook failed for: %s, version_id: %d, "
                        "minimum_version: %d, ret: %d",
                        vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
                        ret);
+            trace_vmstate_load_state_end(vmsd->name, "end", -EINVAL);
+            return false;
         }
     }
-    trace_vmstate_load_state_end(vmsd->name, "end", ret);
-    return ret;
+
+    trace_vmstate_load_state_end(vmsd->name, "end", 0);
+    return true;
 }
 
 static int vmfield_name_num(const VMStateField *start,
@@ -420,34 +424,29 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
 }
 
 
-int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
-                       void *opaque, JSONWriter *vmdesc_id, Error **errp)
-{
-    return vmstate_save_state_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id, errp);
-}
-
-int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
-                         void *opaque, JSONWriter *vmdesc, int version_id, Error **errp)
+static bool vmstate_save_vmsd_v(QEMUFile *f, const VMStateDescription *vmsd,
+                                 void *opaque, JSONWriter *vmdesc,
+                                 int version_id, Error **errp)
 {
     ERRP_GUARD();
-    int ret = 0;
+    bool ok;
     const VMStateField *field = vmsd->fields;
 
     trace_vmstate_save_state_top(vmsd->name);
 
     if (vmsd->pre_save_errp) {
-        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
-        trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
-        if (ret < 0) {
+        ok = vmsd->pre_save_errp(opaque, errp);
+        trace_vmstate_save_state_pre_save_res(vmsd->name, ok);
+        if (!ok) {
             error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
-            return ret;
+            return false;
         }
     } else if (vmsd->pre_save) {
-        ret = vmsd->pre_save(opaque);
+        int ret = vmsd->pre_save(opaque);
         trace_vmstate_save_state_pre_save_res(vmsd->name, ret);
         if (ret) {
             error_setg(errp, "pre-save failed: %s", vmsd->name);
-            return ret;
+            return false;
         }
     }
 
@@ -528,16 +527,16 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                       i, max_elems);
 
                 if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop, errp);
+                    ok = vmstate_save_vmsd(f, inner_field->vmsd,
+                                           curr_elem, vmdesc_loop, errp);
                 } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_save_state_v(f, inner_field->vmsd,
-                                               curr_elem, vmdesc_loop,
-                                               inner_field->struct_version_id,
-                                               errp);
-                } else if (!inner_field->info->save(
-                    f, curr_elem, size, inner_field, vmdesc_loop, errp)) {
-                    ret = -EINVAL;
+                    ok = vmstate_save_vmsd_v(f, inner_field->vmsd,
+                                             curr_elem, vmdesc_loop,
+                                             inner_field->struct_version_id,
+                                             errp);
+                } else {
+                    ok = inner_field->info->save(
+                        f, curr_elem, size, inner_field, vmdesc_loop, errp);
                 }
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
@@ -549,18 +548,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-                if (ret) {
-                    if (*errp) {
-                        error_prepend(errp, "Save of field %s/%s failed: ",
-                                      vmsd->name, field->name);
-                    } else {
-                        error_setg(errp, "Save of field %s/%s failed",
-                                   vmsd->name, field->name);
-                    }
+                if (!ok) {
+                    error_prepend(errp, "Save of field %s/%s failed: ",
+                                  vmsd->name, field->name);
                     if (vmsd->post_save) {
                         vmsd->post_save(opaque);
                     }
-                    return ret;
+                    return false;
                 }
 
                 /* Compressed arrays only care about the first element */
@@ -583,18 +577,27 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp) ? 0 : -EINVAL;
+    ok = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
     if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
-        if (!ret && ps_ret) {
-            ret = ps_ret;
+        if (ok && ps_ret) {
+            ok = false;
             error_setg(errp, "post-save failed: %s", vmsd->name);
         }
     }
-    return ret;
+
+    return ok;
 }
 
+bool vmstate_save_vmsd(QEMUFile *f, const VMStateDescription *vmsd,
+                        void *opaque, JSONWriter *vmdesc_id, Error **errp)
+{
+    return vmstate_save_vmsd_v(f, vmsd, opaque, vmdesc_id, vmsd->version_id,
+                               errp);
+}
+
+
 static const VMStateDescription *
 vmstate_get_subsection(const VMStateDescription * const *sub,
                        const char *idstr)
@@ -637,7 +640,7 @@ static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
-            return 0;
+            return true;
         }
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
-- 
2.48.1


