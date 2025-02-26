Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0894C021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 12:54:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnGvQ-0007yg-0T; Wed, 26 Feb 2025 07:54:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tnGvH-0007xU-GC; Wed, 26 Feb 2025 07:53:59 -0500
Received: from mail-dm6nam10on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2413::625]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Vasant.Hegde@amd.com>)
 id 1tnGvD-00056k-IK; Wed, 26 Feb 2025 07:53:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VeVfQNg08ZOaFTHruVl+GqciMUAzsLmmee/oWkN7v/UXAgeeDuGktAp+3K8BA+e6SK3H1JpWqPzjUNxnIOn88FmCCjJvBOdqazcvjxh6XGfqrG9PgcgzWKnjoqyu3XA2vMOg8vYiWmxXXfPcH7JMWSlbP8pEp6Xq0YoAOiZXROQrUgdTXoIKcvTEwxWmnhkeAPyK5h5PX2ioqoWA4SKioLz9Vb6U7x9iJ+iNnf0cypxIlCoG/q2iz8kx8J0s+hnfGsMg9GJDu3SLpoRloOlgBcAFlMH94Oh+NOwrtgb0Ro2EhTy3BR6F7QGQpIFbRnF3+s9covy8VIn0kV/74rQ28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnDHp1UH4oVKoQCEoUz6mlrwhSna+BBJEH8QbCIGPkg=;
 b=m2Zy98x1qBX/bOEym/oLSfjgvNNBA8h2msFvTfAho5FLbZGTdHym3eZFqJShqSxYKHCWnUB47GA+9PwnqM43N/DuMZW5A68ycTMDX3Ke00yS41/BG9S67TODIOk6rXtemTHFztoqtN1Q0yokfkuSf1y/d8MapBfzmJcFYvWZvVj5/q+e8HgGMM4O52vG+LC/o6gUoQL4PoWa+EqbtI643UDKEDQ4J+Vtuaei+xDu55WMCIlmnEiPNKWBj+fRESyrxD2D4chii8Fio/dts0MmQMYTB1xlMCD1YMGwJMwpoX6DDfURyn3lNs0h+r3G5Ol3asE1WzBfgHf7skbqtyltOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnDHp1UH4oVKoQCEoUz6mlrwhSna+BBJEH8QbCIGPkg=;
 b=1AGcrD4nKzaPWnu3szbpYiGbjAYX2N+Y651nlUiIQf6SK57e2VBnt3AuiqTDc2oy1CXU8CIgbobxUYuSObvlcO04wbCZ86+cLjq+tBpxnihx5HxsnygZ+2FBhSr7EMKBvDV+95qxyQi6g4b3m25QAKpr+umzB/XX/QfmNUG4iuk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB9085.namprd12.prod.outlook.com (2603:10b6:a03:564::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 12:53:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%6]) with mapi id 15.20.8489.018; Wed, 26 Feb 2025
 12:53:45 +0000
Message-ID: <75adbcf1-0acd-40e7-b1ef-c699c07bf2fc@amd.com>
Date: Wed, 26 Feb 2025 18:23:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Emulated AMD IOMMU cleanup and fixes
To: Michael Tokarev <mjt@tls.msk.ru>, Sairaj Kodilkar <sarunkod@amd.com>,
 qemu-devel@nongnu.org
Cc: mst@redhat.com, suravee.suthikulpanit@amd.com,
 qemu-stable <qemu-stable@nongnu.org>
