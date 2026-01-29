Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CB5D358CF
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 06:49:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlLqE-0005H2-LL; Thu, 29 Jan 2026 01:49:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlLqA-0005GL-Ot
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:49:18 -0500
Received: from mgamail.intel.com ([198.175.65.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1vlLq5-0005hY-6S
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 01:49:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1769669353; x=1801205353;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I1OHsWGQvnvI+cOYF+EkTPg3PEzWP8Njx4fyGMqJ2+g=;
 b=R0ftaivoxB1RtLnp3fYTIS8b4ORRXCk4iMSbG/pwrD4YxSdAJGM0gy/t
 DSfOhrtsq+Vp0bKjzx/SvZwJdahbLv9k7Xfg0pf/KeV+Y/12TMAJAzK8q
 hlBK4UUb2I9X7XQJ8wcaN/4Y8+mF4VPDKWcvN02Ebengo4UppVYS/5UdP
 JaWE6aw0zrORrzH4TbhZEeUk3Y/PNGbVkGHyTF5laIcGkqzpHAuDdbXOU
 BpX516T9zlYV2ZKvoa9+aq4DqCqL5q/8B8+NLyO0C6bOGg9AzFKypecVP
 Go6wd/JotMBLjFneSL3J5U+yIva7U7Anf/3NAr81YrIj3fRx6Qj6IKutj Q==;
X-CSE-ConnectionGUID: dd7S4qUNRrGyXP+53Jr/0Q==
X-CSE-MsgGUID: aPf1jdSKSEWncl492wXK7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="70613267"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="70613267"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 22:49:11 -0800
X-CSE-ConnectionGUID: SPa0i+uNTfGwGF62WA7kDA==
X-CSE-MsgGUID: ufS5CRWdQbyAWrK3h85jTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; d="scan'208";a="239739789"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jan 2026 22:49:10 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 22:49:09 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 28 Jan 2026 22:49:09 -0800
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.69) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 28 Jan 2026 22:49:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEcd8Rxw2vcw9+kq/dWHNXF9hoNEijAIfxXoWS9mgGu7sBrjvzn3vXI6xDuaVS8u+Ju2zRgS7180ouE/JNQufqwQpH5P6ZOmnZC01Q3aJZBTvA28tKaHh/A1GMp4gpIecvyzgWS736zpsmnG7vUxX3yk+HbXYQcyyhTsSVmmnIL88wPLl0c6YlzDzNejYDrAXbQ1BOjGpOB2y3FPcolFMN1KPvas65QdZk6BxHPsW2ODSW0vYy/el6/lqXBeHe6qosmO6wXXc//DezHV7ZYnJNoB/RKk7u8t+yiqOLCKWOPSNylFJ6AzoExATYjunVfQji1OrlzxzATsAL0k/k/iOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edI+Lz0roedh9JbcxnIu3AVP0WNm2L0Josa5Io5606U=;
 b=c7gvq2aFDCppGqgtqU/mbaU2UGNuQm+y4YU7YzeIWT5XLpWzYbewn5lup5k3P+gXbCXoTSVpiWu/wZSxC4yOKF2zXjpKGI0FlXOnV3ij9cNJHHhhn3Wha1t5aJDAaXsNLAeZt8APKlGPQiqI4RX65tDC28qEAaHkrocFCgLzZhMfh70FwMDqRiqQmu1NHIKS/GLNEVN8JrE+ypMz4ZdcM0RQlQajwJD+JeBlkjkhq3LlkNSRdU2btRnf3QsjdmnXgaSdFCkPWhgStTixUzlin9uLUsWJvH6IES74JydvxEHYIagXh6ez9fDD7KUcWtYlecGaMD+CVfEypbayCuJuAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Thu, 29 Jan
 2026 06:49:03 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::9f37:cb81:5463:300e%5]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 06:49:03 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>, Alex Williamson <alex@shazbot.org>
Subject: RE: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Topic: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
 associated with VFIO devices
Thread-Index: AQHcjDCjL5JILwxhKUSESHcm3Ev6grVnSDsAgAE+NWA=
Date: Thu, 29 Jan 2026 06:49:03 +0000
Message-ID: <IA0PR11MB7185685AEB4BC657C167EB0FF89EA@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20260123062042.568703-1-vivek.kasireddy@intel.com>
 <20260123062042.568703-9-vivek.kasireddy@intel.com>
 <1bddcc61-9640-4d63-a972-ab16b0061611@redhat.com>
