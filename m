Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1EDD6ACF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 17:39:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGM0Q-0004DS-CY; Wed, 27 Nov 2024 12:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tGM0O-0004DF-IO; Wed, 27 Nov 2024 12:39:12 -0500
Received: from mail-vi1eur05on20715.outbound.protection.outlook.com
 ([2a01:111:f403:2613::715]
 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1tGM0M-0005RA-Iv; Wed, 27 Nov 2024 12:39:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fRl+fe9okDZCPuJlc83d7VaXkDlX10Ss+PXg0u80TPp6gxt/Z+YRCQvBQUViEuEI1HT8sWfna63IL+30dGhcLa5ztCq5bReUfIzlgQaHgzubDJoMaQnqksOE5Cg+uWWRxjOHINxJWTK4cPWY5QJ7/sOA+3OkSaa1bJDVpBLHWKu+eAlJFv3mBF6fdqHJHeADlp2G7x0x6KZagvJ1UcqrkJMYzblhanE2yaVQErPC0lt/8FKODaPO6lMn53rvPwDssokbRR6rpBkjCup19hkiKGP8eZuvmLR71Na+Gv2IzfW1WwlQBL39FjwC1zaxun5gBlP44qTF46EVYGj8tQEleQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iWHnPtVozsLYSTjj4rRgyBIjxoJcNMbLTHgh/YojgY=;
 b=vBh5hpJ4C43ib9UhdIbfdMhKV6DpUla20nNXoFa5dakPDH7XXpEZv9ijmZzciXyLgVVJaUhwQ78v/s5BwpCDMdyQJUycpk0C9TfJCXe6Og+OpyISM6xmz0UwU7UMvVwOtS/9FHFcGH8Qi2WnMd56jzA4Lc6oHgRbgmdzPYN6zK12JpA1YnGyp0eAuipdmb2Vakef4bdluciQSKkEKDKma0TWvaIZJn0IGV100NypP9ZjgyVSWH9GbzCFW7D4wmvhggcb3niBIWoOWNWadsVsggrj0TbvBZbUmpv8Owm3wClHabQl3+myQHBfHi2G42oGVxWzm4eQixs5UgIvr3+c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iWHnPtVozsLYSTjj4rRgyBIjxoJcNMbLTHgh/YojgY=;
 b=T1lno3DQwGMOIZBajczrcvVcd2NCotF64FExEm58Zf8hFOjeZxhYwEvoHbl8j2G39beqZ/7EzpFgyoCUEUmDwq+whiHOY+kC5JReNTH8fqgAUohiZR6iR2PhVWR2cexnhOIf/xTcx+ent5wllM45fLIQ//PzrdXd3/4JEOl2keSVpcpVRUyqXKjxu4nR5zUg4N3izcqOIdaJKFjAb6ZGr7pD8vgMGTjOkX9gt676lJ896b/WKsDI7OAbXM5+gUpVmuqlORn0+h7AXHiAQ98QpOiumIUmZqmKr7cBoj1PFbmALTOUajceiOiCneUb7URb1LJfQQwg5d3rcjfmpF/hXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by AM8PR08MB5586.eurprd08.prod.outlook.com
 (2603:10a6:20b:1d6::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.12; Wed, 27 Nov
 2024 17:38:32 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%6]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 17:38:32 +0000
Message-ID: <f6fc6ed3-d1d0-4498-9ec7-1f4e55a2abf3@virtuozzo.com>
Date: Wed, 27 Nov 2024 19:40:39 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] migration: Activate block devices if VM is paused
 when migrating
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 den@virtuozzo.com, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
References: <20241125144612.16194-1-farosas@suse.de>
 <20241125144612.16194-5-farosas@suse.de> <Z0Su2RINKfqRk969@x1n>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <Z0Su2RINKfqRk969@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|AM8PR08MB5586:EE_
