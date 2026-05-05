Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EFD1CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:51:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEIa-0000Is-MI; Tue, 05 May 2026 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIY-0000Hc-TU
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIX-0001Xz-CT
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981844;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N/oHrMS56nr7W5Cx+u6wW9V0/vRG1vDsmqoyIWxV7Iw=;
 b=CsmqPWcJQSfM8VB4TAyA/phXQV4kv7FZ09qlDo35Hx9XBb8A+ABxXLNAfASBgT0mJaZbPQ
 mDI5/uTAAJbD1i8ENcwTNp+wO1GXNyn2syKHhr/e3h51rnPM4qCVBVjuV4ZVvnaX3FbQ+I
 LWtJ0RfJUQXQBte3IeKDmXQf3bV00FM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-taKHpEwZNNCnSiQ5iaP1qA-1; Tue,
 05 May 2026 07:50:43 -0400
X-MC-Unique: taKHpEwZNNCnSiQ5iaP1qA-1
X-Mimecast-MFC-AGG-ID: taKHpEwZNNCnSiQ5iaP1qA_1777981842
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 57F78180034C
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 183391800348
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D2F8D21E6A08; Tue, 05 May 2026 13:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 5/5] qdev-monitor: Fix qdev ID validation regression
Date: Tue,  5 May 2026 13:50:36 +0200
Message-ID: <20260505115036.1170186-6-armbru@redhat.com>
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
References: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

User-created qdevs with ID show up at /machine/peripheral/ID.

When we restricted QemOpts IDs to letters, digits, '-', '.', '_',
starting with a letter in commit b560a9ab9be: (qemu-option: Reject
anti-social IDs) a long time ago, this also covered qdev IDs.  Looks
like this:

    (qemu) device_add usb-mouse,id=/
    qemu-system-x86_64: Parameter 'id' expects an identifier
    Identifiers consist of letters, digits, '-', '.', '_', starting with a letter.
    Try "help device_add" for more information

QMP, however:

    {"execute": "device_add", "arguments": {"driver": "usb-mouse", "id": "/"}}
    {"return": {}}

This creates a device with canonical path "/machine/peripheral//".
That way is madness.

We accidentally bypassed qdev ID validation for QMP when we cut the
detour through QemuOpts in commit b30d8054642.

Fix by validating IDs one layer down, in qdev_set_id().

Arguably, QOM should protect itself from QOM path components
containing '/', but let's just fix the regression for now.

Fixes: be93fd53723c (qdev-monitor: avoid QemuOpts in QMP device_add)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260123085924.1392134-1-armbru@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 system/qdev-monitor.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 1ac6d9a857..5c00bbf483 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -34,6 +34,7 @@
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qemu/help_option.h"
+#include "qemu/id.h"
 #include "qemu/option.h"
 #include "qemu/qemu-print.h"
 #include "qemu/option_int.h"
@@ -601,14 +602,17 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
      * has no parent
      */
     if (id) {
+        if (!id_wellformed(id)) {
+            error_setg(errp, "Invalid qdev ID '%s'", id);
+            goto err;
+        }
         prop = object_property_try_add_child(qdev_get_peripheral(), id,
                                              OBJECT(dev), NULL);
         if (prop) {
             dev->id = id;
         } else {
             error_setg(errp, "Duplicate device ID '%s'", id);
-            g_free(id);
-            return NULL;
+            goto err;
         }
     } else {
         static int anon_count;
@@ -619,6 +623,10 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
     }
 
     return prop->name;
+
+err:
+    g_free(id);
+    return NULL;
 }
 
 BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp)
-- 
2.54.0


