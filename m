Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A8EC25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 08:34:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCEl9-0003LD-OM; Wed, 29 May 2024 04:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sCEl7-0003Kp-PE; Wed, 29 May 2024 04:34:09 -0400
Received: from mail-dbaeur03on20700.outbound.protection.outlook.com
 ([2a01:111:f403:260d::700]
 helo=EUR03-DBA-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1sCEl5-0006s3-MR; Wed, 29 May 2024 04:34:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8YT2irWy+RApcGFPhsai/7b2OVVnyo3HHNQkH585m7IR2x9ZVtJ1h7AKjYyr+4j5obfv9mphrhqNgpd1ctmPJDjMovZx9mmtKRiO69DOt9kcD8dQwlN2vQruOqYxId5P5dIFeWnWez5Uha/NaaQUYumHIrYd2ATD32aNNzFzmcNVyyT5KvjZR5cy9x9P0cCyU46v+H/CMT6EjI68Sw0b231iWrsGGsp2xjZtC3AOaNvP8SfVWoBK2gQz3XaStjfClzU6zP3tw5cFSuzU/pzXypSoK97veoZtysOPmnQMfZrsFJs6u59bC8/5YxlzfMbQMvApEqSORJMjAKzPXAxjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5m1GWh3bC075UwyS2wy0krIRhBCkUARkTsWoaAZ+Pw=;
 b=QmkJTYGIq6mMXwRgqWpRykKnaIhyRtQ86i4OKjbXO/9xpbdZIaO7Qvcy7qohE5uLK3cAozR7rcZtODD3Jatg4CCKVJrM9RyOzEKNAfRi1EmEBiISkcVrMzAyddOzxAawNOwOPjAvh+DHl0UCyLwc3hpMyeBe0uKo7iu9Dtce4PeqAHB9Q/U+4SiLWzFFISQVqc893g0rUFVQvXG6HM3FtfiMUDo+IaU3R1gCYS48kWbQdWEU8d4c4UFR7T7BJSmxjsaTljlNx/8cNnCEEa5TfuG2pYIptcLu6YPl2qpYahYLbhiVTFZ4kq/hK7cLZy89rnQ+Bvk7x3in8UTPaAhILw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i5m1GWh3bC075UwyS2wy0krIRhBCkUARkTsWoaAZ+Pw=;
 b=Rl+tdx6kia01vKzf51zWGaSuJpApYJHlhu9C3llq7PZOVlnEsHUmxAhBK5GJt0WR8QXLF2tKRmrH1/vYzl/EsiiiHzMiFUPdOLtfmQXoFZshUteu4myVtkjNYtsBbD+LpVnNURpBtxRDVPUBfaHuRaZjtt1kYyb+KCAsMRadznHhgwX33gWgCV8AI/UHB/ZcfpXzDpY2p3FTNXxcckK85XDRDl+ZvAjTtxnII4t+pLbEhyXeqsSFTMKbKbabIVw+sA14I1XTukApE4bRK8QY5fUQKBdmdH44RNWOFbOU6VxtzEyW9GGqkaZ7rK9jfcMjn76B1BPuMg5Ox/vvWpm7Pg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DB3PR08MB8818.eurprd08.prod.outlook.com (2603:10a6:10:434::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Wed, 29 May
 2024 08:34:02 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 08:34:02 +0000
Message-ID: <de048593-a612-4554-a516-3ecb57cd3aad@virtuozzo.com>
Date: Wed, 29 May 2024 10:34:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] prealloc: add truncate mode for prealloc filter
To: "Wang, Lei" <lei4.wang@intel.com>, "Denis V. Lunev" <den@openvz.org>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20240430170510.148812-1-den@openvz.org>
 <02a0f82a-9681-4a44-97d7-6b2cc77342da@intel.com>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <02a0f82a-9681-4a44-97d7-6b2cc77342da@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR06CA0225.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::46) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DB3PR08MB8818:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3a68ee-57b6-4dfa-b119-08dc7fba17ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WlBXODlCVStWS3dROXhzVVpCSmlTR3NuTDNpYjBLc0hxTzBQK2FjcVRHMmJD?=
 =?utf-8?B?QzkwT1RlUmpSQ29leHR5bVhnQmRielBUN2FNdmU0RHpITTdTK3l0Ujc3aTcv?=
 =?utf-8?B?WEdmT2ZaQll5S2J1WmlRV3FsTEdUdG5ER3ljTmVqcXJKTGloWU9MN2tyYWhY?=
 =?utf-8?B?amZ6Tjg3dk5JVFRvOGF1LzFlNHhMVGtGM3dObGo0OW0vazB6V3RBejhsYWlS?=
 =?utf-8?B?dGUvaWcyeHJZVFlUQ012YWp4VG9IbDlSTHJEMmNNd0p0YzFKeW1OeXdJeEpY?=
 =?utf-8?B?Uklnd29xY3BxWERLMDAwOWdpSGFZem5NVVRtVGJwNjRGY2dKQ3ZhMzg5clEw?=
 =?utf-8?B?azc5amVoNmRBcGpWWjdpWFFiZWR3YjNqOWtsQ1huNFd3T0tDNUJja0RiaEp2?=
 =?utf-8?B?aVh1UDZBWDZZbm4vSWVvM09ONXNRQUpzZ0dQbDFqcjFYVDF0Um9tV2hyeTUr?=
 =?utf-8?B?VnhiZys1ZEVXSGYxc3FPQTZKdXJzV0s0c2xPYStZK0FLNkR5cGdqZStsUERj?=
 =?utf-8?B?Qi9JYStEaU83WWFpVW1DOEJlbjA3c1Z6OXNRMGVNSUNuY21YMFZPUDk3NXlH?=
 =?utf-8?B?ajJNNFhDdy92ekF1QU0wUVZ3UGxvQjRrcHg2eWVzNVFTUy9YanBhLzVmWGMy?=
 =?utf-8?B?bkExWUVmRTE4Q2lLSHN0NE9nRTRRYWFjbFB6UW12QUVyRWxTSGlBZ2hrVS9k?=
 =?utf-8?B?K0tTK29oS1R1Zm52OExBa0lRb0kvNjVpRGw0Yzl1dXpuRHVNYk54WE1zbFcv?=
 =?utf-8?B?OVdhVzhsVnFwdnpUS3ErbkJtcGNheTZ3ZEYxQ0RUWW9pbUNoczJ0d3gzZnJx?=
 =?utf-8?B?QjN0L1lGVW1kRTNZbWxBc2pmcEUxbWI3aGhQeVFXTW9TYTNkamg1TUNoaExs?=
 =?utf-8?B?ZldaL3I5ZDlNTndnSHNHSnh3SnFYYnBQeG5WSDZDeTV4eGVLUVNnMXM0RmhL?=
 =?utf-8?B?YkZYUGFaaHF6ZzhpMWQ1S3VqRXQreTdkSFJ6YXVqWWlyTEkzVkkwUld6WWJN?=
 =?utf-8?B?UnJKR2lDZU96RXFGallBSWtpMkdSWXdDYlg2alIyYk5CVzBNKzFzZmE2cnh5?=
 =?utf-8?B?N1M4QnFnR1d2WkpFOGJkNzQydWxFS2tBQW9IcEl1Um9tSmxLbUxMdzBwZVNR?=
 =?utf-8?B?RlBuSFQ3UGhIbzRSa09ENjNoa1d5b0k2MU5OMEFqcUVZNm1EWW4zRlZpd21l?=
 =?utf-8?B?YWh4ek5rWlI4UUdoV2xGVnloNFowZ1hzeW12dWdWZ2p5c3pWenhvRWdhUGdm?=
 =?utf-8?B?WXErWGovcGIyUXVTMjlRWjF1K2h6Wi9KQ0liUDJhTmtkZzNRempjdk1TL1d2?=
 =?utf-8?B?Ui80ci9FSFN2N0VsMHNIVkR5Ti9OM3JEeFU1RnMvVVIrb0VCZnV4Mk5qVHoz?=
 =?utf-8?B?R3MrUitFYnk2M2hPSm5JNzNMS29iZ0lTMkd0ZEtYbGp3WWdnTGtkQThDMUYy?=
 =?utf-8?B?ZnlsYjIxMk5VV2tOVGpBa2FTWC9oaFNFd0pLZk4waUFEOHVqWWpOb0l2d0N5?=
 =?utf-8?B?dFVjTzVYVnVBT0ZxU041dHV2VVJ5cC9LV3NLVFo4ZE9MVjlodUhoZTBBcEZN?=
 =?utf-8?B?cHkrUURtSHhPZm9KMGRNV3V5SkZ6cDduVHBwZjNRNHpoenlIYThMR00vekpl?=
 =?utf-8?B?VGlQVVR5MTAweFRoUXAxWFdYUE9Yc1pSNCtsN0JVU2g2YzhLSDNhSEJmbXo2?=
 =?utf-8?B?c3VYYUlqL1U1MmRJaGJrYnBpSllIelQwek8zOHhSbGt2MkdTNS9GUjF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUJjT1ZkaUw3bVdCMWt1OFFaN0RHUHkxV2xVcXhBMk5XdnFVbFJ3ZndBTzZK?=
 =?utf-8?B?RDM3Q285YmxyYjlRN2NnOTVJaVNKb0dOOTBXNlVSbVE4dWJDYm1RelVlNUVZ?=
 =?utf-8?B?Sk9KRjAzTnYvSHZveGFVVVRuQzNvM3hMTnRVNHU2NU9SYTVHb0pQcXNkamth?=
 =?utf-8?B?RUF3YXVzcWRLV05GUWlpR2E5aUtjMHdSTWppOGdhNHN3OW1EVXRGTm9uNkkr?=
 =?utf-8?B?RUFzK3lRK21sWWhhQng1Q1VvdDBPeUJLRDJiWVgvU2RhUHlCZ1BBKy9JOUxj?=
 =?utf-8?B?V2U0N1BOK1BWUjFCcXFKa2w2aGxRK25Vcys2cUZ1Q0NHV09aTWVLbHNZZUsv?=
 =?utf-8?B?OEhxRzN3VnNReVhUM3R6aEdOY2sxR1Q3VE5uVm1Mcjk5cGlNQ0dPcE5JNzMw?=
 =?utf-8?B?dkxvcE5nTkE3Q2g2eDU0WC9GeUg2Q2hBekNDUWlzMzFDTG84TW5abDVMSHlB?=
 =?utf-8?B?ZTBRcDNXQ1FEekQvUUkzdkY0WTNsdE1KSng0YThyZ2UycmpYU3JrVTJlSGtE?=
 =?utf-8?B?VC9vL3dBRkc0ZTdVOG9veVBzMmZJeEpnYkNzLzVpTlpCa1JsTHlPQ3l2Vlk0?=
 =?utf-8?B?VkMrT3A4MERrVUpHc2NBQ00rdnNlQTRGem45VE02aXFuVDBlSWtPWlNybkpo?=
 =?utf-8?B?QUc2b1BrTk5wZnJwdUc4U2V6aUxMNGJqcmpyWEd2TEdWa2JlTTREQS9LQTY5?=
 =?utf-8?B?VGoyS0liYU1YdUJqVkUwb1NEM09VYlg2QUthWVdzc2E1NWxXVFpQUElMM3Aw?=
 =?utf-8?B?WFdOLzdZT3ladnpvRkw4VGpkd3owQ25kbk1SY3pvRnlKeXpIa1grUTQzOXR3?=
 =?utf-8?B?eWR0YlloVlZSUzVWSGM2V1pPYk93QUd4QnR6Z3B6TmNMRUxlZHdZV25WME1U?=
 =?utf-8?B?ZzJxYjdKanFFeUlnanpoeHJtTitJcXhvdExwcDhRMHU5NFhzTEpCVEJuNTQ4?=
 =?utf-8?B?QmlRSGFOU1prY3E3ajE2WnlkMFU4Zng4cDRnVEFCTVZmaFJuM2tJUTdWVWRT?=
 =?utf-8?B?RVhURG5KOVNacGw5bm0xajVJa0MvQmJ6MkJmOThqamN2Z2dURmU3TmN4OUo4?=
 =?utf-8?B?RjdGSnlJb2w1eTFaNUlmcUw4ckxIeFd5MnI1NzZqejR6aXp2SFAwK3FpN3No?=
 =?utf-8?B?RlRmV1AwWmJCSXdJRE83YkJGN2pCRmkyYmJ3SExjaWpkbDMrYXNHZEJTL3dI?=
 =?utf-8?B?UHg0MFBSSHUzUnBITHF2NGpYWDRmUENuMXlUZENqYkRxeGQwTFBsTGR2UFhq?=
 =?utf-8?B?ZW5sMnY5Z1ZNZUZweTJ0a0ZVcjVjb1hlYktqc2ZPVTk5d2wvelZ4ay80M2Jz?=
 =?utf-8?B?aHNpUmcyRzA1ZWdxcmFSTlZkOHMzVVgwemd2SmpkWU11ZHBTWDhkZUo5Qmlo?=
 =?utf-8?B?b0Y2eGRHVlFnWXlYZjJOR0lKOVhTcG9qSlJza05EaVVGcjdnSnJHR1lRU2tQ?=
 =?utf-8?B?b2lwdFJ4cUROZWNnWVZSVEFpSm1TMGJTclNjV3FCdzRtVUNxRSt2YVh6QlBr?=
 =?utf-8?B?SnFqbmJ5dFNUWVFOQzRaRGgySnBGZk9SZm8rSHMrMFBtZ09TZTJVc011V2d5?=
 =?utf-8?B?QVllc1RXK0lZS3RScnVKWnRFeVRoTjQxUS9HQ0JEdHFuSTRVMG82TE9jRGJ4?=
 =?utf-8?B?cC9BS1FZSmVBU1g1WkdxNDExM1dQdkVZN1Y1OVIyd2hlQ2hmd3p6UUxVdUNr?=
 =?utf-8?B?MHNIZEtxRisveHJNY2k5VmlrL1dKeTlSOVJaSHNNWk1UOTMrdUM3R1p6dElU?=
 =?utf-8?B?dTlGWHV5TGIxaGRxTU1ubWV2Qld6Y0NYbWhoRnNsMGFKdU9PUHVseS9xSC9D?=
 =?utf-8?B?dUIzcFcrZGg2QjZMS3BzK25xNXhzVDlRVDBaOUVFc3JaTXQ0aDZ2cjVTQ1NX?=
 =?utf-8?B?UlhoU09qMFVWbjhrK0REVUtBa1Mvekx3QXdIWXdxU2Y1NlV5b1MyMnB4OUpX?=
 =?utf-8?B?end3UVZTWnJpRi92TVFPY0tkSWI3Ujh3NDZoc1dZK3NXdUpJU0Z4d2JSSytK?=
 =?utf-8?B?UGJRQXVmZkZ3cGlER1VudUdpTndaQWZTWXMxU0FHTm4wdnYzODJjZXVDZGkz?=
 =?utf-8?B?UzNsYjNhMUZZRDVyUk8vRWRRUWc2clFJMWFyc2VBZWcwai9aMlF3SW9JVyty?=
 =?utf-8?Q?HWx5fHHmi22KMhjiEbqawXJhG?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3a68ee-57b6-4dfa-b119-08dc7fba17ea
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 08:34:02.2904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oYO1UcfcTqYg1/mwaouGqD6XgTc9qDcFTOs0mLbL5uN+WtbfUcgxfSNgXhmjUIWKKc7tMF5SyP/QmcfgtX5AjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB8818
Received-SPF: pass client-ip=2a01:111:f403:260d::700;
 envelope-from=den@virtuozzo.com;
 helo=EUR03-DBA-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/24 04:33, Wang, Lei wrote:
