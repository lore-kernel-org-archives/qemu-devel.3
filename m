Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336EFC83F27
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Jul 2025 06:27:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubvbA-0008Nr-UV; Wed, 16 Jul 2025 02:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubvau-0008Go-O7; Wed, 16 Jul 2025 02:26:21 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1ubvao-0002bj-9p; Wed, 16 Jul 2025 02:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1752647174; x=1784183174;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=Ov+MIJwHmykzTn1Cc2OKzbd5Z3dnRGK93Jkqjgv8JWs=;
 b=PGzx1/kVYeJr5tuL8kLVFrg6jmweOW23FI9NdNHY2mJZHgWnu5ZCwzDx
 L5aWRr0MDXgnkLf4iG6LKFpuf7IZfHxMbUM0nfXluRSMyp3lbCcks+Gd3
 Ls4hxTWfiaw2iWFZRD6ArSiFOIB+HhjRrOthX4+UGSrj/hXrQWz13oOUI
 949pTkqxECpVk2195PHkkNQc4X3lkgtM8tgasu7xZT+tju4iAsVD5e4F0
 JW+dNblcsOx0+g4ANK/WF989pIUIhJibZ3RSrBm29tBaVQBiWhhmxheD4
 R9iSH/Os1vMDUW3iiABvnuYz6nExl8BW4S5yckLvRPoG/gjXNlIt4uxvg A==;
X-CSE-ConnectionGUID: SnXzcuExRgyxZ5k4FLNatg==
X-CSE-MsgGUID: zIKimhrQS9G+X9rFx91Vag==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54818890"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="54818890"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:26:08 -0700
X-CSE-ConnectionGUID: HPVqbcbfTOSH+AiYF/cXaQ==
X-CSE-MsgGUID: EKGcYN1iTpSidnaNXXikjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; d="scan'208";a="158144895"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2025 23:26:07 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 23:26:06 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 23:26:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (40.107.236.51)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 15 Jul 2025 23:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKvy5z2fmV57XxbL1uoZOkfWzlGRUm5bOXnEmZR/+NGdMWuVfVSAD0XITfcfer7haEw3GgkhB4AcC6JbQoCX7xRBtbTjg7PgI/u6/7IUmCyjmQF5zruFFF89oSEo5+xRo+KYozNc2Tqy1Kb4HkIkVSqmcYEvl8hVe6doY8wXOIJacpcYKCvfNLpFMpAj1EwrMIcXyuOL6FMneUtphDOf1/83CfLnLFPY8qnSBwKrEBE+ciYoRu06tUuW8Aw3KdpwCbfyOOQwz3mWhZkDhDMjK6DwxU+ydVlt2JnwQSSDJ+3CR9WL/JzOdXDKe2+V7QnqG2OlyPy9acJeip1JFIERMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efZK6EOjyBa7Y4Hg40sMJgZq6GZyuE2BiP1PIxEViCc=;
 b=PDHz9PTQUmFwpSBVi6Ws7akpb8ftkHy6E7L2Exq1E6QZmEJCDktEyBSx8r1yxRJm/YSyBWznuxkGJ7PQgc9KnQUheaF1vc9/3us3pMmCVX8hMB9/KhP8enOFIHV9H4DDOw7cFCdLW9B4MDlTIldjhkHwS+7ajRleSZApgvkDhej9pza4m4OhpRq25vJ8RFvcECZvyrLIo6J/0HgB5AriYfGmvUqRkeSOD6CNB5dm5oUdzQWyfkAHyz6DCJzoDQmudlOULfB9V0MO9htLvP9fhsNOHrWQjtpEmyRS0OjudEJGniDnARQ7Hz0R1qDxlUxp7MYXOicQfviJbPgiYilmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 06:26:03 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Wed, 16 Jul 2025
 06:26:03 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>
CC: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>, "nathanc@nvidia.com"
 <nathanc@nvidia.com>, "mochs@nvidia.com" <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>, "linuxarm@huawei.com"
 <linuxarm@huawei.com>, "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "shameerkolothum@gmail.com" <shameerkolothum@gmail.com>
Subject: RE: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Topic: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict accelerated
 SMMUv3 to vfio-pci endpoints with iommufd
