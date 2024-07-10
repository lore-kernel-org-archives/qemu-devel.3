Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDB5C3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 10:39:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRUio-0004rX-An; Wed, 10 Jul 2024 06:38:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRUil-0004qp-Vj
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:38:48 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1sRUij-000639-L5
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 06:38:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1720607926; x=1752143926;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gwEuNQvC9GJWdLnKM8K0Cwu4k0IOm+x7QNzOYWboFSQ=;
 b=LJSFdSCte3GdlE32qeqhWLr7Ku39kcDdkLpHrvkogzRwt/425AaIGugl
 dNcNKVsEckyI/YfRGjElkXM0cQBTq58u/BTWyboSw2H5HRZHiGOdUSYlO
 wi8ROZhP+eRdX8yev+ZtFKHfHcweaHc6twCv+a9jVNCEdfy/OziQSt16W
 dx6lrngD3Rj+3l7NBuxTyM7KVeX9PLt1eARZQwIDCa7o/qAkRZkyOCdHD
 GRTxGEKI7JmJ99I3PcNK36NbYl04J2+YyAfmS54j9rgNM+osWJdYTTP+O
 Ugz7qVbfZmBjSNYN43Vje1U52oDEqpwAqsHtruOfqj6ZSQfTyk7WfkgXK w==;
X-CSE-ConnectionGUID: FC/hnoo6TjOueR1eo4VFrw==
X-CSE-MsgGUID: SBCKA9+xTTSJ4C5kT8uRKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11128"; a="29319744"
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="29319744"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jul 2024 03:38:42 -0700
X-CSE-ConnectionGUID: g+8Q6CjfS+2P3X+mQYxDmA==
X-CSE-MsgGUID: Fh6mWVITR/WodedFdN1ong==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,197,1716274800"; d="scan'208";a="52971394"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Jul 2024 03:38:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 03:38:40 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 10 Jul 2024 03:38:40 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 10 Jul 2024 03:38:40 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 10 Jul 2024 03:38:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksSEcUTd3A2iQM/FBu94QP//29BDwfKcN09AK16+8tZPfl/FeGPjMYI6OixgsE+HZTSI+RmmjMlBATJoHxAAn29GGbPCYizmE991GXSzcQJIeBc1rf8KCVsAujqhgQxqfDm3N6gc7NXC2Z6rPGYES+ZlEdGx1/lkuRwn2VaSazHh8QlpzGnJWI1DYlmtVw+bt73QUPsUh3dBb/J5M6CVMnjyDSXFw+HuR7/ndfviLM4iEQGqottb3fgT3XCIrvkeCqlvTfwxezJX9MREEfhtl1hEk8YAjdW6F8MpN0oUEZ6uCocCEIogeu4fopUAlrZNnDS5PgZHxDvejyt2/icyNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ig9tWwOli4ZFzzMpJ/qeAlBrWSGw3gxPoFwJqqYsOc0=;
 b=crUQUcqSS8jftgiz1yMLYRJMwOMl+NtQYjn36DQRTNeUeH8bkau3uh2w0lJofDpByyODGYXWlY6UZtCCTExVqhUU7DAVYK+759pX1fMtZ15C/Cpr9AffOVQ6YtSb9WCLGS2WELHKfn0cRhZFXmaCTCbgRiKy5t81pjPFZ945ARUudW85qAUyQJB7rR0Q1VML+Ahaj1Zc0PzSPqTlAtaYPfZwJNkoefhew8suWRHgRkLDzdwMD/ruduQjGMug+WOioFCN4k9FdlgTCd2qnSZK8JNLGaHaAUDOo7RhVedQCt4pFT3hGOaGTwuiyy9Q686CsuMmIVAlWH3GpZzF6UeR6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB4937.namprd11.prod.outlook.com (2603:10b6:806:118::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 10:38:37 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%7]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 10:38:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 "Alex Williamson" <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, Avihai Horon
 <avihaih@nvidia.com>
Subject: RE: [PATCH v3 09/10] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Topic: [PATCH v3 09/10] vfio/migration: Don't block migration device
 dirty tracking is unsupported
