Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA411CA0EDC
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 08:33:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoeCC-00028o-KM; Wed, 20 Aug 2025 04:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAo-0007qo-UV; Wed, 20 Aug 2025 04:28:03 -0400
Received: from mail-mw2nam04on2060d.outbound.protection.outlook.com
 ([2a01:111:f403:240a::60d]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1uoeAh-0001Bl-IE; Wed, 20 Aug 2025 04:27:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NpcrT4/noJ1gc6EKNJDiyIMzG2ucABz448yf1p5xGELpkGcPJRZ/akcD7ItGYc+SFsPxKXsaaeTAwupdM99WCbcRsk95TP0esD5XD26jW0eJnC2GHNhm1sp6mroEnghfLqEQZVH142oApA8tNRxU091IFIvULya5kK5QstdtWtnw5pFIyqOiZoaz2dkcG76qLtMzwVezHXamfoQIB1+xsqIC64jgpmNQk6pTSbREHY3R6CjbYkun8zjKkKSijXF0h18q8EjnnYC9GYNTy2Ds0vnn1qnETciVOQipCxmFzujOt8KCmyIMzxuQxJaZOL6UqprejW94PN1RZzwOmkMs8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EggKcBPTWSvlw60MLxVeyUG1ivURX6FGREj7MFM66Fo=;
 b=ZFUSon9EQUr8UdrE2HU3NvWjdZARd1NgPIbAc9dy6DRhhzTtF/dSPQnAi/4ZqbLBV4GtoHp3+iEt3l5qEghTo1pP710X63AH7No3/6/Uxa1EygjJQpoxUFG66oi8IWfm+2Q2HHXQZn6AycBuCD1BWgHfSZaHMyZXrxY1kVC7ZXeIVFeMPSRvCo4q+7oCK9iEzqM2NQDEHyVq4gLQd9QTk6e/aF1UTDJM5Y5RWYbTgTwdPhgELowLfzL148R675SwUNXxlmkhuphdne+LwY9jY8F4ZqUOQrUpDih0nzQpT/cg/tZzCVG4s9fKso3XronqN0agTutR7nKXdowhBL0edw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EggKcBPTWSvlw60MLxVeyUG1ivURX6FGREj7MFM66Fo=;
 b=mzcfOIMl2bTFCjygps+mfYU8uWjkNxqUXW3+kbWB6smVGy51w0IF4RtVdfjCUgsNOrmBhLskrccm3XJ4Eyh+5jVkk5tpOfkX2DnmsVqJLXQujDVvLCcWDYW/275yzqCp86njHn74lv25AJ/u5uhcmYvyCZztUJSfXG3TKf2T3PQ=
Received: from SJ0PR05CA0179.namprd05.prod.outlook.com (2603:10b6:a03:339::34)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:27:42 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::a2) by SJ0PR05CA0179.outlook.office365.com
 (2603:10b6:a03:339::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.13 via Frontend Transport; Wed,
 20 Aug 2025 08:27:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 08:27:41 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 03:27:41 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 20 Aug
 2025 01:27:40 -0700
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 20 Aug 2025 03:27:39 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v2 47/47] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Wed, 20 Aug 2025 10:25:46 +0200
Message-ID: <20250820082549.69724-48-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820082549.69724-1-luc.michel@amd.com>
References: <20250820082549.69724-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: a729b098-a9da-4b28-c17a-08dddfc36e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wqaUzHqmldiWJkwHaAZMqCzFPoNchPOW3utyQLNkmVDxNFvDEi7sUMhZDDPw?=
 =?us-ascii?Q?8OgnmgvAuRWdGuCOIe9+imB26hNVHbis9nQCTmg7K6lRnQLCTGl0l3pskmaH?=
 =?us-ascii?Q?Xzua8PRxFkhkCNa32HDECGHnc9vr3U3cTNhERF0bLMtKaYh2jY+8FQDkncPB?=
 =?us-ascii?Q?WKlDWpOzsz6wj2bumNXVchJVlpl4i0WvwA94KlUlMD1+JWxCEqQqYhRJsowp?=
 =?us-ascii?Q?mS58v5OsTG5PtwDrs90UORUKgn0zXT9RFZ1E0lkO6+LnYo8swybobq+/rV6l?=
 =?us-ascii?Q?oTON9s8pD0VODWmkM2hZ4xFy/gGNX635B4Dju9mgLJPbplnIK7PHhHzuTFqP?=
 =?us-ascii?Q?730k78gQZaavO4L6MuLbXA6MnC1MRerUhmP7+MZkC4FhkoqdBngYH8UNYMG1?=
 =?us-ascii?Q?JzKXXEq8xz91x+jaYss7KSogVJ/4K1uX0fHpSPYwNuNSXeNlyEWa7q4njkPM?=
 =?us-ascii?Q?bFSsvl74Lb1ro3b122slb2t+mrCnAYHJrscLEiQOeFd7/W4fCIx2whpHkeML?=
 =?us-ascii?Q?WmbwGeb+75uU5UVWpwSqbxMHx1WPkVH5Hil/Jt9Lvk5DXGKXB4/LOUS7MLaP?=
 =?us-ascii?Q?QX4lOFWfrzhJHw1i71+y+sSLULcc1CXkYh0/QJc/h1uBYkJBClgzWnFKDgAk?=
 =?us-ascii?Q?0J17wrrGbNxl3S/NIoYWrz1Bd6I01xOn565cefdcrlo5rmRZc02PbkHdyJ46?=
 =?us-ascii?Q?ZdWGmzxFmdIioW/dANK3A9l5QTRIQpXJpApGsKWaHNtlwElyTohZ3nNM53ts?=
 =?us-ascii?Q?QWm6HMa3GDMLWf7vkPnbc3hDSWpe5YK53stFmSD7UiKUaKnwnK6PGQAdFzqF?=
 =?us-ascii?Q?Ambht7Z2pLpyLDJ9m36fcs5ZU94icUgarUr8YBDe5UKyvhYGsI/IXSKnj/7W?=
 =?us-ascii?Q?5EBCcZ8Y0b5T+i+i7EI6Dt/GkMEyMP713E3oNL4ETO8XhPkcfuCrPIHQ1I3/?=
 =?us-ascii?Q?tJ+LOX5HOB/oWlilO0kafA7iihSe8uuEO0hXY8dl4tac1U0d53oZ0btvvjKo?=
 =?us-ascii?Q?2H7T9xdRR1q3PdzezvTtzRr58r33vCSXGiR+Pmnh8Rk+QigbL8zVEiUBd9Kk?=
 =?us-ascii?Q?B2s3Mj7IadY6FogOSUmBLboWZNtlf9kwwyuRkd8CL5vP4YD8mB4HNtl3IwRh?=
 =?us-ascii?Q?CqVIxhpCifKoh7MKg/ied7g9Mvt7tv4wvU2GybwcQJvV0cCuK8RYxNeJ1lE/?=
 =?us-ascii?Q?wG9n4ZBlQGAHaJXbs3Tw54v2sBJr8MVqvPRRo2MZLO66ZtLNOuSOE9OdHONY?=
 =?us-ascii?Q?9MeC1ZqcsXc3GnI8IJXquxSWaEa8axixVod7PinkvjhI4qS9rGeXrOBeZtil?=
 =?us-ascii?Q?t9OTWCbtub0qcmmMRF2rLKMP3ef0h/V0fs36tfZIVXtXTfVqUxqosoX8yMCa?=
 =?us-ascii?Q?vviY1XiARdOY5VXPJVla2EEqZe5rIhl82R7Qeu6eIHQfqjhMMpEVuf9v0Hiy?=
 =?us-ascii?Q?y3BmY4DZFuIU5VYu7IZkqAn7Cnlf0Qc4CZ4+5uCNanRW/dNgzwXrzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:27:41.8424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a729b098-a9da-4b28-c17a-08dddfc36e5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
