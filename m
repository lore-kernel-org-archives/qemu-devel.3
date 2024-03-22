Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EBCEC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 17:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnizK-0007dM-At; Fri, 22 Mar 2024 13:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7811d50a34=aidan_leuck@selinc.com>)
 id 1rnizI-0007co-UI
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:47:28 -0400
Received: from mx0a-000e8d01.pphosted.com ([148.163.147.191])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=7811d50a34=aidan_leuck@selinc.com>)
 id 1rnizG-0001uc-KU
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 13:47:28 -0400
Received: from pps.filterd (m0136172.ppops.net [127.0.0.1])
 by mx0b-000e8d01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42MCAhd4006536; Fri, 22 Mar 2024 10:47:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding:content-type; s=sel1;
 bh=X/a6J1A49jVg3LjtWWFMiKMUqMNG5Hcp2sRTuzaIbWM=; b=y8IKSB2+l908
 x5oPCJ6rMPwKgp24uI5kOnO4PSzsPml9lINZujC46WuyG/nMsjDOfR941EL0rBOI
 mbK/IAkLSkl2/mMoKgWm9dT2IuuGdJuBsVY5BohQ0RT9Xdx00GcmZ+EgBG9lEowR
 GJcOqqo1graDAfZ9x8HjrJnZ6VDwn5eCtdYOl4IvNhAZy18qzHjc9iTXZWVkp651
 VUgY2I1iCJ9oswN8TsYMv38jFpifCtAmBqO//vckVHNhYN7G/asqolxkOIropFZ9
 nqbMLTLsMchcZkp8Ik19M/wru8m7o0YczSmTb0pWscFXArQ6zJb3zq9FXbVELSxo
 FB8Fi+Gmeg==
Received: from nam04-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
 by mx0b-000e8d01.pphosted.com (PPS) with ESMTPS id 3x0wy0ghrg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 22 Mar 2024 10:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBYCrWKfVfxNKWxg/P8H4cMHz03FtdvlKQsQe7XPzobJ/AgYArM321WOchX3lqm3RXnJz72mf8eCk4ohavWaq9YSI0l3a1nEXdqyGxNy7H/wioVk/5VwNd6FeUjpWCU5KQ0Fpdy3eOO03Xw5ddyhb65qk3ysKMwDa7kgCDiJQoHIjIArpZsp7azLT3SlSMOaLbpAM11SYfkyhl0rmRQK1uh6O9ryyuJKDFVRIDkLFx4eP63JgEiUGo838WaGi6zJFxCOiDvhOfMeJpZxo8citf3O0cq5sP/ovpBCVEntINv/d+Vlj+LNKUSPapRcswP8/abazxY7SmYWgKjq0f8MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/a6J1A49jVg3LjtWWFMiKMUqMNG5Hcp2sRTuzaIbWM=;
 b=RTot8MazJLhoNcbA1TLeeF1/roj+EI7O8IkluVpp7Mvy33Cfn971AzSH/zulYUnB0H+jwZvkmuVx4OCxbluskWijGvns9/rXe8FjNMrimie54zddBEO5BxDOr3R5kLa7EK5Fd+/PIfjsqbbSIxqsrQ+diOnSptklLZc3CsmMtEeE1uj1JrFR+tFji1lZPFHQEUe8R8dlxOVinA8h4uYVSTMXw0wk33K/8J0zA56cPvmP08QMr+/gVKm4QGJ5Ptk+EGl66fS9f9tsA94APgpJ09LHDtfncmpRdlwnRlZQkuWd5QpnJdt6erlDQWruSYPDdXK8G+pEhDvrH+3oXyTSGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 74.117.212.83) smtp.rcpttodomain=nongnu.org smtp.mailfrom=selinc.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=selinc.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=selinc.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/a6J1A49jVg3LjtWWFMiKMUqMNG5Hcp2sRTuzaIbWM=;
 b=Teu4jrNgW+UjAqhrJRT7GVEQWn6L9YoQWhHWJMsD/YJ9ZpFu6Nc2rH24KtqUaIJOtGPYdR4JsIsOZ+dksIOsYV9mbBgxBlR6ksj2XpaG3D9tKqHBxp17DOruKsNIURbq2JrJS6e9iM6hh6Upab7rTV/Fi06hBY+wClB0dviWxUbLkZI2jcgAAEOz4P/cJwfsM7TA1qZ8A9y8nVuDGnP3iK6uBEadgAo8NM+lun4SogCrbVYITH7L/XW81PFdijUt7HsSIx/OpX7C1ZoW/qA1C6NzzzvLL1U7gXsxjnioOPx1C6YGwBH7U5M/uuTTFuci3koH+gBEo5tKJIRpoBGn0Q==
Received: from MW4PR03CA0081.namprd03.prod.outlook.com (2603:10b6:303:b6::26)
 by SJ2PR22MB4581.namprd22.prod.outlook.com (2603:10b6:a03:53b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 17:47:21 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:b6:cafe::8) by MW4PR03CA0081.outlook.office365.com
 (2603:10b6:303:b6::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Fri, 22 Mar 2024 17:47:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 74.117.212.83)
 smtp.mailfrom=selinc.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=selinc.com;
