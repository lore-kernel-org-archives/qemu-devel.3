Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B86DBC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 22:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rn44G-0000bo-SP; Wed, 20 Mar 2024 18:05:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780965bb6d=aidan_leuck@selinc.com>)
 id 1rn44D-0000bd-O5
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:05:49 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=780965bb6d=aidan_leuck@selinc.com>)
 id 1rn449-0001P3-3c
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 18:05:49 -0400
Received: from pps.filterd (m0136176.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42KLmOAA006879; Wed, 20 Mar 2024 15:05:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding:content-type; s=sel1; bh=2xvHhZYA68lc
 +Y7FDMCxTUQMQTQYOsTqukya9UFQv/A=; b=D0HgXkdmY8NoowiBErNW7XL7y07h
 jCQ1LQDrcyRPoeDNNpNrHfrjsl6mf6MaOgDrzyBIq4i63xut50UE/xyBZyya36aD
 86iP5hX8U2nqWk2w14gKYWPqPGFl95gJqKi8/PiG4LAqWVlvq+Bsm8fAwMn+W5IH
 bI5rWw0oPrwp8d5FxS74mUg0tTr7bNeT+SgFE4VZAelLKt1Ylj9vs47urYPTy8TJ
 jBs70dqdLXJzG77PbhrpeReL1bnIzAYUTgxiLHpAA8oHmZb9yp0GNB5zXYJ/TdfT
 7eVkk8E6DFLFv07uamaJK9MWjNjshgISjBUhWzkwIka5/Pq8a16tdmAubA==
Received: from nam02-bn1-obe.outbound.protection.outlook.com
 (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x07y5g0f4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 20 Mar 2024 15:05:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkN43t0YM4XlGWhSfwO+MwGWjRH9kQ1Qz3v2tJY+NafPA/bwB1P+vhi+zB6kVhMf//f6ebXESBsZyNDYMabCATUfLXiy8IsqbPOnlilwR8ext2OkfhosAzNILJyBS5guqvtohpifm7tAUbSvwOFsCiiM0tpWuSf6BDNLClKXh/elfEOdrKGohUjAX5MryaygbW4NV51KGVK5rak3DOzBTmzlsmDIEOlfVUY6rZrdxkAd6LLC0tLPWUuvLGcH+IKZ71g/e+LZcklP8RYuHKu1485F3F486ktYgNfDbDpMen0hWp0laflupWYvVi9jhvEqSe8AfsftPkrdwV7SpRQVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xvHhZYA68lc+Y7FDMCxTUQMQTQYOsTqukya9UFQv/A=;
 b=Yk919XtCgGr0UB1gDz38Ttulik8RXSWqJYVAiC9UYhmZwsFqSa4Z8i2SkbPsJhmZNtORNeVAAOrymwYOrNsmStdjllcC01CfFLbE5dDD9pspsUp3ESWTb1uP4bUDEcvdYk8Ee8TJ1g2/xTEIFD2ZSByPNSEoXtbDcSyNyyEB4mAzC+9wgwUZ1YCO+5+zWJa0Ia2xbnSucWaUauAYM9AkM5ujgWq7iLxXobdZYWDrOyoLljKePc1YhEsTzN8W5vnCvnPwty43WquzRnw9Ga9rZdUHf/I1Tbovad1sc/XxTlxXdOYw4n6ubuu0AIa7/71/fx8mETAOGc3A+6scVRjSWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xvHhZYA68lc+Y7FDMCxTUQMQTQYOsTqukya9UFQv/A=;
 b=lEVBDamkPs4uvGRSoGdHR8i5lubbFTiS8Tpxr2M5PAZW8mmE32e/FmhsDRkuQi5OrA5tgZBRuMmmUSv4zYsaotD/7G/qgXFzyAlu46lBWxY8q4sbOZy6EmFQ+ho1JUcyUcsJlms0t+Q93mWdRPqt1ngpXoF4VSEltLpLT70UkL/xMsZDRGznMgx38h705PAQ9IzXngvd5bNDXTDxN5Zj1aaDHUXW1oyuzi7tDljrlZ5J8Eg+RZrE84k/Apf+BzfuEw/P62AFqClOF9h0HC9qG1t8S9vPeRDC1bMPmAyo2i6vCJtuNm2m4UZ2FeIehHYklsHP9dMNZzd2aFJh1LO30A==
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by IA0PR22MB4561.namprd22.prod.outlook.com (2603:10b6:208:48e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Wed, 20 Mar
 2024 22:05:31 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::16) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Wed, 20 Mar 2024 22:05:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 22:05:30 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 20 Mar 2024 15:04:57 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, Aidan Leuck <aidan_leuck@selinc.com>
Subject: [PATCH v2 0/2] Implement QEMU GA commands for Windows
Date: Wed, 20 Mar 2024 16:04:17 -0600
Message-ID: <20240320220417.1930447-1-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|IA0PR22MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: ec4bd7dc-4304-407d-16c5-08dc4929dbdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PaORW/xexIo5ok8iNhd6GKFEhj3ZJk3OGKOls/p/sJV4IZuiejAbLg9edTcLOLpeBfHJHtkrX5JNOKnb43Ldraf6e8MHVnGf+EW3C64w90piJk6V0TlVOESDJwW8Y73mTZjjmTAksaq9dovxEBONxVFgKIgjgLoyspXy1GWDWgEfPf3CASwwOichgVajfYu0eZbUAAqrQwVttbV6oTPfmDTXKy1npj2ryPwKhjGxWaG+E06i1kCuzTtCs0eqRy09yrd9vP/hrR5AC57JoHjC6IdlLWzcfqHe2cx4XfXlxl0EDu+KB0iPRU9oOtzEMdCbazxDieDVlhhlliz9XpOM0WtqvT7/SeNlJBgFVNZlMATbHD73nMiXWfPnXRi8gTsxMY0FLcxmbw0EPft31HQ93LBTtedew6K6zQBsIA/hFOyFZClhdPT5RdSuAbGa7qB6iEtdMULTDwTc+RVFJ+3daROqBnca9GOe+Wh4EnZNMGZ+hu+CMRXLvyVb/Q6Sb0IEl/J2/+Ts8oVBZkl0WEohQK1FstjtoIMkKb7HGvo5/nwh+T9TSE9bZDLFHXKFeccTOMAPtbiyiaA/lA8cm+mjSqXVivX/gZkNcWbapcoGp1VWmtKGFd1bVq44LHapQ6iX2nYpN/L2mKzIT3JR4M58KAlki32JemjqpG2opEl9ya/4jw1jgmNaq9lQSOqVv9PB/9weg1VGzZz9AjTPFmN/baROmn0plvxI66QL03x/qKdDzOoikfijtQXHmvygmbCw
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 22:05:30.8635 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec4bd7dc-4304-407d-16c5-08dc4929dbdb
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR22MB4561
X-Proofpoint-ORIG-GUID: JljwxU64th6oShJLqtM_bHJ-izIl6UrA
X-Proofpoint-GUID: JljwxU64th6oShJLqtM_bHJ-izIl6UrA
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200176
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=780965bb6d=aidan_leuck@selinc.com;
 helo=mx0b-000e8d01.pphosted.com
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

* Fixed styling errors
* Moved from wcstombs to g_utf functions
* Removed unnecessary if checks on calls to free
* Fixed copyright headers
* Refactored create_acl functions into base function, admin function and user function
* Removed unused user count function
* Split up refactor into a separate patch

Aidan Leuck (2):
  Implement QEMU GA commands for Windows
  Factored out common functions between POSIX and Windows implementation

 qga/commands-posix-ssh.c   |  47 +--
 qga/commands-ssh-core.c    |  57 +++
 qga/commands-ssh-core.h    |  15 +
 qga/commands-windows-ssh.c | 759 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  27 ++
 qga/meson.build            |  12 +-
 qga/qapi-schema.json       |  22 +-
 7 files changed, 881 insertions(+), 58 deletions(-)
 create mode 100644 qga/commands-ssh-core.c
 create mode 100644 qga/commands-ssh-core.h
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

-- 
2.34.1

From b77264e7ba7390adeaaa9d5df707c60693d78c16 Mon Sep 17 00:00:00 2001
From: Aidan Leuck <aidan_leuck@selinc.com>
Date: Wed, 20 Mar 2024 15:36:18 -0600
Subject: [PATCH v2 1/2] Implement QEMU GA commands for Windows

Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
---
 qga/commands-windows-ssh.c | 823 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   9 +-
 qga/qapi-schema.json       |  22 +-
 4 files changed, 867 insertions(+), 13 deletions(-)
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
new file mode 100644
index 0000000000..e9faae90fc
--- /dev/null
+++ b/qga/commands-windows-ssh.c
@@ -0,0 +1,823 @@
+/*
+ * QEMU Guest Agent win32-specific command implementations for SSH keys.
+ * The implementation is opinionated and expects the SSH implementation to
+ * be OpenSSH.
+ *
+ * Copyright Schweitzer Engineering Laboratories. 2024
+ *
+ * Authors:
+ *  Aidan Leuck <aidan_leuck@selinc.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include <aclapi.h>
+#include <qga-qapi-types.h>
+
+#include "commands-windows-ssh.h"
+#include "guest-agent-core.h"
+#include "limits.h"
+#include "lmaccess.h"
+#include "lmapibuf.h"
+#include "lmerr.h"
+#include "qapi/error.h"
+
+#include "qga-qapi-commands.h"
+#include "sddl.h"
+#include "shlobj.h"
+#include "userenv.h"
+
+#define AUTHORIZED_KEY_FILE "authorized_keys"
+#define AUTHORIZED_KEY_FILE_ADMIN "administrators_authorized_keys"
+#define LOCAL_SYSTEM_SID "S-1-5-18"
+#define ADMIN_SID "S-1-5-32-544"
+#define WORLD_SID "S-1-1-0"
+
+/*
+ * Reads the authorized_keys file and returns an array of strings for each entry
+ * parameters:
+ * path -> Path to the authorized_keys file
+ * errp -> Error structure that will contain errors upon failure.
+ * returns: Array of strings, where each entry is an authorized key.
+ */
+static GStrv read_authkeys(const char *path, Error **errp)
+{
+  g_autoptr(GError) err = NULL;
+  g_autofree char *contents = NULL;
+
+  if (!g_file_get_contents(path, &contents, NULL, &err)) {
+    error_setg(errp, "failed to read '%s': %s", path, err->message);
+    return NULL;
+  }
+
+  return g_strsplit(contents, "\n", -1);
+}
+
+/*
+ * Checks if a OpenSSH key is valid
+ * parameters:
+ * key* Key to check for validity
+ * errp -> Error structure that will contain errors upon failure.
+ * returns: true if key is valid, false otherwise
+ */
+static bool check_openssh_pub_key(const char *key, Error **errp)
+{
+  /* simple sanity-check, we may want more? */
+  if (!key || key[0] == '#' || strchr(key, '\n')) {
+    error_setg(errp, "invalid OpenSSH public key: '%s'", key);
+    return false;
+  }
+
+  return true;
+}
+
+/*
+ * Checks if all openssh keys in the array are valid
+ * parameters:
+ * keys -> Array of keys to check
+ * errp -> Error structure that will contain errors upon failure.
+ * returns: true if all keys are valid, false otherwise
+ */
+static bool check_openssh_pub_keys(strList *keys, size_t *nkeys, Error **errp)
+{
+  size_t n = 0;
+  strList *k;
+
+  for (k = keys; k != NULL; k = k->next) {
+    if (!check_openssh_pub_key(k->value, errp)) {
+      return false;
+    }
+    n++;
+  }
+
+  if (nkeys) {
+    *nkeys = n;
+  }
+  return true;
+}
+
+/*
+ * Frees userInfo structure. This implements the g_auto cleanup
+ * for the structure.
+ */
+void free_userInfo(PWindowsUserInfo info)
+{
+  g_free(info->sshDirectory);
+  g_free(info->authorizedKeyFile);
+  LocalFree(info->SSID);
+  g_free(info->username);
+  g_free(info);
+}
+
+/*
+ * Gets the admin SSH folder for OpenSSH. OpenSSH does not store
+ * the authorized_key file in the users home directory for security reasons and
+ * instead stores it at %PROGRAMDATA%/ssh. This function returns the path to
+ * that directory on the users machine parameters: errp -> error structure to
+ * set when an error occurs returns: The path to the ssh folder in %PROGRAMDATA%
+ * or NULl if an error occurred.
+ */
+static char *get_admin_ssh_folder(Error **errp)
+{
+  // Allocate memory for the program data path
+  g_autofree char *programDataPath = NULL;
+  char *authkeys_path = NULL;
+  PWSTR pgDataW;
+  GError *gerr = NULL;
+
+  // Get the KnownFolderPath on the machine.
+  HRESULT folderResult =
+      SHGetKnownFolderPath(&FOLDERID_ProgramData, 0, NULL, &pgDataW);
+  if (folderResult != S_OK) {
+    error_setg(errp, "Failed to retrieve ProgramData folder");
+    goto error;
+  }
+
+  // Convert from a wide string back to a standard character string.
+  programDataPath = g_utf16_to_utf8(pgDataW, -1, NULL, NULL, &gerr);
+  if (!programDataPath) {
+    goto error;
+  }
+
+  // Build the path to the file.
+  authkeys_path = g_build_filename(programDataPath, "ssh", NULL);
+  CoTaskMemFree(pgDataW);
+  return authkeys_path;
+
+error:
+  CoTaskMemFree(pgDataW);
+  
+  if (gerr) {
+    error_setg(errp,"Failed to convert program data path from wide string to standard utf 8 string. %s", gerr->message);
+    g_error_free(gerr);
+  }
+
+  return NULL;
+}
+
+/*
+ * Gets the path to the SSH folder for the specified user. If the user is an
+ * admin it returns the ssh folder located at %PROGRAMDATA%/ssh. If the user is
+ * not an admin it returns %USERPROFILE%/.ssh parameters: username -> Username
+ * to get the SSH folder for isAdmin -> Whether the user is an admin or not errp
+ * -> Error structure to set any errors that occur. returns: path to the ssh
+ * folder as a string.
+ */
+static char *get_ssh_folder(const char *username, const bool isAdmin,
+                            Error **errp)
+{
+  if (isAdmin) {
+    return get_admin_ssh_folder(errp);
+  }
+
+  // If not an Admin the SSH key is in the user directory.
+  DWORD maxSize = MAX_PATH;
+  g_autofree char* profilesDir = g_malloc(maxSize);
+
+  // Get the user profile directory on the machine.
+  BOOL ret = GetProfilesDirectory(profilesDir, &maxSize);
+  if (!ret) {
+    error_setg_win32(errp, GetLastError(),
+                     "failed to retrieve profiles directory");
+    return NULL;
+  }
+
+  // Builds the filename
+  return g_build_filename(profilesDir, username, ".ssh", NULL);
+}
+
+/*
+ * Creates an entry for the everyone group when the user is an Administrator
+ * This is consistent with the folder permissions that OpenSSH creates when it
+ * is installed Anyone can read the file, but only Administrators and SYSTEM can
+ *  modify the file. parameters: userInfo -> Information about the current user
+ * pACL -> Pointer to an ACL structure
+ *  errp -> Error structure to set any errors that occur
+ *  returns -> 1 on success, 0 otherwise
+ */
+static bool create_acl_admin(PWindowsUserInfo userInfo, PACL *pACL,
+                             Error **errp)
+{
+  PSID everyonePSID = NULL;
+
+  const int aclSize = 1;
+  EXPLICIT_ACCESS eAccess[1];
+
+  // Zero out memory for the explicit access array
+  ZeroMemory(&eAccess, aclSize * sizeof(EXPLICIT_ACCESS));
+
+  // Create an entry for everyone (so they can at least read the folder).
+  // This is consistent with other folders located in %PROGRAMDATA%
+  bool converted = ConvertStringSidToSid(WORLD_SID, &everyonePSID);
+  if (!converted) {
+    error_setg_win32(errp, GetLastError(), "failed to retrieve Admin SID");
+    goto error;
+  }
+
+  // Set permissions for everyone group (they can only read the files)
+  eAccess[0].grfAccessPermissions = GENERIC_READ;
+  eAccess[0].grfAccessMode = SET_ACCESS;
+  eAccess[0].grfInheritance = NO_INHERITANCE;
+  eAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+  eAccess[0].Trustee.TrusteeType = TRUSTEE_IS_GROUP;
+  eAccess[0].Trustee.ptstrName = (LPTSTR)everyonePSID;
+
+  // Put the entries in an ACL object.
+  PACL pNewACL = NULL;
+  DWORD setResult;
+
+  // If we are given a pointer that is already initialized, then we can merge
+  // the existing entries instead of overwriting them.
+  if (*pACL) {
+    setResult = SetEntriesInAcl(aclSize, eAccess, *pACL, &pNewACL);
+  }
+  else {
+    setResult = SetEntriesInAcl(aclSize, eAccess, NULL, &pNewACL);
+  }
+
+  if (setResult != ERROR_SUCCESS) {
+    error_setg_win32(errp, GetLastError(),
+                     "failed to set ACL entries for admin user %s %lu",
+                     userInfo->username, setResult);
+    goto error;
+  }
+
+  LocalFree(everyonePSID);
+
+  // Free the old memory since we are going to overwrite the users
+  // pointer
+  LocalFree(*pACL);
+  *pACL = pNewACL;
+
+  return true;
+
+error:
+  LocalFree(everyonePSID);
+  return false;
+}
+
+/*
+ * Creates an entry for the user so they can access the ssh folder in their
+ * userprofile userInfo -> Information about the current user pACL -> Pointer to
+ * an ACL structure errp -> Error structure to set any errors that occur returns
+ * -> 1 on success, 0 otherwise
+ */
+static bool create_acl_user(PWindowsUserInfo userInfo, PACL *pACL, Error **errp)
+{
+  const int aclSize = 1;
+  PACL newACL = NULL;
+  EXPLICIT_ACCESS eAccess[1];
+  PSID userPSID = NULL;
+
+  // Zero out memory for the explicit access array
+  ZeroMemory(&eAccess, aclSize * sizeof(EXPLICIT_ACCESS));
+
+  // Get a pointer to the internal SID object in Windows
+  bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
+  if (!converted) {
+    error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID",
+                     userInfo->username);
+    goto error;
+  }
+
+  // Set the permissions for the user.
+  eAccess[0].grfAccessPermissions = GENERIC_ALL;
+  eAccess[0].grfAccessMode = SET_ACCESS;
+  eAccess[0].grfInheritance = NO_INHERITANCE;
+  eAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+  eAccess[0].Trustee.TrusteeType = TRUSTEE_IS_USER;
+  eAccess[0].Trustee.ptstrName = (LPTSTR)userPSID;
+
+  // Set the ACL entries
+  DWORD setResult;
+
+  // If we are given a pointer that is already initialized, then we can merge
+  // the existing entries instead of overwriting them.
+  if (*pACL) {
+    setResult = SetEntriesInAcl(aclSize, eAccess, *pACL, &newACL);
+  }
+  else {
+    setResult = SetEntriesInAcl(aclSize, eAccess, NULL, &newACL);
+  }
+
+  if (setResult != ERROR_SUCCESS) {
+    error_setg_win32(errp, GetLastError(),
+                     "failed to set ACL entries for user %s %lu",
+                     userInfo->username, setResult);
+    goto error;
+  }
+
+  // Free any old memory since we are going to overwrite the users pointer.
+  LocalFree(*pACL);
+  *pACL = newACL;
+
+  LocalFree(userPSID);
+  return true;
+error:
+  LocalFree(userPSID);
+  return false;
+}
+
+/*
+ * Creates a base ACL for both normal users and admins to share
+ * pACL -> Pointer to an ACL structure
+ * errp -> Error structure to set any errors that occur
+ * returns -> 1 on success, 0 otherwise
+ */
+static bool create_acl_base(PACL *pACL, Error **errp)
+{
+  PSID adminGroupPSID = NULL;
+  PSID systemPSID = NULL;
+
+  const int aclSize = 2;
+  EXPLICIT_ACCESS eAccess[2];
+
+  // Zero out memory for the explicit access array
+  ZeroMemory(&eAccess, aclSize * sizeof(EXPLICIT_ACCESS));
+
+  // Create an entry for the system user.
+  const char *systemSID = LOCAL_SYSTEM_SID;
+  bool converted = ConvertStringSidToSid(systemSID, &systemPSID);
+  if (!converted) {
+    error_setg_win32(errp, GetLastError(), "failed to retrieve system SID");
+    goto error;
+  }
+
+  // set permissions for system user
+  eAccess[0].grfAccessPermissions = GENERIC_ALL;
+  eAccess[0].grfAccessMode = SET_ACCESS;
+  eAccess[0].grfInheritance = NO_INHERITANCE;
+  eAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+  eAccess[0].Trustee.TrusteeType = TRUSTEE_IS_USER;
+  eAccess[0].Trustee.ptstrName = (LPTSTR)systemPSID;
+
+  // Create an entry for the admin user.
+  const char *adminSID = ADMIN_SID;
+  converted = ConvertStringSidToSid(adminSID, &adminGroupPSID);
+  if (!converted) {
+    error_setg_win32(errp, GetLastError(), "failed to retrieve Admin SID");
+    goto error;
+  }
+
+  // Set permissions for admin group.
+  eAccess[1].grfAccessPermissions = GENERIC_ALL;
+  eAccess[1].grfAccessMode = SET_ACCESS;
+  eAccess[1].grfInheritance = NO_INHERITANCE;
+  eAccess[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+  eAccess[1].Trustee.TrusteeType = TRUSTEE_IS_GROUP;
+  eAccess[1].Trustee.ptstrName = (LPTSTR)adminGroupPSID;
+
+  // Put the entries in an ACL object.
+  PACL pNewACL = NULL;
+  DWORD setResult;
+
+  // If we are given a pointer that is already initialized, then we can merge
+  // the existing entries instead of overwriting them.
+  if (*pACL) {
+    setResult = SetEntriesInAcl(aclSize, eAccess, *pACL, &pNewACL);
+  }
+  else {
+    setResult = SetEntriesInAcl(aclSize, eAccess, NULL, &pNewACL);
+  }
+
+  if (setResult != ERROR_SUCCESS) {
+    error_setg_win32(
+        errp, GetLastError(),
+        "failed to set base ACL entries for system user and admin group %lu",
+        setResult);
+    goto error;
+  }
+
+  LocalFree(adminGroupPSID);
+  LocalFree(systemPSID);
+
+  // Free any old memory since we are going to overwrite the users pointer.
+  LocalFree(*pACL);
+
+  *pACL = pNewACL;
+
+  return true;
+
+error:
+  LocalFree(adminGroupPSID);
+  LocalFree(systemPSID);
+  return false;
+}
+
+/*
+ * Sets the access control on the authorized_keys file and any ssh folders that
+ * need to be created. For administrators the required permissions on the
+ * file/folders are that only administrators and the LocalSystem account can
+ * access the folders. For normal user accounts only the specified user,
+ * LocalSystem and Administrators can have access to the key. parameters:
+ * userInfo -> pointer to structure that contains information about the user
+ * PACL -> pointer to an access control structure that will be set upon
+ * successful completion of the function. errp -> error structure that will be
+ * set upon error. returns: 1 upon success 0 upon failure.
+ */
+static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error **errp)
+{
+  // Creates a base ACL that both admins and users will share
+  // This adds the Administrators group and the SYSTEM group
+  if (!create_acl_base(pACL, errp)) {
+    return false;
+  }
+
+  // If the user is not an admin give the user creating the key permission to
+  // access the file.
+  if (!userInfo->isAdmin) {
+    if (!create_acl_user(userInfo, pACL, errp)) {
+      return false;
+    }
+
+    return true;
+  }
+
+  // If the user is an admin allow everyone to read the keys
+  if (!create_acl_admin(userInfo, pACL, errp)) {
+    return false;
+  }
+
+  return true;
+}
+/*
+ * Create the SSH directory for the user and d sets appropriate permissions.
+ * In general the directory will be %PROGRAMDATA%/ssh if the user is an admin.
+ * %USERPOFILE%/.ssh if not an admin
+ * parameters:
+ * userInfo -> Contains information about the user
+ * errp -> Structure that will contain errors if the function fails.
+ * returns: zero upon failure, 1 upon success
+ */
+static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp)
+{
+  PACL pNewACL = NULL;
+  g_autofree PSECURITY_DESCRIPTOR pSD = NULL;
+
+  // Gets the approparite ACL for the user
+  if (!create_acl(userInfo, &pNewACL, errp)) {
+    goto error;
+  }
+
+  // Allocate memory for a security descriptor
+  pSD = g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
+  if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION)) {
+    error_setg_win32(errp, GetLastError(),
+                     "Failed to initialize security descriptor");
+    goto error;
+  }
+
+  // Associate the security descriptor with the ACL permissions.
+  if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE)) {
+    error_setg_win32(errp, GetLastError(),
+                     "Failed to set security descriptor ACL");
+    goto error;
+  }
+
+  // Set the security attributes on the folder
+  SECURITY_ATTRIBUTES sAttr;
+  sAttr.bInheritHandle = FALSE;
+  sAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
+  sAttr.lpSecurityDescriptor = pSD;
+
+  // Create the directory with the created permissions
+  BOOL created = CreateDirectory(userInfo->sshDirectory, &sAttr);
+  if (!created) {
+    error_setg_win32(errp, GetLastError(), "failed to create directory %s",
+                     userInfo->sshDirectory);
+    goto error;
+  }
+
+  // Free memory
+  LocalFree(pNewACL);
+  return true;
+error:
+  LocalFree(pNewACL);
+  return false;
+}
+
+/*
+ * Sets permissions on the authorized_key_file that is created.
+ * parameters: userInfo -> Information about the user
+ * errp -> error structure that will contain errors upon failure
+ * returns: 1 upon success, zero upon failure.
+ */
+static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)
+{
+  PACL pACL = NULL;
+  PSID userPSID;
+
+  // Creates the access control structure
+  if (!create_acl(userInfo, &pACL, errp)) {
+    goto error;
+  }
+
+  // Get the PSID structure for the user based off the string SID.
+  bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
+  if (!converted) {
+    error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID",
+                     userInfo->username);
+    goto error;
+  }
+
+  // Set the ACL on the file.
+  if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT,
+                           DACL_SECURITY_INFORMATION, userPSID, NULL, pACL,
+                           NULL) != ERROR_SUCCESS) {
+    error_setg_win32(errp, GetLastError(),
+                     "failed to set file security for file %s",
+                     userInfo->authorizedKeyFile);
+    goto error;
+  }
+
+  LocalFree(pACL);
+  LocalFree(userPSID);
+  return true;
+
+error:
+  LocalFree(pACL);
+  LocalFree(userPSID);
+  
+  return false;
+}
+
+/*
+ * Writes the specified keys to the authenticated keys file.
+ * parameters:
+ * userInfo: Information about the user we are writing the authkeys file to.
+ * authkeys: Array of keys to write to disk
+ * errp: Error structure that will contain any errors if they occur.
+ * returns: 1 if succesful, 0 otherwise.
+ */
+static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys,
+                           Error **errp)
+{
+  g_autofree char *contents = NULL;
+  g_autoptr(GError) err = NULL;
+
+  contents = g_strjoinv("\n", authkeys);
+
+  if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1, &err)) {
+    error_setg(errp, "failed to write to '%s': %s", userInfo->authorizedKeyFile,
+               err->message);
+    return false;
+  }
+
+  if (!set_file_permissions(userInfo, errp)) {
+    return false;
+  }
+
+  return true;
+}
+
+/*
+ * Retrieves information about a Windows user by their username
+ * userInfo -> Double pointer to a WindowsUserInfo structure. Upon success, it
+ * will be allocated with information about the user and need to be freed.
+ * username -> Name of the user to lookup. errp -> Contains any errors that
+ * occur. returns -> 1 upon success, 0 upon failure.
+ */
+static bool get_user_info(PWindowsUserInfo *userInfo, const char *username,
+                          Error **errp)
+{
+  DWORD infoLevel = 4;
+  LPUSER_INFO_4 uBuf = NULL;
+  g_autofree wchar_t *wideUserName = NULL;
+  GError *gerr = NULL;
+  PSID psid = NULL;
+
+  // Converts a string to a Windows wide string since the GetNetUserInfo
+  // function requires it.
+  wideUserName = g_utf8_to_utf16(username, -1, NULL, NULL, &gerr);
+  if (!wideUserName) {
+    goto error;
+  }
+
+  // allocate data
+  PWindowsUserInfo uData = g_malloc(sizeof(WindowsUserInfo));
+
+  // Set pointer so it can be cleaned up by the calle, even upon error.
+  *userInfo = uData;
+
+  // Find the information
+  NET_API_STATUS result = NetUserGetInfo(NULL, wideUserName, infoLevel, (LPBYTE *)&uBuf);
+  if (result != NERR_Success) {
+    // Give a friendlier error message if the user was not found.
+    if (result == NERR_UserNotFound) {
+      error_setg(errp, "User %s was not found", username);
+      goto error;
+    }
+
+    error_setg(errp, "Received unexpected error when asking for user info: Error Code %lu", result);
+    goto error;
+  }
+
+  // Get information from the buffer returned by NetUserGetInfo.
+  uData->username = g_strdup(username);
+  uData->isAdmin = uBuf->usri4_priv == USER_PRIV_ADMIN;
+  psid = uBuf->usri4_user_sid;
+
+  char *sidStr = NULL;
+
+  // We store the string representation of the SID not SID structure in memory.
+  // Callees wanting to use the SID structure should call ConvertStringSidToSID.
+  if (!ConvertSidToStringSid(psid, &sidStr)) {
+    error_setg_win32(errp, GetLastError(),
+                     "failed to get SID string for user %s", username);
+    goto error;
+  }
+
+  // Store the SSID
+  uData->SSID = sidStr;
+
+  // Get the SSH folder for the user.
+  char *sshFolder = get_ssh_folder(username, uData->isAdmin, errp);
+  if (sshFolder == NULL) {
+    goto error;
+  }
+
+  // Get the authorized key file path
+  const char *authorizedKeyFile = uData->isAdmin ? AUTHORIZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE;
+  char *authorizedKeyPath = g_build_filename(sshFolder, authorizedKeyFile, NULL);
+  uData->sshDirectory = sshFolder;
+  uData->authorizedKeyFile = authorizedKeyPath;
+
+  // Free
+  NetApiBufferFree(uBuf);
+  return true;
+error:
+  if (uBuf) {
+    NetApiBufferFree(uBuf);
+  }
+  if (gerr) {
+    error_setg(errp, "Failed to convert username %s to wide string. %s",
+               username, gerr->message);
+    g_error_free(gerr);
+  }
+
+  return false;
+}
+
+/*
+ * Gets the list of authorized keys for a user.
+ * parameters:
+ * username -> Username to retrieve the keys for.
+ * errp -> Error structure that will display any errors through QMP.
+ * returns: List of keys associated with the user.
+ */
+GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char *username,
+                                                       Error **errp)
+{
+  GuestAuthorizedKeys *keys = NULL;
+  g_auto(GStrv) authKeys = NULL;
+  g_autoptr(GuestAuthorizedKeys) ret = NULL;
+  g_auto(PWindowsUserInfo) userInfo = NULL;
+
+  // Gets user information
+  if (!get_user_info(&userInfo, username, errp)) {
+    return NULL;
+  }
+
+  // Reads authekys for the user
+  authKeys = read_authkeys(userInfo->authorizedKeyFile, errp);
+  if (authKeys == NULL) {
+    return NULL;
+  }
+
+  // Set the GuestAuthorizedKey struct with keys from the file
+  ret = g_new0(GuestAuthorizedKeys, 1);
+  for (int i = 0; authKeys[i] != NULL; i++) {
+    g_strstrip(authKeys[i]);
+    if (!authKeys[i][0] || authKeys[i][0] == '#') {
+      continue;
+    }
+
+    QAPI_LIST_PREPEND(ret->keys, g_strdup(authKeys[i]));
+  }
+
+  // Steal the pointer because it is up for the callee to deallocate the memory.
+  keys = g_steal_pointer(&ret);
+  return keys;
+}
+
+/*
+ * Adds an ssh key for a user.
+ * parameters:
+ * username -> User to add the SSH key to
+ * strList -> Array of keys to add to the list
+ * has_reset -> Whether the keys have been reset
+ * reset -> Boolean to reset the keys (If this is set the existing list will be
+ * cleared) and the other key reset. errp -> Pointer to an error structure that
+ * will get returned over QMP if anything goes wrong.
+ */
+void qmp_guest_ssh_add_authorized_keys(const char *username, strList *keys,
+                                       bool has_reset, bool reset, Error **errp)
+{
+  g_auto(PWindowsUserInfo) userInfo = NULL;
+  g_auto(GStrv) authkeys = NULL;
+  strList *k;
+  size_t nkeys, nauthkeys;
+
+  // Make sure the keys given are valid
+  if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
+    return;
+  }
+
+  // Gets user information
+  if (!get_user_info(&userInfo, username, errp)) {
+    return;
+  }
+
+  // Determine whether we should reset the keys
+  reset = has_reset && reset;
+  if (!reset) {
+    // If we are not resetting the keys, read the existing keys into memory
+    authkeys = read_authkeys(userInfo->authorizedKeyFile, NULL);
+  }
+
+  // Check that the SSH key directory exists for the user.
+  if (!g_file_test(userInfo->sshDirectory, G_FILE_TEST_IS_DIR)) {
+    BOOL success = create_ssh_directory(userInfo, errp);
+    if (!success) {
+      return;
+    }
+  }
+
+  // Reallocates the buffer to fit the new keys.
+  nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
+  authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
+
+  // zero out the memory for the reallocated buffer
+  memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
+
+  // Adds the keys
+  for (k = keys; k != NULL; k = k->next) {
+    // Check that the key doesn't already exist
+    if (g_strv_contains((const gchar *const *)authkeys, k->value)) {
+      continue;
+    }
+
+    authkeys[nauthkeys++] = g_strdup(k->value);
+  }
+
+  // Write the authkeys to the file.
+  write_authkeys(userInfo, authkeys, errp);
+}
+
+/*
+ * Removes an SSH key for a user
+ * parameters:
+ * username -> Username to remove the key from
+ * strList -> List of strings to remove
+ * errp -> Contains any errors that occur.
+ */
+void qmp_guest_ssh_remove_authorized_keys(const char *username, strList *keys,
+                                          Error **errp)
+{
+  g_auto(PWindowsUserInfo) userInfo = NULL;
+  g_autofree struct passwd *p = NULL;
+  g_autofree GStrv new_keys = NULL; /* do not own the strings */
+  g_auto(GStrv) authkeys = NULL;
+  GStrv a;
+  size_t nkeys = 0;
+
+  // Validates the keys passed in by the user
+  if (!check_openssh_pub_keys(keys, NULL, errp)) {
+    return;
+  }
+
+  // Gets user information
+  if (!get_user_info(&userInfo, username, errp)) {
+    return;
+  }
+
+  // Reads the authkeys for the user
+  authkeys = read_authkeys(userInfo->authorizedKeyFile, errp);
+  if (authkeys == NULL) {
+    return;
+  }
+
+  // Create a new buffer to hold the keys
+  new_keys = g_new0(char *, g_strv_length(authkeys) + 1);
+  for (a = authkeys; *a != NULL; a++) {
+    strList *k;
+
+    // Filters out keys that are equal to ones the user specified.
+    for (k = keys; k != NULL; k = k->next) {
+      if (g_str_equal(k->value, *a)) {
+        break;
+      }
+    }
+
+    if (k != NULL) {
+      continue;
+    }
+
+    new_keys[nkeys++] = *a;
+  }
+
+  // Write the new authkeys to the file.
+  write_authkeys(userInfo, new_keys, errp);
+}
diff --git a/qga/commands-windows-ssh.h b/qga/commands-windows-ssh.h
new file mode 100644
index 0000000000..7d68a1bcef
--- /dev/null
+++ b/qga/commands-windows-ssh.h
@@ -0,0 +1,26 @@
+/*
+ * Header file for commands-windows-ssh.c
+ *
+ * Copyright Schweitzer Engineering Laboratories. 2024
+ *
+ * Authors:
+ *  Aidan Leuck <aidan_leuck@selinc.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include <glib/gstrfuncs.h>
+#include <stdbool.h>
+typedef struct WindowsUserInfo {
+  char *sshDirectory;
+  char *authorizedKeyFile;
+  char *username;
+  char *SSID;
+  bool isAdmin;
+} WindowsUserInfo;
+
+typedef WindowsUserInfo *PWindowsUserInfo;
+
+void free_userInfo(PWindowsUserInfo info);
+G_DEFINE_AUTO_CLEANUP_FREE_FUNC(PWindowsUserInfo, free_userInfo, NULL);
diff --git a/qga/meson.build b/qga/meson.build
index 1c3d2a3d1b..4c4a493ec5 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -65,14 +65,15 @@ qga_ss.add(files(
   'commands.c',
   'guest-agent-command-state.c',
   'main.c',
-  'cutils.c',
+  'cutils.c'
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
@@ -93,7 +94,7 @@ gen_tlb = []
 qga_libs = []
 if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
-               '-lsetupapi', '-lcfgmgr32']
+               '-lsetupapi', '-lcfgmgr32', '-luserenv']
   if have_qga_vss
     qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-lstdc++', '-Wl,--enable-stdcall-fixup']
     subdir('vss-win32')
@@ -203,4 +204,4 @@ if false
        qga_ssh_test,
        env: test_env,
        suite: ['unit', 'qga'])
-endif
+endif
\ No newline at end of file
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9554b566a7..ffa7eb4082 100644
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
@@ -1792,4 +1796,4 @@
 ##
 { 'command': 'guest-get-cpustats',
   'returns': ['GuestCpuStats']
-}
+}
\ No newline at end of file
-- 
2.34.1


From 1dbc359096133baeceaed383cc98225bc1a983d3 Mon Sep 17 00:00:00 2001
From: Aidan Leuck <aidan_leuck@selinc.com>
Date: Wed, 20 Mar 2024 15:40:13 -0600
Subject: [PATCH v2 2/2] Factored out common functions between POSIX and
 Windows implementation

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


