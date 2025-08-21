Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B412CA0EFC
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 13:16:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up50Y-0004nm-Co; Thu, 21 Aug 2025 09:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zG-0002da-Q9; Thu, 21 Aug 2025 09:05:50 -0400
Received: from mail-mw2nam10on2061f.outbound.protection.outlook.com
 ([2a01:111:f403:2412::61f]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Luc.Michel@amd.com>)
 id 1up4zA-0003Gh-5u; Thu, 21 Aug 2025 09:05:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZfMXny88maRPnjhsus0mWb21dV3sX52aEXf/LtLTEQec3Y9C6yPZ4cuSBqo3JjyH7Ce5KARSbp4cb43IRQZLO810iwArEBPwWz4MNmZVGDOyjl7aRqyEgKBdAm/oaeKq8RZox57XGFmDs4kHEYgLfwh6X60/284hlxXeF4l+VS0TvY3685U00iRoQQypeRCHqv0yoT9zzLKg9j2/LCyzPedCx6bQwdpfmGgoSMsZ52E/fJT3xyj1HALXHEn9nAc7j7BkwuWM4LQ1xDC90ilLfqO+C3Xc2iTzhu0T/PE5HlUpK86DgMvcGy7lIditKeovpuurEsHlpT/e/d4k5ZADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yX1i5QXUicDE++m4MNj1pW+sh0I2BoPJKAHDLy7Qr+I=;
 b=crnwk6dNvoIrn5yErbyUf4+V+FyhZTgS172piXufJnqX5mrs4J285WSp24PyWNuG4g2Ppo0bJqhtJN4sxuy9d6MqaDjyIQ0tYO2JV19i+pcnpN2HyY0O/Ve9WGOmgEBTlds0vQpRkZtE5pJCaUHxOp3Qi0AVxwLnYjvSzukyVA7Y5dvscYwXXc2/swAodPQ3ZaEzgWKXWfTHpfhMDNDSMsQunwX8A9TFkQuyXdeSBWrsfbPBDMo6EYV4zraCYIdiwHUiLrvZyWTcmqqbJ0eDR4ejNeu6pZKQvJJ8LWCWxdUEf9T2Gra6ASmuiGkPr+n7O+sCH4bNdgK58bDn/Dvy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yX1i5QXUicDE++m4MNj1pW+sh0I2BoPJKAHDLy7Qr+I=;
 b=3FrzMT0R7JMsqFFSzYTnLaNZufO89ou9eL+Ry3PRb3wDbiUBxP6w6iUtFgCKU2kULk0jLmDI2nn8DiQGIBHC0aMT+nrFf/P2fkdEqq/VcILNoCFLon4GvHcREcUySuDG/Aq2R0ZxhZWXHhbmT6xF+WglCou2RRkxsDOLiir4+Ts=
