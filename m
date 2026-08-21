Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69682C5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 02:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxFFT-0000t2-O8; Thu, 20 Aug 2026 22:44:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wxFFQ-0000sr-SZ
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 22:44:49 -0400
Received: from mgamail.intel.com ([192.198.163.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wxFFO-0005fl-GU
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 22:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787280286; x=1818816286;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=o2In/W2f+z5Ignrk/oX0/WAvJ2Jk4Wvi3NqOne15H2Q=;
 b=dBXner4J2GKK3eJqmrGVJe4aJ4x3JcPI3VWBQgcLksJWvtgdBKB/wowb
 BrJ4FbtHdhIn55Sh22bN6ZNyhhWDzQN8F++tkSLTYJKU6B8D2CTZYPUCX
 YI9ICeyQwGThAA/yT3nHXx8I67zJg6VpvIKqrfAENTedUdVkf5EJ7y1J5
 1/fLY6I3gcsA0fP2m7SPNjCevzt1I1qauojpkUDyqanExck5UxikdoCLv
 ZgXlpQLlTDL1CRMLyId7DbTjy6a2TNYOHufG4qVM6wRqjP59PpcEWK9cp
 F3IKPmFS2FaFocycvOs9tfJby8+x7p/TrC5nK2MARpX2BZeCU2RSzDhTV g==;
X-CSE-ConnectionGUID: Rel/ILcjTxaqAxB0HYavvw==
X-CSE-MsgGUID: sF3MxjagSCSGeyASAlTIZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87847207"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="87847207"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 19:44:41 -0700
X-CSE-ConnectionGUID: 0EI83RG2T9ujPgKvVXv3Ww==
X-CSE-MsgGUID: CVX9NQU5SQmgs2VMX91Zpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="269690211"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 19:44:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 19:44:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 19:44:40 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.70) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 19:44:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ny2Fz+b8kww4Fz/LGc+Qa0EdxD6kyp4ngNHwP8RF7zjpF4R6Ti51CBAFYwv0fZKV4BnCNQPOn2U1eZtq5DmxPRBuCODGG3bUjzxAlXlzL4V1OnY3gz0+F+/zbZcKciA8AVq2FU+zt5lXGZ/5Xp0KelJan/R3qV2Cv5LiMDu8Xk/4YNUDvG4aCHWkydRAvwvJrxG5U8jolQxavXnyaDd+EoKSjekHzi1FRcyrSuPaB8Iodv2OP1udqUya0Jy6Vo/10bNo7VUk+7aerHQ4hmnaxYr54VlsY4UJaA1R3E/J7FaDcLBWoyrY7TlikfvuNxMRExKXN+6RSePN3MCsu6uz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2In/W2f+z5Ignrk/oX0/WAvJ2Jk4Wvi3NqOne15H2Q=;
 b=vnHH4yaZkz/c1OJBfymQsDiJClMF4V49q0wNMbwhWecALG6Mmt/49Kp07mPCjOdPtznZiVARyDU0zVIiTnSJBMBAfAtuT5nQiWo9GlfCu5pfZ7ZDLxgMFHjOJ4uNfFJWL99jmiRlWbG2eu8uNUUm0pb8pV5SVmIqsR1kou1lekJC/ZObQ59Gfy5zoTNRGfWWCcpLxrEv0xBp4erX7+g+SH8QEzNxRnsKTYMhF6K7TXKh6zCFUYRyvzfFyHtDDMgUVMbewbzMSRIDqMvj+X/Y104y/luXI79pP+iSLeUv98AiyYLXHO/kJ/7Df/eZP2ypqra7Ba0HBa2AGOndcDAnTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 02:44:24 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 02:44:24 +0000
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
Subject: RE: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Topic: [PATCH v3 0/6] intel_iommu: Enable PRQ support for passthrough
 device
Thread-Index: AQHdJXaoJ2foc7Rrs0CFGZilBc0gdraUUwKAgALNe6CAAAbZgIADRW4wgAAQPYCADWBJkA==
Date: Fri, 21 Aug 2026 02:44:24 +0000
Message-ID: <IA3PR11MB9136C8AC130468162F9EE8A992A32@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <45013c8a3fe7983ee31f52d9d9ba6c176ce98fdb.camel@bull.com>
 <IA3PR11MB9136D461AAF0FCC8D757B33C92DE2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <97d42422c79aaa53a4a3faca5fc04ca75e22042c.camel@bull.com>
 <IA3PR11MB9136F6CEC9314AD408EFFE7992DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
 <2d811cf876963acc75673078a869a63fdccdaf06.camel@bull.com>
In-Reply-To: <2d811cf876963acc75673078a869a63fdccdaf06.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|PH0PR11MB7471:EE_
x-ms-office365-filtering-correlation-id: ea66855e-1a48-4c12-deab-08deff2e1c92
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|18002099003|22082099003|38070700021|4143699003|11063799006|10067099003|56012099006;
x-microsoft-antispam-message-info: FFqu8v2ziUTQPBdPVZKiBe5hmhe3V6FMVX0+SvlHKDTfoZDdKEmVlao7uDxajcdsIAmsSBW5nf+LYQgUeyOtXhUUmhnx3ZuMKGuAGYhHSQGb4bTKm/9kPyEHOB2iYPyPWJInbpWCrC36kurF5I3oS/WeRCdz3GgIkN0ZNA20bOl3IiPyt7fCJ+hxOByq3/l/mqYiniWuZy1eRZNto/2ua18pRQpmv5H2rqeKp0GLr/eVZ+egX+q3vUUGte0cV0LFj8+XkVGAhdQYleHIz5p1nBAg5Heqz17URuqTbUefA+ZlKNMDB3AL6OvWzoBfpcJkohsEV4mkuuENgxwcERpSi+GZ32hFEqTL4GANf4bQEi485K0R/u/U1LE37xycUWlr8TtVJvjz6TYILovyNYJzSgMR8w6bp6nBHq12cTdse7/sU2vNaXoG86QHKy75Ch1+/Rjc+v5Hy5leiytbXl17YWOw8ubm3l343NIAcQc/2Clh/Q7RZLhSynNg3DKRsVwSLOxt9raeqFK9YfE3uUSXaIqOM+I86deClrnY87UZFnbWFvPvkEFLrA3VHR9jsAZiwsN/OrDoe/Y3ZVyhptonJ0b2TXBvusWkCVivUGTD1T6801asz9V52gyqEhX7dAXqGY3pjbX3WWZD9U+A1/bYqFQDWd9hvL9iuIv8zTGLYDaNshqlJrUPVGqG26HoKuq7oUfKt6V1eK5CwCwNe3av89sssT5SgvAgPPZqpCw9AFo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QzJLSGl0THlrN3JBS1dNMlhsN3paYzFsc3hpeDluR25IRm56bFF6eXhsQzFZ?=
 =?utf-8?B?Skx2K2k1RVkxYzBqaVpiVGp5aDhjYVQ0cGpqck5oN1lrMlRLd1VJMnJ0L05P?=
 =?utf-8?B?QTlGckRqT2tvblh1SmxTQWV1Z04xZ1FERG1hSmFmR3RYNFJhWHRUd3Y2VDFO?=
 =?utf-8?B?bEhMY01FK0VjN3J5U1dicmdlMmJGNzNVN2ljYmJqNmJ4NlNDY3B2YlBJMkpp?=
 =?utf-8?B?aTV6SitzVjRjZGFUR3RvMlhPY2IxRms3Y2ZOL2d3c0ZHOEdMQVU1b2tGS2x4?=
 =?utf-8?B?b1AvNmlIYThDTzhPTUlnNnZjOElsQ0x4NG5Yc2FUODhVMGJVZUtRV0hwejhP?=
 =?utf-8?B?NmsrVDg4bGJkYkM1SHRrL281QXhFNDk3Rlk3KzJMYlRzYTlMeEFNRk11bWY1?=
 =?utf-8?B?N2FsdTdjWXJjb1liRU5mQVVYOUpEeHFMZUVNQ3ZvcFVwampadHFDZVlkZFlV?=
 =?utf-8?B?UkNXbzZ6K0QzM3RpUUhBRVpCdkRSVjg2YUx0T2Z1MklqWm4wVWZVTmhXa21o?=
 =?utf-8?B?SG9qZEltSDU1Q3F2YWNLeTI4dUpORzdOMXVDL3dsYWhhWXhLL0JZTTNDWGFi?=
 =?utf-8?B?YmxTK0t1WWFsTUUybFE2bjVVZmhXMnpyakp6QTR1ZmY5eTU0U1MvbVAyU2t4?=
 =?utf-8?B?VTJUN3dtb0dVd2VYQUYxek51R0NCaU11c0k1eUQ3M1Aza1N6ODRlUytnb1VS?=
 =?utf-8?B?TmdQYlFpeUdpdmlHQ2dkenl3R0pxdU0xUmJ4ZGpmbWxOYUhTVy9sc3FSZzRZ?=
 =?utf-8?B?Z1pNdDdGUXFuR1RIMkJTVHlQTkMzZTdjNHNDc3JoZlkzZ2RYNERuYmNEUzVq?=
 =?utf-8?B?RWZnT3ZOQUFDQTRDMFJmYmVNNHRyWkJ0L011WnFkQTNZL2NrbWViQkhQUUVJ?=
 =?utf-8?B?RFpBVVQ0YU1TWE95bTJsdUJqVzRRcEpsQm5zOWRveWFvMEw5bHhQaEV6eWVu?=
 =?utf-8?B?dFBDTFZxY0RsQ1c2L1ZPTm45c1dlSWNWM1ZsMWJoa2FZMTkwdXVndHhOcGUw?=
 =?utf-8?B?WmM0NHFVZXoyWEJFT1hKRjErRnN1QjN0NGc2UTUxUXVHakZaN3pYOVlVYzk2?=
 =?utf-8?B?VE1nRjdYL3BqQUZ4aEp3WXZGZXNKWUdNZWkrdE03ZU1qZVdwMVZaR2JiTFd2?=
 =?utf-8?B?SGZtTVNaVUNEaFJtUi9ocWYvK1ZFRy9LdHZQb2NQZkhvV0ptampPQkcyYlBV?=
 =?utf-8?B?Q1I4RnJEWkhrQ2YwdzdmUUFyaVU2dVphQWdHV1hTc0dlOWg1bmoxakgyaW9i?=
 =?utf-8?B?VTZQdUhicUVqTUdlSjJEVk5sNEg4TEl5NnJpb0FmSXV0c0pmREZUYTZHSExu?=
 =?utf-8?B?L0lWWnhrRE13QVFldGxYYllLQ2pZMXRvTVlOdDJZNGFmSVFzckp3djF3SUhF?=
 =?utf-8?B?MnRENlM1d1lQcUZNaG9qTXFHRCswVzVwSEZlNXRNeW1IOVFVTlJRS3prblBY?=
 =?utf-8?B?dHRtT29GTlRLTUJKbE40elBINjVYeVZBNlhsNHdhOG1CMFNwR3FWKyt3SndE?=
 =?utf-8?B?aVFWNExjejZWSmw3dk1IUDZaR0FIcU16YXRKZDg3YzJKaldKa0hvYmNEYUpk?=
 =?utf-8?B?QWwwYktPQkpHcmpWdEJNdi96RHdLRUFnbEwyb0ZaYW1MWHlRUWVTTzR6VGFZ?=
 =?utf-8?B?RVY1MmdpNzBsT0N1ZVlOZGlPZTlWTlBudVZHajVMc0xBbkZjNXVSOHFBa1pL?=
 =?utf-8?B?UHZRcFNNOUNFdmdKVmd6bFZLeEc1UXhmeDZ0NDdWY1YwbmVobEhabThDS21V?=
 =?utf-8?B?dUgrUVhPWWE3WkZrOVVSSmxNWFUzRXdYSDVPbjFJVDgralAwd1R4VnF0UjZh?=
 =?utf-8?B?Tno1b0RzV1R4Z3FYblJNQ3ZHbWtNTEk4TlFLVHRwMU10aFFOMjhCeDQ3eU1B?=
 =?utf-8?B?d2h1c2NSKyt0eE1qekM0SnhSODhwK25YSFBuazJtWklzOHRFMUc4cjR4VE5s?=
 =?utf-8?B?OHNWZTVjQU82VGh1ZDFyUm1uUDRLd1lIaWYwTE5ZUmMvWitQYUZZVGM0OXI2?=
 =?utf-8?B?cmNKdml6MkVmNzY5czZYQjIwK0JYK01LOGdFQ3Q0T3lWREpVNjdFZmhrRUN2?=
 =?utf-8?B?TnJtS2I3RnhKc1RlT2xYNzM0ZkZRclhvZFloOEVJOUpRVkFxWDkvUjE0SzVu?=
 =?utf-8?B?VGpmTHhBcFB5RGlmOTRLY3pmTEN0RUNYWGNXMkRNbUZiRVBkbWV0S0lnZEV0?=
 =?utf-8?B?aUZRNzJzMTcyT0xwRm96QzM0bjNjWEc0UTJxNkFRb2FwaHlrVC9pWDh0NUh6?=
 =?utf-8?B?YUFaUU8ydFZ0bzB1T2RnNWhraFltSUhmam4vT21ZV21mNkFTNXlic2FEN2tQ?=
 =?utf-8?B?VFdxVERuM042YnJ2dFhoSGQrdEZnZ2NnZFBWZ252UXpZODkrczcvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: A28Fb3CGM6U9CUYr5zUN4+QyP91eR5TGdPPb+Ab0cOaWcwOC7Bw3UV0B5XwgiGLXtlwkICzmiFgCKS5+b+p9rrsiOynBaegzoMf+wWhE52zPvUmIdC+A6GZ9KmMPFeM0nhhtuvs0FHnbQ57dsyM2lrGOD6UJdrvXY059exsv77A8ob2ltKbuHp+BtapuITXOoCrTyshkElw+AinqYEzixN0zIvJb8iPpekXLBDeOwJqQ3cwHgnj21Br33C/Xm7Yh2s2eIsvuUXLPPxdhW4vW2r+us9eCOQ4xf9stJX94DVu1QG4B071m8cOG+UIXsfC9yWr+p2oFP2ri8tbGu67N5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea66855e-1a48-4c12-deab-08deff2e1c92
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 02:44:24.5988 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hegMGakFiMvNskgv7T9c8lVxN4FF7X4l1vEZz96sdRv9iAVw8CxK6BjBWxQJmp8jjzN/Cy5ToUUDNgKw00+y5yApuvPc/XmcKQPOqeY2SjI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.14;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
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

SGkgQ2xlbWVudCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ2zDqW1l
bnQgTUFUSElFVS0tRFJJRiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGJ1bGwuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgMC82XSBpbnRlbF9pb21tdTogRW5hYmxlIFBSUSBzdXBwb3J0IGZv
ciBwYXNzdGhyb3VnaA0KPmRldmljZQ0KPg0KPg0KPk9uIFdlZCwgMjAyNi0wOC0xMiBhdCAxMzoy
NiArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1h
aWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBl
bWFpbA0KPmNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IGlzIHNhZmUuDQo+Pg0KPj4NCj4+DQo+PiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+
PiA+IEZyb206IENsw6ltZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPmRy
aWZAYnVsbC5jb21dKG1haWx0bzpjbGVtZW50Lm1hdGhpZXUtLWRyaWZAYnVsbC5jb20pPg0KPj4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gaW50ZWxfaW9tbXU6IEVuYWJsZSBQUlEgc3Vw
cG9ydCBmb3IgcGFzc3Rocm91Z2gNCj4+ID4gZGV2aWNlDQo+PiA+DQo+PiA+DQo+PiA+IE9uIE1v
biwgMjAyNi0wOC0xMCBhdCAxMDo0OSArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4g
Pg0KPj4gPiA+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50
cyBvciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMNCj5lbWFpbA0KPj4gPg0KPj4gPiBjb21lcyBm
cm9tIGEga25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4g
Pg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPiBIaSBDbGVtZW50LA0KPj4gPiA+DQo+PiA+ID4NCj4+
ID4gPg0KPj4gPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4gPiA+IEZyb206
IENsw6ltZW50IE1BVEhJRVUtLURSSUYgPFtjbGVtZW50Lm1hdGhpZXUtLQ0KPj4gPiA+DQo+PiA+
DQo+PiA+IFtkcmlmQGJ1bGwuY29tXShtYWlsdG86ZHJpZkBidWxsLmNvbSldKG1haWx0bzpbY2xl
bWVudC5tYXRoaWV1LS0NCj5kcmlmQGJ1bGwuY29tXShtYWlsdG86Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGJ1bGwuY29tKSk+DQo+PiA+DQo+PiA+ID4NCj4+ID4gPiA+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMC82XSBpbnRlbF9pb21tdTogRW5hYmxlIFBSUSBzdXBwb3J0IGZvcg0KPnBhc3N0aHJv
dWdoDQo+PiA+ID4gPiBkZXZpY2UNCj4+ID4gPiA+DQo+PiA+ID4gPiBIaSBaaGVuemhvbmcsDQo+
PiA+ID4gPg0KPj4gPiA+ID4gSSB3aWxsIHJlYWQgdGhpcyBzZXJpZXMgZWFybHkgbmV4dCB3ZWVr
Lg0KPj4gPiA+ID4gdGhhbmtzIGZvciB0aGUgcmVzcGluIQ0KPj4gPiA+ID4NCj4+ID4gPiA+IGJ0
dywgcmVsYXRlZCB0byB0aGlzIHdvcms6IGhhdmUgZXZlciBzZWVuDQo+PiA+ID4gPiB2ZmlvX2Rl
dmljZV9nZXRfYXdfYml0cyByZXR1cm5pbmcgNDcgd2hlcmVhcw0KPj4gPiA+ID4gdGhlIGlvbW11
IHN1cHBvcnRzIDQ4PyBUaGlzIGxlYWRzIHRoZSBmb2xsb3dpbmcNCj4+ID4gPiA+IGF3IHRlc3Qg
dG8gZmFpbDoNCj4+ID4gPiA+DQo+PiA+ID4gPiBgYGANCj4+ID4gPiA+IHJldCA9IGhpb2RjLT5n
ZXRfY2FwKGhpb2QsIEhPU1RfSU9NTVVfREVWSUNFX0NBUF9BV19CSVRTLCBlcnJwKTsNCj4+ID4g
PiA+IGlmIChyZXQgPCAwKSB7DQo+PiA+ID4gPiDCoMKgIHJldHVybiBmYWxzZTsNCj4+ID4gPiA+
IH0NCj4+ID4gPiA+IGlmIChzLT5hd19iaXRzID4gcmV0KSB7DQo+PiA+ID4gPiDCoMKgIGVycm9y
X3NldGcoZXJycCwgImF3LWJpdHMgJWQgPiBob3N0IGF3LWJpdHMgJWQiLCBzLT5hd19iaXRzLCBy
ZXQpOw0KPj4gPiA+ID4gwqDCoCByZXR1cm4gZmFsc2U7DQo+PiA+ID4gPiB9DQo+PiA+ID4gPiBg
YGANCj4+ID4gPiA+DQo+PiA+ID4gPiBJIGdvdCB0aGlzIHdoZW4gdHJ5aW5nIHRvIG5lc3QgVk1z
Lg0KPj4gPiA+DQo+PiA+ID4NCj4+ID4gPg0KPj4gPiA+IEkgYW0gdHJ5aW5nIHRvIHJlcHJvZHVj
ZSwgd2hhdCBkZXZpY2UgZGlkIHlvdSBwYXNzdGhyb3VnaD8NCj4+ID4NCj4+ID4NCj4+ID4gSSB1
c2VkIGVkdSBmb3IgdGVzdGluZy4NCj4+ID4gQW4gSSBoYWQgYXctYml0cz00OCBvbiBib3RoIHZt
cy4NCj4+DQo+Pg0KPj4gUmVwcm9kdWNlZCB0aGUgc2FtZSB3aXRoIEwxKGZzdHM9b24pIGFuZCBM
Mihmc3RzPW9mZikuDQo+DQo+TXkgY29uZmlnIGhhcyBmc3RzPW9uIG9uIGJvdGggVk1zLg0KPldo
aWNoIGtlcm5lbCBhcmUgeW91IHVzaW5nPw0KPk1pbmUgaXMgUkhFTDEwLjIgKDYuMTIuMC0yMTEu
Ny4zLmVsMTBfMi54ODZfNjQpDQoNCkluIHRoZW9yeSB3ZSB3aWxsIG5vdCBydW4gaW50byB0aGF0
IGNoZWNrIGlmIGZzdHM9b24gb24gYm90aCBWTXMsIG9uIG15IGVudiBJIHNlZToNCg0KInFlbXUt
c3lzdGVtLXg4Nl82NDogLWRldmljZSB2ZmlvLXBjaSxob3N0PTAwOjA0LjAsaW9tbXVmZD1pb21t
dWZkMDogdmZpbyAwMDAwOjAwOjA0LjA6IEZhaWxlZCB0byBhbGxvY2F0ZSBod3B0OiBPcGVyYXRp
b24gbm90IHN1cHBvcnRlZCINCg0Kd2hpY2ggaXMgZXhwZWN0ZWQgYXMgd2Ugd2FudCBuZXN0aW5n
IHN1cHBvcnQgaW4gTDEgYnV0IGl0IG9ubHkgc3VwcG9ydHMgZnN0cy4NCg0KTXkga2VybmVsIGlz
IDcuMi4wLXJjNiwgUUVNVSBpcyB2MTEuMS4wDQoNCj4NCj4+DQo+PiBJdCdzIGV4cGVjdGVkIGZh
aWx1cmUgYXMgZmlyc3Qgc3RhZ2UgcGFnZSB0YWJsZSBvbmx5IHN1cHBvcnRzIDQ3Yml0IElPVkEg
cmFuZ2VzDQo+PiBhbmQgTDIgd2hpY2ggdXNlcyBzZWNvbmQgc3RhZ2UgcGFnZSB0YWJsZSBzdXBw
b3J0cyA0OGJpdCBJT1ZBIHJhbmdlcywNCj4+IHRoYXQncyBub3Qgc3VwcG9ydGVkLg0KPj4NCj4+
IFRoaXMgaXMgZG9jdW1lbnRlZCBpbiB2dGQgc3BlYyAzLjY6DQo+Pg0KPj4gU29mdHdhcmUgdXNp
bmcgZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24gc3RydWN0dXJlcyB0byB0cmFuc2xhdGUgYW4gSU8g
VmlydHVhbA0KPkFkZHJlc3MgKElPVkEpIG11c3QgdXNlDQo+PiBjYW5vbmljYWwgYWRkcmVzc2Vz
LiBBZGRpdGlvbmFsbHksIHNvZnR3YXJlIG11c3QgbGltaXQgYWRkcmVzc2VzIHRvIGxlc3MgdGhh
biB0aGUNCj5taW5pbXVtIG9mIE1HQVcNCj4+IGFuZCB0aGUgbG93ZXIgY2Fub25pY2FsIGFkZHJl
c3Mgd2lkdGggaW1wbGllZCBieSBGU1BNIChpLmUuLCA0Ny1iaXQgd2hlbiBGU1BNDQo+aXMgNC1s
ZXZlbCBhbmQgNTYtYml0DQo+PiB3aGVuIEZTUE0gaXMgNS1sZXZlbCkuDQo+Pg0KPj4gVGhhbmtz
DQo+PiBaaGVuemhvbmcNCg==

