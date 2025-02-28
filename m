Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7555C282CD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 08:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnw1o-0005pg-Dc; Fri, 28 Feb 2025 03:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnw1l-0005nn-Dy
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:47:25 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1tnw1j-0004jU-DD
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 03:47:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1740732444; x=1772268444;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=uWplX08+dD6RD8/7GZoeI+wEsjmOuBSOXeI21u1Y4i8=;
 b=ARyDu+3JPuauPD3+NHpjNaTgUzbVj/8t6VmiLHrfWdE9mU0WDZIdqqrG
 7GBF9nUS0gzt4pI5zeu19UPIgfyJKs44QuvEt+g0w95Np4x4UimiSHsUA
 HpHhvJy8SS1NtKCDj2qqb0t1WHEW60SUkEnE3t/MQOFpe3XypfQNIBB41
 Muzwrt1cTXP4I2ZimNaw9c4rNXFHMnlvBSgRMrCFXpgCAXMoUnA5RyQB3
 XsgIqSh/56XNJY9QHgYlliLN+GAuY7gv7dqf/ZUp7Bp+QEcB/4o5H6yws
 b3DTqcD1SqzqVl9+OS/L+WlQ9yBr3ECt5Jms12UgI463pKQ8qOv/MgGr+ w==;
X-CSE-ConnectionGUID: ZLbNZfJaR2mOqnmavjFg6w==
X-CSE-MsgGUID: q1EH9oJQS5692/eM+36Wfw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="59065363"
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="59065363"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Feb 2025 00:47:16 -0800
X-CSE-ConnectionGUID: 3UtxRPqpSCqfnprSi7fz5w==
X-CSE-MsgGUID: JCrvEWZTTGaMx3kuZboIeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,321,1732608000"; d="scan'208";a="122224133"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Feb 2025 00:47:16 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 00:47:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 00:47:15 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 00:47:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kP3fj4imvpz8lzOVYm3H9ePlsMrQ8JL+74zTch0nldq+dDreIEg4wKscJRv7w5Q1FCHvKCGAkb3Vh3c0zXGAuwWP3pq9L32SJvun1BAToOQylz8TmwrWZDRll38/dPB4Rv8GvLUUfWNw6lotOzXj4AJ/+XTwqxNTZgt+1wtoMRhUID3tg/Y2n5IEzYo/zefmKzscvXnWwWHFr0waMqNm5MRXL58O/Lo4y34I9BV9hm+D3SDe7jtmqQsSQcS+aFGqULJPFq7nchQ+oGvQyvjvdFgLcenLu6GIXkrYtwU9udSYlXdUJMe282I95hA0FUj74CMpVwBlypD1GeRsRJhThw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWplX08+dD6RD8/7GZoeI+wEsjmOuBSOXeI21u1Y4i8=;
 b=hjxcd4XxoDSd2bdLaruGvW2a6Iw8dmYdz+A6pv1D3s437YJpb9AGMLfDuYLF2H5vlv624KUFEV1hgIOE8xnkZ/VWaktPYbmdXLVlb2ikiCQicY6wxR6IRZ38tHAUI1TKeTrDny/KkMw5bbB7YUKZysRX9yJVtpgaqqFVQrmCX42Dsp5XDG6b8tzod5YWJgaGFfVIPqD0Srtnsr/n6ldV3MmPYzzlgXUSU47MaT62ku9lEBMIgOgj9egcwQUjhKYA+7bd4IVOod359fJmp3ynl12l6Buqusbwo9CKetBhumX9ExXkGkOkp06Hvt1SCAczFiyyGl8GANNIwba5NN5nfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Fri, 28 Feb
 2025 08:47:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%6]) with mapi id 15.20.8489.021; Fri, 28 Feb 2025
 08:47:12 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: RE: [PATCH rfcv2 09/20] intel_iommu: Rename
 vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
Thread-Topic: [PATCH rfcv2 09/20] intel_iommu: Rename
 vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
Thread-Index: AQHbgqgQjVOfyga/6kKBS0dgegEC+rNRjMOAgAlumSA=
Date: Fri, 28 Feb 2025 08:47:11 +0000
Message-ID: <SJ0PR11MB67443B607AABB0BCFA5D57B092CC2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250219082228.3303163-1-zhenzhong.duan@intel.com>
 <20250219082228.3303163-10-zhenzhong.duan@intel.com>
 <950f4531-7614-4327-856f-45a2a2f9cd21@redhat.com>
