Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F7CCAC59A
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 03:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0X47-0005jP-28; Sun, 21 Sep 2025 23:18:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0X43-0005ij-5B
 for qemu-devel@nongnu.org; Sun, 21 Sep 2025 23:18:07 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1v0X3r-0002op-97
 for qemu-devel@nongnu.org; Sun, 21 Sep 2025 23:18:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758511075; x=1790047075;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=9yvAhW3IIyk5ZHezLBG03E/Z4qWmCd0B/FjhkhylR9s=;
 b=Kowj8i3v0/UBVgG/ir/a5VtyXwt99skuLrlABYIiIN9eovbaVzWPf0dh
 ADwIxEC6YogD9alwNZkbbTFP6Wa4bH4Z3NekhydXvscJjlualPoR+KppS
 lieRog99tKP9exm7qQ6TtsxOMGRqguWy44aogWeXDtQO1bcZpmIhWB/kd
 rMEbDLRr0XwdZoiDvKLTSF8HkftuAHStkV5Fe4SMka3CD66iN9+J6T1PE
 nkFJby8VpM54Hh7dvT87TkNDz25VXCwtXSYRVtdMEby3bHJVRYXlkM6/m
 X3yOxl9bKLWVN/7q75ik9YRts40V4s6V5iSraM+e/LOwxx9okXme4Ijd+ g==;
