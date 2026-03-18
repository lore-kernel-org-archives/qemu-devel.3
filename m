Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5C810775FE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2vZW-00077Z-IJ; Wed, 18 Mar 2026 14:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vZU-00076Q-QA; Wed, 18 Mar 2026 14:24:44 -0400
Received: from mail-westusazlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c001::2] helo=SJ2PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nathanc@nvidia.com>)
 id 1w2vZS-0000rX-7j; Wed, 18 Mar 2026 14:24:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1gnOkBNZlc8NPm2yG6X9TP7h1jLQ5u7oMBfKxincBTnev8Ek4vNsErGtQAzDjnVSyrkjRHQ7dd6YyjSCpyaCd1+zKpyAMLAcmprxs4kGamwp+cPVwSG5NJH6+FOWPRmEK31SkJCeHV6LZDeZDluVTGnD24qz9pY10Q4NQ3lfQAfO7WvRQZwJvTC019Udxz9ziPjuoTA9QqE/QzG2/NkAylUcSxnVhfu2KrtrlX3SpdFFX8BMr5sPBd4k9TNuy6zx2TRsF+84vScXTAcVAUzbMlJUhEWGm6nGezkiJRj6fAQ6wVB3GTxtXoce+xA+QI5GGOZWwLO6Y/uCEg4X+wClw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHYg6Qr5tHR/pgaqymRBhXdMIv6JM+V1tJ/sgfJkslA=;
 b=CxhjzqciVIqMGCxcXqwqT2cd/CyHKQFFdatirBYvrvr9UjXMXk9qiOAqhA8DfBzcWpow6ukqbX0/VYT40N3XsTnJKXWtYBQGxxcfjDfTR/MWYQv3lFAO6NHKZyJ4ezbeud3M/xSxdY8KXoOwCk8nOmJ/W5M/ISoez3HQfNy9f10tuErJSXmpH44EhoiK+DwNQRVvnHpEFjSci9tbUcbiIC89lR+SnQJ0RX7pnYRvCt94DOQGCjuBoy+BiLHKZk1OcwXtsf7C8tGn9wGicUFCJBrQvjnnJIPMTVGwpl78dYO/AvFZFboorvWY7t9PVdTOsiEiAc+yJ7EHiWalFjDGMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHYg6Qr5tHR/pgaqymRBhXdMIv6JM+V1tJ/sgfJkslA=;
 b=V/dSHzAg3exZaJ7SevrhlIK+psGbiWr5ZwPjpv0dayIFNurSKKrchGOzzLspODQSHqC8RQ3gnkBkoolFCEUCJApA6uGxGLOA4fqv9Q8uCBScvsmJ/lvcZoHklN1Qd22haElIR2NyCCYwCXt8ZFwoZ8oDxirartKWQPOPpyyCKntMvJV8oXjcagdCIzzHkk95mIdWydfXzdGCunj+9vnAwxZPqFgus+3u0oklvGKIhWiKy2ozmuGwXWnnEAXlqmYAgC+DJhGmnF3jaDgzXqoH75PdHJZA04KcFybTuR+Hs+Y3z28a/8AJgtjw46BZolyPYz6ZShy8T/G20q9hiqDMbw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY3PR12MB9555.namprd12.prod.outlook.com (2603:10b6:930:10a::14)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 18:24:33 +0000
Received: from CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e]) by CY3PR12MB9555.namprd12.prod.outlook.com
 ([fe80::fdb2:266d:ee2b:8d1e%6]) with mapi id 15.20.9745.007; Wed, 18 Mar 2026
 18:24:33 +0000
Message-ID: <a2b99b73-23ae-4a01-8005-d21f5a27621a@nvidia.com>
Date: Wed, 18 Mar 2026 11:24:30 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] qemu-options.hx: Document arm-smmuv3 device's
 accel properties
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Cc: Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Matt Ochs <mochs@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260317183755.3721625-1-nathanc@nvidia.com>
 <20260317183755.3721625-9-nathanc@nvidia.com>
 <CH3PR12MB7548928AA0A42DD675F06708AB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Language: en-US
