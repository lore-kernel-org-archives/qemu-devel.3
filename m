Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D661BE77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKXTl-0002R1-1p; Mon, 09 Dec 2024 01:42:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tKXTd-0002Lf-2X
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:42:41 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tKXTZ-0003xZ-QO
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1733726557; x=1765262557;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=qRpq/nO011EUWFTE/dLUgADZHGbP63DaFyJ6sGglrTY=;
 b=vo6TtGcVMx81RiVAY/QpaaJR6DOFKDeknnAIj581EGzK4qmw8rM7Z0qq
 thFqgRO9Sts4eEMO2mjrSihxejsdYnga1cCh3rwuY7gH3rsy58kM+D9iG
 Xc7iKWQ7rBL3X1hGNPzMGYNyl9HezOYPP9wbT7nqgiM5s16+5GTGHuHKe
 MZmiY2U8PnfTotonKrSiXAbKKeE39qg2I6NLZeIHxr+SEXheBYfMZTaoN
 5p8w9pgZilmZLNtLyPHmc9/cL/gACWq13ZwGRmf34iAkGqxvGamScQC04
 +hhQYW0kqB8+j6we/gw6VQOYRJUXx8eCGu1LCZRwcXyDzXtBps0ruAaQ4 g==;
X-IronPort-AV: E=Sophos;i="6.12,218,1728943200"; d="scan'208";a="26302675"
X-MGA-submission: =?us-ascii?q?MDFEEPvwVyGhz4TDqfjMR78OVAfKtwoThVNoDF?=
 =?us-ascii?q?bahbW50FKIuI8++0d5WaGBQgy7m7ifTzj4W6vM11p2eHpPWjdqez7UG+?=
 =?us-ascii?q?oHoa7GwFEPTtK71VW3H4BNPa7r+kBNiESvDlLReEuiJrpqlg03nOnatv?=
 =?us-ascii?q?Jn+L7CBsFVCXR3dzAD+KrZMw=3D=3D?=
