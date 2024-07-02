Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14E3C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 05:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOWRb-0007yA-I3; Tue, 02 Jul 2024 01:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRZ-0007xh-Sl
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:45 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sOWRX-0006Tu-FZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 01:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1719899563; x=1751435563;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=X34qgNpvmNLKL+VXXKfSHCmNzf0ODL2lEPqu6K2/sUk=;
 b=DnGW/Ib7PTl8KO3qkyP9rYsbzsqc5ZJ4nLOJ/aNlkjB/rYycFp9Df1+w
 8Aq0EzA68FtxRpNA/+wQmanFmZLi45k2xGRYjU0tBx6z60HGkjXaERTUW
 Kkd368hUYicGZ5owsvjQ7/Kp+dEU+Ai1O3PK8lr6sbXXPhLz0dU36Vrdt
 kXxla6vcU7H1fDmdbhuMzt9IgGr1aJpG5f6gUpjcTgFrbS1uTY1B0ZJ69
 N6xOyx1eX9jQZKe3BTeaiSD8IUImZMWVRwCig4XL5QtPRndD5tlG6uQ6o
 4aPutnvxyqyxNDjqLf3UeFqKDvW6gEdM7T071BbJKvCAjyzYsK0zbvHdy g==;
X-IronPort-AV: E=Sophos;i="6.09,178,1716242400"; d="scan'208";a="15721584"
X-MGA-submission: =?us-ascii?q?MDGPKMREWgFGgTAMo+3y5D5JyNVVxl2/mN6Qc5?=
 =?us-ascii?q?509DPEPtB7TwqH82iMT/PLsAbt4GGfSY+5lTLK3NgBPK+ePk3zM7j/5L?=
 =?us-ascii?q?KXA/wqkPlm2SLgTBe+mPgOVsHM7iM9N5uODf/ey3shMomLMpQ2xbEM8P?=
 =?us-ascii?q?A0s321GA+v28fplcQ1RGxZNw=3D=3D?=
