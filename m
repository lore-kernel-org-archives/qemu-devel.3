Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C3DEB596B
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 06:31:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq3ka-0000wu-5D; Wed, 11 Feb 2026 01:31:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vq3kY-0000wl-Nh
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:30:58 -0500
Received: from mgamail.intel.com ([198.175.65.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vq3kV-00043M-Ha
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 01:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770791456; x=1802327456;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Cl2XieDHxaRihuAvfw36/GPDz3Rur/lygJvFMfwJlXQ=;
 b=kj5Mi+CvlKdw6LDNCdsObmYTttI+aWX29rQ6dtUJYsIyWbpcxlBp9yXh
 uaCkv0e7qx+tGjV/iCNRpylRBe67G7pNB5cttWnrfhzKH23UgMKUoxN/O
 HGTo1yt4EHR3fKuztFFN6T9eA16CvCSRc3Q1IPZ/TsRccYFZtZ00NuJtN
 r/Vm5xGn5q8Iwd5GYYa5cctnFeOfE2M5/WVTGVCQ9fWtRYfpZrkSh6k7K
 NZreeXoivQSi6fmMQJKyAOEfumueRx2C0HDOIEL+W9S4wKfYGXEddQM3N
 rFUJvsJyiTc9fqAr+Yo92op8OByx+7KEouJD6CNQOk7dt6eCoDioGoXL5 A==;
X-CSE-ConnectionGUID: 5yOTAhT1SoiTlq2GvCoMgQ==
X-CSE-MsgGUID: c/EGCG4XQcCpja9PKimSlg==
X-IronPort-AV: E=McAfee;i="6800,10657,11697"; a="75558345"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="75558345"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:30:52 -0800
X-CSE-ConnectionGUID: JatPqb+oQKSd6PjfMkmVRQ==
X-CSE-MsgGUID: WZqkxTppT0uiLp7z1vo6Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211121273"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2026 22:30:51 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 22:30:51 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Tue, 10 Feb 2026 22:30:50 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 10 Feb 2026 22:30:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMC+Zc6UCvxYoKisjL6TBWoemzJY0zdbsGS5KgXQxxN1O4oZVdxhcMpPG8p7rqS1J5H7EQE9HD1eoobkn/eK/BP0EKYnNPYsmVX9oNy2op9f8YHwumXULdvYqzEOC0WLiTddPbQCAbOBjIKhzp56a+sgA70ZRxsGGo1kOMBlkKn0YcW07cv4onY+Xrf/8CgYMbwDg+IV8wKn3LVKXFYstaD54unzBcikcvvWqMyHjk6en0xHZzXxy244DyIt2i3z+6zwhzcqfYemHziZ10gvK9mhWN57MbqqsduuNfvmarFgolvu3S6eDZF1AZEnXj/JFERQgbaq0as2pOzXf5Xw0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXitojTl1GZlqiygiqHSqITI+WLH6xACr7261Gg876I=;
 b=MX9IoRylWqLKQidkwILLErthBAUiKS9hLzkheG7LhHFrhHmYE2DKOaI4JgwCDS2ItsUHEfNmUeJJIZDUXiIwN0V00klLOvphKNSq877TiCmTHqlweGqns4dufrnJItYYWOzBed7MSuTICIHYlMuPRAtRmhnAmP6OE/9ChZpNiuVBiNv+loPvCBfCIlFs0thnZUJJeWgPCo8NcMp241EWuazepv1H9y/f/ICS6zcH8Uw/k7tdkZs9bQDE4tzCfn8JVg4kHl67ALhJbVZWJYnTQZKNCPQKofogOMRQr1jYpRc2BmaEq32HPvo6ck+hlYk0fsS3EXXwFXpSL7r8zjcJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by CY5PR11MB6307.namprd11.prod.outlook.com (2603:10b6:930:21::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Wed, 11 Feb
 2026 06:30:48 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9587.017; Wed, 11 Feb 2026
 06:30:48 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcmls4q3luewSeSECtMA18foJZSbV74KeAgACEarA=
Date: Wed, 11 Feb 2026 06:30:48 +0000
Message-ID: <IA0PR11MB71856CAA4507A8EFD5AF5F45F863A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260210070155.1176081-1-vivek.kasireddy@intel.com>
 <20260210070155.1176081-12-vivek.kasireddy@intel.com>
 <c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <c7c03384-4815-4032-89bd-de1ef90bb949@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|CY5PR11MB6307:EE_
x-ms-office365-filtering-correlation-id: af593ba5-3f48-4bba-b002-08de6937183d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?leQjnO+1X/G+hAgzdnPZoTLSkO/EjNNBMrAlf3TDSd1jltuEoaYbzimZAS?=
 =?iso-8859-1?Q?AgsYj74XK5TCpYulTco90r4Mdp0hOmGv5vgtw1D0WO0Lueh559MFcKuLrJ?=
 =?iso-8859-1?Q?0yA7GF2m2d2D4M7JW3yvxkxB8o4ZIlMAEWrkBQkBFBqkdIktxkVmSJnX0t?=
 =?iso-8859-1?Q?r+5tCMLYv0RiU6N4P/mE7En/P/PZ48jLj7OxnCnzfxv0oT5iR9Vakitm56?=
 =?iso-8859-1?Q?RGotkoJdJsXXKBY7AiQyRNPkBj7IEhQWz9PEqHLTgVmfScUwaXhPblQ5Wk?=
 =?iso-8859-1?Q?p/mYw+8lgi0j4HxlxsIM2L8/R2JR5khFuzepnxbNRblGlM02IwRqlXqWy5?=
 =?iso-8859-1?Q?ViRLIMk3AsPXhrKr6f4umMLdle+qcB5pQewv4GQ8sh4e0YOFt/UNF9XmGv?=
 =?iso-8859-1?Q?l88wT3j6emHpfORlbd9lcf+rEa7gM5IpHWIYx1S9kVVRrEdDM9tOFkRZbS?=
 =?iso-8859-1?Q?0dgl4UAXvbajr9lorb9uTRNV4pc3HYJOJOW+4LIAX3ZBygOyFcmfjYrTk2?=
 =?iso-8859-1?Q?8TIVQPJBR6ZGIrrEVT0Tg0OIMWQ/KI0FOIBe8Bm0X/kwWEV02JFa7dxf8w?=
 =?iso-8859-1?Q?nLZz0TizsrBq1sqZVozJ6LJ5EDHTq0LrqaAS9hoQDOUi94coh2w+R0Ok8P?=
 =?iso-8859-1?Q?dnh5VomYT+ExoW219zWfVKL7s7fbkJStklcJnf9r1iTNK/SKA7VajXainG?=
 =?iso-8859-1?Q?WE6qHeohnLeOsxZM09WbFL5yAOiT4SvpW4M9g3MetDp/7yaqJNrU3sq9Dd?=
 =?iso-8859-1?Q?8XfnJQZ2/CoGcKzIstbJyOHnCCO3suYRZQlL/ijxlbjyGGtaWlKrVnKd/s?=
 =?iso-8859-1?Q?JLLW/dgHapJQZA68GXmkGUVaCxArXudMg5r4c72MaNGuYkwEVx1vKguhax?=
 =?iso-8859-1?Q?86Zvds25mXe8jYILRPgm3g8OdwHN0a+20+aB/yf7DnhqdSsb71VDsKSkxr?=
 =?iso-8859-1?Q?m1+01GDyo6ukWPepL3uGfnpP7f6zPp+h+uDlQhkbk4AeFoKzyxvTh54zFf?=
 =?iso-8859-1?Q?IwUNYLgkDS780y46WWhM0ZcMwi0efkXzcxrMuycHltH/Mvfr45Tj4Rdw6Q?=
 =?iso-8859-1?Q?U+oaqlnsOUHzhDBF5r5RcHl6PDGQ2IPWPPyncsR4yITo3A2cNNAvIFh/Y6?=
 =?iso-8859-1?Q?XEojv66JRGBKRCv8jn4U3d9ijhb5L9CtH5AxIzArKqmaDzBf/CPIpKuff0?=
 =?iso-8859-1?Q?vhLz7R7BSSGXF2xL+lkVUDmRueNLfbuz3ui6DMNhYOU+/q9fdgUbB6Gi5g?=
 =?iso-8859-1?Q?d72b+kaY5o3S+G7Neizud0Z2BQmZA5JixTTNpz5rTX3PNVn2NJx1gY6PM8?=
 =?iso-8859-1?Q?L8a//KRCXEJZF/dbRo2THYwA0gvmqCp3F5iCV9Lz9Z78zWtyf37xGzpvpY?=
 =?iso-8859-1?Q?22Y7tc0CY1MKYLhhcMgJVBs1ZnZfXD6qkgy5J/Dak8yCv2Ygy+eYkMg1Zb?=
 =?iso-8859-1?Q?Wh4o1pQLPUlDcjwku6oEBr0lMmFES0Vxc30u1Y6TT3gM757ICMLTC7Rv3F?=
 =?iso-8859-1?Q?azxgjOJK6+4x8bbcUzZF5GE5avQ1q9p0uUp7tWJKV/rP5nHMtZK2vQL2Ct?=
 =?iso-8859-1?Q?kqfV17jg1ibjfCxUk2KFOs69ENQnPdh3CwkPYyh17qNNmRKXqKS48LWmJZ?=
 =?iso-8859-1?Q?H/5u1CZKgRIw4t0gePZjjFXbhqUuOtl96ZlqFwqudftpQideqovTA3rHBR?=
 =?iso-8859-1?Q?frupSDRtjNSIWa0WC7g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ic3YC67GZDC6Kv0s5kZGYoTdflJPxlhmT5Qg7EPIkB/fnColoS4zEB87Lv?=
 =?iso-8859-1?Q?hqcfZltcj+Ts384M7mzUp5xOGg9257WW/uRXfPN96PLSwhGbCmSMx74daH?=
 =?iso-8859-1?Q?lkRPkfcbLPjmlB/ZiSDznqlA2d+CbJCttZNwx1a6Ums2fPLN5SLpiX4vHp?=
 =?iso-8859-1?Q?3zbN2flr7U+xgeF/DoFV/Gw9h5spABGXG5e4ZOzLZdDOR+UOMMhVZldSP4?=
 =?iso-8859-1?Q?0TsT3ORXLWp1RG+Y4gNxtnIi5YmrUoWixFjgm+g6oE/wiugsgmpbLQlYN9?=
 =?iso-8859-1?Q?0rr0lm14RRwPD4A9q0viPH2xKdbHDfc7LtkE9+tjtFIYC2WbrVnd928ttv?=
 =?iso-8859-1?Q?b5XHWEAYupKKZ4/ZQzCit2MLfY1U/rk5VNG5mrEXrOxfAYVy3yIuNsWADE?=
 =?iso-8859-1?Q?rIp+jcQX34+HRjuF/Dkmdh5S+BC9H8A4BBJaClTyK04NbMk6TWld00fxVL?=
 =?iso-8859-1?Q?lUfubjEv4Q6WrmKhLXs+voA7eDKMWsRA9j/h2vTniLX+7UIdIOX/Kl8LFu?=
 =?iso-8859-1?Q?CJJJGtMjI8qmx1crNbHlR77JFvAH1vaVFne9DR3Qg3bJpjj3ZkGsr/FmFD?=
 =?iso-8859-1?Q?UBYFj3eClX26zCIHPO74w2W2oW8CSDaACNo3fLdglZRAsBhmutOXpzSlRR?=
 =?iso-8859-1?Q?VDWEaGANHZqZoy1ovoUQ1ChMkjNfu5bpZIw93zeGA96c2l+zh+eqEhUcmb?=
 =?iso-8859-1?Q?BiGG9RtElxxis7uH6Q5vp6+DLwFDQcIZ7dA4L9K+3t85AA7pVd1njstXML?=
 =?iso-8859-1?Q?5Xjqz1mICyNNErzIqsxCK1fXKa3eviQVvYHNi6GB5iTmzmiZECV2V83WB5?=
 =?iso-8859-1?Q?INie3m2yHhNe9vuKbSh9mfrNLZ8z6qExIyOxQFqTbAZWEQGC+3LLfqRavK?=
 =?iso-8859-1?Q?a5zQzlF6VMDdw50OOHPrIeCPeKzHj3TkTkj+s1xgYiLdJsLSLfZpRK+Pjn?=
 =?iso-8859-1?Q?tVA+WT/TYktG9Ecebzg2P+QOf9q8iSm78jykpVpJiymwn90mhtSN6cyOOJ?=
 =?iso-8859-1?Q?IIi5gEzFrwBLrMO89aFLTwsmdNcDItaTT01FfLDWtYyOyH/sZ4veZ973E8?=
 =?iso-8859-1?Q?8m5phyEGLekdlYcuWqawR1T+LLdmpL5s63Gr2mRNHuasWulW1WntGXZNxu?=
 =?iso-8859-1?Q?aoQddmXlNvLUPSu8F8oWijsyzCL6Vvj5P/f+Z6sGVclYCYmrgK8gDpis+7?=
 =?iso-8859-1?Q?Vo/rnVGJZyZbjnKchwdK3wfH/0wxxMiqO0GM3Te79NvQrquCuiN3KtZVjO?=
 =?iso-8859-1?Q?akyMLFJqtH8XQQ4/vCyamO9fpHUtxJ33TfQvHaODGmqB1rUyBVZ6VeDESa?=
 =?iso-8859-1?Q?NduhYd6AWtfSdR2qgZW+Lw3WuH9S/XhOvdaV2CaLZZb/Y0zQ2pSAj9G0fN?=
 =?iso-8859-1?Q?FJ5ZXtW16+k86bkxdTasMSHNQhOIynILKQUj5Ls7R/uwy33dy/O5mmMPXt?=
 =?iso-8859-1?Q?HoimZTcrQ53BFRqROorCwYKyAYeEUShr4V4XyxMHwTRBhxZLq+0YIbPTrc?=
 =?iso-8859-1?Q?qFvgvYHdi7Yzy24xWnoQCHdbm9BP61Igj4pWvQvVDL7wpMW+JEsQLVZlaD?=
 =?iso-8859-1?Q?M+kgfQJtszPRrpoGdpnIgI3jlAOhwds94eMeENhf5g0tMPrpHc4ccA2sFi?=
 =?iso-8859-1?Q?snugdWkzT+glyrO3k/KRIfFcs7e5/GoXlHDlTgst2v9UGefq6josgm7NNn?=
 =?iso-8859-1?Q?8iw0K0eHwyIiTrrJji++fy8K3yF+MuqyiBFapXlpeHLFCOGJ8C3+cKnZFk?=
 =?iso-8859-1?Q?hhORSlX6nnkdxJHf4DeJDwlo0ZEhathA3KbHZhbaK6I+C4KVbaN7GU6Q9H?=
 =?iso-8859-1?Q?muUVJlZ/dQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af593ba5-3f48-4bba-b002-08de6937183d
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2026 06:30:48.3963 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4hZQtpTucLjR7xJbMjf9Mpt3LaY6yIHXa1//tcoDxB9ZU1ohXV3AHRoN704AZZkNZRCtAYB1YO3/lXzkbsPpTNuLSQ8P3+ySLH+WCW7K9ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6307
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.15;
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

Hi Akihiko,

> Subject: Re: [PATCH v6 11/11] virtio-gpu-dmabuf: Create dmabuf for
> blobs associated with VFIO devices
>=20
> On 2026/02/10 15:59, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Since, there is no effective way
> > to determine where the backing storage is located, we first try to
> > create a dmabuf assuming it is in memfd. If that fails, we try to
> > create a dmabuf assuming it is in VFIO device region.
> >
> > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > backing storage is located in a memfd or not. If it is not, we invoke
> > the vfio_device_create_dmabuf() API which identifies the right VFIO
> > device and eventually creates a dmabuf fd.
> >
> > Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > fall back to the vfio_device_mmap_dmabuf() API to get a mapping
> > created for the dmabuf.
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig             |  5 ++++
> >   hw/display/virtio-gpu-dmabuf.c | 50
> ++++++++++++++++++++++++++++------
> >   2 files changed, 47 insertions(+), 8 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1e95ab28ef..0d090f25f5 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >       depends on VIRTIO_PCI
> >       select VGA
> >
> > +config VIRTIO_GPU_VFIO_BLOB
> > +    bool
> > +    default y
> > +    depends on VFIO
> > +
> >   config VHOST_USER_GPU
> >       bool
> >       default y
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index d9b2ecaf31..54d010b995 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,6 +28,27 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static bool virtio_gpu_create_vfio_dmabuf(struct
> virtio_gpu_simple_resource *r,
> > +                                          Error **errp)
> > +{
> > +    bool ret =3D false;
> > +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> > +    Error *local_err =3D NULL;
> > +    int fd;
> > +
> > +    if (!vfio_device_create_dmabuf(r->iov, r->iov_cnt, &fd, &local_err=
))
> {
> > +        error_report_err(*errp);
> > +        *errp =3D NULL;
> > +        error_propagate(errp, local_err);
> > +        return false;
> > +    }
> > +
> > +    ret =3D true;
> > +    r->dmabuf_fd =3D fd;
> > +#endif
> > +    return ret;
> > +}
> > +
> >   static bool virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> >                                         Error **errp)
> >   {
> > @@ -73,16 +95,28 @@ static bool virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> >   static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> >                                       Error **errp)
> >   {
> > +    Error *local_err =3D NULL;
> > +    bool ret =3D true;
> >       void *map;
> >
> >       map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> res->dmabuf_fd, 0);
> >       if (map =3D=3D MAP_FAILED) {
> >           error_setg_errno(errp, errno, "dmabuf mmap failed");
> > -        res->remapped =3D NULL;
> > -        return false;
> > +        map =3D NULL;
> > +        ret =3D false;
> > +#if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)
> > +        if (vfio_device_mmap_dmabuf(res->iov, res->iov_cnt, &map,
> > +                                    res->blob_size, &local_err)) {
> > +            ret =3D true;
> > +        } else {
> > +            error_report_err(*errp);
> > +            *errp =3D NULL;
> > +        }
> > +#endif
> > +        error_propagate(errp, local_err);
> >       }
> >       res->remapped =3D map;
> > -    return true;
> > +    return ret;
> >   }
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -145,8 +179,10 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> >           if (!virtio_gpu_create_udmabuf(res, &local_err)) {
>=20
> virtio_gpu_create_udmabuf() will log "Could not find valid ramblock"
> even for VFIO, which shouldn't happen.
AFAICS, it won't log a failure here because rb->fd is valid in the VFIO cas=
e
especially after 8cfaf22668 ("Create dmabuf for PCI BAR per region").
The failure would occur in UDMABUF_CREATE_LIST IOCTL most likely
because rb->fd is not memfd in this case.

>=20
> This logic should look like as follows:
>=20
> virtio_gpu_create_udmabuf(res);
> if (it turned out the memory is incompatible with udmabuf) {
>      virtio_gpu_create_vfio_dmabuf(res);
>      if (it turned out the memory is not backed by VFIO) {
>          qemu_log_mask(LOG_GUEST_ERROR, "incompatible\n");
>          return;
I think this is mostly how I have it right now except that I am using
error_report_err() instead of qemu_log_mask(). Do you want me
to only use qemu_log_mask() when we cannot create a dmabuf via=20
udmabuf and vfio?
As you can see, I am using a mix of error_report_err() and qemu_log_mask()
after Cedric suggested to improve error handling by using 'Error *'.

On a slightly different note, do you (or Cedric/anyone) know how to
properly include CONFIG_DEVICES header to fix the following error:
../hw/display/virtio-gpu-dmabuf.c: In function 'virtio_gpu_create_vfio_dmab=
uf':
../hw/display/virtio-gpu-dmabuf.c:35:13: error: attempt to use poisoned 'CO=
NFIG_VIRTIO_GPU_VFIO_BLOB'
   35 | #if defined(CONFIG_VIRTIO_GPU_VFIO_BLOB)

Looks like I am missing some key detail as I have tried different things bu=
t
have not been able to fix this compilation error.

Thanks,
Vivek

>      }
> }
>=20
> Regards,
> Akihiko Odaki
>=20
> > -            if (local_err) {
> > -                error_report_err(local_err);
> > +            if (!virtio_gpu_create_vfio_dmabuf(res, &local_err)) {
> > +                if (local_err) {
> > +                    error_report_err(local_err);
> > +                }
> >               }
> >               return;
> >           }
> > @@ -163,9 +199,7 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_dmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_dmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf
> *dmabuf)


