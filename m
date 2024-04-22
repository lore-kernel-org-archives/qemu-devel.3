Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F69FC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 18:25:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryyLY-0007Cn-1e; Mon, 22 Apr 2024 14:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8842f65a37=aidan_leuck@selinc.com>)
 id 1ryyLW-0007CN-E8
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 14:24:54 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8842f65a37=aidan_leuck@selinc.com>)
 id 1ryyLU-0001C6-EI
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 14:24:54 -0400
Received: from pps.filterd (m0136169.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43MD0mbj006751;
 Mon, 22 Apr 2024 11:24:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=me62+b6suYCCxRPp3P3QXxAGdpJR1MECJQmSW37H604=; b=YiVMCUbB0BnV
 YEYnU6Um7geEwhkyxxJnIMyamomDF8ZBvA6aEAavu7pZ9xt0XTS3TCbqXj8uHwe6
 76CAmOdAXLCABarBvdbNVv4nPGLoiFVGZav5/YcYQ/SGnwbcaMagPO5EIA2XmG9s
 T150h8eO646EFbJ73M3pUs2rKlWHlJfrg5s4gZzfoYrvwXsvBgRMXQQerZsFMTeU
 Tn/ArUnbNZ4LVGIuIOwrkT9YUWpQ6pyJLkw96QMmeTzPHEWKj2QSEUee6BOM3xM7
 LquvcHZBzPNR8HT2Kry3wHeKjeW8Wri1cgqOqQeA5KgrA+ReLG+fGiS7+4KcY6iD
 tLMvDfxzew==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xmcjcs50t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Apr 2024 11:24:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H+K8w+oS/GtJ529h5CEErh+gSXQQdEqaF9tbI6pwJ9f0AVUw2ZRfbbsg0O0pzS/7lx5w2mGkPlMt6lXGYjJNbuZHLAv7ZyYTOsW8YeS9J1u/mSw6EvGmtj89S38wdHCSDychfep7GgIjFHbPLY7w6Jjn3BP3ka4MObbOMc0jBYWpMv5mmdKT0LtrFrr8w3xLycTZ26DdyrFcDS0Cxg9bff8GpuQHXsDpEp7x1qb7MlkMeFU/lQwzcwOMuKKZoHazEnyvE6EQq41ryNxUeW7Eb5u2meYB5Tg28himkgwJ6eJYlu+ylQJP2qUyDEWRfmQ3u0xWg8RuIFwwOiepg69oYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=me62+b6suYCCxRPp3P3QXxAGdpJR1MECJQmSW37H604=;
 b=MFNrhWU+udizhf8GeSxcFnGdiSqK36irgbhTDdwmGVTvp0LG7lARbmYL5/bf5k9MTg6STkaIctYLabiQPoLKGT7A7TG3eK766/psAwiHCiPmfFGjyVeuL/g/s1x4oQGchte5WtdFik3us3Rns28W22jATtuV5tQ9/joP8vQ0vciVgtHqD6fQCquNIlnfenadQrFKw2F02uqhM4DPG4KS47pC5cqCBEWhswUNZqzmQA2DZkB3LERIpj52imx/JQzBRbe9LSDDuyRD7/Y5+SZTQYlp2lepww/2RTnN5POo3V57PCTt9AvxIml6qgQlQhUtzJek8tNjB9OPq3ODSsezew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me62+b6suYCCxRPp3P3QXxAGdpJR1MECJQmSW37H604=;
 b=xRp9ZDXWz0w0MKa7e+OGCN2yTGuw6yD45wOAbYkQD/95ZlpzBgeHQWVPjzPDjlF13szSXBV0DB7enSzT7ZwYwvxxnHLjt7gjkjGOJqIVDa8aTdnQXcQveouHxdvTr6vQqn7WB/gcsNuQnijT+dH6BIrOg0o+ekQ9eOTq8dFm+Xd6OfkxgQ2qGkukdz/mrTC8crSJZEs+sosYUwZQhwWFrtn9/mNPodSnFdmR46+55+2Fr+peroF/X9CQS2JQulxcW7paVqRd1qxExiW2lmn93li/nTAhVThALHYSf1hyN+AZ1qGCaeI6WSQsC3DFOFhmxpaY6//1WXqKGMfI8LU4dA==
Received: from CH3P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::7)
 by LV8PR22MB5824.namprd22.prod.outlook.com (2603:10b6:408:258::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 18:24:47 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::b9) by CH3P220CA0005.outlook.office365.com
 (2603:10b6:610:1e8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29 via Frontend
 Transport; Mon, 22 Apr 2024 18:24:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 18:24:46 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 22 Apr 2024 11:24:43 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v7 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Mon, 22 Apr 2024 12:24:12 -0600
Message-ID: <20240422182413.230378-2-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240422182413.230378-1-aidan_leuck@selinc.com>
References: <20240422182413.230378-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|LV8PR22MB5824:EE_
X-MS-Office365-Filtering-Correlation-Id: 30719748-2f96-4393-536b-08dc62f97d72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xsMSgThxFGwZH0lyAW2d6zG9TpETD6OeVo5meXFDkRvgF/GfGEiXkwuhluNY?=
 =?us-ascii?Q?3VbcB9TG0g7hqN8drrbcIQzePrxedY45A04WhpuG21IFVeZHHJazEjvDSPUZ?=
 =?us-ascii?Q?wVIn9+Icbov82yukQJXVFLVNbrSyLomyMdVPfzGuKsDg0cDB0kldUoB0mmyO?=
 =?us-ascii?Q?oe92caiSrEWvCTq94hdaKC0csMN1yIDTjDuWoCGurRRWS9KGpwhGLyCf7kwA?=
 =?us-ascii?Q?QMRvTrgagawUY35rH1kvQC01Fc8HFNSF0r482Tee+B2t/dDfwL7r6QMnB4+X?=
 =?us-ascii?Q?BDa8mPhibimDA45F+WSQ9v4RTeis9+vm3atDL3ugZaoFAqxTJ8xMz9hR97yv?=
 =?us-ascii?Q?ZyL4ErEkmMfVj9jaeGwpIlhO6vgdQwqWvf7zXl0TEuw1WcAI1MGOAHiK8qTD?=
 =?us-ascii?Q?aKi/Cu99bn5G7c8Y4RrwonkMhCSMexd3mKb4S1h4POrKwiW6onbBgUaBFqop?=
 =?us-ascii?Q?72ZqXIHy08SzzNSTktbnu+mzTc+d6YJLs0zu4r72g5SfkF1UKHyY0w4k9aYp?=
 =?us-ascii?Q?WOOBevGesD/ZrcTGlXcNZBkCr0GSUlHyWgDQZLwsAwjUxSZTgiqHFpcAlosP?=
 =?us-ascii?Q?vH9wmw/+C/rsYQZryVBgAKF+0ruLXwY07hMwHdjxfSoQ2qF8NgP+/3b14EGQ?=
 =?us-ascii?Q?s7xkAatvkTIPdLy3LuQ4vLfBDF17k3o9rkyX/FodnwFpkf8defpK0b5rJwDe?=
 =?us-ascii?Q?kk3U+vJH51qYvAoG4/W9atqENYzUgSrXehXUvESai0Ulr9hvyLNOp66z7Yjh?=
 =?us-ascii?Q?yGR4GwpngT7cCBdvg6mwacoZMsv6aNn9TcpA9oJIZHJJNem4jbVYCUClJUv4?=
 =?us-ascii?Q?SivQpu84E99LIwMq7p/uAYe+uuLtniuIhz+ycy8t2U47MxxQWYarpU0+958T?=
 =?us-ascii?Q?r6kJeT8GT33icNhb4rfzePYTwSwcY908g2RVSVCrSxo5riIZNDKVNPMIqd6m?=
 =?us-ascii?Q?tld7qoj+WZctonoH2OUshROoM0eG5goNkb0mIjmSxDP4X7tgUTcHOEpY0tn+?=
 =?us-ascii?Q?SyAko4ZmXgKTMziyJrR3gBiDCUAwqyFLYLPtMx3mlGSVTIydtqCRUf0kvaXz?=
 =?us-ascii?Q?ha0ikkjNlJFfyMfVVR5wAklgWPmyvhK6XzWKcz/7HeNUrR4gOR/9eybseJfl?=
 =?us-ascii?Q?WxvAfocFZ2J62p7Jtj+1e+smjBAwg9mS5aqPHa5Uh77bU1jb9GELESi9bNrH?=
 =?us-ascii?Q?y0ewtmfZ4zwUtKjoKWePt7c1S0dsVtbBQMAJl4xPuV2V1vXYE7xb6xUan/e+?=
 =?us-ascii?Q?GCHxvQLL/DOgJWRZzHMLUZnoUrv2QI3ho/QVL98jSRfwe1Penqyziemi9l1M?=
 =?us-ascii?Q?IIgToY0vQkz6ExdwViGeufoPlB2BOyIixUpoViw8kXTVzMgK6o6GPZLXB9sV?=
 =?us-ascii?Q?JDk5rRo=3D?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 18:24:46.9072 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30719748-2f96-4393-536b-08dc62f97d72
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR22MB5824
X-Proofpoint-ORIG-GUID: ayhFWbsKmpkP_NBoZiyVuiGiJnAKPrQC
X-Proofpoint-GUID: ayhFWbsKmpkP_NBoZiyVuiGiJnAKPrQC
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0
 impostorscore=0 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220078
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=8842f65a37=aidan_leuck@selinc.com;
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
2.44.0


