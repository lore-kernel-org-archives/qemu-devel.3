Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA45C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 14:33:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTjEV-00024T-BK; Tue, 16 Jul 2024 10:32:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTjET-00023B-FH
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:32:45 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1sTjER-0000nY-Do
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 10:32:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1721140364; x=1752676364;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EqIbr9rF6IXTyd9G8p7c/skRQqVDHafgfBCDRaX9yHo=;
 b=HWByL4LIq/G5vJcmVhRWBaPCuZ0tOsq4tUc4i6lh0g3JI+1cvsYX7x1i
 hyjqM+7P/ESIuSoT5mYB8oEraaFFuPn70AUWDcsEuJecHtlx0F+zM/M/Y
 CggxUijgjwypsHb4437/Z7SlVQnja1qpacnS9Rd25uECAZuAkG/Mk/s51
 MOZ+JSZO9xvRShGuPoaJUk+OG5K2ioFMUpLKi9WbwKLFasnc0UYP82X6I
 lyvRBT8R94VW+4OfOV3kCSKJimtu7Xg/B/v3tuwj6IpdmSH4sfCYLffMi
 c/zgb1NSWmyY1PssmopKVlbvekz1ik7j3smOvjgYcUAOanV3NSEUYZK9b Q==;
X-CSE-ConnectionGUID: r4yE6DS9ThGBrjyCsc6p5w==
X-CSE-MsgGUID: sr9oitb+S0OglehGfmidbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11135"; a="29968532"
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="29968532"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 07:32:40 -0700
X-CSE-ConnectionGUID: bCPYgRGvRgam2HggKQgbUg==
X-CSE-MsgGUID: +EMGvl35RS+tSVSp7z8Viw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,211,1716274800"; d="scan'208";a="54880997"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 16 Jul 2024 07:32:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 07:32:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 16 Jul 2024 07:32:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 16 Jul 2024 07:32:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 16 Jul 2024 07:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6ymT99T0zywDsE7IDIXALRK7QS6kh0yt65ZYX/huwVVN5zjE7sJAjTv1TkRIxpxlO9x3WYTL2xRwh3mFth9ABNHXiaQ1rgfUOv2LulnM1AidZaPiFGi6aY2pArgq/VBeHnrDfHs0uHWmoNULY18sRMfkijBT9g8J4MWWByguP93woHeFbW0DY/DMeKb54/yU9MxAy0JV9eRV4r4mJoHlhEDSxqD3fCRa6BSdRu9BJRIGzxQu4Zn6YMp0sfRERx82TX55XmvDrPPlniQfsaSzrW6R8MmSOzMU1uKIgAKPlyqGhMHYGH170CMtTNp0J0bFLBpSAnLzN7AAe1ONZ6N0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72MQIIBLpGQkQkwG0dPRu1I2ok4KZNU1EaWq2jSKBXA=;
 b=LVgrCK38UrzQPqF/nJMxZsCNnLL1wCXDB2Bw0Fv//pOFAbAfP9a3H3VWYn07fUq1gr7POqsaWsmLyJ9/lE+bKguV2NLOF+e8TMdR7S/2NWiKR5QQGMBdF9CvDhnfvcUc4tACs5S2ErB/35xck7M94tKeqHG9lgupVWnaCEIfIHnkiXwFWHw0JD4ZPVDQX3ls2mVOIXEe3wtYTGLas9DrvLLoSLjeIPxiW1yp1gfSfm7hMoQawNHPVw+NmH2DBouElpk3SdoCpk9HUB1bJ8cRXyllz1QyvTpVi+5vTkpmm1QWrh6rMt+c6JkV+QnpjBpfiGLgNZArAosLjMd37MtXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS7PR11MB7905.namprd11.prod.outlook.com (2603:10b6:8:ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:32:24 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::2750:7e63:952:7f1d%6]) with mapi id 15.20.7784.013; Tue, 16 Jul 2024
 14:32:24 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "Wang, Yichen" <yichen.wang@bytedance.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>, "Eduardo
 Habkost" <eduardo@habkost.net>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Hao Xiang <hao.xiang@linux.dev>, "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>, "Wang, Yichen"
 <yichen.wang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>