Received: from SJ0PR03CA0093.namprd03.prod.outlook.com (2603:10b6:a03:333::8)
 by DS7PR12MB6336.namprd12.prod.outlook.com (2603:10b6:8:93::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Thu, 21 Aug 2025 13:05:33 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::8) by SJ0PR03CA0093.outlook.office365.com
 (2603:10b6:a03:333::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.16 via Frontend Transport; Thu,
 21 Aug 2025 13:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Thu, 21 Aug 2025 13:05:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:33 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 21 Aug
 2025 08:05:32 -0500
Received: from XFR-LUMICHEL-L2.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 21 Aug 2025 08:05:31 -0500
From: Luc Michel <luc.michel@amd.com>
To: <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
CC: Luc Michel <luc.michel@amd.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Francisco Iglesias <francisco.iglesias@amd.com>, "Edgar E . Iglesias"
 <edgar.iglesias@amd.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alistair Francis <alistair@alistair23.me>, "Frederic
 Konrad" <frederic.konrad@amd.com>, Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: [PATCH v3 47/47] tests/functional/test_aarch64_xlnx_versal: test the
 versal2 machine
Date: Thu, 21 Aug 2025 15:03:46 +0200
Message-ID: <20250821130354.125971-48-luc.michel@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821130354.125971-1-luc.michel@amd.com>
References: <20250821130354.125971-1-luc.michel@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: luc.michel@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|DS7PR12MB6336:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d6a8fd-eafa-4ae6-f2d0-08dde0b369da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZE8H5k2n/zcItNK6oIKxVr6mD/xSkOhNjeDx9sEqnD+i3OSu0KvmAEVOzg31?=
 =?us-ascii?Q?lJPVqSWBPcik6ackEEpn/PaodIRjFxBema4NfviRxUqjKPRSUo1sFtBSNeKL?=
 =?us-ascii?Q?dF+LqcqzASEcQpL6BTbc84SP0xvy0cw7R2SO2gVZ6uk4cKNN+fIUU5C8vB7B?=
 =?us-ascii?Q?JLb5H7WUC9cVCsrBXdZS8fTYj9Qe6BI4VjOvyYlGMJwDnQIb0sbGl3HZXcZS?=
 =?us-ascii?Q?Jog8ENwvvfG4bkdNoEde6tuG8wPSwC4qoMSw0v0/dwsktKJ5qhrWE+6fG454?=
 =?us-ascii?Q?gHy+qEzDwXq4uE/PJwIpjHNVz0Mz4ugraqADzt8JQTLNBeM4eGgFyX6W/Fsp?=
 =?us-ascii?Q?zBw3EuI7gRLi1zFleffIA/x1GHq2k6AdH82QLrFYHY/OMK0xr1fKwqgpClCe?=
 =?us-ascii?Q?NMqoJXgiX5KdMCEyK3+z8rPIJb+UMisv3LkjnaafUF6z+Nb/XEz1xk5aZfqz?=
 =?us-ascii?Q?uHvCH0sOgVZxIH71SHVz58AvydnFctyCefFVUPvAmuzbXfSjmDCjLDeiU8wr?=
 =?us-ascii?Q?ivEL0udwuCySQ7WAoWqq+6JEmBiEF0IA3CQSpOUnlmxDcES/P9I80A5/6fj6?=
 =?us-ascii?Q?tkqpeH+tP0Rxh/8hTLJNtYOVPivXDFtpR+CkrZ+x9czpNF43w7xyPZfEmZbt?=
 =?us-ascii?Q?AUQZnmlewZSS7pJJCIX43r/IebaLctRxD6VolUqVCaHHh5rwowAfym07eMWe?=
 =?us-ascii?Q?RajxFh+pivlPf3rpEg7SrnGrg6KB0T56kJxqjMCB3/rjgk4/PZlwJ8YpZY5G?=
 =?us-ascii?Q?+SHjuqf+LbmlG0WK3QXPXPE/swQRn3qr+Up6i/HN+fnjMVxsfqyH0nfSMAV8?=
 =?us-ascii?Q?TgZ0N4RowGzUUBjYfsQq0XW0vBaLPgFDOnX0UdCYahhwKYYm4S6cReImv/ip?=
 =?us-ascii?Q?d5b6jcCn5R3wRyKCJn7oVljARu2dMB3wJ+NZWWtQbn1YDIPwry/A/r3Y4Dsm?=
 =?us-ascii?Q?CuHV4wTPq0Tk8fpLPc2zyW71V7VjgDaUWHjzcZVVqTIokaS6rTiDXYWiaZ/c?=
 =?us-ascii?Q?sVZYLyevjIOCjBVFmFFkS8rq5hlEguWeFbiNl6PaS6U43oJx/w3UQZxRLLHY?=
 =?us-ascii?Q?pFqnGhFajG+zRf01obEvGUF99p2nbQ5hA3T1cOkBszmSx2PsP65O78uuXc+X?=
 =?us-ascii?Q?5qIM+4z2nndtzov5GFo4I8k2VfPQGwTPTrfsmE0zLitVfqp2IQERGc/YpjWp?=
 =?us-ascii?Q?sK2SY8cr5zzE1lamWlzjHJizmIr/fdtyaxVRGcuCbFDb7zGtl/x9bIa86+oH?=
 =?us-ascii?Q?00PBM6Vta+I+0m3gCdLzhc9hZ+Rb3JDPIK8Ip/RuF6aOtERoaW1yAsBlr4yh?=
 =?us-ascii?Q?TMZ1emLqMZaK3V/70V4zMllNj5l0KsBPaUBUdLXwLASUmatjVAzQ1kIwkBWT?=
 =?us-ascii?Q?o9/iV16D6w5iePjdn9lgv5t///cmx7u2OOtV0TJ3ybZykUkj8f0qLTf7glhc?=
 =?us-ascii?Q?lvLMBYDi4h+1jfn0ney118mPt0WvSEAx/A/Q3E7kmq2++MPtpC0aGw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 13:05:33.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d6a8fd-eafa-4ae6-f2d0-08dde0b369da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6336
Received-SPF: permerror client-ip=2a01:111:f403:2412::61f;
 envelope-from=Luc.Michel@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
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