X-CSE-ConnectionGUID: enEUQAGgTSiCghzvm4EIiQ==
X-CSE-MsgGUID: 5gPE3LytTj+qkEiQxpLZFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="60823961"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="60823961"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 20:17:46 -0700
X-CSE-ConnectionGUID: /FyAAXjnQP2bSaKS7b4ozA==
X-CSE-MsgGUID: U8J3hpZ8RvS0beO0Ql4U2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,284,1751266800"; d="scan'208";a="176432267"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2025 20:17:47 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 20:17:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sun, 21 Sep 2025 20:17:45 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.33) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 21 Sep 2025 20:17:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GPv3imwQIGAx8WPoCWO/btk5/O1gML32BWEreiSVQnEqudlbTdwbIKn4o8BPKGUUl2CBDk2iyudBoaLl8uBJIe1Cnr9ROar5zF1rFJ2VFQAe2Vz8tfQbza8qEklcDdMkjeqVvjGhuVuywZmvXqDa+oloeI55hulwU5XXYYReOM2wg9huU1sbmEshDkSK6BPZNk442mcaChTzH2V7TiZ6Ec93OJM49SkXSYWxWWhXyHXdF9zCurmwzD4+pCbKYzYXVresS9SzvvlOD3omYQFyFeV4MnGeTfuxhS7kHWRLjo8GoMK+Pt6gbQ2PIE00jm2iuR3ZdYtYc/jRNLN71+N3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aw9VfHcfa57823pBFyElECIufAFpRVnd/qXXtNc7spI=;
 b=k81g/1ooaAV0htRgM9M2DUWt4mOl0SyPLWI3NxT9Q+Vc0UD3qydTdcAbMQbLfwi1SK1Nhx0r+cpSMutpoI9pk7vcCza3wA8G4tvCYmAgnsGshfRV35qozFDyUorW1cdX+UPHWBpnJ1h5jJhK46nqLkvirG3PdnB/3VjICGkPZR4SffNm9SSaRY2GvWPBXo5L3xsQygTeXDKQ1Qf7F/YsH+g+6AUhEdR2v9UZ3xvUyZO5resXKMFqNQeLDTQcnbvbjkQ7VnagQ2GplIFcJbqoEpUjnfKm+YQlnfqXm2xNi3GdmGLrox1Pn6f+IM30KH0iB/jpE8lWLvpO9sohjq6UUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB4966.namprd11.prod.outlook.com (2603:10b6:510:42::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 03:17:43 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.9115.020; Mon, 22 Sep 2025
 03:17:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "clement.mathieu--drif@eviden.com" <clement.mathieu--drif@eviden.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Hao, 
 Xudong" <xudong.hao@intel.com>, "Cabiddu, Giovanni"
 <giovanni.cabiddu@intel.com>, "Gross, Mark" <mark.gross@intel.com>, "Van De
 Ven, Arjan" <arjan.van.de.ven@intel.com>
Subject: RE: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Thread-Topic: [PATCH 1/5] vfio/iommufd: Add framework code to support getting
 dirty bitmap before unmap
Thread-Index: AQHcIfvimBrBaa+XB0KbskuA8pwIdbSaTDWAgAHZT1A=
Date: Mon, 22 Sep 2025 03:17:43 +0000
Message-ID: <IA3PR11MB91368AE2A58185BE00627E149212A@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250910023701.244356-1-zhenzhong.duan@intel.com>
 <20250910023701.244356-2-zhenzhong.duan@intel.com>
 <ee5c9d7c-a85e-4da4-bd5a-a59951a19a06@redhat.com>
In-Reply-To: <ee5c9d7c-a85e-4da4-bd5a-a59951a19a06@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB4966:EE_
x-ms-office365-filtering-correlation-id: 684385ce-e02b-49be-bcc8-08ddf9869890
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?z5Fa9w8j0LV2UjdPAL6WRDnmdzpNkF4VY9A9TZcYOtUq8KJ/7D9z6Eepfp?=
 =?iso-8859-1?Q?i9eXg+bMb1ls2UBOVYF1JpH0g1kJZMh8nN2qMqc9Z9k+YrCJgdkc2iJSl6?=
 =?iso-8859-1?Q?tTRKRBu43KNIQlvsUZMCm2KuNVaULEr3/EukXZSmPnyMLefPdJ8++cWfMw?=
 =?iso-8859-1?Q?Us8P2SQiUH2itrw19P7MGiQEYYQIj4vkpdqhHYl7egjzwbms9eWj7P9JsV?=
 =?iso-8859-1?Q?Uoc251eYXeIwtzAm5tyV8x+uo0hyAQO6dr8Rsq4Mmj2LxGsZYamkFIWbMy?=
 =?iso-8859-1?Q?NDbqHj2T4OKB3VasA3ODcThQHu/q5SOtTGrz+RVJzn/5Kr0mtfmxUkNT3D?=
 =?iso-8859-1?Q?hQH9D3pexON+iH1M8lbHmbvPeXVLUdoVlB/dEVwCc2Zj7cfdpl+pZ/FAyr?=
 =?iso-8859-1?Q?ayhjxl/um0jy2xW0Bta3TBpPDw+QvQnbYaGHt9lYMWxr4NSMUZMGotqV9Q?=
 =?iso-8859-1?Q?ALE73d4DImXXqdaClm9im7bJaGpH/Cf9SJMOrM7W6aHQmj8AYGKi3mFq/Z?=
 =?iso-8859-1?Q?QBP/rtXV/c7FtGHopTof7FyJEJBQTyWsUjdtke696STWLFCWxQlT8PVJns?=
 =?iso-8859-1?Q?sCDr3u21MI2+64BWf0hQ3T+jK4MqtTnJpJFCywtfEywMWnbuowolTeZeIF?=
 =?iso-8859-1?Q?6uilDZS5sPGNwpt7e6/x/aDmDacoGQM1N6JTVro33ygPFjwNAp/rrjgcJf?=
 =?iso-8859-1?Q?Vm8aSJ0KMQNTVNROW6XC+ENQ2yxXOlsPTicY/ldoRN0PInrltloreiI5vn?=
 =?iso-8859-1?Q?21CmTSHqRo4HSqLgewkLVWvdNM8MDDanI09bFUgVow5gRFfdCkWzBtkKtP?=
 =?iso-8859-1?Q?yUEwySNkupWRRgOifo8BfndyCRnVkAfWtLzyOZ+Va1HcasQ4LYjIv6awYu?=
 =?iso-8859-1?Q?h+UA73lOZkdxiLhDDSyEBEUz5b5peEwmtLhrj5LIYPTvcuJ4XuUCs9llab?=
 =?iso-8859-1?Q?1xCfwR2tKD2srKt3AWHi4FaPSsucOzTTM5VacPU0kmzD5YozOC9GARXAhB?=
 =?iso-8859-1?Q?2lo0Ln5UJsm6hTiGzXQJoKEWFjIARlYnsJ8oypXQ5N4NSZ+Fvu5iKMckVN?=
 =?iso-8859-1?Q?auv/v+wzjZYsFoJPKF1cBrK7gmZId8OvtFdb8d4NxgJioejRLyJpsEldrE?=
 =?iso-8859-1?Q?dxpNl6Xl0WUShm4EDfyjykfB22sqv9lopSgkeRnfGVnt+v0Po2pJ0hR53a?=
 =?iso-8859-1?Q?RJaMCbNcksZ1qQ0+cXydbc0v1Y80MBa0421KKTVrhK0xuTixPJpekzDjiP?=
 =?iso-8859-1?Q?lnJrvum2l3F8dp8cxgeZQ0QBESnPC+Yzmuy+hawuWewRezCPb5sIYRYG+s?=
 =?iso-8859-1?Q?HnBS5nRG3fgUUjBnSjdcRkln6j1iP26MUmQnyBYn9Ey5Pl05D8gTCkcDGW?=
 =?iso-8859-1?Q?SvKbebt05bqUbIY1IHGjckuFB+dAt1jJEmDWKh2T1uKJYupVYiYi2vgekw?=
 =?iso-8859-1?Q?GvksIFpN5lWrSk/iDSZq0PBNTq362cN3+JfJphesVS0ECj5w0m0TdDee4W?=
 =?iso-8859-1?Q?5aGV/ml7Ck+W1uUfM1/t5gu1YuU4aa/gWSBK3LF8q1QrtZZ7h97lsiK+Jx?=
 =?iso-8859-1?Q?bQygjI0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?c/OPOK0u0ZnG02gp5Cou1NNhBw5ZljOOa1cv52rWu7gDhixnrma+RGODjh?=
 =?iso-8859-1?Q?2eUtSif/R95uY6EonoC+V0stVRoRpi4cwshAlqH4bcnHC4oSbfXZdcB3W0?=
 =?iso-8859-1?Q?VVGVmYNseLbB+yttnIBz/luvcsFRQNEssW35XchAlw5QMvy1IVZMihyuQn?=
 =?iso-8859-1?Q?ojP0xytsLsONRnjzKvge2SQjDr61apjiK660Yi9+ZmhC3wVEnCpi0b0eN9?=
 =?iso-8859-1?Q?tY8Cu6/n4ElyD32/tXXhePxvWg/UmV/eE02gVXbf0MJlIApzyoxUkhXfKg?=
 =?iso-8859-1?Q?ZIvTsCzL2XGzRt7cON8xAAHW0CFjZhVzBujSzy3egKn9LasRb8U0TdeIpB?=
 =?iso-8859-1?Q?HTblnc3mxsEa3QYhDZ4PCjcXA5iRtVxuuxs0Sj76Z/AtxwDzUyD8ycKuEv?=
 =?iso-8859-1?Q?a5yXRZE3ojLLdSCQlMvaUkw8sQPDwpQMTn891ocGnG5Fe+1X+tVrHiNdLj?=
 =?iso-8859-1?Q?0gQjvM8HpL7uiZ6bQX0Z5i4WvoNabvI5lwyr/CgvO3G7EXJCASkz4A+Lc9?=
 =?iso-8859-1?Q?+3FxPIbAUX16yZ1uCml1MfZpHgPWkVAJPt8tSugayuC3uM32qfVerEqQZY?=
 =?iso-8859-1?Q?X6r6YXOJX6aUwkHWLYfmmAf99g4e/GUIdtzFfaGPeThx1BP3/M93qE8zJi?=
 =?iso-8859-1?Q?DclKe1Wuls/KrSuc9GB2IPE9LeJQFStIrMQJOzEGPFRtzC6Zbw5mBbKkcS?=
 =?iso-8859-1?Q?dPGQXws1Tw+8pU0cmTU5hbdG4eABzx+IVANsCmbbCUIbVIs3nUK6hTAWeZ?=
 =?iso-8859-1?Q?OToDxgxbCCzyTTxTCXP6A28iXZmAvSocHmN/pizGNEgvneFeyhT3Rvi2aI?=
 =?iso-8859-1?Q?TIV1BCp4wx4b2e/CYdjFQeJ5MartzpVnaKWWkcoxVWmQZ7WUy8urGFD7nD?=
 =?iso-8859-1?Q?GKDC9wospH+rRd6ntooh5r2vyquHQTGb497Mx/1tWNlKmgHxKY9rjnH91K?=
 =?iso-8859-1?Q?yv2aZXIi0L5GKtY4hHU6ilvKTgh1buVrAYzQEMsEDrqLCFpZPH9Nv4G5Dn?=
 =?iso-8859-1?Q?mVAYvaxAgipPgZgfIDhSHN0XiZgoPS4rCCadHCIiSjhJTypCbJ39QnqCdm?=
 =?iso-8859-1?Q?EboAABJ8sLpk9Z0lq9QoacfXzuX6RU8o1EG/opFqNiSa065qaPJhNF8oad?=
 =?iso-8859-1?Q?XD6mtqwCXlvE+siBMj7tFesZS3uKICkbvwlsaaiMJUXUQY91KrVtJO+Ptd?=
 =?iso-8859-1?Q?fccw36LK2MSb8cKY6P1Y3Wjeg2TybEe08djWmX5yPDdniuvR7mYBBKw4MN?=
 =?iso-8859-1?Q?ZSDHQnLgZqxCEYr3gmOkss69FF4LFwONjilMDrmozNVJN92hkfHC71Dil2?=
 =?iso-8859-1?Q?U2pn5xPPh93fkTyOK/yiiH0kuYACevCWXb8itoL5uNtogKxso9CVcqZf32?=
 =?iso-8859-1?Q?Ght2wetjomqjQFejPl+782CKN0lOVVKVFKM8LgPG4Hmof/aFcApTJlKDej?=
 =?iso-8859-1?Q?hZEr0kLMAXfAciwBP9+dye+v3ZD/hHf7XguDKNgah0yp0WkEmAEYeTzjVk?=
 =?iso-8859-1?Q?J/3UW1Dg6yj/hkjC5n9j3Y0EXIFpVzO7H/AKZmGGfyIb8LlVKvAOCnhE5L?=
 =?iso-8859-1?Q?LzuE4nvARv4OMDrmpSIEzxB38BYIGoo0QH/evf214WTQfl/W+6vKEnD5ZE?=
 =?iso-8859-1?Q?fsSOoJnVta9wX2pIQMY4WITQb4mCI5xgta?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 684385ce-e02b-49be-bcc8-08ddf9869890
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2025 03:17:43.6883 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qnBh5Sx56oqDXR8IcOU40TNqvyyX7wCRdeEs3Hsx0r+qIiO9WHCNgAgOADV5LHs8YwD2lL1HR4FgVZfbwU//esVq2KoHcjSGpyQLnwpbKP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4966
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

Hi Cedric,

>-----Original Message-----
>From: C=E9dric Le Goater <clg@redhat.com>
>Subject: Re: [PATCH 1/5] vfio/iommufd: Add framework code to support
>getting dirty bitmap before unmap
>
>Hello Zhenzhong
>
>On 9/10/25 04:36, Zhenzhong Duan wrote:
>> Currently we support device and iommu dirty tracking, device dirty
>> tracking is preferred.
>>
>> Add the framework code in iommufd_cdev_unmap_one() to choose either
>> device or iommu dirty tracking, just like vfio_legacy_dma_unmap_one().
>
>I wonder if commit 567d7d3e6be5 ("vfio/common: Work around kernel
>overflow bug in DMA unmap") could be removed now to make the code
>common to both VFIO IOMMU Type1 and IOMMUFD backends.

I am not clear if there is other reason to keep the workaround, but the ori=
ginal
kernel issue had been fixed with below commit:

commit 58fec830fc19208354895d9832785505046d6c01
Author: Alex Williamson <alex.williamson@redhat.com>
Date:   Mon Jan 7 22:13:22 2019 -0700

    vfio/type1: Fix unmap overflow off-by-one

    The below referenced commit adds a test for integer overflow, but in
    doing so prevents the unmap ioctl from ever including the last page of
    the address space.  Subtract one to compare to the last address of the
    unmap to avoid the overflow and wrap-around.

    Fixes: 71a7d3d78e3c ("vfio/type1: silence integer overflow warning")
    Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D1662291
    Cc: stable@vger.kernel.org # v4.15+
    Reported-by: Pei Zhang <pezhang@redhat.com>
    Debugged-by: Peter Xu <peterx@redhat.com>
    Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
    Reviewed-by: Peter Xu <peterx@redhat.com>
    Tested-by: Peter Xu <peterx@redhat.com>
    Reviewed-by: Cornelia Huck <cohuck@redhat.com>
    Signed-off-by: Alex Williamson <alex.williamson@redhat.com>

>
>I asked Alex and Peter in another thread.

Just curious on the answer, may I ask which thread?

btw: I just found unmapping in halves seems unnecessary as both backends of=
 kernel side support unmap_all now.

    if (unmap_all) {
        /* The unmap ioctl doesn't accept a full 64-bit span. */
        Int128 llsize =3D int128_rshift(int128_2_64(), 1);

        ret =3D vfio_legacy_dma_unmap_one(bcontainer, 0, int128_get64(llsiz=
e),
                                        iotlb);

        if (ret =3D=3D 0) {
            ret =3D vfio_legacy_dma_unmap_one(bcontainer, int128_get64(llsi=
ze),
                                            int128_get64(llsize), iotlb);
        }

    } else {
        ret =3D vfio_legacy_dma_unmap_one(bcontainer, iova, size, iotlb);
    }

Thanks
Zhenzhong


