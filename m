Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F14FC5904
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:23:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVhu-0003hT-9X; Thu, 26 Feb 2026 02:22:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvVhq-0003h3-KK
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:22:44 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvVhk-0000KK-UM
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:22:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772090557; x=1803626557;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=bx5KnlfN0Z0QtsxIewF/BpuRe8I0UlryKfU2nCPWeW0=;
 b=an0DOJqTRRmYe6mVLozHZ/U3gTz5IivyeoX1pNnwDGSJyxwFd3SJHcgG
 iE7/QrWAy+++dxFUvJHfkX4d72w2X4olYhxiRG5ikGDErdJiV+byJnJi3
 qlRexIvVpbgJMd0lBPi86hJuqDAtFH/lLggegKkY6fNdunan+Ie/7Sqco
 UrcC5/v5xxy/w1vT+vU98hAod0I1mINXPe/bDimeGif7WntXz24vfw3gQ
 iQRrwRwJwjdv9bEZswpubZvXL1jNZD3ZnHNiD9gnuT0dLGI+A6cPpDojS
 j3Qic2MhR7SZiNCHzbr0Nyxr62gMxEU6HukweJAjXr7XKhBVROewzj3mj A==;
X-CSE-ConnectionGUID: aC7TuDB5RbOUtKnMfvECNQ==
X-CSE-MsgGUID: K8dDsm1RSmSuuV1ot6BSUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="95758069"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208,217";a="95758069"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 23:22:33 -0800
X-CSE-ConnectionGUID: Ok8JzYkbRlKTPQfmp5nrtQ==
X-CSE-MsgGUID: cTIGaUKoQ7yMVztmPPPxvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
 d="scan'208,217";a="220981607"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 23:22:33 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Feb 2026 23:22:32 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Feb 2026 23:22:32 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.19) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 23:22:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kURAh6JrL9iywp50wh2urroQq6j8iC5bDa376fyb28ye4ZpzC+LAcohkLg0H3t4Y/1L3At6o1HO3RxvkVTr0Md61r73U9+hVE79oEnIFALts9WtQ+XV+pEsKvctjXyuNJ+nd21V4Lslj7R2i2xHmRl1X08NbCzcdnJnNut1e8rLtHyGYJSC6xS1OrcDZ4iHpoX/0pG1qtjD16yt0njFN3kdsAjNnV1G/wxAc3DnTYNIgO+5YW9MRw/xvz4zmVJuTnoQzMDOYYEn+aNCr/qZRYt34bpsQWGcVvsEhfXi7CQvM1BWBPF9flJaVatnBjQe5CeCBJHUAhtIbjkpf19uU1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIGsTYINgfhjnFi5qHgMgvNy5mpOoA2NgX4eIzmwvTY=;
 b=gT84WNmRIEUlQ/T0JXBZT3MshPpqCUX0LaFzlLzL1UlsPtiKXiqSMULTDZIHev2aQEjc75bTUyPj9wP2hdQhAx8oAWf1G+aRLIodrmpdSLtv4PrOIt4/TMn3FvODCrT9hwu5TAxfJy09/dFQ75PQDBf6PJH2jUIEvr72QSyoPkROQwIQX8Nm1gChabG7mc8W9ICyMtpQwWMCaICrMWMR7H49CVr6mh0/l4jauEZA7Eq4pB7KlkQ19wrEuErwqOvtq3uVXZk4UToDaGEyDN+YsHGvGAbOl6EnQjbHgpxIDP+BaBrzZO//4bW56AQuEo68CrCgq5szGp4ZZPoT5Uczfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 07:22:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 07:22:23 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Topic: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check
Thread-Index: AQHcnWP6tyKy+zgBK0aBvE2Kf1JwJ7WTB68AgAFX8xCAADhWgIAADKOw
Date: Thu, 26 Feb 2026 07:22:23 +0000
Message-ID: <IA3PR11MB9136DF2D289C59655B75C9739272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
 <AM8PR07MB760213E1A9BBE02E443F9CD28675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <IA3PR11MB9136ADFEF99A8AD8220F497A9272A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <AM8PR07MB76026D37748B1BEAE5713C2D8672A@AM8PR07MB7602.eurprd07.prod.outlook.com>
