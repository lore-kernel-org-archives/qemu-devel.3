Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AD6C54E65
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 22:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHs4Y-0006BB-Sv; Wed, 21 May 2025 18:38:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4W-0006AJ-UQ
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:01 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uHs4R-0005Z1-3P
 for qemu-devel@nongnu.org; Wed, 21 May 2025 18:38:00 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-232059c0b50so43787035ad.2
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 15:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747867071; x=1748471871; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gMEOAZnlEJm4Cel43J2TXjtD8bt/qKeMwnzVffeoXSU=;
 b=wZwqBU6aFTRcSrovoLdYrpt/35ECSRutK+1FT2w7UcgxeACb0cITeejY6wHwasXYsG
 OflPxRzwGIg+sgzZHch/rmWH3Elf0JSWUIfA3WFxms/vi5jttkqJTZdgOjQndB2eY+Pa
 Sxd2H9ui06nWULA2vqqAFGidlV4vE2didSO1zB7Lo1Lr7pECzdRqcp6zWyGG2y+4M5Ym
 a3sQDHO4lnxgaor/DhQw+N1fm9WIUlP0daD8CN8o4R7p0sMlR2GvLYsafuKxDRcuu56m
 czfMhQniqnkadKNkRTH5tD7AguEubSOF4PgNcj+g5BiznwS+h3oq6ZE62R8QOgZ1PqeL
 JVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747867071; x=1748471871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMEOAZnlEJm4Cel43J2TXjtD8bt/qKeMwnzVffeoXSU=;
 b=mZgTlhbK52hnDkUXPEKhSpcMy9RAeHqR6S/3Us/+dvXNPjKjBgpejocTU7va0M6DPk
 n+j9BaxV/wv1YPlfbR+59uObPofLd0nOIdAy6I3ODRbjwda/qdgknKyVW7fSIrYT/gio
 44t3XmbguMymA7MQbJckcj1U/XJcibGwFwhLh3vPPDgEvUEjR0j+FmJsgA6gCtSllg2g
 yrJO+v3QNQWWj9ekRtgtIpp5+lRdus6+rxVGAryaC7YIUJ20q+PbEt2iUdYXnviJ4stY
 8aKu8/jEqZc4qtSkTEUSeLmZymR7Jk3IDaM78M6iL6KVzClMf7DSJUpbdrdN601RTaC/
 OlOQ==
X-Gm-Message-State: AOJu0YxTYRr6O69RQz0mAd8c4+Efgmy4z02MuvJcN1EQcTngQEkHhI76
 IeM5cyIxDz0cdJLZLSp5BQnQlLrWf8SxBrVczNNDZkzS8DEXJkuk+laRIVaDeZ9BkwJyG+nEGHZ
 +Vt3C
X-Gm-Gg: ASbGncsB/qu0j9Z7/HxQNjOzOYKpxTPBaX3k7mKwBR+TMRQkF2If1lJI7XaAb36m3rQ
 Hr7e/+HBAk4itsVwCiD2MRmBvjROoPh8DnLTy5kdpyUL7Zpu01SRgoMumu5Ni+5DBB4bhLhGliS
 M9qtcMo3j0xaoZYVwsXiot62W0KgvLeEBMNXG5vZB6IMLSKfGLp9ttoc6l11UcKA2IuUlZ/EEEz
 E4Nympqa4yOVJyAh1up/NZnXqa8LpamDhyJWJtg4tbkqv1RY6NbK563d9H1OfvjwNoUXinTtlBg
 lUxyEldga61gnBw9H7/y9lz3U9y4RLU6q8fccb2uVnjHc0lHBQA=
X-Google-Smtp-Source: AGHT+IGhuZIjkk5dL7zImLY8c4AuhL2L55iNqJjxk7bsvJbokLUCfKGKlqile3DuEztuxU//FToZ4w==
X-Received: by 2002:a17:902:d4ce:b0:229:1619:ab58 with SMTP id
 d9443c01a7336-231de37e895mr305066835ad.43.1747867070892; 
 Wed, 21 May 2025 15:37:50 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97dcesm97711105ad.121.2025.05.21.15.37.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 15:37:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com, peter.maydell@linaro.org,
 armbru@redhat.com, michael.roth@amd.com, philmd@linaro.org,
 richard.henderson@linaro.org, berrange@redhat.com, thuth@redhat.com,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 06/14] qapi: make Xen event commands unconditionally
 available
Date: Wed, 21 May 2025 15:37:32 -0700
Message-ID: <20250521223740.249720-7-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
References: <20250521223740.249720-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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


