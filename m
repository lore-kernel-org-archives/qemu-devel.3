Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F22C41513
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 16:38:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s80ae-0003wW-U1; Fri, 17 May 2024 12:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1s80ac-0003wC-Pd; Fri, 17 May 2024 12:37:51 -0400
Received: from mail-am0eur02on20701.outbound.protection.outlook.com
 ([2a01:111:f403:2606::701]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1s80ab-00078C-4M; Fri, 17 May 2024 12:37:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHqeMD23bDhpZytJtDtZ1zwqCp2kqAVx87k7KUU7u2DLIoLxJRV5JwWZ9++JJp1J9+mcg+bof5AkWfiTQMnm+HZBUWn3Vx4MuKXNK38sYxtrhP1thS01jHuIOWbEubZgYkFGKAEMrf7Mnmn0mFmXJt8RZ5wLKy9f7vitRvcUPrb7RCcONKM+sis81ewYv06PC2lUYPXDMoCsGY0XCcXkmiIPesj6PkyLZ4wc5llLJ7SbUaH3Q4jKsFhEfXwZ7CxchimcZLaOHfRxXQgFwYc0Dgp0h5Xp4AcXVrWP/Zrqh0gw8fKTWgjCG/c+6s0TfMwmpNus0wAi6Tx52vtPXSardw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFMRwSJIYcmxfrIIK3YzYPSSTAf+X1IaV5QHV/PUgVY=;
 b=k3kvxXcKwDe7YlOsmdAXZN06OF8ELLkw9JeFy7mpLi50PW15/VLFIpsZ4Nfj/Uoh5Hot7Ovv3IK0DLSixa6qPUJyBKz6sHbFuJwcYHdyv35Ze0mo8bDpKVu5A6V5fBmmyz1rKBEwiVUZ2/RflBGAm/IC2jJb56deJKW8g8dxZoxlPaw+i1lacMa3FYDqYtFa4tdgvaZTEtL9QcEkXNgm60b0woT1rDVJjt+SwpemLejwW58pOXeD47bZx24zF5mj+bzQswfF2YNJ60tb40e6NYe45bcgQmr22jWtrvejtMfPeE9axBL83W2VjfrIrYSi53EsxcSnSTsNeH7Tsrn/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFMRwSJIYcmxfrIIK3YzYPSSTAf+X1IaV5QHV/PUgVY=;
 b=ctRRXwj69iCNChwmDifUGUEbzgZKFSUxFfk6gyjbrgBrm/rprDnTotwUVrOw5h27XSSR7luQziqZGU4AQ2FRZQTTpLddWKVIiJfQ+Ku5OM24oKyibslVitVjSu744Ryb0ezDD0hnNKbibU4G82caoM+8KTbYGr8qsCzD4KI8hu0KNUeohho8gDLZ0u32PodXQHUGNcrcD+UufvQsinj4eSF0k/YLrI0iOfWFTxETXk+aZE2eLAwyP1oNf62nv1ww7a/eUNLonD6TAyx5uWMZkQ5vd8vW92ldHOxsTd0mjP6YdTj8/dbeDfvF+NDdGW8VJ8Kzz3cNhPWh1Jfnyw7A9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com (2603:10a6:102:1db::9)
 by DBBPR08MB6089.eurprd08.prod.outlook.com (2603:10a6:10:206::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Fri, 17 May
 2024 16:37:43 +0000
Received: from PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1]) by PAXPR08MB6956.eurprd08.prod.outlook.com
 ([fe80::59be:830c:8078:65d1%6]) with mapi id 15.20.7587.028; Fri, 17 May 2024
 16:37:43 +0000
