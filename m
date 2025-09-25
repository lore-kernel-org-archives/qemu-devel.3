Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F84BCAC5BA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 18:40:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1qsS-00025C-8M; Thu, 25 Sep 2025 14:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1v1qsK-00020P-UP; Thu, 25 Sep 2025 14:39:30 -0400
Received: from mail-southcentralusazlp170130001.outbound.protection.outlook.com
 ([2a01:111:f403:c10c::1] helo=SA9PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Edgar.Iglesias@amd.com>)
 id 1v1qs8-0008KC-PD; Thu, 25 Sep 2025 14:39:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2P+PMubuBEyJZwQOBUNEkjbl/7T/dxwwXUdNVWMOaBPTSkx4AOBl6Y9IChsfpVRL/r8Ok31L9UHA8L9jiydNV90viIyHSLU/djB6wwJxkMWNJsDdoFk6NE74z53exXIXe8icnQU1pXF9Z7h75VJhLJXneo8GSh8CgQmMWE/vhZb1HE3k1Xu4a2N+BFVzs1rtT9iEaju6g+ysvA8VnYF9U6HEBET9rDeCKMgrmSGih9uH6YYlVzpnS6ZO6wsytbrUWK+76zsw/l8TkXTFKHqoBLuqqgWSuSlC3hFncwadXj/SKimCA4XkAeS5z5PGAi5iSEYFxCC9DOdtNFcN11NyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eH1jzfNxtdjsvctrpjoqgvM7YPif0b2/uYYyLMAT58=;
 b=a8fVMG9CXaD+SqJKMQ7lXRP53rQZe8A/vNObl0a1SR7V7JGULaL7Hx9XvHfd31nXqBw8I2sbaBSY2Cw+TO54vOQuRJIDWjjhZG1zoo0nb+byivYT4XkLDizHM35OXgSTjL2t2z4+RTrdtTwaRJafKpJKkk1RWWMUc5Rq44JlF6Pxz4IRR3lKxsgEWABwMUCkXVegwnR/RvnOrNcFB/xyTiO4C27UiqDzcPuCFabm3Y6sRAfc5M3akWz4TzWbng3x1nOQfu/3Th49TKyBUuvEVPFAaiGbtAxEYVGCho2Qdn5TocgvRuVUMzxCRl8KAMRVnnmBinOh7pjw1WW1g/VRrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eH1jzfNxtdjsvctrpjoqgvM7YPif0b2/uYYyLMAT58=;
 b=D6b0PwsjQ9bCEOlGMqETxizfcmMm8R4/1urEhFNrOWDYudNEqEwH8pdLykBBll0wq2Dsicyxt+9IT6FcnZcj+M0beprMISpeU/HeZpyGhvPWOq7C70NVJ+bdu9SSIR2jos+/VbVsqX5FTEY933oxcHDorSOFchdyJE8kRK/uWm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB6777.namprd12.prod.outlook.com (2603:10b6:303:1e9::17)
 by DS0PR12MB8219.namprd12.prod.outlook.com (2603:10b6:8:de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 18:39:02 +0000
Received: from MW4PR12MB6777.namprd12.prod.outlook.com
 ([fe80::2113:34e8:8f3b:1a49]) by MW4PR12MB6777.namprd12.prod.outlook.com
 ([fe80::2113:34e8:8f3b:1a49%5]) with mapi id 15.20.9160.010; Thu, 25 Sep 2025
 18:39:02 +0000
Date: Thu, 25 Sep 2025 20:38:16 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Francisco Iglesias <francisco.iglesias@amd.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Frederic Konrad <frederic.konrad@amd.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Subject: Re: [PATCH v5 00/47] AMD Versal Gen 2 support
Message-ID: <aNWMGNGh49-t332o@zapote>
References: <20250912100059.103997-1-luc.michel@amd.com>
 <CAFEAcA8L-9hMZdMgvJLottXFs=ys9uNhmQk-3GFR6QtqahU9pg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8L-9hMZdMgvJLottXFs=ys9uNhmQk-3GFR6QtqahU9pg@mail.gmail.com>
User-Agent: Mutt/2.2.14+84 (2efcabc4) (2025-03-23)
X-ClientProxiedBy: BN8PR04CA0049.namprd04.prod.outlook.com
 (2603:10b6:408:d4::23) To MW4PR12MB6777.namprd12.prod.outlook.com
 (2603:10b6:303:1e9::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6777:EE_|DS0PR12MB8219:EE_
X-MS-Office365-Filtering-Correlation-Id: 937f3cd8-b8ee-4052-857f-08ddfc62cadc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9qg8/wvBJhtl59QpTxbL2IQFKz1e/YdtuvoofHGRqEDpSRfDxREFbyisxmt3?=
 =?us-ascii?Q?LAwPD0XT5XfXdHEOAzaBfFxUOuKJ7KaRcpB1K3oBw+hxq6GQ/4MLyu89o8Wf?=
 =?us-ascii?Q?fQTByx/HuHKmFOOELDYAYsUFRRYfO8nJLFuBhXDN+HgGw70pwn4hxucU56A9?=
 =?us-ascii?Q?sT/uVrxPcUVtux+qBCdDKeEXfbuFckHlydZ+952r+5t6GUc6wSpu1/mHeiSJ?=
 =?us-ascii?Q?59QHuWvYVoctp0djDN3XkVxe1F7Xf212HvxdszZ/ZK0ZYhhRv7xIhRkSgDg2?=
 =?us-ascii?Q?CAJoUjZjjH6VQMHoDtIH8wMzYffbFrITfWhNcm3aZAwNsJSueprvDaHyNCPQ?=
 =?us-ascii?Q?9eAsVhicoKCIDTg8M7jZD5X7OVnU8ke7fpnSB0LCXK8azCjfYiyj/4puHMaE?=
 =?us-ascii?Q?h64JRGKd6D03s+YDnhvL1k7WpuTP8gCB3Sv7d76ZodXTxSP+u0vSA1gtb8lJ?=
 =?us-ascii?Q?zPjksFnTrs0j0c6OYJezZuRUTWOY/NdP2SIWr0aczhV+lrX9slJ11scj7hNW?=
 =?us-ascii?Q?7z5AnaXdE6HYJghazrDeHfB1KwydIRF+6+d9+Jz/49A3/yWE9IfMkoD8LPEy?=
 =?us-ascii?Q?UKay1S93NbijPZa/NrlFn/mfrg5Ru/xia4Und2f5RheJHk74sF1ZXIW+aDPh?=
 =?us-ascii?Q?fyzuD/88GLTj1bZJ0gCE44xGUIkyDlmBGOGdghitNzy/ORHerc4HekXl+2bi?=
 =?us-ascii?Q?Lpg5GmDCbcske1dzUEgk8wsINIwGC+0fn5aTsRyFsaVv4mc/A9hHchw8HWuV?=
 =?us-ascii?Q?mBt9XFtbgAeYH2AavIAEGEAJpjpcPX6whboGBGPt1+5TsOFkje0jYAm8MUcA?=
 =?us-ascii?Q?ixFCivqY94tQT6c36ib9P9sZN5qW0tNpLqrVyTXrKuADoxWqbnKsGXAXv6bP?=
 =?us-ascii?Q?F9erODq5w5POdK2d8yryntIu9Emqya5JefuHmBPYRbXKjvaf0QgDmK/UhueW?=
 =?us-ascii?Q?RmK2kJmwbXN+5+bPXDqYrwevmcmYYogjPpy7G25qj/xjHUo88ePPuhKviSOs?=
 =?us-ascii?Q?njfIBZIDHzv3VyikxDgOQgL+AQo+swPNqdnKwu/v/l/N7nG9CftQ0d6orsDJ?=
 =?us-ascii?Q?C3BkmYYtJq3k5HdfVjFDKXP4sGIhu74lNg2fKd10ifNk1sRmko7PNO1UMV7z?=
 =?us-ascii?Q?09kiKjrijlsypQ5VvNuIO3ScFPEsRsG+4jxDaqrrnbn6cUnYFnOqTJ0KOSqx?=
 =?us-ascii?Q?lyOPMUz2U/niUZkHufa7edIP5VhrUTsOTquClzfmeK/Pb4gWrvDaRv7o51ET?=
 =?us-ascii?Q?5aJ/8yvApDiMvXbO3cSlkC2rB9WEE1b2pMNvyl6YHbnlzoth49SHXngiFD50?=
 =?us-ascii?Q?FiXgIpZ08BchYhOqDDMSrDhVYkjU++2ZRhI4vmBtjUiAGrd1/dbZ+oO7RSGX?=
 =?us-ascii?Q?ZgnMGz4TIPD7/QLonLGGZSfPisAXXfJ81MiEImjppe5dqSgwqvS3/B28vQ4q?=
 =?us-ascii?Q?giTmh3pPraZzpxaTaLUVRUZYrFydNS63?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6777.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FNYSRHTfuB1ZOBswucyd4m90Ykt9sS/lHuV+eFbGYsZMLqc8V/4nHEWKtekP?=
 =?us-ascii?Q?5lt2ja4zm49jdzYz4QM7AJNBKciZAfYQhQBVYpRQ2/27E2zprcBqyhDt1rQa?=
 =?us-ascii?Q?i06dxfETHKJX/ykM7latNfevqw7PmqUSRJyTNjZKmjGEwXRCGxKLA/4Ccd3D?=
 =?us-ascii?Q?eW1sdD2Mu6KDOdqL2bG953RGyhfEWNBBd9eGn4+TTWxkFbiw78t7XifhquDo?=
 =?us-ascii?Q?CDjafUMeR4PoTVerE8j7OUpw/v+DtML7ro5ZOikjNxn9r6LEm+0l+NsQZ7lY?=
 =?us-ascii?Q?fslOgRfq/I6lr1yLo6mIkcWoNYg+sCSgh/2WDeNnjfPNpnZaUnFGZZ7poV3o?=
 =?us-ascii?Q?PnhlfUgsBoRmF08TKcvBZbJCFZYOHDyQSLnkZylzJxclkq5zeqneK82B32VW?=
 =?us-ascii?Q?+ldwp3Lj0pyLC8Wpw6FUTRnLikBczi1lYxShePgodHpyPOSQ6q4xLtND1i7g?=
 =?us-ascii?Q?GZ//XIOAAZsn76W3tx/41oHoZIm1cc2n96ZbyvvvkZAUizEJKZ+OjFjtLIuJ?=
 =?us-ascii?Q?nmzFSHo8xK9IJDQ/KLODX/8AOYFeF6iMuSHWZ+wNYTUzoMdbhyeDfwXVhtZz?=
 =?us-ascii?Q?FE6n4V8N7x4yVAVgbGsskTvXmpD05QNxfPuKWoIW7IrjbMHCH8vPC8hPlTK8?=
 =?us-ascii?Q?SyD/BSHFqn5xe9ztl9n621cM8X9+QmD4wznE/6C50NdpRxaajbfysdBoF27R?=
 =?us-ascii?Q?lF0j8bvRrcjKJeCD2gm44/ttXByNT/DvSgSV0VnEqtMrTyxR3F2sPrHr6XcS?=
 =?us-ascii?Q?rgh8DlaJUQsQb58kK4xuFiMrtKi7LybGjypEoRe9I1KYQ/m86CniwEOiaers?=
 =?us-ascii?Q?wwIid4XEuXaR/VgpY/BCcHObk0drwzzE4eM0AhMCJtOxm8O+lwSfc5wrE6mh?=
 =?us-ascii?Q?eotbgT92QaBHbcWn1sjp5/6+xVqX+DGrQtaRR9jT5Je+sdCaWkqxeF2a695z?=
 =?us-ascii?Q?3V4PcFtw6Nd1oFM80mOV2BPKDdBsIBx7Lg1q39hAnHpGAYWzKX7SIWGOiZzJ?=
 =?us-ascii?Q?DL7NB0ya6J8y3isIWbIozHilJph8WPXyzkTAyq9mO3CM1juMnaVqF9eeVPFB?=
 =?us-ascii?Q?a1RJv9oY08oLIsErOtm0cgm2EFoKroRhfQ7cIM5d3Cb7CzNu+4YctmXu/xEq?=
 =?us-ascii?Q?MmJ5srwPj2RYqueXINW47znlCXc40xSghlkOUSoZdCJA1NaG0ar6H2KmKWS+?=
 =?us-ascii?Q?SsJS1VIBAJhrgJEENi7Thr4obCWrhkcuYvQDR7XmuNS+oN3BUZytn3L9FyO6?=
 =?us-ascii?Q?u5LMF9Jqc4h2uzzCCx2Zs6s9sIaTqN8czMX38iN9IlIBQZO/XWaHFje3R4+p?=
 =?us-ascii?Q?BUMtH0C1/mTN2OWvbqXcXMxrJ33dDqBvo/a467tFC27U0osoZAdfzFo99i5r?=
 =?us-ascii?Q?u+OPH2oGUjith6co2nHgUc8zt0QVemB1cD+hZh+3BJaHnB4GnyCUF5ahXYrW?=
 =?us-ascii?Q?saWRUu2D/s500+2w4Sr9K4ofMKvh02iLE/sE8q6P1nx2sPq+Qf2z4wFNuKQ0?=
 =?us-ascii?Q?CLFipPCmWZMR/CRBoJ7ZAFJrQLqmJVCoXjBWydHsskpTLoDwZ22uNHt2q99/?=
 =?us-ascii?Q?I5+n0VB40snb2zkF/9L3WmqA1vCUOeqm+5cn+zaD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937f3cd8-b8ee-4052-857f-08ddfc62cadc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6777.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 18:39:02.0261 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YeNwtz5JT4QjkhYtoFc9Sry1E3f33xH9U0Dn1htQLtbfIQ0EOLyGNPt5UAkFcDMX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8219
Received-SPF: permerror client-ip=2a01:111:f403:c10c::1;
 envelope-from=Edgar.Iglesias@amd.com;
 helo=SA9PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On Thu, Sep 25, 2025 at 04:41:31PM +0100, Peter Maydell wrote:
> On Fri, 12 Sept 2025 at 11:01, Luc Michel <luc.michel@amd.com> wrote:
> >
> > v5:
> >   - Patch 36 (xlnx-versal-crl versal2 version): replaced `return NULL'
> >     with a `g_assert_not_reached()' in the versal2_decode_periph_rst
> >     function. [Phil]
> >   - Fixed remaining memory leaks in the Versal SoC by adding a finalize
> >     function. [Peter]
> >   - Patch 39 (cortex-a78ae addition):
> >      - Switched to the last r0p3 revision.
> >      - Removed the CBAR_RO and BACKCOMPAT_CNTFRQ features.
> >      - Fixed the comments referring to TRM sections. [Peter]
> 
> Edgar: are you still reviewing this series? (I noticed you'd
> left comments on patches 1-4 so wasn't sure if you were
> intending to continue, or if you're done now.)
>

Hi,

From my side, there's only one small outstanding question for Luc
(change if stmt to assert). I'll ping Luc!

Cheers,
Edgar

