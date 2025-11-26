Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA22D10371
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 02:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vO4qx-0008T6-OS; Tue, 25 Nov 2025 21:01:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4qw-0008Sf-3C
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:01:54 -0500
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Honglei1.Huang@amd.com>)
 id 1vO4qt-0002Ur-Eb
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 21:01:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzGGQ9FIH/SOj3ZVn1YECuE4x5KdGw4Q5JIPI29kaBPDnxC7cL2LzztwWm5O5EdKN93G0n7pED5lFBLUpmqIYlh2z2FadBScftY59VMJOCDWF0t08LMTWtW3Hd5qbDPuZkLJsKUSkmWPdpbnJw/rHybLw0dl5b/IeY3FQsiIOj2NxCb8YGmusQK1CWXeybMYMF3xutyyncD5m4FIpbDUHIjYb9uxMm7/YvFbyolK5zd1cAMveHdKyZYnAL/7YYTN+oDh/SszIHpy4m0A0n8x+r/RNGOesSLQgL12278JCgDXi3lgzGj4OWU5s34cllKX1pM1a19peVtfayH7kVv1rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyqyWytiBiRie4FG7zHGN6UnqnMJnB4SZN5b8Ma4bOE=;
 b=vB6QKpZScdrWFAM81EQ1JVwR/ayiEWCsIrFcNMX5DrIPbM/vZZ26JBNUMPRlTMfimHsGkxLDC7nO9D622YA4ZWd1YLT4pvHxf8TizhPDyPtdqKI847HO6PnSqBdAdG9MWPpgTatP6HTG74Oqgc5eiCLP1JMxYMIH+G61AMPUXTnzqndSpGQVxY2iHAOyuOCQuWfqhgiD+N8/dNjuWtE3hMr0rijiMigZ99LwFy3I9ipWzxF50iQH3/OYaFTuJvrRFwNa2twkhrf4/5mZkawOtwhW8aUmadwIbdDDJvVmBQXibINqytwMb2cmX5lnpakCBmGfzo2fmM6MxaiuY1VY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AyqyWytiBiRie4FG7zHGN6UnqnMJnB4SZN5b8Ma4bOE=;
 b=Eq0Iap+GlniG7J0GU0Z8vGyC26vj8waB/k6ZozZqYlTZIsumUKgpG1W1t0/kuOPiDx+txWXyqD+Vqf+UQK3KI1DZpmvJmcV+q1p7U0G31v7TM5nUZg9gDzx8zpRbsNuWCVeQj55eiSVbmHyV431PhurOLewqdT+xqyZbNxJNUco=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Wed, 26 Nov
 2025 02:01:44 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::273a:80c9:35fc:6941%3]) with mapi id 15.20.9343.009; Wed, 26 Nov 2025
 02:01:44 +0000
Message-ID: <7c464405-23c5-498d-be6e-a493f6981d0f@amd.com>
Date: Wed, 26 Nov 2025 10:01:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [v5 2/2] virtio-gpu: use consistent error checking for
 virtio_gpu_create_mapping_iov
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com,
 qemu-devel@nongnu.org, Ray.Huang@amd.com, odaki@rsg.ci.i.u-tokyo.ac.jp,
 alex.bennee@linaro.org, armbru@redhat.com
References: <20251124032423.227712-1-honghuan@amd.com>
 <20251124032423.227712-3-honghuan@amd.com>
 <5d48ae13-eb21-440a-a604-9f90a8e9c11f@collabora.com>
