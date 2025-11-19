Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB945CF34AD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 14:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLixf-00005c-79; Wed, 19 Nov 2025 09:15:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vLixd-00005P-0Y
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:15:05 -0500
Received: from mx0b-002c1b01.pphosted.com ([148.163.155.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jon@nutanix.com>) id 1vLixZ-0008Oz-UM
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 09:15:04 -0500
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
 by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5AJ6D1PA2244891; Wed, 19 Nov 2025 06:14:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
 cc:content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 proofpoint20171006; bh=eFautsL/VsG3jTsvStIQC6fX/idKkOH9CwFv8nWXp
 o0=; b=zFCpwyeOXBtjdSu6wIbiveHWExW9hZNN5uyg1xsmang1vthIcgnDhNB5C
 m4UCvig2BWYMtwEXBep5TSdAaywyDgdFVzbjIkfgTqyWxoVBlC7dDLpehab0lARP
 dBlhoQuluu2upTQ3GKdYQmg9OZccpYkA+bFWfV3l1k4GmDTnHtjFobbulH/eBM8U
 k5S68LdQXrD1YClLPmTkcniXYo04+7u/swX+qIVzVZY7LNbj/kW+bKglMZ4JLdxW
 S7eI4t/eJtx9IhBwSOzsj6HWYJMdfMcxBB/Obf+yqcerzyvgb3OsLeXGogOki/Jg
 f3DrAxfyNbLioO5tFhRzSNV3aBovg==
Received: from ph0pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11021130.outbound.protection.outlook.com [40.107.208.130])
 by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4agw4ptf68-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 19 Nov 2025 06:14:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QntO3rYYeCknOWOyRc0UKbd+GOzy1y6wHIL9YmshXAFM1/kz3lJ6gvEHCMb5uVbOYKsA+CBa0anJocbsms5+YsepRCfv5NTJTmlsTu2hOxm5UD8FuzIXhm0ASG+dQm0BJ4DIyFEygqhn/m9b4moKAu4x9qqmMtmp5zPtGyIGWR8vL0w828iCPhvUxDEx4qdqsKMPmQVhhjPcChrmRUko3vSOUs0S9FouGeISUkHrXOd/f4vHSjz+Y6IlQ6nukia/Or/Wdn3evRmLYgVpWIlspLT8xAbcQxIuhx0yJoev1QEUcbAvCrDhs19L7I7KhCRXlmr4fdEYDt4fct43Mq0HyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eFautsL/VsG3jTsvStIQC6fX/idKkOH9CwFv8nWXpo0=;
 b=OC8KJ8B125K65I7LWi5+D/opF7MjxuJjhPafOe/NSQ0D1eInOPIw7wEZ6Zbt0UTLPb8URV+ruTdrf3NVnwFGtvgby+xLSVz45T3GS1j6cttWYbFUX5GgpKN6i1CM6jIoRO7Th0kWRyOOT2CWLBc0mMC2KC2uUGm8dFqGc1dM4RhsbvyXdlmqtMaDioYu/IzetqtseHjDHb92oPrULFHnhPvyBQwmzL5qdSipP5Pj+v+rozvdIAKXDY0n83PPM8jSmKY1SY2+e3tfurB0xsLlBJPhJaLXNScivTx1eAHOQSRGTsUNQsFJ3LxyaF70sOGSl2FHE+7S8TIPKqA9S3ZluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eFautsL/VsG3jTsvStIQC6fX/idKkOH9CwFv8nWXpo0=;
 b=c470RVUcstpwESWmGyAbcqlH7pnVQEqjk3HfjmGrRGWnIwhposcOYU5nDK4UyPL4120psq8KwSEAWD/vNghNntJPxmaqFsmXCxuXVxRZUeD8XQ5MZu19+CfGIVPDm+rZAklcLeoeooea/7zvjinjt/xDhBCe8obx6a/Fv4Na84WBHENT04cZ00mZ+evFgB3kiMTvwh4+SjPEPtBF4vTxtXu5muN66gsZQjKMgzM6U7tg7LLYgoFUVZ536IOxW23Y1bdB+PgqWQIyGbrINycvpreDdEy1By/WCpN+g0eOczZ2QbzOgnWwTWl21zx6ym9GfyQp27ck3oKbPz+7VXoPiw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by LV8PR02MB9998.namprd02.prod.outlook.com
 (2603:10b6:408:184::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:14:54 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:14:54 +0000
From: Jon Kohler <jon@nutanix.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Tejus GK
 <tejus.gk@nutanix.com>, Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 John Levon <john.levon@nutanix.com>
Subject: Re: [PATCH 7/9] contrib/gitdm: add mapping for Nutanix
Thread-Topic: [PATCH 7/9] contrib/gitdm: add mapping for Nutanix
Thread-Index: AQHcWUlB2ggjBwgyyUmZWP8QnRkZl7T6CyIA
Date: Wed, 19 Nov 2025 14:14:54 +0000
Message-ID: <B70EE8D5-E859-42DC-B9E3-BF95BA21993F@nutanix.com>
References: <20251119113953.1432303-1-alex.bennee@linaro.org>
 <20251119113953.1432303-8-alex.bennee@linaro.org>
In-Reply-To: <20251119113953.1432303-8-alex.bennee@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3826.700.81)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV0PR02MB11133:EE_|LV8PR02MB9998:EE_
x-ms-office365-filtering-correlation-id: b6ad2efe-6dfa-43c2-a453-08de27760342
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|10070799003|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?dzNYbXJsZnR1akVBV0pEUk9sWDk0MHpqRXFCTmVKWlVRdlJydzRiM0ZyTzE2?=
 =?utf-8?B?c3NBV3c4UjhxMDN3cVNhVlNnSnROSStLQVY0eFBEZlQzbmIvUWlZcnJScTI2?=
 =?utf-8?B?OFQyYVgwdHBrU05SNS9QbkZEVFprNWs4b0RoTkdrczFCM1l3R201a3hJUXM2?=
 =?utf-8?B?eTQxcjhSaVNHMWdDYmorbHpXaUxFU1pFUmxsRnQxWWY3YmVPRmlqaHR0Z1hx?=
 =?utf-8?B?TnVUYjl1blpGTkJXTGh6cTk1ZlQ1UVZpZ0x2S0crTWJUdk5qdmJyRUxJK3NF?=
 =?utf-8?B?cWFQck9tdHVwMWhWK3dSUm9wMnExVkZlU3hEczVHc2ZkYmhrYlo2T2g0SFBa?=
 =?utf-8?B?TmxJN0Zicm1HYTgwa3RGYTlJOU1SNEFJRjBJd0VaWkUvOTJFNC9waGliZ1lk?=
 =?utf-8?B?a2xMTWJlVzFKM2NRMXgyaVRxOFh0YTFjbEg1Ui9FRmFIOEx1K21EYVlHWWxD?=
 =?utf-8?B?WnFVMHZHNE4yOFJKZGJNR0xMandndW9maU1qRUNkUFFXUERxR0dpalZ1cjE5?=
 =?utf-8?B?Sm0wM1BrK3UzOUxUZ1FHMnpmazMvcHI4STVDejkwRzRZUk5wMGxOeThqSmVx?=
 =?utf-8?B?MjFxL3pzdWtLTFBiMEtTVnJhN3VhRTc1akV5UjhxWmdmQWNVR05ROHF6bDRU?=
 =?utf-8?B?V2ZiT2J3eHNzTTJRbmxLejlGSGkvSnBvYzFkWHNrUW9JbzY5TlExRGZhKzJE?=
 =?utf-8?B?UmNFS1FOVHhpcnlsaUl3WEJrNHFRNjZBVUZMR3k1YmlMeUtLdjY4MFlHbHAr?=
 =?utf-8?B?RWpESWpYY01DQlBVY2pzRXR6Z3BlU1U0Z2hIV3pIZ1RuOHZoTFFhRCt6YjF5?=
 =?utf-8?B?TGh6cG4yZDJIckhlaXpqV2RDc1B6dzdJb3pRY1BuNlZ3ZTBxRnVxbUFlaTNs?=
 =?utf-8?B?M1p6Z2hUc3d2VDZpVVBDR010dVFnTDhGTThpOGtHblVZdWRnU1FlSURVVXNL?=
 =?utf-8?B?a3poS0FEY0E3L2o4TnMrWTdMcnpmOUxOMFlWQ0Jzc2dRbmxneWMzNXI5Tzlz?=
 =?utf-8?B?UlFvbVNaQWYzTndEMXJUSDBTV1JNTjlvMEhsaTNQTW5UL1dFa09vaUxXOHM5?=
 =?utf-8?B?UFdGdnB2WGdXTVZ5TEVjTTkwVzVmNzVQWHNyU3hwUHJVT1VBZ3N0M3lReEI1?=
 =?utf-8?B?QjluYXNjcmNqMWd1SnpwRlFKcUJITVZJa29RQlc0WW53Ykk1OWYweDBrSDZE?=
 =?utf-8?B?MWNINldJbStSV0V0SGZyVFNlZXI0WFlWcHRwK2djTUdKZmx0RytXK1dXTEt4?=
 =?utf-8?B?eE9lNU0weVh4VklLcitHVFZVZjA0V29kWDJ3SUQxeVdkWTJMZ3dWZWJmY0RS?=
 =?utf-8?B?WmRTY0Q2Qkd0YzQyQmY5eUlTaEdOeVF1Y0tPRnlNUUJUQVJsVytVNFd3ZS9S?=
 =?utf-8?B?UHBscVA4bTU2Mmw4cFZqU0JSVWlIYzlZcHIwd0J1ODhoUlY2YUxTZEZWbThP?=
 =?utf-8?B?cmdoWE9RREg3U0gyeEhGek00bjF6aFBKOGx3U01MeGxLY1dRK2ZpZW5JSWhX?=
 =?utf-8?B?ZzdOQk52enVOOHBBcWZ0eWxseXdIWXAvdjdqcllwSE9mYWRJV3RUQ0hBbE14?=
 =?utf-8?B?b0o5VG9MaWE2QXozdlZJS2dqeURkRTZhL290L093SFlVbWZZWENmV2R5TWZJ?=
 =?utf-8?B?d093TVAyWTdRMDY3WFlaUkFLUDFEZG5uSmwvV1BkMHRTbWMrRUNSOGd4NUcy?=
 =?utf-8?B?YThFRlU2Q0ZzRG00WTZPbGlQMGhKb2tqUXd0anQ0d1pkOUZrcVBmaXJmTS9t?=
 =?utf-8?B?b3lRemJxTEpNaFgzdHpCTXdLaHViOGFQbjVNOFBMUHp1TkYxYUVTWEFLNWpH?=
 =?utf-8?B?REorVWpsYWR6ZENXMy8wK2JTYUluMHVjcjhWUVlFN2dmVnI4WndyK3ZueU96?=
 =?utf-8?B?bzU0bUxDZkYyNXBaWjZXVndKQ1YyRWdDRklDRzhmcFJUTWFvcDQ2OWJXYjVk?=
 =?utf-8?B?cWNkbitUdSs4eUpBMXZCeTJleDhWZVUzNEFobEpBNVVUSFhtcVNIcER4enh6?=
 =?utf-8?B?d0hXcTJNQVR4dzFCM0V0Z3J1S0prbmd2OG83RUI1TVFGaHpBY0d3b0E1TjRk?=
 =?utf-8?Q?dYc2uE?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV0PR02MB11133.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(10070799003)(38070700021); DIR:OUT;
 SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2cvcU9lQWhoV0I4VUFKTDlTU2lsbUxhaDdkdTk4Ykw3ZnNOQVliUWxyL2xv?=
 =?utf-8?B?NDdpbXVOMUw2clZKL3labFhKSk0zcU5BVDNLU3NZN1prQUY1cTVZeGNiM25u?=
 =?utf-8?B?ZzYxR2YrMndDRFExRlRjb0xJVEtzdFpSV2cxbUMyK1BiajY4R0puWE94QzYy?=
 =?utf-8?B?VTZ0b2Fmc09XbUtOYlpCL3Z5d1I0K3h6VEJaVUNQTFZlNC9HOUo4bEtHQVFt?=
 =?utf-8?B?aWJYQlNNVTJpSkFRc2J1VUVNUkVaSVlZaFB0LzZqcEZqRlE5d2lUYlY1MjVl?=
 =?utf-8?B?WFVHYkd5NkdUd2dLa0t1ZU5BUTNGNUFDbWpZQXVjOVp4YldyMTNhR2VWY3Nh?=
 =?utf-8?B?eFEyekxMdm5ybXY4cm52T0VTc1lnYUppcWx6UWhDQWdlcGlqem9hT1ZzS0VR?=
 =?utf-8?B?ekd1cGVaKzVidmNUM041OGorSS9BRHV1UmtjRXdpQVBwN3ZldFR6cmpLbTNN?=
 =?utf-8?B?WXZLSEkzY1JXZXVqMURBQnBaWTFldU5VcEttUlo2aVlRUnVZWXRoZ2FzTVFI?=
 =?utf-8?B?OVlUVkRCcGZhamd3bTlIK1Y5TTRkMnJ0SGVhL0wyc0lDcFNSbVlVZVE1MjlL?=
 =?utf-8?B?and4RytTUkp1elZWb0JwRHRzVUsxN2ZIaEphSTc3c0pSS1pSSTdSRE1SQzEx?=
 =?utf-8?B?eW9pbGdJWlU1VFF5QzVMc2VaZjl2c1hteGZFczNFQjVJOXdNUkgrTlJ6c3Zq?=
 =?utf-8?B?K3Zucld4ZyszLzI3dUZud3dCd2o3bk5HWHpXWE5CenBpRzVGZkhhY3hienJC?=
 =?utf-8?B?VTlreXRnbktFTDlRZzR0MElEM1UxUGU0ZjV6clVDV01FMGpsYkJmd0toNGF0?=
 =?utf-8?B?dW1VQU9kUElmZStpa0lpTHBMS2x5Z0RYdGdKc0x1TWw2dUY3WVUvdGJKZGYr?=
 =?utf-8?B?RkZiREV5UXpkOUtHYXcxU2o2eEJrQUh5NVp6TDhwUjNrYk40TWVoNHNiOVRV?=
 =?utf-8?B?SHB3aGJydDQybzVWODZuSzM4R3UzNWNLQjJ0SE95VHczZDJlc0tJUDYzZ3BI?=
 =?utf-8?B?Vmc2V3RhaGROdzF4NE1pcEtmVFRGalpuNlJmRzNGVTdvZ0lCZlhrWFY2bzBC?=
 =?utf-8?B?RlRycXhwaXJwSDlNd0JDSTJzNTdLNWxMQVc5cU8zMkVZVW9FRXB4OGJkK3N6?=
 =?utf-8?B?YVM3QkhqdEJjdVkwRlhOWk5aYURrNDNFRGxPeEw1UUJRRE5TdWhQVjFtM0I5?=
 =?utf-8?B?SUNpdmNXSEFxRXAxY3BvbjZWbkFZK25iM01nOE5uN2srbVNUNzF2QlJVWEYz?=
 =?utf-8?B?cHkwL1ovK1RQaHYvWGw2QTdxQnVsMy9FMHkrU255eWx5dkh1T1VHOE9XemF0?=
 =?utf-8?B?Yll6UnJxVHo2aHBpZW9GcERzT2w1TlFtVlRRM280QjQyN1hjdGh1Vk1qQVEx?=
 =?utf-8?B?bW9nM04xN3FURm02dm1oU2RBRWhidG5mY0FGUmthU2VwZmhHMkgwaVBVbUtk?=
 =?utf-8?B?SHNQQm83WkxHdE5pcVNoSHE5czhQeWtvTVBwZmtoNys0K2lmSE95R3V0NStP?=
 =?utf-8?B?WHZEYys3aTFQUWkva0ZLVzg3dnZ3MkNCNTZ3K1VmeXJOVndmbnlHRXNjNUFI?=
 =?utf-8?B?bG1jaUNLeldKeG9jQ2ZrdG1wbWR3QmM0czlUaDB0TjFqdURpNWM3WU5XWklw?=
 =?utf-8?B?ck5WcU52TFpwWDEzN09EOEc4K1RtVlJMc2cwN3I2WVRCeVpndWk4dTRXMHJG?=
 =?utf-8?B?OUxTektHSHVJQUdKQTRqYmVZOVlKa3o5RHhWbDB5TXliN1BQOEFSbVF3SytM?=
 =?utf-8?B?UU1NdmU2VXdkendSUW1uaU9ZMXRtcStudmRZd1EwcmgzdWk4QlFOa0dSYWph?=
 =?utf-8?B?UURPeGR0SG5hcWp2emtleDBXL0pGZlVGc0VoWkN2MStDZ09WdkxvRUR4N3FS?=
 =?utf-8?B?cXpxNHRNdFJ0aWdCYVlWOFZXMFp3cXZLWUxNd0VLT1hRT29iTzRwWFFQYk5P?=
 =?utf-8?B?RjBoRGRCL25GTUpPT29zc2R5Z0tYQVBUZTNndEw1bWZTNlRiRXlFeFovVGdQ?=
 =?utf-8?B?MVdjZjBxcnB6b3J4T3g1YmlIMG50VnZYeWY2L0ZLdnhIazQ4WE5PelFuazZP?=
 =?utf-8?B?bUVYam9XTDR6SHY1MzRpV3V6a0JCQTl3MUp2SVVWSnpzZHhyMUNJTStsQzl5?=
 =?utf-8?B?eng2amNmMno0a0J1N2lxQ3FjNUg1Q05PdHpRNnI2TG9iMzAzdjkwSU1hdFpC?=
 =?utf-8?B?b3R2Qit0WlUxTFlvSEtjcFJjZjg5bVFoRlBEWnRSWUdvWHZDcmMzaEpOSW9z?=
 =?utf-8?B?UTZnWW50cmRudUNsTnI0QzNpeVBnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B63DF622C85F7748B4A20618F1B2C5C1@namprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ad2efe-6dfa-43c2-a453-08de27760342
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2025 14:14:54.6907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qh9C9q2Yrj6En1OnolM8P8OCVTDG9y58WKrNsBxeO63oZvpTXCfnwKPej9mEijt/6KA/H9QyYcobi8eH9kRL+tFZO6s01oanzJ8XV/o9ykE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB9998
X-Authority-Analysis: v=2.4 cv=MM1tWcZl c=1 sm=1 tr=0 ts=691dd0e1 cx=c_pps
 a=81r77geWhBIZzI7tvg4+jA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=64Cc0HZtAAAA:8 a=07d9gI8wAAAA:8 a=yMhMjlubAAAA:8
 a=fk1lIlRQAAAA:8 a=9qxNCY_qAAAA:8 a=j8RhgVXbAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=bN1JqijVroZvCFaGr-cA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22 a=e2CUPOnPG4QKp8I52DXD:22 a=U75ogvRika4pmaD_UPO0:22
 a=3SzYsRL22XtqO3ZTpi69:22
