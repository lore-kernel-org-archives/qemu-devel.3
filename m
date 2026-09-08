Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46380C79F99
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:02:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3pqN-0005dq-6g; Tue, 08 Sep 2026 03:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x3pqL-0005dd-Ev
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:02:09 -0400
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x3pqI-00058d-0d
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 03:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788850927; x=1820386927;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=D9/2rD3+KZ+XsCRtsPg8fOjzhex08F8iL0CvTi2ZJOE=;
 b=Q2+lF9RVEScfA+HZjQ9CtO4naLZunwh7UuEXrXY2hogYIVUXt6QCKPOE
 l+m1GL/0T98Ms2t53qCzkRQXt6Q5GVyrIh6eLQ5R7PI06E+JURP1CrMgz
 OCeAtQlCICLlWpVqdgWVuPIGToRER6/YLkLAlIIgbXIqEWkfjfCAuRHTo
 pY+6GEA1ze76HnF0unpR/DKjtoykFr80h2Jbwlkm3/ICySc3+EzFSl0BA
 evPx99Ue5jjsWiQ5sCLd570/i15jZiv+gZ6r02q2au6CWjmIkcsFT5bAd
 uW9SRcSy/oSBkCQ/+BI66M/1DcQ8oMFWhNKpYgeBvfMWpJ81WJ4/n4wWd g==;
X-CSE-ConnectionGUID: Ac91q6LnRVyJAC2XfpYFlQ==
X-CSE-MsgGUID: l0aT/TwLR5KEJ1QWdUI6XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="89001711"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="89001711"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:02:03 -0700
X-CSE-ConnectionGUID: jicCEwEJRSqbJr07ixEKrg==
X-CSE-MsgGUID: Z6jm/fq3Sl+h/feYfuOvKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="264710819"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Sep 2026 00:02:02 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:02:01 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 8 Sep 2026 00:02:01 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 8 Sep 2026 00:02:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UDchz/XYpZ6Pwna1XzJQr6PjzCselEQ3zolYm6ngUPuBwNT2Zk96nYTOylQImd6g5yYw1idBcNC5VR/Avz/RKudehlr2ZIe/rooXavFaiqFju5kAMzVerJp1ZB4p/nY1Yd5M6rNFaAIXCxJURlASYIEXxzVOzCD+YQ12x3EsF3GVVC9Sdy8VBJdA/TzrZ2azYZdOOI40OwrlrpyKNzpIrQmLJL4sA/TRrSj+4Igt+wsEge8juQhbSPpvcvy1vl8ran4AaZ5ghWtmRrAWBXdpLeomQvcxfeW92yQFo/c4UcrnjMhAC9xLppw3xX6BCZIqKI87Jshww01U+pwJz94FsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zHULfxMpFXh955quOvnh91f2rVgThR2oBK++h0jKyI=;
 b=TlBiG1n315VAmLXlEhU9M6jSRmQy0j9zBh7goTFHCK7AhZCKLWRtO9evFlDV+diMWeeyEEtWmbWr9RL0WcxholqYwtwViOty/mKUnSFD2lkwWS17JDbm7Ud+kq6ejsDa73mxYjx1gjqsFSpbGGRmcxTyOEGjVHExquAu63+466Ehm+3FZ8kDFbRniE2+H8HZVydnrkQsbcs6TIMIHF7Eom+iiSsq+cHmfMctWA9nN+zComMvmWG9ygZ5t81388i+LILAttr6uj/EX5iD0jpeLcoV6kvqrAMGTQMmhd3c1LINRnsCGHARAuqtcw9O+M+VzwckZoXEygy4PKA882rfFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SA1PR11MB7061.namprd11.prod.outlook.com
 (2603:10b6:806:2ba::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 07:01:58 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119%5]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 07:01:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v1] intel_iommu: Support concurrent page fault handling
 with PRI
Thread-Topic: [PATCH v1] intel_iommu: Support concurrent page fault handling
 with PRI
