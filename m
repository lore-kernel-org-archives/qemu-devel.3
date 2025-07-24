Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA69FC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 06:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uepkp-00074m-9s; Thu, 24 Jul 2025 02:48:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepkm-00072P-Eo
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:48:32 -0400
Received: from mail-mw2nam12on2062a.outbound.protection.outlook.com
 ([2a01:111:f403:200a::62a]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uepkg-0002vu-69
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 02:48:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IihVwLjv1F4/IELC70GvYQ3yaNhuLzJNt7+2ptrFREl+jgotjCfMT8XAuNWXlkScVLPI03SHT6K/lPksS5pXSJkoBG9w2kSWr3PB1Dvbmdvpa4UNl902KjCr5hFJdPHStkREpmMEWwp+yyyp/vDZTbl4cQgkxDslPu7Ct9Fz4AHwOWNgvYGusJ8Kidixgji/Iuw6P/NiZYJeCU2PVPnm7bxhCEO3Z9LfLhi9HXeGBQKu/FmviAplnyxyJqN8VLBV9nWmA/aZYR/zT1KKIkugFF+1PfmWOWJE1fJemLcXr0U7zB47rCPvCj7GsrFcPpXFzAIYawwF9SGxwp07X27fMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwZZeimT0/CqOGxgg+ZzqGzm85H16sSm/32yevOcgqo=;
 b=YdYdCroWII+1E7du+OFnqaNMY3Sky1vTQTz3KEvyRCADCqyptvP3QOsevklpmjYR90PpGVmXOwvcvshQop4kRy6OYI4gTbLXjWr4MMr/8ymd5Bdwl4CaHXMPxA6XqAoqevCd15h/kcVcdPSqTuzJNgeEFHP7c5ZRQD1n5nnSbRHX6bOWoD1s0zp/uMyfVxdaBWR+hOahtOh6tYFbmWoiU0gOTvD6PaR9dY2fCj9XbOdPsDjIqfG8ekqO8q2fIJefGgQTc+6JAxjTD5mXvFESx6VZoZ5N/09h2yL4Oldm96zLRdQRf2pHOXn2xwTr+lFt2MfLM6LJrxGgav/7DUMNPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwZZeimT0/CqOGxgg+ZzqGzm85H16sSm/32yevOcgqo=;
 b=r6F9rfJZ8E9l48rz1zq/ghhvf517xX/5hsv5MK2+KhUImVx2H0Iuw51r/C0ZMPJ3JAnAYOy2Fr8YRgPEc4DwCO/kzJRlhFXuaSCG20amzCZYC/SSm3PrS1sHpTddNH1pCWbLpmz/BtcD4QIqCOrDDgn3Ifjbf/2x/YEjYSH6voE=
Received: from MW4PR03CA0145.namprd03.prod.outlook.com (2603:10b6:303:8c::30)
 by CH3PR12MB9395.namprd12.prod.outlook.com (2603:10b6:610:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Thu, 24 Jul
 2025 06:48:18 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::a8) by MW4PR03CA0145.outlook.office365.com
 (2603:10b6:303:8c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Thu,
 24 Jul 2025 06:48:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 06:48:17 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Jul
 2025 01:48:12 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH v2 1/6] hw/i386/amd_iommu: Fix MMIO register write tracing
Date: Thu, 24 Jul 2025 12:17:40 +0530
Message-ID: <20250724064745.4091-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724064745.4091-1-sarunkod@amd.com>
References: <20250724064745.4091-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH3PR12MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f766c53-ae84-4472-88af-08ddca7e1247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L09ya1FHT3UzdmEwOU1lbUQ1LzRYakhjZ0l5cnduQjVOQVlHTGU0YVlyL3U3?=
 =?utf-8?B?Vis1cjVXeThaYUh2bS9NREduUEJpS3NYVXpDNjkwek1LQVhFR2M3L1NDUzFx?=
 =?utf-8?B?TVZzNmNpejNhWnErVldCZVIrbzd0d0N4dndkK25PRm5YdnpZc0tnaUgxbTdn?=
 =?utf-8?B?d3dDUFlJWGczQXE3Z3o3by9wb0VEd2pRSEM5YlNGR1pQcTk5ejNGWGdROStv?=
 =?utf-8?B?aG1GeUVHZTZVQ3UxYW9xKzhjVkJ3Z2poRVc1WVZYSkJ2YlN4bm5GOHl1bDNQ?=
 =?utf-8?B?R3pWOXh3YmFaVlZaZVdNd0hGOFBWYTh1NHlpMzZ2alV5UlM0T1Y3ZlRldDRX?=
 =?utf-8?B?ZWJpSlBNblpXL1JqMHkzRCszT1RHMnNHckpTazdHYlZERzdZQWltN0JoeWQ4?=
 =?utf-8?B?d3hYakVTYVY1SEhUZzF4WlZES0lPajRBdG85emxKWnBISFd5QjNyMm4yVXJT?=
 =?utf-8?B?WTc5UXBuelZLMEpnWnVVbEI5UTd2VGFOY2laUTR0QjRZRVJtRklyTTNQUTJH?=
 =?utf-8?B?bHpzUEppOGszRnhtU1hzaTMyc2J6R0kzL3VaYVlyRmJDa2VyYk1oT0hhN1Vy?=
 =?utf-8?B?ZzBQelZObEZhS0c4cXhnMTU3M0hTamxVS3ZVVzNWOGtTWEx5emloamJkeUZk?=
 =?utf-8?B?Z01naTdsMWc1Q2Uycy83cy9uNnVRbDFTTEtYYXljbXNKUUYvQVA1TzFjcFFw?=
 =?utf-8?B?eitMTVVLMldqZXdvVldWek54SSt2MFdPcUJVYndkSDFLeFpjZGgvYjd0Z0c5?=
 =?utf-8?B?cXlVRTFJcU5wazE1YnI1VS9NdTl6eTk0STdDK3BlVGFGM3dyNTBMSzB5UlVo?=
 =?utf-8?B?ZFRncDRWOURaTGlsbXBSVk1aOEpoYnJKb0pzbFE2WDdVSW8xQnoxSVZTekU1?=
 =?utf-8?B?T0dsN2V0ZGM2aHpvSW5rTXlFYTJXTjkycTA5bkNsVkZiTUxQeFhMdW5INzJU?=
 =?utf-8?B?SDl1aWxpTDd4OERVUGJ0REtWS21YV2hxbkhBQ0VFSkIvY0lBYzE3a0dOV2oy?=
 =?utf-8?B?ekYvNXI5bjM2VDhWVWhWYldmYnFDa3BwdlhQMWtFQldBOGRnZzRrMXdja1ky?=
 =?utf-8?B?UjBvdC9ac0RZSUlRazR4YlJhQ0FTRCtYK29LZlkvTUNTOHZUOUtUU0FCdi8x?=
 =?utf-8?B?RmU5UnhVOUQ5SFpVM1V4Zzc5YlRXRFBGRjVVMGx1ZGNhV1NzTHUvWkJlaTFM?=
 =?utf-8?B?QjhsaGdEUFdCTjlyTHpLazNERlJiYTFaSmVqeWU1N1d6RFRaZ2pOei9rNDVJ?=
 =?utf-8?B?NnFqaFArU3QvZXZiZk85WVZhYnJzYzBCYk55L2h0MjIvOUs0N3pKaFl4RzZG?=
 =?utf-8?B?OWtiWU9QWDY4T3dGZno1SnRMTHZvdkcyUTRrZnl5Y0FaL2pCMGJ0Slo5Vjc3?=
 =?utf-8?B?TUVRdkFDOHU4eXQrdUNiWjcxVnBZNjBlYmdqVkpEdEs1MlZvSVlaczYwWUZN?=
 =?utf-8?B?UG1iRzhiOFRGek1WY3d1cU1lVnFIMTcrM3h4NnYwRUgvY2RQS0xSeTFmakQx?=
 =?utf-8?B?aWdoWmNLeFdCaXlkaTN0ekYyYTZPdnJSWUU0RFFzRzdSS3lzbmZ3MEJIbHhK?=
 =?utf-8?B?SElBR0xYbmF4aU4yOWwxVFp0Vk1xMDlmRVNWU0QyeDRFMHhrVENaZEtOSmtY?=
 =?utf-8?B?WHJYdVkxblhLcTJXc0NNRDhheElSUTE5ZyswK1lNUE11R3ovaTFKRmExdDl4?=
 =?utf-8?B?MDN1WXRqTnM0STc4ZFRMNExJR2phMk1iTW53cmdBTWk3bllYLytPSXVTTFJs?=
 =?utf-8?B?WUlkZXVTRHR3bGlUWVlJenp5UHBaRmRnemZhelRKWDd5cmR1enV5UWVHYjlW?=
 =?utf-8?B?T0U2L1BHNlN3VTRaZEJHNE16V3dMbnBYai9Da0N4WE52TEhpY2ZPdkJBbFFz?=
 =?utf-8?B?NDdKVXZ1R2RqdjgxQzk0UTM4cUlQQUwzZll1djMyN0MweGljQXZ6aG4zcEtZ?=
 =?utf-8?B?WjdrZ1dmK1hyNWFjWU9UYS9MR3oreGZNZmd3WHhVYUMwOVJQcVcwUFR1M2Vy?=
 =?utf-8?B?bjJqV2p4d3Y4bEVjNzJhcFJNL1lKRHhnRGpuVFNNVDFIOFVDT0w5aVVHVHB4?=
 =?utf-8?Q?4eHqDp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 06:48:17.6512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f766c53-ae84-4472-88af-08ddca7e1247
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9395
Received-SPF: permerror client-ip=2a01:111:f403:200a::62a;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.377,
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

Define separate functions to trace MMIO write accesses instead of using
`trace_amdvi_mmio_read()` for both read and write.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/amd_iommu.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 5a24c17548d4..7fb0bb68f008 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -592,18 +592,31 @@ static void amdvi_cmdbuf_run(AMDVIState *s)
     }
 }
 
