Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A7EC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 09:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUikC-0008Ma-DE; Thu, 26 Jun 2025 05:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUik6-0008MB-8n
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:18:03 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUik3-0002PR-LL
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 05:18:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750929480; x=1782465480;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=K4rN9T3LjpiaY3UADgS/FHn+49SB8eedf7AiCQRDhUE=;
 b=kD3DIm0HWIIPLGsPQnGD/4KQNsFWWvD0imiNXvKaB4v3G8MgoCW+2dkg
 D8Q3QauLq+IMMUCp0CHZF01dFtqvUKaWwAnAa/FOAdqoiOx0aBd25/1Md
 Ype7MeTUEP38YpoU/Lj/MYEhOdsKVndWYTRCOPS+AN473bOevEVtbZHw1
 /W1Iu20Y5LTOSaR3RA6nCn0VkH50Bn7cwgUdotsm5tzZMR8gkfVud5yIm
 kXrvMsWNiBUQ8+cwR2qBOvptPxtfV2I+VeSYhrx7Nak9ZGzA7ovCRXwYe
 rNCASdUQzSVIb12B5l3Yp0VGDSeCeOPtPbD++dYoRQHxCgxirH8sahWuR g==;
X-CSE-ConnectionGUID: D411rlRdSUSPYpNgeSTOyQ==
X-CSE-MsgGUID: 8SfclK7BQVq4ETwMXZWN2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="57002685"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="57002685"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:17:56 -0700
X-CSE-ConnectionGUID: erZFdm5FQ5aGwb+ieCPEaw==
X-CSE-MsgGUID: SeOZz1L3R/G+XgsMXbjtLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="157958705"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 02:17:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:17:54 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 02:17:54 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.60)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 02:17:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xt/oo+YiB39kCmv1sk4FHm/pAOzHEVCXqRpWT0nZueMOM+wQhuLSSq3oUjhGfI5SNip7x57WRUbD29J3wSjE6s9K0bJ0Nr2AiVpnqxscmlYfl18MfxPlqo1SxZ5cO2obptvtPmX8fghZs1bpYlaMGzlET9XomZbsNvpS58SS6zaAJlt925EJcUiR0zjJBc7XC+R+ovql1nnV24qsak1jZDUGy3laeQ01mMYT9bMGtyoMRiQLzZ1dVSSVfuERyxIJ4YogYzV/NV2b+UeGb0N6f9gl/O/kVI9rY8lIVslbHsuvFN1D5Vfc5qhDVrh1bxHbpd0yb+ZzuZoG8B1wY626yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AyAacUqaI81QASoRHDgXBHOFz8iuAzbK4ANeDAXoGag=;
 b=r0+CmJ+UhtEd4ezv5bolrqFzAbNGrplTtEhO2D11n4iLOJP58VDcNqeZcl3WShzngh08PY1EaNpCCXw/phqF6IEgNaeAOlHd2SnMZar2ltyjqjaOJKJDE1UrGbtiYcwUkdYUt+tNX0dciWpKPWNVvDkpBLhkb12rQuYWigOOftYFJTeAVcMlJbcoBuU+4gWC1QQB426j0Tif6PyxPZZ9XWjl2hwCQ57dTkEVZmoEgv2bpj8oQnW5fc5Pflm7auzzDcaWFBZkSzCZTesw6niMgef/se5wbZA/gx+IReAvosrcjSwpx8pkcaLMfHaTurBRw3kb1dwn6XxOwYqr7PhQ5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA2PR11MB4972.namprd11.prod.outlook.com (2603:10b6:806:fb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 09:17:51 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 09:17:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH v2 14/19] intel_iommu: Bind/unbind guest page table to host
Thread-Topic: [PATCH v2 14/19] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHb4bQ81ROJQ90600KxU9pnc9ujVbQQvwGAgARryrA=
Date: Thu, 26 Jun 2025 09:17:51 +0000
Message-ID: <IA3PR11MB91361F1F79BB367751B65DED927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-15-zhenzhong.duan@intel.com>
 <ef70ca86-d796-4a47-a66f-923f270a2468@redhat.com>
