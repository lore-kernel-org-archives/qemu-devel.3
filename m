Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE12C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 17:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugRfT-0007ub-1G; Mon, 28 Jul 2025 13:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugRfP-0007rP-Ll; Mon, 28 Jul 2025 13:29:39 -0400
Received: from mail-mw2nam10on20616.outbound.protection.outlook.com
 ([2a01:111:f403:2412::616]
 helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1ugRfM-0005jZ-Sx; Mon, 28 Jul 2025 13:29:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D1020jTuzJxj/spZpAftNuKQGh5JXH/Xbzz5MnzT1gDqVZugZEdL3Y3o6rByuXXu5Tn/QzZBXkn+eAJH/GOdWttCkLLa66gIeZJMHTjcLLoO2WByq/ugjjzcC+hWUeiDXyjYWMmW2P0L+slHKd1Mi69qSdhnNIl7eoMrZWmv/uKt9q0oQFqTZ3gMjUTqJeu84iBFYu1h1iOrnHptjkK1WYZSHyYWcNL3+3Tlo+FPMaxC/dIqtpkAsIdgIlqtv42ns5KnYdmL5aI7rdKDQatFn6V9ypewHHxQt4zBh9CH7ysiCw6C7bkyAMsguTxm+vEvwksAbpYTBkQkT6VRcNt65A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFl/xiD4u2ja5YOR38ETFsXhGCXUOvhb1i842imQXWQ=;
 b=nRfdApKHqyjpH2rrKazFtANPN7au5CrelxmUi4ERfhnEpCObjX/2Nq6OQDXOgzZMrCZWnKSWzvsiuUHSdVANk1CD7YHbzfpSecgGDdf6HiAkkNrDWUhjpED7ZyVLD7S5I6dxzQcwut2dQpIzkrGvpGQZU2qyBqAeX/KvZaZbYUt6nbDxadJshtS2uWK+k8KFucGfiaaLr9vzV+Io5LHsKLe81ENSEHEq5IXd7ISQcOYVR7QS2Zz68eMxQYAhbPD2zrWe64y4Iwl39vifLdnggd0+wcgNLwWpEGIqeJkgW5Mkkln6H5KsX/oOCz4I2Wsyt7kIEcd5wKxTslR4DGW84Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFl/xiD4u2ja5YOR38ETFsXhGCXUOvhb1i842imQXWQ=;
 b=LtlzoyGAOi5bowZif3Eq0fZMwi2fBFM4ll4+VCYgnlGQCJ15auNAqF8nv48aVquif/cZaIJ0zQ4PiEaDcejmRYlvtlwJ/I00mxhiGh69E80gg3AtmOJPkABATs9IiD0j+2I/tYXnW7RA5ZExX+q1kwsoZX2lkiamBEZirSgRtqA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH8PR12MB7159.namprd12.prod.outlook.com (2603:10b6:510:229::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Mon, 28 Jul
 2025 17:29:29 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%7]) with mapi id 15.20.8964.019; Mon, 28 Jul 2025
 17:29:29 +0000
Date: Mon, 28 Jul 2025 19:29:12 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Luc Michel <luc.michel@amd.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH 04/48] hw/arm/xlnx-versal: uart: refactor creation
Message-ID: <aIezaOotZV1VH/5c@xse-figlesia-l2.amd.com>
References: <20250716095432.81923-1-luc.michel@amd.com>
 <20250716095432.81923-5-luc.michel@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716095432.81923-5-luc.michel@amd.com>
