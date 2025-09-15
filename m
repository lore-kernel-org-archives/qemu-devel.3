Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21FBACAC597
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 18:08:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyDbV-0006bg-Ec; Mon, 15 Sep 2025 14:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uyDbT-0006bM-S8
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:07:03 -0400
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1uyDbP-00071D-0a
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 14:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1757959619; x=1789495619;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=cNWovp+7GKaokMOkrHiNd8TSAbEMsou4U4l5w0igwzo=;
 b=WjPmSSUmW3UXZPS9cjiZOR96sC8qlxBzFpODYBRp9flHFJzcAvxt2t89
 cAk2OB2NEAQTibEHk1TzzxszQPcXOQIbDCC4rFLTeH6Hepwu5CuJlSxoT
 Ypzc3pGBU/PF7aAAoOP4nHTWb+tL3ntxwGONFbCVXsqq0FdJIlx+/yIWC
 URykQThwwTRlkg81Qgbcvg31IhL4utEmyz/Ah5L3JgIBkbYDjb2gsrXGr
 cOfNlr9QHYaKQNCBDiv9dYvB9w0V5GUpVZt1DAegbk1TO2OS92Phu03l0
 tYQHqOiO9KqW6HPUeSoBiayrZRoYx8SbiUrto8ZQmeNnDEShBStG5jls4 Q==;
X-CSE-ConnectionGUID: Il5BrTIPS2C30Q/HHzOTPQ==
X-CSE-MsgGUID: Q2XjYngBQOO9Fk3N1qpNpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="47792552"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; d="scan'208";a="47792552"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 11:06:53 -0700
X-CSE-ConnectionGUID: jlNHFqOIQOy12BqM3yz0Ow==
X-CSE-MsgGUID: FCKltgBjSXCr/gyrLq7SAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; d="scan'208";a="175496220"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Sep 2025 11:06:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 11:06:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 11:06:52 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.38)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 11:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loDJGlIO5j8GhQ2Qqd/Uq9Bj/own3Le0nTtpicdmMmfsIyts4grdOOhfTW6R/KCDaUU8CuQIQ7tgqug7khWgo9ks0vBD6+14AOy2BifzBFwHZxxFZmmPq36aAgZBPpI2OkwyIW2WNz27PROTSEyKMjOwZYfSRq9h4ruoGkSHlBYtAaJnfbjUB0XjPnNR7iS0Fo8nOhxsGJ5C/Kf76zNsRvzKlGeS0dcQXZZe2qaalSjZ8STYtiQycK/oJf0OWzVR8LNfh7Cbh9UvjM9gkBirlhW402epQloDCUv0zxdbrxKmLvH0Bi1MDYMsciSSYvJaT0K/QmV6Mlj+4cN8wr0pdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cNWovp+7GKaokMOkrHiNd8TSAbEMsou4U4l5w0igwzo=;
 b=BtdEbQe7s2RmWlRKUMKaZiAzh9uplwEQbwEEZfXE9GBWom4d6vg/dsLg1kYckzAmk3XaFpPUwC2Kg9HcOshBxefE7mmB2yenWknMr2VDbxRgQgSb1Xw/ScYRWk0INM802adqa/i9s1oLCy4KocHgf1dtDYrX+/yUCpHiB1aGHMu7a7T+sVFP75JKFfFe3BY4IRNZL094D5ifEPXPphSL6ts0Vpq4wFFsJWaMNfkSGHFD0/DlxHgA61zbINsSOI8nVCNs5rGgW+TJfmInVgaSVuMLCMRoDz3rrsDalqCP2U7YUNz+vmlh8xveykLz1KFZmqJmLeyyMsG5wmSCgls2gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by SJ2PR11MB8452.namprd11.prod.outlook.com (2603:10b6:a03:574::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Mon, 15 Sep
 2025 18:06:49 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::dd3b:ce77:841a:722b%4]) with mapi id 15.20.9115.018; Mon, 15 Sep 2025
 18:06:49 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Dmitry Osipenko
 <dmitry.osipenko@collabora.com>
