Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A9DC54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 17:41:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI9uE-00050d-8K; Thu, 22 May 2025 13:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uI9uB-0004zv-Mo; Thu, 22 May 2025 13:40:31 -0400
Received: from mail-db8eur05on20730.outbound.protection.outlook.com
 ([2a01:111:f403:2614::730]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1uI9u9-0007UY-Ot; Thu, 22 May 2025 13:40:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QTl6huwPsL6xRVnur5c3+KL1aBKwF2JuEEN5TJJoo5FCsu/Ibn661i08YfQiI6ztONqqVAm2a1ryQpKT61F4gmCZAEc11yILLEll9uv1OSrj01n+MKjQqEcgYSScOeKTAa6w/ZeVVk0L6MsrSO9kZRX9gf9KdNRncMjrRnRHHp8cvCPzLydVgMb4rLDnnffQdNv+JqqeHKrq9wbDJD9PGRVdA3cBQOTmct5U0Hq0cmJ7TeGxpcofree7YORNUU4jeVco8JxYVzdwKldP6gKMMM6le6eJQXVLiqKqJCHidvrioMRBkoDVXJ2VR948LwNc2hlKukDlIcOKyhEC9RoXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w4GSanXZkLqHxTqPfAKtkDJ1hdkWgzo3Vx08JkDccg0=;
 b=ozanNKruW8pW0mjRncx5kpqkppcDK0cRARnZGT8L7QtHL3V6T1HmAF731gpTZwTJd70VB0fdr0IjivtqC02EjiCvEC673hyJXM4CC6ZhXUwTnqpG9St2yKbbEdLy4bU4LWqZv5Bq1tC+Ex0sAvzlVh0rR7Lp5TfV33NM92JC7BRXagGqbMB7D5dJ0rJ7SNUr5DcwfMBRRTwKPY/RhLfZOf8GehmXaTwdXerulqV6ggDvaGo67vhjnRmUuqC+dEGyab6c9NrUIjMYu3kRzsCtZD3AJ7Fy90K52Ce79bdftBK7lKmWCKAQ74nzrV1aJicDnKXK9Ts+uf24gexSJB5bzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w4GSanXZkLqHxTqPfAKtkDJ1hdkWgzo3Vx08JkDccg0=;
 b=lDM4TFR9m+yqXlSZsQ6u9CUgzZDEWrYUhhix03cRMgG7Pt/F2COD/QpPOEWIyZgyZLboQbXL561XlMH+AsyTPrlIN+3W5FFAePCjq5y9DA/7BDEIa3Bho9I4ZDfdQZVjI95v7EhwUDdBdIhR5nRaDYEOClVOZmpcGR1avXF+jAJKF9OqQEhr1zLQRtHZFUlAg0WIALj48dZMHxglIcg54wSTf1gbjk+U9b98hLJUns+OoK6yfoY5CdTQEhEbGXFHyuYFzHQ0rDQRc8ISa/DSCsvWOi8yxoNGxJIElsCsnZeGZIpbSdn/73+FRtjC4d6Vv7ahIGDbuWMu6K3UcDgoxw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com (2603:10a6:10:52d::7)
 by AM9PR08MB6641.eurprd08.prod.outlook.com (2603:10a6:20b:306::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 17:40:26 +0000
Received: from DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::b0a0:bda8:8808:adab]) by DBBPR08MB10650.eurprd08.prod.outlook.com
 ([fe80::b0a0:bda8:8808:adab%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 17:40:26 +0000
Message-ID: <3233ad9b-028f-4136-9391-2130ecd5d4fe@virtuozzo.com>
Date: Thu, 22 May 2025 20:38:34 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] nbd: Add multi-conn option
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Richard W.M. Jones" <rjones@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20250428185246.492388-6-eblake@redhat.com>
 <20250428185246.492388-7-eblake@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <20250428185246.492388-7-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0115.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::14) To DBBPR08MB10650.eurprd08.prod.outlook.com
 (2603:10a6:10:52d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR08MB10650:EE_|AM9PR08MB6641:EE_
X-MS-Office365-Filtering-Correlation-Id: 17469a65-8ab3-4686-c3ff-08dd9957bc92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzV5ZTB5dEJHUlk3bmMvTUthREh0Nk1wYUpXdkxzQTE4R0w1eEhXaHE4SmhN?=
 =?utf-8?B?NTBzckM0QjIrUHNuOFlEVlVUOTVxZ3BiZGp0WjNPYzU5REZyQ2pvSDVVeWla?=
 =?utf-8?B?aXZLeXp6QlcwbFA0SnJxRXVONkVFQzJoS1BpY1Rla3FjdGUyWVhoeWhDeUsr?=
 =?utf-8?B?dkdXN2pkUHpnbTlYY2loTXE3bHFlR2hteitRay95MitkWW1KTGJSMVdBbU52?=
 =?utf-8?B?KzQ3ZTFNMHlQR2dBZEdDNUYrQWh4U0J5dWdWQkRnSnpJdzBLTG9RV093TGpH?=
 =?utf-8?B?bGwrQUMvKy9uWUVuWkZWcTZMOThZZVc3aGhic1RsTkZWNnBaT3k1ZHFMTDBo?=
 =?utf-8?B?WjRpc2RPUlh6VVJVa053OS9DZ1d1NGUwc3JnNitRVGc1MFcwem1YZlhOM3J5?=
 =?utf-8?B?Y3lDU0xkRkkzU1ZqTDdlcGtvMEJJajlWL0hUQVEwWVhXTlBESWJ4UnlRUkJD?=
 =?utf-8?B?UjJQeGkxQnlIL1VrN0ZUbWo3akJ3YTNEMHR2QmtrTVJiRHI0TUhUQVlWNCtS?=
 =?utf-8?B?R0dzSk9RVTVScitBNEE0UEJhT0xoeVIrN1RKaHp3MGhmeDJIWWVheWFhQ3k5?=
 =?utf-8?B?d2oxblcvRElOTDhPVnE5MmpNK0lKVTN1aXRocmxNRUpBQ1NjaFJLU3VtcE8r?=
 =?utf-8?B?c0llM3JEZmthVHd1QUt0RHloTi9pK0EzMW5YMkQrVkFDdWovL3lXd0RBbmc4?=
 =?utf-8?B?QzNsWVhlWEFpOTZ3dnkyVUpRRG9FRENndHo4WWJHSTNhNzNNcUp3M3NqWVE1?=
 =?utf-8?B?UEFyZkdaeVBOb3VCdXRtS0Y2clk4UE9HNzE4MlJqSG5zNXhEbmFDMWRMZTNw?=
 =?utf-8?B?bkNjT01ESWsxTW1kaERLcmk0Wk44ODh3UEU2UDMvNjZpZis5NE5PVHFweWky?=
 =?utf-8?B?WGZOcGxFRE52dzJSV0xtOTloeVBZNm4zMk1OK2RzN3dmaHhPSzEyODBndjBB?=
 =?utf-8?B?SFJvdmc5TnNncnk1c1JJNHd6dytjUE9ERTRCZ2hyTExlcWVPbUwyYXlrK2Y3?=
 =?utf-8?B?NWhMR3p4QWMybGJwMC9hcS82U3NPS0JvZ0NkN1RsakNmUW9mcUpXelJqQVVP?=
 =?utf-8?B?VXNxR1U3RzFTcDRMcnRYeDJHZ0s0RWdwQTBXaHBWaWI4aXNrVlk2SDFjMkNh?=
 =?utf-8?B?RjhKQkFPai9PSmYvY0x0U1VUNUlBNkFwK1FvOWQ5eE92bWtXMHZTMXMvSC9i?=
 =?utf-8?B?dDNIUFJVWXJuYytVUjFZcE9ZRG4xaUo5R1hvOVcxODBBY1ZMckozVVVxNS9u?=
 =?utf-8?B?TkIrOE5zQXlGR2VrbmxUS1l1K3VWVSt4eFRNWVBPQmVaVXZmYXRlMEpGUis1?=
 =?utf-8?B?WC9IZng5ZlBKQlVBbHloaCtKbHZyWVRGM0I1bS9qQWFFRGx1cXBwK3J0Y3hr?=
 =?utf-8?B?VXlRQ01KWTMwZ1ZRenRQTU1IaWg2WHNqK29wWWVFQSt0ZWV0KzhuOTNjK2xO?=
 =?utf-8?B?R1o4YUVUTk5iNkc1QVdUdWtBc1FiVlNGZUp3WG5hU29LY1NxNnY2Rk1rdEVw?=
 =?utf-8?B?bjl0dkRrTnFYalc3M3FiZW4zRzhjUm5oN2pBOGdMOVpJWDdISnczbTMzUzJH?=
 =?utf-8?B?OFVKcG9aWWhpT1dYR0dzekh2aDNWRGZSK3MxWFFEM1ZNaTFncFozNjlJSE5U?=
 =?utf-8?B?RFZsMTE0eTJISGN3OGRRKzlGL1hrYjFDeGdZcjVHUEd6MEJ3eTB3OFA1aVQ3?=
 =?utf-8?B?MkQvbnhNTm8weHhObld6cjJZY2pMNlNUbTZwK0EySXJGMVA0VUVLRzFHenVN?=
 =?utf-8?B?ciszRjZBSlo5d0haSHhaeDJZRU1vaFNidGdpTjdyWjdUUGlnS3p0VTVIZkJH?=
 =?utf-8?B?eE5JQVcxaFNWdG9TbTA2eWpIaU1Ma0dqK0hCTUoxWmNLOHpINUFTMUZKNHJL?=
 =?utf-8?B?eEpTN0o4YmRjMi95emdtaDR1YVpUNUY3OGt3RlQ4Mi9tN3h4S05zZU1vb2Rj?=
 =?utf-8?Q?aMk01NRZnSg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR08MB10650.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJOQlR6MUptZy9IZENveXVySkQxRDZLUjV2a1Z2SlNFdGdNWXlvQVA3Mnk1?=
 =?utf-8?B?amRuSGtscktjdEEzYk9zazU1RklmWTZNRUhOL1Y4bkZaL0Z1K2pQQnlHV2k4?=
 =?utf-8?B?MFZZYkVHWXBpL2xQY1RsaHU3OEhhc2VBTkJCYXdzMmE1bVNUbFAvdGQ1TWFZ?=
 =?utf-8?B?cGlSUE04NnJveWtVMDJLS25GTUhocUFDZjkzaHZBMkZIRC95blgvUTZlbUwz?=
 =?utf-8?B?U3RyS0Nnd1ZTdm1LU0VPL3IxWGRvREJpWHI5Wk9hNWxXc3JTQUhYSVRXaVgy?=
 =?utf-8?B?MWlwM1pzQ3V5Rmc1N2ZVem5LeGJLU1F1SVBSZ1pYZ0lwdXp2QW16R3ZhcTdL?=
 =?utf-8?B?NkRuQTk1eVVSM0tWYlZvWnNSK1pLRjB4MWxmcXVYNXg2V3Q1YWlVYjhaWjZ6?=
 =?utf-8?B?dXB4enliRmRlVm9sL096bFJBd1JLZTJqM01WVkpReWliY3lONGg2c3Rmajhu?=
 =?utf-8?B?elJ3QVJzU1lCUlMvVGZyMXhQVWN6bmpPWEtyT0NYOUJ0WGJCbFRtbWRqTHFW?=
 =?utf-8?B?SjVWOUNMUUFzN3BJR2pPc0tlTWszOG9uRW1lVHkxOG1ON1dOemxDTENzM3E3?=
 =?utf-8?B?U0UxeEV1Q0p0RlozZU5SalJERndJVnN3YUxCak40MUw1TDVrZjhseW9LYXRo?=
 =?utf-8?B?VlpnTW9nWW5aN213TWZTcWtFaVNCYjd0VEFSWTlWV2NoNkl4ZkpsV1l2QWRD?=
 =?utf-8?B?UnJseXk4eEpIc1RyOXdDa0E5NVRjOGRReEtwUTRjbHp1SFNycXpjU3R5QStu?=
 =?utf-8?B?MXhsT1huMitwREVWOEwzNThrTWVJMTNRM2FXUkorQitxTncwZ3UxZzFWN3o1?=
 =?utf-8?B?OVdwemNaSTJ2RFQ0eXJYWldhYW1hRWk1SExVckd6bC82MHRUaHJTNE44Q0RH?=
 =?utf-8?B?eFJid2JQSkZhMGZabytyNXNON2JuQjZrMXlDdWdzdkV0eitaWDhIK0l2cWdC?=
 =?utf-8?B?dDNFU3RpaC9uNVAyVDduMGdtbmlua0Z0UFJTd1FnR01nY3ZEMjhGQjdjRnFW?=
 =?utf-8?B?aTJDZWhqLzZDcEpZUUZTcUtoSWVFMUFYTlJFOFh5U2dOYk1vZkVzYWkwV0RR?=
 =?utf-8?B?K1RYUWcxaGgzM0Y4Nm9hNFhNZHBDc0NmNUR5OGZMSzVySkFZUUtCMXRkRU9q?=
 =?utf-8?B?dkdkUWpUN2xONGZjM2NlRG50dkZQcTRKNW1sNUVLQVc0aUdGTk1LZGM2ejVC?=
 =?utf-8?B?MlkxTkRNb3g3NTRXbjZwblNhcWdKNHN3S1p0d05MMWFDNXlLeStnR2JjVVVk?=
 =?utf-8?B?WDlSdjdpdzZuWTRZMnh4bkd3cDR5b0hmTjJGc3dTaHlGMDNqVDdsQVNUSkZu?=
 =?utf-8?B?Y3l2bTRBd3RRSHFmNUtpaERWTXZzTmRVM1IvKys0aXlQUGVTMnZxMldPcFRN?=
 =?utf-8?B?OTd4UitsVS9Pb0VtQWFEZ0hDOUIxZnd5NVpVSUlIdC9SbElKQWJKa0lhNHZC?=
 =?utf-8?B?WWo5K2pRaURWekxkNWl0WmdvNldiYXdUZTVOZkMxdzViWXVyY2xCZWxiR1Vh?=
 =?utf-8?B?Q3RkYjlGbThhT2VGQjhaTGFKZTErQ21GUUdEczB3ckNiNXp1c3M3ZjIyeUZj?=
 =?utf-8?B?a1BiN3kwN0ZzWXhGOHBEKzlYYWd6UUtOSTRKKzZCajU4cDlWcmxMQVY2emxm?=
 =?utf-8?B?NDh6MjRselJSRlE1SS9MSFA2VzhieDJjbzRxS0Z6dDVIQkZ6SXBDdzVqSzQx?=
 =?utf-8?B?TnZJbmp6VXRRMGhQUERQOGphRzlNKzU3V0dsdnBIeHV6RE5nVit5b1hJZFJz?=
 =?utf-8?B?SmlnNVdiby9CVDg0ZDVQaUhWTDF0WDVvRDdMRFRmMkh2b3ZkZk5zc3pZcXlq?=
 =?utf-8?B?azhocjZNcW9NSXdGMkFQSTZFdXJNci90dkJ4MkZqbXY5R0o1bmxNMzdxbk5n?=
 =?utf-8?B?ZUJMQVg2Ujd3bHRjeXZGZ0RrYjlPSExvTWdsOWpFNHV1Y3lQSE5LQXNsWE9K?=
 =?utf-8?B?MmFXVnNKSXpaNGtxT2hGN1diK2JUK1RHZzNXaTVxVmhudnlvM3A0cE1YaG5O?=
 =?utf-8?B?Ty9aNlU2d2FRZm53d0lwcjUwVlhaZ25CK1RPblFoUlNHbGFJTzYxMXBrc2VR?=
 =?utf-8?B?anAvRS9qOUx1dXhpd2NMekZwNlNJcVVhZ05oRlYzY0swWTNScy92elZ6cllm?=
 =?utf-8?B?Mnhpakhlb0daRitURG5PWHYzRjhjOVcyVUp2M1BQRjZvUWUvM1JLVkxENHZh?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17469a65-8ab3-4686-c3ff-08dd9957bc92
X-MS-Exchange-CrossTenant-AuthSource: DBBPR08MB10650.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 17:40:26.3139 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7X74QYNrt8+DFP0vh1HNE9r9I1c4TTpShjlGPy/OXcUo3+ovY6Zoq3R6I/65HTDgspCQpjCJNB9x2s1hBB5cuOvsisFW6yPkQnv92X62BEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR08MB6641
Received-SPF: pass client-ip=2a01:111:f403:2614::730;
 envelope-from=andrey.drobyshev@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
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

On 4/28/25 9:46 PM, Eric Blake wrote:
> From: "Richard W.M. Jones" <rjones@redhat.com>
> 
> Add multi-conn option to the NBD client.  This commit just adds the
> option, it is not functional.
> 
> Setting this to a value > 1 permits multiple connections to the NBD
> server; a typical value might be 4.  The default is 1, meaning only a
> single connection is made.  If the NBD server does not advertise that
> it is safe for multi-conn then this setting is forced to 1.
> 
> Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> [eblake: also expose it through QMP]
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  qapi/block-core.json |  8 +++++++-
>  block/nbd.c          | 24 ++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>

Pardon my nitpicking, but it seems to me that the name "multi-conn"
doesn't really suggest "number of simultaneous NBD client connections",
especially when similarly named NBD_FLAG_CAN_MULTI_CONN_BIT represents
binary logic: supported or not supported.  Maybe smth like
"multi_conns_num" would be better? Or anything else as long as it's
clear it's an int, not bool.

> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 7f70ec6d3cb..5c10824f35b 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -4545,6 +4545,11 @@
>  #     until successful or until @open-timeout seconds have elapsed.
>  #     Default 0 (Since 7.0)
>  #
> +# @multi-conn: Request the number of parallel client connections to make
> +#     to the server, up to 16.  If the server does not advertise support
> +#     for multiple connections, or if this value is 0 or 1, all traffic
> +#     is sent through a single connection.  Default 1 (Since 10.1)
> +#
>  # Features:
>  #
>  # @unstable: Member @x-dirty-bitmap is experimental.
> @@ -4558,7 +4563,8 @@
>              '*tls-hostname': 'str',
>              '*x-dirty-bitmap': { 'type': 'str', 'features': [ 'unstable' ] },
>              '*reconnect-delay': 'uint32',
> -            '*open-timeout': 'uint32' } }
> +            '*open-timeout': 'uint32',
> +            '*multi-conn': 'uint32' } }
> 
>  ##
>  # @BlockdevOptionsRaw:
> diff --git a/block/nbd.c b/block/nbd.c
> index d5a2b21c6d1..5eb00e360af 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -48,6 +48,7 @@
> 
>  #define EN_OPTSTR ":exportname="
>  #define MAX_NBD_REQUESTS    16
> +#define MAX_MULTI_CONN      16
> 
>  #define COOKIE_TO_INDEX(cookie) ((cookie) - 1)
>  #define INDEX_TO_COOKIE(index)  ((index) + 1)
> @@ -97,6 +98,7 @@ typedef struct BDRVNBDState {
>      /* Connection parameters */
>      uint32_t reconnect_delay;
>      uint32_t open_timeout;
> +    uint32_t multi_conn;
>      SocketAddress *saddr;
>      char *export;
>      char *tlscredsid;
> @@ -1840,6 +1842,15 @@ static QemuOptsList nbd_runtime_opts = {
>                      "attempts until successful or until @open-timeout seconds "
>                      "have elapsed. Default 0",
>          },
> +        {
> +            .name = "multi-conn",
> +            .type = QEMU_OPT_NUMBER,
> +            .help = "If > 1 permit up to this number of connections to the "
> +                    "server. The server must also advertise multi-conn "
> +                    "support.  If <= 1, only a single connection is made "
> +                    "to the server even if the server advertises multi-conn. "
> +                    "Default 1",
> +        },
>          { /* end of list */ }
>      },
>  };
> @@ -1895,6 +1906,10 @@ static int nbd_process_options(BlockDriverState *bs, QDict *options,
> 
>      s->reconnect_delay = qemu_opt_get_number(opts, "reconnect-delay", 0);
>      s->open_timeout = qemu_opt_get_number(opts, "open-timeout", 0);
> +    s->multi_conn = qemu_opt_get_number(opts, "multi-conn", 1);
> +    if (s->multi_conn > MAX_MULTI_CONN) {
> +        s->multi_conn = MAX_MULTI_CONN;
> +    }
> 

I agree with Markus that this setting value different from what's been
directly requested by user shouldn't go silent.  Having some kind of
warning at the very least would be nice.

>      ret = 0;
> 
> @@ -1949,6 +1964,15 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
> 
>      nbd_client_connection_enable_retry(s->conn);
> 
> +    /*
> +     * We set s->multi_conn in nbd_process_options above, but now that
> +     * we have connected if the server doesn't advertise that it is
> +     * safe for multi-conn, force it to 1.
> +     */
> +    if (!(s->info.flags & NBD_FLAG_CAN_MULTI_CONN)) {
> +        s->multi_conn = 1;
> +    }

Same here.

> +
>      return 0;
> 
>  fail:


