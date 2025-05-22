Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20902C54ED0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 06:51:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHzlZ-0007eU-GX; Thu, 22 May 2025 02:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHzlW-0007eH-Kw
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:50:54 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uHzlT-0002Wm-VA
 for qemu-devel@nongnu.org; Thu, 22 May 2025 02:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1747896652; x=1779432652;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GM2+L1I7+5sCDtTV1789JyE/iue7n2l94ZFd/govmSw=;
 b=QwZSoNWELEAst5shu7NDSz8fsQLRRJR/IVAVwSGqHCGB1M+AiiVx1tSg
 9QC8f63S4noCHccH2rqG7EdaVo/4UyT+1cClc6H183t/BiNVkau6aVrTJ
 qS9kLG1hAy/Yc2NDJfv68nWhDNKdNkgxmNf/lvhsus1eb36dNCydr0lma
 uP9HQPdvi/wt/FkRwSnIRWIMwe1r+daMXTF2L8tt+Z/cMIkhE4StgCYW1
 1huzXIyowOb+pUum7YhcL+eXb1OB5edtLytiKwDYljOJNdSI7dvZejfF5
 DE/ysEMgdv/YwWB+X0z1NzHGZruxn9UUjyAO6hGDK8MJciL3lKjdPqrTP w==;
X-CSE-ConnectionGUID: Mx+TSmGsS5i/h6WUiQE/Hw==
X-CSE-MsgGUID: XNXbp+eCRPSZVtzZQOfW2g==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60953158"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="60953158"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 23:50:46 -0700
X-CSE-ConnectionGUID: //uLx8MbRRG60OfxfZ6uUQ==
X-CSE-MsgGUID: CDCdo6wzQJ2sIL4oyMwFwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; d="scan'208";a="140973072"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2025 23:50:46 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 23:50:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 23:50:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.48) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 23:50:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ccgilb37FYfp6PEvhDSpQmED21ShUBQ1kwuPP5Tuoik3YPrmpBODseAM1+RRcH/ErvHeXXfEfAPW7Mw8knrNmB58emMvRmHzeET9dPCtX6oP7On3pvwoJQdhjMq6aCqTR7OjpRY/2ZVtCPVKiXAsW48RqG+hEFnIekMuItFToozNS3uKfLgPTb4taVZ9mK2M/GpGBpBoUqqGRWU/qcDPEbjjyDpqLSHjq3qIQTK3fAmP/p0vppnlm34RKInPpoQ04OmGr3If61jVI4z6LWLfsU/Yq8bF9V0ScV0Vo5NwBty9+aVsg8BI2Py5yQ2sPqXe2NeUhHv+GYxdZ2hWx4XuHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQ55pe6xbRxzkQy77cXX63G3gE0zp4KKxQEZc8FCMfo=;
 b=A7KKxUbjQ2YlfugcM8KX/ayUmEpeBOvqrxdGY6/tgMnrPU4FXxfnjt8DYaYLqxdhKhQ4HbHOoES+B2w0fR8bDn2dIloMyZjsjyONxJkbslMr1dQXpXWr3rAXnqfzoxln+RqahvvMUPLoFexaaCNdbKb9LWfSc2AoLR+qSm/Ap8rPGbeLaZtYfeqQBYR2PT2Dd1XDYh7PvPKN7/aI8cUeO5ZJ3RlE/wgJ9XM1W1nDMAwaRHKkGIiNOtOx18aPYkAYdrZALSWPdRv5eSGxZpvJGqtzg7R+F356PL9sof3dYlwz4+Y3n8Oxo0naJSRClslX4Fb0me3WyOTJAfP59pkctg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB6002.namprd11.prod.outlook.com (2603:10b6:208:386::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Thu, 22 May
 2025 06:50:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%4]) with mapi id 15.20.8746.030; Thu, 22 May 2025
 06:50:42 +0000
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
 "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, "Yi
 Sun" <yi.y.sun@linux.intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>
