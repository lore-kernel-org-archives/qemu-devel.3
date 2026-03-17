Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2929AFED9EB
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X1L-0000tn-Al; Tue, 17 Mar 2026 12:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X1J-0000t6-P2; Tue, 17 Mar 2026 12:11:49 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X1I-00032L-6Y; Tue, 17 Mar 2026 12:11:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XFJi4wHzl5RG0RQs9L2WnHxdcniTrf5p/K++i7qiPZdym/KPGE5xsO0KVv9kyNdvywFXn6Aqo6e4qLVAlVHGDz31zFg+RyBqtgSucB0/EBhTRdmruRF1FQolUc3EZPjJnoZIJ/S5yaOps1IBPcQljEsSJzdgmZnOsGR75UuwJeKiHLVwgM58GXjy4jvYb1oqpBgMjZ4BLZr4Mo5OdULz5FIB2F9RCp441oEyAs+WzQiIVbNrePI9kgI5TCmvRG78KFuOFpBwUfyVPUJuPs/fQr+XoXtakPwZn4/TWFBSGJ4vOHvAjfvePj5/mI2TiuGP9Kf6DjaXQT/HS1StdhnBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umiVV3EoTd6YZ0g1R4sR7b47lWg2jlX8CVzH5ZkL7uE=;
 b=GGuMyNd0oJNU9X3XU9WThAHfTIdO1E+UgvWi9mZWj9UT8+E+2oJE6yuCqi291JV84lMkDLvDb3m9uI7/ftzf8n0OhBPnhaZsDsvy/4DViizkJQDkt31noZvE0R8/CjOXpueSGQhDYBkLnAqplGhjT3XaPW2KZcdMZ+8IvMzXUVho7rHlCBBLzWbejz4jpohmWc6WV9eSpPkLUZxSPXB+x8sfyZXzd9a/u0kuFthbpR7k+HJ7/17ElepL/mjqIE7Q143OV8lyar5sEL2ofoA659RyLCCDJM37E13OAvGqavb7rtlZfm6BD+A8Wjh6YGmx/htY0D7X1JLIaAA6aTMtCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umiVV3EoTd6YZ0g1R4sR7b47lWg2jlX8CVzH5ZkL7uE=;
 b=pSC7YoMLjIX/VPjD0i8qQudzO8RR8gxCQnEYiYQ3OaAbVhznC+Q8Pfq60W7hkDyUvAjk5fZpmCYPEauDbBXJCH660wPT8JFR3ONXF7HvP1Yf2SOBtElrrMNHFOM8+Ed7SvYgfncoB0L9Qrba762aIlrx8XQf34crsfeZPt5TI0udwTtdlGfBXHxqto5PQZi7brXf35U3jNGC91s8VLeQBNZzFrosc9RAJS/Wy1XkSDhLsArE5cmVM1eewB2fpnGKvMyzlcjTJXDqZ8wmLn7Hn2R+mn15ESzLl3f7PZvkzBBrMNlLB2HedWJr6zi3G4l+Mw+rk/pOUuORCv2/J86GUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SN7PR12MB6861.namprd12.prod.outlook.com (2603:10b6:806:266::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:11:40 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:11:40 +0000
Message-ID: <33dc436e-a298-49c1-8862-80d4552b9478@nvidia.com>
Date: Tue, 17 Mar 2026 09:11:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/8] hw/arm/smmuv3-accel: Check ATS compatibility
 between host and guest
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
 <20260312210328.2016191-2-nathanc@nvidia.com>
 <6ec20b09-e64b-4d78-927b-80feabf9adbf@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <6ec20b09-e64b-4d78-927b-80feabf9adbf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SN7PR12MB6861:EE_
