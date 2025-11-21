Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6A3BCFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:49:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcho-0007jT-6c; Fri, 21 Nov 2025 20:46:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@siemens.com>)
 id 1vMbP5-00042U-6I
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:23:03 -0500
Received: from mail-norwayeastazon11013012.outbound.protection.outlook.com
 ([40.107.159.12] helo=OSPPR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <konrad.schwarz@siemens.com>)
 id 1vMbOs-0002Pp-UE
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:22:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlCTyCFbihsjrJBm6MGsAE0e5oU11it+q4PH6FHMpLea/26RA3afIa3bfTC4jlLpoCK4uYJ/DSbOdLk/UscrmyuUElqVVn0LEkQ1KO2jMlmsILmfQUUTB9hq3XYJGcwZoa8TRInrBgqSxmKZIXJbN5k9jW11waIbLu0KOTQOwAbJEB6AMEOJrprHGIMZWMYa5Jl0VZbJ8yduUSkwuA1yn2s3npskC6mGCmwlg7fCZSBhUBebI5mO47Fvf6SOpec93exJNYy5FrV0eSafVE3+XRqtNXAcke2Eze5FAynHmN0Jb5jKSVanv1nupusfKw0C8VXy2D/lrZVYAQJXVqC+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Y9YrI2SOnoHSOqq5v4gPde68jh5sFv1bf2Omp3nEhM=;
 b=jRzN/NIsjw0w6x2VgDPIdC56MK47uaMv3DN48XNGiEX4xxkgjH0TAzvaoZa6B/Hb2k2TgBklwEsfqDZXTd9rYU/EiHrx56zTVmdQh1/kNq5CQEq0TejSR45QBCRL5CKmaXY5t54jWXBiYYtxL5A0VyPMoc/x7gLDjjMKCyw9fmN5QYGn8REazmpVhZJGAU0Emb+1gpm4TPNw/eW/ZsnxzJEwCo6/at4RhBsfVyu1bIqXcwwb06/USvkvvdJQ6Igf6nHr61y9m17lk/6AqDpni0sy0LQOnu6w1PBq1gDdsIg47v90n+SujRE4/YZr1hXOnsluyepVvJx/PhA7ct7GRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Y9YrI2SOnoHSOqq5v4gPde68jh5sFv1bf2Omp3nEhM=;
 b=EAJANB2mcxOH7YDczoqlwfpjtjBgrUx4o+EWqdshB+XNUCpXQ20y6uR4/CPPIRc+OUjifpFY6EmpG9Ntklz7reDQjqi5iIuI35RY5/JTWZBoi3+kmuHK9I9hWNW0Hp5aCq3Cl9fQra9Ib8fnQJbvcYbmAI/DRuieNpgVGdIiCnqmDC4zRP0hsDtITWV8AdN+WCTu8kvCKAOiVmRDW7jm9C47IETxWQZtj/qwW3j9IvguZbWPRX6+t2E4IjBraw9usjAkCOcCcWQDT2vcKNDT+RKmqjmZQ79rQhAzbixdm8uN7928MS4E9RjE83CVicl5e4fDyPaLN72PZFfJIOx56w==
Received: from AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33c::13)
 by AS2PR10MB6541.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 13:32:56 +0000
Received: from AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::214b:9b1d:acac:e64b]) by AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::214b:9b1d:acac:e64b%4]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 13:32:56 +0000
From: "Schwarz, Konrad" <konrad.schwarz@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "konrad.schwarz@gmail.com"
 <konrad.schwarz@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "philmd@linaro.org" <philmd@linaro.org>
Subject: RE: [PATCH 1/1] scripts: Changed potential O(n) file size calculation
 to O(1)
Thread-Topic: [PATCH 1/1] scripts: Changed potential O(n) file size
 calculation to O(1)
Thread-Index: AQHcWXoCyaQlcz8AKEufgNoVu9G9F7T87MOAgAASFmA=
Date: Fri, 21 Nov 2025 13:32:55 +0000
Message-ID: <AS8PR10MB46806BA652BA28B4BED9884F8AD5A@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
References: <CA+kmUXafV4PPo2t+P23g9QRXHjaH_XBke3DjzbvciqBtw+i-OA@mail.gmail.com>
 <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
