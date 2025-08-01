Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BC1C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:06:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhiuC-0002xc-Iq; Fri, 01 Aug 2025 02:06:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhits-0002rD-9I
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:05:57 -0400
Received: from mail-mw2nam12on20611.outbound.protection.outlook.com
 ([2a01:111:f403:200a::611]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhitn-0004vA-JX
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:05:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DipGuitcfFcI8gfebmpp8ct+JA61xTF5u+OymJu5gi5NueSCoR86Du3gereAhaU5RCh1cuNHXEn843LE8LiNLpKMTPDWiabTD/n6HD0+3t5CmdWN7+zC3t3HJUT3CJSEMSvu5x1OYXRjg1zbVcGd5ZsOkDmAAADa9cHar4tWNVGbccuUyjMVSma+Zo2TZZPTMC4cXLK9ua51kBwp9dv1x1I9T5ag6MjgYAb8mXS3rhpzNv1C8rrYixn0btfqHouigEZ3Tw3/PmcE/QUD1miwsnY8RGUkPqyi3evgq4eUdiaiHleKHizyQ6SbkbU0vPAZYdVCnx6t9+Y7yRnhUOv7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gwZZeimT0/CqOGxgg+ZzqGzm85H16sSm/32yevOcgqo=;
 b=HKCvImySPm3NKzteESVgC/QtGgsz/rGdoeXAfbl3DxeXZOIfsVKDA1gc65nKOzRdHx1q46ytrlAJ2Ds+MuCDJEGO12Lruix3fEz6auNu3hhpsAWRo22W6WX3KU6HpJgmrahortOkHtI03bKhnduZq8VASKR+eKvr0ZvtNvGtNcYRXdxb0jGWlVgx2Xte52WAT39z3WYZs+TYsEEaSYITOQ5h9jsjLWy55pGF+kaJjf78ukwceF+guCwlIKzrbdZxWI/uTpdtfJGvk2z0ST4XAMjONI9EvoPkVFf0tTKceGbl2fbkYXCjn+hUegLwKG2g8DafEqX/OikNnxFHPgmwAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gwZZeimT0/CqOGxgg+ZzqGzm85H16sSm/32yevOcgqo=;
 b=U1zMpF9QphPjXQ8rpLldkpCnnPPhWHF+QyttWyoDdrqQ0tvoeJ96z2NAta8z9hxeh4Du5OcSt5hKOPMRIA6+NirybX6746pjnCPg9t27HFd9LCnR3UegEbLNGzv0EOBkSpaJOl/JdHfqlAFk+vULKXZpciTMFsaI9ct3kWvdre4=
Received: from MW4P223CA0019.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::24)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com (2603:10b6:61f:fc00::610) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.16; Fri, 1 Aug
 2025 06:05:41 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::6c) by MW4P223CA0019.outlook.office365.com
 (2603:10b6:303:80::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:05:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:05:40 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:05:36 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v3 1/6] hw/i386/amd_iommu: Fix MMIO register write tracing