References: <20250207045354.27329-1-sarunkod@amd.com>
 <985611f9-e7f9-44d0-a8c0-95fb48370591@tls.msk.ru>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <985611f9-e7f9-44d0-a8c0-95fb48370591@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0200.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: b41d43a9-baf9-440e-7f9e-08dd56649afb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlltdFBkb3BiMlRRRzk2aFpTa0VJcC81MUtGVVBuSTg1WHVLOUpIU1ZFM3dk?=
 =?utf-8?B?NTc2V0xRS3p3OGYraVRYTy90R0hFR3BBQjJYQzgyUTNRRFczajB0blpSUERp?=
 =?utf-8?B?aGdaN1BwaStoUkEyS0xpZGd0L2NHQ3MwVlRON3daWG9ITTlYakxIeWM0V2FG?=
 =?utf-8?B?Vk9jczNUV2pVSE05WTFnWGtydkFJek5aUTRKdEVkUERjbFVtbTN6WVM0OEho?=
 =?utf-8?B?OHVOY0R4M05JeG5VcCtncnZDaXoxRU8rT0ExRjI5bGJMV2huMzJrcW5tbURy?=
 =?utf-8?B?TGRCdE1tMmx4TDBxdTV3eU42T2JHMk15Z1BmTkE4bkp6bk4zQ0JXZ3JLMFY3?=
 =?utf-8?B?OERjZDR5c0lLcXBjaWVOR3dpY3B2YUxlMVEwRFJDNW50ekVNWDNlcjBnc0o5?=
 =?utf-8?B?dm43c09nb0Z6V0s0NHRMcFR4REpzWmsvK0FvNllXK1RIVnVjbWh0SzNrbXJt?=
 =?utf-8?B?WWFjTjd0RjcySWhWUjRzZkt6VVVDYXdXUi9jWjJKRlE1VjcrazdSMTMySG1r?=
 =?utf-8?B?TG44a0h3ZDl4ajZwWEFSVVZYWnZnNHZGZExhWWV2U1h1VWh0OUwxMjJPcTFD?=
 =?utf-8?B?Q1JXWmtteUNZMGtTRDhYdjA4WXN1NWFua1RoS3hnU25yM2FHSEhRZTNqNThw?=
 =?utf-8?B?aFF1S3ZRc0dRNksxUTcxcG1NdHc3Nld6RENCRnA2U3RacDBCaEY1eHIzQkpV?=
 =?utf-8?B?WjVPNHZ5NUhrZTNmcFp3dkdOa3JEd1RQT3NoVk1aTGFzeVlJYmovb2dsUEw1?=
 =?utf-8?B?dTVHeXZpM2ptdWZSZzhHVkhpRmZRRzRaWnlLWkViTzI5dDl1Z0ZYQTNDMVNl?=
 =?utf-8?B?UHBkWk80cmVXc3hRMmphU3dwd1M5ODRjbTJDNTJPczdmKytRWmg3ckxlRXFl?=
 =?utf-8?B?YjhQMmZsTzk1dm9hQlh3Y0ZtK1lsam5BT3pNbE52MVFDeUZyQUc5QXl6c3Y5?=
 =?utf-8?B?RjFnNmNsdHl6ZGRtanBicktBeWN2MFRlbmlOSDcyM1JsWFVvYzZnK294THFy?=
 =?utf-8?B?NjFOQnBuZEg5TVJ1WCs3QUtwQkhXejdhcGtBc0t3NkZIVnJ1cXJjQ3pHRWti?=
 =?utf-8?B?aXZYbC9PRWszZFVtWk9rS2sxa0JVb24zdmlWazF5OG5lbTFmSVNvazlCdHR5?=
 =?utf-8?B?bG93d1NqZFdkc1E5YnJFeGN5Q0VzWU54NWdOUnovWkJXWlNxWkFPTE9ZL1pk?=
 =?utf-8?B?LzdyNkNTa2NpK0prT1h2bmdiRkRvMlFrdmYrL0t5Z3FCTTQxdmxLdzV5SnlY?=
 =?utf-8?B?RTNlM0p6dXZHcjZkNHRCTFhHMnBhblpKdUJFd2RuSjREb09ObjZFalZZRkFD?=
 =?utf-8?B?TDVKN0Q2VG1BejV4Q3dKb3JidHdMazh6a2cvTU9qbmdPakRGbTl4bGdVYVE2?=
 =?utf-8?B?YXF0cGROL2txQ0puOVBnRGxWQStXZFVpZ2tleTNEYngvTm00S0ZhQXFsdmxQ?=
 =?utf-8?B?QXhkbWhBVk1pbG96YnJuRWlqRTEyUDNnZUZQOE1sWHUxMVd5SjhhbHhZdjN2?=
 =?utf-8?B?aVpsMkRuRmFsSnhBRWtFWDFPbWEwOXp6bjVnbFJiSCtmZmZMZGxvZGp4WU9I?=
 =?utf-8?B?dmxMVVNiMzhWMHZFWGZyc2FKQU9rTG42L0l0V3NtTGxiaVVaMnlVMWE5bmhU?=
 =?utf-8?B?VHZ0ZkxMRVhRam9wQnF6TjNyQ3loZnJYck9qYmVCQW5ERzl5ZlRzdmx3L1gv?=
 =?utf-8?B?N0tFd1J0bm9qR0pHdmU1SHd0aG5zblJhOW8zcWxTOXo5MmFnVVZIQnYrRjMv?=
 =?utf-8?B?USszOGVBTXdKaStIUENyTUc1WWVuWmIxNGM5Lzc3Z2MvZ1VKNlNlYlA2SXRj?=
 =?utf-8?B?VUQxVUozQVFSYUV6R3d4SUROUnFlWVBsMjdwNjdkbTYvamhJWXFRZ2pqYkww?=
 =?utf-8?Q?KPYP+5oI6QG2q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjJIMVY1VlBXVFB5OFVqcVE0LzJSRTRZUWtOaiszdWk1V1dnOW1SYThKUzAw?=
 =?utf-8?B?NjBqeVhRc0lsSjNkWFJrMHZNMjZnWm52K0o3dHB4SmRNRzVCN0ZmUDhFSmh3?=
 =?utf-8?B?d1BCRnl1dHdnQ3NwSi96cVpxNUxLUUdMM080UDV6d3FUZjlDQ1ZCdjVoR21i?=
 =?utf-8?B?Sk5vTGRxYVpsdVZ0WGdBRjNhand6QmNpU0Q4M3dIdHZMU3djZm56cmsrcDBv?=
 =?utf-8?B?WVZYQlZ5RjlSSUJKVG0xUVhna3UyQ0FxQndmdkQ4eFNMOVhWYTMwZFVxZWxW?=
 =?utf-8?B?ejFEY0pxeWhaL1htZkRRSG5qK2lJNTMzTDA0OXlwWmlnb1dtdHlxSWJWK0tz?=
 =?utf-8?B?QkVXVGIvcDNPUlBtMlE0UXBlQ1haWlR3MXdwOUlnRXVBT1hrNUVMOFJpSTlF?=
 =?utf-8?B?YzE3dlpFOGZkVngxWXN6TlhxajFIOTRWSlVOa1UrajNDOUdSVHZqelE5OVZY?=
 =?utf-8?B?WC9FM1FZNEd5U1VjSEI0dElyUDlJdFZ3VlM5L2dQdUxFTFkxaUdHbGV5V2Za?=
 =?utf-8?B?L3JXWmNSYzFJbk1icGJMQ001SmZSajduQUdhTG9wOVV6blA3NFVGYll6bUtJ?=
 =?utf-8?B?WEsyMmVadjFXcitsR2IyVkZ1NlNVQ1hvZXA0NUM3eXVGbVg1VXNVWEVzYjNR?=
 =?utf-8?B?Q2JEYk90WTFhMmoyV0wzYXdsa3VOSWVZQ1NvY0ZEZEpUQXNCbmVXYm52NFA4?=
 =?utf-8?B?RlZ4TzJISzNNY1JKd0hmcGdEZGRucHJFMmZGMWJXZ3ZtSCtUMGVmeTUvRW91?=
 =?utf-8?B?a2RaTXhSZkRWem82b0UrSHFSeC9MN2I3MWlFSVR4ZDlMVVR5K1VmdVZRWkNo?=
 =?utf-8?B?TjAzZUNKdkNxbkxMc0ptcjFTbDgwbnVMQkZtZVpxbjhmSXpQNEpXZFZXS0tF?=
 =?utf-8?B?bXBodVZNanZwZkVML29PRWV1bFFuRlJOcElHZkh0VzVCSmk2QWdxVk5EZHZs?=
 =?utf-8?B?S1lQc1dmVnN1MlRhVjZNbnk1dHVjcFdGSDhieWR4RmlxUzJONjQweFNzbzFq?=
 =?utf-8?B?ejQyZGhRVGxkb3J5R1UyQTRPV093N3NpaFgwaUNNUnR3SzNGRThVM0lmMHJW?=
 =?utf-8?B?UGdUMmhnT2tkb28zOHRzaVVoSGdTaVJjR2JqNHRSWXVZYm16enpLSHRGZmVS?=
 =?utf-8?B?aXBtbTZDT0YxMFpFbk1JQ0tERkJjd3NEN2dLZmY5NExYNW9najJ6WWpvUjNQ?=
 =?utf-8?B?ZnNlT3daWSs3TDFGUERwUG5RWERYNDBabHMyWkhPM2hDdTR1YktoT1VSRUVB?=
 =?utf-8?B?dERsSWhDWXJVUnExT2hEREJsQm91SmNKQi9pSU14OHpoV2g5M0xFTm5MbExI?=
 =?utf-8?B?ZFBUalUvQjdqSi9rREd5QlMxa3VmclAycHV2ZWFuYlpvSHZoSXVUUWEvZFEy?=
 =?utf-8?B?dkhHUW9EckJhYm9pYThKSTJVM0JMWXQ1VldyWlNDTlAxMW11M2h1M3dkSk1O?=
 =?utf-8?B?S1EyTnRtV1lPdCtXYkVEOTEvemEzbHVGd3R4K2JvU3RWeXVvczFkZnNUaFBI?=
 =?utf-8?B?Tm1SMUo5d2dmbFM2aUtyZUl3eVh1Ukk3dGFMV1NZM0JtZXk5dUcyY0RsK1Mv?=
 =?utf-8?B?dXBPNjJieFZFZkVhdDlIQ3k4VGlpa0NybXJpVC9XUHQ5UE9UMWtsU0dUcnhC?=
 =?utf-8?B?Qk8wR2NnRm5ocmFsVFZGV2o3WjNUc3l5VjY4SU5pM2trczM3TGZCUlIvZG5R?=
 =?utf-8?B?SzM0NzNPdmVyRGtJVm9aaXN4cmsxVEN0U1dvbHRLWmdBaWVwd2k3T2psS0la?=
 =?utf-8?B?aHgvTERJSERNUlZGWks3eTRFRlIxL0Iwc3JVc3ZENkg5MnRuNXFVOHpaZHFO?=
 =?utf-8?B?QVZXWVBIK25KSWIrYzF3elZ3djVYUVJ1aWtWVzNWYk5FYXFQemZLT1laRU91?=
 =?utf-8?B?b0JTTWxNemN6dXBjaE90VklLYnY0dVV0bXczN0gzWm55YmcrRGg2blFFK0Fv?=
 =?utf-8?B?V2l1eEVQVkJqaUtUbDR6M0l1WW5WQkx4dzBtVFIxdWh5NGpFaEl0ZzQ4WFR0?=
 =?utf-8?B?ZE8wWEJlR2kxWi9pWnpJT2NqaUYxZFRSQ1FIcVlPVTRhOGtHeHFHY2NoaktS?=
 =?utf-8?B?d082NmRWaEZqdkFTVWdMcEkyMytsYW5oZTV4NUIrZklLcHZrMHkvcmR0RXFG?=
 =?utf-8?Q?E5lWKuOsOzW7UycUzy0a1bdkf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b41d43a9-baf9-440e-7f9e-08dd56649afb
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:53:45.7017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: exGOOPN9N26G4XJ56ojXvwEi28vT/I73jMTpQO3/KMxqQT70wgpbbANbf56JPFAyWAlgby+B6HCx5oAGeFiZyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085
Received-SPF: permerror client-ip=2a01:111:f403:2413::625;
 envelope-from=Vasant.Hegde@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Michael,


