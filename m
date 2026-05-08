Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D54DCD343F
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 01:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLAIK-0005Fi-Qo; Thu, 07 May 2026 21:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLAII-0005FZ-9O
 for qemu-devel@nongnu.org; Thu, 07 May 2026 21:46:22 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wLAIF-0003if-PO
 for qemu-devel@nongnu.org; Thu, 07 May 2026 21:46:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1778204780; x=1809740780;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=nFzHUjFDbWyFcwns3YeKL/a8F+OpM/SUuSEr9o/B9Mo=;
 b=CLMB97eMofRNzAEcALNqhOW7U0rUC9nm/UfQ159grRPvwNY3Cq4mHu9v
 JC/kV7NxWeXjAIHtS5NFdkP2vYmipd3wOgWOjCvd0UFZUJootMbAwB0qX
 tsKezBRyLdOjJ565fe6uIrUZCOrj16zgqkoFT14fIDy/dq6lrEm3iaW/d
 xszMeUn25HjxyB7iduk2f0TaBOBA+UzEOqcS/FoS2l3dZbE3u/vNS3xIq
 zSDlqE/cT0jBDNiCwaXe7UAEXcZgvsqciH87NwPAYXqLr2kXupzuYutwS
 /f5PODqj/DBvqA0M6Hca4ZkR8u1m+rDkkxe1t3Lq8t2IbJA8WxSD3WtyJ w==;
