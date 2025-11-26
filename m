Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8917DD1039D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 11:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vODZg-00024A-Ni; Wed, 26 Nov 2025 06:20:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liang1.yang@intel.com>)
 id 1vODZZ-0001wP-Rf; Wed, 26 Nov 2025 06:20:35 -0500
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liang1.yang@intel.com>)
 id 1vODZW-0001wy-TC; Wed, 26 Nov 2025 06:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1764156031; x=1795692031;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=k48Gfy0pA9RzgXlAc4Z25SsfoKzOFDytjE4ODY8oxCI=;
 b=cRLIWbJ8HoJSIoztmAxgAXsJtTVorXslJfYGzgBwv/wEsEObVUjiICEu
 /dvIOElSqIu55+6ITTVBu9B7pgO+eqpor9MDM3OAnwVwCSWDup7GnwIQ1
 e7gNNm0p6dnMLu3VNly5s1oQYnZSZkNBiT5eLP3xG4XtY5ohP5GX60uM2
 qcUa3R7g1MOqgdejcnnpuEGFX4UTCWhbzguu+7efYug/bPweE/krbPgMS
 P8lw/YilFDjx4zRvi52u45AX+PdjQLt0HqZQyywKSBGWenQWRtuYOvvub
 mg5miT+UIwXLT4/bovSeIJcTkLMkz6Z8Rvg5ffpk4+7W6ka+KcRUoc3D1 A==;
X-CSE-ConnectionGUID: AFIBWP7ZSz+A1OULZMzcvA==
X-CSE-MsgGUID: avksWNpxTzyyA8eJYdQxkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="70052949"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="70052949"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 03:20:26 -0800
X-CSE-ConnectionGUID: C0HKSm7fTRKSLNM3zyX9qw==
X-CSE-MsgGUID: bYsvu3UqR/iRn7+3fNZwzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; d="scan'208";a="230172016"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2025 03:20:27 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 03:20:25 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Wed, 26 Nov 2025 03:20:25 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 03:20:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sjyj+UrWjyOoAaag/qs/vy4LuplRBM13kkMKy4YBWhQaZMeHrBUrRTB70KFyWIU5dBky8ouPLrQyjLoqmeJrGOW/yaV4vwIxDQSgN4n8fuwWHNXKfe+JjOfIZ/nZ4pjkZnz5xkKOLh1REdfKKZn0trIWd6e4EEnPovA9dm/ev3LpTv6MYYHSwG/ZzVGDoPWbDfl92o0fFy5SScRAMmdZ/LEfUdiE8wwVss7b8SSVwbqO+2uLXydPppcAoKRkmecF6bcjJi4DFGLQlNmbMOKcP55lQbizBxR/P6o8nPyicAmVF1Jxyo1cyPDzN5Qfd4Nw6g4u+9wzL2tGY2yESRWAzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k48Gfy0pA9RzgXlAc4Z25SsfoKzOFDytjE4ODY8oxCI=;
 b=nox+bbAuH8qY1mkmttG1fOPkhL88YjCHMMg5e27LRMPoNUFS5vvLp0OFMbJ/QJvJouoEXExmcZqmwcpLvcx10bb3DEnwu3BFBwG2t6y1DSx74lxgWznLU7Lht4JjY6Qqq6h7RkFh3aMMAQWz3H80MJ7/9kuVLbb7JGvYk4tdFr94qV2g0Af2DfUF5DpLkcAdJixmdfKyj/0440sjWgnRsHsT585ZJktUvrls0G+IiZx1gvdqeTmPySUAO4d7Ng4QjpQV3eWL4MjbIXPqjmJUcIoqtGUGkOi6KMaw4UlxxMqi/1O52hkjk66oHn5PSNu3MlYeVrNuXMMuZM5ZnefuuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB8291.namprd11.prod.outlook.com (2603:10b6:303:20d::14)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 11:20:18 +0000
Received: from MW4PR11MB8291.namprd11.prod.outlook.com
 ([fe80::fd81:328b:63fd:46f6]) by MW4PR11MB8291.namprd11.prod.outlook.com
 ([fe80::fd81:328b:63fd:46f6%5]) with mapi id 15.20.9343.016; Wed, 26 Nov 2025
 11:20:18 +0000
From: "Yang, Liang1" <liang1.yang@intel.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-stable@nongnu.org"
 <qemu-stable@nongnu.org>, "kraxel@redhat.com" <kraxel@redhat.com>, "Kim,
 Dongwon" <dongwon.kim@intel.com>
Subject: RE: [PATCH] hw/usb/host-libusb: Do not assert when detects invalid
 altsetting
