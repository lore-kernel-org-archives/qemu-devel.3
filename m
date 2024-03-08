Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C18A3C54798
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Mar 2024 03:05:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riQXk-0006wJ-NR; Thu, 07 Mar 2024 22:05:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1riQXd-0006w3-7b; Thu, 07 Mar 2024 22:05:02 -0500
Received: from mgamail.intel.com ([192.198.163.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1riQXX-0007Jh-5N; Thu, 07 Mar 2024 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709867095; x=1741403095;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MDTuZPmVWysIEgkvXrNjy9X93qS4vYf9edW6lXwuS24=;
 b=GIjrzOPYgan8J0PWnjmjdKHwizcNjeupQeeYmbHD3gwjRd2yUGBWoCVC
 ou3MWwvJ3X6coNoOOdleRTXX6YHzjzQ6bp1ASZ003yvY53kvXgCgxwHtc
 HMY/GTehDr0YCrrqajh7Mlp7C8l+o9yVov/zkn8h0xIordnHDIjgi30KV
 340F/JgX3bqbzqKnNWg7yEu9YmiKuKCa5TeisVHGN8HOTx1ES16ZBbKQO
 BmLBLGEcv/lIGoifr1VnqJ2GoNgYCrBYLihcqTHBPFP2cfXm6u1xFY99c
 20PSohLlAkeEWsJJVsqfCcaJYxXslyRsr+MnP+Z/tTWQE1aHUj7VV/ARV Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="7519823"
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; 
   d="scan'208";a="7519823"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Mar 2024 19:04:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,108,1708416000"; d="scan'208";a="10735658"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Mar 2024 19:04:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Mar 2024 19:04:48 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Mar 2024 19:04:48 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 19:04:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MzTblF+nwM0fk9EQIkZmGxcchUiRaSStRWAb0qbnuWv7+FnJENu6l/6rYvaQi3irDoKf+cdSuDs5JujIYC56aDsAVz7FojSOn5mOSJ/QE2XKdqqfnft+VV1zaMpgg7rYC5h+csLpu6jCUN0Cg6xEqXkP9CJqAorTVyMx2++JBUZsuzlXeDNOAdxplh2xc1oqwy+ThL9+7AEJ1wdQ3AhPy9WI2oduvz9Yfb8be2zeKSRay8l/Eril1T4ixah0ciskxXNKkaHBQL5zV43j9aRg06/gxQjy/LLnGO5+t3uo6tGzqBtVQGnH5lhhK3OY6StZCsywtDMxDqBGaRHzoDwpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDTuZPmVWysIEgkvXrNjy9X93qS4vYf9edW6lXwuS24=;
 b=F+7GeafMpTZRsmwKnHfoz34k/PHqj3/Q4mYTDlBAqtBzPhmpmU+rqt6jTtEwnX8hjO08+doEXUpU3xCiu3jEwpj/GO2wK1zFXwWQbjzhafzCmyTtxNxPUD0DwBSYCbZwwhYjuj9jdNdrrD7gr/DP+r8mrX4JV894MUCvyGUJqRASTRfuo6cdub0Gj+ntFmBDiP+6jIoebBrTgLnB1sJOkCJXBe0pzTBftPqqwbS8Dcnfk06h3sJaNbkASlrL8sxjHUQQ5JHVWPwdSSeawXKsxkkUipG4JBJA7G1Gcg9H3s6bYVP14VCtAzzncbyeJe5dbS8a27DVYjjnrMwoXe4PUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8719.namprd11.prod.outlook.com (2603:10b6:8:1a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.6; Fri, 8 Mar
 2024 03:04:45 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 03:04:44 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Eric Auger <eric.auger@redhat.com>, "eric.auger.pro@gmail.com"
 <eric.auger.pro@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
 "yanghliu@redhat.com" <yanghliu@redhat.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "berrange@redhat.com" <berrange@redhat.com>
Subject: RE: [PATCH v8 7/9] hw/i386/q35: Set virtio-iommu aw-bits default
 value to 39
Thread-Topic: [PATCH v8 7/9] hw/i386/q35: Set virtio-iommu aw-bits default
 value to 39
Thread-Index: AQHacJXCMWDf5EOUiE2bW5vIfqE69rEtKQcQ
Date: Fri, 8 Mar 2024 03:04:44 +0000
Message-ID: <SJ0PR11MB6744AB3B14C952265210297F92272@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240307134445.92296-1-eric.auger@redhat.com>
 <20240307134445.92296-8-eric.auger@redhat.com>
In-Reply-To: <20240307134445.92296-8-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8719:EE_
x-ms-office365-filtering-correlation-id: f5b841dc-d3e7-4e85-9add-08dc3f1c81cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mkjqKcZpPGQJi+zLFMm2jA2D+1KgzKt7gwV7k6si8iAd7Bhi9iabXeccwz3J5ZguLfIaifTSrlnGZLtlVHAQAtKxs289gFc9vnyOjWc29F7O9CTOb9mf5YUn7BUgTMZ0B49MRICPZFr41rP/bozmvAVcpK3ezW+8TZY8le+QqtdkI3tl8cGSbtVYAWTCHsof2mPFrVYieNe7eNzsSG9dWVU7WyXo3AcukloEnGew6jQcf7fPbphN71JSkzIp7qegwqkaKNCn5gIUPGNqJhVSwuO0hjxKB3LcFjxch1n0TLDsbjeeGZt69l2TgxvcU9fFEld+zlBplgIPPaJjipyO9ylwZkdkNwl0Cteq2J7fCqyZT0fgnfX9Yq+lFCW3DzPJDPWvYwgfdlN6tD/CBjjxsVc0caMskBS3KPedRq+WUlCQMzUS7nzr3mQIcslvTA+UbMxrr64tFkUF4sTjWzLy8u0Dv/SdW0LJSl+8ByG4oeNMbeBTXUpaRPSWSD4/tmx795S/hWU/EARHI4mlhfi8j/oG5UlgOQQH+iDNOhuSPrHCKfWV3S+vuq8yr2U9tZPSCnEBW1iYdMJaZz5p7eR5mFlhtBBb6v9NqeW9ymzWxzxLEgZHuQe7tivKzWu1+yIpO9PMBd4ixongCisXbybeJr+8YoluS1va4kv5LOkntgYQYSlGzGkTQyWRRhaCk+GxkBcHPvy5nmF6mnytbOa5mD43WI3DT7RxoxUvB7vhv3E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(921011)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ck0zZDRFc2tBdDJJMmkzQXArSmN6c0dZMk5LdjJPSk9rOFUvMWFNdGxjT20z?=
 =?utf-8?B?bUdDQ3pZazF2QWtOaThURWV3SWR4NlFSWVRsNWVybzhZSjh3ejcycVRlSFBO?=
 =?utf-8?B?N0dHeHR0SnZFaWpTZHplTHB3V1hOc3BVOTI5WWRYQ0o4ZGFvS1N2aUQ5NkhH?=
 =?utf-8?B?VHIzbytJVHcyUldQbDlXUnkvdjl5L1lQcWE4RUtJT3FxM3dMbXQ5RGpaWG9M?=
 =?utf-8?B?QSt2VHJRMjBRZXRzNHF2NmVEdTA5aWtkV2xKZXQzeWhveFZuRHJFU0syalFo?=
 =?utf-8?B?bmV1RWNuaHZLMStnNGlMRUlkZGQxM2kySjNuV3NCTGZtcFhkaThXVDNINmh2?=
 =?utf-8?B?d1lDeEw1d1JiSXUwWGlzY1BQZ09iZTdBK01zWDdGV1YxUWlIQU1qNlZOazBu?=
 =?utf-8?B?bnNHbDRhYXMvRHhpL3JBNGNoODFoQVZ3Mmg1NEZPT3U5ZXN3VmsyNEN3ODBY?=
 =?utf-8?B?K1o1SnI4UjdWdnZ3NnRYSWU3UDlIT2JqbkdlKzhDRFJPWkphVVdhMUZ3VTNQ?=
 =?utf-8?B?QU9yNmQwWlJwSkFuazlxa04wemVTRzBEemhyejZHNTFPbXU1a1pGK01Sc2w5?=
 =?utf-8?B?R2tyZ1crOTA5L3E5dlRUN1RFSHZ4eDd6b3MwRlJxZ0FwWUt3Q01sc0JtV3ZT?=
 =?utf-8?B?Y1ZHdzVBeENYRU44VUhvY1dZdzY5OTk3c0ZweXBNWUp3NStVb25UaEhqR2Vi?=
 =?utf-8?B?TjZ4SFd3dmVXSkRCeTVBMGJhNUR1RE5aR2NwbWdCUGdtUDNRVE5XSmtKTEFU?=
 =?utf-8?B?QUVneWFrODhOU21iYjNxQVZ0ZkNlcTFtb1lDRjNDd2NXNkE2b2RQaklINkdz?=
 =?utf-8?B?d2pXQzlSTWRJWm94MlpRY1VwT0phNU1neEREdnFFTFhkZ21IdHFKYXBRTDI2?=
 =?utf-8?B?aVhoTXR5OWZ2WkQ5S1BSd09NclZ0Q2M0M2IwTHNzTEJQQ0pNWnRVR0Y2bno0?=
 =?utf-8?B?NDZTNCtmTUVyNjE0VUNEOUJUZXpVNGxEY29YOHA1VVhBNTFabUd0bU8wakRa?=
 =?utf-8?B?RFJLU3FwTm5WeVpuYlovN1NMY0ltVi94T2dHWXlOcnI1K0p6bnYwcm90angy?=
 =?utf-8?B?MTBwVlk0dUxmNWZFUHpuRndDWGoyMnJObW5qR1BWcUNnWDFTRUdSeUtqSm14?=
 =?utf-8?B?VUZNNkk2M3QrTnBnaWNIV2F1RlpnSVJWM2hZdnBBNDBPRXhhSmtqQzFaZHNo?=
 =?utf-8?B?T25uUUFrL3VjWWRzYVRURysyQnFyYWZoTnltSzZiYTNFZ2JZR2I2VlB5Rml4?=
 =?utf-8?B?VEdqY2lNUytpcGxOZ0ppZ28zKzF6cTA5QlhCNE91OG9sTVpJK3ZvVkNyeVRr?=
 =?utf-8?B?dDkxMXBqNVhPQzNTKzJNVXRuMk9RS290T1VlVXBDaUVLVGpHbmw2Q3FrQ2ZW?=
 =?utf-8?B?VjVYY2orbnpHbWN1TWMzMFQxa1BJTWVucnBoRXo5OGhtU0M2eDVqOEtscmtr?=
 =?utf-8?B?MG5wMnd5U2xWeko5MGpBeGtQajVHT2NuMkVJVmlPZ042aXZJZDFzenBOUGJt?=
 =?utf-8?B?dHF3RmhQOXBCOVRrQm5QNWZYcnB0ZDVUUlhhcWl4SGFiSDFTNEg4MFFUT1M0?=
 =?utf-8?B?emVDVG9pbVVLbWhTTmVreDQ1bTRtSU8vRVRoZFEva1dXVXphUTJTa0p2S0c2?=
 =?utf-8?B?VjNjV0w3YzJqU2xSS1FlM00xU0x4YUVIaE1sTHFZOExaNVd0Y0Rma21qQVZa?=
 =?utf-8?B?YTl0YUc2M0xpMkxScnN3a0l1bmNIODM4YjRydEZoRnMvZDEyUkRQOTBFeFpq?=
 =?utf-8?B?cFpOb1pMMGtKSTRnT2dIUFp4SXBoWnVjWmtsVXQ4a0cxZkNLV2Q5dnE3c2Ro?=
 =?utf-8?B?ODUzRS9mWnM0alphclFEeUJySHV4d2NKem9WRFhyd0xNQ3A3T0h1RDE0RUd0?=
 =?utf-8?B?WjN5MEs4QXF2M0xzTUJLVW9McEpaWHBaU0l3Uy9LellmSmRRRFdUNmVEeFE4?=
 =?utf-8?B?K25vdFRPcm5yVkp5Q0pIdUdrZnIxbUQxTmVEb3hCdjYxdU1RNEZRTGRYTzVm?=
 =?utf-8?B?SkZJbTdnVHlaSzlYMi9MdWYyNS9JTTd3OXNDQjc2bXJ3UGh1NGM5d09aemJw?=
 =?utf-8?B?Q1NHMGh6bzJHZmJwd2g2YmZ1Q1FRU3IwNlpqaDZxOUZsSm82d0RCOU5Lc05a?=
 =?utf-8?Q?tTUvfTtrs6UNwlmGKHlshRJ4y?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5b841dc-d3e7-4e85-9add-08dc3f1c81cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 03:04:44.8682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hXLF2qa2yLHXmpT7rGkD483S387SwDlCTTpqWnkRRfYbdSsc/K5Xu7B1rmzGKdBwG9lhFPYk9tnGfkkLNgqk62LuSnwW3ESt1NlL8csmaBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8719
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.583,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjggNy85XSBody9pMzg2L3EzNTog
U2V0IHZpcnRpby1pb21tdSBhdy1iaXRzIGRlZmF1bHQNCj52YWx1ZSB0byAzOQ0KPg0KPkN1cnJl
bnRseSB0aGUgZGVmYXVsdCBpbnB1dCByYW5nZSBjYW4gZXh0ZW5kIHRvIDY0IGJpdHMuIE9uIHg4
NiwNCj53aGVuIHRoZSB2aXJ0aW8taW9tbXUgcHJvdGVjdHMgdmZpbyBkZXZpY2VzLCB0aGUgcGh5
c2ljYWwgaW9tbXUNCj5tYXkgc3VwcG9ydCBvbmx5IDM5IGJpdHMuIExldCdzIHNldCB0aGUgZGVm
YXVsdCB0byAzOSwgYXMgZG9uZQ0KPmZvciB0aGUgaW50ZWwtaW9tbXUuDQo+DQo+V2UgdXNlIGh3
X2NvbXBhdF84XzIgdG8gaGFuZGxlIHRoZSBjb21wYXRpYmlsaXR5IGZvciBtYWNoaW5lcw0KPmJl
Zm9yZSA5LjAgd2hpY2ggdXNlZCB0byBoYXZlIGEgdmlydGlvLWlvbW11IGRlZmF1bHQgaW5wdXQg
cmFuZ2UNCj5vZiA2NCBiaXRzLg0KPg0KPk9mIGNvdXJzZSBpZiBhdy1iaXRzIGlzIHNldCBmcm9t
IHRoZSBjb21tYW5kIGxpbmUsIHRoZSBkZWZhdWx0DQo+aXMgb3ZlcnJpZGVuLg0KPg0KPlNpZ25l
ZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCg0KUmV2aWV3ZWQt
Ynk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQoNClRoYW5rcw0K
Wmhlbnpob25nDQoNCj4NCj4tLS0NCj4NCj52NiAtPiB2NzoNCj4tIHVzZSBzdGF0aWMgcGNfcTM1
X2NvbXBhdF9kZWZhdWx0cw0KPi0gcmVtb3ZlIHNwdXJpb3VzIGhlYWRlciBhZGRpdGlvbg0KPi0g
cy8zMi9VSU5UMzJfTUFYIGluIHRoZSBxdGVzdA0KPg0KPnY1IC0+IHY2Og0KPi0gc3BsaXQgcGMv
YXJtIHNldHRpbmdzDQo+DQo+djMgLT4gdjQ6DQo+LSB1cGRhdGUgdGhlIHFvcyB0ZXN0IHRvIHJl
bGF4IHRoZSBjaGVjayBvbiB0aGUgbWF4IGlucHV0IElPVkENCj4NCj52MiAtPiB2MzoNCj4tIGNv
bGxlY3RlZCBaaGVuemhvbmcncyBSLWINCj4tIHVzZSAmZXJyb3JfYWJvcnQgaW5zdGVhZCBvZiBO
VUxMIGVycm9yIGhhbmRsZQ0KPiAgb24gb2JqZWN0X3Byb3BlcnR5X2dldF91aW50KCkgY2FsbCAo
Q8OpZHJpYykNCj4tIHVzZSBWVERfSE9TVF9BV18zOUJJVCAoQ8OpZHJpYykNCj4NCj52MSAtPiB2
MjoNCj4tIHNldCBhdy1iaXRzIHRvIDQ4YiBvbiBBUk0NCj4tIHVzZSBod19jb21wYXRfOF8yIHRv
IGhhbmRsZSB0aGUgY29tcGF0IGZvciBvbGRlciBtYWNoaW5lcw0KPiAgd2hpY2ggdXNlZCA2NGIg
YXMgYSBkZWZhdWx0DQo+LS0tDQo+IGh3L2NvcmUvbWFjaGluZS5jICAgICAgICAgICAgICAgfCAx
ICsNCj4gaHcvaTM4Ni9wY19xMzUuYyAgICAgICAgICAgICAgICB8IDkgKysrKysrKysrDQo+IHRl
c3RzL3F0ZXN0L3ZpcnRpby1pb21tdS10ZXN0LmMgfCAyICstDQo+IDMgZmlsZXMgY2hhbmdlZCwg
MTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPg0KPmRpZmYgLS1naXQgYS9ody9jb3Jl
L21hY2hpbmUuYyBiL2h3L2NvcmUvbWFjaGluZS5jDQo+aW5kZXggNmJkMDlkNDU5Mi4uNGI4OTE3
MmQxYyAxMDA2NDQNCj4tLS0gYS9ody9jb3JlL21hY2hpbmUuYw0KPisrKyBiL2h3L2NvcmUvbWFj
aGluZS5jDQo+QEAgLTM1LDYgKzM1LDcgQEANCj4NCj4gR2xvYmFsUHJvcGVydHkgaHdfY29tcGF0
XzhfMltdID0gew0KPiAgICAgeyBUWVBFX1ZJUlRJT19JT01NVV9QQ0ksICJncmFudWxlIiwgIjRr
IiB9LA0KPisgICAgeyBUWVBFX1ZJUlRJT19JT01NVV9QQ0ksICJhdy1iaXRzIiwgIjY0IiB9LA0K
PiB9Ow0KPiBjb25zdCBzaXplX3QgaHdfY29tcGF0XzhfMl9sZW4gPSBHX05fRUxFTUVOVFMoaHdf
Y29tcGF0XzhfMik7DQo+DQo+ZGlmZiAtLWdpdCBhL2h3L2kzODYvcGNfcTM1LmMgYi9ody9pMzg2
L3BjX3EzNS5jDQo+aW5kZXggNDVhNDEwMmU3NS4uMWU3NDY0ZDM5YSAxMDA2NDQNCj4tLS0gYS9o
dy9pMzg2L3BjX3EzNS5jDQo+KysrIGIvaHcvaTM4Ni9wY19xMzUuYw0KPkBAIC00NSw2ICs0NSw3
IEBADQo+ICNpbmNsdWRlICJody9pMzg2L3BjLmgiDQo+ICNpbmNsdWRlICJody9pMzg2L2FtZF9p
b21tdS5oIg0KPiAjaW5jbHVkZSAiaHcvaTM4Ni9pbnRlbF9pb21tdS5oIg0KPisjaW5jbHVkZSAi
aHcvdmlydGlvL3ZpcnRpby1pb21tdS5oIg0KPiAjaW5jbHVkZSAiaHcvZGlzcGxheS9yYW1mYi5o
Ig0KPiAjaW5jbHVkZSAiaHcvaWRlL3BjaS5oIg0KPiAjaW5jbHVkZSAiaHcvaWRlL2FoY2ktcGNp
LmgiDQo+QEAgLTYzLDYgKzY0LDEyIEBADQo+IC8qIElDSDkgQUhDSSBoYXMgNiBwb3J0cyAqLw0K
PiAjZGVmaW5lIE1BWF9TQVRBX1BPUlRTICAgICA2DQo+DQo+K3N0YXRpYyBHbG9iYWxQcm9wZXJ0
eSBwY19xMzVfY29tcGF0X2RlZmF1bHRzW10gPSB7DQo+KyAgICB7IFRZUEVfVklSVElPX0lPTU1V
X1BDSSwgImF3LWJpdHMiLCAiMzkiIH0sDQo+K307DQo+K3N0YXRpYyBjb25zdCBzaXplX3QgcGNf
cTM1X2NvbXBhdF9kZWZhdWx0c19sZW4gPQ0KPisgICAgR19OX0VMRU1FTlRTKHBjX3EzNV9jb21w
YXRfZGVmYXVsdHMpOw0KPisNCj4gc3RydWN0IGVoY2lfY29tcGFuaW9ucyB7DQo+ICAgICBjb25z
dCBjaGFyICpuYW1lOw0KPiAgICAgaW50IGZ1bmM7DQo+QEAgLTM1Niw2ICszNjMsOCBAQCBzdGF0
aWMgdm9pZCBwY19xMzVfbWFjaGluZV9vcHRpb25zKE1hY2hpbmVDbGFzcw0KPiptKQ0KPiAgICAg
bWFjaGluZV9jbGFzc19hbGxvd19keW5hbWljX3N5c2J1c19kZXYobSwNCj5UWVBFX0lOVEVMX0lP
TU1VX0RFVklDRSk7DQo+ICAgICBtYWNoaW5lX2NsYXNzX2FsbG93X2R5bmFtaWNfc3lzYnVzX2Rl
dihtLCBUWVBFX1JBTUZCX0RFVklDRSk7DQo+ICAgICBtYWNoaW5lX2NsYXNzX2FsbG93X2R5bmFt
aWNfc3lzYnVzX2RldihtLCBUWVBFX1ZNQlVTX0JSSURHRSk7DQo+KyAgICBjb21wYXRfcHJvcHNf
YWRkKG0tPmNvbXBhdF9wcm9wcywNCj4rICAgICAgICAgICAgICAgICAgICAgcGNfcTM1X2NvbXBh
dF9kZWZhdWx0cywgcGNfcTM1X2NvbXBhdF9kZWZhdWx0c19sZW4pOw0KPiB9DQo+DQo+IHN0YXRp
YyB2b2lkIHBjX3EzNV85XzBfbWFjaGluZV9vcHRpb25zKE1hY2hpbmVDbGFzcyAqbSkNCj5kaWZm
IC0tZ2l0IGEvdGVzdHMvcXRlc3QvdmlydGlvLWlvbW11LXRlc3QuYyBiL3Rlc3RzL3F0ZXN0L3Zp
cnRpby1pb21tdS10ZXN0LmMNCj5pbmRleCAwNjhlN2E5ZTZjLi5hZmIyMjU5NzFkIDEwMDY0NA0K
Pi0tLSBhL3Rlc3RzL3F0ZXN0L3ZpcnRpby1pb21tdS10ZXN0LmMNCj4rKysgYi90ZXN0cy9xdGVz
dC92aXJ0aW8taW9tbXUtdGVzdC5jDQo+QEAgLTM0LDcgKzM0LDcgQEAgc3RhdGljIHZvaWQgcGNp
X2NvbmZpZyh2b2lkICpvYmosIHZvaWQgKmRhdGEsDQo+UUd1ZXN0QWxsb2NhdG9yICp0X2FsbG9j
KQ0KPiAgICAgdWludDhfdCBieXBhc3MgPSBxdmlydGlvX2NvbmZpZ19yZWFkYihkZXYsIDM2KTsN
Cj4NCj4gICAgIGdfYXNzZXJ0X2NtcGludChpbnB1dF9yYW5nZV9zdGFydCwgPT0sIDApOw0KPi0g
ICAgZ19hc3NlcnRfY21waGV4KGlucHV0X3JhbmdlX2VuZCwgPT0sIFVJTlQ2NF9NQVgpOw0KPisg
ICAgZ19hc3NlcnRfY21waGV4KGlucHV0X3JhbmdlX2VuZCwgPj0sIFVJTlQzMl9NQVgpOw0KPiAg
ICAgZ19hc3NlcnRfY21waW50KGRvbWFpbl9yYW5nZV9zdGFydCwgPT0sIDApOw0KPiAgICAgZ19h
c3NlcnRfY21waW50KGRvbWFpbl9yYW5nZV9lbmQsID09LCBVSU5UMzJfTUFYKTsNCj4gICAgIGdf
YXNzZXJ0X2NtcGludChieXBhc3MsID09LCAxKTsNCj4tLQ0KPjIuNDEuMA0KDQo=

