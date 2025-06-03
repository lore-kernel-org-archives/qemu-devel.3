Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D841BC5B549
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Jun 2025 03:13:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMI5g-0005eD-GX; Mon, 02 Jun 2025 23:13:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMI5f-0005e3-4l
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:13:27 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMI5d-0007uS-8F
 for qemu-devel@nongnu.org; Mon, 02 Jun 2025 23:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1748920405; x=1780456405;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i+KiuEK8G+mzg+hy+LErc3qfpE54kI+72LlKVNLVfFk=;
 b=dKD7OMDuXzazf9pE55hybCWcjOkEuYM6K26NtpDGfjqdPPEYIuB2jK6R
 iJw1VxtbCUdU2teXB7UBlgZXSpylLbtlayO339BLiK3rULARtW3L7UG6r
 UjzXiVzEcjmnLfyPWu7+JGiDaTLIKaGXAixlpWNoNpHoxrBGsEpq6Hu8X
 q4iQ/KTTvGQJbrZ60mTDQDFosTdWVbxHiecxyHUz95HhqPha/d4zDyOfz
 SkyD3eu8W6pU0r9CIa27o6mcKnbO2z7va5xmBEhUKMQVQDV90c+OMIXI+
 iAUnqkcJrXSjOPjGRU0431YefU0WZX3X9nantkpo0it399lhPe9nyxApC w==;
X-CSE-ConnectionGUID: g1Xrn0nZTZaotLiLGq3uPg==
X-CSE-MsgGUID: HYwyQT7TSCeGVwbDc7sbFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="50810161"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="50810161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:13:21 -0700
X-CSE-ConnectionGUID: yvUMqsY+RlicmAGzyhfHFg==
X-CSE-MsgGUID: xJVi/34oR6WTnj/X/yX0+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; d="scan'208";a="150006607"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jun 2025 20:13:15 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 20:13:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 20:13:14 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.40)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 20:13:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JfwWzkURT/wHn0TY6dkQIgHulhOCY8ttzMUJ6fdwmMsOkWCom/a4TmkD3Hxa2Fjqy9ubxk0YNDn0rT281KmLu5FbKaokOuz+aiAaE3knRCVRmp+WVuifu6o3b2MART1qUOHxAY7E0Dt82SfUQHkuYhoFqyTtGsHAA8NDyvHiEYvtFQ0NcHUK5vo4WM/iKTTO2NKqQJhT3K0E0BBxPNMto6f+wXs1ioOqwhj0MHXPYaXvQwNDqCij98uWw0PfGGuCyOoXboLJmCsJCl45W+hVOZ+YYkRRQD1TlRifjQd8QctN2bmVLufHplWp31aooePdyRn+K8lCdJSedWxAGYP/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y65eYyJzaw0RnXWKyvfjFp3Tg64f2nodwyW7mA3axYI=;
 b=ZUbk4sB3l3VHy7wOoN5EnA9zui4ZIulKXCLiAIzvyMcLstj0j6pMM4N7l08Y2ZvTyffzAnHenJtBcpw7JFJsyWh0YWywKDfnxwOnDG9WBO26V76xGPHZi+JKB4k7kxM0Ntv3M0wPcltVLVOlvhgg2KHP4IwMxNW+XepmsuQDy5N6efVv5Re9wg3STsUU+aU3hYaHovR4lRH3hqq9c3nsrDYKtxC+gaLAQXkjftXcx/Jwg0+SIHtZtvONVQCKS2ublUUTMOp/fqpl52XMkukCTuRVF8CUTPY+WXfLu54qXqpWH5BxJMfLfQw8kG76dYO9EJ3Od9OgUDGLU5DIyyyBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CYXPR11MB8664.namprd11.prod.outlook.com (2603:10b6:930:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Tue, 3 Jun
 2025 03:12:58 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Tue, 3 Jun 2025
 03:12:58 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 2/4] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Thread-Topic: [PATCH v2 2/4] vfio/iommufd: Add properties and handlers to
 TYPE_HOST_IOMMU_DEVICE_IOMMUFD
