Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF8DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:13:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1Zn-00022f-1m; Mon, 04 Mar 2024 01:13:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rh1Zi-00022C-H8
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:13:23 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rh1Zf-0005Zn-Du
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:13:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709532799; x=1741068799;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8yvJwBKLNcserACdzaPpTMEULBYgYRKRDw2lO2VyEJU=;
 b=lcz13d3N2iN0getYIPxESpBXy59lgMVqDZMSZOnwS6T+6I7kgfdZeWMv
 j4xrMH3rEKahmF/14gtAonOVbbemfCGXtZxXzVtin2RIMjgBSk5QHBCaG
 TDMzzY3OHrZJsoGNRmyyL9NK7TsgUsNJ12uv/PVEtvKyRkTDN6NQbsOlb
 LpzSVroTqIw3Fs49OSCpNRg/UjdbJ9woZyqr5QrCpSxz/JrT7qkDRKoDx
 d3s8onR2nLQ2HYP5+F+YeOI4mZUJA1UdlEASaXqNshWeQ2EgkLuLMDhw2
 364yHVD53j5TEpF+8gqKzwqk2mlWclWTWXT6mAQPYblaTBpVVZxdeqMT9 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="29430217"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="29430217"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2024 22:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; d="scan'208";a="32050413"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Mar 2024 22:13:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 3 Mar 2024 22:13:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 3 Mar 2024 22:13:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 3 Mar 2024 22:13:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSP6VA1ErYHev1uvuqiFHVp0nyilHc/vS6D4yY7m4LOjG03RnByS5ytDT9Tzj9+FP7GtLStAxUo6ZSAUlQX8CHUzjud8SUVKGyaT5YA2j7TOtWP4nPBItpTjgoa9JqHHEU8XupbhtY27ZzinMuT65s6iHQ/CsgIN3hJM1rEPEWm/4sYe8auHtkojat5BFTXVLJNqdbatXHqGC+1v9ro2EMC32XjY4NsZnSCPCM3h228P/U0J/qpEnsrvTkYfx22M0sM29XYHORaW2pQVHoqwaEzFN0DruDOZVikzUOvPFI4kkqOdM6a/THxUXjxWtb7vDz6PvkcE1lUi2AGrk/jhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yvJwBKLNcserACdzaPpTMEULBYgYRKRDw2lO2VyEJU=;
 b=Z8eZSEm38CDfvg0YTLGZrVY+nVxqHiqEnh9NQhmhyfojivvQlszstKMs9bqW1C8cOONGtDWVSkJe9P2QPg+yK0hOgRZjl7oeflIx4s072sVWy83taiZPXZKrMmejD/mc2eFK/sFKWkO7GJTyBpEmOSxenJrpxTks1na4bW+MxcZYq/jpzCnvkaYX6v80coQyCx+eEFbGqyyZ8ShpfU/hauqsySb4vKn/AtgprYWxrBZp7LRZRJdqqmelIfIwWEaA7+euFTRrd8ukHBs+gYDnMwC4R/FJqDkpdCun7pgfPj7GVcMw/e7e3Mz2hipHLZXFAGW641/zkiFZ6N/leA+R3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Mon, 4 Mar
 2024 06:13:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 06:13:11 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Jason Wang <jasowang@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 0/6] Check and sync host IOMMU cap/ecap with vIOMMU
