Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E981CD1288
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 03:23:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq2p2-0003Te-5B; Thu, 28 Mar 2024 23:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rq2p0-0003TS-Of
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:22:26 -0400
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rq2ov-0002se-DO
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 23:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711682542; x=1743218542;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=TS+luOZjxTBvQoJcHK9nb1My6XVCyNupt0SIKjNn0Ck=;
 b=VWKsRCcOeDbqPUpag007JDB6I2NuquZm7fz1Qr/hQ94VzBO3Z5aNnbc0
 s4Ykx4QX8Y+dGuu93F2V2XhHlWMW8WyPIsSMOWVztKr4uz2bJsKOcgvTK
 IQV1geNpbfi5V8iTEMiAOjGTiM/uhjQNfMIK2dPJDU4kkj2E82eXHxIIf
 c81WvYfDFevHmiw3BdvQWjW+rQ6EA7aT4zfTF6rQ161jW3MhsXMUWhZkV
 s++ITZ7cl4CE0FqLXrAlrKLbiJ1nGw9DCJNMVjZ/Fv4yPKaXY5RgKB3Mb
 SyfLtERbZDYIiWu9so3ZmYG/OtIgPrrN24Jgq3Z5EzFuQTKXieGSCFs1W Q==;
X-CSE-ConnectionGUID: jt5IEDAZRTWIyhLPTrOOsQ==
X-CSE-MsgGUID: MLCAJOqmSKixGRqdVArLmA==
X-IronPort-AV: E=McAfee;i="6600,9927,11027"; a="24320149"
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; d="scan'208";a="24320149"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Mar 2024 20:22:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,162,1708416000"; d="scan'208";a="16815858"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 28 Mar 2024 20:22:16 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 20:22:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 20:22:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 20:22:15 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 20:22:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eaiRY2sTEWYiDyZkXOHRKhu1CY91w0jZzjwQcd2ZkKB8iT9Ml0rKhgGvOhlRxKiJf7beNvWHSSlfYgEf9J484RVbaoiiZJQBXP7KxXAzAGa1apG5fDYE0k+Kvop0wdoiD9QX708c4uZMBDwaoh0c53EMKrOozoZEocyouYqrZNo0yjHxpoftw6NzIiyz91il2+vrvXBP6Y6O/FwAB2gjADlmv07qafrKltn22voOfK/KKPP8zTRnr6+9gNBiWCTXXolq0mVXTh5ftqAO6FUd4F5+VRw+JLLkEqMjhWbTTzTqZxHzWInd73E9+b/z598h3Kz9s7qZfB5x+q5y5XT1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TS+luOZjxTBvQoJcHK9nb1My6XVCyNupt0SIKjNn0Ck=;
 b=je526qaQrtnO6u7qVGgNPriBrsYWLj7aGFKKZ0q/qcOxRfYymv+gB0cVOek+wEi+ErDx4ttCv1NrJ7+0yGMpaImTfxz4Okd0OJRlIpk0Xzxn5z9/NUwDVii+GtL0tJ/C5CT3nl/2M4+R5nlx9HBCxUpOUeraGSSRu6RBskRZkQpg6gEH/R46ouACA8g0jzyvpQ+MiUovdTmHx72e8ZdXtJTGE1hiuKqaJZ+7sp+xmm8b2VMeRMF0Q6+bZYz0HrN/gSBW+JOAe3KAflFg012B3ObbspUiXUNdAHD4kiVe747zoa3TDtI8AikanGghu4xIlLFVneVIsaS5XS9Jb9bLmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5832.namprd11.prod.outlook.com (2603:10b6:510:141::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 03:22:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.031; Fri, 29 Mar 2024
 03:22:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Eric Auger <eric.auger@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Thread-Topic: [PATCH v1 3/6] intel_iommu: Add a framework to check and sync
 host IOMMU cap/ecap
Thread-Index: AQHaaisbo2H+re2kM06xKrJPfsjhv7E0ah0AgACay5CAAFDoAIAABZmggABAY4CAB/4OAIAPUpwAgAFF5WA=
Date: Fri, 29 Mar 2024 03:22:12 +0000
Message-ID: <SJ0PR11MB6744496950330780C1E7F079923A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228094432.1092748-1-zhenzhong.duan@intel.com>
 <20240228094432.1092748-4-zhenzhong.duan@intel.com>
 <20240312130058-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB67446BFCEC0FFFBC018D70DA922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313030303-mutt-send-email-mst@kernel.org>
 <SJ0PR11MB6744F2805D8EF6722C725DAC922A2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20240313071647-mutt-send-email-mst@kernel.org>
 <b6ca5e9f-5ba2-4133-b7a0-2e3932fcd051@redhat.com>
 <20240328030023-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240328030023-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5832:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Xo3MJikqgca+Km7a+8Y1GDTFUY2HEDBDgsUJ+A7oAf1Pxwb0UljeMsClLdmHXEpt/uViFnoa40g5EEt24owHA4WepbQDavbkLfEc9Q6jBP7jyPW23QX5lfsK7RGPzDzDpxpMhGG93ChXnycjfGFMhTJqg9S7EJrczRHw9v5Whndjz8gwgq+pArBNL0MUMYyxmW70mTjdxP789HB8kcnaxuyWOhVZGC2GBPPmTQfpGjAoirAlnK6oqCowTRVdHfF2VAhd5b7BrqxJ7tbsg8HXuy1yslJQQKfq94oO5/2FFhj/pdq62O5++3MrHrPIOfMZtF/OLGjBhFgA1a8oD4lI7ezIJbgdpvkqFcHqItEurO7XRhib9FYS8p1cR9sGGrhIIsI4kL8lvQfF0IojSukRVJJrIdAT6PXr8lBeGftdoIBrZF5lKvrNWjOhlUNitCTbUwP2K1e3ysz2lCDM3M+ED12clfIfYRQKe9NgT0LgGwhYwgJ+LZJ5FZlcXhBeI1oTC318kYZ7nm1kj7n/ialbS8vycuyn4Ejek6QUX9gd/j9GWhyJHJZGcqcNOxoZ/6nUXYcaT/6k/YJSu7X1eegXvKroGHOaUWWchzLkuG0vCk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(7416005)(1800799015)(376005); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z09EM2dCSFdaN3I0Y3FaNW9QaFV1SVJHbjdXUmRHdTc0R01Od2ZJZTl3cTNy?=
 =?utf-8?B?VnZ5YkE1cTg1YXpKTk0xbWxnVUN3emxyZmxUcmtZZHdsNFdYR1VKN2FOb1hW?=
 =?utf-8?B?NklYQm1uNnNvcTFsNnJ1VFYwOC9JVGNwajRveGU5VmFxWkhJdjU1dXBxenVp?=
 =?utf-8?B?UHVtazl1ckorRTNLYVBaS3dkRjZTcFdaSnFqc0hleXBnWGpvbEVjcFNuaUNZ?=
 =?utf-8?B?aVNrNnVXS09kYXRsTllYMzBQNjlkdXZDV09BV3JUVWE2Mk9aZVBVMWFIcTFM?=
 =?utf-8?B?NHpSNkhRRmdoTm9MTHNaaWNZVUpkQWxKaGNvZ3IxU1gvUEZuSG4yZEw5Undn?=
 =?utf-8?B?VzV5b0I4UUQvZ1FaV2tFMEdWMnhEVU5BN2FjbFpIdWRGazQwOVlSeHZCVnla?=
 =?utf-8?B?UWxmZkdtQ0lLM1V4SlA3dmRtd1B0OGNVSkV6T0tlaXdTV3NzODZ2U3RIK2JK?=
 =?utf-8?B?d3R3ZjdMclBTMnZaTVY4dUF0YVU5eVRJblBlY2Z0SndvWmJlTzUyUWRzRDlz?=
 =?utf-8?B?WVRkYzVBWkFoS21NcSsxL0RTYTNTMXBZY2JaMmZzSEYwd3pkaWcvTnZUOUJU?=
 =?utf-8?B?aDYrdyt4dHpvVmFRQ3phdTMwK0dCWFMrYnF4QVJLQ2ZpY0kzd0FqSWozTGJr?=
 =?utf-8?B?Z0VkcTMramZ4Wm4xRVRXVWVYSmJ5SXZnak81WlJLb2dGaGVzUS9vUTJpVlIv?=
 =?utf-8?B?bU1aMTVzL2dRcW51WWZ5ZnkwSmtVYUFvb0pYemUzRGZvdFJmSmZBdk8vYkc1?=
 =?utf-8?B?ODlvZkhCeVpKZ01lU250a00zeFVMeUlSTTRsbmtuWE5UR202ZlQrNWRiZjNJ?=
 =?utf-8?B?ZzRPNlVzRWVQbFpBL092N3UyZ3hYejNpUzNEMWZoVmZPSng1a1VDY2dPS0Yx?=
 =?utf-8?B?bk5jbEN3WjNFUkNmUlJtK29NMU84eGxLcmp4ejErU2FjNC9nN3g0TXZXNHR4?=
 =?utf-8?B?YXliUzQvR0pMNDg1cFVFcXU2YVhTQlQxeFZpcHlwSXZ5YktUZ1BZM1cxY3E1?=
 =?utf-8?B?L0tIM3g1b2ZCdHA3cG5YTUhNdWlMMmQvT1AvRjZZZy9qZFdFaXpxWHQxTG5s?=
 =?utf-8?B?TCs1VWJlcjFuVHF4OG5aeXBzeVpSbkdwRERVQlhmT00xTmM5TlFDeHV6VTVo?=
 =?utf-8?B?USt0Yjk2SGcyZTNNUWJ1N2pqb0FqdE91S0x5Snp6WWExdVZZRGtEVVdjc0pR?=
 =?utf-8?B?TEFSS3c1UlV3K2hKcHVZK1BrZ3MvU3d6c2Zxa0g3bU1Lc0tpVHI5VkRLQzh4?=
 =?utf-8?B?MmFOQlczaTA4MmphTWxQQ00wajFUZTgvOGo0TFl4a1BpSGZyNHUraUQ1WHRB?=
 =?utf-8?B?NnRMZkl2MVZNQVVkNEk0bjcyVmM1alRrUjNabWd0NjJxaTFRRExUZFFNUjVH?=
 =?utf-8?B?eWZOREZlNC9BWFp6MXFCckNEVXN3Ymc0TGFoNzRrSEFXanVlWlJnR2srZFpR?=
 =?utf-8?B?dUJmWHN4KzJSR2tnV05DMlc2RFJhcmg0UFd3Sm9lUlNZNWsrNlRBRVc0dFc2?=
 =?utf-8?B?UThtUFVlY3FtZGJ6bGJ3ekVDWmhUaEZoVUFwOHYvcTY2ckxzOFNHSGxHU3hO?=
 =?utf-8?B?RGRJNzRna1ZhL3cwaDlZNEN3Z2ZiRkIxdXNHTGdtT3J3R09Nc1lDc0s0TkFm?=
 =?utf-8?B?OFpVRU4xZnJuYXd6UXJHZXhrK0VGTWtSZ21MczNpdDhFZFZzRXprem1NMW9G?=
 =?utf-8?B?Qmt1K3pMRTdSa3JtYlFLR0hUU252UlBSeXlvMHYyRHpaWGJHS1Q2dTdXU3Zs?=
 =?utf-8?B?QnE2V3JrYURWWm9RVTlKRC8yREx5RzBoa1hGYUNzN1B6SCtxYmFkckkyRHZa?=
 =?utf-8?B?eWZwbjFld05wQkE2TkpNY1dBTzlvMzJ5NWRxbkZmOVZxT05oSlMvUlBYbnNn?=
 =?utf-8?B?ZzcxQ0Jtb3NjZlF2bThIdjhRZStuL3NpZ0VpNjMrVUJtejJLWVJDZGVhZys3?=
 =?utf-8?B?VUZyMVBLY1o4THBpRXY5eFFzVWxsamFRV01oL2hiR2hkcGVxeFVkOGtndklM?=
 =?utf-8?B?Z0cxOGcxQVMzZk9KV3ZHaEJiSFhkeVhXeW5zemdMNmQ3c3UzRnpSQ2M1YlRQ?=
 =?utf-8?B?b3I3emlHUWRMaGxYN2E5QXFYNEh6RnZQVXMzQVgwekFWQUs1M2dGU1doRlZ6?=
 =?utf-8?Q?lR48nB69C50A5QqVQfQURqB6W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73d79a8b-cc7f-4655-a7ba-08dc4f9f6ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 03:22:12.3446 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tTLQZ1k8NQq6kpy/CWLr8chBl8Bg0SevWPpRTsbEQOg6R+vnbNOmg61cQoJYVD+fVYAzKRvY03+kGp2wDTaCFIHY4t0xTRrgNLGOITKd708=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5832
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
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

SGkgTWljaGFlbCwNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTWljaGFl
bCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHYxIDMv
Nl0gaW50ZWxfaW9tbXU6IEFkZCBhIGZyYW1ld29yayB0byBjaGVjayBhbmQNCj5zeW5jIGhvc3Qg
SU9NTVUgY2FwL2VjYXANCj4NCj5PbiBNb24sIE1hciAxOCwgMjAyNCBhdCAwMjoyMDo1MFBNICsw
MTAwLCBFcmljIEF1Z2VyIHdyb3RlOg0KPj4gSGkgTWljaGFlbCwNCj4+DQo+PiBPbiAzLzEzLzI0
IDEyOjE3LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+PiA+IE9uIFdlZCwgTWFyIDEzLCAy
MDI0IGF0IDA3OjU0OjExQU0gKzAwMDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4+ID4+DQo+
PiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+ID4+PiBGcm9tOiBNaWNoYWVsIFMu
IFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEg
My82XSBpbnRlbF9pb21tdTogQWRkIGEgZnJhbWV3b3JrIHRvIGNoZWNrDQo+YW5kDQo+PiA+Pj4g
c3luYyBob3N0IElPTU1VIGNhcC9lY2FwDQo+PiA+Pj4NCj4+ID4+PiBPbiBXZWQsIE1hciAxMywg
MjAyNCBhdCAwMjo1MjozOUFNICswMDAwLCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6DQo+PiA+Pj4+
IEhpIE1pY2hhZWwsDQo+PiA+Pj4+DQo+PiA+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPj4gPj4+Pj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4+
ID4+Pj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMy82XSBpbnRlbF9pb21tdTogQWRkIGEgZnJh
bWV3b3JrIHRvDQo+Y2hlY2sgYW5kDQo+PiA+Pj4+PiBzeW5jIGhvc3QgSU9NTVUgY2FwL2VjYXAN
Cj4+ID4+Pj4+DQo+PiA+Pj4+PiBPbiBXZWQsIEZlYiAyOCwgMjAyNCBhdCAwNTo0NDoyOVBNICsw
ODAwLCBaaGVuemhvbmcgRHVhbg0KPndyb3RlOg0KPj4gPj4+Pj4+IEZyb206IFlpIExpdSA8eWku
bC5saXVAaW50ZWwuY29tPg0KPj4gPj4+Pj4+DQo+PiA+Pj4+Pj4gQWRkIGEgZnJhbWV3b3JrIHRv
IGNoZWNrIGFuZCBzeW5jaHJvbml6ZSBob3N0IElPTU1VIGNhcC9lY2FwDQo+d2l0aA0KPj4gPj4+
Pj4+IHZJT01NVSBjYXAvZWNhcC4NCj4+ID4+Pj4+Pg0KPj4gPj4+Pj4+IFRoZSBzZXF1ZW5jZSB3
aWxsIGJlOg0KPj4gPj4+Pj4+DQo+PiA+Pj4+Pj4gdnRkX2NhcF9pbml0KCkgaW5pdGlhbGl6ZXMg
aW9tbXUtPmNhcC9lY2FwLg0KPj4gPj4+Pj4+IHZ0ZF9jaGVja19oZGV2KCkgdXBkYXRlIGlvbW11
LT5jYXAvZWNhcCBiYXNlZCBvbiBob3N0DQo+Y2FwL2VjYXAuDQo+PiA+Pj4+Pj4gaW9tbXUtPmNh
cF9mcm96ZW4gc2V0IHdoZW4gbWFjaGluZSBjcmVhdGUgZG9uZSwgaW9tbXUtDQo+PmNhcC9lY2Fw
DQo+PiA+Pj4+PiBiZWNvbWUgcmVhZG9ubHkuDQo+PiA+Pj4+Pj4gSW1wbGVtZW50YXRpb24gZGV0
YWlscyBmb3IgZGlmZmVyZW50IGJhY2tlbmRzIHdpbGwgYmUgaW4gZm9sbG93aW5nDQo+PiA+Pj4g
cGF0Y2hlcy4NCj4+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVs
LmNvbT4NCj4+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBZaSBTdW4gPHlpLnkuc3VuQGxpbnV4Lmlu
dGVsLmNvbT4NCj4+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4gPj4+Pj4+IC0tLQ0KPj4gPj4+Pj4+ICBpbmNsdWRlL2h3
L2kzODYvaW50ZWxfaW9tbXUuaCB8ICAxICsNCj4+ID4+Pj4+PiAgaHcvaTM4Ni9pbnRlbF9pb21t
dS5jICAgICAgICAgfCA1MA0KPj4gPj4+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0NCj4+ID4+Pj4+PiAgMiBmaWxlcyBjaGFuZ2VkLCA1MCBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pDQo+PiA+Pj4+Pj4NCj4+ID4+Pj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9p
Mzg2L2ludGVsX2lvbW11LmgNCj4+ID4+Pj4+IGIvaW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11
LmgNCj4+ID4+Pj4+PiBpbmRleCBiYmM3Yjk2YWRkLi5jNzFhMTMzODIwIDEwMDY0NA0KPj4gPj4+
Pj4+IC0tLSBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oDQo+PiA+Pj4+Pj4gKysrIGIv
aW5jbHVkZS9ody9pMzg2L2ludGVsX2lvbW11LmgNCj4+ID4+Pj4+PiBAQCAtMjgzLDYgKzI4Myw3
IEBAIHN0cnVjdCBJbnRlbElPTU1VU3RhdGUgew0KPj4gPj4+Pj4+DQo+PiA+Pj4+Pj4gICAgICB1
aW50NjRfdCBjYXA7ICAgICAgICAgICAgICAgICAgIC8qIFRoZSB2YWx1ZSBvZiBjYXBhYmlsaXR5
IHJlZyAqLw0KPj4gPj4+Pj4+ICAgICAgdWludDY0X3QgZWNhcDsgICAgICAgICAgICAgICAgICAv
KiBUaGUgdmFsdWUgb2YgZXh0ZW5kZWQgY2FwYWJpbGl0eSByZWcNCj4qLw0KPj4gPj4+Pj4+ICsg
ICAgYm9vbCBjYXBfZnJvemVuOyAgICAgICAgICAgICAgICAvKiBjYXAvZWNhcCBiZWNvbWUgcmVh
ZC1vbmx5IGFmdGVyDQo+PiA+Pj4gZnJvemVuICovDQo+PiA+Pj4+Pj4gICAgICB1aW50MzJfdCBj
b250ZXh0X2NhY2hlX2dlbjsgICAgIC8qIFNob3VsZCBiZSBpbiBbMSxNQVhdICovDQo+PiA+Pj4+
Pj4gICAgICBHSGFzaFRhYmxlICppb3RsYjsgICAgICAgICAgICAgIC8qIElPVExCICovDQo+PiA+
Pj4+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxf
aW9tbXUuYw0KPj4gPj4+Pj4+IGluZGV4IGZmYTFhZDY0MjkuLmE5ZjlkZmQ2YTcgMTAwNjQ0DQo+
PiA+Pj4+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+Pj4+Pj4gKysrIGIvaHcv
aTM4Ni9pbnRlbF9pb21tdS5jDQo+PiA+Pj4+Pj4gQEAgLTM1LDYgKzM1LDggQEANCj4+ID4+Pj4+
PiAgI2luY2x1ZGUgInN5c2VtdS9rdm0uaCINCj4+ID4+Pj4+PiAgI2luY2x1ZGUgInN5c2VtdS9k
bWEuaCINCj4+ID4+Pj4+PiAgI2luY2x1ZGUgInN5c2VtdS9zeXNlbXUuaCINCj4+ID4+Pj4+PiAr
I2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb21tb24uaCINCj4+ID4+Pj4+PiArI2luY2x1ZGUgInN5
c2VtdS9pb21tdWZkLmgiDQo+PiA+Pj4+Pj4gICNpbmNsdWRlICJody9pMzg2L2FwaWNfaW50ZXJu
YWwuaCINCj4+ID4+Pj4+PiAgI2luY2x1ZGUgImt2bS9rdm1faTM4Ni5oIg0KPj4gPj4+Pj4+ICAj
aW5jbHVkZSAibWlncmF0aW9uL3Ztc3RhdGUuaCINCj4+ID4+Pj4+PiBAQCAtMzgxOSw2ICszODIx
LDM4IEBAIFZUREFkZHJlc3NTcGFjZQ0KPj4gPj4+Pj4gKnZ0ZF9maW5kX2FkZF9hcyhJbnRlbElP
TU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KPj4gPj4+Pj4+ICAgICAgcmV0dXJuIHZ0ZF9kZXZf
YXM7DQo+PiA+Pj4+Pj4gIH0NCj4+ID4+Pj4+Pg0KPj4gPj4+Pj4+ICtzdGF0aWMgaW50IHZ0ZF9j
aGVja19sZWdhY3lfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiA+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1VTGVnYWN5RGV2aWNlICpsZGV2LA0KPj4gPj4+
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+PiA+
Pj4+Pj4gK3sNCj4+ID4+Pj4+PiArICAgIHJldHVybiAwOw0KPj4gPj4+Pj4+ICt9DQo+PiA+Pj4+
Pj4gKw0KPj4gPj4+Pj4+ICtzdGF0aWMgaW50IHZ0ZF9jaGVja19pb21tdWZkX2hkZXYoSW50ZWxJ
T01NVVN0YXRlICpzLA0KPj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSU9NTVVGRERldmljZSAqaWRldiwNCj4+ID4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ID4+Pj4+PiArew0KPj4gPj4+Pj4+ICsgICAg
cmV0dXJuIDA7DQo+PiA+Pj4+Pj4gK30NCj4+ID4+Pj4+PiArDQo+PiA+Pj4+Pj4gK3N0YXRpYyBp
bnQgdnRkX2NoZWNrX2hkZXYoSW50ZWxJT01NVVN0YXRlICpzLA0KPj4gPj4+IFZUREhvc3RJT01N
VURldmljZQ0KPj4gPj4+Pj4gKnZ0ZF9oZGV2LA0KPj4gPj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgIEVycm9yICoqZXJycCkNCj4+ID4+Pj4+PiArew0KPj4gPj4+Pj4+ICsgICAgSG9z
dElPTU1VRGV2aWNlICpiYXNlX2RldiA9IHZ0ZF9oZGV2LT5kZXY7DQo+PiA+Pj4+Pj4gKyAgICBJ
T01NVUZERGV2aWNlICppZGV2Ow0KPj4gPj4+Pj4+ICsNCj4+ID4+Pj4+PiArICAgIGlmIChiYXNl
X2Rldi0+dHlwZSA9PSBISURfTEVHQUNZKSB7DQo+PiA+Pj4+Pj4gKyAgICAgICAgSU9NTVVMZWdh
Y3lEZXZpY2UgKmxkZXYgPSBjb250YWluZXJfb2YoYmFzZV9kZXYsDQo+PiA+Pj4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVMZWdhY3lEZXZp
Y2UsIGJhc2UpOw0KPj4gPj4+Pj4+ICsNCj4+ID4+Pj4+PiArICAgICAgICByZXR1cm4gdnRkX2No
ZWNrX2xlZ2FjeV9oZGV2KHMsIGxkZXYsIGVycnApOw0KPj4gPj4+Pj4+ICsgICAgfQ0KPj4gPj4+
Pj4+ICsNCj4+ID4+Pj4+PiArICAgIGlkZXYgPSBjb250YWluZXJfb2YoYmFzZV9kZXYsIElPTU1V
RkREZXZpY2UsIGJhc2UpOw0KPj4gPj4+Pj4+ICsNCj4+ID4+Pj4+PiArICAgIHJldHVybiB2dGRf
Y2hlY2tfaW9tbXVmZF9oZGV2KHMsIGlkZXYsIGVycnApOw0KPj4gPj4+Pj4+ICt9DQo+PiA+Pj4+
Pj4gKw0KPj4gPj4+Pj4+ICBzdGF0aWMgaW50IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZShQQ0lC
dXMgKmJ1cywgdm9pZCAqb3BhcXVlLA0KPmludA0KPj4gPj4+Pj4gZGV2Zm4sDQo+PiA+Pj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhvc3RJT01NVURldmljZSAqYmFz
ZV9kZXYsIEVycm9yICoqZXJycCkNCj4+ID4+Pj4+PiAgew0KPj4gPj4+Pj4+IEBAIC0zODI5LDYg
KzM4NjMsNyBAQCBzdGF0aWMgaW50DQo+PiA+Pj4gdnRkX2Rldl9zZXRfaW9tbXVfZGV2aWNlKFBD
SUJ1cw0KPj4gPj4+Pj4gKmJ1cywgdm9pZCAqb3BhcXVlLCBpbnQgZGV2Zm4sDQo+PiA+Pj4+Pj4g
ICAgICAgICAgLmRldmZuID0gZGV2Zm4sDQo+PiA+Pj4+Pj4gICAgICB9Ow0KPj4gPj4+Pj4+ICAg
ICAgc3RydWN0IHZ0ZF9hc19rZXkgKm5ld19rZXk7DQo+PiA+Pj4+Pj4gKyAgICBpbnQgcmV0Ow0K
Pj4gPj4+Pj4+DQo+PiA+Pj4+Pj4gICAgICBhc3NlcnQoYmFzZV9kZXYpOw0KPj4gPj4+Pj4+DQo+
PiA+Pj4+Pj4gQEAgLTM4NDgsNiArMzg4MywxMyBAQCBzdGF0aWMgaW50DQo+PiA+Pj4gdnRkX2Rl
dl9zZXRfaW9tbXVfZGV2aWNlKFBDSUJ1cw0KPj4gPj4+Pj4gKmJ1cywgdm9pZCAqb3BhcXVlLCBp
bnQgZGV2Zm4sDQo+PiA+Pj4+Pj4gICAgICB2dGRfaGRldi0+aW9tbXVfc3RhdGUgPSBzOw0KPj4g
Pj4+Pj4+ICAgICAgdnRkX2hkZXYtPmRldiA9IGJhc2VfZGV2Ow0KPj4gPj4+Pj4+DQo+PiA+Pj4+
Pj4gKyAgICByZXQgPSB2dGRfY2hlY2tfaGRldihzLCB2dGRfaGRldiwgZXJycCk7DQo+PiA+Pj4+
Pj4gKyAgICBpZiAocmV0KSB7DQo+PiA+Pj4+Pj4gKyAgICAgICAgZ19mcmVlKHZ0ZF9oZGV2KTsN
Cj4+ID4+Pj4+PiArICAgICAgICB2dGRfaW9tbXVfdW5sb2NrKHMpOw0KPj4gPj4+Pj4+ICsgICAg
ICAgIHJldHVybiByZXQ7DQo+PiA+Pj4+Pj4gKyAgICB9DQo+PiA+Pj4+Pj4gKw0KPj4gPj4+Pj4+
ICAgICAgbmV3X2tleSA9IGdfbWFsbG9jKHNpemVvZigqbmV3X2tleSkpOw0KPj4gPj4+Pj4+ICAg
ICAgbmV3X2tleS0+YnVzID0gYnVzOw0KPj4gPj4+Pj4+ICAgICAgbmV3X2tleS0+ZGV2Zm4gPSBk
ZXZmbjsNCj4+ID4+Pj4+DQo+PiA+Pj4+PiBPa2F5LiBTbyB3aGVuIFZGSU8gZGV2aWNlIGlzIGNy
ZWF0ZWQsIGl0IHdpbGwgY2FsbA0KPj4gPj4+IHZ0ZF9kZXZfc2V0X2lvbW11X2RldmljZQ0KPj4g
Pj4+Pj4gYW5kIHRoYXQgaW4gdHVybiB3aWxsIHVwZGF0ZSBjYXBzLg0KPj4gPj4+Pj4NCj4+ID4+
Pj4+DQo+PiA+Pj4+Pg0KPj4gPj4+Pj4NCj4+ID4+Pj4+PiBAQCAtNDA4Myw3ICs0MTI1LDkgQEAg
c3RhdGljIHZvaWQgdnRkX2luaXQoSW50ZWxJT01NVVN0YXRlDQo+KnMpDQo+PiA+Pj4+Pj4gICAg
ICBzLT5pcV9kdyA9IGZhbHNlOw0KPj4gPj4+Pj4+ICAgICAgcy0+bmV4dF9mcmNkX3JlZyA9IDA7
DQo+PiA+Pj4+Pj4NCj4+ID4+Pj4+PiAtICAgIHZ0ZF9jYXBfaW5pdChzKTsNCj4+ID4+Pj4+PiAr
ICAgIGlmICghcy0+Y2FwX2Zyb3plbikgew0KPj4gPj4+Pj4+ICsgICAgICAgIHZ0ZF9jYXBfaW5p
dChzKTsNCj4+ID4+Pj4+PiArICAgIH0NCj4+ID4+Pj4+Pg0KPj4gPj4+Pj4gSWYgaXQncyBmcm9u
emVuIGl0J3MgYmVjYXVzZSBWRklPIHdhcyBhZGRlZCBhZnRlciBtYWNoaW5lIGRvbmUuDQo+PiA+
Pj4+PiBBbmQgdGhlbiB3aGF0PyBJIHRoaW5rIGNhcHMgYXJlIGp1c3Qgd3Jvbmc/DQo+PiA+Pj4+
IE5vdCBxdWl0ZSBnZXQgeW91ciBxdWVzdGlvbiBvbiBjYXBzIGJlaW5nIHdyb25nLiBCdXQgdHJ5
IHRvIGV4cGxhaW5zOg0KPj4gPj4+Pg0KPj4gPj4+PiBXaGVuIGEgaG90IHBsdWdnZWQgdmZpbyBk
ZXZpY2UncyBob3N0IGlvbW11IGNhcCBpc24ndCBjb21wYXRpYmxlDQo+d2l0aA0KPj4gPj4+PiB2
SU9NTVUncywgaG90cGx1ZyBzaG91bGQgZmFpbC4gQ3VycmVudGx5IHRoZXJlIGlzIG5vIGNoZWNr
IGZvciB0aGlzDQo+YW5kDQo+PiA+Pj4+IGFsbG93IGhvdHBsdWcgdG8gc3VjY2VlZCwgYnV0IHRo
ZW4gc29tZSBpc3N1ZSB3aWxsIHJldmVhbCBsYXRlciwNCj4+ID4+Pj4gZS5nLiwgdklPTU1VJ3Mg
TUdBVyA+IGhvc3QgSU9NTVUncyBNR0FXLCBndWVzdCBjYW4gc2V0dXANCj5pb3ZhDQo+PiA+Pj4+
IG1hcHBpbmcgYmV5b25kIGhvc3Qgc3VwcG9ydGVkIGlvdmEgcmFuZ2UsIHRoZW4gRE1BIHdpbGwg
ZmFpbC4NCj4+ID4+Pj4NCj4+ID4+Pj4gSW4gZmFjdCwgYmVmb3JlIHRoaXMgc2VyaWVzLCBjYXAg
aXMgbm90IGltcGFjdGVkIGJ5IFZGSU8sIHNvIGl0J3Mgc2FtZQ0KPmVmZmVjdCBvZg0KPj4gPj4+
PiBmcm96ZW4gYWZ0ZXIgbWFjaGluZSBkb25lLg0KPj4gPj4+Pg0KPj4gPj4+Pj4NCj4+ID4+Pj4+
IEkgdGhpbmsgdGhlIHdheSB0byBhcHByb2FjaCB0aGlzIGlzIGp1c3QgYnkgc3BlY2lmeWluZyB0
aGlzDQo+PiA+Pj4+PiBhcyBhbiBvcHRpb24gb24gY29tbWFuZCBsaW5lLg0KPj4gPj4+PiBEbyB5
b3UgbWVhbiBhZGQgYSBjYXBfZnJvemVuIHByb3BlcnR5IHRvIGludGVsX2lvbW11Pw0KPj4gPj4+
PiBWdGRfaW5pdCgpIGlzIGNhbGxlZCBpbiByZWFsaXplKCkgYW5kIHN5c3RlbSByZXNldCgpLCBz
byBJIHV0aWxpemUgcmVhbGl6ZSgpDQo+dG8gaW5pdA0KPj4gPj4+IGNhcA0KPj4gPj4+PiBhbmQg
ZnJvemUgY2FwIGJlZm9yZSBzeXN0ZW0gcmVzZXQoKS4gSWYgY2FwX2Zyb3plbiBpcyBhbiBvcHRp
b24sIHdoZW4NCj5pdCdzDQo+PiA+Pj4gc2V0IHRvDQo+PiA+Pj4+IGZhbHNlLCBjYXAgY291bGQg
YmUgdXBkYXRlZCBldmVyeSBzeXN0ZW0gcmVzZXQgYW5kIGl0J3Mgbm90IGEgZml4IHZhbHVlDQo+
YW55DQo+PiA+Pj4gbW9yZS4NCj4+ID4+Pj4gVGhpcyBtYXkgYnJlYWsgbWlncmF0aW9uLg0KPj4g
Pj4+IE5vLCBJIG1lYW4gZWl0aGVyDQo+PiA+Pj4gMS4gYWRkIHNvbWUga2luZCBvZiB2ZmlvLWlv
bW11IGRldmljZSB0aGF0IGlzIG5vdCBleHBvc2VkIHRvIGd1ZXN0DQo+PiA+Pj4gICBidXQgaXMg
bm90IGhvdCBwbHVnZ2FibGUNCj4+ID4+IE5vdCBxdWl0ZSBnZXQsIHdoYXQgd2lsbCBzdWNoIHZm
aW8taW9tbXUgZGV2aWNlIGJlIHVzZWQgZm9yIGlmIG5vdA0KPmV4cG9zZWQgdG8gZ3Vlc3QuDQo+
PiA+IEl0IHdpbGwgdXBkYXRlIHRoZSBJT01NVS4NCj4+ID4gQW5kIGRvIHNvIHdpdGhvdXQgbmVl
ZCBmb3IgdHJpY2t5IGNhbGxiYWNrcy4NCj4+ID4NCj4+DQo+PiBBdCB0aGUgbW9tZW50IHRoZSBv
bmx5IHdheSBWRklPIGNhbiBwYXNzIGluZm8gdG8gdklPTU1VIGlzIHRocm91Z2ggdGhlDQo+PiBJ
T01NVSBNUiBBUEkgKElPTU1VTWVtb3J5UmVnaW9uQ2xhc3MpLg0KPj4gVW5mb3J0dW5hdGVseSB0
aGlzIEFQSSBpcyBub3QgZnVsbHkgYWRhcHRlZCB0byBuZXcgdXNlIGNhc2VzIGJlY2F1c2UgaXQN
Cj4+IHJlbGllcyBvbiB0aGUgSU9NTVUgTVIgdG8gYmUgZW5hYmxlZCB3aGljaCBjYXVzZXMgdGhl
IFZGSU8NCj4+DQo+PiB2ZmlvX2xpc3RlbmVyX3JlZ2lvbl9hZGQoKSB0byBiZSBjYWxsZWQgYW5k
IGNhbGwgdGhlIHJlbGV2YW50IElPTU1VIE1SDQo+Y2FsbGJhY2suIEJlZm9yZSB0aGUgSU9NTVUg
TVIgZW5hYmxlbWVudCB0aGVyZSBpcyBubyB3YXkgdG8gY29udmV5IGluZm8NCj5mcm9tIFZGSU8g
dG8gdGhlIHZJT01NVS4gVGhhdCB3aHksIGZvciBzZXZlcmFsIHllYXJzIGFuZCBzaW5jZSB0aGUN
Cj5iZWdpbm5pbmcgb2YgZGlzY3Vzc2lvbnMgcmVsYXRlZCB0byBuZXN0ZWQgSU9NTVUsIFBldGVy
IFh1LCBZaSBMaXUsIG15c2VsZg0KPmhlYWRlZCB0b3dhcmRzIHRoZSB1c2FnZSBvZiBQQ0lJT01N
VU9wcyBpbnN0ZWFkLg0KPj4NCj4+DQo+PiBZb3Ugd2lsbCBmaW5kIGluDQo+PiBbUkZDIDAvN10g
VklSVElPLUlPTU1VL1ZGSU86IEZpeCBob3N0IGlvbW11IGdlb21ldHJ5IGhhbmRsaW5nIGZvcg0K
PmhvdHBsdWdnZWQgZGV2aWNlcw0KPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQw
MTE3MDgwNDE0LjMxNjg5MC0xLQ0KPmVyaWMuYXVnZXJAcmVkaGF0LmNvbS8NCj4+IHlldCBhbm90
aGVyIGV4YW1wbGUgb2Ygc3VjaCBraW5kIG9mIFBDSUlPTU1VT3BzLiBJbiB0aGF0IHNlcmllcyBp
bnN0ZWFkDQo+b2YgcmVseWluZyBvbiBhIEhvc3RJT01NVURldmljZSBvYmplY3QgYXMgcHJvcG9z
ZWQgYnkgWmhlbnpob25nIGl0IHVzZXMgYQ0KPmRpcmVjdCBjYWxsYmFjayBidXQgaXQgaXMgc3Rp
bGwgdGhlIHNhbWUgcHJpbmNpcGxlIGFuZCB0aGUgSG9zdElPTU1VRGV2aWNlDQo+bG9va3MgYmV0
dGVyIHRvIGFjY29tb2RhdGUgYm90aCBpb21tdWZkIGFuZCBWRklPIGJhY2tlbmQuDQo+Pg0KPj4N
Cj4+IGhvc3QgcmVzZXJ2ZWQgbWVtb3J5IHJlZ2lvbnMgaXMgbm90IHNvbWV0aGluZyB3ZSBjYW4g
ZWFzaWxpeSBkZXNjcmliZSBhdA0KPnZJT01NVSBsZXZlbC4gVGhlIGluZm8gYXJlIGZldGNoZWQg
ZnJvbSBob3N0IGFuZCBwcm9wYWdhdGVkIHRvIHRoZQ0KPnZJT01NVQ0KPj4NCj4+IEkgdGhpbmsg
bmVzdGVkIHN0YWdlIHNldHVwIHdvdWxkIGFsc28gbmVlZCB0aGlzIFBDSUlPTU1VT3BzIHRyaWNr
IHRvDQo+c2V0dXAgc3RhZ2UgMSBpbmZvLiBTbyB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBzbyBj
YWxsZWQgSG9zdElPTU1VRGV2aWNlDQo+b2JqZWN0IGhhcyBhIGJyb2FkZXIgc2NvcGUgdGhhbiBh
IGdhdyBvcHRpb24gb3IgZWNhcCBvcHRpb24gc2V0IEkgdGhpbmsuDQo+Pg0KPj4gSWYgeW91IGRv
bid0IGxpa2UgdGhpcyBhcHByb2FjaCwgcGxlYXNlIGNhbiB5b3UgZWxhYm9yYXRlIG9uIHRoZSAi
dmZpby0NCj5pb21tdSBkZXZpY2UiIHByb3Bvc2FsIGFib3ZlIHNvIHRoYXQgd2UgY2FuIGV4cGxv
cmUgaXQuDQo+Pg0KPj4gVGhhbmsgeW91IGluIGFkdmFuY2UNCj4+DQo+PiBFcmljDQo+DQo+DQo+
SGkgRXJpYywNCj5Tb3JyeSBhYm91dCB0aGUgZGVsYXkgaW4gYW5zd2VyaW5nIC0gd2FzIG9uIHZh
Y2F0aW9uLg0KPg0KPk15IGNvbmNlcm4gaXMgd2l0aCB1c2VyIGludGVyZmFjZSBub3Qgd2l0aCB0
aGUgaW50ZXJuYWwgQVBJIHVzZWQuDQo+VGhlIGNvbmNlcm4gaXMgc2ltcGxlIC0gYXNzeW1ldHJ5
IGFuZCBjb21wbGV4IHJ1bGVzIGluIGhhbmRsaW5nIGRldmljZXMuDQo+RS5nLiBhIG5vbiBob3Rw
bHVnZ2VkIHZmaW8gZGV2aWNlIGFkanVzdHMgdGhlIHZJT01NVSwgdGhlbiB5b3UgY2FuDQo+cmVt
b3ZlIGl0IGFuZCBob3RwbHVnIGFub3RoZXIgb25lIGFuZCBpdCB3b3JrcywgYnV0IGlmIHlvdSBz
dGFydA0KPndpdGhvdXQgdmZpbyB0aGVuIGhvdHBsdWcgdGhlbiBpdCBtaWdodCBmYWlsIGJlY2F1
c2UgaXQncyB0b28gbGF0ZQ0KPnRvIGFkanVzdCB0aGUgdklPTU1VLg0KDQpKdXN0IGNsYXJpZnkg
dGhlIGFkanVzdG1lbnQgZnJvbSB2ZmlvIGlzIG9ubHkgemVyb2luZyB0aGUgY2FwL2VjYXAncyAx
IGJpdHMsDQpuZXZlciBzZXQgYW4gb3JpZ2luYWwgMCBiaXRzLiBTbyBpZiBob3RwbHVnIGZhaWxz
LCB0aGVuIGNvbGRwbHVnIHNob3VsZA0KYWxzbyBmYWlsIGZvciB0aGUgc2FtZSBkZXZpY2UuDQoN
Cj4NCj5BbmQgd2hhdCBJIGFtIHNheWluZywgaXMgdGhhdCB3ZSBlaXRoZXIgd2FudCBzb21ldGhp
bmcgb24gdGhlIHFlbXUNCj5jb21tYW5kIGxpbmUNCj50aGF0IHdpbGwgdGVsbCB0aGUgdklPTU1V
ICJwbGVhc2UgdXNlIGluZm8gZnJvbSB0aGUgaG9zdCIgb3INCj5oYXZlIG1hbmFnZW1lbnQgdGFr
ZSBpbmZvIGZyb20gdGhlIGhvc3QgYW5kIHN1cHBseSB0aGF0IHRvIHRoZSB2SU9NTVUuDQo+VGhl
IGZvcm1lciBzZWVtcyBtb3JlIHVzZXIgZnJpZW5kbHksIGZvciBzdXJlLiBUaGUgZGlzYWR2YW50
YWdlIG9mIGl0DQo+aXMgdGhhdCBvbmUgY2FuJ3QgZS5nLiB0YWtlIHRoZSBsZWFzdCBjb21tb24g
ZGVub21pbmF0b3IgYmV0d2VlbiB0d28NCj5ob3N0cyBhbmQgbWFrZSB0aGluZ3MgbWlncmF0ZWFi
bGUgaW4gdGhpcyB3YXkuDQo+SWYgd2UgbGltaXQgb3VyIGFtYml0aW9uIHRvIFZGSU8gdGhhdCBt
aWdodCBiZSBhY2NlcHRhYmxlLCBhZnRlciBhbGwNCj5WRklPIGFscmVhZHkgYXNzdW1lcyB2ZXJ5
IHNpbWlsYXIgaGFyZHdhcmUgb24gc3JjIGFuZCBkc3Qgb2YgbWlncmF0aW9uLg0KPlRoZSBsYXRl
ciBpcyB3aGF0IHdlIGRpZCBmb3IgYXctYml0cy4NCg0KV2UgY2FuIGdldCBob3N0IElPTU1VJ3Mg
aHcgY2FwL2VjYXAgYnkgcmVhZGluZyBiZWxvdyBmaWxlOg0KDQovc3lzL2RldmljZXMvdmlydHVh
bC9pb21tdS9kbWFyWypdL2ludGVsLWlvbW11L1tjYXB8ZWNhcF0NCg0KQnV0IGl0J3Mgbm90IGFj
Y3VyYXRlIGFzIGtlcm5lbCBjb21tYW5kIGxpbmUgY2FuIGxpbWl0IHRoZSBzdXBwb3J0IGZyb20N
CnNvZnR3YXJlIGFzcGVjdCwgZS5nLiwgaW50ZWxfaW9tbXU9b2ZmL3NtX29mZi4NCg0KU28gSSdk
IGxpa2UgdG8gZm9sbG93IHVwIHRoZSAybmQgd2F5LCBhZGQgdHdvIG9wdGlvbnMgd2hpY2ggZGVm
YXVsdHMgMCwNCg0KKyAgICBERUZJTkVfUFJPUF9VSU5UNjQoImhvc3RfY2FwIiwgSW50ZWxJT01N
VVN0YXRlLCBob3N0X2NhcCwgMCksDQorICAgIERFRklORV9QUk9QX1VJTlQ2NCgiaG9zdF9lY2Fw
IiwgSW50ZWxJT01NVVN0YXRlLCBob3N0X2VjYXAsIDApLA0KDQpXaGVuIGFueSBpcyBzZXQgYnkg
bWFuYWdlbWVudCwgaXQgb3ZlcnJpZGVzIHZJT01NVSBkZWZhdWx0IHZhbHVlLA0KT3IgZWxzZSB1
c2UgZGVmYXVsdC4NCg0KV2l0aCBjYXAvZWNhcCBzZXQgYnkgbWFuYWdlbWVudCwgd2Ugc3RpbGwg
bmVlZCB0byBoYXZlIHRoZSBjYXAvZWNhcA0KY2hlY2sgbG9naWMgYmV0d2VlbiBob3N0IGFuZCB2
SU9NTVUsIGJ1dCBubyB1cGRhdGUsIG5vIGZyb3plbi4NCg0KVGhlIHN1Z2dlc3Rpb24gZm9yIG1h
bmFnZW1lbnQgaXMgdG8gc2V0IGEgdmFsdWUgYmFzZWQgb24NCi9zeXMvZGV2aWNlcy92aXJ0dWFs
L2lvbW11L2RtYXJbKl0vaW50ZWwtaW9tbXUvW2NhcHxlY2FwXQ0KQnV0IGRvIG5vdCBhc3NpZ24g
YSByYW5kb20gdmFsdWUuDQoNCkxldCBtZSBrbm93IGlmIEkgbWlzdW5kZXJzdGFuZCBhbnl0aGlu
Z/CfmIoNCg0KPg0KPkkgc2VlIGxvdHMgb2YgYWNjZXB0YWJsZSBvcHRpb25zLCBidXQgeWVzIGl0
IHNlZW1zIG5pY2UgdG8gaGF2ZQ0KPnNvbWV0aGluZyBzaW5nbGUgdGhhdCB3aWxsIHdvcmsgZm9y
IGFsbCBJT01NVXMgYW5kIGFsc28gbWF5YmUgbGl2ZSB1bmRlcg0KPlZGSU8/IFRodXMgSSBjYW1l
IHVwIHdpdGggdGhlIGlkZWEgb2YgYSBzdHViIGRldmljZSBsaXZpbmcgdW5kZXIgdmZpbw0KPndo
bydzIGpvYiBpcyBqdXN0IHRvIGJlIHByZXNlbnQgb24gY29tbWFuZCBsaW5lIGFuZCBhZGp1c3Qg
dGhlIGd1ZXN0DQo+bWFjaGluZSAoQVRNIHRoZSB2aW9tbXUgYnV0IHdlIG1pZ2h0IHNlZSBvdGhl
ciB1c2VzIHRvbykgdG8gbWF0Y2ggaG9zdC4NCg0KSUlVQywga2VybmVsIGRvZXNu4oCZdCBwcm92
aWRlIGFueSBpb2N0bCgpIGZvciBhIHN0dWIgZGV2aWNlIHRvIGdldA0KdGhlIGxlYXN0IGNvbW1v
biBkZW5vbWluYXRvciBvZiBjYXAvZWNhcCBvZiBhbGwgdGhlIGhvc3QgSU9NTVUgdW5pdHMuDQpT
byBJJ2QgbGlrZSB0byB0cnkgeW91ciBzdWdnZXN0aW9uIGFzIGFib3ZlIHRvIGFkZCBvcHRpb25z
Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

