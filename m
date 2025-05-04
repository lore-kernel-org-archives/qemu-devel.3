Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C95C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 17:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBcqO-0008Vo-Db; Sun, 04 May 2025 13:09:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1uBcqM-0008Ve-2j
 for qemu-devel@nongnu.org; Sun, 04 May 2025 13:09:35 -0400
Received: from mail-mw2nam12on2045.outbound.protection.outlook.com
 ([40.107.244.45] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Suravee.Suthikulpanit@amd.com>)
 id 1uBcqJ-0006Od-KA
 for qemu-devel@nongnu.org; Sun, 04 May 2025 13:09:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EO7vD7Yv5kpt3jQ4Ew7mSsDlDvwN5NMuWD5JB6IamF3/9qhYwQuzClRwH5y9AqhmewNqK81qMnnyaORkJrHdhX/BhKIuVph0MfCQ1zz1xkcLfRkbauIli9WVjuj2e9cdPxCOOjn+pEbp8Yltdgu5vJSWPF2JGREk8GjLAF+pv0AtlXd0xasLscKkYyXRmMbSA0NrKl5kXTdt8s72Tx4QaMSvCsmxCpZ+9fAoMHDu8kH0VMpF3WOlqPled309STFTcvU1OP3Aqmnq3jkhKXvOEM+3UKu4yueWGlV7ztYDAx3WRpUmmO2Q03C6q67v4G2SGIe3ivmIzqmqFvsAPL68XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MO+7Vu+LIbxZ7GOJOSfccovF36CEANoLEVf+cj7eJjo=;
 b=SDFRN/iZVClxnslTDGcUpFPhONPBJ+/Hj5yrArycONbCt8HDHkiAe/GBq4/zPioW0xnK79wTDFrlll/izWX/WHShFCRxpHP8h1E7y6pfxS5xxsfGTC3Z3CYavqDx37jhVYCZKfXsiXXjcgzHWQzs7SNzV0VR5exYAxUrYTTAO66zgoCrRAbud5YVkqNK/wM3/L3Q5EA7NZvpqokd2A4d1jiu07BOW8CfXgVRXPBuZ1HdUhnQOTqCgenWVjx2RRqexNvVSCiBDR2yGPxk4WLQV1I8A2dKdqqPpk1PcvDyWsr5LVZjyuG/gvv+3ISuiDW/hJR0HOFu86aJqV4U9sRnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MO+7Vu+LIbxZ7GOJOSfccovF36CEANoLEVf+cj7eJjo=;
 b=Jo6Gz4R7R4ZfaQgRmdLVSlShuSdpz13huF28YK+gKT03R2ths+QPHcv8QihtFq2EAD8BI+NHIneLPjfJtfPhNv9rDhGtEcJBY94TGcEwIatPrmrmn9zb15rRIqWmywyi8Fm3HtF2zHowYT+BdjV/Fq3pC9DjNVd/6tionVr6SAA=
Received: from CH0P221CA0048.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::29)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Sun, 4 May
 2025 17:04:24 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::c4) by CH0P221CA0048.outlook.office365.com
 (2603:10b6:610:11d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Sun,
 4 May 2025 17:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Sun, 4 May 2025 17:04:24 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 4 May
 2025 12:04:20 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <mtosatti@redhat.com>, <mst@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
 <vasant.hegde@amd.com>, <Wei.Huang2@amd.com>, <bsd@redhat.com>,
 <berrange@redhat.com>, <joao.m.martins@oracle.com>,
 <alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 0/2] hw/i386/amd_iommu: Add migration support
