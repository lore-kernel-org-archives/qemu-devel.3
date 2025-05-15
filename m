Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24241C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcN4-0008ER-1p; Thu, 15 May 2025 13:27:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN1-000882-P8
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:47 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcMz-00025M-BL
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:47 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso1352520b3a.2
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330064; x=1747934864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IpZQezDLNs1bWZgYz4PCs4KujcbY96LROEFvSXsm75M=;
 b=f4Ock17rceju6YugXqKCnuwNujFg/y2l/3TIdYiqo79DwIjJpPeRkOhwtHtVKWE4jJ
 oQjrV2xM2GxTDQ94rGjZeP1x9IhjVRldGnxBWFzClckF9dV9vzvbe3ti1THEntD551Ts
 7ovzwNxpKKPkNQ6fs11fcnQIu6nT+Z9fpPruAy3cXhKenDfJOd3aaMMwi02fiukqhiU4
 WaMSrHbCLmh3UmrakMFXYkE5SLbG7w9dTW4MAAgMGxrYq7X10moato9cGsjY+2sm43fN
 Siz82uaoSiT0DkcTEzEvlI39M+ZFU3Qem6/1gy7vn0xRSep/xixDcfq5kuZ+guOtum5/
 tZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330064; x=1747934864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IpZQezDLNs1bWZgYz4PCs4KujcbY96LROEFvSXsm75M=;
 b=F/X9Akzfft0rDsWTNENxOKaJ9CQ3TulWrlJ9SGR2j3oPXmoJ/h4TzU9zoR2qjDD+22
 8WpQ3HYctVAjjYpgYuF6TeayQY9K1DOdasNw9pjVPtJdMT9DUvommC0aH0x7hF4/wWOn
 9ag9dVMpKvTahwKk4O+RY/nZ4cqt4VkVLdZjEj2mPMzs51k3x864UtRtdJ+WVMbm85JQ
 ncRP4gwQnQj0t21TvvmUgEH/faxYCs7xWcVOLqz+oezkN6lKpo/iWLSzDQRjQPj/S8YZ
 3uc6RE1uxwvZvwzaCLPNNBWSjuzNjqGE0pPV13tu6LSLyyRLIZ3a5CFXmKmHvWCw5A5O
 vb8w==
X-Gm-Message-State: AOJu0Yyvca+ve/el9C6H7JwSaUv+aASe6SdLuClkh4ZRbEk0kSsoLAPo
 4QAh5MM3EUUv2gdWAyR9pe31HxWcEUH6wkOcWETTEGDGW8OAPsHRqthT4NIoWqZisTqkeDQTrj2
 2CIuN
X-Gm-Gg: ASbGncvX7PxANkKkLLGYsDqyPOx+eWdupdCbPOEsn7lpZqVYXKw1pKcBUDPGn+FLZ1d
 5hx3E0Ri/8OqESDZ5WlPqRNb6FgYeRyMIzzRYXIpPvOFPeorWUEbpjkuxCHRQMpp883Z8KZRqUU
 GnpzV7CfeHHf7j8ug/LupxhUUDZ/SrM6knkq9L2oymXU2Vc/EdV5p9rdvrx1MzH1fIhHN4szrF/
 BkYq0oVtrqnyxD2gsM7gt0liMjAbg5/zdyKD2dMgYyAsv85i77kaqTnf/h4MY+MWKq7Hi6l7fQq
 9Q3CCP/aCO6TKPfFYBqIiZmFS0z/zG+RtcWcdpxtGLtMAVYCEOo=
X-Google-Smtp-Source: AGHT+IF0OpRlwApAAUVpKDND7D0TbvAwQAM0lU5fYGfGzM3aljT21C44LI2PgiApVXwd297NDv8P7Q==
X-Received: by 2002:a05:6a21:502:b0:1f5:7280:1cf2 with SMTP id
 adf61e73a8af0-2162189f48emr529454637.12.1747330063870; 
 Thu, 15 May 2025 10:27:43 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:43 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v2 05/12] qapi: make SGX commands unconditionally available
