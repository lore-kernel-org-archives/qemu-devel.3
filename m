Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1DAC3ABDD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 10:07:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFrxN-0007lU-1R; Fri, 16 May 2025 06:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFrxA-0007l4-Rk
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:06:09 -0400
Received: from mail-dm6nam11on20604.outbound.protection.outlook.com
 ([2a01:111:f403:2415::604]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1uFrx5-0006sF-V5
 for qemu-devel@nongnu.org; Fri, 16 May 2025 06:06:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPwG5G5+SaBCD2A5IQhC4Wm48a5MKEpCb8XU3LBm44i2lOK0Aqgz3EwF6Ekc4rls4UQQDO8aRJhwWzFd9LSYr6KIBf3txoE+KHeStzaI4VqQH9OvtAqvTkW5z2zPBJEtWywXn13aM0ODMMiK2Q2VoUmQ3EG7jdB2XIy9/Ug9C8NWdeByKO/gL9rqYTvgr/zvT0KNecjC8fk7ZNgwK01TsWusCxZQ/hk58SOlrR4XgJLs86RPsJBMnz6wglDL789Dshr3E5CfPsgzd/KRo5Q/IrNGTmCHmxjK/0DQ6EdRsRHIge0Mcd6TGvrJmHQT/CJKhGB40YGOJibBnB9fmpujzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DlZSp5WBVPfAc5mXHgsIDBui1zYGPfeL4bRztPR1jDU=;
 b=KpwIufy+NZrgsx90cQt2uQygNfMsGAYqE9JuU2Q7IpLI4Q3sD7gjm4hxTWuLesLKC7S/6z/wTyNrwq5pa3XGyjvZh1rhABqMy9mcIpLFgPBG7ASpYRdTLhiTE9sozliQBF2mYSoh1cUX+YO/2Z37jM0KIZ/eBwDONoRatvFsdBoJx3nRrAZBtPkxp2qiWZMmbpDQzFFqqUXOM1L+8WmkSRy1+SJLdFSyJ8lluhNsarKO0EYqz8IahUzJ6n3gLmo3tO7HvYN5kCME0tPQS2ChmlNvBpBHNlc9P37JpAi17bbXsnGBUIEcx+JMheh18CcmI9DMF3x4DKEA9di7l1FuEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DlZSp5WBVPfAc5mXHgsIDBui1zYGPfeL4bRztPR1jDU=;
 b=k93NrrVJj60aA8QoT+aAecqKPmK0yNwfyuJiirJ8Ey+UKvb77ymVRgUvDZngrZ/OwHw9E2dGTiNNZCVGjwhtZvDl+S3aNMVhoj6X9R25C8IWkesyo6Z7G7YXxHAuDzCpcc7+b44KG9m2DtHdywvLvnjpWnn+ik9iix6ZR5OemRE=
Received: from BY5PR17CA0027.namprd17.prod.outlook.com (2603:10b6:a03:1b8::40)
 by CY8PR12MB7361.namprd12.prod.outlook.com (2603:10b6:930:53::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 10:05:57 +0000
Received: from BY1PEPF0001AE19.namprd04.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::f7) by BY5PR17CA0027.outlook.office365.com
 (2603:10b6:a03:1b8::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.33 via Frontend Transport; Fri,
 16 May 2025 10:05:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BY1PEPF0001AE19.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Fri, 16 May 2025 10:05:57 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 May
 2025 05:05:52 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>,
 <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <sarunkod@amd.com>
Subject: [PATCH v3 0/2] amd_iommu: Fixes
Date: Fri, 16 May 2025 15:35:33 +0530
Message-ID: <20250516100535.4980-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE19:EE_|CY8PR12MB7361:EE_
X-MS-Office365-Filtering-Correlation-Id: 775c26c0-27ab-4132-0d3a-08dd946140ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cGFIQkZqNkRMOFlaVVpZSUx3d2hNZnJUNFZPclFKSGd3WlpycWpPa0dJa3RC?=
 =?utf-8?B?WUVJbDRiRHhsa3ZTaXJDL3k5bVpkZ2JrUis5Mk5kNWtxMHlYMVl5OXNZc0NH?=
 =?utf-8?B?anQ0WStxbHpMdDA3cTdHZENXT3RiZVVxRzhnUVhFV0ltYlhwcFZ5WElFYlNJ?=
 =?utf-8?B?TWltbzJLTlBnSDlPblRjWlc0eU8wc3RPT1hIVU5WVEJGemYraUxDZG1CRHFk?=
 =?utf-8?B?ZHp2RDh1TVdkWDRBdkxQeCtGVnZ2c2RiNmlFdExUK01uSEZuZm1ZR1ZzczdS?=
 =?utf-8?B?LytLRkMxaGg0MWQ5VmtyNEJLZnBweGNyam5tZVdvREVOZmZVeUYzcFlFMFE1?=
 =?utf-8?B?cndBN2lvZDcwRWM0QmRJeTk5ZDF5VzNOSTVzc05nNWI3NGNmNk16MFZHaFFF?=
 =?utf-8?B?U3V6enlHK0NxalQyVEdwL0UycFBnVURBeDFYb0xDUCs2TzlzdHBEeDg5MWRV?=
 =?utf-8?B?WHVDanZvdXR6WXdNM3RKVVo4V2N1aTVmUy9WckdBMXZmdFRzcWp1dHZwOGtR?=
 =?utf-8?B?Q2xjVTRWRFBWRXJKLysxK084M3FTSjlMeVVjK3hKKzQ3RjJpa0FVait5cG5x?=
 =?utf-8?B?Q1IvZTYwTktYMDRVOEFZdFoxRkxIa3Bvb0F1TlFlcDJVVnozbXI1cktYN1BG?=
 =?utf-8?B?OE41ZklCSWN1eWF0cDVBQjRMcGpwV1V4RzNyWmhKR1lYdWlidjRUTk9JL0Mz?=
 =?utf-8?B?VEhUYjhvSTFJbS9BelRUeUphRVdwMmhabTNIc0Y1NU9OQzM5WEtiTUxMeWhJ?=
 =?utf-8?B?UGNJUklNY3VQSUJiQ29BWDRvSktpa3lDZGY0c1lSUzRRM1RINGxrN0xhL1My?=
 =?utf-8?B?NkgvVnlhZnNpcTR3MzBtY2JhVjkrb2RxUjFOZStFVmQ2c2dxUFcyL0N3Q1Jt?=
 =?utf-8?B?UGt3YmxzTUF2Yi9wWjdlZVR0V1JHRUNPclhlYmlJbXdsbFE0dEV1K2l1RENK?=
 =?utf-8?B?YUdOazloak5WdUNqUHpOR2xMNG9rdVlzbnFyL0tIeDJGVTRlc2ZsNVA1L2hu?=
 =?utf-8?B?V1dQYTRYbEJ6M0ZJU0J1cThLOVJzZHd3bFVYbDNNYy9lUHdZalg0MWVFTHdM?=
 =?utf-8?B?d2RMRW1XUkwzZjZ3RThGYmhpdjV2bzlxT3dxQVlBa00wNmIvbk93ZENmaS9S?=
 =?utf-8?B?bFFmZWFPRitDMzNKbFNlUkFRWmMwUUFNOVRhS0NCQU5QdUFodDF3SVFxQTZk?=
 =?utf-8?B?V2ZWSlUrc29LUE1keGlUUmlpMy9RWWdsRm1xTjlIbVpicS92U1puYmx5YzZS?=
 =?utf-8?B?RTB2NHpYUzFlb0RmUFlNRTkyaVgzdEJZVmNvS3FyQXlsb0VuV2YvVkNSTHV6?=
 =?utf-8?B?SDdrT08rZjd2R3IzTVVZQkMzSGppK3AwaHN2WGxISXcyYTdjNmhLa3RIOEo3?=
 =?utf-8?B?MW9rcE05ZWRrSDIra3Jsc2MxUFRtY1I1UjZJU2YrL0tWTTFUM1NqdG5Cc2lZ?=
 =?utf-8?B?Z29lS3JVS3lIUytEcnZGQ1pCY2ZMMGNDYTNjSHdRN3Y5VDJhWUkyQ0lOaFJ3?=
 =?utf-8?B?OGxPbkN0Rk5KdStVakEyQUFNalJZNnpJbjBPRWJpYlhnLzljc01GRmNuZFpO?=
 =?utf-8?B?Q1hRSXFrN3pranl3cDNlRnNNc3I3dmpDWHFZbDNSa2EvVFpQTmFkb1Rjejdo?=
 =?utf-8?B?TCtDZW9YTW81Qk1KK0NnTEZJTkkvVDhTZVc2SjVFMWJFSnlKb3JkRmR0Tkdi?=
 =?utf-8?B?MmJxSitKRTBqeVVSalEwVGRoNXZLL0c1SWhmdmNsTWkwMm0yTFRtdW1rRUhW?=
 =?utf-8?B?dVVjZ3Evak03UmFrTlRqUUFjV2ZlVU5VbHpoYmVpRDY5Z0hwWHcyemF0Z3Mv?=
 =?utf-8?B?LythZndtcmVCZnlMcWZyeUtVMHNzbTFucnNZVCtTbEdXcG9wVXVhRjhSWFJz?=
 =?utf-8?B?eU9SNGVGMGFjclpsQVdnRVBFdzU0U3NsaEtpVm5aNmpQcEs0TFZldjJhZ0hL?=
 =?utf-8?B?alRXdlZYQ2xjMDEvVUdTVjVtTldWSlBjV1gzK0QwbVRlYlo1bnlvWHh4d2Jy?=
 =?utf-8?B?UTN1YVlDVXU3dHp3ajd5dG1YWDE4WlhRRjNWQVlWV0c0aC9rRGZMbzlVZGxR?=
 =?utf-8?Q?A3Zivv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 10:05:57.4934 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 775c26c0-27ab-4132-0d3a-08dd946140ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE19.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7361
Received-SPF: permerror client-ip=2a01:111:f403:2415::604;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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


