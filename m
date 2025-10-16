Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB6BCCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 05:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Gey-0002Mh-1i; Thu, 16 Oct 2025 01:36:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9Ges-0002Is-Db
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:36:14 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v9Gep-0004VR-QZ
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 01:36:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760592972; x=1792128972;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=BN6SbmnY3NkX37ql8SKyFsYFF1LusPrj1NlfMbwutvU=;
 b=NhlC2YlJ7WodYIz23ialv6lX/Sj7bQsGtzS7tIFCBNbCXxHuz1/U2Df1
 lj0lRnwf3lx4tbSD9ZgnraveZWdN9bwW3mPKYpZeky7z26Glg9JqdEis4
 Kypg3MfrCV7FDWipJ4A9Ts0yZgc9CC61onLqhSrMdvIf92PbtuMGoK04v
 +De1aXU4fblZJZponJswLr7SvDif15MejGx2iDEdIbOy/iy+Su1UHuTnR
 9fm21ym3/c6xxPA8n+5ji34nwb6o6xSfPNSFH3FiuonUp+vzS8aU/pxBe
 Ykx+z10eGg7pUIYTLX9rTJKzxbDXcOKxOF91nitl6joZizkg93EzcTGL7 A==;
X-CSE-ConnectionGUID: O+XBtiT7TYKJ+pBBXmbnRg==
X-CSE-MsgGUID: WdWfLQS5SVKv3J3sXf6fFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11583"; a="73887924"
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="73887924"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 22:36:10 -0700
X-CSE-ConnectionGUID: jSFnldV5Ta62HIyhXJ48mQ==
X-CSE-MsgGUID: 8GUomeFJS6CSleo2oJJg4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,233,1754982000"; d="scan'208";a="182300547"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 22:36:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:36:08 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 22:36:08 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.26) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 22:36:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f2myXWSG4GW5cA364KN/IkobOO3aBS7V6k4i9qUpMjmlAeKHzw0etv+b707JFyaxsOnYQqbPtHZ7hQYpHj+J+KO3TpmRe9i2yPv9dME9b0gM33C15yFj5fUwXDvVQY0FeDkzP8/0mlFTzfMMi227iAgk/D22tcBxCfoquvRiGXv/BwM+QVSWt3t1oY2JRFsK0YGTNxUQkaI5CgJWY5yUbLLvNmi2sOSLvVrH8YmwsFJwnHXCAkUfahn8EEpLlVYGgUi8OrwmGZCEv7aTeQvSmjwwIrFND0Q72xcG+9lOOxnf/8YWcGQlO8flECay9KSbR0OrygGbaFmFj3j8Ch3ogw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BN6SbmnY3NkX37ql8SKyFsYFF1LusPrj1NlfMbwutvU=;
 b=fSUFk4XYYI9kq4XQcqIrkI+PL89r8GBBTJ2bT1tCrijn+dipVVoUeRS8hkSc5QXyMKXZ6DMl6Zh2J0VW2YyP/dtdSjjhENu+P3asXglQChbhB2mXfrYApyCa30SLdUMFr3RLGFJWZ1w0k0BloU5Vl2YbnYBrai0fbwGoYIowYyQT0fM7Yx/jgahQR3JKuPVpgzQPb909/2clqFFATgaCfNPy4VbsqT2BRrt9xZTNhW37EoUYHOP6XR82lEW6Jae0eiJtvn7oM4JOhhVOJZ18CiH3v1u7sVmLaXqV4YlroUiWFa/J8g7aD5Bbv6djIaVKRhFB3oLV77norW2AdcZc/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 05:36:06 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9203.015; Thu, 16 Oct 2025
 05:36:06 +0000
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
Thread-Index: AQHcNL+RUYjirTlu+0+SWGS5LfcOTbS60JoAgAQ3pzCAAhCigIABcDrggABCiYCAAVLIYA==
Date: Thu, 16 Oct 2025 05:36:06 +0000
Message-ID: <IA0PR11MB718592F15E431D03C1B01762F8E9A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-3-vivek.kasireddy@intel.com>
 <1fd966d9-95a5-45aa-8a20-46f2987cd65a@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB718547E3A9E97A0DD6A4A2D6F8EAA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <ba762750-cab1-4cb8-a629-101de5fdc179@rsg.ci.i.u-tokyo.ac.jp>
 <CH3PR11MB7177C4541131508F53BD27F3F8E8A@CH3PR11MB7177.namprd11.prod.outlook.com>
 <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <955ea687-ed25-47bd-9ba9-73c6b98c8e29@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW6PR11MB8365:EE_
