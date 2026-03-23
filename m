Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD63EC01A2
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:42:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4aqz-0001iD-NV; Mon, 23 Mar 2026 04:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4aqr-0001hf-PE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:41:35 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1w4aqo-0001NX-Sd
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 04:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774255291; x=1805791291;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QX/++T26tnAsXunEW++7QOFg8wJOHrjH+QNT1HSvws0=;
 b=TlqCojcZhpC3ryCZIOb1CA16tWRfNflfVW8O+4mk6qAfqks45gXRwdYJ
 nq74g5HnLS8haXYRInQrmUVRnFpjT1Pj17271gZL6ZwbXngbELAJfM563
 qRy0CdLXYyGgwUNVDm2o/So6HEjBRozNiGFMIKEGT6Gaq36Z4GJoAz28e
 QaCgGfIAcEu0GuQ8Jl/9XYjkB2B1Y+tSHUuS9dCrCDDVHY4DSWfzwtBXO
 9DKYzcOgBAaDNTDR17+B9KQCogynWpwYY1v96v4BrAR/gmu/ocziNE8Ax
 13QFfU9OsJpLFrchqtnm79lkvhD+nubTzjg2hxqT5qLfrE+5rhDbnrJBc g==;
X-CSE-ConnectionGUID: wCIG/64pREWK+WrgxY6ZfA==
X-CSE-MsgGUID: pXc0VO4KQx6aT45A0e9AZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="79106158"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="79106158"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:41:28 -0700
X-CSE-ConnectionGUID: rX0hDXYVT8GjmJLmNmBOBQ==
X-CSE-MsgGUID: xGbyahPqQuuuSdz1/M15QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; d="scan'208";a="223983127"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Mar 2026 01:41:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 01:41:26 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 23 Mar 2026 01:41:26 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.55) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 23 Mar 2026 01:41:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRK+uDDvq7cBZXAUI52CQCS6scEoHGtSf03FiJ96NrNAOtmiKHoKLTH22hXh7zbXw8bfe4FGrYvzlTyXGdhuStWNAKAmBNDF8YswBUheI2iPPYJJJl7euefCO4Rk+0CbSu8neXCA9QanHjhB83jqdlXedW6BOqTmJ0c752JDqTPvm2qoq+tSvt81xxMBv6RFkb7O8lj0LgxGMyuonPWB9QTOsvdUAPBLVJu4bH4glJFUCBYFvJnyD7x5w0JVRNgzc7QGXc3bVNftmgTEwQnjZaMJoGpTu6Ln1QXAqU3vEMXvUVthaMmUpwrYSWD/n6UI4hmypAUi511M6j9CGw2zFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QX/++T26tnAsXunEW++7QOFg8wJOHrjH+QNT1HSvws0=;
 b=McgVaRWEP95ZHvp+zvOvY9LadD0nFpfW9rEIQ5/V0ZYFoIqhSd8DATu0r08YFSCczIoVS6qmCP/Gm8xgnrY5l17Wo2/r0heVeV9B6AdJqnUPzAJxCJlYw/CZxOMGcHiq/rLQr0nn3YvTLYyFeUVh7sMKqskQuLr6qTKMEEGoEnBLqpL7z6CLrzUuXyd/Mk3SIdegNU+DjGrtvHga74o9UJuG+9kvrQwaw8diJnX/WfObFhsFSXec3+ABVda3bAiDqoja/Lr4GWzb/5UWCr00lMwgL3gIj+EXtkZGiuhrqngp+zbUPT2LEzTIMIz5TBEEoe17RqUqPf81g4J5moJkyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PHXPR11MB9637.namprd11.prod.outlook.com (2603:10b6:510:3ce::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 08:41:18 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9723.013; Mon, 23 Mar 2026
 08:41:18 +0000
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
Subject: RE: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Thread-Topic: [PATCH v1 08/13] intel_iommu: Handle PASID entry removal for
 pc_inv_dsc request
Thread-Index: AQHcrRuagpYoYycHDkaeqayzx0ooOLW3SNUAgARywmCAABuXgIAAECbg
Date: Mon, 23 Mar 2026 08:41:18 +0000
Message-ID: <IA3PR11MB913636BA972616ABC982D1D2924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260306034409.184873-1-zhenzhong.duan@intel.com>
 <20260306034409.184873-9-zhenzhong.duan@intel.com>
 <e642e31b-49d5-49c8-af7f-53cd5768e336@intel.com>
 <IA3PR11MB9136E8022237A46CE1413042924BA@IA3PR11MB9136.namprd11.prod.outlook.com>
 <4aca274a-9b96-4963-9b36-fd710815d053@intel.com>
In-Reply-To: <4aca274a-9b96-4963-9b36-fd710815d053@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PHXPR11MB9637:EE_
x-ms-office365-filtering-correlation-id: 9347fd6e-03a6-4f43-e810-08de88b7f3a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|3613699012|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: DlvDAzpSNb+SIHTK1BGY0ZcYL7VKOL3yip73BMn7RsXM1NGnNVLx/BnlZvQ5kT1Q1pwNzGte9tI+X8aRpyqyz7GAV5R38bTniFek6jhVxLaiSj9SW3f0Ttu0YMIObExahQ1jlkX8STEfVym/SVX9BwHWezT4PRF/E6ib89jL4Uty0Zv9mYSTqPqwiWl+13Yt6eMl0KF/ggnFb/rBEW/AsBtbq4C+pUd1viWP9T/d9CxCjn88UYqxTNOHFTedjQ+8WlYCwpwwnmTa06m6tBDy2P8ZH9cXah0QD4WyGStFFsWe+k7+8DSfDSAvr+30djilY5RIKKXpSnqX0z36/M30TZzokwr1eTz8Kp3oOEj6URaJjNZogdMOYezy5ZuGYDmk3C3WsYh8z6Uf/a0QAeYnXyvgitRhsDx67t9Ri6w1+anFO1ce2ye2O3LtvP7tcINMfI6OqfLUBTPkT+OfRngpM6nkgQZrumrQJ9we+S5SQUHYW/1ecCiz6j/l9Xn/UqPVS3yWKnn21Cme4YjZ8WKz6oJlGXwnEZnxIn+UVv9DKQPy7dMN720wc9IYDhSdkUyyPfF+3r+ttXzc+8SbXFd5E4e/bckm2Sx/BQKkRebglXCO5jvixeJ8D0duWsoujrq2e1vxOoCl8p+6Xn+ahJTFHnzQIXK7WoQDD2y6El6BHSv4GsIfM1VPbVupfeNsVzIPnz07C8fo8iYQqFqSx8o5vA5Ttj1gV4jLZiL3ypnBCfYnJ/JVe+hlMW39xW1wA3HlKdQK0PVyVg/uY/i6fVGtZIe8JxCCZLw/VVbY/GEXfvnlpdcHZKGBTbPjbMNGBqMZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(3613699012)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWY2VkRwYVoySGhvT1l1WEpLQXhhSDdHSnIvQzF5MjU5dzhUa1dhRTE0MGNF?=
 =?utf-8?B?V29oT05NRXF4cFpRSi9EV1E1RHp0VUc2WGl2aSsyMXpoeFFJS0Q0NWpoYXps?=
 =?utf-8?B?N01GRHZHV2wwMlByREROcDNVQTBxaHVSMk1pUVdWZWx4YnFhOFVvS3F6U1NN?=
 =?utf-8?B?TksrR0Vrb1RlVHp2YjRpei9QTzcvUmUwL2F4V2Fid3ZRclk1d3l2dEJwWit4?=
 =?utf-8?B?WFBXNTNOMTd3Y2w5QkwwS0Z3dFJXRWFNczFVT2xBQ3M1c1JnWnozekxDU2ZG?=
 =?utf-8?B?RzRRSllxWUY5NHptK1dQUFN5b1ViKzd5OUhGR0NxSkZ2SURIM0JsSDdxWktU?=
 =?utf-8?B?WitIRTFOaVFnZlI5dmFPL3hJb2ozM2VSREFDK2VFTllKL1VBcGZFREZJelU4?=
 =?utf-8?B?TWJVUzRaWnhIKzk0SUg1czZkTHdCZEpRSk94NWQwTHBIZWtPUkxSMTNKUzhS?=
 =?utf-8?B?bitiL1ovc2tXZS9Jb3NRWmNmVUFTbnNQazAzNllHbVduc000ZjlWM1lvQW9S?=
 =?utf-8?B?M1dEQzNFRjRyY2FkQnRnOVNTOHprZ2V2d3ZvNHM2SFBiTGV2dTZTUDB3N1Iw?=
 =?utf-8?B?eGtnZnNnZWdYWXVrMmJFSE5WeTg1dC9kQWY4RWllUktEbCtYWlhPODdGYXVP?=
 =?utf-8?B?Tk5jUWlXcHg0RTlmUVZlTVc0NVFRTFNGNEcvSVRReE5BazBqelNod2VFaG1t?=
 =?utf-8?B?K0dOQ1Iva0ZRKzY5b284dHZ1Sm5Sd0V2VCsxakUzaE9kU21WZXlGbGc5WDJx?=
 =?utf-8?B?UGNoODVJbEp3NFppVEpIQ1RGZ1NkZDNZb2FlNGwxcHd6MXJJejgvZHlldTMz?=
 =?utf-8?B?SjBOTm1PV3Jkb0V4UjJqdDM4L2cyZ3lHcTNPWnlwak5HL0ZaZnRSVUl3MDB2?=
 =?utf-8?B?M2NMMEFmZW42dndBV2JsQ0thNThhL214MHZScERMMHNnYk9ZMENHQ1FocGRm?=
 =?utf-8?B?RjB5bDQvbXI4dlZORW5nemRTdDJXZ3NvWG1WMmxFZXV6LzdGREtueGE1em9j?=
 =?utf-8?B?YUkxVGkrL0I4QUtheGV0QXUxQWVqYVVMMVRvWmdheUNDL1gyZWpPT0ZwMjJs?=
 =?utf-8?B?NlZJWTF2WnlCQkdpc1NObk0yVmpQUVNLRW1OSUkzb0kzaG1LTG9vRVI2K3ZN?=
 =?utf-8?B?N21nZ0l4dmF0cVJuR2o2NFlrbGhlaHJsMTg1d1IxMFFWR05VYTNRMG9yTFhR?=
 =?utf-8?B?Yyt1S1ZBNVBEem1nbnUrS1ZuWjlJTGVibzYrV0VrUmwrYlQ4SHJkN2dJR0RB?=
 =?utf-8?B?eFEvUTdSQ2hFNVRQUXRmU2tyYmRTMkk4VDdvajd0M3NEVFpuYzlVeEx1VUsz?=
 =?utf-8?B?M3U3akpsZzNlOUptVUV2dXNWWEdoOTljMTlGZmVQNGFSVE5MWGV1Z0hvMTdn?=
 =?utf-8?B?MFFheEZPS2l2KzVWdW5DVngwWC9qVnNkQ29YNklSTHBGaTVWcDBwd2NCU0VT?=
 =?utf-8?B?UzcybDlucW4xazFqOGRoRTZnSUQwMStvL1pLY3VrV2RXU0huYlpTU0hPdjhK?=
 =?utf-8?B?aDQyV2F5ZVRMOTVadGdpbGxXRjkyL2hFSjBkQjBlMDUrN1lFTUJFS043UHp6?=
 =?utf-8?B?T0xlWngzYXVWaFdITUNuT0RJdXVhVmM3RWI3Zm1adDluQ29DM3ZBcDlKYys0?=
 =?utf-8?B?VVIzZnVhUzg0M0dkZTJmQ0tpYWhtYnloWnRkWDlsYklsdXVjVDk4bFA1cWlj?=
 =?utf-8?B?M0xvQWZpbms1VzhoWWpCYzQ2SXdJNFpXRW0rdWZwNnF3WkIxTHYxb1RhTFBv?=
 =?utf-8?B?TmN0Nm9RU3Rqekh5NWZKcWVFYzNDTW9KSlg0SVNFTm9MU2JMNit4ZHUvTEQ1?=
 =?utf-8?B?Vm9BR3YxMFhRYTNubnhkZklVbm50b0ZPZ3l6SzB4OWtIQkpnZTJIZEkvcG9h?=
 =?utf-8?B?Z0IvdmNZbXpxdGtEbnVlaUc2Y3NoVlVQRVR3ckJyQlc1anNqZjFJcjhSak1X?=
 =?utf-8?B?cXJES0dtLzA3dE92eWpIMHJBSzRIemRKYTkrTDQvejhzdUhrOUUxK2FWV2ZQ?=
 =?utf-8?B?Y2NEQVpNK1ArTC9NQnlxcC95TFdRWWtwYWhnNElRNHdLcVFPMzlZL1g5OWRU?=
 =?utf-8?B?MWVVWEJsMHQ0N0NTTHA0RGd1ZFZST1hDbmhBK0dYUnN6QUNDbHBsZkZFOGZo?=
 =?utf-8?B?YTlxZ0pCalJrUUcyODRRVmxoUzh0NWNLcnlrVncrcHdKVlVRbktpL2RSOG1m?=
 =?utf-8?B?NVlxcG95RnpIRFZqNnNQakJlT2lkR1lqWUJ2Zk1jaGJEb0xRVDBhbXE3ekQz?=
 =?utf-8?B?YzJpS1hFeW5OZDNPTW1wUnR4czdJWFZwa3VmQzJyVmNrdzRoVjkxTEJxdVY1?=
 =?utf-8?B?T1EvNTB0VTc3aUlSZkZJNVk5WGdoRTZTUmZheDVaNDBJSFkzVURDZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Z/6DWtzWb9Ks+NiYLSmFh2uqk1nkk62Xh98/BwEdrrf5/8/VDMzIfnHeQyfMzvtwleC1FzbYPnv19iWj/pbrRsC5kIii3LZYf+6PPQZbCuSk8yHqlJLRxb9YOaLUTCqz3/6x4cGsUvCFKVr/oVTfmK1GIciqv9+ZMKix41aL2RT6recO0NmfefUF+MXSSk71RN8GgrZ5KI9pIEUMWpMMFDnXCd/m0LyYEILWiQFGkeIz6faAXMXT981eqlvG/e/KSiZV0y3KBPdgSn+xLKj8QrkY6NCkFjkXTT1EWogpJqXltEoEj722FXWf4fBBaGi39kZ7xe/YoPQ8sAHjkB5HGw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9347fd6e-03a6-4f43-e810-08de88b7f3a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 08:41:18.1067 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MOQeHGWN36zEdXeSflGjW/DroKXiAwgdzY+4LdUrtXmWPo4Xvj9SzW9xOn6y2I5rjpvz0UrGJRnnhdmaEt9krQDfRCRZqI3/RHXOib3Lx/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PHXPR11MB9637
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
aXVAaW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDgvMTNdIGludGVsX2lvbW11
OiBIYW5kbGUgUEFTSUQgZW50cnkgcmVtb3ZhbCBmb3INCj5wY19pbnZfZHNjIHJlcXVlc3QNCj4N
Cj5PbiAzLzIzLzI2IDE0OjA4LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+DQo+Pj4+ICAgIHN0
YXRpYyB2b2lkIHZ0ZF9maW5kX2FkZF9wYyhWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9oaW9kLCB1
aW50MzJfdA0KPnBhc2lkLA0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVlRE
UEFTSURFbnRyeSAqcGUpDQo+Pj4+ICAgIHsNCj4+Pj4gQEAgLTQyMyw2ICs0OTEsOCBAQCB2b2lk
IHZ0ZF9wYXNpZF9jYWNoZV9zeW5jX2FjY2VsKEludGVsSU9NTVVTdGF0ZQ0KPipzLA0KPj4+IFZU
RFBBU0lEQ2FjaGVJbmZvICpwY19pbmZvKQ0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBUWVBFX0hPU1RfSU9NTVVfREVWSUNFX0lPTU1VRkQpKSB7DQo+Pj4+ICAgICAg
ICAgICAgICAgIGNvbnRpbnVlOw0KPj4+PiAgICAgICAgICAgIH0NCj4+Pj4gKw0KPj4+PiArICAg
ICAgICB2dGRfcGFzaWRfY2FjaGVfaW52YWxpZGF0ZSh2dGRfaGlvZCwgcGNfaW5mbyk7DQo+Pj4+
ICAgICAgICAgICAgdnRkX3JlcGxheV9wYXNpZF9iaW5kX2Zvcl9kZXYodnRkX2hpb2QsIHN0YXJ0
LCBlbmQsIHBjX2luZm8pOw0KPg0KPmEgbWlub3Igb3B0aW1pemF0aW9uLCBmb3IgUEFTREkgc2Vs
ZWN0aXZlLCBpZg0KPnZ0ZF9wYXNpZF9jYWNoZV9pbnZhbGlkYXRlKCkgYWxyZWFkeSBoYW5kbGVk
IHRoZSBpbnZhbGlkYXRpb24sIHRoZW4gdGhlDQo+dnRkX3JlcGxheV9wYXNpZF9iaW5kX2Zvcl9k
ZXYoKSBjYW4gYmUgc2tpcHBlZC4NCg0KR29vZCBpZGVhLCB3aWxsIGRvLg0KDQpUaGFua3MNClpo
ZW56aG9uZw0K

