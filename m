Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7DDC5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 03:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reoS6-0007GI-Hp; Mon, 26 Feb 2024 22:48:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reoS4-0007Fz-Qs; Mon, 26 Feb 2024 22:48:20 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1reoS0-0000GQ-LW; Mon, 26 Feb 2024 22:48:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1709005696; x=1740541696;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=0JnsqRwtjkYKVB9DEfwdlI9Q9r2noQ3MM+N7hC4UzqA=;
 b=nkZiwxhbqrwdeNKymwOJuIOm+FlnIEvakeuYkmVqPpIG9lPVyY9LDtyG
 T6x+eAZwDlUqHUjtCzYXd1uA1Gngr14Q1csVJb3icxsDGMOd5WvgASssl
 +ZcaMuwpS3a5urlmvx/gWYHxdt50p1T69H/iKi23DJqVNMb8aeToEJ1WO
 in5m1YvFx6icPxbOhf6VzkBaW6WQFPLzq999EPK8OxogjR7DTLlXRMjvC
 8yz84PrZD5pf/bEWb2syj7Jd++m7AXjF/WLKByf6ub1IjldRhHl7hUgtk
 Ms2WtyqoyYWEjef4V7LlHLVZkx4I6SooZ03Wg+oK0ge0SyIOcRuq6G2HP g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3495032"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3495032"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2024 19:48:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; d="scan'208";a="30066823"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Feb 2024 19:48:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 19:48:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 19:48:11 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 19:48:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EyXBi7ynhG+HkbQwFVshVNJACNanU55b+o61w9uZXKmCbY+EmGrd/hWQjEbycpEcbttAD5tNF7VrsBsk/PNHUhWu4xEcCkklfHPe8Apsc0tsX3Y7OnsmAYvb+w9GFvlLMOa3BEX/yN79EhqBLWg5tzSEydwEwG72VealBCLxQrCDlw5A5kMhB+f0CtTFUp8wf3JXbCby0EwAxa1DJCDPYMlGvDrErpfu4K7iiLK8G2kA8vR8pBSAiHkSCLOLl4TKMBceVdy2GGkI6li74WyXmaCas3mT1RU6UGVIVJJLlAZp8EmYFztNnC+2wdfNwlyzg3s02TcPlHcv0guxMACEcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JnsqRwtjkYKVB9DEfwdlI9Q9r2noQ3MM+N7hC4UzqA=;
 b=I6jnhQ0dfcwLCsWKS0rslFR+roF1USFbbkQ97kcRYVgXBlzcbZiIF3CZf2hbkVUvthdCkQyptIH5nLQFH0NgSKGydHbsW8/z1RJ0teu5ylHboJtCRKPnt/o+qDpHI76eO53gDZjYWlswMYu1hqmq3wAZWZSVn8bfYCavEWP5y5x2m0k7CaJ0zTOr+w2nJ/c5pk6Rze8axZKCFsbEzkM+lbbQyKEwvdvplqPYV/vHFq7SnpNfhPrSwuo5aT2ZidoTh35A7RAASJ8HupmpfGk1DkxwhLGctMfZLAl9nqO18gpjWtdDFmqHKHUlVX8+ABlBcAu0tEc+ZF9nSR0yYKEuYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 03:48:09 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::c0f3:15d4:d7f6:a72a%4]) with mapi id 15.20.7339.009; Tue, 27 Feb 2024
 03:48:09 +0000
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
Subject: RE: [PATCH v5 1/3] qdev: Add a granule_mode property
Thread-Topic: [PATCH v5 1/3] qdev: Add a granule_mode property
Thread-Index: AQHaaN+fnPw0riq400SvQFoF7qgWb7EdjYvg
Date: Tue, 27 Feb 2024 03:48:09 +0000
Message-ID: <SJ0PR11MB67449084F5047BDBA81D4AF992592@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240226181337.24148-1-eric.auger@redhat.com>
 <20240226181337.24148-2-eric.auger@redhat.com>
