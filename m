Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF1CC3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 13:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTiJ2-0004w1-4v; Tue, 16 Jul 2024 09:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sTiId-0004k1-QS; Tue, 16 Jul 2024 09:32:59 -0400
Received: from mail-am0eur02on20722.outbound.protection.outlook.com
 ([2a01:111:f403:2606::722]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sTiIa-0004ay-2y; Tue, 16 Jul 2024 09:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/AfDs5VvXaJ0dwNdrPJZdAMuO6Zj/hK2RHO/UhiOHrYO8ArcOZnaSgDjq+82qygRtDja/2dOb3oA4d1K5dKZdOpS0RbEQVifWbYKAH2gQqdS7hnBA4h0l5w0J3HnduVDSfbkw46hOM5I7XiMVS1GEaQfpcuBuNHd1C5UT6pVQ5G7/UfIhhkG6i+GjofVlJxfxVI0/FY4HGBBHfjyIpv/BiR8G8RcXgq7AUqTgdsYuA9OZrNjTyNGzuZfiOxSYLz2rmfnyhO9smuyORFLXZjmSe0E9TWXeCMlbPkYaNZvWbf3r+bExlHbVVpZNJBZHHPo1trjRuiBbFL00bpsFmHEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/8ImVU1a9cFltY/keBG35WoGCjY7RuXfB8+LeWnl9k=;
 b=kT1Tt2s3qdPb2ZuU1wE2lrmD6T7aj23T7iXrQ4zJjYWeDezks57lbcaD39TI4GfcYFAMut4n+0bVQUnEXlQ2hsMigFL+W0kiBMGh1pCx72RaGrseSKsop9GwUT5jT6WawWCuhg0qsVvRJf7jytaNh8Aoq0MwxXHQUhUR14NE6aGt6AF1lnJ5RNSGV7EBfQOAc24N+k2xEsEmBtuEPq6MBcPdLPMA1ANjQOB6E2vJdc/C6NPFb5MIBDllTF+CCDjY6YAwF3hh/yWF8gVbKJAr+34b6XPsfU3JSgCcvdlwK8CaQoYVyEuaGekiOFOzQI3YDB7aZIPl1JacsaxC8dbuQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/8ImVU1a9cFltY/keBG35WoGCjY7RuXfB8+LeWnl9k=;
 b=QHaAJytJtC1XR7/vkewXIK2v9YAKLmof8WIDd4frbL4I8QoJCuaZ4FNts9ONnUyY0nDVJkeRg69J3V3Y36ySnBw7jd0acehul/3eNc8Hvmo30YMy5pLujnuG/p8n+La+kTPTDmfM2MqUnSObRDcwacEZZqgigpKasIDg9q5+FVgmwkOcSi6If2rQ25HDYUxAxGuNPtvgmgwDQ2NVG7/NbAUnu21+22YU81d6/04+EzLDPwTTsfwleX5zAZVbpJNvzdg0ZN0ChZAzrTtK6gL8ZzHTFamjyfaiVzk1phnAed5Lx+muW/emrMN/A31ipTVgkjWj3wj82qRfOrefTFChbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by AS2PR08MB9392.eurprd08.prod.outlook.com (2603:10a6:20b:594::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 13:32:47 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%4]) with mapi id 15.20.7762.020; Tue, 16 Jul 2024
 13:32:47 +0000