In-Reply-To: <ef70ca86-d796-4a47-a66f-923f270a2468@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA2PR11MB4972:EE_
x-ms-office365-filtering-correlation-id: 6f03fc67-ddd6-4372-d9cc-08ddb4925362
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?mdYEw+2pfYP5+/SrxI1urs+zQ2Nyy4jxACJFWzwInmUBAUKc2oMIIm4cE9lJ?=
 =?us-ascii?Q?p5mhjkJSGOSnclDAAY0k7tMoLgOZ+92OBfna5ekIEeumWObqmRoKb3mpC8YH?=
 =?us-ascii?Q?GMXMhd80D8P9Q2Om9N0XGwimqq+aqLjXW0sUqiV30AaoApzSMEoXOqQR9/5c?=
 =?us-ascii?Q?e/wNnJiMtLEEiFMs+M8zydUQD8q1AsHcJQvOJbgIPV172saORc1H4wrfVcOB?=
 =?us-ascii?Q?s1zcLpaBIkLkLE0jGf0r16nOeCivmbg6qDq9yhjCc+jWgjXoYiLfTgO1Tpq4?=
 =?us-ascii?Q?wqECrAglExMxijzrqxvRwntAEEoH1wTt0yOiWthQ5ekyXqkQW2g2Io1iPpIF?=
 =?us-ascii?Q?TnHqWw0Prz7KvWojr6lLs5qtuKC93G45k7fxvS4lTNL7MvvRsBNljgBRnFP5?=
 =?us-ascii?Q?m3hd7mjrWe6j+tUJKBrFivy4zumtiknvx/GFdGFPJ+vGNR8DzZhR1JJGUTDu?=
 =?us-ascii?Q?MZ19cWhVZkOGMIvsplfAsViFaqh3m5ZVx+cFZgB0qorMhQLQ8x6Y1ZLL0yv8?=
 =?us-ascii?Q?ZAsLGoheQ0UjH7pJQqUL8cOA9yA6+hWmEOUa/pi94mbntI/An5ociI/ROi+z?=
 =?us-ascii?Q?ldfbi37BxeKBAUMRebQdMgMcJXzr/to9naoJ0z0P1Vl6/RXMen6vweSvfrmL?=
 =?us-ascii?Q?3q9+1i3WKIUuwh7GyK/T+d4uvIbWTMqVY6Wuv0FTuSJt/B36lzHEl+jtZFO9?=
 =?us-ascii?Q?1BKspD28ncw7QeUoeSJUyAidl7UvHnIap+uZkb3w3iKbwEueYlqlnrK8adRR?=
 =?us-ascii?Q?Py9iHolhApKPl/QhB8fnsEDRDpmdkwMLhV0y3yMXWwvwy/+vQ6kuEMV7lGU9?=
 =?us-ascii?Q?l2TPnfY/DOwu1fOG7oHj1IyrT3uIGWBGpfHDcnozZPBfdyTpKkrrodq1gyiB?=
 =?us-ascii?Q?bcqzZaw37PfH78wTWosjDBQ2fYSPD2ER0rEztGZafmzfjNyx9qnIO7e3DBXc?=
 =?us-ascii?Q?mDqAe3jBbFoa6MEGsziB6vXWcFfOv22CUUG1d30vUaXIexM5Hu6OT5s4cQFh?=
 =?us-ascii?Q?QhRiDJLyPxvJarhNjyxeNMFtJpEVmvN9z7fFHokLMxrJFHYh2JMYToVraQQ8?=
 =?us-ascii?Q?ImYhmNhXkNtsMAjwy+bNd+eEjFp+5fjbKrf+1DEuex8P62ccXfCQ8cDZ1O3L?=
 =?us-ascii?Q?WtQFbTPU6s/GDTFgr4o7fNnjrrJztIUDyJXXaTJZDIWUb8HTuSzMo81mAwcy?=
 =?us-ascii?Q?aeJS97gf85U+17WZMVSbMEforHmwUnIvkm8ydqNh3h/75oTRCmCrCN+gS/6m?=
 =?us-ascii?Q?2d8GmeqwmKiw5Mwz1FzRIs7M7UEM6+pyAzgXbLYR+i/qHryrA/xAFcBEyT0Y?=
 =?us-ascii?Q?3U2I+8UpT7DxHA6be/oYVBuu9+iMvc/bij+/t77eASIsUD1xwsKBJqmGciV4?=
 =?us-ascii?Q?5V1Yg6oVJh1kAGzKED0aHuZn5XpXBg+iso+ph7nG2a8PeIVSgMyVS0LfXoVK?=
 =?us-ascii?Q?LlBljMzLYUbls5WThqLVdRzBhxlX63+1YAgL3WfvgGVpiG5KLHq+cQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?H2DjdPQQiNxKNR1y4C/Aw26yk+GOXKIJdK3Vy8TIv46tCbosKOz6ps0GZXTb?=
 =?us-ascii?Q?vU5Uv6ZIFKFU0yot8bG2P586unccFKbA+4iJAOrggnQVOcQU32wi7MW4uyPT?=
 =?us-ascii?Q?1nj5ijHPpWSRjFiIPK51X6wSLni4STYbSnR1bE1GQSwLgcRcdCVE3vnE1Iqo?=
 =?us-ascii?Q?kOy5mtnR3G1tlqInQhG5Ezz5LSOzFxVeZRRZnkPxei004GRKbVB3ZugXvkmr?=
 =?us-ascii?Q?EPVMbb593dyzG1cnHVtDnQXbKuFCO3kN+RbuUpv4NiBixSZdrzihHyn4ecmx?=
 =?us-ascii?Q?tYtHpoPTzVV/g89yCc0TmOdSSzkfuYliNHpPBth3dMxDnzUS51vU9ys9jVzl?=
 =?us-ascii?Q?aY2NB4pSoyFtoavEckCMvGDf6e5yK3fhAqk6DwFMoABu6icoMB7jZV9FlpDJ?=
 =?us-ascii?Q?WZYLNxKyMHKFS7nVtmUyWvSiM2q2VGZA+W/5vlS3uAozkThNx2wAuzPiURjn?=
 =?us-ascii?Q?/coO8nt0AiiLiqJJVQ91YNCJkhKH75hq+EXUKT8x4CBgiilW6Tv4J05aOSlw?=
 =?us-ascii?Q?tGH+FJA9r7+In3FD6gjOmsATH1vh1Bx/RaFhlyMzt5Z1KAminrgMX2I5pkqY?=
 =?us-ascii?Q?hAkhYyBIiwKMjVwSvoxeZDRt+1rYqL9GCT2pHC6oii+oG47rOf9vq2pbNWNu?=
 =?us-ascii?Q?W3AcfK2PUt30+pou5sEQz6p1zDX5J7aqRrZhYnXl+mHer4CodNAAWSfAz905?=
 =?us-ascii?Q?la/krywAVa1j7IPweGjrNEVSTa/aVzTMuWhv5sQLs92n0h9ib7KgkQ8vkDz5?=
 =?us-ascii?Q?dOKLaLVOSuQgRHPwA6v342en4at2G62C5/QTJ+ebo5dzuSBcuI0iZM6WFUql?=
 =?us-ascii?Q?yo9UbQ/I1Bv48nOlH/ORyJrNJXoWjI9faYSrTn9HMdJg315PxiIDBiYaaNct?=
 =?us-ascii?Q?44ckk1zs+C8wmZN67xrCx0adZ8cq5/ZmnYPXo74sDDLDbHRizpC6fZAhg60W?=
 =?us-ascii?Q?FNXkXd2m/gU+kQvH9mMZ1z63ROOb32sYiv4Nnv3Q/5p4AhOgjIN2PlShptFy?=
 =?us-ascii?Q?l+YyBekrMJPv0ELRzM3Ay5ofj3lHogAIWlctSiBey3XxLa6a+hbG6hilHxRE?=
 =?us-ascii?Q?FdMqpLgoVnifQoY44z8E3jkAFDKxpCM37G/3bkDFNpLjSDAgG8iMyggu+XeJ?=
 =?us-ascii?Q?vMyCyvX9VbQ6QtlYsH+Rra8V4Z2Y5KDVp1I+XBF3vE7mc0g2C90b2b3YRxrg?=
 =?us-ascii?Q?FdzaAHonKuGL/uhadKJ6AH2IsGMShr0IdgTtC4odyaFGZTA0UkwS+mhCUrGY?=
 =?us-ascii?Q?8Ka/VlKElK/sbw2yRxVOVwphRzgKQ9JnBdHdKBwUYx75GB20FBcEY/HafXCu?=
 =?us-ascii?Q?ckD0ZVXtm8DMx8ctIUwniTomxybkSBDoLGL1DLYnJB4jbR5wE4FHxXPhGaSG?=
 =?us-ascii?Q?dDjJtgSxFaMlLzgz5Yv+pAWT0L66tFJ68szEYaZpWM0Ihf+Cyl3PcOaNoGL+?=
 =?us-ascii?Q?ZuVcJkMi+CxrAk6R2Txn4rR6By2LLCglurLCvn4j5A3WfY2WzKazkFxkr9dm?=
 =?us-ascii?Q?YdC8N6Vcd0HKjIw5Ujqx4KmhyoXnoBjDCvqNmN7bua5b9ei4SPdhxP+mu7/J?=
 =?us-ascii?Q?P8rA8uYuN7oee/afK+Eeyqt1lS0EYtUSdQ1LM7A6?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f03fc67-ddd6-4372-d9cc-08ddb4925362
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 09:17:51.3385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z7kvoGlL/gfry0S69aEB1/Ek+wjcFmknW+8znIdfe+aejz88MpivKyiJhwh7cRRupGXP6XLnY8KDNYNaNT7MIy6/ogNlF2SM7Gk+D55XYo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4972
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
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



