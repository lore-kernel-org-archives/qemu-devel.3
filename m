Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD0DCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 03:15:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJNnN-00010H-B1; Wed, 12 Nov 2025 22:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJNnL-0000zJ-Mu
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:14:47 -0500
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJNnI-000438-J7
 for qemu-devel@nongnu.org; Wed, 12 Nov 2025 22:14:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1763003685; x=1794539685;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=R9F9ZH6NItcD3F0RigMa3WZ7QSVLrccWolakMgLeG7k=;
 b=FTat5ZiwM1TTHauaGZaZnMA+6z9NMbRW8/MLcP8kt+UJcjbxPR4IYVvd
 GdmR2Xvu+y4l1dYGrEsHpR7hxtXouhZ7IaCfJZ4oVzXWutR2rgx4VUIVo
 hilDgLxEmk06dUBuKuTIvvydVJqAuVxdU4jm5o93Sr5OFnDpwDIdfU+Lj
 UUF1/PoYFpFCgo3tkY0U1/Hv3EId9MnNruNDB8qlK3PlODWyFiFl2FZF9
 h5+r8hmwGScWHBaPkocGXf4m1EMoQJiA4ru+IHYbRtburhvfEcTj1cNyA
 w5udB5Ym2Cu5LUGCUc6u+EnccVGLfhKov7JSKc4qBziMdixtbeidv/5H6 Q==;
