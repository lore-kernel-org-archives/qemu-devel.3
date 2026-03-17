Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25150FED9E8
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 16:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2X9W-0004mt-2c; Tue, 17 Mar 2026 12:20:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X9T-0004m5-Do; Tue, 17 Mar 2026 12:20:15 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2X9Q-0004Uc-7l; Tue, 17 Mar 2026 12:20:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbjUJWZHOziASoVf4hY/FE3L/UgvkdXBdhq+iAhufpX8gi9D0/1EURZc6HYDWTbbEXioj5ODRw6kmPFe891fxD1d6lFsVyzNpICKFlI2QgigGZwqerLwv8aEqaFoRqTiOKpFwFvCHr2zhpf8YsKmO6ihLebGFuzwElDSv+AR4msKuK3CDNiT+VX6jOsviW8qkOA5ef7dyhOvDmeLbnvD/s/dNE/+7kWUyB5nuucUelmONVCeYOOcLiItoHfaOtQIB2AIEkLf5Wbjn8FbPgYkJjvpMgtAeKfblksU6RSKAJZs9CbAA0UKTKDObUFXMzXukLAw6lbbYJ8hDpxk9s93kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDK53AQbrpx4wTA2/IDlKLiKs0ctX8yaGVwJOp4Pnac=;
 b=MPciHmg0mgK2N+ALAHBl+G0yZ9K/hypuln2wOrg8cTL2UTBjS96EdHC5fFU6EpbU/+KD7HRzm+Wgr397URSPaY7JAWqd129P6wd7aIztJip7PrOxUwMEXPgLMw5wEWVz7Kv0jT22c+qkk81Asq4ZWTA1ClWYY3Jz/N59suCky1foVRyw11ya7czZjUIia+ccMYDcwRAHfKJcqiJmCAY1smnsheiNgni7EDWmSxqvLEUB5XsExJRNtIkKwcIrE/1D2VLRjVoXcXwO8FOgjzZQdKz9reemDGiznNsNx6cSM0RLnYE+mGFTDTk/nYsrU2bBtFFY/106Qk/OSfe0JRgf8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDK53AQbrpx4wTA2/IDlKLiKs0ctX8yaGVwJOp4Pnac=;
 b=IxGJ6DdVA+7LVp2UinTeyXjoNKermyLZXwcUrMsZg9/zehFMVhbLfg7k04yaXW90rqwQVRP8nyEu6wll7vIttbLvOkLzo2MeR2o6E4eyKyBmQIwAFq+WQKgrlBHergnroy2y8auomsXm/ovi7wmItaDYJGI7f4I/XmYNLgcCmt+ItPTuGJWi2boEMRJHM4vMwygisWEfSDs7ChoywLArrUMyX3v1dWimbeNlshKlzNTjapIQKCZ6UamTnWaqQwRqSsb68/JL3oWkbHA/rU8Er+WiWPUEL9wNy90hkgBUi+fAv/z7iKU+fCUjEwvWkki+8uhE+pQttLuxhN0wPIARwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9567.namprd12.prod.outlook.com (2603:10b6:8:27c::8) by
 MW4PR12MB7335.namprd12.prod.outlook.com (2603:10b6:303:22b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 16:20:02 +0000
Received: from DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5]) by DS2PR12MB9567.namprd12.prod.outlook.com
 ([fe80::636:1b52:24ca:d7e5%3]) with mapi id 15.20.9723.018; Tue, 17 Mar 2026
 16:20:02 +0000
