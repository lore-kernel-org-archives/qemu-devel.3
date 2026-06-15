Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DD3CCD98C5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:41:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ8Uq-0006Km-Ea; Mon, 15 Jun 2026 10:41:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wZ8Uo-0006KX-5H
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:41:02 -0400
Received: from mail-centralusazon11010038.outbound.protection.outlook.com
 ([52.101.61.38] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1wZ8Um-0003ll-6V
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:41:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MVg+o1hzJFBspzHVxl9OGM7BJIONdnoBwbRt3yG8BuO/KFhz/JakwkSDAPWCM98eGQizB7Cq9snSOY/Dc7v6bgSl2x3N/Jz448AOH1XdHBWHgxE76/9gYl/r5e39THsUsi8v6adsGxHLvrrEIiywr1MoFekqCMAohwOd3jrzHEdKBucKuJl2dAt+rSeFcxnnbE0nsL6T8+Atl3oVx+Wv5RFMlW5eQ88vObKq5lfsxkuMmh2dHWN5p+9cPkhT2N6nPua8NxmfwkudTb2XQPgQiQEwUap3ZGOJQZHOOLA/W9ZipSAjPOl9mwYAppVW4Nt7vv5C1LKSNzSWcfdlL4rblA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1hphCuZN3sK7rnEO/wZb1SIzlONzG7dbrc47aHGe2k=;
 b=xpaxhC0rXGLYm9ilMQw02DVnHXpKn54yFGoaKc9W9f6YyZrx5Ib2urIrnbXNW4mSjNEWwZdnbTLmb9pEytKSpYd09Gf/kF6ubM+HP7BMjUPotwgTEozE9msRCyAAPDh7ltekk7IzWe9ApPggJheuSjfKfrS9XRhefwEa5qveFjdHt++UPxB2eoOR8Sc/w1xzRDsxhblOnhIFIgUWWcIeTzYZu4EPCDTvyShmremGQjRSfssWAL/G3o/O3eSxTGeMIHzM5rVn/SV0AcbjP4C9+hANcbOVP5WTdGdmfyKvgi21v3nMSJP0pW4c41Pih+sZnOfASEksJjPrYHQ06wdi5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1hphCuZN3sK7rnEO/wZb1SIzlONzG7dbrc47aHGe2k=;
 b=X3sleQmLf54QGRvOMNJTDIGZOHGzlxmbGnDbntN6QJlEN/KvKLC6mdBCtXVsWVUEqpuF3RTf+cw51N4QbfW9PgG7LjBb6HHZJE9vZncSoWtKbQtS19N8ir5kbPIlnf24dk88bjBuf9Kp6vasVWi7d6XkRKnRzHFW+GYsPCMVAbIpSdWki5HD9TsWgRwtjZ7op5pWP/MNOf4YSad40ydyELo4c+QWaf8ieUw4Y6R4Kpx5Badgkp50FTh8i2xRG9r/bWDG8oXOsMGQ742nLkIDiLBTl9gHBSjgAJJbpf/3ZFd87NlidRTcHOq7SJVCetoSPoEmF5bBogoOtGb949hdxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 14:35:52 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%7]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 14:35:52 +0000
