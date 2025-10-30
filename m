Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B732CCF9F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEOgH-0008IX-Pv; Thu, 30 Oct 2025 05:10:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vEOgE-0008EV-Qg
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:10:51 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vEOg2-0001g8-Bs
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:10:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1761815438; x=1793351438;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HBTM20QVKm2XnFISj2xmZWHWO9jJvU55qHEScTXZypk=;
 b=G4wNaAnZtvv18E8s2FDSBonJO8Ctd+as1cQZcBrixNKsC+lmqLC+DUcD
 mRNc9dPvBoItvFO65JQqtl5/7Mh2choCB5Ip4FLWfbjc4DVearOVkb+30
 fiASCk0lzz4hDOz2+xcRlmkG8r2lLKrcvQa0Ru7KGjW9KqKs1BUMswoze
 IzDTtWRf9TDJ8/fqZSaG8HvsM4Xy5ofttcLtAOtWO4GrJ6ZdGnHa8X8+n
 X+qMH/wV6cYZ5PdFQw1u+SMW35btF9iFlabgckTqNS+BhrwHDGNINLUqK
 zOpWM1/7znW2omcEGAYK9iy+lM2f+r2Rcivl0uqOZAlEsGIvGSECyTVG/ g==;
X-CSE-ConnectionGUID: px8h+ZfPRSy/NT0mayW1EA==
X-CSE-MsgGUID: I3785sK1RrepfdEEdrQDgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63860339"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="63860339"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 02:10:29 -0700
X-CSE-ConnectionGUID: wsTbSO/qRJitnZoKG4/Dsw==
X-CSE-MsgGUID: RVSpIxnOTLOTAtHMONv4JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; d="scan'208";a="209483875"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2025 02:10:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 02:10:29 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 30 Oct 2025 02:10:29 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.49) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 30 Oct 2025 02:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpag4DFUipka/qBfI39mh+c+tSIesW+Dj9lw2Y6Z3MmJp2gVVplll/8rfXFw5A6Vtbxi0VtiBbo/jy934BRf8qLuAkYsjv9epfLheUhYKNPDcieWIM/xojP5OyCP8vTZRJnWg8j6jDUYktDH2d78+9v8L5sXLiyvd8zXB3GuA6qnobjj3923TSQn1oVqoTeJbiAIxeSYAKC/lA2KW91QNirH0EvI9KQFfr3v7qfFEBEYqQvDrHozvemgtxRGg9zk4AXYR7ZeYhDMLkFv6YyI9ng23nJiizgjzSK7dpROFondQ8l6hL5GDhYdvejhVLT8q2rCCFcrGLa35sE1k3t+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKgwa4ksmsXoHerO1rWtvl2db89rTuYoSBcJxL/2WUA=;
 b=CDAdSOoqd/PIUr/QgrQ3t/KGjB9TvDna0EqgQDefyoFmnDuZ3+Re+7z3y92OkiXNJ2hO/OosTr9MnkQxVvF8tY2rvFkxVxPZebpRRAv51bzEHOC/d6IxucEK7F6Kmx4su9r9xx95BYr9+SE1hBzB3oUMgzfx9OsQhWYmBuTYb1MPP93Ejp9vCJA7OFY85Y23eJoZEleaDSeizMUknSrWHKnjZY4bqi2/QRda+0P1Vos3XxPaamBnbutAN3sNmmvl1x4VFXmJVAhFgCC821sWyI64kxh/9tn4CeMQamdVhxE9LRRxq1QnMmLcJxQ1kCGXG8ocM3Y5ZGSk+lYGP5QHzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SJ0PR11MB8269.namprd11.prod.outlook.com (2603:10b6:a03:478::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 09:10:26 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%7]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 09:10:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Hao, Xudong" <xudong.hao@intel.com>, "Cabiddu,
 Giovanni" <giovanni.cabiddu@intel.com>, Rohith S R <rohith.s.r@intel.com>,
 "Gross, Mark" <mark.gross@intel.com>, "Van De Ven, Arjan"
 <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Thread-Topic: [PATCH v4 08/10] vfio/migration: Fix a check on
 vbasedev->iommu_dirty_tracking
Thread-Index: AQHcSLoYic5r0GqRiU2SGu5DZpxfKbTaWxAAgAADbcA=
Date: Thu, 30 Oct 2025 09:10:25 +0000
Message-ID: <IA3PR11MB913625D418E023D14D4ED0CF92FBA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20251029095354.56305-1-zhenzhong.duan@intel.com>
 <20251029095354.56305-9-zhenzhong.duan@intel.com>
 <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