Received-SPF: Pass (protection.outlook.com: domain of selinc.com designates
 74.117.212.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=74.117.212.83; helo=email.selinc.com; pr=C
Received: from email.selinc.com (74.117.212.83) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Fri, 22 Mar 2024 17:47:21 +0000
Received: from AIDALEUCPC3.ad.selinc.com (10.100.90.200) by
 wpul-exchange1.ad.selinc.com (10.53.14.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Mar 2024 10:47:19 -0700
From: <aidan_leuck@selinc.com>
To: <qemu-devel@nongnu.org>
CC: <kkostiuk@redhat.com>, <berrange@redhat.com>, Aidan Leuck
 <aidan_leuck@selinc.com>
Subject: [PATCH v3 1/2] Refactor common functions between POSIX and Windows
 implementation
Date: Fri, 22 Mar 2024 11:46:36 -0600
Message-ID: <20240322174637.499113-2-aidan_leuck@selinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240322174637.499113-1-aidan_leuck@selinc.com>
References: <20240322174637.499113-1-aidan_leuck@selinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.100.90.200]
X-ClientProxiedBy: wpul-exchange1.ad.selinc.com (10.53.14.22) To
 wpul-exchange1.ad.selinc.com (10.53.14.22)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ2PR22MB4581:EE_
X-MS-Office365-Filtering-Correlation-Id: 15c6ed8b-600f-497b-0663-08dc4a98202f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6MNaimZW6BVYUFvQSwYc+Q/JXT/7iCzGWx8ywAoEXc547NEsV6Hmbz6OvhZOWGcfUasRR0oJ8wqqO/bV8tsjhIff+fz3AIc3ttBk9R+I1Xec4PjsQcjYX/uZns1b/mfLmb+qF/P8s9aXKr+Xp8w8PwMq+5sMK5Xkhg6K7Q75myl955YN/QJFBPuLKJvkXF9UvRTt6FzDOdxE4AU/bCn+n2URMaky8If7+iGHOQApBbGSAVN6Ivns5aKsYmQIJ1Vc2Ej6eks6ksvlxy7vTXvU+rJdGWY48T+AnFM3Y9WyEiOPx9XvyDwhquR4MxlnVXlWX2JC6IwfRP2PSZwijmwh//G+1QoBryLzkBCDuoSSargXXTyh+mY9r0Nm+3VFID1GpY6yyhfGGrfSL5/waMQ6RD7heOTdiXDZoTwYFFxj9eQOh+vpa30XBqjf8rMD8qd5vofS/hgRC1JFDhKhQjMFC9TZ/I7dSV+O2nPkKg+993k4C6zw4AOdm8YncOKj24Kh525lYeYvRZI/7RoXPUOdi97gO5GAvrC8B4MKBLMOt7FBm2LY/hbwIHkgYNCNLOd5QR5gg61G5TWQ7LFTbdnfqi/vwt/XEVRE5SxnXJ6XhjH/Oq29PA+lV3Un1px/j4MP97BpqjJKAM1AYYnh1+s71UMSviSJp44fEjVUzda0rY3KVqLe8yvFSH924mmtVO34qsd1nexwICZ77hpO1hLM52ZctSaARI/Gj8j9o7+1DPQcf0A15pSsLbxm0ZAhXh+J
X-Forefront-Antispam-Report: CIP:74.117.212.83; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:email.selinc.com; PTR:wpul-exchange1.selinc.com; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: selinc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 17:47:21.4736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c6ed8b-600f-497b-0663-08dc4a98202f
X-MS-Exchange-CrossTenant-Id: 12381f30-10fe-4e2c-aa3a-5e03ebeb59ec
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=12381f30-10fe-4e2c-aa3a-5e03ebeb59ec; Ip=[74.117.212.83];
 Helo=[email.selinc.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4581
X-Proofpoint-ORIG-GUID: rVRrP1LmfF5E7pqWlf1Pz2V2PjBvulss
X-Proofpoint-GUID: rVRrP1LmfF5E7pqWlf1Pz2V2PjBvulss
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 suspectscore=0
 impostorscore=0 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403210001 definitions=main-2403220128
Received-SPF: pass client-ip=148.163.147.191;
 envelope-from=prvs=7811d50a34=aidan_leuck@selinc.com;
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

From: Aidan Leuck <aidan_leuck@selinc.com>

Signed-off-by: Aidan Leuck <aidan_leuck@selinc.com>
---
 qga/commands-posix-ssh.c | 47 +--------------------------------
 qga/commands-ssh-core.c  | 57 ++++++++++++++++++++++++++++++++++++++++
 qga/commands-ssh-core.h  |  8 ++++++
 qga/meson.build          |  1 +
 4 files changed, 67 insertions(+), 46 deletions(-)
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
index 0000000000..f165c4a337
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
diff --git a/qga/commands-ssh-core.h b/qga/commands-ssh-core.h
new file mode 100644
index 0000000000..ef9f600d4d
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
diff --git a/qga/meson.build b/qga/meson.build
index 1c3d2a3d1b..d32b401507 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -66,6 +66,7 @@ qga_ss.add(files(
   'guest-agent-command-state.c',
   'main.c',
   'cutils.c',
+  'commands-ssh-core.c'
 ))
 if host_os == 'windows'
   qga_ss.add(files(
-- 
2.44.0


