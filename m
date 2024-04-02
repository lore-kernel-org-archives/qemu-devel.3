Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE2DECD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:26:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrYWz-0008OY-UA; Tue, 02 Apr 2024 03:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rrYWw-0008Nb-HK
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:26:02 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1rrYWt-00040W-De
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712042760; x=1743578760;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FegIS9RvK1OqtfPv7eIKM91g1SUyZfLqyfXE+StD/Js=;
 b=Atkm2SfAgEOgUs8qSLajUSqFTKIIBM//i/UtsjYe964IZMWnKRHch4dH
 QActRLdgabzrA1C2Eo6TenMd8Zk3x5P3IxD6Ja/2e0q11Op6jC9dZ9nWn
 1bmCJzirs5MJO7Ka0+fVD1LjZkDu25+yBL4ivlx8bj67hyHQX2agdxKiO
 BS/yHMfJPR1ZJzI9U7n7aWYoaJuY5YkhKao/Lsf6WrT9abf95PkM11Vrp
 TJC9kpKBUEbsZaLd8iJi59d0i1DlfxrYzP6NPpkG8MqSW60+chrxx1Bmj
 FZ1IHrAsvawxJKr+j+qbUkRlXBLKgT5NE9EcOVqRi6vkJX0SRWlHrClV2 w==;
X-CSE-ConnectionGUID: yO1USs0hTxaqMN8+lfypDA==
X-CSE-MsgGUID: cgDREVPRTW2Jub6yt+eqHQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="24652263"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="24652263"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 00:25:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="41135733"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Apr 2024 00:25:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 00:25:55 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 00:25:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 00:25:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 00:25:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk2m6TAm+iT1EX5/EmByk88b0dl0B+5MclqGnMg3af8nsWOGDz2LD6wFCVVlV6ctyva3UIW5obGQkiqmioOAN34qAagjD5ruF0zpSb8JDdfTsffCse/66ddTMc7/PfPLfg/LCnStXlSybRgtGLUOhx0Mjfu87yRVJEOwVIRDeLNB5dKcVi3WRSfthoabmeVx1p3SmcxkjyvDS7dDQ66K+fGULqrYIJqBOlfwbds6zWgST4KN/X4+hohDNJdzr1wiijC+T/OXIIhBTbWRHwBBK0DZYF1OoR3X4I6VoleDZ33XjQB0zWUkiGGNnHInigKWOq+fwm+97zauqpktN0Rhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FegIS9RvK1OqtfPv7eIKM91g1SUyZfLqyfXE+StD/Js=;
 b=NsKdL/Y7QKHs2fGEQxG1aavVc41nsn7A+ivkdBA1c2xfT50ibxHCyEDAlyKBrNzZL76nRqFFRERwHLT1Mef67CaMW8cr5qvutWvOZpIqSfYN6C0YA8ODM3JA+imBOcbdCLJ8y6dRSTgXF4go/vPg8Lbo5BotiMvkclwYgI0dYyFjF/SK62NjcQtG82cG8MYlohIJwpU8TbxYxd5Pf2o5dnyUNj1WGLIo+X6tZjV3YMjJ/173D3HrUjVaC2tazEFKLB4HWk5azB1UJ3g9u5ALEVfRYRU1Bl6jYE3ZCQNsFi3TIRogqPlMsXC1891MF52rAQdnIphzQ40hTLp35Eky4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 MN6PR11MB8146.namprd11.prod.outlook.com (2603:10b6:208:470::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.25; Tue, 2 Apr 2024 07:25:51 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::55de:b95:2c83:7e6c%7]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 07:25:51 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Wang, Lei4" <lei4.wang@intel.com>, Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>
Subject: RE: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Topic: [PATCH] migration: Yield coroutine when receiving
 MIG_CMD_POSTCOPY_LISTEN
Thread-Index: AQHagYmyxUL+r+eN+kO1eb/5c5VPirFOUHtQgAVLeACAAPZ+AIAAA0og
Date: Tue, 2 Apr 2024 07:25:51 +0000
Message-ID: <DS0PR11MB6373AE29375A2910057CC313DC3E2@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20240329033205.26087-1-lei4.wang@intel.com>
 <DS0PR11MB6373254218DDBF279B13FD79DC3A2@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZgrdIDGe3aNcRu7o@x1n> <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
