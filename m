Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A67C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 12:26:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCeqM-00073O-HE; Thu, 30 May 2024 08:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqK-00071g-V0
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:16 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sCeqF-0006CX-Mo
 for qemu-devel@nongnu.org; Thu, 30 May 2024 08:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717071911; x=1748607911;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=/9deiCr5zfRae8uKC+gcrmZtUgeFngGPj+Ci4oAplW0=;
 b=uHZEXPA3fTawgpFko+hD1nVh93fG/aYysdCgtBUor97IUHHliwBt28bx
 PHjuobzM9Jji6eLHnk/QS0adlplgG/vw7d0+YD/zT+4qhkqPNnY10oDAy
 XExPQItjloOLJY9IlpC0OwTm6W1rPCcZvQu7OjGFtYg4wDgSKPCMDqItk
 duG3YUzcUCLtNz/5mEFcCE0Q5xc6hwrDQmqppxhVMYVz1wHA9t1I0zU8T
 T4DQY7pWCNdKZBCEe5UZTE3ILRvLoPap3rQ1JIs1kWwVaL4+33KrgzvQJ
 Dcazw391w9U9bNf3YxDzuzRAaoff2psKeON7pyEk7v4KHfzTbOmodX5OY A==;
X-IronPort-AV: E=Sophos;i="6.08,201,1712613600"; d="scan'208";a="13581117"
X-MGA-submission: =?us-ascii?q?MDFPc2Uw4XwEguz5Cogvjh6ocKJxlqnIxpyBmp?=
 =?us-ascii?q?BHb5w2ZCEwHYNlCyVyKsp/WInwN4PXG6Xy38PcGaxmEjmo9Gy4JBE+gn?=
 =?us-ascii?q?PBGVhjXkNEk9H6bf7fRoaqE+FoHN7jfOYvB/YqyvX5vW1TRHObsH80qE?=
 =?us-ascii?q?VYapT2nZX1GhV8q2ySuSEQlg=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 May 2024 14:25:06 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xjqqkyfpv2P987VXZxxalWOJJbElnjkfhhHFySOkCgTXaQUghIhy0nFhaysm4LJO+JdhEB5hbLhe4p/5ze3b20QQSUt0lU78BkgFoYpopBkAD/jweA2fTj/xzwdBLkVVi2/pP73dyFQXHw+PFQUH7r5S5BQ9tU97XUcEq3fkcTkWdvBnGUCSdzeFpvGQ2Azt2TviRd/cuq1lkMY16yr1hwrfjUE4zbMN2eooV50FQ/Jw7+oNbvkI6KlGbYTQSonOZCTTwC4Rf/xm8NaGWzIWKHJ07tGdlIuIjXt/NPJ3AvI/7U6D7fERMi37f2Q1E8EsNQfR+4LuugzKjl52uwm8xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9deiCr5zfRae8uKC+gcrmZtUgeFngGPj+Ci4oAplW0=;
 b=CERh5oqm+o1+YnVKEOz9UQCqe+OzRwfAM0Zdbq0I55f3LJNNbKC0K/kzV9KvDaxr6i5LshrzTaM65SxI/uBPw4xRENqjv9RJBu7mk3cvxWMEzkESEJNZcY8p0QJDTTaXA+TS5H9nW+BrezSbySr7De2Aj+i1M7QG0a4iyW/rvSBdsyLaUHUDHy/FcZdWgtqjW1RpMT9oA+OVbk+kkYZlQRRD/cawxBbZs0f/jvuabDDRQWBZN4JxI4JRMlgL6kKPc8c8W5dvcTcWcMfHDt5Z/8xlYKMWEAxVy+ej+a+fyhx6S0YJkjpolMAmNk3j06/ti+BsQ3pcOAopeHXFgKZoCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB8069.eurprd07.prod.outlook.com (2603:10a6:20b:358::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 12:25:04 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 12:25:03 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 6/8] intel_iommu: declare PRI constants and structures
