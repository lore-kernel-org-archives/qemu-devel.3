Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DAF8D31A26
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 08:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfwQA-0003XA-P4; Wed, 14 Jan 2026 03:40:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfwQ8-0003WQ-Aq; Wed, 14 Jan 2026 03:40:04 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfwQ6-0001Ud-5P; Wed, 14 Jan 2026 03:40:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/Ua3cUyD3m39vXWxuO53nCDm8dT8ChJehtf73TjZRwx+gYQMQz6pUcPdApJzWZsDm2hUpn5JjHVQwDaIjNyb6REaH4xwGUa5BgjFxNp5/cG9huHtQ6emTWG2v/lPsAJoSJhJTDoSdIMz1uvIfcJEs82B+G+X5WWNuhDYY4ah2El/FmYyRfApSsCIIzEG0j8pIxdeW9ymM8Mz5FOSO5vn1cgO9wIshvG9mKkMKhG2GX++XrbtLWI6N4C/BL9RycywJsTv7sF5VbAELm7JlSUTL/IOACr0D00xj/ZsgAxHUihkgTfpDx/1POXKU3s3EPyvkNnuc6howaJ7MYG57T0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HKOiy80A8Va3dYGU+S8pd3Y+7VSDgGnhdbAwUFtlarc=;
 b=qt4do7thYAgWbZf7E37E7dT2tz8i5DdHPy1BsARjmDaUliYAndK4G2ioJIluBB5iPginKoZGBz8EGHFSQsK/GJm27pZ8xnAyDR4qO7Hz0wErF3/yG7wG7C3m3CEHzEX0lpe6tZTN8L/Q5JMv5FuG2pHrK+2U/aA85Ik7tQck29VlyLuDDtlbjvAOQPrYxk82KIZT2LOI9L8sKi6fcbxApuyq2gfHs0Dzb2ggb11h9e5HuGNDDeEJVAAzusZJDrc+V8wUrBFms5HQX6jHRK+Yqm85p/5GJMAtB2CR5uBXBTUoXVsqW+wPrRRdwki4/QORsAlRSpqvth+mX4ZeouDJAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HKOiy80A8Va3dYGU+S8pd3Y+7VSDgGnhdbAwUFtlarc=;
 b=cAwfYFrpdXAyEBWr7kNVH/t3n2znTTJ+uAkje/9Fmf6TrnV18atFUynLd8M6BZVJCRvUfd3UfKAk+8SqKiSFayzX5SaVNBkiBaHsZERbJ6q5E/C1LGUfL8yyReCv0KXkhAs+RXEB7GwisNLAayK7VSPDC4elJwH2uCTF0s2cYitpojl+jprjogtCpfMaKTF30Gve33LNC4IaqbZwKGNi5+YuOsOZnDTRIIBVVrzHlZZ0VZ7+gX77NjFPyhebObCabucRC59HSEb9JRgrtydAsptAHoy7JtYB3u2cY4UXvQUR88CuqDsTRUx7sxyHLk61OK+r87QDfCBSzkHVMYbWaA==
Received: from CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12)
 by SA3PR12MB9129.namprd12.prod.outlook.com (2603:10b6:806:397::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.9; Wed, 14 Jan
 2026 08:39:57 +0000
Received: from CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de]) by CH3PR12MB7548.namprd12.prod.outlook.com
 ([fe80::b710:d6a1:ab16:76de%5]) with mapi id 15.20.9520.005; Wed, 14 Jan 2026
 08:39:56 +0000
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "alex@shazbot.org"
 <alex@shazbot.org>, "clg@redhat.com" <clg@redhat.com>, "cohuck@redhat.com"
 <cohuck@redhat.com>, "mst@redhat.com" <mst@redhat.com>, Nicolin Chen
 <nicolinc@nvidia.com>, Nathan Chen <nathanc@nvidia.com>, Matt Ochs
 <mochs@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "vivek.kasireddy@intel.com" <vivek.kasireddy@intel.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>
