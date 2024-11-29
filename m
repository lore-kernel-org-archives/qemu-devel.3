Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62250D6EBE5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfo-00085M-QK; Fri, 29 Nov 2024 02:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfc-0007zE-9t
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:11 -0500
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfX-0002mK-Hn
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866244; x=1764402244;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YBhE5BBedzp0ZGBHlCFslUbzcaTj+tWkn8qeTXWletU=;
 b=UI+wnTHf95zBFzL9yNBfBDGCIwnOJDA/ZvcEIJiXTnNGvjKGR1t9MHNL
 EAuvbaI0h/MnCXbLzAsgUuy5MDSOFd+EqFG2rAechfMqSiT1r6Z3UdPKF
 iGtWkYgnQCCe801SR3K0PP9kL2bJpTPsqisTwTeh+5idRV4fODMBAyvLK
 jLOZ4nxM1i5Vdjy6rPgYhV8Y9XfTSFFlLHygw8jLrMsQKv7mhVcsXy+ON
 JE/V7I0MFdlQyUNOLR4qvJDYTdSzGsHIbLsNhvBtC8p6/IxMlZPWKGe8v
 sbmNJ1iYA8P5rR1ZcH1cLoEaqI+1l7a+AlOTR49pv3dAK072a1NhX0QAk w==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25664406"
X-MGA-submission: =?us-ascii?q?MDGtBwjA5Nw44xfKT5Lzr3q5Gjp0txOBOCy2Vw?=
 =?us-ascii?q?JVfBu0PmHA51M3AhPwk6TLf1pXG3OaQen/fdTz+h2GKc+BEJO+rivQ9q?=
 =?us-ascii?q?ldY8ic6i2xq7wMvWGf8dp1McLg/AqJf3prsSzVv78F3vmuYvjuTwx43y?=
 =?us-ascii?q?gdvoCgwx2rQOBViEBABw/kIA=3D=3D?=
Received: from mail-am6eur05lp2109.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.109])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:58 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dp8wDQWjJWNVAjcF2hxnVf5aU0EVNpJ24xhZdLM44b9sc23zeoU+ElWIxauo5GmBt+dJU8fmMtLLSeAE3BEmwI5YOka0ZFueJXr4akmMzi2AWYPN3C8v4AyeozHYQOEx4iq247aaV8QSmSM+a+Y+1SMRgNHH5TzFkjGSH4SH1pAU40IhTfkXYEgJRO2rkdO0cnvV3p/AuJt7PS0nAdX9ylww+daN06Ofdfe3DE/z7GGA1MyACKCaPuA9OPQ9kEgBRbnGuvmkR2dVkU4OgSxWnzuUyLfpKPABmGPFIQKHfzML+f0i9PJP5j5lvZvvcprN2p3anzMATOfcebjeEI2DjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBhE5BBedzp0ZGBHlCFslUbzcaTj+tWkn8qeTXWletU=;
 b=st+zP0ger25GRaE2ie2CtQIjQffkAZoo9zQTdIuJtuE6qT4urcMwETa/oANnGccJB0YyBi4W5cUNsbJodxYdD5pfe3L6TW/uhlfP+DldVw4QWbiwmn9gQdQyqlVhZEX9JuYIG24KCCD+jKtaZ+DD/Si6NO6hUbTokVzqiAG0Lm0fclNb+bAxHzzH+qqpGZ6f8805arVXRHG/2GZlg+p2eHKZHv49bEzM89wAo2BFpbJC5PxUFSc2FKFbC/nDefcPqI2GKOWcZ0hvRq8LnDwtQHXoMP7QqaIEMGVHFtIQaTBF1LWNm8I67Hz3pCO4/qinsM5GevpHwLQHvJ7OxkgapQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBhE5BBedzp0ZGBHlCFslUbzcaTj+tWkn8qeTXWletU=;
 b=MGIF/FuoKTf/BR11JXoQ7gNkqaActgrp2+nuAQ5Un1ZcgYbVgfxdF7wCALfBNv0yo//bQAQtCtbxeYWQS8/oOi0YZezODUwNDRhi1NpfYgAGE800Tga513ATYq1wRw6UPUsRE7Rdu8R2Xth76u9fircGr1SKywDzTe1P8kKjOzeIGDdVF4zzHkBSPXMH5tgdXWU4HIPwQrWCgCt9vulwhE4H+HIOvxCaGzgdam37GKoT8tTuoaSJE43QmBTdZ6PLSN6t2HBiPamHyYHFvaqlSJBw5OD8br1Uzp1z2VFBa8wWEtwWQTnLcT3H2j46s17jNgFTov64hvv/cFfcUWwuXg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:56 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:56 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 10/19] intel_iommu: Implement the get_memory_region_pasid
 iommu operation
