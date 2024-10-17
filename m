Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25D6ED2127C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1Omk-0004EP-OP; Thu, 17 Oct 2024 07:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Olj-000402-RO
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oli-0005uH-2j
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tJplTBwwEUHeKA6av/wUGRlLDjx56M2IPEFpXeUTY0=;
 b=Qbqh7sz756OxZZ/OxynoiToJEhseDTVbB9kP6Q+H55sqTXnXynAlgPkMOC3obvZbaDyovd
 wO+N4N2bTTt4g5eSsiATmhjKmUQa8BL5RpAki+feA+shb/1h4mDHFXlGMETPcN5HWgd7+K
 pQc3rMDu8MJ+F1cLbTAaVaRppEug5mw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-7RWwlEZcOGuWAUZythq2rA-1; Thu,
 17 Oct 2024 07:34:10 -0400
X-MC-Unique: 7RWwlEZcOGuWAUZythq2rA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AA0A11955DC4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:09 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1A0F19560A2; Thu, 17 Oct 2024 11:34:08 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 12/31] monitor: adapt to new import path for qobject data
 type headers
Date: Thu, 17 Oct 2024 12:33:24 +0100
Message-ID: <20241017113344.883424-13-berrange@redhat.com>
In-Reply-To: <20241017113344.883424-1-berrange@redhat.com>
References: <20241017113344.883424-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
 monitor/hmp-cmds-target.c  | 2 +-
 monitor/hmp-cmds.c         | 2 +-
 monitor/hmp.c              | 4 ++--
 monitor/monitor-internal.h | 4 ++--
 monitor/monitor.c          | 2 +-
 monitor/qemu-config-qmp.c  | 2 +-
 monitor/qmp.c              | 6 +++---
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index ff01cf9d8d..a79418f52b 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -29,7 +29,7 @@
 #include "monitor/hmp-target.h"
 #include "monitor/monitor-internal.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/hw_accel.h"
 
 /* Set the current CPU defined by the user. Callers must hold BQL. */
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index f601d06ab8..c353c52ec5 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -25,7 +25,7 @@
 #include "qapi/qapi-commands-control.h"
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/cutils.h"
 #include "qemu/log.h"
 #include "sysemu/sysemu.h"
diff --git a/monitor/hmp.c b/monitor/hmp.c
index 460e8832f6..dc33fec8c3 100644
--- a/monitor/hmp.c
+++ b/monitor/hmp.c
@@ -27,8 +27,8 @@
 #include "hw/qdev-core.h"
 #include "monitor-internal.h"
 #include "monitor/hmp.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qnum.h"
+#include "qobject/qdict.h"
+#include "qobject/qnum.h"
 #include "qemu/config-file.h"
 #include "qemu/ctype.h"
 #include "qemu/cutils.h"
diff --git a/monitor/monitor-internal.h b/monitor/monitor-internal.h
index cb628f681d..efce002334 100644
--- a/monitor/monitor-internal.h
+++ b/monitor/monitor-internal.h
@@ -28,8 +28,8 @@
 #include "chardev/char-fe.h"
 #include "monitor/monitor.h"
 #include "qapi/qapi-types-control.h"
-#include "qapi/qmp/dispatch.h"
-#include "qapi/qmp/json-parser.h"
+#include "qapi/qmp-registry.h"
+#include "qobject/json-parser.h"
 #include "qemu/readline.h"
 #include "sysemu/iothread.h"
 
diff --git a/monitor/monitor.c b/monitor/monitor.c
index db52a9c7ef..928234a608 100644
--- a/monitor/monitor.c
+++ b/monitor/monitor.c
@@ -28,7 +28,7 @@
 #include "qapi/opts-visitor.h"
 #include "qapi/qapi-emit-events.h"
 #include "qapi/qapi-visit-control.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "sysemu/qtest.h"
diff --git a/monitor/qemu-config-qmp.c b/monitor/qemu-config-qmp.c
index 24477a0e44..9a3b183602 100644
--- a/monitor/qemu-config-qmp.c
+++ b/monitor/qemu-config-qmp.c
@@ -2,7 +2,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qlist.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
 #include "hw/boards.h"
diff --git a/monitor/qmp.c b/monitor/qmp.c
index 5e538f34c0..2f46cf9e49 100644
--- a/monitor/qmp.c
+++ b/monitor/qmp.c
@@ -28,9 +28,9 @@
 #include "monitor-internal.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-control.h"
-#include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qjson.h"
-#include "qapi/qmp/qlist.h"
+#include "qobject/qdict.h"
+#include "qobject/qjson.h"
+#include "qobject/qlist.h"
 #include "trace.h"
 
 /*
-- 
2.46.0


