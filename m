Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392D4D49231
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 15:13:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD3Qk-0007gY-PV; Mon, 18 Nov 2024 10:12:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tD3Qk-0007gO-3P
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:12:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tD3Qi-0002qD-48
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 10:12:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731942761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=91bDsXGibs4V0p1WGe00JPcTn9dCGmR0LcE5tgvzZGo=;
 b=hIQDhKMSdDbOJhD+96eJaJgtGP1FMFCAmr5OUDxNPhIUlFbjNJnlGkwEwnLPKNZRMLFHcm
 ABmcJ7ko6Sn5jqXYZVzOI3xfi3QjcjS28z5h9T7wyw+FUtV5TtYpE99W6jl64uqYgIu1nr
 B/evl6Btdx7YpraR2ac5QTJZ/aXUfgU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-V7vkQfESMNuZGxqBIopKMQ-1; Mon,
 18 Nov 2024 10:12:39 -0500
X-MC-Unique: V7vkQfESMNuZGxqBIopKMQ-1
X-Mimecast-MFC-AGG-ID: V7vkQfESMNuZGxqBIopKMQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C270193E894; Mon, 18 Nov 2024 15:12:38 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.95])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C879B195E483; Mon, 18 Nov 2024 15:12:37 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2A1D21E692E; Mon, 18 Nov 2024 16:12:35 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v3 2/2] qapi: Move and rename qapi/qmp/dispatch.h to
 qapi/qmp-registry.h
Date: Mon, 18 Nov 2024 16:12:35 +0100
Message-ID: <20241118151235.2665921-3-armbru@redhat.com>
In-Reply-To: <20241118151235.2665921-1-armbru@redhat.com>
References: <20241118151235.2665921-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The general expectation is that header files should follow the same
file/path naming scheme as the corresponding source file. There are
various historical exceptions to this practice in QEMU, with one of
the most notable being the include/qapi/qmp/ directory.

include/qapi/qmp/dispatch.h corresponds mostly to qapi/qmp-registry.c.
Move and rename it to include/qapi/qmp-registry.h.

Now just qerror.h is left in include/qapi/qmp/.  Since it's deprecated
& (slowly) getting eliminated anyway, it isn't worth moving.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst                    | 2 +-
 include/qapi/{qmp/dispatch.h => qmp-registry.h} | 0
 monitor/monitor-internal.h                      | 2 +-
 qga/guest-agent-core.h                          | 2 +-
 qapi/qmp-dispatch.c                             | 2 +-
 qapi/qmp-registry.c                             | 2 +-
 stubs/qmp-command-available.c                   | 2 +-
 stubs/qmp-quit.c                                | 2 +-
 system/qdev-monitor.c                           | 2 +-
 scripts/qapi/commands.py                        | 2 +-
 10 files changed, 9 insertions(+), 9 deletions(-)
 rename include/qapi/{qmp/dispatch.h => qmp-registry.h} (100%)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 90d1dfa16c..ea26b8b473 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1854,7 +1854,7 @@ Example::
     #ifndef EXAMPLE_QAPI_INIT_COMMANDS_H
     #define EXAMPLE_QAPI_INIT_COMMANDS_H
 
-    #include "qapi/qmp/dispatch.h"
+    #include "qapi/qmp-registry.h"
 
     void example_qmp_init_marshal(QmpCommandList *cmds);
 
diff --git a/include/qapi/qmp/dispatch.h b/include/qapi/qmp-registry.h
similarity index 100%
rename from include/qapi/qmp/dispatch.h
rename to include/qapi/qmp-registry.h
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index 797e89a999..efce002334 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -28,7 +28,7 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-types-control.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 #include "qobject/json-parser.h"
 #include "qemu/readline.h"
 #include "sysemu/iothread.h"
diff --git a/qga/guest-agent-core.h b/qga/guest-agent-core.h
index b4e7c52c61..a536d07d0d 100644
--- a/qga/guest-agent-core.h
+++ b/qga/guest-agent-core.h
@@ -13,7 +13,7 @@
 #ifndef GUEST_AGENT_CORE_H
 #define GUEST_AGENT_CORE_H
 
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 #include "qga-qapi-types.h"
 
 #define QGA_READ_COUNT_DEFAULT 4096
diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
index e24ba9f0b6..fa95fcceac 100644
--- a/qapi/qmp-dispatch.c
+++ b/qapi/qmp-dispatch.c
@@ -16,7 +16,7 @@
 #include "block/aio.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 #include "qobject/qdict.h"
 #include "qobject/qjson.h"
 #include "qapi/qobject-input-visitor.h"
diff --git a/qapi/qmp-registry.c b/qapi/qmp-registry.c
index 485bc5e6fc..ac989074ed 100644
--- a/qapi/qmp-registry.c
+++ b/qapi/qmp-registry.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 void qmp_register_command(QmpCommandList *cmds, const char *name,
                           QmpCommandFunc *fn, QmpCommandOptions options,
diff --git a/stubs/qmp-command-available.c b/stubs/qmp-command-available.c
index 46540af7bf..8851faced1 100644
--- a/stubs/qmp-command-available.c
+++ b/stubs/qmp-command-available.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 bool qmp_command_available(const QmpCommand *cmd, Error **errp)
 {
diff --git a/stubs/qmp-quit.c b/stubs/qmp-quit.c
index a3ff47f7bd..8fb523e905 100644
--- a/stubs/qmp-quit.c
+++ b/stubs/qmp-quit.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-control.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 void qmp_quit(Error **errp)
 {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index ae4c786930..f0fff8f607 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -26,7 +26,7 @@
 #include "sysemu/runstate.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 #include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qobject/qstring.h"
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index f0aa13b5cf..74f341b2c7 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -346,7 +346,7 @@ def _begin_user_module(self, name: str) -> None:
     def visit_begin(self, schema: QAPISchema) -> None:
         self._add_module('./init', ' * QAPI Commands initialization')
         self._genh.add(mcgen('''
-#include "qapi/qmp/dispatch.h"
+#include "qapi/qmp-registry.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds);
 ''',
-- 
2.46.0


