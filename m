Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFB00C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 05:05:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Oce-0007O2-Fa; Thu, 02 May 2024 01:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2Occ-0007N1-5u
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:04:42 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1s2OcZ-00048x-CN
 for qemu-devel@nongnu.org; Thu, 02 May 2024 01:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1714626279; x=1746162279;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=RQ3blLZ9d5O8IlULeBBm01AzPzcmkHKhAhkUebT4uN0=;
 b=lkqaDGNQAJWqGboW1IfYb+SE+VEWh+Sk7t/mgsdbSY6tNsby1VvdQd+a
 CtlAlqnmzfXfQLQ9aAePBYzAPzVLql3suqz4i+DPqGXJnyPsczZZh+sz2
 SYojogDSzLcIHbRkTNNrSWy2uP7C0m3cpVEkzcHi5FGCPhdKLailvA2RZ
 Hi0j8ILABqMLjtUfeHNXRjUXHhIPf4Xp3MYwAbjnOQiNwTfZ5tulXjVHc
 P8Q9covwcdF1p+zAR5wPEvgQpPISZsOgQrWpv4LKej0CRBudgtsOZSt5F
 PHc4FsBo/vKRlIJ8JVu3gdUAc1QXoa4nvxosf7bVUIBolmJg0khGAkjhS Q==;
X-IronPort-AV: E=Sophos;i="6.07,247,1708383600"; d="scan'208";a="11675202"
X-MGA-submission: =?us-ascii?q?MDEquiURQBquxQt/01YVy2sUuEY/AauOOlCniT?=
 =?us-ascii?q?PET0HCB3rdza8a0AK4wKXjfzpk2gI6W+PIUTQ7oVGziDRB3pyQoY24nn?=
 =?us-ascii?q?CSLD7Yk17I6hRpiY7gyj8loN7ynG6sLb5aAWjNsjdwipmfX5NfI8VUt+?=
 =?us-ascii?q?HqLTK2zKGdhlRKKE+yELy8Gg=3D=3D?=
Received: from mail-db3eur04lp2051.outbound.protection.outlook.com (HELO
 EUR04-DB3-obe.outbound.protection.outlook.com) ([104.47.12.51])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 May 2024 07:03:45 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPGCIrMZ76uUwxHEakXOLUBGZ/WJQKXC/cL8wPAIEHa+bBlgPfFlEt9ocxC6Oivx0Q62h1im7dNyxUipZo6ijKozxszzQeZOMhUSZCt36RnBGi4/OR/yrXvTOu1k7z7vhqA0ZPzArI/sQrt9AFDNmFsSH2BowAfVX41jXXsaQYQ+ADbiI/Nv6FxKjY3bodXN3NHCkRVa87Ls/ekVN0gmssJROKskg3Ratp/dy6vhYTVh1AwfCMNJ2k5F9sZdD9kUVaI5PaWJZyHHhkv/CwK8f9rHKRUIcQGYdtCh69+mAnKqZ5yVyJ0geOSyhYrIfU9iuQJk6ugP6d0NHpXI2fvghQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQ3blLZ9d5O8IlULeBBm01AzPzcmkHKhAhkUebT4uN0=;
 b=nBIhGzDiWhja6k9oWdnmQPyX/IxCtc8yjrtnOHGkct/eG8gGtNDMB8VBgLy6En8etd5AKFeQhLPY/u9GEEGwQ3gS8WUshRjY24kICEarMUKmjDfaq7QcskNnn1lkwqo+PRTjLdt1n2fvsAm8cnXK5lkeD7Omv7aWnRmecbtxqhq1mo/ombbjg/n9itqEpxH/1m0uGbBXv80aAHBUbB7K4jcSIkU7BV3MVkPTCTJW/lSm42SDn1Ns1IDtA92+LOQrGIJQl5Lz/Vi79VRWWXSOfUjnFZURPYWN2cMMmRweI1Ng7/V6fvPJ4RXDP9fwaRgkApSXTE0eAnxyvOjHyaQKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by AM9PR07MB7300.eurprd07.prod.outlook.com (2603:10a6:20b:2c3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Thu, 2 May
 2024 05:03:44 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%4]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 05:03:44 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Joao Martins
 <joao.m.martins@oracle.com>, Peter Xu <peterx@redhat.com>, Eric Auger
 <eric.auger@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: Re: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Topic: [PATCH intel_iommu 0/7] FLTS for VT-d
