Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8484EC282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trU7n-0006zh-PT; Sun, 09 Mar 2025 23:48:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1trU7k-0006zR-Sh
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:48:17 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1trU7i-0001zS-9N
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 23:48:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1741578494; x=1773114494;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=VTfIPq1wQ3iEWq2lFaDA/Q99+0lqzh7A6u6sEE2YkxA=;
 b=V0VemZ+kCesa6cFKJXDqeiqnJTBW1OO0e7cWJcL32pGkvmrn0Us4Zd1R
 3grpK5LGnKOoo+2neN5ar/dtOHaIbLA/muPNAW9tDaL7Cj+oSD7M9IYUd
 bwC8+NOWwcLYy0f83+KV2afLJhFdjgVTHCYg+SyjHI3eio2Pb2O92MwPH
 PnOdC1gPcWVbWGIr2yJuwUiznZMN0qk8eSRlxzSYhCv9u9eigzdRCMkog
 zx75o7I8RwDuVGK3/USZ2U3x2fN59MxV766foFM6UAIvG99wUPrDi65bs
 GwetwOCrV39FJG3o/c560LDyGPT/YuSqEOQb/P0q+1D1pJxuZ1sQ6GePd g==;
X-CSE-ConnectionGUID: 8uG5Q9HiRjqbQbzVCaVW5w==
X-CSE-MsgGUID: ZiKMBqeFSuCYcVekjQi//w==
X-IronPort-AV: E=McAfee;i="6700,10204,11368"; a="41807473"
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="41807473"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2025 20:48:10 -0700
X-CSE-ConnectionGUID: Ft8Ye/idSICgTLIgab8ocQ==
X-CSE-MsgGUID: m57ND30GR56NdFJS6ZxEzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,235,1736841600"; d="scan'208";a="120592113"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2025 20:48:10 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Mar 2025 20:48:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 9 Mar 2025 20:48:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 9 Mar 2025 20:48:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eNTdM2m1djNuv4pKcKEc8PkfulU9b8huCON6jarQ5f3C5MDefqwIvU1udgqzf5PI602BiU8PJA46HButlKUVX9W2Ml5kCxt2gT4kW28qo7iNqi0W9EdlZeKv+LqZTctweq7/28RmzJyJjY52ejlz8Mb1HU/rfEMS1PNa9a29kZ/OzXzihknpXJuoE/YZOz9ni+bNxGKK8HQ1vlKO6B4fZ1JLnB/LdPstQhsdifnF9w44I03JLWDNxeN2I37MFBIYLMgDyBlE+J+XeHOvYkEye0yyctRTjV/X9hr/ypGf0s7PUpHgnvXORObZ5yJ2YpfnAHatdBxYylypxQui+ay6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYteMPfDMjrGXi88HfwrMCKF4NkbOdO2jvgxj7IhGBo=;
 b=FzHXsWZxOVn30joOGJacdaGK0RddvNhEQY0jSAv0jCRKoVZjJt1OajbCmz/4U863l2BZOfHCHBGy7cAkwf4jdvo4QFI4u69nkwBG7eD6KqKzv5UOcnniXmyyv/wkz39x8RCGYDTX7ba1KIHTbsLSY//FoSosN+q8qN8EhqNvO+Rofza0hENOq4c+tV51K3XPxbOa+0kiQ1zg2mPSV738fOKpg93EjBnf6+8QAdf3vXd1wA+Jsy2bdqxp3F9H6V/pY4sJ5r+jq1f1s2M+akyoXfrLolc4jbTAbcLizOrJeEK9AmQ66JXJ2BFb4BQYsVQ1K3nJGgdy2xVsHVNSdbGvRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8675.namprd11.prod.outlook.com (2603:10b6:408:219::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 03:48:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 03:48:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Thread-Topic: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Thread-Index: AQHbgqf/y3kUuFg+M0ycDVxMwbFI87NQiOIAgApqj5CAC2jGgIAAPw2AgAU2Q9A=
Date: Mon, 10 Mar 2025 03:48:04 +0000
Message-ID: <SJ0PR11MB67449C1019C0BA862A66AC2A92D62@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-7-zhenzhong.duan@intel.com>
 <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
 <SJ0PR11MB6744FAC917F2DF9A7BF9FF9992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <0ccbf699-e6be-4936-89f7-b4f69672516f@redhat.com>
 <Z8n7TwzKoLvl5XGF@Asurada-Nvidia>
