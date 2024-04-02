Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9343DCD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 07:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrYns-0003Km-4s; Tue, 02 Apr 2024 03:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rrYnq-0003KO-AN
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:43:30 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuan1.liu@intel.com>)
 id 1rrYnn-0006n5-9k
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 03:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1712043808; x=1743579808;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dWEUOucBL3280dMT12A8IZSonSRhTjXDJqSebce5/zg=;
 b=l/eUKeyhSScp+ReNs1K5n9IMXMWpK9kCXPMG7UPB9Lx6ElpzX6q+vipb
 Tw4P435emJVKRFCZAdZhAueGwyDwFtZIgsJ9ZBn4Z6W8cdvzuiwHhem0W
 A9vF+6NLKmxmpSZcKVndQ6OjszvCbjumD7s/GeQHWOlkG8RkgsbNQbaqO
 1Yn6pEB7TxjjFmJVIqZvJFLEa/jM2V+77ugSvj2kS3QxVtbj2SfNCkRBe
 PH7nJbBIz45jGaPK8VZpUWMJiGBRt50Jo1c9MlKm8Inq8qYBC06Vt1PyT
 TY80l1OwpJVdaIyXQVLKyvb9nlvsJnw+3vVDlQ5XJWuLPrpuqP54oU/Rm A==;
X-CSE-ConnectionGUID: lMVeQP0bQAi53J3NYrpo9Q==
X-CSE-MsgGUID: xXV9W5P4STCKiPY1DRseJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="11027496"
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="11027496"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2024 00:43:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,174,1708416000"; d="scan'208";a="48985689"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Apr 2024 00:43:24 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 00:43:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 00:43:23 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Apr 2024 00:43:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx1+vSTOnEy3PrESmkWe3n+8vacdwI3Hj2FbewbU1yExtKdWyJpoUcUPDP0VeW5HU1ij1+4lT9gmCcdYCqxFVWXGTbIAwN5BVAgW3sRMg4yz7pPmN3EtKK7TxZpp9TkeOJnkCqpQhBvwh63QyzhFB/9m0xD072v/O+Eu5pJEInagj9MHH7gH3vW2yMpb9aLRE8KDAubuZvRHZa0FafLVPC4uhjY0GCLT5FlJXJvMUzVnwqUiglVdUvNNODWrFeHfFwNKHIuICzxKkcBfXdj14EovkNO/0bN5eZPVuGms2Yp2QvV00Tt/FruBoXZDC4qXWZyO1NX7+7CJL0C2Rv67IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWEUOucBL3280dMT12A8IZSonSRhTjXDJqSebce5/zg=;
 b=FOjmdTiAKNrboQOG1C5RLnrcNCB+TR2FCJBUZ3YVVn2CjUEKlSN//z5/B+fg+YJCYcazpH0BJCcwPMmpt4rjSrYyy4xuS47rSDhkEW+K4OuMsBpZJSj0ve6t3klrqKEepmRgPymdnDgySLgdVs/0Zc8fN6zTXj3ivciPbjCCKP2Rm+BH48oPPqX/7kRQiOE4QvfNSwxtrbI4wcvRMOhnGo2Iqkgsqu3+iOHB9R2cBQwFj+rZE3C1Yg/GMsqiglAhb9PW+HnqyLCC255BQDK1+i9MsfiSbJQdXbws0WK+ePauE0A58Dqbf8BkC36oT1ATIOjIdf1FO+3ypmRqvAG7Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5941.namprd11.prod.outlook.com (2603:10b6:510:13d::20)
 by SA0PR11MB4621.namprd11.prod.outlook.com (2603:10b6:806:72::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 07:43:21 +0000
Received: from PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::bd:d247:6d97:6f34]) by PH7PR11MB5941.namprd11.prod.outlook.com
 ([fe80::bd:d247:6d97:6f34%6]) with mapi id 15.20.7452.019; Tue, 2 Apr 2024
 07:43:21 +0000
From: "Liu, Yuan1" <yuan1.liu@intel.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "farosas@suse.de"
 <farosas@suse.de>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "hao.xiang@bytedance.com"
 <hao.xiang@bytedance.com>, "bryan.zhang@bytedance.com"
 <bryan.zhang@bytedance.com>, "Zou, Nanhai" <nanhai.zou@intel.com>
