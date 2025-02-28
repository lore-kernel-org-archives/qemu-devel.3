Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A2C4C282C5
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvmp-0007si-SF; Fri, 28 Feb 2025 03:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvmm-0007sS-3n
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:31:56 -0500
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvmk-0002nI-8M
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:31:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740731514; x=1772267514;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=hV0AGt5A8Vj7epc61tOTsfgjl4H+gmh8TMI7Y4rfyw8=;
 b=aV5KLpe8CnkVH4EnY5t70tl7qSxaedY6fmzJHhMOQpCM3hmtF5FXP+us
 T4KqCq5rnR4idWlfa8e+ms8D7xYTTKelEn9rDTNzD46xsRRB+AHr3JQi2
 WYKjNMR+UNOOH3SmgkM+pbcmcT/pJ4Y8JioSOCplfMpjTNBUXruEo4HxB
 FuzSOdORgHfcNm8I9yFz3dwfFI3BozHWBIUc/Gp/EdujgLvYTFYR6ts7r
 aqq2wGhVJAsmZT1sMrS+4YqK0d1PSVXJIWTH8QibDJtsIpZD+OAPitzwU
 KIHFFAEaW1IadxSPxXHfNJ+lxtPJGuSBff4E88anHiArv8dFbuUiZVDQt Q==;
X-CSE-ConnectionGUID: /+Urr2QXRvyk75m+yVj09w==
X-CSE-MsgGUID: pnX/CZaDTiqATjb/iT6G6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="53064715"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="53064715"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:31:52 -0800
X-CSE-ConnectionGUID: 5Ld4fNB3SlK1tjNpUOAhJA==
X-CSE-MsgGUID: dHuL8DVUQRKZ70PQuJSonw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="117042818"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:31:52 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Feb 2025 00:31:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:31:51 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:31:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a+WQUPJlYmTrisbGovX00Mx9FR8mJCvfsRwXIru0R8FFkRkmEQbXuNtJnppZzscHxTUxTSNFswiqzybQuJo87e5S2gfYnG6rwMLCS7S+iW7etkWKFbnG6sy7shWm6mTMOmGQzOsPovuqCPFUuvrSrdNSNm9R+Kp0cnl/ywI0FSJbAYMk7SCBuAqxJro40lr7kneRc/j5nqgIXJMa62I1Z+cfgwtY4YQzTw7KU5OwrgPQvE/kgF3nXjVYqQCQ2gTEVPfajQjZo2uDGTEfpd0HuUeeQoG/w9Nvg4oYjneiOvx87gPuYrayNI1cJ1aZDzpGSvJ+aiX5wk4PiuQEjlK3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjQC6jRF5rYO01pU6SmpvriwlOW5uwiR5U16sS+mR9o=;
 b=YLcZXpwkWjOe4WoD/CPo+UcFuKTiFVHbVV1uyljfWwFiSx4azaTJnDvACWEDjjpmT4lpYbGsDJGaXtmIrOFor3IJ8QaxXZObZyJ2h9RRaDFCu/tWquNRT3hvI/Mzc65C4FloRSWZVr97m1qUZizgf7wuB1OJICJWuC7iQxLhJptgLn3vg2QTUaWrkKrI4EwnyhzEoozOCszftWRMr1dolhcv0cI+gk1tsj8+Quimit0FNmc5zFYBeQIGsCj1hNGkXoJ7BSlk64xUkwEWi/oR7VCWtJbFu/EP8MpdzahT1fb8DUCFtngiXwWWjypWsV+q2X/GBIksxurVe2FcRpz1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:31:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:31:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 08/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_ERRATA
Thread-Topic: [PATCH rfcv2 08/20] iommufd: Implement query of
 HOST_IOMMU_DEVICE_CAP_ERRATA
Thread-Index: AQHbgqgIViSTUyWlHEWiqFh6Ibkb5bNQjJOAgAppy1A=
Date: Fri, 28 Feb 2025 08:31:28 +0000
Message-ID: <SJ0PR11MB6744967CB7D6D5E30F57E0CE92CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-9-zhenzhong.duan@intel.com>
 <e114b3ce-f470-444c-8aef-cd89f42da93b@redhat.com>
