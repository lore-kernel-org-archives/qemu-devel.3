Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC9B2C5AE5D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 10:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtNWJ-0002dU-4a; Mon, 10 Aug 2026 06:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wtNWE-0002cw-Rg
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:46:13 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wtNWD-0001Vd-2I
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 06:46:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786358769; x=1817894769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=V+urOfr45uW6/YZckN00X/juVO19d/GejQW+ymscORc=;
 b=KzFAe7Ug4eKnq3qC+PV1mM+Z1Zyxb+23SiLJnrqu+dwCP7EGyI6tTOwm
 GSxM8Iw9ndQ8qTlKtRqfyJ8Ss2OyeJJGDRCVRgzv27sDYVBFdInc4/uB/
 lka0fex7sj63uzPa0rCa17JVvbLP7ZVMfAcP3KCA3kyKU+h6MKugtVXlu
 YH5o3BWsdu48jWZm9xuoO9FGoPw6Fv3Gksoh7sgRy4loKCMnejIh6MYom
 KZkk2ViM5iDMhXv/RerqWjL66PBy5NsjT17J2Utl3Mo0o24GyifFR9raT
 EoP37ul3yrVrjUoDFW5nUgKI6+muRZed9r2uKtoMYlg6sdcwTr/4LDrPq Q==;
