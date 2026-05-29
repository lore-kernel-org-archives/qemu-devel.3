Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73205CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:08:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT6Ix-0003Za-9h; Fri, 29 May 2026 19:07:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6Iv-0003Yr-KM; Fri, 29 May 2026 19:07:49 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6Iu-0000IP-02; Fri, 29 May 2026 19:07:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=btB9hrYpgsXg8BmRUX3Ne8k9Evd1uDIE+kk7mF3eAS9z8s9Y0fq9jTtvzNNwBch+V9teVRAnYZciRhM5IK7U0CRXhi0pIbEB0q9qIRvUKlXOoSMzp3tz4rCQPZ2T+19ajeKjrzk8G1KL0RUKXvqmdEPLRUnmw9xcTM3QKInRV3P+ODJaKm8bdNorDhb9nOnbJe4yBUBGH1iZZlgzq4cwQeI+lnNJZWNtIURTkbrOMShMG2dkaqHZvmrOgIo7AdMS9V0djTQyeWzODmMYQ20rzcCE3wYWStYb/UhGsde8+she9TLl3YxfzrcqcmejyQCCV+iZ5W7hCktCQIsEb+cSlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ONMWBD76YkreiEOllU5tYkubRiRJSdB56N2Mas6YCw=;
 b=fKIlwRb7TqVVMIHGbGTnjaO0d3eWURp8bs5f3lrBRCx7WNmCxefBYTboEL2/S74M+qYrmOLm0MJCTceoKNHcnyPlCivzRYyriAVm3f+eyUHGXWtgWLM+wiwKH+sfcD9TTTHkZ0UMnOuNC05zwUbYmsiB1BGtmx+qlFR5/9r27HF1Uj8cqWghvnpOfHeoeQZbQPOJNnHxNQLs0Ot2fbM0FhEr8C754i7yAS7JSK28uq5ckzCodsEw80gisAp6DKlv78eIjDQ2q8Z8e4i0TTjnINQupf+FGe8b11YJgMA3wLITsOvJO3JCpIJhVmTeHWbjyKzpS6mtrhG8gg0nzjHSgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ONMWBD76YkreiEOllU5tYkubRiRJSdB56N2Mas6YCw=;
 b=FZPoCafPxo5WZ0EMj6ovx+lu1DRUMaGbbWn0GYQyB67SSxYMaALs5Nv7HrJFZa/NVCrzx04L5YCXvuncc2c7K1SwctIj0Si0DckhIWxX/lgxPYvA0z84omf7ebUIf5S1SEBPG2lstmVaYKVVUZqdNO1EkqiQWslsbvNlcrzEITE2kNk/JLIQX3Uo+v8cgzBybJ8Svj97voJMBL5Jzxv7M2VtX7dvbINFmoPFTywe/l4ZiGR1JJXuaruaeOjIoq2gxg7RKi3m5RR6h5dwKWiUciph3e43o7u9N6vHkgdvQMAuXcDRdOsn26yqY7u/gUJHVJLjTNmwyL7RZLeDHIHiEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:07:39 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 23:07:39 +0000
