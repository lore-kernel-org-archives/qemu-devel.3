Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC31BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 23:17:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn5Ar-0006gd-D0; Wed, 20 Mar 2024 19:16:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780965bb6d=aidan_leuck@selinc.com>)
 id 1rn5Ao-0006dE-P9
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 19:16:42 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780965bb6d=aidan_leuck@selinc.com>)
 id 1rn5Al-0005BT-Th
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 19:16:42 -0400
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KLmLO5021832; Wed, 20 Mar 2024 16:16:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=TIWswMUwU708
 5K4slczuCu0C5wzCwy1y7XFU5sR4T40=; b=X8tQ2J5FDpTH29HHfzCGaa/Y3r9U
 aE3U1UMjTdRkZf0jgSIb60CaMOlX9Qb+LCrq/K3/60NA3GY5xhR0h0SUJgSVNFhS
 sycIehOhcV3tccAm7oW8E91EaAYNkhYriesmo8efjw7emltCfGLel+EvSrk0TWX+
 uNvHxXM8EwCrwditfcfZx1Rbo4+N39dG9sos6rd8c24ZiXEyHaK3IfPIAz2sWc9q
 9R0nYsxTSjRS7HtnW3IasSo/iVKVF8BeCNKptHhoq9IN2rm8RFp5AGckaS58etJ3
 MPCofsW9ij0fLuX1PP93lm7Q2uO6hGerjqQg7NdzaQZnwk6wEQMkE18fIw==
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x07y601qt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 16:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ELXlKtwzEVLWmMmbjl5mbIEOp0xoc5QeJQm88a7m801YWs28gAf0bnZfmDCJ2fqZymgyimGHzD5EH4MtQdSZToGUo0y24FXGzCcBFe7KR4Lmc/Q3FSy6BlitudBaqX0RWkPAOkzuZdJ/YYqw21rEXO25MyuwR+hMkzMmS8qZE172wYqFz4UXY9wouvfHy8UtVxlyodRbbyc1J56V7c/LQa92mdHp71EkpHxba6SRWkKA4OLgBjZZkCrAtzSRJm5bnwwJFrUE++502fCweux9BQR4b7Div71Dsn4501+QVMFb5bmQkQRmYIZzQpd3tS0eh8jfZQQzuK53bqknkEozDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TIWswMUwU7085K4slczuCu0C5wzCwy1y7XFU5sR4T40=;
 b=CMFA9+t0Ey7WOPQ223w124vUfkNOewDhaiV9Vys/dOGpqGhghfkjjbZAFe+ldgz3nYFAzIUrxy/Q0aMFA3u4cq58AfaRyhJVKOv87jCJWENKiP1CcEeXLGYT7XVEBNkAATDzzNN6UoSzkt68IRMQ5JBHaiIG1ZFU3lhIwl7Uf2ZDtamTEIsZgcI7Prz12IFmdc6UGyGuUZJjx5qWy9+QRcqanZRpnNwKPbMPxc5xuAhi1cHL9RUziC+lbqno3Y8orZrZFmE5UnPUS2UrO/fi5U/AteV4KwDbuzfDKkLZZwuRw4Xt3nMXuiQ9LqkikwYWztsEaQuKr94LHl04M+jlSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TIWswMUwU7085K4slczuCu0C5wzCwy1y7XFU5sR4T40=;
 b=LTUQ9At/kt1b0HP91pnciAhZtjfxgUPZsbhDiIlVWS4A8zPqSTIRyjyeNbr23ks3YeB4JyyMlm056voyw6ubS1nDHGwTeW+n463FbkdKNXDbTczXWyTY3vLZomCkGIpQ+K8mv+WC7JEZTQwVtIVzN7l0W+8tErKX21M09+CRBL0hs/Jbf/SLCB1F5VUWBlm5dF7xnTeXRkTBeZoTPgFbbSztxIwUd93G7GSzk0e0gIxbr5fBTRmPA88NXB9ewXj8uKxfRi/cSvlyw8nRWnD2yJJL6DUGp/E49ijBEfa9m1hs25upCUBdpKV8S/fB9vhjg9oon5npeV1Z05W7J3x+lQ==