Content-Language: en-US
From: Honglei Huang <honghuan@amd.com>
In-Reply-To: <5d48ae13-eb21-440a-a604-9f90a8e9c11f@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:3:17::15) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: fc6b1bc6-e4d4-49c7-f989-08de2c8fbf65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eWJlb0ZTN051Q0hybVRrejM5eGpKSC9GbE02RHo3c21oT2Z5WWFzRWtLeUF3?=
 =?utf-8?B?OHZUNmpNMGhTaDF4K1BlK09XMzVDZERvb0tzSTE3S0llQ2puUExZOWpkRFo0?=
 =?utf-8?B?RUF6Mm5SM3VrR0VWSnk0NmY5S2FQTFZFMjliWEJxSG5CY0Q5ZGN6SWxvSHNq?=
 =?utf-8?B?Q0EzTTJUbzJVZmU2dVMvaFZuaHJ4WTBZRnY3L2xsUnlvZmF1SU9XQnRLVHZN?=
 =?utf-8?B?NXBINWo1RW5la1U1UUlQNktIdDYzOUVnRU9UNk12WDNlcFhQU2R1VDRBdnlp?=
 =?utf-8?B?S0t3bW9ReXlESXdMSGNuN3ZpWjJuY2VkcVkrdE8wdDJ5ZzRydUl2RDhWYzNu?=
 =?utf-8?B?dWRUd3VKeHNsaU5qVkpyWUEySGdSNFZpSTNGN2dlcGt5WEo0MUd5SHpaeDU4?=
 =?utf-8?B?TFhMQXBOeldubkJaNzVjOE56RE9HV3FJWFBEQVhKYmQyekdUcWFKMFBpbFJS?=
 =?utf-8?B?U0ZlV1VESE16WndpTmluSDFVQTZUTTdKOUVOME9VelBpMzdkbXY4RCtqUDJq?=
 =?utf-8?B?VC9seEEyVkhNQS8zelZCenFGUThwRzF1YWJlM2lOSUZxMHVFeS93QmR1Q3ph?=
 =?utf-8?B?bGlYOHlNbXc1TEI0cTJvMURXNGo1Y0RjWkViYjNVUEdqRnhmMThaREcvcjFX?=
 =?utf-8?B?TC96M2N3c0hzaFFXTW1VRjRGZkQ3eGdVR2ZtSjlYS29kdUh3dWc5KzZkL2sw?=
 =?utf-8?B?cWtNKzJXZXhFU0U2Vk1JbzJjcmdTTmFYMzVqTEhkSGg2ZzIrdjdKWFpXZVFl?=
 =?utf-8?B?WjZmbk9sNjdJbzdmbFpvbm9zN2VNOEcwMVIyRjEwYkVPWFlMeEdFUjlJd2Vx?=
 =?utf-8?B?VVZwdmNvajdVOTRzU0t4MXdtNXZPTzEvMEN6RHNTVXpxbEZkRTJUT1lUb0ZW?=
 =?utf-8?B?bHFrWmk2WnFYbTNHaE9mdW8xMHY1WDZrMHdlUk1BeDl4aUM3SVBEZTkrblZN?=
 =?utf-8?B?TVZVWE9EMld4eEY1V1EvOVpwZEpIaVpzeW9IUmFLWld2ZW9rc2lNSkUxS0FE?=
 =?utf-8?B?UHh3YU9SVldNOHRYRFdKTjlIck5zcUlERjJ0bEhtdVVVbVhuYi9NQncxOTA0?=
 =?utf-8?B?aG56aFQ1RFVhRS8xeFlaQ3pWMGJ2RklFUzMrY2FHWktjVm9IUm9zajByVmRr?=
 =?utf-8?B?Zm9iYis4Z25UenZuRWt0R3RnR2hKSVJZenRtUW5MOWRBMC9WRzJTOVFFQmsw?=
 =?utf-8?B?SDk0ZHFLRFk3dUs2WkYyRzc0YUxtVUVQNmpZcnpFcjNQcE1MaHI0WkY5eWVz?=
 =?utf-8?B?T1pDUUlGMTlLejhDVER3aGorUi9vSVpSaG1XZkRwV1lJZXkreVp2dXp6VEFE?=
 =?utf-8?B?VlcvQ3grakFSRlV0eHVScXRxTExDM1BEeTZFMk5nU2djUVREdW5ZZmNJUlB5?=
 =?utf-8?B?ZVZlZTUzTC94TzcwZ0VwcS9Xa1JXcGQ4eE1Lb0N0NDB1MEZOVDhXaFpaL2Rk?=
 =?utf-8?B?MTljcWY1S1hFU0UvNDhNekZIU0g1czFVZm11NU9QNDBTaWdBam9aYVlVQUFC?=
 =?utf-8?B?bkovdHhVSWczSmJFd0NVdkhxT0lUcS9kcS95cExla0RycEVOYzBTWFh3NkEw?=
 =?utf-8?B?RENuUTRxQkFJNnJaeWxxOEtKczFJaklQc1p5eXQzVHI3TUMxTjNqb1NrV1Jx?=
 =?utf-8?B?T2Q2ekdjZ05ZenFqTEVuNnBFcnBjUGNZdGFDdW53amdYWXBia2ZBSm02bjUx?=
 =?utf-8?B?MUdaY25RVllYNndFMEw4eTkxeHhZZlFaN09HdzI2Sit6ZE9INldXTTJwMnZG?=
 =?utf-8?B?MTczNE5HQjhaMlAwZDZVL1A0UWxoUVhqemt2RnEzemxnRGhab2NFVTAvNStP?=
 =?utf-8?B?bzNEQlYzUlBQNitFRHlCdjN2ZnR5UDZwUVEvNS8veUhkbVU3SHpkd0RjRGRO?=
 =?utf-8?B?cUNRMS9zOVpiQzlzN3lFSW5nczZ1MTFhYk1LejBiNVVBQ1JZK2tDNzNnYjdM?=
 =?utf-8?Q?8Is5v8KnfMtiLrggZvMyYuIMPtfHDcXD?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHI5TVhlTWR3S0JhaWRDY0RQK2VpU1BWWjdqb0l3Q3RnVXk2YkRPaEN3aG5j?=
 =?utf-8?B?cUE1WWFMYS9acTgvaXRNWkN2WmZ1TmdQREU2THVodTRrdVBWN2ZWSTdtNmFQ?=
 =?utf-8?B?U3VBVWxzZ2d5REE1N3NtQUZBUXl1L2hTSWlwdjNUY1RVdkNBN1FDRE9iSTZ1?=
 =?utf-8?B?RHR5d1FhcWlFWVBUT1hsRnoyRkFrV29MbG5pODhwS1JDaTJmREM5SENRUlZG?=
 =?utf-8?B?V3ZiMktXQXIrNU5SckcxdFJ0b3FmTTZSdmxwYjhhRG5yMVVFZDM3QzdBbzFS?=
 =?utf-8?B?bkR1eGw1QkR3TFZoNTVyUlkxSEMxNVc5REZMbFh5VlpVKzd0cm9BZTFSajJ5?=
 =?utf-8?B?RjFyMGw4VExyRnBPbTFmcmxSajhtMVVKUFBzc1lnWlk4ZUJaT212TXpKNHhH?=
 =?utf-8?B?VkRKL0tWZEpVQmJUNHFFdlpNL0J2QmFwTFRucE9ra2J6NEtSRUdUR1p0U05B?=
 =?utf-8?B?WFRMTC9kR3d4QmV1dk43bGtJTmY0ZFVSUjlyZFR0UEpoejZEMlhERk9WVWt1?=
 =?utf-8?B?TVo0em5qOHR6bUM1MkxtQW9JMCtaemthNVhtMDNsZXZtRG1kOWRIb1pxVC80?=
 =?utf-8?B?c1RMSTVrbWhSQTZVM3RHUzJ4SlFaR3cxanNrekdlN3hHMHJiY3RvaDNxSWZ2?=
 =?utf-8?B?bHM1a3NrcWFTZXJqWWhEMGEvZ2ROVlVkTkpDb3ZXVHloQmJPS3JYR09LMFpQ?=
 =?utf-8?B?MXRQdW9xdjNEU0gvcGI4clJ1SldmRFduREFzZGtrWi94ZWNpSmY1a0ZKRUVQ?=
 =?utf-8?B?TGdXTTNuOEptOUcwb2lkNnlHcE4vTnNlbFoyQ0IxS3diYjI5bnBJdnhiQkl2?=
 =?utf-8?B?MjFreGZaNkExOW0zYXhPOFRzWXF0VzVWR21HdFVrMVc0M0ZUV0ZMZ0Q1RVAv?=
 =?utf-8?B?OENaNWZKZWcvN3BlZWpqQTFLemdzUGNEMXV5MmFqTUdualVuS29nRXQrYkNG?=
 =?utf-8?B?alBuSG9QVSttVzJwdnl2bGt3Y2g1VHVscjhzODZQVkdxQzF5di94M1RUeFBN?=
 =?utf-8?B?VUY0NWVXQ2tBWndTVGpIaktMNHN1d2ZpRk9pdkQ0bFN2OVMvN0ZTOVlmNnh0?=
 =?utf-8?B?UzZyWGtNZ3hYME5wcGNtS2pScHpkeCtaZTV3VTgwTW9RN2JRUTlNd1diRHpE?=
 =?utf-8?B?QUNLelhOaElzaUluTlBObEdNTVl2dGtvelRUK1J3V0VtaG91d0gzT1MyaHBk?=
 =?utf-8?B?MmRLNExxM2M4ekNkT1c1UGdEQ0xBaVk2S05vY2NHRC80dXc4cjVTYmM2ZG5P?=
 =?utf-8?B?MVdlZ2p0dXBXZWRzdVI3NzdlRE4zZWN2eTlvUFhzK0U0SjdUM2R5TUFUdGhk?=
 =?utf-8?B?M3ZnbnR3Umg1TTc0VHIxYTdlK3JXekVsYnh3UnByczFLaHJIck1Qb2ZyZEs4?=
 =?utf-8?B?WktvM3I3eTFhMVNOSENnbnBQMTBHa1pyOS9WSVZ3TXhla2ZRdmNndkVJcUwy?=
 =?utf-8?B?RWZDc0FHeWRHejlXK0hWa1BEWXNpL3lOVnRCemlZeVVNcGdsbzBJMkYrdFVa?=
 =?utf-8?B?dkxKNVlYMUlMUmkxMnA4NjBkVmcxdVZHVjJkanAyM3FuWjExbmxZMnFxclda?=
 =?utf-8?B?VEpvdXlRRzZjZ2xmOTlIVUQ0cFF1d3N3Vm9lOUJKQjk4TTRVQnZkSG9hbVhC?=
 =?utf-8?B?K0hmRVJWQk43eFZrU0ZHY3d4L1phTEZYVy9IUFpqd3MrUkhGdDRSZUlxK3JT?=
 =?utf-8?B?ZEFzVHZYTFgxdEthNnl3d201bXpON3duVHlBUVhMZlZUVmNESkNVYXRNZXNJ?=
 =?utf-8?B?ZVVKL0pNcXlaQVUzVmxqS296RjRlc0ZacnhZNEp3ZE5SNXJ4YmZNRzVTdHFx?=
 =?utf-8?B?YU5XU2NWUVdJSWdleE9MUXpWWjVqdFdZWUs0UzR5TTMxaEdyL0c3WjAzTENJ?=
 =?utf-8?B?d0tlZGtRT3ZNYUhUSXR5WDkrc0tKY1dzaEwwNjBBK0JtcUpzT0JtWTA5ZHNx?=
 =?utf-8?B?cDhTbFhhQ0l1M3dGSW9wRnMrRUNnWmhWTVNjaE41SDlncXlUc1JCaHExblEr?=
 =?utf-8?B?My9SREI3YXlCbXpOSnhGZVZnMks0N3JkcG5HY1JLREtYckZiVjI5VitiQyts?=
 =?utf-8?B?dnlhTmFRR0MrRVpjUlRWZzJTaU1EcEZIMW01bElYMmxUekRlTVFhdjFZWUtG?=
 =?utf-8?Q?P58ToH/kpv5KUi3s8Pb/2Wvfb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc6b1bc6-e4d4-49c7-f989-08de2c8fbf65
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 02:01:44.0593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MgLAWeOSO9zkqMKXgZWEqLmF5xNotdoU8e358IIjuvZiQH/36LKtTLsSPIe69ixElcxn55DPq2vhu2FGZhsOYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=Honglei1.Huang@amd.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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



