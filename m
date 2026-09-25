Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B6BC9831E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 02:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9vD1-00069h-Fn; Thu, 24 Sep 2026 21:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vCz-00062l-0P
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:58:41 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x9vCx-0006OA-1w
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:58:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2Rge6FJxjGkd7En5PUogRtRkAV8L6Zh5lL/JErpjekaceSgOivCAXjQ0zd9h0qgoD6ZHGZC/rfadShdctq+elGyPn54ks7pXnNsOXMiiVpEdgzQ3cMpR4xQCKFMY9cHslpAbRKgsz4PzXoJrXAAKKTDqaviQ0O9TDQmysF470spfWwTccqlXG+QxA9qYb7t5jxgXmWxO6t7P3/8eUHkFVBISLYk0lXBL/hYD0HJvQsgtypWgViLpZMlRZsM3GkQtWI6lmS44XyDCYGsBN1JohLh56tgpBqhV7ykcZBte0k93jUX3l1drPlhwTaWc+7PMO/gVrnfU6v4VN54/ojJmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9OYJPTL/BO7s6n1zQrdhhnt47uw+t9+pZvpGlU6Lr4=;
 b=iW1s2bLMd0q24kDB8J3PGphAhNkHlJStMPsdBfbx+Xm4U8ks7spJ3SRgeOEOotjF1pz1poR7yh3XhpGVeGPUolMiJTESDncpKH/lVsFFf4ftFnYW6+LxvEI/Bc55UWkli1RTz0tsaRPdzAMZJmmVAHHEGIg8RBU7mWgU8jaeW8hyeh77JEr/mp7HCUiQHVzWcpe3v+i2ct4qhyftrh4I3cC7gd1CwuS33zaOnNCkZebjwL++g1qAj+miDGjlU+f2fXQnddhM92gudHRsWJ0wqytOEKtjuCBhrjkDSYtRKbvMMpA8LInRnkQWzwKn2iSuwDTEPD9rsBQn8zXiQ5q8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9OYJPTL/BO7s6n1zQrdhhnt47uw+t9+pZvpGlU6Lr4=;
 b=Cjgf16aQEcFJ4wuFiNkfopBEhbZ49ieMlC+cOVFFxlerEP1u/G7ifRqpDzDHnQ+nDtDIWQoHjzwHykH9GQCjRqAT12YC8gs1LF/aSy9t25Ij40Ri2J/zZktMT4kHrpTi3k1i0YZVLbvt6fmqmny4ATVgh5juwINR/oSQAuXlP+Y=
