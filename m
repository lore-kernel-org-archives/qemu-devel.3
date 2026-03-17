Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5451FFED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:18:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X7M-0003Eh-BD; Tue, 17 Mar 2026 12:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X7H-0003EK-F9; Tue, 17 Mar 2026 12:17:59 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X7F-00043M-OX; Tue, 17 Mar 2026 12:17:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LgfNZTpItMYmsGBdZxd5d0L8VDAp2amH+pxki0VnAt1qsv0imuKyfUshZ/ksIroPcgl7XDJaI/agKZy6mhIjs9MGKrAGEXvnmqlLMQ+c3Rpqdvxe+ZaZtbpoCVWJlzWsh/wGDVa1Z6AsCDdYZFkXUA+ChFetnFSrDmwdqBAvyUz0k5SD0IKbzM0M0KW1RpKhI/dUbpvPx1MjLx3AdyvniT8XoUBJ/ItWwOJ8QyCogFMrLyL1AoWVDBYqPTR5dFGMFYB91B1SX3PIgwn/stbIxQ1cHlb/dl0RDUiRd07Dhm2T9OuPLOGgXXgWtALmY9Y9w49um6673OIt87sFlXo0mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bwVBtGtnSxnOAKIVF/84LhLLAhKpEG4h9xKCG93F8zI=;
 b=R92yW/aGqdGD7x2kKJFTDuR6RXn4RZNCB+uJWWZz8BRvwyyPenlPMFOxrNrw7ziZVt8dchax/Aig3bjiNo4LTOjmBtjYvWjZDsZ7N1lsJNnWqgD1kIWnSNNlVmamBNsU0IOjIhZAx1+dIOwHiEnT+s6JJX3FC02bNkfRg0oC2Cz51ZGbECJ5oKMo7bQQ7oT12PN4BIs3TGYM+ab2phoIe3bUhq8pCQWba4oot+3x9F2+2eukQtpddhdZACWlsB2y2xEfa2RdFX3yomA/6OOF9tkjVvw4qsh4vww7jYMcJlj1F0moIFjydoZQlyKDabWY5Q7najQ5Y5rcoLAF2J08AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bwVBtGtnSxnOAKIVF/84LhLLAhKpEG4h9xKCG93F8zI=;
 b=rMw2ay8VNSAQp/AImZ68s/5UF27CIUG/RnFJ/uxj9UTRWsUsgy62ypyuTSPNZM2/f+ScoPL/4jxTtCFPHbH0D+e61n0R21Ows6MeNx1Hwrjer2rzPTwxkwlDGUwnxIN+kkhqcCEXgfHzissMlNL8JPgb+2AGDwlFeUmtTceVdvyJw1OtEoES9/8YJdXU/yFSkDTf3tqgHwq0ujjiroxXS+uKBDxASqIBhfunVS58AoyxGCMAFe+OopT7vemDYqVjlhN+b4iAKPDa0Dhh5icj1f7w8sMAuEBsvYXc1kSKcIsnP/JFBoSDi8lea1mDXAcOj6mZSiJCjlcxaYPgqaOGSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:17:51 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:17:51 +0000
Message-ID: <d1c8b6ab-da8e-465a-8195-79d65ef38a59@nvidia.com>
Date: Tue, 17 Mar 2026 09:17:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Nicolin Chen <nicolinc@nvidia.com>,
 Matt Ochs <mochs@nvidia.com>
