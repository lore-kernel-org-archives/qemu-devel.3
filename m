Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C66FCD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT6RC-00084l-PP; Fri, 29 May 2026 19:16:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6RA-00084P-NW; Fri, 29 May 2026 19:16:20 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6R8-0002KV-PT; Fri, 29 May 2026 19:16:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xtz3ftKQHNExQ5J1tV5kYK4pd2Q1CIoqJVuTTJuihAVK5KQgN4PowZh6PXzd0dS5afGbVS7882rXXa9EtV667aAsg5iqBj7kFZAbP0UlJBtU5Ua1/aSxqD1Cqc5N7RXBDEcpcKJFGInMIjDrO6ZmpwNd9W/pbNh6+tS6nuooT0JzuYV3uxkE3OS0bNwTgYcBc6vAtsH3xFtcCuxmoESXpNm4A7elOiNIlYWOWtpPTBkLrDaJH6xYYl7PqpLosTH7DlNom3MmA1+KpleR0pC+SD+w6foCLtpyaSDXQUQbPioBP+3g6gv+tmT8r9eCncpsZ+FWVMZ1otQMPOo2kRqk+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+6JbvhnXBBHBtlL0JiBHTdN+OFzmAxsb4Y+AFEiVlo=;
 b=B9Gys2zR3u/MXoAMbtuIehlfvXkwdlRQ5BA9Ti8s3leiS6tx1szzVQIzSPnsxbS6A1Nk1r+s8InHkIsMq8UE3qImzuY33bHlUfNmgLF7LCqaGkB70hh8xAN30Xrm3UMMaz0FlY7ub0S+1fXMO/2vPLpbZM0XHpqocdG7UGdEYR08SJz1xI7cGbu1dRhCqCc6cnExzQyHvkb0Yy9tYn73B4EdADnWYasD19QgM15UiCUjPsVsYuMiAfn8MHjy6xME5b2uqEDrEGL5thEvGxqbkZV2baPqHq6ITF7qyjJ9EJyu0okBgM7mQW//pQmkLPhAfYic0BFU7BbuOmCuzceJMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+6JbvhnXBBHBtlL0JiBHTdN+OFzmAxsb4Y+AFEiVlo=;
 b=JB3YwTDGLYoDea4EZ8l9exuKHo5z6ZspdQ/i1Sl5k0/u1WXktUMMZEeAWsunW11KQWAr86KybKH8AKfZoAPsSk70koGVfRVCx1WE8NuRHfpRA0WT65fljkgVCzltCecu7DwVMnBQiZbYyZ1lX/+KAvdXNLhvaJoJUgX/0fDyyBmVJkNi1ZDau/LZZLIg5SXVIffCa8PYde+o7cHD7jioTgalZmkltzql4/LIFcV+e43N48G/2MMNbuPbez0uSidDYnezVX70x3xaPFGc+Gn6Prdy4r/NiKC9IhstAJWmftClWVseaPIoDEycGijF0qHEcTZ/zh48ybdRsfUm1bOHnQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 SA1PR12MB7270.namprd12.prod.outlook.com (2603:10b6:806:2b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:16:08 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 23:16:08 +0000
Message-ID: <587e5c9f-87b2-49c2-bb1a-2c2f8dd8f75a@nvidia.com>
Date: Fri, 29 May 2026 16:16:06 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/9] hw/arm/smmuv3: Set default ats, ril, ssidsize, oas
 to auto
To: eric.auger@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>
References: <20260527221631.612026-1-nathanc@nvidia.com>
 <20260527221631.612026-9-nathanc@nvidia.com>
 <37caa2b8-b9bf-4006-8fa4-b417e8881fbd@redhat.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <37caa2b8-b9bf-4006-8fa4-b417e8881fbd@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:a03:254::23) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|SA1PR12MB7270:EE_