In-Reply-To: <AM8PR07MB76026D37748B1BEAE5713C2D8672A@AM8PR07MB7602.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-26T06:29:55.338Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: 44d355d4-c600-4511-5525-08de7507c94e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007|18082099003|38070700021|13003099007|8096899003;
x-microsoft-antispam-message-info: G9a9duIQQTpfNVlMaCX+Rmdk+8ErU8bqvlbpopX3KnwbJ44AGudz5jb5+TGSzHOuQb6y+muhowY0scxsGy0vxqK0mM5B9Jjc7mtyehExJ6JNPnRdxEFW85b2MCtb1WWfosf4+6tnUPHOut3bPwXmr0BSI4FudVoYsHebfo0iIFsG2fB8JCp3aU1K9oOIA75H9YQib2YDRG50Bg4tvjAWRfP18aKKiNYg1E9LSehvhsj6/UByI5e55+PLNjYnsThCX+WBcVAVPAoSIDHd5Nb0SW0IDn0TcYUnLOAxWK72R85FA4LXrSuuNFuimtYCsY+iPYf9pKhaVi29vvkKgb0OMNfv5cT+ELaPEsYvcEttcBk1nq/ulcZpyl1mktJosVSPGna+a6jLPyafWEuYCI/xV6WcmXGDbTRerai60nlUI+Hg4FynE2v9ELDJb2xHmRIpCMSC2C6k5BsOK8PTX1/vZXgE8JZSQc/2l7sdFDiuhBuutu71rmYsl+8YeIJfzeg/eYe5m57EKgQ4CA74voCuYduqzVWRn3DYcSgf/tkZImiLvuivuleG6MbnZFFu2sqyzUc+Vr7sQHbKL31OE53YTm73AUY2MvK38Fyegg7wX3YbG+nNonhXLgrD8YfGU2GJrjm48HZjULuEV5lf+jweGx2XA58b1Jl7veX5OgMA1osZ1y93esHeT3zmEtshZ2wJ3Lgd0RyVGbmOmG2HKnyk+/dDlltDPzvInjRIX1UgOodjoRtyQqF1KVb44BdHbghDdOaCHOT9wnKojkSk3UFo8+P+K+z/jGK2Efh/jJMdR6Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(18082099003)(38070700021)(13003099007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3ZgtO6wPi9OqGzcl4EGWU9maZlqMMV72u71xcEudekIFt8JCfFBfxxGsqF/P?=
 =?us-ascii?Q?jIZFFLWkmBychkXEwqn6gEN2PA0Lg9q2ODSM5zcpwOngMRaHBiEjWCUePdto?=
 =?us-ascii?Q?Dt265W3XceSIo4lY0Nxa943VcicVM2TUDPg9cqUaUsz2LruUjmV0nrfCADQZ?=
 =?us-ascii?Q?0qt0ezQVxpcsEkGBa3vyV5rLwP362Ys42Wz0cVkt7R/PWESmnJnyhDYwoaYZ?=
 =?us-ascii?Q?1L2sxD1wzPdoWjTp+NlV+FPZ6MjMf8P1WPrm1XLHjaRpKRv++TNEZu4rGLzy?=
 =?us-ascii?Q?GR1zqzEU667YlW3vjCpCG0uT2d+/1An9ZxA9+gbtLhPVfxyet6r20EWio0ry?=
 =?us-ascii?Q?iVlGFXmog1kFGPcap6PRJiGZoItqS8gbrTis1U+lAE9/syz/BTG5jlXp92XF?=
 =?us-ascii?Q?pIY0Jd+eUEnUzi+IX5q98Vmv5wUBtJ5r2bNN/uS5o2H13o8tG3kX1FMIE29i?=
 =?us-ascii?Q?+a/SOT9FpkMzT8aYYAGgCEqerX77XOa9J4zrqOpa/Pt6slikOp/9diPQfA9A?=
 =?us-ascii?Q?DujAdxczcy2kkn/2QPjQdU4OiXFq3NVn6xMTLjwWBuUosWVz+QiLwjKlP155?=
 =?us-ascii?Q?VUHLYMELYsrKxb9jjNB3TbZOfm+dEdkixm7vlFxANtbT1+WNAspkKs+zcddr?=
 =?us-ascii?Q?POe8TLf2EbJi5RCL5UqJeqHNbM8biWONLl1xODqEN0+fc5JvGTrfiKJAg7uK?=
 =?us-ascii?Q?aqWApZ6zQ/669/KxoZ9EtFlsorPSDRCsXJCEOe30Hh38MshPBN3NSNlCb5gw?=
 =?us-ascii?Q?LMVCIqmY2LIs42qchEJorbNhXMqZnaZtJwu9+gbUy/Q0xmD2GCBDboICaun5?=
 =?us-ascii?Q?9hLeGqYNo9QzwvEl+8MvtGRmqngyGAy1fzpfVK0aQzVNSmstht1/adCM3RF8?=
 =?us-ascii?Q?pnBmX+OQPeyEEnq9sKpavOLnleaKxhg+PMYQltOZ7M4S6icMH8/E7Xzbrc3s?=
 =?us-ascii?Q?GJ8ZNNDxTPRLjzwW2aVj2d33YhiYpoeEctmylHrN9NEKnnqwOxEt6Kn21Q9D?=
 =?us-ascii?Q?taDtl/LK4e4augB2O9pKkdPzr4WTEHoSbAdBTAOuuBrL5T8jO0l9gI1cTV2K?=
 =?us-ascii?Q?2s8JjzE7K8JZm6Z9ihLf9dyk561nz/3fhowzJ9iUFcGYklQdrIfQ3evqAbyH?=
 =?us-ascii?Q?KiQpTM3dr5PB2m6Os7Cjx2HyWjyQZn2BEHe4u7siCTAhN5J5U4T+apQyC90P?=
 =?us-ascii?Q?kY5elpJwrtGY29L1PBEaYAs8/5BIgeNuNGVVIAasXSI8dw/dqbkRnETxU1LT?=
 =?us-ascii?Q?tV75fV+UDs/Oz6PR3pJPsIyb4MjFTQLKpyD00npoYUEf0MWCZp2AJzOd0kje?=
 =?us-ascii?Q?78q2DmrbXRIrHeuyp90i6heLkCxckf+kZfuD/Td8Tp5tsxX6xmwpde8PlQ/+?=
 =?us-ascii?Q?HrVdJVTAwxZEh4d+23ZktzPmDKGKIGr/R7lput1gag1UsplgMkZEqo1o+hCU?=
 =?us-ascii?Q?K0erREILWWGYszIsED8ISLamFM4e8CeSjoi96ix7OaAl6nti1B7M2T5JqGKv?=
 =?us-ascii?Q?wvI6r1y7qnSejbLbUSD6tHgwu3W82oI0NZx8b8CeMhyiySC8Kc3SzH/w/7cS?=
 =?us-ascii?Q?dHMzl5TSIPnKWzwxveYvF57pRrcLZfIEnf+ICtJJ36fIy5aNZ/g40wcd+VsW?=
 =?us-ascii?Q?CiuyI79W2goHazOT3Owt2y+xxHK5wHSRivd9DhhLzDsWczjfxVdswvl4TKj1?=
 =?us-ascii?Q?W5b7LuX1XzaZvFYGXoE5uTVjETuyQHHo5dcoPt05WQbxH2RcmGaKwbxbRj5I?=
 =?us-ascii?Q?sis29V5fnA=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB9136DF2D289C59655B75C9739272AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44d355d4-c600-4511-5525-08de7507c94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 07:22:23.5679 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3NG2Uf3YgQLYByCrmVTs1vkwbBFc55CT/KjhTNVhZAEGaouRfAhdUfB8tWS+znxNwRFDJ80W0+9rDVvfJKK7ZDSzmYHOiJNYtmbi37sVpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

--_000_IA3PR11MB9136DF2D289C59655B75C9739272AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Clement,

That's a good idea, it looks simpler to use extract32/64 for multi bits fie=
ld, for one bit field, just keep it as is. Will change as below, let me kno=
w if I misunderstand your suggestion.

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e5518a94ea..d6674861fd 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,7 +195,8 @@
#define VTD_ECAP_MHMV               (15ULL << 20)
#define VTD_ECAP_SRS                (1ULL << 31)
#define VTD_ECAP_NWFS               (1ULL << 33)
-#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
+#define VTD_ECAP_SET_PSS(x, v)      ((x)->ecap =3D deposit64((x)->ecap, 35=
, 5, v))
+#define VTD_ECAP_PSS(ecap)          extract64(ecap, 35, 5)
#define VTD_ECAP_PASID              (1ULL << 40)
#define VTD_ECAP_PDS                (1ULL << 42)
#define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 94a691d423..dd7073fc08 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5027,7 +5027,8 @@ static void vtd_cap_init(IntelIOMMUState *s)
     }

     if (s->pasid) {
-        s->ecap =3D VTD_ECAP_PASID | deposit64(s->ecap, 35, 5, s->pasid - =
1);
+        VTD_ECAP_SET_PSS(s, s->pasid - 1);
+        s->ecap |=3D VTD_ECAP_PASID;
     }
}

