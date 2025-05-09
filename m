Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B66EC3ABC3
	for <qemu-devel@archiver.kernel.org>; Fri,  9 May 2025 06:51:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDHZq-0002Ko-Gd; Fri, 09 May 2025 02:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uDHZm-0002HI-Ed
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:51:20 -0400
Received: from mail-sn1nam02on2055.outbound.protection.outlook.com
 ([40.107.96.55] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uDHZi-0000Bb-U4
 for qemu-devel@nongnu.org; Fri, 09 May 2025 02:51:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TllB56OpWGwMmdAXLOJd8ZS95RQLSUylcsU081Lusn+nkOjha6kbFdLvEcxPBAuiSTd/Y6BfbmlzRu1SmlUb4M1yuNBL14lIuX7s9ubvJqTOFIIWVBefy4Gi1SZU9yBR4tWjzqykBhe6AlOe/D01Bu3PSsI20oOyqKqls2zZiV+gaSBWyB3uucGoMAk1t6K6LkoB4M0k8zceArhqmdOFxTf5H+7176I7hc/TCbgOTNpxYEcBXkaP5Ka0wnKCjoarvRz5nPLhLkhRtDD9+N1dXW+cZHEqfMz2jQKmc+xVuloTLEmRmBawpq/by5zo4qDCkwknVMvamFhL4fQ2DQVbgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlZSp5WBVPfAc5mXHgsIDBui1zYGPfeL4bRztPR1jDU=;
 b=N5iL4XS5QSWkOZKO24+iUyLmOzaRZKWvEqNKA2tCJhGF+ZkYlXTLfdHMF8h6yMyUaQtoBkbeosrk3LDxxIA80xLvGkoxWobFunLEz6OxdF8ZpJMqQFQ2lE3enwhOrdsiiMd+uFbxY7oWTZXRiQNntxofLTM2ySSFUyrHJ5nGiEHWWBIjKGqbCMGkev125602zsZmj8DZAp1mCLl8dCO73QWblUit/NZz9/k+W24hCtiQWlZoUsd9uLjRdw1Ekgs3TNZnbAnOHoZYvvrZ+zPClNjyWdLdz/ppTxyYKKlN4aKB+UOe6Ffd58iKZtto/xFN5Z2auzj6N+C22AyTuUfWzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlZSp5WBVPfAc5mXHgsIDBui1zYGPfeL4bRztPR1jDU=;
 b=y1pdNxbZmKugOv4dn6Jt6n5LLCGzGCKSbkXrLhVyUuws5kdkd0tN9Xf+lr+6+mC1WQAAXom3uth8LbqZbFRQaqv/O8jyaY7N9n5kmt1ilKg4XXo+iRuyUQJqR0MaXu0w3P0f12IUVsz4DcCKfc83DqF/z7Snn/zJly/KU6+L1qM=
Received: from CH2PR18CA0012.namprd18.prod.outlook.com (2603:10b6:610:4f::22)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 9 May
 2025 06:46:04 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::29) by CH2PR18CA0012.outlook.office365.com
 (2603:10b6:610:4f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 06:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 06:46:04 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 9 May
 2025 01:46:00 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <sarunkod@amd.com>
Subject: [PATCH v2 0/2] amd_iommu: Fixes
Date: Fri, 9 May 2025 12:15:24 +0530
Message-ID: <20250509064526.15500-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a65801-770f-40a3-5e94-08dd8ec52b34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QW9yMHVsVWFwdmNHM1dETW00dEI5ZkhtMmFGM28wVzRGZGlyck9UMFJLNTVY?=
 =?utf-8?B?QUFKQkJlZW9BaWMyM0VxdGxwVkN3cjFLUWZWYkRuYlJ6RFRDcGZiS201ejNi?=
 =?utf-8?B?aFpWRU9sNXllVjRyU3dzQmJRWlA0S2JJNXRmSGJoUXk2ZEJoVVhSTHNBdDYy?=
 =?utf-8?B?b0dWb24vNFBPL2h0WmE4b3pTNVR0S3psbHlSZWpncjk1NkRFUVk5MS95dUsz?=
 =?utf-8?B?MkxJWEZPMHViaXdKbkdEL0NQMlNhdFhCeFdaZXN3dUNJL08vak9oOXRlRnpB?=
 =?utf-8?B?enJKcy9NYk5JcjhDd0F4cEl5Z2R3bW9Sb05RSWIxMjBsbFhjb1ZOZXZkc2di?=
 =?utf-8?B?Tk5HR3RlS0p5anJ1VUJ3V0xQajNkZ2NSSHFnR01vSUsrY0sza095TlQ4dE9Q?=
 =?utf-8?B?T202cVBhdEpsczY0NlhxeWNkMkgxNEhEa3lRSVVGWFZlRXV1eEVqVkJzVElv?=
 =?utf-8?B?d3F2Wk5NUzYzeHF2QW9ubjBuUWdTZHBaYTMvN01kdkMwMkMxd2hjdHdxUk9X?=
 =?utf-8?B?b1hpOWphZ1czWDVVTncvN1JFVmtORzhKV3hlYWFwVnFZSCt6M0UydGs0MlpK?=
 =?utf-8?B?YTlzbmpKUFVua2hwRXJ3eWU5Skw3cTJFOHNKSko0L01TM1JtVzVpWmNqNDB1?=
 =?utf-8?B?WGo4Q1ZyQkpJVE9wMGpMcjBYVWl6aXNYR01zV2d3VnpiZ3cvSVZkS3RhanJT?=
 =?utf-8?B?TmtWMWJXR0lqa1VwNnpMRGl3TVpUTjhTOHd3N3ppaVhvVmRQb1JIblVIUDBZ?=
 =?utf-8?B?c1ZNcC93akZseGRMV3YxakxrVkFnY1MrUWZxZXh6ZUZYZ3hjWWhEQkNkY1NL?=
 =?utf-8?B?YncvMW44clRNTy8xSVkrWk52bWpyQmxzaWVsbnJKMC9QOFVNYWh5RXI4N3hR?=
 =?utf-8?B?WkkxVldZTEUxd280SGkvYXFUT21XT3I5OXFJdEo1bDNiZnd5MVhvYXNHcGo4?=
 =?utf-8?B?dVhVL2tBYzdWS2V2dCt5c2RZazZsb1hsbHhBQkVzbnJxN1lFckhHaFNRNDlF?=
 =?utf-8?B?VTZwaCsvNzBkTE5nVkdMTzN3SVJlQWpOZXlMOFExL2E2OGl6NGUxSzVteSt5?=
 =?utf-8?B?cnk1WmdhNEl0aUlMbmt6WGZIWGxFRWdqTTVMUTl2Z0NQd3pSblpHc1RXNWlj?=
 =?utf-8?B?V2ZsWUdxUTBYZzEzWFNPNndQLzhpZllKYWNRSDYxazRoemV0dzBTV2dkV2lX?=
 =?utf-8?B?dU80OE5CcDBDeG1US2hBc1luVXVQZVVaTjhnV0RSOFg4UTlrbTRRbHpSZGRB?=
 =?utf-8?B?RWQrNGUyUXFIMWpkM2x5TVFKaklGNUN5VTh0Z2UxK3Bsc3FRVk9NeHU2UFg4?=
 =?utf-8?B?dzQzTHVZUDNLSDZ2OS9mMlp0azJxWHZOclVESGRWR0orZEtEeHlTM0hpU1Z1?=
 =?utf-8?B?SldKR2tBZHA2VlFvbUthN0U1TW4ydmhBQmpPMTFtSnhtdGFFTWR5WUt4N1NR?=
 =?utf-8?B?OC9ITzlOcGxCQ2Mzb2l6UFNnVmdRWmxXemNSU0pLUTdRZVpFYVV6N2Y1Qk5r?=
 =?utf-8?B?TnRodWVid0pkL1p3MVE4VkxTOU1ma1BFclNXaUJVUXM5N1VLNmZwUUErbnh5?=
 =?utf-8?B?ZVBIN0ZBZks3WmF3ejVORnZHWkgrWExSR3EwaU1MT0dDMCs4eTVJWFNHaEs3?=
 =?utf-8?B?Z2pRditVY3AwdWdBeHRadU93a3dEbmc4cktHM0xIZ2czb1djNnpPQzkzcFg3?=
 =?utf-8?B?eFlhQ0RRbFlMUmpSMkx6WTd3MEpXZ21EbmZxU2M4MWZyMHQycFBHVXMyNVN5?=
 =?utf-8?B?SVFBcFlDRWxxcnVKM2Eyc0dyMG9CVnhmQ05nZjBXY0ZPazRHdkpwaFFJY3p1?=
 =?utf-8?B?TlhrekR4TjBnQVJCZlRsMk1BaXNkMFRxWFQ0L1UxR2pTZ2l6eHBxeTVtZzlM?=
 =?utf-8?B?Qm9xMWYvcVl4bkkxbnBjdFNaaUdWckd2cTVxL0piL1V4dFd3SW1vNnVrU0ox?=
 =?utf-8?B?VStkanJDU0lwTENrNWhlVEVJVXRMNGxxL3VnTlluY1FHNDVPd3lJQi91TjFo?=
 =?utf-8?B?TnQxSU9Lb0o4MStyaEJueXF0d2QyK2dHUTBBb2hCL05rUjNXYjZSMzM5UTNk?=
 =?utf-8?Q?wzNm5L?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 06:46:04.0477 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a65801-770f-40a3-5e94-08dd8ec52b34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
Received-SPF: permerror client-ip=40.107.96.55;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM02-SN1-obe.outbound.protection.outlook.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.416,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Fix following two issues in the amd viommu
1. The guest fails to setup the passthrough device when for following setup
   because amd iommu enables the no DMA memory region even when guest is 
   using DMA remapping mode.

    -device amd-iommu,intremap=on,xtsup=on,pt=on \
    -device vfio-pci,host=<DEVID> \

    and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'

    which will cause failures from QEMU:

    qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
    qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
    qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address
    qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS receive buffer address
    qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list buffer address


2. The guest fails to boot with xtsup=on and <= 255 vCPUs, because amd_iommu
   does not enable x2apic mode.

base commit 56c6e249b6988c1b6edc2dd34ebb0f1e570a1365 (v10.0.0-rc3)

Sairaj Kodilkar (1):
  hw/i386/amd_iommu: Fix device setup failure when PT is on.

Vasant Hegde (1):
  hw/i386/amd_iommu: Fix xtsup when vcpus < 255

 hw/i386/amd_iommu.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

-- 
2.34.1


