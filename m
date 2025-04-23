Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5770C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:40:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7UfN-0003JO-Fu; Wed, 23 Apr 2025 03:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uez-00039C-Gq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uex-0003Dq-CG
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393800;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ubksxwnn3dIlQGpMZRKeufkjtSTvTnQ8+cVCN30GioI=;
 b=KWtlGEjOybUpjr9ZycAp5sFG99+vym6mm+XCybs5JASBPWDiPN5WnyIr5MX0I+ITbYHEJV
 mNZ7/KJ9uIWIfgZ6sbMEg6iFRM43dYdInJOb5EPQbTA2BIF2lE0qgjhapq5g1l2a3u6jTt
 n+Y0u5mCmczX+3DpdkF7EEWthgEaWjo=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-9ssyua85NtyWGIIb4xbZzA-1; Wed,
 23 Apr 2025 03:36:34 -0400
X-MC-Unique: 9ssyua85NtyWGIIb4xbZzA-1
X-Mimecast-MFC-AGG-ID: 9ssyua85NtyWGIIb4xbZzA_1745393793
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85C941956048; Wed, 23 Apr 2025 07:36:33 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EC4F71955BCB; Wed, 23 Apr 2025 07:36:31 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/29] qapi/machine: Make @dump-skeys command generic
Date: Wed, 23 Apr 2025 09:35:48 +0200
Message-ID: <20250423073610.271585-9-thuth@redhat.com>
In-Reply-To: <20250423073610.271585-1-thuth@redhat.com>
References: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Reduce misc-target.json by one target specific command.

Error message is returned for machines not implementing
TYPE_DUMP_SKEYS_INTERFACE:

  $ qemu-system-aarch64 -M virt -S -qmp stdio
  {"QMP": {"version": {"qemu": {"micro": 50, "major": 9}}, "capabilities": ["oob"]}}
  { "execute": "qmp_capabilities" }
  {"return": {}}
  { "execute": "dump-skeys", "arguments": { "filename": "/tmp/foo" }  }
  {"error": {"class": "GenericError", "desc": "Storage keys information not available for this architecture"}}

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250310151414.11550-5-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 qapi/machine.json          | 18 ++++++++++++++++++
 qapi/misc-target.json      | 19 -------------------
 hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
 hw/s390x/s390-skeys.c      |  6 +-----
 4 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index a6b8795b09e..a9ff8076317 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1898,3 +1898,21 @@
 { 'command': 'x-query-interrupt-controllers',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ]}
+
+##
+# @dump-skeys:
+#
+# Dump the storage keys for an s390x guest
+#
+# @filename: the path to the file to dump to
+#
+# Since: 2.5
+#
+# .. qmp-example::
+#
+#     -> { "execute": "dump-skeys",
+#          "arguments": { "filename": "/tmp/skeys" } }
+#     <- { "return": {} }
+##
+{ 'command': 'dump-skeys',
+  'data': { 'filename': 'str' } }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index 8d70bd24d8c..42e4a7417dc 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -274,25 +274,6 @@
   'returns': 'SevAttestationReport',
   'if': 'TARGET_I386' }
 
-##
-# @dump-skeys:
-#
-# Dump guest's storage keys
-#
-# @filename: the path to the file to dump to
-#
-# Since: 2.5
-#
-# .. qmp-example::
-#
-#     -> { "execute": "dump-skeys",
-#          "arguments": { "filename": "/tmp/skeys" } }
-#     <- { "return": {} }
-##
-{ 'command': 'dump-skeys',
-  'data': { 'filename': 'str' },
-  'if': 'TARGET_S390X' }
-
 ##
 # @GICCapability:
 #
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3130c5cd456..fd8b4e0b44c 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -25,6 +25,7 @@
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "hw/s390x/storage-keys.h"
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
@@ -406,3 +407,16 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     info->guid = qemu_uuid_unparse_strdup(&vms->guid);
     return info;
 }
+
+void qmp_dump_skeys(const char *filename, Error **errp)
+{
+    ObjectClass *mc = object_get_class(qdev_get_machine());
+    ObjectClass *oc = object_class_dynamic_cast(mc, TYPE_DUMP_SKEYS_INTERFACE);
+
+    if (!oc) {
+        error_setg(errp, "Storage keys information not available"
+                         " for this architecture");
+        return;
+    }
+    DUMP_SKEYS_INTERFACE_CLASS(oc)->qmp_dump_skeys(filename, errp);
+}
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index fd1123b0f35..067ea037268 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -15,6 +15,7 @@
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc-target.h"
 #include "qobject/qdict.h"
 #include "qemu/error-report.h"
@@ -219,11 +220,6 @@ out:
     fclose(f);
 }
 
-void qmp_dump_skeys(const char *filename, Error **errp)
-{
-    s390_qmp_dump_skeys(filename, errp);
-}
-
 static bool qemu_s390_skeys_are_enabled(S390SKeysState *ss)
 {
     QEMUS390SKeysState *skeys = QEMU_S390_SKEYS(ss);
-- 
2.49.0