Subject: RE: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Topic: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
Thread-Index: AQHbykJMfKt9Mfha3Ee+klVeu6JiiLPdsMoAgAB6U9A=
Date: Thu, 22 May 2025 06:50:42 +0000
Message-ID: <SJ0PR11MB67446AF2F48F35D64E98B3D69299A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
In-Reply-To: <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB6002:EE_
x-ms-office365-filtering-correlation-id: f01434a2-2ebe-4c79-742e-08dd98fcf842
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nYANi8C+7/7/FsNGs1kepHIeiJLUwb20azfJtgVuyt6EeYcakhan1HRBL0AC?=
 =?us-ascii?Q?AYUWi95Dad2bR8k45LGIk6Si9JHDrRPrmIE9NOztmYL1nnmNWw638pBd51Bp?=
 =?us-ascii?Q?vKwEwkJBp0jzBKVdCqfBFYzUX2m21LY/OtJIB8i/+mPctbVt9OcG8HKEfQvX?=
 =?us-ascii?Q?+47ntP68bsafmqZYdEHgWJJfKdkgeDYiJC7mCdHNj0bCtnEmQuzJQVulR2wI?=
 =?us-ascii?Q?d4nUJiZO+1rgD+WQso4xUUY4Zo1pj8Gm2+2B069YJBZ37krLCwTTNxkTEMKK?=
 =?us-ascii?Q?Bq3RUdxRXmp2Y6n7sxgisDisekf4NlCyTDGfHa/GF9XGRH0sacxfa+L6OCFN?=
 =?us-ascii?Q?NVwz8PPWrTMHY62yHDxAWv0sj2535cUg97AlnxYUiCebETGnj0K9kaF+2YHz?=
 =?us-ascii?Q?sqTXqSHF+2n7UxTYL6EKTPPbI5P1CjOFpr9tFZWkGdFF8psUAnkCaWeFn4+f?=
 =?us-ascii?Q?MdzN0NHRdJ8yxuqZyUuiDvDsfyHv27BtpabezKsS5UsEp9zvS7BxGcHvpTR9?=
 =?us-ascii?Q?dMtiY7KjxTUrGsxf7zlF7ChdzjxyQYdjl0R845I9SrCDbOm8ocuSZmBByyI3?=
 =?us-ascii?Q?AMtuujQDAxl6xkMiKBsH80WIJdNTvxlbpI76qFgGVqq0U1eE9NvLEKo4V9At?=
 =?us-ascii?Q?O9baVSu+OZHEr9winhR1i25MCaTghvtgxF948lc2BZ0qlLZbB+usbJYBks5D?=
 =?us-ascii?Q?gP+LO+0l7DOHf7HEvItMNg+SRx4ynwvo6uRNMUt9pnjodvfTymi7ujLM6XZt?=
 =?us-ascii?Q?BJ4urR75GnfgnS8hBMGVMn0orLZgEUd5iRTYYhO8L4arKf2ywyaTS+7bJWUu?=
 =?us-ascii?Q?dHGTkwmkNGGAV+hfaL6zAwrws0qd+dxNWYnpPOG6AsNjBR8WU/sd42YgNpi1?=
 =?us-ascii?Q?6axy5X2gKmu3D20Azb2ag+zUaasm2vhbJdd7EkBOv7LsJz+uFP9eFkEiezGr?=
 =?us-ascii?Q?f90d8smPw3BwEkSbiukYhyqI/4ADic3FfK0KFTrFSMC9ebn9JiFmgCeS6AQa?=
 =?us-ascii?Q?nhs/5UElF5Ht1zvYU6bFU17nheCAsii5nTgf/iqujah8PFFot2Jgo/teqp7+?=
 =?us-ascii?Q?TBQuieA623OdTA4KeFeJfY3RssjGkJln02bvc2V/8TIEanjC36hX7jX5XkM3?=
 =?us-ascii?Q?e4s4BaFWot0QM84yCdD696dZeZs/L+7JzuFf7OcDkvIylSj9HicGxbIjuDK1?=
 =?us-ascii?Q?dw+1zT1Z+Au6MVIRXa1VRhwFJ3OmG7VyMu44laB+jfYxOTFmRxPZplNS5wNc?=
 =?us-ascii?Q?OERw/dqkeMRhxxjcZ1lVCHUW9rmLJtWk62Llrsdc89xsMQ/2SFlH0Cw9xLTb?=
 =?us-ascii?Q?LCQLXcyAfVcDHYQdaGux4lAJ7IUn1LNIZifFHTzboE28igeOdX0d8M4kvWZ9?=
 =?us-ascii?Q?HgMsl/kovCbVxR7jHGDpsZ8kGhVlY4cuiQrCTX+YcdoIJsmXjR8XS/Huo8mG?=
 =?us-ascii?Q?kVYRJO65mG8r5H9ek/37XXC9jkIKoJwljSf7QsQjQnhNGTPeh1l1f5PbD5En?=
 =?us-ascii?Q?TNRZNYN4rTfp9kM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FxHnzidP0Mlu/MvCwoGos8rom4aWsBEexDHOUfp56cXiK5N5++5JX9d/NA9S?=
 =?us-ascii?Q?6a81tokPWGpQV/XsusMCOJS0UfSjW/nAeXJoOU1ikUTsmvCpjiD6QE0lpM5k?=
 =?us-ascii?Q?O58TZI4la7bKUK17C5kzNuCxPeOH37YMJKH3haJX82S2E4mJzDLXROXutTES?=
 =?us-ascii?Q?ovteozBvVMZ5p30aTJA+EreDXAotRZFIc34Ee5I1hjYRbYCETcB9A395R9Kj?=
 =?us-ascii?Q?yUJ6DZBSMcC5fpS/BgDDllXfLHm9y+iLWhIsIn3rnDJaqlVIAUE1GN5SPaS1?=
 =?us-ascii?Q?QqPOD6tKWdNEVedlotLtJDsNauKp+sh9XNu7RcVlaMH1IEgiVI/oBz+haVxc?=
 =?us-ascii?Q?3QFq5SFjIqkk0aMMWCApe+IJhJ7dCjOoKk0PYS/gaUiDJ3gNyk2dpz5m+SpV?=
 =?us-ascii?Q?pIBRo4UUox4qgnJ72s588CU2GUcOGcIhQqbwAqimofpvwoY8tYIIm5042WRB?=
 =?us-ascii?Q?Hnrr/8rfN6KbDyGotlbOXyaDWpWUVNVg+tbssStlKSZeL0GKtZyfC+G0Ev4n?=
 =?us-ascii?Q?9v/cSMqwyMD9K0hUIpu2kpKyoQOIbbqexi0UAvQ4u3JCiBFJbSMU3pQwyhPm?=
 =?us-ascii?Q?ouFGC1nWdjGEwDFtI6U00rTz6q+Tk/jVj5Gi0jHprF+g/x1hIXJRorblXf9k?=
 =?us-ascii?Q?WJ6dFoaipiz2iBTTrvCkA94ayGnf41YCOq7un6pRwd4VI4zuJbZLtcwZn+GL?=
 =?us-ascii?Q?zqYR3y4o+Q2HlMyPdVPvDKq47z4fU1nfzrfxqmfsMrDjYBEq47oe/qUfFFX8?=
 =?us-ascii?Q?3wXPsjaoJJyFUowPVWuLKqHxiQfekBw8Wsf3KJGABySmj7YnLtkRCDU9gEjJ?=
 =?us-ascii?Q?2qKhNfSLgStRsUucdEwW8oJvkR/7Fadztqa0fwNrS0pVn/BdfXGh21e+8WV+?=
 =?us-ascii?Q?z+9ySj5bAp06ktA7w/0LeaGac2C4SGlj87x/NyUuKwziV6P2ma5CDJe0RtFK?=
 =?us-ascii?Q?F57ycroGI2jALtHNg5YqbFOUEEaQnN2R2xmnZc0PJW5meOPL6RiHE4AkqIuI?=
 =?us-ascii?Q?VmwvksWnv4mD9xQIpA1cNCCPi+/Az8hZaEgoLRDz6ZfQwf2Rvkb1hTYOxheA?=
 =?us-ascii?Q?YI9YoNPqqRRgsHmfEBiCoNtUIsNU+zskRlZi6+miU1F01KMYqRvVXyC+00cA?=
 =?us-ascii?Q?UGdtllIDeV2yctvYO55UC4e/dr1apVFTrDtI9g1xWCUiLvkgWBl2DulbApjD?=
 =?us-ascii?Q?hRXop9pCjSpEhM+ALI4Dz6oVwD1eYuR+dLbEz/v3woLx6IU/rNJ1MpgiUj/p?=
 =?us-ascii?Q?VD8MBKW9IkOLkM4oImGhaDoH27jv34b3+jDDSDS2WGxi8ab06BJPZTzOx9fi?=
 =?us-ascii?Q?VawST+34tlr2m8INoCXLX9TkRWbmDXzLSNLzSJ1ys9HE8yjZOcQITBY3q3BJ?=
 =?us-ascii?Q?xNPR+X5FWrdwkF3NMqPmMTXIaWRU3GmimYkBhePxCQTaWeJ415QCFRYd+Yet?=
 =?us-ascii?Q?6H1hcaQfw9rdybSDdHP4dr6KVnxQTSwP1jifJWKGolfqbDV354l9Q8X/MTTW?=
 =?us-ascii?Q?Mn6/uNskkYs4VHAWI6Z2MwbVzjkQVaBaWSCUV4HXKJA/t46oDeGii3b9MwLj?=
 =?us-ascii?Q?8IiaxpF2371r9pEuwozvOlkMln11WTm00TT+BEDT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f01434a2-2ebe-4c79-742e-08dd98fcf842
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2025 06:50:42.0559 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bFvp6cDq2vjjcyscAI6ciwOroy19cWeKimTG77EhygYSmAC7oNRyxEfDDUFkRIYBEfiGv6OqyHlVqyHNfYIDhqcTEGbPVmKS6jyohvNsY9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6002
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
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
>Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table=
 to