x-ms-office365-filtering-correlation-id: 33403aab-ac48-4f6d-ca08-08de0c75e712
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?lCEGw+pr855mbHZBK8byWiFPipAdEzKrKUlOegRDKLmwIfUtEXj2/eIZRR?=
 =?iso-8859-1?Q?4s3XJUVim2eIsvpJTPdCPwgNU/6QQ8w/pUYYn/QFYkKeO4dCMA6QoF5YeH?=
 =?iso-8859-1?Q?UoKX4cJABssKPoxRQq1Q8fuaQWTR9cinT9zEaoJ6pm0zqQH74FP2Lghp2t?=
 =?iso-8859-1?Q?iAdZcWzfJjdcby7JMFE/f93KQTcx056nWzth8M4vgFJDjvhfeqE656IEWq?=
 =?iso-8859-1?Q?89qeHRjrPuNA7+n2RLWrWhVmoR1zJ6LS8oCMMCaznK0aC/CxBHR4YrmFdH?=
 =?iso-8859-1?Q?6GGRWY0JmYjD89padc2wFyd5J2U94oZfo3UlURBnycYUZS3SCD60bGQEbp?=
 =?iso-8859-1?Q?h7fozU8ciFEITU9Q7JszU7V3xcsnyCtykH6Uszxw31d0b9BMMMR66jRI8E?=
 =?iso-8859-1?Q?YRy39L2KfizK86u5OuJaxUQEUvy/MjO0g1EZhY4LZeldMYTzp3TZ4AnCP6?=
 =?iso-8859-1?Q?19MRF9lc8Ckj24pNH/SlWoaiN7NFGtc7hr0OQpvi8Zq5NG1iYNAR/e7hbu?=
 =?iso-8859-1?Q?qLiNy2ehSPBLGKVEyWDawHgzPPJZJbmLZWfZ74jTCsMhupbOyxDf3jdPGW?=
 =?iso-8859-1?Q?+YXKnruMZiQW82FH+O/Af8Ygpsf2rPErUqzlKGNDTpWnNyBj7BvoY7BD4/?=
 =?iso-8859-1?Q?mbZpmLpZJhiM+lUIojeyvHCo7xyd/AcLEs5+VN7vt9m4rE+kpkaC7/SxvB?=
 =?iso-8859-1?Q?AD1epsOq25tEqQEKcby4ugeQO9ezJRte5DV0+GpV/oO7sJDCHg8FfuX5qv?=
 =?iso-8859-1?Q?olS/L9cKOYmv8GmxwrMPEoZf3r1DI93xfUXIYzQ8h2Q37KgSUIxmDf5XcD?=
 =?iso-8859-1?Q?yPKklx3KbQQ0aAiP8MG8b+3PkVZqXhsbGlHMUweLBqTPoXk/jyDoUcpAuY?=
 =?iso-8859-1?Q?7yNAYJm4OtyXdwA2XcIlKYdRayCVdB96K7tw4vfLLFnffU3TrhSvW3dHcb?=
 =?iso-8859-1?Q?cdfXuw7sVCYU9/Vz3YZhsDchoCb8zsoKT8DKmxUFULPTnQxlrMahxIi+1L?=
 =?iso-8859-1?Q?dmIzToO6r20465/2m1e+JjcQbcKylHCUMpv/0b11qv6v9sgyWh9K71oBBW?=
 =?iso-8859-1?Q?hjw3O/4AHCfVDzWzS3bkgZpdZ7yeimjUq++fjDap1gq8j4tm7pnSZCKUaL?=
 =?iso-8859-1?Q?+STU+DP3LGrTb5gVWPNiOg4cYP3jXCMSWIyVwNsEDTjddIH5zBX8a9f0Zt?=
 =?iso-8859-1?Q?QOS0BC4V46a3azMX8W2MLfeAd1zAS24E/ub/BPlKdyf68RfylPoAjySw9m?=
 =?iso-8859-1?Q?ubwY5788zjlEKAI1GEXougKsiPCyGWiwSjg0nCuXrhkr95lj0s99qD87RA?=
 =?iso-8859-1?Q?h6qTH+6XalGoY5NTmiuxWdUkykz8goo50VZ2I0xsV6reiURMjGcAQFROD1?=
 =?iso-8859-1?Q?hpwW4HOo0QnnnxLqUFlwcoQ0wMYGBzfO8KxhCUQq/aGBVswPtK8w8IZ4IE?=
 =?iso-8859-1?Q?lPa2XcQgPhCN/10Q7XZrjxr0+OVaMXamwCSDa2pb3/7CQBV8VCft2XOINe?=
 =?iso-8859-1?Q?nEEiJvUXpJP7F0F7ZKCnSy7H+Yi4/TfFyO6VVvboAtN3I9x1SEmBet7Swi?=
 =?iso-8859-1?Q?A8LK+po7F14tttZWGI/dqoURo6KU?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?64AFBxv0pH/L3jmbYHEULdrduY4wnhjsgP2CsmrlgOfdN+ms0J2MvmGO4g?=
 =?iso-8859-1?Q?4gbGBWf+Cvvcw5Zt1E3jwWU+66ec01yElaV/39lOjWeK9OI8R0fR5AmKaa?=
 =?iso-8859-1?Q?5EjPyBTmHMxcxw8qxb9O3CJy+wTWfm0u0wZymhXSSMXnmCw7ya8jJrlDCd?=
 =?iso-8859-1?Q?YXT609B1y0jlMkkITpZfS69DP5wuUZ3XNvBTXqXBIxQRBv9psvXbs3cJLZ?=
 =?iso-8859-1?Q?qnHqvU6eljMvv1AZmTKrZKtze/Ldx37LAY8WBl6wi0Xxk3/EpM5j1zYflB?=
 =?iso-8859-1?Q?ru+n5e1s9ShGbSonMAnOsW4LJSSB4Le5R9dTCtQd8zXZQpZd+C9k6GsUc1?=
 =?iso-8859-1?Q?vNmTh7bQT9/25nAJkZm0NAKWNJUnIsLSx8pOrIZRahcEvumhVHD3OUvAd7?=
 =?iso-8859-1?Q?+7jB47/YoOFS9OWx+8xra3e7Bb/YlR9ie6CaEe0UQT2tWTaizEDvmlpoJJ?=
 =?iso-8859-1?Q?M2M7iLGcMtobaL8jZM6qkKt+wdKKo/mdn/bGWwFMs+vGfVeDj9k4uqWpBg?=
 =?iso-8859-1?Q?QN2WTqYEwXKZByBFy/ycg7UQxn8R2VsA5sMe30QxbXYQ6QcEezfxfpgcUi?=
 =?iso-8859-1?Q?aDFcxnauZtuu4FJOxQVyAuPqW4YLGbniSM9kI9PmxqYVBK6HVJCcdQz8d2?=
 =?iso-8859-1?Q?RKYuO3mc13bakRYTKtnRKha+IKJvtUwL/ogJPlYvqiVPsERw2yLKkjP4kv?=
 =?iso-8859-1?Q?pctKAMvCggezQBD8+V1Ei90eDqNQix9mww4h34H369RqbIAvWVC3CH0II+?=
 =?iso-8859-1?Q?AqrM4n53t70OxiEvZJb71P2qDJL8yvKmt9MnzoEO4nkmg1U610q2wz2DNP?=
 =?iso-8859-1?Q?E+Z2oz/1a13Au9rZ4kMTATDns84o0wkiDNLAnuDmIegLeUN/gxQKKxbow2?=
 =?iso-8859-1?Q?H7yvy6faRMdo5/Pk1Ta/LstQFRachhNQ0hl2ZryGmK2TQB5MEr3tKealRG?=
 =?iso-8859-1?Q?ZHsxhCS4sfMt6/TOieV6u2AqnK9u0p1bX5OFLj0EcWieQ0F8UIU9kdTD+L?=
 =?iso-8859-1?Q?9mFWg0tits74MyqWInTgzBmn0pQ1h9k4xVXOlHGlQDx5uMMbGIxOWj/HDn?=
 =?iso-8859-1?Q?0pcGn5VmSbuQq+ofxTFRTYkLOO4mrveZEKUjDTK9hfUXNGg+/xE4YRujYb?=
 =?iso-8859-1?Q?W5qE6ULVSd9tjaNY4MRrJDiNmNFIodD1A9qIYLTGbPOqxFDs1nbcT0jFb1?=
 =?iso-8859-1?Q?QzesZbJam/FWV4cXu7uVSZ3KhDHp4jZ32QRcf7faiX4IPqOxOteMmfG7+l?=
 =?iso-8859-1?Q?M1mIUP3ip2vX/QM6NwLccAWKsXT3UM5KbCsuvGEoUA7JsprvIpcF2EceKV?=
 =?iso-8859-1?Q?ttDJQtvumSnDNfTBhQIwXpMyej6iwwcN5p68ghWN3Ow+MshwqETvsonNvr?=
 =?iso-8859-1?Q?Zepl4GdoElnfP9XhWZ0/E1YKCKBtYfdzOvu5wiRXH3QM2JCw8X66Mbh6LQ?=
 =?iso-8859-1?Q?mHFnBro0fAYhysmw97B83R3nqRtRF39x0bN2U3X+Eu1jyqU/hpIPZu8yIO?=
 =?iso-8859-1?Q?eGeHwZpcxbuKQ7f9ZFCnA2+TiBnPC2RmwUDngY8yO4T8yZGR8qk18jP1a6?=
 =?iso-8859-1?Q?NrssK37FrgOacYioHELz+0faAeYJv4Ym6VX4A0cG12q3HXNdkx29v3wTa+?=
 =?iso-8859-1?Q?eva1ISk4tdhQn67wLpeeMjnixidiYyQFJ+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33403aab-ac48-4f6d-ca08-08de0c75e712
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 05:36:06.0433 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FykNE/c6ISBlknIvjAQ36iRtG0P1lEen/u8K9oG7w+9xUcobrELxo6YJGC/qX2ECsijUAQI8/Yov0JjZxrZfTpWDwaoyCNNGrOYyGx2sNBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365
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

> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to identi=
fy blob
> resources
>=20
> On 2025/10/15 14:07, Kasireddy, Vivek wrote:
> > Hi Akihiko,
> >
> >> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to ide=
ntify
> blob
> >> resources
> >>
> >>>
> >>>> Subject: Re: [PATCH v1 2/7] virtio-gpu: Don't rely on res->blob to i=
dentify
> >> blob
> >>>> resources
> >>>>
> >>>> On 2025/10/04 8:35, Vivek Kasireddy wrote:
> >>>>> The res->blob pointer may not be valid (non-NULL) for some blobs
> >>>>> where the backing storage is not memfd based. Therefore, we cannot
> >>>>> use it to determine if a resource is a blob or not. Instead, we
> >>>>> could use res->blob_size to make this determination as it is
> >>>>> non-zero for blob resources regardless of where their backing
> >>>>> storage is located.
> >>>>
> >>>> I think this patch is no longer necessary since now you add code to
> >>>> mmap() VFIO storage with "[PATCH v1 7/7] virtio-gpu-udmabuf: Create
> >>>> dmabuf for blobs associated with VFIO devices".
> >>> Right, but given that mmap() can still fail for various reasons and t=
his
> >>> use-case can work as long as dmabuf creation succeeds, I think it mak=
es
> >>> sense to not rely on res->blob to determine if a resource is blob or =
not.
> >>
> >> I think the code will be simpler by making resource creation fail when
> >> mmap() fails, and I am concerned that the guest may mulfunction with
> >> such an incomplete resource.
> > AFAICT, mmap() is a slow, optional path except for the cursor (which ne=
eds
> > further improvement). So, failing resource creation when mmap() fails
> > does not seem like a good idea to me given the fact that supporting mma=
p()
> > is considered optional for dmabuf providers. And, even with vfio, mmap(=
)
> > can be blocked for various reasons by the kernel driver IIUC.
>=20
> Being slow doesn't matter, and it is not just for the cursor, but there
> are several other functions modified; I guess the resulting resource
> will be unusable except for accelerations like virgl.
>=20
> >
> >>
> >> To motivate the proposed patch, there should be a use-case that requir=
es
> >> to have a resource without mmap(), not one that "can work" a resource
> >> without mmap(). It is extraneous complexity otherwise.
> >>
> >> Such a use case should be explained in the patch message and perhaps
> >> also with a comment in the code. The current patch message needs an
> >> update as it sounds like it is unnecessary when theere is code to mmap=
()
> >> VFIO-based backing storage, which this series has already gained.
> > Although VFIO supports mmap(), it is not guaranteed to work in all case=
s
> > and with a different dmabuf provider (in the future), it may not be pos=
sible
> > at all.
>=20
> The fact that mmap() is being optional for DMA-BUF and VFIO is
> insufficient, but what matters here is whether a DMA-BUF that lacks
> mmap() is usable for graphics.
Yes, it is definitely usable. AFAICS, res->blob pointer is only used when g=
l=3Doff.
But given that most environments nowadays support OpenGL, most users
would prefer gl=3Don, which means the resource's dmabuf fd would be used
(by the UI) instead of res->blob pointer.

>=20
> Reading the cover letter, I suppose you are importing a mmap-incapable
> DMA-BUF exported by a dGPU, and the imported DMA-BUF is used with virgl
> or something. Explaining the use case will show that there is a
> mmap-incapable DMA-BUF usable for graphics.
The dmabuf provider in this case (vfio-pci dmabuf feature) does not support
mmap(), but the blob resource/dmabuf can still be accessed via the fd when
gl=3Don (by Gtk, Spice UI). Please find more details about my use-case here=
:
https://lore.kernel.org/dri-devel/20250915072428.1712837-1-vivek.kasireddy@=
intel.com/

Thanks,
Vivek

>=20
> Regards,
> Akihiko Odaki

