Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A40C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 08:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkHvr-0002Jl-GR; Mon, 26 Jan 2026 03:26:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vkHvf-0002EJ-ME; Mon, 26 Jan 2026 03:26:36 -0500
Received: from mail-swedencentralazon11023141.outbound.protection.outlook.com
 ([52.101.83.141] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1vkHvd-0003Za-Bj; Mon, 26 Jan 2026 03:26:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yqrlS/wZMpMUO22AFaR6GD0t54wFsaPhrojJ8/lyfqi5qQeuSuXmTp5Ez7q79R6c8lvlzZBy9gCFnxLBCut9IeQf5vqg0KW8HxyZq2OH04r07yT6gZzfb0ggkkt//j4vcHnrH7pzHL8IVVAeVjxsgyRuwFMLBWjc5a2JhDCr6X9+GwO/BZP4/kbH95mBgd5VhlmlOfD8yESpqt2qv519eSF64sVAQx1iKMR3ft1TV9FP3K600waZbJ8N+ccAw018y51YR2O/bI1sGc76zD9Qp6WUP4LXrq4XpXl0gWs5ncfVE3uOs7Y4KHeAcHDbZBc9xG9/RBjmlqVDVZBPB4fbNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPjtV7jSBvKxVU7xG9iaSF/TVx3XcnrQSaWrR46g2CQ=;
 b=BjyvcXohL5xKIkUrvE2TI1L8g30eaD+OMOMx2l8+8qZjFimjwH0/A50mWLrQejXqUQkNH1trwm552BiMVrIilJo8+/RDCMvAluGQMzsHkFcHyuZVSCewlkPi7XL4XCUZgterLtwwysDv+vT31b62NzwYbg/B6IWn7yCKic9ratmFIXNFYqia7zp/mCWd9n7sywT7+P/TGu8p3s2Ot4AcuXfP4+Av1tKorP1kBoFpDKi4f5yLdIMajWyhjV3KwOHi3AApZ6aOk+MPi7FlUSKgHEm7h6BWClDe5sqjoQASqp2a/0kxMhJS4XSzJ3hTOP80+7fQKWJBZnXD6tAUzbyv0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPjtV7jSBvKxVU7xG9iaSF/TVx3XcnrQSaWrR46g2CQ=;
 b=VllajCh2B7kbuPRoYdhq6xk+AEZ6fJ6Zf8NxLmKwcSolr+y97UJ9P1QY4jkX3mQKljIikinI2BNIkjz1nQ3+fSsfvBgO+Ic2CNtMxbVfT5RY9LGrgn5qFNxm3B2j/WJ0IHUq69RXu4DMpd4g7iVPpHoBc4ro4uZTPuYJdxjAX+7PnY4H9kv7olqB7wRA99nL1am4p4X5DH1l5LxGK+qU9tFi2SixS+lGAv9W1mU4fFNhRwKRbY1O8H+gOgc798xVHLoCO1CjhGv1DiJ3mF4zl7CTYIYQk2TMCmuVi03x21ZKZy+6+wHe/NX7d0uxdyLy0dGXnFeYVM+OTID7jkKP+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by AS4PR08MB7503.eurprd08.prod.outlook.com (2603:10a6:20b:4e7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Mon, 26 Jan
 2026 08:21:25 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%3]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 08:21:25 +0000
Message-ID: <a7ff0cfe-7798-4021-9a93-04456219e0f7@virtuozzo.com>
Date: Mon, 26 Jan 2026 09:21:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fix potential data loss in QEMU (missed flush)
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20251229161740.758800-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20251229161740.758800-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0015.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::27) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|AS4PR08MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ae3f4e-0ec7-4191-8e41-08de5cb3e599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkJvYXFPekNrMVZPd3JzS2szNnZzbUJsNTNIcFpBc3FiWGttQm1RYjV3VG14?=
 =?utf-8?B?NE5qbGpVeUZFc2RkVUlHUzNNemhZWkY3MlBQYzJZTGdFV0pYMXl0MDYwK0JQ?=
 =?utf-8?B?cVh4SnpiK2V5My8ySXYxaGhwWXltbFhOcHV3WWZqRW1reHRLc0QrOTA1cHY0?=
 =?utf-8?B?OHRrZjRaNEQxcE5FUzdsd0p2OVk3cTczTkdIMXNaMzJ6c3ZHQkU2cUswT3Va?=
 =?utf-8?B?S25reVRsSmdzV3RVWDRvTFpJekl1cWdJc1VneXJhbmNlZTVTbS8yOWl4SWtV?=
 =?utf-8?B?eGxZT0c0NThWb1pic3EyY201dDRYZ2o0clJZT1RNWFdmMXJBRXBVV09wZ3lY?=
 =?utf-8?B?dXFvL09GNGxmRTlGbGtQWjVoaTNiNXF2Tk1KQkdaRGc0bVZPd2xhcU9DaDNn?=
 =?utf-8?B?bmhBUkVsbzQyYTdkWWwyNTZFdVhORjBlZjh3WHdUaHVQTmU4Z2VaUmc0YWxB?=
 =?utf-8?B?dkt3SkdCbEZya3hKakZ0Y3BVNUZ2YTh5MzRyRlJ0aWRUTDM2ZVpSdHVlNTFS?=
 =?utf-8?B?WjErRWhOR3RaNTlBU0d1T1dSQ0xheVFCS3NGRE81d2EvOWdSRE1ReGE4U0pj?=
 =?utf-8?B?SGdWbGJKRkNQK3hnMnk3UzZkaTYvd2FUU1BDZGVicHgwODI4WFRIMXNhMlJP?=
 =?utf-8?B?d2dxajJTeDJZbnJpWTlJdnNGUmRrMHNoempnN0xYaWJnUUQ0ZXJqTW14Z1hh?=
 =?utf-8?B?YVo2WjlzSDJFQi9Tc2YranVMdEs2bnZZanhYQ0lMcG0vbEt2Wk9HbVZQcGV5?=
 =?utf-8?B?SGIzb0RNUUwxQ2NSS0ZoZVBCcHFqNmJoTDhveWV0b29HRmtCb0ZZRWd0Rmcx?=
 =?utf-8?B?VXNNdnJPWkUyMG1iTnoyRlJ6S2RyZ2F4dUlzSStFMHU5d3JGR01UMWM0dmZ3?=
 =?utf-8?B?Ulg3OS9HUWtiSU9SVU94R2dIYklSRjNsTnU4YVRoeFFtdG5XaXlibGhBVVM0?=
 =?utf-8?B?eG0xRTJUMkwrd1luckxDZnd3WnBpTEUrc3RZaWgvWmxGNktjalJKOXhhTnhO?=
 =?utf-8?B?TG5tTTlyaGk2aGIyeHhlMUVaTVhRM0xXK1R5VVJtRHY3UUF2YkR2cFkrUUlE?=
 =?utf-8?B?bXRIZExWUysrVXA2MTduR25vWWRueWEyaURnMmpMZTQ1SEEvbTMxTmJGYW4v?=
 =?utf-8?B?S2dZaFZQVUo3dCtOaEdNSnJiWEhheXpTamRvZW9nalhJNHltdi9ONDdPVmZ1?=
 =?utf-8?B?Q1hSZWhXdldGV1hveFZBbVBidkFTc1NjL0VqN2tGVG5YN3JUUk1kVWFncmwx?=
 =?utf-8?B?YXBPSU1yN2twYmd6KzQrMDIyc3ZjOSsvZ3ZmeWdtZEZXUHF0OFRPcW0yeklY?=
 =?utf-8?B?WEZVZGpCd3UzSHlsY1hpeXc4QlFGc0pGNUE0VUplNSs3VE9td0JUV05rbUdw?=
 =?utf-8?B?ZS9qdmZMMUFtNmpMUFZXd09QaGJpRVU5cjlBYUt3VmdDbnN2OVZiUDA2bGJD?=
 =?utf-8?B?NjM4blBrSXlidi9zYWZhTm9HTVNhMGFSRjF5UmVpcnZnL0VGaFVLM2dKK1k0?=
 =?utf-8?B?MVFvMU5hdlJlYWNndEZjbFMwUkptVmZJVllVUTNMN0NoWnNKbHdzcWRGQUxP?=
 =?utf-8?B?aTVrQmVzWFJkVW1BeXR6ODJUaHNLS3NNSXNtM2pucG9ETEkzTFRNWkp3aEZV?=
 =?utf-8?B?WmJaNkxsam9FNSt2a2ZZTEJKblF2T2g2bmlTdHI0SFA2Vkx5MlBoL2RBR2ww?=
 =?utf-8?B?cXhIelhjUitiREYweitDRUVNVzAvem14dG1jNmp5ZE9jNGNyY2J0Y0tzWHQ1?=
 =?utf-8?B?b1ZXWVJ1Y0RadDRXWSsyMWhWRlgzYmN5SzdBaDRuanlVTjg1M2htSzgyYlNU?=
 =?utf-8?B?YzIzcnNYVXBtTi95dTk0SmNNTVF4NGhKN01qZ3RPaHh2K01icFZlRmFuYWRr?=
 =?utf-8?B?bDlUcURFczhhOTZHYW55RElHbFMxNzJrM3E2UnV0ck5FVXJxdDIrMm5GeVZi?=
 =?utf-8?B?MkROblFtZ29RNXNKSnVGWTBMTzhZanhHeHEzQWIySFI2MXlqcUx2ZStNb09M?=
 =?utf-8?B?ckhZMy9jUURIWXprb0VacUZNWkNTN01Oc2QxNTQvSlgvTXRPL0hiSm16UXE1?=
 =?utf-8?B?TFV5di8vTE41S213dHdXb3J5dDc4WXdXUkc0MnF2c2pBZDduTm9VcnlZZHZn?=
 =?utf-8?Q?espI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?amJ3WnJhc01VbCt4TTlWRlhwZytwaGV5S1VyY1NhekN5RzRLeXQzN21PcE1Q?=
 =?utf-8?B?VXkybC83MWVYdkFIME4yWlY1NDJSNWZjR2dZM2M3cFByVXZjajJZdTJDRlE0?=
 =?utf-8?B?ZFJwQU41WEN4T2dVaHBFOTFRZHovU0RRNDlhSTdtVkg4WmtxZWc1TXJnN2RC?=
 =?utf-8?B?eUlzS1NBWVgxTlVuVG1oMHpUNzNHTWdGZjVpS1dvUXo5WFBKMTd5c2s3Mlpo?=
 =?utf-8?B?dVd3eHF6WkYxM2Ewa0h2cSt5YU52ZnRlTk80UllPY0NBN2RVUVRGbUV1M0FW?=
 =?utf-8?B?OFJ4cDJ3c3hkTXNhRzZjeWNnZnIxYnR5SnRFV3hMWGNIQWt3dU5neUp3c3M2?=
 =?utf-8?B?TU9RNmxFRFpqeHlHMUhGMVNzYmtza0VwQ3NxaXVRcVUyOCtUY0g2OFMxcEti?=
 =?utf-8?B?RWE2UHRKb1E1dmd6Y29XUHF3S3BvVFZyUkNlemk1SGZPWFB1ZjN4RnY5dHpn?=
 =?utf-8?B?bUpFamlTM1pVbUEyRmtxNCtMWGhvU1hXaFZoRTc0YmVReGlCWVRnTy9pOVlR?=
 =?utf-8?B?MXJmTEdrbTdBeVNKRlgweU92YU1lcEdFeWxTc3BHOEtXeDJkQlk4WGdndUpH?=
 =?utf-8?B?Rmxob2tVeXlDSEp1UkNmb2ZtakVxMlNWaUZyTGVHR1FVZTNkMVFSS2ZGRHRm?=
 =?utf-8?B?SkhkN24wYjFoVmJOZDB5Wm8wQjlLQlNvbUQyMllDUzRxQ1BqYTVqRkxRSisr?=
 =?utf-8?B?OEZyUENvR1B6U0NhZ1dFN3g1cVhXSXdxQjBIcjdTUzhWalZYQXBiSzluZ0du?=
 =?utf-8?B?V3djNDdzeFNFQ2xlSlUvNVpFUFhwUkJpU0RHTHlLN2NXcEZWelFLc0hNNldx?=
 =?utf-8?B?NG5HSkp1UHVmSzBveUJUZitIQU9LaThJK1YvVDBWSWFSdVp1RXIxOVZ4dm9n?=
 =?utf-8?B?VnFFZy91aVNEaENLSHFmckRwQXN6clJ0SFphSjJUdGRuVHBFdlN6TEhyUTVX?=
 =?utf-8?B?WHUrRXgvTWl6VkxFakM0Qkdndlo2RWNtOU1qZUxreTlIbVlMbURyZjRlMzZj?=
 =?utf-8?B?allFZWhyTFJpLzNSRHg2Z0ZVbHFrRUllckNDR0owUlVRQnJMdnpFYnFpNndJ?=
 =?utf-8?B?ajUvbFFmeGNmTHRRSjc1V2pIbmp2NGswZzNFcFRCVEpRWU5UYXhoYnlWUDYr?=
 =?utf-8?B?NGhNYVhKMEhMZTJjZndwLzJqQnBOKzRNb21yTjNRSTZhREJKbDd6aXg2bllp?=
 =?utf-8?B?U05nblROYXVOUXZ4amFPbzAvSnU1WjFqVXREMEQrVzM0WXJVREkxWUtKdDhv?=
 =?utf-8?B?aTBxRVlGRzB6QjJxTjNNWURLVmc5K3ZEOTZpcWdWdU4zQVBlVGhnVTREdVZn?=
 =?utf-8?B?UkQreEh3YmJLMHowcVgxdW5yN1NRSnZiV3Z4b2VQeFlONHhzUmsvTERMeWd4?=
 =?utf-8?B?aUZ5TGFtNVpvYWo2SGFqWmJ2T1BWZVk3SFpBRzlMQXZCVGFKMWxvSndNNTVl?=
 =?utf-8?B?TjFWTTdqK2tpbE00bjF4bm1Tc2hLcFJXZmgrem50U01PdkIrekZlSE0xNU5n?=
 =?utf-8?B?Ni9BdW1aRElJTWRGVXpJeUVmVG9wdVMxQlNTdjRURmk3a2lNNFEvUnEvd1Rt?=
 =?utf-8?B?VGRLQnZOV09VcTJlejRIYXQxTTV3a0wxZFFyL2JVbTZmLzFYaUFUakJXWGlK?=
 =?utf-8?B?U1FqbXNiOWYwdVFDdmp6b0w4M1grWk9OWlg4Y1g0cXBmWGZ0SEZnN0xVL2ow?=
 =?utf-8?B?aTl6Wlo3K0RvM0ErdnNHUTEyYzE2OEpuMStESC9KQzh3V09SZHhuRUNYcG5m?=
 =?utf-8?B?ZytmSTZ6UEw0YWd0R3FEUGl5eGY3QTVzNVd2cldBa2xUQ3dxRnVYcTczbWZw?=
 =?utf-8?B?dVR5UEVsMjVMdVg0SEtKQUZvN3ptbkVOK3ZkQnk3alRZQ0dpSWdEQmY1S1Q3?=
 =?utf-8?B?RW9jeWkzUWxkREJEL2pMVFZadHIxYzZOS09ETDdzVmpKR2FzV3ExWUN0YlZp?=
 =?utf-8?B?c2VZWnZkOHlFd0dHWFVOOWtDejZFR0VZZ0w0MXhHc2YxYmlNRFJOMnBSYzMw?=
 =?utf-8?B?bEJCdnh4RThvV0xDTW03WlR5V3c5eTBtaXRZUUFOZ1N1bWFSY3RObFFwbEdK?=
 =?utf-8?B?MFdlUnN6SFQ5WkxOdjRyMW9xUFJzcVRpMWdsT1prL1lCdGp2ektLNG5DYzM2?=
 =?utf-8?B?TVBvSkZvRFEyaTUzRXQwQks2UUVzd0duT2xFdzg2Ym9CYUdoUXdDcWdSQ2l0?=
 =?utf-8?B?dEowY2hhUVM1VjhCdVlja0Q3TlJObkd0L3RCS2Zac0FkUGgvQTBSczlKNXBB?=
 =?utf-8?B?eDNxTHJEMUlGZzBwRlBTcUN1NFhLZUt0OWhuY3BvekFzNjd0RVFGZkhxaElk?=
 =?utf-8?Q?u2uGT1gMa6lYTJKR2p?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ae3f4e-0ec7-4191-8e41-08de5cb3e599
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 08:21:25.5769 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GDc48c5YR7tKePmh2aVbci5H0YBeGivBZkVB4/FfIubonJNcgzaSFX0S4ZHSDxCq/ThIwZZGVH/W8f3pPizwbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB7503
Received-SPF: pass client-ip=52.101.83.141; envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/29/25 17:07, Denis V. Lunev wrote:
> This series is a followup to my previous patch sent under
> "qcow2: add very final sync on QCOW2 image closing". Could be considered
> as v2.
>
> This series addresses two problems:
> 1. bdrv_co_flush() at the end of bdrv_driver_pwritev() and
>    bdrv_co_do_pwrite_zeroes() could be effectively no op. The problem is
>    that bdrv_co_flush() is optimized internally this way to track real
>    requests which were making changes in the image and without such
>    requests from previous flush() do nothing. Requests are tracked using
>    write_gen on BDS. This field should be incremented after write is
>    completed but before flush is called.
>
>    This could be considered as potential data loss if caller relies on
>    BDRV_REQ_FUA flag which means that such requests are really lands on
>    the underlying device, which could not due to missed flush().
>
> 2. qcow2_update_header() must actually write header with BDRV_REQ_FUA
>    flag as image processing on open relies on the fact that header is
>    actual and it is not possible to reorder header modifications and
>    image content modifications.
>
> Changes:
>     * added patches 1 & 2
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
>
ping

