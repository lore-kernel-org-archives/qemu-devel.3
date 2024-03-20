Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5EC9C6FD1F
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 14:35:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmx1K-0006P4-La; Wed, 20 Mar 2024 10:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmx1C-0006Np-Px
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:34:15 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rmx19-0001AA-CM
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 10:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1710945251; x=1742481251;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=veAvVMXLxPE6mttb1ScjLBo7oqj0wGzjG3iI0/a+7Dw=;
 b=JO8M64YyhJml2LEBIMl2O6c9fHdlx900PDZrjQTqg3FH/+5KdW523szF
 p+fTUlkyORVIzzXUOuPj/KYvwdUkIs4ac/Eyv0xpyOucryEoMTQ0d+g8M
 kwaBZfq9aKEddhh1p6IyBt6A8HQpzaiQvj6bg/zfehvQpVWyjF+zYinoT
 DGpUPrNzdHN1zDvxppLK54GmWiWNExh76ubPqEsKmX2XDgrPkdbbm8csl
 Xrgm9qVbNUOtcLjHfZ9ITzzV+a8AvZ/YPwodW0aNYi8AABn2F3Z34n0aV
 FSQvS91K0LLyCPKRcIeCmPQcfUAncgi5WC4U9Jl5cf5z2kMl9FRi2EBOn A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17274035"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="17274035"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2024 07:34:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; d="scan'208";a="51612088"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Mar 2024 07:34:08 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Mar 2024 07:34:07 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Mar 2024 07:34:07 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Mar 2024 07:34:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJ8Fo7toZwax6XRdrtTLuyr/sv9JmBuSM2oEKHbwqmHdELf4GYOgjmLvyNI2w0y0se7kDx5qenTWOjGnj1DS6L2TlTjv/hAxTLfU4Eb2eJum/OUrrphewJTYZpkORpoQr/HMdxjP/KNx/kYHbJULrXbWo0EaF6Tk79qlYvZlbKQtGufdW2wEx5nS6+/9rI13UFS8pfqexPs43QsEouHDi4X8UUIXPfEAtixkUHPbn//E4de6xH2M81NurcEa/yVCmbNuUD0wfBblYLn4P7byq9F5GpnOAKt83HshXe82x9+ruo3ughxeJNVGeNHH3/XScPrSgCPUy5VV1xdUQADGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=veAvVMXLxPE6mttb1ScjLBo7oqj0wGzjG3iI0/a+7Dw=;
 b=kmevLShF9XTyJ0rnvgtJkw/tlex7PB5EjbP/Rs1mLjinpmKBL7K2RgatUMQtovbXy5tkMtPqIsd/srNcDnfGElFhGW+728GHMsLSR2mZep2kk9ElRT/bWGlAZDo46WT8B/2xCTmHZAxJ6mAAngaEOsJyc6Lh3QJHLwIN+y7jC4kvRTazjb9Y2WD5clKlTpcoonUnyKfT+thNSUtNZRBuQWiBIu9MJOagbS+CYKJaxcnOCGwe789QUlFP2mFXhbcAUd4JhNVQWDEeRp6mIp1/8z0YeVf9s3Ap0Ly4tk+Q/LUPu16aMKjxTNUFTq5YRNHeHpsPY8lVefxRjO0RTisJ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by DS0PR11MB7926.namprd11.prod.outlook.com (2603:10b6:8:f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12; Wed, 20 Mar
 2024 14:34:03 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::f926:1804:73ce:ca52%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 14:34:01 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: Thomas Huth <thuth@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH v5 3/7] configure: add --enable-qpl build option
Thread-Topic: [PATCH v5 3/7] configure: add --enable-qpl build option
Thread-Index: AQHaeqFAp/BSNyhWSU+idVclCeNmKLFAU10AgAAAa4CAAF2EQA==
Date: Wed, 20 Mar 2024 14:34:00 +0000
Message-ID: <PH7PR11MB59411C850C30138D48B46732A3332@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240319164527.1873891-1-yuan1.liu@intel.com>
 <20240319164527.1873891-4-yuan1.liu@intel.com>
 <a7e38ec4-641f-409b-86d7-ea09d9ac1b18@redhat.com>
 <8cf83c55-3557-4589-a37e-d832109cc703@redhat.com>