X-MS-Office365-Filtering-Correlation-Id: ad6055b1-ab56-4b7c-8316-08de843fdf98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: HskwG1v0z02hOzJr+28WB57KbU/G/spQmuWm7JizaKUENj4xNGrMqZTkYLh2bASzTx9B/fmQsI2+euHsmWf3j5UKDcT9Y+TRYQIj4RtKikPsBGzGgavG1AqOU+HJoJ/g4pBWGHNvNKsjkrIZ40MTRQxRbXaHObNjI39Izo4ydKaXzkepWbGzXkrTFtB3qmN/dkNcI+r9WaQCrw8FVqX+JBwTuVFOMYU6DKFXn24wewkbU71d6OxLnyznHnGrJgNHaGOCpHckLrge0pADBsFL5KBHcYfkOfCj17DRPVq2yxMdgwW5ErMQ8zbieO0O3FdYJ5JSiDpRJVj4jYPumAKUkzdpPIRibCYO8ZiLd1C5uw15zNDZrRc6DbGibwGqiV3KDkoqbGzlmXUjPd/w8bFMXL5AO5u3Vo9lNjmbKykeLETiPSFqowU2CZTudi8bWW6/v85viHXZGK8y8o5HmoC/NgvQAb6uE6iiu7Rtb6MKL82g4I3h371/qLQOhjzupPrwQ2m/d3ZQl7X1Pu4clJYaIdjaJTxbuxTUuhWi7tHegS6loArDrNFqzyj5p9JaCzA+2qQRN73jmkRklIkFn6Sweb2903ea/qHn/MLtZ4knpyXK8apo3IzBwa8QLfN92c5thNNNFrX8c06We9D5QlT+QtKUmU/MEa6B9FMkO4zCH4/05aZf8H7jSKepyeQsWM6ebw0eWvuTHyb/vc1EzVxZ6Zpn0IkU98D50BCN96fhxWE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGdMUE1ITkZYM3RJME5wd05McEZFbzhRS2FnbWFrOWpPbWN2alB3bmRXbUtr?=
 =?utf-8?B?Qm1iajBzVFR4MGhuUmdUQlFBSGVoVGZRTFJXaldDVmxXSk1aVVczY1FLbnd5?=
 =?utf-8?B?enNnSFNVQUNSMUppcVlUNTRlbkpqMXh3Z1NwenMrb2Ura09DSHJFMzlMWXVq?=
 =?utf-8?B?TmlSTnFIaTlKK01QdTFwZnB6cVkvdS9yZDZYcktqVjQ0RDFGWDBXMTFPZ0Nj?=
 =?utf-8?B?VkFyM3JpSkR0YnQ1SW5JUm1mVERtalNCaGZkTkpLaHlqT2crR0tscTZKcjc4?=
 =?utf-8?B?OE9xL0UvcGY3N0puVGFvS0ljKzUzd0o1cGhtaDd3SE91b1hCaVBkd0tJMURM?=
 =?utf-8?B?K1RoTldqQzZoc2JDSloxdEdBS3hkOEZ6VmZEYVlwREtxYVEzOEUrYmxYTHNi?=
 =?utf-8?B?N2wvaGNkcThkZTlXMHdmUFVSR1FmRmFKQ2NqK0ZiQVRBd2hlQ3hHUWtFa1pR?=
 =?utf-8?B?emwvYTJMc2Z3dkJybnN5b2hKWEp5UXJtVHRBVXU0MlpxSmsyaXJxWnZ4dDBK?=
 =?utf-8?B?Vm9ITjZIN1dQc1NvS2RiMGZ4S2YvdkEwTEI2b3RaWXd4bjV5ZzNjYk9KOEpr?=
 =?utf-8?B?Qy9NaExTN2s1bHhwakVhNVJpTi9JWUs4TGRpM29nUGdnZldGZ3RxcXNmSmNH?=
 =?utf-8?B?TmtOM1lyY0VTeGNBOTh1dldNaytwMi8ybWFJUmxCOVNUU1ZsM2lhY09YdWs3?=
 =?utf-8?B?YUp6bVVOZEYxSmtpcjNyVnhrRzVDNE1qUDRTbnVGczZ5MmRlcWI1QXg5YUp1?=
 =?utf-8?B?c0tIQkpMNWR6bDIrN05JRCtQZU0xZ3pLanpVNmwxbi9saWpHYS9EQW5pVjVz?=
 =?utf-8?B?Wi8rZk9MYkFDamM3N2VHeDBoRUwyRzZ2R1ljL2pRTitBcW9wOStmb1kxc3Iz?=
 =?utf-8?B?OTVhdUM2QXZOQjZnVy94anRVKy9FMkYzWVMzaTVnbVI0WnBXYjF1QllsS1ZV?=
 =?utf-8?B?cStCblQ5RUpnVnpJb25KSXcwamJ6RjRrRlU2OFFCWXFWYU1jYStadlpkQWlJ?=
 =?utf-8?B?Wkd1NThqSWJ0UUV6NHRNUDZuWnJ1TXpZSmFCeXpqSVJQRG5pdHhzcWVRUnhG?=
 =?utf-8?B?UlBIb2Rvbk1DWnRpUzhBYkZNT3psU1B3VEdJRTdvTjd6RDJkOWp5bFNVQ05W?=
 =?utf-8?B?N1k3YnhCbGZQMml5bk14TmtNSHZUeU1scEJ0NlV6ak5xOGV3UDM4emtKNWF0?=
 =?utf-8?B?OUtpVS8yTjFSekREWEFSbk9aVVB0S0ZMRHE5YWNuT3lYYktPUUUvWDM3d21i?=
 =?utf-8?B?SjlPRmlFMC8vbG5NQ0FhWVJlNlZ0dzJiT3RwWUFXRzcvTlFIVDMxcEVNaTAz?=
 =?utf-8?B?dVh0NE5PbFc4M25GMGpqVmVweVJ0Z1dqc04zN2crc2JRZVBiS0hwYWlRYUVx?=
 =?utf-8?B?bWFvS3M0Rk5NMk8xVW1vMkRYUVIxSFhRNklzTFNKcmJ4YWs3QjJEcjlWQU80?=
 =?utf-8?B?ZFA1YWFoTlo1OXAvbEdOaGNuMFVHZ3hnMS8yQVhEd1BSY1cxOHgwTVkxZVdr?=
 =?utf-8?B?VG1NMWJyK3h5cjlmeFRVc291S2c4dnhWd1F0UTh5RDllMm10cGU5SFV3Z0ZI?=
 =?utf-8?B?emhyQjc4eFhETEp1VmtpdlZPOXB2cUpDL1ltWjZlVnJrL254TzR2NWJxQTRZ?=
 =?utf-8?B?N1NxWnNrSnN4WmlGeGMrM2FBeUxlRnMzb2xwR05WN1JiTTBLN0xDOE5wOE9i?=
 =?utf-8?B?anFJaUxFZjlJRTk2ekVuS3diWFpaaksyZnRJUnc0djlNS3p0MUxHREZMMFVH?=
 =?utf-8?B?SllRWUluMGVPWDRhajhUMkNpZ1BhenNmZjVvaXRrdll1bUpnYWNRRnJSWGdB?=
 =?utf-8?B?N1Q4MkdRQmVmRnEzU3A4alNBUUlJYkhDMUdCZGxsSmp5akNyVkNIWmQ1b2t1?=
 =?utf-8?B?cnNhLzVIdnNCWm9ubWhmTWV3MkFOZ2tIUjVaeEE1d3M2ZTNOZDE3eFZiTE04?=
 =?utf-8?B?TGFmcW00amg2dVUwSXJOdkExY2pUQStxTGhtakZJM1J6OFRWWVdMcXliRlZO?=
 =?utf-8?B?bWlkNExnbDVPYkdPS0duQXlVWnZ5YkgyQmRLMVBLKzhmaHl1cnRQOHJwRkRR?=
 =?utf-8?B?VGFXVXdKZnVzZzV4TEpYVUZ4Q1pUb3drKzFkZTNsN0JQTWhNdTg1NGJpUHhF?=
 =?utf-8?B?R1RsSW1lMi9sOGtZNENNL1NweDBLYTVqZ1NqcUN5UmtYL0VYK25WT1VJbXo1?=
 =?utf-8?B?LzRJVGNzVUZDR081UUFSTWhWdVNDZlVBOXQxUWtiL0JLRldKZVBZV2NYODAy?=
 =?utf-8?B?c2I3dVA4YzRFbXdrUjFHb2x4OXZNdmRBQXJTRGp3R1BSODBland1L2xzMERp?=
 =?utf-8?B?elgvR3FCWGdHR3VQSTRWekJJWWZuajJMcmh6Uk9pdWFrZk1tWjFJUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad6055b1-ab56-4b7c-8316-08de843fdf98
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:11:40.4615 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WOTCVau1KfIXUXMe4iQb7xSetIUsqBYPL5y1t0kLXCkxNAj4AzIJofnh1XpvtAkvPF6DNAm99E8ewJgNKdSS5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6861
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
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