Thread-Index: AQHb0Ua4K1jenGQydU291PrP1nsdUbPrqRyAgAUdOdA=
Date: Tue, 3 Jun 2025 03:12:58 +0000
Message-ID: <IA3PR11MB9136695A23CD4CFB8F9F6148926DA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250530093512.3959484-1-zhenzhong.duan@intel.com>
 <20250530093512.3959484-3-zhenzhong.duan@intel.com>
 <aDocW24Pz5o0fBeu@Asurada-Nvidia>
In-Reply-To: <aDocW24Pz5o0fBeu@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CYXPR11MB8664:EE_
x-ms-office365-filtering-correlation-id: 0b6ee7aa-6ccc-4135-c800-08dda24c8a8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?c+16XvakuYSLlF39VQsNyopCCJY3p3tu8Fx7iLelN4Q23/wOo5EPj8CXMB9j?=
 =?us-ascii?Q?f5AEkmlUmTh3SiA/eLwYgaveTfhadsStcWehhpcKAzLCAfZIkoNDHSiaoHRY?=
 =?us-ascii?Q?MydxnXDpM/QTkgTnpJ1g9Kj/XIEm4t2mPuXDL35oaNpxpT9SBnxKu6iqGn6O?=
 =?us-ascii?Q?EwC5ZyxHnuTlyVKaa1W9r3EZKRq7CMUhAdQ4IXCl87noVHyxeEwyLwaTVWK0?=
 =?us-ascii?Q?cPRkdTD7HLgqLpEXSiU+Zr1thaRgbP4Cix74cHV+AsJTFD4XidfHIUbc5VTg?=
 =?us-ascii?Q?rGiKhHxafcthWeSu3W6TcxzNNabi81pWh1iTT29amFY2HpgIZdPHXJpAqM5t?=
 =?us-ascii?Q?HClx5SyGmISdIvc+QeUwpAhk6/syFx8mTnu7kSFMOdoSf9e+xXvJ7bBSJRT1?=
 =?us-ascii?Q?jVf48vH3WUjx1SJwDMQBR4kCNAoMa2Jk4Yu8iL03WR8sc1GQoEtdRBcWe35q?=
 =?us-ascii?Q?WZ1chsgo3pMIml2je/TXwV43kaQsicODK8TqXvEo5/MZdKews7HVweTe+Drk?=
 =?us-ascii?Q?aUfWlKK32kRNDbT2SgYO5Q9FonUUru58ekOkxC0eZeL6jB3EXMbeRLCpb0WC?=
 =?us-ascii?Q?XuedVpuLoUE60I3Cs/A2ALDrKkxNRfQibREYSt+t7jPilw7rZpPZPY7fAbMi?=
 =?us-ascii?Q?uyJECXNDUx3oDz3JSH8osK83PFG3kJKcxNB0LX8g6VgSe2tb41sO5jg3zw+B?=
 =?us-ascii?Q?FIChEj+OW4dTm3uqq62exCA4ycTL2B8AnKgh+uXvteJGLooIE+QrtEikR9e6?=
 =?us-ascii?Q?04CP7+rsC/xTZNib7uuP4zL9L1w9frZ93fJGQOET6nWqK/8bRRQOIAicU5ua?=
 =?us-ascii?Q?6ntR96pXgPWEA72CJbmyH45LkpyLGiUVQ/Wg3lF/riCemedWFR+IvRxho2mt?=
 =?us-ascii?Q?/ZQXzEgbnDfQ0A+XMX19iGOqNAHRkMqDLCsq7eXlftWhoH+9EQufigcr1t8M?=
 =?us-ascii?Q?W6PrHoKMReCRkfWbQHRK51xMu5ckG1sPo2xKT3ou4RMZowkv9/9dlHgmTMzF?=
 =?us-ascii?Q?t+b2CS487ZkGGCnEMl6zWqog//7pycvAidXrZfNbmOfdZcFNFLwUkqz73en8?=
 =?us-ascii?Q?Zbh+H+GxBDSnmCLasTYavOACUZ70r0Vm4lL8pdBs60QkjhOaw7m72ndkxrCU?=
 =?us-ascii?Q?rJoUf1fabI8v+ureJG2nk4dj7VXBSLprggOve89p9CraSNBc46ZCaYb1IMbH?=
 =?us-ascii?Q?KWLTBD2VuaAQYlL5pBLzsWvDtklp+x+NjSyCShYUt7fqZ67iVQdkaEF0TFCL?=
 =?us-ascii?Q?6lL88sl8GcXE4iYcoIWUV10TLYWtXqJ6SnAwBdD4yDA1Fy/kN/EdwV/stAfm?=
 =?us-ascii?Q?urk0gO51ERiiiFBC4DsEYBhr5GgMbu7sXnwA+1c4ObZbzys13xK4GT0X+B39?=
 =?us-ascii?Q?LTZVuzC10ouFvc9BMEMKjq+9tJgYG5Lp9WwoAira8EgIu2jTdFwrdsqIp2QJ?=
 =?us-ascii?Q?M09LN5hCXZo44XOW/JpAODUuidgEX5LoAn5QiPZNPRp5k9dZuWsdl37tkYmQ?=
 =?us-ascii?Q?TPTyMa5zAl7Kt7I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sZbH2rgOoLOVh3AHwNPtDJVWyMmGPQTcE/cmDx6oRw6e/6PEWKL0fQyxs8tr?=
 =?us-ascii?Q?okTB+RScSsRRiWctnoq6ASl9q4PPdFiF0//TFJSzhb1zZYq5Iz3x79yk7X/y?=
 =?us-ascii?Q?iLoNGfIBuvCArLnolkjqY6ysR1bs+EeV/hD1wnocJXgH/tZj4RSwSpfXayfZ?=
 =?us-ascii?Q?EaYFJO506Qpvr5H5Hb5tFcWU/qt5Y1lx4zyc9R9zjAIPXj1T0KuXv5z7J0Ie?=
 =?us-ascii?Q?BabQ834mKUDIdbr+jraAGosTP2FoJsDIEMBifhCSUTsa5IWoUnyjhF70nRm3?=
 =?us-ascii?Q?4gclE1aCQzQPbfNhDp34v7qU7eoKsKFIkNJllHhEW4g6u5mBx6kH0sJUbt4B?=
 =?us-ascii?Q?rNehPamb4fiTRUHhSpT2s7HeiLAKqLp9Ch/aPZCBQu3DeSrTx+oASmmZ/zMG?=
 =?us-ascii?Q?UIzv3t/NxFGGQ1dYfCXDlpJ1v90NJp88ignJVcmlU2xYg8BUi0WhB0eGZMQG?=
 =?us-ascii?Q?Us0OkZyQccu0yd3K+C03kjjWuldHXK0/aBA262gw04p8ETEgAWPJ4U5oGisY?=
 =?us-ascii?Q?HRCwo4V7RN3llRalPlSs1sZk4agn9gf8ntb6LI4j72DvLIZJyIHhF0obA4sO?=
 =?us-ascii?Q?W2KcVoXmMEAHDEiDBAZQzBpd7hGGzUFXJ9NeSWmqNQu8GTz7kboTFnjXkI22?=
 =?us-ascii?Q?2DO1kMcAuLUM6NL9ot2r7GuDKi0GrMhXO86kSg5GDcO/GaIA4sgXfMz1WMEp?=
 =?us-ascii?Q?cXPBqzUlvk8LD6bF/v6/Y7n3ILeDqR7sK0wxZBioYcHouBNEmVsHxsz+jtJl?=
 =?us-ascii?Q?2DXQ1dnkftc9hv2ddunzykpKzgkI40ognL4EtLJcf931/ME29jT/Tvz36KYx?=
 =?us-ascii?Q?UNZ6RKmMgenVLJafIMWu8Kc+wyqVpPEdfAsidiBjNyLfbPzpQ7oS1w2WoYfk?=
 =?us-ascii?Q?A0nMajjp/o1XoIMsIROT4bZNS71deYFiIZw10CEbGU//5Nv0rxhC14zYvVk5?=
 =?us-ascii?Q?xKz3wqfocltxaOQOkWS6lCUvmhnGWLFnzYck8I2FFeVVDiUDrpN2q9wkaEAM?=
 =?us-ascii?Q?3lzQ5TRqU/gn6ItWeHOBwxxNuhbTSDspEQVtXlrUPPshG4L1wjgrVomHZXHQ?=
 =?us-ascii?Q?2aZo+X2qtbKH2hxuUkhM5btUg0wY1laOjqu+dletlD74GrV1WxL1nk5RT1xM?=
 =?us-ascii?Q?JpBTofIS8QRy49O0XFKfQxoddRNDm18cSLAzVBRrAxk3HrcfMBm+rIUOmMc7?=
 =?us-ascii?Q?kzkCb+u7vvUpVKOxh+qMtHDU8GjlAv6ydTrLoEeyyRICafd8pntjZ5FxzaVn?=
 =?us-ascii?Q?/TTS+bGRnnRALq68DrwY1HF/7BDVJO0B8q8DPRNObkOlEG2ThpQFNbdp8jG+?=
 =?us-ascii?Q?iBGCUq9GODu1rN7eHNICGiLpr6AnXMSv6CLQP+Ldvf//YZVaoPqdG7+963kl?=
 =?us-ascii?Q?L/h3zQl8WwQKOYgg4QkeOQ6mGlaiOGYcocnyLWr5K98s+E3NwXUend4CKmOP?=
 =?us-ascii?Q?GWXiR/Q8d7NhNvdcMylmlQMIE7cwIoiolFNIiPL8s/i0M4Z7G3MAUh8J3CP8?=
 =?us-ascii?Q?gNWxyBVB8fzcXqKmXW2LyoI9MU8klJejiOSgdRXllTlimGm08YwGdgig8dik?=
 =?us-ascii?Q?upcOlTs9vRQ07Teh7eyFig37lSP6qp9m+RXhnIp7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b6ee7aa-6ccc-4135-c800-08dda24c8a8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 03:12:58.1568 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oz7jtj8rbv+LcDxNvooeYVV2cs8itOOrCeykFI7jCdVlUHGAHsSqLD2uLwU/y5o7bcTC5/QU91S79rd7cSBLZOcYtDgLK8Vls9/AA/K5AMI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8664
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.015,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v2 2/4] vfio/iommufd: Add properties and handlers to
>TYPE_HOST_IOMMU_DEVICE_IOMMUFD
>
>On Fri, May 30, 2025 at 05:35:10PM +0800, Zhenzhong Duan wrote:
>> Enhance HostIOMMUDeviceIOMMUFD object with 3 new members, specific
>> to the iommufd BE + 2 new class functions.
>>
>> IOMMUFD BE includes IOMMUFD handle, devid and hwpt_id. IOMMUFD handle
>> and devid are used to allocate/free ioas and hwpt. hwpt_id is used to
>> re-attach IOMMUFD backed device to its default VFIO sub-system created
>> hwpt, i.e., when vIOMMU is disabled by guest. These properties are
>> initialized in hiod::realize() after attachment.
>>
>> 2 new class functions are [at|de]tach_hwpt(). They are used to
>> attach/detach hwpt. VFIO and VDPA can have different implementions,
>> so implementation will be in sub-class instead of HostIOMMUDeviceIOMMUFD=
,
>> e.g., in HostIOMMUDeviceIOMMUFDVFIO.
>
>You mean HostIOMMUDeviceVFIO and HostIOMMUDeviceVDPA?