Message-ID: <fade4085-ddca-4fe8-99f6-03453acc1d1d@nvidia.com>
Date: Fri, 29 May 2026 16:07:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/9] hw/arm/smmuv3: Improve accel SMMUv3 usage
 documentation
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-3-nathanc@nvidia.com>
 <5a0afcaa-3fa2-498c-86a9-32480619e973@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <5a0afcaa-3fa2-498c-86a9-32480619e973@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0122.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::7) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 1eaf6dd1-9a28-4d3e-227e-08debdd7143b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|22082099003|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 1S1LCfd6Va+P4hyGJ7744n4JC4JyPJHOu+UoS+3dFKqZ9jVpIuv/4RBA8Rfoduj03QDSxPzqhfzlZl0lYgkKvziDSDuZnRpEShBWaW3+mm6oqDRL16pkpsZgN9vLviCZ8JxYss2RiNnNshaXx/VEql944VqktKTK7ua3AFaSdwVbMz5ybtyX1aIhMV54PbjU/NC4/sK62oe+LiAcyso0cUhbwMd3CVvUufPlWbSlV2oiYeFFleW3Qpbu+mbK8tCnJoY3rDrB3t4vjt940SZFOg4uq9vdbV6o8MVjOlN1nU3FJjb0Qy1TAuXLX2jzi9J+LPBNVPp5fjLAXbqfgT2vTNNOFue3NOvkZYJO+ETccadBQcgqqDXaQlfjpfNQaS3PbZNBdxqzCP68EEnWEBlNP+NZKclvGjLSdxCpzCVRbFxW+9Rbm76r3HAEXjUvVRHV9kQEeI5T5/M7RTrnobfVMIZr4iKnzjGht9qkdvKpKX43dcM9PCVdrgaEH76/GPjB0Gh8MT1Y/duWHIhlfvXLV4vePhlGHTeIOlp33uKKV+Aa7EOJSthEd9HG0mOK47cmAXKK+U/XN6AOjw0KGck+Jpvd0nPKX9oOyuvLJrBIe54ZK9iyzb8ZvdZrGAAO7iWOPuFvoeSCpXZniqa7mUVmRyjJvXbsb7CKB0F8Q4Tu4wqtBWbrqAW8slWNbtDyVxQd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(22082099003)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmhVeEtlR0Q4dHppbGJRYXJ6Uy9JQlBTYlNzNTArYUU2K0xsTGVQOW1DdVNm?=
 =?utf-8?B?cjVDYlpKTXdSTVAzRWNSMjE2SnNDdklvVjYvc1FmZktjNjhqUHJKNFFuOGx3?=
 =?utf-8?B?Nnp3emgvd0o2TW00ZkRNVjkxcmZ6cDdjQ25Bb1R4VmRaUk94MjdyT3V4WHRD?=
 =?utf-8?B?YjRsZlZ3NnRZNlVGdzd2QjVHczIwVjlMNStjazNxeDZYNWhrbkxuSkwvclJ0?=
 =?utf-8?B?a0dGNzFFNkErb1dUS3FFUjNaelJEUldVYW9xRmc0OFJqempOZURqdUlqYzIy?=
 =?utf-8?B?TjZySm9IZmZaazNFYXVRcjNVM0JLTHJaazRlMXYvZEdwRjZmWW9KQ0h3VWVM?=
 =?utf-8?B?Smhwa1E4QzlVS1l4OEEzUlFETGFhdGdSYXowMSs4SnhKS2lFSkN5bDh4dkln?=
 =?utf-8?B?VVg0R2JDMjRJTXN5MVphZ3Q2eFNDUDFvVXZrVzlsMkdvNnliZ0c1WWFnbVYv?=
 =?utf-8?B?bVF1cHBVUi9EeG5UUWhDSGZBQk1Oa1Y4WmdVUFJXVElPYWplWUlINmRiaHVY?=
 =?utf-8?B?aG9TKzZwR3B3ZzRqYjd2WXF5a3ZUTjdVSC8xdEFJZXEzUXRENlpVOGMwVzhy?=
 =?utf-8?B?T1NaSk91eWlqRmdVeG80dXJyUzJMR2xQZ0hLTWNyZjhZNitrZG1La1owZlJx?=
 =?utf-8?B?UXlXTld3Z3FGR1hyaWZqV25FUTU2L1MxUUhGOElsRFZDOTcrN1hFcWh0WjV6?=
 =?utf-8?B?YmoxaGgwZjNWN29jLzFwRkhQZ1ZKRjM5dEpYQnNWY1A5WXFFejlsOU0wRGpx?=
 =?utf-8?B?Zno3a3NocmRLRHMvdURTRjRtL1pCeERmT0JIWjdQQTRCeE5IZDFuSXV0WDho?=
 =?utf-8?B?QzBUdnFBNmlDWVc2Wm4zT3dCcThUYmNHN2h0dk51WmhsUXlJdjhxTjVaY0kv?=
 =?utf-8?B?aW5lU3dWT3VVZUczMnVFck5LRVlGbjJjV0NCa0hSR3lXeW83SzhrVmpLRUJ4?=
 =?utf-8?B?a0RrR3Zja1IvZXNuU3A3OVB0K2hvamJVQXVlcC9FMnlqdWl6RU1EbVUvYjhK?=
 =?utf-8?B?bURTOXZJdU1CamE1blc5ekdHM0lIL200cnV3YmFCaE5zWHNHN1JVVS9uOWFT?=
 =?utf-8?B?YjhTZ3JhVDZYWGJ1WkdzYk1MYVVqT08wRjhiSG5SdkdadDd5MVJRalhHZnJV?=
 =?utf-8?B?Q01mZVZ2VTQzdEw3VVhYNUFHTXFIZ1JBNE1waEhJc2JOaFlxMFhqTGMwcEI3?=
 =?utf-8?B?b0NNMTkvd3htd1ZrOGVMZ2EyTWJRSXVLZ3NtWm1YWnZzQzRQMHhyYmx3WUpv?=
 =?utf-8?B?UVZrb2RZOUtJazhUbUh0L05JaEVJckpOOGF2WjErRmJtcGpoSU1aNDJCZ3Ez?=
 =?utf-8?B?OEJsR01pQ200K2xnWU1ZYTczbVV0UUVBbGRlaE5CL2l5WDRDUjd0cGN0bEJr?=
 =?utf-8?B?UnFsd3NJdGc5UVRlNElTR2RWdVJCSnZLV2RERjZtU1JLclpSazlua1lrdkgw?=
 =?utf-8?B?eXhodjBkUTBnUnIyM1h0dzJObVM0bW0ySXlYR2czMGVNMGdjZG53VEV4V1Yw?=
 =?utf-8?B?ZU82ZVNuczlvbTFCR0NXdUNiQUpVOHN5alpxTTZKN2IzU0tKZjZPc1prU3M0?=
 =?utf-8?B?dHA0bGJldFFJQjJ6ZldCY2FXY1kzOUlUb00rcElKMDhqWDY5TFZuRU1jVlA2?=
 =?utf-8?B?elpzVVFIQnhEMkdITm1acS94MHA3SWNvNjNlZ2NwMGx4RWl2VXVFZ1FZMjZZ?=
 =?utf-8?B?dUtNajVTdUd2VjdFMS8zRnMvRFFtRVV1RzYrRHo0dFcrZGU1SWFFR2lTUG9o?=
 =?utf-8?B?d0NSTkRJa3IvQis1aTVhbUtxSkRqcURjM25IRlV6MXc3Nk9mYmFMejg4WXhZ?=
 =?utf-8?B?WDA2eFRzU2NPMGxialZtem9WbVc3Rjg1a3RabEpOWHMxSHBISWFoK3JYemRO?=
 =?utf-8?B?N0h6dWJzeWhnUFNwTWh3NTFlZWtLMGF2UytRSWwyRnNGVkxveTZBL2R6d29l?=
 =?utf-8?B?Q3RQSS9idlZLcXltaVM3aThCT0tsb2FkYUxHbHkvNEVFNmMraWVWTUMrQkRK?=
 =?utf-8?B?bStmNFRkd0RnanljNFBVKy96N2ZGK09JaHJnUGkxamF2WllnNHZjc0c2dWZx?=
 =?utf-8?B?NVpNSkNUT0s1NHlFZkpYc2Z6Q3RPQ1BNSHdpb21JL2p0blBwdHhaOEpQRWZD?=
 =?utf-8?B?VXVXem5zMDFUQW1naW53V1dERmtyQUxINUZhUXhpaGd2WjIxWTkyYXhsUWFu?=
 =?utf-8?B?ZmdrWGNHbEhmNDJSNWpROEcxT0RMZ0gxbjkrSFZMZVhrNEsvN0NVRnZKc0Jy?=
 =?utf-8?B?TkJ0YWFrRWhVK0JHUEkyQUNncVd0N2ZyWkQ1NHJkYjdJZE9aaU9DdndQZVBm?=
 =?utf-8?B?bDFZWUNRZlpoWFg3SjczcGNuZ2RNdkgwcWhxS1dJcW13M3k1QjVXdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eaf6dd1-9a28-4d3e-227e-08debdd7143b
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:07:38.9587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fpMHfwn6/GmiQW0bBiD7bkB2JD7BIeXM3d1AOZfZkWq3u1Y658PqFbBHLPufwc1OpRFm4R49u0GYueVGGJhMUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=nathanc@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 5/28/2026 1:41 AM, Eric Auger wrote:
> 
> On 5/28/26 12:16 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Add a statement to clarify that the host SMMUv3 must support HW-accelerated
>> vfio-pci device assignment when setting accel=on.
>>
>> Suggested-by: Eric Auger<eric.auger@redhat.com>
> Hum did I suggest that 😉
Sorry, is it alright if I add the tag? Would Reported-by be better here?

Thanks,
Nathan

>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 0c65dc8c91..a8c49a48ac 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -2165,7 +2165,9 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>   
>>       object_class_property_set_description(klass, "accel",
>>           "Enable SMMUv3 accelerator support. Allows host SMMUv3 to be "
>> -        "configured in nested mode for vfio-pci dev assignment");
>> +        "configured in nested mode for vfio-pci dev assignment. Please "
>> +        "ensure the host SMMUv3 supports hardware-accelerated VFIO-PCI "
>> +        "device assignment before enabling.");
> this is a rather abstract statement. What is the actual host
> requirement, dual translation stage support?
> 
> Thanks
> 
> Eric
>>       object_class_property_set_description(klass, "ril",
>>           "Disable range invalidation support (for accel=on). ril=auto "
>>           "is not supported.");