BRs,
Zhenzhong

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Thursday, February 26, 2026 2:30 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck

Hi Zhenzhong,

Oh ok, I did not remember this comment from Eric, my mistake.

From what I see in the smmu:
- "getters" use extract and are named according to the field they extract.
- "setters" use deposit and use the following naming pattern "XXX_SET_THENA=
ME"

Do you think we should follow the same way?

cmd

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel=
.com>>
Sent: 26 February 2026 04:12
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com<mailto:clement.=
mathieu--drif@eviden.com>>; qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.=
org> <qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>>
Cc: alex@shazbot.org<mailto:alex@shazbot.org> <alex@shazbot.org<mailto:alex=
@shazbot.org>>; clg@redhat.com<mailto:clg@redhat.com> <clg@redhat.com<mailt=
o:clg@redhat.com>>; eric.auger@redhat.com<mailto:eric.auger@redhat.com> <er=
ic.auger@redhat.com<mailto:eric.auger@redhat.com>>; mst@redhat.com<mailto:m=
st@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat.com=
<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redhat.co=
m>>; jgg@nvidia.com<mailto:jgg@nvidia.com> <jgg@nvidia.com<mailto:jgg@nvidi=
a.com>>; nicolinc@nvidia.com<mailto:nicolinc@nvidia.com> <nicolinc@nvidia.c=
om<mailto:nicolinc@nvidia.com>>; skolothumtho@nvidia.com<mailto:skolothumth=
o@nvidia.com> <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>; jo=
ao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@o=
racle.com<mailto:joao.m.martins@oracle.com>>; Tian, Kevin <kevin.tian@intel=
.com<mailto:kevin.tian@intel.com>>; Liu, Yi L <yi.l.liu@intel.com<mailto:yi=
.l.liu@intel.com>>; Hao, Xudong <xudong.hao@intel.com<mailto:xudong.hao@int=
el.com>>
Subject: RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck

Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


Hi Clement,



This is to follow Eric's suggestion in previous iommufd nesting series

where he suggested to use extra32/64 syntax, copied here:



+#define VTD_INV_DESC_PASIDC_DSI        (0ULL << 4)

+#define VTD_INV_DESC_PASIDC_PASID_SI   (1ULL << 4)

+#define VTD_INV_DESC_PASIDC_GLOBAL     (3ULL << 4)

as those are values for the granularity field using



VTD_INV_DESC_PASIDC_G_* look relevant to me.



I think you would gain in readability if you adopt extract32/64 syntax

like in hw/arm/smmuv3-internal.h

Looks more readable to me.



See https://lore.kernel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b=
@redhat.com/ for details.



BRs,

Zhenzhong



From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com<mailto:clemen=
t.mathieu--drif@eviden.com>>
Sent: Wednesday, February 25, 2026 2:38 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.c=
om>>; qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org>
Cc: alex@shazbot.org<mailto:alex@shazbot.org>; clg@redhat.com<mailto:clg@re=
dhat.com>; eric.auger@redhat.com<mailto:eric.auger@redhat.com>; mst@redhat.=
com<mailto:mst@redhat.com>; jasowang@redhat.com<mailto:jasowang@redhat.com>=
; jgg@nvidia.com<mailto:jgg@nvidia.com>; nicolinc@nvidia.com<mailto:nicolin=
c@nvidia.com>; skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>; joa=
o.m.martins@oracle.com<mailto:joao.m.martins@oracle.com>; Tian, Kevin <kevi=
n.tian@intel.com<mailto:kevin.tian@intel.com>>; Liu, Yi L <yi.l.liu@intel.c=
om<mailto:yi.l.liu@intel.com>>; Hao, Xudong <xudong.hao@intel.com<mailto:xu=
dong.hao@intel.com>>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck



Hi Zhenzhong,



I'm a bit confused about this patch.