Message-ID: <f3b21122-b30d-4d43-8244-8ea99d3cd5b5@virtuozzo.com>
Date: Fri, 17 May 2024 18:37:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] block: drop force_dup parameter of
 raw_reconfigure_getfd()
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20240430170213.148558-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20240430170213.148558-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0271.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::44) To PAXPR08MB6956.eurprd08.prod.outlook.com
 (2603:10a6:102:1db::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6956:EE_|DBBPR08MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ca3c8-96b0-42dc-88bf-08dc768facd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFBrbER1Y0NDRDhVUDEvdm1yUm5rK2ppYmNGSm5FOU1WUTR5aEQzUFVhc0tE?=
 =?utf-8?B?VHlvNlphVzhCZnNrT01Za25COERRQlg1Y2t3MVJkeDJFbjgwaXBRKzBCOTNO?=
 =?utf-8?B?NnZ1Yy9sdnRCM3Y2YTZZY0QreXNtZVNVby8raVVyMWx4MEwySGR4MzIwWXkz?=
 =?utf-8?B?WXBYK21SZmpWL3N0SFJRSjB1SmNpYzBqOWpBbWs5UXc5OHNrK1k2S2tTSVR0?=
 =?utf-8?B?emVRUmtXZ2pqZ2pYVHZaWE1FL0RXeEZJVTdPTlp0VERDSWErbHFoNml1MUcx?=
 =?utf-8?B?QmVWQXpxSTJrMHI3NFNHd3VtNkE1QWtLS1hZc2dzbm1mVUdFOW96bVBpNEFM?=
 =?utf-8?B?YlBCbTJ6Uzc4QVhFOGIxMUMzczFGelExTnZ0Z3RaZERFUVJUT3diTlM2eXdz?=
 =?utf-8?B?U0tjdEZSZG5xQWl4Q1F3RHVmR0ZTT2pUeFozZnFEZ1Fud2VZMjhuNlRaMnEy?=
 =?utf-8?B?SlJGdnBDMVZwMGxKcFg2UjdqWjJHcXpYaTl0VE9Namp1akJUczVhK1BvSFgv?=
 =?utf-8?B?MU1lVDhuVlJYbFFCOUx1VjNXajdyUXAzbkdxVnVMYks1UTFlS3ZFY2V6dnZM?=
 =?utf-8?B?L3dtUEJVLzBiNlZHOWxDNk03MGNGSjV6b0xrLzJJWHA3RjlzREQ4RzNkeVdT?=
 =?utf-8?B?VEIwY0JKbmVVZWZmK1VZUHhkUElSK2ZqZC95akdobDlzY0NMaHNYdk9rcUdj?=
 =?utf-8?B?OHRhZDE0Wm00Z29KOWxRbm9NaVpCdkJQdk9hNGNVNU9Bb2llSE5xQVJ5cXpS?=
 =?utf-8?B?UjhzaVJTRkZHWHhEZnU4bTBmSFZjSXJSM2NKM0hpL1V1WkM0TE45N0ZVMUdG?=
 =?utf-8?B?SXM0Q2ozdVVrNm8wRnBvTDk4dDRrRGRYNVdwdHdXL3kxcStjUGRTaWJwMUdY?=
 =?utf-8?B?dXZRYjBtOTRRYTFDb0RmRkVLaUxIL3kyMzN4aGNWWm8zUmNHdml2VXpBRHF0?=
 =?utf-8?B?TC9abnNLMTE5Y3A0aXZmeHZGN3hTc2ZUblRhRktjaytiRVdDSUhxcVVidTNW?=
 =?utf-8?B?anhLWDlRVDQwam94c3pwZzhYM1lZYzByWnMwaGV3TGlocHpuRTdpK0xlL2Yy?=
 =?utf-8?B?TlZhRDhOYS93ODFGdVRMWVRoT044ZW1BVzFML2gvL3FBMkZuS3NNQk9MdHli?=
 =?utf-8?B?ZFNoYUh3QXc5cnZuZFZNQTMxbW4rZ2t0bU55R3dCQkczekZHYm5HYTE0Vmlh?=
 =?utf-8?B?d2t6N2w5Q0R6ekxxZUtHOXZoV2pHS1ZoUnhCaTkwUk9JMGpucVRCWkdpS01x?=
 =?utf-8?B?eHpJaHVQOEM1d1d6RjVkblhGOWh0SWUzbmtWQ21kMExtSzVYZGJIeUsxWEN1?=
 =?utf-8?B?V3RseXU1WktIVVIxTE5aZ2V5bmVZSEhDQThIYy9uVTNHOVVsTlRlUkhHcHZ1?=
 =?utf-8?B?Zkxud0ZaWWtINnBZY1lIN1hOQlgyUm4xQjdsOFNTdUhwZTdxOTAvV0dleGhH?=
 =?utf-8?B?RDRNR0FqWExoZUdVdjFtT1RHYVllZ2VZSHc3OVlzODIzUkpKZkFlTGxMWHA5?=
 =?utf-8?B?emFsdFNvRzB2bFpmdTFKNEtVYmNaMERBUkRxOFk0MXprRE9SMi9hdS85YVZa?=
 =?utf-8?B?SnlsbmlxT0R5N002VFU5NTdycjF3eEFIS2JMcFp6bzk5YS9aaXdUL0g5RjVI?=
 =?utf-8?B?V09FUENnb3dmaGxMT3J5cTBGSUE2Y0UvOUJMbXlrZGFHdC9yOVVkUytJVWh2?=
 =?utf-8?B?TzlnVkppOTVrc0dSWU13T09QbzlFNnVKK3JPaGJ2M1p0S2R3dnZVUGVBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR08MB6956.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTBJU1RBUmg0TDVoUjhPa0VVamFBK2FrMTlPUmxzM3ZSTXI4cUFWcnNSMWIz?=
 =?utf-8?B?UDdZOEpiRjBvN0FXMDNpZXppQ09qZzRqd1NHSkk4bGlBR2d3OGpMZHVlMTl3?=
 =?utf-8?B?aU1ZN2x5VjNIcWorR0kxaGFjNkYySkliSi8wSnF5NitsenFrbCtnRGJiYThr?=
 =?utf-8?B?YlN2TWpybWVnS2NON3BuRzJ6Zk5sdVpKbVpIVnIvNE1ZZ0VVekY2bWQzUnps?=
 =?utf-8?B?b3VYbHpJOVA2VlR4TkpHa0N3NXU1V0dqclBmSHZkcGV4YkQrWVpsRlJGUk1N?=
 =?utf-8?B?MmFlTXhwQ2o1YVR5SnYzMU50TzZtN2JTdGJaVlgzRmpLN043RU5iTVo1K1lO?=
 =?utf-8?B?T1dVa2UzSzhrU0lqTEc4Sms1YnJjcUJkRDRaTW1acGJvVEZEdHc0VDloV0JE?=
 =?utf-8?B?N0pzV1Jic1FLQ3FkbnZaK3hNbGprbURuZm1aYkxGTXFpRVpwejl2V2Npd1Jk?=
 =?utf-8?B?bzdHQVczNVprR1B2VnY5bHgvWXZZYnNCZTI5VFE2c2hBajFLZkR1UWV3MHJV?=
 =?utf-8?B?SDZoR01rQVZYUjc4K2tNVGY3dVAyMlpEeTNsWHNnb0pYK2VYRTJvNFpLeVNJ?=
 =?utf-8?B?VkRYakIwS1kvOEEvT1JqRnJRcmJHM0JOZUVNaTFOVHlZQ3RmY2tTOWtaRnQ1?=
 =?utf-8?B?YmdnUlkveWhMajdKVFM1RVg0RFZjSFFiM0hSWWhRanE1TERxME1jUWw1emR5?=
 =?utf-8?B?TFBLK0habVVpZEcxamEwODhKUlZsbjl6bmJJcHQzVzduWnlIMk5RdDZ5Rlli?=
 =?utf-8?B?WFkzOE9saVVnYVdDS1psbHFaRThGbGZoRDluZWJKdG41cmVZQ1JxbHZtV0l4?=
 =?utf-8?B?WGhrZlY0WWlPTWY1cmtuc3ZpRUNTcnVWMGx5dFluWU40akpFcmtYbSsvVzcx?=
 =?utf-8?B?THNlMDN5NjdKQjFrYkNqckRtSHhjbmlZeVZCQWhLMS9zMDZ1eUhEZnA5bDNW?=
 =?utf-8?B?YndzNkRBV05DelBIOFRsK1djTTZSbWNOSFh3NXVzYXZqZ2xDd0hXME5PanRa?=
 =?utf-8?B?QVZiTzg1MVJRQ3lmbUViRmxvM1E2RHdoTUdPVkhDSnpKemMzVlVLenh0T056?=
 =?utf-8?B?QnNwc0o2djdJQThoWFNPYmdCZDFMZHpsQnh3S2JYeDZtTy9jdlZYRU8reGFo?=
 =?utf-8?B?eHRqNnE3VitseVhqMCtLc2xhMURxOE5SM3Y5WUZrQ2E5d3lSYysrRThXK2cr?=
 =?utf-8?B?Zm1IOEduWEJHRmMrTFBka1AyMEtvcXlLUkZQQ1JuTFZsZ0YrTFp5QmlOclNK?=
 =?utf-8?B?MC9CMDhWMDAwUm00am9KWHA5bnM3SjRXZW94T0xkYUlyRStQVWxOWk85L1Rr?=
 =?utf-8?B?S3lPQlljT1kyN2ZqRzFaZkg1aDZXZ3NxTWNFdGdFWVFxZWwrNEdGN2tzeE0w?=
 =?utf-8?B?aUFDejZNUlRCaUtLWU55NnVwSHJPUkFnTGlmdVNGUi9jTzBJb0dHRG82dWxL?=
 =?utf-8?B?bWxYRkJvRW9RWjhlcjRDTGthcEhrU1YxaXRYVGV3dXJKajMvYklWUEpCOHBl?=
 =?utf-8?B?RW5LbWFKenBoTCtBazVaMXY0VGxvUDdUT0w4ZlRRN2NScDFNYnVKNFlpTnY1?=
 =?utf-8?B?Ymx5Q0Zzb3I3SmlueXkzUExTZlkyZFBhdWl6YzZ5RmJzTXhra2M3OE1GSnhE?=
 =?utf-8?B?em1ha1NleGpvaW1iQlpKeUw1MjJBM2l1VlFxNDhDbDYyZmpwRExFRmQ1NGZ1?=
 =?utf-8?B?VWxBWVk5b1JnR2xGUGg3Y0IrWi9zbWVxT2M1cU9rYzNMbms2NG53YXNwcXJo?=
 =?utf-8?B?RXBoNHVPa3hTRTJzeHdQVkdnMU1CZllNbTRWZHU1ZjFyaDd5bnNLYStPeGRh?=
 =?utf-8?B?VTl3SGUvZThvcFdFUll6elc3L0dsSEpybW9EMFl5eStBMGVRYjhac0RYQUx3?=
 =?utf-8?B?MlB1N1h0U1F4bXpWbVByKy9xQjNaYytmTEF6MHRlb0RRbFIrRWZrdCtFYnJu?=
 =?utf-8?B?Z0FSeko5aFdCc0N1N3VEYzJyUUc2cDVjVlBTY3lqTThMUEo5NHlwSEx3Q1p6?=
 =?utf-8?B?WUoyZFQ0Z1Yzakt6cHRhNEVpQ0Nad0ZVbUk0S3NNaXF3bU1CeTBxUFlBNHZo?=
 =?utf-8?B?aHp4Rm9XYkN6a2UwV05RUkdzWFhROEdZS1lIZ0RVYjNLL0NpL1dSRnN5Y2JV?=
 =?utf-8?Q?/ximvkHgqgLgZGoZ4/jVBP29B?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ca3c8-96b0-42dc-88bf-08dc768facd7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6956.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 16:37:43.3272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zsv89w1CFqX4iBdbMysiqB0LPk7TKyLw/CbqFvysz1NCN4avKjnQpYIt1jtnRZEJEvGglLzR2QmhjPLjgxDH1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6089
Received-SPF: pass client-ip=2a01:111:f403:2606::701;
 envelope-from=den@virtuozzo.com;
 helo=EUR02-AM0-obe.outbound.protection.outlook.com
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

On 4/30/24 19:02, Denis V. Lunev wrote:
> This parameter is always passed as 'false' from the caller.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> ---
>   block/file-posix.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 35684f7e21..5c46938936 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1039,8 +1039,7 @@ static int fcntl_setfl(int fd, int flag)
>   }
>   
>   static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
> -                                 int *open_flags, uint64_t perm, bool force_dup,
> -                                 Error **errp)
> +                                 int *open_flags, uint64_t perm, Error **errp)
>   {
>       BDRVRawState *s = bs->opaque;
>       int fd = -1;
> @@ -1068,7 +1067,7 @@ static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
>       assert((s->open_flags & O_ASYNC) == 0);
>   #endif
>   
> -    if (!force_dup && *open_flags == s->open_flags) {
> +    if (*open_flags == s->open_flags) {
>           /* We're lucky, the existing fd is fine */
>           return s->fd;
>       }
> @@ -3748,8 +3747,7 @@ static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t shared,
>       int ret;
>   
>       /* We may need a new fd if auto-read-only switches the mode */
> -    ret = raw_reconfigure_getfd(bs, input_flags, &open_flags, perm,
> -                                false, errp);
> +    ret = raw_reconfigure_getfd(bs, input_flags, &open_flags, perm, errp);
>       if (ret < 0) {
>           return ret;
>       } else if (ret != s->fd) {
ping

