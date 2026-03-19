Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 769311090255
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 16:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3Gh0-0006x3-3O; Thu, 19 Mar 2026 12:57:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w3Ggt-0006wT-2z; Thu, 19 Mar 2026 12:57:48 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w3Ggq-0001gX-Sl; Thu, 19 Mar 2026 12:57:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4gVMZndsLwv7z7HDDOeM/ZFRkgxWiemGGunyV2Vi0hrA0lR3pXMYgpwrvYqM1WAhUqZ6k/vF9UnGrFiePoQpqiqh9yrCakfejhix4QM52oIOyIWZBUcp6KSccQ+8dS8W80VsYIzCBjHC5dFqzanCZtRlBU8uT+dmbQ09DaUjeuzIPzdCTh9ZWapiH9xRMTK7bUuvy9o7AabixEywxve0O1lobQf7gIenkzc6AbWgi1J+D7jH3HmbbmaUTrpEvXVhflv/fRQ5cgKGL8kZRnp/bKHydwrmeLHENZN5sjus0WRKomwCwEMVziIWh/7iJaBXMKc9fy1dfxjnFNOx/h+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T+OoDg8quUw4M/0pie89BQOzVdnHdWsSH+LKUsYAzlc=;
 b=XsoW16WZZSTaFaYm5hcAAMDCCaOeZUKBMzstCGMSc/Ewe06qDu77394BpDLLZj0jTcBc4X2FH3o4h7DqZp6nTc8enMQZEENVuC4TjyfzapESMhCLRzYG0aaGaVGXCzpT+BDAqy4vdDSAnhhLE9vacEt4W6z83Mf46VfFvM+Q/kH67qli9GWXlEtsho8r19L7Pory6hnKRIEX/6SVMyHbM8qxwb2UEq5lfvixXGAOb2IB2Sv/kxSCsoVVo08eNfsNjzZvuS2knKUOwAd9gnbPpG6qZHPagGOntciLZSzQ0ynoWzac1eJemKqTVJYq4EPGUA1TnLJFJR/1U+JhK4vppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+OoDg8quUw4M/0pie89BQOzVdnHdWsSH+LKUsYAzlc=;
 b=HP0ckGFddczQqYQwmDHBjSydG00RNx899tSBHQQcj+WX56fv2wOjr2YQv5x4sBe3s5kqHtfRPRmamPGFLWqI5P/XAZaTqBifYztS1uHL+Y5aNMEjWeKluVLxldmWa6JRODVARVx8lzct76EK5dS9Ik2JJBRSapfETQDwd+dH3QsGltXEx6pBTSmcmtxKB0uA0D78VbhSSg9Gwg7sCsKKhZGuJL83Es9qEyOHbhEuKIxQRq9GbM4sLtwGUIZXwJ4aciou4j2ea8HR25ZwHoVkB9UKBKxe7dwK4oDa2lXR0dR1cRrUG1UkIn6/RSEzAS7CNJGWZncj+ciaOsTBNjBZIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by LV8PR12MB9084.namprd12.prod.outlook.com (2603:10b6:408:18e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Thu, 19 Mar
 2026 16:57:37 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 16:57:36 +0000
Content-Type: multipart/alternative;
 boundary="------------03LYOlqCzwWxI0uhUyCnhFtQ"
Message-ID: <654cb406-93fd-4c20-8dec-d01fc7d245ee@nvidia.com>
Date: Thu, 19 Mar 2026 09:57:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/arm/smmuv3-accel: Change OAS property to OasMode
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Eric Blake <eblake@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 Nicolin Chen <nicolinc@nvidia.com>
References: <20260318184907.4060030-1-nathanc@nvidia.com>
 <20260318184907.4060030-8-nathanc@nvidia.com> <87pl5080zl.fsf@pond.sub.org>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <87pl5080zl.fsf@pond.sub.org>
X-ClientProxiedBy: SJ0PR03CA0297.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::32) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|LV8PR12MB9084:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4d6498-98bf-42ff-6649-08de85d89ef6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|8096899003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: pK4pwmtJQshgf9JJA6kIB6kGvxGY2h/4mwtuLV6dkbQqJ19SmhWQMzm+MFq3gMl8BxlovpwkWi85otoB/LcQ0CqCSqD4PRxqytVquRuExosuGzoDR5H5y9Nhrj/EeeFZu06Y1I33VypN/ILLz3L4EVRDWjCyyzAfD/197XIK9UrYblqQGzTYFRfcTwxYgxSw0/mN8WiqMIPrZYhW7NeEwZh9MWFTIq+pos67MmdKw0rigW26Dpm1r7LEOTnn0L9ZEdP7f3EAXvNstkHJFCiL9vAcx3gnwiYjAX7550R7q3NQpiHQz8yB8dWdHBxm3X9Eth743I5+SuTp3XgK+InQHVSYGo9DRNj4p5PM0C7V1lOXO4wUopkn7N2VQCwHQ3FUB9suGMH6r0vdiNwfOS3U/X9lzaaXhyTI/J3ymWE/+vPzP1rKFz/eq2aZFeFACDMDRrzNqZm2nFdHjy+wH1LaqywspFXy+bCK3kSCvoCjMYYuJgvdZo+wnnOWARuuy2pGDOMFEwb5Q/mvfJOGefwLaANYlJbqnoY0kdtw6iPXX9s4wcE8vQVXjq4Ff7fsZp8hkcYhLUGIy9u31U8oqiGaL16OEoeX/TqZgRjizC6Si+tj4gHRui3EenCRuRAP6iffpOPIpsHCa6sBCFyE/8ITE1vinimsKGnvsM8p86pIWEwdMyY8NGPCTBuhe7iSNgnmFeYMB2EmiiQx50O01oP2VJgO2Kl5/VuUaMmWB94A3Po=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(8096899003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnZNSjBGbjdBSUY3VTh1ZXJibXlPVnJLRnpIb0pXQSsxVFlVRzQvOXc5QUZj?=
 =?utf-8?B?ZHdHaHE3U2YzU1R4Zms4bnEwR3cyTlhnZGVITEdBNmJRSmcyT253eFBxNVp2?=
 =?utf-8?B?R3d4Q0VkS3hOeVFNUFBLd01abjFBNlBCbVRWM3RxQ0djNkdJeFEvdDYxUGxj?=
 =?utf-8?B?WUxwdjlVL0tidUszeTRYcnJDdlVCOHUva1BLTGcrUmQyYm5UY1EwRHMvblFp?=
 =?utf-8?B?VG5teWlnQmpTajErZUlnVGIvUDV0Um9qWVFNQ0lLYXh5dkhQRCtPSmpZa3po?=
 =?utf-8?B?K015VVZldjRFZkQwdGhWUkRVSUtqbERhUEErekk0ZnhPNkliY093ck4yeHdJ?=
 =?utf-8?B?WWVqd0tZZnoyR0Z4eUFzRVdVd2hCU2trOWpiaEFFVHFLWVNSSTVnbFV6ZnB4?=
 =?utf-8?B?a29BcDVQdERqVjZrc2NQQzBEdjVSTWtLSm91UnNyQjI4ZnI1dWUvb0R4MFdL?=
 =?utf-8?B?OXZNblBPZVpHMzNtKzB6VnlCaWR0d0RGUXM4T2IwOXRaVzBWSUwyNEw1K1dT?=
 =?utf-8?B?c20wYmI4U000eVE1Wm40Y2xraFFnTWVKb2ZmTU1ONWFkTjZObFhURzdjZXhQ?=
 =?utf-8?B?dEhEc0lqUThjZG00R2FPdW1PUFZpMy9ZN3V4MFlXdEwxVXlHeUVsSUR6eDJn?=
 =?utf-8?B?ZU9rNUYxOU5FS0F4ZVpJdFVQNjVGVFVUOXpFVFk3OG1TbEdLOGlPTW5VUmN4?=
 =?utf-8?B?cVUzVXdNdk84clZTSVFSdnluRUppbFY4eWFqWDJjVTh1RXhacDdFMks3RHlT?=
 =?utf-8?B?aTllRnhxQ21jMzIxRzdoT0tWc1B2bExJN21XUU5KUDc0QjhGaWRHdEtOMVlP?=
 =?utf-8?B?bzFUcmdVQTNvS3lEZkthVUxPRFlDeG5NTC9CZWpDL3hhQitsSmhnVnJrN1lx?=
 =?utf-8?B?dHNKM004T0pHOGpPNXFvbzNJU3MzZGZTdkRzdkUwd1NJbEdxWU9BdjdDRWI2?=
 =?utf-8?B?WmR0bzlQZmFmZy8vcU04R3hxaElpZVk3ZlhpZkUrSks3UHU0dHFINGxkZ1NR?=
 =?utf-8?B?aUNZOWJpTnB6R1o2SmxNc3F3OFhYSldVTVkxVTRIWFc2NkVUeFVRUzhwMysy?=
 =?utf-8?B?SUdDanN3U2xqODNhSUdYZHQ0cHFNTVc5eGhVMkwzUE5zOW13aXRGWDBIMXcr?=
 =?utf-8?B?QVB6RytGOURtdUNBNXhTM3ZsMmtBcWw4cm9DbkJZZE9xQkZCaVQ3bDJ5blNm?=
 =?utf-8?B?M0dXVWpNY1pzVU92R1FXNklEeEpOMHd1UDQvMEp2R1dNV21sM3hlYWFwSWJK?=
 =?utf-8?B?MVRudmsxdHR6bjlpaFhZSmMzWmNBOUp1dWZHdVFHK0dFRDVUUVpqaUtOQVcv?=
 =?utf-8?B?RVIyaVRiRnBPOVZFSnkvTkR5elJSc3NZRVRNejJIZEc4SEZpZ3dZTDFwZUkw?=
 =?utf-8?B?dmFydWxGZTkzV3gxaUpWSGdOL1IzSXhWSkZlVmJUVENYYW1xMnZEalJoVHd4?=
 =?utf-8?B?WE5oeUxPdXZ4Yi91VXJNUGtWWGcrekYrOGNlWVRmQnV2ckNVOTFWbUU5d3pn?=
 =?utf-8?B?cWg5aEpwWE5EWUsvR1gyS2w5RkZRdlorT3d4c1o1M1lZUzk4QXJBTXM3SGYw?=
 =?utf-8?B?RUNvaklMVWJxbTk2QlJqU2tsakMvV1NjSVJuNFgzd0FNVERYaFpRSVoram1i?=
 =?utf-8?B?OWRmY1FaNTdWN0xxazZNcEZuSWJLZUVlRU1rY0ZmdVc3S01zeGVSdVFNTE04?=
 =?utf-8?B?a3BPcHNPTnI1NlZVN0pvZ0FOS3lwQjB6Ty9oQUZ0WGR2LzluYjVCRk9RR2x0?=
 =?utf-8?B?RG5PRkJ0ZGZCbDNsME9XM2pMSFUyWm1ETXRuVDBBWVpvdWZyYlpPb216Lytq?=
 =?utf-8?B?NnJ2ZXJWM3NtRWNuaHJyeXdPcFNYRFFVTTNMaUFLNW1hdGZhdkQ2OEdzekxu?=
 =?utf-8?B?UXg4NmVqT3pYMWRLdFRMTU5pZlhWK0U1OG1YOFZtYnJGc1VZVmNaVVBoY1c0?=
 =?utf-8?B?VXhmdmd2S0M0VDh5RTFtWVFoeTRpL1V5cWpSQ1VEY2QwWk80RmtsSmVmOTZ5?=
 =?utf-8?B?NzhiZkhMK3RCZ2FvRnpPamlNcmd3Mk9rSk5OV3MzSC9HRlNZSFRjeVlhZFNX?=
 =?utf-8?B?Q3RmcjNjVTVqR2hBcWw3OGVJWEdPSlJCVXZYV1dsRCtSbkFCaUZCekFmSkl3?=
 =?utf-8?B?UGhudDNtR3BLWEp2K0l6N1psQnpkR1FmeUF3NzE3THhpVGl2OHkrbTMwQWNP?=
 =?utf-8?B?enFHRmhsSU5rSmU1eDQ4bXpCRlpVYzhNMDhnaG8vMllKV01DNW9aU0taZUpx?=
 =?utf-8?B?VTB6TVYvd0dUOTlPaW8vVUNoTFRITm9Hb1UyalEzbFZ5bE1lVWpxcW1qQmMx?=
 =?utf-8?B?YW9xUmxpQ0dTZUMydXBWNFZ0eHIzY29GZFhVK09LaUt3VlFsWFBSdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4d6498-98bf-42ff-6649-08de85d89ef6
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 16:57:36.1178 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqWhpRAWs3G5otlOOP0JGlEuV1utX/yzox1QUq2AmYAdHnVDZiftmfPTqy+BRrO8gHQoxPe7DOiqQp/aAdOJVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9084
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=nathanc@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
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

--------------03LYOlqCzwWxI0uhUyCnhFtQ
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/2026 5:20 AM, Markus Armbruster wrote:
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 OAS property from uint8_t to OasMode. The
> Incompatible change; okay because property "oas" is new in this
> release.  Spelling out such things out in the commit message helps
> reviewers.  Not worth a respin by itself.
Ok, I will keep this in mind and mention this is an incompatible change 
for the next refresh.
>> 'auto' value is not implemented, as this commit is meant to
>> set the property to the correct type and avoid breaking JSON/QMP
>> when the auto mode is introduced. A future patch will implement
>> resolution of 'auto' value to match the host SMMUv3 OAS value.
>>
>> Fixes: a015ac990fd3 ("hw/arm/smmuv3-accel: Add property to specify OAS bits")
>> Tested-by: Eric Auger<eric.auger@redhat.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c          |  2 +-
>>   hw/arm/smmuv3.c                | 16 ++++++++--------
>>   include/hw/arm/smmuv3-common.h |  2 --
>>   include/hw/arm/smmuv3.h        |  2 +-
>>   4 files changed, 10 insertions(+), 12 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index bc6cbfebc2..65c2f44880 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
>>       }
>>   
>>       /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
>> -    if (s->oas == SMMU_OAS_48BIT) {
>> +    if (s->oas == OAS_MODE_48) {
>>           s->idr[5] = FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
>>       }
>>   
>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>> index 79018f8d66..c67819d6f2 100644
>> --- a/hw/arm/smmuv3.c
>> +++ b/hw/arm/smmuv3.c
>> @@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
>>           error_setg(errp, "ssidsize auto mode is not supported");
>>           return false;
>>       }
>> +    if (s->oas != OAS_MODE_44 && s->oas != OAS_MODE_48) {
>> +        error_setg(errp, "OAS can only be set to 44 or 48 bits");
>> +        return false;
>> +    }
> So, OasMode values other than 44 and 48 are currently useless.  Correct?

