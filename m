Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48B5CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 23:53:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBhds-0005bc-1o; Tue, 29 Sep 2026 19:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhdk-0005YZ-Td
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:53:43 -0400
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com
 ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1xBhdi-0007gq-VN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 19:53:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1zp8DmrWLwPuukffnBbXbzAI0UquRs8kEFNXmpeEtfDRo2rct8d8L8vYXh6yO1aHa5QaaYkaVro809akmP2XweTFb4VWknUCU0wehXhnuTXMY52zb2tyHAEw1Y/U/PuOR1q4xhwpxFgmrv08Pao8C+hEENIXV5QapeO5iN0nhIpNCsXARrqH2/sFMg/v2PzlscstGLIC8p2Enx4WbaLl9Y3OBj+JpK3Z1SS5VR5597xh6KpYrQOv0EeeTfS8hE9m1/f9v6W7ltk/qEqg0ICUP+Vs0TNW7fKCy4+78bZGNEKx8oZbhPtE9fKbysZzqKh7Gd8/jbOGqLVGrBdYgb85Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P5HWQNB0J3KbNCbUQKTE8hkk3j6uhxgHWRLYGcvbiM=;
 b=HFXmDw3mC2oinORBwrurgCNOG0l3hLTRKOqjbf59C8ufJX2EtD0r6Q+f5JuPOtNQRJlngIQEZai6h0YuTe8xXTC8uvNwBww1BEsVD5+bswNx0Lq38rFeH86u3Da6I55L/X9rxR214T8uDYxh8jWFYpkbe/luwGA1YfsZ4v1WfVdkR6G+kp9DXpj//NZro2RIs4Rj9rQJTYurkr5TKKZyeTyjYJEf/HHl3ryAD2aFK09SvKI6T7p6A3ak3lqQRUiMbRJw3u+d5LPjX24Yf4ZVSNQ3vcZcxyrzw2vH70lGZjQn8Sh+BBxQQJtgAWi/CGotBwXA9pH53BH+Bl0CSbThuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P5HWQNB0J3KbNCbUQKTE8hkk3j6uhxgHWRLYGcvbiM=;
 b=YD7mkToDc9i1s0UxUyvouAI4MYXszJqTgImcfgC/HxfMkeK1qimEKDDBDYDHH8/Szh7e+LfuLncAdBq5NojLKCyGLYvejDUVpWFtPMKYEiTCZQPaWIrm2PwpnIOd9z/sH0gjMTji9nvTHJL+siYh0KW/bfhh1Zh1ESznBqBKdq4=
Received: from SJ0PR13CA0218.namprd13.prod.outlook.com (2603:10b6:a03:2c1::13)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 23:53:32 +0000
Received: from SJ1PEPF000037A2.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::68) by SJ0PR13CA0218.outlook.office365.com
 (2603:10b6:a03:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.15 via Frontend Transport; Tue,
 29 Sep 2026 23:53:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A2.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 23:53:31 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 18:53:28 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <armbru@redhat.com>, <pankaj.gupta@amd.com>,
 <xiaoyao.li@intel.com>, <chao.p.peng@linux.intel.com>, <david@kernel.org>,
 <berrange@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v7 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
Date: Tue, 29 Sep 2026 18:50:17 -0500
Message-ID: <20260929235109.1398509-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929235109.1398509-1-michael.roth@amd.com>
References: <20260929235109.1398509-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A2:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: 518d1b7f-bce9-443e-28a7-08df1e84de11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qnmKh7phU3hA58rm37Jgs/YWo7vHSup9eCAH+ygdC25jgheGc9Sh00jCf7VJHlhqE8UC8VP5pAcvd8+Ui+WOy1bJAkw27GtQHubZsT2gD/Tgr3WMHXGRG2ojZZeNma8Nk0esCyU0IS+JU4xkf21oz54NhUYSw6YLcTMpcdlyt0YZUnvXAcgSvghWLa4lDgj6s4XvKByyQc9McI5TbWf9tcWzSzmrRBz5dfYXwszzZWtQ3jW/BgbJ3NwXLaN9s/N0xS4zYOjAvgLoqmGlhM0+IyTG7Cvr3uUIW+64PGh2rj0aQkjx8saP1mJP6OHEdtk1dnq8M7SgZ3VwCSmj1ps3qa1fSZ3cLQoD7B0NbNhcT2fT7Mxx+5hcARH/s32WZ3eXkJlbp5BUrKfhJg1q3n643mqpzchtxFCqq7Jah3F5msF2Lr85lhGRPVFA0lwc0E+iIyUzGgrdB2VZ8ET1UXlF3xyG47CHIv2RRwZvEe9VzoORrlUIQwV4TBNpT/o5SvWH+HYy29Gvq922PkL7iPqZWnuc+KCAgIp0hJ9/4+TQO1TZ16EoNK1G05kyFLKcQs2D38PfQ+ZIC0d+2Ssnzi8dZFOOf4U3EzY9upK7TojxM75A6enk/ZnGBKc1/NXE1FoJy3BpF1gVkinCqoNnR2d1hUCHbwdDUPFrPZiZZSrl9O2shuvIXSx9EkFMU/ooOSvVCqdBlhw23Whi0vmoyzPE9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eQQZ2YjmbNM/a53g2Paa/gl7H8gkDQl+1hQWzK5uGWXPgnsVRLavETiMtzqFIE+w8wBoAsG2c5aM1XN2V9qhWNUduv+ZsRxJEgdl2uVI0nSeN5tK/yGKyQABTBWf77hKX0xSKg3lMXPp8iMRoWMO6WiEjUEppInyyW8EPFTWw5R48uV0uETusupR3wUTn6ZsWKlRLFJ8jpIRjDW4fzQPo4SF2vxFhMvP3VcHk70JUi7/WiN4QNw9cElzko6l0lJ8MvPbUgnbbbzAK9yyC73DoXBv9Evy2A+Ok+Pk89WlEwIC8Dk1yUo2ZJ9rxa/Xzz6de7Ni6zy7AK8aay3++c4kCnqL3zPfzL8b5puKdePeRAQcJnCEF8uyWv2OdX4vbQBUaS9/5NOD4hbgfXssl0MzQmHX6CK90gd/Pcciye/Z5TDXEY+GWxoDAckVxyyrp64N
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 23:53:31.8816 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 518d1b7f-bce9-443e-28a7-08df1e84de11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514
Received-SPF: permerror client-ip=2a01:111:f403:c107::9;
 envelope-from=Michael.Roth@amd.com;
 helo=PH7PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


