Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE669CD4F57
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 07:45:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPF8a-0006uQ-Dc; Tue, 19 May 2026 03:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPF8Z-0006ty-6D
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:45:11 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wPF8W-0006Hu-Rq
 for qemu-devel@nongnu.org; Tue, 19 May 2026 03:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779176709; x=1810712709;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WVgdsCYsb3+ttGkYiIKTqAFFdGXnHupizauufMvBP/8=;
 b=fYrDa7SytvCA0ItiN9KyaBI8fX18GTFF6SeTBhC81r06Uyy7DqBhmZvL
 xvdqgkXSPVgalkFm2iTtJgMRZNXgZRTsEXFLureckvHRPSO4U+DXdwz5J
 PRUBGvCChlghCuwvaRJo5tdfyGZKnklRhnf52w5CHnSpzrQM+s1JMpmqa
 Zvvpsv6OlXkwTL+zVYuRKnBRhzroPjklK81Oapo+bbY72k+zmlszEahCj
 z6KmptltkLXUNotYrYVl7103rpjOfNbL8sNoQBygxDaj64XI3aiszBTAM
 gWB6E7RrIueuJ1TDJHGGfNgzUwv7HrqhGqlhwKiOXBnAirGX+2hZMhhkf g==;
X-CSE-ConnectionGUID: LxsEzUv5Sb68FXPIvWWIug==
X-CSE-MsgGUID: oabs7wCmSSmCfgSOh4S5pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="83924605"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="83924605"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 00:45:07 -0700
X-CSE-ConnectionGUID: KsaKHvTSSLWKxgnFwNiCFA==
X-CSE-MsgGUID: qSPS4Wp9Soyg8zap8+dBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; d="scan'208";a="235241782"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 00:45:06 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 00:45:05 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 19 May 2026 00:45:05 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 19 May 2026 00:45:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kug/pzmi/Yrl6D+NvINORy6UB1wn5sCbjezX/j8TGLefeNacaD2jnKWmM+2j0DF3hOnQ9nI+4LF9nDEzhZ4lJ9wGXdUptYOUqhxD4Ao6ZEQX5S0lO03mCHQOtyYij8iJ+rF7ROQpq5FM9RzBgHh1OzZFUiJgLpcTFiwlUcvZ/kVo7wTXKlibXI4PVSjYzOCVw5lemSWPtF3X6ryvzNrHAUk27kwCx50xDDthzVMx2u8yfsmrycsGyv61EBxxAYxh8xznaVDGCFG7tVjzJ8uxBnELaC97DDrZH+O2A1P8UL6DY+VNoIBVDpD7IAluaJ3ZFsgcfUy5dRCMcKSt/UdyRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVgdsCYsb3+ttGkYiIKTqAFFdGXnHupizauufMvBP/8=;
 b=iQ1wBAxVT13S1fqwM8n9dggox0d0PT5cyhM8qsZmBRjnq22WPtEZe1hcUYYLM+3r/9VfmnL7MxlPFb6ExR5mCuNzIBT61CHccHO2tk/GY+iMR5aWshee7C5SMedT5p5lN/OOi4VPMU7Xq1ygGRHQsd1YcfQBGfDU9qaKP2DuFosqs4Ty3MAOZ1N++Wv3u0DpaT2iu+p8Y6YL06B3bbLmfzAsJw+uKSFoJSQrtgzjT64MtT45fZu7itbZnuJqGdlvxKOhy9ETyRm0Qlurf9xW3kXAbnOD4bsw+S0u9RofaHEFTdoJhaLkeGCd4xJNczXOv0BgNBMz7IzsJx/GftbJFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by SA3PR11MB7414.namprd11.prod.outlook.com (2603:10b6:806:31c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 07:44:57 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%5]) with mapi id 15.20.9913.009; Tue, 19 May 2026
 07:44:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v5 00/15] intel_iommu: Enable PASID support for
 passthrough device
Thread-Topic: [PATCH v5 00/15] intel_iommu: Enable PASID support for
 passthrough device
Thread-Index: AQHc32mKJnemCDyOmEqoib9LVxDYe7YQX8cAgASm+oA=
Date: Tue, 19 May 2026 07:44:57 +0000
Message-ID: <IA3PR11MB913600B78919648276BEF18D92002@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260509040819.1044702-1-zhenzhong.duan@intel.com>
 <83576adbe6c19d562df2633d118173af4295f3b9.camel@bull.com>