Thread-Index: AQHdO7Orx/6HOHEK7kiJZZLQqCFugLbER87A
Date: Tue, 8 Sep 2026 07:01:58 +0000
Message-ID: <DS4PPF93A1BBECDE07BE6A9E338055C18B892B12@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260903145044.2245609-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260903145044.2245609-1-clement.mathieu--drif@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SA1PR11MB7061:EE_
x-ms-office365-filtering-correlation-id: 40868825-29b0-4a09-925f-08df0d771331
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|38070700021|6133799003|3023799007|10067099003|11063799006|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info: fIfhqx849bWEMvak3cLEg18z1jFynkNvMWC+kKgvWV7ubzl4SFK6LxgmnuzrlfOAcU1mHJvnuObkMBLhdq3w3fm9RsKJcGcJlDfvZf8gNlHT+Co2q5OxkqQyNN5z5ziGw2+kcAimI65ORBBE9ooy7WugO7OTnqvL62EmHsIwjZ+Bc3Wf2RB8XoOQpTRsqQkaskBOwR7PIaZFkIdtTf2JxqVxZnDFYlnHtpGBjmVkzncoiBjjg9G63D/mLNo83YEr3xEOeAdEztOZKXMYm8HyWGYS91/D0/Z7WbL0CqeMnMRfUPJj6yoPQ3DolCfzLcgT+kwX+14NMcZnDD92KdTD+Zhsqh8ELMdzRzmZgD9kk2vpGmJNoFHPpe4VPSuY3hx+o7xcYsly1q89LMI/g20UFPyKKkRbLBrIVpL6EGWkKgvPdto2Z8FMbU8QZWLRfhqPgX+qM11Q5VdUsThkz4TZU6+BjMdK1GfkRdCPDxExS6q0yjoiyOGokKfeFayusO8w0g/ML7nmfb8KAX4B3sScJoR6VxvBlNjyh2DR6Y1YDpT7eyPjPEebeZ9Xb1+dBBlyq4104JzLHP7PVwt7lIyGopZs2O8X2LMoQ8VgEPS4UTBAV+UkU9yfpeseMW3CwFawhwEE1fvwu3qjCnVZiVNUBQMjZBSUqWyxpMRAnuWVO3pwtyhg068GxTYsiNtZiBsbFBSYQQ8a13FB30Ny24ngOZrmbEAbSxfOrn+auKlLh+U=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fB3NJOAF6aX/OKcWkgFQEQ7JAU1ZcEMljteHGS2SUJG0xWBfsV5+23niTl?=
 =?iso-8859-1?Q?EqnE2JLU/YIwTwkqVS7sSZXPLYpGxNbvS5NMrcGHZ3bgRg+WOVU9/pYvE1?=
 =?iso-8859-1?Q?x3mZ1se3zdAzOX8yTyjTnQMRIzkKw2gILpCiSLxCM+pOh5l2/G9xy02D7i?=
 =?iso-8859-1?Q?Ydu0IlppOJ8ougWHdeOhocgTmci2vidckauPs0kqwoZNhL6EEqJRsGxGJC?=
 =?iso-8859-1?Q?StbhtKawnl02x/UcUqztEIkNI0gvdsajSAFz7HX8ykeDjLB2/YAqiDbnOa?=
 =?iso-8859-1?Q?4ygqWKo6ajEqz4espT6JKZX86fGxRQrfeup/XzAjYVU5/F9ndj7FEd8lqP?=
 =?iso-8859-1?Q?idhl4YQ0/YdqILCdLv2eFCuT3VmQxV/ax0ykiGLOb0tvykzeUAimIwXZqR?=
 =?iso-8859-1?Q?lJJ8+LwtgF8jub5754rdiuVz9lf5LAy0PUwZV2nK7zvcezGNO7VdZ03/g5?=
 =?iso-8859-1?Q?/R+oMJPCrdm3T6DUKVvWZw+FSq/odRwJjbzuu01cCQ55qyCUU0GnW9ZRO+?=
 =?iso-8859-1?Q?+baQ4GGvGDuojWItfnytRvI4TBU1EDJ9PfEHPR3oPQRTtzJ5tubDYz85SY?=
 =?iso-8859-1?Q?LgX3+nYi9/R5KmtFSaVu/Fg+clZlXGb2D7tAOI4pHdkKDi7B3NJy78Mzrg?=
 =?iso-8859-1?Q?ROFgh2aWFxs+r+hPI97AKXgh5qqSd/zV5nn1hBM2uV9pojPF/1v2QmOwn9?=
 =?iso-8859-1?Q?a8c4uJs1VJHC1JC+H4Ik+pFHcos9FsRttejmTL6K4zUjKJajJ7lLxWCU10?=
 =?iso-8859-1?Q?RC8mVeWWOXiTb0d1R8vSa6ODPHqVggu34c0ljyQFBU+iW85WmrU/HTMXXD?=
 =?iso-8859-1?Q?j79NfSPqXERWCqO5k04K2ijNP5aA/CshzUCfqW2xS8lODW4GMAQN1LpJUk?=
 =?iso-8859-1?Q?OKLSF2FjF6NwropTuXItFz3j/B+D8oLG2pfrTKx1hksgd7srshFAV/iG3C?=
 =?iso-8859-1?Q?YM6Frk0tw3MLr2SwEarF9biyZ+Bs46udRcztSSDChTmArRcqDu+Xc7/20r?=
 =?iso-8859-1?Q?dCfuffJnVfIvSMJ9q+R944kS0EuCJXGsYL5Hd1RQ9p5BK4Pft12NPBv7NR?=
 =?iso-8859-1?Q?57qxvWWTJ2VZW3EHML9gjqu0qN6+RYuiz9AdY8O7OulrU4yUns+0Rg92bP?=
 =?iso-8859-1?Q?iXYurhUBBIoVLZRyZayfT871rZ7QZOxUm6kEGY6re3Gy3VtKu2aVbQc6MJ?=
 =?iso-8859-1?Q?pnr/cpoo95tOSh6q08UFyra5/AumJ04b1QOzrdOxPVrGOW3ewrMDwQrC85?=
 =?iso-8859-1?Q?t8X2s2n+PXSLmxO++LxkDnwbPA7zaLF0nxXywE3NQUMIQz/kz8GA1LRS0v?=
 =?iso-8859-1?Q?/4MZso1iApt2sRE6HhKL2257Wip2fmNQCbUaaHU99d02TQw52mMjuG7XGl?=
 =?iso-8859-1?Q?5Hw2uYvKhc00e7xirhTJgqG0nFqmQBl8QqQZtsWsqwnf5ddhAnmhG36k8V?=
 =?iso-8859-1?Q?hK8E/SHAcQZR6iihn3vJNAf9Rnb6O8ag0j4UNkgvY6/sJkOaTQ1o135w8W?=
 =?iso-8859-1?Q?R5myvl49ffVg+/JKLWHWPSEqVFcsHpVinEPJgcSKToJ2IpSQnYzAfJCK4U?=
 =?iso-8859-1?Q?noQxl4/vvaGgwgj5EkYb6uvyruJombBPfTFpU5tvw3USNWrrdKDdCa1IVF?=
 =?iso-8859-1?Q?jHeekzb/3aTjRgyAN9APfMS3JzKH5kWcKX+Pm5JE6Apo/D7S47NZygoviG?=
 =?iso-8859-1?Q?K9yzu9sRJChhOD3Hgqp0zrbslJcf/EaRYi5AW2Z/4soN9wgZkiUxLJR5zd?=
 =?iso-8859-1?Q?hQapLH9/d6xJ9lQtbdjNP8abTv4tpHXKXqT/E9NPLqsEcma95uhn+SBqgZ?=
 =?iso-8859-1?Q?6+KNSsF8Ww=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Vr/C96vebmTEP36kr/XE9LL2uHoXPGKWNa/TXVtWgqNnqrZNWkfXjsBU+F6R5dIMs5kptUD80HUWZJWjy28FM/xZUqOmht36odFoKtadh5k6T0Cqy9dPwbQJWRCqh7IKVwxJmkXh0scJEo5+GviXDTNK57mTxgbvDbBerxjfgpii/EGCNvalASuVi2GxPidbSSK7D/jypKYaPTGrbhj5mJnuG1yLX+nTJitvvtu9ZjvE49T1fsLXDD9IFIps9HJF256K675tvmlx3z41FjH1Srxi9xGSPvx17X3hIF6g2E8WWUZ+UwOo/vKx2rBTECt0KPJVc1vN7DIgPDN/hVjn4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40868825-29b0-4a09-925f-08df0d771331
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 07:01:58.4016 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yUSFJx+GVwyIOdhkFD+begHPtS9YFHV0OQPpOmgE/rMsSUp2gzBAFRQ95l/WfrPGcq+/LR6aQBNOnyaDNWr+aNqHohkd557r3YQX9HcMslI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7061
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
>From: Cl=E9ment MATHIEU--DRIF <clement.mathieu--drif@bull.com>
>Subject: [PATCH v1] intel_iommu: Support concurrent page fault handling wi=
th PRI
>
>PRQ slot allocation must be thread safe to avoid posting multiple
>commands in the same slot so we take a lock in vtd_pri_request_page.
>
>This allows multiple devices to call the page request interface
>of the same iommu instance.

