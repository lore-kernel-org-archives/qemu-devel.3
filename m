Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB89C02182
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 11:09:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tav4F-0008GS-BM; Thu, 23 Jan 2025 06:08:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tav4C-0008Fo-Ov; Thu, 23 Jan 2025 06:08:08 -0500
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tav49-000883-L3; Thu, 23 Jan 2025 06:08:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1737630485; x=1769166485;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WfPp6FKEQXF4Gic571Xznf7t/04msPbCa43LN78EUY0=;
 b=ntIyWtkfcLVCE59ZrNfHEpYpZfuUX1FXuQwPkhUDdOizvH6WiKUFThn+
 Jd08GYbQY52bETX6DwLNYVKpTPxa0vPjDPPpRA1Fo2PY8Oo+XZb5hskXT
 88HZwWMTa6juJ5O5TEZ1CjHaHNZ/L4RJDBlwEV2jO+BEho5TYEaXV3gJQ
 Ggwaenu6rv7jx0PaViYfBeprNofJ1JjUziFme48aVD5vNPDgkLS18CTn6
 +DBpmyX9psmvrRRVWBmyzMERsIAmpDTuWE/LN0WKSIXrjVc7MNIFT1kCq
 Ll1ZQMCTdj7Xar4Af0qCUII5E7S8qt8awYYo/prLA6RgRAWsQEM1gz5Dc g==;
X-CSE-ConnectionGUID: 9XEyWjXbSJKvhdLeICojuA==
X-CSE-MsgGUID: junYO1J0QzuxjYEiD3J90w==
X-IronPort-AV: E=McAfee;i="6700,10204,11323"; a="41879264"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; d="scan'208";a="41879264"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jan 2025 03:08:01 -0800
X-CSE-ConnectionGUID: Wz+y6O+lTGONkBm1HlKf3Q==
X-CSE-MsgGUID: +eKQvrlARVCDNsKwO2wnoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="112395911"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 23 Jan 2025 03:08:02 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 23 Jan 2025 03:08:00 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 23 Jan 2025 03:08:00 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 23 Jan 2025 03:08:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uExTM/nOpyEi6T0VxY+PAPA6sMviZITiOXm4ezj0LvHBvmwCMmxYNM7oUBqnUlSs6a+v2bwXXTv4zki+aPX3dMjpjK/W5qIJc3Z8A978r+Pl/F3Tue0Z7Ki43hSZdU4WIZ5E+8t+mB/c+1QQLjkm72iNzngABFm4stxQFbsKNuz+3G8hQJ9nTRxgDl9Y0tQDAlrgCuPQm1XMgIHEYjcYN0KJgV7UR1VQoeHlhkTYme+YaeXiuwyxW9Zzp3X2FE0t0bQ2cg9V8Z9lwdPPo14SybGikaxrwHP3QFSO7uZ905CXKoWaUZIeM158VvWxKTbGO9Iu51R+OGscqaychMzViw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fjpmArTHme6NrtXqw5bs6z05rbhOyIQMZ4IeJDAKWs=;
 b=IN5X6uXLyabC1gwm+qHea3KaT9tLbA5V359Bakco4Lg5tOQtYORO+UNdtfCdm4vE4SPP5MkOV8hloPwNYRbrBG6tvdE+kD7wu+x0m8f0LtGSuJBtVq/eToaWW43JJqHe0APAQOawmBAZTNGifOupCiUVY49HHhN82rJNWKcEX4p9v9KZljEbt3Xy8qfUKyq4hKKzEBJjjYAZ7AxODaq0frErEPBdhm55HQAPgdjPzrDeBaWss4JxlrntoW4y2yKrT2cLapvwPvZKNeTczUiKH9pDZ6nZi7/KgYkrSTlcojPOJhTudjlTTf3qiLerEgG5xKT97ym3Yi9LIKU6qXedCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Thu, 23 Jan
 2025 11:07:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.8356.020; Thu, 23 Jan 2025
 11:07:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, Donald Dutile <ddutile@redhat.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Gunthorpe <jgg@nvidia.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Linuxarm <linuxarm@huawei.com>, "Wangzhou (B)"
 <wangzhou1@hisilicon.com>, jiangkunkun <jiangkunkun@huawei.com>, "Jonathan
 Cameron" <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>
Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Topic: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
 nested SMMUv3