Received-SPF: permerror client-ip=2a01:111:f403:240a::60d;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
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
 tests/functional/test_aarch64_xlnx_versal.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tests/functional/test_aarch64_xlnx_versal.py b/tests/functional/test_aarch64_xlnx_versal.py
index 4b9c49e5d64..f32d904ef7e 100755
--- a/tests/functional/test_aarch64_xlnx_versal.py
+++ b/tests/functional/test_aarch64_xlnx_versal.py
@@ -18,12 +18,12 @@ class XlnxVersalVirtMachine(LinuxKernelTest):
         ('http://ports.ubuntu.com/ubuntu-ports/dists/bionic-updates/main/'
          'installer-arm64/20101020ubuntu543.19/images/netboot/'
          '/ubuntu-installer/arm64/initrd.gz'),
         'e7a5e716b6f516d8be315c06e7331aaf16994fe4222e0e7cfb34bc015698929e')
 
-    def test_aarch64_xlnx_versal_virt(self):
-        self.set_machine('xlnx-versal-virt')
+    def common_aarch64_amd_versal_virt(self, machine):
+        self.set_machine(machine)
         kernel_path = self.ASSET_KERNEL.fetch()
         initrd_path = self.ASSET_INITRD.fetch()
 
         self.vm.set_console()
         self.vm.add_args('-m', '2G',
@@ -31,7 +31,13 @@ def test_aarch64_xlnx_versal_virt(self):
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


