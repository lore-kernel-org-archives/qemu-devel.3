Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9071EC7EE32
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 10:17:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUjf3-0003tK-MB; Thu, 26 Jun 2025 06:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUjez-0003t2-PC
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 06:16:49 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUjeu-0004bX-Fb
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 06:16:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750933005; x=1782469005;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uDmc0pBNOgnl68dOECGRQ0ce7jxI0f7Dm6QNwYgNJ0c=;
 b=JaYxk5VWUs9/Di/CP60B2BIlL+l37Yv3x28YAlMdfFTihmRBdDVrkhu5
 39+AvY8COc9l5gkWrqQX8AKX38x9wlJv7KG5VNC3rrLCd5hzwWW+HuXxQ
 +0JtZzF/BK1ZnhjDQJPDd+Pqc15q+dFEjMesn0GIh3WydZvRWluHYo8fr
 eZCtv88RL3NOVVMKqWBbQ03xT1hUdDl2zSGUG1iCsrtv2SfXNYG52Qs9h
 cfF9hglmiCAbfl1gd6A3Rm7WgwHVKBDPBYZFxlbEO6qLOwavsh+m64vxD
 a1RLiX1sZLDqHRHusJRQIbBVAM+BUQz/sXv2PLbDZfh1D3aJTTwATaEGw w==;
X-CSE-ConnectionGUID: Xysxf6zMT9yXNFBbLvD93w==
X-CSE-MsgGUID: ODokuUj3QRGQrRpgXNq1pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="78658729"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="78658729"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 03:16:41 -0700
X-CSE-ConnectionGUID: 8PEu2HpoS1SUEFSaWsJ/Wg==
X-CSE-MsgGUID: 8a3+K2PKR0uWSMdp5tgr8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="189663387"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 03:16:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 03:16:39 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 03:16:39 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.57) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 03:16:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMLufD3NR4rWuBqApFpDqATx4jCPw2o2cmSpchek2MP7BV4sbU7C5E15owG4m0i8ELE3lITkVh8RgKQ2JRRG1nkvm01Sz/uaE0kC4whrVu46wU88yl0KHKeNaEEWO+BYApjS5gk7cMFhl1HMjir1HsSKx+rtQV66WtdNS2OCN/I61lqb1qLxfCzd8XW87oEe/scWAwfegErsB0Sp2BffRUquD4X6u5bntWv0FZT3vjS15qmns1oRmSSVMRoAX4xsd238Q8+w5uptKb7rl275Ahvgk21ZKfC2AABeOG1IAaITZo1Tcz/hXNoJgyWP5Q5ppIPntaZ8oAB32BgCP2Sgiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t34OP4+g7IoxXK4ufzjoz3iyCpbrenYfyYT5xGOiQ7Q=;
 b=V0XaDc7SXeNkanmlz/vGHa9nnjq5I9UXVTHrkwyqox8whVmW6pFepBeXnQAMxkf2xVQGoQ6jTsbNYfTlvOiCJlCFlactwHOGgtinJdvfC18/WnAAIcYNMArwIsh689aD03qM94J41fOCRGFDuLOQZpS7MkSYDyZglVcEVP8Z68Elp7l8rh8cQT69dSsZ/zOjCar/5OH4+MXghBG6Cq4KwKrh95Q7hKDB6mFJouv0j2e0MZ+K/AaWfixHEbFcc8RbZmh8hSLJwtK80+efi75y8M2PSRaViwTwXY4tcFdCf0oy0JVn51aOqScVCF0e3iJJJPHURymKuoZRc6o3j0MXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB8153.namprd11.prod.outlook.com (2603:10b6:610:163::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 10:16:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 10:16:37 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 17/19] intel_iommu: Refresh pasid bind when either SRTP
 or TE bit is changed
Thread-Topic: [PATCH v2 17/19] intel_iommu: Refresh pasid bind when either
 SRTP or TE bit is changed
Thread-Index: AQHb4bRAHYLre/ZBfkWq/aIl3Dw5vrQQx3+AgARyehA=
Date: Thu, 26 Jun 2025 10:16:36 +0000
Message-ID: <IA3PR11MB91364CFDD20B4F8AAF272070927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-18-zhenzhong.duan@intel.com>
 <c15a7312-09e4-4026-b27b-55d19612bf23@redhat.com>
