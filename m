Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB64510BA420
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 03:59:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5yLE-0003sN-UN; Thu, 26 Mar 2026 23:58:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xudong.hao@intel.com>)
 id 1w5yLD-0003s4-BT
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 23:58:35 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xudong.hao@intel.com>)
 id 1w5yLA-0007Fv-M4
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 23:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774583912; x=1806119912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=B6QQpJFg1wDE/mvo8lrnwXeaKNC3mMu7gEbGPl/jUgI=;
 b=S+X8wVzl2JhAiX/o3E+RsB4Ph0KbkI8lksF7OJ+sM7S3E8BrUdN9AkKj
 JCqXov0GsPw1ZqBNniubp5s3Kpsq4pL4KjlronfS28Q7jD8sYmaU+9b1I
 C5Hqbh5pZUfV27RsUIYJb5j7DG77X0y/oBgnb1qe1HaVVW5+ThO4vpV6Z
 y+Hm/BSYsaj3N4KolQPifFaP5/PkoDbJIdM1nd5BvDHp/hsjCnZ8r2JVx
 DbhXGKyHYIOV72tQnyOUtZeFmwOVq6mQYhl8XYxygKZhYeVuQzGgaiVCr
 VTo02zOv2kwh8kwQbG5EbJBHFFbe7E8LJpU8Z8zwze+EXC2OEXXp5obsd g==;
X-CSE-ConnectionGUID: 45JEP/a/QhOjnWnuC1Px2g==
X-CSE-MsgGUID: nitHIirARNatTlVfoH/Jow==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78249869"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="78249869"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 20:58:24 -0700
X-CSE-ConnectionGUID: OWRxKgL7SsyywZDR7zxNdw==
X-CSE-MsgGUID: XMqAePz1QpSDAbtOcQvskQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; d="scan'208";a="224390824"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 20:58:24 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 20:58:24 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Mar 2026 20:58:24 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.36) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Mar 2026 20:58:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UTmIi+0VP1cHmx6a1hpLDR5dYTLrlJOE/q4b2yf+dFsFbEm0Syk6xknJBWn93ggKimdcp5+MSmDrMAujLCUURBvcUAXovKkY6x461xf9JfuE7QxRnVnQoYAteadJwhU1mAb59+C539tBocfTrzWaAMAkbt8773pddzgM7uyaHjJP18IYnjXG1IYLMTlCpLujevxhYSg1q/KV8cRikttm5hBzyDFR/4Coh0QSp/kfQS2LyJy9J2KuubW+CeEyaD6YvQw7+sLqjIHuh2E/RTAzLd/zIj6qXRiL8hpoX9VL8dZAhzjUumNe3dmkkizvAUpH9eLuB+Vmb3yTJeWdk+sC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B6QQpJFg1wDE/mvo8lrnwXeaKNC3mMu7gEbGPl/jUgI=;
 b=jnPe0R8lNe9kYSn7x+XM7AGFddD3Jdllj1I2ppnkzvPv8mVLTWl5mJzTOlRerIucRHOrAqSVWI2+aNhSyaUQC6waRAXHGSri8MzXT2lKGrufRN23mkPS258noEKs1X2iML5qZRNNeLxJ7C2pNz5sg18PFR9kZRgrks466jG7e6spLdfioxRf5hCykj+WErTpH3TQjVYLC3rOWkK4jvVv52enpOB3e2H0CeeETIrcjxmqkbzvMN01C7qlh4/cWMDOaff17GE5iSW9yBi+Nwf+kvod8bnTRYEDwliqq3mb86q1IP2DwZCbwL/u6Z+NX0dwcG4mNMdaurgVxfPLhK1UMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB5278.namprd11.prod.outlook.com (2603:10b6:5:389::19)
 by CH3PR11MB8520.namprd11.prod.outlook.com (2603:10b6:610:1af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 03:58:18 +0000
Received: from DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::1ee8:ba94:dde9:5267]) by DM4PR11MB5278.namprd11.prod.outlook.com
 ([fe80::1ee8:ba94:dde9:5267%3]) with mapi id 15.20.9769.009; Fri, 27 Mar 2026
 03:58:18 +0000
