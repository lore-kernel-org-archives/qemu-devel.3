Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EC5CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 04:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5zet-0005xO-NU; Tue, 07 Oct 2025 00:50:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zeq-0005xC-GK
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:50:40 -0400
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1v5zeh-0006LS-UA
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 00:50:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1759812632; x=1791348632;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0kCXOORZp5jIgCKX5z2UM20cr0fUqsEDAPL+ejHyANQ=;
 b=a1sYEa0ubJ+ZY22ZClM9QbfedV9iOJgV3n9Rh4DA7MARhnlQwsQ0edsT
 80r5/dISky8bM79S5kvwLYdSzbz5C+80aFOQaHhnpdYi2lWrnuB/ZtABh
 UHHhp0rwEtw33Vq2sAj5pUDXOUEpqeo3xo5cOEDT2z1S86P2Vt5RWqrjt
 Ta4RGJ2sP2cbzFvfxIHWIzapdLPWO2vLwMyvW6wopCu+BTF4rBNO42xG4
 UkRSBEXYXNahKtW/hIBzCML6n431ZzcVRVom1O39v2JU+y7zk95YVbN7G
 s2wR/KC68BSyDW9nxetIK5TWbTJxeO3DEbow6EZL93r6IA6E2lIoFZ2Fp A==;
X-CSE-ConnectionGUID: lzphgve3S2i7tY1AKp5nlw==
X-CSE-MsgGUID: vu4r0afVR8q+ehXIE+TSzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="87456650"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="87456650"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:50:30 -0700
X-CSE-ConnectionGUID: 7JVwJC4wS2yDNoR/w5pTvA==
X-CSE-MsgGUID: 2jfEVoJyRvCBiJ66YSuSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; d="scan'208";a="179876547"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2025 21:50:30 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:50:29 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Mon, 6 Oct 2025 21:50:29 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.34) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Mon, 6 Oct 2025 21:50:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vikMhK/LpKhqYLiByNkRUrsnnFtcFHwlJg4IT/hMNl/H++uHEi59iCOf4Ds254VgnyxM2eRQlJYAexwbriLKV8cfkOWRS8b1/sPze8nuciHnHMbcXyze+qHqD/6/E3BZiaUZ6SuBvgR6CKwasVk52Lg4NrGR1RcVjNNp9B64vIPpb/jcE5lFIVMmwfLAGiA+MZoeJYDimFacXompox6p8sfrRJFr6KoILmRwrXjIJXOCNPyUOvTvDoTJl63KOWuRmoZwkMpTUXektb1/bcQJBmhbe+2lG7TQL8nd3MQIOxvbxf/2F5CZw4/Z16nhgD+4e5q2nyD+utv0u+igWX9sig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qgKGI3SUKEJDyvU/2FQFQxoc14UZqOgqU9pxNX+uSTY=;
 b=pTYvz8M6bybEfObpF4a9CEQQkwCAcKIwsVEev8LS3a1JLjB0L2PMTN2qZ9skjTvz/ZJiexM1iOek/IAbkCVfhUIjKbHEBIUAqGKHoffdnKktZEZM9CcNkwrr8SHGi/CqMERykBDvQvuDoSUSjGcEhNBsSVENHpvMkZVu6xpkABUtY0AIwKXUzNYkqnE2aG4nwiUgTBpZbIn5gXBfdJCUcJJHWAi0sXQ1Kv0AP1sSC5ItGHkZM0+CQp6OsSyaJTmigdq4EJehcs9qVfd4/m9vO+j1+A4I8oXJ5h/hZqYMSzN5eGP8GlvviHqcGb16pmKM87YYYExfIBSoBAH8YDbjqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SA1PR11MB6566.namprd11.prod.outlook.com (2603:10b6:806:251::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 04:50:18 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 04:50:18 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 4/7] vfio/region: Add a helper to get region index from
 memory region
Thread-Topic: [PATCH v1 4/7] vfio/region: Add a helper to get region index
 from memory region
Thread-Index: AQHcNL+TH5u978CvakGoAiOhyID8A7S0zG6AgAEtiqA=
Date: Tue, 7 Oct 2025 04:50:18 +0000
Message-ID: <IA0PR11MB7185538792F4A2D3BDB3A810F8E0A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20251003234138.85820-1-vivek.kasireddy@intel.com>
 <20251003234138.85820-5-vivek.kasireddy@intel.com>
 <4b738e3e-6788-4b28-8bc3-d656d3d4db58@redhat.com>