Thread-Index: AQHa0UQB0lWYuUejGUKr0PfEaOEBMrHvx1KA
Date: Wed, 10 Jul 2024 10:38:37 +0000
Message-ID: <SJ0PR11MB674411D22DA888BD5222B8AE92A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-10-joao.m.martins@oracle.com>
In-Reply-To: <20240708143420.16953-10-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB4937:EE_
x-ms-office365-filtering-correlation-id: 89cb5b1c-2e39-47ab-a706-08dca0cc750c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?duVlTNuCqCdtxKG8w29/cA91nb+KwQWL70kpQjNsrrLJ0Qz/uke0PyHH+fEg?=
 =?us-ascii?Q?cvIOq8I1CxJhsslx7xRVN2Sv4RUcz7hL3oYj+BAilHThqqU8YVmpyWJYB6kt?=
 =?us-ascii?Q?RVcLPqrhS5F+OQuzuqqDH3yV4hxuIFLCJkYJszXivELGMWVYPWZ4FCr4aIDa?=
 =?us-ascii?Q?0j2A2FnNrNkzsJoqgzbEeo6ZdhZrP7oAowPLsP61WQdolF6G39dnqIB2FH4m?=
 =?us-ascii?Q?jRmTyC0l2d4RF0Rv8ELElVaXfvDGIpe69OvrBBj2DcdwzWsE62lI1uQd1/4e?=
 =?us-ascii?Q?k6QUfeoauHkhW4Gf9EaiRbAfxSTc+B+v2ujoo/OX4mHNDov1HXlnsBiXCRCE?=
 =?us-ascii?Q?2HiDuifVgov2Q4A+DrTc3KW6acQcgxvoWXDYGkeGPeS+gKQs7C2MxamVadRP?=
 =?us-ascii?Q?1kiE+CUsovde3Zq2Tb085lKpQWlau3BCCxWU1vEDrmjtIL5BoX2gdtJxO1Gh?=
 =?us-ascii?Q?nkDfcuWhw8yi9n+fwnciukcxaR6bLtTL/lsewbXRM0J/rL9jrVx8fVVtiFfp?=
 =?us-ascii?Q?W4gSu+JvQbjz5mxRfA8rQa2Y1AfY6kjGHHtoculiiZPwA9YBPjtlDseDJdDn?=
 =?us-ascii?Q?Dv8uZ4/SgMYFLB0xqwheeEAFlrY7rsepnidjA0a5KJRqNUo/J/CusEbWw298?=
 =?us-ascii?Q?4fuNZ6bwevedq6wJARO1zZQ+1fke1SXxiQ6fbpaS8JW9GSZBTbYhudRRe6gz?=
 =?us-ascii?Q?YejJlDon6Z7nMOm1GjD/AdypZpH1oiZiamTm8mUBryzbqpstpVGueAXe3hHk?=
 =?us-ascii?Q?a6gSeQzJOaVrTMu2V+wY5i/MqiBV6XPkCN6uQiNDoWMXOMKmejmMc6AjTIkg?=
 =?us-ascii?Q?2hTR+Cqrajw6vgdEjUrz73ppgfQT5LMLkR19fu41acOXxWPISY24bHfC8p2n?=
 =?us-ascii?Q?Li9O5QrWh192FsK+pJByiDi4Duc08B0d/dK5YrTPcQ5o/rQB/+Hp1V66SV4C?=
 =?us-ascii?Q?zsOKaS9yJz+JQ4keMtt4Ng4FclXYqmRPurCm0X7ZNZ4VwKnepHCTZ9KSsXxn?=
 =?us-ascii?Q?R3eDgLvYZOHqHm/gLjsm9DXKinnDkeS64QwgN3oAjJTWgeCy4Vlf8wOlkswh?=
 =?us-ascii?Q?I6rCEVs03lVZzCfh+qfUOHorfez6E37CE3V6ETX5whqSaHxzZ0tAKNCiAq3P?=
 =?us-ascii?Q?PHwej1bPuE0IPSdw8UUzk0/mTngBmnvBnX/nNyhSKhDoTUniDIa9M4He34sf?=
 =?us-ascii?Q?I82TWjJTKBdUfSqdJ81ohIZzA0vh4CCXzpBVbjgN6+6UbnVVS2ETzY4eOMzu?=
 =?us-ascii?Q?eZn7w6HQGxL9l7YxNjyHiE4/AtRyfVync2jxut8potgGdxwjakRPhJyTlWz1?=
 =?us-ascii?Q?jIvv1hhm3QsO1h/ZBQ+dRAtM/KNpC/x93Ajz33/TZpbE3o0U5Ole1z/werfC?=
 =?us-ascii?Q?Rbrv2BXz2oFMucyqFhrh4ZF+Mi12ClQNT4lCMTz5HwtpW60qyg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KuW5IdKOXmfmRybD7/pg2j85by0qnwfNNiPZgbUeqCwgJU2tRaS08jpROOQh?=
 =?us-ascii?Q?pT7Y3Y6QHJYpwEScJOtXE+ZmK6vPmiBVAn1HCDAh3oeJWba2OZsfJMRbROiT?=
 =?us-ascii?Q?pCiTxf/mw3U8DU1sTML7zl4o6UM9Xhb41U8SpyH99VUMz2ri34jM5hgelody?=
 =?us-ascii?Q?krKQ8IIFCs/tFwV3TUN1hGyj7Ts2mnQ1jMP3lL2SW8qtzTEPwWkiEG+/zFAz?=
 =?us-ascii?Q?lEVaThlEXwdrdj8A9KOXT6R51bCqYKZlweMnfUInmNqIUup4/JwieLSsrVJ1?=
 =?us-ascii?Q?1WFFjbN7dOm69OSz8RVkLJAG9K3zO2upUz9IpUwqWKjihaJNnktL9olRvKaK?=
 =?us-ascii?Q?T3x+eCrmtVIC2swSFfgCYZBQz6HNkL5J1V/0DbGt0csWS2ZkuI4hPspOR29q?=
 =?us-ascii?Q?6L1u7PDIywb6x76uQ3lhwYo8p9XyoLf4P+B46gb7fPSH095k7+kq5pvkkRJJ?=
 =?us-ascii?Q?uWkuXy9aOvslWiaaM66D+V+Cpg0niqG70C+lF7ujRJEk4QyUq88cLorBFer1?=
 =?us-ascii?Q?pYZ7mIe0x4v+uy+unMH3IllNN0C/e+9zLoulympx9mK7osyd8f+vlSlT8nBD?=
 =?us-ascii?Q?sYCw9EOzEAwsvi/X7b2VuzIgBSkbJTB3Lxt4CSlvqgoVNLCfYslQFnmMpcOd?=
 =?us-ascii?Q?BET/zzty4eMobSqn+jQe2Z9J8iIENB6aOXQ6RJwVXncWft+JoFsMYPQLWivj?=
 =?us-ascii?Q?jLXqSdupjkqkHm5R0Nz4b/jTahvI6XR8P95P539luJ0KSKKrT4RqgWufDlBa?=
 =?us-ascii?Q?dVBQo2VZThK6mIBj+AYWZ4DJDe4GiKeAmyNdTbd5JqXg8fzIRYsED0SCqRsq?=
 =?us-ascii?Q?n2hZtdkemFZWtOyOOJqf+Fo7g1jPFHO3jv/LbCGGR9hi0VoglSfFbm1HlNLY?=
 =?us-ascii?Q?6dchrgAxAmQw2WXLd4gcJrfw6aO502zIW/GI5dBRCV3+v96W/jEbiI80030D?=
 =?us-ascii?Q?D4SU8w8NFGBiHng0sA48DEAywBLWufNWX0kZuQsnPVBXUrKcrFbOpGiL+Ao9?=
 =?us-ascii?Q?hrcaZGGrpFIteQ1IWL2+MqMyhM145mCGse1HQ1YFFfdb79ctXTEilrl5RP/o?=
 =?us-ascii?Q?nHctV4VT5fVsorzBA0tTLKumS0ZhDCG6cBf50Vb9YP/FfYtEs8dw0CCaod+1?=
 =?us-ascii?Q?0ZgZ821fz6+L0lb8UYZc193uzI668ZPMfbzW5So3C667bHFCyOxtbMaFYUXj?=
 =?us-ascii?Q?f/DHQWYwKex9u3iE4YCRCgSFb1tcELeUS8ILBJ1G5OlPBSw2k2CdvJYaunir?=
 =?us-ascii?Q?UpE60/6VWxRDy9Lb+CW/rOoJOFUtRv71dOiHauh/Xqpp5ZzoYxjrHKS7uVna?=
 =?us-ascii?Q?xDDRplvwu8HzBBZDgIrmWPWOMsvxEHeAlA8ZpWuyCA6WLu/+d8jnzVjwgOqy?=
 =?us-ascii?Q?iyR78oOyv1FYk2Z02wkt0RhEqDQdOa/sykutahlqie8spGBV6YU7iD7zm+Uu?=
 =?us-ascii?Q?5tpjCl3AWAo50x3DTVZmMk/EBdarHi9ak/uvYylNbusPy4z3DpN9LQSxKG15?=
 =?us-ascii?Q?Gf0+Bp06G2VzUR7u/sexRfaC3PDLHyop9zrfrbedsm3z5lU5fumWGruMJcj3?=
 =?us-ascii?Q?SMgi8ec++nN2PK0l8VZZN1tTm2s2YUgbGJmPvA13?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cb5b1c-2e39-47ab-a706-08dca0cc750c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 10:38:37.6739 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0FtInih1QkVnHOE+DBXehEfdIRg5UuUuiDeyR0wBJ84xthJeWrQKxHfCfWbTLew4ecTV2DwTrUCVDG87cFAjCJQ8t8iu69Nj/d9+Atwhn+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4937
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
>From: Joao Martins <joao.m.martins@oracle.com>
>Subject: [PATCH v3 09/10] vfio/migration: Don't block migration device dir=
ty
>tracking is unsupported
>
>By default VFIO migration is set to auto, which will support live
>migration if the migration capability is set *and* also dirty page
>tracking is supported.
>
>For testing purposes one can force enable without dirty page tracking
>via enable-migration=3Don, but that option is generally left for testing
>purposes.
>
>So starting with IOMMU dirty tracking it can use to acomodate the lack of
>VF dirty page tracking allowing us to minimize the VF requirements for
>migration and thus enabling migration by default for those.
>
>Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>---
> hw/vfio/migration.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>index 34d4be2ce1b1..89195928666f 100644
>--- a/hw/vfio/migration.c
>+++ b/hw/vfio/migration.c
>@@ -1012,6 +1012,7 @@ void vfio_reset_bytes_transferred(void)
>  */
> bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
> {
>+    HostIOMMUDeviceClass *hiodc =3D
>HOST_IOMMU_DEVICE_GET_CLASS(vbasedev->hiod);
>     Error *err =3D NULL;
>     int ret;
>
>@@ -1036,7 +1037,10 @@ bool vfio_migration_realize(VFIODevice
>*vbasedev, Error **errp)
>         return !vfio_block_migration(vbasedev, err, errp);
>     }
>
>-    if (!vbasedev->dirty_pages_supported) {
>+    if (!vbasedev->dirty_pages_supported &&
>+        (vbasedev->iommufd &&
>+         !hiodc->get_cap(vbasedev->hiod,
>+                         HOST_IOMMU_DEVICE_CAP_DIRTY_TRACKING, NULL))) {

What about below, this can avoid a new CAP define.

--- a/hw/vfio/migration.c
+++ b/hw/vfio/migration.c
@@ -1036,7 +1036,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Err=
or **errp)
         return !vfio_block_migration(vbasedev, err, errp);
     }

-    if (!vbasedev->dirty_pages_supported) {
+    if (!vbasedev->dirty_pages_supported && !vbasedev->bcontainer->dirty_p=
ages_supported) {
         if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_AUTO) {
             error_setg(&err,
                        "%s: VFIO device doesn't support device dirty track=
ing",

Thanks
Zhenzhong

>         if (vbasedev->enable_migration =3D=3D ON_OFF_AUTO_AUTO) {
>             error_setg(&err,
>                        "%s: VFIO device doesn't support device dirty trac=
king",
>--
>2.17.2


