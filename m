Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B47CD37AC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2026 17:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNaFR-0007Lf-4J; Thu, 14 May 2026 13:53:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNaFP-0007Je-6X; Thu, 14 May 2026 13:53:23 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wNaFN-00039U-Iv; Thu, 14 May 2026 13:53:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJttIfaarod2hlMp/7R8MEoK4sk/aoOntF11sDcGNLfr9CI4L6NsgBZ6Je/dSYZ5XHIDIBy1l4GxjqvXVD6bUHgWGz3uP2UHHstfAhScI2P5KPdDVA7DFncpyUkQoDvP3I4mgT1CH2EaSQsZ5KJJsPCNXT7PVGdu1b/wvaSw+LYrJ5qMt6LEJWTG2vW3nBqzDy5g8EZ+Ll5AQk4/noCSPB80rfQoRr+4fHniKTBEJbsMW4OZYAjhAGuLg38r328EaWRra49tttlvwfd+cG/dMohhOr1kn1XHt7lpKA/L3UPPJ6XMK8mgMYJx7krBuxnr0rYcH5nS5xn6MbJKEkkKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FywmRyB5eJPVU/3trpR1JJ4SdO/cxqr2JhZCdnXqyxo=;
 b=ZkSc8+zUSax2SHvMcLzAcKKSnejkqISAcABUzA4cFBCpDgQYUTlT8Tx9EgCInpiOt/Rpt9Nm9qWHum6zlKXqXr4DDi6/gVAxAux06NjwSEcfzHEibjlt9fuHOVoZYO0BD3t7qerhahVajcMvw//xce6VgGHnU6T6sUbIqw4XsAAnItlF7lRWvOcT3cJBcBolIMapBe1HxYhhJTDUHoyVJUkR4Zo6RsTep3j8lz7rvqpQFQm0waDBR3N7XYMA03ut+/Eg+QGJ8kHsZXNtStSDmbZtFGZptycLhPOzYuM+ovaGBiEAL95KEeoI0X/EimL6umP+FaWJuPtUqUpcmD5Omg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FywmRyB5eJPVU/3trpR1JJ4SdO/cxqr2JhZCdnXqyxo=;
 b=RqmfsZpfrLriX0s8apvFJhSGDkgqWb2I1BQN3Pkh7CPZlqsyYWacgo21j7HiYfOT5tnlZOstKClW2xzvsJuF2e/cXkbLVVqCgmlux0epxnUb80ZTpRqNNJxYYIczKVHi9vVcHuNPw9qIhgho8+2WUyR47b47LQaU2KlbhuZVmxd+pv+NIKxSJeWQqisSJNcCk23MxxGREBv8q0iwhcUbabSEa+jIc/A6OR5tHJo8L7hVmxQACaMhGQVEL1cU4+bgH2jL39TuNq0qETU9xLJty5Cs4i7fdWVFkl6mAj9PIb9V7VEh16pAGWsOlzrB9b3juzaQ7CJ73FWItXmT7EBcNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by PH0PR12MB8050.namprd12.prod.outlook.com (2603:10b6:510:26e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.18; Thu, 14 May
 2026 17:53:13 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9913.009; Thu, 14 May 2026
 17:53:13 +0000
Message-ID: <9bb15637-c11a-48bf-af89-b60dfd2a3080@nvidia.com>
Date: Thu, 14 May 2026 10:53:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
 properties
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260512193520.3109172-1-nathanc@nvidia.com>
 <20260512193520.3109172-8-nathanc@nvidia.com>
 <CH3PR12MB75489D1484199F9F00620981AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB75489D1484199F9F00620981AB072@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::21) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|PH0PR12MB8050:EE_
