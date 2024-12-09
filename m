Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14775E7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 06:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKX30-0003uI-3B; Mon, 09 Dec 2024 01:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tKX2y-0003tr-B6
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:15:08 -0500
Received: from smarthost4.eviden.com ([80.78.11.85])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1tKX2v-0001QB-Jd
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 01:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1733724905; x=1765260905;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=1jjuTm80TMv19PWEg9cdAUhepsZfM/ce2pw4S7XRctg=;
 b=JESvXJXcKGzqULSosoJyvO6Ey/ZYB5+8proicxComi13WKRGB1Xqa4fG
 XReGxQuHiZk0ca+HdUtU2bbQgDgQ5PIXdGR1QimBeM1Sxqdi6X26bEjjp
 4yD73vEgf01K9S7W9sSNFgImgQLMcVIHFHYTn6hjSLbMQaYmRh5PHGryX
 4XFs9/bpiMicrL7/32UfOauInnxOjEXYKfUHBE/SY1dWtPjRHVkU6SDcH
 gUCGRly7kDLFx8FsQHi9NNEGo2MWIt6I1TKOcLLBoh+0xhrC5pp7Hve2N
 rxmWXmu5xfpn8/cUoIiKvemZvIbR2oNEgWrsNF0Gu5KcVrLnCYL5JKIf1 Q==;
X-IronPort-AV: E=Sophos;i="6.12,218,1728943200"; d="scan'208";a="27086200"
X-MGA-submission: =?us-ascii?q?MDFnVZ/7KGMxSnrPtnp68fRToO73Q49lNhfosC?=
 =?us-ascii?q?7NzoF8jqyVl4vrP6F5BIG7i5Ry7I4aTiR7XaqH8s1Yv3JKr5VPu4jhoC?=
 =?us-ascii?q?TJ5Kv06S0kCws+O7P31Qm3xpqMoJwLGSVXBVCPJSUoE3W3YxEDr/EvMd?=
 =?us-ascii?q?vCC0xpg6zZT72rC4suU+z7eQ=3D=3D?=
Received: from mail-westeuropeazlp17011030.outbound.protection.outlook.com
 (HELO AS8PR04CU009.outbound.protection.outlook.com) ([40.93.65.30])
 by smarthost4.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2024 07:14:59 +0100
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5gVtWgnN1xEI80Hohj2JmvO4QnkrXzOaOmppCZ+nxF7cR+igyBA8M2w/xZva3asVZEFBt3Cv8Y2WnZLfyD8SvWHHYnD3qPY/NHU66OSK+qJDliq+FSzZ0C9nWYos72tvCx2/VM47lWvJdGohITm9qURnzog1UZGvpTwRj1G+Ie5UDh4E2jNofT0x6oJNVKZaCHJDL06hmLzLWUohBaj89KSeyg+mASutk+C7XAbjVqPoYnFVi+gSJqwidIlHcKB8qNNr8SXyvuPB3G5WH7tw0AzCa6JO5ckFM3k+rhVoAMTkYdxfJz/e8jLBmnWhp8apXF0AJqsb96BXkPyENZQTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jjuTm80TMv19PWEg9cdAUhepsZfM/ce2pw4S7XRctg=;
 b=KbTqb6qORelOmF8pvU4sLu9W5CuT32jgVCI+fDQJ0/6l9aIR75Orbx/70hbqHr67KJVoCPljMrCywFiNA4VGaGgoxE2/wmWbcRuZKIncLIiqLI6tRvy93c8U4UnEV/QOWt0GoaIbqfhAm6B7Y1nte+Ec87VwtRqGYfIgPeWyzfV80a48m+kWA9mpwJRqFsNeQEDtQkkpjLm3TuZqedyBR3moAp9wSXaMDY9FHmvSMiqR8x8RYaRNPxv6nK07fQhXnJ3IEcmnM1cfQv+UqO2lQxR6oHny6vUedjQoum1AldxI9E6NVeZalal1oqLRzR1EbTJWHYSHwn9dXD5pGRsdUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jjuTm80TMv19PWEg9cdAUhepsZfM/ce2pw4S7XRctg=;
 b=R8OweGSoyHuxO38m2wdm5CHSGxeZlRBaIVq5vqqA2dZpCPLdO7aKbt5+f2yzPc2qd7ieWN3+EYPr4C/22QmHFYHb11Tl83fL4sGzWAV5bP5+x8xDbijtb3o/qcm3qdzndZoHHWXZzL8INjHlLY4UIN5wKMJDruIA77DJm+lo/wSHHR4slye8p9qkDKItwE9q1pvSqtOrJopy6tjYI5PoNgygX1jbSatPdVQAJq7rtCcTmlLF8ohFsdj0CbSxiLTpymCTMaudvsdX3+x/U4oUjoG6ANyGeA+QtwRNJ0bwk//8r9qZyuyDDettJYmeTbX+j0/z27pGJCYYiwz1oBI1RQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7155.eurprd07.prod.outlook.com (2603:10a6:20b:2d1::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 06:14:58 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 06:14:58 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Jason Wang <jasowang@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, "yi.l.liu@intel.com"
 <yi.l.liu@intel.com>, "chao.p.peng@intel.com" <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Topic: [PATCH v5 18/20] intel_iommu: Introduce a property x-flts for
 scalable modern mode
