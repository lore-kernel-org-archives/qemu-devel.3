Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFEBFCC9C2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 05:38:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzpnb-0004c8-Mp; Tue, 10 Mar 2026 01:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vzpnZ-0004bs-Oe
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:38:29 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vzpnU-0003Rl-VA
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 01:38:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773121105; x=1804657105;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=yBSw7Uyal4m+NJu2BUD6IW53b6JC3XDp7m62D1dFwiA=;
 b=hZTJT9wVKDNELyilOBpoZTRLH5t5o7Dcwj3uknR7YAwrBX/akxQ3Augh
 vfwOJt83g6YWmNh0c59yHgsxWufwpssxr5dy0hxTWwFT2xwoH8u45hM0L
 cTSTMfhBTM386MZ9cQMDfJ9X0v5/FaT6lb0HBcb47X7UKbmUWpw2FkMeT
 TnJ/jfUCevtMQsio/JaCAfyEQUE5PN+oWmpE+xnqu81imc8ZkhSxftRNA
 C2VNw8k5IhkWkg8T9Vymi0ZY/rlmALeANHuqagD8cSkdUCEz73EKCyCiu
 trtN4r6mOMSDhetDDlIKBxn5JmBmAF3Ueel4x3PbJ3G2QgOVOWe7ep5BH w==;
X-CSE-ConnectionGUID: NRDDIV7oTYq8c2beTNubdw==
X-CSE-MsgGUID: clRYN9R9QD2DmM+Gl3goyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="74349465"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; d="scan'208";a="74349465"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 22:38:20 -0700
X-CSE-ConnectionGUID: U30znZ7xSCuO3aciTGfLKQ==
X-CSE-MsgGUID: koC8i/TpT/aN6I8BzcnyYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; d="scan'208";a="224100699"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2026 22:38:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 22:38:19 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 22:38:19 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.3) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 22:38:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqX2zSzHwZ/AmfUQx7Z8nMiDgrDKqKNWDnv4a/sU68PrV7AeND1Vpi8qEW4XuujMjkKWzhf+S7j13HXQZPlrT1B0txG1KurIHeCGpFo0sSf+8+R9c2J6LvvToVh1zOl3dx2+g/662qQbcoaozzL25zWcDcUrWX4e3DAPGkriM5Qb74r41nABLLK96ZTg2xYfOgo3VPqX/QdJ4sVnTf1TRbVljetNjOAkLY3xUN6vlOZ8uOCrCc4gDAIsY4+v/KI5H+JtvFnIg57IZcDhDtysnBruD4JhZNISJ7INm9NAAuUS4zbUpB3+OtSC2uxsN903qLmeM4kB8v8CwPuoXoCaLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkPJVgbfbUA26hZ8nQNugREWqYV7NB/AxOdTc9xDyfc=;
 b=MGLAN6dAONdXaM/d6crnQw+bDDy9QMIxJ57QAbw71syrNq5SasqiaQd7d/rNInx2uqkagT0bbFKOFUXRUmLOybY78+IU8csd8dftAGXg67nKoKeFk9DXwFHmeZhbl63nyjyqYapv0BTcdcek//wYV4VrY74VOJbvctNDZIIjBJ5OSbS+87xsAUJqUu2oZuW37JZAZXWWMBa2NRXN6KRB8C12UWqlJROqhb58ipWRIepDUr8xs5zywRL7tyM4WHqnRp1N26JpfTlezw8nb0xdRVqLV0EdkJPYTI70VLNGUgo4y50cZ1krmOUuT0kVZWt0j9ZgLFCn63aMCrFCZ4GYxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MN0PR11MB6088.namprd11.prod.outlook.com (2603:10b6:208:3cc::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 05:38:03 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 05:38:03 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>
