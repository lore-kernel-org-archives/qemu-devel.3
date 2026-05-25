Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88D74CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 09:27:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRRZl-0005gA-TX; Mon, 25 May 2026 05:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wRRZe-0005eM-FN
 for qemu-devel@nongnu.org; Mon, 25 May 2026 05:26:15 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wRRZc-000170-6G
 for qemu-devel@nongnu.org; Mon, 25 May 2026 05:26:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779701172; x=1811237172;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OTcKpxRP6SdpVqaXuPtsbWVEbkyEL9f3ZxmHwrQb4m0=;
 b=d/0ry+xqzPvWdOdZqDqQi2TDbkaNdw67wJ3JHcLrnTOy9Aa0mJglcsuZ
 AxkxnRzmVK2WwNhI4Yvr5JhBf3OGud/mF8zWBdk7IAWXYGyFS1uGfgbHq
 eY1HHHJdjSwzGHqG/3qNzsPXtFGDr+ZcYVsuWue5sHBoRZtjRMUEVtBLF
 tb+4gv848pEM0kxDJJ2mA7j0jt/lnregpWvcnzT/0zfv7mXrZiZZnJw6D
 ZmeZFzdoDN5Opnf0QbduMqRGSu6iHlqRe+GVL86COU6xw4vokNl3XUjj8
 a6BpvZxQaFt1IePx2/sDDuDY3Jc2lkmVwAL+66mR8GU4BZCfDWmjng+EJ Q==;
