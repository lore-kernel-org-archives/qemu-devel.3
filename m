Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90366FCD0B5
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 05:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2jgM-0003TS-9U; Wed, 18 Mar 2026 01:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2jgJ-0003TJ-Gy
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:42:59 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1w2jgE-0004fs-U3
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 01:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773812575; x=1805348575;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=xTKTHT9WobyVk7gTEX+7p4DWOnksmuLiQUHxakZR+bI=;
 b=d8eKAq4n8ddnk631C5MqCNAML8koyD0MUitEuQ2c5JDE1wzuTEZbIc6t
 5uwUEjOamOkjGqwjbjqsffa/uybjettebHDkmxk+IidU6FOqeWdPZLktX
 1yEaVKDvHvJf3IMe5LOzwBZ/l1r5YG7cVkrftxOPbkAvhqWD6OFdcvNHA
 gTO6aIjDmavMDkyeTqsM/nLK4ZcjzdF8BTPfyACr/cfuCw6y5bzFu4MdV
 GoMyqLgdOHHMabx29iVW/zDthDClhGIOmm0ndBWIlsOCYWkDH+tRXSwCa
 HUJQlJwJB61LgY97hWB5OnQySKPP+QtVnvjbkfPv18yaXQpmyu7iT0SAY w==;
X-CSE-ConnectionGUID: mFHFil2/TKeEsdIWtZJOJQ==
X-CSE-MsgGUID: mvSNIYA+S4Ogk64WI64hHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="78718976"
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="78718976"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 22:42:49 -0700
X-CSE-ConnectionGUID: /9IQwoXySyWjX3WHISyu8w==
X-CSE-MsgGUID: VcK0IHqlQPax+M9eyOJRDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,126,1770624000"; d="scan'208";a="218556434"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Mar 2026 22:42:49 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 22:42:48 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 17 Mar 2026 22:42:48 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 17 Mar 2026 22:42:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OSopN796czwJMRMsC25g6APXKmnVL47tc+H4snydvsO7f5cnzku0xKBTbg4ExqrnSe7hY0fVjFhQ1lUUh0L7+2nnGre/1GfaZVXGncVsd9wAZ1wHnl3RFlMsuVLz68wZyAftIHFGwaKhormdsTOPxx04SXU3sPbYP0cMzdL0lhiP0Aj2IPDm4/Yl3UGD+wXA5pyoA8uchheE95ajc3ERlUjmF+zR1OyMpb+EEYPfgySixrzFpsZOzHK1zKZAHY945QtzVAc07KPDANDpGhOeMxBuidL9b+U+HtwlLR98iNAnOu3nTkufCSL6AvUp5BpGd1Xc2fPP0N53FUSbYx9ARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xTKTHT9WobyVk7gTEX+7p4DWOnksmuLiQUHxakZR+bI=;
 b=IU1orInJ+9A+FYfjyUXfhoGLEfoZE1iZNRnLsqQyE/vCpOuj2tDREOIW9FPnIBKGB/jMrUvT6lbaEGZQDUup4QBPcOK/HISzT/LhGfUqYG8qlhTb27CCLTjiyx++Aydr11jV0+VLxcdKcpTS2rX/yQiCeBab7lckdK4NzJN60JRqqurEwziPzBKwb/qgnkvDIgxy5H3fpjinaC21uCAJBSfp7Zz7HKBrlWHc30vaBB22/a0Fz3jd1WRBsNf6bk7Rye4z0BuJLTGuMM6TLGNsCj4I7syepPiDia3grEJmN/mR5+IlG22yz6wz991sm1qPPzl57Ryx63m4MiyLCLyqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by DS7PR11MB8853.namprd11.prod.outlook.com (2603:10b6:8:255::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 05:42:45 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%5]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 05:42:44 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcsQKvhlyWHsvpDkKW/EAlR6lOwLWoy/CAgAFO1hCAArqpUIAFt1qAgACW6WA=
