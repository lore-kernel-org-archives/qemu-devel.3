Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DF3CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 05:09:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8tk8-0003Cv-63; Wed, 15 Oct 2025 01:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tk6-0003CS-1b
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 01:08:06 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v8tjy-000803-7J
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 01:08:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760504878; x=1792040878;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=rJMb+QbOEBn6m1wiYRp9e9JkC5iCzRxHeVCMBlJ+lLo=;
 b=I9v55DOg2Lov6Erhk0u3ZPyA4RAEYIbXTLSqMW43AzozfLiten8IWNRw
 ycvMQ8T8OM6BX8Z8EdZHgHhaSzt5gaSzf5Moby0n7pMkNVy/jNYz8i0Vp
 6YsSsbMq9oOJwG7P+8M2NlPkIkVM3V9MVufeUAklxr51rJ/XTvIYiNf92
 Hz99QQK/C6I77kIAnZAcU4jrJeCby22K5FFhsqbN+D7M8UZmdBHyxfFsr
 dFHFtf1f+Zaf8yl4HcjE+g+tNncGDZmQ9cg9/SVQ990rBg5Zxv/uWdDPv
 1zbl4ufYDJ8VJSi70YusPTXMMkHU88KhGnIAakOdcU8KNrdu1/TpOTU+2 g==;