Thread-Index: AQHbNBU5r5oNBkqzVUqCcHjZN6/EL7LVkrqAgAAsh4CAB6k4gIAAMqgA
Date: Mon, 9 Dec 2024 06:14:58 +0000
Message-ID: <68d3a523-19c4-4296-9df8-b98b498d4c0e@eviden.com>
References: <20241111083457.2090664-1-zhenzhong.duan@intel.com>
 <20241111083457.2090664-19-zhenzhong.duan@intel.com>
 <CACGkMEtwV51X9ovWB3JHtyW4gpLT8zD8bieKFA2X=BVNZF8ymA@mail.gmail.com>
 <7126398e-fc27-4d4f-894b-f71b012f98e1@eviden.com>
 <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
In-Reply-To: <CACGkMEvuX4CtADqq0O3TnD1=Jh2aBnXFdTzLS9junGyxkKq+Xw@mail.gmail.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7155:EE_
x-ms-office365-filtering-correlation-id: 0d380cd8-ff20-4fdb-20f0-08dd1818cebc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?SGthTUlUVk9MNVBheTZPNVFzZWRhUTh6ekhYR0M4UFBKZ2FDa2FKdEs5RzZa?=
 =?utf-8?B?cGRrNmNFdStHN0dBd2JZR1FLSzZWTFc0ZStaUEVaVkt0dkx3MTdTRlNqR0Za?=
 =?utf-8?B?RWRaQ0VZeEpuZVVtcFFoNGVKOHhYckFYR2VKaEtvOThVYUFTQUZxd0phYjU5?=
 =?utf-8?B?WjJTeVNhK3EwSlJIUkFja0xJeUowTnB1NXhoL1huTk82RVdFSWozNHhnVDN2?=
 =?utf-8?B?d1Q4cTdQamVGNHlsRWtBUzM4WkxlYmsrSEFkejhEbVA5VXVlaWZvOWpjWGFj?=
 =?utf-8?B?ZWFGMjkzRW1tMnFMV3BCeVFqUXBFNGhON01mVmZFT2lNeXdieDJwYmNvZitG?=
 =?utf-8?B?cW0ySjR1STRMV3V4UGQxMlYyL1NjTWJwSWdYcEMyTlpJc25XU3A3ZjVWRjln?=
 =?utf-8?B?THAyZno4SXVlTVBmVzZPZGRiZmRNMjZmZ0U2QlBhL1JlQXcycUsrQmFCRHFV?=
 =?utf-8?B?OFU0eWl4L2Nid3NpNGRzcWVZMjZMVWE2eTJQczZ2eEdXaElVYWNOVkJwSU1V?=
 =?utf-8?B?VFcxU29vOS9DSXJFSmRMSWhvcUFSTG13UDJjdlR2V3lROHFYTXFBeEhlUVhu?=
 =?utf-8?B?ekNUYW5vUk5YMTQ1d0dFSTBDMmZjTCtwTU1GRkpTQlliTm04eTFyYVpjM3NB?=
 =?utf-8?B?UThqa01HekxYS2JyQlNFOC9tdlpzTS85Zm1FVVFmb25SMVF5MG4veTVnVkd5?=
 =?utf-8?B?TGdWRDlXWGM3OGp4RE1NOVYxMHdTN3NrZ3g5SGRRbjRGejY3emFCUTV6NDVm?=
 =?utf-8?B?dVlvY0NJSDB2TkNUbzI4emZ0aUs3Wm15eUlJbDNjdDdwazdFVFlKZjkvaW5N?=
 =?utf-8?B?eHJWOUswQkdwMEZzL0REUGNNMGVjQ2x5M0hWMGRTMFlVNzk1MlVBcnU1VkU5?=
 =?utf-8?B?VlV6ZTFCNnRvUHFOYXdiTDBuR1pOYmFhRWxXOWNVbHVaWXRNdXc1MUgzeFZX?=
 =?utf-8?B?dWFoQWRTMElYVVFaWGJONnVwQytqL21CMk1CdDRMdE1Vd1VoSk94SFRreW1E?=
 =?utf-8?B?bWdETlRJdE4xOThJSDhBOEcyVHJHcjRyRmlmc0dmcGRkOGJFODVhYk0vOG9L?=
 =?utf-8?B?RWZMQVppN3ZQV204RHl4Q0o1aVZoMXc3VW9lTnhXOG83Zlp1R2tPY0dvTjhS?=
 =?utf-8?B?cklZZ2hJakIzZzdSM1VPZzlIL2lyL1g2YisyengzQ2RpVXhnYkF3QjBqN29O?=
 =?utf-8?B?WTlFcTgvNTdVeUhxMHRMdjBkU0RSMEFTbjZ3S2FMNDFUeHNldDd2RG5HMC95?=
 =?utf-8?B?QmgxUXFscGppVEFxYnV2a2c0S1JRUHRBTEwxVHJZVzlVNExBUzJSSXg1aUNk?=
 =?utf-8?B?SnhyT0ZmOHpQOEFhVHlEVGhnTTZkUG4zTHljOG8zNGU3SGlQR3NiZ2xmSWRU?=
 =?utf-8?B?eUh1NUdha3NaYnNITGZMRG9ZSkVaMllpWFNPak9paXFULzlaOU9BekxrVWpB?=
 =?utf-8?B?dVlINDk2Z3o2SmZISkpqV0trZ2RaNXFkQlkwaHZ0TW1OMDBDaGRGVkROdEZx?=
 =?utf-8?B?Q0JuMTd6V1NwK3ZTR1pxZUxSRWlRaFRtc0ZNWEhoNmNob1N0azMzQnFReWlw?=
 =?utf-8?B?c3NKYUdwd2liSlVtc3ZvcS9RWkdxcHROSTE2eWxiZHl3Z1lHQTVJY2dBV0VI?=
 =?utf-8?B?WDN2bWJ0OEJ4dVpuZ3I5dm9ZWFp3UlFiTk45eWpEWURFeFFLK2pZVmpIMTZY?=
 =?utf-8?B?NlJWTmZXVzRvVWZ2eG1WSDB4K1BVWnFJNXJGU081OU5JR2tZaCszYTF5Rk5Q?=
 =?utf-8?B?NnFOWXpybE5SOHllSklnZHF1OGNzNmpxR2hJa3JGUVhIWDlTK0lRL3JQdTgv?=
 =?utf-8?B?WWxEdFJPaSsvQ21zWUNiZjNUbG5qbGlmWjVxSHNFKzJmeUNCTG5vUUcvcDgz?=
 =?utf-8?B?Zk9iUndRWm5xZWwxQUFTbHAxSndxcWJKdlE3cTN2eE1GbWc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkZCTXdKM0ZRR2xISzNTYkRLMldIb1VPaXRHUGkxOGhpN2JwMG1adTZVU1RJ?=
 =?utf-8?B?aWhnNlQ4TFR0U1g5bzVTc2lwK2FnWHRhSWY0UjkrYm5FMFZxZ2dTNmt6eGYy?=
 =?utf-8?B?MlErYUhKaFlOSVEzNFdNcUNhczlJbkR6R0UxMHZjQUFaYnVwWEVtS04wRytK?=
 =?utf-8?B?MmQyU2V5S25mcXlsUEtMUjBaMGJ1TVU3OUQvZ0dmbGdlU2cwdWdvWS95eU94?=
 =?utf-8?B?Y2JBdllOeVJKM2RLeXd1RzBrTVp6Nk5qdnp0L1JsRndiODFzRVNYT3NxZG5E?=
 =?utf-8?B?eHgxeWtReUFYUUpIN1Z2UTh3V1JqYlJlck9uYTcwU0RTaHFmMmRSdXBRSmNk?=
 =?utf-8?B?UVY5YWI3QUw1TTNjOUhOV29KaHNvd1ljb3F5RExQMjViejRKeVYvOW0xU1cr?=
 =?utf-8?B?TUxQdjBma3RYVHpYK1N1Q0k3YlFDUXNuWnpZVGxnME9rRlVPMjVJeUdUVHZo?=
 =?utf-8?B?WVFHRnhWSEtzRC9XbVAwTUJjRUpSbzdUa1VwYktJMndyQ05xSlpVNm5KNFRQ?=
 =?utf-8?B?RWFFR1J3NHh4MG5QK3MwR2gxRlUvZ00za1RweHRWbVJkMGpRNmd3cmRYZmc0?=
 =?utf-8?B?Qm9ncExHckpYRjlFK3Bxc3ZzNEhoVFFMODVmMTE4eldvbXhJeS9iMEVsa3Fx?=
 =?utf-8?B?bU9PR0lMdHN1VVdaZUdqZGQrL2VSOU41WGlReC82VTBOaS9URHgxOHA0dFZS?=
 =?utf-8?B?SlBpczVnaDdDRXRIa2J2T2FsSVBwWEE4aFFaNFZKV1Jnc3NZb2srQkR1TzNV?=
 =?utf-8?B?ZjJ1emdTbzRPdUlUVTlOS0R1MUdCd0Zvcyt2OFdTYWJGZWxrZzJRR3hVOXJa?=
 =?utf-8?B?ODRGK3B0a0lRUmJwWkcxSGQybGNXNjRlNWNkR09oTFE2UVcwWFVtWnRQUkhk?=
 =?utf-8?B?dC9UZm9WUXhuY1hEYk9udlJNNHl4c0hsaHpiTVVIS0NGYXNQWUxCdFdpRllY?=
 =?utf-8?B?RjBqNi85M0JQdkIyaER1TXJOelBvK3VXK1IzYzZUbW12YVhBeE03Zy8zdExn?=
 =?utf-8?B?M0pVeThKbGRKV2dqYTBkTFdkNkFFbXBjU2ZkNmovLzZ3b1NVNjQ0bGs5Z3lZ?=
 =?utf-8?B?Nm9RbGFFeVJEYUYrU0o3cDRBVUxaeUFid0kyQnBqSDdVQXRwMG00Z1ZzQTVR?=
 =?utf-8?B?Nk13VE1VK1RFbjRzc01pUTZYbmlTUW1XaU0yS1VuTkZsUHlTMXppVmRsU2tB?=
 =?utf-8?B?d1o5ZDQzTDRMLzhqbnpFM3Jpd2tQSUFpZjhVemVOTlhhcXQyTzVQV2tWYXRo?=
 =?utf-8?B?WFN0U1lBdW9qVGI1cW4ycDRXTDd0RmxjOHZ5akMrYkFsL0M1SzVMVDE0SkJs?=
 =?utf-8?B?eXF6QUlJdmZzd1B3Vnlzb3ArZGR1THJGUmRtMGh5VjdMMDNDV2h1MmhYcytP?=
 =?utf-8?B?NWRPeGlzVndWbTVuRUlXY1lQeW10Q3lBWDlHZnBMekxVVTJqS3g3dUowU2JQ?=
 =?utf-8?B?OUY0N3poVWo5NkdhR0FsblQzc28vdjF0NlhoU2c5Y0pFWVhHZWpPZVR6S0xZ?=
 =?utf-8?B?KytvYUR1LzR6V2lNZnBJVnM2OFZ4VnJyem8yQnhxTUJObWZCR09UUGdocXhK?=
 =?utf-8?B?cHRSVk9MT2MzTzhXQ2k4T0tBMGhaSkRORFBOU0pWQTVNTGk5RVlGenZSbmNB?=
 =?utf-8?B?S3FHL09LUWhNVzZHWG42NjJ5V0xQOHVLejZPSDhvRFpzTUhLMlhiSlFNeitz?=
 =?utf-8?B?VU0rN2lyN1NERTZ0WFk5WkhOR2FKUHh6SDlwWkkvRS90ajNnQW9VVTkvaVoz?=
 =?utf-8?B?VHp1RWY0VzFiY0NIUWdRcENlM2xuR2dKaDU4Zy9pK3VaVGxwY2pqdm9tTDdX?=
 =?utf-8?B?V25xcmE2dVNicDVWWU1EYTRuVzlKYVFmQ2Uwamo1Z1VwM0x4MWhDeFFra0hY?=
 =?utf-8?B?a1p5bG1UZjk0bnZjdmk3bE03OEtvTWpQT29CcEc0Tlo5TnNsZUVzUXFiV1BN?=
 =?utf-8?B?NDRDMU1nMkh2cW1EMDkzRG1mQWZ2Y0RIQnovYllUT2xzd1A2VGdNWC9ZaFVM?=
 =?utf-8?B?cU1VbzZhWVZmUG95anRQYzh1WWplTE5NbzNEQTlQNGZ4VTBHUVE2N09TRTI3?=
 =?utf-8?B?R1Z1eFQ0Z3JmN2o0NTd5U1NlenhmNlcrem0xc0h3V09xbkdFVmRxUW5wMG1Y?=
 =?utf-8?B?RmV3Ky8rY3ROdUJHQlRZV2FhbkRnMjg4aXNGcmlma1dLbGEyY3plK2JiT01n?=
 =?utf-8?Q?25Q3Gof2tuvsWv1S/SAR0zo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9833542A9D45474AA432725AB71CEF02@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d380cd8-ff20-4fdb-20f0-08dd1818cebc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:14:58.2832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 135hn5Gl7TtijlEASVypTAhiCfSMo3eYWhkXkPYZLWoqdvu3Id8KtaLaYaJgK7li4j7pdnhiq2/6Rdvt1H8EfAKt2yWxBg2itTQDtK+ob6Ua9c+xPc/K18gPk7AmHTeC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7155
