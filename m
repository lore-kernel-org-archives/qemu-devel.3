Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFC2AC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 09:59:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN8NZ-0005Gr-EE; Fri, 28 Jun 2024 05:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sN8NX-0005GJ-2H; Fri, 28 Jun 2024 05:58:51 -0400
Received: from mail-am7eur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260e::700]
 helo=EUR03-AM7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sN8NV-0001AA-9B; Fri, 28 Jun 2024 05:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nrs9VfOvYXRJiXXy4F3/DgHtzsvXhqwwuKPHhCBs8vJQDkzz7HMNic/rdGd8JP8AoPfUbhk1NPn2URdhoJSyYgPekIATM4A2u94KMuyDMqx+xMGtdkaVBK1W2G6qq5pMv2DCK43wZC34gqcCUvdNxSd4xKEhkqgVPv99js+Z374qhks3mMc3kZfeIMrNakyto/uarXjnv7riJ1GdT7Bhea951TpVG0eudkiqs6fVm4VWklbJmomzNqDX/a/DYq9xYdztO0GUahBQa9c5idtHkqZMAnISefI+FU/aLFF7f18TcvwOABVs2ju9IjTkVflssKowI9VipEgEU4tqy+Wf8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HuwGtvEQdbvYq7wIUfS06gUC4dGD2+y+AMFMqBNgdkI=;
 b=ZBpGW4FDLvT8q5NhPRlIBfnm5VHQIcA4vJ078O5d6lv1rLOa4CKs//LZN6pS/anNT7qkh+s0xw/s8Hj2eRlC/6MQQLfJGWtK0T5MRlzOQ0SUVCmpxyOuWCSbbcINbMa5noUZDvEA04Vvsj2aY33Bmy4NRpKoL6XQNk3FwBRN/1SefqF55bcBudY98Xb3eKrmpKTaID7Qgynh75tLPaUPD2nMBiLcSVx5hFqp5wDPz7INoRqgmpHNZakvgZsyi+BGVqHtjRoD1jrF5SVYD3wqI/anbgJogSCaGRFaD/j6Xr4Hc4U2UOm4xF+TxxcTyIA8jZUKhgqmKn1JW7B3psTojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HuwGtvEQdbvYq7wIUfS06gUC4dGD2+y+AMFMqBNgdkI=;
 b=ezICM7KcxUllmTjyH+m9BfWnsR9sd/3c3HYIyWxLeEeKfj3TzbR+OH6buoBQvN8KkuuAMuES1x7A6Yfx8DOLERU8be6fXA7gI2LU7k6Bhmwe79narKlxAi719eQICkmZcunkbagEeVGrTqdtJurx1T2xqOPpT9h+eAiRHei3EL4hNtoBQwbRh6MEK5WULtQEZk7pSLoukuWa6bI0K3TnUlvVQcwmE2dUGorzE187LLgxijIAF4vbPEDBE+Df+eaVKvfuTETLaeOFRH5QK7c9H6w9KpLs31qDReh9jx7qDYT2egxoecauUhTLKlGhe2n96kJvWxg+syo/NEPl2o+5Rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com (2603:10a6:10:530::22)
 by PA4PR08MB6126.eurprd08.prod.outlook.com (2603:10a6:102:ea::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Fri, 28 Jun
 2024 09:58:40 +0000
Received: from DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::1bc:d7fe:62d3:bc14]) by DBBPR08MB10721.eurprd08.prod.outlook.com
 ([fe80::1bc:d7fe:62d3:bc14%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 09:58:40 +0000
Message-ID: <0a6671e8-58ce-4f63-9e51-b9f33e6d0a2d@virtuozzo.com>
Date: Fri, 28 Jun 2024 11:58:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: Prevent NULL pointer dereference in
 nbd_blockdev_client_closed()
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, 
 eblake@redhat.com, vsementsov@yandex-team.ru, kwolf@redhat.com,
 hreitz@redhat.com
References: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240607150021.121536-1-alexander.ivanov@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0019.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::23) To DBBPR08MB10721.eurprd08.prod.outlook.com
 (2603:10a6:10:530::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10721:EE_|PA4PR08MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 318a0541-d546-40b2-5bcb-08dc9758e30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXRob212SHFtSys2M2U2ejlSMEZQaUpMeFUwdXA5OGc1eDNBQ3I0V3N1L0xB?=
 =?utf-8?B?V3FtOE9aY0x3VWlveVdRTm81RUY1R05aVUtUYmhKUTF0S3JBcTFYeEp0Z3h0?=
 =?utf-8?B?cDdzRTVuT2RwaVdiRmxUZUlRMmltV3BMTXdSSVlTMGtNS01tMTFuemVhaTVU?=
 =?utf-8?B?T1U4MWRBRE5NbnBId3YvbUVrOURnSWZhSGRaTEpNZndMbEpnSmJRcG02bUZx?=
 =?utf-8?B?TVZDRzBHU1NyaE5rQ2ZORkVNUjlFY1NmWmZlQ1dqUmZ6SlVXZTNneEJTSjE2?=
 =?utf-8?B?WExUVHUyWkdvYm9Wb1Bmczk5WFg1MTZyQmd3eVdpVUhVUzdhSUxBWTRwRzNP?=
 =?utf-8?B?NzNSVXIyRGxucWdmRVB4cklyVXMxYzVTZFdVdno0L29FR3ZjVnZSdnp1bVhk?=
 =?utf-8?B?b3FpWE5NTzRSNzByZ1JCekFWVVRVSUNzRDJUV1N1NmFVb3hrcmNnVGRiODNq?=
 =?utf-8?B?d2JZc2pRQjNKMFRHdVJCc2doajhLaExUM2lydkxPWWZMTExoZHNpKy9yZEov?=
 =?utf-8?B?eHRNK1p3R0t4UGJNZGo4NUZlNHpDaWtHUW1jYkNXa0RVeW5VWXVqUmo0QUVu?=
 =?utf-8?B?TVg2SGJpTGZXelhiVXM3SW1vSTJmMjQ0bGU0U3RQclpOekthaHBCR3puWTk4?=
 =?utf-8?B?cmFIMnlrNVNUVjVnSXNJcnAxRlcrNDdDTDYyaGRaNXg1MXhoSVErNHBUSWtx?=
 =?utf-8?B?OEpBQmliL0JwbHllUlpZcUJKd3MvWXV3SkRQSHV0ekh5N0NXb1QzZllQbDFM?=
 =?utf-8?B?OTcxS0lYRTlndFhacWJBRUpQNlZnVDl3T0RTNjA2anVEbGtBcFJJdVZhQXY1?=
 =?utf-8?B?aEp2MzZoSVJsa1o0Wlp6S0xJbWQyL3dPV2JnQmIrT3llcnJwVklFQzc4YXhD?=
 =?utf-8?B?VzZ3bi9PalZOYk8yb21MZnlOSS9pWFJjVTZCeFdEKzBnNUd5U2Naamx1Q3Zm?=
 =?utf-8?B?Mi9Hd1FXaTJ3OFlqamw1aVVDRU01V005SzA5R2VydHZ2Qmx2VElZZjRFajIv?=
 =?utf-8?B?TncxaVFNK2QwMDRXNVlVVkptVjlPeW5JMTBuWjVNbXpKRkk0WGQ5czRoSjZp?=
 =?utf-8?B?MmFVMVhjSDBVVk9aeC9rTHVUZG1TeUtwb0V2aGVWZGx2N2RoYklUbmdiTmxs?=
 =?utf-8?B?NUF1V042N2lhZ0tJMURSNjhVS05FWXFEN3JoRnp4K21QR2ZLSERlL2ptbHkz?=
 =?utf-8?B?TDd2cnFNbFhqRk1OYUU2eTFaMHNzdXdvSDI3VHVDRVBYY2kvZVpsd2NiVVRP?=
 =?utf-8?B?RU1mQ1Q1SS8zS3BSOXlmWEUyN1JaaUlaMWo3am4wY0I1WTB3SHZXWmpmcDht?=
 =?utf-8?B?V1pXeXpBTnBZb1lZZ1NBR1ZlY1hjdUFTRjVRU0pvNWp0WHNReVBDZkQyNDdu?=
 =?utf-8?B?Z3cyZ1NwVXpZOUFaeFZyTlZEU3VzMGUzMUdMR3JoMnFYRC9uMEJUaU5JK0hm?=
 =?utf-8?B?U1YvMTMvNGlmd1plRG9GRXVnZWd3N01tQWljS0NMUHhxc2srVnZka1VOWjFn?=
 =?utf-8?B?UDVCZTAxVEV4TG9UdlFaQ25BNmZJTWhweVphRTNYUmk2L0cwTzhFcHhROG1x?=
 =?utf-8?B?ZHJob2EybEJ0UDl5NEh2VHh5UFhqU0U5VmJtM21jZmo0Y0dXT3dIQzhxeHZI?=
 =?utf-8?B?b2lxLzNDN21zeG9tZDh0aFZuOHdvQitlZ2hCdVQ2dG9PbSsyQUl4WHZEWmRh?=
 =?utf-8?B?aXJjeDRKOEFXdG5yOVNHVGZLakNvSzBQdm1Nb2tVUTk2YTFpU05NYzBNbGs1?=
 =?utf-8?B?Q2VXOGFUZWlqc0VNeWlFSXZ3NnZoRkpKTGN1aUxMa0RBOEhRSXI2K2F5OVJ4?=
 =?utf-8?B?VE83Z2pWZVJFRHBlNEQ2Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10721.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3doODhTWjZUTlovYnhrazFXdkt0NDVmSEN4bU1jWkkyUmljLytXVTZlWkN1?=
 =?utf-8?B?Z1NveUVxU25nRlc1ZDJ2eFUxZTVKRk1YWjMvNXZQVHpTdVBzUmxGMDlSbTR5?=
 =?utf-8?B?YTNBeG5CRVBBbTlZQ3RCN09DUGplQjNWczU0MEIxY2FWbUZKMUE2QUVyYVBL?=
 =?utf-8?B?SWlRdVp5MEgwSXFIVU41MkpJTFNKSXNJUHhKWERBb2RsWHAwaXNrT3YxTnV6?=
 =?utf-8?B?SG1YZ2srR0lKb1ZabjdCcDdQSVFINll4WEZIS2QyeSt5Nm9FQWtMcm9Qc3ZH?=
 =?utf-8?B?TjAzeHhJRE55aVlJRFhNS25rMnpvMDQ1QnJzZzBaM1dUd3ZlanRobWV3L2xi?=
 =?utf-8?B?VVh4U0NUUzkreFVSZ2tWbTNnYnNMTTd2ZHR3ZWxsY21naUkrc0tGOTNWcFJu?=
 =?utf-8?B?YkJDZzlNaWcrRWFCRnQ4T1BwZGVLczZlT1hReHU2Nk1QenlWVHVsZTVxREEw?=
 =?utf-8?B?NWlmdUlNcXJBZDdJWFhhRHRQTEJQb3BvcDgxNXNoWE1IUDdBQlRRK29Ud0ZH?=
 =?utf-8?B?QTE0WDVQa3o5MEdFSXBvT1ducTVUb0hCdDM5ZzdHZDVhcEY0RkRVZ1BKcTZo?=
 =?utf-8?B?ZE5mRUpBOHBxNk9KZTl0dUVNcWlSeUU4bEtZRTJkbzc2SnN1M05lU2Y3S0lB?=
 =?utf-8?B?NGJEbXJFYktremhJZldJeDd1cm40UHRHRTNVRUhsa3BmY0pEcmFzaDdyVnlQ?=
 =?utf-8?B?cTdwaXQwRzh5dDJ5Q3RZMEVmbllnZlRRa0hZQ1VEUkpIT1Y0Z1BkUzJLb1VM?=
 =?utf-8?B?V0EvZDk4RUYvZ3l2ZitQeTR6bTJsNFhPRDd1SFlxSlpkenpERWZHelN5dGNw?=
 =?utf-8?B?RGZNYXBmcFJWeU5WZW1CcldXTURhRjFwVDh0Q0E3WUhpVmRPNmNTaDN6VTlB?=
 =?utf-8?B?dU5ld2VjV2NETVhqdG5QN0t4NHVtUXVKb3phL1FxYVFTaVlKanhZeWRvMnRu?=
 =?utf-8?B?K0c4V21ZOHZ2NlpkdWlkOEtxYitVZFdjN1FTNHNTbXpRd21FeGxMMmVnQjNR?=
 =?utf-8?B?YmQzMnkrcXpwZXFKTHZCTGRIdHFpR05XQVNadW5zZWFMalhwY1hnMlRDZ1Jv?=
 =?utf-8?B?bjQ5OCtrUjg0aHh0MXhvNUZqK1FDd3UvdTN4c3Q4OTVqejVkcFJUTWxDU0Jm?=
 =?utf-8?B?c2pmc1dGTlFRdzR1ZlB3NnVpTTBrdXFrcmtPVGExRFE2N0FtVFNNR3hmTXc3?=
 =?utf-8?B?VXFGbFRheHhieHFZMSt5WXkrSmFxMjFUUytlZjN2RGxpYndTdG83T3gzL3pL?=
 =?utf-8?B?V0lTT0ptVUZpaHIvRkQ2ZGZlUUxVWW9NUVk5L2Y1TnF6Qk4vTzVXV2dleXcr?=
 =?utf-8?B?YUVCTE1ScldmN2RUYmxobFhvWkhQSFMvQjUxRStGSEt5TlN5OTV5NUZueXlL?=
 =?utf-8?B?YUZWc1pzZ1BZYTgxTlBqOFI1NVZuVHo5TFo0T3ZDaEwzTi9kWUVrUkR4bDNP?=
 =?utf-8?B?ZmxPZjhPTDhPMTJXYmxDWmFDdVJ1ZG5qbXkzQWxOK2xvaXlhSHVPK003RERS?=
 =?utf-8?B?aG93TGZnTHVyWUw0QndoV2hVRHZqeFFaVlgwdGJXbldwN2NwZ1MvRi94bHkr?=
 =?utf-8?B?MHdDNkcwRTBUclhCLzFvMDVyVUExNUxOWTgzOE1xbjdIczMwcFhQVC8yWkpl?=
 =?utf-8?B?QWpGNmxDUnVwck9reDdTZ2VaVGtBWkJhSm5IeS9CeVo2cWFkN00zNm1Cb0FW?=
 =?utf-8?B?cTI2WGhUT2FrR2ZWRXIvVGNBSVRQUXMzUVlFS2kyZ2FCVHpzMC9FT1FyRCtG?=
 =?utf-8?B?SmVLaVBUaWpObDNVdlpwVHY0TW5vNElXaXZEa2c5V1RaRThBeloyVThnSHdF?=
 =?utf-8?B?TU9tUmUrNDA5bFNZV1FJQ1VqY3lzdHMvd2FSQk5kck4zNXlIdm5PbUs1Zi8z?=
 =?utf-8?B?WkZyeGw1R0g5M1NkR1RoOVJITXRwN2dMN1FXb2xsTXgzMXppYlcrenZ6b2dS?=
 =?utf-8?B?eXBPbzV0RVVSRGgxN2tYTnI2YkNPRVlSaTlGN0JyWHRiYjBCVTdScGZFQ2x0?=
 =?utf-8?B?R0FjTFFEWDZCL1FsbjVtY3cvMWY4QUtxbGd3STRZbTVGbUVBaDFjV3hoMnFZ?=
 =?utf-8?B?ek8vUDlrYjNIQ3VMT3ZWNjNnUUs1enJabEF6QjYzSXZSSTNRdUhIM1VrQ1Uy?=
 =?utf-8?B?eGxQbndzYmlNL2k5cmdxNERjaitQbGFlOVFTcnRWT2o3RVY3bWlWQlVvWWty?=
 =?utf-8?Q?IuthxRWnZOUdfXZRkFzj+1Q=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 318a0541-d546-40b2-5bcb-08dc9758e30d
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10721.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 09:58:40.4220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2AnYg4fa0etpueu5V+vArvICHW0kTrUfZWWSViVnKr20KL6e97RY6kZI1kkIJn3uPUJ5RN2RzqyllXRwJ5YFBSVDo+DhS0YqhqhKCGdaIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6126
Received-SPF: pass client-ip=2a01:111:f403:260e::700;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR03-AM7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Ping?

On 6/7/24 17:00, Alexander Ivanov wrote:
>   static void nbd_blockdev_client_closed(NBDClient *client, bool ignored)
>   {
>       nbd_client_put(client);
> +    if (nbd_server == NULL) {
> +        return;
> +    }
>       assert(nbd_server->connections > 0);
>       nbd_server->connections--;
>       nbd_update_server_watch(nbd_server);

-- 
Best regards,
Alexander Ivanov