X-CSE-ConnectionGUID: bWGun6KURjW8Az4QwtONAA==
X-CSE-MsgGUID: /q8e4b94QrKJa6WTVuqtDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97522672"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="97522672"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 03:46:05 -0700
X-CSE-ConnectionGUID: 6FbyNvZBQlatUSaXUcr14w==
X-CSE-MsgGUID: Vq1ROjtwSSyMt1Mky4/aSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; d="scan'208";a="261266527"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 03:46:05 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 03:46:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 03:46:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.26) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 03:46:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xsa4DO8MHQydDONALXEFG+/xjqF/KlunV7M3FgtzimupLb5D0y4LbMU3SLtV9pKWJIoh33u0U8PAljRuSpZA+YWmxgBXC3Ev0d4Glh2+iSljnzvWlZnocDY3iB1PbZRUJJONDKYPWjT31tiO0DAeBGWKK+/aXRz/7cRdg3C1foQTiPL6zXkhra2FDuRCMdTleKRlZfjzGqCEzfwckOFotl74kTisG0zaDCJDJU7Ed8c7CBuey39gdFyNAvd13glrjpSQFNkAxgLDEFllbahwwRZsnAUCmXYz3kCjPIOLTLp5jr3zCUPoFUtmIYDU+4CnifP2+4wHGhBJfDpiz4YD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+urOfr45uW6/YZckN00X/juVO19d/GejQW+ymscORc=;
 b=QkKg6bXoeFAK/HSAf2MlaqPiflAb0UjIv2COrjwq0HfKvl5Sh49gEMft9yMQhPLXIcBRhxk8TG9UMBSC5qzxUW3+IuBpmRXD7IA8yevC0WueHLEyUvcy51RmGl0J4UQtMGOIvMdK6Km8191uLLnIg07fL+LDNErVW9ETkP7N3khLLza4JoJVq8VlMXO9uH5iXp3d6LYrNcd57twtd8ioy3x2DjNu/uMNBI4k+5sSuZUx9FNN3pT54mBenlBIU9KZJPyGM5ky/ZRPaD9aZvreAfrljAod27zFBC7LNqK69tp9lbTSOBJvKuxCnY9qbFkUlzguCe3JqIvUxaW7oVYqnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7421.namprd11.prod.outlook.com (2603:10b6:510:281::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:45:56 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 10:45:56 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?Cl=E9ment_MATHIEU--DRIF?= <clement.mathieu--drif@bull.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "pbonzini@redhat.com" <pbonzini@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jasowangio@gmail.com" <jasowangio@gmail.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Topic: [PATCH v2] intel_iommu: Expose SMPWC when SVM is enabled
Thread-Index: AQHdJ0u05hBgRFNdVEyKKLViqh+TG7aXG+CQ
Date: Mon, 10 Aug 2026 10:45:55 +0000
Message-ID: <IA3PR11MB9136BEEE9E73ED4FB69EEF2192DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260808153626.873965-1-clement.mathieu--drif@bull.com>
In-Reply-To: <20260808153626.873965-1-clement.mathieu--drif@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7421:EE_
x-ms-office365-filtering-correlation-id: c23431a0-9773-4d58-99a6-08def6cc8ea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|38070700021|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
x-microsoft-antispam-message-info: nmWlHR994ibdr96X6mWvWEECh8ExuxG45AciVIf1zi+Pfjyw2MDC6iVer9qzf92Lzdq+GYOvBeiinjjfg1ltzdJyaHVZ5+onFur0cR1oKClfFzsMIyTwtIkqhpEQ8kBoGhttdSB5oXAP54NtCRF3RhjFHiVOz0HI+9cZOpDTU+4UTwOuHw48GypE6PeBY8jtHICj8fxNT7ysqT0PtYgUoKPtxSVNqq5/EEOGeOxnB9KmlvXIryBsUyJZQGNGVCyKzM46jZkKkhBMScunnyPqpT8c26W6hrETEh9T0Eg8HoXiXbjlLhvVYaGPAKAQz5+kUxXtx+es2j0nNhli7S8NfiddriG+uQsP5pRG4ujSlslZPeO2aPQZryR3wJgh01Sr8c7SHyCjlpRqfAWhxjpG3pU5vy+PlKrurfIKdzeQhIiTqHcyiqR6cfjTGOT/CKkTDhqeTC8bOfV/NQc9/aIYGDdaW2JGk/hk3ffd/S9nOxDtaeHMXgttU9GfF8HqAtNT9tNl6gbOUcq3aU3TViQHFaEKmmRX7uEl070bRGXOsWnVr+7pcBVNBt2HxQ8gQhFtHEHNB76fxxtrtv9a7CVH9xYibG+4UXhIytokdRJ62OvuSbeCfZBfq8MMbQFlkhzIJ8JH76LiLHJVfccn8CiLE3hEe/B0a1L3uUOm9S6kYTQGRxV+3WdzYfL1e/T6CL4uE+/VFLIm31Ob0muquZg3/4+BgCHxYHKsSuzNsjfZAeA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?i5XpcGd6F3vicFRELG5GRz1c3+LIQou0qzW87gvXmyBxl23zvoxImEoDwr?=
 =?iso-8859-1?Q?jVuzVC0bgM8+cwpVsAq1NT3aYDXDQOWBWVrLmcPNTeL5+0luIRQQCTOmbM?=
 =?iso-8859-1?Q?o4QzmsTFEy+06zo5jMlj2LexHCWZFi5QgGeMugGZ8VAears4XF3JYV0UKk?=
 =?iso-8859-1?Q?70CVsrmk6y0SZiHDLOYlxPwpy47ArDDRMbuoGIXng9EaYbIcpT7Bx0Y+IA?=
 =?iso-8859-1?Q?xHgKL8yyMqBUgLc8Y3GX93eCsrLJTJEf6pZbvWPNOIBSZRDXM1ZpqjKRsZ?=
 =?iso-8859-1?Q?+6ig1Vov0Y6yUJFTbuQwkMsbTRT8RmSybKOgP/9Ti7E2q+1zbA3J/Z9fpD?=
 =?iso-8859-1?Q?xbqfrMmm8sFei/RrKn4wcCzRoyi61TLj7mdxAZloZSeFXwaSQ1nGc6jmb3?=
 =?iso-8859-1?Q?qw7PxWexAAqYWnFD8ZFHpTNPaZZD6Cdl2IR9+lFROMD9Lo6PnnBR5dRKCV?=
 =?iso-8859-1?Q?jWll6uJ459pAs262pXQZbPhGsob1xlyEJ98408jj7vMm8wg4724WK/3NRx?=
 =?iso-8859-1?Q?NuqgyRefeVFIb9ookm1/8rzbcMqZBZ+WV7nOT9B6rRzSENXrEAfcmErnM8?=
 =?iso-8859-1?Q?pbULWiJdyhrhTxXjMcPR7tWER4ws2czpfIhuGYoHKjevtXCsRqr4UJMd/A?=
 =?iso-8859-1?Q?739hp9CaNiZHpha+dPevp8B6Zg3AxK47UIAiNUGQPbueW64mrCJKMkEey4?=
 =?iso-8859-1?Q?PSID12/0BZ7J5b1krX0eVrk27oV+xyt+g3M+6dQk0TvOeoG8ssqtNlL2mH?=
 =?iso-8859-1?Q?Zkv0G/FsZ3e1lEPEBf3T+sGInvFnvGM2tMHva0xctUh+C7pErJhsDVo6IJ?=
 =?iso-8859-1?Q?fsfg9MVPfSjZ6qPkYljd5tJtkje0gj0pdaGnBl2m6rwN1cWnwr6UWUEYql?=
 =?iso-8859-1?Q?h5kTOLvfgVIbgRSpS/PG4sAkUxWToO9rNyZlY5B3rcpLfl44PuwHMyByln?=
 =?iso-8859-1?Q?xyFE/O5jaNHzf195KchPxIlz/1r38fVXFJjjyxnn34kbem767rH/dYtS3f?=
 =?iso-8859-1?Q?E9xcQjZJL/2zKbwacdhp7K3nQ2dbU1A1BP8/YhFfEaLhjAfctM6azCXfq/?=
 =?iso-8859-1?Q?TUGgEfDp6LDSvumL7oKHDollFP1N+E7366NMdXYAAwP83JvVxhpFD3hwj3?=
 =?iso-8859-1?Q?04+orWxSeJ9qLOKtSTJFTPhJIeGjgCFHuZjFFMOFsViRJmbFEHU3eqPkC8?=
 =?iso-8859-1?Q?4clJiQJBiEzninS7Abh21QcNot1lb371/7a39R2WKUthKeNFg5Ba9MTD2X?=
 =?iso-8859-1?Q?nzB7LizSH4J4weSsUR2vZhljxjMbe9occG0UzSq4rBa+5zHkLVdpX4KINw?=
 =?iso-8859-1?Q?xS6oa3WqTOk80RWB2cRFVrfVQIvzyOCbeTCw++/LKpQozH0wGBmTIUtMct?=
 =?iso-8859-1?Q?LgHeU8hXFQFPRSxT3R2mOYNUB9TvgX47AxfH8vq0JwIO9DJgbOGc4EZ5bw?=
 =?iso-8859-1?Q?cOUQVVCqwSmHs2PLn5dnvO/neKzBhUgpvkmGcuFXmDbwR8Va9C5z0Y08tT?=
 =?iso-8859-1?Q?wlcFsHVHim5G34yHJZw4ZVvTY7PacoUGCB/3eMYldCY35K/aUlyAQqbHbG?=
 =?iso-8859-1?Q?n/6PwSQQ9l8yQQHWVmRMPkaepCTzzji/stB+yibzgUs+1MDF0apFLZnXNy?=
 =?iso-8859-1?Q?7H/NcZXOAcVrAqDZh+I+DpKPg8uWeDd6tBuNurvU+de+6u93RPPztzBC2Z?=
 =?iso-8859-1?Q?bqR0qr6jYhbUBLD7dqAHz38e7xYNihdN99obKqLWskC0m6xSp27a3mBzUm?=
 =?iso-8859-1?Q?XbA9ukIO90yOnJM5trCdLBFkIbXK0g19MuImjlfUq/U9haDH05wWARvST0?=
 =?iso-8859-1?Q?2+ZG/jADvA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ETwLeQOQL3qnRxtiLAGlx2tGnVkKLQ4r7LKvYNJGTbyZZG1gF6SIBp4uzNlqdHufgtKzs17SCOikkjZPyk4BPNb4M4uJS816JwZ+3nkIxOzuHLVa7QIiVryW+yYN38GhTDQD+qyLh0v7/6prY0kTQDRwIp7lexMKTSqQ6xbxH2qh5/iGRXE0YDoVk2+scTiYcGnwmpbt0mWd+fg3+pfC2efz/xuc+z4p/F+ymLnAJUS/WDY3T3BKZ4MBinp0tA50remGHnZGnd7FnCkh7IfxfK/6nvk2gEFilQCYYTIKQmMycrS6mYvctTHux6IJtbYNwMDREj3186QWVmKwQM13AA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c23431a0-9773-4d58-99a6-08def6cc8ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2026 10:45:55.9421 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xaLF9Ls71G1Kw4gsLbA4whq+cgqsSrsS7lEcpv1LqWgCnB0ULh+AOolj2jE3+yKsvD1FwNvr//CsDVNzLrKYUhtL9fOwGAK5rpRMi8fjeKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7421
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.827,
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
>From: Cl=E9ment MATHIEU--DRIF <clement.mathieu--drif@bull.com>
>Subject: [PATCH v2] intel_iommu: Expose SMPWC when SVM is enabled
>
>SVM in Linux requires SMPWC. This is free in the current implementation
>as it is already in line with the expected behaviour.
>
>Link:
>https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/=
?id=3D780
>dfed68862
>Fixes: 952e1a6e90eb ("intel_iommu: Add a CLI option to enable SVM")
>Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>

Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>

Thanks
Zhenzhong