Subject: RE: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Topic: [PATCH 3/3] hw/vfio/region: Create dmabuf for PCI BAR per region
Thread-Index: AQHcc0r/PShlE7i9HkafE8JAYPcnrrVIH1QAgAAPWOCAAYu5AIAARN1QgAPxowCAAGXKAIADJC6A
Date: Wed, 14 Jan 2026 08:39:56 +0000
Message-ID: <CH3PR12MB75481B0654599B9BFA98EEDEAB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20251222135357.143339-1-skolothumtho@nvidia.com>
 <20251222135357.143339-4-skolothumtho@nvidia.com>
 <d043f6e1-8fa4-4215-95ed-7570ae002e11@intel.com>
 <CH3PR12MB75485C401917E76FF22E0122AB85A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB9136783B1EC050DB8B655A2A9282A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB75487D6B81B1C6556E044B6EAB82A@CH3PR12MB7548.namprd12.prod.outlook.com>
 <IA3PR11MB913696E604E31C678F7083979281A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <CH3PR12MB754866E17D778C5836903444AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
In-Reply-To: <CH3PR12MB754866E17D778C5836903444AB81A@CH3PR12MB7548.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7548:EE_|SA3PR12MB9129:EE_
x-ms-office365-filtering-correlation-id: 3ad2b10f-daf4-400a-e8e3-08de53487f18
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UUZvNkNiMExkNHZtNXdydEdTRnZ0M3VxTDdCL2srbDlnMFVEUDBaei9jN2xh?=
 =?utf-8?B?SUN3VU9oY1o5L25RZE5GQklMQ0ZYVkJyZ1dxWi9maEJLb2tna1FXUTIwVHcw?=
 =?utf-8?B?WnE1M2ZTWkFBN3ZjSlRRSmY2VEVsbEtxZkNnKy9hNWN1UEU3R0ZRTEZOeSs3?=
 =?utf-8?B?YUEveHJ3RkU2NVV5cUxyS3FLdGxHN1J3WjIxcUxCVkZhSEJRNnBZWW56RmZN?=
 =?utf-8?B?eklqWkt2QXVqU2JvaW5rQ1I4SzF2aU1xaDcrYWdnb3FrWTFldlJOMDdPUENw?=
 =?utf-8?B?b3hnSjUvTFVsTlFVSm4rdCtxSFAvMU5rZThTWXpMMG1sZ2w4ZkdFOTlzd0ND?=
 =?utf-8?B?bHJweS90bWQwOTVkNGtzaVNuT2JUcDk0TFc4Ykk2OWJvbU1GRDZkR3g5VkUx?=
 =?utf-8?B?UTViZmk1cFBpWjBnMjVRbU95a1V3WDFrWEZ5Z0pzY1dFSjRoOWFKSDlmS2ky?=
 =?utf-8?B?aFY0aWEzUHdYTS9ZZUUyd25ITXZ4THFUb1hxZUlsK05YSnFYdFlRTFJqUTJ0?=
 =?utf-8?B?Y2dSVmlJd1dOaWd4cjY1c2YwdkpNbTF2TUt6MHVMdVJVZ25YaDhTTTUvNS83?=
 =?utf-8?B?aGQ4Q1QrVDJXclVVSGRneHJSOCtOZzNqS0tmbUE5c0hRcFlSTVZXV3ZrcWJK?=
 =?utf-8?B?N3ZsSTV2Tm5HZHV1WVI3bnZ2NmVXOHBQd3k1UXUwb1A4Lzd6MVdsT1p3Zkgz?=
 =?utf-8?B?enRkcjJuNFptQmordXpmRzlwTVNVUE1SZXI2bUh4VjFHUmhTRk5XNmZqUVMw?=
 =?utf-8?B?VjM2SGVUSUxoNVBkUTE0VHIzeVJLNDMzZTh5MEVGcHBPeXRSMUlqSm9NTFNL?=
 =?utf-8?B?VjVRcWs2YlNpbllVZkFvWGdTUENsMkIrSUhmaWFCTVVFWU1xVkRhR0xZeFBE?=
 =?utf-8?B?THJRbWdpY1JYQmRrTHdBRDlJTFB2MGZicVlZVE1pZFdqaDhpVlZPK3IzTnAr?=
 =?utf-8?B?TmhBQ2Y1ZGJLc2tLRWQvRys0aVZkU0tQZzhjajRrTUZhZGVkRGtNNVNJc29N?=
 =?utf-8?B?eVJZWTluYnQxZTV5Zk5PczM0bFB3R0JTMU9pV0prOS9NekcwU0pFcjJmTU9a?=
 =?utf-8?B?bHZQem9Ha1pKUW11SmNWdGdGWXYwekdVUzdCQ2tRM1d1UFpXTmRub2tMN1o0?=
 =?utf-8?B?TmJmQzk0ejdrNDNiWFp0OGRQWjJSc2tQaHBHVndQMTdnRlFQZHZuTmhMUENm?=
 =?utf-8?B?cms2QUhLV2RxcVZBQmhkSjRlR2REZm1MaENRNVFZTk5KcWJNdmRTcHlDUHM4?=
 =?utf-8?B?OVA3bHhTOTdEUG9zQXB6NnhlSitvczdaQXQ4MW5uVDJ3QUhxT0I4QkszL3Jt?=
 =?utf-8?B?WGhRSFNzNVVhUzd5dDNXbFN4WUdHdEtHYUF5cUJ4QzR6TFBlVVdDc3pNNzNy?=
 =?utf-8?B?dVo2UTJHUy9nTk5teXd5OE9MWnRLK2hMdVJaVjVlaTJ4ZXNOa1UxMXhSUVkv?=
 =?utf-8?B?eHFoNkpuN0IrZ2Z3Tmg4a2tld0Z1VUowQldvYk00T1RxM2lKS0o0bjcxMkQ1?=
 =?utf-8?B?VG0vdGxaNTE1Q1F6dEpUUHQyU1pNY2l0VjNpS3hGbmVLVTVnZDh2TWZSU3lM?=
 =?utf-8?B?SkdsK2lTaEVSWHVXTi9yMU1ZN0dtdWtTUVNsRUNxUFhPakxQMDBhNGNkblVW?=
 =?utf-8?B?UGkvaEpXTENHeXJYZ2hiVGJoQmR1eGJ4WmIwWEk4MUVMa2pZL3c1U0FPSU9a?=
 =?utf-8?B?U1pXMjNYa2o4RDZZd2ZSU3Q2aHNMVDNmRUhHaGhoVjhuL2U3QzM2akt1dWFZ?=
 =?utf-8?B?eVFUaXAwTGFEZ09naXFoVzh6NFFjNW5OaXJ2YXI4SjNyajJacHFmZ0pySFdN?=
 =?utf-8?B?bUUwR0gvNE0xbVR3dXlLYnNVd005dGFCZU5Dc0NtaTRXV3NGcXNJb3NXbWlS?=
 =?utf-8?B?WU16ZmhtbEpGOU5DVFNmM2pBMG5keDVNL1ovektXVmtvenBSQzVRYVZvZWpx?=
 =?utf-8?B?M2N3RitOZzY3U2JRaUNnK1d1b0NjZk4wY1pDOVE3OVRZeUEzK1RuTklqRGxP?=
 =?utf-8?B?VEdJN0Z6NnpVY1BzdFRLQmdxa3ZwQUFmTE9nTUI5UnlOQlBKRlpmMTRMaXRS?=
 =?utf-8?Q?N2C6SK?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR12MB7548.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZEpGWFV6QVBQT25PMkJnNlZsWDk4OFFPN3ZBam56WVUwamMrZHVNdXNHdUlx?=
 =?utf-8?B?anlyOTQ1akxMcmdFS1EzdkhGbnBneXBqSFZldDdTM3dkNkRwTG5YcmMwRW8v?=
 =?utf-8?B?K0lkZVpxSUN1Q3ltcUY3MEQ2YUU3dUoxTU9BM1YxaXlEUVlyVG16VCt5NVow?=
 =?utf-8?B?dGVOUHlDUCtYVGpiRnhEVnFmVnRoa3d1TzVob3hHc1BEMk9oSmFCa0RwZUlo?=
 =?utf-8?B?RlF3aUNzbytEVXBLZENZeityb3lXaTVURVJHTm1ySW1Ob0k4bVRUYU1ZcFJk?=
 =?utf-8?B?VFFJdE5zbWNnSjU4MFpGcDFBN0p3eHlDOVpXRDdETnVtd0dUSG1rZldWdkF3?=
 =?utf-8?B?WUU3N1Y0K1k0cm9hUnh3TGFZWUpSMUh4a0M0SXlIUXR4Y1lFcXNXSW8rUGto?=
 =?utf-8?B?Wno2V1Nzak5HckIvSzdrSG9mNlUzZXRIR1hhaURta1lqMll1Z0RlYUxTb2x3?=
 =?utf-8?B?UncwaWVlUGpja29qMHdjK212K3RBQkxJQWc0RmxZTG1vd2ZqeEU4SDM3VXBP?=
 =?utf-8?B?anYwMFVFSDUrTHJnOVJPMFVuNlJNVG9vOEJ0cHFBbWxlaXJldDVaK05tYVRh?=
 =?utf-8?B?Tm44Ti9lZkxWclZ4WVNKR3VQZktPYUJDbGVTZG9RZ1J0WE1wMlc1TXY3bUt5?=
 =?utf-8?B?RERRQ0JtdGRoVWptWFYvSU1PbUxoSU1kckNSZ3poU0xHVEJJSm16WFpSRzZl?=
 =?utf-8?B?ZVdrajBFRmoxbFhlRVQ3OFQvd016QUpwd0J3MEFiVDVHSGJQNUZ5VXEyVXdL?=
 =?utf-8?B?dlVPM3FJeTBBZjNPakRVc2dsZ0JWeU5vWFBuV3ZQUFpiNGN5Zjkxcko3Vjhv?=
 =?utf-8?B?cFVvMkVtb0tFUWNLSlRRWWQ0dm9lN0ZoU1E4eEprYmR6QjhHY2ZtYVhWTWZk?=
 =?utf-8?B?TmY0a2xiYW14NVoyb2tMbWFTNzNuSjhEUVRUTTdtT1c0aDlPamhMcDJndHZQ?=
 =?utf-8?B?cGFjaFU0bjFBaGdjVXk4WGpYRnJGa2ZJWGgvN1lCYmJlNzBpUFVXbGxKcmY0?=
 =?utf-8?B?OVNpaUpkRjFXNENsM3NNM2VzQ3Nmejd3VmZtQ3RZNmx5MzNaVi83aFVNUXZu?=
 =?utf-8?B?ekhWeFZ6OW11NHcvbnhlVWFZdmtsdUxzdHB3UWMwRUJOVWV0UXVDRjI2dXBX?=
 =?utf-8?B?L1F1VDVoZXZpS3NxalpvM1hrNWxKMWVvOURnRGFpN3lQd1lGWjlKcjZndWRz?=
 =?utf-8?B?NmZ4OVBwajNnOEpDUTFlSnNINVBtSVJXNE1PUWhZWWRJRVBZUzNrZFZRMVZ4?=
 =?utf-8?B?cWNISi83cHV5UjFmZlFjU2ZzQW5BOUNWNlJKL0tVZ3REYmZucGJ5N09GUkFa?=
 =?utf-8?B?bzFXQlNVWkxVTHMrRzU5SEJsekgwS2ttY01aek9EaHR3akh2VFg3S2RBcjI2?=
 =?utf-8?B?aGZwV3NqbkFRYWlXZG9kajFZQWNRWTZGS3g5VHZlMmNNRk91TW5IRnZhR1JM?=
 =?utf-8?B?SWk3SFBoeTRZc0pWYVVIeFhiSWpsMGNlYnBYOEQxU0FBQVRSUy9IbEJhQXF4?=
 =?utf-8?B?VzFkVkxRNllnT3pYQmJiSG5VOXdaVlh3UmNLMlNRRmlmYjRwU0ZaZnRJVEpr?=
 =?utf-8?B?KytTSHpHZlFZKzUzSzFXdWxHN1JkYXpJeGg1Zno0T3pGSmxsYUdJUHplWHRD?=
 =?utf-8?B?R0NkUlQzcGdrV1daMnBwWWNKM2VNM2pFOVMwVjBpYVFpVW9LbzVxTmRtR1V6?=
 =?utf-8?B?OEU5cHhpVXNVWWpYYTdkakFGd2kzVUhjbTV1RHR5L1UvMnI3NHFCeVBSVkxJ?=
 =?utf-8?B?VmxyaE1mVU5IdjRKeHhlMFFHdmRNMVZNcE9WUTg4djk4RnFpaVAvUEdYOUxu?=
 =?utf-8?B?TGVjUXdvZkpvNUJ0Yy9BVnJGTk84L0hQMEdDU3J2SGl6ZFZPWDlSd3lkYm1T?=
 =?utf-8?B?eEdjMVBKL002MGZTQStGdlBueEROeFZDcFZMZ3dlRGFZbk9YaUIxcXRkRnAr?=
 =?utf-8?B?OThrMWZzVmRybXVqRW5LT21OakhkOGtjb3FWTUo5YUVUSTUvVHJEc1ZnRGJN?=
 =?utf-8?B?YVM3Tm92RGtXbGZ6RVM0N2pVZVlDUCtTbHJpc0dpWXZxS0MxSmVubm9jNEZv?=
 =?utf-8?B?STNWd3BYbUlzZ210YlUzQlR2MTdiaWpZRnAvZFJmOFJObVJzbUtmQ1V3TGI2?=
 =?utf-8?B?SU16M3ljbkRiN2hyMzFzYytSMGpmWEM3WjU5SW5WRmcxQmxjS0NmZ000RW5s?=
 =?utf-8?B?NlpkR3NZSk9NRjlVcEhKelFncm5KUEYyTVZ1eHNqeE9sZTg0TW5JOGVMWDgw?=
 =?utf-8?B?WHgzcFBRNERjY21MRytrUnNmZW5HSUc5N003MGFiU1ZqSEROOTA2cndkeXc3?=
 =?utf-8?B?eHRIZ2FkNDNId1BiZVN2ek9ndkNhSFZRZmlFT3YrZjlINzNwckY4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7548.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ad2b10f-daf4-400a-e8e3-08de53487f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 08:39:56.7680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P1lapCTnoj/8tzIusDhNIid/CunpJ27MEL5NPkvfMsSvZFAXHG4HQwUoDVIp8nCJIdW/Qk+Sq+2WTsVGRMnWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9129
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2hhbWVlciBLb2xvdGh1
bSA8c2tvbG90aHVtdGhvQG52aWRpYS5jb20+DQo+IFNlbnQ6IDEyIEphbnVhcnkgMjAyNiAwODo0
NQ0KPiBUbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+OyBxZW11
LQ0KPiBhcm1Abm9uZ251Lm9yZzsgcWVtdS1kZXZlbEBub25nbnUub3JnDQo+IENjOiBlcmljLmF1
Z2VyQHJlZGhhdC5jb207IGFsZXhAc2hhemJvdC5vcmc7IGNsZ0ByZWRoYXQuY29tOw0KPiBjb2h1
Y2tAcmVkaGF0LmNvbTsgbXN0QHJlZGhhdC5jb207IE5pY29saW4gQ2hlbiA8bmljb2xpbmNAbnZp
ZGlhLmNvbT47DQo+IE5hdGhhbiBDaGVuIDxuYXRoYW5jQG52aWRpYS5jb20+OyBNYXR0IE9jaHMg
PG1vY2hzQG52aWRpYS5jb20+Ow0KPiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPjsg
S3Jpc2huYWthbnQgSmFqdSA8a2phanVAbnZpZGlhLmNvbT4NCj4gU3ViamVjdDogUkU6IFtQQVRD
SCAzLzNdIGh3L3ZmaW8vcmVnaW9uOiBDcmVhdGUgZG1hYnVmIGZvciBQQ0kgQkFSIHBlcg0KPiBy
ZWdpb24NCg0KWy4uLl0NCiANCj4gQWguLiBJIHNlZS4gIEl0IGRvZXMgYWxsb2NhdGUgUkFNQmxv
Y2sgcGVyICBtbWFwc1tpXS4NCj4gDQo+ID4gSUlVQywgd2Ugc2hvdWxkIHNldCBmZCBhbmQgZmRf
b2Zmc2V0IGluIGVhY2ggUkFNQmxvY2suDQo+IA0KPiBPay4gV2lsbCB1cGRhdGUgaW4gdjIuDQoN
CkkgaGF2ZSBzZW50IG91dCBhIHYyIGFuZCBtaXNzZWQgdG8gQ0MgZmV3LiBTb3JyeS4gUGxlYXNl
IGZpbmQgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyNjAxMTMx
MTM3NTQuMTE4OS0xLXNrb2xvdGh1bXRob0BudmlkaWEuY29tLw0KDQpUaGFua3MsDQpTaGFtZWVy
DQo=

