Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F858C369AB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Apr 2025 06:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5fN0-0007PX-Aw; Fri, 18 Apr 2025 02:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u5fMl-0007Nz-RO
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 02:38:25 -0400
Received: from mail-co1nam11on2071.outbound.protection.outlook.com
 ([40.107.220.71] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1u5fMi-0000sx-Mq
 for qemu-devel@nongnu.org; Fri, 18 Apr 2025 02:38:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nma8TNx6e2yMxLCPBwwEctKeUxRqvwRnmmRvkq0nuNhxYbBWdMFOkKrtl8qudTa9NC9LlXgn7zvAXeyihmnF7AqGOv0trTU1rCNFsx41XsiQwiaDRULrW6dzE3ahnQSo8XUrs/+ZxmqLNG1qpRLXOfcS4rPRIR6AmRWOwYbflLaAe93qPc9FrgjRbUx7bth6dODV/RQe2KMW+ppEA2SJGNcKb5YB1NYArdoDYglQZ7o9xQlCbDZRElBcnr3dJUCIJU/Hsn7oRVNPavJRiz/6+m6PIbOw4kl4gke19rCP9MJmFZMyHHPIeKaOl4M2ei6hdUpDfP/Ru+qTuntMeQMa9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEFbdYHLixC48SOXd9NYyAtxZi3rgQ19hyYOeqw+AFE=;
 b=pSvcTbHYCk3JEIHN5erNuL9ztCOyj7agCq9ObMn1GJKOqVBqL2o/svaPfzMJxAE1J4Ujooo/Tq+8ZrJ3YR5E9PKO18qFawYGt2bqikIqELGTJ+ulZr8MA0vW5KP+5ejnSyvJuLmNRAliIlA28mGaT6rGEynLWiymQ7FRaBQB9wQUfZKxfpGGDAppHczhsEcKwWmFGxNCDPIqq24dENHjo0FbXWQbMW1cNnucM3oYYWXG96rD4auBnIRr6fRF0DrhBLf5W7eeDUoFEi2vVNpN6tBbH2xc2diCstW8+4L8mSjVumDUrfDWH3iBtB2Wf8+LIROzgGXLzfKv/wg7Kq0OgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=oracle.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEFbdYHLixC48SOXd9NYyAtxZi3rgQ19hyYOeqw+AFE=;
 b=er6xqzTK4kVxqutTV6JQSjFuB22BRHmjn3XQc7p6kKkVrmOgRwgDdNG0e5+nXGJPe2H1lttxF5it9OiHO+JAwaRoPKPAMkxOkJgGDVKqnyrn6QCIjW1MFzRaKJLmIBUqt1SBxOokf9G5Akjk8Wc8oepsrn5FdSTvTBkPpGXcSgM=
Received: from PH8P221CA0039.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:346::14)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.29; Fri, 18 Apr
 2025 06:33:09 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:510:346:cafe::b3) by PH8P221CA0039.outlook.office365.com
 (2603:10b6:510:346::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.23 via Frontend Transport; Fri,
 18 Apr 2025 06:33:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 18 Apr 2025 06:33:08 +0000
Received: from [10.85.32.54] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 18 Apr
 2025 01:33:03 -0500
Message-ID: <6fa9cb6d-7b62-42d7-9917-2ccb63105753@amd.com>
Date: Fri, 18 Apr 2025 12:03:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/18] amd_iommu: Add support for IOMMU notifier
To: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, <qemu-devel@nongnu.org>
CC: <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <eduardo@habkost.net>, <peterx@redhat.com>, <david@redhat.com>,
 <philmd@linaro.org>, <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
 <alex.williamson@redhat.com>, <vasant.hegde@amd.com>,
 <suravee.suthikulpanit@amd.com>, <santosh.shukla@amd.com>,
 <Wei.Huang2@amd.com>, <joao.m.martins@oracle.com>,
 <boris.ostrovsky@oracle.com>
