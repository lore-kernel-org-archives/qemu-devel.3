Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E15D6EBE2
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 07:47:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGvfi-00081T-Ro; Fri, 29 Nov 2024 02:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfb-0007z6-F3
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:09 -0500
Received: from smarthost2.eviden.com ([80.78.11.83])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tGvfT-0002eL-7w
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 02:44:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1732866239; x=1764402239;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=m6yDis67dF1alZmmiGn0X8kfeXfpoNZ8C44721iYd5Y=;
 b=OhI/vO86mw1MfJnjsbCWXmc2C+GnhPxXNDfWZ8Jo03/0bnvq/dZPJz4+
 TJSd4kHQ0s9R1+CQLLECU5bOJ2VL3jvGukVka8hGsW0XOcvWTrg9+GXoy
 nutQIdRX3fqlQXymCuCSQDA5q1wnftO3Msmb9NnUCN1TULYUZVRkdaGEK
 O99r7TSoTbS7JNioMpZJuYKEXBXbliza/Q6ZvSLLoofQyanztW0cT1sNS
 9SfmWLfidEQv9hbHcD9A3YGwpwewdE5pirxDufT0VzOAK75iIJJxTFV5M
 WsQawUf7diKj3JgnbLsaLjrjiNrKnSCRe2Kvh503aAhLLkuu/WcNK+y+H g==;
X-IronPort-AV: E=Sophos;i="6.12,194,1728943200"; d="scan'208";a="25670801"
X-MGA-submission: =?us-ascii?q?MDGd+gu3E8dwwfAWmaJ4UUlpW8tOeM0lwfXLuX?=
 =?us-ascii?q?2SmGIK/IkiY+UceDBeBF/G9ZBCG+DUTcJxppFSkov3Uxtvw0N2oVCJkt?=
 =?us-ascii?q?Ny91fErWmi3kk00cTaUe7hp3gKZtwXz1T3eBHBR9Oeps/CF9u6sQj0CE?=
 =?us-ascii?q?8TEoYswuP/43hh/ejSuSxWng=3D=3D?=