X-Proofpoint-ORIG-GUID: Sva67yfkvWdFvY-2JeZnxbOrLEs7WgiR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE5MDExNCBTYWx0ZWRfX9B4KQtb/oN9i
 AUbxQJI+RAaR3ZdBloAw6haMBp9nJwNfMRS4KiWqL4otkVHdaDQL0+Q3TilmSkq2HCaEktCu+k6
 Z64X36DeP92Svb9krlSNoLJaxzAZeJsZpan9KUUBpSndRNbg5lOND/7VGmDsRhDcxifVRuvM9r5
 k+DHFSSSSZkzvJCKouN7HEhb1YGH76j9Td92HKdeKgbOP/79SZy++O7b+yeY0fYimnJOTlyO1ki
 Lh+YDXnCaHFM7gc/sNL/powKguwh2uH06vrh4DC7Ngi8CH37BaORE0Llm08ZV7KbulfFXK5nF0z
 q96ma6W5a1r5fzD2Pvd/SCFvfpPI5jVVTYKgWF0T6DFEDGjSJgOggd/rCPy9MyIpAUYru9LISsl
 TTK61/tvnfkd8FY1RvACiEj7mCfG3Q==
X-Proofpoint-GUID: Sva67yfkvWdFvY-2JeZnxbOrLEs7WgiR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Reason: safe
Received-SPF: pass client-ip=148.163.155.12; envelope-from=jon@nutanix.com;
 helo=mx0b-002c1b01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

