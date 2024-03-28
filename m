Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512CAC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 03:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpg6h-00016I-Gs; Wed, 27 Mar 2024 23:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rpg6g-000166-2x
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:07:10 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rpg6d-0007VW-NB
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 23:07:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1711595228; x=1743131228;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ULVZVvld8pLvFNSN6LBazdR7MaWzNc63zzWehAs4VgA=;
 b=JajgeflkNFsJlozxZ1ByEiysKqP9c6P38UBv5WweUHWKi+ytZG/3zF7G
 PRphmIPQf9TLZH1uRf5zdV0yxbxjoQjiseiXfM0W9jIbkq1IggZyy9J8U
 q7nBP3c9sxjLgH8qemNjCvjw9b6ox8pzYTtzrMtbGx07kXfZ8Q759KHTK
 USa6eRoTn4g+rDzBsb6hUUjlpr/WzpvTTRz49NkAiyCdP36T5m1HMlztY
 L4q6n8dERG/h+W5BobqDjkI6b9oOvpRb0zWV4PfZ7icBFv5/vqsND72VG
 rWUEYgJiyGyinn2jEvPGQayFdKavjUqE4lDLUKc5lBCRh0PK0AjVUzTaN Q==;
X-CSE-ConnectionGUID: tlvRl75VRDWjUWtjmBP2fA==
X-CSE-MsgGUID: WzefShAGQ96FKIaXaBsB4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="29210545"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="29210545"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2024 20:07:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; d="scan'208";a="20974659"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Mar 2024 20:07:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 20:07:03 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 20:07:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 20:07:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXA1f9miYi4zYlW4xFmn/wxzkEEms5hlg5lgIJLxhaSjHRKKYgD4Az8crbm10Mp9v4eZ7Ny+mW8GCrkM/E2XzPeBIx8O7u+hLtjbmDheVjeWyQ3HOFBrfePjMzAzXevPJIvhXmsz+ihiW5ufelk9HAPFzCRh/pB1AmSfYxuc4rGKGJskTgPLAGzQTWhsI5rYZs5imc6BKEy8kag/nzR0aeOT2cB/cWQYByI7nFsfY8WEsmCSTg9zAfJRSvh3ntHUrK8cRTsAwGkJjqXfg3P3B/jNrRbYi2/+0glVmMumXkq2LO8m2H2Mx3c8N7QdN8v+WGZOXDL9tquOVWEJG0fBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULVZVvld8pLvFNSN6LBazdR7MaWzNc63zzWehAs4VgA=;
 b=beZTEo2g8o/LaevniXlGBU52UzaHkClaqDS2yU3Iz+vmF8n4V/yRF589/pJNOUyClQH69qbu4Zj2zob2miIYXWtnhb8t/Gru+69tUN0Rj2QkLjy6s3/nW7uGm8XzF+7P3TVkUOy2eJbdnllH2zklHYa5D1vy8/ktKRPBeobmq74E0As9nv27BO31yrwiwcWELLXKkOElSnbVYZisFOYDztwsOlyWovLMH8BXhIcPaz8vEFn4IFfQN0h7B922Vi6jNd/JP1dggWoVvKKWqKuh+fCDz7qLH9YPieENhmomcqMv4yx3yhaE7d7bk1B5mkpkp1722sHshrbLyaQRCNFmIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7269.namprd11.prod.outlook.com (2603:10b6:208:42b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 03:06:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::e4a3:76ce:879:9129%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 03:06:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Topic: [PATCH v1 01/11] Introduce a common abstract struct
 HostIOMMUDevice
Thread-Index: AQHaafrJT1f15ksRNUCyLoL+rga0E7E+15OAgAAJFUCADK2tgIABCXpg
Date: Thu, 28 Mar 2024 03:06:55 +0000
Message-ID: <SJ0PR11MB6744F798CF55CC8FF230CE7B923B2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240228035900.1085727-1-zhenzhong.duan@intel.com>
 <20240228035900.1085727-2-zhenzhong.duan@intel.com>
 <e6af68f4-f38d-413f-a63c-d1ae7254d802@redhat.com>
 <SJ0PR11MB674439E1DDE3DDE285571AEE922C2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <41d50645-9f81-40b1-9ca5-7bb2e73d90de@redhat.com>
In-Reply-To: <41d50645-9f81-40b1-9ca5-7bb2e73d90de@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7269:EE_
x-ms-office365-filtering-correlation-id: 3b883d64-019d-4e3a-5bd6-08dc4ed41fe6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jg/6RoNmAo3a+uJ/8fflDRUSYcCSqjVLEaG7fwOgyu8g51/dOpufjUpZUmYGLhr0ZXyGQdqJ/rOvilini7/zBcSuZPS2EjXimd07AGNLHI7rwaVUM/St4I521d5l4N7qAczU7fE+RQ5nZNR8WOLOflwIhgnIo2fF3415zTuPxIMr07PXb3BfpNrwCERjIQA/tz6LQxiOt1MWblERLW5dJKkK9YAaan7ZXl9BcLGcf7x2N3XXTU1wp1P3Eb02t7V7NIW8TrHqWZ/JspIC9xLOqP8eHZW3DAfs7Oohzu9VE3v9x7rCLbhult1Eyy6xqt+imSjxlab0xOt4hwjlWDwMQpzqxDYUUoxRfQ8kJ82iZjSF0+UF+VxnHM+cn0XxrZUp4SNuIlXxwA55PqwaG77TrdlzM2fKuFe2W4wbZ+EkcDGjLNRd9dSSh+RGnwratpLz75adl3E0C9Gj4YcoRgO91t3+8rhv4IasVMsj/tGlJfjNBrRrRIiX529NIOj6KHOin21uBezS0UqRZGuiCR9Jmh4xPAeNi6WV8HjxOWrvY5bW60JjZE9rKOziJi2bX/wcjrXyuxavPu3WbfJY1E2Bfinz8xn4XZobMxIovLsTDY9LE/EBSEV4slTRjwCxDufYdaupz4d/075yeqBLQe3L7HVZW7lM0hg909/1hSQ6Gho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(7416005)(366007)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkFMS01aUkdNT211U3FwVXcydWl3b3BVWGdwYmE1MUtOT3BMTEd0QlBxWlBQ?=
 =?utf-8?B?QXM4ZmRvVWNld2d5YnBDa2xlWjlROWo4azN6Q3VUNzZUZlEwd3BLbEF5SklO?=
 =?utf-8?B?cHRIVktMcHZCVC9OYVRJTi8vWTErdFVTM1RySHZla09mQzFrWU5KeisvMnlW?=
 =?utf-8?B?RjJhc1pRV2pHUXlxc1U3eU12UEdwY1cxVWNXcG11Q1ZnSUJVUTYyT3ZCOVha?=
 =?utf-8?B?UUtCRWlZblpOejhFZ0dsWXV6THdiVlJnUHdRalFYQ2VQb1krb2tSa0ZJMnZL?=
 =?utf-8?B?Q1Yrdk9PMFlaVDVhTW8yUVJFVGNQOTU3OHU5c3V0S1NtcE1UV1V6amJTV21I?=
 =?utf-8?B?WlM1amZZVDBCMTFJNUFWalFWUlcrWnBPSElLdGpXNnJOS3lCUnVrTHNMK3Ju?=
 =?utf-8?B?ZWhLUUpNNytCV0M3RDF0ci82RmpnQUEwQXJWWER4WlhiSm9YSUlwQ0hMbkFX?=
 =?utf-8?B?SFRCUmhmNmFTckt5Y3JlZE50cml1WndzTEM2eUJxVCs3TjJLYmRHS0szL21Q?=
 =?utf-8?B?TnlkSjA1OWV0eVZHcmlKS3pYMUpwUVNaakkwbythNmYwTzhJMDkwZ0QzcHdU?=
 =?utf-8?B?QlZPRlNwclc0K1ZhNEtscG1HbFFvUGFtOGc4QXdUQmtKS29BcllyNW1YMGRD?=
 =?utf-8?B?WlBad0tTd1NsN0NjYW81ZjExaWtybmcrS1Bmb2VZSlV2Z0hIejY3MlA0cnhU?=
 =?utf-8?B?NWlhYU04LzR3Ukd5Kzl0QTZnaWNvS3lZLzRONnZQOGh1OGhFTkE0OXgrcU9u?=
 =?utf-8?B?RG4wZ3lCZTlkeFZab0tnMkp2d01EUnJJaTlPM0lTZU5zOGZvV0ptcTBsLzdN?=
 =?utf-8?B?YnUzUVZLekQrZmFlUWRzdkhDdDhBV1FZU0dCMTZPK28zNDVqNHJadXpFdTM0?=
 =?utf-8?B?ZFRvWElZSDdZM3dFSXVIL2lDMkZ6cEI4ODM2RG1keWFNbjdVSlFQOEp4elp0?=
 =?utf-8?B?cUprRGMvRDdGaktCS3RNOCttY24rVEZtd0hqMTZNTVlMNXNDb0x6V2RodGZK?=
 =?utf-8?B?TnlUUys3NEdxVXhwNm9KOWxhVXJqdmgzZVJnZW1LZGJhWHZoUHJFb0lUNXFy?=
 =?utf-8?B?NDk3RU15NzNZRmhpaWsrSXoyVnpsbnB3QzFjRnlmOG1XaUlsTkFFNGN4dUN4?=
 =?utf-8?B?UFdoU2NmbUkxMWVYUmFQTHhYRFEvZ3ZqeGo4d0lTY2t6VmNyL255M1BmaU96?=
 =?utf-8?B?eU9RVkhCbXB0RDdDWkJ0ZXo4djY3KzlLOUFHN0V6ZHJlUXNUcGZpU0VpOVpL?=
 =?utf-8?B?djExZm9tNm1VL0MvMTVnYTE3Q1N6aEc5ejFycS9ORlFwTDRKcCtRQkNoZGlH?=
 =?utf-8?B?UTRUUmVCeEErRkhqUUFrZHNkcGJNTHhUN2NRYXQ4cTVwK1l1NEdoc1l5c056?=
 =?utf-8?B?RVRYKzVBcHlSbW1NN3V6dU1BbFZBOXc3dUVwQzZkQ3hXZ1hoamlhRzRYWVpo?=
 =?utf-8?B?aWdoZzlDcWpGWHpuL0Jsd2FaMzFtOHV1dk1HWkRVVEZ5eWpKZGJ1SFBkK2tX?=
 =?utf-8?B?Y0lORnFiVGk2L2l2R3ExUW1WVVNiYjcxellQYUNESEJHV0hGbWRCM0w0MVdT?=
 =?utf-8?B?bEIvZTZWK3JDOE90aGoxci9uNDV3c2dxdG5JMk9Ma0hSMGhmdjZSOW9SMWRx?=
 =?utf-8?B?NWhNMEJ6cStRc1c1Zm4rQ21zUjNuWTg3UmNUTXA2NkRlaVZnd24vWHdVQ21v?=
 =?utf-8?B?VkJ2UW5MRC9lQmVjSnNXbU5FVkxielpEamM0aVR2QlFySjByMU4zclUyV0VB?=
 =?utf-8?B?dFRka3M4OFNDN3NnSFVpcHlVbmlTN2QxRllTZHlNL1p6RWxINk41R3YyenZN?=
 =?utf-8?B?MDF3OGpWV05FUTdiVzVuWFRCRVNGbFBjSHNrRVBCUzIxVk9EQndzczlQL0E2?=
 =?utf-8?B?cDVWN2RzaTZxT3Y1a1JLbHpQZ1hzTTNOUFFKa2NVT0llV21RcDY1aFIrS1E4?=
 =?utf-8?B?SEFJUXZWL29ob3YyUFZoYU0zRUdYUTBZSTgvZDVDaEJmelM3Y0xLQVV0Y2FO?=
 =?utf-8?B?YlcxaTNyelk5ZXF1UUVoYUZMVnZITFhXNGFFemp6Q0ZJTXViWDNyVGhFSE1M?=
 =?utf-8?B?UlVYVDZoZExyb2VEak80aHFJSmVQQ0U0d2VhZHBsYXdBTllrZW94SlVRUTcz?=
 =?utf-8?Q?xMNjQWmb2WriNpds4Lub0YoCU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b883d64-019d-4e3a-5bd6-08dc4ed41fe6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 03:06:55.4756 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cHIh2Ok5TOt7PFTOy4lzUhFTARRvL7Z477KVf3ZtPALuscbBxDui1KcCln8qxqIMQLRrZ051wXKJ+j4bF5SIG+ka6NvcrDa6RHzTARMjzEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7269
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMDEv
MTFdIEludHJvZHVjZSBhIGNvbW1vbiBhYnN0cmFjdCBzdHJ1Y3QNCj5Ib3N0SU9NTVVEZXZpY2UN
Cj4NCj5IZWxsbyBaaGVuemhvbmcsDQo+DQo+T24gMy8xOS8yNCAxMjo1OCwgRHVhbiwgWmhlbnpo
b25nIHdyb3RlOg0KPj4gSGkgQ8OpZHJpYywNCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4g
U2VudDogVHVlc2RheSwgTWFyY2ggMTksIDIwMjQgNDoxNyBQTQ0KPj4+IFRvOiBEdWFuLCBaaGVu
emhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IHFlbXUtDQo+Pj4gZGV2ZWxAbm9uZ251
Lm9yZw0KPj4+IENjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgZXJpYy5hdWdlckByZWRo
YXQuY29tOw0KPj4+IHBldGVyeEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOyBtc3RA
cmVkaGF0LmNvbTsNCj4+PiBqZ2dAbnZpZGlhLmNvbTsgbmljb2xpbmNAbnZpZGlhLmNvbTsgam9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbTsgVGlhbiwNCj4+PiBLZXZpbiA8a2V2aW4udGlhbkBpbnRl
bC5jb20+OyBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT47IFN1biwgWWkgWQ0KPj4+IDx5
aS55LnN1bkBpbnRlbC5jb20+OyBQZW5nLCBDaGFvIFAgPGNoYW8ucC5wZW5nQGludGVsLmNvbT4N
Cj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDAxLzExXSBJbnRyb2R1Y2UgYSBjb21tb24gYWJz
dHJhY3Qgc3RydWN0DQo+Pj4gSG9zdElPTU1VRGV2aWNlDQo+Pj4NCj4+PiBIZWxsbyBaaGVuemhv
bmcsDQo+Pj4NCj4+PiBPbiAyLzI4LzI0IDA0OjU4LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+
Pj4gSG9zdElPTU1VRGV2aWNlIHdpbGwgYmUgaW5oZXJpdGVkIGJ5IHR3byBzdWIgY2xhc3NlcywN
Cj4+Pj4gbGVnYWN5IGFuZCBpb21tdWZkIGN1cnJlbnRseS4NCj4+Pj4NCj4+Pj4gSW50cm9kdWNl
IGEgaGVscGVyIGZ1bmN0aW9uIGhvc3RfaW9tbXVfYmFzZV9kZXZpY2VfaW5pdCB0byBpbml0aWFs
aXplIGl0Lg0KPj4+Pg0KPj4+PiBTdWdnZXN0ZWQtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJA
cmVkaGF0LmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9u
Zy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICAgIGluY2x1ZGUvc3lzZW11L2hvc3Rf
aW9tbXVfZGV2aWNlLmggfCAyMg0KPisrKysrKysrKysrKysrKysrKysrKysNCj4+Pj4gICAgMSBm
aWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKykNCj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+PiBiL2luY2x1ZGUvc3lz
ZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4+Pj4g
aW5kZXggMDAwMDAwMDAwMC4uZmU4MGFiMjVmYg0KPj4+PiAtLS0gL2Rldi9udWxsDQo+Pj4+ICsr
KyBiL2luY2x1ZGUvc3lzZW11L2hvc3RfaW9tbXVfZGV2aWNlLmgNCj4+Pj4gQEAgLTAsMCArMSwy
MiBAQA0KPj4+PiArI2lmbmRlZiBIT1NUX0lPTU1VX0RFVklDRV9IDQo+Pj4+ICsjZGVmaW5lIEhP
U1RfSU9NTVVfREVWSUNFX0gNCj4+Pj4gKw0KPj4+PiArdHlwZWRlZiBlbnVtIEhvc3RJT01NVURl
dmljZV9UeXBlIHsNCj4+Pj4gKyAgICBISURfTEVHQUNZLA0KPj4+PiArICAgIEhJRF9JT01NVUZE
LA0KPj4+PiArICAgIEhJRF9NQVgsDQo+Pj4+ICt9IEhvc3RJT01NVURldmljZV9UeXBlOw0KPj4+
PiArDQo+Pj4+ICt0eXBlZGVmIHN0cnVjdCBIb3N0SU9NTVVEZXZpY2Ugew0KPj4+PiArICAgIEhv
c3RJT01NVURldmljZV9UeXBlIHR5cGU7DQo+Pj4NCj4+PiBBIHR5cGUgZmllbGQgaXMgbm90IGEg
Z29vZCBzaWduIGFuZCB0aGF0J3Mgd2hlcmUgUU9NIGlzIHVzZWZ1bC4NCj4+DQo+PiBZZXMsIGFn
cmVlLg0KPj4gSSBkaWRuJ3QgY2hvb3NlIFFPTSBiZWNhdXNlIGluIGlvbW11ZmQtY2RldiBzZXJp
ZXMsIFZGSU9Db250YWluZXINCj5jaG9vc2VzIG5vdCB1c2luZyBRT00gbW9kZWwuDQo+PiBTZWUg
dGhlIGRpc2N1c3Npb246DQo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL1ltdUZ2MnM1VFB1
dzdLJTJGdUB5ZWtrby8NCj4+IEkgdGhvdWdodCBIb3N0SU9NTVVEZXZpY2UgbmVlZCB0byBmb2xs
b3cgc2FtZSBydWxlLg0KPj4NCj4+IEJ1dCBhZnRlciBmdXJ0aGVyIGRpZ2dpbmcgaW50byB0aGlz
LCBJIHRoaW5rIGl0IG1heSBiZSBvayB0byB1c2UgUU9NIG1vZGVsDQo+YXMgbG9uZyBhcyB3ZSBk
b24ndCBleHBvc2UNCj4+IEhvc3RJT01NVURldmljZSBpbiBxYXBpL3FvbS5qc29uIGFuZCBub3Qg
dXNlIFVTRVJfQ1JFQVRBQkxFDQo+aW50ZXJmYWNlLiBZb3VyIHRob3VnaHRzPw0KPg0KPnllcy4g
Q2FuIHdlIGNoYW5nZSBhIGJpdCB0aGlzIHNlcmllcyB0byB1c2UgUU9NID8gc29tZXRoaW5nIGxp
a2UgOg0KPg0KPiAgICAgdHlwZWRlZiBzdHJ1Y3QgSG9zdElPTU1VRGV2aWNlIHsNCj4gICAgICAg
ICBPYmplY3QgcGFyZW50Ow0KPiAgICAgfSBIb3N0SU9NTVVEZXZpY2U7DQo+DQo+ICAgICAjZGVm
aW5lIFRZUEVfSE9TVF9JT01NVSAiaG9zdC5pb21tdSINCj4gICAgIE9CSkVDVF9ERUNMQVJFX1RZ
UEUoSG9zdElPTU1VRGV2aWNlLCBIb3N0SU9NTVVDbGFzcywNCj5IT1NUX0lPTU1VKQ0KPg0KPiAg
ICAgc3RydWN0IEhvc3RJT01NVUNsYXNzIHsNCj4gICAgICAgICBPYmplY3RDbGFzcyBwYXJlbnRf
Y2xhc3M7DQo+DQo+ICAgICAgICAgaW50ICgqZ2V0X3R5cGUpKEhvc3RJT01NVURldmljZSAqaGlv
ZCwgdWludDY0X3QgKnR5cGUsIEVycm9yICoqZXJycCk7DQo+ICAgICAgICAgaW50ICgqZ2V0X2Nh
cCkoSG9zdElPTU1VRGV2aWNlICpoaW9kLCB1aW50NjRfdCAqY2FwLCBFcnJvciAqKmVycnApOw0K
PiAgICAgfTsNCj4NCj5Jbmhlcml0ZWQgb2JqZWN0cyB3b3VsZCBiZSBUWVBFX0hPU1RfSU9NTVVf
SU9NTVVGRCBhbmQNCj5UWVBFX0hPU1RfSU9NTVVfTEVHQUNZLg0KPkVhY2ggY2xhc3MgaW1wbGVt
ZW50aW5nIHRoZSBoYW5kbGVycyBvciBub3QgKGxlZ2FjeSBtb2RlKS4NCg0KVW5kZXJzdG9vZCwg
dGhhbmtzIGZvciB5b3VyIGd1aWRlLg0KDQo+DQo+VGhlIGNsYXNzIGhhbmRsZXJzIGFyZSBpbnRy
b2R1Y2VkIGZvciB0aGUgaW50ZWwtaW9tbXUgaGVscGVyDQo+dnRkX2NoZWNrX2hkZXYoKQ0KPmlu
IG9yZGVyIHRvIGF2b2lkIHVzaW5nIGlvbW11ZmQgcm91dGluZXMgZGlyZWN0bHkuIEhvc3RJT01N
VURldmljZSBpcw0KPnN1cHBvc2VkDQo+dG8gYWJzdHJhY3QgdGhlIEhvc3QgSU9NTVUgZGV2aWNl
LCBzbyB3ZSBuZWVkIHRvIGFic3RyYWN0IGFsc28gYWxsIHRoZQ0KPmludGVyZmFjZXMgdG8gdGhp
cyBvYmplY3QuDQoNCkknZCBsaWtlIHRvIGhhdmUgYSBtaW5pbWFsIGFkanVzdG1lbnQgdG8gY2xh
c3MgaGFuZGVycy4gSnVzdCBsZXQgbWUga25vdyBpZiB5b3UgaGF2ZSBzdHJvbmcNCnByZWZlcmVu
Y2UuDQoNCkNhcC9lY2FwIGlzIGludGVsX2lvbW11IHNwZWNpZmljLCBJJ2QgbGlrZSB0byBtYWtl
IGl0IGEgYml0IGdlbmVyaWMgYWxzbyBmb3IgYXJtIHNtbXUgdXNhZ2UsDQphbmQgbWVyZ2UgZ2V0
X3R5cGUgYW5kIGdldF9jYXAgaW50byBvbmUgZnVuY3Rpb24gYXMgdGhleSBib3RoIGNhbGxzIGlv
Y3RsKElPTU1VX0dFVF9IV19JTkZPKSwNCnNvbWV0aGluZyBsaWtlOg0KZ2V0X2luZm8oSG9zdElP
TU1VRGV2aWNlICpoaW9kLCBlbnVtIGlvbW11X2h3X2luZm9fdHlwZSAqdHlwZSwgdm9pZCAqKmRh
dGEsIHZvaWQgKipsZW4sICBFcnJvciAqKmVycnApOw0KDQphbmQgbGV0IGlvbW11IGVtdWxhdGVy
IHRvIGV4dHJhY3QgY29udGVudCBvZiAqZGF0YS4gRm9yIGludGVsX2lvbW11LCBpdCdzOg0KDQpz
dHJ1Y3QgaW9tbXVfaHdfaW5mb192dGQgew0KICAgICAgICBfX3UzMiBmbGFnczsNCiAgICAgICAg
X191MzIgX19yZXNlcnZlZDsNCiAgICAgICAgX19hbGlnbmVkX3U2NCBjYXBfcmVnOw0KICAgICAg
ICBfX2FsaWduZWRfdTY0IGVjYXBfcmVnOw0KfTsNCg0KPg0KPlRoZSAuaG9zdF9pb21tdV9kZXZp
Y2VfY3JlYXRlKCkgaGFuZGxlciBjb3VsZCBiZSBtZXJnZWQNCj5pbiAuYXR0YWNoX2RldmljZSgp
DQo+cG9zc2libHkuIEFueWhvdywgcGxlYXNlIHVzZSBub3cgb2JqZWN0X25ldygpIGFuZCBvYmpl
Y3RfdW5yZWYoKSBpbnN0ZWFkLg0KPmhvc3RfaW9tbXVfYmFzZV9kZXZpY2VfaW5pdCgpIGlzIHVz
ZWxlc3MgSU1ITy4NCg0KR29vZCBpZGVhLCB3aWxsIGRvLg0KDQo+DQo+Pg0KPj4+DQo+Pj4gSXMg
dnRkX2NoZWNrX2hkZXYoKSB0aGUgb25seSB1c2Ugb2YgdGhpcyBmaWVsZCA/DQo+Pg0KPj4gQ3Vy
cmVudGx5IHllcy4gdmlydGlvLWlvbW11IG1heSBoYXZlIHNpbWlsYXIgdXNhZ2UuDQo+Pg0KPj4+
IElmIHNvLCBjYW4gd2Ugc2ltcGxpZnkgd2l0aCBhIFFPTSBpbnRlcmZhY2UgaW4gYW55IHdheSA/
DQo+Pg0KPj4gUU9NIGludGVyZmFjZSBpcyBhIHNldCBvZiBjYWxsYmFja3MsIGd1ZXNzIHlvdSBt
ZWFuIFFPTSBjbGFzcywNCj4+IHNheWluZyBIb3N0SU9NTVVEZXZpY2UgY2xhc3MsIElPTU1VTGVn
YWN5RGV2aWNlIGNsYXNzIGFuZA0KPklPTU1VRkREZXZpY2UgY2xhc3M/DQo+DQo+U2VlIGFib3Zl
IHByb3Bvc2FsLiBpdCBzaG91bGQgd29yayBmaW5lLg0KPg0KPkFsc28sIEkgdGhpbmsgaXQgaXMg
YmV0dGVyIHRvIHVzZSBhIElPTU1VRkRCYWNrZW5kKiBwYXJhbWV0ZXIgZm9yDQo+aW9tbXVmZF9k
ZXZpY2VfZ2V0X2luZm8oKSB0byBiZSBjb25zaXN0ZW50IHdpdGggdGhlIG90aGVyIHJvdXRpbmVz
Lg0KDQpTdXJlLCB0aGVuIEknZCBsaWtlIHRvIGFsc28gcmVuYW1lIGl0IHRvIGlvbW11ZmRfYmFj
a2VuZF9nZXRfZGV2aWNlX2luZm8oKS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0KPlRoZW4g
SXQgd291bGQgaW50ZXJlc3RpbmcgdG8gc2VlIGhvdyB0aGlzIGFwcGxpZXMgdG8gRXJpYydzIHNl
cmllcy4NCj4NCj5UaGFua3MsDQo+DQo+Qy4NCj4NCj4NCg0K