Subject: RE: [PATCH 0/1] Solve zero page causing multiple page faults
Thread-Topic: [PATCH 0/1] Solve zero page causing multiple page faults
Thread-Index: AQHahM9sp2Fv3Go6YUeo1TyETV6fgrFUmLNA
Date: Tue, 2 Apr 2024 07:43:21 +0000
Message-ID: <PH7PR11MB5941F04FBFB964CB2C968866A33E2@PH7PR11MB5941.namprd11.prod.outlook.com>
References: <20240401154110.2028453-1-yuan1.liu@intel.com>
In-Reply-To: <20240401154110.2028453-1-yuan1.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5941:EE_|SA0PR11MB4621:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S7FZnR9Fhhgmf63pFH32oqzD5worOupTnE+Lt2ly8XiKEP7mHt6+GaFHGyERZUD2tuAqXGh08tV4BwpBHj0EseEkQCzcNK5TDae3Rz6jos0moKHZk2mc8qj4udeB7Kl6bdiR4DYeQX+KWPMZMUvlW6Y8dNHg/PmGAmrgpQIIc9q3PmN/CBqOmaERjsYvnLydIXXgGs2+YvsJw+4OcviPa/j8kbryaguG0M0cbqwR70+GC4dSABjT0qwUJhEn5maNj3fhq7DGURfmNPbKhLgqyZpYBRLC5IPiE1ISJY9f6L6iIVFTZP3rQVYu2ghqDtyLTVlACrmKJyKaUId7NtYjhuPTLaQ94kZ75h06ZwQ4P5McM3+7+JzICIS0KossI3f1nwYg30lQD9uuD522mkko5+6AXqCM/yfp4MKsXsa4pCSmdK9+6SGg/BlbKD7efV3kwMp8z6lxduORA21VJ7JioKBTaA2S/Ykq44gmjfWW3P8AZKj5qNGYL4/zFA0XrEuVbPx/FCtwAmE7IkE0f0pplIVVhc8WPueDbMktkspvtT6tQYDhc0ry1RBFUsrbYiOi+KriuJ/xr3ynNLdbTT6u5iYG4y7hHhtP2PH0nnUSwn0SWgYF7WpGzyO7yJxzslcZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PH7PR11MB5941.namprd11.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?RCtha2Y1aDRzMCtZSklUd3Q2NkMxeFNqRW5KUmRkSHRYVGxnZStvS2F1cWt0?=
 =?gb2312?B?VndOZzZHMEd3WmtXcjNlMkR0UHBLZGlpek1yOHU4aWZJbnY0ajJtck5ZY2JR?=
 =?gb2312?B?WjkyZlVFS2VCck5vNUhIenVnUlQ3R3VyNnVTNFdRZGxwWHJ5Sm5YOXdNajQ5?=
 =?gb2312?B?ZlRFN1NkaFAyc3B0MWVUVWlIQzVNQmdJazJIcEpyT0pYbFF5WWE1OHBjS1Jn?=
 =?gb2312?B?cXVNMTN4YnVmUEd1SXlyVlpRbmUzb2twcnFhVjlZQ2Ria1NtYWtycHRMaDVY?=
 =?gb2312?B?bjNFWVlsVFA4ZGN5SVFTN3pZZGNuYVVNZC8rcFdOYzU5bmliVi9QbHRMWUZo?=
 =?gb2312?B?OVVMMGgraXZiSSttNjBGRmRUSngrSHdyNGxjQWxoYU5UM3JmL0NUckd1anQ5?=
 =?gb2312?B?TVFSbXVUOTV5UVYydjQzLzkrUFFyUXZVTEJENWdHM29EWVd1RGU4N1FKMGFy?=
 =?gb2312?B?VXQ4bDBjUFpWeFZkY2kyZGdUMVRZTzJnQnRZODBxeVBaRGZNcXBDNXR0NXM2?=
 =?gb2312?B?WFdSMXpsamNEUzBFYnA4bFVQVnJNNGJ3OVovYk9CRDMvdUhxMTREMzAwZGxN?=
 =?gb2312?B?NVArbEFWbjdVZkdXbVhDWFBoZVNCWG9KQ0ZSYUUyV21PeUM3bTFCbmJvRU1Q?=
 =?gb2312?B?ZVRSNE52Z0cxY0xGRTQ3eWh1ekhFK05QTkd6bG1NeXRrTGxheEFCY1V4S1Q3?=
 =?gb2312?B?S3IzenpHUDlsbEsxMFIrOWVTRy8ySEFBNnhoMnY3Z3JrQzlodDVqVk5TZ0Zt?=
 =?gb2312?B?RktqZXl1b1hsRXFaZld0aFBiOENXaHlpb3lDRzBIRG1BMGxYVzdGSk1UOCtT?=
 =?gb2312?B?ZzhWZmRjc2hwSC9hVVllOXg3YzF0ZTBnVmYxK1EydnNsUktmK3A2c2dxN1hy?=
 =?gb2312?B?TzE5NzRIelcwRHExR0pWMzlseFVta1pOemlTTnFVb0NDSEdRMkVuc3ZESWlR?=
 =?gb2312?B?NmIwUks3aFFNSzFPOEN5ZHhFaERHcmcyVWszZ1Y3akpVc24zOFl3YXJvZll4?=
 =?gb2312?B?THJBYXg5dzFGaXBhOGhLUEFmVUdHb1dsUkdBZmNyUW43ejliakwzY3YxQ05k?=
 =?gb2312?B?djBYMG1lTlYva2d6V0owVG5JMGNZeDRIUUdrU2IvWU9lZzJJVmNxRjBmY0lr?=
 =?gb2312?B?UjNSQUVNRmhEZVdpK09RVUdZQ3R2d1U2a01lRUEydVI3ZjJtQm15SGVyNkZm?=
 =?gb2312?B?UklMYU53eG5ENFZyMy9BQitkOHRtMGNaVE9hdDh3NXpKVWp4MUEzMFNhMXVR?=
 =?gb2312?B?Vk1EcHZsWnF1dGlxOVR4TnpQZFVoVUJiekcxVzdxWVBmSEF1Z0VPd0dYRXdO?=
 =?gb2312?B?Nk5oN1VHZ2pNaUVvM2hLSXZuTUQ0RUVmM1l2Yi9EY2NveHV4VkdXN0pPQzYv?=
 =?gb2312?B?QUhBbzNnTndXYmVHTlIxaHJYRU8zZzEyVnRabzlkcXV1YXMrVHBzWVRGR1Mw?=
 =?gb2312?B?K2lkN1hXTGp5eTROUFdKTGhCQVFpTTZQc3VmSDBzYkFoazJLODRTRll6LzlI?=
 =?gb2312?B?MW9sTEVaTmthSldQUDRSZWJOZjJic056Nm84cXpOQVE1cWl4UDl0MnIyZ3ZN?=
 =?gb2312?B?N21KaVUzbmgvNVhtN0JXdmN3UHZBUGlBc1FWVE5MczRFTUZTTmltVFhvekU0?=
 =?gb2312?B?dnFLazJ3RUhqbEY2dXA2Q0p3K25vM3c0b3BwUzNqa0ZKRVVPR1RPeW5UeXdT?=
 =?gb2312?B?MEIvU3RjRnh2VmhOMDEwQ0lxY21CZGl2Y05OR0ZHQXVFTTN3bXR3aWdoTnFF?=
 =?gb2312?B?eEJHajhwZ09PNUpMZkNoSVdmcFVWWTY4cWNHcmN6ZmRVSkx6ZVM2R2tzR050?=
 =?gb2312?B?RWpOZ1JjTWg0bG1EYkJ0YWw1WXBXSE94dVlDU1N5dkxQR05DUmdhdW5YN05n?=
 =?gb2312?B?YnJDcVpDNTlGaEM2ZWIzdFAvTERIWklkbGFPeDI5RG00KzVRT0FSQW9lVTNV?=
 =?gb2312?B?THVHUGhTNkJTZXQyZUthL253M1lVdGhRRzNKZjdsaFNvd3NLRnlDWnA4QWVE?=
 =?gb2312?B?REFmQ3h2eld5eWZ5Z29VamRyajdIaFgreXhwMi9kQlZPMWNrMXl5QnFaczdK?=
 =?gb2312?B?Zmp3Z1FXMjkwVUxZczJjNlliL2tHVVN6REtKai9zSnpGaTR5WUhENzQrTnZV?=
 =?gb2312?Q?/bi6LageyeaWBdfXPQ9SJiujF?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5941.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f1bbf9-f5ea-4e63-71f8-08dc52e891f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 07:43:21.4093 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u+fAPmGmD+YudyiwXBK3boU8q6g0CdlsXaPbzEAYISCmgVRvFBchVh7ja0LzCvtpomVZB30UuJW3GlHRK95Cwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4621
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yuan1.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMaXUsIFl1YW4xIDx5dWFuMS5s
aXVAaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDEsIDIwMjQgMTE6NDEgUE0NCj4g
VG86IHBldGVyeEByZWRoYXQuY29tOyBmYXJvc2FzQHN1c2UuZGUNCj4gQ2M6IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZzsgaGFvLnhpYW5nQGJ5dGVkYW5jZS5jb207DQo+IGJyeWFuLnpoYW5nQGJ5dGVk
YW5jZS5jb207IExpdSwgWXVhbjEgPHl1YW4xLmxpdUBpbnRlbC5jb20+OyBab3UsIE5hbmhhaQ0K
PiA8bmFuaGFpLnpvdUBpbnRlbC5jb20+DQo+IFN1YmplY3Q6IFtQQVRDSCAwLzFdIFNvbHZlIHpl
cm8gcGFnZSBjYXVzaW5nIG11bHRpcGxlIHBhZ2UgZmF1bHRzDQo+IA0KPiAxLiBEZXNjcmlwdGlv
biBvZiBtdWx0aXBsZSBwYWdlIGZhdWx0cyBmb3IgcmVjZWl2ZWQgemVybyBwYWdlcw0KPiAgICAg
YS4gLW1lbS1wcmVhbGxvYyBmZWF0dXJlIGFuZCBodWdlcGFnZSBiYWNrZW5kIGFyZSBub3QgZW5h
YmxlZCBvbiB0aGUNCj4gICAgICAgIGRlc3RpbmF0aW9uDQo+ICAgICBiLiBBZnRlciByZWNlaXZp
bmcgdGhlIHplcm8gcGFnZXMsIHRoZSBkZXN0aW5hdGlvbiBmaXJzdCBkZXRlcm1pbmVzIGlmDQo+
ICAgICAgICB0aGUgY3VycmVudCBwYWdlIGNvbnRlbnQgaXMgMCB2aWEgYnVmZmVyX2lzX3plcm8s
IHRoaXMgbWF5IGNhdXNlIGENCj4gICAgICAgIHJlYWQgcGFnZSBmYXVsdA0KPiANCj4gICAgICAg
cGVyZiByZWNvcmQgLWUgcGFnZS1mYXVsdHMgaW5mb3JtYXRpb24gYmVsb3cNCj4gICAgICAgMTMu
NzUlICAxMy43NSUgIG11bHRpZmRyZWN2XzAgcWVtdS1zeXN0ZW0teDg2XzY0IFsuXQ0KPiBidWZm
ZXJfemVyb19hdng1MTINCj4gICAgICAgMTEuODUlICAxMS44NSUgIG11bHRpZmRyZWN2XzEgcWVt
dS1zeXN0ZW0teDg2XzY0IFsuXQ0KPiBidWZmZXJfemVyb19hdng1MTINCj4gICAgICAgICAgICAg
ICAgICAgICAgIG11bHRpZmRfcmVjdl90aHJlYWQNCj4gICAgICAgICAgICAgICAgICAgICAgIG5v
Y29tcF9yZWN2DQo+ICAgICAgICAgICAgICAgICAgICAgICBtdWx0aWZkX3JlY3ZfemVyb19wYWdl
X3Byb2Nlc3MNCj4gICAgICAgICAgICAgICAgICAgICAgIGJ1ZmZlcl9pc196ZXJvDQo+ICAgICAg
ICAgICAgICAgICAgICAgICBzZWxlY3RfYWNjZWxfZm4NCj4gICAgICAgICAgICAgICAgICAgICAg
IGJ1ZmZlcl96ZXJvX2F2eDUxMg0KPiANCj4gICAgYy4gT3RoZXIgcGFnZSBmYXVsdHMgbWFpbmx5
IGNvbWUgZnJvbSB3cml0aW5nIG9wZXJhdGlvbnMgdG8gbm9ybWFsIGFuZA0KPiAgICAgICB6ZXJv
IHBhZ2VzLg0KPiANCj4gMi4gU29sdXRpb24NCj4gICAgIGEuIER1cmluZyB0aGUgbXVsdGlmZCBt
aWdyYXRpb24gcHJvY2VzcywgdGhlIHJlY2VpdmVkIHBhZ2VzIGFyZQ0KPiB0cmFja2VkDQo+ICAg
ICAgICB0aHJvdWdoIFJBTUJsb2NrJ3MgcmVjZWl2ZWRtYXAuDQo+IA0KPiAgICAgYi4gSWYgcmVj
ZWl2ZWQgemVybyBwYWdlIGlzIG5vdCBzZXQgaW4gcmVjdmJpdG1hcCwgdGhlIGRlc3RpbmF0aW9u
DQo+IHdpbGwgbm90DQo+ICAgICAgICBjaGVjayB3aGV0aGVyIHRoZSBwYWdlIGNvbnRlbnQgaXMg
MCwgdGh1cyBhdm9pZGluZyB0aGUgb2NjdXJyZW5jZQ0KPiBvZg0KPiAgICAgICAgcmVhZCBmYXVs
dC4NCj4gDQo+ICAgICBjLiBJZiB0aGUgemVybyBwYWdlIGhhcyBiZWVuIHNldCBpbiByZWNlaXZl
ZG1hcCwgc2V0IHRoZSBwYWdlIHdpdGggMA0KPiAgICAgICAgZGlyZWN0bHkuDQo+IA0KPiAgICAg
VGhlcmUgYXJlIHR3byByZWFzb25zIGZvciB0aGlzDQo+ICAgICAxLiBJdCdzIHVubGlrZWx5IGEg
emVybyBwYWdlIGlmIGl0J3Mgc2VudCBvbmNlIG9yIG1vcmUuDQo+ICAgICAyLiBGb3IgdGhlIDFz
dCB0aW1lIGRlc3RpbmF0aW9uIHJlY2VpdmVkIGEgemVybyBwYWdlLCBpdCBtdXN0IGJlIGENCj4g
emVybw0KPiAgICAgICAgcGFnZSwgc28gbm8gbmVlZCB0byBzY2FuIGZvciB0aGUgMXN0IHJvdW5k
Lg0KPiANCj4gMy4gVGVzdCBSZXN1bHQgMTYgdkNQVXMgYW5kIDY0RyBtZW1vcnkgVk0sICBtdWx0
aWZkIG51bWJlciBpcyAyLA0KPiAgICBhbmQgMTAwRyBuZXR3b3JrIGJhbmR3aWR0aA0KPiANCj4g
ICAgIDMuMSBUZXN0IGNhc2U6IDE2IHZDUFVzIGFyZSBpZGxlIGFuZCBvbmx5IDJHIG1lbW9yeSBh
cmUgdXNlZA0KPiAgICAgKy0tLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0r
DQo+ICAgICB8TXVsdGlGRCAgICB8IHRvdGFsICB8ZG93bnRpbWV8ICAgUGFnZSAgIHwNCj4gICAg
IHxOb2NvbXAgICAgIHwgdGltZSAgIHwgICAgICAgIHwgRmF1bHRzICAgfA0KPiAgICAgfCAgICAg
ICAgICAgfCAobXMpICAgfCAobXMpICAgfCAgICAgICAgICB8DQo+ICAgICArLS0tLS0tLS0tLS0r
LS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLSsNCj4gICAgIHx3aXRoICAgICAgIHwgICAgICAg
IHwgICAgICAgIHwgICAgICAgICAgfA0KPiAgICAgfHJlY3ZiaXRtYXAgfCAgICA3MzM1fCAgICAg
MTgwfCAgICAgIDI3MTZ8DQo+ICAgICArLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0t
LS0tLS0tLSsNCj4gICAgIHx3aXRob3V0ICAgIHwgICAgICAgIHwgICAgICAgIHwgICAgICAgICAg
fA0KPiAgICAgfHJlY3ZiaXRtYXAgfCAgICA3NzcxfCAgICAgMTUzfCAgICAxMjEzNTd8DQo+ICAg
ICArLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLSsNCj4gDQo+ICAgICAr
LS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tLSst
LS0tLS0tLS0tLS0tDQo+ICsNCj4gICAgIHxNdWx0aUZEICAgIHwgdG90YWwgIHxkb3dudGltZXwg
U1ZNICAgIHxTVk0gICAgfCBJT1RMQiAgfCBJTw0KPiBQYWdlRmF1bHR8DQo+ICAgICB8UVBMICAg
ICAgICB8IHRpbWUgICB8ICAgICAgICB8IElPIFRMQiB8SU8gUGFnZXwgTWF4VGltZXwgTWF4VGlt
ZQ0KPiB8DQo+ICAgICB8ICAgICAgICAgICB8IChtcykgICB8IChtcykgICB8IEZsdXNoICB8RmF1
bHRzIHwgKHVzKSAgIHwgKHVzKQ0KPiB8DQo+ICAgICArLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0t
LS0tLS0rLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tDQo+ICsNCj4gICAg
IHx3aXRoICAgICAgIHwgICAgICAgIHwgICAgICAgIHwgICAgICAgIHwgICAgICAgfCAgICAgICAg
fA0KPiB8DQo+ICAgICB8cmVjdmJpdG1hcCB8ICAgMTAyMjR8ICAgICAxNzV8ICAgICA0MTB8ICAy
NzQyOXwgICAgICAgMXwNCj4gNDQ3fA0KPiAgICAgKy0tLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLS0tLQ0KPiArDQo+ICAgICB8
d2l0aG91dCAgICB8ICAgICAgICB8ICAgICAgICB8ICAgICAgICB8ICAgICAgIHwgICAgICAgIHwN
Cj4gfA0KPiAgICAgfHJlY3ZiaXRtYXAgfCAgIDExMjUzfCAgICAgMTUzfCAgIDgwNzU2fCAgMzg2
NTV8ICAgICAgMjV8DQo+IDE4MzQ5fA0KPiAgICAgKy0tLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0t
LS0tKy0tLS0tLS0tKy0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLS0tLQ0KPiArDQo+IA0KPiAN
Cj4gICAgIDMuMiBUZXN0IGNhc2U6IDE2IHZDUFVzIGFyZSBpZGxlIGFuZCA1NkcgbWVtb3J5KG5v
dCB6ZXJvKSBhcmUgdXNlZA0KPiAgICAgKy0tLS0tLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tKy0t
LS0tLS0tLS0rDQo+ICAgICB8TXVsdGlGRCAgICB8IHRvdGFsICB8ZG93bnRpbWV8ICAgUGFnZSAg
IHwNCj4gICAgIHxOb2NvbXAgICAgIHwgdGltZSAgIHwgICAgICAgIHwgRmF1bHRzICAgfA0KPiAg
ICAgfCAgICAgICAgICAgfCAobXMpICAgfCAobXMpICAgfCAgICAgICAgICB8DQo+ICAgICArLS0t
LS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLSsNCj4gICAgIHx3aXRoICAgICAg
IHwgICAgICAgIHwgICAgICAgIHwgICAgICAgICAgfA0KPiAgICAgfHJlY3ZiaXRtYXAgfCAgIDE2
ODI1fCAgICAgMTY1fCAgICAgNTI5Njd8DQo+ICAgICArLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0t
LS0tLS0rLS0tLS0tLS0tLSsNCj4gICAgIHx3aXRob3V0ICAgIHwgICAgICAgIHwgICAgICAgIHwg
ICAgICAgICAgfA0KPiAgICAgfHJlY3ZiaXRtYXAgfCAgIDEyOTg3fCAgICAgMTU5fCAgIDI2NzI2
Nzd8DQo+ICAgICArLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0tLSsNCj4g
DQo+ICAgICArLS0tLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLSst
LS0tLS0tLSstLS0tLS0tLS0tLS0tDQo+ICsNCj4gICAgIHxNdWx0aUZEICAgIHwgdG90YWwgIHxk
b3dudGltZXwgU1ZNICAgIHxTVk0gICAgfCBJT1RMQiAgfCBJTw0KPiBQYWdlRmF1bHR8DQo+ICAg
ICB8UVBMICAgICAgICB8IHRpbWUgICB8ICAgICAgICB8IElPIFRMQiB8SU8gUGFnZXwgTWF4VGlt
ZXwgTWF4VGltZQ0KPiB8DQo+ICAgICB8ICAgICAgICAgICB8IChtcykgICB8IChtcykgICB8IEZs
dXNoICB8RmF1bHRzIHwgKHVzKSAgIHwgKHVzKQ0KPiB8DQo+ICAgICArLS0tLS0tLS0tLS0rLS0t
LS0tLS0rLS0tLS0tLS0rLS0tLS0tLS0rLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tLS0tLS0tDQo+
ICsNCj4gICAgIHx3aXRoICAgICAgIHwgICAgICAgIHwgICAgICAgIHwgICAgICAgIHwgICAgICAg
fCAgICAgICAgfA0KPiB8DQo+ICAgICB8cmVjdmJpdG1hcCB8ICAxMzIzMTV8ICAgICAgNzd8ICAg
ICA4OTB8IDkzNzEwNXwgICAgICA2MHwNCj4gOTU4MXwNCj4gICAgICstLS0tLS0tLS0tLSstLS0t
LS0tLSstLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0NCj4g
Kw0KPiAgICAgfHdpdGhvdXQgICAgfCAgICAgICAgfCAgICAgICAgfCAgICAgICAgfCAgICAgICB8
ICAgICAgICB8DQo+IHwNCj4gICAgIHxyZWN2Yml0bWFwIHwgPjEzODMzM3wgICAgIE4vQXwgMTY0
NzcwMXwgOTgxODk5fCAgICAgIDQzfA0KPiAyMTAxOHwNCj4gICAgICstLS0tLS0tLS0tLSstLS0t
LS0tLSstLS0tLS0tLSstLS0tLS0tLSstLS0tLS0tKy0tLS0tLS0tKy0tLS0tLS0tLS0tLS0NCj4g
Kw0KPiANCj4gDQo+IEZyb20gdGhlIHRlc3QgcmVzdWx0LCBib3RoIG9mIHBhZ2UgZmF1bHRzIGFu
ZCBJT1RMQiBGbHVzaCBvcGVyYXRpb25zIGNhbg0KPiBiZSBzaWduaWZpY2FudGx5IHJlZHVjZWQu
IFRoZSByZWFzb24gaXMgdGhhdCB6ZXJvIHBhZ2UgcHJvY2Vzc2luZyBkb2VzIG5vdA0KPiB0cmln
Z2VyIHJlYWQgZmF1bHRzLCBhbmQgYSBsYXJnZSBudW1iZXIgb2YgemVybyBwYWdlcyBkbyBub3Qg
ZXZlbiB0cmlnZ2VyDQo+IHdyaXRlIGZhdWx0cyAoVGVzdCAzLjEpLCBiZWNhdXNlIGl0IGlzIGNv
bnNpZGVyZWQgdGhhdCBhZnRlciB0aGUNCj4gZGVzdGluYXRpb24NCj4gaXMgc3RhcnRlZCwgdGhl
IGNvbnRlbnQgb2YgdW5hY2Nlc3NlZCBwYWdlcyBpcyAwLg0KPiANCj4gSSBoYXZlIGEgY29uY2Vy
biBoZXJlLCB0aGUgUkFNIG1lbW9yeSBpcyBhbGxvY2F0ZWQgYnkgbW1hcCB3aXRoIGFub255bW91
cw0KPiBmbGFnLCBhbmQgaWYgdGhlIGZpcnN0IHJlY2VpdmVkIHplcm8gcGFnZSBpcyBub3Qgc2V0
IHRvIDAgZXhwbGljaXRseSwgZG9lcw0KPiB0aGlzIGVuc3VyZSB0aGF0IHRoZSByZWNlaXZlZCB6
ZXJvIHBhZ2VzIG1lbW9yeSBkYXRhIGlzIDA/DQoNCkkgZ290IHRoZSBhbnN3ZXIgaGVyZQ0KTUFQ
X0FOT05ZTU9VUw0KVGhlIG1hcHBpbmcgaXMgbm90IGJhY2tlZCBieSBhbnkgZmlsZTsgaXRzIGNv
bnRlbnRzIGFyZSBpbml0aWFsaXplZCB0byB6ZXJvLiAgVGhlIGZkIGFyZ3VtZW50IGlzIGlnbm9y
ZWQ7IGhvd2V2ZXIsIHNvbWUgaW1wbGVtZW50YXRpb25zIHJlcXVpcmUgZmQgdG8gYmUgLTEgaWYg
TUFQX0FOT05ZTU9VUyAob3IgTUFQX0FOT04pIGlzIHNwZWNpZmllZCwgYW5kIHBvcnRhqVwNCmJs
ZSBhcHBsaWNhdGlvbnMgc2hvdWxkIGVuc3VyZSB0aGlzLiAgVGhlIG9mZnNldCBhcmd1bWVudCBz
aG91bGQgYmUgemVyby4gIFRoZSB1c2Ugb2YgTUFQX0FOT05ZTU9VUyBpbiBjb25qdW5jdGlvbiB3
aXRoIE1BUF9TSEFSRUQgaXMgc3VwcG9ydGVkIG9uIExpbnV4IG9ubHkgc2luY2Uga2VybmVsIDIu
NC4NCiANCj4gSW4gdGhpcyBjYXNlLCB0aGUgcGVyZm9ybWFuY2UgaW1wYWN0IG9mIGxpdmUgbWln
cmF0aW9uIGlzIG5vdCBiaWcNCj4gYmVjYXVzZSB0aGUgZGVzdGluYXRpb24gaXMgbm90IHRoZSBi
b3R0bGVuZWNrLg0KPiANCj4gV2hlbiB1c2luZyBRUEwgKFNWTS1jYXBhYmxlIGRldmljZSksIGV2
ZW4gaWYgSU9UTEIgaXMgaW1wcm92ZWQsIHRoZQ0KPiBvdmVyYWxsIHBlcmZvcm1hbmNlIHdpbGwg
c3RpbGwgYmUgc2VyaW91c2x5IGRlZ3JhZGVkIGJlY2F1c2UgYSBsYXJnZQ0KPiBudW1iZXIgb2Yg
SU8gcGFnZSBmYXVsdHMgYXJlIHN0aWxsIGdlbmVyYXRlZC4NCj4gDQo+IFByZXZpb3VzIGRpc2N1
c3Npb24gbGluazoNCj4gMS4NCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL0NBQVlpYlhp
YitUV25KcFYyMkU9YWRuY2RCbXdYSlJxZ1JqSlhLN1g3MUo9YkQNCj4gZmF4RGdAbWFpbC5nbWFp
bC5jb20vDQo+IDIuDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC9QSDdQUjExTUI1OTQx
MjNGN0VFRkVCRkNFMjE5QUYxMDBBMzNBMkBQSDdQUjExDQo+IE1CNTk0MS5uYW1wcmQxMS5wcm9k
Lm91dGxvb2suY29tLw0KPiANCj4gWXVhbiBMaXUgKDEpOg0KPiAgIG1pZ3JhdGlvbi9tdWx0aWZk
OiBzb2x2ZSB6ZXJvIHBhZ2UgY2F1c2luZyBtdWx0aXBsZSBwYWdlIGZhdWx0cw0KPiANCj4gIG1p
Z3JhdGlvbi9tdWx0aWZkLXplcm8tcGFnZS5jIHwgNCArKystDQo+ICBtaWdyYXRpb24vbXVsdGlm
ZC16bGliLmMgICAgICB8IDEgKw0KPiAgbWlncmF0aW9uL211bHRpZmQtenN0ZC5jICAgICAgfCAx
ICsNCj4gIG1pZ3JhdGlvbi9tdWx0aWZkLmMgICAgICAgICAgIHwgMSArDQo+ICBtaWdyYXRpb24v
cmFtLmMgICAgICAgICAgICAgICB8IDQgKysrKw0KPiAgbWlncmF0aW9uL3JhbS5oICAgICAgICAg
ICAgICAgfCAxICsNCj4gIDYgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiANCj4gLS0NCj4gMi4zOS4zDQoNCg==

