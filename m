Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AB9CC5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 20:22:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuFTE-0008RR-Df; Wed, 12 Aug 2026 16:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFTC-0008Qn-Rw
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:22:38 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1wuFTA-0007EJ-QW
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 16:22:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY15SBMFU/1AfJzcsmUoiER/7V+sMM8FC6KHsnMH74gkfID6iePs0Gq6W9GROgb2+HBwcRsJapmNwUZsJSTMg8eI8Hqk3xWIL/VkXv86iKWOwNjtPEUlAeKTOxkANROtiNO1QiEI8kTBP3FoG7AhxBcBAxx9L4TSUS7WzmhHLNN0CjVIsqEUDRaJj9W6hw7YsNAOfuDqFwdhJCJsj+ISK8aFk1ERXKCxzAwLbcHX5YgzDHL7CGBXFyT3dQqCfm/pvQhO2Q+6/kLwkQpjiW2/QW+HVIru+79/6P0tbtw0PhwlCMU8tUjx8FRYaU4lStkQKo0N68VQYtcBItxZFUw/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqQwY9FRIg4cBhSUC4LtnUoO8da849dF5czoKqjNDhM=;
 b=I6MjHqpAMTaiy/lizK2f0tEWLt+oOXdEEbVtguxjzDKtYHhX2VKAraVvrG1VkfRoIf9u6ZSQAxd0MzB/a3tVDxj+MyhNX0VDApFM0dEUUt6Q7Jmo1gIy4tpDKBUU7tkpv77znwjIk9NkaHIhizbz1yEZANgygOfEV8WRvDcQchEJqpz3sXbD2M+znm+mGj1Lwv01EjyNvqxCv9CoMnsJnuOnCjmJI0XJPXCXmdjmhHVssHlzorTgVZJVc8uByoQ7x+VaJAsBgbyACO61LbFXwcRXTgjajCCZgyC/V0DDOmrrXUS06IaDh+03K17fK//BsjZaCvWgcH5PwvyAOBeUWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqQwY9FRIg4cBhSUC4LtnUoO8da849dF5czoKqjNDhM=;
 b=iJGRCjZGqY67O0ouG6ybgnFOxrqfkFQVYqZbYbqE1PQe+GrXI1XhAPh4/gBrSiaPgkZeFkqhF4+1b8pPjiBejDBIsKy3YwyN0ySF/m6FCSUlS29ivnMC0cgFTzYmH66OWDindUtPMDuGTj9O69RFmoSqUYA/OkHKKtVsLlUcxiE=
Received: from MW4PR04CA0334.namprd04.prod.outlook.com (2603:10b6:303:8a::9)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Wed, 12 Aug
 2026 20:22:25 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:303:8a:cafe::49) by MW4PR04CA0334.outlook.office365.com
 (2603:10b6:303:8a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 20:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Wed, 12 Aug 2026 20:22:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 15:22:22 -0500
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: <jmarcin@redhat.com>, <david@kernel.org>, <pbonzini@redhat.com>,
 <chenyi.qiang@intel.com>, <peterx@redhat.com>, <farosas@suse.de>,
 <aik@amd.com>, <xiaoyao.li@intel.com>
Subject: [PATCH v4 11/12] tests/migration-test: Support guest-memfd init
 shared mem type
Date: Wed, 12 Aug 2026 15:16:49 -0500
Message-ID: <20260812201938.198915-12-michael.roth@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812201938.198915-1-michael.roth@amd.com>
References: <20260812201938.198915-1-michael.roth@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CY5PR12MB6297:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a2466b-c7c4-4067-c8bf-08def8af6c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: EwwdfOdxFbu3751V9SElkHXWk5v24ET1XKcjcgFtK663uraXm3qWrcuPRytVSb4pC7MfsMpLhNgsN9djECCyJgTtmIN8ugXDucAw6hykLht15/fWeqvdOTMrio24eSPJ/w7/+qPtnEDWl0z97A5E+qCPAZIhBNDYKLsgiylxet/ETIi+7z4LXtJLqQRk2s8soYVKqpmOxkLP6DjVLp9xajqk/JAoi8hZqPs/0xFhVlZ92WfwMzbcy61czC/jnPF3UiYDAZCr94OYr0mAbHI5lNWdZJenNOHf/4neD12mOVbVv2KmXybECloI6+xHJdu6deibtj1pjU9kqGR/5M66hJkxaOrte2Wkj+q/xV2uAQFgrQqJgVbankMd0ArsYx2DhRJoK0V+7lA+HD9IL7lNCwi1DU1wxC3FX8xhvfMKo871XQAae66vZ7t4azh7DJGPWZQyAxZX4ShedNMZQx1REKaFWQsd3458dTRG4ZLvYwHe+AszqNFeXf/vZTccSDHcARnb7ogVFbtM0l59hShMTMrTJ/24wAox9cMOLObJFA/DQ3QZKM82PareFjNoNBPDfgIuo5dNTQsha9mCqcVhBzmVbVa54wjCYb9rb5FqxI3p0N+OYQfvOqprMoThDtQb01OWS+agq5OIOfv6w/+KJGGcd0JAUgCIW+PbxpYgip/lkpsEq/qj9HI4jo/W5Wia+s9PgGciiWYIyfKK3HkawQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: klbagII8kEXMRotpjbfT93VHeW5yQJ1VS5P10BO0SPAiUPSh7DYR576kWmJwznCTmCOTGVFuBszZyapFqK0OsNIOP2SvHS1FPBKYg6/SFBJ+WK/BvTho5igZiXBsMCHPcUxVnyQ6TmYsQ0SUbT/k4XqerWJ7jHgV09kT9XACKyiyb9e2kQvz1PU/3hVv2haOzzvxwAYVOOu6YVMk/Q4Qr0guuklYFcU/ztBaemt30TxIwK92CqfYTJ3Kd5Y1fjmodVLuw+ZorHpirsTEW3w3S7uDniPR6EgQ6Ks+aODDF8HQs0Dkfo5++ptd/+UoBD3EHg/mLRm+4w85ijsjdvzsYaVIPWwk0SCP0yKCGmaBzx8WuZoshozfAxOzB+GKAc3lV/90Z9HpjGxK9+RrDmLJP01WGaTXUDPGTrCdaZMeXO0jfGF8ZS1DKQSW2FXG5qcd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 20:22:24.9809 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a2466b-c7c4-4067-c8bf-08def8af6c2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Michael.Roth@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.104,
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