Message-ID: <df1d123e-b285-40bf-84c2-8448129562d9@nvidia.com>
Date: Tue, 17 Mar 2026 09:20:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
 SsidSizeMode
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
 <20260312210328.2016191-6-nathanc@nvidia.com>
 <CH3PR12MB7548AC937FEFC3CC4601AAB5AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548AC937FEFC3CC4601AAB5AB40A@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0108.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::49) To DS2PR12MB9567.namprd12.prod.outlook.com
 (2603:10b6:8:27c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9567:EE_|MW4PR12MB7335:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b29c95d-75f5-4567-21cb-08de84410b18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: odMb2o/YvYRKuLRwUMN9lSV6CU6T7JRhG8TQKBXIIhoqhxtF3hZA6cTYi+BnRJFvnaXldmX+bW0avOEWtD6c8VxLdIiDo9CF8WospJKqDoVYBQH1ckERZbjauGuyfoyhjFnNNavkyXZouqCVbYhdJW5G7luer986OEoHNTzT6GUhloGHbhZTM/zudTddFOh1oGlkMGSQJBJZ6X4OTzf3QbdHZvI5Mb9AOfDlXC/Oa7YgMLaVh6VO/eUjt8CpbbFshz/m+5rtPu7sAyOGDECDYqY07BekWfqNkJZTor0KIJvCfRJXtFL/9zq3704a/1YmrbgzPUKpDzAZGYAfUpnh8a2GALMnK/281oHfnGQkcDZwr5THuqJNtXLgRNOPs9Cdsy7n+MvC5XsWgQvK7oQbbNe5VpXJa+N9YejMwkxnU0LA6QSP3zvP2u2KEq/9WtB4ACXo3nVvkLSQAPJxDym1JHqRrTkYCKGiwLgRRBw/MBb16HJscuEkRpaa0ZjwQcDHXUEJJ3jYyLXsYboz6dsZlYdhtGTJ+K8Ef35X11BtuNTQrXFzEy9836nupE72Iydoav1CxxdpQL22ReP8OkloeZfre5o+A9YhEOSlV7b/W+XNUdV/IzHebDAHg39/9yfKW/TqBF1Qn7HP/t5zRCokcFFI13A+e2dGCCIE1JsGqI80IsUvAr0a880i7btyABPQH6j4mqqkgmwdRIgx7ELoh0YkIEphQnNSAZhL0pwjSS4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS2PR12MB9567.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVFFcVhDZExOaVNKeXhCUkN0WTN3eXUwa1NPUWNsbW91V3pka0swdHdLWTNJ?=
 =?utf-8?B?ZWE3Yjdka2Y5ZmhYRlJoUk1EOFA3ZC8wYUNBSnFIeVpzdDh4dEZldkJoWUd5?=
 =?utf-8?B?eXBaSXYwdTVIYzU1T0FPb2xHdlNVR0VkNm42dlVBV3JENVpBYnpFdFVITlpH?=
 =?utf-8?B?T3RFRHRQQXRtNjk0VHd2M05TaGpXdUQrNFdGeFNrbk04RWpKZUx3ODlRck5r?=
 =?utf-8?B?SVNUWm93dVZoL1k4MzA3MkZMOXYxR2kzTDk4VjlrTHM2dk9CSFVESXR3RGtK?=
 =?utf-8?B?dzVMc0FZY2h5MSs1QU9WMTJNd09yb3FZbXJWTGtJeWR0amtxWmFWK3U2SmJa?=
 =?utf-8?B?eFV0cnJUQmpYL2FaYXFpWjQ5WnN4dEo0bXFOUnJ3TzVrMDBCREQvMEZheHQr?=
 =?utf-8?B?MkoxY3NRNWdjdldVdlVIaVZJZmh1QWJuWGRPdFBxVDhLd3Jtem04TC9HRnNu?=
 =?utf-8?B?YXpOOG0xWnNLRVp1WlpMbkxEbmQ2bXVLQi9oWW00NkprYjNNVHZ2K1RpZVdG?=
 =?utf-8?B?OEw5SmVjd3p0YVgrNkdnNzlKUXdoS2J1UGJOSmJ4aGdEZjM2T1FRcWYvVVA4?=
 =?utf-8?B?L2pHaUtQc3RBVlpiRm5jYlZUeHE0UUtRbVVSbmZSaVZCbkFiZThWNVVlRmhM?=
 =?utf-8?B?by9RdnRTMTNLRzZjNmh2NzN1Q2NtSGh1TnU2eTBZcGs0Wmdzbjd1c0RzQ1R2?=
 =?utf-8?B?VUlrZWFEUXAwYnJaWG9CbkZvOUh6Qko1SDFpR01oLzluNHl5dUhQN3dqdkcv?=
 =?utf-8?B?OWs4S2U1Z2V6N1Q4TXN2TGF1c1lNbUlBempsaXdEZWl0bUpxcDFMMG56ajEv?=
 =?utf-8?B?VW82bC9JZm9hOUc2TWZxaEFtUU5NNXNVdm1IZ2pXTVZLb05NQnNxbnBoR0pS?=
 =?utf-8?B?UDFEQ2s0RGdGaWk3MUl0U2xvcjUrWDdhRDd3bm1TTXFma2xWY0NWUTBOL3U3?=
 =?utf-8?B?U0xZbG5LaldaSGdXemhBbzE1Rm9lblViaTFpbll3NGN4eW9mdnI4VmNoK3Na?=
 =?utf-8?B?KzlPVlB6cldtU1B5MFMwNTl1V0pzR1lSdmpNTVdCc1JXUmhUa2F1bDYzcXUr?=
 =?utf-8?B?R0lWVE1oclRtVTVLWFA2ZjZ4MTFxbmlFZ0daaVFLNXBpRVJtSW4yVEpiam1I?=
 =?utf-8?B?YXVCOUxjemlrb2JsbFRWUXNscXQvU3BBNFZjTWswTURicTF5RnVVSFQ2M25R?=
 =?utf-8?B?d2FodGxNNTNNa0dKMzRFSGxwTHpNMWdiSlNlbkx0eVpaQlphajVXS2x2TzRm?=
 =?utf-8?B?R1pwTVNBZFlqQlpFcDNYSGoyTDZQYmphN1RFV1libDVnemhjcEZrRnd0TEFF?=
 =?utf-8?B?d0QvdkVaQVc2SFE5SVdZdVpMSWwzWlFhZXlQbkFvYTh5U2FtdzB2eVYzSW5p?=
 =?utf-8?B?OVMzcnFGNW5UeUlJdVZWU2owM2xKRjlBZ0k4Z2FuckE3TWRNM2c1bkhRM3FM?=
 =?utf-8?B?dGwvT0p4TVBNempnYVRXdnVNbDhxdmpPc2VBNmFpci9QWmt1ZmxXeTdLUlht?=
 =?utf-8?B?Z21JbGJuYjBENEdYQlhvWEFoOGM5dkhpai9tMmhHT1kzU283UUs3MzY5VC9Q?=
 =?utf-8?B?U1BKVmdlQUl1azd4c0JHdTZrV1NsbnlkdTBjSGRpN2RHK29LdW9BN0Nta0FN?=
 =?utf-8?B?Sk54SVFKOGpsQlBtWVNiZnI1QXhhSXBYcnpISCsxTElBVFdTL3pFMzFSOHRo?=
 =?utf-8?B?WlNSZGR3aVFHQ3pac0pYRTFDQjI4bUJRR1Z2REJOL290em9pMGR2ZnpaSy9F?=
 =?utf-8?B?SmRDd3JBeVhGN08rYjQ0a1FoYXc1ZitnenlmbVZ0MWcwZ0ZsQ2pLV1dndmdm?=
 =?utf-8?B?Z2NXMm00ektGQkpEYXpueWExZjRCcGRMYldHc3M4WkpWTXNYbFFQT3AvS0Rw?=
 =?utf-8?B?UlJxL284b2RDbkd4bDh6b2EvaGRhZTMxeEFINktJVFkzZmRVZXRacWxXd0I4?=
 =?utf-8?B?SUVJTXh3NW9Ed1R4WElIb0tBR0xRRjVuZUJsMGNDSURteXNHQVVvSXBVL1JX?=
 =?utf-8?B?MHRsRFlzOW9TeHcxUjA4dzJtV1huaHE5MFBFOFRaZUJTbTJ4dXppYkhqU0xt?=
 =?utf-8?B?cVFHaE51OHUwdnFxT1B3MUF0NlJBcGQ1aWhTTGhvbjh3M0VLTXVPcWZxZVRM?=
 =?utf-8?B?MHowMWhyd3pYR0dueEhYNHRseGZoSHdUbjhWTGw5d1BoK3hhY1k1Z0RoZmY2?=
 =?utf-8?B?NGJMUk1UMWd1WWRmZEc3dS9LWHRjSjhMb3RPbFZoYkRURTRkTUFpQmI2SENQ?=
 =?utf-8?B?UFN3WngrRGd4NFhhUytuZHg4RGxKY3k2R3k1czRrN2ZoQkhPeGg3cFdpZTRl?=
 =?utf-8?B?dVFSOXJKYmlBVlJRZzdidkxlU0lPVW5iM1RFdHpjUjJ4TlhBOEEwUT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b29c95d-75f5-4567-21cb-08de84410b18
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9567.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 16:20:02.8572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yh38c8CiGSR+4nGErN69TEzFONDVuzVDCC5Sx927hVNM7/wxiEZ/8Is54ru6dCrM1yff5GkxFdBIO/BuhwX6zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7335
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=nathanc@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 3/16/2026 1:56 AM, Shameer Kolothum Thodi wrote:
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
>> Subject: [PATCH v2 5/8] hw/arm/smmuv3-accel: Change SSIDSIZE property to
>> SsidSizeMode
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Change accel SMMUv3 SSIDSIZE property from uint8_t to SsidSizeMode.
>> Setting 'auto' will use the default value, i.e. 0 in IDR1. A future
>> patch will implement resolution of 'auto' value to match the host SMMUv3
>> SSIDSIZE value.
>>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   hw/arm/smmuv3-accel.c   | 17 +++++++++++++++--
>>   hw/arm/smmuv3.c         | 16 ++++++----------
>>   include/hw/arm/smmuv3.h |  3 ++-
>>   3 files changed, 23 insertions(+), 13 deletions(-)
>>
>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> index 6f44fd3469..ab037df7ac 100644
>> --- a/hw/arm/smmuv3-accel.c
>> +++ b/hw/arm/smmuv3-accel.c
>> @@ -803,7 +803,7 @@ static uint64_t
>> smmuv3_accel_get_viommu_flags(void *opaque)
>>       SMMUState *bs = opaque;
>>       SMMUv3State *s = ARM_SMMUV3(bs);
>>
>> -    if (s->ssidsize) {
>> +    if (s->ssidsize > SSID_SIZE_MODE_0) {
>>           flags |= VIOMMU_FLAG_PASID_SUPPORTED;
>>       }
>>       return flags;
>> @@ -818,6 +818,16 @@ static const PCIIOMMUOps smmuv3_accel_ops = {
>>       .get_msi_direct_gpa = smmuv3_accel_get_msi_gpa,
>>   };
>>
>> +static uint8_t ssidsize_mode_to_value(SsidSizeMode mode)
>> +{
>> +    /* SSID_SIZE_MODE_0 = 1, SSID_SIZE_MODE_1 = 2, etc. */
>> +    /* SSID_SIZE_MODE_AUTO = 0 */
>> +    if (mode == SSID_SIZE_MODE_AUTO) {
>> +        return 0;
>> +    }
>> +    return mode - 1;  /* Enum values are offset by 1 from actual values */
>> +}
> Maybe better to consolidate these comments and move them to a
> function level block comment above.

Yes, I will move it above and include more details about the function 
implementation in the block comment.

Thanks,
Nathan

