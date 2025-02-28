Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59512C19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnvkd-0004gD-KL; Fri, 28 Feb 2025 03:29:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvkZ-0004bC-9Y
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:29:40 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnvkW-0002Og-40
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:29:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740731376; x=1772267376;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QDUkyP9K2YtLcw2GnosmZ+FON+tcupZI+GRg221o61U=;
 b=IJ1FI8fbcbqBalGMqkH4bSqSYomDlNRAvO41T6a3LOLvPYn2fP/Abyj5
 cZaHG+Szgf4JNLtxttRsK6YF4sKqrIZvuhA8PxBsIFb8o/nou+g/6aySr
 zH8MXPEY/g6fG9AIJgQiqzcPFWK9IPCgN0Q1q2V/tDImuh/iyHuDjU0hC
 WlR/wJvLUFdEkTOBHnsOzMrBGpLjnRme5NP6XsMTYM3yTXyTP22C2z7DN
 UXmxrzwCveIvpg0dXX3zry250JL4MVNMXk8jDCMu+IfFhyGcc/INZBKz3
 UuvCSi5F6yF1gC+t9xKAKVBrHQ2wINSuCqRFhG/B/YefLPkkzzTxXMZav w==;
X-CSE-ConnectionGUID: mSdSi9V1SrCmH8PvByw3Qw==
X-CSE-MsgGUID: kRhSc7GZQy2xpjRtmPRQvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41538895"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="41538895"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:29:32 -0800
X-CSE-ConnectionGUID: Ovt7hrBNRYqy44BYjOGHig==
X-CSE-MsgGUID: xHPxj8GLSkS+OoEtoKu/AA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="148193248"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Feb 2025 00:29:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 00:29:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Feb 2025 00:29:30 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:29:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpEi3LsM1ImyHr/qSU9SX5OYMqDZUhcYi7nYEWp+S0Xo1B/2EqJAKiEIpZHMLaqOJXb9YlW0U/dYyzhUNENcwtTndNJJhBYKw26b5GzFBwHUKMDsDeCVjG0mop+DRwpxkVtp0FGAfS7VoVqUFKD2c1ByKgmJoC0xSB1XcGW9BX0UExFSD6xjz1dMDTMmZG3w141OaRPbvESJAc98w4s4r049t1eGPW7YuKYl/V8jGbFIpx4ydJ8OsVuZd4GRXX2x8L0fuekun/77dewLJesyD1RgNKZaeKwxeW9mNrEv2t8Bhk9gd+3vqNqVdiAZ2F7llgl7ZCVgqoYLQTbfVcrRrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qt9+SlQxow1s8xuZerdEFG4GFE/62NGuTL5lc7GUEs=;
 b=WRIRh/qwwug/EyzcVR+4mJMYkI8nEEjXPKrWSux24Gfr8dsQIbS5WEgJzHTbj0Fvz9shdq9kslWijIrsPyYF2sHkHOxpzYMXyohMW94JBTAZokkZnYp0r+LN0F6l49oyR9ztJ2LRHhCdLYieQEqzaeuwtj4lrvEw0D47LDco6yYdzK0EdKzNi84N9CJg1vkRY/2wRjDBYql1oCqclttty2qvVP0KRcmjdHEldcoyYiUsexDaCgtSLUC6Xzagyx9l2ctAjGVcn+Ar/zPdZFCmdtgYzwCoHJ+rVaegnMzY0Kz7hm8xBLTIXKaVvnjGuAlYHSejwjrDQ6FoT26aSHA5iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY5PR11MB6368.namprd11.prod.outlook.com (2603:10b6:930:38::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 08:29:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:29:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Thread-Topic: [PATCH rfcv2 06/20] host_iommu_device: Define two new
 capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
Thread-Index: AQHbgqf/y3kUuFg+M0ycDVxMwbFI87NQiOIAgApqj5A=
Date: Fri, 28 Feb 2025 08:29:27 +0000
Message-ID: <SJ0PR11MB6744FAC917F2DF9A7BF9FF9992CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-7-zhenzhong.duan@intel.com>
 <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
In-Reply-To: <4f13004c-a6d9-4f45-938e-3fc8d49183d7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY5PR11MB6368:EE_
x-ms-office365-filtering-correlation-id: 7850daf4-2778-4972-e536-08dd57d2039b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?J16sBDx4+xgqhvbV9RTwHPIQvB2G5VPXZxJDB996n08yLHLYlOb8d1djT/fu?=
 =?us-ascii?Q?XuRe/Y7TSmCZRIzuFB27W34Q4NYkXLPXP6TlC8kX4TrP9IaAXQT7hLH/tkk0?=
 =?us-ascii?Q?hO+Jijk7lM5jj4wx6JuR9Fy8f8GwvkYtCliNgtD4KU2D9dblApezoKMhomV1?=
 =?us-ascii?Q?62pLTmm01cbXovYAeCTLv5K2vGNkmY1bAi7G+ocr19utmeduuzijrz+Sqydh?=
 =?us-ascii?Q?r21zSoF2hrYVdgKBNnoTuBQFC92pM2reJigN8zekvtzZ+9cgXgKfKkR5OoEo?=
 =?us-ascii?Q?MJ3wlGQWxLzAMv6XmbTGoLmMwyc7pb/RKTx0aoj3DO10MCfrZqBUatXfw437?=
 =?us-ascii?Q?sYm+Pk6pcVYIoCnEaBK4YmqJrYPbiwYMwjtnU4KCr5Vh4B+oyPWWI7J1JG+f?=
 =?us-ascii?Q?mPHFzTmDuIUM88o9ARrWMm9CSwXMX5XCeOaB0CtW9lni8L3WclR+JWbRv5VY?=
 =?us-ascii?Q?5cf/tqd4tASNyzQdQtbZSAQzi9WS6xnGahHQi1GUOeU2Gg8B03wxgj1MJB6q?=
 =?us-ascii?Q?Uqu6Wsnx2gwSZO4co1mA0IFkSDMFYI/nFLxKYX4j/bjC/zWXj5gHPdHwx6Hh?=
 =?us-ascii?Q?j9WzHHtG2Fu1HJ/7frUt0Tadjmd46xAudyqkpEHKkZGagIFZSs5BGPxyUyte?=
 =?us-ascii?Q?75l4EHGuOPhWOPVZwJdmcOQZwHu50rO/L9MR+M0NBmG/VEdbB0mn08F9Y6GP?=
 =?us-ascii?Q?f0W/y+mtHlT8eGOy91sdlvx6uHPKFPY3y0iEzz1LCaCUZ7AjgswALj2/NlPi?=
 =?us-ascii?Q?8oomg9XGkTRmpf/mkwbFx4e04iT2ulvYjASwOJr9DV/XL+4ryg7z5cOXHPxY?=
 =?us-ascii?Q?oiOFTHS9QHn6eol7K3dokW9JPgmDXmv5osZxuQzNLCFEMU11M44Ghgbdu5k/?=
 =?us-ascii?Q?Y54XyOrkM9wVJsvZraByRXb4ExN9p/44UxJISzBRoVrC5s/M9SyrC242S3FH?=
 =?us-ascii?Q?eLiruGOylXGiElU2YXloRjN+YkMO58PmCAp7vNXgM7BzVRBABR4r/0HZ56Su?=
 =?us-ascii?Q?FnW4xnqbDvMmcJzSNb0ODjUSkTK1Wko0Ue2XpEeJ9h8aukLvp2QrC/K9bg/5?=
 =?us-ascii?Q?FLo/Q/BLdhzZa/GAnBCFCZuI/ITBRkotFMaWyyizrWzuvAzIl1kUocGM2kxE?=
 =?us-ascii?Q?JPnf8XxPeVu3y3Y+4aAzkRTFW0CsOH1e0ZCijhkuDhRgejKG+vbMS7PUKoQB?=
 =?us-ascii?Q?yQIeEDV24eI8Tsg5AodORoyizFd6XDFZhcBRkx3DXMOHNGwf+nNsxxqP8tBk?=
 =?us-ascii?Q?sLR1cMGde3dmDvZ+Nwh/Q+rjdwO/2wRIwgv+PuMKLSC9dIt9qvrhENkDWfAt?=
 =?us-ascii?Q?nVq/cMZ+IX5Y8fzGZXC6uAhxKUviCmFZWXd1BhCr2znAbKgG+sskIBWwQrWC?=
 =?us-ascii?Q?7+3PagY8DZkGRsznbxa7r2bHVQyILcib5qMkrGjjk/hBavIMEF0iWAlUyesx?=
 =?us-ascii?Q?hp02acVrsHn3zpa9CaPboVXYQBu3tlBm?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s+H9aNOdTL4kGwK57ouV+JztcRILwcyArLK0WxjN/IKIfpM6IlfenK8akOz/?=
 =?us-ascii?Q?I3z8BhiFT8+X/UOf1Tc2A50Z2b9kBa2UrOH0U8rJnYJcWazP8gVObW3sguj8?=
 =?us-ascii?Q?GWMgltvarFDy4Lm1vEER5WzpOr0a6+eEMi7+D+f2CiP4txCAilid7YRZNjNH?=
 =?us-ascii?Q?6N+YnTUtp6FGi23ZSw3iINVXkHWvbZGZiQ28+LyPLlBrSEm7Mg0qTX8tRBqa?=
 =?us-ascii?Q?Pgz5jhir/fVzPvduJv9o5uDhT6c7wg8BA5zImDlrLHVeX8qH1e1BlQ2NViOh?=
 =?us-ascii?Q?2Jw4ChpWwz1jcBJxNoMR0JXOdCbaVdjhvIkz4nDQcA5S1sDEG+WAxCzp1rV0?=
 =?us-ascii?Q?H5uMxMsZTQoI3lmX0xEKJMEtzhyfm1SJLdt7FDw6gyBzHEfjkPjnEdMa235B?=
 =?us-ascii?Q?TeNvgEiPyzbb0cRTGV30qiStKtCHPxfuATFOSFqjCM6BOo4U0QKLDg5L1AVT?=
 =?us-ascii?Q?v2Plfchp+7GIcn0u8AdA7yc3U3g9OvJUJdJ4NrG5GGU0GYAYUAqaVlS3SY6c?=
 =?us-ascii?Q?CsoIzQHecF9HIUeMcKuavHVBjZ9ltHhm5CSSK7ueuJRmRMABNi76c1vPyuaV?=
 =?us-ascii?Q?5SxDJX5f+l1nm9mjDmDMhGiAeTQKmmod9G4LOKyb5cV5caR7Fx+VmXI6AQ1w?=
 =?us-ascii?Q?ezxC4DIHqErcJmnGiRfWNA/CpuAy3L7Avd6yIic+9FppXAgpVtlFghzCBObY?=
 =?us-ascii?Q?ZxmVD5GEUOBmVknwQleeSlxItZyyg+bbQthPR0EATTS4OaK+S5H//LmyMnpr?=
 =?us-ascii?Q?pZE6boFOV7EDFl6xhXvMQTOeknxr5jXjlVLViNqkI9V0cfWdYL5DRdE3MJWo?=
 =?us-ascii?Q?SQUR63fEML7h7Sn8dwK4AoDj8UDO9YPqw7NKmMjLV0oTvSiXOLKN0tAfOd6m?=
 =?us-ascii?Q?UoNF3/gNRM0/rq7tdxBh9nPeYzhTVbciz/eDdHGXtwEzeQQxf1PYMs8UGH4Y?=
 =?us-ascii?Q?rGghUHgxBYA0wkt/YcDlJCFWQdu6g3oilYKgvHQKtV4pZBSKBZGTWRY4ERG9?=
 =?us-ascii?Q?q1kHkv+aEqZAobryhzmT6a1asVVgRwMFmM1oiMciGAv4DBgYUoDLFfr7tH+1?=
 =?us-ascii?Q?tfIzaQ2SmZaudmknhBJSZ/pcGcC+Ka0JGxBQmGzlvX0GnZz3Q7tP3CIBnvo7?=
 =?us-ascii?Q?/rG4s4af1MqM8NMPnbkIB3SIpMIDEjvv/1fi2+7uQ9A54+iO14uviTjXK9BE?=
 =?us-ascii?Q?Bhhsnj9gx5xHpmz8uLNhS8Mabw7gpGHqXKtjIySp42uglRCTbtznteMk1HQ1?=
 =?us-ascii?Q?btr/Cp6BDr60gsnJxzHxSlM0HVBQOANe9/Z1iKhhz3UdYJ3K3FYRPhsFDhm+?=
 =?us-ascii?Q?qQzeEYva+Bw7GggpMFNCE1XLQ32RTMtCDbAnA/dlE7CN5fB9uRjwUNEmDV0P?=
 =?us-ascii?Q?wASLpewEaun6u6gicr9QGbCU3igCCr1j6Z8QJgda/l6s8IdDMtaGxK9U0z7n?=
 =?us-ascii?Q?1VQJXEzCmsZvrEHYFbv7z4ovNM5nsUBwXGddS7/mJfD6uKQ14KOu5Riw39rx?=
 =?us-ascii?Q?GC3DGrNbPueGuxvCyK8BeY7YuddObQusC0xtU/LW5cetKqSDqGRU/+CDxC4w?=
 =?us-ascii?Q?PuQUOyIcNLL4MbALaskGaRfb4SLuBa/3hRSaS3QK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7850daf4-2778-4972-e536-08dd57d2039b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:29:27.1705 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rLpZ7SS7VA7aTqLIRMmc1S8k95PVtHtSqM4BYf2qREC0JWhWf919Oi5zrtdhSRUphrDEVuPJAvpTiUXQY3YlLUZX/dStecFMllSkFLP/UfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6368
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH rfcv2 06/20] host_iommu_device: Define two new
>capabilities HOST_IOMMU_DEVICE_CAP_[NESTING|FS1GP]
>
>Hi Zhenzhong,
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  include/system/host_iommu_device.h | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
>> diff --git a/include/system/host_iommu_device.h
>b/include/system/host_iommu_device.h
>> index df782598f2..18f8b5e5cf 100644
>> --- a/include/system/host_iommu_device.h
>> +++ b/include/system/host_iommu_device.h
>> @@ -22,10 +22,16 @@
>>   *
>>   * @hw_caps: host platform IOMMU capabilities (e.g. on IOMMUFD this
>represents
>>   *           the @out_capabilities value returned from IOMMU_GET_HW_INF=
O
>ioctl)
>> + *
>> + * @nesting: nesting page table support.
>> + *
>> + * @fs1gp: first stage(a.k.a, Stage-1) 1GB huge page support.
>>   */
>>  typedef struct HostIOMMUDeviceCaps {
>>      uint32_t type;
>>      uint64_t hw_caps;
>> +    bool nesting;
>> +    bool fs1gp;
>this looks quite vtd specific, isn't it? Shouldn't we hide this is a
>vendor specific cap struct?

Yes? I guess ARM hw could also provide nesting support at least?

There are some reasons I perfer a flatten struct even if some
Elements may be vendor specific.
1. If a vendor doesn't support an capability for other vendor,
corresponding element should be zero by default.
2. An element vendor specific may become generic in future
and we don't need to update the structure when that happens.
3. vIOMMU calls get_cap() to query if a capability is supported,
so a vIOMMU never query a vendor specific capability it doesn't
recognize. Even if that happens, zero is returned hinting no support.

Thanks
Zhenzhong