In-Reply-To: <1bddcc61-9640-4d63-a972-ab16b0061611@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|MW4PR11MB5799:EE_
x-ms-office365-filtering-correlation-id: ebc205cb-7dee-40d6-0ce6-08de5f027d91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?VaZo0c0HLxIyM7FNbUN4wjIB1xIzVBGfiE383U/Cl7TJixW1ABq39MY+Sp?=
 =?iso-8859-1?Q?3W0/53DebjqbLeJZEsWGlxmJ8RbnBaeyDRpqLg8mcX9VoduBPk6dhjxoY5?=
 =?iso-8859-1?Q?shjt952bFLAoxd/TER2g6NWEiX9F3WKQ0tt51fvc7v6vLSS1KW4ENSpZbb?=
 =?iso-8859-1?Q?Uw+wNvqwuQKU2mszenjXGvQhKfuNdsFtcDkhuxXMf1SmyG58FQbISmpymM?=
 =?iso-8859-1?Q?JIkbmsYxAOvPSNz6QdSfpZfZUWjbrg1pnGc86zjHTdUBJAIOEz6y0CBPL7?=
 =?iso-8859-1?Q?/7XRZrHCIU2qDY1o7vpx/0dSXrII1JmRw+TnyitWGPGRXJth/IK7z4l3WB?=
 =?iso-8859-1?Q?VmaTOKlgoPDoaGSaPk1Bz39DkV/rzTYqnHoqIxKIonntIj1tBX1FzSwbVC?=
 =?iso-8859-1?Q?4NAmWzFqJ+ZbCVXUAvAp8BI+s5nb3aw74hUPPNchwUFHLnOVFy0uIcGABx?=
 =?iso-8859-1?Q?tlgowcjLG5484F7TQLnTYkl+gzqty0O2DI9mTifdIni5pbC6kG0n/id3Ok?=
 =?iso-8859-1?Q?hm1BqIAj89dUZxN7hogmE6Tn7DK7g5Lg/d90V+2I20fFtkYbC2Bnezksv+?=
 =?iso-8859-1?Q?w+UHegUKF8wBy4JSbNF4IEqa8bjqvqJSATVjNJg42jk/IxhYpXI0T1TlZn?=
 =?iso-8859-1?Q?87LkZrP2Uvt0SXO3VSLufswOzuaR30k1G9+GrfdY5VAP8KDjVJuaursRwR?=
 =?iso-8859-1?Q?Xqe2f2uRLsTMjuu5qnSBYWQ0gZ38ax8fBYTUq65Qa75N1hdYtloTIVyx8T?=
 =?iso-8859-1?Q?ZzS0Gvf9ZWI3jrTzJf0kEoy0e7xr/5SqkVDwcy/+QCwtjogB0dw/AOFMaT?=
 =?iso-8859-1?Q?ET6ft48wTPjh8Bd4Uk2gi0w66NnT8YEs7Z2n5wbDh4elUEDRqHDthrkocN?=
 =?iso-8859-1?Q?RwjiPAyBwWWNvh2+E9ViN8+E4xvyU9c+tWJ/+EiMYlW+M98a7vjcTm0McS?=
 =?iso-8859-1?Q?u9Wdk/Yhc4vZVauS4Au5s/tMbsMs4hG0AdhSOa5vMfjwMCyocybpvTD6Op?=
 =?iso-8859-1?Q?edQ5zqp37ik4+vgAl6Pt0bffRacSOSEP23VFPE4aGVTuH6Js/ouj1mIti/?=
 =?iso-8859-1?Q?jYioDJFxuLo2xB0gdizbne6EWKhSCftgVpkaQATwRv6oCuE/nfqTyK9i8N?=
 =?iso-8859-1?Q?hf60auXZ+vTwb55hpjpwwRdjGZU3CXyCs6m25dmeIgugMjCzuAhnbZJFxU?=
 =?iso-8859-1?Q?MHztuT70pQUXydz+OO+Yi1ZM9DD4Vl7p/84RGGqc6PbwRQzJJtxRHhn6cr?=
 =?iso-8859-1?Q?p1So3RfWeipTSWscak0T1AbLF15j4gvBpAjhtNq9SZP2JxyLIlCnXbf+Mv?=
 =?iso-8859-1?Q?eSi7Nh4oyaooiAVqd38ZflQ/lrRr+PtehBhDDvbDHJs+hJxCFovvSZ542E?=
 =?iso-8859-1?Q?CipnRqYACmAdms48NfDTEPzLpMhFs9dxeyaLD5qDHRcdhJhz0x+yRrewSk?=
 =?iso-8859-1?Q?Zi9N0psHPL5fMDlPUuJxKE93rDtTzH8DKXV85jSMIgtUXzPcvZXwNUklKT?=
 =?iso-8859-1?Q?lY+eYcaySLLqjiPBYF5tFAfVX+YMZRsHsg9x1KkZ38dPGGiDH1CX/l94oz?=
 =?iso-8859-1?Q?Dt7jFq2wGLB6CTjigI1nqSKOdCWXsSia93sE46CeEOmbgWGMCb3tbDSq2i?=
 =?iso-8859-1?Q?vh1Dn1fSKiD1eeBbT6M/xevAyUCCKurswKXpGJ/vDjlz+mQnHZV/M7P+lI?=
 =?iso-8859-1?Q?rCceEv/qcD2GQP8fTYY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IdfvvF/wCvdVA1ASeQsI1GlxCHA9OsWGFQNGY26jKsiZTV1KPu36yrfXHq?=
 =?iso-8859-1?Q?yGV729bsdEb0S7RSpFhFAJp03gE9+onBUSIyrYr5JNcRV+I9ujI883l0/e?=
 =?iso-8859-1?Q?zGSZMlIbq13J0IOaeo2Ad3qim6rNgp0zOf+4rKCOidHBaTqX55qvQoc90H?=
 =?iso-8859-1?Q?KWtONLI2wSOyEJh36YCQsFaDI/D8AcdChAuH3HZ2Rt08ZprUxl3//SEr3u?=
 =?iso-8859-1?Q?QbWo1bwg1w30BA6yx1EST9H4XiDFvJoICYGLe71NNmhwG97XYB05a44fcB?=
 =?iso-8859-1?Q?gGE8Z6wSYMCRDVvXeL/azSp6YNeSEs0qtw/EMNCarAzV5/ATIcZ8gc9yWi?=
 =?iso-8859-1?Q?P3WSYEj5a2hPrQL5wqWOl7XxDKqeHJEET4RERaeEQhL8rv7ON8A09AAGCV?=
 =?iso-8859-1?Q?v7fweDsGd3BpmuH3f41rKMP1vUrPvBYO9hH0jOQVy2VmeQPw/ypsEe6OJa?=
 =?iso-8859-1?Q?FJidkVd5yIYOu8tkp6i9JPNWuVIBSbV/jmSOoyLRGbUbBxS5NOHZTmffcy?=
 =?iso-8859-1?Q?xyH2WJ3FX6+vTvcy6ln0XKrw8PLJabmc1Afti6bDtTShFmpwLKlBXaFsTe?=
 =?iso-8859-1?Q?MLsIH6mw/f+2qeOJ07HXP3+M9MVhcLnaOVQfErYOI53Ps9bzuwtoxr8qmM?=
 =?iso-8859-1?Q?TWjQU/RLK1LwLuofiefZ9fvSumr0E3GxR2RavLyGadMeVkT6/+/h9wcFAk?=
 =?iso-8859-1?Q?cN0/ByOJtgN5BpoRUniW0YXvv3OaE91ZqbQ4ogD3aREu0cT3u9eCJ8SWdM?=
 =?iso-8859-1?Q?I5+ZF/Z8RJ8QMxDqnqZ1BSwclg3mYFN2aKJnOSSf/oTw4pfR0GIlUETNYX?=
 =?iso-8859-1?Q?wH5JM4E8njB+8p01zN110/X7qPp4VCrOoFA/r4yrB3JZFDYYe/j6tUxcWg?=
 =?iso-8859-1?Q?B9or0G+WR3JdwlpKhzl7WGqKu4+XaxwtGaPkCyzNLHxdxzWGZuotVYYLsT?=
 =?iso-8859-1?Q?Eqp2Yz+qIUFQFOirb01os2lW3EPmw0J5YkpioXWwfBy6k8c9OxvXhfnOOT?=
 =?iso-8859-1?Q?3psFPkIsMZ61EFLoH+lCUzPCudgaq1zkViE/M27Z58d26iHoZWr3x9Femu?=
 =?iso-8859-1?Q?PNHsp8ECoDbWeqlrWObaMXqJW/d6qVjbYJZlj021fh0yhTmEN7qMmZWdN1?=
 =?iso-8859-1?Q?pyDMW9cLv7XK2KCQ73B5iGHD/aF85kguUqCBcmikQvNV8pzmNaGriZJwXL?=
 =?iso-8859-1?Q?iQXjr6NKyxGn1K8IbXxAemC34s+3+1ibE4uaGzyZvVrtFaVTuTlHfzCxBH?=
 =?iso-8859-1?Q?7tzeWLa2hV4gsBhlHdKJWSwLJAiBAspddecJxvQKXlqjhLLtlU+rW16+no?=
 =?iso-8859-1?Q?Y4DU9ydH4bBHm5IeF/CXc8nCh1LwDOhmo6xhuZkCK2/Axo4HLm3Ssu8EmI?=
 =?iso-8859-1?Q?zEOnyeJ3/sDMnKDYmOwWYBZs4Go6fP35M7gdjy9h1a3gl7p96YeULYWzrW?=
 =?iso-8859-1?Q?93jIbq5bVIl6fFNkrhnoGDr8g1jr1nToRCZS/b7cAb3apxRyJ6yrzhhf+Y?=
 =?iso-8859-1?Q?lDSN07Sc9YHJHHDM7gFPLj/BwlL7Se4OrH4Mnvt0RAmZfMTQKApD27t/Rq?=
 =?iso-8859-1?Q?LzlS+lCOxUBScpfl2kEymHjHpQ02VnH6BLC7uydSwzJvXelcbkiitIt/LZ?=
 =?iso-8859-1?Q?n28MtOUjzvEywGfAgK14YTRaaHJQbJk2JpqvJW7A8QgMkllKSjxD9oOZxj?=
 =?iso-8859-1?Q?kOLgY8rzfypMHoJklAdYjSo0Uu4zN9paE8EMyflc8uANDUvi3STyPIIZEc?=
 =?iso-8859-1?Q?Oa1JLsfNF2ERzA3E6ZNdMz4TS6I0+laS6QG52VmYnIEffsJsq+i8C9tV9Y?=
 =?iso-8859-1?Q?U9RrNySyGg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc205cb-7dee-40d6-0ce6-08de5f027d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2026 06:49:03.4000 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KeiVPa1yckNSTG5vRFDaiXgDBK19ArXS4pxSwXnPGsp2tnMh+yaAKXuTfKpdqPBEi5pwTyKv2RTCiMs1Obwm61VEW0h7qQ6Y/8KIy+easlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.20;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Hi Cedric,