All the other VTD_ECAP_* are masks for the ecap qword.

The purpose of this new definition of ECAP_PSS differs a bit as it extracts=
 the field itself :/



cmd



________________________________

From: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.=
com>>
Sent: 14 February 2026 04:41
To: qemu-devel@nongnu.org<mailto:qemu-devel@nongnu.org> <qemu-devel@nongnu.=
org<mailto:qemu-devel@nongnu.org>>
Cc: alex@shazbot.org<mailto:alex@shazbot.org> <alex@shazbot.org<mailto:alex=
@shazbot.org>>; clg@redhat.com<mailto:clg@redhat.com> <clg@redhat.com<mailt=
o:clg@redhat.com>>; eric.auger@redhat.com<mailto:eric.auger@redhat.com> <er=
ic.auger@redhat.com<mailto:eric.auger@redhat.com>>; mst@redhat.com<mailto:m=
st@redhat.com> <mst@redhat.com<mailto:mst@redhat.com>>; jasowang@redhat.com=
<mailto:jasowang@redhat.com> <jasowang@redhat.com<mailto:jasowang@redhat.co=
m>>; jgg@nvidia.com<mailto:jgg@nvidia.com> <jgg@nvidia.com<mailto:jgg@nvidi=
a.com>>; nicolinc@nvidia.com<mailto:nicolinc@nvidia.com> <nicolinc@nvidia.c=
om<mailto:nicolinc@nvidia.com>>; skolothumtho@nvidia.com<mailto:skolothumth=
o@nvidia.com> <skolothumtho@nvidia.com<mailto:skolothumtho@nvidia.com>>; jo=
ao.m.martins@oracle.com<mailto:joao.m.martins@oracle.com> <joao.m.martins@o=
racle.com<mailto:joao.m.martins@oracle.com>>; CLEMENT MATHIEU--DRIF <clemen=
t.mathieu--drif@eviden.com<mailto:clement.mathieu--drif@eviden.com>>; kevin=
.tian@intel.com<mailto:kevin.tian@intel.com> <kevin.tian@intel.com<mailto:k=
evin.tian@intel.com>>; yi.l.liu@intel.com<mailto:yi.l.liu@intel.com> <yi.l.=
liu@intel.com<mailto:yi.l.liu@intel.com>>; xudong.hao@intel.com<mailto:xudo=
ng.hao@intel.com> <xudong.hao@intel.com<mailto:xudong.hao@intel.com>>; Zhen=
zhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel.com>>
Subject: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size check



Caution: External email. Do not open attachments or click links, unless thi=
s email comes from a known sender and you know the content is safe.


If pasid bits size is bigger than host side, host could fail to emulate
all bindings in guest. Add a check to fail device plug early.

Pasid bits size should also be no more than 20 bits according to PCI spec.

Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com<mailto:zhenzhong.du=
an@intel.com>>
---
 hw/i386/intel_iommu_internal.h | 1 +
 hw/i386/intel_iommu.c          | 5 +++++
 hw/i386/intel_iommu_accel.c    | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h
index e4bcc884b0..e5518a94ea 100644
--- a/hw/i386/intel_iommu_internal.h
+++ b/hw/i386/intel_iommu_internal.h
@@ -195,6 +195,7 @@
 #define VTD_ECAP_MHMV               (15ULL << 20)
 #define VTD_ECAP_SRS                (1ULL << 31)
 #define VTD_ECAP_NWFS               (1ULL << 33)
+#define VTD_ECAP_PSS(x)             extract64(x, 35, 5)
 #define VTD_ECAP_PASID              (1ULL << 40)
 #define VTD_ECAP_PDS                (1ULL << 42)
 #define VTD_ECAP_SMTS               (1ULL << 43)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 6483cb3d85..c1b31b17de 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)
         error_setg(errp, "Need to set scalable mode for PASID");
         return false;
     }
