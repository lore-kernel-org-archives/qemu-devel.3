Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE53F459FC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 19:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBH7B-0007Hq-0Y; Fri, 10 Apr 2026 15:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH79-0007HQ-3e; Fri, 10 Apr 2026 15:01:59 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBH77-0002du-55; Fri, 10 Apr 2026 15:01:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQNtjSUvJgfy6GMW+6GljIQD7MM5TXcM7R7l4MnSIICo+5NGSjDllWuPROa/JOK8MEd68u42/75rynt2fPd2q0UGIiMf84Vf7rfUIhYR+jBYu6/BbB6UHPuJ/xQCJcv72mDSFStsXUZUT6vDfmqxKixgYXaWCAnAJwc493/xTH5AyY7PNI4zOnr1F6D2a5AYRQWoPNt9mz/T4h7Lbd+EdKY7flgwgXs0ao9RvVbvRYgH8gmmc28d0Q0rX5sH/fR0+vPpkUDB2wqih9Vyw+J/h/H8wQYxMalTaaI7m3fSvtOMYS3B6eEyfkWh+Tfou/lxqaM/3A+FQ5JjvjvTEPVDyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPAFIQzW7m9TXGYYpOcdwCzh6SQW8GR8RRzxh3vCog0=;
 b=Yg89uDi80RVgEAOWlVE3pOCzFCzR3YcDjNW4sGFaUrzaVKCSqkvudasnAo1maIvERxKWpi3Pt74u5eL2XLhuJ0QfISO2r5HFWdUU1jQl/6snlIGIxd3Zgzo0JS19HE4wI9i2J2QQQ1Tl+chzhqmczpAA3bFL46xOVtqgk6y1GSKaqhi9CZn7xUwRuhrC0+o7NVl9Q4OkShLz1aNMTrpklwNfbkvmjAWYr9CKQ4SHYAg1pwt/JDFZOHgQiYfgt4hBOecrGDA2cFx4qUWF7pA5TDomrStD++zRUzGyGvFT2+6tMZ0ENkq2TRdkN3Q0Ob6juHf+puVzdoAIBMYwflYHJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPAFIQzW7m9TXGYYpOcdwCzh6SQW8GR8RRzxh3vCog0=;
 b=lrOIJ4ImiWhZwBihP3KYdiSNDXwbTZJRPpG6599AxMDtu3x7prHa17q+6fvZrQk6ZxTkPKkjD5/CFuPSLtC0Qnv47OAoXnL6Zod9POxYb65s0QFD0yO1DBcaau0TAUaPWk/AOQSra7G9Lbu9DF3kqra62c1Yrr81RUcdU/mfASwJQc9DS1JJCbpafGBz9s8McFSodapv0B/ksNNEOkXFeHh2cMEcTdZPuPvZ7dj9/rw7+4/f437lqHy2NJEn+wghmHyuc+fHc503eisPaxaGrBND4aTc6aOTUlBUmFityW6o+c0dLkryQ6yvB7qfm1Z9Sj4rj0NQ/Mjp9M7Ry8QnHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.19; Fri, 10 Apr 2026 19:01:50 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 19:01:48 +0000
