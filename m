Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CA3F45A08
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 18:54:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBGzZ-0004gp-Te; Fri, 10 Apr 2026 14:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBGzX-0004g8-MI; Fri, 10 Apr 2026 14:54:07 -0400
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wBGzW-0007VH-0s; Fri, 10 Apr 2026 14:54:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fh8klnz64fc9pZ860Y0D1m3iPnupGv7Zt9Q2rQXQsZu34eV7aMKYB0EtgFx++A+gsxwK8FDEtfRlXWvY5ogk6XRIBN13WaZuYbba0q9Jn9CqeUw/tV6+i3RUbaU9c1/r9p4u3InTLpQZKGQrhmc5Hw8rJy8P3L1VZXr91zMQju+gk9Oi53hSy8NZfEa2XnM78xoUASd3e3GBz+M+q9JU4Q2mvOZ6ZsCL0EMJfi+18qW6BoXTq3myWkBP3uU5xZljP63S5BtpaVkLPIfCADicXfqn55pMQV+uw6mv7ddJWiwd/qRtsl4zwTBgwVYhIkJmnkPMwGI84P4l5i/iRbcbVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HtRD++E/WI3LQ6qUf30C9kL42MjAj6hN16Qj72C6LQI=;
 b=x1QbqLY8rgetPVyknpLafVxCBEn80iKbGD6mTqMJr8mbxhmfKSQYcMy7G4q9DiWC+gv/8swBTuKtBwNKiNGq0L+1G6cCWKLPXdaf188+NwPDs8wAKi+Cb5t15qrNjNEPsQu1H5RsRrnxbaMKRRJsLHPXDzzeLm5yWBEPJGkY71/7DsxptNquJt3aGrX1pj5Tbuy10QdMTn/nhi3WYsAoMruqEehWuLrdECtu6eyPOZ70LNfNk/ow/sq5SBQQGmUlwTBCX+3Qd/KkoR3TkkT8/lMv3fYmhMcSETX+kUXBvYtoQj3yGfaq4MpkN0ou6u9HZ1DijiwPKWXAuQaHJyYwBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtRD++E/WI3LQ6qUf30C9kL42MjAj6hN16Qj72C6LQI=;
 b=Bav/mjGdqpULDhZqeq/BspSkS+9m6VIrFKqCOn/KNhLjJLVMTvutq7bo137jbPQjb5FgtZOdO/6iiN9YT66bXvSm5d/xwR2IErTuQfc7HqT9b7F2fQpfjtdATVabItsdVJkq0CdpmeFHozIzaA/cZHIMnN23urOc+EsMF0zGHOJEh3xQT3+CVDY7nXyRvQmwKszsJASDrUQsNZXGttHIISL8KCBhHlVWLUI+en5IQChUylPJVYSHigoHsmnDfyosmzG3TJ0q6b9GLSJ+UKRBDocf8UB7L+8pxPFPrTSVIzpHpuSf0M/Nd4VK3OkPQ8N8akkS+do4lmAJcA2CnsCnGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.42; Fri, 10 Apr 2026 18:54:00 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 18:53:59 +0000