Message-ID: <a5104e75-dd44-4524-916d-1196fd585647@virtuozzo.com>
Date: Tue, 16 Jul 2024 15:32:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] block: zero data data corruption using
 prealloc-filter
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 pbonzini@redhat.com, eesposit@redhat.com
References: <20240712094617.565237-1-andrey.drobyshev@virtuozzo.com>
 <20240712094617.565237-2-andrey.drobyshev@virtuozzo.com>
 <ee1cf8a6-a381-4e30-9f5b-e6fd0a049863@yandex-team.ru>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <ee1cf8a6-a381-4e30-9f5b-e6fd0a049863@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1P191CA0004.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::10) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|AS2PR08MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: db3fdb8b-0b94-463f-40ba-08dca59bc7ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R04vMnpCU2VOR3VmcEdzSmVVN2U0Zi8zelRTTXlKTU9ndE1Pb3NXNWF0S294?=
 =?utf-8?B?M1dabnBScDhKQ3dRb01rUVNmM3BxWUpMdHRyUHFpOTZiVnFnUjhWb1dZcUhN?=
 =?utf-8?B?RmNQVkVmbHFIOXN4bFltZ0h4cWE5Q3BxeklYVGpvQm1hbEZXbUZOR0VIKy9F?=
 =?utf-8?B?dEVac2VSTzVPNFZpV0thRjlRUkoyT2ZOd0tMQlVmN0d5QVNOOTZEY1JMUWhN?=
 =?utf-8?B?cUNpeDBrQmFOUWFjNHkrK2s0elY2bUkwdWhEZCswQ1dhVkxzR2lURFR2SjBG?=
 =?utf-8?B?dmFqUThqUysvTzJ3b0o0OUVNUWRTQUYzY0JHeFdrd1ZTemx2eTJuMi9vQ2hS?=
 =?utf-8?B?Q0pJS1NtTmsxMkhHZ3NDazNpeWFTU3IvalRYb3FubExrdXhBQkZHME1BQ0lq?=
 =?utf-8?B?S2piWlRSOUNCSFFpSm9zd0R2eTBBQUtKamZVYm9QY2w5ejhPZWZmbDFGaGZX?=
 =?utf-8?B?RFpyWGd2MTVWcVltVE9yL1FMakJ3ai9leFJKaTk4N1kybDFIOGxwYkhNeHVz?=
 =?utf-8?B?YVQ3NmhiS2loN2lyL3Y2TGtnbDFRcHcyWWVBZDkrQ29meGdNdlRlNTJFMkh5?=
 =?utf-8?B?dE1uZTRlOW16OGp3cDdXeVk2bUlEL28yd0NYZVVVY1ZKaFV3c3k3eExGQkI2?=
 =?utf-8?B?NWFySlJGdXR4ZXhrcGhjU3J6Wno1UTA4Y1dGcndSVDNaUFNHdjh3SGJuKzZL?=
 =?utf-8?B?R3Q5Z1ZSa3lzbzNNblFPcEZUbTRVZUtGVmp3RkhEOUNiNkErYVhGQTNpNk5i?=
 =?utf-8?B?UExLM3lJMTl1NnVEemJnbjdIeGFkb3VnRXR0clMvZU1kU1RDbzYxS2NDaTU1?=
 =?utf-8?B?Y0p1cUdhbWxuN2UxZFBlSEIrS2F2ejZYUzFLbFRjOTg2Sy94QXdhYld6UDJB?=
 =?utf-8?B?dWZFekRGdER1QTNRMm0yUkZ4RWE2dGtISWFjemx1RUZsT3hDU3BtZm9tMjRj?=
 =?utf-8?B?V0RtMDJpeTJlZjlPWmlBLzlPQ0JNTkFrSXorWXcwT2NDSllIRWtHelVJSlkv?=
 =?utf-8?B?VkxRVTd1b095MzRTNEhrUlkzWGZsOHV6MC95dzdycWtpTHVxUWEyZXdNWFhq?=
 =?utf-8?B?ZHQyandQcWNwMW9FYUF4QWtiRWd2SmtISFg5M010TlRKd25rUVFtV2JDSFl3?=
 =?utf-8?B?TDJ3UGp1b1FsRUNuSGZzdG41Vy9acXFZdTdXMHlBdUV4SE9Rc3I5bjhvc3Qw?=
 =?utf-8?B?RFNwNWxnaHFEZHAvbUtDUzZmMEk5anZkVUQvTmx0ZGJ1bVpZN0lpZjFqTTYz?=
 =?utf-8?B?ckhKR0VRYm10Q2VnL1V4TmcxclNiNXhxZDhHM0ticFh1MWd1ZUtsNk5rRmVz?=
 =?utf-8?B?NFVhVEJhWkM3VlIwRWdUbWtwc1UzY01kSSs0eU5mRzd6eFlUc1RUa21jb1Rl?=
 =?utf-8?B?ampZNkdjUmR1dlovQlFnRjIrYXI3ZnY2SE5nTXFwZFlRdVpjMm9tcHU0VlFC?=
 =?utf-8?B?SWF3d3F3b1U2RzVkelVhdlNLSlJSa21oVXNkYXc4WjFtbCsrSW9IUkhXMWR2?=
 =?utf-8?B?RzNlRVBLK0RoZTNOMVNTckJLaFFTSWF0QWRGUUNyODdjRlBoUTFoRDd6Wk5m?=
 =?utf-8?B?SUpwdUkrRk9SK213LzU2Z2d3ZFNNeHhaL3hueTQ0WDcvL1ZNZjZqR25zUThB?=
 =?utf-8?B?VjhLenJlT3JLV2tiL0lRbEV6SHF5MWxLbDR6bGVJOXRLZDBsYnJocGJJbjQy?=
 =?utf-8?B?TVl1bXY4NUw3WDZHQ1VuQU9VT1FzOHdwakFIdGVQc2Q0UmtOZHZyV0Fpbkt6?=
 =?utf-8?B?MDVPSURqRUpmVUIxRmw5c3g5S05NWExzazlrZnA5YXJDeUZWUU9YKzArM0l6?=
 =?utf-8?B?N0E2VzlXQU5RUGMrbm56Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejR4TVRESzFYeEhwSkc0K2dSbE1td0lQcHBzTVJmZTAyd0tpUzFXVmdUY0dQ?=
 =?utf-8?B?b2Z1N0ZqYzJWUE16V1Q2VzBwL3dqNHh5NmlIaUY5NUgvb1JTeEkrNWdQT00w?=
 =?utf-8?B?dkl0dUdzUDM4QkR0SzRORlVkaUs5QnU5NEcxeSt2bVROU3pza3BVWHo3bDN3?=
 =?utf-8?B?UFRBWWMrQUxyNGpaQld4dHZvQjl1SWZtQ01Gd2R0YWFsckNlcTg4RnhpV040?=
 =?utf-8?B?RFcrWWc3TVpISnRkWXBHNnlUNkZneFVlamtuUnZpcHNDZkVFUmJldjBuNitV?=
 =?utf-8?B?OVF4TTFuTURPcG5CRWdwM2dmbU9kNWZrZ1p1eDN5TmFxTDBoSHE5SjVBT1l1?=
 =?utf-8?B?dXBucHhtcDZsMUlzM3REaGZCTWtrWFF2c1lQWjM3T1R6azJGUXA0NlN1WEJI?=
 =?utf-8?B?OWNRbXVuQklaN2NmNklnRlk2YUxmdGxvZnVxWDJ1Uk9lSUdVMkQ0Tm1KYmpn?=
 =?utf-8?B?OTJHODV0QUJGd1hVeEpOV0JRdU9oSXlpYVlnMnBCMzdaRVFLTXdJQjYxVmhz?=
 =?utf-8?B?WEw5Q1V6Ty8rVjhvODg1Qy9GYW04aU0vcDg3cnFxaFdTUlJ3Y00wSU8yQk9Y?=
 =?utf-8?B?YS9MZWlaZXB0NHFWRS95aDJVMkJIVmdYcnZGclhWSXE4bVhBMlZXV1U5aWZi?=
 =?utf-8?B?ajh4MmsyVXJQaEhqV0NFTG40ZUt6NXYwdUczcmp1elF6QWdGM0tNWVQ1NWkz?=
 =?utf-8?B?akxBWDk3a2gyM0RISHJaaFlSNko2WTNTbGJtUzl2Vnl1bWdyWDVIUzAzTWM2?=
 =?utf-8?B?aXl6K0VoTjlDd3NJWDVCMnE3MkFtWWdMV0RCUnJQWnBjM0U3N3NJQkVFclA5?=
 =?utf-8?B?TUdLemxhTW1QNGRsYWlGb2xOcjhjd1pxaEJWZjZ5aWZraDBFZUQvOEhwazNB?=
 =?utf-8?B?cklydEJQQ05DYUMxTytaMUc2WEZDSFh5Q0kweE5Za2czU3B5WjY0M0lGeHZV?=
 =?utf-8?B?UlNaLzdySllGMUNmV2o4VGtiWDE2TVZWQ1BBU01ZMWRVRjQxTmZzSUtYbFVG?=
 =?utf-8?B?TENwdDVTUE4vczZmRmlYWDVxTGRxc1dBODNYKy9FOE13OWVPTW1aRTFvaFBr?=
 =?utf-8?B?TWNPNHVKNHdOTzh5TXBNTVRITm9IY0xkODB0bzg4TWpMaDQrUTNTZUp5alNF?=
 =?utf-8?B?cDhncVpmZTQ0dkNQY3IwWVpNdmgzbkJpYkROQUtKdUwvZng1YWpYcmp4OWJO?=
 =?utf-8?B?M2R6bTBBNkt1QkdDRkxQQ2JyQnZ1VCtDQnprZzNucEhhazZoemZXbERWMHp5?=
 =?utf-8?B?NnVEcVY4azltcWd1dHpoYVRZMzdVdUVTTERISUNlaThWU2YxY2VHQXdubFBl?=
 =?utf-8?B?N3Rqbm54ZDBJdFRCUktlYlZKOGd2U0IvcWJFQVU2ZUgrUVFNZkFwck1kRzUy?=
 =?utf-8?B?ZVRSdEc4dnJmOXd2WXlLTDd3VkJRckFPSFVjUHpSbWRYWTBwcWg0VlVsZU85?=
 =?utf-8?B?UVNURWdoaU1yQkR5VmVTN0N6eTVYQVh5bmppb3JNd0hsM1JwVEU1YTlRZklD?=
 =?utf-8?B?VGc1Vm9tOG5kSi9qY21COEFIbGxIVGZCRWQ2c3IwRDRRWDVpR2ZZZ04wWEs2?=
 =?utf-8?B?NHdtOGlHbUkwclpheEFvd0tQSmFvOGk2R2I1UU1FWUlYVHBjd3dyaEEyY3JC?=
 =?utf-8?B?Nzc1Zm1pYzNtN0VleU40NmkzbVBacVAzY3VuYnlwT0l2UVJTT1lzR1dQZy9l?=
 =?utf-8?B?ZGRsYThuMm5FVU9CZC92MzlzK2U4UU04SDBDYm10R1VSM2EyQ2lWZ0ZNV1Qv?=
 =?utf-8?B?ZzNnMHFpOGxza0xIeml3ZHQ5T0p5SXU3aFZnT3dBK0hCSWdTaDc0NWs3c3By?=
 =?utf-8?B?WWFLeWhPZlYwNm5JbUw4VUw1eWZCSE0wTGZCTDl4eVVNQUY5VjBNUXUvZWVi?=
 =?utf-8?B?d05sZldOQVc4VXlOSHlINXZXLzdZamJjT2FGbERXVHhUc0FTU3lPN3c3WG5s?=
 =?utf-8?B?c0VWRTFUSmpCdXN4N09MZXQwWmtmSGhKVmRmb3o0ekdaSWpXMHU2ZlRVa1Fx?=
 =?utf-8?B?ZnZuZ29mc3ppZm1PaXV1UDByeFFuWlU0RHdWT1B3YS9tZFFpaENtWVh6V2Rj?=
 =?utf-8?B?RnRFRFoxOVpJdWNYVGNtN0xFU3ZRNC92WVRtYVNSbldrQk9tcmhGd2EzM2dy?=
 =?utf-8?Q?40Xfhltmtkn5/yvn3bCMSOBep?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db3fdb8b-0b94-463f-40ba-08dca59bc7ac
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 13:32:47.0259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O4VVbXVDnnM/zb1inTtb8VbNqS+C4PEA1DnVlEWlVm7pEc2kiijdF7MWbZ18oXqtaq/ZaZqhono457CkoxDbgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9392
Received-SPF: pass client-ip=2a01:111:f403:2606::722;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