Yes, in an earlier version we had only implemented auto, 44, and 48 for 
OasMode, but we included the other OasMode values according to the 
SMMUv3 spec after receiving feedback to do so.


Thanks,

Nathan

--------------03LYOlqCzwWxI0uhUyCnhFtQ
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 3/19/2026 5:20 AM, Markus Armbruster
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87pl5080zl.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap=""><blockquote type="cite" style="color: #007cff;"><pre wrap="" class="moz-quote-pre">From: Nathan Chen <a class="moz-txt-link-rfc2396E" href="mailto:nathanc@nvidia.com" moz-do-not-send="true">&lt;nathanc@nvidia.com&gt;</a>

Change accel SMMUv3 OAS property from uint8_t to OasMode. The
</pre></blockquote><pre wrap="" class="moz-quote-pre">Incompatible change; okay because property &quot;oas&quot; is new in this
release.  Spelling out such things out in the commit message helps
reviewers.  Not worth a respin by itself.
</pre></pre>
    </blockquote>
    Ok, I will keep this in mind and mention this is an incompatible
    change for the next refresh.
    <blockquote type="cite" cite="mid:87pl5080zl.fsf@pond.sub.org">
      <pre class="moz-quote-pre" wrap=""><pre wrap="" class="moz-quote-pre">
