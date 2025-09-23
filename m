Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040E8CAC5A7
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 02:48:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0t4G-0004cD-SX; Mon, 22 Sep 2025 22:47:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0t4D-0004aw-UE
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:47:47 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0t47-0004bJ-1h
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 22:47:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758595659; x=1790131659;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=JFa4EHihBEJtstkixH1ISLgKqETgjtgM1jtmBFUnLY8=;
 b=kfw956uCHb2ExIBh5f/1oTA2YAtjEWFvLyTQBowovnfAAZAwd4KOUtR0
 ZXYC3cAGS1Gczbgp+m/ii5rz+3L+4McoLlr43PzMvrmoPeBBn714RRaof
 oNlOka76tg0vubGssG84ZaGE4qE86gnWeQULhJJb6/YiOpD+Ra6i5vlL1
 mvHlgdX4l6+ouQTtMIbJII3s9eNUmESPJ+L3RQo1Ub2TUGCtgxO7LTcsn
 CFqbIn1/pZgyO1wpkBxX/YvYMTodDbj5VEJqf2g2iDJ/Iay1wFI5DuBP0
 GFOvMuiLBRdBEcySv1QSk88pSnu9ksHMNPB6E5XWFAKdBi4RS767dVeCM Q==;
X-CSE-ConnectionGUID: gTFlHRJVRyCoa2Iyop54mQ==
X-CSE-MsgGUID: jKODYR61QyCke6A5ZnDhIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71542582"
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; d="scan'208";a="71542582"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 19:47:33 -0700
X-CSE-ConnectionGUID: CH7+KvTzSI2fNjjf/baBFw==
X-CSE-MsgGUID: 8f6ZHUICRiehBSQmNEPvmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,286,1751266800"; d="scan'208";a="176701994"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Sep 2025 19:47:32 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 19:47:31 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 22 Sep 2025 19:47:31 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 22 Sep 2025 19:47:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARDVvXs/qrFueSAf/erVMRR34NL9Qkjd7QYDL7U2RuWjZjDqgKnVJmgP323g9O9RfI3YGBJUxcHVXregNdf/BKKC9VU+2f2dQVsQUixJr+sd+uPe7Sc1XL7vhhh0e7UpyScecwcfQESYvYDkBmw3xzr2TeTkm65r3hydDGczNfp9TBQqmmVXDWQDnRYU631sUOcvrJCEhT+504RDUWv7kgt8CrZLkoHznu6K6g2rYLWNcNnQSleyuYn+IznHEq+SLVB1zoZ+qvyBzBIbGquzLqfReYGjJVT/OmYAxupMbZV9d45FKfF3tOFxwhCZni36Cw0VDiAAadL1BxIB6qvCkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHqvSA9F0fuNGKgFYZB+Y7TNdDvHJeqVMPoI1X6Syo8=;
 b=zHj37KK9j3FIV64OXY5ai9h6Fo1btubmvvBTgA7dxawpJK3CHxeMTtQaZKD0x/FJAQrW8uT8A6nzkE7jYUHKOZ8tTXYgyC8my/dO+QOyGYKZFpNXs2/+EHQbMc/wYqDbYztmV9cO9NNLGzV/kVBEqaPSeo9+Sos5cfq/LlJ35tvbNLMEO/T96f9cacGgry7lszzyYlTFPhCcVayW5cpLtqaB78GtSG0pRPGd2xre2Hh/8xYwGDRwy737zaiBalbq/oQ7ckisX48T/YcNN0Pll60xmsF2Andmp/FU5DbbyjgCZX7zy0SazCCMdeCK72+cWwCgBUh02G1GHQM/Xl8HYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH3PPF23335A1E7.namprd11.prod.outlook.com (2603:10b6:518:1::d0e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Tue, 23 Sep
 2025 02:47:25 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Tue, 23 Sep 2025
 02:47:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, Joao Martins
 <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "avihaih@nvidia.com"
 <avihaih@nvidia.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, 
 "Van De Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Topic: [PATCH 3/5] vfio/iommufd: Add
 IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
Thread-Index: AQHcIfvtcDcAUY1arESRh5H1VPguD7SaXCYAgAQ5VOCAANsXgIAAsyBA
Date: Tue, 23 Sep 2025 02:47:25 +0000
Message-ID: <IA3PR11MB9136AC6054BC33CE1DC716BE921DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-4-zhenzhong.duan@intel.com>
 <d167b62a-be06-4bb1-b88e-e1cc96d7c4a4@oracle.com>
 <IA3PR11MB9136B9DA08CC2A48E1678DED9212A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
In-Reply-To: <ac9e71a9-972d-4fba-a0f1-9823ae6664cb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH3PPF23335A1E7:EE_
x-ms-office365-filtering-correlation-id: bef28104-ba07-4efe-f61d-08ddfa4b875d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0QHpEAKT7X9/eXOKKqa8rki8vMdExc1n8AL6dBapZkK0K/lUlx4rCodmuN?=
 =?iso-8859-1?Q?aOR9W5V9yY+qK+2ksoVqzQ9e+JuiYlXsvHVgGHE6BdZ5M+mAVAFX1I2QRX?=
 =?iso-8859-1?Q?9lGmBRZhKPe+lPP7qFI92DNJgJ9n/SvwxEiJy+wJ8Qm6/ESba+9eXb76OW?=
 =?iso-8859-1?Q?iVmJvvnciw+y9wGWRp2Jd7BXGL+LVYzBZzJmQJYAIzeAfWmUzUttELL/xI?=
 =?iso-8859-1?Q?T7mor1gH1235F9aoMS90cs6hucdlU63Lw849oPUwSJBYOevhCzh0DdZ5op?=
 =?iso-8859-1?Q?w0j8vXcAat/0xOd4QvnRGW5v1CC/qsc5wYGCLlIcfsfE0flz4xCGqRdT2K?=
 =?iso-8859-1?Q?e8LAdiEB/j57h0oBy14zEAg8MZ85p3ocQNrHEmAwJQktdMwqBqfie1jsW3?=
 =?iso-8859-1?Q?dV0BZKD386pG1wrWUjbkjlHUZyPB7e8f7jIfJv7lFU4Cw6k9sI5H2X4NH7?=
 =?iso-8859-1?Q?pu6mnNY27pVe5XxB+oi31nkMW0eqHCAsqEQOHNPf43MuhEJc4IMsRVU5Yy?=
 =?iso-8859-1?Q?x1mHJLkxfmm32gN/0MmF32hK7S1EOl3ouRoCZ1WRP7Xenl7W7TLpCKw3mR?=
 =?iso-8859-1?Q?VvUA0R2cSTHqoO48MLQsuh2LsC0J03OeCgz3CYWmud2zaLR+4b/xM38aaI?=
 =?iso-8859-1?Q?a+n1QQLYzVin2eJK8rz2+jRJSXhBhB9rR4Y9F5O9V4PFN6895O/TxidkvM?=
 =?iso-8859-1?Q?HuEQW+UO42QVheXsYC2pbjS7Kv4IPnvGfBQlDn2UQeEX604KWNPp8MsXTz?=
 =?iso-8859-1?Q?M0g+bxqbnEfr5n90TmCkyeMtbWrThvugc/IWXvZc42m5ek6kFxq2x3hUq3?=
 =?iso-8859-1?Q?ucdmpTnoozucano4KCnT1kLLT4aA+c7jLvoH7z5MMTxTPhQgNI99ZNVAWd?=
 =?iso-8859-1?Q?RloIqIPWECQlZzIbsXhikoGBWjyBuFRcTXPNjxgG6621+L3jl98FXzwA6i?=
 =?iso-8859-1?Q?xNAKyQuP1lAUjSFH4zSTlCSm4M54wg9e7z88ErklSHjZkod0XlgUGckoMz?=
 =?iso-8859-1?Q?KoZBT25FAelrwlwNg/OEXazOK2WDz/PohRTME7TzhLA1UbqB5GSvSXbl7m?=
 =?iso-8859-1?Q?owbnABlefv3DIyary6xs+8qBdXnYzuA9mpuaxZDIirIAvb6GqVmAmw4rNR?=
 =?iso-8859-1?Q?TIB+7sY1VZC0lDdywdHVA6NK/eAZ1T44otqnn5kt/M37EL2tC9DFBsWy5O?=
 =?iso-8859-1?Q?SFLqN4EIe+wVwge25EEN27OMgwSU/j7MhSpp20s9FNibjYaPB7tn6XG+nV?=
 =?iso-8859-1?Q?T5/zuwmPLcGVcivJskCaSkIT+80RZPYaE00Q6RhprUEcCCquC7lMumNpFa?=
 =?iso-8859-1?Q?JQ3fb5bDjrlZgkDxmHanR1pAiESlnfOS93OWmD9GBVV0kv/W84f6CHdtNS?=
 =?iso-8859-1?Q?IM/7Z9bAmeuVfZVhhcWm0rFI11FQdLhu954/EJ2eCfOFPTCdjHc/hffqdd?=
 =?iso-8859-1?Q?tRlewkvwep7b+hIZS79/I1gIwfYt6QjRa25CN2BpUr5ayWeif0z8+7jdZM?=
 =?iso-8859-1?Q?BfAdZHHd7s/o773DiZrdrULzisVv3S6CuoFpmjBuSWnSmzPSqpI7P4Gwyb?=
 =?iso-8859-1?Q?0F6Om3o=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?skfQ+uGLYk8U8Pxm0oi1d8+pcyB7yy/DNvXalPi388WVykP889Lb9a8ymJ?=
 =?iso-8859-1?Q?ZAImH3K2PivOzg8Kr74Ltl9vbCrJVHufAGshlumIvikeQX8zDK+rNMD7Dp?=
 =?iso-8859-1?Q?aEkauPmIGs83TinlQqEaICAAyoJq2BeQHVq1lB6IATu/K98/46+YIwuzxR?=
 =?iso-8859-1?Q?oME/MC40q9JCET2i+ZyXCV8r2pNELp5K8Gpb+YMW61aVRlHZ2VHGNV8xRF?=
 =?iso-8859-1?Q?xtXWIVBzEe6TA2HanNYxx6aMAVq6By259TeufH8wBb69gdIObykXvcJa2i?=
 =?iso-8859-1?Q?1H/g3eqDrBzt11rZPrKAs44gW8UdyrUluG2EaT44wN+5WMrsW2QOoeoXfE?=
 =?iso-8859-1?Q?x8Plu5xbNdb3WCnRP+Ae/vSVoxdtaQw2nR0u2HN3JSHVZZ4yIKbCrH7VrC?=
 =?iso-8859-1?Q?je/CwtbAN3E1/1IEDlXd4cUKuuDyfrKPX0TRdt78+ga707E6fLT9cktVwB?=
 =?iso-8859-1?Q?K5Z3oOz38hDBZ7OO1IHfjMN7JJilXI+aSWNaYXn+wjlyZOrMqxP27trDov?=
 =?iso-8859-1?Q?nmik/PpZCAFmxMQbJ3EmTvM9iIIc7GoE2FpdgkyV+SpOECRpFoYzUL5bai?=
 =?iso-8859-1?Q?/c0Ch3z6XEdbgrv/IC/SygRXHnJCjY/bVbvHEvEh1B238nGA144iANBner?=
 =?iso-8859-1?Q?bbE64d/Kl3TMcWf3GnWWxTXZtkZBM95b5NVL3K0ytDKtUXOoPnCqigVqwC?=
 =?iso-8859-1?Q?IwLl88GCvREL+drcV+H8TKLxQ5Pck2NyY0/+Xph/DzbdLF69etD557atAS?=
 =?iso-8859-1?Q?MA45qh2fl+FBrv3QdlOOiIgU3eu7Gz1mv99VVxEP0Ca+nPNQ0ABXxkMiyZ?=
 =?iso-8859-1?Q?u/vA+FmR0iBhQpikEexhKPJEkVy54sVay+Pgu0LxoV0Zx13EQbOpokWm9N?=
 =?iso-8859-1?Q?QU39Hd8X3IuFlLL+KYAitlNL+vRIe4qkcBX2iW4pxmp1A0ea3UOE+zSmg3?=
 =?iso-8859-1?Q?zorzUHYWNHO1z7NitH0/zfhj15lqNQ/Kq1BdwYR540KIn8Aml+YGfjmLSO?=
 =?iso-8859-1?Q?WB81fCpm5zmQQD2lx7718CLFi5XELXcygDwlcf9jo5EYN3pAmxrBCNfcop?=
 =?iso-8859-1?Q?cXgo0NByuSnokgh1v7XUSrbXLLasVF8SP5KC2fGe+hr2r4DBOpCaAVGn9j?=
 =?iso-8859-1?Q?JG/mCfmeafpSlvv8Wx4m1QzJBIBugB3ALYyqX7LJJnQgKW1clbI28j6BaF?=
 =?iso-8859-1?Q?rVIJBQjT8T0F2sCamDpmq1QZLIJM/WUr2eKua1oqbObiPL5NqPQweURtLD?=
 =?iso-8859-1?Q?WcgYUQclsSnHnCIAAM1SqiC7fvhBCAYkH0UCvWE2Lm0M2fmV/tWTdIOuF9?=
 =?iso-8859-1?Q?jujim6lp9OAO2ngnOF6Nyw0n6+n0fJQBySk1OP0PMaYh7qDui3xGlgw7Vs?=
 =?iso-8859-1?Q?vg+uhqQLjxrdr9YPBBosOtPOwfBPsAavfasQUkq18Bunn/5hcvVteNzLEy?=
 =?iso-8859-1?Q?m3W0kV6BUTT2oCvmQf/s7vvw6rVi5FR+Qsre4tA+a/FGIF7GQpLZvcpaEm?=
 =?iso-8859-1?Q?Ov1GAVoeI+vtSK/sAuTh6/AQzH9+VwKhARxjjwFUF8lK7pbKd5kCRTiWEW?=
 =?iso-8859-1?Q?OBL/gqJlykPhU/1rSWLBL8HufWvUoIyT0Tqv2iduzkuk0S4fvghXvc/OK+?=
 =?iso-8859-1?Q?8qfIatS5NS6S1fZ04E15lxZpQ5yYCITgT7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bef28104-ba07-4efe-f61d-08ddfa4b875d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2025 02:47:25.6509 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vXhuo+RsQ0saEr/huZKKQmLh2gwYPuzn1noKCh6tzWHFlTdTCCBbGNP14F1ihqba6tPwA7MJRnIUrD0YqiZ82+MZHCNy61MSLchXqj2reUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF23335A1E7
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>
>On 9/22/25 07:49, Duan, Zhenzhong wrote:
>> Hi Joao,
>>
>>> -----Original Message-----
>>> From: Joao Martins <joao.m.martins@oracle.com>
>>> Subject: Re: [PATCH 3/5] vfio/iommufd: Add
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR flag support
>>>
>>> On 10/09/2025 03:36, Zhenzhong Duan wrote:
>>>> Pass IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR when doing the
>last
>>> dirty
>>>> bitmap query right before unmap, no PTEs flushes. This accelerates the
>>>> query without issue because unmap will tear down the mapping anyway.
>>>>
>>>> Add a new element dirty_tracking_flags in VFIOIOMMUFDContainer to
>>>> be used for the flags of iommufd dirty tracking. Currently it is
>>>> set to either IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR or 0 based
>on
>>>> the scenario.
>>>>
>>>> Co-developed-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>>>> Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>>>> ---
>>>>   hw/vfio/vfio-iommufd.h   | 1 +
>>>>   include/system/iommufd.h | 2 +-
>>>>   backends/iommufd.c       | 5 +++--
>>>>   hw/vfio/iommufd.c        | 6 +++++-
>>>>   backends/trace-events    | 2 +-
>>>>   5 files changed, 11 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/vfio-iommufd.h b/hw/vfio/vfio-iommufd.h
>>>> index 07ea0f4304..e0af241c75 100644
>>>> --- a/hw/vfio/vfio-iommufd.h
>>>> +++ b/hw/vfio/vfio-iommufd.h
>>>> @@ -26,6 +26,7 @@ typedef struct VFIOIOMMUFDContainer {
>>>>       VFIOContainerBase bcontainer;
>>>>       IOMMUFDBackend *be;
>>>>       uint32_t ioas_id;
>>>> +    uint64_t dirty_tracking_flags;
>>>>       QLIST_HEAD(, VFIOIOASHwpt) hwpt_list;
>>>>   } VFIOIOMMUFDContainer;
>>>>
>>>> diff --git a/include/system/iommufd.h b/include/system/iommufd.h
>>>> index c9c72ffc45..63898e7b0d 100644
>>>> --- a/include/system/iommufd.h
>>>> +++ b/include/system/iommufd.h
>>>> @@ -64,7 +64,7 @@ bool
>>> iommufd_backend_set_dirty_tracking(IOMMUFDBackend *be, uint32_t
>>> hwpt_id,
>>>>   bool iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>> uint32_t hwpt_id,
>>>>                                         uint64_t iova,
>ram_addr_t
>>> size,
>>>>                                         uint64_t page_size,
>>> uint64_t *data,
>>>> -                                      Error **errp);
>>>> +                                      uint64_t flags, Error
>>> **errp);
>>>>   bool iommufd_backend_invalidate_cache(IOMMUFDBackend *be,
>>> uint32_t id,
>>>>                                         uint32_t data_type,
>>> uint32_t entry_len,
>>>>                                         uint32_t *entry_num,
>void
>>> *data,
>>>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>>>> index 2a33c7ab0b..3c4f6157e2 100644
>>>> --- a/backends/iommufd.c
>>>> +++ b/backends/iommufd.c
>>>> @@ -361,7 +361,7 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>                                         uint32_t hwpt_id,
>>>>                                         uint64_t iova,
>ram_addr_t
>>> size,
>>>>                                         uint64_t page_size,
>>> uint64_t *data,
>>>> -                                      Error **errp)
>>>> +                                      uint64_t flags, Error
>**errp)
>>>>   {
>>>>       int ret;
>>>>       struct iommu_hwpt_get_dirty_bitmap get_dirty_bitmap =3D {
>>>> @@ -371,11 +371,12 @@ bool
>>> iommufd_backend_get_dirty_bitmap(IOMMUFDBackend *be,
>>>>           .length =3D size,
>>>>           .page_size =3D page_size,
>>>>           .data =3D (uintptr_t)data,
>>>> +        .flags =3D flags,
>>>>       };
>>>>
>>>>       ret =3D ioctl(be->fd, IOMMU_HWPT_GET_DIRTY_BITMAP,
>>> &get_dirty_bitmap);
>>>>       trace_iommufd_backend_get_dirty_bitmap(be->fd, hwpt_id,
>iova,
>>> size,
>>>> -                                           page_size, ret ?
>errno :
>>> 0);
>>>> +                                           flags, page_size,
>ret ?
>>> errno : 0);
>>>>       if (ret) {
>>>>           error_setg_errno(errp, errno,
>>>>                            "IOMMU_HWPT_GET_DIRTY_BITMAP
>>> (iova: 0x%"HWADDR_PRIx
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index 0057488ce9..c897aa6b17 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -62,7 +62,7 @@ static int iommufd_cdev_unmap_one(const
>>> VFIOContainerBase *bcontainer,
>>>>                                     hwaddr iova, ram_addr_t
>size,
>>>>                                     IOMMUTLBEntry *iotlb)
>>>>   {
>>>> -    const VFIOIOMMUFDContainer *container =3D
>>>> +    VFIOIOMMUFDContainer *container =3D
>>>>           container_of(bcontainer, VFIOIOMMUFDContainer,
>>> bcontainer);
>>>>       bool need_dirty_sync =3D false;
>>>>       Error *local_err =3D NULL;
>>>> @@ -73,9 +73,12 @@ static int iommufd_cdev_unmap_one(const
>>> VFIOContainerBase *bcontainer,
>>>>       if (iotlb && vfio_container_dirty_tracking_is_started(bcontainer=
))
>{
>>>>           if
>>> (!vfio_container_devices_dirty_tracking_is_supported(bcontainer) &&
>>>>               bcontainer->dirty_pages_supported) {
>>>> +            container->dirty_tracking_flags =3D
>>>> +
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR;
>>>>               ret =3D vfio_container_query_dirty_bitmap(bcontainer,
>iova,
>>> size,
>>>>
>>> iotlb->translated_addr,
>>>>
>>> &local_err);
>>>> +            container->dirty_tracking_flags =3D 0;
>>>
>>> Why not changing vfio_container_query_dirty_bitmap to pass a flags too,
>like
>>> the
>>> original patches? This is a little unnecssary odd style to pass a flag =
via
>>> container structure rather and then clearing.
>>
>> Just want to be simpler, original patch introduced a new parameter to
>almost all
>> variants of *_query_dirty_bitmap() while the flags parameter is only use=
d by
>> IOMMUFD backend when doing unmap_bitmap. Currently we already have
>three
>> backends, legacy VFIO, IOMMUFD and VFIO-user, only IOMMUFD need the
>flag.
>>
>> I take container->dirty_tracking_flags as a notification mechanism, so s=
et it
>before
>> vfio_container_query_dirty_bitmap() and clear it thereafter. Maybe clear=
ing
>it in
>> iommufd_query_dirty_bitmap() is easier to be acceptable?
>>
>>>
>>> Part of the reason the original series had a VFIO_GET_DIRTY_NO_FLUSH
>for
>>> generic
>>> container abstraction was to not mix IOMMUFD UAPI specifics into base
>>> container
>>> API. Then in getting a VFIO_GET_DIRTY_NO_FLUSH, then type1 backend
>>> could just
>>> ignore the flag, while IOMMUFD translates it to
>>> IOMMU_HWPT_GET_DIRTY_BITMAP_NO_CLEAR
>>
>> I did port original patch
>https://github.com/yiliu1765/qemu/commit/99f83595d79d2e4170c9e456cf1
>a7b9521bd4f80
>> But it looks complex to have 'flags' parameter everywhere.
>I think I would prefer like Joao to avoid caching information if possible
>but I haven't check closely the mess it would introduce in the code. Let
>me check.

OK, waiting for your finial decision, I'm not that eager on a simpler chang=
e,
I can cherry-pick Joao's change if you prefer it.

Thanks
Zhenzhong

