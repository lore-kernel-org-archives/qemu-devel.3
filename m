Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C8DCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX9F-0004v3-RR; Fri, 19 Jun 2026 07:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX9D-0004uV-Gb
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:31 -0400
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX9B-0001vC-NA
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkIqnithxdZ4XK9yGpOio4vVN8XZWa0eYw+m2/2f2sU5ZtYA5W+fKETfnflwIgSYN4Lmi71imURdVmPQFkv428LIszs9PcoJ13yA4OD80ZSNugXHQN5vpNOXiEsrhPZp6OWXNMWAfRUz/4p+w0Bh2N8+iLQ49v7xPcOvfE3ml9JxfvI3+o21kIFF2oFXJ12l7ZIXZyy+rEHYlSyDBs/n0f0iDTzofqIYCnUd/mj+pbCgHI6lCVEzNiS37AIh/m4w3oQPGKNAqv3b70xu1hsDUzZQeWoQgid7ycF0b3vG+GPmuRv5XLkUIvstwk5QL5174xuccy9lNnq1k4CXWeD9Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oN7Cuv+a/sGwNDTt/PZk+kJCAUW+sftiVyDnDLG+DAE=;
 b=i6ER+oY+86eKIcF/ZbD7d767x/mICWyogxS/Yo/uQe/+OxBrCh+Glf0V+6HtY2mMsHFgQGq6OXHdao3GyA4C73Uo95+T2/eQcJ/l68fc8ZblrWBwA8bQ07yA35nX2ICvZqDF/u+CeqAGeHSv259KAlC78Y7Nk8qvTBb1L2JcKhw5GqfKrKRJxU0s0NmgXXDHynhZ5D5WGUo/Yq0lVr1JPVSlwg+Sp1zMt00ob8i8P1zTVNr7/4LRLyvQWnFDqi+U6UqRnBFl4t2uFCJFKTyTptwmsLQ1Aw9ZPQjj4B7Cv+Sx6HyBsOp5bbeego4gwh7hEf67UUFhkTNWvSn53SYFzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oN7Cuv+a/sGwNDTt/PZk+kJCAUW+sftiVyDnDLG+DAE=;
 b=H7Og7o8TY8R30QreySVHJB68yaU3fWDu/YR7b3hkmlSZE9g4Jb+px6VSI38vl/1kMwsX14gheiGvikomEdVRsGCHQLNxP8s3eUD6UggBZOmfDZLNBkhQsRAjUzrfiOha46PaxwZk7JrpwShsB+XFd+m4DyItrJD/mOjZ8PO/+O0=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by SN7PR12MB7912.namprd12.prod.outlook.com (2603:10b6:806:341::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 11:12:23 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::44) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Fri,
 19 Jun 2026 11:12:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:22 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:12:19 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 10/10] tests/qtest: cover sp-mem SOFT_RESERVED e820 entry