Subject: RE: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Topic: [RFC 4/6] virtio-gpu: Don't rely on res->blob to identify blob
 resources
Thread-Index: AQHcHJY2YKFPoBQc1k6SDELAvZKU07SFiqKAgAqO7zCAAj6KgIABcGJwgAAiyYCAAJKy0A==
Date: Mon, 15 Sep 2025 18:06:49 +0000
Message-ID: <IA0PR11MB7185820387F1F84BEF4C613BF815A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20250903054438.1179384-1-vivek.kasireddy@intel.com>
 <20250903054438.1179384-5-vivek.kasireddy@intel.com>
 <26c02124-eb57-4d50-bf8d-1fa809984adc@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185758D6CD5D2774E6373BBF80BA@IA0PR11MB7185.namprd11.prod.outlook.com>
 <43a98363-0607-42c6-906b-4f79e5740ea8@rsg.ci.i.u-tokyo.ac.jp>
 <IA0PR11MB7185329E174E270F6911FF03F815A@IA0PR11MB7185.namprd11.prod.outlook.com>
 <d107e7d4-f5cc-4714-b5f7-cd7d9a35dd6d@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <d107e7d4-f5cc-4714-b5f7-cd7d9a35dd6d@rsg.ci.i.u-tokyo.ac.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|SJ2PR11MB8452:EE_
