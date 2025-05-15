Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B29C3ABDD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:29:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcNS-0000Sh-KV; Thu, 15 May 2025 13:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN3-0008Ek-FJ
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:49 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcN0-00025v-LC
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:27:48 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-7423df563d6so1398924b3a.0
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747330065; x=1747934865; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yy1N9oiYSYBkQ29Su06uvC5+FmtCDv4iNmAiWF6Koag=;
 b=ASZk1t2m6ejzXgfFXk3Gx/y5QNj/aa4DlQBHBhePdhlrRjzcqHccK9JExxdcJwMf59
 tYi2CjIJBe0G168G52+BBaCGMXKzKKeT0HvthAlg43VMIsT98wYen/ABEBE7Hten8ZmW
 RswX3QhBvMtJp+YCkAKNrs5WuoEaV2HVeCrNyrIruJCLzRuMjfn4RvF5WXE/8oBk/rLq
 gKqHEDz8NJn2HKTKHdI7YmGqL16o0uvDS+TRB1UvzxxERvpLRT0iE4q4Mt5phra4UG93
 cBpvLtrFCCGJQOK7xvx5Cn01efpge8rDy8wFZbawQFW8Zz8GYFrreZF0Kppus22VBRAP
 mvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747330065; x=1747934865;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yy1N9oiYSYBkQ29Su06uvC5+FmtCDv4iNmAiWF6Koag=;
 b=n5vRewv481DDBLu3vkLGq20wh8y5Pex22hAYjJetdwNUqlqNap8NquqAKxVXIMCUM6
 7yD+O/PeFZUiXAh3DKPv6f2QzdrWcGxr7a5ZZBbMqKFOcjv4MKcnXjljW61imAcbSEIb
 tQi9nSsBg2ZmeBaisE7U60gi+mdSACC0gNDFlTE0DmswFvc35a08No3Bnpsck3uOfUXF
 n4lt0pWY0PQnlur0Pve+RW+DdjkPYwrZD+/mKeGGukw4VYrc+onRp9I5V3L/hanB3qeO
 cAHFzxiwlGuXmsUyDrGjEL3+V46sTpS+DObA4hgLv76DlL3YW07+kLt9PgSA0REbeC+L
 K57w==
X-Gm-Message-State: AOJu0YxE7u/ufUH+ZySpkqDc09nPNdVpnPh24vmvRz7O+26/GyYOJiWC
 k3XJsCzcJHsOUFyl/FcjznvO9syblXe/IBs4i5kIpT3VqqGspD+8AW0mu/qN68sFttKlLOIRKoO
 MsAI3
X-Gm-Gg: ASbGnctztZBXXGGpX3KyQ3Dt+JjuQlHGZJDXI3TT5//LU0+Ap+L0aJ62KDzv1l1i9yk
 GcqJAmaRgwoXjKHKPY6KldX/BRNRsfXuLtL/4KSI05cgTgD6sezXHOZbes6VaP2ic5YvkUOP5Cr
 Pam5jbNAzyUZ35fkDpJBCBTEjXpAegUlsYHxDV1BtbAMSFCCOrna8bUwaaWOnanLO133kaM+oqM
 5H+bIB94EvS1y5ltPy3ugfwDGjprI7s0pA61fQEEo+lH/dqL5HlBntifp4Z2uveo7C0pBte89xa
 9Q6z6WcXLn4iKzJCUUX3UGQQpxohBsf8xHIFCULgLzeqb9nz3tA=
X-Google-Smtp-Source: AGHT+IGf0DssqHpoVYKS/Po4HeATLasR0Yfc9cTp4qkOKfxeF5Ul3T76lRFHDEqGDU03jMY2kDJ7nw==
X-Received: by 2002:a05:6a21:69b:b0:216:1ea0:a512 with SMTP id
 adf61e73a8af0-21621a03148mr429988637.38.1747330064831; 
 Thu, 15 May 2025 10:27:44 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a96dfa9dsm79730b3a.10.2025.05.15.10.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:27:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 berrange@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 06/12] qapi: make Xen event commands unconditionally
 available
Date: Thu, 15 May 2025 10:27:26 -0700
Message-ID: <20250515172732.3992504-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
References: <20250515172732.3992504-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

