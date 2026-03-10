Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1F3FD4F09
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 17:14:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w00ej-00028x-Dv; Tue, 10 Mar 2026 13:14:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w00eh-00028j-0x; Tue, 10 Mar 2026 13:14:03 -0400
Received: from mail-southcentralusazlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::1] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w00ed-00061q-7K; Tue, 10 Mar 2026 13:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s00FLSBn+MZtQthZwoRnhlsKJUjvmFrAGgoU6URXcp9ccggppMpdarNqmn4OrA/uCiiciwsayUsxG+LcL7IPY4bPnXW4BKD8i2XKe72SIREJYeUToDHuNIrrzh1icETOi2ONCHNWfsC9WIGqhSYClsuLMRyq82BTuuCkdCoh8B6Frw3Unulz6dxxgxhcN85KTXSQ6VmEmU93DYsFBYh5URQK50PP1tvlDkZ39BxusDHW7Wvmqg0YNV8a/+nlqu1fFYLNpO6mZw/u32XhQwwW9Psfv84ysRQE98PNvEa2vZnDM8QY+kzwQkBg8joK4ZLjIPku1dYyuPBmwdgOjhOLfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YuF1sXdaJ/Wn7bP01JJwlmbCkmd8ACLl0XOL8TWqGUE=;
 b=RYqFk8gb5r5UObHy0strJPRz489dRXocUjDioupQ21vETjABNWzFIvabJA7je5aQjtwraqAyFAFK5rYxj9L3LUT4l4u0p2TlHVLQ0I8oa8+4ndJ/fDg7cRW2+oG1p1P/B/meMz/Sn1fPzAuWmmUPIVAgnc6zt9uH5KqW/Gcokjr0WAsv1tovXgPtkX3tMDbxxLoDXZ22WqEM6sCURnc+HCvXotbEjAm7bQLwAOuD6VZpsccDWrTuq2UYBePDxpu9rfo3e0RobNFvBa/BoNsfNdbyJeE1AxdYxYQelSNeGNqGoRqCD1zX/R6dQKwn043+RtzxQ80haAPcAtfHLnvVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YuF1sXdaJ/Wn7bP01JJwlmbCkmd8ACLl0XOL8TWqGUE=;
 b=dstvTWdMLsezO2DGZFKHb7xnGLYJooF5Qireb0IqKC/jxJAbdpT09zRF/0WCh1XPhQgmTPF2X4G5lsQt6dKEn8PpLCQecK16m1w5PPt0GYqqRW0+T8bZfDP3XAJJT+hvOoiz95GJRwyP57hKT2C2wg28OXqUQuvCKRS3hhuhZbgdwK7Yf+xEv9cdgOKwATEiq8W69ZHfSNegD0pb5skWtJn2poUzWLNLDPf56NFBMjP/Wz3quHCWRBP+dEjepDvNjWTnJegT0+gfTQ/wCsMqS6e8LLL6xmt9e5lU/q7RLDwytbZYNMEBcsnVJHXkr5epGKKadJP2o+PyI7goOg9dQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA4PR12MB9810.namprd12.prod.outlook.com (2603:10b6:208:551::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 17:13:53 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 17:13:53 +0000
Message-ID: <c9b3d7ab-e497-4af6-b6af-201c8f351bf6@nvidia.com>
Date: Tue, 10 Mar 2026 10:13:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com>
 <b76df308-6731-4d30-9665-34d4cb71159d@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <b76df308-6731-4d30-9665-34d4cb71159d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0108.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::23) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA4PR12MB9810:EE_
