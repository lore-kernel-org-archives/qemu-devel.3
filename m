Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26EDCD98F7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waCA9-0001jr-Rh; Thu, 18 Jun 2026 08:48:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6223d7685=Johannes.Thumshirn@wdc.com>)
 id 1wa7rD-0003rm-O0; Thu, 18 Jun 2026 04:12:17 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=6223d7685=Johannes.Thumshirn@wdc.com>)
 id 1wa7rB-0003VD-01; Thu, 18 Jun 2026 04:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1781770332; x=1813306332;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=kZP0hMvilXcu59uUZ6SMBbwMdYoanTr+nwjR70NggdFQxBdM1ObotgZs
 tgg5h7y8z3COtZicg05Yon6RYMlWmoxEbMaaZEqAxT14nqBIqFE289gW1
 6L6ZwbKdATZiTMfKkQW8c1V8P7zCIPR9EdkFcD6s1RK/dGk+E0r2M+yUa
 ZK3hiZsny6r+eU6O3G2GpeX6LhvqHLQS6YROxyXMZjSVaxQI+MUEqVl4u
 SUZlR2hlM3KYYLQS7EACfYuOqVWzhnR4Xrf8e/jYS7MxvDsw1K9VtB2ms
 zlp3Sa/cYPzC7wGwgJPz88PlLcfWxE2MC9NfvAKxJUvQapGYn+wUWdyPh g==;
X-CSE-ConnectionGUID: kZzVRSN3SCWOPhSaYvwgVA==
X-CSE-MsgGUID: bAE1GXV4Rmyh3ZazdfgAIQ==
X-IronPort-AV: E=Sophos;i="6.24,211,1774281600"; d="scan'208";a="149047417"
Received: from mail-eastus2azon11010036.outbound.protection.outlook.com (HELO
 BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.36])
 by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Jun 2026 16:12:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9Lp+3AbWc0PAU1sH3WJj3mHiYZPkxN63GhhobVUYj36ZkbtHpCOmrWjhFo+mmdrIFYJ9sBhlCpMxqNAEmTQUKu41YJ5JsHgyp3zTzsQtCkeeaG55KMPumNBkJm5+6jxDPlQBdxPnR6d03f+BqDm+C9nG9oqulAqo6kutbl2zTshxEX8ZK+DxjPkhs3BbOy23p9A0fca6xcVzUZZlg1vjTBXkJPdShKPjjbuFrKCpjjyJ6pQAwj7G224BclmrawRtAaZY4B7jijnDqw/cvqzsOSggzwgdaK3xNjF8s5qdI9OaUNVkSj7mMUtVfaRZP4MiEHd7QRAp3jEhWKzSUO67Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=JpBOscOOCh4cEHiKyuTzuU/LpnCQf/mn4HuUXhbKtie+cVKi59VGjqHdjFjzidNKTRgq7lZ+L41ciBXGVTwnzANyDCCKnm729Pn3rX79dDodkhYa9pCCvpweupUJNilOkUnl7YMX/gslI1x6Nm501O5wkDR0u70yvdskGkRG08tY0uF27Zo/6p9y1nJf5ano6AXdUH18Qz6ZU95/TaS73r171VMYCtQyaEJOmvKI0OdCWmMnyLh6FKvg0jags9sm3u0NAvv2JvgT5w0bXllehsfrf3I/SHZHrYYPK5Ps7BwYGkT9YST55mBjTjZxkN6UV2v2y/RUFh2YFZ8F5lbriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hFm4yO+V2KgeQG0ik8lLOHczCQdLX2syeEcd394fgI=;
 b=Ht1yt3q+HlzDP46t8IkfQGbr35tMG+k2PycOGuxgRPEKNUIwEI1ea3014vpyLNAgAG9oUGw2dPW1xvoAnCfR1KMr7/kS0iNoZD/ChzGbHWabU99uJIbZsy5jHRfCJbBrqsq1PahA0fWG389z9dRjzDuzfy2umMOn1Jy7iViemJw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
