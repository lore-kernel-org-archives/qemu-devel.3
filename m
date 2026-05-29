Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DEDCCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 23:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT6Kq-0004XQ-IL; Fri, 29 May 2026 19:09:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6Ko-0004Wj-Iq; Fri, 29 May 2026 19:09:46 -0400
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com
 ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1wT6Km-0000dA-O5; Fri, 29 May 2026 19:09:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FftkNAhgGQEhnjAS/f5GIZvDkGPkyyRo+c1fB9jX4BtTNh9K9+Dr1/zB/u7grj/J88MxBQr3i+9354P+EXuS4sEZazHpCbcmVAN0HKprwVq1yCw3WpE33ogCVxubftgmExCG0NkB86onl0YID4OzD1tuKJNCpLEAu5YaEqADzvlJUkLxuqOpr4Jh6wUbs3J3XozUmlYcYWyxV1Odtw5sxQ3o+0NNHAHe3xWDuUQDfigivaNauCtZW+5QhWrO1uetcAonuulDqgboeGhWT2vS43ppnRQd1+5m9PvRJaA/icOl1GgW+L6kZsKQnEsz8QFaxPwpkbwsUk7W5N7KZcbNsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7BbXQIEpvPYt00e7R9pPG45eCar3Fqnx7a5hWiwAnpw=;
 b=X1QGOKweZiLTSTZUIz0Oea2O+oSX11QSXyHB4l3SmVLUr6MuhwgaM52/xzsXLlF1jqLKG4asrQzWfqkwj44NnIY1zKNWD2Q6VcmoKJgRpW6bqXG2j0RS6r6sdqDzXL3aQrLg9d7M6+g1UnObfwToGslaej96lNXGnVoBS2yz4SkLaPjPVFimSRjh6IDvRi6njA5Qq+OTlKJYhzZQvukqIGJD0i2aeG/kbH4ocn7JlYeUjilsl28KxwnX2XA5MkhqkvfPtTKFUPJyMwwpfEOxT2kQaKqj4I3Cz7snpg5gw7KxYUyD6TBcVKMpO87+aXWwRuZVqersYG5X6ahJ0cYL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7BbXQIEpvPYt00e7R9pPG45eCar3Fqnx7a5hWiwAnpw=;
 b=fv0LkJqZCJeT3o4OEwi2sJKp4l9W5OyCS7MvSWT/77sON5xddr5bpYmQokNuP8Wd+11yrBWJBg2tD3e78Swh2xdCOcnzkyqj5N9zA8wkC+qMYJhNPumf66tkW70WZJ3GJ7xuresYBxK8zpzhjW0yToQXrqvmJnH6atfTgdoO2T8X1SvVVZhlZgsSgJuIRGekVXUvm7GgmpMDPfCrhoQY3eMmo+mXS2axQTZR4ZJtddnYMh/HgHz86for/0K0g83Q+td2OAgdwSaYQhzZPLP6z3XuQjdpln3wQgIP0R5a8oxt4E5uRKUj6EL4o76Y3iSZik/JoUtGeU61EE9sHn0Tqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB5666.namprd12.prod.outlook.com (2603:10b6:303:188::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 23:09:39 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%2]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 23:09:38 +0000
