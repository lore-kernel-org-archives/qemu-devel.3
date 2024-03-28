Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96682C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 15:42:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rprsa-0002tl-LO; Thu, 28 Mar 2024 11:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=881719a93e=aidan_leuck@selinc.com>)
 id 1rprsW-0002t9-VY
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:41:21 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=881719a93e=aidan_leuck@selinc.com>)
 id 1rprsU-0007Vf-Ek
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 11:41:20 -0400
Received: from pps.filterd (m0136176.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42SCP10E015533; Thu, 28 Mar 2024 08:41:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=qXi/j4+ThDv9uFRSo28+/p24QiKZ3x42mM82KZoDShM=; b=Sizjy/vtDgAH
 L1cer5rSQXnjsdGfHHs2No9gftYrVTFTnX0NfSGG54qI74W2FM3o/QXvV7cZyDku
 PAErLNA1AelXQMY6scoX8Q9AeCh8ubk8Tv7FT4z9845RGQQiKYV0u+Z0CO2iBZdD
 kTWI6z2rcxeA1hC8pg5ba6Lcor/p060tp8Ny1YsjGmDkZMhbDdUGh4JdjtjL/VA1
 5GjbRJHBaLBaBqntWsffUCImSnlK8qUKqUz8Erj51bvu4178R0RU9o6Pj0NX/dEv
 JIrD0M8Cbe1/zptzMlisoq+EZH7vNwCsG2u2NhDO8xPwpUMaRFijlHwl9EeXNZtd
 rQbwmJ9TWw==
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x4xnh0h9p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 28 Mar 2024 08:41:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g/YvR22sqM6rNe9OA+o0R8Jso4S47yHOFmac+jnmFwbqWbcx/JCZxxO57uWNweT6bo4YQCw1C6/5JNLRZcJ4KNqxfiThBKv0vG7a7ye+4FFNdMaPrc4YJIcj/Q7Zo/cVq540RKhYzMK03/oH002xX7MakcjOpSAdyKcQUigiddC0ef0H4+2TqYO7qITYc+P6rjG1FTogqnhAXr80DkWN+EjFFvhEccGSDVJC9ytnjL2+SN/2iuQ3lolNe9X/aacCLfx9ehia/GA55MA8CmfeO/EznzmQIpsidD29NOqtyByi0hWmcV7b0ZkI77/zkxhTXeMNUkI7g6OF2tRbP4G8qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qXi/j4+ThDv9uFRSo28+/p24QiKZ3x42mM82KZoDShM=;
 b=YUqsKxIjA41sy8XnDAKZskjCA7W3PZoKzCCFEWXmFqjVgK6YqXTwUi5W5SfXamJRvimSs8Hoq7sx9zuFog0Su0Hl5GXHmKRFNF9lMjyXlI4QtT6Iy1C9NluLUMBeeTy3GRkIfuRtfgMNdS6amp11hoCLBjP+6fSMXGk8gNpG8b9/JgH3aTQ+TmuTD8vX5BUnTOA9OgJ1JmlIyoK80v/jjGbEU+Y11rodWZKTm2JxJw11wbW/NbL3yPPxhFghZU6k6thnfhzdCgArxhG6TvUU/tNydBSiJGguwz2YFw92WwEjTAdAhWXPlAzxmVsJvCUgutslm3RwMw14469n4Nai2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qXi/j4+ThDv9uFRSo28+/p24QiKZ3x42mM82KZoDShM=;
 b=fSM0qNIUrpT0HoLS4gdeOfXevEDJ783zIWi3ix7cFMS2jbE+3dQZLFVFyxr63e4Ii7EZrvwSn6TWniB+NTtyokcNQ99L5R0gVRmsht7Ly0KvVRwUWqcHB2O45DbKMIy004KvBbTuD4XucysXbVK2Bx4siRFj3u3HwRlkaI0hOtGsNlCA19ICuJVsAkz6VcNuG8KIq6dirz8VqVbNJKD1m1wEvsHI5uGLq3QUIbRcJsQyEcApvAEqez+8dFjIHL6bXC/Ylr0+3u2DS/hz0q8VvFX6CQ/voBTBsYGX4eWTUXaHcOd+ZZzdo4Q7cK6vpEZkuCV7C4ze37Qf+rHQlS01KA==
Received: from CH2PR15CA0030.namprd15.prod.outlook.com (2603:10b6:610:51::40)
 by SN7PR22MB3929.namprd22.prod.outlook.com (2603:10b6:806:32c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 15:41:12 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:51:cafe::48) by CH2PR15CA0030.outlook.office365.com
 (2603:10b6:610:51::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 15:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.0 via Frontend Transport; Thu, 28 Mar 2024 15:41:11 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 28 Mar 2024 08:41:08 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, aidaleuc <aidan_leuck@selinc.com>
Subject: [PATCH v5 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Thu, 28 Mar 2024 09:40:48 -0600
Message-ID: <20240328154049.3090753-2-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328154049.3090753-1-aidan_leuck@selinc.com>
References: <20240328154049.3090753-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SN7PR22MB3929:EE_
X-MS-Office365-Filtering-Correlation-Id: c7a3c9c8-3804-462c-9fb5-08dc4f3d7ea6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SpaLRmEod4aWgq3fwCOnhSTouuzUYDHbI7FVaA8W/2EIuYz/4YAxvcfH+NNdFMZYOhtJzlNxuRSXl2Kw1pu4pKMVe1SU9obiII4JfwB+umPRNKR43Pjt3xu22Gdi54bsx9nhT5YoEh6KdLdPFRD+mLc30Rg4vU9yYg1J4NWgiG/fTblyp+rVXhU6jZgiPi1oGK+CO6ByLR05jsTOX+Q5u0k919W+W5DeQBl/CaNnTnOsQt76DYMcy5O8xj4z48XSjBmizJZhnmIIboRV4wpnO7xlolzhZFFfgNYUiU2E31Fg0/NAog+sxxCU6gAs60FgZEx0UpG5nMIUv5iSvAEHF3lnfsz5sCkfUwLwWvr+hY8rsfNVXqCyVJJoNSrGDoIL9ASNPEUU+StfZCrX/06sq99CtjQ8r0zUY9qjwwlGuHKEPu93kaG7Gpoz3d1GwvC7ytgAXFk0qCD4VqajZFY1CagCiFq0+fWQMVJU+eIaL7mN8NyyGFB00UtzYr9i6UnuFVl2C+7UbIZbP2kWQkpEqPNrx66ubavjXiY7fE59BjKoOE8C9ri/fBlQEFmduko6mIblriXVdYd1gJP+UTlMB/xIXGnH2KbM7Gmcp7K7yYvVCRSbAlxgAeRLPhmTq/zqiwx8pMfB3oixCEgdulVa6ZvtZqQywqBqRBrIIMHjpbJeNmqOB+ieQ5AAPQnQsjNoVpAyRZxXqXL4sYwRjcIbWt1LSkBEVrETuBxX6ojSXsGlz+CkxNSWKCpH66XUlq5R
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 15:41:11.4810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a3c9c8-3804-462c-9fb5-08dc4f3d7ea6
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR22MB3929
X-Proofpoint-GUID: 1jdtSE1KWWYd5srUTc6HhjgaF6cvTdv0
X-Proofpoint-ORIG-GUID: 1jdtSE1KWWYd5srUTc6HhjgaF6cvTdv0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280108
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=881719a93e=aidan_leuck@selinc.com;
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
 qga/commands-common-ssh.c | 50 ++++++++++++++++++++++++++++++++++++++
 qga/commands-common-ssh.h | 10 ++++++++
 qga/commands-posix-ssh.c  | 51 +++------------------------------------
 qga/meson.build           |  1 +
 4 files changed, 64 insertions(+), 48 deletions(-)
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