In-Reply-To: <4b738e3e-6788-4b28-8bc3-d656d3d4db58@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SA1PR11MB6566:EE_
x-ms-office365-filtering-correlation-id: cf0a6fa0-a5f3-4cef-9ebb-08de055d036f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VsLB1bS0eAFL1fmCo04Gnf5EMkQrnq7okReNUbshmvXrXmV/plyVxOeNIl?=
 =?iso-8859-1?Q?EWiVnv33up6FJJPkqrcHyOyAQ7s+r8rehAFGTaT8HNzDRwo1tjOjDIY3Nd?=
 =?iso-8859-1?Q?gjLMlSrQati08qUhohSsH5MV36M13jD7Csbn/Ssz3g53Tg8U7Ofe/hOnjn?=
 =?iso-8859-1?Q?77xNnXtOtGpH7sKI/KqgaJNXIcwyzAVKJm5Y3ie7vrVsOctV9Z/HTGYJOo?=
 =?iso-8859-1?Q?Ue8GhfdvqMNtVWjaEN9jK5pEh4lCYUOcvENCHHYsnAc/ovelMIRL2rsjup?=
 =?iso-8859-1?Q?lJM6N+bKjoulDbWOa9yzxutI5RHTcGyaDURfGbpqpDtOcAXg/p9+BlOFgd?=
 =?iso-8859-1?Q?SnFEr8Gt7w+oDfQ56oz0PXmSWdx0hwVvt6MP8TfUbINb+hOm/QkDZnVAxL?=
 =?iso-8859-1?Q?AWM5Cp+hnPjzJhom8Dh/c/eGaLh94GFEQo6wJTSGprhzU/W0zhHuubC4gL?=
 =?iso-8859-1?Q?CkBAfjECFOy2A5Gsq+TRl7pFHq+BOco7q4k2fyYP3NlwLhzaV/ff3ZMWd7?=
 =?iso-8859-1?Q?lKaSh+gdKEL0eHBqXLz5CB7LnX5LxTwc5v+37yejOA+fAVDaiaR4IX6KEh?=
 =?iso-8859-1?Q?jrUGwUn99T39U2bq/74hldBr/EvK6JcJ4b+HHK+2z+4d6b3uhvari3bG08?=
 =?iso-8859-1?Q?r+e2/QYYaLvLWLpovwfy4SIph+TybjTjZhAvua56l8oX2/9jE8qCVI+hBX?=
 =?iso-8859-1?Q?GWh0llzgWCW9+m7mIpAXowhEZxKf5bUCH0n/FBVsww6fnlfhs8sVmm2WdF?=
 =?iso-8859-1?Q?a8dyAzAGjd0yVHwotaWndYRVT/sulDsSj6WfaTpPEy2byx5kUKb+pr3YYA?=
 =?iso-8859-1?Q?CHTblCsS6AkPBJhV8wFphZtBIQDrCDvyXct4k3Y0dZqMPzaOUQW+bFPcJO?=
 =?iso-8859-1?Q?8pcuESt5+2bYqHp9sSexxzqQfp6spl4dU0C7Z4a/jeTXsc/wpJ3rMQrk0z?=
 =?iso-8859-1?Q?Z+X81HnqOl17Vbzv7pNzRRcwgH1vZy51h6gIMs3p3Qrw2v0iUtY0GCJd0/?=
 =?iso-8859-1?Q?lk5KM8nyzO9puNvH8nX2+b944St5KQlTzvwBbgWSF+ippD8nH+Jnbavg/d?=
 =?iso-8859-1?Q?VGujw2K2YsvVFSPP7A9dilQ6rx9QpKPtIJyab3aUvZyXanEf4d1irv4zkz?=
 =?iso-8859-1?Q?pBWdwBBFt/78HIzXbLI9I2NrFbFQwjzUv77DiRhv8V5YqkdsovZFolOod8?=
 =?iso-8859-1?Q?ba+RIA4TlykqSTzfJ7ZDeDKFam7Z6uTHa3u5afQjcGYd2TIQr+S5lQznBZ?=
 =?iso-8859-1?Q?cNopfdS7M5MuenebIl98/zCM18vVIbxX7FAXgendbSvfwzkqi4u4AUQHoS?=
 =?iso-8859-1?Q?joC8y1+VrY3BH3b+fyQa5HtHyglbTSZj6GwtOZtTDXV6HKWNpvH4M5Ounf?=
 =?iso-8859-1?Q?YpYb7hOo+WqkPy8DICb5uKWsBwknZonKeBF5B1gjteM+GNvgu3XCuus30I?=
 =?iso-8859-1?Q?JhAsx3XVT6PBF8Zk6evVQjcob2nDw0fMmaxHnDvh//OjSAeiVun8q7tqvf?=
 =?iso-8859-1?Q?zeZBXvfYd2zEP0OWb1ljA48CqjJRF5fwmW0OEZknDBfaWDMW5pyPN2FrU4?=
 =?iso-8859-1?Q?IhyzpfQsA4lY1ap8w1o33mFAGau4?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UiStSk917gijA3YKA70ntvb88IGfqIatt5VKnCEEhNtDeZdJw9CMfOKS75?=
 =?iso-8859-1?Q?klr7a8cJVINOBIMcSYndeZfw3HwOmyfkDunisXuPVeTkyHSkFOBYKWLXfk?=
 =?iso-8859-1?Q?f92uc16+fQIySVkNi61VWGSBqQ1rWTErZAICODMnhUdc7PlYv3+JgGGJem?=
 =?iso-8859-1?Q?lpXBRj9V/qzuabceWkDxt+I5L5tNqNvX+DoZ2d1dimwUnOeNapqRvCb1Ad?=
 =?iso-8859-1?Q?+KhqLTlm0Y1G4CXuDN3buZpWQZ7DtmqpJ8Q2s4YN5xj0YSICwS+JpjOx6+?=
 =?iso-8859-1?Q?Rt5ox849GyOEaEzlIMHoBRXMp4hEbBRYmGMOo3Y467OS0Qd8J5lAo8X3H1?=
 =?iso-8859-1?Q?pmYI7XvSSSc7+3mOJpfpeKFPROgVjOH9EflOgFt9nNWBZrVb/Xt8MlZZ67?=
 =?iso-8859-1?Q?eafowci/tdnVWwEkagi+1ihrKKv/WhbqBGI3KzeLWndC6+OrI3QxKf3iZ5?=
 =?iso-8859-1?Q?3Eq97WFCM9JzXXb4YWDyzTtFDxZtQv4V13upvu8jEUhNZOm1vQzIZ27NCd?=
 =?iso-8859-1?Q?wM9ty+mL+joBKBf1jo2WHG4NNMo7o/b5BFvzkClX8XHXfyDFIgOiC6Bhvb?=
 =?iso-8859-1?Q?blptV5fLXqhIQtsBjLolrkt4eQw3kNqHDVzp/VyZGSYtMeUjjsYA/VXeyu?=
 =?iso-8859-1?Q?SYGWg85YMdvQedDXkmexT35w44cF7k/Nu+Ah32PKgC6JlQTHXPhC8DKpiv?=
 =?iso-8859-1?Q?vOyysTJLqThENxf4loaoILLnyn0cC/MfbAOTzUozwkXuQtxK3uaZ/vIIWO?=
 =?iso-8859-1?Q?t/s/0KufFBhh2T0LD4OgHRRbbVVXf6wFnbMu9uSTVY+vtd8FotF03nVDT6?=
 =?iso-8859-1?Q?2ids0QF+ijW7w946CuIpNwXqDUkC9JKcvUOWdNxe4zUIe6YgxiS5L8gyCn?=
 =?iso-8859-1?Q?7bs0XdWjy5ri4p5t+8TGEsuj7hrnS9mKVqU4636MwAVkcNwewQc/x1H5vR?=
 =?iso-8859-1?Q?IRJFn57OhrBai8QEfMHEJbsb5UGnQy5WzXbHXtNsubHyP5O62zExoU4oG/?=
 =?iso-8859-1?Q?6z5V09Zgocr9OvI7edCi+49+1G1/Q3F5pDLn4FDudNfZZoRX67Pc6XnFIm?=
 =?iso-8859-1?Q?JJVcc4nU4uC+M1FjVFWYEKE9VuxX7z6/3qSBOCyIMlJf447r8ZGtSF486q?=
 =?iso-8859-1?Q?iFukZkAyffbDBTctVTrt90WOGXJZauxmo7JUpojkhwPZ+3tWs8uDqJU0uD?=
 =?iso-8859-1?Q?5wRhV3DWhFcX48h1SKrgjY+K7XbRUsoEUsq9xRnA54VaT11CEcsw6TTLaY?=
 =?iso-8859-1?Q?Qp354Z5O8PGfV7QL7roTdHNNn0vL/3LmcUT3PnMP8iWO122zp2ESQmZ7dx?=
 =?iso-8859-1?Q?uRLSkptyxyxdzSUCw0GHIf83wpddVmwhVqYtBfHPP3//zJLTkn0MWDlMFD?=
 =?iso-8859-1?Q?AFRDlWl2oL0im/s0QQauayHS1tj3jlgx6+LIfKNDf6aC9pXdAfimQo8VYt?=
 =?iso-8859-1?Q?KTL/vDMmNb3y5yXpfjg9m7tCtMa4bmiy7aLk8TBlJQuxdeLtBUp+AffVgt?=
 =?iso-8859-1?Q?0b9XWKVLXM+rlhlGldlW4dhEf7rraZ+c4FAEII2R8vQHrDYLVsPjeKrkNO?=
 =?iso-8859-1?Q?TldzkDvq0wiXiJSPe4vjZbY2eY+XN8/ADrYieMpjAI1gMHnOMphSwMM0Ec?=
 =?iso-8859-1?Q?q19XNJxKiF8gVwESCailL2qttQGNck051w?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0a6fa0-a5f3-4cef-9ebb-08de055d036f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2025 04:50:18.0666 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HjssetEZvgmYMNKClR6cBC7yG0uUBpUIUHGro7OHusa6e936u7PEaTUF7wnzBBZREkwxp63ROyAr+fOnONVfnSxKZwFz+iv6eCCBUor1aFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6566
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Subject: Re: [PATCH v1 4/7] vfio/region: Add a helper to get region index=
 from
