Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 761ACCA9ED0
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2026 04:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGTmX-0008Rn-KT; Tue, 13 Oct 2026 00:06:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xGTmQ-0008RW-DQ
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 00:06:23 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1xGTmN-0000DZ-Fj
 for qemu-devel@nongnu.org; Tue, 13 Oct 2026 00:06:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791864380; x=1823400380;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LI35QKLY5yEnaL2xhXS+SNhRTepAvtiYNiPO8kNGOdQ=;
 b=lzF8+jj7sWNIfQIfAMrqcr2Bizy+wcRL+KzYXR0yWiPALil0gAwNlNPQ
 pYq87qGXsl/2ByzSnGPCcdRxs2APBnHmc4+G0TicRO1V/HnNn1F4UbebZ
 4Vbp2PraUrn6e1MzjCmbL+wU6ZBRc0uPHQrIOZgSa8kQJxx6Jrxw4/rum
 3oTfkHa6cayHHEy6YkCbGCe9UVePmpD6VtRMCDwq2TMn6uiASqvieKERl
 OgNMI+7tzdqTIp1d/I4IgNAa2vVel7tcly/U5c/O8q+J2mQzroabpfKK5
 ZEDXX3Cp+9OIkSOIi3RT5H0c7KfdnHerayeqYK/2e9MPyDNBjAbrlbkIy w==;
X-CSE-ConnectionGUID: EPHVdVGjTWuYzqXY6jwjpA==
X-CSE-MsgGUID: /Qx+iNX2QBmpRUh+CfWazQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="480311"
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="480311"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 21:06:16 -0700
X-CSE-ConnectionGUID: puDWnLVPQ7icjAvYEzJeBA==
X-CSE-MsgGUID: g/jnAwUFSS+CrioZp6hq+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,154,1787036400"; 
   d="scan'208";a="987597"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Oct 2026 21:06:15 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 21:06:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 12 Oct 2026 21:06:14 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.45)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 12 Oct 2026 21:06:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KIGAW2ZF5LPsRjr9sXLOODGy+WjUCvp7+6Mpa3hxxRDZBBcrKZVxobeXrGLpV3xUh6gYfeOZOFHfp6uPY+0dr1O0sa5yW0Cb8QmfRN48J3YXGZKxnHdAfGEbSrhfRaN0lycKjUT00nInc0gbMEUprolsWjGdNaTTfhF0cT2/VqtxH+AD/Zt/tRrKIwGDVYHhwQPdbojNH4PUpnxhBFK0uu6DocvoXQm1oaZ7Bft0sgXzFcpVqCAMfzgQ7xrOdN39TPo5YHilS+PFoUTBYg9CBVSOV3WJWWuMPm02xjsra48N0cPKMITQszfXzkfykWqFKRPra/0UcAYt3QJuvjk7LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H74VRhCsUfhWukFXJCqXncgCKAocLlPvAXvy2CNYkww=;
 b=c7kdOL+yDa+d2h3AWtgnaWktuv7FRJPKwBPBgxEX45eUzZzVJnf57iPC0R8lm5X/SEJ02s+QQe/mV0W9ImWts5B2FyGIg9URi7kMLKLG5HliseGm5rTr4+178iNCgNw/yxS4ZPPn/C7tELYuVYFFbTxbp5wyxvjUs8zqNTjwWSqKpepWgAms4DlONjFnvSsP2Hgd6+XTWy/MaHmaOg2neVVa5CZfw9qPT/8gNC3YR4BKRnJJILJsF28kHyPcdAqajeCdYmZkTtdM1hIAZMkgsyDxUEN9bPtw+rvsfhQ0dn/1opDyaVs9NDWT5lvhW+lF4AWBe2jB66nIMPrv06ASmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH3PR11MB7177.namprd11.prod.outlook.com (2603:10b6:610:153::8)
 by SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 04:06:11 +0000
Received: from CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035]) by CH3PR11MB7177.namprd11.prod.outlook.com
 ([fe80::b997:e226:4979:c035%2]) with mapi id 15.21.0496.015; Tue, 13 Oct 2026
 04:06:11 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
CC: Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf from
 multiple ranges
Thread-Topic: [PATCH v13 6/9] vfio/device: Add support for creating dmabuf
 from multiple ranges