In-Reply-To: <dee22f22-c2e5-4154-99a7-525bfeb965af@siemens.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=1172b9cf-c399-4135-92db-258ba9750602;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-11-21T11:20:54Z;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB4680:EE_|AS2PR10MB6541:EE_
x-ms-office365-filtering-correlation-id: aa627fab-655a-49a1-5e38-08de29027acd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?eEZCaVRsMHNmU09rTC9pTSsxVmhtdktsZHVRMzliaU52OWlRWjY4QnRWVGkv?=
 =?utf-8?B?RjF4T09hUzlGSnFsNTF3ZHQ3VlluRDVOaTFQVkxzOVdSdGE2TVB0cTRpbGQ1?=
 =?utf-8?B?NDB2Mnd4RnhRTG1wdzNYdGt0Y3lkR2U4SFo0V3ZXcWhTZUpZbm5HUmZkS25h?=
 =?utf-8?B?ZGd6YVhJa1hCUGtYRVNSUDdOUVJaOHVaT25ma0YrVFFYR05mdEducDNURVpp?=
 =?utf-8?B?M2E0bWVnc2dLSlMvN1d4QkhRU0k0Y0tZcVh1RVh2bzFXcHpwNTJURGtmS0F1?=
 =?utf-8?B?dVRCbVFOUmFNZVpuelc4SEhkQnFMK0NGL21lS3g4VTBhKythRXFHSFAwTzgv?=
 =?utf-8?B?QWxGeDdiTGZuY0Z6clRXazVuZSs0OVRuUHhtWndHalVHcE9hS3RqdytxdEM0?=
 =?utf-8?B?WEtUd01JS0ZFZVpDMWh0UkNDaVZDVisrc0l4UURuUndLZFFOeGlqQlBQV0NB?=
 =?utf-8?B?NkZkWmZ1bk9rMjUwZ3BXc0xvbnhVeGxlcGp5bGVPYkhBTnR1UHZGQTdwVHJJ?=
 =?utf-8?B?M21ROXZCZDhVNmZ3NUFNZTFkTU1YQ05Ga0VzKzhoYmx5cWMxMklRVVBRSmJN?=
 =?utf-8?B?bzNseXdOUy82ZkFyVENFRmNCOFhodFpicVBoTDc0TEJxYm1jUnhZc0twMm5x?=
 =?utf-8?B?VUVlV1J4Q0VTMnhVNVQzZHdiVzJVb2ZldHdwdjU1TEJoVERUUHVtdERyd25p?=
 =?utf-8?B?TTNVbW5qdE1Rd3gvU3hBenpGeU9DWUdlSXFmb2p5djRXV3JhajlZNG9mbzlz?=
 =?utf-8?B?Ykw5K1p6M21EVktBdE9uelhwR0xRMjNaTklkWTZZZmNvSzZ6RWhIbWRqdXlm?=
 =?utf-8?B?L1V6RVhLK2dkVlIrb0dCMzh3WHFSTmVJYVRZcFRSeGhpMkxCbnpHZFlreTRJ?=
 =?utf-8?B?Ny9OOXFNTk01c0tsUlhKTUNBemdmMWYzMXo3bEpPdzZvZlNwU1hYVGxXZUZJ?=
 =?utf-8?B?V2U4alluNVpnNlFqT2VQcHBpRzNHZW9FaUs2cnFHZnVHMDNmejJmWGUwVlNt?=
 =?utf-8?B?dDBlL0djbWw4enlVT2J2TDJQcEc1UUNML25Dckh2RmtKTXhhV3VRODdDWUZv?=
 =?utf-8?B?ZkFGV3BpZDJySDJpQy9LRnZHQk5aaEJqcEF0QlRoVzMxSnVkYlFvejU3OHdw?=
 =?utf-8?B?clhZK2JzQmo4anpKSldtUVBpdTJNRmkzcEJ1UmZkNkhrbVZkeTM2SFFBV0VI?=
 =?utf-8?B?VitmQ2kwZ1hOV2hoZkZsU0twekZFWmRibDRlbUVJUVErZEo0SnA2eVJyMnRx?=
 =?utf-8?B?czlRTzErQnA0VHZ6NEVQOUdWWHVzQk5zMU1iMzlKdmFVLzBsZ1Q4eFVjTXY2?=
 =?utf-8?B?MVlSakxBSTVCQ21zUFFiWHdGU2FsZFZDM2VWeituR0VxMEkzcmIvczNXWWRG?=
 =?utf-8?B?dVNmY2NNZnBJZTdmY2l0WGk1MXo2RFJzVGlhbUdodXdURVJndXJOUng1Zklq?=
 =?utf-8?B?clJIa0l0NmVMcW5qMWUvYkM0bVZESjJKcE5KRGJjb29ZQUtoVGRTRVczRDhH?=
 =?utf-8?B?ZENoUiszSkZOTWYvY3NFWmNLQjBNcTZjc2RWQzJzcU9DTnJpNlhSQjZQRCtw?=
 =?utf-8?B?QXRuaHVJQUUwRWZWRXd6M01haGljVWJ2bXFtY0h4ekhvMW8ybkcwM044Ni9M?=
 =?utf-8?B?ZEcyb3A0cWJxMEM5bkRiZkZKVk1pZGE2em9HSE52WEdNOWg5VWpFUFA4eGtJ?=
 =?utf-8?B?emVySjhyZzRYR3E2Vm15aTJVZWRnVXd2WDM3VUZnMk9JSnN1N3d4MGdwdVBT?=
 =?utf-8?B?Lzh3SFg3WEhNUThHRHJXMDJWc01zODd6OTRLNjVPQXBZL3FsN2g5aDgvcVJF?=
 =?utf-8?B?L2ZIY1hGK0RDRlN5RDRxSks2SmhubkJ4OEQvSitEY3dnb2JOWEFUQjM0OXJI?=
 =?utf-8?B?cWtkYkJvZU5Ma1diN3RmRzlabGROS0o1U3A2ditTM29VQjVzaHN0ZzVmV1Er?=
 =?utf-8?B?TCtwMkcvRFFNbWY0T0gwc3VnVGZ4d1R2eE1pbTNjRlZtcS9HdjNpcDUwOTU4?=
 =?utf-8?B?bXZFT2VVT1dBM0JjdkVpZmhiaTZnZ2g1TXI5d1g5ZG5STnpySk9jN1M4K1Fn?=
 =?utf-8?Q?o98dim?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NG5EeFd2dFRyS0NWWmErdmp4RFlqaC9VWDJnYzhVdVpmd3BXWG5FaE5JSk5D?=
 =?utf-8?B?cVNVZ2tlRmZEUkI0TmY1dTdBemwxVCswamtVTlRIVDZ1aTlrWVV4NThDRXVK?=
 =?utf-8?B?NjRGMTE2SWVOUURiV2EzaWJoZ2M2RWNpS2t5b2Ezd2lSN280S2xKakpZanRO?=
 =?utf-8?B?K0IvQ3dNcmhzbU9tOVNiZkNoOXBpc25LN2RSb2lPOW5vRlB2d0h0aTBzTGs2?=
 =?utf-8?B?a2JlWnNnNlZCbWtNVXBWQ2hyc25MWWpVMXdYVHcwYXNKdHo2NHZjamJWVFJS?=
 =?utf-8?B?N0RjZU9FVmFOTS93RzVPb3VDbFRWK1hSMFBpM3dTNzBRSE9iV1F3OUdrYllr?=
 =?utf-8?B?YWl6eGRlSFJCSUYxNi8xelA0eHRWaEU4cmFLVFhIVUgvR3JCaEQ3THBpTXVu?=
 =?utf-8?B?d0ZnQXIxYktIdTIxaDBZczFzaENoOHlpeWl6eFFJWGZ0SS9Pc0VuZTh0VHpP?=
 =?utf-8?B?VS84TWhuTTlpUWZvYkExQ2hrTmZWRnV5cFdwMWJaRmZzdUd6M0JveUFuTm1i?=
 =?utf-8?B?ZGN2b0Y4ek93WFhrMVNDRXJPdVNvL21SY1VZczBQbkpyU1VrU3J4L0RUZnZX?=
 =?utf-8?B?cGxzZjVGTGpBVFpYR2ZEVzR5S2dNdnBZV0JPRnprVHQ5OTl4OW9BOGhXUVBw?=
 =?utf-8?B?dWpQUWMxQlo0Zm5vVUdtQ2ErTlZ6RzJPNzB6NmNOM3VqSVRwVVJ4dU93M3RM?=
 =?utf-8?B?QXB6a0dmY2tWNXRMcDhhVWFhNzlGWCs4V3lQYWNYNW9Oc0NDaFJzakdIVWRx?=
 =?utf-8?B?NkFNVnFSSVNpb2E5SGxtbDVHR2F5UTdnT2RuTTZNaldkYlpqUjFjQjU5MFh2?=
 =?utf-8?B?V0dkSlgyU2hwR2RqYlArbUtxNGpYblFGQXd2TXZ3UXg5TnBwdklMWmNwUTJX?=
 =?utf-8?B?WC9ZMWJPWm00NTM0c0lEMjFOSXRPYTdZKzh4cC9CMmg2ZmJ0Y2JiRUR6U3NV?=
 =?utf-8?B?TXcxN3RMVWI0QkJSekJiQ1UycFpMTUd3QlJTK0FVWFpZaGhoVDlmekNRR3J2?=
 =?utf-8?B?Y0lNeUNnV2FONzNtRmFBMFJ2OHBvUVgxTHA3OTNOSlBaZjdwODJjaVIzNytZ?=
 =?utf-8?B?czhzRnF3aGlPMzh1dmYzNE5xdkFtSGdXUlgxZU9jeDNxL0kxUjkrNkdqV084?=
 =?utf-8?B?S1crekxRSGh4NU5KVEt4bnRRQ0d1eFhyYmk4cHRqRk80cGdiNU1jcEdUK203?=
 =?utf-8?B?eERCTGRnTEoyeVV0bnNDQnhDRUIzV1didVd3YlZwdFRtY3ZaT1RsTDVzVjYy?=
 =?utf-8?B?RmN1ZHRkN1gvc3dyY2J2T0wrWVJqTTlmSERBa2xoL0twZXZxYzMrWExWSDVv?=
 =?utf-8?B?d3dDanFrb3M2RGR5WlVGcDV2RFRYdVdibGhsUkJrd2s2ci9NS1ZxYTBTRnl6?=
 =?utf-8?B?czBGdkkzejZpOVpwU0RrZktJNytTM0FmWWhVWi9kczBMMHhnNDR2WlNlLzND?=
 =?utf-8?B?MzE1anp0Z1F2YlZQMXk5elNPV3BReHF3NDdIWGc4WTV1ZmFXZU1uUFpFcVpo?=
 =?utf-8?B?eWVlelYrSmMvcUNkNHpYdkRFRy9DcDNHT0w1SVZPcDVoNUQzMkNycHAzSlhW?=
 =?utf-8?B?Wmg3d1BkYVluTHE1ZFlqc2QzNjRUYmZ6VTdXYzNoVkJTU3dpZXgvSEx2UDFV?=
 =?utf-8?B?bFJ3NXZTOWtCOTl3WlBtMTJzOS9ZOG1NK3JLcSs4MVVkKzZmeVJxQ1MwTFN6?=
 =?utf-8?B?WWI1K2F1ZVRORmM5SmNWbVhjUTdNaGVNd1JOZUZuWTMvMVdtK3Erc0V2SXlM?=
 =?utf-8?B?OE1hUklVdnA4enFTVEtaUVNMOU93YjFpOEhQdXA1VXRUMS8yWkZFczgvRU5V?=
 =?utf-8?B?S1BIQkhjakdSVUV4akQxbytNNmZDV2IwUDJsSnJzbENWTzVSakFFRXJzQkJ3?=
 =?utf-8?B?RjN4TFVCbmk4L1VKUVJDYUd3VHBUWm43RTlydTN2bmEwQUFsb2ZqVlVhbGJP?=
 =?utf-8?B?bDBRQkRESzFXSnJSQXhTN0djQ3JVcWR4LzBMQnBuS3c2Q2YrSVUzOGxrUlYv?=
 =?utf-8?B?MGtWdmI0K1lGTjliQWlzUlVSQWhvQlRhc2NTYm50UHhwRVAxdGRqYXEwUWtD?=
 =?utf-8?B?U0s5cXZBajFtalhFYmZQNzdJSjVXb1Q5WlBVTmpQbVhJb0FFQnpGMVcxOXpR?=
 =?utf-8?B?czVyREdZcWtleWRjeHVnc1pGZWRwQzlJbVovc1RrREhkUTJxY0pHZVhJZVVJ?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: aa627fab-655a-49a1-5e38-08de29027acd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 13:32:55.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Byqc8cZXiclaIRcuiYbjgrvgvgah5og/m5wxcIwPTPGh8RJZ1bWIKLAHpMMs7znrgoNu/Wpsw1x365pIuLLHQk280Wt7+SjCnABigH/oEQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6541
