Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA91CA0EFF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 06:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur9v3-0002kI-KF; Wed, 27 Aug 2025 02:46:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ur9uu-0002iZ-Cz
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 02:45:58 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ur9uq-00081m-DM
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 02:45:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756277152; x=1787813152;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kN4R4DTxJuwefdgisU7unOHqF5pY4DQwVtpkG4iy4g8=;
 b=g66yJKE9rGpUBhKjoQl3kKJSRpHXAah50/DfgelllsgyVKk6cVTm2IrY
 kHC7Ue/LHR2/fW9OkNsik5BJ1o4Kc9EqkDEWVhpZjPcfBz/z+/Tpm2UF4
 J9aZ3e/F193DvIT4xZ+O1ILdDg/Xjt4XckfJ0fYkxR3cTvlZIKmrBHnnb
 KqA5d/fUjgTgsxhbVCszZRYFaVxzLUfCK3+E/KpsZPZQNBzcfUYUgejtP
 uEHuAvIN9DsdBTwiNF/8T0eA0dTU/BpxpxhShHQjUP8iB7gDZDMK3N3VX
 kzxZ+WPt+qeJRw7oA+k9nO5k+2VOHTCF0taemY673lMjfyZDkesSUrZ4r A==;
X-CSE-ConnectionGUID: G/1jnczLQyKfLWWfdlFI1g==
X-CSE-MsgGUID: Efysl3UKSBOjvyNEV2JNew==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="69894959"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="69894959"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 23:45:47 -0700
X-CSE-ConnectionGUID: OEcT89l2QZ+uHGO9BU+T8Q==
X-CSE-MsgGUID: w//8ix5ARpGSeD+8QMrFow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="170167610"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Aug 2025 23:45:46 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 23:45:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 26 Aug 2025 23:45:46 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (40.107.100.42)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 26 Aug 2025 23:45:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d20Emnb2Hq0CUPexbPsXCTy6gCwz8epbsrNOoVhwbbTnrqGkLXfYxdW6Zg2RZVsJecvJ6Mgk6/Pvw2WMwr7v+ejCJj1td6MfUSd7FlUqA5vmC/dLJI4A6oSLtUhE22WE06FAsJWNGQ6JKEFzc3/0p2BNo86+sgJ5Rk/+AAPoM7hNxSF7sa9WPAmyHaZB80tRdbHzkg2Ck25jRppkVsp/H35/mdZy6oHGujEslcTw3vlkX5+Wai4TXJMW1Nyb04GiXMvzJoqkY85rWSgYWs/JMzTPRhciapFnhiSYJyJ6ASQLzUX8unXoIfj1qOk8bs36YfZph0YLOl1DyukLHKLLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weTGy3RQAfUlGsNx2FAHvbeHXxf6xbIt9ZwYlQgB11g=;
 b=c3yUHnUOBZsiexQF6ph+X65QRfDU9xDwqYSvT7c3BqHbCRYDww2cGEVIGYyebEYoNcM8OaPPgZjt9PEfSVQ4VGen1SmfoacuEcEJFOz1uUe4aRv4rDrM7BJZ08jKicj41QdRB8dz+aQMWjxuJhMFdA0+WYWcylVzVmCfRiYKz/Q9CBMfWmSa2ic8tNuqImyiq60fyAOz1plujr5UiXhVGnt06qe5kEUzNHkOyK0RlWaSXrQCJESpveQfaeVoW35lVm6nPDOF4wdprRHQSFsYXOXomPjzB15OR34g9L6Y0n0yjNzs7Xs0jOPSsVHiSKqGpL6TQfMUrl4BfW5QBJKdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DS7PR11MB7783.namprd11.prod.outlook.com (2603:10b6:8:e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 06:45:42 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 06:45:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Topic: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
Thread-Index: AQHcEy/do9teDlFYnEKseS/ebbtbpLR1NTuAgAC5ezA=
Date: Wed, 27 Aug 2025 06:45:42 +0000
Message-ID: <IA3PR11MB913642ABC862B837CF0DF4359238A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
 <aK3tAUUn5t61VPyk@Asurada-Nvidia>
In-Reply-To: <aK3tAUUn5t61VPyk@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DS7PR11MB7783:EE_
x-ms-office365-filtering-correlation-id: 3c72cebb-218e-4d2d-cc5e-08dde53557c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bH2AiXGnlZeUoJhtWC8oIE3zTCzTqbi1YHtEUeTEzoHeyN4j/uQMmukf3Y7o?=
 =?us-ascii?Q?dPrM7BVHY11W1Uam41YWmwaAaCz+yQlT/ckNVpd3pU/T+kqDc1E9X9CriKDE?=
 =?us-ascii?Q?FXjg2fs32iwG3a0KdIbp7CMH9D0/3vXhLuPkdM/ZuwOn5EmSCnkvvxBcDyHK?=
 =?us-ascii?Q?I4ZwEQtUFl1K+mc86HZy4oFaYLSJauTe/91aQ2MgGhj8ejkmtRxG6BcQlUYN?=
 =?us-ascii?Q?7ppAkxXVb49SoHDvucKLA+1jnx9fxE1dZudkFSGQtvQUwaudo7XQU2mz6yh5?=
 =?us-ascii?Q?NQpCDLbJRorcZHiDc7PRBdibpUZxyPw/Ka/514A4gnqoQ+ntULaLMWUY7OO0?=
 =?us-ascii?Q?bmlMwZJgMFmkH5RbryJFK6oguYlC+a73gHWFEQ6MkBZJmStCmwJ2FBLwHPdB?=
 =?us-ascii?Q?WWOXSXUDsfMt5lqqnpdgx1j0vqCpcIndawAmCtZlip93WJO6HniwTqE4PhJC?=
 =?us-ascii?Q?es/4yE3dVCAMF3VfN14Xh1hbJ3JdeCBFFnpSrmVEj3W4ThZeFWoKs2DjukzK?=
 =?us-ascii?Q?fPfZFg9Oyaz+3nlOqoaqYhhNXZyrVkDaF4IjLMcNXQDFOjx38pBBoffp4GBP?=
 =?us-ascii?Q?RSMM1nLvaottbKjXu3a/WPgMurE/SZuUOjQ+HKeiPs7LDH77Agvelc6QqtzP?=
 =?us-ascii?Q?VDv0YT4bgasDNj3ewROk+pkOCMrKqA19j54ivD4dVZdqZr1mrAmDuV+KCyaC?=
 =?us-ascii?Q?F0J5pkIhASJGFvvD51eGhD1Rfy0T6lPMSa0C+Rv/j/xt2SJZRNOyCc9DFghK?=
 =?us-ascii?Q?A15ZB6fzlhoAAWaZwBzv45w2AEpPDUPWWekhPGE18BG8pPpHbu0SsB9GONBQ?=
 =?us-ascii?Q?IGWQwQ3xkGH4nk+Am3/dttfuhgkQkiM4NN/KPm7auI7wsAIvg+SH6wgno6vr?=
 =?us-ascii?Q?m1MgwqBIRuf3aUuYhHXGzDi8l3SRJvSB2B86jyNPs+l+QQm/MxzPaZzmB1+W?=
 =?us-ascii?Q?xgIAcqvsCZDY2D9Ctggy1VEOG4/IGQZ7sszGK7VuyJOBhks17qH+MB9wyNg/?=
 =?us-ascii?Q?rGwAQ3FFvwtj+zMK7pktspbEKc5Z/g3MxsmQXULPoMowi2pDq85sCex6BuTZ?=
 =?us-ascii?Q?5GXPllG5ouaNZPGMvUNLToO0uMlYOw+uYgjbdqkf+lQWNdyboRq6LDEsqKL1?=
 =?us-ascii?Q?fsRJmwHQB+uQQAby+QYrVICEYH8TWwTbfJiKZUtdiAXCoaXkA2Dj7vqaU5IZ?=
 =?us-ascii?Q?dpxNUM7D5EjkqR3HAzJs+53ls8qGEhk4ONbQGlxoBaIplUd7oP9Gy04lPgqY?=
 =?us-ascii?Q?KTFsP1gSTVVx1qEIchloOVaTCmnWHM1ao130lAhOwkNKriJc6iZ74Odvq0tZ?=
 =?us-ascii?Q?/aSwKUBc2yUsSF220k8OaWG8sMWsrS0VgDH9Cn+Mqe5Ghn8kr8pgzYx3ysmM?=
 =?us-ascii?Q?07PyFeoGEOg56t49mqu3V0yTl3xndwYtVIXb6CO0Oc1AV4+G+fXye3yD25pW?=
 =?us-ascii?Q?cgj/KvE9+achPJGWCe4YqmQX65gcIkr0Vt40qOrrQYlsoTPwC99BtRwEeD/E?=
 =?us-ascii?Q?XJZvkQxigkdCBVY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ozWsqTCWMxFc8Fbzq0Dkosg28et9F7V8yA63+Ft7D/0speQuvoJZOI3qUQ5I?=
 =?us-ascii?Q?JMBMof+WheQmRQIBIE/wy1h6Vt8R6VGd8EpVcx7EP32nrH8pQynJqdMoQYXL?=
 =?us-ascii?Q?hfW1lpPdp46itiaFm8pcIQ5ZfNhQ7+1p3d6kP04Mzai96yDF6ToJT02Tgd1T?=
 =?us-ascii?Q?gB27YXHtzt2+o+R0E5YroFmbrvDu2TT2T0pyRwoQzgtKwRpJhgxrMcMzfpxg?=
 =?us-ascii?Q?gbopr2yBDmj1I9Bmz6UdORGm3+i3VmDtY4NV94ooDXd0IuRtwsIl+Ggp8L7x?=
 =?us-ascii?Q?MCrQwxGsnfQmoip0lFUtco5n26itAZXdztmkThb2//eBgqxU2U7PNo9tHxQH?=
 =?us-ascii?Q?zJwBJjAlJwNlwRVIjerxWslOUdsbNM1aZHZGA08VSsCLQkuwBQy4J4kabkVd?=
 =?us-ascii?Q?0mMCRoeckX3/gJQ9ykkFkfysbjT9L3k163vz6Zd1u/1kfdRvx40D44EWu1kc?=
 =?us-ascii?Q?JEmsaEK3caLLMXD3kPJVFwWxkUG8JXX0TCuloytEqZXhY55fJPB38y5QscnL?=
 =?us-ascii?Q?Ut+wwFKU8SHMgEYkEbKpqB7s4FiEQ/PnKOjcAkCUgmP4xnoYSA3HzojBukAS?=
 =?us-ascii?Q?TjvdxI0o0tdLZoDX14e+SLIbxlc9lhDFGZui5rnxrwQn0OwN7bC8/4LLLaKg?=
 =?us-ascii?Q?A6gkcKR+8IzpLJ+z0z3QREDO/JwmxbV3jaSuQJs8KmzWjETf6l+m4u4oKY1m?=
 =?us-ascii?Q?DqCRMNE77Lid5NiDNpgzoOsisO0E5U49Z+ZLU90WKUdEVL3AqewrBgzEs6C2?=
 =?us-ascii?Q?/P3+7vSI14kSeWE9MTgbCx4068c1U7u7ednal61WP2A01QzJaIFAoB4dt7Fn?=
 =?us-ascii?Q?7dx9PHb1LbAmmBYsqhycPyaJCq37OSUS+KeqD1eDuAHzKQUKsNR1TKDYvMXh?=
 =?us-ascii?Q?Qsc/iWIlnFYQoEofTzvBIH4b1lyqMllRqbesX+rq9Hhgs1cMQbhp/Tuegh8W?=
 =?us-ascii?Q?1Qn2/8QBmup6+6xa5UOSf6kDpXYWCe1qSAVU335ZsYwRl5/wutWr/DgMnf/U?=
 =?us-ascii?Q?9sTBhm4aYFUZkq2dIzIp5XDBOwZSjXbEQrjEdHWedbnqA/s7gv4jepsmqfAE?=
 =?us-ascii?Q?2a1ewImXuHsZPT+yCfpGp/hnrMAC3om9jPHjg6E8GPVENMt+g1PQPQ4CPJD0?=
 =?us-ascii?Q?IhG0KdU9fIhJOhCNnyjj6Oe7klPeJPie59aUbUyac2Vkj5lrOMsOfpiBX8sc?=
 =?us-ascii?Q?mrKyXaI8o817YYGZkeF/OJTsfJhMSH4HT7gkI/R9FZ1Sr/sic2Wcbo8QtcmQ?=
 =?us-ascii?Q?/K1k7LNX/hk9u+L84rjIimXRUHOiakPfAUUu88sBOPi+8nCJH6eIhwpVjusA?=
 =?us-ascii?Q?81SP+F6LxJcE1uz/YCLs4MY9KU0ZDB3e/mal5Wyu/OGPYEULUNfzfdkF0bqL?=
 =?us-ascii?Q?xfhojP9OFqCMxivvNjn7U/KDLKInx9IzXEMcUxOWrwe5iFI907bB94E5Os7e?=
 =?us-ascii?Q?eE73j1LWsfOrq0XCvjZAvuubvQSe8Dbl5XWf4wedgj/w0muTABBhmXB/u26y?=
 =?us-ascii?Q?t9FTMTwroUlp9Pa9Qet2MLbJfkawyOIYIZG+Gz0+s1qK5gfeSuDiR622S5Xo?=
 =?us-ascii?Q?xYoNiCYKbesHVVLkWbuXzsNEV4b52cP+ZR9JFSHH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c72cebb-218e-4d2d-cc5e-08dde53557c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2025 06:45:42.5248 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tf0YOsWbv7oJ1QiBffL56FrKvoOaPkPDGxXu9SyJ23SOAjRictstvpl+FX8MRGRV/SCuwq/U0FTi7/kUXzd/ozvf+BQG4q1gqvIn4qZ3qVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7783
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10;
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

Hi

>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
>VTDHostIOMMUDevice
>
>Hi Zhenzhong/Yi,
>
>On Fri, Aug 22, 2025 at 02:40:45AM -0400, Zhenzhong Duan wrote:
>> @@ -4371,6 +4374,7 @@ static bool vtd_dev_set_iommu_device(PCIBus
>*bus, void *opaque, int devfn,
>>                                       HostIOMMUDevice *hiod,
>Error **errp)
>>  {
>>      IntelIOMMUState *s =3D opaque;
>> +    VTDHostIOMMUDevice *vtd_hiod;
>>      struct vtd_as_key key =3D {
>>          .bus =3D bus,
>>          .devfn =3D devfn,
>
>I wonder if the bus/devfn here would always reflect the actual BDF
>numbers in this function, on an x86 VM.

devfn is enumerated by QEMU, see do_pci_register_device(), bus number is en=
umerated in BIOS or kernel.
So we can't use BDF number as key, we use PCIBus pointer + devfn as the key=
 instead.

>
>With ARM, when the device is attached to a pxb bus, the bus/devfn
>here are both 0, so PCI_BUILD_BDF() using these two returns 0 too.
>
>QEMU command for the device:
> -device pxb-pcie,id=3Dpcie.1,bus_nr=3D1,bus=3Dpcie.0 \
> -device arm-smmuv3,primary-bus=3Dpcie.1,id=3Dsmmuv3.1,accel=3Don \
> -device pcie-root-port,id=3Dpcie.port1,bus=3Dpcie.1,chassis=3D1,io-reserv=
e=3D0 \
> -device
>vfio-pci-nohotplug,host=3D0009:01:00.0,bus=3Dpcie.port1,rombar=3D0,id=3Dde=
v0,iom
>mufd=3Diommufd0
>
>QEMU log:
>smmuv3_accel_set_iommu_device: bus=3D0, devfn=3D0, sid=3D0

There is only one device under pcie.port1, devfn is initialized to 0, bus n=
umber isn't enumerated yet during realize() so 0.

>
>The set_iommu_device op is invoked by vfio_pci_realize() where the
>the BDF number won't get ready for this kind of PCI setup until a
>later stage that I can't identify yet..
>
>Given that VTD wants the BDF number too, I start to wonder whether
>the set_iommu_device op is invoked in the right place or not..
>
>Maybe VTD works because it saves the bus pointer v.s. bus_num(=3D0),
>so its bus_num would be updated when later code calculates the BDF
>number using the saved bus pointer (in the key). Nonetheless, the
>saved devfn (in the key) is 0, which wouldn't be updated later as
>the bus_num. So, if the device is supposed to have a devfn (!=3D0),
>this wouldn't work?

Both PCIBus pointer and devfn are fixed value for a QEMU instance, never ch=
anged.

Thanks
Zhenzhong