Thread-Topic: [PATCH] hw/usb/host-libusb: Do not assert when detects invalid
 altsetting
Thread-Index: AdxZGlhBGy6gfZiISI+dbcvBgm7OFgEJoLiAAE/pPeA=
Date: Wed, 26 Nov 2025 11:20:18 +0000
Message-ID: <MW4PR11MB82915352467DA0D706DF98CDACDEA@MW4PR11MB8291.namprd11.prod.outlook.com>
References: <MW4PR11MB8291BDD718BE9BB5A160C839ACD4A@MW4PR11MB8291.namprd11.prod.outlook.com>
 <CAFEAcA9J=ETmdptn7cbzsx6hU_EiD+Pmvro+QW-T957vNMCSqw@mail.gmail.com>
In-Reply-To: <CAFEAcA9J=ETmdptn7cbzsx6hU_EiD+Pmvro+QW-T957vNMCSqw@mail.gmail.com>
Accept-Language: en-SG, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB8291:EE_|PH0PR11MB7542:EE_
x-ms-office365-filtering-correlation-id: 991987e3-bb62-432f-4570-08de2cddc7b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?anM0RmFjclVqd2ZDaXcvYkN1MVNuaVcvbEowS2hjdS9uS3AvVUNLWFNHSUgr?=
 =?utf-8?B?aGh3dTFMcUhXbmFvT3p2UEN2OHlMd2l4YnZUZ0VQNzBVZ09PMCtJRWJYSldQ?=
 =?utf-8?B?MENVdGpHVi9MYkZ4eExRbm91R1RyRW1wa0k3YWxiV3daejh0aVEyMmZ6WWdj?=
 =?utf-8?B?cWlXQ1dkeUFZQVY1R2pRVnhiaThVTmhWNFhyTjZsZS9yUGV5NmJUYzhPemhW?=
 =?utf-8?B?bWQ4dE9OS1gyVlpqdk0xVGdHYUcveHZCTVpMY05sYkJpak9TTGJvVVBTYWFI?=
 =?utf-8?B?Q1dzYUNXNi9BN3BJbE9lMjh3T3hXaGd6aTllTGFrems0ZWNGdWdHZmZnd0Q1?=
 =?utf-8?B?V0VZdENhaDZNK20rNW12azBDYnNzYzcyNkZSeVMrays3Y25uZzd1RkVuN05R?=
 =?utf-8?B?YUZjeDJQY0Y3U09ReVp5a3grQ3FqWGZFSXlLN3piZkpnemxjNCt2eWk5N1pK?=
 =?utf-8?B?WFVUeG02Kzg5dzRBc256RlRSa1piV09kZ0NxRko0aW5iajJBMWtzRmJ4Q25H?=
 =?utf-8?B?emZqRkJFbnFMdW9wUStwdjkyZGRiNHdjTzlnaUxaTzhhVzZad25Hd245NGFG?=
 =?utf-8?B?YW5GcU42cnZJV05TUUREcHBBKzVSaXgxeWh3WExoY1plTURxMVZ2cVg5ZUsw?=
 =?utf-8?B?enIrRDlsTys2NC9DbjgxWExnTyt0WXcvcXdCdUNQRzdHVVRmVk5NUzVrSmkw?=
 =?utf-8?B?QTNMR1VKWEE4ay9WalZoT1BkZUs4WmNOVk05RjdxclNsdWQzT29ZaDNnd2xH?=
 =?utf-8?B?WDNYZ3h4eFIySWp5aXpQUk0vbVJKM011OEJrSG8wdVljdmFURGFIOXFKWjBi?=
 =?utf-8?B?SlFrZTVtMElCY1U1TWY3SDhCR3E4cEJMYWNlRUVZZldsSjE2UUJMVGNlQ0RV?=
 =?utf-8?B?UlFZS1FYbWZVcnFkVi84aGl5QXhHTWJMM3N6YWhjRWtjN2ZzRE4rRFRxR2VV?=
 =?utf-8?B?RkRxNTBtMjNVRVNFWGJCTytQaTR6MzVJKzlLc0hxMmpraFZSVHFFMUJ6aW8y?=
 =?utf-8?B?SDVuUGtJRG5JbWM2aHlKaHdZVGQyckw5N0dlU1pOVjZ4WkZlK09HUDdYY2Zm?=
 =?utf-8?B?UmxHYXZ5aWxTRkpWN3cycm56NUh3U3k5UG9jM3ozelZjSWJjVEV1dElqYXBI?=
 =?utf-8?B?SjZGK2wxUSszZG9OMXdSY2h4MzkvRmdxcGY1aTIvMHI1UzhMQVdHQi9ReXRL?=
 =?utf-8?B?N0hOZVpWYmwybnNQYThEY25vRlFPV1BRcXYyQmhBMkt3M3pDdldLYmRRWnlD?=
 =?utf-8?B?N3VDc0xldTVXNzdoNHJJUzVlcTY3RzlWQ0VZaFZuWFlGTzZObHZ5UUVnS0c2?=
 =?utf-8?B?ajdYblB1dnBsQ1JvMVN2alJ0MENBdmdBbEgvdVdHNDBZNUtLTk8zb1B1b1BO?=
 =?utf-8?B?dEZqU0kyL3NndnVMOEtHaW1lUUZzQVhtN05rOGF5VVZuSmErY1k4NVBKQlNS?=
 =?utf-8?B?SE1ueDJjSjVaMmxEU0RTenNPQWtzaGN0RmEwZVB0ZjJUUm9Md2lkOEFxTUJ4?=
 =?utf-8?B?KzdQZDRST0wyejYvdVJQRWN2enAwWWJIcnVGek9FOGN4NXFMNDFKMG9iOERE?=
 =?utf-8?B?YnJTRmFOK2JTUFlPUVJYanptc3B2QWVqcEF6anZWZGRDMW10K0Y4cG1XclM5?=
 =?utf-8?B?M0ZHc0F1LzQ4b0NOTk1QdUIvMG1rZDBKT2tZMTZMa0NqZkNOL2YrVnBrUlJw?=
 =?utf-8?B?Y2d5Q1VjM055MDNGTnRvR1lNdnhMazU0bU11c1cwNzk0VkhXZHh0RXNHNk1n?=
 =?utf-8?B?UjBpY0lSTWd6cGFMZ2pZc1hKYUl6ZzZNZ2psd2FxUVFvT3Y1NjIrSDFhTklB?=
 =?utf-8?B?bG5tNzdBUE5oNUlTVTB6WE5NT0JtYXpIWTZEWFAwWWVCNFcvWGRYV3JlNGJr?=
 =?utf-8?B?akxmbS9Gc0xPaG9nQ0VMVGQyMCsyQmFraEl2ak96TnhydmdQY3hSdHl6aUVi?=
 =?utf-8?B?TVR3NHVNdVdZOVJKNkx5RCtlSTdBbXFIeG5VZXd3Y2pZYlhiZmdIS0FZTmlW?=
 =?utf-8?B?M2YzYVU5Z051ZlQ0ZFgxV2ZndG9IQkZ1ZG1MSGxhYks2bFNzZ1dES2M5OVZs?=
 =?utf-8?Q?jHcjU9?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB8291.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WWhhWDlDTXVRRldscVNnN2FZK3NKTDJDREg3RTd4cFk3Vno3R1RkNm11QURP?=
 =?utf-8?B?dllCN3pQR3pHUkUrZThaaHRycmFXM0tLYmV6NzdrNkhnNnNqeDhSSm8xTXRh?=
 =?utf-8?B?U3hPMnZGTUdCV0VyWGNweGZXL2lIRDhQdDJxdlVlUTdQUUsrM3dJV09Oc3Y4?=
 =?utf-8?B?S3lkNzJlRzVFN2pKNjZxdndQaVFvN1Vwa3l2RFBad0VwQllSQ0k2U0hpZDlz?=
 =?utf-8?B?d01KK1FybXk1SStKWm81TGxBbWwxTTAxWU5vNnJaYUd5dlhBeStWZloxaTZ5?=
 =?utf-8?B?bnNXSWV5TDNEN0sybFVuKzVNQmwvMlV3ZzZCeFVOS3FiY0NUZk1SeFF2Z2hJ?=
 =?utf-8?B?N2FUTS9RcGlkK3lQcTVNR2NqcjBhRG5QaFp6czJOUno1ZSt3V1p2Z2gzcEo5?=
 =?utf-8?B?Z2p6SElSQStpS0E2ODRqYzJGdWRlNFZ4NnBNOHJ4eTJFVHV4NitzaldOLzds?=
 =?utf-8?B?RXB3L2Q1ZVRwckN0L0tHUUY2dFIvVC9tVElPWkFQVXdPY2d3bG5xUUVkT0da?=
 =?utf-8?B?cU5oc29lTnZpWDE2Vi9sbzFpTlVaWk5YTkh5dy9USC9Gb2NlMWtvaFk4eTFD?=
 =?utf-8?B?dEZNYVRYYVVJaWZWMFpuNE9VMmZwUXFyWWhHNUsxM3pXb3h4emF6aTdVZ1gw?=
 =?utf-8?B?Z3ZGYmFtRUFpVFdmVElGNjErWFVHN0JaTXN2Z2Ria3k1VXJmbDc1b1VjcHRE?=
 =?utf-8?B?YnBsZnFvNlk3aTlBQlh6Y0cyU1Azb0lralYzNjdsVWZaek5QbThzdEtoSVk3?=
 =?utf-8?B?T3Q5YmFkZ3J1aGZiRnBOWEdsSzZEeTgrYnk5TjB5MitTNVZaQUxLbzdpc08w?=
 =?utf-8?B?aUVJNGNkSFV4U2Q0ZllkYmNCZ1EyclJvcXJ0czFOU0RoVEJGOTExRHdzQStL?=
 =?utf-8?B?dFIrQ3A1YTdlb1VaWjdyU3owa2p2eGltWEZLL0ZOZU1zcVg4OVFtL1VEdkdY?=
 =?utf-8?B?Yk4zTnJSbE9TeVZQcmRtVk9LSktURGIvWkxRTTJDREJTTDNoc0lNanVGc2t3?=
 =?utf-8?B?dzR4U3F4QmYvMFdVbHZ1RytHcUdUdlNzQVVhODdKbldqSEpneTc3Z2REaU44?=
 =?utf-8?B?YUl2Nk9OYnZFVUYyTXBhblpDbmRZdFZvQ1d2YkNWRytsdkxybUQ2R1BaM001?=
 =?utf-8?B?QUVyZlY0NExzb3FBSnkwN1k2cXNOZmFLOFFxazdRbStLbU03cVorTmtkUy8x?=
 =?utf-8?B?dGhYcVlWNVhaZSsyNFppODByQU5OeU5tWVZzZ216WFo1NVJQS2ZCcmZkdW1U?=
 =?utf-8?B?TVdSRjRwY2J1K1hCUHE1SVVJVVRqQUxEQjZtNU9OUDMxNTArMHVKQ1ZCNEwx?=
 =?utf-8?B?cHh4OFU1YnhveFljN3lnMCtPbVhDa096b1c3V1N5ZE41elhzeUUwNHJES25P?=
 =?utf-8?B?V2NuaEw4MGNGdzhvb3FGYzJ3QnZDZm9DajNSRUZaL3ZFVml0VGc5dWNsRCt6?=
 =?utf-8?B?c3lQelF6bHQyc3cyWTBodk5XMkwySWZIWnJVMTJHUDRPcWZLV0NWanZJeHpH?=
 =?utf-8?B?alE0djRBbDVBNWRRL1hzMkRCWmR0clFyMkliT00rNnRuWDlGVWdhUWxlcC8w?=
 =?utf-8?B?N283TjUybFJyeDNWNVkyZXFkd3NZQUNUOC81Q0JQZGVUZE5KQ01SYU5WTnkr?=
 =?utf-8?B?cEdNdEV5ZmNYUDJGSXR6WEloZXI3L3ptZXVDNS9JUXdEelVqbG55MEVKRDBv?=
 =?utf-8?B?dExZWmhZMjRZY2NwSC9iajVablM1SDZKTVgvUFpZdi84eXRSUFE3Qm1GbUpX?=
 =?utf-8?B?ZHNxUzNyUXd4RXBuc2lCUkhvQTF1Q3JoeFFoalFPZXhONzhybUxxWDl3bzVu?=
 =?utf-8?B?am5TUFVtSTczdm44MWcyWEJZTmF0aHJ6VGhBaCtZNFNoWWN4K0tRZkZ4N3ds?=
 =?utf-8?B?em54ak5ST0lhbEgzOS93dWJQMXlBWFhDaEVrZW9tYUpYTk1wOUtmaUJGTmlp?=
 =?utf-8?B?WE9JK0hpSGJMTHBQMkVEMWF2aWMwcXVDNWxuaFp4UzNGenE4b3Q5ajIzYytX?=
 =?utf-8?B?Vnk1Rm8xNlIyUGlhL05zYmVYZG5wQ3B0TmxycXR4ellkaUllTU5XNUlyVUE1?=
 =?utf-8?B?Z3hTY3J3bnc2U05HbGJjMWwwNWxwTUVSa1hTMmZsOEZRaXFZUHVZNHhhMHE2?=
 =?utf-8?Q?p9KFuiKubKP9IlEK2e13ff9Sr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB8291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991987e3-bb62-432f-4570-08de2cddc7b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2025 11:20:18.3211 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: job2hkHTsIBD6NxeCtl7izNJJnKMfdjj0H+zSX5Sg+zpZVscPvCHJLQqeGDCW/Lq1oOqIgK8g677xF7cZQ4fpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=liang1.yang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.152,
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

