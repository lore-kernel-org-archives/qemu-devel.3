Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D09EC01A0
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:12:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4aNl-0005KD-SJ; Mon, 23 Mar 2026 04:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4aNj-0005K2-V6
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:11:28 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4aNh-0006VT-1x
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774253485; x=1805789485;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LiBChHb4v/yZQU8FDI3DWL8P06OLgrgMrXpjW/jUJ3E=;
 b=SgxlMTUJPMltVvibe72HFYXDwT26Vq+hJbPzPEHqI1jmmUzBCiIzoUHO
 ywjvUnUZmoB+9w1zaPJUtufFJ0cv38EWerj/IMxS+7NJRugm71qTnwAVM
 Fn449cz93nrFQR4f7VOvmoNK9hIUWdUlBn96lgksEHb64nLZfYATzrArk
 xRLj0KauRGidJ7qR/XeFJoS8R/Zd0DwimfcvKWpsgLJRsAhcIx5nAagPD
 uQ6yOawZ5g9/MVCT34rcJvGsvy8uDTR9Wj+9GhD3mSLsIsOEG2GqA0Cc+
 mY4nzv1De1tSIJ8EJ6Qg0FrEDQSRk/zonKs1UNJORjEXk4RFGvqZZ3Nuc w==;
X-CSE-ConnectionGUID: Jz0Xph4oQDCVTimzzDWjWg==
X-CSE-MsgGUID: ayenpCvCROKlotoXPyNSrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="79151624"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="79151624"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:11:12 -0700
X-CSE-ConnectionGUID: cxBMRHjcQ/ywFU/WmUZhag==
X-CSE-MsgGUID: NG73M+bqQp2yiJwWu8KPhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="228030932"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:11:12 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 01:11:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 01:11:10 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 01:11:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bNXJTeh+v+499VX4dzOvcfA+nWnqzaJWzHMB5tTGUKgBRczApXGM/IWjJeWAu1kzy/iM1TlR1/E2AzY5IGmcMLRO+hRk80s6+E7oaPzhOctAfS1coXXt3aitU9EtYtVanjPrcqc4Q1vgfcXZouIumZXSVWaQw8Z15RzWsXSmIbjs6SSAkI8LHlyDZpM88jF5jo+6/rrsf4BzrY4oOPfU6XNM2gSCLa2+2iQmL845RX8MF8JWsLR0buWoHuHtW5IzjH4NseaNEXy/V7r9jnzzj+slQHblZGeqpoyjiEG29DzZM3KdGNnIh1OcL8UbPH06BJI5Y5UpqMYPJaytBYsftA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiBChHb4v/yZQU8FDI3DWL8P06OLgrgMrXpjW/jUJ3E=;
 b=E5IOtuyXW/ry/2O2BmCN3aaI9xo/L2/HbdL46SlQjGudkKqTvgvYKOQtz87DQmTTFm4LE6sp6HjQhvjuVn0RV3at4RXuy6IUR/P1XMCB7md8I0OXWocHYDlf9843idiT2jgQ2OrMBAr9W5kkSS7OuZ5nUwsoGtCfMXHkWfb9McQVL21nRpp8gduNOe3v0A5GBkSiiEXu534rQBnPTPtdgzlllGg68k2GsROuvrrIQU6qgwa3OnfQm3PzkjTldv4RhfperwYMSc3xbhjSH1cXWXKdxn2wD4biEWyX5p4EyTOz16ZB0My2WETgJ+4+cgMT2XhDkYIKapwYsduSc6Dpkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by IA1PR11MB6489.namprd11.prod.outlook.com (2603:10b6:208:3a7::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Mon, 23 Mar
 2026 08:11:05 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 08:11:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>, "Tian, 
 Kevin" <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Topic: [PATCH v1 07/13] intel_iommu: Handle PASID entry addition for
 pc_inv_dsc request
Thread-Index: AQHcrRuZzPy+NHZDEEGZrvXfRrImE7W3SM4AgARoZDCAACSeAIAACQzQ
Date: Mon, 23 Mar 2026 08:11:05 +0000
Message-ID: <IA3PR11MB9136B3BAB5B1CE2E08DF896A924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-8-zhenzhong.duan@intel.com>
 <52063ae4-eb23-4139-9385-43422463e278@intel.com>
 <IA3PR11MB91362B7ED15479ADDE95E3A4924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <35778e4a-5491-4e25-bbb9-0534af488e9c@intel.com>
In-Reply-To: <35778e4a-5491-4e25-bbb9-0534af488e9c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|IA1PR11MB6489:EE_
x-ms-office365-filtering-correlation-id: 12083efe-3650-4190-d6a3-08de88b3bb2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|366016|376014|1800799024|56012099003|22082099003|18002099003|3613699012|38070700021;
x-microsoft-antispam-message-info: mIBvQFLAYRNHOKzCDO+2p3VRusjtgD9qd53vTsREZ1zBibVJeFZTxiKHrG6fSrsQrF3eFgMjDxMTxGfhEIyQV50ANSqwuJCtd52RkoBLWFTL0HHvot0UglpEAA+Gn9JvE5UjGswXrRNCIlgJWwDu/GL5WWbX2c1au1t9wMQwZNynmzBJ0Ye488JypHK6zuQp78w8Uzcp09wofCmIQ0mtVDupjk/GS/iLmYvBlBO/WUW2xqxGagVBcM/3aW2e9eFZGV+q4EIZGOnO5VB21YaXyMsnwLv69f+S18B+CJvNx4VYgbFYk3Uk0DkC1kkEPlbg8+H/rm5cFWmVyB4GpgPbc0er+6o0EnC0CvOD1ryC2BteqIXagpxud+Y78g9pLLCSTkK+kD6E+bHCjcNDk3PB09YMZCnr+0xVMTc7regjfAXB3qeEJ5/0mUTgctVH0c2peHTGyTxKVJulFxYljRIzi3idKaI/ntThmV6zOHvyU0Fd4SQI3/nn76kv41B2Ujtar6ClFJxIcm1rvgWRAcCsyCGKqKU4sznuXU1MDnfTXZXwNDYnbCYlJPxo9WUx467nLBPbQ/cxUf6qfA6xaN8VEv3n0+6vz5LemHCN1Y/HDzqeFY0mht6lKEFexoJdybNEXpkw+MhXRi+fHowMXuPPKSyhUZf3rL3fu2nSQ6sSxB2BBN/uGbNajp7X1lCoiq+qUTIVKhdv/Il7X6WRSA6dw6HfqRZ2jNi4slQSKViFsCcS2fVF0bHr7tfB/qioWW5hbV32hjg/LdCmgDmTZvNprYw6XrClIbYpZdz6QxEaKCYYXbGE88ZHHkGr9NJFvELZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(3613699012)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dHpVR1gxNTdKcUR2QzVPbGxqTFFzSFFmSE9HNGdSV04wN2JlbVY2SnQ2R0ZE?=
 =?utf-8?B?cW1pUWI4UmdXbWI0aTNWNzdKdlVUTE85c2Z6cm8vU056T3NjN2NMVUhjRnVU?=
 =?utf-8?B?TW5DY3d4NU94N3hyZWJNSk5xckpBL0RTOGEvYlJqeGhUVGlvWHFFemsrNHBC?=
 =?utf-8?B?VkY4blA1L0o3ZG1ZbERzTVhkMm1LR1JrQ2xkQXZ0d0dVQ01NbDBkTG9jTVZG?=
 =?utf-8?B?dm56bmh6N3lIWW5rQ05aZndNVTBDamZlYkJTdS9NNXhOZTB1d1hKSlgvVnRy?=
 =?utf-8?B?eXBhSEs0OEpEdFcxTUlFZUdydHBwZXlURHhpUmo4U1hBMlY4dnJhb0Y5MjJa?=
 =?utf-8?B?OVNtdzZZNDN5OTBZNFVJbHhKOSt6czF1Vys0aWNjcno5Q09NY3QvN2FsUTFj?=
 =?utf-8?B?ZkhzWUw0b3FlK2ZsTnZzOVZlTmFNWFA4ZENUTlgxTUo2ZjRQd2dLa2lEd2hF?=
 =?utf-8?B?LyszWVpEcXgrcVJza0FtUFRnZEJlVHFNbjM5L202RUlNNlhqRmdkTmtpRTlP?=
 =?utf-8?B?MWl4aFhBWDExdVhjTmRlQWk2dlhYNWxKazdidGNkcXB2QjVKdnJzUlJjcnll?=
 =?utf-8?B?V2h0NnY1dTJQWmR4L3l6WmN5WExyR21yMnEwd3BDWERnM2Y2eURHM0Q1bzFZ?=
 =?utf-8?B?akFiTFgzdUwrSnFxRmVYbndkU3lEM2lBZ2tJVzZUY1EyTlJMVTdOdlF3MVVi?=
 =?utf-8?B?ckcyalk0MnVZUm14MmZZTlk2c3QyWjcyWWpSYXdzNlVOSTUwZkJ1TXVCeEM3?=
 =?utf-8?B?TEl1cTUvTjdLVnhtdG1XSm95UE9qTitpZFlVTUN4ejRKS05RUU42ZXdWbW5B?=
 =?utf-8?B?UUdjcmkwK2RjMERYTys5NXZPakFINE0xYlNBRWowQWo5a21XbE5SZkZHNkZh?=
 =?utf-8?B?S01TeFEwS1BwN1RXbWMzYU5GdTUvVGU1Wk5vNlV0ais3OFFrTU5RTXp4Z1VR?=
 =?utf-8?B?VDBmdG14VWwrMmFRRlZZak5jS0tUdVRmb0VXb3gzcm1FcVdTYVZ5cytUTVlM?=
 =?utf-8?B?aXlHSFlaQVRQdGdZYSs3ZHo4YXA4U2FtVjVuZnNGMzR6eWdLMlh5d1h1enhK?=
 =?utf-8?B?Y096clZRaXF0dlBnenBXeW1vQ0tsbm1TQVpnckZhZUU3bVdDcTFBT2RxeTgw?=
 =?utf-8?B?T3E3U2NNL013SFBKQ1pmeE5hYjhwY21pSXNja2lrN0xPc0Njbmo2Qk0vWTFa?=
 =?utf-8?B?cS9YUlEvQmlIcmpYODNQa3JYdkdTZGhoakZLV05jN2svTWNNdytmM2NGNTNU?=
 =?utf-8?B?aTVaVmNpZFQ5dlAyamhBdEdwUDcyYVErTUVyUEFPdkdzdldVcGZNMzgxTGZK?=
 =?utf-8?B?bnVaSUZuSWVObzZYRUNqM0xIWDJXcVBRUU5oQldVZjNMamVZUENyM1lySlU2?=
 =?utf-8?B?Z1hteE8xM1A2a3haQm9wYWtDM1ErcHJOdFZNai85b01JTzRMaVRFZWZZT1Ax?=
 =?utf-8?B?WVpSa0FmODc2K0k2T2ZuWTVyT1ZVOU5raGFmWFNOVThOZ0pTU3FDT3hwWlZo?=
 =?utf-8?B?d1R1UHZrcEMrQ09YcEZFTXlEcXVyeVpHNGVuSjFMT1pDRnl4UmZkTEh1YWty?=
 =?utf-8?B?WThnbmtlVXBFUXRvaVRyUFlzSEpWUklrZ3pJR1BVQ2N2THR3QUdsQTE3QWQ3?=
 =?utf-8?B?SlJQemdmOWNmbW1mVjNKSDZLQk1wWEhhNG83a3poaTdXcFRuTTVxMTB3dmF1?=
 =?utf-8?B?QkdQZS9vaE82Y1ZERXhIZmZDdldYYWgxMXNkRVdxbHJGV2VQN3F3cDIrTnow?=
 =?utf-8?B?UFBCZDBmNjRFRnN6THRDUjlIbk9pWjBHTHdhU3F1UFROYmJZb0EzaS94eHd2?=
 =?utf-8?B?aHFxS0xpTXozM242WGlSQ2pYSVFSSjN5WXUzeFUxT3NKUUVGOUlTckJhTk5B?=
 =?utf-8?B?Y3lFaUw4cDBDVVArcjVBanBERk03RlNsd0lKb0huRG9RU2xXdnpWQjY3NmZr?=
 =?utf-8?B?S3VvaDVhdmJUZzlBdFdGNFdETWhsSDNra295dm44VEUzUXJHaUNYRW1RQlI5?=
 =?utf-8?B?N2xnK3BvTTJLdkFsZUZUOEM0SDVnVW1KRE5wMVFJR3pialZJbGV1RkRPdFBp?=
 =?utf-8?B?YitITFZpemwzU1RqR3NHYnZuRFBlYjE0QWNjZDBSckpOSmUvVTR6VDUyNllR?=
 =?utf-8?B?Vk0rbGthNE9lSG1NTVlFUTdhMmNxL0Q2N1hZQnhnMzFPaDhzMlBwcnhGSFdp?=
 =?utf-8?B?NE5uWWdxQTRDVkt0ek1NZnpHMG9ybnFhNG5HdXRiN0xvajVUa1Y1V1hhVGp1?=
 =?utf-8?B?OUtCaGJBekRaR1p6eGtGbjNGMWlvMElibk5CbDVlbUh3dVlZS2RzNnBXMkp2?=
 =?utf-8?B?eWtUcWtmd1lJSkV5U0U3dzJCS2ZMa0NWSXhlTmRvTUYvRy9Oc2pTdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: IJLUnHqkHsncOrggCsCVpyXd3ikFleccaxE9QesdR3Zprsf3yrLkDhCVhKCN+M61dqeKrPikEgzb7Mst5SEt9+3fCpviDr0xDJazwQ3V0DtYEJwGEO0YeYxdZB7P7AnIgy0zecs535h1avLqnTH70XKAcTwB4GIqi9oQ8wfsjVooc0US2165oI7ZkEUiiVzjaD//FRSwf5VPsmndwFOjz+M/RzbcfhUus/2Qbj7OxtMdd3nYWwy4BnwHWUo2Zv/O0pcm4Px8nvR/8ePp6DmmlihJjHSWoMe7MDGKR2elkPeA9+mxUK4qMKs2qDoAHyHCJ2Udk++rJ92FVjUOJOLjsw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12083efe-3650-4190-d6a3-08de88b3bb2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 08:11:05.3587 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gj4vgWFaF5bj8z11dVOJz6LnaA6ghgTguJcMLUr4Lj2J8wO4yR1FK3h9njxcLELgwwiwjKyMZfSDtewEMy4JJJVy13Bkz1zbJjMoSgC6vVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6489
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpdSwgWWkgTCA8eWkubC5s
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDcvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yDQo+cGNfaW52X2RzYyByZXF1ZXN0DQo+
DQo+T24gMy8yMy8yNiAxMzo1MCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+Pj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1
QGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDA3LzEzXSBpbnRlbF9pb21t
dTogSGFuZGxlIFBBU0lEIGVudHJ5IGFkZGl0aW9uIGZvcg0KPj4+IHBjX2ludl9kc2MgcmVxdWVz
dA0KPj4+DQo+Pj4gT24gMy82LzI2IDExOjQ0LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4g
U3RydWN0dXJlIFZUREFkZHJlc3NTcGFjZSBpbmNsdWRlcyBzb21lIGVsZW1lbnRzIHN1aXRhYmxl
IGZvciBlbXVsYXRlZA0KPj4+PiBkZXZpY2UgYW5kIHBhc3N0aHJvdWdoIGRldmljZSB3aXRob3V0
IFBBU0lELCBlLmcuLCBhZGRyZXNzIHNwYWNlLA0KPj4+PiBkaWZmZXJlbnQgbWVtb3J5IHJlZ2lv
bnMsIGV0YywgaXQgaXMgYWxzbyBwcm90ZWN0ZWQgYnkgdnRkIGlvbW11IGxvY2ssDQo+Pj4+IGFs
bCB0aGVzZSBhcmUgdXNlbGVzcyBhbmQgYmVjb21lIGEgYnVyZGVuIGZvciBwYXNzdGhyb3VnaCBk
ZXZpY2Ugd2l0aA0KPj4+PiBQQVNJRC4NCj4+Pj4NCj4+Pj4gV2hlbiB0aGVyZSBhcmUgbG90cyBv
ZiBQQVNJRHMgdXNlZCBpbiBvbmUgZGV2aWNlLCB0aGUgQVMgYW5kIE1ScyBhcmUNCj4+Pj4gYWxs
IHJlZ2lzdGVyZWQgdG8gbWVtb3J5IGNvcmUgYW5kIGltcGFjdCB0aGUgd2hvbGUgc3lzdGVtIHBl
cmZvcm1hbmNlLg0KPj4+Pg0KPj4+PiBTbyBpbnN0ZWFkIG9mIHVzaW5nIFZUREFkZHJlc3NTcGFj
ZSB0byBjYWNoZSBwYXNpZCBlbnRyeSBmb3IgZWFjaCBwYXNpZA0KPj4+PiBvZiBhIHBhc3N0aHJv
dWdoIGRldmljZSwgd2UgZGVmaW5lIGEgbGlnaHQgd2VpZ2h0IHN0cnVjdHVyZQ0KPj4+PiBWVERB
Q0NFTFBBU0lEQ2FjaGVFbnRyeSB3aXRoIG9ubHkgbmVjZXNzYXJ5IGVsZW1lbnRzIGZvciBlYWNo
IHBhc2lkLiBXZQ0KPj4+PiB3aWxsIHVzZSB0aGlzIHN0cnVjdCBhcyBhIHBhcmFtZXRlciB0byBj
b25kdWN0IGJpbmRpbmcvdW5iaW5kaW5nIHRvDQo+Pj4+IG5lc3RlZCBod3B0IGFuZCB0byByZWNv
cmQgdGhlIGN1cnJlbnQgYmluZGVkIG5lc3RlZCBod3B0LiBJdCdzIGFsc28NCj4+Pg0KPj4+IHMv
YmluZGVkL2JvdW5kLw0KPj4NCj4+IE9LLg0KPj4NCj4+Pg0KPj4+PiBkZXNpZ25lZCB0byBzdXBw
b3J0IFBBU0lEXzAuDQo+Pj4+DQo+Pj4+IFdoZW4gZ3Vlc3QgY3JlYXRlcyBuZXcgUEFTSUQgZW50
cmllcywgUUVNVSB3aWxsIGNhcHR1cmUgdGhlIHBjX2ludl9kc2MNCj4+Pj4gKHBhc2lkIGNhY2hl
IGludmFsaWRhdGlvbikgcmVxdWVzdCwgd2FsayB0aHJvdWdoIGVhY2ggcGFzaWQgaW4gZWFjaA0K
Pj4+PiBwYXNzdGhyb3VnaCBkZXZpY2UgZm9yIHZhbGlkIHBhc2lkIGVudHJpZXMsIGNyZWF0ZSBh
IG5ldw0KPj4+PiBWVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeSBpZiBub3QgZXhpc3RpbmcgeWV0Lg0K
Pj4+DQo+Pj4gSSB0aGluayBzb21lIHR3ZWFrIGlzIHByZWZlcnJlZCB3LnIudC4gdGhpcyBhbmQg
dGhlIG5leHQgcGF0Y2guDQo+Pj4NCj4+PiBJbiB0aGlzIHBhdGNoIHlvdSBvbmx5IG5lZWQgdG8g
aGFuZGxlIHRoZSBQQVNJRCBlbnRyeSBhZGRpdGlvbi4gSGVuY2UNCj4+PiB5b3UgYXNzdW1lIG5v
IGV4aXN0aW5nIFZUREFDQ0VMUEFTSURDYWNoZUVudHJ5IHlldC4NCj4+DQo+PiBbLi4uXQ0KPj4N
Cj4+Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCj4+
Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNv
bT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaCAgICB8ICAx
MyArKysNCj4+Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgICA4ICsrDQo+
Pj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8ICAgMyArDQo+Pj4+ICAgIGh3
L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYyAgICB8IDE3MA0KPisrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPj4+PiAgICA0IGZpbGVzIGNoYW5nZWQsIDE5NCBpbnNlcnRpb25zKCsp
DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmggYi9o
dy9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmgNCj4+Pj4gaW5kZXggZTVmMGIwNzdiNC4uYTc3ZmQw
NmZlMCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5oDQo+Pj4+
ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuaA0KPj4+PiBAQCAtMTIsNiArMTIsMTMg
QEANCj4+Pj4gICAgI2RlZmluZSBIV19JMzg2X0lOVEVMX0lPTU1VX0FDQ0VMX0gNCj4+Pj4gICAg
I2luY2x1ZGUgQ09ORklHX0RFVklDRVMNCj4+Pj4NCj4+Pj4gK3R5cGVkZWYgc3RydWN0IFZUREFD
Q0VMUEFTSURDYWNoZUVudHJ5IHsNCj4+Pj4gKyAgICBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9o
aW9kOw0KPj4+PiArICAgIFZURFBBU0lERW50cnkgcGU7DQo+Pj4+ICsgICAgdWludDMyX3QgcGFz
aWQ7DQo+Pj4+ICsgICAgUUxJU1RfRU5UUlkoVlREQUNDRUxQQVNJRENhY2hlRW50cnkpIG5leHQ7
DQo+Pj4+ICt9IFZUREFDQ0VMUEFTSURDYWNoZUVudHJ5Ow0KPj4+DQo+Pj4gYnR3LiBzL1ZUREFD
Q0VMUEFTSURDYWNoZUVudHJ5L1ZUREFjY2VsUEFTSURDYWNoZUVudHJ5LyBsb29rcyBiZXR0ZXIu
IDopDQo+Pg0KPj4gU3VyZS4NCj4+DQo+Pj4+ICsNCj4+Pj4gICAgI2lmZGVmIENPTkZJR19WVERf
QUNDRUwNCj4+Pj4gICAgYm9vbCB2dGRfY2hlY2tfaGlvZF9hY2NlbChJbnRlbElPTU1VU3RhdGUg
KnMsIFZUREhvc3RJT01NVURldmljZQ0KPj4+ICp2dGRfaGlvZCwNCj4+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0KPj4+PiBAQCAtMjAsNiArMjcsNyBAQCBi
b29sIHZ0ZF9wcm9wYWdhdGVfZ3Vlc3RfcGFzaWQoVlREQWRkcmVzc1NwYWNlDQo+Pj4gKnZ0ZF9h
cywgRXJyb3IgKiplcnJwKTsNCj4+Pj4gICAgdm9pZCB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxs
X2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMsIHVpbnQxNl90DQo+Pj4gZG9tYWluX2lkLA0KPj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IHBhc2lk
LCBod2FkZHIgYWRkciwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB1aW50NjRfdCBucGFnZXMsIGJvb2wgaWgpOw0KPj4+PiArdm9pZCB2dGRfcGFzaWRfY2Fj
aGVfc3luY19hY2NlbChJbnRlbElPTU1VU3RhdGUgKnMsIFZURFBBU0lEQ2FjaGVJbmZvDQo+Pj4g
KnBjX2luZm8pOw0KPj4+PiAgICB2b2lkIHZ0ZF9pb21tdV9vcHNfdXBkYXRlX2FjY2VsKFBDSUlP
TU1VT3BzICpvcHMpOw0KPj4+PiAgICAjZWxzZQ0KPj4+PiAgICBzdGF0aWMgaW5saW5lIGJvb2wg
dnRkX2NoZWNrX2hpb2RfYWNjZWwoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiBAQCAtNDksNiAr
NTcsMTEgQEAgc3RhdGljIGlubGluZSB2b2lkDQo+Pj4gdnRkX2ZsdXNoX2hvc3RfcGlvdGxiX2Fs
bF9sb2NrZWQoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4+PiAgICB7DQo+Pj4+ICAgIH0NCj4+Pj4N
Cj4+Pj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB2dGRfcGFzaWRfY2FjaGVfc3luY19hY2NlbChJbnRl
bElPTU1VU3RhdGUgKnMsDQo+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+Pj4+ICt7DQo+Pj4+ICt9
DQo+Pj4+ICsNCj4+Pj4gICAgc3RhdGljIGlubGluZSB2b2lkIHZ0ZF9pb21tdV9vcHNfdXBkYXRl
X2FjY2VsKFBDSUlPTU1VT3BzICpvcHMpDQo+Pj4+ICAgIHsNCj4+Pj4gICAgfQ0KPj4+PiBkaWZm
IC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Yi9ody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmgNCj4+Pj4gaW5kZXggYzdlMTA3ZmU4Ny4uZWRlNGRiNmQyZCAxMDA2
NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+ICsrKyBi
L2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+PiBAQCAtNjE2LDYgKzYxNiw3IEBA
IHR5cGVkZWYgc3RydWN0IFZURFJvb3RFbnRyeSBWVERSb290RW50cnk7DQo+Pj4+ICAgICNkZWZp
bmUgVlREX0NUWF9FTlRSWV9TQ0FMQUJMRV9TSVpFICAgMzINCj4+Pj4NCj4+Pj4gICAgI2RlZmlu
ZSBQQVNJRF8wICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwDQo+Pj4+ICsjZGVmaW5lIFZU
RF9TTV9DT05URVhUX0VOVFJZX1BEVFMoeCkgICAgICAgIGV4dHJhY3Q2NCgoeCktPnZhbFswXSwg
OSwgMykNCj4+Pj4gICAgI2RlZmluZSBWVERfU01fQ09OVEVYVF9FTlRSWV9SU1ZEX1ZBTDAoYXcp
ICAoMHgxZTBVTEwgfA0KPj4+IH5WVERfSEFXX01BU0soYXcpKQ0KPj4+PiAgICAjZGVmaW5lIFZU
RF9TTV9DT05URVhUX0VOVFJZX1JTVkRfVkFMMSAgICAgIDB4ZmZmZmZmZmZmZmUwMDAwMFVMTA0K
Pj4+PiAgICAjZGVmaW5lIFZURF9TTV9DT05URVhUX0VOVFJZX1BSRSAgICAgICAgICAgIDB4MTBV
TEwNCj4+Pj4gQEAgLTY0Niw2ICs2NDcsNyBAQCB0eXBlZGVmIHN0cnVjdCBWVERQSU9UTEJJbnZJ
bmZvIHsNCj4+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfRElSX0JJVFNfTUFTSyAgICAgICAoMHgz
ZmZmVUxMKQ0KPj4+PiAgICAjZGVmaW5lIFZURF9QQVNJRF9ESVJfSU5ERVgocGFzaWQpICAgICgo
KHBhc2lkKSA+PiA2KSAmDQo+Pj4gVlREX1BBU0lEX0RJUl9CSVRTX01BU0spDQo+Pj4+ICAgICNk
ZWZpbmUgVlREX1BBU0lEX0RJUl9GUEQgICAgICAgICAgICAgKDFVTEwgPDwgMSkgLyogRmF1bHQg
UHJvY2Vzc2luZyBEaXNhYmxlDQo+Ki8NCj4+Pj4gKyNkZWZpbmUgVlREX1BBU0lEX1RBQkxFX0VO
VFJZX05VTSAgICAgKDFVTEwgPDwgNikNCj4+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfVEFCTEVf
QklUU19NQVNLICAgICAoMHgzZlVMTCkNCj4+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfVEFCTEVf
SU5ERVgocGFzaWQpICAoKHBhc2lkKSAmDQo+Pj4gVlREX1BBU0lEX1RBQkxFX0JJVFNfTUFTSykN
Cj4+Pj4gICAgI2RlZmluZSBWVERfUEFTSURfRU5UUllfRlBEICAgICAgICAgICAoMVVMTCA8PCAx
KSAvKiBGYXVsdCBQcm9jZXNzaW5nDQo+RGlzYWJsZQ0KPj4+ICovDQo+Pj4+IEBAIC03MTEsNiAr
NzEzLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgVlRESG9zdElPTU1VRGV2aWNlIHsNCj4+Pj4gICAgICAg
IFBDSUJ1cyAqYnVzOw0KPj4+PiAgICAgICAgdWludDhfdCBkZXZmbjsNCj4+Pj4gICAgICAgIEhv
c3RJT01NVURldmljZSAqaGlvZDsNCj4+Pj4gKyAgICBRTElTVF9IRUFEKCwgVlREQUNDRUxQQVNJ
RENhY2hlRW50cnkpIHBhc2lkX2NhY2hlX2xpc3Q7DQo+Pj4+ICAgIH0gVlRESG9zdElPTU1VRGV2
aWNlOw0KPj4+Pg0KPj4+PiAgICAvKg0KPj4+PiBAQCAtNzY4LDYgKzc3MSwxMSBAQCBzdGF0aWMg
aW5saW5lIGludA0KPj4+IHZ0ZF9wYXNpZF9lbnRyeV9jb21wYXJlKFZURFBBU0lERW50cnkgKnAx
LCBWVERQQVNJREVudHJ5ICpwMikNCj4+Pj4gICAgICAgIHJldHVybiBtZW1jbXAocDEsIHAyLCBz
aXplb2YoKnAxKSk7DQo+Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gK3N0YXRpYyBpbmxpbmUgdWludDMy
X3QgdnRkX3NtX2NlX2dldF9wZHRfZW50cnlfbnVtKFZURENvbnRleHRFbnRyeSAqY2UpDQo+Pj4+
ICt7DQo+Pj4+ICsgICAgcmV0dXJuIDFVIDw8IChWVERfU01fQ09OVEVYVF9FTlRSWV9QRFRTKGNl
KSArIDcpOw0KPj4+PiArfQ0KPj4+PiArDQo+Pj4+ICAgIGludCB2dGRfZ2V0X3BkaXJlX2Zyb21f
cGRpcl90YWJsZShkbWFfYWRkcl90IHBhc2lkX2Rpcl9iYXNlLCB1aW50MzJfdA0KPnBhc2lkLA0K
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlREUEFTSUREaXJFbnRy
eSAqcGRpcmUpOw0KPj4+PiAgICBpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKElu
dGVsSU9NTVVTdGF0ZSAqcywgdWludDMyX3QgcGFzaWQsDQo+Pj4+IGRpZmYgLS1naXQgYS9ody9p
Mzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+Pj4gaW5kZXggNzQ0
YjU5NjdiMi4uOTg0YWRjNjM5YSAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21t
dS5jDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiBAQCAtMzIwMiw2ICsz
MjAyLDggQEAgc3RhdGljIHZvaWQNCj52dGRfcGFzaWRfY2FjaGVfc3luYyhJbnRlbElPTU1VU3Rh
dGUNCj4+PiAqcywgVlREUEFTSURDYWNoZUluZm8gKnBjX2luZm8pDQo+Pj4+ICAgICAgICBnX2hh
c2hfdGFibGVfZm9yZWFjaChzLT52dGRfYWRkcmVzc19zcGFjZXMsDQo+Pj4gdnRkX3Bhc2lkX2Nh
Y2hlX3N5bmNfbG9ja2VkLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGNfaW5m
byk7DQo+Pj4+ICAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4+PiArDQo+Pj4+ICsgICAg
dnRkX3Bhc2lkX2NhY2hlX3N5bmNfYWNjZWwocywgcGNfaW5mbyk7DQo+Pj4+ICAgIH0NCj4+Pj4N
Cj4+Pj4gICAgc3RhdGljIHZvaWQgdnRkX3JlcGxheV9wYXNpZF9iaW5kaW5nc19hbGwoSW50ZWxJ
T01NVVN0YXRlICpzKQ0KPj4+PiBAQCAtNDc2MCw2ICs0NzYyLDcgQEAgc3RhdGljIGJvb2wgdnRk
X2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cw0KPipidXMsDQo+Pj4gdm9pZCAqb3BhcXVlLCBp
bnQgZGV2Zm4sDQo+Pj4+ICAgICAgICB2dGRfaGlvZC0+ZGV2Zm4gPSAodWludDhfdClkZXZmbjsN
Cj4+Pj4gICAgICAgIHZ0ZF9oaW9kLT5pb21tdV9zdGF0ZSA9IHM7DQo+Pj4+ICAgICAgICB2dGRf
aGlvZC0+aGlvZCA9IGhpb2Q7DQo+Pj4+ICsgICAgUUxJU1RfSU5JVCgmdnRkX2hpb2QtPnBhc2lk
X2NhY2hlX2xpc3QpOw0KPj4+Pg0KPj4+PiAgICAgICAgaWYgKCF2dGRfY2hlY2tfaGlvZChzLCB2
dGRfaGlvZCwgZXJycCkpIHsNCj4+Pj4gICAgICAgICAgICBnX2ZyZWUodnRkX2hpb2QpOw0KPj4+
PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jIGIvaHcvaTM4Ni9pbnRl
bF9pb21tdV9hY2NlbC5jDQo+Pj4+IGluZGV4IGMyNzU3ZjNiY2QuLjBhY2YzYWU3N2YgMTAwNjQ0
DQo+Pj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNjZWwuYw0KPj4+PiArKysgYi9ody9p
Mzg2L2ludGVsX2lvbW11X2FjY2VsLmMNCj4+Pj4gQEAgLTI1Nyw2ICsyNTcsMTc2IEBAIHZvaWQN
Cj4+PiB2dGRfZmx1c2hfaG9zdF9waW90bGJfYWxsX2xvY2tlZChJbnRlbElPTU1VU3RhdGUgKnMs
IHVpbnQxNl90IGRvbWFpbl9pZCwNCj4+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZ0
ZF9mbHVzaF9ob3N0X3Bpb3RsYl9sb2NrZWQsICZwaW90bGJfaW5mbyk7DQo+Pj4+ICAgIH0NCj4+
Pj4NCj4+Pj4gK3N0YXRpYyB2b2lkIHZ0ZF9maW5kX2FkZF9wYyhWVERIb3N0SU9NTVVEZXZpY2Ug
KnZ0ZF9oaW9kLCB1aW50MzJfdA0KPnBhc2lkLA0KPj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFZURFBBU0lERW50cnkgKnBlKQ0KPj4+PiArew0KPj4+DQo+Pj4gdGhlbiB5b3UgY2Fu
IG5hbWUgdGhpcyBhcyB2dGRfYWNjZWxfZmlsbF9wYygpLiBBbmQgSSB0aGluayB5b3Ugd291bGQN
Cj4+PiBoYXZlIHZ0ZF9hY2NlbF91cGRhdGVfcGMoKSBhbmQgdnRkX2FjY2VsX2RlbGV0ZV9wYygp
IGluIHRoZSBuZXh0IHBhdGNoLg0KPj4NCj4+IFllcywgaW4gY3VycmVudCBpbXBsZW1lbnRhdGlv
biB0aGlzIHBhdGNoIGhhbmRsZXMgcGFzaWQgZW50cnkgYWRkaXRpb24gYW5kDQo+dXBkYXRlLA0K
Pj4gbmV4dCBwYXRjaCBoYW5kbGVzIHJlbW92YWwuDQo+PiBXaGF0J3MgdGhlIGJlbmVmaXQgaWYg
d2UgbW92ZSBwYXNpZCBlbnRyeSB1cGRhdGUgaW50byBuZXh0IHBhdGNoPw0KPg0KPklmIG5vIHJl
ZHVuZGFudCBmbHVzaCwgZm9yIGEgbmV3bHkgY3JlYXRlZCBwYXNpZCBlbnRyeSwgeW91IG5lZWQg
bm90IHRvDQo+bG9vcCB0aGUgcGFzaWQgY2FjaGUgZW50cnkgbGlzdC4gQnV0LCBpdCdzIHBvc3Np
YmxlIHRvIGhhdmUgc3VjaCBndWVzdC4gOikNCj4NCj4+Pg0KPj4+PiArICAgIFZUREFDQ0VMUEFT
SURDYWNoZUVudHJ5ICp2dGRfcGNlOw0KPj4+PiArDQo+Pj4+ICsgICAgUUxJU1RfRk9SRUFDSCh2
dGRfcGNlLCAmdnRkX2hpb2QtPnBhc2lkX2NhY2hlX2xpc3QsIG5leHQpIHsNCj4+Pj4gKyAgICAg
ICAgaWYgKHZ0ZF9wY2UtPnBhc2lkID09IHBhc2lkKSB7DQo+Pj4+ICsgICAgICAgICAgICBpZiAo
dnRkX3Bhc2lkX2VudHJ5X2NvbXBhcmUocGUsICZ2dGRfcGNlLT5wZSkpIHsNCj4+Pj4gKyAgICAg
ICAgICAgICAgICB2dGRfcGNlLT5wZSA9ICpwZTsNCj4+Pj4gKyAgICAgICAgICAgIH0NCj4+Pj4g
KyAgICAgICAgICAgIHJldHVybjsNCj4+Pj4gKyAgICAgICAgfQ0KPj4+PiArICAgIH0NCj4+Pg0K
Pj4+IGhlbmNlIHRoaXMgbG9vcCBjYW4gYmUgYXZvaWRlZC4NCj4+DQo+PiBIbSwgSSB0aGluayBn
dWVzdCBtYXkgc2VuZCByZWR1bmRhbnQgcHZfaW52X2RzYywgc28gd2UgbmVlZCB0aGlzIGxvb3AN
Cj4+IHRvIGJ5cGFzcyBleGlzdGluZyBwYXNpZCBlbnRyeSB0byBhdm9pZCBhZGRpbmcgZHVwbGlj
YXRlIHBhc2lkIGVudHJ5Lg0KPj4gTGV0IG1lIGtub3cgaWYgSSBtaXN1bmRlcnN0YW5kIHdoYXQg
eW91IG1lYW4uDQo+DQo+QWx0aG91Z2ggSSBoYXZlIGFuIGlkZWEgdG8gaGFuZGxlIGl0LiBCdXQg
aXQgcmVsaWVzIG9uIHNvbWUga2luZCBvZiBmbGFnDQo+cmV0dXJuZWQgYnkgdGhlIHJlbW92YWwv
dXBkYXRlIHByb2Nlc3NpbmcgcGF0aCB0byB0ZWxsIG5vIG5lZWQgdG8gcmUtDQo+Y3JlYXRlIHBh
c2lkIGNhY2hlIGVudHJ5IGluIHRoZSB2dGRfcmVwbGF5X3Bhc2lkX2JpbmRfZm9yX2RldigpIHBh
dGguIEkNCj5kb24ndCB0aGluayB3ZSBuZWVkIHRvIG1ha2UgdGhpbmdzIHNvIGNvbXBsaWNhdGVk
LiBTbyBsZXQncyBmb2xsb3cgdGhlDQo+Y3VycmVudCBzcGxpdHRpbmcuIEJ1dCBJIHRoaW5rIHlv
dSBzdGlsbCBjYW4gbmFtZSB0aGlzIGhlbHBlciBhcw0KPnZ0ZF9hY2NlbF9maWxsX3BjKCkuICJm
aW5kIiBzb21ldGltZXMgbWVhbnMgcmV0dXJuIHNvbWV0aGluZyBiYWNrLg0KDQpHb3QgaXQsIHdp
bGwgZG8uDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