x-ms-office365-filtering-correlation-id: 05ad919a-f033-47cc-3d44-08ddf482a441
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?OEJ2REFRbFVBdVRoYlhhTnVMNG82M0o5cklucHVPNE12cGpHU3BjVDZjV0dT?=
 =?utf-8?B?MWtsZkJVZDQ0S0taUHFkNVhiL1ZJUkpOcVJ0ZnVJUW5FSUZUQm9YRHZDdXdm?=
 =?utf-8?B?a2J0alMzdTVFbkVpSEtYeU9MSjNWcEFkbmppbVFvSXpUdUpRT1EyVmFzWGtP?=
 =?utf-8?B?M1BZYmJCd1NiVUpSRHIrZjVIU2d3RGk2bnN5eFJYM2FrbjRleEprRXNnN0Uv?=
 =?utf-8?B?WTRCL2I5MUJYcHVVUk9SMHptd0ZXUldpUEtOR2JOWHluS0FDRitxRndjLzFG?=
 =?utf-8?B?UEh4MjZjS3MxcDV6SDNmWGxwM2Y1bXE3TVppYkNVTUZLUTY1SUpIdVpFd0sz?=
 =?utf-8?B?MzlqUFlOVnhYbU1RWEtqV25JVXdVeTRocVJTbVZjTXdCR1R4RmxrOVZjMmtj?=
 =?utf-8?B?Zy9hbm1tQ0x2Q3pHakF2OVNaR0MyYVNmNkdUMjFjRDViMGsxNnRFQWIyNzFm?=
 =?utf-8?B?UWRncHo5bzY0UE1VQ2VRZVJXajliNkNHNVg5Y2RnSXJjQkF3a21YR3N4Zm9k?=
 =?utf-8?B?MnlJNGtQZkhnL3lKTkVReFU4UUQ0alQvTnJYNnF2SFdua3RWL1crazBWNnJo?=
 =?utf-8?B?Z0p5YmJVU2pwTG9WYVU0MmtUeUR3RDFBc0M0WVhOR1pQemp2NHB5UURKSklJ?=
 =?utf-8?B?VmdoSEwySUIwRFNoc1RVZWIyQWk2YnhMaFB0S25YN2lBVENhd3ZPTjBtTkxr?=
 =?utf-8?B?KzdleG5MVkJVL0JNRUZMWDNEV0FneWxSbzdJRmJLa0c5YkxBSVpxMEJCcEp6?=
 =?utf-8?B?SXRBRldlb0JoTlZaME9DL1VNcGt3V2Y3UmQ1VE1hYlJNU25VS09paFhRQS9L?=
 =?utf-8?B?Y2MrdGovQ2VycmF4Sk5la0RrNHVTRTl2c3ZkUUU1RHA4UkV3eERVVDJqMTAw?=
 =?utf-8?B?R25XOUMrQnU4ZEhIYjNNZTFNSm94SEhqbjkrM0FHMXgrdWsvS21kSU9EUWhT?=
 =?utf-8?B?T3VBRFVtWGJEdVFsUFFIQXlYd3g5RVVyZzJ3MWUrV3FObDVOdUNVdkZsekRL?=
 =?utf-8?B?UW9RcW9CeExHQzhVTkI3eVgrbTl3MkRoVUFPUDlYRGhYMVh5N2hpY0MrREtr?=
 =?utf-8?B?M1N4cXlqV1NTRjdzR3llWXhXMm9qb2FrckJIaGU1MndJc3g1QmZ1N2JmWTVO?=
 =?utf-8?B?aVllbDcyVVRGNmRBWGtrTjdkai9QdHd2YlpqT0pZSmZKTGxEMFBKUUhmWUh2?=
 =?utf-8?B?UGgwZ2dFeElnWDRFSUc4ajFZSnJtN3EzZ1dFQy9leDRYR2tJVlYvSzBMY3ZE?=
 =?utf-8?B?R0haa3piV0JqSEw3V0RXOW1USW9YNWNXeWw0TzVkVGpCQW5oZjBoNGRDL2Nz?=
 =?utf-8?B?b2p2WXNyNFA2MHVaTG9Jb1hvS1o3SGtib0VZT2ZNTFQ1U0NCQWZjQlYzN2dw?=
 =?utf-8?B?VUswRk5FUXROV2R4N2JvbTlNYTVaUy9aZHZZbFZZU2MzNXI4NUI2ZG4rK1VM?=
 =?utf-8?B?UTQvUm9ET241RENLcVk0TlQvdEl1VmN2aHZ2OE5CZDMvL2plekNwNllZUXNU?=
 =?utf-8?B?eVpENnAxdjN3SU9wbENQOEMvYVE1amtKNXMyZDA5ajRjWWZjWkRmR29VZlhx?=
 =?utf-8?B?TnFGakhMbzd1QXRoUmFySnYvand1bStlLzZQNlZ4RUxyV3VnSnJQcGZIeVdT?=
 =?utf-8?B?R0ZiOXduejZVSmU3aUg0S1RpUEI0N0FFUXZCdytrSGxMNkFCelpEWktTS0xj?=
 =?utf-8?B?SzE0VnFEUXVLbFZJbmwzNk81d0cvYkpkdU5zUk5IVVV5WjRJc1NMYVBjWFk1?=
 =?utf-8?B?b3dNZ0M5WTk3eEl4RWhtcUZ1UFFhZVZqaUdmY2ZONWdpY3lqT1NNWE1VeXp5?=
 =?utf-8?B?K1VZWWhtbXI3NktqdFFhb1dDTk16QTZWU1EzdHdpVmkyRnRRU1BWSlJxZzVy?=
 =?utf-8?B?YmZPUDBSU2hCSVZQUUpIdUJuWmRmbit0aWdUOHo2aWpKWlJBTVFKTmhDVSt5?=
 =?utf-8?B?VXdSc2JoMEVlMzNFQ0RqZjdLdmlZUEdZTWhIYXJBNnpsdlNROE9rQVlhZXVU?=
 =?utf-8?Q?u0sUTLYDyk/ZHzjvWpreKGPb66yfmI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N1ZlN0tUd1VJSzMvbTMyQk42VjlKN1BEM0lacUNTQUNtQzZrZFlZd2ZuWFRP?=
 =?utf-8?B?aC9WVktlSXowWlNBVVNTc0FKYXVHRDNGckRPamE1Z09nbklUb0dQRFZranB3?=
 =?utf-8?B?Vng2RjIvQ21vWlNuK0x3VDBwTlRaSW1uWWpBZTViSWFuUS9ER296ekF0ckRG?=
 =?utf-8?B?aDV3MnowZlAzcFJpOUZNQ1dKdGFiVDdMWHNmZDhCUHo2dGtwRHdLNDlweURr?=
 =?utf-8?B?VkM1M3hqY0NHa0VuQlhiQllmM2Zac2lZdHpxdHRDeE11UXEvVUUvYnhOUUNX?=
 =?utf-8?B?SjBBdjF3RFE1cUJDZnNtd2NRdlBlYkxXUkpoeUNWT0FDT0pGaWhoY1BQeXFh?=
 =?utf-8?B?T0k0Z1VGaEJuejA4YXh0RVVpNXRKdFY5azN6R29iZW5nR0hyek9xWHpsb20v?=
 =?utf-8?B?eUdnLzMrbCtoUXozRk9rQUlOMm05K1gzU3g4bTNkVzBjSUQyZjlnb01GdlhU?=
 =?utf-8?B?SGJsQmVPVUIwZEtSV3ZvU0h6aFoyYkpMdVVkd3Q5QnFNbG44VFJqU2JENmlv?=
 =?utf-8?B?Y1NLL05hVzltOFB0QUxXcHdjeTRvOVk4SEowdkp0V2dDL0JkOUptZmdZcTlK?=
 =?utf-8?B?Y1BCTHZNVkdZdGdXKy9ZTnV4dm5NcGlQZy8zL28wbDFmRkc1VUlWNFUydVlF?=
 =?utf-8?B?a1QxNE1naVVVdFNXdkVkR3k0dHMwc1Y4NlBpanZTV3llWG84VjZQTU9zSEda?=
 =?utf-8?B?UlY5WjIwV3Y4ZHd1bUIwQTNoS1JSM0Z1ZWg4NWxKd1BmZjMrUU9XYTRnVVda?=
 =?utf-8?B?NGlvaU1qMG4yc3lKSitMUmY3UnVrbWNVQnJLTThCc3JmLzVZR0dIOXpiM2Zz?=
 =?utf-8?B?UG5xSjRQSFFjRmdRMjVjWVhkNWhDZDVqay9CNjhvaEdBTitVT21Yc29lTmRt?=
 =?utf-8?B?YXYrNWlPd3VwYy9VV0NFUS9paEZ3RHovOG5tMUJGMXdVTlNudnRhc1FDdlFV?=
 =?utf-8?B?OGxCaUQyM2h5b2tTR0oxaW5YVVl6RW5iUHo2OGlUU3NMdEVCdmpzVnhGdldt?=
 =?utf-8?B?WU5TZUx4eXgvNDUvSnVSeFYwR09aNG5YYjhVYVVaUURzVlJDd2g4WnkrVkVI?=
 =?utf-8?B?QzlVRmwrVE5jcS9pR3RueGE5dFpXeXNvMkJRTkhjNVFQdVF4RWplOC9kOHRW?=
 =?utf-8?B?dDRZUmNIRndmVlVXaGNRZVFFMHNGRS92T3VsNFhtWnNUTVZTTVY1MVA5akhI?=
 =?utf-8?B?QStVWC9nek9vbGZ6SkxkbXk2QXhURnVDSVRsSzBMQWhPZDZsazIyVHdGd2g5?=
 =?utf-8?B?RGJKQVBVTW56ZWNhOTRUZ0VZVkM4OGhNRm1zckxya3BhNXNKYXlRQWJMdUp4?=
 =?utf-8?B?MTAvSFc0WXY3cmEraUwza0FzVVBpOHJyY2ZkbU5CNm5sZitEVWR3VlRzMHE3?=
 =?utf-8?B?dlFFYzRBTS9wVXA4Qk5HMnRiMGNEYVpnTmhuUS9mblJaR016RllLYzBIdFBF?=
 =?utf-8?B?elI1dXFDMnZtdEMyWDBnUHRwNFJWUmllOVk3U1dNT29DU29ueEd6TkZiSks2?=
 =?utf-8?B?ZU1BSGRpdkw0eDRqY1AwL0pKeG1IVkhRVFo5eEQ5ckd5Z3hHekdIOE4yemM0?=
 =?utf-8?B?VFNwSGhCWGxlWUZzNWZGUVhzTXBRdjVpN0cvT3EvbEx3SnRxazJsbVhua1VI?=
 =?utf-8?B?NUdZQjJlc1ZteVB5Zlo1Q0syelB0dk9OV25vSUwzV2FpMEhJb0tER0tqblhr?=
 =?utf-8?B?R1VQc2tlR1BDVU9HVDFSbk9YakovelhLQWh5SUx4cGh5bHBHQUoycXFQYldj?=
 =?utf-8?B?M2NGSDNVV3NGRlE3azdQY0pja3RaNkh0QjZGRmNSZXBJb1VhZzhZMnd2MCs1?=
 =?utf-8?B?cDNlV3E1Z3hIVmx4Sk5EUjQ3S2xZc0lQSTFnY2ZVTU40cDZNdHlMbGVDMnlH?=
 =?utf-8?B?MS82MXB5Tm5ZOG95WExBcXlDbmg3NWd3Qi8wajk2L2h1Qjc3VjArTnVYKzc4?=
 =?utf-8?B?Z2FsZ2pyaUtiZlZjbEZSVjFHZ0Z4YXpBeE9xL2tjTWZGeXQwTU8vdDNsSitQ?=
 =?utf-8?B?S2VkbHkvYXJyQzdEbDdBRmlWYWQ2ci85ZndLajEwelk5NTRrdGo5MkJHeFBr?=
 =?utf-8?B?Ni96QTlkdlIxazdhZE95N29IMTF2TUZhTnIyekxSVlhYRFlNQkQwZkZXaExR?=
 =?utf-8?Q?qwv+1xUQWHT7nQsWEN2chKMcR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ad919a-f033-47cc-3d44-08ddf482a441
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2025 18:06:49.4573 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nHUTcexBwTNdmnPY9+BXsFgL0b8wEDWrYU4Jp22LNXo3X78+iUob/3Zt75kJYL3mylgwYcuHW2LbshYCGy3TrLo1spja1J8ora4wEBzBuwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8452
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

