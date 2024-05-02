Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD19C04FFE
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2YNt-000445-NN; Thu, 02 May 2024 11:30:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNl-0003xw-SY
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:01 -0400
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2YNj-0005z0-TW
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714663799; x=1746199799;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=utCfpqA582zPDO3rI6/KuwFYiXteNmSye6BL+9lf4fs=;
 b=rEL1F/dASthvxkmAFIsXLtejVF1w8V6Ylk7zAU55C4U44vNdIxfrgpMI
 CLEqbc18NdeNyktnd4UKqYO8GUVSQE4YMaQGG9/AWVZq9fS3IIuyztE4z
 9Jw3/GVL+yGxFSsryNXrL+T1vQfDIkWvlWYz6tF5UeAaOSIMfhn3oV1NJ
 zZagEmWw5i8e0VuZOJ2pM/PjtyYKaifppdsKVC+L79RXx0klepJyI5wBB
 M0dc8rhscagdXA1j6/uMVUd1UenWBg1fO6WX/gJ/Wn7U42R13IvddRkSN
 FlbBjaeLEZaXSoqx6BD6juvt9P8cmqWULlRpBgBVr5gRoaonCud2wK6Ix w==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11785886"
X-MGA-submission: =?us-ascii?q?MDHgAXYiiHTKaGc0ZQWAV4XE3sg4DQSnWvuU33?=
 =?us-ascii?q?SWiJM3P2QVUcJYNlD+7BWdz7dP24pjanX0AjmjF0jcwAsfyuxFKPx3iL?=
 =?us-ascii?q?7QOGqIAA/NXCTjfYdVxsXuGcPGyiiyn66cWXwNqgkP9sVXja7aZC7X0q?=
 =?us-ascii?q?ZUzE2oiDF6h8DfxKyndWeuyQ=3D=3D?=
Received: from mail-db8eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-DB8-obe.outbound.protection.outlook.com) ([104.47.17.104])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 17:29:22 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhH+uahRahSYoO8FehLbyrRTiohKjKg4eRpNVZ8Qeh5bAcvxrT9GH+va8YVaxTKIohS4MJG7UCr3s7qmhqF8TPKa8uLVrPfqWWB/JQWLb/VRXWbvxdCPtjjAe+Uz/gyJFyjDVfNWzfVwNzJbPPdbQFAe7VmtTdjCekv8VG/uPbvqCwKo0GF6VgdeJDIad4BCpnC0ims1RssrA3uXYfsBOBLyDLM/Eg/F847UupPMGYHsIUZ1QWeZAmwUHHRKJaz5looKxMgKSunINplVosIGROqnr2H2ZRzeDjwy8hSv9lLSkJvcElH/VXJFZqqpvdr+pxUnWzlDiv3gLUOLLPCzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utCfpqA582zPDO3rI6/KuwFYiXteNmSye6BL+9lf4fs=;
 b=mS2qGpdM7LMqSu2H4ob2PaLV66/HNeX0ajBvGH4idzTcN+QCkM0WGgr/HM67pKXtBXiEkm6+sXybdIX2D6S/lWmvf2/ihJn3SY1wVxjKow4ia6569DJ1joRSGS+hLaxhPzzMYHKc5Gzk+pyo9tznNM80YcJiigJpE0dhobsQS7BigrhvRaPQyMalDp8npmxsq58RBD3uTAySuVcmpc/hLOhQdRm++TL3ogFi1eJT2svRAKSqB4I7pKgKic/MUYLT/WZWWahflf98zp/i+VI5UpGkY13qPrvuKuZZjjOW98KEgeVDSKESyhD81pgOMY780d774kMr5BJihANfzS8Hsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PAWPR07MB9661.eurprd07.prod.outlook.com (2603:10a6:102:389::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 15:29:19 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 15:29:19 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>, CLEMENT
 MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v1 12/24] intel_iommu: add support for PASID-based
 device IOTLB invalidation
Thread-Topic: [PATCH ats_vtd v1 12/24] intel_iommu: add support for
 PASID-based device IOTLB invalidation
