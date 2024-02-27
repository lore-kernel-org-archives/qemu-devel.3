Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 802F9C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 03:50:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reoTX-0000B4-J5; Mon, 26 Feb 2024 22:49:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reoTW-00005L-56; Mon, 26 Feb 2024 22:49:50 -0500
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reoTG-0000Q0-MA; Mon, 26 Feb 2024 22:49:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709005775; x=1740541775;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WyfyJiF/UiblNzwhrcjuavQYMHJlQEh2PqR8gXIHqzw=;
 b=RAeKT9s56b3joeckjRO0JlKaHq3X59D1k9HzNy3fk+r7oWyWA7uwJaj3
 vBPVglr9vENyHcuGmaLofNjPRoPq+R8CCADzL0QX/YMSbNV5iuZuVi/wW
 Cy/NWWEHijSmzQKIkWApn71ihMyxmmjOq8DEcHaKCT/TL38ixsb0mNANU
 Z4iuUlAF1rkHjWxuTzmsOgvfeZdLt1urgQt1L926rnrR39Ts562HVQhjA
 Im+JBpA9uP+1TRjVtP0Y2A/CAKeRSa+Prq7NZM+yZvZ73MidCfQLu3stj
 SxKTDihzl5kQWHyMS5x/LwXiiWSnPWzLsrIaRfg0ybDZC2z+XcxNXFW1z g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3253150"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3253150"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 19:49:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="11673558"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 19:49:33 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:49:32 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 19:49:32 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:49:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfyiK85d/uSPB7wgsl2fVZuEX7QRaC1vUvRHk4dxbSkLWIBAWXZz/x2h3UiGJU/1beCWjsJwPHyJZSCUvQEMYLukDeC8AVl+7nAQEj9u/utCWW42kWvwqz1AzuYIbC9ATW/rn8qlPEYuKHNo1rGQP9fAySLsln+106oCG0XwWiayE5pqHdKODpG69+bmExnIvgEjyNyx+/FYO+eFZrRR5niFP3E0WMfoul2C0EPCeL5zQfhGo6yg4I5BRyaap6ZvVZ8enxnvZchG3c250d1y+8rWP7YzQZxVingDI5bKtRlsbU2VwzWIC4j/Q2mbWBkLMFSzl4zFBi8TDI0fiwhvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyfyJiF/UiblNzwhrcjuavQYMHJlQEh2PqR8gXIHqzw=;
 b=F/LLjAiwZ6jeEmHVaw4tSZ5Pf1CAq7un2A9SjbB+EzqPtklptmPpR59i6GWUWcqXr5e1ycHoez47n9LisGJpw/FJ+AJoK3i8NvR3avs70cXOaLoVaMAjibIDWXRoYT/g/tQiiVDGttHLoUHBFkzpyQmy5JAXt4bOGoOBWQKFbGr1j0eo3lH3MWjdO5FpCedhlX+EbtQp4xwl/kuS0YIFWT/XPtwNDdiTfyX6mESw6g6ohrODwv9WXJDk1mmpIPS1j4fUgzkm6hmDjnLdzPh5omw7c1nS4g14oh2uYQEZ8z1SEJrizNXvG3AFXoiL0XtKnPZCVMOZv9wS4n9IWq3Mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.24; Tue, 27 Feb
 2024 03:49:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Tue, 27 Feb 2024
 03:49:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "clg@redhat.com"
 <clg@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v5 3/3] virtio-iommu: Change the default granule to the
 host page size
Thread-Topic: [PATCH v5 3/3] virtio-iommu: Change the default granule to the
 host page size
Thread-Index: AQHaaN+jsOvaK244ekCjBLHZS9RAdLEdjfZg
Date: Tue, 27 Feb 2024 03:49:25 +0000
Message-ID: <SJ0PR11MB6744FEC8C98F367699705D9E92592@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240226181337.24148-1-eric.auger@redhat.com>
 <20240226181337.24148-4-eric.auger@redhat.com>