> Subject: Re: [PATCH v4 8/8] virtio-gpu-dmabuf: Create dmabuf for blobs
> associated with VFIO devices
>=20
> On 1/23/26 07:17, Vivek Kasireddy wrote:
> > In addition to memfd, a blob resource can also have its backing
> > storage in a VFIO device region. Since, there is no effective way
> > to determine where the backing storage is located, we first try to
> > create a dmabuf assuming it is in memfd. If that fails, we try to
> > create a dmabuf assuming it is in VFIO device region.
> >
> > So, we first call virtio_gpu_create_udmabuf() to check if the blob's
> > backing storage is located in a memfd or not. If it is not, we call
> > vfio_create_dmabuf() which identifies the right VFIO device and
> > eventually invokes the vfio_device_create_dmabuf_fd() API to have
> > a dmabuf fd created.
> >
> > Note that in virtio_gpu_remap_dmabuf(), we first try to test if
> > the VFIO dmabuf exporter supports mmap or not. If it doesn't, we
> > use the VFIO device fd directly to create the CPU mapping.
> >
> > While at it, remove the unnecessary rcu_read_lock/rcu_read_unlock
> > from virtio_gpu_create_udmabuf() and also replace warn_report()
> > with qemu_log_mask().
> >
> > Cc: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > Cc: Alex Benn=E9e <alex.bennee@linaro.org>
> > Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> > Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> > Cc: Alex Williamson <alex@shazbot.org>
> > Cc: C=E9dric Le Goater <clg@redhat.com>
> > Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> > ---
> >   hw/display/Kconfig             |   5 ++
> >   hw/display/virtio-gpu-dmabuf.c | 117
> ++++++++++++++++++++++++++++++---
> >   2 files changed, 113 insertions(+), 9 deletions(-)
> >
> > diff --git a/hw/display/Kconfig b/hw/display/Kconfig
> > index 1e95ab28ef..0d090f25f5 100644
> > --- a/hw/display/Kconfig
> > +++ b/hw/display/Kconfig
> > @@ -106,6 +106,11 @@ config VIRTIO_VGA
> >       depends on VIRTIO_PCI
> >       select VGA
> >
> > +config VIRTIO_GPU_VFIO_BLOB
> > +    bool
> > +    default y
> > +    depends on VFIO
> > +
> >   config VHOST_USER_GPU
> >       bool
> >       default y
> > diff --git a/hw/display/virtio-gpu-dmabuf.c b/hw/display/virtio-gpu-
> dmabuf.c
> > index c34d4c85bc..2dfe70d7eb 100644
> > --- a/hw/display/virtio-gpu-dmabuf.c
> > +++ b/hw/display/virtio-gpu-dmabuf.c
> > @@ -18,6 +18,7 @@
> >   #include "ui/console.h"
> >   #include "hw/virtio/virtio-gpu.h"
> >   #include "hw/virtio/virtio-gpu-pixman.h"
> > +#include "hw/vfio/vfio-device.h"
> >   #include "trace.h"
> >   #include "system/ramblock.h"
> >   #include "system/hostmem.h"
> > @@ -27,6 +28,38 @@
> >   #include "standard-headers/linux/udmabuf.h"
> >   #include "standard-headers/drm/drm_fourcc.h"
> >
> > +static void vfio_create_dmabuf(struct virtio_gpu_simple_resource
> *res)
>=20
> Could you please not use the 'vfio_' prefix ? Its confusing as there
> routines are part of the virtio component.
Ok, I'll use a different prefix.=20