X-ClientProxiedBy: LO4P265CA0299.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::17) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH8PR12MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 44a201d1-841d-47aa-3594-08ddcdfc4e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzhFV1UwZHdacHR5QlI3STdGd3h2Nzd4ampVMW1XbGlhOFdnSVlSQ1JETlpJ?=
 =?utf-8?B?S2NFdGprRk5ZQzhsWDd0K3JReVVoRHoyWHhFRFF6dmFweFBhV0s5Wk84NkNX?=
 =?utf-8?B?NjF2d3ZuN0RkUzkrZFNzeGpUakluQmo3cU5NT2pjY3hnbU9IVXVMUHMxaUdC?=
 =?utf-8?B?ZVFxb2tBM0pYS2ZkKzEvdlJocFA3V0lLM2hHd2NTWlpkYnVuNkhGWXpvTzBm?=
 =?utf-8?B?ejF1dTNKbkw5OURrT2pxcUhsQno1aDYrRW5yOEJTTzIrcHdBT28vUElzZ1k2?=
 =?utf-8?B?S1VJRS9NWC9LWEZ2d2ZmemNDMzJKSEVsTy81SmdDYVYyNStCNWgvZ01zaFVh?=
 =?utf-8?B?aXNZcE5NYlVvL05NQUtXUHkrQjFYR2VYWk9icWQxRUxlcWVrdUxPT05XVlJj?=
 =?utf-8?B?aVBlNXBnUmJQSjdNMFpVUy9oZnRIZk9CQWphbU1zSkZyemZwMG9UcURsbjRT?=
 =?utf-8?B?aDRLTU93T2J2WVFlc2hHU0lEcmNueTNMWkgrTVRYRFhsVVVNT3pPcnQzeXhH?=
 =?utf-8?B?M1AwYkJXNlNmNnJoczE4QlcvR2ZMUFVORzNiUEovaEdKTit2akR3OWJPQVdQ?=
 =?utf-8?B?emZSM0tPajgyYncraUdEV0FJeEVzd1o4R0NyUmJnNEthSGNEbzVNUXFIaGJy?=
 =?utf-8?B?NXdTRHBidUFlMS9mRnBVNWl6U01oUWpyRDdIN1ZMTHNEYzFtTnovSjY2UG5j?=
 =?utf-8?B?VFc4dUZHdDNFL1FUSUVoQkpseXZoVHRjZkxKVjhlTE5YTW5jcGsxdjkyWW04?=
 =?utf-8?B?NkVVaWx6T0xzczN4M25lMzlwaVR2OUlWNnlCSThGTHF5MlAyVHRnQURHK1Nn?=
 =?utf-8?B?cnNPbjJzT0kwQ1AvUU5xNllqVkcxZGJRTHJLakFQRGpTaUtUNXM5WFVFemlC?=
 =?utf-8?B?VW00OW9venJaL2hjeUZhU3lMaG9MU2hFVy9ISjFwL3hQNWdJVmNLbXVrK2x4?=
 =?utf-8?B?SHZ3bWpVTWtZTVltb2NaRm96bjFvcWJRbkJmQWdIVmZpdzk0TzRPUUplQ3c1?=
 =?utf-8?B?YzBGbTE4QWpRU0NTS2FKVVU1d3NGeGlFRDM1aTFLV2g3UndwSmtwV01CUzc2?=
 =?utf-8?B?UjF1bmVQWTczOVAxOUNLUk1SV2VlaHVvdXdxTXZhdmxHRWt4QUZ2UlNhREZk?=
 =?utf-8?B?YThCeVdPYjhKeVB1YUdhb080OVl3QnZWQUhNd0lMeG1OblBXamRHYzc2NVJj?=
 =?utf-8?B?RXE5NGdua1NjK2h3MVoyYWxvckNidjlVRkhrR2ZsNmx5S0xXSkNabjBORzY0?=
 =?utf-8?B?YWFHSGE3dGYxem1tRmQzT1JlM2VZa0I3a2dJU2p3TXozTmZPMWhiYkt3Rk01?=
 =?utf-8?B?azJBNDh2ci9vblI5ZEdHUktWQ2wwdnhRa0dQb3RubWVpNjZHTk1SQXpQQWVU?=
 =?utf-8?B?L0x1Mng1OWZGQnh5eWNMTjBMdUhYaUkySENIVVJNeVM2cVFPWThzNjRtbmR5?=
 =?utf-8?B?TWZadVBtalc3UmNMc1o2bWwwck1GVnJKbmYrSm9WcHdhbExaT0tXRjhlU2Jp?=
 =?utf-8?B?am9iOGpnWGEwNEhXV1NXREdEaGNZWGN2T3JyZU5WK0Z0NWRkSVdvV2FXaHcr?=
 =?utf-8?B?blV1M2ZEb2lENU9DSHBIL3RweWM4T1pKTzNUQlExNDNjQXNKdGZDYnZ6MU9r?=
 =?utf-8?B?M2txMXB1aFNzOTZKeVdFT0RhSnl5NXh6bmtsSStwbXN0RnQzeFVOYnBsa1dT?=
 =?utf-8?B?Rk9xUkJZWldtSTF5Z2lrS2kvd2VjaVg5M2VKQ213elJ3SmNoTk9KbEszcXlt?=
 =?utf-8?B?eC9scE5RYThvU1p5aHRielAxeXZVL2tQT3ZpTHN4VHdhSHpzdG9JMGc1bFpk?=
 =?utf-8?B?NmNjR1l0NnplL3grNm1XNzZGSlNsU1pCYkZkQS9xWFNRMjNuTjZRQmpOSk9B?=
 =?utf-8?B?aWlLbGp2dGhaOGZhalpEN2xnUm5nRDI0cTdMMjU0Tm11dEl1K2NvWU9Vb05J?=
 =?utf-8?Q?mixR7GS5FIM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ym1DcnE0dTNPTlgwb2Q4NlY3TEh0Y0RBcEVKbklvOGhlSnhrNU9sTFF2cG55?=
 =?utf-8?B?OG1XSW8xZG9TNVBjYmpwUXFKVkdYL01TcUo5cVFKcVBCb0l5bUlvZVRsekdE?=
 =?utf-8?B?dmNndmV6cWE1WWEyVGNZcXhlUUZZNzJaNVVnVS92Mi9mK2s1YnBNdXlkc3Ft?=
 =?utf-8?B?MHhUREwyTGhUWjFEZXc4TlFESGtlRFRLZlY5OW9xT1pUcFl2TUs0OTVZc0hC?=
 =?utf-8?B?SnRzMXJISmpMYWRFOGpnWko5RElLUUxXMlhSYTZ4WlM5eFRBSVhOaUk5c0FW?=
 =?utf-8?B?U0MvRU0zTGVTV25pdysxVXMyM28xMkpuZnM5T3kxQ1F2Mm9BUTBwRER0cXdx?=
 =?utf-8?B?eC9TQ2wwSmtnc054V1Y4MmlNUXRlc0R6ZndYSjFYSVhlTjNsUElOTTlQc2h5?=
 =?utf-8?B?YXpWNFVydUVlRW02YjAvbFJvQ0wzZ21LUzZiTERRbWdacGhlZnRYcVFNUElT?=
 =?utf-8?B?eExDMFpTczA2YUtLYlluR08vMHU4SlYvTmMrWmZ6ZnV3QWpyTU1kUXVMdzBy?=
 =?utf-8?B?ZFFHT3JhaTZGcWY2OTRubjZ3UVRZd1lLb3FycmRZNlRid2lyUk5OL2JvL2o1?=
 =?utf-8?B?OEVoVTdPK1k2Z1RZVnhoWm1QWm5BNDBPNTR6R1p3SUEzUk9rWWY5TkJKSjNw?=
 =?utf-8?B?S0cxMFhadzZ2UURSd25NREpOZ3pRRmdVOUpJbmh5NCtoRkhTOHNKdTVUSmMv?=
 =?utf-8?B?ekV2c3kxMHhsTXJwTTVETUZCWWFiYkFYL1Fia1FnaDd6dDYreEhWYUZVV3A3?=
 =?utf-8?B?c3FYR3FOMkhxakRMWXR6OFgxM3hMU3ptbWdXbklFa2tKT29CQzZ2ZUZ6ZnlJ?=
 =?utf-8?B?QXduVWJXcFlReHZpUVYwSHFvdmV3SnVSZ3lkUTd6Vlh6aTBFM0M5eWl5V2VY?=
 =?utf-8?B?RVZjUFJmSGlLOGgyeWVGYVZhYUJ2K0dabDNDMjhwQStjQk8zWVh1YjJ2UmdB?=
 =?utf-8?B?QXNadVlCM005QkU0VkltRE91dFFRZTFrdGtGZ2dsL1RkMnR0NmphdXNDZDVj?=
 =?utf-8?B?ZmF5THdJdGQ3QWtZL1AyR1g2d3EwOU1ieVZ0L1g5R0xvWGFqdVpMUklqbVR6?=
 =?utf-8?B?RXAvZkU2YmlXcmV5QUc5YmFYajBBbURwWWhwQ0U1eXFLSUZkVlk4UVQxYVd6?=
 =?utf-8?B?YVBsUnJWNFV6WnU3d2hBWFc4QWFJc2Y2dmUxbFBqTDA0MCthNG5paGFScFJF?=
 =?utf-8?B?ei9ZRUJQVzltSVV4YmtJalM0ekllOHQzZmxyNS9YMlpEV2ozbURURFNjYWR3?=
 =?utf-8?B?bG1Cd0RNeGhTTEJFVm1WdWhJTEs0K2FUMHVqZmlhWXhjMEZyU1dTZVQvNGY3?=
 =?utf-8?B?OXVBRy9RTUlZUWNVZWNPakZHVlFoZ2tWRzd1ZzlRdG5DU0Q4NWM2WlVBN0VL?=
 =?utf-8?B?RDZkVzJGSHIzTEdOOFBYZWxOMm9tV2hoQU8wOGJUUDVPWVlkQnZUM2FRZU5V?=
 =?utf-8?B?MlF0NjNuVDlCaHFhQS9ZeWs5dWxmanhaQTBTZ2hmcHBadjQxOHVIajE3aGw4?=
 =?utf-8?B?ZnY1U3NYTUNxOFFaaHZNaUI5UXhSQk82ckUxZ2lMNkRYMTRzdCtBalpva3ZB?=
 =?utf-8?B?dXNVZU9Qa2paNjBtcjRwbE5ycEY1cWFoZGc3U1ZHeGRrTFkzMVNrTGxHcG42?=
 =?utf-8?B?aVlDMDV1U0pKSE5obEpJMkdYV041Nk0ydlZQTHdZTEl5ZzhsWHpBQkhZc2Ix?=
 =?utf-8?B?eVc4aE9yamV1U3h6ckRLSmladlZrR1JBSTlLeTZvRkJKZk96cDVwQnI0SmxO?=
 =?utf-8?B?TWw4YnpPWDM4YlY0Q2Y4YktXcVVhZFlHUEZOSHU2UkRQTURVNXk3ZEg3bWNV?=
 =?utf-8?B?NGNLdVprKzVYM0dQQW81MW1WeHFxbFZBOWxXMkU0ZW1XZkpXNStZdzFvcVJq?=
 =?utf-8?B?NHlFMWxiQXdGUklTMDVPbkw2cFVJSmUzQnBIbHo0ZWpaZWllMzhmV0pISmFz?=
 =?utf-8?B?b2lnM203b1k5c0wyNTN1OGlZazVMTEVhMWhqVVFBNG9Pb3RrRWpOQjd1Z1Ew?=
 =?utf-8?B?YWQ3NitJMTYwUGIzUitwNXhHaW8vYmx6dVNtb2c5UkhKc3paWklzVThoS2JG?=
 =?utf-8?B?emNQdXBCSjNuVHRMUCs3VlVaMjNHQjArd0ZNU2lkc1VNUUtOajJXQ056dWlH?=
 =?utf-8?Q?hH6uOY/UTdjLyjQmQIwP/6XMa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44a201d1-841d-47aa-3594-08ddcdfc4e70
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 17:29:29.0254 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ueJlw8Xedbeyoiciu6/enDHApOBrbC6wptDYlyJPpwJahhPJ9A1RAHTOlN09fmWPKKPI+7Ep6sTHqOwEB3JEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7159
Received-SPF: permerror client-ip=2a01:111:f403:2412::616;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM10-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 16, 2025 at 11:53:46AM +0200, Luc Michel wrote:
> Refactor the UARTs creations. The VersalMap struct is now used to
> describe the SoC and its peripherals. For now it contains the two UARTs
> mapping information. The creation function now embeds the FDT creation
> logic as well. The devices are now created dynamically using qdev_new
> and (qdev|sysbus)_realize_and_unref.
> 
> This will allow to rely entirely on the VersalMap structure to create
> the SoC and allow easy addition of new SoCs of the same family (like
> versal2 coming with next commits).
> 
> Note that the connection to the CRL is removed for now and will be
> re-added by next commits.
> 
> Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  include/hw/arm/xlnx-versal.h |   2 -
>  hw/arm/xlnx-versal-virt.c    |  36 +--------
>  hw/arm/xlnx-versal.c         | 142 ++++++++++++++++++++++++++++-------
>  3 files changed, 117 insertions(+), 63 deletions(-)
> 
> diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
> index f2a62b43552..b01ddeb1423 100644
> --- a/include/hw/arm/xlnx-versal.h
> +++ b/include/hw/arm/xlnx-versal.h
> @@ -16,11 +16,10 @@
>  #include "hw/sysbus.h"
>  #include "hw/cpu/cluster.h"
>  #include "hw/or-irq.h"
>  #include "hw/sd/sdhci.h"
>  #include "hw/intc/arm_gicv3.h"
> -#include "hw/char/pl011.h"
>  #include "hw/dma/xlnx-zdma.h"
>  #include "hw/net/cadence_gem.h"
>  #include "hw/rtc/xlnx-zynqmp-rtc.h"
>  #include "qom/object.h"
>  #include "hw/usb/xlnx-usb-subsystem.h"
> @@ -78,11 +77,10 @@ struct Versal {
>  
>      struct {
>          MemoryRegion mr_ocm;
>  
>          struct {
> -            PL011State uart[XLNX_VERSAL_NR_UARTS];
>              CadenceGEMState gem[XLNX_VERSAL_NR_GEMS];
>              OrIRQState gem_irq_orgate[XLNX_VERSAL_NR_GEMS];
>              XlnxZDMA adma[XLNX_VERSAL_NR_ADMAS];
>              VersalUsb2 usb;
>              CanBusState *canbus[XLNX_VERSAL_NR_CANFD];
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index c30dcca424c..7213ead466d 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -75,10 +75,11 @@ static void fdt_create(VersalVirt *s)
>  
>      s->phandle.usb = qemu_fdt_alloc_phandle(s->fdt);
>      s->phandle.dwc = qemu_fdt_alloc_phandle(s->fdt);
>      /* Create /chosen node for load_dtb.  */
>      qemu_fdt_add_subnode(s->fdt, "/chosen");
> +    qemu_fdt_add_subnode(s->fdt, "/aliases");
>  
>      /* Header */
>      qemu_fdt_setprop_cell(s->fdt, "/", "interrupt-parent", s->phandle.gic);
>      qemu_fdt_setprop_cell(s->fdt, "/", "#size-cells", 0x2);
>      qemu_fdt_setprop_cell(s->fdt, "/", "#address-cells", 0x2);
> @@ -206,44 +207,10 @@ static void fdt_add_usb_xhci_nodes(VersalVirt *s)
>      qemu_fdt_setprop_cell(s->fdt, name, "phandle", s->phandle.dwc);
>      qemu_fdt_setprop_string(s->fdt, name, "maximum-speed", "high-speed");
>      g_free(name);
>  }
>  
> -static void fdt_add_uart_nodes(VersalVirt *s)
> -{
> -    uint64_t addrs[] = { MM_UART1, MM_UART0 };
> -    unsigned int irqs[] = { VERSAL_UART1_IRQ_0, VERSAL_UART0_IRQ_0 };
> -    const char compat[] = "arm,pl011\0arm,sbsa-uart";
> -    const char clocknames[] = "uartclk\0apb_pclk";
> -    int i;
> -
> -    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
> -        char *name = g_strdup_printf("/uart@%" PRIx64, addrs[i]);
> -        qemu_fdt_add_subnode(s->fdt, name);
> -        qemu_fdt_setprop_cell(s->fdt, name, "current-speed", 115200);
> -        qemu_fdt_setprop_cells(s->fdt, name, "clocks",
> -                               s->phandle.clk_125Mhz, s->phandle.clk_125Mhz);
> -        qemu_fdt_setprop(s->fdt, name, "clock-names",
> -                         clocknames, sizeof(clocknames));
> -
> -        qemu_fdt_setprop_cells(s->fdt, name, "interrupts",
> -                               GIC_FDT_IRQ_TYPE_SPI, irqs[i],
> -                               GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> -        qemu_fdt_setprop_sized_cells(s->fdt, name, "reg",
> -                                     2, addrs[i], 2, 0x1000);
> -        qemu_fdt_setprop(s->fdt, name, "compatible",
> -                         compat, sizeof(compat));
> -        qemu_fdt_setprop(s->fdt, name, "u-boot,dm-pre-reloc", NULL, 0);
> -
> -        if (addrs[i] == MM_UART0) {
> -            /* Select UART0.  */
> -            qemu_fdt_setprop_string(s->fdt, "/chosen", "stdout-path", name);
> -        }
> -        g_free(name);
> -    }
> -}
> -
>  static void fdt_add_canfd_nodes(VersalVirt *s)
>  {
>      uint64_t addrs[] = { MM_CANFD1, MM_CANFD0 };
>      uint32_t size[] = { MM_CANFD1_SIZE, MM_CANFD0_SIZE };
>      unsigned int irqs[] = { VERSAL_CANFD1_IRQ_0, VERSAL_CANFD0_IRQ_0 };
> @@ -700,11 +667,10 @@ static void versal_virt_init(MachineState *machine)
>                               &error_abort);
>  
>      fdt_create(s);
>      versal_set_fdt(&s->soc, s->fdt);
>      fdt_add_gem_nodes(s);
> -    fdt_add_uart_nodes(s);
>      fdt_add_canfd_nodes(s);
>      fdt_add_gic_nodes(s);
>      fdt_add_timer_nodes(s);
>      fdt_add_zdma_nodes(s);
>      fdt_add_usb_xhci_nodes(s);
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 7bb55751e5c..87468cbc291 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -24,18 +24,96 @@
>  #include "qemu/log.h"
>  #include "target/arm/cpu-qom.h"
>  #include "target/arm/gtimer.h"
>  #include "system/device_tree.h"
>  #include "hw/arm/fdt.h"
> +#include "hw/char/pl011.h"
>  
>  #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
>  #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
>  #define GEM_REVISION        0x40070106
>  
>  #define VERSAL_NUM_PMC_APB_IRQS 18
>  #define NUM_OSPI_IRQ_LINES 3
>  
> +typedef struct VersalSimplePeriphMap {
> +    uint64_t addr;
> +    int irq;
> +} VersalSimplePeriphMap;
> +
> +typedef struct VersalMap {
> +    VersalSimplePeriphMap uart[2];
> +    size_t num_uart;
> +} VersalMap;
> +
> +static const VersalMap VERSAL_MAP = {
> +    .uart[0] = { 0xff000000, 18 },
> +    .uart[1] = { 0xff010000, 19 },
> +    .num_uart = 2,
> +};
> +
> +static const VersalMap *VERSION_TO_MAP[] = {
> +    [VERSAL_VER_VERSAL] = &VERSAL_MAP,
> +};
> +
> +static inline VersalVersion versal_get_version(Versal *s)
> +{
> +    return XLNX_VERSAL_BASE_GET_CLASS(s)->version;
> +}
> +
> +static inline const VersalMap *versal_get_map(Versal *s)
> +{
> +    return VERSION_TO_MAP[versal_get_version(s)];
> +}
> +
> +
> +static qemu_irq versal_get_irq(Versal *s, int irq_idx)
> +{
> +    return qdev_get_gpio_in(DEVICE(&s->fpd.apu.gic), irq_idx);
> +}
> +
> +static void versal_sysbus_connect_irq(Versal *s, SysBusDevice *sbd,
> +                                      int sbd_idx, int irq_idx)
> +{
> +    qemu_irq irq = versal_get_irq(s, irq_idx);
> +
> +    if (irq == NULL) {
> +        return;
> +    }
> +
> +    sysbus_connect_irq(sbd, sbd_idx, irq);
> +}
> +
> +static inline char *versal_fdt_add_subnode(Versal *s, const char *path,
> +                                           uint64_t at, const char *compat,
> +                                           size_t compat_sz)
> +{
> +    char *p;
> +
> +    p = g_strdup_printf("%s@%" PRIx64, path, at);
> +    qemu_fdt_add_subnode(s->cfg.fdt, p);
> +
> +    if (!strncmp(compat, "memory", compat_sz)) {
> +        qemu_fdt_setprop(s->cfg.fdt, p, "device_type", compat, compat_sz);
> +    } else {
> +        qemu_fdt_setprop(s->cfg.fdt, p, "compatible", compat, compat_sz);
> +    }
> +
> +    return p;
> +}
> +
> +static inline char *versal_fdt_add_simple_subnode(Versal *s, const char *path,
> +                                                  uint64_t addr, uint64_t len,
> +                                                  const char *compat,
> +                                                  size_t compat_sz)
> +{
> +    char *p = versal_fdt_add_subnode(s, path, addr, compat, compat_sz);
> +
> +    qemu_fdt_setprop_sized_cells(s->cfg.fdt, p, "reg", 2, addr, 2, len);
> +    return p;
> +}
> +
>  static void versal_create_apu_cpus(Versal *s)
>  {
>      int i;
>  
>      object_initialize_child(OBJECT(s), "apu-cluster", &s->fpd.apu.cluster,
> @@ -165,32 +243,48 @@ static void versal_create_rpu_cpus(Versal *s)
>      }
>  
>      qdev_realize(DEVICE(&s->lpd.rpu.cluster), NULL, &error_fatal);
>  }
>  
> -static void versal_create_uarts(Versal *s, qemu_irq *pic)
> +static void versal_create_uart(Versal *s,
> +                               const VersalSimplePeriphMap *map,
> +                               int chardev_idx)
>  {
> -    int i;
> +    DeviceState *dev;
> +    MemoryRegion *mr;
> +    g_autofree char *node;
> +    g_autofree char *alias;
> +    const char compatible[] = "arm,pl011\0arm,sbsa-uart";
> +    const char clocknames[] = "uartclk\0apb_pclk";
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
> -        static const int irqs[] = { VERSAL_UART0_IRQ_0, VERSAL_UART1_IRQ_0};
> -        static const uint64_t addrs[] = { MM_UART0, MM_UART1 };
> -        char *name = g_strdup_printf("uart%d", i);
> -        DeviceState *dev;
> -        MemoryRegion *mr;
> +    dev = qdev_new(TYPE_PL011);
> +    object_property_add_child(OBJECT(s), "uart[*]", OBJECT(dev));
> +    qdev_prop_set_chr(dev, "chardev", serial_hd(chardev_idx));
> +    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
>  
> -        object_initialize_child(OBJECT(s), name, &s->lpd.iou.uart[i],
> -                                TYPE_PL011);
> -        dev = DEVICE(&s->lpd.iou.uart[i]);
> -        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
> -        sysbus_realize(SYS_BUS_DEVICE(dev), &error_fatal);
> +    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> +    memory_region_add_subregion(&s->mr_ps, map->addr, mr);
>  
> -        mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
> -        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> +    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->irq);
>  
> -        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
> -        g_free(name);
> +    node = versal_fdt_add_simple_subnode(s, "/uart", map->addr, 0x1000,
> +                                         compatible, sizeof(compatible));
> +    qemu_fdt_setprop_cell(s->cfg.fdt, node, "current-speed", 115200);
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "clocks",
> +                           s->phandle.clk_125mhz, s->phandle.clk_125mhz);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "clock-names", clocknames,
> +                     sizeof(clocknames));
> +    qemu_fdt_setprop_cells(s->cfg.fdt, node, "interrupts",
> +                           GIC_FDT_IRQ_TYPE_SPI, map->irq,
> +                           GIC_FDT_IRQ_FLAGS_LEVEL_HI);
> +    qemu_fdt_setprop(s->cfg.fdt, node, "u-boot,dm-pre-reloc", NULL, 0);
> +
> +    alias = g_strdup_printf("serial%d", chardev_idx);
> +    qemu_fdt_setprop_string(s->cfg.fdt, "/aliases", alias, node);
> +
> +    if (chardev_idx == 0) {
> +        qemu_fdt_setprop_string(s->cfg.fdt, "/chosen", "stdout-path", node);
>      }
>  }
>  
>  static void versal_create_canfds(Versal *s, qemu_irq *pic)
>  {
> @@ -781,18 +875,10 @@ static void versal_create_crl(Versal *s, qemu_irq *pic)
>          object_property_set_link(OBJECT(&s->lpd.crl),
>                                   name, OBJECT(&s->lpd.iou.adma[i]),
>                                   &error_abort);
>      }
>  
> -    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
> -        g_autofree gchar *name = g_strdup_printf("uart[%d]", i);
> -
> -        object_property_set_link(OBJECT(&s->lpd.crl),
> -                                 name, OBJECT(&s->lpd.iou.uart[i]),
> -                                 &error_abort);
> -    }
> -
>      object_property_set_link(OBJECT(&s->lpd.crl),
>                               "usb", OBJECT(&s->lpd.iou.usb),
>                               &error_abort);
>  
>      sysbus_realize(sbd, &error_fatal);
> @@ -955,11 +1041,15 @@ static void versal_realize(DeviceState *dev, Error **errp)
>      s->phandle.clk_125mhz = fdt_add_clk_node(s, "/clk125", 125 * 1000 * 1000);
>  
>      versal_create_apu_cpus(s);
>      versal_create_apu_gic(s, pic);
>      versal_create_rpu_cpus(s);
> -    versal_create_uarts(s, pic);
> +
> +    for (i = 0; i < map->num_uart; i++) {
> +        versal_create_uart(s, &map->uart[i], i);
> +    }
> +
>      versal_create_canfds(s, pic);
>      versal_create_usbs(s, pic);
>      versal_create_gems(s, pic);
>      versal_create_admas(s, pic);
>      versal_create_sds(s, pic);
> -- 
> 2.50.0
> 

