Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D8AC531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 10:14:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shRIh-0001lo-FB; Fri, 23 Aug 2024 06:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shRIb-0001kf-U9; Fri, 23 Aug 2024 06:13:43 -0400
Received: from mail-bn8nam04on2062d.outbound.protection.outlook.com
 ([2a01:111:f403:2408::62d]
 helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <francisco.iglesias@amd.com>)
 id 1shRIZ-0000hm-Rs; Fri, 23 Aug 2024 06:13:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QOFvOjnYbBi/iGUEsFU78K5CyXwpLTNpBWzxjaLGDg4nVz7UqZU7nMoAoSyT/8urrAVAn+f/BpAfl5NROUjq5Us6qWP292imSIIsDgBftAcIKsQJ8JdHrTK4h/aZZAnVII7k4HeveMYr+CTh4YM/iCuKF5ccwv+xmtYcayJfxVdVH6gKuZF4LG0wdELu6kX4vIGHwyZbUx3IyvLE0P0WmHoxgzo93huwUVIF1waA/rsf6TfWYwLPR5H1/ln9qJA4oUvvV7TxZ90d1yjBuQcrUMROhKnnF8JhX0YsN8GlebzVKBGTc10jMU+vXQ0pVl2djUffV/uGUeUJrQkLqM7vgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IjybR5/gUh6LjPPJmUDKxPDBursY7DSxKfBFQYuSelE=;
 b=IURcKxH+Gjmh+KNMAhkb+H2kNCNIKB6y+iElBkao/nOO09oOwT+XgI73nUzZF+1wmH+WHLJshUVAt5STrqEG1RciDD+KauBjfzD+XoSwlYbtiOs6xpRMwWOap8Ist04hie9UFBknQGNYT2ye885R9DI7yOkkcvVmXUnm3NXdRQexpllpsTh59743cz6rKP+jIEunUNRr5VsCSee4M5xh7ifWs1Iq4Nyvm08l+4k92HiwDs8sF8qp748VjBggfuddRCsW/SFzbSWnM4zOAtqMuj8pGPOWGvthmGjNUPCryJ1pZk3l596iF+iYV1JQQrtMZtnyJasccA1zUtwhWFAnng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IjybR5/gUh6LjPPJmUDKxPDBursY7DSxKfBFQYuSelE=;
 b=n5wXQMUMLVelU8AZpLMJoGaSC7q4gxPNMpNcFQh6vkVvUyrbjQ2+aKGMSkSTs+nkzbBOhrHJ5yvS/C9mElxK4QNnOhZdPCfZO77dxLdhet425j3EeIW9aLZDpoON2ClW1tBo/rBxW5Y3z8deAaMaA79G6kE24vk72MafpIsFaNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com (2603:10b6:a03:549::10)
 by PH7PR12MB6660.namprd12.prod.outlook.com (2603:10b6:510:212::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Fri, 23 Aug
 2024 10:13:21 +0000
Received: from SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b]) by SJ2PR12MB8739.namprd12.prod.outlook.com
 ([fe80::29bb:9aa:2a72:df1b%6]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 10:13:21 +0000
Date: Fri, 23 Aug 2024 12:13:15 +0200
From: Francisco Iglesias <francisco.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: Re: [PATCH for-9.2 1/6] hw/misc/xlnx-versal-cfu: destroy fifo in
 finalize
Message-ID: <Zshgu67d6yg/NhnN@xse-figlesia-l2.amd.com>
References: <20240822162127.705879-1-peter.maydell@linaro.org>
 <20240822162127.705879-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240822162127.705879-2-peter.maydell@linaro.org>
X-ClientProxiedBy: FR0P281CA0224.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::10) To SJ2PR12MB8739.namprd12.prod.outlook.com
 (2603:10b6:a03:549::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8739:EE_|PH7PR12MB6660:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2fa943-7e9b-4796-cdf8-08dcc35c3746
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bVg1RnpBc3NlTnJubHdIaDNoN1lWQjZQek41dmJpLzFFT3d5dHlDRGFtVG03?=
 =?utf-8?B?RHB0V0FjU3RMZ0ExazR2ZGc1a0gvNTE5clFxNXhGRlNrQXpLN0FKMXJMYjZ2?=
 =?utf-8?B?U3JXUzBWWjh6cnY5Z09ma0R5UVlaM2VlUEd6OTB4TlZEM0dVdm12VUJaUnlr?=
 =?utf-8?B?Tldsano5NU5xdnlGeFM5M3E0VjNXK1gzb1JrNVpEQWVkcVZVTzJuZ0x5ZXNJ?=
 =?utf-8?B?VzFiT2RSTzJpcXppYTlKbFoyVEhBSWE4NGFmcEwwYU9nUlN4L0NQVHVwNjhZ?=
 =?utf-8?B?cVFaYThSeE9TMjVFR2xZdGpZZnB0T2JiMVhOdVV2T3VvSjZ3Q3hHcEJZSzhl?=
 =?utf-8?B?cWpOS1lQeUMxOVlxaUNIam1GZ0QzWWNKclF0b21BMHEwNitOZEtYbzhxa3E0?=
 =?utf-8?B?SXVjN3UrdEZMekxqaitZSVFJWDZ4NW1ZMDMrK0FYTjdESW5DVlZRVk5iaHR1?=
 =?utf-8?B?bEdVRTUrV0QyenF0amtXc1dlREMwNGFLRzM0a3IwNS9ERHR6YXI1NjJYSVpX?=
 =?utf-8?B?RmJlcFdET1hKRUx0cXBMYmxnaFFLciszY21LNFB3RG8xU2lrNjdLbjc2cU8z?=
 =?utf-8?B?bC9kV3lkemRhZ1RsZGY3OGxQOXo2T3J1WVFlVUpMdzBlTmJ2QkVMUkVoVGdn?=
 =?utf-8?B?V2hNM1ZvQmJFZmdvMDZhRVMrOVhTRXh5d3BzZ1dveDh4UjFyVUQrbklYV2U5?=
 =?utf-8?B?U3NBU056eHNTM3IvTlBjSHRCWWttQndacUNSeTZaRlpoZjVzakNnV0JXV3Rt?=
 =?utf-8?B?aHVTL1JidnRGR0p4NTZCeHB4cnMvNkk3RUNmMk1MWHBkclE2UklaMHdqNnFO?=
 =?utf-8?B?b0NhQUNZeExKMGZwSjZaWkNvWDIvWisrQU42Y0NDdnJLRUJqR3Zjb1dwcDB2?=
 =?utf-8?B?TnpiMWVKeVVvRFpqbDNpTjU0TTlEREFma290S2greUFBSFh4T0haN0VIdUUr?=
 =?utf-8?B?MTljeHd6ekdZMWRNaXpSVnZXK2ttQjFuK1VYbzV4R20vNlpGZmhORWlLcW1r?=
 =?utf-8?B?K3pBbWo2Zzl5VHZBcmFLK05rbjcrS1p4QnhVVkpsQTFCd2VxaHp6TktuUVZi?=
 =?utf-8?B?czlPWmwwY0srNy9uVGpYZWZpaWxhNWxoUjdPZ2NXQnNncHE4UUdxSXdIZ0xj?=
 =?utf-8?B?dXNGZnVuNUdyR3J4elVWVk1haXFrVUpQMkZYRFM4YkdLcmhQMVppUmppaFQz?=
 =?utf-8?B?MXFuSzlwTi84NFl3QjlSUFc3RTYxY0ZLSHdzenJ1ZG9nOGd2NFVXRTQ5QXFJ?=
 =?utf-8?B?bDM1OTllanFGcFdjYi9oaW4yQjU1ODZIRjR5VkRtQ3RndG5oYVFjNjlsUmRm?=
 =?utf-8?B?Y0R3NnEzWDdXemR1SlNiLzlKSk1GUnQzMnAyTjBTVlRDY0svVUZVbWlKR25q?=
 =?utf-8?B?RFIzL2tIUi90a1JGZ0lHWWVBLzFQZ0Q4UEJyYmtndXduamRVVFljV1owRmVl?=
 =?utf-8?B?L29TRThVYi9LaEk4eTJwYitFM2JOcFFYVWV5bnBBMUI0b1ZxYjlxNU9hR0RL?=
 =?utf-8?B?Q0FVSEc4U0JDaEJYcXYzeDFEdEE1ZnpwOVpMTlU3ZDBHcFJFdlprd2lseHli?=
 =?utf-8?B?M0NzYk1jWEtBTm80M05RMUp4cERpNzB5cmNzRmlCM0Z3YnovYnV1WG1UbE14?=
 =?utf-8?B?YkltTFBWVy8zcXNmSzk4aWFCWG5sWDJDMGI5b1NWRG1BQ2JJL0RlOUI2bDZ5?=
 =?utf-8?B?VmRFZkEyM3JBY1h1d3QrNE1ma2MxOTF1aGlxa29ZUWM3YTZUYU1md3NOVEl0?=
 =?utf-8?B?STJIZGZ2M0hrajJtYldQb1k0dEVlb3hqMVZLb2NjMmpzKzdWaEttekJnc2lz?=
 =?utf-8?B?bUprYnJGMjBBaUhGVGg3UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8739.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azE5amwvamhVTkJmcGYxblp1d0toTzBJZUZGNzdBM3BEcjJlbmMzeDQxKyt3?=
 =?utf-8?B?UmFYcHM1Nk40MkRuT1EwYlplUHlDcGVZRTZpSFRZaHVsd2hrZ2pxNHdEQkNI?=
 =?utf-8?B?VVMvL3VBSG5uN2dEUnRSa3NKSE1Ga1kvdWFuaWFGN08rUTc2WVFaUkZnMDkx?=
 =?utf-8?B?K3lBT09YWlBrUmt0V2UrUXpzaVFKdWllbDd5UG5mM3NSYTdwWXpmMlU3Zy9W?=
 =?utf-8?B?U1ZHKy83UGpQcm44M2k4SFNWY1NTVUFIRmdNdTh1MUtMWlJGckpNVktrd1lp?=
 =?utf-8?B?UkNRUmZ1cU9odU5DaW1QVzlIS1IzSWx0UEUvcDcvWkRtVTJ1U0M3My80Y01F?=
 =?utf-8?B?Z3NvbEhaVTErSk4zZCtJRjFpVitvNWNUNUJ6WGdxeGF4MTlsWjliVktUT29u?=
 =?utf-8?B?aG9VNk4velFzQVN4K0Y4TDZ6dlUxV2JoaWErUXJ0ZkRldzNTZlhKYkhLelQw?=
 =?utf-8?B?dk5vZXZ5eGczRE9PREplbGtkeFQzdURQWDdaeVQ4dldsZitHYnQrR296S1Yx?=
 =?utf-8?B?bVNNN3VQL21ObjhRNGRtRUhrbVJqWC93M2ZaYmxhYnZZc3JKNU1aUmV2L093?=
 =?utf-8?B?OVZIaDk1cDZtNVFlZUdOVVhtblBzTERoelRlOEFUbUpVaWVDdjAwdXNMa2k3?=
 =?utf-8?B?eUZPaEhDUkxwc25pOENPWmdmUlBBWW9ZL3BCbDlmcjdMMmFrZjNyYVEranFu?=
 =?utf-8?B?bVFMWWZOMUtQQ0pOblN5UjloMHNBdzZkbjVNL2ZHUjhuTWZIVExXMkpkeklk?=
 =?utf-8?B?NzVBbVphQzN2bnBOSHdyaU9qU1ZRSU5IT2hqaks0Zi9ldjhTaTNrakpjR015?=
 =?utf-8?B?aDFKWnZSeGhZWDBsa1AwM0VTY2MrUnRHVDE3ME1ML1RLT0hzL0VGMDE0SGln?=
 =?utf-8?B?bzVLSzVNRktmMVp5WlhkM3F5ZHo2ckMweDExMERaWnNiMXprOTcvWkNHcDU5?=
 =?utf-8?B?YWs3OXUxbVYwcEFIZlVLb3dHYys2TlJTZXdadzN4TzZzM21wcGV1bVJtMTF4?=
 =?utf-8?B?TTcvNFUyYjIwS0hVdHdWcXp6eFVNVG5rMXo2eEZ4U1A0bHFyOWxoanEyUHNL?=
 =?utf-8?B?RUp2RWdVcE9nWGszL2hONmgwTjNnejN2UzBuV2l1d3ZtMFNCNlZMNWlzOHgv?=
 =?utf-8?B?QmRTbXBpZmQxcmdpLzdSQjRFZ1Q4RjY3Y1EwbDE3KzFXNFppaG5GcDBrOHVn?=
 =?utf-8?B?dHE5Y3FnRjEzQ3dGdjhMeW9WNngzVmpKWEFrTENiZ2dlVVVLeVR5NFNiS0NB?=
 =?utf-8?B?ak9LTjFCYTIzMXRuRkc5eWtDNGxSNEF4YldWT3lqYjJTSmZXYWhKQUt1Y1Yv?=
 =?utf-8?B?TzZVSUJ6U1gwZWgzc0UzODBDZzFWNG0zOE0rZGNvOUgvYnNJdHB5REtWYTBH?=
 =?utf-8?B?UldXVEZuSlc1Q3NyV3haYXUva3hzVnQwRUFtTzcwa2xqYWN3Q1E3dXFZT0Ev?=
 =?utf-8?B?ZFZkTXFlVWt4QWdMd2hWZW5TeVBkMEhlaTdxb200TGh3OXBKRGtyQ2t0L2d1?=
 =?utf-8?B?N3F2Z0dqZVRYMDlRRnBXYm5iczBSLzdFRnl5ODZCRDU5RDYzNTlsZ3JoMXhN?=
 =?utf-8?B?Q2VHbEpTK3FZcFRUQ2hEVVc2YUt6cHF2YUw1NDZXUDZWNnZlbVlSWDNTdkl0?=
 =?utf-8?B?aitOMEtOY2kwSUdPSXJvVGtscU53bFpYYnJlU0FUSUdZYStnMW5YRElQZHpT?=
 =?utf-8?B?Rmk1Y1RpVkNCRUJKYkNNU1JqMFdKODhsalA4aFFaRHRHK0hDMjBhdDVxUE5r?=
 =?utf-8?B?TjlnSGNjTWV1MVFHN2JjUjZHSXV0Wm1BSm1lSktlcHZveUlpa3FkaG5jZ0lB?=
 =?utf-8?B?ZndieWVHYjkxdzczZStyNm5uQ1pCUFZTMGtMcGFTOWZJQzdJQW5FakM3dWxK?=
 =?utf-8?B?bGZNdDZNK3lOaTM0SG5rWkJCTm5PK1dTRnYwVUdLTUdCZHY1S2EvK3lwdmRO?=
 =?utf-8?B?Skd4UzRMSGxuNGVHN1pnb3dDd2RCaGt5OXpzdE8rNFM2Y1VSNURTWmhTZFZ5?=
 =?utf-8?B?N3RjdEZRQzFhckExeXN2WUdaSDM1cmt4Zy9VY0h5cFUyVlZXZS90dU9DVjNJ?=
 =?utf-8?B?RUxham81cC96WDBtd2pFOC9uTDBKSGtGSjE0RU5MaUhSWTJGbEVyT1ZRWnpu?=
 =?utf-8?Q?fOlTbUuBpp4Kzvrg9rk4F3dTa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2fa943-7e9b-4796-cdf8-08dcc35c3746
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8739.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:13:21.3832 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jxSSebWp9ck/8X/BYz51MkMRh6u7vJeC2qUDn9rCA9XEBsh9Tqk4sZeJsZjsTXcP0NIACuw0O2PTgHqM9jE7hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6660
Received-SPF: permerror client-ip=2a01:111:f403:2408::62d;
 envelope-from=francisco.iglesias@amd.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 22, 2024 at 05:21:22PM +0100, Peter Maydell wrote:
> Since the TYPE_XNLX_VERSAL_CFU_FDRO device creates a FIFO in its
> instance_init method, we must destroy the FIFO in instance_finalize
> to avoid a memory leak for the QOM introspection
> "instantiate-examine-finalize" cycle:
> 
> Direct leak of 8192 byte(s) in 1 object(s) allocated from:
>     #0 0x55ec89eae7ee in malloc (/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/asan/qemu-system-aarch64+0x294d7ee) (BuildId: 6d508874816cc47d17c8dd775e8f809ae520e8cb)
>     #1 0x7f697018f738 in g_malloc debian/build/deb/../../../glib/gmem.c:128:13
>     #2 0x55ec8d98d98d in fifo8_create util/fifo8.c:27:18
>     #3 0x55ec8aa2a624 in fifo32_create /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/fifo32.h:35:5
>     #4 0x55ec8aa2a33c in cfu_fdro_init hw/misc/xlnx-versal-cfu.c:397:5
>     #5 0x55ec8ce75da1 in object_init_with_type qom/object.c:420:9
>     #6 0x55ec8ce5d07b in object_initialize_with_type qom/object.c:562:5
>     #7 0x55ec8ce5e91d in object_new_with_type qom/object.c:782:5
>     #8 0x55ec8ce5e9f1 in object_new qom/object.c:797:12
>     #9 0x55ec8d65c81d in qmp_device_list_properties qom/qom-qmp-cmds.c:144:11
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>

> ---
>  hw/misc/xlnx-versal-cfu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/misc/xlnx-versal-cfu.c b/hw/misc/xlnx-versal-cfu.c
> index 6bb82e51c15..2284b407eab 100644
> --- a/hw/misc/xlnx-versal-cfu.c
> +++ b/hw/misc/xlnx-versal-cfu.c
> @@ -397,6 +397,13 @@ static void cfu_fdro_init(Object *obj)
>      fifo32_create(&s->fdro_data, 8 * KiB / sizeof(uint32_t));
>  }
>  
> +static void cfu_fdro_finalize(Object *obj)
> +{
> +    XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
> +
> +    fifo32_destroy(&s->fdro_data);
> +}
> +
>  static void cfu_fdro_reset_enter(Object *obj, ResetType type)
>  {
>      XlnxVersalCFUFDRO *s = XLNX_VERSAL_CFU_FDRO(obj);
> @@ -539,6 +546,7 @@ static const TypeInfo cfu_fdro_info = {
>      .instance_size = sizeof(XlnxVersalCFUFDRO),
>      .class_init    = cfu_fdro_class_init,
>      .instance_init = cfu_fdro_init,
> +    .instance_finalize = cfu_fdro_finalize,
>      .interfaces = (InterfaceInfo[]) {
>          { TYPE_XLNX_CFI_IF },
>          { }
> -- 
> 2.34.1
> 