>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v2 14/19] intel_iommu: Bind/unbind guest page table to
>host
>
>
>
>On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
>> This captures the guest PASID table entry modifications and
>> propagates the changes to host to attach a hwpt with type determined
>> per guest IOMMU mdoe and PGTT configuration.
>>
>> When PGTT is Pass-through(100b), the hwpt on host side is a stage-2
>> page table(GPA->HPA). When PGTT is First-stage Translation only(001b),
>> vIOMMU reuse hwpt(GPA->HPA) provided by VFIO as nested parent to
>> construct nested page table.
>>
>> When guest decides to use legacy mode then vIOMMU switches the MRs of
>> the device's AS, hence the IOAS created by VFIO container would be
>> switched to using the IOMMU_NOTIFIER_IOTLB_EVENTS since the MR is
>> switched to IOMMU MR. So it is able to support shadowing the guest IO
>> page table.
>>
>> Co-Authored-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu_internal.h |  11 ++
>>  hw/i386/intel_iommu.c          | 244
>+++++++++++++++++++++++++++++++--
>>  hw/i386/trace-events           |   3 +
>>  3 files changed, 243 insertions(+), 15 deletions(-)
>>
>> diff --git a/hw/i386/intel_iommu_internal.h
>b/hw/i386/intel_iommu_internal.h
>> index 5ed76864be..92a533db54 100644
>> --- a/hw/i386/intel_iommu_internal.h
>> +++ b/hw/i386/intel_iommu_internal.h
>> @@ -563,6 +563,13 @@ typedef struct VTDRootEntry VTDRootEntry;
>>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL |
>~VTD_HAW_MASK(aw))
>>  #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1
>0xffffffffffe00000ULL
>>
>> +typedef enum VTDPASIDOp {
>> +    VTD_PASID_BIND,
>> +    VTD_PASID_UPDATE,
>> +    VTD_PASID_UNBIND,
>> +    VTD_OP_NUM
>> +} VTDPASIDOp;
>> +
>>  typedef enum VTDPCInvType {
>>      /* Force reset all */
>>      VTD_PASID_CACHE_FORCE_RESET =3D 0,
>> @@ -607,6 +614,9 @@ typedef struct VTDPASIDCacheInfo {
>>
>>  #define VTD_SM_PASID_ENTRY_FLPM          3ULL
>>  #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
>> +#define VTD_SM_PASID_ENTRY_SRE_BIT(val)  (!!((val) & 1ULL))
>> +#define VTD_SM_PASID_ENTRY_WPE_BIT(val)  (!!(((val) >> 4) & 1ULL))
>> +#define VTD_SM_PASID_ENTRY_EAFE_BIT(val) (!!(((val) >> 7) & 1ULL))
>>
>>  /* First Level Paging Structure */
>>  /* Masks for First Level Paging Entry */
>> @@ -644,5 +654,6 @@ typedef struct VTDHostIOMMUDevice {
>>      PCIBus *bus;
>>      uint8_t devfn;
>>      HostIOMMUDevice *hiod;
>> +    uint32_t s1_hwpt;
>>  } VTDHostIOMMUDevice;
>>  #endif
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index be01f8885f..1c94a0033c 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -20,6 +20,7 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include CONFIG_DEVICES /* CONFIG_IOMMUFD */
>>  #include "qemu/error-report.h"
>>  #include "qemu/main-loop.h"
>>  #include "qapi/error.h"
>> @@ -41,6 +42,9 @@
>>  #include "migration/vmstate.h"
>>  #include "trace.h"
>>  #include "system/iommufd.h"
>> +#ifdef CONFIG_IOMMUFD
>> +#include <linux/iommufd.h>
>> +#endif
>>
>>  /* context entry operations */
>>  #define VTD_CE_GET_RID2PASID(ce) \
>> @@ -839,6 +843,27 @@ static inline uint16_t
>vtd_pe_get_did(VTDPASIDEntry *pe)
>>      return VTD_SM_PASID_ENTRY_DID((pe)->val[1]);
>>  }
>>
>> +static inline dma_addr_t vtd_pe_get_flpt_base(VTDPASIDEntry *pe)
>> +{
>> +    return pe->val[2] & VTD_SM_PASID_ENTRY_FLPTPTR;
>Isn'it called FSPTPTR in the spec. In the positive I would use the same
>terminology.

Sure.

>> +}
>> +
>> +static inline uint32_t vtd_pe_get_fl_aw(VTDPASIDEntry *pe)
>> +{
>> +    return 48 + ((pe->val[2] >> 2) & VTD_SM_PASID_ENTRY_FLPM) * 9;
>here again I am bit lost as you seem to look at 3d 64b FSPM while there
>is an AW field in the first 64b, please add a comment.

Sure, will add. Per spec, this helper is for stage1 address width,
AW in first 64b is for stage2 page table:

"This field is treated as Reserved(0) for implementations not supporting Se=
cond-stage
Translation (SSTS=3D0 in the Extended Capability Register)."

>Also it isnot clear where this computation come from. Can you quote the
>spec?

In Figure 9-6. Scalable-Mode PASID Table Entry Format:

This field specifies the paging mode for first-stage translation.
* 00: 4-level paging (FSPTPTR is base of FS-PML4)
* 01: 5-level paging (FSPTPTR is base of FS-PML5)
* 10-11: Reserved

For 4-level paging, iova width is 48bit, for 5-level paging it's (48+9)bit.


>> +}
>> +
>> +static inline bool vtd_pe_pgtt_is_pt(VTDPASIDEntry *pe)
>> +{
>> +    return (VTD_PE_GET_TYPE(pe) =3D=3D VTD_SM_PASID_ENTRY_PT);
>> +}
>> +
>> +/* check if pgtt is first stage translation */
>> +static inline bool vtd_pe_pgtt_is_flt(VTDPASIDEntry *pe)
>> +{
>> +    return (VTD_PE_GET_TYPE(pe) =3D=3D VTD_SM_PASID_ENTRY_FLT);
>> +}
>> +
>>  static inline bool vtd_pdire_present(VTDPASIDDirEntry *pdire)
>>  {
>>      return pdire->val & 1;
>> @@ -2431,6 +2456,188 @@ static void
>vtd_context_global_invalidate(IntelIOMMUState *s)
>>      vtd_iommu_replay_all(s);
>>  }
>>
>> +#ifdef CONFIG_IOMMUFD
>> +static void vtd_init_s1_hwpt_data(struct iommu_hwpt_vtd_s1 *vtd,
>> +                                  VTDPASIDEntry *pe)
>> +{
>> +    memset(vtd, 0, sizeof(*vtd));
>> +
>> +    vtd->flags =3D  (VTD_SM_PASID_ENTRY_SRE_BIT(pe->val[2]) ?
>> +                                        IOMMU_VTD_S1_SRE : 0)
>|
>> +                  (VTD_SM_PASID_ENTRY_WPE_BIT(pe->val[2]) ?
>> +                                        IOMMU_VTD_S1_WPE :
>0) |
>> +                  (VTD_SM_PASID_ENTRY_EAFE_BIT(pe->val[2]) ?
>> +                                        IOMMU_VTD_S1_EAFE :
>0);
>> +    vtd->addr_width =3D vtd_pe_get_fl_aw(pe);
>> +    vtd->pgtbl_addr =3D (uint64_t)vtd_pe_get_flpt_base(pe);
>> +}
>> +
>> +static int vtd_create_s1_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>> +                              VTDPASIDEntry *pe, Error **errp)
>> +{
>> +    HostIOMMUDeviceIOMMUFD *idev =3D
>HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +    struct iommu_hwpt_vtd_s1 vtd;
>> +    uint32_t s1_hwpt;
>> +
>> +    vtd_init_s1_hwpt_data(&vtd, pe);
>> +
>> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
>> +                                    idev->hwpt_id, 0,
>IOMMU_HWPT_DATA_VTD_S1,
>> +                                    sizeof(vtd), &vtd, &s1_hwpt,
>errp)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    vtd_hiod->s1_hwpt =3D s1_hwpt;
>> +
>> +    return 0;
>> +}
>> +
>> +static void vtd_destroy_s1_hwpt(VTDHostIOMMUDevice *vtd_hiod)
>> +{
>> +    HostIOMMUDeviceIOMMUFD *idev =3D
>HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +
>> +    iommufd_backend_free_id(idev->iommufd, vtd_hiod->s1_hwpt);
>> +    vtd_hiod->s1_hwpt =3D 0;
>> +}
>> +
>> +static int vtd_device_attach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>> +                                     uint32_t pasid,
>VTDPASIDEntry *pe,
>> +                                     Error **errp)
>> +{
>> +    HostIOMMUDeviceIOMMUFD *idev =3D
>HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +    uint32_t hwpt_id;
>> +    int ret;
>> +
>> +    if (vtd_pe_pgtt_is_flt(pe)) {
>> +        ret =3D vtd_create_s1_hwpt(vtd_hiod, pe, errp);
>> +        if (ret) {
>> +            return ret;
>> +        }
>> +        hwpt_id =3D vtd_hiod->s1_hwpt;
>> +    } else {
>> +        hwpt_id =3D idev->hwpt_id;
>> +    }
>> +
>> +    ret =3D !host_iommu_device_iommufd_attach_hwpt(idev, hwpt_id,
>errp);
>> +    trace_vtd_device_attach_hwpt(idev->devid, pasid, hwpt_id, ret);
>> +    if (ret && vtd_pe_pgtt_is_flt(pe)) {
>> +        vtd_destroy_s1_hwpt(vtd_hiod);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int vtd_device_detach_iommufd(VTDHostIOMMUDevice *vtd_hiod,
>> +                                     uint32_t pasid,
>VTDPASIDEntry *pe,
>> +                                     Error **errp)
>> +{
>> +    HostIOMMUDeviceIOMMUFD *idev =3D
>HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>> +    int ret;
>> +
>> +    if (vtd_hiod->iommu_state->dmar_enabled) {
>> +        ret =3D !host_iommu_device_iommufd_detach_hwpt(idev, errp);
>> +        trace_vtd_device_detach_hwpt(idev->devid, pasid, ret);
>> +    } else {
>> +        ret =3D !host_iommu_device_iommufd_attach_hwpt(idev,
>idev->hwpt_id, errp);
>> +        trace_vtd_device_reattach_def_hwpt(idev->devid, pasid,
>idev->hwpt_id,
>> +                                           ret);
>> +    }
>> +
>> +    if (vtd_pe_pgtt_is_flt(pe)) {
>> +        vtd_destroy_s1_hwpt(vtd_hiod);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static int vtd_device_attach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
>> +                                   VTDAddressSpace *vtd_as,
>VTDPASIDEntry *pe)
>> +{
>> +    /*
>> +     * If pe->gptt =3D=3D FLT, should be go ahead to do bind as host on=
ly
>PGTT. The rest of the sentence is difficult to parse.

Sure, will rephrase.

>> +     * accepts guest FLT under nesting. If pe->pgtt=3D=3DPT, should set=
up
>> +     * the pasid with GPA page table. Otherwise should return failure.
>> +     */
>> +    if (!vtd_pe_pgtt_is_flt(pe) && !vtd_pe_pgtt_is_pt(pe)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    /* Should fail if the FLPT base is 0 */
>> +    if (vtd_pe_pgtt_is_flt(pe) && !vtd_pe_get_flpt_base(pe)) {
>> +        return -EINVAL;
>> +    }
>> +
>> +    return vtd_device_attach_iommufd(vtd_hiod, vtd_as->pasid, pe,
>&error_abort);
>> +}
>> +
>> +static int vtd_device_detach_pgtbl(VTDHostIOMMUDevice *vtd_hiod,
>> +                                   VTDAddressSpace *vtd_as)
>> +{
>> +    VTDPASIDEntry *cached_pe =3D
>vtd_as->pasid_cache_entry.cache_filled ?
>> +                       &vtd_as->pasid_cache_entry.pasid_entry :
>NULL;
>> +
>> +    if (!cached_pe ||
>> +        (!vtd_pe_pgtt_is_flt(cached_pe)
>&& !vtd_pe_pgtt_is_pt(cached_pe))) {
>> +        return 0;
>> +    }
>> +
>> +    return vtd_device_detach_iommufd(vtd_hiod, vtd_as->pasid,
>cached_pe,
>> +                                     &error_abort);
>> +}
>> +
>> +/**
>> + * Caller should hold iommu_lock.
>> + */
>> +static int vtd_bind_guest_pasid(VTDAddressSpace *vtd_as,
>> +                                VTDPASIDEntry *pe, VTDPASIDOp
>op)
>> +{
>> +    IntelIOMMUState *s =3D vtd_as->iommu_state;
>> +    VTDHostIOMMUDevice *vtd_hiod;
>> +    int devfn =3D vtd_as->devfn;
>> +    int ret =3D -EINVAL;
>> +    struct vtd_as_key key =3D {
>> +        .bus =3D vtd_as->bus,
>> +        .devfn =3D devfn,
>> +    };
>> +
>> +    vtd_hiod =3D g_hash_table_lookup(s->vtd_host_iommu_dev, &key);
>> +    if (!vtd_hiod || !vtd_hiod->hiod) {
>> +        /* means no need to go further, e.g. for emulated devices */
>don't you want to check
>
>            object_dynamic_cast(OBJECT(vtd_hiod->hiod),
>
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD)
>as well.
>In the positive you may introduce a helper that returns the vtd_hiod or NU=
LL.
>It could also be used in previous patch and maybe at other locations as we=
ll.

After further thinking, it looks checking only vtd_hiod is enough, as vtd_h=
iod is
created based on hiod, and below check in vtd_check_hiod() ensure hiod are
TYPE_HOST_IOMMU_DEVICE_IOMMUFD.

    /* Remaining checks are all stage-1 translation specific */
    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD))=
 {
        error_setg(errp, "Need IOMMUFD backend when x-flts=3Don");
        return false;
    }

Note we only run into these functions when hiod is TYPE_HOST_IOMMU_DEVICE_I=
OMMUFD and x-flts=3Don.

Thanks
Zhenzhong

