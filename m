Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE515C3DA5D
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 05:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVlMw-0003sr-QY; Mon, 22 Jul 2024 01:13:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlMt-0003sJ-Gt
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:13:51 -0400
Received: from mgamail.intel.com ([192.198.163.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sVlMr-0004Ty-8D
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 01:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721625229; x=1753161229;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oIIvxjLCBFiT4BCyagF15O7PyO7ROPaTiF1FitBzyAo=;
 b=WoBFupVzs4iurfMw4UvFC8ieQtt8+Ff5gqfPFBADKl/8FQULAU+F10+f
 YCU7qFcR0KWARXBPdvW9lHGoN2VhkDvsgtOJchjUTxZka77KRf1brTW/i
 ojwfdReqDQx483uitCuzI7VpVk7vkZgB+WrRCe7Yv6bSyvMQrj5JZGca8
 no09l3BSQ61OSGrJMIL3cDNs/PKDuJsP079qs6ku+fzGS0fWMfKuN+URF
 F3vk4Uy6/RalT56ytvUaRsYADxVwI2tJ7mMRlU9kKcxV5JKpASPnPJDna
 /Ve0mGyBqYkuDoI2GN670BIQPFpVWZkGvI9NM3rPBeU+yckbWQp7L+8Pd w==;
X-CSE-ConnectionGUID: 8wH1mUBlRn2PvBqlT94+eA==
X-CSE-MsgGUID: CorLYwJgTuWBsFoigbyzuA==
X-IronPort-AV: E=McAfee;i="6700,10204,11140"; a="18792130"
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="18792130"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jul 2024 22:13:44 -0700
X-CSE-ConnectionGUID: ScnFih6SRE+ayg87igZQbg==
X-CSE-MsgGUID: qM0+vPW3TgCUWkxca/ifbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,227,1716274800"; d="scan'208";a="74980837"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Jul 2024 22:13:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 22:13:44 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 22:13:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 21 Jul 2024 22:13:44 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 21 Jul 2024 22:13:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nqoOyoBuH3+4kiCGylpkyKJer1Iy7vkxPC88axak+G7CVvCqrNci2yaoFRFofNeInmvhslKqtxwD8WRM1TzZTt1VrhZ5ldrv4cO4tw7EQdfOF+PbxhSFEDqYPvyLUMCqtcfbBQlAwUDULCrWa0E2EC3u8QwGZ2cO1PmZlQpFUBLiCUCUVnuba9fOT243G07m+Dyqpmm9GIH5Z7VgekWeSxEX8zFELIY4VLjCPhE90645bHOyO0PSfkhUX5Q2dLeWh/AMND3lwGM9E1x72yvcLE9cvkmN5+eBK8PkVtOii6KP5+v+erbp4Qi3wLBWVCsaMK0+Wjr+Vk+NX7zeX0gZWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vamYxuvnTRSki9bJpFOL6NMhb4ZmeTHnN7DoK18MX2k=;
 b=uLk1C7wOOjY9S21kc9bu083e3uUvhbNRlUJQ0ENPayQYoxztNWWFTpNNXv+ReqVhfVAeIRlJMdnjrFw61ZXz662IP/zFe0RZ233FO+RtPwtCPXzkUFERMxiU6LTzWlQLT6OLL0MeGI0gzrVvhcvwd4OD8Ik4Kwlt+D/zxLcO9XTjezviPealpJ7kQJzowoaUJIk3lx4ctSXBlYAzXnBNZ8i8OLtRBz29Uxiw4ODxT3ROqQoRQ47QiAfe9w7zTN2fQKFf8cwNUtoFnMPj2gpxAuYer6Ga+6Eb4uLuHslFos2sMOdHEfbaOMZ1ZcJh3oYLCctHD+op89qEm2Fmruehog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB7527.namprd11.prod.outlook.com (2603:10b6:806:314::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 22 Jul
 2024 05:13:41 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 05:13:41 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v5 01/13] vfio/pci: Extract mdev check into an helper
Thread-Topic: [PATCH v5 01/13] vfio/pci: Extract mdev check into an helper
Thread-Index: AQHa2dSxmto6W5vnHUm4SmrqoEmxFbICFzdQ
Date: Mon, 22 Jul 2024 05:13:41 +0000
Message-ID: <SJ0PR11MB67445CAB5885F395E6C9396D92A82@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240719120501.81279-1-joao.m.martins@oracle.com>
 <20240719120501.81279-2-joao.m.martins@oracle.com>
In-Reply-To: <20240719120501.81279-2-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB7527:EE_
x-ms-office365-filtering-correlation-id: 54f21ddd-7fcf-458d-07c5-08dcaa0d0d60
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?DjXrIQH+vWKw6Zf7qT1i7xymSwTz1CaD2+hdT4xBkGWFgHN4sWXGdhyzRzl3?=
 =?us-ascii?Q?7cRcG1QZmxPeZaIncyxHzlFQIUfPSQ1kp0UeORuAr6qu7x3RuBAc1fJuRwD3?=
 =?us-ascii?Q?Hg0y69EEZzYz4m2fU4aMe0A4pTuQ11RVimVR2WTVCbwmCxzuZ71qbhxjSJwQ?=
 =?us-ascii?Q?6CdxiKS9N0zwss2NHmAlMetV+nAlHrpeE1lgFnju2aZ8KIy+UL6BWGTynbYX?=
 =?us-ascii?Q?xek62c9B5x4pzx5tJbgL6lgaK6ZvTmU7NAKSzWOSJEwZLruoB+YF7G3CbRnX?=
 =?us-ascii?Q?ymDdxX5ZgGLnAoPNXEYHckOzVfQeMZtoP/iQeYqc0THGlV4cXmEi1CT8DLCM?=
 =?us-ascii?Q?ryNIbXdQP9DQlglFSCx0cMYehltktbQCPtk8tw+xQfZMWgSNFQ9Nj4jhuW/Q?=
 =?us-ascii?Q?HzB30Wbw6HLb0AI46kzNwJRYm+bRCiJDdnErt0GF6yU/hMHGVyOC7vw/2XLB?=
 =?us-ascii?Q?0+90/xBg8BvCkie3OPTgOaVL/jk0zFCIlPvtESfLH0BOoyKcZfCDV458/rm6?=
 =?us-ascii?Q?931MYTew+/KM2/VMIoD/fK2s3DGdYdQ7a+6HzdqnlNEcYRUla1GIX8OYDyK0?=
 =?us-ascii?Q?t148QdRBsIaQa8ccrAHU87fv9iJqyq/fHbk6ESWzhV8VrEcM4vSV5fG6GDS8?=
 =?us-ascii?Q?5yeWCUDe96MpoxIj2ect/9hDJIvxOBFrUyj8/PmTvsKsCHhER5qisNTc02BJ?=
 =?us-ascii?Q?6BoS2bb+zI75yaydDw0kyfe5MdQn7gZ8X1uYrGdp7zr+VyJbSkASCUoO191B?=
 =?us-ascii?Q?sVwKV59Gc4M5D2Q0AhPwEui4BhKfQ64IcLeA0Q1VhHXttUULD9oZFxgXEESY?=
 =?us-ascii?Q?+Fq/vb6Y5UvjmlotVpajM1v3FO10NYy7mwwIqFWs2XRCad/4ddtNUffQGZL8?=
 =?us-ascii?Q?5gm/KXxYgRXONtyC1Quk3/CGURPmlszSlT2VcSESWQkp0B1MLqBZB5OYyeH3?=
 =?us-ascii?Q?ly/eBRc8gLZhzZfAcBmOq01dnoVrpeQNzR/rDRy8bjuanLNhTkY7tpafntpY?=
 =?us-ascii?Q?Q7IDrstgUNl+P3U8pWRlHWRInVIwIvepbk7gCja7htwyEPTnPW680hug8Cr5?=
 =?us-ascii?Q?CxxL9+SmGWDXt1+jRPg7/k76erb/HNmRncNoxpMVU02Sg/xodGhUeD/TfX1n?=
 =?us-ascii?Q?rIU/QJENMOUo5H6tw/QslX5tIIwN4kLmcDgUSZ2c7v1XMGYHrakE0qizdnFV?=
 =?us-ascii?Q?aKHhDCDRFMEvmzgt2IT3O4GLzBhvjxqrN6hCNsu8F1fhiWT4MbPg13lmZnnJ?=
 =?us-ascii?Q?fkRa+KG9xl2Tzyy+AoXT6GhLKAwo3mMrNJCquhbTHFbMD6mQ326WpQPNl20l?=
 =?us-ascii?Q?mFUdPVb5RGcQlmxZCtMN1MjVYolMtvcgpr1x56veF3fGY9jtr2leUS3Zx2Eq?=
 =?us-ascii?Q?w26DsaFN8OHC5XKCH5Zz56k1uDqSYZGIZnBK9ZY+8/Y1gc1aPQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2IJddNEt+FB2UIsBCEzjajEBNYZig9Mj3lUM8bXYJ1ytKmICNFjBTrHLe9Gx?=
 =?us-ascii?Q?LE1D2IBRXBAqtcKCaGaoxT2hHqRdsr69OE8/qCC5IdfvoSeG/I8sFPO3dz6W?=
 =?us-ascii?Q?IVeec1V5IOx/DXd2zN7OXOv9c9rQqFRpYhuJPrne3zVFA37K6D4E7qu5cXn8?=
 =?us-ascii?Q?2JmutNUrCylXffLnOaak5G2+1JC3G7emgz6Gkid+PWhvb/efPAGEOmTiuOIO?=
 =?us-ascii?Q?wJb1VXPjKk1N4j4j8/t3Pgqigh9QZoagyAMR2Ic+WPqf++1zj2+E4Y2nP9fg?=
 =?us-ascii?Q?F0QVs7y1TVj9YMGvzYxnrzz2UGVPmQI/NHYHy/USeUGCjDQPX2Jq4FpoiLxj?=
 =?us-ascii?Q?CW+YpaQqXtiq72rUfpli5lp8CuuGLFA15m+biSueQcFDcYtZ+XixikLZ5i40?=
 =?us-ascii?Q?LLNdei8Zb8LkN3FQ0Xy1mWefStyknFcYrSUUcWag6y1KKOiIYmnPnVkAqgEY?=
 =?us-ascii?Q?MSKPcYXMwQkHY57Gl3agrTVitkmH0jyjjDOUsSJEYvqVg7pw+MDPB/o5FMyl?=
 =?us-ascii?Q?8uXAFobdipNCYKDbsje+l6AyPeKUap4BRmC8gMwvN+macdNxWbNxy7E84C0b?=
 =?us-ascii?Q?QujaaJ5iJH/oJCp18pEIQxpFuEetzF7bAlCxs5vwPCX2dR+1vetcC22K2fQA?=
 =?us-ascii?Q?6akQ75aUVyRpkyN+qaPNzl1+p63x7LaUPZ6FyWucT1lFtcRl9lFp19TFbrj+?=
 =?us-ascii?Q?GrS2Zj5Vw2ZzvfDgaz50DnEPNuzmLNitDpd4aV/tnH+xQEgo+yB37ECk9fus?=
 =?us-ascii?Q?7TiLSTr3cQ0WGzbtXAGyLgd87A0A36KOFXRwhMoj+xHOdFF18tUwg37+mHcB?=
 =?us-ascii?Q?ejI4/s6KwJeTjeZ5kvLXt7ViNG/KWfqOQkbJmHOlFpQ+ovRHzbAfeQIpRV6t?=
 =?us-ascii?Q?9Q23bcgF8x0ExmD3Mj/ItdSUu3LS7Y3Y0kMtiQARZUvG8v65VzYCQywHh0Kw?=
 =?us-ascii?Q?YJGGuJyAxbv4xgqX1SGnAQ0aTTxwe05IPC8gsre3e67ZxE1p/F2yAjs/kHe9?=
 =?us-ascii?Q?vllsNVbvJbqNxcFUjC9/FJm3xc2wougDoNTN4VJecZE3cRk1YUZYY+wSfsyN?=
 =?us-ascii?Q?zKh+dzyMpZZAI1xVgE/twLZvhD5taHm9iqHedQVFqfhrDx04ZW52j3KlVEPn?=
 =?us-ascii?Q?LkwgE4QjaIulEM/Tc1GQOXwLZwnsym/ggEEUW5krBO5nCg4uMU2MbgUYw9n7?=
 =?us-ascii?Q?9pYf1WF2m3BYMXvk4yhPCGoqhpwm+N+X3TD1EcyppqVkCAqIOh2uGIujUX0m?=
 =?us-ascii?Q?fNy4vXJku2hia43uwFkm0ChD6c0rUepMZqs5i3W4feDditxZ21e1gmeXRjZW?=
 =?us-ascii?Q?JZv838ADj9OL06dPemykCd4scfIBqqodOL12TICB9kqV8322yEzum528B+2K?=
 =?us-ascii?Q?3P0au+JQjD4i8ZE7CLLdvz0h+kz+GLrFDmbqOIvF4o/OzMUCv9XXwokA5s3W?=
 =?us-ascii?Q?OLU1ThhYp+lh4JnxBPCpD/3ShAUMcr2IvuUp0/RRZSGbgkx5OQMSHm2OKtA1?=
 =?us-ascii?Q?dI8xgHRelf6+6ck3EEpMDdR/oZBJgqZgmwxwa4MN5o6gUMOvn7pS+jEOdzii?=
 =?us-ascii?Q?Hpu5SFDEYglqYGyliwMszD6ZQjwrY6DPOq5mCXAS?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f21ddd-7fcf-458d-07c5-08dcaa0d0d60
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 05:13:41.5121 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q83CR4ekokL+fJYOp+C5DmTJTBgEjpX6S/Jd0dMBNgiJzzJQ610PH+eZL3xgdcsECOzbpqjHZSs79RaGDaBurmFENP41ovZg7Xu6R+s75uE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7527
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Sent: Friday, July 19, 2024 8:05 PM
>To: qemu-devel@nongnu.org
>Cc: Liu, Yi L <yi.l.liu@intel.com>; Eric Auger <eric.auger@redhat.com>; Du=
an,
>Zhenzhong <zhenzhong.duan@intel.com>; Alex Williamson
><alex.williamson@redhat.com>; Cedric Le Goater <clg@redhat.com>; Jason
>Gunthorpe <jgg@nvidia.com>; Avihai Horon <avihaih@nvidia.com>; Joao
>Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v5 01/13] vfio/pci: Extract mdev check into an helper
>
>In preparation to skip initialization of the HostIOMMUDevice for mdev,
>extract the checks that validate if a device is an mdev into helpers.
>
>A vfio_device_is_mdev() is created, and subsystems consult
>VFIODevice::mdev
>to check if it's mdev or not.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

>---
> include/hw/vfio/vfio-common.h |  2 ++
> hw/vfio/helpers.c             | 14 ++++++++++++++
> hw/vfio/pci.c                 | 12 +++---------
> 3 files changed, 19 insertions(+), 9 deletions(-)
>
>diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-
>common.h
>index e8ddf92bb185..98acae8c1c97 100644
>--- a/include/hw/vfio/vfio-common.h
>+++ b/include/hw/vfio/vfio-common.h
>@@ -116,6 +116,7 @@ typedef struct VFIODevice {
>     DeviceState *dev;
>     int fd;
>     int type;
>+    bool mdev;
>     bool reset_works;
>     bool needs_reset;
>     bool no_mmap;
>@@ -231,6 +232,7 @@ void vfio_region_exit(VFIORegion *region);
> void vfio_region_finalize(VFIORegion *region);
> void vfio_reset_handler(void *opaque);
> struct vfio_device_info *vfio_get_device_info(int fd);
>+bool vfio_device_is_mdev(VFIODevice *vbasedev);
> bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>                         AddressSpace *as, Error **errp);
> void vfio_detach_device(VFIODevice *vbasedev);
>diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>index b14edd46edc9..7e23e9080c9d 100644
>--- a/hw/vfio/helpers.c
>+++ b/hw/vfio/helpers.c
>@@ -675,3 +675,17 @@ int vfio_device_get_aw_bits(VFIODevice *vdev)
>
>     return HOST_IOMMU_DEVICE_CAP_AW_BITS_MAX;
> }
>+
>+bool vfio_device_is_mdev(VFIODevice *vbasedev)
>+{
>+    g_autofree char *subsys =3D NULL;
>+    g_autofree char *tmp =3D NULL;
>+
>+    if (!vbasedev->sysfsdev) {
>+        return false;
>+    }
>+
>+    tmp =3D g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
>+    subsys =3D realpath(tmp, NULL);
>+    return subsys && (strcmp(subsys, "/sys/bus/mdev") =3D=3D 0);
>+}
>diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>index e03d9f3ba546..b34e91468a53 100644
>--- a/hw/vfio/pci.c
>+++ b/hw/vfio/pci.c
>@@ -2963,12 +2963,9 @@ static void vfio_realize(PCIDevice *pdev, Error
>**errp)
>     ERRP_GUARD();
>     VFIOPCIDevice *vdev =3D VFIO_PCI(pdev);
>     VFIODevice *vbasedev =3D &vdev->vbasedev;
>-    char *subsys;
>     int i, ret;
>-    bool is_mdev;
>     char uuid[UUID_STR_LEN];
>     g_autofree char *name =3D NULL;
>-    g_autofree char *tmp =3D NULL;
>
>     if (vbasedev->fd < 0 && !vbasedev->sysfsdev) {
>         if (!(~vdev->host.domain || ~vdev->host.bus ||
>@@ -2997,14 +2994,11 @@ static void vfio_realize(PCIDevice *pdev, Error
>**errp)
>      * stays in sync with the active working set of the guest driver.  Pr=
event
>      * the x-balloon-allowed option unless this is minimally an mdev devi=
ce.
>      */
>-    tmp =3D g_strdup_printf("%s/subsystem", vbasedev->sysfsdev);
>-    subsys =3D realpath(tmp, NULL);
>-    is_mdev =3D subsys && (strcmp(subsys, "/sys/bus/mdev") =3D=3D 0);
>-    free(subsys);
>+    vbasedev->mdev =3D vfio_device_is_mdev(vbasedev);
>
>-    trace_vfio_mdev(vbasedev->name, is_mdev);
>+    trace_vfio_mdev(vbasedev->name, vbasedev->mdev);
>
>-    if (vbasedev->ram_block_discard_allowed && !is_mdev) {
>+    if (vbasedev->ram_block_discard_allowed && !vbasedev->mdev) {
>         error_setg(errp, "x-balloon-allowed only potentially compatible "
>                    "with mdev devices");
>         goto error;
>--
>2.17.2


