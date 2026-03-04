Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247B6EFCE4B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 21:24:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxtgw-0004nZ-Iq; Wed, 04 Mar 2026 16:23:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgb-0004jz-GW
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:20 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vxtgW-0003Rg-71
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 16:23:16 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:bf1f:0:640:c739:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id E939A80853;
 Thu, 05 Mar 2026 00:23:10 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:921::1:1b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5NwBA90AmW20-nvUkxXb3; Thu, 05 Mar 2026 00:23:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772659390;
 bh=ieXGioyIM0zmkWgYfFJb49W9g2VLCOkGdaL37EE0fKA=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=TEOomZA26Wh0qWFhGRNLqBKQ7MMbQc+YYq3gZ2A0GAkkAGOQeWN/9J4V4X/iIpIK1
 wRxOy5i89qoK9l4BxKuSk9paxvWRxW6e68DsnS23L8kl2pHPwaQrYvEBnxLQjlbuVl
 sajee6ya67DVWT8g2yK+LKHLysFZzRCpksXdMTvs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: peterx@redhat.com
Cc: farosas@suse.de,
	vsementsov@yandex-team.ru,
	qemu-devel@nongnu.org
Subject: [PATCH v3 06/18] migration: factor out vmstate_pre_save() from
 vmstate_save_state()
Date: Thu,  5 Mar 2026 00:22:50 +0300
Message-ID: <20260304212303.667141-7-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260304212303.667141-1-vsementsov@yandex-team.ru>
References: <20260304212303.667141-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: 0
X-Spam_score: -0.0
X-Spam_bar: /
X-Spam_report: (-0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 migration/vmstate.c | 37 +++++++++++++++++++++++--------------
 1 file changed, 23 insertions(+), 14 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 87e1f049592..605b5c59c76 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -435,6 +435,26 @@ bool vmstate_section_needed(const VMStateDescription *vmsd, void *opaque)
     return true;
 }
 
+static bool vmstate_pre_save(const VMStateDescription *vmsd, void *opaque,
+                             Error **errp)
+{
+    ERRP_GUARD();
+
+    if (vmsd->pre_save_errp) {
+        if (!vmsd->pre_save_errp(opaque, errp)) {
+            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
+            return false;
+        }
+    } else if (vmsd->pre_save) {
+        if (vmsd->pre_save(opaque) < 0) {
+            error_setg(errp, "pre-save failed: %s", vmsd->name);
+            return false;
+        }
+    }
+
+    return true;
+}
+
 static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                                 void *opaque, JSONWriter *vmdesc,
                                 int version_id, Error **errp)
@@ -445,20 +465,9 @@ static int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
 
     trace_vmstate_save_state_top(vmsd->name);
 
-    if (vmsd->pre_save_errp) {
-        ret = vmsd->pre_save_errp(opaque, errp) ? 0 : -EINVAL;
-        if (ret < 0) {
-            error_prepend(errp, "pre-save for %s failed: ", vmsd->name);
-            trace_vmstate_save_state_pre_save_fail(vmsd->name);
-            return ret;
-        }
-    } else if (vmsd->pre_save) {
-        ret = vmsd->pre_save(opaque);
-        if (ret) {
-            error_setg(errp, "pre-save failed: %s", vmsd->name);
-            trace_vmstate_save_state_pre_save_fail(vmsd->name);
-            return ret;
-        }
+    if (!vmstate_pre_save(vmsd, opaque, errp)) {
+        trace_vmstate_save_state_pre_save_fail(vmsd->name);
+        return -EINVAL;
     }
 
     trace_vmstate_save_state_pre_save_success(vmsd->name);
-- 
2.52.0