On 7/12/24 13:55, Vladimir Sementsov-Ogievskiy wrote:
> On 12.07.24 12:46, Andrey Drobyshev wrote:
>> From: "Denis V. Lunev" <den@openvz.org>
>>
>> We have observed that some clusters in the QCOW2 files are zeroed
>> while preallocation filter is used.
>>
>> We are able to trace down the following sequence when prealloc-filter
>> is used:
>>      co=0x55e7cbed7680 qcow2_co_pwritev_task()
>>      co=0x55e7cbed7680 preallocate_co_pwritev_part()
>>      co=0x55e7cbed7680 handle_write()
>>      co=0x55e7cbed7680 bdrv_co_do_pwrite_zeroes()
>>      co=0x55e7cbed7680 raw_do_pwrite_zeroes()
>>      co=0x7f9edb7fe500 do_fallocate()
>>
>> Here coroutine 0x55e7cbed7680 is being blocked waiting while coroutine
>> 0x7f9edb7fe500 will finish with fallocate of the file area. OK. It is
>> time to handle next coroutine, which
>>      co=0x55e7cbee91b0 qcow2_co_pwritev_task()
>>      co=0x55e7cbee91b0 preallocate_co_pwritev_part()
>>      co=0x55e7cbee91b0 handle_write()
>>      co=0x55e7cbee91b0 bdrv_co_do_pwrite_zeroes()
>>      co=0x55e7cbee91b0 raw_do_pwrite_zeroes()
>>      co=0x7f9edb7deb00 do_fallocate()
>>
>> The trouble comes here. Coroutine 0x55e7cbed7680 has not advanced
>> file_end yet and coroutine 0x55e7cbee91b0 will start fallocate() for
>> the same area. This means that if (once fallocate is started inside
>> 0x7f9edb7deb00) original fallocate could end and the real write will
>> be executed. In that case write() request is handled at the same time
>> as fallocate().
>>
>> The patch moves s->file_lock assignment before fallocate and that is
>
> text need to be updated
>
>> crucial. The idea is that all subsequent requests into the area
>> being preallocation will be issued as just writes without fallocate
>> to this area and they will not proceed thanks to overlapping
>> requests mechanics. If preallocation will fail, we will just switch
>> to the normal expand-by-write behavior and that is not a problem
>> except performance.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Tested-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
>> ---
>>   block/preallocate.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> index d215bc5d6d..ecf0aa4baa 100644
>> --- a/block/preallocate.c
>> +++ b/block/preallocate.c
>> @@ -383,6 +383,13 @@ handle_write(BlockDriverState *bs, int64_t 
>> offset, int64_t bytes,
>>         want_merge_zero = want_merge_zero && (prealloc_start <= offset);
>>   +    /*
>> +     * Assign file_end before making actual preallocation. This will 
>> ensure
>> +     * that next request performed while preallocation is in 
>> progress will
>> +     * be passed without preallocation.
>> +     */
>> +    s->file_end = prealloc_end;
>> +
>>       ret = bdrv_co_pwrite_zeroes(
>>               bs->file, prealloc_start, prealloc_end - prealloc_start,
>>               BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | 
>> BDRV_REQ_NO_WAIT);
>> @@ -391,7 +398,6 @@ handle_write(BlockDriverState *bs, int64_t 
>> offset, int64_t bytes,
>>           return false;
>>       }
>>   -    s->file_end = prealloc_end;
>>       return want_merge_zero;
>>   }
>
>
> Hmm. But this way we set both s->file_end and s->zero_start prior to 
> actual write_zero operation. This means that next write-zero operation 
> may go fast-path (see preallocate_co_pwrite_zeroes()) and return 
> success, even before actual finish of preallocation write_zeroes 
> operation (which may also fail). Seems we need to update logic around 
> s->zero_start too.
>
Yes. This is not a problem at all. We go fast path and this new
fast-pathed write request will stuck on overlapped request check.
This if fine on success path.

But error path is a trickier question.

iris ~/src/qemu $ cat 1.c
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <fcntl.h>

int main()
{
     int fd = open("file", O_RDWR | O_CREAT);
     char buf[4096];

     memset(buf, 'a', sizeof(buf));
     pwrite(fd, buf, sizeof(buf), 4096);

     return 0;
}
iris ~/src/qemu $

This works just fine, thus error path would be also fine.

Den