Thread-Index: AQHdVphlAJLtaSnr1k+pnx5j3pf8VLb03vkAgAQUeTCAAQO2gIAAaEyw
Date: Tue, 13 Oct 2026 04:06:10 +0000
Message-ID: <CH3PR11MB71774290FE2CE0532AD32FADF89E2@CH3PR11MB7177.namprd11.prod.outlook.com>
References: <20261007201222.648687-1-vivek.kasireddy@intel.com>
 <20261007201222.648687-7-vivek.kasireddy@intel.com>
 <306e36da-31eb-4e54-8b47-afb5ae55a6c9@redhat.com>
 <IA0PR11MB7185A1C516474E6EA317F8E9F89F2@IA0PR11MB7185.namprd11.prod.outlook.com>
 <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <98667ef2-8931-497a-bb76-04097a2aa43b@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB7177:EE_|SJ2PR11MB7546:EE_
x-ms-office365-filtering-correlation-id: a816cf2b-e9d4-4f59-aa14-08df28df50e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|260925021311599003|11063799006|22082099003|5023799004|4143699003|6133799003|260925022911599003|10067099003|260925021911599003|56012099006|3023799007|261009223027099003|38070700021;
x-microsoft-antispam-message-info: a3nKurPwq7YhAF8dP3RCi5otQ10OBKAsKeNKPxVCynPqAbxJdNyoMJ/e3b3Z97+DuOyi41OwMfJnA3opQMJ66R9hfeqT1Df81H8faqLs4h14ZMY+WV6Ync/9uEKk8adLahbvHKrEkftaUPjaWrem6ANDZEsWF2/qnxrFZuDrI5YTLjfqSQ2ZsddtgeV720FWuwRU772c/g/A+qbPJwmZesXiAKbfmbVdfNDGk5R1bif5bQyAEBy0VTVOph2dg1KVMLuoTAgPRHZIWj7b0tTzDhMURioaxeXniQl3SxWPBjg4fsmPlSOTpYDFYAHImqjIKW+ZV0uM2zuhAr6RG0SBsCLK38h9S0dJTyFGIGfyH8FZp/fe58Dss+maIJBaQBMub5DlcUbeOmqIqA52n/AWNE1I2mN5UkpNYD3XQsDPmmhUJ6waoBjwM7sIAztkO77Hu5sBoeiZ4sf4XH0y7IpJVBP7ELk1s2nX2nvwESPL5hvWw1VJ560zmD0gcJ2/PRBT46ADWYkPEt2lLf6PizMbWLU2MRMcexN/5MiIbjTIEuPaa7d5aGx3BzRBZzSvNJx2aAMlRk2vaqdbtT8WpEIiQH4GyWt05hLiR+PeqeRf3lD8FmzbnuT6Tpu6/cZ8gJqGaphr4ioXNaTdNCzIApbOWss9uHC8p+yJYIQuMn4pWKE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7177.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(260925021311599003)(11063799006)(22082099003)(5023799004)(4143699003)(6133799003)(260925022911599003)(10067099003)(260925021911599003)(56012099006)(3023799007)(261009223027099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?iDNyHSUbMemra85fH6PCo9aUVVLlQmPGEsaw6YAaw72e0K1dlp3xQGsRr7?=
 =?iso-8859-1?Q?yLsfJKbqTt2iduZiDlHs28c0HzI/ZXvEOY7mPOocWrKPZZsKDP1B25GDII?=
 =?iso-8859-1?Q?hHvrvBBufXwG1XpaDvv8wjv7PAYqTtDwRZRm8iiZOsUOi8dSooKIwiRt3M?=
 =?iso-8859-1?Q?LLld9q7hFMnHM1QUoR0EqLIAzin7EMWCjKFSvRVcfK2lJL0Wy/tx+Ich5R?=
 =?iso-8859-1?Q?+mRfZAEAFjUgF3MdCQNK2laiqdlOw2q7m2vj9hQ0CT/Hu6g3nQC1lM9Tn1?=
 =?iso-8859-1?Q?G8TlntkhUV2z40inxXcnzkwLBXixTcJ/FYQSKhxLaxK2jJ17bAKCo0o2fv?=
 =?iso-8859-1?Q?+I8YPnY+z13hGOGhmgQKHVSDEE1mgTLNcYJQaU+7OUnXZMGTJQpjHgkNxF?=
 =?iso-8859-1?Q?469lzOpatPRnFu+I1sOaiCZY2fo8nXkf1piKl3Kwtys1Z3Cw1/IyWQB+H3?=
 =?iso-8859-1?Q?5S8NhanhN0zR/nqpiEeGG/KiOXyXIHPzgHx1UG5oy44tE4hcwgnyzuFwGT?=
 =?iso-8859-1?Q?YsLTPmNhWfudBxeDteSdYzdxohR2XZX8c0qQ8q3O0niOmfSQGi7AR4ODG1?=
 =?iso-8859-1?Q?UKt6g4wqD7f/sgqvO0tycamV6m2FDzxu1ddT2YCRi0ofRyIcM065UCyBRC?=
 =?iso-8859-1?Q?aNfVtOcD3SDhG3Hv81wxAentjKIhIH1d6zZGoooptb5I23swFCLRNVw/R+?=
 =?iso-8859-1?Q?ebFnp3UfCXYLNxNILIb3jvVxJ7qyWAaSu8wAcpGYJIxZ4xNf6yWkrS9y5h?=
 =?iso-8859-1?Q?NduDFiYJGiNEARBWMQhY64DIhIQNR+tBzIDKkswkWiW4QZirG+yCrcWDL3?=
 =?iso-8859-1?Q?lRMw5lN3vPlGKbiKDTITDORJePaximYb9DHp1s8XDq/t96qH5Q4xwk9fKN?=
 =?iso-8859-1?Q?ev/oedSAwbOj+YDjANskS8QgDrIjZV3VOLqns+bYP1dsLL1ZQgoMmmjv60?=
 =?iso-8859-1?Q?RAe+n/2pacQsPGNOZ8RlgaYfxBC3GJVKp472NBbBZVOnkS0id0lUu2SOc3?=
 =?iso-8859-1?Q?QIlIDWhKCf2ST5KkbvIypHoQKS7Dcwr+5pxT8bymLAzq77/ok779wSDBjn?=
 =?iso-8859-1?Q?ZaJLqDZjvPqRcTCSapb3a9tF3Mz0xgbdn3ntDrpwcpKgd1bcJjHkITcM/M?=
 =?iso-8859-1?Q?XG2BB1dKeGY/9bfN9lHDmtupgm033HS4iA0s0XOZd4UgzB57KJW/Q4iavz?=
 =?iso-8859-1?Q?5aJNI+/N89YznK5whWVsWmYWavoNY+UX2M8OUJY/HXBarIB0qDLl8amN9q?=
 =?iso-8859-1?Q?zd4cElwSTjFts2mH/j8vaWhbnrrH5ghTpjoLeltxRcV0lWJq4DjLCmThJ7?=
 =?iso-8859-1?Q?IdRre0k3HDkd6f7Rsg5ZEMY0b8zOgjW3X0dmmgZW+Z2j2UFg2Q9egDJisS?=
 =?iso-8859-1?Q?B/6GnImNIn3FbfSyqiizgKdbdbFBpXmbx8o1HZq7LP35a4POv8B0KsjHwh?=
 =?iso-8859-1?Q?pSB29AloFvcXivcAUyLUsn4vJn0jpV3yxO0yF716/h9EbK4171RPKZw8rk?=
 =?iso-8859-1?Q?s286B3ueyXhftB1rPk5pTvf2e3rtqKkHO87gdoTD7AOYqJCK126cg8AjwB?=
 =?iso-8859-1?Q?9C6FQV2/RHEwHVhtEkDH+yeFB5mDOm5E+O23m82tIW2YTWjsmwG5ubPVO6?=
 =?iso-8859-1?Q?v842B4xlrie+Ve2xbHmbTMG+P6qTwkTIjSUEqeBYlc+BiRepQ8gjb6xdTT?=
 =?iso-8859-1?Q?JiERIkfQQ0/+4kuoTwmWtsuYO+im4zsiaGs5gWsHPvLKXUBTjUFzP3ve62?=
 =?iso-8859-1?Q?XoJw0zQ8RSX6myary0hdZIRnSX+Rvkm85g1TT05hMhWEkxy3ERVlyciI7l?=
 =?iso-8859-1?Q?qfNPKu3A+g=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: cCO1BFx04/60PPhgeqba89cTu/Q9qTqUT/CKmPTxmaAH0N3vTSjcIKc6n1VgEOtz7DQ7R8XrtDLL7fl5DlACHflsFKFr7KGBhzxJiYz5OwX/5W/WKdmCWdcLFBWWz7ZPcvB/GcMz8aq3JeAydswmfveCLRIjzVg/D5LAHq2h9C7Sy6IRL5bUs5mw/0DYwxV1Eh61YTCey6578om4fdvbc+tzfWex3+LJdx3+tRu/D7GjWY4pSGW/ax7InF+SpBJ+PYYWUcczL0KtTwE8w3DkGKNUvXOyi6j2OOVIDes/0sx5+vzFfVsNaqnBIeESkd4qtAYEy6kj66tVYJOO6RtBNg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7177.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a816cf2b-e9d4-4f59-aa14-08df28df50e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 04:06:10.8956 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imDT3V6tJa4cQF4LRYyzxnoSDxy6uUqyohiQ0wWOPeoK4QhlLSM82ppgCGEX0cL7gs7Dg+XwoHdkFPFeIscCoXQC0JSjWcfot0bIglF4RCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7546
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Hi Akihiko,

> Subject: Re: [PATCH v13 6/9] vfio/device: Add support for creating
> dmabuf from multiple ranges
>=20
> >>
> >>> In order to create a dmabuf associated with a buffer that spans
> >>> multiple ranges, we first need to identify the VFIO region and
> >>> index the buffer (represented by iovec) belongs to and then
> >>> translate its addresses to offsets within that region.
> >>>
> >>> The qemu_ram_block_from_host() API gives us both the region and
> >>> the offset info we need to populate the dma ranges so that we can
> >>> invoke the VFIO_DEVICE_FEATURE_DMA_BUF feature to create the
> >> dmabuf.
> >>>
> >>> Also, instead of iterating over all QOM devices to find the
> >>> VFIODevice associated with a memory region, introduce a helper
> >>> to just use the vfio_device_list to lookup the VFIODevice.
> >>> And, introduce another helper to lookup the VFIO region given an
> >>> address.
> >>>
> >>> Lastly, introduce an enum to return the type of error encountered
> >>> while creating the dmabuf fd.
> >>>
> >>> Cc: Alex Williamson <alex@shazbot.org>
> >>> Cc: C=E9dric Le Goater <clg@redhat.com>
> >>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> >>> ---
> >>>    include/hw/vfio/vfio-device.h |  22 +++++++
> >>>    hw/vfio/device.c              | 109
> ++++++++++++++++++++++++++++++++++
> >>>    hw/vfio/dmabuf-stubs.c        |  17 ++++++
> >>>    hw/vfio/meson.build           |   1 +
> >>>    4 files changed, 149 insertions(+)
> >>>    create mode 100644 hw/vfio/dmabuf-stubs.c
> >>>
> >>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-
> >> device.h
> >>> index 8472420d3f..c05430be8a 100644
> >>> --- a/include/hw/vfio/vfio-device.h
> >>> +++ b/include/hw/vfio/vfio-device.h
> >>> @@ -41,6 +41,13 @@ enum {
> >>>        VFIO_DEVICE_TYPE_AP =3D 3,
> >>>    };
> >>>
> >>> +enum {
> >>> +    /* The Guest passed addresses stored in IOV are invalid */
> >>> +    VFIO_DMABUF_CREATE_ERR_INVALID_IOV =3D -1,
> >>> +    /* Guest or Host may be at fault for this type of error */
> >>> +    VFIO_DMABUF_CREATE_ERR_UNSPEC =3D -2,
> >>> +};
> >>
> >> Nack.
> >>
> >> As said a few times already : it's a VFIO-specific enum leaking
> >> into vfio-device.h to serve virtio-gpu's fallback logic. The
> >> cleanest alternative is to use standard -errno returns and
> >> make the fd an output parameter.
> > It looks like Cedric remains unconvinced about the value or usefulness
> > of this error enum. Therefore, to make progress, I intend to adopt his
> > suggestion to use standard -errno returns for the next version,
> considering
> > that this series has been stuck for a year.
> >
> > AFAICS, dropping this error enum means that we would not be able to
> > clearly identify and log (or attribute) Guest vs Host errors in virtio-=
gpu,
> > particularly the INVALID_IOV case. I am not sure if this can be
> considered
> > a significant limitation. However, if there is a reasonable middle
> ground
> > solution or an alternative that you can think of that does not involve
> > using VFIO error enums in virtio-gpu, then I would like to pursue that
> > instead.
>=20
> C=E9dric's comment is a reiteration of previous points, but his concrete
> code suggestion is new and brings to light some challenges with errno
> propagation.
>=20
> First, errno does not precisely match the required semantics. We need
> to
> distinguish lookup failures from the other errors. However, with your
> suggestion, lookup failures become -EINVAL and
> vfio_device_get_feature()
> also returns the same value when the backend lacks the operation,
> making
> it impossible to distinguish them.
>=20
> Propagating errno also requires extra care to preserve it when
> necessary. For patch "[PATCH v13 8/9] virtio-gpu-dmabuf: Improve error
> handling with 'Error **' and err enum", you suggested to add the
> "saved_errno" variable to save errno before error_setg_errno(). That is
> redundant because error_setg_errno() preserves errno. Realizing that
> requires careful attention.
>=20
> While we could spend effort fixing these issues, we can simply avoid the
> churn by not using errno.
>=20
> In any case, I agree keeping this stuck is not ideal while I don't think
> I can provide any further insights. So I'm inviting Markus Armbruster to
Looks like you forgot to cc Markus. I have added him now.

> this discussion. This is an area better handled by him, who maintains
> the error reporting facility, including include/qapi/error.h, which
> extensively documents codebase-wide error-handling convention.
>=20
> Markus, could you advise on the appropriate convention for returning
> this kind of classification alongside Error **? Your perspective
> across the codebase may help us settle on a consistent approach
> beyond the individual subsystems involved here. Perhaps you may
> improve
> the documentation according to a design decision made here.
Markus, here is some additional context from Akihiko as to why there is
a need to introduce an error enum in VFIO:
https://lore.kernel.org/qemu-devel/09f02fe2-63cb-4283-899e-4cffc5f60cf1@rsg=
.ci.i.u-tokyo.ac.jp/

>=20
> If anyone else has a clean middle-ground solution in the meantime, I
> would greatly appreciate your input as well.
I am not sure if it can be considered clean or elegant but one middle-groun=
d
solution I can think of is to have (and use) the error enum just in virtio-=
gpu
only but associate EINVAL (return value of vfio_device_create_dmabuf_fd())
as the equivalent of INVALID_IOV. That is, the relevant code now becomes:

        res->dmabuf_fd =3D virtio_gpu_create_udmabuf(res, &local_err);
        if (res->dmabuf_fd =3D=3D VIRTIO_GPU_DMABUF_CREATE_ERR_INVALID_IOV)=
 {
            error_free_or_abort(&local_err);

            res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(res->iov,
                                                          res->iov_cnt,
                                                          &local_err);
            if (res->dmabuf_fd =3D=3D -EINVAL) {
                error_free_or_abort(&local_err);
                qemu_log_mask(LOG_GUEST_ERROR,
                              "Cannot create dmabuf: incompatible memory\n"=
);
                return false;
            }

I think this is reasonable IMO, but is this proposal acceptable to you?=20

Thanks,
Vivek
>=20
> Regards,
> Akihiko Odaki
>=20
> >
> > Thanks,
> > Vivek
> >>
> >>
> >>>    typedef struct VFIODeviceOps VFIODeviceOps;
> >>>    typedef struct VFIODeviceIOOps VFIODeviceIOOps;
> >>>    typedef struct VFIOMigration VFIOMigration;
> >>> @@ -323,6 +330,21 @@ bool
> vfio_device_has_region_cap(VFIODevice
> >> *vbasedev, int region, uint16_t cap_t
> >>>
> >>>    int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> >>>                                    struct vfio_irq_info *info);
> >>> +
> >>> +/**
> >>> + * Create a dmabuf fd by first translating the addresses in the
> >>> + * iovec array into VFIO region offsets and then invoking the
> >>> + * VFIO_DEVICE_FEATURE_DMA_BUF feature.
> >>> + *
> >>> + * @iov: array of iovec entries associated with a buffer
> >>> + * @iov_cnt: number of entries in the iovec array
> >>> + * @errp: pointer to Error*, to store an error if it happens.
> >>> + *
> >>> + * Returns the created dmabuf fd or either
> >> VFIO_DMABUF_CREATE_ERR_UNSPEC
> >>> + * or VFIO_DMABUF_CREATE_ERR_INVALID_IOV on error.
> >>> + */
> >>> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> >> iov_cnt,
> >>> +                                 Error **errp);
> >>>    #endif
> >>>
> >>>    /* Returns 0 on success, or a negative errno. */
> >>> diff --git a/hw/vfio/device.c b/hw/vfio/device.c
> >>> index 4f11959633..d95503a5f1 100644
> >>> --- a/hw/vfio/device.c
> >>> +++ b/hw/vfio/device.c
> >>> @@ -21,7 +21,9 @@
> >>>    #include "qemu/osdep.h"
> >>>    #include <sys/ioctl.h>
> >>>
> >>> +#include "system/ramblock.h"
> >>>    #include "hw/vfio/vfio-device.h"
> >>> +#include "hw/vfio/vfio-region.h"
> >>>    #include "hw/vfio/pci.h"
> >>>    #include "hw/core/iommu.h"
> >>>    #include "trace.h"
> >>> @@ -667,3 +669,110 @@ static VFIODeviceIOOps
> >> vfio_device_io_ops_ioctl =3D {
> >>>        .region_read =3D vfio_device_io_region_read,
> >>>        .region_write =3D vfio_device_io_region_write,
> >>>    };
> >>> +
> >>> +/*
> >>> + * This helper looks up the VFIODevice corresponding to the given
> iov.
> >> It
> >>> + * can be useful to determinine if a buffer (represented by the iov)
> >> belongs
> >>> + * to a VFIO device or not. This is mainly invoked when external
> >> components
> >>> + * such as virtio-gpu request creation of dmabuf fds for buffers
> that may
> >>> + * belong to a VFIO device.
> >>> + */
> >>> +static bool vfio_device_lookup(struct iovec *iov, VFIODevice
> >> **vbasedevp,
> >>> +                               RAMBlock **first_rbp, Error **errp)
> >>> +{
> >>> +    VFIODevice *vbasedev;
> >>> +    RAMBlock *first_rb;
> >>> +    ram_addr_t offset;
> >>> +
> >>> +    first_rb =3D qemu_ram_block_from_host(iov[0].iov_base, false,
> >> &offset);
> >>> +    if (!first_rb) {
> >>> +        error_setg(errp, "Could not find first ramblock\n");
> >>
> >> no \n
> >>
> >>
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    *first_rbp =3D first_rb;
> >>> +    QLIST_FOREACH(vbasedev, &vfio_device_list, next) {
> >>
> >> wrong list : global_next.
> >>
> >>
> >>> +        if (vbasedev->dev =3D=3D first_rb->mr->dev) {
> >>> +            *vbasedevp =3D vbasedev;
> >>> +            return true;
> >>> +        }
> >>> +    }
> >>> +    error_setg(errp, "No VFIO device found to create dmabuf
> from\n");
> >>
> >> no \n
> >>
> >>> +    return false;
> >>> +}
> >>> +
> >>> +/*
> >>> + * This helper looks up the VFIORegion corresponding to the given
> >> address.
> >>> + * It also verifies that the RAMBlock associated with the address is
> the
> >>> + * same as the first_rb passed in. This is to ensure that all
> addresses
> >>> + * in the iov belong to the same region.
> >>> + */
> >>> +static bool vfio_region_lookup(void *addr, VFIORegion **regionp,
> >>> +                               RAMBlock *first_rb, ram_addr_t *offse=
tp,
> >>> +                               Error **errp)
> >>> +{
> >>> +    VFIORegion *region;
> >>> +    RAMBlock *rb;
> >>> +
> >>> +    rb =3D qemu_ram_block_from_host(addr, false, offsetp);
> >>> +    if (!rb || rb !=3D first_rb) {
> >>> +        error_setg(errp, "Dmabuf segments must belong to the same
> >> region\n");
> >>
> >> remove \n
> >>
> >>> +        return false;
> >>> +    }
> >>> +
> >>> +    region =3D vfio_get_region_from_mr(rb->mr);
> >>> +    if (region) {
> >>> +        *regionp =3D region;
> >>> +        return true;
> >>> +    }
> >>> +    error_setg(errp, "Could not find valid region for dmabuf
> segment\n");
> >>
> >> here too.
> >>
> >>> +    return false;
> >>> +}
> >>> +
> >>> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> >> iov_cnt,
> >>> +                                 Error **errp)
> >>> +{
> >>> +    g_autofree struct vfio_device_feature *feature =3D NULL;
> >>> +    struct vfio_device_feature_dma_buf *dma_buf;
> >>> +    RAMBlock *first_rb =3D NULL;
> >>> +    VFIODevice *vbasedev;
> >>> +    VFIORegion *region;
> >>> +    ram_addr_t offset;
> >>> +    size_t argsz;
> >>> +    int i, ret;
> >>> +
> >>> +    if (!vfio_device_lookup(iov, &vbasedev, &first_rb, errp)) {
> >>> +        return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>
> >> return -EINVAL;
> >>
> >>> +    }
> >>> +
> >>> +    argsz =3D sizeof(*feature) + sizeof (*dma_buf) +
> >>> +            sizeof(struct vfio_region_dma_range) * iov_cnt;
> >>> +    feature =3D g_malloc0(argsz);
> >>> +    *feature =3D (struct vfio_device_feature) {
> >>> +        .argsz =3D argsz,
> >>> +        .flags =3D VFIO_DEVICE_FEATURE_GET |
> >> VFIO_DEVICE_FEATURE_DMA_BUF,
> >>> +    };
> >>> +    dma_buf =3D (struct vfio_device_feature_dma_buf *)feature-
> >data;
> >>> +
> >>> +    for (i =3D 0; i < iov_cnt; i++) {
> >>> +        if (!vfio_region_lookup(iov[i].iov_base, &region,
> >>> +                                first_rb, &offset, errp)) {
> >>> +            return VFIO_DMABUF_CREATE_ERR_INVALID_IOV;
> >>
> >> return -EINVAL;
> >>
> >>> +        }
> >>> +
> >>> +        dma_buf->region_index =3D region->nr;
> >>> +        dma_buf->dma_ranges[i].offset =3D offset;
> >>> +        dma_buf->dma_ranges[i].length =3D iov[i].iov_len;
> >>> +    }
> >>> +
> >>> +    dma_buf->nr_ranges =3D iov_cnt;
> >>> +    dma_buf->open_flags =3D O_RDONLY | O_CLOEXEC;
> >>> +
> >>> +    ret =3D vfio_device_get_feature(vbasedev, feature);
> >>> +    if (ret < 0) {
> >>> +        error_setg_errno(errp, -ret,
> >>> +                         "Could not create dmabuf fd via VFIO device=
");
> >>> +        return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>
> >> return ret;
> >>
> >>> +    }
> >>> +    return ret;
> >>> +}
> >>> diff --git a/hw/vfio/dmabuf-stubs.c b/hw/vfio/dmabuf-stubs.c
> >>> new file mode 100644
> >>> index 0000000000..fb5318e929
> >>> --- /dev/null
> >>> +++ b/hw/vfio/dmabuf-stubs.c
> >>
> >> Fails to build on MinGW/Windows.
> >>
> >>       hw/vfio/dmabuf-stubs.c:12:5: error: no previous prototype for
> >>            'vfio_device_create_dmabuf_fd'
> >>        hw/vfio/dmabuf-stubs.c:19:7: error: no previous prototype for
> >>            'vfio_device_mmap_dmabuf'
> >>
> >>
> >>> @@ -0,0 +1,17 @@
> >>> +/*
> >>> + * Copyright (c) 2026 Intel and/or its affiliates.
> >>> + *
> >>> + * SPDX-License-Identifier: GPL-2.0-or-later
> >>> + */
> >>> +
> >>> +#include "qemu/osdep.h"
> >>> +#include "qemu/error-report.h"
> >>> +#include "qemu/iov.h"
> >>> +#include "hw/vfio/vfio-device.h"
> >>> +
> >>> +int vfio_device_create_dmabuf_fd(struct iovec *iov, unsigned int
> >> iov_cnt,
> >>> +                                 Error **errp)
> >>> +{
> >>> +    error_setg(errp, "VFIO dmabuf support is not enabled");
> >>> +    return VFIO_DMABUF_CREATE_ERR_UNSPEC;
> >>
> >> return -ENOTSUP;
> >>
> >>
> >>> +}
> >>> diff --git a/hw/vfio/meson.build b/hw/vfio/meson.build
> >>> index c7c31b78f6..aa6f4bc1b4 100644
> >>> --- a/hw/vfio/meson.build
> >>> +++ b/hw/vfio/meson.build
> >>> @@ -38,3 +38,4 @@ stub_ss.add(files('iommufd-stubs.c'))
> >>>    system_ss.add(when: 'CONFIG_VFIO_PCI', if_true: files(
> >>>      'display.c',
> >>>    ))
> >>> +system_ss.add(when: 'CONFIG_VFIO', if_false: files('dmabuf-
> stubs.c'))
> >