In-Reply-To: <c15a7312-09e4-4026-b27b-55d19612bf23@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB8153:EE_
x-ms-office365-filtering-correlation-id: d84e5e9f-7869-4399-f47e-08ddb49a88dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?F6EHyEYV/76aYQEPL0OiNydPYwefwJ8W5Su8wenCY5TNJxAtRdYJr+S4Pdkc?=
 =?us-ascii?Q?nKsxyJvHuiVrrQDEWqCL4c/pDnwqWlRoe5fXIhr6Q06/B6vCxW/FHGq0RdQ4?=
 =?us-ascii?Q?DAS60Sy10oBrBXwWL1J87YTvkL0VHgJeI+pycHqIysl5fEdMou21W4WMu5gV?=
 =?us-ascii?Q?rRcGo3zSzIeO2VkACB4uOrL5O0KqIDX/e3d9k7hdiux3cozdXO1krBxPLjCD?=
 =?us-ascii?Q?bcodYmmUBY7Z01jB7mJ9iIitL487OZt7lHCo/c/fiiseHytexm+FCs95U1yu?=
 =?us-ascii?Q?3cOe/imDAIeCqnGUCHS8U0BsYPgelNhorC9kCeJtkXIYSPEHVT3atooql29q?=
 =?us-ascii?Q?zNowi8O4QkPQocm18+JFKhpUTleCEXP3tvbRaZCJgkPcqXMhrSxJL0nWQ411?=
 =?us-ascii?Q?Wrf4D/Qqve1B5cxXbOjddiEVK0pZSU6UlBkBC+1k6DqwE0yXqn/RxUDjIzPw?=
 =?us-ascii?Q?8J6MgvNtau6TjdLEGUNsahbE7UPt8zQKxHplC3z2kh8QyfNqFzXEsdrw6WDk?=
 =?us-ascii?Q?uDIFp4Wv8+ucP/H0ym1+pTMeTLHVK1DZnxd3QcjmW8bbnK8ccS9Bh1RwqFX1?=
 =?us-ascii?Q?jJeI5Jvgn9RdBCeRi9Aqkz3Dn0IRfXZb6y2ocVg/94/9Fl/LUHlEzTzz4/mQ?=
 =?us-ascii?Q?FTMsvrMQrbQdijVqsPUGndVJT+BME0w48SM6QnwM9S+1LzG7LDLSZDqLBGFf?=
 =?us-ascii?Q?Ef3HMT/8F28W/oCxYPK80cJD1iH4TdYRY++xne8DjkC4ldM/hbdoEQb8L2va?=
 =?us-ascii?Q?NgsHvVSmrSNzjtszl3RfBq1ek3CngcTEzIUnmly/BJhOEbwpU+adhA/98gZx?=
 =?us-ascii?Q?MfeQ02zY88UTlLcGHdayFXIltFpz6vzaZeoorK+x7UYEcsbVFuNs7QRv6K6n?=
 =?us-ascii?Q?wZmrRjb4sW0DxbVA9a0zl7z+Bs/2VyCeiO5q9Gm+LRODFTp9HE8/aHnjELba?=
 =?us-ascii?Q?s5fhUZC26mbPeK/pKO+AqXWwBRlbHdHz6zKk6AvJNwgC8v2leaCcpFy1Rplm?=
 =?us-ascii?Q?76mJt4TgtzMgp2+0bLim08QtP5kwLFkOCihHn1CQrynd7bkh6fGmdIxjxGBF?=
 =?us-ascii?Q?bfhepdYpx1i/oeB/qBHF3N7Fwf+fH3aqHHrqnE6/kw8v81C7qQz0HjrrhRXx?=
 =?us-ascii?Q?aP7Tk1nEC9YjZMzmd2yoTcopKWeWteLfA2QSFHpaCfVQY2udTUKukmUlJc8O?=
 =?us-ascii?Q?k8kbcZxe6D4phZ/lyDWdv9pOS2Of8Z65/dNmKITxga88PAXcUN+SiQtHOl1+?=
 =?us-ascii?Q?aULrOhLweW5WDXGlNSlU+EBdQ28SN6SxmRf8+2JTLoHphKvwX7nycw8oP33m?=
 =?us-ascii?Q?vkJcL/pDU0VJDZppioZE+rgVFp1bderPegGZvULWn50l2ZfLHTJ7bwkzthWa?=
 =?us-ascii?Q?mFaLggnhmyMVEHwQwkCaBGBrn9P/VDL/X0T9yfgniWCgb6e5hFOIDLByiJIb?=
 =?us-ascii?Q?G7HRy5JumgxuB6fPKLSYhKVqbNRugNZEGXTBZAtFsw4N6+q8ozhsge1BXo90?=
 =?us-ascii?Q?VEanHQuPoX2lTyM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y9LZy5XQN3E5Z7LzdkXbFzIKiXsgt9iiPW/mSwn07Ce2WHEakFOL4apU9Qcu?=
 =?us-ascii?Q?DOR0NvW91hZxGQMktnD3b4t+3uYsuucyIXQueutKWfKitGV9fYxMmtJQe390?=
 =?us-ascii?Q?rQ3KG37M2rL/KTzEpJOAUn8fOolejVFwTT694jsf0R3z3VsbvP1nztkbgBau?=
 =?us-ascii?Q?uqfnfeVEqYbYV1/jDU2T0AUuQFIAlP1STqx9Ue/GUoLpmcWVrJ9C+OeT0ELQ?=
 =?us-ascii?Q?0seExEepyuaVNnHZNAttc7wyy9B0s7T8GZ+9yiEyAYA3xSpK2O+P7BrZQ+Ex?=
 =?us-ascii?Q?NEdA/CPOuqb6uh+eXZPY5CvyT3v4342saIt2TB4rKskyEY/L3iB+Hdr1aXKu?=
 =?us-ascii?Q?cIurreWcNRS5UP2IPI/p+ywNS1NUMp1qSwj8LhVn43PCRFFoR/RsfspPnzuA?=
 =?us-ascii?Q?ugo1p0DYyHOyWdgDkOoCSb4sJSiUJ+WaPG4sB2OHVjZJYdTjF+lwQ1Ku7lWV?=
 =?us-ascii?Q?Jh6yLkTAVy0BqUS0gCLWbhjbTxcDs89Qx86xIXd+/6JdSRma+HOyIBDdO4Zo?=
 =?us-ascii?Q?Wek8bp51FkHe0+7+X/A26tUNnsIwKMEsKpa+ar6U6BVkZoAuhddATZApWlW8?=
 =?us-ascii?Q?Qv630Vo6Jovd4H6kMdjk3xLD1cub9RxGgC+ZkoISxtiyVWEzR27dKAoRjAGZ?=
 =?us-ascii?Q?9Gyr9t8lj130GfD6BaYtpZGtI+TKnacWmHTnYOjfXLTI0lL4krwsvkvUbXl9?=
 =?us-ascii?Q?9dXEAmVvEXvQ3mZ20j4AQ6OlYN/oId5B8R2ZekDBl7MPY68TicjwscYcZnKj?=
 =?us-ascii?Q?8o8rPkMWnyUNIbw13zXT4s6bsPNuByLWbpt7TgunCOD55wfk7CWgHjzBTY8Q?=
 =?us-ascii?Q?ixZ7hUubs1vaWvENw7ZuJKHx0u2nTDDkBjzYVepiLjcdWoRLC7TZysY1uy4B?=
 =?us-ascii?Q?AlRkqkqm0xT+jGUrSkU/e8WwpgMtDSvDwsg6/uePnALc59KRX5B6Q5KnRQMR?=
 =?us-ascii?Q?Ouu4M2eUvSgLqbcUIdGs/hROFHNZv/p/01TufQznPN7Z/p4M0iCjJiC7DUgO?=
 =?us-ascii?Q?Jz/P9tNyOExbKFH9b+LVbSaASjv2hFm+jgU1DQkClUW6TTByS0kj8CCEmtgf?=
 =?us-ascii?Q?JbWAviP7TYCPAnQfgbo0bYgNWO2UmBA+h3TzNJFkLUJHHewR4EqkUkU2n6/5?=
 =?us-ascii?Q?suOzQzfkg59q9zgHQRwlHJDIp82FntINU7d5SIL4Ellda3E9V/1U7CxEtRBI?=
 =?us-ascii?Q?C+yG/kn0p/bLnhLNi8jE3UnNdOYghSHlbOLiUDK0DpzSuuvb87RaK1XbRN0q?=
 =?us-ascii?Q?CkJe4oSqvEDLvN91AlW3fc/GulpdJUGDY5D9VraEnPNAIHPf8g8wxwzvrR8c?=
 =?us-ascii?Q?KbyOhwPt920ILkAJOFwS2jXpb6RzkTfLYX/NMiPHRxKTqAOpDCxCz9LJeaCq?=
 =?us-ascii?Q?JbkphGPmQCFpAhM2GhaQHSrvt+rdHzyyWQDA6f4YI5DxcQuYMVpNlr5dH1qn?=
 =?us-ascii?Q?L4JXui/c5MBUnvAbZCcHaQPijvXUaAT74XT/vniJzWJvAwsmoQhGlBDmcCT5?=
 =?us-ascii?Q?67zkU/yk3k0ys3ct2l+mVV7oSrbIWd2n1q73A+tb4QOBsHDa30Trh4KW5RYw?=
 =?us-ascii?Q?z+cGkbYSVnqhD5s/Q9rU0yxz4n1Hz7AVBPsujrLO?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d84e5e9f-7869-4399-f47e-08ddb49a88dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 10:16:37.0244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBLmcD/k2/SKVV4+FN8eKAMf/4HpBKzC5KlxcxBdX0Kj63PZxkDo3/wn4/tortR+y/828ZW9KAS1pW+ptyHP49zdIRFHLyx2ggxjm1iIQws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8153
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
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