X-MS-Office365-Filtering-Correlation-Id: 58435ec7-e9c4-4a0c-0df4-08de7ec86784
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|366016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: PpCUakku/1hI2aQsCauBM0RIuIoNHzwGH8E2R+cGNEFuMew9gKvbXKSftc3zP2CdiL/okYpWAaZL2W7hdM8s2M8l6tWSMYZnyKL0tSXjUMuWgtDDKy1fVpC6Wj+MW/dR0xZ/VWHvSpGVGZtpkmUN0pPVgAkYuzpeZ9EhXqhlogVrnqSY9O/5jrBgELjAFvAHBFw68wV7lZkbORHS7dqEKjhNRruOFuaz5/hseKECFv7f1Oa6u8os3Q3ItHGIBWNF7j1fL/kB81rSCLyutozMfngyDyJ7vYo9uKU2f4htWjTQ7JcprIzqRCBB7m/6JziUHbuD+Tzxt35aKgW97yH2xEfWR4rdp9s3CJ2NPAkE7r/veUuqlqqGdiBqfpOA+3I7dyJmDA/lTkL6m5tU69BIBciJbWopPjIdMeB47bIDzNq7ntgLL1V/cGvl+KLNEeC2LC70O+/vtlMM1glQlMk9XrSGozlpAPkXF5wg1K38LbYcXakpx+c/QsysismrEFhowAoxNJiAYm1P8++5nZRctSFGUe+Z7K3Kx7nO85LBzcWZ0GsyvShCE2C0IH3ZdLUzQeAJTsFBSr+n5B9bGdrn59/N8sT90dlUFVfa26BQ7VZPSeBqzIa5MzK56L5YNxvl5ypgVPB7uRm4QXg19mG0vWYtqld5ajcgFfULqan2xsqfbkx/4cxmrPLtwNkUoLoGELnxjQ4EqP1D0xCa00fDfSjLrBPqRuxRuvG4En8B8J4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTZRRmZFd1ZpYk5Sb1pXTU9KZDJhcmFVUmhNZWNLSUpkSCtKdzMxZWxSUGtV?=
 =?utf-8?B?N1lsQk90ck03ZWsxSEZrOEMwVjZ0UE5iV0t4aUhZaTlheGorR2M4N2FNVWY2?=
 =?utf-8?B?bzh5S0lHSGkxWGNmN0RDY0t1QlFTMG1vU2loWWF4Wjl4Ui9nOWZGZzNBVndF?=
 =?utf-8?B?WDhwTHBFcEtBbmFIWVpka0haTk1IcGVqM2xRUmVKWnV0L3pySUNGK2J6eDNp?=
 =?utf-8?B?TUJubmpqaEwwdENWM0FablQ2amp2ZE1kc25hemJlUDlMYkYrNk8wa3ZTajZ2?=
 =?utf-8?B?VjhzOU1rdU9NeVZjem1jSTZOaW0xV21FY0Z4eUZmUXppRGV3WTN6TklFQXEv?=
 =?utf-8?B?Yk9KdzdQN2c3QjZyTjgzeE15UG4wa1FpdTIzOXI3TE1jb2lKWFlMVTBXb2s5?=
 =?utf-8?B?bjNOSmVtNmV5VnZ2NUYybmlxc1c0V0xYaWV2U3YwMzZpUDVtbDg0OTdQYkUv?=
 =?utf-8?B?eTkwZktlRDdzUnhGWnBGL3hEUXAwdjdFOVl2MTJPTXhvYkx4WHRNTzBRYSs3?=
 =?utf-8?B?Z3ZXN3k2S05iLy9qelVNb0tLajBrR2xxMkJrbENyQ3pxdFZNM2x1K2dCb3dS?=
 =?utf-8?B?NlI3RTJQbkloaGNKUy9sUnZNcGhRK3lQT0pONmVkRXhBMXV1aWt6TDB6OGtx?=
 =?utf-8?B?bUJYNjJaWG9kNytQUUEwWEN1RDVUNGE0Mzk5cGFHcnpFYW5nZkpzSWdIVFpl?=
 =?utf-8?B?cS9ZMU4zVzRlMXg2eEQrcVVvU1FneGFCSndtSEFDWmxHcmUzM3JKL2lmamhF?=
 =?utf-8?B?QjJFcGF6QksrQW0rblZlNDJGK21pcC9CN2lnWG1JU25VRi9xZTFSOXhjRUF1?=
 =?utf-8?B?YVUrbUdUNUk4NkRaKzR1OVVaOHJrTXIxMjkwRTB0NTdLS3NiUUN1RytpeVhq?=
 =?utf-8?B?R3d1UkRiUzF5SHIvdVRHV1VwSWxpUTJkcHRsaCtFemRaZkhsaTg3bmVvTlB6?=
 =?utf-8?B?UHMzZk5kYmxLbms4UXVvdnMwZzJZMDlsMU5tMXFDWk54UFA4VFhMY3FVdjNt?=
 =?utf-8?B?dDVaS3pMb0dMbkhDVGo3SWtlbGlRWm9UeS9CcnEvVGREcmY2TURKSEpTUnFl?=
 =?utf-8?B?NytucitGMnRNK3VhQStVTUN1VTBPc0ZkdTJYbmc5S01lK2tUc1c4V011UFBj?=
 =?utf-8?B?RmxnN1VPSkwxMWJRRUN4cS9HQlF3eGh3aGV0UEUvRm9OdnErZTMvT0Vpd1NL?=
 =?utf-8?B?S3FNenZtT1kvVkk0YWZmeWI1bytDSlBkOGNSNG1ZditCS2hSd29BWnRuTDhL?=
 =?utf-8?B?eFBrRGw2a2s1Um9HUy9LbUlZQ3UrbkFoV0tXT056UkFnb1ZHdEhFd2lWeWZO?=
 =?utf-8?B?VWlRWW5VTE5PY0tHRkpXZlQvbEt6YWZHTHNmMzRoaWljTWIrTTFNUkI4c2lG?=
 =?utf-8?B?SnZTeGtTRUI5eWo4UHdvSENLSFRTZmVxQjF3NUs1RmF5REZUYncxNFZJRUhq?=
 =?utf-8?B?VE54OHFtV0xTUUkzUE5hVWVJZnNWS1ZxNzZqVnFrQlRjVTIrbWRudUllTS9Y?=
 =?utf-8?B?TUJWZml6aE1rSDh0LzI3UlZMZlNPaHJEbHRUa1ArcVlCc3k5TEZuckZxenNP?=
 =?utf-8?B?ZTRkUXhyeFZUTFF3VDBTODJxSCtDd2xwbXp0OE03L0xFV1hMd0M5b3p5MnV4?=
 =?utf-8?B?VEZzZlNzaytYK3g5d3RIU2xDaXdLb3VWdTl6dGJ4cjFRcUxUYThvMEFPcjdN?=
 =?utf-8?B?bnhYajRCVjVvNjZOZXJpd1piMGtZejdBZEFUYnV3L3laU01mZ0daZ3NGMkV3?=
 =?utf-8?B?ejB3Z1g2Wjc3VS8yTG1OdTVWWXlNNDZMVXErNE9QOGlNQ1M2L0JET3d2MWZp?=
 =?utf-8?B?akJIS3NFSmFoUFcvRVhFNkV4RWY5eHNEaTkrdzBEV1FTUDBCbHNSUlZ0ZmVj?=
 =?utf-8?B?ZXhsWlZyVERucHN0UStybjJUeE1rY2hLYnFaNjRNRjZGMUVYTko4WGRiK3pC?=
 =?utf-8?B?WnE2WFZKL0R0MFNqQzU3NjdoY0ZxWkR1eis0eTV0SXp3VXpWTEZ0SzRXdjBt?=
 =?utf-8?B?bUZnR2NiblIzYTRydFkza1E3ZGtBcjZjbTNFbEpHZEgxMndpS04rVTVyeTZR?=
 =?utf-8?B?NXl1NnBUVVkzdCthTUQzMVdLaENGTnR2d1BXcXpaY2pLYmxlL3BTNEVESVNv?=
 =?utf-8?B?ZDJFbUo4Z1RtUEhVMStEVnRyUUZNUnQ0UjkxYjJnMm5OMXVGRmNwTnZPd1NZ?=
 =?utf-8?B?b0lNVWRJcW9sK1htVXFBUzBvV1RidkxTRGJZUk50cGJkMVJWNHRRVzZHZUM5?=
 =?utf-8?B?aGN1eW1rc09nQkRKTmF3TEpkVitIallDRnRGNHowQXN0Q3pWTVJ6YmxsazVl?=
 =?utf-8?B?bk91VU9ZS0ZtaHdjRlJYajJxK1dOdk5uL3Zab2ZQVFNXSGs4SXF3QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58435ec7-e9c4-4a0c-0df4-08de7ec86784
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 17:13:53.0226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TxT81d6edgzpysPxtI+vHmEO/msP5kaCzUed+8lgyUKQxyGOnSH1EabDe8PY4pLywqElyo7u8ixEpUSBpBx1mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9810
Received-SPF: permerror client-ip=2a01:111:f403:c10d::1;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/10/2026 12:42 AM, Cédric Le Goater wrote:
>>
>> Subsequent patches will make use of this helper to set the
>> values when we convert the values to OnOffAuto. New auto_mode
>> and auto_finalised bool members are added to SMMUv3AccelState.
>> smmuv3_accel_init() will set auto_mode to true when 'auto' is
>> detected for the accel SMMUv3 properties.
>> smmuv3_accel_auto_finalise() will set auto_finalised to true
>> after all 'auto' properties are resolved, and subsequent
>> calls to this function will return early if auto_finalised is
>> set to true.
>>
>> Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 38 +++++++++++++++++++++++++++++++++-----
>>   hw/arm/smmuv3-accel.h |  2 ++
>>   2 files changed, 35 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 17306cd04b..617629bacd 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
>>       return map[oas];
>>   }
>> +static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
>> +                                       struct 
>> iommu_hw_info_arm_smmuv3 *info) {
>> +    SMMUv3AccelState *accel = s->s_accel;
>> +
>> +    /* Return if no auto for any or finalised already */
>> +    if (!accel->auto_mode || accel->auto_finalised) {
>> +        return;
>> +    }
>> +
>> +    /* We can't update if device is hotplugged */
>> +    if (DEVICE(pdev)->hotplugged) {
>> +        warn_report("arm-smmuv3: 'auto' feature property detected, 
>> but host "
>> +                    "value cannot be applied for hot-plugged device; 
>> using "
>> +                    "existing value");
> 
> Please add an 'Error **' parameter instead.

Ok, if we decide to keep this hotplug check I will use the 'Error **' 
parameter instead here in the next revision. Per Shameer's reply to 
Markus on this patch, we may end up removing this check as we plan to 
fail boot if auto_mode is set but auto_finalised is still false from the 
lack of a cold-plugged device.

> 
>> +        return;
>> +    }
>> +
>> +    accel->auto_finalised = true;
>> +}
>> +
>>   static bool
>>   smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                                    struct iommu_hw_info_arm_smmuv3 *info,
>> +                                 PCIDevice *pdev,
>>                                    Error **errp)
>>   {
>> +    smmuv3_accel_auto_finalise(s, pdev, info);
>> +
>>       /* QEMU SMMUv3 supports both linear and 2-level stream tables */
>>       if (FIELD_EX32(info->idr[0], IDR0, STLEVEL) !=
>>                   FIELD_EX32(s->idr[0], IDR0, STLEVEL)) {
>> @@ -124,7 +147,7 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>   static bool
>>   smmuv3_accel_hw_compatible(SMMUv3State *s, HostIOMMUDeviceIOMMUFD 
>> *idev,
>> -                           Error **errp)
>> +                           PCIDevice *pdev, Error **errp)
>>   {
>>       struct iommu_hw_info_arm_smmuv3 info;
>>       uint32_t data_type;
>> @@ -142,7 +165,7 @@ smmuv3_accel_hw_compatible(SMMUv3State *s, 
>> HostIOMMUDeviceIOMMUFD *idev,
>>           return false;
>>       }
>> -    if (!smmuv3_accel_check_hw_compatible(s, &info, errp)) {
>> +    if (!smmuv3_accel_check_hw_compatible(s, &info, pdev, errp)) {
>>           return false;
>>       }
>>       return true;
>> @@ -595,6 +618,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus 
>> *bus, void *opaque, int devfn,
>>       SMMUv3State *s = ARM_SMMUV3(bs);
>>       SMMUPciBus *sbus = smmu_get_sbus(bs, bus);
>>       SMMUv3AccelDevice *accel_dev = smmuv3_accel_get_dev(bs, sbus, 
>> bus, devfn);
>> +    PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>>       if (!idev) {
>>           return true;
>> @@ -613,7 +637,7 @@ static bool smmuv3_accel_set_iommu_device(PCIBus 
>> *bus, void *opaque, int devfn,
>>        * Check the host SMMUv3 associated with the dev is compatible 
>> with the
>>        * QEMU SMMUv3 accel.
>>        */
>> -    if (!smmuv3_accel_hw_compatible(s, idev, errp)) {
>> +    if (!smmuv3_accel_hw_compatible(s, idev, pdev, errp)) {
>>           return false;
>>       }
>> @@ -867,8 +891,12 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State 
>> *s, Error **errp)
>>   void smmuv3_accel_reset(SMMUv3State *s)
>>   {
>> -     /* Attach a HWPT based on GBPA reset value */
>> -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
>> +    if (s->s_accel && s->s_accel->auto_mode && !s->s_accel- 
>> >auto_finalised) {
>> +        error_report("AUTO mode specified but properties not 
>> finalised.");
> 
> This is not a very friendly message for the user.

Agreed, instead of 'properties not finalised' we will note that the 
properties were not introspected from host IDR registers, and that a 
cold-plugged device attached to the SMMUv3 must be present to do so.

Thanks,
Nathan

