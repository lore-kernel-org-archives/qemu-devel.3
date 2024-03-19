Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7DFC54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 03:13:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmPuV-0008K1-Cg; Mon, 18 Mar 2024 23:13:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmPuS-0008Jn-Hp
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:13:04 -0400
Received: from mgamail.intel.com ([192.198.163.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rmPuL-0000Cj-2J
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 23:13:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710817977; x=1742353977;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0kqfRU/i4He8QG6fOXxypIy5lfa5KDpASjRIMBg8Bvc=;
 b=SCiUInODT09f8uRfrDxOYU4EZHcZmDiTnxudLRI6xif5FYc1IAdTU/4b
 2ghVTpaOv/UOqPqw51SQTEnRJjjLOd5yZK2vapfDe4/a4MIv+bJD/rIR5
 H9eldLv5cXbpN/qfZET+gmvijfeYIauUKc2hz6vBI7zDpBc9QB3XHaaor
 5UarRWI5+3NW2MNbYldMDdMifvz5xUeF1+BO5lESIAj91kABtkPxv9uAu
 1WYb0CC90EEwYoFjHt8sigqVyp0PNW/xq0EDit9JI0m1ZRGg+abpYO2M5
 2FYOgPf58ZSJh8J24wFG0rYrF4FNahsJzsBCso3OipnzoBcYtucyvERyX Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="9433518"
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; 
   d="scan'208";a="9433518"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Mar 2024 20:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,135,1708416000"; d="scan'208";a="18293351"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Mar 2024 20:12:48 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 18 Mar 2024 20:12:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 18 Mar 2024 20:12:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 20:12:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4nUwCvKVxzS/PY/QhbFkwxf5bdPCKX/LjAlKoK9LNLncyWIX1G6YZAAJ4K/XHZV5Vsy/GyEvKB9l1nogxlQMOVANrDIDyHtqw4mK+waPm0MHb8HARqg3fikYXz1eEZBn0AJUCH2Xu/EGE+NtzlLHodcA3Au88I5o7z1nEIG7vqd57DKq8rB0PKKut4KIqd5tSopMCWgL4ZClmuTbyazS86ZT4aHKPxixDIDkg3rqkKybjrlmJtyTgRwCdY1+7Nr0gXyR44S+ZWyQaSP3ym49sMXnUcTWVntKkGpSCwx4MA0f8ilncokXMTUbPbkgDM3nzPHUHKtLDHEAiCjwBuKQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0kqfRU/i4He8QG6fOXxypIy5lfa5KDpASjRIMBg8Bvc=;
 b=oa1tJxg00pfrIzEInnRYh7FwHeOrYx4qFwYz31wVKGYElQpIk4vsxSmOwZ4HHEq5KWmK7/0wvAxm1+Qr4YGKv5+CdtJRMFegL/N2Q5f4hcDATgfGeYNzd2FUgwD2GmxKsfsLW7WWwRSl0GEtdL7m5VpxrwWhVCKpz8bl/bl+SgSldLanX7dUGVFAgTb8qHSS1hBCAcs99QEZ5hiGZkciDm46S1Ju/exfIlRyjA/eE3E5I7f29HrfpMq+AvA2WBvsfjVPmFRzrGcAfbosf1TXNMAX9+eeLPoAU4A8ARh9SfIXEKkvA27K5TlnzcKpjwjFcECa5QhkZ05hhOhB2MuP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7281.namprd11.prod.outlook.com (2603:10b6:208:43b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.15; Tue, 19 Mar
 2024 03:12:46 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.010; Tue, 19 Mar 2024
 03:12:46 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create callback
Thread-Topic: [PATCH v1 05/11] vfio: Introduce host_iommu_device_create
 callback
Thread-Index: AQHaafrWsToC+V6/rUqIu+gBPSMIMLE9oxWAgADehpA=
Date: Tue, 19 Mar 2024 03:12:46 +0000
Message-ID: <SJ0PR11MB67442FE4EA5CF066DC577A0B922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-6-zhenzhong.duan@intel.com>
 <d386b8e4-b597-492c-b0ab-4b4246906f94@redhat.com>
In-Reply-To: <d386b8e4-b597-492c-b0ab-4b4246906f94@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7281:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j6qdx/DLvlCCHIlOwJYMP5z7VE3GXXd4IFTtjxpBSjlgR1Sw/jRIvN5bu+yOhxUEnwRH1lGw68X8MIYt7tJmsX0KCik3IncY9lv+8ssBJkSwN3UjLBpKkNjH9u2PkJEHAbK8ndwUecNeYZSub72oj7Yl0Dhhugyl+IA85mir4T+xO2/BOAZHVROCmqO8uENWb+yfOpFjYyiMTaBM39L+phwDBBiGKEoYybNeFD5OcQFV5gCeRQ6GFe+WiQrJxDQSqCCK0V+IHdJZMKcv5jA5fBgnemwzwg4XpW30xknbNoK3CFCt1+JGkh9tdPeIGCYjAPzYC3M5HYzqVXO0quh8AfhZCvtC2F3wdcbm0FaeEaV7GoQx7zZJ80epnNMYlFQ04dLE1+xDgDrYcnEh+THMDCz7libtH59zADIg2Gc36rhMtHJYmL3Xnyl3Zx+Zj9/u5ZNwDu0yuEa/4TqLuH87wzSz0Y6Y1q3eCdEv4na1W7TEA4a5N8to3C/sK7wXU/Kutpa/2jVOEuK0CsKz7hwLAVU16QIIEJEW6LVSzyQDfONZjBsFGc8qFECAQGU5o//4EI43vD6duJt3lo1aln7zH1sBWgoMWYyNR2uaIXAnZZLgPtj3vTV1IcGUA5Ve+uSb0N0/uGtRuhw3ig+IoHTV57BA0ZCCvfl/V6qmwHum8ks=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzlTRkVxOTJaZXN4c1NwT1JUa2pNYVZQdmhHYVVlYXlvZUZWSGNwTmVRTGk1?=
 =?utf-8?B?U1BaemhpRDZ0bjBDbk1mcG85M1luNDExaWdwTWVNalNmbmJzbHpPRENqWnF5?=
 =?utf-8?B?Z3ZMdW1OMjBQcUFhRlhXVGxoUTR4NDBCL1RLVmY1Mlkycy9LK25vSXdIZWkv?=
 =?utf-8?B?RzhwWnRWcE9MemdsSm5ubndqcEtyZFlnODlvb2RKczhOSFFQNFJ3T0ZtQUE0?=
 =?utf-8?B?a1ppbElkMHlKTm0wYkdIZEtwQkdvdUErM0hnNzdyaDhLTjh3ajZIaVdSei9U?=
 =?utf-8?B?a3Vxa1JnRlhuUkVEUnlKblpCbUJMYmVVaGp4T1hpdnFnK1dsNDUxR3lFcVAv?=
 =?utf-8?B?WmNxUlNlVXdNbjFPSC91dGtRZlMwT0RYVGF0VHZaaDhrcS91eVFtOGIwdDZS?=
 =?utf-8?B?eW5uVVRxUW1Vb09mb2F2eHdWU2FUTFA3c0Q0WTc2K05MZjBGcGwxNW9hRGI3?=
 =?utf-8?B?dndnL1JJdHlrbXloTWNSb1lJQ0VzVThQN0txeXhYZGI0RHlWUEJaQTlQTTFn?=
 =?utf-8?B?YkxjMGU2NUlMNHNHSlVVVGVtN0xFank5cG5MbVNYVnJhZHhMNW5YRXZSREg5?=
 =?utf-8?B?ZThKcFVBUmpCM3BGN0l0bVd4OWR1NUtMdEd2Y3FwMlZIVjJQUE44S2Y2Mm9W?=
 =?utf-8?B?RjNXVm9GdkJkaURLdjRkYzB6ZUdNd2t3UGYxMGpRTUFvZnFUbGNXOG9uS0NV?=
 =?utf-8?B?dHNJQlk4NzhQNk9KM0U2a3BDNXJhcUJCc1Z6eDFOWmFPYXlMTDJkMWkyUjZP?=
 =?utf-8?B?MUlNbDFOQWU3aFIxYnhKaWdWK01tSWVFZ0NOVjN2K29vclFqT2p3RW5NNjJD?=
 =?utf-8?B?OWZHV1lveFdMMnlRaEV4dys1ZE9CNGRUTXRlQWdXNE1Va3IwaG5GSzlSYTBx?=
 =?utf-8?B?L3J4eWZRRFhmb0s1Y2kxK0o2VTlPeS9MdnFvR2hCVEQrMzZnRzhIQ0ZHdThI?=
 =?utf-8?B?alpNRFB0YjduckFrMjE3aTkybXVZS1dIWDVxVXVnVFF4d0JQVjZqZzA1cVdI?=
 =?utf-8?B?OFhRM0dQNm4zMy9BRnFHZWdhZ3M1bDJOVmpxamtQYm1oYnFJbXJXRmU3S0dQ?=
 =?utf-8?B?czd6alVoZ21BOVZoTjlLcjJQZVJZYzNkdzRtK1FCajBOVVNERlpFRVl5SWNB?=
 =?utf-8?B?NTNvd0R2d25VZlhGVmoweEh5TW9tT1NTcEt0K1VxYno3a20ycjAvVUs0akxS?=
 =?utf-8?B?TWVVSkl2ZEFEWmRQeHJmTHNRdlBnZ29QWHFTWWpjY3RRVjlGd1A4ZGpOVTBq?=
 =?utf-8?B?bGJvSjdtN2JxUnZCWmNvUDBGTmxXUklSWWdRUWNsRlJCWkkzSjd1aDRJV0xU?=
 =?utf-8?B?MW8yR0c4bHNjS3JGWXhramorYUxQeGhZRkdxaVNIZnljUkJyS0VUem45L2Ey?=
 =?utf-8?B?ZmJSOFA5MGJOYTB1OWpYQmdJU2lwblh2dU8yMGJncjd0YmEvVlBndHFnNDJj?=
 =?utf-8?B?eERjM3lpOFhMblBXaGxlMVAvdWMzaFhkUUZUdmpWcTdFbnBjeWdhcExwVjcx?=
 =?utf-8?B?VUdEbGVGbzlzZzE5OWEwdzJwVk5lblpXdlF0RzFqeHA4L3I0cXpzbGREdU53?=
 =?utf-8?B?eGZjTVpSUHZPZWhSVTFLMEFodGFPSmNVWFBUUGpWSjRnVGpsdFhidi9MKzFZ?=
 =?utf-8?B?d2tNaWl0aXA4WS9OcXM2ODhpNzZ0ZDEzeFJmbEd4VitzUFJCbDgzS2ZPdk5K?=
 =?utf-8?B?MGxKdlN5TTIrK1lKWUZ1K0h3ajdPRCsyR2t3enZDTVEvUzFkYnRkRTRoRTZm?=
 =?utf-8?B?Yk9PU2YyS3JHb1lWekxSYi9BV0xxbUVDUWZRT3ZZNW4reFFIL3VvaFR5STdi?=
 =?utf-8?B?RTdqdXd6Zk9YY2JkV1ZwWVZLQnE5YjBuak9yM1V5WHdWb3BlU3JkaW1icmt2?=
 =?utf-8?B?NW9xNDcvcE5UbHNLdllwQWtiSzZPbmhpTzBmem43MzJ1MnQ5cjh4bUtDdVk2?=
 =?utf-8?B?OXJObFp4L0loUzN1WnRNZkI3UDNYUFkvZFY5bTJRTVpxN1dpTjc4OThFYThG?=
 =?utf-8?B?OXNtNm5xbEowYXFiSFlpUlNPaHZzV3ZqN2cyN2hPbVBLN0d2ZUNMOXFaN1FV?=
 =?utf-8?B?TDArZGFrbmhOdHBVQm1teUNHTnBUK1FBVkFCZFhEMmxTZXJkcG8wMGtLcm5Z?=
 =?utf-8?Q?fAdVJRBEOXmRtsDNOuQ9vqEv6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff553791-bae2-4fa7-801c-08dc47c2732a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:12:46.1066 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QvkkRu/MQFv8oqPOBrPxe4bVMT2s1MfN36LH6YKrXVGvbuHt5NIf/hc6lIZ23YvdwHrUi3F2D7m9V59nyz2HDRDYubTjvOXwjEXuTSo4thw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7281
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

SGkgRXJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRXJpYyBBdWdl
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDUvMTFd
IHZmaW86IEludHJvZHVjZSBob3N0X2lvbW11X2RldmljZV9jcmVhdGUNCj5jYWxsYmFjaw0KPg0K
PkhpIFpIZW56aG9uZywNCj4NCj5PbiAyLzI4LzI0IDA0OjU4LCBaaGVuemhvbmcgRHVhbiB3cm90
ZToNCj4+IEludHJvZHVjZSBob3N0X2lvbW11X2RldmljZV9jcmVhdGUgY2FsbGJhY2sgYW5kIGEg
d3JhcHBlciBmb3IgaXQuDQo+Pg0KPj4gVGhpcyBjYWxsYmFjayBpcyB1c2VkIHRvIGFsbG9jYXRl
IGEgaG9zdCBpb21tdSBkZXZpY2UgaW5zdGFuY2UgYW5kDQo+PiBpbml0aWFsaXplIGl0IGJhc2Vk
IG9uIHR5cGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1v
bi5oICAgICAgICAgfCAxICsNCj4+ICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFz
ZS5oIHwgMSArDQo+PiAgaHcvdmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAgICAgICB8IDgg
KysrKysrKysNCj4+ICAzIGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3Zm
aW8vdmZpby0NCj5jb21tb24uaA0KPj4gaW5kZXggYjY2NzZjOWY3OS4uOWZlZmVhNGI4OSAxMDA2
NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9pbmNs
dWRlL2h3L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTIwOCw2ICsyMDgsNyBAQCBzdHJ1Y3Qg
dmZpb19kZXZpY2VfaW5mbyAqdmZpb19nZXRfZGV2aWNlX2luZm8oaW50DQo+ZmQpOw0KPj4gIGlu
dCB2ZmlvX2F0dGFjaF9kZXZpY2UoY2hhciAqbmFtZSwgVkZJT0RldmljZSAqdmJhc2VkZXYsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBFcnJvciAqKmVycnAp
Ow0KPj4gIHZvaWQgdmZpb19kZXRhY2hfZGV2aWNlKFZGSU9EZXZpY2UgKnZiYXNlZGV2KTsNCj4+
ICt2b2lkIGhvc3RfaW9tbXVfZGV2aWNlX2NyZWF0ZShWRklPRGV2aWNlICp2YmFzZWRldik7DQo+
Pg0KPj4gIGludCB2ZmlvX2t2bV9kZXZpY2VfYWRkX2ZkKGludCBmZCwgRXJyb3IgKiplcnJwKTsN
Cj4+ICBpbnQgdmZpb19rdm1fZGV2aWNlX2RlbF9mZChpbnQgZmQsIEVycm9yICoqZXJycCk7DQo+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaCBiL2lu
Y2x1ZGUvaHcvdmZpby92ZmlvLQ0KPmNvbnRhaW5lci1iYXNlLmgNCj4+IGluZGV4IGIyODEzYjBj
MTEuLmRjMDAzZjZlYjIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250
YWluZXItYmFzZS5oDQo+PiArKysgYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFz
ZS5oDQo+PiBAQCAtMTIwLDYgKzEyMCw3IEBAIHN0cnVjdCBWRklPSU9NTVVDbGFzcyB7DQo+PiAg
ICAgIGludCAoKmF0dGFjaF9kZXZpY2UpKGNvbnN0IGNoYXIgKm5hbWUsIFZGSU9EZXZpY2UgKnZi
YXNlZGV2LA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICBBZGRyZXNzU3BhY2UgKmFzLCBF
cnJvciAqKmVycnApOw0KPj4gICAgICB2b2lkICgqZGV0YWNoX2RldmljZSkoVkZJT0RldmljZSAq
dmJhc2VkZXYpOw0KPj4gKyAgICB2b2lkICgqaG9zdF9pb21tdV9kZXZpY2VfY3JlYXRlKShWRklP
RGV2aWNlICp2YmFzZWRldik7DQo+PiAgICAgIC8qIG1pZ3JhdGlvbiBmZWF0dXJlICovDQo+PiAg
ICAgIGludCAoKnNldF9kaXJ0eV9wYWdlX3RyYWNraW5nKShjb25zdCBWRklPQ29udGFpbmVyQmFz
ZSAqYmNvbnRhaW5lciwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJv
b2wgc3RhcnQpOw0KPj4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8vY29tbW9uLmMgYi9ody92ZmlvL2Nv
bW1vbi5jDQo+PiBpbmRleCAwNTliZmRjMDdhLi40MWU5MDMxYzU5IDEwMDY0NA0KPj4gLS0tIGEv
aHcvdmZpby9jb21tb24uYw0KPj4gKysrIGIvaHcvdmZpby9jb21tb24uYw0KPj4gQEAgLTE1MjEs
MyArMTUyMSwxMSBAQCB2b2lkIHZmaW9fZGV0YWNoX2RldmljZShWRklPRGV2aWNlDQo+KnZiYXNl
ZGV2KQ0KPj4gICAgICB9DQo+PiAgICAgIHZiYXNlZGV2LT5iY29udGFpbmVyLT5vcHMtPmRldGFj
aF9kZXZpY2UodmJhc2VkZXYpOw0KPj4gIH0NCj4+ICsNCj4+ICt2b2lkIGhvc3RfaW9tbXVfZGV2
aWNlX2NyZWF0ZShWRklPRGV2aWNlICp2YmFzZWRldikNCj4+ICt7DQo+PiArICAgIGNvbnN0IFZG
SU9JT01NVUNsYXNzICpvcHMgPSB2YmFzZWRldi0+YmNvbnRhaW5lci0+b3BzOw0KPj4gKw0KPj4g
KyAgICBhc3NlcnQob3BzLT5ob3N0X2lvbW11X2RldmljZV9jcmVhdGUpOw0KPmF0IHRoaXMgc3Rh
Z2Ugb3BzIGFjdHVhbCBpbXBsZW1lbnRhdGlvbiBkbyBub3QgZXhpc3QgeWV0IHNvIHRoaXMgd2ls
bA0KPmJyZWFrIHRoZSBiaXNlY3Rpb24NCg0KVGhpcyBwYXRjaCBvbmx5IGludHJvY3VkZXMgaG9z
dF9pb21tdV9kZXZpY2VfY3JlYXRlIGJ1dCBubyBvbmUgY2FsbA0KaW50byBpdC4gUGF0Y2g2LTcg
aW1wbGVtZW50IGNhbGxiYWNrIGZvciBkaWZmZXJlbnQgYmFja2VuZCwNCnBhdGNoOCBjYWxsIGhv
c3RfaW9tbXVfZGV2aWNlX2NyZWF0ZSgpLCBzbyBJIHRoaW5rIHRoZSBvcmRlciBpcyBvay4NCkxl
dCBtZSBrbm93IGlmIEkgbWlzc2VkIHlvdXIgcG9pbnRzLg0KDQpUaGFua3MNClpoZW56aG9uZw0K
DQo+DQo+RXJpYw0KPj4gKyAgICBvcHMtPmhvc3RfaW9tbXVfZGV2aWNlX2NyZWF0ZSh2YmFzZWRl
dik7DQo+PiArfQ0KDQo=

