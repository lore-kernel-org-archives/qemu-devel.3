Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B632CAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYtw-0004CZ-Rc; Tue, 16 Sep 2025 12:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYtv-00043j-4K
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:31 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYts-0006vR-UN
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:51:30 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id B47C220154FA;
 Tue, 16 Sep 2025 09:51:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B47C220154FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041487;
 bh=quGwFaWZlF9fQnMjHDBqRfcKVhre0mrLs82B3RESyuk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aRYD+s91SO0c9ZXsgB1Kn2du7hKqWM9lRaDCNSyiuYoiaQVAzKCEJJNYQCd/b0VGI
 kpv3Fuwl4Z8v6wlVT59UdCe+/LQ8prQ3hJEtRvD71wN0JthIRBqMZM64rdmVZCK5Tc
 qbBL6eu2n/aU8yqe8RexDMHrGe06U0Ta62JaGENU=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 24/27] qapi/accel: Allow to query mshv capabilities
Date: Tue, 16 Sep 2025 18:48:44 +0200
Message-Id: <20250916164847.77883-25-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Allow to query mshv capabilities via query-mshv QMP and info mshv HMP commands.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 hmp-commands-info.hx       | 13 +++++++++++++
 hw/core/machine-hmp-cmds.c | 15 +++++++++++++++
 hw/core/machine-qmp-cmds.c | 14 ++++++++++++++
 include/monitor/hmp.h      |  1 +
 include/system/hw_accel.h  |  1 +
 qapi/accelerator.json      | 29 +++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index 6142f60e7b..eaaa880c1b 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -307,6 +307,19 @@ SRST
     Show KVM information.
 ERST
 
+    {
+        .name       = "mshv",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show MSHV information",
+        .cmd        = hmp_info_mshv,
+    },
+
+SRST
+  ``info mshv``
+    Show MSHV information.
+ERST
+
     {
         .name       = "numa",
         .args_type  = "",
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 3a612e2232..682ed9f49b 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -163,6 +163,21 @@ void hmp_info_kvm(Monitor *mon, const QDict *qdict)
     qapi_free_KvmInfo(info);
 }
 
+void hmp_info_mshv(Monitor *mon, const QDict *qdict)
+{
+    MshvInfo *info;
+
+    info = qmp_query_mshv(NULL);
+    monitor_printf(mon, "mshv support: ");
+    if (info->present) {
+        monitor_printf(mon, "%s\n", info->enabled ? "enabled" : "disabled");
+    } else {
+        monitor_printf(mon, "not compiled\n");
+    }
+
+    qapi_free_MshvInfo(info);
+}
+
 void hmp_info_uuid(Monitor *mon, const QDict *qdict)
 {
     UuidInfo *info;
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 6aca1a626e..e24bf0d97b 100644
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
+
+    info->enabled = mshv_enabled();
+    info->present = accel_find("mshv");
+
+    return info;
+}
 
 /*
  * fast means: we NEVER interrupt vCPU threads to retrieve
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index ae116d9804..31bd812e5f 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -24,6 +24,7 @@ strList *hmp_split_at_comma(const char *str);
 void hmp_info_name(Monitor *mon, const QDict *qdict);
 void hmp_info_version(Monitor *mon, const QDict *qdict);
 void hmp_info_kvm(Monitor *mon, const QDict *qdict);
+void hmp_info_mshv(Monitor *mon, const QDict *qdict);
 void hmp_info_status(Monitor *mon, const QDict *qdict);
 void hmp_info_uuid(Monitor *mon, const QDict *qdict);
 void hmp_info_chardev(Monitor *mon, const QDict *qdict);
diff --git a/include/system/hw_accel.h b/include/system/hw_accel.h
index fa9228d5d2..55497edc29 100644
--- a/include/system/hw_accel.h
+++ b/include/system/hw_accel.h
@@ -14,6 +14,7 @@
 #include "hw/core/cpu.h"
 #include "system/kvm.h"
 #include "system/hvf.h"
+#include "system/mshv.h"
 #include "system/whpx.h"
 #include "system/nvmm.h"
 
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


