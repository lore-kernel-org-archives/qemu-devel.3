Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33396CAC5AC
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 07:14:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22eD-0003t5-90; Fri, 26 Sep 2025 03:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22cV-00015d-U0; Fri, 26 Sep 2025 03:11:56 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1v22cJ-0007Fp-0s; Fri, 26 Sep 2025 03:11:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFa272ZWSFxPgHHBIwJ6XjxZd3LN4nd2ScpCmKGuyZ/WU8M+kjmieeY22ZA1/l8WKgo9TPgH4aH57Bi6Zg9IeFRG61OsBGjoa4FSi+vw5HLxLAkLFzdxsjED14AgCUNH+RZDBeivJyFl6BQ3Awki4Kd6VkR+SyXnHLqi/mR9RQrJcHBlR1XNgyK1J41UoJSd+DQEFQva5VHmBD0BxcukXPx86v6cFKr051pEUA1LfIfEGB8QJvJjuqqnXZvowj+69BQ4+3v97dCAfb51K2O77Caf+enUdgyxcs1mcj/Iwm3nqjV0OhCsu5YumyTEweGE2kxHD7TfikdiFnY0EsOCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kihyp+p43tYNcqRkNOb/4laAo6FtxVLRtDdITnqWkAk=;
 b=WoIH57OriWdxBcsYBz36p1nzJK0lqDLZaT7BqHY5nbR2K3ftMJXKtHlp2BSff+TA3Pz1Fl4IgPLSButneGDd/UHbokzqXupt56sNPInfr8O1OAm8Lh7RHLduZLsZmZJqlTXjJzNWHYWZUADr0zz2CSFaSfEn5FakDPm9L19eONoIfuqKEEu86ODnpG7gtoBeXxAXj80Q8GMnx52BX3+AoIyF3srygAP1j7aqwi5QvdujyYtUiY/90sLa3DLWUO/dceA1dpVeXhVJTU0/7FyjjXjhXFcHornooYh8ht8L9p8wA0qwMZYEwDNnoB/vn3I/6cUXnMGgTY4qOaor06EUVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kihyp+p43tYNcqRkNOb/4laAo6FtxVLRtDdITnqWkAk=;
 b=QQxVMp3cNIYmuEqLoO7vdSRX8/JwDeQY/6h7mZMVjQbow3XhEQBUv4ha7g7LyxnET1TcRKeKjcgzd9itMhKOkY+kOeo6pHmb8NTGIbHY1t8OUoDtftY1esIUDMlFsqPrX5T/T7lQJ/JF5/p0/yavegyQawk4uIhzyXSvpRIZzxk=
