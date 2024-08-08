Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85262C52D7B
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:57:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc4ZK-0004Cv-9M; Thu, 08 Aug 2024 10:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sc4ZE-0004BT-SY
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:56:43 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sc4ZC-0001CL-35
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1723128998; x=1754664998;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=yDhIgOPA+qE5efY7pmsI8PH361T3Gh+apBA2ziskOh0=;
 b=cSawvM1RIS4pFq4glzSzPD8F2iclf+YXav0XEYq4ng+lnz8ANEMhvXQP
 Xr0IVi+TpVw1OOUCsnzlqBskQLm6MgmT7J92OnZ2zJp8jM+zj6GVMcfHm
 4KNUL7KkWMX652w4gh4FmBNTDHfqBX3gvGeS3nn3Kik1XmfIDO6KjrJqb
 lOw85ZwAn8IKGfxMhGJ9HovWHp3/TL6/u+1hKyi3y/qgUYejiowBIDWmA
 xTyj0YPlEtAcXLKBLBC5Zj73KzHcfilJWMs2S1hzmbprLafw/GdUR+8Eh
 PX/JKRIXHnU8uOPsR6c8+k+FaN3DjiIKllnYIPH19AtnGu+Nhko5zYNmW Q==;
X-IronPort-AV: E=Sophos;i="6.09,273,1716242400"; d="scan'208";a="18022396"
X-MGA-submission: =?us-ascii?q?MDHcUBCexclG9qW9ftzNdhOzSjFIvsLv35/5rv?=
 =?us-ascii?q?BH0PcFdSYpJoswR1TW+ZlBLEdSQYEkgZraW0l8tRhQwTK/7EKKNEAEeF?=
 =?us-ascii?q?XmSz7tZhvwVgLv/+5RsfW8n1uUMsIxE60c17r7HuB+FHw57DLxxM9z8u?=
 =?us-ascii?q?21Wqyb3QeOlB4UkwuSML0LyA=3D=3D?=
Received: from mail-am6eur05lp2113.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.113])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2024 16:56:30 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UqjFclyomgRV7ablKcthPYOwEe0YOguvV9LQ8hwoR2xYCjIU33hks/oJF94bUpuhTgqhsuLo/SC+Ki08nyoeBdauZcSWBSylHU3lq0sySP9eI/VnpN+ReYhqSE2bGNr9KZnLDKhOTrqKLeDE3/ooyxcYlPhP/zVR9aIZfwQH2agrbD3NHUZdchSVfZt5YhkMqN5SioJ0WhzCLHVcfDQ4TmjGZ12tkKBOHJZAB5ROYm8iXU7seF3nbTGIPgbxrKf1jyekuRlc7R5kkkqPGxtJED/t8e146qgDQ+px5azTu+eMp4R53C0pwfRAT4mwFngR3ZeIJOCA6Kefrn4lf3LIhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yDhIgOPA+qE5efY7pmsI8PH361T3Gh+apBA2ziskOh0=;
 b=PhOx/O491WFhkCB7rSiamiJ00sm5oYXyDY5R9j4xOgKg6LMC3V42csAi1RatIJlljWmNOPUFJ3dKGjpKGJbHqImt8MkDIsOFqYIiZdNDCq5UqJKp9k2enCcXPk0sCXLFUyZf2JDhBJulJ8F0D5lNU82XrLcPFATyMsf7YjJEtYPqWCBt0fVugnxjLAA8tFSI86yU5M3w8YE8PXFX9J9I9pG++g26uUUCyKn/nYZdC38dhD4fpJhSoA4B0vK3d11xXIQDBClZvaRoVPUDPwdA7xfDRVf4ReMnXzIRnET1UjsMzA3mve95iYnI+uzmg9gi0CWFnpVT/NeHBRL45MHmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yDhIgOPA+qE5efY7pmsI8PH361T3Gh+apBA2ziskOh0=;
 b=fmRECf/pVCQouxyRgaR3ZU/5FEP8VdOc34oeuk4NWIWlFmpdN8O9sBaTLWcJ2HAO6sVmigXR9azMIrsrPJGjzv1A+VbwrC2xbdmaVE7mQJY3AL4UfPnIF52H2frFRKEGatZkOukMvSQ12tG6Vf0yJbhR4ryCRKWcva9GNFbNKi1zcNjsKfwxoWaLJilTBQ9Af6UFh3FsJDatandc5UZHvOVwgefFU60fsru/1FJkY4olf0rdu80hUz/j3FOaiMSpqZeYt49Cd7yd769D5/IOvyGjLkjruaDwqMsKyRQ/GPJlDf/UgRM4gK0+KLj/nYWxCdoq/uxlbe8iv4wsWnxppQ==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by PA4PR07MB7424.eurprd07.prod.outlook.com (2603:10a6:102:cd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Thu, 8 Aug
 2024 14:56:29 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%7]) with mapi id 15.20.7849.008; Thu, 8 Aug 2024
 14:56:27 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard
 Henderson <richard.henderson@linaro.org>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Topic: [PATCH v2 04/17] intel_iommu: Flush stage-2 cache in
 PASID-selective PASID-based iotlb invalidation