In-Reply-To: <8cf83c55-3557-4589-a37e-d832109cc703@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|DS0PR11MB7926:EE_
x-ms-office365-filtering-correlation-id: 3dfecef8-56b0-46b2-1394-08dc48eac8e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GZTitlgcRUurIESm7YMeW0d0fAsU5yY6wChTj63D0qkIkNU7BAuP3ebT8RXAVGm5pRoM4H1KVcVy44r9ypryDfQPn9aThmWqNklk8kVkH/2yfMe91QsmfSImTu694XvngLxRgm0m1RmCsEjbmCZ8pvHdPZLvGN8GCJepYojqgTnLfzU4BxV6HcjISNrBJvZv58/amWxoqm8BzlCw6GFf1e9gkEAmdvXujXn80TGKzTytOjxBkE7rlIbH6+bX0CgQ0545m/zL+WAX1O5wuwIJNBvO26cxaFrZC4P+eygs8deS2/gQJ0jmosmaI092P9tL6N6bPQnMFibKLPxkjsBSNY3w4FpkNSjT8iYEOeb6+XsY2XDMCyIPI+S8Llas2tYrugVaiowBU8olQR9EslwXT2+gtsuhE1BfYUloMkFr1Z8/HPQ2i6CamrKqcM5n8/J8EjiZfg3Ket3OAueWBCpDtsmjIAdt2jLarxfQraJoKsklS/SjzaF8mYcZZIiYSPCcovPAVSvUt2oZ738zKhbt+YMziZDKkJIYnuLkAzpde7nYaDc3tGNDeJa9mIOgnDTtpi0X5k2ujGGPiBvysmoGUS1oa2DwiM4YUiTVolhXB8EmmwccnwmKIWW0VJ6khSI3dfCngpYVfJ3fdALDuCq6bk/jE4KlJZJ0R1/V4FJMq1dhUSyA7swHaWPgePCLTf1t
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RW12Znp4dk5XbTVnT0NnNFYxS0ZBMm5vUEZ4eFFrS1UyL0hsejBINkxYcTRr?=
 =?utf-8?B?a1hnV0JhRDFHTU02ZUgyREFSWGs2MjJVWnhUN1IyZDFxM0EybnB6UEt4eGNy?=
 =?utf-8?B?ZWhBcy92YWhqakZ5QmxQajFUQlhBYnlWWE5XTWRndFdSVFhLa0x1WFZVM05P?=
 =?utf-8?B?K0NkLzJ0ZlJodGN4UEVDNHkvaTVoTDRNWDROeHd1OVVQd0kvMG8rTjZyK0JG?=
 =?utf-8?B?c3hLMFIvQlBpUzU1dmdTYlErWjdWbDZLc2R5QktocDJzN2pLMnIzUlc0VS9v?=
 =?utf-8?B?OFZweEZrMzRiYWlvbDBHUU1HUG5LaUFUWG85U29pNDdQc3RndExYT2tCenll?=
 =?utf-8?B?aUVxNXBWNzNNRkp5b1liVmJINzUzREQ5NXdUSWhzRWZIbnlNbzJLZHQ2Tlhi?=
 =?utf-8?B?cDdFeWJCN3BKckF3dyt2ajNCeldFdnNNYTRGZEJ0UUJwdWViSllaRVluVDJz?=
 =?utf-8?B?YlZxVzZNYWc4ZU5TOEExa292WmJQRU9Pb0RrNy9paDU5cmRZSUFmdjhzaFNa?=
 =?utf-8?B?VjhRdlJJNUI3UHBWdUhlMjBaV2lHdUxKS1lPWXYzNDlXOFR0cU0raGEzMVdT?=
 =?utf-8?B?SG1ZOW8vaEtxUXpxb2lDbGxXTjF3aEFIeUhrZ3RhUzU5N2pGUTU1TTRGejQy?=
 =?utf-8?B?REJnRnZPY0tSMDBDcW1hN3VQa2VuUFRaQjQ3c1paKzZRQWltdWIwRmdnbkFn?=
 =?utf-8?B?WkVYUkEyS2xxTnpTUWJueUE3cFRZMkU0ajVCWGJYZWd2Skw2VjFUbkNtVjR5?=
 =?utf-8?B?VW82WGFHRU96NWtrYWUxZzRPNlZiMWlwaGI5WWh0enZFQVp1Y0dnajlZSVdJ?=
 =?utf-8?B?UmlqZkFRUFUyZ2RRR0Z6WFpsTmFhNmFzaThhbXkxS2ZpMFBlcUJISE9BeHo5?=
 =?utf-8?B?a2dyY3NKL1ZDcGNWbGxrZVdkM0VIM3h4STRnMkZPcUpENTJCMExPSjBXaW1Q?=
 =?utf-8?B?eFNnajlSb3RqNGJPOTl3ajlGMEFaMC9CMDdNcXVLSU1zOVFxSWl1dTdvc0w2?=
 =?utf-8?B?Zmk1UmVjVXk0RGVWMjdyMDcrakgxdU9vNFRYWHNSaDlmaEVUWGMrcWpqUkFm?=
 =?utf-8?B?bGRFQ2RXbXFUcDhvaUZlTUJkZ21SQjNlNDhPdlZZZ0hHVkFtaUk0aGY4aE9q?=
 =?utf-8?B?a3JmN3pmR2JxZWYzY2tPQ2xiS0Q0OTExZnEremFELzZkUVIxNnk5bzkzeHBH?=
 =?utf-8?B?czkrbnNTU2gwNXpZREJ0bFlYMDZTc3FrTDRVZXlZL3VtaGJ2Q3ZackN4bits?=
 =?utf-8?B?aGpDNGpOVzhrU004VWl5Y3ZaNHlCSHZBS2Iyby9mUFphZlg0Z0N3eEZIcU5D?=
 =?utf-8?B?N0YrNnJ4WGtPUVFMQWo1UGpOVVYvQURhd3AweVB2MFFZZGk4UFc2WHZWMFo4?=
 =?utf-8?B?bWVBSGhRRkhRTittblArZ1JZZHZYTEVqMmlaNVhDY3A4SXo5NjRUOU1PeVVh?=
 =?utf-8?B?MXBtS0ZJNm5aTlZBakFHa3BvUXJmMUMyN2FyUm1rWmtvMjRWQ3habE9uU2NC?=
 =?utf-8?B?bWg2eng2cEUvajNwL1RQQVJpcm9NTU44cWQrQ0JRd2Q2ZGI0L0xweE5aRTdt?=
 =?utf-8?B?L05UeFlMa1hzdUFMdUxNblp2a1BiUWlDZHZtb1Rqd0xSQ29wbGwxdXBGYVFw?=
 =?utf-8?B?Qy9ySzU1eDdZeVR5ZUgrQk5pNG42RXp0eTBHTGJWc0w5TzFnSmpKRFpzUjln?=
 =?utf-8?B?Q0FiRWEweGMwb1NMUk13cVFwQlVmNU9wSklKSmQwTkxQM1ZtSUNjaUR0RHNk?=
 =?utf-8?B?NjBvUzZkOWwvcGZWZkNUS0hCSkdxelR4TWRzTjFjRHNyTkFZSDBsVm1RV21l?=
 =?utf-8?B?cmJXWXlaVlJDUllLQnJYWmRvbjVFV01aeWNoVFJoZ0dpZk5DMlU4aTdMSDlo?=
 =?utf-8?B?UHI4NkNsTC9NeUZqRGpQd1BZZHkzTHFhOWU0amV1NjJaZ3VKQ1hiZC9mVFgy?=
 =?utf-8?B?RHJWNmdQMVRNYTBxQmFwTjFZdnFna0UvMGZwK3BKUDZKYzd6WE5JWEpJOFpm?=
 =?utf-8?B?S1R6WUdlL1drcVpCTGQ4VVYyRDN3eUxFTUswd2dtTmVxcWhSYldXcUtrb3Zn?=
 =?utf-8?B?cVFXYzVmYXZjWnU4SjZnS2RuN0FCYnI4MFIzaGZlUmg0cm40a0dIcEsvdjlq?=
 =?utf-8?Q?AbHZHx6YLzHVsSBo1BQPefjsK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dfecef8-56b0-46b2-1394-08dc48eac8e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 14:34:00.9356 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pk6ytop7M5JkfpnHgMLyNqx+0yUSQnq78wGVZTjwYyQ172ROn+g1c4fDrrwx/hC/t3alYFb92WEun0EWxGCeFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7926
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.417,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBUaG9tYXMgSHV0aCA8dGh1dGhA
cmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMCwgMjAyNCA0OjU3IFBNDQo+
IFRvOiBMaXUsIFl1YW4xIDx5dWFuMS5saXVAaW50ZWwuY29tPjsgcGV0ZXJ4QHJlZGhhdC5jb207
IGZhcm9zYXNAc3VzZS5kZQ0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBoYW8ueGlhbmdA
Ynl0ZWRhbmNlLmNvbTsNCj4gYnJ5YW4uemhhbmdAYnl0ZWRhbmNlLmNvbTsgWm91LCBOYW5oYWkg
PG5hbmhhaS56b3VAaW50ZWwuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDMvN10gY29u
ZmlndXJlOiBhZGQgLS1lbmFibGUtcXBsIGJ1aWxkIG9wdGlvbg0KPiANCj4gT24gMjAvMDMvMjAy
NCAwOS41NSwgVGhvbWFzIEh1dGggd3JvdGU6DQo+ID4gT24gMTkvMDMvMjAyNCAxNy40NSwgWXVh
biBMaXUgd3JvdGU6DQo+ID4+IGFkZCAtLWVuYWJsZS1xcGwgYW5kIC0tZGlzYWJsZS1xcGwgb3B0
aW9ucyB0byBlbmFibGUgYW5kIGRpc2FibGUNCj4gPj4gdGhlIFFQTCBjb21wcmVzc2lvbiBtZXRo
b2QgZm9yIG11bHRpZmQgbWlncmF0aW9uLg0KPiA+Pg0KPiA+PiB0aGUgUXVlcnkgUHJvY2Vzc2lu
ZyBMaWJyYXJ5IChRUEwpIGlzIGFuIG9wZW4tc291cmNlIGxpYnJhcnkNCj4gPj4gdGhhdCBzdXBw
b3J0cyBkYXRhIGNvbXByZXNzaW9uIGFuZCBkZWNvbXByZXNzaW9uIGZlYXR1cmVzLg0KPiA+Pg0K
PiA+PiBUaGUgUVBMIGNvbXByZXNzaW9uIGlzIGJhc2VkIG9uIHRoZSBkZWZsYXRlIGNvbXByZXNz
aW9uIGFsZ29yaXRobQ0KPiA+PiBhbmQgdXNlIEludGVsIEluLU1lbW9yeSBBbmFseXRpY3MgQWNj
ZWxlcmF0b3IoSUFBKSBoYXJkd2FyZSBmb3INCj4gPj4gY29tcHJlc3Npb24gYW5kIGRlY29tcHJl
c3Npb24gYWNjZWxlcmF0aW9uLg0KPiA+Pg0KPiA+PiBQbGVhc2UgcmVmZXIgdG8gdGhlIGZvbGxv
d2luZyBmb3IgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBRUEwNCj4gPj4NCj4gaHR0cHM6Ly9pbnRl
bC5naXRodWIuaW8vcXBsL2RvY3VtZW50YXRpb24vaW50cm9kdWN0aW9uX2RvY3MvaW50cm9kdWN0
aW9uLmgNCj4gdG1sDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFl1YW4gTGl1IDx5dWFuMS5s
aXVAaW50ZWwuY29tPg0KPiA+PiBSZXZpZXdlZC1ieTogTmFuaGFpIFpvdSA8bmFuaGFpLnpvdUBp
bnRlbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiDCoCBtZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE2ICsrKysrKysrKysrKysrKysNCj4gPj4gwqAgbWVzb25f
b3B0aW9ucy50eHTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDIgKysNCj4gPj4gwqAgc2Ny
aXB0cy9tZXNvbi1idWlsZG9wdGlvbnMuc2ggfMKgIDMgKysrDQo+ID4+IMKgIDMgZmlsZXMgY2hh
bmdlZCwgMjEgaW5zZXJ0aW9ucygrKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvbWVzb24uYnVp
bGQgYi9tZXNvbi5idWlsZA0KPiA+PiBpbmRleCBiMzc1MjQ4YTc2Li5iZWU3ZGNkNTNiIDEwMDY0
NA0KPiA+PiAtLS0gYS9tZXNvbi5idWlsZA0KPiA+PiArKysgYi9tZXNvbi5idWlsZA0KPiA+PiBA
QCAtMTIwMCw2ICsxMjAwLDIwIEBAIGlmIG5vdCBnZXRfb3B0aW9uKCd6c3RkJykuYXV0bygpIG9y
IGhhdmVfYmxvY2sNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHJlcXVpcmVkOiBnZXRfb3B0aW9uKCd6c3RkJyksDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZXRob2Q6ICdwa2ctY29uZmlnJykNCj4gPj4gwqAg
ZW5kaWYNCj4gPj4gK3FwbCA9IG5vdF9mb3VuZA0KPiA+PiAraWYgbm90IGdldF9vcHRpb24oJ3Fw
bCcpLmF1dG8oKQ0KPiA+DQo+ID4gRG8geW91IHJlYWxseSBvbmx5IHdhbnQgdG8gZW5hYmxlIHRo
aXMgaWYgdGhlIHVzZXIgZXhwbGljaXRseSBzcGVjaWZpZWQNCj4gPiAiLS1lbmFibGUtcXBsIiA/
IE90aGVyd2lzZSwgSSB0aGluayB0aGlzIHNob3VsZCBiZToNCj4gPg0KPiA+ICDCoGlmIG5vdCBn
ZXRfb3B0aW9uKCdxcGwnKS5hdXRvKCkgb3IgaGF2ZV9zeXN0ZW0NCj4gPg0KPiA+ID8NCj4gPg0K
PiA+ICDCoFRob21hcw0KPiA+DQo+ID4NCj4gPg0KPiA+DQo+ID4+ICvCoCBsaWJxcGwgPSBjYy5m
aW5kX2xpYnJhcnkoJ3FwbCcsIHJlcXVpcmVkOiBmYWxzZSkNCj4gDQo+IC4uLiBhbmQgaXQgc2hv
dWxkIHVzZSAicmVxdWlyZWQ6IGdldF9vcHRpb24oJ3FwbCcpIiBpbiB0aGF0IGNhc2UuDQo+IA0K
PiAgIFRob21hcw0KDQpIaSBUaG9tYXMNCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCB5b3Ug
YXJlIHJpZ2h0LCBJIG5lZWQgdG8gYWRkIGhhdmVfc3lzdGVtDQphbmQgY2hlY2sgZ2V0X29wdGlv
bigncXBsJykgaGVyZSwgSSB3aWxsIGZpeCB0aGlzIG5leHQgdmVyc2lvbi4NCg0KPiA+PiArwqAg
aWYgbm90IGxpYnFwbC5mb3VuZCgpDQo+ID4+ICvCoMKgwqAgZXJyb3IoJ2xpYnFwbCBub3QgZm91
bmQsIHBsZWFzZSBpbnN0YWxsIGl0IGZyb20gJyArDQo+ID4+ICsNCj4gPj4NCj4gJ2h0dHBzOi8v
aW50ZWwuZ2l0aHViLmlvL3FwbC9kb2N1bWVudGF0aW9uL2dldF9zdGFydGVkX2RvY3MvaW5zdGFs
bGF0aW9uLmgNCj4gdG1sJykNCj4gPj4gK8KgIGVuZGlmDQo+ID4+ICvCoCBsaWJhY2NlbCA9IGRl
cGVuZGVuY3koJ2xpYmFjY2VsLWNvbmZpZycsIHZlcnNpb246ICc+PTQuMC4wJywNCj4gPj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmVxdWlyZWQ6IHRy
dWUsDQo+ID4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IG1ldGhvZDogJ3BrZy1jb25maWcnKQ0KPiA+PiArwqAgcXBsID0gZGVjbGFyZV9kZXBlbmRlbmN5
KGRlcGVuZGVuY2llczogW2xpYnFwbCwgbGliYWNjZWwsDQo+ID4+ICvCoMKgwqDCoMKgwqDCoCBj
Yy5maW5kX2xpYnJhcnkoJ2RsJywgcmVxdWlyZWQ6IGdldF9vcHRpb24oJ3FwbCcpKV0sDQo+ID4+
ICvCoMKgwqDCoMKgwqDCoCBsaW5rX2FyZ3M6IFsnLWxzdGRjKysnXSkNCj4gPj4gK2VuZGlmDQo+
ID4+IMKgIHZpcmdsID0gbm90X2ZvdW5kDQo+ID4NCg0K

