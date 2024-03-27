Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078DDC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpW5d-0002Wb-4w; Wed, 27 Mar 2024 12:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpW5a-0002WJ-0c
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:25:22 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78160ec3c5=aidan_leuck@selinc.com>)
 id 1rpW5Y-0003Hl-4Z
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:25:21 -0400
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42RBxLoc027404; Wed, 27 Mar 2024 09:25:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=nHxzIP9SIcafElNQYMriMUzIFK5M0TtW0K51Hbem8tU=; b=MTcxUGHrRp4F
 8KrdanbNlyoS6qv+7GLYRKMNGdxQwRfDsAqtEcgvqYXfqcCSFry1KxAZL3DzlZzi
 7bqVk0MCNH6CCeb39ZiMyt2rMpDxuHQR9LX9CmypM+L8ciCyHshWlVI8Nkkc9o71
 VRcjh7JyYja2m8K8b2y/ECd5BG6nOIokAfc0YFZTyrorAxayOqxGrA/kIRNb0UJn
 8h10moCRRKA8txkqsGY2FYj5C7eBmWCCUsGhv4yQWk3sMNgJhTrJHfcm3Ag1jUce
 5zxK4p9AXQUDs4DupA8JiHm/EbFR4AQCuDX/smiDLIz66usxbpUoKUt6ZwiN+4pm
 7HDVb/uf+A==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x4dkr8b93-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 27 Mar 2024 09:25:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4zPG7kCQeTB92p7j3ikFxpseVxGY2F78snY5mx6PLHtVmckJm10VzbeVmQDkAbQqlDraCyDsfxp2WOHPZ8ouf4yqdBFXbGe4s7acLb9s2tiRkrZk7iLdbPisbwbnrWT5/WEhFQKI84epIg6cXXGqg8NYCLElTYiYlbleInw9pjcOxTRceb8J3vLmF/DD1K3BXhv93fmoH2H1XrjKeNOa2aNX65Go8h+lZlIpfvOOJ6jrTRJgyw4I3QYIpzfmXoO5RYzLFsmfX+2hjZm3X8ddVvElEcyWGkAz16H/k7dr+2CJi8CLJx3zYDeH3JaQmRCa1r/aL7sFT5ZrMsmkDso/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHxzIP9SIcafElNQYMriMUzIFK5M0TtW0K51Hbem8tU=;
 b=kS8krY+C2SqfOh9slKk1FkqfNS1NyWRzrr05l3SoB+DAElUKp2DzNepenVnyPHPgzsc5Xcc4KEByQsZ4PC6U1tQTIGeLMmd2NW96/JWjkxg5MhHK5LC6kPEjsoHEeaPyLdBSyyvr3PwI2mubRwKSBV3uBe/YFRwnniLsryCTzc8z/fDi+caJz3eDwmlowB73m3Dt/Gsh4WC4jfvdkCu+iIv2oHTzSZCr2jL/Csbjq5Zdq+PVaq6C6PesnWb5ueNd2SM0MdXz6xkCXFmXhMgN3U+ey234bule05wb/PuIvJnaB1QclmI2PvOj5WTpZulD82v7UsoyJ6EnIi9Gsw7MEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHxzIP9SIcafElNQYMriMUzIFK5M0TtW0K51Hbem8tU=;
 b=r5GVpvAay1TiHpD6Bei5dcTHGrJ8wcb6iYB0v8z060MwLmB6oDBuiYh6TVpqQ2zXiTh2dY0bBGjfrpX4mHb6xAoG6FiR0QXvTw7km7baTxzouNf4eqt7KTq2JrqLtrKWMO0iLE3Jlt+4By8WVafYuZch6MIcVifKxvCjNIeyzsTZRoa92P+UiI9wDzKsir14icyl6XZLy+N/AnUWO7XpWzSqeJHH6bo+RIcB4QMmrWq8oxG3oyRsRS6IMtl551ObOsDnQkt6qnm6MVDMOcTOfclwbUZBY1LLqft0zN3tG1W/QgVekZ6deLWHc4HJ/ai52MU2u/E9hkfc4G60sWDBJg==