Thread-Index: AQHa5wD3t0aSWs4KZku3dYcmr1ZjXrIZx6uAgAOKqACAACXlAA==
Date: Thu, 8 Aug 2024 14:56:27 +0000
Message-ID: <1b46fc72-7e51-4585-865e-1d32b2ae6997@eviden.com>
References: <20240805062727.2307552-1-zhenzhong.duan@intel.com>
 <20240805062727.2307552-5-zhenzhong.duan@intel.com>
 <d245008c-ef6e-4a58-bcbc-869aa4901cf4@eviden.com>
 <ecfaec89-bdfd-0512-b9e4-d2dc237a9c56@intel.com>
In-Reply-To: <ecfaec89-bdfd-0512-b9e4-d2dc237a9c56@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|PA4PR07MB7424:EE_
x-ms-office365-filtering-correlation-id: 7b92ba67-1b08-4150-9371-08dcb7ba47f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?TElFWjhmS1VpUmtsdmVqWlJ6ZlVMY0g4VGdidTBia1pBeGIzY0VqOEQxeFVQ?=
 =?utf-8?B?dkJ2a0tHTW5IeWsrdU9XZ1JtZytqZDY5ejBTaVBXSTY1enNLK0VKUmRJRzBN?=
 =?utf-8?B?dlliMzhaSUVmVE9kS3VGdXA5NnJkaXBCRkJ5WUJZcEsrOGpERkxDM3VRUkR6?=
 =?utf-8?B?Rm1mZkVxNkF1K0RjU3ZPdHI3RnhDcVBBNVdDMk1NM2syOTQ0RmJvVHJuVDIx?=
 =?utf-8?B?b3JtSDQ4K0p5L0xteUNvbXNMOGszKzZEcmFQR080ZnVveDkxSy9qSmxWK2tk?=
 =?utf-8?B?dFhZWCtYNklxVVNhRXYyZU5wNmtqbUtqdWtoZ3hMRUNGUndtSTZSVDRZdFB3?=
 =?utf-8?B?a0h4cnFPcks1bUFhMTZmQ01yblNQRXRKQVdWTlVnc1dWOGFiY0FQS05Nd08y?=
 =?utf-8?B?VTdPSGpkR245Y3gxNGRPTkw2MllYV1pwNXkyTm1pZ1B1RjdaMzlKMXQ4UmEv?=
 =?utf-8?B?SEhoclF0Um5RUTluVkowUlZUUkpXQmZTRFZ6Y1BscThnbWQzSUFOUG1QVGRD?=
 =?utf-8?B?TXZCaFpqTXFhZU5NN2hMTlNhdjJibU9WTm1uSktVWG82M3UvSkE3SU9IYmNK?=
 =?utf-8?B?OEhaLy8zd1IrQXJ2OVRTNFhXc3kxOFVCYzJLMCs3WHZ1M3haT2oxRElkeDVv?=
 =?utf-8?B?RXYrQ00yVjd1U04yZzVvcTlDazNRcW5GVis1dndRc1pwb2Uwa1IyRi8zK0x5?=
 =?utf-8?B?N3dDQWdYb29lMkJxeG5kUG5Ra01rTi8vQWtxa3JKSkR5VUdBdnpFakZWcG5i?=
 =?utf-8?B?bHp1RUppeUtzVDlHS200UEsxK0Z1M3JseEJGZGxvWG5PVU1XRXNJbWVKWmgv?=
 =?utf-8?B?bVI1cjdLdlIrMFRxaUYwY2NBejlNb1dFQ2J0Qllld2pPV3ZvMjN6WDc3Wlpw?=
 =?utf-8?B?Z1kwSG9BNC9tdUFLcVY0bXViYWNCaUlsbHh5UVBQK2F2eTBaWHpWc0ZpYUJ3?=
 =?utf-8?B?cFZLVUVyL05lTTM1R0NyU2l3VmE0c0xIcVlIa1UzcUxvWHhEdWpxZG1DMmwy?=
 =?utf-8?B?NDMwQzBjYmNBcjYyMTRMekZodXBxdHgrdFMyeG9GQ2V6dnR5Y3BrOTZWdU9Z?=
 =?utf-8?B?ZzF3LzRjN0haeHdJSlp1WDFpOWJ4ejgxMTJzUGlWT0VSV2MxdTgxMExPTTJ5?=
 =?utf-8?B?YmlVdVFCQzA2ejdOV05VakhwMjZHMjV0Z1VWMHlYcEZ5WjdFTlNMK0dIdzFH?=
 =?utf-8?B?QzROTUhJOXNRMEx2dEZrVVZmUXdMd1Rab1ZzbGhDTnI4RlJrUkFNYXorbnJa?=
 =?utf-8?B?ZzJjOUZrRnZYNk5YbjBoRkY4UGlQT3lNeVhKdk92eE82UDUydGpmUVR3NVU3?=
 =?utf-8?B?bWNpdHdIeU1veXZTeEZBVm9NTWdWeUtWa0xjbVNxaWpQc2V6RVNEay9pTmkr?=
 =?utf-8?B?NnEyQ1JJZzUrN0wvQ29nY3ZRNG1KSXhFOVhFK0RFWGw3MFdFa3IyNFlvcTlx?=
 =?utf-8?B?Qlh1dFRwUUJhSmg5SUlZcEhVME5CSUFKd1FOMGhjMXAvaDhVN3pyVlpKeS9C?=
 =?utf-8?B?Y08vZFBoUkd0bkNpS3p3MWt0M3VzMmtwdkE0NUUybEQ5YVQ5SHg4amdWcHpZ?=
 =?utf-8?B?ck9rc3RDMWFHVnJDcC8rY3NlZlZKelRLNEQwdHdCbEdia1RTOWFjVFFYTnh1?=
 =?utf-8?B?TFoxdCt2Q1A0dzlsbWFJdnlxOWZXYnR2endoVzJtWlB1a0JTeVN6TzI0OVl2?=
 =?utf-8?B?M3pmR1JCanRhOWVUaDFaaUhad0E1QVpkekJoSjJyYkdnQ3dzUEZ1TUh5djJi?=
 =?utf-8?B?cnNUakZLME5lcDhBamhWZjc2Q1p1U0NZUWQvR3VOcFYyWXd0UVZxNWFWSWww?=
 =?utf-8?B?Z1Vta05ONE9XZUlUV0NTVWlpalVId1dCTWJTUnZnTTdTbzhvQVVQazlOMDYz?=
 =?utf-8?B?ZU03b056NWZLclM1UFVqQjhPdXF6T01OZHE3VWR4T1FyVGc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3dpTmxuc0JSUllzbm1wdUxnQ0VYVDdGcUNzeUpYOUorS3ZDdGtuWk9qU3cx?=
 =?utf-8?B?aksyNElncmY3YjJzTmpSYjZPeVFoa0JWV29CbXl3TjBieEhhMktGMHF3UGNM?=
 =?utf-8?B?QlJJb1c0d29ZS0xWaUIzVUdpbWlROThkcVVpU3dnMVE3YURzVE1ZQnV3WkJo?=
 =?utf-8?B?d3A3T1dUQjhrL3M3b2k5OFFQbm9raVdVenhmSjNiTzhNSnV5MTIwZCt3Vy9Q?=
 =?utf-8?B?cHhoejBCM3c1SWdxRDNvZHdCSjhoMXdEKzNxdjA4VC9TdHpIU1I4eGQvQWVU?=
 =?utf-8?B?Zm5wWnp6aERpNTZreENCZ2NLT2VsanEyZnc2L2tuSGJubFRublcrbW95Sk5m?=
 =?utf-8?B?YzFMckE1M2RiNlJRWERyMWFMZytQelNUNXJ4Qk5randPVDRQTXFwZlZJSEUr?=
 =?utf-8?B?eGJMREpHYUQxVGxLUEpFdDZpRUhzRmlNSndaeUpEUmhqT2JDSGpTV01NdU5Q?=
 =?utf-8?B?aEZDTDBtNEpGU3BKMWF6TGNGZE9qOUR1SnRxVEc5eFM1eFc2czBRMktFMUhD?=
 =?utf-8?B?K0JSYm1RZ3F1ZEJzTmN6SWFoMUh5b0R6QloyWTNhc1ZwUnhNRlhVNHZOWDdv?=
 =?utf-8?B?RFlIdXp0b2ROSHA3SW1jcVd6TFZvYU9zOWN6MGdIQWcxTWhXSS9LUlFvSjRI?=
 =?utf-8?B?Z3RlU2llZ3Q5dmM1US8xYW9YOTk1b0VOd3R4a2NCMlB6TkRvVUJqV3c2Vkd2?=
 =?utf-8?B?SDQ3cWRmVTVvbVppeWlPL1JnQ0N1clJXa25DU3dTeTQ0NlpjZWRhY0orSHBD?=
 =?utf-8?B?bkZQMTRrUzAyUHRFclRWLzI4a2N1dzFmRFVPZ3U1MTRTV2szNjFaeWVZTXM2?=
 =?utf-8?B?NklJTXlrSHM4RkF6SnhxcjQyZzhkUUlQQVRrWWV5TmNxd0xjWUJMTmdhMzE4?=
 =?utf-8?B?SkdMNW16Q2t5WVZOcTlodDRXTU9pMDlPRy9YMlpwMFh5NjlDVFFUd0YrMTBY?=
 =?utf-8?B?MFVhS21KWk54M3JiemYrR1FKNzA4UEpTa0hBQnVoYitFVDFzMk5WUmM5V1JN?=
 =?utf-8?B?cWhiL2hDYm9mVXZic2ZqM2d2b1ZsTjVEb3l2dTRjdWxiNTc3dVlsTUZVV2Ez?=
 =?utf-8?B?VHJzc0Q5V3Z3RDVobVY4OGgrQy9CQnNDVWJVcG1qdGxLZENabWUyVlNaMGto?=
 =?utf-8?B?QkdvdDhiNkpTUkJyVzVPeVhhMG5Rakl2aWE2K08vZUM3a1lFQ2V6MWxmTkRj?=
 =?utf-8?B?U3pIamJxa2lrRjZxTTlPNnlTcjJLUnVOSVZRRGgzRWRRaldkNXVidHBDZjJP?=
 =?utf-8?B?MmdlMjZTT2NYL1o0VmdJZ2g4bEdIY21JaVczMDFZODJua3FWbm1mTmtFck00?=
 =?utf-8?B?SUx1eXl4dGNwUnZBZU9RZ1IreDV2OUNBbkZZMmdKei9IMElad1JDcnJ5NUM2?=
 =?utf-8?B?bUxFUnpuVkFYeEVnczhvS2ZMSGZVMFRDVWw3WmtuZEV2SkJWa3NTdC9oSmFl?=
 =?utf-8?B?T29vbWExVFhYTkh2MkZrT1V5aGQ0QUJlRzd0WTAxd3hqa3V0d0NvMFU1Wi9L?=
 =?utf-8?B?SFdZTmRnUUFMY2Y2TUNpeXRnenkxWktzTkYyYVIweEZGc2tDdGpPNUJPUk00?=
 =?utf-8?B?RVZHd0ZjdG9mWWFncVp1bWFETzlscE05MGxlbDdsN0d5WjM1MWdMUVlhNXdy?=
 =?utf-8?B?Unp5RlFIZk5FL2F1QnlBMWNTQTd2Nk4yK21rQ01OYnppZDJhbVBCREhqb3h3?=
 =?utf-8?B?WVFnMWxZdXdsRHErNVNjWkdhU2lJbXpVVGtMazRrQ1h5enlJQzd2WEFYMFM3?=
 =?utf-8?B?TDJWamNzdHk5R2NObVMzSkpmbWxEdjBhN0JsQjRLVTBhaHZwNDhVMkkxMnFT?=
 =?utf-8?B?SEdFMmNzOEpjL1lLZTNJaHZjR2RNeE8yTzhJRm14WjRLUGNBUkN4YkpwK1Js?=
 =?utf-8?B?Q0VQcGJjTVY4Q2F1Q0Z4aG1PQTNxdW9qRXgvWnNjWHlROVkyVlhsLzhqN2JX?=
 =?utf-8?B?blVlRlk1TmJDbkRQMmtsWlBxWDBNU0YzMW5Ec2NYemdvTGNMNWlHQXpiUmgw?=
 =?utf-8?B?dDBDZk5YMWd0ekMydWdiR3oxdnBTdll1MG5kREUydjJUTkJEbTFKcHNMcytO?=
 =?utf-8?B?TVcrS1J0SjhLQXBCRWg3amFPQVJXOEZNa1FTZ1RvYmw5R1d6WVdCZTlBcVBD?=
 =?utf-8?B?SGFGcjJMVEFIdlpzMDRrSDN6WXV2M0N5c1poT25xcm9Ec3hqRXEyTWRMWXN1?=
 =?utf-8?Q?9vKS/QKpeg7P2WPi2h3VKRA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3F9CFFBD9DF188468E18E323B26F390B@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b92ba67-1b08-4150-9371-08dcb7ba47f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 14:56:27.8593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AUAUN65Z2r+0X6GzawNDKkGAVaPkiBzSs3vyYurr+EEWz5xizDI6+WH9kdFuAhTWhSSUEVmh1dE/wti6xcreAQ4Y17E42/EHbT40XycKYrZ5mUKfMdjsWINI5TGq7Rmh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7424
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