On 2025/11/25 05:31, Dmitry Osipenko wrote:
> On 11/24/25 06:24, Honglei Huang wrote:
>> diff --git a/hw/display/virtio-gpu-rutabaga.c b/hw/display/virtio-gpu-rutabaga.c
>> index ed5ae52acb..ea2928b706 100644
>> --- a/hw/display/virtio-gpu-rutabaga.c
>> +++ b/hw/display/virtio-gpu-rutabaga.c
>> @@ -466,7 +466,7 @@ rutabaga_cmd_attach_backing(VirtIOGPU *g, struct virtio_gpu_ctrl_command *cmd)
>>   
>>       ret = virtio_gpu_create_mapping_iov(g, att_rb.nr_entries, sizeof(att_rb),
>>                                           cmd, NULL, &res->iov, &res->iov_cnt);
>> -    CHECK(!ret, cmd);
>> +    CHECK(ret >= 0, cmd);
>>   
>>       vecs.iovecs = res->iov;
>>       vecs.num_iovecs = res->iov_cnt;
>> @@ -616,7 +616,7 @@ rutabaga_cmd_resource_create_blob(VirtIOGPU *g,
>>           result = virtio_gpu_create_mapping_iov(g, cblob.nr_entries,
>>                                                  sizeof(cblob), cmd, &res->addrs,
>>                                                  &res->iov, &res->iov_cnt);
>> -        CHECK(!result, cmd);
>> +        CHECK(result >= 0, cmd);
>>       }
> 
> The ret < 0 part looks okay, but ret >= 0 feels dubious to me given that
> this func doesn't return positive values.
> 

Will remove the ret >= 0 check according to your requirements in V6.


