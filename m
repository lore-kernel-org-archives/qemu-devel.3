Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 778D0C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saxFl-0005Z6-ML; Mon, 05 Aug 2024 08:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1saxFh-0005Qf-FV; Mon, 05 Aug 2024 08:55:54 -0400
Received: from mail-am0eur02on20713.outbound.protection.outlook.com
 ([2a01:111:f403:2606::713]
 helo=EUR02-AM0-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.drobyshev@virtuozzo.com>)
 id 1saxFd-0007Hg-Un; Mon, 05 Aug 2024 08:55:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RCK0df5WkwIfUWR8m2qGe8N+SjBGM/tVWDq9epVJpLAiR254f0FuFRnztDkZ1uwd3kY6yn2euS0u3E1mfi7zkt8hMT3ebvhYBLbZELnPT+xutvgx+iJPFniEzd2A6B80udSyxbXuGm/aK3l1cHWkP4allX/JFmQy3K4RA0Ptv4tTN+XQ7iwUWEblTRiAxS8fBnqEaWUtaHVGxtEgNdjIFuMA4LDiHHbjsho2q56enceWFvDzo/QaYA9hOaXUs2IW9fFeV5wqsB08VSUYFx445iAzGw7HT2gc0qOFlZO6xt0O+pLbpq/9R3azNyYBvxQi15iliMp0c13lJsZLWuSW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=91BhOyjyXb7X6y1WiWTEo9iN1lHoeK6IDr/4kOlp1Oo=;
 b=dZHtkqJTyPX5JnpG2r8/CL+rNvncsNYX/WQ41cQc79v2Vff6WBeLtusgT6r01AVs5GUYR+4GOTGMQRZvouHoiMFcDA3USsh4WvtVwiww5LWpI9ppG75ij+Z4QzfH0Euo3euNrxoSubr3fCAdDLVSTpIl9SiLtZdRPqZvnqCho2lGrNNg0DnhUz3yEjDWMpHAt9otaI98TieAIcQDa6dbiX61iyO6k9ID+wjrYLXOvXZdFCvSQ71HCqPVnsodHochglaAKfYsEZW/KWuWMtrNnLIgOgxc89pnTkrKv6+CDbBZXsZZCcJ2+R9UMtpHYAtbgmGnkvxZQrdS3JnC/Zsf7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=91BhOyjyXb7X6y1WiWTEo9iN1lHoeK6IDr/4kOlp1Oo=;
 b=mDcfLqzq9OQdsIRtWaegZupr5Kao4n01Y5xyCdvHviXQGYm4e2w7o+oWLjehNKcRREFfKokV59M9HDQ45BeU+0sRcISd1ec7EV6jhUuAQHCH/HWXZtu746T9CF1EHW1uIzlg1IQsPToF8TseRDDERqVQPjWxtVSRr8gK+LMP6LQpxCFzO0qL0Dn6cxoEYf63ulye2uVazOUazrlLrTrDgzttccGUETK90klYHbiRFiLCazZCcnF25XTgYjG24Gtf0ct8C/x/oYwiISpVd8VPy4rCGdthlFYdEUWTr0TOArvgK5Hgcxvc4JWa4sQ/YCC1eupeh6phqAqG9Rgr7JbQmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12) by DBBPR08MB6252.eurprd08.prod.outlook.com
 (2603:10a6:10:20b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Mon, 5 Aug
 2024 12:55:43 +0000
Received: from VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7]) by VI0PR08MB10656.eurprd08.prod.outlook.com
 ([fe80::7f30:b6c:9887:74a7%3]) with mapi id 15.20.7828.023; Mon, 5 Aug 2024
 12:55:43 +0000
Message-ID: <9b44493d-2955-4c8c-a6a3-367335cdb3e7@virtuozzo.com>
Date: Mon, 5 Aug 2024 15:56:05 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] iotests/298: add testcase for async writes with
 preallocation filter
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 den@virtuozzo.com
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-3-andrey.drobyshev@virtuozzo.com>
 <ZrC_6jb8M6YU1AfQ@redhat.com>
