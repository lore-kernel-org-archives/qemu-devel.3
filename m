Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57E4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 06:45:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4a1h-00040d-8k; Tue, 15 Apr 2025 02:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u4a1H-0003xi-9G
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:43:44 -0400
Received: from mail-mw2nam12on2056.outbound.protection.outlook.com
 ([40.107.244.56] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u4a1E-0006lD-II
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 02:43:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vf8MO/7OCV2arBr7WQ0p6pdxpQPD4NsMz2k5IGnx07BH/P842CJPQ5MHNyHWp0n8hY8wgAOwUKULtW4mcrDr4dK0oQbHIRnudzgNGTafJIWVcL58j4Pr7aSjfDlbThTPiq1LBV8ieIJSeMA9r7sTfX92Lmo2vVnV6QTzybXzeHUDV4spf1ogTu/96HuGOWvkkorJoj9oYNWag4KBBG8CyCmiF0xqPetv6kf2P2vz6BjJqhht+PZGHvSSHQuAGlXXphlsDk5BNI/KTPq5iR8xzCwSJzh9D4oeFDD5T4jwqd0hZtVuQO8gp+MLue4OWFb1PLdg5hzmpc6MUdnlHrlMqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kminknc/l9Sqfs6vOZ5jm1BeFsp4ZWSHLdvSahPVUdU=;
 b=Sm8tnvGaoW2DXeZ/WUYkBMAPcowfrjlFjNR31XnvAMU6z8e4MSziZZyviN249QbpVhXQQML3NVcTN4EQrjTzhKoOpj8nqHhPDyl5W+7JSumGdi4aC9gbjsspr9cukrMckyeya46vboFs9TOPTaG5NdULnxaupELD8WsSbIHudY2AqVg8NkjpCkQIgDthLKODuAj6I2m/C9xThKGbiFurkZmoEcMo7CKsfvIzc9tXDC7V9BEohwqVVjtdPnG2JgN+UtknljhvRPTRwkuIiL6ZOLvBVuGp4MaV0lcpYO9Rxg+nSlPygQCzktY69bezfeuz6mJ95GuXBfsgLMQSguV5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kminknc/l9Sqfs6vOZ5jm1BeFsp4ZWSHLdvSahPVUdU=;
 b=Xjwv8jF6JvNEnesTVY88NJaa4CLdjPEG+WGYeaYIIWKyhsGs6w9VXmR0ZCe3px6VoVySXhj3xf/JDSfvCWgU39wr7TWSTda2kRc7C4VmXJx+dgEbfPyfexj5IA+Rxe7ocdJjh5XaUCiKEdfZYRtePWgXXvO8270ow/7bTW2M2hM=
Received: from BN0PR08CA0009.namprd08.prod.outlook.com (2603:10b6:408:142::13)
 by CH2PR12MB4277.namprd12.prod.outlook.com (2603:10b6:610:ae::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Tue, 15 Apr
 2025 06:38:31 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:408:142:cafe::22) by BN0PR08CA0009.outlook.office365.com
 (2603:10b6:408:142::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 06:38:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 06:38:31 +0000
Received: from [10.85.32.54] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 01:38:29 -0500
Message-ID: <63acddc3-bc7b-47e4-9e7c-66bdc40f23d2@amd.com>
Date: Tue, 15 Apr 2025 12:08:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/i386/amd_iommu: Fix device setup failure when PT
 is on.
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
 <philmd@linaro.org>, <vasant.hegde@amd.com>
References: <20250410064447.29583-1-sarunkod@amd.com>
 <20250410064447.29583-2-sarunkod@amd.com>
 <914314b3-611d-4da3-9050-3c8c1b881e40@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <914314b3-611d-4da3-9050-3c8c1b881e40@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH2PR12MB4277:EE_
X-MS-Office365-Filtering-Correlation-Id: dadbe2ab-362c-4a28-9a55-08dd7be8236e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTlaUmpjMmlpbUQ4MUpJREp5Rkl3c0I1Q2d1NitTRFRIVUJrOERia1JmM3Zz?=
 =?utf-8?B?R3ZjeEhvMWg3L1FSaElsbndkMFhyczkvZDA5V05hVXp5YlZIdnN0U3lCTzFD?=
 =?utf-8?B?YW56NlQwN2NUeUU5Y2dkSFVSQTZiTERpbG55QjlKMytIMEVQZ0EyWDVabmNH?=
 =?utf-8?B?MGRzYUt3NHZmZ3FJSjlQTC9tSEVNWmFzTE1reDBWWW4vWjhHanZmbVY0b01W?=
 =?utf-8?B?QkRtUjluZ0l5ZGVqWk1TSFhHWVc2UHVhbjdPZms0WmtEdlZaSkFZc0ZtREww?=
 =?utf-8?B?dVlabGd6NkFUQTA3dHp4QmdzVTNHZzRyRm1CeDJNV3VldHBuN2dxSFdYVnFN?=
 =?utf-8?B?d2tRLzRuZ1JsNkh4ZEI2dU5NYk5mWE5BRjFFcG5vTDRxbWRzNTlxTWx2eW1Q?=
 =?utf-8?B?Z2xWV0VuMFpYZkd3ams2L2E4dTU5bWg2a3R3WUJUMDRuaWZGcy82bVk5YTRo?=
 =?utf-8?B?MWNLZDB1SlNnMFVITVk4U1dvMkVDbnhxQVhpQ2JOUjRKSFUzbEIxQ1FiZ2Z2?=
 =?utf-8?B?TWlBVE9raWpnZGZwSk5ld2dGQml0VjVzSzFpa2x5bHc1b0tINElPTkpudVgw?=
 =?utf-8?B?S0ZDYTl6TU5yRFJENEFFZVFLdWUvTzNiVzRoR0lEV1hlWFo5a3VabUJibGVU?=
 =?utf-8?B?YVhYeXEyM3dQN1B6T2F1MjNIT2dWcWdEVzdBRW5hcGJCcmlOeS9FeHlERUow?=
 =?utf-8?B?RU5la0dYSmRWZG56aHZFOEVPU2VBNnNRdVpTN3Eyc3J4QUp0dUdZZUliZ0Rl?=
 =?utf-8?B?d2w4WUt5eGxFcDNNRGpMbi9OTVV3WlRDQklueVdPSFRCR1JhZ0xOK3hrditV?=
 =?utf-8?B?TTArVFZvMWJkUzBCRW1ZdVhJeXVGbi9oWDlNREdGK3k5Vmc4QkxqMW84UDM0?=
 =?utf-8?B?aGZBK1JWMGhUNTJsYU1GZTFsZG1YZmNiWDUzVmpDd1dWU1U1emRnc2dtWWcw?=
 =?utf-8?B?Rm9jcGxncVVxTHh2NlNQYktDSm9iWWFnUmdUaW5kcm9QQWN0dXJTQVdxR1RB?=
 =?utf-8?B?ckt0cXlwbzBMWVFnVHlibFBhMkE5YXI1UHk4ZzlZRDR5eDhqN0p2OXJZUVdS?=
 =?utf-8?B?TkhsMlJRdEttOHI1NXBIc3lWVldiK0d1VFdsVFlqMGxQSUV4SEV3bTlwck9Y?=
 =?utf-8?B?OE05b0djU3FVSy9oVjRwTmNYQ25aUDQzdHIxdjNaV1BRVDRiU0MrUjFHMFc1?=
 =?utf-8?B?MFVYMUt1Q2lsRHVINjFGYzRtbVpabTAzbTFrYzVtUGNkYmtsTXJKMHE0eUUv?=
 =?utf-8?B?SStNSFlGOHNpcDBMRDYyaGhFNEVHTHpzQzg0RmtxWWxQQ2V4TjJyLzZLaEhs?=
 =?utf-8?B?NjJ4K21kcGF4SnlOaXhJcVEvcXozSXZreHJwNHVaOWxJM0Zvd3FiVUh1N2ta?=
 =?utf-8?B?SHhodGVTSUdyd0thV2JMUjFUajhlditVOGdzdXJ2Nklrc1FkK0JiLzM3TElE?=
 =?utf-8?B?M2NFaVRwYnRLWE5kTXF1dDdvUmIvRW1melNZeUpXOXdzREgvQzlPUEtsSXlC?=
 =?utf-8?B?L1VMYkkzTC9HNVpRYW9qSmQybVdIUFpDYlpDSlBmZ0Y1cnJDTWlHd1B2QjA5?=
 =?utf-8?B?c0NCSm5DNzZjZ0ZJeUpwT042dmF4M1p4TWlOaGJ1Wnp0NldTMUtVRjVBSVNw?=
 =?utf-8?B?Ni9hMnBvVGZmVy9kcmV4b2hUSlAwa0pLakRVNlg0KzdqV2tTTjJ4bkZjY3Fq?=
 =?utf-8?B?WnhmN0RUQmpxdmNoUGRYWTNEZU8wR2VmQ3c5VGdZSU5DOUlteDNnUUszbS9k?=
 =?utf-8?B?eElnekk5eHBQdWdFVXpvUEx4VWVTTGN5VlVXMzMwejBRVmgxV1o3TXFXL1JT?=
 =?utf-8?B?R2VxN01nTWRTN2JvRy9VNVgwMmpqYitXUDd1b0ovS2dQWEVWY09SUUVsenp1?=
 =?utf-8?B?NDhtTWtSRzVGd2FBVlJuRGJnTWdaK1ZSeURtcU1LbHMreW1XdDJ5eUZSN0xv?=
 =?utf-8?B?WFBkVFY1c3I5S3MzSHA4WW9vRVBxV3Zzckk4RDhNc0daRVVkbTBhQUt3Yjlw?=
 =?utf-8?B?V1lwNWkwMVk0SzJ5cE8yYVF4alB4MjJGZzNuRjlhcFY2cmRZc01HZGxSRXVV?=
 =?utf-8?B?UG9KZnVJWGlHRjhQa1pia0FNdGVKZmJEeSt0dz09?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 06:38:31.3246 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadbe2ab-362c-4a28-9a55-08dd7be8236e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4277
Received-SPF: permerror client-ip=40.107.244.56;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



Hi Alejandro,

On 4/15/2025 1:56 AM, Alejandro Jimenez wrote:

> Hi Sairaj,
> 
> I'm conflicted by the implementation of the change, so I'd like to make 
> sure I fully understand...
> 
> On 4/10/25 2:44 AM, Sairaj Kodilkar wrote:
>> Current amd_iommu enables the iommu_nodma address space when pt_supported
>> flag is on. 
> 
> As it should, that is the intended purpose of the iommu_nodma memory 
> region.
> 
> This causes device to bypass the IOMMU and use untranslated
>> address to perform DMA when guest kernel uses DMA mode, resulting in
>> failure to setup the devices in the guest.
> 
> So the scenario you are describing above is this QEMU cmdline (using 
> explicit options):
> 
> -device amd-iommu,intremap=on,xtsup=on,pt=on \
> -device vfio-pci,host=0000:a1:00.1...
> 
> and guest forcing DMA remap mode e.g. 'iommu.passthrough=0'
> 
> which will cause failures from QEMU:
> 
> qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list 
> buffer address
> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS 
> receive buffer address
> qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list 
> buffer address
> qemu-system-x86_64: AHCI: Failed to start FIS receive engine: bad FIS 
> receive buffer address
> qemu-system-x86_64: AHCI: Failed to start DMA engine: bad command list 
> buffer address
> 
> and also errors from the VF driver on the guest. e.g.:
> 
> [   69.424937] mlx5_core 0000:00:03.0: mlx5_function_enable:1212:(pid 
> 2492): enable hca failed
> [   69.437048] mlx5_core 0000:00:03.0: probe_one:1994:(pid 2492): 
> mlx5_init_one failed with error code -110
> [   69.444913] mlx5_core 0000:00:03.0: probe with driver mlx5_core 
> failed with error -110
> 
> 
> Whereas after your change the guest would fail to launch because VFIO 
> will try to register a MAP notifier for the device and fail the check in
> amdvi_iommu_notify_flag_changed().
> 
> If my above description is correct, then...
> 
Yep, The above description is correct. I should have included it in the
cover letter.

>>
>> Fix the issue by removing pt_supported check and disabling nodma memory
>> region. Adding pt_supported requires additional changes and we will look
>> into it later.
> 
> I see that you are trying to essentially block a guest from enabling an 
> IOMMU feature that is not currently supported by the vIOMMU. Hopefully 
> that limitation will be solved soon (shameless plug):
> https://lore.kernel.org/qemu-devel/20250414020253.443831-1- 
> alejandro.j.jimenez@oracle.com/
> 
> But in the meantime, I think enabling amdvi_dev_as->iommu when DMA 
> remapping capability is not available is likely to cause more confusion 
> for anyone trying to understand the already convoluted details of the 
> memory region setup. 

> To a reader of the code and the commit message, it 
> is confusing that to support the "NO DMA" case, the nodma memory region 
> must be disabled, which is the opposite of what it is meant to do.
> 

I dont think that I understand above statement. What do you mean by "NO
DMA" case here ? is it iommu.passthrough=0 ?

Essentially, I am trying to support the "DMA" case that is
iommu.passthrough=0 for the emulated devices, by reverting the changes
that introduced the regression.

If I understand correct -->
The original intent of the flag (in case of Intel) is

1. To turn on the optimization which will use nodma region (dynamically
    enabling it) if guest configures the device with passthrough (pt=1)
    for given context entry.

2. The flag should not enable no_dma region if guest does not configure
    device with pt.

Intel driver does this dynamically (for every context entry update while
guest is running). But for AMD this is static and does not change with
the DTE updates, which is causing this regression.

> To explain the "trick": this change is always enabling amdvi_dev_as- 
>  >iommu, which is explicitly created as an IOMMU memory region (i.e. a 
> memory region with mr->is_iommu == true), and it is meant to support DMA 
> remapping. It is relying on the "side effect" that VFIO will try to 
> register notifiers for memory regions that are an "IOMMU" (i.e. pass the 
> check in memory_region_is_iommu()), and later fail when trying to 
> register the notifier.
> 
> If this change is merged, I think you should at least include the 
> explanation above in the commit message, since it is not obvious to me 
> at first reading. That being said, in my opinion, this approach adds 
> potential confusion that is not worth the trouble, since most guests 
> will not be using AMD vIOMMU at this point. And if they are, they would 
> also have to be specifically requesting to enable DMA translation to hit 
> the problem. Unfortunately, guests will always have the ability of 
> specifying an invalid configuration if they try really hard (or not hard 
> at all in this case).
> 

Yep, I should have explained it in details. Sorry about the confusion
will keep in mind while sending future patches.

Regards
Sairaj

> Alejandro
> 
>>
>> Fixes: c1f46999ef506 ("amd_iommu: Add support for pass though mode")
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>   hw/i386/amd_iommu.c | 12 ++----------
>>   1 file changed, 2 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
>> index 5f9b95279997..df8ba5d39ada 100644
>> --- a/hw/i386/amd_iommu.c
>> +++ b/hw/i386/amd_iommu.c
>> @@ -1426,7 +1426,6 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus 
>> *bus, void *opaque, int devfn)
>>       AMDVIState *s = opaque;
>>       AMDVIAddressSpace **iommu_as, *amdvi_dev_as;
>>       int bus_num = pci_bus_num(bus);
>> -    X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>>       iommu_as = s->address_spaces[bus_num];
>> @@ -1486,15 +1485,8 @@ static AddressSpace 
>> *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
>>                                               AMDVI_INT_ADDR_FIRST,
>>                                               &amdvi_dev_as->iommu_ir, 
>> 1);
>> -        if (!x86_iommu->pt_supported) {
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, 
>> false);
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu),
>> -                                      true);
>> -        } else {
>> -            memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu),
>> -                                      false);
>> -            memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, true);
>> -        }
>> +        memory_region_set_enabled(&amdvi_dev_as->iommu_nodma, false);
>> +        memory_region_set_enabled(MEMORY_REGION(&amdvi_dev_as- 
>> >iommu), true);
>>       }
>>       return &iommu_as[devfn]->as;
>>   }
> 


