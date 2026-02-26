Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34686FC5903
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 07:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvVj7-00046J-Uo; Thu, 26 Feb 2026 02:24:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvVj5-00045v-MB
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:23:59 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1vvVj2-0000NS-D7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 02:23:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772090636; x=1803626636;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:mime-version;
 bh=xCuVCsw6sODy7bg/KuhCy3jxX9BLXZK13vnrkVXfxGU=;
 b=POEA8uNf5Cj+ummb50HRuiHEAE0eiqNqr5zfFD5EUVmOtZsfCJEtefz4
 KLOmB1gZL3+HvifTnzuixfvbT2WM8hJowxzacYoTsiGDotA9BNb68Kd0Q
 yFeAVrSNvDB2i2wk1VLowq0aUbx+ykgdiHvH10mYPDXOl1jO/AZuVOqsH
 gnpbuNI33XDVzBEiu7IS+CoXwG5tYBLEuw//Zlu5cRfo0hTnYRNTBbBHs
 BTe8M50KVpOhGT+vljx5oE4U2ZinB3VTtvhZA0pTdsIlw8LU7TPHpnGe2
 L042l5J237jy7poBEYcXIaT2XzVhsW3FCzMA/ZYwND6912mIAWh9rl4UY A==;
X-CSE-ConnectionGUID: 1p8g9amYSV6U9vOigRnu/Q==
X-CSE-MsgGUID: VP9B/vaBTLmaI22sr0TsvQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73015958"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; d="scan'208,217";a="73015958"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 23:23:54 -0800
X-CSE-ConnectionGUID: dA0axWX6Q7iWx+T8yRfnIA==
X-CSE-MsgGUID: 4J0IWCRFT5+v+0+MQTr0kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
 d="scan'208,217";a="221462122"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Feb 2026 23:23:54 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 25 Feb 2026 23:23:53 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 25 Feb 2026 23:23:53 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.18) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 23:23:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZgVvuT48yJDYSz+srn7hvvFnm9Q7bqaj4RylbJzlUJfk1bgUH/LDyYVOqQixxDRrsApDYXvyyUzTEvMS2c5IcHd3jfJ48iKnsQttGYpxSydVCpOBusGxy7yqFAC4Fn4hhnud69NU7LP6TVGxi1zpVESjYw2xV6/IUEYq3EJ2ZhA0LGWU5ilyJ7W7TEU0EyEALEypGIdnUH5w0+rOIab+tYG++v64BSX8cp5ArvOLpfLsD8OyL3+OZGeVZEnysuEcU1lAgFfrQBUcHrHKc928Lub1+IVh6zGwxJRNan2B5UKbqFf2eQI2pl9gW8cqIbUxaLXM8XCoOgHDs8KaL+lCEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOiQdbTbjKiAVeInRRxlUz8lXfvtBz/f55gBHUvi0ok=;
 b=LLMY1uCBTwaRZvlOuDEFpwRhwJyVSdH74J4gAPoaXtP07yu6S9I3VNQbajFWKLB89fwP0NqbKDwEwtgs6ceMeQ4bns9cQ59rsTGwNoGx8nUXwDiI3/+V2yBhH7NoA/njfZ8VVGQLWkgu9CrjzvCpGDTPTxlOB12Ynr8p4Kafj+emV7Hy+44zdfeZwsMKEADxDddvTS+Ejb74mz2A0QClCgO8Jymm9hVOkh8MFTJA45Rb01F06PqMaL+VRphcQfgorjXengqSKZ4Gqf4iSEYYuUZyeod5ZL+NrQM4h/ur0KY0Ijmp8Bh5KDURl4uBPkF43L5745LxUnGrq3kXu02BdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by CO1PR11MB5139.namprd11.prod.outlook.com (2603:10b6:303:95::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 07:23:48 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9632.017; Thu, 26 Feb 2026
 07:23:47 +0000
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
Thread-Index: AQHcnWP6tyKy+zgBK0aBvE2Kf1JwJ7WTCNiAgAFesyCAADGdAIAADZNg
Date: Thu, 26 Feb 2026 07:23:47 +0000
Message-ID: <IA3PR11MB9136EA84C2DE4A3342273CDB9272A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260214034135.220413-1-zhenzhong.duan@intel.com>
 <20260214034135.220413-13-zhenzhong.duan@intel.com>
 <AM8PR07MB7602F76D7799033FFCB1A5608675A@AM8PR07MB7602.eurprd07.prod.outlook.com>
 <IA3PR11MB9136245DC6D58206EC54E2C09272A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <AM8PR07MB7602232CB25D963A887E9B018672A@AM8PR07MB7602.eurprd07.prod.outlook.com>
In-Reply-To: <AM8PR07MB7602232CB25D963A887E9B018672A@AM8PR07MB7602.eurprd07.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Enabled=True;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SiteId=7d1c7785-2d8a-437d-b842-1ed5d8fbe00a;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_SetDate=2026-02-26T06:34:09.791Z;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Name=Eviden
 For Internal Use - All
 Employees; MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_ContentBits=1;
 MSIP_Label_ecb69475-382c-4c7a-b21d-8ca64eeef1bd_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|CO1PR11MB5139:EE_
x-ms-office365-filtering-correlation-id: ed10f924-b4c6-4dc8-895a-08de7507fb92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|7053199007|18082099003|38070700021|8096899003;
x-microsoft-antispam-message-info: DXayHrk6+rd/c4weCz8BWFff3PwzQWCYkoBhlcmFK8Z90xqCW5BHL+ZhldmbkTcqkiQcg0BUF9t+1404I5qhnFLnCv9ig4qP1lZ4ru4ksAFVOeVnzGI1xz80X8s/XQGdH79o6oUpA36OkqmztWIRZkzeygZV2NBonVjEMwC+EIJXaCCN/G16PEof6hAK4MDcxHpkaQm8zFDkxeN8RCAB9s1FCiXkYm8FoKQnxoxO+8w15t+qDkynml+v8ZXh/OHvTt3TuxO3Neb9OE1Y84AXhKpjEO0IoSO1SEVJvoIJC2qCJdxH2x91QYBQ1JFWqz0+RfCoj8DDwyeD9Agg1Rf1FQu5JzN44xmszhGcC2ewraxns4PTwDBB1JdcW0pWod4z1PokC0jDZC7zDhbCQIs1r21lfGJNiFX/Gd2mFqvO7bQP4s21dpRebCD/srBY4PZubOWHuDMwH72n3BOVN3Qk7fBeR5SsX0J81gXgVaq7v9sVG7VJ7D6JBbfVmEYU09xABxf81x4/e+70A40Bwk+41XFx9+uwWXy0kPnOLIutXMgYywDu0/JCLH2Jg7TbR8UdEfnUe0cDyyBkSaW7ouQ+hUITro2vsd6ErnIKLLV1vauvbI/97tesFcCtnkj0YXuOkHEX2bdCBS1QmUHmkOe706wvJ3JF07+P0vA6NCBog+OF0muEMq29soIo9rEGURgxS54fchlpOgOjTqI9WiPrUXTM4JlA+VmzmsJOc6ieYrOVyeQ0+b7XvBRoPyX/BMhUM4uc6DRTP+t6T1uwnFkAz5KtHicXDZmIwB2cw//LJow=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(18082099003)(38070700021)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3mFkueO3tNh5CM2sYSTG7sv/+RAgbFS/2y/5XXLasSz/NcOk2+wxrlUe3MPp?=
 =?us-ascii?Q?7b+XHK1rZIRiSnQrkmunfWLoo6Ghpv7BVB/murJzKCNi8Zfu3vhl6vLv0mPD?=
 =?us-ascii?Q?cqYwWsx5gLUNdXAqGOPvQYyZyxUiE1kzgAZEvl67gVlE5Q729DWKdJZ2hjn/?=
 =?us-ascii?Q?O1LznEGYzjdSHAq2ttNI0U9bRe2CtmhGvWTOj3g6vjPrdGfhD6y3a9t+G0SV?=
 =?us-ascii?Q?zcyBvcY0402m2E+ySsyzHLaJAUnFJzMoTgZnh2ICS+CmF8RsMb/yL1aJelDu?=
 =?us-ascii?Q?SEJt5YOwWhM+VLU1ko+I7Tnvnv5LbUwikN+CYAMn5+MUvFgCacX9fveJONJy?=
 =?us-ascii?Q?kFXGmMldnDfrBMvN0ynhh4lsMrbm3ttnX94Ten6g5bv6SdmE2iN7+pKkRvzr?=
 =?us-ascii?Q?OYSzEkv7k9SCipnjpjdF7EGoXS7QlJCQ5UE1+Shk4OaD29q0DJn1WN+oFYoH?=
 =?us-ascii?Q?g68k1ux/7tXiX0StLubZyux3OL1zL5O52pXowKAQM26C/hhhtBGMdU0ub1ya?=
 =?us-ascii?Q?kbV+ZKSBHZJstt+vorqSWW98bc5PuowvCnjqcMmCvVCRBP6Ll7yDZNlvyABA?=
 =?us-ascii?Q?wt+sSq47ch2+UO/aITJ3o7ZUwyvxw//tYZ+ILfxygwVqzr6HyAEqySaHwUD4?=
 =?us-ascii?Q?kwYvlwhtn1qh3dNBmqlPw7fQ2CyhWIPMof2dLFQaHVpdERS14PkaGbKXb4F+?=
 =?us-ascii?Q?zjqZ1+YEvEuBLjL3KgC2Er1j1ftmcESXtSiBnr/ilswcXZS7VHAeG1PdMx9i?=
 =?us-ascii?Q?YT+qUGOl1zc9YWNgEZ1FKyJnZBcgfLnRwsfMRMqY+JOMPF6U0QciIWsAqguv?=
 =?us-ascii?Q?XwCTKqZp1YzlUOzhi4xEcu0UgVbpHayJovxuxmw1qmvbzTeE8K8DRecpRihC?=
 =?us-ascii?Q?1bttPw4/5BngK2N9f8SnyFac/b9SMuSCPgOwUGQ1e63iG7cSO/W+OjjufrT9?=
 =?us-ascii?Q?LD7qgMHX+TNdZQZ95u9c6UGg0WtO6f+qvNnGepdi4ljwet+DRWaeVGUnwWnd?=
 =?us-ascii?Q?w8Npwy0MEswXNA0qVn9gHDOelGHcIuHG9GkPENRS2RwJAeMd41iOmi37BUcf?=
 =?us-ascii?Q?CjrKMXXqJ4eTZGknw03EcIkvVxvzOEw0mUlS5ohE1N580uTRVJ3nUIMdDhmc?=
 =?us-ascii?Q?Cdretm1UhBwGb2Fog+SmRu5Vc8a+viVAHhg7tz4UQjCndm4Vwwqz/CzUsb/i?=
 =?us-ascii?Q?nAZjmcq7rI9Njw1ZPd5JQcTbrAq4Hkj+nSqb8cX38rpL9naKPo0wVkpnLMlh?=
 =?us-ascii?Q?g6lGRxty8q9uHcIkGMBpFenwMtqelUEpfuYwy3EUSdR9/wB9qDl8jeFwCpgv?=
 =?us-ascii?Q?N7m3u0hbK9CwHkXeob5f5Kwye3wAhuyMMCIl4gmyTo4AP3x7a5KX9Ah5uwC6?=
 =?us-ascii?Q?xHfZLLhoilxalOLXa+XJsKuSnDE2ajlgmOSWXtflUENrhiCIkMRqVpRkNCgp?=
 =?us-ascii?Q?4H7gxmJhl80csyCdG1M9mpbgVmGeseIuC4zLYzrMiSlMO8TdgoPGoadz3k2J?=
 =?us-ascii?Q?/D6S9xGCniuLWX6cFNneWmDAPd8I23tqfDELjKi7foT0VNqq3iI1NK7vkYzm?=
 =?us-ascii?Q?NZ1B7j2IuWrRsXtAimyMf32/igP7CPC9BTveD+i6XJIjDKl6Uwwac9+nEY3K?=
 =?us-ascii?Q?xQt4RW3UbhBznR30vt/IehdW1gsOxF/+Bb9cgNfB6IxoT8h9d/7zeaOykH1Q?=
 =?us-ascii?Q?vslYGM4/OHNFP+FswkZyMTHzEI4w2ygUFwLxv2MQj5wJ/2dXPAW17NaTZovd?=
 =?us-ascii?Q?xGILBovK/w=3D=3D?=
Content-Type: multipart/alternative;
 boundary="_000_IA3PR11MB9136EA84C2DE4A3342273CDB9272AIA3PR11MB9136namp_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed10f924-b4c6-4dc8-895a-08de7507fb92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2026 07:23:47.8723 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RY+ftMs2B1IEum+fRvLMcV1z1uvRYcyUlqEOaoUR7a5qUclt0Nhi5nlLEw3SlSX7DoVHfuQ5HZU1x7luLrOVjhNNDwyxEnI3bqZt4YKCexM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5139
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
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

--_000_IA3PR11MB9136EA84C2DE4A3342273CDB9272AIA3PR11MB9136namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Oh, good catch! Will fix, thanks

BRs,
Zhenzhong

From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Sent: Thursday, February 26, 2026 2:35 PM
To: Duan, Zhenzhong <zhenzhong.duan@intel.com>; qemu-devel@nongnu.org
Cc: alex@shazbot.org; clg@redhat.com; eric.auger@redhat.com; mst@redhat.com=
; jasowang@redhat.com; jgg@nvidia.com; nicolinc@nvidia.com; skolothumtho@nv=
idia.com; joao.m.martins@oracle.com; Tian, Kevin <kevin.tian@intel.com>; Li=
u, Yi L <yi.l.liu@intel.com>; Hao, Xudong <xudong.hao@intel.com>
Subject: Re: [RFCv2 PATCH 12/13] intel_iommu_accel: Add pasid bits size che=
ck

Hi Zhenzhong,

In this hunk:

if (s->pasid >=3D PCI_EXT_CAP_PASID_MAX_WIDTH)

s->pasid comes from the prop and is the actual size right? not size - 1 ? S=
houldn't the comparison be > instead of >=3D ?

cmd

________________________________
From: Duan, Zhenzhong <zhenzhong.duan@intel.com<mailto:zhenzhong.duan@intel=
.com>>
Sent: 26 February 2026 04:37
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



Exactly, copied from PCIe spec:



Max PASID Width - Indicates the width of the PASID field supported by an ap=
plicable Endpoint Function. The value n indicates support for PASID values =
0 through 2n -1 (inclusive). The value 0 indicates support for a single PAS=
ID (0). The value 20 indicates support for all PASID values (20 bits). This=
 field must be between 0 and 20 (inclusive)



BRs,

Zhenzhong



From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com<mailto:clemen=
t.mathieu--drif@eviden.com>>
Sent: Wednesday, February 25, 2026 2:42 PM
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



Why do we capitalize the first letter of each word in "Max PASID Width"?

I guess you try to match the pcie spec, but just want to confirm :)



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