In-Reply-To: <Z8n7TwzKoLvl5XGF@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8675:EE_
x-ms-office365-filtering-correlation-id: 34dadf92-2413-487e-6cae-08dd5f865d35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?W1Hiix5RqM75S9UpJ8xA5JjFrJhAgTLNzXSImqa0R7cBSdKEbDOmNzG3bBPL?=
 =?us-ascii?Q?fdSU1s/e17gktyzmGZJXiwzkZURqN5W4m2lMDkydK+Riav9BBTfM6U17WdtX?=
 =?us-ascii?Q?1rSgISgc+15NhO5RqFfQmM2WZCFRZfE2+kjZS7VkuPm/Y2FVaIaxHJ3a09Kd?=
 =?us-ascii?Q?vD7nEFenGnUupsvwmqy1iO+jy3HUHbmxhSLtYIm0a92iNAcwh+sPI5KXypi7?=
 =?us-ascii?Q?CjMaNOL32b0a3NdqporZjGEQt3YNRORyyBA3WdUpIZoiLLR6eBCvUnEZNyIj?=
 =?us-ascii?Q?Pd4c4XAWArXqUZuZ3jZpt+WiyGg8zmweHmAjO2u68FDw+lTRvPwjD55D4g15?=
 =?us-ascii?Q?bktcVpEDxECCd9L9cAnDqktFFYKqoUglMswD3XjiZ1Rtoa7Qt/SKmUpXXy//?=
 =?us-ascii?Q?3aR+GQ9XrUfdyD7vsuyLlEQT2WlWLOQiGcH02HV0r+ImTusYChnd5kbl6I1q?=
 =?us-ascii?Q?gDyei8DUZhO9muxIMZ7ZK1Km0JP+fPglgi1rNY1wje03Nygfmz6j9aJZrC1m?=
 =?us-ascii?Q?KLV0xEfDjndIRWspzjSaGX1jcmcm/Upt5kjP5Ie95iYGPuZd0fJyvVwzQwVK?=
 =?us-ascii?Q?6BphTdjYne7kMAcl1uduoY19UVfMK29GPCLKMHiVkSKPSIQUJCKub+7uG5bG?=
 =?us-ascii?Q?W5KB3ENCUclqUWOOMZibv/T43A3y+DQj6lep/EYW8W0xWbiTtZholbH66fT6?=
 =?us-ascii?Q?YO4SGzbFlqvbNl/eTa5ESb9c7QfMO+6rQTACdFgdwBC7B5x58+C7heemgc5U?=
 =?us-ascii?Q?mF/gk9f4c4Kq+1+ATgaRK0gOSnlpb+Z8kMUOJSJaeF1yUiSSzqgNZFAeC+kk?=
 =?us-ascii?Q?GAMy3IGrmgdJMiuoJvJ5Jx+W2a6xjcFj+Tm9cqq3HSBjj8TVP3xTjduG8awi?=
 =?us-ascii?Q?qSj4GrzuyvyQ8G23QlXNHFyxa7NeiMCt7B5aGL9F1NnudlJAfOqFDcP/2BMb?=
 =?us-ascii?Q?zq0kYcL1KWyU3mLB3T0iPtA3QkFGs8sVSjQ9gnQR36JR5d+Rpb4i7YLUTk+l?=
 =?us-ascii?Q?LIgcCYasth9/u5bflaqhNkitQHYIMqE4+AyGHKNoZgYRG+4Iopy/YB3RTuW1?=
 =?us-ascii?Q?CwuQ3BuhgGtoWvwCBNHddE4ysu4oRhs0vIDLIpuyYIfSbSQFXs3sToIxzzQz?=
 =?us-ascii?Q?WEm7JpkN+U7kzGd2pSK+kSPeRpOlcr1WEl/OhYm7RBIPsQrGXxij2tCfutzO?=
 =?us-ascii?Q?Er09fWSNqP5ip59w4LbFhEMKR1uSQ2BQt6Xw0YQZQp0Xofes5mS0wn/PBz/6?=
 =?us-ascii?Q?1ONaJQ2wivPEEkWs+YSsRAU95C+GX44mFXa8Jp9XRdKQq2O0Ek+DyaX4fYgO?=
 =?us-ascii?Q?n3II8hyNER1qn6QeorXcQk40Jeefb9+JKxNsomiUBOwVDU1V8ikfJ33v6n6x?=
 =?us-ascii?Q?5z6pJx80qzJLAWih9kqyizBuSshYkPLm/v52nNNwpd2URC8sjcvxZPKXvkrR?=
 =?us-ascii?Q?Q1eQ6E+xofs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uPLfIofpZCYWt/X/0zODIRacDx00W59WEknkCnaaoZoAdaa4sczl8csS3O6Z?=
 =?us-ascii?Q?958++iA+5HmlCgtYk8rvCqqaayRkdvHp6uinrnfRUJ3MJuJiWMq2jyVZyKOO?=
 =?us-ascii?Q?5LsMCVWR4p5aOLw11PcvgF238ulzZO0Rkp5Q7LyfYUCkrH9i0wzjLbP2wAyg?=
 =?us-ascii?Q?ztd65Il1mPKpXE9PN2nhf/tYOj0w/n+cdWEodFZD/28upTpYyVzOfOh1i/jW?=
 =?us-ascii?Q?2RULNQuol9pGZxpA2JWp/iEIT3VHz1vKhDsMTf+ET2pbDV8D/guI38RnEjhN?=
 =?us-ascii?Q?opMuuGPJnRStjLuHkql3mRuIKVufrLc/Z9AJjKShEdDeoxC5BPr4i5iRV97i?=
 =?us-ascii?Q?cavJKbbuCOhRsq789qLNM5Xr8eX95pm96qJREuqDxB8v1R0TKD007qRlx3jL?=
 =?us-ascii?Q?a3VoEiSmiQrLM0ELQiCAQNMEa75CLgUNn9cVanjUgngNVyPUujV8DgBZpLzL?=
 =?us-ascii?Q?DCTeRdcs8ldu4Xt2/zO0HSNGJj9F5Kky/efFsPeyTgi5LEXAlJXHZpdcfaoe?=
 =?us-ascii?Q?dI+rWVAOI+0Am6kAbIchLpRXBZdYor0j34w+tkWPGOpYNcWZxs4UshRjVuxo?=
 =?us-ascii?Q?NbC8HQNFyIB648WIAxq3pAnydjnHs65XmY1lHo+PvkSRq2y8BEr8z6NW+3Qj?=
 =?us-ascii?Q?e/CfgIlvpqgPyA3ocoNq+A8M20y9jmYzLxBHIrfddBUh5Yx+SeNUWhXaY0Wn?=
 =?us-ascii?Q?HGhQMYw8z1UqU4cWoZ+saNbfLqdY1MOJREbGH/tnx+1pyx/crOxLinchWaYH?=
 =?us-ascii?Q?3l4NYzMyHO7Y4YJZG3lDYIZDFiKgoz6sAiMv5mKRuN5ttc9+h9Ofbv8THDvt?=
 =?us-ascii?Q?X42mh+zoV8EKyGOWHMYDvbGbDENvFE+fKjohofZxdc0cJcB2TJeQ0wTWG4Kg?=
 =?us-ascii?Q?APxL2t7hBBoPDjoQahkgBnT90oyXWf8L+iKMIOwlk5odkxmEoZDrdVrhXx5T?=
 =?us-ascii?Q?ztA43T93TCRuQwX2GHoRtpflNDTLg2IYd9JSegnToLLGjZN0RpD54Us5eRF0?=
 =?us-ascii?Q?BjVZ4gnHu9GhcxDH9KDscWZbiMmGZ6nH9LLmby7Fpq/rCSygUcz4anb1I4m0?=
 =?us-ascii?Q?dczLopE4r03eg+u4wjleoBT/3DxwiravC/3+Hy30iI40iXQl6zX2jF5KOhVj?=
 =?us-ascii?Q?DCu/8p3IuE4FQj35MNhcprLqSYpr9DSVKAXIjA4tt1YxXKPRnIRZeOv13mmu?=
 =?us-ascii?Q?LOTy60EuXyiHl/ynIcKlWovd3FRAoojTGxJUZ0P3a0k8uT0LH+UU3mSp9pLr?=
 =?us-ascii?Q?fOug2PmVcWr4ngr1B6iQL5AfJ6sUTtecNcIX1TugqMFKoUexMp4K51KVrfA2?=
 =?us-ascii?Q?r8K/R7Y9CHv1hMe1JNDihy6Ms0sC0hMMxCq4rTs3+410xergmFglbxXMFVlq?=
 =?us-ascii?Q?qFtUD+dgQ9/WYOu5n1+z4fPDZDqnzdIEzuIpSveWBoniGiX32GQTnIOWr49K?=
 =?us-ascii?Q?3iszwMcTgCeJ2vL8MLH6HEB7hRWehWca3sNE8QhwfbTqxQhnH7OTPrUySd7I?=
 =?us-ascii?Q?36C9NKJfE2UWd2fyWPn2HU5ZIDd03YV6rE15I0WBSzAPi0FdM6M/XvtNdhUT?=
 =?us-ascii?Q?m7uWo13WNQJVDyyEHVGGcV59DvenCdFqKKzS5HDK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34dadf92-2413-487e-6cae-08dd5f865d35
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 03:48:04.9987 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZTLJ/JQDML5wyn4zdoYoHaJa7C0e8QMD8X+P69015QtdDCmvv2Y11/C9QivKqJuvRLjUngeNqdTt4l0ID/3njXceMDZ4QLIEIwrPdvwSF/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8675
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
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