In-Reply-To: <83576adbe6c19d562df2633d118173af4295f3b9.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|SA3PR11MB7414:EE_
x-ms-office365-filtering-correlation-id: 22ad1382-bd90-4439-b67b-08deb57a8624
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|38070700021|18002099003|22082099003|56012099003|11063799003|4143699003;
x-microsoft-antispam-message-info: twnINrSUS6dy5T4VUDWIHlYsU/mQWozHvxOzv2gRdpsq2VJPFf0O0c6amVTl0iwrIm0suRpSkuo9ZReVv28wtij6Ii6on6t4MSplbIW+30GVqz2dyy8IEPFWj3SIvjA+pc9gA24Qp7omZQR8EOgFf9GNQbXA0E6oDGvSrGN3KFWcC3Z2AJDoiWYMlFDAxN8/lqdQy9bvnvgsEfYp0CVXfs7dohI7RGLio8R71stTShJVPlOUzh3k9UyFYT0zK+xUerEjfUtGmMCPVp+XXq3AVoWN/6yEBWHXoypPKIkSuD8d09d5ROlfFeo1Ig1/UTaJKxJTcECE/TcmN8DNGIZ3ThMskZ7APKxzQIMQxGlM2n7QWuAQlH74/S+K8si6LU7zjPS6yC7MfnqTB7RnjwVOTwX1QLyAWFjbiEUxD8Uq0g774o9l/HPhfl1CrrH7GusUIzHEqXkT50xTlj4pJiWcjEFXTK20EgBt+aklhJfRM4b5tal4Wpu2jtpm49r6dglSzZUSUjYymuC2EplOKv23Yysb7zwf5w3/8vDyORvy9K/2RV3clewnT7QLmu22CTzZ/jjvHA1P/0YhnSYXNduRiyWliMsT9NQOsG4SOqw2GVNzd9hphI94KEU0o4/wEY4V0U2wc5BojV/D5Zj/1FyU0awbUPQsiKKaAPOp4cTSOcw7nw7dzTgu1V2/Y6vjejC2TR8tj3sRY8MhMsmp58pVSw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW9WcnVDVFZRWkh2TzB1NEJWQys2NTExMGpwc3lRVEptNjR6QzFQbVpaTkZK?=
 =?utf-8?B?eEpFdVdxY1hEaitrYzJES2lOQjN5WnVmZVhtVEVZeVBqNFlTZG12Vmw4a2d6?=
 =?utf-8?B?OXdyUUpIU0JvbkJwb1Jra09zODc3TVZPd2N1WFB2Vk1JcFpQejhVZFJ2bWxJ?=
 =?utf-8?B?akhFdWFQRWlQVUcyOVVqQldCTitobllQNm56cWdjK2kzS3R1RU9ZYWhGd1VK?=
 =?utf-8?B?cFd4cFBUUEZvNWVneHJleU1jWlFwNFhFTWlsNngrczR4ZjZycDQxUUNNa2Ry?=
 =?utf-8?B?dFhBc3ExMEpXYStuV0RBWXlrSmtocnhkUmcvNnlwNTFmWTAwRHp1djFsV1Ir?=
 =?utf-8?B?aUtrS2FpTDQ2c29CMHRRREJBWjRiQUt3M1U0UzV0OXlVbDFGaUV5cW9vY0l4?=
 =?utf-8?B?Tm0wWncvSmdwZ0RsY0l6c1JIM3pNZDgzeTFid3R1bWZjeTZGbWVqMThxcWoz?=
 =?utf-8?B?V095YTZ1WExnN2ZFY0pzdWwxazZnUGNUYm9HNzUrN0NKOHN6U1l0ZXgwaEtI?=
 =?utf-8?B?M3VBZHJ0cGZPWFRteWt5VzNUNWNreGNnbWw1Y3JSalVpZnhUUk5HeWZDaEYx?=
 =?utf-8?B?UTRleThSdWlDV3B2KzVNSkpETEk1RTFMMWhUa2phWkc5N1JiU080M21MK0ta?=
 =?utf-8?B?SGsra2FFYTZ4ZDViWmdxdzBaaFNHNG9VLzVIVFZMeEVMYlY2U3l0VlRUc1ZG?=
 =?utf-8?B?aEplWWt3QUlmSG8rdUU5S2tnU09aaTVsK3VaOUVHNXlBS01WSm5mOEtvMWZh?=
 =?utf-8?B?MUZuS3FkTWZsWUtZY29OWGxiUDRxWG5MNFRDb2lNaE1VKzg1MFVOQlpIRHZC?=
 =?utf-8?B?ZFhWcE1CZWNFMHBZaE1vN1h0bjBPdEQwTmlkRXRITnJzS0IwalBrVVBYTWJ6?=
 =?utf-8?B?RDBLMXFtTksrYXg0TmYxREQ2WGowMFd3UTc5RHFvb3BIVDVFT2RCZDhQRzdo?=
 =?utf-8?B?U1pZdmtwOGkwNFFhdG5NNFVLWTdINjhyYVdxdUUwZFFYekV3NHVuWDJzdEZs?=
 =?utf-8?B?MHVGZUxmTmRUOHlSUkg3TG5heDF3Tytyc0hhZjB1bGxoUWp4Rjlhd0lDZ0ZP?=
 =?utf-8?B?SUlGa2FVdTFQOU1SQTkrZkdLOVJibnRJS3JJaVZyakErQnhHOUZIOVgrd25y?=
 =?utf-8?B?ZXU5dU5yclVXUDJHVm5oc0JaZjVLZUtIcitVczYzZmdKSE5oQ1RJTm9PdjR5?=
 =?utf-8?B?emxNNVRNaVF6WWFPUmNHZ0FwVCtSV01sTWJTTEZwS2ljWkN2LzVlYzF1Mm1w?=
 =?utf-8?B?bVVGL2wra0ZuMVBEVVZXRVI1ZnV1S1N3SVJKMnRZQ3lieWtrSE5xUElNelNy?=
 =?utf-8?B?YUxnQjFodllENnBaaUdrdVp0N3orR0pwVS9CNTlIRDRpWlVMWEh0Q1VhOUVm?=
 =?utf-8?B?b2MwS2U4YXlZSWh0SFJMR3VrbWowWjdjOVk4UTJpVUFYL2tBOXMzMDBXSGRH?=
 =?utf-8?B?ajRrWFpKRVR0eEtKcmRDNFdlK3pmT3BpNWNkclgremhmSWdpZ0pXYTk2aXUv?=
 =?utf-8?B?cERqY2xEb0VKZkErekhzaW83YXR1S0hSQkIzVWVpV0kzUGNLMTNmVjZnNFNa?=
 =?utf-8?B?ZS85aUxuMFZpSWdkaXE4Q2ZoMEpVcTlkYitvT1ZTM2NoUm52eDdoTGVTL1g5?=
 =?utf-8?B?WWdTYnF5SzhTSi9jRnJvSlhXaWNqSHFzQWk4WlRKRnZHZTF3MnJEWStpbmcy?=
 =?utf-8?B?bEZsVnFmeEtOMkttUUxBWVhpbzd1dzVRYmpUa1hVRXBPV29xeEx6OUlhR3Fi?=
 =?utf-8?B?b1ErdGpPNHZqUEpjeE1yVnFkamtXVFRQMSt4WmVqYmxqSGNXV3VJM09kRUUw?=
 =?utf-8?B?aitEL1NZOXZvcldqMDh2eitRZFc3SkpxMjdyOTJyS2xDN2VvRVFmdHN1YjJO?=
 =?utf-8?B?Y1dMeGtpKzBNaWxzazBRNVRFdmd6WFdSQjJJSm80OWRUTkFlbW41NXh6SHI0?=
 =?utf-8?B?WGhYd0NpbE1JUXRKTE5XMXR1cmM5ZG8xcEFMeUVtMjRGMHIzUWJnZXVLdnVQ?=
 =?utf-8?B?c1Nxc0xEREwvbVhhUk1SMkNQMUxud0hibXNhZEVnY1J0WFpPaDkvbGdVeGxn?=
 =?utf-8?B?U1FWRk9DZkR5M09oVUJrZ3VUbVB0WXBxbmxJcmVGTzBvZE01a0RvOE4wcnhw?=
 =?utf-8?B?Y2RwY2g1RHIrSWcyWFJiZXZFWWJrcWM0V0w1QmY1US83clJSZTl6aVdJVjVr?=
 =?utf-8?B?QUpDOHM2ajNNVHM2aVdneWpwR2x2aXM3ZUQ2ZVdoOHArR2xad0Z0aTY1YzR1?=
 =?utf-8?B?VGN1aEdLK0QvVDNQNk1vdm9NeG1uWm9zREpZcElyaUVrME1aWFBLV0tOMnFQ?=
 =?utf-8?B?OVRDRW5YaWtQUVhYNXhzTHc2RkErdFlzSlkvTnBQT05WK00yVU5Wdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ZtvGfGdSNz94NHnJwj4WCUSsj9mB0cZO7vwuDI0LrDFDZ4ymOY6ejZ2aNWyoCvctVXYok2EFRGHazdGRleKd0oHELi/8Vt7VaqtXG6Kt+3eZL+5nvHBueZQslqXkyQzBRzTAVC0IPLcoiN53l0FlX6Q59yZPw5EA1EBY9qY51ImywBtCmN5iVm6GuLOrZ8fPF9GSifPpnGMpWic7yQzZQ9ICMdbFoD6G6JsYFqQ3wPMaYEk29ALztJCMmAWQd/droptbaizd8ozBdt+Bz1rj8wanwAoVmVwDcIZbscFzPRDTWLpXvHBmVIT/zxg71JKvImh8ZgKvxtbgk0rCwl9MXQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22ad1382-bd90-4439-b67b-08deb57a8624
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 07:44:57.4029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ugcb//GZQkV1UFxw5SWnbtU6/H1+b9NqtFgDGqD6zO7yVgYGuY/CzPF7HSKpXSEY1tbfeSyePSosBAfQetwHYMcbnzo28t+CLP/GXLLzlus=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7414
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

