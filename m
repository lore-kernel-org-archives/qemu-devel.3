Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D07C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 06:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhj0K-0000nd-BE; Fri, 01 Aug 2025 02:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiyP-0007V5-2i
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:10:33 -0400
Received: from mail-co1nam11on2047.outbound.protection.outlook.com
 ([40.107.220.47] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uhiyN-0005gp-69
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 02:10:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LfVQaJjOEB4ciizwoKLgItbRIkQxvS4WvRYp7lHJUNiVVYesVy6Ln7YyOJ4KV+4y+b3WGW3hFIMB8L4kojTxpouQ/WOZ82TiQvY/kK9QnCW0v2zFfX3PSNkhmlNv0GOnjDYyVXcJO3Ky1mA2SjXWhwwgrly0vGYEP3301RKfY1GxWhp4iHWL9qZQrwTrPs1V/5Z0mytvaEABkf4FD1GnMXb/pKVGSM7BohnIcXg8WJdp0waBnSw8CqZ8Xm7rqoLYUoiK7cFczLdJmXCA21R4Ol5sNCeEFcdqGjGl+V0itPWbnHxEz5naBhOdn9tF9yw6LeeL5gEo177T519AWi2mfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfuAe1I55mMvKw1p7u09JXtxwTeC49uZovBiihpDlGQ=;
 b=R/IVN4GyXrOjyfOZBaDDb3+qlJX5YybohnzbeFV48khpkdnOZeGI+quf0v4A7E6BhHqp0Pp9RcOVCFCpcpXKaRQ5IgDLSMhjMEt9q1hJlXXh9SSz4l1GL7Ay31VGqFkhUYvtJXO85W8FuEVYLT0/RKUWmUv3unjnf0mkfw+Jq7g7dNcxuVx+Fq75SF8qbJQn1Q+71mPpwZjjcWJ5+daF51E8pzdEvZl128O2wKVErJN0emZU9z4R7z8GgYnh2f7OU1gZUzJEEtR1G1ewjcxumliAfljjy+zilIb6Gfslu8bKn7r9YePfZaxAUL88uh8ssHlUFj0fWCi1rKMCEyxG7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfuAe1I55mMvKw1p7u09JXtxwTeC49uZovBiihpDlGQ=;
 b=mbfx6AyNt3rBvaonKdMJmY/o5kfhmhxGwxtRe+x8I5Ot56XQmj8wDNrGJHyYFJj1WGnFh+uL7qktx2yPsfxFCLpivaDftKTc54c7+vTMdqU8zsOtqrq7Eg4Op4U0GFM95LWwDz8ekpdJJM1vD2Z30Qp+hHVzDpRAPzXhKD9HcAg=
Received: from BN9P222CA0020.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::25)
 by SA1PR12MB6677.namprd12.prod.outlook.com (2603:10b6:806:250::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.14; Fri, 1 Aug
 2025 06:05:23 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:408:10c:cafe::de) by BN9P222CA0020.outlook.office365.com
 (2603:10b6:408:10c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.14 via Frontend Transport; Fri,
 1 Aug 2025 06:05:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 06:05:23 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Aug
 2025 01:05:20 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <eduardo@habkost.net>, <richard.henderson@linaro.org>,
 <alejandro.j.jimenez@oracle.com>, <vasant.hegde@amd.com>,
 <philmd@linaro.org>, <Suravee.Suthikulpanit@amd.com>, Sairaj Kodilkar
 <sarunkod@amd.com>
Subject: [PATCH v3 0/6] hw/i386/amd_iommu: Cleanups and fixes
Date: Fri, 1 Aug 2025 11:35:01 +0530
Message-ID: <20250801060507.3382-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA1PR12MB6677:EE_
X-MS-Office365-Filtering-Correlation-Id: 568cbef7-3a21-4863-e6ca-08ddd0c16745
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXBsdi9zU1JpUmZ6SFNvWlZzbVdJcW9jM2pxTVFxcUQyM1ZGZ2N1bGFTbDJl?=
 =?utf-8?B?RWg4aEZSUStTdnpFQXZ3RlVlK2pldjYxUURtOUpiczE4S2l5aFJqM0pUdnUw?=
 =?utf-8?B?OTFxbG54UVJFZEpiWkVRdkg4QVN5WXRYRDRrN2ttN1NRV3Q5eGwyVEZ4OXEr?=
 =?utf-8?B?d0M3S0RyZG1XeHBVeWljcHZXZ3I1Sm9ONm9WNGN2TXdyYll1R0UzcHhIYzBJ?=
 =?utf-8?B?MWFBL0wzV3E3R2RBVVQ2eDNjamxiVllIWEt2YVloNzh2MFMwdkF4VHdTMEtP?=
 =?utf-8?B?eFJOWlE1T2c0andYK1ZqME5pVnFFak5DVC9IdWhGU1lDQkZXSUpVRDhJREdZ?=
 =?utf-8?B?akdRUFY5WEhFY2pYaHl6WWYxRjhOdzBmeG1EaWFhWXNIeUhDSXFDektjRmFn?=
 =?utf-8?B?UENaaitnOVdsOWN5WThDZlFBNm91R29XK0VsbjQ2VXd2dDR0bm1IZkhFWEMr?=
 =?utf-8?B?ZG9GSHhsNDVNeG8zeElWUUtqUVp4NDZYL1NYc3VCYVhrNWVRQ01VOGlQL1FN?=
 =?utf-8?B?R1RrRFBwSk1EWW9rajVMTW9uWFVCT1IwMkp3UnVCcHFSV2RBSjBZZ1FKVkRy?=
 =?utf-8?B?TW5NMUR6NDFzMTRPaGpmNFAwdWMxamNUdEZ2bmhERWx5aVVFU3g4VVFzTmNj?=
 =?utf-8?B?MGxKYVpmOHVxNEhMUlE2MEdySkFmTmJEcFNKelpwNXRudVhnU0Nqc1lqMWVl?=
 =?utf-8?B?Vjl3TFZ5ZGFockkvY0NnMVhDMDJzZ0NtZzFIZ0ZSQ3E5TWFQS3RycVZ2Y08v?=
 =?utf-8?B?TVBDckJ6WWI2a1VhbUJ0T29WVExwSUdlMHpPYmJwbzQrZXVVemcyTGdYNEFO?=
 =?utf-8?B?NzlHc2lMY3VjKzJYSi9hL0FDZUwzQkc5RDY4OTA1NVRZVm5sR3hhUFVhNCtV?=
 =?utf-8?B?N3laKzF5NU9FQzYveEROY0hVN0xIamF3cysrR3o0WnJVYmhTemRoanEzdWZE?=
 =?utf-8?B?bHlRdHZ6elR4QkhSeko0dnZ2RktCQ3AycVpFM3FWeUh6ZDBwTnFRZU1YTzVt?=
 =?utf-8?B?TjAwNktPTTBmencwOHpiL2hlUlRybVl0aEFjeklURFBxczRSa3Z0ZzlmMndJ?=
 =?utf-8?B?Vk40c3ZjZDBaTGNNOHpoR0ppbTV2Q1lFVHJiUjlCMEZFU0dNSTA5djNrYzM5?=
 =?utf-8?B?bStjVXlpWVhXMnVMbUdSK3Z4dnlDTDVMMjBhOUd0MlZTNTdSajJ6VGRYZms2?=
 =?utf-8?B?NS85RWNZTm1ZczB4N3IvWlRvdDdTbmRYYTBlUk1zK3NxdWlNdjdjY3NNVmly?=
 =?utf-8?B?WE5rdUNtQ0swRVlsNjZhNW9lU2FWcHZ0RERXVWpKWHpUQkFsOW9jM0NaNWdQ?=
 =?utf-8?B?Rks0Q2JGNGpOVmpzcERheW93b2t0YnBON25ERnl2RGVyZE9uQXF2NXVITTM3?=
 =?utf-8?B?R2pvRmI3bFR2UnFQdkxsaTcwNGQwK3dNNXBFeUE2bm5HUDV6bEgvcDZ5a0t4?=
 =?utf-8?B?clQxeGJnSnQwOUV5Q3VnVUx4cVoyblQyS3hRV1VEMmczK1FodldRZERRd0Vp?=
 =?utf-8?B?dmhMa1BKa2N1Mzlxd210OVY0ZnM0Qm1PS2huVTEyNHVuSEN6TEJzV0J1TzFN?=
 =?utf-8?B?WGZnQkUvaVRTR3FDME5JYnliTDlFcWM1RVBkckVoVXBCR211dE5sK0h2TWMx?=
 =?utf-8?B?N1pMdjgzMmlWTUc1Ym5hWmwwT2JpMi9TNlNqbFY1cjFHOEYyUFFtdmxwNGtR?=
 =?utf-8?B?aThFdjkzMHlhN0pPT3kvOWdJblFqQWhkOWNDZER1UkU4V1gvM0ppazljV0wy?=
 =?utf-8?B?RXpXajg1bG5pZEZWd1Jya3RLdXdCS2R6b1VlUE5tR0w5OFB5d2lRcXRiMzZh?=
 =?utf-8?B?L0tWcUpwbEdWeHpKWThDaWZkQ0xnejFZZ1dVejdDNXVqckZlN3V5aWtocjhD?=
 =?utf-8?B?M3lpVFlpdlplWHRSdlpaNDFOMUtkby9CZXQrZE1BcEhtSXFsL3JtS2FLbzFw?=
 =?utf-8?B?QnhKMk05aEVINUtrUFJHMmRaSXVIM1Z0R0ZpT0U0QWlnMWxmZDE2dEkvcTZy?=
 =?utf-8?B?RHRMOXlBY1ZKZ3g2M2NpVUJuZ3hGSUd0VkErNFFDMnJXcHR6TlovSDZ3OU5l?=
 =?utf-8?B?d3FKNEdvRnhpNVI0R09TN3V1NjZjZDFPQkNpdz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 06:05:23.5960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 568cbef7-3a21-4863-e6ca-08ddd0c16745
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6677
Received-SPF: permerror client-ip=40.107.220.47;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This series provides few cleanups and fixes for the amd iommu

Changes since v2:
- Used VMSTATE_UNUSED() to maintain migration compatibility when ats_enabled
  flag is removed [Phil].
- Simplified the amdvi_writew [Phil].
v2: https://lore.kernel.org/qemu-devel/2e8f2b72-8fb5-474f-9844-61f306efeb2b@amd.com/

Changes since v1:
- Dropped top two patches which depend on the Alejandro's changes and rebased
  remaining patches on top of v10.1.0-rc0 [Phil].
- Added a patch to fix amdvi_write*() [Ethon].
- Reset event log head and tail when guest writes to event log base register
  [Ethon].
- Considered "evtlog_intr" flag while generating event log interrupt [Ethon].
- Fixed comment [Ethon].
v1: https://lore.kernel.org/qemu-devel/20250716073145.915-1-sarunkod@amd.com/

Base commit: 9e601684dc24a521bb1d23215a63e5c6e79ea0bb (v10.1.0-rc0)

Sairaj Kodilkar (6):
  hw/i386/amd_iommu: Fix MMIO register write tracing
  hw/i386/amd_iommu: Remove unused and wrongly set ats_enabled field
  hw/i386/amd_iommu: Move IOAPIC memory region initialization to the end
  hw/i386/amd_iommu: Fix amdvi_write*()
  hw/i386/amd_iommu: Support MMIO writes to the status register
  hw/i386/amd_iommu: Fix event log generation

 hw/i386/amd_iommu.c | 102 ++++++++++++++++++++++++++++++++++----------
 hw/i386/amd_iommu.h |   2 +-
 2 files changed, 80 insertions(+), 24 deletions(-)

-- 
2.34.1


