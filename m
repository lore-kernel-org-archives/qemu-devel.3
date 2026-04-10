Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76384F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGyr-0004Ng-QK; Fri, 10 Apr 2026 14:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBGyp-0004Ma-Lt; Fri, 10 Apr 2026 14:53:23 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBGym-0007Ff-Sh; Fri, 10 Apr 2026 14:53:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfWet59oXkf882xEgzTpcQWIZkDvb/4hsXxYQvv4PucPqF4G6Z5m1ftOppKw/OaWnA5ho36zkw1kSm0/I18ekKwQLHg/P2rCgi6WzsLZp1OK4pWkaHZWYZ+7/tq0yxcdzkC4cKdAiUyxM0ZufkUWXd3LRJcdH4gxgl2MdmIAiF8p+AVFei626uW79Nq/5gfBWw+LZAaCUnWxy+rZLymh/Hil+rUd6XN//cfjAM5V4SVWiggBDKWzVaPzZfWJ1za91Btyi8lrNart2Wm+jsT0oedCFMHagZp4+shDUl72RYS2R+/UjHrGKDj1ZDOcbsbJ6F2YyjJbYfxAN25T8GO0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XyEqKvGiQZXLHSxlhRxRIoDUdGnV7QGRC3jDYOKh1Ro=;
 b=FtBkTVC+iVrbpI/5RLZ4guxj23bgmQDQ6/75sP+/7Gh/5IM5u4gC+iwbXI3rf4wWt9oW7g1QdaC3xpjrjDSRn1aDnwYoZDoU1gwwQ/hJS2ZmxrXl2ZIyte1KT8eOeP2wA7hOg8GFF9GEevGttGWE2cEcXe/AhIlJRrDonvIgH83UI+hhyTU7bI4+87HOQAhXJ47IR6FxATcyIB+2WvnoTNbtrntkd84eeBGh1QzKWpWRPOFqSoU0t8r9+8MFK5mECwtHbRZdQpp68E8iWF9v0nSDAAdL2r9pBaJdhRiToBv9bLfOwxyU99kLjYyy/sqJ2hMzGVBWwahs3KxgUTyf3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XyEqKvGiQZXLHSxlhRxRIoDUdGnV7QGRC3jDYOKh1Ro=;
 b=qpTKXn/rxJNDrBGSYjLkj0ooQWMz5kHMEtaiKYZI7y2eBu9b8q045ggvROSnX89OK97d/L7pcdT1Vv9QzB3l0WW0qQAa9WJW+ejSRNWgvtdEh2I0JRYIHZVYzypAzX1odHztbKMcUIlMnKrW15fYQVkhEd23r60onw6bGWdOjbhVFnf2xTCltVsfaXclWBSCFfXcMwC2H9akUMC14YmDFvblwXTTGjb90E8K1kpWwb+cm02y1qrxocJ/OpI0aH050WX3phxveIWyPet9UjQ57lkdrC17wDU7jmwg4Lq/M79GFVaPItCEucD4wC+ZGXBZsCqbGGbhPvlxUxQ3lot1Wg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Fri, 10 Apr 2026 18:53:14 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 18:53:14 +0000