Thread-Index: AQHb9Nia/FYvy/Va1kO7Qt3Wn+Al1LQy3OPggACdxwCAAMPz8A==
Date: Wed, 16 Jul 2025 06:26:03 +0000
Message-ID: <IA3PR11MB9136E0D793F99E3837D208229256A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250714155941.22176-1-shameerali.kolothum.thodi@huawei.com>
 <20250714155941.22176-7-shameerali.kolothum.thodi@huawei.com>
 <IA3PR11MB9136A660E9FAE540037986FB9257A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
In-Reply-To: <aHaW9IpjbaVcRUpA@Asurada-Nvidia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SN7PR11MB6604:EE_
x-ms-office365-filtering-correlation-id: 8d037103-efc3-4cd7-1c5b-08ddc431a3b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?JbIW2fRU+azUhwIvkmSgK2X25nB3BaB9PUFe8VIUgMJTngYRHrm6h+h1tLTK?=
 =?us-ascii?Q?dvrWBXoaobgaRhhvTOMj3JmgjoJKoM75QUV9Edziuzizhi1ffHXtggsYRO9w?=
 =?us-ascii?Q?faa6PfglT2kI/60eYbfN3GTIye4Ju1JlQ/lKqBZLBGJCJ/GM9F8yPrvAR6yM?=
 =?us-ascii?Q?QG00bFXwHrptMK3OsvAbjfBso5MTDo9GYyxwsKnB9CeK66yniNkRqFTReSXn?=
 =?us-ascii?Q?LliM6X4ZSeLshDvyLAI0I3od/BZF+oi2r6e+YgIf4SaZXEKu3XQ2l4TTJ79d?=
 =?us-ascii?Q?ZsU3/qniG+qJ8LT7UNN9NB0zeI4VKwqodXdOFrGtn83NVdIWvKfwZeBC6DlX?=
 =?us-ascii?Q?4S5MANiJiZ2B/ltE/DODtX42lvLOMTumkikrcXjXUNxeBU9Y3WCU5vj/HUen?=
 =?us-ascii?Q?lWFLfwjVt98zPma2fpsIJL5sKbgVrmE5UWHPTqo4hzZ7tP3pEK0w8iIVeeSD?=
 =?us-ascii?Q?oT/R9hN/6TDtlBWZCrqt1hH2IkD5BRJ3KKdQwy5Kh5ozZ3EImWSv6OpTqck1?=
 =?us-ascii?Q?IFCFDqproM9yYQq60C/z3eeARC3Wc8QFh4MmT2i9nkQMdsy4v9GKuO+8eVoL?=
 =?us-ascii?Q?jjp/XPsZYFyHRPmEVtdeX27B9+zpyKRP7lw5BXl3KR2FkkqS30izp8rXeQGy?=
 =?us-ascii?Q?v1S4a1H3u2hkknZrvazBMVILCjNaUJKyp4dbVwLsOe/e5EGa8kUWDPuvZmk7?=
 =?us-ascii?Q?TjGeXtMlVyidD2D1XTl0ucR8XPcMMmIxt2xHDvdI04lPyWUle57B+wJJcy5G?=
 =?us-ascii?Q?DfZiwUteEq7hGnsliDO4aJBNckDUotb2k8XruuXjL93N+1EzuzPHBmRKrKVN?=
 =?us-ascii?Q?Xh+i+HaWQCn8/c7geHDpTmYkJmkM3ezGkLgyGQt/ouqIWY6pJAqrxzjq+Rqz?=
 =?us-ascii?Q?HEnKCZcRvVrC6A8l2Ahm+NtIO5y9x+uHY3UOO4dv3vfbtybQiti4zRIuLHdr?=
 =?us-ascii?Q?a8j//N4NIbuxTnmhJdL40rE8zIKKvj7pNusQkRWncNfxlSp7CjQvwuAYXaz1?=
 =?us-ascii?Q?YlEhhDb6VCS9PB3AWb0PdUg2hcZas888Nn/hs3KJwCO6YTRblZND6M/9OUdp?=
 =?us-ascii?Q?Hwdr7xEN23GD/UIvAfSP6KLz/P1++z16O8Br1dMAn9jdRHK7a+O4xdFiYXUL?=
 =?us-ascii?Q?mn4ZMG34y0MLNGQGAiKMcg4lSRaSTQvHmmAO4BcTpnZPyrfqQoXk83BB+asc?=
 =?us-ascii?Q?GFCn1y5qzSfjF8BpOw6WaEsb9C0ZsK7B27i3GBu3J0B5zFX28Oaki2SJ2eMa?=
 =?us-ascii?Q?WLwvpKXont5xR5Iyh9CdL1bhfUMyQMJZIHvdZLRBpUSCzQDk5i6pDiMON9i+?=
 =?us-ascii?Q?N35xpvuL4wVjUhVh3Iu9kxuGbzKQ9uJOWL2Je9QCbz1bn3Er7mSm+xYX/3k0?=
 =?us-ascii?Q?/IGG2CXqbf4H0msRnuQJiVsVRFaL0jKWba1cBOIe7LNrqgkeSFNcHp73Hf63?=
 =?us-ascii?Q?d1h2hYPccxVQVEE9M9OzOfWbX6OhDG25g7ECsKt0MFuCVNpnsFCMEVECh1NQ?=
 =?us-ascii?Q?rbkQK8WdeGf6z2w=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T15eveIV/jEcdFREtBow5Hu/Ghg0IqLM3N3Lvn0HW2hcb2YsTnNb82vQmNGP?=
 =?us-ascii?Q?MzgPa7VUOrPDdMpxv0I2k9ZY0KoqQVAYAvbHrkW9zSVZ6YgBWdZM1871VntO?=
 =?us-ascii?Q?fwatZNElBQQjJngNnWtfTspM1m/cX7zoItPzcdna61kmXh1cFtfuGj3QM0WW?=
 =?us-ascii?Q?86ag1wF16qcESzCC3OaBFqR7N2NKW7AAeIbdoeXwwqNbOwM/T+uexpHsz3/1?=
 =?us-ascii?Q?KyCKfIBPRUz/lpiryGpuejRr45lfLKyLrFUMHTHMCVOIHrxGJS7uoC2Y6JWk?=
 =?us-ascii?Q?Nrpdxnaap+CZ91tD5h5zPjdUCzjtiMrhGxcc6HXGROnruKSRqmRQwnOR3p7I?=
 =?us-ascii?Q?KlaxdSp/Xh+kBP5FObTDWh0hKGCYVAkJv8ZGiCaIpF2LCT8trILNGpOsebCx?=
 =?us-ascii?Q?yc+mfI7hYa4i9XWyoua3xsRJppnYa83OWU0LSy6AB9zaVrSUyS5+RJH+7xXH?=
 =?us-ascii?Q?tYapDbFiQQoIhRCD+O2xE3PF3cJSTj47Es/diuKjQmmeK+/KaTlA78dpoYyh?=
 =?us-ascii?Q?XFhlGxgeF/Ol8UAqIF2rRkgvnFUJuasx+sO36O2NvEeCC7CFawYiFFORngMt?=
 =?us-ascii?Q?wjUxUa28imPB1IIV2A0ZHbinAHn80vAlCi88S2ae2kwP2v0bCzO2MdGeCUT7?=
 =?us-ascii?Q?jmXxJBn98BxZ6bmZut+/01RbL/jeBB1GWk3l6X5iV7nwWEFbwhFtRvfIPUIR?=
 =?us-ascii?Q?v29r8+OUUyNUr6KZNAktCCSzgSseAPOPTjSsIehF+nP2GafHUlA+3UUwc2AP?=
 =?us-ascii?Q?u0YLMlT9FwrNlgmppIISB2dU2nPyR3EecxhzkOfrdJtvraNqY+9LN+KiN8MJ?=
 =?us-ascii?Q?AIrOqfRYDlZJ5jPEJWDWjrrg74dlQbIa54/nUq57IcgSKCa34/1yUbgU3ysc?=
 =?us-ascii?Q?ZP4ufcVgfvvkBauDhCq0ZHlIOUcrG4W1A8VE8qZ+q/7bGSIsjvVaffLDIOrQ?=
 =?us-ascii?Q?iRe/vog8HXYvAYPfMk9RWsl1TZnPfY59knV7zDzPhZ7BHmppQgfvuLjb3k67?=
 =?us-ascii?Q?DCZIpsRlKhh7BpSoocFQEw6oLO8+DsWhzIb5rKbQ66+64yLSS2qFgzI4HAri?=
 =?us-ascii?Q?K90kSjBcpGwqrjPndoZuwiuF6p244ls4av+tvcqphAnUzgVjn/0jemCF3Y8r?=
 =?us-ascii?Q?JkRuQoTNEu7GG54mzANhhBwks6fAvRsCEGym2hKb98tSFWp3r/qscesxGCWO?=
 =?us-ascii?Q?gHWcm/+BSd+KgNPrkWi+RYcMhv/7W/9+LWktDI83CM/cusAs1CO7yjozGQoH?=
 =?us-ascii?Q?twuOTJb9ds+jS0DXg2yC2LslGfLM2p1euHpriBF6+BTkRQpnrh5mmswDmp3j?=
 =?us-ascii?Q?0E57neybg4zdTZ46QADUelQhIbKBD3xwv9N4mzxB+/cFXvnsedgvcuTH5Bcy?=
 =?us-ascii?Q?razFCcJcq0fUmQ2ZqYYuvhtFUSyNgAt3duFfAPk4QhYOHN5uqHneWPCkiJTr?=
 =?us-ascii?Q?9rbIsnCnNC7/Qt6LT+0wy0BPIcMoJ8hRue/gwf5gs95Aynr7T1OySAIdvw0G?=
 =?us-ascii?Q?kd3IS6ACyA4NftG5LHDp8BpaNlCSyuHxeJtTwKaDR4O1MmXdUblTcrrjbmWK?=
 =?us-ascii?Q?u3nQm5ZBHLcKAhV06AxeqPJW4F6/y3cQBdX3Le/D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d037103-efc3-4cd7-1c5b-08ddc431a3b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 06:26:03.5113 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0dwUceEXgqAuwHTl6SKpQxavg4/cktItVrzN7c724XTrde+8HMjg7KP9CtfINXGLPa42XGEdx+BN5XkAparY8b1he8X9cOv5AWx54yJd8vw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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



