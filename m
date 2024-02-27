Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F016C48BF6
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 02:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1renPd-0008Fx-OO; Mon, 26 Feb 2024 21:41:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1renPb-0008FW-VI
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 21:41:43 -0500
Received: from mgamail.intel.com ([192.198.163.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1renPY-0004TP-8P
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 21:41:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709001700; x=1740537700;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8W2Djgju/ie5Tty4cQ1JjZchVi3gOIlYyfX6gp4fCJE=;
 b=AXffJZXN23+IvvcPzEgGlqYVpiXDlCJkcfGxhwpwsiu2KcaEwc5OMa3s
 SPGiWKNp9Op0BNiix+3nm6/EC6ihGgB0CCt/mcIDp70E4LGQaT4i/XEQM
 STtWKyioptyNG0Bw6KLvAMXxAU3XqmOYihAOTAQU8Uqie3FewZR6Rgk7i
 zJcD16DTaVXgwU7gI2NV+C2HjxV+Qvn593ZHA67P54YMoGEwgd40ozRWM
 Y2VOmLmPvf+StlRLASZhOsxfLl9IC3oI0f8NAcCXaWIALwvAmXD6vbPqS
 RdLHeLclQFur2HibWMiNZ56HlGj9/YI3EcxDWqijtO+OLQEqqa8VmPe87 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14037683"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="14037683"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 18:41:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="11474249"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 18:41:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 18:41:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 18:41:36 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 18:41:36 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 18:41:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fajc5Cy2eSt7aqhxlYOywxwQTK46xMSRT0D2zyl9igDlnH+Itv8cZZuPNtnFHEaz7HKwtgsOAqYVvuZhsuTTIUjfI8OESyK5ZxlZPSDfbc5qOTVLW4DZuTY7my+B1koUJVbQ7yvjGrucflV+Hee6gaeeilkaQiQSyNPsxODqlazRAKU4RF47dpZoGUxNBCUzUFnW8bMEeSl5CA1qrjQ16C419SgGX1I1OI/tE0Pi/DPwZ/gMe14j678JnSkRXJA3NH1XbOz0asPgHO8io6ypfiQznGUZA30miU0+HSc45vwwMUX+6Zn8QaKUQcYAXf9Fd72Bxz+E4kvwnC0VkY+WBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8W2Djgju/ie5Tty4cQ1JjZchVi3gOIlYyfX6gp4fCJE=;
 b=UhgXLSoPMPFWko6DhoohLbLqyiXA6iWTtPSdfwMHMNkxHO9sp0SjoVBrDVwzrmcX/uEUtLqMCRYMWWzFl2qRxXUadOuY+JstYKJoyZ9tdRfghs63dO7b/NImt+Et18Ok4bmWY8I6GMfU8Yt4lggYlcYjX7834svpwCs1YyXgBzyvVvlDfu57uknIruEYzZY97EqBOLbByJcKJZx9nAe3RXjzDeWXk7EPu72r3/adB+SFyWeLI+/+PRP9QIufmYfMP2hpPaK/N1ZKzGtHDdomfFqn7KZY8rseN1QvQ0JHvVoS3CuFvjN/LJOGZfllzTbCpCachsksFQmJtITUYlFlXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 02:41:33 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Tue, 27 Feb 2024
 02:41:33 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, "Richard
 Henderson" <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: RE: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is updated
Thread-Topic: [PATCH rfcv2 18/18] intel_iommu: Block migration if cap is
 updated
Thread-Index: AQHaVOC9sC8O2ye14U6f5euIaQuiIrEILJaAgBV15iA=
Date: Tue, 27 Feb 2024 02:41:33 +0000
Message-ID: <SJ0PR11MB6744BF58C9C21D5778A2D15792592@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240201072818.327930-1-zhenzhong.duan@intel.com>
 <20240201072818.327930-19-zhenzhong.duan@intel.com>
 <72642921-98d4-4c4f-8117-868d2ae29eb0@oracle.com>
In-Reply-To: <72642921-98d4-4c4f-8117-868d2ae29eb0@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB4984:EE_
x-ms-office365-filtering-correlation-id: 3fc0f57c-8dc3-4eac-8d6e-08dc373d9c65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qOpnYwIxZftbDcpYx4vF3rGx3uItGfLUKt9hh48qh8PyrrSBwrYO+vcYCESAdZfHbH1mtVjqlY99EXJfiCUmXd7mVTLDHJijMMMd6BKQPDDiMV3ilugKbaNhttbJLuoqZREQvp/dftiG5b2SF21O02VFNV5w489sTz+5WCyAXRYoOBRE4lFBic3jbKxtRXI3vNFfkUipbRmXWM4IIXJO/tBvlfI8YYfVIe0TgvqnpsFqiYZ/u728nvVOGyomJ/LlhrRuFoTv7BiTWFwlW4R4DdZnuWU5Br60bglAGodSUyaExskBSn9F1Nng60yChHniX4INnjYzPIGylTPv/CfvtdSiCg8Ua2Lqz78+YePn6bWMT034dgjuhrZ7RwmFXRbwnwjSKkpNHdYh5Z2US8a5o1UnLYWhjsqobyEKGcXcacTVASWHTeNwMXQQak3BupOQbBMVe4j9oiGXTbkq2tT4sDa2vKtDQZh/JSQlisSqIMsJLTqyZM+/hVXkBD18z35F5rHENsNARvebsrjhwkpJHi+tdKPBlFOui6sewQVAhhZx1JbFMnAnTDbMs09JdH2RHg8APDjGk9XX0A6p7EK3be+MIgZYRQ+EqKD5MndJxaDadcESc8EgMCh1Gn8a7GUpzYVKv3tazWrwhk/IBmPnJ9zcIWnmsbJx9gDKcdxVxQEEY/K0AB5LF960NywScDDDk0VafPrzy5VtXVP1KaRl6A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlhCYUJqRjl0YStjeG5manBUeVlEK3RtcWd4M3lWcHRIbGhDbW9FeGJrOCty?=
 =?utf-8?B?MzZiVGFCbmtWMzNVbUhzL0M3OCtIMTYralc3N2Z5dFY5NEY2ZTFPQTRXZG9s?=
 =?utf-8?B?dnpTZVRhZFpEZHAzQkJ5OUdZZzUyaEtqRTNuYm9SRncva1ZqOGJwcERYcFFF?=
 =?utf-8?B?d1BrcndBaWJraklPaUtqMFRwazQrRGpibE5VUGZxVGFwd1RtdklxSXlMT1M5?=
 =?utf-8?B?c0N0Wk9QUU9DS1JzRWZINHpwZkNYM0RIYk9CMkpDYk5kYmR6SzhrQ1NjanZZ?=
 =?utf-8?B?enlEb3pCNFphUm9FRG1WTC9ic2t0MEpOZ1ZaRXVrSHYrRndHakhMZFJGZWxk?=
 =?utf-8?B?cUFZSzJlNENXUXJjZnFBOUF6Q0h6V05ac1ZKajQvR1VXTXk3allpMG93MGFn?=
 =?utf-8?B?cW9MbmxYNFJYcFJGOG1USTlBYVdENWR5Vk1kdEZrYXptQll3Rjk4ajJkZVNo?=
 =?utf-8?B?TXdmK3IyeXptVE5xYTFZUXd0N2c5OXVpRG8rMnR1L01HY0N3RFFGeFVLK0xD?=
 =?utf-8?B?NHk5NUFHek9EaUp3cHV5cm1KY3A0ODBpMkpyRXdFVGM3N3d3MTliZDM5dDZj?=
 =?utf-8?B?amRGNzlmRnd0NUc5c1JSTlNSc0hYS3Bla2czNlZjUG9GQ3d1Ny9maWcvdmlK?=
 =?utf-8?B?ZFFTY3NSYjhnVTZST2crMXd3c29zMnBqd2FZU3ptRG9nYWxXa0s3Q3Y3ZFFw?=
 =?utf-8?B?Y21hM2hOY3YyeWpESmZ4WG1mUHVJZytwbkpPQjZrVkVtYyt4bWdlbXZLeGVm?=
 =?utf-8?B?V2hGc1NxMDRJbE04cjZyWDVyTi90WSs5YjZlSVdCWmYzOUgvRmdNMTZhV1Bk?=
 =?utf-8?B?b2p2djZmdjNOV0dsemNPWVA3QUtKQXpMZzI1NFV2RDFqNVppUmtxTkJlRUxR?=
 =?utf-8?B?ZXFYbXFsbU51SjFrL2Q4K05nR3QrQWRpUkVWaFo4WktwSzRVRVAzYjlldFYv?=
 =?utf-8?B?QmhVT3RxSCszVWZFeXZxNWdRWU5TbTlVdWozSkg0SUw2eDNKalJWUUhPdkR1?=
 =?utf-8?B?Z0ZKbExDbGV2MlY0Mk1GQmx1MWVoMjVSR3RtdXRMNWxudUJqSjNqUkNxaUxh?=
 =?utf-8?B?SjNkV3d0clpJN2J4bHVKZE5LRXFtUTBwNHZzNVdISVVZUkFWTXE2S3VWRm5t?=
 =?utf-8?B?OE9BcEI0ZEpMQk5RaUxwajZDUHJWbVpVdmVWckVoREdtRWtHTDgwcW1DcWhw?=
 =?utf-8?B?djNiZVpuMHdBSHhUQmMvRjBQaGkySVZwRy9ZTEYzclFqSjB4bXNlNVR3N1ZF?=
 =?utf-8?B?c0szejJNK3dQcERhZy9GRVhtNytKY3FYbzFUZGF4eER6c2Vrd3RUb0VrV0Zx?=
 =?utf-8?B?bVhmVXJlK1dCOGhiaXBhZDQvSG9LbGVOMXBud1BwUFh5SE5LMDQzbmNQcmQ1?=
 =?utf-8?B?NzErbjNDcGZTcURETTQ1MGtWaG9Bd25FSlB4U0lYNWVlMFJLVkt0UFFaVEI2?=
 =?utf-8?B?cmVhRHlYVitBZ0gyekxxOHN4VjlpUWNIWHQrUWFpYjBFMXA0c1o5V2lFNlhE?=
 =?utf-8?B?MUJjVEJqS3BxWXVzVWZoTEs2b0JxU2JhUm1oRHdBdnBpaDAybURUSXA3L3Z1?=
 =?utf-8?B?UHRtWDBNMXNkaGtweWtMSmFVeXp3MS95OWQ4UXF5b25nTjdwaDQwU2xwQUFw?=
 =?utf-8?B?K1M2bzV0K2xsa3BSb3I4TVZZVHFCOXo5NXdlcmRta3lzK0pWcjdYeTdkU2Rq?=
 =?utf-8?B?T1pocGNjOGU5TmRQQ3pWMm53ckhkdWVWUDJ5bHhkeDJaOS9DSEhvUXVZMXMr?=
 =?utf-8?B?M3Fsakp4UFNadEJ0elZtSitwTXJkUVFYZ2pXU1pBMmg5TmZUWFphWHY1eXo4?=
 =?utf-8?B?dzZJZUZ1UHE4UzZVcjhjMXpBNnRWSTlvNTJrVkoreGRteG9EcWlhaWNyY1Bk?=
 =?utf-8?B?V1RUcTloejVDL0phRXp2bkFRNlZLQ2doZ09PUzhxSHpwcHRnTjF0cktNYjVq?=
 =?utf-8?B?TzBVaVlXSlM4Z1NaaUhyK3pDeThEVTU5MTJQendHTEM1dzl1VmNiTWxkSG45?=
 =?utf-8?B?dFBJOHVYdkJPa2FxUHFBQ2tmQjB4NC9WRnBJRzZnbFR3NkprWDdBRTVVYlF6?=
 =?utf-8?B?SWxrRVVmVnlTcHYzdk42eGhGU0dvdkNBYjhwYXFKd3RsMmE0QlNWblg5Um9i?=
 =?utf-8?Q?ttgVuaOM2VSQtmmFaFVYjMNbC?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc0f57c-8dc3-4eac-8d6e-08dc373d9c65
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 02:41:33.5757 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qOleV3leZH3/R9/83XnjnN6/LAAKeZBKQ2+U93DBB0nHYn1eom/vu03UYOKQ0jFLiIYONs8+kAjWcoQvZiCW3I7VottIrbzorUJYfEvRi78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHJmY3YyIDE4LzE4
XSBpbnRlbF9pb21tdTogQmxvY2sgbWlncmF0aW9uIGlmIGNhcCBpcw0KPnVwZGF0ZWQNCj4NCj5P
biAwMS8wMi8yMDI0IDA3OjI4LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+IFdoZW4gdGhlcmUg
aXMgVkZJTyBkZXZpY2UgYW5kIHZJT01NVSBjYXAvZWNhcCBpcyB1cGRhdGVkIGJhc2VkIG9uDQo+
aG9zdA0KPj4gSU9NTVUgY2FwL2VjYXAsIG1pZ3JhdGlvbiBzaG91bGQgYmUgYmxvY2tlZC4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPg0KPklzIHRoaXMgcmVhbGx5IG5lZWRlZCBjb25zaWRlcmluZyBtaWdyYXRpb24gd2l0
aCB2SU9NTVUgaXMgYWxyZWFkeSBibG9ja2VkDQo+YW55d2F5cz8NCg0KVkZJTyBkZXZpY2UgY2Fu
IGJlIGhvdCB1bnBsdWdnZWQsIHRoZW4gYmxvY2tlciBkdWUgdG8gdklPTU1VIGlzIHJlbW92ZWQs
DQpidXQgd2Ugc3RpbGwgbmVlZCBhIGJsb2NrZXIgZm9yIGNhcC9lY2FwIHVwZGF0ZS4NCg0KVGhh
bmtzDQpaaGVuemhvbmcNCg0KPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwg
MTYgKysrKysrKysrKysrKystLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11
LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+IGluZGV4IDcyY2M4YjJjNzEuLjdmOWZmNjUz
YjIgMTAwNjQ0DQo+PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPj4gQEAgLTM5LDYgKzM5LDcgQEANCj4+ICAjaW5jbHVkZSAiaHcv
aTM4Ni9hcGljX2ludGVybmFsLmgiDQo+PiAgI2luY2x1ZGUgImt2bS9rdm1faTM4Ni5oIg0KPj4g
ICNpbmNsdWRlICJtaWdyYXRpb24vdm1zdGF0ZS5oIg0KPj4gKyNpbmNsdWRlICJtaWdyYXRpb24v
YmxvY2tlci5oIg0KPj4gICNpbmNsdWRlICJ0cmFjZS5oIg0KPj4NCj4+ICAjZGVmaW5lIFNfQVdf
QklUUyAoVlREX01HQVdfRlJPTV9DQVAocy0+Y2FwKSArIDEpDQo+PiBAQCAtMzgyOSw2ICszODMw
LDggQEAgc3RhdGljIGludA0KPnZ0ZF9jaGVja19sZWdhY3lfaGRldihJbnRlbElPTU1VU3RhdGUg
KnMsDQo+PiAgICAgIHJldHVybiAwOw0KPj4gIH0NCj4+DQo+PiArc3RhdGljIEVycm9yICp2dGRf
bWlnX2Jsb2NrZXI7DQo+PiArDQo+PiAgc3RhdGljIGludCB2dGRfY2hlY2tfaW9tbXVmZF9oZGV2
KEludGVsSU9NTVVTdGF0ZSAqcywNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgSU9NTVVGRERldmljZSAqaWRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgRXJyb3IgKiplcnJwKQ0KPj4gQEAgLTM4NjAsOCArMzg2MywxNyBAQCBzdGF0aWMgaW50
DQo+dnRkX2NoZWNrX2lvbW11ZmRfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsDQo+PiAgICAgICAg
ICB0bXBfY2FwIHw9IFZURF9DQVBfTUdBVyhob3N0X21nYXcgKyAxKTsNCj4+ICAgICAgfQ0KPj4N
Cj4+IC0gICAgcy0+Y2FwID0gdG1wX2NhcDsNCj4+IC0gICAgcmV0dXJuIDA7DQo+PiArICAgIGlm
IChzLT5jYXAgIT0gdG1wX2NhcCkgew0KPj4gKyAgICAgICAgaWYgKHZ0ZF9taWdfYmxvY2tlciA9
PSBOVUxMKSB7DQo+PiArICAgICAgICAgICAgZXJyb3Jfc2V0ZygmdnRkX21pZ19ibG9ja2VyLA0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgImNhcC9lY2FwIHVwZGF0ZSBmcm9tIGhvc3QgSU9N
TVUgYmxvY2sgbWlncmF0aW9uIik7DQo+PiArICAgICAgICAgICAgcmV0ID0gbWlncmF0ZV9hZGRf
YmxvY2tlcigmdnRkX21pZ19ibG9ja2VyLCBlcnJwKTsNCj4+ICsgICAgICAgIH0NCj4+ICsgICAg
ICAgIGlmICghcmV0KSB7DQo+PiArICAgICAgICAgICAgcy0+Y2FwID0gdG1wX2NhcDsNCj4+ICsg
ICAgICAgIH0NCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gcmV0Ow0KPj4gIH0NCj4+DQo+PiAg
c3RhdGljIGludCB2dGRfY2hlY2tfaGRldihJbnRlbElPTU1VU3RhdGUgKnMsIFZUREhvc3RJT01N
VURldmljZQ0KPip2dGRfaGRldiwNCg0K

