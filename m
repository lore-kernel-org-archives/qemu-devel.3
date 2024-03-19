Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A4FC54E68
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 20:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmgE3-00009m-Da; Tue, 19 Mar 2024 16:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78089e1de9=aidan_leuck@selinc.com>)
 id 1rme2T-0000Vk-9v
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:18:17 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=78089e1de9=aidan_leuck@selinc.com>)
 id 1rme2O-0001WW-JZ
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 14:18:17 -0400
Received: from pps.filterd (m0136176.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42JHoLTF004240; Tue, 19 Mar 2024 11:18:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=er77t6cKbN5v
 Gi0UqkPrGF44kFtvmhjL6wDcs0wTutc=; b=NGKqcZh/zL0QWq2FsKFSXzZ8AWca
 VUTqQvbU5e2PCcYRUEAHUYDB2Nw93SkNMsrgM7yhcBxlyOTCEDiILjyyEoNqQ+nq
 hFxewLGwDsJax5948bZIBfqhlNQVAcH+7Xi6mpHZf9eZ7Ty7QmoXGY2wxONIlNct
 AYD5i4Xg2DmH4gtCcY56G9NhMnoainvrJglrwUAt9uHHykEsOtr3S4dDCsWONAHj
 Gc3LE8coQ7dkVz2C4efarj1QBK19zhYUZ7fph5vdIOzgbW0/yCYi7WxIey/SZvSA
 C4uQ83AcjMH3SBvvJBtverh5Yd7TjHZJ+WPfyauCVz3OXqaV7GzvmCuTDw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3wyb1607va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 19 Mar 2024 11:18:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IpxDM/9NT8YbopN9iwnP1BcpUweU7RW8skHk7fvouUV7eLGmqqdjhSd7+U1gdpNlqa4kuACMxDS2CwrIqM+us9zuvC2r8FyRb5/GgEEV6XMguyLgqNdBOd6eLlraOwr6wKlI/7jcTNdjjRLMpOHqM0o6jrSOdS9gBLzhXBUUp9vThthlSsfeMW6zd0zoF5LA0JA5BfUhZUjfC4g5Hk3InrZrHCEhZ84cwmqLGz/aq8ekIoZvhV82WukawZ0w/S4EvCHR0CbLjU5YPVtn3Y9Wj+GkaSk+79yqEetvqrALW8uhqc/Y8oJgbQYigJHbu9eR3+DfopYEjl2gG1ll0S2oSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=er77t6cKbN5vGi0UqkPrGF44kFtvmhjL6wDcs0wTutc=;
 b=hBHbap4DMoY21ZUM3Mfker/GJyQrnf5b/KqraereakUDZXWTKzetewC9Pp3uSYCE0IAo+hVgXI2Zoa9OCv+lOUNcc4ZmRM8tFal09vb0gs6fU8rsrOlaWb4Do96NGQH8DWI86dgSOWdDG6o6mqj2laGf6gpWFA5A7iz65Jsvr54nX6r100nmIiDEZGStQb4pRI/MJkG5zm/1wLpAV8OStUSU9Ps5Apeakp1R1C80C54zoZSev2xg73R7QKj0heJEoca2wZl5RWCEty4lEAPQ8l1/7atHgpG3AJDwcuXexAhxCiW0lARegCdUzMZUlmTmUby5DVioVLMfQwhevOhs/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=er77t6cKbN5vGi0UqkPrGF44kFtvmhjL6wDcs0wTutc=;
 b=WnttW2UERXVnm5JyZT8uBdvP2o9vFx7JL5pooF2zP9fsoz765DWQoh3HjL5bQtNxn9pGWQfqPHS+6EGvE341wgFtgcv5Eg8d2dYB/jmi6j7kaqcHswvn1PLQ1YIve7TfZJZ/L+zEWKF33feblExP6cw550Vu0DQPZDBupsQLWLTNHvqsutzfZ/Mrkd1Fda2hgVRtvDnKxqis/4zGTlJjcgApuLw5XmL36+tDJWHZen2BxB6lc+DSHm1eMvCC8VrSn8gwDh6obMi+PNOMWaGS+c1YGRjqXTxUqMS2TO7vopmBTG/HIFNGHoPzgZvTbwUGeONeBBH9MoB18nJcmTH40Q==
Received: from CH0PR03CA0396.namprd03.prod.outlook.com (2603:10b6:610:11b::16)
 by SJ2PR22MB4227.namprd22.prod.outlook.com (2603:10b6:a03:538::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 18:17:53 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:11b:cafe::87) by CH0PR03CA0396.outlook.office365.com
 (2603:10b6:610:11b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 19 Mar 2024 18:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 18:17:52 +0000
Received: from localhost.localdomain (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 19 Mar 2024 11:17:46 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <micheal.roth@amd.com>, <kkostiuk@redhat.com>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH] Implement SSH commands in QEMU GA for Windows
Date: Tue, 19 Mar 2024 18:17:24 +0000
Message-ID: <20240319181724.212753-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|SJ2PR22MB4227:EE_
X-MS-Office365-Filtering-Correlation-Id: 091104ef-9e61-4558-d910-08dc4840e477
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4BI74qoT1exTABHS1OTUVMTDo++GRdKOXGQXTbd5NsvcxjRqc0krJ/5S702GAKWpNl34kR3YxRw2zP1g9pDkk5h1H5aivyELbwSO4bb/qGDL14nkdDYxNJ5l3w7YJLQpr/AnXawav1HekUFupmi0wx6rhc1keJm3OEau9X0FU+E7mqp90le3cQfxD279jIXafzobLvrcVexjUABlhFo5ZSYrXUZAKELcvmKrIyoFvUtU5GUEb8gNKfVcrW4AYnsYbP92hTAikhj9+pJVRtoV7D3UWpk/nbH3of1WOdP6hQdPX+TUkTKcyjyIIc0iHjzqEpQxp4cB9dbaaKb1Ea1okBwA6uYzq5Ml+PTj/smMz63W45p9g/rNmXHOjZ1Z/+MjSjubISg5Ubb7fU7ObHG5wgBQXj3cuM0D41ihClOjfRrMShhRHk2Tt5nLqxws0l8S0hXdEBy/xgVrSmqo1m5plHfcrqJ2IWhx1bly8B78skTglsqcWxJwl/KYfBOKwuEhIf+Oe/YF34aSEcahdPTXUqrFm75ymLWxWtU2Qc1iX9hcFYZJtFyn0Um21ggzAhzEoV6SIz/I1XoFlZwIhDCU0/6IMsCFpXEYSeGhTa/RLUN4s5ndKikZjtJ9iFuqkxob7G7sDTS7a3pbaA+PvCyd3WOWhxANT7CFK6Yh5cSO6cgwjxPBW134A6Ge6F2redhObR//ifSu92PbuwR0Hn4E5A==
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:17:52.6527 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 091104ef-9e61-4558-d910-08dc4840e477
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4227
X-Proofpoint-GUID: n36SEL74OMSwMMoLBb4y7XiT37vYUU4P
X-Proofpoint-ORIG-GUID: n36SEL74OMSwMMoLBb4y7XiT37vYUU4P
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0
 phishscore=0 clxscore=1011 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403190138
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=78089e1de9=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 URI_TRY_3LD=1.999 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 19 Mar 2024 16:38:21 -0400
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
 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-ssh-core.c    |  52 +++
 qga/commands-ssh-core.h    |  20 ++
 qga/commands-windows-ssh.c | 686 +++++++++++++++++++++++++++++++++++++
 qga/meson.build            |   6 +-
 qga/qapi-schema.json       |  20 +-
 6 files changed, 775 insertions(+), 56 deletions(-)
 create mode 100644 qga/commands-ssh-core.c
 create mode 100644 qga/commands-ssh-core.h
 create mode 100644 qga/commands-windows-ssh.c

diff --git a/qga/commands-posix-ssh.c b/qga/commands-posix-ssh.c
index 236f80de44..7058894007 100644
--- a/qga/commands-posix-ssh.c
+++ b/qga/commands-posix-ssh.c
@@ -11,6 +11,7 @@
 
 #include "qapi/error.h"
 #include "qga-qapi-commands.h"
+#include "commands-ssh-core.h"
 
 #ifdef QGA_BUILD_UNIT_TEST
 static struct passwd *
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
index 0000000000..2c9fca791a
--- /dev/null
+++ b/qga/commands-ssh-core.c
@@ -0,0 +1,52 @@
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
index 0000000000..b6866cff22
--- /dev/null
+++ b/qga/commands-ssh-core.h
@@ -0,0 +1,20 @@
+#include <glib/gstrfuncs.h>
+#include "qemu/osdep.h"
+
+GStrv read_authkeys(const char *path, Error **errp);
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
+bool check_openssh_pub_key(const char *key, Error **errp);
+
+typedef struct WindowsUserInfo
+{
+    char *sshDirectory;
+    char *authorizedKeyFile;
+    char *username;
+    char *SSID;
+    bool isAdmin;
+} WindowsUserInfo;
+
+typedef WindowsUserInfo *PWindowsUserInfo;
+
+void free_userInfo(PWindowsUserInfo info);
+G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PWindowsUserInfo, free_userInfo, NULL);
\ No newline at end of file
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
new file mode 100644
index 0000000000..59b9309eff
--- /dev/null
+++ b/qga/commands-windows-ssh.c
@@ -0,0 +1,686 @@
+/*
+ * QEMU Guest Agent win32-specific command implementations for SSH keys.
+ * The implementation is opinionated and expects the SSH implementation to
+ * be OpenSSH.
+ *
+ * Copyright IBM Corp. 2024
+ *
+ * Authors:
+ *  Aidan Leuck <aidan_leuck@selinc.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <qga-qapi-types.h>
+#include <stdbool.h>
+#include "qapi/error.h"
+#include "qga-qapi-commands.h"
+#include "lmaccess.h"
+#include "guest-agent-core.h"
+#include "lmerr.h"
+#include "lmapibuf.h"
+#include "shlobj.h"
+#include "limits.h"
+#include "userenv.h"
+#include "commands-ssh-core.h"
+#include "sddl.h"
+#include <aclapi.h>
+
+#define MAX_PATH_CHAR MAX_PATH * sizeof(char)
+#define AUTHORIZED_KEY_FILE "authorized_keys"
+#define AUTHORIZED_KEY_FILE_ADMIN "administrators_authorized_keys"
+#define LOCAL_SYSTEM_SID "S-1-5-18"
+#define ADMIN_SID "S-1-5-32-544"
+#define USER_COUNT 3
+
+// Converts from a standard string to a Windows wide string.
+// it is a 16-bit wide character used to store Unicode encoded as UTF-16LE/
+// some Windows API functions require this format of the string as opposed to just
+// the normal c char*. This function attempts to convert a standard string to
+// a wide string if it is possible. Some multibyte characters are not supported
+// so it could throw an error.
+// Read more here:
+// https://learn.microsoft.com/en-us/cpp/cpp/char-wchar-t-char16-t-char32-t?view=msvc-170
+// parameters:
+// string - String to convert to a wchar.
+// errp - Error pointer that will set errors if they are converted
+// returns - The converted string or NULL if an error occurs.
+static wchar_t *string_to_wide(const char *string, Error **errp)
+{
+    // Get the length of the string + 1 for the NULL terminating character.
+    size_t requiredSize = strlen(string) + 1;
+
+    // Create memory for the wide string.
+    wchar_t *wideString = g_malloc((requiredSize) * sizeof(wchar_t));
+    if (!wideString)
+    {
+        error_setg(errp, "Failed to allocate memory for wide string.");
+        return NULL;
+    }
+
+    // Convert to wide string
+    size_t size = mbstowcs(wideString, string, requiredSize);
+    if (size == (size_t)-1)
+    {
+        error_setg(errp, "Couldn't convert string to wide string. Invalid multibyte character encountered");
+
+        // Free the allocated memory if we failed to convert the string.
+        if (wideString)
+        {
+            g_free(wideString);
+        }
+
+        return NULL;
+    }
+
+    // Return the pointer back to the user.
+    return g_steal_pointer(&wideString);
+}
+
+// Frees userInfo structure. This implements the g_auto cleanup
+// for the structure.
+void free_userInfo(PWindowsUserInfo info)
+{
+    if (info->sshDirectory)
+    {
+        g_free(info->sshDirectory);
+    }
+    if (info->authorizedKeyFile)
+    {
+        g_free(info->authorizedKeyFile);
+    }
+    if (info->SSID)
+    {
+        LocalFree(info->SSID);
+    }
+    if (info->username)
+    {
+        g_free(info->username);
+    }
+
+    g_free(info);
+}
+
+// Gets the admin SSH folder for OpenSSH. OpenSSH does not store
+// the authorized_key file in the users home directory for security reasons and instead
+// stores it at %PROGRAMDATA%/ssh. This function returns the path to that directory
+// on the users machine
+// parameters: errp -> error structure to set when an error occurs
+// returns: The path to the ssh folder in %PROGRAMDATA% or NULl if an error occurred.
+static char *get_admin_ssh_folder(Error **errp)
+{
+    // Allocate memory for the program data path
+    g_autofree char *programDataPath = g_malloc(MAX_PATH_CHAR);
+    char *authkeys_path = NULL;
+    PWSTR pgDataW;
+
+    // Get the KnownFolderPath on the machine.
+    HRESULT folderResult = SHGetKnownFolderPath(&FOLDERID_ProgramData, 0, NULL, &pgDataW);
+    if (folderResult != S_OK)
+    {
+        error_setg(errp, "Failed to retrieve ProgramData folder");
+        return NULL;
+    }
+
+    // Convert from a wide string back to a standard character string.
+    size_t writtenBytes = wcstombs(programDataPath, pgDataW, MAX_PATH_CHAR);
+
+    // Free the Windows allocated string.
+    CoTaskMemFree(pgDataW);
+    if (writtenBytes == (size_t)-1)
+    {
+        error_setg(errp, "Failed to convert program data path to char string");
+        return NULL;
+    }
+
+    // Build the path to the file.
+    authkeys_path = g_build_filename(programDataPath, "ssh", NULL);
+    return authkeys_path;
+}
+
+//  Gets the path to the SSH folder for the specified user. If the user is an admin it returns
+//  the ssh folder located at %PROGRAMDATA%/ssh. If the user is not an admin it returns %USERPROFILE%/.ssh
+//  parameters:
+//  username -> Username to get the SSH folder for
+//  isAdmin -> Whether the user is an admin or not
+//  errp -> Error structure to set any errors that occur.
+//  returns: path to the ssh folder as a string.
+
+static char *get_ssh_folder(const char *username, const bool isAdmin, Error **errp)
+{
+    if (isAdmin)
+    {
+        return get_admin_ssh_folder(errp);
+    }
+
+    // If not an Admin the SSH key is in the user directory.
+    DWORD maxSize = MAX_PATH_CHAR;
+    g_autofree LPSTR profilesDir = g_malloc(maxSize);
+
+    // Get the user profile directory on the machine.
+    BOOL ret = GetProfilesDirectory(profilesDir, &maxSize);
+    if (!ret)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve profiles directory");
+        return NULL;
+    }
+
+    // Builds the filename
+    return g_build_filename(profilesDir, username, ".ssh", NULL);
+}
+
+// Sets the access control on the authorized_keys file and any ssh folders that need
+// to be created. For administrators the required permissions on the file/folders are
+// that only administrators and the LocalSystem account can access the folders.
+// For normal user accounts only the specified user, LocalSystem and Administrators can
+// have access to the key.
+// parameters:
+// userInfo -> pointer to structure that contains information about the user
+// PACL -> pointer to an access control structure that will be set upon successful completion of the function.
+// errp -> error structure that will be set upon error.
+// returns: 1 upon success 0 upon failure.
+static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error **errp)
+{
+    g_autofree PSECURITY_DESCRIPTOR pSD = NULL;
+    g_autofree PEXPLICIT_ACCESS pExplicitAccess = NULL;
+    PSID systemPSID = NULL;
+    PSID adminPSID = NULL;
+    PSID userPSID = NULL;
+
+    // If the user is an admin only admins and LocalSystem have access so two ACL's
+    // if the user is not an admin, the user, admin and LocalSystem will have access so three ACL's.
+    int numUsers = userInfo->isAdmin ? 2 : 3;
+
+    // Allocate memory
+    pExplicitAccess = g_malloc(sizeof(EXPLICIT_ACCESS) * numUsers);
+
+    // Zero out the allocated memory.
+    ZeroMemory(pExplicitAccess, numUsers * sizeof(EXPLICIT_ACCESS));
+
+    // If the user is not an admin add the user creating the key or folder to the list.
+    if (!userInfo->isAdmin)
+    {
+        // Get a pointer to the internal SID object in Windows
+        bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
+        if (!converted)
+        {
+            error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID", userInfo->username);
+            goto error;
+        }
+
+        // Set the permissions for the user.
+        pExplicitAccess[2].grfAccessPermissions = GENERIC_ALL;
+        pExplicitAccess[2].grfAccessMode = SET_ACCESS;
+        pExplicitAccess[2].grfInheritance = NO_INHERITANCE;
+        pExplicitAccess[2].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+        pExplicitAccess[2].Trustee.TrusteeType = TRUSTEE_IS_USER;
+        pExplicitAccess[2].Trustee.ptstrName = (LPTSTR)userPSID;
+    }
+
+    // Create an entry for the system user.
+    const char *systemSID = LOCAL_SYSTEM_SID;
+    bool converted = ConvertStringSidToSid(systemSID, &systemPSID);
+    if (!converted)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve system SID");
+        goto error;
+    }
+
+    // set permissions for system user
+    pExplicitAccess[0].grfAccessPermissions = GENERIC_ALL;
+    pExplicitAccess[0].grfAccessMode = SET_ACCESS;
+    pExplicitAccess[0].grfInheritance = NO_INHERITANCE;
+    pExplicitAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    pExplicitAccess[0].Trustee.TrusteeType = TRUSTEE_IS_USER;
+    pExplicitAccess[0].Trustee.ptstrName = (LPTSTR)systemPSID;
+
+    // Create an entry for the admin user.
+    const char *adminSID = ADMIN_SID;
+    converted = ConvertStringSidToSid(adminSID, &adminPSID);
+    if (!converted)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve Admin SID");
+        goto error;
+    }
+
+    pExplicitAccess[1].grfAccessPermissions = GENERIC_ALL;
+    pExplicitAccess[1].grfAccessMode = SET_ACCESS;
+    pExplicitAccess[1].grfInheritance = NO_INHERITANCE;
+    pExplicitAccess[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    pExplicitAccess[1].Trustee.TrusteeType = TRUSTEE_IS_GROUP;
+    pExplicitAccess[1].Trustee.ptstrName = (LPTSTR)adminPSID;
+
+    // Put the entries in an ACL object.
+    PACL pNewACL = NULL;
+    DWORD setResult = SetEntriesInAcl(numUsers, pExplicitAccess, NULL, &pNewACL);
+
+    // Set the user provided pointer to the allocated pointer
+    *pACL = pNewACL;
+
+    if (setResult != ERROR_SUCCESS)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to set ACL entries for user %s %lu", userInfo->username, setResult);
+        goto error;
+    }
+
+    // free memory
+    LocalFree(systemPSID);
+    LocalFree(adminPSID);
+
+    if (userPSID)
+    {
+        LocalFree(userPSID);
+    }
+
+    return true;
+
+error:
+    // On error free memory and return false.
+    if (systemPSID)
+    {
+        LocalFree(systemPSID);
+    }
+    if (adminPSID)
+    {
+        LocalFree(adminPSID);
+    }
+    if (userPSID)
+    {
+        LocalFree(userPSID);
+    }
+
+    return false;
+}
+
+// Create the SSH directory for the user and d sets appropriate permissions.
+// In general the directory will be %PROGRAMDATA%/ssh if the user is an admin.
+// %USERPOFILE%/.ssh if not an admin
+// parameters:
+// userInfo -> Contains information about the user
+// errp -> Structure that will contain errors if the function fails.
+// returns: zero upon failure, 1 upon success
+static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp)
+{
+
+    PACL pNewACL = NULL;
+    g_autofree PSECURITY_DESCRIPTOR pSD = NULL;
+
+    // Gets the approparite ACL for the user
+    if (!create_acl(userInfo, &pNewACL, errp))
+    {
+        goto error;
+    }
+
+    // Allocate memory for a security descriptor
+    pSD = g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
+    if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION))
+    {
+        error_setg_win32(errp, GetLastError(), "Failed to initialize security descriptor");
+        goto error;
+    }
+
+    // Associate the security descriptor with the ACL permissions.
+    if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE))
+    {
+        error_setg_win32(errp, GetLastError(), "Failed to set security descriptor ACL");
+        goto error;
+    }
+
+    // Set the security attributes on the folder
+    SECURITY_ATTRIBUTES sAttr;
+    sAttr.bInheritHandle = FALSE;
+    sAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
+    sAttr.lpSecurityDescriptor = pSD;
+
+    // Create the directory with the created permissions
+    BOOL created = CreateDirectory(userInfo->sshDirectory, &sAttr);
+    if (!created)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to create directory %s", userInfo->sshDirectory);
+        goto error;
+    }
+
+    // Free memory
+    LocalFree(pNewACL);
+    return true;
+error:
+    if (pNewACL)
+    {
+        LocalFree(pNewACL);
+    }
+
+    return false;
+}
+
+// Sets permissions on the authorized_key_file that is created.
+// parameters: userInfo -> Information about the user
+// errp -> error structure that will contain errors upon failure
+// returns: 1 upon success, zero upon failure.
+static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)
+{
+    PACL pACL = NULL;
+    PSID userPSID;
+
+    // Creates the access control structure
+    if (!create_acl(userInfo, &pACL, errp))
+    {
+        goto error;
+    }
+
+    // Get the PSID structure for the user based off the string SID.
+    bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
+    if (!converted)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID", userInfo->username);
+        goto error;
+    }
+
+    // Set the ACL on the file.
+    if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT, DACL_SECURITY_INFORMATION, userPSID, NULL, pACL, NULL) != ERROR_SUCCESS)
+    {
+        error_setg_win32(errp, GetLastError(), "failed to set file security for file %s", userInfo->authorizedKeyFile);
+        goto error;
+    }
+
+    LocalFree(pACL);
+    LocalFree(userPSID);
+    return true;
+
+error:
+    if (pACL)
+    {
+        LocalFree(pACL);
+    }
+    if (userPSID)
+    {
+        LocalFree(userPSID);
+    }
+    return false;
+}
+
+// Writes the specified keys to the authenticated keys file.
+// parameters:
+// userInfo: Information about the user we are writing the authkeys file to.
+// authkeys: Array of keys to write to disk
+// errp: Error structure that will contain any errors if they occur.
+// returns: 1 if succesful, 0 otherwise.
+static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys, Error **errp)
+{
+    g_autofree char *contents = NULL;
+    g_autoptr(GError) err = NULL;
+
+    contents = g_strjoinv("\n", authkeys);
+
+    if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1, &err))
+    {
+        error_setg(errp, "failed to write to '%s': %s", userInfo->authorizedKeyFile, err->message);
+        return false;
+    }
+
+    if (!set_file_permissions(userInfo, errp))
+    {
+        return false;
+    }
+
+    return true;
+}
+
+// Retrieves information about a Windows user by their username
+// userInfo -> Double pointer to a WindowsUserInfo structure. Upon success, it will be allocated
+// with information about the user and need to be freed.
+// username -> Name of the user to lookup.
+// errp -> Contains any errors that occur.
+// returns -> 1 upon success, 0 upon failure.
+static bool get_user_info(PWindowsUserInfo *userInfo, const char *username, Error **errp)
+{
+    DWORD infoLevel = 4;
+    LPUSER_INFO_4 uBuf = NULL;
+    g_autofree wchar_t *wideUserName = NULL;
+
+    // Converts a string to a Windows wide string since the GetNetUserInfo
+    // function requires it.
+    wideUserName = string_to_wide(username, errp);
+    if (!wideUserName)
+    {
+        goto error;
+    }
+
+    // allocate data
+    PWindowsUserInfo uData = g_malloc(sizeof(WindowsUserInfo));
+
+    // Set pointer so it can be cleaned up by the calle, even upon error.
+    *userInfo = uData;
+
+    // Find the information
+    NET_API_STATUS result = NetUserGetInfo(NULL, wideUserName, infoLevel, (LPBYTE *)&uBuf);
+    if (result != NERR_Success)
+    {
+        // Give a friendlier error message if the user was not found.
+        if (result == NERR_UserNotFound)
+        {
+            error_setg(errp, "User %s was not found", username);
+            goto error;
+        }
+
+        error_setg(errp, "Received unexpected error when asking for user info: Error Code %lu", result);
+        goto error;
+    }
+
+    // Get information from the buffer returned by NetUserGetInfo.
+    uData->username = g_strdup(username);
+    uData->isAdmin = uBuf->usri4_priv == USER_PRIV_ADMIN;
+    PSID psid = uBuf->usri4_user_sid;
+
+    char *sidStr = NULL;
+
+    // We store the string representation of the SID not SID structure in memory. Callees wanting
+    // to use the SID structure should call ConvertStringSidToSID.
+    if (!ConvertSidToStringSid(psid, &sidStr))
+    {
+        error_setg_win32(errp, GetLastError(), "failed to get SID string for user %s", username);
+        goto error;
+    }
+
+    // Store the SSID
+    uData->SSID = sidStr;
+
+    // Get the SSH folder for the user.
+    char *sshFolder = get_ssh_folder(username, uData->isAdmin, errp);
+    if (sshFolder == NULL)
+    {
+        goto error;
+    }
+
+    // Get the authorized key file path
+    const char *authorizedKeyFile = uData->isAdmin ? AUTHORIZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE;
+    char *authorizedKeyPath = g_build_filename(sshFolder, authorizedKeyFile, NULL);
+
+    uData->sshDirectory = sshFolder;
+    uData->authorizedKeyFile = authorizedKeyPath;
+
+    // Free
+    NetApiBufferFree(uBuf);
+    return true;
+error:
+    if (uBuf)
+    {
+        NetApiBufferFree(uBuf);
+    }
+
+    return false;
+}
+
+// Gets the list of authorized keys for a user.
+// parameters:
+// username -> Username to retrieve the keys for.
+// errp -> Error structure that will display any errors through QMP.
+// returns: List of keys associated with the user.
+GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char *username, Error **errp)
+{
+    GuestAuthorizedKeys *keys = NULL;
+    g_auto(GStrv) authKeys = NULL;
+    g_autoptr(GuestAuthorizedKeys) ret = NULL;
+    g_auto(PWindowsUserInfo) userInfo = NULL;
+
+    // Gets user information
+    if (!get_user_info(&userInfo, username, errp))
+    {
+        return NULL;
+    }
+
+    // Reads authekys for the user
+    authKeys = read_authkeys(userInfo->authorizedKeyFile, errp);
+    if (authKeys == NULL)
+    {
+        return NULL;
+    }
+
+    // Set the GuestAuthorizedKey struct with keys from the file
+    ret = g_new0(GuestAuthorizedKeys, 1);
+    for (int i = 0; authKeys[i] != NULL; i++)
+    {
+        g_strstrip(authKeys[i]);
+        if (!authKeys[i][0] || authKeys[i][0] == '#')
+        {
+            continue;
+        }
+
+        QAPI_LIST_PREPEND(ret->keys, g_strdup(authKeys[i]));
+    }
+
+    // Steal the pointer because it is up for the callee to deallocate the memory.
+    keys = g_steal_pointer(&ret);
+    return keys;
+}
+
+// Adds an ssh key for a user.
+// parameters:
+// username -> User to add the SSH key to
+// strList -> Array of keys to add to the list
+// has_reset -> Whether the keys have been reset
+// reset -> Boolean to reset the keys (If this is set the existing list will be cleared) and the other key reset.
+// errp -> Pointer to an error structure that will get returned over QMP if anything goes wrong.
+void qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
+                                       bool has_reset, bool reset,
+                                       Error **errp)
+{
+    g_auto(PWindowsUserInfo) userInfo = NULL;
+    g_auto(GStrv) authkeys = NULL;
+    strList *k;
+    size_t nkeys, nauthkeys;
+
+    // Make sure the keys given are valid
+    if (!check_openssh_pub_keys(keys, &nkeys, errp))
+    {
+        return;
+    }
+
+    // Gets user information
+    if (!get_user_info(&userInfo, username, errp))
+    {
+        return;
+    }
+
+    // Determine whether we should reset the keys
+    reset = has_reset && reset;
+    if (!reset)
+    {
+        // If we are not resetting the keys, read the existing keys into memory
+        authkeys = read_authkeys(userInfo->authorizedKeyFile, NULL);
+    }
+
+    // Check that the SSH key directory exists for the user.
+    if (!g_file_test(userInfo->sshDirectory, G_FILE_TEST_IS_DIR))
+    {
+        BOOL success = create_ssh_directory(userInfo, errp);
+        if (!success)
+        {
+            return;
+        }
+    }
+
+    // Reallocates the buffer to fit the new keys.
+    nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
+    authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
+
+    // zero out the memory for the reallocated buffer
+    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
+
+    // Adds the keys
+    for (k = keys; k != NULL; k = k->next)
+    {
+        // Check that the key doesn't already exist
+        if (g_strv_contains((const gchar *const *)authkeys, k->value))
+        {
+            continue;
+        }
+
+        authkeys[nauthkeys++] = g_strdup(k->value);
+    }
+
+    // Write the authkeys to the file.
+    write_authkeys(userInfo, authkeys, errp);
+}
+
+// Removes an SSH key for a user
+// parameters:
+// username -> Username to remove the key from
+// strList -> List of strings to remove
+// errp -> Contains any errors that occur.
+void qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
+                                          Error **errp)
+{
+    g_auto(PWindowsUserInfo) userInfo = NULL;
+    g_autofree struct passwd *p = NULL;
+    g_autofree GStrv new_keys = NULL; /* do not own the strings */
+    g_auto(GStrv) authkeys = NULL;
+    GStrv a;
+    size_t nkeys = 0;
+
+    // Validates the keys passed in by the user
+    if (!check_openssh_pub_keys(keys, NULL, errp))
+    {
+        return;
+    }
+
+    // Gets user information
+    if (!get_user_info(&userInfo, username, errp))
+    {
+        return;
+    }
+
+    // Reads the authkeys for the user
+    authkeys = read_authkeys(userInfo->authorizedKeyFile, errp);
+    if (authkeys == NULL)
+    {
+        return;
+    }
+
+    // Create a new buffer to hold the keys
+    new_keys = g_new0(char *, g_strv_length(authkeys) + 1);
+    for (a = authkeys; *a != NULL; a++)
+    {
+        strList *k;
+
+        // Filters out keys that are equal to ones the user specified.
+        for (k = keys; k != NULL; k = k->next)
+        {
+            if (g_str_equal(k->value, *a))
+            {
+                break;
+            }
+        }
+
+        if (k != NULL)
+        {
+            continue;
+        }
+
+        new_keys[nkeys++] = *a;
+    }
+
+    // Write the new authkeys to the file.
+    write_authkeys(userInfo, new_keys, errp);
+}
\ No newline at end of file
diff --git a/qga/meson.build b/qga/meson.build
index 1c3d2a3d1b..e365cd1ed7 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -66,13 +66,15 @@ qga_ss.add(files(
   'guest-agent-command-state.c',
   'main.c',
   'cutils.c',
+  'commands-ssh-core.c'
 ))
 if host_os == 'windows'
   qga_ss.add(files(
     'channel-win32.c',
     'commands-win32.c',
     'service-win32.c',
-    'vss-win32.c'
+    'vss-win32.c',
+    'commands-windows-ssh.c'
   ))
 else
   qga_ss.add(files(
@@ -93,7 +95,7 @@ gen_tlb = []
 qga_libs = []
 if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
-               '-lsetupapi', '-lcfgmgr32']
+               '-lsetupapi', '-lcfgmgr32', '-luserenv']
   if have_qga_vss
     qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-lstdc++', '-Wl,--enable-stdcall-fixup']
     subdir('vss-win32')
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9554b566a7..57dc3ab12d 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1562,8 +1562,8 @@
 { 'struct': 'GuestAuthorizedKeys',
   'data': {
       'keys': ['str']
-  },
-  'if': 'CONFIG_POSIX' }
+  }
+}
 
 
 ##
@@ -1580,8 +1580,8 @@
 ##
 { 'command': 'guest-ssh-get-authorized-keys',
   'data': { 'username': 'str' },
-  'returns': 'GuestAuthorizedKeys',
-  'if': 'CONFIG_POSIX' }
+  'returns': 'GuestAuthorizedKeys'
+}
 
 ##
 # @guest-ssh-add-authorized-keys:
@@ -1599,8 +1599,10 @@
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
-  'if': 'CONFIG_POSIX' }
+  'data': { 'username': 'str', 'keys': ['str'
+    ], '*reset': 'bool'
+  }
+}
 
 ##
 # @guest-ssh-remove-authorized-keys:
@@ -1617,8 +1619,10 @@
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-remove-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'] },
-  'if': 'CONFIG_POSIX' }
+  'data': { 'username': 'str', 'keys': ['str'
+    ]
+  }
+}
 
 ##
 # @GuestDiskStats:
-- 
2.44.0


