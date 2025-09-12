Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E30E2CA101F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 10:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux0ew-00032e-78; Fri, 12 Sep 2025 06:05:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0dD-0007jV-Me; Fri, 12 Sep 2025 06:04:00 -0400
Received: from mail-bn1nam02on2060c.outbound.protection.outlook.com
 ([2a01:111:f403:2407::60c]
 helo=NAM02-BN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ux0d0-0001Py-3K; Fri, 12 Sep 2025 06:03:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vCF+inXC995ZUS3VezKVcF/z4XAcvK7zKOPKDa5ISNzG67nCzwFS4HfYkwk8Z9pa8qpuXmnWp/b9rbrJGB+fk/zwXZq31yuzL4GUqUWWG7KsNrIlRZo/RYY/VzH7m6TKGNWlob+eJzwSNia502zUhtbIjha/GsSc1qoEeg9dsHWJJhJucs3JgzdfZMRP0g9YK/3+o4hPeIeNHXqJR43KNvMzMwcXZe2IVFr1teX/NexCS7iWFB6J4yCPidKifuL8hYjdNjPlDqwzpevOmN2tqkrqocXeSX/e9RDoinnqzrZQzphBWAoWHRNhaPgMFc0VQRyIWm4fuHlK0T4lVdPCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7+eehizqazwdB6iHvoGlW3cC+8c34+ZcP6D1D7TWe8=;
 b=qVJVO+eiRnTTgq97vbirevEOJBW52nH7vY0ynHDrJIXkD5sOPa/R8iuGfD7DkUFTRPKbqylsm9u4FIVKq861UZt9Apr/Ou6UzxyJbwreD3E7K0nA+kJ4PBwVUaWAhRNoUU8Y/eDYnLfTq1h9jlt6qQ0t5L6bCrhCCaStnSR8Ibg+/DCgZiK3ycygu91u0jAQX4zH6QhJsnkGyC3CfrAoTE4Ywk3g7BhJybpAsNN631GLai2//ZoQWH6pTMzSsqzZK0MQ1D3oE07D8ftKLiyToHpDsrk3rxZLHQAP7Dsdw5q5zZY25N9kEvfXILPXiEMv21bvkas3ztRRzsGz8UdRmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7+eehizqazwdB6iHvoGlW3cC+8c34+ZcP6D1D7TWe8=;
 b=Pl/WD3VMJLq7pxZQcj5YfENX09PGgUEPJjE2ufTfmwqmI/iERMzAMBIMbJzDHhk3vsqyXsQsWF3S7J5qqHt9I51mqBlfqGQ6ATi63DI78Em2A57AkmCT5U+q9WeWm76bjWXZVJhMpwpbcE4KAOsDeU6Fbx1rKz4gD15JiZL6uDs=
Received: from DS7PR05CA0026.namprd05.prod.outlook.com (2603:10b6:5:3b9::31)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:03:20 +0000
Received: from DS3PEPF000099DF.namprd04.prod.outlook.com
 (2603:10b6:5:3b9:cafe::a4) by DS7PR05CA0026.outlook.office365.com
 (2603:10b6:5:3b9::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:03:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DF.mail.protection.outlook.com (10.167.17.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:03:20 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 12 Sep
 2025 03:02:45 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Sep
 2025 05:02:44 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 12 Sep 2025 03:02:43 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v5 47/47] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Fri, 12 Sep 2025 12:00:56 +0200
Message-ID: <20250912100059.103997-48-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250912100059.103997-1-luc.michel@amd.com>
References: <20250912100059.103997-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DF:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 86812469-6a6e-418a-afc6-08ddf1e39a55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?foDzt4H5LPcgGlC7eXvTqn5CJYrVlgDDZ+5vKr/uW2doIIj7nGoGyiDsDTiX?=
 =?us-ascii?Q?lYWvEyCh6mjSWJXLWep7ok0jcEE1/64VykGRdJimslmrj7ZpkdvwSrLUKKwA?=
 =?us-ascii?Q?9E3nwIAW24hbaeWZ4yBEVS7ZA9Vf9UZJxNzGaHSflu41ZcpyV+N6yqnc15cl?=
 =?us-ascii?Q?l/mES0xjNLeQtNuydMYJIZK76QHKmC+k8eEtVX0CfMzNDDE/t2VbtDqthoML?=
 =?us-ascii?Q?ipS9v71volGlN114DLupXamNTPKEniQkKTZGrXGSkdaAG4oTo81tpiNfWrJR?=
 =?us-ascii?Q?8fqzVJRa+RxD4+9bnpQxmsHhzowxF6pQ9FemDjVWxjR+ad2E4mCcFgIHZ+oB?=
 =?us-ascii?Q?zZr6GugTtefjs00m2twBn159M8HDZvbrmlO+r0HoU4b0cUWUR2QxYUs1DeAW?=
 =?us-ascii?Q?ymxlpH1PnHbXj5ZpsVvoJfiaqqjL44jpJXZUxOaQojumtDoqvoEox+n0wn8T?=
 =?us-ascii?Q?GOtV6sM1JtplsNxBoylL8TX/TGabqNroJG3v0xjAWa8xPx58L/31Ycu6TxWj?=
 =?us-ascii?Q?MfiLiAl6prfDim0TInVZXOke0or28L48I7lk5G+9Ik7cdoECroRLgPVS6Prw?=
 =?us-ascii?Q?cP12kHF4WX2v/aMmesr4JNKwDztoLZS/7TedgJxwsVvwC7Tca3Bk3k1uqRCg?=
 =?us-ascii?Q?jk7JRNQjoeRryR32v+l0SQoQ27AA33pTA7bxNHGYRrrWONw8D+8sCwLzMojA?=
 =?us-ascii?Q?DmVyxlZpValWR98dqXd2P0phHoA5TjGGRdiGYdxOTjH0K00sTviMrYf6mCCi?=
 =?us-ascii?Q?afmg+ax0a4StgG7S6AvhN7DE3GCwGuWI4AFd6ctdl4Gv/wwFMvqggHvcpBFi?=
 =?us-ascii?Q?1MSpxVpfImPly4xvZJEONO4eXRsEBZfT+7D5BPxOkw6PK2HRpkI2fnzF5M3C?=
 =?us-ascii?Q?8o2O0C6YROPfYg55ZCY68W8Nw41bFOF+EYZa66BVm9JrB/Q5gRLYAmHMBDrh?=
 =?us-ascii?Q?Y9IATl+gfr56MdvXQA2ZTi39sLsQ0OQ1z6tm7NN+P4GuX6A3MUaqg3txjYK7?=
 =?us-ascii?Q?Yqu3rnrHktDmQ4TAbhmc87INvwZ4ujUKKowzQDCZClRRwbymC3UV7J0vSCyg?=
 =?us-ascii?Q?IBsUn9dplxqXYX75JBN4kwW9y20W+pmgrtI3kXfiINhz1+FsKzQCmPpRO1uY?=
 =?us-ascii?Q?s1SHMxwPtuuGDDQDyDcf7Z9HKN991aMcV4WiTNO9p8c547BUjCHAGcnixArj?=
 =?us-ascii?Q?oKvI4IybjcbFT5iLWZ8XU2TWYJ6MkNHVXYxMsUynu+cj3mdnokD/rbP+2RPO?=
 =?us-ascii?Q?8oZrnEqH+Q52qyZFFluH70iDQnnRlFca6vNgFjOmqA/+ZHzw/i3Zsjm79QEG?=
 =?us-ascii?Q?8aIal9vbhArJxDxaDNshLZzdIawmW4VbyRCxajnk7F4HoxHrMyiUpV2H7lww?=
 =?us-ascii?Q?mda4axd/WSIguFfONrU0re4MgZLTEYHJJrpmj+mVeQym0fIpK/PIpjx+mF//?=
 =?us-ascii?Q?Z2KkT+kd/5hf/S3VES9HD/TSQFzOvqnZiXqJ8KRykm69xSDPXSmrbw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:03:20.4849 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86812469-6a6e-418a-afc6-08ddf1e39a55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
Received-SPF: permerror client-ip=2a01:111:f403:2407::60c;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM02-BN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a test for the amd-versal2-virt machine using the same command line,
kernel, initrd than the ones used for amd-versal-virt.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
---
 tests/functional/aarch64/test_xlnx_versal.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/functional/aarch64/test_xlnx_versal.py b/tests/functional/aarch64/test_xlnx_versal.py
index 95e5c44771f..45aa6e1b881 100755
--- a/tests/functional/aarch64/test_xlnx_versal.py
+++ b/tests/functional/aarch64/test_xlnx_versal.py
@@ -18,12 +18,12 @@ class AmdVersalVirtMachine(LinuxKernelTest):
         ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/main/'
          'installer-arm64/20101020ubuntu543.19/images/netboot/'
          '/ubuntu-installer/arm64/initrd.gz'),
         'e7a5e716b6f516d8be315c06e7331aaf16994fe4222e0e7cfb34bc015698929e')
 
-    def test_aarch64_amd_versal_virt(self):
-        self.set_machine('amd-versal-virt')
+    def common_aarch64_amd_versal_virt(self, machine):
+        self.set_machine(machine)
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-m', '2G',
@@ -31,7 +31,13 @@ def test_aarch64_amd_versal_virt(self):
                          '-kernel', kernel_path,
                          '-initrd', initrd_path)
         self.vm.launch()
         self.wait_for_console_pattern('Checked W+X mappings: passed')
 
+    def test_aarch64_amd_versal_virt(self):
+        self.common_aarch64_amd_versal_virt('amd-versal-virt')
+
+    def test_aarch64_amd_versal2_virt(self):
+        self.common_aarch64_amd_versal_virt('amd-versal2-virt')
+
 if __name__ == '__main__':
     LinuxKernelTest.main()
-- 
2.50.1


