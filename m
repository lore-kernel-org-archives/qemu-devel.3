Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E91C83F1D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 10:54:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubdIY-0003Uk-Us; Tue, 15 Jul 2025 06:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubdIQ-0003QT-6L; Tue, 15 Jul 2025 06:54:05 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubdIN-0001HV-5x; Tue, 15 Jul 2025 06:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752576839; x=1784112839;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9hITOCOHEr1c/i9QRHwywhXYrr4vxI1rxF98/7UIzro=;
 b=l2SODXAu4sEWWIE3MGYomnp8ooB4xpePiepPeAG8Jh8s2XVwTWQA7C4w
 ldqyFJeVQicMQrIOSRt0f+PYIfdk8A2Y1MU0eYKb6trYePbKvdtgWaL17
 TkXSanRyYJDnO788aXMDv3C6Pgrw7FX5FVQmmLgJQZJLAK8uR7vKnrWrR
 8HYz1UheEgcEusjfdYozFP3Rd/I/X2hdpBhXsW6j+CcoSRJCnNLzJmVWX
 h78WckRmlzPRUDHxMJwaxYDUqQWsHn1Y2i2u3xugQtYjjxnhueIfhNrEA
 MggjeAzIee2TFKkvnYos/YEpW7jmMn/82JwSJy8Pjt9/BCxtFXYj1ZYh+ Q==;
X-CSE-ConnectionGUID: db1SXG5sQ06UC5NQjYh/gw==
X-CSE-MsgGUID: Cu+GrT9MT5+Oplgx1MHvIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65858787"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="65858787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 03:53:56 -0700
X-CSE-ConnectionGUID: LNE5C0zFR7yBPqNfNqaX4A==
X-CSE-MsgGUID: aVxS6WlQQI2FLa0YzHO/vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; d="scan'208";a="188178258"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 03:53:56 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:53:55 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 03:53:55 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.75)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 03:53:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mah97FJfpM7dXEALOfVaJFDeVU83maBZuh8E1EwpwiUSvVYfmxkvtguG/X4h4FozupVTCS6/F3QmafugVrH8alCim94c2T/bZhmaWH8pnOHux2m0MJhEgW9TmFcQWRHfC7esEdtpm2zdbNccvIz0fYt0ZGLKc23VpSgOnNV4xCI5jRJcAiyUTlVlmwr0oiXsofHtlNG3+pv1KOnCx5rgGg1hJ8oBqtEjKBu346Z+MDDAGx4Mk7sgykEcUT5sWYelciPCUmtkQTOTvTpi8ilEhTx82o4MQPvFWKg9dKqXXtI/RhXqiPIfEwP0Nm9dMr1PHVUmQvHtXiowWTVaH4H3uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=embFmSLGYpYr463a0ET2YYEqeIL2jd0B6ZVx96MnGFM=;
 b=YWaBg7d6kvQmvVN7Be/nIcpe+vJ63QiwCa82Jw/uQO1cfb2DUCZE2ta4Xik2pp7+CtMBJ1XYd0vb83DiC5zh9hWztrvFwd6WhC2wkxp+BkMRFzf5Zjl2wrvyW6X51HgEKn/ctZux6tJeunE62yA1howDD9PKZ/dyYNmbOQooHrDFoyedXqIJ1hSwTPTNj0PbEnrHT4WcqTI1Uz1sCuUkMJ2q0CCfWoxlAxSuZx438Wf6LUFR7vezxW93UqQQ3F7tt9N6zCYhTXRDCjIB+ObpsXqeOKB7ELlCqoF9DLd3hrkU2ExLSOF2omtp3tMh6t+azVwX3Ct3cabe/NreWXVOLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Tue, 15 Jul
 2025 10:53:50 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Tue, 15 Jul 2025
 10:53:50 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "berrange@redhat.com"
 <berrange@redhat.com>, "nathanc@nvidia.com" <nathanc@nvidia.com>,
 "mochs@nvidia.com" <mochs@nvidia.com>, "smostafa@google.com"
 <smostafa@google.com>, "linuxarm@huawei.com" <linuxarm@huawei.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>, "jiangkunkun@huawei.com"
 <jiangkunkun@huawei.com>, "jonathan.cameron@huawei.com"
 <jonathan.cameron@huawei.com>, "zhangfei.gao@linaro.org"
 <zhangfei.gao@linaro.org>, "shameerkolothum@gmail.com"
 <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHb9Nia/FYvy/Va1kO7Qt3Wn+Al1LQy3OPg
