Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B0AEEFCE4B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxth7-0004p0-46; Wed, 04 Mar 2026 16:23:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgd-0004kE-Hy
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgZ-0003S8-Ou
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 08ACC80BAA;
 Thu, 05 Mar 2026 00:23:12 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-xSnsZKe7; Thu, 05 Mar 2026 00:23:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659391;
 bh=yUwaxEoj8/RJhMUIeV+z4vL/mWgiT7aABoMoIYemUT4=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=IW5IgrpJBD7q4uZW9ZJN+ntvNLXap2lbuHJBBhbFwcT/9Y6GPfgWlmI16+38Dlf+p
 JO5DRNF+bWqgti/jx2VFXVamdrcqvD9UtRUH401dreKOHRkFDORxvMF2T1zVAvSFo2
 aSn3sl4mLfc5K/8Sdsye7i5irvAG3u9cidZkfgFg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 08/18] migration: factor out vmstate_pre_load() from
 vmstate_load_state()
Date: Thu,  5 Mar 2026 00:22:52 +0300
Message-ID: <20260304212303.667141-9-vsementsov@yandex-team.ru>
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

Simplify vmstate_load_state() which is rather big, and simplify further
refactoring.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 2ce26527124..35dbe1550e9 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -134,6 +134,33 @@ static void vmstate_handle_alloc(void *ptr, const VMStateField *field,
     }
 }
 
+static bool vmstate_pre_load(const VMStateDescription *vmsd, void *opaque,
+                             Error **errp)
+{
+    ERRP_GUARD();
+
+    if (vmsd->pre_load_errp) {
+        if (!vmsd->pre_load_errp(opaque, errp)) {
+            error_prepend(errp, "pre load hook failed for: '%s', "
+                          "version_id: %d, minimum version_id: %d: ",
+                          vmsd->name, vmsd->version_id,
+                          vmsd->minimum_version_id);
+            return false;
+        }
+    } else if (vmsd->pre_load) {
+        int ret = vmsd->pre_load(opaque);
+        if (ret) {
+            error_setg(errp, "pre load hook failed for: '%s', "
+                       "version_id: %d, minimum version_id: %d, ret: %d",
+                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
+                       ret);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
                        void *opaque, int version_id, Error **errp)
 {
@@ -159,23 +186,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return -EINVAL;
     }
 
-    if (vmsd->pre_load_errp) {
-        if (!vmsd->pre_load_errp(opaque, errp)) {
-            error_prepend(errp, "pre load hook failed for: '%s', "
-                          "version_id: %d, minimum version_id: %d: ",
-                          vmsd->name, vmsd->version_id,
-                          vmsd->minimum_version_id);
-            return -EINVAL;
-        }
-    } else if (vmsd->pre_load) {
-        ret = vmsd->pre_load(opaque);
-        if (ret) {
-            error_setg(errp, "pre load hook failed for: '%s', "
-                       "version_id: %d, minimum version_id: %d, ret: %d",
-                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
-                       ret);
-            return ret;
-        }
+    if (!vmstate_pre_load(vmsd, opaque, errp)) {
+        return -EINVAL;
     }
 
     while (field->name) {
-- 
2.52.0