From: Nathan Chen <nathanc@nvidia.com>
In-Reply-To: <CH3PR12MB7548928AA0A42DD675F06708AB4EA@CH3PR12MB7548.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0006.namprd21.prod.outlook.com
 (2603:10b6:a03:114::16) To CY3PR12MB9555.namprd12.prod.outlook.com
 (2603:10b6:930:10a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY3PR12MB9555:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: b31fd67c-3c3a-48f9-59da-08de851b99f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: g7jOpG27yNuROpC2+5WYUc3qN/vZKFoOe0FkKosDatp4XFIaciIaeeLdizBXqMNVSxLJEK8WXk6t6TEWsclQyhfKWHhoWJBuhZZlGQ/mf1VARn465S0Tplu5q5Vx1XpKvBGkCgphshNOteb0WSQZjfzYV9aP4HF1uO1lyo9vZGO5OYrzotIUp9sn+xvGxtRh5DfnRP8WSfVf6U6RW6DgSnPeVfF/j8r8YSpvlBLU9VSQK5QDOScQnkkR+EaGM5x72FiMUyITXsvuBj8ZIB1vyhqceiqie8CiyNgt2nRUksDb3oqI1adisyC+EvLgpU6Moh1cddOvyie6nP1Qtrj3VgcLQY1gbWLT4oec+qX8vXmdMy4Oqor0X1fxvQQAagpohae+FV+yyrzK3nh6NkgMRcX7hlaGjM1qrO1uHQujjSEKIXIuBFvM/1/q+MaCdWct7aKPTLWzyt9X/EmZlz8atHmdOPS7A3cPE28M36rdFSvfFD/cnSPWL3KZuZUQiPb7/eq5P7vGkOIUqNZSV/JjE0c8oTtrqD9ytwGk3A+6bF/nP2VkJzvYMhf7YJ5GIfNic8mumSyFunbAGRT4XiZu5LMUcdRfY7s1wt8tFPj8kgTS3YcAc94GFv9UDOYS/pRRnUWWvGzxQdqhBnwvaLEAFiMyLXpOZJIFIoOp9RC6T1e5wY5ilLfVNuZeLlOidFZ46LEejbEc7xEaZpN0SsSeKUxQWAax6GcaRgExWQhIiRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY3PR12MB9555.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aW5pY3IycmdyQ3VaWHRXbzF0cFc0ak5PVnd6QTE4OGw3N2tJcGNYeG43bHpx?=
 =?utf-8?B?MGVOQzhHZHJwQW4vY083cnJtRC94NEsvUFJHQUNHd2RybE9PaGRwSm9HZmdX?=
 =?utf-8?B?WFczRWVKaFRRcDFWdFFHeldjeTJQSCtZK0M2eHdxb0QxT0VpOU1KV1lXWGdX?=
 =?utf-8?B?ZEpRTkh3c25zeHMwZXhydklhWHRuTWpOdGdRVllQTHhkWitLQ1ZqTkhJb1dp?=
 =?utf-8?B?T3Y4WFFrSVBsV0xUZE5kV0xmWjFWUFBjRnB2WVB5aW5BTU1pdG0zNGJqQ3Q3?=
 =?utf-8?B?TXVucERmZTI2dGY5UnpxeDB5azhnMjFEZCtwdk1TR04yS2k0SWpyUlg4MEFa?=
 =?utf-8?B?VExlYUFpUS84cEdKOEJ6RnRScS9XUU4zakttMHIrcEdwZWdqK2pSRHNSb2FH?=
 =?utf-8?B?M1NQNE5LalFFbnhzTXZXbWEyQTJHVStTVkpOUEZjZDJKTlBvRDR1K2RaR0g4?=
 =?utf-8?B?c2RPS1VxeCtyQitTSHphblV6RUFNY2RpWThqMFZ4YVltcjduVWlvaFhRUVdO?=
 =?utf-8?B?L3hyY0xVc1JMb01nRjF1bVFRUnBHN1RaUTJxRDdBSU1BaStTL01jWmlRWDlJ?=
 =?utf-8?B?MEZNdlRycTZycWp0SHlMTlo0NHFWWStyaE1NRXc0MnlJMXVRSHh2cFg0M3VQ?=
 =?utf-8?B?ck82c3V4a0pWYXlGQkhsWktYZUpZdGZ6RElqbzh2L1IwTnZvcERDRWpzd3gx?=
 =?utf-8?B?amNWdnp6K255MTlqK0MyRWpKRm9xd0J2UERDWTRidWx4eUg1R1hUT2UrYklD?=
 =?utf-8?B?Mnk5M1paVzhFNDF5TTdnRjIxY2tld3Y4Mjg2WDJ2WnE3RzZhbHpabFg1TWpM?=
 =?utf-8?B?YTVoWUJHSFJ5Y1lJR2lvMEs2d1YxeWYvRnQrbStxNHVYKzVPVURaRjFyZFVa?=
 =?utf-8?B?YVB0ZFFZUnA4OTBFVG5ldWt4cG9abm93UEhRSDZyd2RyQUlyU25zL3RWVnIv?=
 =?utf-8?B?VHczV0dVdGQwYUhvMnJVVlRxano3UkhaMTc1MkpPQTdRQng0cDhQTE1mZThx?=
 =?utf-8?B?MzA3SUxRVGtsaVQrYndJcnZlRlNPenFxandkOVlra2FkbkNMWVlmTUZqVjAr?=
 =?utf-8?B?cDFua0d4Mkh5bnBBVE56TURTckZ5aVFYODhpdDBrVUpqSklWRFNlTDdxUElm?=
 =?utf-8?B?cTI2NTZRZFQzN1NtQmJKTVFHQkFEdXRyRTAvUi9kUUQ1QTR5eGtqNlB0a1Jr?=
 =?utf-8?B?cEwvOFFXb0VudnJOWXVKN3g3YjNNTjViMWVyL2Q5SUJQTjhpTzZtcGdtS2pm?=
 =?utf-8?B?NHI2V0tVZUs2aEg0aklKamhLcHY5ZGdUcE8vSjVrdDAzUVkycCtaNC8wRjha?=
 =?utf-8?B?L21JRDY1eTQ0VUt6dENQWFRBSDMydThZdWcvdlRRMXZDeFA0dkRYa3BGR096?=
 =?utf-8?B?VjFrWkJRZmJ0anE1bEdFQ2puNlU5SjY5OHc5YXBwM29wWWJUSmRzcWpoNkI3?=
 =?utf-8?B?QTNqeHdKVTBmZ3VobGJXQ2pjZTlHK2NNT3UxbUg5SFczN1dXY01hdXF4YlZi?=
 =?utf-8?B?Qk0vemRKZWtpUFZNOE5HaTVONFNEbjVReG81NTBwdkVqVCsvZWNVcFNyZ1dC?=
 =?utf-8?B?WHIxOTQzcUJqUXFPaG94VS9mKzl3S0lxRmJkWDRBNmh0T1h3SSsreGZQcG9l?=
 =?utf-8?B?aTJZc1NuQmEraVgxN2o2N09waXN0dTdlaGhEeFA3M0g4RURxL0xWNXhNZDh1?=
 =?utf-8?B?UzlncXlqM2s2RytGR3N5SnFrR01Kbk55dFpwTTlSWkM0WCt0a0NObHdYZkFI?=
 =?utf-8?B?NlpWbjB3Q29uUHhUaVY1R3k1RStVNTNkSEdMZS8zM3lRclNMTE1MbUt1Y0Nm?=
 =?utf-8?B?UHIzSnl4Z2pCWUg0WE5kVmtGZVJzSC85Q3FtUG9vY0Qyb1BXMGQ4ajJTMzNu?=
 =?utf-8?B?WmprOHgrdjFyaGkwSDFDRnpLUmljcW1WclJpcnJHWU95NzEzTnR6ZXFPYWR5?=
 =?utf-8?B?bVZDT2cyOTdWcTlQSXpvRHNRQ0ZJWTFLUzlQcEREWlFWa2NQQ2JMcWlBdDkv?=
 =?utf-8?B?NHp3dWliejBpaStnZ3QrWDFkVWp2SGRwbzBaQ2sxbkRoYjB3bUxDUjBrTHVn?=
 =?utf-8?B?MlpPTkpxb09rOTl3blROTzNwUEJzVVdJanJNZFRlT3doOG5TSmpCUUhNMGlv?=
 =?utf-8?B?Y29nbmpYVlVEcDFLWDhrM253WTM0NVFkcGNBK3BjNVN3bHcvZkI1UEc5Y3Nx?=
 =?utf-8?B?ZG5XczRGamZXc0JlVDB1dVZ5RXh2TzY2TW5QYUhtRm1GZGhGM2lqOEJlRUY3?=
 =?utf-8?B?c24zZnphVGJzN3d4YXVxbEVmTnFtbkxuSlVUQ1NUKzhYeHE4bk16bmlOME9C?=
 =?utf-8?B?TTVmY2lmak9JbVRqYmZlbng4U3NwMlZXdEN5QjllNmFDWTcrNjhnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b31fd67c-3c3a-48f9-59da-08de851b99f9
X-MS-Exchange-CrossTenant-AuthSource: CY3PR12MB9555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 18:24:32.8662 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W0NY2M70L6pp40dwu9d99CxK2T+TOXkzsQll8ORz8GyQrO7/kpkb5+o+qZdyD2H5aXMMRBMMLdXBrlwZCnbdcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013
Received-SPF: permerror client-ip=2a01:111:f403:c001::2;
 envelope-from=nathanc@nvidia.com;
 helo=SJ2PR03CU001.outbound.protection.outlook.com
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



On 3/18/2026 3:36 AM, Shameer Kolothum Thodi wrote:
>> -----Original Message-----
>> From: Nathan Chen<nathanc@nvidia.com>
>> Sent: 17 March 2026 18:38
>> To:qemu-devel@nongnu.org;qemu-arm@nongnu.org
>> Cc: Eric Auger<eric.auger@redhat.com>; Peter Maydell
>> <peter.maydell@linaro.org>; Shannon Zhao<shannon.zhaosl@gmail.com>;
>> Michael S . Tsirkin<mst@redhat.com>; Igor Mammedov
>> <imammedo@redhat.com>; Ani Sinha<anisinha@redhat.com>; Paolo Bonzini
>> <pbonzini@redhat.com>; Daniel P . Berrangé<berrange@redhat.com>; Eric
>> Blake<eblake@redhat.com>; Markus Armbruster<armbru@redhat.com>;
>> Shameer Kolothum Thodi<skolothumtho@nvidia.com>; Matt Ochs
>> <mochs@nvidia.com>; Nicolin Chen<nicolinc@nvidia.com>; Nathan Chen
>> <nathanc@nvidia.com>
>> Subject: [PATCH v3 8/8] qemu-options.hx: Document arm-smmuv3 device's
>> accel properties
>>
>> From: Nathan Chen<nathanc@nvidia.com>
>>
>> Document arm-smmuv3 properties for setting HW-acceleration, Range
>> Invalidation, and Address Translation Services support, as well as setting
>> Output Address size and Substream ID size.
>>
>> Reviewed-by: Eric Auger<eric.auger@redhat.com>
>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
>> ---
>>   qemu-options.hx | 35 ++++++++++++++++++++++++++++++++++-
>>   1 file changed, 34 insertions(+), 1 deletion(-)
>>
>> diff --git a/qemu-options.hx b/qemu-options.hx index
>> 69e5a874c1..0ba8322695 100644
>> --- a/qemu-options.hx
>> +++ b/qemu-options.hx
>> @@ -1279,13 +1279,46 @@ SRST
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
>> +        Enables guest to leverage host SMMUv3 features for acceleration.
>> +        Enabling accel configures the host SMMUv3 in nested mode to support
>> +        vfio-pci passthrough.
> Nit: Instead of repeating for all options below, may be we can add something like
> below here:
>               The following options are available when accel=on.
>               Note: 'auto' mode is not currently supported.

Yes, I think it will be cleaner to consolidate the notes about accel=on 
and auto mode like this.

Thanks,
Nathan
> 
>> +
>> +    ``ril=on|off`` (default: on)
>> +        Support for Range Invalidation, which allows the SMMUv3 driver to
>> +        invalidate TLB entries for a range of IOVAs at once instead of issuing
>> +        separate commands to invalidate each page. Must match with host
>> SMMUv3
>> +        Range Invalidation support. Only applicable when accel=on. Setting
>> +        'auto' is currently not supported.
>> +
>> +    ``ats=on|off`` (default: off)
>> +        Support for Address Translation Services, which enables PCIe devices to
>> +        cache address translations in their local TLB and reduce latency. Host
>> +        SMMUv3 must support ATS in order to enable this feature for the
>> vIOMMU.
>> +        Only applicable when accel=on. Setting 'auto' is currently not
>> +        supported.
>> +
>> +    ``oas=val`` (supported values are 44 and 48. default: 44)
>> +        Sets the Output Address Size in bits. The value set here must be less
>> +        than or equal to the host SMMUv3's supported OAS, so that the
>> +        intermediate physical addresses (IPA) consumed by host SMMU for
>> stage-2
>> +        translation do not exceed the host's max supported IPA size.
>> +        Only applicable when accel=on. Setting 'auto' is currently not
>> +        supported.
>> +
>> +    ``ssidsize=val`` (val between 0 and 20. default: 0)
>> +        Sets the Substream ID size in bits. When set to a non-zero value,
>> +        PASID capability is advertised to the vIOMMU and accelerated use cases
>> +        such as Shared Virtual Addressing (SVA) are supported. Only applicable
>> +        when accel=on. Setting 'auto' is currently not supported.