Message-ID: <89a2076a-d70b-484b-87e2-95b2267ae92d@nvidia.com>
Date: Fri, 10 Apr 2026 11:53:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] hw/arm/smmuv3-accel: Implement "auto" value for
 "ats"
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
 <20260401010231.4166776-3-nathanc@nvidia.com>
 <46116b64-c7a7-4d9a-bd99-a6b81fd45fed@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <46116b64-c7a7-4d9a-bd99-a6b81fd45fed@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0088.namprd05.prod.outlook.com
 (2603:10b6:a03:332::33) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 815386a8-4da5-4439-8f50-08de973286a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: LzXWRV54YnJRIwkyVO5JY7DxdGckonpYktljEDeBHSC1vibc01A5x7uiGIJPMO0A7YFA6VwSbVv+TEbLFhpsw26dNNQUtWZytjf+Y/o2VWO5U0Pg7Y2SaNxfhmKaoIjhlDYo5sfCk81F9Un8Wa3stfX3lXySW682q0JxNCkPhBiMd+K5oXr0q17I/CdXYe4hma6GZNe5PngAqxF/tj+NTG8cWIjrygDZWPj7phjKYpPVnzUJ5OIILihqCmQ9d18M2FLcn+GZr+u06BjDT2PLfWNAXb+vajs7H2UxvdzAJo2ZD3mMJtDIzQRJ1UwkJI2gvYXL3GlMkhr31Ufq9V4aNBXMNZBQAo2Mqax+BI2HqtcSh8zB1SRlCFLchvUARVxfxPuRQnC+mWTB7EQEExhlJxu0qg+lV8v3BxEnbXj9UfuTUSkFBtqHxz6BGITVyCeiGWVTX3o/sWNw4bt4rzg4Kqhc1hQxmseCiUBbPR7foKmWy/ceJyPngLw4SDB6hOlVHaq36RCnmmnciCCJz0LczdhK33iOt9PPHqi9EDqMrdwiqVEeY+jhg0hhydDF6RtpKIiSgjTgyZzr2tTRvH226+2JRp5mIDBwKfJw2XNebB/0igsltv+ZHJWmGdDbcJ9noxTWH0CL4DLD79L53I0lCoZk8bW9KtezjsEkKyLlMMROLJ5YVHRSrYpu3aisUDZyyPRD05O0KBU+UNswTV8penMkfNGMi83hzGCjg3tqASA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGk3cFVmYkRYTXpsc1NsN2xFUE1wRHNnRGcvQnBlZjJRV2JsdnU1ZDM4S3Bh?=
 =?utf-8?B?SWtCRVIvVnJDaEtObS9MdEpaRDc4YVNMK3U3NmJKYmJVVU5CNDFPNExnYjdR?=
 =?utf-8?B?VE5qTUFJNWEzaWxqNEp3L2JHWXRXbERIeUpqOUZPSXhUdzBQOHNjemRneTZ4?=
 =?utf-8?B?TWQrbTRKOVlDL29hUE85ZnlRODRWVFdTRmdzOUlBdWlQVDk0Y2MyeS9JOTdX?=
 =?utf-8?B?bVZvcWNTUGorSDhidnNMZ2pCdzVPWkF3ZjViV1djK3ZmaDlDQUtDQ1B3TkQ1?=
 =?utf-8?B?bzZCZ3c5MG9GTG9NeGRWam1IOHd3WllGTk4xZExvWjA2WGcvYytMVUxxVWUw?=
 =?utf-8?B?UGtXdGFsVVZMMGpGN2FrQldpaVR5UXAwUTQ0bktueGdjcE1EWmgrbFpsZnIx?=
 =?utf-8?B?YUdyWTdGR3ZJbGk3Nit4Sjcya0xTRllhd2MrSGdSNWJnRDNZR2tOMFNieWo1?=
 =?utf-8?B?UElSSWxUQkc4V0EzOFdsZk5hY1FuT0ZTSFFkU0U4OS8yRG5Dbzc3WWU3N1h4?=
 =?utf-8?B?YzdUUEp4cU9vcGJzdUd5dEpBQnZiN2tDVnZ2b0wrYUZYSjYvUUJ6NTV4M3hF?=
 =?utf-8?B?bm1ab0orM0RRL2NtNFEvVkJBMU1ybG1VcjJFa2JSR1FmRmVYVW5Teng0Tmh4?=
 =?utf-8?B?ajlzK091aUl2WWNQYytEVS9SM01NL3ZwVGhWV21WUWd1TzN4ZWV6cHVVVUx4?=
 =?utf-8?B?d0pqWExYU3RSZ1huUTdpZ1VTREZoTHh6eXpFSG13M2ZDeGVSZGhPbFJZRUxO?=
 =?utf-8?B?aTlEUHAzVmd0dzZrM01PY1pHQk1WM25ZaHIzK01BVkRHc0RvcXNYOTdsQ3d6?=
 =?utf-8?B?SFJzSWtWMjY4UjBac3Voc1M4R29leXpBSDR3TmZGMThBRnFJaTNVTCtDc01V?=
 =?utf-8?B?YyttcTlxdnc4Tzd1ZzJaa2pHM2FwV2M0eGRmem9adFN1R3VqbjBxZ2FIK3B6?=
 =?utf-8?B?czAzMGkvUWlteFphdVZhU3Avd05LMjZQVXE3SzJsWW9mUEhLWUZyNUdtZDRB?=
 =?utf-8?B?L3NnNlhzS2trck1XSXJHSEc1NXE3bUwwSXZ2bnpNcHhDWXFlQW5MUGp4My83?=
 =?utf-8?B?WVozOEZqTlMrbm5nMzcwUUtiTWVjcStWdnA4dnpZWE8wK3dZbzJmd3FiVUFn?=
 =?utf-8?B?bnR2L3dlRjBINytqcG82NjAyUmQvNGJKVGN6TDV5ZENoUVlZZXVLVmcwRk5j?=
 =?utf-8?B?WWpRWHNTSlFWSHhLNVdrR3dQQlZxaVg1U0ZEUkJEejNqdHcxSUV6YVZ3V3FF?=
 =?utf-8?B?Vm9NZng1R0x0a3lpVkJWcVBzY0xaQ094VVZDVVB1Wk5sSEJTTGQyK3VaMDZ6?=
 =?utf-8?B?T0RsYnhTcDVHTmExQjdZQXFIT1dqd0swd3J1V2pYSEFpaEoxd3NMbUhiNDQz?=
 =?utf-8?B?VDFFVFlrRm5RSjNJUXY3NVZLbG56WldCSHNjdVNON3Z4K3BINjVhZzJpRFdx?=
 =?utf-8?B?emEybjBMY3JPRlJkSm5OcTNpcXNJMXBNY21YMDUzOHliem00REphVnd4VkJH?=
 =?utf-8?B?aHA5SEErbWFrcFBFd051eHdQZmFyTkladFRyMzk3eXJpZ0xEeTZkSm5FenVX?=
 =?utf-8?B?NTducTNHbDhrczltMlZTeDhjR3U4aWdiaUsxbVJ4dzM2VkoyTzBKOE1zRmFH?=
 =?utf-8?B?SG5MQ081TkFBazFPcmYrUGwveXJZdXk2Mmw5NlZwQzU3cjcvRmE0eXppdlN0?=
 =?utf-8?B?dEFoRkVkZVMyNHJ6ZEZ6V1c0Y1NZelNWMzR6cU5Gc1pQbWU2cHRpMVZhcVFR?=
 =?utf-8?B?SEpnYWhOTGpRSTFMNzdhVnVibTkwM2dvd0lpWHhtdkRkTEpUdUw3VEVDU09W?=
 =?utf-8?B?UjA5N1kwZDU0QkUvc3pnRWxpdHNSNCthUHJRYnFxdmt5R1FRaFRSejMyZFUz?=
 =?utf-8?B?RURqNThTZ2RwNnEzK1NUK3lram9SSkJmRS9KTHR3UFBUdVVvL0krajYwOWh4?=
 =?utf-8?B?U29kN1Yya0xjdjhoNm9DaTZSbGUraC83NU9SaXRyd052QlBYeFhLeFVtU25T?=
 =?utf-8?B?dU42L1hhUS9uTXB2bmRaNjM4VmM4aWpNNVdiSERQRk1WRkM0aUcyWmlUbVQ0?=
 =?utf-8?B?WUloUHU2YkJ2Q0JZVVdNbEdaQTBGbFUyandSZWRqM2w1WmJFYnFxUXZ1UXpQ?=
 =?utf-8?B?RURBQm5EOTBQMEZKejdxaVFvU1NtZ1Fybm80Q0dmaDJTTXVKMWg3YXh2SWdR?=
 =?utf-8?B?bkFNQzBWQjYxWk5JKzBuemo3emFwNDNwRjRsWk1NVDJ6TEVnaTI4RmJiV1Q4?=
 =?utf-8?B?amVqbGtISnM0RW5BWmdva0V4RlJmY0NBdStzdnFoVTJNQUN0eVlKQmY2VXRG?=
 =?utf-8?B?dUVtZkV4cnh5WWEzMGk5VWFwQUVNbldNR0RtM2lJY1JCdzV1Tnc2Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 815386a8-4da5-4439-8f50-08de973286a5
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 18:53:59.7681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlHpzNMedrw2Tcyef8ekWv4J/jInf8okkqvLxNtW6U2HTpsOhEdP7zpII3/6XDXUwwQqZDQdxMOB2gXYzHArTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=nathanc@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
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



