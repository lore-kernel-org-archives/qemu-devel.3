Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4285C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 08:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdQ38-0006mc-2u; Mon, 12 Aug 2024 04:05:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sdQ33-0006m3-PV
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:05:01 -0400
Received: from mail-vi1eur05on2111.outbound.protection.outlook.com
 ([40.107.21.111] helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1sdQ31-0000d2-Es
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 04:05:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wVjVI50HwyGpZ1tXw72E1LcbvIwvqVFIomriHOoC3wR0TJMsMeOJDudmRMWKig197yKwuAj8UbU6XY1UIomdfy5jTGjPmi/vfWz4mYYswutTv3n5hZ/12QEAuGWQbT2yHAUotw32mCfs3yFRYK4YOkouarkOGwOJb1KTf/Li+eThVe9J3EZIwseNRbONsz4hpbLr0Vq3PmNpYY6vsRYolO4k4LE9xztLVwpqNWJLDcN7Epf3Wv08aSJJDL46Q6VbHLtJEQf+xkY0YeKjAVIYWVJyerhLolWL5ZUknhL9svuknuTysu971pS8t50uSsW3dSzxsE8OOR4M+QkZsEaJkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RyZZZ5XXFbPnv6dSfcKsj42nFNF4kVyq3LcrbhFVT+g=;
 b=Ts6CayAvWnTB1Q0KwPADJ7OnMlHouT6cfG6UR1QA0dLigsYO/Z+L23N0sg10w8zFgjBUO0kqHjcfXgnPxuZPC4yDct8flYssX0PKyYvJGLckAegLKiUl/B6y+SHJj45UFwJ7mY1Xrn5fTYbBgDY99CPVzrbi5pdVRjVwsle1Fda6w5DWm5Fz/ZtLoXwyUaKb9dVKAZsdZpoBoN8UzZFuDt++XE5xw+AzJq6ANGKIvzHbWQ6Dz24vkBcAae8mJbex876y2NTdWGSNSwASm1IsMO3ob9FyhL3hJKfqabtzejF/sRzac66t9x5LylTHjCu93t/lX1EDZ53TvcFsU9W4Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RyZZZ5XXFbPnv6dSfcKsj42nFNF4kVyq3LcrbhFVT+g=;
 b=UrRvFv4/ukFHCsBE/P1OzvvWY6Ofl1dlhY8yQnOmiYdD3uuOQnX9yWch8zVYgxcV1UvLzowVivdsBJYyBQKaZmwiPcy45XpT6sAS3F3vyrixK9nciLgwrsTGapwTZ/Yf0A8Tzxn7p+Y/WJLMLyT+0vwybszgYKOzSCchFtoqAbrTIsEIYy8hbBFbEPUdJTrnxPCol+uqCddnej0JJXPxZ52Bh60k0coSZWV6UmXKyFQeLoaP7uMqFRx9rjlatK1XyUUwv/6yMM6aZxB7yFHjwzwPHSFyPTNOuAcgj1rnUgoSxshzXWDIJM9wQPopnjB2udGzKCMssLrLicJKgnouKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by DB9PR08MB9537.eurprd08.prod.outlook.com
 (2603:10a6:10:459::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.13; Mon, 12 Aug
 2024 07:59:48 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%5]) with mapi id 15.20.7875.012; Mon, 12 Aug 2024
 07:59:48 +0000
Message-ID: <b50dcbde-5221-4f4a-8f62-c348431a1408@virtuozzo.com>
Date: Mon, 12 Aug 2024 09:59:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] module: Prevent crash by resetting local_err in
 module_load_qom_all()
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: den@virtuozzo.com, andrey.drobyshev@virtuozzo.com, cfontana@suse.de,
 kraxel@redhat.com, laurent@vivier.eu, mjt@tls.msk.ru