Received: from BN9PR03CA0198.namprd03.prod.outlook.com (2603:10b6:408:f9::23)
 by EA2PR22MB5357.namprd22.prod.outlook.com (2603:10b6:303:250::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Wed, 20 Mar
 2024 23:16:34 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::26) by BN9PR03CA0198.outlook.office365.com
 (2603:10b6:408:f9::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 23:16:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 23:16:34 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Mar 2024 16:16:31 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, Aidan Leuck <aidan_leuck@selinc.com>
Subject: [PATCH v2 2/2] Implement QEMU GA commands for Windows
Date: Wed, 20 Mar 2024 17:16:23 -0600
Message-ID: <20240320231623.2005756-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|EA2PR22MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b51c7b8-7869-4ea5-3a76-08dc4933c8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKaqT+SvhgNIoOg5FfIvkrAPnnbd4GV0mohQtSJ9EVJruJuZ6polAXmHv+1cJ2s6JIrP/W/AZBZnhqDqzPfn3RRhHIoBgxUTKwv8HeVPM+w4G3mf1zFIWmCx/8Y96jH8M9KYTPoT9m9XacZifnRGG14JkosRdASRuZiQTS6e5xqSmOFcdG1Cv+JJpUgeVARzXtoyyA4hojxnaRCV054axaLwDZEui2x663x0YnpiAG7XRPT5KnYAyQ0zDpNm14Nm7ukegzm8XH0CPEh6VqeSZNcykmkp1+DlzpAjK5sj4Lg12FWhF9Gm+CB73s/njqMd1ZSlzUtzyNVXskDaMd9AkmrOE9jS+tNkl6TGFL/i8WY2SLWDwyUtJfqkQ4QjoyjKfN8mKHGxFWYgszW15e+f9WBg9+/z0os4sAqUkwS5o5M+zVpZSk5tr1A6aLBBzFuFZM0659Ce02ZLNxMQORUhWO7zF+AN8CHW0MS5zzArz8Dq5QiGdAy57T66aGz/s2A9yfvA8dqgdJuvYhXnwQnFAZ6+6eQxWOu0wDlqduxuPrE71lzvqMkFnzj98LrYmI7Vu1pdj8d3iG7k6VGr6DVUd1tROOKkEsfs+7Z+RqBqQHHxE8SWiWljnyRKFS7/jQ4Qsw1mSC6/VUhi1+Y7B/8PWRh1PSipfdEqqi8uL+FYvLaCuCLOEtBJARzJEW2plShs0ewNk7OaGNp2hwCypDb2c0N54dhT4IExNBhaFi6TIQ+FCeGVyOgt4FO/GEFMs7Bs
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 23:16:34.0689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b51c7b8-7869-4ea5-3a76-08dc4933c8ea
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2PR22MB5357
X-Proofpoint-GUID: OEIJDJ1rwNNBO_FEHjKasejxyVhuGIgz
X-Proofpoint-ORIG-GUID: OEIJDJ1rwNNBO_FEHjKasejxyVhuGIgz
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 mlxlogscore=996 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403140001
 definitions=main-2403200185
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=780965bb6d=aidan_leuck@selinc.com;
 helo=mx0a-000e8d01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Aidan Leuck <aidan_leuck@selinc.com>

Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
---
 qga/commands-posix-ssh.c   | 47 +---------------------------
 qga/commands-ssh-core.c    | 57 +++++++++++++++++++++++++++++++++
 qga/commands-ssh-core.h    | 15 +++++++++
 qga/commands-windows-ssh.c | 64 --------------------------------------
 qga/commands-windows-ssh.h | 15 ++++-----
 qga/meson.build            |  5 +++
 6 files changed, 86 insertions(+), 117 deletions(-)
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
index 0000000000..c77cee8a11
--- /dev/null
+++ b/qga/commands-ssh-core.c
@@ -0,0 +1,57 @@
+ /*
+  * This work is licensed under the terms of the GNU GPL, version 2 or later.
+  * See the COPYING file in the top-level directory.
+  */
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
diff --git a/qga/commands-ssh-core.h b/qga/commands-ssh-core.h
new file mode 100644
index 0000000000..9c9e992c62
--- /dev/null
+++ b/qga/commands-ssh-core.h
@@ -0,0 +1,15 @@
+/*
+ * Header file for commands-ssh-core.c
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
+GStrv read_authkeys(const char *path, Error **errp);
+bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp);
+bool check_openssh_pub_key(const char *key, Error **errp);
\ No newline at end of file
diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
index e9faae90fc..0739d694ed 100644
--- a/qga/commands-windows-ssh.c
+++ b/qga/commands-windows-ssh.c
@@ -23,7 +23,6 @@
 #include "lmapibuf.h"
 #include "lmerr.h"
 #include "qapi/error.h"
-
 #include "qga-qapi-commands.h"
 #include "sddl.h"
 #include "shlobj.h"
@@ -35,69 +34,6 @@
 #define ADMIN_SID "S-1-5-32-544"
 #define WORLD_SID "S-1-1-0"
 
-/*
- * Reads the authorized_keys file and returns an array of strings for each entry
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
diff --git a/qga/commands-windows-ssh.h b/qga/commands-windows-ssh.h
index 7d68a1bcef..6b457524e2 100644
--- a/qga/commands-windows-ssh.h
+++ b/qga/commands-windows-ssh.h
@@ -11,13 +11,14 @@
  */
 
 #include <glib/gstrfuncs.h>
-#include <stdbool.h>
-typedef struct WindowsUserInfo {
-  char *sshDirectory;
-  char *authorizedKeyFile;
-  char *username;
-  char *SSID;
-  bool isAdmin;
+
+typedef struct WindowsUserInfo
+{
+    char *sshDirectory;
+    char *authorizedKeyFile;
+    char *username;
+    char *SSID;
+    bool isAdmin;
 } WindowsUserInfo;
 
 typedef WindowsUserInfo *PWindowsUserInfo;
diff --git a/qga/meson.build b/qga/meson.build
index 4c4a493ec5..2fca6f34fc 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -65,7 +65,12 @@ qga_ss.add(files(
   'commands.c',
   'guest-agent-command-state.c',
   'main.c',
+<<<<<<< HEAD
   'cutils.c'
+=======
+  'cutils.c',
+  'commands-ssh-core.c'
+>>>>>>> windows-ssh-refactor
 ))
 if host_os == 'windows'
   qga_ss.add(files(
-- 
2.34.1

