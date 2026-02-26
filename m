Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E280FFD460E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 03:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvS9q-0008N7-JC; Wed, 25 Feb 2026 22:35:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvS9o-0008M1-SR
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:35:20 -0500
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvS9l-0000a8-Dz
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 22:35:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772076917; x=1803612917;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=/qndfBuRv3nCJOhDX36E3yR6zKEk/BhGBmwSHzUHp8Q=;
 b=VtzTgJSGVBP4WIwhhMkuht89pgfp+USeXi7tiPDcfRnv5bUJZTxfhcww
 S3EyKSC3KzVOJfdcA/grappPDinNRYApz+RtGvq2r696OgWLZVqBmdz/C
 5eSLQFKZ4JJQ+alSsXHitK9VO+m5sj4TUFxYiNDnEaSTn5RRPktGR6uMA
 g3qPJbS674/FWyYazLYQSUhz5NB1fRKqHmvE1edUYEvr7L6hVIBWIFpPx
 sVcA6nEqEy2ZkF/+Gi13RAXXYcq48jUegqldWj+BwV0kuBm4Qvk1vnl1d
 1DQw+2fKwIb3IuNyYXb+V8apO/XXNkwidFPybbh7pxKXaEBe4WLkeXFj5 g==;
X-CSE-ConnectionGUID: NPhCim3NTd+I6/kXuCUmyA==
X-CSE-MsgGUID: wseVCv38S1alVpf7RgCpIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73173053"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208,217";a="73173053"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:35:13 -0800
X-CSE-ConnectionGUID: ylI758e5TXi764jMsEcFfA==
X-CSE-MsgGUID: 6ZvPOKrbSwaUkTm6Tx4h9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
 d="scan'208,217";a="215539442"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 19:35:14 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 19:35:12 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 19:35:12 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 19:35:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=peE2RPTLtDRuf5PtBVV7jT1nbPPlVMQWJhbVNMIb+jsggAdpP7ob/1nutp0lKWkLB3dsi3b+m1vjoBunA3pGqUH8LAjFXNvUJ/Ml/2KJIZb4ZHSklhyo7LuswlEOlnfNW6IcOjcSFUoAEt2bIQYX5+Q5pIjEz0i857+dThjCDYP9acqt3v1CZZV68bPoY1Wzi8P5c+gYeJGpbhkJtuAXswrnGowwQrX/fs1hUGmYbuVhbhikHtdJgKs5QzxGnYcfGopIlSZOjEvKWv2UcZ+Z466mdZLX6nUrWxdRRqbmMvbWTqzlSn0sGTu7pZR8DcUqxArihXxbPEUVGIb0/j3ZTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDvI5NsMPDvA8vZp0LNzfGw9sznrIpJZq6M53SdHM9U=;
 b=yyYSYa0WiG7NwXHI08emAmtxvR2INQ7pNeLmjTSVR20YIDsvjn7YY1L0sI6IzYcWHwBYu8uZGCgXVjKivAdrATgcQUM6iBdFrQIZ9tdK8PaSrYeiFUSCr2LWD5diKP6x7oN7qfD+JHwBVOK4++dXlocu8T9+PjlIfcKkGwQ0D6YhNlXN+oDOfXjFafrNSm4JziaObapFfrvu7EiqruO/QSZnHnX+jN8NVa4dgySRuMj8XWggEQVqRVq4W6yY1znSqqB12UJAZ8hOab5w6CacdCzsbR4jScLnm60xFd0jv3d2tBJk+8mEHnwvzEVm99r7Rd2glFSsVp7C7/pGnN7bUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH7PR11MB6546.namprd11.prod.outlook.com (2603:10b6:510:212::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 03:35:07 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 03:35:07 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bool
 to uint8
Thread-Topic: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bool
 to uint8
Thread-Index: AQHcnWPqbS/Y9XzGekqX1LA/E6YJILWTCDiAgAFd5UA=
Date: Thu, 26 Feb 2026 03:35:06 +0000
Message-ID: <IA3PR11MB91368B668DF1EB773AB54D779272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-6-zhenzhong.duan@intel.com>
 <AM8PR07MB76022449D3A87724252E41FB8675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
In-Reply-To: <AM8PR07MB76022449D3A87724252E41FB8675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-25T06:39:09.792Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH7PR11MB6546:EE_
x-ms-office365-filtering-correlation-id: ca72cab3-a242-4c71-e278-08de74e80943
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|38070700021|8096899003; 
x-microsoft-antispam-message-info: Qoxtmfs3oRCte+kOxs1zSV0LX4i3EkulQlYWJT5QTTfuGmhn5Px3b5aPK7+WE2clv7ivPGCjJmVYeW261EKlVp9IMXfJWwgtoa2RoMFdXGfO4ueka/gYn8O2ljPc+/2Ny/qQ6iXrzZjNk/2oCKiH0qxgYkqj9ep53W2tszBhpE+uiEc76mz8tZ/WG4N9hddrGkPpmLVbOHC5J7mhRJ632p+ClCUo2AQVa7B+i1RYoSHEipfUFV86/24119zm4Uol8WOp0C38Weyj0bh6w7KxjXOqDCyw4b8s/D3FyPmaUOW+YMzK4aF+W0q+b0iCIQdYdoTgTplpkIIXQaDo13kv6rcMOuDnQaysJ+J/2jjmFeDgGiiv2d+c8eN2SUcjRlyc8VhRm2LdtkImGHny1nLMvMA0/YuT6pKSRyknd47wPDpN0tI3p4zswOtCfIUz3VFD8RirMFdbvj6idxM64aoJgkmcQum3stE6UwCOIn6jssz/PVgzoKJtsW2Y+ttcZYuqPFc6CkOmglKSXpTniPE20O3SN5XQolVJTw4z7iEY3PW0t5UXTPinmn1ZlUtdmzwTqOZ25Q84Llb1GSiZ7HGx8ymOTzhyKOynII4m3lmxVXWokl+SUikHUIvtJXjYmrA/HbcFGaDaJE0ZEu/UlTw5GG1G6qj/556+/HdVa3LGpO3nphu5+jSIi/WT5g9VwAroIjkNqn5ymhv0KBhoLxTICM+DmaxK6wgnN2zVxjVVqfMURNlEN6Bdt05nzbnOLx2/3josCmOrUfQdiMAJCLW7dUYDbGqgE37gtKsvarVmHRE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dF0UeoyM8H7NQe6EpS6yZ+6gLQXz9Bn1aCYygcn47kGaRPx/AlF4zo+P35pC?=
 =?us-ascii?Q?UJZXBmYoukHQXnihvQB5u59NXTcBZPHhhL31ZRf4fuFkkmG0xaYXdn0KDvQl?=
 =?us-ascii?Q?Xm3Qhg0FpNAOe0CQSVxr33jCyhlBAilQ/D+E8V5XO1Orez7pCnvnR+bAzkm9?=
 =?us-ascii?Q?JTSAlBY/urXhSZ3N8KGq4FuiUYoifK/gW42Np7mIS/NGIRNJ2qeWI5NJo4ye?=
 =?us-ascii?Q?vKglI7yNrQkhZXs868meCsLCA6TNrEgU7OlLvgaOxuAttSO6j4oZt3ObLgtQ?=
 =?us-ascii?Q?SJdsDq8MgRNtOkrMcKP6cmR/tBNMXNVNwaWaG2uCwGTOMLV+vVjIhUzoiY7K?=
 =?us-ascii?Q?I6zI/O+U0kdXdnxAvbItgB+sGQzxm5XQuUZvPNrEnF0KNTWTOGL8MOziGwEH?=
 =?us-ascii?Q?RCQrBcNfs7MLIc1boMECORbR9hkAvsf2HjKkSqfUMb7vmbg5KkGm/h0QHac6?=
 =?us-ascii?Q?KiAkxfQ8229M8jMLzNlVTTemqOM7BZO+3rVS/5Q+XDWUh9dotpw1XBJlJBpf?=
 =?us-ascii?Q?aDLLhb+J3y7KI7BEAcw1jEpIQLfRDzAYVGF/BOoW2GpAbw1i62IYRvh7M2+s?=
 =?us-ascii?Q?WKa1txfLLeOOXnlP3ftbdiTpDP5i2HkZVYh6/Ql1dgkueOCi3lipEjLBReN8?=
 =?us-ascii?Q?++Y4yvdtq9VDtv0qta5qDwmbwJi8X+SxPyQvZJOUA0kTpYM7azrjjo6LaQlO?=
 =?us-ascii?Q?QSFe4HrHOJPTn3hHj9V8A3jraJxXzDUeCdUH/addS4+9rvoSSKYEGv4viA3g?=
 =?us-ascii?Q?75xfXpY8alVNHsRwMbQefpNjsVT60bfabQOq+odqqHDEOlxu53m6zDyvLmno?=
 =?us-ascii?Q?ujGtjQO4YT4oykH3iyPdbarjT/fk7gU8mdWMFv3YACJ5b79tfKt7ORMmegV7?=
 =?us-ascii?Q?y78aBnKTrEIUsQgacLMtNZDSSPfE3JxEMutQNETwtngQHTFKea1hpYFQLOBF?=
 =?us-ascii?Q?iWiKs/JTtkHEYpM4l8G85nWtF+J0j6POupdj6rpL0IR7v+mvchDMd6QnsXa7?=
 =?us-ascii?Q?sjFyIyqTPiwPHe7vLjQ74j0B4qYohkuEfyYaml8l7sP1/usdcq0kyWzQpdDf?=
 =?us-ascii?Q?nuWX2hZaE4LbB8eOYZavI8XnFwWSJlcm0Seo333/2sCyZg5MnjRYWlZgpZzR?=
 =?us-ascii?Q?Zjos7CSjJfz3Zk0vjoAI8xdrVPyU5xpkohGLTGuJcTOEvent/4dIuvb/YBEr?=
 =?us-ascii?Q?Ct+0zgkBDIrRu1XHyduEePzA5gJYKAZNJYBcu4H1Ln9b1EoC6+fz34eHgcOI?=
 =?us-ascii?Q?UBwokf1p6o1jA3/3206w1+krZxnkv92rJFuS1mxB9YyTmtzAn1paHy5GlVd0?=
 =?us-ascii?Q?0BAvPZ6ELIBTNBePIQ2pkDQvulF5slhkehSDEGuEjs3KOM6MvisFa0pq5uIm?=
 =?us-ascii?Q?wIE1D6Hm2TVtjxnQW2yjYeCpjAX+ZnSibcVGZ5hKqWhXtM4Cl5Ear1d9x+Gk?=
 =?us-ascii?Q?0kRDxOadpTKjYX8bobTgEa20elMs52tNMuQVZS3b2mRhbxCVxHm8yF7pQcag?=
 =?us-ascii?Q?vh+ADMXUiJhWh2cugEgJLAcW7b83xkiONh7L+rDlHBYbaxb1Bdq+jMCGF6Dh?=
 =?us-ascii?Q?vmir86OYnsE4iZelSifaHXm7hsz3AE6HXmkXQO0zYYvMSS2A2KTtCLv0i+Z/?=
 =?us-ascii?Q?AhQ+Fq9UAVeLCaywfkVXht+uzmrnRGrL+wr7kSBiplg1JHI2LTltn5PyQOiO?=
 =?us-ascii?Q?JNav9Mz3+Lc6geMmivW6dECQAxt8+Xu4+BTNwdujpPZ1RiScK5Wj0Lth9XJj?=
 =?us-ascii?Q?UYcxggiHag=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB91368B668DF1EB773AB54D779272AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca72cab3-a242-4c71-e278-08de74e80943
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 03:35:06.8656 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wya2QmYLaUDIKjoc4Ut8Zcm+BYDoGfp9QbFp1x2oBeUV30LlkoGaLlr89UlFZ2SMbV/uZvlrNzMGQpIeWK1eY2OlkuniFK0amORt4GcGU/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6546
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--_000_IA3PR11MB91368B668DF1EB773AB54D779272AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

I'm fine with either extract32/64 syntax or mask syntax. Just to confirm be=
low match what you prefer.

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e5518a94ea..e097839c3b 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,8 @@
#define VTD_ECAP_MHMV               (15ULL << 20)
#define VTD_ECAP_SRS                (1ULL << 31)
#define VTD_ECAP_NWFS               (1ULL << 33)
-#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
+#define VTD_ECAP_PSS                (0x1fULL << 35)
+#define VTD_ECAP_PSS_SHIFT          35
#define VTD_ECAP_PASID              (1ULL << 40)
#define VTD_ECAP_PDS                (1ULL << 42)
#define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94a691d423..48c2565a9e 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5027,7 +5027,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }

     if (s->pasid) {
-        s->ecap =3D VTD_ECAP_PASID | deposit64(s->ecap, 35, 5, s->pasid - =
1);
+        s->ecap =3D VTD_ECAP_PASID | (uint64_t)(s->pasid - 1) << VTD_ECAP_=
PSS_SHIFT;
     }
}

diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index e6e9251d21..cb668f3d00 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -47,7 +47,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
-    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
+    uint64_t hpasid =3D vtd->ecap_reg & VTD_ECAP_PSS;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -69,9 +69,10 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
     }

     /* Only do the check when host device support PASIDs */
-    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+    if (caps->max_pasid_log2 && s->pasid &&
+        ((uint64_t)(s->pasid - 1) << VTD_ECAP_PSS_SHIFT) > hpasid) {
         error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
-                   s->pasid, hpasid);
+                   s->pasid, (int)(hpasid >> VTD_ECAP_PSS_SHIFT));
         return false;
     }

Thanks
Zhenzhong

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Wednesday, February 25, 2026 2:40 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bo=
ol to uint8

Hi Zhenzhong,

Maybe VTD_ECAP_PSS could be modified to take the pasid width and return the=
 PSS field with the correct offset.

This comment echos what I said about [12/13]

cmd

________________________________
From: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.=
com>>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.=
org<mailto:qemu-devel@nongnu.org>>
Cc: alex@shazbot.org<mailto:alex@shazbot.org> <alex@shazbot.org<mailto:alex=
@shazbot.org>>; clg@redhat.com<mailto:clg@redhat.com> <clg@redhat.com<mailt=
o:clg@redhat.com>>; eric.auger@redhat.com<mailto:eric.auger@redhat.com> <er=
ic.auger@redhat.com<mailto:eric.auger@redhat.com>>; mst@redhat.com<mailto:m=
st@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat.com=
<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redhat.co=
m>>; jgg@nvidia.com<mailto:jgg@nvidia.com> <jgg@nvidia.com<mailto:jgg@nvidi=
a.com>>; nicolinc@nvidia.com<mailto:nicolinc@nvidia.com> <nicolinc@nvidia.c=
om<mailto:nicolinc@nvidia.com>>; skolothumtho@nvidia.com<mailto:skolothumth=
o@nvidia.com> <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>; jo=
ao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@o=
racle.com<mailto:joao.m.martins@oracle.com>>; CLEMENT MATHIEU--DRIF <clemen=
t.mathieu--drif@eviden.com<mailto:clement.mathieu--drif@eviden.com>>; kevin=
.tian@intel.com<mailto:kevin.tian@intel.com> <kevin.tian@intel.com<mailto:k=
evin.tian@intel.com>>; yi.l.liu@intel.com<mailto:yi.l.liu@intel.com> <yi.l.=
liu@intel.com<mailto:yi.l.liu@intel.com>>; xudong.hao@intel.com<mailto:xudo=
ng.hao@intel.com> <xudong.hao@intel.com<mailto:xudong.hao@intel.com>>; Zhen=
zhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.com>>
Subject: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property from bool t=
o uint8

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