Thread-Index: AQHanKWAR9D3bMixykiyWgUWFlxu2A==
Date: Thu, 2 May 2024 15:29:19 +0000
Message-ID: <20240502152810.187492-13-clement.mathieu--drif@eviden.com>
References: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240502152810.187492-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PAWPR07MB9661:EE_
x-ms-office365-filtering-correlation-id: 7ca59488-8d39-4054-2f81-08dc6abca2aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?RSsrRzNUQ05pd1pVeTV6aFhjd2xCQ3k4blBka3NGSEVvR3ZmdTdQL1I2NXM0?=
 =?utf-8?B?MlNNbTRtd1NGSWNEM0V1QzhOM2FwVk5LU016L1hCNmMrM2RxdHNKMVZTK24w?=
 =?utf-8?B?M0lINjVtbERnWDZZRWY5bjl1VFh3aDhHZGp5K3RXQW9wOXR2RjV4MkF1RElo?=
 =?utf-8?B?ckp5UzRyMlJUM20rcGkxWkgxaWhkT3pacTFTY3U2Y2p4N0RiZFJqY1VIRlV5?=
 =?utf-8?B?b0VlTEFJUGlBRU5BeEtvWU1PN0JPbXNObnRJZDFIampqc1V5UkFKWE5qdmE1?=
 =?utf-8?B?djlXM3czcHNpU1JkNi92bVNBTzhkWDFDWnNIdHBFaTNYTVRLVEtweW9LYXkv?=
 =?utf-8?B?YmhQbzNlWkJSeTRTaGs0Z2JvUVp1NmJ5ZzJWWHpwUUg5djF6cmZLZlZyTzRz?=
 =?utf-8?B?UXpJYUFleFV1MEg4a1pWMDV5bUN5aWJyekVGV1JjVER2c1d4bmVXUVFWdjRK?=
 =?utf-8?B?L2o0bGNmaERXMTkybU5KcVlNZHNTbGorZmxFQXVJNjBoNmx2VHd3cmRkNjk5?=
 =?utf-8?B?aE5mVE14dDFBUGJDLzc4WklYRkJPL0RlVE1nN1ZvSHRiQ1hoLys0cXJqQVA3?=
 =?utf-8?B?a0kyV2hmMmt0ZUo2elI1MjZpVk5oTVBDSmpiT2t6cnh5ZEtVaStmMHJzYUhv?=
 =?utf-8?B?dU5WY3hNcyttRDF6VzVxTEM1M1hUdkpLNUI5cmhGajFXRWM0ZnVIdzQ5dTQv?=
 =?utf-8?B?bTFoVk1LSEc1Y2JXbVozT0pTcGxodlNLS0pTNkJOVGNWNmJLNm9QTlNzQlAr?=
 =?utf-8?B?YnRBSmcxU2xNZ0lOTEhHNWtPMWsvTWNmQVJQNDVWdE1KRHBpclRWc2twRlQ1?=
 =?utf-8?B?QVNtdVdvYXA5emZvYk9xZW1jVmdGNVZXdy80ems5YmE4bDNXTk9XVjVxRm5q?=
 =?utf-8?B?cFJSM1p5d2FjbHJTMTZsWXZVQ3JMYjk3bTIwc1ZIc1hwakdxQ3BzTURnNzhK?=
 =?utf-8?B?Q0NGRWFoaWFQUThiOGZOdFlXbkkrVTh2aDRTdXhPK0ZZMnlveWcreWxBVzNI?=
 =?utf-8?B?ZjVzRU5ENFJONm9RNkVyVFNTVEVQaU9HNW9Sa29XWU50YldKRUFSOVZVUmVB?=
 =?utf-8?B?eDl6TlVHSTZkMk8xcy9ZanpSRFFmZHNVeVBhSkJGUy8vQlREc0Z1ckN6bzBY?=
 =?utf-8?B?WmRqQXpQRG9SOEd1K3dlSmd5N0MvcEJER1NsUTl3MktUeEt4WmJtQnUvZStL?=
 =?utf-8?B?VUpHazkwNytYOGZzTlR6SE54TVMyU0lQWDJoUW5KT2tKVEI2MmQzNnpTdWpC?=
 =?utf-8?B?L1kwczNCemF5Y0RKbTAvb29WaWxKTHRTUU1xMjl1aTR0dEY1L1UxRVFpRnJU?=
 =?utf-8?B?TWpDNXA3dTFURmw0RWpqbmR0RWVHWmZYSS9lMEZzZHR3U2lERm0rMk9kcmlS?=
 =?utf-8?B?VzkzREVZMGtPNFpjVG5JbU12UXI0U3g5aTJiYkFqRi9qT1k5VHNFVDVpMmFW?=
 =?utf-8?B?MGNjeTJOQnFUZmlMNkFUbXlMSFpQM3UzQXlDcmpmWFNoL24xcWhHd2xKT3Uw?=
 =?utf-8?B?VzJzdVFnVkNiY3Qxc2VOS1pEUCt0QzB6eEtkellid0RtMEx0b0sxQWpxc1Ft?=
 =?utf-8?B?Yit0K0VYbVJFa1F3REs1MHArTk5CQ3ZMZ002ZWIraDRmK2JtRzRwUFFidXFX?=
 =?utf-8?B?bXJTTnJPRzVneUpEU3dyVEk2bHlWYkpSQ09IOEVaa2tqdHhLRVFLelZ4WSt2?=
 =?utf-8?B?YkZuT3NOQkVVbXl4Zm9qWW5CTGpsRXU2UnUzVG11OU9rYlhXL1l4Z0NKbGlZ?=
 =?utf-8?B?MEZnakNqb2hVNkYwOFovM2xHd0JZR2UwazA3N3VhNDJ4c1g1cE83R0diRHZi?=
 =?utf-8?B?N25Vd1NVUVdsbHcvSml4UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUZ6aGFReVZnUVJLb0dqYWZkQW1WQnlHeWl6ZGJSMXY3T0ZCdmp3MXFzVkFI?=
 =?utf-8?B?clVpR2NtV1NuTjdDV014YVpEUVJxb1l3cFpCZTRKMkVxdzVwUGFsRUh1L21h?=
 =?utf-8?B?YmZoYUE4ZUtCcjhJWm9DR0R3MlRRcnMyZzVkNHd2YlBZakZ5RFZBY0Y4eCtS?=
 =?utf-8?B?OVZLOHVSZk1JWWl6WW9DVEVnaURZVU9adkttY2grYnREd0wyb042dTJ1L1FY?=
 =?utf-8?B?OEpYcDYwcnNhTlNPRXBjWkEvOGxYRzNOUmNFRXhpdVVDUThUUUpQV2FNaTJW?=
 =?utf-8?B?SzhYOWExZG85UStEUmlZVFB0WDc2bk50K2pQK3NkUng3SVJjSEdubUhhRVM2?=
 =?utf-8?B?YkRUVFVyVmVNdUtldkdhakZ5SklSRGpNa0FrU2VaMDNuTk5kMWZUSm5IN2ZD?=
 =?utf-8?B?SW1WK2t1L2tyVHVjQlZyZ2FwVllPQmtnbHZMeTZzek42ZklPWWhDMXVZeklI?=
 =?utf-8?B?NzRpUzErNElVTldXeWxVSVd5a1kzd0VGQ1JUaHdZeFMzVlpNdXNnUDNPanV5?=
 =?utf-8?B?TzdjRURFaGFhdVp3Q2ZLYnVnbVNCM2ZyOVJlUkNOenNNZWxaZzc4UDI1Vk1a?=
 =?utf-8?B?Rk1yNTdwSDJsMm1DQTJ1NDYrVlRXOTJnZ0x3Q1dCVjg1OHY3VGR4ZGpuYVZt?=
 =?utf-8?B?RXluNWRGWUxscS91emp6bDNYc3I5TlJBZWZ4MVBJSWVPVTVER1pvOTgyREFW?=
 =?utf-8?B?eWV5dWdBTS9hMlFTekdVSi9OUmUyZllqVXBOQjBqTXBOOTRVemdWMEtjdlFZ?=
 =?utf-8?B?VDZVeUNjcnI5Ukp0L3NkWU1uVk8rSzB2OFlGcjh4YTBGM29VM2FuUkpSTldv?=
 =?utf-8?B?M3RXVkZiZFljSVVISnNBcWl0N1JGazQxcVVtK1VXQXRTWm4wcWJxaE9XcXNH?=
 =?utf-8?B?QmI0QUFnT1RwUklaUVJldzYvUmJyWGpmSXNOMFNGVmhLMWJsMXhsdG9NZEZY?=
 =?utf-8?B?ZWNlK25yKzZyOCsrUm9qYTFRL2cvdHk3RFFCaFYrME9nN3Z6TnpSTzVKQjVM?=
 =?utf-8?B?eERFYzJVdzg0REpWV3pVanhhOXlCQ2hZS25jZDJtYk5pUTBFUWIyUndQb0Vn?=
 =?utf-8?B?SngvRm1zREdBZm1ZZ2NKU0Q1Mm8rYllITkpJQklOK25aUVpKZldpaitGaWFa?=
 =?utf-8?B?WTNqNXYvRDJQZHUzMllrNTZnUFY0VlBJQTgrWVIrZDdwN2ZXVTFiUUorNXpn?=
 =?utf-8?B?K2NQUXNmUkIrVlVwQ0RiRXZVUlg4eDBYeTlKRHdUeFBFditQQWJPQkRWNStS?=
 =?utf-8?B?VkRHOGVacjl4WVZ5MlMxcFJVcmF2OEhLYWVDWFpJbnJWZWowUmRjU3N5L0dE?=
 =?utf-8?B?Z2Y4SXQvOEltUFpQOFUrUk5iWUNYUTcrRVBtTjhWQ0tUVXNkd25nYkdtRE9S?=
 =?utf-8?B?blJhVFNkb0tYcmM1UnNlRVhWUENNbnFHbVN2Zll5MEZWd1hpb3VxbnJjUnpZ?=
 =?utf-8?B?UmE0UlBCZXN5eW9sYXBQSG5ia0xhNGxoMTBYbC9CSXdoSndLUWpMRXFFbFpN?=
 =?utf-8?B?dnVkU0ZVTXA2cXRRTnIydFE5ME5BRzR0Z0R6MStHaWM2cittazM0ZzlmTmd3?=
 =?utf-8?B?dVRPTStSVkZZV3V2WWV0Qk55OTZpcHgrRFQwaXhIOHkzbGNld0Z1cEFyU28w?=
 =?utf-8?B?aWNiS0syc2xwTlNDZmtGb3lIM3hZRUJvYmQybS80c2ptTmNLb0FVc2wrZDBX?=
 =?utf-8?B?OVRNNDNIUlJxdmRoSm5PejAvUXkwY3ZpaWR3YjNCVHc4V0M4REhCNER1elkr?=
 =?utf-8?B?RlJKWWVyd2hKU2Z0a3A2eGV6OTljNVVsWVpFb3JyZldHUU9hb1VEbmoxcnpB?=
 =?utf-8?B?R1dCT0twblNkeVIrQ1cwTVJ3dWhROWlaYzNxditNelBVc2plbEQzWjZMMitZ?=
 =?utf-8?B?aDdIUFZNWDJjczF2V1RmUEhyNFRzYlB2MEwvcFR5enRhbTZCQ0t2dlVTd1hu?=
 =?utf-8?B?YnROSWRBcHpxRTRhK1Nvc2U5UmN3eTd1UFEvcmwxSVhWb1dENG0wUHEwcWts?=
 =?utf-8?B?dFRUYjdSbEw5a0hSZFM2SHpBc1ZRR3VwQTUwb2JVcXZjaVJoTkNQOTA1RmJK?=
 =?utf-8?B?R1Ewb0NtMUt6dGVaSXU3L3JuTDlDSk5CeXovMXZTVEF6eHVNY3BBZHFlWmRP?=
 =?utf-8?B?Mno2SVR3S0dNWFRNWkdsWVQ5Sk5PRnFRTHhWY3ZnRlhHZ3RPMVowb1pDQ2ZD?=
 =?utf-8?Q?uL/UaFr4h8HbZgXA30K/kAs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4038642DA5248349BEDC0B7947FA5F84@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca59488-8d39-4054-2f81-08dc6abca2aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 15:29:19.4281 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GjS89IZwGBRrhrh1aldwS0yoKiLnOpOpXO7RtvVWG+n/9qREPQOcd+hrJEmf9WJmo/Ez9L7Sdd4ocytWSmsUtkTVvSj88GfgS1/JJ3TaGBgxJ8OKYDFRDgmYYI/QU4g4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB9661
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

