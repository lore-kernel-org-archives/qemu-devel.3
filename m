Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9B2C25B75
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 06:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sE0jd-0006gA-SK; Mon, 03 Jun 2024 01:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jb-0006f7-Qu
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:55 -0400
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sE0jZ-00072M-RV
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 01:59:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1717394394; x=1748930394;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=acc0XnlBTdWdElPteZmm/CA3s/ptFk3pV/0xf9UxvH8=;
 b=uKMPl2HqthknXeq+41F/P47bM9xcsfjrUTJOe8H5GdZZyzSaV1gR6obH
 H6AgP1k145Ac9v18HSFTh0UtrRHPFFKWvWlwb8QId6e72KJu4Lo2qTIER
 Wo7bUCWOjlEvVrpfCAztm4erId+9Ixy0GmxcRiDU3QIC1WU/drTwtD5Mz
 g3wgkjF6dOOMjsFafgwJvCLjVSMKLPXqu3yrJx3rceTovOkgj3UERtUTT
 lpBGfAogx6rh/wN0u3ZfenAK1eYz9uVhtaoPdMdRJu2xsr/OThjzdfOyd
 j/QZc715R/TrZKc8AJ5F2iQNtgz1SDC/kVwuHeNvPK9LN1P3mQVZFQ9Lp g==;
X-IronPort-AV: E=Sophos;i="6.08,210,1712613600"; d="scan'208";a="13763240"
X-MGA-submission: =?us-ascii?q?MDEyFvRha8IsJXlP/gqwAblC3FzKbidQSdwk4F?=
 =?us-ascii?q?uY/W+YTr+9/S5wsLs3Pod4G78HrdyvwOaDLAHPrHq6bqM6W8yM0WmzQx?=
 =?us-ascii?q?ZflNEaL8my9Z21PcOtEO2nI++nCHQ8HK8Kx39qyevVBVMUptqBjJuTJ7?=
 =?us-ascii?q?gDT6xeQAfkR1g7G1WUkFO+JA=3D=3D?=
