Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D5CDC5B543
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Jun 2025 09:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uMkqQ-0003YH-9A; Wed, 04 Jun 2025 05:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMkqG-0003Xd-K3
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:55:29 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1uMkqE-00022k-0F
 for qemu-devel@nongnu.org; Wed, 04 Jun 2025 05:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1749030926; x=1780566926;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HjqOQ82tHZA/SffmB9yZMXXLms3whp0xOoLnaMpqJv8=;
 b=ZyzvGf1ymKy94aG5nimaSrr9/DtfRl5ylPU6sWxZUUQLQtJKafit9q/L
 3VgnFDraZpL5a6d4m45l8PA50gsoIsDcQmkhKR6EosuuWo9YWrguxqTWC
 /PAW063tv9R8SxkXh7ix5BS1gVF2VFkLdKrOeYB9y+Rylf4H6dBYdnD6Q
 StFign0dtCHVUeGTv7Fqjod6HTtyCIaQe8BakrOKeP6uJzBiz13QUOtdS
 XjoVc+Yq1QQPASVenB4zLVHpCW5Qk1yluIJbxrs/koDdbPWNN2cXHmEn4
 URjkFf54Y3EbTBGExBQUmm89DLtSmCgxM7b98TTsLmSgJ3E+Vo6m6qR6t g==;
X-CSE-ConnectionGUID: fMIOUqLSRSia5wZxop2wfg==
X-CSE-MsgGUID: 8ADtx9BdS+6CNNJ65PofoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62157202"
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="62157202"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:55:09 -0700
X-CSE-ConnectionGUID: pW/a7muQRNeGuRU+0bSN3w==
X-CSE-MsgGUID: /dVcSvYBSVWSBWcn9MR7tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,208,1744095600"; d="scan'208";a="145104329"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2025 02:55:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 4 Jun 2025 02:55:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 4 Jun 2025 02:55:08 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (40.107.94.53) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 4 Jun 2025 02:55:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vNcLD3OfewI5nGjSoz9mvBJFVpIkfecznxvN1MGnrq84X8Sc4kdIiX1EDLes0X9a3jWK7KMO6JjYOKDV8+CmuKBcqVQGA7Y9bscKITr3ci+cTyFfxlcNLeJIexLbSfGsonDViHOrd9kZgU/PUxiSB4cdu7/tLknGsoiUJghMm902WiOZaFAswP5iAqXVkhXHpL9bF7qt1lptS9/D4H+O343rVXuf87iebJd/nTBvXp4d+ZFCYGC8s/hoPlyzdP4Yq+ltgOkAEh15ALqGtibL5xRBxXWaqo3pjE8YZM7V+le8z6Mcs//CKsc9RVii8qJx1VxsgBt/3LQoKqCF45dRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjqOQ82tHZA/SffmB9yZMXXLms3whp0xOoLnaMpqJv8=;
 b=WsPB1Xe5wrydDatTR20MFITIZ3DnVACHrevSOZTmCoolbWjXStoZ7OdYVZ5S1ngvM6LUyFl8xh7pEe7zA9MtJycHKf95tZPH48Z8HzmYOl3jLLj8GmhmO6geTh0Q8lrH2smZfcIuAKt+RQpGMmKaaQqmqwwcXnpiYCsj73Yk6GvYzxaPJPXMGnk4zCiRTKNF48TLHHAlak4DHFMLNoO+9fjVWbdRs2/T1jEX3Wd/d2oDwIxLCbzoZ87MBIbYLFNjqmHcHfLed97pmKxSQfmg5KZK99/veDs6gMYcsmLdkUJ1wVnF9f/SQGQzDQrQTSwb5Y0rccpSBDTyZqzpBpiPMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB9136.namprd11.prod.outlook.com (2603:10b6:208:574::12)
 by DM4PR11MB5248.namprd11.prod.outlook.com (2603:10b6:5:38b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 09:55:06 +0000
Received: from IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13]) by IA3PR11MB9136.namprd11.prod.outlook.com
 ([fe80::604b:77a4:b1be:3f13%4]) with mapi id 15.20.8769.037; Wed, 4 Jun 2025
 09:55:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: David Hildenbrand <david@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Subject: RE: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
