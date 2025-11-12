Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D393CCFA1A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Nov 2025 04:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJ2Rw-0008FJ-BM; Tue, 11 Nov 2025 23:27:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJ2Rl-0007yX-Oo
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:27:05 -0500
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vJ2Rj-0004KO-BA
 for qemu-devel@nongnu.org; Tue, 11 Nov 2025 23:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762921624; x=1794457624;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6gQ06uJ3FZUn8XJz6wJMWxMkF6kkrzEZX61Iw7tkghE=;
 b=JVuj6PCwJY6xHoLWa6il/x9BxEd1jGw6MUpY9Ok4H3lj55xgAYalfka9
 y6oZUo7eZfOAaH1ZevU/lEfUiq4EMHvWP7eJbpNzRqKXrvJ2BZOjnlGoR
 o71jm0hnaGiWLGbQXF8nPSYib/0Jf+mSu+1ItxCtPl1jXJNsLy55PPRbN
 kWm2Bp7eZ0JBNCaSR1gqfNjFbM59BZ4yyXfBMBUjJY7VQGfsziGkUwGeg
 MU8APPEg/EXlh/lLR0xQ2UC3PDkCbwq2pEDjI86aYjK0pZeaplGnlGL5v
 BzA3Nyd6tYiOLUw3+e/m1XzcCiZeDe2637FPGwUjlb+YERo4L6JlVDKwc A==;
X-CSE-ConnectionGUID: nqmLl9yeQB6eA01CsJibJA==
X-CSE-MsgGUID: rtJZBR8DSTyGVWl0HcJPdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11610"; a="76084671"
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; d="scan'208";a="76084671"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 20:27:02 -0800
X-CSE-ConnectionGUID: v/9p/CT4QeO/Vijx8wQWLA==
X-CSE-MsgGUID: Xa670b+sQ9mn3vsQJRRcCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,298,1754982000"; d="scan'208";a="188960551"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 20:27:02 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:27:01 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 11 Nov 2025 20:27:01 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 11 Nov 2025 20:27:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3WTX+HW8bukA8hutYE8djekFeoreetwy1CGINCBIw1MTQs08cF14jjPC5OaZItlvZaonJN3FY9gXLMtAR9oquREEUiGp7R/RDetOj+RiylD8Mm1uDdTkSKM0k+WQ0JFzmZAXyGAtcu4sVGaMOVJRmYCPjjpDCagCGYQLynN503glJtp2StIAr/yIcjbu0swMClO2sZeoH5jg+DMKGGZ+Er09NjSpZPa81yan4AFdzGDyj/e1jBQxwsSAi/l4VdqusDbLzd/n6E0FHS1aAGOsulb2wBjRLWq0GkyOl4MCldhscuB+29GK3MC97GsjSUE7vj8JRFa0BClyLyIDIiVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98cpvLwj5MS+HEjr1/e4FyobXjIi09DEejIZKe0H+7I=;
 b=UzE5VDGFuZXozyB/Y+R/GePeQZqF4+zJZUDuVQbQVZ6KorQkFVwO2hGFYPnXuAE7rRCEMXFTssVpG63wDJc0woU0TTweKzYt07YCGjuKZVX+2v+WoXmol0X/X0X5S+s1yb/7UGDeYPYgRzPDmDSN5+/FBgitOU9lx/WD0eWxlL//769nzNQ0ALYfS6+Sp3TC64QaPk9zKjNC9PZJ+TjMeE4e85p2pRDWJyhZ/Qhfi3wcgfc6Oc96Lka9aI1FGXPpdkxwZHyh0J2xe6Y6LVPQ2qxuG1MDtRkaqjvDsmOfHfWfhpF5RRu1lyI8vRPGQKdbt/TGqLwlmI7QfI1GDKXClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH0PR11MB5904.namprd11.prod.outlook.com (2603:10b6:510:14e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 04:26:53 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%3]) with mapi id 15.20.9298.015; Wed, 12 Nov 2025
 04:26:53 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?iso-8859-1?Q?C=E9dric_Le_Goater?=
 <clg@redhat.com>