Subject: RE: [PATCH v10 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Topic: [PATCH v10 09/10] virtio-gpu-dmabuf: Improve error handling with
 'Error **' and err enum
Thread-Index: AQHcreAP/IpUL9q13kGE2T2CRMYWq7WicecAgAQXpnA=
Date: Tue, 10 Mar 2026 05:38:03 +0000
Message-ID: <IA0PR11MB7185B020FDF01E34A56D126AF846A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260307030812.1224392-1-vivek.kasireddy@intel.com>
 <20260307030812.1224392-10-vivek.kasireddy@intel.com>
 <0fcb33f3-4d2b-4825-93ea-27dac89c4237@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <0fcb33f3-4d2b-4825-93ea-27dac89c4237@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MN0PR11MB6088:EE_
x-ms-office365-filtering-correlation-id: 873a88c7-bc74-4387-9513-08de7e673313
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: mPFMQmFxWFEcDjRH9p06NfJIIX0MNAwPzT1V7D71hKhbH4e1MIJFQd/qYoA+RYHkUWqUj9OFWHkjHQbiqxMWYRxW0MwuTx7YGWgLqWlDgqt4oIWLJTCMw2f+N0Id/8Hpi1ownLQmsX4BsvFvqGBZOXPvTxOhd1Jfnn9qnjLiNNLgFMuskiAX6u1ZSTOc5lX+gfAZkD1yOBZJZWKPCJSx+vJjW010/ZYNITSL6l+KG/BMv6NgsyQpyE7jPm/QRS0i19j/l94IBUFo0Ce8ixL6GoQ/rymKB/oB+H8uzjUJ1TfDLIcrv7/bmW8BX2stYwatI1icHDiKGsJ7wL3zp2uYQGA4lhIboCGc7JFWoCiVRseWB7PWGzv8zsSTO3trsbZAwPnBsCcU38k8diQ0cFnbNEPV59HKeLnv9MhaqEAGzHiUJS01xFh+Lsh3bRHqZ9eM9xfM18yvx+OfQxeW5ncY49g53QkytKonWhr5k4s056mq1f1H0Zos8ssiiRqluKD0mpPDGEJ0SfjuaXtiTAU95vX8p7nhWjh2PmtiuPFSsIfuB1Y+4OtJ6D+CDsP41jRSaqmfAqDyWRIvgbj+/HFYAKM94Rrr7R9GJwbTZagpdIIzKBAafYrPmPkfBMqGyY6LjGRxiWMyVU19pmfUm7o4y+7FMvNsNYbWfys/R+4y7F7wD4wKdaT+GHuwu/SXE/btv8xQRxus2WMw2bY/J3Sie5PRFWSi4tfwfjjiasZOeScocLa8uc4tK/cEkEGYMAhf6pus8MDYsVUNbpc0zBRxpLUG6RveJsZRcOiQNWZrKsc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uML4sGNkFlfxwd6HXnv3dLL7rDPsJvnJQ03UtoKCD8NyQ1pv6AmKBilg3P?=
 =?iso-8859-1?Q?OgpSMtP4YudwFLZDj2ZdN6UJqys5sZpgEwtl20c5BhLnQOPFmOKiSVIB3h?=
 =?iso-8859-1?Q?z68C2dhlFHrtEcA0GXqaJ/xTu4UgchWl7ArxHqW9DBjCXN7s44e/hW0X/I?=
 =?iso-8859-1?Q?sB1RUn0hORLJLGmoy0ItOzSzqEYUoo5q87hzwGzNeD6YNMdBCnnQAlVJJP?=
 =?iso-8859-1?Q?+N2L4inHKSy2Ef6A8DNtA5XFblDFXdYwV/yFiNem3EvX5syWTU7/Pl03Bp?=
 =?iso-8859-1?Q?jq1FFffJtmtmvnXRpq7lnfsAOVSln77GQsY2ALXGWm4VUR9udyySvSW+AU?=
 =?iso-8859-1?Q?tvh8K4pmOOeImyqXrId+uiWwtMaLm7e1ac44ct6wNqd057WpaPOY7VrSf6?=
 =?iso-8859-1?Q?eZRkdutHfIwBaMBJ1PKv/4qaSRBlBIH8/bDWTgb8lEBpZ955QAKLleCZKt?=
 =?iso-8859-1?Q?/sR4PT8mXWZqLIEHGY8UHuE+m6PgEi9HoCt+ag9tQxpgSLWex3c0B2C3ZI?=
 =?iso-8859-1?Q?PIegZc7qOmWPUk3nNnmJehceONkdsD0OTmkMR11StBFQ/Duv5Ht5meTBsr?=
 =?iso-8859-1?Q?JYUf6nZyDq2FD/SjfbIzORjZe8eG8V5hCLkgKRaJixSP26D2PM2+tI5JbD?=
 =?iso-8859-1?Q?hTpqFW6JjB4UB2T7QpXe28y0rdhLwwxCIMzzQ3JQ78w6Jl8mR7D3D6vcus?=
 =?iso-8859-1?Q?SThTB/Jtnoo0QXWWZoiZmAS8crn/CRPNeBYo3HVGV9LG3DB2pv7T/TFG5X?=
 =?iso-8859-1?Q?9iaCgVTH9/oceZz/NkFjTw4srpS0P3GmCcKriNNjC1zTZQz7LbHg/8GLaT?=
 =?iso-8859-1?Q?5SmObitIkPFjfC641a2G4l2Nc+B+cUQefmXjVX5KkmsEJ0vn1/GcA9DwiT?=
 =?iso-8859-1?Q?nURauRwx6RvWSae6wF/xB3Yak1w0U31XCB/KQJVB1WoZarom8qeDeeB0g6?=
 =?iso-8859-1?Q?fPXUE3pT18Z3qch6y6uqGSFvDytKn/jFpPrVUccGWozsRMBE6d6T8kbpWc?=
 =?iso-8859-1?Q?vT4I/wDt7hAqeDdvd/fblsxfF7inwwj7U4aYKPfe8/4T6R/I3hBRWN1T7S?=
 =?iso-8859-1?Q?sLLDbJA+s2s3UtbiApKkwsBJZnegi3UbKSmAZ2BML1irUpfuANj6GfRpBq?=
 =?iso-8859-1?Q?UH9Fg98ItqudoMUcnqSt45hjs569YopdK8W7wGwxvX1a61gp/+7LOhJ1xZ?=
 =?iso-8859-1?Q?PUZCJUx5KkNG8+4aY0cDVSynYCf99d/V0Kr2OuLNclth5AxFrbKHUxEWNf?=
 =?iso-8859-1?Q?l3Rt4S0oJBODiEPcLPMSGC+TpkT2iCYOKm+HNoTTbcLku3oE4U0P9ekom7?=
 =?iso-8859-1?Q?ZZANFgv2+ApUbJrMPe7U3B7LE/RdATzRbPzkt10dOwBzxtDJo+11cxRhif?=
 =?iso-8859-1?Q?NnOcMjECsntBQnTu8EoRhsX0uqcY78XlQDmeWDWJ5Tg+Cs/9SIr0ozxnmh?=
 =?iso-8859-1?Q?SuFFRWlSlj24k343oOXn+PWa6z7AIohV4TKAiE7dutCTpWbuWAgvULvqcO?=
 =?iso-8859-1?Q?pT3RLucgEst3p7ga/vW2lwFgkFFDLFtDPnVIcCC7rckuK+lRAkt+rr13s+?=
 =?iso-8859-1?Q?U2287urVbH02Nz8A8L4NCiEqVD9p6HZR4CIy1XfJkN/U7nsPcgMSNOwH/y?=
 =?iso-8859-1?Q?XlOrgEXfrzE4LJ+6KGeZ1xSKhxsECI1rO7Ud9QpfJ3WkxCnDYRNph9kWYx?=
 =?iso-8859-1?Q?kN3DM+83iw9wzjVz+rCJlEeeV+q5qt7VviFHYf+vdyx6MV1xY1lSvKHBvd?=
 =?iso-8859-1?Q?NUzzyZrCGwXifx9o2JumppV1nuh/fy4htc2VtgigvTbyOrqGNFhqNeX6tg?=
 =?iso-8859-1?Q?hoi3KAAvsg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: HtsZQ+3Y7iRpvfl7FVm9XQvtwOREwB3ZhV9KJuriJZ0BSG2a1avYBkZpnzV51YogLLX1hG/iR8jr0lDggIEuB71NaAmCxnXcrtnxjnweiarKp1L2ppvLyXagC8V3cJJ9wNQkK3uaawxxlZPHBJS8iRnuQy5SFJqSZksT399M/N7WrmnYFHmFtSpyXoI0od+AyNaoYJf2C+6wEqkU0CEtk7ED/FZ5KD3vjSDhKpgk7kLWQ66EQ1Nw7shZDA39xrFX4gYz5spcaG5B8PtMzRZQLpHPidzNOIO1L5rKFBHFn1i6QI5Dk9Q89xRybKA7lsx105rrbD2BwEzv3EmFLE1dXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 873a88c7-bc74-4387-9513-08de7e673313
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 05:38:03.6474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PvbssjBq96j9CQH36FIOLqCtUBXP4TDoL3S8sGI20fzLunIvOFAhQ4thQHYSx0m+jDSgJeaxR50dEIKlq4WAKAbOsdsMkuLDELSH3/meLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6088
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v10 09/10] virtio-gpu-dmabuf: Improve error handling
> with 'Error **' and err enum
>=20
> On 2026/03/07 12:05, Vivek Kasireddy wrote:
> > Make the error handling more robust in virtio_gpu_init_udmabuf()
> > by introducing 'Error **' parameter to capture errors and using an
> > enum from VFIO to categorize Guest and Host errors. This allows
> > for better error reporting and handling of errors from
> > virtio_gpu_create_udmabuf() and virtio_gpu_remap_dmabuf().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/virtio-gpu-dmabuf.c | 65 ++++++++++++++++++++++----------
> --
> >   1 file changed, 43 insertions(+), 22 deletions(-)
> >
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index 8d67ef7c2a..0a6b54fde5 100644
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
> > @@ -27,16 +28,18 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > -static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static int virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                     Error **errp)
> >   {
> >       g_autofree struct udmabuf_create_list *list =3D NULL;
> >       RAMBlock *rb;
> >       ram_addr_t offset;
> > -    int udmabuf, i;
> > +    int udmabuf, i, fd;
> >
> >       udmabuf =3D udmabuf_fd();
> >       if (udmabuf < 0) {
> > -        return;
> > +        error_setg(errp, "udmabuf device not available or enabled");
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >       }
> >
> >       list =3D g_malloc0(sizeof(struct udmabuf_create_list) +
> > @@ -45,7 +48,8 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> >           if (!rb || rb->fd < 0) {
> > -            return;
> > +            error_setg(errp, "IOV memory address incompatible with
> udmabuf ");
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >           }
> >
> >           list->list[i].memfd  =3D rb->fd;
> > @@ -56,22 +60,29 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       list->count =3D res->iov_cnt;
> >       list->flags =3D UDMABUF_FLAGS_CLOEXEC;
> >
> > -    res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > -    if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +    fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> > +    if (fd < 0) {
> > +        error_setg_errno(errp, errno, "UDMABUF_CREATE_LIST: ioctl
> failed");
> > +        if (errno =3D=3D EINVAL || errno =3D=3D EBADFD) {
> > +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> > +        }
> > +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >       }
> > +    return fd;
> >   }
> >
> > -static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > +static bool virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res,
> > +                                    void **addr, Error **errp)
> >   {
> > -    res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> > -                         MAP_SHARED, res->dmabuf_fd, 0);
> > -    if (res->remapped =3D=3D MAP_FAILED) {
> > -        warn_report("%s: dmabuf mmap failed: %s", __func__,
> > -                    strerror(errno));
> > -        res->remapped =3D NULL;
> > +    void *map;
> > +
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, res-
> >dmabuf_fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        error_setg_errno(errp, errno, "dmabuf mmap failed");
> > +        return false;
> >       }
> > +    *addr =3D map;
> > +    return true;
> >   }
>=20
> Following the convention, this function should return the mapped pointer
> if success and return NULL otherwise.
Ok, I'll make the change. I am guessing I should also make a similar change=
 to
vfio_device_mmap_dmabuf() right?

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki
>=20
> >
> >   static void virtio_gpu_destroy_dmabuf(struct
> virtio_gpu_simple_resource *res)
> > @@ -125,22 +136,32 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    Error *local_err =3D NULL;
> >       void *pdata =3D NULL;
> >
> > -    res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> >           res->iov[0].iov_len < 4096) {
> > +        res->dmabuf_fd =3D -1;
> >           pdata =3D res->iov[0].iov_base;
> >       } else {
> > -        virtio_gpu_create_udmabuf(res);
> > +        res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res, &local_err);
> > +        if (res->dmabuf_fd =3D=3D VFIO_DMABUF_CREATE_ERR_INVALID_IOV)
> {
> > +            error_free_or_abort(&local_err);
> > +
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "Cannot create dmabuf: incompatible memory\n=
");
> > +            return;
> > +        } else if (res->dmabuf_fd < 0 ||
> > +                   !virtio_gpu_remap_dmabuf(res, &pdata, &local_err)) =
{
> > +            virtio_gpu_destroy_dmabuf(res);
> > +            res->dmabuf_fd =3D -1;
> > +        }
> > +
> >           if (res->dmabuf_fd < 0) {
> > +            error_report_err(local_err);
> >               return;
> >           }
> > -        virtio_gpu_remap_dmabuf(res);
> > -        if (!res->remapped) {
> > -            return;
> > -        }
> > -        pdata =3D res->remapped;
> > +        res->remapped =3D pdata;
> >       }
> >
> >       res->blob =3D pdata;


