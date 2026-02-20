Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C241C5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXe2-0000Fo-UV; Fri, 20 Feb 2026 16:02:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXe2-0000Ff-7A
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:38 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXe0-0002m2-0V
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:37 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 7A10CC023D;
 Sat, 21 Feb 2026 00:02:23 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-6EedVZ4q; Sat, 21 Feb 2026 00:02:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621343;
 bh=LICYfeHbVPa/c94Szq3uuavaaW736ZJqwHn8so8sW20=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=0n8DJEthdTBwukkZMY0ntmb1dV+npXvTe7BxVaFLQS3i3Vk09/aapKSp644kx5QmH
 tTrn4Mn8oOpj+pCubF2ZAFyxFfrQt5/l56tDxMIpNGw7g/z+TD6GAGpQ97IIh64OpC
 P8xdnBWkTxGNymqKeOedF2SZc+dVgjtPwjiAzmik=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 13/16] migration: introduce vmstate_load_vmsd() and
 vmstate_save_vmsd()
Date: Sat, 21 Feb 2026 00:02:11 +0300
Message-ID: <20260220210214.800050-14-vsementsov@yandex-team.ru>
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
---
 include/migration/vmstate.h |  9 ++++
 migration/vmstate.c         | 89 ++++++++++++++++++++-----------------
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 167b1aa9cf..a76f259180 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1249,10 +1249,19 @@ extern const VMStateInfo vmstate_info_qlist;
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
index efef4d0433..84ad8b08d3 100644
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
+                                  errp);
     } else if (field->flags & VMS_VSTRUCT) {
-        return vmstate_load_state(f, field->vmsd, pv, field->struct_version_id,
-                                  errp) >= 0;
+        return vmstate_load_vmsd(f, field->vmsd, pv, field->struct_version_id,
+                                  errp);
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
 
@@ -224,18 +223,18 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         error_setg(errp, "%s: incoming version_id %d is too new "
                    "for local version_id %d",
                    vmsd->name, version_id, vmsd->version_id);
-        return -EINVAL;
+        return false;
     }
 
     if  (version_id < vmsd->minimum_version_id) {
         error_setg(errp, "%s: incoming version_id %d is too old "
                    "for local minimum version_id %d",
                    vmsd->name, version_id, vmsd->minimum_version_id);
-        return -EINVAL;
+        return false;
     }
 
     if (!vmstate_pre_load(vmsd, opaque, errp)) {
-        return -EINVAL;
+        return false;
     }
 
     while (field->name) {
@@ -255,6 +254,7 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
             }
 
             for (i = 0; i < n_elems; i++) {
+                bool ok;
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
 
@@ -273,32 +273,30 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
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
+                        return false;
                     }
-                }
-
-                if (ret < 0) {
-                    qemu_file_set_error(f, ret);
-                    return ret;
+                } else {
+                    qemu_file_set_error(f, -EINVAL);
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
@@ -306,16 +304,16 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
 
     if (!vmstate_subsection_load(f, vmsd, opaque, errp)) {
         qemu_file_set_error(f, -EINVAL);
-        return -EINVAL;
+        return false;
     }
 
     if (!vmstate_post_load(vmsd, opaque, version_id, errp)) {
-        return -EINVAL;
+        return false;
     }
 
     trace_vmstate_load_state_end(vmsd->name);
 
-    return 0;
+    return true;
 }
 
 static int vmfield_name_num(const VMStateField *start,
@@ -488,11 +486,10 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
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
@@ -505,18 +502,18 @@ static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
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
-        return -EINVAL;
+        return false;
     }
 
     trace_vmstate_save_state_pre_save_done(vmsd->name);
@@ -597,8 +594,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
                                       i, max_elems);
 
-                ret = vmstate_save_field(f, curr_elem, size, inner_field,
-                                         vmdesc_loop, errp) ? 0 : -EINVAL;
+                ok = vmstate_save_field(f, curr_elem, size, inner_field,
+                                        vmdesc_loop, errp);
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
@@ -609,7 +606,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                     g_clear_pointer((gpointer *)&inner_field, g_free);
                 }
 
-                if (ret) {
+                if (!ok) {
                     error_prepend(errp, "Save of field %s/%s failed: ",
                                   vmsd->name, field->name);
                     goto out;
@@ -635,13 +632,13 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -658,11 +655,11 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
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
@@ -707,7 +704,7 @@ static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        if (vmstate_load_state(f, sub_vmsd, opaque, version_id, errp) < 0) {
+        if (!vmstate_load_vmsd(f, sub_vmsd, opaque, version_id, errp)) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
             error_prepend(errp,
                           "Loading VM subsection '%s' in '%s' failed: ",
@@ -749,7 +746,7 @@ static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            if (vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp) < 0) {
+            if (!vmstate_save_vmsd(f, vmsdsub, opaque, vmdesc, errp)) {
                 return false;
             }
 
@@ -766,3 +763,15 @@ static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
 
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
2.52.0


