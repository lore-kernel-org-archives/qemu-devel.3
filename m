Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7C0C5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXdt-0000Bj-DV; Fri, 20 Feb 2026 16:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdq-0000AR-Ts
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:27 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdm-0002lT-P9
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 813CCC020D;
 Sat, 21 Feb 2026 00:02:21 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-lsUO4RYN; Sat, 21 Feb 2026 00:02:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621341;
 bh=YibYNvIXW00FMdxV9fXYsNCfNmF3K6wndL8gMvi9oWs=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=ZmTRyWZ/AHqtOVt8h0GLeL2ItcDl0687SROmG/jLKsWt5ILHp2WqCiQnYz5U2vbeC
 1+1TEMcyL7aZwBH4ma3bqdGB6eHOWWQnjDEdAawb7a5HXDsfylf0BVtlPBmq7kBsyq
 rMMn/siT5T8hMvCKtF+9bpEO0JWoMSWkG6pwOFew=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 09/16] migration: factor out vmstate_load_field() from
 vmstate_load_state()
Date: Sat, 21 Feb 2026 00:02:07 +0300
Message-ID: <20260220210214.800050-10-vsementsov@yandex-team.ru>
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

Simplify vmstate_load_state() which is rather big, and simplify further
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 migration/vmstate.c | 41 +++++++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 68d5c37992..7d776ce27a 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -161,6 +161,27 @@ static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
     return true;
 }
 
+static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
+                               const VMStateField *field, Error **errp)
+{
+    if (field->flags & VMS_STRUCT) {
+        return vmstate_load_state(f, field->vmsd, pv, field->vmsd->version_id,
+                                  errp) >= 0;
+    } else if (field->flags & VMS_VSTRUCT) {
+        return vmstate_load_state(f, field->vmsd, pv, field->struct_version_id,
+                                  errp) >= 0;
+    }
+
+    if (field->info->get(f, pv, size, field) < 0) {
+        error_setg(errp,
+                   "Failed to load element of type %s for %s",
+                   field->info->name, field->name);
+        return false;
+    }
+
+    return true;
+}
+
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
@@ -223,24 +244,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                     inner_field = field;
                 }
 
-                if (inner_field->flags & VMS_STRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->vmsd->version_id,
-                                             errp);
-                } else if (inner_field->flags & VMS_VSTRUCT) {
-                    ret = vmstate_load_state(f, inner_field->vmsd, curr_elem,
-                                             inner_field->struct_version_id,
-                                             errp);
-                } else {
-                    ret = inner_field->info->get(f, curr_elem, size,
-                                                 inner_field);
-                    if (ret < 0) {
-                        error_setg(errp,
-                                   "Failed to load element of type %s for %s: "
-                                   "%d", inner_field->info->name,
-                                   inner_field->name, ret);
-                    }
-                }
+                ret = vmstate_load_field(f, curr_elem, size, inner_field,
+                                         errp) ? 0 : -EINVAL;
 
                 /* If we used a fake temp field.. free it now */
                 if (inner_field != field) {
-- 
2.52.0