Received: from MW4PR02CA0012.namprd02.prod.outlook.com (2603:10b6:303:16d::35)
 by CY1PR12MB9674.namprd12.prod.outlook.com (2603:10b6:930:106::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 01:58:35 +0000
Received: from BY1PEPF000264B0.namprd02.prod.outlook.com
 (2603:10b6:303:16d:cafe::23) by MW4PR02CA0012.outlook.office365.com
 (2603:10b6:303:16d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Fri,
 25 Sep 2026 01:58:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF000264B0.mail.protection.outlook.com (10.167.242.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 25 Sep 2026 01:58:34 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 20:58:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <david@kernel.org>, <pbonzini@redhat.com>, <peterx@redhat.com>,
 <xiaoyao.li@intel.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <chao.p.peng@linux.intel.com>
Subject: [PATCH v6 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
Date: Thu, 24 Sep 2026 20:43:17 -0500
Message-ID: <20260925015700.1260501-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260925015700.1260501-1-michael.roth@amd.com>
References: <20260925015700.1260501-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B0:EE_|CY1PR12MB9674:EE_
X-MS-Office365-Filtering-Correlation-Id: b12d2c10-2740-4c89-fa0e-08df1aa8822b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: IMDYwQEdIkHx0HoDhpmDNu/2diMlt0S5q7BJsHYRqF/jF4TMsSttlJM7kYHHiHjy/XhsjQEvbGYXJg+hFs+cgkMJjean15BV00YdjWUfpTWuWF+Mdag0V8/D3kM4v1bFTDqYE0jdk4BsKVKwVQy81oReswluW0o251cTDkI9MjZ1ITsi/AxhpVx5cNtrBuWimmKc8jW4cN7Q5Vc5Kum6y9z7KhPqQmOSaMi5H/OWM/P3/5+iMGa9Uh/hrkEFhWkyh6vAxMk6s4ycf/+3A+Rawhs9d1fj239FIhZoPHmWk1uVigCytjpg1A3FLRsjT00AQ0YajOLllL9cmiMv1qhMZWFT2UT4pIiUC4Q/dt8Z4VDcmCW8N8W1RTFHsGbxTtkWeRcGRLmk4xqIaVaAPvVKf0bcn1o3VHY6yBvwjazJG0PheYjZc0m8fscn9Uyi8YeTZCsljXhMKDGeqj31AvWKYSXJoo5Up69Ae75E/nrO9pujWI/DZCP8qf7DyXyS3pykiEebfgARlyQV71d7ZCFJllN+P5ui9BvXh8XFQ9j9jImwKoxTKJWTBv+thsWT1iyILeBZEzoZ8nC7dzPuPBWq46yelL7uVwDk2XTrn8l8CbCeqGmaA1HXCj1j3S3zrhzdH5h9Wu3OXq0cWGiy3sTAG+7hNODe3ZX5Ew0J0BLinLbLJGNCm72kVck7dKDRdrTF/DEXd+XCHuJ9F/jzR37Dzg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V3tZncnMsgTEBwhb3sY+xk+wNmm+FFJ6KzC+BK61b2oW0rjr1MoVwq6L0eBmuBrT4uYFZmyzT4aFVaqFbEneCtRmrjGI7xsBNATLYIyAhGRqo/fH6vAuuaMXG6koRK492Wm4re/tbFw+/5q+5xTwqqoKv8xlIKTJHu6arGWlOj/xysY8GUy3DbC4iVRSPZRExBHZ6rAqmkeFVSOlNeAHlHfzrmpMwzPWpG7nXAYoCdH3ewd6BeVmC59MldC/MfAhfKP4Qt6jpS1K8dATFR1O6afEZmlY0SLiuIS/IzS+4jNRhVibu9PEZbkrYMuKXsIf7vQV3AvcK7Xnp35uJ0yJwz8gMLodosa6dJmqKgSPiLXXsyfTN29PI8X40BEy1D9rKA0P75k+cAhTM5UjuYI5SISo36wvnBm2N/W+WdjWGGwn2KsWOwB9I7NeOjGz9PYZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 01:58:34.9340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b12d2c10-2740-4c89-fa0e-08df1aa8822b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9674
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Michael.Roth@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Xu <peterx@redhat.com>

Support the guest-memfd type when the fd has init share enabled.  It
means the gmemfd can be used similarly to memfd.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tests/qtest/migration/framework.c | 60 +++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a830b96f41..93225e3720 100644
--- a/tests/qtest/migration/framework.c
+++ b/tests/qtest/migration/framework.c
@@ -26,6 +26,10 @@
 #include "qemu/range.h"
 #include "qemu/sockets.h"
 
+#ifdef CONFIG_LINUX
+#include <linux/kvm.h>
+#include <sys/ioctl.h>
+#endif
 
 #define QEMU_VM_FILE_MAGIC 0x5145564d
 #define QEMU_ENV_SRC "QTEST_QEMU_BINARY_SRC"
@@ -296,6 +300,9 @@ static char *migrate_mem_type_get_opts(MemType type, const char *memory_size)
     case MEM_TYPE_MEMFD:
         backend = g_strdup("-object memory-backend-memfd");
         break;
+    case MEM_TYPE_GUEST_MEMFD:
+        backend = g_strdup("-object memory-backend-memfd,x-guest-memfd=on");
+        break;
     default:
         g_assert_not_reached();
         break;
@@ -444,8 +451,55 @@ int migrate_args(char **from, char **to, MigrateStart *args)
     return 0;
 }
 
+static bool kvm_guest_memfd_init_shared_supported(const char **reason)
+{
+    assert(*reason == NULL);
+
+#ifdef CONFIG_LINUX
+    int ret, fd = -1;
+
+    if (!migration_get_env()->has_kvm) {
+        *reason = "KVM is not enabled in the current QEMU build";
+        goto out;
+    }
+
+    fd = open("/dev/kvm", O_RDWR);
+    if (fd < 0) {
+        *reason = "KVM module isn't available or missing permission";
+        goto out;
+    }
+
+    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD);
+    if (!ret) {
+        *reason = "KVM module doesn't support guest-memfd";
+        goto out;
+    }
+
+    ret = ioctl(fd, KVM_CHECK_EXTENSION, KVM_CAP_GUEST_MEMFD_FLAGS);
+    if (ret < 0) {
+        *reason = "KVM doesn't support KVM_CAP_GUEST_MEMFD_FLAGS";
+        goto out;
+    }
+
+    if (!(ret & GUEST_MEMFD_FLAG_INIT_SHARED)) {
+        *reason = "KVM doesn't support GUEST_MEMFD_FLAG_INIT_SHARED";
+        goto out;
+    }
+out:
+    if (fd >= 0) {
+        close(fd);
+    }
+#else
+    *reason = "KVM not supported on non-Linux OS";
+#endif
+
+    return !*reason;
+}
+
 static bool migrate_mem_type_prepare(MemType type)
 {
+    const char *reason = NULL;
+
     switch (type) {
     case MEM_TYPE_SHMEM:
         if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
@@ -453,6 +507,12 @@ static bool migrate_mem_type_prepare(MemType type)
             return false;
         }
         break;
+    case MEM_TYPE_GUEST_MEMFD:
+        if (!kvm_guest_memfd_init_shared_supported(&reason)) {
+            g_test_skip(reason);
+            return false;
+        }
+        break;
     default:
         break;
     }
diff --git a/tests/qtest/migration/framework.h b/tests/qtest/migration/framework.h
index 941cbd7102..10761f6e28 100644
--- a/tests/qtest/migration/framework.h
+++ b/tests/qtest/migration/framework.h
@@ -34,6 +34,10 @@ typedef enum {
      * but only anonymously allocated.
      */
     MEM_TYPE_MEMFD,
+    /*
+     * Use guest-memfd, shared mappings.
+     */
+    MEM_TYPE_GUEST_MEMFD,
     MEM_TYPE_NUM,
 } MemType;
 
-- 
2.43.0