Received: from mail-am6eur05lp2111.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.111])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 07:52:37 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=co9Z/CYgKHX9RPFwBfrKbD5WC0ggKBy7Wi4y/miFKWxjZi9ffVL+EGzXzWFroprsvdY61NqdSEe1z8CiW6BOhhwJCjAI8juHsGqG/cn+FBKlUgx4yW6xdCp8nsleUUxxEFjI5tZbBLH9uUdvt4D5XnKjIpQRuXmzE3+uMClpyPbL41kyyLJQ+rP7h6kZ2MhWqLsQuYqrMWkpBg7PK0u5zoF9dgdkDuLktveHWO7RrGiUwzW2m4FO3AMj13Ls8Qvy9lzT02Xt/kSGYChJz2cvvBhwmjSjzp5BPfLUF7YK0RR1nDuci+koz7kwdRb4NanjLZHeFq/1il3I1xH3E3ATGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X34qgNpvmNLKL+VXXKfSHCmNzf0ODL2lEPqu6K2/sUk=;
 b=IJ1Wn2YTyh7uK8gma+7YJdqnsMm7dOhdGT38HlJQWiVwkAU0qamSw914nkpIghfh6MWS05liWUW3TZcIzt0auH3qVmmo7QlDbgxnR4GU/2nP2aUt0K2R/5vlNVpBRK5wl/SxQ1Dq7hmI44lZM/CUX2fi1xJ/7p6GzLN1LoG1XTSgkaSB5PnGrQbgU+Ut6GV9MjLIvnB821nOOcSe03ktdR6iK/3O06siQGVujQizF/ggeaeKAftZptzkRbMtC7QxcqlL0O2LZThgVHmgaIkonjEXMTMt06VGYYX5PxXONP0TRGvBmMZ020rqFJwM6oQjsTU25AJQsvZaYWxF5YgLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X34qgNpvmNLKL+VXXKfSHCmNzf0ODL2lEPqu6K2/sUk=;
 b=Me69v9Z/Ek8ag95LIQPXDWv1s25s40NyOooihjpNU/dESGOgw/xpb5XPnn/nj6F3J7N0qgyFaNbjtvhHsPb/qOoTXhS2/AkrMZiRGomQKGngdGRpruxSNiakmcT0m6zEQr31fLG34rMVSjsNwmBUixoEW+201Z3G2Of4k/0dH11/SAJz5pMo2ZbXRo7RuZgnWrjvdXOvr0UiA3TP7W0wXm/KLQ9vYCrE/7VQgKrqHqM8KXwEvCykpN4Wkp/NllWYl0YMKYAuGbkfJrJ52QN8xazP5C3bWhR7qR0DYNbryMhXdsV2AolAtReP7dStJOLC/nXV2f3CLhll276JSJ1yyQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7080.eurprd07.prod.outlook.com (2603:10a6:20b:239::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.21; Tue, 2 Jul
 2024 05:52:35 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7741.017; Tue, 2 Jul 2024
 05:52:35 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID capability
 for a pcie device
Thread-Topic: [PATCH ats_vtd v5 06/22] pcie: add helper to declare PASID
 capability for a pcie device
Thread-Index: AQHazEQJfH+RmlRl2EizMPPk04nn5A==
Date: Tue, 2 Jul 2024 05:52:35 +0000
Message-ID: <20240702055221.1337035-7-clement.mathieu--drif@eviden.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7080:EE_
x-ms-office365-filtering-correlation-id: 10ab6147-d96d-4b17-b32e-08dc9a5b2c37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bHZZWmlFbmVMNmJGR0ZNWCs2citVRUdhZE5jenB2UjRmbjh5RWVoWDZFZ21i?=
 =?utf-8?B?QmErOElpSkk5Qnp4ZmN3K3U4YmwrbVV6WHFyL05ISk9hOXYwd3V3NDNYdURR?=
 =?utf-8?B?Nkp3SjFQUUdkZVEwLzE2dUlMQUp4Z1hQczlNeWkzRW8vUmNRVGROQytFQzk3?=
 =?utf-8?B?N3c4ZmVuRHJDaEQzWTdZMHJyV2Z6ZEFaWG5ybkovN3JOWG5LK1BiVXRPQTZN?=
 =?utf-8?B?elpuRW9TbzJXZE9yNnF6WDVkNENPc3cyZDJqVjl3c1N1UzJmcGZWTG1zVGN4?=
 =?utf-8?B?MFBZRUNvZTg3QnZLOWtic2R0NytPS2d4WWk2NjRsUm5qbmV1NXVlcCtUeFY4?=
 =?utf-8?B?cUp2YVQzdlMxTzl1bTFnUjZqRDhIdEJDQi9GM0dqcVduaVMvNEpib1VlM1dB?=
 =?utf-8?B?R0hYUzVJMVYxTyt3M0FVNVlJUFozQ1V5MjRWMGE0RGkyME50TTNTRS9YMUJF?=
 =?utf-8?B?YlZOUHpBRitQNTZla090Vk9rUFJLWjMvMENlOGF5anFRcXozWkk0UlpJZGU2?=
 =?utf-8?B?ZTQ1ZjdieG8yc3MzMUw3SWVjMFVxYjlVNWs1c0E0VmZ6SWJxeUNPb2NTY0kz?=
 =?utf-8?B?RW5od2JvZWVaaVBKZVI4S3BMN0VkQWNFV0YvT0ZMMGZvZFZEWTlBU1o0QkJn?=
 =?utf-8?B?a0lhY1U4MWt6TmJ1R1lBRkhZYXZOZ1lUY2F5QjJtQ2ZPZFpkOFFIMCtOeHFn?=
 =?utf-8?B?SzZjVXZtNC9FeTRhQ1ZrY042c2FzNDlrd0Z2TlBpdFZYWlduV2owekR0U0Zy?=
 =?utf-8?B?NHI4ZkY3OXp1VE41bkxQZEFYYUtkV2Z5MDNwMDhnSEdBbTNCTFl1TmZVS2sx?=
 =?utf-8?B?QSthWjFLNVhxUzZHZ0pvSUJIa3hOUmw1MnlLc2Vrbm94ejUwQ1ZTeGpEZUdi?=
 =?utf-8?B?Y3lMTTlLaUQ2aWxJUWhlS1BTRDNwRWxkOG9FelJickdJeVZDNG94TlVvZjM4?=
 =?utf-8?B?dmN6VXJsQk5DTlNzQkJrbXhyZFdnZ2Q0NzdhSU85VGVqazBrRWZVT242dlFz?=
 =?utf-8?B?cGtCZHhlVm9xRC9BdlU1aVRyTkQ2c1NRZ2pwa0wrT052T3FRbVJ6ME5XeUdh?=
 =?utf-8?B?RmZYVDhDQmZ5OVlYWXg4dFE5YlNOclFNUCtsdWQ3QTdvNlJTcVN6VkZESkw2?=
 =?utf-8?B?TzIrRDR1NzMxeFBYNDZwVTd5L0NHTG1mMHp2OW5mbEFCdU1sN05tMldxajdl?=
 =?utf-8?B?NFkxaVF1NHZJMHdzZFIzKzUzOXRWMHdzNUNMYVkwVVVFY3RmQlZSYjE4aEg0?=
 =?utf-8?B?MHlmRXk3U20zb0RkWVZ3eHhEQlBsbVRHM2hvQVdrY25lbHQ4KzZhOEkyTkFl?=
 =?utf-8?B?WkhuYyt0Q3VXRkNKQjlBWTZ3Vnk1WXAwRHhGbnJvUk1kQ0h6dUdZN201bDFY?=
 =?utf-8?B?Z0JiV2QyemszU0tOQ2VuMlBJdXY2L2gxSi9HM3dlQnBPYnFmbEJqdFlJczIz?=
 =?utf-8?B?RlVneHBlYzhLTkhOUVN1MzArT1ZyTWxtbGU5T2xqbi80cWRFOEVTQTdSYmhz?=
 =?utf-8?B?bmp3bXRHbE9qRjc2MVhyYWZYTE1CZU14TFZ2QmFxbCtWekh2WUdyemQ5VFZr?=
 =?utf-8?B?d3V6RUk0MDZlbzJXM0FWYjRlMkNjRGNRQ0JKZmZyN3hNV1JSQXRleVBFbHRP?=
 =?utf-8?B?bHoreE9sbGh3Z1RRbW93d2pwN0R1YVlvL0taemZXdjkwQ2pVM3U0WGZycUFT?=
 =?utf-8?B?Rkd4ckxma1JtaFJHYmFJNUg3Ryt5RUJMc3p3bHkwNHJ5NGN1aE4ybXFDVTRm?=
 =?utf-8?B?V3V6cWFGQS83T0k0aWdXcnhoMVV3Z2lMRmdsZlhpQUU0RVJOVjRqdjE5cUsz?=
 =?utf-8?B?SXJsbnNTS3pUczFvZ20veHlkOG9LSWowQ3EraVNqdmlqeThac0MyaE1DZTJt?=
 =?utf-8?B?TkhLZHpoaFg5K3c1L24rZVkzOS9CRDNLNTFaZWFGcE9UQ3c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1FIaktXdXkzcnhjQ01KQ0hMblBzNzcrYjdIUmRrT2tuQjZvVnJTdmlYalE3?=
 =?utf-8?B?d3Y3cjNZZHFXSkdVK2lSUER1YkUxaEdVS1dSKzQwZzBNcXM3RnRpY2Z4SWFG?=
 =?utf-8?B?cGxGTjBzK25VNTRSa1VlZy9TR012M1hYcG0wTzhYMTg5TVpnaE02OW9JT0Fh?=
 =?utf-8?B?Q1grdUZZeG5yTWFFWkRxT000amdQbGhYSmlKMWpiVlFKRTVnai94aVBYdnFI?=
 =?utf-8?B?MlhQcWRjQWdtRXh1bVZmb3dIelRjb1I2ZS9nK3k3b3BWK2cxSG5ub1ZVMEJJ?=
 =?utf-8?B?Wk9qTzFYOUFudzBidDFwZ1RFSE5FVXVrYlhMSFA5MWVHRDRkc0cwU0lmc0NQ?=
 =?utf-8?B?MmFxa3pLeGNaalZybGpEdXM1ODVNU2ZBVzZ5cjZDcU4xT0t0dVcvRGtCQk8w?=
 =?utf-8?B?ajVaVm5OZHRHR2VzSEplNHN1RlJyU0V3NWp6Wk9MSnJTRW5hZkthM0IzUHA2?=
 =?utf-8?B?dE1nVFQ4d01sRFltdGlsU09lcjRVb3RxcUYwVnJoSjFWeHBLSkF2aEpxWTJ6?=
 =?utf-8?B?NFhXMjd6aG1veUlBSjVKMUlKTlA1UGM2aEtPanVmTHJYOUxvZUw0T04zRXpI?=
 =?utf-8?B?WDI5QW1Rdkt5bk5lQ0pqb0w4WUswUitOQTdqUG5LdHBBSENyU09DNDlRMTYz?=
 =?utf-8?B?M2IvbXNTb25IYVM2dDZBaTlaVlpOSFZ0WlpIR0dzQXFvWDJ5ZVBBNk9Cc2gv?=
 =?utf-8?B?ekdZVGdKeVdXZDVLUWNFNWJQa0xvb3FNZXlKR3FpT3hiaXhGdkdlOXpSOEJv?=
 =?utf-8?B?SFlPbVphMjZNdktJRDN0ZVZmbEN3NXZuQ29laVBvTzVCOXFlUEZod3NCZVFY?=
 =?utf-8?B?VTg0Tm5tWnB2Z1VPajByUHEvUzd4OXhnM3BGakNyY3ZoRzhnY2RwNGZxRFdR?=
 =?utf-8?B?VkZodzk3bDd3d2UvM2t5eGRSTjdyS05VMVU5U3BkUzdsd29GODlrRGtBZzFh?=
 =?utf-8?B?ZWptYUxUblRXbTF5MWtBbm1yUEk4ZkxxUFdGOHRUK1hnRUpVZy9SWVFwMTgv?=
 =?utf-8?B?QUE3UWRHcEtDOUtOMEpyU0RuRVRhYnBDTjNRUnN3TEIwYW1ITktRS2JPU0VG?=
 =?utf-8?B?MlJ4OG83N2hLMnRZVXNrK0Q5dGVKVDkxWUlOQTlVNjlTNnFzSWJLVWh6ZjdX?=
 =?utf-8?B?UVdVOGs2MGNBZUl0dHNUZjlST0tiOU8rSXc1emFZN3BBM2F0YUU0MnM1eDdB?=
 =?utf-8?B?NS9ZRTNjWXlIa24ySkJUamtBVTAwNTd5REJvZlZNTG1ET1pDV2h2cXFNS3lH?=
 =?utf-8?B?b25KanVtKzZrc2ZvTExpc0dTUVMyanJ2UllzNGsvYTE4a3R6L1M1RGxxWkcr?=
 =?utf-8?B?di84RFZSRlMreHNsQTQ5eTkxazhEUkN3SDJpYzlRTlRmakhEMG1Xem9TUjRl?=
 =?utf-8?B?QjBQdjc1RHNjVTYvVVVHeXFQOVJ1elVQT1JNQ05hR29JcC9MMmpkZ2VJeUhZ?=
 =?utf-8?B?UVFuR0lGa3BFaEtjbHBrdTRBM1o2YW1rTlYyc05hclQyYXhSUmdmb0plSDVM?=
 =?utf-8?B?V2lXL2E1WjkwYlVQaTIyVE5IZzhPeXEzVm1SRGZiZEliRkI5YVVCcjg5Vksx?=
 =?utf-8?B?Qm5JMEw0Ri9rSDRyZlVFVTlSU0VndkpidjlmVlBpc3lzMUdERnZHOWw3YmxP?=
 =?utf-8?B?MVlyejY5UThYWFAyU1krUkFlNWdib2ZEc3R5VFAwT0ZPVHJmN25IVWVGTDRP?=
 =?utf-8?B?enhjOSt5b2JLaUd4WHYzTTNEd1NTMmc0VUh6UDduc2VOd2o4REVlTStZbkZu?=
 =?utf-8?B?RjgzZ3hseGp4U2w5am9Od2NnYlBlOFErQXFIVmo5TnBjUTFZWWFhMHBuQW9L?=
 =?utf-8?B?SjM4YWd5YU1Eam8zTi9oVUNSYUt2ME5zV1ovdHBzbnV2dHIrdzJ2OEV1dzZu?=
 =?utf-8?B?RkhqK2lSZHdqay9wSFFlM2JaamJRT1NKTmdUUUMxblFCYWlpVVdLTzVBNFRS?=
 =?utf-8?B?M0xUWEJHV1ZKVDJSR2NqeXhGaUZ6RktKN3ZWemxQb2k1eHJQaVhvNCs1aUdx?=
 =?utf-8?B?Q2VOYWJqVHBtZXRnOGVReU5OMERMWmhEL0R4SWtSQnVWQmEvaFpnRkJRQSt1?=
 =?utf-8?B?U1Y2Y1NxNWM4QzVsUTZtMVordk5VL0FUTlhBZEM2R0t2MzRWUktrQjZvZkVr?=
 =?utf-8?B?bGYycHZiOEpsZGM5R0NxVG5rOE1HbFJnalNtWncxY0tQRkFXYlB5WjVZSEdU?=
 =?utf-8?Q?zSkJG5Et+XpC0VfEikn6o1A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9D09EE5E89594782C8E2DC41846900@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ab6147-d96d-4b17-b32e-08dc9a5b2c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2024 05:52:35.3912 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CdMD2deWace6gzGOXKczNCCmjfzcgav52kHnsvXKM1Zt+mQAd4+yznjoGv6lRXw2UXO8RuIDHvaYBhJMeN7KChXftgYnL0UuRSGFY6MSC8cpSSZlgIxjQHEJvg9F8Ryj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7080
Received-SPF: pass client-ip=80.78.11.84;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost3.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

RnJvbTogQ2zDqW1lbnQgTWF0aGlldS0tRHJpZiA8Y2xlbWVudC5tYXRoaWV1LS1kcmlmQGV2aWRl
bi5jb20+DQoNClNpZ25lZC1vZmYtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWYgPGNsZW1lbnQu
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaWUuYyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUv
aHcvcGNpL3BjaWUuaCAgICAgICAgICAgICAgICAgICAgIHwgIDYgKysrKystDQogaW5jbHVkZS9o
dy9wY2kvcGNpZV9yZWdzLmggICAgICAgICAgICAgICAgfCAgMyArKysNCiBpbmNsdWRlL3N0YW5k
YXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaCB8ICAxICsNCiA0IGZpbGVzIGNoYW5nZWQsIDMz
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L3BjaS9wY2ll
LmMgYi9ody9wY2kvcGNpZS5jDQppbmRleCA0YjJmMDgwNWM2Li5kNmEwNTJiNjE2IDEwMDY0NA0K
LS0tIGEvaHcvcGNpL3BjaWUuYw0KKysrIGIvaHcvcGNpL3BjaWUuYw0KQEAgLTExNzcsMyArMTE3
NywyNyBAQCB2b2lkIHBjaWVfYWNzX3Jlc2V0KFBDSURldmljZSAqZGV2KQ0KICAgICAgICAgcGNp
X3NldF93b3JkKGRldi0+Y29uZmlnICsgZGV2LT5leHAuYWNzX2NhcCArIFBDSV9BQ1NfQ1RSTCwg
MCk7DQogICAgIH0NCiB9DQorDQorLyogUEFTSUQgKi8NCit2b2lkIHBjaWVfcGFzaWRfaW5pdChQ
Q0lEZXZpY2UgKmRldiwgdWludDE2X3Qgb2Zmc2V0LCB1aW50OF90IHBhc2lkX3dpZHRoLA0KKyAg
ICAgICAgICAgICAgICAgICAgIGJvb2wgZXhlY19wZXJtLCBib29sIHByaXZfbW9kKQ0KK3sNCisg
ICAgYXNzZXJ0KHBhc2lkX3dpZHRoIDw9IFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9XSURUSCk7DQor
ICAgIHN0YXRpYyBjb25zdCB1aW50MTZfdCBjb250cm9sX3JlZ19yd19tYXNrID0gMHgwNzsNCisg
ICAgdWludDE2X3QgY2FwYWJpbGl0eV9yZWcgPSBwYXNpZF93aWR0aDsNCisNCisgICAgcGNpZV9h
ZGRfY2FwYWJpbGl0eShkZXYsIFBDSV9FWFRfQ0FQX0lEX1BBU0lELCBQQ0lfUEFTSURfVkVSLCBv
ZmZzZXQsDQorICAgICAgICAgICAgICAgICAgICAgICAgUENJX0VYVF9DQVBfUEFTSURfU0laRU9G
KTsNCisNCisgICAgY2FwYWJpbGl0eV9yZWcgPDw9IFBDSV9QQVNJRF9DQVBfV0lEVEhfU0hJRlQ7
DQorICAgIGNhcGFiaWxpdHlfcmVnIHw9IGV4ZWNfcGVybSA/IFBDSV9QQVNJRF9DQVBfRVhFQyA6
IDA7DQorICAgIGNhcGFiaWxpdHlfcmVnIHw9IHByaXZfbW9kICA/IFBDSV9QQVNJRF9DQVBfUFJJ
ViA6IDA7DQorICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZpZyArIG9mZnNldCArIFBDSV9QQVNJ
RF9DQVAsIGNhcGFiaWxpdHlfcmVnKTsNCisNCisgICAgLyogRXZlcnl0aGluZyBpcyBkaXNhYmxl
ZCBieSBkZWZhdWx0ICovDQorICAgIHBjaV9zZXRfd29yZChkZXYtPmNvbmZpZyArIG9mZnNldCAr
IFBDSV9QQVNJRF9DVFJMLCAwKTsNCisNCisgICAgcGNpX3NldF93b3JkKGRldi0+d21hc2sgKyBv
ZmZzZXQgKyBQQ0lfUEFTSURfQ1RSTCwgY29udHJvbF9yZWdfcndfbWFzayk7DQorDQorICAgIGRl
di0+ZXhwLnBhc2lkX2NhcCA9IG9mZnNldDsNCit9DQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9w
Y2kvcGNpZS5oIGIvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQppbmRleCA1ZWRkYjkwOTc2Li5iODcw
OTU4Yzk5IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9wY2kvcGNpZS5oDQorKysgYi9pbmNsdWRl
L2h3L3BjaS9wY2llLmgNCkBAIC03Miw4ICs3Miw5IEBAIHN0cnVjdCBQQ0lFeHByZXNzRGV2aWNl
IHsNCiAgICAgdWludDE2X3QgYWVyX2NhcDsNCiAgICAgUENJRUFFUkxvZyBhZXJfbG9nOw0KIA0K
LSAgICAvKiBPZmZzZXQgb2YgQVRTIGNhcGFiaWxpdHkgaW4gY29uZmlnIHNwYWNlICovDQorICAg
IC8qIE9mZnNldCBvZiBBVFMgYW5kIFBBU0lEIGNhcGFiaWxpdGllcyBpbiBjb25maWcgc3BhY2Ug
Ki8NCiAgICAgdWludDE2X3QgYXRzX2NhcDsNCisgICAgdWludDE2X3QgcGFzaWRfY2FwOw0KIA0K
ICAgICAvKiBBQ1MgKi8NCiAgICAgdWludDE2X3QgYWNzX2NhcDsNCkBAIC0xNTAsNCArMTUxLDcg
QEAgdm9pZCBwY2llX2NhcF9zbG90X3VucGx1Z19jYihIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19k
ZXYsIERldmljZVN0YXRlICpkZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJv
ciAqKmVycnApOw0KIHZvaWQgcGNpZV9jYXBfc2xvdF91bnBsdWdfcmVxdWVzdF9jYihIb3RwbHVn
SGFuZGxlciAqaG90cGx1Z19kZXYsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCk7DQorDQordm9pZCBwY2llX3Bhc2lk
X2luaXQoUENJRGV2aWNlICpkZXYsIHVpbnQxNl90IG9mZnNldCwgdWludDhfdCBwYXNpZF93aWR0
aCwNCisgICAgICAgICAgICAgICAgICAgICBib29sIGV4ZWNfcGVybSwgYm9vbCBwcml2X21vZCk7
DQogI2VuZGlmIC8qIFFFTVVfUENJRV9IICovDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9wY2kv
cGNpZV9yZWdzLmggYi9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaA0KaW5kZXggOWQzYjY4Njhk
Yy4uMGE4NjU5OGY4MCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvaHcvcGNpL3BjaWVfcmVncy5oDQor
KysgYi9pbmNsdWRlL2h3L3BjaS9wY2llX3JlZ3MuaA0KQEAgLTg2LDYgKzg2LDkgQEAgdHlwZWRl
ZiBlbnVtIFBDSUV4cExpbmtXaWR0aCB7DQogI2RlZmluZSBQQ0lfQVJJX1ZFUiAgICAgICAgICAg
ICAgICAgICAgIDENCiAjZGVmaW5lIFBDSV9BUklfU0laRU9GICAgICAgICAgICAgICAgICAgOA0K
IA0KKy8qIFBBU0lEICovDQorI2RlZmluZSBQQ0lfUEFTSURfVkVSICAgICAgICAgICAgICAgICAg
IDENCisjZGVmaW5lIFBDSV9FWFRfQ0FQX1BBU0lEX01BWF9XSURUSCAgICAgMjANCiAvKiBBRVIg
Ki8NCiAjZGVmaW5lIFBDSV9FUlJfVkVSICAgICAgICAgICAgICAgICAgICAgMg0KICNkZWZpbmUg
UENJX0VSUl9TSVpFT0YgICAgICAgICAgICAgICAgICAweDQ4DQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9zdGFuZGFyZC1oZWFkZXJzL2xpbnV4L3BjaV9yZWdzLmggYi9pbmNsdWRlL3N0YW5kYXJkLWhl
YWRlcnMvbGludXgvcGNpX3JlZ3MuaA0KaW5kZXggYTM5MTkzMjEzZi4uNDA2ZGNlOGU4MiAxMDA2
NDQNCi0tLSBhL2luY2x1ZGUvc3RhbmRhcmQtaGVhZGVycy9saW51eC9wY2lfcmVncy5oDQorKysg
Yi9pbmNsdWRlL3N0YW5kYXJkLWhlYWRlcnMvbGludXgvcGNpX3JlZ3MuaA0KQEAgLTkzNSw2ICs5
MzUsNyBAQA0KICNkZWZpbmUgIFBDSV9QQVNJRF9DQVBfRVhFQwkweDAwMDIJLyogRXhlYyBwZXJt
aXNzaW9ucyBTdXBwb3J0ZWQgKi8NCiAjZGVmaW5lICBQQ0lfUEFTSURfQ0FQX1BSSVYJMHgwMDA0
CS8qIFByaXZpbGVnZSBNb2RlIFN1cHBvcnRlZCAqLw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DQVBf
V0lEVEgJMHgxZjAwDQorI2RlZmluZSAgUENJX1BBU0lEX0NBUF9XSURUSF9TSElGVCAgOA0KICNk
ZWZpbmUgUENJX1BBU0lEX0NUUkwJCTB4MDYgICAgLyogUEFTSUQgY29udHJvbCByZWdpc3RlciAq
Lw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DVFJMX0VOQUJMRQkweDAwMDEJLyogRW5hYmxlIGJpdCAq
Lw0KICNkZWZpbmUgIFBDSV9QQVNJRF9DVFJMX0VYRUMJMHgwMDAyCS8qIEV4ZWMgcGVybWlzc2lv
bnMgRW5hYmxlICovDQotLSANCjIuNDUuMg==