>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com>
>Subject: Re: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>accelerated SMMUv3 to vfio-pci endpoints with iommufd
>
>On Tue, Jul 15, 2025 at 10:53:50AM +0000, Duan, Zhenzhong wrote:
>>
>>
>> >-----Original Message-----
>> >From: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
>> >Subject: [RFC PATCH v3 06/15] hw/arm/smmuv3-accel: Restrict
>accelerated
>> >SMMUv3 to vfio-pci endpoints with iommufd
>> >
>> >Accelerated SMMUv3 is only useful when the device can take advantage of
>> >the host's SMMUv3 in nested mode. To keep things simple and correct, we
>> >only allow this feature for vfio-pci endpoint devices that use the iomm=
ufd
>> >backend. We also allow non-endpoint emulated devices like PCI bridges
>and
>> >root ports, so that users can plug in these vfio-pci devices.
>> >
>> >Another reason for this limit is to avoid problems with IOTLB
>> >invalidations. Some commands (e.g., CMD_TLBI_NH_ASID) lack an
>associated
>> >SID, making it difficult to trace the originating device. If we allowed
>> >emulated endpoint devices, QEMU would have to invalidate both its own
>> >software IOTLB and the host's hardware IOTLB, which could slow things
>> >down.
>> >
>> >Since vfio-pci devices in nested mode rely on the host SMMUv3's nested
>> >translation (S1+S2), their get_address_space() callback must return the
>> >system address space to enable correct S2 mappings of guest RAM.
>> >
>> >So in short:
>> > - vfio-pci devices return the system address space
>> > - bridges and root ports return the IOMMU address space
>> >
>> >Note: On ARM, MSI doorbell addresses are also translated via SMMUv3.
>>
>> So the translation result is a doorbell addr(gpa) for guest?
>> IIUC, there should be a mapping between guest doorbell addr(gpa) to host
>> doorbell addr(hpa) in stage2 page table? Where is this mapping setup?
>
>Yes and yes.
>
>On ARM, MSI is behind IOMMU. When 2-stage translation is enabled,
>it goes through two stages as you understood.
>
>There are a few ways to implement this, though the current kernel
>only supports one solution, which is a hard-coded RMR (reserved
>memory region).
>
>The solution sets up a RMR region in the ACPI's IORT, which maps
>the stage1 linearly, i.e. gIOVA=3DgPA.
>
>The gPA=3D>hPA mappings in the stage-2 are done by the kernel that
>polls an IOMMU_RESV_SW_MSI region defined in the kernel driver.
>
>It's not the ideal solution, but it's the simplest to implement.
>
>There are other ways to support this like a true 2-stage mapping
>but they are still on the way.
>
>For more details, please refer to this:
>https://lore.kernel.org/all/cover.1740014950.git.nicolinc@nvidia.com/