Received: from mail-he1eur01lp2051.outbound.protection.outlook.com (HELO
 EUR01-HE1-obe.outbound.protection.outlook.com) ([104.47.0.51])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2024 07:59:51 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OkQcw5RavQjBkbVsa9pUSQoKwU4NJkUFs9jlh9857EgE0Z/3l4zC0EMYFkmFvCKwvWilSP3eoYpIGxSn+lJxg1cfhNAe+SW8YMiSE6NZ2lMF3kC4FlxUig4yKtzlKO8UkfNS0Wjl29WMQpK99JnLCBsUfN9g2yYo+eb5rF+VTMnSHq+scQGvoejtMQvmhqxEfENzn6+8++v4eCOTosI726L+M0mhdyh0LiGmarf8TDP6yokH0c7b02ofBNBkcbsldCZn6egdy9nqOwDmj2IJNfXeREvINUDE9Pqov8Vf9mNCJ1/LyC+lb3qqrAjcKWrof+Dxl98wn0vxWb5es6ow9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=acc0XnlBTdWdElPteZmm/CA3s/ptFk3pV/0xf9UxvH8=;
 b=hraPycEsjMYjNMcn5APBafZv8x7gjyEsXUJ76NBqVK9e/Bju3HnBwfkUQkax5bnLPMIN9GZsc00m37yGomJaSZYo5mcVylZ49u18yCKyiGeZgdOrm/xQyV3c8yptYqgkr27hgrnaAWdH8Ae2CPLhnU5BmCjJqN+q9GVK5s/+w+CH6ZnGrnuac4Mx2SlbCJL2w2R3PQH0JXc36oLKtbKOPeear40x/sWfbKqEpqidPUG7fwjNYbFsSaFInU2KiEUnFkABP8aXICLiNXzmaUW6+a6z1nVB5XsWZattQ+MR9WQ0fqtGKGvMat8qIXBmNSqfEjPESwHi7RrjIZD6wXQI7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=acc0XnlBTdWdElPteZmm/CA3s/ptFk3pV/0xf9UxvH8=;
 b=pH0ijjeEtBmx0o8UJavljH+9OaRocCk1rX21rAN+ERWliuNkXLsILrKt4uYfio2vC6+eYWyd1zmFZfwqyumrjYG9RRfcoHUTs5Md1o7iEjLR1GhThU41xtss8uHVkTloj1ysMFgQmxNa9CPgp9EBuT3hgYtG690P/Iq7o0LLSYxbzvw2dhMF777brLcaddiMilkwDYae/EHvLli+U2w8f+yEIK4H0haWYeiW6OQLhHbsrftLIUEIrsthxhokQkIrhiWJUBbNC+gufDrB2SvfTcBXPJYPeAl3z/MiLzuTc9N8Jai8m/phhmbXnizsIAUU/3ePOtDy5k2po35f7J5+BQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by VI1PR07MB6238.eurprd07.prod.outlook.com (2603:10a6:800:136::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Mon, 3 Jun
 2024 05:59:47 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 05:59:47 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, CLEMENT MATHIEU--DRIF
 <clement.mathieu--drif@eviden.com>
Subject: [PATCH ats_vtd v5 10/22] pci: add IOMMU operations to get address
 spaces and memory regions with PASID
Thread-Topic: [PATCH ats_vtd v5 10/22] pci: add IOMMU operations to get
 address spaces and memory regions with PASID
Thread-Index: AQHatXs9KwLmXjyVvEupV37REpL8HA==
Date: Mon, 3 Jun 2024 05:59:47 +0000
Message-ID: <20240603055917.18735-11-clement.mathieu--drif@eviden.com>
References: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
In-Reply-To: <20240603055917.18735-1-clement.mathieu--drif@eviden.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|VI1PR07MB6238:EE_
x-ms-office365-filtering-correlation-id: d5d58363-0ddd-4808-2a04-08dc83925f9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: =?utf-8?B?QlAvb2plUjRnZjNUNnVMMEtITU1tOEYxdHhPUEpZbkVjdExVMXJXODhLUGU1?=
 =?utf-8?B?QUM0RkI1ZFBIMEU4cmVZTWhPbktrOXRiRSt1Q0xjL3JSVWRCZTBWZEV1ak0x?=
 =?utf-8?B?T1BEREd5cFVDd0VEc05ZYXlCKzdHeFdOSXdwaGhqT0lOVEVkOTMzV1oyTnpD?=
 =?utf-8?B?N1ZLazZoZlFDMWpQT28wdUQ3R09XTGRpTnZvaEhXOXU3bkRkTXQ5ekhVamxH?=
 =?utf-8?B?T3I4Y1ZkMlFyTVF1MlBHZkR1S1FSK1hsQXpzR3J6RGdQczZVdlFtdUlLTDV6?=
 =?utf-8?B?emtSSGdTUzJaNlVkMzdLd3Nwd3h0UkNmbGplVGpJYm5OcnJSVkdyT1VJNnpx?=
 =?utf-8?B?WWwzaE5OUjZRMG9RSzB4UmpJaEhMbER6bzVPSzhid1R4S21SUllsL0Z3azJ6?=
 =?utf-8?B?Q3NzaE1IUTZndHo2eFRNellTOW1yR1JsNHVPT28wcUhNRExKLzBDYUhnTlhv?=
 =?utf-8?B?Q3ZpL1lPY1h3QkgxMno1bFBtUzkyZTRiYnloc1E4ZnB2WkRkRXRGVlVBdWE0?=
 =?utf-8?B?N01ucHBCUFA5NkpKcHE0dDNseG1nNzRsbTdjWU80RE1nZHpDTDhhN3RpSlc4?=
 =?utf-8?B?T1lNOFN2TkVTWEhtSHlkcUdSSUJoamYySk0xK0R1OXVNYW1kYmZxRmJ4d1pJ?=
 =?utf-8?B?RVpIcWZzR0kyNzR5OUlqelgwNkF4TlRlLzMvdkpabWVzcGd5dDIwdHNZbFJO?=
 =?utf-8?B?MzhNTnlzeVpnWnFROUhYbmxYTWkrOG84TkN5WEtuN2JFTE51bkxPbnhKT0ZF?=
 =?utf-8?B?YjhlY216THUzNmlVb21QUHkyRzV4dk5FSUs0cTVja0VwQnJESzZJdWZncjc2?=
 =?utf-8?B?MFJnQi9VYXQ1eUpmU3JHT0NyWW40VFVkTDN6eStPRlBuRUVEZFkzUXpkL2xS?=
 =?utf-8?B?NjhvOG5kb1hmZVFtc2pGSHdWbWlPYTJ2N3ZaRGZNWWxkMm8xMjBUZUV3SVlk?=
 =?utf-8?B?djN0NWFOVUl1bGNERFRueC9MV29CK0tPYkxxQ05IN3RDd3RqOGRKdzVYR3Uz?=
 =?utf-8?B?VUZPU2dLd1VQelgrQjlYY2pHaHRBRHp6LzJTM2JBblhWYnNENFlHdkUxaFhi?=
 =?utf-8?B?QnZBc0ZRbkFmKzJ5dmY0dEd5WEMzVXdzakVEN1VpVWEwWkpLSis5V3ZRb3F4?=
 =?utf-8?B?K3pmR2NVZ3R1emF6UWRtZmZIaU1mNVNYTld3a2x3emUzTkc5UkRUWThMdXEx?=
 =?utf-8?B?elo1blRhcUFYVGRzY0JTT00vMzgzS2p3NitSLzFHTFpvdzBUMmFyUUd2VnZs?=
 =?utf-8?B?S3M1dVVFQ3JTakpkdUIxUEFLZHRqUlJlTDQwUXJncXdjNHVNa0VoekFCOEJV?=
 =?utf-8?B?bzh2b0pnT3Ric2lLY2JKM1pNcnlML3dLSEg0cUwrakd5NHh4MXpLaTZsRUlG?=
 =?utf-8?B?dXhzcDZuTzhCeC9TU0Z0akRENks0WjFWcnVuMUgxLzVCYzN1cnNGRW1OUFoy?=
 =?utf-8?B?TkpHc2FJNDVVaHdXWXl4S2pzdDJqZW9xakJuL25xUit4VHkzM25YazVGc09Z?=
 =?utf-8?B?TVQwRjdQdFROd0ZyWmxGdm01cForNEJqdXhjdGFzV3dKVFdJZ1E2M0drVGFH?=
 =?utf-8?B?WGxOYzNka3VSSUhLS2RvR21lYS92dXlPakE0YTZGM1BOU0lVbXNEY3UwK1pR?=
 =?utf-8?B?Y3NkMitacEdqRTRoelhwNE5UR2RJTEFyTm5FVk1nOHo0RS9TYXUrNDVUdmEv?=
 =?utf-8?B?UE5Qb3BvWnZubFZ5dXdkQ1EwYmdlVnlaVWJrRlRtd0tGcnZYODNLa3oyaUNt?=
 =?utf-8?B?eEJ0TzAzOUZuVENJQzZCOThUcDkvNWJqNXo4QitHQXNwQVE5VXlCbmtkVHZL?=
 =?utf-8?B?YVlieC80SUE2eFdKNjdEQT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEI1TVd3L0VMbGEwYlBZbUc2UHdtajgwVmJJamw3dmlpNWVIZ0FqcEk5blpt?=
 =?utf-8?B?Z2JUS090blE1b3Mwdm9uQUlEWWJVcE1IRXFOUTVnQjZLR215MEc1aDZkbjhN?=
 =?utf-8?B?S3BYQ1R0YWE0R3U4LzBudktJQ2VGVzdYdS9hZFBxdisvRndFM0hqdFkvamFI?=
 =?utf-8?B?ZGJzTHZPZ2o3Ymp5cTNGU1dHQ2h4N0ZKWkhqUloramh4QmQ4NDBYZ1VuODZS?=
 =?utf-8?B?YU1icXRNUzJOSmhnVWxwb25zYXh2TFFaei9UZ2xvR0UzVGVHYU1IRVhyTjdQ?=
 =?utf-8?B?L0tZVzkwRzAyOU5jV0Q2VmN6WTNuMHVYLzZoV2ZzVzVnWkpSNldKQVRUL2Mx?=
 =?utf-8?B?TUlaaXBxenlXcCt6ZVdpUnltckhnL0plaGFMU0t6T0g1TVk3UDE2SjZBcG1Q?=
 =?utf-8?B?ZFpQOUxRR1ZaZ09BK001Y0J2YmNnVjdFc0VNNGc4dEdaNmZvQUFlWkN6YlB4?=
 =?utf-8?B?Ly8vanlhanZld0JuSEp2ZFhOd2JYckU3S0dBT0pxbFpUWjRIZDFGdEk4QWkv?=
 =?utf-8?B?RUtXayszQVhvTFlaeVZxbjZUUDlmMEhaWjNHRVorRUhENXVDT2p0WENSeDB5?=
 =?utf-8?B?elYzUVBOb1RjYXBtWjNnMlJMNnE3cFZFTWh2cXhkUHV0SjRKNjJlNU1LKzhy?=
 =?utf-8?B?R3BDTDAwUDZsa1hrSmpybWJKeDRKeUY3S3VDY2tRTWtaeGoyRkJXbzQ3ZjBt?=
 =?utf-8?B?YVM3V3JyL0pwTGVtQTE3bUd5Z1JHdjR3bldDazZ5S2p0SnJtSVp2YUJRRkYv?=
 =?utf-8?B?UkpOZjc0dUpiYmk5ZVcrRzc1VkgrcjJrUDJ4WVl1TnNZUFdWaTBOU2hjaWQx?=
 =?utf-8?B?T1hYSHRRcHFmN3hESjRuNXQ4eE1OWXJlSmZlT2JBNlMvMGhhT3JZT28yNmV0?=
 =?utf-8?B?SXpTeUxacWI3T2ZrTGtBbFNRSDVON3o4QWtKYlVFcTJkdXg3Z0htTmd3Ulps?=
 =?utf-8?B?b1paVGdoQkNkWXNXK0xyeUFucUlZVVpFOXU2MkZ6b3F5MTlTRVllQUNFTEVF?=
 =?utf-8?B?MUY0QVljNUNFbXdOZGwrZW5oaWw0RTFQeDJyU2RFcjJCL1g3U2xNVGRLNE5R?=
 =?utf-8?B?RXRHRjY3QkUwdlQ0cDd4RXdWejJjeWZIczdKcVdGdy9RNDhEY1FTRlB0SGRs?=
 =?utf-8?B?L0VFclAvVHREcmlKemFZb3Z5eU1PbjM4QTRoOW9QalRQYWtjN3lueXMxbGhk?=
 =?utf-8?B?WXVqYlR4RjBxUnJnSnBpRG04endyREF2ZTdaVjhOSmxBSm5TY3NDOTJwWERq?=
 =?utf-8?B?ZklzWUNhL0IxaHFlUUMwQXFmQklkUXJmVmJ0dEZVN210dlRFNExnZ1Zid0py?=
 =?utf-8?B?djk0TTJTQis3aHFxU0kxNHFYRmRmQzlGT0NZQk4yeE50aDcyZ2p5cjA2WmZP?=
 =?utf-8?B?ZWxGRDdFVU84eXB2RWZLcVRhYUExY0lOa1BkSy9md0hrQ0NrcFhtWkU4cEV2?=
 =?utf-8?B?QTNGYjhlWlpIVERJcnR6MEhXeldDcWREUjVDbmlnWnRpeHpvR0hOQUpsREth?=
 =?utf-8?B?Q0d4WVc1YiszK2JIWXpTZWFWWVRqMjk1RXN0UjQzVkc2ZktHYlVnRkdvcUg2?=
 =?utf-8?B?SDlKelJEemN2UjVjZXVYRjl5RTJzNVRyeWY4VkxJR2NvZm9BVXVlbnVlQ1M5?=
 =?utf-8?B?THI2bHV5RG15ZnhHVTNuV3FnbWI3dXVWMlBFdlhqeTFtNCs5cW9qTVl0c25p?=
 =?utf-8?B?V3dPY1BsNjhvYnJQb1NCd1NkanBNajBpblBTdVp5SmkxUlZlOW56ZlhwbmZ2?=
 =?utf-8?B?NncvWUxacy94cTA1M2pVYTdxd29iM1Zmdjk5TWlMRnc5dXg2UWFVbjBTU3Bx?=
 =?utf-8?B?OGhma1k0b0w3a25ZbmJzT0Q5SktiME5wTnVwd3JsUnJ1bGt2OHZQV056bzNz?=
 =?utf-8?B?NjdEeHcxNDJnaXR4L0hSZGNKVHZaY3RTeVRjSWhtWmlST2dQRmc3Ti9ZaG12?=
 =?utf-8?B?SFUyN1Bwd2JqcUhjNitRSGtuQ1NnNEIzSm1kcHdhUUtVU0d5dUlyaGpmQmhh?=
 =?utf-8?B?TGV6T2tJWGlpK29tT1ZCR1hEaWNlWXFrZVl1b0g4dWZ5QW1PVGw2RkZkdFVh?=
 =?utf-8?B?c09DVlVrZXRQT1ZpMjNjM0N1bHRyVUNnazlka0FaMExwQUZjZEF3SktLZmRa?=
 =?utf-8?B?QjZJeUNxYjViNnpUeWJZdDVHcy9ReUY3Z1RuZFE5VmptWXl0TUcwN2RDZ0xn?=
 =?utf-8?Q?Gjyu9lt6Zq6/4nn9ddDFH88=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C00E88A528EB74479C1617C7C68898D8@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d58363-0ddd-4808-2a04-08dc83925f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 05:59:47.2109 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WEQYzi64BlfSRPu6wgbsZVHKXZ/3l6qV8P5qxjCIiTfILRGCeU2Dqr8U574cFQu/+EfVk2j9MEn3a5AmeTDOJMh/r86tar59iOHeBaRtsyf4FTfEgIWhYC0DbjeC1bCm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB6238
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
bWF0aGlldS0tZHJpZkBldmlkZW4uY29tPg0KLS0tDQogaHcvcGNpL3BjaS5jICAgICAgICAgfCAx
OSArKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9ody9wY2kvcGNpLmggfCAzNCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQogMiBmaWxlcyBjaGFuZ2VkLCA1MyBpbnNlcnRp
b25zKCspDQoNCmRpZmYgLS1naXQgYS9ody9wY2kvcGNpLmMgYi9ody9wY2kvcGNpLmMNCmluZGV4
IDUxZmVlZGUzY2YuLjNmZTQ3ZDQwMDIgMTAwNjQ0DQotLS0gYS9ody9wY2kvcGNpLmMNCisrKyBi
L2h3L3BjaS9wY2kuYw0KQEAgLTI3NDcsNiArMjc0NywyNSBAQCBBZGRyZXNzU3BhY2UgKnBjaV9k
ZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZShQQ0lEZXZpY2UgKmRldikNCiAgICAgcmV0dXJuICZh
ZGRyZXNzX3NwYWNlX21lbW9yeTsNCiB9DQogDQorQWRkcmVzc1NwYWNlICpwY2lfZGV2aWNlX2lv
bW11X2FkZHJlc3Nfc3BhY2VfcGFzaWQoUENJRGV2aWNlICpkZXYsDQorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgcGFzaWQpDQorew0K
KyAgICBQQ0lCdXMgKmJ1czsNCisgICAgUENJQnVzICppb21tdV9idXM7DQorICAgIGludCBkZXZm
bjsNCisNCisgICAgaWYgKCFkZXYtPmlzX21hc3RlciB8fCAhcGNpZV9wYXNpZF9lbmFibGVkKGRl
dikgfHwgcGFzaWQgPT0gUENJX05PX1BBU0lEKSB7DQorICAgICAgICByZXR1cm4gTlVMTDsNCisg
ICAgfQ0KKw0KKyAgICBwY2lfZGV2aWNlX2dldF9pb21tdV9idXNfZGV2Zm4oZGV2LCAmYnVzLCAm
aW9tbXVfYnVzLCAmZGV2Zm4pOw0KKyAgICBpZiAoaW9tbXVfYnVzICYmIGlvbW11X2J1cy0+aW9t
bXVfb3BzLT5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZCkgew0KKyAgICAgICAgcmV0dXJuIGlvbW11
X2J1cy0+aW9tbXVfb3BzLT5nZXRfYWRkcmVzc19zcGFjZV9wYXNpZChidXMsDQorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgaW9tbXVfYnVzLT5pb21tdV9vcGFxdWUsIGRldmZu
LCBwYXNpZCk7DQorICAgIH0NCisgICAgcmV0dXJuIE5VTEw7DQorfQ0KKw0KIGJvb2wgcGNpX2Rl
dmljZV9zZXRfaW9tbXVfZGV2aWNlKFBDSURldmljZSAqZGV2LCBIb3N0SU9NTVVEZXZpY2UgKmhp
b2QsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKQ0KIHsN
CmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3BjaS9wY2kuaCBiL2luY2x1ZGUvaHcvcGNpL3BjaS5o
DQppbmRleCBjODRjYzliOTlhLi42YzYwZjdhN2M1IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9w
Y2kvcGNpLmgNCisrKyBiL2luY2x1ZGUvaHcvcGNpL3BjaS5oDQpAQCAtMzg1LDYgKzM4NSwzOCBA
QCB0eXBlZGVmIHN0cnVjdCBQQ0lJT01NVU9wcyB7DQogICAgICAqIEBkZXZmbjogZGV2aWNlIGFu
ZCBmdW5jdGlvbiBudW1iZXINCiAgICAgICovDQogICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2Fk
ZHJlc3Nfc3BhY2UpKFBDSUJ1cyAqYnVzLCB2b2lkICpvcGFxdWUsIGludCBkZXZmbik7DQorICAg
IC8qKg0KKyAgICAgKiBAZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQ6IHNhbWUgYXMgZ2V0X2FkZHJl
c3Nfc3BhY2UgYnV0IHJldHVybnMgYW4NCisgICAgICogYWRkcmVzcyBzcGFjZSB3aXRoIHRoZSBy
ZXF1ZXN0ZWQgUEFTSUQNCisgICAgICoNCisgICAgICogVGhpcyBjYWxsYmFjayBpcyByZXF1aXJl
ZCBmb3IgUEFTSUQtYmFzZWQgb3BlcmF0aW9ucw0KKyAgICAgKg0KKyAgICAgKiBAYnVzOiB0aGUg
I1BDSUJ1cyBiZWluZyBhY2Nlc3NlZC4NCisgICAgICoNCisgICAgICogQG9wYXF1ZTogdGhlIGRh
dGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KKyAgICAgKg0KKyAgICAgKiBAZGV2Zm46
IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQorICAgICAqDQorICAgICAqIEBwYXNpZDogdGhl
IHBhc2lkIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1lbW9yeSByZWdpb24NCisgICAg
ICovDQorICAgIEFkZHJlc3NTcGFjZSAqICgqZ2V0X2FkZHJlc3Nfc3BhY2VfcGFzaWQpKFBDSUJ1
cyAqYnVzLCB2b2lkICpvcGFxdWUsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGludCBkZXZmbiwgdWludDMyX3QgcGFzaWQpOw0KKyAgICAvKioNCisgICAg
ICogQGdldF9tZW1vcnlfcmVnaW9uX3Bhc2lkOiBnZXQgdGhlIGlvbW11IG1lbW9yeSByZWdpb24g
Zm9yIGEgZ2l2ZW4NCisgICAgICogZGV2aWNlIGFuZCBwYXNpZA0KKyAgICAgKg0KKyAgICAgKiBA
YnVzOiB0aGUgI1BDSUJ1cyBiZWluZyBhY2Nlc3NlZC4NCisgICAgICoNCisgICAgICogQG9wYXF1
ZTogdGhlIGRhdGEgcGFzc2VkIHRvIHBjaV9zZXR1cF9pb21tdSgpLg0KKyAgICAgKg0KKyAgICAg
KiBAZGV2Zm46IGRldmljZSBhbmQgZnVuY3Rpb24gbnVtYmVyDQorICAgICAqDQorICAgICAqIEBw
YXNpZDogdGhlIHBhc2lkIGFzc29jaWF0ZWQgd2l0aCB0aGUgcmVxdWVzdGVkIG1lbW9yeSByZWdp
b24NCisgICAgICovDQorICAgIElPTU1VTWVtb3J5UmVnaW9uICogKCpnZXRfbWVtb3J5X3JlZ2lv
bl9wYXNpZCkoUENJQnVzICpidXMsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdm9pZCAqb3BhcXVlLA0KKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBkZXZmbiwNCisgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBwYXNpZCk7DQogICAg
IC8qKg0KICAgICAgKiBAc2V0X2lvbW11X2RldmljZTogYXR0YWNoIGEgSG9zdElPTU1VRGV2aWNl
IHRvIGEgdklPTU1VDQogICAgICAqDQpAQCAtNDIwLDYgKzQ1Miw4IEBAIHR5cGVkZWYgc3RydWN0
IFBDSUlPTU1VT3BzIHsNCiB9IFBDSUlPTU1VT3BzOw0KIA0KIEFkZHJlc3NTcGFjZSAqcGNpX2Rl
dmljZV9pb21tdV9hZGRyZXNzX3NwYWNlKFBDSURldmljZSAqZGV2KTsNCitBZGRyZXNzU3BhY2Ug
KnBjaV9kZXZpY2VfaW9tbXVfYWRkcmVzc19zcGFjZV9wYXNpZChQQ0lEZXZpY2UgKmRldiwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJf
dCBwYXNpZCk7DQogYm9vbCBwY2lfZGV2aWNlX3NldF9pb21tdV9kZXZpY2UoUENJRGV2aWNlICpk
ZXYsIEhvc3RJT01NVURldmljZSAqaGlvZCwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBFcnJvciAqKmVycnApOw0KIHZvaWQgcGNpX2RldmljZV91bnNldF9pb21tdV9kZXZpY2Uo
UENJRGV2aWNlICpkZXYpOw0KLS0gDQoyLjQ1LjENCg==

