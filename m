Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8E8CDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvQ-0006jp-Uv; Tue, 23 Jun 2026 03:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvP-0006hF-8m
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:52:03 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvvN-0000jb-Dn
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:52:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N72O5tzVB86DbqJSMUIr9k2FHM05GhnhykDpwDCqPL4AXjc5sW4niGq8IIicSxtI845utdDvT9QbeMuWuIZNNrA4zTLRHuEzgp2URqCbncip21HjBQlC5iqZzW0dU6ZMt7VS/1ziqTtu6nGaG9pnJ3g7xB87Q/eUv/nKPBnFApLeDAmjM0D+91sIbRjulmwnWZKmJ56111u5wAIFJeOtrbDY58NFnMckcJC+4BOVQ0XfK4PmdASTyZCFFISNqX0MH4cvx/A4NsjvfGOo1ja/Z6kpHdQYWwL3TDVV6CM8XQYuZeUUw9FsOpSczI3spYQeRRjGLQg0vP9+U33ywEgxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/Qx/vsAim6qCvjytKLZ1qRsEsA35CZydUX0JHPvF2I=;
 b=jKjpSfYtDmYq2yKqGWYqz49jfXgvh2N9FJNfWlkXaiCEuJtu6D9nwTgZaB8dELZuMsdWpu5h76GdOnWEoa2ONAB4E3d25PMlws6XFOyUkMHIJfDOEuT8MW60CRdmeXxtNgtTN4tVq0beaLl5AaD0oMAUKYHobOGqoUfKQcFCbAJ8LS0lMR+8Fyo19z9S5S67BZgzfl+vODoEzDHEZ7on8AoU7wCFgC8rGvRSvIlS444AbhzCQN6z0+I3ASFDmaezB9Dr0PDNDTn7jZ43krg7hPLLuEOjqQUwyJBcSD7ZOU8zKHOF46RK3m9CMGYDO74ASOpeByXv+DNf8POxeeKa2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/Qx/vsAim6qCvjytKLZ1qRsEsA35CZydUX0JHPvF2I=;
 b=NFLJd/27OADWJ/NPD9SVEORvXCuJ0KUTFkPmKlOBz2KXj1/mAXoggDUc46KTqlCtTUvJ4BsPsDKeVXnYDv4YqDV7/VAxAaSb4AHrsu6SlktKbVKacHne2LSBWccaaL7D5tdc3BHmt5n2XbaqY3D0hkILy6Jj02lNFWuO5TeZ/8U=
Received: from BY1P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::10)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:51:55 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::69) by BY1P220CA0015.outlook.office365.com
 (2603:10b6:a03:5c3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.12 via Frontend Transport; Tue,
 23 Jun 2026 07:51:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:54 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:51 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 10/10] tests/qtest: cover sp-mem SOFT_RESERVED e820 entry
Date: Tue, 23 Jun 2026 15:50:51 +0800
Message-ID: <20260623075051.3797975-11-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: 776d3a03-ebfa-4ac3-4992-08ded0fc4b77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: ZXyyyS+BO1Fu3gP9ypWFCrW37UAj/sIXFzQ8MXnO4JRGEufBKn9KkBJujOfIoWCQ/6qaawyD9fScDLzH2hJ1D9D3Du7XfgvMkIw7Psi1kUmxgnRs23vkjtPDX8MsSZ07ZJN6LSa13dr2NS2GLaOuLC6mcpmV0VYiiRN3uvPKM7eEOz/6S1cdXkkkmJspEniJhPmmL8jcsxbDc/V9gtxf0MjEF7lBbG045K0Bo9zTEq16WKAm382mdkSaxXGSZuXD51JY51TvkbCIC2UC/VK2Zjmxfh/aVgBC8OZDL4KhMr4cApoXhifTtkPWq5T1b4htMPcdESQbXrmeBpzmuANmWf4tZaweUlRGebY/5qexUotfNt4HeuOaVYX7vbPKjcxSvv8k+1Wf5E1ZaaHeBVEznqc7rya5PKGIcY3lal7zBSMPqpQ4A0Pv0aQj/wEgD+qNm3arpZEwsM9oKfzA0yNwW1Q+9RaZwEukfMkruk1IGdgD6mToR/HkGCgkp7IGF7XuzdR89kf9EJ0EMQHBpZ3ZBsD0cwg1YqobfAMroTnnX4wic2C1OSwu3D4xyiHo2AvAn4CaVISmJba6Ci17pkVtDlhqNGEw9GTuYk11lnXVzxEMu7EYx30Yyx4X9HhL1JQTtLsThJaujMoVyvA1LdxpkFLQ+/HBLN4kwyczEFH2G7Lj84COShZS+mXxs1mB63NAY5FlSzdfX2NXJzUkKPlQDNHuHuDN/wWT4CX3j80GwXHePs9QfJ40z8Jw8tafGIIU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N2yDm2aQ2qBhOi0yY8hJ6qbDK77ndI1B0+0VGofUrF96cVjZGyrJ5I1p5vTqOb46isQ+pNf2epgAM5/gtZqJm2nNGV4VK+CNvUQXu+Mz9hnRw0gHl4AZFXG4tSDYsCDWCggirVgR4AzIL+L6vaRmoIr3Ad59qz5Vc/lsVlaOqYssPv3CIehOpB4aOcX9gzCrbxYIbi7rC39/xIi8YO1AuURviwYqNnZ9JlV0LaVldivcC56zQXDg1tXPHgkod9eFF3tnLhC2zFYvo7iadJAm7iUbAvuUKhMGN8BOZnLnu/PN/CSi3BPxR89YcOuDnySH8JGvPWjDMcQXBlQa7zQlc1jMpnqBiHFfz7rTsIlpiRBkvMg/kgFPR+HidXrmmuEeCbaQJKUB1o+6q9NrjIScfYDgs31IpDlkhiRRAdthq9TsVD3/E0x1cfBpd5T7MQKN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:54.8371 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 776d3a03-ebfa-4ac3-4992-08ded0fc4b77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=FangSheng.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Boot one sp-mem device and assert the guest's e820 table gains exactly
one E820_SOFT_RESERVED range whose length matches the device's backend
size.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Acked-by: Igor Mammedov <imammedo@redhat.com>
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


