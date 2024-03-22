Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EE2C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 16:28:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnhkB-0002Rl-1r; Fri, 22 Mar 2024 12:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnhk9-0002RW-Gp
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:27:45 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rnhk5-0003NP-Ga
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 12:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711124861; x=1742660861;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=z7hX48lLiBGc4jVxfzT+DWmFhIcdqhQnpuPa2Z+TfZU=;
 b=nfpg32tH4fXyWxR/XAnJ5JprXuqqNcKgtrzvNeCc9jW9nea8iwotDNXU
 mRJJl9p06IWRPmk0ST1DKfH2hdHSlD1KWzI6f7rX8XSqy+ExuUX4qmp1E
 qmSyVIwgDK1JBNl+jnqCq+Q6n0jKwjq7eTKmpAblqWs4MGKIEOm5YmrFw
 9AFsMSAYtQJ3W5QULshHiD9WcT3pWDGN5YCxSYGQuR5XAagyAEGD54bDk
 cnTWUSN0S5EC4erL00zmsuaeewu/4HV+n/dIfMGdD+5YygosG7WVHM18d
 2tVoRQusUl+tcSA6wdpeWkLZybj+U5eJw/BEej4HkWI6DH1moj/pzh6Hn g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="23636853"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; d="scan'208";a="23636853"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Mar 2024 09:27:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; d="scan'208";a="15621715"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Mar 2024 09:27:39 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 09:27:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 09:27:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 09:27:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAKOEAvDWORJruLgSL9ApRqh59hPwbPqV3BK6asnm09dXrq6RD2xBHOp1QpGPleG7yJ3HOR1tZe/twgrI+hMiggqByBu/LV6U/B5DCFfXbsZd3XdNNm0sYrbx1MKsvKTV1KvU3dtRlWjyEneGHjJdxIDwjt1oq/4qLQcZQuDba5jzqia0epsNpgdqn3360mAwwpRVevvnn0VR3kXHMV4aHWQCItWaQbhvTozYj2VXfV0/qc9ZQD4nMGT43by+l96SJrM6pAgOXqrI/FeIkn/mN5obrjDGZs0pLWgo0VP+wPH06/OwLM1JxDUIVOzEE7spzsOuW5y8ycD1iYGxfoxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7hX48lLiBGc4jVxfzT+DWmFhIcdqhQnpuPa2Z+TfZU=;
 b=WfqsoeZnT0FzCA8EGGRcul3v2GAhTTli50czHBXGJg1aXV6o2cXjGytwJOQfGmwEG7L/psr5UH14/X9RG2qkhSS8khJnwFa5Bnuw6/j1qbCjow9KZzHPpaI/DsMnbq4w2oOV4DgoF+ZiGTIdGxZyqbdBs4zR3aK5gUI/NwHGCpCJ5ky13f/KncyicV+9DIHPhf4B70mSke1tjIBMcbTcksaeBotChwsa/9+3S8ji+CE8zx1AeVUonUBlnCzgLLkf/hb4lrJDbiHqmSptzVlqvzTX4fO0fHV731ExYtLk+zW7kAlR1RCIu8VUjS/BheLCPk6ixPRPMG0UZICZKh/nDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by PH0PR11MB5925.namprd11.prod.outlook.com (2603:10b6:510:143::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Fri, 22 Mar
 2024 16:27:36 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::6e15:2e:4421:ba9f%4]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 16:27:36 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "philmd@linaro.org"
 <philmd@linaro.org>
Subject: RE: [PATCH v4 1/3] ui/console: Introduce
 dpy_gl_dmabuf_get_height/width() helpers
Thread-Topic: [PATCH v4 1/3] ui/console: Introduce
 dpy_gl_dmabuf_get_height/width() helpers
Thread-Index: AQHae+nd5mVW4P1oVkimniKmCh5PNLFDeHoAgAB57LA=
Date: Fri, 22 Mar 2024 16:27:36 +0000
Message-ID: <PH8PR11MB687962F2C80461AE8CBD6322FA312@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20240321234236.3476163-1-dongwon.kim@intel.com>
 <20240321234236.3476163-2-dongwon.kim@intel.com>
 <CAJ+F1C+UJtiSpx09hq+RRO4GZ9UKuQrqDLAGn8hYayP8pyb5Lw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+UJtiSpx09hq+RRO4GZ9UKuQrqDLAGn8hYayP8pyb5Lw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|PH0PR11MB5925:EE_