In-Reply-To: <20240226181337.24148-2-eric.auger@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA0PR11MB7749:EE_
x-ms-office365-filtering-correlation-id: d83e45cd-87c0-4e90-574b-08dc3746e9df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ieXCcMhjSM0d4UoXz2klsdy/7aO3h0YXvzohlcE606Ys7UABAzXPtgwJzG4ieGfu3uZ7enHo3DVWTeXDBz5zAWjCxABGDYLq1oIaeOv6E6mAfg8VrZLsejdJ8XSsJ+AUUg6ygWVzhKDqB2OjikJ+v1NO4bfapoy1RCt0W4ZdghClei5XYHWbHFcA4FN0dL23oe9NE3FAz4Trqak3aOIJ1y4xb3CTQiizdmpoLxq4+Rqx+kXrSf5AYd3wwgihhQ0O5OnQgJE75TbhjFuCxb1KqXx4g+3Nyor2h2M7OxAlc1tKnaFw4/OkbbSBtJHq+gN4At/h6TXsDcubfKB6u4gKaj5IlBsWWwIGX5LTXwIKe9kZsdDW/BUpHeyW8+mmHCyB5rzZlNyQQvQcPQ4cDQ9vJ7EU1NAp/LVgjtGdnhOwG9wPpNvR4Hz5SOtu+JhaOOZA9Toxdw6hvE4Aeq9E4wOac91KO31Mc+AqmhmGZCaggpIEQq7NXlvzIYyBnbyc37MdWFzVINiuZvZN1kftuwy8yL6QJJ/P6B5MWzIE5H7IOdNuyKUucVTLkOcv+TaCIN82YEloOoSn5gK5nZc1/MRKoNfwi0KY8rcj7zrMfCnauYqWddmrtBujxN/ubEyUTgOStna54FPjsVqdMP7eeO5dzKid0VV98VtW8Fx8vop1W/3dMwhI1Dr3YMt0uacfoQWA3Vc5UxPe8GAQ/qVRcH8M6hTd0VvGdk/6eC6gYnWg+ww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SS9LVUFVTklMM2N3YVZvTno4S09SWDQzWUhvRmV1azZqSlE2bEJCQ0ozOEZi?=
 =?utf-8?B?NStVUWdsU1Vzdmo4TnZGak1ONVZYNGVFSXc1UFdRZ2NadnZ1Mk9yanVZNnpv?=
 =?utf-8?B?dGpHU1YwU3FRekE1bk5CTHNBckx6N1QzZjhDL1l1Mi9Vd0doSFdIZmczRDEx?=
 =?utf-8?B?Q3BPWkNFVS8weHVnTkhXZzZZdzJCbzI2VXgvZitjei9JQTlLZnZhU2JIRDlR?=
 =?utf-8?B?OW9ENXNpMkM5ZFVrUXRBUmJDRTRpOXFVNUt6UVFUTnFMc0JOSmZEeWhiN3NQ?=
 =?utf-8?B?b3lpYnRCVDlxdVc3TDM2L1FIVWVKRXJPaHk0dVU4VW1RMVJxMFErN3kwZmJI?=
 =?utf-8?B?b0tQU3dNY014MENQUVhZZjcvVnZabUNIVE9PbHZyZVRiR1dVSzlJUVg1NkJX?=
 =?utf-8?B?TndCMWpJR0p3N3F0OUtOdHlrWUhncW9qL1piUmwwQ2RFU2pBOUxnZU5OWWhG?=
 =?utf-8?B?UkJFeWRWSkxsdTQxSXNZTVVLYmNVckQ2cDl0bHdMRXN2cXBSRnFVZ0gzbTA1?=
 =?utf-8?B?RUJqY1hncGlVekpvWDIxakVnL1VHa3gxVjM5ajg3WEJDd0pHaWl0NnQ3eG55?=
 =?utf-8?B?ZEViUWZON3RXMkJTV3FEQ1Y2dG1Sa0lROFcvWjJRVVhPRWRydmR0NDVEekxx?=
 =?utf-8?B?T1gxQmdkNW5kV01sNXdTYUh1SzVFSWtsMTQ5b1NpSTNyMWt3Rk1XQUxIQUw1?=
 =?utf-8?B?b3FJenAyYlRUOFVFaGNyYkVQVWxCNEdaaWhOSWVlaDJxckRmN1NabndZbzRB?=
 =?utf-8?B?T2c3ZTQ2VEY4YUVuS2VCekR2QWFzTlo5Lyt1N04vd3R5VFAwUmsrS0ZxZDk5?=
 =?utf-8?B?dkJpcWtJNTNJOXh6OHRZL3RaSVFudTZieHIyRzVTWjQ1cDJYL09obk56d3VP?=
 =?utf-8?B?UnduUHBaQjJLbzZwVWVlTzhyVEo3SXRjZEpLOXhaQ0FlcFdyMGVnUXptQkdm?=
 =?utf-8?B?YXpBdUNCcGY3UmkzTndIYlY0SzFHY2tDazdJMXRmdlhYYXJXc1cwTWE3UFVH?=
 =?utf-8?B?OXlmb1IvbThxaHduOE15Zk55RzhqY1FySU5LaCtZeVY1TDR0S1FtK3hGaDd0?=
 =?utf-8?B?M24xZEVnQnI2NkczL0JtcHRoWHpGOHhmSFkvaUlYRUtRZE5TRncrQmh4ZHNn?=
 =?utf-8?B?Y2tXKzBOVzZFcmk2TFRyVzJKOHZwY2NNRUNKaGhLNTZjWVZ5dXZCdFpYblFQ?=
 =?utf-8?B?SFlJSld3RVBzd2NyNDFRVkV2U1k1Ry9KTnpFVnQ2Y3h3Z0pLZkNoa1VSTXF3?=
 =?utf-8?B?citMZTdUVHptNnZuS05BOTJCQzkzWE9xNG9ibXhHQlZZMmsyZmFtbktBNjQv?=
 =?utf-8?B?Ymd5dC9UajBqdkZidTVxSDkvcWRpZ3c3WEZJY2w5OFNYamx4enVnT281TlNI?=
 =?utf-8?B?UmNKcjRlckdRaWEwQldZMzhrekVvY1Z0d1FOVXd4ajRFVEdUYVowRnZDeWE1?=
 =?utf-8?B?RCt6YVBLK0Y2c29hTy94RWcvTTBPUWIrRkhnTGVwOEpQOUgyWkMzdkVCR3o5?=
 =?utf-8?B?U1lnZ2JpVkFncWorYitPUnNnd0FIcUhXVGQ0NTliRmNXcWRUa2IrckhVM2tJ?=
 =?utf-8?B?TnlyKzJpWmRFcWJLTU9MTllmcGZMZjh1Z1ZuMStnMU43bEZ0ZURnQVM0QmRo?=
 =?utf-8?B?N29jNGZUQnMxdUoveFFINDRBTjJDNThRMUFSK3dpa2dzS3lxL3puUm9Pb0tG?=
 =?utf-8?B?MWQwek5ZU2JRSVNJa1JUUzRPbDhIeTArTEh2WGFOQjNoZWpGWGp6QXF1SkpQ?=
 =?utf-8?B?MjBrT0VpMG5yQmRQOXBOOXNQTm9Yb1gwZmtmb2hVOU82OVgxZHVuUDZxQUNO?=
 =?utf-8?B?WWdqcFVjaWdjV1BaMUk0ZEVrbHZHTEhzckRGWXo2WEJISDJKNlBMZUdLeFJr?=
 =?utf-8?B?a1E4ckZtL0NGeUhGR0JPZTFCRGNMOE5kTExXQU0zZ2Y3cUNKSmsxOHZNU1hD?=
 =?utf-8?B?Y2VmQnQzMW9qWXpzL1JIK2s1dVJka3ZudHNqc3locUdXK2h0cjRaakQzWm9Z?=
 =?utf-8?B?aHJ0a3MybklJS2VERzk2OU15M1hCMFZJSjVaWUsyT09BOVVmTmIvRGFSd1No?=
 =?utf-8?B?WmE1UVJBaWFCM3Q0aWNWd25hbnh3b0pMTE9XSGtveEhHLytZTk9QMmFRNmQy?=
 =?utf-8?Q?SdHSZPQPJfad7zXR8IxHNJ5CS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83e45cd-87c0-4e90-574b-08dc3746e9df
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 03:48:09.0501 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9QUHjWGYo2r5gi5MFYq8M8E0Ou1JX85/bBqHa6NVXm47s9zLe3jCnL//Z5BewL0VpEVx11Nz+sdaQgWsSg3k690hSeuGFBczTAmlExbU/X8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBbUEFUQ0ggdjUgMS8zXSBxZGV2OiBBZGQgYSBn
cmFudWxlX21vZGUgcHJvcGVydHkNCj4NCj5JbnRyb2R1Y2UgYSBuZXcgZW51bSB0eXBlIHByb3Bl
cnR5IGFsbG93aW5nIHRvIHNldCBhbg0KPklPTU1VIGdyYW51bGUuIFZhbHVlcyBhcmUgNGssIDhr
LCAxNmssIDY0ayBhbmQgaG9zdC4NCj5UaGlzIGxhdHRlciBpbmRpY2F0ZXMgdGhlIHZJT01NVSBn
cmFudWxlIHdpbGwgbWF0Y2gNCj50aGUgaG9zdCBwYWdlIHNpemUuDQo+DQo+QSBzdWJzZXF1ZW50
IHBhdGNoIHdpbGwgYWRkIHN1Y2ggYSBwcm9wZXJ0eSB0byB0aGUNCj52aXJ0aW8taW9tbXUgZGV2
aWNlLg0KPg0KPlNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNv
bT4NCj5TaWduZWQtb2ZmLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+DQo+DQo+LS0tDQo+djQgLT4gdjUNCj4tIHJlbW92ZSBjb2RlIHRoYXQgY2FuIGJlIGF1
dG9tYXRpY2FsbHkgZ2VuZXJhdGVkDQo+ICBhbmQgYWRkIHRoZSBuZXcgZW51bSBpbiBxYXBpL3Zp
cnRpby5qc29uIChQaGlsaXBwZSkuDQo+ICBBZGRlZCBQaGlsZCdzIFNPQi4gbG93IGNhc2UgbmVl
ZHMgdG8gYmUgdXNlZCBkdWUgdG8NCj4gIHRoZSBKYXNvbiBnZW5lcmF0aW9uLg0KPg0KPnYzIC0+
IHY0Og0KPi0gQWRkIDhLDQo+LS0tDQo+IHFhcGkvdmlydGlvLmpzb24gICAgICAgICAgICAgICAg
ICAgIHwgMTggKysrKysrKysrKysrKysrKysrDQo+IGluY2x1ZGUvaHcvcWRldi1wcm9wZXJ0aWVz
LXN5c3RlbS5oIHwgIDMgKysrDQo+IGh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLXN5c3RlbS5jICAg
IHwgMTUgKysrKysrKysrKysrKysrDQo+IDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygr
KQ0KPg0KPmRpZmYgLS1naXQgYS9xYXBpL3ZpcnRpby5qc29uIGIvcWFwaS92aXJ0aW8uanNvbg0K
PmluZGV4IGE3OTAxM2ZlODkuLjk1NzQ1ZmRmZDcgMTAwNjQ0DQo+LS0tIGEvcWFwaS92aXJ0aW8u
anNvbg0KPisrKyBiL3FhcGkvdmlydGlvLmpzb24NCj5AQCAtOTU3LDMgKzk1NywyMSBAQA0KPg0K
PiB7ICdzdHJ1Y3QnOiAnRHVtbXlWaXJ0aW9Gb3JjZUFycmF5cycsDQo+ICAgJ2RhdGEnOiB7ICd1
bnVzZWQtaW90aHJlYWQtdnEtbWFwcGluZyc6IFsnSU9UaHJlYWRWaXJ0UXVldWVNYXBwaW5nJ10g
fSB9DQo+Kw0KPisjIw0KPisjIEBHcmFudWxlTW9kZToNCj4rIw0KPisjIEA0azogZ3JhbnVsZSBw
YWdlIHNpemUgb2YgNEtpQg0KPisjDQo+KyMgQDhrOiBncmFudWxlIHBhZ2Ugc2l6ZSBvZiA4S2lC
DQo+KyMNCj4rIyBAMTZrOiBncmFudWxlIHBhZ2Ugc2l6ZSBvZiAxNktpQg0KPisjDQo+KyMgQDY0
azogZ3JhbnVsZSBwYWdlIHNpemUgb2YgNjRLaUINCj4rIw0KPisjIEBob3N0OiBncmFudWxlIG1h
dGNoZXMgdGhlIGhvc3QgcGFnZSBzaXplDQo+KyMNCj4rIyBTaW5jZTogOS4wDQo+KyMjDQo+K3sg
J2VudW0nOiAnR3JhbnVsZU1vZGUnLA0KPisgICdkYXRhJzogWyAnNGsnLCAnOGsnLCAnMTZrJywg
JzY0aycsICdob3N0JyBdIH0NCj5kaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9xZGV2LXByb3BlcnRp
ZXMtc3lzdGVtLmggYi9pbmNsdWRlL2h3L3FkZXYtDQo+cHJvcGVydGllcy1zeXN0ZW0uaA0KPmlu
ZGV4IDA2YzM1OWMxOTAuLjYyNmJlODdkZDMgMTAwNjQ0DQo+LS0tIGEvaW5jbHVkZS9ody9xZGV2
LXByb3BlcnRpZXMtc3lzdGVtLmgNCj4rKysgYi9pbmNsdWRlL2h3L3FkZXYtcHJvcGVydGllcy1z
eXN0ZW0uaA0KPkBAIC04LDYgKzgsNyBAQCBleHRlcm4gY29uc3QgUHJvcGVydHlJbmZvIHFkZXZf
cHJvcF9tYWNhZGRyOw0KPiBleHRlcm4gY29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJvcF9yZXNl
cnZlZF9yZWdpb247DQo+IGV4dGVybiBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9wcm9wX211bHRp
ZmRfY29tcHJlc3Npb247DQo+IGV4dGVybiBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9wcm9wX21p
Z19tb2RlOw0KPitleHRlcm4gY29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJvcF9ncmFudWxlX21v
ZGU7DQo+IGV4dGVybiBjb25zdCBQcm9wZXJ0eUluZm8gcWRldl9wcm9wX2xvc3R0aWNrcG9saWN5
Ow0KPiBleHRlcm4gY29uc3QgUHJvcGVydHlJbmZvIHFkZXZfcHJvcF9ibG9ja2Rldl9vbl9lcnJv
cjsNCj4gZXh0ZXJuIGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3BfYmlvc19jaHNfdHJhbnM7
DQo+QEAgLTQ3LDYgKzQ4LDggQEAgZXh0ZXJuIGNvbnN0IFByb3BlcnR5SW5mbw0KPnFkZXZfcHJv
cF9pb3RocmVhZF92cV9tYXBwaW5nX2xpc3Q7DQo+ICNkZWZpbmUgREVGSU5FX1BST1BfTUlHX01P
REUoX24sIF9zLCBfZiwgX2QpIFwNCj4gICAgIERFRklORV9QUk9QX1NJR05FRChfbiwgX3MsIF9m
LCBfZCwgcWRldl9wcm9wX21pZ19tb2RlLCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgTWln
TW9kZSkNCj4rI2RlZmluZSBERUZJTkVfUFJPUF9HUkFOVUxFX01PREUoX24sIF9zLCBfZiwgX2Qp
IFwNCj4rICAgIERFRklORV9QUk9QX1NJR05FRChfbiwgX3MsIF9mLCBfZCwgcWRldl9wcm9wX2dy
YW51bGVfbW9kZSwNCj5HcmFudWxlTW9kZSkNCj4gI2RlZmluZSBERUZJTkVfUFJPUF9MT1NUVElD
S1BPTElDWShfbiwgX3MsIF9mLCBfZCkgXA0KPiAgICAgREVGSU5FX1BST1BfU0lHTkVEKF9uLCBf
cywgX2YsIF9kLCBxZGV2X3Byb3BfbG9zdHRpY2twb2xpY3ksIFwNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgTG9zdFRpY2tQb2xpY3kpDQo+ZGlmZiAtLWdpdCBhL2h3L2NvcmUvcWRldi1wcm9w
ZXJ0aWVzLXN5c3RlbS5jIGIvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtDQo+c3lzdGVtLmMNCj5p
bmRleCAxYTM5NjUyMWQ1Li42ODVjZmZkMDY0IDEwMDY0NA0KPi0tLSBhL2h3L2NvcmUvcWRldi1w
cm9wZXJ0aWVzLXN5c3RlbS5jDQo+KysrIGIvaHcvY29yZS9xZGV2LXByb3BlcnRpZXMtc3lzdGVt
LmMNCj5AQCAtMzQsNiArMzQsNyBAQA0KPiAjaW5jbHVkZSAibmV0L25ldC5oIg0KPiAjaW5jbHVk
ZSAiaHcvcGNpL3BjaS5oIg0KPiAjaW5jbHVkZSAiaHcvcGNpL3BjaWUuaCINCj4rI2luY2x1ZGUg
Imh3L3ZpcnRpby92aXJ0aW8taW9tbXUuaCINCg0KVGhpcyBpcyB1bm5lY2Vzc2FyeSwgb3RoZXJ3
aXNlLA0KDQpSZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVs
LmNvbT4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPiAjaW5jbHVkZSAiaHcvaTM4Ni94ODYuaCIN
Cj4gI2luY2x1ZGUgInV0aWwvYmxvY2staGVscGVycy5oIg0KPg0KPkBAIC02NzksNiArNjgwLDIw
IEBAIGNvbnN0IFByb3BlcnR5SW5mbyBxZGV2X3Byb3BfbWlnX21vZGUgPSB7DQo+ICAgICAuc2V0
X2RlZmF1bHRfdmFsdWUgPSBxZGV2X3Byb3BpbmZvX3NldF9kZWZhdWx0X3ZhbHVlX2VudW0sDQo+
IH07DQo+DQo+Ky8qIC0tLSBHcmFudWxlTW9kZSAtLS0gKi8NCj4rDQo+K1FFTVVfQlVJTERfQlVH
X09OKHNpemVvZihHcmFudWxlTW9kZSkgIT0gc2l6ZW9mKGludCkpOw0KPisNCj4rY29uc3QgUHJv
cGVydHlJbmZvIHFkZXZfcHJvcF9ncmFudWxlX21vZGUgPSB7DQo+KyAgICAubmFtZSA9ICJHcmFu
dWxlTW9kZSIsDQo+KyAgICAuZGVzY3JpcHRpb24gPSAiZ3JhbnVsZV9tb2RlIHZhbHVlcywgIg0K
PisgICAgICAgICAgICAgICAgICAgIjRrLCA4aywgMTZrLCA2NGssIGhvc3QiLA0KPisgICAgLmVu
dW1fdGFibGUgPSAmR3JhbnVsZU1vZGVfbG9va3VwLA0KPisgICAgLmdldCA9IHFkZXZfcHJvcGlu
Zm9fZ2V0X2VudW0sDQo+KyAgICAuc2V0ID0gcWRldl9wcm9waW5mb19zZXRfZW51bSwNCj4rICAg
IC5zZXRfZGVmYXVsdF92YWx1ZSA9IHFkZXZfcHJvcGluZm9fc2V0X2RlZmF1bHRfdmFsdWVfZW51
bSwNCj4rfTsNCj4rDQo+IC8qIC0tLSBSZXNlcnZlZCBSZWdpb24gLS0tICovDQo+DQo+IC8qDQo+
LS0NCj4yLjQxLjANCg0K