Date: Thu, 15 May 2025 10:27:25 -0700
Message-ID: <20250515172732.3992504-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
---
 qapi/misc-i386.json      | 77 +++++++++++++++++++++++++++++++++++++++
 qapi/misc-target.json    | 78 ----------------------------------------
 hw/i386/sgx-stub.c       | 13 -------
 hw/i386/sgx.c            |  2 +-
 stubs/monitor-i386-sgx.c | 17 +++++++++
 stubs/meson.build        |  1 +
 6 files changed, 96 insertions(+), 92 deletions(-)
 create mode 100644 stubs/monitor-i386-sgx.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index de0e4ab67ff..0ddc297ccbf 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -293,3 +293,80 @@
 { 'command': 'query-sev-attestation-report',
   'data': { 'mnonce': 'str' },
   'returns': 'SevAttestationReport' }
+
+##
+# @SGXEPCSection:
+#
+# Information about intel SGX EPC section info
+#
+# @node: the numa node
+#
+# @size: the size of EPC section
+#
+# Since: 7.0
+##
+{ 'struct': 'SGXEPCSection',
+  'data': { 'node': 'int',
+            'size': 'uint64'}}
+
+##
+# @SGXInfo:
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
+# @sections: The EPC sections info for guest (Since: 7.0)
+#
+# Since: 6.2
+##
+{ 'struct': 'SGXInfo',
+  'data': { 'sgx': 'bool',
+            'sgx1': 'bool',
+            'sgx2': 'bool',
+            'flc': 'bool',
+            'sections': ['SGXEPCSection']} }
+
+##
+# @query-sgx:
+#
+# Returns information about SGX
+#
+# Returns: @SGXInfo
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
+{ 'command': 'query-sgx', 'returns': 'SGXInfo' }
+
+##
+# @query-sgx-capabilities:
+#
+# Returns information from host SGX capabilities
+#
+# Returns: @SGXInfo
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
+{ 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo' }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index d36292b3321..d9368a1f21f 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -2,84 +2,6 @@
 # vim: filetype=python
 #
 
-##
-# @SGXEPCSection:
-#
-# Information about intel SGX EPC section info
-#
-# @node: the numa node
-#
-# @size: the size of EPC section
-#
-# Since: 7.0
-##
-{ 'struct': 'SGXEPCSection',
-  'data': { 'node': 'int',
-            'size': 'uint64'}}
-
-##
-# @SGXInfo:
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
-# @sections: The EPC sections info for guest (Since: 7.0)
-#
-# Since: 6.2
-##
-{ 'struct': 'SGXInfo',
-  'data': { 'sgx': 'bool',
-            'sgx1': 'bool',
-            'sgx2': 'bool',
-            'flc': 'bool',
-            'sections': ['SGXEPCSection']},
-   'if': 'TARGET_I386' }
-
-##
-# @query-sgx:
-#
-# Returns information about SGX
-#
-# Returns: @SGXInfo
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
-{ 'command': 'query-sgx', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
-
-##
-# @query-sgx-capabilities:
-#
-# Returns information from host SGX capabilities
-#
-# Returns: @SGXInfo
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
-{ 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo', 'if': 'TARGET_I386' }
-
 
 ##
 # @EvtchnPortType:
diff --git a/hw/i386/sgx-stub.c b/hw/i386/sgx-stub.c
index 38ff75e9f37..10ffcdd154d 100644
--- a/hw/i386/sgx-stub.c
+++ b/hw/i386/sgx-stub.c
@@ -4,24 +4,11 @@
 #include "hw/i386/pc.h"
 #include "hw/i386/sgx-epc.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 
 void sgx_epc_build_srat(GArray *table_data)
 {
 }
 
-SGXInfo *qmp_query_sgx(Error **errp)
-{
-    error_setg(errp, "SGX support is not compiled in");
-    return NULL;
-}
-
-SGXInfo *qmp_query_sgx_capabilities(Error **errp)
-{
-    error_setg(errp, "SGX support is not compiled in");
-    return NULL;
-}
-
 void hmp_info_sgx(Monitor *mon, const QDict *qdict)
 {
     monitor_printf(mon, "SGX is not available in this QEMU\n");
diff --git a/hw/i386/sgx.c b/hw/i386/sgx.c
index 5685c4fb802..2b10a8d144e 100644
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
index 00000000000..55a4f194f3f
--- /dev/null
+++ b/stubs/monitor-i386-sgx.c
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+SGXInfo *qmp_query_sgx(Error **errp)
+{
+    error_setg(errp, "SGX support is not compiled in");
+    return NULL;
+}
+
+SGXInfo *qmp_query_sgx_capabilities(Error **errp)
+{
+    error_setg(errp, "SGX support is not compiled in");
+    return NULL;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 07e9d3799a5..f2eb4880181 100644
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
2.47.2