Thread-Index: AQHalM0ix1VtZwm0bkmmtp6S6avLxLGA52yAgAF4ZgCAARK/gA==
Date: Thu, 2 May 2024 05:03:44 +0000
Message-ID: <f00d7bfa-91d0-4c58-8b7e-bd3dad477e9f@eviden.com>
References: <20240422155236.129179-1-clement.mathieu--drif@eviden.com>
 <9e15abd9-f824-4f11-9532-b0dcb7b521dd@redhat.com>
 <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB6744D9C5BCFBA146FE09270492192@SJ0PR11MB6744.namprd11.prod.outlook.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|AM9PR07MB7300:EE_
x-ms-office365-filtering-correlation-id: 383b0309-ec2f-4fa0-c9c1-08dc6a653de9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230031|376005|7416005|366007|1800799015|38070700009; 
x-microsoft-antispam-message-info: =?utf-8?B?eGFOdDRYM0VjTXVxS0ZwdC9TTTRjbER6RXo2bWJpT3I1VUhVK0hlUjNBVysz?=
 =?utf-8?B?SUFDRnYwV0taU3RwbksxWUE5SGFubFFYcnV3dncyWS9FTVhOeldVc05GMDcx?=
 =?utf-8?B?TDZMQWRXTW9aZGlTZ3UrcVFiY0dQQTVpYUJPcDZEalV3ajhuZThVRGdXYThT?=
 =?utf-8?B?cGtwdFcvb2l0NnZjbVdZaUFTTWdyQ3BUejM1aDRvanFGUndra3ZING8rWUR5?=
 =?utf-8?B?V1MwR1U5aHpsbnUvOEJyZHdnS2s4MFNHRWJkQ2VSclk5bmszMjhiaXd3eGxo?=
 =?utf-8?B?bG81M0ZJWWllSExVNHNKYitrR0xTbERrN1NZTnZDZUZqMytBSEI4cXZpemlF?=
 =?utf-8?B?ZEFuU1Iyd1dCdStsTTlDakQySDJoUlpaaTdvQURZNlZQbXV4emxlbGV4R2dm?=
 =?utf-8?B?cXBPY0tQOG5FemF2K0FnN2ZuTUlxUS9Lc1JhaG5Ua0xBOTBsZTFteDgyRmRv?=
 =?utf-8?B?bnh6ZlBmcUhVZVpTZnNmamNEUkJXYlJHYzJ4TzRmamhSYXgxSFIrNkxZQWtF?=
 =?utf-8?B?ZUZqRXNNc3JyeCtJVGUwYXZDQVdvYWRxMmU5QUl5VTZza3UrVkZVTnA4dW5L?=
 =?utf-8?B?OCtGY2pEUXlYQ016anJPbWFBdDVqRDlMbjI0RjM4dVJub05JdUpuc1FOR2h6?=
 =?utf-8?B?YWRpeG1ZWTRnNVRUNWdnTUdRWUZvdTNYWk5QbEhvQ0prQjRXYjNiSTFPNWZh?=
 =?utf-8?B?c1Jwajl4Q05sS1pwSFJJR0ZHenVQSU5TUnFQTGljYkl4S2lDUzVxQUZ6TmZC?=
 =?utf-8?B?VkJJWmVZL2EwcGxSUDhtVnd4OXlLb1pQb2JIWHdGblRoUW5meW1oZlJWN3Rz?=
 =?utf-8?B?L0pmVFR0U05IMWljYzhDUnFyM3A4VzR6cHZidjBJTUt1VXRYbGZiZkJiWE5S?=
 =?utf-8?B?QWdZQ3dhZUpjallqRmgvV2VVUEoyZVlLYU16TmI2cThWT0czWlNsdHhXYy93?=
 =?utf-8?B?NDVyMm9rblVZMHZxZFJaeGNxc0pQT3Nwd2MvMXQyNHVEUXlkOTNHdTRSeGtL?=
 =?utf-8?B?YkxpZHZKY1MvY0t2MXRGcCtqRlE1MVNtR1Z0Tys1TmdCdHVMMFJpRURFZTBW?=
 =?utf-8?B?RWdybWIzRkZJQVlHbmdzUHRWbHFQemZhNE12SU1wOFhZZG1uZHVFQ3BrTFov?=
 =?utf-8?B?WktjMGlrU1RtRFhYQnFWeGh4ZE02VXNVU0JIekcxZFJxUWlTNE9nVllkS21J?=
 =?utf-8?B?VVhtTzdLNUJlOHIrejdDdE4wQmZsOURCUzI1Q3dxZ1hSZzBJYlhOWXNHb2pS?=
 =?utf-8?B?dkFWNCtTSG1TYUFDUFhkeXNMWFNDU3lrM2lCUitvbFJHamtaMUFIV3lLcVBl?=
 =?utf-8?B?ck1SQUtvd3VoZTBHZ2VYSmxKYUdyZTRrZFdVV1YvYWdKdG4vWEo0M1N5U3B4?=
 =?utf-8?B?aGFwRHlkb2w0L1Z6K1BDQlduOE16Y0ZQWURWWVRSa3h3YWhaUG5rbzZMQk5S?=
 =?utf-8?B?RFpuRk95b084M3FUMHlYOFJuYWFMZS9oSUpmbmNtdHpRVERsK1VyY0hEUDdM?=
 =?utf-8?B?dEFLNWtuQkJEa3hBSDdVNFpOQWl2MVR0djdLR01aY09RT2lYSGJXanIyZGlt?=
 =?utf-8?B?OXBYVklaTlFxTkczeFQ3Rkh6NDZPcjFGNGRLTy9ncUJaMC9VMGFUbzVCdGEr?=
 =?utf-8?B?dmtIZlp3ZzdyWmlXQ2pjRGUyYUNOYWlUUW9GZ1Ixb3BwYnljMUgrbFZBMWti?=
 =?utf-8?B?SmdTaWszTEJ5eHJGY1R1YmZMT3psWnQ4aU43T21JTERHOHVYRkhRZzZLdWhR?=
 =?utf-8?Q?cAX2ZO55vUQtHfg+8I=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGhMaUcwYlBmaFMvWVRTZkVxRTRBNWNSdWRQNE9GMlpxSHEwWXNxWi9FNFBG?=
 =?utf-8?B?M1B2bFAxRlgzVnNIRXpVcWhwUmFveTJZTWFsZUxoY3h3ejQvemdKT0JTQ0JT?=
 =?utf-8?B?bXV0alJ0VFE1M2VPeXlmZmI5NU5vVWRJTnUwcFdxbjJxMXcrZmFEWTNqcTV5?=
 =?utf-8?B?bG9uQ2QzY3dwb0ZObkJKTjJvNi9SZ2RacGdhcExyVzM3TE1LTTJYMUFvWG1I?=
 =?utf-8?B?K3pvVDNnVm5wRnc1ajY2RnJ5LzZqQWxpQytrSWRlVEt0dThDRUk3dm9IamJL?=
 =?utf-8?B?RVhZdmJwZnVMR3JGTWw4c2E2ajBFbWJwSFJCdGM0UEJZdmo5dWdTVVp4TUo0?=
 =?utf-8?B?RENScTViRitPT2VmNXBNaGpXWXJlNkVrNmJLWWpOcmYrU2szREk0MlQ5anNJ?=
 =?utf-8?B?Q1JXZkc3d05XQVNQVmV2YXZsMkI3YjhQRi9kc3lNYzJjbzZCQnpoN2NoN0dh?=
 =?utf-8?B?aktTNVRmN1d4WHBvWm43QlB1emUvWVhVbDNsR3RwQUc1SEc2bHNYZlg2MXZT?=
 =?utf-8?B?eXU1TG5SWTZxaDFMckdNY2N0cFlaTnZST0MyQnRsZU5UWUVrN0pXd1RsS1Jo?=
 =?utf-8?B?ZEVEcjg3MnBUMC9TUE16NFMrd3g4ajVMUllzUXNZRTFmZTFZd1cvTTQ2enBD?=
 =?utf-8?B?Rmt4YnJsa2w4U1pCNUFvTUNpTmphOGJ2dVdYeVZCOHB1YUMyQWp0ZHpEU2Jn?=
 =?utf-8?B?cE96VjNPQVNLVkZhQkk0cnRrV3dON2N6Mjc1cEpibkRhZnFveXpvS3RFb3VT?=
 =?utf-8?B?a21WSWdhMGVjNjgvK2VCSjVXem5ZbnYzeHRXeS95YkZFOU5IZkd4VlVEbWl0?=
 =?utf-8?B?UlJGTDhSMmdMSGR1cTNDaHpyUytEaGtSZEZYL2w1OWtDeitwK3lsWFZWa0NS?=
 =?utf-8?B?RDg0bXhRZzhRU201QlFheGwyc0dieDBVa1dMaEEwbHFHVjRadE5QN0JYQXpZ?=
 =?utf-8?B?eTdaUHVFMlBsbVNTVEZ6YUhnbHdscnFNaFpSYk1CTVYzUUhJT0p2UFRpU3cv?=
 =?utf-8?B?M2Izc0FINzFJOTNSYkpSMi9pSzBoYlI5MFFUTFd2VUZyR2hJeUJFR05vY1h5?=
 =?utf-8?B?anRBcXhhZWlKc3lWZHRCUll5VnI1VWhvTkpOYm1ESzFvUHZSSExIeE1adDdl?=
 =?utf-8?B?MXFLMklWTk9FUmFiaS9BNmZrZ21sVVcvNzdpTDM2ZExNNllIdkxRKzNLdTJS?=
 =?utf-8?B?aFJFZC82aC9FNTVNaTNYVTYrM2pOUEE1ZFllVnFDT2lRb1JpbnBueFJnTzd2?=
 =?utf-8?B?WVR0WTNPU2ZnUjZyRGlOK2ZqMmpPSUpGYU5OMllhazhWamlUTUl1L2NSalBE?=
 =?utf-8?B?d2owRmZlaVRVME51WDRPUmo1UnBxbW9SNXhZZjdmcTN3dWhTRUdQNzhOa0Rk?=
 =?utf-8?B?Q1dDUHFnazhFSFpvSXEycHlrSHJ3MjRIR2NOREhpUXZUbGxIOWhMVys4SUJF?=
 =?utf-8?B?elRXYTNQSWh4TkN5SURlY0RuaGFOZ25LS3BFWE9OWnNYbXdiOEsxZkhJZ2NL?=
 =?utf-8?B?M0pabi9XcERxb04zdXF5cWZGZnpLV1RoVU44blBFMThWeSsvOTNacXBaVUdv?=
 =?utf-8?B?b2p0bnlibTBvSTZzNURZK0VGVGpKWTlvTXgvYTFBZEY2MXkyWkVBd200bVVL?=
 =?utf-8?B?R1dPV0ZMMFZyRXBkbUlNTlJGOFM1VXVTWnFPVS8yZjgzaXdJV3JLNE1JNDg5?=
 =?utf-8?B?RDF6RzFvSUdWeGZWSjI0NTJrRzFhb3pTdHg4TjBvamoxd3EvREVDdks3OEtZ?=
 =?utf-8?B?OVk0OUdkNHg2NzFvOThwVzRhZ3ZmOHYxZ3Q0OC9WR2NqVWRyeFphcTUxUDFS?=
 =?utf-8?B?UWZHUzM0Q0JPWkVUclA3UDI3ZnBMUlpYcXNwaGNITkttbHRJeE80NXRERmRP?=
 =?utf-8?B?Z01QMDhBTndTL01xSVozM0UxTmhUbkI5MXh2Yy9JNHdiRFdhY29pbkUzdEND?=
 =?utf-8?B?OS94eVo2eUpnK2JwQ1hrOFVCZms4MmdLTWdHN25CeDBoZENESzRLWkhFOGFW?=
 =?utf-8?B?RS9tblIvUkU2bElLdFE2MEJxWC9yOXlmS1JralFOUjNHU0xOZjZWRXdwa0g4?=
 =?utf-8?B?Q0xPMitYd1lvT2ZmVVUwM2d4djFtc2lhQ1c0SUN1NnA2RVluUXl3cmY5RndT?=
 =?utf-8?B?Vldxa2NMLzlXS2hrdGxqVGFSRzd3d0VtU0JydjZCdzZHMFY4QVhYUVBTaG9X?=
 =?utf-8?Q?DdtltFe+cHM8cK8vMU1tvJ8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EDDC0E5F5DB1B54C8533CE57A1C89C65@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383b0309-ec2f-4fa0-c9c1-08dc6a653de9
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 05:03:44.2143 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMhr2lfLqPTKlMg1DqDusQYQ9LZdKlo+q81WabxFC4tOYoP9w4rDx+DIzpTMV1xbLUjegqelI9/hMSfBI8mnNanJA7yqt5O5LT3S3mzAdIaEhJFxAg72nbeJ3xqMsPyP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7300
Received-SPF: pass client-ip=80.78.11.82;
 envelope-from=clement.mathieu--drif@eviden.com; helo=smarthost1.eviden.com
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