R2xhZCB0byBrbm93LCB0aGFua3MgQ2xlbWVudC4gTGV0IG1lIGtub3cgaWYgSSBjYW4gaGF2ZSB5
b3VyIFRlc3RlZC1ieS4NCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2zD
qW1lbnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjUgMDAvMTVdIGludGVsX2lvbW11OiBFbmFibGUgUEFTSUQgc3Vw
cG9ydCBmb3IgcGFzc3Rocm91Z2gNCj5kZXZpY2UNCj4NCj5IaSBaaGVuemhvbmcsDQo+DQo+VGhl
IHNlcmllcyBwYXNzZWQgb3VyIG5vbi1yZWdyZXNzaW9uIHRlc3Qgc3VpdGUgZm9yIGVtdWxhdGVk
IHN2bS4NCj5JIHdpbGwgdHJ5IHRvIHRlc3QgdXBjb21pbmcgdmVyc2lvbnMgYXMgd2VsbC4NCj4N
Cj5jbWQNCj4NCj5PbiBTYXQsIDIwMjYtMDUtMDkgYXQgMDA6MDcgLTA0MDAsIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gTm93IHdlIGFscmVhZHkgc3VwcG9ydCBmaXJzdCBz
dGFnZSB0cmFuc2xhdGlvbiB3aXRoIHBhc3N0aHJvdWdoIGRldmljZQ0KPj4gYmFja2VkIGJ5IG5l
c3RlZCB0cmFuc2xhdGlvbiBpbiBob3N0LCBidXQgb25seSBmb3IgSU9NTVVfTk9fUEFTSUQuDQo+
Pg0KPj4gU3RydWN0dXJlIFZUREFkZHJlc3NTcGFjZSBpbmNsdWRlcyBzb21lIGVsZW1lbnRzIHN1
aXRhYmxlIGZvciBlbXVsYXRlZA0KPj4gZGV2aWNlIGFuZCBwYXNzdGhyb3VnaCBkZXZpY2Ugd2l0
aG91dCBQQVNJRCwgZS5nLiwgYWRkcmVzcyBzcGFjZSwNCj4+IGRpZmZlcmVudCBtZW1vcnkgcmVn
aW9ucywgZXRjLCBpdCBpcyBhbHNvIHByb3RlY3RlZCBieSB2dGQgaW9tbXUgbG9jaywNCj4+IGFs
bCB0aGVzZSBhcmUgdXNlbGVzcyBhbmQgYmVjb21lIGEgYnVyZGVuIGZvciBwYXNzdGhyb3VnaCBk
ZXZpY2Ugd2l0aA0KPj4gUEFTSUQuDQo+Pg0KPj4gV2hlbiB0aGVyZSBhcmUgbG90cyBvZiBQQVNJ
RHMgdXNlZCBpbiBvbmUgZGV2aWNlLCB0aGUgQVMgYW5kIE1ScyBhcmUNCj4+IGFsbCByZWdpc3Rl
cmVkIHRvIG1lbW9yeSBjb3JlIGFuZCBpbXBhY3QgdGhlIHdob2xlIHN5c3RlbSBwZXJmb3JtYW5j
ZS4NCj4+DQo+PiBTbyBpbnN0ZWFkIG9mIHVzaW5nIFZUREFkZHJlc3NTcGFjZSB0byBjYWNoZSBw
YXNpZCBlbnRyeSBmb3IgZWFjaCBwYXNpZA0KPj4gb2YgYSBwYXNzdGhyb3VnaCBkZXZpY2UsIHdl
IGRlZmluZSBhIGxpZ2h0IHdlaWdodCBzdHJ1Y3R1cmUNCj4+IFZUREFjY2VsUEFTSURDYWNoZUVu
dHJ5IHdpdGggb25seSBuZWNlc3NhcnkgZWxlbWVudHMgZm9yIGVhY2ggcGFzaWQuIFdlDQo+PiB3
aWxsIHVzZSB0aGlzIHN0cnVjdCBhcyBhIHBhcmFtZXRlciB0byBjb25kdWN0IGJpbmRpbmcvdW5i
aW5kaW5nIHRvDQo+PiBuZXN0ZWQgaHdwdCwgdG8gcmVjb3JkIHRoZSBjdXJyZW50IGJpbmRlZCBu
ZXN0ZWQgaHdwdCBhbmQgZXZlbiBmdXR1cmUNCj4+IFBSUSBzdXBwb3J0LiBJdCdzIGFsc28gZGVz
aWduZWQgdG8gc3VwcG9ydCBJT01NVV9OT19QQVNJRC4NCj4+DQo+PiBUaGUgcG90ZW50aWFsIGZ1
bGwgZGVmaW5pdGlvbiBvZiBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSBtYXkgbGlrZToNCj4+DQo+
PiDCoCB0eXBlZGVmIHN0cnVjdCBWVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSB7DQo+PiDCoMKgwqDC
oMKgIFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2Q7DQo+PiDCoMKgwqDCoMKgIFZURFBBU0lE
RW50cnkgcGFzaWRfZW50cnk7DQo+PiDCoMKgwqDCoMKgIHVpbnQzMl90IHBhc2lkOw0KPj4gwqDC
oMKgwqDCoCB1aW50MzJfdCBmc19od3B0X2lkOw0KPj4gwqDCoMKgwqDCoCB1aW50MzJfdCBmYXVs
dF9pZDsNCj4+IMKgwqDCoMKgwqAgaW50IGZhdWx0X2ZkOw0KPj4gwqDCoMKgwqDCoCBRTElTVF9I
RUFEKCwgVlREUFJRRW50cnkpIHZ0ZF9wcnFfbGlzdDsNCj4+IMKgwqDCoMKgwqAgSU9NTVVQUklO
b3RpZmllciBwcmlfbm90aWZpZXJfZW50cnk7DQo+PiDCoMKgwqDCoMKgIElPTU1VUFJJTm90aWZp
ZXIgKnByaV9ub3RpZmllcjsNCj4+IMKgwqDCoMKgwqAgUUxJU1RfRU5UUlkoVlREQWNjZWxQQVNJ
RENhY2hlRW50cnkpIG5leHQ7DQo+PiDCoCB9IFZUREFjY2VsUEFTSURDYWNoZUVudHJ5Ow0KPj4N
Cj4+IEJhc2VkIG9uIG5ld2VzdCBtYXN0ZXIgYnJhbmNoLg0KPj4gR0lUIGJyYW5jaDoNCj5baHR0
cHM6Ly9naXRodWIuY29tL3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfcGFz
aWQudjVdKGh0dHBzOi8vZw0KPml0aHViLmNvbS95aWxpdTE3NjUvcWVtdS90cmVlL3poZW56aG9u
Zy9pb21tdWZkX3Bhc2lkLnY1KQ0KPj4NCj4+IFBBVENIMDEtMDg6IFNvbWUgcHJlcGFyaW5nIHdv
cmsNCj4+IFBBVENIMDktMTM6IEhhbmRsZSBQQVNJRCBlbnRyeSBhZGRpdGlvbi9yZW1vdmFsIGFu
ZCBiaW5kL3VuYmluZA0KPj4gUEFUQ0gxNC0xNTogQWRkIFBBU0lEIHJlbGF0ZWQgY2hlY2sgYW5k
IGVuYWJsZSBQQVNJRCBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlDQo+Pg0KPj4gVGVzdHM6DQo+PiBU
ZXN0ZWQgd2l0aCBEU0EgZGV2aWNlIHdoaWNoIGRyaXZlciB1c2VzIDIgUEFTSURzIGJ5IGRlZmF1
bHQuDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVuemhvbmcNCj4+DQo+PiBDaGFuZ2Vsb2c6DQo+PiB2
NToNCj4+IC0gdXNlICV1IGZvciBwYXNpZCBwcmludCAoU2hhbW1lcikNCj4+IC0gcy9hdHRhY2ht
ZW50L2RldGFjaG1lbnQgaW4gQVBJIGRvYyAoU2hhbW1lcikNCj4+IC0gc2F2ZSBpb21tdSBwYXNp
ZCBpbiB2dGRfYXMgdG8gYXZvaWQgdGhlIGNoZWNrIG9mIFBDSSBwYXNpZCB3aGVuZXZlciBwb3Nz
aWJsZQ0KPihDbGVtZW50KQ0KPj4gLSBjb21taXQgbG9nIG1pbm9yIHR3ZWFrIG9uIHBhdGNoMyBh
bmQgcGF0Y2g3IChMaXV5aSkNCj4+IC0gdXNlIG5hbWUgJ3Bhc2lkLWJpdHMnIGZvciBwYXNpZCBw
cm9wZXJ0eSAoTGl1eWkpDQo+Pg0KPj4gdjQ6DQo+PiAtIGltcHJvdmUgZG9jdW1lbnRzIG9mIFZJ
T01NVV9GTEFHcyAoQ8OpZHJpYykNCj4+IC0gYWRkIGEgY2xlYW51cCBwYXRjaCB0byBzaW1wbGlm
eSB0aGUgY2hlY2sgYmV0d2VlbiBQQ0kgcGFzaWQgYW5kIFZURCBwYXNpZA0KPihDbGVtZW50KQ0K
Pj4gLSByZWJhc2UgdG8gbmV3ZXN0IG1hc3RlciBicmFuY2gNCj4+DQo+PiB2MzoNCj4+IC0gZml4
IEBQYXNpZCBwYXJhbWV0ZXIncyBjb21tZW50IChMaXV5aSkNCj4+IC0gaW50cm9kdWNlIGEgd3Jh
cHBlciB2dGRfYWNjZWxfZGVsZXRlX3BjKCkgKExpdXlpKQ0KPj4gLSBkcm9wIHBhdGNoMTIgaW4g
djIgdG8gYXZvaWQgYSByYWNlIGNvbmRpdGlvbiAoQ2xlbWVudCkNCj4+IC0gcy9QQVNJRF8wL0lP
TU1VX05PX1BBU0lEIHMvZ2xvYWwvZ2xvYmFsIHMvYXNfaXQvaGlvZF9pdCAoTGl1eWkpDQo+PiAt
IG1ha2UgdHJhY2VfdnRkX2RldmljZV9hdC9kZXRhY2hfaHdwdCB1c2UgSU9NTVVfTk9fUEFTSUQg
KExpdXlpKQ0KPj4gLSBjaGFuZ2UgX2FjY2VsIHN1YmZpeCBzdHlsZSBuYW1pbmcgdG8gdnRkX2Fj
Y2VsXyBwcmVmaXggc3R5bGUgKExpdXlpKQ0KPj4gLSBkcm9wIHVubmVjZXNzYXJ5IHBhcmFtZXRl
ciB2dGRfaGlvZCogZnJvbSB2dGRfZGVzdHJveV9vbGRfZnNfaHdwdCgpIChMaXV5aSkNCj4+IC0g
aW50cm9kdWNlIGEgbmV3IGZsYWcgVklPTU1VX0ZMQUdfV0FOVF9QQVNJRF9BVFRBQ0ggZm9yIHBh
c2lkIGF0dGFjaA0KPihOaWNvbGluKQ0KPj4NCj4+IHYyOg0KPj4gLSBtb3ZlIHRoZSBjaGVjayAi
cy0+cGFzaWQgPiBQQ0lfRVhUX0NBUF9QQVNJRF9NQVhfV0lEVEgiIHRvIHBhdGNoNQ0KPihDbGVt
ZW50KQ0KPj4gLSBtb3ZlICNpbmNsdWRlICJody9jb3JlL2lvbW11LmgiIGJlZm9yZSAjaW5jbHVk
ZSAiaHcvY29yZS9xZGV2LmgiIChMaXV5aSkNCj4+IC0gcG9saXNoIHRoZSBjb21tZW50IGFib3V0
IEBQYXNpZCBwYXJhbWV0ZXIgKExpdXlpKQ0KPj4gLSBzL3BlL3Bhc2lkX2VudHJ5LCBzL2FzX2l0
L2hpb2RfaXQsIHMvdnRkX2ZpbmRfYWRkX3BjL3Z0ZF9hY2NlbF9maWxsX3BjIChMaXV5aSkNCj4+
IC0gcy9WVERBQ0NFTFBBU0lEQ2FjaGVFbnRyeS9WVERBY2NlbFBBU0lEQ2FjaGVFbnRyeSAoTGl1
eWkpDQo+PiAtIGFkZCBleHBsYW5hdGlvbiBpbiBjb2RlIGFib3V0IFBBU0lEIHJlbW92YWwgYmVm
b3JlIGFkZGl0aW9uIChMaXV5aSkNCj4+IC0gcG9saXNoIHRoZSBjb21tZW50IGFib3V0IHNjb3Bl
IG9mIFZUREFjY2VsUEFTSURDYWNoZUVudHJ5IHZzDQo+VlREUEFTSURDYWNoZUVudHJ5IChMaXV5
aSkNCj4+IC0gYWRkIGFuIG9wdGltaXphdGlvbiB0byBieXBhc3MgUEFTSUQgZW50cnkgYWRkaXRp
b24gZm9yIFBBU0lEIHNlbGVjdGl2ZQ0KPnB2X2ludl9kc2MgKExpdXlpKQ0KPj4NCj4+IHYxOg0K
Pj4gLSB1c2UgbmFtaW5nIHBhdHRlcm4gIlhYWF9TRVRfVEhFTkFNRSIgc2FtZSBhcyBzbW11IChD
bGVtZW50KQ0KPj4gLSBmaXggcy0+cGFzaWQgY2hlY2sgKENsZW1lbnQpDQo+Pg0KPj4gUkZDdjI6
DQo+PiAtIGV4dGVuZCBhdHRhY2gvZGV0YWNoX2h3cHQoKSBpbnN0ZWFkIG9mIGludHJvZHVjaW5n
IG5ldyBjYWxsYmFja3MgKFNoYW1tZXIpDQo+PiAtIERlZmluZSBJT01NVV9OT19QQVNJRCBmb3Ig
ZGV2aWNlIGF0dGFjaG1lbnQgd2l0aG91dCBwYXNpZCAoTmljb2xpbikNCj4+IC0gdXBkYXRlIHZ0
ZF9kZXN0cm95X29sZF9mc19od3B0KCkncyBwYXJhbWV0ZXIgZm9yIG5hbWluZyBjb25zaXN0ZW5j
eQ0KPihDbGVtZW50KQ0KPj4gLSBjaGVjayBwYXNpZCBiaXRzIHNpemUgdG8gYmUgbm8gbW9yZSB0
aGFuIDIwIGJpdHMgKENsZW1lbnQpDQo+PiAtIGluaXRpYWxpemUgbG9jYWwgdmFyaWFibGUgbWF4
X3Bhc2lkX2xvZzIgdG8gMCAoQ8OpZHJpYykNCj4+DQo+Pg0KPj4gWmhlbnpob25nIER1YW4gKDE1
KToNCj4+IMKgIHZmaW8vaW9tbXVmZDogRXh0ZW5kIGF0dGFjaC9kZXRhY2hfaHdwdCBjYWxsYmFj
ayBpbXBsZW1lbnRhdGlvbnMgd2l0aA0KPj4gwqDCoMKgIHBhc2lkDQo+PiDCoCBpb21tdWZkOiBF
eHRlbmQgYXR0YWNoL2RldGFjaF9od3B0IGNhbGxiYWNrcyB0byBzdXBwb3J0IHBhc2lkDQo+PiDC
oCB2ZmlvL2lvbW11ZmQ6IENyZWF0ZSBuZXN0aW5nIHBhcmVudCBod3B0IHdpdGggSU9NTVVfSFdQ
VF9BTExPQ19QQVNJRA0KPj4gwqDCoMKgIGZsYWcNCj4+IMKgIGludGVsX2lvbW11OiBDcmVhdGUg
dGhlIG5lc3RlZCBod3B0IHdpdGggSU9NTVVfSFdQVF9BTExPQ19QQVNJRCBmbGFnDQo+PiDCoCBp
bnRlbF9pb21tdTogUmVuYW1lIHBhc2lkIHByb3BlcnR5IHRvICJwYXNpZC1iaXRzIiBhbmQgZGVm
aW5lIGl0IGFzDQo+PiDCoMKgwqAgdHlwZSB1aW50OA0KPj4gwqAgaW50ZWxfaW9tbXU6IEV4cG9y
dCBzb21lIGZ1bmN0aW9ucw0KPj4gwqAgaW50ZWxfaW9tbXU6IFVzZSBJT01NVV9OT19QQVNJRCBh
bmQgZGVsZXRlIFBBU0lEXzANCj4+IMKgIGludGVsX2lvbW11OiBSZWZhY3RvciBQQVNJRCBwcm9j
ZXNzaW5nIHRvIHVzZSBJT01NVV9OT19QQVNJRA0KPj4gwqDCoMKgIGludGVybmFsbHkNCj4+IMKg
IGludGVsX2lvbW11X2FjY2VsOiBIYW5kbGUgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yIHBjX2lu
dl9kc2MgcmVxdWVzdA0KPj4gwqAgaW50ZWxfaW9tbXVfYWNjZWw6IEhhbmRsZSBQQVNJRCBlbnRy
eSByZW1vdmFsIGZvciBwY19pbnZfZHNjIHJlcXVlc3QNCj4+IMKgIGludGVsX2lvbW11X2FjY2Vs
OiBCeXBhc3MgUEFTSUQgZW50cnkgYWRkaXRpb24gZm9yIGp1c3QgZGVsZXRlZCBlbnRyeQ0KPj4g
wqAgaW50ZWxfaW9tbXVfYWNjZWw6IEhhbmRsZSBQQVNJRCBlbnRyeSByZW1vdmFsIGZvciBzeXN0
ZW0gcmVzZXQNCj4+IMKgIGludGVsX2lvbW11X2FjY2VsOiBTd2l0Y2ggdG8gVlREQWNjZWxQQVNJ
RENhY2hlRW50cnkgZm9yIFBBU0lEDQo+PiDCoMKgwqAgYmluZC91bmJpbmQgYW5kIFBJT1RMQiBp
bnZhbGlkYXRpb24NCj4+IMKgIGludGVsX2lvbW11X2FjY2VsOiBBZGQgcGFzaWQgYml0cyBzaXpl
IGNoZWNrDQo+PiDCoCBpbnRlbF9pb21tdTogRXhwb3NlIGZsYWcgVklPTU1VX0ZMQUdfUEFTSURf
U1VQUE9SVEVEIGFuZA0KPj4gwqDCoMKgIFZJT01NVV9GTEFHX1dBTlRfUEFTSURfQVRUQUNIDQo+
Pg0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11X2FjY2VsLmjCoMKgwqAgfMKgIDIwICstDQo+PiDC
oGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8wqAgNDQgKysrLQ0KPj4gwqBpbmNsdWRl
L2h3L2NvcmUvaW9tbXUuaMKgwqDCoMKgwqDCoMKgIHzCoCAxMyArKw0KPj4gwqBpbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaMKgIHzCoMKgIDQgKy0NCj4+IMKgaW5jbHVkZS9ody92ZmlvL3Zm
aW8tZGV2aWNlLmjCoCB8wqDCoCAxICsNCj4+IMKgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5owqDC
oMKgwqDCoMKgIHzCoCAxOCArLQ0KPj4gwqBpbmNsdWRlL3N5c3RlbS9tZW1vcnkuaMKgwqDCoMKg
wqDCoMKgIHzCoMKgIDIgKy0NCj4+IMKgYmFja2VuZHMvaW9tbXVmZC5jwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoMKgIDkgKy0NCj4+IMKgaHcvYXJtL3NtbXV2My1hY2NlbC5jwqDCoMKgwqDC
oMKgwqDCoMKgIHzCoCAxMiArLQ0KPj4gwqBody9pMzg2L2ludGVsX2lvbW11LmPCoMKgwqDCoMKg
wqDCoMKgwqAgfCAyNTQgKysrKysrKysrLS0tLS0tLS0tLS0NCj4+IMKgaHcvaTM4Ni9pbnRlbF9p
b21tdV9hY2NlbC5jwqDCoMKgIHwgNDE0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LQ0KPj4gwqBody92ZmlvL2RldmljZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MTEgKw0KPj4gwqBody92ZmlvL2lvbW11ZmQuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oCA1NiArKystLQ0KPj4gwqBody92ZmlvL3RyYWNlLWV2ZW50c8KgwqDCoMKgwqDCoMKgwqDCoMKg
IHzCoMKgIDQgKy0NCj4+IMKgMTQgZmlsZXMgY2hhbmdlZCwgNjA3IGluc2VydGlvbnMoKyksIDI1
NSBkZWxldGlvbnMoLSkNCj4+DQo=

