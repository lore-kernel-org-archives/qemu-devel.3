Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33658C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 15:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9noI-0000u0-KL; Wed, 22 May 2024 11:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9noF-0000tL-O5
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:23:19 -0400
Received: from mail-he1eur04on20701.outbound.protection.outlook.com
 ([2a01:111:f403:260f::701]
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander.ivanov@virtuozzo.com>)
 id 1s9no9-0004x7-Ov
 for qemu-devel@nongnu.org; Wed, 22 May 2024 11:23:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRb3qydVv4Tcnms+JNHQRwIr6qpfg2uk6H5cJtuVzHf1mnIfxdz5OtQuhpOOJ1ngEtAdlEzrv0peG8zNXnZchFZqDsfgxJIcEhLs/1s6eVAFdUj7Rh1HckLSSeHmiK3JywP75bloLq0larG+3UO7b4MJmBYebPv/0YWBiS9eDDJH+tW4Nhl/m8rzqnQDkC0eC+/Pphgjs1GPJFR046YP2s9oh3ab02Q/lBhLUjPTtieiWgCt6SVlA40+q2jRJe6Adna9ssT1VS15P7zszjdMc0BGpV1FmaDw3KkAqpzePYpsyK0gIEt9J8TOMU2Vj2+q1Kw/utyE2td9WwAgCuZR7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YPjyeqq7VUHa4OXbkzHhzIH3lEjgDDCmchp5ZH9XXL8=;
 b=SkV3IvcsTcshP1T2HrQeiFSul22Wk6x0LAXNXoPjVUxd/aHNi8xvcfTlR+y/Zf79pCdBUyP3bLCsxvrHA+q3MBdQY4HtmSWY2umDIf9ta8TLSfFpIL1XQSSv86ORCKwHAdAa46JdNtYHOf52IDOfPMLAdPhFd7UvrVNGR/uTYJ7PmuZWqfqlS2dIXbkvgEBBdC56/0kfTxXJHLU7y6+aJcz+t4TRNP3pardHrspMjV8DTsYaeWK/8CIAN1QdB3KC8/6NGoMMFMBgmhPC6hVCQfxPFn/GjipT/thGICPG6IK0a9Db7jn9AOtdVE7sfV0cLuQdaSR6iRHysqmFFrL31w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YPjyeqq7VUHa4OXbkzHhzIH3lEjgDDCmchp5ZH9XXL8=;
 b=DbMvqd/EU+k5AfgzmofyY22WeLJL4Ikns3RAVFV7qY12eXSrllPuEl0+LK0RFrF6CeJsanJ0tBsnGIwSiIrry93qppSRPdOi8nTbUBCFL0bhbk2UfWeaM8AEnHwcCS6k/YA0oLKXlvh95JD1cByVmi603nmMIh2F6i+t8xgT7xmO2e3zKv2bcB2jx46ZqIku6N/LQ53HQt7vgtmAPLtMr2GT3oAV8FPh86dmNEQsZRNdi/VqmWh8YOIkBIO+q7lv2+IXJusim8BNF6FEGuIQwbm6OuCmy8lpkJUN5AFMpsvndbFVfwlDl/DzPWSdgQcnG5+E6PGxHIfW1fSm6JB7Xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19) by AM7PR08MB5416.eurprd08.prod.outlook.com
 (2603:10a6:20b:10e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.34; Wed, 22 May
 2024 15:23:09 +0000
Received: from VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5]) by VI0PR08MB10743.eurprd08.prod.outlook.com
 ([fe80::cebf:31ab:1e25:cfb5%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 15:23:09 +0000
Content-Type: multipart/mixed; boundary="------------IriCK4bm9IQpfAR0ABywHsp7"
Message-ID: <b2c65317-4b52-42d9-9b7f-471b2a2140fd@virtuozzo.com>
Date: Wed, 22 May 2024 17:23:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Test scripts
From: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, michael.roth@amd.com, kkostiuk@redhat.com,
 marcandre.lureau@gmail.com
References: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
Content-Language: en-US
In-Reply-To: <20240522150657.2378330-1-alexander.ivanov@virtuozzo.com>
X-ClientProxiedBy: VI1PR07CA0150.eurprd07.prod.outlook.com
 (2603:10a6:802:16::37) To VI0PR08MB10743.eurprd08.prod.outlook.com
 (2603:10a6:800:205::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR08MB10743:EE_|AM7PR08MB5416:EE_
X-MS-Office365-Filtering-Correlation-Id: 24587d3c-5ec6-458c-e62f-08dc7a7315f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnVUdFBXVmV2ZnhRSzhwZFBWSE5PektJV1ZmR2FoL2RYNW1aTi9xRXVucVlF?=
 =?utf-8?B?dnVIa1dHM2pOczJ0UlRKaGFUZXkzQzBud0N6VjJRQ2FyNnBoRzhzanErbVE1?=
 =?utf-8?B?ek83Vm9zcVdSRUpkSk56Y3pjdC9UKy80SWM1RE0vMlVDWTVqUEdkRnVxVXhp?=
 =?utf-8?B?M01KWTdYT3BtUDJ6SVZWVGdMUFgwcWlWZlFHS1A0MnNIdERObjNPdmdkMk1x?=
 =?utf-8?B?LzFlb0g2a2NXVjJEYlVjbTlRM3JvaDhlTjl1WHRCUjMydXJJd1hqNFpxSWRB?=
 =?utf-8?B?dXdNcGlibmxKSWpSQlpRZ0tEMURMWUpPZEwyWTJrODhVQmNGUEJjcWFSdlNw?=
 =?utf-8?B?cEFGQmsvQlIzcSsrYUtIZ3MvRExjL0kvVXk4Qk5PMXBhR3hzZFZlbkZhd250?=
 =?utf-8?B?YW5mamIwSlp6a2JLd1BoeG13MEYvZ2tBZTdqamgyVzFwTjlpMHQ0Q3J0OEtC?=
 =?utf-8?B?czd4Mm9sbmF3NkRGRE43UTFiQ050VGFzd0xvSnR4Y3o2d05jcnNVN09iaDRi?=
 =?utf-8?B?WTNlVElSek9KUWVxaytSbDlKL05MbkY4K0dOYTNsMm5abzJwcW5vblgxT2NY?=
 =?utf-8?B?L1FPMURuTWNDMnNJZnhUcDhvd3puYldhVG9pS2QzWmJRcTFib2hpVXluTjdq?=
 =?utf-8?B?U3creVB1OGcvcDNCMFdzNUhqdkJDdUJMM0F1OE9hbXl4S3BKUkhCWlF2bzlt?=
 =?utf-8?B?SGV0eE5kN0RyT1N0ZlhGaERTdlJxV0lsekVjUDdMdW1PeUNKUHVDMjFZc3VI?=
 =?utf-8?B?KzhsU0EvZG9JWmxLb1NTTTI0N214aVRNVnpLWENEY2RPVkQ4U1dITnlsK3lz?=
 =?utf-8?B?SHU0akVmK1hOd0hRTlN6MWhOUHU0L0Q5c05aL09IQ2NnVGdVa2hlSVgwY0V1?=
 =?utf-8?B?L1VNKzBqYnVoY3pRclkyT3hWWktWTVUyT1MzT044UDJobC81V1hMRVhTZDhm?=
 =?utf-8?B?SWxhUmgwaXBpWW9RTkVselVZc09jNGlVVytoaVp0SWk1a1ZxOHYrUXhCMzY4?=
 =?utf-8?B?eXYvNDFxSy9OeGNJM3NQVXFIMC9pYnZPb1dwZkVCbk5LdGN1d3Y1ckJFY3Rq?=
 =?utf-8?B?RFcyOHovejVHMkg2dTcrT1FBSFJyRlZybW9XMmNDYkY4VzlHYU5ZbnZ5UkZu?=
 =?utf-8?B?SUZXWFl2OHJaNXJSWm1YOGNHNEszaEQ2cERiZlRpQktkNFNkMFJDZnFWYWpR?=
 =?utf-8?B?U0E4YVY4cEhiaUtpRytnVk1QNTk3OUF1SnpyekZ0SnlzYWZyek9wcjNkd2hu?=
 =?utf-8?B?SlYvNEpxMldnMXJaZTdCS3ovSXpSeEtzU1Z1VURYVmRIN3Jyb1ZEVk5zZWw1?=
 =?utf-8?B?dGwwMHNRMUlmOXdoUDhxZDNvSG5iTHNFaUFnR1RyRHBOMXZ3N3p5dStNUGti?=
 =?utf-8?B?ZGJPb253T0ZSSU1hM0g3SE9kYXMweXVvak1udW5VR1J2cUNheXZLOEFjL2Z5?=
 =?utf-8?B?WU00eXhDY1lPZkRLL1I5R1dMYWhaZGlPbkVWeCtyVGRvOFpFRE5YbGFXZzVw?=
 =?utf-8?B?Q1YzSlY2NDQrSSt3blJUbTZaTzYxcjdHYmVaVFVOQTJOaVc2OXN6VEVtMWYy?=
 =?utf-8?B?c05TOUJkdkNsM3RocEp0a2dxRmgrRm5IalQ1Zjg2MGtSK21nWXFXd05mcjFn?=
 =?utf-8?B?TVhYZFRoQnhDSkNPd2VLeXUvbkhjdDh4TnFQenRhd0NTNHJ6YmdiSlBFTGpD?=
 =?utf-8?B?d1BzV0pQV3pjejZ6N1o2STk1ZXhTOHM0R0IvN1lqeGFGV0oyZkVXeURBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR08MB10743.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE9VRkc0S2RBWlNNUlFiQVhzekdVV2FYYkdlN28xcHRiOTRQOXhRb3FqWHdP?=
 =?utf-8?B?MDBKSm9vT1llSGhSeWVNTDE0dklPazMzeUwvSWJaazJ6OXlvN3VWSzJXNnIv?=
 =?utf-8?B?aTJQMHoxM0dWaDNQT0dLZ3NwU09RMzJ4d1d0MmY0bDRzeXRDa3ZXMnVIM2lr?=
 =?utf-8?B?Y1NGNFByYmdEZUFCUENId2NFa1VtWm04NlJ3bytDSHRNTXpLeFFUQitsV3JP?=
 =?utf-8?B?Rnh6dG1mbmxjVzRiM0JUL1VHZ29hSm9XN2FQSnVEd1F4UmcrNGJBZG43ZWNX?=
 =?utf-8?B?YTRQdjh4dVhsNjFIYVp3VEc2aS8vUjk4bEFMSEpsT0F0U0RKdW1WaERFYXRI?=
 =?utf-8?B?TTF5ZVk0ZElESEZSMEdrSDBIaDJmK3U1bTBkamVyWjY1YUVWTTd4Q1lXOEZK?=
 =?utf-8?B?OURBZCtGdmlHOXpkeVkxckRKZmdySVh4UStVNVR0VTdqeFhMK1ZwN04wK29W?=
 =?utf-8?B?cXV4YWIwTGgrdmtUZ1g0L2NxWjFqU0ZMTzRWT1NkYk55R3dnWXVsV1ZDTHRU?=
 =?utf-8?B?dit2a1p4K1RPMmZueE9JZUwwR2dybDY1aVVnNWl0WDM4SlJrajlsUlpZVGtP?=
 =?utf-8?B?N3hjYlVaYjJvdUxJR0E1Q28vc1gzbDBYWms0RE5rTDFIcTk4Rk9wbS9BZ1lT?=
 =?utf-8?B?ek1oUUNZaXQrbUtHRnhmTmd4Rno3T3Vpa2tQZ09VY3NxRHprNHdzeWREOXhv?=
 =?utf-8?B?VSsvQndjZVlIZHdSajVubGtJSlhkUDQ1czNsMjFDRzZZc2ZOTGZNdEM0cEpt?=
 =?utf-8?B?Q29hVWh0QVJSVXZKSlhiMmZ1bkNEeFo0ZVE2Zmp6UW5GTUZPRnEwWlVHNTZn?=
 =?utf-8?B?WjZKa1p5YmtiaUh4dzU2SHZSOFpRZVp6SGtEcFBwOUhKb3grV2paSDlBZk8z?=
 =?utf-8?B?VWNRcGVzQy9rU3ZSdWdzRGloR1p0dEY5SHhQUEkzNzlIT0FhWnBxWjNmYklk?=
 =?utf-8?B?NEo4ODhNM0RuUFdKbTkvb1RKOFc5TS8xRzNOMFVIV0hxQm5jWHg1Ty9rRGRM?=
 =?utf-8?B?RFE4TGRjYXdnd2FDTUl5L0dkeHhIcUEyeHB4OU5WNEZDck5ET1NaTmR3MWxx?=
 =?utf-8?B?TytkaCtXaFNFQ3QwaHhDcXkwUjNxMWswTmhGRVgyRTNOZmJreTBobWpDSzlV?=
 =?utf-8?B?SkVlM05QaFJxLzlCZUJFNFA4cHN2NHdJY0RXSVJwcGEvcW1QNTdQUC9QVUps?=
 =?utf-8?B?VzNvK1JJU3ZVbkd3cCttRUoycG5ibmp2TnJYZnRQMDVvMkZHV1ZvdGtFTVpv?=
 =?utf-8?B?WkowQnZUbmd3QnhOckFWZ3NOaWdkYitkRTlrNjc2YmVTTnZSRU5oR29kYXdr?=
 =?utf-8?B?RHlidDZnYmQ1NkFzQ3ZtbG5hMW50RGFSOGZnS01va0lLZWdoVzZpeFNzTjJQ?=
 =?utf-8?B?Q1UvdzVJK2lJSndicUpGK2RaVHB0Z29YblpLZ0sxQXg5NjdmTmZwNHUvMC81?=
 =?utf-8?B?RzJwTXB6WlJNT3NhS0NLWVFXQ0h6NHR3OTdJbVUrQm5naFdyRy80UU5tZUIw?=
 =?utf-8?B?WU40ZXV5dXk5MjMxdzB1QUZ3enBVRCt1UGNVZXo4TjI3aUI3RjFOaEJMeGdy?=
 =?utf-8?B?VGdmWHpTVUFsek5ZdnRnRVRtRWxRbFFoQzlIT2JMM3dZU1JoSXlxd05YZ3Zl?=
 =?utf-8?B?dUIxR2NYenIyQjZDdWhNYytLY1BEUkEzcThwR01zOFNPeERGUFVpK2hBNXM4?=
 =?utf-8?B?T2N0WkdpWGVnNXhkaTA2NkNQdnIrUjkrUm9QYlRMSEVOTEdmQ29WVGp2RG1V?=
 =?utf-8?B?djVOdlZ0dzY3NWIrd3VMU3dMMFBLWW54a3RqSVBDWDlqbDJuNndWbktWdTV3?=
 =?utf-8?B?VGdYdEZKcUpSZlNLYytwNmJkZ3h0KzQySmJValFHVm1KN2lmdnFBOVpLMzU4?=
 =?utf-8?B?b2tyNE00SjNjdmtWaDRYQVQ0eWt2a1Q2clh5TXdlZ2IyQXg3bDlFQU5kdGhn?=
 =?utf-8?B?enp5K3Q1UzFENDlFZFp1RHhSRGJRWCtVd29rNVp2RnBlcEtuUWVydmg3dEl6?=
 =?utf-8?B?Z1FzT2tVdjhTY1UvejhoOHVmWUQ3ME5TcllQSlFoM2FDZFlnNEt5dW50N0pH?=
 =?utf-8?B?THV5cFZJSEVFZklibWRkaXBZUUxTY3RHejFUYWg4VU1aQ3psS0p3NVBvYTUv?=
 =?utf-8?B?dWF1OVdSNGNtcjVKVVkwaWJSY0hjYVFlWm1lRWxLSkNrT29kdUxsczM1K2dK?=
 =?utf-8?Q?RsLlz042L11rdFQZzVMj+1o=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24587d3c-5ec6-458c-e62f-08dc7a7315f8
X-MS-Exchange-CrossTenant-AuthSource: VI0PR08MB10743.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:23:08.9950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oy13FVvXWHOMfqb0EF4OF7NZxeHMTrXj/duA3RyyCRS2Ow4HGqUUaikxybB9HpiiB5BS6EFAUkhEcQsYm3oCDSIaosFQD9F6tAp6gL9ks1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5416
Received-SPF: pass client-ip=2a01:111:f403:260f::701;
 envelope-from=alexander.ivanov@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_SPF_HELO=1,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--------------IriCK4bm9IQpfAR0ABywHsp7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

There are two python scripts in the attachment:
vsock_guest_exec_simple.py - simple example of a client;
vsock_guest_exec_test.py - tests with different payload size.

The last file should be copied to a guest VM. Edit SRV_PATH variable
in the host copy of the script - there should be path to the directory
containing a copy of the script in VM. Execute the host script with
net arguments:
./vsock_guest_exec_test.py srv <VM_NAME>


-- 
Best regards,
Alexander Ivanov

--------------IriCK4bm9IQpfAR0ABywHsp7
Content-Type: text/x-python; charset=UTF-8; name="vsock_guest_exec_simple.py"
Content-Disposition: attachment; filename="vsock_guest_exec_simple.py"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9weXRob24zCgoKaW1wb3J0IHN5cywgb3MsIHN0cnVjdCwgc3VicHJvY2Vzcywg
anNvbiwgc29ja2V0CgoKVFlQRV9NQVNLID0gMHg4MDAwMDAwMAoKCmRlZiBwYXJzZV9ibG9ja19o
ZWFkZXIoZGF0YSk6CiAgICByZXMgPSBzdHJ1Y3QudW5wYWNrKCchSScsIGRhdGEpCiAgICBzaXpl
ID0gcmVzWzBdCiAgICBpZiBzaXplICYgVFlQRV9NQVNLOgogICAgICAgIHNpemUgLT0gVFlQRV9N
QVNLCiAgICAgICAgdHAgPSAnZXJyJwogICAgZWxzZToKICAgICAgICB0cCA9ICdvdXQnCiAgICBy
ZXR1cm4gKHNpemUsIHRwKQoKZGVmIHJlY3ZfYmxvY2soc29jayk6CiAgICBoZHIgPSBzb2NrLnJl
Y3YoNCkKICAgIGlmIG5vdCBoZHI6CiAgICAgICAgcHJpbnQoJ0VSUk9SOiBoZWFkZXIgcmVjZWl2
aW5nJykKICAgICAgICBzeXMuZXhpdCgtMSkKCiAgICBzaXplLCB0cCA9IHBhcnNlX2Jsb2NrX2hl
YWRlcihoZHIpCgogICAgcmVzID0gYicnCiAgICByZWNlaXZlZCA9IDAKICAgIHdoaWxlIHNpemUg
PiAwOgogICAgICAgIHBhcnQgPSBzb2NrLnJlY3Yoc2l6ZSkKICAgICAgICByZXMgKz0gcGFydAog
ICAgICAgIHNpemUgLT0gbGVuKHBhcnQpCiAgICByZXR1cm4gKHJlcywgdHApCgpkZWYgZ3Vlc3Rf
ZXhlYyh2bV9uYW1lKToKICAgIHByaW50KCdydW4gZ3Vlc3QtZXhlYyBjb21tYW5kLi4uJykKICAg
IGNtZCA9IFsndmlyc2gnLAogICAgICAgICAgICdxZW11LWFnZW50LWNvbW1hbmQnLAogICAgICAg
ICAgIHZtX25hbWUsCiAgICAgICAgICAgJ3siZXhlY3V0ZSI6Imd1ZXN0LWV4ZWMiLCAiYXJndW1l
bnRzIjp7InBhdGgiOiAiYmFzaCIsICJjYXB0dXJlLW91dHB1dCI6ICJpbnRlcmFjdGl2ZSJ9fSdd
CiAgICBwID0gc3VicHJvY2Vzcy5ydW4oY21kLCBzdGRvdXQ9c3VicHJvY2Vzcy5QSVBFKQogICAg
cmVzcG9uc2UgPSBwLnN0ZG91dC5kZWNvZGUoJ3V0Zi04JykKICAgIHByaW50KCdyZXNwb25zZTog
JXMnICUgcmVzcG9uc2Uuc3RyaXAoKSkKICAgIHJlc3BvbnNlID0ganNvbi5sb2FkcyhyZXNwb25z
ZSlbJ3JldHVybiddCiAgICBjaWQgPSBpbnQocmVzcG9uc2VbJ2NpZCddKQogICAgcG9ydCA9IGlu
dChyZXNwb25zZVsncG9ydCddKQogICAgcmV0dXJuIChjaWQsIHBvcnQpCgpkZWYgc3J2X2Nvbm4o
Y2lkLCBwb3J0KToKICAgIHNvY2sgPSBzb2NrZXQuc29ja2V0KHNvY2tldC5BRl9WU09DSywgc29j
a2V0LlNPQ0tfU1RSRUFNKQogICAgcHJpbnQoJ2Nvbm5lY3QuLi4nKQogICAgc29jay5jb25uZWN0
KChjaWQsIHBvcnQpKQogICAgcHJpbnQoJ2Nvbm5lY3RlZCcpCiAgICByZXR1cm4gc29jawoKZGVm
IG1haW4oKToKICAgIGlmIGxlbihzeXMuYXJndikgIT0gMjoKICAgICAgICBwcmludCgnVXNhZ2U6
XG5cdCVzIDxWTSBuYW1lPicgJSBzeXMuYXJndlswXSkKICAgICAgICByZXR1cm4KCiAgICB2bV9u
YW1lID0gc3lzLmFyZ3ZbMV0KICAgIGNpZCwgcG9ydCA9IGd1ZXN0X2V4ZWModm1fbmFtZSkKCiAg
ICBzb2NrID0gc3J2X2Nvbm4oY2lkLCBwb3J0KQogICAgc29jay5zZW5kKGInZWNobyAiSGVsbG8g
d29ybGQhIlxuJykKICAgIGRhdGEsIHRwID0gcmVjdl9ibG9jayhzb2NrKQogICAgcHJpbnQoJ1Jl
Y2VpdmVkIGZyb20gJXM6ICIlcyInICUgKHRwLCBkYXRhLmRlY29kZSgndXRmLTgnKSkpCgptYWlu
KCkK

--------------IriCK4bm9IQpfAR0ABywHsp7
Content-Type: text/x-python; charset=UTF-8; name="vsock_guest_exec_test.py"
Content-Disposition: attachment; filename="vsock_guest_exec_test.py"
Content-Transfer-Encoding: base64

IyEvdXNyL2Jpbi9weXRob24zCgoKaW1wb3J0IHN5cywgb3MsIHRpbWUsIHN0cnVjdCwgaGFzaGxp
Yiwgc3VicHJvY2VzcywganNvbiwgc29ja2V0LCByYW5kb20KCgpTUlZfUEFUSCA9ICcvaG9tZS91
c2VyLycKUEtUX0hEUl9GTVQgPSAnIUliMzJzJwpUWVBFX01BU0sgPSAweDgwMDAwMDAwCgpUWVBF
X09VVCA9IDEKVFlQRV9FUlIgPSAyCgoKZGVmIHBhcnNlX2Jsb2NrX2hlYWRlcihkYXRhKToKICAg
IHJlcyA9IHN0cnVjdC51bnBhY2soJyFJJywgZGF0YSkKICAgIHNpemUgPSByZXNbMF0KICAgIGlm
IHNpemUgJiBUWVBFX01BU0s6CiAgICAgICAgc2l6ZSAtPSBUWVBFX01BU0sKICAgICAgICB0cCA9
ICdlcnInCiAgICBlbHNlOgogICAgICAgIHRwID0gJ291dCcKICAgIHJldHVybiAoc2l6ZSwgdHAp
CgpkZWYgbWFrZV9wa3Qoc2l6ZSwgdHApOgogICAgcGF5bG9hZCA9IG9zLnVyYW5kb20oc2l6ZSkK
ICAgIGRpZ2VzdCA9IGhhc2hsaWIuc2hhMjU2KHBheWxvYWQpLmRpZ2VzdCgpCiAgICByZXR1cm4g
c3RydWN0LnBhY2soUEtUX0hEUl9GTVQsIHNpemUsIHRwLCBkaWdlc3QpICsgcGF5bG9hZAoKZGVm
IHJlY3ZfYmxvY2soc29jayk6CiAgICBoZHIgPSBiJycKICAgIHdoaWxlIGxlbihoZHIpIDwgNDoK
ICAgICAgICBwYXJ0ID0gc29jay5yZWN2KDQgLSBsZW4oaGRyKSkKICAgICAgICBpZiBub3QgcGFy
dDoKICAgICAgICAgICAgcmV0dXJuIChOb25lLCBOb25lKQogICAgICAgIGhkciArPSBwYXJ0Cgog
ICAgc2l6ZSwgdHAgPSBwYXJzZV9ibG9ja19oZWFkZXIoaGRyKQoKICAgIHJlcyA9IGInJwogICAg
cmVjZWl2ZWQgPSAwCiAgICB3aGlsZSBzaXplID4gMDoKICAgICAgICBwYXJ0ID0gc29jay5yZWN2
KHNpemUpCiAgICAgICAgcmVzICs9IHBhcnQKICAgICAgICBzaXplIC09IGxlbihwYXJ0KQogICAg
cmV0dXJuIChyZXMsIHRwKQoKZGVmIHJlY3ZfcGt0KHNvY2ssIHNwa3QpOgogICAgaGRyX3NpemUg
PSBzdHJ1Y3QuY2FsY3NpemUoUEtUX0hEUl9GTVQpCiAgICBkYXRhID0gYicnCiAgICBzaXplID0g
Tm9uZQogICAgdHJpZXMgPSAwCiAgICB3aGlsZSBUcnVlOgogICAgICAgIGJsb2NrLCBidHAgPSBy
ZWN2X2Jsb2NrKHNvY2spCiAgICAgICAgaWYgYmxvY2sgPT0gTm9uZToKICAgICAgICAgICAgaWYg
bGVuKGRhdGEpID09IDA6CiAgICAgICAgICAgICAgICB0aW1lLnNsZWVwKDAuMDEpCiAgICAgICAg
ICAgICAgICB0cmllcyArPSAxCiAgICAgICAgICAgICAgICBwcmludCgncmV0cnknKQogICAgICAg
ICAgICAgICAgaWYgdHJpZXMgPiAxMDoKICAgICAgICAgICAgICAgICAgICBwcmludCgnQ29ubmVj
dGlvbiBjbG9zZWQnKQogICAgICAgICAgICAgICAgICAgIHJldHVybgogICAgICAgIGVsc2U6CiAg
ICAgICAgICAgIGRhdGEgKz0gYmxvY2sKICAgICAgICAgICAgdHJpZXMgPSAwCgogICAgICAgIGlm
IGxlbihkYXRhKSA8IGhkcl9zaXplOgogICAgICAgICAgICBjb250aW51ZQoKICAgICAgICBpZiBz
aXplID09IE5vbmU6CiAgICAgICAgICAgIGhkciA9IGRhdGFbOmhkcl9zaXplXQogICAgICAgICAg
ICBkYXRhID0gZGF0YVtoZHJfc2l6ZTpdCiAgICAgICAgICAgIHNpemUsIHRwLCBkaWdlc3QgPSBz
dHJ1Y3QudW5wYWNrKFBLVF9IRFJfRk1ULCBoZHIpCiAgICAgICAgICAgIHRwID0gJ2VycicgaWYg
dHAgPT0gVFlQRV9FUlIgZWxzZSAnb3V0JwogICAgICAgICAgICBpZiB0cCAhPSBidHA6CiAgICAg
ICAgICAgICAgICBwcmludCgnRVJSIHR5cGUnKQogICAgICAgICAgICAgICAgcmV0dXJuIE5vbmUK
CiAgICAgICAgaWYgbGVuKGRhdGEpIDwgc2l6ZToKICAgICAgICAgICAgY29udGludWUKCiAgICAg
ICAgcGF5bG9hZCA9IGRhdGFbOnNpemVdCiAgICAgICAgZGF0YSA9IGRhdGFbc2l6ZTpdCgogICAg
ICAgIGlmIHNpemUgIT0gbGVuKHBheWxvYWQpOgogICAgICAgICAgICBwcmludCgnRVJSIHNpemUn
LCBzaXplLCBsZW4ocGF5bG9hZCkpCiAgICAgICAgICAgIHJldHVybiBOb25lCgogICAgICAgIGlm
IGRpZ2VzdCAhPSBoYXNobGliLnNoYTI1NihwYXlsb2FkKS5kaWdlc3QoKToKICAgICAgICAgICAg
cHJpbnQoJ0VSUiBkaWdlc3QnLCBkaWdlc3QsIGhhc2hsaWIuc2hhMjU2KHBheWxvYWQpLmRpZ2Vz
dCgpKQogICAgICAgICAgICBmb3IgaSBpbiByYW5nZShzaXplKToKICAgICAgICAgICAgICAgIGlm
IHBheWxvYWRbaV0gIT0gc3BrdFtpICsgaGRyX3NpemVdOgogICAgICAgICAgICAgICAgICAgIHBy
aW50KCclZDogJWQgIT0gJWRcbicsIGksIHBheWxvYWRbaV0sIHNwa3RbaSArIGhkcl9zaXplXSkK
ICAgICAgICAgICAgcmV0dXJuIE5vbmUKCiAgICAgICAgcmV0dXJuIHBheWxvYWQKCmRlZiBydW5f
Y29tbWFuZCh2bV9uYW1lLCBwYXRoKToKICAgIHByaW50KCdydW4gY29tbWFuZC4uLicpCiAgICBj
bWQgPSBbJ3ZpcnNoJywKICAgICAgICAgICAncWVtdS1hZ2VudC1jb21tYW5kJywKICAgICAgICAg
ICB2bV9uYW1lLAogICAgICAgICAgICd7ImV4ZWN1dGUiOiJndWVzdC1leGVjIiwgImFyZ3VtZW50
cyI6eyJwYXRoIjogIiVzIiwgImFyZyI6IFsic3J2Il0sICJjYXB0dXJlLW91dHB1dCI6ICJpbnRl
cmFjdGl2ZSJ9fScgJSBwYXRoXQogICAgcCA9IHN1YnByb2Nlc3MucnVuKGNtZCwgc3Rkb3V0PXN1
YnByb2Nlc3MuUElQRSkKICAgIHJlc3BvbnNlID0gcC5zdGRvdXQuZGVjb2RlKCd1dGYtOCcpCiAg
ICBwcmludCgncmVzcG9uc2U6ICVzJyAlIHJlc3BvbnNlKQogICAgcmVzcG9uc2UgPSBqc29uLmxv
YWRzKHJlc3BvbnNlKVsncmV0dXJuJ10KICAgIGNpZCA9IGludChyZXNwb25zZVsnY2lkJ10pCiAg
ICBwb3J0ID0gaW50KHJlc3BvbnNlWydwb3J0J10pCiAgICByZXR1cm4gKGNpZCwgcG9ydCkKCmRl
ZiBzcnZfY29ubihjaWQsIHBvcnQpOgogICAgc29jayA9IHNvY2tldC5zb2NrZXQoc29ja2V0LkFG
X1ZTT0NLLCBzb2NrZXQuU09DS19TVFJFQU0pCiAgICBwcmludCgnY29ubmVjdC4uLicpCiAgICBz
b2NrLmNvbm5lY3QoKGNpZCwgcG9ydCkpCiAgICBwcmludCgnY29ubmVjdGVkJykKICAgIHJldHVy
biBzb2NrCgpkZWYgcnVuX2N5Y2xlKHNvY2ssIHNpemUpOgogICAgdHAgPSByYW5kb20uY2hvaWNl
KFtUWVBFX09VVCwgVFlQRV9FUlJdKQogICAgcGt0ID0gbWFrZV9wa3Qoc2l6ZSwgdHApCiAgICBp
ZiBsZW4ocGt0KSA+IDEwMjQqMTAyNDoKICAgICAgICBwcmludCgnU2VuZCBwa3QsIHNpemUgPSAl
ZCcgJSBsZW4ocGt0KSkKICAgIHNvY2suc2VuZChwa3QpCiAgICBwYXlsb2FkID0gcmVjdl9wa3Qo
c29jaywgcGt0KQoKZGVmIHRlc3Rfc2VxdWVuY2Uoc29jaywgbik6CiAgICBmb3IgaSBpbiByYW5n
ZShuKToKICAgICAgICBydW5fY3ljbGUoc29jaywgaSkKCmRlZiB0ZXN0X3JhbmRfc21hbGwoc29j
ayk6CiAgICBmb3IgaSBpbiByYW5nZSgxMDAwKToKICAgICAgICBzaXplID0gcmFuZG9tLnJhbmRp
bnQoMCwgMTAyNCoxMDI0KQogICAgICAgIHJ1bl9jeWNsZShzb2NrLCBzaXplKQoKZGVmIHRlc3Rf
cmFuZF9iaWcoc29jayk6CiAgICBmb3IgaSBpbiByYW5nZSgxMCk6CiAgICAgICAgc2l6ZSA9IHJh
bmRvbS5yYW5kaW50KDEwMjQqMTAyNCoxMDAsIDEwMjQqMTAyNCoyMDApCiAgICAgICAgcnVuX2N5
Y2xlKHNvY2ssIHNpemUpCgpkZWYgcnVuX2NsaWVudCh2bV9uYW1lKToKICAgIHBhdGggPSBTUlZf
UEFUSCArIHN5cy5hcmd2WzBdCiAgICBjaWQsIHBvcnQgPSBydW5fY29tbWFuZCh2bV9uYW1lLCBw
YXRoKQoKICAgIHByaW50KCdzdGFydCBvbiAlZCAlZCcgJSAoY2lkLCBwb3J0KSkKICAgIHNvY2sg
PSBzcnZfY29ubihjaWQsIHBvcnQpCiAgICBwcmludCgndGVzdCA2NTUzNycpCiAgICB0ZXN0X3Nl
cXVlbmNlKHNvY2ssIDY1NTM3KQogICAgcHJpbnQoJ3Rlc3QgcmFuZCBzbWFsbCcpCiAgICB0ZXN0
X3JhbmRfc21hbGwoc29jaykKICAgIHByaW50KCd0ZXN0IHJhbmQgYmlnJykKICAgIHRlc3RfcmFu
ZF9iaWcoc29jaykKICAgICMgcnVuX2N5Y2xlKHNvY2ssIDc0MDQ3MSkKCmRlZiBydW5fc2VydmVy
KCk6CiAgICBoZHJfc2l6ZSA9IHN0cnVjdC5jYWxjc2l6ZShQS1RfSERSX0ZNVCkKICAgIHdoaWxl
IFRydWU6CiAgICAgICAgaGRyID0gc3lzLnN0ZGluLmJ1ZmZlci5yZWFkKGhkcl9zaXplKQogICAg
ICAgIGlmIG5vdCBoZHI6CiAgICAgICAgICAgIHJldHVybgoKICAgICAgICBzaXplLCB0cCwgZGln
ZXN0ID0gc3RydWN0LnVucGFjayhQS1RfSERSX0ZNVCwgaGRyKQogICAgICAgIHBheWxvYWQgPSBz
eXMuc3RkaW4uYnVmZmVyLnJlYWQoc2l6ZSkKICAgICAgICBidWYgPSBzeXMuc3RkZXJyLmJ1ZmZl
ciBpZiB0cCA9PSBUWVBFX0VSUiBlbHNlIHN5cy5zdGRvdXQuYnVmZmVyCiAgICAgICAgcmVzID0g
YnVmLndyaXRlKGhkciArIHBheWxvYWQpCiAgICAgICAgYnVmLmZsdXNoKCkKCmRlZiB1c2FnZSgp
OgogICAgZm4gPSBzeXMuYXJndlswXQogICAgcHJpbnQoJ1J1biBhcyBzZXJ2ZXI6XG4nICsKICAg
ICAgICAgICAgKCdcdCVzIHNydlxuXG4nICUgZm4pICsKICAgICAgICAgICAgJ1J1biBhcyBjbGll
bnQ6XG4nICsKICAgICAgICAgICAgKCdcdCVzIGNsdCA8Vk0gbmFtZT4nICUgZm4pKQogICAgc3lz
LmV4aXQoLTEpCgpkZWYgbWFpbigpOgogICAgaWYgbGVuKHN5cy5hcmd2KSA8IDI6CiAgICAgICAg
dXNhZ2UoKQoKICAgIHNpZGUgPSBzeXMuYXJndlsxXQogICAgaWYgc2lkZSAgPT0gJ3Nydic6CiAg
ICAgICAgcnVuX3NlcnZlcigpCiAgICBlbGlmIHNpZGUgID09ICdjbHQnIGFuZCBsZW4oc3lzLmFy
Z3YpID09IDM6CiAgICAgICAgcnVuX2NsaWVudChzeXMuYXJndlsyXSkKICAgIGVsc2U6CiAgICAg
ICAgdXNhZ2UoKQoKbWFpbigpCg==

--------------IriCK4bm9IQpfAR0ABywHsp7--

