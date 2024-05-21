Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 285B0C25B77
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 01:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9E1V-0001PC-9g; Mon, 20 May 2024 21:10:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1s9E1R-0001OU-Gd; Mon, 20 May 2024 21:10:33 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo1.xu@intel.com>)
 id 1s9E15-0001S3-MN; Mon, 20 May 2024 21:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1716253812; x=1747789812;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hC1xs/fJUInC9N4lyDOyF4zl4Ho32bHVgvLzr09zRu0=;
 b=nS5BlUqq5vV8+AEuoShea5JpQL0eVUe/TaJdtIHHawJlJbxR97J/LXjy
 aQ5bb7GKemRBApds1ZJ5TZQAIl/ULg8L5vH6zwknD3sXUnrx4/1Hz55PH
 S0jKaOX7BgGhlArCfbCWJ/p/qpqWkUnVMJfF5TcZW1NSFMBjK4S2PC8WT
 LP/7sB09UVlnyt0yM4QF22buxK6hvGxxWskUqczYiEjIxrHx0CluB1pnr
 WB6iHw/DGLJbqvJ+j2oxHWP/3ISgEJ+BYEDsVEeA0YDmhreShbg096lw/
 kiffVfKm0AJ76OAjr86pY25f2k2xLpZVC9jkimUZEPEG1iA1fI5jj/5PC g==;
X-CSE-ConnectionGUID: XUkeju7kSuGdnpplXZxasQ==
X-CSE-MsgGUID: 06wnO2bsT5+OQoLRNXLD7Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="12260209"
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; d="scan'208";a="12260209"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2024 18:10:06 -0700
X-CSE-ConnectionGUID: MgAZqmP7TxenqDhkAzrLWQ==
X-CSE-MsgGUID: oMgnynCbS6yy9ClRsKY7Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,176,1712646000"; d="scan'208";a="37110870"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 May 2024 18:10:05 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 18:10:04 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 20 May 2024 18:10:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 20 May 2024 18:10:04 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 20 May 2024 18:10:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gal/W8GQbucOT9MQHi7+Po4sm3JqpsdnM/G9RZ2vux//sD39jZZ7v9vZrUB01q6Q0URQwLqWKSvklyIV/3PxWLv7XRdywFYtVk1O5qM/XIpJ3YGMaEhX+QNtclfXZzcDzXTNWiWxSqoR169TuVDGzGhuzP40mSXbnZrZ1BxsGv07kCBN5cn3PRNED79BaqWXRYBRj4pqKsqx6jVH9ZGqBwgM9oMpv26FmakkevC/LZmE29ENBo8wiMv/K03ymXhVGxlLN1jmNNVY2lzjGq32AOxUiRUg7bqZ7o53gr1mf1zBQ+91xNGaOR7ci+PvHCLzttUfewTazblspwLttPy4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfqQCLKXIUgS+MJk8DUJWA0RI+M4JVHmfIabR+bCsEw=;
 b=Ly9rToh/q5bZlL+aYVQdyrFEdNBQeBfeeKCzHQgu3YvkHyzs7Xz0czr3Mht5t/xa43ZdvZqFPnFfEZYBu2at/phhzNueuaikVYZ+0holBiCWFXUUK+sweMU+kb0ZnJJt943dU5nhE6vOS1DgEMJGLGKJQD+4NOwWTGPtYQ84XIxSkmlc5ehiRXkKzD50xH7xB62umXpnxwZxvG05QQujH88QF/vbGTgrShgIMXo1LXS4KkDB+QJaJMOWgSJd/UaMulk4sF0NKw0pGNRqIgof1gClgOd3noDLIYUJGZAYh+CHs/dodWSiigO0N7TFoZSFhu2/TRjvbaT08XQd8lwrEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BY5PR11MB3909.namprd11.prod.outlook.com (2603:10b6:a03:191::13)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Tue, 21 May
 2024 01:10:01 +0000