>host
>
>On Wed, May 21, 2025 at 07:14:45PM +0800, Zhenzhong Duan wrote:
>> +static const MemoryListener iommufd_s2domain_memory_listener =3D {
>> +    .name =3D "iommufd_s2domain",
>> +    .priority =3D 1000,
>> +    .region_add =3D iommufd_listener_region_add_s2domain,
>> +    .region_del =3D iommufd_listener_region_del_s2domain,
>> +};
>
>Would you mind elaborating When and how vtd does all S2 mappings?

When guest trigger pasid cache invalidation, vIOMMU will attach device
to stage2 page table if guest's PGTT=3DPT or nested page table if PGTT=3DSt=
age1.
All these page tables are dynamically created during attach. We don't use
VFIO's shadow page table. The S2 mappings are also created during attach.
See:

vtd_device_attach_iommufd()
{
...
    vtd_device_attach_container();
    container->listener =3D iommufd_s2domain_memory_listener;
    memory_listener_register(&container->listener, &address_space_memory);
...
}

>
>On ARM, the default vfio_memory_listener could capture the entire
>guest RAM and add to the address space. So what we do is basically
>reusing the vfio_memory_listener:
>https://lore.kernel.org/qemu-devel/20250311141045.66620-13-
>shameerali.kolothum.thodi@huawei.com/
>
>The thing is that when a VFIO device is attached to the container
>upon a nesting configuration, the ->get_address_space op should
>return the system address space as S1 nested HWPT isn't allocated
>yet. Then all the iommu as routines in vfio_listener_region_add()
>would be skipped, ending up with mapping the guest RAM in S2 HWPT
>correctly. Not until the S1 nested HWPT is allocated by the guest
>OS (after guest boots), can the ->get_address_space op return the
>iommu address space.