PiBTdWJqZWN0OiBSZTogW1JGQyA0LzZdIHZpcnRpby1ncHU6IERvbid0IHJlbHkgb24gcmVzLT5i
bG9iIHRvIGlkZW50aWZ5IGJsb2INCj4gcmVzb3VyY2VzDQo+IA0KPiBPbiAyMDI1LzA5LzE1IDE1
OjMzLCBLYXNpcmVkZHksIFZpdmVrIHdyb3RlOg0KPiA+IEhpIEFraWhpa28sDQo+ID4NCj4gPj4g
U3ViamVjdDogUmU6IFtSRkMgNC82XSB2aXJ0aW8tZ3B1OiBEb24ndCByZWx5IG9uIHJlcy0+Ymxv
YiB0byBpZGVudGlmeSBibG9iDQo+ID4+IHJlc291cmNlcw0KPiA+Pg0KPiA+PiBPbiAyMDI1LzA5
LzEzIDExOjQ4LCBLYXNpcmVkZHksIFZpdmVrIHdyb3RlOg0KPiA+Pj4gSGkgQWtpaGlrbywNCj4g
Pj4+DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtSRkMgNC82XSB2aXJ0aW8tZ3B1OiBEb24ndCByZWx5
IG9uIHJlcy0+YmxvYiB0byBpZGVudGlmeQ0KPiBibG9iDQo+ID4+Pj4gcmVzb3VyY2VzDQo+ID4+
Pj4NCj4gPj4+PiBPbiAyMDI1LzA5LzAzIDc6NDIsIFZpdmVrIEthc2lyZWRkeSB3cm90ZToNCj4g
Pj4+Pj4gVGhlIHJlcy0+YmxvYiBwb2ludGVyIGlzIG9ubHkgdmFsaWQgZm9yIGJsb2JzIHRoYXQg
aGF2ZSB0aGVpcg0KPiA+Pj4+PiBiYWNraW5nIHN0b3JhZ2UgaW4gbWVtZmQuIFRoZXJlZm9yZSwg
d2UgY2Fubm90IHVzZSBpdCB0byBkZXRlcm1pbmUNCj4gPj4+Pj4gaWYgYSByZXNvdXJjZSBpcyBh
IGJsb2Igb3Igbm90LiBJbnN0ZWFkLCB3ZSBjb3VsZCB1c2UgcmVzLT5ibG9iX3NpemUNCj4gPj4+
Pj4gdG8gbWFrZSB0aGlzIGRldGVybWluYXRpb24gYXMgaXQgaXMgbm9uLXplcm8gZm9yIGJsb2Ig
cmVzb3VyY2VzDQo+ID4+Pj4+IHJlZ2FyZGxlc3Mgb2Ygd2hlcmUgdGhlaXIgYmFja2luZyBzdG9y
YWdlIGlzIGxvY2F0ZWQuDQo+ID4+Pj4NCj4gPj4+PiBJIGd1ZXNzIHRoaXMgY2hhbmdlIG5lZWRz
IHRvIGJlIGFwcGxpZWQgYmVmb3JlICJbUkZDIDMvNl0NCj4gPj4+PiB2aXJ0aW8tZ3B1LXVkbWFi
dWY6IENyZWF0ZSBkbWFidWYgZm9yIGJsb2JzIGFzc29jaWF0ZWQgd2l0aCBWRklPDQo+ID4+Pj4g
ZGV2aWNlcyI7IHdpdGhvdXQgdGhpcyBwYXRjaCwgdGhlICJjcmVhdGUgZG1hYnVmIiBwYXRjaCB3
aWxsIHByb2JhYmx5DQo+ID4+Pj4gY3JlYXRlIGFuIGludmFsaWQgYmxvYi4NCj4gPj4+IE9rLCBt
YWtlcyBzZW5zZS4gSSdsbCBtb3ZlIGl0IGVhcmxpZXIgaW4gdGhlIHBhdGNoIHNlcmllcy4NCj4g
Pj4+DQo+ID4+Pj4NCj4gPj4+Pj4NCj4gPj4+Pj4gQ2M6IE1hcmMtQW5kcsOpIEx1cmVhdSA8bWFy
Y2FuZHJlLmx1cmVhdUByZWRoYXQuY29tPg0KPiA+Pj4+PiBDYzogQWxleCBCZW5uw6llIDxhbGV4
LmJlbm5lZUBsaW5hcm8ub3JnPg0KPiA+Pj4+PiBDYzogQWtpaGlrbyBPZGFraSA8b2Rha2lAcnNn
LmNpLmkudS10b2t5by5hYy5qcD4NCj4gPj4+Pj4gQ2M6IERtaXRyeSBPc2lwZW5rbyA8ZG1pdHJ5
Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IFZpdmVrIEth
c2lyZWRkeSA8dml2ZWsua2FzaXJlZGR5QGludGVsLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+
ICAgICBody9kaXNwbGF5L3ZpcnRpby1ncHUuYyB8IDE5ICsrKysrKysrKysrLS0tLS0tLS0NCj4g
Pj4+Pj4gICAgIDEgZmlsZSBjaGFuZ2VkLCAxMSBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygt
KQ0KPiA+Pj4+Pg0KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvZGlzcGxheS92aXJ0aW8tZ3B1LmMg
Yi9ody9kaXNwbGF5L3ZpcnRpby1ncHUuYw0KPiA+Pj4+PiBpbmRleCAwYTFhNjI1YjBlLi4yZjkx
MzNjM2I2IDEwMDY0NA0KPiA+Pj4+PiAtLS0gYS9ody9kaXNwbGF5L3ZpcnRpby1ncHUuYw0KPiA+
Pj4+PiArKysgYi9ody9kaXNwbGF5L3ZpcnRpby1ncHUuYw0KPiA+Pj4+PiBAQCAtNTcsNyArNTcs
NyBAQCB2b2lkIHZpcnRpb19ncHVfdXBkYXRlX2N1cnNvcl9kYXRhKFZpcnRJT0dQVQ0KPiAqZywN
Cj4gPj4+Pj4gICAgICAgICB9DQo+ID4+Pj4+DQo+ID4+Pj4+ICAgICAgICAgaWYgKHJlcy0+Ymxv
Yl9zaXplKSB7DQo+ID4+Pj4+IC0gICAgICAgIGlmIChyZXMtPmJsb2Jfc2l6ZSA8IChzLT5jdXJy
ZW50X2N1cnNvci0+d2lkdGggKg0KPiA+Pj4+PiArICAgICAgICBpZiAoIXJlcy0+YmxvYiB8fCBy
ZXMtPmJsb2Jfc2l6ZSA8IChzLT5jdXJyZW50X2N1cnNvci0+d2lkdGggKg0KPiA+Pj4+DQo+ID4+
Pj4gSSBkb3VidCB0aGF0IHJlamVjdGluZyBhIHZhbGlkIGJsb2IgZHVlIHRvIGFuIGltcGxlbWVu
dGF0aW9uIGNvbmNlcm4NCj4gPj4+PiAod2hldGhlciB0aGUgYmFja2luZyBzdG9yYWdlIGlzIGlu
IG1lbWZkKSBpcyB0b2xlcmF0ZWQgaW4gdGhlDQo+IHNwZWNpZmljYXRpb24uDQo+ID4+PiBBcmUg
eW91IHN1Z2dlc3RpbmcgdGhhdCB0aGUgd2hvbGUgaWYgKHJlcy0+YmxvYl9zaXplIDwgKHMtDQo+
ID5jdXJyZW50X2N1cnNvci0NCj4gPj4+IHdpZHRoICouLi4NCj4gPj4+IGNoZWNrIG5lZWRzIHRv
IGJlIHJlbW92ZWQ/IEkgdGhpbmsgaXQgaXMganVzdCBhIHNhbml0eSBjaGVjayB0byBlbnN1cmUN
Cj4gdGhhdCB0aGUNCj4gPj4gYmxvYg0KPiA+Pj4gc2l6ZSBpcyBiaWcgZW5vdWdoIGZvciBjdXJz
b3IuDQo+ID4+DQo+ID4+IEkgcmVmZXJyZWQgdG8gIXJlcy0+YmxvYiwgdGhlIG5ldyBjb25kaXRp
b24uIEl0IHJlamVjdHMgYSB2YWxpZCBibG9iDQo+ID4+IHRoYXQgaXMgYmFja2VkIGJ5IFZGSU8u
DQo+ID4gVGhlIHByb2JsZW0gaXMgdGhhdCBmb3IgYmxvYnMgYmFja2VkIGJ5IFZGSU8sIHJlcy0+
YmxvYiBjYW4gYmUgTlVMTCBidXQNCj4gdGhpcyBmdW5jdGlvbg0KPiA+ICh2aXJ0aW9fZ3B1X3Vw
ZGF0ZV9jdXJzb3JfZGF0YSkgaXMgcmVseWluZyBvbiByZXMtPmJsb2IgYWx3YXlzIGJlaW5nDQo+
IHZhbGlkLiBUaGF0J3Mgd2h5DQo+ID4gdGhlIG5ldyBjb25kaXRpb24gIXJlcy0+YmxvYiBpcyBu
ZWVkZWQgaGVyZSB0byBjaGVjayB0aGUgdmFsaWRpdHkgb2YgcmVzLQ0KPiA+YmxvYi4NCj4gDQo+
IEkgdW5kZXJzdGFuZCB0aGUgaG9zdC1zaWRlIGltcGxlbWVudGF0aW9uIGRpZmZpY3VsdHkgdG8g
c3VwcG9ydCB0aGlzDQo+IG9wZXJhdGlvbiBmb3IgVkZJTywgYnV0IHRoZSBndWVzdCBtYXkgbm90
IGJlIHByZXBhcmVkIGZvciB0aGUgZmFpbHVyZSBvZg0KPiB0aGUgb3BlcmF0aW9uIHNvIHdlIHNo
b3VsZG4ndCBzaW1wbHkgcmVqZWN0IGl0Lg0KSSB0aGluayB0aGUgd29yc3QgY2FzZSBzY2VuYXJp
byBoZXJlIGlzIEd1ZXN0IFZNIHRoaW5rcyBpdHMgY3Vyc29yIGlzIGJlaW5nDQpkcmF3biB1c2lu
ZyB0aGUgaW1hZ2UgaXQgcHJvdmlkZWQgYnV0IG5vdGhpbmcgZ2V0cyBkcmF3bi4gSSBndWVzcyB3
ZSBuZWVkDQp0byBzZXBhcmF0ZWx5IGZpZ3VyZSBvdXQgaWYgdGhlcmUgYXJlIGFueSBhbHRlcm5h
dGUgc29sdXRpb25zIHRvIGFkZHJlc3MgdGhpcw0KaXNzdWUgKHN1Y2ggYXMgcmVuZGVyaW5nIHRo
ZSBjdXJzb3Igb24gdGhlIEhvc3Qgc2lkZSkuDQoNCj4gDQo+IEJ5IHRoZSB3YXksIHBlcmhhcHMg
aXQgbWF5IGJlIHBvc3NpYmxlIHRvIHByb3ZpZGUgcmVzLT5ibG9iIGZvciBWRklPLg0KPiBTaW5j
ZSAiW1JGQyAzLzZdIHZpcnRpby1ncHUtdWRtYWJ1ZjogQ3JlYXRlIGRtYWJ1ZiBmb3IgYmxvYnMg
YXNzb2NpYXRlZA0KPiB3aXRoIFZGSU8gZGV2aWNlcyIgY2hlY2tzIG1lbW9yeV9yZWdpb25faXNf
cmFtX2RldmljZSgpLCB0aGUgVkZJTw0KPiBiYWNrZW5kIHByb3ZpZGluZyB0aGUgYmxvYiBzaG91
bGQgc3VwcG9ydCBtbWFwKCkuDQpUaGUgcHJvYmxlbSBpcyB0aGF0IGZvciBkbWFidWYgaW1wbGVt
ZW50YXRpb25zIGluIHRoZSBrZXJuZWwsIHByb3ZpZGluZw0KbW1hcCgpIHN1cHBvcnQgaXMgb3B0
aW9uYWwuIEFuZCwgdGhlIGN1cnJlbnQgdmZpby1wY2kgaW1wbGVtZW50YXRpb24gKHRoYXQNCnBy
b3ZpZGVzIGRtYWJ1ZiBmZWF0dXJlKSBkb2VzIG5vdCBzdXBwb3J0IGl0IGFzIHRoZXJlIHdhcyBz
b21lIHB1c2hiYWNrLg0KU28sIHJlbHlpbmcgb24gcmVzLT5ibG9iIGFsd2F5cyBiZWluZyB2YWxp
ZCBpcyBub3QgZ29pbmcgdG8gd29yayByZWdhcmRsZXNzLg0KDQpUaGFua3MsDQpWaXZlaw0KDQo+
IA0KPiBSZWdhcmRzLA0KPiBBa2loaWtvIE9kYWtpDQo=

