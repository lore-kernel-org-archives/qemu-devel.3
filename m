Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D90BFED9EA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X4X-0002Cn-IC; Tue, 17 Mar 2026 12:15:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X4V-0002C8-GO; Tue, 17 Mar 2026 12:15:07 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X4T-0003LC-Iv; Tue, 17 Mar 2026 12:15:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OTHFdCEd0XIoGpl4FoPjrFeIBsxK8MTzQi0Sr49kVy+qL0ofSokddDWf1IuX9jsXIld7ERvjaUlJq+6RwRCv8gvbK4VEI3LfWpfqGWnlFseQRxKpVz97BNXEK92HscZDh1KhIarT+ViqjqfdgiN7Ni4xMqLs7DZvZNzp1TdzFXttsBXHTpwyM/XKQV2Cd10sB0rnXnSeyCjvHKYBXMC20V1o4pzV1QnF9ZDBKztXMD2n2ivFcrloh1OTMwo/Nku9PUk49h9pVE/i3DPbjZpFG3Cnem/TJGtEpWPq5Vf31GyxuKdZs/dwODfJbWA19nUwtL4IZJGDfHalOZsECa8rNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NztuHIdvm1KhSJdlMmnBYltZwtlYnqE2dSwsGKRsNd0=;
 b=wFsP6egVIkC/XsnRq6RiT3no3y4VQ4ftbUBGtH7RnW8vW5D89TrOuhB6CZbCdLS+Jtn6llA97iszeouhfOkrQqipQWfQ6ynJSOnamPkrImppyiB8S9GaF0OpswmPwfpQVddsvXwSQfnELf0XvwnC6rB7PnhAVMS+ae5YcwUl3C6dWAtEiaOB0G1y8dbnqndIF85r6CJuSvQMKxBJo86059HH6Q2GiaLV9sQdOL8zhj/XtHhC+G0x2GzURdlctzWNEOZl/h3InBFCkeHv9rXShCcm8ZizXHaDoaDozGxviDuVxzqV/rYWMwW8xS3gEnMIdfaNKfxJBK0cOAQFo+c09Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NztuHIdvm1KhSJdlMmnBYltZwtlYnqE2dSwsGKRsNd0=;
 b=bb8AiTRlS6Ab7CMZWf68B5cp7EfwqjE9iJq7+2MJ2wrLcQ9WRj9nT6XTQUHqSkcJ+4cmqQdW37MXYAuDBF2Ha/iV7a8jtX6SxeXbk5/lS86AzjC1RYfAO8U5/phXG3fV7LjptIEgaEXkgmxs2ScTI75TSurxirrId9+miANhbo11PcgQjlx3QRb2pmdRDf8uc8Tkj9slhCfU5oExeqkzoU1KgQfDpw9OiQdXyy/o/tVQIuxtSH7+t8IXZ0F8hSms4jLw8ugssS+rKfOMh7ut1Cv071Qo/LY3GEboLB2ijG/aY7/BraRPHYNNQ/KN+O9ItUutABmPD7JMiOYuLKkjrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SAWPR12MB999141.namprd12.prod.outlook.com (2603:10b6:806:4e1::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:15:01 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:15:01 +0000
Message-ID: <658fe7e6-3ed4-4e84-83a3-84c78191fee5@nvidia.com>
Date: Tue, 17 Mar 2026 09:15:01 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
To: eric.auger@redhat.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-6-nathanc@nvidia.com>
 <b708f800-c2e4-4da7-907c-3602f0d1378a@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <b708f800-c2e4-4da7-907c-3602f0d1378a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:a03:74::25) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SAWPR12MB999141:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bb5146-c89b-49ce-8ce9-08de84405728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: bG1r0WLXlizAojBQnRWW/is00JaW39giyWdBaFPfn/P2jRIG/UD9IAdvkuAifzgl9HxA1H096x4yQSaD3gRx/vw0qObs/7ocZXXA8tdxMdJWFf2nceQTthXc3CdumpH+oICafjtfJyCHtxpGzIUEKdZpxRZuo4S8wgbGGR1PkwdDZLTIll8jW3reoyLwAb22LyNEkgknSHOQ8U8I+epCHQ83dKfHNivwaa/3dhlaxVtmoX0B3dN4pBLkL/jlJq9Z5OarcftYfJpuSyThrvLpj+uWqWQcHgp1oGfSB/eLO7fgyY5FPqqIOuriuWFKvgiEkwhaJPo7WlGzJ0qhJXIr5Zlri9zQ4uuoFiaMeoqeQgzOShypwuzCQ2Q9vYsSIqH9nkbYrH2SljacGweq6QKJ3GNj3yWCaVRxnc2NDwebOFRMNA2GkyY4wGJDAuD60lbSC1o0u1mn73xZphtsbmIX1UHXlW47Xf5neLkHfqGKN/Xx6RhZkdmsHRjp65uT9ZhTFrwd3GL9Eu51NPxY75y9e5uKfgv8GAivfpK7JeKFrNLS6LPBrQNI20UTVO5MehxHMcAkTJ/bT9f98xV/84PfiYnw3dM+fzM1IjNp8AavBu6VbiqqIla//uF1fCEhH7y0fWjF0BV9R+TpwT1CfHdR1Q1b0nsCyCs9pecDw4/ijcsWGL7hpXiB3jj8hlMwr5xeKfV05feTZQhEc6yl4m0bZOfFrOeHOqWIXQB2/HZUfnU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3RveFlhQWVCYXJuTlFNdk1yUnRHajhMekFyMU5jRlJYbHptTFV3VW1oWU9a?=
 =?utf-8?B?cWxBWC82eWtEeWhpQUU1WHUzdy84SEdhdnRVbWEzUWFzSzBzT0NDT0xWMEtX?=
 =?utf-8?B?T1duZTVZN3pEelozWTQ0SkVrQng5eXNHWUUzVjkvVGFPRU5hSFFnK2ZEblBt?=
 =?utf-8?B?RjNhUHRXdGdJYWVheFVwa0tlL2UzdFhyU3R0SE9UTkdQM25xU0doOVJhb1k3?=
 =?utf-8?B?Y1c3Q0ZsRm9JTzZmZlBwNlNFWnoyaE9WZmhFUGtlWjNYZUxOeEtvOU1kQ2RU?=
 =?utf-8?B?R3Y5ZDRoYUxwb2kzTmxRbit3WmN5Ryt4Qk9DamdsU0FBc1VrQnlSOHFVcXBF?=
 =?utf-8?B?b1dNNlpMamcvazVNM1lySWhMd053NFMyRXpjT3ZiOGZnTm9wV2ltZTZQcGZO?=
 =?utf-8?B?eGFwODFaZ3NuWWUweHlKQ3FIREVKMG1KV29ab2NKZ1hIK2RpNVhIK1k0SS9j?=
 =?utf-8?B?anNxcVg3citkWkF4N1ROZlNaL3pYUG1jd21xYlBCWno0QkNOc213b1NPYVNt?=
 =?utf-8?B?VkJGZ2t6eE5LVFVhL1RkMTNZWklRZXdHbDhUS0pOVjg2UWNYMW5IZnVuNlZF?=
 =?utf-8?B?T0ZTTWR5cmdPdVhZNXhhOUZKQzJxS0JiRHBGSXRhWkFmUWI0TUZRL0VscTNv?=
 =?utf-8?B?Q2VOQjBINC9iMnNBWXlEaU9BeTVPUTExaXdtcTU3NmR2bGZIZzZ4ZGhya3Q0?=
 =?utf-8?B?RXBLWlk0OUtnRVk0N1lwNDZhL2VjWHJMNiswWHNDcHdCL0lwVWlMWlhGZlJF?=
 =?utf-8?B?RTVLUys4ZFVJbGM0UStvZjNZaHY1UTVJT2pRWUVaM1ZMWVhQdjRqM3ZoZXVJ?=
 =?utf-8?B?akVzbWM0dEx3MW5zNWIya3ZXenJXMzNKb3l4RkZCQkFZajB2Z2l2UENQMlRB?=
 =?utf-8?B?UFQ0TU5mM1BZblZDQ2FZeis0QkI2ZmVKeUI1Wlpidis3K0lqMElvYlBHclA1?=
 =?utf-8?B?TFZuR3hnRGNUK0crMDVnMEMya3VWb3JjVTdITEp6RHB5eFVZTUVEWnlCek1t?=
 =?utf-8?B?RXhLbEl5UFY3K3Z6LzE0Z09NdFBGWFZabDRyTjBzNlZSdk04Kzk4VGpqbk5M?=
 =?utf-8?B?OHd1VFIvdHBReVlhLzdrL21DMmhpQ2wvaGRtcCtITXBmMStHQ0RHRVNKRDFs?=
 =?utf-8?B?K1g0OFFmZ1IvVXhUZlBJenJqQzBMZEhhckozcksyNVlWVVBlajhjSW41cERH?=
 =?utf-8?B?dkpYRDU4d0U4QmFzRkJFdmRaZ24xeExrbngrTC9PcDZxc0xuQ21TQlVLR2o0?=
 =?utf-8?B?RkI5RXpEeEMrcUtmcndXZExMQlozdUVGbmdQdHhKOW9tUzRxYzg4cTFrTm1F?=
 =?utf-8?B?M2s1V3gvelBIdUQ5Y2puWnl4U2g5bkFjVVJQdDVkVE4yc3A5UUZuL0R6MlBo?=
 =?utf-8?B?dytQbzQ0MEh3QVpobnZnTk5vMGc5ODdZTzhUKzZnOFZhdnVCV0ZTYTdQaVBu?=
 =?utf-8?B?NGRIT2ZvbktpZGV0SnNqVFhHQjFyR1NxNE1BRy9VbnlFMzhTelVHSCtZby9p?=
 =?utf-8?B?Z2tMSXcxRTZGZmszSWRZcHhKRGJrZW45K292djRGWS9OQmh1RGhwYTdNMEtP?=
 =?utf-8?B?U1ljMEl0dXBNNnZMSERnaDBXYlcyZWdlUTNKaFA2aEw5V292a25aSURlRTBa?=
 =?utf-8?B?VzhsQWoxd0oxSnFRRjNkbHhCMC9QMGdvYVFBdGJLcmU1M2o5YnZqbHlCNVJ0?=
 =?utf-8?B?N25uT21lZjlNOVJ2d0lRRGt1RmtVWUhEalk5bll0WEJzbnp6dnFFZmRaYzRk?=
 =?utf-8?B?eUJrQitwc1FvZkd6Y0Nja3ltTmZMdnV3RURaYXl4T1VTWjdSSEFJZUVZd3R3?=
 =?utf-8?B?ck1WQ09pcXlqeENlZGFqQ09HYmhjcjN5QnVQL0tsUzA3eFNpQUtEaU5vQW5Z?=
 =?utf-8?B?ektnMVBsYWVwcVd5Y0xDTlFCbXVrT3VIVStxOU5GeEttWHZId0RMQmdkQmVW?=
 =?utf-8?B?RUVuckxKWnJ6bnp6aGJiblRqSmM5TWJSMllUUGU4c3NidHIrL254TElJblZu?=
 =?utf-8?B?U01FVGF5bk1nMTlLU1J4ZjdhczJ6dUo2WmU3OW5NZDRDV1hKVXZIZUh1WlJF?=
 =?utf-8?B?THJLTElnS2J0WXpESjcwK3RnYXhwM2ZLNjAxbDZFbjNWall0Q2hiQ3F0SEk1?=
 =?utf-8?B?ZG9SODZybmpuL2NsamlncEFqOVAvbFM1Zk5qZWwwenVXcFlQbUtRc0lvUVpt?=
 =?utf-8?B?R1J5aDA5elF1WHNZRkdyK2tuNHBybklycHFQc3RMWjRVT20vK2xPeFkvdm5I?=
 =?utf-8?B?dFo0cU4zMUJuVXJMbU5GZXhHMEM0ME9vQ3JJR3JmL0cxay9EUlVjdFFMc1oy?=
 =?utf-8?B?QVgvL2ZxVUV0VGM5UlJvY1lsNzVRWEN2enQ0aXo2ZDdkekRvazk0UT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bb5146-c89b-49ce-8ce9-08de84405728
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:15:00.9686 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ue3N9lReFkhXowC2v4B7jvZWIeyC+Tg9NS+4H/yBa/r/QBuIynefWpAr9cZ0GBpmh0cjnMMlVZ7XXunxJZRTGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999141
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



