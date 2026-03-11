Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED511125858
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 17:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0NkU-00043B-1g; Wed, 11 Mar 2026 13:53:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0NkQ-00041d-KX; Wed, 11 Mar 2026 13:53:31 -0400
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w0NkO-00068K-Bt; Wed, 11 Mar 2026 13:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CL++1mbqsYiB7ghYoh47XX5XKI4QTPHl68NZjsXtA/yH/xZoU3ST79FjHJxUi1PDR3hqOlPUqvdoPwnl/lr+gYg/u7Do94mhPsdwNTQkRNsCZPIMK/Fl9AwEjIyi1DsOgooLuA3ocPEFuWgWfxLZ6uNZB/oF5ZmTonk7/iWvwX588h5a/ZwgwEa+uQl3YykP61Msbmn54nIaKyn/FaJkCGyWnAXSl6KfuSkpNHUSpIp99pgOpFkS93Ym2mw/tW6rXgnagEQoLVuQoyC+CB+2dhFCehx/QKuFq8TOTDsE798O0LcstsBLMnDD8Q1URrGN9iiequfIthvw2jEihpGSbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bQjCkDCZZMM8q3J9vYkwkIJQQGGzo0GzzdH02eMpsZo=;
 b=BQC71psNPZqEtPNktw3qR57PXYOLkySGF5q9Ysp5V3jdXz58SQBA6Ri0zClYArf6QjK6bUW+F3BOM1imi4jIHTFRERxwvfla8t351bWldTAwFgXy7tDo2nPEL4FHqshBdX8hR6Q1l1URCaVZHGWDAeIL81EkPfF725hbD5hNFwnBvHp9RDOipIK6VNT6Oi1LuUl7vg+7RTveGklgRraoxmXipJPhau44+2JBuAs0QkqI8ttSwilpRUhTMKMnshw+fJZpoNt1cg06XFYzVhRWpht6xQFVC4gqM92Q7+hsmaLlJsZW/bJnGsQM3T8Q7WhnyOjzfPzKcBDU4cVR1Ff6fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bQjCkDCZZMM8q3J9vYkwkIJQQGGzo0GzzdH02eMpsZo=;
 b=hrwO5ZQevU7RPG/lL91MiAxMUvBAO36Snh5p8mrVs7IWAC2w9DqQGwDOllqIhmVcL7eRhFcP3vCyNwDUgKVAJePDtCzGyilW/NVMmXzIjn/yWvUgCtzH3x+OIS4hAglxE/dSrmH+T/T6rqufa455b6sM8G6yStzE6nNp9lsCG3QkzBO2GZFAnWzUAmmWMguyLFhM83BA1NGToBGpBMsItAvRUBfLC4U/fFs4Eq7hUh7ThfiUOOshmWz7mkPCYmssjr9/s9ZpcUfNHvMy6O25YDFwixFjimLSDJ9wykPaEw6fDrywrxrYJCjGWRu0lu5R0H/A3bL1ynT0gntIwwqfcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 DM4PR12MB6135.namprd12.prod.outlook.com (2603:10b6:8:ac::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.4; Wed, 11 Mar 2026 17:53:19 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 17:53:19 +0000
Message-ID: <eb361325-6a67-4834-87bc-2be906ef68b3@nvidia.com>
Date: Wed, 11 Mar 2026 10:53:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
To: eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com>
 <df333115-cf74-4ce5-9393-4cab1013c2dd@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <df333115-cf74-4ce5-9393-4cab1013c2dd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|DM4PR12MB6135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cf6dcf6-a50d-4f46-2252-08de7f971496
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: RrGF+L/Y7yAB3gEaZf8MAs+7rmjITQko99mK7y5EkmDBNA2DX+TRUlGYMGOMEm+bNR9OE3xOI1vTbVAPCgC3V9A12yOYcnClREPoSplTZOm5xFWtbJM0ZIOOvVoZkfsEa+gP08Sj6j4+2mROjGvyhhcrTTlaJUjpAohlU70hpZ5bikQsNyCqQ84hM0fBVqCcsfVpawDiyjTtzDO7QuxAdGKEhERromfCgEEZh0XXm/Eoe97FjKyQjMactWaBvb+HQwhHl1QX/F0aQw2ekQhNpYbYu94HOnBk2S7+UF3hNLMaCp4CvH9U2DdChv+CLpGMW2S70jJk6MWiBUUYcaZ3DCxXya5oUmWmMOqX973MKnIfxynfe6cxVxOxWi2PNDt88xlaUAMs5zBi4Oo8Ezhv681aW0V3wZ7aPvZ4omtKi+meht/rTPEEFulOI3iCAd5JMSO68DclV1ERONcMVVfwcDaJAZxNvIkw/SkHnKGiheNFNEgrRAHeVUzZylSqc2eLy3ZLyvmuI4faz8XKswmzrftuER8TtTZNxEI0g5fiMTVDBGSWf7OO9i0crXEwAZK9DKmT38SJ3wLGoSEm92f+GM5k3UqxuocYTLMZUtxNCLOV0dbBmpTGQ+quOLN5FiDHW5TB7xOkPvu3TZQ4O+COIt48pY+DATd0511bSQ1ojF+bhIGQGBM//udzGMtkF+659d7/pym7v5rQnZIEj1NDkwVwRGYhU3YqbBdZ1NFAVmJsFycuLmzjUEqJ/nWr1GHa
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGRJWmVtZjkwSVhUL20zdFJxMHdndm43cVVIRFhLQ1dvbVM0eGNmVFJvaTFG?=
 =?utf-8?B?L0lwMERCOXlJekE2aDdJaktQL3BlWERwUW1TMHY3TXZPQkxMK0xjUk9oYVBD?=
 =?utf-8?B?VlJjR2lrZVZVVjRsRnJoSXVLandKU2Vqa0d4NzE4aG1ZR1JKTWk3b28wdnd4?=
 =?utf-8?B?MXpQQjZOOXFvRFkrdlpOMnQ0R3kvblE3SXZMNkY5NmVYdXp4WVRHQ0l5TmNB?=
 =?utf-8?B?c3Vnb0lET1h5bDhZUnhsMWM5UUs2aWN2TWRWWXZienBEZFZsMGt2dlpGM3ZS?=
 =?utf-8?B?VVg5UkVKSllhbjJWbTJtZDBVTE03QlpmaTdXZWRGcmh5azVnVTNtam5KbVlU?=
 =?utf-8?B?QnFndXBhM1F0SGpmQ3dDeU9xUE82bzAzbGlzNE5SUW9tVUcwaFpvanVWVEFS?=
 =?utf-8?B?c1hGQXhJNVp4b0UwUDBaK3NTZVBqRkVFenlSaEdQY2pVVVl1ci9QbkJPNlI3?=
 =?utf-8?B?cURFdndBTHdlK0ZUb0lCam5wVzFZS2RJNFVVQi9LeE02WW8zYkIvOXptem00?=
 =?utf-8?B?L2h1MXBoSndTNFZMQUQyR2M5bXM2STlQemVLLzQ2UVhmTXhyME14K3hmNUs3?=
 =?utf-8?B?czI0d0lrWEZIT0hERGxsamRPREsxdkVoOVJZWDNXWCtQclcyVEpQZWRGdGdU?=
 =?utf-8?B?RHhvcnlZbWFNanQ1eGh2aDZaNjhadzAzaUpaWEFiVVU1a1cyaXhqczJjSC90?=
 =?utf-8?B?QmhxODJkRlpLUFArbEcrMTlrS1F6ZE9RK1FKejNMR3hPWHZxNW02T0Z6eFZy?=
 =?utf-8?B?MFVxeVJoOTRTYUI3bDU3ZE1BVzdqdHM0UVpLSHpzZk96OHdaU25xZU8xcTNB?=
 =?utf-8?B?MFlRbW1QQU1ndGZqcTVOdjAxR1JCQmovVmhHcVVKQjgvKzZFTW45bHJpY2g1?=
 =?utf-8?B?TFhCS2JSbThJYlZ0YUdRT1FlZFF4ekZoMWhORkRUMkFVaU0xalpEcWJIU1BE?=
 =?utf-8?B?YzFOS3lRVWdoMzA0NExBd3JES1N2azBKZEwrUmZLRkY0UnhCQ01iaGFrVHlS?=
 =?utf-8?B?SXBVSU56UW9JTEt3M0hTT1lvbmdudkRqVlRTUzJuOVdLL3Z3Mnd1djNSNkM0?=
 =?utf-8?B?VnJORkN3NVgyaUhEcGZkbzM2bjVwRmcxVHJZYUtzenRJbHh2ZGlBUkZrdXZY?=
 =?utf-8?B?c3ZzejBmU3YvSHpRbGEzUmsvOVh2VUMzRVBNZUpIeE1nWXdnaFE5Q1FQeE5r?=
 =?utf-8?B?ajU4bVBrVGFYSkVoYXBjcDFmTjQyRG1xUDY0b01HZkszR1dnR3ZJVUI4YWho?=
 =?utf-8?B?OEFEYXlXVzZQNEdUd0xNY09GcTU5VGdJVnFmZDRycjd0Slp5ZG9YOGwydHZi?=
 =?utf-8?B?eXBsVnhlNEMzYUdCU05WcnN1Y055ck01WHJSSWh4eUJ2ZnRCaS95c2pSVVJ0?=
 =?utf-8?B?Ry9jN3N4cytPbWsrWXlJSWxCTXZubE1JMVlFYk50YVhjUkxlUFlJZG1lcVNC?=
 =?utf-8?B?cWlKUytUeWllVU0xa01ubUpmMW1QNGFKMTh0SHA1SS84TjFBY1Q1UWJxdUpF?=
 =?utf-8?B?UDBkc2IxZ2crTXlqVUc4Y0w3UkRqN1ArSEQrbHFSL0tPbkV1bFhHWWN3b1dm?=
 =?utf-8?B?K3ZtVTZwTjRyVllmcGdPL042T2lVUnY1OXNwN3FIdlZjN296SVdDRHNFaUNy?=
 =?utf-8?B?L0dha2JTYjRlVXdEZ202VUllc1l2WEM5dWtKVThHU2x0UlVwSGduZ0UrbEV0?=
 =?utf-8?B?bnhkYTNMUjJUcVNJbEs3WTg0ZjRBbDEyTjJPRDZRVmo0d3JVU044SEdCRWpV?=
 =?utf-8?B?Skg2ZzhrSUdsc1Q3bytVdy9TSUpPQkpnQW9GTGdFaldpdllOT3ZLR2tpNllz?=
 =?utf-8?B?bkhOOFd4c1dESmhNL3VQMUVqa2NUVkhQaFRxdnF5d25ReTVsK3JkWjZEd003?=
 =?utf-8?B?RHZoWnJVM1ZUM3FldURzTVVZLzYrSXVNUHhRS0pWVnF1Nk85VHFyNkJsaXR6?=
 =?utf-8?B?YzRUMG5SYW5xdzdkeDlDdkFidEVlR1lMSHViU2lnMFZZT09yOWp3a2RTTVNH?=
 =?utf-8?B?NXpZMDdNcUJNWDBNY1ZkS0N4TmxwRmlPZEQ1T05pU2prY1N1c0JZL3VQaVNj?=
 =?utf-8?B?Q2xxK2ptRUZ3T0x2TjZ5TC81Rm9BQnNwVzEwa0Z6S2MxbUJGSmU2TjA3b1cv?=
 =?utf-8?B?U1FUcThlSHk5cXc4MnhSRXUrT3dJTHMxUng4R3NJdWk2eFhmQXVxWlFqTjlH?=
 =?utf-8?B?MU5HYW50MXh1MGV1ajh0UHUzcUQxNEJZTVhLc0Q4aG1jOVFTUVpuV1FFdFlX?=
 =?utf-8?B?MWpyaHlhNi9RR3BkMVR5Uyt6MFJZSExOcXhJUkFGcmVBNkl2U0dESE52b0J1?=
 =?utf-8?B?ZkRUcHlsYy9DZVlRdENxeXVOOWhxZVdKLytmOGh3RHlFSHE2MitzQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf6dcf6-a50d-4f46-2252-08de7f971496
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 17:53:19.6709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TaVfPxTEuwHhRDV10l43CTtooBGTxQAVAUKvh71r08gFzugVQglxpTYFmdlUtcGEdSmNmOXrc325Dd1f+YyK1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6135
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=nathanc@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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



On 3/11/2026 10:46 AM, Eric Auger wrote:
> 
> On 3/9/26 8:21 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Address Translation Services support property
>> to be derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>
>> Set the default value of ATS to auto. The default for ATS support used
>> to be set to off, but we change it to match what the host IOMMU
>> properties report.
>>
>> Add a "ats-enabled" read-only property for smmuv3 to address an
>> expected bool for the "ats" property in iort_smmuv3_devices().
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c    | 25 +++++++++++++++++++++++--
>>   hw/arm/smmuv3.c          | 12 ++++++++++--
>>   hw/arm/virt-acpi-build.c |  2 +-
>>   include/hw/arm/smmuv3.h  |  2 +-
>>   4 files changed, 35 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 617629bacd..8fec335557 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -52,6 +52,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>>           return;
>>       }
>>   
>> +    /* Update ATS if auto from info */
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS,
>> +                               FIELD_EX32(info->idr[0], IDR0, ATS));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>   
>> @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                      smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>>           return false;
>>       }
>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
>> +                   " Services");
>> +        return false;
>> +    }
>>   
>>       /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>>       if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>       /* By default QEMU SMMUv3 has RIL. Update IDR3 if user has disabled it */
>>       s->idr[3] = FIELD_DP32(s->idr[3], IDR3, RIL, s->ril);
>>   
>> -    /* QEMU SMMUv3 has no ATS. Advertise ATS if opt-in by property */
>> -    s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, s->ats);
>> +    /* Only override ATS if user explicitly set ON or OFF */
>> +    if (s->ats == ON_OFF_AUTO_ON) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 1);
>> +    } else if (s->ats == ON_OFF_AUTO_OFF) {
>> +        s->idr[0] = FIELD_DP32(s->idr[0], IDR0, ATS, 0);
>> +    }
>>   
>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>>       if (s->oas == SMMU_OAS_48BIT) {
>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>> +
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->s_accel->auto_mode = true;
>> +    }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 068108e49b..197ba7c77b 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
>>       smmuv3_accel_idr_override(s);
>>   }
>>   
>> +static bool get_ats_enabled(Object *obj, Error **errp)
>> +{
>> +    SMMUv3State *s = ARM_SMMUV3(obj);
>> +    return FIELD_EX32(s->idr[0], IDR0, ATS);
>> +}
>> +
>>   static void smmuv3_reset(SMMUv3State *s)
>>   {
>>       s->cmdq.base = deposit64(s->cmdq.base, 0, 5, SMMU_CMDQS);
>> @@ -1971,7 +1977,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>               error_setg(errp, "ril can only be disabled if accel=on");
>>               return false;
>>           }
>> -        if (s->ats) {
>> +        if (s->ats == ON_OFF_AUTO_ON) {
>>               error_setg(errp, "ats can only be enabled if accel=on");
>>               return false;
>>           }
>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>>       /* RIL can be turned off for accel cases */
>>       DEFINE_PROP_BOOL("ril", SMMUv3State, ril, true),
>> -    DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
> In general you cannot change the default value like that. This requires
> compat handling
> in virt machine: See
> https://lore.kernel.org/all/20240307134445.92296-4-eric.auger@redhat.com/
> for instance

Ok, I will handle the default value change similarly in the next 
revision to account for virt machine compat handling.

Thanks,
Nathan