From: "Hao, Xudong" <xudong.hao@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH v2 00/14] intel_iommu: Enable PASID support for
 passthrough device
Thread-Topic: [PATCH v2 00/14] intel_iommu: Enable PASID support for
 passthrough device
Thread-Index: AQHcvQCWuE7ebMxGNkW5tn/vx/Er5LXBwMyQ
Date: Fri, 27 Mar 2026 03:58:18 +0000
Message-ID: <DM4PR11MB527878B1C943922C0B2790C98857A@DM4PR11MB5278.namprd11.prod.outlook.com>
References: <20260326091130.321483-1-zhenzhong.duan@intel.com>
In-Reply-To: <20260326091130.321483-1-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB5278:EE_|CH3PR11MB8520:EE_
x-ms-office365-filtering-correlation-id: feca161c-43cf-4359-d87d-08de8bb5146e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: BbOXCxhGSLjlxdhFxK+B84vtLV27wHVR0pEin0h3A9EcwbrR8HJpOwetyoF9hcLCdcKySHzovFAXHMpcvNiiPc5xxiJcmgFdtSGg7FuFPLCIfVeps+FS6RB19WSFjqFdfeDjDxjc49x/Xqg2lZ3oIkSZQEqfUK65dRc9ptRRgBsHfF/SwS6PQfEGMtIJGALo4eeDxe4e0ekhiIsvMfIlUMx6HVtw5R3xEvLFm0Hyf0UaLUm/eTg64W6XIDrXdmTyzm8dgx/oYizE/xr5YwFxu3lPhLsyQanXgTIhzEa2MANqKm6y7AOcAYmZFFfXqys3ioqPVzQcm5uLiMvcuXnePg2S4V7e0SJlgOjWIdyooS8C2eCD79/h2bvTnVa6mHcRDg628rwP+L4XNPc+obpc1hK9NabL0yOwEg9xdOo0dlDSqkpLkfsNCKT6JZVnNkLvfe4krtkvzqnFiGPkDr7b8d2p0dCqxb59roaQ+K/ZUPTK/VfGBntJxXCN6p8AAGDzLdMT4ATho8z2ARBa4ArjHcKgfFlk47C2+Bg9cYX9LJD8ggybFJtAcRr+o/hSpvUHPIoHbAFUo4e6BmI0z6XovgeRa8/vMShU1CTotCI1ZyRgbWAPMg1bpcDsCQ63y7uHp2wqhPfMYbFZpnj/mdMwIatWp6BdzYFSkwE2gRAvZT/g2oQDax4yyBg7VSQo4JxqyKFHyuAXrDQKVcTk87pPtsMutHuionS98fIzPJTymQK3oL9WXsTr4z5WBtTLVydA5QZiWDCwH/PpQKUfvYfFXBJtLLXXSlGclslSIxrr6yS0V6JswKKYDyV9w+v1ozvc
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR11MB5278.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWNiK0RtTGgwUzBtVkVnbUtJbE04MmlncklNZGJCbUJTeVJJNmRaT3hBK2F1?=
 =?utf-8?B?eUZjRFBqNDhjeUdQQUFIR1ZrcHBpOGhHWWR2WCtFZHViRmd2T1U1RU5qMVY3?=
 =?utf-8?B?NlcxVWJlWk5UbTFwck5DcXJENklvZ1ZUQWxvQ3dQUkk1Y2J4NUtCTVBsQUlh?=
 =?utf-8?B?aVBDVUM3NHlPaHpSWGI5Yjg0N1FTZXdvK2s4akg5T3JiMmtTWExyVlRvRmhM?=
 =?utf-8?B?VWxBVmlIQ1BNZTNuNWZOQ3k3OU1hR1hhbS81ZXorZ1BtUWM3R3Rlcy9XS3U4?=
 =?utf-8?B?NzdUK05tbzVWaGJXeWNFT0MyZTZkL3VHamV1K0t1elcwcDFrY0pneFBuWERl?=
 =?utf-8?B?eFg1OUZ6RVZvYk9tSW5HRk1SNGN5WE52WmlSWmpDZUgvUVpGVEY4N2VGYW1J?=
 =?utf-8?B?c1hqbkNQQkt4eXBkZ3BKSWo1OG4yMHk1TUlpc1lFTEJpYVduV1JXUEgvRTcw?=
 =?utf-8?B?aUEvUGZoTkI2WVRCVDR4UDhyZTJrS200THJ2WVlQYk8xVTNQMGJPMHNHeXFI?=
 =?utf-8?B?OFlLZEJGQURkYzZqWmx2NVFpQjFLcGIvZUVrMitoTENLVlpsYUlxd1M1K2ZX?=
 =?utf-8?B?Y3o1THlxS09pSVpqVGcxelgrQTBUNzFXTS9ldHZzMWJTOGZRamRKM3JXYnVi?=
 =?utf-8?B?R0lmTk1seDFoVDAzZVJDOVFhcUhaS3FhTzZ2TWg3dXlPNGFFVFJoT0ZaYmV4?=
 =?utf-8?B?aVBDSnBOSUNtbTBkNEQveDRlWWR3cW00bjNlTkpGSHNPbFlqN29hckRmQ2dV?=
 =?utf-8?B?blc5VDY0M0pwV1RJMEl6eWxRcHk2RGRJOGUzZjZCdEtOT1oyWHIzREZ1M0Q3?=
 =?utf-8?B?aGJLZ3VZaTQ1V0VHakhySGdYRkcxY1o3cTkvTUV2Q0hvL2cyZ040ZWZlYndC?=
 =?utf-8?B?cjhIVzhOeVVpWHYrcVJ0bEJqVmx5TnFqNDhnZUFOQ1ZIOFZoOCtzcE4zNHNz?=
 =?utf-8?B?NmRzU2tMckVvVDc1bndWY3d2Y25tOVRCSDBBQTB0cTJJa0J2T1VaRm5DMGpJ?=
 =?utf-8?B?YUJFOXV6dmlhN2FzV2tXcjVVVUN1c3hxV1prSm9GYzVxUVNHbXhTbStYSnBu?=
 =?utf-8?B?aVI1ajdTUEpmMmtybStKQVFKUWtySXpnS1FkQitmcW8raTFVSk5DRWhQemQr?=
 =?utf-8?B?eHEzVDhVcGVCblZPUzZQS1V2ZnhPNUxlSmw2RElBeHpmUTZaaW14ZXFkRXJO?=
 =?utf-8?B?Y2ZiWEh6M3lRUGxZbWVLODNnT0ZRNUxyUDhSc3c4VHE1dnliRWxYc0xaMWpl?=
 =?utf-8?B?cTJuT3RDTjd3UGpXOUNzWUUrb2FYWXpJekJLbjQwY0Vpc0xieFZJelZpTGZv?=
 =?utf-8?B?TGI5dlFBVHo2UlllclVtS2IwWXhmTlltcVdmRlE4UVZXTXRtY3JjUnpBMzlv?=
 =?utf-8?B?TkNhN0hWLzRhRWVmMExocStrMXlFUkF3dkdhRFpkM09zWElQM3MvdjNwZXAw?=
 =?utf-8?B?bTN6NnpYVlh6TkpCUEMzVGxra0xJV2MxMVk3UEJoRlVlSGpSU05qUk42WnZy?=
 =?utf-8?B?cWJwczRmN1NjL2FnSi84c0NmUFZGZmFqOUdVT0ZBeVlNNnQrUDhJMXJOS2hP?=
 =?utf-8?B?RUZKakh4WHNIR1FzSkN3VWVWZ2I5M1NaWGo5WkdtTFVvblRPR0w4OEZzbXFU?=
 =?utf-8?B?TkJXZ0NjWUZSbGh2ZDVsb1d5UmZicVhab0IxVjd3aVIyb1RNai9RQU9sSjJF?=
 =?utf-8?B?Ukc4eWFXU3ZuZkhVdVZuRnVuNUxZS3V6VzVYSzlMckdSSThLaUVyQjdxM3RN?=
 =?utf-8?B?MDVKdll5NGliWFBzc1JUVC85MkJiSTNJWkhFN3ZTQW0xM2pJaWo4US91eGRm?=
 =?utf-8?B?Nk05VXBqNHZ1NHM5dkVPRFV5aVJKNGVybnVIcURGNzVxTWRscnVvdnBPc3VP?=
 =?utf-8?B?c1gxWHVaYzFNUlFrcW13cDNVeXdnZFFxN1lIS3JiUWJNOEp1Q0ZWam42TitG?=
 =?utf-8?B?d2lKVGdVT1ZDUU5vWjQvUjdWTFV0VFVnTkRQNzhiZldFeXJSeDVJSnc4bXRq?=
 =?utf-8?B?QlZraVRpc2EzbTBudFBaZTExdG4zYzhsM00zSmhCcnFBakhyQmZDOVhyLzdU?=
 =?utf-8?B?NnRWQXVwbjY3a1krVS83TDJUVCtxMlhhVEFHZEpuQmFnUVVMYVY5Q2tsWEla?=
 =?utf-8?B?UnNRbFBDczFJSXgyMkJwUFJ3Sk1oOHlPWXVsQUdMdmZEL041RHdIWkdCSEcv?=
 =?utf-8?B?Qk5jTXVyR0IyVWN5dkRaVGt6cXFLTEpSRFhKY3NOUVdVMUdqdXNIZEtrNkFx?=
 =?utf-8?B?dnU3NmFQclNuQlROSTRsdEpiNFdHb1RnUEJHR0NQbFp5WlRxS1N6RVJPTDM5?=
 =?utf-8?B?VkVQSzEzdzcxZkJJc1NtQkdpSzdzb012NkxMaXUrekxkY2V6b201dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: epn75reWw0/fqA/D6wNDBAI0j55wHzbXW1yx2jEu+0YEg68PtbmLzMoiv0gxgg639oesZR3xwk5RRmgAQ1M1+LojYHInoJ4CzWU1w8Y83Iey9BUusWPp4EaI5W78zjXeoeGrlABmC0/3B5vkCksEm4ur0YW/DK9/CP1yjwKmckyuIPyjNF7ZAD3bjYjC48zdvnXGx3dDBCKbKabMjyrFOx7DBKo2BQFLXrJAQrhZ3dSER96B3WDtDH511iTF+touCvr55NfjRZQdyoWKjlwpgD+cVr0mbORtjqcgvmRYE4kNdsOED6uJVafVQB/1Xg5kQrVhf1ddpoH3awJOqstC1g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB5278.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feca161c-43cf-4359-d87d-08de8bb5146e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 03:58:18.0962 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T0czFO1yzkVkpHFL8pM1w1dw+nVF4ddH2ZtOEMhiZu4K4zNN7kV8/wt0LDBhwBoH8leWtNfzx/QAX3kKana6Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8520
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13; envelope-from=xudong.hao@intel.com;
 helo=mgamail.intel.com
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRHVhbiwgWmhlbnpob25n
IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAyNiwg
MjAyNiA1OjExIFBNDQo+IFRvOiBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gQ2M6IGFsZXhAc2hh
emJvdC5vcmc7IGNsZ0ByZWRoYXQuY29tOyBlcmljLmF1Z2VyQHJlZGhhdC5jb207DQo+IG1zdEBy
ZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBqZ2dAbnZpZGlhLmNvbTsNCj4gbmljb2xp
bmNAbnZpZGlhLmNvbTsgc2tvbG90aHVtdGhvQG52aWRpYS5jb207IGpvYW8ubS5tYXJ0aW5zQG9y
YWNsZS5jb207DQo+IGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbTsgVGlhbiwgS2V2aW4g
PGtldmluLnRpYW5AaW50ZWwuY29tPjsgTGl1LCBZaSBMDQo+IDx5aS5sLmxpdUBpbnRlbC5jb20+
OyBIYW8sIFh1ZG9uZyA8eHVkb25nLmhhb0BpbnRlbC5jb20+OyBEdWFuLCBaaGVuemhvbmcNCj4g
PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4gU3ViamVjdDogW1BBVENIIHYyIDAwLzE0XSBp
bnRlbF9pb21tdTogRW5hYmxlIFBBU0lEIHN1cHBvcnQgZm9yIHBhc3N0aHJvdWdoDQo+IGRldmlj
ZQ0KPiANCj4gSGksDQo+IA0KPiBOb3cgd2UgYWxyZWFkeSBzdXBwb3J0IGZpcnN0IHN0YWdlIHRy
YW5zbGF0aW9uIHdpdGggcGFzc3Rocm91Z2ggZGV2aWNlIGJhY2tlZA0KPiBieSBuZXN0ZWQgdHJh
bnNsYXRpb24gaW4gaG9zdCwgYnV0IG9ubHkgZm9yIFBBU0lEXzAuDQo+IA0KPiBTdHJ1Y3R1cmUg
VlREQWRkcmVzc1NwYWNlIGluY2x1ZGVzIHNvbWUgZWxlbWVudHMgc3VpdGFibGUgZm9yIGVtdWxh
dGVkDQo+IGRldmljZSBhbmQgcGFzc3Rocm91Z2ggZGV2aWNlIHdpdGhvdXQgUEFTSUQsIGUuZy4s
IGFkZHJlc3Mgc3BhY2UsIGRpZmZlcmVudA0KPiBtZW1vcnkgcmVnaW9ucywgZXRjLCBpdCBpcyBh
bHNvIHByb3RlY3RlZCBieSB2dGQgaW9tbXUgbG9jaywgYWxsIHRoZXNlIGFyZSB1c2VsZXNzDQo+
IGFuZCBiZWNvbWUgYSBidXJkZW4gZm9yIHBhc3N0aHJvdWdoIGRldmljZSB3aXRoIFBBU0lELg0K
PiANCj4gV2hlbiB0aGVyZSBhcmUgbG90cyBvZiBQQVNJRHMgdXNlZCBpbiBvbmUgZGV2aWNlLCB0
aGUgQVMgYW5kIE1ScyBhcmUgYWxsDQo+IHJlZ2lzdGVyZWQgdG8gbWVtb3J5IGNvcmUgYW5kIGlt
cGFjdCB0aGUgd2hvbGUgc3lzdGVtIHBlcmZvcm1hbmNlLg0KPiANCj4gU28gaW5zdGVhZCBvZiB1
c2luZyBWVERBZGRyZXNzU3BhY2UgdG8gY2FjaGUgcGFzaWQgZW50cnkgZm9yIGVhY2ggcGFzaWQg
b2YgYQ0KPiBwYXNzdGhyb3VnaCBkZXZpY2UsIHdlIGRlZmluZSBhIGxpZ2h0IHdlaWdodCBzdHJ1
Y3R1cmUNCj4gVlREQWNjZWxQQVNJRENhY2hlRW50cnkgd2l0aCBvbmx5IG5lY2Vzc2FyeSBlbGVt
ZW50cyBmb3IgZWFjaCBwYXNpZC4gV2Ugd2lsbA0KPiB1c2UgdGhpcyBzdHJ1Y3QgYXMgYSBwYXJh
bWV0ZXIgdG8gY29uZHVjdCBiaW5kaW5nL3VuYmluZGluZyB0byBuZXN0ZWQgaHdwdCwgdG8NCj4g
cmVjb3JkIHRoZSBjdXJyZW50IGJpbmRlZCBuZXN0ZWQgaHdwdCBhbmQgZXZlbiBmdXR1cmUgUFJR
IHN1cHBvcnQuIEl0J3MgYWxzbw0KPiBkZXNpZ25lZCB0byBzdXBwb3J0IFBBU0lEXzAuDQo+IA0K
PiBUaGUgcG90ZW50aWFsIGZ1bGwgZGVmaW5pdGlvbiBvZiBWVERBY2NlbFBBU0lEQ2FjaGVFbnRy
eSBtYXkgbGlrZToNCj4gDQo+ICAgdHlwZWRlZiBzdHJ1Y3QgVlREQWNjZWxQQVNJRENhY2hlRW50
cnkgew0KPiAgICAgICBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kOw0KPiAgICAgICBWVERQ
QVNJREVudHJ5IHBhc2lkX2VudHJ5Ow0KPiAgICAgICB1aW50MzJfdCBwYXNpZDsNCj4gICAgICAg
dWludDMyX3QgZnNfaHdwdF9pZDsNCj4gICAgICAgdWludDMyX3QgZmF1bHRfaWQ7DQo+ICAgICAg
IGludCBmYXVsdF9mZDsNCj4gICAgICAgUUxJU1RfSEVBRCgsIFZURFBSUUVudHJ5KSB2dGRfcHJx
X2xpc3Q7DQo+ICAgICAgIElPTU1VUFJJTm90aWZpZXIgcHJpX25vdGlmaWVyX2VudHJ5Ow0KPiAg
ICAgICBJT01NVVBSSU5vdGlmaWVyICpwcmlfbm90aWZpZXI7DQo+ICAgICAgIFFMSVNUX0VOVFJZ
KFZUREFjY2VsUEFTSURDYWNoZUVudHJ5KSBuZXh0Ow0KPiAgIH0gVlREQWNjZWxQQVNJRENhY2hl
RW50cnk7DQo+IA0KPiBHSVQgYnJhbmNoOg0KPiBodHRwczovL2dpdGh1Yi5jb20veWlsaXUxNzY1
L3FlbXUvdHJlZS96aGVuemhvbmcvaW9tbXVmZF9wYXNpZA0KPiANCj4gUEFUQ0gwMS0wNjogU29t
ZSBwcmVwYXJpbmcgd29yaw0KPiBQQVRDSDA3LTEwOiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRp
b24gYW5kIHJlbW92YWwNCj4gUEFUQ0gxMS0xMjogU3VwcG9ydCBwYXNpZCBiaW5kaW5nIGFuZCB1
bmJpbmRpbmcNCj4gUEFUQ0gxMy0xNDogQWRkIFBBU0lEIHJlbGF0ZWQgY2hlY2sgYW5kIGVuYWJs
ZSBQQVNJRCBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlDQo+IA0KPiBUaGlzIHBhdGNoc2V0IGRlcGVu
ZHMgb24gYSBrZXJuZWwgZmVhdHVyZSBlbmhhbmNlbWVudFsxXSB0byB3b3JrLg0KPiANCj4gVGVz
dHM6DQo+IFRlc3RlZCB3aXRoIERTQSBkZXZpY2Ugd2hpY2ggZHJpdmVyIHVzZXMgMiBQQVNJRHMg
YnkgZGVmYXVsdC4NCj4gDQo+IFRoYW5rcw0KPiBaaGVuemhvbmcNCj4gDQo+IFsxXSBodHRwczov
L2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNjAyMDUwMjM0MDUuNDE1ODMtMS0NCj4gemhlbnpob25n
LmR1YW5AaW50ZWwuY29tLw0KPiANCj4gQ2hhbmdlbG9nOg0KPiB2MjoNCj4gLSBtb3ZlIHRoZSBj
aGVjayAicy0+cGFzaWQgPiBQQ0lfRVhUX0NBUF9QQVNJRF9NQVhfV0lEVEgiIHRvIHBhdGNoNQ0K
PiAoQ2xlbWVudCkNCj4gLSBtb3ZlICNpbmNsdWRlICJody9jb3JlL2lvbW11LmgiIGJlZm9yZSAj
aW5jbHVkZSAiaHcvY29yZS9xZGV2LmgiIChsaXV5aSkNCj4gLSBwb2xpc2ggdGhlIGNvbW1lbnQg
YWJvdXQgQFBhc2lkIHBhcmFtZXRlciAoTGl1eWkpDQo+IC0gcy9wZS9wYXNpZF9lbnRyeSwgcy9h
c19pdC9oaW9kX2l0LCBzL3Z0ZF9maW5kX2FkZF9wYy92dGRfYWNjZWxfZmlsbF9wYyAoTGl1eWkp
DQo+IC0gcy9WVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeS9WVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSAo
TGl1eWkpDQo+IC0gYWRkIGV4cGxhbmF0aW9uIGluIGNvZGUgYWJvdXQgUEFTSUQgcmVtb3ZhbCBi
ZWZvcmUgYWRkaXRpb24gKExpdXlpKQ0KPiAtIHBvbGlzaCB0aGUgY29tbWVudCBhYm91dCBzY29w
ZSBvZiBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSB2cw0KPiBWVERQQVNJRENhY2hlRW50cnkgKExp
dXlpKQ0KPiAtIGFkZCBhbiBvcHRpbWl6YXRpb24gdG8gYnlwYXNzIFBBU0lEIGVudHJ5IGFkZGl0
aW9uIGZvciBQQVNJRCBzZWxlY3RpdmUNCj4gcHZfaW52X2RzYyAoTGl1eWkpDQo+IA0KPiB2MToN
Cj4gLSB1c2UgbmFtaW5nIHBhdHRlcm4gIlhYWF9TRVRfVEhFTkFNRSIgc2FtZSBhcyBzbW11IChD
bGVtZW50KQ0KPiAtIGZpeCBzLT5wYXNpZCBjaGVjayAoQ2xlbWVudCkNCj4gDQo+IFJGQ3YyOg0K
PiAtIGV4dGVuZCBhdHRhY2gvZGV0YWNoX2h3cHQoKSBpbnN0ZWFkIG9mIGludHJvZHVjaW5nIG5l
dyBjYWxsYmFja3MgKFNoYW1tZXIpDQo+IC0gRGVmaW5lIElPTU1VX05PX1BBU0lEIGZvciBkZXZp
Y2UgYXR0YWNobWVudCB3aXRob3V0IHBhc2lkIChOaWNvbGluKQ0KPiAtIHVwZGF0ZSB2dGRfZGVz
dHJveV9vbGRfZnNfaHdwdCgpJ3MgcGFyYW1ldGVyIGZvciBuYW1pbmcgY29uc2lzdGVuY3kNCj4g
KENsZW1lbnQpDQo+IC0gY2hlY2sgcGFzaWQgYml0cyBzaXplIHRvIGJlIG5vIG1vcmUgdGhhbiAy
MCBiaXRzIChDbGVtZW50KQ0KPiAtIGluaXRpYWxpemUgbG9jYWwgdmFyaWFibGUgbWF4X3Bhc2lk
X2xvZzIgdG8gMCAoQ8OpZHJpYykNCj4gDQo+IA0KPiBaaGVuemhvbmcgRHVhbiAoMTQpOg0KPiAg
IHZmaW8vaW9tbXVmZDogRXh0ZW5kIGF0dGFjaC9kZXRhY2hfaHdwdCBjYWxsYmFjayBpbXBsZW1l
bnRhdGlvbnMgd2l0aA0KPiAgICAgcGFzaWQNCj4gICBpb21tdWZkOiBFeHRlbmQgYXR0YWNoL2Rl
dGFjaF9od3B0IGNhbGxiYWNrcyB0byBzdXBwb3J0IHBhc2lkDQo+ICAgdmZpby9pb21tdWZkOiBD
cmVhdGUgbmVzdGluZyBwYXJlbnQgaHdwdCB3aXRoIElPTU1VX0hXUFRfQUxMT0NfUEFTSUQNCj4g
ICAgIGZsYWcNCj4gICBpbnRlbF9pb21tdTogQ3JlYXRlIHRoZSBuZXN0ZWQgaHdwdCB3aXRoIElP
TU1VX0hXUFRfQUxMT0NfUEFTSUQgZmxhZw0KPiAgIGludGVsX2lvbW11OiBDaGFuZ2UgcGFzaWQg
cHJvcGVydHkgZnJvbSBib29sIHRvIHVpbnQ4DQo+ICAgaW50ZWxfaW9tbXU6IEV4cG9ydCBzb21l
IGZ1bmN0aW9ucw0KPiAgIGludGVsX2lvbW11X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgYWRk
aXRpb24gZm9yIHBjX2ludl9kc2MgcmVxdWVzdA0KPiAgIGludGVsX2lvbW11X2FjY2VsOiBIYW5k
bGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3IgcGNfaW52X2RzYyByZXF1ZXN0DQo+ICAgaW50ZWxf
aW9tbXVfYWNjZWw6IEJ5cGFzcyBQQVNJRCBlbnRyeSBhZGRpdGlvbiBmb3IganVzdCBkZWxldGVk
IGVudHJ5DQo+ICAgaW50ZWxfaW9tbXVfYWNjZWw6IEhhbmRsZSBQQVNJRCBlbnRyeSByZW1vdmFs
IGZvciBzeXN0ZW0gcmVzZXQNCj4gICBpbnRlbF9pb21tdV9hY2NlbDogU3VwcG9ydCBwYXNpZCBi
aW5kaW5nL3VuYmluZGluZyBhbmQgUElPVExCIGZsdXNoaW5nDQo+ICAgaW50ZWxfaW9tbXVfYWNj
ZWw6IGRyb3AgX2xvY2sgc3VmZml4IGluDQo+ICAgICB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxs
X2xvY2tlZCgpDQo+ICAgaW50ZWxfaW9tbXVfYWNjZWw6IEFkZCBwYXNpZCBiaXRzIHNpemUgY2hl
Y2sNCj4gICBpbnRlbF9pb21tdTogRXhwb3NlIGZsYWcgVklPTU1VX0ZMQUdfUEFTSURfU1VQUE9S
VEVEIHdoZW4NCj4gY29uZmlndXJlZA0KPiANCj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwu
aCAgICB8ICAzNCArKy0NCj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA0MyAr
KystDQo+ICBpbmNsdWRlL2h3L2NvcmUvaW9tbXUuaCAgICAgICAgfCAgIDIgKw0KPiAgaW5jbHVk
ZS9ody9pMzg2L2ludGVsX2lvbW11LmggIHwgICA0ICstDQo+ICBpbmNsdWRlL2h3L3ZmaW8vdmZp
by1kZXZpY2UuaCAgfCAgIDEgKw0KPiAgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oICAgICAgIHwg
IDE2ICstDQo+ICBiYWNrZW5kcy9pb21tdWZkLmMgICAgICAgICAgICAgfCAgIDkgKy0NCj4gIGh3
L2FybS9zbW11djMtYWNjZWwuYyAgICAgICAgICB8ICAxMiArLQ0KPiAgaHcvaTM4Ni9pbnRlbF9p
b21tdS5jICAgICAgICAgIHwgIDgzICsrKy0tLS0NCj4gIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuYyAgICB8IDQyMCArKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4gIGh3L3Zm
aW8vZGV2aWNlLmMgICAgICAgICAgICAgICB8ICAxMSArDQo+ICBody92ZmlvL2lvbW11ZmQuYyAg
ICAgICAgICAgICAgfCAgNTYgKysrLS0NCj4gIGh3L3ZmaW8vdHJhY2UtZXZlbnRzICAgICAgICAg
ICB8ICAgNCArLQ0KPiAgMTMgZmlsZXMgY2hhbmdlZCwgNTI0IGluc2VydGlvbnMoKyksIDE3MSBk
ZWxldGlvbnMoLSkNCj4gDQo+IC0tDQo+IDIuNDcuMw0KDQpUZXN0ZWQtYnk6IFh1ZG9uZyBIYW8g
PHh1ZG9uZy5oYW9AaW50ZWwuY29tPg0KDQpEU0EgUEYgYXNzaWdubWVudCB0byBWTSB3aXRoIHZJ
T01NVSBzY2FsYWJsZSBtb2RlLCBkbWF0ZXN0IHBhc3NlZCBpbiBWTS4NCg==