--_000_IA3PR11MB9136EA84C2DE4A3342273CDB9272AIA3PR11MB9136namp_
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
<p class=3D"MsoNormal">Oh, good catch! Will fix, thanks<o:p></o:p></p>
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
<b>Sent:</b> Thursday, February 26, 2026 2:35 PM<br>
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
<p class=3D"MsoNormal"><span style=3D"color:black">In this&nbsp;hunk:<o:p><=
/o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">if (s-&gt;pasid &gt;=3D =
PCI_EXT_CAP_PASID_MAX_WIDTH)<o:p></o:p></span></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black"><o:p>&nbsp;</o:p></span>=
</p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"color:black">s-&gt;pasid comes from t=
he prop and is the actual size right? not size - 1 ? Shouldn't the comparis=
on be &gt; instead of &gt;=3D ?<o:p></o:p></span></p>
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
<b>Sent:</b>&nbsp;26 February 2026 04:37<br>
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
<p>Exactly, copied from PCIe spec:<o:p></o:p></p>
<p>&nbsp;<o:p></o:p></p>
<p>Max PASID Width - Indicates the width of the PASID field supported by an=
 applicable Endpoint Function. The value n indicates support for PASID valu=
es 0 through 2n -1 (inclusive). The value 0 indicates support for a single =
PASID (0). The value 20 indicates
 support for all PASID values (20 bits). This field must be between 0 and 2=
0 (inclusive)<o:p></o:p></p>
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
<b>Sent:</b>&nbsp;Wednesday, February 25, 2026 2:42 PM<br>
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
<p><span style=3D"color:black">Why do we capitalize the first letter of eac=
h word in &quot;Max PASID Width&quot;?</span><o:p></o:p></p>
<p><span style=3D"color:black">I guess you try to match the pcie spec, but =
just want to confirm :)</span><o:p></o:p></p>
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
dth %d, exceed Max PASID Width&nbsp;%d allowed &quot;<br>
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

--_000_IA3PR11MB9136EA84C2DE4A3342273CDB9272AIA3PR11MB9136namp_--

