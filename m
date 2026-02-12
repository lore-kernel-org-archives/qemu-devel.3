Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 369E8EDF04C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 07:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqR3z-0006bL-2A; Thu, 12 Feb 2026 02:24:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqR3m-0006Kr-25
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:24:22 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vqR3K-0005x6-Oo
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 02:24:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770881035; x=1802417035;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=AmTx+0JMimSsiHwL9rjmmK+KNMef3uxJ3V6oUPCFLCE=;
 b=Z1nriGnnqdxOvgd+TpE8Ejp1A64uEcEP6hB/pszMU1diUSaHnIvMIHcV
 BMxzrpggpkGePUI1VM650tvuM+kSlhVzY/tUM+XnXLOklgzswd3vwlp1e
 SfCYUgeSDaGHBjt8b4NbKeli8qIoPT5xJQ/qFColXmkBuhUd9jhgCUvaf
 QW3fGXKNARRDnCd+56bs3eORTEm6KF3zr/5Urlt2T5rUhI255JLza+vlZ
 cf9RNYiTSTU0xHg4oXm9AjDaJczDiXGrAjTtKV4S7jvoS57TSxgjhr2Vz
 7sf8bMnGajBW7MYsXfOoFXb10H0HNt2AjDy9OxbtGTKYONK8zpybaMo/L Q==;