Date: Sun, 4 May 2025 17:04:03 +0000
Message-ID: <20250504170405.12623-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 29142d11-7dcd-4dad-ec0c-08dd8b2db899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZldRSWluYzYrRURydlpmcWVWVExUbjZnR0FlTmtuam1lbDBpQmFqbVNBeTcr?=
 =?utf-8?B?UjFIUmwxSDdzR09MdWs3NnBSR2dWWjZFWHM5ZHNBcGxFMWRtSmowZ1VVS2Vn?=
 =?utf-8?B?Z0c3SVF6Vm1hUjhkaVJTcWxueXl2Z2djUEg4VHptL1VndEE1QktHQ1c3eEdK?=
 =?utf-8?B?TUxHREluNW1kUU1xYlNiVngwREJEaWUrNllFZnRUcnU5VU42K0JRbVlFeko5?=
 =?utf-8?B?UUVISGVWQTNFbEFuUjhzZkRXTEpkdlN4NzlYM1g4V0xwTHVjMFZ2Uk91RzJp?=
 =?utf-8?B?VkRqUC9jUm1IZVpWMDVsdUVVd3VYMTNYV2xIMWZmWEIrWGQzbGhrajQ4aTkr?=
 =?utf-8?B?ZXEwU2dmakh0RkpuTjZRUHVVbW9jOE5oZktoaGNUUzlJSGljcVp4MDUyR0VL?=
 =?utf-8?B?b1NTSXBOZVl0U1IvVHFYM2NYQWZnUnhpc1NySG9UTnA2UjBCS2N5TDArd3V3?=
 =?utf-8?B?VXY2YzZ0M3g1MitkS1NRM04rQ013ZGpIcndRN1kvd3pnOFVVSkVEZExrMGtY?=
 =?utf-8?B?Mzg3ajRtcFF1dWhHMVRZcW0vN0lVWXB3Q3ltYjJIRWFWbFdRWVpqNFd1d016?=
 =?utf-8?B?MFBhdDBoQlZLcnozb1pqbnk5L0FsWDI3bTVRVDhrVkNsQi8rQXE2L2ZQdVRW?=
 =?utf-8?B?MUlpQVBnTHBBZlY3YjhMeVlVZFV0cE9USjh6dUxvNmdrRTRBWldXVVlOTklw?=
 =?utf-8?B?aTlSWkxuQzhaWmlUa3dOL0ppM056OTYzdnBad1ByTVVOMkFVSU12UlFTNllE?=
 =?utf-8?B?MWVxMXE2NmNKQzVBQncrTExIZmczenFiZUpmOFp6MnR0ZHhhK1B0Vk4xODlk?=
 =?utf-8?B?cWpBZDl6dFNJN3BNU3p1R0MrSmx6Tmg5U1pFMWlVYytQbEJOVUNzRjNVUllr?=
 =?utf-8?B?eElnUWtZMEx0ZFhMUFoyWDJ5M1I5aDBpNWVXNnVDcWtlQkM4NEdwWmVKZVIx?=
 =?utf-8?B?Y3F4ZjhiaXo2MmJlRU9nZ0Rvejh4bTdGQklqVWNId3FzRUdTQ0dKVDNQdGRV?=
 =?utf-8?B?amw3QlNlVmRyVXFNclRnS0FhVnpEY2VhK2JFa252WkZIdTJraVFqZy9Kem1h?=
 =?utf-8?B?eFl3MGxpZEdyZS85cVYwbjc5dGhpaDNPTFVDdmdGVXlxV0RZL1NqSm8rVlJj?=
 =?utf-8?B?Q1VIU1R6aERUWWxQYks0ZkN0eW4yNlBGNGJIKzV3bjNBS1FCL1VCTVh3M0kx?=
 =?utf-8?B?QXNaYWNteG50V0ZxSEdaQ3dySWkyUDRkYkJ0L2hJcEdwSEFJOEFrNXhZSXhC?=
 =?utf-8?B?NHlqNnhXWEhDZUs1NWFwbCthc2tSM05YOGp5V3U1c0RNeDFnWUIxOFJTNUp1?=
 =?utf-8?B?N3JjRE5oaTUwZzJQNkk1VTRVWk1NTXJDUGR5YTFNLzlYL3Y3T1dMOVNMRGZD?=
 =?utf-8?B?WnNUUzUyNVZjNExVZ2RXQWVDL2x3WU03VkVZMDU5U3BOcldFQnI5cGNEUE1n?=
 =?utf-8?B?SzIybzdwVitwdTVESFg5L1RkWnhzT1lZU2FPeW1jV25rYWIxcG5iWEM0YVcw?=
 =?utf-8?B?UXpLSVdsbnVoTGZ6STQzRUdPVjE4Z1VSNnM4YUpGUlZrenRMdGt2dnFCU3pX?=
 =?utf-8?B?ZWRCS2ZrQ0hpK0poaENHY0Q2SWJKQk8wWHFJL1Y5QjJTd1RLT29KbVlzZzVG?=
 =?utf-8?B?RE5NR1R3eStWTzA2eTFUQ1hrVytUa0I4VTYyNGo2WnlCNFNDbHdjeUdYejlL?=
 =?utf-8?B?R0t4Z0tBZUwzcmpJS09zMTd3ZFpXaTRTOTBiK2t0VVFWbkpEcmdKc3ZlT2k3?=
 =?utf-8?B?bGphc0YwWmUwM3QxRXhtdUEvcnJqQW1SR3BJUmtiTW9BTDNyZWNIN1dmU2VF?=
 =?utf-8?B?TEtDeTJnY2Z0aXVPTGx6enRrQytiZm9uWlJlOVVPRTNyZ3YreGRjTkNwb2Rj?=
 =?utf-8?B?QXZuU21aTmZERlRKZTQ3ZDdWdThSMzd6NDhLRlBON1I2d05YSkVkVVhacyts?=
 =?utf-8?B?U3ZyL1dFbEtGNzdlQzB0YjBCUEZNSE1Nc085TmxkREs1ZndXNjd3QVBuMnY2?=
 =?utf-8?B?SVp4TXpMb0lYNDlKRXcwVE96ZEJER3RUY2F3UlVBQ2xHdVVtSGlxZ1JmZnRy?=
 =?utf-8?B?QjR5WldJbGpkNUo5QTlUWlY2Y0hoYzJhUmJrUT09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2025 17:04:24.2700 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29142d11-7dcd-4dad-ec0c-08dd8b2db899
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
Received-SPF: permerror client-ip=40.107.244.45;
 envelope-from=Suravee.Suthikulpanit@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Currently, amd-iommu device does not support migration. This series addresses
an issue due hidden AMDVI-PCI device enumeration. Then introduces migratable
VMStateDescription, which saves necessary parameters for the device.

Changes from v4:
(https://lore.kernel.org/all/20250304141716.638880-1-suravee.suthikulpanit@amd.com/)
  * Patch 1: Fix commit message per Daniel and add review-by tag.

Changes from v3:
(https://lore.kernel.org/all/20250212054450.578449-1-suravee.suthikulpanit@amd.com)
  * Patch 1: Fix build error
  * Patch 2: Fix 32-bit build issue.

Changes from v2:
(https://lore.kernel.org/all/20250206051856.323651-1-suravee.suthikulpanit@amd.com)
  * Add patch 1/2

Suravee Suthikulpanit (2):
  hw/i386/amd_iommu: Isolate AMDVI-PCI from amd-iommu device to allow
    full control over the PCI device creation
  hw/i386/amd_iommu: Allow migration when explicitly create the
    AMDVI-PCI device

 hw/i386/acpi-build.c |   8 ++--
 hw/i386/amd_iommu.c  | 101 ++++++++++++++++++++++++++++++++++---------
 hw/i386/amd_iommu.h  |   5 ++-
 3 files changed, 87 insertions(+), 27 deletions(-)

-- 
2.34.1