Subject: RE: [PATCH v6 5/5] tests/migration: Add integration test for 'qatzip'
 compression method
Thread-Topic: [PATCH v6 5/5] tests/migration: Add integration test for
 'qatzip' compression method
Thread-Index: AQHa1wQ716UPdV+ER0eBcdpVi36bxbH5a2RQ
Date: Tue, 16 Jul 2024 14:32:24 +0000
Message-ID: <PH7PR11MB59412987AF193254AC16EB0CA3A22@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240715221245.12435-1-yichen.wang@bytedance.com>
 <20240715221245.12435-6-yichen.wang@bytedance.com>
In-Reply-To: <20240715221245.12435-6-yichen.wang@bytedance.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS7PR11MB7905:EE_
x-ms-office365-filtering-correlation-id: 72c8125f-8e26-43cf-85a1-08dca5a41c24
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700018|921020; 
x-microsoft-antispam-message-info: =?iso-8859-1?Q?xFWaZ+0k8cPqaj7mAiVPrEFgnOfZElKv3y6Ner71Rt7Mnspw8EbMXJsUkd?=
 =?iso-8859-1?Q?facEc2cvCVUn9Bj7BNRh2YF6FydqvBjNOZxXGRX4VHfia/erV68GzPfDqT?=
 =?iso-8859-1?Q?nMx0LwswhOlkcOoq8R+mGlmPFXAd03O/kRnhGaGKCZ4sufE/qQC5kos+qy?=
 =?iso-8859-1?Q?4TIlSt8gW3XOPDgtlWW4m+vhZoeBU4S8m2C6HWydYrUPf1ajiLAO2Yrr1B?=
 =?iso-8859-1?Q?RkWV3y2G5xc7ZFuASLxd4J5KaSx20Pva4a2+IdKnE9tIgWvoyjbpy8Yp0y?=
 =?iso-8859-1?Q?bLLTC91egiZHBSeZ660VmWEmN1Q2ZEnKDpoCKm+vwEk2BSlgtD9kk4hiJQ?=
 =?iso-8859-1?Q?Yfhd6GG95m178XxADokErYNK3imDgTGs//m7EVB/2hm0j3gbZukNPGh/vG?=
 =?iso-8859-1?Q?1Hr6aNnQkOSI8WUBQNjmVOswgsxq5qWcA1vTeZMFpCm9zXfD6B1rLVjgAX?=
 =?iso-8859-1?Q?YhV2ZWcHE0gktw2NheDJEisimDnJ9YDvABSW25W33xFKODcaq842bSpMOc?=
 =?iso-8859-1?Q?Dv4aTi5d1UzmXSiFImQdvKfD29FQ847QZld3euj7E9X9tB3CuD7pmYVrb9?=
 =?iso-8859-1?Q?LoO+/UWUfEnkxmDCbQYuVLuz5NSMj4sh+OlHyH+yEDuRMEZbjE1NYMp+dI?=
 =?iso-8859-1?Q?vrvS8qup8/QD+KGucnTIxG9he93ziZX2i7+4nt6Rn5PY6UVt0xN6BlNBsr?=
 =?iso-8859-1?Q?zPdOcJtBgpQgfKocw+l7NB1FXJ89RU86AaquAYKbF4gM6c3udiGgdbvYxf?=
 =?iso-8859-1?Q?ypkF7iFFnQWUGOSU5YaJj5gMp4Pu1q7njFLMF/Al4r4Q0UCO6a6Qa2SG9+?=
 =?iso-8859-1?Q?w/K26bD0h1QIThLqDLLFnlswwar0kkQ2MlEoi3639EOnTnYPDj/YunTdQZ?=
 =?iso-8859-1?Q?Z1ZOx1GTDaSH/+YiXJUKqTRrLFXhrYzlpaB5X1fGTMi21UE8tnImMkKzTw?=
 =?iso-8859-1?Q?3CaU+JRHortdZKuuTQIOCXSo4Yg3y4pPkvA0w7togMr9uRqbwgo/QdPGzU?=
 =?iso-8859-1?Q?blm3YdqVg502EDTAaAsDWVDv6aEjGfgvf/GHzoYTEixzzV2wUb2wwSw+8q?=
 =?iso-8859-1?Q?2YXO2sHzCsAQep3Z9+qb/2hWYzGcoF4qgHECNI1VXNbcYeZ/Qv8kENvXNZ?=
 =?iso-8859-1?Q?KmPFJ7MEQmzBjVM0hmTKknuzG38vz8gp6KWCWXMP8i4ddGLuFxO5brWTJr?=
 =?iso-8859-1?Q?9KavZ6k914l/YFwGbnKFbQy5v8+A+y2ULXL+qecg613ZbGVXfdhlKnjuhd?=
 =?iso-8859-1?Q?+SqNPbQ71/TQIE2qQh2aG7piFhDMWdRdwPTZhfYTzHWFITOrYTMK809LIs?=
 =?iso-8859-1?Q?AH0lLNCQuKs9W2MnIM74Fa5y3CdyU+hLkyvQIaT1qBk1OGq5PwXySsAbO3?=
 =?iso-8859-1?Q?ifyhgPQMpO33izVkYQ6OIdi+vMOVXSYYO0UeQePWpciH8U//EX1DWP3DEu?=
 =?iso-8859-1?Q?nC9hDwDYGivufF1dOp9kVtXXdEgEH76GkRbv50qcBbPOoiitY+d7VJ0t0n?=
 =?iso-8859-1?Q?A=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NdFqO6dzBwmKdQXxxc4fc6QG2rsu5jJZVYcYJsPM2+spUlBBQGpQRh0ZnD?=
 =?iso-8859-1?Q?Qhyog5XVtn/zpoNP1CU6ZIXDvtoW3Vsfmn8iXNwXb8a5w/wVmPPkw+EwtR?=
 =?iso-8859-1?Q?nmWg0CGtNmnLkAlk0B0WbtAmvlGfi9OWSt3frWmQEn9mQQQkk2Dy+NP+0Y?=
 =?iso-8859-1?Q?dhgomi0zBHEnyjC8SR9JCIMACWhQbMjBqOb9TIw5NKkulax4K5eOpcv8D/?=
 =?iso-8859-1?Q?8gxVpvzLQOOfxDcBNW9vmK0qGxUOAAmj4gwRFOD/B/coSvfzB1jUJRfOFC?=
 =?iso-8859-1?Q?jBfG7ZtWwrn2qdehdgVzQROb2PE6ZWvQ+S8CeUpqman9/bFiFd3mtq+FqV?=
 =?iso-8859-1?Q?UW7WJAqPfC/qW7V5xzW0iQ7Vto5bqbMM7tGpXYM8pz/vKV3+kWlCj91MRA?=
 =?iso-8859-1?Q?6nsNwo2d5D+I5pUf9fNyDib1P6gPAsYcOjaBVY5HDYrwxQGMDv+mvL+Fk4?=
 =?iso-8859-1?Q?W71W86eJk8W9fbaG6ICcb8sG2LKDHgR+kllU1p6L/T/leJP+HYhbeamWmZ?=
 =?iso-8859-1?Q?ZmiU/c8FOVeCxFF1pAI/iD6wEHP96Lp/lrHhLHndn6QAPoO89Qyzr4wK/8?=
 =?iso-8859-1?Q?wnAmxDDykRuzu/v/LKr7WKs8c7UP3g8SdBfZX+6SC/mQu6j8B9n9VVUEm0?=
 =?iso-8859-1?Q?LlbZPjau/vC8x1K1EGmc1BvvbWd5p1d3tsSQe6ZKxU7OEKy91W7vojly1S?=
 =?iso-8859-1?Q?W2LhUttdMJSwjDnjvEkJypeqhCJBnIULffSYWfPtKfQAPd3T0vS27gX/jJ?=
 =?iso-8859-1?Q?ZAGz5B51T4A6UcDoUZBXd+sqL98RjMMdF3niiVMLGeAQ8QhBpOmeVm7NEh?=
 =?iso-8859-1?Q?ju73CS7vmO8Z8u07Gzp13Vxk0DusNEof/2g+zMCirNDcI8/CIq50fHT2fk?=
 =?iso-8859-1?Q?wD54KLD1gGXJ1kbFq/Uz8DfEZYU4F0P0GnsjdemWZh7un3WPIc1nKnK8N+?=
 =?iso-8859-1?Q?5AGGtCUJVpbfHBtjIR3O0gFmmAj/qagwCv1d4rCnzz2W3wcXG7DI4z5IWE?=
 =?iso-8859-1?Q?tG1Km9usN6Cjq8ikGx5WYx/QdNBqtuQssSFiEtJmkZe1fX0EznuP+Kmz0g?=
 =?iso-8859-1?Q?J7UERANlio4Pd4BkzbygjTIMl1VVeSmZcQ/2UWDp8H3Ozr2+ondgbXVQE4?=
 =?iso-8859-1?Q?5a+NRY+YpIxcwhmfuh27uRCgsiCNQ54OXCdr0+nQWSZjHOgBRaA9t6dGnb?=
 =?iso-8859-1?Q?MuD4n0/jBmO2pwpGss1HAeaANak8XpkURD11hIrarJB364aoUO4smj2ewj?=
 =?iso-8859-1?Q?i7S9WEeT6AD16ns/myYzHPFxGqSPPx5lbcenIuWlyucieYIwE+SQHNJSaj?=
 =?iso-8859-1?Q?mU76dxYOK4V9VW/aadTOz0Q0YN+EpuMPEgJQmYPdd8pWA4z6MZuXi/JTWR?=
 =?iso-8859-1?Q?952/uPd4uiPX6cYMHwnjfOg+M9YfojH8c0Pv76NqDZoF+v3Gea6IXPMuZ/?=
 =?iso-8859-1?Q?pQtM6lcqeTbyxkB9KciRsfF9nrP9NO8UFtdJdmrXLoGU0lFcCnBjpAI7Fy?=
 =?iso-8859-1?Q?QkQOoMOtuQ3slA21yt/oAq/mCBjIS9cdMV2CwplV5YmZfNxqrIAfH3DcOz?=
 =?iso-8859-1?Q?9YL0NA2byCkJ/qya42wCDTyPcSiNO9ppAWxyYUb/bu6AoN2xkBSA8Agw/1?=
 =?iso-8859-1?Q?q3GCWWkDUXRQxlb+PLipNapQApF+jfJIGU?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c8125f-8e26-43cf-85a1-08dca5a41c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2024 14:32:24.4553 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 73IyJ2+wR6PThcARl2LfR6YkPAtAtIBZyS8ta3+DilHv7eacFgCDYP/CvFJWGW8Gxd9kbdDlxBO8G1wyOK6d2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7905
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

