Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31FD2C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 19:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uIBFM-0001CC-LV; Thu, 22 May 2025 15:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEz-0000wU-VK
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:06:06 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uIBEr-0006TD-QA
 for qemu-devel@nongnu.org; Thu, 22 May 2025 15:05:59 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-30e57a37294so7906234a91.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 12:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747940755; x=1748545555; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMEOAZnlEJm4Cel43J2TXjtD8bt/qKeMwnzVffeoXSU=;
 b=Kg5BufUHXILgZdipCxRkl/4CRvIsyGvc8qml5KEcdeH/wUmht4tKVg1E8h3DTRuhah
 4C8anl5dQqd/s/qpKzpDhRw1pDmi3wqgkVYG+15/oPzfa5rFZczQES8buYbZvXuuVOne
 UrCpVH4Pelh4SD7vXl8NqXAAtTozWj7Zcp9AyMRSd8zMyH1XvByh4Eegi74nSg9E8O5Z
 TMuUbMhjVB2uhuKrSfZ5gGkaL+uuDJ+lbAgFMfTQQg+eWlV9M9DmywKijU+PB1ljdMfY
 Ze1ZgGXsRM0mag9TAf26IVE4OC3SrmCZMsEk+2X5V0TmxblU05HbBZCCnS5ryK/MIlOV
 d+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747940755; x=1748545555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMEOAZnlEJm4Cel43J2TXjtD8bt/qKeMwnzVffeoXSU=;
 b=UcmRB0X0i/BQNxIY2qsiIc+zN+KXw2eTQY4WN6kZg3Nv+MCERavIyR3oESCztmaPT6
 iOpcK3FWGqpjswtFD6MaoizR7X3U2KFwdXWiWSWuvpt6mfKwa/ozGJGAq58OfQnblzZP
 4YGF1YV4a55qY1oQmXaaFw6GEGJ6hPb7iW2YJkdG5Wg6g+WpTDMScBiqjdXCpOpf89Ix
 1XMx+Jwcel1G7qd2vV6qcvF93BVxPWibLBhGW9gB8rlmOM8kDQzCYNX7EoG2yfd7M0iw
 n49vzIGbCfYY+py3vMJEMSVTA02ZiigFOPThlw8V6JHm3+jSrTZH3jgJlkiPzoiAaYeI
 cQMw==
X-Gm-Message-State: AOJu0Yyrfu3GTjTZmHSINVlH4ajOfhEt3ofHaVKQ4e+QxrEC9qXfPZdi
 eVmyWI90Fk+aVvuuyhzBn9CYpXuPdQbSSGIfODCuAKU49wwZ+/F1Iu5sw3OosjSym270D46dv0W
 LvLw3
X-Gm-Gg: ASbGncsFYcna3qCu527CL3nVzbWwNEE4INBqIIpipW0Vjp1V4KxcoF3tuBVQyECFlXT
 50Alr1kqBRD6Kpn+ou7KPIxjBpD4f/pOXYq+qek259jmeFTceC7HjSr1AAWRmX/WQ0qli4tMibK
 CKGwTs/i1Izji0zKb2YOcfNviQYD1AG+KoxD5ziHYuWjx2iJexpf3LH1GLjlT+71Wx/xvO7DlSK
 587qEkH/NyqIPtz7uQ/VwCZCJtAUph7Z6VDNSaUjKycCsrqOb2Mxvo5GSDyaY1TKr6paImfx5QJ
 eT5e1qJjdPd3skofzYia4s7QgBvbefbNxUzHZSV/joLCzUGC/hWZLVgrnM+l7A==
X-Google-Smtp-Source: AGHT+IEbDbmKUmu9k3CnG7i0pxmzr9UALCh0UhZxtRvJS/N3wxy2YOJR47ymKrPYEixa5pWzIZE0qg==
X-Received: by 2002:a17:90b:5344:b0:30a:b93e:381b with SMTP id
 98e67ed59e1d1-30e8323efb1mr37558178a91.35.1747940755128; 
 Thu, 22 May 2025 12:05:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eb082c66sm11625565a12.60.2025.05.22.12.05.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 12:05:54 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, thuth@redhat.com, pbonzini@redhat.com,
 richard.henderson@linaro.org, armbru@redhat.com,
 pierrick.bouvier@linaro.org, peter.maydell@linaro.org, berrange@redhat.com,
 philmd@linaro.org, David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v4 06/15] qapi: make Xen event commands unconditionally
 available
Date: Thu, 22 May 2025 12:05:33 -0700
Message-ID: <20250522190542.588267-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
References: <20250522190542.588267-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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
 qapi/misc-target.json    | 111 ---------------------------------------
 hw/i386/kvm/xen-stubs.c  |  13 -----
 hw/i386/kvm/xen_evtchn.c |   2 +-
 stubs/monitor-i386-xen.c |  16 ++++++
 stubs/meson.build        |   1 +
 6 files changed, 125 insertions(+), 125 deletions(-)
 create mode 100644 stubs/monitor-i386-xen.c

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 92751d5e180..cbf85233eba 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -370,3 +370,110 @@
 #                      {"node": 1, "size": 29360128}]} }
 ##
 { 'command': 'query-sgx-capabilities', 'returns': 'SgxInfo' }
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
index d62db37d7cf..c9ea1ab23e7 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -1,114 +1,3 @@
 # -*- Mode: Python -*-
 # vim: filetype=python
 #
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