Hi Eric,

>-----Original Message-----
>From: Eric Auger <eric.auger@redhat.com>
>Subject: Re: [PATCH v2 17/19] intel_iommu: Refresh pasid bind when either
>SRTP or TE bit is changed
>
>Hi Zhenzhong,
>
>On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
>> From: Yi Liu <yi.l.liu@intel.com>
>>
>> When either 'Set Root Table Pointer' or 'Translation Enable' bit is chan=
ged,
>> the pasid bindings on host side become stale and need to be updated.
>>
>> Introduce a helper function vtd_refresh_pasid_bind() for that purpose.
>nit I would avoid introducing yet another terminology, ie. refresh. If
>it is a replay let's keep replay and precisely explain what the replay doe=
s.
>vtd_replay_pasid_bindings?

Will do

>
>
>>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>  hw/i386/intel_iommu.c | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>> index d1fa395274..0b322078cc 100644
>> --- a/hw/i386/intel_iommu.c
>> +++ b/hw/i386/intel_iommu.c
>> @@ -90,6 +90,7 @@ struct vtd_iotlb_key {
>>
>>  static void vtd_address_space_refresh_all(IntelIOMMUState *s);
>>  static void vtd_address_space_unmap(VTDAddressSpace *as,
>IOMMUNotifier *n);
>> +static void vtd_refresh_pasid_bind(IntelIOMMUState *s);
>>
>>  static void vtd_pasid_cache_reset_locked(IntelIOMMUState *s);
>>  static void vtd_pasid_cache_sync(IntelIOMMUState *s,
>> @@ -3066,6 +3067,7 @@ static void
>vtd_handle_gcmd_srtp(IntelIOMMUState *s)
>>      vtd_set_clear_mask_long(s, DMAR_GSTS_REG, 0, VTD_GSTS_RTPS);
>>      vtd_reset_caches(s);
>>      vtd_address_space_refresh_all(s);
>> +    vtd_refresh_pasid_bind(s);
>>  }
>>
>>  /* Set Interrupt Remap Table Pointer */
>> @@ -3100,6 +3102,7 @@ static void
>vtd_handle_gcmd_te(IntelIOMMUState *s, bool en)
>>
>>      vtd_reset_caches(s);
>>      vtd_address_space_refresh_all(s);
>> +    vtd_refresh_pasid_bind(s);
>>  }
>>
>>  /* Handle Interrupt Remap Enable/Disable */
>> @@ -3813,6 +3816,26 @@ static void
>vtd_replay_guest_pasid_bindings(IntelIOMMUState *s,
>>      }
>>  }
>>
>> +static void vtd_refresh_pasid_bind(IntelIOMMUState *s)
>> +{
>> +    VTDPASIDCacheInfo pc_info =3D { .error_happened =3D false,
>> +                                  .type =3D
>VTD_PASID_CACHE_GLOBAL_INV };
>> +
>> +    /*
>> +     * Only when dmar is enabled, should pasid bindings replayed,
>> +     * otherwise no need to replay.
>> +     */
>I am not sure the above comment is necessary.

Will delete it

Thanks
Zhenzhong