Hi Eric,

On 3/16/2026 12:32 AM, Eric Auger wrote:
> Hi Nathan,
> 
> On 3/12/26 10:03 PM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Compare the host SMMUv3 ATS support bit with the guest SMMUv3 ATS support
>> bit in IDR0 and fail the compatibility check if ATS support is opted as
>> enabled on the guest SMMUv3 when it is not supported on host SMMUv3.
> Miss
> Fixes: f7f5013a55a3 ("hw/arm/smmuv3-accel: Add support for ATS")

I'll include this in the next refresh.
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 17306cd04b..fe78ce69a5 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -101,6 +101,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3State *s,
>>                      smmuv3_oas_bits(FIELD_EX32(s->idr[5], IDR5, OAS)));
>>           return false;
>>       }
>> +    /* Check ATS value opted is compatible with Host SMMUv3 */
>> +    if (FIELD_EX32(info->idr[0], IDR0, ATS) <
>> +                FIELD_EX32(s->idr[0], IDR0, ATS)) {
>> +        error_setg(errp, "Host SMMUv3 doesn't support Address Translation"
>> +                   " Services");
> I think you can keep it on the same line. Checkpatch will just issue a
> warning.

Ok, I will put this on the same line.
>> +        return false;
>> +    }
>>   
>>       /* QEMU SMMUv3 supports GRAN4K/GRAN16K/GRAN64K translation granules */
>>       if (FIELD_EX32(info->idr[5], IDR5, GRAN4K) !=
> Otherwise
> Reviewed-by: Eric Auger<eric.auger@redhat.com>

Thanks for the feedback and R-by!

Nathan

