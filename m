Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC130EF071C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 07:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpLnU-0007rr-Bl; Mon, 09 Feb 2026 02:35:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vpLnR-0007rX-SQ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:35:01 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vpLnP-0004I7-0u
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 02:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770622499; x=1802158499;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=KytTCziPYjX7dNi0+3lm6DLbAnMLxjzGEDq1HEJtRfU=;
 b=RYtUC8lYI3DFrMH1IrhXMr/8xnxmzlF5kzmEwPCNgejrtS9DAQtacUJh
 38G9S3L+Mym/uSDG15zpNxCIrfIgMcbOdWmChxiAP/LkA9gJxtR89blTr
 zpaaKFV1Y/qPNZ3iWz0pLyjc++sedfxxU/8/CXy8Nwio7kx5/9ZZ12EMF
 JDdanz64oes5SsTCuSi+kh9kqjOwzfYYH8bRuEHcccOR6Ns6XSL5OyeWx
 8u4ZB+slR8RepTNbkiZ/7eQPCL0dNHsgaaS+eAyS8JD8Jt9MXKAdNDclh
 p09exUvqq1A+Zj249BAJ//nXj24asZLlNFtUSQzRoBR2VjDI/JMZbG/vX A==;
X-CSE-ConnectionGUID: 8S7/WtDIS/ih47oYYESg5A==
X-CSE-MsgGUID: c9+iaN3oTWSMd6P1O3cXHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="71912149"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; d="scan'208";a="71912149"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2026 23:34:54 -0800
X-CSE-ConnectionGUID: 49r/i0SGQDK0wV+7ZiH5DQ==
X-CSE-MsgGUID: x2cZFXpGTFibjdeqHsDPag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; d="scan'208";a="242134885"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2026 23:34:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:34:53 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 23:34:53 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 23:34:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=frcYY4TIvT5Q8X3hpyAW3iu26yimV2KQWa7gFdUpglRgAsLXbtZbTDxWmwcYnndFRt5RpYio8eRpC5FgTU6vFskteQE6MS8jGWzyHT3mBux7MnQEUKqDGZsRqGLgf4ne7WoIU93kIx9YgDUVOBpOxtQk2gyg2zxcfugc3rO4Gytb6IfYYpJkETlIyfZbRUEcgSOVcP2WTy4GEkpoklS4b4QXMPl3L8TZOY8VUeOAKaOpucvKqukSxRcePFNFpEQFsevV4e4XjkVVCPsnvTtFRmauLnluvmJU92w1GCAVd7Cbt51nn4g+CS7P3IxhBBrqtn7bnfOXlIMgWOggZzmY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAtcVia1FObieBiIWiJuK6waWdb+GcPHQhgn6CXHAHw=;
 b=oNozAZOyWnFglx7irkZyRSWAnRTARbwfUxxIpeeqAN6vDkQ9WooC8ue1ikKsif9huSZUoGSQ3gw4B3oftZfG2O7bmLaZaf+J9VP4ik7+2ruE8NRMFHn2J9CH8ZOb7orNMa7WFuzdBzwQgCnXaN4pBb4uLFVGeh5N6qFdB5xFg9tD/Kn4h5f0fgTPxWEADyBdqy2giVZ+wYaEHA+/vtVIDMTiOocp3wTpwNQahi5R99tBpOMMhUG+0bD6zJqotzassd9QHs0ICsk77Bu+L9rpnnj+6eX+vA2/T7dh+OkVBKmSE1OkUWBYlxjuGh5P5SmZ9hVb+BDslYmIf5qEkQSlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM6PR11MB4722.namprd11.prod.outlook.com (2603:10b6:5:2a7::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Mon, 9 Feb
 2026 07:34:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 07:34:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "david@redhat.com" <david@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>
Subject: RE: [PATCH] intel_iommu: Do not report recoverable faults to host
Thread-Topic: [PATCH] intel_iommu: Do not report recoverable faults to host
Thread-Index: AQHcmNSX9m4zaFg2WU+PK2nSuD+sw7V5913g
Date: Mon, 9 Feb 2026 07:34:49 +0000
Message-ID: <IA3PR11MB9136AACA4BFA95DBE6B92B599265A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260208082252.288-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20260208082252.288-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM6PR11MB4722:EE_
x-ms-office365-filtering-correlation-id: 02e13be5-8454-4c00-52e6-08de67adb516
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?HnO6UsQJT/wPGgnRNbU1ir6fwSlLAzn9pShAM2Ozj53QDjC3upuYmVXvmMb1?=
 =?us-ascii?Q?hrCflVOgmKYOcjZrOQuBiW2MZvLZI4mj5HElrG9BFMWfNL43e+pT+TiPeKzm?=
 =?us-ascii?Q?RUu7ZRPee2QG68aogGs5pTdzYg7/tBkdOKlymClaB8zGa4kRDRTPfVH1Tym2?=
 =?us-ascii?Q?W1mRcePue4p3z8/QtbTmoAdQvsyBE/7eh+bKz8TiwbdApXBRPDsG1oHyw2tE?=
 =?us-ascii?Q?lUIA932dxOiq6Yrap1tXRVWOzWthZEE5hanhJCXMMIuZWUH/zlEhD9MA370T?=
 =?us-ascii?Q?96ggBX0U7lLD9v6G/aIawS0qXBaJYtSFxGoZOn/KsTbXSx/crstk32TE5L5U?=
 =?us-ascii?Q?e/p3lck8P62rv19zQefZryHVAguz9bAKVH+c95/ufJO0IwccABGb5zjvrYYg?=
 =?us-ascii?Q?3pJZ68RELMXKvuR2Z7daqmiidukkeNptSLMT5LTrYFIqNRyxi5aBzkfbdg4i?=
 =?us-ascii?Q?SgRXg3It4gdEDpq4KsUOx7AN4Sb+kZMKSRfsFhti1bID13A9SKb6W+PzB0Vh?=
 =?us-ascii?Q?bYEarllsor6/+S4sHUSz3yKMgm28N8xEBJNdTbn0bxqxfsTZO+eZQfb/wm0m?=
 =?us-ascii?Q?axaq9l+nA5lJ1lFvjh2TK+PMHPawFO93m4gxk/uJyYQ1Nd+g196a7Fuj3u0h?=
 =?us-ascii?Q?hHxAgvlUbZwkjZSeWZlyvhGznYX7b7bS1CHms+j4CYPrAYsuIoiuZoeuUoS5?=
 =?us-ascii?Q?A5hqKsCSA8RI8VxfuKYaY0mcFXTszZxu7YORb/JyUI9bx0Y2/YcDTzc5LMyd?=
 =?us-ascii?Q?d0cx/Tq8jycyq7JsoUFElDPZ94Oa4755cIs0gZVI/WYvgxX/alwM7sVCUq/+?=
 =?us-ascii?Q?BDO1PhkLEwZrec5zDgchwSy5imInjaCxjR9pWgu4izLc2ASB9s8QzhVYS6KX?=
 =?us-ascii?Q?luXLH48kqmlrjWq4xpP/Li2s1Vtqzh1n28xOT4NuYgFbi6/8tctZlau+Uoge?=
 =?us-ascii?Q?g6bWlCS+BUxU8uYBpe6+vPZrvTrd8XlsXdDNN/oumZmCVe8XD/wwtLD2jBl/?=
 =?us-ascii?Q?CNvg3mfMr4vXf2h8QwMpJyGrw88nxesxIJvaPE5PCHdYEdWYN/idDMG7KAoC?=
 =?us-ascii?Q?FUtMnMY/tty9Py+ddyVLyadMBx3uqdSrJZPa9tlhmZu6xCt8Os7oYTKpukdo?=
 =?us-ascii?Q?+4GAJ4hd/s+auVjFXtKN+540MynrY8ytVaZmM5iCWLYS+G6YYPvE3lEaf/7K?=
 =?us-ascii?Q?2Z1+s0u6vurwkw8pxy2X4dhkRkRm9V56fru4JDeGMSdBTAYdeiArg0cf6W5H?=
 =?us-ascii?Q?mwPgYMknzbn+N/a2z3j4asGWOXhZs4y5FmM9SeTiNJfAAb6Tn2m9BvFFZ2Et?=
 =?us-ascii?Q?vpd1kvhh2uNQxBBvLzEOn/H4TOlVo8vSFR2kjfDuQOcJEAMvAzVC7NNaGvDW?=
 =?us-ascii?Q?Oye88DV362zU5ecGujO492jr1H0GEIF6fPFd7A5uH4WIo1ISUfyu2KeSBEqk?=
 =?us-ascii?Q?jupib5loKQJRVA9KLuxtTe+xXtNXUICmDQG8q/qLLvbI/6C3g83DrAhwbMGR?=
 =?us-ascii?Q?1509s0XcyDn07u/1XQwnuC7EQPBY5vJCtt8VfnSPU8Fa5Qtm8u1xAmLTBzIB?=
 =?us-ascii?Q?JiQCs7NpGUYGhPnW3yKjPbRilW4MmoNYZp0RlsxooLyc/Ooo+6X6xIqjCezu?=
 =?us-ascii?Q?cMqpoHLo6imU5I/NRHwWTjg=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oK1Ei9IwKENJagcFEINq6CSPR7teCHvBmarBXYr8Tf4XHgd6FOnHzJSp9PZx?=
 =?us-ascii?Q?LU39U7sQNrmx4bPA+E3Tm9oObI5KgAIwURmpR+igZRwpY31ljTPpmouG44uJ?=
 =?us-ascii?Q?H05zkiYb+Q3A8cgaKSStSaAwQYAypGdQsqXH3AUyHy6Gh6FAOyz1xxrcwwT2?=
 =?us-ascii?Q?kSuIZZ8HYIzoiFovoAo+bz6gbCXaT1z5bND/bC4whJzaARY7tuolXZh/k6Mm?=
 =?us-ascii?Q?wcZZHmSPXOtqrRgO5UrD2Me8FtiA+w9xAt/isaIuok8fp/iICY+QSLYFOTFu?=
 =?us-ascii?Q?+cVFLRoNZ4ws7gdiTJu6rBCl7Kz4fTFT6FXQWsC3+iJzytlIQxO2p9ajF2r8?=
 =?us-ascii?Q?C7xp/IMCwlvJxEhKeXaORttOsj/R2NhNI6uCM128UB2PaHfY1L+c5WFb4rl/?=
 =?us-ascii?Q?QmIvzX7k+TqiYnBfLYxlPKwMDjXRrxB8hGfGlVvUdEZgKa1sQc8G5/dj1KKz?=
 =?us-ascii?Q?eRTIwE5Yo4YsDLUiTe5GC/ckYOoC/yZStPezQVY9mjtME13RGhYC5bMf5+bq?=
 =?us-ascii?Q?Ioag5u7cJlFJgwg3/EhktkCNINLKC8NmSTdHB3Fer4yvEgn9vrzBihTxWqXB?=
 =?us-ascii?Q?qm1s6CD/zrg7ocMxPbh28aC1qRYtgtYAlmJ2EN1JJNL4U9zI4aNvrRDksZu4?=
 =?us-ascii?Q?oow1rcxzn7SPCjWnxQJr36VD9Xufy3Lhezee0LvAUrkbvT15J51mMmP4m9co?=
 =?us-ascii?Q?5JxiyGws4w0V3pJHyodVfH/GiaDpZT2rROVysyGSVhvkq9h1+tD2TrA+IJ5+?=
 =?us-ascii?Q?uKudyq12LIaEZImrDPTpWu6VJ3NrGj9U+Fw3j9cXg5Hi3sfiWyZ1VwoTN4/q?=
 =?us-ascii?Q?DuqZeW+Rq4wjcZaTTsyAF20/+M0+aNDlMF1XtNg+p2TRwE33QqwoPLnvDard?=
 =?us-ascii?Q?JQTg1FIFD6k00w1vcQrG/lgCfrM8gITuYWA3WMyspB1nDHw0T5a2dKHUO4nP?=
 =?us-ascii?Q?WG7K3kz2lo7gTK6aAka9C64BYNSOLvKcOWXEsh2Atvw9ntKVaTSvKnPpW4uV?=
 =?us-ascii?Q?kE6mnlbcF+W3XpoVYWEbtfxkuC/QMP0sZjFqqLaUuDUmg75/EMwLp/cWyQOT?=
 =?us-ascii?Q?oFRX6KgIM0NTGTIvsfe6LzAaU9KKnul0t1C7NoTtw4dxqF8WyGxpPss1ZT14?=
 =?us-ascii?Q?P796qXoRf63g90BQoqjlTIrvfU+BNMQYcIuBRBPmUuI42Ocf4MNg/EmpUI69?=
 =?us-ascii?Q?WoID8BIGLZRpf2pIXVfRkeOTuKYMEwjrKP84QIA3+/T9uMWgsblUXYs1RJ1o?=
 =?us-ascii?Q?fnSm/7gxvw7a2sbRUbqtLdqlK4omS1Nn2QvWRvvIgYm60BqAzzvpNFEx+dFO?=
 =?us-ascii?Q?2JYRnljcVe5w36HI6d5XTYCicJ22FdQtPfRwANb5r+wJEgfgFbciuU++klzM?=
 =?us-ascii?Q?GOhAjLzQ3jS34tLxPLbXjU3bBNh8uDmAhf+KmYiEcXZYjeOekjLo/VhlOg8t?=
 =?us-ascii?Q?Rw5G4CzCGprBgTBY9dsus5pAIY3dqwg3c/amYJOaiLL1t+En62b4zyz1XvpK?=
 =?us-ascii?Q?LaraRi72FbayS5PRudKKXufPV4N+FBHB9iu/ShUENe4emCAXO3dJakXUMc3a?=
 =?us-ascii?Q?dOTJHAyocHo9rOMBpeIMx/iuW+Ax3NRMRDgunIrZIV5bECrMm4qdyQcBIMvv?=
 =?us-ascii?Q?0qG5mytSSOKPVAFCCms+IbKgolZr/m1R9x0hTT/T6LBbbaQjlsbpLcSl05JT?=
 =?us-ascii?Q?AagD3HIVpnLa2gL55Ic69BBnIcN09l02pqA7FeuT98SbKZ+iTY325fv3+hGh?=
 =?us-ascii?Q?0R2bzX2dVg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02e13be5-8454-4c00-52e6-08de67adb516
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 07:34:49.7949 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KKDomcj0Ojo5p0pb7aLfPcfpT3ezKqMGJuKW5H4n5MCf6KLPMe0RGx1xSH3C8d4hqrnXv8dXZnCD069Co378tViCuIzTvmtn2zD151HxaNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4722
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
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

Hi Clement,

>-----Original Message-----
>From: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>Subject: [PATCH] intel_iommu: Do not report recoverable faults to host
>
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>---
> hw/i386/intel_iommu.c | 26 ++++++++++++++++++++++++--
> 1 file changed, 24 insertions(+), 2 deletions(-)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index dd00079a40..0735b24ac0 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -1857,6 +1857,21 @@ static const bool vtd_qualified_faults[] =3D {
>     [VTD_FR_MAX] =3D false,
> };
>
>+static const bool vtd_recoverable_faults[] =3D {
>+    [VTD_FR_WRITE] =3D true,
>+    [VTD_FR_READ] =3D true,
>+    [VTD_FR_PASID_DIR_ENTRY_P] =3D true,
>+    [VTD_FR_PASID_ENTRY_P] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_INV] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_P] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_RSVD] =3D true,
>+    [VTD_FR_PASID_ENTRY_FSPTPTR_INV] =3D true,
>+    [VTD_FR_FS_NON_CANONICAL] =3D true,
>+    [VTD_FR_FS_PAGING_ENTRY_US] =3D true,
>+    [VTD_FR_SM_WRITE] =3D true,