HostIOMMUDeviceIOMMUFDVFIO and HostIOMMUDeviceIOMMUFDVDPA.

>
>I wonder what are the difference between their implementations.

They have different way to transform HOST_IOMMU_DEVICE(idev)->agent.
See host_iommu_device_iommufd_vfio_attach_hwpt()

>
>Main reason for asking this is that we have alloc_hwpt (and will
>have alloc_viommu soon) too, and should that/those be a part of
>the Class op(s) too?

I think vIOMMU could call alloc_viommu and alloc_hwpt directly,
they are common IOMMUFD interface no matter VFIO or VDPA backend device.

>
>> @@ -833,6 +834,11 @@ static bool
>hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>      caps->type =3D type;
>>      caps->hw_caps =3D hw_caps;
>>
>> +    idev =3D HOST_IOMMU_DEVICE_IOMMUFD(hiod);
>> +    idev->iommufd =3D vdev->iommufd;
>> +    idev->devid =3D vdev->devid;
>> +    idev->hwpt_id =3D vdev->hwpt->hwpt_id;
>
>Since it's the default hwpt that VFIO contain allocated, perhaps
>it's better to call it default_hwpt_id, indicating that won't be
>changed by further HWPT attachment.

hiod_iommufd_vfio_realize() is called only once, no one will change idev->h=
wpt_id.

Thanks
Zhenzhong