Thread-Topic: [PATCH v1 10/19] intel_iommu: Implement the
 get_memory_region_pasid iommu operation
Thread-Index: AQHbQjJx30tXT3ATwUiFDB81CRnjhg==
Date: Fri, 29 Nov 2024 07:43:56 +0000
Message-ID: <20241129074332.87535-11-clement.mathieu--drif@eviden.com>
References: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20241129074332.87535-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AS8PR07MB7847:EE_
x-ms-office365-filtering-correlation-id: 37c0f1c5-f8d3-4a30-8e3a-08dd1049946b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?cWd5eVZjWXZTaFNmck85VEg4akJuVll3WWloQy9QMkZ5RVN2b3gybEhXdnhN?=
 =?utf-8?B?YVhqOHNzMjQyYVFXVHY0bTlUY3crYS9mb1pobWJETE50emxLcHV5V05XYTZH?=
 =?utf-8?B?MFkzeldqY0pRSkNZRlc3SFBicm9mZlMrYXl3cWIyR0d2SzVTMkFEVFhkSVQy?=
 =?utf-8?B?UnhWR1RreHNnZytPVVl0a2FESFRqWEplVkNVUndkbzVkT3dveGxBbWFTNk1o?=
 =?utf-8?B?emZsRmRaaWFmMHdJZzRpS2t6cWFub2k1ZE1kRkI4TDl2Z01iU25WSTR3b0J0?=
 =?utf-8?B?V1ZtWWNFdFQ3ek8xVjlpcEpjY0hnOGNSZ0UzM052RS9JWEc5a2lSaWk4czJ6?=
 =?utf-8?B?K0JxU3B6Mm5rVW1TdmtEZmlkZTdrdjVycGY5VGpUTmhxczVQV1BjQ2lnaTlO?=
 =?utf-8?B?V0JCMDZpS3o1QU51OXR3OFQ4TC9HV3FrYjZNc05vbE5LK2F5eXhoMTBUM0xs?=
 =?utf-8?B?ZkdSc3Q0dU12a0NtOWtsT3NHVHVnZDJmZmpOQk5TNDlZWktBN3A5S2lVcTJ6?=
 =?utf-8?B?eWh0TXMxbW1IMEtvZzl3KzRoSEpNVng4UW9KZzVNMnZua1p5SnlramtsRTVq?=
 =?utf-8?B?NE92empQQXh6bFY5Yy85SjlYdDdhV0JmeGw3VW9teEhDejBoYTlTeDJEa0h5?=
 =?utf-8?B?cG5NZFIvcWtQeXhqakUvbytKUnN6S1NsTnV0ZDZrSjhTN0V6WkoxU284UHpE?=
 =?utf-8?B?ZG5OTHJ0VWlaMDB3SkZRZ2ZLcnoxeDVhNEdUY1IrUkd5anlJemJkdVlDTEx4?=
 =?utf-8?B?aExaNTJJUGZjZ3ZSNHlQT3dRaWZaZk9qdzdGSWhCbHNMQlVVQW0yeFZtaS95?=
 =?utf-8?B?TWdQaFZ2SGdCekQxZjAvbTBLcGR4ZTZvbTB3K2pUc3d5b0c2M2J6dFJsQUts?=
 =?utf-8?B?STRHTUsxVktEODhxZ2pZQjBjL0xVSEZFSmhuU0xMOG1tY3VQR2RMcjVIRFEv?=
 =?utf-8?B?bSs1MEdFRnRJR2lqbjlPYmI2cGJVSmYxWUxyVXl4Yk96WWU0T2FHdSt6cTZs?=
 =?utf-8?B?OStYNm5IZ0xQaDUzZmdGNmtKWnViM1JKeU56cXVUOWhIdVNaNGNqWnJrTGxD?=
 =?utf-8?B?cXdPcWZLaEZPb0ROQ0JVSi9ZczJEeWNCSFVMTllQUGJUZWtIbks1QUtta2VG?=
 =?utf-8?B?eE5mY01vWVpxcVVLcERDUkw3VjVGUEtlRStoNFlQRmFtanRUYmdyTnJwNE9p?=
 =?utf-8?B?ZUcwSHVsb05VKzJtMzQ1aEllVHJ0Sk1FQlNuWXpUeXdJTGd5TXlXVHo5NFl6?=
 =?utf-8?B?YW52QUxMZnUyZE0vamlWd3JmVXQvMzBKOTM4aDJKaXh0MEZUQWpvUzhZaENy?=
 =?utf-8?B?VzhnL1F5eER3TnJWTlRqUVpmU3ZTdHBIcU0wbERobjVaUnRmM1dSN2tzcEhW?=
 =?utf-8?B?aGczdjlPQzhIV2FqQVdlNmVUTHFHWFVrQjBZUnNrWnBQV1FPZjFBMXFBYVND?=
 =?utf-8?B?bnR3dldYNy9kd09qK1ZyOVhqWEo3RStDNmdTaUt2OTM2dkR2MTBwWjBOa2tt?=
 =?utf-8?B?Y3hMWlk2eHlqOUN0dTh6dmVlR2dJaDhLaXI4bmJiOU5FMFRJT3dMbk1kVTky?=
 =?utf-8?B?OGV0czVhYXUyNmFoRkE5NFFSYmtjVmlnbEV5M2VvYnJiWjRINVgxTkJUTkt4?=
 =?utf-8?B?UCtrZUMxV2dmdjJISHAvVkF0NWVZeDdkWEFLQ1VabHNYS216cHlLYnVqdjZi?=
 =?utf-8?B?L1J4Rlc2WER4V2tYNXg1OUJxVFhJWXdQM3JwNUtEMlZoVHZtNGNPcXh5dnQy?=
 =?utf-8?B?czJsSFlIbmNSOXUzeEhvamZ3UlhRZkVXMG9NakdPU2ZIb2xZa2ZxTnFYdnBT?=
 =?utf-8?B?Y1ZNSjlpbkRQYXByU1Z5cHNReGxoMEpyUzkzYmR5Z3gyM2JqS0M2aHR1K3lp?=
 =?utf-8?B?aWpndVc2cDA4VGgvbC9paGF6ZWticUx3RG44eDVFUmZKWEE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bkxjOTV0SjYvQW5pVGI1S3pLR2FrZHdWSURUbVVMUWk3OU43NTYxQk9FWXVU?=
 =?utf-8?B?WkhBTUpuR0pYK3dnT3lZU2RsYkZKSkNnVkthQnllc1hGbC8wWUJJM3kxak5o?=
 =?utf-8?B?UmtTRzRNaVk3MWF2RFlnRTZRME5oVXlCcnBHTk5pajNiZmdIeUVUYlduS01Z?=
 =?utf-8?B?S1d3RHI5NnA0YlhjVzhFSVJZY1dmQWJIbDZzelBiaWZyQisxMXVydHpYZDQ3?=
 =?utf-8?B?YzZmYTVHdFRmRXpXTDJwa0tOWWhCZTROaWt1c1BvSjV5WkJGYXVrWldVcG1D?=
 =?utf-8?B?Ump5TzVqSDRwOGVKZnZSUkJoZ2lJcVZ6UHF4UmZ0M3ZsZk9OanRacitxWUd3?=
 =?utf-8?B?b05HL0dzRWFweXpDRUpDYnpRUGhCbUxxNzFLYTA5RVA0R3dheFByd0hLUFdx?=
 =?utf-8?B?QUMzQ3lFS3I2Z3YvS0RvbDdYNHRqT1RPVHZqTmVUZlYwRERuN09LQzFGdTRw?=
 =?utf-8?B?WEdodlliZFJNSzZFdFpzUUFMUDB5VTNwU0V6Qm11My9ZaTd0K3ZBUDNQcjVD?=
 =?utf-8?B?YWtXb2NHUVJNM3crdldwZEtnaEdzdWJPMXpFZEZrWHJWem1wcXlaRTdsZnd0?=
 =?utf-8?B?aTF1bmU2L0tiVFIxbkVZREtZaVlQTjZnekVsdW53dWJ6Z3BDampiRmluUkZF?=
 =?utf-8?B?NGpML04rUHN1WmJTd3A1SFducXFISVc0QXBEU3R4Rk83bWp5SWRCaUNLd3ZE?=
 =?utf-8?B?Tkt1ZkRIQXNYOVU2MC8rc24yOWNQN09wZlc3OHBwcG1aSDMvUlRmbDVXYXR6?=
 =?utf-8?B?SWFqTmQ4UUplQXZFaTRWM25BWG9PekhPcm5iMmhYb1ZIMnVZM2E4TUkrbDdQ?=
 =?utf-8?B?OEJEQUVjSXpoUmhLQ2w2N3R4d3ExNUprL2JYcDAvazcwRnpUTSt2ZHJDMDA2?=
 =?utf-8?B?NE04S3dnM0dDdDUrRE94c3ZUWUJ3QkZrSGRZd096NnR6YUI2aVphb3BUck1q?=
 =?utf-8?B?OW8rVjdpR0RkUk0yaEVEWWE2VTUrVG8vREpYZVNFSURiaW0zMFdIcDVOU281?=
 =?utf-8?B?Z0IvcHpRcWxCOGl0b1ZBcWNEYnJXTXQ3QnBYa1dUMkdLVlVoVFZkREFMaDYw?=
 =?utf-8?B?TldwQ2VYTDE4bzFKQWdZL0h2RjhKTzdoc01lN0FIZ3gxZEpLMnFHQVFyZGJj?=
 =?utf-8?B?RkNRRFdoNnZ1bExJNFNiUFRhR1Q3Z3BnNFdMT0FCTzFpYm1pOVJ0TjltUVp3?=
 =?utf-8?B?TlRnR3R3L3h4clNyQW5BcTBIMWZuU0R5Y3VBQ3JlZ0xwT1d1REJ2ZHlPZHdp?=
 =?utf-8?B?aGhGS1BzOGNvYk9LcVZQVVh4dm1sVDVWZTRlOXlmNlZaK2NTQ2NFRFI3TDNo?=
 =?utf-8?B?czA0c3dJK3dGQjJKdmhGdytVSUVSRmZHMkRVRzloL1UyQncyTHhuTXlCcHRx?=
 =?utf-8?B?WmowYzdPLzYrSFpwRDRQTTlhUHE2RFBMOVlkOFYrU1JNUHFteVAwanYwWG9R?=
 =?utf-8?B?TWYrYmtOVE54c0F2MXBvMU54NitwNlpOclFJWGpsZFNqbG1LWXdsU2IzMmIx?=
 =?utf-8?B?M2VvdEZ5aE5sY214alNTU0pIUE52MWlSNVFDc0NkZ2phMHNySkxaK0dUeVZv?=
 =?utf-8?B?VDlGN1lGZ3JHNWM1T3hzb2J3bUs4Wk1heXo3MzNJakUvZzJLVE5mcFhYM3hS?=
 =?utf-8?B?UFJtRWR3alZTeUdtQWRlOHhjYjhza0t2YkJXVm82MzFUc0FnTU52NVZud1I0?=
 =?utf-8?B?aVYraEg0TXN1cVA2ZTdGaElIRExEUldEL014ck1Ja3ZuVHJEak51eTg5TFVn?=
 =?utf-8?B?Ry9kYk81c3IxQXhEUURXSXFSRzlPMDA2a1MxaitxVnZKVjdCOHQzSnl5UThm?=
 =?utf-8?B?Uit6NFEzV0ZEYUVrYWFrK0NwRHNuV3ZIK05zWnk1eUtCUHA1R0xJNlJqeVBn?=
 =?utf-8?B?NDAxclYvSTU3T2pqUmcvWkJ2eDlJeldqQ3pRSk8wYkVyMXZHaW5uZVl6dVRt?=
 =?utf-8?B?czRzRlNyUFZSMWRkZ1R0SVduR21vdzByTTR3VTdEWU9qMk5PNGYyV1d2MXdG?=
 =?utf-8?B?b25uOUNkTUVFY3ZydGRYdHhyMHFaYjlHVmJFMHA0b2NZYW9LNnNnRkduOFdh?=
 =?utf-8?B?ZUhIRzZobmZLUnNDeUJHdUtaK3RSanYxOTFyOXlNQzdNRyt5ZSs0aFdpcW1a?=
 =?utf-8?B?TExoMmZmeGFSYk9hWDdBT3BZV2UxaEtIR0d5MkU0eW5hNFdRZlNZZ1BNRTVI?=
 =?utf-8?Q?AqDvzLyXrGZ9Udm226dlbyQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <66038F5E1B650D4D8F6EEFAFC7DDBCC0@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c0f1c5-f8d3-4a30-8e3a-08dd1049946b
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:56.5081 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U73fHSWNQyej6D9CPYyZoKVeMHJLk15JJIVvpNttsHYo7VKVVJ9+72mu+KErnozkbRi3l5Jt6rnr1xtXQI3sfpJKcIB2cN2KPKYejpoPHqMGCw3otE1epbE7Yx+VGe6p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAg
ICAgICAgfCAxNyArKysrKysrKysrKysrKysrLQ0KIGluY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21t
dS5oIHwgIDIgKy0NCiAyIGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDIgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCmluZGV4IGE5MmVmOWZlNzQuLjdlODY3NmVmYjAgMTAwNjQ0DQotLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCisrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KQEAgLTQy
MDksNyArNDIwOSw3IEBAIHN0YXRpYyBjb25zdCBNZW1vcnlSZWdpb25PcHMgdnRkX21lbV9pcl9m
YXVsdF9vcHMgPSB7DQogfTsNCiANCiBWVERBZGRyZXNzU3BhY2UgKnZ0ZF9maW5kX2FkZF9hcyhJ
bnRlbElPTU1VU3RhdGUgKnMsIFBDSUJ1cyAqYnVzLA0KLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGludCBkZXZmbiwgdW5zaWduZWQgaW50IHBhc2lkKQ0KKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwgdWludDMyX3QgcGFzaWQpDQogew0KICAgICAv
Kg0KICAgICAgKiBXZSBjYW4ndCBzaW1wbHkgdXNlIHNpZCBoZXJlIHNpbmNlIHRoZSBidXMgbnVt
YmVyIG1pZ2h0IG5vdCBiZQ0KQEAgLTQ3MjYsOCArNDcyNiwyMyBAQCBzdGF0aWMgQWRkcmVzc1Nw
YWNlICp2dGRfaG9zdF9kbWFfaW9tbXUoUENJQnVzICpidXMsIHZvaWQgKm9wYXF1ZSwgaW50IGRl
dmZuKQ0KICAgICByZXR1cm4gJnZ0ZF9hcy0+YXM7DQogfQ0KIA0KK3N0YXRpYyBJT01NVU1lbW9y
eVJlZ2lvbiAqdnRkX2dldF9tZW1vcnlfcmVnaW9uX3Bhc2lkKFBDSUJ1cyAqYnVzLA0KKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKm9w
YXF1ZSwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQgZGV2Zm4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0KKyAgICBJbnRlbElPTU1VU3RhdGUg
KnMgPSBvcGFxdWU7DQorICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzOw0KKw0KKyAgICBhc3Nl
cnQoMCA8PSBkZXZmbiAmJiBkZXZmbiA8IFBDSV9ERVZGTl9NQVgpOw0KKw0KKyAgICB2dGRfYXMg
PSB2dGRfZmluZF9hZGRfYXMocywgYnVzLCBkZXZmbiwgcGFzaWQpOw0KKyAgICByZXR1cm4gJnZ0
ZF9hcy0+aW9tbXU7DQorfQ0KKw0KIHN0YXRpYyBQQ0lJT01NVU9wcyB2dGRfaW9tbXVfb3BzID0g
ew0KICAgICAuZ2V0X2FkZHJlc3Nfc3BhY2UgPSB2dGRfaG9zdF9kbWFfaW9tbXUsDQorICAgIC5n
ZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCA9IHZ0ZF9nZXRfbWVtb3J5X3JlZ2lvbl9wYXNpZCwNCiAg
ICAgLnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3NldF9pb21tdV9kZXZpY2UsDQogICAgIC51
bnNldF9pb21tdV9kZXZpY2UgPSB2dGRfZGV2X3Vuc2V0X2lvbW11X2RldmljZSwNCiB9Ow0KZGlm
ZiAtLWdpdCBhL2luY2x1ZGUvaHcvaTM4Ni9pbnRlbF9pb21tdS5oIGIvaW5jbHVkZS9ody9pMzg2
L2ludGVsX2lvbW11LmgNCmluZGV4IDFhNGE1MzA1M2YuLjIxZjdmOGEwN2IgMTAwNjQ0DQotLS0g
YS9pbmNsdWRlL2h3L2kzODYvaW50ZWxfaW9tbXUuaA0KKysrIGIvaW5jbHVkZS9ody9pMzg2L2lu
dGVsX2lvbW11LmgNCkBAIC0zMjQsNiArMzI0LDYgQEAgc3RydWN0IEludGVsSU9NTVVTdGF0ZSB7
DQogICogY3JlYXRlIGEgbmV3IG9uZSBpZiBub25lIGV4aXN0cw0KICAqLw0KIFZUREFkZHJlc3NT
cGFjZSAqdnRkX2ZpbmRfYWRkX2FzKEludGVsSU9NTVVTdGF0ZSAqcywgUENJQnVzICpidXMsDQot
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaW50IGRldmZuLCB1bnNpZ25lZCBpbnQg
cGFzaWQpOw0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwgdWlu
dDMyX3QgcGFzaWQpOw0KIA0KICNlbmRpZg0KLS0gDQoyLjQ3LjANCg==

