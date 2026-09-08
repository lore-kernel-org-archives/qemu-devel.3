Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B45FC79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 13:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3vxX-0001uL-E6; Tue, 08 Sep 2026 09:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vxT-0001td-V0
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:55 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1x3vxQ-0005eZ-RA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 09:33:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ia82m7N/0ZJg0Vbg9FAbrdi2MFECSCNsyen4vnga/pl2iHNPLUdfMv/ac2YSONeGQVZuEEPHcjC1zhz/PvPvWj4yzVTmOwbamSgYO7eLVMsBRIqq3W7bCeUttjd9pSwn6y8B54LilIWtdkil8FxBUx9hJOXGU0Uztmb/uuebpBni0eI2Q9HBqBmgyTKG0Ela3zQY4cJPuO9cHd81AqEs3YyTCvDdiaFMxccyXtDOWoLyPtmJJpoXclgDssusNqBg/61QQO5U6I7WhbXNcrekKZ2UtCrZcCgZAfMOABVPdZz3QOtusqMeyJfmpoAS4eKarV0hYD9KyRYaeSZUwKUjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqQwY9FRIg4cBhSUC4LtnUoO8da849dF5czoKqjNDhM=;
 b=UWgDVwCg/fCBe5LEcBjLuabjqMzodHELvv3NjU0mtyXwTKXWiBFcl1NXo7NhgLDdyRH8xv5fVR1eCdBBbRSPpuQ8KLxvOFTbXFckJf+o8vok65D/4n0rMHlAtitW8bfz2i9zZoQ+NVTv03EfrLq/+vrCWAAHXl/ZAxnK+vgTukoWCYWeVDKCdJ3RnJseeLWRQ5DNk/HCkHAadCGy3rfpBYIDfi/TziDBkS+wS4dncT8gRSe7CfJNQMXrRjKXyRvYNh64SXl+xn/L6yVIez/h16LEGBDqWfzbdUR07l7TyiQO2Lccfq5KJKjVq/83lMc/ZW0mH5WtIbfaUcF74fED1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqQwY9FRIg4cBhSUC4LtnUoO8da849dF5czoKqjNDhM=;
 b=qhNwJGhCme0IfGMxHShp0sGHUrpu5YEqFiImmcgG855Nyw/E+pf35cwcJsa2OdNE03aHKEOgWVHpZNwQA+GZSzEkgX0KPd8Twk3WzJ8yiKW2S/5iNpo/Y/GUX2G8bQ0HTjxHs+P3F267nIZU8qZ4gBamFPXRy97N7RMhScMEV00=
Received: from MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:16d::18)
 by CH3PR12MB9124.namprd12.prod.outlook.com (2603:10b6:610:1a7::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 13:33:34 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:303:16d:cafe::39) by MW4PR02CA0030.outlook.office365.com
 (2603:10b6:303:16d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 13:33:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 13:33:33 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:33:29 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <berrange@redhat.com>, <armbru@redhat.com>,
 <pankaj.gupta@amd.com>, <isaku.yamahata@intel.com>, <xiaoyao.li@intel.com>,
 <chao.p.peng@linux.intel.com>, <david@kernel.org>, Peter Xu
 <peterx@redhat.com>
Subject: [PATCH v5 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
Date: Tue, 8 Sep 2026 08:31:01 -0500
Message-ID: <20260908133151.836685-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908133151.836685-1-michael.roth@amd.com>
References: <20260908133151.836685-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|CH3PR12MB9124:EE_
X-MS-Office365-Filtering-Correlation-Id: 127e490f-c4ae-4b97-ceaf-08df0dadc786
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: yuN1jkeEKzjA0AZ+Vj0mG2N9nEs0tGdqSfJSwz++lxF8bd0bJlkOaKB4PPNgs0ZEzSSUPFTDWeoQKigu4y5x3bOZSoVX1yVHHasGDJM4AEkmAwiDBehgsXVXVE5PZJ/v2hMQ0ZZIKSzpkWmgbkgHAhLuGFJKhZeeuTzSS9tF1mbMUuoZBi0oTQFlSjHgCco+qqcvUUQuV6aKckzEnebKFQgBW5tvNi76cy1vpSUflJdtjkjLOOoePQjCYC0jknKthneLWOYzGdqjWpWJDuwOfCtWK0zJK7yFSe84li+enJAff/AjOaJw5o9mwBR8C7rrnhcOcovwAcco4ktL7j/Zqv/yoXCE06K+hvgzK7Wempt/4DGQLMxCX9TmgRM9GvoF4Mc3IBZ7DJLyNpSyEuCNYad8HIWgPbO7KhLyLRdirgMWbjYaKZAWnUnm7nBmleFUNpLf958yDMvmqXBkjHHnUI8+i3O1wBgnv++aRhCJdMfLzotp2ZtEBNo+x+HoKVg49SNKhZ/LsU70HoY7+Rz6uweo7x8bfbPV0ClRAvrvyCQvseAYzv9WjcCsE1+4mubIVG6vHMyRtu5Z8HSLjBUFAr6f3/I3rQNHB/hom5Au6gifGgUqfoD10Wg4eXSbf0BgzuPTel1XBa/J9472G2DpBJAhqa5mH8ZWL+S+90Pr/Xwj6ITRysxDUNRKelKw8NPG8mcMcx/GchKTO/fEWRzM3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /I5OVe7BBORuHU8X9cRtHQanX3qqa/4D6NkIQHGUf5utBAR6zop3yGwxzYfPGZr+19krR9VCYPvGT2M9rENv7X2orxztfQ5qn3TJ4TsGdGhy3nxCjxhlISE85fpfCDV7j0n0ng1dUp9EAUGUpT+d/+I/jP7y80tHojkLSQ0lM9VOWM9niq8xth7mexZTyupzhZyPK8FmAe+J/C92N/e65RAHv7VGvfP/DaHH1Usyiga0CVAPNf7x1X9TO2dCx0mg6NDZ0PLaKwnXV15pm646TlhIgl9mXaGfsmD2mfFvJ5F920+UE33D5lCQXipv7Ez6e1/bjcWpdQ4nZ+yfSjXCaGvMBol5gmeyB1bB3+uxa2dtolR0ypraLg59V8J7dGu/8PVviD0nJ1X+vV4hH+tFZ/wVDfMA4qCQmuh+eOVbUthA96CnMSmIPsUwsBxr2C3K
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 13:33:33.7448 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 127e490f-c4ae-4b97-ceaf-08df0dadc786
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9124
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=Michael.Roth@amd.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Support the guest-memfd type when the fd has init share enabled.  It means
the gmemfd can be used similarly to memfd.

Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 tests/qtest/migration/framework.c | 60 +++++++++++++++++++++++++++++++
 tests/qtest/migration/framework.h |  4 +++
 2 files changed, 64 insertions(+)

diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
index a830b96f41..b7aef6b21c 100644
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
+        backend = g_strdup("-object memory-backend-memfd,guest-memfd=on");
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


