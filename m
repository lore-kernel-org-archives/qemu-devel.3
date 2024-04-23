Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F35C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 15:02:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzHeX-0008QE-G9; Tue, 23 Apr 2024 11:01:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8843110a50=aidan_leuck@selinc.com>)
 id 1rzHeT-0008PM-3V
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:01:45 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8843110a50=aidan_leuck@selinc.com>)
 id 1rzHeQ-0006uU-RS
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 11:01:44 -0400
Received: from pps.filterd (m0136171.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43NCmkrp018101;
 Tue, 23 Apr 2024 08:01:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=L/Dz3oqML6XdI4O1NjXIvAMq8sYNt88Fqs6/DXIpJ9k=; b=0mloRpyXrxCz
 SDBJX7rtkw7+0x90y6G/Gg98JJzj1QkXVasLZ9pybGb5feLhaLj2VWLpkYB4ascU
 /NAaNugzhtjqmPBni08EWEL7IrtZoswSXsiTNOpl6Ds4oiKwo7okGaUfTBcIaI2E
 jA6P4PqHzBN6AuZAKNi7AgMBGr8XliO1PnJl93m+E89BRUwlvsUTqN8Eyf2ZGZ5v
 3cWjRmpqJ9jNlGqk0jHh8aTnsOPm8y8GinwFhET5Dh8/vRw1Fg4XmK29eQmFRoK+
 4+hdVEUAZs188w3yUrhdkXE6mwFnk2TMQuw1vv3cX7rC6QY8h4c3JkPhO13OeoGt
 Wr1pYI+OQA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xmbmu9rts-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 08:01:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VG3ifkdHOndRr+c3kgQyE32Bi3osgO/ZEyJfNxVgHqdXpcQylmnIjjmJ8I/TVlgP5iyXQAl4iR5w91g3o6r1rNzESRqtGUyyh6Ya0auO5rh4SqUg5cul1tQ+2RktSfSe8+Me1JqzDKNwLBeSNAvIqYfX7nuqsFaAM8R9hbzHGoi6d7ZKPApl8fjU1Yg40GB8C085hUrQ0+A9AvJXgcTj39giZ+X4QL+QkKUyNaq27pCIpLJwdBi5dikPOPDusJp6LUL11EdHJ7AmIQQnSAUMZ4llqDxH7QR8gqSRmsgBWKmkdKP+R5xMUGX40G50fcf5b19PG586XvROCz8/k1AvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/Dz3oqML6XdI4O1NjXIvAMq8sYNt88Fqs6/DXIpJ9k=;
 b=QN+VTFTWJUli5aeH0CF0AqZsr6gqJinPFQQX0gcEJfkOIrcaSej+q9MqrVUIU4fhULS4WqiIIqIvoZLUqEzQVWo4oYNS2xAH98dZsqB1Q5/boqpSyIiKRsSmFG8XSjgOJI7xRsu8/atSjtokg9WSM/pSvP5lbae9gHjKxYgUrA5UmNNQZX7EEnfW86zs6oez56FkQEnolZI3QL1M4M1EPUY6buyw2Ktc/kLk1XcURvsIif8FSWcIcdO67rQepvchlQrg3l+47ghgrmsVsoQBY+EuS0RTeJm32qCMPMITO29h+iWIbOK1WkjzsKyOpqQGN9EbYdoDANZ8Gzj0V8J0sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Dz3oqML6XdI4O1NjXIvAMq8sYNt88Fqs6/DXIpJ9k=;
 b=sK5ueKE3aeDW+55EGO99BHYAZ3pVltMO9UYExSlKH9GufjOZFBwqx7yhrWKjAPJFuvyI8hZkrzFNzdZHPfsJ5qZTxE6DnvZVRexkv9Rf4e041D6oo37WitFnCHlxmFUearZsQiHBKah3McPL55BgxJpE4lUAokf2rHZBrzgUMWORr/mdO7Jk9eH12POtaQOx2AyMeZuFSVPib45YIGnjBFzDQeUujq3POPPCmrVLwloE2K6klvlj2jsL5QeOLGk5aXPi4RrTHDNqsRQ2CtlyBSArb/Vf6vGQ+25IdiWlxzrXL7Kzh9ekAQOL5naM8kewMfqqmXDruocNp+W2veSSqQ==
Received: from BL0PR01CA0027.prod.exchangelabs.com (2603:10b6:208:71::40) by
 LV3PR22MB5924.namprd22.prod.outlook.com (2603:10b6:408:274::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:01:35 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::6e) by BL0PR01CA0027.outlook.office365.com
 (2603:10b6:208:71::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 15:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 15:01:33 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 08:00:33 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v8 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Tue, 23 Apr 2024 09:00:04 -0600
Message-ID: <20240423150005.48175-2-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423150005.48175-1-aidan_leuck@selinc.com>
References: <20240423150005.48175-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|LV3PR22MB5924:EE_
X-MS-Office365-Filtering-Correlation-Id: 932494f7-ea7b-4293-30c4-08dc63a64432
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3hbEQH6j8rAAOCsdyHgiLL8wLL8aGYTIyZzwR+cvUwqkOWD11dAIalQivaSQ?=
 =?us-ascii?Q?x+Ty7Nbk+7/lfHgkaxP+0DZULDlCsnEt2bzyokC+hAbG+UQYLvEzb4ntGZiK?=
 =?us-ascii?Q?FlCSW2GOviVGnD2oD6J7TrX5aI6xGKxOenK3tqDBgdlixtmPcnEz8mqJCa5D?=
 =?us-ascii?Q?xEuXQ552E+CpgbJ3SZjaB2BpAADifK7X9SjtTe4l3RPqrBAqtkVIQeHkJSlI?=
 =?us-ascii?Q?MHoYDOE7VB7F+XtzC1cD0R7uMSvo7sw5+8nAGSERspA8DuZ1GlxcnuebtTeB?=
 =?us-ascii?Q?9VtyZi50R0XrqGxAfw4Pr/HT/QaRRaURIs5VAA0oslrezCpI4B7XWrGV+abx?=
 =?us-ascii?Q?fL/6E3hmCutjZ3D4QoGv/wPLRn4IT2GZlhzFrFJUXF3nyENuTbAL8JcjrdQ7?=
 =?us-ascii?Q?9/xWYpxWU4xFa2uXVlXB9Mlv61uS67avcUfhl+zOsM6aj2dVSd7UbfDBRGzf?=
 =?us-ascii?Q?1PaDwIi5PAL86PJFZVgiyZRCslTS10f35Br4jZz/lV9Oo/dHvj2ZL2EpLODN?=
 =?us-ascii?Q?uDPJTM36AUi7y69JjIrBdwRshwtmSiWBgw5pF3QqNkUs4Faw1/dvscJdqlbb?=
 =?us-ascii?Q?39FqQ0J2vOcrp38ooBJjUxeM7eo1JDbC5EzJFNskc9OQOoNVCK27GfvwMLuO?=
 =?us-ascii?Q?YzjgBhydXr7k1gUfryj6IaFZiO6wtE5M116xs3yQCCxOYUOzI10pXeSAv4xE?=
 =?us-ascii?Q?K4PN5kKlnZ+rIC0faZ2RvndJC/J15n6Q+as60BoO6dN8m7Ka2rjrpOeUh9Jw?=
 =?us-ascii?Q?l5lIpIXHr24gpkRTkH/fMWqOUupYw2jg+qW35a0jbM1zgF22jnaymmnTdKTF?=
 =?us-ascii?Q?4AQEDu/Bb4jpbcW0Iic3MhelK6mTSnPJKaq2biO4M4poShgmvmjx8KaJFaIu?=
 =?us-ascii?Q?UOhgEZy6YKJe+NQLmBurZjRFuUQLxxTX/E6v5WaAi4iu171qJDFsmvmtlzpq?=
 =?us-ascii?Q?UXI3rsvKb9xAXRlA20tnir3izmElpnau4BjHh+7NV/MSE4d5/kv065JEDUpS?=
 =?us-ascii?Q?Wqam/J2Li/nkZ8QKp9Xu+fZTEh35pD+QzEvM3ymPlX8PKRIziesYGf0xxml3?=
 =?us-ascii?Q?BKSotxSHjwFByd5x6Ick5rw6Qmg4RmG3OApIHkXq4dV0ltmV3XO4NalCTaxp?=
 =?us-ascii?Q?Kdq0asGpgRNvRGcVzmceu0e0cv8cBTvEDM6gvYg15+oD+pxJ0eCYis4ieLnG?=
 =?us-ascii?Q?8pmQcKcK2bLSOuW+kbQneymQWnIFOnKZOpmdXlFR1CcWQixwzEMqGrY0vT74?=
 =?us-ascii?Q?cV8uAdcdTBExDRdPv677vWNT4l60k7W4N7zGI9Cgs7Uy2lTGGekqAeBwqwz6?=
 =?us-ascii?Q?yuCAIFaVqvP91qJsqzfYsuBhq0gcBuly4/0jSC1lkiAlQ38xB/hU+o8jaOoA?=
 =?us-ascii?Q?NjDkLAo=3D?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 15:01:33.2441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932494f7-ea7b-4293-30c4-08dc63a64432
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB5924
X-Proofpoint-GUID: A7KUc0oXYGuwS_wLtwtgUUUZIK9y2R5D
X-Proofpoint-ORIG-GUID: A7KUc0oXYGuwS_wLtwtgUUUZIK9y2R5D
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230036
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=8843110a50=aidan_leuck@selinc.com;
 helo=mx0a-000e8d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: aidaleuc <aidan_leuck@selinc.com>

Signed-off-by: aidaleuc <aidan_leuck@selinc.com>
---
 qga/commands-common-ssh.c | 50 +++++++++++++++++++++++++++++++++++++++
 qga/commands-common-ssh.h | 10 ++++++++
 qga/commands-posix-ssh.c  | 47 +-----------------------------------
 qga/meson.build           |  1 +
 4 files changed, 62 insertions(+), 46 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h

diff --git a/qga/commands-common-ssh.c b/qga/commands-common-ssh.c
new file mode 100644
index 0000000000..537869fb98
--- /dev/null
+++ b/qga/commands-common-ssh.c
@@ -0,0 +1,50 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "commands-common-ssh.h"
+
+GStrv read_authkeys(const char *path, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *contents = NULL;
+
+    if (!g_file_get_contents(path, &contents, NULL, &err)) {
+        error_setg(errp, "failed to read '%s': %s", path, err->message);
+        return NULL;
+    }
+
+    return g_strsplit(contents, "\n", -1);
+}
+
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
+{
+    size_t n = 0;
+    strList *k;
+
+    for (k = keys; k != NULL; k = k->next) {
+        if (!check_openssh_pub_key(k->value, errp)) {
+            return false;
+        }
+        n++;
+    }
+
+    if (nkeys) {
+        *nkeys = n;
+    }
+    return true;
+}
+
+bool check_openssh_pub_key(const char *key, Error **errp)
+{
+    /* simple sanity-check, we may want more? */
+    if (!key || key[0] == '#' || strchr(key, '\n')) {
+        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
+        return false;
+    }
+
+    return true;
+}
diff --git a/qga/commands-common-ssh.h b/qga/commands-common-ssh.h
new file mode 100644
index 0000000000..14d955fa84
--- /dev/null
+++ b/qga/commands-common-ssh.h
@@ -0,0 +1,10 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qapi/qapi-builtin-types.h"
+
+GStrv read_authkeys(const char *path, Error **errp);
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
+bool check_openssh_pub_key(const char *key, Error **errp);
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 236f80de44..dd2ecb453a 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -9,6 +9,7 @@
 #include <locale.h>
 #include <pwd.h>
 
+#include "commands-common-ssh.h"
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
 
@@ -80,37 +81,6 @@ mkdir_for_user(const char *path, const struct passwd *p,
     return true;
 }
 
-static bool
-check_openssh_pub_key(const char *key, Error **errp)
-{
-    /* simple sanity-check, we may want more? */
-    if (!key || key[0] == '#' || strchr(key, '\n')) {
-        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
-        return false;
-    }
-
-    return true;
-}
-
-static bool
-check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
-{
-    size_t n = 0;
-    strList *k;
-
-    for (k = keys; k != NULL; k = k->next) {
-        if (!check_openssh_pub_key(k->value, errp)) {
-            return false;
-        }
-        n++;
-    }
-
-    if (nkeys) {
-        *nkeys = n;
-    }
-    return true;
-}
-
 static bool
 write_authkeys(const char *path, const GStrv keys,
                const struct passwd *p, Error **errp)
@@ -139,21 +109,6 @@ write_authkeys(const char *path, const GStrv keys,
     return true;
 }
 
-static GStrv
-read_authkeys(const char *path, Error **errp)
-{
-    g_autoptr(GError) err = NULL;
-    g_autofree char *contents = NULL;
-
-    if (!g_file_get_contents(path, &contents, NULL, &err)) {
-        error_setg(errp, "failed to read '%s': %s", path, err->message);
-        return NULL;
-    }
-
-    return g_strsplit(contents, "\n", -1);
-
-}
-
 void
 qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
                                   bool has_reset, bool reset,
diff --git a/qga/meson.build b/qga/meson.build
index 1c3d2a3d1b..4c3899751b 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -66,6 +66,7 @@ qga_ss.add(files(
   'guest-agent-command-state.c',
   'main.c',
   'cutils.c',
+  'commands-common-ssh.c'
 ))
 if host_os == 'windows'
   qga_ss.add(files(
-- 
2.34.1