In-Reply-To: <ce89cb04-65d0-4f43-ad87-ead6e69c1e09@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|MN6PR11MB8146:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tLCokpS2nvM+meaxoFlezip22ANynz+8YFMFRR6YyFOW1BjrLrL4Fab4T4taMHds5v4NOqRxuz8Z4hSPLgT41IwoZdkuu45cYmxhaI3IMu+zbJG84J9uBgobZUodknzdBpQUCPGJu3Wv/fTcXUAve9AXWgePz0IZJGbezn+BaVJ2CVE8sYlJB/6XV0vVc+eKIQLHXxybX6hm1h/AOkglJkkTf9Wlk/R+zy3Z/KiYOIFLZuebEmQe3F3LLAdPvn61WYZEDGFysAmf82UT7dQ1kV1K/P1HH+huY8wCxASpO9d/ye3aZvE/PJ8J8Bb+V2fg3MTh/SYvaFlEdbLFu0r954ggdvjDpn1RETCuUds5YxRY1psXxv06qNZkYn5GCG43VItc9KRdfOD+S9yRSd7yHkqh4cLXyRln3W4uuphki5V+Z8s1/TO4KrZxbRrhFcJENSeYUbrDen9twy2XTMETv0me9zKTbBVOQo0+4NN+sSSnMQJE4qKrU3bwDJeMgV6l3tCdz52pMvAbOPZ9WKfSj6rywFyb0mqIi7OsGqbG/JELflEsAifP1rfTEBg32RW6dhjEaiYTOljNxpZ2Pf40M9XxQCfHtRrLRmTWzQWSSKs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THVhSXJhTjlBNmZDZWlOc0Z2ZHhZMU9mdGcvaFNMeHZZOGUyMWdPTHF6MHZv?=
 =?utf-8?B?bFRNN1Q5NFVpTnVzTWthbkxpbjNWdW5aSUlGaWJSYUNIYTlXc2wwQjF6bm05?=
 =?utf-8?B?WGd2UjA5bEhQYkx6U2piWTF1bERtRHJtcVp3eVZRcllsenpWVGlPRFhJa1lx?=
 =?utf-8?B?V04ybTFTdWZLenR4M1JISkhHcUlWNitkUnQ3N1RFVmpXRi9LWVNwaTRkVEd3?=
 =?utf-8?B?aDlJU2ovSUZINWcrZUtLRHBwdXJpQ3k4d1FoMVFnVWxMQkd3MldZSnFielZw?=
 =?utf-8?B?ZlVOUFZqMWZrS3ZCYVo2aWM4YU9oVkFSck1Mc3JYYU9PZDRqT3ZKS2RHc1Q3?=
 =?utf-8?B?Uk5KOE80Sy9POGswWE5MU2R6MU1BN29UZFRqWWRQTVFWMVdXK1JzRkR5cUJ1?=
 =?utf-8?B?N09vRGlHZUNCZnlLMGxqMHFKWjlUOGwvUm1nOG11cS90YXY2TDkvRmtseGN2?=
 =?utf-8?B?b0RjVWV6dk5kQkJPK2IycldRanQ1MGVCMW50SXdaUmdYa1NXeFRpRnFFZUxB?=
 =?utf-8?B?UUJkK0YwSGtTOUY0NFFSWDhYbFF4RlJKVU5BaDJXZlBqU3RpTURjYlJKb1hH?=
 =?utf-8?B?cWY1UFY3dHhnRWNpUUpTbkVobEw2cDdScDFyK2RHOVg0SElEZHJGTUFSdjNk?=
 =?utf-8?B?cmpjaDJQS2J3V2lXQkV5dDZXb0hQYy9Xb29HWWo2OVNKMmkzWUdyRGRQODRP?=
 =?utf-8?B?ZDQrclpSNE5MbVNCOEw2d3hrNGhEVEJVL1ByYjQ2R05NenI3dFlGUVJBQlRV?=
 =?utf-8?B?SDJpOWNBU2RMNlREbE4wU1dMYmdScFRTN01OQnowQ1k5bk1rYzFML2h3SWxU?=
 =?utf-8?B?dDZrNHFhakRMQnhuWFFmKzBZWXhGWkYvcFp1WkM0WGo4cUxDc1hjMlJpcXVK?=
 =?utf-8?B?bFRDeFNOMHFBbTlOSGxSbHBvTVQxUjFTWlRybys1UGtyREkyOXJRaFVzOTRj?=
 =?utf-8?B?cnJDdzAwN1FScFlRRkxURG9DOGRrRU9rSVdEZUhOczFWblMxUU1hUHFGdHVH?=
 =?utf-8?B?eW0vbjdiM2lYM3hlZlNnR3FwQW9PaWZQQWdLVVdBeTVneHIyMElNYkI0MUZX?=
 =?utf-8?B?R0RTdWtyVUE4RTcrd0ZHOE9ETkpvWkl2dDR5OU5URG9YdlpXVjFBUk02SU44?=
 =?utf-8?B?RE8wM1RKK283T0o0bytvOVI3blhyUzV6SUROWlJqTEVYRU1QN1gyYm9yMGh1?=
 =?utf-8?B?Zlh4YnFLSHNBcExHc3VYL0h6VVR6eHZwNXdxaXFXSndJQyttbjRleVZ5UVlL?=
 =?utf-8?B?aWFrRFB6dk15cDhQNGZ6TGJPU2xUUTV4eWRoaUYrTzJCQmN1OStLc1F0RklJ?=
 =?utf-8?B?engrcjEwSExTWDZ1bXRTWGlSWTNKL0FmMm9yaUM1WEhhZkZKc0d2Y1dIOWZG?=
 =?utf-8?B?bkpMNm5qTlQ5bENCY0I3ZlU0RityT0o5V0c3c0FOVVlHMHROWkptbHNnbzVP?=
 =?utf-8?B?azBrdjZxNzI3RUpEK1JFdFZTTWFCeXNBMkNrMUErTDZVZlFJaDEwNENSSzB4?=
 =?utf-8?B?b1FWK05KQ1BobmxJR1Nkb0RUZUNZQmJ6V3pCaGNCdkFiaG1ESHM3bGhXSERv?=
 =?utf-8?B?QWdwTkRsdUJUN0FqVlg4OUZGc0NwQWNsd1pQSmFHNVF2YzlrMTNwQklsNDBi?=
 =?utf-8?B?bUkvcHpyb2ZSalg5OVFkVGhRbW5mTDMwTUF4Vmw0YWJTTC8rc3lMT0dlUmdF?=
 =?utf-8?B?Q3hPTDBNb0ljdlROeXZXaVhrMG9KYkpoRTBnN3RReDl1K0MrMlVYQkg1RXhr?=
 =?utf-8?B?UFZZSUhGUHozc29QUStESFEwcElMRFMwVjJ4SzFOUGpWNmlPbE1uQlhiaWJP?=
 =?utf-8?B?Zy8wdnE2aXNWS1FSZDdyY3YvdFBmYnk1K2tiV1JQMnpOU0pGMzJ1ZG1WVzRG?=
 =?utf-8?B?Vm1GTWNFU0dVRUNhVTMrMDFuUk0wVGliVERhRDJkcEUxM2xPMnJvZmxybm51?=
 =?utf-8?B?MkJ6WDREc0ZXVG9paFZFYUZZZUdhRWdiUkRlUGxHdUNUYkZjOU9aZm82a0I1?=
 =?utf-8?B?NmZIVzB5U2M2My9Fa0tjWWY3blQ1eDVRQ1EvZ0VTcUx5NStwcU9aQVVlY0w3?=
 =?utf-8?B?ci9ySXFNWGo2dWxod1JTbTBsY0JVZkdVMW9pVGRrVzVsc25mQ3hkRVhWWXBV?=
 =?utf-8?Q?LwGqdFOOJhqtE2cfOOV8d5/AH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2373a10a-1fe6-4b91-3e7b-08dc52e62057
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 07:25:51.7756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P/arBxYXwqv9p7gX0JctM287RvXjtN5XEjvM0QZaWVen7PUoT4UUQQTXsWepyoWaMjJx0ormHwFeooUr6Si8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8146
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=wei.w.wang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