X-CSE-ConnectionGUID: bCC6C/+UR764NDl8Y504rQ==
X-CSE-MsgGUID: 1WHhWkYVQGyvOyRZ++KXIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71942029"
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; d="scan'208,217";a="71942029"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 23:20:22 -0800
X-CSE-ConnectionGUID: c0URZj4STQy4gvDKD1g1Yg==
X-CSE-MsgGUID: 1ku2CWk5Qo+JkOKe5C1dcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,286,1763452800"; 
 d="scan'208,217";a="212533282"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 23:20:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 23:20:22 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 23:20:22 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.7) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 23:20:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FG8uhC909Q7ncI2hICOhAgwJfJ2VGQGEjl5mH+FpGhBRU8UtjpATEe6MPkCxVgFjAk8ohHx9pnkjla5ZIAtJ+a+VOAOo+mFAQHWbGbxi1SSjFxNePECFyha9wnJGXkIXqrvjgFMRTfgdFE9Tsq1sQDb0O43yi95RLCIcNAG6Fjiy9M0ITh2VugAGAqqYukk7gGDhk0WV3FXwPvSw1HDOHCF8ZoincTjXCtLMisbn+W+ZT8oozYT7sOLLQVEwKAFmtShs/I/f5uaJ75xNOFmDNhKYuSlzoWHvbFDw9kDue8cCi2s75aa5HUS1tIbwhHCbje6TNgXQ567VACxzCt4zhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8QdoFw5cp8rEGFop8y4yDa7tqOUtEqXoEnwCrq81rs=;
 b=Nkl0sz1al+t92zw2gx1yUBxwW7t+6m2XvGBxU+9gtg+/qRvbsiQG+XKUUtb3W7D3OFdoAUjsLC/NEhPPKipxN5coOeiAx/s9YirR2gN3QqEQZ4RHmnrtNtkG3FKNogWrlY6d23whD7kS8YBzo3y35/Rxn6nGwaDy0D/LrDCFsgRGnEZBDhQ1x4B0o+d6CiLhk8szVRCNtPnpaO1wpmglTlTcTVisrAhSI4i/a80cyV41kYlgHlVswDODU9rjyOjGi4L3o7lX02iKoQcacUn/IU4YbZBIdLuZqTGW2ue71PXyLynkSZtMVZgpwT58E4lT2cBSnSQbt8c4gCPlAhP9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CH3PR11MB7914.namprd11.prod.outlook.com (2603:10b6:610:12c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Thu, 12 Feb
 2026 07:20:16 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 07:20:16 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Topic: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
 callbacks
Thread-Index: AQHclk1HGYQZR/NqT0axcOYTjnZUhrV9Qo0AgAAOM0CAAHZtgIAABf4AgACWwDCAAEW6gIAAB+Nw
Date: Thu, 12 Feb 2026 07:20:16 +0000
Message-ID: <IA3PR11MB913687D1DB6FF5B0D813E6509260A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260205031133.74357-1-zhenzhong.duan@intel.com>
 <20260205031133.74357-2-zhenzhong.duan@intel.com>
 <CH3PR12MB754856C12CAD98891555C791AB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB91367D6A321018EE989FA1899263A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75482AF23DD73B2D37742AFDAB63A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <aYy+AENRSGdWh0Ij@Asurada-Nvidia>
 <IA3PR11MB91362AA3967AD60A6B27F95A9260A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <PA4PR07MB761339215913CDD1C65547718660A@PA4PR07MB7613.eurprd07.prod.outlook.com>
In-Reply-To: <PA4PR07MB761339215913CDD1C65547718660A@PA4PR07MB7613.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-12T06:44:46.296Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CH3PR11MB7914:EE_
x-ms-office365-filtering-correlation-id: ffed2ca1-c3e4-40f0-4e3a-08de6a072bfd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|8096899003|7053199007|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?jjs9OwUDfOG0Ard1HyMwESO5C4t8+uuGp8FFt27O5TNtzqNi9lG0WxzWmF6Q?=
 =?us-ascii?Q?e8HBBauzEbWYz5xSPwt+0afX/BRrQKA9pfPAB6g2HN1XQfkjc0okIdNgD37p?=
 =?us-ascii?Q?/O1gp77vxIMjjr+6L8lQAWh9KCymbs+uGGjVf/xb7hqiN5ol36tqKnAH8WVY?=
 =?us-ascii?Q?5eZI3+VQ/DPpLBJB5TkAkjs46RYIKrWXRgLyME+DzBCzDErpNomz2eFM+10h?=
 =?us-ascii?Q?MYVNqMiSZXzwmwmcOddxhhRcIeQG9gq7mmoKgICXgAZvu6kS7eJCTYM+o2Pg?=
 =?us-ascii?Q?pHtFgUB7XBXXJ1xFeF4uLrs4vTZceF0KWbBUq7msMZ2X1CW6nzSdXNGgUGco?=
 =?us-ascii?Q?5zUCnNlq+HWThTaqZ8P7D+4SJUBQd62cQv9k35XC1GTwRmX01HwXIzXIzA35?=
 =?us-ascii?Q?fpzG8dDdYdRPlGj6j0whzX8Uv3S6Am1k5tH5y+YPqllhtum88xS2D1vEw6Me?=
 =?us-ascii?Q?OQKv0RahP1Yp+3S5KgThVrQYu9LN1K5wc00JonMAVZ6u+sEpTyZXWSBXrBlo?=
 =?us-ascii?Q?MhvdyzIdlYEl1q2L8ipakClMVUz07Sfrcb2u4l7hiPuuQN0nCdunjIErkcK2?=
 =?us-ascii?Q?Jp0mSSGlCnjgw+vfwt3fjMPDjYGYq+ndjWJcN6EehgDQopTvIfvPCq3aNm0E?=
 =?us-ascii?Q?AHquDBgauLTcuqGKDhbPGIyu0NO4rgA6ulvvHRkGNwxMA9IwuNBiUbTFg3pU?=
 =?us-ascii?Q?G2/yaaFkaqLq7suV+WiiC17Hfnl3O9HLwqxjv/eJ0y9kgeatjTB1Mx2qXNeo?=
 =?us-ascii?Q?ZgA0Py6tKwRsPePnzskbquHOX1OP8vOxrXx6uXCCk/XZBXggXKu4i64jEWxS?=
 =?us-ascii?Q?OgHeKAyLt+EI2X0BgTC5ck7VCdrYHOWXdWSEWKzRg5mjb/HdvMWggHfKdqtU?=
 =?us-ascii?Q?jQCkUghPnqF2vNmnpgoMtJ4winGxcLTXImIB7TGY+n1+ZqqFnM9aH1tqqi/7?=
 =?us-ascii?Q?VoVmqOIS7ul0WM8o9aZZYHIyu28Qb1xmRnQNGcOeWx8IpV9DtYNp+usFoe02?=
 =?us-ascii?Q?upLJAMKZ7q8UqdVkUJGmgojMXngiyyCusnbNkwH67MT64j8EiqROL0pqqFaN?=
 =?us-ascii?Q?8ZUZP/NEThNJhl3cWf4BYCEUpxhIA2OPUca2laALiWG0J2CFcKgH8knDmODW?=
 =?us-ascii?Q?N2P3i7Efz1E0coG4yJYbIoX1/Spc0LNh+wLxMs0xnXFdBrZuhhkHrr9gOr7O?=
 =?us-ascii?Q?SviuB0LKj9peTCJD8sBdNQ3Z5b4F+gGHJkGJvc+Mx/H0vcz+UZqmV43hFCJc?=
 =?us-ascii?Q?TS/3PzEooM9+0f40xo9z80j30ViRYW7lhcTzhtukvd0BSbaQxjMOeeYkUD3z?=
 =?us-ascii?Q?f9qREHvyOtkpFF46w5xfOlikdSTatG3AWk7t3S9xPYHITa+XU7HWGfPgwdM4?=
 =?us-ascii?Q?Sh7tsRcjln6l0WBC5UuVWCe9PxiseDZMfcb4R+WyTjGZZ91CjtIIP9qRsbaT?=
 =?us-ascii?Q?tVS/riRZ6KcUWV6+GRYsHWQjss2y3feMU8cf1tgx2cn/S+DKk2ruoY1hsOvO?=
 =?us-ascii?Q?2cnjHM8dzt36D/oYWDht+vBfSdsdkKNw93rnUVMsWBUFB3KSECHNltHpt5qC?=
 =?us-ascii?Q?J5Wr05F/Yrnqo6g/Z0mjZXR8KptSHNTlNUqk4Gka698+XiRX8lioIWqEIIBP?=
 =?us-ascii?Q?UV6amNvqN7QDRAhCogdOMl0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(8096899003)(7053199007)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?50P6qrGXHfSitKmE1kmrYCRIVtkFh3ZbixSxjPSQmVBywWGSJ3lFE1UrMoXQ?=
 =?us-ascii?Q?yS9mNj72t8ZyWXkJeMlVaE753sQ+y07zga7CxaKZpkcKjU8YwTJqsjOAph5Z?=
 =?us-ascii?Q?2+y85GkWrdbK/xbclKSN6BpelQI7+jtH8/lVX1dAiRmED6Z1DJoY4dy5zCJt?=
 =?us-ascii?Q?LOyMk6gDtbN3CabYBBDoQQc6l0qOrwEAyqZCggi1qgm7cT8Z7ebH/iVlF0vD?=
 =?us-ascii?Q?imzcHWNOf1VW7kYiLjedjPb6zbjNl5caKhxASMLTLUVtTGxMywSyGsCzruCD?=
 =?us-ascii?Q?9fZ1NfnW3dsKc3j3Ah+IoC9cnNqChaNrJdANQRD+jDrjl/rK3RkjtT4nAd0/?=
 =?us-ascii?Q?Sz593v6TE0UMGITExK1Mhu1NCEELjKeQ3tTgfGOkWGRXRoedBiJ9DVjhGPJf?=
 =?us-ascii?Q?7NErNufb15U3crGHn7x28FVnR5WOh2goOOHULb+DaB++1yA4abv2zBTJD6VI?=
 =?us-ascii?Q?7wBETTpIcj9BiXYAMRDzFWJVyRTrZNUmeRQVkfOJEG4Qpk+x3JLLtNZHCREp?=
 =?us-ascii?Q?quLWUeL2XXsb3PCVhVmOZlw27A8eIqMnNCo7CbAGERuD0AKxtODepdAdGjeR?=
 =?us-ascii?Q?FcJKSAB0C0hSWfeqPRUXj5vmjpnrsd2c4ZX/IW6BOfBrp3nlGgPoKzKQ2l/V?=
 =?us-ascii?Q?3MoLw64aNVJdWRCeK7I9H+Slvobe+bB+9SQnn5eSfJ/ncx6wOadjEjlDiznS?=
 =?us-ascii?Q?KVwyR7Z6mkGdKiQg/+c2/72T6m1Sqz/AnHW4tFxIon/0nJlvF+fMvRpebP70?=
 =?us-ascii?Q?lxAbr32AUnzXjPgIJb0KT1ob3xvVLvhxqrCPoAyUoeaOHQCWhdPDP1C2a1fK?=
 =?us-ascii?Q?/D+cFYmxxINX+97nnKBKx+BjKe8/ozfednEwrZd+1Wwm8u51aXZr3DWLd9S3?=
 =?us-ascii?Q?d/RVArGYgKnUDyPbWl1sJXpV6aK8zMvxMeDXjsQ81Q93tXeEHtHxDPrCGfyd?=
 =?us-ascii?Q?SR0p7phti2t28haXp7DKx2i63sp29R4Ihn/MfGeHkfUfQ17rVdgzuEbFXidx?=
 =?us-ascii?Q?yM1f3yLIJ2isZHSNDHoa2WVFFIXdUNXWD0a9J70pfobsjskJ8YAt9vXek0Mr?=
 =?us-ascii?Q?y5hsqMKJqdBnvAoPRlhre74gSP+kLEWysnUZroYnGLV9gnW9o5mGli//DIsv?=
 =?us-ascii?Q?t5CfEWw6aVfRzf11Lm9uCLzyRSXkQ5O9hWzaQuZ/5zhoSVBDOUPldr/vCUF4?=
 =?us-ascii?Q?7/jBasWs3qaCl+PTZKcb1XYpPozoD0zLITx/xtZRXQavg7z/HxXC/aN3s9u2?=
 =?us-ascii?Q?3JVk/8lmTM+DnJF0LW6AcmoH30VU8CTEGZpstk4aSyeMlJb+cGcRKo87U420?=
 =?us-ascii?Q?t5PGacHa1h5GEnVvvXrroBn+OhtdfRWUjS8a9tum0oBb5qQO2zFKbi42pW7J?=
 =?us-ascii?Q?iGabsTd9LG63u+aejC7lpYtgDqkcErBYjKe6pbXHzsMygvN/Ws1xnQapbTTz?=
 =?us-ascii?Q?7FG4/Uqtm+/qaSJRqe21mFosUAriA8pgD8NO+eVPl15P2NUSDahW63Si/KhW?=
 =?us-ascii?Q?eBeyLitfPuc5rdTF7gSfdBIvhhv9L90TxRBHSo76Vp3cZQ01zOHxl8I/G4zS?=
 =?us-ascii?Q?SjnE+fqLNdKgoiz9PP/j3Ovq9HBm5zld6CzJJyV2xJ1ngAhMcitT0GYQWc5H?=
 =?us-ascii?Q?qWirWYx3lvJATGqznnC/fNm4i8hF5b8aBtvDyqL8O1Yb9Yr6sL6sWDi9QEJD?=
 =?us-ascii?Q?DCNdEuC6WvQ2AeY3ikLY2cYcpKY8Tsqq02015BzbnznYFQJwY9JBWlaZFXMA?=
 =?us-ascii?Q?fQf94dfU1Q=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB913687D1DB6FF5B0D813E6509260AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffed2ca1-c3e4-40f0-4e3a-08de6a072bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 07:20:16.8197 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0XsEHJAoCF/MQxET8njjLspntHUYdKKpRkhiheb+Qq5o5xHHLx1xuuRRNgGVZZvpjoMGWgQ0OLqtPFrOa/Jjoejo4nX9c83/P7ORmK7oCT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7914
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_IA3PR11MB913687D1DB6FF5B0D813E6509260AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

We could use PCI_NO_PASID (-1) but need to translate from PASID_0 to PCI_NO=
_PASID in intel_iommu,
IOMMU_NO_PASID(0) which equals PASID_0 looks more straight-forward for me,
I plan to define it in include/hw/core/iommu.h

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Thursday, February 12, 2026 2:45 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; Nicolin Chen <nicolinc@nvid=
ia.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: qemu-devel@nongnu.org; alex@shazbot.org; clg@redhat.com; eric.auger@red=
hat.com; mst@redhat.com; jasowang@redhat.com; Jason Gunthorpe <jgg@nvidia.c=
om>; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Liu, Yi=
 L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach ca=
llbacks

What about PCI_NO_PASID?

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel=
.com>>
Sent: 12 February 2026 03:43
To: Nicolin Chen <nicolinc@nvidia.com<mailto:nicolinc@nvidia.com>>; Shameer=
 Kolothum Thodi <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>
Cc: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.=
org<mailto:qemu-devel@nongnu.org>>; alex@shazbot.org<mailto:alex@shazbot.or=
g> <alex@shazbot.org<mailto:alex@shazbot.org>>; clg@redhat.com<mailto:clg@r=
edhat.com> <clg@redhat.com<mailto:clg@redhat.com>>; eric.auger@redhat.com<m=
ailto:eric.auger@redhat.com> <eric.auger@redhat.com<mailto:eric.auger@redha=
t.com>>; mst@redhat.com<mailto:mst@redhat.com> <mst@redhat.com<mailto:mst@r=
edhat.com>>; jasowang@redhat.com<mailto:jasowang@redhat.com> <jasowang@redh=
at.com<mailto:jasowang@redhat.com>>; Jason Gunthorpe <jgg@nvidia.com<mailto=
:jgg@nvidia.com>>; joao.m.martins@oracle.com<mailto:joao.m.martins@oracle.c=
om> <joao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com>>; CLEMENT =
MATHIEU--DRIF <clement.mathieu--drif@eviden.com<mailto:clement.mathieu--dri=
f@eviden.com>>; Tian, Kevin <kevin.tian@intel.com<mailto:kevin.tian@intel.c=
om>>; Liu, Yi L <yi.l.liu@intel.com<mailto:yi.l.liu@intel.com>>; Hao, Xudon=
g <xudong.hao@intel.com<mailto:xudong.hao@intel.com>>
Subject: RE: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach ca=
llbacks

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


>-----Original Message-----
>From: Nicolin Chen <nicolinc@nvidia.com<mailto:nicolinc@nvidia.com>>
>Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detach
>callbacks
>
>On Wed, Feb 11, 2026 at 09:14:33AM -0800, Shameer Kolothum Thodi wrote:
>> > > Have you considered extending attach_hwpt() to
>> > >take a PASID instead of introducing a separate callback?
>> >
>> > Yes, I did. To extending attach/detach_hwpt(), we need to add two
>> > parameters, "bool has_pasid, uint32_t pasid". E.g.,
>> >
>> >     bool (*attach_hwpt)(HostIOMMUDeviceIOMMUFD *idev,
>> >                                          bool has_pasid, uint32_t pasi=
d,
>> >                                          uint32_t hwpt_id, Error **err=
p);
>
>The RID attach/detach could be just pasid=3DIOMMU_NO_PASID without
>that "has_pasid"?

After further thinking, yes, we could.

IOMMU_NO_PASID isn't export as UAPI, we need to define it in QEMU.

>
>> > and refactor iommufd_cdev_attach/detach_ioas_hwpt() a bit.
>> >
>> > I'm fine either way, two separate callbacks just look cleaner for me.
>> > Let me know if extending is preferred.
>>
>> Since PASID attach/detach is essentially an extension of the existing
>> attach/detach flow, I would prefer extending the current callbacks.
>> I think that keeps the interface simpler and avoids code duplication.
>
>+1

Ok, wll extend attach/detach_hwpt(). Thanks all.

--_000_IA3PR11MB913687D1DB6FF5B0D813E6509260AIA3PR11MB9136namp_
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
span.EmailStyle21
	{mso-style-type:personal-compose;
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
<p class=3D"MsoNormal">We could use PCI_NO_PASID (-1) but need to translate=
 from PASID_0 to PCI_NO_PASID in intel_iommu,<o:p></o:p></p>
<p class=3D"MsoNormal">IOMMU_NO_PASID(0) which equals PASID_0 looks more st=
raight-forward for me,<o:p></o:p></p>
<p class=3D"MsoNormal">I plan to define it in include/hw/core/iommu.h<o:p><=
/o:p></p>
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
<b>Sent:</b> Thursday, February 12, 2026 2:45 PM<br>
<b>To:</b> Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; Nicolin Chen &=
lt;nicolinc@nvidia.com&gt;; Shameer Kolothum Thodi &lt;skolothumtho@nvidia.=
com&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org; alex@shazbot.org; clg@redhat.com; eric.au=
ger@redhat.com; mst@redhat.com; jasowang@redhat.com; Jason Gunthorpe &lt;jg=
g@nvidia.com&gt;; joao.m.martins@oracle.com; Tian, Kevin &lt;kevin.tian@int=
el.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt;;
 Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b> Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/de=
tach callbacks<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">What about PCI_NO_PASID?=
<o:p></o:p></span></p>
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
size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;D=
uan, Zhenzhong &lt;<a href=3D"mailto:zhenzhong.duan@intel.com">zhenzhong.du=
an@intel.com</a>&gt;<br>
<b>Sent:</b>&nbsp;12 February 2026 03:43<br>
<b>To:</b>&nbsp;Nicolin Chen &lt;<a href=3D"mailto:nicolinc@nvidia.com">nic=
olinc@nvidia.com</a>&gt;; Shameer Kolothum Thodi &lt;<a href=3D"mailto:skol=
othumtho@nvidia.com">skolothumtho@nvidia.com</a>&gt;<br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.=
org</a> &lt;<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org<=
/a>&gt;;
<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a> &lt;<a href=3D"mai=
lto:alex@shazbot.org">alex@shazbot.org</a>&gt;;
<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a> &lt;<a href=3D"mailto:=
clg@redhat.com">clg@redhat.com</a>&gt;;
<a href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a> &lt;<a h=
ref=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a>&gt;;
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a> &lt;<a href=3D"mailto:=
mst@redhat.com">mst@redhat.com</a>&gt;;
<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a> &lt;<a href=
=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;; Jason Gunthorp=
e &lt;<a href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a>&gt;;
<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a> =
&lt;<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com<=
/a>&gt;; CLEMENT MATHIEU--DRIF &lt;<a href=3D"mailto:clement.mathieu--drif@=
eviden.com">clement.mathieu--drif@eviden.com</a>&gt;;
 Tian, Kevin &lt;<a href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.c=
om</a>&gt;; Liu, Yi L &lt;<a href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@in=
tel.com</a>&gt;; Hao, Xudong &lt;<a href=3D"mailto:xudong.hao@intel.com">xu=
dong.hao@intel.com</a>&gt;<br>
<b>Subject:</b>&nbsp;RE: [RFC PATCH 01/14] backends/iommufd: Add pasid atta=
ch/detach callbacks<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:11.0pt">Caution: External e=
mail. Do not open attachments or click links, unless this email comes from =
a known sender and you know the content is safe.<br>
<br>
<br>
&gt;-----Original Message-----<br>
&gt;From: Nicolin Chen &lt;<a href=3D"mailto:nicolinc@nvidia.com">nicolinc@=
nvidia.com</a>&gt;<br>
&gt;Subject: Re: [RFC PATCH 01/14] backends/iommufd: Add pasid attach/detac=
h<br>
&gt;callbacks<br>
&gt;<br>
&gt;On Wed, Feb 11, 2026 at 09:14:33AM -0800, Shameer Kolothum Thodi wrote:=
<br>
&gt;&gt; &gt; &gt; Have you considered extending attach_hwpt() to<br>
&gt;&gt; &gt; &gt;take a PASID instead of introducing a separate callback?<=
br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; Yes, I did. To extending attach/detach_hwpt(), we need to add=
 two<br>
&gt;&gt; &gt; parameters, &quot;bool has_pasid, uint32_t pasid&quot;. E.g.,=
<br>
&gt;&gt; &gt;<br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp; bool (*attach_hwpt)(HostIOMMUDeviceIO=
MMUFD *idev,<br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool has_pasid, uint32_t pasid,<br>
&gt;&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hwpt_id, Error **errp);<br>
&gt;<br>
&gt;The RID attach/detach could be just pasid=3DIOMMU_NO_PASID without<br>
&gt;that &quot;has_pasid&quot;?<br>
<br>
After further thinking, yes, we could.<br>
<br>
IOMMU_NO_PASID isn't export as UAPI, we need to define it in QEMU.<br>
<br>
&gt;<br>
&gt;&gt; &gt; and refactor iommufd_cdev_attach/detach_ioas_hwpt() a bit.<br=
>
&gt;&gt; &gt;<br>
&gt;&gt; &gt; I'm fine either way, two separate callbacks just look cleaner=
 for me.<br>
&gt;&gt; &gt; Let me know if extending is preferred.<br>
&gt;&gt;<br>
&gt;&gt; Since PASID attach/detach is essentially an extension of the exist=
ing<br>
&gt;&gt; attach/detach flow, I would prefer extending the current callbacks=
.<br>
&gt;&gt; I think that keeps the interface simpler and avoids code duplicati=
on.<br>
&gt;<br>
&gt;+1<br>
<br>
Ok, wll extend attach/detach_hwpt(). Thanks all.<o:p></o:p></span></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA3PR11MB913687D1DB6FF5B0D813E6509260AIA3PR11MB9136namp_--

