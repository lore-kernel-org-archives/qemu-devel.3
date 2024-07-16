Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3438C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTj9w-0001oP-BD; Tue, 16 Jul 2024 10:28:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTj9o-0001gW-1b; Tue, 16 Jul 2024 10:27:57 -0400
Received: from mail-am6eur05on2072a.outbound.protection.outlook.com
 ([2a01:111:f403:2612::72a]
 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1sTj9l-0008Mv-NP; Tue, 16 Jul 2024 10:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlILWOzLTPw+BKRTi4wERzvWOicZ+5I4jua5AUr5696n7kSxuYtykjsQbr1BrBgN28Fk64eNIdIy9PoJ58zTGp3Bx/V3H9hcfSVtq12s8IxwihLQwLY3VyhpD7m6jbSq9xYaWJJ6U40MMKfOYZtHUhJKuItwKvCswcXlU5lnki/11LoRfIbvpp7FzFHYSl/3/TChVLcUnPTX0+C/kBwsX2BElSU3lCJUQXhuUvL3simoN1LF/SZJ4aVgr1h7UjuGs2MhsiOeCgK7Va+Bygwjb4t8fujNWN2NswH7KBB6PMq6Z+FEIuVvm91CtMIlVZSCJN5Zai6CEFqEKavnavpE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/bO529ignCUh6on/j9UyHbUve3Mp1WA7C8BBMHSsB8=;
 b=hWS8H8QfsfKIylJhmZkCcpOaWdFct1vLiiDlbR06lxPpAcE930deJzoxXQzOH3MkrSWkKwb5b42EutjY4dwGh0lIEU6klr2cR+vJNyhOPxOFzCWXCTgclD7VqPPoMCM8yT3SV133aFOIU7163q47MHh2ouFl4ismQrjNN0vBvcjcJASBkj+F1Bhv8BWlVdsq3hIte/JclkJisoqRGFfQscZsE8YQyOoyRTuAN3NEZdIxGHqSqxAonCbao+ZkDhWiLc5M28jw4uHvZPwk3DD+zDVQqyBIOg1KLq1MRNC0bGZO5dFhSRVY05bDUG5cEOzt7bShF77jGrOzPheTziiJdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/bO529ignCUh6on/j9UyHbUve3Mp1WA7C8BBMHSsB8=;
 b=NKpK5bcqINgCnah6EudMmZQ2mEWg1vTJqsTaExGQx41UNj3s5uAWrhrWG4wbuZL1V220dMv8+HrY0e26z36nzC4qrgDigbhx8Es16OWMa/hP/HooGMW0gO1Tqny+67SoWCAj/21O2eYwYg9nfLXRJN8XlKO89t+T8ZRU+Exv9cLH5MZJbe8HyPKtB5KNbBkH9K9gTeA1l/NN2sBfB4Vu75R+NoMPL2Ggy4sOVaKtGx+0E/3/cYiy03nksXZ0pS9WHhjyvkezehLIk1PM7a1xleNwjZGrggbAjcT3FvCnDdb/PQ3glkhJwFzxIR/35/Ve/3h7hWnKFqjmdDC8OEwxeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by PAXPR08MB6671.eurprd08.prod.outlook.com
 (2603:10a6:102:13b::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:27:46 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 14:27:46 +0000
Message-ID: <58192891-7520-443a-bbaf-6a6b9b905bea@virtuozzo.com>
Date: Tue, 16 Jul 2024 17:27:48 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: zero data data corruption using
 prealloc-filter
To: "Denis V. Lunev" <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, eesposit@redhat.com
References: <20240712094617.565237-1-andrey.drobyshev@virtuozzo.com>
 <20240712094617.565237-2-andrey.drobyshev@virtuozzo.com>
 <ee1cf8a6-a381-4e30-9f5b-e6fd0a049863@yandex-team.ru>
 <a5104e75-dd44-4524-916d-1196fd585647@virtuozzo.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <a5104e75-dd44-4524-916d-1196fd585647@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR5P281CA0030.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::6) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|PAXPR08MB6671:EE_
X-MS-Office365-Filtering-Correlation-Id: 80c55cdb-7eff-4ec1-a7b4-08dca5a3763f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YlBGOVlPMjFvVW4vYUhYKzZmNGhzUDd0UXAyOUJ2aFE2N0xQU3hGSGZFdXdU?=
 =?utf-8?B?VytOMjJrWndUeUZKcTMvK3hudy9VVmRzcUgyejcxc1UvVWlCclBzbmJqa2pF?=
 =?utf-8?B?OWY5UlZwRWxwUXI4YURmMENMbjhXN2FOTDgwVDNjSExnRGtCcm0vR1E5a2I1?=
 =?utf-8?B?QmdYak8yeVQ2UWFadHJYd3N1TWloWWhTNjVlZDdkeXYyeFJTRHVIY3E3R0JM?=
 =?utf-8?B?cXpWQk9yajUyOGpNVk5LVStsYm90ZGhRbTVIc1owcExtSFFHOXJwRWZEMEc1?=
 =?utf-8?B?eHpxSlptUkwwSkk2aXJLZFZtK1IxTVJkK0s5ZVNQRUNod3YydVovZkoxdmlq?=
 =?utf-8?B?aGM4Y2hBSjVZdXB1WGt1SnFDOXYrSWNtYms0bFBPUTBwWlVZYUFkcDJhTi9o?=
 =?utf-8?B?ODQwRjJQNVJHVEhReHJCTlNKc2ExQWxjelVLWWgrTXRZQmtjK1pIbDZxV0RQ?=
 =?utf-8?B?Vkh3cEtNWHB5dE44eGNzQUt0d1h1L0kyUzVISVNrNDFBZ0lwTjFFSWFPL1Jv?=
 =?utf-8?B?cUtDMktoMmRTejM2OGlqQkZqWFcrKys1MHNnZEZKdGM5b3RmNWFBdWtoN3hG?=
 =?utf-8?B?VGNnZlQyMjdqWEdGRCs2bld3U1hGdUxMN0Q5Qm42R0R3RFpINk1VaWtCWkIw?=
 =?utf-8?B?dmZTVWg2a3ZpNTF3U3VhQkViaGNVTnBVaFhWU001eFJ4QTRZOHRla2xsUXFy?=
 =?utf-8?B?Nk5YUU9tWU9QdHU2SXRKcHhHdXdwaFdwcjJlL1pJZytkS0p0N0MwVko1NVZI?=
 =?utf-8?B?alBsTHhYT2pjNk0zQk1ZNWtIWEd4dWlCU0FhZ3g2aVFnMHA4K0VtWmJLOENB?=
 =?utf-8?B?Si9TYTVwV1l2MXUwcEk0eFlYRTdlMExBN0ptK3NZODlURzUxZi9PeFViWll1?=
 =?utf-8?B?UTZ0aTNzUVQ1NUFHazY3TWx4RjR3elhtOXQrT0RIYjdIVUdYSFRKb0dDRmY0?=
 =?utf-8?B?R2JKM2M5M3VDK0x0R1ZBVTBIZWlWSjZEOTBLV0w4TXFHM2xNd1h6UW9vYXAv?=
 =?utf-8?B?ZkFkR0p6cUZtcmhZWFg1STlXcE5PaFNubHZPOUhZV0N2cmdjanZUYkpGT09O?=
 =?utf-8?B?dktMSjEzTXphY1BMckFjaEVkYnJVQ0N0dUtTTlFYcmVQNS9BRXRBM1pGU3Jr?=
 =?utf-8?B?SDdSdzJvTE50OGNONitkMm12Y1luVjA3TW51cWVGL1Npa0VtTVczdTBiS0VE?=
 =?utf-8?B?bkNadlhiMVA4RlBRY1dad3BMUTNFdUNYNHNkQXlwZTRaMWRkaENVcWxqNXBt?=
 =?utf-8?B?VmNwRmFyVC9GRTFVSmllVnRqbFRucjBSZGtIa2JMb1FERHlDbkhYblBwRkda?=
 =?utf-8?B?UEM1cTdhbHlQZ290T3hWZVRMQzBEcUMvalpDaDN5OWx0cWF2U2Y1M2dzZE9L?=
 =?utf-8?B?cEFUTWw1Y1BXdTJ6djZhT2hNbkxlUmgvRlREZFM5Z1JmbEM3Y2VmTEhXTGJG?=
 =?utf-8?B?SHNpdDdJYnNiMFlTY3E1ZSthZUpBUys2dHRGZSt5Qy9KOThnZDd6OWN3OXl4?=
 =?utf-8?B?cFdvbjl6V1lNMnpZOUloTnNNSCtHQ0l6cm8vaU1oY3Y3UC9lMk16TGR3RDVp?=
 =?utf-8?B?ajRHRWdEMndaOG11R0doUTRWQ0lBa1k3UE5McERMYVFUTnZIdjlBNGdjNXZv?=
 =?utf-8?B?ZTVXRTZtWXlWcWdvM0hLZG1rTzd4bXZreVk4eElrUW41ZTcyRlFpUUNQS3pZ?=
 =?utf-8?B?VEI1WmgwbXRsS3g4K1hiZnh2REoxNWhkSjA5a0g2QTdYSHdSVEgrSU9wZ3k0?=
 =?utf-8?B?QkpMZUZNZjl5ZHJSZHRyWDl2NGJpWFIzNnV3c3FFd2hETTQvVkJIN1ErRnRZ?=
 =?utf-8?B?SjFiMVU0eWQ3YXp3T09NZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TEFjampPcFJ2Y0ZmREN3LzVtaEY0NjZwV0U3N0g5ckcvN3VyY2ppSFpKVDF2?=
 =?utf-8?B?RWRYVmhVbzFlcENlM0tseHVYbmJVeWZSQmJDZVVVYnJRZHdrS0ZzWW9OZzVR?=
 =?utf-8?B?dWhLTzg4cURxMG1Lc0tIaXM4MnVJU3RrTEtvN1Rwd0NJZFdSS21kWWpBMkxI?=
 =?utf-8?B?VlhBckJveW52UmlvQ2VKZVVBaDdTV3NjME9sNEk0cjdMenl4TDJ1Q21PUVNh?=
 =?utf-8?B?bHRSNWJrQ2MrdWNaZDRDOWpnOHQzNzZvcDhvY005ZlNEdmZ0d2Rmbk43NkpM?=
 =?utf-8?B?VU9XZGRseXFhQXBCL0VaOEhOa0JBV3R5NUtKSUowQVNpT3pTc1BSWCtwLzdj?=
 =?utf-8?B?UVpXdkVTOXlRSU1lSmQwVGVTZWhyeDVGeUxqOFByVHRCZWlXNVdjZVUycVV0?=
 =?utf-8?B?T0pORmlxUG9iU040TEJIZmphYzh3NWR0MUtHVXppTVlWZzB2azdrdEF2dkNN?=
 =?utf-8?B?aU1oZ2ZPbTNWOG9GYXY5cCtNcTZzQXd5MlBqcjhvWlovLzdZZlVubEZQMkhM?=
 =?utf-8?B?L1J5OE9vcy9jY3RnQnplMHJodzB0aFR1U3NPeUN4UTBHZTI2QmdrWUROQjZr?=
 =?utf-8?B?QlJNS1VXZ0R4SlpKZE1DMXVYMnNOYW5OZStteEVFYmt6REFVUDNuYnZwREo0?=
 =?utf-8?B?VndxK2NxMmZ5MFN1c2lER1FPNVZ4WEU4ZHBtdVRHV3NSZ0hwMVNwUjlMSkNh?=
 =?utf-8?B?d2NXYVd1VlQ4M0IvRjVteVVzUmFtWnJlaTJTMXdrT0JPcmg2aU1xS3pzWExF?=
 =?utf-8?B?T3VlSTlMRnh4UHdManRoYll6NC9JbHVZWGlWc3lJV29MVG96RFhIMmI1YS9H?=
 =?utf-8?B?bWZQZGpndEpUQ1BNbTV3SGZ3UEtTMTNhb3VZaVQyOGl2N1NXYTVCQ2JuTHpm?=
 =?utf-8?B?bEZieE1jbGRBaVF0bmFkdUoxMk8vQlBSZzZNanY4WUEwY2VKanhVMTF6NC9H?=
 =?utf-8?B?MlNzRmRtNk51c294V2VPN255WnloZWlKYWtsQTEzdXEveGJGOWZkMTRZb1dN?=
 =?utf-8?B?aE1lcCtOVERUR0J1U3hCTWgwTlhmQThpZzUyc2xtTnJQczU4YjdBOXVjQndB?=
 =?utf-8?B?Qitpc1MzZmtXRmR1OEtaM2lMWUQ1Y3dNYjJCdGJRMHJKdmp0TnpaVCs2cm0v?=
 =?utf-8?B?ZXdBeFpNdldWVld5OFJHNmdBWnFIZGZ6WE1PMWVGVStBN05oWmVWbXkwOVpV?=
 =?utf-8?B?QWliNU5pTCtkZDZxNFZ3ZUFEYVdBYXd5Rm1aOVVlckNXNkxCZHVBcVZMdDJl?=
 =?utf-8?B?UFkzU21ScjlXUnE1YnkxT1kvbUlwRjh5TTRWWTA0Q3dGNzhQTCtQaCsxaWdn?=
 =?utf-8?B?VjFpVjNKZ21RRS80R0hMVlZWSmNzSmQ5OUFmWjBZeHB4OW9oV1FGM2FrNXZL?=
 =?utf-8?B?ZTFBVWtnV1crbnNQemt1bXdaR1hRSnFnRnU4ZXovY21jNGpHWXFENTR4WHhC?=
 =?utf-8?B?NzJ2cyt2d055bTdJQ2w1YUpUSlBFTFh1SFVSclJuQ0hONUg5dDhlT3B3Q2FS?=
 =?utf-8?B?Ri9zN3lRbFhtRnNnT3VuM3hrUkhIaWtmcnBKeS9HRXlQQ0ZyTktNZTVoWVBE?=
 =?utf-8?B?ZHNWTG4yUnE5ZEtUTnZUWDgrYkpGL21XQTV1WWs5Y21zUFgwVHlORi9EdC9W?=
 =?utf-8?B?RjJyZFBwMzdkWUZsSmpRbnpPa0IzWkdHL2ZoOEw2ZUZXWmk3cHlSczlwWjR3?=
 =?utf-8?B?ZFFKYXpmRkNpdXRZdDZXdGVhMWJmM2RDYkFJc1M4SWlJbGtoYTd3VU9sV3pI?=
 =?utf-8?B?UXJCVXNHOU1qTEZRb090TXRUUkdnNU5nOGZ5bFY2Y3YrU0NZVWJka0gzeS9m?=
 =?utf-8?B?aFc5dkEyUE9rNGtMNUVZM1lPTC8wbWF4VUtZaDhNRGJvenZ6RGhSNG9pWTN2?=
 =?utf-8?B?T0tjNWVZL0FZbFNoZ3FPdTh0djVrekVKS1kwb2FUNEtVNGRXU2NXWUtpa3I5?=
 =?utf-8?B?OE8wVFBNSWYrSEVzZWtKSmxnVThIdFBob0Rveng3WHNkUjJaQTRnSlhsRkw1?=
 =?utf-8?B?UDZpUFRlcXp5UlVOS05xRFRuR05NRG96MmRkdWtkelRpa3ljeXdvNzZnWWV2?=
 =?utf-8?B?OFIxUC9vZW5hc3FnZDM2aVU5NnZyUDFSME50U2htandvbVN1TGJ1OHlFU0Fx?=
 =?utf-8?B?UmVUOHRLT1luVGlkdWFUN3d4czZSTWptelRub0NtQzZtVm0xRWdtVlZCenJp?=
 =?utf-8?B?aWc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80c55cdb-7eff-4ec1-a7b4-08dca5a3763f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:27:46.3017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/Yhdhq8HkRouEcGocoam2Q7o60ElmPaVRzix50tlZYJ6x9S7yDwcABP6ekgxxWAINCpBudr/IfmGjn7gtZNz2/TIoHjwEUbGVbHOSmIZiE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6671
Received-SPF: pass client-ip=2a01:111:f403:2612::72a;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/16/24 4:32 PM, Denis V. Lunev wrote:
> On 7/12/24 13:55, Vladimir Sementsov-Ogievskiy wrote:
>> On 12.07.24 12:46, Andrey Drobyshev wrote:
>>> From: "Denis V. Lunev" <den@openvz.org>
>>>
>>> We have observed that some clusters in the QCOW2 files are zeroed
>>> while preallocation filter is used.
>>>
>>> We are able to trace down the following sequence when prealloc-filter
>>> is used:
>>>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>>>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>>>      co=0x55e7cbed7680 handle_write()
>>>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>>>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>>>      co=0x7f9edb7fe500 do_fallocate()
>>>
>>> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
>>> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
>>> time to handle next coroutine, which
>>>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>>>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>>>      co=0x55e7cbee91b0 handle_write()
>>>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>>>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>>>      co=0x7f9edb7deb00 do_fallocate()
>>>
>>> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
>>> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
>>> the same area. This means that if (once fallocate is started inside
>>> 0x7f9edb7deb00) original fallocate could end and the real write will
>>> be executed. In that case write() request is handled at the same time
>>> as fallocate().
>>>
>>> The patch moves s->file_lock assignment before fallocate and that is
>>
>> text need to be updated
>>
>>> crucial. The idea is that all subsequent requests into the area
>>> being preallocation will be issued as just writes without fallocate
>>> to this area and they will not proceed thanks to overlapping
>>> requests mechanics. If preallocation will fail, we will just switch
>>> to the normal expand-by-write behavior and that is not a problem
>>> except performance.
>>>
>>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>>> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>>> ---
>>>   block/preallocate.c | 8 +++++++-
>>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/block/preallocate.c b/block/preallocate.c
>>> index d215bc5d6d..ecf0aa4baa 100644
>>> --- a/block/preallocate.c
>>> +++ b/block/preallocate.c
>>> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t
>>> offset, int64_t bytes,
>>>         want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>>>   +    /*
>>> +     * Assign file_end before making actual preallocation. This will
>>> ensure
>>> +     * that next request performed while preallocation is in
>>> progress will
>>> +     * be passed without preallocation.
>>> +     */
>>> +    s->file_end = prealloc_end;
>>> +
>>>       ret = bdrv_co_pwrite_zeroes(
>>>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>>>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING |
>>> BDRV_REQ_NO_WAIT);
>>> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t
>>> offset, int64_t bytes,
>>>           return false;
>>>       }
>>>   -    s->file_end = prealloc_end;
>>>       return want_merge_zero;
>>>   }
>>
>>
>> Hmm. But this way we set both s->file_end and s->zero_start prior to
>> actual write_zero operation. This means that next write-zero operation
>> may go fast-path (see preallocate_co_pwrite_zeroes()) and return
>> success, even before actual finish of preallocation write_zeroes
>> operation (which may also fail). Seems we need to update logic around
>> s->zero_start too.
>>
> Yes. This is not a problem at all. We go fast path and this new
> fast-pathed write request will stuck on overlapped request check.
> This if fine on success path.
> 
> But error path is a trickier question.
> 
> iris ~/src/qemu $ cat 1.c
> #include <stdio.h>
> #include <unistd.h>
> #include <string.h>
> #include <fcntl.h>
> 
> int main()
> {
>     int fd = open("file", O_RDWR | O_CREAT);
>     char buf[4096];
> 
>     memset(buf, 'a', sizeof(buf));
>     pwrite(fd, buf, sizeof(buf), 4096);
> 
>     return 0;
> }
> iris ~/src/qemu $
> 
> This works just fine, thus error path would be also fine.
> 
> Den

This would also be relatively easy to check by modifying our original
test case in 298 so that half of aio_write requests write actual data,
and other half cause write_zeroes operations.  It doesn't seem to fail
with this v2 patch.

I'll modify the testcase accordingly in v3.