This removes the TARGET_I386 condition from the Xen event channel
commands, moving them to the recently introduced misc-i386.json
QAPI file, given they are inherantly i386 specific commands.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 qapi/misc-i386.json      | 107 +++++++++++++++++++++++++++++++++++++
 qapi/misc-target.json    | 112 ---------------------------------------
 hw/i386/kvm/xen-stubs.c  |  13 -----
 hw/i386/kvm/xen_evtchn.c |   2 +-
 stubs/monitor-i386-xen.c |  16 ++++++
 stubs/meson.build        |   1 +
 6 files changed, 125 insertions(+), 126 deletions(-)
 create mode 100644 stubs/monitor-i386-xen.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 0ddc297ccbf..3d3f373a6be 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -370,3 +370,110 @@
 #                      {"node": 1, "size": 29360128}]} }
 ##
 { 'command': 'query-sgx-capabilities', 'returns': 'SGXInfo' }
+
+##
+# @EvtchnPortType:
+#
+# An enumeration of Xen event channel port types.
+#
+# @closed: The port is unused.
+#
+# @unbound: The port is allocated and ready to be bound.
+#
+# @interdomain: The port is connected as an interdomain interrupt.
+#
+# @pirq: The port is bound to a physical IRQ (PIRQ).
+#
+# @virq: The port is bound to a virtual IRQ (VIRQ).
+#
+# @ipi: The post is an inter-processor interrupt (IPI).
+#
+# Since: 8.0
+##
+{ 'enum': 'EvtchnPortType',
+  'data': ['closed', 'unbound', 'interdomain', 'pirq', 'virq', 'ipi'] }
+
+##
+# @EvtchnInfo:
+#
+# Information about a Xen event channel port
+#
+# @port: the port number
+#
+# @vcpu: target vCPU for this port
+#
+# @type: the port type
+#
+# @remote-domain: remote domain for interdomain ports
+#
+# @target: remote port ID, or virq/pirq number
+#
+# @pending: port is currently active pending delivery
+#
+# @masked: port is masked
+#
+# Since: 8.0
+##
+{ 'struct': 'EvtchnInfo',
+  'data': {'port': 'uint16',
+           'vcpu': 'uint32',
+           'type': 'EvtchnPortType',
+           'remote-domain': 'str',
+           'target': 'uint16',
+           'pending': 'bool',
+           'masked': 'bool'} }
+
+
+##
+# @xen-event-list:
+#
+# Query the Xen event channels opened by the guest.
+#
+# Returns: list of open event channel ports.
+#
+# Since: 8.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "xen-event-list" }
+#     <- { "return": [
+#             {
+#                 "pending": false,
+#                 "port": 1,
+#                 "vcpu": 1,
+#                 "remote-domain": "qemu",
+#                 "masked": false,
+#                 "type": "interdomain",
+#                 "target": 1
+#             },
+#             {
+#                 "pending": false,
+#                 "port": 2,
+#                 "vcpu": 0,
+#                 "remote-domain": "",
+#                 "masked": false,
+#                 "type": "virq",
+#                 "target": 0
+#             }
+#          ]
+#        }
+##
+{ 'command': 'xen-event-list',
+  'returns': ['EvtchnInfo'] }
+
+##
+# @xen-event-inject:
+#
+# Inject a Xen event channel port (interrupt) to the guest.
+#
+# @port: The port number
+#
+# Since: 8.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
+#     <- { "return": { } }
+##
+{ 'command': 'xen-event-inject',
+  'data': { 'port': 'uint32' } }
diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index d9368a1f21f..c9ea1ab23e7 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -1,115 +1,3 @@
 # -*- Mode: Python -*-
 # vim: filetype=python
 #
