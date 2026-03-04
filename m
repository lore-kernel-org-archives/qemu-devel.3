Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A01EFCE47
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:24:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxth8-0004r2-G8; Wed, 04 Mar 2026 16:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtge-0004kG-2Z
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgZ-0003SM-Pd
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BE04F8086C;
 Thu, 05 Mar 2026 00:23:13 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-6J8keWck; Thu, 05 Mar 2026 00:23:13 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659393;
 bh=3PPnchP95MpmjTTGrn5npE4Kd5zzNjZiQiulnkPPyA4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=mL3qInKPrSTSNw9f40SBaEgnEU2thMyjNbNZqHpqfQFC3WkMeIHGSQPBmv2T79hiX
 3VlUp9WScuhCBQZSHVUSw0ArY617wcARnIEB3FDcNo/jp+JrJE4Q6Nq0CPk+jgJ/29
 sqGOn5XPApYcRGJd8v7KqIYnZ+C9rfhCI5e83eaA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 11/18] migration: convert vmstate_subsection_save/load
 functions to bool
Date: Thu,  5 Mar 2026 00:22:55 +0300
Message-ID: <20260304212303.667141-12-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Convert them to bool return value, as preparation to further
convertion of vmstate_save/load_state().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 57 +++++++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 31 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 53b57c09d82..8825aa3b1f1 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -21,11 +21,11 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 
-static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc,
-                                   Error **errp);
-static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, Error **errp);
+static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, JSONWriter *vmdesc,
+                                    Error **errp);
+static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, Error **errp);
 static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp);
@@ -305,10 +305,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
     }
     assert(field->flags == VMS_END);
 
-    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
-    if (ret != 0) {
-        qemu_file_set_error(f, ret);
-        return ret;
+    if (!vmstate_subsection_load(f, vmsd, opaque, errp)) {
+        qemu_file_set_error(f, -EINVAL);
+        return -EINVAL;
     }
 
     if (!vmstate_post_load(vmsd, opaque, version_id, errp)) {
@@ -637,7 +636,7 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp) ? 0 : -EINVAL;
 
 out:
     if (vmsd->post_save) {
@@ -667,15 +666,14 @@ int vmstate_save_state(QEMUFile *f, const VMStateDescription *vmsd,
                                 errp);
 }
 
-static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, Error **errp)
+static bool vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, Error **errp)
 {
     ERRP_GUARD();
     trace_vmstate_subsection_load(vmsd->name);
 
     while (qemu_peek_byte(f, 0) == QEMU_VM_SUBSECTION) {
         char idstr[256], *idstr_ret;
-        int ret;
         uint8_t version_id, len, size;
         const VMStateDescription *sub_vmsd;
 
@@ -683,12 +681,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         if (len < strlen(vmsd->name) + 1) {
             /* subsection name has to be "section_name/a" */
             trace_vmstate_subsection_load_bad(vmsd->name, "(short)", "");
-            return 0;
+            return true;
         }
         size = qemu_peek_buffer(f, (uint8_t **)&idstr_ret, len, 2);
         if (size != len) {
             trace_vmstate_subsection_load_bad(vmsd->name, "(peek fail)", "");
-            return 0;
+            return true;
         }
         memcpy(idstr, idstr_ret, size);
         idstr[size] = 0;
@@ -696,41 +694,39 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
         if (strncmp(vmsd->name, idstr, strlen(vmsd->name)) != 0) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(prefix)");
             /* it doesn't have a valid subsection name */
-            return 0;
+            return true;
         }
         sub_vmsd = vmstate_get_subsection(vmsd->subsections, idstr);
         if (sub_vmsd == NULL) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(lookup)");
             error_setg(errp, "VM subsection '%s' in '%s' does not exist",
                        idstr, vmsd->name);
-            return -ENOENT;
+            return false;
         }
         qemu_file_skip(f, 1); /* subsection */
         qemu_file_skip(f, 1); /* len */
         qemu_file_skip(f, len); /* idstr */
         version_id = qemu_get_be32(f);
 
-        ret = vmstate_load_state(f, sub_vmsd, opaque, version_id, errp);
-        if (ret) {
+        if (vmstate_load_state(f, sub_vmsd, opaque, version_id, errp) < 0) {
             trace_vmstate_subsection_load_bad(vmsd->name, idstr, "(child)");
             error_prepend(errp,
-                          "Loading VM subsection '%s' in '%s' failed: %d: ",
-                          idstr, vmsd->name, ret);
-            return ret;
+                          "Loading VM subsection '%s' in '%s' failed: ",
+                          idstr, vmsd->name);
+            return false;
         }
     }
 
     trace_vmstate_subsection_load_good(vmsd->name);
-    return 0;
+    return true;
 }
 
-static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc,
-                                   Error **errp)
+static bool vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
+                                    void *opaque, JSONWriter *vmdesc,
+                                    Error **errp)
 {
     const VMStateDescription * const *sub = vmsd->subsections;
     bool vmdesc_has_subsections = false;
-    int ret = 0;
 
     trace_vmstate_subsection_save_top(vmsd->name);
     while (sub && *sub) {
@@ -754,9 +750,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
-            if (ret) {
-                return ret;
+            if (vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp) < 0) {
+                return false;
             }
 
             if (vmdesc) {
@@ -770,5 +765,5 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    return ret;
+    return true;
 }
-- 
2.52.0