X-CSE-ConnectionGUID: SZK0UFmeTTGvTDkalN5u9g==
X-CSE-MsgGUID: Q8pERBZsT8ap26ZnmPKoQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="64963480"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; d="scan'208";a="64963480"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 19:14:42 -0800
X-CSE-ConnectionGUID: fHsvclUmQK+0jvJ73RB5Dw==
X-CSE-MsgGUID: LP8UTN8oRHSIz3ggppPeqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; d="scan'208";a="189170121"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 19:14:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 19:14:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 12 Nov 2025 19:14:41 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 12 Nov 2025 19:14:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6eqWwsmicraceWpkTwQKVtOliKUu84hegMNy4oWi5yJU4ljHy9uIglM/JaEdiChLxAReyE6hNh1e5J47yv6dhfxqckQXZimh4VEhkYOxAKXjSnZJ4D6JoigYQiooRJpuxXE7nQe6WeMsZ1wwEF+b0+8wAnmjeDys+aRaPc4CqB9fijFkUJqZVYP8XOag+ZX6lmqI6Fe6W7EY8k8ytRIK31YvGj+s+qMwSvnIxxdfwUGlfvi2ZXES1KZYaifoC6ZTnIm+3wJeLXWru4/tog0mGhEa4ztBcOAmJgbyRMptga40OeOex+IdhHYBU/yZKpAUV8GVmfjM4JriVsCHviYRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kzll2SOEfQ+G3oLh5Q1I1gyTVIYWuIYlRHIJ5iWyAbs=;
 b=mCWgb1vdeNc46UrUwjYNWhgDE5nMr8ljw4CmZGuM/BTUTvm7jWW+UDem35NWhXfYxiCOmFZzfPyQl7rvAJ1BRqTskNoXXToMGV7jBJKfQ8K8XNZNsRAYSZn+mnECkgbPFJpg0nD+v0hAvmMyUMheNxu2ASuJCA4NoakG888FhJS7yGwtMx5Vfo6bWUDRYAXaaCiBix9ePfKAU2cNpZAHuSbgfzEANTWEgVpYB2JQCxKTidvtjKQBRvWa+rfyyTS8zTiQ2M1l0r+7HBxFgnrwYxcBdtpmulnG93vByvJ6U8wLI4Me36ovG03wtFRy1DSmU5135FpcF70XLXRi4fiGnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ0PR11MB5770.namprd11.prod.outlook.com (2603:10b6:a03:421::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Thu, 13 Nov
 2025 03:14:34 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9298.015; Thu, 13 Nov 2025
 03:14:34 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
Thread-Topic: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
 qemu_iovec_same_memory_regions()
Thread-Index: AQHcUTsfvAmEvBE55UuEj1Z1sXK9/bTrYKcAgAEJ0eCAAk2jgIAA0/xw
Date: Thu, 13 Nov 2025 03:14:34 +0000
Message-ID: <IA0PR11MB718585B6BC22B86156DAE0C2F8CDA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-10-vivek.kasireddy@intel.com>
 <83274ca7-dd37-4856-b198-f334bf630835@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185F1DA0CD274FBB2C30672F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <77fd4755-a880-4a69-90fd-7153183ebaf3@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <77fd4755-a880-4a69-90fd-7153183ebaf3@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ0PR11MB5770:EE_
x-ms-office365-filtering-correlation-id: 389bf678-52b6-4021-a757-08de2262c51e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?0vcaxg5cwQo/vaaU8KzabkLz1vMpfHiB1Ft5Ygmt61a4Hckzm08wHGFnzW?=
 =?iso-8859-1?Q?x8kPVFy63pea5yQN89HLX6mEBXK3MVlIAVGNsmB63RMkzfN95YXWpTzouc?=
 =?iso-8859-1?Q?6dskTI8sSEBAlP0CN/lICHtWM1tPAO2G2qBBv7f7zz3xr7yGx4PIhEhr8s?=
 =?iso-8859-1?Q?yVGSy7SJpiqxUnBlxLTdQsYsh1eWBKPzGyznisChhNXb0XLnJJyHTdlNkJ?=
 =?iso-8859-1?Q?ssN25V2+oZmUdO+Bf/UlRMO5imNRYNdgy1UZ75NJ5XWR/8tRxbzA1iW28g?=
 =?iso-8859-1?Q?9uFtTCNdyB5tr45Gv5EtVV2nQM3izk0rqRmmjZoGovCnQwMcs97imc619X?=
 =?iso-8859-1?Q?UBvcZTVBz+EOdRRwoLxIzqniYFDgFeuM4ZYVzeq9PAAyAFtSFflPZHaUhc?=
 =?iso-8859-1?Q?WVpRNVzrq7z35haF6GBgKlVtFWta+5r6E0V4fZ0xXfArjr91agN7gngRqr?=
 =?iso-8859-1?Q?+k2KeDVqkV4jk8VesmPrgZPqLI9uydoQWKrzKVpmSc4Vgea95r1+TXYfUr?=
 =?iso-8859-1?Q?Ylmju9gZVz6P2kVfEjqZ1GEzhk8ck2xPG8l3mJSWAOG1p7wlIFzS8Un6qN?=
 =?iso-8859-1?Q?d44z24qDkGcn2GzSVln1u/EU3oP9x9E2b8DUoic9/7tJoD6rx4r5bBVQ07?=
 =?iso-8859-1?Q?stMmfh7GugyBwv4sHRONr36iVWAL+T/OOr8W516vHTCfo48mo2ZpYl9F94?=
 =?iso-8859-1?Q?uUeiKBYRsSpF28cvcApBjSz0YqBE1I5CFge1/taCHsSsyMjjwf9vIYJOAI?=
 =?iso-8859-1?Q?6TRle0nBR1pEaGzWoYmd1Zl72VOF2WotWEDaBVlO9FbuhpKRAWr0IKQLS2?=
 =?iso-8859-1?Q?P33Y5DjZQT+xkO0NyADpj5mkSSYLpQ0k3FWITzOFAYkQDo0PDigEU248S9?=
 =?iso-8859-1?Q?JlwjqZpnnY1ep2TH7MaFaAA3H+LfwYZ0S70kjHJpvJmeKlb2gEzNpH43iv?=
 =?iso-8859-1?Q?dNX/cOsgHYbhhf7En7m3glgHr3gxH3W8lRTdYAPj4J9J7/tAUa9Zum12Jx?=
 =?iso-8859-1?Q?D4TQAw0vUePyQKN/HSABJJzuCm3EDTFeFBzv0Pa3fHlkarx5yNwy4DTF32?=
 =?iso-8859-1?Q?42iUsuAF6/Qv28Y795QjO61VSKXSyG/lNEHvSZC46bqq4yzM3lHL9Bp+Kr?=
 =?iso-8859-1?Q?131kyO/Pf0tO7+ebFT/EetjCpzXkHBNMCn6JKWq8CMPiumQE9Kiu+nARIX?=
 =?iso-8859-1?Q?BwyaP6/dj2iX+H1FdN1UvrHXC0Vzq0N6Vyqzeg4LvAnVl7nLaZosektMh9?=
 =?iso-8859-1?Q?sizlsawbXoGPf53Rlr6IL4fOypfVSwiMABIENsjjM3zYnCHvxYU+nvyZTb?=
 =?iso-8859-1?Q?usmoxPA47quk5ZKs5H+UdntzibPslamINidec/QuZPkYRFcLe4G9d4cws6?=
 =?iso-8859-1?Q?WBKw4jqvXGx4lhptztpQfQQPiFlnwwK2ODqgRhD6RvBYqXmo86z8VqaxxX?=
 =?iso-8859-1?Q?p5mFNQxyjjP2+lDWd+Q6thctLGCE2oJmMSCUx8LQiyJCqZDbOUhdRPcgjE?=
 =?iso-8859-1?Q?zLoRsM1Fod5+3pmSZgF2Mthj196wCiqJFzYoRaIMIlptkv1HNrlFL6397H?=
 =?iso-8859-1?Q?hMTGU73TpYZPIec6MHg6qta1t8Hs?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ltrg/E+CjDfPvo8gjv5FTQgx65EahJlGW19tshf+4z9N8fGFmfJ/JWblmm?=
 =?iso-8859-1?Q?SbLcFTdOjrd/tnSet7txUCMc/HIVUAglN0N7yVoyK78lME/JpgEBGfxpHg?=
 =?iso-8859-1?Q?1+7vxFmb4s0SPis+haXO4dH7h/6R8O4zsS9n871eRNtl7OJIddLyqQulh1?=
 =?iso-8859-1?Q?H8BxN1252koSedQvmUugZ2GbZjHOAGKZOf/s9dik2nEEJdEyAqndCWRK4F?=
 =?iso-8859-1?Q?T2BuaP1BiaHhAbEvSoblHomvMRLPDHiZaw6gljLOPV+62mblqTwRwWaKdN?=
 =?iso-8859-1?Q?OEeJ/atxXDzbYc4dr3P2OqHwX1AX/Qk/ZM0cHaesOKXq8obH/nDovI8oHS?=
 =?iso-8859-1?Q?PoTWq6kz132wGBJC8RS95xz+VYeu/VD5j176SyOeCTXH8OERIPYqwRqZwS?=
 =?iso-8859-1?Q?9cAESrweOcippcoUh8hPyHpgQ1XbJFwEs5L8v0ZeXUkvsuAzwQ6WUTK7e6?=
 =?iso-8859-1?Q?2NS0PAQ1Gi8qJB0Izt/8Av5uB7MvKLdAswfqUHBpq2hqxsZqKRPwUBdEKW?=
 =?iso-8859-1?Q?/kjsyxexb95aFp0oLfUZ00SSGrXPGOCw55DKYMZX1mzOAJjFeAll1SFX37?=
 =?iso-8859-1?Q?32TzehBrvpPT1SqxdPs2NkRcZWdJnKzww3/ON1ydV+u16qCAFTi8xxXAXL?=
 =?iso-8859-1?Q?IaC6EKAMr07ll7ZexBegaUhIP8LIVVKrimwnStOhMT+drF5sooYqME9EGO?=
 =?iso-8859-1?Q?LYKrPiGLa43fWO21IqMMjhsesZIdEA5fBt7cKlHMzJ6/T7gWi2vx2ap866?=
 =?iso-8859-1?Q?yl4OwhRQbK4jS4UJiNjle3lkqjBrkp+tc+0ox8mso2QPMmJd3DbQFgU+Di?=
 =?iso-8859-1?Q?L4iwJXC374zNGIYfoXhBqic/lWw2N8Ms+Jd2aYZqUiEVOgNx1+EHB8kw0Q?=
 =?iso-8859-1?Q?5dAAIsocYJ2ZziboX9DL96ORYc127XS+buAZx8drO3ZIVW2RqqJXwBMs+m?=
 =?iso-8859-1?Q?CPjsNwrQQjUFlu73w3d+MlIZy0BK5CVWhzVMuvnXShkvnWP59Bs8sImK8r?=
 =?iso-8859-1?Q?nZMFNBnNFEdapRfCbV5dz7YE2yICq2buQOWkmR4SmfKFaXvQbkR1HsG7Ik?=
 =?iso-8859-1?Q?PwHzkVXnJXfXomNOe/Jolw/6Z772FsZQtNZ8vKN/kixsW0BbTEpFtC2k45?=
 =?iso-8859-1?Q?SK4wJsTKmgiZWCV+YfqtkHLIKbclamTasCexk9FMsu1Zu8UpsdtOPA8/P6?=
 =?iso-8859-1?Q?qAmqtvJZsyIKq4qh1HmT7v4jfgjmpoMZsl95dbdXOcGoIvexiTGUgGmqn4?=
 =?iso-8859-1?Q?BWng8/+cf+d9Bv21RQYwVmGJiAydk3eQnWkiBL5yHgNTHmfoYlbun5/HQa?=
 =?iso-8859-1?Q?aLSXz0l34xe6yXtuth8EFgY4/DWRDbkacbfmlQKFn0xT7yktXPkaBVBge2?=
 =?iso-8859-1?Q?WIY2QasAE4iy8wLyLSVCbJCYMgZobXUNJ8xp0whG0zXFzoG4Dx35cWJycO?=
 =?iso-8859-1?Q?lwncWWmngeixF1dZjKebDdEZnnLNJuzocmrO6oWtCU7s2mv2rmubN0Yx+U?=
 =?iso-8859-1?Q?evqVdt2UVDppx9sTutZ4+zU2nQz2XtIOBZ2cKHpmxyPn8S4NeO9Q361KDa?=
 =?iso-8859-1?Q?4br1E0qjMlw5WLlFB2fJHw+/SEt+VYv/cpvZXUn2RZxc2BJ2oqZCcO3izk?=
 =?iso-8859-1?Q?4jtTUXmnS/XFtnNwbuW2aXvrzoItxyrOYD?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389bf678-52b6-4021-a757-08de2262c51e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 03:14:34.2283 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hlfkfVE2+lbt0hKWZqbYXXDn2zTZNlwPS//is7qMFVUK1yLXb10hpIkn7AmpBDkoLVvkwBKFHlkb1y15dclStVvEjHh2Ot/pV8JVsVJJC3Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5770
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Hi Akihiko,

> Subject: Re: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
> qemu_iovec_same_memory_regions()
>=20
> On 2025/11/12 13:24, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v2 09/10] virtio-gpu-dmabuf: Introduce
> >> qemu_iovec_same_memory_regions()
> >>
> >> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> >>> Add a helper to check whether the addresses in an iovec array
> >>> belong to the same memory region or not. This is useful to verify
> >>> before trying to create a dmabuf from an iovec array.
> >>>
> >>> Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> >>> Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> >>> Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> >>> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    hw/display/virtio-gpu-dmabuf.c | 29
> +++++++++++++++++++++++++++++
> >>>    1 file changed, 29 insertions(+)
> >>>
> >>> diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> >> dmabuf.c
> >>> index c34d4c85bc..80143034d4 100644
> >>> --- a/hw/display/virtio-gpu-dmabuf.c
> >>> +++ b/hw/display/virtio-gpu-dmabuf.c
> >>> @@ -27,6 +27,31 @@
> >>>    #include "standard-headers/linux/udmabuf.h"
> >>>    #include "standard-headers/drm/drm_fourcc.h"
> >>>
> >>> +static bool qemu_iovec_same_memory_regions(const struct iovec *iov,
> >> int iov_cnt)
> >>> +{
> >>> +    RAMBlock *rb, *curr_rb;
> >>> +    ram_addr_t offset;
> >>> +    int i;
> >>> +
> >>> +    rb =3D qemu_ram_block_from_host(iov[0].iov_base, false, &offset)=
;
> >>> +    if (!rb) {
> >>> +        qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                      "%s: Could not find ramblock/memory region\n",
> __func__);
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    for (i =3D 1; i < iov_cnt; i++) {
> >>> +	curr_rb =3D qemu_ram_block_from_host(iov[i].iov_base, false,
> >> &offset);
> >>> +	if (curr_rb !=3D rb) {
> >>> +            qemu_log_mask(LOG_GUEST_ERROR,
> >>> +                          "%s: memory regions not same for iov entri=
es\n",
> >>> +                          __func__);
> >>> +            return false;
> >>> +	}
> >>> +    }
> >>> +    return true;
> >>> +}
> >>> +
> >>>    static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource
> >> *res)
> >>>    {
> >>>        struct udmabuf_create_list *list;
> >>> @@ -137,6 +162,10 @@ void virtio_gpu_init_dmabuf(struct
> >> virtio_gpu_simple_resource *res)
> >>>            res->iov[0].iov_len < 4096) {
> >>>            pdata =3D res->iov[0].iov_base;
> >>>        } else {
> >>> +        if (!qemu_iovec_same_memory_regions(res->iov, res->iov_cnt))=
 {
> >>> +            return;
> >>> +        }
> >>> +
> >>
> >> This check is unnecessary. Perhaps rejecting iov with different memory
> >> regions may be fine if that simplifies the code, but this actually add=
s
> >> some code.
> > I think we can keep this sanity check but I don't really mind dropping =
this
> > patch given that buffers with mixed memory regions are not encountered
> > in practical situations. Or, I guess I could move the if (curr_rb !=3D =
rb) check
> > to virtio_gpu_create_udmabuf() and vfio_device_create_dmabuf_fd()
> > like you suggested previously.
>=20
> I won't call it a "sanity check"; it is "unlikely" to have different
> memory regions, but it is still not "wrong" and is sane.
I'd say "very unlikely". The only scenario I can imagine where this might
happen is if a buffer is partially migrated (from one memory region to anot=
her).
And, if we do come across such a buffer, it has to be rejected because
there is no way we can create a dmabuf (via vfio or udmabuf) for such a
buffer/resource.

>=20
> The VFIO code path still needs to check if the memory regions belong to
> one VFIO device. Trying to create one DMA-BUF using multiple VFIO
> devices is wrong.
Ok, I'll add this check in vfio_device_create_dmabuf_fd() to avoid iteratin=
g
over all the entries separately.

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