Content-Language: en-US
From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
In-Reply-To: <ZrC_6jb8M6YU1AfQ@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR2P278CA0084.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:65::8) To VI0PR08MB10656.eurprd08.prod.outlook.com
 (2603:10a6:800:20a::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10656:EE_|DBBPR08MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: d00ec18d-d68d-4df1-6892-08dcb54dea6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UnN3Sm5FOWkwQ1RGanJQWVAwb1hPWHNqUlYzTVgvUTFxQ1o4WDZrdnpEZHJn?=
 =?utf-8?B?WkJxVE5IUzltaVFiSWlwRGFIdXRvL2hYTjZZUTBrcTQ5TlB5R3o1QWxzN0Nt?=
 =?utf-8?B?RzExbEJoTkltc3ZSZklMbnhqbDcrN1VmdzFqRmZOY1ZPQ2huNk1QTU5vVWxm?=
 =?utf-8?B?dXpXdVd2MUZuNDhiNGFSRTNzTjVqelFjcGtVaUxDMUJvei96TEprZXdlWnhk?=
 =?utf-8?B?L2NUT2hwcHV0Y3dWNmd4VTNrdmgxN2VNcG5wcExaNEIrZTg3TDR2NDlKbjlU?=
 =?utf-8?B?ekRSbkhpK24vOW8ydWJSOStWbUNKSzY5VWlsUjVUQnpCNm9yMjlBQThOZkpI?=
 =?utf-8?B?dXE2Yk8rVHNzTGpNcytiVm9ET2JYQkxlYVJib1hQQW9ubUJMcEVjc2pkNnIx?=
 =?utf-8?B?VHhjQjlSS3Z6VkUxeXltSnVJZkMvd3N3ODIvWlFEeVhhSnZJblAwN1M5SmE0?=
 =?utf-8?B?UUg0MlhpTU5PN3JmdzNPQ3gxRkg3WlYrdVdlVGtIaEdnYUJDU3k1Wnc0dDc2?=
 =?utf-8?B?UGJzWGdFekMzckhHLzFiS05meGtNNEZ4eXdsb3FZNmNvSHcvSTJERk9jQktF?=
 =?utf-8?B?bzYzMUJDOTVUUi9TWHlLK1U5WTdVU25kMFNlNVpsOXRwR1JsZWxFU2tVUDR5?=
 =?utf-8?B?dzN1TU9sTzkwOFI5MUVZeGo0VmYrQ2ZpRzZSMnhkZWNZZ04zR3hEQTlqZExq?=
 =?utf-8?B?OGIvVmt6YlY0WUsyQjlESkZndjMzRFdxczZqMFlKTU16dzRBdVczNlQzUmdB?=
 =?utf-8?B?SWFUbzQ4WjM1Q2V3UmU2RmNGbXl3OC90YTZkK29mQktOS3hpbFBiY0RjcGEw?=
 =?utf-8?B?bWRvbStER3F2eVVwU0t4aHdFNUNIYUlDckJOOXVaU2VFVTZiVU5mY3FSeGE0?=
 =?utf-8?B?NXN4SW1qbWd0V0lhT2lDajIzZ3ZERW1ncjRKbzk5dWRQV0dTRUluMWVaWStR?=
 =?utf-8?B?WDJoOWVscU1ZbmJWVTI5WjdzQ2JHNm82UW51elVleFEyT3lPeHlXS3hnR3FV?=
 =?utf-8?B?U1A5RFhaenBiQVZUbnY5NjhGYk9SeElVUlQ1LzhDN25ON21ld3E0bTBWSVYx?=
 =?utf-8?B?UE4zdjRTQ05uMXZyZkVXWnhvVk5tRzJReXZtOEZKZUNuY2hGV3RrMFRVYWli?=
 =?utf-8?B?bDhPZlhhWlNjQ3R4dnNqT1NwYkprNXArcWo5clAySHlmT2tuTzc4K1VYRTlW?=
 =?utf-8?B?c3I3MlFndXBIcGd2d2M4MkpySC94NUlUc0JFRElaeXdLZ3hJbkJENXBqLzNO?=
 =?utf-8?B?eGhrNUVlYkFwaEZjR2IrT0IxaGxEcGt1V3ViUmhsSEZYZTNZN3hzbmhySVUw?=
 =?utf-8?B?MnhSaEt6aEVCdzg4Z21XQjdLbEFueW9rc3Z4cE1nSWV4Qkc5Umdiak0wWFVs?=
 =?utf-8?B?WE1JdS9GY2MreCtPR3BvL081TDBIQkNEb0N0RTRzUm5WRWhFVmtUMXlsdmo2?=
 =?utf-8?B?L3k2WkRmMXg0NFU1OTg0Szd3SU4zelRBelNVNmVxT1lTMnJ0cFlUNHp2L05T?=
 =?utf-8?B?c1cwTG1sTk1IQ3JDclRiQ0NraktVaS9qMnZCYzkwMUc2K2EvckVaWlU3UEtP?=
 =?utf-8?B?Q09EdkE1cjFKa1IxNEVkSlZtNVBnQ0tUTHZJQmp1QTlObWtiU3g3UmJZdW5W?=
 =?utf-8?B?VGZJV2xOa29NaDRlamQ3dkpoNVI4QlppMktyZVErMGRWUldlWEpadFA2ZnFi?=
 =?utf-8?B?ZVYraDVaV2hTSFkxb3ZYVG40LytxUm5pYU5KdnIwVDdPVTJZK05YMDFMdyta?=
 =?utf-8?Q?9paOVxYauryHbxU6pA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10656.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T0U0Mk1ld1JteWxyNmY0NjU1K0JDSGdyVVpEY0FiV293WHpCZGhIbVJkS21K?=
 =?utf-8?B?eGNyb2VlT3hkQmwxbnRscHJ1ZjZqbkIwR3pYdWYyL2J5cm9SVlFnemkyR0Zn?=
 =?utf-8?B?NmRsY3dCQWpUNGFsRW9BZVcwNHBQb3pvaHA1U0hqTFIzU0dJekM4SVVkY2Nz?=
 =?utf-8?B?Wmh1alFDR0RoVmxMdUpQejVGZHg3eEJrS2h2dWI5eGdoa0hEdDJmeWwrSW5S?=
 =?utf-8?B?eGVNMmYwdi95VFZCdmlObjR2bkNJQ1o4NEs3NEo5ajIzc0hqSjR5NkpFN1Zq?=
 =?utf-8?B?MWVXWDJDWXAwQm96cGlSaFRqamljaXBWMTB4YWgzUWFncGc3YTJ5OWJkTWRN?=
 =?utf-8?B?U3FSV3FBMWQrbmp5WjFUM0ZDZEdpeDRoZ0RjaXNRbmhlNlFLR01iR003UGpN?=
 =?utf-8?B?eFZMcmM5NGh0dWd3c3B0dVNibStZc0RxM0NqUkpsdys3cFcrdEJQbjBvazBV?=
 =?utf-8?B?UmRSbjRPSFQvUFFwbkd1NVpCeVdrMnY1QXAwRUVSZHpqaG1ZM1lRdFVxekxj?=
 =?utf-8?B?MUR1azJOd1U0anpVeUhIN1JTMit4QURuNFhXVEh0QnQ1bmZ5a2IwU1p4YkM1?=
 =?utf-8?B?a2RjRHZLdUg2NjdBT2ttd0FlNFpDK2M3L3c5ZFR1bTdOc3d6Z0hMUjV5M1BF?=
 =?utf-8?B?MmxRcnlHZUtCa1JQRlFKallmYis4V25iUHRTekNMaVR6c3BGMXBHdXFVOWFL?=
 =?utf-8?B?VmszUUQ5YkFvSGpHaGJLSm93U1Q0dWtRanBhYTFGbzJOcERaVGc3QU1mL1pW?=
 =?utf-8?B?NmxPTjVQbTBTaWl6Wko3K0ZwcW0xTTRrSmdvKytEMWhZM3p6RVQ0ZlVnbE1P?=
 =?utf-8?B?aTI0L3NaWXU1WGNMdnhzYmFUM3FQK2RsNnBnTlVYWVhZZWtnMVhTaWJ6VVBz?=
 =?utf-8?B?UHhwUElWanZ3VjVnNnZjTGIwUy9hSlpzSndoMGtPbjNnTUJWaWlXY3F1TFRC?=
 =?utf-8?B?S3BYWUxIZGZoUUk0amx5R21qODJuRFZtaVFOVFhod0tFV0F6VXp0T3oyT1BY?=
 =?utf-8?B?QWZtdVcyVjVWYXhRamRFdUpmTjFVdmtVN0hvcGJncGUyZ0Z5RkoySjhkUE9p?=
 =?utf-8?B?RWVzWjNKQXFBc1k5NVZOY01CYTNRUSs5WWlvcXNyVGs4S1pjQmtNUmZGMFFi?=
 =?utf-8?B?UjFaRE5XaXRPRk5zaGxlWkJXNzRlT3JpZ2d1cFZlblVDUzVlYzl4b09CenBv?=
 =?utf-8?B?TlkwUk1iQlpOM011Tnk3aUV3Q3h3Q0sxSGF6OUJ1MGNVL1JTbmlHUHY2QS9V?=
 =?utf-8?B?a1ZFUjI3NE44ZFRsVTJkK3JpRXN1WE5jTmplTHFPYVlLZ0pIWGl6dUE5TUpm?=
 =?utf-8?B?VkwycTdpT2JjWE4zM2M0Y21TcUcxMXVKTldBOEZ4WGRhRlJVM1czKzNTRmFN?=
 =?utf-8?B?N29IOG9sVlFjcU16YW16NFhvQjU5dEk1c0hvQTFoeTJZZzlBLzFPNFZ3dWsx?=
 =?utf-8?B?ajFSTTF6b1pTM0ViMGo3dk10VWxEaFprUDNnMkRkbFBpd1ZVSlFrYlB2WGNo?=
 =?utf-8?B?RzNCSnNqeTNjN1RRY1hNdytkQ3RZR05LblVFcVlOMG9zS2U1YXN0QzFLV0JL?=
 =?utf-8?B?emd3aUhoMXVCa005QVRDRS9YRVRQOVpla2JqOUc1TjI4ZWpKVFlxeDdVdzdi?=
 =?utf-8?B?TG9hTStONUFsRHp1WWFoZmxkb3NWUmNsZ1dqVWVJVVU4bGpSd3NVUVNzRG91?=
 =?utf-8?B?NC8wZDlDNTdJWHlzVEtKNzRPc255ZEszek9qN3JJcUtTcHM1QkYvSzNUdTZo?=
 =?utf-8?B?QUtXS1NoVzJCc0d2K2R3U0c4ZlhHMXJ0QXpiVDdac01EU2h5TzVML25DMzhU?=
 =?utf-8?B?WXYrRklKRWd0bE9WOHQvMDRQWGZZV01kMmErOXlKT2lQcUoyTEcxQUtsRnp5?=
 =?utf-8?B?RnRqMUFkMGJLZEVXUzBxM2FGb2ZKeDNoRnpYMFFZS25YUi9takFUbCtBTk03?=
 =?utf-8?B?eGt1dVVVUW1wa0QyOS9reE5yUThsOHNreFUxOFJaU3lVYk1CMlBic1ZyRlJj?=
 =?utf-8?B?Slg5ZVNqQjVzb2xxSklRN3ZRUVZpODBmanJPK0dEd0gyU1pSaDliWlRES0ov?=
 =?utf-8?B?RWpDaWE1THozUkl2VmRObWNMM0MzNVNOZFVmSDBsdGRhcWNBZHk2emhCOUk3?=
 =?utf-8?B?VDYvdktBVUNwMjhSRkVsSFRqeWRSL0M0bGd0czZOcGVFYU5sTzcrMzU1aUJ4?=
 =?utf-8?B?WEE9PQ==?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d00ec18d-d68d-4df1-6892-08dcb54dea6e
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10656.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2024 12:55:43.1796 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2nbTqDkfQ9EJuRo6N4Jzk41wya5mBsLuqsATV2EOgIYiYPsLeKCnXfi/2WC9v+JW4YlOTqj5p0JPpA7U1ncepg00WnMCEYJCfAO0CPGXl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR08MB6252
Received-SPF: pass client-ip=2a01:111:f403:2606::713;
 envelope-from=andrey.drobyshev@virtuozzo.com;
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

On 8/5/24 3:04 PM, Kevin Wolf wrote:
> Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
>> The testcase simply creates a 64G image with 1M clusters, generates a list
>> of 1M aligned offsets and feeds aio_write commands with those offsets to
>> qemu-io run with '--aio native --nocache'.  Then we check the data
>> written at each of the offsets.  Before the previous commit this could
>> result into a race within the preallocation filter which would zeroize
>> some clusters after actually writing data to them.
>>
>> Note: the test doesn't fail in 100% cases as there's a race involved,
>> but the failures are pretty consistent so it should be good enough for
>> detecting the problem.
>>
>> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> 
> I left it running in a loop for a while, but couldn't reproduce the bug
> with this test.
> 

Hmmm, it seems to have stopped failing on my setup as well, no matter
how I increase the number of requests.  And it seems to be related to
the interleaving 'write-zeroes' requests.  My initial attempt was to
cover the case described by Vladimir here:
https://lists.nongnu.org/archive/html/qemu-block/2024-07/msg00415.html
Maybe we just leave it and try reproducing the corruption with just
regular write requests?  At least with this version it seems to be
failing pretty stably on my setup:

> +    def test_prealloc_async_writes(self):
> +        requests = 2048 # Number of write/read requests to feed to qemu-io
> +        total_clusters = 64 * 1024 # 64G / 1M
> +
> +        offsets = random.sample(range(0, total_clusters), requests)
> +        aio_write_cmds = [f'aio_write -P 0xaa  {off}M 1M' for off in offsets]
> +        read_cmds = [f'read -P 0xaa {off}M 1M' for off in offsets]
> +
> +        proc = iotests.QemuIoInteractive('--aio', 'native', '--nocache',
> +                                         '--image-opts', drive_opts)
> +        for cmd in aio_write_cmds:
> +            proc.cmd(cmd)
> +        proc.close()
> +
> +        proc = iotests.QemuIoInteractive('-f', iotests.imgfmt, disk)
> +        for cmd in read_cmds:
> +            out = proc.cmd(cmd)
> +            self.assertFalse('Pattern verification failed' in str(out))
> +        proc.close()
> +



>>  tests/qemu-iotests/298     | 49 ++++++++++++++++++++++++++++++++++++++
>>  tests/qemu-iotests/298.out |  4 ++--
>>  2 files changed, 51 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
>> index 09c9290711..b7126e9e15 100755
>> --- a/tests/qemu-iotests/298
>> +++ b/tests/qemu-iotests/298
>> @@ -20,8 +20,10 @@
>>  
>>  import os
>>  import iotests
>> +import random
>>  
>>  MiB = 1024 * 1024
>> +GiB = MiB * 1024
>>  disk = os.path.join(iotests.test_dir, 'disk')
>>  overlay = os.path.join(iotests.test_dir, 'overlay')
>>  refdisk = os.path.join(iotests.test_dir, 'refdisk')
>> @@ -176,5 +178,52 @@ class TestTruncate(iotests.QMPTestCase):
>>          self.do_test('off', '150M')
>>  
>>  
>> +class TestPreallocAsyncWrites(iotests.QMPTestCase):
>> +    def setUp(self):
>> +        # Make sure we get reproducible write patterns on each run
>> +        random.seed(42)
>> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '-o',
>> +                                f'cluster_size={MiB},lazy_refcounts=on',
>> +                                str(64 * GiB))
>> +
>> +    def tearDown(self):
>> +        os.remove(disk)
>> +
>> +    def test_prealloc_async_writes(self):
>> +        def gen_write_pattern():
>> +            n = 0
>> +            while True:
>> +                yield '-P 0xaa' if n else '-z'
>> +                n = 1 - n
> 
> This looks like a complicated way to write the following?
> 
>     # Alternate between write_zeroes and writing data
>     def gen_write_pattern():
>         while True:
>             yield '-z'
>             yield '-P 0xaa'
>

Agreed, thank you :)  Won't need this chunk though if we end up adopting
the version I posted above.

>> +        def gen_read_pattern():
>> +            n = 0
>> +            while True:
>> +                yield '-P 0xaa' if n else '-P 0x00'
>> +                n = 1 - n
> 
> Same here.
> 
> Kevin
> 


