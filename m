Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6197E78498
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 22:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYXPV-0003de-A6; Wed, 24 Dec 2025 17:32:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vYXPN-0003dG-9l
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 17:32:43 -0500
Received: from mail-southcentralusazon11011054.outbound.protection.outlook.com
 ([40.93.194.54] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Michael.Roth@amd.com>)
 id 1vYXPK-0004RW-6D
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 17:32:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pwRzDWXho9v3b+0jDCzTaRLf5YyQIm5YgKJANmxSFbmPjqUKeQmkPYSAGFSZENmHHi7M7AYbCf4kICGc4CQxnmaW8Eztur/Ua79mSX+hl2F4PlJb/7ppl5/FAwuZRU0Scg11hoSszEPlPfbl3tPe0NrwQ6ae0Dgak306S2KIAi16E32z0HE5u4MLNuIdt2Ch5SgNDqH2mq1KP8mbBaUI/BrEnJ0yx8sbDc7+aR5niNXpdZc3IMVo+rtYeXvAEAvgnCSi53swnFFmlBdfTc6mUjRgRbX2wVV5HzneJKgiopwuJ5L+tnKmt3qZBEtBRoUO6rPHgVP6eKPwV13G5cDS9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MtPlViDl2oWBAUVKbxCPWIsDm/sCAWZUE4A7p2LVRZ8=;
 b=FCwUi60dIJrC4UHx+q2SWxCJQSFceceLvFpPJtRKi6Ba/ALrGBsWUc7aVohVHKJ00xDpB2mfU1kHyxPmnnfHzgMyVHFclezON/LWRuYg24A5wqtSO0vEruhDLVlQd6W/NQO+TqkipV+mOunG+I8sdRqW53JRkm87r+CcOHzUUlKjW6Swn/41zcRcQNwFCKVlTJhO+9Ju2SWyp1RhQSSp8Bq801xByF5xEMwJOom3qAgEJRt8sXFIQ79ix9WHfNbpv8o/e6n4M4j2Nws9stuFNoWCynUzJLYDH0TEzNSMe1BXhcg1Lu5UiR2MJhBVyZG/Vi9sQPpwM7cDbVxZ0lmDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MtPlViDl2oWBAUVKbxCPWIsDm/sCAWZUE4A7p2LVRZ8=;
 b=ABAkmMGIYaG/iLLVXuvDZ6Nm1C0sHAc4vo3uxEs3Y71t0cA4NYeY5Of7Ht9toPKZR6ZNyF9l6q/QFnTZ5FJI8rXwQy5ukmv2mz2cr46WJK2okbK5PJmggTmhip7rFxYeiAZMd0BXkskRx3csT6qvOEGFMs/WGRkBrTDkfL3riqA=
