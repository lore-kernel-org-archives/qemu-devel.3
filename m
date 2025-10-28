Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B518CCF9F3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 23:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDsto-00036c-8R; Tue, 28 Oct 2025 19:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstn-00036M-2c
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:43 -0400
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDstQ-00018p-RC
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 19:14:42 -0400
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id EF36A8177F;
 Wed, 29 Oct 2025 02:14:06 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:582::1:19])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id oDnXpg2bCW20-3Q8HwkNU; Wed, 29 Oct 2025 02:14:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761693246;
 bh=d77pOpn706V6UlmPku+gqYZpRBb+6mVRH/UFFJ6GHEo=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=H7mHalUnFQ5rqhAPY19nEp4eSsBXLXFMCfnxTku1sR4bcggzP8orPjS8qHHr6k7Ll
 JjNpZQnvT3arl8T5siklHC0ds0Xm3Jc2+OoVtDojZb9MayJjQlI8+d8Y6ZUlpozCf9
 M09qz3ZW8oloUDYbsK0H5xe9qmSTVmbA8+T0RjYU=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: armbru@redhat.com,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [RFC 21/22] migration: convert vmstate_subsection_save/load functions
 to bool
Date: Wed, 29 Oct 2025 02:13:45 +0300
Message-ID: <20251028231347.194844-22-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251028231347.194844-1-vsementsov@yandex-team.ru>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Convert them to bool return value, as preparation to further
convertion of vmstate_save/load_state().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 55 +++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 30 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 6f1e878f36..2298f190de 100644
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
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -249,10 +249,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         field++;
     }
     assert(field->flags == VMS_END);
-    ret = vmstate_subsection_load(f, vmsd, opaque, errp);
-    if (ret != 0) {
-        qemu_file_set_error(f, ret);
-        return ret;
+    if (!vmstate_subsection_load(f, vmsd, opaque, errp)) {
+        qemu_file_set_error(f, -EINVAL);
+        return false;
     }
     if (vmsd->post_load_errp) {
         if (!vmsd->post_load_errp(opaque, version_id, errp)) {
@@ -584,7 +583,7 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp) ? 0 : -EINVAL;
 
     if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
@@ -610,15 +609,14 @@ vmstate_get_subsection(const VMStateDescription * const *sub,
     return NULL;
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
 
@@ -626,12 +624,12 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
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
@@ -646,34 +644,32 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
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
+        if (!vmstate_load_vmsd(f, sub_vmsd, opaque, version_id, errp)) {
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
@@ -697,9 +693,8 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc, errp);
-            if (ret) {
-                return ret;
+            if (!vmstate_save_vmsd(f, vmsdsub, opaque, vmdesc, errp)) {
+                return false;
             }
 
             if (vmdesc) {
@@ -713,5 +708,5 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    return ret;
+    return true;
 }
-- 
2.48.1