Received: from mail-vi1eur02lp2049.outbound.protection.outlook.com (HELO
 EUR02-VI1-obe.outbound.protection.outlook.com) ([104.47.11.49])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 07:42:33 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yIMeOTthW6lo0nw7Zph7/RSbZzKLqEZT6B2w0QiMGE/7z0Vh1gGiVsoaZ077JF0M3ARLRuJg+6dC8Izohc0xd32BRh3ZI94MkEE9xieJUATd/6+2nngYsRf40319RMp1bYSS5x/R0dk3yni3qN3ZlxIBgNPbdI37pk2yQvgEJoBB0QY7Ept71wNJ/VN0ylJfwZyu3v6CjNNTC+Hb25AdO9/MRPUELS/xAdQifEflwDiJZ4QpB2x2ztfiTf/AyXufLlEGS9zxR/8xrqOiS+0TV+bmMVKQFyryJJF3TcT77B2JOqH9NzNxkBUJ7NMdgJg2iT3hQzYO85nMJKYSybysIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qRpq/nO011EUWFTE/dLUgADZHGbP63DaFyJ6sGglrTY=;
 b=M4RF+kaW+Cr1jcdvxM9CKy9wwLpJxdEmjc2AeTTXxl6fagCaSZ6t8NiWs4veXdNoZ65L+zSphXkkJc9zlGHlcQodOn7OIboXkxPwXVfibNAbHYnHyfnVP89qiSLGdAKIMEE0UPcJESy5Zd4zh5MnvRgbg7Ty6uo7KNwO1nUKEC4D/p0k8kjLOJSkwIBKXoS05gbTlZ7ags/aphD3yc9YLMZl6DekL1RYx50iS8r+bQZlp3UnEK1SSHV2VKegKPps/cboqtmCRT+U0wpvk81cNPiruYruHZ3Egp0CkzMjgdFPn8/HzOehf8mAZjInEGzsMRVXIt57ZD3WPo7sl37PAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qRpq/nO011EUWFTE/dLUgADZHGbP63DaFyJ6sGglrTY=;
 b=Vcg2vyean9Lrlk5CxxPNM32S9AlNVTbO51cJEJ++I2zdkeHnBKhIPVDBaVqxwd4Ugapn6WP+d1YUO9waRE8ZddXD9oTjO42IZGSXtl26uuEAoseBBWGMwXeGvng52J+NlWPUpC20haqi3ak/vIz1W5jNsmVl+fARYQeOzyJ2A/uhr4M3lupsGlBTvxHfKbt7P9uCsSZ+9Jj9+6qyd5TxdlfXSCrD0Z2vuT4i9aIx/ufiaNTlqQBVo5b3ODIn0tTM6tWy12qcnATPF53vk0EtsDvSse4aUd53XfY2xoUAru56qA3IvIcsEePuEUQFlBLwfHcR20SXrrwgE4QO1NIlwg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by DB9PR07MB8612.eurprd07.prod.outlook.com (2603:10a6:10:308::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 06:42:31 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 06:42:31 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Jason Wang <jasowang@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBU5r5oNBkqzVUqCcHjZN6/EL7LVkrqAgAAsh4CAB6k4gIAAMqgAgAACyICAAATsAA==
Date: Mon, 9 Dec 2024 06:42:31 +0000
Message-ID: <bb7df163-e3fe-4d26-93c2-756a7b6be15a@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
 <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
 <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
 <68d3a523-19c4-4296-9df8-b98b498d4c0e@eviden.com>
 <CACGkMEs0xTf+YeCWmBbyJaQSS2RzBe2pBYzrv3n_mW+6EV4few@mail.gmail.com>
In-Reply-To: <CACGkMEs0xTf+YeCWmBbyJaQSS2RzBe2pBYzrv3n_mW+6EV4few@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|DB9PR07MB8612:EE_
x-ms-office365-filtering-correlation-id: 9e20cbd7-698c-4a61-fa77-08dd181ca82b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?eXc1NGNCaFVJNmpHT3d6elpzNWhuR0MwMjlFd3NCclZXMEpiQUhRQWY0QThp?=
 =?utf-8?B?MXNLeG1oN1VRNzJjUmZEenRGczhlY0tlMGsxVFR3OWg5bVdabmY2QVl6T0p4?=
 =?utf-8?B?QkNuSnE5WFJHZWY0UUczcVVEZ0hWNjhkdHNCUDYrY2RSREw5ZmtrT01SbHFV?=
 =?utf-8?B?Q1Z5bGt5SzNYTXp4SDdoenJPc1F4NVExZkNxd0ZseW8zdHZEdEo3aGlRSHV6?=
 =?utf-8?B?aFFLWG5VT1R1QkptUjNtMWxxSkZMMUNreldpeVhzYWtsbytTdUZUN2NUMlpj?=
 =?utf-8?B?eHlvU2wzaXp2aDZqYTdZRmdudmdqVS9PSjY4cFR6WmM1UE8wT1N0b2ZhR3VV?=
 =?utf-8?B?UWxxTFN4NVZEeDBlenNScmJndFU2Zm5ESUhQY3RPeUdrMkh0YTBBcUNGOEJB?=
 =?utf-8?B?dlVqTWcyYjJodXJFM0l6enpzVkFXWTArNG1SRzVVWDBUWG9CSkNDYU81eFZC?=
 =?utf-8?B?SGxIZUxHM2ZROW12a2c2cjdsSGlzMGhHcFE3N2RiajRCL3F0QmY3dWM3N1Ir?=
 =?utf-8?B?RmNoTmRvQnlyTXdib0J0dTd4NFROaTkvZUNJU09LR3VhelkwT3ZZZ1VwNURW?=
 =?utf-8?B?ZE8vQW9taFMvY0R3ZkVqMUpjbENLMndIbEdZTktQV3ZidnVIYitkcm5SWUdx?=
 =?utf-8?B?YW56VnNEQ0lmd2JMTWpROEZwazY0WVAvUnFKcVJLK1l5R1gzVUZhR3RpN0VB?=
 =?utf-8?B?OVRQYmlWL1U5YU1HUTJ0Tm9mZUtZOFdxZ25qazQ0dG1ZZEN5V3lIcno1T1FZ?=
 =?utf-8?B?WUVuVHA0RW4xU1pUb0VTekVDdm9zUUN5RHFab0xjV1dZOStBcllZUjR2NHRv?=
 =?utf-8?B?cVRjQVJ0WFErNTBLaWxWUyt4ZnJ5K0wvT3VPM3VUdU5oSkg1aVQwam1iSGlH?=
 =?utf-8?B?cHhwME5nbnVrdlpmTDNpeDFGZS9jT2dNbmc0MmZRY1BwTFdUQjArYzRaUGFw?=
 =?utf-8?B?T2ZGSzc0MHc1U1d3K1k4MVBjMHBscHRDMk5GUms4SlJmSFhMTmFEM1BuaGhk?=
 =?utf-8?B?WWw0c09ZbHNOT0l0RTFTbGJEL0ptUWhPQlV3UHBJUGhpcVVnRWRveVZGd2Rm?=
 =?utf-8?B?NlNycndDYmQwMjMydkpkbW54UG9Xc2FRbkJtTmpidFBoTFVONEtPNmVOV0NZ?=
 =?utf-8?B?WHpIUDVqM0VrZThvbkFSakhJSVFhM3lvMW1JU3V2ekFJRytJWHJ0WUllb0RY?=
 =?utf-8?B?dGNVZlBHWHp6WDljMkpWY0ZMS041d1ErUllmZFliUHRPeW5XYjNJT250Z1BC?=
 =?utf-8?B?UnFHQ1ZYRXZjWGMrYjl3TjZxNm1jTWxKTlh1VytieWtRMnY3aG9OSENPZGkz?=
 =?utf-8?B?bDAyanBtaEpwcUQzbzZpWEpKWGFYelFqRHhxd1ovNmcrTUx3THIxSE5pMVhW?=
 =?utf-8?B?VmtPNlRaSlU3QmVKL3cyTGJqNmp1RnVYWnNNby82U3FoaHJudUZ0MUsxWFd4?=
 =?utf-8?B?cWR1MmtVYTRCSTVLOVl3aitLUy93ZmxFNXNmLzgvVmFFUFZBTDBLMDFOcGhv?=
 =?utf-8?B?NzJaQU9CMXdobVFHOFg4S29MM1JRemlMY05sMEJmZXJxRWtmc1drQ2pqazVp?=
 =?utf-8?B?RGlDZkY5MGlUb1NNR2RHRXlvSzdlanlVVjN4NTk1RERRMWFZam1QU2k3aWhu?=
 =?utf-8?B?cGp0S0RiVzNhZlVnM2ZKcldPRGtSSWRxY0duc3NmRGVGSjhORjNGNFd0d25C?=
 =?utf-8?B?WHdyR1o2MEVybGJGQ0pnNVN1Sy9nY0hrR1A2WkNyZ3ZmdkhVZitKZmcxVk43?=
 =?utf-8?B?V0RtUFRaeDh5M2lCNUsrOXJUYjlUQ3dmR3NSUkpzYm9YVWRyamJ1S1VadTRl?=
 =?utf-8?B?bzE0QlJsVkpwTWhndklqeFd2dXBmSnJiL0J4TlNlUGYzYUNVN3V3cWM0Zllo?=
 =?utf-8?B?SnUrelJrbC9yalN5YTR0TTBtc2J5eTVqajhUaHBYWTJzSGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDdRR2t0cis1SDl3K213YXRGRkJTRjVvaXVhY0xhSHRuMXpOWE5QM1FwRlhE?=
 =?utf-8?B?R2F3NW85Y0xkU1F2angrTmdvMkYwajYzc1hRdTh4WGFHcjFGWG85SXBmeXlW?=
 =?utf-8?B?eUx1M0lSMG40eHJIaWxkZ1FFK3pDRjAva0hVaE9pZEZUcFpTK3liMDRaMy9U?=
 =?utf-8?B?NGZyTTZKL2t3M2I2eDExc1YvYk9tb0N4R0Q4QjBFK1N6MTN6SnZscnZQbEZU?=
 =?utf-8?B?TkJjNVJOeXZwcTFyc0lZUURYbFRkRkJjSVU5dml4ajhEb1hlTHRmazNKL1RQ?=
 =?utf-8?B?RkwyNnlRaThHdzZ2ZGN2VEM0ek1qMFByelhLN1lUd0pvalNNZUxhSjV3ekhF?=
 =?utf-8?B?aVRmSU85SUpBZ1VuQmxXek1YeEU1dDRxdDVUZEl5YTFBa1RDMFlWWS9DWVA2?=
 =?utf-8?B?VnFDVjRoMDcyMlJRMXlCZ2hpRm5VU2g1SEtWOHNaanNtTG04RWZyVXhaL1pT?=
 =?utf-8?B?djNJWHBYNDhrVXpaNHkwTnh6VStmR2w2Sjdma3drdkVVRUQyNkcyR0wrWmtJ?=
 =?utf-8?B?OS96TGVoTklhU29pem1kTkZqSVRiN1pKRVJoeXF4czlRSjVES3FRVGdNdDZu?=
 =?utf-8?B?a0xIeFk0YTB2RVpRalNINEtIREVyVDZGMktWYlIyZXppVS95TjI2STI0ZVlo?=
 =?utf-8?B?OWlpSGFKcENkN0FMOUV0M0lTWnNhS1IxK09wWGF1NkxMRDZHeThxY0s1SzMz?=
 =?utf-8?B?U3RIcVRrbnNnYU1OWmNBd21WSnhwWTg1ellYY3JORzBBcWppY01yS1hIRVov?=
 =?utf-8?B?MTBOTWh6UnAycGlRMGIvaWhqVHFkS3N4cEViVzR2Y016RjIyMzBqZ1pvUHBh?=
 =?utf-8?B?Y1h3K01YZEN5NC9GTWV3OXJ5am1yaHhScHNkcURCb1NUZUwwdThMenAzUEE1?=
 =?utf-8?B?RFVMRERqcWdKYy9jeUF4VmtPMHFwUGM3R0d2KzNlRE1USVNacWpJQ3ZwL1pJ?=
 =?utf-8?B?SCtQUkdiWEwwVituNjFaMXBRMHNlcExiR0YzWVN6akNnZTZEWExPaXhYRGsv?=
 =?utf-8?B?OFJqTDV0dHVmeDVqSERUZjROQWovaE5ua1BlekU2YU83TlRla0ZiTGs1L3ln?=
 =?utf-8?B?WG43bkQ0SzZoclN0YUQvM3h2ZnN4UzNiS1crdVAvRU5zL2hlRlVYUC9UWnhj?=
 =?utf-8?B?eXVwOFBsTmQ5bEFnRkRqcXdTbVVET2VqWFhmdzNsbmJCSTRuLys5VDQwN3lv?=
 =?utf-8?B?SG9MeE1PdTdDRmovUmtJOUN4Z05MbUZIWXdkL1JMNy81Nys3ZlR3M3RYeURs?=
 =?utf-8?B?b2NGU29jUFNlT1p2VHNtenpOejFyazJwcjI4TzVyRnFwQVdYVUordFVobjRi?=
 =?utf-8?B?RVNEN2NnSldQZzU0SEVzaHg3QkJSVjZPeFNlMW1UQ2piRXpmdk1ISitBU01G?=
 =?utf-8?B?N1FCNXc3MEJlTlBQV1hQcm5udW5xRy82S3VuWVpUbTUzRHNhN0xpTUhLQVBC?=
 =?utf-8?B?c1J4d3YvZXJCUHpEVGVEWGlTbHh1S3VHZVRGMVlhM243ZVk2K0I2WFAyZUt5?=
 =?utf-8?B?MFdIdCsyUC9CMmlQMGtvL2NFTWpkejhIYXN0bCtpKzZHQjkvVG9XMGZTMXcr?=
 =?utf-8?B?VCtZcWZhZjFQdDhQajlNT2dwalhFZDlRQks0WDk5NllWdjlmZHprRUJYb3p5?=
 =?utf-8?B?UnU3YzJXbDcxQUEwY2lnbVlsRVNiTmNPckc0UUFBQjBVSENLMmR6UEQwTU8v?=
 =?utf-8?B?U0hJMWhvL1k0MW5pa1l0cHgyczBaS2d2TGdGaGtlSnVnd2pBWkZoWmxoMmtS?=
 =?utf-8?B?QXliVndDRFE5MGQ5dnBsZU13WnNFYWc3SkJwb1kwbnZhekpyN2J1UklTT0hI?=
 =?utf-8?B?ZkJpN2NiVlNMVFhPWWk3bDBML0Z5SktRVExvVUpERFVTalpycEtKdno2V0M4?=
 =?utf-8?B?YWRjRzR4UUVEcUxUOTFaZ2dSRFk1emcxZTNTQ2lmTzJyaXhoaWZyU04wOTd6?=
 =?utf-8?B?VDQwZjhkZ094T3JGT2hiWHF3aE1BMktpaDdMSHlEdnFBajl1clVNNk1rQVVw?=
 =?utf-8?B?RmY1ck1yeGJXTVBQZGNCTnF4dm0yWXl1eGt5enl3alBEcldqN3ZRSlB3M1VR?=
 =?utf-8?B?b2x2MUgyUHFuNm14TnhJTkRveTZ5bnhIcmFyMHlaUjhaR0JiaEFCanZ2WTV0?=
 =?utf-8?B?cWlwN0VERzVpVWNsTmh2a29sdlZwS0FVVFNNTW5maERlak0xRHJDcHh1QW85?=
 =?utf-8?Q?djfER1cPlgGQ3DcOd6ECLc0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <84C0E138AB245E4595C583755D6F3F82@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e20cbd7-698c-4a61-fa77-08dd181ca82b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:42:31.5751 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8dFVcBJ95+0hefMMrrwONZgTF7O1byLBWAzPQwTus/a/HxlfKpI5hWYvapM1wStN7xDUo4paxQZpRm8ywI3/VMWNFymVcRvDj6XxFNH1EwsV2Gx6LAbkqvhZVHT03pXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB8612
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

DQoNCg0KT24gMDkvMTIvMjAyNCAwNzoyNCwgSmFzb24gV2FuZyB3cm90ZToNCj4gQ2F1dGlvbjog
RXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1
bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlLg0KPg0KPg0KPiBPbiBNb24sIERlYyA5LCAyMDI0IGF0IDI6MTXi
gK9QTSBDTEVNRU5UIE1BVEhJRVUtLURSSUYNCj4gPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMDkvMTIvMjAyNCAwNDoxMywgSmFzb24gV2Fu
ZyB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNo
bWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93
biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4NCj4+Pg0KPj4+
IE9uIFdlZCwgRGVjIDQsIDIwMjQgYXQgMjoxNOKAr1BNIENMRU1FTlQgTUFUSElFVS0tRFJJRg0K
Pj4+IDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+
DQo+Pj4+IE9uIDA0LzEyLzIwMjQgMDQ6MzQsIEphc29uIFdhbmcgd3JvdGU6DQo+Pj4+PiBDYXV0
aW9uOiBFeHRlcm5hbCBlbWFpbC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlu
a3MsIHVubGVzcyB0aGlzIGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBr
bm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IE9uIE1vbiwgTm92
IDExLCAyMDI0IGF0IDQ6MznigK9QTSBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPiB3cm90ZToNCj4+Pj4+PiBJbnRlbCBWVC1kIDMuMCBpbnRyb2R1Y2VzIHNjYWxhYmxl
IG1vZGUsIGFuZCBpdCBoYXMgYSBidW5jaCBvZiBjYXBhYmlsaXRpZXMNCj4+Pj4+PiByZWxhdGVk
IHRvIHNjYWxhYmxlIG1vZGUgdHJhbnNsYXRpb24sIHRodXMgdGhlcmUgYXJlIG11bHRpcGxlIGNv
bWJpbmF0aW9ucy4NCj4+Pj4+Pg0KPj4+Pj4+IFRoaXMgdklPTU1VIGltcGxlbWVudGF0aW9uIHdh
bnRzIHRvIHNpbXBsaWZ5IGl0IHdpdGggYSBuZXcgcHJvcGVydHkgIngtZmx0cyIuDQo+Pj4+Pj4g
V2hlbiBlbmFibGVkIGluIHNjYWxhYmxlIG1vZGUsIGZpcnN0IHN0YWdlIHRyYW5zbGF0aW9uIGFs
c28ga25vd24gYXMgc2NhbGFibGUNCj4+Pj4+PiBtb2Rlcm4gbW9kZSBpcyBzdXBwb3J0ZWQuIFdo
ZW4gZW5hYmxlZCBpbiBsZWdhY3kgbW9kZSwgdGhyb3cgb3V0IGVycm9yLg0KPj4+Pj4+DQo+Pj4+
Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBleHBvc2VkIHRvIHVzZXIsIGFsc28gYWNjdXJh
dGUgdGhlIHBhc2lkIGVudHJ5DQo+Pj4+Pj4gY2hlY2sgaW4gdnRkX3BlX3R5cGVfY2hlY2soKS4N
Cj4+Pj4+Pg0KPj4+Pj4+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4N
Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4LmludGVsLmNvbT4N
Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lvbW11X2ludGVy
bmFsLmggfCAgMiArKw0KPj4+Pj4+ICAgICBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAg
fCAyOCArKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tDQo+Pj4+Pj4gICAgIDIgZmlsZXMgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRp
ZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+Pj4+PiBpbmRleCAyYzk3N2FhN2RhLi5lOGIyMTFlOGIwIDEw
MDY0NA0KPj4+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+Pj4+IEBAIC0xOTUsNiAr
MTk1LDcgQEANCj4+Pj4+PiAgICAgI2RlZmluZSBWVERfRUNBUF9QQVNJRCAgICAgICAgICAgICAg
KDFVTEwgPDwgNDApDQo+Pj4+Pj4gICAgICNkZWZpbmUgVlREX0VDQVBfU01UUyAgICAgICAgICAg
ICAgICgxVUxMIDw8IDQzKQ0KPj4+Pj4+ICAgICAjZGVmaW5lIFZURF9FQ0FQX1NMVFMgICAgICAg
ICAgICAgICAoMVVMTCA8PCA0NikNCj4+Pj4+PiArI2RlZmluZSBWVERfRUNBUF9GTFRTICAgICAg
ICAgICAgICAgKDFVTEwgPDwgNDcpDQo+Pj4+Pj4NCj4+Pj4+PiAgICAgLyogQ0FQX1JFRyAqLw0K
Pj4+Pj4+ICAgICAvKiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+Pj4+Pj4gQEAgLTIxMSw2ICsy
MTIsNyBAQA0KPj4+Pj4+ICAgICAjZGVmaW5lIFZURF9DQVBfU0xMUFMgICAgICAgICAgICAgICAo
KDFVTEwgPDwgMzQpIHwgKDFVTEwgPDwgMzUpKQ0KPj4+Pj4+ICAgICAjZGVmaW5lIFZURF9DQVBf
RFJBSU5fV1JJVEUgICAgICAgICAoMVVMTCA8PCA1NCkNCj4+Pj4+PiAgICAgI2RlZmluZSBWVERf
Q0FQX0RSQUlOX1JFQUQgICAgICAgICAgKDFVTEwgPDwgNTUpDQo+Pj4+Pj4gKyNkZWZpbmUgVlRE
X0NBUF9GUzFHUCAgICAgICAgICAgICAgICgxVUxMIDw8IDU2KQ0KPj4+Pj4+ICAgICAjZGVmaW5l
IFZURF9DQVBfRFJBSU4gICAgICAgICAgICAgICAoVlREX0NBUF9EUkFJTl9SRUFEIHwgVlREX0NB
UF9EUkFJTl9XUklURSkNCj4+Pj4+PiAgICAgI2RlZmluZSBWVERfQ0FQX0NNICAgICAgICAgICAg
ICAgICAgKDFVTEwgPDwgNykNCj4+Pj4+PiAgICAgI2RlZmluZSBWVERfUEFTSURfSURfU0hJRlQg
ICAgICAgICAgMjANCj4+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIv
aHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+Pj4+Pj4gaW5kZXggYjkyMTc5M2MzYS4uYTdhODFhZWJl
ZSAxMDA2NDQNCj4+Pj4+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+PiArKysg
Yi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4+PiBAQCAtODAzLDE2ICs4MDMsMTggQEAgc3Rh
dGljIGlubGluZSBib29sIHZ0ZF9pc19mbF9sZXZlbF9zdXBwb3J0ZWQoSW50ZWxJT01NVVN0YXRl
ICpzLCB1aW50MzJfdCBsZXZlbCkNCj4+Pj4+PiAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gICAgIC8q
IFJldHVybiB0cnVlIGlmIGNoZWNrIHBhc3NlZCwgb3RoZXJ3aXNlIGZhbHNlICovDQo+Pj4+Pj4g
LXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9jaGVjayhYODZJT01NVVN0YXRlICp4ODZf
aW9tbXUsDQo+Pj4+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERQ
QVNJREVudHJ5ICpwZSkNCj4+Pj4+PiArc3RhdGljIGlubGluZSBib29sIHZ0ZF9wZV90eXBlX2No
ZWNrKEludGVsSU9NTVVTdGF0ZSAqcywgVlREUEFTSURFbnRyeSAqcGUpDQo+Pj4+Pj4gICAgIHsN
Cj4+Pj4+PiAgICAgICAgIHN3aXRjaCAoVlREX1BFX0dFVF9UWVBFKHBlKSkgew0KPj4+Pj4+IC0g
ICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0KPj4+Pj4+IC0gICAgICAgIHJldHVybiB0
cnVlOw0KPj4+Pj4+IC0gICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfUFQ6DQo+Pj4+Pj4gLSAg
ICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRfc3VwcG9ydGVkOw0KPj4+Pj4+ICAgICAgICAgY2Fz
ZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0KPj4+Pj4+ICsgICAgICAgIHJldHVybiAhIShzLT5l
Y2FwICYgVlREX0VDQVBfRkxUUyk7DQo+Pj4+Pj4gKyAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRS
WV9TTFQ6DQo+Pj4+Pj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRT
KTsNCj4+Pj4+PiAgICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+Pj4+
PiArICAgICAgICAvKiBOb3Qgc3VwcG9ydCBORVNURUQgcGFnZSB0YWJsZSB0eXBlIHlldCAqLw0K
Pj4+Pj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4+PiArICAgIGNhc2UgVlREX1NNX1BB
U0lEX0VOVFJZX1BUOg0KPj4+Pj4+ICsgICAgICAgIHJldHVybiAhIShzLT5lY2FwICYgVlREX0VD
QVBfUFQpOw0KPj4+Pj4+ICAgICAgICAgZGVmYXVsdDoNCj4+Pj4+PiAgICAgICAgICAgICAvKiBV
bmtub3duIHR5cGUgKi8NCj4+Pj4+PiAgICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+Pj4g
QEAgLTg2MSw3ICs4NjMsNiBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfaW5fcGFzaWRfbGVhZl90
YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+Pj4+Pj4gICAgICAgICB1aW50OF90IHBndHQ7DQo+
Pj4+Pj4gICAgICAgICB1aW50MzJfdCBpbmRleDsNCj4+Pj4+PiAgICAgICAgIGRtYV9hZGRyX3Qg
ZW50cnlfc2l6ZTsNCj4+Pj4+PiAtICAgIFg4NklPTU1VU3RhdGUgKng4Nl9pb21tdSA9IFg4Nl9J
T01NVV9ERVZJQ0Uocyk7DQo+Pj4+Pj4NCj4+Pj4+PiAgICAgICAgIGluZGV4ID0gVlREX1BBU0lE
X1RBQkxFX0lOREVYKHBhc2lkKTsNCj4+Pj4+PiAgICAgICAgIGVudHJ5X3NpemUgPSBWVERfUEFT
SURfRU5UUllfU0laRTsNCj4+Pj4+PiBAQCAtODc1LDcgKzg3Niw3IEBAIHN0YXRpYyBpbnQgdnRk
X2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4+Pj4+PiAg
ICAgICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+ICAgICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlwZSBj
aGVjayAqLw0KPj4+Pj4+IC0gICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayh4ODZfaW9tbXUsIHBl
KSkgew0KPj4+Pj4+ICsgICAgaWYgKCF2dGRfcGVfdHlwZV9jaGVjayhzLCBwZSkpIHsNCj4+Pj4+
PiAgICAgICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9UQUJMRV9FTlRSWV9JTlY7DQo+Pj4+
Pj4gICAgICAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiBAQCAtMzgyNyw2ICszODI4LDcgQEAgc3RhdGlj
IFByb3BlcnR5IHZ0ZF9wcm9wZXJ0aWVzW10gPSB7DQo+Pj4+Pj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICBWVERfSE9TVF9BRERSRVNTX1dJRFRIKSwNCj4+Pj4+PiAgICAgICAgIERFRklORV9Q
Uk9QX0JPT0woImNhY2hpbmctbW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgY2FjaGluZ19tb2RlLCBG
QUxTRSksDQo+Pj4+Pj4gICAgICAgICBERUZJTkVfUFJPUF9CT09MKCJ4LXNjYWxhYmxlLW1vZGUi
LCBJbnRlbElPTU1VU3RhdGUsIHNjYWxhYmxlX21vZGUsIEZBTFNFKSwNCj4+Pj4+PiArICAgIERF
RklORV9QUk9QX0JPT0woIngtZmx0cyIsIEludGVsSU9NTVVTdGF0ZSwgc2NhbGFibGVfbW9kZXJu
LCBGQUxTRSksDQo+Pj4+Pj4gICAgICAgICBERUZJTkVfUFJPUF9CT09MKCJzbm9vcC1jb250cm9s
IiwgSW50ZWxJT01NVVN0YXRlLCBzbm9vcF9jb250cm9sLCBmYWxzZSksDQo+Pj4+Pj4gICAgICAg
ICBERUZJTkVfUFJPUF9CT09MKCJ4LXBhc2lkLW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIHBhc2lk
LCBmYWxzZSksDQo+Pj4+Pj4gICAgICAgICBERUZJTkVfUFJPUF9CT09MKCJkbWEtZHJhaW4iLCBJ
bnRlbElPTU1VU3RhdGUsIGRtYV9kcmFpbiwgdHJ1ZSksDQo+Pj4+Pj4gQEAgLTQ1NTgsNyArNDU2
MCwxMCBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQoSW50ZWxJT01NVVN0YXRlICpzKQ0KPj4+
Pj4+ICAgICAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gICAgICAgICAvKiBUT0RPOiByZWFkIGNhcC9l
Y2FwIGZyb20gaG9zdCB0byBkZWNpZGUgd2hpY2ggY2FwIHRvIGJlIGV4cG9zZWQuICovDQo+Pj4+
Pj4gLSAgICBpZiAocy0+c2NhbGFibGVfbW9kZSkgew0KPj4+Pj4+ICsgICAgaWYgKHMtPnNjYWxh
YmxlX21vZGVybikgew0KPj4+Pj4+ICsgICAgICAgIHMtPmVjYXAgfD0gVlREX0VDQVBfU01UUyB8
IFZURF9FQ0FQX0ZMVFM7DQo+Pj4+Pj4gKyAgICAgICAgcy0+Y2FwIHw9IFZURF9DQVBfRlMxR1A7
DQo+Pj4+Pj4gKyAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsNCj4+Pj4+PiAgICAg
ICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERfRUNB
UF9TTFRTOw0KPj4+Pj4+ICAgICAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gQEAgLTQ3MzcsNiArNDc0
MiwxMSBAQCBzdGF0aWMgYm9vbCB2dGRfZGVjaWRlX2NvbmZpZyhJbnRlbElPTU1VU3RhdGUgKnMs
IEVycm9yICoqZXJycCkNCj4+Pj4+PiAgICAgICAgICAgICB9DQo+Pj4+Pj4gICAgICAgICB9DQo+
Pj4+Pj4NCj4+Pj4+PiArICAgIGlmICghcy0+c2NhbGFibGVfbW9kZSAmJiBzLT5zY2FsYWJsZV9t
b2Rlcm4pIHsNCj4+Pj4+PiArICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJMZWdhY3kgbW9kZTog
bm90IHN1cHBvcnQgeC1mbHRzPW9uIik7DQo+Pj4+PiBUaGlzIHNlZW1zIHRvIGJlIHdpcmVkLCBz
aG91bGQgd2Ugc2F5ICJzY2FsYWJsZSBtb2RlIGlzIG5lZWRlZCBmb3INCj4+Pj4+IHNjYWxhYmxl
IG1vZGVybiBtb2RlIj8NCj4+Pj4gSGkgSmFzb24sDQo+Pj4+DQo+Pj4+IFdlIGFncmVlZCB0byB1
c2UgdGhlIGZvbGxvd2luZyBzZW50ZW5jZTogIngtZmx0cyBpcyBvbmx5IGF2YWlsYWJsZSBpbg0K
Pj4+PiBzY2FsYWJsZSBtb2RlIg0KPj4+Pg0KPj4+PiBEb2VzIGl0IGxvb2sgZ29vdCB0byB5b3U/
DQo+Pj4gQmV0dGVyIGJ1dCBpZiB3ZSBhZGQgbW9yZSBmZWF0dXJlcyB0byB0aGUgc2NhbGFibGUg
bW9kZXJuLCB3ZSBuZWVkIHRvDQo+Pj4gY2hhbmdlIHRoZSBlcnJvciBtZXNzYWdlIGhlcmUuDQo+
PiBIaSBKYXNvbg0KPj4NCj4+IE1heWJlIHRoZSB3ZWlyZG5lc3MgY29tZXMgZnJvbSB0aGUgZmFj
dCB0aGF0IHgtZmx0cyBvbiB0aGUgY29tbWFuZCBsaW5lDQo+PiBpcyBtYXBwZWQgdG8gc2NhbGFi
bGVfbW9kZXJuIGluIHRoZSBjb2RlPw0KPiBZZXMsIGFjdHVhbGx5IHRoZSBjb2RlIGNoZWNrcyBp
ZiBzY2FsYWJsZSBtb2RlIGlzIGVuYWJsZWQgaWYgc2NhbGFibGUNCj4gbW9kZXJuIGlzIGVuYWJs
ZWQuIEJ1dCB0aGlzIGlzIGluY29uc2lzdGVudCB3aXRoIHRoZSBlcnJvciBtZXNzYWdlDQo+ICh0
aG91Z2ggeC1mbHRzIHdhcyBpbXBsaWVkIHRoZXJlIHByb2JhYmx5KS4NCg0KV291bGQgeW91IHJl
bmFtZSBzLT5zY2FsYWJsZV9tb2Rlcm4gdG8gcy0+Zmx0cz8NCg0KPg0KPiBUaGFua3MNCj4NCj4N
Cj4+IFRoYW5rcw0KPj4gICA+Y21kDQo+Pg0KPj4+IFRoYW5rcw0KPj4+DQo+Pj4+IFRoYW5rcw0K
Pj4+PiBjbWQNCj4+Pj4NCj4+Pj4+PiArICAgICAgICByZXR1cm4gZmFsc2U7DQo+Pj4+Pj4gKyAg
ICB9DQo+Pj4+Pj4gKw0KPj4+Pj4+ICAgICAgICAgaWYgKCFzLT5zY2FsYWJsZV9tb2Rlcm4gJiYg
cy0+YXdfYml0cyAhPSBWVERfSE9TVF9BV18zOUJJVCAmJg0KPj4+Pj4+ICAgICAgICAgICAgIHMt
PmF3X2JpdHMgIT0gVlREX0hPU1RfQVdfNDhCSVQpIHsNCj4+Pj4+PiAgICAgICAgICAgICBlcnJv
cl9zZXRnKGVycnAsICIlcyBtb2RlOiBzdXBwb3J0ZWQgdmFsdWVzIGZvciBhdy1iaXRzIGFyZTog
JWQsICVkIiwNCj4+Pj4+PiAtLQ0KPj4+Pj4+IDIuMzQuMQ0KPj4+Pj4+DQo+Pj4+PiBUaGFua3MN
Cj4+Pj4+DQo=