> memory region
>=20
> Hello Vivek,
>=20
> On 10/4/25 01:35, Vivek Kasireddy wrote:
> > Having a way to figure out the region index (or bar) associated
> > with a memory region is helpful in various scenarios. For example,
> > this capability can be useful in retrieving the region info needed
> > for mapping a part of a VFIO region or creating a dmabuf.
> >
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/vfio/region.c              | 14 ++++++++++++++
> >   include/hw/vfio/vfio-device.h |  2 ++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> > index b165ab0b93..8837afc97f 100644
> > --- a/hw/vfio/region.c
> > +++ b/hw/vfio/region.c
> > @@ -398,3 +398,17 @@ void vfio_region_mmaps_set_enabled(VFIORegion
> *region, bool enabled)
> >       trace_vfio_region_mmaps_set_enabled(memory_region_name(region-
> >mem),
> >                                           enabled);
> >   }
> > +
> > +int vfio_get_region_index_from_mr(MemoryRegion *mr)
> > +{
> > +    VFIORegion *region =3D mr->opaque;
> > +
> > +    if (mr->ops !=3D &vfio_region_ops) {
> > +        mr =3D mr->container;
>=20
> May be start the routine with :
>=20
>      while (mr->container) {
>          mr =3D mr->container;
>      }
Ok, makes sense.

>=20
> > +        if (mr->ops !=3D &vfio_region_ops) {
> > +            return -1;
>=20
> I think I would prefer returning a 'VFIORegion *' which should be
> NULL in case of error. Looks cleaner.
Given that VFIORegion type is no longer exposed to other subsystems,
I am guessing you meant adding two helpers: internal helper that would
return VFIORegion * and an external routine that would call the internal
helper and return region->nr?

>=20
>=20
> > +        }
> > +	region =3D mr->opaque;
> > +    }
> > +    return region->nr;
> > +}
> > diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-devic=
e.h
> > index 7e9aed6d3c..bdb106c937 100644
> > --- a/include/hw/vfio/vfio-device.h
> > +++ b/include/hw/vfio/vfio-device.h
> > @@ -277,6 +277,8 @@ bool vfio_device_has_region_cap(VFIODevice
> *vbasedev, int region, uint16_t cap_t
> >
> >   int vfio_device_get_irq_info(VFIODevice *vbasedev, int index,
> >                                   struct vfio_irq_info *info);
> > +
> > +int vfio_get_region_index_from_mr(MemoryRegion *mr);
> Please add documentation.
Sure, will do.

Thanks,
Vivek

>=20
> Thanks,
>=20
> C.
>=20
>=20
> >   #endif
> >
> >   /* Returns 0 on success, or a negative errno. */