Message-ID: <2e63174a-d426-4c79-92fc-ae38f82ef2be@nvidia.com>
Date: Fri, 10 Apr 2026 11:53:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] hw/arm/smmuv3-accel: Add helper for resolving auto
 parameters
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Shameer Kolothum <skolothumtho@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260401010231.4166776-1-nathanc@nvidia.com>
 <20260401010231.4166776-2-nathanc@nvidia.com>
 <d68d889f-2257-45ba-87f7-7948ef0da478@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <d68d889f-2257-45ba-87f7-7948ef0da478@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0038.namprd08.prod.outlook.com
 (2603:10b6:a03:117::15) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: eef9948e-b52d-4fe7-33bf-08de97326b66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: dxYH3kyfUYhKqeZv6vXx+rPPWZTj1Pek7NGYBXo0kPoKjHXmHgj4qrLX9BWpL97HcRXhGwgXZmH+APuwUoPGPMI2iTFCwozkPHd23fFxpnCt4r7F5usH8iO1aKTL9731KqNik5Xqy1f89zhyGhlmls1BLg+edSJ2ns54kf5D7L4RofocvB3w0rBowIbx8lC8lUQf5l04eyBh2/hNElkuDzGxFvPQDBmD1efHOJg96ej1FAlppirqZ6meS/ZoDuCK5hJA4H8EGtNqpBltD1sOCHbvBw+hAdAfSvd//tPKWbFzpj1mBIDWYox+NWrFabQ+WRJFtX1d27wl0sUlkG7pKquXP7IowcPGSk7dbw6YmPeMEChdr68UbdI/Agp2+ZhBonlYHSQkkgia4z9jLNBvZMbTFXFi+iXWK1NY4Ia+hyEHAsypldcDPT408pUsojapKpFbKIXzbrUqM6BVGxFAm0nyciv3+9/6siyT5CKizvjJH6OLbo3LUDK5kM9TS3hsnT9n/m9phIuDOXadQgQewhek0nEp5dq5IAjYArdoWDOpYE6qflOAW1NkG0oKqOkO16lB9m0/qb40HhOC+n0YhVRwh+apPKCVb+nOw8QWtfzR1uK5UPE58N8vOOaJ31IfJvI9C9GHMqOyW3j3l3/cS2llb/b6gXMRasoXgflPLUUOLgZ2he+61VFOPUcRMOaGUJqtexIRI9608f5XLTs/3ggERzFHPtX6e7K7ATY7+xQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnJadWxwbXUydFhQeDI2Tnc5MFhBVkhWcW05a1lwNW92K1R1ZFloNXJrMzdT?=
 =?utf-8?B?dTFwZWlEdGVSU1ZZTC9NNzcvY1pVbkhtU1JsVWpaamZBQjRralQwbVlLb2NZ?=
 =?utf-8?B?czUrMzVWNi96ZXEzcUIxVkpMcnFDb0xucHZJNk42eWdPc3RqaVh1V0NCT0xX?=
 =?utf-8?B?emxGTlJjOG1VM2o2TmlLNC9vdUJtVExBd0dDWmZWRDJUZmdoTGJmb3BUWnpY?=
 =?utf-8?B?blVZQkM4QjZUZ3FOTVZmTC9OWkFnUXdQSU5oWWRET2p3NVdwN0MzT1lpSm4x?=
 =?utf-8?B?SUQ2S0ltaHlxa1pCOWJvbnlWNGNaYzdxbkc5eDNPczlDSWdUUm9OQjJkZ1Yy?=
 =?utf-8?B?SHF6NXJ5RkRYbThZTEM5UzNpaVE0TWd5Z2pmZlpESEFnN1BZUDZOd01YTkFu?=
 =?utf-8?B?K0NxcVpMeXNGQ3ZiUjQrSlBFbWdKdklSUWtuUXdUcFg5cHAraEQ1Y1VlWXJU?=
 =?utf-8?B?QXB0UDcrMFNka1VaTXpnTm44RmlUS2s4V0F2ZWxWK1B6U2tjWUJaKzR1VmJ1?=
 =?utf-8?B?bmxMK2pYTVVMek40SitTODJTR052cnNzc3BCMjlMc3VIWmk5OWFhSHp4UHVn?=
 =?utf-8?B?YmZzNEhuR0l4MmExbDQwaURLdmNRY2s1Uk5KTGlwYjJRb2FPT0tiTGNkYjhw?=
 =?utf-8?B?YUMzSE9QcDVxR1FCYkdVZUxjd0k1N0E2NVQrRGpZRTdsREpnMjdBMmVUdjk5?=
 =?utf-8?B?Qjk0eEMzQmY5UmpNNHYxMjFIUjVNQXVtakJnNWlaYnp5bERPRk51UFFhaWZY?=
 =?utf-8?B?ZUNvSWZDajRiKzFQSU9zSUx6RG1wbHJQM05PVlNSdHplbFlGbnBOL2Yra3I0?=
 =?utf-8?B?eGJnSHR5dzN5THVXU2JtbDdyMHo2emdmYnZReVUzUjdkSlpZNzNFVXZGbXk1?=
 =?utf-8?B?ekI2MzkyeFpMSkxWL21rNWEzZldZYU50RlVvTUlkRklJR0toMUEzLzZ4QzR5?=
 =?utf-8?B?bmNRNUUvbmIrZThDdDhzKzVzOGxTVmhMU09oZEg2ZWcvR1g4SGE3aUI0cUpZ?=
 =?utf-8?B?ViswNUx5MGZJVWZsOW0rbE9DZ1FWWmQ1MEVicDFlOUM1SXRxbUlWcjBURG8r?=
 =?utf-8?B?VGRwcDlCK25ZTUd6blE2QThmUzA4REtJenRjZnVkcUo1WHk3WUYvYW5WK0sz?=
 =?utf-8?B?V2Y0c3BNSGdmUXJtWFdJNnBUUjZPamxXQmlHZ25VNG1Rc2srSzBxWGtxL0U5?=
 =?utf-8?B?UlMvaFliZmlQUlF6b1NUOWRrOWZpS2NjUGxVVVAyVWVwTkFPOUhqR3hGcjFF?=
 =?utf-8?B?YklrTDlIakpMWDlsMTFDaHc2dWtnakoxUW1yT2Fid2tVL0NTeTAzMDhyZ3Fz?=
 =?utf-8?B?VmNXaGFoampzK01xTHlFQTVFT3RLcWlySmZmQWt1eFVKTkVRZ1hLUlcrVU13?=
 =?utf-8?B?YWhpR2Vtak5pOXhWK2gzTlRZQm1neGVyeEcwRGlObGU4ZUV6RjJjdGRaZXhh?=
 =?utf-8?B?a2lEM1ZkY0EyOWc0aG5lT3BXbGFLOE1aZ25WVjdLVXFxLzI0WnozYkRmSWlO?=
 =?utf-8?B?dUFIOHd1cWZXMklyRUpyanJRcXhWV2VlY3hmU0I5S1ZacU4rd205cGxtWFZn?=
 =?utf-8?B?SExiLzFwYmVaa0VTaGo2K0x5ek0wdmdUSU5memloQ0x0MGpJTlVZL0tCNUFR?=
 =?utf-8?B?TngxQWhWUUpWUDZnYkpJbXJHZ3NXak5OKzdjWm96eGxLQW16aVZHV2tjOEF0?=
 =?utf-8?B?S3d1NnAyQnhib3A4R2kwSnRuOFJ1ZXFNVHNiYnNBWWNVUm8rRFhYZ1BpcjMr?=
 =?utf-8?B?b0Zxanl3UnllMVRld1JmMnFFUG9lR0VsWnJ5ZXRvL0VNQnA1dXE2a0sxTGo3?=
 =?utf-8?B?ZFhHUGVuU3E2djZrb09iVVJhenZJMVRZWlhaTFZoU09BZEpFS2hnSExmZ3pV?=
 =?utf-8?B?U2hxSXQxdXZISmJGMXhYWmp6dG5sd3c4cytGVG1xYytHYzdlc053QTd6NnhX?=
 =?utf-8?B?bXFBc1BkdlR2eWlBVWxHckVpTlkwNWdPaUlVMGhOdUVFaUtmWW1EWXhoTzI3?=
 =?utf-8?B?SCtxWUlxVHY1OXVBVjBqR0hPSzB3MkNVNUp1WXMzSndRYVRpYTVkUDFqN1N0?=
 =?utf-8?B?aDN5YkQrNUFKQmNpNVFjeWRHY2RQa3Fhb0hSM1RyVTEyU3B4aUpHTXRzQXBD?=
 =?utf-8?B?aHBIMjE2UzRuRnlQdlFjekpPR2ZiakdvWkpaVkRPZVk1L3dVbW9Ka1A0OW91?=
 =?utf-8?B?dzdjSTcwVjJhTkRCdFBGTGFCRjNnS2E3cHpsc3JuK3NnMGtBZDVNYjJRQkU1?=
 =?utf-8?B?cEdtdWN5YW5DdW8xbnFDYkxxYjQxNE9Lakt6K29qVnM1S3R1YlFiWnNyQ3VO?=
 =?utf-8?B?NU5DaWQ4VElOK0Rva2RPcUtSM3dIWnFZTHhDTFh0Q1RTWXk3aXR6Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef9948e-b52d-4fe7-33bf-08de97326b66
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:53:14.0327 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PN+S7l4QvlO/8n/rb1wao37EuNu+GdYE8JIJP7gKAOrY8WC5zZ6ljdSsxxahxikaXfAmGxpejqWwr8tJt87YCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nathanc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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