> -----Original Message-----
> From: Yichen Wang <yichen.wang@bytedance.com>
> Sent: Tuesday, July 16, 2024 6:13 AM
> To: Peter Xu <peterx@redhat.com>; Fabiano Rosas <farosas@suse.de>; Paolo
> Bonzini <pbonzini@redhat.com>; Daniel P. Berrang=E9 <berrange@redhat.com>=
;
> Eduardo Habkost <eduardo@habkost.net>; Marc-Andr=E9 Lureau
> <marcandre.lureau@redhat.com>; Thomas Huth <thuth@redhat.com>; Philippe
> Mathieu-Daud=E9 <philmd@linaro.org>; Eric Blake <eblake@redhat.com>; Mark=
us
> Armbruster <armbru@redhat.com>; Laurent Vivier <lvivier@redhat.com>; qemu=
-
> devel@nongnu.org
> Cc: Hao Xiang <hao.xiang@linux.dev>; Liu, Yuan1 <yuan1.liu@intel.com>;
> Zou, Nanhai <nanhai.zou@intel.com>; Ho-Ren (Jack) Chuang
> <horenchuang@bytedance.com>; Wang, Yichen <yichen.wang@bytedance.com>;
> Bryan Zhang <bryan.zhang@bytedance.com>
> Subject: [PATCH v6 5/5] tests/migration: Add integration test for 'qatzip=
'
> compression method
>=20
> From: Bryan Zhang <bryan.zhang@bytedance.com>
>=20
> Adds an integration test for 'qatzip'.
>=20
> Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
> Signed-off-by: Hao Xiang <hao.xiang@linux.dev>
> Signed-off-by: Yichen Wang <yichen.wang@bytedance.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/migration-test.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test.c
> index 70b606b888..98f60d58a7 100644
> --- a/tests/qtest/migration-test.c
> +++ b/tests/qtest/migration-test.c
> @@ -32,6 +32,10 @@
>  # endif /* CONFIG_TASN1 */
>  #endif /* CONFIG_GNUTLS */
>=20
> +#ifdef CONFIG_QATZIP
> +#include <qatzip.h>
> +#endif /* CONFIG_QATZIP */

It looks like <qatzip.h> file is not needed, maybe
it can be removed.

>  /* For dirty ring test; so far only x86_64 is supported */
>  #if defined(__linux__) && defined(HOST_X86_64)
>  #include "linux/kvm.h"
> @@ -2992,6 +2996,18 @@
> test_migrate_precopy_tcp_multifd_zstd_start(QTestState *from,
>  }
>  #endif /* CONFIG_ZSTD */
>=20
> +#ifdef CONFIG_QATZIP
> +static void *
> +test_migrate_precopy_tcp_multifd_qatzip_start(QTestState *from,
> +                                              QTestState *to)
> +{
> +    migrate_set_parameter_int(from, "multifd-qatzip-level", 2);
> +    migrate_set_parameter_int(to, "multifd-qatzip-level", 2);
> +
> +    return test_migrate_precopy_tcp_multifd_start_common(from, to,
> "qatzip");
> +}
> +#endif
> +
>  #ifdef CONFIG_QPL
>  static void *
>  test_migrate_precopy_tcp_multifd_qpl_start(QTestState *from,
> @@ -3089,6 +3105,17 @@ static void test_multifd_tcp_zstd(void)
>  }
>  #endif
>=20
> +#ifdef CONFIG_QATZIP
> +static void test_multifd_tcp_qatzip(void)
> +{
> +    MigrateCommon args =3D {
> +        .listen_uri =3D "defer",
> +        .start_hook =3D test_migrate_precopy_tcp_multifd_qatzip_start,
> +    };
> +    test_precopy_common(&args);
> +}
> +#endif
> +
>  #ifdef CONFIG_QPL
>  static void test_multifd_tcp_qpl(void)
>  {
> @@ -3992,6 +4019,10 @@ int main(int argc, char **argv)
>      migration_test_add("/migration/multifd/tcp/plain/zstd",
>                         test_multifd_tcp_zstd);
>  #endif
> +#ifdef CONFIG_QATZIP
> +    migration_test_add("/migration/multifd/tcp/plain/qatzip",
> +                test_multifd_tcp_qatzip);
> +#endif
>  #ifdef CONFIG_QPL
>      migration_test_add("/migration/multifd/tcp/plain/qpl",
>                         test_multifd_tcp_qpl);
> --
> Yichen Wang


