Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C451CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urAKO-0004yA-J4; Wed, 27 Aug 2025 03:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urAKL-0004x1-QU
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:12:13 -0400
Received: from mgamail.intel.com ([192.198.163.8])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1urAKE-0003fH-G5
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756278726; x=1787814726;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qYiJHrZD+kYmT8WwS8LfsLKDg+4EqXDYCuXjy2f8VNY=;
 b=YMZAf1fP8vLTaM90KB1uTbiuAF+o8MGYm8jZwCnr70nlymmVBYyZ/oys
 w5FwKcdOzSXKZglU5+aPu5+cDyGMlPydeFniU/Sr5hBDVmpm5gyV6Wi2S
 CXutOjb4SvLvxtiHxNKaK6zh+4wU0jbXJWoYlOAgQnGz5drmfA8+CJV9A
 fSIblrimUcUVQAG9pPjcmNYlM9NSNhEPDTAH7CE7bdylbOcBmM8rZz6qD
 XkwgIQr+LHRWVhCijSUm9BpjeYjHSrSruBKtB753cEOJVOJWqwplfW6xE
 UCmp5Nt5RzEOx1MHRVwnASGDNA5Q8xbzxMUYSMxzj8ohLxXO6uB13gmoY w==;
X-CSE-ConnectionGUID: QVEbVFP7QWGBo8F35FBntA==
X-CSE-MsgGUID: +ll3xuOeSEaKNcw63ssXmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="76124460"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="76124460"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 00:11:59 -0700
X-CSE-ConnectionGUID: xeL23as+R1S2Az2odwgHiw==
X-CSE-MsgGUID: PmpXpysHSfax8Qj0/WtR+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="173938611"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 00:11:58 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 00:11:57 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 00:11:57 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.68)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 00:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h8pX9uvdspPxzCIyKZ5Lvm6mK36/8ofgM/p4LXbcRRmzF+g214X1Swu958BVyMcwfHvf0qQa54GNOcmLfDp/KLaIZqRdr1fisnGBLHI1KQdQhGh0itvsrcM1nzrwc3aCWB2KXR9ok0ZvI/p8tmfGu7LDQMwgg1Ev3dOOyXZ37oIBl4WHQXtliYmAs48G284y/a/wgrz1VwCw7w7LP2p9ylSBqRE2J5SA6C66pwE1PK6Er7N4bwylXscxUeWk6W4e3I6+ZexiSLbG9lO/QcxCZKaY2JuZ8V9SHQMwkmHva/SKR070w6qIMmTJCnALaviP7AfGYWYOm8JJXeVVPKauug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9jpTM6DCs9HGT8eoTeKhBWVhZ80ZkO+Nl2rnxFBQSw=;
 b=DlJvVNMbx6jzw7BDNAxFQJU883CT8IXsm4XFaIvhGtCYt+wBlgHZAQNW+aj2WPSc1LGyPpsJBE1hLdQqNED8LxF3JcPgGjtIkP++8db7u2+MWNqErdo9eBuNqjP67hF8HtNsqSXI+F27isTT40j9cdxIVxZGVtO2T0WgOe3dX0DRJiyitVf1VKRjdOBoheWfm2mtBZfTam6pvOwneegtgOCBu8RACjrobwA+uSBPcWQrMKGlT8lRSku4hvdZ6HRDm7heHKANM7bEkIpuKaTVpa1qu6yBBV93LSGk4Sum0rip/sp7EJa+IpwdtRoXKPaPXAvFxCPdVaAiZWxQnyIE2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA3PR11MB9226.namprd11.prod.outlook.com (2603:10b6:208:574::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 07:11:54 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 07:11:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao
 P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Thread-Topic: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
Thread-Index: AQHcEy/8GohI0K7pz0eZTie1Q5YTorRvWgMAgAPANdCAAIJugIACeoew
Date: Wed, 27 Aug 2025 07:11:54 +0000
Message-ID: <IA3PR11MB913677EF729CF0BD2E3902FF9238A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-21-zhenzhong.duan@intel.com>
 <aKkDXiSwWGgio0dM@Asurada-Nvidia>
 <IA3PR11MB913633DE25AD6CF07BF26F8E923EA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aKyWQ6inC+F7idd0@Asurada-Nvidia>
In-Reply-To: <aKyWQ6inC+F7idd0@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA3PR11MB9226:EE_
x-ms-office365-filtering-correlation-id: 2be4726d-81d4-498d-577f-08dde53900e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?SCn9fRxgKgWFme8gjPKpRT3AuNcyEU9BgQXWadPD4UZaOEkTy7DeHS2B12Qj?=
 =?us-ascii?Q?Wx0OHnzInq5i7SJfhTAewHUOpM7WGNJNIKgJxVXGe/QqTTw8CLuu6kry2lZ8?=
 =?us-ascii?Q?Yl8kXQBO7g/tQVhlrMHKJYs3n7FDFaU6YkiDMOtho1ZsyneNFxlSSp2GS6xf?=
 =?us-ascii?Q?3imob78oaH6ukrQIw9lhcDX70DcI0Y62VQS3EyR50ZoPsWVySzPwx5s4s+5f?=
 =?us-ascii?Q?QtblyjHadEwj4JHGDT2nEy34VlXv55UDicKgb0EAsUc7vc+lAE47YOFyY11Q?=
 =?us-ascii?Q?a0Dcy+Rlc1313Kct2J8URtNs51Z0XxcwtamWmR3DRznBLVSieY7y2qkfwkvh?=
 =?us-ascii?Q?bfzHEZGzemhqP+nOrVF92oZU3Kqp4oXdA+LDRvbns7y5jUhd9U6+LiCXyd8t?=
 =?us-ascii?Q?MBQVdFlPekKfgyjy0V4BbOKjxnM/tjVBdJql5Nb0cLmFBPZlUzKqVoTfVWpZ?=
 =?us-ascii?Q?aTI3fIH8A0P8gS8a2CcZbxFpI4h5AfJjj9SqKT/eoOKoyhaYsJ8Ty+M57feu?=
 =?us-ascii?Q?NKQJxdGjIKpb6+ylk/IQ9+JTXPGSafxB+HJxqQ2iFFRtZo58dq4XTY8g7iMb?=
 =?us-ascii?Q?SOCyNJI6wZfSAs1qbumf9oTOgC+JeT7/3Kd6teTq0xndtanuOzVsefNT4J7N?=
 =?us-ascii?Q?2YlxZ/oOFMJ3xNUhmelRiL6rJ0Pazkk8BFJetpDihoqsUlAK24jWaGM5G2xi?=
 =?us-ascii?Q?nnGA/lFen+fXUS9yx82LNPsPTQeZkfJsW/S6qrt7qNIykn8VuW5th2Q/iKR2?=
 =?us-ascii?Q?Cnzrp3sZURrXyi6ci9f4f97JuSQWUBx6zI2DbO2GPtdLtY4zXuscCpPRuZVO?=
 =?us-ascii?Q?VPI5x3PFT1hK94f1bE3ry5kUs3JACcISbs78h6dWHDQP46GIsUvLL2+3hzu+?=
 =?us-ascii?Q?lxKeZemtMXmVEBBXN6mje6/t1iRyL+1j0EvSFDK0kwcduAkrJS75GImLLvxJ?=
 =?us-ascii?Q?efyhSUb6MCsPokt4QnRY5OH2ULzhJKiKuISl8Dep4Hy4fZLAfwHWKjO+rvZy?=
 =?us-ascii?Q?JNa8FoKeQ4rsmLDA9W6AxsNQ8GNP6MgzSiKdpu2xU9RbGRvXj24VOTisTDno?=
 =?us-ascii?Q?BwFFrBvpClF9oK4MXHWfHHwL3acS02KEbkELNdNrxpyvvirSR7U27zPea6+L?=
 =?us-ascii?Q?ScP6pUa/FuHHw/YkcTbF9uuWZePW1pneJlZR+66OfOH4alDstT+kqdbN6UL5?=
 =?us-ascii?Q?zrOOQNCo4xmSaH1mRi269Z1ykzrb2DlDoizKFN6IsTZWmXwMZZAG9zB5v5J/?=
 =?us-ascii?Q?mbADrOEZ4ZZmNz8S97v/4pZZiSpXTUBqtiwekiy+5wZG96cpGK9qNtkOwdVK?=
 =?us-ascii?Q?7Hqhfz2Np4dTqoZxlt09oHm6+PLL13+JhU+MiVU/ymzBin1Ra/rEvAtXWvnp?=
 =?us-ascii?Q?PuXDy/Y9EPS1ytpLNPZqdw+daRHhiFHbZcr5e1rdhY8wKw54Ss9tJ4qzvoT5?=
 =?us-ascii?Q?lY73RQ6tAB7J/isSSrnZdoPYeb4ZbVdM32ijgx9lt5KsR0GtD6e/nA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S5ZOu8ZnoJ9qDeGj+4VC6GXkgB1NR9fm1ZTe0DFAgA6hNdZDUVBAYKzY4xVx?=
 =?us-ascii?Q?W4oh4OJyCHhDIUgpaJXRmIpFQEkFlosnzfG/7Kp9rnEjq2Ds8dzXkBPqx5Bu?=
 =?us-ascii?Q?wKCNI1f3Mv408x/BLhTKy0FLPkZWAD2puapkFZmuHZJCmE1AYOMBLv0ALlwN?=
 =?us-ascii?Q?/xkWCd8TgbLVHbe9oaoCpDzgVjx1MdEzBWr84On9lD3oufXV7lv5N3aiiYd+?=
 =?us-ascii?Q?YwT+31XohDvAydogwkHlraK9q9l4lD5BGJOj1TIUHTBX91/g3PLfnOl3yxgy?=
 =?us-ascii?Q?znzWao95IDexCtnrlNx4JLzA1H2aX2JX4E3FkE3I5HqJ3koGDioehUEI65sQ?=
 =?us-ascii?Q?FWicZSiXnawwGqMA0aBFc6dFiZz9khwgTyDwWte9cCrq5Lggul5elzIkIWBh?=
 =?us-ascii?Q?Jq+CPcIgyGzDxVJJYRW4wgnnirvkbUlGD8cey6HF5tPg8JUCVJezQtls95E9?=
 =?us-ascii?Q?J4602hnBkuF2SRQKq7aka5T+2A9fDrQ/B4d+mda0Hk3dvPhYAhH0DEdziNAo?=
 =?us-ascii?Q?N+eZMISymgQvQNIiIzOgXR5oAxAqQjScFP10lkrGl5IuRVOHFLHjvzm4G2pQ?=
 =?us-ascii?Q?xxmCYxbM58d8Ymu2beeFZuv55sMscY2/7UKQHn983x0+PL1sbQy4DLj51Ql1?=
 =?us-ascii?Q?p301GIBzBlSbCZyBWkjpSek5GzbXwK8xbzsL5vB+jkR6m13ws+gRLp2aIoh7?=
 =?us-ascii?Q?iKcSv91N6jrCsl5jIEaCt2sF5jKerjhdFqbb+kQJFsjmIRxiQk4AIpeUAYMx?=
 =?us-ascii?Q?W/BmIk+Qno29aiQsjZE8QJAa9a1G0aj6egOUJEnFgChmPcrqVYQFfOhD+Wv/?=
 =?us-ascii?Q?wZn/fWpL1q3A160HEzyJjtWPm0XINLx+s9SWKTp7Bp10EWhh3D5kBuLJEO0c?=
 =?us-ascii?Q?pAOzCUW+3W7xeoFuMmcabxtMKSiOYppzvFnE/pq7B/uG94uMVJ7z8HxtgQC+?=
 =?us-ascii?Q?9hqak4xFJ+TrQXD4fdRiOhLUpQ/2BePhaVPdVkBERc6pqIEtZ0PIt7lSgI2m?=
 =?us-ascii?Q?uZodBoA40I0x/Lib9tMcG30L5Ubd3HRvS7FQPyvrTr5/PtTvAHShQ75E9ktH?=
 =?us-ascii?Q?A2mSaPvdEJ9DE9jm8nb22hs2Goq8ed5VnWKBFXJFqVdJbHKxkj67zc57uD9R?=
 =?us-ascii?Q?p1isOGBCNFSbHMjlJJdZ7/3QOK+zjMSitTwLp++I/KCFXA5W8gxjVzur2ZYp?=
 =?us-ascii?Q?n+oajfViXsIAF3hoBDIUu+wiWdfWhCZWFBYSpxWu4LGg1xAiPbo4BMUmB+Vh?=
 =?us-ascii?Q?oBrVSPaBaIPcbIGb56NDi8EwyDmF6/t2FNQnNIpcoRBBTRfy3m/LYNqG/Hjo?=
 =?us-ascii?Q?ZCRuUATSyuT82ODwlTHfH6fYQE744pYr8N6AYhdcWqW1tZPWAYOZG0VadWmP?=
 =?us-ascii?Q?Sm2CEYyRPntWdI6Fci7+R9Upwmcq1tZjS6lsejL3vxjDnBLJ0AfQrnk27fdW?=
 =?us-ascii?Q?nbMku5B5meY6pYRRMmBgHaKbkAXk4PbjDZfpWFx1slk3JRvVV6+Ufz+C2VEt?=
 =?us-ascii?Q?Hz8//GvJIn7MN0JEupr1oOI4Arxwc0Q2Q854WzzH09g3k2VGiS4RNdt0P0CO?=
 =?us-ascii?Q?Ix3OvB+2rY3d7nIRA5u26yY5LZG+eSC2nxvn89ck?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be4726d-81d4-498d-577f-08dde53900e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 07:11:54.7342 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DAcnDcV273QgcTxergZPmUWuNXkIIOt5xqnqEQtKIJUcryzXeXZMwgW4w2GM8NG/sDIrBdN8e81MtwjPewMYbFjn0OQpQ+FlSiwMxAJHLpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9226
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.8;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
>
>On Mon, Aug 25, 2025 at 09:21:48AM +0000, Duan, Zhenzhong wrote:
>>
>>
>> >-----Original Message-----
>> >From: Nicolin Chen <nicolinc@nvidia.com>
>> >Subject: Re: [PATCH v5 20/21] Workaround for ERRATA_772415_SPR17
>> >
>> >On Fri, Aug 22, 2025 at 02:40:58AM -0400, Zhenzhong Duan wrote:
>> >> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> >> index e503c232e1..59735e878c 100644
>> >> --- a/hw/vfio/iommufd.c
>> >> +++ b/hw/vfio/iommufd.c
>> >> @@ -324,6 +324,7 @@ static bool
>> >iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> >>  {
>> >>      ERRP_GUARD();
>> >>      IOMMUFDBackend *iommufd =3D vbasedev->iommufd;
>> >> +    struct iommu_hw_info_vtd vtd;
>> >
>> >VendorCaps vendor_caps;
>> >
>> >>      uint32_t type, flags =3D 0;
>> >>      uint64_t hw_caps;
>> >>      VFIOIOASHwpt *hwpt;
>> >> @@ -371,10 +372,15 @@ static bool
>> >iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>> >>       * instead.
>> >>       */
>> >>      if (!iommufd_backend_get_device_info(vbasedev->iommufd,
>> >vbasedev->devid,
>> >> -                                         &type, NULL, 0,
>> >&hw_caps, errp)) {
>> >> +                                         &type, &vtd,
>sizeof(vtd),
>> >&hw_caps,
>> >
>> >s/vtd/vendor_caps/g
>> >
>> >> +                                         errp)) {
>> >>          return false;
>> >>      }
>> >>
>> >> +    if (vtd.flags & IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17) {
>> >> +        container->bcontainer.bypass_ro =3D true;
>> >
>> >This circled back to checking a vendor specific flag in the core..
>>
>> I'm not sure if VendorCaps struct wrapper is overprogramming as this
>> ERRARA is only VTD specific. We still need to check VendorCaps.vtd.flags
>bit.
>
>Look, the HW_INFO call is done by the core.
>
>Then, the core needs:
>  1 HW caps for dirty tracking and PASID
>  2 IOMMU_HWPT_ALLOC_NEST_PARENT (vIOMMU cap)
>  3 bcontainer.bypass_ro (vIOMMU workaround)

Why vIOMMU workaround? ERRATA is from host IOMMU. In a heterogeneous enviro=
nment, some host IOMMUs can have this ERRATA while other newer IOMMUs not.

IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 may only exist on old IOMMUs with nes=
ting capability, vIOMMU doesn't support nesting emulation yet, it's also no=
 sense to emulate an ERRATA in vIOMMU.

>
>Both 2 and 3 need to get from vIOMMU, while 3 needs VendorCaps.
>Arguably 2 could do a bit validation using the VendorCaps too.
>
>> >Perhaps we could upgrade the get_viommu_cap op and its API:
>> >
>> >enum viommu_flags {
>> >    VIOMMU_FLAG_HW_NESTED =3D BIT_ULL(0),
>> >    VIOMMU_FLAG_BYPASS_RO =3D BIT_ULL(1),
>> >};
>> >
>> >bool vfio_device_get_viommu_flags(VFIODevice *vbasedev, VendorCaps
>> >*vendor_caps,
>> >                                  uint64_t *viommu_flags);
>> >
>> >Then:
>> >    if (viommu_flags & VIOMMU_FLAG_BYPASS_RO) {
>> >        container->bcontainer.bypass_ro =3D true;
>> >    }
>> >...
>> >    if (viommu_flags & VIOMMU_FLAG_HW_NESTED) {
>> >        flags |=3D IOMMU_HWPT_ALLOC_NEST_PARENT;
>> >    }
>>
>> IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17 is a VTD specific flag bit
>> from host IOMMU, we have defined get_viommu_cap() to return pure
>> vIOMMU capability bits, so no host IOMMU flag bit can be returned
>> here. See patch2 commit log for the reason.
>
>VIOMMU_FLAG_BYPASS_RO is a "pure" vIOMMU flag, not confined to
>VTD. IOW, if some other vIOMMU has a similar issue, they can use
>it as well. Since we define a "bypass_ro" in the core bcontainer
>structure, it makes sense to have a core-level flag for it, v.s.
>checking the vendor flag in the core.

It's not a vIOMMU flag but host IOMMU flag except vIOMMU want to emulate th=
at ERRATA.

Due to patch9, there is only one VFIO device under a container, so bypass_r=
o is set based on VFIO device's backend host IOMMU's flag IOMMU_HW_INFO_VTD=
_ERRATA_772415_SPR17.

Thanks
Zhenzhong

>
>My sample code is turning this get_viommu_cap to something like
>get_viommu_flags, which could include both "cap" and "errata".
>
>Nicolin