X-CSE-ConnectionGUID: 32bPbdbiQnaOEr+XI+ZDng==
X-CSE-MsgGUID: QtVvLnhlQh+ScrKo+TbwrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="90272495"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="90272495"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 18:46:14 -0700
X-CSE-ConnectionGUID: SwdNfQDJRem9n9Hyqwpn1Q==
X-CSE-MsgGUID: 0fjDWKNlTKipNaImjXAXSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; d="scan'208";a="233976829"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2026 18:46:13 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 18:46:13 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 18:46:13 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.59) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 18:46:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Je+v5HuGuEsEesMvSZu7p2oZPr3p5U1OHCYzfl5TZfqrosj/XCELkHzu4YCtqgdEatfsrx44UOq0ySdO29e7vOKUFDl0fZEXR307B0abwPy7BRNhNaQv/t02Cp+q9Vu8+QxTne+5CScDNi29bPp4ddswoSUrQHxMGRdnmcY6p+YfuoV7qTFS9mIuhIkXhT7XOeQovxTvNAuS0wbySoRhMJDW2WZRv9ZQRIDh5K9619Yalg8hDvtRHKukng+/KvY3OS4giWEehGZMvIHMiAH8NFiE71VmtaNvIDZ2n8GQlRy6KUFCIY2C0rn7eyx/AmZBZf3ga6mC1Z59g8Onjnuh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qIbEuOFokS5xC06LvG+H6CAJ+htYBuvcOve024XCNS4=;
 b=abxDiCdj+Ozf69xtrTM3WbxflcgULRcy0iLO3cSveFxzs7QubBP4LDHFLuL2LDY0qbVnovezYsaa8K0n0lzOD86HQydJ77BMzSzGJlQdxeIBqw9WWDVdkoY5GUWKzQ5SEbCUdchHKmfKNOgxlnMOfhEZadKu3s4CYDVDr4WvzLK5naOKoSrOwKecjgfOvfOxXn93zb0H2wCnBmmWzgP0CZgJDLr4Ggkg1EmAlfjCTsGCPChaG4A94LJFyAgOIzcCoX3Zvy18oDXqXbnfOQLptfY4xUVm4cYwi2WBhs4DPpLwA45IkTAMaZbXaHeyBenL8fP5erELoXALQ1j1mqKOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA4PR11MB9106.namprd11.prod.outlook.com (2603:10b6:208:55f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Fri, 8 May
 2026 01:46:09 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 01:46:09 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@bull.com" <clement.mathieu--drif@bull.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao,
 Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Topic: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
 IOMMU_HWPT_ALLOC_PASID flag
Thread-Index: AQHc2HDsdHmvyEbLYUuUhfmf5MuDZbX3nKeAgAvIkxA=
Date: Fri, 8 May 2026 01:46:09 +0000
Message-ID: <IA3PR11MB91368B4C6AEFCCD8119C5FCF923D2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260430071315.354333-1-zhenzhong.duan@intel.com>
 <20260430071315.354333-4-zhenzhong.duan@intel.com>
 <CH3PR12MB754848E6244366B28A0784AAAB352@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB754848E6244366B28A0784AAAB352@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA4PR11MB9106:EE_
x-ms-office365-filtering-correlation-id: c6c81d6c-57f3-4b53-7a72-08deaca393d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9OVRv5AP1CHsDK8T3LnIqkKY0GFxXlrBVfhjf9KzF6wb4L2+orh0UqmR5oKYs5nzMNGGjWaG9dzy/hKl2Q6G9vzI6JmORun4mQ/EhGWH/l5mWnAwpmlFAk8hhczkFPG2opUaLc2M4Js6s32rBo8Vg1jv0+PRRx27jFevkuy3Z5Em5TC9oOVG4MOXJFasCGZS56rosPjSDHY6B6SBNWvXbMwihmrt/o7Xed1TCF++Pir1TrQj/wFsxRkEEvTRNv8FiB+fHDk9/1a/f8wB13TpIylkXT2SlCQcypM08PIsJpG5RIOEBDVu4po5k8zanXQgYl+Yb1qoSD33YkvKc4xbJE8CN6Mme8aHmU1ewyvZEPkdihS++oCuO+/JPIEDMR75KivkZeKeq04RBbZbmevPXcv4WcTmdPSPwyoxzTONv9ljK8GlFYO0+w5Q/OzIJxfKmOh0xudP08aNlUNHrJbZ5+Z7XhtGNmailiCz+XEZOzBLszESh/FHO2hSwu3KoSMn+1CEOHJjYfX56eVz+ojKcOo36GJsfSuUr3MwH0HMtWqWx1yt/8hqZhtF9S8u77Pmu9MjkR1BzL+BEjaHV1f98keynplZdCjsVh/z+evlgpqpVoHy2T6oYMcptto8nAYMrEXhSlVTOkiTHaz0qNLEba5Pjvr/NVcJNKlBDZ4DtOlmImgNPgDMeG/3L87ydSYRkhOC//gRLyFwtgFa5eGkgB+k/D2j8rDILsp2yMhoP6cg8st6u3Awq46sgyWsPs+B
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MIxBdXOwberDgJ0X/ghPjLnOU+mMuf4B6MebPqpKGzT6s20oTgAUcAnHo7NU?=
 =?us-ascii?Q?QSzX+UJm2HGjAjynKNOZUoW8CCX0C/BbfB22NI/Yo6w9sKB6+InguzuquIIj?=
 =?us-ascii?Q?0ePl3EDAkqBnbXdCvzmnWsKTGS5fM0iKBR56jTeIaQMDnw+NFpj4s3G14N9a?=
 =?us-ascii?Q?R46Pgkmq2w5Zm2JzJMbZ+x2WGsPGlS930F0AdlVltk73aY695Y6PhABYCITu?=
 =?us-ascii?Q?G6eke02FKDIm+YDVaXSitgwzG9/hqPMtgabW5buxfibuLh5KyYy8thW34OxO?=
 =?us-ascii?Q?1VNICjKbGLyg4tsLstliTPZiQiSQkdO6+M9m34oEqifOYhHE/EUfhkd1TF0G?=
 =?us-ascii?Q?j2+EyaSs46KpGPdjMzU4CmWNzgRu8Li7/Uyyb08va5BJ4adg0Qh/sR2ARKIO?=
 =?us-ascii?Q?2IXjwQlmUUqSRXW9xRvzi2o2toCUx7bmES1t248FXax3w18wR7ACJs1iZKye?=
 =?us-ascii?Q?X6ejmQvi2ZoR3ThMfoKymRP+fUKCaCS6Q1lWrsIJIOlKg9XcU7cU/Tm8c9em?=
 =?us-ascii?Q?JrVtQ0jhEZ/KVZNlbE8dl1DWoT1gApjXwB1h8QTPAY1NGwdT6Tex57R/0PQm?=
 =?us-ascii?Q?mkwICZVhE0IwiWTeDk6GQDJvygGIIHtTC9YwNWU44Vd0RYoyGDwjHLQAcRxg?=
 =?us-ascii?Q?pjVRgS58fIUZldzTKwSyLMNI8xh7cKsjlzTOyoVkAVhNu0cexWGDtwL0y5el?=
 =?us-ascii?Q?MP6DljxNnIHGWIONZOM3EcbTnevNnjB4XOHKsB/Jrz6vv2Zme8UlCzei26cJ?=
 =?us-ascii?Q?h9TUQtbG9eOhgeHasC9sCGUfy4H8pjaQ3S6atMyNg3xdUw5FPAIpCwtzzS5O?=
 =?us-ascii?Q?KCsCEf3z8XIpFKQBhaeIr3e2OX0FZ1P5tssVT/HhxumCX/1LnFGrdyl3toqx?=
 =?us-ascii?Q?ZMJYXfq+t0p8PIQaTzx3eUUuo3ZKTnhU9ndGyVBDoQSCauu+JDXEN8cQbqNi?=
 =?us-ascii?Q?33T6a1YjNFMb4vd57K9JaDVh49ed87/0iwbjsezy6OARHVeYUF+07fU+tIio?=
 =?us-ascii?Q?ICBPmC8D0yim98H2aML2fnSs7NiibBB2JOLkeB/sm/QYKS6rMPrj3eZ2aErp?=
 =?us-ascii?Q?1sJaei7YWngBlNZixSTgD2tQA60Yz6pM8AUWnIw0Sh4PBHDAoJsQ8fz0G68C?=
 =?us-ascii?Q?4RkWWEjJR3wEVSwZ1UEGLCXp+N4xRWviVLuKXVgMMFnfs9GV61miDEjODS2q?=
 =?us-ascii?Q?f2himpqX4hP6TR3PKuo6k7+D6wC5EXr0oKnbY6Kz0jtElKmpdzDRyI64fVgl?=
 =?us-ascii?Q?VzGd/E+tKFYnptvOceMyZJrS55CaR06Ypzh1XKCUoCewoHRI4QLsxla4HXSk?=
 =?us-ascii?Q?6tqlGU0n9laJ4pSoG7hM/F2ue1fONw7b/G1RsacYtXos73o3+aNJ87tHywff?=
 =?us-ascii?Q?2qpUrOqBZjbRnmAz5FwywoNgLAiefI8OJk2qcgIfHLJbPqS2rajYHLtX89jg?=
 =?us-ascii?Q?aKXchvAe1fhFY9MNy7zYnMnJwT4G2/dYIUqCSsBKbsQChHXac2cUkEJRuPCn?=
 =?us-ascii?Q?wfkEUeX3z1NdYqBU43F87wHTZEO4mLRqIJoj3LvGWakjUCY0aPRor2vYW+oH?=
 =?us-ascii?Q?8kFDhTUAgRYePjwctUT2kFSZpTwlKAwhdvUzDaWzaI0gFshhiQXgQpCoCt4c?=
 =?us-ascii?Q?i5AKt1Mhz+lB5OOv7zxhB78YMvpjFf/TeS4sPYX0I0i0Ew0eshjWiun7w5m4?=
 =?us-ascii?Q?F4PS+YCsQMkc7Kp8JRdDvXZqztoeI5zIdt3YjTkfaSOhI6LUPYNXJuBy9Nax?=
 =?us-ascii?Q?EmgAyqYNsw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: wZq83SjGt7Wuel5UvTxmsZoAcE31Aj1zVcdG6jwfkNHEcB2HwxnSKQL7x7XJUiXhbmjXKbY5fk/SFJECNn6LeT8LP+VE5n6E76sl2UEnSdF2iE9oR9U36vyADi91zM2fxj96J15XN/YO6s9BQRZf2IK6bVSPMCCJxbZQ/8+Q/aSk4HDjAWaL9l2Rxtc3CxpssVYPBx628/aulz+4QXd3kMKjXPtoeBbJYYW25ig83nRNJWtP0fpqKrT/LZpLoO+qbU6Hm0ERBsc1cq1ZRJjqg0bEI9VUjtQ8Oaj2kxjkK2WxzvKMFulbVWzrVm8iSbGXRQt0hLSfBdrBwHKkQ/jKBg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6c81d6c-57f3-4b53-7a72-08deaca393d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 01:46:09.2917 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KI8HZ+eOGw5ZwihghQzL2eGtmGNpKLaN5X1lLuM8Poh7NPH6MJYmDz7k5gKsCQaYuvoAUaE7HRmeM2MgSPS2hLu1Q3xcecwYjZJ1d3506BE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9106
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
>Subject: RE: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt wit=
h
>IOMMU_HWPT_ALLOC_PASID flag
>
>
>
>> -----Original Message-----
>> From: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Sent: 30 April 2026 08:13
>> To: qemu-devel@nongnu.org
>> Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com;
>> mst@redhat.com; jasowang@redhat.com; Jason Gunthorpe
>> <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; Shameer Kolothum
>> Thodi <skolothumtho@nvidia.com>; joao.m.martins@oracle.com;
>> clement.mathieu--drif@bull.com; kevin.tian@intel.com; yi.l.liu@intel.com=
;
>> xudong.hao@intel.com; Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Subject: [PATCH v4 03/15] vfio/iommufd: Create nesting parent hwpt with
>> IOMMU_HWPT_ALLOC_PASID flag
>>
>> External email: Use caution opening links or attachments
>>
>>
>> When both device and vIOMMU have PASID enabled, then guest may setup
>> pasid attached translation.
>>
>> VFIO needs to be aware of potential pasid usage and should attach the
>> non-pasid part of pasid-capable device to hwpt flagged with
>> IOMMU_HWPT_ALLOC_PASID.
>>
>> ARM SMMU doesn't support IOMMU_HWPT_ALLOC_PASID, only VTD need it.
>> So
>> we can't check the existing vIOMMU flag VIOMMU_FLAG_PASID_SUPPORTED
>> to
>> determine if set flag IOMMU_HWPT_ALLOC_PASID. Instead, introduce a new
>> flag VIOMMU_FLAG_WANT_PASID_ATTACH which will only be exposed by
>> VTD.
>>
>> Opportunistically add documentation for VIOMMU_FLAG_PASID_SUPPORTED
>> and explain the difference with VIOMMU_FLAG_WANT_PASID_ATTACH.
>>
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>> Tested-by: Xudong Hao <xudong.hao@intel.com>
>> ---
>>  include/hw/core/iommu.h       | 11 +++++++++++
>>  include/hw/vfio/vfio-device.h |  1 +
>>  hw/vfio/device.c              | 11 +++++++++++
>>  hw/vfio/iommufd.c             |  8 +++++++-
>>  4 files changed, 30 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/core/iommu.h b/include/hw/core/iommu.h
>> index 77739d4214..20d6d79062 100644
>> --- a/include/hw/core/iommu.h
>> +++ b/include/hw/core/iommu.h
>> @@ -20,9 +20,20 @@
>>  enum viommu_flags {
>>      /* vIOMMU needs nesting parent HWPT to create nested HWPT */
>>      VIOMMU_FLAG_WANT_NESTING_PARENT =3D BIT_ULL(0),
>> +    /*
>> +     * vIOMMU supports PASID capability, VFIO checks this flag and synt=
hesize
>> +     * a PASID capability.
>> +     */
>>      VIOMMU_FLAG_PASID_SUPPORTED =3D BIT_ULL(1),
>>      /* vIOMMU needs dirty tracking on the nesting parent HWPT for neste=
d use
>> */
>>      VIOMMU_FLAG_WANT_NESTING_DIRTY_TRACKING =3D BIT_ULL(2),
>> +    /*
>> +     * vIOMMU requests other sub-system like VFIO to create a HWPT that=
 can
>> be
>> +     * used with PASID attachment. VIOMMU_FLAG_PASID_SUPPORTED can't
>> be used
>> +     * for this purpose as PASID attachment is needed by VTD IOMMU but =
not
>> ARM
>> +     * SMMU.
>> +     */
>> +    VIOMMU_FLAG_WANT_PASID_ATTACH =3D BIT_ULL(3),
>>  };
>>
>>  /* Host IOMMU quirks. Extracted from host IOMMU capabilities */
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device=
.h
>> index 380a55d6e5..8472420d3f 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -282,6 +282,7 @@ void vfio_device_unprepare(VFIODevice *vbasedev);
>>
>>  bool vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev);
>>  bool vfio_device_get_viommu_flags_want_nesting_dirty(VFIODevice
>> *vbasedev);
>> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice
>> *vbasedev);
>>  bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>>                                                  uint32_t type, void *ca=
ps,
>>                                                  uint32_t size);
>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
>> index 3ffd69a579..b954b44d31 100644
>> --- a/hw/vfio/device.c
>> +++ b/hw/vfio/device.c
>> @@ -544,6 +544,17 @@ bool
>> vfio_device_get_viommu_flags_want_nesting(VFIODevice *vbasedev)
>>      return false;
>>  }
>>
>> +bool vfio_device_get_viommu_flags_want_pasid_attach(VFIODevice
>> *vbasedev)
>> +{
>> +    VFIOPCIDevice *vdev =3D vfio_pci_from_vfio_device(vbasedev);
>> +
>> +    if (vdev) {
>> +        return !!(pci_device_get_viommu_flags(PCI_DEVICE(vdev)) &
>> +                  VIOMMU_FLAG_WANT_PASID_ATTACH);
>> +    }
>> +    return false;
>> +}
>> +
>>  bool vfio_device_get_host_iommu_quirk_bypass_ro(VFIODevice *vbasedev,
>>                                                  uint32_t type, void *ca=
ps,
>>                                                  uint32_t size)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 78e7b6a045..0718f029ca 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -364,6 +364,7 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>      VendorCaps caps;
>>      VFIOIOASHwpt *hwpt;
>>      uint32_t hwpt_id;
>> +    uint8_t max_pasid_log2 =3D 0;
>>      int ret;
>>
>>      /* Try to find a domain */
>> @@ -409,7 +410,7 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>       */
>>      if (!iommufd_backend_get_device_info(vbasedev->iommufd, vbasedev-
>> >devid,
>>                                           &type, &caps, sizeof(caps), &h=
w_caps,
>> -                                         NULL, errp)) {
>> +                                         &max_pasid_log2, errp)) {
>>          return false;
>>      }
>>
>> @@ -437,6 +438,11 @@ static bool
>> iommufd_cdev_autodomains_get(VFIODevice *vbasedev,
>>          }
>>      }
>>
>> +    if (max_pasid_log2 &&
>> +        vfio_device_get_viommu_flags_want_pasid_attach(vbasedev)) {
>> +        flags |=3D IOMMU_HWPT_ALLOC_PASID;
>> +    }
>
>Here, suppose a container already has an hwpt without
>IOMMU_HWPT_ALLOC_PASID
>(from a no PASID device), and a PASID capable device then tries to attach =
to it
>via the FOREACH loop above, does the kernel return -EINVAL:
>
>ret =3D iommufd_cdev_pasid_attach_ioas_hwpt(vbasedev, IOMMU_NO_PASID,
>                                                      hwpt->hwpt_id, errp)=
;
>
>If not, it will get attached to NO_PASID HWPT and return there, isn't it?

We had below commit:

commit 42fa8991b5e3501f07f43b8f40cd8eab306164a8
Author: Zhenzhong Duan <zhenzhong.duan@intel.com>
Date:   Tue Jan 6 01:12:52 2026 -0500

    intel_iommu_accel: Fail passthrough device under PCI bridge if x-flts=
=3Don

which ensures each passthrough device is attached to separate AddressSpace
in nesting cases, so it never shares a container with other passthrough dev=
ices.

Thanks
Zhenzhong

