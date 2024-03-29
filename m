Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A98C0C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 15:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqEDe-0007jH-JV; Fri, 29 Mar 2024 11:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=88182a685f=aidan_leuck@selinc.com>)
 id 1rqEDS-0007hn-8F
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:32:26 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=88182a685f=aidan_leuck@selinc.com>)
 id 1rqEDO-0000b0-HV
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 11:32:26 -0400
Received: from pps.filterd (m0136176.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42TDx0du027791; Fri, 29 Mar 2024 08:32:19 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=4uQHur8lX9Ls9FnbWa+ZkYnFzw9hcc0wbunkGaF+XWo=; b=uwi2WF1N2MAg
 RKY3J7NEHCnm+OqKyi1IbDUJYaVgDAoe8YCg9qxk02n17gE17UKWC07xdjf9Ddzk
 AR/8FH7PM6egYIoS74/nFoDxaE4C7KLT8oAvbGPiRbKReBIiO83a7ZjwTc1QbqhC
 qysRLPWqZCe20DjSYfkDfO2PbFf1/MjyrM0ICjYCpvVFxddc6nrYxZJWKBWSvu0i
 wWEU63nWld11f8SIkGsaxbV26fZRmKIXWkSd5+xpYgW0o21u98/6UwLCm5Kb5bhD
 BRzhP8zytKWB2gLLnN7O2DPLRvO0uXdH76kUG3oCXpZZ3w6WIGAORPImaoec5OMu
 0I2djn6eYw==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x4xnh17qg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 29 Mar 2024 08:32:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5hWzm/7W1K3IIW9hFR7XvltHkdA5hvV27l5IlhM5s/z1VaOOBoqrzoLL+lhWcEvh0tfnagH/UuNI8K1FDpSJfhXJEbO0dlc5B1B2IjpzgtiqMLlTIU94AzHZluIhxddys5gNXj4abiwtz13Ob5jcx2B/cV3nkI11HQP5CQomy8a24uxavcaQDhYRnjaopmt0YmUIa0rgDEDqBmQ0U4ECpWqj/8euCCGBJoCVNvQNv/4d31NhWeU2mLvgPnLb7GJa+9mYJwRHepk5qGkxV4MThFad8+kBVwEZEgEP1n2Ma42EKLtI5Myn1AF8tVxwOEqoQEsrtF9hlxxPYO5c3klWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uQHur8lX9Ls9FnbWa+ZkYnFzw9hcc0wbunkGaF+XWo=;
 b=VlAKrXVHFdBnISNeaKBVDvYpKlTBehNxdWG0ReQGEehEjeSfdT6Il6N/7R8YwnoccWx7XUCDwTVvKgDafRPWZfyLyqlbc1U2JmuuTjR6oE8IUowe5O4KiTAFqGoiO62LCRyaOPpRoze+DP5vdCz8W+oMbqAXMdkjhRH+4+gQ2KBXTM2A4y/fid2itUxA48QkSP223HQh5Bp36kvSxQW6FbEdekQ3B7lttnt9clOSd1VJmYSi6297CaB9E8ASiBaizqN9ByGJNw5BeGRYRhX8QaZCY7nXA52A0WlGwQYlUGGHkImGtf28iPiNiSoZj4Rshib+eGjUwe85lP0+fBv2Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uQHur8lX9Ls9FnbWa+ZkYnFzw9hcc0wbunkGaF+XWo=;
 b=FgvAYuB2ocYkIaXxSFnftsTNblFQVszFqBFrumCkZcSnTdgc24QbkxHDAdPM0HWaVpF+ehksrJXzfZUN01rStMmLi7eFEXwv+oiczBCM3k7f4pmdWIojU/5FeRP7gkyzpju0qmAC61/vHglnhrM2xkqo8NgnPEbl9+sNRmKqSUlMdmoryCX04MbsRQlch2S355jFbn6bCj2X+Lg6+lqr3q1WIcdJep4ojeHmTdlA414FAe4qeFqdHZIhxq84pAsAfyESDBL1tk7mzE262/+Gos0aAqVgtPiJ/JRVoKwSSSG9Lgasj/GUcIsUziKsl1ZlWRzkXzukK1SiRacJPPNlXA==
Received: from CH0PR03CA0214.namprd03.prod.outlook.com (2603:10b6:610:e7::9)
 by PH7PR22MB3117.namprd22.prod.outlook.com (2603:10b6:510:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 15:32:16 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:610:e7:cafe::e0) by CH0PR03CA0214.outlook.office365.com
 (2603:10b6:610:e7::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.40 via Frontend
 Transport; Fri, 29 Mar 2024 15:32:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.0 via Frontend Transport; Fri, 29 Mar 2024 15:32:15 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 29 Mar 2024 08:32:11 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <philmd@linaro.org>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v6 2/2] Implement SSH commands in QEMU GA for Windows
Date: Fri, 29 Mar 2024 09:31:55 -0600
Message-ID: <20240329153155.17840-3-aidan_leuck@selinc.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|PH7PR22MB3117:EE_
X-MS-Office365-Filtering-Correlation-Id: f8a94bdb-9844-4dca-fc2b-08dc500569dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yRCo1nCqqdFXicjyrNWHpn76aqE7ie+NlqRTY457B3oe6eERAK619Hv/2K41s/a5XuiFDec8zJ/3JwXmCHwotPOTaCNg/ykHG61oJESa7v/dBR48QDe+Vhb9Vm7N5qSWG03WsxKHMl0ScwZNWNhsvzC68fiHi49cH4fLfKNFs7pEIQ1vlE17PrUN/dX27m75XIw5YDbWqXB2bBZWgXywARnNEBHyZisAKnl1BLvmJ4DdlOuiKM7gMBCXA9NHUOON4cdOrlNZaHHdpN85LZA4IfBWS/Fqw0TDAe0kG9kTPhZ15DHUD8fXueNHxHBLA5HxvjdgqaGUiKaPogoux505rA0uH5CsM8vOm0Sd72bXX/YmXn5PsBZsMy032W0ARfNO7UjkK8H1CgFtqcZwshI2YV1ccrIvnfJWwu7xiwB/4yPbPaWUqHuLjYf3NXpxr4BQIguSrGroiO+Zvim9lVtn1h5lJRwfbGSfT1E5FWctM9yo4XtqZs36kMMoZEWmb4B+U87TOxOPM/MaXSfcI/gRZa6Zy5N+a04lZlqh0Hf30ssfaTlZs1dAP+z6kt8jyz2JVqMXhyCV7c88xeVpnrgXKAQtU//9MdDa28Vcpr1ogQ06Bg2/hCmRKyn/TCXZSB0ZbCCxDOvY39ztADhMT91J2pOUknTpKI65/5VKz4AjHR/I6hiCNDNPmkMZyXG4AVLgdikbvPX9VJOMakgJ6KOOYQ==
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 15:32:15.9510 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8a94bdb-9844-4dca-fc2b-08dc500569dc
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3117
X-Proofpoint-GUID: YVaoaUArP0CzdXEY-6KkJeEXR9s0BMhy
X-Proofpoint-ORIG-GUID: YVaoaUArP0CzdXEY-6KkJeEXR9s0BMhy
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxlogscore=999
 clxscore=1015 impostorscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290137
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
 qga/commands-windows-ssh.c | 789 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   5 +-
 qga/qapi-schema.json       |  17 +-
 4 files changed, 826 insertions(+), 11 deletions(-)
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
new file mode 100644
index 0000000000..bfd944f0a4
--- /dev/null
+++ b/qga/commands-windows-ssh.c
@@ -0,0 +1,789 @@
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
+#include "commands-common-ssh.h"
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
+ * Frees userInfo structure. This implements the g_auto cleanup
+ * for the structure.
+ */
+void free_userInfo(PWindowsUserInfo info)
+{
+    g_free(info->sshDirectory);
+    g_free(info->authorizedKeyFile);
+    LocalFree(info->SSID);
+    g_free(info->username);
+    g_free(info);
+}
+
+/*
+ * Gets the admin SSH folder for OpenSSH. OpenSSH does not store
+ * the authorized_key file in the users home directory for security reasons and
+ * instead stores it at %PROGRAMDATA%/ssh. This function returns the path to
+ * that directory on the users machine
+ *
+ * parameters:
+ * errp -> error structure to set when an error occurs
+ * returns: The path to the ssh folder in %PROGRAMDATA% or NULL if an error
+ * occurred.
+ */
+static char *get_admin_ssh_folder(Error **errp)
+{
+    /* Allocate memory for the program data path */
+    g_autofree char *programDataPath = NULL;
+    char *authkeys_path = NULL;
+    PWSTR pgDataW = NULL;
+    g_autoptr(GError) gerr = NULL;
+
+    /* Get the KnownFolderPath on the machine. */
+    HRESULT folderResult =
+        SHGetKnownFolderPath(&FOLDERID_ProgramData, 0, NULL, &pgDataW);
+    if (folderResult != S_OK) {
+        error_setg(errp, "Failed to retrieve ProgramData folder");
+        return NULL;
+    }
+
+    /* Convert from a wide string back to a standard character string. */
+    programDataPath = g_utf16_to_utf8(pgDataW, -1, NULL, NULL, &gerr);
+    CoTaskMemFree(pgDataW);
+    if (!programDataPath) {
+        error_setg(errp,
+                   "Failed converting ProgramData folder path to UTF-16 %s",
+                   gerr->message);
+        return NULL;
+    }
+
+    /* Build the path to the file. */
+    authkeys_path = g_build_filename(programDataPath, "ssh", NULL);
+    return authkeys_path;
+}
+
+/*
+ * Gets the path to the SSH folder for the specified user. If the user is an
+ * admin it returns the ssh folder located at %PROGRAMDATA%/ssh. If the user is
+ * not an admin it returns %USERPROFILE%/.ssh
+ *
+ * parameters:
+ * username -> Username to get the SSH folder for
+ * isAdmin -> Whether the user is an admin or not
+ * errp -> Error structure to set any errors that occur.
+ * returns: path to the ssh folder as a string.
+ */
+static char *get_ssh_folder(const char *username, const bool isAdmin,
+                            Error **errp)
+{
+    DWORD maxSize = MAX_PATH;
+    g_autofree char *profilesDir = g_new0(char, maxSize);
+
+    if (isAdmin) {
+        return get_admin_ssh_folder(errp);
+    }
+
+    /* If not an Admin the SSH key is in the user directory. */
+    /* Get the user profile directory on the machine. */
+    BOOL ret = GetProfilesDirectory(profilesDir, &maxSize);
+    if (!ret) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to retrieve profiles directory");
+        return NULL;
+    }
+
+    /* Builds the filename */
+    return g_build_filename(profilesDir, username, ".ssh", NULL);
+}
+
+/*
+ * Creates an entry for the everyone group. This is used when the user is an
+ * Administrator This is consistent with the folder permissions that OpenSSH
+ * creates when it is installed. Anyone can read the file, but only
+ * Administrators and SYSTEM can modify the file.
+ *
+ * parameters:
+ * userInfo -> Information about the current user
+ * pACL -> Pointer to an ACL structure
+ * errp -> Error structure to set any errors that occur
+ * returns: 1 on success, 0 otherwise
+ */
+static bool create_acl_admin(PWindowsUserInfo userInfo, PACL *pACL,
+                             Error **errp)
+{
+    PSID everyonePSID = NULL;
+
+    const int aclSize = 1;
+    EXPLICIT_ACCESS eAccess[1];
+
+    /*
+     * Create an entry for everyone (so they can at least read the folder).
+     * This is consistent with other folders located in %PROGRAMDATA%
+     */
+    bool converted = ConvertStringSidToSid(WORLD_SID, &everyonePSID);
+    if (!converted) {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve Admin SID");
+        goto error;
+    }
+
+    /* Set permissions for everyone group (they can only read the files) */
+    eAccess[0].grfAccessPermissions = GENERIC_READ;
+    eAccess[0].grfAccessMode = SET_ACCESS;
+    eAccess[0].grfInheritance = NO_INHERITANCE;
+    eAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    eAccess[0].Trustee.TrusteeType = TRUSTEE_IS_GROUP;
+    eAccess[0].Trustee.ptstrName = (LPTSTR)everyonePSID;
+
+    /* Put the entries in an ACL object. */
+    PACL pNewACL = NULL;
+    DWORD setResult;
+
+    /*
+     * If we are given a pointer that is already initialized, then we can merge
+     * the existing entries instead of overwriting them.
+     */
+    if (*pACL) {
+        setResult = SetEntriesInAcl(aclSize, eAccess, *pACL, &pNewACL);
+    } else {
+        setResult = SetEntriesInAcl(aclSize, eAccess, NULL, &pNewACL);
+    }
+
+    if (setResult != ERROR_SUCCESS) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to set ACL entries for admin user %s %lu",
+                         userInfo->username, setResult);
+        goto error;
+    }
+
+    LocalFree(everyonePSID);
+
+    /*
+     * Free the old memory since we are going to overwrite the users
+     * pointer
+     */
+    LocalFree(*pACL);
+    *pACL = pNewACL;
+
+    return true;
+
+error:
+    LocalFree(everyonePSID);
+    return false;
+}
+
+/*
+ * Creates an entry for the user so they can access the ssh folder in their
+ * userprofile.
+ *
+ * parameters:
+ * userInfo -> Information about the current user
+ * pACL -> Pointer to an ACL structure
+ * errp -> Error structure to set any errors that occur
+ * returns -> 1 on success, 0 otherwise
+ */
+static bool create_acl_user(PWindowsUserInfo userInfo, PACL *pACL, Error **errp)
+{
+    const int aclSize = 1;
+    PACL newACL = NULL;
+    EXPLICIT_ACCESS eAccess[1];
+    PSID userPSID = NULL;
+
+    /* Get a pointer to the internal SID object in Windows */
+    bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
+    if (!converted) {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID",
+                         userInfo->username);
+        goto error;
+    }
+
+    /* Set the permissions for the user. */
+    eAccess[0].grfAccessPermissions = GENERIC_ALL;
+    eAccess[0].grfAccessMode = SET_ACCESS;
+    eAccess[0].grfInheritance = NO_INHERITANCE;
+    eAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    eAccess[0].Trustee.TrusteeType = TRUSTEE_IS_USER;
+    eAccess[0].Trustee.ptstrName = (LPTSTR)userPSID;
+
+    /* Set the ACL entries */
+    DWORD setResult;
+
+    /*
+     * If we are given a pointer that is already initialized, then we can merge
+     * the existing entries instead of overwriting them.
+     */
+    if (*pACL) {
+        setResult = SetEntriesInAcl(aclSize, eAccess, *pACL, &newACL);
+    } else {
+        setResult = SetEntriesInAcl(aclSize, eAccess, NULL, &newACL);
+    }
+
+    if (setResult != ERROR_SUCCESS) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to set ACL entries for user %s %lu",
+                         userInfo->username, setResult);
+        goto error;
+    }
+
+    /* Free any old memory since we are going to overwrite the users pointer. */
+    LocalFree(*pACL);
+    *pACL = newACL;
+
+    LocalFree(userPSID);
+    return true;
+error:
+    LocalFree(userPSID);
+    return false;
+}
+
+/*
+ * Creates a base ACL for both normal users and admins to share
+ * pACL -> Pointer to an ACL structure
+ * errp -> Error structure to set any errors that occur
+ * returns: 1 on success, 0 otherwise
+ */
+static bool create_acl_base(PACL *pACL, Error **errp)
+{
+    PSID adminGroupPSID = NULL;
+    PSID systemPSID = NULL;
+
+    const int aclSize = 2;
+    EXPLICIT_ACCESS eAccess[2];
+
+    /* Create an entry for the system user. */
+    const char *systemSID = LOCAL_SYSTEM_SID;
+    bool converted = ConvertStringSidToSid(systemSID, &systemPSID);
+    if (!converted) {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve system SID");
+        goto error;
+    }
+
+    /* set permissions for system user */
+    eAccess[0].grfAccessPermissions = GENERIC_ALL;
+    eAccess[0].grfAccessMode = SET_ACCESS;
+    eAccess[0].grfInheritance = NO_INHERITANCE;
+    eAccess[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    eAccess[0].Trustee.TrusteeType = TRUSTEE_IS_USER;
+    eAccess[0].Trustee.ptstrName = (LPTSTR)systemPSID;
+
+    /* Create an entry for the admin user. */
+    const char *adminSID = ADMIN_SID;
+    converted = ConvertStringSidToSid(adminSID, &adminGroupPSID);
+    if (!converted) {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve Admin SID");
+        goto error;
+    }
+
+    /* Set permissions for admin group. */
+    eAccess[1].grfAccessPermissions = GENERIC_ALL;
+    eAccess[1].grfAccessMode = SET_ACCESS;
+    eAccess[1].grfInheritance = NO_INHERITANCE;
+    eAccess[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
+    eAccess[1].Trustee.TrusteeType = TRUSTEE_IS_GROUP;
+    eAccess[1].Trustee.ptstrName = (LPTSTR)adminGroupPSID;
+
+    /* Put the entries in an ACL object. */
+    PACL pNewACL = NULL;
+    DWORD setResult;
+
+    /*
+     *If we are given a pointer that is already initialized, then we can merge
+     *the existing entries instead of overwriting them.
+     */
+    if (*pACL) {
+        setResult = SetEntriesInAcl(aclSize, eAccess, *pACL, &pNewACL);
+    } else {
+        setResult = SetEntriesInAcl(aclSize, eAccess, NULL, &pNewACL);
+    }
+
+    if (setResult != ERROR_SUCCESS) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to set base ACL entries for system user and "
+                         "admin group %lu",
+                         setResult);
+        goto error;
+    }
+
+    LocalFree(adminGroupPSID);
+    LocalFree(systemPSID);
+
+    /* Free any old memory since we are going to overwrite the users pointer. */
+    LocalFree(*pACL);
+
+    *pACL = pNewACL;
+
+    return true;
+
+error:
+    LocalFree(adminGroupPSID);
+    LocalFree(systemPSID);
+    return false;
+}
+
+/*
+ * Sets the access control on the authorized_keys file and any ssh folders that
+ * need to be created. For administrators the required permissions on the
+ * file/folders are that only administrators and the LocalSystem account can
+ * access the folders. For normal user accounts only the specified user,
+ * LocalSystem and Administrators can have access to the key.
+ *
+ * parameters:
+ * userInfo -> pointer to structure that contains information about the user
+ * PACL -> pointer to an access control structure that will be set upon
+ * successful completion of the function.
+ * errp -> error structure that will be set upon error.
+ * returns: 1 upon success 0 upon failure.
+ */
+static bool create_acl(PWindowsUserInfo userInfo, PACL *pACL, Error **errp)
+{
+    /*
+     * Creates a base ACL that both admins and users will share
+     * This adds the Administrators group and the SYSTEM group
+     */
+    if (!create_acl_base(pACL, errp)) {
+        return false;
+    }
+
+    /*
+     * If the user is not an admin give the user creating the key permission to
+     * access the file.
+     */
+    if (!userInfo->isAdmin) {
+        if (!create_acl_user(userInfo, pACL, errp)) {
+            return false;
+        }
+
+        return true;
+    }
+
+    /* If the user is an admin allow everyone to read the keys */
+    if (!create_acl_admin(userInfo, pACL, errp)) {
+        return false;
+    }
+
+    return true;
+}
+/*
+ * Create the SSH directory for the user and d sets appropriate permissions.
+ * In general the directory will be %PROGRAMDATA%/ssh if the user is an admin.
+ * %USERPOFILE%/.ssh if not an admin
+ *
+ * parameters:
+ * userInfo -> Contains information about the user
+ * errp -> Structure that will contain errors if the function fails.
+ * returns: zero upon failure, 1 upon success
+ */
+static bool create_ssh_directory(WindowsUserInfo *userInfo, Error **errp)
+{
+    PACL pNewACL = NULL;
+    g_autofree PSECURITY_DESCRIPTOR pSD = NULL;
+
+    /* Gets the appropriate ACL for the user */
+    if (!create_acl(userInfo, &pNewACL, errp)) {
+        goto error;
+    }
+
+    /* Allocate memory for a security descriptor */
+    pSD = g_malloc(SECURITY_DESCRIPTOR_MIN_LENGTH);
+    if (!InitializeSecurityDescriptor(pSD, SECURITY_DESCRIPTOR_REVISION)) {
+        error_setg_win32(errp, GetLastError(),
+                         "Failed to initialize security descriptor");
+        goto error;
+    }
+
+    /* Associate the security descriptor with the ACL permissions. */
+    if (!SetSecurityDescriptorDacl(pSD, TRUE, pNewACL, FALSE)) {
+        error_setg_win32(errp, GetLastError(),
+                         "Failed to set security descriptor ACL");
+        goto error;
+    }
+
+    /* Set the security attributes on the folder */
+    SECURITY_ATTRIBUTES sAttr;
+    sAttr.bInheritHandle = FALSE;
+    sAttr.nLength = sizeof(SECURITY_ATTRIBUTES);
+    sAttr.lpSecurityDescriptor = pSD;
+
+    /* Create the directory with the created permissions */
+    BOOL created = CreateDirectory(userInfo->sshDirectory, &sAttr);
+    if (!created) {
+        error_setg_win32(errp, GetLastError(), "failed to create directory %s",
+                         userInfo->sshDirectory);
+        goto error;
+    }
+
+    /* Free memory */
+    LocalFree(pNewACL);
+    return true;
+error:
+    LocalFree(pNewACL);
+    return false;
+}
+
+/*
+ * Sets permissions on the authorized_key_file that is created.
+ *
+ * parameters: userInfo -> Information about the user
+ * errp -> error structure that will contain errors upon failure
+ * returns: 1 upon success, zero upon failure.
+ */
+static bool set_file_permissions(PWindowsUserInfo userInfo, Error **errp)
+{
+    PACL pACL = NULL;
+    PSID userPSID;
+
+    /* Creates the access control structure */
+    if (!create_acl(userInfo, &pACL, errp)) {
+        goto error;
+    }
+
+    /* Get the PSID structure for the user based off the string SID. */
+    bool converted = ConvertStringSidToSid(userInfo->SSID, &userPSID);
+    if (!converted) {
+        error_setg_win32(errp, GetLastError(), "failed to retrieve user %s SID",
+                         userInfo->username);
+        goto error;
+    }
+
+    /* Set the ACL on the file. */
+    if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT,
+                             DACL_SECURITY_INFORMATION, userPSID, NULL, pACL,
+                             NULL) != ERROR_SUCCESS) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to set file security for file %s",
+                         userInfo->authorizedKeyFile);
+        goto error;
+    }
+
+    LocalFree(pACL);
+    LocalFree(userPSID);
+    return true;
+
+error:
+    LocalFree(pACL);
+    LocalFree(userPSID);
+
+    return false;
+}
+
+/*
+ * Writes the specified keys to the authenticated keys file.
+ * parameters:
+ * userInfo: Information about the user we are writing the authkeys file to.
+ * authkeys: Array of keys to write to disk
+ * errp: Error structure that will contain any errors if they occur.
+ * returns: 1 if successful, 0 otherwise.
+ */
+static bool write_authkeys(WindowsUserInfo *userInfo, GStrv authkeys,
+                           Error **errp)
+{
+    g_autofree char *contents = NULL;
+    g_autoptr(GError) err = NULL;
+
+    contents = g_strjoinv("\n", authkeys);
+
+    if (!g_file_set_contents(userInfo->authorizedKeyFile, contents, -1, &err)) {
+        error_setg(errp, "failed to write to '%s': %s",
+                   userInfo->authorizedKeyFile, err->message);
+        return false;
+    }
+
+    if (!set_file_permissions(userInfo, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
+/*
+ * Retrieves information about a Windows user by their username
+ *
+ * parameters:
+ * userInfo -> Double pointer to a WindowsUserInfo structure. Upon success, it
+ * will be allocated with information about the user and need to be freed.
+ * username -> Name of the user to lookup.
+ * errp -> Contains any errors that occur.
+ * returns: 1 upon success, 0 upon failure.
+ */
+static bool get_user_info(PWindowsUserInfo *userInfo, const char *username,
+                          Error **errp)
+{
+    DWORD infoLevel = 4;
+    LPUSER_INFO_4 uBuf = NULL;
+    g_autofree wchar_t *wideUserName = NULL;
+    g_autoptr(GError) gerr = NULL;
+    PSID psid = NULL;
+
+    /*
+     * Converts a string to a Windows wide string since the GetNetUserInfo
+     * function requires it.
+     */
+    wideUserName = g_utf8_to_utf16(username, -1, NULL, NULL, &gerr);
+    if (!wideUserName) {
+        goto error;
+    }
+
+    /* allocate data */
+    PWindowsUserInfo uData = g_new0(WindowsUserInfo, 1);
+
+    /* Set pointer so it can be cleaned up by the callee, even upon error. */
+    *userInfo = uData;
+
+    /* Find the information */
+    NET_API_STATUS result =
+        NetUserGetInfo(NULL, wideUserName, infoLevel, (LPBYTE *)&uBuf);
+    if (result != NERR_Success) {
+        /* Give a friendlier error message if the user was not found. */
+        if (result == NERR_UserNotFound) {
+            error_setg(errp, "User %s was not found", username);
+            goto error;
+        }
+
+        error_setg(errp,
+                   "Received unexpected error when asking for user info: Error "
+                   "Code %lu",
+                   result);
+        goto error;
+    }
+
+    /* Get information from the buffer returned by NetUserGetInfo. */
+    uData->username = g_strdup(username);
+    uData->isAdmin = uBuf->usri4_priv == USER_PRIV_ADMIN;
+    psid = uBuf->usri4_user_sid;
+
+    char *sidStr = NULL;
+
+    /*
+     * We store the string representation of the SID not SID structure in
+     * memory. Callees wanting to use the SID structure should call
+     * ConvertStringSidToSID.
+     */
+    if (!ConvertSidToStringSid(psid, &sidStr)) {
+        error_setg_win32(errp, GetLastError(),
+                         "failed to get SID string for user %s", username);
+        goto error;
+    }
+
+    /* Store the SSID */
+    uData->SSID = sidStr;
+
+    /* Get the SSH folder for the user. */
+    char *sshFolder = get_ssh_folder(username, uData->isAdmin, errp);
+    if (sshFolder == NULL) {
+        goto error;
+    }
+
+    /* Get the authorized key file path */
+    const char *authorizedKeyFile =
+        uData->isAdmin ? AUTHORIZED_KEY_FILE_ADMIN : AUTHORIZED_KEY_FILE;
+    char *authorizedKeyPath =
+        g_build_filename(sshFolder, authorizedKeyFile, NULL);
+    uData->sshDirectory = sshFolder;
+    uData->authorizedKeyFile = authorizedKeyPath;
+
+    /* Free */
+    NetApiBufferFree(uBuf);
+    return true;
+error:
+    if (uBuf) {
+        NetApiBufferFree(uBuf);
+    }
+
+    return false;
+}
+
+/*
+ * Gets the list of authorized keys for a user.
+ *
+ * parameters:
+ * username -> Username to retrieve the keys for.
+ * errp -> Error structure that will display any errors through QMP.
+ * returns: List of keys associated with the user.
+ */
+GuestAuthorizedKeys *qmp_guest_ssh_get_authorized_keys(const char *username,
+                                                       Error **errp)
+{
+    GuestAuthorizedKeys *keys = NULL;
+    g_auto(GStrv) authKeys = NULL;
+    g_autoptr(GuestAuthorizedKeys) ret = NULL;
+    g_auto(PWindowsUserInfo) userInfo = NULL;
+
+    /* Gets user information */
+    if (!get_user_info(&userInfo, username, errp)) {
+        return NULL;
+    }
+
+    /* Reads authkeys for the user */
+    authKeys = read_authkeys(userInfo->authorizedKeyFile, errp);
+    if (authKeys == NULL) {
+        return NULL;
+    }
+
+    /* Set the GuestAuthorizedKey struct with keys from the file */
+    ret = g_new0(GuestAuthorizedKeys, 1);
+    for (int i = 0; authKeys[i] != NULL; i++) {
+        g_strstrip(authKeys[i]);
+        if (!authKeys[i][0] || authKeys[i][0] == '#') {
+            continue;
+        }
+
+        QAPI_LIST_PREPEND(ret->keys, g_strdup(authKeys[i]));
+    }
+
+    /*
+     * Steal the pointer because it is up for the callee to deallocate the
+     * memory.
+     */
+    keys = g_steal_pointer(&ret);
+    return keys;
+}
+
+/*
+ * Adds an ssh key for a user.
+ *
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
+    g_auto(PWindowsUserInfo) userInfo = NULL;
+    g_auto(GStrv) authkeys = NULL;
+    strList *k;
+    size_t nkeys, nauthkeys;
+
+    /* Make sure the keys given are valid */
+    if (!check_openssh_pub_keys(keys, &nkeys, errp)) {
+        return;
+    }
+
+    /* Gets user information */
+    if (!get_user_info(&userInfo, username, errp)) {
+        return;
+    }
+
+    /* Determine whether we should reset the keys */
+    reset = has_reset && reset;
+    if (!reset) {
+        /* Read existing keys into memory */
+        authkeys = read_authkeys(userInfo->authorizedKeyFile, NULL);
+    }
+
+    /* Check that the SSH key directory exists for the user. */
+    if (!g_file_test(userInfo->sshDirectory, G_FILE_TEST_IS_DIR)) {
+        BOOL success = create_ssh_directory(userInfo, errp);
+        if (!success) {
+            return;
+        }
+    }
+
+    /* Reallocates the buffer to fit the new keys. */
+    nauthkeys = authkeys ? g_strv_length(authkeys) : 0;
+    authkeys = g_realloc_n(authkeys, nauthkeys + nkeys + 1, sizeof(char *));
+
+    /* zero out the memory for the reallocated buffer */
+    memset(authkeys + nauthkeys, 0, (nkeys + 1) * sizeof(char *));
+
+    /* Adds the keys */
+    for (k = keys; k != NULL; k = k->next) {
+        /* Check that the key doesn't already exist */
+        if (g_strv_contains((const gchar *const *)authkeys, k->value)) {
+            continue;
+        }
+
+        authkeys[nauthkeys++] = g_strdup(k->value);
+    }
+
+    /* Write the authkeys to the file. */
+    write_authkeys(userInfo, authkeys, errp);
+}
+
+/*
+ * Removes an SSH key for a user
+ *
+ * parameters:
+ * username -> Username to remove the key from
+ * strList -> List of strings to remove
+ * errp -> Contains any errors that occur.
+ */
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
+    /* Validates the keys passed in by the user */
+    if (!check_openssh_pub_keys(keys, NULL, errp)) {
+        return;
+    }
+
+    /* Gets user information */
+    if (!get_user_info(&userInfo, username, errp)) {
+        return;
+    }
+
+    /* Reads the authkeys for the user */
+    authkeys = read_authkeys(userInfo->authorizedKeyFile, errp);
+    if (authkeys == NULL) {
+        return;
+    }
+
+    /* Create a new buffer to hold the keys */
+    new_keys = g_new0(char *, g_strv_length(authkeys) + 1);
+    for (a = authkeys; *a != NULL; a++) {
+        strList *k;
+
+        /* Filters out keys that are equal to ones the user specified. */
+        for (k = keys; k != NULL; k = k->next) {
+            if (g_str_equal(k->value, *a)) {
+                break;
+            }
+        }
+
+        if (k != NULL) {
+            continue;
+        }
+
+        new_keys[nkeys++] = *a;
+    }
+
+    /* Write the new authkeys to the file. */
+    write_authkeys(userInfo, new_keys, errp);
+}
diff --git a/qga/commands-windows-ssh.h b/qga/commands-windows-ssh.h
new file mode 100644
index 0000000000..40ac67c4d9
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
diff --git a/qga/meson.build b/qga/meson.build
index 4c3899751b..d5de492da3 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -73,7 +73,8 @@ if host_os == 'windows'
     'channel-win32.c',
     'commands-win32.c',
     'service-win32.c',
-    'vss-win32.c'
+    'vss-win32.c',
+    'commands-windows-ssh.c'
   ))
 else
   qga_ss.add(files(
@@ -94,7 +95,7 @@ gen_tlb = []
 qga_libs = []
 if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
-               '-lsetupapi', '-lcfgmgr32']
+               '-lsetupapi', '-lcfgmgr32', '-luserenv']
   if have_qga_vss
     qga_libs += ['-lole32', '-loleaut32', '-lshlwapi', '-lstdc++', '-Wl,--enable-stdcall-fixup']
     subdir('vss-win32')
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 9554b566a7..a64a6d91cf 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1562,9 +1562,8 @@
 { 'struct': 'GuestAuthorizedKeys',
   'data': {
       'keys': ['str']
-  },
-  'if': 'CONFIG_POSIX' }
-
+  }
+}
 
 ##
 # @guest-ssh-get-authorized-keys:
@@ -1580,8 +1579,8 @@
 ##
 { 'command': 'guest-ssh-get-authorized-keys',
   'data': { 'username': 'str' },
-  'returns': 'GuestAuthorizedKeys',
-  'if': 'CONFIG_POSIX' }
+  'returns': 'GuestAuthorizedKeys'
+}
 
 ##
 # @guest-ssh-add-authorized-keys:
@@ -1599,8 +1598,8 @@
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-add-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' },
-  'if': 'CONFIG_POSIX' }
+  'data': { 'username': 'str', 'keys': ['str'], '*reset': 'bool' }
+}
 
 ##
 # @guest-ssh-remove-authorized-keys:
@@ -1617,8 +1616,8 @@
 # Since: 5.2
 ##
 { 'command': 'guest-ssh-remove-authorized-keys',
-  'data': { 'username': 'str', 'keys': ['str'] },
-  'if': 'CONFIG_POSIX' }
+  'data': { 'username': 'str', 'keys': ['str'] }
+}
 
 ##
 # @GuestDiskStats:
-- 
2.34.1