On 4/10/2026 12:37 AM, Eric Auger wrote:
> 
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Introduce smmuv3_accel_auto_finalise() to resolve properties that are
>> set to 'auto' for accelerated SMMUv3. This helper function allows
>> properties such as ats, ril, ssidsize, and oas support to be resolved
>> from host IOMMU capabilities via IOMMU_GET_HW_INFO.
>>
>> Auto mode requires at least one cold-plugged device to retrieve and
>> finalise these properties. Register a machine_init_done notifier to
>> verify this requirement and fail boot if it is not met.
>>
>> Hot-plugged devices into an accel SMMUv3-associated bus will re-use
>> the resolved host values from the initial cold-plug.
>>
>> Subsequent patches will make use of this helper to resolve 'auto' to
>> what is reported by host IOMMU capabilities.
>>
>> Suggested-by: Shameer Kolothum<skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 14 ++++++++++++++
>>   hw/arm/smmuv3-accel.h   |  2 ++
>>   hw/arm/smmuv3.c         | 20 ++++++++++++++++++++
>>   include/hw/arm/smmuv3.h |  2 ++
>>   4 files changed, 38 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 65c2f44880..a0146c8d31 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -35,11 +35,25 @@ static int smmuv3_oas_bits(uint32_t oas)
>>       return map[oas];
>>   }
>>   
>> +static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>> +                                       struct iommu_hw_info_arm_smmuv3 *info) {
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    /* Return if no auto for any or finalised already */
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
>> diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>> index dba6c71de5..3c1cd55714 100644
>> --- a/hw/arm/smmuv3-accel.h
>> +++ b/hw/arm/smmuv3-accel.h
>> @@ -26,6 +26,8 @@ typedef struct SMMUv3AccelState {
>>       uint32_t bypass_hwpt_id;
>>       uint32_t abort_hwpt_id;
>>       QLIST_HEAD(, SMMUv3AccelDevice) device_list;
>> +    bool auto_mode;
>> +    bool auto_finalised;
>>   } SMMUv3AccelState;
>>   
>>   typedef struct SMMUS1Hwpt {
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 7fead1c3cf..09ea08eb18 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -37,6 +37,7 @@
>>   #include "smmuv3-accel.h"
>>   #include "smmuv3-internal.h"
>>   #include "smmu-internal.h"
>> +#include "system/system.h"
>>   
>>   #define PTW_RECORD_FAULT(ptw_info, cfg) (((ptw_info).stage == SMMU_STAGE_1 && \
>>                                           (cfg)->record_faults) || \
>> @@ -2020,6 +2021,22 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>       return true;
>>   }
>>   
>> +static void smmuv3_machine_done(Notifier *notifier, void *data)
>> +{
>> +    SMMUv3State *s = container_of(notifier, SMMUv3State, machine_done);
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    if (!s->accel) {
>> +        return;
>> +    }
>> +
>> +    if (accel->auto_mode && !accel->auto_finalised) {
>> +        error_report("arm-smmuv3 accel=on with 'auto' properties requires "
>> +                     "at least one cold-plugged VFIO device");
>> +        exit(1);
>> +    }
>> +}
>> +
>>   static void smmu_realize(DeviceState *d, Error **errp)
>>   {
>>       SMMUState *sys = ARM_SMMU(d);
>> @@ -2058,6 +2075,9 @@ static void smmu_realize(DeviceState *d, Error **errp)
>>   
>>       smmu_init_irq(s, dev);
>>       smmuv3_init_id_regs(s);
>> +
>> +    s->machine_done.notify = smmuv3_machine_done;
>> +    qemu_add_machine_init_done_notifier(&s->machine_done);
> you might also register the machine done notifier only in case auto_mode
> is set
Yes, I'll incorporate this in the next revision.

Thanks,
Nathan

