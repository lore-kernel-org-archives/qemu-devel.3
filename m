Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F020FCFD376
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Nov 2025 03:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOpVt-0002yg-LB; Thu, 27 Nov 2025 22:51:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOpVq-0002y0-Bp
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 22:51:15 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vOpVn-0004t7-9s
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 22:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764301871; x=1795837871;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ixrK+GwPZJJIYmpYXEXD0nHLYvmGUYEumr/J5+39NV4=;
 b=knKnWyhegbfKauGxPwTLrc2JLgnViV/P9AiydLGiKGqThICniddZFfUB
 ELlyMlz237hiNhVsgrfO2RovySdjJDbmSDtuxl19I7wXdSNhIRn4CfrSB
 PWFgOOLedSqxtMWsTqKwps2tOAsx4kElwfVgef7LSMDUu2fiWGAjkpQWM
 7ygl/hwitQgqpzMdqrQ7snmdfX6TKtOV2fxGK438rnieOWGSCnmlmhf28
 F4Up+USK28E5lCeyqlI/e4gE6k7nXkI5XUTc4u62YU+jcriBWEyUOzyuA
 0TRICIbvt58ElNWs8wxL9PLu71PE+CGDF3GboR2Dm1Oi12JlQ7xgIjMUN A==;
X-CSE-ConnectionGUID: 1W+pY1aRQsWPlDDSHpPVnQ==
X-CSE-MsgGUID: 8q79l2VGQyuTOZ693VD2DA==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="88982228"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="88982228"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 19:51:08 -0800
X-CSE-ConnectionGUID: UMnPEkHLT7eiwaHMh3nlKg==
X-CSE-MsgGUID: o39kUf0gQOyxJepk61/m0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; d="scan'208";a="198318180"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2025 19:51:08 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 19:51:06 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Thu, 27 Nov 2025 19:51:06 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 27 Nov 2025 19:51:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5MLugDgEVY3Jbu08yAL6da0mDQx9hZbxaUj5vqnmirdHbTagRZBgORfpkz+LIFZuqU9qXxPjMPmmgw9/ZSru/dwFAUhNf8bU32nExL7lCoUu+apz3+Sh4Zaa3Zxdf/xTKHRsPjQm0Mcg6EMmjH8OL0mbE9jOpTv68XEccrCBmEsS2Z77NY6HUpLsYk6VxjZKee41/KO6Zqr5OQYGIUDRRiWgHgscg1rD36xPWlAjQZzI+mgGPw87wy9I2s1gkdq73Z5FUqqigOWg5llUinaNykAPt4J0TsSCQgTGEKWi7CaJXng9g2UpZlLtZNM32va1mjxSQ6XPlKkU5qI8ppevw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5A3dweU8a9le/qhvr36351G4LAfVCBe3Vd0SGI2UeU=;
 b=Qw7ZGYkrstg+XplE5U+G79R2XOdgUC4IZUJNjRBJkhXrtYMsv/0IV4l9nnAfoXqjp/uqy2yd9hsj7In4GvqEqKTbPrmslGXMtB74tXUMEf+I9L8Q8WeqYEfuBTY+DqZ/bpqQOLmUts8Mtoh6OmgHfgweld4jYRwB9Q2BlFeVwhESr2gy0hPSEj9ckkbUH9J9a44sEKFRFKH61hWP9J06coho/xWOwwUlshS3oI34u1BIVk1Q0xXdEx0wJjG/RLeOU1KJyVMFz9LiWe1D+EqX2Osp69h1g+LlIRwrOQ4wbugDt+CvkrVLO2Im6v3ozv7zXM8seV82YFciTNL7HN1mLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by PH7PR11MB6548.namprd11.prod.outlook.com
 (2603:10b6:510:210::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Fri, 28 Nov
 2025 03:51:05 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::687c:dd58:c4ca:ecfd%5]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 03:51:04 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>, "Gross,
 Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v5 6/9] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Thread-Topic: [PATCH v5 6/9] intel_iommu: Fix unmap_bitmap failure with legacy
 VFIO backend
Thread-Index: AQHcTtTJbJBFo1Ikfk++4595ZtNNBbUHlhTQ
Date: Fri, 28 Nov 2025 03:51:04 +0000
Message-ID: <DS4PPF93A1BBECDC64D1634DE1519ACD5E792DCA@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20251106042027.856594-1-zhenzhong.duan@intel.com>
 <20251106042027.856594-7-zhenzhong.duan@intel.com>