X-MS-Office365-Filtering-Correlation-Id: 47557e01-9b8b-4bce-cdc9-08debdd84426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|3023799007|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: PDE3A5MI8RQ4EDwzHcu59axiulDdd+3E2NiITDp4YebDq1Q+3TMStTB3eKTt66QOhderJWUprqeuNj29aJm9Bq7rdIfUxinMwJfJ2qqu3Ykga1zZTJYzDRGEJU2CNDizTqD7S2t4MW6ithasPUCB5V+eTkrgeYqbFHDC2YNJKw6mCT3b16agt7wEy0a3QjJwr4sABnWHsW39Ro1Ti2RisixBsAPFIYNgkpqvJz5BBh/+gd8le9IZAufqn+f8nK/eE78CHRHjv6YhzigAJr9vUA2mIWEV5+1Jlu567iyS2K5qavbNt8/nH2YxBmZrK+M+r7pfk15ttL7EzMpjid/jCyLS7RvEZBFJ8wSu5Iu12ZkJseEIgHnPhOuL5IQjO/pAsctj60SkHV5yX6+207rU8dsSAMdjn9PV52RTsrxK8zjtbJqHiRWzebietBIgslEGq1NR3D29SzWzCw2cr8e6dDwL7M4w9N1IekExwEqE7znIMxR3j+PqBjOEhXzL7PDi6eTg4NH2St2W82ePoB30YhscmHkcfltS7qjryXBKkNrVm13P+ai4DhvlGTU/1EgWKkgcyxdbVa+RTXIOvvs3MflhFATlWrQ215qX361YIjV9MPb6ZJshjEFvzHnKZptuOcIdbPg5T3hMrGiLIrvp7bQq/Qr4F+XIxuw0mjK9tgNez7RfBV09CWhDJIzNXQuP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(3023799007)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1ZrcTJIVkNNc1YxclY2c29TN3M1OURuOWJhUi93QlpIWFc5MGxDUWx5ZHp1?=
 =?utf-8?B?dGUxQ1hNRkgvRGtGYXNTQzVTQmlGRVZwekZiOTg5cWUyeldZZFE0YmZLbnRX?=
 =?utf-8?B?aDBuSmFiejUwclBrdDduTmhnV2JzUHdnUFRMSUEvMVB3Yk9hbWpiQUFnU0Z2?=
 =?utf-8?B?KzZrWVkxS2pQaUtiQktIMXdrTUZBWjNXd2REa1BOWEx4Yy91L2FrT1hBdGhS?=
 =?utf-8?B?Y2x3YTJYRkV6bGVwZGpOaVU4cldsRHpSTXEzWnBtLzZiMlB6elBOaUJ6SDY2?=
 =?utf-8?B?L2VNTlU2UW1tbDVqdStOejJYSWZ6cXRjdUJ3Nzd4cTdiNndiM2JBZFFvdnFV?=
 =?utf-8?B?TDY4RXZCbGNtQ3dvZDNzb2tPbUwyTjE3RDhCdlhJMW9WbTBsL0o1SzRvd21K?=
 =?utf-8?B?Q09TOUIvUHQ5ZDZFWFdIblhCV0Q2dHI2dVhzR3pvTUhacFBscjU0dDhWTkJK?=
 =?utf-8?B?dDA3VHNVN2lRRjZCdHFWV0FBTkhITU8wdG5sNi9xN1M3YXBYenJGdDVtYWtl?=
 =?utf-8?B?SCt6MHRyMno2UDFwTU5jWTlUVUY1OEl3RU5aMUdlRUpIQjVqTjFrUVpmajNq?=
 =?utf-8?B?OHlvNEQ0U1ZBdklFVDZZMWlsbUFWVnBSazRBek52K21mZjR0TWNPODVrZnZm?=
 =?utf-8?B?VHlCL3E1a2gvaXp5UGd0T01qOUFCTTBFMmJMZjB0UkNtRG5VeUNFbzlsTk0y?=
 =?utf-8?B?ZDV5cWVzT2Jaa1htaWZaeXczZDJtdHdoV2F5aGNUdEIxVmdCN3RGd3RjNW5F?=
 =?utf-8?B?WTg5cVFtbmVIU2JIYVI1YVlBVkdBM2pscDcwTnVQN2ZxUDdFTWtsSC9WRFk5?=
 =?utf-8?B?bEQ5MGFHMktTNS80R1dVZXpERkhReVZKY0h1MzEySVlYWURKdTlBdVBuV3o3?=
 =?utf-8?B?cjFYUkpKazF4UnF6SFAwZncvRnBNei9qUkdrRGQxOTdGQ3h5K1RJU1AyQVZI?=
 =?utf-8?B?OE13eG9MeFUwZ2xJMU1jdzZIRnN2N3NoVitIUFllT2QwdWxsSCt4eW80SHdE?=
 =?utf-8?B?MXV1cXFuRzJia0RPZGpTZVVpRjBzODluWmcyQi9OMUQxaWNGQzUxaDVQZGlk?=
 =?utf-8?B?THFjNnNuQlM3S0RMTWluYXF1dzJIOGVFUzJsM3c0ZjlncDByWjY5R2ZWaTNs?=
 =?utf-8?B?enhpMVVidTAyOVdCZ0ErMzJ4SnZ3V1N5QXZoTGlIMjk1eEZqOUcrb1RuNzIw?=
 =?utf-8?B?RzJ2ZXg5MXpNdWFJcUEwWjEvbURuTTJIaXlZNFBubitUSFZ3UXJINTVYcTRE?=
 =?utf-8?B?NThHSVZGL05jd3VYdnZiamJUZERiSlNEbkE4MGRVeUlrSFg3MXowK0xucXJz?=
 =?utf-8?B?RklqOUNzeFZ3LzV6aUpOOUpSaitpVGtTY05Uem9aKzI0eC9NV1RjeUp5TXpZ?=
 =?utf-8?B?K043WlNsR2VoSDlhWU5GdWpyajBiQzZOWndISTYwUEdWM0pEeUJPM1hpcThn?=
 =?utf-8?B?WjMxUjJIdm5hSHA5dGRXUTJybUN3cEo2VWtwYUE1elN4UTZTNDJyN0RERGIz?=
 =?utf-8?B?YTN3TDlyWkRnK3A5SW1UYlBvL0w4MTc2SkhCeFJjazVEZ3dXOHRjbE9TRTBE?=
 =?utf-8?B?bjNoeGdacjY1WHFUTERWY1BGK0dtVmoxMmcwM0FvdlhWcmpFZmxwRFZlRFpL?=
 =?utf-8?B?Mk0zblZSbEROWTcxUzJsSkpuVjBtZ2krcVZ4NE93dWVSei9SUlA3dk83ekFL?=
 =?utf-8?B?VWh5WTlxQ0tFMzEwY1MyanZORStIOS9MVkNhSStONUFielhPTDdpVkc2UmYw?=
 =?utf-8?B?RnZLVGNGNDlwTlhlV3E2STFzQWZQanRTZnliM2dzMTJEQmVwL2ZkQWxxNGoy?=
 =?utf-8?B?Tmd5amMvVWJFRU1NUWVvMVgwaTlFN1BXSHhGaTRlMFlEemJodll2YkNubzRG?=
 =?utf-8?B?NHFRL1hsVTR6aDY0aTU4VzdzbXJKQkJYdWVISmt2WCs1aGZMZ05Gc1BwUDhl?=
 =?utf-8?B?Y3NJV2xFZDAzbVdMSWVBamlyMnpaNkJnbXRuSDd0czlBZHBxTXRjeXB6MWdv?=
 =?utf-8?B?d1FyTVpVMERtSStpL1RtZG5vdUpKT2ZqZGhIVXZoL2crMVNvK0trR3VqWmtm?=
 =?utf-8?B?Z2x5cFRRRGI2U0hPb0lDajVsTzhoQUN1azlvajBteG9ENENVeER3Ykp0TlI2?=
 =?utf-8?B?S1ljYk5KRG1hTnFUMWRGcEVPMW1FaXpjY1B5WkJuNWRsMTFaemtQNWN3WnIz?=
 =?utf-8?B?T05tREVrYkFYUjhxVTNSYU5xb01qTkJIZFZIaWdCdGdDY0ZKbmtvSm80bWFj?=
 =?utf-8?B?Rzg4NHlQMUFscGxJWTBhcVZpdnRaemJGSzRPNGduTFdPZkFMK2lmSENMTjZv?=
 =?utf-8?B?b3hOdFhvRnlwZTlWdXBqL1MraG1Ma015cWducEdpbDVUOEY0NDgrZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47557e01-9b8b-4bce-cdc9-08debdd84426
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:16:08.8673 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz3JkKopbzHVPnHwvpIAu7tEqodGMvl0XOoM8OUFzRUtdWAwB9JlMbGr+Tkr2dshKYjvjFd5ZpLUYsX4uhAI4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7270
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=nathanc@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
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