Received: from SA6PR04MB9447.namprd04.prod.outlook.com (2603:10b6:806:436::21)
 by DM6PR04MB6542.namprd04.prod.outlook.com (2603:10b6:5:1bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Thu, 18 Jun
 2026 08:12:05 +0000
Received: from SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825]) by SA6PR04MB9447.namprd04.prod.outlook.com
 ([fe80::14c6:1c14:485f:1825%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 08:12:05 +0000
Message-ID: <f12efec6-89bf-4f58-81bd-6b28fa98cea6@wdc.com>
Date: Thu, 18 Jun 2026 10:12:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] file-posix: fix cache.direct=on check for zoned block
 devices
To: Niklas Cassel <cassel@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Dmitry Fomichev <dmitry.fomichev@wdc.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Damien Le Moal <dlemoal@kernel.org>
References: <20260617133658.2022750-1-cassel@kernel.org>
Content-Language: en-US
From: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20260617133658.2022750-1-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::16) To SA6PR04MB9447.namprd04.prod.outlook.com
 (2603:10b6:806:436::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA6PR04MB9447:EE_|DM6PR04MB6542:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b6e2437-a9fb-4c42-fea4-08decd11489a
WDCIPOUTBOUND: EOP-TRUE
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|1800799024|19092799006|366016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ojzbesGzWW0/v8MFZKGF3t05Mdf2x+FG7WzH01WhM3YMh2NFgtvo7A9H3xnfQZEfKlFlqKrnrwUL7iAI9KKEdaQbIVOBfxTqPJrt2zeFjR3gZciy0+s4zTJ902th1LbiO2oZKouMuYXhWOCNey04ANI+rlEEoar76sItI6Tsn/FEZp5ifIQb9mnBbQ703Mm0eRt551+VjI5y8pJd6DnPLeQ9Q3Uzv85uMbPX/dtQADIVkcC+j1TWuIgEz2TGSvkeTOkH7eFl+NhKA+sTPba1oHirfWwZ2k93O32T0y/7wcK/obursxoLVaImPUOrRK+ALqUBiDVjw05kBkH3NwUKOID/eeKeG6SKaDZ2c32bTmIvVLoMn9p8aVC3KOqYHDsel9+3yBXezPIMXPrGEX/j30Af5e5+Gy5P5S34zKG7AO77IYo5rBl9wPLB3weulQPJr9GyNacrh0kqkeNDU4mS1MOOnfpm28h7vfnvSqHeWrmmhGoL2qDALx/iYcCefoolSHTDfctPhdoJyMkq6uIxPbKb2bFYpwhf4Z+32AoYiIcg11yYPiSOM3HYaKQxzZNAj7vO5BCvT3KUsam1t6E9BWQu8thObeUeJX7dW9LfHJC5ORsyoILlb6cgtJiJYLPyXq3VAg0Zd8v92IGmgxr9GkkqSylDtEzPGVvKQuYgHu8qW5ZSnNXhuSlViui1SsS8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA6PR04MB9447.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(1800799024)(19092799006)(366016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWE2VDdEcFBpRkM1TjU1azM0cXEyQTJBT1BVaTNnMi9tUlJqTW9oTTE1U3Ux?=
 =?utf-8?B?ZjUzc1l1bGFCN2QzMGd2NmU3ZVJnOHhuenhIbktlRzdLS3NscndhVXZsYTFj?=
 =?utf-8?B?TEFVVTMyTzVmRnc5WmFGcWNFak11ODc0RXpOMEkxQUpWakpEM0xNeHc0aDJj?=
 =?utf-8?B?RnA5NDRLdFB5UEMwM2pxUHBra1FsZE9kSVhJVGFsTWx0SW9FSXBuYzJPK2FQ?=
 =?utf-8?B?bTdvWEtJdENsT0RtZVpSQjdYNzArU1RDcTN3eUtlQVFHWGpZS0NyaWpqZmIz?=
 =?utf-8?B?RWtRbENINGp1MzJOSlRjVFhoazViN3QrQWNmclZzajMySG41dHZUaXREeGYw?=
 =?utf-8?B?SHE2c3ZQenBtYUZtb09VdDVibVdhUXB6c2F0RDI4N29mMXNhamIwR2xQOCtr?=
 =?utf-8?B?OUwzZHZCZERnN25TY0xPRGp2L2R3djBJcjE0VUxmeUVqbDhaejBzSzBySnNV?=
 =?utf-8?B?d014akVhczVvMENEckxPS1dvYUZDaUtTcjI5RjJ2Mi9laE81QWhwL2NJMTNT?=
 =?utf-8?B?bkI2eTJqWnFHdXhDQndRbGtMQlR6VVNsZ2RkU24rSVpVT0ZzKzIvQ1dwcHdE?=
 =?utf-8?B?T1Axb0JtVGhpQTdsMlFlR1B6Q0JCVklKWTR6dkJ4TWJBTytKV0JZRmV5Zzhw?=
 =?utf-8?B?WDhsSm1xRXRYUzZaaXJ6UVRucjliUWM3d2xsQTlnNTJZOGl4aWlmdkJIK2V1?=
 =?utf-8?B?Z0xhdzlyWVJNTVFXTjAvQWZIOCs2dEtCQ2o2RVlYdzE1Rlk2dnUwUjh0cUZG?=
 =?utf-8?B?bkwyOGdIRDV6R2dxeHFnV3hFbktYRWpRNDRtWmwvU09BdjdmSjF0UmtmMTNZ?=
 =?utf-8?B?cUV6a0FVaVRQOTdkYlBubFdtS0dmU3hjVTdsV3dFRVpabW0wNENrQzJUUFQ3?=
 =?utf-8?B?MG45emFwenhrdG1CQUQ4a2R0SmVXL2lIMlp6aHRtVGYwaFNsd3JML2txQWp2?=
 =?utf-8?B?b2pEOTM3NkRUdVZNeUhyZFFQN2tUUWtpNVNWazVicnVYTVhLSitjSXNLWHg4?=
 =?utf-8?B?U0FEcklVRUxZK0RXNE5GRTFpME5UaGg3NWpLZ09jbEFDWHVhZnhOaVpGUy9U?=
 =?utf-8?B?RGVIZFZLeW1ySUdFYVFFK1owZk1mVnFkZm9xbXFKVXlRQzRvUWZQQkxkNUtO?=
 =?utf-8?B?YWpRVCtKbXphMDYyL1BUNFpYeXFGTW5DWFE1NEhmam9VM29hWXlNR0FhQTRO?=
 =?utf-8?B?VDdGY0dtMThIdjBUd2N2TWdkZnlTNUVaSDBqdkxyVmNWVGtmVzc0dCtZVzZ1?=
 =?utf-8?B?d2liclhWeDFWMFZhVWJMVDdCNzhRZEFyMnhSd09OcXBhYnRWajVhV0hITStl?=
 =?utf-8?B?SmVoNDVhRlpQcWpKSjVyd25ZckltTXN1Q3NnSUhsTHFpN3NJTmEvOXhjU3NC?=
 =?utf-8?B?RjRPSUIxWFFHeHRMcmlGa1Z4dEgvZ3l0aTBSa1BvVWZNYWwvV2I1MUduLzhV?=
 =?utf-8?B?SG5MTWpUNUZSK0IzOWVZVnlzLyttVzdPQVdkS3daTWJ1TTRzaWxEd1ZXN2o1?=
 =?utf-8?B?RUxaaHFDb1NhbUtxa2Vua3l2TmNLakt5ZXVKT2VOd21hQmlDOVBjaUsvd3NK?=
 =?utf-8?B?ZHdKUy9vNFhxMFRER0RQeVBXRDlKRVRqZHBGV1RTdUhGVWlKVlJla2VQNG9W?=
 =?utf-8?B?QlNJUjl4ejFPWU1pcHIwT1ZIaUJ2NTg3ZEluZERHZHZiUVZpaG8yNWxWak8w?=
 =?utf-8?B?ZHFiR2RtaW5hVGIwWnpydGw4SkNaMzlqWVFvNHZVTWRZNFM3U3oxaDYxcGZx?=
 =?utf-8?B?TlhoUlU2UVVVMzQxdUdCaDllWW9BNkVVUjFEbGc4NGI0OGpHOXhjaWtsQjhv?=
 =?utf-8?B?U2FLWndwbHd2dVNKUGR3Z2Zxa1o0bnh1VkRvVXFuRkhiK1lEM3phR2Y0Q01u?=
 =?utf-8?B?bEl5YlRFU0VrajU4eWd3YmRBZWdVeUFIcGNXS3NZV0NuVnVuZ3Bnb2tKcEhj?=
 =?utf-8?B?emRCRnJoOTJ4QzkwVDZYVFZmbXBhQlV5cWJYcjBnbFh1UjNUSGR5UDlHYjdv?=
 =?utf-8?B?QzJtUU8rSC80UmNrUHgwUDhGV0VpbVNNTFFYK0RQajRMR1hwMkd3N2xERFdt?=
 =?utf-8?B?ME1tWnhHb2VrWEIxOEtEL1UralhubVdSK21WNEpSc3ZlTmlnVHpIYWFMRG00?=
 =?utf-8?B?d3R3cXJBcnZyeURubHdpMmlpTzNQbVR1V3U1MVptenF4UGc1WnZuNFZKYm5M?=
 =?utf-8?B?U3Y2OVgzaXlINlEyNDViS1VSWStvaUYxRTJzSXIzY0JxUWVtR29EY21ML3o3?=
 =?utf-8?B?Y3A0MngyVk5yT1U0cmkrbk9tSTFOUG9hcFJvUEVPVUJRSzZ6M01xTktaWng1?=
 =?utf-8?B?a01iTCt4dGFiQW1rSjlJTThFRWxudjhnVTNjK1ZuQjFnRTRJWm9tYWkvcHZF?=
 =?utf-8?Q?fxMl+buUwUsG6tHPK7Ly7VmDWhxOMi69CJrnzPml1i7x1?=
X-MS-Exchange-AntiSpam-MessageData-1: G4ZHBRa+4urexw==
X-Exchange-RoutingPolicyChecked: cdNYqtoEM0f0hVxpMMLRmOlIr+2fNYJBk0ERFRiwItVLGDxkcJJa5VghTd8ExGD/jaXSKofGVbbqsAeuOddbFHSepuJ9dGufrWK74AQYsN3Dr9zTHN2n8o1n/gjaVB0wN8vEDuCZnrqDFD7UfXXGAJUkC69gFB6X7VC80eGpKSxXJJGYziTxqYfKXFJmJkIdRIm0WalxRQ5LQeIhOKB/bR6R2XGKpT1G2DWsFf3agvsZuei1DXa+dYKyS3TRONw9+7fYkTMyufrYEIYqMeJk7ncbi9n9xOymXxZE0KFJ+zvl6L2yv5rLMdOr9bIxTRpTSJH7nnbZnF2auDkKm1Hbiw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ATGdPZPgIp3cpbR+FoEhGjFV+sGTHJ053+5mRw/onUkvXlwY8BKHCa0fgGQmOeFfjRW1rrOd1BpY1MsGPGRQE4WUqkYoNF53uUWkCvz7xAbenlTgbZfbe23/AxCBt2j5i0OYpuD147Ek9GRxEnYQRNmkSLqSRQ+bIhkKAFIqQiYIlcjzGuAW8ybeM5FFhY8DyqexUk5+iPZmJw46aF9I7U0SqNJBxwPCVJUuzrpSaDYffaUM1/3/iIm5w9sOpkqmBVxB/H9+hkOZ7MKGG2F/NS/o26qzHarJCkWX4eQP6JiVjHoh8Kl99pJpzQJdmQ7xFjf37mg9cEPE6UxAYdTwKDzViNY5paMAdELxoMlWJ6ZAY4lMFJihkakbNgQNk8MZl03HffiESXn83jmwUm6J6OtkTpU6AZAJuOzZsXd3uM4XRNC94ksUhOmiL+8kKBr3JlxuSjCRbc2x/oELovLZKyK9+Rf+gmAtKqcpZVTmkHAm7J5buLyP+BLTWBYf7lpeNbJyKBKMH6g1m3VBCwsiSZD8FPla5jxeevpjZC2Uc7GlRKuCGQ5ICPcEsyagP0ehp7TqIFY9Kn/zK1S2TT/Dl/q8RK4xUYuvap4rtu7vbJjO9lWOvVDN+qKFtfIo5Att
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6e2437-a9fb-4c42-fea4-08decd11489a
X-MS-Exchange-CrossTenant-AuthSource: SA6PR04MB9447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:12:05.1974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYG4E92ceWK7mNPxzLsKN0d+DJucJlOyfm5cHyu17oAk3TCU9ExGx8u2f05iUHvMnCDYBi+Qa40GxBwAH1abl6mbsy5izU9+G5p5DMwWkfg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6542
Received-SPF: pass client-ip=68.232.141.245;
 envelope-from=prvs=6223d7685=Johannes.Thumshirn@wdc.com;
 helo=esa1.hgst.iphmx.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 18 Jun 2026 08:48:00 -0400
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

Looks good,

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>