In-Reply-To: <950f4531-7614-4327-856f-45a2a2f9cd21@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB4872:EE_
x-ms-office365-filtering-correlation-id: aeb0713c-7d75-4943-eefb-08dd57d47e3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?dJkP6dWsZN3bUyCMsxruDAhMMMKhiM7dxhDchIYNyicAMBq6i+9xwNmwIGzo?=
 =?us-ascii?Q?q6WVu/pTb1nyDdGjow+JIMBg/NVTH2xevLI7bzRe6DU3EewcNzCkyB9kRIgG?=
 =?us-ascii?Q?WnJ1DXccxT5ttLwDCUC3mitZzoWAUIfMKahrbsBJAcvkJs7pp2LrxNBV6ki/?=
 =?us-ascii?Q?+iAEDApD+eTAkHH8GVej1jxmnL4oEvNfbmWIsUJfxKDICdIPLHL/FUMxBBsj?=
 =?us-ascii?Q?eKW5o1Dw7q6/z9agpu2ULVk5/CGRXocFLaB52Ow+oGwhoYxL1sSyUOMXsk7x?=
 =?us-ascii?Q?Zsy7x61PMA6ZAGgbfeoPgqfeISS99JQrOvCQ2tTKHgJH3riPkEQ2XIU9lvie?=
 =?us-ascii?Q?KtdhDdpJkw5/uPcE2sZUh2qWWXLxbxHvjms0X+ZVQXsxlfCRW3FwSkrp4jJQ?=
 =?us-ascii?Q?geSe157itshn8KxLkL81uMno8N8ecbvYml8/ikt8JU+oUnTVuPPnRwgV5CJ9?=
 =?us-ascii?Q?hoQA8rmND9jM/pnmgGaEV0hx4Bu9vXD5+7MDnn3RNpI6aiz7qCTsHbxAow9D?=
 =?us-ascii?Q?JmQ+1SD2PLbRc5OpHtycMSy0E+yrdqLIM4dhyRAZbHT+nE9zkW1/Ybc4z+pZ?=
 =?us-ascii?Q?TeCbGr6aJrbbPZXiy/HxyNs5zSncNDwiyhc6Op4e3T0zNCmnBaTU4Ld3tASZ?=
 =?us-ascii?Q?4rcMR+LsgMynWfn1O2ze2sGej4uQV6VrLtYs6V25KJIYczA5NLwVXW4BlHCd?=
 =?us-ascii?Q?lun3fCdrbEghs9CC/qiCqqzkInGP2l0Ez/0VSsbkUvk80sSTltXxQYfbV2b/?=
 =?us-ascii?Q?cv/urtwX9suIPPS8iTDTIn/02irRa/y1y+/Pj9lKuJVg2TQuNJw7akOEteqJ?=
 =?us-ascii?Q?ewrUtiH6AyQSc6PNLPMDgD9kkv0dIj95NQ75cfJDG3w2k77wU1khprD8M+A/?=
 =?us-ascii?Q?KV0BwRpbJSBTgFuZruOUG3kdXeSul+pHRT7uZFyXxf0ncxP6AazNea+6bWLO?=
 =?us-ascii?Q?lgQUxZFAoNrd+p/7IWxWXDBV5lvf3Z4AuqDcJ5a+blBwnvIN/N8wAuhPqn1i?=
 =?us-ascii?Q?hF+BuJsMH1cTltxdb7u0wK1IjMrcyKVUwFuEs+sijhgPzADHsZ2VZFGwgoZN?=
 =?us-ascii?Q?Y2v6p2XIhEunQvFgrMrRywVtGc0f2UlVzrBhbsjnSV5squrQ5yQNc2DSdpJt?=
 =?us-ascii?Q?hJthhtZe6fv94ekzQIH0PbpIrGMOYLQT4Mx6IMtYQ2FnlUoYC7u+mMuoprGZ?=
 =?us-ascii?Q?NpExKfkJxOWH7QkklqPSvifbozYvzTw/tk0wrDBSSdPjb9j7TWo49cjlfzf2?=
 =?us-ascii?Q?eJ0n6hWP2YAGS4n+bh1vfA5O95YwVnKZWaoyq3YM7wNv+UOAQYbuXng92jAO?=
 =?us-ascii?Q?hnNTTAWqEfDXYSzl6lDLyej1u+ClO48SAK6skH2Lp27yBJ19C/c5X1U2Cf6o?=
 =?us-ascii?Q?RQAckCHHwdpuotzRxABoL+uISKJUYxE1CeGbZNpQ0mnmRoMFc98Ra7IG3xXM?=
 =?us-ascii?Q?Odj0VXxUbEz2XKvb3eWDn/94ZbPDFSuY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hoB7mt/lwu996HBbxCHRMWajSzm4DzauyQSIHgEKhOj8WhNQkoVBBnuolOo1?=
 =?us-ascii?Q?tbHTYnyn95jfJW7kHscjnTXqIaePh7mxjKX3DfAyqq2WySXx9xeIu1jMBAhe?=
 =?us-ascii?Q?Akl3YRAdIMTTenLizmOzKPe5EAT5WKMQWJ8QfomTnU8C+ySBGmr/pLXTQFBB?=
 =?us-ascii?Q?1OKGp6wSSeVEhLBTp482+xLzFMRndz7QY2dKuUvZqAk7h8m4Y/SJhfNN4JwS?=
 =?us-ascii?Q?HJSnV/15VzVZLkaH4tqzhGUTbVWWYPbpYFYPsbW6GfEoJKrllSp09bTnw0bO?=
 =?us-ascii?Q?TncZtzY9jtyBLGvbwz6bFYqBraebD4ZdDlMuWoNV+LyB+eoa+7UBK01kjB+F?=
 =?us-ascii?Q?12o36zuRDZLYo03JOG6wPlbmgKXBfQyAgL2aVTLpam7SULe/3MnPYn1YDrYX?=
 =?us-ascii?Q?z6Q2hl/jOO8SO4TO0a1AIesDMrf3ZluoSVFznWoXctpyRecyNrvl15d1EaZI?=
 =?us-ascii?Q?vZo4/KwaocvuAWgKK8XEMkmxxjfkyYFpc18dvGl8tEbv/bQsQsFjG0c8C9Ma?=
 =?us-ascii?Q?Qo9Cq+HeQ4InAfL73sKcc81Nrcjq2fha4zxsCIyB8z+G5u8rjN/HCkRqOBmh?=
 =?us-ascii?Q?LCYLgN5/D4g05NH97jw0Lo6qE++rQS4Nz/erqV15CYafgN9quI6vxk8JaOAr?=
 =?us-ascii?Q?1R7IqGZkcxgDgJPSwoaLxhSFwKctlu1n2fmov0xRQX9K1Vjpr7+cAlqPWYiv?=
 =?us-ascii?Q?FwGTqE01XBSwSLBqgu/iZr7di2JSofQrMxKTTR+SHhZpHK2azE8+4/73k3O3?=
 =?us-ascii?Q?wnBemi03xl+zt9KhjVbtZbuaAa0v4BiTrRAvJLU/tCKgShy+tz074yOZ/opD?=
 =?us-ascii?Q?G96y2fTdCpJcOL0W6fn/QMScGjjGia89+2lqVpwYOvDYNN1iEOOAWrVX81UO?=
 =?us-ascii?Q?OJXqTTnls2Ied6Yqge0U3u8FmoIrh3NGuf21uhJ0Cl1T+/OznZ3vt42JYzlK?=
 =?us-ascii?Q?LnSJAbAct/FkOImshrMY+zg/+4mNCUQwQTJwpxBwu8HEH6QVyXUf7V2zL4aC?=
 =?us-ascii?Q?/cWc9DqUes1iMlughQNvNu1xRqRvngWeajLP6TUggPW+XBuBIslSP/RVtROb?=
 =?us-ascii?Q?vi2WNbeyBaE8db20hb2ddaARF27CaB5QfrcHrk9H7PEyq3qG4TGoXne9t+DI?=
 =?us-ascii?Q?PMKmjMvTeZL3sI121TegYKTwa3d+F0uYQi8Fc0ewn528TVE8VXEif/QL+DEE?=
 =?us-ascii?Q?gDyoTnNLpZb7Te+pwcCyp6adoobGHB4bJN9hR/HtSlrY2sKqtT8DsXDnpD4T?=
 =?us-ascii?Q?hWiIxlgfNoNyRxgbrQsgd820POFmdsifTfFOlVZJjf+MSBPSRM2PyDsEDC5m?=
 =?us-ascii?Q?nkqAHXfSJoRd+fTA2tkVyhqaEhWe7MQWQlOdO1fAv1IVLT0yW3H5Ug14Cgvt?=
 =?us-ascii?Q?+VfkrB5GScGOqW4Mbd4OlNGq+WiB1LRfkw6KNfRPpXv1d6xbnvMI1xj82dQm?=
 =?us-ascii?Q?z9wr54j4y5grTujYQho6oMekDk7hOo5acnlqoSnyPCuArwDQcIlz8J+qL4Ly?=
 =?us-ascii?Q?LNn+7kI4Ytc5gwhFvg2WA9N4hK7l8XYeae6SRl0zaRB29HMiiHTlncyz1TgK?=
 =?us-ascii?Q?r0zwM+Z7Xn2nOPMFAvSsEozATeau7jJff8OZBerE?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb0713c-7d75-4943-eefb-08dd57d47e3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 08:47:11.9158 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KP7+VKvQAFpO+HSihbfKMQ1EJMC8Rpow6H+e5gJjh/Tg8LV9X3g4EtQrHuth9/yRuJf9owwupkym4YQQH1YWLLukoZRp3nzc3bjm9ozxp60=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
>Subject: Re: [PATCH rfcv2 09/20] intel_iommu: Rename
>vtd_ce_get_rid2pasid_entry to vtd_ce_get_pasid_entry
>
>Hi Zhenzhong,
>
>
>On 2/19/25 9:22 AM, Zhenzhong Duan wrote:
>> In early days vtd_ce_get_rid2pasid_entry() is used to get pasid entry of
>is/was

Will do.

>> rid2pasid, then extend to any pasid. So a new name vtd_ce_get_pasid_entr=
y
>then it was extended to get any pasid entry?

Will do.

>> is better to match its functions.
>to match what it actually does?

Yes, will do.=20
>
>I do not know the vtd spec very well so I searched for rid2pasid and I
>did not find any reference. I think I understand what is the pasid entry
>from the pasid table though so the renaming does make sense to me.

In spec it's named RID_PASID, copied some desc:

"Requests-without-PASID processed through this scalable-mode
context entry are treated as Requests-with-PASID with PASID value
specified in this field. ExecuteRequested field is treated as 0 for
such requests."

Thanks
Zhenzhong