References: <20250414020253.443831-1-alejandro.j.jimenez@oracle.com>
 <20250414020253.443831-4-alejandro.j.jimenez@oracle.com>
 <d4c11455-f28f-4052-9042-5d2c2ed9329d@amd.com>
 <f14bf894-0c95-4bcf-8a7c-25dfa7ebe76d@oracle.com>
 <ce1ae384-ab88-4de5-af14-9479394b9182@amd.com>
 <8245dc10-4dff-4a89-b4e4-dad5025544fa@oracle.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <8245dc10-4dff-4a89-b4e4-dad5025544fa@oracle.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: 97479562-837f-45ec-005c-08dd7e42e293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE5CMFlxcVVSWTcxd0xMSEJqRkxwN2VzN3M5S2VPc25jTCtCY0w4dXJHZ2c2?=
 =?utf-8?B?YzlOcGFGaHh4NjN2WlQzMVRTNUtLRHFDK2pxaDJyb2I1azlCaEIraWY0WVVS?=
 =?utf-8?B?TVdEN05JYmRFSnRXRGYvMDVUWTVwYXpybmFlT3B4RkdnSDRMem90OHM4amRJ?=
 =?utf-8?B?VVFEYzRDMUFIQkxSVEJyQUx6T2ZCdHR2T0daUVdpOWhDTTdjdU5kckI5Mnp1?=
 =?utf-8?B?WmZUbFp2MnZGRHdJeVZTZmtRYUNMTVl6cGNHR1d5MlpocXNrbzM4MXNXTElp?=
 =?utf-8?B?cTZJb1dWbUpvYTBqZ3htR3VuUEtMVnY0ZFNLRThQZkI5SjZPVXRnS1Y1dW5a?=
 =?utf-8?B?UVVlOW03VmxwSWNmb0lqWDloelE1UVRBR0xzMDd4UE9GN1prYUdpVkFIdjk5?=
 =?utf-8?B?c0dtRGVlWjUrL0pRRHAwVGo2SGErTVAvd2JNSzk2bUd6MzBwOENPNnNlWXdj?=
 =?utf-8?B?NVJUWGFOQ09SYVRDU3JNVitLenZ1djRpQ3NFRDZSY2lSMm9ZM1doOUdKL1o4?=
 =?utf-8?B?M0FEL2MrZE1ZQmoySVFLZ00vSzZhZ1NIc3dwSWdNbEZLY1JHcS9SM2J3L0Vr?=
 =?utf-8?B?UFBIMjVQVkJhQzRRREl6NnVxZEwrY1diVDhIcGN3VnU1bWZsajgwM2VMV2l1?=
 =?utf-8?B?cExiNWw0ZXBYTi9WMUFtTENsbGFuQmtkUDYrOUdDd0JIUzJUb2xFajlucUxL?=
 =?utf-8?B?WGlnTUlGZEVSbjdyb2JqanR4QTVtZllQZ1ZaSlhRMVdtcVBSejV6Y3I2OG9Y?=
 =?utf-8?B?b3g5L1VHVU1KVitrNXdPbm5Ycmc5ZmhoU01zVS9pczloUXFXS1lxaWVGRGJv?=
 =?utf-8?B?R0ovUTl3UXlCaEJoWEo0VWRvMkZsS3NGTCttWkhVRFZyQVViRHlkYzduRFJp?=
 =?utf-8?B?VXgweUhnR2Zxd0cvQ3BURE1aa0VRcXhGd0txUjh1Y0dzNzZRTHlvblJYdWEz?=
 =?utf-8?B?MEhXVisvL0JHVVZJc2JKa0cyWGpJYmlkdjU0cmRKZlRuYUJhZC9YSTErNjdR?=
 =?utf-8?B?SlRtRXRVUFN3TzA4Y3FEZENSUThvUk40VTdMZWZndy9SL2tnRDVQR3FlOEFi?=
 =?utf-8?B?YUk2d2pGY1YzR3RacUVIeTZSTGs0TnNOVlpMVkgwR3RqRGJiYzhzQjZYRVpD?=
 =?utf-8?B?TGVhQ2RkdEZoSDZSamZFaDNIVnpwRi8wWWxKbC9nd2N2bFR2RU1OamVNajVG?=
 =?utf-8?B?d0x5MWhWRzQyOXFEOEdPQTMzTUtlcVUzSDlCNjVsZDI1NGYxNElKcUhZbFg5?=
 =?utf-8?B?NWlFNzV1MjF4TkkvdXFmWm1PUTN4ZHVNK3E0TlJydHVHVVlhL3VaT0hpNkpl?=
 =?utf-8?B?SGduWTM4ektJakRkelJQTGJmUzBVSXRTdytoenUzRVN4NjJMZHZPS2ZBK3Az?=
 =?utf-8?B?ZWJPMDhCNlJmMUZNajE3Rm5zZU5rNWlmaElaM0JmSThzT1R6WUliQjVRMnJV?=
 =?utf-8?B?WjIxZ0wzSUkvWmtoR3RBS1l4elRlQ1E1bVFGRGhTZGdTNFhYNWNvNXgydTl5?=
 =?utf-8?B?aXhNYUlwM0djRUxQRkpVaFd1Y0RsVWNzMHRNUnJ1S2svdDFiNWhmcGxOYlFB?=
 =?utf-8?B?b3RsNmtRN0hlVDJXbVJnSzNtL2w0MkNCN2xVbERIUE1Jc2E5QjFyRmRDcGhU?=
 =?utf-8?B?ZUtxQVB5K3l1d3dyNW0xcG5PK3NGakwxelhDVlhtZW9PSUZ1aXlSbWJuVUxh?=
 =?utf-8?B?TEtHNmJqZGJyeFdqblBOZ2ozZTZrVUg5QkZEcmpKRWFOaUo2ZmpXakFwMTBh?=
 =?utf-8?B?UGZ6eTdXSmM2MFcrNGpGWHBGZDJCMFN1andIV3k1K2FRS2xTbkZFMlovRmNY?=
 =?utf-8?B?NDJaQ1FtYm1kcDdVQXR4L1hGZEdweXJwdG1hQVpsM3F5Q1E5TitQV1RmbG1R?=
 =?utf-8?B?QlZMS3VMSHBveHdVTkx1bjFXQktBRmwvNVV3QTJySkk2dkJ4YWhXMDJUeVB0?=
 =?utf-8?B?M0UwQ2FhZDdLdUdrZm91Q21mUW1qV2ttTWVKeGlCbkZMMHA1OG85TS9QaUxB?=
 =?utf-8?B?N1pzTTM5dEY0a3Y1YTlxS2RDcEN5eVZNT0hhM2JKVVlZRFBWc0gxOWNXeDdF?=
 =?utf-8?Q?2w0s5v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2025 06:33:08.9298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97479562-837f-45ec-005c-08dd7e42e293
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680
Received-SPF: permerror client-ip=40.107.220.71;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=NAM11-CO1-obe.outbound.protection.outlook.com
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