X-CSE-ConnectionGUID: Jl9mZhMZTpC8HvX3QHxsug==
X-CSE-MsgGUID: ZcNzSv/xTJWQu/1glUeZww==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="66533380"
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="66533380"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 22:07:47 -0700
X-CSE-ConnectionGUID: lCnsCL3VRnORrxwYlaXuhg==
X-CSE-MsgGUID: Bq++HOnWRPq5WdYaRl/Leg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,230,1754982000"; d="scan'208";a="181202942"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2025 22:07:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 22:07:45 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 14 Oct 2025 22:07:45 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.44) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 14 Oct 2025 22:07:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dM4ItWMBiyh8UG06Yu6WECqKn4Whe0XXGeuMdm7iiUQZE/XoCwpS/pzgPnUaWWf9olEfTO67by/OxlASzrmuCShZJ1baNOb56oH0+d/3wr5EtuCznHk2hFbc6TEzVFDuJKXfpc9dylv4LXIads2DvOr+3+f+nTFJ/l+2dzoVmsTkCvhc3bPmi4k84gz0XA2fwQ0J4pL/kvQW80KAUZ+m07GU2D/QTjW7A0UWaGtEuDmFfnI1slcSHfJ8Zj/bHex858nO8HScNd4v91tRrP+dH9KCGUl2AkCB7AV0vcZHTGp/cGUVufqBCv5DYTg7p+Q5Z1FSVmrgGFp+jsXYUzTnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJMb+QbOEBn6m1wiYRp9e9JkC5iCzRxHeVCMBlJ+lLo=;
 b=eCB4INtEG1RpHd3xgNuv3e+iKAf3G3SETj6tOx/nXwBiWIW+ZX1bT+FhZpcueIe6u10b4BsdF/5j0TeDmPKGP2pdYTkoPDQYT0331nnwezoU44w6KrOD2axFp8Om2mdgyEXaQo+pssHgGPhqBq4183eZnoiqyCOuE5uKknEnQqNDkRburktl+CYrcD9KtC9ZM7dHRWYPCVOcVJ5B6JTtq7ysZJW17nHthYMUMBcmIO6Sed04mnPvBZxphh6nhlj+6d6xnawvHfbdeDO4fXF08EglwHMyqn3CEUQXAg/dFsPSnqWR2zgcsJELdt4XdB2e2sNwQFKYnhpzc/1ziJDZFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by IA1PR11MB7387.namprd11.prod.outlook.com (2603:10b6:208:421::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Wed, 15 Oct
 2025 05:07:43 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::271b:c621:d244:6105]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::271b:c621:d244:6105%4]) with mapi id 15.20.9203.009; Wed, 15 Oct 2025
 05:07:43 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Topic: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identify
 blob resources
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrg
Date: Wed, 15 Oct 2025 05:07:42 +0000
Message-ID: <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|IA1PR11MB7387:EE_
x-ms-office365-filtering-correlation-id: e7ca170b-bf40-4430-6c30-08de0ba8c58a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?8rxgCJb1E3NJKBS4mwJmYJ3zMErt1mDE0Et9kCIw2ZgH4ex5xHwS+PCbJU?=
 =?iso-8859-1?Q?BzNSSv959efFRRRXNtnyYMsTRB5nkk+F9qcBpmDFCJ5TcmDzUoCCZHJRRp?=
 =?iso-8859-1?Q?mvgZ841Web80eqtPFmBVqcUraMLTM5tHDNwcdqaJCqlltD4u+IjxQ84x3n?=
 =?iso-8859-1?Q?FEys/i4Uhs7zD73Ba1B1Zh0Wwgfepit25T71SMB+pKT7X/8U7PNjjmGuCM?=
 =?iso-8859-1?Q?fXJQcxUxzspfmn70riJWPG2g9t5X4NPl7/iRVq4BLvvhf80E0cQMNqwobL?=
 =?iso-8859-1?Q?nJ5FUrSXI+thwjxA2Fd9Gs1bF4AxizpYvniYPNS90lSwoX0q6GzkGjJ+Ei?=
 =?iso-8859-1?Q?qVSW8EbYy/aNyfRQT4Jp2IJCZDM+eftRErbDe9ne6JtAhHNVioTUtuKao6?=
 =?iso-8859-1?Q?OWthsQzf4HvpKg/sqq70NEM40HHagSq/DxuSejrzhU7uFdFlvkh+XvrC3/?=
 =?iso-8859-1?Q?lRiBC7wFg6TM9/imDYIjQGNyLx9mNBjSjalRP2zHvjW98VNTAKTY62BPb2?=
 =?iso-8859-1?Q?VkNCsxMcQMpm6Z/B/a8wxqsRL3yHIRO13D6GlgUn9it714gyplVahyk+Ku?=
 =?iso-8859-1?Q?dVMjd1uwPfPodWORiI/wdUyoNO26rX5nYjJBMWlFSq7XQyKfjnehd+TDEi?=
 =?iso-8859-1?Q?69Qncdmcn6m5hC10vXDs7Cb9fN4rddZdZa/Y6qzEE9UCy0Y+viKnyikqHk?=
 =?iso-8859-1?Q?nhMs6oFk/5SqAY7KA8Fd+2ZZdgp2G3AjjfiyhhQaOZVxHTc94/6OPO8fTg?=
 =?iso-8859-1?Q?iQbqV1GuBXKyRTnBsTa3ZzJZksQ9XoT3oMy018E96ZTJyuLcR9BuiduyDY?=
 =?iso-8859-1?Q?dNwjz43sCYlr7xqq9aUoBlyti9zf8pV6w9TrdLEYb5xOcLBCk9kkmg6TcS?=
 =?iso-8859-1?Q?CSa9DD+V2FYeL6Nx5tjoMbRWRdWFb49vaRX3aTNHHmPXGznZ8P/IDjMfwe?=
 =?iso-8859-1?Q?U5VnB3VNnZZ9ePd7Yw4OMBUmFmIj265vcrmsmUzZqNgGXqOqmhutV7Bkwo?=
 =?iso-8859-1?Q?7fhCaqk7uKM03mt1+p4ihHkwCuMEa3xPVFe1+cKLJwBuivo4ZUqcqUpiVg?=
 =?iso-8859-1?Q?HrXOXhPeY+T2orLGD4P61/VLe02QoaZO8egQY2uZQ7wKgmrdm59EoCMV7m?=
 =?iso-8859-1?Q?Aid0S8fSg1vgW20muSkw2pdKD3qRrE/w28B9sgxqM4yviyCKM29L+m9tSy?=
 =?iso-8859-1?Q?HxiRcFxegIWTKu8M+K6TJ4OELCeGpC/9xa7yHMMPSc6fRSzsSDVSFZX+wp?=
 =?iso-8859-1?Q?13Qu9WOGW5IrN4jOqwQDKecV6vjmJQxzpqZCc/EH0hhpkLS5ovHF3Nvsxy?=
 =?iso-8859-1?Q?7H2OLUL6TdjL8sY+0cfVL3FO8ZQsPXJtvDOhVE83HtDwgyw/6AypDduKuF?=
 =?iso-8859-1?Q?nzy6lGk1ZQiPeW4Y/c/PfJfJq9D44A5Z3C0khMXPQ+PTiwPjxgWBBwrNH3?=
 =?iso-8859-1?Q?JQi+V4apLUWylT+wGMY9QxloO2izCi0CJaAyNt+3GkDVUCDMUxO+KTT0By?=
 =?iso-8859-1?Q?nxPUhfSzpr8GoevTHTCJrhWs5xjBYEbTqu0Yxb87BqLAKFRHpPsaDK6qy7?=
 =?iso-8859-1?Q?6EDQnncyrBBmm5aDrVZEnz+ExmN1?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?4/y/sc/pnf7/cA5KQVvEruQpUBmRWrZ1Sf5dYOssbJU0oNwfID/u5oShPK?=
 =?iso-8859-1?Q?Fmq5d/JACFCSprhNZUVEznuqqfvxNigafg64JvdNRvlKQJCgW7KAPoF+46?=
 =?iso-8859-1?Q?mioD4z9470q8mC3Irb7IpZo8N/gA0oC5qKZEMYyfBnRzhMMfVEgoBfg7HY?=
 =?iso-8859-1?Q?1m9rEodKe4hDWv4cuqr8VnnTxQzIQ98PBlGLqp7eCdVOw4Nao82d8eCrFw?=
 =?iso-8859-1?Q?FAqSv2zbSDDcjWR033CXziUBw/QCQ1UatGoFUlgK0AlMShNb4KtlIacheO?=
 =?iso-8859-1?Q?BfYyMTMZwYVJQSjXC5h/+M6MFFcey/KeS+F9RmISc28Oalxce4itnoTWY5?=
 =?iso-8859-1?Q?E5mOnLhyIc7F1Iye5EhEY1khK15H2RMJyCEHzRoI188SP55pewBTphVV1M?=
 =?iso-8859-1?Q?w26i484U0D7A03Wl7b3Pfr4sgEeb26VGmmXZD1mr+UV4d1/AEMsEx45LP1?=
 =?iso-8859-1?Q?ZdKOl1HBRkDS+L5TbDk8gvBU/UVlteJx/i+yDhr0wtShuA0GiSWmnAh9OL?=
 =?iso-8859-1?Q?mhlGEv563y0htP3eGqlKLoxtUFzNLFqNnk+13+1Vu1ppID5mzGThCOlyNK?=
 =?iso-8859-1?Q?EivlLOZynF1zroezPTnBdBG7PGv+hqgkcAWPQah8jJ8IZSO02CrHewe36S?=
 =?iso-8859-1?Q?ocm/g1ZaEyIUh2RWGbedu6m/zhY9HF1mcMNI1plOui8jwsA9CgEr0jEGgW?=
 =?iso-8859-1?Q?qYkEbp5u09vlIZ9WZAKhD3NvsSZz14+ZGzDqI87xHAwjRJu6wXFmkJ3Ymt?=
 =?iso-8859-1?Q?F1jVMPtvQoIYYUAQR68AogGvSKfYXxctfNNCPb87d/x6KPiw2l4ED1PPiw?=
 =?iso-8859-1?Q?4m/eC6/SQSEH5+woKGoQ/JsO9Kagct5lFfYQS6dvYSMNrobJr9KkGHXetd?=
 =?iso-8859-1?Q?gHD6XunYX2e5n0rCiWzbFRFI2BNoS/YMFoHPcdP3y+i3uDr3U+RzwYRA60?=
 =?iso-8859-1?Q?2XyLK2Q9JYNnxNEjtOfwl7FVbhvz87+KhkvHOVWVFaYUs6f9QHx8Q/agbV?=
 =?iso-8859-1?Q?HZ5JuHDueRGrI7Knzxhqap7uwvgCSQNfgb1354E3QqUDonQDNXH6umNNLr?=
 =?iso-8859-1?Q?00PiXpiVBxNbqRoSSHPqjTvflPsSHbAVCOy6vlI7LS2i3wczH3Tyd1ntZM?=
 =?iso-8859-1?Q?gB3qpQw2kVkoJLftBSeS+dO9PeAULZUXd+4ARQk9+IM7usR2mQg+EhButN?=
 =?iso-8859-1?Q?A6pJ6HEjM9BGa0Go2+AoKoqTcthxp9i2N/FbQDiALGXEvCPSI6Dhxb7gG3?=
 =?iso-8859-1?Q?SLpHgS/zEdtbyDK9ty3pSIsktU+HXizaODLsThSvx9t+uFkrBPNHZ+r1q1?=
 =?iso-8859-1?Q?HvoQqWHqsx56kPhLI1g2DtvT74PXyHYVPQbHkSqrzP7+v/X9MJ+cVnrUwu?=
 =?iso-8859-1?Q?XIU/+nB1jOjfM7xO4tdcmkRpAHWC1GocvePFAj+Am8f05PTI2RvSZBCUSq?=
 =?iso-8859-1?Q?bjO+/v++2yVo7mmbh9fondnPJBt2zTiSd0tuBRXas1Hhwx8s5P0A6Od7+J?=
 =?iso-8859-1?Q?N4g0iHIVdNKwCDX5GdPFSKNlm0DM2bcOy2KtINJMh/aY8LlOfJyWbLZoMu?=
 =?iso-8859-1?Q?3+1IWqtwDDY0W7k6wjrKtaLeDoo7TLN53maI43I2Y5TdrlQWvL87ErIwqZ?=
 =?iso-8859-1?Q?hurKpfjqXKX0NftdbJ8pl2zHH331cDE4JU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ca170b-bf40-4430-6c30-08de0ba8c58a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2025 05:07:42.9246 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YC67C67FLKoMLaaLqUNej18SgxzicyYsWqa9n9hKDtyUOKKs6MfAT5bVjQV5Yzwb9uw47r5cDOvE3QqE6ZmbzVHEqfiNKWmavPIue5ZU08g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7387
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