'x-pasid-mode' is a bool property, we need an extra 'pss' property to
represent PASID size supported. Because there is no any device in QEMU
supporting pasid capability yet, no guest could use the pasid feature
until now, 'x-pasid-mode' takes no effect.

So instead of an extra 'pss' property we can use a single 'pasid'
property of uint8 type to represent if pasid is supported and the PASID
bits size. A value of N > 0 means pasid is supported and N - 1 is the
value in PSS field in ECAP register.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.du=
an@intel.com>>
---
 hw/i386/intel_iommu_internal.h | 1 -
 include/hw/i386/intel_iommu.h  | 2 +-
 hw/i386/intel_iommu.c          | 4 ++--
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index 11a53aa369..04a9392e8a 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,6 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
-#define VTD_ECAP_PSS                (7ULL << 35) /* limit: MemTxAttrs::pid=
 */
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
index 54c2b6b77a..bb957b93e0 100644
--- a/include/hw/i386/intel_iommu.h
+++ b/include/hw/i386/intel_iommu.h
@@ -315,7 +315,7 @@ struct IntelIOMMUState {
     OnOffAuto intr_eim;             /* Toggle for EIM cabability */
     uint8_t aw_bits;                /* Host/IOVA address width (in bits) *=
/
     bool dma_drain;                 /* Whether DMA r/w draining enabled */
-    bool pasid;                     /* Whether to support PASID */
+    uint8_t pasid;                  /* PASID supported in bits, 0 if not *=
/
     bool fs1gp;                     /* First Stage 1-GByte Page Support */

     /* Transient Mapping, Reserved(0) since VTD spec revision 3.2 */
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 92a367d657..e27a7c725f 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4186,7 +4186,7 @@ static const Property vtd_properties[] =3D {
     DEFINE_PROP_BOOL("x-scalable-mode", IntelIOMMUState, scalable_mode, FA=
LSE),
     DEFINE_PROP_BOOL("x-flts", IntelIOMMUState, fsts, FALSE),
     DEFINE_PROP_BOOL("snoop-control", IntelIOMMUState, snoop_control, fals=
e),
-    DEFINE_PROP_BOOL("x-pasid-mode", IntelIOMMUState, pasid, false),
+    DEFINE_PROP_UINT8("pasid", IntelIOMMUState, pasid, 0),
     DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, false),
     DEFINE_PROP_BOOL("dma-drain", IntelIOMMUState, dma_drain, true),
     DEFINE_PROP_BOOL("stale-tm", IntelIOMMUState, stale_tm, false),
@@ -5033,7 +5033,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }

     if (s->pasid) {
-        s->ecap |=3D VTD_ECAP_PASID | VTD_ECAP_PSS;
+        s->ecap =3D VTD_ECAP_PASID | deposit64(s->ecap, 35, 5, s->pasid - =
1);
     }
 }