-
-
-##
-# @EvtchnPortType:
-#
-# An enumeration of Xen event channel port types.
-#
-# @closed: The port is unused.
-#
-# @unbound: The port is allocated and ready to be bound.
-#
-# @interdomain: The port is connected as an interdomain interrupt.
-#
-# @pirq: The port is bound to a physical IRQ (PIRQ).
-#
-# @virq: The port is bound to a virtual IRQ (VIRQ).
-#
-# @ipi: The post is an inter-processor interrupt (IPI).
-#
-# Since: 8.0
-##
-{ 'enum': 'EvtchnPortType',
-  'data': ['closed', 'unbound', 'interdomain', 'pirq', 'virq', 'ipi'],
-  'if': 'TARGET_I386' }
-
-##
-# @EvtchnInfo:
-#
-# Information about a Xen event channel port
-#
-# @port: the port number
-#
-# @vcpu: target vCPU for this port
-#
-# @type: the port type
-#
-# @remote-domain: remote domain for interdomain ports
-#
-# @target: remote port ID, or virq/pirq number
-#
-# @pending: port is currently active pending delivery
-#
-# @masked: port is masked
-#
-# Since: 8.0
-##
-{ 'struct': 'EvtchnInfo',
-  'data': {'port': 'uint16',
-           'vcpu': 'uint32',
-           'type': 'EvtchnPortType',
-           'remote-domain': 'str',
-           'target': 'uint16',
-           'pending': 'bool',
-           'masked': 'bool'},
-  'if': 'TARGET_I386' }
-
-
-##
-# @xen-event-list:
-#
-# Query the Xen event channels opened by the guest.
-#
-# Returns: list of open event channel ports.
-#
-# Since: 8.0
-#
-# .. qmp-example::
-#
-#     -> { "execute": "xen-event-list" }
-#     <- { "return": [
-#             {
-#                 "pending": false,
-#                 "port": 1,
-#                 "vcpu": 1,
-#                 "remote-domain": "qemu",
-#                 "masked": false,
-#                 "type": "interdomain",
-#                 "target": 1
-#             },
-#             {
-#                 "pending": false,
-#                 "port": 2,
-#                 "vcpu": 0,
-#                 "remote-domain": "",
-#                 "masked": false,
-#                 "type": "virq",
-#                 "target": 0
-#             }
-#          ]
-#        }
-##
-{ 'command': 'xen-event-list',
-  'returns': ['EvtchnInfo'],
-  'if': 'TARGET_I386' }
-
-##
-# @xen-event-inject:
-#
-# Inject a Xen event channel port (interrupt) to the guest.
-#
-# @port: The port number
-#
-# Since: 8.0
-#
-# .. qmp-example::
-#
-#     -> { "execute": "xen-event-inject", "arguments": { "port": 1 } }
-#     <- { "return": { } }
-##
-{ 'command': 'xen-event-inject',
-  'data': { 'port': 'uint32' },
-  'if': 'TARGET_I386' }
diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index d03131e6864..ce73119ee7a 100644
--- a/hw/i386/kvm/xen-stubs.c
+++ b/hw/i386/kvm/xen-stubs.c
@@ -12,7 +12,6 @@
 #include "qemu/osdep.h"
 
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
 
 #include "xen_evtchn.h"
 #include "xen_primary_console.h"
@@ -38,15 +37,3 @@ void xen_primary_console_create(void)
 void xen_primary_console_set_be_port(uint16_t port)
 {
 }
-#ifdef TARGET_I386
-EvtchnInfoList *qmp_xen_event_list(Error **errp)
-{
-    error_setg(errp, "Xen event channel emulation not enabled");
-    return NULL;
-}
-
-void qmp_xen_event_inject(uint32_t port, Error **errp)
-{
-    error_setg(errp, "Xen event channel emulation not enabled");
-}
-#endif
diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index b5190549a81..dd566c49679 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "monitor/hmp.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc-target.h"
+#include "qapi/qapi-commands-misc-i386.h"
 #include "qobject/qdict.h"
 #include "qom/object.h"
 #include "exec/target_page.h"
diff --git a/stubs/monitor-i386-xen.c b/stubs/monitor-i386-xen.c
new file mode 100644
index 00000000000..95b826f9795
--- /dev/null
+++ b/stubs/monitor-i386-xen.c
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-misc-i386.h"
+
+EvtchnInfoList *qmp_xen_event_list(Error **errp)
+{
+    error_setg(errp, "Xen event channel emulation not enabled");
+    return NULL;
+}
+
+void qmp_xen_event_inject(uint32_t port, Error **errp)
+{
+    error_setg(errp, "Xen event channel emulation not enabled");
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index f2eb4880181..0ef11976a2f 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -81,6 +81,7 @@ if have_system
   stub_ss.add(files('monitor-i386-rtc.c'))
   stub_ss.add(files('monitor-i386-sev.c'))
   stub_ss.add(files('monitor-i386-sgx.c'))
+  stub_ss.add(files('monitor-i386-xen.c'))
 endif
 
 if have_system or have_user
-- 
2.47.2