Thread-Topic: [PATCH v1 0/6] Check and sync host IOMMU cap/ecap with vIOMMU
Thread-Index: AQHaaisPuOWkqJe7wUCNosPjWfJN97EnAV8AgAAX/RA=
Date: Mon, 4 Mar 2024 06:13:11 +0000
Message-ID: <SJ0PR11MB674423831399B56C8A51116F92232@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <CACGkMEtadjC7sX+ssc=5LTaqrrkVZzs4DDMMiUPdPVXRLD0hJw@mail.gmail.com>
In-Reply-To: <CACGkMEtadjC7sX+ssc=5LTaqrrkVZzs4DDMMiUPdPVXRLD0hJw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SN7PR11MB6994:EE_
x-ms-office365-filtering-correlation-id: 079b09b2-3c29-42a8-68fb-08dc3c122ba3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tKueRBBrPYEXd+KRavI9Q71f//DLRd+a8qD35LzG0ATfqkJpwi44Ll2sw7mlDZ3ZU8BYTQjaIgSwov1Z0z5z2QYfc0KZgqlcdafypyfPCHho3XMJ30yzdLMrJrVtzPfRnaSWetlgJ/z5rCXSIwzyoWj41ghNUyzguWbTxi2FyccZP4FKSr9ZAvfMPkj7hTy8nQgHli0HYz/WB6vmvkLxwYpVz+30zP2soxSotIIR8qvPE9JV+qUeJjBDz6QaJvjqnv/joAE0Tep9sNHSSTaDiJ+sz4G7HV/+9h2W2PQElbSMFs6Na4wgRfeheKaq259AYj70KHx2YHe1RyMiHVunrQfJgDI1G6TdHjuEcGcdWg+Orv2FOOCZ/iCWxyKbuY7/B/R+2A72dOUg1WGL0tJHaH9IhJPy4Abz1XfgSz8NJ4IH638dDAa2yexXd9ipc2D6Eaa0quAuoxHrjF/v0FYhdcPBEzl0CYnCh8zoyPFK9eWkWDl56V+YToUmZg+bBmlyAr9e2AmkxP/aGru2GxsnTaiwn8SOowLTd4bMsmJRDHFRscZHd8umEaEchGznlOi29+Axl+uy6hGENAMzvYRKMzy0h1QsOKx2gNn7ziiML3sWeuekUJRJWuTl5agbgYmDltgJf2fB7cj9H1tqYksIm9m+9ILM3/462dKJYMP1gUqC0l/Yug2FerpWORKvHZnd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MS9kYk1kYWh3NTRmM2h3TjE4NUFiSHZoeXppUmg1dEVnN3pNbDY1Q05VZ1hx?=
 =?utf-8?B?MW5JMWhpUXJFRFdyWHUybHJYZUwyNGVCTTdib01oZzNXWUR1cnBoaTNVTmkr?=
 =?utf-8?B?K0FsNlVMQUFac29ldUNMbGtnTFNTRDlDeForQmp5b28zczh1ZUQ5dWVKM053?=
 =?utf-8?B?ZklRaURHT0VpdDdGWUtlY01hejdpbm1hTzdJbHpyY1RkcmFLL2lheXQ1ck5h?=
 =?utf-8?B?Z2IrdGdPekM4UkF4dWI4Mnd4ZDJmZTZzakk0Znc0anpEL25wRlBGSWhzYUxw?=
 =?utf-8?B?MFhuMGZSM2lqUEVuUWY2ZjB5RmVWSE4vQ3FWM3k2bjVnK2Y3M1ZiMlVaRzFN?=
 =?utf-8?B?VEc1ZGY1VmpOMzAwNUNWaHYwQmtoT2lDRGFaUkdmc1ZCSXRXT1d1bk41OVZl?=
 =?utf-8?B?WUdMSkZSS05xYXJSVlEzczd5M05UKzE3MnNEMkdtMFBYNEY5T3c2SDR1UjU3?=
 =?utf-8?B?emg2RXM0S2hvazc0WE1DMUpGSk5rYmEyVlpGYzYxZ3BZOGIybGJKNGxlejd3?=
 =?utf-8?B?Ykl4MjE0OEpmUGFFUkpZQVJPT041Wm5IZ0IvUkt6UGdTUWU2dkR2N1pYU1E4?=
 =?utf-8?B?Wk1zWkJ2L1J3bHl5aWtzOXlVUVBJT1V2azlRRlQvc21WREYzWWE3dWIxemIx?=
 =?utf-8?B?SkpaZklsYVBIZzZKTyszZUtKOEpReEZTNHE4dUF2K0tBUFExY0xraVR2aW9J?=
 =?utf-8?B?ekhVa0M2cWZsY3d1NTdhSE5PbDBuYXJNcnl3NWFiMmxmMjFuZzFFVDZySk1N?=
 =?utf-8?B?RWNheGUwc3FXODVqSXpzZ1JlaGVOUHpmTmZQRmpYYkJZRnN3S1BvMHN4YXU3?=
 =?utf-8?B?bDFzV3lDZFZGVE1haDY3a0dzQ1g4aHpwazh4Y0tBYkRpSnMyWkN2TlhnVlor?=
 =?utf-8?B?WDhmZ0xnWjh5aWV2SjF1VHN2Y2JyVWJMVVN4NldEUkJOOTljMTM3QnM4T28w?=
 =?utf-8?B?clJnQ042RGwzWm1ldWtYSFAyY1o3eGV0MUJLV0lrSHFSaEhBak44NzRoM3NX?=
 =?utf-8?B?MWwxcEVOR0dEazh5R1czcE4wdnArbjcwSDQ3eHM5bitNbFRhVFFOVUgwbVp1?=
 =?utf-8?B?TGp1NjJyWXpzeWQ1VEVQR2FDVnBRd1k2amNYNm5VTWs1aUE3VEZsWXNvL3Nm?=
 =?utf-8?B?bURqZlRabEFlb096NDNhOTVEeWZIMlZZcC9sUUJiSCtyL0Z4UkhZMFh4T1lz?=
 =?utf-8?B?R3lraHhWVlc4YjJzenkwWHpMUlliZDlOU3crR09BSDNYWUJZWkZONGlQOXVH?=
 =?utf-8?B?MXVZM3FKd3lneDVnU1pMejR6OVpIWjhxVTZ4Ui93ak8zVDI3aDh5NnJZNCtP?=
 =?utf-8?B?TU4yd1BnWUhISTJTMGljV1h5eFVvQTdQeVhHQ1lqWGFPenkrOEtmWWtUdTNh?=
 =?utf-8?B?MkxTdmo4VnVYbklYTkpFLzl0UHNqSUJjNTVuSEkwRGUwTXRYa0NIRVNGdlFI?=
 =?utf-8?B?WC9kODRGU3ZFM0d5aklQOHlISEZPU0lwOGNlR29ZUEFKTzVZTGUzam1yLzFh?=
 =?utf-8?B?VGhpb2ZxbWRuVkM3UVpNVmt3dlFvUDNQNldDbjFGUGpYU1dwZFlzL242MlpQ?=
 =?utf-8?B?ckp6SU9kNzZxRFZ1d2VWRmxhejcvNGpGWUgyT3FUa3dic1BBVGNXSnZ6ZDdN?=
 =?utf-8?B?dHp5UG5FVUFwdU1ybTZwV2k3aVFta09YdWU4WkMrdWZFN2RJQ0hVcHF5Z3E2?=
 =?utf-8?B?QjdkWXQ4RytDSXZHSW5IRGlUbzRaQjMrNWpLOUtJV2pnaTlXT3NTYVA2RTJw?=
 =?utf-8?B?NnB6R0xmbGNWaW5iR0ttZXdIMktmVGgvRUN3TVVXQWtHZStMYjJUSjc0dnZl?=
 =?utf-8?B?ZnVYQVI1bVFGRGZDQzEwUnY5NDVzRE1NTVY4WW5laWJzZm9waXl1cEt4aklC?=
 =?utf-8?B?WWtBZzVwNFBDQmtOaitVbHRITlRpcjl0NGhtSTA5V25QZER4R0d2UGJrNSsv?=
 =?utf-8?B?bmlQRjlSNTF5VHpzclFRckhNMDliUFpXeSs1ejNvUFlkVWsrMCtKWmE3ZjZC?=
 =?utf-8?B?ZnVBd1BwN1JnV01PUThjaVUxK1ZTbU1FTXZWYmNydExBS2tHWitVY0hpS2Zz?=
 =?utf-8?B?SzRnNWw5d3RzTXNXL0FwWHpKa2NWbXhiTHozSnVBQ2ZtMkVMR1RqQXVsM2xR?=
 =?utf-8?Q?pl/q/qU5TtSMjcs7GOhWGL6O7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 079b09b2-3c29-42a8-68fb-08dc3c122ba3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 06:13:11.8958 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDmJ3rgG1J5LohXzixwIei6rrP4wuDBV8fGyYugwM+DpOV1692URw8Zr4CRO/XDVpCwQSskk0VFI5m5HlKgNGKLmz5I+QEL11TeHiPixp0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAwLzZdIENoZWNrIGFuZCBz