SGkgUGV0ZXIsDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHRoZSByZXZpZXcgYW5kIHRoZSBk
ZXRhaWxlZCBjb21tZW50cyENClBsZWFzZSBzZWUgbXkgY29tbWVudHMgZW1iZWRkZWQgYmVsb3cg
YW5kIEkgd2lsbCB1cGRhdGUgdGhlIHBhdGNoIGFjY29yZGluZ2x5Lg0KDQpCZXN0IHJlZ2FyZHMs
DQpZYW5nIExpYW5nDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQZXRlciBN
YXlkZWxsIDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+IA0KU2VudDogTW9uZGF5LCBOb3ZlbWJl
ciAyNCwgMjAyNSA4OjUwIFBNDQpUbzogWWFuZywgTGlhbmcxIDxsaWFuZzEueWFuZ0BpbnRlbC5j
b20+DQpDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBxZW11LXN0YWJsZUBub25nbnUub3JnOyBr
cmF4ZWxAcmVkaGF0LmNvbTsgS2ltLCBEb25nd29uIDxkb25nd29uLmtpbUBpbnRlbC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBody91c2IvaG9zdC1saWJ1c2I6IERvIG5vdCBhc3NlcnQgd2hl
biBkZXRlY3RzIGludmFsaWQgYWx0c2V0dGluZw0KDQpPbiBUaHUsIDIwIE5vdiAyMDI1IGF0IDA1
OjI3LCBZYW5nLCBMaWFuZzEgPGxpYW5nMS55YW5nQGludGVsLmNvbT4gd3JvdGU6DQo+DQo+IERl
YXIgUUVNVSBtYWludGFpbmVycywNCj4NCj4NCj4NCj4gSSB3b3VsZCBsaWtlIHRvIHN1Ym1pdCBh
IHBhdGNoIGZvciBwcmV2ZW50aW5nIHRoZSBndWVzdCBWTSBjcmFzaCBjYXVzZWQgYnkgdGhlIGFz
c2VydGlvbiBmYWlsdXJlIGluIHVzYl9ob3N0X2VwX3VwZGF0ZSgpIGR1cmluZyBVU0IgaG90cGx1
Zy91bnBsdWcgb24gaG9zdCBwYXNzdGhyb3VnaC4NCj4NCj4NCj4NCj4gUUVNVSBpc3N1ZSBzdWJt
aXR0ZWQ6DQo+DQo+IGh0dHBzOi8vZ2l0bGFiLmNvbS9xZW11LXByb2plY3QvcWVtdS8tL2lzc3Vl
cy8zMTg5DQo+DQo+DQo+DQo+IFBsZWFzZSBoZWxwIHRvIHJldmlldyBiZWxvdyBwYXRjaCwgdGhh
bmtzIQ0KDQpIaTsgdGhhbmtzIGZvciB0aGlzIHBhdGNoLiBJIGRvbid0IHJlYWxseSBrbm93IG91
ciBVU0Igc3Vic3lzdGVtLCBzbyB0aGlzIGlzIG1vcmUgc29tZSBzdXJmYWNlLWxldmVsIGNvbW1l
bnRzIHJhdGhlciB0aGFuIGFuIGluLWRlcHRoIHJldmlldy4NCg0KKFBTOiBmb3IgZnV0dXJlIHBh
dGNoIHN1Ym1pc3Npb25zLCBpdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHlvdSBjb3VsZCBzZW5kIHRo
ZW0gYXMgcGxhaW4gdGV4dCwgbm90IEhUTUwgZW1haWxzLikNCg0KWUw6IFRoYW5rcywgd2VsbCBu
b3RlZC4NCg0KPiBkaWZmIC0tZ2l0IGEvaHcvdXNiL2hvc3QtbGlidXNiLmMgYi9ody91c2IvaG9z
dC1saWJ1c2IuYyBpbmRleCANCj4gNjkxYmM4ODFmYi4uM2EwOGNhYWZhNSAxMDA2NDQNCj4gLS0t
IGEvaHcvdXNiL2hvc3QtbGlidXNiLmMNCj4gKysrIGIvaHcvdXNiL2hvc3QtbGlidXNiLmMNCj4N
Cj4gQEAgLTg4NSw2ICs4ODUsMTUgQEAgc3RhdGljIHZvaWQgdXNiX2hvc3RfZXBfdXBkYXRlKFVT
Qkhvc3REZXZpY2UgKnMpDQo+ICAgICAgdHJhY2VfdXNiX2hvc3RfcGFyc2VfY29uZmlnKHMtPmJ1
c19udW0sIHMtPmFkZHIsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbmYt
PmJDb25maWd1cmF0aW9uVmFsdWUsIHRydWUpOw0KPg0KPiArICAgIC8qIExvZyBhbmQgc2tpcCBp
ZiBjb25maWd1cmF0aW9uIGlzIE5VTEwgb3IgaGFzIG5vIGludGVyZmFjZXMgKi8NCg0KVGhpcyBj
b21tZW50IHNheXMgd2hhdCB0aGUgY29kZSBkb2VzLCB3aGljaCBpcyBub3QgdmVyeSB1c2VmdWwu
DQpNb3JlIGhlbHBmdWwgaXMgdG8gc2F5ICp3aHkqIHRoZSBjb2RlIGRvZXMgc29tZXRoaW5nLg0K
DQpZTDogQWdyZWUsIHdpbGwgdXBkYXRlIGFjY29yZGluZ2x5Lg0KDQo+ICsgICAgaWYgKCFjb25m
IHx8IGNvbmYtPmJOdW1JbnRlcmZhY2VzID09IDApIHsNCg0KV2h5IGFyZSB3ZSB0ZXN0aW5nIGNv
bmYgZm9yIE5VTEwgaGVyZT8gV2UgYWxyZWFkeSBkZXJlZmVyZW5jZSBpdCBpbiB0aGUgbGluZSBh
Ym92ZSwgc28gdGhpcyBpcyB0b28gbGF0ZSB0byBjaGVjayBpZiB3ZSBuZWVkIHRvLg0KV2UgZ2V0
IGNvbmYgYnkgY2FsbGluZyBsaWJ1c2JfZ2V0X2FjdGl2ZV9jb25maWdfZGVzY3JpcHRvcigpLA0K
YW5kIEkgZG9uJ3QgdGhpbmsgdGhhdCB3aWxsIHNldCBjb25mIHRvIE5VTEwgaWYgaXQgc3VjY2Vl
ZHMsIHNvIGl0IGxvb2tzIHRvIG1lIGxpa2Ugd2UgZG9uJ3QgbmVlZCB0byB0ZXN0IGZvciBOVUxM
Lg0KDQpZTDogQWdyZWUsIHdpbGwgcmVtb3ZlIHRoZSBjaGVjayBmb3IgY29uZj09TlVMTC4NCg0K
PiArICAgICAgICB3YXJuX3JlcG9ydCgidXNiLWhvc3Q6IGlnbm9yaW5nIGludmFsaWQgY29uZmln
dXJhdGlvbiAiDQo+ICsgICAgICAgICAgICAiZm9yIGRldmljZSAlcyAoYnVzPSUwM2QsIGFkZHI9
JTAzZCkiLA0KPiArICAgICAgICAgICAgdWRldi0+cHJvZHVjdF9kZXNjID8gdWRldi0+cHJvZHVj
dF9kZXNjIDogInVua25vd24iLA0KPiArICAgICAgICAgICAgcy0+YnVzX251bSwgcy0+YWRkcik7
DQo+ICsgICAgICAgIHJldHVybjsNCg0KVGhpcyBpcyBzb21ldGhpbmcgd2UgYWxyZWFkeSBnZXQg
d3JvbmcgaW4gYSBsb3Qgb2YgdGhlIGVycm9yLWV4aXQgcGF0aHMgb2YgdGhpcyBmdW5jdGlvbiwg
YnV0IHdlIG5lZWQgdG8gZnJlZSB0aGUgY29uZiBkZXNjcmlwdG9yIHdpdGggbGlidXNiX2ZyZWVf
Y29uZmlnX2Rlc2NyaXB0b3IoKS4NCihJZiB5b3Ugd2FudGVkIHRvIGluY2x1ZGUgYSBwYXRjaCB0
byBmaXggdGhvc2UgZXhpc3RpbmcgbGVha3MgdGhhdCB3b3VsZCBiZSBncmVhdC4pDQoNCllMOiBJ
IHNlZSwgbGV0IG1lIGNoZWNrIGFuZCBzZWUgaWYgY2FuIGNyZWF0ZSBhIHBhdGNoIHRvIGZpeCB0
aG9zZSBsZWFrcy4NCg0KV2UgYWxyZWFkeSBpZ25vcmVkIGEgYk51bUludGVyZmFjZXM9PTAgY29u
ZmlnIChiZWNhdXNlIHRoZSByZXN0IG9mIHRoZSBmdW5jdGlvbiB3b3VsZCBqdXN0IGRvIG5vdGhp
bmcpLCBzbyB0aGUgb25seSBjaGFuZ2UgaGVyZSBpcyB0byB3YXJuIGFib3V0IGl0Lg0KDQooMSkg
SGF2ZSB5b3Ugc2VlbiB0aGUgYk51bUludGVyZmFjZXM9PTAgc2l0dWF0aW9uIGluIHJlYWwgbGlm
ZT8NCg0KWUw6IE5vLCBJIGhhdmUgbm90IHNlZW4gKG9yIG5vdGljZWQpIHRoaXMgaW4gcmVhbCB0
ZXN0aW5nLCBidXQgSSB0aGluayBpdCdzIGdvb2QgdG8gaGF2ZSBlc3BlY2lhbGx5IGR1cmluZyB2
ZXJ5IGZhc3QgVVNCIGhvdC11bnBsdWcvaG90LXJlcGx1Zy4NCg0KKDIpIFRoaXMgaXMgdW5yZWxh
dGVkIHRvIHRoZSBvdGhlciBoYWxmIG9mIHRoZSBwYXRjaCwgc28gaXQgc2hvdWxkIGJlIGl0cyBv
d24gcGF0Y2ggKGkuZS4gb25lIHdoaWNoIGp1c3Qgc2F5cyAid2FybiBhYm91dCB0aGlzIGtpbmQg
b2YgaW52YWxpZCBkZXZpY2UgcmF0aGVyIHRoYW4gc2lsZW50bHkgaWdub3JpbmcgaXQiKS4NCg0K
WUw6IFRoaXMgaXMgZm9yIHByZXZlbnRpbmcgdGhlIHBvdGVudGlhbCBhc3NlcnQsIGJ1dCB3ZSBj
YW4gc2VwYXJhdGUgaXQgaW50byBhbm90aGVyIHBhdGNoIG9yIGp1c3QgcmVtb3ZlIGl0IGlmIGl0
IGlzIHJlYWxseSBub3QgcmVxdWlyZWQuDQoNCigzKSBBbGwgdGhlIG90aGVyIGNhc2VzIGluIHRo
aXMgZnVuY3Rpb24gb2YgInRoZSBpbmZvIGFib3V0IHRoZSBlbmRwb2ludCBsb29rZWQgd2VpcmQi
IHdlIHJlcG9ydCB2aWEgdGhlIHRyYWNlcG9pbnQgdHJhY2VfdXNiX2hvc3RfcGFyc2VfZXJyb3Io
KS4gSSBkb24ndCBoYXZlIGEgc3Ryb25nIG9waW5pb24gYWJvdXQgd2Fybl9yZXBvcnQgdnMgYSB0
cmFjZXBvaW50IGhlcmUsIGJ1dCBJIGRvIHRoaW5rIHdlIHNob3VsZCBiZSBjb25zaXN0ZW50Lg0K
DQpZTDogVW5kZXJzdGFuZCwgSSB0aGluayBpdCBkZXBlbmRzLiBGb3Igbm9ybWFsIFFFTVUgVVNC
IGV2ZW50IHRyYWNpbmcgb3IgZGVidWdnaW5nLCBpdCdzIGJldHRlciB0byB1c2UgdGhlIHRyYWNl
cG9pbnQgZnVuY3Rpb25zLiBCdXQgaW4gdGhpcyBjYXNlLCBpdCBpcyByZXBvcnRpbmcgYW4gdW5l
eHBlY3RlZCBjb25kaXRpb24gb3IgYmVoYXZpb3IuDQoNCj4gKyAgICB9DQo+ICsNCj4gICAgICBm
b3IgKGkgPSAwOyBpIDwgY29uZi0+Yk51bUludGVyZmFjZXM7IGkrKykgew0KPiAgICAgICAgICAv
Kg0KPiAgICAgICAgICAgKiBUaGUgdWRldi0+YWx0c2V0dGluZyBhcnJheSBpbmRleGVzIGFsdGVy
bmF0ZSBzZXR0aW5ncyBAQCANCj4gLTg5Niw3ICs5MDUsMjEgQEAgc3RhdGljIHZvaWQgdXNiX2hv
c3RfZXBfdXBkYXRlKFVTQkhvc3REZXZpY2UgKnMpDQo+ICAgICAgICAgIGFsdCA9IHVkZXYtPmFs
dHNldHRpbmdbaW50Zi0+YkludGVyZmFjZU51bWJlcl07DQo+DQo+ICAgICAgICAgIGlmIChhbHQg
IT0gMCkgew0KPiAtICAgICAgICAgICAgYXNzZXJ0KGFsdCA8IGNvbmYtPmludGVyZmFjZVtpXS5u
dW1fYWx0c2V0dGluZyk7DQo+ICsgICAgICAgICAgICBpZiAoYWx0ID49IGNvbmYtPmludGVyZmFj
ZVtpXS5udW1fYWx0c2V0dGluZykgew0KPiArICAgICAgICAgICAgICAgIC8qDQo+ICsgICAgICAg
ICAgICAgICAgICogUmVjb21tZW5kIGZpeDogc29tZXRpbWVzIGxpYnVzYiByZXBvcnRzIGEgDQo+
ICsgdGVtcG9yYXJ5DQoNCiJSZWNvbW1lbmQgZml4IiBkb2Vzbid0IG1ha2Ugc2Vuc2UgaGVyZSAt
LSB5b3UgY2FuIGRlbGV0ZSB0aGF0IGJpdC4NCg0KWUw6IEFncmVlLCB3aWxsIHJlbW92ZSBpdC4N
Cg0KPiArICAgICAgICAgICAgICAgICAqIGludmFsaWQgYWx0c2V0dGluZyBpbmRleCBkdXJpbmcg
ZmFzdCBob3RwbHVnL3VucGx1Zy4NCj4gKyAgICAgICAgICAgICAgICAgKiBJbnN0ZWFkIG9mIGFi
b3J0aW5nLCBsb2cgYSB3YXJuaW5nIGFuZCBza2lwIHRoZSBpbnRlcmZhY2UuDQo+ICsgICAgICAg
ICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgICAgd2Fybl9yZXBvcnQoInVzYi1ob3N0OiBp
Z25vcmluZyBpbnZhbGlkIGFsdHNldHRpbmc9JWQgKG1heD0lZCkgIg0KPiArICAgICAgICAgICAg
ICAgICAgICAiZm9yIGludGVyZmFjZT0lZCBvbiAlcyAoYnVzPSUwM2QsIGFkZHI9JTAzZCkiLA0K
PiArICAgICAgICAgICAgICAgICAgICBhbHQsDQo+ICsgICAgICAgICAgICAgICAgICAgIGNvbmYt
PmludGVyZmFjZVtpXS5udW1fYWx0c2V0dGluZyA/IGNvbmYtPmludGVyZmFjZVtpXS5udW1fYWx0
c2V0dGluZyAtIDEgOiAtMSwNCj4gKyAgICAgICAgICAgICAgICAgICAgaSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgdWRldi0+cHJvZHVjdF9kZXNjID8gdWRldi0+cHJvZHVjdF9kZXNjIDogInVu
a25vd24iLA0KPiArICAgICAgICAgICAgICAgICAgICBzLT5idXNfbnVtLCBzLT5hZGRyKTsNCj4g
KyAgICAgICAgICAgICAgICBjb250aW51ZTsNCg0KRm9yIG90aGVyIGVycm9ycyB3aXRoIHRoZSBp
bnRmIGluZm8gd2UgInJldHVybiIsIGkuZS4NCnNraXAgdGhlIHdob2xlIGVuZHBvaW50LCByYXRo
ZXIgdGhhbiBqdXN0IGNvbnRpbnVpbmcuDQpTaG91bGQgd2UgZG8gdGhlIHNhbWUgdGhpbmcgaGVy
ZSA/DQooQ29uY2VwdHVhbGx5IHRoZSBzYW1lIHRoaW5nIC0tIGp1c3QgInJldHVybiIgbGVha3Mg
dGhlIGNvbmZpZyBkZXNjcmlwdG9yLCBhcyBub3RlZCBhYm92ZS4pDQoNCllMOiBJbiB0aGlzIGNh
c2UsIG9ubHkgb25lIGludGVyZmFjZSBoYXMgYW4gaW5jb25zaXN0ZW50IGFsdHNldHRpbmcgaW5k
ZXggKGNhdXNlZCBieSBob3QgdW5wbHVnL3JlcGx1Zykgd2hpbGUgdGhlIG90aGVycyByZW1haW4g
dmFsaWQsIHNvIEkgdXNlICJjb250aW51ZSIgZm9yIHNraXBwaW5nIG9ubHkgdGhlIGludmFsaWQg
aW50ZXJmYWNlIGF2b2lkcyBsb3NpbmcgdmFsaWQgZW5kcG9pbnQgaW5mb3JtYXRpb24uIFJldHVy
bmluZyBlYXJseSB3b3VsZCBkcm9wIGFsbCByZW1haW5pbmcgaW50ZXJmYWNlcywgd2hpY2ggc2Vl
bXMgdW5kZXNpcmFibGUuICBUaGFua3MuDQoNCj4gKyAgICAgICAgICAgIH0NCj4gICAgICAgICAg
ICAgIGludGYgPSAmY29uZi0+aW50ZXJmYWNlW2ldLmFsdHNldHRpbmdbYWx0XTsNCj4gICAgICAg
ICAgfQ0KDQp0aGFua3MNCi0tIFBNTQ0K