References: <20240809121340.992049-1-alexander.ivanov@virtuozzo.com>
 <20240809121340.992049-2-alexander.ivanov@virtuozzo.com>
 <903e6896-47e1-450b-9164-314c8924304f@linaro.org>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <903e6896-47e1-450b-9164-314c8924304f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0019.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::31) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|DB9PR08MB9537:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c827313-9911-42dd-263f-08dcbaa4bc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SUZWT3NoQ0RsVlNJVWVTUU9PUlMwcEo4S09LVTJ0OVhNSCtCeHZ5OS9kampF?=
 =?utf-8?B?aGpZSXhVeWVrWkhSVElYQlAwNWx4bmdONERxTnliQ2JYSDFsTDNLR0svVnRv?=
 =?utf-8?B?VHlNTmFDK1o2TEFjL3FDbCtYdGQvclYycHhFOG9jRDZXSjJVWDJVUmwxdVBw?=
 =?utf-8?B?STBjMVQvWXdwcVpkOFB3STBDSERTblcwRW4rTjZ4RGdiaVpaRktRdHVZYVZO?=
 =?utf-8?B?YWpzTlRHWk1pcEY4ME83QUlRaTB0TU5NK2k0aGM0eU1CQzRBL3JBK3FHYTBr?=
 =?utf-8?B?LzNndlVERGRadVdpb1VPb2d2Qi9Tcm0wbUNhUTcwRnpwSWFadG4xUEp3MTBz?=
 =?utf-8?B?ZkZjZzV5L3pHSjNJSHowUFF4MlkzMUpOVXQ4MDllcmFVRzhNVHVGVXhwZUZ0?=
 =?utf-8?B?Y25BamE4a1I3T2x6QXM3cW8vS1RuTHZEOUJ4dzM2RnNCOGhSK1lpT1ZNN211?=
 =?utf-8?B?MDlaU3NQelQvR0s5cUxyaVlFMFRmNFZobGxEUzBVMEFHc1pOUTJsMzROeXc2?=
 =?utf-8?B?b3E2QW1GTnFveXRPWVhUaVAvSG84Q3lPZjZ2RkJjRnlURStyQ0kxWDBucVRj?=
 =?utf-8?B?QjNhelZQdW5oM3NQTUwyMHAyTW1mSlVPYnJRYVRVSjF2UDJoSllDNVZYY3h1?=
 =?utf-8?B?Q0EzN3Z3djRYNExyekRieW5kZ3Y0R3cwNXg1WnBGVzhXdW5FVVNPYkVHNitQ?=
 =?utf-8?B?UTlxTFZzRytFVkYrUnlFb045UzZ5MzB0STR0YWJEUWZCUVRTbXVFa1lhRHJz?=
 =?utf-8?B?STZUTWYvdDFJd3dZNmV6cGpnMldZaHp2cVlwcmV0cUVncTNSRVNQUy9OUHVt?=
 =?utf-8?B?TVhNdDNyQ1JuZDRHVm1FeWMzSy93em9XckR4RWI2cnErNzNuajRqVW4yRThF?=
 =?utf-8?B?blZHb09aZ1VBZlh5WExEUDRlR3BIN1Q2azZhY3l6QTRQaWhTcTV1V0ZQWm1T?=
 =?utf-8?B?dW44dnB2TmE1czQrMEhEQ0M1alpaRjdPaEZxdGdlbmdDdis1YWM4VFhHZWxJ?=
 =?utf-8?B?RWN0aWpnUGs1U296dlFFRUwzbGRhTE9QZnViRkhscThnL21nUTJveHZ5Vmhh?=
 =?utf-8?B?NDJPTGJ2SHRxaXFLYUJMeGZoTTl2MldoWitDN3o3SXlNUXpwZFA1c1cyT1U1?=
 =?utf-8?B?aDVUa3RMbnZTenFHMWNKMEdIdDdKTnJPQnlnODl3M09SeXFjTXc5MnNkS0E1?=
 =?utf-8?B?dlEvV25ybi9Jb2hlemdnVnU5RUdYbGlyQ0xmNy9mOW01REw4L3JiMnc0OWJH?=
 =?utf-8?B?NnpML0VZdHByN1lEZXRlSmNMZkU0aytWT2trUE5oK2FsRDd4OGV0YUEyd2JN?=
 =?utf-8?B?YjJXRlpscmNrTHltSU5mUnhydGhqRlFVZ1Z1dmY5dnJITnhvVTFSbmZHZGVV?=
 =?utf-8?B?aExTYW9tOXRHTXlWa05kcFhOeU1PVkQ5RFZJUmgxUEx6ZnNBd201aW8yUGZ5?=
 =?utf-8?B?VXBzYmhuWC9DbWE4aEVHU1lGaWUzZVNyc2hhZmIwZ3EwVG1xK015UVcvZ2VP?=
 =?utf-8?B?NjlEWUIrUkNtMGF3R3VhUmR3aFJyMVgwRVdaTmlKT1BTdVhPYzdIOFJNcE16?=
 =?utf-8?B?cFZnb3hVQXdjWVo5OGozdUIzdmpGektOd2lsbmpQMVVyb1ZmV2ZBYzNkaGE1?=
 =?utf-8?B?d0FRSGh3TVdvZGhOTjlWNTVEcXhJeExxR1RZaytxMXVvWjMwa1hPbzVoLy9q?=
 =?utf-8?B?dVQ5TXprNFhyb1dCdnkvOUc3V0FQbWpFY2VzMS9xQTdsVWVwWXM5T0trcVhi?=
 =?utf-8?B?VmNWOW1VV1RTUzh0K3dYcks3TS91ejUraHVYdUZGVnQ5ODJYWHNZMjI2R3dD?=
 =?utf-8?B?Z0Ywa1RjYlJxS0lzbkJ6QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWl0Y0tvTzl1aDNGMUI1cnZIN2N0ckNmWUIvMmxXaFZUTVhPaFJvNG1YeHNE?=
 =?utf-8?B?eS91TDBhemRWVEFXS1hFRWwxVnpJdWxsMGUzMmZKOFJFb0RjRFF2WVhyTTFZ?=
 =?utf-8?B?R2R4dHEvMkJ4YW9uaEkzNEtWaWM0MGViak5NS3FoTXNwcEk1cnkrTEswNExS?=
 =?utf-8?B?ME1oTzcrNUk4Si90elpuZFBnRUlIM20vVXhKUXhXZ0diRVhodDB1MTVIdENB?=
 =?utf-8?B?RVkyai84YS9kTlhwKzlzSVZzZTlRUDJXc2k5b3k2MTZHOUZaUDB6Z0syK0F4?=
 =?utf-8?B?K0V4TkNFbGVQdVk2a0dBM05KZTNDSWlrcXpNRVRGUFE3NmRCRTF3Z0s3Qlg2?=
 =?utf-8?B?UDlRUmcyT0Q2ZVIyVUloQ2szY1NGdVl1Q2VSMFYwNW5yZ1JtQVRuTVlWSXIz?=
 =?utf-8?B?Tkl1c3NUdGl0QXpjY3lRZFRrR21iUzdKbUpsdzRJTGJhZWYvUUFCeHA1T21V?=
 =?utf-8?B?KzltNTRpWUhTYzk4Qmh3SkNHczZ4ZEc0RnAwc250M24vWDFvd2o0TU9SUmo2?=
 =?utf-8?B?WXZjTWlTbjQxLzRtcmNrWkh1M1UrcTZmODFQV2ViN05OL3Bkek93MHczeGFj?=
 =?utf-8?B?OHF6UWV0Nlc0SjNWb2t3TjBCVWkvOTVhUUM5dU54WHpoeW1icUNSTWpKMGRu?=
 =?utf-8?B?ZzBQNmh0Q3VvQnpXK0xlMHhXOE1iVjlZcURlUy9jdEFzVWtCa2xkK00yUDlR?=
 =?utf-8?B?em1yc01ZUWtScGppSWZ0WGt4bEpTL3FtRWNBTktWaXRKWWpIQ0xBcVB0cWR1?=
 =?utf-8?B?aW4zSENwVXFVTUZ6VnhEL1RiUHhDSW5zd3NCMVlFMkVMbFRrSzErZ2RkR2Y5?=
 =?utf-8?B?MlZBM3R5S0lMMjZLS2E4NTVnYUxWRVRRemZzcVNzNHcrU1g4dU9zQk0zMUxi?=
 =?utf-8?B?b2JjV1hoMlFOSkRmQmFTbzJic295Wml5aVVoYnBkTEZiSnR5VWJCcnhnOGdv?=
 =?utf-8?B?QmNBdHVyRXg1UlYxQ2dnU0E5ZUJNZURNSzE0TTZ2MGJuT3RiOVExV0hPVmZa?=
 =?utf-8?B?dDZWWXlZNUZneng3c29Qdk9KbFdaeW82ZFdieHNhYXdBQlN6cFNPalZiR0Ur?=
 =?utf-8?B?VjUxaEVwbE1yQmJtSkVEc1pyM0MrS2RoWW1BcnR0a3p5R2IyaVZkRXI4eXlS?=
 =?utf-8?B?ZDFyYitvbnczVDZtZVkwcy9yTVdYM1A5VCtaellUS3hPdmtwa21IWkpLZU1v?=
 =?utf-8?B?NDRFY0szV25Yc05uM1d5NlhoQmlIQTZ2Qzd3VEtRekhZU3lJQWNNUUVWUTRZ?=
 =?utf-8?B?QUhmUFgxMFJmUXVRMHNZYUdnQVpzVEhmVXNpUHVyUWk3ZWgrSzQwTTdWNWUv?=
 =?utf-8?B?aFk4MkU2K05iMFMwdDgwMU12MFgxV25kQVp0WDlOVkhTZld2RHFNT0pSL0s0?=
 =?utf-8?B?UXBoa0t2YlkxYXVpV3hwaTltQUswdmd2NG9BQURrQUdXcGk3bmFhUURRT2ph?=
 =?utf-8?B?N2lpUEJMd0Z5d1VnVXlzeGswUGRhMkdKdVQ4T2lxVFdkcUFrQkF4ejZHelVT?=
 =?utf-8?B?cmFMaVJYLzlESHI2Nk5CR1BVczM3aWFmeDhmalZWUVJhK1VqMldLL3pqelhu?=
 =?utf-8?B?dmdndlRPZE0wVGVzci8rVmVaeHVWKzFtS0JEcnljNDNNTW44QWRFZnBLTXN4?=
 =?utf-8?B?Vk9LZGQybHcwSVQ0aURDRTdyK0tRekgxQTNmaDliUkhpUjI1YUtWWk9GVWZ0?=
 =?utf-8?B?Yk5kUGxxQjl4M1ByQjdtMWJoTnZucDNjTXRWZkdscmpoeDY5bW5IL1pJL0RV?=
 =?utf-8?B?bTFHbTE4SWgrODJVUkZlY0M1c0RHcWNsUmswUXlGVHl0Y3FwMlVMWmM4N3gx?=
 =?utf-8?B?TWZnVUVKdzRNK2FaZmdwdTYyQnF2NjRoWFIrMkxMcFRvTGFyMGhsK212UzVU?=
 =?utf-8?B?UDg2VkVncUNHMmJIYkhJeVc4NlNYb3lVcHVTMjg5aTFaa2hXb2xoM0ZzTERu?=
 =?utf-8?B?SmtPdmwrWFJvaTlVUkxMQlRNZzAvZkdQNmR6ZTByQXZSdTVpZTF6bGNtYTA0?=
 =?utf-8?B?dVJvWmt4NXFUSExnSXYxblBFeTA0UVNXZjI5RXgxTHhOZUJDK2tPSHQyREhr?=
 =?utf-8?B?OXhidWIyZklHR0x5aHY5VTZuR01sVkYwaHpDK2JTems3bS9UM1FDMFhsQUVZ?=
 =?utf-8?B?d2JqMFRqOUdVQnIwdnpIRnM1ZGdub2duZnV1cmV2MnowZVFuQ0RKVlVPMy9m?=
 =?utf-8?Q?w62dAa8dSLazDmcsRtBUEmg=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c827313-9911-42dd-263f-08dcbaa4bc84
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2024 07:59:48.1354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FidUVxhioAcKC+a6lLU/kC8fW8LmNGuC3sDSU0YrjK1rqbOySUwpqfJl1h2wHGggnquqTUZLvY6VkqScIXBsiiTBTabjoTQnFMfWGgs2Y5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9537
Received-SPF: pass client-ip=40.107.21.111;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

On 8/12/24 00:05, Richard Henderson wrote:
> On 8/9/24 22:13, Alexander Ivanov wrote:
>> Set local_err to NULL after it has been freed in error_report_err(). 
>> This
>> avoids triggering assert(*errp == NULL) failure in error_setv() when
>> local_err is reused in the loop.
>>
>> Signed-off-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
>> ---
>>   util/module.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/util/module.c b/util/module.c
>> index 32e263163c..3ff4aee2ca 100644
>> --- a/util/module.c
>> +++ b/util/module.c
>> @@ -369,6 +369,7 @@ void module_load_qom_all(void)
>>           }
>>           if (module_load("", modinfo->name, &local_err) < 0) {
>>               error_report_err(local_err);
>> +            local_err = NULL;
>>           }
>>       }
>>       module_loaded_qom_all = true;
>
> Better, IMO, to move local_err and its initialization into the loop.
Yes, I agree, it makes sense.
>
>
> r~

-- 
Best regards,
Alexander Ivanov