Thanks for the link, it helps much for understanding arm smmu arch.

>
>> >+static bool smmuv3_accel_pdev_allowed(PCIDevice *pdev, bool
>*vfio_pci)
>> >+{
>> >+
>> >+    if (object_dynamic_cast(OBJECT(pdev), TYPE_PCI_BRIDGE) ||
>> >+        object_dynamic_cast(OBJECT(pdev), "pxb-pcie") ||
>> >+        object_dynamic_cast(OBJECT(pdev), "gpex-root")) {
>> >+        return true;
>> >+    } else if ((object_dynamic_cast(OBJECT(pdev), TYPE_VFIO_PCI) &&
>> >+        object_property_find(OBJECT(pdev), "iommufd"))) {
>>
>> Will this always return true?
>
>It won't if a vfio-pci device doesn't have the "iommufd" property?

IIUC, iommufd property is always there, just value not filled for legacy co=
ntainer case.
What about checking VFIOPCIDevice.vbasedev.iommufd?

>
>> >+        *vfio_pci =3D true;
>> >+        return true;
>> >+    }
>> >+    return false;
>
>Then, it returns "false" here.
>
>> > static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void
>> >*opaque,
>> >                                               int devfn)
>> > {
>> >+    PCIDevice *pdev =3D pci_find_device(bus, pci_bus_num(bus), devfn);
>> >     SMMUState *bs =3D opaque;
>> >+    bool vfio_pci =3D false;
>> >     SMMUPciBus *sbus;
>> >     SMMUv3AccelDevice *accel_dev;
>> >     SMMUDevice *sdev;
>> >
>> >+    if (pdev && !smmuv3_accel_pdev_allowed(pdev, &vfio_pci)) {
>> >+        error_report("Device(%s) not allowed. Only PCIe root complex
>> >devices "
>> >+                     "or PCI bridge devices or vfio-pci endpoint
>devices
>> >with "
>> >+                     "iommufd as backend is allowed with
>> >arm-smmuv3,accel=3Don",
>> >+                     pdev->name);
>> >+        exit(1);
>>
>> Seems aggressive for a hotplug, could we fail hotplug instead of kill QE=
MU?
>
>Hotplug will unlikely be supported well, as it would introduce
>too much complication.
>
>With iommufd, a vIOMMU object is allocated per device (vfio). If
>the device fd (cdev) is not yet given to the QEMU. It isn't able
>to allocate a vIOMMU object when creating a VM.
>
>While a vIOMMU object can be allocated at a later stage once the
>device is hotplugged. But things like IORT mappings aren't able
>to get refreshed since the OS is likely already booted. Even an
>IOMMU capability sync via the hw_info ioctl will be difficult to
>do at the runtime post the guest iommu driver's initialization.
>
>I am not 100% sure. But I think Intel model could have a similar
>problem if the guest boots with zero cold-plugged device and then
>hot-plugs a PASID-capable device at the runtime, when the guest-
>level IOMMU driver is already inited?

For vtd we define a property for each capability we care about.
When hotplug a device, we get hw_info through ioctl and compare
host's capability with virtual vtd's property setting, if incompatible,
we fail the hotplug.

In old implementation we sync host iommu caps into virtual vtd's cap,
but that's Naked by maintainer. The suggested way is to define property
for each capability we care and do compatibility check.

There is a "pasid" property in virtual vtd, only when it's true, the PASID-=
capable
device can work with pasid.

Zhenzhong

>
>FWIW, Shameer's cover-letter has the following line:
> "At least one vfio-pci device must currently be cold-plugged to
>  a PCIe root complex associated with arm-smmuv3,accel=3Don."
>
>Perhaps there should be a similar highlight in this smmuv3-accel
>file as well (@Shameer).
>
>Nicolin