Received-SPF: pass client-ip=80.78.11.85;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost4.eviden.com
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

DQoNCk9uIDA5LzEyLzIwMjQgMDQ6MTMsIEphc29uIFdhbmcgd3JvdGU6DQo+IENhdXRpb246IEV4
dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBvciBjbGljayBsaW5rcywgdW5s
ZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiBPbiBXZWQsIERlYyA0LCAyMDI0IGF0IDI6MTTi
gK9QTSBDTEVNRU5UIE1BVEhJRVUtLURSSUYNCj4gPGNsZW1lbnQubWF0aGlldS0tZHJpZkBldmlk
ZW4uY29tPiB3cm90ZToNCj4+DQo+Pg0KPj4NCj4+IE9uIDA0LzEyLzIwMjQgMDQ6MzQsIEphc29u
IFdhbmcgd3JvdGU6DQo+Pj4gQ2F1dGlvbjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0
dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtzLCB1bmxlc3MgdGhpcyBlbWFpbCBjb21lcyBmcm9tIGEg
a25vd24gc2VuZGVyIGFuZCB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlLg0KPj4+DQo+Pj4N
Cj4+PiBPbiBNb24sIE5vdiAxMSwgMjAyNCBhdCA0OjM54oCvUE0gWmhlbnpob25nIER1YW4gPHpo
ZW56aG9uZy5kdWFuQGludGVsLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+IEludGVsIFZULWQgMy4w
IGludHJvZHVjZXMgc2NhbGFibGUgbW9kZSwgYW5kIGl0IGhhcyBhIGJ1bmNoIG9mIGNhcGFiaWxp
dGllcw0KPj4+PiByZWxhdGVkIHRvIHNjYWxhYmxlIG1vZGUgdHJhbnNsYXRpb24sIHRodXMgdGhl
cmUgYXJlIG11bHRpcGxlIGNvbWJpbmF0aW9ucy4NCj4+Pj4NCj4+Pj4gVGhpcyB2SU9NTVUgaW1w
bGVtZW50YXRpb24gd2FudHMgdG8gc2ltcGxpZnkgaXQgd2l0aCBhIG5ldyBwcm9wZXJ0eSAieC1m
bHRzIi4NCj4+Pj4gV2hlbiBlbmFibGVkIGluIHNjYWxhYmxlIG1vZGUsIGZpcnN0IHN0YWdlIHRy
YW5zbGF0aW9uIGFsc28ga25vd24gYXMgc2NhbGFibGUNCj4+Pj4gbW9kZXJuIG1vZGUgaXMgc3Vw
cG9ydGVkLiBXaGVuIGVuYWJsZWQgaW4gbGVnYWN5IG1vZGUsIHRocm93IG91dCBlcnJvci4NCj4+
Pj4NCj4+Pj4gV2l0aCBzY2FsYWJsZSBtb2Rlcm4gbW9kZSBleHBvc2VkIHRvIHVzZXIsIGFsc28g
YWNjdXJhdGUgdGhlIHBhc2lkIGVudHJ5DQo+Pj4+IGNoZWNrIGluIHZ0ZF9wZV90eXBlX2NoZWNr
KCkuDQo+Pj4+DQo+Pj4+IFN1Z2dlc3RlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IFlpIFN1biA8eWkueS5zdW5AbGludXguaW50ZWwuY29tPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29t
Pg0KPj4+PiAtLS0NCj4+Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oIHwgIDIg
KysNCj4+Pj4gICAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jICAgICAgICAgIHwgMjggKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLQ0KPj4+PiAgICAyIGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlv
bnMoKyksIDkgZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9ody9pMzg2L2lu
dGVsX2lvbW11X2ludGVybmFsLmggYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4+
Pj4gaW5kZXggMmM5NzdhYTdkYS4uZThiMjExZThiMCAxMDA2NDQNCj4+Pj4gLS0tIGEvaHcvaTM4
Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXVf
aW50ZXJuYWwuaA0KPj4+PiBAQCAtMTk1LDYgKzE5NSw3IEBADQo+Pj4+ICAgICNkZWZpbmUgVlRE
X0VDQVBfUEFTSUQgICAgICAgICAgICAgICgxVUxMIDw8IDQwKQ0KPj4+PiAgICAjZGVmaW5lIFZU
RF9FQ0FQX1NNVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0MykNCj4+Pj4gICAgI2RlZmluZSBW
VERfRUNBUF9TTFRTICAgICAgICAgICAgICAgKDFVTEwgPDwgNDYpDQo+Pj4+ICsjZGVmaW5lIFZU
RF9FQ0FQX0ZMVFMgICAgICAgICAgICAgICAoMVVMTCA8PCA0NykNCj4+Pj4NCj4+Pj4gICAgLyog
Q0FQX1JFRyAqLw0KPj4+PiAgICAvKiAob2Zmc2V0ID4+IDQpIDw8IDI0ICovDQo+Pj4+IEBAIC0y
MTEsNiArMjEyLDcgQEANCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQX1NMTFBTICAgICAgICAgICAg
ICAgKCgxVUxMIDw8IDM0KSB8ICgxVUxMIDw8IDM1KSkNCj4+Pj4gICAgI2RlZmluZSBWVERfQ0FQ
X0RSQUlOX1dSSVRFICAgICAgICAgKDFVTEwgPDwgNTQpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0NB
UF9EUkFJTl9SRUFEICAgICAgICAgICgxVUxMIDw8IDU1KQ0KPj4+PiArI2RlZmluZSBWVERfQ0FQ
X0ZTMUdQICAgICAgICAgICAgICAgKDFVTEwgPDwgNTYpDQo+Pj4+ICAgICNkZWZpbmUgVlREX0NB
UF9EUkFJTiAgICAgICAgICAgICAgIChWVERfQ0FQX0RSQUlOX1JFQUQgfCBWVERfQ0FQX0RSQUlO
X1dSSVRFKQ0KPj4+PiAgICAjZGVmaW5lIFZURF9DQVBfQ00gICAgICAgICAgICAgICAgICAoMVVM
TCA8PCA3KQ0KPj4+PiAgICAjZGVmaW5lIFZURF9QQVNJRF9JRF9TSElGVCAgICAgICAgICAyMA0K
Pj4+PiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jIGIvaHcvaTM4Ni9pbnRlbF9p
b21tdS5jDQo+Pj4+IGluZGV4IGI5MjE3OTNjM2EuLmE3YTgxYWViZWUgMTAwNjQ0DQo+Pj4+IC0t
LSBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4+PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11
LmMNCj4+Pj4gQEAgLTgwMywxNiArODAzLDE4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfaXNf
ZmxfbGV2ZWxfc3VwcG9ydGVkKEludGVsSU9NTVVTdGF0ZSAqcywgdWludDMyX3QgbGV2ZWwpDQo+
Pj4+ICAgIH0NCj4+Pj4NCj4+Pj4gICAgLyogUmV0dXJuIHRydWUgaWYgY2hlY2sgcGFzc2VkLCBv
dGhlcndpc2UgZmFsc2UgKi8NCj4+Pj4gLXN0YXRpYyBpbmxpbmUgYm9vbCB2dGRfcGVfdHlwZV9j
aGVjayhYODZJT01NVVN0YXRlICp4ODZfaW9tbXUsDQo+Pj4+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgVlREUEFTSURFbnRyeSAqcGUpDQo+Pj4+ICtzdGF0aWMgaW5saW5l
IGJvb2wgdnRkX3BlX3R5cGVfY2hlY2soSW50ZWxJT01NVVN0YXRlICpzLCBWVERQQVNJREVudHJ5
ICpwZSkNCj4+Pj4gICAgew0KPj4+PiAgICAgICAgc3dpdGNoIChWVERfUEVfR0VUX1RZUEUocGUp
KSB7DQo+Pj4+IC0gICAgY2FzZSBWVERfU01fUEFTSURfRU5UUllfU0xUOg0KPj4+PiAtICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4+Pj4gLSAgICBjYXNlIFZURF9TTV9QQVNJRF9FTlRSWV9QVDoNCj4+
Pj4gLSAgICAgICAgcmV0dXJuIHg4Nl9pb21tdS0+cHRfc3VwcG9ydGVkOw0KPj4+PiAgICAgICAg
Y2FzZSBWVERfU01fUEFTSURfRU5UUllfRkxUOg0KPj4+PiArICAgICAgICByZXR1cm4gISEocy0+
ZWNhcCAmIFZURF9FQ0FQX0ZMVFMpOw0KPj4+PiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZ
X1NMVDoNCj4+Pj4gKyAgICAgICAgcmV0dXJuICEhKHMtPmVjYXAgJiBWVERfRUNBUF9TTFRTKTsN
Cj4+Pj4gICAgICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX05FU1RFRDoNCj4+Pj4gKyAgICAg
ICAgLyogTm90IHN1cHBvcnQgTkVTVEVEIHBhZ2UgdGFibGUgdHlwZSB5ZXQgKi8NCj4+Pj4gKyAg
ICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiArICAgIGNhc2UgVlREX1NNX1BBU0lEX0VOVFJZX1BU
Og0KPj4+PiArICAgICAgICByZXR1cm4gISEocy0+ZWNhcCAmIFZURF9FQ0FQX1BUKTsNCj4+Pj4g
ICAgICAgIGRlZmF1bHQ6DQo+Pj4+ICAgICAgICAgICAgLyogVW5rbm93biB0eXBlICovDQo+Pj4+
ICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPj4+PiBAQCAtODYxLDcgKzg2Myw2IEBAIHN0YXRp
YyBpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywN
Cj4+Pj4gICAgICAgIHVpbnQ4X3QgcGd0dDsNCj4+Pj4gICAgICAgIHVpbnQzMl90IGluZGV4Ow0K
Pj4+PiAgICAgICAgZG1hX2FkZHJfdCBlbnRyeV9zaXplOw0KPj4+PiAtICAgIFg4NklPTU1VU3Rh
dGUgKng4Nl9pb21tdSA9IFg4Nl9JT01NVV9ERVZJQ0Uocyk7DQo+Pj4+DQo+Pj4+ICAgICAgICBp
bmRleCA9IFZURF9QQVNJRF9UQUJMRV9JTkRFWChwYXNpZCk7DQo+Pj4+ICAgICAgICBlbnRyeV9z
aXplID0gVlREX1BBU0lEX0VOVFJZX1NJWkU7DQo+Pj4+IEBAIC04NzUsNyArODc2LDcgQEAgc3Rh
dGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUoSW50ZWxJT01NVVN0YXRlICpz
LA0KPj4+PiAgICAgICAgfQ0KPj4+Pg0KPj4+PiAgICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlw
ZSBjaGVjayAqLw0KPj4+PiAtICAgIGlmICghdnRkX3BlX3R5cGVfY2hlY2soeDg2X2lvbW11LCBw
ZSkpIHsNCj4+Pj4gKyAgICBpZiAoIXZ0ZF9wZV90eXBlX2NoZWNrKHMsIHBlKSkgew0KPj4+PiAg
ICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVjsNCj4+Pj4gICAg
ICAgIH0NCj4+Pj4NCj4+Pj4gQEAgLTM4MjcsNiArMzgyOCw3IEBAIHN0YXRpYyBQcm9wZXJ0eSB2
dGRfcHJvcGVydGllc1tdID0gew0KPj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgVlREX0hP
U1RfQUREUkVTU19XSURUSCksDQo+Pj4+ICAgICAgICBERUZJTkVfUFJPUF9CT09MKCJjYWNoaW5n
LW1vZGUiLCBJbnRlbElPTU1VU3RhdGUsIGNhY2hpbmdfbW9kZSwgRkFMU0UpLA0KPj4+PiAgICAg
ICAgREVGSU5FX1BST1BfQk9PTCgieC1zY2FsYWJsZS1tb2RlIiwgSW50ZWxJT01NVVN0YXRlLCBz
Y2FsYWJsZV9tb2RlLCBGQUxTRSksDQo+Pj4+ICsgICAgREVGSU5FX1BST1BfQk9PTCgieC1mbHRz
IiwgSW50ZWxJT01NVVN0YXRlLCBzY2FsYWJsZV9tb2Rlcm4sIEZBTFNFKSwNCj4+Pj4gICAgICAg
IERFRklORV9QUk9QX0JPT0woInNub29wLWNvbnRyb2wiLCBJbnRlbElPTU1VU3RhdGUsIHNub29w
X2NvbnRyb2wsIGZhbHNlKSwNCj4+Pj4gICAgICAgIERFRklORV9QUk9QX0JPT0woIngtcGFzaWQt
bW9kZSIsIEludGVsSU9NTVVTdGF0ZSwgcGFzaWQsIGZhbHNlKSwNCj4+Pj4gICAgICAgIERFRklO
RV9QUk9QX0JPT0woImRtYS1kcmFpbiIsIEludGVsSU9NTVVTdGF0ZSwgZG1hX2RyYWluLCB0cnVl
KSwNCj4+Pj4gQEAgLTQ1NTgsNyArNDU2MCwxMCBAQCBzdGF0aWMgdm9pZCB2dGRfY2FwX2luaXQo
SW50ZWxJT01NVVN0YXRlICpzKQ0KPj4+PiAgICAgICAgfQ0KPj4+Pg0KPj4+PiAgICAgICAgLyog
VE9ETzogcmVhZCBjYXAvZWNhcCBmcm9tIGhvc3QgdG8gZGVjaWRlIHdoaWNoIGNhcCB0byBiZSBl
eHBvc2VkLiAqLw0KPj4+PiAtICAgIGlmIChzLT5zY2FsYWJsZV9tb2RlKSB7DQo+Pj4+ICsgICAg
aWYgKHMtPnNjYWxhYmxlX21vZGVybikgew0KPj4+PiArICAgICAgICBzLT5lY2FwIHw9IFZURF9F
Q0FQX1NNVFMgfCBWVERfRUNBUF9GTFRTOw0KPj4+PiArICAgICAgICBzLT5jYXAgfD0gVlREX0NB
UF9GUzFHUDsNCj4+Pj4gKyAgICB9IGVsc2UgaWYgKHMtPnNjYWxhYmxlX21vZGUpIHsNCj4+Pj4g
ICAgICAgICAgICBzLT5lY2FwIHw9IFZURF9FQ0FQX1NNVFMgfCBWVERfRUNBUF9TUlMgfCBWVERf
RUNBUF9TTFRTOw0KPj4+PiAgICAgICAgfQ0KPj4+Pg0KPj4+PiBAQCAtNDczNyw2ICs0NzQyLDEx
IEBAIHN0YXRpYyBib29sIHZ0ZF9kZWNpZGVfY29uZmlnKEludGVsSU9NTVVTdGF0ZSAqcywgRXJy
b3IgKiplcnJwKQ0KPj4+PiAgICAgICAgICAgIH0NCj4+Pj4gICAgICAgIH0NCj4+Pj4NCj4+Pj4g
KyAgICBpZiAoIXMtPnNjYWxhYmxlX21vZGUgJiYgcy0+c2NhbGFibGVfbW9kZXJuKSB7DQo+Pj4+
ICsgICAgICAgIGVycm9yX3NldGcoZXJycCwgIkxlZ2FjeSBtb2RlOiBub3Qgc3VwcG9ydCB4LWZs
dHM9b24iKTsNCj4+Pg0KPj4+IFRoaXMgc2VlbXMgdG8gYmUgd2lyZWQsIHNob3VsZCB3ZSBzYXkg
InNjYWxhYmxlIG1vZGUgaXMgbmVlZGVkIGZvcg0KPj4+IHNjYWxhYmxlIG1vZGVybiBtb2RlIj8N
Cj4+DQo+PiBIaSBKYXNvbiwNCj4+DQo+PiBXZSBhZ3JlZWQgdG8gdXNlIHRoZSBmb2xsb3dpbmcg
c2VudGVuY2U6ICJ4LWZsdHMgaXMgb25seSBhdmFpbGFibGUgaW4NCj4+IHNjYWxhYmxlIG1vZGUi
DQo+Pg0KPj4gRG9lcyBpdCBsb29rIGdvb3QgdG8geW91Pw0KPiANCj4gQmV0dGVyIGJ1dCBpZiB3
ZSBhZGQgbW9yZSBmZWF0dXJlcyB0byB0aGUgc2NhbGFibGUgbW9kZXJuLCB3ZSBuZWVkIHRvDQo+
IGNoYW5nZSB0aGUgZXJyb3IgbWVzc2FnZSBoZXJlLg0KDQpIaSBKYXNvbg0KDQpNYXliZSB0aGUg
d2VpcmRuZXNzIGNvbWVzIGZyb20gdGhlIGZhY3QgdGhhdCB4LWZsdHMgb24gdGhlIGNvbW1hbmQg
bGluZSANCmlzIG1hcHBlZCB0byBzY2FsYWJsZV9tb2Rlcm4gaW4gdGhlIGNvZGU/DQoNClRoYW5r
cw0KID5jbWQNCg0KPiANCj4gVGhhbmtzDQo+IA0KPj4NCj4+IFRoYW5rcw0KPj4gY21kDQo+Pg0K
Pj4+DQo+Pj4+ICsgICAgICAgIHJldHVybiBmYWxzZTsNCj4+Pj4gKyAgICB9DQo+Pj4+ICsNCj4+
Pj4gICAgICAgIGlmICghcy0+c2NhbGFibGVfbW9kZXJuICYmIHMtPmF3X2JpdHMgIT0gVlREX0hP
U1RfQVdfMzlCSVQgJiYNCj4+Pj4gICAgICAgICAgICBzLT5hd19iaXRzICE9IFZURF9IT1NUX0FX
XzQ4QklUKSB7DQo+Pj4+ICAgICAgICAgICAgZXJyb3Jfc2V0ZyhlcnJwLCAiJXMgbW9kZTogc3Vw
cG9ydGVkIHZhbHVlcyBmb3IgYXctYml0cyBhcmU6ICVkLCAlZCIsDQo+Pj4+IC0tDQo+Pj4+IDIu
MzQuMQ0KPj4+Pg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4NCj4gDQo=