T24gVHVlc2RheSwgQXByaWwgMiwgMjAyNCAyOjU2IFBNLCBXYW5nLCBMZWk0IHdyb3RlOg0KPiBP
biA0LzIvMjAyNCAwOjEzLCBQZXRlciBYdSB3cm90ZTo+IE9uIEZyaSwgTWFyIDI5LCAyMDI0IGF0
IDA4OjU0OjA3QU0gKzAwMDAsDQo+IFdhbmcsIFdlaSBXIHdyb3RlOg0KPiA+PiBPbiBGcmlkYXks
IE1hcmNoIDI5LCAyMDI0IDExOjMyIEFNLCBXYW5nLCBMZWk0IHdyb3RlOg0KPiA+Pj4gV2hlbiB1
c2luZyB0aGUgcG9zdC1jb3B5IHByZWVtcHRpb24gZmVhdHVyZSB0byBwZXJmb3JtIHBvc3QtY29w
eQ0KPiA+Pj4gbGl2ZSBtaWdyYXRpb24sIHRoZSBiZWxvdyBzY2VuYXJpbyBjb3VsZCBsZWFkIHRv
IGEgZGVhZGxvY2sgYW5kIHRoZQ0KPiA+Pj4gbWlncmF0aW9uIHdpbGwgbmV2ZXIgZmluaXNoOg0K
PiA+Pj4NCj4gPj4+ICAtIFNvdXJjZSBjb25uZWN0KCkgdGhlIHByZWVtcHRpb24gY2hhbm5lbCBp
biBwb3N0Y29weV9zdGFydCgpLg0KPiA+Pj4gIC0gU291cmNlIGFuZCB0aGUgZGVzdGluYXRpb24g
c2lkZSBUQ1Agc3RhY2sgZmluaXNoZWQgdGhlIDMtd2F5IGhhbmRzaGFrZQ0KPiA+Pj4gICAgdGh1
cyB0aGUgY29ubmVjdGlvbiBpcyBzdWNjZXNzZnVsLg0KPiA+Pj4gIC0gVGhlIGRlc3RpbmF0aW9u
IHNpZGUgbWFpbiB0aHJlYWQgaXMgaGFuZGxpbmcgdGhlIGxvYWRpbmcgb2YgdGhlIGJ1bGsNCj4g
UkFNDQo+ID4+PiAgICBwYWdlcyB0aHVzIGl0IGRvZXNuJ3Qgc3RhcnQgdG8gaGFuZGxlIHRoZSBw
ZW5kaW5nIGNvbm5lY3Rpb24gZXZlbnQgaW4gdGhlDQo+ID4+PiAgICBldmVudCBsb29wLiBhbmQg
ZG9lc24ndCBwb3N0IHRoZSBzZW1hcGhvcmUNCj4gcG9zdGNvcHlfcWVtdWZpbGVfZHN0X2RvbmUg
Zm9yDQo+ID4+PiAgICB0aGUgcHJlZW1wdGlvbiB0aHJlYWQuDQo+ID4+PiAgLSBUaGUgc291cmNl
IHNpZGUgc2VuZHMgbm9uLWl0ZXJhdGl2ZSBkZXZpY2Ugc3RhdGVzLCBzdWNoIGFzIHRoZSB2aXJ0
aW8NCj4gPj4+ICAgIHN0YXRlcy4NCj4gPj4+ICAtIFRoZSBkZXN0aW5hdGlvbiBtYWluIHRocmVh
ZCBzdGFydHMgdG8gcmVjZWl2ZSB0aGUgdmlydGlvIHN0YXRlcywgdGhpcw0KPiA+Pj4gICAgcHJv
Y2VzcyBtYXkgbGVhZCB0byBhIHBhZ2UgZmF1bHQgKGUuZy4sIHZpcnRpb19sb2FkKCktPnZyaW5n
X2F2YWlsX2lkeCgpDQo+ID4+PiAgICBtYXkgdHJpZ2dlciBhIHBhZ2UgZmF1bHQgc2luY2UgdGhl
IGF2YWlsIHJpbmcgcGFnZSBtYXkgbm90IGJlIHJlY2VpdmVkDQo+ID4+PiAgICB5ZXQpLg0KPiA+
DQo+ID4gT3VjaC4gIFllYWggSSB0aGluayB0aGlzIHBhcnQgZ290IG92ZXJsb29rZWQgd2hlbiB3
b3JraW5nIG9uIHRoZQ0KPiA+IHByZWVtcHQgY2hhbm5lbC4NCj4gPg0KPiA+Pj4gIC0gVGhlIHBh
Z2UgcmVxdWVzdCBpcyBzZW50IGJhY2sgdG8gdGhlIHNvdXJjZSBzaWRlLiBTb3VyY2Ugc2VuZHMg
dGhlIHBhZ2UNCj4gPj4+ICAgIGNvbnRlbnQgdG8gdGhlIGRlc3RpbmF0aW9uIHNpZGUgcHJlZW1w
dGlvbiB0aHJlYWQuDQo+ID4+PiAgLSBTaW5jZSB0aGUgZXZlbnQgaXMgbm90IGFycml2ZWQgYW5k
IHRoZSBzZW1hcGhvcmUNCj4gPj4+ICAgIHBvc3Rjb3B5X3FlbXVmaWxlX2RzdF9kb25lIGlzIG5v
dCBwb3N0ZWQsIHRoZSBwcmVlbXB0aW9uIHRocmVhZCBpbg0KPiA+Pj4gICAgZGVzdGluYXRpb24g
c2lkZSBpcyBibG9ja2VkLCBhbmQgY2Fubm90IGhhbmRsZSByZWNlaXZpbmcgdGhlIHBhZ2UuDQo+
ID4+PiAgLSBUaGUgUUVNVSBtYWluIGxvYWQgdGhyZWFkIG9uIHRoZSBkZXN0aW5hdGlvbiBzaWRl
IGlzIHN0dWNrIGF0IHRoZSBwYWdlDQo+ID4+PiAgICBmYXVsdCwgYW5kIGNhbm5vdCB5aWVsZCBh
bmQgaGFuZGxlIHRoZSBjb25uZWN0KCkgZXZlbnQgZm9yIHRoZQ0KPiA+Pj4gICAgcHJlZW1wdGlv
biBjaGFubmVsIHRvIHVuYmxvY2sgdGhlIHByZWVtcHRpb24gdGhyZWFkLg0KPiA+Pj4gIC0gVGhl
IHBvc3Rjb3B5IHdpbGwgc3R1Y2sgdGhlcmUgZm9yZXZlciBzaW5jZSB0aGlzIGlzIGEgZGVhZGxv
Y2suDQo+ID4+Pg0KPiA+Pj4gVGhlIGtleSBwb2ludCB0byByZXByb2R1Y2UgdGhpcyBidWcgaXMg
dGhhdCB0aGUgc291cmNlIHNpZGUgaXMNCj4gPj4+IHNlbmRpbmcgcGFnZXMgYXQgYSByYXRlIGZh
c3RlciB0aGFuIHRoZSBkZXN0aW5hdGlvbiBoYW5kbGluZywNCj4gPj4+IG90aGVyd2lzZSwgdGhl
IHFlbXVfZ2V0X2JlNjQoKSBpbg0KPiA+Pj4gcmFtX2xvYWRfcHJlY29weSgpIHdpbGwgaGF2ZSBh
IGNoYW5jZSB0byB5aWVsZCBzaW5jZSBhdCB0aGF0IHRpbWUNCj4gPj4+IHRoZXJlIGFyZSBubyBw
ZW5kaW5nIGRhdGEgaW4gdGhlIGJ1ZmZlciB0byBnZXQuIFRoaXMgd2lsbCBtYWtlIHRoaXMNCj4g
Pj4+IGJ1ZyBoYXJkZXIgdG8gYmUgcmVwcm9kdWNlZC4NCj4gPg0KPiA+IEhvdyBoYXJkIHdvdWxk
IHRoaXMgcmVwcm9kdWNlPw0KPiANCj4gV2UgY2FuIG1hbnVhbGx5IG1ha2UgdGhpcyBlYXNpZXIg
dG8gcmVwcm9kdWNlIGJ5IGFkZGluZyB0aGUgZm9sbG93aW5nIGNvZGUNCj4gdG8gbWFrZSB0aGUg
ZGVzdGluYXRpb24gYnVzaWVyIHRvIGxvYWQgdGhlIHBhZ2VzOg0KPiANCj4gZGlmZiAtLWdpdCBh
L21pZ3JhdGlvbi9yYW0uYyBiL21pZ3JhdGlvbi9yYW0uYyBpbmRleCAwYWQ5ZmJiYTQ4Li4wYjQy
ODc3ZTFmDQo+IDEwMDY0NA0KPiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4gKysrIGIvbWlncmF0
aW9uL3JhbS5jDQo+IEBAIC00MjMyLDYgKzQyMzIsNyBAQCBzdGF0aWMgaW50IHJhbV9sb2FkX3By
ZWNvcHkoUUVNVUZpbGUgKmYpICB7DQo+ICAgICAgTWlncmF0aW9uSW5jb21pbmdTdGF0ZSAqbWlz
ID0gbWlncmF0aW9uX2luY29taW5nX2dldF9jdXJyZW50KCk7DQo+ICAgICAgaW50IGZsYWdzID0g
MCwgcmV0ID0gMCwgaW52YWxpZF9mbGFncyA9IDAsIGxlbiA9IDAsIGkgPSAwOw0KPiArICAgIHZv
bGF0aWxlIHVuc2lnbmVkIGxvbmcgbG9uZyBhOw0KPiANCj4gICAgICBpZiAoIW1pZ3JhdGVfY29t
cHJlc3MoKSkgew0KPiAgICAgICAgICBpbnZhbGlkX2ZsYWdzIHw9IFJBTV9TQVZFX0ZMQUdfQ09N
UFJFU1NfUEFHRTsgQEAgLTQzNDcsNg0KPiArNDM0OCw3IEBAIHN0YXRpYyBpbnQgcmFtX2xvYWRf
cHJlY29weShRRU1VRmlsZSAqZikNCj4gICAgICAgICAgICAgIGJyZWFrOw0KPiANCj4gICAgICAg
ICAgY2FzZSBSQU1fU0FWRV9GTEFHX1BBR0U6DQo+ICsgICAgICAgICAgICBmb3IgKGEgPSAwOyBh
IDwgMTAwMDAwMDAwOyBhKyspOw0KPiAgICAgICAgICAgICAgcWVtdV9nZXRfYnVmZmVyKGYsIGhv
c3QsIFRBUkdFVF9QQUdFX1NJWkUpOw0KPiAgICAgICAgICAgICAgYnJlYWs7DQo+IA0KDQpXaGlj
aCB2ZXJzaW9uIG9mIFFFTVUgYXJlIHlvdSB1c2luZz8NCkkgdHJpZWQgd2l0aCB0aGUgbGF0ZXN0
IHVwc3RyZWFtIFFFTVUgKGUuZy4gdjguMi4wIHJlbGVhc2UsIDE2MDBiOWY0NmIxYmQpLCBpdCdz
DQphbHdheXMgcmVwcm9kdWNpYmxlIHdpdGhvdXQgYW55IGNoYW5nZXMgKHdpdGggbG9jYWwgbWln
cmF0aW9uIHRlc3RzKS4NCg0KDQo+ID4NCj4gPiBJJ20gdGhpbmtpbmcgd2hldGhlciB0aGlzIHNo
b3VsZCBiZSA5LjAgbWF0ZXJpYWwgb3IgOS4xLiAgSXQncyBwcmV0dHkNCj4gPiBsYXRlIGZvciA5
LjAgdGhvdWdoLCBidXQgd2UgY2FuIHN0aWxsIGRpc2N1c3MuDQo+ID4NCj4gPj4+DQo+ID4+PiBG
aXggdGhpcyBieSB5aWVsZGluZyB0aGUgbG9hZCBjb3JvdXRpbmUgd2hlbiByZWNlaXZpbmcNCj4g
Pj4+IE1JR19DTURfUE9TVENPUFlfTElTVEVOIHNvIHRoZSBtYWluIGV2ZW50IGxvb3AgY2FuIGhh
bmRsZSB0aGUNCj4gPj4+IGNvbm5lY3Rpb24gZXZlbnQgYmVmb3JlIGxvYWRpbmcgdGhlIG5vbi1p
dGVyYXRpdmUgZGV2aWNlcyBzdGF0ZSB0bw0KPiA+Pj4gYXZvaWQgdGhlIGRlYWRsb2NrIGNvbmRp
dGlvbi4NCj4gPj4+DQo+ID4+PiBTaWduZWQtb2ZmLWJ5OiBMZWkgV2FuZyA8bGVpNC53YW5nQGlu
dGVsLmNvbT4NCj4gPj4NCj4gPj4gVGhpcyBzZWVtcyB0byBiZSBhIHJlZ3Jlc3Npb24gaXNzdWUg
Y2F1c2VkIGJ5IHRoaXMgY29tbWl0Og0KPiA+PiA3Mzc4NDBlMmM2ZWEgKG1pZ3JhdGlvbjogVXNl
IHRoZSBudW1iZXIgb2YgdHJhbnNmZXJyZWQgYnl0ZXMNCj4gPj4gZGlyZWN0bHkpDQo+ID4+DQo+
ID4+IEFkZGluZyBxZW11X2ZmbHVzaCBiYWNrIHRvIG1pZ3JhdGlvbl9yYXRlX2V4Y2VlZGVkKCkg
b3INCj4gPj4gcmFtX3NhdmVfaXRlcmF0ZSBzZWVtcyB0byB3b3JrIChtaWdodCBub3QgYmUgYSBn
b29kIGZpeCB0aG91Z2gpLg0KPiA+Pg0KPiA+Pj4gLS0tDQo+ID4+PiAgbWlncmF0aW9uL3NhdmV2
bS5jIHwgNSArKysrKw0KPiA+Pj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykNCj4g
Pj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvbWlncmF0aW9uL3NhdmV2bS5jIGIvbWlncmF0aW9uL3Nh
dmV2bS5jIGluZGV4DQo+ID4+PiBlMzg2YzUyNjdmLi44ZmQ0ZGM5MmYyIDEwMDY0NA0KPiA+Pj4g
LS0tIGEvbWlncmF0aW9uL3NhdmV2bS5jDQo+ID4+PiArKysgYi9taWdyYXRpb24vc2F2ZXZtLmMN
Cj4gPj4+IEBAIC0yNDQ1LDYgKzI0NDUsMTEgQEAgc3RhdGljIGludA0KPiBsb2Fkdm1fcHJvY2Vz
c19jb21tYW5kKFFFTVVGaWxlICpmKQ0KPiA+Pj4gICAgICAgICAgcmV0dXJuIGxvYWR2bV9wb3N0
Y29weV9oYW5kbGVfYWR2aXNlKG1pcywgbGVuKTsNCj4gPj4+DQo+ID4+PiAgICAgIGNhc2UgTUlH
X0NNRF9QT1NUQ09QWV9MSVNURU46DQo+ID4+PiArICAgICAgICBpZiAobWlncmF0ZV9wb3N0Y29w
eV9wcmVlbXB0KCkgJiYgcWVtdV9pbl9jb3JvdXRpbmUoKSkgew0KPiA+Pj4gKyAgICAgICAgICAg
IGFpb19jb19zY2hlZHVsZShxZW11X2dldF9jdXJyZW50X2Fpb19jb250ZXh0KCksDQo+ID4+PiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHFlbXVfY29yb3V0aW5lX3NlbGYoKSk7DQo+ID4+
PiArICAgICAgICAgICAgcWVtdV9jb3JvdXRpbmVfeWllbGQoKTsNCj4gPj4+ICsgICAgICAgIH0N
Cj4gPj4NCj4gPj4gVGhlIGFib3ZlIGNvdWxkIGJlIG1vdmVkIHRvIGxvYWR2bV9wb3N0Y29weV9o
YW5kbGVfbGlzdGVuKCkuDQo+ID4NCj4gPiBJJ20gbm90IDEwMCUgc3VyZSBzdWNoIHRoaW5nIChu
byBtYXR0ZXIgaGVyZSBvciBtb3ZlZCBpbnRvIGl0LCB3aGljaA0KPiA+IGRvZXMgbG9vayBjbGVh
bmVyKSB3b3VsZCB3b3JrIGZvciB1cy4NCj4gPg0KPiA+IFRoZSBwcm9ibGVtIGlzIEkgc3RpbGwg
ZG9uJ3QgeWV0IHNlZSBhbiBvcmRlcmluZyByZXN0cmljdGVkIG9uIHRvcCBvZg0KPiA+ICgxKQ0K
PiA+IGFjY2VwdCgpIGhhcHBlbnMsIGFuZCAoMikgcmVjZWl2ZSBMSVNURU4gY21kIGhlcmUuICBX
aGF0IGhhcHBlbnMgaWYNCj4gPiB0aGUNCj4gPiBhY2NlcHQoKSByZXF1ZXN0IGlzIG5vdCB5ZXQg
cmVjZWl2ZWQgd2hlbiByZWFjaGluZyBMSVNURU4/ICBPciBpcyBpdA0KPiA+IGFsd2F5cyBndWFy
YW50ZWVkIHRoZSBhY2NlcHQoZmQpIHdpbGwgYWx3YXlzIGJlIHBvbGxlZCBoZXJlPw0KPiA+DQo+
ID4gRm9yIGV4YW1wbGUsIHRoZSBzb3VyY2UgUUVNVSAobm8gbWF0dGVyIHByZS03LjIgb3IgbGF0
ZXIpIHdpbGwgYWx3YXlzDQo+ID4gc2V0dXAgdGhlIHByZWVtcHQgY2hhbm5lbCBhc3luY2hyb3Vu
b3VzbHksIHRoZW4gSUlVQyBpdCBjYW4gY29ubmVjdCgpDQo+ID4gYWZ0ZXIgc2VuZGluZyB0aGUg
d2hvbGUgY2h1bmsgb2YgcGFja2VkIGRhdGEgd2hpY2ggc2hvdWxkIGluY2x1ZGUgdGhpcw0KPiA+
IExJU1RFTi4gIEkgdGhpbmsgaXQgbWVhbnMgaXQncyBub3QgZ3VhcmFudGVlZCB0aGlzIHdpbGwg
MTAwJSB3b3JrLCBidXQNCj4gPiBtYXliZSBmdXJ0aGVyIHJlZHVjZSB0aGUgcG9zc2liaWxpdHkg
b2YgdGhlIHJhY2UuDQo+IA0KPiBJIHRoaW5rIHRoZSBmb2xsb3dpbmcgY29kZToNCj4gDQo+IHBv
c3Rjb3B5X3N0YXJ0KCkgLT4NCj4gCXBvc3Rjb3B5X3ByZWVtcHRfZXN0YWJsaXNoX2NoYW5uZWwo
KSAtPg0KPiAJCXFlbXVfc2VtX3dhaXQoJnMtPnBvc3Rjb3B5X3FlbXVmaWxlX3NyY19zZW0pOw0K
PiANCj4gY2FuIGd1YXJhbnRlZSB0aGF0IHRoZSBjb25uZWN0KCkgc3lzY2FsbCBpcyBzdWNjZXNz
ZnVsIHNvIHRoZSBkZXN0aW5hdGlvbiBzaWRlDQo+IHJlY2VpdmVzIHRoZSBjb25uZWN0KCkgcmVx
dWVzdCBiZWZvcmUgaXQgbG9hZHMgdGhlIExJU1RFTiBjb21tYW5kLCBvdGhlcndpc2UNCj4gaXQg
d29uJ3QgcG9zdCB0aGUgc2VtOg0KPiANCj4gcG9zdGNvcHlfcHJlZW1wdF9zZW5kX2NoYW5uZWxf
bmV3KCkgLT4NCj4gCXBvc3Rjb3B5X3ByZWVtcHRfc2VuZF9jaGFubmVsX2RvbmUoKSAtPg0KPiAg
ICAgCQlxZW11X3NlbV9wb3N0KCZzLT5wb3N0Y29weV9xZW11ZmlsZV9zcmNfc2VtKTsNCj4gDQoN
Clllcy4gQnV0IGFzIG1lbnRpb25lZCBpbiBhbm90aGVyIHRocmVhZCwgY29ubmVjdCgpIGFuZCBh
Y2NlcHQoKSBhcmUgYXN5bmMuDQpTbyBpbiB0aGVvcnkgYWNjZXB0KCkgY291bGQgc3RpbGwgY29t
ZSBsYXRlciBhZnRlciB0aGUgTElTVEVOIGNvbW1hbmQuDQoNCj4gPg0KPiA+IE9uZSByaWdodCBm
aXggdGhhdCBJIGNhbiB0aGluayBvZiBpcyBtb3ZpbmcgdGhlIHNlbV93YWl0KCZkb25lKSBpbnRv
DQo+ID4gdGhlIG1haW4gdGhyZWFkIHRvbywgc28gd2Ugd2FpdCBmb3IgdGhlIHNlbSBfYmVmb3Jl
XyByZWFkaW5nIHRoZQ0KPiA+IHBhY2tlZCBkYXRhLCBzbyB0aGVyZSdzIG5vIGNoYW5jZSBvZiBm
YXVsdC4gIEhvd2V2ZXIgSSBkb24ndCB0aGluaw0KPiA+IHNlbV93YWl0KCkgd2lsbCBiZSBzbWFy
dCBlbm91Z2ggdG8geWllbGQgd2hlbiBpbiBhIGNvcm91dGluZS4uICBJbiB0aGUNCj4gPiBsb25n
IHRlcm0gcnVuIEkgdGhpbmsgd2Ugc2hvdWxkIHJlYWxseSBtYWtlIG1pZ3JhdGlvbiBsb2Fkdm0g
dG8gZG8NCj4gPiB3b3JrIGluIHRoZSB0aHJlYWQgcmF0aGVyIHRoYW4gdGhlIG1haW4gdGhyZWFk
LiAgSSB0aGluayBpdCBtZWFucyB3ZQ0KPiA+IGhhdmUgb25lIG1vcmUgZXhhbXBsZSB0byBiZSBs
aXN0ZWQgaW4gdGhpcyB0b2RvIHNvIHRoYXQncyBwcmVmZXJyZWQuLg0KPiA+DQo+ID4gaHR0cHM6
Ly93aWtpLnFlbXUub3JnL1RvRG8vTGl2ZU1pZ3JhdGlvbiNDcmVhdGVfYV90aHJlYWRfZm9yX21p
Z3JhdGlvbg0KPiA+IF9kZXN0aW5hdGlvbg0KPiA+DQo+ID4gSSBhdHRhY2hlZCBzdWNoIGRyYWZ0
IHBhdGNoIGJlbG93LCBidXQgSSdtIG5vdCBzdXJlIGl0J2xsIHdvcmsuICBMZXQNCj4gPiBtZSBr
bm93IGhvdyBib3RoIG9mIHlvdSB0aGluayBhYm91dCBpdC4NCj4gDQo+IFNhZGx5IGl0IGRvZXNu
J3Qgd29yaywgdGhlcmUgaXMgYW4gdW5rbm93biBzZWdmYXVsdC4NCj4gDQo+ID4NCj4gPj4NCj4g
Pj4gQW5vdGhlciBvcHRpb24gaXMgdG8gZm9sbG93IHRoZSBvbGQgd2F5IChpLmUuIHByZV83XzIp
IHRvIGRvDQo+ID4+IHBvc3Rjb3B5X3ByZWVtcHRfc2V0dXAgaW4gbWlncmF0ZV9mZF9jb25uZWN0
LiBUaGlzIGNhbiBzYXZlIHRoZSBhYm92ZQ0KPiA+PiBvdmVyaGVhZCBvZiBzd2l0Y2hpbmcgdG8g
dGhlIG1haW4gdGhyZWFkIGR1cmluZyB0aGUgZG93bnRpbWUuIFNlZW1zDQo+ID4+IFBldGVyJ3Mg
cHJldmlvdXMgcGF0Y2ggYWxyZWFkeSBzb2x2ZWQgdGhlIGNoYW5uZWwgZGlzb3JkZXJpbmcgaXNz
dWUuIExldCdzDQo+IHNlZSBQZXRlciBhbmQgb3RoZXJzJyBvcGluaW9ucy4NCj4gPg0KPiA+IElJ
VUMgd2Ugc3RpbGwgbmVlZCB0aGF0IHByZV83XzIgc3R1ZmYgYW5kIGtlZXAgdGhlIHBvc3Rwb25l
ZCBjb25uZWN0KCkNCj4gPiB0byBtYWtlIHN1cmUgdGhlIG9yZGVyaW5nIGlzIGRvbmUgcHJvcGVy
bHkuICBXZWksIGNvdWxkIHlvdSBlbGFib3JhdGUNCj4gPiB0aGUgcGF0Y2ggeW91IG1lbnRpb25l
ZD8gIE1heWJlIEkgbWlzc2VkIHNvbWUgc3BvdHMuDQo+ID4NCj4gPiBZb3UgcmFpc2VkIGEgZ29v
ZCBwb2ludCB0aGF0IHRoaXMgbWF5IGludHJvZHVjZSBoaWdoZXIgZG93bnRpbWUuICBEaWQNCj4g
PiB5b3Ugb3IgTGVpIHRyaWVkIHRvIG1lYXN1cmUgaG93IGxhcmdlIGl0IGlzPyAgSWYgdGhhdCBp
cyB0b28gaGlnaCwgd2UNCj4gPiBtYXkgbmVlZCB0byB0aGluayBhbm90aGVyIHNvbHV0aW9uLCBl
LmcuLCB3YWl0IHRoZSBjaGFubmVsIGNvbm5lY3Rpb24NCj4gPiBiZWZvcmUgdm0gc3RvcCBoYXBw
ZW5zLg0KPiANCj4gUGVyIG15IHZlcnkgc2ltcGxlIHRlc3QsIHVzaW5nIHBvc3QtY29weSBwcmVl
bXB0aW9uIHRvIGxpdmUgbWlncmF0ZSBhbiA4RyBWTToNCj4gDQo+ICAgICB3L28gdGhpcyBwYXRj
aDogMTIxbXMgaW4gYXZnIGluIDUgdHJpZXMNCj4gICAgIHcvIHRoaXMgcGF0Y2g6IDExNW1zIGlu
IGF2ZyBpbiA1IHRyaWVzDQo+IA0KPiBTbyBpdCBzZWVtcyB0aGUgb3ZlcmhlYWQgaW50cm9kdWNl
ZCBpcyBub3QgdG9vIGhpZ2ggKG1heWJlIGlnbm9yYWJsZT8pLg0KDQpZb3UgY291bGQganVzdCBt
ZWFzdXJlIHRoZSB0aW1lIGZvciB0aGUgYWRkZWQgcWVtdV9jb3JvdXRpbmVfeWllbGQoKSBwYXJ0
Lg0KVGhlIHRpbWUgd2lsbCBkZXBlbmQgb24gaG93IG1hbnkgZXZlbnRzIGhhcHBlbiB0byBiZSB0
aGVyZSB3YWl0aW5nIGZvciBhIGRpc3BhdGNoLg0K