Received-SPF: pass client-ip=40.107.159.12;
 envelope-from=konrad.schwarz@siemens.com;
 helo=OSPPR02CU001.outbound.protection.outlook.com
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

PiBGcm9tOiBLaXN6a2EsIEphbiAoRlQgUlBEIENFRCkgPGphbi5raXN6a2FAc2llbWVucy5jb20+
DQo+IFNlbnQ6IEZyaWRheSwgTm92ZW1iZXIgMjEsIDIwMjUgMTE6MTYNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCAxLzFdIHNjcmlwdHM6IENoYW5nZWQgcG90ZW50aWFsIE8obikgZmlsZSBzaXplIGNh
bGN1bGF0aW9uIHRvDQo+IE8oMSkNCj4gIA0KPiA+ICBzY3JpcHRzL21rZW1tYy5zaCB8IDEwICsr
KysrKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9zY3JpcHRzL21rZW1tYy5zaCBiL3NjcmlwdHMv
bWtlbW1jLnNoIGluZGV4DQo+ID4gNDVkYzNmMDhmYS4uZDJjNGU4NGIxNiAxMDA3NTUNCj4gPiAt
LS0gYS9zY3JpcHRzL21rZW1tYy5zaA0KPiA+ICsrKyBiL3NjcmlwdHMvbWtlbW1jLnNoDQo+ID4g
QEAgLTM3LDEzICszNywxOSBAQCB1c2FnZSgpIHsNCj4gPiAgICAgIGV4aXQgIiQxIg0KPiA+ICB9
DQo+ID4NCj4gPiArZmlsZV9zaXplKCkgew0KPiA+ICsJbHNfbGluZT0kKGxzIC1IZG9nICIkMSIp
IHx8IHJldHVybg0KPiANCj4gVGhpcyB3aWxsIG5vdCBzdXBwcmVzcyB0aGUgZXJyb3IgbWVzc2Fn
ZSB3aGVuIGEgZmlsZSBkb2VzIG5vdCBleGlzdCBvciBpcyBub3QNCj4gYWNjZXNzaWJsZSwgc286
DQo+IA0KPiBsc19saW5lPSQobHMgLUhkb2cgIiQxIiAyPi9kZXYvbnVsbCkgfHwgcmV0dXJuDQoN
Ck15IHRha2Ugb24gdGhpcyBpczoNCg0KYGxzJyBpcyBhYmxlIHRvIHByb2R1Y2UgaW5mb3JtYXRp
dmUgZGlhZ25vc3RpYyBtZXNzYWdlcyBhcyBpdCBoYXMNCmFjY2VzcyB0byBgZXJybm8nLiBUaGUg
YWRkaXRpb25hbCBpbmZvcm1hdGlvbiwgZS5nLiwgd2hldGhlciBhbiAnRUFDQ0VTJywNCmFuIGBF
Tk9FTlQnIG9yIGFuIGBFTk9URElSJyBlcnJvciBoYXMgb2NjdXJyZWQsIHNob3VsZCBpbiB0aGUg
bWFqb3JpdHkNCm9mIGNhc2VzIGhlbHAgdGhlIHVzZXIgaW4gZml4aW5nIHRoZSB1bmRlcmx5aW5n
IHByb2JsZW0uIEkgdGhpbmsgaXQgd291bGQgYmUNCmNvdW50ZXItcHJvZHVjdGl2ZSB0byBzdXBw
cmVzcyB0aGlzLg0KDQooSW4gZmFjdCwgb25lIGNvdWxkIGdvIGZ1cnRoZXIgYW5kIGNvbnNpZGVy
IHVzaW5nIG9ubHkgdGhlIGVycm9yIG1lc3NhZ2UNCm9mIGBscycgYW5kIG5vdCBwcm92aWRlIGFu
IG93biBlcnJvciBtZXNzYWdlIGF0IGFsbC4NCkluIHRoaXMgY2FzZSwgaXQgd291bGQgYmUgZXNw
ZWNpYWxseSBlYXN5IHRvIHJldHVybiBgbHMnIHN0YXR1cyBiYWNrIHRvIA0KdGhlIHNjcmlwdCdz
IGludm9rZXIsIGJ5IHNpbXBseSBpbnZva2luZyBgZXhpdCcgd2l0aG91dCBhbiBhcmd1bWVudC4p
DQoNCj4gDQo+ID4gKwlwcmludGYgJXNcXG4gIiRsc19saW5lIiB8IGN1dCAtZFwgIC1mMw0KPiA+
ICsJdW5zZXQgbHNfbGluZQ0KPiA+ICt9DQo+ID4gKw0KPiA+ICBwcm9jZXNzX3NpemUoKSB7DQo+
ID4gICAgICBuYW1lPSQxDQo+ID4gICAgICBpbWFnZV9maWxlPSQyDQo+ID4gICAgICBhbGlnbm1l
bnQ9JDMNCj4gPiAgICAgIGltYWdlX2FyZz0kNA0KPiA+ICAgICAgaWYgWyAiJHtpbWFnZV9hcmcj
Kjp9IiA9ICIkaW1hZ2VfYXJnIiAgXTsgdGhlbg0KPiA+IC0gICAgICAgIGlmICEgc2l6ZT0kKHdj
IC1jIDwgIiRpbWFnZV9maWxlIiAyPi9kZXYvbnVsbCk7IHRoZW4NCj4gPiArICAgICAgICBpZiAh
IHNpemU9JChmaWxlX3NpemUgIiRpbWFnZV9maWxlIik7IHRoZW4NCj4gPiAgICAgICAgICAgICAg
ZWNobyAiTWlzc2luZyAkbmFtZSBpbWFnZSAnJGltYWdlX2ZpbGUnLiIgPiYyDQo+ID4gICAgICAg
ICAgICAgIGV4aXQgMQ0KPiA+ICAgICAgICAgIGZpDQo+ID4gQEAgLTEwNSw3ICsxMTEsNyBAQCBj
aGVja190cnVuY2F0aW9uKCkgew0KPiA+ICAgICAgaWYgWyAiJGltYWdlX2ZpbGUiID0gIi9kZXYv
emVybyIgXTsgdGhlbg0KPiA+ICAgICAgICAgIHJldHVybg0KPiA+ICAgICAgZmkNCj4gPiAtICAg
IGlmICEgYWN0dWFsX3NpemU9JCh3YyAtYyA8ICIkaW1hZ2VfZmlsZSIgMj4vZGV2L251bGwpOyB0
aGVuDQo+ID4gKyAgICBpZiAhIGFjdHVhbF9zaXplPSQoZmlsZV9zaXplICIkaW1hZ2VfZmlsZSIp
OyB0aGVuDQo+ID4gICAgICAgICAgZWNobyAiTWlzc2luZyBpbWFnZSAnJGltYWdlX2ZpbGUnLiIg
PiYyDQo+ID4gICAgICAgICAgZXhpdCAxDQo+ID4gICAgICBmaQ0KPiANCj4gVGhhbmtzLA0KPiBK
YW4NCj4gDQo+IC0tDQo+IFNpZW1lbnMgQUcsIEZvdW5kYXRpb25hbCBUZWNobm9sb2dpZXMNCj4g
TGludXggRXhwZXJ0IENlbnRlcg0K