References: <20260312210328.2016191-1-nathanc@nvidia.com>
 <20260312210328.2016191-9-nathanc@nvidia.com>
 <CH3PR12MB75483F2A3C9BA1E27DF06180AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB75483F2A3C9BA1E27DF06180AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: a843a97c-fe57-4d58-be3b-08de8440bca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: yAaTQ9tNu0MUvQeBpDySNYszY/LFor9sdo2TG9fMkDLXUkIkaKI5l/vKF/JkVNmV/o35AEjMnAaXjxAPKznzMSPxVl84D0VuJvf15uTvqYrB1ag6aQug9Tz7mrTTfPffnKubNq4mdXrfUMNHX2RVbvUYOTChPHPel8x2e10bGAaZBEwTCBY3WUIBHNSNk+sjBCr6Kl9VEKo6c8fKu3TlJF027ybCtSYutuNfbD38/suwu3k4xASFW2Yc5/1ChTS5evUIKkEyMa3bCGCCG6CeXLeGFnwGsRG2FZr1xVhEMjnGAWTplV5eDbGFkIPP+YW1CW6vqnW4H6jUTpD5Uq8QLM1vjf84bZwIKlN6sFrcvvFmcVR38hbhEKqbVMK5Vhbp1cvK5x/Gq3aEG7F21qHywcnqs4m2yDLdt7Z/0wqlZjnbBwXsRhzjFyAezndVAhVgiRtEas4a/EnKz+xax/lZic9WPjKZlpotYxE8nNBMJbvuukBTKDJeEBcIxO0aNiGd4/072MECYBK9bVH46B1V+t+0rrpBCqFtoPDw4PYachXYb4TJtPqfhVSZSi5R9J3O+6nVZrLfR7jQX+dSKWbIePKCArC1PLa4Y+V5gQzne3eV60/l6ElkQjZBbl7l3ObGKd5h8sXFL713mV+HcqLQkNDspapKHdhUxre8W/rsaccjErhQJDZgwuZzzE1eXZX2QNeNJmeob/eiJrUjae+E9RGB72VJXWnPIHUalU8YggY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c04vck1LVlQ3eCtLYmdVdUJLU1cvQ1J3cStJSU1uMHVSelJ2d1drbEJjdlhI?=
 =?utf-8?B?MUVPR25lK3hiT2RuSkh0cVBzTGZsd3hUMG5qT3BCNHlRNi9haWVsYllaRTIr?=
 =?utf-8?B?LzRYcTdTQTJZNm1DU25UN3Q0bXhCUnMvWnJpeDFTRE9zS2hzL0RlOHFRMFFH?=
 =?utf-8?B?Ni9sYmlTNkR6YitRdW1BZ0E1KzVJaDFiVkJPckZkZEtHZ1crNVIyR3p0K1FX?=
 =?utf-8?B?NDdkRkRpTXRGbWFrTiszZjBDWjNLVWgzdGpJRHNlZDBEV24yZXFXZStwZDVY?=
 =?utf-8?B?dzJsK0d4OVFELzlZV1ZKVzBiVXRCWnU0MXpLajAvNnYzYWlNNTdmSzFCMFFk?=
 =?utf-8?B?dUdHSHRFZDlYeWZKTEEyd0YwcElhSnpsUm5sdnNCeTNFeExhMk9sL3pVNUp3?=
 =?utf-8?B?WDBrVzlZaVhUcVFCMXFsRmIycXhMNGpSUVY1d1F0YldIdUJ0ZTNxN3dvejhC?=
 =?utf-8?B?Z1ZUTmNMVUNPZWk1MUl5bU1UTWlGUkJxYUd5eTg1MHMyODdMTGV5bms4OUM4?=
 =?utf-8?B?SWZ1amw4ays3WERFQVp1M1RmQzVqUGs0RjErb3lJMGFMM2phRVpuMXZHQkMx?=
 =?utf-8?B?ZjFlRzJTbEc1V1B3S25QVTA0a1l4RE5YblhNQUVlUi9qK1FxK1ZCYnlYTEwv?=
 =?utf-8?B?UkFmU1ZkV1ZacEhSeWJEN1huMnlVN3VvOXJneDZZOUNFMmZUUHhXMklKOGUy?=
 =?utf-8?B?NW40QjVzMHVad1pLaHFxVkRmb0lwRE1Qc2l6NGdIT0I4MmlEVjZOZTllbnBO?=
 =?utf-8?B?S3YxN2xibjFsT1ZrNEVDbW04ZXNvU3dxSGVJakE1emRuQUk1WjFBVEU2VVow?=
 =?utf-8?B?QUlBbnRUQjRHY1JUYzl1cUFBbTFnVTlMeE5IZVhZQWlCVDlyUTFKaWE0Sk9z?=
 =?utf-8?B?OGVvVTFlekxwMXdIT252a29acVdwa0JJWnAyQ1B2RnNGWmszN2tVYnJFQ3VW?=
 =?utf-8?B?bVdGTUF5bjVVUFUzYWNTWFFwRk1KZ3ByR2xTMjRpRFA5cWViVTBIRm9TRWNT?=
 =?utf-8?B?U0VVU2F5SVF2ZUQ3N0FXZmxLdXZaaHpQaG5MTjBvL3NXNHljeXN3MmRCRVRu?=
 =?utf-8?B?NUtMNlBDRm80V2ZWaWxFSmZvMVk3T1dVRXdoSGprV2k2b2xiVVZXZVlKa0E1?=
 =?utf-8?B?WWFyUWZ3UnZ0dGVmMnp6cUIxaWdpeW5QVGNTWnhuYUJYaTdyN245SUVhdUhR?=
 =?utf-8?B?RkV2YUU3SEdXNy9lbDJCWkNuUEd2RVYwQjIrb3Q0bXlGOEdXZGlaSWcyTW9x?=
 =?utf-8?B?QVR6UG9yc3pxTytGUy9jRXgxY2xVVmtpYmVNZS9kSGRrNmhuMHlPQ1V1Mzh3?=
 =?utf-8?B?YjlTYzZyaXhnUjZyM0JiWUx6SnQrTFZwbGcvdmhZblIvZlMxajk4VVZGbndM?=
 =?utf-8?B?ckpCc0lia202SVdVTlpGbVRYaWl4WlBRNWc0aE8vTU0wMm9QWmpWdE9ZNndj?=
 =?utf-8?B?aXlvZE5NNnZ4WVQyaW5CVDBwTklEQ3VZcGpQVloyaG5kQTdyYW9LM3BNbVlW?=
 =?utf-8?B?RnhaeTBVRDhuZXFqcjBOTERnNkowTEtCL3dHbWJvUFZIb0NoTFV6S3p5NS9E?=
 =?utf-8?B?ZUxwM3NoS3pqd2h0OEp5WnE5ekRWTDFPM2hhMklxMWMyNGp1WGZ3c2Z4MFgw?=
 =?utf-8?B?NG9ET3BPYkZFN01TQWg4Z1RWVUhxYlVkV2w5bFhJVWVhcVJMYS9vQVlCMlg2?=
 =?utf-8?B?RnZmRUJLWXVycGVKeWprQUlhOUlIbnh5UTZQVlR1VndsRURjdUp1WEZGVDBG?=
 =?utf-8?B?V3BPN2tJRkFvcGhWV3BTaVNjOTJXblF4Uld1QVZJaDVFQVhLNkhMTWx3aEI1?=
 =?utf-8?B?ZU9Wd2NkVGk4SkpyVWptZU5MNnVJYjlTZGszSlpKTXkxc3BxTDN2V1VtWHgw?=
 =?utf-8?B?Y0h1NUd4d2oreG5GclJqS0hURXFrNVRGZVFvN1A0WXhHUEFuVDZLU1k5cHh4?=
 =?utf-8?B?NjdGZTNDY001K0FQblR5OFVKbG5YczgrRkZVb0krbjBmOERzV1dXYkx0UkI0?=
 =?utf-8?B?czlaYXFHWmFuaUp6R24rWmovQzVTMUdhZkIwdG1lUGkwRWtSajlCUEExSmpi?=
 =?utf-8?B?aFZ2NkR2ellJTVljSFdGeVorS2hOVGFaeCswTWlDbElJclNLY2tuL0hnbFVC?=
 =?utf-8?B?dGlJTzRRVjRJZU5XOERJdk1UeEExTUFucVhtVmJ4RnhNa1UwbnNpRkpmMTlr?=
 =?utf-8?B?Q3BPTHRYTkFnMlpJRzdGRmYwbFBqVXJERjVYbWNWdTltSUdScjIwcVFLVE5h?=
 =?utf-8?B?ZURIS0k2dm9qckZETkVTWXRUa1pFamNLMFlmcDlGNTU1WnNnMXl1TTFZbWZW?=
 =?utf-8?B?VllwRTU4bXJRT0NvRkZyUzdwRVJxWEpSREY0SitUYVpwZWpzM2xJUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a843a97c-fe57-4d58-be3b-08de8440bca7
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:17:51.2657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krIjij+C80m0miLPDA2ti2t68v/yrdBdlKeBVXm/INivYsXqm6p2qkwMVYXFwXSjajHZu59rBeuwiOuuhYNj5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=nathanc@nvidia.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
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



