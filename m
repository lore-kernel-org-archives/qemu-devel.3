Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B49B6CD11DD
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 15:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqEDZ-0007hx-AM; Fri, 29 Mar 2024 11:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=88182a685f=aidan_leuck@selinc.com>)
 id 1rqEDP-0007hM-7h
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:32:23 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=88182a685f=aidan_leuck@selinc.com>)
 id 1rqEDM-0000at-MN
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:32:22 -0400
Received: from pps.filterd (m0136174.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42TDmD7I021554; Fri, 29 Mar 2024 08:32:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=L/Dz3oqML6XdI4O1NjXIvAMq8sYNt88Fqs6/DXIpJ9k=; b=HvrwzrjbErL1
 a2LyvOWtHK9B7RgesqmiJO1OkokLzOk8wmSb7arpj/OAd6/V/uukW9b+GzOzT5zL
 AwcO566PnFCxqUrbqzYrZtqve29Wd397skOi6jVxCwcyJH8XUtWYimjLI0PW3lIA
 iADRJOYb34RS2lsOT0LZZ0u1JRzMBW8YXRi4FRfYmGaGP9lW4UA3BxP2Gm4BbqcK
 NWrZHtPkfEtH8naKf6jx6WrW26GVYHADQQa8A0XAOoTU+tYVggQSOK+zI2zT/w4X
 MJ8ZeUsGybK7Gq1H9YUyVel1fyDG1i9U5/FOQOjE/cdmvBNTo6+bPxpfsaJYbJkk
 Z6YnQ5h3vg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x5g1ygfaa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2024 08:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l4Nbl1kJjrCobAyQ9PZyQqa7PtihS8J64d6Mi0plj02OylxG1taLWjKHxwnfVJ9AnbGHAC8rHcQFI/rrMY7wW077NlY1aoIdWAAXnlSMEwx3YCga49pe8xgUMe0eyfk0z49IEn39wq1/dheMbeBKD+7YC1eO2RfM4j4C7AclSok/los3W2oiEd89fdotLpuDWunz1MsbdTl9cm1SiJZmnoBKKGIKyea68a44LLTVRzV6Wzz55V40XgRWzWWi9C8bP0/GLruHxb1r6hFauHGnp0JGW+a38fJggNzIupUeqZHdNLXC7IMELVgKfeAhOu2x2KKu6d5d7091evkgxy/B2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/Dz3oqML6XdI4O1NjXIvAMq8sYNt88Fqs6/DXIpJ9k=;
 b=NndpcIY1wuM8IAr4FSrZ2HqnVPJfyaQ11FmduruZ0B6J65Y+SGTmDtmKGN+yTnuszyqCaPztAuNSHhNi9nLABvlF4XYwDD7sMaI9Lb1tRF0R1H6BRTl4Nlzcqws5hJkbVfPdm8EClPjfJF8h4J/Ezd/LPupP51I1sgeV/n4GIk9vOsTFuOl8fxeXStWDQC20PpMp9vZiIbmk6jRFeupO2fUE7nolk73DkdMA/tkRlk1MEGuTofW1rI4lAbibJDHuy/DdYYmtNZQzKhLDnW0+6Z1CN22YXf/EdiIPvuraOFaT/Osngi3UvHXc5y2nAOSOSRV70r0uJLvzzwn5DL3rbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/Dz3oqML6XdI4O1NjXIvAMq8sYNt88Fqs6/DXIpJ9k=;
 b=J6I5sL4qh35xoAgPTw+LUNw3pysZG5YN8yLVeMRC5avSR8pk7i3lkoMhPg6nJAtOTIpA4/6gCoPpwrmI2BR7FWYlNCHXlGvGbEWLWWv5/P8L0GsxGvY/S0IK0FXyTVDq5xIf4sUb+Ygm3m/HplAi/f6yczGbVYZsrwG8kn8osxO/eYAug/6ZeSPhdMLQGJq8TGtQXp/nt5JQMjvLfrNQEopeGokWkvGbg7cJ1bNTL2My1xPmbLoGOoKyB+6BP9+scE9yctpUDnojEOf9PmkDYY5rg/oNcpwOLg0zMQzn1uaiVlEMBVofUIrKmCKSLvMWMJETmUFC2xeXo77Gjb3zYQ==
Received: from CH0PR03CA0229.namprd03.prod.outlook.com (2603:10b6:610:e7::24)
 by PH7PR22MB4447.namprd22.prod.outlook.com (2603:10b6:510:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41; Fri, 29 Mar
 2024 15:32:13 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::ff) by CH0PR03CA0229.outlook.office365.com
 (2603:10b6:610:e7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.41 via Frontend
 Transport; Fri, 29 Mar 2024 15:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.0 via Frontend Transport; Fri, 29 Mar 2024 15:32:13 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 29 Mar 2024 08:32:10 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <philmd@linaro.org>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v6 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Fri, 29 Mar 2024 09:31:54 -0600
Message-ID: <20240329153155.17840-2-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329153155.17840-1-aidan_leuck@selinc.com>
References: <20240329153155.17840-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|PH7PR22MB4447:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b9f2c3-2473-4eff-5df5-08dc50056839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8JFqaLSdyvnVx8kI15sYJCWyyHmcM5JFjqCY8fRRRJQ4THVaLfNflG0r7o5BMwXTzXGXUgnXmK4qbyZ3qV9de+p5OcQDmoc93jkQb2CEhXr/doZPSdugx8KU8cVL2qYIdKni0em8KKKHx+V9qcFapBKwkGhSQIt71Nnhz7G10XnsBopexl2B11gogaoiloUYWbasyFzUtFhtk1mxgeBIGwakaUSWw/YupOyFSwnQfn73X1zphLNTG3nA/1g460qcYM41cvWS+0Nts+C3++rmzktDLupRqVdMwCWIC5aga/dS3wQqim5xETMN4askUSCaWo7/yLmgaYQcfsFCDigPMoeQGBXsCts03ot5KRZw5Pgvz73+mRR8/lpdxW2Qe38y1htNR4Wy5F3Y69iY3AXzQc8bJH8jIEVlklYwhFMzZKLhm7NCCS5AfUq5XIkfxG0Eqj8Bs62yNsJ8UR0c+CJVRJFgpZYiUU5zXP8HenDcCQcRTxIEJlLs+UxpgWcdcUxJ8txXolW8C4Hhpt9Dtgsi9ejhh8z/qwMU5QrrK0ZJXfNnyW1d3hAabrQvcfGM6NluTYPflzVqUruTB5eAVLjtluQrxOm/fD65jFEV56561U2aRlktrn+eotc1Sl5RTRcX68LA29klGfMcroNru2k40lo7aZIooNO2k1adf6ess9y8WEmVixqiIf6BlgqDd6R15OGa0F9UsWQ0NihdaD0AA==
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:32:13.2010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b9f2c3-2473-4eff-5df5-08dc50056839
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB4447
X-Proofpoint-GUID: I27AaSJ79f4xH2JKfLEElpNoIs8IQhWg
X-Proofpoint-ORIG-GUID: I27AaSJ79f4xH2JKfLEElpNoIs8IQhWg
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290136
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=88182a685f=aidan_leuck@selinc.com;
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