+    if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {
+        error_setg(errp, "PASID width %d, exceed Max PASID Width %d allowe=
d "
+                   "in PCI spec", s->pasid, PCI_EXT_CAP_PASID_MAX_WIDTH);
+        return false;
+    }

     if (s->svm) {
         if (!x86_iommu->dt_supported) {
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
index acb1b1e238..15412123d5 100644
--- a/hw/i386/intel_iommu_accel.c
+++ b/hw/i386/intel_iommu_accel.c
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,
     HostIOMMUDevice *hiod =3D vtd_hiod->hiod;
     struct HostIOMMUDeviceCaps *caps =3D &hiod->caps;
     struct iommu_hw_info_vtd *vtd =3D &caps->vendor_caps.vtd;
+    uint8_t hpasid =3D VTD_ECAP_PSS(vtd->ecap_reg) + 1;
     PCIBus *bus =3D vtd_hiod->bus;
     PCIDevice *pdev =3D bus->devices[vtd_hiod->devfn];

@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,
         return false;
     }

+    /* Only do the check when host device support PASIDs */
+    if (caps->max_pasid_log2 && s->pasid > hpasid) {
+        error_setg(errp, "PASID bits size %d > host IOMMU PASID bits size =
%d",
+                   s->pasid, hpasid);
+        return false;
+    }
+
     if (pci_device_get_iommu_bus_devfn(pdev, &bus, NULL, NULL)) {
         error_setg(errp, "Host device downstream to a PCI bridge is "
                    "unsupported when x-flts=3Don");
--
2.47.3

--_000_IA3PR11MB9136DF2D289C59655B75C9739272AIA3PR11MB9136namp_
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
	color:blue;
	text-decoration:underline;}
span.EmailStyle20
	{mso-style-type:personal-reply;
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
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple" style=3D"word-wrap:brea=
k-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi Clement,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">That&#8217;s a good idea, it looks simpler to use ex=
tract32/64 for multi bits field, for one bit field, just keep it as is. Wil=
l change as below, let me know if I misunderstand your suggestion.<o:p></o:=
p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/i386/intel_iommu_internal.h b/hw/i38=
6/intel_iommu_internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">index e5518a94ea..d6674861fd 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/i386/intel_iommu_internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/i386/intel_iommu_internal.h<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -195,7 +195,8 @@<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<o=
:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 3=
1)<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<o:=
p></o:p></p>
<p class=3D"MsoNormal">-#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<o:p></o:p>=
</p>
<p class=3D"MsoNormal">+#define VTD_ECAP_SET_PSS(x, v)&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; ((x)-&gt;ecap =3D deposit64((x)-&gt;ecap, 35, 5, v))<o:p></o:p></=
p>
<p class=3D"MsoNormal">+#define VTD_ECAP_PSS(ecap)&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; extract64(ecap, 35, 5)<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<o:p></o=
:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 4=
2)<o:p></o:p></p>
<p class=3D"MsoNormal">#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<o:=
p></o:p></p>
<p class=3D"MsoNormal">diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_i=
ommu.c<o:p></o:p></p>
<p class=3D"MsoNormal">index 94a691d423..dd7073fc08 100644<o:p></o:p></p>
<p class=3D"MsoNormal">--- a/hw/i386/intel_iommu.c<o:p></o:p></p>
<p class=3D"MsoNormal">+++ b/hw/i386/intel_iommu.c<o:p></o:p></p>
<p class=3D"MsoNormal">@@ -5027,7 +5027,8 @@ static void vtd_cap_init(Intel=
IOMMUState *s)<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;pasid) {<o:p></o:=
p></p>
<p class=3D"MsoNormal">-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ec=
ap =3D VTD_ECAP_PASID | deposit64(s-&gt;ecap, 35, 5, s-&gt;pasid - 1);<o:p>=
</o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; VTD_ECAP=
_SET_PSS(s, s-&gt;pasid - 1);<o:p></o:p></p>
<p class=3D"MsoNormal">+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ec=
ap |=3D VTD_ECAP_PASID;<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp; }<o:p></o:p></p>
<p class=3D"MsoNormal">}<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">BRs,<o:p></o:p></p>
<p class=3D"MsoNormal">Zhenzhong<o:p></o:p></p>
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
<b>Sent:</b> Thursday, February 26, 2026 2:30 PM<br>
<b>To:</b> Duan, Zhenzhong &lt;zhenzhong.duan@intel.com&gt;; qemu-devel@non=
gnu.org<br>
<b>Cc:</b> alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@red=
hat.com; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothu=
mtho@nvidia.com; joao.m.martins@oracle.com; Tian, Kevin &lt;kevin.tian@inte=
l.com&gt;; Liu, Yi L &lt;yi.l.liu@intel.com&gt;;
 Hao, Xudong &lt;xudong.hao@intel.com&gt;<br>
<b>Subject:</b> Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits s=
ize check<o:p></o:p></span></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Hi Zhenzhong,<o:p></o:p>=
</span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Oh ok, I did not remembe=
r this comment from Eric, my mistake.<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">From what I see in the s=
mmu:<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">- &quot;getters&quot; us=
e extract and are named according to the field they extract.<o:p></o:p></sp=
an></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">- &quot;setters&quot; us=
e deposit and use the following naming pattern &quot;XXX_SET_THENAME&quot;<=
o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">Do you think we should f=
ollow the same way?<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">cmd<o:p></o:p></span></p=
>
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
<b>Sent:</b>&nbsp;26 February 2026 04:12<br>
<b>To:</b>&nbsp;CLEMENT MATHIEU--DRIF &lt;<a href=3D"mailto:clement.mathieu=
--drif@eviden.com">clement.mathieu--drif@eviden.com</a>&gt;;
<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a> &lt;<a h=
ref=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a>&gt;<br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a> &l=
t;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a>&gt;;
<a href=3D"mailto:clg@redhat.com">clg@redhat.com</a> &lt;<a href=3D"mailto:=
clg@redhat.com">clg@redhat.com</a>&gt;;
<a href=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a> &lt;<a h=
ref=3D"mailto:eric.auger@redhat.com">eric.auger@redhat.com</a>&gt;;
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a> &lt;<a href=3D"mailto:=
mst@redhat.com">mst@redhat.com</a>&gt;;
<a href=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a> &lt;<a href=
=3D"mailto:jasowang@redhat.com">jasowang@redhat.com</a>&gt;;
<a href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</a> &lt;<a href=3D"mailto:=
jgg@nvidia.com">jgg@nvidia.com</a>&gt;;
<a href=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</a> &lt;<a href=
=3D"mailto:nicolinc@nvidia.com">nicolinc@nvidia.com</a>&gt;;
<a href=3D"mailto:skolothumtho@nvidia.com">skolothumtho@nvidia.com</a> &lt;=
<a href=3D"mailto:skolothumtho@nvidia.com">skolothumtho@nvidia.com</a>&gt;;
<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a> =
&lt;<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com<=
/a>&gt;; Tian, Kevin &lt;<a href=3D"mailto:kevin.tian@intel.com">kevin.tian=
@intel.com</a>&gt;; Liu, Yi L &lt;<a href=3D"mailto:yi.l.liu@intel.com">yi.=
l.liu@intel.com</a>&gt;;
 Hao, Xudong &lt;<a href=3D"mailto:xudong.hao@intel.com">xudong.hao@intel.c=
