Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C43F2C83F1B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 10:09:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubyv0-0003F2-Kz; Wed, 16 Jul 2025 05:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysY-0002pC-53; Wed, 16 Jul 2025 05:56:46 -0400
Received: from mail-bn8nam12on20609.outbound.protection.outlook.com
 ([2a01:111:f403:2418::609]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1ubysV-0006po-T8; Wed, 16 Jul 2025 05:56:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+vOa0PKJOFHmkuW1LfZZesi6IjNblJTc1P9alhUf9s1EXWKkZF+lGgN8mrStL/idxV60xUb2Y2SI8N/mt9+F6uY6aenDrht/BqEI2KoeUKxrR+OAUeOt0f2U1IC7qMRi7kEU4MVMZC7MUGS30809cF+wF/mYoG7WUN5vaza7t0vI/DxtUzoLdqeV4oL68rFsbj+vY4xg02SPzdASw8OhNMUINMw4mY5N7jgfGsUk4ZETSBFYbxy4xWrHBACsQSqUi4XaMPBHsPsQRnfm423l7mHGhrU5xk6m9yEiTQNMOE490P00apgzVnsJYdP/Ahb4UgkyxqDdhqktP+0Q8Ex2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR7RusYRlXJOiL/py+ko9ymo2tWV4kBZXkvon8Zsz+s=;
 b=WVvxD7cCEiY0NbjLi3p8jMVUzY4wFD/vhiKqLJv3bNPA0cs3oMgGhjRZTwVYqW2xL0mETf0eXMILiuy+hGAGpHmnaeUVj5OQl60dm/uYekL28vY7rCEUNib/vi+jxToDR1i7CwLTs/LyvZZdJry0p86bmMQRw57JaVgdPbgg76VDc4ZsBZhivIduUUZpbFJqR4MwK39LmwT9oZzAcIHCmkFWigEGFFtQroY3X06y/NhXaEraytDHvj3dYSgxRL9rL1Uu1PFh+D4VoldLPP2/xsYf7pGRvOFrZdVwWeKOgXjYJKYbSHANIQ5Pe3GAa4AyPJIu98gIM/6OCORvL+Cg0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR7RusYRlXJOiL/py+ko9ymo2tWV4kBZXkvon8Zsz+s=;
 b=zWXachF9CCBMwnOKkolwnaxcjAM8+3rbnaoa7AIwbT77q7rlrhSoi4/L7Tnm2iR8J2Z0/KDDIoL39cdahkyXu4+lJAvrLyaD3ewCU+JTH0Owm27ctyDXnRoGEgsZ3QZZiJfdwWtBIVKs9JRTKJNvIb1L91/ENCtqXr4bpNo8Mfg=
Received: from CH3P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::31)
 by DM6PR12MB4155.namprd12.prod.outlook.com (2603:10b6:5:221::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 09:56:36 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:610:1e8:cafe::46) by CH3P220CA0021.outlook.office365.com
 (2603:10b6:610:1e8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.19 via Frontend Transport; Wed,
 16 Jul 2025 09:56:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 09:56:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 04:56:35 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 04:56:34 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH 48/48] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Wed, 16 Jul 2025 11:54:30 +0200