In-Reply-To: <e114b3ce-f470-444c-8aef-cd89f42da93b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 76322f44-8bbd-459e-e70b-08dd57d24c0e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?+5Vf90pROJEkBLEnTz0JR+bo5YjLN2FVICyD3HJhpnDH2gVx5Ej0D2nJ3dDy?=
 =?us-ascii?Q?ht/xDsN34ZQ0kk1/4LY/xtV6cWlyTD6txkPpeWO8+REWg1qD2LSboho2W1je?=
 =?us-ascii?Q?w+703nERPNkY1oEJzAjV6z1MEuwwoc8MzG0G53Iapp20GPVuZSlWbG23QPEC?=
 =?us-ascii?Q?nar1eQTmSwPSR+YkjbHaSbDUwvJliwvF5IurLf+eZTQiuHlPFo3SF67Drou+?=
 =?us-ascii?Q?Z6TQNwEuWMW4d3CW76PEdMPv5ryqFpEYpUQpy3wfKN8QRDNWDR9LBVw5wd76?=
 =?us-ascii?Q?BGUD4I54nugEgWFTkD1cxRTsYW7FdrQQf9XMvyDEKVucbeY7dr/6Qf25FvsA?=
 =?us-ascii?Q?y12MCbocXd6L298syaS3T+BvfbsLPGydX6XQtatYWyL1BDCPzUI451yAYAs/?=
 =?us-ascii?Q?NFxwlDcVKlUCQhl0xslWTK3hlt1eIxfwEP+EhMoYCmqYeWyl/oZ4RWyNskz1?=
 =?us-ascii?Q?kc85P2q7aDfQCafIkUkGYH13vBv4sL0l/1tf8RImYD6zNvxxBXpn+uhAiMfe?=
 =?us-ascii?Q?Kfk7MeMyUmJNTrzk+OCoi3Rxm8OwBkOaozsAQTzRJP1wHtQmgOGWbmTtEUF/?=
 =?us-ascii?Q?ra8y/g8zwAaHYNdMQEtK5VOEo6V1UN0FooVWuDq/c5DvZlF7XPQqCLWmcp9e?=
 =?us-ascii?Q?J1kuajvfsJfSRpKgQMB+MTWuNaO/Njcm0Xia6zK0MTNg5Uqp+96uUodrMla2?=
 =?us-ascii?Q?OHqRcru/wBin7/UDjg6I8B2iVUxZJEa2pNCgFQrNq3N7lpdNAp2RcLowtKkc?=
 =?us-ascii?Q?46351iaWe3SqocM/Q9UgISiypT6Qnu+yMab21mnKkNmtIh0SjxvEA5QOcjfd?=
 =?us-ascii?Q?ihIhReLBxn76VuuUX6qLRja0769M4eRi3L4MqaXkrZP7NRxVNtAgVIPXCcLf?=
 =?us-ascii?Q?uiId1n9dKcPZ/wo2uer29xtSAfTljBJZRHX3I/YwP6S4uNMpDZk3YO0skPbr?=
 =?us-ascii?Q?Si7HVMA8BLDxnwa1KEbu6RznvxOH3uP/mIm7/YpVGBSCGedwJeHw1wqtAEO1?=
 =?us-ascii?Q?/HdnFXJhcL8Kee7Qlf096oqGK6NOOB7PPBVsupsAvn8hsN7KEiMUrAb1cHQn?=
 =?us-ascii?Q?/9ddhOvph9ceRSiuQNSYAaa3TuW/PmxzY3wl+/PZ2twa6sDiXgDmIbyULGpg?=
 =?us-ascii?Q?jzpA/PHpW54NFSLK0wcfs80TmDhvoW8zQSe6Hr1FY+N0s2tUoMHoFRl9Mbjo?=
 =?us-ascii?Q?XAqMAbjIdCKbfEeMu/KD6Otn4DBPuUhqRI5rn12lYQRbZdDQ7dDSVJxz012p?=
 =?us-ascii?Q?MuywRyMssuZMP03dKuabBnutLoNOQnK0ddRZVWGr7YaNeLLNq4WlEu+azsHx?=
 =?us-ascii?Q?f9Y1CspwPLioPdUh9+XOFgcIwfIZcA8jx7zrIjTSaYw5ni1tdwzWSk8aV23I?=
 =?us-ascii?Q?3Yf3Zq/C5TqNjeKwelxgYSaAUdeBY7A7BeipJhLMJLerNldMx6pCzwjYpm1z?=
 =?us-ascii?Q?8DXAlP1/vr9dVzGqkJBaYRAYJ4iIxjUF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JKwhNlwQr7rFmYrpG8QjNkhAOGmPhGNf/vu5Yt7NJJxuswDKcZAe4Tq2NLNU?=
 =?us-ascii?Q?hRahnTY+tO3zW0l4GrvW6+J8cjXnlRAf8XPa3AlEirDoAMHEslTCsTm/pHto?=
 =?us-ascii?Q?SntHkgloIfPM2qQCTsqS/450ROzEWxkHBsgxu7NrNClsUZ/CFONSWUkhJwy/?=
 =?us-ascii?Q?CqpHwZ8tmH9yThSqPEMBYLl1EHZmDAuGSsYG4KthmCHGecxvWc2HmdSfWrBo?=
 =?us-ascii?Q?UyMsyZasS5ejlcbnm9NeyQk7DSXXdKt1/uP81/rB0u6mAWKiTgM9Eauvzl6Z?=
 =?us-ascii?Q?uk4Qje/JEoPQ05GgOfK1VZN/UqrCpTN/5ZzXf6VgbGce0K5nGZXCdkJleGfA?=
 =?us-ascii?Q?xzlsd2FL8Y7I8Y0wt6GHNW0ddhon/TDGO/jFEfwlbzXTpP9K640PVgjozR9j?=
 =?us-ascii?Q?TbzwIPlerD0400lqpNH5BRgedJ5eN/nvzq65H7IrlISvdFzSrryxLmoiB/lK?=
 =?us-ascii?Q?9UOu9JzJTQ0gkSF5GcAf9Wyr7wOA1SKCWFGxIN3ZfKjoDMQdgQtdTHBjpc+0?=
 =?us-ascii?Q?Ox4Zz21Pyvse4rRqsdH44B45joNW0w565WlN4WJ6i7Adto5RuBgwRjFj0pM0?=
 =?us-ascii?Q?g1AMdvkZXNZyNvToxom+2LdovHq0XZV5w34lin+WFaDLMHQ8qPF5kQ2ek+iD?=
 =?us-ascii?Q?UCk0HaBaeAp0LrEVQT0+Js1OlDvZ9dwJ4dooLHiuJyoKzv8/xrVXsM6yTYAY?=
 =?us-ascii?Q?+DtOp1nDD3jSq7Q+FXHfkEexufI9JICNOsx4OgEGzDD/xLpxq5zPfHb0Qnx5?=
 =?us-ascii?Q?RoWraPNZVEKGaRIya0bXOKbXVg8wOYtT4ZB8z9u6pVWDtDaOqOD6fWPTATP+?=
 =?us-ascii?Q?64HBO5vDHv4XjLJy7ioGCL+ZvkimGpDUW9Kf5IHLNBHhBWdiYdpDW1nZne9U?=
 =?us-ascii?Q?ChKYBY376Ya+9PYVnsRjlNs5/KZBJsf4lQUo5+/c7kDLQ9QcMM238enwdKGE?=
 =?us-ascii?Q?SxmMZ8IdfmZWcYgYKgrp7nsHQXMVdR9dJLkR0E+t4x3hTxCGuGLZanqDdpcR?=
 =?us-ascii?Q?0jt2lnyyfbRLQOhCpiN0NUwGpoWTOFloHOfT1ptm2saUBs0dwCl2Zkef37AI?=
 =?us-ascii?Q?ydoERh+UBrzNS8LwaFsWkP9EUdxGgO3slRmeEn1rIOn4MsqzG/5CRmKVBrYm?=
 =?us-ascii?Q?6i04uKjBaeYKZ2rQTT5VnLqV18rEd5yJHa8Jx6Oc/bhQDC4qFqvGNLRb40fT?=
 =?us-ascii?Q?ivOWRSf+B+UEF65tg8vnb5uJJTW5iDo0T/xsDwOqtvfTv+oIeHUQd4hwASrt?=
 =?us-ascii?Q?u+KZd9y74u3j8FIJKs6Aedb0STCqdeNY2kWChkYVazgfIycrqcskXCBTJ2TH?=
 =?us-ascii?Q?NShztKEO1+md7kf72w5vsOjzM/DkPA22cQHwgJQAmzzZV2/LjWYShNPaoX6T?=
 =?us-ascii?Q?roKnjxrjw3f9yOIkp5/noQ4AzI8p5HCdxA2ApRVlAzTa6quaa0AYpUFpUoF7?=
 =?us-ascii?Q?RrDwQbstXRIdqPqnOx1Fj4g720Yi7jEEPe4Sm9Ly4BevHspGfJp/XNVoYyGS?=
 =?us-ascii?Q?DSJLnUoA3MFldrYjUNJhaiP/FDDtxfW6spvyWCja7Ck1EngifKAhFTk7/2bh?=
 =?us-ascii?Q?/diUOhuaVzZ1FKfwDStQ0fVaB0ffGGskwHpe0Ylm?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76322f44-8bbd-459e-e70b-08dd57d24c0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:31:28.6831 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3iilvcYPIq8ResRontiyu6GTeytsp8Cny4CEhvka6eePe/MYWXB5+Q87+5y3R3q0ZcKzG5F2WsronDzGi5jkCCWzjShTo5fE8eGvh60h1Jg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 08/20] iommufd: Implement query of
