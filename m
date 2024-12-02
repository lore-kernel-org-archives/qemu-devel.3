Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E9FD78321
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 13:40:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI6bg-00080f-5P; Mon, 02 Dec 2024 08:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Ln-00081j-Re
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:41 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tI6Li-0005n9-JI
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 08:20:28 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B26WwEN012851;
 Mon, 2 Dec 2024 13:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :date:from:in-reply-to:message-id:references:subject:to; s=
 corp-2023-11-20; bh=n8GAaLWehzVdaQSW0sNL/nudX90REaKNsDMkGSNfea0=; b=
 Jv7Dgvg95RLlIl4HAF60VxuJkDXlx0WXTNfXzEFicnWI4KUkyXN9ORgS9T5SarS2
 yQqSozzAJPvPKB7rRx9dBhVRyqoGzvsbkBMJ+fiMAwQIxDqY1wLhX+bDXsA581r+
 OioTeihSAL51YEAMjqBhJQ6TPhVEaR1/N45qBJ2xPmET9T1FZXrXAryT6K1nKOWB
 PQTCfHq49p7VZtY4CzJ7lznXSWSe1WN7+PgHTXHG8mfOCcsqfmoNn13yq7TyKj7G
 +OvJnM05qCQSIphMu8uykSTxd1ZPaSN7YIwxqZEFMy4bgYbynsS93JmFV7wr43Oc
 arG4xDDN65hoyfinErSTHw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 437s4c3348-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:22 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4B2DIXe5032684; Mon, 2 Dec 2024 13:20:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 437s56jtra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 02 Dec 2024 13:20:21 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B2DKCEr032806;
 Mon, 2 Dec 2024 13:20:20 GMT
Received: from ca-dev63.us.oracle.com (ca-dev63.us.oracle.com [10.211.8.221])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with
 ESMTP id 437s56jthv-11; Mon, 02 Dec 2024 13:20:20 +0000
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>
Subject: [PATCH V4 10/19] migration: cpr channel
Date: Mon,  2 Dec 2024 05:20:02 -0800
Message-Id: <1733145611-62315-11-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-02_09,2024-12-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412020116
X-Proofpoint-ORIG-GUID: XlFtZckGl6MIUh_6UZDggTBP5DKiiIY3
X-Proofpoint-GUID: XlFtZckGl6MIUh_6UZDggTBP5DKiiIY3
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add the 'cpr' channel type, and stash the incoming cpr channel for use
in a subsequent patch.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/migration/cpr.h |  3 +++
 migration/cpr.c         | 15 +++++++++++++++
 qapi/migration.json     |  3 ++-
 system/vl.c             |  6 ++++++
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/migration/cpr.h b/include/migration/cpr.h
index 201d66d..e833fae 100644
--- a/include/migration/cpr.h
+++ b/include/migration/cpr.h
@@ -17,6 +17,9 @@ void cpr_save_fd(const char *name, int id, int fd);
 void cpr_delete_fd(const char *name, int id);
 int cpr_find_fd(const char *name, int id);
 
+void cpr_set_cpr_channel(MigrationChannel *channel);
+MigrationChannel *cpr_get_cpr_channel(void);
+
 int cpr_state_save(MigrationChannel *channel, Error **errp);
 int cpr_state_load(Error **errp);
 void cpr_state_close(void);
diff --git a/migration/cpr.c b/migration/cpr.c
index 1e2878c..f4a795f 100644
--- a/migration/cpr.c
+++ b/migration/cpr.c
@@ -116,6 +116,21 @@ QIOChannel *cpr_state_ioc(void)
     return qemu_file_get_ioc(cpr_state_file);
 }
 
+static MigrationChannel *cpr_channel;
+
+void cpr_set_cpr_channel(MigrationChannel *channel)
+{
+    if (cpr_channel) {
+        qapi_free_MigrationChannel(cpr_channel);
+    }
+    cpr_channel = channel;
+}
+
+MigrationChannel *cpr_get_cpr_channel(void)
+{
+    return cpr_channel;
+}
+
 int cpr_state_save(MigrationChannel *channel, Error **errp)
 {
     int ret;
diff --git a/qapi/migration.json b/qapi/migration.json
index a605dc2..a26960b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1578,11 +1578,12 @@
 # The migration channel-type request options.
 #
 # @main: Main outbound migration channel.
+# @cpr: cpr state channel.
 #
 # Since: 8.1
 ##
 { 'enum': 'MigrationChannelType',
-  'data': [ 'main' ] }
+  'data': [ 'main', 'cpr' ] }
 
 ##
 # @MigrationChannel:
diff --git a/system/vl.c b/system/vl.c
index 2c24c60..40e049e 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -77,6 +77,7 @@
 #include "hw/block/block.h"
 #include "hw/i386/x86.h"
 #include "hw/i386/pc.h"
+#include "migration/cpr.h"
 #include "migration/misc.h"
 #include "migration/snapshot.h"
 #include "sysemu/tpm.h"
@@ -1834,6 +1835,11 @@ static void incoming_option_parse(const char *str)
         qobject_unref(obj);
         visit_type_MigrationChannel(v, "channel", &channel, &error_fatal);
         visit_free(v);
+
+        if (channel->channel_type == MIGRATION_CHANNEL_TYPE_CPR) {
+            cpr_set_cpr_channel(channel);
+            return;
+        }
     } else if (!strcmp(str, "defer")) {
         channel = NULL;
     } else {
-- 
1.8.3.1