-static void amdvi_mmio_trace(hwaddr addr, unsigned size)
+static inline uint8_t amdvi_mmio_get_index(hwaddr addr)
 {
     uint8_t index = (addr & ~0x2000) / 8;
 
     if ((addr & 0x2000)) {
         /* high table */
         index = index >= AMDVI_MMIO_REGS_HIGH ? AMDVI_MMIO_REGS_HIGH : index;
-        trace_amdvi_mmio_read(amdvi_mmio_high[index], addr, size, addr & ~0x07);
     } else {
         index = index >= AMDVI_MMIO_REGS_LOW ? AMDVI_MMIO_REGS_LOW : index;
-        trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
     }
+
+    return index;
+}
+
+static void amdvi_mmio_trace_read(hwaddr addr, unsigned size)
+{
+    uint8_t index = amdvi_mmio_get_index(addr);
+    trace_amdvi_mmio_read(amdvi_mmio_low[index], addr, size, addr & ~0x07);
+}
+
+static void amdvi_mmio_trace_write(hwaddr addr, unsigned size, uint64_t val)
+{
+    uint8_t index = amdvi_mmio_get_index(addr);
+    trace_amdvi_mmio_write(amdvi_mmio_low[index], addr, size, val,
+                           addr & ~0x07);
 }
 
 static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -623,7 +636,7 @@ static uint64_t amdvi_mmio_read(void *opaque, hwaddr addr, unsigned size)
     } else if (size == 8) {
         val = amdvi_readq(s, addr);
     }
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace_read(addr, size);
 
     return val;
 }
@@ -770,7 +783,7 @@ static void amdvi_mmio_write(void *opaque, hwaddr addr, uint64_t val,
         return;
     }
 
-    amdvi_mmio_trace(addr, size);
+    amdvi_mmio_trace_write(addr, size, val);
     switch (addr & ~0x07) {
     case AMDVI_MMIO_CONTROL:
         amdvi_mmio_reg_write(s, size, val, addr);
-- 
2.34.1


