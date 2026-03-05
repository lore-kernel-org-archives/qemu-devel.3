Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8430F33A6D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9KX-0002Nt-CN; Thu, 05 Mar 2026 09:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KL-0002MZ-5x
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KJ-0007q5-JE
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772719517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8SkyZpAdoek+6/Kstn8OTn5RccsZembirL7cHTMoe2M=;
 b=ABdh/86G5FK481Ca/4ZKyWPug7wunwGEDMSS1mga36qVXxPjKD9gXqo9eWIBwju5RgQuUj
 OXdRJt/fkD8JOuJpdaLfx655QZ+lqDXWbBme5BaTuLh4Of0De2Pdn2u99ap8O1LYhvqZem
 PNn8hSpEPw8DYgzbsHMacWESwMoJWW4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-8il34bQyMpOPs-jIKQVmgA-1; Thu,
 05 Mar 2026 09:05:15 -0500
X-MC-Unique: 8il34bQyMpOPs-jIKQVmgA-1
X-Mimecast-MFC-AGG-ID: 8il34bQyMpOPs-jIKQVmgA_1772719514
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9DCEF180060F; Thu,  5 Mar 2026 14:05:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 253A818002A6; Thu,  5 Mar 2026 14:05:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AADB721E6885; Thu, 05 Mar 2026 15:05:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 6/6] qdev-monitor: Fix qdev ID validation regression
Date: Thu,  5 Mar 2026 15:05:08 +0100
Message-ID: <20260305140508.218316-7-armbru@redhat.com>
In-Reply-To: <20260305140508.218316-1-armbru@redhat.com>
References: <20260305140508.218316-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.53.0


