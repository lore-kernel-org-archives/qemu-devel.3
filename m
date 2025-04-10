Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40C42C3601E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 06:51:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2ljo-000097-EE; Thu, 10 Apr 2025 02:50:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u2ljl-000089-BL
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:50:09 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com
 ([40.107.92.64] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u2lji-0006Ze-Uv
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 02:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7Bbz2I0k4STyV+M1fJXkbjl/BPDv5hgsf4aC2+89o16KlKr3RQy55BDpFVuf6dpRtCZezep40DjRKFn4j2brXnKht7mvjBAq2CQWbyZZOtTBORfSRUXy7IZJoRARgUJ89Gi91lhGJm14nbuZXL3Jr0uAJbqSXRrONUTefkWloiekE4VouHxfHlsJahcL6kOPgZldIFPj+fWVIuOTSnRFSpYusqIg5VPCSgKCsj4/TKJrIP3g5dMlFeoW5dVA7xsR+8SWKzecAVktjxP++5PuOH2wZ6Vl4GZ3C+uE669lZUhIN5Tgip3zwxu25M7Icl4I8LjmHAyLjGt15WmKGmBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTRJ9pBiN2JVZkAuM3ZAl0YkLpXG06fhOTxViAgPgvA=;
 b=qitwn5fMt8K5TXeRrS4cubDlk3IWmIaYLXAvhamvlQsfs0XOYfXvYyDKoVQM0KeQ15FlxPqu0ASzVR9yvFGwf8pxzDBL6+A/g5DQAZpibIlZPi723pSelRNQmwcA0wOneCACmgAKvqGJEdE8vnPmmwwVplX/xnLwfYadUvMrN5pppuI4OOCUFKy9xNMr0es5+IEQW4PWVcfGiE7BrTF4njz6HgvJfTzSSmA3KapIKJaZh18jg50hh0bhtL92blr8z3IszGbDpx0R6trvBNC2JO3ILmTxK8wIm7T2zwLCsIUApvhjbh386vVYQ3cx7jLU+5YY5cgaHwH08Bf8ZgtOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTRJ9pBiN2JVZkAuM3ZAl0YkLpXG06fhOTxViAgPgvA=;
 b=syJmqn+BuA7jHGEj8f5kcQx8T8TwbrFZ7uCvSoFkWwF2DbrGuIH9Xzo+m/wAGCRDfJNMUBwpKFIJVLQ+bZ4w0GBuoTs3TFL5JTMBy9Yk+r22NBTUniQvuSNrPQ3aNNw/2tmsyk/q8sxMkGtOzfbyXTfoIlxO3BOx3CYYHn55eY8=
Received: from DM6PR02CA0148.namprd02.prod.outlook.com (2603:10b6:5:332::15)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 06:45:00 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:332:cafe::ce) by DM6PR02CA0148.outlook.office365.com
 (2603:10b6:5:332::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.36 via Frontend Transport; Thu,
 10 Apr 2025 06:44:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 06:44:59 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 01:44:56 -0500
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>
CC: <suravee.suthikulpanit@amd.com>, <alejandro.j.jimenez@oracle.com>,
 <joao.m.martins@oracle.com>, <philmd@linaro.org>, <sarunkod@amd.com>,
 <vasant.hegde@amd.com>
Subject: [PATCH 0/2] amd_iommu: Fixes
Date: Thu, 10 Apr 2025 12:14:45 +0530
Message-ID: <20250410064447.29583-1-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: bf6d9e4f-771b-46ef-f3f8-08dd77fb36d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Wm1WTVo0eWlIU1pkcGswWG13RWIraCtiL01uNFIzclQ4KzEvM1B6ZFdhQktF?=
 =?utf-8?B?QWY5aTk4TEdVSTVFQ0w5YzdXcG9kMloyNHpaWU92RUZ1Vm5sOUgyb0wwNWRI?=
 =?utf-8?B?RTFCa3RiVGRZWUVTeUZERi81MU1tM2xjYUhFYlk1Q1pMZy81NG1jRXRTUkpE?=
 =?utf-8?B?SjFYS09USlZYcHpoeEZDT2VPdks5QzdyaHAwYnowdkwxbE9RRWhQdXl3T0Ru?=
 =?utf-8?B?WW1GY1FBTFJuNjFnMk0wNDltR1VmR0tTUkZjSFNKR3NOSGtrWkFTdU40MFNw?=
 =?utf-8?B?SnZIZHF6cHlUaHR3S2lxUC9qbG94N0VBL25HV2hjOGlnbE04ZHdEMlorTDR0?=
 =?utf-8?B?LzA2Vi9LWlp2dVZrdWpZd1BQVSthMmFxYUgzWWswdW8zVzFQRkVHdENuKzBn?=
 =?utf-8?B?QjA2cmNqV3VNWWlLajFLWklsNUxLb2NzV0g3Z0gzV3gwOWhEWlYvRFJyUG4w?=
 =?utf-8?B?TkpydktwMTVtWFhQS1JOUE9DemJJTEpqaHdTeUFCUWtpMWhEaHZ0dEtFQnps?=
 =?utf-8?B?WWo2OWE3ZjZQMU40TTZ5bUJlc1orYWpyZDdRRytxdnEvOHFpL3JjOHlienFQ?=
 =?utf-8?B?VDBMRWNEN1F2dlQrUU1ZYWNnZE8wRWpEKzQ3VHVldnh2bjdJU3lCSU9odTJx?=
 =?utf-8?B?V05TVWhLRVlKSjVkSiszMXFKY1VoMGhJMkdySTc5L3dieThHTHF6QUZQRkd4?=
 =?utf-8?B?SFEyY1ppdjN4dWtzMXFUVXNwRUxNVUdtdlhGeGVZNkN0bDlsWEVseDdLWndy?=
 =?utf-8?B?b1k4ZGwyQlhHSEZPSkhVVmxuZlYraHd6WGM2UVdnQk1PSFVlNlozK0NkejEy?=
 =?utf-8?B?MXNyUGxaZ1ZWYU5hS2tIbkFpNkMrbnZZalp6dncvMTUzZ29Sb1FDU2FrSzNJ?=
 =?utf-8?B?TDlHWWR2NlVtVjRYMW4xUEoyMVE3TVB1M01TSFUzemI5ZzVwUXF4MWQzU2Rj?=
 =?utf-8?B?OWhlTFVPTVpVaHhPaUJWYzdiK3Z0d25DWG9pL2Vhd0VlSFMxM2tjbkNQL1F0?=
 =?utf-8?B?ZStScC9IQnRvS2FSbU1xRHlPdEpEMzl6VElyWmZQc3pudE94N3lZb0NwOUcx?=
 =?utf-8?B?Q3pkRHg3K1pIN2pNanVoSS9YNitPRituVHIxcHlwWlJPaTBEd0gvV0gwOG0z?=
 =?utf-8?B?eEF5ZzVUOFFRTzJNRGlpcHovWjliUitteTNqK3hpRUpQdEtGMkUyeEdvUWF2?=
 =?utf-8?B?UWRtZkFyM3orRzdwTVIwWXg5aVJieCttY2lNaTY4UEFZdkpTQ1RqMDVxU1Zk?=
 =?utf-8?B?MVRMc1Q4OFk5dFJEQTlmTUtLZDdYV0ZkMlk2SlFNRzgyeUlxeHVGak1JTGJX?=
 =?utf-8?B?b1RnQk5PajR5eGZzRG8vUDV1RFJqdkNoMGEvbGJ2NzhtdnVRV0ZiQ3pUWjZ6?=
 =?utf-8?B?TlFaZGw4VjZrVjhjaUtFaGJlT0czY2tiaWk3L3VyYlVsenFXMGJkakNvOUQx?=
 =?utf-8?B?bFlTS2dDa1FsQytBTmJOUURuTFJkZSttaVBIYWFJalJmTldYajIzcEtmVEln?=
 =?utf-8?B?ZkxRWC96V2hyMTE3R1NvQ1psV29XMi9MYmFGN3A2TFFaQ2V5UnczZFNNazVj?=
 =?utf-8?B?VURNZ3k0VTd6dmtMZWdzaDEvbWxGc29pWDRKNG1DMmd6OUw3UlVScWZtb1RM?=
 =?utf-8?B?cXJ6cDI1NWhnTFFEU2I5TUlqYWRqQUZlMVFheG5rSG1Xb0hrS251c3AwT241?=
 =?utf-8?B?ckZFdmx1azN1UTZQS0N6NE5KcithcE5QZ29FUytKVFE5cXJaZ2MxUlRpakFZ?=
 =?utf-8?B?VFZVeXJqcXlpYUV0elpXNUU3cWZockdNaWJCRFBWWk1UT2h4NGZSeUhxL3hF?=
 =?utf-8?B?MSsxM1hrK3NwV01WUUFSeWhPYWE3dGpSUHA3K1JuNWpqUTZJUm8vVDRsZEJK?=
 =?utf-8?B?QnpMcWNwbFdWZEd4YzZVSHpYNzMrMmozT0M1MjExcWdZdjBFRmJVaFZoSkZk?=
 =?utf-8?B?bWx6RVVCd1dOcEgzVndDeWZKNlBCcDNNSzBONVRXbU5ORVVmeTNFYk1nUEFD?=
 =?utf-8?Q?xCEGH6khm6hcrXMEv5WQ0Kg1HNJlQ0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 06:44:59.6094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6d9e4f-771b-46ef-f3f8-08dd77fb36d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
Received-SPF: permerror client-ip=40.107.92.64;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.505,
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

Fix following two issues in the amd viommu
1. The guest fails to setup the device when pt_supported=on, because
   amd iommu enables the no DMA memory region even when device is using DMA
   remapping mode.
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


