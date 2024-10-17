Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC822D2127F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2024 11:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1OnX-0005TH-Lg; Thu, 17 Oct 2024 07:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Oli-0003zl-Ar
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1Olf-0005tx-CA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2024 07:34:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729164850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9rdXs9fE+HwNk99lPb/63Dz7YXp6p4OVaQNurfWWpWE=;
 b=I7vxcCcAbDdF4kGADsIu0ePntO++i/w6QQ2UmX0A10VmDnrAurw8ObXhxs+rOSB/8yJvoJ
 6RgykjE3AQIXrQlcwLVcod3cHUMLSbZ8bUV6G9u6b0reD+vNnBWxDwBVcpueHe2uKmavbD
 QXmCGAaTkD0X0DhB23zeZLMzEjxVTfI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-q13zM4dmOuGoFDedDIRETg-1; Thu,
 17 Oct 2024 07:34:09 -0400
X-MC-Unique: q13zM4dmOuGoFDedDIRETg-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42BFA1955D9D
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2024 11:34:08 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.94])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 394B019560A2; Thu, 17 Oct 2024 11:34:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 11/31] migration: adapt to new import path for qobject data
 type headers
Date: Thu, 17 Oct 2024 12:33:23 +0100
Message-ID: <20241017113344.883424-12-berrange@redhat.com>
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
 migration/dirtyrate.c          | 2 +-
 migration/migration-hmp-cmds.c | 2 +-
 migration/migration.c          | 2 +-
 migration/migration.h          | 2 +-
 migration/options.c            | 2 +-
 migration/vmstate.c            | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 233acb0855..14b28a59fc 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -24,7 +24,7 @@
 #include "dirtyrate.h"
 #include "monitor/hmp.h"
 #include "monitor/monitor.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "sysemu/kvm.h"
 #include "sysemu/runstate.h"
 #include "exec/memory.h"
diff --git a/migration/migration-hmp-cmds.c b/migration/migration-hmp-cmds.c
index 20d1a6e219..69c86780e3 100644
--- a/migration/migration-hmp-cmds.c
+++ b/migration/migration-hmp-cmds.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
-#include "qapi/qmp/qdict.h"
+#include "qobject/qdict.h"
 #include "qapi/string-input-visitor.h"
 #include "qapi/string-output-visitor.h"
 #include "qemu/cutils.h"
diff --git a/migration/migration.c b/migration/migration.c
index 021faee2f3..b615f93a1a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -43,7 +43,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-events-migration.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "qemu/rcu.h"
 #include "postcopy-ram.h"
 #include "qemu/thread.h"
diff --git a/migration/migration.h b/migration/migration.h
index 38aa1402d5..c61c259a1c 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -17,7 +17,7 @@
 #include "exec/cpu-common.h"
 #include "hw/qdev-core.h"
 #include "qapi/qapi-types-migration.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
 #include "io/channel.h"
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..4bfa2ac236 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -19,7 +19,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-visit-migration.h"
 #include "qapi/qmp/qerror.h"
-#include "qapi/qmp/qnull.h"
+#include "qobject/qnull.h"
 #include "sysemu/runstate.h"
 #include "migration/colo.h"
 #include "migration/misc.h"
diff --git a/migration/vmstate.c b/migration/vmstate.c
index ff5d589a6d..82d64a6988 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -15,7 +15,7 @@
 #include "migration/vmstate.h"
 #include "savevm.h"
 #include "qapi/error.h"
-#include "qapi/qmp/json-writer.h"
+#include "qobject/json-writer.h"
 #include "qemu-file.h"
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
-- 
2.46.0