Subject: RE: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcUTsgsJEAjPPBdEeeacaZ/CcvobTrWiQAgAEUO2A=
Date: Wed, 12 Nov 2025 04:26:53 +0000
Message-ID: <IA0PR11MB71853FE6CD48B77FA586B628F8CCA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251109053801.2267149-1-vivek.kasireddy@intel.com>
 <20251109053801.2267149-11-vivek.kasireddy@intel.com>
 <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <5c224e00-8114-4586-b502-3819770bc8ff@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH0PR11MB5904:EE_
x-ms-office365-filtering-correlation-id: 584ed4e8-1d04-4a63-18b8-08de21a3b509
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?EYSu8MVCuPSKletfgUsxUATulOXxic74dJG+nhCWwLXzetWvgwgsGHotKh?=
 =?iso-8859-1?Q?ePXFEaieqhZg+tA+SYVBpKVTGZorD4Un9rNzDyjP2OcuNwE0L8n5JxtH0c?=
 =?iso-8859-1?Q?vgF1dHczbR5pszmQI7Frq2fJn1Nx+JPTZ+1M0H2CCT4lhvInCxuW2xiHIX?=
 =?iso-8859-1?Q?cc4A1l7u/Lg00OlRP/g/8UA5UfDVTs82a01RGSrKjtLGxMnGQsuBGmNhMO?=
 =?iso-8859-1?Q?KPhop14tQ+8eaGPCwegXc/UmgZ7Z/lKMS+ElHUTAlQ57Tfs/5fc6s7djTk?=
 =?iso-8859-1?Q?q22108i5QFn9RdmDhDRWhBKbmZxpxGz145DXKCCR4eQoWC0DCfE8+dqKly?=
 =?iso-8859-1?Q?Yt9cZ8UxrLQglDyLNS/wLa987Ra8i6gUVmMe4KQiWnyudUq98lFfK3mYaB?=
 =?iso-8859-1?Q?W4X+DFZEEZQqp0O9JsK/m60cXSaCWY5xVEH59s2DvsnWGeA0t1QxLoztdX?=
 =?iso-8859-1?Q?YgWO6reu0c/3J+wSvoguGxn4T0ViEBiKQxCxm6NnV81lxgVWQQqG7BRKhA?=
 =?iso-8859-1?Q?+Z5laredO7sH1rtwDvDqci34l4uXkpWbMNKM8lNRpmCnRejR/bNydbzBoO?=
 =?iso-8859-1?Q?XbwyoFAKP3mHSH5/ZpaecZRVK2woVPwdJW+1UDTxvwT2hSBjsaZFU8roo1?=
 =?iso-8859-1?Q?NkTk9A2pCXC2fM/B6KFuvN2I49tWv7CIDzuG5wZkj16ztmScZVf6qR2MLa?=
 =?iso-8859-1?Q?6QulxM66lwX2wzzM+xznzmVkbwb05MHtxbmBGoZDpsdtBGyF+LG7qB0S77?=
 =?iso-8859-1?Q?5qCBOFhu3cs1XkVhrTpmLCyQhlEuQWBZSlDhKt/sUVd2nWnDS2XuIV2v1Z?=
 =?iso-8859-1?Q?ualqg+4uzQq4rbLT3ZP2FtxiZ+1TZLc5qGp03hHDjkLwb2IrUPs8OKktxg?=
 =?iso-8859-1?Q?t3HHa5b7GKRDuXGznN5lUE+OU1NtGDk0ixUW5V1nCMyyP6PIuKldby8jvS?=
 =?iso-8859-1?Q?V1pXs0XhlXYar/tXRCec8GB9DJiz1zvkfpoRlOgEOLSYlEyADSyktA8jRN?=
 =?iso-8859-1?Q?IuCHjYMUHOC7F+jj9X2Vas92rCgIT42Mb6QekBYQ6oHZu/k/Cocr8HA3tq?=
 =?iso-8859-1?Q?cpjGIgGFJnwSpgL5+kF10Q8CZbzwJ6WSCcuk6/qWWxrnUSsGPj7wuE4FYw?=
 =?iso-8859-1?Q?kTLuPr/dCsT84SaW5IOFHZ8CSpk03//Utt8XGIwmOEFAS12pHLgcsQJEoY?=
 =?iso-8859-1?Q?lhYVTASn9/0q7JjNuNU5YwxlAe2Kou0XqIkohBJTRI3QP1q7B2IbFsaRtu?=
 =?iso-8859-1?Q?FWd7ZR4+gIH8PxGOAGSTM4ea0T16H4OHFtCJXSTY1VAuBPeS16IEOC55pE?=
 =?iso-8859-1?Q?teBQOqFX/OKcY0jLW7UjaxWX2XtxSWvukQKrRVUA1KJH60G+fL895O6JSz?=
 =?iso-8859-1?Q?HcW/mycMP2TSo12oycJb6iz9o42JrXXA/Y0vCTj7V/SinE1swp1nRCUcrx?=
 =?iso-8859-1?Q?6P19YfgdUO98BakoovGrMeK51/gqiOWromspdOvc+PPc8G72egH0/6POS7?=
 =?iso-8859-1?Q?8ZIiUfPWKaFuZtM0ZjtlOETtgxyl/fI6wrdu/Iqk/uJXjzo7Y12G55kg++?=
 =?iso-8859-1?Q?AMEMiQvT7C9Hxyxt5tn/bbVzR/hK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GVoH2eaQON4ozripKjHonTnZs743iXA5jKO95+fO62Ox08Az5eoab57eR+?=
 =?iso-8859-1?Q?gZsWUJBdkq2oHv++k2a2WKrLP+GQ0J461VyOjA3OxF6PE15hfdHkCSva8F?=
 =?iso-8859-1?Q?WStFPnwfNWtl6kVF/a83esnKmq0rNLYzlm906w8uaaT7sVYngqGk3yyXMf?=
 =?iso-8859-1?Q?aGf0rK+qL94NinZ0NnsPGYV8Bl/2Aj1AseLmeVOqEmbub2iTnr3hzXmXhA?=
 =?iso-8859-1?Q?6u40r4T7epDTAgTTAmheWz2DrmpXeV8xMsx0am0VuQpLM3nmU8hoNDjnlO?=
 =?iso-8859-1?Q?6i07OaPJMeZAEzgt7EcPUg1jUsask8JFYAnvzLQQE8E4M0keEaLvbBhzvu?=
 =?iso-8859-1?Q?59hAgDEyv3iLemER0pIaw4Jvh3kkQP9XdGiKR1B/Who4s8bU1COFekkuJ0?=
 =?iso-8859-1?Q?3OSBzeNKpFrjWvFSfBWT3W2ifC/XVZkxPSC7KLf9BLpP8RrgIgOF+co99x?=
 =?iso-8859-1?Q?s0u0NlAuuM8PyNyMBRG8Uo9FKDCscDGNYmnqU3gWx6EorKjKjZVZTtnoVl?=
 =?iso-8859-1?Q?pcqFjDI6q1pN5AafHxfhQP0/OWv6WJ3Kb/FJPb3t2MVEF4aWYF3ReWvwoz?=
 =?iso-8859-1?Q?0BzhjMLw5hQYxMbUGqEVe7amCxHg2JSvJ8uzxcaBF+J8EetW1bQYz49d3u?=
 =?iso-8859-1?Q?5ooLF99o5CV/+2LenGFkVya3FLwvNALnfhYtCrUz9ndpRbREHLUtbbuASK?=
 =?iso-8859-1?Q?rYeFU0iJn0laVPGCz2CVnJ5+LjAVpp/ZkDgIPEE+TnJM1jDUMiuLMzleNO?=
 =?iso-8859-1?Q?/lWhdTefFfl5zBpOkZnrztss3Hf+MAb66+ym0q0adePMAWlB3g41ZWebEv?=
 =?iso-8859-1?Q?se6suuW4X11mKIK+mWAoOQ63xdR8rjhykDz7k20P3BWdzL5w7Cnz3FdZ3D?=
 =?iso-8859-1?Q?P1T8+oJ1+9FZNVuo/njS6x4ehjz8WFeh0a9gi0k3XEDz4U3qJlIUu44XQn?=
 =?iso-8859-1?Q?vSfHB0d4/0cqjy6Z34c9H20ntZwhTVew3nerwLVJVF7bWXkbdSzFqsRbp/?=
 =?iso-8859-1?Q?Ou8yVcve0qREXQlWX6LyYVphgt8Oy8vfFsSufOZhSD9MUaIqCVIpqzHA/V?=
 =?iso-8859-1?Q?9QQdr5NGSWaMlUjKDrPPBmzEbKzLQfYKOHxx1O8A9qivgONOLMMdocZfWv?=
 =?iso-8859-1?Q?3NxlKJb7rQF19hDXdvt3r4BSbMRwe7qOlzjjHIc0KDhfZg0asG0g1LDl/q?=
 =?iso-8859-1?Q?dcTbI481VST5I2qfsS5Rrjr+sTyxx1qRaCH3cdRWu7FUfZXOwWqRc6JhIz?=
 =?iso-8859-1?Q?RIrXbkCFnHWVYJdftdJIriPAggum7GPqiKBO9D2QzE5Fq2NgjP2YM46iQw?=
 =?iso-8859-1?Q?XirW1ZH239RcS5coqhQsMpUk9INivXhFev3bt+ipop0yvBWRBKcgz4I9TV?=
 =?iso-8859-1?Q?a+wymi1GHNyv7ZFCmOGbveIQpwOt45LLg4aDWSlBkZYC8BmB5prZw3HC6y?=
 =?iso-8859-1?Q?TMcheRHkLkN6QukSD+ALLyVnaZansmOms3uuugVRHV3U4u/GD0gs//0fBq?=
 =?iso-8859-1?Q?i6p7R8Tv4xMCdRaNSczxB4slT42VKGfdaET4XG1JKNbfAff2JFJ6KHFfzh?=
 =?iso-8859-1?Q?AglS57Bp4l0Hd1jb/MY97hLgcZvm6h13f/cVqnGEwvTpGVWnydUXyhb3oT?=
 =?iso-8859-1?Q?jECV2suYbP4EjGhv3RKRWATQFjpdNt5CD2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584ed4e8-1d04-4a63-18b8-08de21a3b509
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 04:26:53.3173 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /rX2L5tw5Z6chTpdrh/4CqScVsSJZGGt1jJMC+PlqJw8KnSmUTl0xy765W0Tzz5lkTVeEsQ8rNxU2lmhNduo7gvNqBDgRBqeexLmXQmc/e0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5904
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
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