U2lnbmVkLW9mZi1ieTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1k
cmlmQGV2aWRlbi5jb20+DQotLS0NCiBody9pMzg2L2ludGVsX2lvbW11LmMgICAgICAgICAgfCA0
MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21t
dV9pbnRlcm5hbC5oIHwgMTAgKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlv
bnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCmluZGV4IGZlOTc5MzA3NzQuLmU3YzFhNTU4MmEg
MTAwNjQ0DQotLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KQEAgLTQzNDQsMTEgKzQzNDQsNDMgQEAgc3RhdGljIHZvaWQgZG9faW52YWxpZGF0
ZV9kZXZpY2VfdGxiKFZUREFkZHJlc3NTcGFjZSAqdnRkX2Rldl9hcywNCiBzdGF0aWMgYm9vbCB2
dGRfcHJvY2Vzc19kZXZpY2VfcGlvdGxiX2Rlc2MoSW50ZWxJT01NVVN0YXRlICpzLA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWVERJbnZEZXNjICppbnZfZGVz
YykNCiB7DQotICAgIC8qDQotICAgICAqIG5vIG5lZWQgdG8gaGFuZGxlIGl0IGZvciBwYXNzdGhy
dSBkZXZpY2UsIGZvciBlbXVsYXRlZA0KLSAgICAgKiBkZXZpY2VzIHdpdGggZGV2aWNlIHRsYiwg
aXQgbWF5IGJlIHJlcXVpcmVkLCBidXQgZm9yIG5vdywNCi0gICAgICogcmV0dXJuIGlzIGVub3Vn
aA0KLSAgICAgKi8NCisgICAgdWludDE2X3Qgc2lkOw0KKyAgICBWVERBZGRyZXNzU3BhY2UgKnZ0
ZF9kZXZfYXM7DQorICAgIGJvb2wgc2l6ZTsNCisgICAgYm9vbCBnbG9iYWw7DQorICAgIGh3YWRk
ciBhZGRyOw0KKyAgICB1aW50MzJfdCBwYXNpZDsNCisNCisgICAgaWYgKChpbnZfZGVzYy0+aGkg
JiBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1JTVkRfSEkpIHx8DQorICAgICAgICAg
KGludl9kZXNjLT5sbyAmIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9MTykp
IHsNCisgICAgICAgIGVycm9yX3JlcG9ydF9vbmNlKCIlczogaW52YWxpZCBwYXNpZC1iYXNlZCBk
ZXYgaW90bGIgaW52IGRlc2M6Ig0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgImhpPSUiUFJJ
eDY0ICIocmVzZXJ2ZWQgbm9uemVybykiLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgX19m
dW5jX18sIGludl9kZXNjLT5oaSk7DQorICAgICAgICByZXR1cm4gZmFsc2U7DQorICAgIH0NCisN
CisgICAgZ2xvYmFsID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9HTE9CQUwoaW52
X2Rlc2MtPmhpKTsNCisgICAgc2l6ZSA9IFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJf
U0laRShpbnZfZGVzYy0+aGkpOw0KKyAgICBhZGRyID0gVlREX0lOVl9ERVNDX1BBU0lEX0RFVklD
RV9JT1RMQl9BRERSKGludl9kZXNjLT5oaSk7DQorICAgIHNpZCA9IFZURF9JTlZfREVTQ19QQVNJ
RF9ERVZJQ0VfSU9UTEJfU0lEKGludl9kZXNjLT5sbyk7DQorICAgIGlmIChnbG9iYWwpIHsNCisg
ICAgICAgIFFMSVNUX0ZPUkVBQ0godnRkX2Rldl9hcywgJnMtPnZ0ZF9hc193aXRoX25vdGlmaWVy
cywgbmV4dCkgew0KKyAgICAgICAgICAgIGlmICgodnRkX2Rldl9hcy0+cGFzaWQgIT0gUENJX05P
X1BBU0lEKSAmJg0KKyAgICAgICAgICAgICAgICAoUENJX0JVSUxEX0JERihwY2lfYnVzX251bSh2
dGRfZGV2X2FzLT5idXMpLA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICB2dGRfZGV2X2FzLT5kZXZmbikgPT0gc2lkKSkgew0KKyAgICAgICAgICAgICAgICBkb19p
bnZhbGlkYXRlX2RldmljZV90bGIodnRkX2Rldl9hcywgc2l6ZSwgYWRkcik7DQorICAgICAgICAg
ICAgfQ0KKyAgICAgICAgfQ0KKyAgICB9IGVsc2Ugew0KKyAgICAgICAgcGFzaWQgPSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1BBU0lEKGludl9kZXNjLT5sbyk7DQorICAgICAgICB2
dGRfZGV2X2FzID0gdnRkX2dldF9hc19ieV9zaWRfYW5kX3Bhc2lkKHMsIHNpZCwgcGFzaWQpOw0K
KyAgICAgICAgaWYgKCF2dGRfZGV2X2FzKSB7DQorICAgICAgICAgICAgcmV0dXJuIHRydWU7DQor
ICAgICAgICB9DQorDQorICAgICAgICBkb19pbnZhbGlkYXRlX2RldmljZV90bGIodnRkX2Rldl9h
cywgc2l6ZSwgYWRkcik7DQorICAgIH0NCisNCiAgICAgcmV0dXJuIHRydWU7DQogfQ0KIA0KZGlm
ZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxf
aW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggZDYzZmYwNDlhNy4uM2Q1OWUxMDQ4OCAxMDA2NDQNCi0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdV9pbnRlcm5hbC5oDQpAQCAtNDI0LDYgKzQyNCwxNiBAQCB0eXBlZGVmIHVuaW9uIFZURElu
dkRlc2MgVlRESW52RGVzYzsNCiAjZGVmaW5lIFZURF9JTlZfREVTQ19ERVZJQ0VfSU9UTEJfUlNW
RF9ISSAweGZmZVVMTA0KICNkZWZpbmUgVlREX0lOVl9ERVNDX0RFVklDRV9JT1RMQl9SU1ZEX0xP
IDB4ZmZmZjAwMDBmZmUwZmZmOA0KIA0KKy8qIE1hc2sgZm9yIFBBU0lEIERldmljZSBJT1RMQiBJ
bnZhbGlkYXRlIERlc2NyaXB0b3IgKi8NCisjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJ
Q0VfSU9UTEJfQUREUih2YWwpICgodmFsKSAmIFwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAweGZmZmZmZmZmZmZmZmYwMDBVTEwpDQorI2RlZmlu
ZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1NJWkUodmFsKSAoKHZhbCA+PiAxMSkg
JiAweDEpDQorI2RlZmluZSBWVERfSU5WX0RFU0NfUEFTSURfREVWSUNFX0lPVExCX0dMT0JBTCh2
YWwpICgodmFsKSAmIDB4MSkNCisjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9U
TEJfU0lEKHZhbCkgKCgodmFsKSA+PiAxNikgJiAweGZmZmZVTEwpDQorI2RlZmluZSBWVERfSU5W
X0RFU0NfUEFTSURfREVWSUNFX0lPVExCX1BBU0lEKHZhbCkgKCh2YWwgPj4gMzIpICYgMHhmZmZm
ZlVMTCkNCisjZGVmaW5lIFZURF9JTlZfREVTQ19QQVNJRF9ERVZJQ0VfSU9UTEJfUlNWRF9ISSAw
eDdmZVVMTA0KKyNkZWZpbmUgVlREX0lOVl9ERVNDX1BBU0lEX0RFVklDRV9JT1RMQl9SU1ZEX0xP
IDB4ZmZmMDAwMDAwMDAwZjAwMFVMTA0KKw0KIC8qIFJzdmQgZmllbGQgbWFza3MgZm9yIHNwdGUg
Ki8NCiAjZGVmaW5lIFZURF9TUFRFX1NOUCAweDgwMFVMTA0KIA0KLS0gDQoyLjQ0LjANCg==

