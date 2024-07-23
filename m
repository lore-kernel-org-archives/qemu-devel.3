Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77164C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 07:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW9hE-0003iU-Mz; Tue, 23 Jul 2024 03:12:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sW9hC-0003Z2-AX
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:12:26 -0400
Received: from smarthost1.eviden.com ([80.78.11.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clement.mathieu--drif@eviden.com>)
 id 1sW9h8-0002DG-HW
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 03:12:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=eviden.com; i=@eviden.com; q=dns/txt; s=mail;
 t=1721718743; x=1753254743;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-id:content-transfer-encoding: mime-version;
 bh=YTArWp3Tuc/ng1nB7WwCbV/Cd+obXQJSDmSpZLbe7IU=;
 b=eNIexWWxCbxqDA6TfuY4/c9DeymBp8Sl2a5DPV+vG8XSlHOgss29OaaO
 cCdkR/RPRzg94srf1/MHvdP/9kF+uM3wh1lJRM8FxONZjuH/0jffxyB8t
 enYaTGPVUpWLdj7iJSqvpmSN64c0gpEq2UjoGC7SOSpEVBnGfelcpwvOz
 BdZaRlMQYJYKxFoZJuLhbjgZid1DVEVsJ/ZovkbbWcR8knfOzyq1B7Gxo
 LBQJKFm8T3HYOq8alGS6HydE65kjsnQFsWl8v+x2kKyhUDrrZUyQE5N/n
 yCZ38O9jXnAW2KwkZPIapFBwUsduK6eMvVHI8Vw7WdAdvMIh8xXwopyDF A==;
X-IronPort-AV: E=Sophos;i="6.09,230,1716242400"; d="scan'208";a="17003509"
X-MGA-submission: =?us-ascii?q?MDF1JEyYKKoE+jLeHyrslMqsBPHK0KdNuXdFOS?=
 =?us-ascii?q?FUTWKsJuvD8BKS/izOJ97if5TtcRJ15ZlHxDMJnAMNBOQ8YPZGQxNBPf?=
 =?us-ascii?q?KDQG7jrAhqp4/Z5dtZIPMEiIeN5sfsU0eZ9TQg9lttokYKU39ErZStIm?=
 =?us-ascii?q?PUgdMywAb2A1k2la8hF7WufQ=3D=3D?=
Received: from mail-am6eur05lp2106.outbound.protection.outlook.com (HELO
 EUR05-AM6-obe.outbound.protection.outlook.com) ([104.47.18.106])
 by smarthost1.eviden.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2024 09:12:19 +0200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLzauT+Rts6fJjNVmPo2hgGo2eOHWS7x3fw4PHsqZNG32Jb92rCPA8RIIO2QWYFxSPl8KcZRgzyeFC8+QRMAjuSygOmzAmp1Z9prLAV0wy1mRg5oEiZP32O0R0JQ/PUOp4YWBVmcN+JugOYWTjwOU02KX164Tvz0XjxxiRVj+lGNptWaTSDwDy56/m5XABEgnJBpOv5kpSm3i68vlNN6tGoRHHWiTwZX/yavp1Hnof2l4KO3RUrwHohfRADuo2OYuW0U8dz8/2Hqja501F/CGea6yrBf8yRL5DcZxUo+YVvwoZMBk84RVmkXzfcw1QNtPHuT73Ldg6BRHQIhUtpoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTArWp3Tuc/ng1nB7WwCbV/Cd+obXQJSDmSpZLbe7IU=;
 b=jONASElNd83BDcxdwdVu5EvtqKiTG6mrYzOOyOb1cpYueLPUXxiRS/iOkrRq4uwzgYeDmxQyZGc4WfYy1VOIY5EkHSvxLRQ5dkxlsY0F+F9Qeo6N9XPpeuxiJr/LQATKRtOetG/VgcJMeST/RZ316QTPLCrxx60q+foJBt5TQ+tOrrkKto+L/7wzoixQiccJHvwEap7Jm5YmbQaFtOiTBjCtJkGC9hNhp7f4xi3Z6eae2g3/lq0aXO+p/evJXsVZKWECu+NUN5wD9ffJSW4/VpXqCiOAt/L7oaS47cBPqEN5cxbFlkDg4OImGfUFDfAEfkhWlT7a+bX/0zqSGE5JSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eviden.com; dmarc=pass action=none header.from=eviden.com;
 dkim=pass header.d=eviden.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Eviden.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTArWp3Tuc/ng1nB7WwCbV/Cd+obXQJSDmSpZLbe7IU=;
 b=Ew86dSsBnRTUpftouuMlnYW8XhrdjT/aejojFRNNGP0lN612mtPqMtjxHK+qW9O+H1pHhRZvsrevXoAVuwyyZGgbWDrMNrjcjnCU96egkl+pcihkxfe2oX4WHoX/SFd/bPZZH4AAxjQwZ+fbIlYz6icVpeEExXCO/PGkXVTCnr4P7O7vb6ww5CQHRpZBJfGzCBGNXlz7Jli+U8eAIiw1AiZR4J3hMZbRPls07nIvYu3HMuUztcvjVFpkcbTn7gXctsgPsmhuoDQlQ9yyrlVY8/9/jxr6LYEGsaZB0u3l4yhyUYl6oXTttZy1cndbZ0hCt0XZGct5X/sc1pYtpccVYg==
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com (2603:10a6:20b:24b::7)
 by GV1PR07MB9168.eurprd07.prod.outlook.com (2603:10a6:150:81::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.7; Tue, 23 Jul
 2024 07:12:13 +0000
Received: from AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d]) by AM8PR07MB7602.eurprd07.prod.outlook.com
 ([fe80::fbd7:ca71:b636:6f9d%6]) with mapi id 15.20.7784.016; Tue, 23 Jul 2024
 07:12:13 +0000