> On 5/1/2024 1:05, Denis V. Lunev via wrote:
>> Preallocate filter allows to implement really interesting setups.
>>
>> Assume that we have
>> * shared block device, f.e. iSCSI LUN, implemented with some HW device
>> * clustered LVM on top of it
>> * QCOW2 image stored inside LVM volume
>>
>> This allows very cheap clustered setups with all QCOW2 features intact.
>> Currently supported setups using QCOW2 with data_file option are not
>> so cool as snapshots are not allowed, QCOW2 should be placed into some
>> additional distributed storage and so on.
>>
>> Though QCOW2 inside LVM volume has a drawback. The image is growing and
>> in order to accomodate that image LVM volume is to be resized. This
>> could be done externally using ENOSPACE event/condition but this is
>> cumbersome.
>>
>> This patch introduces native implementation for such a setup. We should
>> just put prealloc filter in between QCOW2 format and file nodes. In that
>> case LVM will be resized at proper moment and that is done effectively
>> as resizing is done in chinks.
>>
>> The patch adds allocation mode for this purpose in order to distinguish
>> 'fallocate' for ordinary file system and 'truncate'.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> CC: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> CC: Kevin Wolf <kwolf@redhat.com>
>> CC: Hanna Reitz <hreitz@redhat.com>
>> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>> ---
>>   block/preallocate.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
>>   1 file changed, 48 insertions(+), 2 deletions(-)
>>
>> diff --git a/block/preallocate.c b/block/preallocate.c
>> index 4d82125036..6d31627325 100644
>> --- a/block/preallocate.c
>> +++ b/block/preallocate.c
>> @@ -33,10 +33,24 @@
>>   #include "block/block-io.h"
>>   #include "block/block_int.h"
>>   
>> +typedef enum PreallocateMode {
>> +    PREALLOCATE_MODE_FALLOCATE = 0,
>> +    PREALLOCATE_MODE_TRUNCATE = 1,
>> +    PREALLOCATE_MODE__MAX = 2,
>> +} PreallocateMode;
>> +
>> +static QEnumLookup prealloc_mode_lookup = {
>> +    .array = (const char *const[]) {
>> +        "falloc",
>> +        "truncate",
>> +    },
>> +    .size = PREALLOCATE_MODE__MAX,
>> +};
>>   
>>   typedef struct PreallocateOpts {
>>       int64_t prealloc_size;
>>       int64_t prealloc_align;
>> +    PreallocateMode prealloc_mode;
>>   } PreallocateOpts;
>>   
>>   typedef struct BDRVPreallocateState {
>> @@ -79,6 +93,7 @@ typedef struct BDRVPreallocateState {
>>   
>>   #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
>>   #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
>> +#define PREALLOCATE_OPT_MODE "mode"
> Why not keeping the names consistent, I mean:
>
> #define PREALLOCATE_OPT_PREALLOC_MODE "prealloc-mode"
>
I have had some thoughts on that, like prealloc-mode
name is already used on the generic level, but obviously
I have mistaken.

Sure thing, I'll rename to "prealloc-mode" and in the
same way in the macro on next submission.

Thanks!