Thread-Index: AQHbMeB0+Q5BEZc9JkeH/U6Jz+dF4rLkOMCAgAAM2QCAAAz2gIAEhqeggCVVAYCAAxlYAIAS3VEAgABWAvCAACxmsA==
Date: Thu, 23 Jan 2025 11:07:53 +0000
Message-ID: <SJ0PR11MB6744943702EB5798EC9B3B9992E02@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241108125242.60136-1-shameerali.kolothum.thodi@huawei.com>
 <Z1wh69_gZ9izr1iU@redhat.com> <Z1wsslDnwlth3A8+@nvidia.com>
 <CAFEAcA8TW2RKyFnh-TZRpfaKfZipHD5TZy_hymUr41GJ4rs4xA@mail.gmail.com>
 <329445b2f68a47269292aefb34584375@huawei.com>
 <Z39Ugx2M+FRFVVpB@Asurada-Nvidia>
 <568014f5-25fd-439b-b70c-9cf50f31255b@redhat.com>
 <Z5HBJOgO4tUJApY+@nvidia.com> <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
In-Reply-To: <8fe09b60e6f04cc6aec99b72b46b2fb3@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7334:EE_
x-ms-office365-filtering-correlation-id: 9558b277-49c3-4e3a-2c18-08dd3b9e2ebf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?BleT+DMPGq9zoZ8X3ZfhKHG6DA7/eailgeyL28Bkk9bm0p/r0A2PeoImIC?=
 =?iso-8859-1?Q?HHiltSIssC9gMJBWqwIAVUvHXc7IQOrl3WIfG/g5z56kZFKOemHnssK5C6?=
 =?iso-8859-1?Q?PgP06yXy1QyVhH3cKXjK/jXzj8evCwLLQkGU36esu9cDPwDaMdDJuOhvnQ?=
 =?iso-8859-1?Q?+i4HZqLisu5eqzWGdSrOC4c7X/PpF6td7vX2vcj1q1O31ocsJhCaI1DGAg?=
 =?iso-8859-1?Q?5+dsWqtcspaDnjRCYX5ClZVPp3ZQunddhFzaYniUy7xDnrvoqvYRp0GOGI?=
 =?iso-8859-1?Q?gicTLrHvI6iuYgvM1ks52oEFp3oUNx2Ra3eedr/g5BqlKq0BJhtL6FksPU?=
 =?iso-8859-1?Q?MooUKHHYCf6jQNKFm9E6pDkUb1qdpu7bxLG0hO2wpESZtXlvirI5gEqOkJ?=
 =?iso-8859-1?Q?lD7hmdD74uuu8LvNKkavQdS6kYVpbErZQ20Sg/+PmNh/jdBjqK5jaZpl4b?=
 =?iso-8859-1?Q?KlQmxeNv19f3KenvCYS0NMfgfnEKRv+p1Rs8MLk9zVNW//UNzr4riwETeg?=
 =?iso-8859-1?Q?a9xUVulWZDNTlSNGgOziNeNpFUYQPOHVasZ8k02xdTabB0TxDssaxA2Lv1?=
 =?iso-8859-1?Q?7pYBDfMkm39ewAP8zIAuwTgFmEGIecXhjK6HUT6cTjhhHmswf6C/p/DPqu?=
 =?iso-8859-1?Q?y0qUdO0XnqBBefXJ7w9uNi054I7NOFHe38lxwLEdYO2/98PQVcmLw7Q/ip?=
 =?iso-8859-1?Q?KWiAQEG13syvbpAV0sNrjC6AWO3eh8JaGdxROxeAdKIsjnOEAi6Vky9+QI?=
 =?iso-8859-1?Q?WYi3SnATYnuKO4313H4+BsEtFpcMg8TZfXs3uJxIRzo4NQrdMoyeRgUWjy?=
 =?iso-8859-1?Q?lANE+M/RSsuOnUixjEAqMt9CAYWiwAuwxj3p6icGNQqmhZorRKxADiLxew?=
 =?iso-8859-1?Q?XnanJ6GblW0mxYzERT2YUXMaReg9d2dc89wG5bVrhxQa0EgobOnZ+nIVmm?=
 =?iso-8859-1?Q?xDJZGxIioFWgkZqk3Wz7EtBZnZ+rY/b+5zfSE3CYA8Crou0P85UAp5vU6I?=
 =?iso-8859-1?Q?BLXWDhfFTsIjOYcIl8W3nv2PwbtkVrKdQ7ht+N3mLCzfGLfVIkZHOWTgOR?=
 =?iso-8859-1?Q?AXrGH0y2vQ0tgPoz9YnCdq959Y3jIHjfm/65G1Us1mcFFsU4TYwoC2ie8t?=
 =?iso-8859-1?Q?23tGjW+0rVHBXweS5fuc7O4qbjHRc2XwrXU5+o0RvWDw5nCGwSsy+RkOjv?=
 =?iso-8859-1?Q?+bUqIHBohImpXukElvxFqCjRDY35AXwLPjWVQ7Rgh5T9pggZsGEcnXs6Yz?=
 =?iso-8859-1?Q?+j0HT17lDsco2CMkrGuIdEngbElUACOAjSiC7T61IMXTv9PuCa72yebAIh?=
 =?iso-8859-1?Q?beOkIakWGulYVB+PlatslBFtmzuLSeeC9t3X6u+7MxbMVYVE0x53TPnL1Z?=
 =?iso-8859-1?Q?H7bZsBlqwSgr7rewYlks4GRmVzZydq4rC2Sp6SAdhpuorFzqIecbjz1RMB?=
 =?iso-8859-1?Q?Ip0udDxJWiFqCbUGt5wj32YwtpPKY2BCeVHugQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Mig4WbrAmIDMtOgD32wlsgqSqTwEYrw+uUEfAd8vUQy2zDkvux7WIULnM5?=
 =?iso-8859-1?Q?xQCVSLWbf1mINFzftGY4/BZRT7+IOipNRa2TawsnFIjFH4Jw783XXRuM5h?=
 =?iso-8859-1?Q?51AM+1uNfd2wk7UmdONKst+juKj9hdO8tKpt8t7N4kvIgLRExGYqSKNJa7?=
 =?iso-8859-1?Q?YTeyN/la0Ju3BvMvGEkYBkMJHOSzrd2kLotIlflwkiwsRGbJ8bA2x4EFW/?=
 =?iso-8859-1?Q?NJkAcR68BYkAYH6NJU8PL4HnKUMdxgj725AARKWM8073r54xWTlVLYJwsA?=
 =?iso-8859-1?Q?sitG6u32oDyy66BXiv9soAnZVTojY/71es0nekR6CKk7fNLyCehwLGRiVx?=
 =?iso-8859-1?Q?TEOhCe91lKagNxABeV/HQllCGMMwVFAYMTXsIVpg9kAgV1ARLEYDlJgJO3?=
 =?iso-8859-1?Q?mD+ZKI+rxALyP0VKqrC+WaPOzuamcnxMfV3tONvgT3k4XF3TGyqs5YwU9s?=
 =?iso-8859-1?Q?Yq4Ze4c9PH5xG5VsgV5W5TJ5ElWAgyczLegCE4YYnloCYOcV34EyHiR0br?=
 =?iso-8859-1?Q?995xCxFb0EPonv7u/AEXR45fMd+KPZJuj80Qhp29ysmgYfHtkWc3M6b415?=
 =?iso-8859-1?Q?5eV/PA4noAbjC6Yz6shwAQ9i7bmA0q46hDQCtsklEOY6TrwPs0MPn/mj7m?=
 =?iso-8859-1?Q?CQd/tLH+XwlKhxrHJmNbbIOokGhltNknLE4j9FKI96vYuoC1J4R9Ok+2J/?=
 =?iso-8859-1?Q?jUbHHUL9E0QwmjU7RRD43K5Ga51280/x2CGvkJNZhSaozs+ZZXq2ZjCsvr?=
 =?iso-8859-1?Q?pEWSAzp4lYkLuOTJyBUs/FuZRvFnjHqZ7pLURBR91m9NYqildZFy2tDBum?=
 =?iso-8859-1?Q?hGLkOIEImg8tEwYL5xr7B4d0zmtvKxIFUZXEX47rIzCZGWC+ENCWLB0TXt?=
 =?iso-8859-1?Q?o4FeRvqxk3GIOITKGvh5Mken8X7tnST+TobHsVf7dlP1KsoeMyKUezYrIg?=
 =?iso-8859-1?Q?NldrnhOl5+Kk119DYYQrysr03mxEB175lNGy+adq7IQLqBwRGifIhS/MVq?=
 =?iso-8859-1?Q?scaDUEVMFndwtHC9A2uq9nCSYYC6ZlVZYmXyY5LgCWGeDCCVLDvC6vGtw8?=
 =?iso-8859-1?Q?4LdLGRXkS+Bfu7vOVbTLl/rWoYSJmKjrhxMKtqro3N2TZr5E4Rs0GACX2C?=
 =?iso-8859-1?Q?9Rx58WpvLIX8zYaW94tag9wVHR3Ajg2kLK/TPVUFUiakaxAjEVYFQqDLhR?=
 =?iso-8859-1?Q?DQk2m1oUeDW8ImZP5oe+jMYKSfgmUzKMWYj93tUNUA8+pEYueFE7EoR7u5?=
 =?iso-8859-1?Q?NDC3Kou478RqW/CDScyzN72nd6dAo9sg3s4oX4L4GmOzxxR0sR7QMu/NmD?=
 =?iso-8859-1?Q?/pkGUGhmPlSeazC6PF6MP1Ygfv0QF+ZgJw1xHDHxwcol3JNqxamyT/gxsa?=
 =?iso-8859-1?Q?YWHEtBxNiOfnZffIK71ALWeRG5ElCZPl8inGcEDNCEC6QaGe7gqYP12oZc?=
 =?iso-8859-1?Q?Qetpt1F4v1y6ZF/b1j3uS8vVSPRfAOgMtnXLCHrM4H4TAuFRuNzUDuv0v8?=
 =?iso-8859-1?Q?lliU/P7dxrI6FXrPVz8ct9hMCEohdlLTF9YwC/ndYl28a0NXEMQYO4MGA7?=
 =?iso-8859-1?Q?IYWDg/yZLWudp2RQBLdn9IE8p9cfdRsZmqGQI5h9HDF3JXoq75f7wFDwVQ?=
 =?iso-8859-1?Q?+6RsGkR0zqKSSo8OEG1YNsBJUDZva1ayCP?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9558b277-49c3-4e3a-2c18-08dd3b9e2ebf
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 11:07:53.1117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BBgLQMwJriRRzriht0IfNa6K1nj9fSqD3kgzNZEz0X2OUr/7h9umj88Bn6OBtwjiPgKF0KGB8yeNkP/WeRVKWKJgZuqxMhbzFRKxbPM6j2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -73
X-Spam_score: -7.4
X-Spam_bar: -------
X-Spam_report: (-7.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
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

Hi Shameer,

>-----Original Message-----
>From: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>Subject: RE: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable n=
ested
>SMMUv3
>
>
>
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Sent: Thursday, January 23, 2025 4:10 AM
>> To: Donald Dutile <ddutile@redhat.com>
>> Cc: Shameerali Kolothum Thodi
>> <shameerali.kolothum.thodi@huawei.com>; eric.auger@redhat.com; Peter
>> Maydell <peter.maydell@linaro.org>; Jason Gunthorpe <jgg@nvidia.com>;
>> Daniel P. Berrang=E9 <berrange@redhat.com>; qemu-arm@nongnu.org;
>> qemu-devel@nongnu.org; Linuxarm <linuxarm@huawei.com>; Wangzhou
>> (B) <wangzhou1@hisilicon.com>; jiangkunkun <jiangkunkun@huawei.com>;
>> Jonathan Cameron <jonathan.cameron@huawei.com>;
>> zhangfei.gao@linaro.org
>> Subject: Re: [RFC PATCH 0/5] hw/arm/virt: Add support for user-creatable
>> nested SMMUv3
>>
>> Hi Don,
>>
>> On Fri, Jan 10, 2025 at 11:05:24PM -0500, Donald Dutile wrote:
>> > On 1/8/25 11:45 PM, Nicolin Chen wrote:
>> > > On Mon, Dec 16, 2024 at 10:01:29AM +0000, Shameerali Kolothum Thodi
>> wrote:
>> > > > And patches prior to this commit adds that support:
>> > > > 4ccdbe3: ("cover-letter: Add HW accelerated nesting support for ar=
m
>> > > > SMMUv3")
>> > > >
>> > > > Nicolin is soon going to send out those for review. Or I can inclu=
de
>> > > > those in this series so that it gives a complete picture. Nicolin?
>> > >
>> > > Just found that I forgot to reply this one...sorry
>> > >
>> > > I asked Don/Eric to take over that vSMMU series:
>> > > https://lore.kernel.org/qemu-devel/Zy0jiPItu8A3wNTL@Asurada-Nvidia/
>> > > (The majority of my effort has been still on the kernel side:
>> > >   previously vIOMMU/vDEVICE, and now vEVENTQ/MSI/vCMDQ..)
>> > >
>> > > Don/Eric, is there any update from your side?
>> > >
>> > Apologies for delayed response, been at customer site, and haven't bee=
n
>> keeping up w/biz email.
>> > Eric is probably waiting for me to get back and chat as well.
>> > Will look to reply early next week.
>>
>> I wonder if we can make some progress in Feb? If so, we can start
>> to wrap up the iommufd uAPI patches for HWPT, which was a part of
>> intel's series but never got sent since their emulated series is
>> seemingly still pending?
>
>I think these are the  5 patches that we require from Intel pass-through s=
eries,
>
>vfio/iommufd: Implement [at|de]tach_hwpt handlers
>vfio/iommufd: Implement HostIOMMUDeviceClass::realize_late() handler
>HostIOMMUDevice: Introduce realize_late callback
>vfio/iommufd: Add properties and handlers to
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>backends/iommufd: Add helpers for invalidating user-managed HWPT
>
>See the commits from here,
>https://github.com/hisilicon/qemu/commit/bbdc65af38fa5723f1bd9b026e29273
>0901f57b5
>
>[CC  Zhenzhong]
>
>Hi Zhenzhong,
>
>Just wondering what your plans are for the above patches.  If it make sens=
e and
>you
>are fine with it, I think it is a good idea one of us can pick up those fr=
om that
>series
>and sent out separately so that it can get some review and take it forward=
.

Emulated series is merged, I plan to send Intel pass-through series after
Chinese festival vacation, but at least half a month later. So feel free to
pick those patches you need and send for comments.

Thanks
Zhenzhong