From: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>, "chao.p.peng@intel.com"
 <chao.p.peng@intel.com>, Yu Zhang <yu.c.zhang@linux.intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>
Subject: Re: [PATCH v1 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
Thread-Topic: [PATCH v1 01/17] intel_iommu: Use the latest fault reasons
 defined by spec
Thread-Index: AQHa2Os0flq0/BTu/U2JwXlJJo503rID7WiA
Date: Tue, 23 Jul 2024 07:12:13 +0000
Message-ID: <aa2a1349-96c7-4723-8a84-1a459270ae04@eviden.com>
References: <20240718081636.879544-1-zhenzhong.duan@intel.com>
 <20240718081636.879544-2-zhenzhong.duan@intel.com>
In-Reply-To: <20240718081636.879544-2-zhenzhong.duan@intel.com>
Accept-Language: en-GB, fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eviden.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8PR07MB7602:EE_|GV1PR07MB9168:EE_
x-ms-office365-filtering-correlation-id: f6eed831-55ee-4b86-2d82-08dcaae6c707
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?S0o3U2IxZk51SWhsbnFSdjlmTGNET2FKRG9tNHcyNEJsdmhkWGxmMlFBZ2ZO?=
 =?utf-8?B?elk2VExZS1hRQU45TGplbTBGSlBkZjMxYmFueUllTWQ1dUNRNkU3eTdpYWRJ?=
 =?utf-8?B?NGhDTVB6RTVyS2llb1JYZmJkUFZzR00wSW1hRk9lL3VtbER2VCsyL0tQN1Zv?=
 =?utf-8?B?UnhmUU13bEROUXpYRU54VGVzd2U0OVpNYUMvTFNtNUlwYWYvYWVkN1FoZW5L?=
 =?utf-8?B?ZU9YN3BlbUJ2eks3aWM3UGxPNDNNQytDSlh6endwUFpqUmVFZVNBRkJIZlFy?=
 =?utf-8?B?ZVpWMU9ERzg3ZElVSjdWWm83dEdoVTBNNityVTdsKzI3QUZoMXRMazdMMFA4?=
 =?utf-8?B?TVhSNXlrVklWWHkxbWJ1bXIxM1g4YXcxWFpZNmZqTm8wbThOVG52VG90MndM?=
 =?utf-8?B?Z1RhL1NwN3FXTFYwWU8vMHdoNHdvVWI5azhrTEF1WWtzckNGTHZzbnNrVVdi?=
 =?utf-8?B?WGg3azBIRzFydXhwYkpRVitBcGN6aXFsL1NLcm5nQ3lhQWRLbTRiTXZzVFRR?=
 =?utf-8?B?UkY5M2JUa0duYTVmR3VtZlZsTWk5QWlNWm1lbjJLTEYzK2ZFMXViNFNsVWNt?=
 =?utf-8?B?clpwcU9oenBnRTZHZlBUaVJ5V1pXaTAzRi8wZFM1b2VrZHFXbWNMN0w3N2s3?=
 =?utf-8?B?bVVUdExRV29aRFkzQzFWemVLRXhycHdtS3I1M2hMeFBrSFV2N25DSkd6UFlM?=
 =?utf-8?B?RnVjVjZHNWxaOFVLblNSbDNVcFA5UEJ6WmphM0NrbThJUkNWRXhvMk41VDdZ?=
 =?utf-8?B?dGhNcGRuOHZxcm1nSVFzd1FxMmJ3V3drUjF3OTczVzNkOWVvMCttR2RGUXUv?=
 =?utf-8?B?NkJZeVJEQlJuRFY3MStnV1FCUmNvQWNjdFVoeDkxM3FUcWNmelFqSjVpanRY?=
 =?utf-8?B?eTJXbVRUdDRFS0VsRmJnaWNqeVJIc1ZhVDAvRCtDQW9XeSsySGZ2N3BGc3Nj?=
 =?utf-8?B?WUUwZTdubmF4QlFCVGtZaTNGTFltOHJwZ0MzcVZReUpnR1NOTUpkSWYyS1VC?=
 =?utf-8?B?ZENWSEFnWm1lRzAwbWs0L2RXMTFKZGgvNjUyWlB6VUdTMlQ2SThvMEJQQnlt?=
 =?utf-8?B?c2xMTUppQXpHKzNiVVRsakhhRi9sd2k3VHMzTlRBTmtleGRLMld2SXJGSG5s?=
 =?utf-8?B?WGtyMUV5QnZwdmNudWlFVTZFZnZZaktGSWVHaFZSVzg5N3hkV0lyaWRwQ3Zl?=
 =?utf-8?B?c1BiMldYTVVINGduck44eTRVTVR5NWhOb0crdmhSRnQ2SFRWdlhFQXhyQUVr?=
 =?utf-8?B?NmoxY1JvdlFTQU80bHNDZFVHdlMydHF1QjZIclV6WHplQ1VPZFhRVDljNkdU?=
 =?utf-8?B?WGpYVkNvRkthVVBoWDlqcGJHaUo1cVJKVWQrWWN3aFl2OXpwZk9PbkV3K3VY?=
 =?utf-8?B?Ujg4bVo3L1UxV1k4dGhpbnFndWVzMUFDcjhuQ0NVZlRIT3RxbzVvK1c2SFRu?=
 =?utf-8?B?VE5sT0h5T3ZwRUMyWWJaRFZXcDJNd050QUdDbG13L0JqU1FWUXg3NVpzbnpC?=
 =?utf-8?B?ZU1SbTd6ejJZaGxlZGc0QU8zMWJxWHd4Tjh4VHpDTmE1aEpnUjJpYTJYcmFH?=
 =?utf-8?B?K3Nzc0RlNS9tZjRzbDFEOHJuVmRnbUExYkM0aVZob0xiUWZScWI5N0NRVXY3?=
 =?utf-8?B?WkYwaUVLbTBKSGpFbU1rc1RjUHBycnlPOTlYOU1acjkxUXQ0dzNMVHRJemF6?=
 =?utf-8?B?bzk1RHZNUnl5QlpKbFFpMEVvSDdjRWlYNmFuWUNqa3IwUnIrZzBPQklKY3Zl?=
 =?utf-8?B?QnpmSExXTUdRbFJ1NTRMR2p1UEMvOU43NzJYWEw3M0pxcjdXeFU0WXVlZWNj?=
 =?utf-8?B?RWlndFl0YUduNkx6MFk0bE1makJORTZ4a3NlVGUyMG1mTTFDc1NLdzBHZnR2?=
 =?utf-8?B?NnR0b0hRNHpiQkZOZks3aUlscktSWEdKc2FaY3FwQ0d1NFE9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR07MB7602.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXR2NFBEZ3ptY004Mk15MkdHL0FwOFdTT0ozVjJpQTROSkluSzU3ZzJLMERr?=
 =?utf-8?B?a3BHTzU4a0QrN1ErZkFBdm5jZTkzV2FleTFWTUtYZnYraG9TSzRxQy92RjdI?=
 =?utf-8?B?Y3Q3RHNsZWpYSFRnV3MrZ3AyTzNqT3I0UHJmbENUTXpNcC9uN2wwTFBOMmcw?=
 =?utf-8?B?QkJaRHo0NWwvb1Jva29QUTZqWTUzSHV5NGVTVVF2bTJ0Q3A2N0QxZmxmczk3?=
 =?utf-8?B?cm5NdWlrbkFIU0dWRit4RnV2amRpREJrUkF1RE1lM1FSZTNqN1ZQTFhUT24r?=
 =?utf-8?B?UWhraXVFN0hYZlUrZzNQRm5kTHZtY1FpS1ZvVUJ2Z1ZDVnlQcXd2TFhXWEZH?=
 =?utf-8?B?aDNSS3QzYW5WbGZwS2svcEIrUUlaNzNlWU0wK0YrS2c0M1VGMitQbGJFRk1V?=
 =?utf-8?B?MFV6MCtpbmRzaWptemZBandOeEZ4YXkvbTRhTjdVazdTaE5WWUtNZW1DZkJ0?=
 =?utf-8?B?bFdsbU1zMnJ1NDQ3bmdIK3NoSXFHOVZnblZaakhrbHFKeCt3SnRpZThMbXJj?=
 =?utf-8?B?cjMxTlFnU2RVTldsRjhsWXVDQjd5ZFA2WkpMRTZoS1RrODV6SFYrVmJKaTFX?=
 =?utf-8?B?bHpzQ3dUeXBkMmtUOHdWU2N1NjNMU0MveTV1UXQ2YmNNMHUvNitSYUQya1R6?=
 =?utf-8?B?YThRd3ZYZm56SXhpalRoSFZwRTkxanJmS1ZraXNTeUswYWkzOTJna2pweUYr?=
 =?utf-8?B?OE1aOTk5ajFyVzBOQ2NXNjZlQVJOSFBoWVV3Z0hHMVRJb2tWTnNja0hJeDBW?=
 =?utf-8?B?WTNMUUh6Mi8wUTQ5Y09qenFEampyZU84UmdOUnJvUFNzcnl1cWg1djRSTkxp?=
 =?utf-8?B?Y0dxU0VjTnMvZ2ZnZHhQVHM2b2dCdEozVlNwMS9peS94dVBvVXkwa2FaYm12?=
 =?utf-8?B?VUdZV0lSUkZSZHc0Zy8xbEpVV0RVeFY0NlkxVXozNnhYaDlBak5zbWs5ME1a?=
 =?utf-8?B?OFBHZ1pMQlM4R1FKRzBKNDNQRWM4S3NZSXhKMDdOUWJaVWl5T1dmc3plYkU0?=
 =?utf-8?B?V210UHp1SG15dnN6MTFKTWtHcnNKc2gvMGV6WEFxMDJYZVZYVm56N2NRWWF4?=
 =?utf-8?B?VjNoVGNWVW5EMjNKTXdBMmMzK0RsaElUQ25HWlR6b3VWTTV5M1RPaXRaUC9a?=
 =?utf-8?B?N2phaU9KUDVoUno0d2xoRHYwZHdiTmxVZG0yTGIxeHRQQ3htbDFkdDNCb0d3?=
 =?utf-8?B?aDczT2RLemhvSEk3TGxxN25ic0F3ei9kRGd0enZrdG5GNlVnRGVZODhmMmFy?=
 =?utf-8?B?bnY2WDhOM2ZOb1VUa2o2VERzTyttTUNLR1UxdmRRL0QwS0hoUEVRRlE5VWhC?=
 =?utf-8?B?bDNaWVNXTjRHeHRrOXV1Y29NU0puOHBhUHJneUx6THNieXF4WUJSajlNUW1l?=
 =?utf-8?B?SFRNNjdkcFUxVWx0WUpnNTQxVkFoRjE3YWJ3aW9kZm9nT05lUkVyS1dNcDhv?=
 =?utf-8?B?bjdKUjBLSVF3NzkzVTQxSWptQktpRnVKaVBuc2Eyc2VMdU43WVlJUElqbTVk?=
 =?utf-8?B?SWpOT0N0b2pZaUxudnJXWWtLU2xjY0dVU09JeURUNHFCekNjRk5yS0RubEFq?=
 =?utf-8?B?MHY2dXJDcCtzcTBERGhUbkljdHc2dEk2eW1INnB2dXVPZC9GOHhNVGdEaER4?=
 =?utf-8?B?dTFmVERDZG1ZMXRuak5FSGcyV1JiaWYrUzdSclJDazZGbUdYZGFCazB6amVU?=
 =?utf-8?B?S1JPaDB0NUFqZ1Jnbjh2c0FTR2tmVkw4TmxyQkFaSXBpVXFGcnVTZlprc3NF?=
 =?utf-8?B?NW1ac3dPempXMkFUU3NWZnRUdit4a0JzRGR2MDFjZU5vdVZQVy9jZ2ovUE9h?=
 =?utf-8?B?ZHBkU2dOdGNIS0FmcDFhV1AxRkdRTGJ1WTV6Tm4wdE9ldDhDZkxXVXNLai95?=
 =?utf-8?B?aXNLSEI3cmoraTVvRGJ0UUVRVG5jMVlxemlicXQ1VXJySjZHazRXZWczdWNV?=
 =?utf-8?B?QVA2U29pSXNDN3lsY3hWRUZZTnJYb0NESnlzRnpKUUc0ZFQrcjBVYXRNNGJL?=
 =?utf-8?B?aE53Tk56dVk1Q3ZadzVySEJDalAyNi9XRWhmM2pwcVRmV0xsN2VCek5aZHln?=
 =?utf-8?B?aHVwRnJvaXZUVWdXKytaV1ErWjdHNlBHQllLcmxaejNIc3Zvc2VMZ21oOC90?=
 =?utf-8?B?MS8rUjdEOHpncHM4cW91TkVOTlJ4SERrUklsWm9XVFczeFpwR3A0bjVhNDNL?=
 =?utf-8?Q?A9Alk8ki3LkINqbKzh0OSg8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <17E12277A73EE7499D678C4945026E75@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: eviden.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR07MB7602.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6eed831-55ee-4b86-2d82-08dcaae6c707
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 07:12:13.7709 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7d1c7785-2d8a-437d-b842-1ed5d8fbe00a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DdL1X6Xe536VfAdfVKdgsd1+/0b0gK8U+DFgK3hE77N3lIZRACpl1lTdPzTwkOD5+Sd9RMb0DJs2tyzdsWT+h9n9YWPrweQO8NR/UNP/h/dY5lgfqo0VkpZ0uloTXjBw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB9168
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

UmV2aWV3ZWQtYnk6IENsw6ltZW50IE1hdGhpZXUtLURyaWY8Y2xlbWVudC5tYXRoaWV1LS1kcmlm
QGV2aWRlbi5jb20+DQoNCg0KT24gMTgvMDcvMjAyNCAxMDoxNiwgWmhlbnpob25nIER1YW4gd3Jv
dGU6DQo+IENhdXRpb246IEV4dGVybmFsIGVtYWlsLiBEbyBub3Qgb3BlbiBhdHRhY2htZW50cyBv
ciBjbGljayBsaW5rcywgdW5sZXNzIHRoaXMgZW1haWwgY29tZXMgZnJvbSBhIGtub3duIHNlbmRl
ciBhbmQgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4NCj4NCj4gRnJvbTogWXUgWmhh
bmcgPHl1LmMuemhhbmdAbGludXguaW50ZWwuY29tPg0KPg0KPiBTcGVjIHJldmlzaW9uIDMuMCBv
ciBhYm92ZSBkZWZpbmVzIG1vcmUgZGV0YWlsZWQgZmF1bHQgcmVhc29ucyBmb3INCj4gc2NhbGFi
bGUgbW9kZS4gU28gaW50cm9kdWNlIHRoZW0gaW50byBlbXVsYXRpb24gY29kZSwgc2VlIHNwZWMN
Cj4gc2VjdGlvbiA3LjEuMiBmb3IgZGV0YWlscy4NCj4NCj4gTm90ZSBzcGVjIHJldmlzaW9uIGhh
cyBubyByZWxhdGlvbiB3aXRoIFZFUlNJT04gcmVnaXN0ZXIsIEd1ZXN0DQo+IGtlcm5lbCBzaG91
bGQgbm90IHVzZSB0aGF0IHJlZ2lzdGVyIHRvIGp1ZGdlIHdoYXQgZmVhdHVyZXMgYXJlDQo+IHN1
cHBvcnRlZC4gSW5zdGVhZCBjYXAvZWNhcCBiaXRzIHNob3VsZCBiZSBjaGVja2VkLg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBZdSBaaGFuZyA8eXUuYy56aGFuZ0BsaW51eC5pbnRlbC5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IFpoZW56aG9uZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+
IC0tLQ0KPiAgIGh3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaCB8ICA5ICsrKysrKysrLQ0K
PiAgIGh3L2kzODYvaW50ZWxfaW9tbXUuYyAgICAgICAgICB8IDI1ICsrKysrKysrKysrKysrKyst
LS0tLS0tLS0NCj4gICAyIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMoKyksIDEwIGRlbGV0
aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5o
IGIvaHcvaTM4Ni9pbnRlbF9pb21tdV9pbnRlcm5hbC5oDQo+IGluZGV4IGY4Y2Y5OWJkZGYuLmMw
Y2E3YjM3MmYgMTAwNjQ0DQo+IC0tLSBhL2h3L2kzODYvaW50ZWxfaW9tbXVfaW50ZXJuYWwuaA0K
PiArKysgYi9ody9pMzg2L2ludGVsX2lvbW11X2ludGVybmFsLmgNCj4gQEAgLTMxMSw3ICszMTEs
MTQgQEAgdHlwZWRlZiBlbnVtIFZUREZhdWx0UmVhc29uIHsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgKiByZXF1ZXN0IHdoaWxlIGRpc2FibGVkICovDQo+ICAgICAgIFZU
RF9GUl9JUl9TSURfRVJSID0gMHgyNiwgICAvKiBJbnZhbGlkIFNvdXJjZS1JRCAqLw0KPg0KPiAt
ICAgIFZURF9GUl9QQVNJRF9UQUJMRV9JTlYgPSAweDU4LCAgLypJbnZhbGlkIFBBU0lEIHRhYmxl
IGVudHJ5ICovDQo+ICsgICAgLyogUEFTSUQgZGlyZWN0b3J5IGVudHJ5IGFjY2VzcyBmYWlsdXJl
ICovDQo+ICsgICAgVlREX0ZSX1BBU0lEX0RJUl9BQ0NFU1NfRVJSID0gMHg1MCwNCj4gKyAgICAv
KiBUaGUgUHJlc2VudChQKSBmaWVsZCBvZiBwYXNpZCBkaXJlY3RvcnkgZW50cnkgaXMgMCAqLw0K
PiArICAgIFZURF9GUl9QQVNJRF9ESVJfRU5UUllfUCA9IDB4NTEsDQo+ICsgICAgVlREX0ZSX1BB
U0lEX1RBQkxFX0FDQ0VTU19FUlIgPSAweDU4LCAvKiBQQVNJRCB0YWJsZSBlbnRyeSBhY2Nlc3Mg
ZmFpbHVyZSAqLw0KPiArICAgIC8qIFRoZSBQcmVzZW50KFApIGZpZWxkIG9mIHBhc2lkIHRhYmxl
IGVudHJ5IGlzIDAgKi8NCj4gKyAgICBWVERfRlJfUEFTSURfRU5UUllfUCA9IDB4NTksDQo+ICsg
ICAgVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOViA9IDB4NWIsICAvKkludmFsaWQgUEFTSUQg
dGFibGUgZW50cnkgKi8NCj4NCj4gICAgICAgLyogT3V0cHV0IGFkZHJlc3MgaW4gdGhlIGludGVy
cnVwdCBhZGRyZXNzIHJhbmdlIGZvciBzY2FsYWJsZSBtb2RlICovDQo+ICAgICAgIFZURF9GUl9T
TV9JTlRFUlJVUFRfQUREUiA9IDB4ODcsDQo+IGRpZmYgLS1naXQgYS9ody9pMzg2L2ludGVsX2lv
bW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gaW5kZXggMzdjMjFhMGFlYy4uZTY1ZjVi
MjlhNSAxMDA2NDQNCj4gLS0tIGEvaHcvaTM4Ni9pbnRlbF9pb21tdS5jDQo+ICsrKyBiL2h3L2kz
ODYvaW50ZWxfaW9tbXUuYw0KPiBAQCAtNzk2LDcgKzc5Niw3IEBAIHN0YXRpYyBpbnQgdnRkX2dl
dF9wZGlyZV9mcm9tX3BkaXJfdGFibGUoZG1hX2FkZHJfdCBwYXNpZF9kaXJfYmFzZSwNCj4gICAg
ICAgYWRkciA9IHBhc2lkX2Rpcl9iYXNlICsgaW5kZXggKiBlbnRyeV9zaXplOw0KPiAgICAgICBp
ZiAoZG1hX21lbW9yeV9yZWFkKCZhZGRyZXNzX3NwYWNlX21lbW9yeSwgYWRkciwNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICBwZGlyZSwgZW50cnlfc2l6ZSwgTUVNVFhBVFRSU19VTlNQRUNJ
RklFRCkpIHsNCj4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5WOw0KPiAr
ICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUjsNCj4gICAgICAgfQ0K
Pg0KPiAgICAgICBwZGlyZS0+dmFsID0gbGU2NF90b19jcHUocGRpcmUtPnZhbCk7DQo+IEBAIC04
MTQsNiArODE0LDcgQEAgc3RhdGljIGludCB2dGRfZ2V0X3BlX2luX3Bhc2lkX2xlYWZfdGFibGUo
SW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGRtYV9hZGRyX3QgYWRkciwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBWVERQQVNJREVudHJ5ICpwZSkNCj4gICB7DQo+ICsgICAgdWludDhf
dCBwZ3R0Ow0KPiAgICAgICB1aW50MzJfdCBpbmRleDsNCj4gICAgICAgZG1hX2FkZHJfdCBlbnRy
eV9zaXplOw0KPiAgICAgICBYODZJT01NVVN0YXRlICp4ODZfaW9tbXUgPSBYODZfSU9NTVVfREVW
SUNFKHMpOw0KPiBAQCAtODIzLDcgKzgyNCw3IEBAIHN0YXRpYyBpbnQgdnRkX2dldF9wZV9pbl9w
YXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywNCj4gICAgICAgYWRkciA9IGFkZHIg
KyBpbmRleCAqIGVudHJ5X3NpemU7DQo+ICAgICAgIGlmIChkbWFfbWVtb3J5X3JlYWQoJmFkZHJl
c3Nfc3BhY2VfbWVtb3J5LCBhZGRyLA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHBlLCBl
bnRyeV9zaXplLCBNRU1UWEFUVFJTX1VOU1BFQ0lGSUVEKSkgew0KPiAtICAgICAgICByZXR1cm4g
LVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lE
X1RBQkxFX0FDQ0VTU19FUlI7DQo+ICAgICAgIH0NCj4gICAgICAgZm9yIChzaXplX3QgaSA9IDA7
IGkgPCBBUlJBWV9TSVpFKHBlLT52YWwpOyBpKyspIHsNCj4gICAgICAgICAgIHBlLT52YWxbaV0g
PSBsZTY0X3RvX2NwdShwZS0+dmFsW2ldKTsNCj4gQEAgLTgzMSwxMSArODMyLDEzIEBAIHN0YXRp
YyBpbnQgdnRkX2dldF9wZV9pbl9wYXNpZF9sZWFmX3RhYmxlKEludGVsSU9NTVVTdGF0ZSAqcywN
Cj4NCj4gICAgICAgLyogRG8gdHJhbnNsYXRpb24gdHlwZSBjaGVjayAqLw0KPiAgICAgICBpZiAo
IXZ0ZF9wZV90eXBlX2NoZWNrKHg4Nl9pb21tdSwgcGUpKSB7DQo+IC0gICAgICAgIHJldHVybiAt
VlREX0ZSX1BBU0lEX1RBQkxFX0lOVjsNCj4gKyAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURf
VEFCTEVfRU5UUllfSU5WOw0KPiAgICAgICB9DQo+DQo+IC0gICAgaWYgKCF2dGRfaXNfbGV2ZWxf
c3VwcG9ydGVkKHMsIFZURF9QRV9HRVRfTEVWRUwocGUpKSkgew0KPiAtICAgICAgICByZXR1cm4g
LVZURF9GUl9QQVNJRF9UQUJMRV9JTlY7DQo+ICsgICAgcGd0dCA9IFZURF9QRV9HRVRfVFlQRShw
ZSk7DQo+ICsgICAgaWYgKHBndHQgPT0gVlREX1NNX1BBU0lEX0VOVFJZX1NMVCAmJg0KPiArICAg
ICAgICAhdnRkX2lzX2xldmVsX3N1cHBvcnRlZChzLCBWVERfUEVfR0VUX0xFVkVMKHBlKSkpIHsN
Cj4gKyAgICAgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0VOVFJZX0lOVjsNCj4g
ICAgICAgfQ0KPg0KPiAgICAgICByZXR1cm4gMDsNCj4gQEAgLTg3Niw3ICs4NzksNyBAQCBzdGF0
aWMgaW50IHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShJbnRlbElPTU1VU3RhdGUgKnMsDQo+
ICAgICAgIH0NCj4NCj4gICAgICAgaWYgKCF2dGRfcGRpcmVfcHJlc2VudCgmcGRpcmUpKSB7DQo+
IC0gICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX1RBQkxFX0lOVjsNCj4gKyAgICAgICAgcmV0
dXJuIC1WVERfRlJfUEFTSURfRElSX0VOVFJZX1A7DQo+ICAgICAgIH0NCj4NCj4gICAgICAgcmV0
ID0gdnRkX2dldF9wZV9mcm9tX3BkaXJlKHMsIHBhc2lkLCAmcGRpcmUsIHBlKTsNCj4gQEAgLTg4
NSw3ICs4ODgsNyBAQCBzdGF0aWMgaW50IHZ0ZF9nZXRfcGVfZnJvbV9wYXNpZF90YWJsZShJbnRl
bElPTU1VU3RhdGUgKnMsDQo+ICAgICAgIH0NCj4NCj4gICAgICAgaWYgKCF2dGRfcGVfcHJlc2Vu
dChwZSkpIHsNCj4gLSAgICAgICAgcmV0dXJuIC1WVERfRlJfUEFTSURfVEFCTEVfSU5WOw0KPiAr
ICAgICAgICByZXR1cm4gLVZURF9GUl9QQVNJRF9FTlRSWV9QOw0KPiAgICAgICB9DQo+DQo+ICAg
ICAgIHJldHVybiAwOw0KPiBAQCAtOTM4LDcgKzk0MSw3IEBAIHN0YXRpYyBpbnQgdnRkX2NlX2dl
dF9wYXNpZF9mcGQoSW50ZWxJT01NVVN0YXRlICpzLA0KPiAgICAgICB9DQo+DQo+ICAgICAgIGlm
ICghdnRkX3BkaXJlX3ByZXNlbnQoJnBkaXJlKSkgew0KPiAtICAgICAgICByZXR1cm4gLVZURF9G
Ul9QQVNJRF9UQUJMRV9JTlY7DQo+ICsgICAgICAgIHJldHVybiAtVlREX0ZSX1BBU0lEX0RJUl9F
TlRSWV9QOw0KPiAgICAgICB9DQo+DQo+ICAgICAgIC8qDQo+IEBAIC0xNzk1LDcgKzE3OTgsMTEg
QEAgc3RhdGljIGNvbnN0IGJvb2wgdnRkX3F1YWxpZmllZF9mYXVsdHNbXSA9IHsNCj4gICAgICAg
W1ZURF9GUl9ST09UX0VOVFJZX1JTVkRdID0gZmFsc2UsDQo+ICAgICAgIFtWVERfRlJfUEFHSU5H
X0VOVFJZX1JTVkRdID0gdHJ1ZSwNCj4gICAgICAgW1ZURF9GUl9DT05URVhUX0VOVFJZX1RUXSA9
IHRydWUsDQo+IC0gICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9JTlZdID0gZmFsc2UsDQo+ICsgICAg
W1ZURF9GUl9QQVNJRF9ESVJfQUNDRVNTX0VSUl0gPSBmYWxzZSwNCj4gKyAgICBbVlREX0ZSX1BB
U0lEX0RJUl9FTlRSWV9QXSA9IHRydWUsDQo+ICsgICAgW1ZURF9GUl9QQVNJRF9UQUJMRV9BQ0NF
U1NfRVJSXSA9IGZhbHNlLA0KPiArICAgIFtWVERfRlJfUEFTSURfRU5UUllfUF0gPSB0cnVlLA0K
PiArICAgIFtWVERfRlJfUEFTSURfVEFCTEVfRU5UUllfSU5WXSA9IHRydWUsDQo+ICAgICAgIFtW
VERfRlJfU01fSU5URVJSVVBUX0FERFJdID0gdHJ1ZSwNCj4gICAgICAgW1ZURF9GUl9NQVhdID0g
ZmFsc2UsDQo+ICAgfTsNCj4gLS0NCj4gMi4zNC4xDQo+DQo=