On 5/28/2026 1:42 AM, Eric Auger wrote:
> 
> On 5/28/26 12:16 AM, Nathan Chen wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Set the default value of ATS, RIL, SSIDSIZE, and OAS to auto, in order
>> to match the host IOMMU properties when accel=on.
>>
>> If accel=off and these property values are set to auto, the default
>> property values defined in smmuv3_init_id_regs() for OAS and RIL will
>> remain unchanged, while SSIDSIZE and ATS values will remain initialized
>> at 0.
>>
>> Introduce a new compat for the changed defaults.
>>
>> Reviewed-by: Shameer Kolothum<skolothumtho@nvidia.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3.c   | 23 +++++++++++++++--------
>>   hw/core/machine.c |  5 +++++
>>   2 files changed, 20 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 97ac893d86..4e630b6403 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -2129,12 +2129,19 @@ static const Property smmuv3_properties[] = {
>>       DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
>>       /* GPA of MSI doorbell, for SMMUv3 accel use. */
>>       DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
>> +    /*
>> +     * AUTO values for accel=off will resolve to:
>> +     * ril: on
>> +     * ats: off
>> +     * oas: 44
>> +     * ssidsize: 0
>> +     */
>>       /* RIL can be turned off for accel cases */
>> -    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_ON),
>> -    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_OFF),
>> -    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_44),
>> +    DEFINE_PROP_ON_OFF_AUTO("ril", SMMUv3State, ril, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, ON_OFF_AUTO_AUTO),
>> +    DEFINE_PROP_OAS_MODE("oas", SMMUv3State, oas, OAS_MODE_AUTO),
>>       DEFINE_PROP_SSIDSIZE_MODE("ssidsize", SMMUv3State, ssidsize,
>> -                              SSID_SIZE_MODE_0),
>> +                              SSID_SIZE_MODE_AUTO),
>>   };
>>   
>>   static void smmuv3_instance_init(Object *obj)
>> @@ -2164,22 +2171,22 @@ static void smmuv3_class_init(ObjectClass *klass, const void *data)
>>           "device assignment before enabling.");
>>       object_class_property_set_description(klass, "ril",
>>           "Enable/disable range invalidation support (for accel=on). "
>> -        "Valid values are on, off, and auto. Defaults to on. "
>> +        "Valid values are on, off, and auto. Defaults to auto. "
>>           "Any attempt to turn it 'on' while the host does not support "
>>           "it would fail.");
>>       object_class_property_set_description(klass, "ats",
>>           "Enable/disable ATS support (for accel=on). "
>> -        "Valid values are on, off, and auto. Defaults to off. "
>> +        "Valid values are on, off, and auto. Defaults to auto. "
>>           "Please ensure host platform supports ATS before setting it "
>>           "to on.");
>>       object_class_property_set_description(klass, "oas",
>>           "Set Output Address Size in bits (for accel=on). "
>> -        "Valid values are 44, 48, and auto. Defaults to 44 bits."
>> +        "Valid values are 44, 48, and auto. Defaults to auto."
>>           "Please ensure the value does not exceed the maximum "
>>           "Output Address Size supported by the host platform.");
>>       object_class_property_set_description(klass, "ssidsize",
>>           "Set number of bits used to represent SubstreamIDs (SSIDs). "
>> -        "Valid values are 0-20 and auto. Defaults to 0. "
>> +        "Valid values are 0-20 and auto. Defaults to auto. "
>>           "A value of N allows SSIDs in the range [0 .. 2^N - 1]. "
>>           "A value of 0 disables SubstreamID support. A value greater "
>>           "than 0 is required to enable PASID support."
> also I think the set value sould be <= host range, to make it consistent
> with the rest, no?
On second glance, we added this <= host range statement in patch 6 but 
it was cut off here in patch 8. But I do spot a typo "SubtreamID size" 
so I will fix that in the next refresh.

Thanks,
Nathan

