Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38598C3ABD8
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj7-0001gB-So; Wed, 14 May 2025 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj2-0001TR-NT
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:24 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj0-00032w-6i
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:24 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22d95f0dda4so4136495ad.2
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266080; x=1747870880; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lBS2AIpxXgiP9xnU+n7gYkZBp0TynhJ2U8QSIxuWAKE=;
 b=K4ZmI/s9RnQ4Bqfu4SnDzvfLuEI2ADM2cc2U+u2K1Hi8AjEPB8iLEVS1zcLse5Sh0U
 9jtAEf7HL49qSQW8gqWtIBJV2/mHAjugkwpdRzcN9ZFqtJZKM2iLerr3h1hAxCMynAP7
 ULGVyXuiy/GdP/yQhgfKeogJSBV4JCN2Hfh015PBc9INbhXlhvvNp9daG6XaVeHZSr+L
 E6GMNVtNeo5EwnPwV2ko19LNatksk0SfNKjWn2uZ/KzEZO8BM8XEYDo/KGEQx70HOye3
 twNDuBP6T2eN4FjzyXu57+TbyIKn7YNaQ4zwnzw1yDdg2RrNKyRGOF7VcsxhdArD6D0o
 YiTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266080; x=1747870880;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lBS2AIpxXgiP9xnU+n7gYkZBp0TynhJ2U8QSIxuWAKE=;
 b=SN1K9TD1MvmaBygVeIlc2dkrWv3JMOIAvXDyBfYtm8Cd94i0z8WIOoXC5O4M/oNZf7
 9i3kitO+7nck1GvT6DW9dc6zX6TEAY4+mTefa1h42vttnn+NRe5bhV3o76XqRpVUhI+S
 9STnJXV8vsFT2r7XrvQeDkbvz8bcQT6ZwM1AsbziSY9I1x9fx9vw9Sid16C6aUB0byKZ
 f0irUsbxyKA87DZDXzt6+ZGySDYVh8bkm8u5YjrthQEZ0HUtacrPzo4iHpyGQS5xDgRO
 7gOJf3VSke9XXMnBiCJlzbNs7qg53TuB0l5qJFYSYY/b7ZP0hg7q90dZ5njDol3f8JaT
 LJ9A==
X-Gm-Message-State: AOJu0Yw/bnJeFdqA44i0lAexi3OrlbthVUorekyBP4subYdJhxB8Zz1n
 KyqCURmJW3fLCaYPmcc1zmm1g88T57O/sa0h3W1++GdeZoYS6Hcwf/y+zJJedU8ZyWBW4v/wR9Z
 msCs=
X-Gm-Gg: ASbGnctrlsTh7F88GppRBCgDNs9U42R4Jcdd/U+usaFBqHE9NlKS7Mli5+kPWvZMiMQ
 0butNPnmAONmr0yP6UugRfb79H2YBqBLo3B2sXtfcGeyoX6OLbtfUP8Fje1H5XOMdLamFGJkBdB
 5b1xfujtu4DLkB4zSGM3aFW/G/7UuxJcZHvPRL5pPyfldsbSXpR9XGEo6hQnPgIPTLvRv87JC6v
 c7nQDbcO1CU4si4xIvBAWVieFqvjzCcB72+Ko0bHokUqxplcK5nlM0MssWtRXloQdI0rh7k2MwA
 OSUC/7+NAqibL32RcmdsBy+cctKG1Iy3o2T94ZDJQsSSboZYSIU=
X-Google-Smtp-Source: AGHT+IF6h919GsR+TM7Y44WdyOAvoQgcQc2HKTq08occBfD7k7WnjMfY02YWJrCSgvW7nqtiN4ayfQ==
X-Received: by 2002:a17:903:2f85:b0:223:5ca8:5ecb with SMTP id
 d9443c01a7336-23198143b9bmr69090595ad.42.1747266080411; 
 Wed, 14 May 2025 16:41:20 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:20 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 05/12] qapi: make SGX commands unconditionally available
Date: Wed, 14 May 2025 16:41:01 -0700
Message-ID: <20250514234108.3746675-6-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x630.google.com
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


