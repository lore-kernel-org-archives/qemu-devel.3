Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E13C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZq-0002f9-4J; Wed, 28 May 2025 14:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-0002Ld-Cg
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZL-00071v-ES
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JcIQghWRFUMFPQLJJYZpyY5uj0N4aFb/n7V+lyIb7Ro=;
 b=eJO4UufbhnisRjpSQIA5SxQ4ESqaTMVepWMW7heP5nrl8BBn2i7JQlj/gOzIXiHo8VoHBD
 DtLiZQwi1eAoNuR8Kd5ZrSKJhuXYQ33MXVFnyte0DbWl/vtcbg66YXilIHGi+7Z+iofCHJ
 EnGvVATVbaaaaj2FrttixkUjzwxkDHQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-TrthKi4xNn6n7sgEFXNlHw-1; Wed,
 28 May 2025 14:31:59 -0400
X-MC-Unique: TrthKi4xNn6n7sgEFXNlHw-1
X-Mimecast-MFC-AGG-ID: TrthKi4xNn6n7sgEFXNlHw_1748457118
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1287A1955D88; Wed, 28 May 2025 18:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C40719560AF; Wed, 28 May 2025 18:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9FE8821E6757; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/13] qapi: make SGX commands unconditionally available
Date: Wed, 28 May 2025 20:31:43 +0200
Message-ID: <20250528183151.2839034-6-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
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

From: Daniel P. Berrangé <berrange@redhat.com>

This removes the TARGET_I386 condition from the SGX confidential
virtualization commands, moving them to the recently introduced
misc-i386.json QAPI file, given they are inherantly i386 specific
commands.

Observe a pre-existing bug that the "SGXEPCSection" struct lacked
a TARGET_I386 condition, despite its only usage being behind a
TARGET_I386 condition.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-6-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc-i386.json      | 77 +++++++++++++++++++++++++++++++++++++++
 qapi/misc-target.json    | 79 ----------------------------------------
 hw/i386/sgx-stub.c       |  2 +-
 hw/i386/sgx.c            |  2 +-
 stubs/monitor-i386-sgx.c | 17 +++++++++
 stubs/meson.build        |  1 +
 6 files changed, 97 insertions(+), 81 deletions(-)
 create mode 100644 stubs/monitor-i386-sgx.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 360adadfe0..d5d1af55a4 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -300,3 +300,80 @@
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
   'returns': 'SevAttestationReport' }