Date: Wed, 18 Mar 2026 05:42:44 +0000
Message-ID: <CH3PR11MB71777D6CF04696E54D839D0DF84EA@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20260311025340.1335673-1-vivek.kasireddy@intel.com>
 <20260311025340.1335673-11-vivek.kasireddy@intel.com>
 <04fa350a-b181-483b-8cbd-2ba5171174ba@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185D57A5228ACBD883CCA99F844A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <CH3PR11MB71779A42788AC6E84035F362F841A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <664eb0bd-cd2d-4813-91d4-2a48e18bba55@redhat.com>
In-Reply-To: <664eb0bd-cd2d-4813-91d4-2a48e18bba55@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|DS7PR11MB8853:EE_
x-ms-office365-filtering-correlation-id: ba7d3782-fe90-465c-4014-08de84b12e09
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: 0ICRD09fG/EkjbbqEff9p8MrBk8SnJRVPfpesSuneka2B0LQH6T2ta2JCRAR03nmgRb7O1T9ohOA7eTfnNTounW9cDKKCgO5F3zt91w6sNpP08j2DTeJSjhIDR9twGZxE7QKqBJNzl4Zh+sb+w5D+/+7Q7sNV+2SASkavebmsUZ/KyJEKjebFXLsav6jT61RLFvRur2/CXF31zsQTlDNRuMLya/SVzxN6ZNXPRL1nxE1IZiLNtNz51v49WHoh/xTDNL7CAc6S1cTMphCWfK8tRYxxPNTnfss3aLDdh6BcJRfoR8am4kcPcob1SHHrYwEIwZP4/lKdRTQlGNwXnZ6INnOJx8xxsbQHQULncJJEqIdi8T37IG8F1hS7OV0fBjC/5rZRz4YUwKPPewwaJgsFbDuU5/Yp5GwpjFdqm8F4T0JcsAmq3JZmycdk0uIxzqruHmJjY21uU4iFM/3Lis3gpLt2u+mxwHUC4F9loPgZb6JyHzJcWwCA0gAYSPGyeEKV+dtcTYeYJ+OUxAkL9C75mb0Eq9wEEXeqeKgEA17bujRSFLkDG/5tcGoND0l1y9N1ilVaiPMtbFLBWEZJnoUsnhS4Xtonozl5rxGXpA+wmWtQjunOjnt82I87RvuVdv7uFxdLq3PbyTlnfrB2NdqyiZIMATtkLjkLgGdlrgoFKov8oB6DgyOop/x4UTZh4UARVN27pGK+JC/OYTT4bRjcXwZ0yBXvrNjOshY7J51+cUUX082l7x3p76ZVHJvOxOeg3ZfBLGxqFxv3PpYrSvyZs6IPMS/EbHdzdMCI/mISY4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?F/NMBB0SM3ibTfGiwkFyBxhUKeRx8q5FaPgSUjYWMHeOm6d/OIiI8N3Ah6?=
 =?iso-8859-1?Q?QTOmfeK+SNUH3Jmoz2jMGN0cIacfUs6AECeEvRAg1WG+aMs/N5u0yCA7nL?=
 =?iso-8859-1?Q?9FUZ3jhnFv7ZBsIWKhg77SzcbY6AMa/7i4WGXHSxrocuYYeIdb651GRpRs?=
 =?iso-8859-1?Q?S6byWbkJ+Px0ngFysKh7oIPaB6bw9qq3KxJGqkdOSQALIbqxcAGqz/7UCf?=
 =?iso-8859-1?Q?uPZFOFyaffxX47L347rshlxL0nsUK2PozWlizc0iG+DmeCIve19d/0k1il?=
 =?iso-8859-1?Q?LoCzqc1TGY82z24G7jX0uzha0aeAn45kJoeAONlZmNe/M1RjpzZzZZRoVA?=
 =?iso-8859-1?Q?AdoUKsS/iyI1q9d3eLFCjVkySA/Ds/BIQ4z+iMAemr0JL/5+Ti8KHrzOoM?=
 =?iso-8859-1?Q?KKqCpuvr/QGxJT8+UdGbMYog6XbflLFsLusSgBfGggmucolAoro4+JeVKu?=
 =?iso-8859-1?Q?TZ0nPdj7kDr6IwZ9UNODZJTg6uZpkYMLjZ+7s4CygwxZe3NtWhl06zRCMe?=
 =?iso-8859-1?Q?UsryFwuyRL5D5UfeEfIpmmk7yo41yVYaiSY9SChtA54nrO8VVewyR9vk4Z?=
 =?iso-8859-1?Q?WkIT0hLRrHhH00rirzh74p1zfbiiobY0dOS5FKXLmAqr1rLYUOEhJIcCwG?=
 =?iso-8859-1?Q?EJt0BNE7ar0y85CW8+4msGiHXgLS7KIBgSkoO/3LVt1Fi+mkirIPkOvY5i?=
 =?iso-8859-1?Q?hfb/lC8hlVFdgAwDlOA1Pnb+zoCl7BaILvS9gT/uWmwmqqi4FKNdc+zTnT?=
 =?iso-8859-1?Q?6Q5YLFYAd39xFk9jt1sy3JppDs4bNPm61udBWG3mwHcOkEAnPjHO06oilB?=
 =?iso-8859-1?Q?x3VC2kPUMOpfJrgfvGztmSXK5boE+zC/D6TF8bIc0w37aKLIJ/XUDMMHJY?=
 =?iso-8859-1?Q?vQE/kLlCXErplDyIFGvREJvMIJTRmB9hFgRZQ0g5DZ4EQwK9y2CMFX3UpA?=
 =?iso-8859-1?Q?7qaB4v04sNDwgwf9l0JI3cdntsSm/u1m926dzxZH2Cq5QBsu+FVyYuZSNc?=
 =?iso-8859-1?Q?KkvX6we8hbjAP9cn8SIoDkTH655zvm1eXWWmYXzOOF7WhJWhssj1z4hsxd?=
 =?iso-8859-1?Q?afRmmJxYENUR3wQUbd3SxrC9fEQwYljnQuDKzJJLYegVSPlBzFdKr5w8mv?=
 =?iso-8859-1?Q?NVAz2EBlTa8jtanIh1AGsiKJvEznxX+n2aGd/d2Xg83gmf+aaK9NmTLkVo?=
 =?iso-8859-1?Q?YDeqH9go+xlWEoKt3HG8ge/HJuTECwQ2X7wQkWXYz82q+agC02EeLD1LYl?=
 =?iso-8859-1?Q?mMdUu+BQsyRaMkpqjQ3qDSsy3uiNXI+6bxusDZXkCqegE+naxPLNJnQUtg?=
 =?iso-8859-1?Q?51Clpwt9U9yC3BKW+OeU5+4Lj7xJ0RFR3ncR/8ir1iHRg7QpG3FwS17mRp?=
 =?iso-8859-1?Q?q0CWG+C5pGrM3hIw8by2yxVOARJT3TFEnFZTd3GuB27cbdte93DhYFqmUI?=
 =?iso-8859-1?Q?Bwfi3HKlwhbKJ/Saa9DSjRBekRnl1Z2X7RChYsAM57pqJkMIWZsnYds7Hh?=
 =?iso-8859-1?Q?ul8OAmxAvG38Fzp/VbxQr6LEsDOhugci/o1BDXrWoF5Yq6oijlHxwa0MZo?=
 =?iso-8859-1?Q?ImFXN9xG3Ne/cXr0j8RPUtLmZVZ7mRoZrjE/u7b3Xg3WzIN/V71zdxhh69?=
 =?iso-8859-1?Q?fU8gEym0gJ7c3fet1CnoUapmI92VU1j2Rk6muPDEcf+DySWAETlgAYihb+?=
 =?iso-8859-1?Q?Uxwf8NCWO+A2HRa+Rur1E4z7sAr6STHq2A+P5enJCQ5vpVcORQimjaD/b4?=
 =?iso-8859-1?Q?HG/Iq4xnGNbw8cqnY4CnbIvhBnNwiADphmQQ0wZhwV7wNf1mNXf+kiFtD+?=
 =?iso-8859-1?Q?+lprdFy/cw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: KjZFM+ofnObK+6LCAl5OmK4oYNmFMgXVOjVGzoEVSN62Tfj7YyZE7lkSHmqEDSlHXpcSYN8UGpdzmDi4uikqR06cruRT+vWx5NiHOGr0JUaGdKSVcn1Dx3YHs3sXPLiU/zB9adhq0jY1payUnSejxSEkeeBSJOPd/nYdQ+F5+6ZatEg3q/5Fa0xpaODiMiZHYSjPhWhfaD1k7SADoGfl+u0bFm69EzUaBzrszRjm0pb6BiplT9eilSVLzWAevor/zCong23KeysigjZ7omnCP++bvQkFKbZ3SW8qMM32t2Pdk6TbTr+0ZFP7Ajk0EtcxF7enTTuXfT9EHXkvUSHWQA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7d3782-fe90-465c-4014-08de84b12e09
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 05:42:44.9243 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GJPDGaCY6eGhkv/9fBsW6OCJgrYhIpNMRblttY4x6TT6WCQRBVJ0wKscbZC3iyUCqroRhgTzJb3D4TM1wI++BrS3JHn6xEVS8PdnV3pRqw0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB8853
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Cedric,

