Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D64CC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 08:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFqkS-0004Rs-JC; Fri, 16 May 2025 04:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqkR-0004PH-Ci
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:48:55 -0400
Received: from mgamail.intel.com ([192.198.163.11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uFqkP-0006uj-59
 for qemu-devel@nongnu.org; Fri, 16 May 2025 04:48:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747385333; x=1778921333;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZBeAbJSKmcl50D67Y/tb8qvQpPAYyo3RI6+EcwoKvzo=;
 b=NZgQetg/FOKhrXwu8MPt0+k73PPIablXTV1ZnbZ8NDczTRTz8gajq0P2
 WpmfhKi4RxxUhCOfI2hHL6cEPtQ3I/gPVr1aH3nStVpmj7V4iaa9GFZXB
 YKsejCDjIAFWmP2Tw9wMrW4fWZPWhq1ZYyfATJ/jAeRxaGlgXYnK7F/ru
 1KMZa6fRo63Sf7OZdFnhHvIDpzhYLt8t/GTixDFEkxuTPQECvqKyef+TL
 vpW2BP+u+exR8J0SR6v0/rjYrQMDmvns6nSrIz9CyXLeWRBN6IOtul4fx
 Br62abGEgdmOQzX7Yr9sN/xRVHuoEhZqhunj3E2k9jjNDCX05XSWZoYVK g==;
X-CSE-ConnectionGUID: mY2brhBHQcGzmtdqcOWUvg==
X-CSE-MsgGUID: W3MZiVwCSZOPDOTW6g4wlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59989269"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="59989269"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:48:51 -0700
X-CSE-ConnectionGUID: /2iKT2W1TOiIhCsCX3xqsQ==
X-CSE-MsgGUID: 7KoHi/MMStmOIRri+P5l+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; d="scan'208";a="138488075"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2025 01:48:51 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 16 May 2025 01:48:50 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 16 May 2025 01:48:50 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 16 May 2025 01:48:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uDFymL+aqcVHwUDyd46gbzMCJl4DgGPF5nPvMRZqIRQO9Cusx3MP8gZq+FoGR//DaAocoQaXup/cakIxm9r3pH2w60H0KMiRFJcQF8ZkIkjorsQlOI+BUCeyu2GImf1SQRJpTL7Muc+p63dXwgttsMhFwgsnzPNQyEySvqlLiZ4QzRXOfLnzKvF8uby6uFsgJp1LuDvoswjANEZ/7/bpDt8oEqsnfWbeCdJ9EcALS0SgS/h35QFgwy2OHeNYrOxvexY2o5mn/iuJJxQXIWJNNKccDXYzn6DGVMwgQTb5Q4Pvq/aeBAfG25AJBIGbT7fREzR8weC0GbX6bZW3dMsHjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR+dspVDKcMkJcvYQmjgy8kn/LVFho/W9tNS4Xh2Z4I=;
 b=hEbdO3Y/BcM2wIwp9KIN2WM+bVJHaKyPEJ7TIjSO6lNBczTIyLWyny93IekinWC/uCSRLVwLgbcDMiCUhSz0DAK2vOeYJA6Wgid+QXmMcLJG6YqjsKDkiAzgdnr94J3OzTzcVus6TaF2yrOxWhd6AVxNDMS73YuDteflSTxR81fTq7gYJVk2GV8OcueqBHKaonhlnTGXr4rDcQMJRr2C7RwmteIlqLlUrc8PmO+C+piTj4JzkZOGToIU4MVHoc6eRkLjHriuJ13hee6bkNs/nVH2crfofrs4txjoi79HrgD/ZIByuEz/LnNMGCM+7H+fV172exSDphVpS2xyuMzGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Fri, 16 May
 2025 08:48:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 08:48:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Thread-Topic: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
Thread-Index: AQHbw1NeOM38BEFik0GyWuV7ydnDA7PU95jg
Date: Fri, 16 May 2025 08:48:35 +0000
Message-ID: <SJ0PR11MB6744E4675DF4622F4414F5B49293A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1747063973-124548-32-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5769:EE_
x-ms-office365-filtering-correlation-id: 1438fe5f-798b-49b9-4cdd-08dd945671f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Kr31q7B6lTwwrnwO6VZzpHv0kWnEnpTIrxjDEFhRO2PVlXZxaNpe8u0R299C?=
 =?us-ascii?Q?0OO9GV19/VwMQtdvhTuCcrTGx01YSK1nEkYvk7mdwObRe4v+EJA4jtgWUfRX?=
 =?us-ascii?Q?LCsQANWaaYKr+GAGvWlGqAqmQda+z1dQHEWDqUPiYkjSynGFdBbzoMNRpXrh?=
 =?us-ascii?Q?ebFEnDBuGY+IKoD+IpDRgz/ySo9lQMFA8qkAOmc1iboY3VIlvLDogJzjcPw2?=
 =?us-ascii?Q?jlNerMSvGad1N/G5Fy/DJj0+FShAZ84qNreYj5gZbSKRjVBgtnSlSwjz8vKu?=
 =?us-ascii?Q?do6811CgSzeaZWgYGwn+hA3EiU3no8BZke5LDy4SQKshAJr5kc3V3nO9tDXX?=
 =?us-ascii?Q?AdIMGB7Ad84rmQeRYa89wdX2+U98A15ThCCba6Lv9utXXgXqFjP7mZZdscAc?=
 =?us-ascii?Q?hHLPxYEXStA4FTt3+hf8omyFUDSXkE4jhuGCc+KFYmhpRyZoUdPvcrMctdJD?=
 =?us-ascii?Q?IjAGRcnaYQMYNb/PKR/oJ3Ut0tvQRGy0O1uY2Dnwk4qvTTLaYQrsT5f6krqJ?=
 =?us-ascii?Q?ITjUBW3mfETSmtJ0XmnMni8yecNZhsRXgvv06LNNrvzpjLEZlaQC9XmJlT1y?=
 =?us-ascii?Q?IywEvJD2L86xJE+pDqW7PNxDFpayn6d1T8rC5QDIae+dFCjWbZ+40C39GlYV?=
 =?us-ascii?Q?Fw4C5hNXG4hZUQ4KHyGoA9qEgFENqXlprTtWt/o2B/W33W+yOdGRI1HADbZM?=
 =?us-ascii?Q?9hkYmGuBf4UPmmaGxfVGlsQaFWJvSiyOYLfM6n2UzSe5hIFQL+/R0aZZCBea?=
 =?us-ascii?Q?zbE5hykoQPmIwmqqYeEyTsC01dtfwp9ZlQjwRa7UHI6JWOjnYvRfxraYZpsY?=
 =?us-ascii?Q?v82W0i5iT7y6xq/C4V0y9+0T87725ZsJ9jdsJY7aE0SinMoIPF2iMRXsUWCc?=
 =?us-ascii?Q?WVZ7thqgtVnkInLPneiDLO1QVPjmXnfk5NjI4yhAnQ20mqCR5eOS3NgucIt/?=
 =?us-ascii?Q?XpgdftN4YvkRHS1pjLcpLZApLiNcoTDka0c551EPKCQFt930xtvcVu0FNBLk?=
 =?us-ascii?Q?TJXpHBOH3/mkROZBhk0GSu9CmfhtyWoH8t5vkDtj6PR6/dOCfSz7rsjroNZ8?=
 =?us-ascii?Q?zniJYPhf0VAn/bTjV4nim0eWhNGkGpUZKfdqOnDva6tp7ejeMD8NIMaLpfks?=
 =?us-ascii?Q?wnIvsr19KFlhHh7yUV/VO97UZNAZWb484bhEg7aQUsMHxn5MMq/0QAlP7SPR?=
 =?us-ascii?Q?GlWHYDhUKXO8dg/nb1Jizagw9mXI0+aZ1xw74noLvVFBy1BLtFib+rVFYGES?=
 =?us-ascii?Q?lDf/WxT659mGn4uD9KRQWxH9B7NwgbUl66TtR8ypiAfOQ8Y1hdhtxAzs8Ru8?=
 =?us-ascii?Q?rXsqHej5p3SKqRaAfc4Culi+DnwWKauTu8qPdCeQi3vUDdfvD9l5+ysV0FAI?=
 =?us-ascii?Q?5O29ze03EqHIVyK+H5XqLnMr/vTDiaU9b+nIeFTX/rCjtTIRB3ecKpcsuu49?=
 =?us-ascii?Q?shBcec2iUdEUQpiZMngJlKYNDiRUsVdxoD5tlSvs/kvXJ3SkmycSPA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AIc5WThzsh/k6TDzpGPNY+LjTkBUBSsIXJ9hk/if/wMH20pxsVlm5EFRugcH?=
 =?us-ascii?Q?ItawhKY47+b6y2VWNi2j3c2PxdJUfm4LePMMFHZYvQduYa7SzbsuyG03ggnK?=
 =?us-ascii?Q?QtSSyYBjLhHJJP5oFlP2Pb/ebTdJoren2eFfno9SNzmmFKESS0r2WNdnPKg2?=
 =?us-ascii?Q?LUxbUe1CljSnoV/GNsmm2mI4Drn3yYQajWJHqHQsBODltW6xo1bfP7XdDRd5?=
 =?us-ascii?Q?jR/nebQFA4doS13A7WNDjeVhCJhIMFrJ9LkRWWkkf3n2Wekgsgyit7rAsAO6?=
 =?us-ascii?Q?Wn1EY84DrBYRkRjrdI1pHvZWhFA0Bhp5sbYjNyczugEJ6kVZDoQ+46tGYyXZ?=
 =?us-ascii?Q?3GF9BOgWhF6aPK/Z5kVTVsqcfaRwTKUK0V5r1LHdccqBXTU9hbWzvFDA55GK?=
 =?us-ascii?Q?S9ESJs0HYN89GdUs0i4HM0QEj6xJimiy49ga8XlOqgNMiz3KgT/9cIKyiE3W?=
 =?us-ascii?Q?Y4daRSaq5VZtt7d11nhXjTBlXsTakVXU0Zg/FhGZi5t+k0LfefpTF/Erl9CI?=
 =?us-ascii?Q?T3fx1sn3aYUFEVIucuxO4n3ZGrMbQ5rP/IGMI90NT6a1eFzDBI99mfyPFK4K?=
 =?us-ascii?Q?sKFejuZNabPsw5/frlPIo5ECiyjDnUocXRy+21VzfUQDBJboKK7k4Oq+btl0?=
 =?us-ascii?Q?MRruEaVTq8fa6QMUPddptgeT5jIeEVLWDsUuoh10MtoZZE8hhYdfZXR89rh0?=
 =?us-ascii?Q?t/SIPZgB9wpIUVzTDe/wMnoCp9iZwKM+Allt33vhxdH4twgvxZDQ/sJDyS7G?=
 =?us-ascii?Q?rjysvbfgSWpd/KjLsY/XwYmwT3tiT5qBLz2DOo40YlmG8nRSOQW8tZZ2lV8b?=
 =?us-ascii?Q?Vo+at8xiPv6dI0rreWj5lvLZPnCFaDJojjg9t6PB9NWlrrzyFf+PqJdt+REt?=
 =?us-ascii?Q?Hw/cOjvzll8yNAaUz5Owa+6sndZ2TdHjUpX9eMQy3Yjo5Yv3mGY7DJAg3nHd?=
 =?us-ascii?Q?3Z4g1uQkUxh41XhgTsk6hnrgfqx07e/v8hbaP+iCVruWYHYKncGernCIx+S/?=
 =?us-ascii?Q?5YVvAUApbeVwg0fR9+XdWL3EEfE+QXRbu+Y/x3sU5u3cWuRF3VQvrmUSDiJm?=
 =?us-ascii?Q?UbFIRatQX0d5Xhx4CyLCK9SIyHN0/WDPxlGlbmZsTQ040EERo1Z4y80GsmsZ?=
 =?us-ascii?Q?g52r4HnkvGYQ7yhT0Ibay1TbTvHtahifGcvwp1qT7e4cAp9QrNLStO5deM3s?=
 =?us-ascii?Q?zXCM5q+a1Te1Gpmz5SlwmF+vBW3RwvBeP5Ck8iFIwVn+soY8GaDtA4XkhGJT?=
 =?us-ascii?Q?IPj/H/TCRcPx8ZntUv4l34RtvDki0NJxeUbBDiDUnweVKmGDIYOmSZ92NEpk?=
 =?us-ascii?Q?vOIkbsM/HSKJL9hDwKjqyYPdGsxy7SWd2gQtyIXz2dJVOWYFOfyrkudKijNO?=
 =?us-ascii?Q?78shUboY23dJPiwLz1MEnwy0TaOpJAzI+UPTWpLn4mwfca4IHW+dxd5D9uG7?=
 =?us-ascii?Q?8JOD7N/IEOAOR4azal58TDWi8UOFIBGUJjQFqNryyfNDl2YkFKJIJTheGr+s?=
 =?us-ascii?Q?+QnQ2OaefzJC4+mJeh0oOPnMNG5ElER/BG9goo6mWZfMlQ7bBh5WTnas3heZ?=
 =?us-ascii?Q?Hnlsp521f47jby0OJ38SdP1QUm8lX14liOalbxEJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1438fe5f-798b-49b9-4cdd-08dd945671f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2025 08:48:35.6429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N+AjhvdgGobwSMmebO6dyxyezaCdnf/u9CB33yQL60XUcZgJRJMXVE6PbULPxNvzpTZbul4JPSeuv5E3nLttPi/YJYW4+4BQhrXWtMEBVIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.11;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -60
X-Spam_score: -6.1
X-Spam_bar: ------
X-Spam_report: (-6.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V3 31/42] vfio/iommufd: use IOMMU_IOAS_MAP_FILE
>
>Use IOMMU_IOAS_MAP_FILE when the mapped region is backed by a file.
>Such a mapping can be preserved without modification during CPR,
>because it depends on the file's address space, which does not change,
>rather than on the process's address space, which does change.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> hw/vfio/container-base.c              |  9 +++++++++
> hw/vfio/iommufd.c                     | 13 +++++++++++++
> include/hw/vfio/vfio-container-base.h |  3 +++
> 3 files changed, 25 insertions(+)
>
>diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>index 8f43bc8..72a51a6 100644
>--- a/hw/vfio/container-base.c
>+++ b/hw/vfio/container-base.c
>@@ -79,7 +79,16 @@ int vfio_container_dma_map(VFIOContainerBase
>*bcontainer,
>                            RAMBlock *rb)
> {
>     VFIOIOMMUClass *vioc =3D VFIO_IOMMU_GET_CLASS(bcontainer);
>+    int mfd =3D rb ? qemu_ram_get_fd(rb) : -1;
>
>+    if (mfd >=3D 0 && vioc->dma_map_file) {
>+        unsigned long start =3D vaddr - qemu_ram_get_host_addr(rb);
>+        unsigned long offset =3D qemu_ram_get_fd_offset(rb);
>+
>+        vioc->dma_map_file(bcontainer, iova, size, mfd, start + offset,
>+                           readonly);

Shouldn't we return result to call site?

>+        return 0;
>+    }
>     g_assert(vioc->dma_map);
>     return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
> }
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index 167bda4..6eb417a 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -44,6 +44,18 @@ static int iommufd_cdev_map(const VFIOContainerBase
>*bcontainer, hwaddr iova,
>                                    iova, size, vaddr, readonly);
> }
>
>+static int iommufd_cdev_map_file(const VFIOContainerBase *bcontainer,
>+                                 hwaddr iova, ram_addr_t size,
>+                                 int fd, unsigned long start, bool readon=
ly)
>+{
>+    const VFIOIOMMUFDContainer *container =3D
>+        container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>+
>+    return iommufd_backend_map_file_dma(container->be,
>+                                        container->ioas_id,
>+                                        iova, size, fd, start, readonly);
>+}
>+
> static int iommufd_cdev_unmap(const VFIOContainerBase *bcontainer,
>                               hwaddr iova, ram_addr_t size,
>                               IOMMUTLBEntry *iotlb, bool unmap_all)
>@@ -802,6 +814,7 @@ static void vfio_iommu_iommufd_class_init(ObjectClass
>*klass, const void *data)
>     VFIOIOMMUClass *vioc =3D VFIO_IOMMU_CLASS(klass);
>
>     vioc->dma_map =3D iommufd_cdev_map;
>+    vioc->dma_map_file =3D iommufd_cdev_map_file;
>     vioc->dma_unmap =3D iommufd_cdev_unmap;
>     vioc->attach_device =3D iommufd_cdev_attach;
>     vioc->detach_device =3D iommufd_cdev_detach;
>diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-
>container-base.h
>index 03b3f9c..f30f828 100644
>--- a/include/hw/vfio/vfio-container-base.h
>+++ b/include/hw/vfio/vfio-container-base.h
>@@ -123,6 +123,9 @@ struct VFIOIOMMUClass {
>     int (*dma_map)(const VFIOContainerBase *bcontainer,
>                    hwaddr iova, ram_addr_t size,
>                    void *vaddr, bool readonly);
>+    int (*dma_map_file)(const VFIOContainerBase *bcontainer,
>+                        hwaddr iova, ram_addr_t size,
>+                        int fd, unsigned long start, bool readonly);
>     /**
>      * @dma_unmap
>      *
>--
>1.8.3.1