Received: from CH0PR03CA0210.namprd03.prod.outlook.com (2603:10b6:610:e4::35)
 by SA1PR22MB5132.namprd22.prod.outlook.com (2603:10b6:806:3d8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 16:25:16 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::7c) by CH0PR03CA0210.outlook.office365.com
 (2603:10b6:610:e4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Wed, 27 Mar 2024 16:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 27 Mar 2024 16:25:15 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 27 Mar 2024 09:25:14 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <berrange@redhat.com>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v4 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Wed, 27 Mar 2024 10:24:49 -0600
Message-ID: <20240327162450.888453-2-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327162450.888453-1-aidan_leuck@selinc.com>
References: <20240327162450.888453-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|SA1PR22MB5132:EE_
X-MS-Office365-Filtering-Correlation-Id: ee387246-f27d-4acb-ac3b-08dc4e7a7c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eQgebO5AXTHxf6nxdf9vhImMuU5G0LkuUU7JE3+TlmFpFL0Tt/NdQ5FtL8byUkTmqT+TIsjGc3gwfQjUBYk6OPSuPKbdxIqce8jEttQTjXCBYzK3NZAB7WPP51Eabe0Qqb1o1f7x43JGpL5OBmVz9dcCUMmEalRJl9u/I08NBVu3zWJIi3mlNAqBEyuqojegZ9wzm4yo2mgFTd9YifZloDoYl/aOEbhDS6dVWj855az9W+CjC82m5F8F4s7aXoBBjqkMZYuxFbRsBmJk8eAtwhxtlK7qykSt052TSlbxIOt6CQYTrXIEZ1rrKuEmW6J/q3yTkvJD/bTEmxp1adtAe16jsaZtr7kLNNTZ/INmrRLK/VMec/SDsyZlMxSPVaJ3hykBRo5KyTPxwjzazVLGSGvqwvAwTwxvO4CJOJpK/FBNvqXVJdIy8cMJl5PHAeZfMoISEkxhUeCzVzhtLpIctc5leNlN5sQi7borWJZj0Oo34JQubCAKe28rR/5lNjgsAac/StESVAqZywbeyBOFoSR85WkuqkfF66MnNg5glGbV7mljjKhiERtgygFYGCWVKSLDm+HQI3VkTsgqRCtvq/t74ZM0iF2zGulDcTtCv2inWZ9L3F4OWS6lHBUUqgduKr3e4saXNwlfRA27iebgnnKB4KFjYheLM+7ufMtXwTElSl+r8BExYWR2MXZYfZIoZoQjlX75rOy/Wk46eW5zqH2XTRr0vAIEgnZZ2Lq9fnCodTWLmvm0l2MjPspezoi0
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 16:25:15.8860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee387246-f27d-4acb-ac3b-08dc4e7a7c6a
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5132
X-Proofpoint-ORIG-GUID: 2ETuCZKHsFxz7n7Mg7UT1Il3O1oYomXO
X-Proofpoint-GUID: 2ETuCZKHsFxz7n7Mg7UT1Il3O1oYomXO
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270114
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=78160ec3c5=aidan_leuck@selinc.com;
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
 qga/commands-common-ssh.c | 49 +++++++++++++++++++++++++++++++++++++
 qga/commands-common-ssh.h | 12 +++++++++
 qga/commands-posix-ssh.c  | 51 +++------------------------------------
 qga/meson.build           |  1 +
 4 files changed, 65 insertions(+), 48 deletions(-)
 create mode 100644 qga/commands-common-ssh.c
 create mode 100644 qga/commands-common-ssh.h

diff --git a/qga/commands-common-ssh.c b/qga/commands-common-ssh.c
new file mode 100644
index 0000000000..5fcf589206
--- /dev/null
+++ b/qga/commands-common-ssh.c
@@ -0,0 +1,49 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
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
index 0000000000..04621dfb7b
--- /dev/null
+++ b/qga/commands-common-ssh.h
@@ -0,0 +1,12 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qapi/error.h"
+#include <qga-qapi-types.h>
+#include <stdbool.h>
+
+GStrv read_authkeys(const char *path, Error **errp);
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
+bool check_openssh_pub_key(const char *key, Error **errp);
diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 236f80de44..c82ccfe629 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -9,12 +9,13 @@
 #include <locale.h>
 #include <pwd.h>
 
+#include "commands-common-ssh.h"
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
 
 #ifdef QGA_BUILD_UNIT_TEST
-static struct passwd *
-test_get_passwd_entry(const gchar *user_name, GError **error)
+ static struct passwd *
+ test_get_passwd_entry(const gchar *user_name, GError **error)
 {
     struct passwd *p;
     int ret;
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