On 3/16/2026 1:27 AM, Shameer Kolothum Thodi wrote:
> 
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 12 March 2026 21:03
>> To:qemu-devel@nongnu.org;qemu-arm@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Michael S . Tsirkin<mst@redhat.com>; Igor
>> Mammedov<imammedo@redhat.com>; Ani Sinha<anisinha@redhat.com>;
>> Shannon Zhao<shannon.zhaosl@gmail.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Daniel P . Berrangé<berrange@redhat.com>;
>> Eduardo Habkost<eduardo@habkost.net>; Eric Blake<eblake@redhat.com>;
>> Markus Armbruster<armbru@redhat.com>; Shameer Kolothum Thodi
>> <skolothumtho@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Matt
>> Ochs<mochs@nvidia.com>; Nathan Chen<nathanc@nvidia.com>
>> Subject: [PATCH v2 8/8] qemu-options.hx: Document arm-smmuv3 device's
>> accel properties
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Document arm-smmuv3 properties for setting HW-acceleration,
>> Range Invalidation, and Address Translation Services support, as
>> well as setting Output Address size and Substream ID size.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 29 ++++++++++++++++++++++++++++-
>>   1 file changed, 28 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx
>> index 890c4f1d23..836de4532c 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1274,13 +1274,40 @@ SRST
>>       ``aw-bits=val`` (val between 32 and 64, default depends on machine)
>>           This decides the address width of the IOVA address space.
>>
>> -``-device arm-smmuv3,primary-bus=id``
>> +``-device arm-smmuv3,primary-bus=id[,option=...]``
>>       This is only supported by ``-machine virt`` (ARM).
>>
>>       ``primary-bus=id``
>>           Accepts either the default root complex (pcie.0) or a
>>           pxb-pcie based root complex.
>>
>> +    ``accel=on|off`` (default: off)
>> +        Enables guest to try to leverage host SMMUv3 features for acceleration.
>> +        By default, enabling accel configures the host SMMUv3 in nested mode
>> to
>> +        support vfio-pci pass-through.
> It might be worth mentioning that the properties below are only
> applicable when accel=on.
> 
> Also, should we explicitly mention that "auto" is currently not
> supported?

Yes, I will mention accel=on being a requirement and call out that 
"auto" is currently not supported.

Thanks,
Nathan