When S1 hwpt is allocated by guest, who will notify VFIO to call
->get_address_space op() again to get iommu address space?

>
>With this address space shift, S2 mappings can be simply captured
>and done by vfio_memory_listener. Then, such an s2domain listener
>would be largely redundant.

I didn't get how arm smmu supports switching address space, will VFIO call
->get_address_space() twice, once to get system address space and the other
for iommu address space?

>
>So the second question is:
>Does vtd have to own this iommufd_s2domain_memory_listener? IOW,
>does vtd_host_dma_iommu() have to return the iommu address space
>all the time?

Vtd only support to return a fixed address space, under the address space
there can be either system memory region or iommu memory region enabled.

>
>> +static int vtd_create_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>> +                              VTDS2Hwpt *s2_hwpt, VTDHwpt *hwpt,
>> +                              VTDPASIDEntry *pe, Error **errp)
>> +{
>> +    struct iommu_hwpt_vtd_s1 vtd;
>> +    uint32_t hwpt_id, s2_hwpt_id =3D s2_hwpt->hwpt_id;
>> +
>> +    vtd_init_s1_hwpt_data(&vtd, pe);
>> +
>> +    if (!iommufd_backend_alloc_hwpt(idev->iommufd, idev->devid,
>> +                                    s2_hwpt_id, 0, IOMMU_HWPT_DATA_VTD_=
S1,
>> +                                    sizeof(vtd), &vtd, &hwpt_id, errp))=
 {
>> +        return -EINVAL;
>> +    }
>> +
>> +    hwpt->hwpt_id =3D hwpt_id;
>> +
>> +    return 0;
>> +}
>> +
>> +static void vtd_destroy_s1_hwpt(HostIOMMUDeviceIOMMUFD *idev,
>VTDHwpt *hwpt)
>> +{
>> +    iommufd_backend_free_id(idev->iommufd, hwpt->hwpt_id);
>> +}
>
>I think you did some substantial work to isolate the get_hw_info
>part inside the iommufd backend code, which looks nice and clean
>as the vIOMMU code simply does iodc->get_cap().
>
>However, that then makes these direct raw backend function calls
>very awkward :-/
>
>In my view, the way to make sense is either:
>* We don't do any isolation, but just call raw backend functions
>  in vIOMMU code
>* We do every isolation, and never call raw backend functions in
>  vIOMMU code

Iommufd backend functions are general for all modules usage including
vIOMMU. I think we are not blocking vIOMMU calling raw backend functions.
We just provide a general interface for querying capabilities, not all capa=
bilities
are from iommufd get_hw_info result, e.g., aw_bits.

Zhenzhong