In-Reply-To: <20251106042027.856594-7-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|PH7PR11MB6548:EE_
x-ms-office365-filtering-correlation-id: ec124dc4-256d-4854-c9ef-08de2e315ae5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?6sdl1WsIf/HWwcEX0JEXaHGDzrenrs9ISDCq8ODpfDdRYBhKvHrxxzociInd?=
 =?us-ascii?Q?YTBIXd3S6C9W/TM8jsxtU42+F/xGXNidqu2kPCZZKdK70uoj0N7Xnubswd/S?=
 =?us-ascii?Q?3Y+8KQNhiMS8hk+U70/xKo+3qHtgum04mB14CCsE1lgeSlDfIle/U7BMEZ5o?=
 =?us-ascii?Q?sflLjEj3WjyfIZe4WXRXR4Zio2QEIf/TcG0QUWR8HSWcwYlSwkLreYE+1Zio?=
 =?us-ascii?Q?5G16gNgA3gPa4q+H6oYbiGcMLIp1nxZrCR8MyutS1FDab83F8dkrjWURduzc?=
 =?us-ascii?Q?lyY2eBtvTaDvSB9Zk84uKf5kFtDhMiRV+gxpzDiz4igmeRQWPfAbUAiXeQxQ?=
 =?us-ascii?Q?6RTqP7vlTCMbizsznpJRrJMDpZaFyVwiuQSoWe5nemxU8947WsNDFVqfOOYw?=
 =?us-ascii?Q?Ukbtvg5qTsbYWRsPzRXEsZ+ypiDA09LA5gyRdYRncMSUBXKTlqzaJWxKELMf?=
 =?us-ascii?Q?adzJ6RboDXwTKdq/ZMPdogMb+LYyYph4Pea2gvuBJa5eRiKUpL7Cyy58rizr?=
 =?us-ascii?Q?ajg/td+WJ3YSYIyxEURAQYBcg9QdAV1WVwUmv/Qj7AR9qerpA9FHjEo/yNJr?=
 =?us-ascii?Q?q8B0qpucKWDmMzlOO1bf0majB0EXNkK4fxX4080FBa03vH7dwXA2H+YR8AnT?=
 =?us-ascii?Q?ulmY//M4w+CrJ7Sli8GZwLVGaIIZYlU7iuAb43b+z3c3vveQCjpwDSGyE4s9?=
 =?us-ascii?Q?u2G0VW7q6sh49GJ3+NUli3kAooE8aw4BCVudXtd2o9GYMXGD6faYs6DC/vUb?=
 =?us-ascii?Q?/U95b7wyjZEmK1fz700OjOxp9Z8EU9SNXSALNBi08MUHxILREXgo+Vx1hrwx?=
 =?us-ascii?Q?8TEP36GoNsxBMmToxCgm/g4SwH9G1uFMH44SOch4wNlKF9RtjpGX4pxpaGnt?=
 =?us-ascii?Q?sKldwO8na3VmHcHD2WA265VS5Cq5Az7B5Px/hWLtrLMWLinHBgyQIuJtx8Rq?=
 =?us-ascii?Q?iKcek9LYlfY7C1nqD7hiC/TcYxhKKsJfqJJfqjRDC4eYTPneqEpK4i8AtQxJ?=
 =?us-ascii?Q?PPWnZJpRXLdwttjlhntRANq66E+ORRJNfwHdSIjCpfLq8Qgz6I5PO749hRm2?=
 =?us-ascii?Q?NyebJpF1RGnrsKx+1IQZ7MH6nPM1PeL3PqsKBL3CCWcr3Uqr6TLu5xheCq7n?=
 =?us-ascii?Q?DYthLEZQdsVpNRKcNwnvqaKUV/UgzyM5i/z4FkfLfJ2Yeeb/HzgJd2jw9QOE?=
 =?us-ascii?Q?cVCmMRTPSG0xMm3gbzrGyB6ozVmHjbsQpf3tqAmoawas8vLbyTlC+yxFuQEO?=
 =?us-ascii?Q?eCXuSo7y0X42mTdI5L4ZnNvScP0GNx/fNQDL6dG2jo1sWYVAhHZq5eRCxGjr?=
 =?us-ascii?Q?EfyNkrHNKesSlJezBNUeYCP8NfCWrvGzBZs5pZewCVGUSqs3dm2wd/I++nHA?=
 =?us-ascii?Q?L5b4wbS+VAD2WpKwOHoZtcRaV1n3tuwy+/9vbXdtqO2dJTJQCqIRkQEmpZJJ?=
 =?us-ascii?Q?8JebpZxDOnbVltljQSQzBeReYgKmBEo6zymMOf0HIf0BT+6fHDB9g/rBYxe4?=
 =?us-ascii?Q?qEyIqx9DL4w3Zye42Y5gWn63Ig+MuCUzI7or?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?otMKuWyiRh5+B8BovFGgrb7KIt8MTqlOShAYpr8nPsfyU4aIpBv7SZL0ad4M?=
 =?us-ascii?Q?qv0hkdah23vjCMqAaeAhDypyDVAryB+dheU7ZNco2c3LKOdPt2xK4rtk1zz0?=
 =?us-ascii?Q?AZId8krRtGfR6BePDvlsjq4CWrv7TGoDh4lHTespulNSrW0wX3zGRjajJzuE?=
 =?us-ascii?Q?6IVSmVPgWNkUkQcheXJ84q7cuSdBSCrbQSrEzD/Pqvuh1h0ZDRAcnZ9RJenS?=
 =?us-ascii?Q?1vxdMpqCgpuBgENPV9IYE1cOIt9xmnCYvXmIlTPt5mI/UnzRUpM0AFbpVQLM?=
 =?us-ascii?Q?4UmemQyUhiaanDj9tn73l15cQSkqoVQgn+C1FZVoWmKZiIPUihvf/a7PacRO?=
 =?us-ascii?Q?Z0tYFikJ/dVWxTKy6lX29IsR51+4/hLusc560s6Q9eQvf0znFV9ljjn2pqaM?=
 =?us-ascii?Q?0zauNxv3S84E9rFa/swXU1UAhJtcnGVTxij6XQHauYTqPHxHfCxr2gvecImN?=
 =?us-ascii?Q?2dRs+c/rzJRWNtGP/whOVM9Sx+6x9c9x3cyKhcJwe0HwcN5sEUmXJCNZEO41?=
 =?us-ascii?Q?sHWvSe0IvGPzwHlthmOobkalx7C9rwMfvyBKqnBJeFgdP3cGLJVHNAojGrte?=
 =?us-ascii?Q?PwF6APfJJfOssyIdJwWhlI3Ukf3yF7wXojAswydvqERXMm/3mHZIPQJYJ8kB?=
 =?us-ascii?Q?NZbXE1Ij+OJX7aTPVzp9YQWTb6a4Duuh+HSNcPF1guK3/NxTE4rlrNFe7WJ4?=
 =?us-ascii?Q?cR1kjB2w4LZHc2AIu7YFLAr6xTEzPdi6TEcgCpFM+7IlC/WaI7j3ePu/VZgo?=
 =?us-ascii?Q?2uuls1CsTzBkO+/mcSzMQojC/hyktYEBzJ7gs5p3Zfx+LNgWnoov9vrPNHoW?=
 =?us-ascii?Q?YIGZJcGrIxzgNViDA2vQRVQSnWmE9Z3mDLzixacY9gbF6nOw7PcUcUrUEtPR?=
 =?us-ascii?Q?zW6iC2u5MDVEiqeVQAgJtHdn1fFYvrJgicmk/q4uCdvz6W6fGl3p7oHOHsCU?=
 =?us-ascii?Q?70nf2w3pcHyDY5gBBTpJUwx2oYgA0i5uqgK23iEYiofAWrg1/mCYq2vzN2c6?=
 =?us-ascii?Q?9f2nE9gWXDnUdK/Oc70a2oZR8+gjoElT5RIHUaIGclEiBHhTqcK/rU6XRJ/m?=
 =?us-ascii?Q?DKsqYZ2ALqm6WTo+Hhl5p3TnJPL3+gegTOfRXimN5xJ9z9hSdFEuzyKo/jhP?=
 =?us-ascii?Q?mCDKNUEGK+S122AWI530eA533HNtnd2yCoFJN9DJnk4a1F8D8EnbYI6KIztU?=
 =?us-ascii?Q?xEa4JLMWWJdHP91O7Spx7E2ft4drQNzHsHBC0bXBYzLR2yerx1zIf+Ax4hOS?=
 =?us-ascii?Q?Bpt1tIw4hgtaPeZRazeg91M9LYRfRC20GxIWgw8Ipo2vqDtCO2q7kBF/cKCO?=
 =?us-ascii?Q?a4EuCsK9ksVNgQAuhRJaOKTZ0FW0i9kucEef5X9DC11Q5CeCT5GwOtrm6onF?=
 =?us-ascii?Q?6j1O8zwV0+f0SNx7ehP47ftag6fQy/NWavHmr+D7svGLAruUl5EJUzRj9Gsm?=
 =?us-ascii?Q?SBPNrEq/dytypxacVdattYqXUYmvfrmm/jBIHRsUgEU5ZwOe9IbXPZTYbk7f?=
 =?us-ascii?Q?PT7VkYTU3D4k3efpOASuXh7+/tiZEwo2VDF/G/5ITJQ3ituJ+Elw+WEJ1AZt?=
 =?us-ascii?Q?gZ7wzlx8jgm1xFgDL1+6dqYQxMBWLEtAtW68rCyo?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec124dc4-256d-4854-c9ef-08de2e315ae5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 03:51:04.6009 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kwznV1OKdSnCjt42C2HrnQG6/4rNIQtQKsxPSCO0hvDPybAVyfmVaaB/jXIBB7PNLvc/IuUz7pE2F6kmfxm/mmB8izPaV0ube/yoTNobNzs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6548
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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