> Subject: Re: [PATCH v11 10/10] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> Hello Vivek,
>=20
>=20
> >>>
> >>> On 2026/03/11 11:50, Vivek Kasireddy wrote:
> >>>> In addition to memfd, a blob resource can also have its backing
> >>>> storage in a VFIO device region. Since, there is no effective way to
> >>>> determine where the backing storage is located, we first try to
> >>>> create a dmabuf assuming it is in memfd. If that fails, we try to
> >>>> create a dmabuf assuming it is in VFIO device region.
> >>>>
> >>>> So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> >>>> backing storage is located in a memfd or not. If it is not, we
> >>>> invoke the vfio_device_create_dmabuf_fd() API which identifies
> the
> >>>> right VFIO device and eventually creates a dmabuf fd.
> >>>>
> >>>> Note that, for mmapping the dmabuf, we directly call mmap() if
> the
> >>>> dmabuf fd was created via virtio_gpu_create_udmabuf() since we
> >> know
> >>>> that the udmabuf driver supports mmap(). However, if the dmabuf
> >> was
> >>>> created via vfio_device_create_dmabuf_fd(), we use the
> >>>> vfio_device_mmap_dmabuf() API to get a mapping for the dmabuf.
> >>>>
> >>>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>>> Cc: Alex Williamson <alex@shazbot.org>
> >>>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>>
> >>> Now I think this patch implements proper handling of all error
> >>> conditions and conforms the convention.
> >>>
> >>> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >> Thank you for taking the time to review these patches!
> > Can this series be merged to vfio-next given the dependencies on
> > the newly added VFIO APIs?
> I could merge in advance the VFIO changes but the series does not
> apply nor compiles.
The current series is based on vfio-next. I'll rebase it on top of Qemu
master for the next version.

> We need feedback from the virtio-gpu maintainers
> that this proposal is a useful feature too.
All the virtio-gpu patches are thoroughly reviewed by Akihiko (who is
a virtio-gpu reviewer).

>=20
> Since this is QEMU 11.1 material, we have some time. Let me review
> it first.
Ok, sounds good.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.


