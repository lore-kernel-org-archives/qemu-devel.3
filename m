Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C32C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 14:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk1pk-0003ck-Ug; Thu, 07 Aug 2025 10:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uk1pP-0002k1-BG
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:42:47 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uk1pN-00019Q-Fv
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 10:42:47 -0400
Received: from localhost.localdomain (unknown [167.220.208.72])
 by linux.microsoft.com (Postfix) with ESMTPSA id C891C201BC98;
 Thu,  7 Aug 2025 07:42:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C891C201BC98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1754577753;
 bh=TdslHxYMO2LnnYzjeOqT0wZpwVZ9Dbjhm6fZmwSEr9E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=KOl9ogjjrWrVwS4TRJacOZHY673ijxYl2aD+qVOQgCUD6gL2SsCtsg1BqxRj4Pcac
 CBcu93qPssY5OvGQ3idVqLcozthhOP5PPCBa7xYjVF9Vqc0+DNC6ad09V4yzaSV8q2
 3QC245Ubs3Pw2SyqwM9VQWoj2m6ugKoe6HrCm2s0=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Magnus Kulke <magnus.kulke@linux.microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Magnus Kulke <magnus.kulke@microsoft.com>,
 Cornelia Huck <cohuck@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Thomas Huth <thuth@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Cameron Esfahani <dirty@apple.com>, Wei Liu <wei.liu@kernel.org>,
 Wei Liu <liuwe@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 26/26] qapi/accel: Allow to query mshv capabilities
Date: Thu,  7 Aug 2025 16:39:51 +0200
Message-Id: <20250807143951.1154713-27-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
References: <20250807143951.1154713-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

From: Praveen K Paladugu <prapal@microsoft.com>

Allow to query mshv capabilities via query-mshv QMP command.

Signed-off-by: Praveen K Paladugu <prapal@linux.microsoft.com>
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
 qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e..024ddb8d2d 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -28,6 +28,20 @@
 #include "system/runstate.h"
 #include "system/system.h"
 #include "hw/s390x/storage-keys.h"
+#include <sys/stat.h>
+
+/*
+ * QMP query for MSHV
+ */
+MshvInfo *qmp_query_mshv(Error **errp)
+{
+    MshvInfo *info = g_malloc0(sizeof(*info));
+    struct stat st;
+
+    info->present = accel_find("mshv");
+    info->enabled = (stat("/dev/mshv", &st) == 0);
+    return info;
+}
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index fb28c8d920..c2bfbc507f 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -54,3 +54,32 @@
 { 'command': 'x-accel-stats',
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
+
+##
+# @MshvInfo:
+#
+# Information about support for MSHV acceleration
+#
+# @enabled: true if MSHV acceleration is active
+#
+# @present: true if MSHV acceleration is built into this executable
+#
+# Since: 10.0.92
+##
+{ 'struct': 'MshvInfo', 'data': {'enabled': 'bool', 'present': 'bool'} }
+
+##
+# @query-mshv:
+#
+# Return information about MSHV acceleration
+#
+# Returns: @MshvInfo
+#
+# Since: 10.0.92
+#
+# .. qmp-example::
+#
+#     -> { "execute": "query-mshv" }
+#     <- { "return": { "enabled": true, "present": true } }
+##
+{ 'command': 'query-mshv', 'returns': 'MshvInfo' }
-- 
2.34.1