On 4/17/2025 9:51 PM, Alejandro Jimenez wrote:
> 
> 
> On 4/17/25 6:19 AM, Sairaj Kodilkar wrote:
>>
>>
>> On 4/17/2025 3:47 AM, Alejandro Jimenez wrote:
>>>
>>>
>>> On 4/16/25 8:14 AM, Sairaj Kodilkar wrote:
>>>
> 
> 
>>>>> +
>>>>> +    /* DMA address translation */
>>>>> +    bool dma_remap;
>>>>
>>>> I think you should use this flag in the remapping path as well.
>>>> I am aware that you are using it later in this series to switch the
>>>> address space, but current patch will make things inconsistent for
>>>> emulated and vfio devices (possibly breaking the bisect).
>>>
>>> The change in behavior happens only if the user explicitly sets dma- 
>>> remap=on property in the command line, which is why I made it off by 
>>> default.
>>>
>>> To eliminate the possibility of using dma-remap=on before all the 
>>> infrastructure to support it is in place, I will move this patch and 
>>> [5/18] to the end of the series. Does that address your concern?
>>>
>>
>> Yep, That works for me. Its always better to introduce flags at the end
>> of the series when we have the infrastructure ready !
>>
>>>>
> 
>>>
>>>>
>>>> Also, is it a good idea to have default value for dma_remap=false ?
>>>> Consider the guest which is not aware of HATDis bit. Things will 
>>>> break if such guest boots with iommu.passthrough=0 (recreating the 
>>>> pt=on
>>>> scenario).
>>>
>>> That is not new, that is the current behavior that this series is 
>>> trying to fix by adding the missing functionality.
>>>
>>> As far as the default value for dma-remap property, I think it must 
>>> be set to 0/false (i.e. current behavior unchanged) until we deem the 
>>> DMA remapping feature stable enough to be made available for guests.
>>> On that topic, maybe it should be an experimental feature for now 
>>> i.e. "x-dma-remap".
>>>
>>>
>>
>> But the current behaviour for the emulated (virtio devices) is to have 
>> dma-remapping on by default... I still think its better to have this 
>> flag = on.
>> Honestly, I am confused here...
> 
> The dma-remap property is meant to be the global on/off switch that 
> controls whether any/all the code changes in this series have any 
> effect. It is off by default, so the new code doesn't run and behavior 
> stays the same.
> 
> This example case you mention:
> 
>  > guest boots with iommu.passthrough=0
> 
> is already broken today if you are using the AMD vIOMMU with VFIO 
> devices. We cannot stop guests from doing invalid things if they choose 
> to do so. Following up from what you said above:
> 
>  > Its always better to introduce flags at the end
>  > of the series when we have the infrastructure ready !
> 
> and we only enable new features by default once we have sufficiently 
> verified them, otherwise we risk regressions when launching guests that 
> have not changed their configuration (i.e. explicitly opted in to the 
> new feature) but are now running the new code/feature.
> 
> Perhaps I missed a different scenario that you are warning about, in 
> which case please expand...
>

Understood. Thanks for the explanation and sorry for the confusion.

Regard
Sairaj Kodilkar
> Alejandro
> 
>>
>> Regards
>> Sairaj Kodilkar
>>
> 
> 


