Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD2BFC5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXds-0000BL-AN; Fri, 20 Feb 2026 16:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdq-00009c-8n
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:26 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdl-0002lJ-Rx
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:25 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 9EFDBC0238;
 Sat, 21 Feb 2026 00:02:20 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-qUMyV1Sn; Sat, 21 Feb 2026 00:02:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621340;
 bh=uiP1/GlQ2tZdBK6A1JL84rxpYftNF6OJQHGbz3rsxVE=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=1O5useoRXM4gIGRqdoK7rbIGx9vx09++T1vmLGr3KHCctEtSDyCpxOTxC7E8aeCVy
 YyuB+qBu5QlGqWXMAX/tgArMKsK+xIVt2jfut//MYtzRWxXoZCHCMH7rIq0Mu/104x
 YJk5130v4Wv3yAWEFn/H332VgcgN/xcfaClicjIQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 07/16] migration: factor out vmstate_save_field() from
 vmstate_save_state()
Date: Sat, 21 Feb 2026 00:02:05 +0300
Message-ID: <20260220210214.800050-8-vsementsov@yandex-team.ru>
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

Simplify vmstate_save_state() which is rather big, and simplify further
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 810b131f18..d8c30830d6 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -26,6 +26,9 @@ static int vmstate_subsection_save(QEMUFile *f, const VMStateDescription *vmsd,
                                    Error **errp);
 static int vmstate_subsection_load(QEMUFile *f, const VMStateDescription *vmsd,
                                    void *opaque, Error **errp);
+static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
+                                void *opaque, JSONWriter *vmdesc,
+                                int version_id, Error **errp);
 
 /* Whether this field should exist for either save or load the VM? */
 static bool
@@ -450,6 +453,26 @@ static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
     return true;
 }
 
+static bool vmstate_save_field(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field,
+                               JSONWriter *vmdesc, Error **errp)
+{
+    if (field->flags & VMS_STRUCT) {
+        return vmstate_save_state(f, field->vmsd, pv, vmdesc, errp) >= 0;
+    } else if (field->flags & VMS_VSTRUCT) {
+        return vmstate_save_state_v(f, field->vmsd, pv, vmdesc,
+                                    field->struct_version_id,
+                                    errp) >= 0;
+    }
+
+    if (field->info->put(f, pv, size, field, vmdesc) < 0) {
+        error_setg(errp, "put failed");
+        return false;
+    }
+
+    return true;
+}
+
 static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -542,21 +565,8 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
                                       i, max_elems);
 
-                if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_save_state(f, inner_field->vmsd,
-                                             curr_elem, vmdesc_loop, errp);
-                } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_save_state_v(f, inner_field->vmsd,
-                                               curr_elem, vmdesc_loop,
-                                               inner_field->struct_version_id,
-                                               errp);
-                } else {
-                    ret = inner_field->info->put(f, curr_elem, size,
-                                                 inner_field, vmdesc_loop);
-                    if (ret < 0) {
-                        error_setg(errp, "put failed");
-                    }
-                }
+                ret = vmstate_save_field(f, curr_elem, size, inner_field,
+                                         vmdesc_loop, errp) ? 0 : -EINVAL;
 
                 written_bytes = qemu_file_transferred(f) - old_offset;
                 vmsd_desc_field_end(vmsd, vmdesc_loop, inner_field,
-- 
2.52.0


