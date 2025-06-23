Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0C26C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 10:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTegm-0006rt-HV; Mon, 23 Jun 2025 06:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTegj-0006rG-LS
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:46:10 -0400
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uTege-0003Vy-Hz
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 06:46:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750675564; x=1782211564;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=L4ZfE9++YybpYK66NcJLIwaYPKA64qKrYBPx4yy/ap0=;
 b=CMfl+zvU+A4vChwW/8XhSpWhE0ulC4S8FI2HFKwHaux3pt47DTk+MOSP
 ARIqt0o+7kXfRKPDWEyLJRVdFkeaZRkNaQvq3GGsFtthKOfrwZN0vKaLA
 Op+084MsAiNx7N3E2TuKsNLHCjhkmVj/97qhNw7sAw5/1zwWixQfcqJNv
 HQf4Vj9WeyX2WFmF5YUngkcrL7ZcToJNiEOtKfdJY12eG4tGwzdEmegv4
 LDVMCyovuTHOIEJCkAvnMx1g9klmBkw5IReQezMIlCZW6fFUGdC28JwNn
 R9pOSj9+Ic11wHY7hW/eHifTQZwBRB+ayUoyUN8sWpmr3gokBKvHsd0ug Q==;
X-CSE-ConnectionGUID: r0dk1fsiSIyila6fIk266A==
X-CSE-MsgGUID: kb/tyAjfQ8KLFVUi12fwUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="55510490"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="55510490"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:46:01 -0700
X-CSE-ConnectionGUID: VcvD2VY0SduZPXnpJ6sE8Q==
X-CSE-MsgGUID: zmLuIvPmTgeSRzM05E+MyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; d="scan'208";a="152082760"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2025 03:46:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:46:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 23 Jun 2025 03:46:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 23 Jun 2025 03:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWRH+a9wCZG+Y00z9XRoQxncIckljROTCoKFXa/H3hYFVHF9vwgqogwrCIS6g9YHugULAWjidVcEQnntyPziwa35uVfriaK8MVZU4Q1L5CIMgFar3KTigSeBbHa7M4/aY83z3qIegeJJ4NQU65SkaIyCYvrk/pjlnL6mgV5HYNN94frMsAbb3aMoegI0kn5uCF+cM6Gbd/Cyjnnd79lN6PhztNGrKk1PwCtLPAJybeX8RCiVpQQp+oO3MLvbxuts7Gg5296QY8Q1z61f9JeEuqqFGstVtAYrd/novttkxbCGPjEBX+vjL7TIJQFrmAXoZdxyT1JzL5+mvQPFfwpunQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rjFLANzGVJC6Iewdrq5GxlHv1mD77ELfgfCIiaNPT0g=;
 b=DNOPMH1CjQZFl3NFBJYl1MCiva/E+VJI6s75pmltrVq8akI2fjYJ48GKpK1HQApQWR8FlYBbmRhN0Q1PGAhacd561uuDxulZqrVypRXhhABCorZ497cYPBKcOY6YVPOCBL50xxEI6myt2vJsTH7jUiZaFe2F2Ls1fLUvvSW37cxs6qrsdDq2WeUQIdLhvQ6Mm5b/uo2OoWaYPZMyVHMzJME9jLWM7IiP/DH/bn2xrETsxDLxp4V/nwgzdvjqYzfvojbn7navmgFe28UNeonkUOgM6cChyfDDD1Pp0x0Kv3RrspGpW7qTtzCqT7xeTXumXpUs5/HHPvrJGrgkoIMovA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB8180.namprd11.prod.outlook.com (2603:10b6:8:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 10:45:53 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8835.023; Mon, 23 Jun 2025
 10:45:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Steve Sistare <steven.sistare@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger
 <eric.auger@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Marcel
 Apfelbaum" <marcel.apfelbaum@gmail.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: RE: [PATCH V5 31/38] vfio/iommufd: cpr state
Thread-Topic: [PATCH V5 31/38] vfio/iommufd: cpr state
Thread-Index: AQHb2h4NVeUNEp49j0+Outy3gmpN/7QQozaA
Date: Mon, 23 Jun 2025 10:45:53 +0000
Message-ID: <IA3PR11MB913698E6A59B6531BEF5F60E9279A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <1749569991-25171-1-git-send-email-steven.sistare@oracle.com>
 <1749569991-25171-32-git-send-email-steven.sistare@oracle.com>
In-Reply-To: <1749569991-25171-32-git-send-email-steven.sistare@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB8180:EE_
x-ms-office365-filtering-correlation-id: 305844d6-5dea-4756-57c0-08ddb243208f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fV9UMrrt1HQqrl78toqEEO40VpYDqtC/Qfnxsyox6hwakelpWZgywZww4xG8?=
 =?us-ascii?Q?3WmX5miMAxcly2LFAAhn7I1bBGZXZfszMd7nePHpG38rSs0dfxVR8T8cf2ep?=
 =?us-ascii?Q?BOem6EK0Jt8P1MP8ZNtyI6dsVZ/6FZDn/klPgmeMYgnKGebwnYZrddP5YCeG?=
 =?us-ascii?Q?5a45kaBVgLQDtUboyN7+uO7ixkHbehD9O3YIrgMG14HbXeC0vrwc1WKAplyy?=
 =?us-ascii?Q?jb8+0uN/hMplSkFG8UvABMLqFAjtnBIpNuS98hXuSLdfgDmxT2Tt1bGVMf8z?=
 =?us-ascii?Q?NWUctMVPlCOnOx04BSjiTtBo8Dee2LYIHPyG5VLKYJhrJEmnpwaDLcCSmLIg?=
 =?us-ascii?Q?12rQbpmqkaXsW3XT6ds1mVkySX1wzloIqmlHqbANLcVGwn+5UGlEMco+iPme?=
 =?us-ascii?Q?iR+vl/I5sM+43mco7Adw3VK/8T5gk15RQmsBZ4cX4t4rtkiBL02W3tZ8Xfuj?=
 =?us-ascii?Q?WhRz8O/HHPX57CKBhEwxVtgFo4U4NW2/ynX+i+k+upJ5LFxCI01HLFuYk82h?=
 =?us-ascii?Q?Xwn/c4Db6r2xUTAjG5grewTi9r6HfU6Aze78dKY/cEmQ5BGMtPclGPEPyo3Y?=
 =?us-ascii?Q?AUsDXsiNvpVOdRpH7I9Krpv9s47Xq92dsUX5WWNbji13yFuBiZwVKRXdL8XV?=
 =?us-ascii?Q?Z+f0U4mrebLYBMi35vcTuIdcGwBnv9VoLWvsKDbXyR3Ln+Rcmag3dlz2Wf5L?=
 =?us-ascii?Q?NKT3PnZixEMgpm/VgMDGkwhNBh8+3/kIFc8HAQQxw2cwRUqoiqbXCCZGWOb2?=
 =?us-ascii?Q?uHQcOYlL8Bw4n0E76Q3zswBmLF9SzIl7MLnzAYGFkts33EK52CEpNYdkO6+x?=
 =?us-ascii?Q?3zkMxcjGzmGocmjPjkUUjIm8I7T+CuS8qB+7cujK/M3ueX6t79D+vZJHdshP?=
 =?us-ascii?Q?4fmYanUoWpXY3KEeIOnQXbhKmDt1U4FxYfDE8dY6OmOZinerc6jgzte34/9l?=
 =?us-ascii?Q?MTQZt/qARDTvDLAaTE0I74jTJL7wiYfVnwQAibvnoQ8V4NiTJWTwFInlTTzW?=
 =?us-ascii?Q?K1CLTZuTvdWHRIo2+1neG07eMBdADi30XkVdjRCP6KAJrj8Sf6T1FS58wMSx?=
 =?us-ascii?Q?1ZgHTfgyBI3YrHxKVXefekMzznaYljNua8c4LARQJhy8HSt8UaWee7J2lHfo?=
 =?us-ascii?Q?NA9Bpx7o6QbYcsW2bMl2ZG5o0qjY3EqDb20+4tRB/J05x09AEO47gIVgQI10?=
 =?us-ascii?Q?H+9ievIIs1Q5ZnhwclwGXcHMkiEckrbNt98rfIL6wBj6jCcVDo3YueobC/ei?=
 =?us-ascii?Q?Ww/JRaQkElB34ZUzndnxxwxGCnXPNuNWdFJtbkjzajbKzcgjjj1i88uCQVXG?=
 =?us-ascii?Q?S7VHivKFSoZGas6EKC6oK4Un5tj7Iex/TrEHL65Cj+gdULrLg7hudBIgiZpN?=
 =?us-ascii?Q?h9QLwjknv3pQYmWxzx+9tdpKz8nK0EVpsViJ7MQzrY3VFLvHCLjrsei6MWnY?=
 =?us-ascii?Q?kH7hH/axq9JZDJhrpcBlepRmDSfu+mYv8WaW0fLqqXqEZrfLh9tBr90dUPhl?=
 =?us-ascii?Q?aS9BvY9K8+5UU/A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WD2QtdARovbpytjhHssJ1BCO28ywLjOvuBnhwvD56ilFe2kYlBObG16tko58?=
 =?us-ascii?Q?uAY9QBPRURegdI3w9How+AuTHy1niVJsIJcfjVjSxE/To5yGJPpKv8LW7qws?=
 =?us-ascii?Q?vqfKR6f/Prs+Jn9dpjYR8nqTnnDGVQ86NblxRjNLRS/iSE1SJ7R6FtPdTrOv?=
 =?us-ascii?Q?Sz9t7DVe1Xx3/dRjMtQ2FjbzhOthr1BfJGwxFs6KrFpGbWgGBbUCv6cdtxMw?=
 =?us-ascii?Q?rNjnO99BuzUEGV7iDM6EVtMCQoojsYEQov2UTFzy3JJWR4XUxylgRbZmau8+?=
 =?us-ascii?Q?LCdyuvqmDk/UQ4XPBVxNE7qkxjqxYuQfNLOJLwQozsd5CqrtO2CVT1++9uwM?=
 =?us-ascii?Q?jXCJtv8yg58IMmwT4h6wwH4o7zXmpNREp1QT9LuaL8kZ4ITcDotoZaSDbhTV?=
 =?us-ascii?Q?IZcSTkHE6Pek1oUtzhjXcNPS9cSw/poF3duZ+rFlahsBUj8f/gNgEvhk5MwY?=
 =?us-ascii?Q?si4SssU8+1pznmh9EexV2muMLNBKlRL/bkICD6T2nuU22EX9VZpXdyPR799z?=
 =?us-ascii?Q?0uuTNKGCA3CkJSgZqC6sW7CCkJseBZsrt7ldGg7uC17dW6Jm+Zb30K59KVyC?=
 =?us-ascii?Q?rFj28KVJLj0GbN8bVOffp/VDEyylfUCDVYLHhHlIwc74RRt2vS5IaQYNY30Q?=
 =?us-ascii?Q?Bn676ihCta5YbCeEXwoVYa+iZD/5rbZ7j9X2QCSBEQLMkyNxDhLh+5e5tYwY?=
 =?us-ascii?Q?yH3miGInmGoCuaoS3JR2QBILI6jd9xwJfY+wTi/eWdaegmmcA3osEgFX1NI8?=
 =?us-ascii?Q?uocmnF893MvURSc4sMkAKfcLzA7aGD7BH7Y3VI5Uu4kmfIZoKW5WzIrB+bF0?=
 =?us-ascii?Q?NHCI7ojhhc5WCs6x4msTHUkWTK6waGK4hQoyj4NMo0sagguPCu7+bcZ52e+j?=
 =?us-ascii?Q?4eviymGstS09F+i/g4LJ4XGpTSI0yKncOcWETsjXi38GDnf7efA82PzT9qpg?=
 =?us-ascii?Q?nDz1hdL8UtT+4Ktbx2oEkwmVNyygPZ06BaTIndWCIohYqMDvWmy2BTH2HDO0?=
 =?us-ascii?Q?zVxBUBabk0Vj+6lO1ZwmHf+VKx0+Ypviu5riVCyYKf5hjwIM/FEh/iu8vaLd?=
 =?us-ascii?Q?2LzC/ZkyGZ8V0eLdSK+ahMH3iMoaDrJt2aV/kwWkADhtM/hGywkJ/CvKJbd/?=
 =?us-ascii?Q?D6GqIgjdFMOojH4T+NJ6HwU9F9kiDqvPDyI3TBrBRRoC68tr/DvDCVzeOuNq?=
 =?us-ascii?Q?wxjdyPN3H/d+yZ4SZ6rt6oVGwlbejF1JJFR3mlLaWmEU6X083iEpViRSyxn+?=
 =?us-ascii?Q?RdmPPUkyVaOIqpWdHmHckErTZTOhP0AZfK3zmxnpgO1wCBu8bnMJLfwNDEiC?=
 =?us-ascii?Q?nnpRdlntSACCLemGyA7ERW+74PXwOMKvR6zy+jMEGNHLgy2347HoMxHp55X7?=
 =?us-ascii?Q?8eZNuaLIpYVD7nT6/S9eVHd2d9UEXPiLOuzPh6wPpC6kMVDE6y1B1ok/TtB1?=
 =?us-ascii?Q?t13Su6FAC0Bwan+Jb0a2WVhpclyFs1gdYAnetldMfkKn8Hwyu6f0WFnidT5y?=
 =?us-ascii?Q?SUblFXEBL5UExUAk7LOrUD/GIT9Vau39S6XNx5dYGfogY5obEs74oB4ANGNz?=
 =?us-ascii?Q?8Ucz1Q6JszS3eCXVQcIsH2zY4c6VHA+JR8pHeoEWO+xas8yzfh7Xs9pyKSjZ?=
 =?us-ascii?Q?SA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305844d6-5dea-4756-57c0-08ddb243208f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 10:45:53.5070 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1iazWHmtXgRx4guFs58pA88z186scMr2qQ+vFIKcTMEOyWlHWbVTQ6fkJGLqFTsTgkH3suQc9ixphgQCwDGk2fhR0DqnsEazacbTCHlgw6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8180
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
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
>From: Steve Sistare <steven.sistare@oracle.com>
>Subject: [PATCH V5 31/38] vfio/iommufd: cpr state
>
>VFIO iommufd devices will need access to ioas_id, devid, and hwpt_id in
>new QEMU at realize time, so add them to CPR state.  Define CprVFIODevice
>as the object which holds the state and is serialized to the vmstate file.
>Define accessors to copy state between VFIODevice and CprVFIODevice.
>
>Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>---
> include/hw/vfio/vfio-cpr.h |  3 ++
> hw/vfio/cpr-iommufd.c      | 96
>+++++++++++++++++++++++++++++++++++++++++++++-
> hw/vfio/iommufd.c          |  2 +
> 3 files changed, 100 insertions(+), 1 deletion(-)
>
>diff --git a/include/hw/vfio/vfio-cpr.h b/include/hw/vfio/vfio-cpr.h
>index 619af07..f88e4ba 100644
>--- a/include/hw/vfio/vfio-cpr.h
>+++ b/include/hw/vfio/vfio-cpr.h
>@@ -33,6 +33,8 @@ typedef struct VFIOContainerCPR {
> typedef struct VFIODeviceCPR {
>     Error *mdev_blocker;
>     Error *id_blocker;
>+    uint32_t hwpt_id;
>+    uint32_t ioas_id;
> } VFIODeviceCPR;
>
> bool vfio_legacy_cpr_register_container(struct VFIOContainer *container,
>@@ -54,6 +56,7 @@ bool vfio_iommufd_cpr_register_iommufd(struct
>IOMMUFDBackend *be, Error **errp);
> void vfio_iommufd_cpr_unregister_iommufd(struct IOMMUFDBackend *be);
> void vfio_iommufd_cpr_register_device(struct VFIODevice *vbasedev);
> void vfio_iommufd_cpr_unregister_device(struct VFIODevice *vbasedev);
>+void vfio_cpr_load_device(struct VFIODevice *vbasedev);
>
> int vfio_cpr_group_get_device_fd(int d, const char *name);
>
>diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
>index 3e78265..2eca8a6 100644
>--- a/hw/vfio/cpr-iommufd.c
>+++ b/hw/vfio/cpr-iommufd.c
>@@ -7,6 +7,7 @@
> #include "qemu/osdep.h"
> #include "qapi/error.h"
> #include "hw/vfio/vfio-cpr.h"
>+#include "hw/vfio/vfio-device.h"
> #include "migration/blocker.h"
> #include "migration/cpr.h"
> #include "migration/migration.h"
>@@ -14,7 +15,88 @@
> #include "system/iommufd.h"
> #include "vfio-iommufd.h"
>
>-const VMStateDescription vmstate_cpr_vfio_devices;  /* TBD in a later pat=
ch */
>+typedef struct CprVFIODevice {
>+    char *name;
>+    unsigned int namelen;
>+    uint32_t ioas_id;
>+    int devid;
>+    uint32_t hwpt_id;
>+    QLIST_ENTRY(CprVFIODevice) next;
>+} CprVFIODevice;
>+
>+static const VMStateDescription vmstate_cpr_vfio_device =3D {
>+    .name =3D "cpr vfio device",
>+    .version_id =3D 1,
>+    .minimum_version_id =3D 1,
>+    .fields =3D (VMStateField[]) {
>+        VMSTATE_UINT32(namelen, CprVFIODevice),
>+        VMSTATE_VBUFFER_ALLOC_UINT32(name, CprVFIODevice, 0, NULL,
>namelen),
>+        VMSTATE_INT32(devid, CprVFIODevice),
>+        VMSTATE_UINT32(ioas_id, CprVFIODevice),
>+        VMSTATE_UINT32(hwpt_id, CprVFIODevice),
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+const VMStateDescription vmstate_cpr_vfio_devices =3D {
>+    .name =3D CPR_STATE "/vfio devices",
>+    .version_id =3D 1,
>+    .minimum_version_id =3D 1,
>+    .fields =3D (const VMStateField[]){
>+        VMSTATE_QLIST_V(vfio_devices, CprState, 1, vmstate_cpr_vfio_devic=
e,
>+                        CprVFIODevice, next),
>+        VMSTATE_END_OF_LIST()
>+    }
>+};
>+
>+static void vfio_cpr_save_device(VFIODevice *vbasedev)
>+{
>+    CprVFIODevice *elem =3D g_new0(CprVFIODevice, 1);
>+
>+    elem->name =3D g_strdup(vbasedev->name);
>+    elem->namelen =3D strlen(vbasedev->name) + 1;
>+    elem->ioas_id =3D vbasedev->cpr.ioas_id;
>+    elem->devid =3D vbasedev->devid;
>+    elem->hwpt_id =3D vbasedev->cpr.hwpt_id;
>+    QLIST_INSERT_HEAD(&cpr_state.vfio_devices, elem, next);
>+}
>+
>+static CprVFIODevice *find_device(const char *name)
>+{
>+    CprVFIODeviceList *head =3D &cpr_state.vfio_devices;
>+    CprVFIODevice *elem;
>+
>+    QLIST_FOREACH(elem, head, next) {
>+        if (!strcmp(elem->name, name)) {
>+            return elem;
>+        }
>+    }
>+    return NULL;
>+}
>+
>+static void vfio_cpr_delete_device(const char *name)
>+{
>+    CprVFIODevice *elem =3D find_device(name);
>+
>+    if (elem) {
>+        QLIST_REMOVE(elem, next);
>+        g_free(elem->name);
>+        g_free(elem);
>+    }
>+}
>+
>+static bool vfio_cpr_find_device(VFIODevice *vbasedev)

Better to rename as vfio_cpr_load_device

>+{
>+    CprVFIODevice *elem =3D find_device(vbasedev->name);
>+
>+    if (elem) {
>+        vbasedev->cpr.ioas_id =3D elem->ioas_id;
>+        vbasedev->devid =3D elem->devid;
>+        vbasedev->cpr.hwpt_id =3D elem->hwpt_id;
>+        return true;
>+    }
>+    return false;
>+}
>
> static bool vfio_cpr_supported(IOMMUFDBackend *be, Error **errp)
> {
>@@ -79,8 +161,20 @@ void
>vfio_iommufd_cpr_unregister_container(VFIOIOMMUFDContainer *container)
>
> void vfio_iommufd_cpr_register_device(VFIODevice *vbasedev)
> {
>+    if (!cpr_is_incoming()) {
>+        vfio_cpr_save_device(vbasedev);
>+    }
> }
>
> void vfio_iommufd_cpr_unregister_device(VFIODevice *vbasedev)
> {
>+    vfio_cpr_delete_device(vbasedev->name);
>+}
>+
>+void vfio_cpr_load_device(VFIODevice *vbasedev)
>+{
>+    if (cpr_is_incoming()) {
>+        bool ret =3D vfio_cpr_find_device(vbasedev);
>+        g_assert(ret);
>+    }
> }
>diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>index ff291be..f0d57ea 100644
>--- a/hw/vfio/iommufd.c
>+++ b/hw/vfio/iommufd.c
>@@ -515,6 +515,8 @@ static bool iommufd_cdev_attach(const char *name,
>VFIODevice *vbasedev,
>     const VFIOIOMMUClass *iommufd_vioc =3D
>
>VFIO_IOMMU_CLASS(object_class_by_name(TYPE_VFIO_IOMMU_IOMMUFD));
>
>+    vfio_cpr_load_device(vbasedev);

This can be open coded.

Thanks
Zhenzhong

>+
>     if (vbasedev->fd < 0) {
>         devfd =3D iommufd_cdev_getfd(vbasedev->sysfsdev, errp);
>         if (devfd < 0) {
>--
>1.8.3.1