Date: Fri, 19 Jun 2026 19:11:36 +0800
Message-ID: <20260619111136.3481329-11-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|SN7PR12MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5fc9f-7f3e-49bc-b5ac-08decdf3a324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|18002099003|22082099003|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: 4Ae8CEB3Oav3qOBePRHoa2YjEjTAUjmtWNJcWB4lb8iD/72BfFGjX5EolHnN39zTU3hOG5R8omDKcdq4e2YJS7/PGmg6vGM9JN9EIcw3LQaxfCkiz+Pj+KaKiN86dwiWzA+raDdBTaXBKmV0b4/dqd6Jyd+W0GgZ2+UoqJdzARtnxDZ+W+l6LBi/+NotQ/WFyHcl0r7Ing/IawmKAYnEypw6Mz77pc+IfrDKe1RPQDw3cazFAD47UPhukj8QGca+A6F3Ffqd38Bi9pwAwHc/8YXrRIFnzYQjKXuUERjS4Y6WWpwZ741cwFMubl3KspRp5dc8Fn4N5LS+MksNwUPkK9f8oGVcjK4UYAar5tVV9Wsq8mIKShKHZWsgTol3bD2O91d0rJfSySVfXunOjHbVmrH1TjuVlfOIifmErH1hoTwkPlH8IudkD5jfNTWQTirnH4RC/HVI+g3q9JRe6idJC7lD0a64jwKiiHNrP5CNXq5S8m4cdIuXS7flW4A328X2YKCBJ0cW4tOpLEnx+m5FNnhiti4Fm5Hy51w1jF2i30CpEZ2YXNeFurXALxCx1r/oAeIH1ienRgsMY0lVi2o79MLo32dtrVJZGYdtc/+hcj64AgQ6X/Ut5H98XXC3PFB248oZA5f57h0iByKg0Yol8Rb34pcPNS/eKqRkjplb0bD9VmMLri1GKFcvMFCUFdE8p3rOGEIGLvHdVrQ8dn7dEZYQnHAfTzRvBgk+SMNMZ/mq1cwOyyBaoW66KpFi0Y/E
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Gtt9OuPdzu1G2wbXV4QVXT1c3RKHLhcsvgvlRnd9i0HEQt5R/NnzQxBJIXlTBGhjk39OzjsdE67Hh0+haBfvogpXKBGuOn0uBCloS3JIAA/x3Xc/bBZx4+Q4U6WLD0gsl7RyhfchEboiQvf7fBkIkwT61wgWlg5ZN0VhcPIZJDoajornkCg2NQgTYbFKgVNiv3v1Z0lKjvYW8GRBdKX2AOb+i45GeW/x/dcAVdizqp49zD8obZFEoJW6xy5VIuj1eUG3zzbWssEJi59+XuLLG4e2rBOlD3QuCsa/RBszluqr4Z8pGMjDdnrz44T2C4d+rMVcISLBoZAVXPs1XnPudeFKE26S//381fSIfeYIlBbO8255sB2tVCeekygewdq3kx08ovOwYSeGRrX+RycZrFUISOhZkkqDmNPKkDLvwYxvlsazXh5mr2TFGcQbB7uS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:22.9759 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5fc9f-7f3e-49bc-b5ac-08decdf3a324
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7912
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=FangSheng.Huang@amd.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Boot one sp-mem device and assert the guest's e820 table gains exactly
one E820_SOFT_RESERVED range whose length matches the device's backend
size.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 tests/qtest/e820-test.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tests/qtest/e820-test.c b/tests/qtest/e820-test.c
index 1db0744c08..aafa3c1aa2 100644
--- a/tests/qtest/e820-test.c
+++ b/tests/qtest/e820-test.c
@@ -16,6 +16,7 @@
 #include "libqtest.h"
 #include "libqos/fw_cfg.h"
 #include "qemu/bswap.h"
+#include "qemu/units.h"
 
 /* e820 entry layout and types (cf. hw/i386/e820_memory_layout.h) */
 #define E820_RAM            1
@@ -85,11 +86,44 @@ static void test_e820_basic(void)
     qtest_quit(s);
 }
 
+static void test_e820_sp_mem(void)
+{
+    struct e820_entry table[E820_MAX_ENTRIES];
+    QFWCFG *fw_cfg;
+    QTestState *s;
+    size_t n, i;
+    int soft_reserved = 0;
+    uint64_t soft_reserved_len = 0;
+
+    s = qtest_init("-machine q35 -m 256M,slots=2,maxmem=2G "
+                   "-object memory-backend-ram,id=ram0,size=256M "
+                   "-numa node,nodeid=0,memdev=ram0 "
+                   "-object memory-backend-ram,id=spm0,size=128M "
+                   "-device sp-mem,id=sp0,memdev=spm0,node=0");
+    fw_cfg = pc_fw_cfg_init(s);
+
+    n = get_e820_table(fw_cfg, table);
+    for (i = 0; i < n; i++) {
+        if (le32_to_cpu(table[i].type) == E820_SOFT_RESERVED) {
+            soft_reserved++;
+            soft_reserved_len = le64_to_cpu(table[i].length);
+        }
+    }
+
+    /* exactly one SOFT_RESERVED range, sized to the backend */
+    g_assert_cmpint(soft_reserved, ==, 1);
+    g_assert_cmpint(soft_reserved_len, ==, 128 * MiB);
+
+    pc_fw_cfg_uninit(fw_cfg);
+    qtest_quit(s);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
 
     qtest_add_func("e820/basic", test_e820_basic);
+    qtest_add_func("e820/sp-mem", test_e820_sp_mem);
 
     return g_test_run();
 }
-- 
2.34.1


