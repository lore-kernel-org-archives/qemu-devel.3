Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1221C54E68
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKyE-0004QK-TW; Thu, 21 Mar 2024 12:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78105fa443=aidan_leuck@selinc.com>)
 id 1rnKy6-0004O4-1J
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:08:39 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78105fa443=aidan_leuck@selinc.com>)
 id 1rnKy3-00077j-Dn
 for qemu-devel@nongnu.org; Thu, 21 Mar 2024 12:08:37 -0400
Received: from pps.filterd (m0136173.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42LEQHSt029058; Thu, 21 Mar 2024 09:08:34 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=KswmGm3JtExoIy164be1K6CNpkIJgOu/dDlZwu9/ufs=; b=E/mehOdTd/6I
 4yd2e7YeR/DXCc4rYPtxtlcmGoLWcX3rsTU4vuXKyOtR/GL3r0nK9bGaRW9+67VR
 TaeLiR1HBcEgLhRV4Jku2nspDScCJZpIXoDCf7RQE1G/iT9gCjxoxfLNBLTWbEnv
 DmBop6XcenhMsNRj5QU6RX1qVXp+k8jI/5348j+EgJnxUsO1tKsIkHfv+26AzoWp
 oG8ix8MUmanfo+UuzpaLvyGgWf0eaTeeHAy9iJrLaAJkQJqGAIcX8PNb9zEzSJHZ
 0MPUeAlDdWQDfLIw72BwSoa1sbDkiN8tnRQth6aVI0zenM6/BFa2jOroo6iO9Yn0
 MzJPstGa9g==
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x07y80fuq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 09:08:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zn0jNUzDD8YMwV+RKppDyFSxgSo/PmYh9loVnDZ5kwwdqyPv5p+1xNHSVVIIvx2g8P8HIDQT4tA0E40sqv9sP/VIZr7vq7Bd7Z/71aYaGA/qjBpuGfUm/YqLwJlz3J+o2Sm7dJbqveH022hG8AeT6b8+STW/TDcqP373u/N+EcZCRlVH44zNLl7COzWFGZGlTSe8+JHjm0n3FPFPRhx1Doj3k9TLIlpoqk0d1J4c1hgB7ooVwI7CYDjZ7nAKPMFx8ZJ2VNSkHPOkFqHfYnt5P8KnL33dEiWcfajIfb2YO107Z1QyQhRDq4ZqnG9ofKteuImMw/2NLI0c/S+k1q+pQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KswmGm3JtExoIy164be1K6CNpkIJgOu/dDlZwu9/ufs=;
 b=NDihWXSprhY0rc6pCD1kHegFPF/xdkcc9YlJade/Vf+sIzxhIu1K8Bwk9sMD/9PzRTpOksaOl5MC77r/nzuAutTxn9SY19q/z/f90WRtshdxKWxfkF5d6dEMGmV3zXAJggH7LLIeTjPAqAuwEvWUcmTQhcEkOkqCaCO6aEB+8rHGpMdeSJu3l/UPolwf8D9dtHZ10vzcpM5R2K5Juqg5J0aKDj7Yc8gLiajJretIzikJSSCDI83NhA4JRdQlZgBqTb+vndGJnBzKp0mQFEMe2pL2DmDNRKfsKLwLfaXQTdfh85MClWpFskphEiEfm/2HIh1HewO6qFCtKD018i6nVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KswmGm3JtExoIy164be1K6CNpkIJgOu/dDlZwu9/ufs=;
 b=PSRQ9EszsprujVXamfa7h0ond0JkkSyY90K2gWUofAhqA+ZYDAhLdblkb0afQCSbtIPeAsjKdOTowUzyANrFddnbM53SilN3gMbe91UbyyU19TJYmeRzTkiBp2iKVxDQEaPnTI+so51a1VMcIJ3s5UblH+xTnopMqpcllB/VM6paHkyg0tSylRCwW2D6pifo4Rjn3ot0j9N+7jSE+AI/9mxW4Dk3QFWmwUHoGgZHVwEq5GoAE198a7+HDk4e6VcfvOSfGnEBoLol0V1hIMhF9CgVa2jslAK6Mn0m3F0Y8opJICrE7lrF4SpWuYIZlFrCXm5zg9c8YzN7psgSBUCWZQ==
Received: from PH7P220CA0113.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::31)
 by IA0PR22MB4189.namprd22.prod.outlook.com (2603:10b6:208:48d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 16:08:30 +0000
Received: from CY4PEPF0000EE3A.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::92) by PH7P220CA0113.outlook.office365.com
 (2603:10b6:510:32d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Thu, 21 Mar 2024 16:08:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CY4PEPF0000EE3A.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Thu, 21 Mar 2024 16:08:29 +0000
Received: from localhost.localdomain (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 21 Mar 2024 09:08:22 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v2 2/2] Refactor common functions between POSIX and Windows
 implementation
Date: Thu, 21 Mar 2024 16:07:25 +0000
Message-ID: <20240321160725.340341-3-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240321160725.340341-1-aidan_leuck@selinc.com>
References: <20240321160725.340341-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3A:EE_|IA0PR22MB4189:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a66c92b-8103-4a48-fe22-08dc49c12639
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cCGhViYsGTuqd+oOL4YF14V7rCGy0KP4whHeugYr5WzcDtdcXe3BKqMvWf16LXVJE5twEeQaSjYFDdsq/p4VjTbWV27fiLJoiwCHLvXsZXpCTNnR2l7zpR9eOpASKn8JWrfeGWd81G+DYPF2CjqlC3x+NY4qniEHzFkgiNY4RJobzcpUvLoePMB5Dy+rEiCa70Rq6Oc/ktStRMCQTGKqWtCSf6CLLRt6GF36p6u+PZjeTje84Qov42B85XtEi90liy0TwFMpGWEKbt4iA5wbnYCRaZbVbKfyN5B4Pu8qxh0wxv6dLrUISpHSbFRIqoQ9eHe0CdGapu14h4Svo9RRbVpv9GFZSTs7frVG3pWDiEqgEP5xMQelImp2wXqi/szTBr+4EwMYpFf9sCV5LLAnBwDT7G7FZf/fqKPmShb/ry9mAV8Wti7c3Or0UrODmYmD98wYNaEDCgCFEd5TQSE3ikc5LRZgUZlEIpH4tBBUD0EkfEr6xcnMxb460D9A/1i0jqOnd3yxOvQ6SKFweVrkhXV38oap4D9LrD5HHLqF0swC6ae45XVeWkorVBjILEV+fh82QOryR2TuiUEZEroswy9lmx5XSqyshzqkAHt20tq6oYtbycE+ZUXMua70m/IgEAgKqzje+DqCnkxkMEyhpiFCcScWYT5VDzpg5g0o9au6A65jnQ9ncauSPAe+h2vbH5ZmjB09xl1qBGhAaRjfumCqgjoaIeFDbpe3Nk0QLNeKvh2vFLvh3XqJyb7RRBbT
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 16:08:29.7680 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a66c92b-8103-4a48-fe22-08dc49c12639
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4189
X-Proofpoint-ORIG-GUID: hnkHRlkk1S7ayvVQgvN6vwMmviVuSeil
X-Proofpoint-GUID: hnkHRlkk1S7ayvVQgvN6vwMmviVuSeil
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 clxscore=1015
 mlxscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403210117
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=78105fa443=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
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
 qga/commands-posix-ssh.c   | 47 +--------------------------
 qga/commands-ssh-core.c    | 57 ++++++++++++++++++++++++++++++++
 qga/commands-ssh-core.h    |  8 +++++
 qga/commands-windows-ssh.c | 66 +-------------------------------------
 qga/meson.build            |  3 +-
 5 files changed, 69 insertions(+), 112 deletions(-)
 create mode 100644 qga/commands-ssh-core.c
 create mode 100644 qga/commands-ssh-core.h

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 236f80de44..9a71b109f9 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -9,6 +9,7 @@
 #include <locale.h>
 #include <pwd.h>
 
+#include "commands-ssh-core.h"
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
diff --git a/qga/commands-ssh-core.c b/qga/commands-ssh-core.c
new file mode 100644
index 0000000000..51353b396d
--- /dev/null
+++ b/qga/commands-ssh-core.c
@@ -0,0 +1,57 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <qga-qapi-types.h>
+#include <stdbool.h>
+#include "qapi/error.h"
+#include "commands-ssh-core.h"
+
+GStrv read_authkeys(const char *path, Error **errp)
+{
+    g_autoptr(GError) err = NULL;
+    g_autofree char *contents = NULL;
+
+    if (!g_file_get_contents(path, &contents, NULL, &err))
+    {
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
+    for (k = keys; k != NULL; k = k->next)
+    {
+        if (!check_openssh_pub_key(k->value, errp))
+        {
+            return false;
+        }
+        n++;
+    }
+
+    if (nkeys)
+    {
+        *nkeys = n;
+    }
+    return true;
+}
+
+bool check_openssh_pub_key(const char *key, Error **errp)
+{
+    /* simple sanity-check, we may want more? */
+    if (!key || key[0] == '#' || strchr(key, '\n'))
+    {
+        error_setg(errp, "invalid OpenSSH public key: '%s'", key);
+        return false;
+    }
+
+    return true;
+}
\ No newline at end of file
diff --git a/qga/commands-ssh-core.h b/qga/commands-ssh-core.h
new file mode 100644
index 0000000000..f26d66c846
--- /dev/null
+++ b/qga/commands-ssh-core.h
@@ -0,0 +1,8 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+GStrv read_authkeys(const char *path, Error **errp);
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
+bool check_openssh_pub_key(const char *key, Error **errp);
\ No newline at end of file
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
index 566266f465..e8cbcd0779 100644
--- a/qga/commands-windows-ssh.c
+++ b/qga/commands-windows-ssh.c
@@ -16,6 +16,7 @@
 #include <aclapi.h>
 #include <qga-qapi-types.h>
 
+#include "commands-ssh-core.h"
 #include "commands-windows-ssh.h"
 #include "guest-agent-core.h"
 #include "limits.h"
@@ -35,71 +36,6 @@
 #define ADMIN_SID "S-1-5-32-544"
 #define WORLD_SID "S-1-1-0"
 
-/*
- * Reads the authorized_keys file and returns an array of strings for each entry
- *
- * parameters:
- * path -> Path to the authorized_keys file
- * errp -> Error structure that will contain errors upon failure.
- * returns: Array of strings, where each entry is an authorized key.
- */
-static GStrv read_authkeys(const char *path, Error **errp)
-{
-  g_autoptr(GError) err = NULL;
-  g_autofree char *contents = NULL;
-
-  if (!g_file_get_contents(path, &contents, NULL, &err)) {
-    error_setg(errp, "failed to read '%s': %s", path, err->message);
-    return NULL;
-  }
-
-  return g_strsplit(contents, "\n", -1);
-}
-
-/*
- * Checks if a OpenSSH key is valid
- * parameters:
- * key* Key to check for validity
- * errp -> Error structure that will contain errors upon failure.
- * returns: true if key is valid, false otherwise
- */
-static bool check_openssh_pub_key(const char *key, Error **errp)
-{
-  /* simple sanity-check, we may want more? */
-  if (!key || key[0] == '#' || strchr(key, '\n')) {
-    error_setg(errp, "invalid OpenSSH public key: '%s'", key);
-    return false;
-  }
-
-  return true;
-}
-
-/*
- * Checks if all openssh keys in the array are valid
- *
- * parameters:
- * keys -> Array of keys to check
- * errp -> Error structure that will contain errors upon failure.
- * returns: true if all keys are valid, false otherwise
- */
-static bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
-{
-  size_t n = 0;
-  strList *k;
-
-  for (k = keys; k != NULL; k = k->next) {
-    if (!check_openssh_pub_key(k->value, errp)) {
-      return false;
-    }
-    n++;
-  }
-
-  if (nkeys) {
-    *nkeys = n;
-  }
-  return true;
-}
-
 /*
  * Frees userInfo structure. This implements the g_auto cleanup
  * for the structure.
diff --git a/qga/meson.build b/qga/meson.build
index 4c4a493ec5..820ffcb7df 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -65,7 +65,8 @@ qga_ss.add(files(
   'commands.c',
   'guest-agent-command-state.c',
   'main.c',
-  'cutils.c'
+  'cutils.c',
+  'commands-ssh-core.c'
 ))
 if host_os == 'windows'
   qga_ss.add(files(
-- 
2.44.0