Aren't these devices' emulations serialized by BQL?

>
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
>---
> hw/i386/intel_iommu.c | 91 +++++++++++++++++++++++++++----------------
> 1 file changed, 57 insertions(+), 34 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index 9f21622a4f..350d2b7753 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -3627,15 +3627,26 @@ static void vtd_handle_iectl_write(IntelIOMMUState
>*s)
>
> static void vtd_handle_prs_write(IntelIOMMUState *s)
> {
>-    uint32_t prs =3D vtd_get_long_raw(s, DMAR_PRS_REG);
>+    uint32_t prs;
>+
>+    vtd_iommu_lock(s);
>+
>+    prs =3D vtd_get_long_raw(s, DMAR_PRS_REG);
>     if (!(prs & VTD_PR_STATUS_PPR) && !(prs & VTD_PR_STATUS_PRO)) {
>         vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
>     }
>+
>+    vtd_iommu_unlock(s);
> }
>
> static void vtd_handle_pectl_write(IntelIOMMUState *s)
> {
>-    uint32_t pectl =3D vtd_get_long_raw(s, DMAR_PECTL_REG);
>+    uint32_t pectl;
>+
>+    vtd_iommu_lock(s);
>+
>+    pectl =3D vtd_get_long_raw(s, DMAR_PECTL_REG);
>+
>     if ((pectl & VTD_PR_PECTL_IP) && !(pectl & VTD_PR_PECTL_IM)) {
>         /*
>          * If IP field was 1 when software clears the IM field,
>@@ -3644,6 +3655,8 @@ static void vtd_handle_pectl_write(IntelIOMMUState
>*s)
>         vtd_set_clear_mask_long(s, DMAR_PECTL_REG, VTD_PR_PECTL_IP, 0);
>         vtd_generate_interrupt(s, DMAR_PEADDR_REG, DMAR_PEDATA_REG);
>     }
>+
>+    vtd_iommu_unlock(s);
> }
>
> static uint64_t vtd_mem_read(void *opaque, hwaddr addr, unsigned size)
>@@ -5378,19 +5391,18 @@ static int vtd_pri_request_page(PCIBus *bus, void
>*opaque, int devfn,
> {
>     IntelIOMMUState *s =3D opaque;
>     VTDAddressSpace *vtd_as;
>+    uint64_t queue_addr_reg;
>+    uint64_t queue_tail_offset_reg;
>+    uint64_t new_queue_tail_offset;
>+    uint64_t queue_head_offset_reg;
>+    hwaddr queue_tail;
>+    uint32_t old_pr_status;
>+    uint16_t sid;
>+    VTDPRDesc desc;
>+    int ret =3D 0;
>
>     vtd_as =3D vtd_find_add_as(s, bus, devfn, pasid);
>-
>-    uint64_t queue_addr_reg =3D vtd_get_quad(s, DMAR_PQA_REG);
>-    uint64_t queue_tail_offset_reg =3D vtd_get_quad(s, DMAR_PQT_REG);
>-    uint64_t new_queue_tail_offset =3D (
>-                                (queue_tail_offset_reg + VTD_PQA_ENTRY_SI=
ZE) %
>-                                (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
>-    uint64_t queue_head_offset_reg =3D vtd_get_quad(s, DMAR_PQH_REG);
>-    hwaddr queue_tail =3D (queue_addr_reg & VTD_PQA_ADDR) +
>queue_tail_offset_reg;
>-    uint32_t old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
>-    uint16_t sid =3D PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devf=
n);
>-    VTDPRDesc desc;
>+    sid =3D PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn);
>
>     if (!(s->ecap & VTD_ECAP_PRS)) {
>         return -EPERM;
>@@ -5414,52 +5426,63 @@ static int vtd_pri_request_page(PCIBus *bus, void
>*opaque, int devfn,
>         return -EPERM;
>     }
>
>+    /* Prepare the descriptor */
>+    desc.lo =3D VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
>+              VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
>+    desc.hi =3D VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
>+              VTD_PRD_LPIG(lpig) | VTD_PRD_PRGI(prgi) | VTD_PRD_ADDR(addr=
);
>+
>+    desc.lo =3D cpu_to_le64(desc.lo);
>+    desc.hi =3D cpu_to_le64(desc.hi);
>+
>+    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
>+        return -EINVAL;
>+    }
>+
>+    vtd_iommu_lock(s);
>+
>+    queue_addr_reg =3D vtd_get_quad(s, DMAR_PQA_REG);
>+    queue_tail_offset_reg =3D vtd_get_quad(s, DMAR_PQT_REG);
>+    new_queue_tail_offset =3D ((queue_tail_offset_reg + VTD_PQA_ENTRY_SIZ=
E) %
>+                            (vtd_prq_size(s) * VTD_PQA_ENTRY_SIZE));
>+    queue_head_offset_reg =3D vtd_get_quad(s, DMAR_PQH_REG);
>+    queue_tail =3D (queue_addr_reg & VTD_PQA_ADDR) + queue_tail_offset_re=
g;
>+    old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
>+
>     if (old_pr_status & VTD_PR_STATUS_PRO) {
>         /*
>          * No action is taken by hardware to report a fault
>          * or generate an event
>          */
>-        return -ENOSPC;
>+        ret =3D -ENOSPC;
>+        goto out;
>     }
>
>     /* Check for overflow */
>     if (new_queue_tail_offset =3D=3D queue_head_offset_reg) {
>         vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PRO);
>         vtd_generate_page_request_event(s, old_pr_status);
>-        return -ENOSPC;
>-    }
>-
>-    if (vtd_pri_perform_implicit_invalidation(vtd_as, addr)) {
>-        return -EINVAL;
>+        ret =3D -ENOSPC;
>+        goto out;
>     }
>
>-    desc.lo =3D VTD_PRD_TYPE | VTD_PRD_PP(true) | VTD_PRD_RID(sid) |
>-              VTD_PRD_PASID(vtd_as->pasid) | VTD_PRD_PMR(priv_req);
>-    desc.hi =3D VTD_PRD_RDR(is_read) | VTD_PRD_WRR(is_write) |
>-              VTD_PRD_LPIG(lpig) | VTD_PRD_PRGI(prgi) | VTD_PRD_ADDR(addr=
);
>-
>-    desc.lo =3D cpu_to_le64(desc.lo);
>-    desc.hi =3D cpu_to_le64(desc.hi);
>     if (dma_memory_write(&address_space_memory, queue_tail, &desc,
>sizeof(desc),
>                          MEMTXATTRS_UNSPECIFIED)) {
>         error_report_once("IO error, the PQ tail cannot be updated");
>-        return -EIO;
>+        ret =3D -EIO;
>+        goto out;
>     }
>
>     /* increment the tail register and set the pending request bit */
>     vtd_set_quad(s, DMAR_PQT_REG, new_queue_tail_offset);
>-    /*
>-     * read status again so that the kernel does not miss a request.
>-     * in some cases, we can trigger an unecessary interrupt but this str=
ategy
>-     * drastically improves performance as we don't need to take a lock.
>-     */
>-    old_pr_status =3D vtd_get_long(s, DMAR_PRS_REG);
>     if (!(old_pr_status & VTD_PR_STATUS_PPR)) {
>         vtd_set_clear_mask_long(s, DMAR_PRS_REG, 0, VTD_PR_STATUS_PPR);
>         vtd_generate_page_request_event(s, old_pr_status);
>     }
>
>-    return 0;
>+out:
>+    vtd_iommu_unlock(s);
>+    return ret;
> }
>
> static void vtd_init_iotlb_notifier(PCIBus *bus, void *opaque, int devfn,
>--
>2.54.0

