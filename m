Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91C1D5E368
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2024 12:32:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9kM6-00085B-Rs; Sat, 09 Nov 2024 07:14:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kM4-0007yh-1u; Sat, 09 Nov 2024 07:14:16 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1t9kM2-0004iJ-1M; Sat, 09 Nov 2024 07:14:15 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3D154A161F;
 Sat,  9 Nov 2024 15:07:10 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id EB6B9167FAD;
 Sat,  9 Nov 2024 15:08:04 +0300 (MSK)
Received: (nullmailer pid 3295423 invoked by uid 1000);
 Sat, 09 Nov 2024 12:08:01 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.0.4 55/57] migration: Ensure vmstate_save() sets errp
Date: Sat,  9 Nov 2024 15:07:57 +0300
Message-Id: <20241109120801.3295120-55-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
References: <qemu-stable-9.0.4-20241109150303@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Hanna Czenczek <hreitz@redhat.com>

migration/savevm.c contains some calls to vmstate_save() that are
followed by migrate_set_error() if the integer return value indicates an
error.  migrate_set_error() requires that the `Error *` object passed to
it is set.  Therefore, vmstate_save() is assumed to always set *errp on
error.

Right now, that assumption is not met: vmstate_save_state_v() (called
internally by vmstate_save()) will not set *errp if
vmstate_subsection_save() or vmsd->post_save() fail.  Fix that by adding
an *errp parameter to vmstate_subsection_save(), and by generating a
generic error in case post_save() fails (as is already done for
pre_save()).

Without this patch, qemu will crash after vmstate_subsection_save() or
post_save() have failed inside of a vmstate_save() call (unless
migrate_set_error() then happen to discard the new error because
s->error is already set).  This happens e.g. when receiving the state
from a virtio-fs back-end (virtiofsd) fails.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
Link: https://lore.kernel.org/r/20241015170437.310358-1-hreitz@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
(cherry picked from commit 37dfcba1a04989830c706f9cbc00450e5d3a7447)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/migration/vmstate.c b/migration/vmstate.c
index ef26f26ccd..d19b42630a 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -22,7 +22,8 @@
 #include "trace.h"
 
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc);
+                                   void *opaque, JSONWriter *vmdesc,
+                                   Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque);
 
@@ -440,12 +441,13 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
         json_writer_end_array(vmdesc);
     }
 
-    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc);
+    ret = vmstate_subsection_save(f, vmsd, opaque, vmdesc, errp);
 
     if (vmsd->post_save) {
         int ps_ret = vmsd->post_save(opaque);
-        if (!ret) {
+        if (!ret && ps_ret) {
             ret = ps_ret;
+            error_setg(errp, "post-save failed: %s", vmsd->name);
         }
     }
     return ret;
@@ -517,7 +519,8 @@ static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
 }
 
 static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
-                                   void *opaque, JSONWriter *vmdesc)
+                                   void *opaque, JSONWriter *vmdesc,
+                                   Error **errp)
 {
     const VMStateDescription * const *sub = vmsd->subsections;
     bool vmdesc_has_subsections = false;
@@ -545,7 +548,7 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
             qemu_put_byte(f, len);
             qemu_put_buffer(f, (uint8_t *)vmsdsub->name, len);
             qemu_put_be32(f, vmsdsub->version_id);
-            ret = vmstate_save_state(f, vmsdsub, opaque, vmdesc);
+            ret = vmstate_save_state_with_err(f, vmsdsub, opaque, vmdesc, errp);
             if (ret) {
                 return ret;
             }
-- 
2.39.5