On 2/25/2025 2:17 PM, Michael Tokarev wrote:
> 07.02.2025 07:53, Sairaj Kodilkar wrote:
>> This series provides few bug fixes for emulated AMD IOMMU. The series is based
>> on top of qemu upstream master commit d922088eb4ba.
>>
>> Patch 1: The code was using wrong DTE field to determine interrupt passthrough.
>>           Hence replaced it with correct field according to [1].
>>
>> Patch 2: Current code sets the PCI capability BAR low and high to the
>>           lower and upper 16 bits of AMDVI_BASE_ADDR respectively, which is
>>           wrong. Instead use 32 bit mask to set the PCI capability BAR low and
>>           high.
>>           The guest IOMMU driver works with current qemu code because it uses
>>           base address from the IVRS table and not the one provided by
>>           PCI capability.
>>
>> Sairaj Kodilkar (2):
>>    amd_iommu: Use correct DTE field for interrupt passthrough
>>    amd_iommu: Use correct bitmask to set capability BAR
>>
>>   hw/i386/amd_iommu.c | 10 +++++-----
>>   hw/i386/amd_iommu.h |  2 +-
>>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> Is this qemu-stable material (current series: 7.2, 8.2, 9.2)?

Linux kernel doesn't use these changes. So its fine. But I believe we care for
other OS as well? if yes then better to backport.

> 
> 3684717b74 "amd_iommu: Use correct bitmask to set capability BAR" does
> not apply to 7.2, since v8.0.0-10-g6291a28645 "hw/i386/amd_iommu: Explicit
> use of AMDVI_BASE_ADDR in amdvi_init" in not in 7.2, but the change can be
> adjusted for 7.2 easily, or 6291a28645 can be picked up too.

How is this works? You will pick it up -OR- you want us to backport and send it
to stable mailing list?

-Vasant