On 3/16/2026 12:50 AM, Eric Auger wrote:
> On 3/12/26 10:03 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
>> Setting 'auto' will use the default value, i.e. 0 in IDR1. A future
>> patch will implement resolution of 'auto' value to match the host SMMUv3
>> SSIDSIZE value.
> At the moment we need to reject auto setting as it is not supported
> 
I will enforce rejecting auto setting for this and the other properties 
in the next refresh.
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 17 +++++++++++++++--
>>   hw/arm/smmuv3.c         | 16 ++++++----------
>>   include/hw/arm/smmuv3.h |  3 ++-
>>   3 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 6f44fd3469..ab037df7ac 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -803,7 +803,7 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>>       SMMUState *bs = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(bs);
>>   
>> -    if (s->ssidsize) {
>> +    if (s->ssidsize > SSID_SIZE_MODE_0) {
>>           flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>>       }
>>       return flags;
>> @@ -818,6 +818,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>>       .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>>   };
>>   
>> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
>> +{
>> +    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
>> +    /* SSID_SIZE_MODE_AUTO = 0 */
>> +    if (mode == SSID_SIZE_MODE_AUTO) {
>> +        return 0;
>> +    }
>> +    return mode - 1;  /* Enum values are offset by 1 from actual values */
>> +}
>> +
>>   void smmuv3_accel_idr_override(SMMUv3State *s)
>>   {
>>       if (!s->accel) {
>> @@ -847,7 +857,10 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>        * By default QEMU SMMUv3 has no SubstreamID support. Update IDR1 if user
>>        * has enabled it.
>>        */
>> -    s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE, s->ssidsize);
>> +    if (s->ssidsize != SSID_SIZE_MODE_AUTO) {
>> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
>> +                               ssidsize_mode_to_value(s->ssidsize));
>> +    }
>>   }
>>   
>>   /* Based on SMUUv3 GPBA.ABORT configuration, attach a corresponding HWPT */
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index acbd9d3ffe..8b0121c0ed 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -20,6 +20,7 @@
>>   #include "qemu/bitops.h"
>>   #include "hw/core/irq.h"
>>   #include "hw/core/sysbus.h"
>> +#include "hw/core/qdev-properties-system.h"
>>   #include "migration/blocker.h"
>>   #include "migration/vmstate.h"
>>   #include "hw/core/qdev-properties.h"
>> @@ -625,7 +626,7 @@ static int decode_ste(SMMUv3State *s, SMMUTransCfg *cfg,
>>       }
>>   
>>       /* Multiple context descriptors require SubstreamID support */
>> -    if (!s->ssidsize && STE_S1CDMAX(ste) != 0) {
>> +    if (s->ssidsize == SSID_SIZE_MODE_0 && STE_S1CDMAX(ste) != 0) {
>>           qemu_log_mask(LOG_UNIMP,
>>                   "SMMUv3: multiple S1 context descriptors require SubstreamID support. "
>>                   "Configure ssidsize > 0 (requires accel=on)\n");
>> @@ -1984,7 +1985,7 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>               error_setg(errp, "OAS must be 44 bits when accel=off");
>>               return false;
>>           }
>> -        if (s->ssidsize) {
>> +        if (s->ssidsize > SSID_SIZE_MODE_0) {
>>               error_setg(errp, "ssidsize can only be set if accel=on");
>>               return false;
>>           }
>> @@ -2002,11 +2003,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>           error_setg(errp, "OAS can only be set to 44 or 48 bits");
>>           return false;
>>       }
>> -    if (s->ssidsize > SMMU_SSID_MAX_BITS) {
>> -        error_setg(errp, "ssidsize must be in the range 0 to %d",
>> -                   SMMU_SSID_MAX_BITS);
>> -        return false;
>> -    }
>>   
>>       return true;
>>   }
>> @@ -2135,7 +2131,8 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>>       DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>>       DEFINE_PROP_UINT8("oas", SMMUv3State, oas, 44),
>> -    DEFINE_PROP_UINT8("ssidsize", SMMUv3State, ssidsize, 0),
>> +    DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>> +                              SSID_SIZE_MODE_0),
>>   };
>>   
>>   static void smmuv3_instance_init(Object *obj)
>> @@ -2173,8 +2170,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>           "Number of bits used to represent SubstreamIDs (SSIDs). "
>>           "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>>           "Valid range is 0-20, where 0 disables SubstreamID support. "
>> -        "Defaults to 0. A value greater than 0 is required to enable "
>> -        "PASID support.");
>> +        "A value greater than 0 is required to enable PASID support.");
> Why removing "Defaults to 0"?

This was left over from the v1 RFC. I will fix this in the next refresh.

Thanks,
Nathan

