Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F66C25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 08:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9L6O-0007v7-9e; Tue, 21 May 2024 04:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9L6M-0007ut-PM; Tue, 21 May 2024 04:44:06 -0400
Received: from mail-db8eur05on20709.outbound.protection.outlook.com
 ([2a01:111:f400:7e1a::709]
 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9L6K-0008Ao-Lv; Tue, 21 May 2024 04:44:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jXOWX1fiQi39yvxWYZzUFbTtSGsnVpDupySS1LdOzRBLXy/QoEh/K12kDiSxHqIym7VdqMuD1coIqPmUvjZ3SZ76j3pkSxfkPmSXePrFTCjPq+hWxOYZAyhQn7XhddHkvR/jsIIchocXnyOaLliYBvUeobt1QbhOtxOFnmzHvP0FiABFxbIyuWNor1rcNTiv9vqQ/pRu6kcgnNpvg4XwpxGMvq+SHLVJ545/8bxV2iGWdgDy5eY9LUXhFD75VrYXXzLZvlR4IYNdZljOVG6zSrZ9nep5AuzLPXXM1Hjn/kRsmB8DWxvd6LZ0wV39ZvwG0L3LajEOKmJpYrYVtN/IYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYOOsjeSbwgrA6h4vw5foOsssTQg++skjMk0qMxRuf8=;
 b=FgXhs/Q7KCQOHmoWJTtC6j8I1Zb++uZCUG94HmVIKqnJBFWmoO2+KSnbZMMHOrUb9e0NYHYGroXgPiHoypVcntU3TrX4/uqcGM9MdGWWcnUDVs7UnOhM6OQb4k3bXPjpVZ3cfz4d9zF92dD+ooF9rtRHpOOJaAkB56iV1B2JuWXGvE7gnMUtWoF4cIteiBhhzpOZYMd8FxR/slUOIKtXbBdrkC48fBbOgnhnpJw3xvmqLwE1bX7v+wXy6mwb1eUUpgXI8+8N7wgitcSjWupUpRzlCMdRpBdBVBf28NtJ8ieyUwOSM7VfDgHq2lDn6R2WhOCzpKAu+20VJcn8s3tD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYOOsjeSbwgrA6h4vw5foOsssTQg++skjMk0qMxRuf8=;
 b=JuStLUoyzG4eNQyQq2dMNcC++h1MUhMnsp2BGlg5OpT7NB1xvVxkdDQXhh206H2RdBdKu/z4Vuogy8Dd8FBohhH+w/t2py00qG3dxWBHWXg+9bXtM4C0mK10LofJUImtiGQITw0+OWBZi1vejjtyFp/ecLSHPRvYWhSGzF2VZPe9UJb1rEOXMbVhljumc+DxYVI79/GHOLnCpwJgmMNoZybsMBdZhpVYKgMV7V92vXnz3FM1RQLfBpZcUdhegcpV9UuEYS59hr5KhhOx1Rvzbbt6DfthUtBDL/sCf6nlJnObqmZN8N+wDZBMljulL+jsOw9N7L+ezy82dr8k4AzCRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AS8PR08MB8327.eurprd08.prod.outlook.com
 (2603:10a6:20b:56e::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 08:44:00 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 08:44:00 +0000
Message-ID: <c233512d-f4f5-4a25-a4e3-53867da4d34d@virtuozzo.com>
Date: Tue, 21 May 2024 10:43:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/11] qcow2: put discard requests in the common queue
 when discard-no-unref enabled
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 eblake@redhat.com, berto@igalia.com, jean-louis@dupond.be, den@virtuozzo.com
References: <20240513063203.113911-1-andrey.drobyshev@virtuozzo.com>
 <20240513063203.113911-4-andrey.drobyshev@virtuozzo.com>
Content-Language: en-US
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
In-Reply-To: <20240513063203.113911-4-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AS8PR08MB8327:EE_
X-MS-Office365-Filtering-Correlation-Id: 786060ab-060a-48c1-5a6f-08dc7972291f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWpmVjQ2WnJhWDRPNmxSdFlacytmdUtZbFVsVGMxc05jeXJqZGoybUJQQVFu?=
 =?utf-8?B?TnRoanRpamNhMmtXMDVOV0NpS2VKWTZyMXlBTTYzM2crSmk3SW9pYlI1dkdY?=
 =?utf-8?B?SVIxTGlqcUYyRGF4SGlrZWUvM2sxei9nWUpGOVlUazRKQTB5RGhHQjMyM0Q1?=
 =?utf-8?B?Y2g1QkdGUzYyQ1l1WVo2Y0lLS1M0cmNWd3RJbFhOUWplZXBaL3NwUHJQOHdY?=
 =?utf-8?B?cjJXY2JyMzFQdVZ2QkJleE1pQjgzZXp0RzB2dEhHRHJXc2JRbUljc1p0eEhu?=
 =?utf-8?B?QlROdkFnVDRhZ2ZXQmtuSWFvUGtETjVTVFdBSTVwdTVocFBDRTBpR0JzNnlC?=
 =?utf-8?B?eEE5SGJ1Z25CZmcxV1hPbUJQYjM0OHk0Z1lLZ2tQSFVjUFJBM08yM2tBd1JG?=
 =?utf-8?B?Tm1jMVIzbDZmcHo4dkIvSzBSRFU1OWw4SmVNRTVCRWpjYXBXNHU0YUxxSUZF?=
 =?utf-8?B?SktLTWdydUFLOFhhMTZhUG92VGhYVHpGUVpzQk5PRXpQeHptRGVJSnE0S0M4?=
 =?utf-8?B?YzdKR2R0b05uK1RsNDJBY2xlSHJxM0Y5c215ZTFqbVBDclJlZFUzcngyNENB?=
 =?utf-8?B?c282d01EeE9hOFdtVm16Zlkwb01Sa1c3dTI3M3lVRUFJemd3MnM1T0hiRC9q?=
 =?utf-8?B?UWhEUUw0aU16NXNVcHIvdTdac2lqZVVSUmxwajN6ZnZ0ajd2eHVZWTc0RnNI?=
 =?utf-8?B?RU8xU3NxNXBYRExJajhWWThwNlNuWGFWZDhLZHBxMklxUFNkYmtnai9qOW9k?=
 =?utf-8?B?UE9qa29TWEdhdzRuVTZCRzFpakpMTjBNSkJKTUgvZG1pNGhKQVVWQWl1T3Y2?=
 =?utf-8?B?Y3NhVXFQQzF0Mk5DRjlkU2p5RWN3VEoxcjFhbWlIMTBqcTFyZmRiOVlJeUtm?=
 =?utf-8?B?Q21DV3JKcXBZMTY4YlNaNHY1bEEwZjE1TUxCSTRHdEFtTlBmRjZGRlZNQnFX?=
 =?utf-8?B?Zm0xREpGTW5DbU5tUjZQL2NTRG85cDlFVmlIanNoYlA3YW0zeTVLU3JkN1I3?=
 =?utf-8?B?WENINlp3SE9CVlFpTFRMRmF6bXJxUzM4ZkRRNi9CZi9RcnJoUWxNb3RlYjJm?=
 =?utf-8?B?bHErSUNIeW9mdmtqL2U4dXdFTW1KdWFTWm1pZVdPaTN1aE9ONm02dE1hMkd1?=
 =?utf-8?B?YnplVStVdVV5Q2xsTkllOHEyR3dneVB2OWk0eUcvOXo2bS9LZm5QSjdUZExs?=
 =?utf-8?B?ZWozQ01IUkRFa0tOUEsvUUo0WUVwajVhUnA3QnBVNENxdFM4a1dpaGw4dTJI?=
 =?utf-8?B?ak5TOThTZHRwNFI5bmFvRyt6RzRRMFRsczl5M2hrWXBvZFlaNWpqdHk5cWoz?=
 =?utf-8?B?anBrVjFlL0Fnam5QeG9lazhOaGNkOXdzV25oKzZSMnE4UXlNanU0VkQyWkFJ?=
 =?utf-8?B?YUxsWWY5V2tlN2dhNG5teHF2WEg5Y2h2TzhUTzI5OW1nVmpRaGhTZWhtK3dJ?=
 =?utf-8?B?aHNLRGFPakVkOWZWd0NEb01scElEcGdyc1M4dXlzODRzcHlKQjBwdUREUlRp?=
 =?utf-8?B?SHhBeGpSV1FZT093NVVDd25yTnB2RFBEK1NncmhCL0lzMlZDNTQ4UUlPaHpu?=
 =?utf-8?B?aE40TEwxVi9VL041MnErWktpb0U3UDRSWThqb0dabWE1S3VkODUwVWQ2NDRP?=
 =?utf-8?B?a3BtYmMxZU1NTU4zcEora1JpS0ZXeXIwOVV6cW9SdXFISEpkVndhdzNHYlBH?=
 =?utf-8?B?c1VlYWZUTTEzY1FUdjdGZ0E5T3hReDhBdXllR2xiQXB6QVhhcTFLZTV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cml4eE1FNG1OZE5GRC9vcG1WTkFQUVMrRFJoclhLUkFKT0E3Mi9xRm5QL09X?=
 =?utf-8?B?czZWNlJQYXFPMXBCNVk1WjM1cHc4ejNpUlE4Y1FDL3RxaXhxdFNKdkgyNTYv?=
 =?utf-8?B?Y2hSczNjYUNUd2U1NDhPSXhQRW1nTFAxZjNxejZad1VGYkQvcWF3TVNiNngr?=
 =?utf-8?B?RmV3dER3aXFndmxZb0UxRmZLL2JuQ21IUEJBWm5RRHR3d2JtWXBiNm4zVWVh?=
 =?utf-8?B?OU9OVmRqWCswODNFVzR6QUFDQWJNT0l4anREcm8xV3VabTFLalRlU0ZsUks1?=
 =?utf-8?B?cmlMVUE5UkljUHgyczM3cGRvZlZ5WnRVWlBrVlVWd09Gb3VyMmxXZ0pqRk5Q?=
 =?utf-8?B?TE1iMWdNQmtOdEpmd1hjSC8xVHNRMjMvRlVNY2NTMlk5ZlA5ODlMc2dqR1JS?=
 =?utf-8?B?WGJHS2VXTXJMdHQrWm5jNS9IV1RTZk5XQklwSnRjb3laNVM5Nlk3OXU3bkN6?=
 =?utf-8?B?UjVWWnFsWUczMzZYRmswdjZuNjZtM28wdXJmc3RqdUtOdDNsUXlIUi9UeE12?=
 =?utf-8?B?d3pHS0d5RS92SWFXMm5vajVoL0lMNG9jSEZsRFVuKzloQ3pKbEppMGJzYys5?=
 =?utf-8?B?cEcrbUJXR3QwRW1IVlZMVlA1QXhrcjZlaENkZUQvVUJPUHc2RjREd01jcGZ0?=
 =?utf-8?B?YkVFMHBEUFM2NjRBUkk4MkZJLzNKaW1CRDlPdnN5VlNlU0t5WUs2MGR2cjRw?=
 =?utf-8?B?a1JBOXlmSEdmSXJIT0F5RDZ0Yld6ZFdEZCszc1ZkVCtIOENXNW9BYWZEVVIz?=
 =?utf-8?B?UkZhTmVMc0dPWlBoR3V2TG83eERuV1V1ZjJxNTRrV2hxbHc5VElvVDJPS2NL?=
 =?utf-8?B?RFhwY05Zck1LWWxUbVNSb1IvYjM3dUF0RzBPeXF2OXV5dXRBeHFNN1Ywb0Jl?=
 =?utf-8?B?MUdQeXBzb29YTVBWQUt0ME5mUC9LYXV3YWxDcFV5T2ZJeWR1R1NTUHdzeUVz?=
 =?utf-8?B?QVpoRWU2SEMyZTlVRTlDTEszRDR1b0Q4OU5VMVUzUmJZRmNUQmdpOUNseFR5?=
 =?utf-8?B?dFNTTUdXTkF3Q05HeFJ5MDVlaE04WE5JcDFkSGdmbXk5akF1SlJkdFNXUnRB?=
 =?utf-8?B?b3RvNmIvV1p5NjVxcUl2RVFkb1lzTjdadnp6WFB5QlhhQXk3REdQRWZJZXpI?=
 =?utf-8?B?bHUvNUlCSXcrQTFvV0Z1c1JScW9ndVJMVkY2Nm9yN3JoRnh5eDNkOVVWZWNr?=
 =?utf-8?B?OE0xbnZ2ZVRqbG9rMXlJMjNjN05MUWRLTDJrL2ZKUy9LQUQxM1RnY2ZVd0dP?=
 =?utf-8?B?VVJtamlUcjdmTTJiSmR4Tjl1Y1VnWnFqSnRMYkdHRlNjMkszTS9HL1R4Ukh1?=
 =?utf-8?B?VkJKaEcvRkRQU2xXYVJkRUhuanVHNEd3aEFLSnk0dUxhSTR1UmttWHZUdnd5?=
 =?utf-8?B?YkttVXh6Vnd4VHZZOXFDNEhZZjZ6R3pzN09yemdzZFBtQzI3TEl2VGxPa0tw?=
 =?utf-8?B?R3hneDM0d2MrTzNOcVBkRjFjb095QU5UeFBZSWVDcVk2ZzBuNnNsTXhPWXYr?=
 =?utf-8?B?eHJmT2syYkJLeXNva0s0MkJZbHVuaS9PeTVZODRCb1NKb1ZHOElBMFY5Ujkz?=
 =?utf-8?B?bUVLWmZ4QVFwQ1FmTXBUUFNkemU5N21qYlRxT0pmcS9pRzV0YjhGelpLV05p?=
 =?utf-8?B?dk9GamZPRUF0L2JBWUM0UHR5VkQ0RmNzMVRlSm9SL2trRWJQY01TQU9sQkpx?=
 =?utf-8?B?UXh6RkpvSmhEbDI1SmJYNW1WR1Q5OHNpVlhKZitKZTlwakJMcU5ESzZtWVpo?=
 =?utf-8?B?ellhYzE0UHFLRzdXWkV4SGxrNTN5MHFIbFBkVkdSQkI3VEExd21jRWc3YjJC?=
 =?utf-8?B?UVNuU3pIY0FpbW1jS3o3WFdiM2NLZVlIU1RYOGJ3dVA1azJHajZPaGtvbmxM?=
 =?utf-8?B?S0llaWxjYllCRXBKWFo5aWpSNjREZTRsQUp1MnhVaHR0Nmh3c0Y1a2NHQkIz?=
 =?utf-8?B?NHlXaG55WUFlbG9xdEY3Q1ZpRXVpbmZFUFdMME9SanRkb3NqdlBLeW1lMDUz?=
 =?utf-8?B?YVo0enI4Y2xwdkhYRVJiTFFpcDhzVWp4U2J4RC9PODdlWGhxdWZFTUlLaFU4?=
 =?utf-8?B?cnFkeHIzNmFjRFh3QlM5WE5TbjVYL1JrVVVkbW5NM05vUEw4UWx6VjlpUGlK?=
 =?utf-8?B?THNvN0FkOUlsMHFDd3NNdU1yMWNwOWtOc2s1RFJxVWtxNDh5cHJ0c0hZWmJ3?=
 =?utf-8?Q?Jd6lABtJKZw4Tpc1Vq9SCjo=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786060ab-060a-48c1-5a6f-08dc7972291f
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 08:44:00.3946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHTSi2xQ91OaU65YDATN1Bawj2EXVh12dp9ehMsFXzcGJTtkWWDfxGnz0L2YIDInVbev6wo41SFERLrCJUffNxunjyPVmry0dNpx7wVy5o4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8327
Received-SPF: pass client-ip=2a01:111:f400:7e1a::709;
 envelope-from=alexander.ivanov@virtuozzo.com;
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



On 5/13/24 08:31, Andrey Drobyshev wrote:
> Normally discard requests are stored in the queue attached to BDRVQcow2State
> to be processed later at once.  Currently discard-no-unref option handling
> causes these requests to be processed straight away.  Let's fix that.
>
> Note that when doing regular discards qcow2_free_any_cluster() would check
> for the presence of external data files for us and redirect request to
> underlying data_file.  Here we want to do the same but avoid refcount updates,
> thus we perform the same checks.
>
> Suggested-by: Hanna Czenczek <hreitz@redhat.com>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   block/qcow2-cluster.c | 39 +++++++++++++++++++++++++++++----------
>   1 file changed, 29 insertions(+), 10 deletions(-)
>
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 5f057ba2fd..7dff0bd5a1 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1893,6 +1893,28 @@ again:
>       return 0;
>   }
>   
> +/*
> + * Helper for adding a discard request to the queue without any refcount
> + * modifications.  If external data file is used redirects the request to
> + * the corresponding BdrvChild.
> + */
> +static inline void
> +discard_no_unref_any_file(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t length, QCow2ClusterType ctype,
> +                          enum qcow2_discard_type dtype)
> +{
> +    BDRVQcow2State *s = bs->opaque;
> +
> +    if (s->discard_passthrough[dtype] &&
> +        (ctype == QCOW2_CLUSTER_NORMAL || ctype == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +        if (has_data_file(bs)) {
> +            bdrv_pdiscard(s->data_file, offset, length);
> +        } else {
> +            qcow2_queue_discard(bs, offset, length);
> +        }
> +    }
> +}
> +
>   /*
>    * This discards as many clusters of nb_clusters as possible at once (i.e.
>    * all clusters in the same L2 slice) and returns the number of discarded
> @@ -1974,12 +1996,10 @@ discard_in_l2_slice(BlockDriverState *bs, uint64_t offset, uint64_t nb_clusters,
>           if (!keep_reference) {
>               /* Then decrease the refcount */
>               qcow2_free_any_cluster(bs, old_l2_entry, type);
> -        } else if (s->discard_passthrough[type] &&
> -                   (cluster_type == QCOW2_CLUSTER_NORMAL ||
> -                    cluster_type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +        } else {
>               /* If we keep the reference, pass on the discard still */
> -            bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                          s->cluster_size);
> +            discard_no_unref_any_file(bs, old_l2_entry & L2E_OFFSET_MASK,
> +                                      s->cluster_size, cluster_type, type);
>           }
>       }
>   
> @@ -2088,12 +2108,11 @@ zero_in_l2_slice(BlockDriverState *bs, uint64_t offset,
>               if (!keep_reference) {
>                   /* Then decrease the refcount */
>                   qcow2_free_any_cluster(bs, old_l2_entry, QCOW2_DISCARD_REQUEST);
> -            } else if (s->discard_passthrough[QCOW2_DISCARD_REQUEST] &&
> -                       (type == QCOW2_CLUSTER_NORMAL ||
> -                        type == QCOW2_CLUSTER_ZERO_ALLOC)) {
> +            } else {
>                   /* If we keep the reference, pass on the discard still */
> -                bdrv_pdiscard(s->data_file, old_l2_entry & L2E_OFFSET_MASK,
> -                            s->cluster_size);
> +                discard_no_unref_any_file(bs, old_l2_entry & L2E_OFFSET_MASK,
> +                                          s->cluster_size, type,
> +                                          QCOW2_DISCARD_REQUEST);
>               }
>           }
>       }
Reviewed-by: Alexander Ivanov <alexander.ivanov@virtuozzo.com>

-- 
Best regards,
Alexander Ivanov


