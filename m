Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37F0CA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 15:36:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upTXq-0001qe-CQ; Fri, 22 Aug 2025 11:19:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTXL-0000zz-Sm; Fri, 22 Aug 2025 11:18:40 -0400
Received: from mail-dm6nam04on2061b.outbound.protection.outlook.com
 ([2a01:111:f403:2409::61b]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1upTWv-0007JV-N2; Fri, 22 Aug 2025 11:18:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr3TMXU6AlPZG5dnbPH1NeV7ni1dZkXEnBc+cf3o2nAOJg3fEP0DUdVQxPIR76VGUgNNyvjHl6XqzTc8EM0ZxN8zz4VOPKUjoEc+zQoCIHaKG6zPUkdjZEzbbpl2P+aNSuL9/jP0iJFb9GEJjpK5RmMaVjFRjqQh/gGWMxss57ozS342V0O0zPAW0ftsybu0f0LDULTaBYk12JimeQ1oqcPTxU0F8EmCgg3Imz96ReTYBZPqv5A/BWtRi7pVnm3xqxUzjwvu5CHC7gvJS5T9KbhA6gUAQjdVzKU/Wuh663AZU9hoIdUWVJrNsgc/LpKxvrNy8LSPSu4HFC5WUDLhTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX1i5QXUicDE++m4MNj1pW+sh0I2BoPJKAHDLy7Qr+I=;
 b=CYzVx5E8nU3cPJh3zCJGwb41SLuyLwAX4jQTQLcyyEAS9WL57NHfNINuUhkt/fzWsyEeD4U8j538PDcZ9supW8u1xqeagFPCmKXghLdmJufdNcXHSQwZZHbKCkR0AqABU1TBwhXIudwIyFiCYYk97n4/HTBbJEZhHbImNEIcYErczAh0jD/Akj7LJT9VswzqDVw3c/jXHsg817Vr5fnzcG7Ms8ip8IuLxEaq7kDuDtsSq5SMBJLp0ilZ95syeyw7uSumAZTJwj1NRxSUMs6sigcPlNojwE6vkZUfeeHsAEQvILA8zhVrl1DsLukbfCTbh7pDc3BlLVwapsyR8LB9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX1i5QXUicDE++m4MNj1pW+sh0I2BoPJKAHDLy7Qr+I=;
 b=Vw9xjE3Y+8uOxuM03YU6lqb7IqvzvGiNQGlXVRxovMsPcJqyM+7GWy3Bo3Y6QQwprnf/6uBnuoivuU/472/2bRaJrRcBHpTbC6fxakfmbMH+fOHBagPVLuEHeMDtsTerTspYejcb4zQdINm5H3SZ/5w+A4fHoh+6uQ7BdtbHsI4=
Received: from MW4PR04CA0319.namprd04.prod.outlook.com (2603:10b6:303:82::24)
 by CH3PR12MB8711.namprd12.prod.outlook.com (2603:10b6:610:176::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 15:18:02 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::78) by MW4PR04CA0319.outlook.office365.com
 (2603:10b6:303:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 15:18:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 15:18:00 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:18:00 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 10:17:59 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 22 Aug 2025 10:17:58 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v4 47/47] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Fri, 22 Aug 2025 17:16:12 +0200
Message-ID: <20250822151614.187856-48-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822151614.187856-1-luc.michel@amd.com>
References: <20250822151614.187856-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|CH3PR12MB8711:EE_
X-MS-Office365-Filtering-Correlation-Id: 0301ecda-cb76-4286-2eda-08dde18f1507
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6royg8inbEVi2o2O9rzUdMDTo3UhoGZCnYbdIZexgr5DGuMyZxjqOYzVdEkv?=
 =?us-ascii?Q?fJeM3nAHkbfnSp3YhdtaOjq2VzEGf4DZM0rnuxlpmFThDA94hLC0AhUUvaJT?=
 =?us-ascii?Q?ttfJjHcQ/mId2ZTJfnwKjph/R+jONBRWUFS7En1X1hFUk1IPC4osqbZjucv2?=
 =?us-ascii?Q?JT6Dl5OFCCrnS9Enl1cSqdr87Yc9217IAUI6GfU8LnB8R6eREi+if0w8RbvE?=
 =?us-ascii?Q?BUNPxXVm4X3Uu6Y66pZIXU5dS3K0IcwcVVK1zNPS8aZhyssDI5DV7WaeBjJL?=
 =?us-ascii?Q?pwfdY6MMTUI+yvhKgA0S2r/FfOCxiclpsBgvtZITJMBAgGOsYvpp1fP3aDNN?=
 =?us-ascii?Q?5BHn/3xbC0BMeTCSq3k687I6eitYNcjK1S5gxc8bGEccEvdC5jM0NhClrtY9?=
 =?us-ascii?Q?bJF+7+++oC32j96CoWqwefz0LwxCfhtmho2A2k11ZbIcR86ggHEww9sOGwqk?=
 =?us-ascii?Q?te0kKNYgVXpyY7+77cBINeL1+zxhvyERDRT6tH+yGf/qYgnGQ+1FmI4ykSgp?=
 =?us-ascii?Q?xqEe3jWlGkp68cMrF5RmvYMeZxfyNPXkDQ3dv7v9USw72ZKqQHTHkPx3cDWM?=
 =?us-ascii?Q?7cogd0quxj/Fi+zHKGggECYQ8x0nM5g6dHvN1/WhpInYUB7MV/k3q0E1n8Do?=
 =?us-ascii?Q?OU+Iy/EXs8csC67hj7YjY5rT07mVGjXCg0/9eTTTA4eshAS41SOUhSaJOLIF?=
 =?us-ascii?Q?ZG6G7/oDBu0seCgQ02zPEuz14xSbyCQ0Slt0ZZ/A+QLmMlkWoaXVBWdowX1O?=
 =?us-ascii?Q?kR8DpN4SFGj/2mun7ez7CTM3sI3MDODk5ch95h5WljPAywqv3JFXr38RX48h?=
 =?us-ascii?Q?GGVVKv56S4taZWA3YWQnAoNKYEfNBM2G1y9H0xGyQs6ndIgopbn4ouPPbF80?=
 =?us-ascii?Q?DJOPGGdvmBDyxPHvqTKCNt9sA2HdvTYzLZSegj6b+dIG3oAe0OJAqpHX55TN?=
 =?us-ascii?Q?w6FzgqB/D1RJDmBik+T/YgYm/noiGAbnTK1X+oI5EdCCUR/hDyJj4WgBSbEh?=
 =?us-ascii?Q?YhvcHKuMrDI0zjz1rXwlmCbiRfHEtuU/88LUVR7aHlq4BGrfTJyU3phw0uAO?=
 =?us-ascii?Q?4CmKJ3KmcqtmhPzLuty9Q3Qor85oipREy+srGI0WER4TQy7Aosbf5+IB4yjw?=
 =?us-ascii?Q?a0pki1+SB8sv7n/5vvSd4oamcM8PHXMp/H0Zzw2G6H4xQHiw/dG3aY0xE+VM?=
 =?us-ascii?Q?lbRvlGnZ6l/hftr03FDkbePn64SnEwYDRXpft06ACn1eC64DLM3GOsg+mID6?=
 =?us-ascii?Q?5+P6yK6vXEXtBxsC/xEeYFkrCyTmGqIu/NxWkiXZ/35wCZJP/Y9TKRZBAHkS?=
 =?us-ascii?Q?6O9Atr6IKTQuCc86IN92KfByM75y0oO0hJ9U1Iwu2rjL9NUGYpjPBWJuXn+h?=
 =?us-ascii?Q?LF0WARi+E/OHFX0jnLM/Mp6QX1pAHbO5NKdC8guMUrcASzrG+ByGyKaCjPKC?=
 =?us-ascii?Q?F7qxsqYlN6oE1dU62kslCVqC9OSxLFZcNVWViCccz9qmeB7n3QDRzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 15:18:00.5113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0301ecda-cb76-4286-2eda-08dde18f1507
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8711
Received-SPF: permerror client-ip=2a01:111:f403:2409::61b;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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
index 95e5c44771f..45aa6e1b881 100755
--- a/tests/functional/test_aarch64_xlnx_versal.py
+++ b/tests/functional/test_aarch64_xlnx_versal.py
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