>HOST_IOMMU_DEVICE_CAP_ERRATA
>
>
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Implement query of HOST_IOMMU_DEVICE_CAP_ERRATA for IOMMUFD
>> backed host IOMMU device.
>>
>> Query on this capability is not supported for legacy backend
>> because there is no plan to support nesting with leacy backend
>legacy
>> backed host device.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/system/host_iommu_device.h | 2 ++
>>  backends/iommufd.c                 | 2 ++
>>  hw/vfio/iommufd.c                  | 1 +
>>  3 files changed, 5 insertions(+)
>>
>> diff --git a/include/system/host_iommu_device.h
>b/include/system/host_iommu_device.h
>> index 18f8b5e5cf..250600fc1d 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -32,6 +32,7 @@ typedef struct HostIOMMUDeviceCaps {
>>      uint64_t hw_caps;
>>      bool nesting;
>>      bool fs1gp;
>> +    uint32_t errata;
>to be consistent with the others yu may have introduced this alongside
>with the 2 others?
>This is also not usable by other IOMMUs.

Yes, this is vendor specific element. Will merge after confirm nesting and =
fs1gp
are vendor specific too.

Thanks
Zhenzhong

>
>Eric
>>  } HostIOMMUDeviceCaps;
>>
>>  #define TYPE_HOST_IOMMU_DEVICE "host-iommu-device"
>> @@ -130,6 +131,7 @@ struct HostIOMMUDeviceClass {
>>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS           1
>>  #define HOST_IOMMU_DEVICE_CAP_NESTING           2
>>  #define HOST_IOMMU_DEVICE_CAP_FS1GP             3
>> +#define HOST_IOMMU_DEVICE_CAP_ERRATA            4
>>
>>  #define HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX       64
>>  #endif
>> diff --git a/backends/iommufd.c b/backends/iommufd.c
>> index 0a1a40cbba..3c23caef96 100644
>> --- a/backends/iommufd.c
>> +++ b/backends/iommufd.c
>> @@ -374,6 +374,8 @@ static int hiod_iommufd_get_cap(HostIOMMUDevice
>*hiod, int cap, Error **errp)
>>          return caps->nesting;
>>      case HOST_IOMMU_DEVICE_CAP_FS1GP:
>>          return caps->fs1gp;
>> +    case HOST_IOMMU_DEVICE_CAP_ERRATA:
>> +        return caps->errata;
>>      default:
>>          error_setg(errp, "%s: unsupported capability %x", hiod->name, c=
ap);
>>          return -EINVAL;
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index df6a12d200..58bff030e1 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -848,6 +848,7 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>      case IOMMU_HW_INFO_TYPE_INTEL_VTD:
>>          caps->nesting =3D !!(data.vtd.ecap_reg & VTD_ECAP_NEST);
>>          caps->fs1gp =3D !!(data.vtd.cap_reg & VTD_CAP_FS1GP);
>> +        caps->errata =3D data.vtd.flags &
>IOMMU_HW_INFO_VTD_ERRATA_772415_SPR17;
>>          break;
>>      case IOMMU_HW_INFO_TYPE_ARM_SMMUV3:
>>      case IOMMU_HW_INFO_TYPE_NONE:


