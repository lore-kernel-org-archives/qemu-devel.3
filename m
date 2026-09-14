Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27396C88E6A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:20:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x62rq-0002cn-H9; Mon, 14 Sep 2026 05:20:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x62ri-0002aY-NM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:20:45 -0400
Received: from mgamail.intel.com ([198.175.65.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1x62rg-0006og-9v
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 05:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789377641; x=1820913641;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+y6M/KRyyfTXquvqnKbVs0+WbNpKX8t1J/aIh+SIl4E=;
 b=YaNI8FQtwQEMRyjAqQiod8k+yrqfXrRu1WFJnFDnrNbfCCnQTHGq7H9Y
 pHeBrrq24sOjlf4ic+N1dYTdxismcpu4zvFAP7qpQaZO1tMC+r2lBelVp
 6Htek7S7NSfn55tlrzOLl65I3MFONVBJvG1XRNX/aYrITaJoJ+0AKP2JK
 VAqIjxgPllwwsacei9H3tk6oXc0rougeUpxm4kApenPJ0G5NrWu5qfVEw
 i9at/RwTTF4fhF4l6BVsokQGgpPt8A4d+b3x2pTfHJBkNRStzqoIxIDLr
 peLboX6OeqUCi7mxMvTZZX4fceK5TrgQ4A0ow8OQxKFN+WR+TNjnGIK3+ g==;
X-CSE-ConnectionGUID: 23u3+kOiSF+YeHQHZ9KexA==
X-CSE-MsgGUID: rH7qgndVTNGGYUB6mm4muw==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="89769439"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="89769439"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:20:36 -0700
X-CSE-ConnectionGUID: 3ViBB3CSTlujaH5k0rJ5Cg==
X-CSE-MsgGUID: pKN5rot/SNSGRQU1W5xyRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; d="scan'208";a="269311175"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Sep 2026 02:20:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:20:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 14 Sep 2026 02:20:35 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 02:20:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ie1+noLrtb/7rANmlbSHiHVg6DN2pNwrzl4sRZD5wEsCBvuYRcgZwLnkhY9JoB8LsDeb9ixY0gc6suD+8eWQahy0J2m3+/j8mt7nJbxc+sXAMHcLeBD9WFoE39446EmTabeEmkO1JSu25QKn6cGYVZ5+fJGQN7i+K1Vlffd8yVRUS2mzRjC7sOqE2NLwXM2Dpeqjr1VGPgcMBGdv4IZL+hqQWeobrGDwgnRBKp3mKw7x9b7HInba4zd+N1dVhs9rPOKLOCHA3iaHipbleGpf8JpG1BimfvQT5A887dlIRyT5LOCc/PzmTBOmFJ/PTT01E/fzLFYLjbAkQ8/6Gk3Pag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+y6M/KRyyfTXquvqnKbVs0+WbNpKX8t1J/aIh+SIl4E=;
 b=Enj+kDulYaGLul9e3UgzjazU2E+XFwow8sIhb+C3OFAnFY6ZofMIDxK+ZZAujcZJMCvDrVsGEfEkLwf8MYZxoofw/0/VJy95IvNpDwtO/l2O/uZtwg8jfZNEbuqs2VlHAo8LaqIGtfKetIclLx2arL6AomIG5WTIUyyINHnKXtW8Vne96tlxxejYb74RJL+DHPFTjT2JGlXEQVXkHF99gguoKQfFPyZd5dyAxO+khIrOyRHTqqJKqA2eMrsEn09hirw72tpQqyj5iQ/3fxF5g8d6ZpRvJ71q6PqyPbYkM0KLQ1JEP4Ss+VIzgN2VOyuo/eHc8kWQOqqtCvFee1QSkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::3c) by SJ0PR11MB5056.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 09:20:31 +0000
Received: from DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119]) by DS4PPF93A1BBECD.namprd11.prod.outlook.com
 ([fe80::aaad:f003:86ec:c119%5]) with mapi id 15.21.0382.014; Mon, 14 Sep 2026
 09:20:30 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Hao, Xudong"
 <xudong.hao@intel.com>
Subject: RE: [PATCH v6 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Topic: [PATCH v6 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
Thread-Index: AQHdQCzvjDHWOjG3UUq00Zx4uDEfa7bNu0wAgAAYWaA=
Date: Mon, 14 Sep 2026 09:20:30 +0000
Message-ID: <DS4PPF93A1BBECD0DD3FC8E099B2D1C6DAE92BB2@DS4PPF93A1BBECD.namprd11.prod.outlook.com>
References: <20260909072837.3183154-1-zhenzhong.duan@intel.com>
 <20260909072837.3183154-5-zhenzhong.duan@intel.com>
 <624a43c0c08f2d01979bff36fa9ce9ede77dd8b2.camel@bull.com>
In-Reply-To: <624a43c0c08f2d01979bff36fa9ce9ede77dd8b2.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPF93A1BBECD:EE_|SJ0PR11MB5056:EE_
x-ms-office365-filtering-correlation-id: 104521d4-0382-42dc-0f25-08df12416c46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|366016|38070700021|6133799003|56012099006|11063799006|4143699003|22082099003|18002099003|10067099003;
x-microsoft-antispam-message-info: d6t54Snb6SQsVp9wBHMg/5StpIr6HzM1/QCFXrKsB8mw+IPXGMZpDjp9BhA81uX0loqQrn9MWIjLjR0TB+SiQ1aVYEbtTG77vphADbTpVQZBPS97d122kPNQutFhHcHzZrMGhGuSkd4dbo/NUgtaE8Yh78yo+r50eTWjCswotntkeBmpqDDZ4/NkE6VyE9gsO3WgNj2MuwrcHwWQnVQE9ma1B2psN5OirtZE8sMR13EfwXdc7/Qod45fxUbKybymSwx4yq2IXkVD85LfISkDdswUQf0ou2g6QIB5jr4iqGf2GzyE/zgCljzvzUDR9ORdbbDY/EBddwEfRnCpy7/kEGtrPhwySGDWg/Eyy/WhiRpHjalzz56Xca8Rgt0W2YtwDx5NUULWZOOZ5zZY2hTM1pyBJdwBxkElOip7udjkWZK2+4aKLDrdW3YROIyFj54AOt/bf4nELwNy7KiWnPHJ1k7ceoRH3t500OrcxuY5H0no3vm03cCPj39TK9cu+FU/qPwi8bJeGzGxhe3hRXMT4B0u38JCunT1xSQst7v5Ri4Bu1h9MZILwk9Fob0dSLjz6Ae9QFx4F2sEywip02sjiJ1X2RihzjMWwumh9O8VkgaZfH4zmJ+IZRQRngexxiKw4/k4gVymZQLJVCUk34TJ3jJin8TdqrgyXFAEUYAo6DNxl+zj8oMcGTHDyfj5hS/X1KSe/uc1tvo+I8xV6exG2F59PNwl108i5c6UzToF/QM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPF93A1BBECD.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(6133799003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXR3S0liVVhqWFlsZzZDK0ovR2xpb0xHc1NKQTdUZDZaK2M4T1RTanExZzdr?=
 =?utf-8?B?a3N5aWNSbjBBejJ3Qm9STE9kNGp4UWxMSmJOQTdteC84S1dWeE5lcGhSZEZn?=
 =?utf-8?B?K0VrUW9teTh1OE5FWEh0MEZFYUU1YmZBMHZFSURTTUZzSUdLa09SS1drcmZv?=
 =?utf-8?B?RGxFMVFkNEVsd3hmazBRQzNJNUVhTCswZGRUak5kVWpmS3Q4Tm96ZlljQ1VN?=
 =?utf-8?B?RXp4aHRoM01kSXgrZTk2L3gyTlRrNTJJd1d4RGNCVTg0UXpXdlVFQlRPRGRY?=
 =?utf-8?B?R0JZOWRMK2lrTTBwR2FBZGFKYlcvTCt2LzNkWTlPaktybXBvY29UbkF5eGZW?=
 =?utf-8?B?QzQzaHFxTTdRUWRrZ29aazNHYVMwTHFENW8rcmdUT2pwRFhBeVY5Uko1b0Ji?=
 =?utf-8?B?MDVmdXhycnBITDNSYnh1RFlXemw2TjBBZUFYTlRsTE1HVWpZMkYzbDNwS3h1?=
 =?utf-8?B?Y1NaVzFvMldjVDFWMmdBS092TWcwdVo2RkZLdThtMW9sRjFzMkRYVjU5NDJa?=
 =?utf-8?B?V2Nzak1rWGZ4cXJ1emtVWWNSLzNVakxCc3ZsR2R0bEhRTDlmbjJncmR6SXBG?=
 =?utf-8?B?QS82bnliRDI1OHRoT0Q0OFphUWh5OVFDSjFOUFZOZElzVHhNTUsxV3RBMjZB?=
 =?utf-8?B?NU5tSy92THJKNnhmSlVhM21DOG9MVmJBbHlPd3lXVXZGaUhlY3UwcHRJNVlt?=
 =?utf-8?B?WmpNYVpsMVlrWG1zR3IwZXpSVEZJNFBBbXJZOUpXOGU3L1lXaWd2QXNkaDFx?=
 =?utf-8?B?d2NLZitKcVgwMzdIZTVJalpHbENmbWw5d3ZpSGlXZURSWmNRK1JUSUZES29U?=
 =?utf-8?B?UlptSzhXUXpCZy9PR1pXSEw4MW1XVW9NcnZMQzNvbElYbGJ5d0g0dnUvZXhZ?=
 =?utf-8?B?UG1wN282SG9oeWlJZWxWSi9uSDM3c09jRmdmcmR0L1dZV3hIcVZSOU9uZ1ZR?=
 =?utf-8?B?Kzlxb1NkaFVoL09sRFBwUi9lN0xrVlZ4OVhUc0R3L3RLa3N4SVBhaC9lSEV2?=
 =?utf-8?B?c0FIN3l0Sy9VMUNPR0w0QmN5WmdiTTc2aXNaL1JSL3IzTUtCZ2RYaDlURUFM?=
 =?utf-8?B?NzNFNzZVMHE0K2VodkpKaUZpNXlnQlBsVTFzTkpKcE9Da3Nra1VoS3luMTJO?=
 =?utf-8?B?ZGtEZkRUZldsNG5CSUtDdEEyY3QzQ3I1MlgrVGdNSnZqZHl5SExvanZ5TUd5?=
 =?utf-8?B?c3NObnRCVXpFbUhmVUF5WlNMcy9xWnJ5YnZpR1NFYjdGcXJOaVhPZFVLMFBQ?=
 =?utf-8?B?dzFLbmh1cTZ5bUVnVUZIQ3EzZG1lT3JDa1hOWERIZHczbmRrSnphM2JibU5w?=
 =?utf-8?B?RVlyVWpSNlB3aWJockQwSU9EMmpjcW1qN2phMUJDRVVDRjV3NEs0TWV0a0Iz?=
 =?utf-8?B?eE1xY1JTRXgwREh4R01FMkpHcTNORm5DQ3BFTXlhL093Q3pBRGtjV2dVWU9K?=
 =?utf-8?B?RzJ0UTc1d3dGSWIyM1pub3pIK0lFeFNLTGMza1VUbld5S0tqdlpJa2Y1K2lJ?=
 =?utf-8?B?RmlmM0krUG5IUnZTdVFyMGlVc2ovckd4dm9XdzNKQkRKNDJJMXY3cUt6NitV?=
 =?utf-8?B?OEdRSko3UVR1czdKNVVId3ltbTF6UWFNdzVJaS9PMDQ5TzBQREVQVTdObUdQ?=
 =?utf-8?B?QytTMU85SDFaNHdNMXRSWEpIejBKM2tKRXBMK2JBLzR2ZnZnVU5vTDZRSmRk?=
 =?utf-8?B?aGdIaWptVnRWbEVPMWp3OVZnT3Z2MkQ4TFhiT3FhU0k1U2JPMkFLRTJLMXRZ?=
 =?utf-8?B?Znl5cjhleWkvQ24wZnVNZ01VS2NkU3dvTzlvUit4L3RUOXRubm5CNXhJQVZv?=
 =?utf-8?B?ZGxTR0lCcFpVQVZlYzdpSmhFaWRUWU5zaHpMZXRQbGxBMktIYkVnaHQxZVN3?=
 =?utf-8?B?WUJsNVhaWDNDVHFxMlBMaThBR0xTbUN3b0JoR3JITDBGSnZhbXNaLzJOYUEx?=
 =?utf-8?B?S2RHUFZlNVBOLzN6bXl6TjgvY0hleHBYemtjSjV3dFpBN0F6VTJLd3FhSENn?=
 =?utf-8?B?eFJFWGt5ZEdETEl1bkZrYVhBcXBpQm0vNFdPQisxeC91QjJZWDlleFExbE5F?=
 =?utf-8?B?Mlk2OVF4bGdaa0N0UGlvVXQ1NU9VcWF3ZWJIOHRUK1VjMVQzUFBDeW1OQXhH?=
 =?utf-8?B?dVU2TE9SZlo3ZmtEbTJ2bjhpU1REOVVmVU04RkhLZW5GUHN0R2xlZWpPV0ZX?=
 =?utf-8?B?VWNGK1QzeUFnVm5ja3JLYWpER0pPaXJ0czJQUGp1WmJKd3J0a3MzR2FkeVcv?=
 =?utf-8?B?dGlvS09Ya2pTN0I1UnJMT05NOXo5Z0NBWXl2b1ZNMytIZEV3MlMrdjE3R1RP?=
 =?utf-8?B?VnZxQnlNNkVYUzErMkt4bXRSWkpXVXJtdWVnZ0Jhckw5WEJheERVQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 4xmlrRRLBC3O0d4SO/Nk1htB+UTdVX2prU+6yC0TMxjOoDjRNPfFDoMxma/00PYB+XGyrOy1ja30z+Y+SgYrk3UwHZWuPPZuM/jmAoILEugaUnxWJPKt7MJhghmK6c+YGD5PpnZz8wxrFmqHyL8wT4rumqJGMaFS3uwePdQ5oMOmcs3AWsO6M16o8pqEwbnKr/YdqjmhuZmUsFj9AwEQhxzMdnvBCOH6pZWXp79JT6S9J+5+i4HhJUGfo6o5rQ4zo6lE7V9O4PneoozfNmb4oorhTVpClbe3/J4TGUBGrJpb276ptnAGKouyzhwo4t5qg7bI7mT+5g+v+JXY8xSl/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF93A1BBECD.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104521d4-0382-42dc-0f25-08df12416c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2026 09:20:30.7919 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1se3nV4Vce3UE786lLGdVKG3HKu1eJvmaV1GdKEq6litOrdN/GYwA+3RGU8IfvHNgX7GvO7zQL2EuPv9Bl29AF3W18PMNNQHdiGtXBOek5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.18;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IENsw6ltZW50IE1BVEhJRVUt
LURSSUYgPGNsZW1lbnQubWF0aGlldS0tZHJpZkBidWxsLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BB
VENIIHY2IDQvNl0gaW50ZWxfaW9tbXVfYWNjZWw6IEFkZCBQUlEgaW5qZWN0aW9uIGZvciBwYXNz
dGhyb3VnaA0KPmRldmljZQ0KLi4uDQoNCj4+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfYWNj
ZWwuYw0KPj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9hY2NlbC5jDQo+PiBAQCAtOSw2ICs5
LDcgQEANCj4+IMKgICovDQo+Pg0KPj4gwqAjaW5jbHVkZSAicWVtdS9vc2RlcC5oIg0KPj4gKyNp
bmNsdWRlICJxZW11L2Vycm9yLXJlcG9ydC5oIg0KPj4gwqAjaW5jbHVkZSAic3lzdGVtL2lvbW11
ZmQuaCINCj4+IMKgI2luY2x1ZGUgImludGVsX2lvbW11X2ludGVybmFsLmgiDQo+PiDCoCNpbmNs
dWRlICJpbnRlbF9pb21tdV9hY2NlbC5oIg0KPj4gQEAgLTc3LDE0ICs3OCwxNDAgQEAgVlRESG9z
dElPTU1VRGV2aWNlDQo+KnZ0ZF9maW5kX2hpb2RfaW9tbXVmZChWVERBZGRyZXNzU3BhY2UgKmFz
KQ0KPj4gwqDCoMKgwqAgcmV0dXJuIE5VTEw7DQo+PiDCoH0NCj4+DQo+PiAtc3RhdGljIGJvb2wg
dnRkX2NyZWF0ZV9mc19od3B0KFZUREhvc3RJT01NVURldmljZSAqdnRkX2hpb2QsDQo+PiAtwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFZURFBBU0lERW50cnkgKnBlLCB1aW50MzJfdCAqZnNfaHdwdF9pZCwNCj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRXJyb3Ig
KiplcnJwKQ0KPj4gK3N0YXRpYyB2b2lkIHZ0ZF9wcm9wYWdhdGVfcmVjb3ZlcmFibGVfZmF1bHQo
VlREQWNjZWxQQVNJRENhY2hlRW50cnkNCj4qdnRkX3BjZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaW9tbXVfaHdwdF9wZ2ZhdWx0ICpmYXVsdCwNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBjbnQpDQo+DQo+V2h5IG5vdCBhIHRy
YWlsaW5nICJzIiB0byB2dGRfcHJvcGFnYXRlX3JlY292ZXJhYmxlX2ZhdWx0Pw0KDQpTdXJlLCB3
aWxsIGRvLg0KDQo+DQo+PiArew0KPj4gK8KgwqDCoCBWVERIb3N0SU9NTVVEZXZpY2UgKnZ0ZF9o
aW9kID0gdnRkX3BjZS0+dnRkX2hpb2Q7DQo+PiArwqDCoMKgIHVpbnQzMl90IHBhc2lkID0NCj4+
ICvCoMKgwqDCoMKgwqDCoCB2dGRfcGNlLT5wYXNpZCA9PSBJT01NVV9OT19QQVNJRCA/IFBDSV9O
T19QQVNJRCA6IHZ0ZF9wY2UtPnBhc2lkOw0KPj4gKw0KPj4gK8KgwqDCoCBmb3IgKDsgY250LS07
IGZhdWx0KyspIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBib29sIGxhc3RfcGFnZSA9IGZhdWx0LT5m
bGFncyAmIElPTU1VX1BHRkFVTFRfRkxBR1NfTEFTVF9QQUdFOw0KPj4gKw0KPj4gK8KgwqDCoMKg
wqDCoMKgIHZ0ZF9wcmlfcmVxdWVzdF9wYWdlKHZ0ZF9oaW9kLT5idXMsIHZ0ZF9oaW9kLT5pb21t
dV9zdGF0ZSwNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB2dGRfaGlvZC0+ZGV2Zm4sIHBhc2lkLA0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZhdWx0LT5wZXJtICYg
SU9NTVVfUEdGQVVMVF9QRVJNX1BSSVYsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZmF1bHQtPnBlcm0gJiBJT01NVV9QR0ZBVUxU
X1BFUk1fRVhFQywNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBmYXVsdC0+YWRkciwgbGFzdF9wYWdlLCBmYXVsdC0+Z3JwaWQsDQo+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZmF1bHQtPnBlcm0gJiBJT01NVV9QR0ZBVUxUX1BFUk1fUkVBRCwNCj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYXVsdC0+cGVy
bSAmIElPTU1VX1BHRkFVTFRfUEVSTV9XUklURSk7DQo+PiArwqDCoMKgIH0NCj4+ICt9DQo+PiAr
DQo+PiArLyogQmF0Y2ggc2l6ZSBwZXIgcmVhZCgpOyByZW1haW5pbmcgZmF1bHRzIHRyaWdnZXIg
YW5vdGhlciBjYWxsYmFjayAqLw0KPj4gKyNkZWZpbmUgRkFVTFRRX0JVRl9TSVpFIDIwNDgNCj4+
ICsNCj4+ICtzdGF0aWMgdm9pZCB2dGRfcmVhZF9mc19mYXVsdHEodm9pZCAqb3BhcXVlKQ0KPj4g
K3sNCj4+ICvCoMKgwqAgVlREQWNjZWxQQVNJRENhY2hlRW50cnkgKnZ0ZF9wY2UgPSBvcGFxdWU7
DQo+PiArwqDCoMKgIHN0cnVjdCBpb21tdV9od3B0X3BnZmF1bHQgZmF1bHRbRkFVTFRRX0JVRl9T
SVpFXTsNCj4NCj5zL2ZhdWx0L2ZhdWx0cy8NCg0KV2lsbCBkby4NCg0KVGhhbmtzDQpaaGVuemhv
bmcNCg0K