In-Reply-To: <eb2e5419-7a63-47be-adaf-e34709d8310f@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SJ0PR11MB8269:EE_
x-ms-office365-filtering-correlation-id: 894dfc81-9d89-4d30-170d-08de179429e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?us-ascii?Q?AiRcCzoX1ubQE3LYHKmaKGcciD1CFuSnb4D1xxF3zYAER229Tf6/a7thM1P7?=
 =?us-ascii?Q?cOAQ8XzQPCsBwBCwtvUIcwf1Yqnwp25jeLrM37UdV91cTsegZfAIvVh+t9wd?=
 =?us-ascii?Q?0IDpzCLprs21SPYv20K014pT0TvxhsP7642+pxYTQc5c1Z617GPhVg4B6lE+?=
 =?us-ascii?Q?pP/x4vIS53Wx4LfWnQciWHuLO414cI6nQPqNyRO/oWXfKD7+Y7SRh7958r6/?=
 =?us-ascii?Q?XfjRpK9fTApbP4ebaNEcmGvBQnxD9nqoJ2XWyoonBqmUQoZbdn0tkpXJaPrp?=
 =?us-ascii?Q?hBs3JbftYPJHfxfkgUXe4PvEz6Bndb11lYGBRZRomfGVfM6kzWsRoZ03h8oJ?=
 =?us-ascii?Q?Wl34nEN7mGSAbeXVsrS+lKaL44mXizdmh+A7/qT8W/sX3N+lJ9vQTdzGYFqk?=
 =?us-ascii?Q?LtUd+dQ16TvGAgTeCYICP0uzVUXnIH9D+NufDIXH80gGu8oI0fnW4QTRQuYR?=
 =?us-ascii?Q?EhFF6+jCELGhGXJ3Y8/GjBgHvOtCS4BW1cTujx8vHZSjSZOiDvmPxcCUsQxg?=
 =?us-ascii?Q?bz1gV9QbLWaejoUr9NsRZcJktivTQ37EJ4w/0BAYbwogqSyVmbr2iFpL4TwA?=
 =?us-ascii?Q?RT3dYEkAFLtYeICQ/A2pixks39w3lByL+HE7d28zv59oXGLAbytbt9b8SPj8?=
 =?us-ascii?Q?LDuzB7rTF3O8SILLbjNAVz4ltQ5qzpxVGQ2zFlHkniHuxmSrH3ZRxE46s0ms?=
 =?us-ascii?Q?B4V0GV3Wyqg+NaoZeN7HHjKjHM6kyXfGPnz0Bzo35qrtSgogGcocVTFkf1bX?=
 =?us-ascii?Q?cT06aNwcCZnsYUgHCo+Y+A/DPs1hNtAKccP8Pj+jyFcgzgPl0Al6g12KtUWs?=
 =?us-ascii?Q?uYP3GLRfiaaAPdMkQ/FT9UdjQekU1JYNh5hCGXzRf0b5JR7jVDfHWdmq8brh?=
 =?us-ascii?Q?Mx0Ygg5Rc+xxWOFTXx6obUZCUYRKNWZWlXsqWeHOecXNWQQOPVbSa+IG5Cum?=
 =?us-ascii?Q?62VX44ZYoYzUAHsxxs/yjICkQQKPmd/pU37P1MDM521X9OKdeJVRehivOeoZ?=
 =?us-ascii?Q?LLAPvNlw5E5+LiOckgtqab7YbNHRVrU6BxCmGlEZAW7hpNdV8xsc+MhpmEjE?=
 =?us-ascii?Q?ep0+qoHdpWR9dZTZaHVbv4o7nJr2NcEoCOE0linSbaZYAD5wVgd7mDRzXezW?=
 =?us-ascii?Q?UYGX9rOlSBUI+96aESKI13oKhOne1PQn5NtlaxpIQdC8WqiSyZPieu/mxLkn?=
 =?us-ascii?Q?/+v8k6ctTQENERjlPvAFY53mIaCie4xwdesQXWwgXnlYQs7dghsYkh2Ht0ER?=
 =?us-ascii?Q?QZhcZOVz2fDv6IFj6STAhR0Focbz4HnzyMnXYW8SQvwwL4/AJMEy1EbrDoP1?=
 =?us-ascii?Q?Dt4wX3XvOlZ+Qm12XMc7dQ6rifVpA7WwYbpB90ZLKgoI3RBDRG1j5qB5KLgG?=
 =?us-ascii?Q?p7LhP9T2JKoi9oTqa5R9RN/K6gCEEG6L6/khu4pXXGuDVADROdrMpzdOWZPv?=
 =?us-ascii?Q?6ORtBWMa864Bf+tyKZn64ANuFu3cQCdmWWmlPkH2DW3WVB07iadP45bS7Oz9?=
 =?us-ascii?Q?EaayDVlkbKq+Pvji4GA0ezpkt8HIBSznwhqf?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S2M3DBWMcBjtFYD21mvbw3CmTRjUIP3L22AE3MT4a8Mu+cVeLYkL4cZF5npe?=
 =?us-ascii?Q?Q/W4Vnwb9tOwUgVKGaHl9F+OrLzE7BJMSoF/Bwi8qSnzISongZ0GTqM/bUfS?=
 =?us-ascii?Q?1MDiwrw1EQbiFtDQzuTMKAQj6fJD7NYp9fHUA7X0koLeGdhkSLaJ4PoauPzx?=
 =?us-ascii?Q?jApM4Zebg8viFHeMqVK/Y3yLRi4jxs0itVissG248n5ZqBhLYeNoN8klwMzQ?=
 =?us-ascii?Q?hBhHB9/fcV5aWAxB22AJjEtOYeTZG7v3+7LxghlFzLCys+Wr1xvYX0CihsGc?=
 =?us-ascii?Q?11gsUh5Cmcxy9GSYOGgcgcaER70tHOuw5KEuU/AOlAvd0UMHK3FdU7ouRR7p?=
 =?us-ascii?Q?s3OZ+SRP5xOpxfbhJy02EYfEb1NGyo3DQiHZZ+JvGN88WMfz++3Uc3KYRp0c?=
 =?us-ascii?Q?/gya0l3O9JMhTiBckHb3gVwMjWekCnVQUijzhfSPp+M+fdboXVNv0st3BV9k?=
 =?us-ascii?Q?HuRwUNnaSHi13ViGbZmuchRGEqcRVDyAVGNQd6+nFd7uXzEQgxid/PA/9ljk?=
 =?us-ascii?Q?cgv7fETN6jKd3aPjIq9rXxB9RAyMxc/DTMhY6MBwr4A4Nv3BGxBpkkQ3fIFB?=
 =?us-ascii?Q?WBaUmbvF01Cg7cRN8V5zPnrF/VRPpwGYMnG379SLTxtnPdcfG/jL4exggrmn?=
 =?us-ascii?Q?t2jdTkrlVFjNHwkyyFLUuALtJ8P9x3ewtGh23EKV6U/qRuMQ2y4/fXEGm7Vv?=
 =?us-ascii?Q?/tJLwwUPPwQ18JzVSgNvQnFi7npl1K33nBypKwVTPBKz9GKygGBVCxhnm0PC?=
 =?us-ascii?Q?QLLdIUrtg13Nq3GCZqF0uCrvQERI51F028NuUfZXYH6TAWFIO0uUqmNcg5qB?=
 =?us-ascii?Q?ziRoTEcLXVyd9txQ0zTvPIxjrITajhHjzSW0boWztBdcMKqAESsRqVuTBhpF?=
 =?us-ascii?Q?1F8soWoy07h3TmJbBfxadsIe9vgCG7UCWX7h3Wvv7m8U+plrglnTQ39Vv07D?=
 =?us-ascii?Q?YrB+mgYgkAWqFn8+vO0PzTqW3ZT+rHe/fHF7bt3PSqhWQWOIkW2Tdod/hwZa?=
 =?us-ascii?Q?tppn5ghzVGfUiQ/PMnenA8J07iuGK0JLGwAu992Bl+UvI3V+jodDzFTkRJ3Z?=
 =?us-ascii?Q?1zQV5LIVt/LoCHaUnOOG/mCXxjG6Xde09TNnbhvL3Ktzbu+hGmt9bLs2BqSW?=
 =?us-ascii?Q?qDCcTg94xlrk5MssEpnSqMK84nAgmKLAa6SV+yD54d5qxNRMpn02hkm2baj3?=
 =?us-ascii?Q?KmwPB30PEE8qy06/4oWVkIZdSWizhYgaysoXtsX+pKeK3f5014DvEw3Q93Gf?=
 =?us-ascii?Q?NfyKhES/p4rouBXjyOTwklSiP1UYed9FCUbo6gm/w7ELULWgyCoKLmBHm0Mk?=
 =?us-ascii?Q?RSm2FXzz4E43XwcQGBQ2Kx/gA1toQXUuCEsSEDrUGjqM1J7hmtGN1tLnnRBC?=
 =?us-ascii?Q?gS+ekSg9kIP0xeYtomZgbFowsEDeY0D41wUpbWXGcpk9Y6mtIzEpVx7r+XmO?=
 =?us-ascii?Q?YIrg/zjOb4X7oOXcRVlDefgevai9BpjJqz3E5jCfeST4zVBs4fH/93qsogOw?=
 =?us-ascii?Q?JOESlzKWgZFRH4MX7K865fYhf+lx482MXbe4qW7SgsMi4v5rGKf6URxntpzY?=
 =?us-ascii?Q?weFOJzq18HnqDU23oSakicvJ69SyuQfwKtXgZBaG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894dfc81-9d89-4d30-170d-08de179429e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2025 09:10:25.8558 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8/h3HLG8yjfjF2Tf2+cVLb4TtRtXT7WJ4boXrcNeHtEmZDbx+ZuP8KWTaHb6QNPDnM8cvB56jtRHcir5oDoGmfhbfkyI3EuVLSc4Bi50Xe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8269
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17;
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