Message-ID: <9605d542-f797-4ac4-bb62-966a77ffd361@nvidia.com>
Date: Mon, 15 Jun 2026 17:35:45 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/14] migration: Make switchover-ack re-usable
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>
References: <20260609075812.32067-1-avihaih@nvidia.com>
 <20260609075812.32067-8-avihaih@nvidia.com> <aiww8tN6dRLA3t_R@x1.local>
 <e4d00894-990b-44b3-b89c-7cd1b0398a0a@nvidia.com> <ai__gjsVcZs_ecLc@x1.local>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <ai__gjsVcZs_ecLc@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0408.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::6) To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 3800d376-b728-457f-6471-08decaeb6692
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SLA+s1JcJH0Un3eOIkLMQK2dT5wnHJE+juswVa0rDC9AdjInuxTR2Z4tcoBJ1euXidCuavnvTlz8KL7ND28RX+51sE6FU8HFMCRuobaF/u9Qo8bMJSfoZmQJdij+RLeIvK3GK/DqzZVUmoA5DVUAsJnhEnGMKiO7fxVpG91MGe5hf0JlbiH4kA2Bb6lgYiMe42gk/yuXvN5i6vyxPSRESIbRYu2WatQkGQ2AiHx8D+9XNXAkO9cPO7knDJgagjYupCm3UsVN1ActzD0r2qbCDZl36F94vTPOmM+zyacM2XLhl3WRkGV4HTz3yFiHrcowiboSI7iAuqtFvSpyzHtuCQHrXeFVKe9iItdP6J3Ym+3wkIkzWWzMe+/2xsrNWztyAyw4dMAbNhZvnl+oCvhD8Hn9nrTBYosm8HsS+FpUYWwegac6DhMjtruE/qx9ATB93wurjYcmG4EFqGBngHO/+1PzViYzMGoY57eYgHBDEzMJnumtNMaB1/usMOiuDbrCwuEkyuHvnAGStNSTbxvi0aYZrZReYZgWTFOb0ean8b4b8/81K4ouVCOrpMriqSKVmXB+Z5jOtxrDr49ZzrAIVyLldWF4X9pdYdvlU6Zar1ofuZb1LNxrza4YdKP8+fDt5mFY87+/B96vp3VZTHmr1zh/pqngTmyLXAQdz66tyIkhEd7kxKIwfkOiuS3BRVZX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEVyY0VjY0hHa2hGWkhHTHJMR0xkaWRxQzV5TDlZaWhsTHJVditKWU5VL0dp?=
 =?utf-8?B?UlAreFhZSm1LallocFd5WitIYVNJOGVML3ErbmJPYUIzWmVQd25qQ3VDWnJO?=
 =?utf-8?B?NDFoaDBIOHZWVVVWNm5RRlFqRExteVNkU1B5N0FaajIva2NrWlR0WmNYN0pp?=
 =?utf-8?B?Z1dXQUp4SGp2MWxBdTVLL1M4dGprQkNjQXpYRGFFdVBkdGMrWjBONldwem41?=
 =?utf-8?B?ODJZVUV2SWN2V1NPSmdYekt5UU1iT2VLazJsZWtTY0diZ1MrUVNYSVdkQTZ1?=
 =?utf-8?B?VC9SU1k3ZmJWb2xQd1NTZ3IzZWVVcVpWcGl0Vm1TSGpFeFdKV1N3c2RSYi9w?=
 =?utf-8?B?ZzFub08yeVh0QlNjSlpwSTVFSmpYaEhza0FQbUZNcFBnMHdRRzkxVHdkNFJk?=
 =?utf-8?B?ZENvRUdtNjRZcUVEdkxIeTZnNzhkdnhHdXNXT0U4SG9uWFBud0U2UXNaZm1z?=
 =?utf-8?B?S1U5b0oreWNmTHNmUnZIcFYycTlTYnc3dy9Ua1MvcitZNGwwVmI5UkpnRSto?=
 =?utf-8?B?VEFxQ3dGWm5GZ2ZKVm91TG5FQk5NRktDV1U4RXBpWjNLUXVDZXZaY2gzRWpu?=
 =?utf-8?B?V3lZQVRYdzRDazIxUTZRMW8ra3I4WjYzU3lsbnhVZTRwME5EN2ZHZ0J2RGk0?=
 =?utf-8?B?MXpaUDFNWU1BWUJpalZFVlV2UW1sWDZkY3BwRmJRWHFsUFBtRGxNT1pLd0g2?=
 =?utf-8?B?dzJLcjNGWVhmaVl5ejZUNXBCZGJnWGt6VTNUOUNydS8rSzlzV1hDdlRXUG1l?=
 =?utf-8?B?T2xGWENpVmRSalhvRjgvVHN5cVVoYzFENlBaaENjQTdYTTVPS05qOTdGRDhv?=
 =?utf-8?B?QXBhbE1RdGpjanNPOWVtR1crMHRPcXYyL2FZak10Y2FhcENCTEJNcUFGeVdk?=
 =?utf-8?B?K1h6YTNzSVBVT1R1MlVBYVc2cll6V2hIdzBYdDlYTHM0b0RSVktMRGxOUmxV?=
 =?utf-8?B?c29NL1VMNHM0bTJzN0l0Rks4cWE4WXVCSlRsazJ1aWJCV2F0a3g0eStzTkV2?=
 =?utf-8?B?RktFNzUrbnJnektUREh5MVJlaDVQZkcxZVZScllncHVoWlB4aVNlSzdBVnFF?=
 =?utf-8?B?cWhoaDdEUEg2M25xaUxwbm5JODFTME1sMlBRb0xRbmtKeFN0S2NmYzc0SmN3?=
 =?utf-8?B?N3RDcTEvNHNUNkxGQjgzUkhLUDRXVG9iQTllSU9KUm5zT1RVNjh6aHprZVAx?=
 =?utf-8?B?dUhIV2VQMzBZd25qejRmYTJ2T2lEeWorSFI5bThTa1ArcmVyMnpnSzJBeVhG?=
 =?utf-8?B?b2RIRHJHbitucmx2alZrZ2lueTkraVprU2JCMnNlK2g0ZnREWkJwS0xFWmtX?=
 =?utf-8?B?akZZUmFMSndhWkxoaXF0bGp6TitZKzM3MktMYngxYnBQY05FaWkyamhlR1M1?=
 =?utf-8?B?amd4TCs1WjZwZnNmZ1F1Rzh0M0lEOCs0NHY2MlRXMUQ4aFVDNWVaQTduaFdF?=
 =?utf-8?B?THUrWlkrOVZYcmM0S2JLT0JtRlpDanExOU9zdHJ2SnQzTWhXNHp6RXJnbENR?=
 =?utf-8?B?ZHFLSFR0aXpoQ1JIRUFIbzhrUHVCMXdUVVByd2krUEt1eFc0Mm9tTG9aa2t0?=
 =?utf-8?B?SS90TzYyWVd5ZXhiblpGSm8zL1dhR29wOSs0c0phTStKRXhGV1VOSzB3eXl4?=
 =?utf-8?B?bThUR1Jlb0FkSnUvN1JPV1JvWjlPQmFsWUVIZ28yZnB4dVFYZk1kVmwzK2U5?=
 =?utf-8?B?aVhjR1ltL3JpbDRGeGFIa0U4UC9mSHRFRXZMQlNtZUNtc2ZoZForWjV5K1F1?=
 =?utf-8?B?WnlHYktLa2pqRE52U2hHbUZIY1dLaSt1NXV6R3U4aUVadWlsNXlRVjN1Zkxj?=
 =?utf-8?B?cUNGNGNuNzNNZE9mRGJYUSttUmQwT3lPeDJkWEtHNFUyWmhQK1l2TGc4RFhM?=
 =?utf-8?B?SUZ4OHRkZTBPSHo2ZlVvT2FnUUZ1L3FaUDB6UWR1UGY1dzhva3lLaHFjeCs1?=
 =?utf-8?B?LzFzMXhSSEt4YU1EQlRZYlFTTHJRU2Robm91S283OXJKWkJuaTFtc0dydklY?=
 =?utf-8?B?TVBDcFFIVGZBR0xGUnlTWWI5dmg1YVY1Z040Z1pSdXRreWcxQWpYYXZVQU9t?=
 =?utf-8?B?SmFsZjlibk5TY256Mk1QWTNqS1BSVSthSFlsWkRGTHVBWnduVkI5NDh0a0ZR?=
 =?utf-8?B?ekdPQkprcHk0dW5lOG5XNlV4b0hmYnRIc1NPRHRCdUs0NHhxSUd1Rmc5Kzdu?=
 =?utf-8?B?dnBzalJQajVPRDRSUEptUEMrVnhQWHA3MC80SVRKcTVtNS9CZXoreXFBQndS?=
 =?utf-8?B?VG9uaHZqOFlDMTJ2RjFGSTFRTHVLYkg0N3cyWGcyOFpUZjdlSUNjb0x3a1BD?=
 =?utf-8?B?TzROSlFqc0wvb0JidFpOSnZGUVVrRmZVT2xxRGQ0WjFPb1ZkRVZ1QT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3800d376-b728-457f-6471-08decaeb6692
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 14:35:52.2927 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0d8tXaBF6sgTz9soH/fXsCalZxPNgXcbGKL+JRDS1WvPQ/bwwX3leSObanzXo0wiW/zd3dUVW+zge0W4KMC3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
Received-SPF: permerror client-ip=52.101.61.38;
 envelope-from=avihaih@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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


