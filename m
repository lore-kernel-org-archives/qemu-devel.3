Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89C7EFCE4B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxth2-0004oK-AS; Wed, 04 Mar 2026 16:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgd-0004kF-UE
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgZ-0003SA-O3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:19 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 27BBF80884;
 Thu, 05 Mar 2026 00:23:13 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-y3zHomAZ; Thu, 05 Mar 2026 00:23:12 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659392;
 bh=A+WiueIXETLIeMIRZIQgBqkxh+hFRPAHRreOOCK2W/c=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=Ox5aAvEOjhjk6cutgQvi9cq/0CpY38upe73SK5zvh9gLsyfSGshdFQl+Hft2SSsxk
 IhPnvOGBeNS1e4xqI0nRRbAW4WK9dqZvVBgVhOmvqpo8Me82/dmcBOlnY+ihLKCh2s
 Yfvbe703bTVVSpHX7LVGqpolDWMeAgqEawGrCyDc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 10/18] migration: factor out vmstate_post_load() from
 vmstate_load_state()
Date: Thu,  5 Mar 2026 00:22:54 +0300
Message-ID: <20260304212303.667141-11-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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
 migration/vmstate.c | 49 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 32944c04443..53b57c09d82 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -182,6 +182,33 @@ static bool vmstate_load_field(QEMUFile *f, void *pv, size_t size,
     return true;
 }
 
+static bool vmstate_post_load(const VMStateDescription *vmsd,
+                              void *opaque, int version_id, Error **errp)
+{
+    ERRP_GUARD();
+
+    if (vmsd->post_load_errp) {
+        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
+            error_prepend(errp, "post load hook failed for: %s, version_id: "
+                          "%d, minimum_version: %d: ", vmsd->name,
+                          vmsd->version_id, vmsd->minimum_version_id);
+            return false;
+        }
+    } else if (vmsd->post_load) {
+        int ret = vmsd->post_load(opaque, version_id);
+        if (ret < 0) {
+            error_setg(errp,
+                       "post load hook failed for: %s, version_id: %d, "
+                       "minimum_version: %d, ret: %d",
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
@@ -284,25 +311,9 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return ret;
     }
 
-    if (vmsd->post_load_errp) {
-        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
-            error_prepend(errp, "post load hook failed for: %s, version_id: "
-                          "%d, minimum_version: %d: ", vmsd->name,
-                          vmsd->version_id, vmsd->minimum_version_id);
-            trace_vmstate_load_state_fail(vmsd->name, "post-load");
-            return -EINVAL;
-        }
-    } else if (vmsd->post_load) {
-        ret = vmsd->post_load(opaque, version_id);
-        if (ret < 0) {
-            error_setg(errp,
-                       "post load hook failed for: %s, version_id: %d, "
-                       "minimum_version: %d, ret: %d",
-                       vmsd->name, vmsd->version_id, vmsd->minimum_version_id,
-                       ret);
-            trace_vmstate_load_state_fail(vmsd->name, "post-load");
-            return ret;
-        }
+    if (!vmstate_post_load(vmsd, opaque, version_id, errp)) {
+        trace_vmstate_load_state_fail(vmsd->name, "post-load");
+        return -EINVAL;
     }
 
     trace_vmstate_load_state_success(vmsd->name);
-- 
2.52.0


