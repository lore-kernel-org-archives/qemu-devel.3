Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F499CD4F39
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNaKL-0000gf-FG; Thu, 14 May 2026 13:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNaKJ-0000gL-TZ; Thu, 14 May 2026 13:58:27 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNaKH-0005i1-U0; Thu, 14 May 2026 13:58:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QGEaq8VRD6T9DSJoZXGWiV8k1b1jOh6nWKB/bJrokKXOFV8H7cc5etcCnsFel7qP38IG9oYgROGc9QY2NHNl1slxPPgXVem1kdJVMq6cTUx9SIqNFhpkOrrS09YeOcGXfDffw7lg07aV+Ck+AD88v1RJLsZUEGv37fVcdnod2GMRA0/YtcZNBsWIeK8Ej/ExACx/X+8+UOBAgo8+b4q28rwZCLfGGLE7y4LKLBwo4nk2W3I2MVAg6AzPGQmbALS62xphRMrV0XIx2slwR4045GPMxclqHAgAbkD5V6efuvOwOHtaUcN/BSltZ8PvLMf9uT/iFoFmmyk+3N3HCly2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DMq9XWsDASNWm40nVZrK+m7ps5vKEuD3Ih9CExLrz/Y=;
 b=i173fyOoFYYUl/XXuXdqeWaTSxCYmLajlwJNkFVoTBV6xW0BfB4L5B/XfEtDxXDCP58DF76kTSlhja6S4snZniDgUhrWjpJF3PAXEV4EXuOnYfhp4tf7F8QXIDVSmBjaZ13we+JfTD9tLWcXc4w0nysT5lLeat4WQDGgWVDbsxF8K4b92f6VCGDSvLI3hKoUb43kfTuqYg/cgGqO9sLgoiXsY5JoTW3AOhTsPE0SXFgJOgCWhDLMn4yEzTMJq9GuSVbiQpaI96RG3XYcLWrH23ZJZOPCLpA5VZO8kTzLrUJgbgfVuRCfs5tlAP1CQqrq4RJbhmQ12aqj8/r0BKY/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DMq9XWsDASNWm40nVZrK+m7ps5vKEuD3Ih9CExLrz/Y=;
 b=dyR8h4ZqKrOA1CLTRA+sENfWBC3X36FcVv23txC6091eklv20LxDFNAr9OaYuEyyzmK+qGq7/nuCKaq2sBzdwtR0LJyd8jv0xh2OZJiXppzyjoc294fZv0J4a2Tk6eU3f2QjOjbnfSdO2urAm90WnG3SuuHcBdoOocpc+bnQVj0Y4qeQakTTgJbFPnxr4aXRRKJ1ibYfwwfi0OcbHKYl7tflHPOVt3DVycxlOk8LHMsIWcM0mtbtHLZGbKnUVX0OIllXkqGHpz5Hz4FEHYI0EvqdJCnPV7EuaY4YAGfhNenYaIri4FobhKFklj00rs8t7DKIaDO9IsEn5b+F0zaDBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 17:58:15 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 17:58:15 +0000