om</a>&gt;<br>
<b>Subject:</b>&nbsp;RE: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid b=
its size check<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<table class=3D"MsoNormalTable" border=3D"0" cellspacing=3D"0" cellpadding=
=3D"0" align=3D"left" width=3D"100%" style=3D"width:100.0%">
<tbody>
<tr>
<td style=3D"background:#FFB900;padding:5.0pt 2.0pt 5.0pt 2.0pt"></td>
<td width=3D"100%" style=3D"width:100.0%;background:#FF4D4D;padding:5.0pt 4=
.0pt 5.0pt 12.0pt">
<div>
<p class=3D"MsoNormal" style=3D"mso-element:frame;mso-element-frame-hspace:=
2.25pt;mso-element-wrap:around;mso-element-anchor-vertical:paragraph;mso-el=
ement-anchor-horizontal:column;mso-height-rule:exactly">
<b><span style=3D"color:#222222">Caution:</span></b><span style=3D"color:#2=
22222">&nbsp;External email. Do not open attachments or click links, unless=
 this email comes from a known sender and you know the content is safe.<o:p=
></o:p></span></p>
</div>
</td>
</tr>
</tbody>
</table>
<div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
<p>Hi Clement,<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>This is to follow Eric&#8217;s suggestion in previous iommufd nesting se=
ries<o:p></o:p></p>
<p>where he suggested to use extra32/64 syntax, copied here:<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>+#define VTD_INV_DESC_PASIDC_DSI&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; (0ULL &lt;&lt; 4)<o:p></o:p></p>
<p>+#define VTD_INV_DESC_PASIDC_PASID_SI&nbsp;&nbsp; (1ULL &lt;&lt; 4)<o:p>=
</o:p></p>
<p>+#define VTD_INV_DESC_PASIDC_GLOBAL&nbsp;&nbsp;&nbsp;&nbsp; (3ULL &lt;&l=
t; 4)<o:p></o:p></p>
<p>as those are values for the granularity field using<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>VTD_INV_DESC_PASIDC_G_* look relevant to me.<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>I think you would gain in readability if you adopt extract32/64 syntax<o=
:p></o:p></p>
<p>like in hw/arm/smmuv3-internal.h<o:p></o:p></p>
<p>Looks more readable to me.<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>See <u><span style=3D"color:#467886"><a href=3D"https://lore.kernel.org/=
qemu-devel/2cbb91d3-9acc-4e7a-9a0a-19d9b5efe21b@redhat.com/"><span style=3D=
"color:#467886">https://lore.kernel.org/qemu-devel/2cbb91d3-9acc-4e7a-9a0a-=
19d9b5efe21b@redhat.com/</span></a></span></u>&nbsp;for
 details.<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>BRs,<o:p></o:p></p>
<p>Zhenzhong<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<div style=3D"border:none;border-left:solid windowtext 1.5pt;padding:0in 0i=
n 0in 4.0pt;border-color:currentcolor currentcolor currentcolor blue">
<div style=3D"border:none;border-top:solid windowtext 1.0pt;padding:3.0pt 0=
in 0in 0in;border-color:currentcolor currentcolor">
<p><b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-=
serif">From:</span></b><span style=3D"font-size:11.0pt;font-family:&quot;Ca=
libri&quot;,sans-serif">&nbsp;CLEMENT MATHIEU--DRIF &lt;<a href=3D"mailto:c=
lement.mathieu--drif@eviden.com">clement.mathieu--drif@eviden.com</a>&gt;<b=
r>
<b>Sent:</b>&nbsp;Wednesday, February 25, 2026 2:38 PM<br>
<b>To:</b>&nbsp;Duan, Zhenzhong &lt;<a href=3D"mailto:zhenzhong.duan@intel.=
com">zhenzhong.duan@intel.com</a>&gt;;
<a href=3D"mailto:qemu-devel@nongnu.org">qemu-devel@nongnu.org</a><br>
<b>Cc:</b>&nbsp;<a href=3D"mailto:alex@shazbot.org">alex@shazbot.org</a>; <=
a href=3D"mailto:clg@redhat.com">
clg@redhat.com</a>; <a href=3D"mailto:eric.auger@redhat.com">eric.auger@red=
hat.com</a>;
<a href=3D"mailto:mst@redhat.com">mst@redhat.com</a>; <a href=3D"mailto:jas=
owang@redhat.com">
jasowang@redhat.com</a>; <a href=3D"mailto:jgg@nvidia.com">jgg@nvidia.com</=
a>; <a href=3D"mailto:nicolinc@nvidia.com">
nicolinc@nvidia.com</a>; <a href=3D"mailto:skolothumtho@nvidia.com">skoloth=
umtho@nvidia.com</a>;
<a href=3D"mailto:joao.m.martins@oracle.com">joao.m.martins@oracle.com</a>;=
 Tian, Kevin &lt;<a href=3D"mailto:kevin.tian@intel.com">kevin.tian@intel.c=