x-ms-office365-filtering-correlation-id: 76cfd466-d8f2-45ef-294d-08dc4a8cfbd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xa/TUQiWJx9wLkuFlPY1Plb69c+CIB/hARiVD3pAFYtw+INUDNJymj02uIppo6R0faGRMLtxfSjxROWYge8HLeVkuyduwp4ua3geY0Lq102jHeJNLiuIsmWA6KybtFWuXlxvxf0WyKN9Z7E9of2QBFskpT0MttV6f+exJRkvIJ0VgG0aGwUcYLa1Q8UszJaNcO3qIxtiJSoRCXxCRSy1peRxQFE/bf7yLpXpsH/Q7e2wc/Vyk+hVI2r1ecreVrLMZBF2Hm5X3BehQx6uYmHB9RrQciPK/JcKU9BF5E6ybm0+xcEGgXPom41i0j7vHAsKTLcG58wnRhYQoxJk7VZgwAGKXpdktF7mx+iBFgUKB1r8sBiecgAm6lSTTaI9KjHB5Zc2owlLTYiwRk1IGedYJ3BVrnBLslv4BB1WFbqocLpbXMTn5wIJxsIN7BAPyimSvoLX/86qWmmKW3fowOJvJC1mr4pJ4L7AUYCmSWG+1GvSU1pnMbxzRZdgEaO+tIDH4qMEVkOkJv0X0o7b8BMkZvlLMT7b5kD8C143JOwMvTJqh3A73bi1zUU9tqZv2K3IHlAYiOWN+rUyAMcyS9Iw0FoL94OIAgls+RQzJANWVQ4J3wyO4CKCet04zDp35q8bGpfFv98tsN0lUm/ikLdUfxlZk9LiyiylJA3PO1avcCBQDwLUJOW85vugZSvN6wNZwlHU4/gIeoULfHrKezetAw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SkNVSDc4MFhaZkN2STZnb2FhLzh1Vitkbm4vTUxzQlJ4Vy9INzZFd1YwYjhk?=
 =?utf-8?B?RXU4a1UrTTNGUzlwVzhHNm1LTFVpWkN3UnZYRS8xQVE2UzFnRjd6T0VuaHRz?=
 =?utf-8?B?QmZmYXBhc3hucGV1MG9SVVFCSUo4RE1pRUJqWW5pUGhpL3R3MlJmenQrZ3J3?=
 =?utf-8?B?aXR4amJnNTQvSFFtUENaNTg0ZDc4d3pHWWE5cTVDd2ovdzAwL0hlYWZZTDVj?=
 =?utf-8?B?QjR2WVNUWTk5bUlmSk5Kc3ZoMGRUUG5oTlNhbWdTb0RzRXQ4VTdBb0s0VE9V?=
 =?utf-8?B?cFF6eUZsVG80dGFDamIyZmhrZkdnUXgzV2hRcjFjb3piVEV1U2pEU3NnUVhL?=
 =?utf-8?B?bkNwY1B6QjcwaDBidnRwVk5JbE9RNm1KVGpxUkNDRzczS1orZ0RBWHpUWjd3?=
 =?utf-8?B?dmVJSWlPcXp1d1lPc2gwOGI3Vkk4V0hzY09YS2NRUEx5YldPN3ZkWm9xcmxz?=
 =?utf-8?B?d21ERDU5RnZsVXpVSmtmejU4cGY1dU10bkZCOGVvSE9xakNXRDZUWFRIMlkr?=
 =?utf-8?B?N3lOemY2VjJoam1aalFNVjZFdW9vRFZLUEFiYmVHeEM5cHRvTSttc2Q0aGN6?=
 =?utf-8?B?TlUxVWw1RlpFWklTcTdDZmpNc1RrUTNzRGJTMFdVbHlic010OGF1RitXVktv?=
 =?utf-8?B?VzN1aHJDT0tDM0ZpS0VIOVFOeFJ4Zk56TitzM2hLQ0tNLzcya1IyeHQ5dk1r?=
 =?utf-8?B?QXFBQ2tUcFRGbGZZUXR3WFFrV2pONTR3bHhpb1lJMXJ0NEkxa294VDRCTGxk?=
 =?utf-8?B?V056NDF1a0NzQmZldDBDRGFQSHNGejcxYjZ6ajNYS2UyajNhaGUrUHU0YW1R?=
 =?utf-8?B?dHNFY2hpMm93cGsrVDNzNGRPS215ZDVWMDhuY0ZUUjVvY0tYekpGS2Ryb29J?=
 =?utf-8?B?SFJmMHFtNU0rdUpoVjJNcm5HdU5KVGR5UytZYzFPSzFqNVVlbXlKaDZpbENH?=
 =?utf-8?B?YjQ3LzUvUkUvMll6MjZwQ0lVSDZqT3RieExET3h6bFpldllEM2o3T1FrNGxS?=
 =?utf-8?B?aHAyQzM4ZVp4VktrOVFJamE1dWdnaXhkQ0svSitTaC9XRnNuYkdiZW5Ock80?=
 =?utf-8?B?RVJjRnY0K1lNK25ZOENBVG9zMHpNN3cyQjVOT1FiNmRxa2I4djl4MjVPT1pN?=
 =?utf-8?B?bG45Q3A0M0QvbmRXS21VNkVKMUQ3SGtibnh1d3RJZHlVWGJ3WHdYNzduNXEy?=
 =?utf-8?B?QlpSLzlFekVKODNFaFBWUUdLN2dNTEpHVjJrOUJJakNzZXhxSHBTMjJDSmlv?=
 =?utf-8?B?TFV6V3M3Uk9aN3dXSzZnU1VORXNpNDNDMlRCRUpIbXZKN3lSMjZrcWptNlps?=
 =?utf-8?B?dThPZXlMUURzdlVGWmZjbFhMdnhYTUR6YVAxVHRiazN5RUFqeXBrUXp0aE1E?=
 =?utf-8?B?dCtWM2ROYWMrSWVVMWRad1pnTmxhWU1xazR6UWZ1T25taDlrWStDb0FMK3l1?=
 =?utf-8?B?Q3FkSGtUWk5hV2lnYW5LUGZHcFQ0Ujd1cDJjNFo3ZVdqTWxsMi84TXNGWEFR?=
 =?utf-8?B?R3dqTVZ1UWJLQ0RCV3RYYXo0U2lYellWR0FnalNYUmZ4YVE0d0IzaVB0QWh0?=
 =?utf-8?B?V25hdFlTTTNsL2pORWo1clY3YXgrdmN5VkNpSXowN0IyRHZwK3BZODhJQmRp?=
 =?utf-8?B?dU9NQ01QdFp2QTlUMlhiQjE1cnJEekpNZ2JodmYwcTZ5anJSRlFsYzVpNFdY?=
 =?utf-8?B?U0NUbUNOVXJEaDIwTVpoS2tRdjdhSEZPK05xVkNvNmRIeFNSSGk4K3RNSG9q?=
 =?utf-8?B?SkZRRWRvUkl4QU8vVVB2V3crWUIzb1hadE10WC9CaWcveFVEaWxUNUNVd3d4?=
 =?utf-8?B?cXdIelAwYnNIcENTbVVjY1l1VC9YZGoxWDV1RFR5K2VCQWM4SmVzZTVKNlVy?=
 =?utf-8?B?U1o3U0hUa2RIdG5vMjJac3V4SHFtWndaN2IyY2k1bXdDN3dTMENJZ1FXcEo1?=
 =?utf-8?B?RitROTYxclVDOVlqbXQ3Yyt6ZmpYRUZUTTlmL09PUnlUWHpRUUE3Y0lrOTRi?=
 =?utf-8?B?ZHZNTzhNbkNxNGRtdlNud0xKci9MNDliSGxpRkdXZGc1Z0ZLN3M1YVBQQytM?=
 =?utf-8?B?LzN0bEUrS2piR01QSS82WkI2dnN2ZWtydlY3cE5qdDdFWHFOK1l2UUZXMVl2?=
 =?utf-8?Q?8AJhAWjfriHTmUyA9q9gPrcMw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76cfd466-d8f2-45ef-294d-08dc4a8cfbd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 16:27:36.0525 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gy8TGWD61EMO3Drt52dYaLLIYOlaNrtqxt4qnjp5mx35KhLuC6/bTSEEJ6EvE8FW2ofDSJ2zGZQy0FuTmqz8Mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5925
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.222,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
TWFyYy1BbmRyw6kgTHVyZWF1IDxtYXJjYW5kcmUubHVyZWF1QGdtYWlsLmNvbT4NCj4gU2VudDog
RnJpZGF5LCBNYXJjaCAyMiwgMjAyNCAyOjA2IEFNDQo+IFRvOiBLaW0sIERvbmd3b24gPGRvbmd3
b24ua2ltQGludGVsLmNvbT4NCj4gQ2M6IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgcGhpbG1kQGxp
bmFyby5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NCAxLzNdIHVpL2NvbnNvbGU6IEludHJv
ZHVjZQ0KPiBkcHlfZ2xfZG1hYnVmX2dldF9oZWlnaHQvd2lkdGgoKSBoZWxwZXJzDQo+IA0KPiBI
aSBLaW0NCj4gDQo+IE9uIEZyaSwgTWFyIDIyLCAyMDI0IGF0IDM6NDXigK9BTSA8ZG9uZ3dvbi5r
aW1AaW50ZWwuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IERvbmd3b24gS2ltIDxkb25nd29u
LmtpbUBpbnRlbC5jb20+DQo+ID4NCj4gPiBkcHlfZ2xfZG1hYnVmX2dldF9oZWlnaHQoKSBhbmQg
ZHB5X2dsX2RtYWJ1Zl9nZXRfd2lkdGgoKSBhcmUgaGVscGVycw0KPiA+IGZvciByZXRyaWV2aW5n
IHdpZHRoIGFuZCBoZWlnaHQgZmllbGRzIGZyb20gUWVtdURtYUJ1ZiBzdHJ1Y3QuDQo+ID4NCj4g
DQo+IFRoZXJlIGFyZSBtYW55IHBsYWNlcyBsZWZ0IHdoZXJlIHdpZHRoL2hlaWdodCBmaWVsZHMg
YXJlIHN0aWxsIGFjY2Vzc2VkIGRpcmVjdGx5Lg0KPiANCj4gSWYgd2Ugd2FudCB0byBtYWtlIHRo
ZSB3aG9sZSBzdHJ1Y3R1cmUgcHJpdmF0ZSwgd2Ugd2lsbCBwcm9iYWJseSBuZWVkIHNldHRlcnMu
DQpbS2ltLCBEb25nd29uXSAgSSBhbSB3b25kZXJpbmcgaWYgeW91IGFyZSBzYXlpbmcgd2UgbmVl
ZCBzZXR0ZXJzIGFuZCBnZXR0ZXJzIGZvciBhbGwgaW5kaXZpZHVhbCBmaWVsZHMgYW5kIHVzZSB0
aG9zZSBuZXcgZnVuY3Rpb25zIGluIGFueSBwbGFjZXMgaW4gUUVNVSB3aGVyZSBhbnkgb2YgdGhv
c2UgZmllbGRzIGFyZSBhY2Nlc3NlZCBpbmNsdWRpbmcgdWkvKiAoZS5nLiBndGstZWdsLmMpPyAN
Cg0KPiANCj4gSSBkb24ndCBzZWUgd2h5IHRoZSBmdW5jdGlvbiBzaG91bGQgc2lsZW50bHkgcmV0
dXJuIDAgd2hlbiBnaXZlbiBOVUxMLg0KPiBJbWhvIGFuIGFzc2VydChkbWFidWYgIT0gTlVMTCkg
aXMgYXBwcm9wcmlhdGUgKG9yIGdfcmV0dXJuX3ZhbF9pZl9mYWlsKS4NCltLaW0sIERvbmd3b25d
IFllYWggSSBjYW4gZG8gdGhhdC4gSSB3aWxsIHVwZGF0ZSB0aGF0IHBhcnQuDQoNCj4gDQo+IA0K
PiANCj4gDQo+IA0KPiA+IENjOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+ID4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFyY2FuZHJlLmx1cmVhdUByZWRo
YXQuY29tPg0KPiA+IENjOiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRlbC5j
b20+DQo+ID4gU2lnbmVkLW9mZi1ieTogRG9uZ3dvbiBLaW0gPGRvbmd3b24ua2ltQGludGVsLmNv
bT4NCj4gPiAtLS0NCj4gPiAgaW5jbHVkZS91aS9jb25zb2xlLmggICAgICAgICAgICB8ICAyICsr
DQo+ID4gIGh3L2Rpc3BsYXkvdmlydGlvLWdwdS11ZG1hYnVmLmMgfCAgNyArKysrLS0tDQo+ID4g
IGh3L3ZmaW8vZGlzcGxheS5jICAgICAgICAgICAgICAgfCAgOSArKysrKystLS0NCj4gPiAgdWkv
Y29uc29sZS5jICAgICAgICAgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+
ICA0IGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91aS9jb25zb2xlLmggYi9pbmNsdWRlL3VpL2NvbnNv
bGUuaCBpbmRleA0KPiA+IDBiYzdhMDBhYzAuLjYwNjQ0ODdmYzQgMTAwNjQ0DQo+ID4gLS0tIGEv
aW5jbHVkZS91aS9jb25zb2xlLmgNCj4gPiArKysgYi9pbmNsdWRlL3VpL2NvbnNvbGUuaA0KPiA+
IEBAIC0zNTgsNiArMzU4LDggQEAgdm9pZCBkcHlfZ2xfY3Vyc29yX2RtYWJ1ZihRZW11Q29uc29s
ZSAqY29uLA0KPiBRZW11RG1hQnVmICpkbWFidWYsDQo+ID4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgYm9vbCBoYXZlX2hvdCwgdWludDMyX3QgaG90X3gsIHVpbnQzMl90DQo+ID4gaG90X3kp
OyAgdm9pZCBkcHlfZ2xfY3Vyc29yX3Bvc2l0aW9uKFFlbXVDb25zb2xlICpjb24sDQo+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwb3NfeCwgdWludDMyX3QgcG9zX3kp
Ow0KPiA+ICt1aW50MzJfdCBkcHlfZ2xfZG1hYnVmX2dldF93aWR0aChRZW11RG1hQnVmICpkbWFi
dWYpOyB1aW50MzJfdA0KPiA+ICtkcHlfZ2xfZG1hYnVmX2dldF9oZWlnaHQoUWVtdURtYUJ1ZiAq
ZG1hYnVmKTsNCj4gPiAgdm9pZCBkcHlfZ2xfcmVsZWFzZV9kbWFidWYoUWVtdUNvbnNvbGUgKmNv
biwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUWVtdURtYUJ1ZiAqZG1hYnVmKTsg
IHZvaWQNCj4gPiBkcHlfZ2xfdXBkYXRlKFFlbXVDb25zb2xlICpjb24sIGRpZmYgLS1naXQNCj4g
PiBhL2h3L2Rpc3BsYXkvdmlydGlvLWdwdS11ZG1hYnVmLmMgYi9ody9kaXNwbGF5L3ZpcnRpby1n
cHUtdWRtYWJ1Zi5jDQo+ID4gaW5kZXggZDUxMTg0ZDY1OC4uYTRlYmY4MjhlYyAxMDA2NDQNCj4g
PiAtLS0gYS9ody9kaXNwbGF5L3ZpcnRpby1ncHUtdWRtYWJ1Zi5jDQo+ID4gKysrIGIvaHcvZGlz
cGxheS92aXJ0aW8tZ3B1LXVkbWFidWYuYw0KPiA+IEBAIC0yMDYsNiArMjA2LDcgQEAgaW50IHZp
cnRpb19ncHVfdXBkYXRlX2RtYWJ1ZihWaXJ0SU9HUFUgKmcsICB7DQo+ID4gICAgICBzdHJ1Y3Qg
dmlydGlvX2dwdV9zY2Fub3V0ICpzY2Fub3V0ID0gJmctPnBhcmVudF9vYmouc2Nhbm91dFtzY2Fu
b3V0X2lkXTsNCj4gPiAgICAgIFZHUFVETUFCdWYgKm5ld19wcmltYXJ5LCAqb2xkX3ByaW1hcnkg
PSBOVUxMOw0KPiA+ICsgICAgdWludDMyX3Qgd2lkdGgsIGhlaWdodDsNCj4gPg0KPiA+ICAgICAg
bmV3X3ByaW1hcnkgPSB2aXJ0aW9fZ3B1X2NyZWF0ZV9kbWFidWYoZywgc2Nhbm91dF9pZCwgcmVz
LCBmYiwgcik7DQo+ID4gICAgICBpZiAoIW5ld19wcmltYXJ5KSB7DQo+ID4gQEAgLTIxNiwxMCAr
MjE3LDEwIEBAIGludCB2aXJ0aW9fZ3B1X3VwZGF0ZV9kbWFidWYoVmlydElPR1BVICpnLA0KPiA+
ICAgICAgICAgIG9sZF9wcmltYXJ5ID0gZy0+ZG1hYnVmLnByaW1hcnlbc2Nhbm91dF9pZF07DQo+
ID4gICAgICB9DQo+ID4NCj4gPiArICAgIHdpZHRoID0gZHB5X2dsX2RtYWJ1Zl9nZXRfd2lkdGgo
Jm5ld19wcmltYXJ5LT5idWYpOw0KPiA+ICsgICAgaGVpZ2h0ID0gZHB5X2dsX2RtYWJ1Zl9nZXRf
aGVpZ2h0KCZuZXdfcHJpbWFyeS0+YnVmKTsNCj4gPiAgICAgIGctPmRtYWJ1Zi5wcmltYXJ5W3Nj
YW5vdXRfaWRdID0gbmV3X3ByaW1hcnk7DQo+ID4gLSAgICBxZW11X2NvbnNvbGVfcmVzaXplKHNj
YW5vdXQtPmNvbiwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgbmV3X3ByaW1hcnktPmJ1
Zi53aWR0aCwNCj4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgbmV3X3ByaW1hcnktPmJ1Zi5o
ZWlnaHQpOw0KPiA+ICsgICAgcWVtdV9jb25zb2xlX3Jlc2l6ZShzY2Fub3V0LT5jb24sIHdpZHRo
LCBoZWlnaHQpOw0KPiA+ICAgICAgZHB5X2dsX3NjYW5vdXRfZG1hYnVmKHNjYW5vdXQtPmNvbiwg
Jm5ld19wcmltYXJ5LT5idWYpOw0KPiA+DQo+ID4gICAgICBpZiAob2xkX3ByaW1hcnkpIHsNCj4g
PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9kaXNwbGF5LmMgYi9ody92ZmlvL2Rpc3BsYXkuYw0KPiA+
IGluZGV4IDFhYTQ0MGM2NjMuLmM5NjJlNWY4OGYgMTAwNjQ0DQo+ID4gLS0tIGEvaHcvdmZpby9k
aXNwbGF5LmMNCj4gPiArKysgYi9ody92ZmlvL2Rpc3BsYXkuYw0KPiA+IEBAIC0yODYsNiArMjg2
LDcgQEAgc3RhdGljIHZvaWQgdmZpb19kaXNwbGF5X2RtYWJ1Zl91cGRhdGUodm9pZA0KPiAqb3Bh
cXVlKQ0KPiA+ICAgICAgVkZJT1BDSURldmljZSAqdmRldiA9IG9wYXF1ZTsNCj4gPiAgICAgIFZG
SU9EaXNwbGF5ICpkcHkgPSB2ZGV2LT5kcHk7DQo+ID4gICAgICBWRklPRE1BQnVmICpwcmltYXJ5
LCAqY3Vyc29yOw0KPiA+ICsgICAgdWludDMyX3Qgd2lkdGgsIGhlaWdodDsNCj4gPiAgICAgIGJv
b2wgZnJlZV9idWZzID0gZmFsc2UsIG5ld19jdXJzb3IgPSBmYWxzZTsNCj4gPg0KPiA+ICAgICAg
cHJpbWFyeSA9IHZmaW9fZGlzcGxheV9nZXRfZG1hYnVmKHZkZXYsIERSTV9QTEFORV9UWVBFX1BS
SU1BUlkpOw0KPiA+IEBAIC0yOTYsMTAgKzI5NywxMiBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Rpc3Bs
YXlfZG1hYnVmX3VwZGF0ZSh2b2lkDQo+ICpvcGFxdWUpDQo+ID4gICAgICAgICAgcmV0dXJuOw0K
PiA+ICAgICAgfQ0KPiA+DQo+ID4gKyAgICB3aWR0aCA9IGRweV9nbF9kbWFidWZfZ2V0X3dpZHRo
KCZwcmltYXJ5LT5idWYpOw0KPiA+ICsgICAgaGVpZ2h0ID0gZHB5X2dsX2RtYWJ1Zl9nZXRfaGVp
Z2h0KCZwcmltYXJ5LT5idWYpOw0KPiA+ICsNCj4gPiAgICAgIGlmIChkcHktPmRtYWJ1Zi5wcmlt
YXJ5ICE9IHByaW1hcnkpIHsNCj4gPiAgICAgICAgICBkcHktPmRtYWJ1Zi5wcmltYXJ5ID0gcHJp
bWFyeTsNCj4gPiAtICAgICAgICBxZW11X2NvbnNvbGVfcmVzaXplKGRweS0+Y29uLA0KPiA+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcHJpbWFyeS0+YnVmLndpZHRoLCBwcmltYXJ5LT5i
dWYuaGVpZ2h0KTsNCj4gPiArICAgICAgICBxZW11X2NvbnNvbGVfcmVzaXplKGRweS0+Y29uLCB3
aWR0aCwgaGVpZ2h0KTsNCj4gPiAgICAgICAgICBkcHlfZ2xfc2Nhbm91dF9kbWFidWYoZHB5LT5j
b24sICZwcmltYXJ5LT5idWYpOw0KPiA+ICAgICAgICAgIGZyZWVfYnVmcyA9IHRydWU7DQo+ID4g
ICAgICB9DQo+ID4gQEAgLTMyOCw3ICszMzEsNyBAQCBzdGF0aWMgdm9pZCB2ZmlvX2Rpc3BsYXlf
ZG1hYnVmX3VwZGF0ZSh2b2lkDQo+ICpvcGFxdWUpDQo+ID4gICAgICAgICAgY3Vyc29yLT5wb3Nf
dXBkYXRlcyA9IDA7DQo+ID4gICAgICB9DQo+ID4NCj4gPiAtICAgIGRweV9nbF91cGRhdGUoZHB5
LT5jb24sIDAsIDAsIHByaW1hcnktPmJ1Zi53aWR0aCwgcHJpbWFyeS0+YnVmLmhlaWdodCk7DQo+
ID4gKyAgICBkcHlfZ2xfdXBkYXRlKGRweS0+Y29uLCAwLCAwLCB3aWR0aCwgaGVpZ2h0KTsNCj4g
Pg0KPiA+ICAgICAgaWYgKGZyZWVfYnVmcykgew0KPiA+ICAgICAgICAgIHZmaW9fZGlzcGxheV9m
cmVlX2RtYWJ1ZnModmRldik7DQo+ID4gZGlmZiAtLWdpdCBhL3VpL2NvbnNvbGUuYyBiL3VpL2Nv
bnNvbGUuYw0KPiA+IGluZGV4IDQzMjI2YzVjMTQuLjFkMDUxM2E3MzMgMTAwNjQ0DQo+ID4gLS0t
IGEvdWkvY29uc29sZS5jDQo+ID4gKysrIGIvdWkvY29uc29sZS5jDQo+ID4gQEAgLTExMzIsNiAr
MTEzMiwyNCBAQCB2b2lkIGRweV9nbF9jdXJzb3JfcG9zaXRpb24oUWVtdUNvbnNvbGUgKmNvbiwN
Cj4gPiAgICAgIH0NCj4gPiAgfQ0KPiA+DQo+ID4gK3VpbnQzMl90IGRweV9nbF9kbWFidWZfZ2V0
X3dpZHRoKFFlbXVEbWFCdWYgKmRtYWJ1ZikNCj4gPiArew0KPiA+ICsgICAgaWYgKGRtYWJ1Zikg
ew0KPiA+ICsgICAgICAgIHJldHVybiBkbWFidWYtPndpZHRoOw0KPiA+ICsgICAgfQ0KPiA+ICsN
Cj4gPiArICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICt1aW50MzJfdCBkcHlfZ2xf
ZG1hYnVmX2dldF9oZWlnaHQoUWVtdURtYUJ1ZiAqZG1hYnVmKQ0KPiA+ICt7DQo+ID4gKyAgICBp
ZiAoZG1hYnVmKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIGRtYWJ1Zi0+aGVpZ2h0Ow0KPiA+ICsg
ICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICB2b2lk
IGRweV9nbF9yZWxlYXNlX2RtYWJ1ZihRZW11Q29uc29sZSAqY29uLA0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFFlbXVEbWFCdWYgKmRtYWJ1ZikNCj4gPiAgew0KPiA+IC0tDQo+ID4g
Mi4zNC4xDQo+ID4NCj4gPg0KPiANCj4gDQo+IC0tDQo+IE1hcmMtQW5kcsOpIEx1cmVhdQ0K

