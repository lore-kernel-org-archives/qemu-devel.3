Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF004C2BD09
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2024 14:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRBnb-0006rE-Vb; Tue, 09 Jul 2024 10:26:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnX-0006XQ-5Z
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:27 -0400
Received: from smarthost3.eviden.com ([80.78.11.84])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sRBnV-0002k2-8S
 for qemu-devel@nongnu.org; Tue, 09 Jul 2024 10:26:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1720535185; x=1752071185;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=LD3dfZ2F2UETlVfIWevvE8qQfgdkNOQiC0RyOj3j5uU=;
 b=a9u0oSy5tNgoSys0WjyhjN8mmNJrgqDmFQ/dtvZCUWmhXqx7clpGYYql
 DAhP7hxqzeVA+ZpMfbVABPJn5EV2Lc7VNzx2riBNby0oLaeYkHJrKV4oX
 77K0u/bnmndzJUYfXA5H1eMWcsKboCmrvLDto4eVmh4edm45EqChBVVqO
 FSwo0ijteaF26+kBAF9cmW2u6vPp4w5xaPUZX7TI+Bd3hPdttQqX1Iv1V
 uG9QsoV+L1zW9fl3/+AmBQg/4BsSq3KgO79x4iCm43b6tHsvwCNlaeqR4
 EX/oWy541HuORjV0pnb8XgD9QDUjTJI403nswVpb9AF2cAWe6QWxr56Ri w==;
X-IronPort-AV: E=Sophos;i="6.09,195,1716242400"; d="scan'208";a="16172663"
X-MGA-submission: =?us-ascii?q?MDFFOgHd5UU7r4auyfq9wTqTwmWeLSiBUlIiOu?=
 =?us-ascii?q?gfvvWfrH9OxUDes7NVdgna3sbaWdxj+SApKoQrtbFnC9GCjERs4kZrzf?=
 =?us-ascii?q?eoRna3b6lKi5oovmguMHTxKF4NnH6LtbjN0Pef0rHIw+vRa37NzYR09N?=
 =?us-ascii?q?72hn0Q9gCy5vOdYAFrQkWWWA=3D=3D?=