>=20
>=20
> > +{
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    VFIODevice *vbasedev;
> > +    RAMBlock *first_rb;
> > +    ram_addr_t offset;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: Could not find ramblock\n", __func__);
>=20
> Error handling is quite poor. Can't we have an 'Error *' parameter ?
Ok, I'll improve the error handling by introducing Error * here.

>=20
> > +        return;
> > +    }
> > +
> > +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> > +    if (!vbasedev) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: No VFIO device found to create dmabuf from\=
n",
> > +                      __func__);
> > +        return;
> > +    }
>=20
> vfio_dmabuf_mmap() does the same sequence of code to query the
> VFIODevice.
> May be a common helper would help.
Sure, I'll try to figure out a common helper.

>=20
> > +
> > +    res->dmabuf_fd =3D vfio_device_create_dmabuf_fd(vbasedev,
> > +                                                  res->iov, res->iov_c=
nt);
> > +    if (res->dmabuf_fd < 0) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                      "%s: VFIO_DEVICE_FEATURE_DMA_BUF: %s\n",
> > +                      __func__, strerror(errno));
> > +    }
> > +#endif
> > +}
> > +
> >   static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >   {
> >       struct udmabuf_create_list *list;
> > @@ -43,10 +76,7 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >                        sizeof(struct udmabuf_create_item) * res->iov_cn=
t);
> >
> >       for (i =3D 0; i < res->iov_cnt; i++) {
> > -        rcu_read_lock();
> >           rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> > -        rcu_read_unlock();
> > -
>=20
> The rcu un/lock removal needs some explanations. It deserves a separate
> patch
> I would say.
Ok, I'll split these changes out into separate patches.

>=20
>=20
> >           if (!rb || rb->fd < 0) {
> >               g_free(list);
> >               return;
> > @@ -62,17 +92,84 @@ static void virtio_gpu_create_udmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >       res->dmabuf_fd =3D ioctl(udmabuf, UDMABUF_CREATE_LIST, list);
> >       if (res->dmabuf_fd < 0) {
> > -        warn_report("%s: UDMABUF_CREATE_LIST: %s", __func__,
> > -                    strerror(errno));
> > +        qemu_log_mask(LOG_GUEST_ERROR,
>=20
> Is it a guest error ?
IIUC, it can be considered a guest error as it failed to create a dmabuf
on the Host using the udmabuf driver and Guest provided addresses.=20

>=20
> > +                      "%s: UDMABUF_CREATE_LIST: %s\n",
> > +                      __func__, strerror(errno));
> >       }
> >       g_free(list);
> >   }
> >
> > +static void *vfio_dmabuf_mmap(struct virtio_gpu_simple_resource
> *res)
>=20
> please use a "virtio" prefix.
As suggested by Akihiko, I am considering moving this routine to VFIO in
order to avoid exposing VFIODevice or VFIODevice->fd outside of VFIO.

>=20
> > +{
> > +    struct vfio_region_info *info =3D NULL;
> > +    VFIODevice *vbasedev =3D NULL;
> > +    ram_addr_t offset, len =3D 0;
> > +    RAMBlock *first_rb, *rb;
> > +    void *map, *submap;
> > +    int i, ret =3D -1;
> > +
> > +    first_rb =3D qemu_ram_block_from_host(res->iov[0].iov_base, false,
> &offset);
> > +    if (!first_rb) {
> > +        return MAP_FAILED;
> > +    }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +    vbasedev =3D vfio_device_lookup(first_rb->mr);
> > +#endif
> > +    if (!vbasedev) {
> > +        return MAP_FAILED;
> > +    }
> > +
> > +    /*
> > +     * We first reserve a contiguous chunk of address space for the en=
tire
> > +     * dmabuf, then replace it with smaller mappings that correspond t=
o
> the
> > +     * individual segments of the dmabuf.
> > +     */
> > +    map =3D mmap(NULL, res->blob_size, PROT_READ, MAP_SHARED,
> vbasedev->fd, 0);
> > +    if (map =3D=3D MAP_FAILED) {
> > +        return map;
> > +    }
> > +
> > +    for (i =3D 0; i < res->iov_cnt; i++) {
> > +        rb =3D qemu_ram_block_from_host(res->iov[i].iov_base, false,
> &offset);
> > +        if (rb !=3D first_rb) {
> > +            goto err;
> > +        }
> > +#if defined(VIRTIO_GPU_VFIO_BLOB)
> > +        ret =3D vfio_get_region_index_from_mr(rb->mr);
> > +        if (ret < 0) {
> > +            goto err;
> > +        }
> > +
> > +        ret =3D vfio_device_get_region_info(vbasedev, ret, &info);
> > +#endif
> > +        if (ret < 0 || !info) {
> > +            goto err;
> > +        }
> > +
> > +        submap =3D mmap(map + len, res->iov[i].iov_len, PROT_READ,
> > +                      MAP_SHARED | MAP_FIXED, vbasedev->fd,
> > +                      info->offset + offset);
> > +        if (submap =3D=3D MAP_FAILED) {
> > +            goto err;
> > +        }
> > +
> > +        len +=3D res->iov[i].iov_len;
> > +    }
> > +    return map;
> > +err:
> > +    munmap(map, res->blob_size);
> > +    return MAP_FAILED;
> > +}
> > +
> >   static void virtio_gpu_remap_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >   {
> >       res->remapped =3D mmap(NULL, res->blob_size, PROT_READ,
> >                            MAP_SHARED, res->dmabuf_fd, 0);
> >       if (res->remapped =3D=3D MAP_FAILED) {
> > +        res->remapped =3D vfio_dmabuf_mmap(res);
> > +        if (res->remapped !=3D MAP_FAILED) {
> > +            return;
> > +        }
> >           warn_report("%s: dmabuf mmap failed: %s", __func__,
> >                       strerror(errno));
> >           res->remapped =3D NULL;
> > @@ -139,8 +236,12 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >       } else {
> >           virtio_gpu_create_udmabuf(res);
> >           if (res->dmabuf_fd < 0) {
>=20
> Why test dmabuf_fd ? Can virtio_gpu_init_dmabuf() be called mulmtiple
> times ?
Yes, virtio_gpu_init_dmabuf() can be called multiple times as the Guest VM
creates/uses new resources/Guest blobs, which can happen frequently.
Are you suggesting that it is better to make virtio_gpu_create_udmabuf()
return res->dmabuf_fd explicitly as opposed to the current indirect approac=
h?

Thanks,
Vivek

>=20
>=20
> Thanks,
>=20
> C.
>=20
>=20
> > -            return;
> > +            vfio_create_dmabuf(res);
> > +            if (res->dmabuf_fd < 0) {
> > +                return;
> > +            }
> >           }
> > +
> >           virtio_gpu_remap_dmabuf(res);
> >           if (!res->remapped) {
> >               return;
> > @@ -153,9 +254,7 @@ void virtio_gpu_init_dmabuf(struct
> virtio_gpu_simple_resource *res)
> >
> >   void virtio_gpu_fini_dmabuf(struct virtio_gpu_simple_resource *res)
> >   {
> > -    if (res->remapped) {
> > -        virtio_gpu_destroy_dmabuf(res);
> > -    }
> > +    virtio_gpu_destroy_dmabuf(res);
> >   }
> >
> >   static void virtio_gpu_free_dmabuf(VirtIOGPU *g, VGPUDMABuf
> *dmabuf)