On 4/10/2026 12:36 AM, Eric Auger wrote:
> 
> On 4/1/26 3:02 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Allow accelerated SMMUv3 Address Translation Services support property
>> to be derived from host IOMMU capabilities. Derive host values using
>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 10 ++++++++++
>>   hw/arm/smmuv3.c       |  7 +------
>>   2 files changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index a0146c8d31..a835c8f220 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -44,6 +44,12 @@ static void smmuv3_accel_auto_finalise(SMMUv3State *s,
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
>> @@ -938,4 +944,8 @@ void smmuv3_accel_init(SMMUv3State *s)
>>       s->s_accel = g_new0(SMMUv3AccelState, 1);
>>       bs->iommu_ops = &smmuv3_accel_ops;
>>       smmuv3_accel_as_init(s);
>> +
>> +    if (s->ats == ON_OFF_AUTO_AUTO) {
>> +        s->s_accel->auto_mode = true;
>> +    }
>>   }
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 09ea08eb18..f3603554e3 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1973,10 +1973,6 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>       }
>>   #endif
>>   
>> -    if (s->ats == ON_OFF_AUTO_AUTO) {
>> -        error_setg(errp, "ats auto mode is not supported");
>> -        return false;
>> -    }
>>       if (s->ril == ON_OFF_AUTO_AUTO) {
>>           error_setg(errp, "ril auto mode is not supported");
>>           return false;
>> @@ -2196,8 +2192,7 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>           "is not supported.");
>>       object_class_property_set_description(klass, "ats",
>>           "Enable/disable ATS support (for accel=on). Please ensure host "
>> -        "platform has ATS support before enabling this. ats=auto is not "
>> -        "supported.");
> I would explicitly mention that auto value is supported.
> Maybe:
> Set ATS support. Valid values are off/on/auto. If set to on, make sure
> the host platform supports ATS.
> 
> You have examples in hw/arm/virt.c. For instance msi option.
> 
> Also note that the doc in qemu-options.hx must also be updated.
Ok, I'll explicitly mention it's supported here and in qemu-options.hx.

Thanks,
Nathan