X-MS-Office365-Filtering-Correlation-Id: 786a050a-8d22-4d09-3988-08dd0f0a4fb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWlEZ0t4ckRCY1AwNlZkNjBCNk0xUVpZNTVnREIvcGtMbDlyUUYwMDBFYWJN?=
 =?utf-8?B?Ulc1ektrQ3dQd3JoUWx6K2J0djVxVnlEdnB3OE9vem1WRzUreHFma3ZSalhp?=
 =?utf-8?B?b2ozL2lzOU1zUVdwQTQxdGZkTExMamhLRVhQc0JRM2I5bEZ2TXJodFVLTTA5?=
 =?utf-8?B?YjhZNm9CMU5wZ3cxRUNmWTlaK3pqdW5DQW5PNFgzbjZ0R3lMbUdUbmptbnhk?=
 =?utf-8?B?cUZlMURRdnNSSHJGdVlNaUlGV3JqdEVPR1lOa3FHR3h2dWhvQnlQdHpIN056?=
 =?utf-8?B?YVhVbmJBdDhYSys2bFo3b2hTYS9OTmdIR2ZyaXk4MEJJUm5hR1ZRdmErMVBL?=
 =?utf-8?B?a2RaVXJkcXF2bjE3aUxKbC9oUXhrSGNscGliOGE5M2xyUHRIME1GQmhtQ29M?=
 =?utf-8?B?YU1XOFR1aEpSNjdqV0p3Nm15R2VqOTRGQnVraEhwQW92RzMwWENwRUluQjhy?=
 =?utf-8?B?QW5pZGxJeCtPTDVrY2VmYkd0djlDNUwzM1R3WmxnTHg0Q082N0swSnFGc2Nu?=
 =?utf-8?B?dTZxRnRqWnUvcDlEMyt3bGlYbVhaSW1vVFppNHVRNGF2QWpic3VkbGsydTN3?=
 =?utf-8?B?dDhTTGJnTTRFdFJLU2w5V2FkL3kxalR4ckVsM2ErQVdTbEZUY2RCNGNnR0h1?=
 =?utf-8?B?SHhyb252OWhLRW9rMjV1RVM5QzdzK01Bdk9PYXkxN0ZZclFXSWdVU08wcW1D?=
 =?utf-8?B?TktTMEgvdUR4bnJ1THF1SGpmSTlTQXJDWGFOSysrOEhCTHB3SXRaQmRha1ll?=
 =?utf-8?B?OWI4SGswMmhyemFkOXNjcWZkdTBONUQvNzVxbW1LeGR5N3JYTC9iMUFBWk5p?=
 =?utf-8?B?cytvcFlaVC95ZzdhR2pIYllnRzVBMzc4OEk2MWNZamdDOWFlYkRPU1VvZmwz?=
 =?utf-8?B?eGpleVVDOUlXTGVOZ2w4T3VWMk1URFEvUGEzWDlLQXRTaE5hYWl2dmEvSTFv?=
 =?utf-8?B?allFU1BybXZxZjRiOHJ6Y2Qza0RJaVBSNEpWRzRQNWtaV3BseEdzQ1JOMmdl?=
 =?utf-8?B?WjVLbWNJRkxQMTc0MzF2KzRVRE9mNm9NUnppUmk3MDc3dmZ2WVY1dHdROTJ6?=
 =?utf-8?B?R0Z6T2ZUQjRaR1pwMnJiQU9ySVdvbXdCZHl4VmhQbHk1dDJqTzZsMk9yUnNK?=
 =?utf-8?B?cXRtMWtLb2lMSHhBdTdHQmV2dytXcmZVT1A4bVVoWmQ2ZExyRURUalgwd2dv?=
 =?utf-8?B?cy9Eaytubjg4TmVqSDBYNG5GY2w0VENKZkdEQzlYb0Z0anpMNWhlTHIxdjBu?=
 =?utf-8?B?dXhBdnAzSWx1VWNpTisveVQvOEZOWWVoNUJQQW9IeGk1aWJYMHBHaUdNaE1J?=
 =?utf-8?B?RVEyZHFEbnowQ1VMaCs5VDdhZ3daekZuYzQvYU9seE9MM25MeGxwOVhmcHdj?=
 =?utf-8?B?cUFHRFY0ODZSQmJiakdXdWh6eUs0NE82R0M1Wlo4WWExbTNlck9IQk5ONVJu?=
 =?utf-8?B?aHF1em1jU2V2QUF0V3Z6aE0wODZWb3RhMDRzc0hObS94SzZ2ZjRTNXl1MjE3?=
 =?utf-8?B?T045MlVSaGhHbWpaMitFczVYTUpOQ0cyK2F1Z0tCeGlHT3JiTGZNTzBjMU9z?=
 =?utf-8?B?eDVtZUpoNC9HbkY4T3FRdzVIN2kyNlBCOWlkbWoxR0g1SHFQNlo1RU8vVFlT?=
 =?utf-8?B?V3ZNNXhrcVE0bWdXWUNaVmxhVjZEdkZQbGJ5a2hWZ1k4UTkwYldEQ1ZVb0Za?=
 =?utf-8?B?dnNCS1B2MExreDA2eklUTFVSYS85eWZmdXVta3RpTjZZZWltbndWdWYyeUFC?=
 =?utf-8?Q?5xoaKuHB7N6ql+FseQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0dpc2FHa0M5R2p4SGlibVdUL3d2Zlo2NmQ2RUZBYjd4cGd6Qlliak1Sd2Fm?=
 =?utf-8?B?U1ZwVXV3TkFXZHRYZ21XSCs4Q0hnQko4dDRkRFIydXp6d1RHRW9qL3Ruc25L?=
 =?utf-8?B?OVMxNTRYdkRoWU9rY2FjekQzczEwdyszSFZHZngwRkl3cm5iM2pYN2hIanI2?=
 =?utf-8?B?ZU93MjNacUF6TFR0MWUwZVVjWUVSQy8yMW5TNGxkby9ac2lDb0Rtamd4UFhC?=
 =?utf-8?B?YnFvQXBYTE9kNTlnaFdBOEhrUzNoUCtTU2w2V0plNlRsM2RYVDBIUEdWZEFo?=
 =?utf-8?B?bFl4V1hGcmhuMGNDVG40QkR0NTJUWkZSNHBTTzFXQUNpeEZVLytBZTFFdWpT?=
 =?utf-8?B?S3VVTHBFeFJRb3dnSDFaSmtRaDZ1cHE2aHpiYm9hK1RETEp5WXpZanRpQUht?=
 =?utf-8?B?b2VWMW5GTEllNUJyZkd3OVRobHBUZHo1Z2J4ZFROb3R2cmhZeWJqdi9YTisx?=
 =?utf-8?B?a2U5OXgySWdaR2VTcXJXV2VWNmpGVWw1RURsRVNFNnliSkxyQnBjSTBpekhB?=
 =?utf-8?B?QzQ0SWpPWFFxT2xCemNmWDVXeUx1RUxOT0dlcWtUUlZ3anp4TlNmTzlEZFRS?=
 =?utf-8?B?YmtXOVEwTThEYXZ3N09LaEZ3cjRJQW5haWhubThBUHV2UStDOFBabnczZUJW?=
 =?utf-8?B?ZXVRNHkvMTBnWGpnMHFHWnFQdmhVeUJXWjR1WHcwaEZKck55bklIbXBCMlJp?=
 =?utf-8?B?Q3ZPOEtQTzk1Y2U5bGNuUUJnQXZDZS9RQkFFa1VnV2loc1N4R0dLVktBSVFC?=
 =?utf-8?B?RXVGdHJ6NjQ4WEQwNUxzTkVJVXY2b1kvSXd3OWljbFF5UUhkM3pqdnY3NWk2?=
 =?utf-8?B?c2xwSjNOWUJtTTI5SGtTK3ZMU3kyZlBzVEZra0F3d0xSQlFqczd2cVh2UW82?=
 =?utf-8?B?aDNoZi90MU51QXpTbWlCZW9qK0c1K0FJR2kxKytHVE9VdFlFMHRkVWZFR2ly?=
 =?utf-8?B?RytEenBoZ3VZclEzbmo3bzRzM1g0YlVBNTR6dkU1dE1QWTQ5VWxnRkk5WUZ1?=
 =?utf-8?B?SjM5azVNemhzb2U5b25xMUFYMkRZM2U2QTJhN3ZrMHZrTEZ1NS9CN2xxTEgz?=
 =?utf-8?B?M1FwTXVTSllPa1J5blYvSjJGQVhCWmUxMXlnSHJJeUVldERjSE5CelN2NGF5?=
 =?utf-8?B?ZjZaSFVTaEZwdmNwN3ZsaWdhZG9weUU4QlQ0WEdVeFpZU1RPOVcyNDI2Vlhu?=
 =?utf-8?B?ajBqOExLVk5uLzJNUjgwbVc4WDZwak0xUlhIYnRWaXkrT3VsODVWTFIwNFYz?=
 =?utf-8?B?aG9VRDROSjIvVFJUUXVwZml3TG1lcmx4NEd3OWtvclJkQWlFazdrSURJUkp0?=
 =?utf-8?B?YndtZ0VSckNDMHB4SUovNjFMK3dXMFkvd21Mb21IY0xrRmVpZWpkYTl5NGw4?=
 =?utf-8?B?YzVYR2xlZklRWFdTL0N3elZTWTZScVp3WnVKb1JOU2FaVGVrWkV5MHpFK1FX?=
 =?utf-8?B?cThZWEM4MVp3cGtmSWU1akhZbXhKSTZLa1RUUXRCVFBXbFpUck5JOFNTb0xV?=
 =?utf-8?B?ZVZZYndLQjVrMXBkQ2xqaU5pS0ZQYks4Vi9GQ0I3MVhUbDE3TS9RVnFvZjhm?=
 =?utf-8?B?SVJmV0VUMGdOeWdmQUpLaHViMVlZemVJR2tVM3BSMnVtbTBRTktiNHROaGw0?=
 =?utf-8?B?QXEzUDhwOGNmM09PZUZqUm40YXhPbVpVUnUwMmc2OVdjdkduOWpGRjlxY2pT?=
 =?utf-8?B?Wm5Ya2QrRWNHdVl1V01kUURrb0d4RFp0ZEo3cW1OUkpxYU9HUGVkVjJCcmdK?=
 =?utf-8?B?TjBJUURXN0RleStxWHBRb1VjcjdBeTdxMUdXcFlFcGJYdXdtemdhSFA1TG9M?=
 =?utf-8?B?U29qb2p6ZE13WmFlbnAvK0FzeEk0eDRWWjdHQi93U2lwZTlEeENqdVY4dkVP?=
 =?utf-8?B?TWdQZkpOT1N0NkpGT09OVVdYbHRoWEFvQm1yWGpFa1NNQkMxNWM5elA1Z0Nk?=
 =?utf-8?B?YlJEZ1pGL09tdmQ1ZUxtTmErNEJoTnRqOVAwVWxQbnFyZzhYNjh1NG9QVGdB?=
 =?utf-8?B?bHVQZldQbkN6bEtuOWQ0ODdDWWVtOEx4SllTSXpGWi80ZlhFR1VTOEp0aVp1?=
 =?utf-8?B?U29IOVVSSmhQVVA1MWxabHREYjc3L0wwVGp6YjFCVUpBNmsyZUVHeTA5Ym5O?=
 =?utf-8?B?TFU1cmRJOHIrcGF3WWJJVkxSdW9UZ3RXWHN5WG9PSkRNeUYvN254QUU2VFYx?=
 =?utf-8?B?dGc9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786a050a-8d22-4d09-3988-08dd0f0a4fb4
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 17:38:31.9391 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8Jwl3aZaEL7eCYsqDip/YSyobInD3k16eveTIfakF6D4yiSKkVIXewr1IqTMBjhQwNgSmOStV8qgBZwqLEJYb9kp79Gi5jrdZLCK2cbFWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5586
Received-SPF: pass client-ip=2a01:111:f403:2613::715;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
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