</pre><blockquote type="cite" style="color: #007cff;"><pre wrap="" class="moz-quote-pre">'auto' value is not implemented, as this commit is meant to
set the property to the correct type and avoid breaking JSON/QMP
when the auto mode is introduced. A future patch will implement
resolution of 'auto' value to match the host SMMUv3 OAS value.

Fixes: a015ac990fd3 (&quot;hw/arm/smmuv3-accel: Add property to specify OAS bits&quot;)
Tested-by: Eric Auger <a class="moz-txt-link-rfc2396E" href="mailto:eric.auger@redhat.com" moz-do-not-send="true">&lt;eric.auger@redhat.com&gt;</a>
Signed-off-by: Nathan Chen <a class="moz-txt-link-rfc2396E" href="mailto:nathanc@nvidia.com" moz-do-not-send="true">&lt;nathanc@nvidia.com&gt;</a>
---
 hw/arm/smmuv3-accel.c          |  2 +-
 hw/arm/smmuv3.c                | 16 ++++++++--------
 include/hw/arm/smmuv3-common.h |  2 --
 include/hw/arm/smmuv3.h        |  2 +-
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index bc6cbfebc2..65c2f44880 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -850,7 +850,7 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
     }
 
     /* Advertise 48-bit OAS in IDR5 when requested (default is 44 bits). */