Received: from MN2PR14CA0012.namprd14.prod.outlook.com (2603:10b6:208:23e::17)
 by PH0PR12MB7790.namprd12.prod.outlook.com (2603:10b6:510:289::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 22:27:25 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::72) by MN2PR14CA0012.outlook.office365.com
 (2603:10b6:208:23e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9456.11 via Frontend Transport; Wed,
 24 Dec 2025 22:27:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.9 via Frontend Transport; Wed, 24 Dec 2025 22:27:24 +0000
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 24 Dec
 2025 16:27:23 -0600
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [ANNOUNCE] QEMU 10.2.0 is now available
From: Michael Roth <michael.roth@amd.com>
To: <qemu-devel@nongnu.org>
CC: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 24 Dec 2025 16:27:09 -0600
Message-ID: <176661522950.44264.17249319357025962085@amd.com>
User-Agent: alot/0.9
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|PH0PR12MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 569292f5-349e-40cc-941d-08de433b9cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkE2WXZ6dzZXNm0vd1NWT1ltUzdBVzNDanJoMjFTMGNYeEllT3pGRUpXdVIr?=
 =?utf-8?B?Q0phZmRwSFV5eUhhakFMZEVOdE1zMFNqWElmd1lCeTd2elRwRk9oM2ZXRFB1?=
 =?utf-8?B?RTZ3YkZXbE5qY2hheTI0U3BWZG5XVitNZmRlVmE2Q2pvam50RTJHdVFoM3Nz?=
 =?utf-8?B?TWQ4Rm41R1BpZjhNVzZsWVhHM1JjUlJhbVRGcDZVWis5Y3loU3pkTW1GaSty?=
 =?utf-8?B?aEVlQ2kraUZDZUFmRm1aQ3pMSG9BQ1NwNEVWZGtvUDdaMmFFWWxveHBjY0hI?=
 =?utf-8?B?SFc4bC8raXd3N2V3UkFPV0JJL0FCYkdZbE92RWZzaDNLZS9xbHNMS0NGN1lj?=
 =?utf-8?B?MHM0QVNKVWY4K1l6STgrTnk4cnI0QkhYNHRlUWF6eDZLNkNOM2UrOThyVk1O?=
 =?utf-8?B?NFc5UmVqMjFQRjYrdHJteFVCaEpIZnlYZSt0OHZoZ0cxQWx4cnMyd3NtT25J?=
 =?utf-8?B?T1hmOXY0MTlrMVY1bkVZd1J3NDJkRHExRE55Y3plYkNnZDdvV3RGZjMzZmhn?=
 =?utf-8?B?dUtaSkd5dkxrK2d0Y0IwQzhlRFlWNVBJYllJYWNyYjk0YTI5c1ErcEJRQmo4?=
 =?utf-8?B?d2M2SjkzSTNBV1pLSFArVE9CL0d0QXordkNkNlJFVlB1cmdCNVJhQWtMd0hK?=
 =?utf-8?B?eW1iamlBMG9TMG04MGdlMW5HOVg4eXhxVjEyQmFGQnF1NFRpMU80eFAwbDI0?=
 =?utf-8?B?M0xYVlpQejZ6a3VTeVBrUXB5N0lRTS9mVEJHdkxwR20rSENLNmVSekg1Z3lT?=
 =?utf-8?B?TkZtUTVhYmVaM0E5UkorWXpna1Z1NjVrUnRpS2FFN0g0MjBEVUkwYjRhemc4?=
 =?utf-8?B?WUZYdUNQeEYyWW1kV09Vc04zUjhZSkpsTFpyVSs4d2VjdUY3VUJqc2RsendJ?=
 =?utf-8?B?NFZKUFhjZ1EyWkJLSHdjSGhTUUdjU1Avb2VIWlQyUVl6elMvTCt0dHgwZ0xH?=
 =?utf-8?B?aEwyQzJxdUgwcHRLcjkwaTBubVBpVWhKbVBxS0RxSmRSSG4va3p5MUlPd3Z5?=
 =?utf-8?B?VXdWSXJXY1hpMlo0dFhFRVFIRHBKcTFvWUsydnpHb21kN3BOU2h4Z3N4Y2hj?=
 =?utf-8?B?cVAyaGZTZ3FXVS80M1d6RVVCODlHYXVKRWxWbGNneDY2WDJrU1c3SU05aHZS?=
 =?utf-8?B?dmdaTXpqemtPTEtqTEdrLzB2aVFpRXdPaHFuU1FtYjlpZ3ZQRTByQnZ1eDZ1?=
 =?utf-8?B?dW9Jbkw3WXZCVXhrSTRrd1BjN2VJRHhtSWdpejcySjNNdC94dDJ0ZlJZOXQ5?=
 =?utf-8?B?elZOSWNpdTRvT3pSMjRtVWNjcUsySWhrV1ZmRU4zOVpFeXJuUjJ1bm5YR1pQ?=
 =?utf-8?B?c2ZaVkJ1VVdqWk5KZmc4REp5UTBkeDBOeG8vby9MNzYyRWxMeGI5cVAxN1A4?=
 =?utf-8?B?a3hodE5ka3ZOU3pXcU9nMkNUdHhxbzlaTFI4TG9NdnJ3UzVWdkYyNnB1dlhV?=
 =?utf-8?B?akJWS2Iza0cramlkSkFBNmRsU0JEdXNLb2ZVaDN3bk5PSXl4S3Z3UGQ3MHdM?=
 =?utf-8?B?OFArelowVUg2YXliT2FCSkw0aUxFZS9oTWVkajAyNVBiYy9LeWNnc3ZncDF5?=
 =?utf-8?B?TDArWDhvZUYyejBiUUQ4ckFMcG9vWVB4a0RJaGJGeDZsQlYzTUtrcGdkU2hU?=
 =?utf-8?B?eHJteXZaRDVrd2t4eWh6ZG9Hc0gxYVhlMWwzTll3MXROc0U0d0wwTTRMaTRN?=
 =?utf-8?B?dWErNERnSVZ5Kzd5dk5GckhzTnkrKzZIdFJFdEI4amFLdyszTStTK05USDV1?=
 =?utf-8?B?WEZCZlA4RkhMOWs3ZVVMd2NHeWluY3JIOFIxcnRxa2RMZnBkeERiRkl2N0w5?=
 =?utf-8?B?L3QxS1NLQ0FGckJUdGlxcWNBWVAvM1FXaG0xSXVYaWdUU1ZUem54ek9ZM1Nq?=
 =?utf-8?B?VllBd3NqWm9Jd0FRS2U4c2M0Z1U1Y2RvdzlEeWFxWjdMaVA1OWZ1dkZ1bXBY?=
 =?utf-8?B?d0hRa3RXbm4ycEswdkRVRDlUTUtVVjVhbVFNK3VYNFBiYjZRNWZHWUlvaFN3?=
 =?utf-8?Q?Ay2y6k7ch6Vnu4OXXsF3g6n5mdpVd0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2025 22:27:24.3502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 569292f5-349e-40cc-941d-08de433b9cad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7790
Received-SPF: permerror client-ip=40.93.194.54;
 envelope-from=Michael.Roth@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello and happy holidays,

On behalf of the QEMU Team, I'd like to announce the availability of
the QEMU 10.2.0 release. This release contains 2300+ commits from 188
authors.

You can grab the tarball from our download page here:

  https://www.qemu.org/download/#source

The full list of changes are available at:

  https://wiki.qemu.org/ChangeLog/10.2

Highlights include:

 * 9pfs shared filesystem support for FreeBSD hosts
 * Live update support via new 'cpr-exec' migration mode, allowing
   reduced resource usage when updating VMs, and potential for re-using
   existing state/connections throughout update
 * Performance improvements via switching to io_uring for QEMU's main
   loop
 * Lots of fixes/improvements for user-mode emulation

 * ARM: support for CPU features FEAT_SCTLR2, FEAT_TCR2, FEAT_CSSC,
   FEAT_LSE128, FEAT_ATS1A, FEAT_RME_GPC2, FEAT_AIE, FEAT_MEC, and FEAT_GCS
 * ARM: support for new 'amd-versal2-virt' board model, and improvements
   to existing 'AST2600'/'AST2700'/'AST1030' and 'xlnx-zynqmp' boards
 * HPPA: Emulation support for an HP 715/64 workstation
 * HPPA: Emulation support for NCR 53c710 SCSI controller and HP LASI
   multi-I/O chip (developed by Google Summer of Code contributor
   Soumyajyotii Ssarkar)
 * PowerPC: Support for PowerNV11 and PPE42 CPU/machines
 * PowerPC: FADUMP support for pSeries
 * RISC-V: Numerous emulation fixes/improvements for various components
 * s390x: virtio-pci performance improvements via irqfd=20

 * and lots more...

Thank you to everyone involved!