On 11/25/24 7:07 PM, Peter Xu wrote:
> On Mon, Nov 25, 2024 at 11:46:11AM -0300, Fabiano Rosas wrote:
>> Currently a VM that has been target of a migration using
>> late-block-activate will crash at the end of a new migration (with it
>> as source) when releasing ownership of the disks due to the VM having
>> never taken ownership of the disks in the first place.
>>
>> The issue is that late-block-activate expects a qmp_continue command
>> to be issued at some point on the destination VM after the migration
>> finishes. If the user decides to never continue the VM, but instead
>> issue a new migration, then bdrv_activate_all() will never be called
>> and the assert will be reached:
>>
>> bdrv_inactivate_recurse: Assertion `!(bs->open_flags &
>> BDRV_O_INACTIVE)' failed.
>>
>> Fix the issue by checking at the start of migration if the VM is
>> paused and call bdrv_activate_all() before migrating. Even if the
>> late-block-activate capability is not in play or if the VM has been
>> paused manually, there is no harm calling that function again.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  migration/migration.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index aedf7f0751..26af30137b 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -2029,6 +2029,25 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>>          return false;
>>      }
>>  
>> +    /*
>> +     * The VM might have been target of a previous migration. If it
>> +     * was in the paused state then nothing will have required the
>> +     * block layer to be activated. Do it now to ensure this QEMU
>> +     * instance owns the disk locks.
>> +     */
>> +    if (!resume && runstate_check(RUN_STATE_PAUSED)) {
> 
> I hope this will cover all the cases that QEMU could overlook.. or I'm not
> sure whether we could invoke bdrv_activate_all() unconditionally, as it
> looks like safe to be used if all disks are active already.
> 
> I wished we don't need to bother with disk activation status at all,
> because IIUC migration could work all fine even if all disks are inactivate
> when preparing migration.. hence such change always looks like a workaround
> of a separate issue.
> 
>> +        Error *local_err = NULL;
>> +
>> +        g_assert(bql_locked());
>> +
>> +        bdrv_activate_all(&local_err);
>> +        if (local_err) {
>> +            error_propagate(errp, local_err);
>> +            return false;
>> +        }
>> +        s->block_inactive = false;
> 
> This var so far was only used within one migration iteration, and the var
> was only set in migration_completion_precopy() so far.  Now we're resetting
> it upfront of a migration.  I'm not 100% sure if it's needed, or should be
> put somewhere else.
> 

This variable is unconditionally set in migration_completion_precopy()
and used as a flag for whether or not we should be deactivating disks in
qemu_savevm_state_complete_precopy():

>     /*                                                                              
>      * Inactivate disks except in COLO, and track that we have done so in order 
>      * to remember to reactivate them if migration fails or is cancelled.           
>      */                                                                             
>     s->block_inactive = !migrate_colo();                                            
>     migration_rate_set(RATE_LIMIT_DISABLED);                                                                                                                   
>     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,             
>                                              s->block_inactive);

Ideally we'd like to take our paused state into account right here and
skip inactivation.  However at this point during the 2nd migration (in
paused state) our current_run_state == RUN_STATE_FINISH_MIGRATE.  So if
we truly wanted to skip unnecessary bdrv_activate_all(), we'd have to
remember our paused state somewhere earlier on the call stack and pass
an additional flag for that. Personally I don't think this is any
cleaner than just blatantly calling bdrv_activate_all().

> In general, I saw the mention of other places that may also try to
> invalidate disks that used to be invalidated.  If that's the case, I wish
> we don't need to touch migration code at all, but instead if block layer
> can cope with "invalidate on top of invalidated disks" it'll be perfect.
> 

This sounds similar to my initial very naive fix, which we decided not
to take:
https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg04254.html

>> +    }
>> +
>>      return true;
>>  }
>>  
>> -- 
>> 2.35.3
>>
> 