+
+##
+# @SgxEpcSection:
+#
+# Information about intel SGX EPC section
+#
+# @node: the numa node
+#
+# @size: the size of EPC section
+#
+# Since: 7.0
+##
+{ 'struct': 'SgxEpcSection',
+  'data': { 'node': 'int',
+            'size': 'uint64'}}
+
+##
+# @SgxInfo:
+#
+# Information about intel Safe Guard eXtension (SGX) support
+#
+# @sgx: true if SGX is supported
+#
+# @sgx1: true if SGX1 is supported
+#
+# @sgx2: true if SGX2 is supported
+#
+# @flc: true if FLC is supported
+#
+# @sections: The EPC sections information (Since: 7.0)
+#
+# Since: 6.2
+##
+{ 'struct': 'SgxInfo',
+  'data': { 'sgx': 'bool',
+            'sgx1': 'bool',
+            'sgx2': 'bool',
+            'flc': 'bool',
+            'sections': ['SgxEpcSection']} }
+
+##
+# @query-sgx:
+#
+# Returns information about configured SGX capabilities of guest
+#
+# Returns: @SgxInfo
+#
+# Since: 6.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sgx" }
+#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
+#                      "flc": true,
+#                      "sections": [{"node": 0, "size": 67108864},
+#                      {"node": 1, "size": 29360128}]} }
+##
+{ 'command': 'query-sgx', 'returns': 'SgxInfo' }
+
+##
+# @query-sgx-capabilities:
+#
+# Returns information about SGX capabilities of host
+#
+# Returns: @SgxInfo
+#
+# Since: 6.2
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-sgx-capabilities" }
+#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
+#                      "flc": true,
+#                      "section" : [{"node": 0, "size": 67108864},
+#                      {"node": 1, "size": 29360128}]} }
+##
+{ 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index cc472ce91c..d62db37d7c 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,85 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @SgxEpcSection:
-#
-# Information about intel SGX EPC section
-#
-# @node: the numa node
-#
-# @size: the size of EPC section
-#
-# Since: 7.0
-##
-{ 'struct': 'SgxEpcSection',
-  'data': { 'node': 'int',
-            'size': 'uint64'}}
-
-##
-# @SgxInfo:
-#
-# Information about intel Safe Guard eXtension (SGX) support
-#
-# @sgx: true if SGX is supported
-#
-# @sgx1: true if SGX1 is supported
-#
-# @sgx2: true if SGX2 is supported
-#
-# @flc: true if FLC is supported
-#
-# @sections: The EPC sections information (Since: 7.0)
-#
-# Since: 6.2
-##
-{ 'struct': 'SgxInfo',
-  'data': { 'sgx': 'bool',
-            'sgx1': 'bool',
-            'sgx2': 'bool',
-            'flc': 'bool',
-            'sections': ['SgxEpcSection']},
-   'if': 'TARGET_I386' }
-
-##
-# @query-sgx:
-#
-# Returns information about configured SGX capabilities of guest
-#
-# Returns: @SgxInfo
-#
-# Since: 6.2
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sgx" }
-#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
-#                      "flc": true,
-#                      "sections": [{"node": 0, "size": 67108864},
-#                      {"node": 1, "size": 29360128}]} }
-##
-{ 'command': 'query-sgx', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
-
-##
-# @query-sgx-capabilities:
-#
-# Returns information about SGX capabilities of host
-#
-# Returns: @SgxInfo
-#
-# Since: 6.2
-#
-# .. qmp-example::
-#
-#     -> { "execute": "query-sgx-capabilities" }
-#     <- { "return": { "sgx": true, "sgx1" : true, "sgx2" : true,
-#                      "flc": true,
-#                      "section" : [{"node": 0, "size": 67108864},
-#                      {"node": 1, "size": 29360128}]} }
-##
-{ 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo', 'if': 'TARGET_I386' }
-
-
 ##
 # @EvtchnPortType:
 #
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index ccb21a975d..d295e54d23 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -3,8 +3,8 @@
 #include "monitor/hmp-target.h"
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 
 void sgx_epc_build_srat(GArray *table_data)
 {
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index c80203b438..e2801546ad 100644
--- a/hw/i386/sgx.c
+++ b/hw/i386/sgx.c
@@ -19,7 +19,7 @@
 #include "monitor/hmp-target.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "system/address-spaces.h"
 #include "system/hw_accel.h"
 #include "system/reset.h"
diff --git a/stubs/monitor-i386-sgx.c b/stubs/monitor-i386-sgx.c
new file mode 100644
index 0000000000..00e081d52d
--- /dev/null
+++ b/stubs/monitor-i386-sgx.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+SgxInfo *qmp_query_sgx(Error **errp)
+{
+    error_setg(errp, "SGX support is not compiled in");
+    return NULL;
+}
+
+SgxInfo *qmp_query_sgx_capabilities(Error **errp)
+{
+    error_setg(errp, "SGX support is not compiled in");
+    return NULL;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 07e9d3799a..f2eb488018 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -80,6 +80,7 @@ if have_system
   stub_ss.add(files('monitor-arm-gic.c'))
   stub_ss.add(files('monitor-i386-rtc.c'))
   stub_ss.add(files('monitor-i386-sev.c'))
+  stub_ss.add(files('monitor-i386-sgx.c'))
 endif
 
 if have_system or have_user
-- 
2.48.1


