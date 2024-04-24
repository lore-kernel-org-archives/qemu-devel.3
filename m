Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B9EC10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:42:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdoJ-0004hJ-37; Wed, 24 Apr 2024 10:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8844046850=aidan_leuck@selinc.com>)
 id 1rzdoG-0004gJ-Kj
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:41:20 -0400
Received: from mx0b-000e8d01.pphosted.com ([148.163.143.141])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8844046850=aidan_leuck@selinc.com>)
 id 1rzdoD-0004ht-Ax
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:41:20 -0400
Received: from pps.filterd (m0136173.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43ODtfxd017787;
 Wed, 24 Apr 2024 07:41:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=qK3uNfdLa4btKXT/a6nasHoVMny1acLEXQLscdS8Bhk=; b=e/By9muh2iE/
 mAz+B4JUC7xNRN9ahDv0xIbgoavgIhUcaNXqG54Jd7yixSWZNbw12AK9G/0QqVJ3
 rlCbBNaAe0koyf5ob2mxTnwjjq1SCKLJ06Nyo/0P8uG/cW7TcXumcPg3oioQ/HFA
 rSDMWxTxH7I8+y3PUNPxivcJV22EeF5Sh//47J0tWFTYM64klhgAkKYGyBYTMe5f
 z/suH9+kjLfiRgxD9mJh3s1Vh1Lk4j3vAoXCbe0P3H0hQb45FNie2CpHUDUdeg31
 L5GTD3V3kpdAg7YphJXb8R0nKh1M23ar1AW5qCv67JnIPoHmaDWR/OzXmAfLqowV
 KNPh8x2RtA==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xpk2e8hr3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 07:41:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbSuOHA/urKdgGBPR99auBLxJdEKQs/MoDZnFlw9hC/Hc8Cg0TGGWxIGopRpgUMQXwVWLojgJUVysbVjqmYBW11p8g8BU+VoKBQbkMNjYGZ4+PxhF8uOtoi0yyAs6IonbpbRdvmtm2r6uMa41qKJRVTqznStKYWAhAI9LuVBZ4pNdyL7ReXampfBHlkmrhSLxBRDJ7qBVCqLBERnLIEeC/Ybkck9+ffDpVDU58Dh3ff10N7AR6enb4bsdyt7PIE6zBdH5Hdt7HUsWNMIthu+FfwB0rwGyXacd0tVp3tFn4hZjrhyGv9SmZ3UzFkZ9CqxNgzjmddqHs9SWGp13f9Hrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qK3uNfdLa4btKXT/a6nasHoVMny1acLEXQLscdS8Bhk=;
 b=GuvEclmjBj2dm2Vcmx634grn2ducVXzHW6VFdKUYMl2SO3oBDeh5TEHjUmtpo0dEpxkEEuNnecYCxGge9qGGE5TVFwWt7su2GQz1AcjWU9ABGjx0xCPVYnkeubeL+F2ng4elfkv19S4dq7nGoRd0cLqelwDCltUXLvm2LZMen0jdeBJI1ia+mSq6Z19pBBG1+y46TrH2xH5eyV9dtHm+BlbkAO+42vQiifCa5ol7Q2xJACv+Gq2uX3+QfKhcD52IDHHPoQepnlhJgkoPPccVMdQN0FGmwdDr+/bWDJeqC9TrRa3i0h5/f1uJFHxhBh4bgFGHsY8vm9hB3jpHfq9Exg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qK3uNfdLa4btKXT/a6nasHoVMny1acLEXQLscdS8Bhk=;
 b=PS+ra9ZEA6Vj/yOdkLPpR0WUg23PiULduyltvdCyGy0vVIjAV4vceEnDpCQMmLG0bJpiKbJ3Ve1jzw9z+nNyAOQ/boXFv99APrkzjpqdEDp/DdqSR/Adt6n9e99EpXFWJfypnq5vUkqYfgHZpgol2N5AzQ6HR1JoEkUT2zVhlwMXBsZR/RbUZWdSqE4BBWOcxRA0eu96sVy3tD3cRETLMsE6L44n+tDxiSQ3xtFjOaJubCzRtdQE3PUsexi2O7Ur6D/2LucwCxz6zx0ryZEt+lOwvjOOfB+iTQjLcOJ0lPttgbCu0s3viYNlHd9eTABFxoNX7/2wvQlyDIz+p60R2Q==
Received: from MN2PR22CA0013.namprd22.prod.outlook.com (2603:10b6:208:238::18)
 by IA2PR22MB5429.namprd22.prod.outlook.com (2603:10b6:208:4a9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:41:13 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::a8) by MN2PR22CA0013.outlook.office365.com
 (2603:10b6:208:238::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.36 via Frontend
 Transport; Wed, 24 Apr 2024 14:41:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 14:41:13 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 07:41:02 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <demeng@redhat.com>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v9 2/2] Implement SSH commands in QEMU GA for Windows
Date: Wed, 24 Apr 2024 08:40:29 -0600
Message-ID: <20240424144029.30665-3-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424144029.30665-1-aidan_leuck@selinc.com>
References: <20240424144029.30665-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|IA2PR22MB5429:EE_
X-MS-Office365-Filtering-Correlation-Id: 734d218f-501d-436a-87ad-08dc646c9714
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2ofNKy1b2tbwEeKyWnHmdkcasmlzmd0si+MwqonTbZ/1gjY2y0egJ39QCULZ?=
 =?us-ascii?Q?VvIMHExf2zkimv+mu17kRimRggPI1HTilTJnJV5HlGlY0EWoX0HKGxdyY3d9?=
 =?us-ascii?Q?OPU4SFpEebxV2uxTxqjXEw6h5spZDWH0vyuo5Mn/U5ty8brV1sOhAG+s8DLZ?=
 =?us-ascii?Q?wtnL2GhrPkBFJ/DgeTtPRYmg/6lLkVBs7kfET7KQLBNh7mxnUUa7qFwV3pfg?=
 =?us-ascii?Q?hDiLrrX5osMuYSYj5vRjk+o8hVRP2qaq1M2M/wnhkm+F6DpTDPAScpDB/UyH?=
 =?us-ascii?Q?XZ+yfjPmwFkc7oBHhHHL6/TRod3oUz2DtrqKNXwGmXTTbk9lRXV8qNojkPxs?=
 =?us-ascii?Q?0d5qjv4WwSs4dXuz1Yg074tKYmzL7mtQaegpFrL0BqL0oGHdeiJbgLzKsLI2?=
 =?us-ascii?Q?0p1faA+0IwtOxKulq6QQYvEtkl1a388c7uYMcBle6Z21KrNwVCftXdmwXHF7?=
 =?us-ascii?Q?TEgaseMBrfC3d3/xmuR+YP/pIDJetYc0ILUbDZKU8+Cp00IyyDmkZMSYdYSZ?=
 =?us-ascii?Q?GV6PuYkQ3n+Ld3ZSUJjBd7EFq3BX6U/VHYardVen4gm50IcYXRQM2A2n9xYu?=
 =?us-ascii?Q?jMYqodUbhewYMy14xWerL9OMeMGqpudEuMkKNwTONNk+1LV8mybkkMD8Q26L?=
 =?us-ascii?Q?A5d0s5rLQyGciFn9cUB6A+yKXjlpwV+lHf2MHO4rFKmJLsruQWaHatAigQcX?=
 =?us-ascii?Q?1NRmq0RBLzKkAxkU1ge/HLhlHchdkVu0HLbHIxVbj9T9OfHEfjcHJqlYxlcq?=
 =?us-ascii?Q?2WkRQ3hh/JJYUugOxNKY5gruWyTSof9+6nNCbY2H5cECzh2Ew/QtwhjLsX1D?=
 =?us-ascii?Q?m52+nzhMEHWlAwsWSHYQTrA80bTVOJIlb3YT0UuwolfuoydlV42lw4/XHPm9?=
 =?us-ascii?Q?ih+yaI49uC9CPjDwLnwICtInhva4+U8mKms/CuXAJ3irkOm5DtowOfIXC204?=
 =?us-ascii?Q?g/CIdPByeWc6IO8bymD6wACysjaulrSiz8s3M6KU8CW3ZjKNcKaVud7UWm0r?=
 =?us-ascii?Q?kGlTNu3XrqH/7+W5u/dcD+tAKfDiW3qVjLne7adWkLQLK5rHY7ddPL1bYSse?=
 =?us-ascii?Q?iwzVpCp4ZOStc2VyQiSy4P/5S5lALI8wAZOq/gFqCf1lUILxRf32XSvnvWD+?=
 =?us-ascii?Q?1uRz5/r2XaKz6p07WmbKpqp8HVrN6yw4tDk8zxZo44srcUbuWDhxdFfUnDJW?=
 =?us-ascii?Q?xj0K7F203d371CyI9CEkcrId7wOLMqlfxJ4JwaZUulhekHzcBtWr0d2/rjYV?=
 =?us-ascii?Q?mSQsQS7h4LhoO82ItkLsy/RKPM63MGa29WqPnGqwhLYC4ZJoY6MHW6HWaCmO?=
 =?us-ascii?Q?s24pkDeDad4fgcqLMn9VpAtFswLmkwwSPNLHl9vhnr+hHC5bmdr/Er3JmDW9?=
 =?us-ascii?Q?8VeVmBc=3D?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:41:13.1999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 734d218f-501d-436a-87ad-08dc646c9714
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA2PR22MB5429
X-Proofpoint-GUID: N_Rdr0gyvQu1XUAVaYiO5n-YeCd4cnDs
X-Proofpoint-ORIG-GUID: N_Rdr0gyvQu1XUAVaYiO5n-YeCd4cnDs
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0
 malwarescore=0 adultscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404240053
Received-SPF: pass client-ip=148.163.143.141;
 envelope-from=prvs=8844046850=aidan_leuck@selinc.com;
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

Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
---
 qga/commands-windows-ssh.c | 712 +++++++++++++++++++++++++++++++++++++
 qga/commands-windows-ssh.h |  26 ++
 qga/meson.build            |   5 +-
 qga/qapi-schema.json       |  17 +-
 4 files changed, 749 insertions(+), 11 deletions(-)
 create mode 100644 qga/commands-windows-ssh.c
 create mode 100644 qga/commands-windows-ssh.h

diff --git a/qga/commands-windows-ssh.c b/qga/commands-windows-ssh.c
new file mode 100644
index 0000000000..6a642e3ba8
--- /dev/null
+++ b/qga/commands-windows-ssh.c
@@ -0,0 +1,712 @@
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
+    /* Prevents permissions from being inherited and use the DACL provided. */
+    const SE_OBJECT_TYPE securityBitFlags =
+        DACL_SECURITY_INFORMATION | PROTECTED_DACL_SECURITY_INFORMATION;
+
+    /* Set the ACL on the file. */
+    if (SetNamedSecurityInfo(userInfo->authorizedKeyFile, SE_FILE_OBJECT,
+                             securityBitFlags, userPSID, NULL, pACL,
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