Message-ID: <20250716095432.81923-49-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250716095432.81923-1-luc.michel@amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|DM6PR12MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d06f721-798c-4ab6-cabb-08ddc44f0d91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h3VGWv0Fyu92H8Hh3ldITog/3wpdfzMTDhJKIJBeEViAIHWNOOjNaiDT4/tW?=
 =?us-ascii?Q?KP7dsRywXh9wfJAndK7KASiArfFKFmTDImWNGCaH6c29omOM/q1fSYAujyUO?=
 =?us-ascii?Q?/k3GYk5VsL87ZN+j6LaUbpPwtagsEUoPWba+UCrgDz4dle61wUKhwShNWXoh?=
 =?us-ascii?Q?hocoxISx63S6QJSd0jSUGuJWNJuZ001eTlIbyKvjHx92WRUY+joQ6Bqd5d9l?=
 =?us-ascii?Q?vy0FVxdtEevWkGDAfMJ9Z5p32meVErBm2SA+g3IT8plm2JPQ9W/muitMUnrx?=
 =?us-ascii?Q?0Pgjfmr+0Tz+XDKPnssS3me+pTUqdwUPAgWR6AtREo5kyfsxKIo2QIl7ySL1?=
 =?us-ascii?Q?sa8AXwgIJ5XU5J5wWWkWpI97lVYeJ/YkTw6vb4DyExZqnF6kYHF0QhzSa/mP?=
 =?us-ascii?Q?Bl28vdfn4B+Hd3DDwH5RO5Nm4xfum9v0qbQuv0RRKV1uA2gn8nxj/wzRIh8p?=
 =?us-ascii?Q?tjyxD7XpJxkgS7hzVzxPjyJWdZ5MJPZKuho8tSqo/knzJUiq1lzOg+y2mM2y?=
 =?us-ascii?Q?rYnmI/Dvl2amEr3dWGYwV11r3NwNC0+NF8l7NrQWcvXk70i8P5q1XDqkGfW4?=
 =?us-ascii?Q?d+Ckbnxx5GOA0VSwa43EplHRFQPkHXsdC60f9JwEx0aa5ttSoedpZyomgpaX?=
 =?us-ascii?Q?YzaG7er+einNPI/3MJahGmpeU+CVdpm6qGgakrO2+bCiHfHqntzZbk68ySy+?=
 =?us-ascii?Q?VmLI3wmB6L6UWksK13fMq3mSfEskLm3kgEKyz5Hy4hwE8jdRFfshg+hst3OV?=
 =?us-ascii?Q?fKEQAvvn4M37xAdlnYjcjN5NMxqaP9eZJPrnuixfFNvezZbtdYBVftfjYd6U?=
 =?us-ascii?Q?ZuhAjvMt809znH7rRefFMOTDqtRMDQ3fJfXPZlCW1i9Ohb0RX6Yb/SYjnUFE?=
 =?us-ascii?Q?jsSlkO7jOGTRBr2zA+EG67hNoiHdTtVP3osEtiWyeqGAgdDNSiI/4i5YULlc?=
 =?us-ascii?Q?6qJ1lYgudBgRddnQTf+NrCsmrRqxq+spxuTPxsdRFKYV+aHjXCQFxzCpF22S?=
 =?us-ascii?Q?myTOHKz5j303Z5igJltsL8b7TOMcMqqMiAqCSsZ5JN6RmucLwNuCIafuqm/X?=
 =?us-ascii?Q?hEcOf9lihO4ALqzJc+4ErLGMyYmgLp18kuoXQ7Ud3MUxUq796Lu/hmyZ0eix?=
 =?us-ascii?Q?q2oYyZc7hoVp2ECg+Ok+h1q5rvpOw/Iyp8Jne96pNMIpv0kryISgKxJeg09x?=
 =?us-ascii?Q?z0uxG8gtHwcNDDytwKVCRAn5IrJmTaft/GjTbpMcHMRPoTqEJI2PnBlLXHA6?=
 =?us-ascii?Q?Ts51FxAWxamx4Qry8/bZhaNhr7gvmyXGSxYDiaWtIQlB5giUYHhqBghDazIp?=
 =?us-ascii?Q?U+geHmPtTpFoYNl600oZoGzqlizqflmDKIDNCR7YzjMqqX2ar1/H/TH9qxpW?=
 =?us-ascii?Q?McN/aklXyQcFzfnCYPfon1/2yFl35H6kcrkzKnEHEA4XH1mh3B70A10JlafD?=
 =?us-ascii?Q?oZql8YX+ZcEmTnoKBdCAHeMgNP5IhkZ/3rhJ0OvGhbTs88aC9pdhEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 09:56:36.4817 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d06f721-798c-4ab6-cabb-08ddc44f0d91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4155
Received-SPF: permerror client-ip=2a01:111:f403:2418::609;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
2.50.0


