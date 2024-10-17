Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD34D2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Opy-0001Fp-8S; Thu, 17 Oct 2024 07:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Om6-00042o-KN
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Om1-0005wG-Gx
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DWsduU7/UvYKnigI0a5p/vXc9aHiy6b1wu7h9Pyw/FA=;
 b=KcnN85vots29uiEM4ag1fOmLv9IxjC0y/krHWoDWJfScEJ+2xsfn+nOUzOENcxrelN5owg
 S2U3y1Bi46n0LQwcqMFoJyfN4hlkI3DpYaFA2kHfSGmvoXZUeX5LByimh6F6UzS3aHIGpY
 p5qDxOketW5hgYz5J/kqakOcB8hLsLo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-7VCBXqKaNpGd609RTR3Zqw-1; Thu,
 17 Oct 2024 07:34:29 -0400
X-MC-Unique: 7VCBXqKaNpGd609RTR3Zqw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA3521956083
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:28 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD11219560A3; Thu, 17 Oct 2024 11:34:27 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 23/31] system: adapt to new import path for qobject data
 type headers
Date: Thu, 17 Oct 2024 12:33:35 +0100
Message-ID: <20241017113344.883424-24-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The qobject data type headers have moved from qapi/qmp/ to
qobject/.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/device_tree.c       | 2 +-
 system/dirtylimit.c        | 2 +-
 system/qdev-monitor.c      | 6 +++---
 system/rtc.c               | 1 +
 system/runstate-hmp-cmds.c | 2 +-
 system/vl.c                | 6 +++---
 6 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/system/device_tree.c b/system/device_tree.c
index 2e38259d34..446e49cef6 100644
--- a/system/device_tree.c
+++ b/system/device_tree.c
@@ -28,7 +28,7 @@
 #include "hw/boards.h"
 #include "qemu/config-file.h"
 #include "qapi/qapi-commands-machine.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "monitor/hmp.h"
 
 #include <libfdt.h>
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index ab20da34bb..644b0060ce 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/main-loop.h"
 #include "qapi/qapi-commands-migration.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/error.h"
 #include "sysemu/dirtyrate.h"
 #include "sysemu/dirtylimit.h"
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 44994ea0e1..e2f8abed8b 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -25,10 +25,10 @@
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-qdev.h"
-#include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/qdict.h"
+#include "qapi/qmp-registry.h"
+#include "qobject/qdict.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qstring.h"
+#include "qobject/qstring.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
diff --git a/system/rtc.c b/system/rtc.c
index 216d2aee3a..e3bc2095f9 100644
--- a/system/rtc.c
+++ b/system/rtc.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "qemu/timer.h"
diff --git a/system/runstate-hmp-cmds.c b/system/runstate-hmp-cmds.c
index 2df670f0c0..be1d676992 100644
--- a/system/runstate-hmp-cmds.c
+++ b/system/runstate-hmp-cmds.c
@@ -19,7 +19,7 @@
 #include "monitor/monitor.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-run-state.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/accel.h"
 
 void hmp_info_status(Monitor *mon, const QDict *qdict)
diff --git a/system/vl.c b/system/vl.c
index e83b3b2608..1e5525c1c7 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -31,9 +31,9 @@
 #include "hw/qdev-properties.h"
 #include "qapi/compat-policy.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qstring.h"
-#include "qapi/qmp/qjson.h"
+#include "qobject/qdict.h"
+#include "qobject/qstring.h"
+#include "qobject/qjson.h"
 #include "qemu-version.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
-- 
2.46.0