Message-ID: <8550e0aa-53e0-4366-8949-ebe09f1ecd77@nvidia.com>
Date: Fri, 10 Apr 2026 12:01:45 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "ssidsize"
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
 <20260401010231.4166776-8-nathanc@nvidia.com>
 <24339c4e-0654-445e-8ed4-bbe192c83523@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <24339c4e-0654-445e-8ed4-bbe192c83523@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0003.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::34) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: 91353ef5-4b7f-46ef-e32e-08de97339dbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: et3H3uGEgtQQXDNcRWb9oV5dI4VaGqVeyavHJAU5qYcb4YmgcO9o/ILZOpsNHvdlcGMIzWTHWiNWuz27EXFW7UijyEi3UfSaxZn5Krpwu36p10kwUqEb2mI25VmRHTRODNMkKThkLMTopD5bBSJyesqmCcti4ajYvW/bwl1v42DLN8VyhRiBh924o6SMS+O/GvA+xTAjFOTX9jrrgvtoZvqiCkQagni8yA3kOvGBNMbe1gvGfGNIPBucAQ0frGao+xvr6LTfWv2CsJj8MVCCM3wAWEa26L38uO0L52h8kIDJBsi21ZOthVl44YOIYepiu7XfkPDIN1WsLTmLXKw5HDSbczcavLUoiGzG1/rn6k3JrISpG4nZ+pI7RIkY5J69C/AhkNX6IjaK03IZWYCg7G70elast6v7Yw/qyFZ52W2gelJhWtA0fQga/bdfmKGLEkTFTmHWKxOokig/LCJaRM79Wx7alOEXSzVv9OSo+ZuHkEaaFUh4KWaLKeydnRh4KhkHyvcW6ZpDqbrd16EhLb1G6wErT6m5eF8F/yeyggnlQxb9qXeU35F6myfGYnzE1N6zT2hAgd5kpBZoc9tdyaX1jNjr/4xgWfOONZLAgWKXumI0vQCv3D8rnEwkgHJkz1YAnEFpTpNSaaqrfR79Qcv5ZaWnpvG4hzrUIbQHLCv20cNhKOrpU4GktZ/E9mJCnxNDiaUqjWNQcM943sxNVtxX8FWdby9/7plVWhUAAbw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YndVOHdVMzFkQWdOQmF5Q2NwbGZrRVV3V2FBV1g3RFQvYWJ5TkZQczZXeW5P?=
 =?utf-8?B?NDVYSUt1akdjVDdWeVZ6bit5NW9abjRGMFpDS2dLb0pxYkIyRFF4YzFyTjg2?=
 =?utf-8?B?ZmZwRmRaMmJ1THcyYk0rNDFNNUhEWmVOZjdYNk1iUVNlSHhrL2JFMFlVa0RD?=
 =?utf-8?B?ODJCOWZlb3YzbkNBTzVHblNxTlJvT3pWWHlKeW5EMjBJUFFuR3d6THBoK0Vr?=
 =?utf-8?B?aDYrNzFhZktYR2hmNWdHRmoyUkN0ZWpBUlFoTGlWOS9oR1hjZmtnZEdad2NH?=
 =?utf-8?B?LzlxZUxJdC9ra0U3K3BEcXZORUJGTTdOTVN5QmhjeHFucnF5dXFZd3Q1cnA5?=
 =?utf-8?B?V3pWSFhYdjNCSjViTGh0YURuZU1HRzVxaEYwbEV2L284dkluTW9hcDZDMmVG?=
 =?utf-8?B?Z2FwZUhpak5qUkZ6R2FyTk1hOUViZmlqOElSK2toTDdHemlnRmxCQXhQSkUw?=
 =?utf-8?B?ejE0bS95S3Q5d0tUQWlPZVBXZ3Q2dDJ3aklUam05cU1RbWVUS05CSXVMLzZj?=
 =?utf-8?B?T21jcTd1NTFlUFlsNDhWbitwanVJaFJ4WFhJU3NKa2I1QnlkdWtpMXl1SW1O?=
 =?utf-8?B?TnFqS1g4YVRQRTBaVjgvUFVuYzlZRUdIVStMV2YzN1VZbUs5Ti9kVjRlYmFN?=
 =?utf-8?B?S1NScTh5dTZGWjlna0VTOU5jbTNvWFlpZVFLQVVWRkg2VXVXSEpoY0gxUmhG?=
 =?utf-8?B?NUtEUnJjM0tMYXdXc3JPNE1iSys1NjVWSzMrSVFCdUcxY0VzNm93VTk1QVl4?=
 =?utf-8?B?U2VPUDgwM1RCeHJQNXJvM1pWYUdubG1OL0JuTzBHZGlqZ2tWUzNoNkx0empq?=
 =?utf-8?B?ZVhyZXZzR2o1SHM5VDB6cHJqbTJTTUJ2OWVFUVB5RWZoeUtWemlrQ0FTY2Jt?=
 =?utf-8?B?RERNUk03czQ1TUhEd1IrTGZibDlEei9yZzZ2WFVEa2RNK0NLQXJIRkR2b1lD?=
 =?utf-8?B?S1BpOEN5bm5LUnVxMDBGUW1ZNDlOaUpwWkluTy9hZFdDUTc2dmZiVXdNd2po?=
 =?utf-8?B?VU5GWkliVDU4SEp2RTFhbTlvdW9ZOTZUc2JZaGkwOXQ5ZVkyWXM1dE12d0lS?=
 =?utf-8?B?QWgyMmJmM0tnMUk5ZktwNUpmTGNrWUxnQk1nNlBmZWp6dEMvS25nVW5KekpG?=
 =?utf-8?B?K2tyY2QyTmdQb1RRelhYM1VmRHNRdDREM2w4UGRCN3piUkI3Wlo2cU5SOTFm?=
 =?utf-8?B?aEpRUmNXbDZiR1F1NVl5dGd6dE1BSndjVFlHRTE4QWlZV01lQWhnYk1TZ09a?=
 =?utf-8?B?U0IyWjI3TFhNUFZWbFdWdXZMTXhCZnZjbG80bjR4N0U4RHBJMXNrckd3cGwr?=
 =?utf-8?B?aHpJS0xkVmlQaVo1eXFXS1hMT2RMSzl5SFVmRUVqMW4xVkE2L0ZRdEN0Zldv?=
 =?utf-8?B?ZGtyZXdQVTVwcXl3U2RZRHlLbjBSaDUxa2xSUTJnNGdsM056RDE0U3M0M2V1?=
 =?utf-8?B?NDdXZ2tNYVU4bHg4WXA1Um9yS1pHWTNPSnl6MkkveFRSblBoM3JwWTBicU5B?=
 =?utf-8?B?bzZUanA3dmluU1hMWHJPcjZVeFRrZERvenY5dHBGZnQ1NGNOS0Vta3FMWnBt?=
 =?utf-8?B?N1MwemQwU2RwNFF2TmVhaW1GYnpBZmJjNWJOVHlwT0ZhWWxLQWd3NFFjTEF5?=
 =?utf-8?B?RG8yamFXYzh1VEszbm1ySGxtSlRROVVDdSt1d2FwQ29QRXNzKzMwMzBHN09Y?=
 =?utf-8?B?TUlWcEdObk80bGU0WWxLeFZZcXo0TFBDS0NiRFpmTW9lZmdZZkFRbkhnZzY3?=
 =?utf-8?B?NDd5YTcvMjkvcUtaQnhJZUdXOWFUSHU2VE5hY0ovOWxRSmZqL3FPYVJBR2Z1?=
 =?utf-8?B?RDBPcEZVQlNzOW5pVlFaWFBUemhFeUJsMlhVeVhXS3dzNmZGcEdkQ3pGZ3VS?=
 =?utf-8?B?Y05aL0ZlZG5EaDZsSnFuVnk5K3QyaC9VaVZ2UmVqSDNNWW9SblFOWC85bDFs?=
 =?utf-8?B?VzdtM0ozK3VhU3dDQXRpWFp1ME1FRXVxcWo2WXJxL3FXWmE2V2g3UCttRlFw?=
 =?utf-8?B?SG1tWkg5WWdqSEVrdUtUS0IvcVVtNUJsMGcwdndhTy9XRHJ3V2ZVRGJhNGF1?=
 =?utf-8?B?NERWZTJSdmh2bHNMVzVQOEpQTXBmQkhSZTJMa3JieE8zenFUK1F3VU40RGo1?=
 =?utf-8?B?WWVSL3BFcDFPRXRtR0NWNlR1ZHh6WTh6ZWxwYWNMK1hCVVp1Z0RVd0x4VFZF?=
 =?utf-8?B?Q1g0T0dxZzBnSXhxYTYvYkx3TDJNNFBlalAvQXFaWkRwNlJ1TDR6N29rRXRl?=
 =?utf-8?B?L1NhOTluUk51b0hYOTFFNW5lMDhMTU5CallNcTNrbG9TT3N2TFNSODdIc1RV?=
 =?utf-8?B?NURqdEZ6Vjgya05HU1VMMFVScEZNb0piY2hUT29jaldqQlplcVJiZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91353ef5-4b7f-46ef-e32e-08de97339dbe
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 19:01:48.0351 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: filZwYYLgsHNzRsIx4btD08f3UhFbZOnY+cKKT3mbSlFsZJxTz4zAekPkvvpIQ9qtbhGT4i7JSSU9Oab/slnCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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