>-----Original Message-----
>From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
>Subject: [PATCH v5 6/9] intel_iommu: Fix unmap_bitmap failure with legacy
>VFIO backend
>
>If a VFIO device in guest switches from IOMMU domain to block domain,
>vtd_address_space_unmap() is called to unmap whole address space.
>
>If that happens during migration, migration fails with legacy VFIO
>backend as below:
>
>Status: failed (vfio_container_dma_unmap(0x561bbbd92d90,
>0x100000000000, 0x100000000000) =3D -7 (Argument list too long))
>
>Because legacy VFIO limits maximum bitmap size to 256MB which maps to
>8TB on
>4K page system, when 16TB sized UNMAP notification is sent, unmap_bitmap
>ioctl fails. Normally such large UNMAP notification come from IOVA range
>rather than system memory.
>
>Apart from that, vtd_address_space_unmap() sends UNMAP notification with
>translated_addr =3D 0, because there is no valid translated_addr for unmap=
ping
>a whole iommu memory region. This breaks dirty tracking no matter which
>VFIO
>backend is used.
>
>Fix them all by iterating over DMAMap list to unmap each range with active
>mapping when migration is active. If migration is not active, unmapping th=
e
>whole address space in one go is optimal.
>
>Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>Reviewed-by: Yi Liu <yi.l.liu@intel.com>
>Tested-by: Giovannio Cabiddu <giovanni.cabiddu@intel.com>
>Tested-by: Rohith S R <rohith.s.r@intel.com>
>---
> hw/i386/intel_iommu.c | 42
>++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 42 insertions(+)
>
>diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
>index c402643b56..8e98b0b71d 100644
>--- a/hw/i386/intel_iommu.c
>+++ b/hw/i386/intel_iommu.c
>@@ -37,6 +37,7 @@
> #include "system/system.h"
> #include "hw/i386/apic_internal.h"
> #include "kvm/kvm_i386.h"
>+#include "migration/misc.h"
> #include "migration/vmstate.h"
> #include "trace.h"
>
>@@ -4695,6 +4696,42 @@ static void vtd_dev_unset_iommu_device(PCIBus
>*bus, void *opaque, int devfn)
>     vtd_iommu_unlock(s);
> }
>
>+/*
>+ * Unmapping a large range in one go is not optimal during migration
>because
>+ * a large dirty bitmap needs to be allocated while there may be only sma=
ll
>+ * mappings, iterate over DMAMap list to unmap each range with active
>mapping.
>+ */
>+static void vtd_address_space_unmap_in_migration(VTDAddressSpace *as,
>+                                                 IOMMUNotifier
>*n)
>+{
>+    const DMAMap *map;
>+    const DMAMap target =3D {
>+        .iova =3D n->start,
>+        .size =3D n->end,
>+    };
>+    IOVATree *tree =3D as->iova_tree;
>+
>+    /*
>+     * DMAMap is created during IOMMU page table sync, it's either 4KB
>or huge
>+     * page size and always a power of 2 in size. So the range of DMAMap
>could
>+     * be used for UNMAP notification directly.
>+     */
>+    while ((map =3D iova_tree_find(tree, &target))) {
>+        IOMMUTLBEvent event;
>+
>+        event.type =3D IOMMU_NOTIFIER_UNMAP;
>+        event.entry.iova =3D map->iova;
>+        event.entry.addr_mask =3D map->size;
>+        event.entry.target_as =3D &address_space_memory;
>+        event.entry.perm =3D IOMMU_NONE;
>+        /* This field is needed to set dirty bigmap */
>+        event.entry.translated_addr =3D map->translated_addr;
>+        memory_region_notify_iommu_one(n, &event);
>+
>+        iova_tree_remove(tree, *map);
>+    }
>+}
>+
> /* Unmap the whole range in the notifier's scope. */
> static void vtd_address_space_unmap(VTDAddressSpace *as,
>IOMMUNotifier *n)
> {
>@@ -4704,6 +4741,11 @@ static void
>vtd_address_space_unmap(VTDAddressSpace *as, IOMMUNotifier *n)
>     IntelIOMMUState *s =3D as->iommu_state;
>     DMAMap map;
>
>+    if (migration_is_running()) {

Hmm, I just realized it may be better to check global_dirty_tracking instea=
d,
because dirty rate/limit QMP also need it.

Zhenzhong

>+        vtd_address_space_unmap_in_migration(as, n);
>+        return;
>+    }
>+
>     /*
>      * Note: all the codes in this function has a assumption that IOVA
>      * bits are no more than VTD_MGAW bits (which is restricted by
>--
>2.47.1