Received: from mail-db5eur02lp2105.outbound.protection.outlook.com (HELO
 EUR02-DB5-obe.outbound.protection.outlook.com) ([104.47.11.105])
 by smarthost3.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jul 2024 16:26:14 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hh4Bi1jwggkafryvK8KPsN5hJAYShNoRNmRlPQxh17dD9uXlzBlNf5yqTl5Ee2Gn44qUBC24Z94o8aDjbNqjf49es8yRw+mMX0DeWbSgKwftwRCIbLst+j8dEcCH+Ako8GSlnVmKqDIovmW7YKOLWCXCGcJRQf4Mvm55AFJsSUQ8Ta+ZOzzx3yeOzn8qNAhNioS27vWiMsi8OMNjKq0+gMa9KbzEa0XwA6O+TIbWbns9ija10sZKp/ksFp1yfAlK8X+KqSKH0i154PR3i0neflwLcPmObSYzwtmwqMON7/0Cf6PLksUih/nTym5gl+x9LjI7w2pS+ECAZqR/ESr5CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD3dfZ2F2UETlVfIWevvE8qQfgdkNOQiC0RyOj3j5uU=;
 b=bI2sTeImUy7Xzio04tbWVwZMF2Hma4w88coMfowOBWKx92PFH64EMu2gWPneD9z3P5rUBAarRBEFA90CF3csEF26f+SmJTtpkCLXk3Tw1x+GEtoLKKWHq+iVMAEh17tx3LahhpvQrZ+tOXBFCkejKYqfG6F+WteC5O7zL9RtIfTflgnK/9Zh7GHUR4KUXLzX2+L1DIopWb+pHs3E/ZDETsoBeuL4p8Dtz1+F1oS5FRRE/phm7KuYx5PqxjkvhWROtDDoXyObvSkkYpOa6AKQWA+s34rYiHZdeAE2KnKIPhJuNtktbl0eKCClBBLuBSkAIKqceWXlk6HtTvAXJhQMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD3dfZ2F2UETlVfIWevvE8qQfgdkNOQiC0RyOj3j5uU=;
 b=fGOU/6jBPQndhNLmA4y/DB/O2D4PP1tOPPp1mw6KA7zsRQWsYsCJX6L5a8QAZ14P+wbTSkQQEWkwD0/WEPb9H1KbuemPy3kAwjjB0P0UTjZnAvjILeo77o9RkgSoMMGUEbQ3Afutv5TMEGKV+bu6L8utWSPV0RIvpK5wDHdYc1LzDiYre5aJMFzvlY2dUgKvwmxKzoQp2YPsL2VXa6q6FFFklDOM8UoqY+Cfi/QFldFJ419nmpFswg3JZLI1XHC1URNVVC8JqZINycLbtaiRjOg4OLxrsjDvPWqcR/M7KKn+AfzjjLwQ9+5PV17/WaSKKkDbIM2u9KH7alRxPeOiiQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS4PR07MB8459.eurprd07.prod.outlook.com (2603:10a6:20b:4e6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Tue, 9 Jul
 2024 14:26:10 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:26:10 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>, Minwoo Im <minwoo.im@samsung.com>
Subject: [PATCH v7 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Topic: [PATCH v7 3/4] intel_iommu: fix type of the mask field in
 VTDIOTLBPageInvInfo
Thread-Index: AQHa0gvxim5DZG7IQkeXyOKD2lbMJg==
Date: Tue, 9 Jul 2024 14:26:10 +0000
Message-ID: <20240709142557.317271-4-clement.mathieu--drif@eviden.com>
References: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240709142557.317271-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS4PR07MB8459:EE_
x-ms-office365-filtering-correlation-id: ccab5a72-331e-4ac3-acd2-08dca023140f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?dVdFNXhpZHhCdHpZQzZBUmgyZ1l1UVFSREh4Y0F5YngrZVExUlB4N1A4MGpn?=
 =?utf-8?B?ZjdOeWxJVkdsSnRHSmdWU3lRMWQ4TkdhRDRCTlpwMXpOczlGcmRaM0VFU3Vv?=
 =?utf-8?B?cmpWV3NGeDFleWZUSWNUOHhOdXRGMlhFNWNmOWk3Y3dsQmZTR3FueEtVRkU4?=
 =?utf-8?B?M05VK003RHA5UVhUL3FOS1ZyaC9iR2JITU9xQm5UNVpjVUxZL2hMUlJkTlIw?=
 =?utf-8?B?UFkzTU04MmxyYk9EYnUraUc1RmliYlV4MHRIVDkrUFJtOFhYVEs4RGdCZDMy?=
 =?utf-8?B?RHpYMUh6NHFYalRpSHJ6Q0FDU2ZhL1ZacVFNbTE2UHdsS25yNFY1bWJRUitF?=
 =?utf-8?B?NzNra25OWGhLaElSVXMwTFhWM0FNNXNTUktWQkFBZlgxdDNZcXdZSUVqRDNC?=
 =?utf-8?B?TmxleWR0b0FKMXRwbkVYd0FVekt6ZVlDSXZZL0tlTkdxMnZuUE5IeHZtMVQw?=
 =?utf-8?B?TzdyTkl1UmFjUm80US8xdndiQmMxYWozQjY5YUVxWklYV1MycGRxaEdoNHVj?=
 =?utf-8?B?VklVY3hpSTVHMXhPZUUzdEs5R0hWQVl2VDU0N3gwbnBHQUd3bURWdm1wVEpZ?=
 =?utf-8?B?TXlkSWJSUGVXQlJXNVpiMXhDUitJcXBuMEJ4SkFleFUrQnpQNlAyUGlGbU5F?=
 =?utf-8?B?Z2dLUFlpanRnM1F1a3NWV1V3ak5JWHlqZS93Z0RhTktxbE9CNHBtb1pnVFVO?=
 =?utf-8?B?dWZVOFhuRTU0a2tCNEhMUjhzYzBRZ0dtdStVTSs5WkxGSHRFV3F0VEdnQS9k?=
 =?utf-8?B?SHYvbGo5TFRmMWhOdTRRMWg2Uk04U0o1VnBaVDZneEFyeEcvYkZxTmw1RzZG?=
 =?utf-8?B?ZXd6MUtia0tOVEVxN3N1cXZwVS9nbWEyVjMzNm5IM2NZMU9CcFRRdGdUOHpr?=
 =?utf-8?B?Y0ZYUTQ1d0s2T3NETGh4aUJHcW80NW1MdVZwQ0MyYTU1WUlhNmVxNU0rT0Ex?=
 =?utf-8?B?YXl4VDRMM052VjQwclh6Y2UyWVNxalliUmJyZGUrQVFRekxhUnFxYVNQWm5P?=
 =?utf-8?B?TVVubTRzSVYycEE0cC9sUnpoZmNRaXF1WUdJNzRIRDBpUktVM2U3ZHV5UzIr?=
 =?utf-8?B?UEorQnNlc1dSeE1jcVpOWm9UVHBHekFCUmFIYStWUVQ3Sks3V3RVSUk5SURx?=
 =?utf-8?B?cFZLQWNvOUNGQ3RvZnlhZjNlRUJCbWt0dzVCbmZBWnRFcTh5VGt5L25JaVAy?=
 =?utf-8?B?ZVh0SUIwc2h5cHFFNFFnYTFrU0hwaDMzVzlTK3hXOTFCZFA5azJjSjBFN0p2?=
 =?utf-8?B?TW10eEJJZmlmdmFZSXcwdzIwajBzRFhQWDRIQy84cHVGUEIyWnBJekU5Tnkv?=
 =?utf-8?B?K24vUDE4Q0ZuY0dQRVdVT0szUDFoQlQxZlkvKzBVckQ1amZYeThpODdZcGJz?=
 =?utf-8?B?ZCtNbmtPdTcwSFBHUlJ2QWJBVmhzUytYKzFFNUdrK2I4UytzZ21MUWZoWHhl?=
 =?utf-8?B?ZVJsMHluVTZ5Mlp1Z0x4TGp4aTlkODh4Z2Q1UHZWV0UrRUp2T3pRdHdDdXpB?=
 =?utf-8?B?anhmRS9HdEozMkJNbENWNXM1bTZWYlRFU1RmcnU1Wk5vN0huRExPSldIYVFO?=
 =?utf-8?B?bGpxbXlZSHY2cEtQQnRZWXcrUk9qWFR5aWw0ZDBWRGtBTXUvNXZOMzY0MUVk?=
 =?utf-8?B?MXhzR3JOeXU1TDh4Y1VMcDgwejg5eHhQN3dESTNOOWtGNkx1VFZ0ZGVCM0pw?=
 =?utf-8?B?M2tPcnJKQ0ZKTi92eDJJVEdDWUMvMmt0cm5Oa2pTTGE5UUljRDh4WXlLY04x?=
 =?utf-8?B?dE9xb0JoUENzR2tqdHJuTGxKRloyeW82MWxlZWFxWXduam10M0ltZ2pyQkE1?=
 =?utf-8?B?UExub205ckkvRm9iV0YyaXlpNFlJMWZWbFVTa1lwdXJhNlVtTUkzemMwN0tV?=
 =?utf-8?B?N2Z3R2NHNXFyWTdjcThLajdpMTVDcHFWWTQ4UGFCWmRwbXc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUc4RHlIWkxoRVpJMHhtR0JhaXpIM3djVGh3N3ZPTXhoclBIYWdJaEw3QXM0?=
 =?utf-8?B?dlJBekNPUEp5WGFNclUxV1N6T0FLcExqRENsdk5zSHdIQ1VVQndhRk9IQ2tv?=
 =?utf-8?B?UlREbW5DbWpDWDg4Q25YbWlUSm1PWXBDNU9JSXI3c0NFZjVFNURaRUJnQWNM?=
 =?utf-8?B?amtDSTJIRDBoTUJQYUprdi8wL3U5bjNjd3NydWxaRkVqRzduRjlRWFJoWDhj?=
 =?utf-8?B?c0NVVzBOTmtkcm5XWm5iejZsRGlWNUV0TWRZR0xNZ2RWaTZrNzRZTGZaM3Z5?=
 =?utf-8?B?bFBaSXlzVStURlkyV1VIdHduTGFnR2lCc3B1WlJaT2JxOFBpQ1VxZkREaDFx?=
 =?utf-8?B?em16WkVuQ0ZKV09jOXdjbXd6RmJUMEg2aEhFc2k3OWRFKzd3V2VUdENZckE3?=
 =?utf-8?B?MUhMYnc2Zi8vQ2xRNGNkRFRSaXFlVVF0QXFteXN0L3pwZCtVb1VSSFcrTHJF?=
 =?utf-8?B?NzZ3YjJVemp1TURpeC9ZWnRNYVVTeGhQdm5NbSs0cURhNVFIekZaMHJmdzBX?=
 =?utf-8?B?Tll6b1JtWXJZQmp0UHdzNTdHZzl6MjhNalN4bEkxTUR3WVJ4N0dNYkVsamxS?=
 =?utf-8?B?Ym5qcmJIMWVtRko0anRkSktPM3FxTlNSdUEwOEtuT0pxVkFVWHd1NldVTy9C?=
 =?utf-8?B?QUt0WEF3WnZQMm8zM2xuM1lYUmRubUo0dHR6UU1nVUdjT3BKdkZ1Tmd0RjFw?=
 =?utf-8?B?Qzc0V1hsRHNmYmljQ0paNGM2eThZMVg0R0lKekF5S1l4cXBDNDFOZkIxengv?=
 =?utf-8?B?NnRuWUZSSTJ6SEV1Nmx6SFN1b05ib0NIL3JHZHduNU5ZVTFyeHE3TEV4djV4?=
 =?utf-8?B?a0hNb3N6VzZXSGJIemgrVXMvdWU3T0VCNHR1Q0FBSlhJTWhMeHpKK29nWFF5?=
 =?utf-8?B?QkkwRjk1YTZpc0l6U3Z6UkVYY0lFajNleEU0Z1lhbm9nUWFHL1pEanM2UFJU?=
 =?utf-8?B?VkVxUCs5MEJqVFhQMXZ5VTlPODZRMTNSTHhUaFNjTTA1eGVwVGUvRElLUlUz?=
 =?utf-8?B?VjZ6a1JWY1NtblVBaUdlZnpyeTNuSllkS2p4Vk9XcGNoRnFnK1NwOXFxc1c0?=
 =?utf-8?B?emlIOGFKc3RmQjNncjhSUjVOUHd0UUlQV2dKMGlqOUJLVDJHVHJQMVpWdWxn?=
 =?utf-8?B?b3daN2FxU3FKRzBEWWo1eVUrVVdMU29tdlJUOGFvd1dLQ2Q2SVJvSEtybVN5?=
 =?utf-8?B?STZubzFabTlTZmN4a3hhVzFITnJtbG9CeTZwU1ZvSy9WWkVGZnd5UHMxRHJi?=
 =?utf-8?B?NklDYzFuSFAyS1o4ZGZIQjRrWkJHOUI4SVVUcDJzbDIvNEphWGZ0cittWGNL?=
 =?utf-8?B?MERYdHZxODBtUEhYbDdySExsdGVRandCSWxOVmxZSEwreFVrZXRQNU9Oeis3?=
 =?utf-8?B?VXZZNm5YQVJ5V05mZkFibnh2T1dRQitGT2h6SWozUmxSSHRKR29HMGpMVndN?=
 =?utf-8?B?VU1xd3BFdEZDaSsyUFlVSzdQZVo1cmlDSlE3Vk9WTUViQmhNOXhPWlAxZ3VP?=
 =?utf-8?B?MmF1c3lLamZESFcvWW02RG9tbHUvSkR1aUhhM25zcU9OcDBIamRmYzZTZlQ4?=
 =?utf-8?B?dmZnZmd2V21aOVBqRHBSUUNXR21UczBZUnEySnU2bTBTUFp6dFdJb2NMNXAw?=
 =?utf-8?B?TG5Lc2NGUHdJVlJMeEhnaGwwT2RoTkNNVVZGa1pQRlp6TkpPVkMvNEFTNEp0?=
 =?utf-8?B?eXIzeXZnMUlwUC91bFRqQW5wdk00d0Q3TXZuU2JYNGlOTFZVNnFRVmZ2Y0wv?=
 =?utf-8?B?M0h2SElyMjcyS3A1dExUVVdOb29oeDg3TVlNY05UNEVhUEtnRll6czVVWGk2?=
 =?utf-8?B?SkVzMGZ4MEk5YjJqUU01bUZ5aWRpYllTRmxjZjRCckdDdnVwYiszWUVoZk1r?=
 =?utf-8?B?WkVrd3JBb1NGdEVkZXZVZjYwa1ZmWGh5TGtzbEVqQ0pSbFl2TzlQWndKekx0?=
 =?utf-8?B?akNCdXk5d2xQRVQ4MnFpM0JsbWlPMWNkMVdXcVM1Vk41THdkVitxQ0pBYW1H?=
 =?utf-8?B?YlJDZHV2TTdKanVoYzkyaFVod1Z2bUxZS2dpK2xNVElTN0NTR3Q4MXZoZGpq?=
 =?utf-8?B?S1QrYkEzT002Q2l4QVFKYU1vMW85anJDVVJRYndXcVlZL0RFUnpyYThYRk5L?=
 =?utf-8?B?VkdyYzhIeTV6TnZDVzI5MVV4ZUU3bFZ3MnlwYUcwZkUzaUFVS0RyeGd6SEpj?=
 =?utf-8?Q?TOiqc50wOYex9/2jMEI4XmU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C873A1CAD1E58043BEEA287F6C845D3E@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccab5a72-331e-4ac3-acd2-08dca023140f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 14:26:10.0313 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VyKgq2WgTx/PqY0PGel1kDoOJ9z2/KWYIDQj+pgFiuxY8bJKIr+uI8cWk9y6ZhE6s5OGEk7VSzOZbC0za0YPtxoBD13dIAZAIg7f8HF4fJspcLBJi7uh3n3h5c3V08IY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR07MB8459
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
bi5jb20+DQoNClBlciB0aGUgYmVsb3cgY29kZSwgaXQgY2FuIG92ZXJmbG93IGFzIGFtIGNhbiBi
ZSBsYXJnZXIgdGhhbiA4IGFjY29yZGluZw0KdG8gdGhlIENIIDYuNS4yLjMgSU9UTEIgSW52YWxp
ZGF0ZS4gVXNlIHVpbnQ2NF90IHRvIGF2b2lkIG92ZXJmbG93cy4NCg0KRml4ZXM6IGI1YTI4MGMw
MDg0MCAoImludGVsLWlvbW11OiBhZGQgSU9UTEIgdXNpbmcgaGFzaCB0YWJsZSIpDQpTaWduZWQt
b2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVtZW50Lm1hdGhpZXUtLWRyaWZAZXZp
ZGVuLmNvbT4NClJldmlld2VkLWJ5OiBNaW53b28gSW0gPG1pbndvby5pbUBzYW1zdW5nLmNvbT4N
ClJldmlld2VkLWJ5OiBZaSBMaXUgPHlpLmwubGl1QGludGVsLmNvbT4NCi0tLQ0KIGh3L2kzODYv
aW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaCBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KaW5kZXggZmFlYTIz
ZThkNi4uNWYzMmMzNjk0MyAxMDA2NDQNCi0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJu
YWwuaA0KKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQpAQCAtNDM2LDcgKzQz
Niw3IEBAIHN0cnVjdCBWVERJT1RMQlBhZ2VJbnZJbmZvIHsNCiAgICAgdWludDE2X3QgZG9tYWlu
X2lkOw0KICAgICB1aW50MzJfdCBwYXNpZDsNCiAgICAgdWludDY0X3QgYWRkcjsNCi0gICAgdWlu
dDhfdCBtYXNrOw0KKyAgICB1aW50NjRfdCBtYXNrOw0KIH07DQogdHlwZWRlZiBzdHJ1Y3QgVlRE
SU9UTEJQYWdlSW52SW5mbyBWVERJT1RMQlBhZ2VJbnZJbmZvOw0KIA0KLS0gDQoyLjQ1LjINCg==