X-CSE-ConnectionGUID: JKUw3wQBTpGwwcApSDKdrA==
X-CSE-MsgGUID: GCtC4/4eSeSDdoz7vxFHrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="103202225"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="103202225"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 02:26:07 -0700
X-CSE-ConnectionGUID: aws1KKloRPSQ5Om0phDVnA==
X-CSE-MsgGUID: p2YdtD3tQwi96OTNgXyCsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="238980068"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 02:26:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 02:26:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 25 May 2026 02:26:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.22) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 25 May 2026 02:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQlszcssGwRT2rEl39Xq7/qe7xzzuTZ6kZEqG9Ta/fNygaPht9JDDc1FT4fMufWaDUr2DRGWuHQ9J5dSyM0CSNDJwTYlNFIBmqvpLqYQTWs3701vfwTGlnLvGru7gjvvNy0yvTW4WjJZaSmv5CZV2DPu+DJKqghfHpls0B8OKfsPUmp86cVVzmzc3BZkGdbXeft+eREhpMzZq9vqhX0EERFpWTln464cb26FQdhF00Gye5y0CnDMjGDwFz1/d0RTgTg3CCH/9KKZU/euHI+vz17FoMFU0OaEERrPoryqeQWmgWyAN1qTW0WKgrjRZdGyfguX17rUqvM2EQb4MWSMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYyclkWyP0+nbrGBwc/8ezTFw2rXRNHnaGuMHgS+Icw=;
 b=hL3ReAgOibOWKck8HaGKxtJWxCIBdYP4IwoIVJzJRHJd8E/3IvZcw5Kp6jJh7BV9ZTi1wIk13Ci33LSoUkwzUyLL7JGBX6Q01EPdTO+arfdsUb9vCwJKRthqY1qv595hruMvDGp7gPwa5WUKZ7YDu49X2q+0LZiJT6H4anIdJnRE2c/Brtiui/Vr5O5k6LAn/X3wf0HwtS4yIkwLdxZCYwsrhFBzOFlgN1RQ1YtxAo+CIvD5v3Kt8h8EDl3/HC1Gxei1MuhtxC42/QddNiODeM8Dbukn/GM8Apv69q07rSyFKQYUW7YBlVPG7jDQlxHoeUyY5JALOOWoioozB1djTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB8282.namprd11.prod.outlook.com (2603:10b6:806:269::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 09:26:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 09:26:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Cao, Junjie" <junjie.cao@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "philmd@linaro.org" <philmd@linaro.org>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "clement.mathieu--drif@bull.com"
 <clement.mathieu--drif@bull.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>
Subject: RE: [PATCH v4 0/2] intel_iommu: fix guest-triggerable assert in MMIO
 handlers
Thread-Topic: [PATCH v4 0/2] intel_iommu: fix guest-triggerable assert in MMIO
 handlers
Thread-Index: AQHc44kbK84KWxI6R0i3T4NSkJuvwLYZt39w
Date: Mon, 25 May 2026 09:26:02 +0000
Message-ID: <IA3PR11MB9136008119E08F717BF36E3B920A2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260514180703.85686-1-junjie.cao@intel.com>
In-Reply-To: <20260514180703.85686-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB8282:EE_
x-ms-office365-filtering-correlation-id: 29e9d0cc-e640-453a-5176-08deba3fa40c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|11063799006|22082099003|18002099003|56012099003|6133799003|38070700021;
x-microsoft-antispam-message-info: W4HnxlxK3+iXflshGnzpBS3ouxhgn0fCt/3knyJwIW5tUFdvtrUG4BrQL/qZyajyppbBnjCJO18l/wetjnN+pkjs9vhCvsFOObOAhbcoxL802RvXZyugHezyKHsSJKy8UW+1Tbv2IHryADagL+t6QiLXyTa+zR3ZVszpJcdORWzjLgVb5YCDUWDkfYQk30GDpfUB7UET8WvFa+ojXoQuS2klracFP5pYXutq+Xm7z1JeIL7MO+FNoJ2yMcYVEPy58/VyhJCQ3BTOa6/Pf98sFizmNj9XgVVdiah6kofqQ8gv9giFy3Xt9OOze8tnqGY82WrtzS2vT7D7J/CmOl0PLH+0qWJtUawxOAPYgCuWSXj611j1lxWe8bh4kpKRaeNqN5NN3mGSeW7kyD+DxMtdibg1sCvDujF8aR/V/9yLuprGjyomU2vpc2B1wYf6AcjQRK5sLz6NcLadzb5h8usqxmNptZGMVeziykEfq5FI6GunVmo4tQ4LdCh+NJ1KjfOuW747u3oyXIrLQvKNgOpFIW80sRnvDy+L5lhbasJXpbo9D2V2pdyOZOna0PEino5CuPoV64xHbVVDAUDvamTr+Zt4UBsHcYk5jCMrunZRmRykVvUR48721tOXLtWKpEJ9Sm1hM8tBxDKPoNDQRWwYafuYw9O1caoVbaxrQ3g9r6oxS5XJr/O6+ZopBwW0EYydpwiHUBkthMExbCDNP/67ii/TCtzlTWVAxqWbxHsgAieallpxLvPIB+U21Ax2uqDU
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(11063799006)(22082099003)(18002099003)(56012099003)(6133799003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FJuBnZj3IanmiRJEUIF7lVggWSnvv3S5xFAPBeF3bQPnpNrLom2QfMcgeMQH?=
 =?us-ascii?Q?FtLYnutWXBjCzisAXS2NYt0aV4Sui2u+He1hY4IFnX1SaTGY3RsrFZIldZ63?=
 =?us-ascii?Q?EHI5G6xtNaviqGWMTHZzR7GUnL49GSi6GKwibmXPN7j1PrulW01UK5nyLDBd?=
 =?us-ascii?Q?ews+2nipvCfZOb2tGWHAor2N14BbI8cNFy3JZ6M/Z/cLv2kfrkH9FDL4OHuL?=
 =?us-ascii?Q?2R6AKM1FHxt0qeafYjXQlQQeQ6eQzyaPjXlQ1tJG1/dbLTiihfUBx5jzZkvl?=
 =?us-ascii?Q?xupwck+ofvgknTuyhQbD7LjHPSSQFpGjnySLtfENvsaBQpHIEpBmsDoSmkvD?=
 =?us-ascii?Q?ZhwB+ybqRAQJGTDbzN0fLsyXaRoBgo/V9W0BLLMU9uxUAZaVx2cIL44fzmfJ?=
 =?us-ascii?Q?GnPWUCFsmzNsZNlAOwlwmSF+5n5RxjX5uFIV1P8a7pN5HQRDLDAJ5kIES+QZ?=
 =?us-ascii?Q?DPwzrXnbn4OTLcUGS0jK9FwNbky32ZMmguHTZbHPROLGDD77Y2yOVCcgKqHv?=
 =?us-ascii?Q?Nj1LPxQjKtr79AihFcSyBN6xRlarrIgWmVIiUbQ43g6ks24UqxVvP6/1wLey?=
 =?us-ascii?Q?tnq1GmnNvXm6qU1qgTWbLcF22cwOWeUzw1Ftn6kNlqjt5We1+Sf3oElaQigk?=
 =?us-ascii?Q?N2uW2Yu4CHsLXpGolb9ZcEOay6T4yF8UMlMCRDQCu79BOKfRe/XSyRJXKYIQ?=
 =?us-ascii?Q?E6QY74NAr5QrSl95b/zFaK6ZQfnJHpnN5N51OgVh60svd6JqdXKSYAZ/Cg9i?=
 =?us-ascii?Q?otpaHjDM8GOM6rrr86SFewTdUJxlh3daXukESK1gIhOeRaAjxPJoCLEM+icT?=
 =?us-ascii?Q?DVyWlJar1AVNitCwHAJ2hKB6rg5LT8DExtshFka0xuAZjfXDGOqrh3bK4kwy?=
 =?us-ascii?Q?PseOm7d7u9YBTpswgGfDvFdlRzIkHS1Xa47boIOTbiSYn1kX6FDQl5t5U8Dx?=
 =?us-ascii?Q?vGDyBN4ODf7ixHIcqgSPMnOV0ZG+KDQdpMm5OXZ66C/6PoU2biRDISh3pL8V?=
 =?us-ascii?Q?EGfwwvIH36xGSLueUg1FINCBrOsuVPTRyheXb7czM+L9xExJYbd3mSKV1J1/?=
 =?us-ascii?Q?1gpUAlyygdA7CztjAoH5jjBVkIGlhmhPwZRkQJs4yKO8HpZ3gwuyO17uuBl1?=
 =?us-ascii?Q?Yfhlm5kYDiN8njc+0B/TFNlbpA2OFVELeka8M4G0q/L9uvvc49pdtpHtU+SJ?=
 =?us-ascii?Q?Ezk+yIhLLTb7tRTQxX0EgQcN8+O/rJYYrAkRo6athdrNqiB92ncn2tBFmes2?=
 =?us-ascii?Q?/4zj1YshQH1w6WGVQ0n4sfGgEZCZ659Bb7aaL6FxukkEorPYfVR7g7jQVYgK?=
 =?us-ascii?Q?BSseMfh4HSsTGaRRByYjmVnKUVdtYs/R6tQWR4HMwCS+xaJHCWwtSXND+2q0?=
 =?us-ascii?Q?LyA6Zr8hGYu5cgUQfX0y1OrkubViVkk/eoSreKBCARM7giyvi/Y5YS1vMOAX?=
 =?us-ascii?Q?+pHwntkqyVc2DotI6i24W07vdf/OnZUm5sVEXBNESZFV3E7AWWxfCFubMK2w?=
 =?us-ascii?Q?sQJxVlffDvdz/85e7aaY+5QIlM1jje57LQ0d35W8vPTQF3496e7y9PAe3yhI?=
 =?us-ascii?Q?PKok3Nh4xPkl/49hmN4zUqNWxw2Ho7mjPPkCAuQwEBqlj/0l8GoDOXQLuj8X?=
 =?us-ascii?Q?VR6E5DSKFbmh4dq4XjA7Zblg0C8jJcPqfnMb7pqPS3Hv86PloT8jPtJmU8k5?=
 =?us-ascii?Q?qjJogUpQgAZ1PFsN8HDtnZZvDo8EGJiBUYOUnh51yMTOowFUFr0cjcaFbGJF?=
 =?us-ascii?Q?OnXkM3HYFg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ICq5cQvxKNZDrCxdOH7ab5UJb/0jpJsybVK+luVB4/8gKMrczDL44yiiyDeHB4Io0faFPsheynyJZla/L03AJv+IKJ705o5fYubr2uEVUprlmd1HBAQD6W3Zze0BXcJ/4XkG4bxQ3xzU4WC8VrkEcLKQUu+wCXTi9ijDS830rS2dE8j5rRbIgqyx1uqsdFjjwg1j3QjdAzXxmwqhaz+AHxX4vOaSiLRw2hAaqqT47B/8APREUw4FdNEDMG1my4nCqHBZiLoSQi0M9XUkceLPC1AO8r/gtY1p6iTxrWIJODA3e6ceFpq/nxr5WGCsq2aRyXH2Mf59sO/sKBsJa0J2+w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e9d0cc-e640-453a-5176-08deba3fa40c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 09:26:03.0001 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lft/Li0t5Ll0vLivOBTRcLIv+gZVdR+5G6VQzS0FCiGXs63JyUt+djoKIvvXnQCXOF7xDEqwLaM8sPCbKKD/jCbQ3ksWpqqWzM2kryP8RZo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8282
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Cao, Junjie <junjie.cao@intel.com>
>Subject: [PATCH v4 0/2] intel_iommu: fix guest-triggerable assert in MMIO
>handlers
>
>An 8-byte guest access to a 32-bit-only VT-d register hits
>assert(size =3D=3D 4) and aborts QEMU.  Found by generic-fuzz.
>
>v1: https://lore.kernel.org/all/20260420170523.17908-1-junjie.cao@intel.co=
m/
>v2: https://lore.kernel.org/all/20260424201842.176953-1-junjie.cao@intel.c=
om/
>v3: https://lore.kernel.org/all/20260506031942.251335-1-junjie.cao@intel.c=
om/
>
>Changes in v4:
>  - Switch the guest-error log from error_report_once() to
>    qemu_log_mask(LOG_GUEST_ERROR, ...) so it is surfaced only
>    under -d guest_errors (Zhenzhong).
>  - Add a block comment at each of the 4 reachable sites
>    (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0)
>    explaining why the check must stay, so future readers do
>    not delete it as "harmless" (Yi).
>  - No functional change beyond the logging-API swap.
>
>Changes in v3:
>  - Drop v2's min_access_size=3D8 approach: per Zhenzhong, it
>    silently zero-extends 4-byte guest writes, wiping upper
>    wmask bits of 64-bit registers and firing triggers gated
>    on size=3D=3D8.
>  - Keep min_access_size=3D4.  Remove the 25 assert(size =3D=3D 4)
>    sites: 21 are unreachable (non-8-aligned), the 4 reachable
>    (FECTL 0x38, IECTL 0xa0, IEADDR 0xa8, PECTL 0xe0) fall
>    through to vtd_set_long() and log a guest error.
>
>Junjie Cao (2):
>  intel_iommu: fix guest-triggerable abort on oversized MMIO access
>  tests/qtest: add 8-byte MMIO access sweep for intel-iommu
>
> hw/i386/intel_iommu.c          | 74 ++++++++++++++++++++++------------
> tests/qtest/intel-iommu-test.c | 30 ++++++++++++++
> 2 files changed, 79 insertions(+), 25 deletions(-)
>
>
>base-commit: 5e61afe211e82a9af15a8794a0bd29bb574e953b
>--
>2.43.0

For the whole series,

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

