Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2D9C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 14:42:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzdoX-0004jL-7U; Wed, 24 Apr 2024 10:41:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8844046850=aidan_leuck@selinc.com>)
 id 1rzdoV-0004iv-1j
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:41:35 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=8844046850=aidan_leuck@selinc.com>)
 id 1rzdoT-0004iy-5q
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 10:41:34 -0400
Received: from pps.filterd (m0136171.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OEJZNe019560;
 Wed, 24 Apr 2024 07:41:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=DXEXLlUU69YWlGrgs2j2BtnE9ToWd8JscHIadvmCAnA=; b=uxJIxftMJL6V
 6z/qs4cKJ4trzGfLVM/019CePxHdtpDt3O60UzkT1Vk2tHlJOd0daS7wPpH9VPlL
 DBlM+5cnDFWzIWIYprvyJOly5UGQB4DKP9b9LYdHdPy1udFiEkZ0REuyKj0z0I5X
 5SR7QyNBC4+C8m2EIi/ZzIP5AC4be6KVxZJBDedSTv4R6EQIBM0S6sfHPHo+h/J4
 uywlgCzBOV1w1rv73m5V3noy6rrp8EtFLj1tWCaw0o3pDIy2jtiFZWgHNLsFJA76
 ePJHEEnHxaJI6QVBkNYMkjQjHSzNZUelX4q3SjykDIeDK8XDEovCmni2fDrX/xuN
 dvAEI5J+Kg==
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3xmbmuahrb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 07:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CASvnDmwdfUHeg4f2beZk+NN1ybsMYAWplcSzOTrS9BJRczRBXNI5GFUJ2hTn3058y5AYHuDMz2oJD7P7fDvMrB4SHq+u/rdZgQc6F61XASaDIytjPCtm+JeldbTlWFTypqRvIU4PIDryKQqtdYGvz3r+6uDEpH8qn6hhj8TQayipHO9PGClQmydbvCNpYGawVLdUKmwjkbp/hQ0bPFNSl6oewLFv50O2Bv/8iubBqZx+X+b5jqAPbsKckOydo6zmbI6XR+p+4ekebsDj18SQ9aoFwQ5MIhhNGNL7lbKSR0/VcrXy0KnvYPfeiB1fsX2v8bcqVM+joOIfGIvVzNf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXEXLlUU69YWlGrgs2j2BtnE9ToWd8JscHIadvmCAnA=;
 b=M9p64gk6cJnn7LgvIsz/PuO3Z5rvZZty3OB5HR8P1YIFEXpJsO2CYDy+ZlyaNEIOTwC5quzbICHHJQr+oedAAqIisNf+F7t1AYtRF7C12dL9xcOGFlACYRnJ4vJquvFiOOis2ScmtMypfNbxK0ZUg++Gpe4GmiWsfwUIGSc26BSo+6Z4QhcRgp8s7EwMc7Uprrl+RJfhqTYdvsdumGz5X0xA2v2aKe0pQIgo9Gs2erfFEDzWU+bxPDo0ozENIfTEY1KdQfc/WGiRZNKsL2wv8oSvCtac5CHnZ7LWLtGk1PvhNFVCKETvckOK60tV+A/6T13iGcQZcmqGoxVl5sxlxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DXEXLlUU69YWlGrgs2j2BtnE9ToWd8JscHIadvmCAnA=;
 b=iTgtHZQEVvC1WF5e97IkxNRF1UN5ag6O1OKQYLkMf7P1NkJfdL776yQJlifq2pFJo7uiU+PU3qgrJJMeXEL4wXksDgLiFbFeCjWlDdtjMseqCoRyN+CM2wyKgcGerkk0NHmtK+o+RxUmDMawALHAAbvB2ARJ7xjWMLMP214oh4m6BHDS8juvbwUcSY8M3SFsb7BZCXHOVtecdkxpQjtRK0rcNrCjsnjEve3d0Cj2dLYyNG0UfIvJ5d8XCwZ5juOtjz3pnONruN1QPBNilDaejEfE/vc/vdFXr2dFpU0qdjQKnsvVwC6ARxYnpdMC6rDCgxJFfZ7J7hBmq3TzWg6zUg==
Received: from MN2PR22CA0004.namprd22.prod.outlook.com (2603:10b6:208:238::9)
 by PH7PR22MB3769.namprd22.prod.outlook.com (2603:10b6:510:2bf::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:41:09 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::d9) by MN2PR22CA0004.outlook.office365.com
 (2603:10b6:208:238::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 14:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 14:41:08 +0000
Received: from AIDALEUCPC4.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 24 Apr 2024 07:41:01 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <demeng@redhat.com>, aidaleuc
 <aidan_leuck@selinc.com>
Subject: [PATCH v9 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Wed, 24 Apr 2024 08:40:28 -0600
Message-ID: <20240424144029.30665-2-aidan_leuck@selinc.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH7PR22MB3769:EE_
X-MS-Office365-Filtering-Correlation-Id: 41c9d7ab-34d4-4afa-b9fa-08dc646c947d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?srLTQmy3H6Sj7Up3Kv908uqXQYP8qxLGcm9qEIr49b8Ok5sH1ASNNmEcvSjt?=
 =?us-ascii?Q?5oAKtDrO0GrS+s7u+zO0tHGV9TcHhTqAZWruSlacmHONUewwxKZ7TneFrbML?=
 =?us-ascii?Q?xAkaCVdGplNbFlaEF9M3QWOyqbSWq1FTLxqghMKjBbT4Rglg/9ybj3XhtcTd?=
 =?us-ascii?Q?cLVEdiA5xcAJ5RUj2AOw0yzH76+MHKzpF9Idugq81DUJt6NFQt8QsPopfE4F?=
 =?us-ascii?Q?AVATdYQCPEPOKUydE1tQ7qGdmhjw2fWUApzqxfx0aVZ1Apw27/ak7v0uGfpA?=
 =?us-ascii?Q?xRgYzW4cSxqj+Lqr8td7gT2A9Zjll7gfvKJSOQwqm9Vc9Ltp804YPWzNjcCS?=
 =?us-ascii?Q?lkHY+TCbwV81zrLg5B5Sr70cGRa9b3/ZYRl4BNKKL0G+MYR02iHyKZNvsA1D?=
 =?us-ascii?Q?pGwxm3ERgnkbVg7v6qPiSw5b39S+6ruU9g5CKxaEY7q7ReRYEHmmZ05IhryJ?=
 =?us-ascii?Q?N/84ThpYsXnyApkUPhyLrBHIC91foC0DIQZkRhX/cXRjqRBTYG7f5GX/xKOk?=
 =?us-ascii?Q?2IwLq5RX+Hcnud2VATnbaPljDqDn97TRAfJwZWliQzTrf8ZcDMZpKFAMp4Rl?=
 =?us-ascii?Q?Anh3LpKZWBcazfHCFUCz+CDVrvZAgrd3EDRAiP8Cegsw8bXehBVSge9J57G0?=
 =?us-ascii?Q?XuxmTfqPtEUqqHwKiRQuK7w6HuP9ZCdw9LZiUDbdxwZTFcK0czc/EMHWEe3H?=
 =?us-ascii?Q?mlddwwwxfaYj6xqhTmeqYDL0xa52jcaHb0c+Z/IAEAsSMV1yRDlUrgpKFoyw?=
 =?us-ascii?Q?r3gNAvVe1aPR3H5/iVpb9UQl946YhbvSZARSg5RYTRqbijNi5IxzE4uGBzlA?=
 =?us-ascii?Q?9/kqGejmbfwTy0yLi2NcYIWpUAlmK4DxTLH4ZNbuM4kbkK30x/dSexQcO0lg?=
 =?us-ascii?Q?m9B6F07lQmmDF9oAyr5zDwWsqR45VMKr2I0yvxJn1x4K8WX+ouRats2FpUir?=
 =?us-ascii?Q?9xaybHjjAIOHSxH6vZPrkBCA0H1emgjUHWcR+/A3piyvz+MQd9aX3TLXHZZd?=
 =?us-ascii?Q?Fio+3/6lLiJ1YYBWjZkja7qNqX2ygBftHGJxHNc9PW48BMnYbF88rtoAtpT7?=
 =?us-ascii?Q?HZ7DwMwDoR0nm68veVG4GFPQ3IrUfYx4DsEPbN0NSrJ8aicthSamD5I+ilr6?=
 =?us-ascii?Q?I5NzFIi3LL1W5RMwX2HXeLe/4E+BAgRUHFOWDhtvTCJGwORaU+L/F6SEx70y?=
 =?us-ascii?Q?ttvgnjghQnLgW64XPBCaRSePW1Mnd3mrBLyDAgRgxjAInJ/OcQ/tbSFI87nw?=
 =?us-ascii?Q?aoqSn/CrF/pDSjEJxw7QA430pQHBT1TgzVIBDpcxOM6xHZJMsR1xYST7DPXm?=
 =?us-ascii?Q?ueUTKDZE3DC1I3HmAy2f2yaJnAcoNE5U9cByeKUTt1Csuv2xID+cNjvDDlMO?=
 =?us-ascii?Q?ZMZJ3/M=3D?=
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:41:08.8562 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41c9d7ab-34d4-4afa-b9fa-08dc646c947d
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR22MB3769
X-Proofpoint-GUID: Ro_a3j-h9Od0Bm0Fr-FLIgVwlKCybnTt
X-Proofpoint-ORIG-GUID: Ro_a3j-h9Od0Bm0Fr-FLIgVwlKCybnTt
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0
 phishscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404240054
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=8844046850=aidan_leuck@selinc.com;
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

Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
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