On 6/15/2026 4:34 PM, Peter Xu wrote:
> External email: Use caution opening links or attachments
>
>
> On Sun, Jun 14, 2026 at 12:50:14PM +0300, Avihai Horon wrote:
>> On 6/12/2026 7:16 PM, Peter Xu wrote:
>>> External email: Use caution opening links or attachments
>>>
>>>
>>> On Tue, Jun 09, 2026 at 10:58:05AM +0300, Avihai Horon wrote:
>>>> diff --git a/hw/core/machine.c b/hw/core/machine.c
>>>> index 4d8b15d99e..8219f13779 100644
>>>> --- a/hw/core/machine.c
>>>> +++ b/hw/core/machine.c
>>>> @@ -43,6 +43,7 @@ GlobalProperty hw_compat_11_0[] = {
>>>>        { "chardev-vc", "encoding", "cp437" },
>>>>        { "tpm-crb", "cap-chunk", "off" },
>>>>        { "tpm-crb", "x-allow-chunk-migration", "off" },
>>>> +    { "migration", "switchover-ack-legacy", "on" },
>>>>    };
>>> This line needs to be moved to the last patch, or people will get very
>>> confused on last patch flipping default without caring about old behavior..
>> This patch Implements the compatibility flows for legacy switchover-ack
>> which use this property, so moving this line to last patch sounds even more
>> confusing IMHO.
> My comment only applies to this one line to change hw_compat_11_0[], not
> the property itself.  It won't affect this patch.  It's common pattern to
> do this in one patch to "update default value, but let's keep the old
> machines unaffected".
>
> Btw, since this value still has a default value ON in this patch, moving
> this line to the last patch won't change anything except making last patch
> clearer.

Alright, I'll move it to last patch.

Cedric, would you like me to send v4 for this?

Thanks.

>
> Thanks,
>
>> The last patch should not be viewed standalone, it's tightly coupled with
>> this one. Plus, it doesn't make sense to have the switchover-ack-legacy
>> property if it's always off.
>> So I personally don't find it confusing, the last patch simply enables the
>> feature once everything is in place.
>>
>> If that helps, I can extend the last patch's commit message to something
>> like:
>>
>>    Now that VFIO has implemented new switchover-ack, enable it for new
>>    machines. Note that legacy switchover-ack is still used for
>>    compatibility with older machines via a compatibility entry for
>>    switchover-ack-legacy property.
>>
>>> After move, feel free to take:
>>>
>>> Reviewed-by: Peter Xu <peterx@redhat.com>
>>>
>>> PS: If Cédric feels comfortable updating that while queuing it'll be fine
>>> too.
>> Thanks.
>>
> --
> Peter Xu
>

