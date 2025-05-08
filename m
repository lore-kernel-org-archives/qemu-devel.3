Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 034FCC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 13:59:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD1m0-00036y-Kk; Thu, 08 May 2025 09:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lv-0002ib-RU
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uD1lt-00079v-Iz
 for qemu-devel@nongnu.org; Thu, 08 May 2025 09:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746712724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zTMF2aQoBryuGNIZS+BzSHfaK24hkeI17xCmPeKSfmM=;
 b=WzFmTbbL4kmpHCEM9Q3NezV/rFwinX6Cgq2mtP2qgwd0Ux9+CCF66fDvrAjsTAfSmiALaO
 GQz9NbaJSE6pQ//WRlGFii23+5wrDq4aPXcGYNUeg57pK2ExtGQhToVR8vchHncBom4mLl
 L1qeJ2RrI3jkJyPhveDM3uFpsxkVZv8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-2WcpbBdNNi-tfPmAaKvTGQ-1; Thu,
 08 May 2025 09:58:43 -0400
X-MC-Unique: 2WcpbBdNNi-tfPmAaKvTGQ-1
X-Mimecast-MFC-AGG-ID: 2WcpbBdNNi-tfPmAaKvTGQ_1746712722
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A8401800DA1; Thu,  8 May 2025 13:58:42 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.138])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AF5F5180049D; Thu,  8 May 2025 13:58:39 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 06/10] qapi: make Xen event commands unconditionally available
Date: Thu,  8 May 2025 14:58:12 +0100
Message-ID: <20250508135816.673087-7-berrange@redhat.com>
In-Reply-To: <20250508135816.673087-1-berrange@redhat.com>
References: <20250508135816.673087-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This removes the TARGET_I386 condition from the Xen event channel
commands, moving them to the recently introduced misc-i386.json
QAPI file, given they are inherantly i386 specific commands.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/i386/kvm/xen-stubs.c  |  13 -----
 hw/i386/kvm/xen_evtchn.c |   2 +-
 qapi/misc-i386.json      | 107 +++++++++++++++++++++++++++++++++++++
 qapi/misc-target.json    | 110 ---------------------------------------
 stubs/meson.build        |   1 +
 stubs/monitor-i386-xen.c |  16 ++++++
 6 files changed, 125 insertions(+), 124 deletions(-)
 create mode 100644 stubs/monitor-i386-xen.c

diff --git a/hw/i386/kvm/xen-stubs.c b/hw/i386/kvm/xen-stubs.c
index d03131e686..ce73119ee7 100644
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
index b5190549a8..dd566c4967 100644
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
diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 0ddc297ccb..3d3f373a6b 100644
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
index d9368a1f21..6c2f4e71d7 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -3,113 +3,3 @@
 #
 
 
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
diff --git a/stubs/meson.build b/stubs/meson.build
index f2eb488018..0ef11976a2 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -81,6 +81,7 @@ if have_system
   stub_ss.add(files('monitor-i386-rtc.c'))
   stub_ss.add(files('monitor-i386-sev.c'))
   stub_ss.add(files('monitor-i386-sgx.c'))
+  stub_ss.add(files('monitor-i386-xen.c'))
 endif
 
 if have_system or have_user
diff --git a/stubs/monitor-i386-xen.c b/stubs/monitor-i386-xen.c
new file mode 100644
index 0000000000..95b826f979
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
-- 
2.49.0


