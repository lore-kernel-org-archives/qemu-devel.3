Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9806EC5DF8C
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 09:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwciR-0006sk-Av; Wed, 19 Aug 2026 05:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wwciQ-0006sY-QW; Wed, 19 Aug 2026 05:36:10 -0400
Received: from mail-swedencentralazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c202::7] helo=GVXPR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@virtuozzo.com>)
 id 1wwciP-0003ts-Bf; Wed, 19 Aug 2026 05:36:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXkBSwTipyk43jxD4pUIPi+i4y5udZP/gO0wq9qapiKKZBfg7qkb/rQ8crNIYNgpaI7xRC6WY6fU71jQn8A956HmLivTfvVhx+iBvMnmfCu9G0v32tLDj8lBVOm5H4m/JlP9OiffBrt1i8HLYkgqv+cvMEzLBegbwcGdRJRlmiq7ujfnXonBor9oizGIrRYH6gauaSTX5t1ELLn1TqJHsbPfP5u1rQXLk7rlhkA6ka7Yo9AyTrjGzOEZU75Idy0BGl39+a0nW6wGjJQQ8PdZC0Reh8IuYHdkV2W9FxpvEiUXijT7r1w1XzpacVl+gGq43aAto8NOaDqONPX/K0oECw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G+yaEnnrUXi81Nf54ly5Su0hqvYd3akqqr2EFrnPQHo=;
 b=n9mSB2SbEwG+gzLH5W7WPX8Hl2c9wBOkzlhiVkShRks/EndNaSdfbBf0SjpZvfo5ayi+k+Qv+gjswFHkbMjvXTbQ9e6563w92Cu/ZSBjUo+F9KMcjGGkTRcRdI/n/RtgXacU6Nvo895fL1vB2k3/fpu5buMNgYjO7xRYCznFlz1Qo4SvJE1TAV3XE4XzZq6vHSZVAqEJ+7o2XuE8aGLGdh0YieZVvMIkMfkQNLFmd/MH6A37wF2kdpFyJ53r4HrUKd3bjhAa7ye/GEvXMSQL8pxt6h2N+Hi9e8ZDTujgchxL3Oa+3ChwqNmUq0DesvU372zaOUYHwRhNtbSIFJPNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G+yaEnnrUXi81Nf54ly5Su0hqvYd3akqqr2EFrnPQHo=;
 b=OpFF0ggH9UNRYLZC+0bV1cY2GM7BfRjp07l0u1kXyO1a5YMGZMfdK+e/1Uk0iLgrDqdRfMvjlov6xAH7q6OIXKIo+F25iQws6Ex/cOooYOszommT4hZoeU3Fg759wKrQnyyoc2pAXtuEhhWL4SMIdqY6jgl5adBhxR+sAZwexrZqiMI34D7wo+ZzGZ3WZOJR1WIMDpSJ/nu6TkFRury1rBG+uMPyfeE9J0qWsK1O2Mnd9UXHSVmQgZcc5nVrkyjhrBFxhfFQXfSFmrQ9N1aNftM6A4DNi/fSltvTtFN2vdtR5r4RFIdFnh+b5n1dratDd47NVs6T+ajdiCREDNMUug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com (2603:10a6:20b:2dd::16)
 by PAVPR08MB8823.eurprd08.prod.outlook.com (2603:10a6:102:2fe::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 09:36:05 +0000
Received: from AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd]) by AM9PR08MB5892.eurprd08.prod.outlook.com
 ([fe80::94bb:633f:1f55:4bbd%2]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 09:36:05 +0000
Message-ID: <93a334b6-3aac-40e3-b7ff-1aa6a427abca@virtuozzo.com>
Date: Wed, 19 Aug 2026 11:36:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: map the last From-munged author back to a real
 identity
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Eric Blake <eblake@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
References: <20260812112456.970371-1-den@openvz.org>
Content-Language: en-US
From: "Denis V. Lunev" <den@virtuozzo.com>
In-Reply-To: <20260812112456.970371-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR08CA0003.eurprd08.prod.outlook.com
 (2603:10a6:803:104::16) To AM9PR08MB5892.eurprd08.prod.outlook.com
 (2603:10a6:20b:2dd::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR08MB5892:EE_|PAVPR08MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcf8c72-1a66-45a1-b460-08defdd54abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 4vuI+8NJGgCSO3FgXGStDospYVQAOEGnOggJFaN5wBC9zEolTl6VZxYqR/oBfocdTICF51c9ZiV2iJo9ZDwKHOvv0Us939L4qAM8GiWyznnDrkhxVyoAIzXbuFeMYYeEOQ042S8j5uLYMUqDx9VpetnaQfO6CL5+qYzVlVYGSuVyC3GnsFUitJ4OFsEsyjoqZjFlywIqPxnRsLVBzDyYuQCI5noJLHMDosgGiCxh9NOd5+7zlQ6ZM1MtTpJ6OvOLyab8WYJrEfcALkOEg3Y16tb8DajJ4oDfHc2fA3oph80DcPUV9x0c79A3YJoZ25uYOZgJS0feF7enCHqvWwpnQkpiQyjgusc4LDS1TJsEkBOSwrKm4Itjzs7jGD+2mZmvnu4PoP+D1ys/7e3OS9pSXrFMOsxPYpAM2mdWQ0SqcTkuBWQMo11H8td1sp2uwYIPLdaaZ9KUEGBzHzGMT7IjyjXnv/ekuE4Qscp183MW2mdx7puBlgnXJNPq6hQRRNH4wvbvoaS4cgQzbLlIPTOF/B3hkU6BlzAI43vvrCTjKaFNBsujvGKCUGauHVsg7nMHiZyQXOn4/W4JOOzYHdWTCkjCpWLER9NlkwmfABTlw1w4nhKrgPd+T7gv2BlG6difmGe4X+jszfhiflwxeJqSzWP+lz42Gh4limXZ9D2+cUs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR08MB5892.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YzJDek40a0Y5N0tKa2VxaytqMkdFOGZ4ajlwMzF5RzJ3OHFxQUNzb09NdnRJ?=
 =?utf-8?B?NDJEOGxJcSs1Q1lMTjJKWGVJWXNkWnlxYVpxVzZYU09XYTJ4R2pORDNwL0Mx?=
 =?utf-8?B?TURGZjVPSWtwTzRPSFFlSmMyeEE1WlRsZE9WRk9ySnYzWjRwR0RIWDVxaWVE?=
 =?utf-8?B?UkVKM2F4S0JkczBNa3dVNW9XVUxabGRZL3ByMVNrKzEvMjdmRDFlZmpUTE1K?=
 =?utf-8?B?c1pEVXUwWG5TeGJMcVFhOGFPTnpxc0JPWUszTDFvdkRNelA2Z0RpMFpXYjVn?=
 =?utf-8?B?aEZxb1MzdHRRenNJK2YvUk9YK3I0NTluaXpmVnBsNE5peVNWdXdlaVZHWUtT?=
 =?utf-8?B?M0h1T0tMbmZSUnh3c252bmtaOHFKWlExeGJjWVZpN2FzbVI1UEV2N0p0MEZP?=
 =?utf-8?B?RnRLT0cxRG5saUVxRnovS2w2WDJmZE8rRTJUOHpIUlVFZXdDcnUwNmR0NHZl?=
 =?utf-8?B?bk8xcFY4dkR6dDdrQ3hwaStaNUs5aklHeVNJTCtMbWs1QnFtV2VtRU53RXJH?=
 =?utf-8?B?VVgrM3BWSmx2MnlZTzY2MTYyTzR0ZG9IZDQ1NmJZWm5JMmZWUTM2azZXeUFX?=
 =?utf-8?B?akpkblRBdjI4c0JGRXJ1RVNackptWmplVmlhYkN6OVNtUGdpWHVFekFqMUox?=
 =?utf-8?B?NFBMR1hRQUlac0pVdG5Sajg0QW5KRnRzKzEvRkN2RUxqM3dzL0xscDFQeUwr?=
 =?utf-8?B?cHBGNFNleE9zUWljUllGTGZqVXZVOFZYWmRKRnlhT096NnRoS2pzTVVqYkxv?=
 =?utf-8?B?aS9rOWo2RmFsbktaOTNXRE95U1prREEvS2JqekNHRWxIVmxZTkhDWVJzL2tJ?=
 =?utf-8?B?dUZHSDQ2T3FPK3UraldKRVJDNjRUT3VpZFVQNW9uclpaL0oxNnNwalNqY3lZ?=
 =?utf-8?B?SERmTVNRamZ3SzlOKzNUVitsMCtETUdtMEpsMllLSGVlaXV2L1JiVG90dWlO?=
 =?utf-8?B?QVpsTnZDcFo1NnJHa3YveTcyUWUvR1ZPSEI0UDR2VjgzRUZDc1hoYXNqVWdC?=
 =?utf-8?B?ZXNpUkI3a3lzc2xJSkExampOdUlVNjVKcjRmdUd4bVBuVDVkY29mdlhIdFY0?=
 =?utf-8?B?K0UvOVFMOUlGdFhKdXVUdE1MZFFxV2pha3JNTnErMTVhV2hNVDZsMFdDQ2ZW?=
 =?utf-8?B?S29ma0NaRDhFbFkwWGZ4MkV1dnoyd2xNMXBuV0ttdmdqSnFYbWd0TnNqanBW?=
 =?utf-8?B?TWpuWjcwY3UvcEd0d3c4N1pZN0xVaXh2ZUg1ZmIwSGp0bE9ZeXUzZTErMlFw?=
 =?utf-8?B?SGtOVk5ZRHFCZ1Z4MUFudDQvSEYrYkd0QU1YYTh6YmIvYnYzM1NBcmJ3UzBR?=
 =?utf-8?B?SytpNFhjVGhtTDZ4WkNKOWhiS0Vac2Q4UG5KUERzd1lRRmZYYkVtQW1zT0p6?=
 =?utf-8?B?YlpRWlJKbHZzMlVGOWxQd29QSkJXdVBDV0xhbjNSUGNZTnlHOXFPc29oUUtl?=
 =?utf-8?B?bFp2Tk9FcHNFVzlwb2pzby94WFl0MzYyajFGdUZNNGx0TW9PVXA1dTZteVpM?=
 =?utf-8?B?UVBCeGxDOENJMnB1VFB0dERHQWRoQkZScFVibkFrZlVBZUJoTXhuSStIOFoy?=
 =?utf-8?B?eVdta2Nkb0dpd1VHd1RiSFRpVHNuWTVHcmRXUGEvREJYRkVaUDJwOHBSWVJx?=
 =?utf-8?B?cmFkQlBaNUxsSUZqWWJncE9kVFVKd2pOL1pzb1hLb1Q1eE1xYlB4MHViOWhr?=
 =?utf-8?B?SFNQZGJ4WGoxaEk0bjkwTDdQQld3NmhGL29xcEtmOXpEMXZ0UlNGY3Y4ZmM4?=
 =?utf-8?B?enRrdmVXWkZuMy9PMzVUQWdLYkxSdlRQMFpGY2RRSXdwSmNQK25VK2pkMzU5?=
 =?utf-8?B?UEpoNTkzU2wxQWdxaU9DYTJCSnIveWhLaFNleUpBdVAzY2VjOGVuV0xZZGdu?=
 =?utf-8?B?TExXQ1YveHU1ank1WmlBVC9QbG9TTXVPRlZ2SDg3VDl2MFVFNHkyN2RRRHdy?=
 =?utf-8?B?SDl6RzFLS3lFYWlCdFpNS0xhNzFkeDY3cklPSTJyMU1ZWTFRVWZ6b1UraHQr?=
 =?utf-8?B?OHczL25xdDVnYzZRQ3NRc3N6aTdMK01iMXRMcTV4bmVjaUk4bTRlbjV5ZS9y?=
 =?utf-8?B?d1lwSnFDa1orRGZ3RXF1ZWxySUlZOEVySTViY1VOdlVGZThqNS94d25ZODJ5?=
 =?utf-8?B?eE9aUVdtOG43UXQ5UjBrSmhMOHozM3ZXcUk1NWdJZUNYMnZkR1dubTZmRHJw?=
 =?utf-8?B?Rjg4Z3VOak85MWFndjhncHcwTC9nRFR3dTk5eTlES3lOa3A0aXZZa3lNaWpY?=
 =?utf-8?B?amdVeTBITm5SYTdCQmVZR3o3Z3o3NEttMnFIRm8zTlJDNmo3MG5QSTNGYTdp?=
 =?utf-8?B?MXZmbDlwRXBaOENuRkQ4dWxRL2RTTktLTStBcHBMTGRXVlZ4TGZMSmRxcHlP?=
 =?utf-8?Q?wOv3b+vJ2mASky0o6P7qMYfGKfD+RWH/I6vNOHi922saZ?=
X-MS-Exchange-AntiSpam-MessageData-1: yZZFrsFPN5GGFw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcf8c72-1a66-45a1-b460-08defdd54abc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR08MB5892.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 09:36:05.8167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZokWSOc620SgVTKMRJFW7nXLHPxF0GNZ/N5zbeUumEGWdPq8BFUztao8k8NdfLTudw5MYhuon9Tb/FxjH8pPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8823
Received-SPF: pass client-ip=2a01:111:f403:c202::7;
 envelope-from=den@virtuozzo.com;
 helo=GVXPR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 8/12/26 13:24, Denis V. Lunev wrote:
> This email originated from an IP that might not be authorized by the domain it was sent from.
> Do not click links or open attachments unless it is an email you expected to receive.
> qemu-block@nongnu.org rewrote the From: header of commit b67e353863
> ("block: drop force_dup parameter of raw_reconfigure_getfd()") for
> DMARC reasons, so it landed in git attributed to the list instead of
> to its author, whose real address is in the Signed-off-by trailer.
> Map it like the other munged identities collected in that section.
> This was the last one left unmapped, so 'git log --format="%aN"' no
> longer reports any author 'via' a list.
>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> CC: Alex Bennée <alex.bennee@linaro.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Michael Tokarev <mjt@tls.msk.ru>
> CC: Laurent Vivier <laurent@vivier.eu>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/.mailmap b/.mailmap
> index e5dc644623..08f0fa9e11 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -68,6 +68,7 @@ Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-devel@nongnu.org>
>  Stefan Weil <sw@weilnetz.de> Stefan Weil via <qemu-trivial@nongnu.org>
>  Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> Andrey Drobyshev via <qemu-block@nongnu.org>
>  BALATON Zoltan <balaton@eik.bme.hu> BALATON Zoltan via <qemu-ppc@nongnu.org>
> +Denis V. Lunev <den@openvz.org> Denis V. Lunev via <qemu-block@nongnu.org>
>  
>  # Next, replace old addresses by a more recent one.
>  Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> <akihiko.odaki@daynix.com>
ping