om</a>&gt;; Liu, Yi L &lt;<a href=3D"mailto:yi.l.liu@intel.com">yi.l.liu@in=
tel.com</a>&gt;; Hao, Xudong &lt;<a href=3D"mailto:xudong.hao@intel.com">xu=
dong.hao@intel.com</a>&gt;<br>
<b>Subject:</b>&nbsp;Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid b=
its size check</span><o:p></o:p></p>
</div>
<p>&nbsp;<o:p></o:p></p>
<p><span style=3D"color:black">Hi Zhenzhong,</span><o:p></o:p></p>
<p><span style=3D"color:black">&nbsp;</span><o:p></o:p></p>
<p><span style=3D"color:black">I'm a bit confused about this patch.</span><=
o:p></o:p></p>
<p><span style=3D"color:black">&nbsp;</span><o:p></o:p></p>
<p><span style=3D"color:black">All the other VTD_ECAP_* are masks for the e=
cap qword.</span><o:p></o:p></p>
<p><span style=3D"color:black">The purpose of this new definition of ECAP_P=
SS differs a bit as it extracts the field itself :/</span><o:p></o:p></p>
<p><span style=3D"color:black">&nbsp;</span><o:p></o:p></p>
<p><span style=3D"color:black">cmd</span><o:p></o:p></p>
<p><span style=3D"color:black">&nbsp;</span><o:p></o:p></p>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"x_divRplyFwdMsg">
<p><b><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-=
serif;color:black">From:</span></b><span style=3D"font-size:11.0pt;font-fam=
ily:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;Zhenzhong Duan &lt;</=
span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:#467886"><a href=3D"mailto:zhenzhong.duan@intel.com"><span st=
yle=3D"color:#467886">zhenzhong.duan@intel.com</span></a></span></u><span s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">&gt;<br>
<b>Sent:</b>&nbsp;14 February 2026 04:41<br>
<b>To:</b>&nbsp;</span><u><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:qemu-devel@nongn=
u.org"><span style=3D"color:#467886">qemu-devel@nongnu.org</span></a></span=
></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-s=
erif;color:black">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:qemu=
-devel@nongnu.org"><span style=3D"color:#467886">qemu-devel@nongnu.org</spa=
n></a></span></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&=
quot;,sans-serif;color:black">&gt;<br>
<b>Cc:</b>&nbsp;</span><u><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:alex@shazbot.org=
"><span style=3D"color:#467886">alex@shazbot.org</span></a></span></u><span=
 style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color=
:black">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&qu=
ot;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:alex@shazbot.o=
rg"><span style=3D"color:#467886">alex@shazbot.org</span></a></span></u><sp=
an style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;col=
or:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:clg@redhat.com"><span style=3D"c=
olor:#467886">clg@redhat.com</span></a></span></u><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;&lt;</=
span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:#467886"><a href=3D"mailto:clg@redhat.com"><span style=3D"col=
or:#467886">clg@redhat.com</span></a></span></u><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:eric.auger@redhat.com"><span sty=
le=3D"color:#467886">eric.auger@redhat.com</span></a></span></u><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black=
">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:eric.auger@redhat.co=
m"><span style=3D"color:#467886">eric.auger@redhat.com</span></a></span></u=
><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif=
;color:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:mst@redhat.com"><span style=3D"c=
olor:#467886">mst@redhat.com</span></a></span></u><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;&lt;</=
span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:#467886"><a href=3D"mailto:mst@redhat.com"><span style=3D"col=
or:#467886">mst@redhat.com</span></a></span></u><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:jasowang@redhat.com"><span style=
=3D"color:#467886">jasowang@redhat.com</span></a></span></u><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&n=
bsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri=
&quot;,sans-serif;color:#467886"><a href=3D"mailto:jasowang@redhat.com"><sp=
an style=3D"color:#467886">jasowang@redhat.com</span></a></span></u><span s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:jgg@nvidia.com"><span style=3D"c=
olor:#467886">jgg@nvidia.com</span></a></span></u><span style=3D"font-size:=
11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nbsp;&lt;</=
span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,san=
s-serif;color:#467886"><a href=3D"mailto:jgg@nvidia.com"><span style=3D"col=
or:#467886">jgg@nvidia.com</span></a></span></u><span style=3D"font-size:11=
.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:nicolinc@nvidia.com"><span style=
=3D"color:#467886">nicolinc@nvidia.com</span></a></span></u><span style=3D"=
font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&n=
bsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri=
&quot;,sans-serif;color:#467886"><a href=3D"mailto:nicolinc@nvidia.com"><sp=
an style=3D"color:#467886">nicolinc@nvidia.com</span></a></span></u><span s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:skolothumtho@nvidia.com"><span s=
tyle=3D"color:#467886">skolothumtho@nvidia.com</span></a></span></u><span s=
tyle=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:b=
lack">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot=
;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:skolothumtho@nvi=
dia.com"><span style=3D"color:#467886">skolothumtho@nvidia.com</span></a></=
span></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sa=
ns-serif;color:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:joao.m.martins@oracle.com"><span=
 style=3D"color:#467886">joao.m.martins@oracle.com</span></a></span></u><sp=
an style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;col=
or:black">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:joao.m.marti=
ns@oracle.com"><span style=3D"color:#467886">joao.m.martins@oracle.com</spa=
n></a></span></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&=
quot;,sans-serif;color:black">&gt;;
 CLEMENT MATHIEU--DRIF &lt;</span><u><span style=3D"font-size:11.0pt;font-f=
amily:&quot;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:cleme=
nt.mathieu--drif@eviden.com"><span style=3D"color:#467886">clement.mathieu-=
-drif@eviden.com</span></a></span></u><span style=3D"font-size:11.0pt;font-=
family:&quot;Calibri&quot;,sans-serif;color:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:kevin.tian@intel.com"><span styl=
e=3D"color:#467886">kevin.tian@intel.com</span></a></span></u><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black=
">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:kevin.tian@intel.com=
"><span style=3D"color:#467886">kevin.tian@intel.com</span></a></span></u><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:black">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:yi.l.liu@intel.com"><span style=
=3D"color:#467886">yi.l.liu@intel.com</span></a></span></u><span style=3D"f=
ont-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black">&nb=
sp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&=
quot;,sans-serif;color:#467886"><a href=3D"mailto:yi.l.liu@intel.com"><span=
 style=3D"color:#467886">yi.l.liu@intel.com</span></a></span></u><span styl=
e=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:blac=
k">&gt;;
</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,s=
ans-serif;color:#467886"><a href=3D"mailto:xudong.hao@intel.com"><span styl=
e=3D"color:#467886">xudong.hao@intel.com</span></a></span></u><span style=
=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;color:black=
">&nbsp;&lt;</span><u><span style=3D"font-size:11.0pt;font-family:&quot;Cal=
ibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:xudong.hao@intel.com=
"><span style=3D"color:#467886">xudong.hao@intel.com</span></a></span></u><=
span style=3D"font-size:11.0pt;font-family:&quot;Calibri&quot;,sans-serif;c=
olor:black">&gt;;
 Zhenzhong Duan &lt;</span><u><span style=3D"font-size:11.0pt;font-family:&=
