Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76B0C5B567
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu30l-0001cv-Tn; Wed, 12 Aug 2026 03:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wu30d-0001aX-4v
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:04:20 -0400
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1wu30a-0001E6-Tb
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 03:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786518257; x=1818054257;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1bWZesmJZZRZ3DtH4jtwVXnA4HRfzQpRiOX9CNbDlOs=;
 b=OCu6CP7MnYRMMGWLlPX1gl0T12SsDYIk/HKnxDN41JzJZz3txGeeq3KA
 V1mZVMUh9tZK5OX95h+1byDlcsUPsRmfeCjNWti3kCx3VwvhCA2WvBVWN
 4iLAr3lvsSs1kjPTNaIZL66+D37ACzWuUf1/xEpQvUaZC7VFlbk78JdFu
 efKyc32iwvEqLAI/27S/GxLaGBE5OWq9ommfej4+uRuRepaUOHCaVb+mD
 F88p0EzKUfoQAECKC4KMEwS+NGmspwOU1tiI5FV9iya18cWaeJ4BsRegX
 49DIR9Ox79aLN6SlS8W6GQsut8IqL4r4XVyzF2/3JyKliSGcs1/F0Pjov g==;
X-CSE-ConnectionGUID: ZTDYYXYTRpqEUg2zdbQlhQ==
X-CSE-MsgGUID: +jcnzbFdTWa2TBeByEFhww==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="97725731"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="97725731"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 00:04:13 -0700
X-CSE-ConnectionGUID: hBKy7nxOTIuPeB5UL7N8hg==
X-CSE-MsgGUID: CEPkG/cMREGiqaxKjOgS8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; d="scan'208";a="257364250"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2026 00:04:13 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 00:03:35 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 12 Aug 2026 00:03:35 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.38)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 12 Aug 2026 00:02:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RoZko0pdwDqhImTYgjBRK8PaTwPyf7zCYjuXdOJD42w1EVJQL/0ly9xSJDD376AIRkk3FFqTUR0VlRn3jFSpb//gdWDh0+WQzSYwjb4DrTXOOL44hBjAoaybrQnDv+tVe9nGx7q39SL/STX7qE3Q5MKTwpzKK5o2TSNeisebTOW7NreR15gjHYoPxxiKoO6Eytu3VJaI30uDk1yMGD2wyZv01UYHTesQVqSysqzo0G5lt+0uRuIKwMdBIFACMiIX+gUdzjl/i6L17MUf8uQeNWcLw7b7yziNMEA9lmaM0g6+kw6fE0n/z74JySTGy3Z5ja7OX+FQq4QMJSOyZhzlxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bWZesmJZZRZ3DtH4jtwVXnA4HRfzQpRiOX9CNbDlOs=;
 b=arbuwGiZxd0cDfxCxc3ojU/FYqFps1uYddP/SEc4ihYNpN1d3sp+wzo2mn4prnAircd4G3ltse+//IeqY38SEEQvdrujBlD3zt3rcLqDSCMyh+FwQgVEoGXAtxoxG5lWC2UQI67OPiEK8mx6ZO+ZNMVT7ldPBog6octviJ6Gego6z0K6dR3ruiQ5/iNQ5gyK7C5jcF9S06lvFL3LgPHvuSWaUQUuweoQ9VHwbj0rHd3VhSn/H4U1dGOXHYncuV/rpCtT6w8U2HyXiIjyx+Vzr+P9MePE/PkZDgRfkQu8jiG/QWpqg6PHtt9n2Ni4PhMEG13pk+13bA4w4ESPkZ6v2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by BL3PR11MB6411.namprd11.prod.outlook.com (2603:10b6:208:3ba::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Wed, 12 Aug
 2026 07:02:37 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::37b4:37a9:4f3:518b%3]) with mapi id 15.21.0292.024; Wed, 12 Aug 2026
 07:02:37 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q2zDqW1lbnQgTUFUSElFVS0tRFJJRg==?=
 <clement.mathieu--drif@bull.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, 
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowangio@gmail.com" <jasowangio@gmail.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "skolothumtho@nvidia.com" <skolothumtho@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Hao, Xudong" <xudong.hao@intel.com>
Subject: RE: [PATCH v3 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Topic: [PATCH v3 2/6] backends/iommufd: Introduce
 iommufd_backend_alloc_faultq
Thread-Index: AQHdJXarFur1nTi1wECQ4ZL35pyMz7aYbRYAgAGTGtA=
Date: Wed, 12 Aug 2026 07:02:36 +0000
Message-ID: <IA3PR11MB91369EE6124AA8113A00166592DC2@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20260806073825.363468-1-zhenzhong.duan@intel.com>
 <20260806073825.363468-3-zhenzhong.duan@intel.com>
 <b47384ede6bc77248473b248ad8c16fbc892bfd9.camel@bull.com>
In-Reply-To: <b47384ede6bc77248473b248ad8c16fbc892bfd9.camel@bull.com>
Accept-Language: en-US
Content-Language: en-US
X-Mentions: yi.l.liu@intel.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|BL3PR11MB6411:EE_
x-ms-office365-filtering-correlation-id: 5fd548f1-0ad7-4bb7-c42f-08def83fb10e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|7416014|38070700021|6133799003|10067099003|4143699003|11063799006|56012099006|3023799007|22082099003|18002099003;
x-microsoft-antispam-message-info: kuXmYgxhvgOsm39S3LEsjtYWW2bn8bxTPiXltj8QF8IQRD33+r7y//8iUyNP74uJaIvWYWfwHkPAXTEloJfIAh2WsKsHu51Th+qnZ6pgUlB0M8Shxi1vAhKnclQh3rdgJaZMkau+FRyP5lzM6jJa1qOg0VNovWxZ9O285eUsyglgbo95YvJsLCsLxv+3In/miW35X8Hj5c7myJiDPUFKCXvzhBRhxtf9Wt3gI4JtZAHJu7KPao79l0LZQWP7PzvumXj3BB0biodOES51TMVu5NxtUaiK1Fgb0Pkyl4U1aLIEN6kbTONP1HYT/l6XSpH14U9OOB9+G1trVDTlutCRWlWonO5URQ3RKs6DQi87H1HY+Uptj4EIH2gPl9E1yT6GMiiC4F+gknU9DooVzQlo3n4eNm+sPOJgB05n9vUdJ/C0C7FPayDk1irAQiFaqJHajglFBV+b9sgz/wpxcanRMtuhVSt5zEiC4KlyTbpkEIMxk/flW6HTcJuXKeyXWMqD8c1tB4U+IhwaujorHS6IisFlqcoPBHMep/GMStAxAUrNmetO//4jwz4TutIAluOX/4otgPDuBbA4GcIbRBWzumphtDcho5WpMJ13A/sTb203FjrvO6NVAANpdBsLYf7VEitehviugtJCEPLXFpCOvskkJpTEiieVBd0K2TvQUA7D+iq/kkeqvxDXsvKGYyJ2pMypF0igM6+swsKqN7hcyq+hlF3dvKHV4Aj1C9OUQaY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(38070700021)(6133799003)(10067099003)(4143699003)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SmZpc1k1eW92QmZyZ0RRSGxmUDA0WWJ6eDdLbTE3d0Z5b1VXaWpGMTN6OEk3?=
 =?utf-8?B?R3B2ZkVoTFBtWHNEY2JGV0p2QVV0Q1BRb295eDAvaXVpbEIvcElraUt0Tktw?=
 =?utf-8?B?T2dnNHFxNUdnb0toVGJMdE56YmJRYVpYODQ0dWU5VkpLbGVxUlljM251Wkky?=
 =?utf-8?B?VGFPR0FoRjh2TSs1QU1EMitzTmxYektBSWNpdWhVd094c3hCN2lJRkxMVEVJ?=
 =?utf-8?B?RnRzbzdWamhmOGNzNm82aDUzUDhjTXlJYkpFb3V3YzN5d0pUUXkvUjl5bklS?=
 =?utf-8?B?TkwyNEZVY3NZYndjUGc0UnhSUGE3TUZYT2tldkhTL0xwTFBlKzVIYXN3M0F6?=
 =?utf-8?B?WHUwV2kwRmMyUHUvWDBkSXNhNXU3NlBQT2k0aExUbVBwei92Rnk4dHkxMTVx?=
 =?utf-8?B?WnM3bDNCa0JMcUhOQkZXSHVXZFBGS1hDcWp6ak8xU1VPUjkxL0tLcHVWNXM5?=
 =?utf-8?B?a3NBbUtFUktWZnVBa1E3TTFpMk1zQmIvZGhzUC85Z09wWFNQUFB5SklSNVp6?=
 =?utf-8?B?MWFDNmFYVGsxcDM4MjQ5bFNrVXNPaCs1ZjBoV1lBZ2xtQzRCQVloVTlzZS9x?=
 =?utf-8?B?eTlzaHFTSndzbmY3TCs4OVRETFREUXVUeXJUOXFGTXc4YXJDYVJjQzdGN1I1?=
 =?utf-8?B?SnpVaGo0OEUwTmpzeDYxN1hsV2VmNmowY1RycEZpcGw1b1djT2d2T2tYY0xw?=
 =?utf-8?B?UDFHK1NMY0U0YzY2UnhYVzZzRW9pcHE0Y2VtdDZlTUZsZnNLR2xHTDBEMVo4?=
 =?utf-8?B?WUNTR3AxTStNTWVGZnBJeTNOaDVHa1NyYTNCbWR0OVcrRG9OdzBKVUdWamZq?=
 =?utf-8?B?eHZ2NkxLUmtYbkI0S3QrMnh5cGhrSWVjZVVHVHJwZFZRaFJZTWNQaWhEM0da?=
 =?utf-8?B?NmswRzVJbjJ6dnFUS0JTb2FWNkpNSUhFV1NIbVZUZUJvNGVlWFE2ZUpmUXhH?=
 =?utf-8?B?Z3pTQStOOU1PQ0dNS2g1K2JjcnQ2OW81b1dWYlZSb0t2UjMrenN0TW9iRVdE?=
 =?utf-8?B?dVM3M1VYcjcrS2kwbWZqZUc3SnhsYnR0TUVYakdOWlJ4OEsyUjNvdm1OUUtj?=
 =?utf-8?B?V0x6UG5CZU9Takk4YVlOR0pDVER1dm9PNXdqaERBZWZnREZTN2MvVVFtNHFQ?=
 =?utf-8?B?Ri9TZ3RMMkhqblJyYzNpSkF2eURuYzRJTHVyWTUzT0QyMDVRM1lES3VydHN1?=
 =?utf-8?B?ZnNqWFlkVW1maUlWMGRRNDhDbjdDY1ZsR3lRcDlidFNic0liZnFzekdIT0ZZ?=
 =?utf-8?B?Nmw1M3JRVEx2ejI5WTUyM1FrTGp1aXFnNnl6N3BDUkE2VHI0cVBjY2pKREYz?=
 =?utf-8?B?RzR1eUo4VUZTTmk2UG5ZQnpNei9DZU1GcWZWeUVmN0FjVjJZckRqSHA5eThy?=
 =?utf-8?B?cUR6UE5nS1M4RWpzMEVyTmhVZ0VKQXI3UENDZTVVNThDT0p1ZTFoYTlxYnl0?=
 =?utf-8?B?MktubE9acGV2YW9tSEFmZ1BZNzFiYzlsL1NnblNFTVVnUDFwSGYwRCtsT3h1?=
 =?utf-8?B?b3V0NE1CR2UzK1JzaDFhSFg4djhOdVhZQnAyTXFNeUF1THhsQkhVT2RnczJ2?=
 =?utf-8?B?WUsyaGN3azVMVjZTWkJ2MVNUV3NSWm5PbkhmMGdCQnlKWVVyUzNYUm1hbWQ4?=
 =?utf-8?B?cXQ3aml1bGZORUN6NFZBVDlvWDgyVGZNZEZYY2FJdW1mVzBLWWIrY1UreHFH?=
 =?utf-8?B?RU9kbnhMcEp1UWlxWGdydnRlMk9YWXk4aThMY3FvZHVtTjkxUTZCUXZRNXJL?=
 =?utf-8?B?MWRkRXpIQnczOG1lQ1dta1MzMzNwaURsOWoyaEFqbDg5TWR1bEhieE5GSW0y?=
 =?utf-8?B?eWJST3VxamVyMHZvSU9nN0s4NWlKeXRVdTVGSTQycW1oWlRoRytVc0VwdmtK?=
 =?utf-8?B?bWgwREVFZUZlVDhoUzJ6UjZJRFNES1p6QmxzMEg5aFV3b0hvKzVibTN6OGZN?=
 =?utf-8?B?SlFOaWNoVVFNV2w3bXY5bnBwWkhVbEwxVkRSc3pCOTJGR1dMQy9EZGVObStj?=
 =?utf-8?B?OWcvWk9CVmF4T2ZsbGlPQVZyTjl1OHRjRGtvRkZUQjdXY1ZMcXRaaS9MNDYx?=
 =?utf-8?B?RVd6cVd0WUkvZU84VFJ2eVRkQndJQStxWkM1Z2xQQ2lKOVhSS1oxUVkxcG9z?=
 =?utf-8?B?V2QrRExHUzdwWFRSVU1iK0N4M0RPNFR2dHU0YmVpYWNjRERjdXJmZFAreFdV?=
 =?utf-8?B?NTlFL2tTVnNFdWV3aWM3U3dDMTI3cXFlN1lNbW85MkZJeklSUE9NNnhBUnIw?=
 =?utf-8?B?c1RmQ0lmMXArdHJhUUZTZ25qVndKMUY4MFF2OTBDZVpNc2RXNkE4QWpTZU0y?=
 =?utf-8?B?SnFyQVhuTkQ4aDlBd3RGN1FNWlFqS2lieGNlaXVyNlFnd3RwU3RVZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YfXburpf/sxVK9wgmCj5riXptQzFqByCMfMhRWVfJ0XV8ryz30ysFmfYrKowg86gxB3l6I2EdatI50WrwKvuEPGHa3JgssFK0e1Kd0r4HFOUhdf5pr0D+dIyCqxyQLFkD8kFrIhP8APxMSElZlOBAfgzDNGJjGiAthEjIEiwZWG70kYLA9mfGan4jGzh08R31OCm3qelyPuiefUjdEjNYCB4KN9wswuY6gGrbZ3mIIgIj1PZNMJqcLw3tpPJoSxWyHZ7JlmuU2z5Qyq2G7s+uSm0caJSRz/Nuym9uOeYhyn6eYJVAqymOa7XXjvNHX4XBppJF4P9nK2W+DXwpVQFqg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fd548f1-0ad7-4bb7-c42f-08def83fb10e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 07:02:37.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQVHkflFocGmokoVrMPzePMh9h7jIcmLn1eYbZP4xvuL9ZFHQP9IapKsr/MrgErlOh42jFguCITVVtTLBYJsTsTrkkaZW+kGHZNfmUcuuFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6411
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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
VENIIHYzIDIvNl0gYmFja2VuZHMvaW9tbXVmZDogSW50cm9kdWNlDQo+aW9tbXVmZF9iYWNrZW5k
X2FsbG9jX2ZhdWx0cQ0KPg0KPg0KPk9uIFRodSwgMjAyNi0wOC0wNiBhdCAwMzozOCAtMDQwMCwg
Wmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBBZGQgYSBuZXcgaGVscGVyIGZvciBJT01NVV9GQVVM
VF9RVUVVRV9BTExPQyBpb2N0bCB0byBhbGxvY2F0ZSBhIGZhdWx0DQo+PiBoYW5kbGluZyBvYmpl
Y3Qgd2hpY2ggd2lsbCBiZSB1c2VkIGluIGh3cHQgYWxsb2NhdGlvbi4NCj4+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBaaGVuemhvbmcgRHVhbg0KPjxbemhlbnpob25nLmR1YW5AaW50ZWwuY29tXShtYWls
dG86emhlbnpob25nLmR1YW5AaW50ZWwuY29tKT4NCj4+IFRlc3RlZC1ieTogWHVkb25nIEhhbw0K
PjxbeHVkb25nLmhhb0BpbnRlbC5jb21dKG1haWx0bzp4dWRvbmcuaGFvQGludGVsLmNvbSk+DQo+
PiAtLS0NCj4+IMKgaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oIHzCoCAzICsrKw0KPj4gwqBiYWNr
ZW5kcy9pb21tdWZkLmPCoMKgwqDCoMKgwqAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4+
IMKgYmFja2VuZHMvdHJhY2UtZXZlbnRzwqDCoMKgIHzCoCAxICsNCj4+IMKgMyBmaWxlcyBjaGFu
Z2VkLCAyNSBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc3lzdGVt
L2lvbW11ZmQuaCBiL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0KPj4gaW5kZXggMTdiZjFhMzcy
Ny4uYzI4Nzc2N2IxMSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvc3lzdGVtL2lvbW11ZmQuaA0K
Pj4gKysrIGIvaW5jbHVkZS9zeXN0ZW0vaW9tbXVmZC5oDQo+PiBAQCAtMTA2LDYgKzEwNiw5IEBA
IGJvb2wNCj5pb21tdWZkX2JhY2tlbmRfYWxsb2NfdmV2ZW50cShJT01NVUZEQmFja2VuZCAqYmUs
IHVpbnQzMl90IHZpb21tdV9pZCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdWludDMyX3QgKm91dF92ZXZl
bnRxX2lkLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1aW50MzJfdCAqb3V0X3ZldmVudHFfZmQsIEVycm9y
ICoqZXJycCk7DQo+Pg0KPj4gK2Jvb2wgaW9tbXVmZF9iYWNrZW5kX2FsbG9jX2ZhdWx0cShJT01N
VUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+KmZhdWx0X2lkLA0KPj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnQg
KmZhdWx0X2ZkLCBFcnJvciAqKmVycnApOw0KPj4gKw0KPj4gwqBib29sIGlvbW11ZmRfYmFja2Vu
ZF9hbGxvY19od19xdWV1ZShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90DQo+dmlvbW11X2lk
LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHF1ZXVlX3R5cGUsIHVpbnQzMl90IGluZGV4
LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHIsIHVpbnQ2NF90IGxlbmd0aCwNCj4+
IGRpZmYgLS1naXQgYS9iYWNrZW5kcy9pb21tdWZkLmMgYi9iYWNrZW5kcy9pb21tdWZkLmMNCj4+
IGluZGV4IDE1ZjJhNTEzNTAuLmZjY2Q0ZTY2MGMgMTAwNjQ0DQo+PiAtLS0gYS9iYWNrZW5kcy9p
b21tdWZkLmMNCj4+ICsrKyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KPj4gQEAgLTU1NCw2ICs1NTQs
MjcgQEAgYm9vbA0KPmlvbW11ZmRfYmFja2VuZF9hbGxvY192ZXZlbnRxKElPTU1VRkRCYWNrZW5k
ICpiZSwgdWludDMyX3QgdmlvbW11X2lkLA0KPj4gwqDCoMKgwqAgcmV0dXJuIHRydWU7DQo+PiDC
oH0NCj4+DQo+PiArYm9vbCBpb21tdWZkX2JhY2tlbmRfYWxsb2NfZmF1bHRxKElPTU1VRkRCYWNr
ZW5kICpiZSwgdWludDMyX3QNCj4qZmF1bHRfaWQsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGludCAqZmF1bHRf
ZmQsIEVycm9yICoqZXJycCkNCj4NCj5vdXRfZmF1bHRfZmQgaW4gdGhlIHN0cnVjdHVyZSBpcyBf
X3UzMi4NCj5JbiB0aGUgc2FtZSBmaWxlLCBpb21tdWZkX2JhY2tlbmRfYWxsb2NfdmV2ZW50cSBp
cyBpbiBhIHNpbWlsYXIgc2l0dWF0aW9uIGFuZCB0aGUNCj4NCj5GdW5jdGlvbnMgaW4gdGhlIHNh
bWUgZmlsZSBuYW1lIG91dHB1dCBwYXJhbWV0ZXJzIHVzaW5nIHRoZSAib3V0XyIgcHJlZml4Lg0K
Pk1heWJlIHdlIHNob3VsZCBkbyB0aGUgc2FtZS4NCj4NCj5Nb3Jlb3ZlciwgdGhlIG91dHB1dCBm
YXVsdF9mZCBpcyBfX3UzMiBpbiB0aGUgaW9tbXVfZmF1bHRfYWxsb2Mgc3RydWN0dXJlLg0KPldl
IHNob3VsZCBhdm9pZCB1c2luZyBpbnQgaGVyZS4gaW9tbXVmZF9iYWNrZW5kX2FsbG9jX3ZldmVu
dHEgaXMgcXVpdGUgc2ltaWxhciBpbg0KPnRoaXMgcmVzcGVjdC4NCg0KSSBwcmV2aW91c2x5IGNo
YW5nZWQgdGhpcyB0byBpbnQgKmZhdWx0X2ZkIGZvbGxvd2luZyBATGl1LCBZaSBMJ3MgZWFybGll
ciBzdWdnZXN0aW9uIHRvDQpoYW5kbGUgdGhlIGNvbnZlcnNpb24gZGlyZWN0bHkgd2l0aGluIHRo
ZSBoZWxwZXIuIEhvd2V2ZXIsIHVzaW5nIHVpbnQzMl90ICpvdXRfZmF1bHRfZmQNCmluc3RlYWQg
YWxpZ25zIGJldHRlciB3aXRoIHRoZSBwYXR0ZXJuIGVzdGFibGlzaGVkIGJ5IGlvbW11ZmRfYmFj
a2VuZF9hbGxvY192ZXZlbnRxDQppbiB0aGUgZXhhY3Qgc2FtZSBmaWxlLiBJJ2xsIGRvIHRoYXQg
dW5sZXNzIFlpIGhhcyBzdHJvbmcgb2JqZWN0aW9ucy4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K
Pg0KPj4gK3sNCj4+ICvCoMKgwqAgaW50IHJldCwgZmQgPSBiZS0+ZmQ7DQo+PiArwqDCoMKgIHN0
cnVjdCBpb21tdV9mYXVsdF9hbGxvYyBjbWQgPSB7DQo+PiArwqDCoMKgwqDCoMKgwqAgLnNpemUg
PSBzaXplb2YoY21kKSwNCj4+ICvCoMKgwqAgfTsNCj4+ICsNCj4+ICvCoMKgwqAgcmV0ID0gaW9j
dGwoZmQsIElPTU1VX0ZBVUxUX1FVRVVFX0FMTE9DLCAmY21kKTsNCj4+ICvCoMKgwqAgdHJhY2Vf
aW9tbXVmZF9iYWNrZW5kX2FsbG9jX2ZhdWx0cShmZCwgY21kLm91dF9mYXVsdF9pZCwNCj5jbWQu
b3V0X2ZhdWx0X2ZkLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0KTsNCj4+ICvCoMKgwqAg
aWYgKHJldCkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJy
bm8sICJGYWlsZWQgdG8gYWxsb2NhdGUgZmF1bHQgcXVldWUiKTsNCj4+ICvCoMKgwqDCoMKgwqDC
oCByZXR1cm4gZmFsc2U7DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgKmZhdWx0X2lk
ID0gY21kLm91dF9mYXVsdF9pZDsNCj4+ICvCoMKgwqAgKmZhdWx0X2ZkID0gY21kLm91dF9mYXVs
dF9mZDsNCj4+ICvCoMKgwqAgcmV0dXJuIHRydWU7DQo+PiArfQ0KPj4gKw0KPj4gwqBib29sIGlv
bW11ZmRfYmFja2VuZF9hbGxvY19od19xdWV1ZShJT01NVUZEQmFja2VuZCAqYmUsIHVpbnQzMl90
DQo+dmlvbW11X2lkLA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQzMl90IHF1ZXVlX3R5cGUsIHVp
bnQzMl90IGluZGV4LA0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVpbnQ2NF90IGFkZHIsIHVpbnQ2NF90
IGxlbmd0aCwNCj4+IGRpZmYgLS1naXQgYS9iYWNrZW5kcy90cmFjZS1ldmVudHMgYi9iYWNrZW5k
cy90cmFjZS1ldmVudHMNCj4+IGluZGV4IDAwOWEyNWIwYmUuLmRiYmM4ZWE3Y2QgMTAwNjQ0DQo+
PiAtLS0gYS9iYWNrZW5kcy90cmFjZS1ldmVudHMNCj4+ICsrKyBiL2JhY2tlbmRzL3RyYWNlLWV2
ZW50cw0KPj4gQEAgLTE3LDYgKzE3LDcgQEAgaW9tbXVmZF9iYWNrZW5kX3VubWFwX2RtYV9ub25f
ZXhpc3QoaW50IGlvbW11ZmQsDQo+dWludDMyX3QgaW9hcywgdWludDY0X3QgaW92YSwgdQ0KPj4g
wqBpb21tdWZkX2JhY2tlbmRfdW5tYXBfZG1hKGludCBpb21tdWZkLCB1aW50MzJfdCBpb2FzLCB1
aW50NjRfdCBpb3ZhLA0KPnVpbnQ2NF90IHNpemUsIGludCByZXQpICIgaW9tbXVmZD0lZCBpb2Fz
PSVkIGlvdmE9MHglIlBSSXg2NCIgc2l6ZT0weCUiUFJJeDY0Ig0KPiglZCkiDQo+PiDCoGlvbW11
ZmRfYmFja2VuZF9hbGxvY19pb2FzKGludCBpb21tdWZkLCB1aW50MzJfdCBpb2FzKSAiIGlvbW11
ZmQ9JWQNCj5pb2FzPSVkIg0KPj4gwqBpb21tdWZkX2JhY2tlbmRfYWxsb2NfaHdwdChpbnQgaW9t
bXVmZCwgdWludDMyX3QgZGV2X2lkLCB1aW50MzJfdCBwdF9pZCwNCj51aW50MzJfdCBmbGFncywg
dWludDMyX3QgaHdwdF90eXBlLCB1aW50MzJfdCBsZW4sIHVpbnQ2NF90IGRhdGFfcHRyLCB1aW50
MzJfdA0KPm91dF9od3B0X2lkLCBpbnQgcmV0KSAiIGlvbW11ZmQ9JWQgZGV2X2lkPSV1IHB0X2lk
PSV1IGZsYWdzPTB4JXgNCj5od3B0X3R5cGU9JXUgbGVuPSV1IGRhdGFfcHRyPTB4JSJQUkl4NjQi
IG91dF9od3B0PSV1ICglZCkiDQo+PiAraW9tbXVmZF9iYWNrZW5kX2FsbG9jX2ZhdWx0cShpbnQg
aW9tbXVmZCwgdWludDMyX3QgZmF1bHRfaWQsIGludCBmYXVsdF9mZCwgaW50DQo+cmV0KSAiIGlv
bW11ZmQ9JWQgZmF1bHRfaWQ9JXUgZmF1bHRfZmQ9JWQgKCVkKSINCj4+IMKgaW9tbXVmZF9iYWNr
ZW5kX2ZyZWVfaWQoaW50IGlvbW11ZmQsIHVpbnQzMl90IGlkLCBpbnQgcmV0KSAiIGlvbW11ZmQ9
JWQNCj5pZD0lZCAoJWQpIg0KPj4gwqBpb21tdWZkX2JhY2tlbmRfc2V0X2RpcnR5KGludCBpb21t
dWZkLCB1aW50MzJfdCBod3B0X2lkLCBib29sIHN0YXJ0LCBpbnQgcmV0KSAiDQo+aW9tbXVmZD0l
ZCBod3B0PSV1IGVuYWJsZT0lZCAoJWQpIg0KPj4gwqBpb21tdWZkX2JhY2tlbmRfZ2V0X2RpcnR5
X2JpdG1hcChpbnQgaW9tbXVmZCwgdWludDMyX3QgaHdwdF9pZCwgdWludDY0X3QNCj5pb3ZhLCB1
aW50NjRfdCBzaXplLCB1aW50NjRfdCBmbGFncywgdWludDY0X3QgcGFnZV9zaXplLCBpbnQgcmV0
KSAiIGlvbW11ZmQ9JWQNCj5od3B0PSV1IGlvdmE9MHglIlBSSXg2NCIgc2l6ZT0weCUiUFJJeDY0
IiBmbGFncz0weCUiUFJJeDY0Ig0KPnBhZ2Vfc2l6ZT0weCUiUFJJeDY0IiAoJWQpIg0K