Hi Akihiko,

> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identi=
fy blob
> resources
>=20
> >
> >> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to ide=
ntify
> blob
> >> resources
> >>
> >> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>> The res->blob pointer may not be valid (non-NULL) for some blobs
> >>> where the backing storage is not memfd based. Therefore, we cannot
> >>> use it to determine if a resource is a blob or not. Instead, we
> >>> could use res->blob_size to make this determination as it is
> >>> non-zero for blob resources regardless of where their backing
> >>> storage is located.
> >>
> >> I think this patch is no longer necessary since now you add code to
> >> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf: Create
> >> dmabuf for blobs associated with VFIO devices".
> > Right, but given that mmap() can still fail for various reasons and thi=
s
> > use-case can work as long as dmabuf creation succeeds, I think it makes
> > sense to not rely on res->blob to determine if a resource is blob or no=
t.
>=20
> I think the code will be simpler by making resource creation fail when
> mmap() fails, and I am concerned that the guest may mulfunction with
> such an incomplete resource.
AFAICT, mmap() is a slow, optional path except for the cursor (which needs
further improvement). So, failing resource creation when mmap() fails
does not seem like a good idea to me given the fact that supporting mmap()
is considered optional for dmabuf providers. And, even with vfio, mmap()
can be blocked for various reasons by the kernel driver IIUC.

>=20
> To motivate the proposed patch, there should be a use-case that requires
> to have a resource without mmap(), not one that "can work" a resource
> without mmap(). It is extraneous complexity otherwise.
>=20
> Such a use case should be explained in the patch message and perhaps
> also with a comment in the code. The current patch message needs an
> update as it sounds like it is unnecessary when theere is code to mmap()
> VFIO-based backing storage, which this series has already gained.
Although VFIO supports mmap(), it is not guaranteed to work in all cases
and with a different dmabuf provider (in the future), it may not be possibl=
e
at all.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