Received: from PH7PR17CA0055.namprd17.prod.outlook.com (2603:10b6:510:325::16)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.11; Fri, 26 Sep
 2025 07:09:47 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::57) by PH7PR17CA0055.outlook.office365.com
 (2603:10b6:510:325::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.10 via Frontend Transport; Fri,
 26 Sep 2025 07:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 26 Sep 2025 07:09:47 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 26 Sep
 2025 00:09:36 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Sep
 2025 02:09:36 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Fri, 26 Sep 2025 00:09:34 -0700
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v6 47/47] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Fri, 26 Sep 2025 09:08:05 +0200
Message-ID: <20250926070806.292065-48-luc.michel@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926070806.292065-1-luc.michel@amd.com>
References: <20250926070806.292065-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b78df1-ad00-41c8-7da5-08ddfccbad91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6Twyl6qzNwBCoogx2REfR2PGSsC/FRjY0l5tdbIsaq7xyMVpAtFMHfFAf3X?=
 =?us-ascii?Q?9Vf6n5BfNaJRluaQM3nppgoD6lIU8Gzgw1dHjfeNFxZsgxzVwd6YNdrQP3Ba?=
 =?us-ascii?Q?pMpY77ZShXgF1gnMYZg0P00pWmYlD21i8NsjYj0t4Q6YxYveucJZpH/ogUbx?=
 =?us-ascii?Q?r/VYGW7BEEPOdTDn1+rEtsKzqxn7+AJl7pXOdKEZfD6OmCSVwzKiHLbftRlK?=
 =?us-ascii?Q?feldp1HQXI5lrSGuKdz8q8QMquxQKRgy6N2rdn9qrsCA8hQWU+5Q0o4HxKpw?=
 =?us-ascii?Q?Pl5C8GDETndEQT0YEjTHG++2jNkgK625OiPmMoBZWgH3LWGbarji0RgB/sQx?=
 =?us-ascii?Q?LUA0CWrNmLbyWYUtJOjBU9lfMboHjVj3gLNPO0ltloehLmnhGvHvE7O+fnZc?=
 =?us-ascii?Q?g21z+o67FGLyAuH+jniJcm2aejOppZPHhEjCyxq6Vyr36pDkLuQS8DNa/e1+?=
 =?us-ascii?Q?zH66vSjJaiwBJwiVauPmNUvxzwWuZbrw4R4hBFOuJweBxoZuS2kN4bxZgg3x?=
 =?us-ascii?Q?TcR+IwOtUlK8uvhoJAIC6mjXPLVIk38dhLzT1a+p26unL5ehPv2CQLBtc21i?=
 =?us-ascii?Q?kLDg8w67jNXRzfHi9AYgEWMGKzxzL0wb3rcoU32Rg34/3I8JNgrbXN8feUFu?=
 =?us-ascii?Q?iUHNm63I7Bb8rx/VyA/vKaK4Hjs3EzrVqHBScBaN6JhfYCpsKwfx/jr2Yl+4?=
 =?us-ascii?Q?URIZ5VLw0WZsstCalthNLsAyiFkOpiT0wQ4sHtRT9np47vmvnxsSHeH3+YME?=
 =?us-ascii?Q?UeVvOiINlHGY1ObxznYVpovLPIcsw67+zDIJugGbKVoJz3QL3AEyLLyxZYka?=
 =?us-ascii?Q?kRjPacLcHdX7VyqzXfeOEi/jCZcrrOi51vSCOhKe5CIA5RZsKYJ+K6RQZrkB?=
 =?us-ascii?Q?X+fhQczCGNM7VkaX1XaXL73Wmi2wfg/0YB3TU77e1JPPawBLZ+2UlUJmOURV?=
 =?us-ascii?Q?wtdpwZFsxovr3oe74GNkgeTUEuhR1/6sZOL54plRUL5f9iBW6A9viUvHbWwr?=
 =?us-ascii?Q?syF7bFSEijtdu5de1WCa2dbBuHtxUh55LnxDH565TFjPZtfGeqZcWnlpaive?=
 =?us-ascii?Q?W4o7FVhogrXcXtAtdzhRJ79mOOpReUJR9z5aOsV8uqXXeuMdtzxodZWgWLfM?=
 =?us-ascii?Q?lmKchxlPyv5xrmmjOdxXUQszUD9PLPDKjwhsfg3DfcqKNCGJyzNoLUjc+7Di?=
 =?us-ascii?Q?T5ybsfnS204YgXNmSnWFyLQJiPKZGKKrdokY6CL1qMYnwPvVpt7OHQ0NolDI?=
 =?us-ascii?Q?jcSKSfrUBa48WPEWEJ7U0qP8I+M54oKOn0DMvGuQlzR8zfiNP6EwnnTMh+Fp?=
 =?us-ascii?Q?Z24+o/plOqI7NgHzTEVfmuhLExx/wcWMByYmswvT9qjLdrm7gGBPrl53vIvX?=
 =?us-ascii?Q?cxZWDZ4U6hMJWO8KqmBWC6UpX4Dc0TbRYFAerl3s6n31/dZELUWgVBIVY+Ef?=
 =?us-ascii?Q?ILJTKrRZidWkEsWeuF83O/w9ynvhIzm+QpkQ6/ZQ4ma8beUVpmhlKg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:09:47.6136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b78df1-ad00-41c8-7da5-08ddfccbad91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Luc.Michel@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
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
2.51.0