Which fault reason is classified as recoverable fault?
Is this documented somewhere?

Thanks
Zhenzhong

>+    [VTD_FR_MAX] =3D false,
>+};
>+
> /* To see if a fault condition is "qualified", which is reported to softw=
are
>  * only if the FPD field in the context-entry used to process the faultin=
g
>  * request is 0.
>@@ -1866,6 +1881,11 @@ static inline bool
>vtd_is_qualified_fault(VTDFaultReason fault)
>     return vtd_qualified_faults[fault];
> }
>
>+static inline bool vtd_is_recoverable_fault(VTDFaultReason fault, int iom=
mu_idx)
>+{
>+    return iommu_idx =3D=3D VTD_IDX_ATS && vtd_recoverable_faults[fault];
>+}
>+
> static inline bool vtd_is_interrupt_addr(hwaddr addr)
> {
>     return VTD_INTERRUPT_ADDR_FIRST <=3D addr && addr <=3D
>VTD_INTERRUPT_ADDR_LAST;
>@@ -2237,8 +2257,10 @@ static bool
>vtd_do_iommu_translate(VTDAddressSpace *vtd_as, PCIBus *bus,
>     }
>
>     if (ret_fr) {
>-        vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>-                         addr, is_write, pasid !=3D PCI_NO_PASID, pasid);
>+        if (!vtd_is_recoverable_fault(-ret_fr, iommu_idx)) {
>+            vtd_report_fault(s, -ret_fr, is_fpd_set, source_id,
>+                            addr, is_write, pasid !=3D PCI_NO_PASID, pasi=
d);
>+        }
>         goto error;
>     }
>
>--
>2.53.0