Message-ID: <6ef357cd-eb65-4a62-9e84-cfa923e54096@nvidia.com>
Date: Fri, 29 May 2026 16:09:36 -0700
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
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB5666:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fd0415d-2757-44bc-1628-08debdd75bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|3023799007|11063799006|22082099003|4143699003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WeXJsntwasDBLB7qZbsP68Fv9pXYlU+xMg4XyFQwBdlpQHXL9/R0N/juCJyjHorFKALjtJZGsosmdgaSbTCHblXaRN8hDTpChpvKRRd0HGRrT1YBvAzk9+WNfNoHHT387/+MPL7yZpxU50vqG/V//yVrfCwTxz0SGvCldf/CQzZByBIHOatmNarslHW7lm/aX7n3sPmQp0wGNJ5aOq9o/eJaReiWgzzGTWLVLTq27YoNis4HczMDCzGpxBWx4sc/9jWPgILMR5CpUu/xmB0HR1VfRE6q8bwQI5RymKlAuiT0AgspGQT6NWoHJfp3R3hOGhnnZGVuVrEpXdmlbHCGbuHc+TCTk657eh6yHPBmI5E8DFWER2oF4r/6Mk8JVJeyHSHlhU6Mt/ypSefILjjMAPQiya3fvh3CyuvZ39iGPWViriksfQcVsPwnIGGDbzSHSW+F8ztM+znPwFTXgkQiSnv/CnleoL4pWxGnhegRLnECqjD8j8cEFOaY80nUlTthfx9hXgC6t2wRRrxaGSIFHmqA518as9/tbCF63vblFbS5yK7vI7wIum/WPt8tf7tQpT2Pdx37jPb03Sx4BpjydyWhj/UaBMEYUiNA38p95pc/cdPQX0E1bs//TKHDsOT79NgESBPoGmUNxC2CJa1SYMVHr3ephk5Lu6C5zzdv4kY7aFSOYf78v9Lye11kzYjv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(3023799007)(11063799006)(22082099003)(4143699003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1lpWmpUakNVeGlOWVV6dFlKOXUvMDBPSncyL2kvVk1YQjZLVXl1K2NSNUMx?=
 =?utf-8?B?Mm16Y0VwU1lPSDNSN21ScFN4Y0JzTkg5NVFXRm9yV2Y2cGExRHBtSEpaU1Qz?=
 =?utf-8?B?Q3BTR0xFVmRNQ1VuZ2pmdGJKT3hzd0tBeTBnR1lReFlGVW5aUWNYSjMwTTFS?=
 =?utf-8?B?TDVHREw5UEp3UWRhaTlPaXRyaytFb25rbnF2RmVMUGxILzVyTU9kY0lLenp3?=
 =?utf-8?B?M0JjNGdBdGdtQ0xBNmU5aFRtazJ2cjEzdElrSFV5UlJnTGMyNzNlbXpRQ2cr?=
 =?utf-8?B?T0xBWVhldjFIUEdjQmtXT2RYVjNzdTNORis2S0sydGxDQ2QxWWJEUlRsazNF?=
 =?utf-8?B?SXJSWmM5T0pHandWUjF4eE1xbW94NlYvTDdja0kvekdPd1pQMHhEMmszUEJh?=
 =?utf-8?B?WFpYVEVVTmtzNG9kUGlmZlBvNnBmR0QwU2ZGUnJUbDc2a1BwWFEzRFVTd05J?=
 =?utf-8?B?bXpud3NnQ25MTDF6UWw2VTRRMVdnbmpwK1F4cXFVbldNWlhzZy84RFRlUVJq?=
 =?utf-8?B?SlRhdlIwV1AzdERhOUpnWDFienZRcTBmdnlqV011SklvbVQ2QWdQQVRveVlE?=
 =?utf-8?B?MzBtUnlaNjlHZzVpa3k5OGpIZkR4SlVhM1B2Mzk4MzRRRmcwWGk0WHprYmtp?=
 =?utf-8?B?T1FjVnQwN1dtb2d6eEdGcExCWE5Sa3JJK3ZodGRQeW5YOWhIV3VrblliQVdY?=
 =?utf-8?B?LzlQcWRVVDV4NzV0UWp2eVpMeCs2QnRjVkZLbkcxNHZNS2swVXdpdTlSRlRY?=
 =?utf-8?B?ZXovNk0rZCtJd3lFOGlPNUtQMG5qSUhhZk1nS3VwWFdkMWJsTnM0WnJwTzVP?=
 =?utf-8?B?LytiY3AyZXJqQnExQ2haTDdOeTRsdHg5d1I1YXlaS0poc0hyd0FFUTVvVEJ4?=
 =?utf-8?B?WGcxcXE0ZDlHQ1JXYlhERGlqYisrdjU2cUFoSDFvdWZxOWZ2elRPdUNyNURV?=
 =?utf-8?B?SDM4dGdoeWlFNW55UHlRWEU1N1lrRDl1Tk1UM2htSTE0K2V4SEtVWDJCb0pI?=
 =?utf-8?B?WjNzbUlTYXRRRk93RGxkUkRKYitYOHVZdmg2bWhaV09icWdFaHBxUmFTWnF0?=
 =?utf-8?B?cTNTVVNHM2Y1a0lTVlIzRVhuZmplcGZLR0xZakgxRDJCNERjM1BLa2Nqb2ZZ?=
 =?utf-8?B?R0QwK1RRYXNzSDhydUFaRHR5NWFnVWx5eVEzWG4xVlNTY29PcS84SHJMWmpS?=
 =?utf-8?B?WW90SXM4VE5ya0czQlFzRjRPSUhxQmpDaExOTlFFcjhqWW9vak5mMUdSL1J6?=
 =?utf-8?B?aUVGVlF1RnNjUHZ3OWxGK1pnenhMdi9VWGhTNDA3cklIYWlyQmJiSU9iUTZK?=
 =?utf-8?B?ZktxNDcxY2k2dFJMWU9GT0VzcVREWEtJUTFxVGEyQ0R0UVNXTXQzSG9PZGJJ?=
 =?utf-8?B?V0ZOSEZlRkdDUEIrWlYyZzgxZ25TYWZZY0dhM2UwdFlmZ0lCNXpYNy9ZUHZv?=
 =?utf-8?B?MFpUR3RRQnU5S3l1eHhnWUVRd1BxT3l3OE5FT0RwOVZ6UWhaTUYvZmlwc0N4?=
 =?utf-8?B?bVNSdDZIcm1JQi80MUZyUzFmNmVjVTFvV0F2Zk9wWndvR2VkQWVzMFVMMXE0?=
 =?utf-8?B?bmtnVHZNdTZUb0QrQ3ZaYWpiTHFnVjJTSVQ2YW9Id3ZXdWFiL2ZFNW02Rm5J?=
 =?utf-8?B?OTBVbHJ2Nk1ncUNiQ0FtNERMQVkybm9ibE56NnFRM3lOYk5xZVFEVld3UXZV?=
 =?utf-8?B?UXkyOFlEeUFiMmFyZ3FNU2ZMZlR3TUZSeXNpWTVHSXhJRzJjSFRvK3J2WnNi?=
 =?utf-8?B?cnRobmhrYlMvWWFRbWprcGUxcExvRjlUZC9TcUZJRlVXQVc5SGp3OXIzcDFW?=
 =?utf-8?B?c3B0aW00SE10NURaKzlCdWpCMXBSU2tuWS8zVGxtS3RZVXpuQkFlVVV3Mmw1?=
 =?utf-8?B?V3dmdTdNZWlaWGhQR3pZbU45YXQ3cy9nZmpoenhtWWRNWnc3bjJWRlI4Njdt?=
 =?utf-8?B?cEd6NnRITUVVbm0rQzhXbVFlU2ZjU25WTm92YjBJSHMxdHdCWlhtZ0R0U3lF?=
 =?utf-8?B?eVMxWWpEaDI5OVdCbllmaE10eWo3UXlGZ2VJM1Q5Wm0wdjNuazVjSXR1WFBZ?=
 =?utf-8?B?WjRQTEljbE5KSU16R1Jwd1pMVnFURFdyRjRGRHlSZFpVTjdJbklpZldramZp?=
 =?utf-8?B?VzJjSEllV1M5ZUZoajl3dmRTVm1XdkpVWU1ZbmpCcWQ3U25TTmpKeHdaWHVs?=
 =?utf-8?B?ZGdHODhIajNRRWdzMm1MUnlFYktQQnhKVGpQaFVyZisxZko2N2l0NFVtb0Rz?=
 =?utf-8?B?T2U0bCtad2hlY2g2eEFnY0tKbzlJM3JnRXB6c3ZURnY5LzdQeU1pRTVZTE5q?=
 =?utf-8?B?M3YwRGhHYzBMWnB6MW1xME5JUnJPTTVmRk5oQ1dSZDNTTzdJcC9jQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fd0415d-2757-44bc-1628-08debdd75bbb
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 23:09:38.8913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jxevex+t4xaG66ZGxOveDZHajIYhuKOcIybDEIYT2Fj8Wi6Z/r4dAQi2yHULpJbr2SsO9GMpb5TqZ3Ctu6XL4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5666
Received-SPF: permerror client-ip=2a01:111:f403:c101::7;
 envelope-from=nathanc@nvidia.com;
 helo=BL0PR03CU003.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
> 
> Eric
Yes, I will include it for ssidsize in the next refresh.

Thanks,
Nathan

>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>> index 63baff859f..3339da99ee 100644
>> --- a/hw/core/machine.c
>> +++ b/hw/core/machine.c
>> @@ -38,9 +38,14 @@
>>   #include "hw/virtio/virtio-iommu.h"
>>   #include "hw/acpi/generic_event_device.h"
>>   #include "qemu/audio.h"
>> +#include "hw/arm/smmuv3.h"
>>   
>>   GlobalProperty hw_compat_11_0[] = {
>>       { "chardev-vc", "encoding", "cp437" },
>> +    { TYPE_ARM_SMMUV3, "ats", "off" },
>> +    { TYPE_ARM_SMMUV3, "ril", "on" },
>> +    { TYPE_ARM_SMMUV3, "ssidsize", "0" },
>> +    { TYPE_ARM_SMMUV3, "oas", "44" },
>>   };
>>   const size_t hw_compat_11_0_len = G_N_ELEMENTS(hw_compat_11_0);
>>   