Message-ID: <7bc3907b-f170-4f86-bbc8-24acdc7f2970@nvidia.com>
Date: Thu, 14 May 2026 10:58:12 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/7] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-2-nathanc@nvidia.com>
 <CH3PR12MB7548A1A5114A588B8FFB57CDAB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548A1A5114A588B8FFB57CDAB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::11) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: d0760cfb-31c6-479d-10d5-08deb1e25f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|4143699003|11063799003|3023799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 8maF5hIBrJZPTjmtc0xfhqzLPEqTVwNwSruCYl1VUCOa0DpU0JRYfez3/n1NBkylBcRWztSJzFo0KPW6qEtLN8FkhUNHmVoCjwrWnQLftbQBm3jtF2y8+az/sfkXLMiiJMSVHTxn7DrBzEviShoDnSWvaMeghWp/RibJS2SMGYQxLHOqdCoamInrl5vkuEYCqn4qPzKz8VaMzSnR4CuZ+uT3rEvkJN55AqdFukADzrSf8lNKBvqpbExlKGFASGafZUDDYXCh0mbY/fgjUUB6+imZeXECq6S7RVOrnNUtA/SdkAwAabHkNrtjBXt53NtY1YSLARE3N53dG8KvWPSbGbJaKAS0YJYsooS7xhW2ooCzmQhSaVMt28GmSEA14FXe+UPbuMBUUasJIZktehpaDXHTqFSkhbn9LILbh8UOh91DjJdjyWKUvQ34wzZW/+SRZvx2zVjEv9LSQMwsmmnNPG4m+mOfV/seIwE3jOyW4cKEO1zEd/SubfyLdE2//pc8FDwhc5J9rKPGbhJwSjO5MoB7T6D5UF1VoGckh6rRxixtFrbl9b5Kpsf76+7VEdp60JRL++Tz5Q54sxbe5fjs+kkZ3actvbzs5/5DaunPCNjx6bNgRuzG1JYM8N0hnQfA2TlNWaYhHBfDhPfXDW6Cn0BNgbRdXUjYidwuE3AzVXIr9IlTl2N5x1CXplsq5yJc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(4143699003)(11063799003)(3023799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXhVNzk0NjBVMnBOMUJPdndiNi9YZ3h1a2lKblBHUldLV3ZwTHVyOWZMQTJT?=
 =?utf-8?B?SzJlUTZMWHhnaVZRYjh5Z3ZNaDMxTnNHUVdNT2pXc3BuRm1HTThTQVNLZW5a?=
 =?utf-8?B?dFVKVmhtYzUzTmlDekl0dEJMMkE2dWI3NmZvVHdNTnNKck1DaUNIblRLQTBm?=
 =?utf-8?B?TnpMT3pyc01ZVmdNUitDd1p0NXkvWTRycGFGRTdZTnBIcEUrK0NkblVPak1i?=
 =?utf-8?B?ai9PR2NyOXNCMUVPUFBlVXZuWE5Dcm5ZcnhMeUNONjlOSGFQVEJDdmtLV2p6?=
 =?utf-8?B?K0Q1MEtRZllrTUJneUthUC9mYzVGRmpZVkF2TUR6eXNFbk5sWnBhTzVrcGM4?=
 =?utf-8?B?amRHWGt5enZDSjFRKzJnb01yaXc5MTl0SGQ1YzRlMFFLaUhUaEhPV3pVNEFU?=
 =?utf-8?B?M1IzemFvLzdQaktaU05XbVEyVk1IUFp4VDZjSGl6SmRHVVMxUDR2U3JZWVFL?=
 =?utf-8?B?UWFsU2wzN1JFcUhWTUs5d04rbnN1NUVVS3hYYnlMcGsxMDFUTzhtYjhud0Q2?=
 =?utf-8?B?VmJOZ1JBSXdkT1BqalpoNE41SzBFM095WUhaclhYVjFiSHZLcG92NllNaWZ6?=
 =?utf-8?B?WFprWUdnVG9CNEx5TWhjSG1tdGw4akdTS3lBMDBLWlBOazMyZTNxVDM3NDVT?=
 =?utf-8?B?ejZmV2cxSXNtRDZYLzZhYm8wbXdGbkczQ2pPUjVMak9idzhBVzZFemQ4R2VO?=
 =?utf-8?B?aXV5L2xNSlpKUVFuRkR3VmlVbmJrMzgvdmlMb1JuY0xJK0VaaTI1SVA1bGUx?=
 =?utf-8?B?VzgvblF5Q1VHNTllNmVDbFhjckh4UHJrTm1MMmRwajlnbEI2WVkvS2x2bU5W?=
 =?utf-8?B?dElZTDVFcnNWU0YrWVRmay9BNDFXRmhjWWVxcUtZdVJ6SkE3SXdtclI4dzkz?=
 =?utf-8?B?dkNGWVRJcG9JVGNobzBURVc1NzZ0OWV3bVRxY1NhMDJrNWZDS0Fkeng2N3Zk?=
 =?utf-8?B?TTBpWGRnbllrT1o2a0RyTjVNTVliNDd6RFY5SVVRaWloMGcrMEx2djN0TVYv?=
 =?utf-8?B?QTNHaUZraUZvaitESUlLK0dSN1dadXVuU2xqMDJncTRpZkYxMWdkQ0hBZmtE?=
 =?utf-8?B?NnlYTnd5NUlOMzRVbEltaDNHUmlqNlNlaXkwREFLb0pIQ0pyQ0NwSnk2TXlO?=
 =?utf-8?B?Q0dSTEtDV3VOYXJ3L1dMMnc0a2hOUFFxU1Rvd2t3djEwdkhNWGJab2xoK3l3?=
 =?utf-8?B?NjZsNUFDb2JtcHVhS0NRdldkREJCa1NCZlIrSllCTTRweVJjSElnN2ZZbVpv?=
 =?utf-8?B?bGNNczIwd0hIY0NnN2tkbWI5QzRkR2JCNjlXVktvTGc5azVzQzJSeTNUZU15?=
 =?utf-8?B?R3dtclBEczBzMmNEUWU3eWhpdzQvdmFoOHExaGZhZTREZktWTjBGbmdyWENa?=
 =?utf-8?B?eDdicHAyZUljUzcrN2FyTWtDSjJHK2NNNmxJdmFoSW1hUjBwYmZScGhPblhu?=
 =?utf-8?B?UDhCM2RWblZwdm5PODZxZzNoUVRITkk2bDMxVzNWUC9aRnlNczRQeU1wck1l?=
 =?utf-8?B?ZUZaNklONmxDZ3dqanJUZ3Z2bnhvRkJEQnlVNkxuTHllU2pTU2htQU1EUHhh?=
 =?utf-8?B?NEtCbzYxazJZTTZKU2R3b1FFRVRDcHVvL2FGUU5UVlgyWFVUSmZ6RmZtdjFK?=
 =?utf-8?B?UjNia0dxWE9VY1NDVW9ZWE1vWHQ1bVNNM3RRdk5PVTJRa240b0NRN3FnT2xI?=
 =?utf-8?B?WnVVZko4cmt2VFpVZTVIRTVONzl0ZkpBNUUwUWdPUW43WGVVTStzOXNQRDBS?=
 =?utf-8?B?UEw5L1hobDBZb1g5eGpRYUZJRXBWT2g1bkhEdyswT3JJUStMaHFqVmtiZXZa?=
 =?utf-8?B?czFpWjFkNURWWmlBei90VEg5WGRuSjNRRVd0ZlNrZTNyQnFsQy95Mjc0YlRo?=
 =?utf-8?B?TmFueEJJWGkxekExWFZoNHNRTGs5amFkaVBVWU5WWk9uZXFGallXS0xWM3Bu?=
 =?utf-8?B?L1JKeG5RWThMcEdEUXhWL2w2a0kvQWVlemN2YnhhR2tUbXRKeFhOYkpFOHNT?=
 =?utf-8?B?T2E5RkNtMWxvU0xja3BwbmVDSUwyYVl5S2tGSld0ZUlubEtKaVR6QnR2bGNr?=
 =?utf-8?B?RzNKWENaVktSSitHWWdYVEtYV1drd0paSzVBcmtwOEoxTEIvWFIyay9Wd1Ry?=
 =?utf-8?B?dTVFaW1nam5VSXliK3M4cVYreGQvQ20rUTduMmhSOU1pNUt0cDM2N0VmeFpV?=
 =?utf-8?B?K3ozLzE4ajRJM3BOckVPNlU0anJVWk81T2V2ZmorTmQ3OFlrNzk0clBsTVQx?=
 =?utf-8?B?Qko3USs0di9Jc3FvRjRMajc1WGdVMVh5Rzk1YlRXdEl3ak9GS2k4N0t0emcr?=
 =?utf-8?B?VW1tZ0hOc2VRQjYyYXoyVjZORnJzZUV1dytGTWlNRVlINlNVWDRoQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0760cfb-31c6-479d-10d5-08deb1e25f01
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:58:14.9750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t4JSjl3Mby/e6b4b5cr8VL9sYf4bBPdN4kS9Nb3YF7gTAkJLX89HNbzWzp6QA4Yck7yFiE6z1xtTfyl0GcmR4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/14/2026 6:41 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 May 2026 20:35
>> To:qemu-arm@nongnu.org;qemu-devel@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Philippe Mathieu-Daudé<philmd@linaro.org>;
>> Zhao Liu<zhao1.liu@intel.com>; Matt Ochs<mochs@nvidia.com>; Nicolin
>> Chen<nicolinc@nvidia.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v3 1/7] hw/arm/smmuv3-accel: Add helper for resolving auto
>> parameters
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Introduce smmuv3_accel_auto_finalise() to resolve properties that are
>> set to 'auto' for accelerated SMMUv3. This helper function allows
>> properties such as ats, ril, ssidsize, and oas support to be resolved
>> from host IOMMU capabilities via IOMMU_GET_HW_INFO.
>>
>> The later commits in this series set the auto_mode flag to true when
>> an accel SMMUv3 property value is explicitly set to 'auto', or if the
>> property value is not set and defaults to auto mode.
>>
>> Setting these property values to 'auto' requires at least one
>> cold-plugged device to retrieve and finalise these properties. If the
>> auto_mode flag is true, register a machine_init_done notifier to
>> verify this requirement and fail boot if it is not met.
>>
>> Hot-plugged devices into an accel SMMUv3-associated bus will re-use
>> the resolved host values from the initial cold-plug.
>>
>> Subsequent patches will make use of this helper to resolve 'auto' to
>> what is reported by host IOMMU capabilities.
>>
>> Suggested-by: Shameer Kolothum<skolothumtho@nvidia.com>
>> Reviewed-by: Eric Auger<eric.auger@redhat.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 44
>> +++++++++++++++++++++++++++++++++++++++++
>>   hw/arm/smmuv3-accel.h   |  2 ++
>>   include/hw/arm/smmuv3.h |  2 ++
>>   3 files changed, 48 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 862be814a0..82c0800f4d 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -18,6 +18,7 @@
>>
>>   #include "smmuv3-internal.h"
>>   #include "smmuv3-accel.h"
>> +#include "system/system.h"
>>
>>   /*
>>    * The root region aliases the global system memory, and shared_as_sysmem
>> @@ -35,11 +36,32 @@ static int smmuv3_oas_bits(uint32_t oas)
>>       return map[oas];
>>   }
>>
>> +static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
> Nit: Move the opening brace to its own line.
> 
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    /*
>> +     * Return if 'auto' was not set for any accel SMMUv3 property, or
>> +     * if property values were already resolved from a previous call
>> +     * to this function (e.g. if this function was called again after
>> +     * VM boot during device hot plug). We do not accept new property
>> +     * values in this case where auto_finalised == true, and we re-use
>> +     * the values determined from the initial cold plug.
>> +     */
>> +    if (!accel->auto_mode || accel->auto_finalised) {
>> +        return;
>> +    }
>> +
>> +    accel->auto_finalised = true;
>> +}
>> +
>>   static bool
>>   smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                                    struct iommu_hw_info_arm_smmuv3 *info,
>>                                    Error **errp)
>>   {
>> +    smmuv3_accel_auto_finalise(s, info);
>> +
>>       /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>>       if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
>>                   FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
>> @@ -918,6 +940,22 @@ static void smmuv3_accel_as_init(SMMUv3State *s)
>>       address_space_init(shared_as_sysmem, &root, "smmuv3-accel-as-
>> sysmem");
>>   }
>>
>> +static void smmuv3_machine_done(Notifier *notifier, void *data)
> smmuv3_accel_machine_done() better.
> 
>> +{
>> +    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    if (!s->accel) {
>> +        return;
> Not sure we need this as we only register this for accel cases.
> 
>> +    }
>> +
>> +    if (accel->auto_mode && !accel->auto_finalised) {
>> +        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
>> +                     "at least one cold-plugged VFIO device");
>> +        exit(1);
>> +    }
>> +}
>> +
>>   bool smmuv3_accel_init(SMMUv3State *s, Error **errp)
>>   {
>>       SMMUState *bs = ARM_SMMU(s);
>> @@ -925,5 +963,11 @@ bool smmuv3_accel_init(SMMUv3State *s, Error
>> **errp)
>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>> +
>> +    if (s->s_accel->auto_mode) {
>> +        s->machine_done.notify = smmuv3_machine_done;
>> +        qemu_add_machine_init_done_notifier(&s->machine_done);
>> +    }
>> +
>>       return true;
>>   }
>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>> index 407940616c..87fecb5c68 100644
>> --- a/hw/arm/smmuv3-accel.h
>> +++ b/hw/arm/smmuv3-accel.h
>> @@ -25,6 +25,8 @@ typedef struct SMMUv3AccelState {
>>       uint32_t bypass_hwpt_id;
>>       uint32_t abort_hwpt_id;
>>       QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>> +    bool auto_mode;
>> +    bool auto_finalised;
>>   } SMMUv3AccelState;
>>
>>   typedef struct SMMUS1Hwpt {
>> diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>> index 82f18eb090..fe0493c1aa 100644
>> --- a/include/hw/arm/smmuv3.h
>> +++ b/include/hw/arm/smmuv3.h
>> @@ -74,6 +74,8 @@ struct SMMUv3State {
>>       OnOffAuto ats;
>>       OasMode oas;
>>       SsidSizeMode ssidsize;
>> +
>> +    Notifier machine_done;
> Better to #include "qemu/notify.h" in this header.
> It may be compiling through some indirect #include now.
Ok, thanks for the feedback - I will update these in the next refresh.

Thanks,
Nathan