Date: Tue, 15 Jul 2025 10:53:50 +0000
Message-ID: <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
In-Reply-To: <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6417:EE_
x-ms-office365-filtering-correlation-id: 1947c620-4922-4ab3-228d-08ddc38de212
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?eRbIeeISOmmtOW/egsRrXSvqx9V5dhBsaZRy9MQbhQkbrPjsWp+I74OER3/3?=
 =?us-ascii?Q?GwCIEOm/EPDpbnu3Cn7fyuvTAclQ3DtllGSdC19wYrX6cMWFYgszjwvUUA1a?=
 =?us-ascii?Q?GVOYORmmE2xVky3tWIqZpdlaHMT0Qj2ZKntZ6xMVNtY9Bz/KczC4bxD00egA?=
 =?us-ascii?Q?9FyKQ8xayW9x1bKg0PF04emvJSQioPfy12Mic6P0k+/+UE/JwfmecS/1w/SQ?=
 =?us-ascii?Q?wHMr3hjEp6UB3RyFXQv6WGg6nISh4smwlIrsceIe13u6fvpuc5qsm33Hf6Fd?=
 =?us-ascii?Q?6NQkDsa5DeEQLg3aULy9yvmEhIUmd+mw5izjujNfM2a07CmLx0tQGHUKx6IV?=
 =?us-ascii?Q?0g98QXmeDhPzI4bkTm2hDG9jSc4c7YWSyP/1MwFo98QS7sUHAUx08oqZkTkh?=
 =?us-ascii?Q?491Hho1SkLOhYT8R6YRFBLx1GdVdx8AkwPcWKChVMgHi8lSyTYQXtwgmHG+E?=
 =?us-ascii?Q?wG3f4On6qPRC4jPTUqtOfqhZGlPiKNVUXG982G1GoKtoLFqcGOcEETk02DZd?=
 =?us-ascii?Q?t0dhb9fSRHgmwtZ9FtzjRM1knZEXHgKFGklyVawgcp5lbOHDT7a2ArUqU4WG?=
 =?us-ascii?Q?xe3oDWFE6dyCN5AUi22c9GuV2JYe5k8Xhd9X+WBmnluIUrO05KITWF9K9Hge?=
 =?us-ascii?Q?md70Mb2u5cak0qwnMp13vidK6eb0NedXP23D4Xtekg6kScmfxh4OLi4Qhqll?=
 =?us-ascii?Q?etZuqBPSjBALUv7wEKOw1PmOT878kuk3dPBfYHXMBfSCe7lVucRg5DA8EkUZ?=
 =?us-ascii?Q?FBOuDjnxLdfzKpCy3KTPUmUsjRAMpI/GuHHEDmARiMFGeR3NsXLoF1XfXBeT?=
 =?us-ascii?Q?GXLdywkrEJvYGNyWQblsywzGUmQq7Wy+jtIVWU4FYAw8c87bXxi6kyi7SGBC?=
 =?us-ascii?Q?kyMQ2is2/gPim9Wi+Y0TfmrKD/As/TxmAIJqmef6IOchIHyzQ5R4Gh1boslF?=
 =?us-ascii?Q?uop+GtelNrH05NYVYNfLnFM5LjjUYEVokz45OuqEPWzBPhTJI0XMJm11qVCt?=
 =?us-ascii?Q?QEkQ5KWiGfA8cRAYzVTZGgZCrHKgaf+8KpvkbMrTkRK0ig2arky/XBrftH/p?=
 =?us-ascii?Q?zx6auCrN1YoE1ztpoYaghklnbrt1X0vOIlyO9VxFfwnOJ3ARcrkmfRmKN36n?=
 =?us-ascii?Q?DBIxive9mdW5Mi7QTCNzrb5E386YwEZg/QrKP5uKxRHf1Q1OCiDpbVtq3AQl?=
 =?us-ascii?Q?AOT/lmEIpkmOmabf9/dHuwIltnTYqSz9Xto7kz1CA+wKPbx+mYqxDjiai9NV?=
 =?us-ascii?Q?YDHGKYXKEwDmgYz/rvbslUds+54UbHrJB5Sg3SMnkvQS/X9QtYg7ZiM4qC43?=
 =?us-ascii?Q?hA2caF0dPlaVDWvT52G4jBoKPIrZn8A/vHDjyw7tqyply2zEWjplgS4X7zPk?=
 =?us-ascii?Q?/RNl0B6pItO688J3cV5KoQE3a9xNB1sBtiNjE3EEmw/WoAUghkVp4FjyTX4x?=
 =?us-ascii?Q?qsq8OpbzZmv1oeGh0l1aya0Fu2hHAPvT7kC2NawEvjS6P2pD8ssYvA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MpaJdPFsWrYXtyIfYknQ7n/n7sPN6eXpfQIeV6xCDZ6P9C061l9lpP+275M+?=
 =?us-ascii?Q?rOwZzCDbhix7JGZvy7/GmaJrsCV/bPsAdSzrVRZFtzWigIoOb67unK28fEPd?=
 =?us-ascii?Q?2eQ/pToI7ax+UA77WuXf2ESoi3r5eEtQ9mzwXuRh8F+TDNrSovwsX6vYxuDC?=
 =?us-ascii?Q?CmxWOkle1fP7/TwR7K/jIc0P1tTFHG5P0H4GGzWgJZBe+J6ZB+dc69tzlU7e?=
 =?us-ascii?Q?RWwqt0ZnoGQLm29fkgqboXutoY1UwIzdY0HT8B+zjXYjRFMPX47B18IF0ADb?=
 =?us-ascii?Q?wI7fjoJLybZopkt8myXXp+YYvbBlNzNXXwWnoUwyD5Pv9oK49IbLWZJZPYSN?=
 =?us-ascii?Q?soR0i2Zaq1I4pigckw/+CmIc0E+Jc2ozsAhH/Q/udnFGcGMxXWN7gc9/hjBw?=
 =?us-ascii?Q?x8OQEfRbFYrIa/NJvbJfDmjucptyIF3foMC10yFKvykva9g8gDCVnJnKqnXH?=
 =?us-ascii?Q?ZeYY/NTHHG3yDd18s17LgdfgFbjN3OYVcTEfBfRYiaRqChZAsbPxZsLEo5X2?=
 =?us-ascii?Q?cNqMBiq2cWQTyRBvXMRy4TErfTw8w++WClgHgUxgL83Jt7u5eRAh9DMtxbyw?=
 =?us-ascii?Q?Y4uyrSnIy7Fb2Fwi0vJ4pZDtelp7e7DOhzInL/I6wGLTVXZqsuGl4GWJT9/r?=
 =?us-ascii?Q?D7jSACz0QjYqpLnGdIEI+MiZiDcNkSClQDFQ3M9WdP1dcDYIBcd7DVAnHB4e?=
 =?us-ascii?Q?hu6FzPUhEGyxW/UjDQI8s9XtPLpvN4OnI89Mj8wuNOEbP/wbfD/LF3SIf3j8?=
 =?us-ascii?Q?n0HSvf9A3DWG0GllR2OevMONL3bXfsBXlszuouO6c07K4Pnp77LW7Yh1d67K?=
 =?us-ascii?Q?akBakp8FHbOjwOa3XwnFh0gSRALO2GlQPq3f5bUxHT9NlXd1PZ2oS/8xa7RX?=
 =?us-ascii?Q?Yrrf3khwA6MnqbqsyBIo2v1Uln6SjYguk5w5/mJkqf5CX3mGz/BLBhb2XbnB?=
 =?us-ascii?Q?nBZYatHNod0PvaziiAs/KeCmqGluwv8iMrITecE60hIWgs3aHXSQCoAVl9Dh?=
 =?us-ascii?Q?T0LdBw744DbT0TOZCIz5IWNccKRjiKqfiBB2tDPnSqCf2dyv5Wr/YAeucer3?=
 =?us-ascii?Q?1Ykzw3lJKk78gb0h4PXbH/ER3O+mvBpjNRlOJS+yW9KxJ6ffw5fT15jMazMs?=
 =?us-ascii?Q?xCD1UC3ATyWmouj6L0Ee96Nq+YR+k0EbkOrTHDSFAjxcT5Ggh8uKCaQbIWWp?=
 =?us-ascii?Q?zHYbNWsmMZ0JEr8ho4d1Q2VMUhVpiBQjwlHojjVdr9vNrX78VE7tqTwudQzc?=
 =?us-ascii?Q?UbiWfnpm61sAcqivBcceLqGRhfqwj9OPJfl07vui9zQmt7EyCqFrp6F2pln1?=
 =?us-ascii?Q?2dkWY7zIQTqDg+vYH/t44RN9hbqedjdH81uBmnfLDPHMIf8uq/CkmvPbsKyk?=
 =?us-ascii?Q?1WU24Ehy0f0LGotxw7nulzGfkrqZHFM0kLUG4dmLklkj09P7OR7/gL4ktGxP?=
 =?us-ascii?Q?CkKnAjpOPaw6tf/8YPOu6y2tByb4DMZdAd9b2WGdG7gETGDkX7SJmMSIbpK3?=
 =?us-ascii?Q?iCvh7iyn1bzNxYp+kE33rYlRGr5jQmUwKUxlmmoGAozv7fn3jpy32+ZepM1w?=
 =?us-ascii?Q?Cen0WiS3BPIYco6F663Cg68OCIBNjwM9LJUhsxWe?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1947c620-4922-4ab3-228d-08ddc38de212
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 10:53:50.6874 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSJhEiw1HGkx2aDuI4CI3FTJphRsh/7tIgpSDDeDxQkjmfunMN+BViB4Ceqjz9VyS12Rfs3TzeP2Fo/ls+VUjIuuRH9c9wr/rTMo913ARHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
>From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>Subject: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
>SMMUv3 to vfio-pci endpoints with iommufd
>
>Accelerated SMMUv3 is only useful when the device can take advantage of
>the host's SMMUv3 in nested mode. To keep things simple and correct, we
>only allow this feature for vfio-pci endpoint devices that use the iommufd
>backend. We also allow non-endpoint emulated devices like PCI bridges and
>root ports, so that users can plug in these vfio-pci devices.
>
>Another reason for this limit is to avoid problems with IOTLB
>invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an associated
>SID, making it difficult to trace the originating device. If we allowed
>emulated endpoint devices, QEMU would have to invalidate both its own
>software IOTLB and the host's hardware IOTLB, which could slow things
>down.
>
>Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
>translation (S1+S2), their get_address_space() callback must return the
>system address space to enable correct S2 mappings of guest RAM.
>
>So in short:
> - vfio-pci devices return the system address space
> - bridges and root ports return the IOMMU address space
>
>Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.