DQoNCk9uIDA4LzA4LzIwMjQgMTQ6NDAsIER1YW4sIFpoZW56aG9uZyB3cm90ZToNCj4gQ2F1dGlv
bjogRXh0ZXJuYWwgZW1haWwuIERvIG5vdCBvcGVuIGF0dGFjaG1lbnRzIG9yIGNsaWNrIGxpbmtz
LCANCj4gdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRlciBhbmQgeW91
IGtub3cgdGhlIGNvbnRlbnQgDQo+IGlzIHNhZmUuDQo+DQo+DQo+IE9uIDgvNi8yMDI0IDI6MzUg
UE0sIENMRU1FTlQgTUFUSElFVS0tRFJJRiB3cm90ZToNCj4+DQo+PiBPbiAwNS8wOC8yMDI0IDA4
OjI3LCBaaGVuemhvbmcgRHVhbiB3cm90ZToNCj4+PiBDYXV0aW9uOiBFeHRlcm5hbCBlbWFpbC4g
RG8gbm90IG9wZW4gYXR0YWNobWVudHMgb3IgY2xpY2sgbGlua3MsIA0KPj4+IHVubGVzcyB0aGlz
IGVtYWlsIGNvbWVzIGZyb20gYSBrbm93biBzZW5kZXIgYW5kIHlvdSBrbm93IHRoZSBjb250ZW50
IA0KPj4+IGlzIHNhZmUuDQo+Pj4NCj4+Pg0KPj4+IFBlciBzcGVjIDYuNS4yLjQsIFBBRElELXNl
bGVjdGl2ZSBQQVNJRC1iYXNlZCBpb3RsYiBpbnZhbGlkYXRpb24gd2lsbA0KPj4+IGZsdXNoIHN0
YWdlLTIgaW90bGIgZW50cmllcyB3aXRoIG1hdGNoaW5nIGRvbWFpbiBpZCBhbmQgcGFzaWQuDQo+
Pj4NCj4+PiBXaXRoIHNjYWxhYmxlIG1vZGVybiBtb2RlIGludHJvZHVjZWQsIGd1ZXN0IGNvdWxk
IHNlbmQgUEFTSUQtc2VsZWN0aXZlDQo+Pj4gUEFTSUQtYmFzZWQgaW90bGIgaW52YWxpZGF0aW9u
IHRvIGZsdXNoIGJvdGggc3RhZ2UtMSBhbmQgc3RhZ2UtMiANCj4+PiBlbnRyaWVzLg0KPj4+DQo+
Pj4gQnkgdGhpcyBjaGFuY2UsIHJlbW92ZSBvbGQgSU9UTEIgcmVsYXRlZCBkZWZpbml0aW9uLg0K
Pj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4+PiAtLS0NCj4+PiDCoMKgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwu
aCB8IDE0ICsrKy0tLQ0KPj4+IMKgwqAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jwqDCoMKgwqDCoMKg
wqDCoMKgIHwgODEgDQo+Pj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPj4+
IMKgwqAgMiBmaWxlcyBjaGFuZ2VkLCA5MCBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0K
Pj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCANCj4+
PiBiL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0KPj4+IGluZGV4IDhmYTI3YzdmM2Iu
LjE5ZTRlZDUyY2EgMTAwNjQ0DQo+Pj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5h
bC5oDQo+Pj4gKysrIGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+Pj4gQEAgLTQw
MiwxMSArNDAyLDYgQEAgdHlwZWRlZiB1bmlvbiBWVERJbnZEZXNjIFZUREludkRlc2M7DQo+Pj4g
wqDCoCAjZGVmaW5lIFZURF9JTlZfREVTQ19JT1RMQl9BTSh2YWwpwqDCoMKgwqDCoCAoKHZhbCkg
JiAweDNmVUxMKQ0KPj4+IMKgwqAgI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUlNWRF9MTyAw
eGZmZmZmZmZmMDAwMGZmMDBVTEwNCj4+PiDCoMKgICNkZWZpbmUgVlREX0lOVl9ERVNDX0lPVExC
X1JTVkRfSEnCoMKgwqDCoMKgIDB4ZjgwVUxMDQo+Pj4gLSNkZWZpbmUgVlREX0lOVl9ERVNDX0lP
VExCX1BBU0lEX1BBU0lEwqAgKDJVTEwgPDwgNCkNCj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0Nf
SU9UTEJfUEFTSURfUEFHRcKgwqAgKDNVTEwgPDwgNCkNCj4+PiAtI2RlZmluZSBWVERfSU5WX0RF
U0NfSU9UTEJfUEFTSUQodmFsKcKgwqAgKCgodmFsKSA+PiAzMikgJiANCj4+PiBWVERfUEFTSURf
SURfTUFTSykNCj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFTSURfUlNWRF9MTyAw
eGZmZjAwMDAwMDAwMDAxYzBVTEwNCj4+PiAtI2RlZmluZSBWVERfSU5WX0RFU0NfSU9UTEJfUEFT
SURfUlNWRF9IScKgwqDCoMKgwqAgMHhmODBVTEwNCj4+Pg0KPj4+IMKgwqAgLyogTWFzayBmb3Ig
RGV2aWNlIElPVExCIEludmFsaWRhdGUgRGVzY3JpcHRvciAqLw0KPj4+IMKgwqAgI2RlZmluZSBW
VERfSU5WX0RFU0NfREVWSUNFX0lPVExCX0FERFIodmFsKSAoKHZhbCkgJiANCj4+PiAweGZmZmZm
ZmZmZmZmZmYwMDBVTEwpDQo+Pj4gQEAgLTQzOCw2ICs0MzMsMTUgQEAgdHlwZWRlZiB1bmlvbiBW
VERJbnZEZXNjIFZUREludkRlc2M7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKDB4M2ZmZmY4
MDBVTEwgfCB+KFZURF9IQVdfTUFTSyhhdykgfCBWVERfU0xfSUdOX0NPTSB8IA0KPj4+IFZURF9T
TF9UTSkpIDogXA0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgICgweDNmZmZmODAwVUxMIHwgfihW
VERfSEFXX01BU0soYXcpIHwgVlREX1NMX0lHTl9DT00pKQ0KPj4+DQo+Pj4gKy8qIE1hc2tzIGZv
ciBQSU9UTEIgSW52YWxpZGF0ZSBEZXNjcmlwdG9yICovDQo+Pj4gKyNkZWZpbmUgVlREX0lOVl9E
RVNDX1BJT1RMQl9HwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICgzVUxMIDw8IDQpDQo+Pj4gKyNk
ZWZpbmUgVlREX0lOVl9ERVNDX1BJT1RMQl9BTExfSU5fUEFTSUTCoCAoMlVMTCA8PCA0KQ0KPj4+
ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUFNJX0lOX1BBU0lEwqAgKDNVTEwgPDwgNCkN
Cj4+PiArI2RlZmluZSBWVERfSU5WX0RFU0NfUElPVExCX0RJRCh2YWwpwqDCoMKgwqDCoCAoKCh2
YWwpID4+IDE2KSAmIA0KPj4+IFZURF9ET01BSU5fSURfTUFTSykNCj4+PiArI2RlZmluZSBWVERf
SU5WX0RFU0NfUElPVExCX1BBU0lEKHZhbCnCoMKgwqAgKCgodmFsKSA+PiAzMikgJiAweGZmZmZm
VUxMKQ0KPj4+ICsjZGVmaW5lIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUwwIDB4ZmZmMDAw
MDAwMDAwZjFjMFVMTA0KPj4gV2h5IGRpZCB0aGlzIHZhbHVlIGNoYW5nZSBzaW5jZSBsYXN0IHBv
c3Q/IFRoZSAndHlwZScgZmllbGQgc2hvdWxkDQo+PiBhbHdheXMgYmUgemVybyBpbiB0aGlzIGRl
c2MNCj4NCj4gWWVzLCB0eXBlWzY6NF0gYXJlIGFsbCB6ZXJvIGZvciBhbGwgZXhpc3RpbmcgaW52
YWxpZGF0aW9uIHR5cGUuIEJ1dCB0aGV5DQo+IGFyZSBub3QgcmVhbCByZXNlcnZlZCBiaXRzLg0K
Pg0KPiBTbyBJIHJlbW92ZWQgdGhlbSBmcm9tIFZURF9JTlZfREVTQ19QSU9UTEJfUlNWRF9WQUww
Lg0KT3RoZXIgbWFza3MgY29uc2lkZXIgdGhlc2UgemVyb2VzIGFzIHJlc2VydmVkLg0KSSB0aGlu
ayB3ZSBzaG91bGQgZG8gdGhlIHNhbWUuDQpGb3IgaW5zdGFuY2UsIGNvbnRleHQgY2FjaGUgaW52
YWxpZGF0aW9uIGlzIDogI2RlZmluZSANClZURF9JTlZfREVTQ19DQ19SU1ZEIDB4ZmZmYzAwMDAw
MDAwZmZjMFVMTA0KPg0KPiBUaGFua3MNCj4NCj4gWmhlbnpob25nDQo+DQo=