> Subject: Re: [PATCH v2 10/10] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 2025/11/09 14:33, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Therefore, we first need to figure
> > out if the blob is backed by a VFIO device region or a memfd before
> > we can call the right API to get a dmabuf fd created.
> >
> > So, once we have the ramblock and the associated mr, we rely on
> > memory_region_is_ram_device() to tell us where the backing storage
> > is located. If the blob resource is VFIO backed, we try to find the
> > right VFIO device that contains the blob and then invoke the API
> > vfio_device_create_dmabuf().
> >
> > Note that in virtio_gpu_remap_udmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > use the VFIO device fd directly to create the CPU mapping.
>=20
> I have just remembered that mremap() will work for either of udmabuf and
> VFIO. That will avoid having two different methods and make
> vfio_get_region_index_from_mr() and vfio_device_get_region_info()
> unnecessary.
IIUC, the name virtio_gpu_remap_dmabuf() is misleading because we are not
actually doing remap but are simply calling mmap(). In other words, we are =
not
expanding or shrinking existing mapping but are creating a new mapping.
And, for dmabufs associated with VFIO devices, without having to call
vfio_get_region_index_from_mr() and vfio_device_get_region_info(), I don't =
see
any other way to determine the region offset.

So, I guess I'll create a new patch to do s/remapped/map.
>=20
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig             |   5 ++
> >   hw/display/virtio-gpu-dmabuf.c | 114
> +++++++++++++++++++++++++++++++--
> >   2 files changed, 112 insertions(+), 7 deletions(-)
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
> > index 80143034d4..940b0e0411 100644
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
> > @@ -52,6 +53,19 @@ static bool
> qemu_iovec_same_memory_regions(const struct iovec *iov, int iov_cnt)
> >       return true;
> >   }
> >
> > +static void vfio_create_dmabuf(VFIODevice *vdev,
> > +                               struct virtio_gpu_simple_resource *res)
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(vdev, res->iov, re=
s-
> >iov_cnt);
> > +    if (res->dmabuf_fd < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> > +                      __func__, strerror(errno));
> > +    }
> > +#endif
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct virtio_gpu_simple_resour=
ce
> *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -93,11 +107,69 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >       g_free(list);
> >   }
> >
> > -static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource
> *res)
> > +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource *res,
> > +                              VFIODevice *vdev)
> > +{
> > +    struct vfio_region_info *info =3D NULL;
> > +    ram_addr_t offset, len =3D 0;
> > +    void *map, *submap;
> > +    int i, ret =3D -1;
> > +    RAMBlock *rb;
> > +
> > +    /*
> > +     * We first reserve a contiguous chunk of address space for the en=
tire
> > +     * dmabuf, then replace it with smaller mappings that correspond t=
o
> the
> > +     * individual segments of the dmabuf.
> > +     */
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED, vdev-
> >fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        return map;
> > +    }
> > +
> > +    for (i =3D 0; i < res->iov_cnt; i++) {
> > +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> > +	if (!rb) {
> > +            goto err;
> > +        }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        ret =3D vfio_device_get_region_info(vdev, ret, &info);
> > +#endif
> > +        if (ret < 0 || !info) {
> > +            goto err;
> > +        }
> > +
> > +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> > +                      MAP_SHARED | MAP_FIXED, vdev->fd,
> > +                      info->offset + offset);
> > +        if (submap =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +
> > +        len +=3D res->iov[i].iov_len;
> > +    }
> > +    return map;
> > +err:
> > +    munmap(map, res->blob_size);
> > +    return MAP_FAILED;
> > +}
> > +
> > +static void virtio_gpu_remap_dmabuf(struct virtio_gpu_simple_resource
> *res,
> > +                                    VFIODevice *vdev)
> >   {
> >       res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >                            MAP_SHARED, res->dmabuf_fd, 0);
> >       if (res->remapped =3D=3D MAP_FAILED) {
> > +        if (vdev) {
> > +            res->remapped =3D vfio_dmabuf_mmap(res, vdev);
> > +            if (res->remapped !=3D MAP_FAILED) {
> > +                return;
> > +            }
> > +        }
> >           warn_report("%s: dmabuf mmap failed: %s", __func__,
> >                       strerror(errno));
> >           res->remapped =3D NULL;
> > @@ -155,7 +227,10 @@ bool virtio_gpu_have_udmabuf(void)
> >
> >   void virtio_gpu_init_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > +    VFIODevice *vdev =3D NULL;
> >       void *pdata =3D NULL;
> > +    ram_addr_t offset;
> > +    RAMBlock *rb;
> >
> >       res->dmabuf_fd =3D -1;
> >       if (res->iov_cnt =3D=3D 1 &&
> > @@ -166,11 +241,38 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >               return;
> >           }
> >
> > -        virtio_gpu_create_udmabuf(res);
> > -        if (res->dmabuf_fd < 0) {
> > +        rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +        if (memory_region_is_ram_device(rb->mr)) {
> > +            vdev =3D vfio_device_lookup(rb->mr);
> > +            if (!vdev) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not find device to create dma=
buf\n",
> > +                              __func__);
>=20
> This should say "VFIO device" since no other RAM device is supported.
Ok, I'll make the change.

>=20
> > +                return;
> > +            }
> > +
> > +            vfio_create_dmabuf(vdev, res);
> > +            if (res->dmabuf_fd < 0) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not create dmabuf from vfio d=
evice\n",
>=20
> Nitpick: let's make VFIO uppercase as other user-visible messages do.
Sure, will do.

Thanks,
Vivek

>=20
> > +                              __func__);
> > +                return;
> > +            }
> > +        } else if (memory_region_is_ram(rb->mr)) {
>  > +            virtio_gpu_create_udmabuf(res);> +            if
> (res->dmabuf_fd < 0) {
> > +                qemu_log_mask(LOG_GUEST_ERROR,
> > +                              "%s: Could not create dmabuf from memfd\=
n",
> > +                              __func__);
> > +                return;
> > +            }
> > +        } else {
> > +            qemu_log_mask(LOG_GUEST_ERROR,
> > +                          "%s: memory region cannot be used to create =
dmabuf\n",
> > +                          __func__);
> >               return;
> >           }
> > -        virtio_gpu_remap_dmabuf(res);
> > +        virtio_gpu_remap_dmabuf(res, vdev);
> >           if (!res->remapped) {
> >               return;
> >           }
> > @@ -182,9 +284,7 @@ void virtio_gpu_init_dmabuf(struct
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