DQoNCj4gT24gTm92IDE5LCAyMDI1LCBhdCA2OjM54oCvQU0sIEFsZXggQmVubsOpZSA8YWxleC5i
ZW5uZWVAbGluYXJvLm9yZz4gd3JvdGU6DQo+IA0KPiAhLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLXwNCj4gIENBVVRJT046
IEV4dGVybmFsIEVtYWlsDQo+IA0KPiB8LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSENCj4gDQo+IFdlIGhhdmUgYSBudW1i
ZXIgb2YgaGFja2VycyBmcm9tIE51dGFuaXgsIG1ha2Ugc3VyZSB0aGV5IGFyZSBncm91cGVkDQo+
IHRvZ2V0aGVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5l
ZUBsaW5hcm8ub3JnPg0KPiBDYzogTWFuaXNoIE1pc2hyYSA8bWFuaXNoLm1pc2hyYUBudXRhbml4
LmNvbT4NCg0KTm90ZTogTWFuaXNoIGlzIG5vIGxvbmdlciB3aXRoIE51dGFuaXggYXQgdGhpcyB0
aW1lLg0KDQo+IENjOiBUZWp1cyBHSyA8dGVqdXMuZ2tAbnV0YW5peC5jb20+DQo+IENjOiBNYXJr
IENhdmUtQXlsYW5kIDxtYXJrLmNhdmVheWxhbmRAbnV0YW5peC5jb20+DQo+IENjOiBKb2huIExl
dm9uIDxqb2huLmxldm9uQG51dGFuaXguY29tPg0KPiBDYzogSm9uIEtvaGxlciA8am9uQG51dGFu
aXguY29tPg0KPiAtLS0NCj4gY29udHJpYi9naXRkbS9kb21haW4tbWFwIHwgMSArDQo+IDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbnRyaWIvZ2l0
ZG0vZG9tYWluLW1hcCBiL2NvbnRyaWIvZ2l0ZG0vZG9tYWluLW1hcA0KPiBpbmRleCA0ZTY3YzNl
NDg0ZC4uYzA3ZGZmYzUxYmQgMTAwNjQ0DQo+IC0tLSBhL2NvbnRyaWIvZ2l0ZG0vZG9tYWluLW1h
cA0KPiArKysgYi9jb250cmliL2dpdGRtL2RvbWFpbi1tYXANCj4gQEAgLTM1LDYgKzM1LDcgQEAg
bHduLm5ldCAgICAgICAgIExXTg0KPiBtaWNyb3NvZnQuY29tICAgTWljcm9zb2Z0DQo+IG12aXN0
YS5jb20gICAgICBNb250YVZpc3RhDQo+IG5va2lhLmNvbSAgICAgICBOb2tpYQ0KPiArbnV0YW5p
eC5jb20gICAgIE51dGFuaXgNCj4gbnV2aWFpbmMuY29tICAgIE5VVklBDQo+IG52aWRpYS5jb20g
ICAgICBOVklESUENCj4gb3JhY2xlLmNvbSAgICAgIE9yYWNsZQ0KPiAtLSANCj4gMi40Ny4zDQo+
IA0KDQpOZWF0ISBUaGFuayB5b3UgLSBKb24NCg0KUmV2aWV3ZWQtYnk6IEpvbiBLb2hsZXIgPGpv
bkBudXRhbml4LmNvbT4=