Thread-Topic: [PATCH] virtio-mem: Fix definition of VirtIOMEMClass
Thread-Index: AQHb1S3uVjr36/Og1kyf11sueVIyArPytSYAgAAARUA=
Date: Wed, 4 Jun 2025 09:55:06 +0000
Message-ID: <IA3PR11MB91365ECA05E4EA4A0F9D814E926CA@IA3PR11MB9136.namprd11.prod.outlook.com>
References: <20250604084757.4035354-1-zhenzhong.duan@intel.com>
 <d80f0f29-056a-4828-aec9-dccb7a3e23c6@redhat.com>
In-Reply-To: <d80f0f29-056a-4828-aec9-dccb7a3e23c6@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB9136:EE_|DM4PR11MB5248:EE_
x-ms-office365-filtering-correlation-id: 6c956e36-541d-47f2-39a0-08dda34de285
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dEp2Rng4S01QMktrendLT1JzbEd3d2JuVUR3WTJFR05ENXVXWk1Qc1QrdWZm?=
 =?utf-8?B?a21ycTBEN2ZyZ1VoSEkrWWk4M251cGgyekZEbHBaRkJUS1paQ1JVU1ZWNmRk?=
 =?utf-8?B?alRnNkdVSHRNMGxiYis1TmZEU0cwMzFjZnRHcmpkMUNaQ0NBbTM4ZkVGWTF5?=
 =?utf-8?B?S3h2bU8xWUhERVJ3cFpJRlNNQXpYanJadmhnMDhpdk9wR1hwSHlxU3RBM2pO?=
 =?utf-8?B?ekQxajBSR20zcWJ5NHoyVU5ZZjBoek1vbkNyK0lNaTNBWUhJZzNFcWJhSzJu?=
 =?utf-8?B?TThCWXBKcWtrTU1qWXhKaWNwdDVKeHVmQUdjYzJzR0k5d3pKTngyTnZRcDZB?=
 =?utf-8?B?U3lSaWx4VXJrd2dhUGFQcGZJRmtQdWJlVlM1RVh1TFZPZUFWazIxVlUvVzdv?=
 =?utf-8?B?dm02bGxNYTRwQ3NOY1BJUk5reDJGMTdKZWNuNlowZVU4eGNpbnRtNWpOd2Vt?=
 =?utf-8?B?NmlyWlpZNWQ3VDg1S0JuSEVMQmJ4UWZjNUlFam5Kc1kvcWZUS1FsNVZ4YVgr?=
 =?utf-8?B?Rnh4VlBXQkRxWWFtUm5aTzQ4QlNjY2NzZlorU2UrOHgwSlArNng0OVpxZktl?=
 =?utf-8?B?YnE5bUpqOHJSYzZOU0hSam0wNjViV0dLalByT1BzaHJPbUgvT3BDQUhaS1pK?=
 =?utf-8?B?ejR4VHptL09JOHFnUGlRWVp1OWNTY2hEbWw2clhiNU1uWWltYWZ1Tlhva2FO?=
 =?utf-8?B?cFhpcndkWW5QaTg3cHUzcm9mMnd1NnNYRHIwMkg4aU84Z1pkQk5WSHFiNHdJ?=
 =?utf-8?B?QzNXWG4xYzVzMFdxVHpRdFBpZ21tNGFuL1ZGVytLYzJydjYxb1daMTdZNkxF?=
 =?utf-8?B?TmlGaUlnbFl0RDByQVN5NzA3anpxaE9mb3RBdG9Wd3lkODRyUGJBNnhGb2JM?=
 =?utf-8?B?N1lFbkxGVU83UklJMEpqUEFtWXdPSld4dDlKdVdwNGZlZmV4WGRpRG8wUW1N?=
 =?utf-8?B?OGFVSldyZ3pOMEhlYjk3eFlKSmtNd1VhMlpJSmFMTll5NHlnTURYU3VzQUF5?=
 =?utf-8?B?YVcvWW8zU1ZJWjJXQnRtWDRuTDZMb1BJMU5kbDdwcnRMcTFMYU9BMHBmK21y?=
 =?utf-8?B?NG1ib0VOTWRkemhkRUxlSXY5Nk5HcW96K3YwekdGd05iS0ticnU3RkFZZnd0?=
 =?utf-8?B?MHRQRXpwcnh1M2lyV3l2YXoxR09oWXZGMHo4Q2p4Z29wRTZ3bG1pa09Mb2s5?=
 =?utf-8?B?ejZGWm42bElNaTRPallvalJLKzZJLzVsdmpSM3MyK1RyOGErZDZFVWNPMFow?=
 =?utf-8?B?MVNTaFRlTCsxTXNNdzE0cFhHNzNWTGdTc0dnSVo3QnN6czRPS1E1cFBPMVRT?=
 =?utf-8?B?N1JoYVFqbkFIT2k4OTllYm1KNVZqRmhLRmFlZ29ITGxGUnBQUXZuYVJPYk5w?=
 =?utf-8?B?MFQ5OHFBcXIwdWNYbFlOK2ZpRmxYOEQ3RHMydUhRZnVDTzlYbE5tRjkvZGFZ?=
 =?utf-8?B?bmpuSGJBTmNEeWZLSS9PUE1YektZZUNwQkhlbHlRQ2h1N0k1R3dXWVhqZ2Zl?=
 =?utf-8?B?L2JWdUFOcFNZMm9mTXk5M1RTbmg0MEFJV3BjSXF3WU9WTWRaTXMzc2VsK0Jm?=
 =?utf-8?B?dHhjcmJjWFVhak0vdy8vdkpEdVBNY3krWHZUT1FSY2gvWEdQVUhkK3hMTlpx?=
 =?utf-8?B?VzR3U1MvRHRpbzJlQUJUN0J1UHRRNXU2NlBFdU9ZS0xub285c0p2UUNmeTVX?=
 =?utf-8?B?cTE1ZldaYjh1Z05UR1ZHZSsxODh0MC9JS3dMLzU0MGZPemJuQXZId21IVjVi?=
 =?utf-8?B?VHZyUEJHOUlmcWc3cTVEeVhWMFl4LzdFNitQblh3ditkY3kwcnVBRG15MjFW?=
 =?utf-8?B?OFYyUW1rdTNqS3hsa2thVzQrOHZUTkp2YndmNGR1K2E0ZEFZcFJBdFplays2?=
 =?utf-8?B?ODFLVWxOZHl2biswL2JyMWdTSzhWd2RsS0syeXJZcUlyeWFHb3R0V2Y5eWFa?=
 =?utf-8?B?ZzVSOVVZek56aGowRWQyTS9VZ3VBVDZReTRqbFdRbWI3Zm9hL0xoOWNRTHVP?=
 =?utf-8?Q?i3zi3DK4EWFuvWZWYoQ0KnRIcY6DRI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA3PR11MB9136.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?czlQbjQ0SGNzV2hMU2hPVk5qVThEV0FUS2Zsc2M1ZjV2WWUrUDZJTHNTQzVw?=
 =?utf-8?B?STdpbHlqZnUrWWlZMVNFZGlBODVUdk9HWlRMa1dvY09YV1ZWVXRYb2tnVjFo?=
 =?utf-8?B?dkVQUVVVem9ONFFrclN1eHVONU5WWDRwQ2pMYkcveEJXdkRwNjJuamVNbXNp?=
 =?utf-8?B?czRYUVV6TEV1RXpGSWE2QnFzbmtRZzNSU3FOTkJ3MHFrRlJTaC90UktwWEJp?=
 =?utf-8?B?ZXVGMVQ5dzFuNnUvTUxsZnI2TEZXTWIzSWNMM010QWhMZDlyU0tWRmpwTEQr?=
 =?utf-8?B?RzZrbzNPSDQrU3pwTUNRMWVFUFE4cFZ5V21wR1llKzhuOElxUjIxYjhRNDMz?=
 =?utf-8?B?MzJ6am00NnJsNThCcGkrMGVpYnNHQlAxc2dDV2N1RkpHNVVvRktEaS9RTVoy?=
 =?utf-8?B?bmZ5cTdRdENCSWFFalEzelpkZUdodVFuRk4zOXlhTU9xRmt1T1Z0OGVOWEdX?=
 =?utf-8?B?MEhZNjU3aGNZWFRWRXF6dWcvTnZTc0p6OXNJbFovd044ei9ua2NVM1BOc3JX?=
 =?utf-8?B?Y0JocWh4TGlpOW16THBtWENPWGRJT0MwaUtqS2V6Yk0wT1NacnFhWnhsZFBF?=
 =?utf-8?B?MlgzNGlzRTNBdVJ1MjdSVVNWVlJPWnVXSlk1UWhzZWt2dGlYdnUxb0lsMlNR?=
 =?utf-8?B?Y0xBNGRJS1VXSFFrczRXWElXNUdFRkExR1djQjkwOFRQTWVYMFJSc2gwYmww?=
 =?utf-8?B?VkdJZmY0aVNJY0FOSThPUWUyUy9nRngwZjBiSTBRWnM5ODUyMnQ3TU9uQ1ZP?=
 =?utf-8?B?UDB3eGc0U3FraXZOT2pOWld3SWxtenFIblBCYjZoRllHQTRzbE1ZZGl1SS9a?=
 =?utf-8?B?VDVpYWhxYmtQVVVOV1VqbUxZWVJRMGlsZm5rc1RlU2ZxMEJVaU4vcXRHN0py?=
 =?utf-8?B?UjNuNDRrdFg1YTR3THRUNEJpQjM0dWZCNnZZT3Nyc0IvUjlwRnJBYVp2Zkx0?=
 =?utf-8?B?VlRRT3lUa05pa2lzUUphNG9iM20wNUUrd3IvV0V3b2dXWDM4dHFSTW9PbUpQ?=
 =?utf-8?B?eThXYk0yNk43QkdXUVJuUTlzN2greEYxVHFvaGo3ck5TNDJtNytnZ1JsazVL?=
 =?utf-8?B?dTNUM3gyWmM4WlRnOWdZejJwQ1YreG5Gdk9hTWkzRWgyZ2pHMmV1d1FRcWRh?=
 =?utf-8?B?a3Y3Ui9PMndhRit1UDhobkdxWGZIbHBYUXg1b3pSN0VGQ0lrT1hyTmJGZ1NG?=
 =?utf-8?B?dGVvcXVMM2p3R0oxWmdwYjdGK0FNeGxHT1M0b2hHR3BubTh5Ukwzam45NXF6?=
 =?utf-8?B?RXQvNm9rcXcxMUFUeCtuOGJ1WDNDS3oyeWkxa0RYejlzS1FGVTB2UU9wM0ZZ?=
 =?utf-8?B?OWQxZytoVStkT0NlY1JKRXFwdEdaWTFTU29XZTBOaTg4RnNuOWRoNzRjTkxL?=
 =?utf-8?B?S3VKdXVXQ2VCa2FwSE9RQUlJYWtHcUxoMENvUy9FTFFnOTVzSDdkSE1IWS9N?=
 =?utf-8?B?Tk50cmpFSHBPd3FGOGE4c1hVKzNaT0ZlVk9sSHM0eTBXczFPdFBqYnhyVzVj?=
 =?utf-8?B?NklGc0ZMbUt5aWE0OEhaNjBuYndyT1F3MU1IV0RKZjJ6UkRCdVdPeVcxSVpG?=
 =?utf-8?B?bGpNOHJYYjFYUkVremJ3ZGhmYVEyZllNM2xWR3VoaEdublNyNGxmSzBiVTVt?=
 =?utf-8?B?NHQrQjF0WHJuWjY1N09Qd3Zyc1NKRTVwUnlXUmptTElvanNBQ2pIS2RUdjVM?=
 =?utf-8?B?dklQM3lNOG45cXBjOWg4UjF1QnZlK0g1cVFZbTllb3l3ZHUzQm1CZ1N2T0xv?=
 =?utf-8?B?NFc0ZWY1UUx0TlZWTzhMeHpTNEcwYWZXTjh5NDd4VDYwYVIrVW9JVkRsQkxx?=
 =?utf-8?B?d1FobVhuNGdiMUhGWEJlcEJvMWlZZHZpN3kydkVSZkR2WlFsbUxraXI0OEg2?=
 =?utf-8?B?T2N5RVYwOUM3MGE3c0Nwek9XWi9LS01sMTdrdGNWL0tBVjRxbW5xMDRJa2ZK?=
 =?utf-8?B?aGQ0cUt6YVRjYno0cjV5c091WEpERGxTNkpZRzNEanJYVzFjQmRYSjdWdHF2?=
 =?utf-8?B?Snh3S1lnYndhck53Z3dTV2p5RFNvci95UUtIZCs2R3QwSGlEaDJMMFUxc0xs?=
 =?utf-8?B?cWptL21Bbzd4dUpDMDAxMlZGWW9LNGIrQlNaMCtmZGFSUUVjY25xSlZXeUY5?=
 =?utf-8?Q?vPeXLuxn5QWtrj0jGQRnAhcVk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB9136.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c956e36-541d-47f2-39a0-08dda34de285
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2025 09:55:06.4170 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2/e+1Mp8P0D14sIgNOStpK8N0fqY/w0dkz6yGUQczFst6gsepedDz+AJc33KZkNzrcmuv1l8/LF0cdIXhxlnGDfEQ/YobcA9MPjan6cREEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5248
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.128,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhdmlkIEhpbGRlbmJyYW5k
IDxkYXZpZEByZWRoYXQuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZpcnRpby1tZW06IEZp
eCBkZWZpbml0aW9uIG9mIFZpcnRJT01FTUNsYXNzDQo+DQo+T24gMDQuMDYuMjUgMTA6NDcsIFpo
ZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gUGFyZW50IG9mIFZpcnRJT01FTUNsYXNzIGlzIFZpcnRp
b0RldmljZUNsYXNzIHJhdGhlciB0aGFuIFZpcnRJT0RldmljZS4NCj4+DQo+PiBGaXhlczogOTEw
YjI1NzY2YjMzICgidmlydGlvLW1lbTogUGFyYXZpcnR1YWxpemVkIG1lbW9yeSBob3QodW4pcGx1
ZyIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50
ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaCB8IDIg
Ky0NCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaCBiL2luY2x1
ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaA0KPj4gaW5kZXggYmM0Zjc4Nzc3Mi4uOTNmZGY5ZTQz
MiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmlydGlvL3ZpcnRpby1tZW0uaA0KPj4gKysr
IGIvaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW1lbS5oDQo+PiBAQCAtMTM0LDcgKzEzNCw3IEBA
IHN0cnVjdCBWaXJ0aW9NZW1TeXN0ZW1SZXNldCB7DQo+Pg0KPj4gICBzdHJ1Y3QgVmlydElPTUVN
Q2xhc3Mgew0KPj4gICAgICAgLyogcHJpdmF0ZSAqLw0KPj4gLSAgICBWaXJ0SU9EZXZpY2UgcGFy
ZW50Ow0KPj4gKyAgICBWaXJ0aW9EZXZpY2VDbGFzcyBwYXJlbnQ7DQo+DQo+UmV2aWV3ZWQtYnk6
IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQuY29tPg0KPg0KPkkgYXNzdW1lIGl0J3Mg
bm90IGN1cnJlbnRseSBhIHJlYWwgcHJvYmxlbSBiZWNhdXNlIFZpcnRJT0RldmljZSBpcw0KPmJp
Z2dlciB0aGFuIFZpcnRpb0RldmljZUNsYXNzPw0KDQpZZXMsIHRoYXQncyB3aHkgd2UgbWlzc2Vk
IGl0Lg0KDQo+DQo+T3IgYXJlIHlvdSBhd2FyZSBvZiBhbnkgZXhpc3RpbmcgcHJvYmxlbXMgd2l0
aCB0aGF0Pw0KTm8uDQoNClpoZW56aG9uZw0K