So the translation result is a doorbell addr(gpa) for guest?
IIUC, there should be a mapping between guest doorbell addr(gpa) to host
doorbell addr(hpa) in stage2 page table? Where is this mapping setup?

>Hence, if a vfio-pci device is behind the SMMuv3 with translation enabled,
>it must return the IOMMU address space for MSI. Support for this will be
>added in a follow-up patch.
>
>Signed-off-by: Shameer Kolothum
><shameerali.kolothum.thodi@huawei.com>
>---
> hw/arm/smmuv3-accel.c               | 50
>++++++++++++++++++++++++++++-
> hw/arm/smmuv3-accel.h               | 15 +++++++++
> hw/arm/smmuv3.c                     |  4 +++
> hw/pci-bridge/pci_expander_bridge.c |  1 -
> include/hw/arm/smmuv3.h             |  1 +
> include/hw/pci/pci_bridge.h         |  1 +
> 6 files changed, 70 insertions(+), 2 deletions(-)
>
>diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>index 2eac9c6ff4..0b0ddb03e2 100644
>--- a/hw/arm/smmuv3-accel.c
>+++ b/hw/arm/smmuv3-accel.c
>@@ -7,13 +7,19 @@
>  */
>
> #include "qemu/osdep.h"
>+#include "qemu/error-report.h"
>
> #include "hw/arm/smmuv3.h"
>+#include "hw/pci/pci_bridge.h"
>+#include "hw/pci-host/gpex.h"
>+#include "hw/vfio/pci.h"
>+
> #include "smmuv3-accel.h"
>
> static SMMUv3AccelDevice *smmuv3_accel_get_dev(SMMUState *bs,
>SMMUPciBus *sbus,
>                                                 PCIBus *bus, int
>devfn)
> {
>+    SMMUv3State *s =3D ARM_SMMUV3(bs);
>     SMMUDevice *sdev =3D sbus->pbdev[devfn];
>     SMMUv3AccelDevice *accel_dev;
>
>@@ -25,30 +31,72 @@ static SMMUv3AccelDevice
>*smmuv3_accel_get_dev(SMMUState *bs, SMMUPciBus *sbus,
>
>         sbus->pbdev[devfn] =3D sdev;
>         smmu_init_sdev(bs, sdev, bus, devfn);
>+        address_space_init(&accel_dev->as_sysmem, &s->s_accel->root,
>+                           "smmuv3-accel-sysmem");
>     }
>
>     return accel_dev;
> }
>
>+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool *vfio_pci)
>+{
>+
>+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
>+        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
>+        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
>+        return true;
>+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
>+        object_property_find(OBJECT(pdev), "iommufd"))) {

Will this always return true?

>+        *vfio_pci =3D true;
>+        return true;
>+    }
>+    return false;
>+}
>+
> static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>*opaque,
>                                               int devfn)
> {
>+    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
>     SMMUState *bs =3D opaque;
>+    bool vfio_pci =3D false;
>     SMMUPciBus *sbus;
>     SMMUv3AccelDevice *accel_dev;
>     SMMUDevice *sdev;
>
>+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
>+        error_report("Device(%s) not allowed. Only PCIe root complex
>devices "
>+                     "or PCI bridge devices or vfio-pci endpoint devices
>with "
>+                     "iommufd as backend is allowed with
>arm-smmuv3,accel=3Don",
>+                     pdev->name);
>+        exit(1);

Seems aggressive for a hotplug, could we fail hotplug instead of kill QEMU?

Thanks
Zhenzhong

>+    }
>     sbus =3D smmu_get_sbus(bs, bus);
>     accel_dev =3D smmuv3_accel_get_dev(bs, sbus, bus, devfn);
>     sdev =3D &accel_dev->sdev;
>
>-    return &sdev->as;
>+    if (vfio_pci) {
>+        return &accel_dev->as_sysmem;
>+    } else {
>+        return &sdev->as;
>+    }
> }
>
> static const PCIIOMMUOps smmuv3_accel_ops =3D {
>     .get_address_space =3D smmuv3_accel_find_add_as,
> };
>
>+void smmuv3_accel_init(SMMUv3State *s)
>+{
>+    SMMUv3AccelState *s_accel;
>+
>+    s->s_accel =3D s_accel =3D g_new0(SMMUv3AccelState, 1);
>+    memory_region_init(&s_accel->root, OBJECT(s), "root", UINT64_MAX);
>+    memory_region_init_alias(&s_accel->sysmem, OBJECT(s),
>+                             "smmuv3-accel-sysmem",
>get_system_memory(), 0,
>+
>memory_region_size(get_system_memory()));
>+    memory_region_add_subregion(&s_accel->root, 0,
>&s_accel->sysmem);
>+}
>+
> static void smmuv3_accel_class_init(ObjectClass *oc, const void *data)
> {
>     SMMUBaseClass *sbc =3D ARM_SMMU_CLASS(oc);
>diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
>index 4cf30b1291..2cd343103f 100644
>--- a/hw/arm/smmuv3-accel.h
>+++ b/hw/arm/smmuv3-accel.h
>@@ -9,11 +9,26 @@
> #ifndef HW_ARM_SMMUV3_ACCEL_H
> #define HW_ARM_SMMUV3_ACCEL_H
>
>+#include "hw/arm/smmuv3.h"
> #include "hw/arm/smmu-common.h"
> #include CONFIG_DEVICES
>
> typedef struct SMMUv3AccelDevice {
>     SMMUDevice  sdev;
>+    AddressSpace as_sysmem;
> } SMMUv3AccelDevice;
>
>+typedef struct SMMUv3AccelState {
>+    MemoryRegion root;
>+    MemoryRegion sysmem;
>+} SMMUv3AccelState;
>+
>+#if defined(CONFIG_ARM_SMMUV3) && defined(CONFIG_IOMMUFD)
>+void smmuv3_accel_init(SMMUv3State *s);
>+#else
>+static inline void smmuv3_accel_init(SMMUv3State *d)
>+{
>+}
>+#endif
>+
> #endif /* HW_ARM_SMMUV3_ACCEL_H */
>diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>index bcf8af8dc7..2f5a8157dd 100644
>--- a/hw/arm/smmuv3.c
>+++ b/hw/arm/smmuv3.c
>@@ -32,6 +32,7 @@
> #include "qapi/error.h"
>
> #include "hw/arm/smmuv3.h"
>+#include "smmuv3-accel.h"
> #include "smmuv3-internal.h"
> #include "smmu-internal.h"
>
>@@ -1898,6 +1899,9 @@ static void smmu_realize(DeviceState *d, Error
>**errp)
>     sysbus_init_mmio(dev, &sys->iomem);
>
>     smmu_init_irq(s, dev);
>+    if (sys->accel) {
>+        smmuv3_accel_init(s);
>+    }
> }
>
> static const VMStateDescription vmstate_smmuv3_queue =3D {
>diff --git a/hw/pci-bridge/pci_expander_bridge.c
>b/hw/pci-bridge/pci_expander_bridge.c
>index 1bcceddbc4..a8eb2d2426 100644
>--- a/hw/pci-bridge/pci_expander_bridge.c
>+++ b/hw/pci-bridge/pci_expander_bridge.c
>@@ -48,7 +48,6 @@ struct PXBBus {
>     char bus_path[8];
> };
>
>-#define TYPE_PXB_PCIE_DEV "pxb-pcie"
> OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
>
> static GList *pxb_dev_list;
>diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
>index d183a62766..3bdb92391a 100644
>--- a/include/hw/arm/smmuv3.h
>+++ b/include/hw/arm/smmuv3.h
>@@ -63,6 +63,7 @@ struct SMMUv3State {
>     qemu_irq     irq[4];
>     QemuMutex mutex;
>     char *stage;
>+    struct SMMUv3AccelState  *s_accel;
> };
>
> typedef enum {
>diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
>index a055fd8d32..b61360b900 100644
>--- a/include/hw/pci/pci_bridge.h
>+++ b/include/hw/pci/pci_bridge.h
>@@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
>
> #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
> #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
>+#define TYPE_PXB_PCIE_DEV "pxb-pcie"
> #define TYPE_PXB_DEV "pxb"
> OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
>
>--
>2.34.1