Date: Fri, 1 Aug 2025 11:35:02 +0530
Message-ID: <20250801060507.3382-2-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250801060507.3382-1-sarunkod@amd.com>
References: <20250801060507.3382-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c13e24d-8d8f-477b-cb99-08ddd0c17175
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDFKM1FyMUVLc2V4RXU5QXMvR0gxQU1NTVdlSEZHNUMwM082NDRqRWZIc2dJ?=
 =?utf-8?B?T1orOE9GNUlHZk0rVCtMcUZ2d2hrbWV4YnZVRlhERkgwQUFPb3lXUEtsYmNJ?=
 =?utf-8?B?MlRhTy9QU2RKSGJiOWJQZTREeTJYb2IxQ05FN1NJZE5ZdFYxY2RSSjJXbGxN?=
 =?utf-8?B?dnA1MHNBa3MzOGZsNnd1Y1YxMU5TWXZqOXByVDBwbURPWExoQTJScUdQelBN?=
 =?utf-8?B?RXlNRnlJRHo4NDRXMVo3ZUd0cm1VbW5kOTB5ZjBNUkZvTzd6ZHdnVTNnUjMv?=
 =?utf-8?B?c3Q1UHBONEJMVnZ2NjUyY3hEOUZVTGptbGFyZHJrUjRvQ1lJdFRaOHh2ZWhP?=
 =?utf-8?B?V2kvbXppbUE3REFOTVBXdk4yak5uN3k1ZGNPN0x5enhHU21hK3Zhdm1jclRG?=
 =?utf-8?B?UStFTDI1Ui9xdGZxRmFmOW9sSEZrNVdwRko1YTZnay8xMGF6Y1loWTdxcFQ5?=
 =?utf-8?B?ZzdtcW1zUHFiSll1Q20rWDJjbHRXN2RRa2RjcjVUOTA2YldKdnhyYk5GN1lL?=
 =?utf-8?B?L1d5UXM1ZlJKRml0cmlaamdJQVpram1WUHFHZWtMNjUxS3JTN2lXZHo0UXl1?=
 =?utf-8?B?UWtadDdzVzVKZFFxbTM2eXNUU0JRMUcyMFlVQlJvV0RoMGtHenRVMC9JSFA0?=
 =?utf-8?B?QW1NeE80ZEVqYUlST05qM0dEQ0REdHk1b2NNRlBJbzZRakNpcWZZWU0rWFUz?=
 =?utf-8?B?K1c5eVV1aHlYMk9EMGFvUndTa2w3SkR5WGNKdXNoU1grN0ozVVArUE5CQkRU?=
 =?utf-8?B?aG5kUVpzL1E2dmI0VmdDRU1xZHFSMk5nMFZNZ3EwYkRaOW5PSU1sdWd1aTJ1?=
 =?utf-8?B?ZmM5UjlvbUw5NW5LYVNlN09pencvWGtpcFFXQkFBeUZXZU5hc3grZSs2bzI3?=
 =?utf-8?B?Mm42U0hpcHlkVXZvTnBmM2dmTzd1VWJkcEFHNExjclQ3dzRTbThJalJJSmtE?=
 =?utf-8?B?LzFvcFVlTVVHa2s0VWJWUzJ1eFYrR3BtS2VNNm53RU5RWitWSll6TzFnTyto?=
 =?utf-8?B?eWFnTDcrOTkvSlo4TngwWTE2ZDlBcDV2NjEvMEt0S1YyUWJaRytoYWErazk5?=
 =?utf-8?B?N1gwV0ZtVEdLY1RmdEx3dk12MjM5NmgxNWI2OXlYdUFTMmRtbUx2VnYyVHBT?=
 =?utf-8?B?aHZiTEhVYkJId0Irazh2VmU5cUQxQlc4MENvQW5xdndqOXh6QllreUM3a0xB?=
 =?utf-8?B?WUNQOE9JbFowLzh5UE53VE5Db1RDUG9xb2U4Q200cGRrNStmV2U0WFoycjEr?=
 =?utf-8?B?cHMvKytiaFBnT0xzSkprVUpTOUZKSElobE0xNGRCTDBLSCtMYTY5Qkk4QVRI?=
 =?utf-8?B?L2dtMG9teXF4VURLNDFYb3RGYXR6Y2F4d2s4bEtCdkQ1alRPUk9kQTZIb1I4?=
 =?utf-8?B?alhQbkJOZmMxQXJhZjNjUW4yVExudllzRjFObkZQVTdlUGhYTkVjNGowRGh1?=
 =?utf-8?B?Ty9mcnpoSkhlVnpCa0NHblV6YnloK293RG9YWWt3S2NWN0pwdSt2N0Z0UHVP?=
 =?utf-8?B?SUU2UnB6aFl1MDRxNXo4RmdDaDI2RHZEc2lvQnNzUHpCUUt1Skl1MklXM2Rw?=
 =?utf-8?B?ZmVRbTVwRkdrSldTa291UGZMV3hHdEpicDk0TzNVa1hEMXZaNWU5L3NuQ1di?=
 =?utf-8?B?dlBubkxybDhVTXcvOTJLTVhPVnNMNWoxbi9QdG9pZFUveU85L0h6R3JHWHBn?=
 =?utf-8?B?V0d2U2M0YkJLMSt1VldFZFAzWUJadG9FTzJhK1NNT3VzOXorUGpKajRINzZz?=
 =?utf-8?B?N3VWSXQ2RTNjVlZ2SmNId1ZOam50T20vZjVkRHF1dlpWSVV1WE5pUzNkcmIw?=
 =?utf-8?B?bzh2Tjk5ZDdqQlpaSTJLVTVxamhpWHZsOWF2MDJCWkVsdDdoRlJhY0QvQkFE?=
 =?utf-8?B?ZVU3Rmx1dlM1RGNta1BFaXlhbllFY29aSi90UmQ1VFBNVGtTWFJhbE41am5S?=
 =?utf-8?B?OFhvL2xoTHByVis4eEMyY2MyQ0QzOXl2UEVSdThGMFNjNTNaMVhsZUNxajND?=
 =?utf-8?B?eWd5MGdKMVRlQVp3eTM1Zm40Um4rZWc0UkdTYzBpcCtBV3I3RlRmYjh0bkFH?=
 =?utf-8?Q?cpk2A8?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:05:40.5936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c13e24d-8d8f-477b-cb99-08ddd0c17175
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
Received-SPF: permerror client-ip=2a01:111:f403:200a::611;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
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