-    if (s-&gt;oas == SMMU_OAS_48BIT) {
+    if (s-&gt;oas == OAS_MODE_48) {
         s-&gt;idr[5] = FIELD_DP32(s-&gt;idr[5], IDR5, OAS, SMMU_IDR5_OAS_48);
     }
 
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 79018f8d66..c67819d6f2 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -1984,6 +1984,10 @@ static bool smmu_validate_property(SMMUv3State *s, Error **errp)
         error_setg(errp, &quot;ssidsize auto mode is not supported&quot;);
         return false;
     }
+    if (s-&gt;oas != OAS_MODE_44 &amp;&amp; s-&gt;oas != OAS_MODE_48) {
+        error_setg(errp, &quot;OAS can only be set to 44 or 48 bits&quot;);
+        return false;
+    }
</pre></blockquote><pre wrap="" class="moz-quote-pre">So, OasMode values other than 44 and 48 are currently useless.  Correct?</pre></pre>
    </blockquote>
    <p><font face="monospace">Yes, in an earlier version we had only
        implemented auto, 44, and 48 for OasMode, but we included the
        other OasMode values according to the SMMUv3 spec after
        receiving feedback to do so.</font></p>
    <p><font face="monospace"><br>
      </font></p>
    <p><font face="monospace">Thanks,</font></p>
    <p><font face="monospace">Nathan</font></p>
  </body>
</html>

--------------03LYOlqCzwWxI0uhUyCnhFtQ--