--
2.47.3

--_000_IA3PR11MB91368B668DF1EB773AB54D779272AIA3PR11MB9136namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Aptos;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:12.0pt;
	font-family:"Aptos",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#467886;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Aptos",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	mso-ligatures:none;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"#467886" vlink=3D"#96607D" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Clement,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m fine with either extract32/64 syntax or ma=
sk syntax. Just to confirm below match what you prefer.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/i386/intel_iommu_internal.h b/hw/i38=
6/intel_iommu_internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">index e5518a94ea..e097839c3b 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/i386/intel_iommu_internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/i386/intel_iommu_internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -195,7 +195,8 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<o=
:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 3=
1)<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<o:=
p></o:p></p>
<p class=3D"MsoNormal">-#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#define VTD_ECAP_PSS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x1fULL &lt;&l=
t; 35)<o:p></o:p></p>
<p class=3D"MsoNormal">+#define VTD_ECAP_PSS_SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 35<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<o:p></o=
:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 4=
2)<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<o:=
p></o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_i=
ommu.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 94a691d423..48c2565a9e 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/i386/intel_iommu.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/i386/intel_iommu.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -5027,7 +5027,7 @@ static void vtd_cap_init(Intel=
IOMMUState *s)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;pasid) {<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ec=
ap =3D VTD_ECAP_PASID | deposit64(s-&gt;ecap, 35, 5, s-&gt;pasid - 1);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ec=
ap =3D VTD_ECAP_PASID | (uint64_t)(s-&gt;pasid - 1) &lt;&lt; VTD_ECAP_PSS_S=
HIFT;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/i=
ntel_iommu_accel.c<o:p></o:p></p>
<p class=3D"MsoNormal">index e6e9251d21..cb668f3d00 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/i386/intel_iommu_accel.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/i386/intel_iommu_accel.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -47,7 +47,7 @@ bool vtd_check_hiod_accel(IntelIOM=
MUState *s, VTDHostIOMMUDevice *vtd_hiod,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D v=
td_hiod-&gt;hiod;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps =
*caps =3D &amp;hiod-&gt;caps;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *v=
td =3D &amp;caps-&gt;vendor_caps.vtd;<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(=
vtd-&gt;ecap_reg) + 1;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; uint64_t hpasid =3D vtd-&gt;ecap=
_reg &amp; VTD_ECAP_PSS;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&g=
t;bus;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt=
;devices[vtd_hiod-&gt;devfn];<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@ -69,9 +69,10 @@ bool vtd_check_hiod_accel(IntelIO=
MMUState *s, VTDHostIOMMUDevice *vtd_hiod,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; /* Only do the check when h=
ost device support PASIDs */<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp=
;&amp; s-&gt;pasid &gt; hpasid) {<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp=
;&amp; s-&gt;pasid &amp;&amp;<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ((uint64=
_t)(s-&gt;pasid - 1) &lt;&lt; VTD_ECAP_PSS_SHIFT) &gt; hpasid) {<o:p></o:p>=
</p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; err=
or_setg(errp, &quot;PASID bits size %d &gt; host IOMMU PASID bits size %d&q=
uot;,<o:p></o:p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpas=
id);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, (int=
)(hpasid &gt;&gt; VTD_ECAP_PSS_SHIFT));<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret=
urn false;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks<o:p></o:p></p>
<p class=3D"MsoNormal">Zhenzhong<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt">
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif">From:</span></b><span style=3D"font-size:11.0pt;=
font-family:&quot;Calibri&quot;,sans-serif"> CLEMENT MATHIEU--DRIF &lt;clem=
ent.mathieu--drif@eviden.com&gt;
<br>
<b>Sent:</b> Wednesday, February 25, 2026 2:40 PM<br>
<b>To:</b> Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; qemu-devel@non=
gnu.org<br>
<b>Cc:</b> alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@red=
hat.com; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothu=
mtho@nvidia.com; joao.m.martins@oracle.com; Tian, Kevin &lt;kevin.tian@inte=
l.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt;;
 Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b> Re: [RFCv2 PATCH 05/13] intel_iommu: Change pasid property =
from bool to uint8<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Zhenzhong,<o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Maybe VTD_ECAP_PSS could=
 be modified to take the pasid width and return the PSS field with the corr=
ect offset.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">This comment echos what =
I said about [12/13]<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">cmd<o:p></o:p></span></p=
>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<div>
<p class=3D"MsoNormal"><b><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:black">From:</span></b><span style=3D"font-=
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;Z=
henzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.dua=
n@intel.com</a>&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.=
org</a> &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org<=
/a>&gt;<br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a> &l=
t;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a>&gt;;
<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a> &lt;<a href=3D"mailto:=
clg@redhat.com">clg@redhat.com</a>&gt;;
<a href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a> &lt;<a h=
ref=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a>&gt;;
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a> &lt;<a href=3D"mailto:=
mst@redhat.com">mst@redhat.com</a>&gt;;
<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a> &lt;<a href=
=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;;
<a href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a> &lt;<a href=3D"mailto:=
jgg@nvidia.com">jgg@nvidia.com</a>&gt;;
<a href=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</a> &lt;<a href=
=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</a>&gt;;
<a href=3D"mailto:skolothumtho@nvidia.com">skolothumtho@nvidia.com</a> &lt;=
<a href=3D"mailto:skolothumtho@nvidia.com">skolothumtho@nvidia.com</a>&gt;;
<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a> =
&lt;<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com<=
/a>&gt;; CLEMENT MATHIEU--DRIF &lt;<a href=3D"mailto:clement.mathieu--drif@=
eviden.com">clement.mathieu--drif@eviden.com</a>&gt;;
<a href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.com</a> &lt;<a hre=
f=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.com</a>&gt;;
<a href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a> &lt;<a href=3D=
"mailto:yi.l.liu@intel.com">yi.l.liu@intel.com</a>&gt;;
<a href=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.com</a> &lt;<a hre=
f=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.com</a>&gt;; Zhenzhong D=
uan &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.duan@intel.co=
m</a>&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 05/13] intel_iommu: Change pasid property=
 from bool to uint8<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal" style=3D"margin-bottom:12.0pt"><span style=3D"font-s=
ize:11.0pt">Caution: External email. Do not open attachments or click links=
, unless this email comes from a known sender and you know the content is s=
afe.<br>
<br>
<br>
'x-pasid-mode' is a bool property, we need an extra 'pss' property to<br>
represent PASID size supported. Because there is no any device in QEMU<br>
supporting pasid capability yet, no guest could use the pasid feature<br>
until now, 'x-pasid-mode' takes no effect.<br>
<br>
So instead of an extra 'pss' property we can use a single 'pasid'<br>
property of uint8 type to represent if pasid is supported and the PASID<br>
bits size. A value of N &gt; 0 means pasid is supported and N - 1 is the<br=
>
value in PSS field in ECAP register.<br>
<br>
Signed-off-by: Zhenzhong Duan &lt;<a href=3D"mailto:zhenzhong.duan@intel.co=
m">zhenzhong.duan@intel.com</a>&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 -<br>
&nbsp;include/hw/i386/intel_iommu.h&nbsp; | 2 +-<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 4 ++--<br>
&nbsp;3 files changed, 3 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index 11a53aa369..04a9392e8a 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,7 +195,6 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
-#define VTD_ECAP_PSS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (7ULL &lt;&lt; 35) /* limit: MemTxAttr=
s::pid */<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h<=
br>
index 54c2b6b77a..bb957b93e0 100644<br>
--- a/include/hw/i386/intel_iommu.h<br>
+++ b/include/hw/i386/intel_iommu.h<br>
@@ -315,7 +315,7 @@ struct IntelIOMMUState {<br>
&nbsp;&nbsp;&nbsp;&nbsp; OnOffAuto intr_eim;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Toggle for EIM cabability */<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp; uint8_t aw_bits;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Host/IOVA addre=
ss width (in bits) */<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool dma_drain;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Whether DM=
A r/w draining enabled */<br>
-&nbsp;&nbsp;&nbsp; bool pasid;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /* Whether to support PASID */<br>
+&nbsp;&nbsp;&nbsp; uint8_t pasid;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* PASID supp=
orted in bits, 0 if not */<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool fs1gp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /* First Stage 1-GByte Page Support */<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; /* Transient Mapping, Reserved(0) since VTD spec r=
evision 3.2 */<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 92a367d657..e27a7c725f 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -4186,7 +4186,7 @@ static const Property vtd_properties[] =3D {<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-scalable-mode&quot;, Inte=
lIOMMUState, scalable_mode, FALSE),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-flts&quot;, IntelIOMMUSta=
te, fsts, FALSE),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;snoop-control&quot;, IntelI=
OMMUState, snoop_control, false),<br>
-&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;x-pasid-mode&quot;, IntelIOMMUSt=
ate, pasid, false),<br>
+&nbsp;&nbsp;&nbsp; DEFINE_PROP_UINT8(&quot;pasid&quot;, IntelIOMMUState, p=
asid, 0),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;svm&quot;, IntelIOMMUState,=
 svm, false),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;dma-drain&quot;, IntelIOMMU=
State, dma_drain, true),<br>
&nbsp;&nbsp;&nbsp;&nbsp; DEFINE_PROP_BOOL(&quot;stale-tm&quot;, IntelIOMMUS=
tate, stale_tm, false),<br>
@@ -5033,7 +5033,7 @@ static void vtd_cap_init(IntelIOMMUState *s)<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;pasid) {<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ecap |=3D VTD_ECAP_PASID =
| VTD_ECAP_PSS;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ecap =3D VTD_ECAP_PASID |=
 deposit64(s-&gt;ecap, 35, 5, s-&gt;pasid - 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;}<br>
<br>
--<br>
2.47.3<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA3PR11MB91368B668DF1EB773AB54D779272AIA3PR11MB9136namp_--