On 4/10/2026 12:56 AM, Eric Auger wrote:
> 
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 SSID size property to be derived from host
>> IOMMU capabilities. Derive host values using IOMMU_GET_HW_INFO,
>> retrieving SSID size from IDR1. When the auto SSID size is resolved
>> to a non-zero value, PASID capability is advertised to the vIOMMU
>> and accelerated use cases such as Shared Virtual Addressing (SVA)
>> are supported.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 14 ++++++++++++--
>>   hw/arm/smmuv3.c       | 11 +++++------
>>   2 files changed, 17 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 9e7ec6a930..03393fd7ba 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -56,6 +56,13 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
>>                                  FIELD_EX32(info->idr[3], IDR3, RIL));
>>       }
>>   
>> +    /* Update SSIDSIZE if auto from info */
>> +    if (s->ssidsize == SSID_SIZE_MODE_AUTO) {
>> +        /* Store for get_viommu_flags() to determine PASID support */
>> +        s->idr[1] = FIELD_DP32(s->idr[1], IDR1, SSIDSIZE,
>> +                               FIELD_EX32(info->idr[1], IDR1, SSIDSIZE));
>> +    }
>> +
>>       accel->auto_finalised = true;
>>   }
>>   
>> @@ -828,7 +835,9 @@ static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
>>       SMMUState *bs = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(bs);
>>   
>> -    if (s->ssidsize > SSID_SIZE_MODE_0) {
>> +    if (s->ssidsize > SSID_SIZE_MODE_0 ||
>> +        (s->ssidsize == SSID_SIZE_MODE_AUTO &&
> maybe worth adding a short static inline helper pasid_is_supported(s)?
Yes, I will include that in the next refresh. It should look cleaner in 
smmuv3_accel_get_viommu_flags() that way.

Thanks,
Nathan