SGkgWmhlbnpob25nLA0KDQpJIHdpbGwgcmViYXNlLA0KDQp0aGFua3MNCg0KT24gMDEvMDUvMjAy
NCAxNDo0MCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFp
bC4gRG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIHVubGVzcyB0aGlzIGVt
YWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+DQo+DQo+IEFoLCB0aGlzIGlzIGEgZHVwbGljYXRlIGVmZm9ydCBvbiBzdGFnZS0x
IHRyYW5zbGF0aW9uLg0KPg0KPiBIaSBDbGVtZW50LA0KPg0KPiBXZSBoYWQgZXZlciBzZW50IGEg
cmZjdjEgc2VyaWVzICJpbnRlbF9pb21tdTogRW5hYmxlIHN0YWdlLTEgdHJhbnNsYXRpb24iDQo+
IGZvciBib3RoIGVtdWxhdGVkIGFuZCBwYXNzdGhyb3VnaCBkZXZpY2UsIGxpbms6DQo+IGh0dHBz
Oi8vbGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDI0LTAxL21zZzAyNzQw
Lmh0bWwNCj4gd2hpY2ggbm93IGV2b2x2ZXMgdG8gcmZjdjIsIGxpbms6DQo+IGh0dHBzOi8vZ2l0
aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56aG9uZy9pb21tdWZkX25lc3Rpbmdf
cmZjdjIvDQo+DQo+IEl0IGhhZCBhZGRyZXNzZWQgcmVjZW50IGNvbW11bml0eSBjb21tZW50cywg
YWxzbyB0aGUgY29tbWVudHMgaW4gb2xkIGhpc3Rvcnkgc2VyaWVzOg0KPiBodHRwczovL3BhdGNo
d29yay5rZXJuZWwub3JnL3Byb2plY3Qva3ZtL2NvdmVyLzIwMjEwMzAyMjAzODI3LjQzNzY0NS0x
LXlpLmwubGl1QGludGVsLmNvbS8NCj4NCj4gV291bGQgeW91IG1pbmQgcmViYXNpbmcgeW91ciBy
ZW1haW5pbmcgcGFydCwgaS5lLiwgQVRTLCBQUkkgZW11bGF0aW9uLCBldGMgb24gdG8gb3VyIHJm
Y3YyPw0KPg0KPiBUaGFua3MNCj4gWmhlbnpob25nDQo+DQo+PiAtLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KPj4gRnJvbTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4g
U3ViamVjdDogUmU6IFtQQVRDSCBpbnRlbF9pb21tdSAwLzddIEZMVFMgZm9yIFZULWQNCj4+DQo+
PiBIZWxsbywNCj4+DQo+PiBBZGRpbmcgYSBmZXcgcGVvcGxlIGluIENjOiB3aG8gYXJlIGZhbWls
aWFyIHdpdGggdGhlIEludGVsIElPTU1VLg0KPj4NCj4+IFRoYW5rcywNCj4+DQo+PiBDLg0KPj4N
Cj4+DQo+Pg0KPj4NCj4+IE9uIDQvMjIvMjQgMTc6NTIsIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3
cm90ZToNCj4+PiBUaGlzIHNlcmllcyBpcyB0aGUgZmlyc3Qgb2YgYSBsaXN0IHRoYXQgYWRkIHN1
cHBvcnQgZm9yIFNWTSBpbiB0aGUgSW50ZWwgSU9NTVUuDQo+Pj4NCj4+PiBIZXJlLCB3ZSBpbXBs
ZW1lbnQgc3VwcG9ydCBmb3IgZmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb24gaW4gVlQtZC4NCj4+PiBU
aGUgUEFTSUQtYmFzZWQgSU9UTEIgaW52YWxpZGF0aW9uIGlzIGFsc28gYWRkZWQgaW4gdGhpcyBz
ZXJpZXMgYXMgaXQgaXMgYQ0KPj4+IHJlcXVpcmVtZW50IG9mIEZMVFMuDQo+Pj4NCj4+PiBUaGUg
bGFzdCBwYXRjaCBpbnRyb2R1Y2VzIHRoZSAnZmx0cycgb3B0aW9uIHRvIGVuYWJsZSB0aGUgZmVh
dHVyZSBmcm9tDQo+Pj4gdGhlIGNvbW1hbmQgbGluZS4NCj4+PiBPbmNlIGVuYWJsZWQsIHNldmVy
YWwgZHJpdmVycyBvZiB0aGUgTGludXgga2VybmVsIHVzZSB0aGlzIGZlYXR1cmUuDQo+Pj4NCj4+
PiBUaGlzIHdvcmsgaXMgYmFzZWQgb24gdGhlIFZULWQgc3BlY2lmaWNhdGlvbiB2ZXJzaW9uIDQu
MSAoTWFyY2ggMjAyMykNCj4+Pg0KPj4+IEhlcmUgaXMgYSBsaW5rIHRvIGEgR2l0SHViIHJlcG9z
aXRvcnkgd2hlcmUgeW91IGNhbiBmaW5kIHRoZSBmb2xsb3dpbmcNCj4+IGVsZW1lbnRzIDoNCj4+
PiAgICAgICAtIFFlbXUgd2l0aCBhbGwgdGhlIHBhdGNoZXMgZm9yIFNWTQ0KPj4+ICAgICAgICAg
ICAtIEFUUw0KPj4+ICAgICAgICAgICAtIFBSSQ0KPj4+ICAgICAgICAgICAtIFBBU0lEIGJhc2Vk
IElPVExCIGludmFsaWRhdGlvbg0KPj4+ICAgICAgICAgICAtIERldmljZSBJT1RMQiBpbnZhbGlk
YXRpb25zDQo+Pj4gICAgICAgICAgIC0gRmlyc3Qtc3RhZ2UgdHJhbnNsYXRpb25zDQo+Pj4gICAg
ICAgICAgIC0gUmVxdWVzdHMgd2l0aCBhbHJlYWR5IHRyYW5zbGF0ZWQgYWRkcmVzc2VzDQo+Pj4g
ICAgICAgLSBBIGRlbW8gZGV2aWNlDQo+Pj4gICAgICAgLSBBIHNpbXBsZSBkcml2ZXIgZm9yIHRo
ZSBkZW1vIGRldmljZQ0KPj4+ICAgICAgIC0gQSB1c2Vyc3BhY2UgcHJvZ3JhbSAoZm9yIHRlc3Rp
bmcgYW5kIGRlbW9uc3RyYXRpb24gcHVycG9zZXMpDQo+Pj4NCj4+PiBodHRwczovL2dpdGh1Yi5j
b20vQnVsbFNlcXVhbmEvUWVtdS1pbi1ndWVzdC1TVk0tZGVtbw0KPj4+DQo+Pj4gQ2zDqW1lbnQg
TWF0aGlldS0tRHJpZiAoNyk6DQo+Pj4gICAgIGludGVsX2lvbW11OiBmaXggRlJDRCBjb25zdHJ1
Y3Rpb24gbWFjcm8uDQo+Pj4gICAgIGludGVsX2lvbW11OiByZW5hbWUgc2xwdGUgdG8gcHRlIGJl
Zm9yZSBhZGRpbmcgRkxUUw0KPj4+ICAgICBpbnRlbF9pb21tdTogbWFrZSB0eXBlcyBtYXRjaA0K
Pj4+ICAgICBpbnRlbF9pb21tdTogYWRkIHN1cHBvcnQgZm9yIGZpcnN0LXN0YWdlIHRyYW5zbGF0
aW9uDQo+Pj4gICAgIGludGVsX2lvbW11OiBleHRyYWN0IGRldmljZSBJT1RMQiBpbnZhbGlkYXRp
b24gbG9naWMNCj4+PiAgICAgaW50ZWxfaW9tbXU6IGFkZCBQQVNJRC1iYXNlZCBJT1RMQiBpbnZh
bGlkYXRpb24NCj4+PiAgICAgaW50ZWxfaW9tbXU6IGFkZCBhIENMSSBvcHRpb24gdG8gZW5hYmxl
IEZMVFMNCj4+Pg0KPj4+ICAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDY1NSAr
KysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gLQ0KPj4+ICAgIGh3L2kzODYvaW50
ZWxfaW9tbXVfaW50ZXJuYWwuaCB8IDExNCArKysrLS0NCj4+PiAgICBpbmNsdWRlL2h3L2kzODYv
aW50ZWxfaW9tbXUuaCAgfCAgIDMgKy0NCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDYwOSBpbnNl
cnRpb25zKCspLCAxNjMgZGVsZXRpb25zKC0pDQo+Pj4NCg==