Hi Eric, Nicolin,

>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
>capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>
>On Thu, Mar 06, 2025 at 04:59:39PM +0100, Eric Auger wrote:
>> >>> +++ b/include/system/host_iommu_device.h
>> >>> @@ -22,10 +22,16 @@
>> >>>   *
>> >>>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this
>> >> represents
>> >>>   *           the @out_capabilities value returned from
>IOMMU_GET_HW_INFO
>> >> ioctl)
>> >>> + *
>> >>> + * @nesting: nesting page table support.
>> >>> + *
>> >>> + * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
>> >>>   */
>> >>>  typedef struct HostIOMMUDeviceCaps {
>> >>>      uint32_t type;
>> >>>      uint64_t hw_caps;
>> >>> +    bool nesting;
>> >>> +    bool fs1gp;
>> >> this looks quite vtd specific, isn't it? Shouldn't we hide this is a
>> >> vendor specific cap struct?
>> > Yes? I guess ARM hw could also provide nesting support at least
>> > There are some reasons I perfer a flatten struct even if some
>> > Elements may be vendor specific.
>> > 1. If a vendor doesn't support an capability for other vendor,
>> > corresponding element should be zero by default.
>> > 2. An element vendor specific may become generic in future
>> > and we don't need to update the structure when that happens.
>> > 3. vIOMMU calls get_cap() to query if a capability is supported,
>> > so a vIOMMU never query a vendor specific capability it doesn't
>> > recognize. Even if that happens, zero is returned hinting no support.
>> I will let others comment but in general this is frown upon and unions
>> are prefered at least.
>
>Yea, it feels odd to me that we stuff vendor specific thing in
>the public structure.
>
>It's okay if we want to store in HostIOMMUDeviceCaps the vendor
>specific data pointer (opaque), just for convenience.
>
>I think we can have another PCIIOMMUOps op for vendor code to
>run iommufd_backend_get_device_info() that returns the hw_caps
>for the core code to read.
>
>Or perhaps the vendor code can just return a HWPT directly? If
>IOMMU_HW_CAP_DIRTY_TRACKING is set in the hw_caps, the vendor
>code can allocate a HWPT for that. And if vendor code detects
>the "nesting" cap in vendor struct, then return a nest_parent
>HWPT. And returning NULL can let core code allocate a default
>HWPT (or just attach the device to IOAS for auto domain/hwpt).
>
>I am also hoping that this can handle a shared S2 nest_parent
>HWPT case. Could the core container structure or so store the
>HWPT?

Thanks for your suggestions. It is becoming clear for me.
I'll update the code and send a new version after I finish a higher
priority work in my company.

Thanks
Zhenzhong