Received: from mail-am6eur05lp2104.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.104])
 by smarthost2.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2024 08:43:58 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCVf87RXf2d1j8fo0xUvnn3+LzesxLGDnOth0RQ54ciQwEEFGUUZJfUmK8vXRoycOWBh1C7sA2v9DyK2v2ptlm647ox9tpA/9zpsqIlFYrBAG75IZtd8vqZJ+rs+pv+knMQe/WHQ3jdsS7RN62h1iCCyV4GrdT0KWN1lZ0xMFeWM8g5U2GNFfo7decl5pZDhu5FJj8rmJlRJZEOIPG/m/tSHnZCTiyVe7x3KZWXFXAVfbQTCuIlk3IdzrzST8DQTECcOGcaKpMR/LquhTr0/Zxaa1J02Bv5lIrIvpPrs53VAZ0H3dcLWC0WWSWv/XMIi7XEyE9jXCZVqtzEiAU7qxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6yDis67dF1alZmmiGn0X8kfeXfpoNZ8C44721iYd5Y=;
 b=TWkzbS9CQbArM+8huw4ARd8k08f1LxmrQ6k6rTrQ4tOw3qycMfBt9OpneL/lllNa6HJGrePZ+jhbzMtYfo/l4zLp3oC9UH+N4yeZbWKbFkdLMUtib5NokFIXIeL6lK4KXiYxVxp47DVMaWkGH70fD3YILQ8ZTFw5bDTKx9NnHehga7+kDYDYMf6OdDvsD7B4AGBATFxFZD1bf5HLXJ40V09qPSiPGLSQTCaIrCw+j7FnE39PPba/J26C2hqPr47kCF/xIEUepdL2VSblz26s8y+NWGnNxSZSEpMnpIEJ+tAyB/hpeLks4T1ccrsZKwIw6lKUWy3hdvnDkC6KhGNM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6yDis67dF1alZmmiGn0X8kfeXfpoNZ8C44721iYd5Y=;
 b=bcpU7CCnPl1La1UkErRlyuqbRV5TnUzt62eGJb+ekEePWqUYs0uLFC20vDH92W44nQQILz72Zd198VMuQuIWdHcZvpvBaT8cH3nxpvG9lnL8rkovsSWjgwr2Xkrbzyh3SVTU7KopBfjNCL3z6wA87HZBYE/EC1bvOeS/Lryj9Dvyt+FDDhEhoRmxEYZ+G3+9I9jcjiinpbqLekrGuESHjZvLGZIIhAme/3Z3sHDjLYztQ3knPArN2CJQ6L7cC5pjO6xQg9Y0OkFMcehKe/dP2NjJMaVPPcH9CXUWhTAoIOGpHeBh5hcRUSXOWtwhAiC6hAbTUAcWOMmzGE4Dgz92iw==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AS8PR07MB7847.eurprd07.prod.outlook.com (2603:10a6:20b:39e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Fri, 29 Nov
 2024 07:43:57 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8207.014; Fri, 29 Nov 2024
 07:43:57 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "mst@redhat.com" <mst@redhat.com>, "tjeznach@rivosinc.com"
 <tjeznach@rivosinc.com>, "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Subject: [PATCH v1 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Topic: [PATCH v1 11/19] memory: Store user data pointer in the IOMMU
 notifiers
Thread-Index: AQHbQjJyHnrIgNnsXECB7r/kjdHmtg==
Date: Fri, 29 Nov 2024 07:43:57 +0000
Message-ID: <20241129074332.87535-12-clement.mathieu--drif@eviden.com>
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
x-ms-office365-filtering-correlation-id: 803f1af2-d758-4f6b-5c63-08dd104994e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MDZZbVpCcE5Ia29HdHdXR3oxb3dESGcraEFUOFhYRTBtNENEaTA1Z1hiZzRv?=
 =?utf-8?B?SWROdDZGQUxDRzQ1UEpiV3FxWVBBaTZkZXo5WEV5aFlycUZENnhKQ0VNcTli?=
 =?utf-8?B?Q2lZR0pxNE5DS3VVemtqWFRXTlZqamRaenl2OXluOGJJMG0zanZQUTFvdlFU?=
 =?utf-8?B?Q3RWRHlDbmZjYWptS3lhb2JBQ3RYeExPbW9EM1U0REpZUG9kMFFyeWRFQjRX?=
 =?utf-8?B?WC9uTVVHT05lWnlZdWZHcVhDNEpqU3VoR1IzQmJnbER6Y0RTWUhUS2FhRE9W?=
 =?utf-8?B?ZVRmc09FRFI0L0NNOHlIdnNvSXUxeWdpOVc1Q1FrNFpncUJRVVdhNGJRVXpq?=
 =?utf-8?B?WW43ZkpEOFgrYXorR3JIbGpKUVA3MDlQUEowbENVWTc2YTJYM3lPNVdLZ294?=
 =?utf-8?B?Wk5sdjdrMzM4SlpNTndBblJpenpQSCtPMENuejVUVHpqTy9ianFtcUF1N0VS?=
 =?utf-8?B?M2poRndLbE03YktXaU13aUJ2RXZlaStvbS9mRmJwRURVVUhyVklDUFpvWDNo?=
 =?utf-8?B?Zm45QVcrT3MvWkR3TjNDa1d3ZFY3cGljM0t4dEl0Ry9NdTA1K0s0dDR2Mith?=
 =?utf-8?B?dGJtTE1wRXpGYU9abjZ0amFJTi9BTnhxNEhoL3JpQ0p4VEk3b1hjWkR0bzZY?=
 =?utf-8?B?ZVpYMjN3WEpZYk9BclV2QzB4dHRpdkVXVmwwVDRHMmpUL3V5cmF2N0hzSEVC?=
 =?utf-8?B?WVlvQmJtOWFsZUdicEhud2dTb1RPVkMwNC9pUGFDZFU3RDkwTndRYmtpd3Rn?=
 =?utf-8?B?ZVFVVkdlYUx4M2NIRC9lcVg4L2ZVa1czcFNQU3drKzFEVzJMaGlJZ2t3dlpk?=
 =?utf-8?B?YmdJWU42UVRVcG5USVM0Nmo3K0psT2d3c3BMcXBhQUszSmdZKzBzVW1IU1pp?=
 =?utf-8?B?Ym1PMFhuREtScWc0RHVMbXQyakJCZzlaS1hqQWJOZEFobGQyQnJLNERrS0FQ?=
 =?utf-8?B?RmtEOXdlU0dRbWgvMTZvcm4xYjc2MEhoNXNUcGlnREMwRUpWWkZROFMxa1Ey?=
 =?utf-8?B?RmtpMGNYYWUvUkMrM0M0bkZYdTdwa3JrZ2prdlYweHJoRVBKYU8wKzN2QStT?=
 =?utf-8?B?UWl2bW9aaUFNZDdBeWNhTG1WY2dvcjRxQWc0citmc3laYkRVeHNvVW02bFo2?=
 =?utf-8?B?eWRCKzB1aUI5dXdmaEJOeWVvM1BZTWd2N3BDbnlIdEpySmRCUlhzU0MxV1ps?=
 =?utf-8?B?R2JvZDZHenh3VDBqS2F4dFZMSkhCVjFNWmxHdmpUclF6UVdWeGJxdnJjMUJu?=
 =?utf-8?B?WS9vdlVwamNWanlEa25SekNrL2VMZUdmMmdlNVRZcG1WdjRXWjNVNWFGU3JB?=
 =?utf-8?B?ck5IcGtnU2lOWGhNbnkrVDlYUVVTd245RGU4NklROUJScnRweldUa1dJc1Rt?=
 =?utf-8?B?U3pnZERXbjNPOC93Zm9ycHNwRVhtYjFOWXg4ckRFNlpkdTdmUGp6OGtmT2Yz?=
 =?utf-8?B?Yk9OeDd2RDlIQ0Fmbk82MEh3Qk9qdU1zRWVXdTVtck45ZVVrMEhWY1MrQkh1?=
 =?utf-8?B?L2x5bHY4ZkJWYWpHUGhmZ2FmeGMwYi9EOC82MGpsS0oyZEhwT1gwMm5vV2M3?=
 =?utf-8?B?ZzhNQXZ0eHV0TU0wdGRSZ0dQa2NQYzJlRTVmcXpPZ0srWmIxUktCcUNmY0t3?=
 =?utf-8?B?TTZlank5NWdGU080SE5idllvRlZwaVdiY3VNSERvb2wwVFdndGZ5UGxlblVB?=
 =?utf-8?B?eStUM29pdmNLN0pCSkxqK3RURENnbkU4TXE5b1kzb3Z5dzBYVExGaHMranhO?=
 =?utf-8?B?Q0MrWUlxeTNKS25nYm5EcU4ra2VLTmJjRjVCM3Zud2FGOXE3bG1oaEl4Q00w?=
 =?utf-8?B?TjBWVklibnUzZFJNRkt2SDNobGJ0bnRUREM0ZTdGQm1UdDFnek9CbzFUSCtB?=
 =?utf-8?B?NmxlS0RXNUNhbG9TcnlmSHNHVUM1WXVzT0VUQ293ZUwzUHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmsxdGc5MWVmYnVicFZQdFBiVER5cmdJQnRFbVNtcWdDaWVld2IxV0M2Yktq?=
 =?utf-8?B?NUdJVTc3RHhTTTR1TFFGbVZ1VnZzMXRzeTVKeEoxbXFqRWQ1b2R1WFNYQlpy?=
 =?utf-8?B?M3BXOFdVajdMaFNOdTJjUGVvQ1Vxd0UxVEdKTXJCUGR4TjdiR2tCWmRqL1Vp?=
 =?utf-8?B?THFWUExnMmVseEQwWW5OQ29rQWhFS2RwVzRGdzhSbzlNdzV5NzExQ0JrdldZ?=
 =?utf-8?B?SmpDOGJMVFo0RXlhTmthS084RFNWR1l4MGxad3pQY0pkclBhOUdXMjZPQUlo?=
 =?utf-8?B?VFh4MEwxekhPNHlNVkhscUFuTjNJd0ZsRHhxRHJIQUZ2eTB3RjlkcElUNlhL?=
 =?utf-8?B?emdNYU9PT3l6U1I4NXdBYzFLbndiczZHVG0yUEhXSmM0K2NLZnFTbTQra2RI?=
 =?utf-8?B?bDdvOGpOL3VBOEFqZXh0TFJLMllmM0xmUTQrcHJNTjV0R1d6MmhsMU1yRmh6?=
 =?utf-8?B?cEJuNUJiQ1FMTThjVEZqZCtKNUNnZ051ZkUyOWEySDRnMGtWWS8zOUpYUXM3?=
 =?utf-8?B?WC94V2pGZUJJR1BVS1hxakVHUGJRS0c1RHhhZGxFSG5yeTRYTWVURXg4Rndi?=
 =?utf-8?B?bXV4bnJXeHY3dHRZQzRkS2ZKZmw0RXkrejdUQ2ZtdnlTajJuSU15dm0rMzNO?=
 =?utf-8?B?QnR5SmxuTnlERjM1NUxLSzJsSlFNTXNJSW9QeW1NK1Y0QXNzMzA2SmJhdTd0?=
 =?utf-8?B?T1ZucFoyS2tUNmN4RDdFWGZMUFFVdG94M09ocEFBd05BQUg2NXlrOHd1M0g3?=
 =?utf-8?B?OGE2cGh5Q2ZqR1F4YitmZStFVWVmVjQyRmI3bGR1TXppemNpbXE1Q0ZrVnhk?=
 =?utf-8?B?bWl4MTRTNlpxa2pPYkhwcGFrRDhaVkgxbHVrZFQ4WDRWMWVjVDc3NWZUVzd5?=
 =?utf-8?B?SmlHN1ZZdlU5TUlwME1IQ1BHSGJVNWlHdjhPcG90K3g2b0oyK2lzb3VYUW1W?=
 =?utf-8?B?TGEzMWt5N1YyMUdGYTFERHVJVHJEL2IrZ3doVHdrZldCNy92cTdNM29pWjhi?=
 =?utf-8?B?ZS94eDc3bE9sSXh5WmdzTGsrVkx1enZlcXlGWjlHYjJWT08wTENKYldqMlUw?=
 =?utf-8?B?NVJUMzdvbnNuc2phWVZ2cEVGVTBXNGdmeHNBeDFHTDZRK25veHlYcnZidnJs?=
 =?utf-8?B?T01iL2M2QUVHK1NWTWxXZDd0UzhrYm5TN2xPbHZiYUVlSWFUUGxtR1N1Mk00?=
 =?utf-8?B?VlAyd1M0TTRXNjdMRVg0cG0xZHY1M2ZwN053MzRGTEpwbG9iS0NMYnhZZXgv?=
 =?utf-8?B?VEpTa0ZmQkZrdHgyYnkxWDgyc0k5ZzlOVWRFZExvUFQ0akh2clF6L0d3Nmdy?=
 =?utf-8?B?ODRrTHhpUnFITkRjT3lPS2k5WVhtL1pYN1FtTXpTQ25qM3V4Ymd3TzFReDdp?=
 =?utf-8?B?NnZaYk1aRmVQNG9hVzEzYVpzTUozZi85UmF0OUJWaEIxWENwcmVLaGpzb3Np?=
 =?utf-8?B?Y3hHY3RhWnFLR0Q0a29PdEZvRDNGTnlTNmtLVlR4MW1kUHZFU25JL2JVaVJn?=
 =?utf-8?B?eVFIc2paQk9iRDZ0SDZnWEFUbjVNS2JBYkFDMFk5ZXJpekN5amluT2ZvcTRZ?=
 =?utf-8?B?VzJnb2hzN1hpRSttNnlJSWZFOVFRMEYyKzNlYlhLOWNnUzgvbHhVNWRRam9r?=
 =?utf-8?B?dDQ0NHdPS3N1ZmdIVGFRbEYzc3hFYXkzQ0ZuOHEydm9BejZTb05aSWVSTUFT?=
 =?utf-8?B?MkVRQ2l1NWxNbnltY0FVc3lOT2ZBU3g1em1yTWFxY2M5U2dKc3hueVN3ZnNS?=
 =?utf-8?B?VWZ2TlBGNHZvdS93UXc4Yys2V1R1dVNEQzNxMzlmVUM1dWJlczk4Y1k0U0l4?=
 =?utf-8?B?MklPbXpGUEtxWHpyUmRzNWFVcHdPYTNKeW1xZis1U3NnNld6KzdaTk1qV25L?=
 =?utf-8?B?MCtBZG5KdUdINEpCRVM4NkYwNXJEaWNsK0pDM1dtaG5TNldGRExqQVEwZ3RE?=
 =?utf-8?B?dkI3SDd3QjljN1VRWlRKUFlEVTNaQXZtcUZoeTA1a0lWQ0pGOGhOaitoOFNO?=
 =?utf-8?B?MW9iZDNDVGdVbjM3SWU4WjRkMGJXQzFrZG5iejJhcGJKMmVuSlFFZEZmbC9C?=
 =?utf-8?B?em9MTG9TNkRtYlJwRnYxUDc4M2hlbHd5aEZ2c1gzSFNLMHZ1Yi9VellicHNE?=
 =?utf-8?B?a1R6VUZPUTRtL09lY25hS014WXU0WUdZWTRUYjZxbUNMS2RJOFBQaVEyWDNo?=
 =?utf-8?Q?nGDWpKHLcExznHiFelh+a1o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <200A7DC6C30DFB4CBC2D1A7ACB295E26@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 803f1af2-d758-4f6b-5c63-08dd104994e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2024 07:43:57.2456 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fK+jsmiZDyMhqO3x0Ouy1LU1Xq7nw82hw3jUhAAf2BNLg1D6lmwSfU27MdEkXUn6eVN1YEU+84waTrjjDX+9mxTb0o6YU/o8pTfNxQQJ8VmmNhhNYZrnIGoltm+WnNM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR07MB7847
Received-SPF: pass client-ip=80.78.11.83;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost2.eviden.com
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
bi5jb20+DQoNClRoaXMgd2lsbCBoZWxwIGRldmVsb3BlcnMgb2Ygc3ZtIGRldmljZXMgdG8gdHJh
Y2sgYSBzdGF0ZQ0KDQpTaWduZWQtb2ZmLWJ5OiBDbMOpbWVudCBNYXRoaWV1LS1EcmlmIDxjbGVt
ZW50Lm1hdGhpZXUtLWRyaWZAZXZpZGVuLmNvbT4NCi0tLQ0KIGluY2x1ZGUvZXhlYy9tZW1vcnku
aCB8IDEgKw0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KDQpkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9leGVjL21lbW9yeS5oIGIvaW5jbHVkZS9leGVjL21lbW9yeS5oDQppbmRleCA3NTZk
ZDJlYTdmLi5jMGQwNjRkYmQ4IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9leGVjL21lbW9yeS5oDQor
KysgYi9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCkBAIC0yMDQsNiArMjA0LDcgQEAgc3RydWN0IElP
TU1VTm90aWZpZXIgew0KICAgICBod2FkZHIgc3RhcnQ7DQogICAgIGh3YWRkciBlbmQ7DQogICAg
IGludCBpb21tdV9pZHg7DQorICAgIHZvaWQgKm9wYXF1ZTsNCiAgICAgUUxJU1RfRU5UUlkoSU9N
TVVOb3RpZmllcikgbm9kZTsNCiB9Ow0KIHR5cGVkZWYgc3RydWN0IElPTU1VTm90aWZpZXIgSU9N
TVVOb3RpZmllcjsNCi0tIA0KMi40Ny4wDQo=