>-----Original Message-----
>From: Avihai Horon <avihaih@nvidia.com>
>Subject: Re: [PATCH v4 08/10] vfio/migration: Fix a check on
>vbasedev->iommu_dirty_tracking
>
>
>On 29/10/2025 11:53, Zhenzhong Duan wrote:
>> External email: Use caution opening links or attachments
>>
>>
>> VFIO IOMMU type1 claims to support IOMMU dirty tracking by setting
>> bcontainer->dirty_pages_supported, but in vfio_migration_realize()
>> vbasedev->iommu_dirty_tracking is checked, we should pass
>> bcontainer->dirty_pages_supported to vbasedev->iommu_dirty_tracking
>> in legacy backend so that the check is accurate.
>>
>> Fixes: 30b916778517 ("vfio/common: Allow disabling device dirty page
>tracking")
>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>> ---
>>   hw/vfio/container-legacy.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/container-legacy.c b/hw/vfio/container-legacy.c
>> index dd9c4a6a5a..fa726a2733 100644
>> --- a/hw/vfio/container-legacy.c
>> +++ b/hw/vfio/container-legacy.c
>> @@ -845,6 +845,7 @@ static bool vfio_device_get(VFIOGroup *group,
>const char *name,
>>                               VFIODevice *vbasedev, Error **errp)
>>   {
>>       g_autofree struct vfio_device_info *info =3D NULL;
>> +    VFIOContainer *bcontainer =3D VFIO_IOMMU(group->container);
>>       int fd;
>>
>>       fd =3D vfio_cpr_group_get_device_fd(group->fd, name);
>> @@ -883,7 +884,8 @@ static bool vfio_device_get(VFIOGroup *group,
>const char *name,
>>           }
>>       }
>>
>> -    vfio_device_prepare(vbasedev, VFIO_IOMMU(group->container),
>info);
>> +    vfio_device_prepare(vbasedev, bcontainer, info);
>> +    vbasedev->iommu_dirty_tracking =3D
>bcontainer->dirty_pages_supported;
>
>IIRC, we intentionally don't consider VFIO IOMMU type1 dirty tracking as
>a real dirty tracker, because all it does is mark the whole tracked
>address range as dirty (which is the same as not having dirty tracking
>support at all).

Yes.

>Thus, when vbasedev->iommu_dirty_tracking was introduced, we
>intentionally set it only if IOMMUFD dirty tracking was supported.

Then we have conflict setting of vbasedev->iommu_dirty_tracking and bcontai=
ner->dirty_pages_supported.
We had set bcontainer->dirty_pages_supported =3D true in vfio_get_iommu_inf=
o_migration().

bcontainer->dirty_pages_supported is checked in dirty tracking related func=
tions of container scope,
e.g., vfio_container_set_dirty_page_tracking() and vfio_container_query_dir=
ty_bitmap(). If we take the
legacy backend ditry tracking as not supported, we should set it to false, =
is that work for you?

>
>So, I don't think this patch needed.

Yes, if we set bcontainer->dirty_pages_supported =3D false, this patch and =
patch9 are both not needed.

>
>BTW, do you have a real production use case for migration with VFIO
>IOMMU type1 dirty tracking? I mean, is the scenario you described in
>patch #7 a real use case or you just fixed it for completeness?
>If there is no use case, maybe patch #9 is not really needed?

patch7 is a real use case, in guest, we switch device from IOMMU domain to =
block domain and see the issue.
We need to send accurate unmap notification with actual mapping during migr=
ation, for both backend.

patch9 is specifically for unmap_bitmap(), it's needed as long as we set bc=
ontainer->dirty_pages_supported =3D true for legacy backend,
because vfio_legacy_dma_unmap_one checks bcontainer->dirty_pages_supported.

Thanks
Zhenzhong