In-Reply-To: <20240226181337.24148-4-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB5087:EE_
x-ms-office365-filtering-correlation-id: 30f6b3bd-e9de-484c-34b5-08dc37471776
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p5JObpJn9I+2VYUfyL4E/mAtGemzOODm9fk+gGzQv3EPxe2+sPR9+JuJEu+qlxNYiLhMJPBOl0CW1Jx8jbETBJAx/08VgKbbg38f/oa4D/TynwXvRfVZxWTqkPmXuUgsRZlQqk7MZ/urX6Fz0ZpZxQQ6zaoFbKoeiYJQp4fML4mgwRUUUx2PwVuFaO+aUprFXZuKznf1l6JW2JFUyZSCzM1mPPuThUBaB1m60tl0srEIvfIurfTdMT0lJR8M2WOBm7ZKMj4UXGOSd1RE/axp2wS2UZBY6FO6tRWFopf2xMYAmP3gYWeff15UR/gwIxF6E77MN3PuU29/j62zQz3Z0vIQdS1SrVv8fe+Hf3Cx8pGTUyYiNKtgHzyrj0csIcA1dKY7xR8x9MrEHPR50ulAuhvRvurh/b4lg3oA1WrYOFFcIru9uG3eprwiBTyWA32uqz08ApWmhDUe5czRWwkFaEsxeZ76lNyiVwZAUcDnrLS1umGGlaNoWWD79I7W/UJP6w/GHdakgj/qsBAVByhkHZHACWbeOhQjZfUbmMpR+eNRyBNEJnDATrNL39tztPCXts90yTkAsel5UM7F6qGSfOEvfGQrHMk75jSLjl7UgnLK3XkwJ2XvqQGHD5PHr82+RMO9UftP/0uBACgxJT9uxzuIYtCtQG6ori3EESF7Ka72LuqgLTX16Z/9FLasttl3Q+nOy3amFwqb/nwu6encjt8bqmQzG5UadsuvkiIgm84=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dFgxN0lBajdUTDdjNTljOG0xWXlQWXY2aFpRbjFsemxvR0gyYUtiYjRkVmdt?=
 =?utf-8?B?NVVMbXhoZGNrZjdYWG9XWFJXTEltZGtnZTk5cytxV1lJQjhtelVYemxKcUpW?=
 =?utf-8?B?dXl0aEFVQkxuYmRiRGozbnFsSmZrRWJRYkR4UHBWbnZDdFhqZlhzWTR1REM1?=
 =?utf-8?B?cFZ6RlRPYTUrL1BaQThWQ3BrZFJjUGlPUXR5bWxteFBSdXJnSFd6WGpuZHEz?=
 =?utf-8?B?RGRRcnFVc1BkczZscERUQjdGcGxvemJNT1Y4K3JhUytERlkxc2dDTVJKZEdC?=
 =?utf-8?B?TUE5SEttTXlQSEVXQ0g4cVVQczQ4ZXdKSlNiSjRxWGdSRmZIU2tsQVFsUGln?=
 =?utf-8?B?SGNleDBtRjEwRXJmTDgvVTZ6STgweCtid21rS3B4T2kxNzZ5alBiNzR2ejlP?=
 =?utf-8?B?RnQ2S0N3Wi9rSjlLLzRnSjdDdjU2R21wMmZuVmhCRXBvaytWN3AzK1RsT0gw?=
 =?utf-8?B?RWdYVlVuTGN6Zm9QUXMwOUtiZnRpOHZVbE40NFBFazhmeDZtTFd1akw5NnF6?=
 =?utf-8?B?YkJvRkg1MWYwNVJvYnQ3WEMyaGd4ekZWbXA5TklJdEx5OHZSOTdyQUVBeUlh?=
 =?utf-8?B?bkR3UUxkY3ZicGo0dFBYcVBVS0NMT3ZFOWVDZEpqRUtrdFBUT3NVREJXZVQz?=
 =?utf-8?B?eUhmQkFVL2lsTDhoT2VNSlFrdXRTN3J6TEdTUUxDUlN1SlNJaVZpWHdVVVlE?=
 =?utf-8?B?NHRWLzczUWprbTlxT2loM3JYK05INUhRU3VSWktJSVEvWTgzam82RzNkWFI4?=
 =?utf-8?B?RVl1YmMrWDQ1Q1M1OWVIbE9UbXZsSExVM29STzRyQk9qYnFDSEhtMW5ENzly?=
 =?utf-8?B?b0VmM3o0MSt3Q2VERGpodkh0RVF6aGUzOXo3S09QcWQzZ1E0UzJxMkljVUNT?=
 =?utf-8?B?OTVyUEk1THVuNG9JWXFqOVgyczhSZmJiZHdkSkZ5ZW5DMVQ2NmJJdHZ3VnVB?=
 =?utf-8?B?NjdjRmg5T3BWWFBEU0tMZ3YxaGhHNnMraXp5blgyUU5RWXQ5TXgzeHNMZmJm?=
 =?utf-8?B?S3dEWjc0RXl1SHIyYUNTRlNreVJxVmJzNldJd0FsZm1hTFMycFhRNVVDNUNN?=
 =?utf-8?B?Z1V2L2g2RlE0OFRJc1U3T1NNcHNMdjB3ekJqMDlJK0NjM3loM3NJOUlLazdS?=
 =?utf-8?B?eEVpRXZVblIrUFVvNHBIYk5HVitockhiaEZncjN6dEdLalM4RXExcTlmU1dY?=
 =?utf-8?B?SmQ5elIvVzhML3J0bFE0RlhjZVU2SWY4dGxFRS8vVzgxWWMvMlFVa1BFSWla?=
 =?utf-8?B?VmtQUElLNTlibTB2SDRTTWhORk15a2lmNG54czJjRGsxWTFlNkc4MWhJMjBO?=
 =?utf-8?B?NFZMVi8xRzhQL0FRNEpPamVaaTdSL3B4bGVFRmp5Z0ZiU2JoUDlzMGg5YWlE?=
 =?utf-8?B?ZWJlRW5NVVVaQU1hZVRxWGgrZWlvYjlEYmZBbFFiSEFzTjFiZlQwcFk3RFBL?=
 =?utf-8?B?MDVyMVhFU01xaTVCQ0JTSVB6Vm1RL1U1amlpSlVad3hpRmpvZ0k0VjFlRFBN?=
 =?utf-8?B?cWRob1VpRmRHOG4wS3Job1YrMnNEZno4ODBVNXBWTldIRDNCYzFzNE53YkpC?=
 =?utf-8?B?TEFvaHBMVUYzaEtRRDRiWlcwalRUK2d6empOdGdwUGFVRzhvZ3ZGMVNGaHVP?=
 =?utf-8?B?cHRWUVpNRHZncGRXaWhwMFJCYWszQTR1MXdoR3lFakJZRlJpZ21vWDhKa25U?=
 =?utf-8?B?NTJSUUYzUzhEVFJuVVNFZkpNUFJXL2ZHK1BycHM4WTJsc0hDdFczRWVKUGJ2?=
 =?utf-8?B?dUhBa3Fzd1AydnlycUpjMVkyTmtyOEtsN2h3b3Z6akk3MkxtZGRTRXZKb2Js?=
 =?utf-8?B?MWFoVmVhUkRTY2MvR1BiNlNXdnBRVHM0MW05TTBYZEdDQjRyemMzN010d0xK?=
 =?utf-8?B?MFVlRlYwWDJJaWJtYm93cVBESW5ua2Fqc0NBNTBaUVJMUnZ0bm5rL0tuSnc5?=
 =?utf-8?B?WXZPVmZCT3JpZDZEcWNmNi9vcGx0bE9QR0pZZGZyZGxBa2hCRzhieUJWdFBs?=
 =?utf-8?B?bUo5UDRlNXN4bGNPWnRwNVo1c25lb0paSVcvekVHQWVURkJLOVY2aWE2ZFph?=
 =?utf-8?B?bHJ0L3hVQ0RBK3JndnpIVGc3clpwK2RML00wVkhseFc4My9Gd0VZTkZyU3JI?=
 =?utf-8?Q?JOZBTs+aHnD62H045byWnxUHM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30f6b3bd-e9de-484c-34b5-08dc37471776
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 03:49:25.5098 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J28NeVqo5N6rytk3AuYdkElqqjM3xaUBH+dXG+R7Euk2XvRQKuskqCv/WsI081DeV0Dz55kUM9n/m1erKiPNLVGoAVR+ktbYXlzEkgDpLB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SCC_BODY_TEXT_LINE=-0.01, T_SPF_HELO_TEMPERROR=0.01,
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
ciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFtQQVRDSCB2NSAzLzNdIHZpcnRp
by1pb21tdTogQ2hhbmdlIHRoZSBkZWZhdWx0IGdyYW51bGUgdG8gdGhlDQo+aG9zdCBwYWdlIHNp
emUNCj4NCj5XZSB1c2VkIHRvIHNldCB0aGUgZGVmYXVsdCBncmFudWxlIHRvIDRLQiBidXQgd2l0
aCBWRklPIGFzc2lnbm1lbnQNCj5pdCBtYWtlcyBtb3JlIHNlbnNlIHRvIHVzZSB0aGUgYWN0dWFs
IGhvc3QgcGFnZSBzaXplLg0KPg0KPkluZGVlZCB3aGVuIGhvdHBsdWdnaW5nIGEgVkZJTyBkZXZp
Y2UgcHJvdGVjdGVkIGJ5IGEgdmlydGlvLWlvbW11DQo+b24gYSA2NGtCLzY0a0IgaG9zdC9ndWVz
dCBjb25maWcsIHdlIGN1cnJlbnQgZ2V0IGEgcWVtdSBjcmFzaDoNCj4NCj4idmZpbzogRE1BIG1h
cHBpbmcgZmFpbGVkLCB1bmFibGUgdG8gY29udGludWUiDQo+DQo+VGhpcyBpcyBkdWUgdG8gdGhl
IGhvdC1hdHRhY2hlZCBWRklPIGRldmljZSBjYWxsaW5nDQo+bWVtb3J5X3JlZ2lvbl9pb21tdV9z
ZXRfcGFnZV9zaXplX21hc2soKSB3aXRoIDY0a0IgZ3JhbnVsZQ0KPndoZXJlYXMgdGhlIHZpcnRp
by1pb21tdSBncmFudWxlIHdhcyBhbHJlYWR5IGZyb3plbiB0byA0S0Igb24NCj5tYWNoaW5lIGlu
aXQgZG9uZS4NCj4NCj5TZXQgdGhlIGdyYW51bGUgcHJvcGVydHkgdG8gImhvc3QiIGFuZCBpbnRy
b2R1Y2UgYSBuZXcgY29tcGF0Lg0KPlRoZSBwYWdlIHNpemUgbWFzayB1c2VkIGJlZm9yZSA5LjAg
d2FzIHFlbXVfdGFyZ2V0X3BhZ2VfbWFzaygpLg0KPlNpbmNlIHRoZSB2aXJ0aW8taW9tbXUgY3Vy
cmVudGx5IG9ubHkgc3VwcG9ydHMgeDg2XzY0IGFuZCBhYXJjaDY0LA0KPnRoaXMgbWF0Y2hlZCBh
IDRLQiBncmFudWxlLg0KPg0KPk5vdGUgdGhhdCB0aGUgbmV3IGRlZmF1bHQgd2lsbCBwcmV2ZW50
IDRrQiBndWVzdCBvbiA2NGtCIGhvc3QNCj5iZWNhdXNlIHRoZSBncmFudWxlIHdpbGwgYmUgc2V0
IHRvIDY0a0Igd2hpY2ggd291bGQgYmUgbGFyZ2VyDQo+dGhhbiB0aGUgZ3Vlc3QgcGFnZSBzaXpl
LiBJbiB0aGF0IHNpdHVhdGlvbiwgdGhlIHZpcnRpby1pb21tdQ0KPmRyaXZlciBmYWlscyBvbiB2
aW9tbXVfZG9tYWluX2ZpbmFsaXNlKCkgd2l0aA0KPiJncmFudWxlIDB4MTAwMDAgbGFyZ2VyIHRo
YW4gc3lzdGVtIHBhZ2Ugc2l6ZSAweDEwMDAiLg0KPg0KPkluIHRoYXQgY2FzZSB0aGUgd29ya2Fy
b3VuZCBpcyB0byByZXF1ZXN0IDRLIGdyYW51bGUuDQo+DQo+VGhlIGN1cnJlbnQgbGltaXRhdGlv
biBvZiBnbG9iYWwgZ3JhbnVsZSBpbiB0aGUgdmlydGlvLWlvbW11DQo+c2hvdWxkIGJlIHJlbW92
ZWQgYW5kIHR1cm5lZCBpbnRvIHBlciBkb21haW4gZ3JhbnVsZS4gQnV0DQo+dW50aWwgd2UgZ2V0
IHRoaXMgdXBncmFkZWQsIHRoaXMgbmV3IGRlZmF1bHQgaXMgcHJvYmFibHkNCj5iZXR0ZXIgYmVj
YXVzZSBJIGRvbid0IHRoaW5rIGFueW9uZSBpcyBjdXJyZW50bHkgaW50ZXJlc3RlZCBpbg0KPnJ1
bm5pbmcgYSA0S0IgcGFnZSBzaXplIGd1ZXN0IHdpdGggdmlydGlvLWlvbW11IG9uIGEgNjRLQiBo
b3N0Lg0KPkhvd2V2ZXIgc3VwcG9ydGluZyA2NGtCIGd1ZXN0IG9uIDY0a0IgaG9zdCB3aXRoIHZp
cnRpby1pb21tdSBhbmQNCj5WRklPIGxvb2tzIGEgbW9yZSBpbXBvcnRhbnQgZmVhdHVyZS4NCj4N
Cj5TaWduZWQtb2ZmLWJ5OiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+UmV2
aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4NCg0K
UmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoN
ClRoYW5rcw0KWmhlbnpob25nDQoNCj4NCj4tLS0NCj4NCj52NCAtPiB2NQ0KPi0gdXNlIGxvdyBj
YXNlLCBtYW5kYXRlZCBieSB0aGUgamFzb24gcWFwaQ0KPi0tLQ0KPiBody9jb3JlL21hY2hpbmUu
YyAgICAgICAgfCAxICsNCj4gaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jIHwgMiArLQ0KPiAyIGZp
bGVzIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1n
aXQgYS9ody9jb3JlL21hY2hpbmUuYyBiL2h3L2NvcmUvbWFjaGluZS5jDQo+aW5kZXggNzBhYzk2
OTU0Yy4uNTZmMzhiNjU3OSAxMDA2NDQNCj4tLS0gYS9ody9jb3JlL21hY2hpbmUuYw0KPisrKyBi
L2h3L2NvcmUvbWFjaGluZS5jDQo+QEAgLTM1LDYgKzM1LDcgQEANCj4NCj4gR2xvYmFsUHJvcGVy
dHkgaHdfY29tcGF0XzhfMltdID0gew0KPiAgICAgeyBUWVBFX1ZJUlRJT19JT01NVV9QQ0ksICJh
dy1iaXRzIiwgIjY0IiB9LA0KPisgICAgeyBUWVBFX1ZJUlRJT19JT01NVV9QQ0ksICJncmFudWxl
IiwgIjRrIiB9LA0KPiB9Ow0KPiBjb25zdCBzaXplX3QgaHdfY29tcGF0XzhfMl9sZW4gPSBHX05f
RUxFTUVOVFMoaHdfY29tcGF0XzhfMik7DQo+DQo+ZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aXJ0
aW8taW9tbXUuYyBiL2h3L3ZpcnRpby92aXJ0aW8taW9tbXUuYw0KPmluZGV4IDMzZTA1MjBiYzgu
LjY4MzE0NDZlMjkgMTAwNjQ0DQo+LS0tIGEvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+Kysr
IGIvaHcvdmlydGlvL3ZpcnRpby1pb21tdS5jDQo+QEAgLTE1NDgsNyArMTU0OCw3IEBAIHN0YXRp
YyBQcm9wZXJ0eSB2aXJ0aW9faW9tbXVfcHJvcGVydGllc1tdID0gew0KPiAgICAgREVGSU5FX1BS
T1BfQk9PTCgiYm9vdC1ieXBhc3MiLCBWaXJ0SU9JT01NVSwgYm9vdF9ieXBhc3MsIHRydWUpLA0K
PiAgICAgREVGSU5FX1BST1BfVUlOVDgoImF3LWJpdHMiLCBWaXJ0SU9JT01NVSwgYXdfYml0cywg
MCksDQo+ICAgICBERUZJTkVfUFJPUF9HUkFOVUxFX01PREUoImdyYW51bGUiLCBWaXJ0SU9JT01N
VSwgZ3JhbnVsZV9tb2RlLA0KPi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEdSQU5VTEVf
TU9ERV80SyksDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgR1JBTlVMRV9NT0RFX0hP
U1QpLA0KPiAgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwNCj4gfTsNCj4NCj4tLQ0KPjIu
NDEuMA0KDQo=

