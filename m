Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 067B3C77B7F
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Jun 2025 08:29:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uUhyS-0004s8-T8; Thu, 26 Jun 2025 04:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUhyJ-0004mf-QF
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:28:42 -0400
Received: from mgamail.intel.com ([192.198.163.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uUhyG-0002Ej-HI
 for qemu-devel@nongnu.org; Thu, 26 Jun 2025 04:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750926517; x=1782462517;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ObPpK66iOXjqnBjNUDCGXm3NeEU2FqZVhcZREQxUBvw=;
 b=TaS1KR3bAnHhivyMmKDftVbcO5xyBFin3BJ0ohhTgvW1VUJtvjaxNz0x
 kq2dinn4lWVSN3PyuCVhHEQY3B/OYi0EluJmy3xcoACMrWLfZ5A2bRjGF
 p7MnedNX7z2cnCt2yYZwNDT+VL9lYvhpVHhm5+GNf7b3h6YascgYQEPt6
 NgJOcxSHqlLm2tjQAe+w6yVOv2vn7dc/QKbIx0j+6n7JgmCYYSOIgZzXL
 ldotnV2t+ygmNTESgjLwBgJPMdzchwJtsAjKzrSKNZMmiZ+UEsTpBivo8
 marOtZikUqjwMj19vMZhTJ6ekR/9BvZLi8cPpQm+V3abUOqrk8z5I2PTh w==;
X-CSE-ConnectionGUID: hvJYme6ATEeBeOh0KSoRyg==
X-CSE-MsgGUID: r1k18A6DTT2m7qwBVKQ67w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="52330062"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="52330062"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:28:22 -0700
X-CSE-ConnectionGUID: YMjzNrNjTsasW9MxkvA4dw==
X-CSE-MsgGUID: +OtlaKZcRxG0nKSPttal3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; d="scan'208";a="152956038"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2025 01:28:22 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 01:28:21 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 26 Jun 2025 01:28:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.42)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 26 Jun 2025 01:28:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ih+EQIg7ufosYy9lwjfaXudlJwPkMLBm6BSbkGthp4wIKvGFVw3rjExMzdYTbUqBfUBGnPSb4XeuilHTXZNiDGR1WUuRYB4z73UqbaY7qEYvUYsnX+AVbHi5jrT0Oy6mDMsyH7eKcjQgoGr4cDypML2vDzPuZTx+eWNjMjj6zGqNb+QQAADTEhl8KwIZdwX00QMhcjUs6g7mblt1zjqQIOUy1I03mwRue+fUKpIHCyGmcecMehP97+vpeDcyzX4ywYTUnkm5RblbmcGbTAKc2hiSxRrzcue1s2zghieCvoLM36XWo0lcis+jHpRxh4Xk3j1UGCGNi177z5UQxCiHJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ObPpK66iOXjqnBjNUDCGXm3NeEU2FqZVhcZREQxUBvw=;
 b=DcczOOn6C1SwjJEp6IF3BuR3v3ecCuZVbjIUCcZ9dLE2kCGnuQWN5VjNGmu6dZQIXYmrYR+GigQpw6OR/p49GJMELtaOkyjiqZbbgQ4p+sP8KwSV9Ktxwu981IZohlBNrUDHwXbNasQJvCfIhEjXIhD8vB1wU6gAyF8G1EVOykVB5oi+xkxNDGTaOp7dcHoSJ1aBgtDsMR+g3yn61ZaoZAzsKs+cQs97MFPS69Oq7hFSrGWTS0uYOGP6z1lohgeGGE5pBQw69tLParWH7AUboZ2WXEaxuJEVfVRUAea6/UaslWKF/H2H33tLmrBW3XxRs0BZc4+a8eow4Ga1RnOs8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB4834.namprd11.prod.outlook.com (2603:10b6:303:90::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Thu, 26 Jun
 2025 08:28:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Thu, 26 Jun 2025
 08:28:05 +0000
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
 Sun" <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v2 12/19] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Thread-Topic: [PATCH v2 12/19] intel_iommu: Introduce a new pasid cache
 invalidation type FORCE_RESET
Thread-Index: AQHb4bQyFldcg2x/bkqV8Er7xVHlpbQQp/8AgARdeiA=
Date: Thu, 26 Jun 2025 08:28:05 +0000
Message-ID: <IA3PR11MB91369900C5CEA3CE218F17D9927AA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250620071813.55571-1-zhenzhong.duan@intel.com>
 <20250620071813.55571-13-zhenzhong.duan@intel.com>
 <e402a485-66be-44d4-9cc5-aa7157511f76@redhat.com>
In-Reply-To: <e402a485-66be-44d4-9cc5-aa7157511f76@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB4834:EE_
x-ms-office365-filtering-correlation-id: c236b35b-e13b-4638-3ba3-08ddb48b5fb5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?0aN7bAn0r89mBqCIoKfNbpX9JVMZBYxc8ybG6enzrT0j6rOvF4C535eRq4wJ?=
 =?us-ascii?Q?UmOJjVg+NdnOs4aVoDf98QPb/npHwnDux4m0BbckTONzAynDboQmol6IEkFy?=
 =?us-ascii?Q?ei/UGCbSla6DSNOBBQNOjKlhX8VDyAqOSQJ0Ng8C9o5Sp76ms5akCLWzVPVN?=
 =?us-ascii?Q?kW0Y7q3E1+YVnmL6fP0JdEVijXnm/IPCcWDGjnVHa9EiiNS7Zy2Ewb70P40x?=
 =?us-ascii?Q?UmZK7HChAxTOibFi3dyjjMPXCVmXJ0jyDMk3dT0MVyjPfG5PYqgOLzM+ciq8?=
 =?us-ascii?Q?PnQu+Mw/Ey4WaTRM4imAFR3V3lXgATuZhSH3Jkioxf+MRaedw1R/Zi9R5vAS?=
 =?us-ascii?Q?DINU0mhhnwFM60vOP3oszdd1+NlFjw8q6JnZDqu3RemgVqbrX3XWQ1YWQT5c?=
 =?us-ascii?Q?3k5sG41zZMs0emp+UUDFgoPxMXD2ook/rDH+FI0WswszfY4AKZ9GYPhpziH4?=
 =?us-ascii?Q?OuyHW9AWH6XPU4nTtbRM7kiIIvTksTu7G/ys0T2e6SlarjNu/IpvMiyhTVm7?=
 =?us-ascii?Q?/vWZZH5c5A+Ry709puY+YZMmotorsqgIXe5wMHRxhONtYMC9NHrsg60e5jc9?=
 =?us-ascii?Q?2DuB1tDXKSEXrNrl0SZzeysR1v0GnOSjZ9qkz2/jX2nE4LeOMasSl72CjLhP?=
 =?us-ascii?Q?Y5c6K2TiatDY69KJn9sbtFD7MJVLBM//3O+xGUkV4J288uF050hQsxlQ1zPc?=
 =?us-ascii?Q?5t4wxGXYg0AwfFHX18uNFlVuq27hYSnjDJml1kcp/9X1fQPvUrUTdjsXuRJ5?=
 =?us-ascii?Q?m8qQtlKwe5CftHOtV3N91h3nTAy5AtAN/DNFmW8AhmsYpR0E08lFyp8K3OLq?=
 =?us-ascii?Q?QaBvZ5IXVqjlC80eqPakJD7UmkzH74jG6w2N3QJiPC8454kCQVmr/4zFMhd+?=
 =?us-ascii?Q?OzRr9Z0FE2/tcu76CKiWIYyW0DHV9u7Mwwo8aII8ENRsn8epjemlMN6Rs2yn?=
 =?us-ascii?Q?ab8hVZ7FO2CYubu5+aJOdWs3DWzOx6QLcoUHPRtuqF3XlTgqcWB3t3tBak6r?=
 =?us-ascii?Q?blwM1fP7gVlXbV+4s2+0hgo5YIl3/BL6RCVovsxj7w/Y/wxvHe+BioGuFyR9?=
 =?us-ascii?Q?22HPjA7jrdkpjSNVkD4Z08YXLLG986DdWl2hBpG0u2u89euu/7GzAyfDrzGe?=
 =?us-ascii?Q?BBaEDb5bltussZvrCJ5qV2BMFbs4Xg8nyeQFkQ5R2/SFWtJ+xyWy8LNq66F7?=
 =?us-ascii?Q?bKbGbWGUrS4JkGEQD5PHcpuGDwRzoZLdCTLIsg5X2LmJWnMzu+tIbvBs+U/P?=
 =?us-ascii?Q?ZkWeR5i+c9Yu05dhbADhpic+UAF2XTfvL8gVGBVjle+Xgyyc7LZ6dYQx7yZa?=
 =?us-ascii?Q?gtXQzNPKKemhYSXHpe9u8JOF5Cjs+wlS3KtBQ7fFPhzubNQKOI5DvGg0wMe7?=
 =?us-ascii?Q?nU1dnFSZ0sxw5jXO/I4cTaX0j8+0j3KPbOXepn7SDTipDvt4gRJ2hzeBGhzo?=
 =?us-ascii?Q?7CtyfLsXy24QM8qCxa1b0l8tr2aMC1h3mlrvxUTHLvugeYHYLAt+rDj7BB00?=
 =?us-ascii?Q?pJl5AaiynXjlXbk=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ApNISoMr4xn+rjo0diq0H2Ov9IhY45GgEVBrKRGjjdqHclo2EqXMetzkxBT+?=
 =?us-ascii?Q?1FpvC4QjAzAHavPrJ07MOIKmQEVvepSNndm14jYGTmmlfgrHWuuVgBss7ewk?=
 =?us-ascii?Q?FC3hNRMt8eOmUxKDbKY4QaFg10B4zYHcZ/5aAjAh7/E/s0xoGCcrJz7Lfs31?=
 =?us-ascii?Q?c9Zujd0BVIsBi8MA7QWDFBV600Ldg60XddiBxTwJi0Fo0kWJgwmziLpD0Wjh?=
 =?us-ascii?Q?Cjphrn+pmIj+y3IyvtRrDIksVWpqJ1TVt+0t5ka5NAuGD+Oehfr9fxh8reVU?=
 =?us-ascii?Q?N1puIZwgIcyZeh2mQh5E3l/NDCGfO0hg9bW3eytRK42oC7jP4KJcFnUp+2Dk?=
 =?us-ascii?Q?v4BDxMYwh8D2b5xXJXrmSaTX/QedSMfxb9xrpk2sbEdJTHCw3cxF1slNGah6?=
 =?us-ascii?Q?K/IRTYZDiN1wzFhAJjMUCZnqOd4co7aXITBA9nHZGt9q+FIY5jj1k8SinN8x?=
 =?us-ascii?Q?Wd7dbqv5pZ30mDFreRdeTPjWDkulNakQQzq2EhBw12ys4z8HM5HhGfyOGFJO?=
 =?us-ascii?Q?Q+22YlYQoh9X1k6Vm8ON40374mVzQRYWs07Zfn+bgXT9wCmoQ0v5wqFkJLj+?=
 =?us-ascii?Q?jMQZzQ+6atO7P7B4IIiwZCWMwM4iR7fkRNlgV9R0naCu48s5BbzElm3G2GZd?=
 =?us-ascii?Q?tmCoZUSEq0MdRnHn8r96dyh2EnT/9PoD2hLAJE4XXBvYDHrkz/uO2Dd7FTiw?=
 =?us-ascii?Q?eldkYRkIPduZKoTtSiZleVkoplty2E1I6MOlE0WQe/xy+Y+waxgF0850vPx3?=
 =?us-ascii?Q?H6a1AqNi4JTbn4X1GoEsS9lAF6NtaXBmD1O7+F3EGjzMyqxLflLAUo+HO8YJ?=
 =?us-ascii?Q?aDLN6RKb56mVE+r0FxX+XaR+UTsJtQm3xGcPXiZ1GZT2Xf9ZjDBelBbBpuBn?=
 =?us-ascii?Q?1hmn+mY3L59gegzd2RPLWeWkYRy0V49u4u7clBu2yS0+fmgr5XOJwyVHwJHX?=
 =?us-ascii?Q?Bkvecir8dsz3aPXjbsiVul6W/BkFpO7mqbvukJ3hk6PE5pPM0NpFEpV5lVfW?=
 =?us-ascii?Q?81LLFQuboPnYVGHyYmVPak8I+xLUXjM5zcSBT+ZTPjt4J04768cARiV2wZsm?=
 =?us-ascii?Q?zmz9xHlRZ8/MZqIQPNqvBrgXk/jykF6SVhywaT27DaGp6YbLUR6/3yTe0yG2?=
 =?us-ascii?Q?iOeeGrvTww2ycqykfHM5AsNkXKCywTd7fGuFUPzEm7eN5D+N+/zzsBZd9FUZ?=
 =?us-ascii?Q?l9ECcV+0NLdDhv26QjiCOxua2HVttCAwfPnrbNYlHmA9Jkglc9tZDhlmkLTw?=
 =?us-ascii?Q?73jFJsiMsepTUXdPmDSuMSdT4/aww5qPTd91V1eAsEHpuz5r7LsZHpz7O5tA?=
 =?us-ascii?Q?0cGqVFAHJ+3zuDuuLgInCixufw0+S/0mWqXDGfg/jzrj/VN5RYFHZbx8cEPx?=
 =?us-ascii?Q?mrmbZ85+vduCqJxOtIfiaiDvPrkZAuBjMSdqMotFcg997Tq6r9uvu4DkmRW1?=
 =?us-ascii?Q?VEQmNaPJjCltUEXB0amHWsdPTXsFbr5Bu5/hiPGQ1W/0alJ1A/fnFpQVDbr8?=
 =?us-ascii?Q?mDSbGnMBjrLQCUeDNZUrGQiEjyoHrnRZS6rZNVDdCiAuvzkdU3ZwAHlSERer?=
 =?us-ascii?Q?73SusN6vedeWIF8Yd2i0S8RygRCAqVev0q8G0oir?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c236b35b-e13b-4638-3ba3-08ddb48b5fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 08:28:05.5499 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x7dZNTHlbECM1BRAiStiNNzTwWL6Qj7Yey5EaJoUCF3KlqeTXosow/3hkbrLrT08Tl6zxetALxTvR1edXFKVBffcUcYIh8901qI8AhY2ePY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4834
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.19;
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
>Subject: Re: [PATCH v2 12/19] intel_iommu: Introduce a new pasid cache
>invalidation type FORCE_RESET
>
>Hi Zhenzhong,
>
>On 6/20/25 9:18 AM, Zhenzhong Duan wrote:
>> FORCE_RESET is different from GLOBAL_INV which updates pasid cache if
>> underlying pasid entry is still valid, it drops all the pasid caches.
>>
>> FORCE_RESET isn't a VTD spec defined invalidation type for pasid cache,
>> only used internally in system level reset.
>this comment shall be put in the code, along with the VTDPCInvType
>because the reader may look for that cmd in the spec.

Good idea, will do.

Thanks
Zhenzhong


