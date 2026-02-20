Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2D3C5B56A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 21:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtXds-0000BM-TO; Fri, 20 Feb 2026 16:02:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdr-0000AT-46
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:27 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vtXdn-0002lY-5s
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 16:02:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:3530:0:640:eca4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id E8D3CC023A;
 Sat, 21 Feb 2026 00:02:21 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:87::1:2c])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id G2kijG5A6qM0-COjASV0Y; Sat, 21 Feb 2026 00:02:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1771621341;
 bh=xLS0Fx5QPecQizLL9RmU1SXSaaiUs4EihpSOtFmju6w=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=w6XUvGwJ0aw0TCY2CDF4nGkfBF9SN75ZAKINBaru6hA/Antofm/y91SIZm5hVTjL6
 KqK96/TFyLpEvmc6B4QpeuQEjtXI5ZK/30R79V8HyDvX09PUg9fJuHkCtQa6c9pL0J
 r9/liFMrNz5pw3UZm+92aa0qelbPZbBQq942c3tc=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de, vsementsov@yandex-team.ru,
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH v2 10/16] migration: factor out vmstate_post_load() from
 vmstate_load_state()
Date: Sat, 21 Feb 2026 00:02:08 +0300
Message-ID: <20260220210214.800050-11-vsementsov@yandex-team.ru>
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
 migration/vmstate.c | 46 ++++++++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 17 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 7d776ce27a..8b31aa1c9f 100644
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
@@ -281,23 +308,8 @@ int vmstate_load_state(QEMUFile *f, const VMStateDescription *vmsd,
         return ret;
     }
 
-    if (vmsd->post_load_errp) {
-        if (!vmsd->post_load_errp(opaque, version_id, errp)) {
-            error_prepend(errp, "post load hook failed for: %s, version_id: "
-                          "%d, minimum_version: %d: ", vmsd->name,
-                          vmsd->version_id, vmsd->minimum_version_id);
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
-            return ret;
-        }
+    if (!vmstate_post_load(vmsd, opaque, version_id, errp)) {
+        return -EINVAL;
     }
 
     trace_vmstate_load_state_end(vmsd->name);
-- 
2.52.0