Thread-Topic: [PATCH v1 6/8] intel_iommu: declare PRI constants and structures
Thread-Index: AQHasoxm243WHLgbkk2BAL0jzD3XeA==
Date: Thu, 30 May 2024 12:25:03 +0000
Message-ID: <20240530122439.42888-7-clement.mathieu--drif@eviden.com>
References: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240530122439.42888-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB8069:EE_
x-ms-office365-filtering-correlation-id: 461e6470-3af9-4a5c-4178-08dc80a3889b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QmtvbXIrSmZTYUdSMUFaRUkra2hHL1hCb2NvRUJpeHRTSVRjNmlFRkpSU0I2?=
 =?utf-8?B?Y0NtMHNQWDgxZDNSWkZFblFNUDZwSytvYW82VmxvY2pDQ212UkFIQVA1L1BG?=
 =?utf-8?B?ZHFTVnV6eHd0OFk2M1N1Q1pHajVRL0cxY1NMeUY5WlQ3TEJUa2NFRVhOV05E?=
 =?utf-8?B?eFBpSFh0Um90QnpBSStQRlJReXhPa1pvT3diOW45aURDOUtabDFZN0M4Y1VH?=
 =?utf-8?B?SnRUL0FRSFJGb3JVZkNzVGVPaTRLUzlKSE9IMm4xR2xuTlY5Tlhlb1R3V09N?=
 =?utf-8?B?eTFXY1VhV2VEMUxmbmhaTER1UXplQWhLbjkwN3JQVWtmZ1E5dkhTR0xqbXRF?=
 =?utf-8?B?OFcvV3VEZlRWL09GQ0VraGtvMTdNc0ZKNFJTM05UU2VPTVpEYWhWRDhFSnFV?=
 =?utf-8?B?VTA2V3V1VVZIcVFnY3pBZ1ZzdWd1NDloaEd4ZitwaFI0N3RtdnQ1M1U3UkFN?=
 =?utf-8?B?TXlkK1g3c1pFK2J1V05WZHByNElMd0gxNk9KTlJNSVJKOGdMQjJicFFYeDBQ?=
 =?utf-8?B?cU1weTFOZ3ZlcldLQk0rSUFBRHlDRDBjVmN6Ukgzc1RuT01jM2lJVXRRWTRR?=
 =?utf-8?B?aXZKTUEyY2xkRWYwSCtsTGZneFk1Tm1kUDJRaVVadXBPOE4wcFA5eG1sYUti?=
 =?utf-8?B?ZEkrOGtyYWZwWE5FcGJ5TUhkcDlldElCdUEyNW56NFZDVlgxVFV2YUp3OWFn?=
 =?utf-8?B?VGZyMFM5bkl5UFNmdjQyNUl0ZXQ4R01hNjFSN0xWSGk5alhhOWZaSEZBZG1M?=
 =?utf-8?B?b2NBdFlxd29mRHF3VmpFNS91ZmZ3eEpWMU4vT0lQQVNGK1BhcmFENVd3VFI0?=
 =?utf-8?B?cHBaOHNzYVo3SVVqbGIwYmJKOFovay9Ec0NXV2dwZVh1cXVqZHd6alBTcVZH?=
 =?utf-8?B?SXVmQUNwdEhPQXFTUUpkMkYxWTJvaUo4RDc1K3YrUlFtdytxbnhveFBpbDRo?=
 =?utf-8?B?VkhCRW9kcFExL1VrSThnMWU5Yy9xRHBBK0hWZUhhYU82Vko5a29aNHJWVU9x?=
 =?utf-8?B?SmordUt2WTlMSzdzUEFzaWxEc0RncENaMGU4d3hVUW90bDJmVHR3R3JUZERQ?=
 =?utf-8?B?ckl5Q1BjOGZleDNNK2dsa1FoTjlaS3R1WXB4MVJmY1dzbHZsUlNOVVpYQmw3?=
 =?utf-8?B?bGRxaDhBOW8xa1dEMDd5RXFHeGQ1T0hBdzEwRWZSWDd6WFdkVm5XUkV4Nmg0?=
 =?utf-8?B?czZpU2JXSVdjZXpsb1JHVUVJdVRvajV5Qkp1cklYOE02bVVFOTk1Z3d0STlE?=
 =?utf-8?B?VHRQempkZ0xZNnhrSFdieVVJcUNZU2xXdGY1VldKMzQ0ay9jSHNHY25KK1dX?=
 =?utf-8?B?YisxaXliSEx1RHJnQW8xeG1jNTZOcFZrL2s5YWh2UGhzK1piSjZOOXJ0eEpa?=
 =?utf-8?B?b3duNDREeGRVM3dNV1hDdS9IN1hCaXQwRDUvU2ticHBmTHcySmpDWVYrVFhs?=
 =?utf-8?B?aHhlWUdXaW0vZ1JnS25pdzY5eVdNOTRCVkJpQkNCekl5TEp1V000QWxHR1Av?=
 =?utf-8?B?K3dFZWl3aW5pOVY0ZDdsMnppOG1sOG9kcmpTcFU0VWF1TU5BT0JXSnp0b01F?=
 =?utf-8?B?Si92MUFtcUlLNGVFN1BENGVoS3pnMVc2OU52NytVeEEzeU5BOXdNT2R0S2Zt?=
 =?utf-8?B?ckpkWk9YRkFoRVJNOEtGM0RlSTJxR3g1TFdhV2VYaFFTQXpXZjV6WTdsRUg3?=
 =?utf-8?B?WnJnWDNYM29RK0xscTN1UW1xa1hVMGg1TGhEQmg3aHJCQ1Vvak9yQS9SbU03?=
 =?utf-8?B?L3dkcXBvM01BNHdUWjdSWnRBS0tOOS9ndGY1NVdJMS9ENnhLam42SGNDbjUz?=
 =?utf-8?B?WnJPbklCVWxJc2pFbkpiQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bU15L1RyRitnQ0ZsRjdZWHUwU2hld3QwSnRYcGJiWElIa21iQU1hb1dGTWlI?=
 =?utf-8?B?Ujc2OHdheVFYWVFhcTl5M1hwS3p3K3JqY0NCYlJSb0FORGVjQVdGaEVqb1Av?=
 =?utf-8?B?akM0SHJLaGRnMERQdFF1UU1kcEFhRXkycHF0MlhOQ1JwLzN0d3NSRFpsTEZP?=
 =?utf-8?B?ZU9QS0ZmYWo0b05pemZyQ25veGtMUXBTNGlZdDJQWXRZTGdIRnVWZnNQcnY2?=
 =?utf-8?B?YVE5TC9YQytwQ3Z6c1V3U0NRallFUUJMRkRnaDlDK2g1OXhDYlBRci9xN0Fi?=
 =?utf-8?B?Q1RhQUREZURDWUR3RlZuZmowbjVTVGFLY0FYVlhwMmVrTjA5eUpUdS9jdlJj?=
 =?utf-8?B?b1BGT3hYNmZCR1ppQXhRSmt1Y3A0Q0Q5YmRjbG5WblBJdEc3RFZybmEzNEl0?=
 =?utf-8?B?SDNKMnd5aWxQK2FSQnc5dVJscyttMmNCQnZZWG13djNyNG9CdWZoWUFETVV3?=
 =?utf-8?B?Z1NGNy9SLzZVNmVQbkMrOEtOUHd0QTB5RngzWGZra0IvYkM3a0pCcEpRSWNy?=
 =?utf-8?B?S1VEQmZKWWc3V25aWDc3cnQ0YklRTXJZSFZEZEZqZ3dZR0NQWEFwZjdERUtZ?=
 =?utf-8?B?b2xEYi9TVkFxUUZMN1ZUZXVPUVFXWXpxUExqeTN1THRGUFE4ZzNqZ1ZMMzNH?=
 =?utf-8?B?SXpTZzlYRXluajFkbUNYZ3ZJTXVzeHd5N2M2d0g0bE9GYm1LK0tIaWFKMnk1?=
 =?utf-8?B?TlA5L1ZaN21UaWVsSEVlczhoMzFwSURRa09hR1gzRmI4SHBhZzNFQmxBdVl3?=
 =?utf-8?B?OTN0YktWRFo1T1FseE9JRWMrN1BUR0tUZEtTMitpbGVXZDdCR3c5dEJETnVX?=
 =?utf-8?B?MnZyT3pxNjZDVW9vcFU5QWcwRVFMVE81Y2o0cUgrQmErQXVLTnl4aC83Nnhi?=
 =?utf-8?B?NUIwUTZiNUNYSURnWDIxQXlyS1FqeWRFT21JT0VwL0dyS1QwZ2ZyVmxCWU1Q?=
 =?utf-8?B?Z0JYNzZqNjBkZEFUMWQ4WkJjZVN0L2FUMytnaXd6YW8zYmxpZDFqUHplR2dL?=
 =?utf-8?B?MlRBT3RNQWk0VldwdGVPd3hVaFRaUGU3TTlqVzQ5VjNCOERIenVvVkFORE9D?=
 =?utf-8?B?UHdOQ1dEQTdqdjdFY0xaNWcrajhabklHRTlaZ0lCaFVUanR4QVBOaFhjNFgr?=
 =?utf-8?B?b0lKeUNxV2QwOHFZNmJRd2VMZFVHbGhocy9SMFJpSTAvKzFDS1FXWThuNlhN?=
 =?utf-8?B?dy84L1JwSXJJVW9mTkM2NFlTVmY3REtmTkhEQ0FHUVhqK0thMlF5SnNqUGJm?=
 =?utf-8?B?V0xkQ0JpSk1uK3h6YUJOcFYvdlFuTHRBZlRBYzNSNzhhdjlpemg0aUFISlM3?=
 =?utf-8?B?eFhtZlZObkZ3Sk5ISUtOR3BYalFBSDMxU09KT2h6ejI0SERMZy9PYzQzYnZl?=
 =?utf-8?B?Tk5sWFo0UTI4WWZUaFJaM2Fzd1hSRjlVd2k0NjlFQ1pNSldnd25qdE5ZRVhZ?=
 =?utf-8?B?MzJUWnZWUU1yR1J2YUFvcUJNbjdkektJYmoxd2lmV0ZBdnlwZzdjYVRGZGdv?=
 =?utf-8?B?OEpWekhGUFR3aWIvVi9oTWtsaVFZM3gvL1d6UitUU3EzU01LRnFEQkloc1Bu?=
 =?utf-8?B?U2NlbUxZMmR0SWtxWENuUTZTTE5YMmYyVkJ5NWI0YnR6b1BPUnNyU0pYbE1t?=
 =?utf-8?B?S0w5akNxQ2dDakZQbGtYSUJWSC9FQitIbVpLOEdoOWxZNHNaV3BZenZ4bkRN?=
 =?utf-8?B?M1lXb0pCdHErOGR4Qm9uMDFIdFdNK0ZPOGFSVzlGVWFsb21ibmY0Skhad0RP?=
 =?utf-8?B?N21JYXBvOUNnSDlqT1VXMGdCWG9nQ2lOZk5qOXpLMUVlakdpZ1lvZDUvMUpQ?=
 =?utf-8?B?M0hIVVp4djNXQUZ1N3hZcU83bklydklYVm1EVmwwaGczYm1VN3B3WTBtWVJ6?=
 =?utf-8?B?TkMzeWZkK0ZMNzZwOWg5RTlaWkVQUnNoSFpHMUozUjB6NHpvMnZjQWVvWUh1?=
 =?utf-8?B?bUxrclRCTkhiRVh4UnpSZnRvc2ZKMExxV1BkekN4aGJySW10aCs1ZGVTM1lK?=
 =?utf-8?B?cFdiMXZSVjVESGhSakVkV3hTeHIyNUFoVm1tQ1RpT0k3V3ZEcEhoZDljSDl4?=
 =?utf-8?B?WlNsUUYrZVdPbUxsK04xMFl4WU40dWx3eW1SRFBiamtVRXFqRy9KYXNvelow?=
 =?utf-8?B?VDN3L3lETGNERHlFejVVNnUyangwenZtOFpEYXZZeEFpL1dDazVscTR6RjNE?=
 =?utf-8?Q?tlR7ZwaUymm2LJcPhtdbHNs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49D715EDC1D20447B486473CB1621A62@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461e6470-3af9-4a5c-4178-08dc80a3889b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 12:25:03.9573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rbE4hOAaWS5jtO/lDj3wHq4f314Crrq5vKEFlzEXWFkZSRRZkqrS/5HLwrU7TIeMzU7kt6Prde9+GfbwEPvr6x9DXbBVN21c7Dv58r9UJcVzpMXu6d1TkRafmeWqhyEv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB8069
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmggfCA1
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDUx
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5k
ZXggNDYxMTU4ZjU4OC4uOWUwMTI1MTMzNSAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9t
bXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAt
MTkxLDYgKzE5MSw3IEBADQogI2RlZmluZSBWVERfRUNBUF9FSU0gICAgICAgICAgICAgICAgKDFV
TEwgPDwgNCkNCiAjZGVmaW5lIFZURF9FQ0FQX1BUICAgICAgICAgICAgICAgICAoMVVMTCA8PCA2
KQ0KICNkZWZpbmUgVlREX0VDQVBfU0MgICAgICAgICAgICAgICAgICgxVUxMIDw8IDcpDQorI2Rl
ZmluZSBWVERfRUNBUF9QUlMgICAgICAgICAgICAgICAgKDFVTEwgPDwgMjkpDQogI2RlZmluZSBW
VERfRUNBUF9NSE1WICAgICAgICAgICAgICAgKDE1VUxMIDw8IDIwKQ0KICNkZWZpbmUgVlREX0VD
QVBfTkVTVCAgICAgICAgICAgICAgICgxVUxMIDw8IDI2KQ0KICNkZWZpbmUgVlREX0VDQVBfU1JT
ICAgICAgICAgICAgICAgICgxVUxMIDw8IDMxKQ0KQEAgLTM3Myw2ICszNzQsMTggQEAgdW5pb24g
VlRESW52RGVzYyB7DQogfTsNCiB0eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsN
CiANCisvKiBQYWdlIFJlcXVlc3QgRGVzY3JpcHRvciAqLw0KK3VuaW9uIFZURFBSRGVzYyB7DQor
ICAgIHN0cnVjdCB7DQorICAgICAgICB1aW50NjRfdCBsbzsNCisgICAgICAgIHVpbnQ2NF90IGhp
Ow0KKyAgICB9Ow0KKyAgICBzdHJ1Y3Qgew0KKyAgICAgICAgdWludDY0X3QgdmFsWzRdOw0KKyAg
ICB9Ow0KK307DQordHlwZWRlZiB1bmlvbiBWVERQUkRlc2MgVlREUFJEZXNjOw0KKw0KIC8qIE1h
c2tzIGZvciBzdHJ1Y3QgVlRESW52RGVzYyAqLw0KICNkZWZpbmUgVlREX0lOVl9ERVNDX1RZUEUg
ICAgICAgICAgICAgICAweGYNCiAjZGVmaW5lIFZURF9JTlZfREVTQ19DQyAgICAgICAgICAgICAg
ICAgMHgxIC8qIENvbnRleHQtY2FjaGUgSW52YWxpZGF0ZSBEZXNjICovDQpAQCAtMzg0LDYgKzM5
Nyw3IEBAIHR5cGVkZWYgdW5pb24gVlRESW52RGVzYyBWVERJbnZEZXNjOw0KICNkZWZpbmUgVlRE
X0lOVl9ERVNDX1BJT1RMQiAgICAgICAgICAgICAweDYgLyogUEFTSUQtSU9UTEIgSW52YWxpZGF0
ZSBEZXNjICovDQogI2RlZmluZSBWVERfSU5WX0RFU0NfUEMgICAgICAgICAgICAgICAgIDB4NyAv
KiBQQVNJRC1jYWNoZSBJbnZhbGlkYXRlIERlc2MgKi8NCiAjZGVmaW5lIFZURF9JTlZfREVTQ19E
RVZfUElPVExCICAgICAgICAgMHg4IC8qIFBBU0lELWJhc2VkLURJT1RMQiBpbnZfZGVzYyovDQor
I2RlZmluZSBWVERfSU5WX0RFU0NfUEdSRVNQICAgICAgICAgICAgIDB4OSAvKiBQYWdlIEdyb3Vw
IFJlc3BvbnNlIERlc2MgKi8NCiAjZGVmaW5lIFZURF9JTlZfREVTQ19OT05FICAgICAgICAgICAg
ICAgMCAgIC8qIE5vdCBhbiBJbnZhbGlkYXRlIERlc2NyaXB0b3IgKi8NCiANCiAvKiBNYXNrcyBm
b3IgSW52YWxpZGF0aW9uIFdhaXQgRGVzY3JpcHRvciovDQpAQCAtNDI1LDcgKzQzOSwxNiBAQCB0
eXBlZGVmIHVuaW9uIFZUREludkRlc2MgVlRESW52RGVzYzsNCiAjZGVmaW5lIFZURF9JTlZfREVT
Q19ERVZJQ0VfSU9UTEJfU0laRSh2YWwpICgodmFsKSAmIDB4MSkNCiAjZGVmaW5lIFZURF9JTlZf
REVTQ19ERVZJQ0VfSU9UTEJfU0lEKHZhbCkgKCgodmFsKSA+PiAzMikgJiAweEZGRkZVTEwpDQog
I2RlZmluZSBWVERfSU5WX0RFU0NfREVWSUNFX0lPVExCX1JTVkRfSEkgMHhmZmVVTEwNCi0jZGVm
aW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9MTyAweGZmZmYwMDAwZmZlMGZmZjgN
CisjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNWRF9MTyAweGZmZmYwMDAwZmZl
MGZmZjhVTEwNCisNCisvKiBNYXNrIGZvciBQYWdlIEdyb3VwIFJlc3BvbnNlIERlc2NyaXB0b3Ig
Ki8NCisjZGVmaW5lIFZURF9JTlZfREVTQ19QR1JFU1BfUlNWRF9ISSAgICAgICAgICAgICAweGZm
ZmZmZmZmZmZmZmYwMDNVTEwNCisjZGVmaW5lIFZURF9JTlZfREVTQ19QR1JFU1BfUlNWRF9MTyAg
ICAgICAgICAgICAweGZmZjAwMDAwMDAwMDBmZTBVTEwNCisjZGVmaW5lIFZURF9JTlZfREVTQ19Q
R1JFU1BfUFAodmFsKSAgICAgICAgICAgICAoKHZhbCA+PiA0KSAmIDB4MVVMTCkNCisjZGVmaW5l
IFZURF9JTlZfREVTQ19QR1JFU1BfUkModmFsKSAgICAgICAgICAgICAoKHZhbCA+PiAxMikgJiAw
eGZVTEwpDQorI2RlZmluZSBWVERfSU5WX0RFU0NfUEdSRVNQX1JJRCh2YWwpICAgICAgICAgICAg
KCh2YWwgPj4gMTYpICYgMHhmZmZmVUxMKQ0KKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BHUkVTUF9Q
QVNJRCh2YWwpICAgICAgICAgICgodmFsID4+IDMyKSAmIDB4ZmZmZmZVTEwpDQorI2RlZmluZSBW
VERfSU5WX0RFU0NfUEdSRVNQX1BSR0kodmFsKSAgICAgICAgICAgKCh2YWwgPj4gMykgJiAweDFm
ZlVMTCkNCiANCiAvKiBNYXNrIGZvciBQQVNJRCBEZXZpY2UgSU9UTEIgSW52YWxpZGF0ZSBEZXNj
cmlwdG9yICovDQogI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0FERFIo
dmFsKSAoKHZhbCkgJiBcDQpAQCAtNTQ1LDYgKzU2OCw3IEBAIHR5cGVkZWYgc3RydWN0IFZURFJv
b3RFbnRyeSBWVERSb290RW50cnk7DQogI2RlZmluZSBWVERfU01fQ09OVEVYVF9FTlRSWV9SSUQy
UEFTSURfTUFTSyAweGZmZmZmDQogI2RlZmluZSBWVERfU01fQ09OVEVYVF9FTlRSWV9SU1ZEX1ZB
TDAoYXcpICAoMHgxZTBVTEwgfCB+VlREX0hBV19NQVNLKGF3KSkNCiAjZGVmaW5lIFZURF9TTV9D
T05URVhUX0VOVFJZX1JTVkRfVkFMMSAgICAgIDB4ZmZmZmZmZmZmZmUwMDAwMFVMTA0KKyNkZWZp
bmUgVlREX1NNX0NPTlRFWFRfRU5UUllfUFJFICAgICAgICAgICAgMHgxMFVMTA0KIA0KIHR5cGVk
ZWYgc3RydWN0IFZURFBBU0lEQ2FjaGVFbnRyeSB7DQogICAgIHN0cnVjdCBWVERQQVNJREVudHJ5
IHBhc2lkX2VudHJ5Ow0KQEAgLTcwMCw0ICs3MjQsMzAgQEAgdHlwZWRlZiBzdHJ1Y3QgVlRESG9z
dElPTU1VRGV2aWNlIHsNCiAgICAgdWludDMyX3QgZXJyYXRhOw0KICAgICBRTElTVF9FTlRSWShW
VERIb3N0SU9NTVVEZXZpY2UpIG5leHQ7DQogfSBWVERIb3N0SU9NTVVEZXZpY2U7DQorDQorLyog
UGFnZSBSZXF1ZXN0IERlc2NyaXB0b3IgKi8NCisvKiBGb3IgdGhlIGxvdyA2NC1iaXQgb2YgMTI4
LWJpdCAqLw0KKyNkZWZpbmUgVlREX1BSRF9UWVBFICAgICAgICAgICAgKDFVTEwpDQorI2RlZmlu
ZSBWVERfUFJEX1BQKHZhbCkgICAgICAgICAoKHZhbCAmIDFVTEwpIDw8IDgpDQorI2RlZmluZSBW
VERfUFJEX1JJRCh2YWwpICAgICAgICAoKHZhbCAmIDB4ZmZmZlVMTCkgPDwgMTYpDQorI2RlZmlu
ZSBWVERfUFJEX1BBU0lEKHZhbCkgICAgICAoKHZhbCAmIDB4ZmZmZmZVTEwpIDw8IDMyKQ0KKyNk
ZWZpbmUgVlREX1BSRF9FWFIodmFsKSAgICAgICAgKCh2YWwgJiAxVUxMKSA8PCA1MikNCisjZGVm
aW5lIFZURF9QUkRfUE1SKHZhbCkgICAgICAgICgodmFsICYgMVVMTCkgPDwgNTMpDQorLyogRm9y
IHRoZSBoaWdoIDY0LWJpdCBvZiAxMjgtYml0ICovDQorI2RlZmluZSBWVERfUFJEX1JEUih2YWwp
ICAgICAgICAodmFsICYgMVVMTCkNCisjZGVmaW5lIFZURF9QUkRfV1JSKHZhbCkgICAgICAgICgo
dmFsICYgMVVMTCkgPDwgMSkNCisjZGVmaW5lIFZURF9QUkRfTFBJRyh2YWwpICAgICAgICgodmFs
ICYgMVVMTCkgPDwgMikNCisjZGVmaW5lIFZURF9QUkRfUFJHSSh2YWwpICAgICAgICgodmFsICYg
MHgxZmZVTEwpIDw8IDMpDQorI2RlZmluZSBWVERfUFJEX0FERFIodmFsKSAgICAgICAodmFsICYg
MHhmZmZmZmZmZmZmZmZmMDAwVUxMKQ0KKw0KKy8qIFBhZ2UgUmVxdWVzdCBRdWV1ZSBjb25zdGFu
dHMgKi8NCisjZGVmaW5lIFZURF9QUUFfRU5UUllfU0laRSAgICAgIDMyIC8qIFNpemUgb2YgYW4g
ZW50cnkgaW4gYnl0ZXMgKi8NCisvKiBQYWdlIFJlcXVlc3QgUXVldWUgbWFza3MgKi8NCisjZGVm
aW5lIFZURF9QUUFfQUREUiAgICAgICAgICAgIDB4ZmZmZmZmZmZmZmZmZjAwMFVMTCAvKiBQUiBx
dWV1ZSBhZGRyZXNzICovDQorI2RlZmluZSBWVERfUFFBX1NJWkUgICAgICAgICAgICAweDdVTEwg
LyogUFIgcXVldWUgc2l6ZSAqLw0KKyNkZWZpbmUgVlREX1BSX1NUQVRVU19QUFIgICAgICAgMVVM
IC8qIFBlbmRpbmcgcGFnZSByZXF1ZXN0ICovDQorI2RlZmluZSBWVERfUFJfU1RBVFVTX1BSTyAg
ICAgICAyVUwgLyogUGFnZSByZXF1ZXN0IG92ZXJmbG93ICovDQorI2RlZmluZSBWVERfUFJfUEVD
VExfSVAgICAgICAgICAwWDQwMDAwMDAwVUwgLyogUFIgY29udHJvbCBpbnRlcnJ1cCBwZW5kaW5n
ICovDQorI2RlZmluZSBWVERfUFJfUEVDVExfSU0gICAgICAgICAwWDgwMDAwMDAwVUwgLyogUFIg
Y29udHJvbCBpbnRlcnJ1cCBtYXNrICovDQorDQogI2VuZGlmDQotLSANCjIuNDUuMQ0K