quot;Calibri&quot;,sans-serif;color:#467886"><a href=3D"mailto:zhenzhong.du=
an@intel.com"><span style=3D"color:#467886">zhenzhong.duan@intel.com</span>=
</a></span></u><span style=3D"font-size:11.0pt;font-family:&quot;Calibri&qu=
ot;,sans-serif;color:black">&gt;<br>
<b>Subject:</b>&nbsp;[RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits =
size check</span><o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
</div>
<p><span style=3D"font-size:11.0pt">Caution: External email. Do not open at=
tachments or click links, unless this email comes from a known sender and y=
ou know the content is safe.<br>
<br>
<br>
If pasid bits size is bigger than host side, host could fail to emulate<br>
all bindings in guest. Add a check to fail device plug early.<br>
<br>
Pasid bits size should also be no more than 20 bits according to PCI spec.<=
br>
<br>
Signed-off-by: Zhenzhong Duan &lt;<u><span style=3D"color:#467886"><a href=
=3D"mailto:zhenzhong.duan@intel.com"><span style=3D"color:#467886">zhenzhon=
g.duan@intel.com</span></a></span></u>&gt;<br>
---<br>
&nbsp;hw/i386/intel_iommu_internal.h | 1 +<br>
&nbsp;hw/i386/intel_iommu.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; | 5 +++++<br>
&nbsp;hw/i386/intel_iommu_accel.c&nbsp;&nbsp;&nbsp; | 8 ++++++++<br>
&nbsp;3 files changed, 14 insertions(+)<br>
<br>
diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.=
h<br>
index e4bcc884b0..e5518a94ea 100644<br>
--- a/hw/i386/intel_iommu_internal.h<br>
+++ b/hw/i386/intel_iommu_internal.h<br>
@@ -195,6 +195,7 @@<br>
&nbsp;#define VTD_ECAP_MHMV&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (15ULL &lt;&lt; 20)<br>
&nbsp;#define VTD_ECAP_SRS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 31)<br>
&nbsp;#define VTD_ECAP_NWFS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 33)<br>
+#define VTD_ECAP_PSS(x)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; extract64(x, 35, 5)<br>
&nbsp;#define VTD_ECAP_PASID&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 40)<br>
&nbsp;#define VTD_ECAP_PDS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 42)<br>
&nbsp;#define VTD_ECAP_SMTS&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (1ULL &lt;&lt; 43)<br>
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c<br>
index 6483cb3d85..c1b31b17de 100644<br>
--- a/hw/i386/intel_iommu.c<br>
+++ b/hw/i386/intel_iommu.c<br>
@@ -5545,6 +5545,11 @@ static bool vtd_decide_config(IntelIOMMUState *s, Er=
ror **errp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Nee=
d to set scalable mode for PASID&quot;);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; if (s-&gt;pasid &gt;=3D PCI_EXT_CAP_PASID_MAX_WIDTH) {<=
br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID wi=
dth %d, exceed Max PASID Width %d allowed &quot;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;in PCI spec&quot;, s-&gt;pasid, PC=
I_EXT_CAP_PASID_MAX_WIDTH);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (s-&gt;svm) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!x86_iommu-&gt;dt_supp=
orted) {<br>
diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c<br>
index acb1b1e238..15412123d5 100644<br>
--- a/hw/i386/intel_iommu_accel.c<br>
+++ b/hw/i386/intel_iommu_accel.c<br>
@@ -44,6 +44,7 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOMM=
UDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp; HostIOMMUDevice *hiod =3D vtd_hiod-&gt;hiod;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct HostIOMMUDeviceCaps *caps =3D &amp;hiod-&gt=
;caps;<br>
&nbsp;&nbsp;&nbsp;&nbsp; struct iommu_hw_info_vtd *vtd =3D &amp;caps-&gt;ve=
ndor_caps.vtd;<br>
+&nbsp;&nbsp;&nbsp; uint8_t hpasid =3D VTD_ECAP_PSS(vtd-&gt;ecap_reg) + 1;<=
br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIBus *bus =3D vtd_hiod-&gt;bus;<br>
&nbsp;&nbsp;&nbsp;&nbsp; PCIDevice *pdev =3D bus-&gt;devices[vtd_hiod-&gt;d=
evfn];<br>
<br>
@@ -64,6 +65,13 @@ bool vtd_check_hiod_accel(IntelIOMMUState *s, VTDHostIOM=
MUDevice *vtd_hiod,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
<br>
+&nbsp;&nbsp;&nbsp; /* Only do the check when host device support PASIDs */=
<br>
+&nbsp;&nbsp;&nbsp; if (caps-&gt;max_pasid_log2 &amp;&amp; s-&gt;pasid &gt;=
 hpasid) {<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;PASID bi=
ts size %d &gt; host IOMMU PASID bits size %d&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;pasid, hpasid);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+<br>
&nbsp;&nbsp;&nbsp;&nbsp; if (pci_device_get_iommu_bus_devfn(pdev, &amp;bus,=
 NULL, NULL)) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; error_setg(errp, &quot;Hos=
t device downstream to a PCI bridge is &quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;unsupported when x-flts=3Don&=
quot;);<br>
--<br>
2.47.3</span><o:p></o:p></p>
</div>
</div>
</div>
</body>
</html>

--_000_IA3PR11MB9136DF2D289C59655B75C9739272AIA3PR11MB9136namp_--