X-MS-Office365-Filtering-Correlation-Id: 51951c8d-9870-4605-7770-08deb1e1ab23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|9063799003|3023799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info: o4kibjHw/+khQATvsPr6alBor1HBiEomAFLZZa3YFB8NaV/4XeeoJoXEY6NVBkMdxwOozgvDC0bMkeOS5vy964E8JQQ74sMTbsI5z8lmB5YL45VIUt+/RbisraUuQL/ETmV40VfKvhcBsEIHYyjK6V3NzoZNAzhlZaViJvDQGr5tXOtjs3fDbankNEAG8KTlZhbTg1mNma9Jw1EaigSCDBPzwqtv8O5wL2cTSD0FOx85taHdJxGLIRDsVGXpy50k2ee8EBu7PhzkntEoBOhSj9oYFSjsMu9wr65F1R8tFzGCzLYxhnMryJ8xccqVJlx1R/cffFfhd1HlFXdsF8SLxFzLIMN4pRxGaFsTMfbxGJ5NRnv1sw3YGeJSWiajcb9+zFaeL6AJt+WJY6l5xoNXa8QJF58j/YjJTzpJDVhQOwFKW6GakW1uuEp4J5Y7JssDXLhtOs/0k8C8X2pfGQQw8ZV6vqMypXWyJdD+X6SltrKyCdf4LaFkJuMyckZ1inkqwAIN5pTABqUE411zTVQonDQZnb012Kz8Pu4BPGekWT47Kz0GmrNR+OvGGT83FQARWBW97dRz9lbB3IE7E1ixj6Ozym0109Rs4HBT7RpP8Ds16k0HKdQlbtfvg+SJkRllnM5UZVEUPCX2EDXrAN52eQt0aJddj1v+gGTADb9IxqqqXtg3lyWUG62795r8kx1V
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(9063799003)(3023799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TG9nUS95aHpvZG1yRWdzZTRuczB0Szd6SUVZVjRIbGhKeDNwZEpVamlRNFFZ?=
 =?utf-8?B?QzdnYWRYbTNHREpybWlPa0lVaDY5SFJGOHluM2h2UTJiaEVQbDQwWVVTL3dw?=
 =?utf-8?B?NVJERnl4UzVvVzE3U2h1YVAwYnFIQTl2UmdlL2FSVVlHNlBYN04zRUZ3aWdr?=
 =?utf-8?B?WUp5QWRpK2lYcFV4VkZsY1dEWHVhRjBZVTg2THRjd2hBM21hT3Z5SXB3SUN4?=
 =?utf-8?B?YnZ4ZjdWSUhvZjd6L0ZJY1hkbkFVeWRON0pGZ1ZWeld2M2RuNlcrWDJFZ1F4?=
 =?utf-8?B?VU1pbXg5dmxnbTd6RHBxdVErVHFQc1FYVytCSkhpSHFmSTcvN1BmdGJ1Vml0?=
 =?utf-8?B?ZHpSQ3Yrd0doellkYzhORktoTjcxSXpLWXloR2tKaGVLZU1NYkk0Umt5bmRu?=
 =?utf-8?B?Nlo1OWZZK2JZY0laOHppdmE1U0JVU1lSbTlGeVBMNnoxVkh5WnNiTW5yemR3?=
 =?utf-8?B?RVkrV20zQTJadWplcFhNWEdmT1VCdzNBcW5pQm5tLzFOM0srMXhEYTFNRVlS?=
 =?utf-8?B?Mjh1QSt1Sk1VMFdxaDV4MGEzRkVUenBFM0RuY3RsT1psYU9YQTZWNkxjazlp?=
 =?utf-8?B?VEJaMzlCTkdHUGkzQUhBdHVoVVFMd1REN0RZazkxUVpCRU82N1FzQlpneUZ3?=
 =?utf-8?B?N2w0a2hQdDA4eVB0TXZUTjRqTTErZWJWR0ZnSjExblVVSW84dnI2K2tTQnVL?=
 =?utf-8?B?RjFSRERiNnorTko2aVAxMy8wZU1xV3JPbzkwT214TS9hM0crZEJqa0QyNVVX?=
 =?utf-8?B?MW5oY0R5S3p6S3NCZkxEUFFtcmdsaDcrUTRLWDhzMmdUaHlaSTBldnZ0Qkcz?=
 =?utf-8?B?K2Noc1BmSlUzUHpnZU8xWWZma1BkNnBLYWRBUHkrcXlOQ2ZGV0NTNTFSWitu?=
 =?utf-8?B?WDQ5WVA5Wkl1Vzk1ZkJCbTlwdmQyVFR0VTYyVUpoa3FEQW16emJXSTN4aEd3?=
 =?utf-8?B?dllXMDl3dEtPREtCdDY4UmY2aGRYYVNiTmExOW9pU3Rtb0ZZTDVleDJlODFz?=
 =?utf-8?B?QWcrS3NzWXEvRnVYdE8xYmtUNmp4Qm51cmlqVld3elNidXVPVWVjQlVkTmgz?=
 =?utf-8?B?NEFIV3RUQ01RT1hCZ0k5UFNOMWpCTHFPazFKdE9acmZJNEZSeXVHd0lUampl?=
 =?utf-8?B?RVdIWFhLZ1IvUGRiWWg5cmVWOWRhWXNJSHNlbmRsdVdUWi9lbVJHZmVkNEhK?=
 =?utf-8?B?N0RBRE5lSkVHaUxwemFOVjRXV2o1VE5kWlFsVmhLZVVYWCtiUVIrd2ljeHZs?=
 =?utf-8?B?ZHYxQ2U2ejNUazhZK1VNazIzOTcranNmQ3JDM1pRY1BKd2FQVVM3enhiODdh?=
 =?utf-8?B?ZmUvWGR1b2xNTlFXUXd5MTdySEpUMHExanZ6dU9PYlMrdEdQTXk0cGxaN05y?=
 =?utf-8?B?dXBuZE8vMDNUOElwMzZIam9qeXJ1ajk1OVRWYnN5ajNXRlZaTGtWZEtCczRD?=
 =?utf-8?B?MFNZc1NoL05FM0JLWU9rVU9mYm9GYkljTDFEMDlKUjY4NHB2YjQ2TDFjTEU1?=
 =?utf-8?B?TlVpL21CRDlHczBraWduTXZOYW55b0syNGtiTDBpcUtyU2JFZWFITDZmYzdq?=
 =?utf-8?B?ZmtZck9vRnJlU29ObzlrNHRUTVpMV3RRTk9UeXhBRDBldVdza1F0SUNiay8w?=
 =?utf-8?B?K1YxVEZWclZ5SG9RVzU4dHdHbGZxUjdFc3NpWmIwTTRBN3BYUTlBcUFDSTRk?=
 =?utf-8?B?Unh6ZENhM3dlb1J4QndxQTc4SU9YRnN0M1V4bFhYRGFCd25GaUJoRDlmQmJT?=
 =?utf-8?B?T0RGVW53VlVUa1g1SnVmSFlXTWZHUWs2STIzaE9MY1BWUDRIZHhlUW1GaXZE?=
 =?utf-8?B?ZkJick54OUphRlJzY1kwVXVtYkJ0aDZwRlhyRG5wQ3lsRlBsYS9vZnFCMm5W?=
 =?utf-8?B?a0toVUdmQnAzTXRjK0VJMVhRazJUV3REaWgyMytuWkdidHJGR1JkalB2c0NY?=
 =?utf-8?B?cnBacnJtNERVQjI4MUUvS3p3cUE2RHd1eUtnTnNORzBQS3E3Z3pCZzNMMzFP?=
 =?utf-8?B?T2c0YmpJcnkrb0NTWVNiMDkxUUFOZjQ3UTRKak5naFJEdGNRU2dtQURTQlg2?=
 =?utf-8?B?b044aFE1OWtKbjM4L2lDY3JIZ3Q1dDg5S0JTaWN0ZU5CUFhGdWdPbGt5UjEv?=
 =?utf-8?B?UEpoTWcycm96M04zaVdEV2FEd3NGZHBRU25nMm9nNWxzb25KYjlqbC9YYlJK?=
 =?utf-8?B?LzJHaUc0R0o0eFovM29HazlFVGJJbEkyVTJOT3dwZFczVzZaWFZlV0t4MUtw?=
 =?utf-8?B?M1UrWDYxL083ZzZFSUlJNkd5Tmpkdit1N0RLa3BiWmx6UktQaHRoQkYrUThp?=
 =?utf-8?B?WktwZjIxbFdHcklISHI5SVRqOFJzQUppOWt5WU1CZDRQekRKT2s5Zz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51951c8d-9870-4605-7770-08deb1e1ab23
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 17:53:13.2566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaGO8svtCwYsNUDJ6BT7sPlPL9392yEEfpcaFnmn8SithElrNazOUgGoBvR2ERhg0wQGsQ0eIF+B9pasWj1Uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8050
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=nathanc@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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



On 5/14/2026 9:19 AM, Shameer Kolothum Thodi wrote:
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
>> Subject: [PATCH v3 7/7] qemu-options.hx: Support "auto" for accel SMMUv3
>> properties
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Update documentation now that "auto" is supported for accelerated
>> SMMUv3 properties.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 25 +++++++++++++++++++------
>>   1 file changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx index
>> 96ae41f787..46b02a1bb3 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1291,30 +1291,43 @@ SRST
>>           Enabling accel configures the host SMMUv3 in nested mode to support
>>           vfio-pci passthrough.
>>
>> -     The following options are available when accel=on.
>> -     Note: 'auto' mode is not currently supported.
>> +     The following options will be set to auto by default if not manually
>> +     set. When accel=on and these properties are set to auto, the value is
>> +     derived from the host SMMUv3 capabilities via IOMMU_GET_HW_INFO.
>> With
>> +     accel=on, this requires at least one cold-plugged vfio-pci device; if
>> +     none is present at machine init, QEMU will abort.
>>
>> -    ``ril=on|off`` (default: on)
>> +     If accel=off, auto values resolve to the non-accel defaults given below.
>> +
>> +    ``ril=on|off|auto`` (default: auto)
>>           Support for Range Invalidation, which allows the SMMUv3 driver to
>>           invalidate TLB entries for a range of IOVAs at once instead of issuing
>>           separate commands to invalidate each page. Must match with host
>> SMMUv3
>>           Range Invalidation support.
>> +        - With accel=on, auto means the value is automatically derived from the
>> host SMMU.
>> +        - With accel=off, auto is resolved to 'on'.
> If the intention here is to have bullet points for above, you might need a blank
> line before "-" . Please see how this gets rendered in html format and
> adjust.
> 
> Same for others below.
Ok, I will confirm the render and update accordingly on the next revision.

Thanks,
Nathan

