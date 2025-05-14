Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D47FC3ABDA
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 23:42:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFLj7-0001fQ-QA; Wed, 14 May 2025 19:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj4-0001V7-EH
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:26 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFLj1-00033B-7S
 for qemu-devel@nongnu.org; Wed, 14 May 2025 19:41:26 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-b20d46fcc86so241252a12.3
 for <qemu-devel@nongnu.org>; Wed, 14 May 2025 16:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747266081; x=1747870881; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Ut9gXI10r1rMT9f7vlPNOoFK8sxd1vNcUdclqcG1OI=;
 b=KThoeloxoZ6RngZtThHsxISnWvqAdostDNwrP55jzucRz4NpEAV7PG3sqZJOSajPyx
 SUb8Rvsibljp2Vpv30FA2cUi/DpFk7ZFuAp8zkpnQGqMqHOjxuFE2O/CA2auoxuZutqf
 bc371X+WLOjO1IG1UFAkYP8vBnrmtacS0qcaBTA9nyHH/67mKS0U0PRk6SUxx6QsmuQE
 ReTJ0yTMByZAZxDBCA2u4W9IRYrHcwjNlWZ40XNhsCvo26B4JFG+rBsoxG4bgb8uGfht
 W4e1hIEgqldH+u9C6ofc3D9Nw5SeAYBBX1NwhhDM55cbb/NNszCfT+cgB3NPfy6BrI+K
 N/rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747266081; x=1747870881;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Ut9gXI10r1rMT9f7vlPNOoFK8sxd1vNcUdclqcG1OI=;
 b=G+zqwzb7uwLupf/h7Zr3ei9p4nNshNdvDYk9R6q9JrAhXrov7c/vTA9w/rFRxw5eJ0
 e7rhEy31uOzDI74Bse4xnFiiT5987qnqSTfddZojUFldfb9RNrZxdEkyQr5LPSpJGz0m
 46F2wCJaryUdRpKUC/5+qP61cZY6CHSzZWCHc8g/LUusexx7q/0m9R8tInCJ4t+b+Xa8
 Rcy57Evj3HMEOMTmEG9OreCiteaNT68FuK+GYxnYiYWJqSGHByPYxxbdqKdRIP+akX4B
 bq+s1q9JqYLd0l7ElHHaktlw3XKkDixjAv2yqGAsRN6OUF5dru8QKUrdQn9wIGwfEv2j
 3muw==
X-Gm-Message-State: AOJu0YxRMDx1zG7w2qRI3DZsskka8PuxTAqGXG4FJE6ZTdinI3CP8ypW
 7XtwP1ADi7b0uGfioSKNrpNpZCMWnfuUeigbFflDIiIhCvhvyeUw0OW2hERAV4tpFSqxPCGX+kj
 ZB+o=
X-Gm-Gg: ASbGnctiWpnyt21GJ1e05XuSwVdgNFYJ4VIcRYXyD/fjYtIb63twhlTNQUNh70B8TTi
 vkmqxec0CbUME2dmKB50lRYvJr9Q+o/8GGoc9G4m8OVYdNbHKH7p/DiOW7oIhHCkpAa6RGz8GVS
 7FTltIXhY6cwTRq8Iqli+os+VrjGiTOGyBKmNDIhfwCMWcBWeLDPiwxAQz0im90Y7NyTs19xPdj
 ZIvVvXkkrS10duVFrXYFGj7wO6Wz83ul05T8gV+cYl3TRaPk0vQUL2pQXTiauMLfbdh2q5EhAc+
 d4sslGAookTVZOIx2CTnAqMo3dJ8LtbSDk2aurJkEXlWxs2G13g=
X-Google-Smtp-Source: AGHT+IHW652sqvS5EoFGoyCFsbsOJLXXssIELu0YYx+EizvFg5QzTFgW/lglGk2uUzRH2Ng4fD6Ncg==
X-Received: by 2002:a17:903:1b26:b0:224:1074:63a2 with SMTP id
 d9443c01a7336-231981befb6mr87984055ad.43.1747266081444; 
 Wed, 14 May 2025 16:41:21 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc828b4e4sm104583615ad.182.2025.05.14.16.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 May 2025 16:41:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Michael Roth <michael.roth@amd.com>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, Richard Henderson <richard.henderson@linaro.org>,
 peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 06/12] qapi: make Xen event commands unconditionally available
Date: Wed, 14 May 2025 16:41:02 -0700
Message-ID: <20250514234108.3746675-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
References: <20250514234108.3746675-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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