Received: from BY5PR11MB3909.namprd11.prod.outlook.com
 ([fe80::366d:21d5:9005:4c55]) by BY5PR11MB3909.namprd11.prod.outlook.com
 ([fe80::366d:21d5:9005:4c55%5]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 01:10:00 +0000
From: "Xu, Haibo1" <haibo1.xu@intel.com>
To: "tech-server-soc@lists.riscv.org" <tech-server-soc@lists.riscv.org>, "Wu, 
 Fei2" <fei2.wu@intel.com>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "palmer@dabbelt.com"
 <palmer@dabbelt.com>, "alistair.francis@wdc.com" <alistair.francis@wdc.com>,
 "Meng, Bin" <bin.meng@windriver.com>, "liwei1518@gmail.com"
 <liwei1518@gmail.com>, "dbarboza@ventanamicro.com"
 <dbarboza@ventanamicro.com>, "zhiwei_liu@linux.alibaba.com"
 <zhiwei_liu@linux.alibaba.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "Warkentin, Andrei" <andrei.warkentin@intel.com>,
 "shaolin.xie@alibaba-inc.com" <shaolin.xie@alibaba-inc.com>,
 "ved@rivosinc.com" <ved@rivosinc.com>, "sunilvl@ventanamicro.com"
 <sunilvl@ventanamicro.com>, "Chai, Evan" <evan.chai@intel.com>, "Wang, Yin"
 <yin.wang@intel.com>, "tech-server-platform@lists.riscv.org"
 <tech-server-platform@lists.riscv.org>, "atishp@rivosinc.com"
 <atishp@rivosinc.com>, "conor@kernel.org" <conor@kernel.org>,
 "heinrich.schuchardt@canonical.com" <heinrich.schuchardt@canonical.com>,
 "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: RE: [RISC-V][tech-server-soc] [RFC v2 2/2] hw/riscv: Add server
 platform reference machine
Thread-Topic: [RISC-V][tech-server-soc] [RFC v2 2/2] hw/riscv: Add server
 platform reference machine
Thread-Index: AQHadISuugUdXQ7euk6fyEFHfjzSpbGgs3iAgACaN2A=
Date: Tue, 21 May 2024 01:10:00 +0000
Message-ID: <BY5PR11MB3909507A084A4D1ABB024D3FB0EA2@BY5PR11MB3909.namprd11.prod.outlook.com>
References: <20240312135222.3187945-1-fei2.wu@intel.com>
 <20240312135222.3187945-3-fei2.wu@intel.com>
 <20240520-2ca42f1c1d9a9c65f5474529@orel>
In-Reply-To: <20240520-2ca42f1c1d9a9c65f5474529@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR11MB3909:EE_|SA1PR11MB6990:EE_
x-ms-office365-filtering-correlation-id: 7a512ada-a39e-4c44-847b-08dc7932bcf0
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|1800799015|376005|7416005|366007|38070700009; 
x-microsoft-antispam-message-info: =?us-ascii?Q?2V1v19hzr45FXACMPxRKS+/kRFS7PisGxDwa2SX6/dc9Qn1LjjPg3rSsAcMj?=
 =?us-ascii?Q?dVDsGD06yj+Sqv5b/aIee9bgW32aLlZQ3sRuepv5E6rRCAz/pxlK2UjJg0Vu?=
 =?us-ascii?Q?qVOrF0EOiRgRc/dl+N1rdhngqiLMYZREmPwIFJl+mBesLeXn/tG8DAEYfKx+?=
 =?us-ascii?Q?FUS57MuC4YK56vaWQb36qIm2Xxw2UzYyHFA5X3h8Xk1pBJDyKF0RLASosJie?=
 =?us-ascii?Q?xPai4F0gKkcxLiVpoTJzPQxQ+2GVtk57hgARGxvMzQamnjxvbEg63hSPxsgt?=
 =?us-ascii?Q?joQ+Jj0OHyUp3FriFpxR6jWcJ66kYZGiqB+Cpca0CnD8zSPoZNVi+GwbIMqG?=
 =?us-ascii?Q?EcZB0ir6dNuXS6NLUNhZPscZoZxGyv3dy4QvpSNiVWMPdj/hICiqNQXErTVV?=
 =?us-ascii?Q?NXGDpChlMOG5AHdytQEvTjw2BZk5mCQLf3EBaia2EE1nS9fOF6KdH8c8baR2?=
 =?us-ascii?Q?8xLinL/ezX/mckhxV9CYgMircURBMHRgNaISyNxr2Oz5TTMJ8eeHyoSuijcB?=
 =?us-ascii?Q?tptbClBPDBgoUVPdDRpPvchAmhPAA3cyed9I1SSZn/I3+CfJJ+iFTMQhhq9p?=
 =?us-ascii?Q?UEYFy+xiXo77IndoBCm8FFrCG/vqgqi+TrlKHg1Ic55Edd+pgMI+8yzpY3eJ?=
 =?us-ascii?Q?GZ8BEvgq9RGpwCq9BUGRaES/Yd+yIFxRS6/+3D3WZhAv1fZv/GDocF7yZBW1?=
 =?us-ascii?Q?EA+OMLWOQavi+nwGge52lMuDDhkLU4IajbIRFxbsGHuijirzGP2ZpA4daF3v?=
 =?us-ascii?Q?GUrx59Wq1Sm9OJW1a3T1whJjxn6g4WKaMc3XPzhMvEcHOnT0lV4pKd2dPV+T?=
 =?us-ascii?Q?pn0PlzHpAoh34srzwUjkRC1MsbP6rTTXpxNC+HtLMH5tVKfTtOiZrUCMnfNG?=
 =?us-ascii?Q?YKlx4zAEr5Ij/Kn88q83SnHAi/L91H9kIhQJDRDvFk6GHVSne11mo/94UHv8?=
 =?us-ascii?Q?FM9obohA8NBtDgqfMxRlDADZ3TxpPWcQ/FJm2Nc8vFnmhKdeQaBf8nekWppf?=
 =?us-ascii?Q?iIqojdwS+tohVdlzX/kht4Pi83eZiOHlEzEnoBgrykgVRG24ePa07eCmvt8x?=
 =?us-ascii?Q?nXKri0nozIZDOresY3H6MNCHwoOpijvedDHpAI+QYSir2aHT1JOOcpTfOD6A?=
 =?us-ascii?Q?XOAHHgKMdhT4HtBv2GhrR0U8dGcwC35yOd1694yrgbxQywWz9ofkvEptLScu?=
 =?us-ascii?Q?4qDfg8P2kS9imrHnRJQPQcpizNth7xZOg5Jg3IxYKYiapBoJLBZv/chc91+s?=
 =?us-ascii?Q?9zufEEPvjFPQs1QCpolskD8PWvCfyy5wjBuQD64l3BV8PdksV8RoHZgF1ccU?=
 =?us-ascii?Q?SC4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3909.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yrVrCx24oNqcOLTmU41kuc/QyhmV2fIFOxtcoI2EH+Jb26VOYl4zQ4Dx94XZ?=
 =?us-ascii?Q?efbMPNl03O3DnSJJ22WLJ3qtgDYCkU8xE1xkI2ND3WpzUg7yz+HFk7B4D1o/?=
 =?us-ascii?Q?bVAUPBFd8kdOHazqAudPdl7lpkidthk5ByWV0EB9E0CpE+Dl70h7rGD6oWiw?=
 =?us-ascii?Q?KFLWN7wnLusyKAEXI/AjjRDq4LfA9V7J37FsQSZCwCSPH9RR7QX4opCiZ44O?=
 =?us-ascii?Q?Xx+DsRJwmHRd6PPXvvZsDV+vAXtXVMVsubtVBLJV6KwKTpJ8Ls3k2EPRa2e3?=
 =?us-ascii?Q?vf8q1JCZHNlXft1KM0ijEqyFnlVi9VuLThP7iY50FaoMdP4GyR9YYrI9qj3f?=
 =?us-ascii?Q?w9z8fnkb9osxdGipYHJMbMgdJljIeV7N/rXWA443+p7Q7wLeLs7jy5obwT7T?=
 =?us-ascii?Q?aG8vZgLeVGQKRkv0gMaHQphN9KYTNh1vB+EHwcW583zD9E9fIPIENTKSvzkx?=
 =?us-ascii?Q?T5EZY/xBxLYgcj9VvhEF7jK+n3ruH5CQHtAlE25DIRqW/fVvSROUxHh8XaIe?=
 =?us-ascii?Q?T7o4X0rCtaUCH7eoDfx9Ohtj9x7OxKe2pwyxHcz24aZ8PKFBPk3nNqA1NC4L?=
 =?us-ascii?Q?O8jZfi9a4GvBO8gZULIDDQoqZID7taGKVfXsVbPQEUdyGwGYBxLtw3AZyy90?=
 =?us-ascii?Q?HBFHJQI4+lzuou4aXot8uV21uQ9wSdMDkl83d92gTMezJgn+0XoY43ARM7Tw?=
 =?us-ascii?Q?fufSMIc394nm5qH5YAv27WLBG4OQWR2HaU7hs8ay11T5M7+S8qJaKRU1Ihf1?=
 =?us-ascii?Q?dSj0S7+2/vRvG0qCUg0YS2vfVsWc4kCzfr4H78dmDciVKhoFNZrpV7KOkDQP?=
 =?us-ascii?Q?d7jLdwSRzx23gajt2TqixiDNOwJkbJa42vJuTSlORO/SOAYttDwBoOrBkDCZ?=
 =?us-ascii?Q?YDJDwecUY1dYuNwIFhtyTnoFcF+zrcK1Tm7uT7kP5jO9mArO6/sLwW/rEJno?=
 =?us-ascii?Q?8PBqjPxRnOkqMeSohKSHbEMHCnmKgrJCPs/8paGImy985npHbJUzCRbVHdla?=
 =?us-ascii?Q?+WD4ND61m2E4E18tNNZrmRr8nCEvbxjmEo4PtdM8YxJ6eutqfA/yaUmA7eDg?=
 =?us-ascii?Q?HUSqSC6Yw6sofBZWZS6fFBv2ObPY2cgq4VgwnuGcTpEYrgWAn1+ydZGipznS?=
 =?us-ascii?Q?oAnt7DjD3oJbVeK7Y/BLWnDS2wg2MoJP4EMz+wdWpMD7CxpzMSP0yaVBwQDV?=
 =?us-ascii?Q?2XPXSBGPEDpzhjuVNy71dqOb3INTz59AAXbvLzkuT28YkskNB2trS2+YF2Sd?=
 =?us-ascii?Q?LjbKFeeJAI8wI1fELgHV80NpDi5Og241mx/4tBO9cry4CYzqJB3snzzaTQ8i?=
 =?us-ascii?Q?ze4qFh1MXaRIPrr52ZBX5d8RkMR/oRR+Y4kyV2LHw+yUA/rl1qjimVFGBTgJ?=
 =?us-ascii?Q?xn91KoiWEyTQHitJGv4XNZ8FopyGuY1nywzYUXwXfI1W5wPxxH7j5R6OmviL?=
 =?us-ascii?Q?hFbSm35Effe4JuaR+eJRQMa0L6L0WafQAUIfyjDyB9mN0KVeIUd7hZClo7hM?=
 =?us-ascii?Q?DAgS6ky/C5wo41oq1cBX8wcze7QKxDr25P/VDE4gmZR+HFDGnX0lm7LCqReS?=
 =?us-ascii?Q?uVFT8Zy9y4XMP/4YCMapdKxmjPH0CpZ7YUo0VOJn?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3909.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a512ada-a39e-4c44-847b-08dc7932bcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 01:10:00.4446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mXTkFCDlMCJAOTWnWuhJ5ngwR9xqHFZjLbgZ8snu1l6ZKMV5mvMiwh4vx+GyBVeRa2MrfzH/ICynlZc6L/u1mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=haibo1.xu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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

> -----Original Message-----
> From: tech-server-soc@lists.riscv.org <tech-server-soc@lists.riscv.org> O=
n
> Behalf Of Andrew Jones
> Sent: Monday, May 20, 2024 11:56 PM
> To: Wu, Fei2 <fei2.wu@intel.com>
> Cc: pbonzini@redhat.com; palmer@dabbelt.com; alistair.francis@wdc.com;
> Meng, Bin <bin.meng@windriver.com>; liwei1518@gmail.com;
> dbarboza@ventanamicro.com; zhiwei_liu@linux.alibaba.com; qemu-
> devel@nongnu.org; qemu-riscv@nongnu.org; Warkentin, Andrei
> <andrei.warkentin@intel.com>; shaolin.xie@alibaba-inc.com;
> ved@rivosinc.com; sunilvl@ventanamicro.com; Xu, Haibo1
> <haibo1.xu@intel.com>; Chai, Evan <evan.chai@intel.com>; Wang, Yin
> <yin.wang@intel.com>; tech-server-platform@lists.riscv.org; tech-server-
> soc@lists.riscv.org; atishp@rivosinc.com; conor@kernel.org;
> heinrich.schuchardt@canonical.com; marcin.juszkiewicz@linaro.org
> Subject: Re: [RISC-V][tech-server-soc] [RFC v2 2/2] hw/riscv: Add server =
platform
> reference machine
>=20
> On Tue, Mar 12, 2024 at 09:52:21PM GMT, Fei Wu wrote:
> > The RISC-V Server Platform specification[1] defines a standardized set
> > of hardware and software capabilities, that portable system software,
> > such as OS and hypervisors can rely on being present in a RISC-V
> > server platform.
> >
> > A corresponding Qemu RISC-V server platform reference (rvsp-ref for
> > short) machine type is added to provide a environment for firmware/OS
> > development and testing. The main features included in rvsp-ref are:
> >
> >  - Based on riscv virt machine type
> >  - A new memory map as close as virt machine as possible
> >  - A new virt CPU type rvsp-ref-cpu for server platform compliance
> >  - AIA
> >  - PCIe AHCI
> >  - PCIe NIC
>=20
> We should rebase on the IOMMU series [1] and add an IOMMU to the platform=
,
> as it's required by the Server Soc spec (which is required by the server =
platform
> spec).
>=20
> [1] https://lore.kernel.org/qemu-devel/20240307160319.675044-1-
> dbarboza@ventanamicro.com/
>=20
=20
Good point! Then we can also include the IOMMU driver in Linux for integrat=
ion test.

> Thanks,
> drew
>=20
>=20
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
> Links: You receive all messages sent to this group.
> View/Reply Online (#171): https://lists.riscv.org/g/tech-server-soc/messa=
ge/171
> Mute This Topic: https://lists.riscv.org/mt/104884663/7216082
> Group Owner: tech-server-soc+owner@lists.riscv.org
> Unsubscribe: https://lists.riscv.org/g/tech-server-
> soc/leave/12613148/7216082/2077856617/xyzzy [haibo1.xu@intel.com]
> -=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
>=20