eW5jIGhvc3QgSU9NTVUgY2FwL2VjYXAgd2l0aA0KPnZJT01NVQ0KPg0KPk9uIFdlZCwgRmViIDI4
LCAyMDI0IGF0IDU6NDbigK9QTSBaaGVuemhvbmcgRHVhbg0KPjx6aGVuemhvbmcuZHVhbkBpbnRl
bC5jb20+IHdyb3RlOg0KPj4NCj4+IEhpLA0KPj4NCj4+IEJhc2VkIG9uIEpvYW8ncyBzdWdnZXN0
aW9uLCB0aGUgaW9tbXVmZCBuZXN0aW5nIHByZXJlcXVpc2l0ZSBzZXJpZXMgWzFdDQo+PiBpcyBm
dXJ0aGVyIHNwbGl0dGVkIHRvIGhvc3QgSU9NTVUgZGV2aWNlIGFic3RyYWN0IHBhcnQgWzJdIGFu
ZCB2SU9NTVUNCj4+IGNoZWNrL3N5bmMgcGFydC4gVGhpcyBzZXJpZXMgaW1wbGVtZW50cyB0aGUg
Mm5kIHBhcnQuDQo+Pg0KPj4gVGhpcyBlbmFibGVzIHZJT01NVSB0byBnZXQgaG9zdCBJT01NVSBj
YXAvZWNhcCBpbmZvcm1hdGlvbiBieQ0KPmltcGxlbWVudGluZw0KPj4gYSBuZXcgc2V0L3Vuc2V0
X2lvbW11X2RldmljZSBpbnRlcmZhY2UsIHRoZW4gdklPTU1VIGNvdWxkIGNoZWNrIG9yDQo+c3lu
Yw0KPj4gd2l0aCB2SU9NTVUncyBvd24gY2FwL2VjYXAgY29uZmlnLg0KPg0KPkRvZXMgaXQgbWVh
biB0aGF0IGl0IHdvdWxkIHN1cHJlc3MgdGhlIGNhcC9lY2FwIGNvbmZpZyBmcm9tIHRoZSBxZW11
DQo+Y29tbWFuZCBsaW5lPw0KDQpObywgY2FwL2VjYXAgaGF2ZSB0d28ga2luZHMgb2YgYml0cywg
b25lIGlzIG5vdCBjb250cm9sbGVkIGJ5IGNtZGxpbmUsIGUuZy4sIE1HQVc7DQp0aGUgb3RoZXIg
aXMsIGUuZy4sIHdlIGluaXRpYWxpemUgU0FHQVcgdGhyb3VnaCBhd19iaXRzLg0KDQpJIHRyZWF0
IHFlbXUgY21kbGluZSB3aXRoIGhpZ2hlciBwcmlvcml0eS4gV2Ugb25seSBhbGxvdyB1cGRhdGUg
dGhvc2UgYml0cyBub3QgcmVsYXRlZA0KdG8gYW55IGNtZGxpbmUsIGUuZy4sIHVwZGF0ZSB2SU9N
TVUgTUdBVyB3aXRoIGhvc3QgTUdBVy4NCg0KSWYgdGhlcmUgaXMgY21kbGluZSBjb250cm9sbGVk
IGNhcC9lY2FwIGJpdHMgaW5jb21wYXRpYmlsaXR5IGJldHdlZW4gaG9zdCBhbmQgdklPTU1VLA0K
dmZpbyBkZXZpY2UgaG90cGx1ZyBzaG91bGQgZmFpbC4NCg0KPiBJZiB5ZXMsIEkgd29uZGVyIGhv
dyB0byBtYWludGFpbiB0aGUgbWlncmF0aW9uIGNvbXBhdGliaWxpdHkuDQoNCklmIGNhcC9lY2Fw
IGlzIHVwZGF0ZWQgZHVlIHRvIGFib3ZlIHJlYXNvbiwgSSBoYXZlIGJlbG93IHBhdGNoIHRvIGJs
b2NrIG1pZ3JhdGlvbi4NCg0KW1BBVENIIHYxIDYvNl0gaW50ZWxfaW9tbXU6IEJsb2NrIG1pZ3Jh
dGlvbiBpZiBjYXAgaXMgdXBkYXRlZA0KDQpUaGFua3MNClpoZW56aG9uZw0KDQo+DQo+VGhhbmtz
DQo+DQo+Pg0KPj4gSXQgd29ya3MgYnkgaGF2aW5nIGRldmljZSBzaWRlLCBpLmUuIFZGSU8sIHJl
Z2lzdGVyIGVpdGhlciBhbg0KPklPTU1VTGVnYWN5RGV2aWNlDQo+PiBvciBJT01NVUZERGV2aWNl
IHRvIHZJT01NVSwgd2hpY2ggaW5jbHVkZXMgbmVjZXNzYXJ5IGRhdGEgdG8gYXJjaGl2ZQ0KPnRo
YXQuDQo+PiBDdXJyZW50bHkgb25seSBWRklPIGRldmljZSBpcyBzdXBwb3J0ZWQsIGJ1dCBpdCBj
b3VsZCBhbHNvIGJlIHVzZWQgZm9yIG90aGVyDQo+PiBkZXZpY2VzLCBpLmUuLCBWRFBBLg0KPj4N
Cj4+IEZvciBjb2xkcGx1Z2dlZCBkZXZpY2UsIHdlIGNhbiBnZXQgaXRzIGhvc3QgSU9NTVUgY2Fw
L2VjYXAgZHVyaW5nIHFlbXUNCj5pbml0LA0KPj4gdGhlbiBjaGVjayBhbmQgc3luYyBpbnRvIHZJ
T01NVSBjYXAvZWNhcC4NCj4+IEZvciBob3RwbHVnZ2VkIGRldmljZSwgdklPTU1VIGNhcC9lY2Fw
IGlzIGZyb3plbiwgd2UgY291bGQgb25seSBjaGVjaw0KPndpdGgNCj4+IHZJT01NVSBjYXAvZWNh
cCwgbm90IGFsbG93ZWQgdG8gdXBkYXRlLiBJZiBjaGVjayBmYWlscywgaG90cGx1Z2dlZCB3aWxs
DQo+ZmFpbC4NCj4+DQo+PiBUaGlzIGlzIGFsc28gYSBwcmVyZXF1aXNpdGUgZm9yIGluY29taW5n
IGlvbW11ZmQgbmVzdGluZyBzZXJpZXM6DQo+PiAnaW50ZWxfaW9tbXU6IEVuYWJsZSBzdGFnZS0x
IHRyYW5zbGF0aW9uJy4NCj4+DQo+PiBJIGRpZG4ndCBpbXBsZW1lbnQgY2FwL2VjYXAgc3luYyBm
b3IgbGVnYWN5IFZGSU8gYmFja2VuZCwgd291bGQgbGlrZSB0bw0KPnNlZQ0KPj4gd2hhdCBFcmlj
IHdhbnQgdG8gcHV0IGluIElPTU1VTGVnYWN5RGV2aWNlIGZvciB2aXJ0aW8taW9tbXUgYW5kIGlm
IEkgY2FuDQo+PiB1dGlsaXplIHNvbWUgb2YgdGhlbS4NCj4+DQo+PiBCZWNhdXNlIGl0J3MgYmVj
b21pbmcgY2xlYXIgb24gY29tbXVuaXR5J3Mgc3VnZ2VzdGlvbiwgSSdkIGxpa2UgdG8gcmVtb3Zl
DQo+PiByZmMgdGFnIGZyb20gdGhpcyB2ZXJzaW9uLg0KPj4NCj4+IFFlbXUgY29kZSBjYW4gYmUg
Zm91bmQgYXQ6DQo+Pg0KPmh0dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS90cmVlL3po
ZW56aG9uZy9pb21tdWZkX25lc3RpbmdfcHJlDQo+cV9wYXJ0Ml92MQ0KPj4NCj4+IFsxXSBodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsLzIwMjQwMjAxMDcyODE4LjMyNzkzMC0xLQ0K
PnpoZW56aG9uZy5kdWFuQGludGVsLmNvbQ0KPj4gWzJdIGh0dHBzOi8vbGlzdHMuZ251Lm9yZy9h
cmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI0LQ0KPjAyL21zZzA2MzE0Lmh0bWwNCj4+DQo+PiBU
aGFua3MNCj4+IFpoZW56aG9uZw0KPj4NCj4+IENoYW5nZWxvZzoNCj4+IHYxOg0KPj4gLSBjb252
ZXJ0IEhvc3RJT01NVURldmljZSB0byBzdWIgb2JqZWN0IHBvaW50ZXIgaW4gdnRkX2NoZWNrX2hk
ZXYNCj4+DQo+PiByZmN2MjoNCj4+IC0gaW50cm9kdWNlIGNvbW1vbiBhYnN0cmFjdCBIb3N0SU9N
TVVEZXZpY2UgYW5kIHN1YiBzdHJ1Y3QgZm9yDQo+ZGlmZmVyZW50IEJFcyAoRXJpYywgQ8OpZHJp
YykNCj4+IC0gcmVtb3ZlIGlvbW11ZmRfZGV2aWNlLltjaF0gKEPDqWRyaWMpDQo+PiAtIHJlbW92
ZSBkdXBsaWNhdGUgaW9tbXVmZC9kZXZpZCBkZWZpbmUgZnJvbSBWRklPRGV2aWNlIChFcmljKQ0K
Pj4gLSBkcm9wIHRoZSBwIGluIGFsaWFzZWRfcGJ1cyBhbmQgYWxpYXNlZF9wZGV2Zm4gKEVyaWMp
DQo+PiAtIGFzc2VydCBkZXZmbiBhbmQgaW9tbXVfYnVzIGluIHBjaV9kZXZpY2VfZ2V0X2lvbW11
X2J1c19kZXZmbg0KPihDw6lkcmljLCBFcmljKQ0KPj4gLSB1c2UgZXJycCBpbiBpb21tdWZkX2Rl
dmljZV9nZXRfaW5mbyAoRXJpYykNCj4+IC0gc3BsaXQgYW5kIHNpbXBsaWZ5IGNhcC9lY2FwIGNo
ZWNrL3N5bmMgY29kZSBpbiBpbnRlbF9pb21tdS5jIChDw6lkcmljKQ0KPj4gLSBtb3ZlIFZUREhv
c3RJT01NVURldmljZSBkZWNsYXJhdGlvbiB0byBpbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+KEPD
qWRyaWMpDQo+PiAtIG1ha2UgJyh2dGQtPmNhcF9yZWcgPj4gMTYpICYgMHgzZlVMTCcgYSBNQUNS
TyBhbmQgYWRkIG1pc3NlZCAnKzEnDQo+KEPDqWRyaWMpDQo+PiAtIGJsb2NrIG1pZ3JhdGlvbiBp
ZiB2SU9NTVUgY2FwL2VjYXAgdXBkYXRlZCBiYXNlZCBvbiBob3N0IElPTU1VDQo+Y2FwL2VjYXAN
Cj4+IC0gYWRkIFItQg0KPj4NCj4+DQo+PiBZaSBMaXUgKDIpOg0KPj4gICBpbnRlbF9pb21tdTog
QWRkIHNldC91bnNldF9pb21tdV9kZXZpY2UgY2FsbGJhY2sNCj4+ICAgaW50ZWxfaW9tbXU6IEFk
ZCBhIGZyYW1ld29yayB0byBjaGVjayBhbmQgc3luYyBob3N0IElPTU1VIGNhcC9lY2FwDQo+Pg0K
Pj4gWmhlbnpob25nIER1YW4gKDQpOg0KPj4gICBpbnRlbF9pb21tdTogRXh0cmFjdCBvdXQgdnRk
X2NhcF9pbml0IHRvIGluaXRpYWxpemUgY2FwL2VjYXANCj4+ICAgaW50ZWxfaW9tbXU6IEltcGxl
bWVudCBjaGVjayBhbmQgc3luYyBtZWNoYW5pc20gaW4gaW9tbXVmZCBtb2RlDQo+PiAgIGludGVs
X2lvbW11OiBVc2UgbWdhdyBpbnN0ZWFkIG9mIHMtPmF3X2JpdHMNCj4+ICAgaW50ZWxfaW9tbXU6
IEJsb2NrIG1pZ3JhdGlvbiBpZiBjYXAgaXMgdXBkYXRlZA0KPj4NCj4+ICBody9pMzg2L2ludGVs
X2lvbW11X2ludGVybmFsLmggfCAgIDkgKysNCj4+ICBpbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9t
bXUuaCAgfCAgIDQgKw0KPj4gIGh3L2kzODYvYWNwaS1idWlsZC5jICAgICAgICAgICB8ICAgMyAr
LQ0KPj4gIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI4NyArKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0NCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDI0NSBpbnNlcnRpb25z
KCspLCA1OCBkZWxldGlvbnMoLSkNCj4+DQo+PiAtLQ0KPj4gMi4zNC4xDQo+Pg0KDQo=

