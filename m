Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB70CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 11:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urE0X-00021V-Mn; Wed, 27 Aug 2025 07:08:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urE0U-0001zj-57
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:58 -0400
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urE0Q-0007H6-Ti
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 07:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756292875; x=1787828875;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7MjWe375ptDB/tRra82Sfcp7pGOFtyLrjgHFl+ioqSo=;
 b=HHU6cwbbwDj568XE0Ah63V1GuzsVeGiKqv2bUw5Jpjzjzp2irthOD4eP
 uWochfVVGO1uc+EYx7vQtHyFsUlC2WpkFPi/xrL1elHgM8W+7NTVhtaxu
 NOn47sYzAMFGfvM5v56QDTS4FTf4BabKkx71sN76AepjYQ0TATBujhTJo
 jHwWmYqPCXsPBrm7c1m7OdTVusjp7zSu+72xNP0PfS3vjyQNAfuU2uURn
 8DidVsM5E7dfOgp46Cm2WQmsgSXeBoxb+m0TR81e7W3sN/zdOthIk2+Vu
 wQIoLmwN9Q79HFFCRIV7kEYpD4RNgP9AhsewgL9zKrUxZrQeO5LKHH0xC A==;
X-CSE-ConnectionGUID: xCt65xlJTySKMPx1kWyWhA==
X-CSE-MsgGUID: TzUKLwZcS8ahgD7b9lJp3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="58692999"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="58692999"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:52 -0700
X-CSE-ConnectionGUID: XElkrjMBRXKRGXYShR/EQg==
X-CSE-MsgGUID: krPG+HUFSfKRHDro391BOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; d="scan'208";a="206985414"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2025 04:07:52 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:47 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 27 Aug 2025 04:07:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.48)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 27 Aug 2025 04:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=noPRMNNvGL+kx6B9uyt8B5k4LXFCWBCnre9Oo5Oa2UKkxVCF60KEfM7YeSJazvtUY089uUbyTeRT7GHUl4xVNSznctBA/FZDthZzFOg6xZLe+J/6mHVI7mr9eZ0Xmcj9Rj1q48JsDI3NbQircfpyZkHuKqR0Z2qeYG1tFvXhwjP6ucZ0QPG8JtohhhMpf7CkH8OiV57+I0MWGjHdJSRqdHi4G9nm9phijeze9vk8qEslMSntjiSzoLeV1qXLc2t9W4w2DR7cNDaJcHTrmBrzsbtCPxpVv2SR7g5YYk6JH9oHALJ13Oo/f0LBEBztP072ZSFboFhmlMJreIZW6ml4OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJpvbAZbB0oY0JJ2B0whAiExh+jw5vnuJNb42UtL8iQ=;
 b=ERn5HRQPPLZKUFI8qYx0Ccg2zAobWjgeaT8T7y8cZb6M6ngJFuXcCS7oxmf4nFAhr/rCpjxn15l++JbYAX+4bBwkXKE1XPc5eY8GLcQ/myqgCj9+PZX7pSOTn3YwdYi3uNiDqhoR7yD27FnQF5Z10QvWa6pW7IBX+HmEjcTBkcptTU3nlMnO/nbuFT18l03KItiFcM2ir2YwNnJAUuCxjv4hvTe3tMg9NzjWtwqwWdUcXXwGm96yy7InEAzB9WtEhUW8KRRcZ11OruhHDW1jDjcZPbluqR/Fe8fL2sWdh/U2so52vwpw86YyoBRTiHaq4puH2AjVuTi989rs6cRzJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 11:07:44 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 11:07:44 +0000
Message-ID: <05dac745-f612-4556-bd99-9de32ae63ccd@intel.com>
Date: Wed, 27 Aug 2025 19:14:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/21] intel_iommu: Introduce a new structure
 VTDHostIOMMUDevice
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:195::15) To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SA2PR11MB5082:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f9f6621-ca33-4884-a448-08dde559f24e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|42112799006|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkIvcitZa1hUWHYvZHJIZ1l6YVdzVW5veWJVdFdYOTZDZVFmNFJqRk9BQnFG?=
 =?utf-8?B?WkN4SnZ6bTRPWUoyQk5VWHBHOFdjdTBjN1JJVlpkZEExTklWZGZ2cEVUS2RQ?=
 =?utf-8?B?MnJ2dlE4b0JqWTZmUnhubEcvUE4xS0d4OU9xQWNyZ1VWbzNmRUJkZzNqZlVY?=
 =?utf-8?B?UjlpbnpDWm1mcmIvRTBaZlNMWFV5Q2VqN0pFSkFPTC9LeGFYVnljVVlDcmxp?=
 =?utf-8?B?eGt6THVUSkkzN2xuek1YUDNmZHRVc1V2bVBLcUxWZjFxR1QybXVuazl6NmtP?=
 =?utf-8?B?NUJxOEsyTXJGS0FGNkRJVlVMcnZyNFRqVkZxRGlITHJLVjFpUDVodkpha1Zr?=
 =?utf-8?B?TENKNkhXZ21LbUZpWWw3K0VhcFZzcjRHUG9jeWYwdDQ5L1N5RkEwRzZjVEk4?=
 =?utf-8?B?RE9EeUFMYzA5RTVKSTk4Qk1Qc1RuRHl6WkRQR2V1V0hQRGdRM0dNekdJeDRs?=
 =?utf-8?B?Z2UxZnk5c0o1b2QwR0RUWEFSc0pSVkx2SUV5VldZTHRpTWdibFlRMnhqQWZX?=
 =?utf-8?B?c290TXdDVVdpZE5VcE5CUXdMT1U0NzVxNU9MQ0dGQ0pBR0RmbWd1TmZMRk4v?=
 =?utf-8?B?WDRDYVdvWEtaNnVzeDZMc1NWWUlwN1Z5VjVRSTkvLzJET1k3cHlRTVpZSzRt?=
 =?utf-8?B?Z0hpaWcvZTNOMG8yUU1sUHFoTCtoS1RVRVNaaDlRWVV2OVYwV3k4c3ZFZzFB?=
 =?utf-8?B?d3o3TUNtSHlhVlVuVDB6Q1lwdVJwZk9QTENyRFpiS0pjeFYyaS9Qa2JVUDhy?=
 =?utf-8?B?VkNZdE9BS1MwdU1MeHNRMWF2dGxFMGxpcEFKcXBDK010TjRPeDc4a3dwdGMw?=
 =?utf-8?B?S3RiZGkrRjZ6bjVURW9SbkxrenZqa09nKzdoRThlbkh4d3orNGdOUmRUcE1k?=
 =?utf-8?B?ZWJpOUpjWVVITjRCQ0hibW5UVnJJUzJGV3FXWFM3N3RwWHhQamhWVjBvci9u?=
 =?utf-8?B?RnNycVdQSTlxNEVBNGNlY1JsaFY5OUw3R200d3FWdStqbUxFSldMeTlVUGsw?=
 =?utf-8?B?ZnlDS1V1dU5kd2FVWktZb2J5cEdpOGdERkxuNVd5VC9mcUpmbmxNd1ROKy95?=
 =?utf-8?B?Ui92SHJxMjdLR1E3YU1IS28rR0NuYnd2MUpZOEJJb1U3TThJdmwxSG15UHdN?=
 =?utf-8?B?SnljNDc0Nk5nV2VWbk5LTVZhaERudWdUZUVZS0gwVDVPLzl5OG5sU2c1aWJ6?=
 =?utf-8?B?QmFhUkRJZVc5WjRkdWJpVkhlRWdUem95ZWErRVRwQS8vZGY4MSt3VlpXYXVj?=
 =?utf-8?B?MXBac2FSKzZ3alhDNjlONEhTd0NTbTB4S2RQc0wxdEJLaVZEK1hubWF5bHNz?=
 =?utf-8?B?SUcwUjArQVoza3FjbXZGTDl5VU5NMFU1UStKUkZUZmljSlM1SkVJMm1wcUlR?=
 =?utf-8?B?ZzIwT2ZhZlh3ZURMOERGeE4xNU04MXJETENVR3V0OHlSaldFdkJmaXJVTWpR?=
 =?utf-8?B?Q0h1a2tEZWpkR1BYOW9qTGxJVHUxaUVYdG8wZytHdUo3YXVHNnBvWlpLaWRC?=
 =?utf-8?B?ZnpIVXV2Tk9iT2Mwc1ZzRmQwOTNDcFJZMXJqdUFzbEJhYk9HUWhsd0dwaW5n?=
 =?utf-8?B?ZlRub3RZT2VoYzVVUk5YZ2VaQ3NHN2JaeWxTYWNmMm8zN2lFcTVsUHJ0c2hk?=
 =?utf-8?B?a2hXODU3dGt4OTM4QzNWNzZmV1hSUU81TFhKaWlYcFNWL05wWm00MGpVRC9K?=
 =?utf-8?B?cVdmRHRhUU1ISVVmNGxZT2pXb1o1SHZ2V0tGYy9YZWIzclJDb3BGRzAyT3BK?=
 =?utf-8?B?Z2xQSXBxNkdEb3k1WmdqMGNBN2dGcFJTenVtN0hsSXFTUW5tWGtuRDg5SXNT?=
 =?utf-8?B?R2xMb2NoVTJnUWw3SGJWbHQ2UUJrZ2MzdExMdlB6Vnl2bWFITlhXNWF2Zi9k?=
 =?utf-8?B?Q1F0NHlUNWtDckhtSWhtOHIwemJ3S05XQTZrWkpibVF5ZXFaSTErUVg1QlRW?=
 =?utf-8?Q?uZnYOjLjNQU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEV1emdnTXBqMVA2ZzRyQ2ovRmFCTktHTy9McnJmWUowMmpOazhZcnlTYTc4?=
 =?utf-8?B?UXdpeWNwRFhMU0tsVko1Nm1sZzB0MDFPK0FnUUxMODVKY2h3NEFkeEFQQVg4?=
 =?utf-8?B?Y1dQS1BTelFyRk1aUVJzUGEzN3djQklTUUM3Y2ZhdS9xWjZKTXBCVVBTL3p3?=
 =?utf-8?B?QWJiVUJkM0ZaRHU1UW9YZm4xeTVSeC8wQmV0SUVsTUw3QTgrUVVDbXM3UDVH?=
 =?utf-8?B?UXpGOGVBdnROTmxsSkdudG81YjJvamN2VXdzM2p3Z2tFWDBtUVMvbXpzeGdv?=
 =?utf-8?B?YjFPa3FyLzVUNVlFaUNoRG5EMFkwbmxoUzNLb1RmaEh0cnVOK0JQUFoyTlJ6?=
 =?utf-8?B?b1VYQVNHd0hWSTkyK3RVQmtBRjMyOG9HaytjY3hCUVViKzdkeG9TOWZlSjdE?=
 =?utf-8?B?OE9rUGROU0VBWUlZWkFsODF1VXEzZXlQMzR3V2ZxWE9JTElLNmNSOUxhNE0y?=
 =?utf-8?B?R2JhUmNoTUJ4cy8wY0tUd0FOTVFNUWRpS2MwdG1XM3QrRnZHM2VQNldMV09E?=
 =?utf-8?B?MDdjeG1qUTdMc3dHT1g4d3pIZmZpZEgxbmtmSlFpNU1MUjd1NkJvWFdEZUZP?=
 =?utf-8?B?Z3A5cDFHN2hRWUMyZnJtL0JWVWVWZ0NWYzQ2Y09TN1RSRHgxQlZvU21EczZU?=
 =?utf-8?B?dDJYbkpDb3dzU1JBMVR3QXZ2VVFzeWdhYVNtUHNKZXNtMmtKbU5NZjZjcVB6?=
 =?utf-8?B?MWtLS1l0cjVWaWdvYkxZSXdmRFlZYlBiMHhVVHZmMmwxMVBhOEg5QlZSZWJD?=
 =?utf-8?B?VitZUEtVOERvdndXQkZtYlBLR3VHYTNBV1RiWGJIWE9TRDVYZ0xUVUlIRXR5?=
 =?utf-8?B?TGpvbWxoT21BNFR2VllEeDFJUm5nK3NGNEU1SVBXTlQyWGFpMVQxKzRhblcy?=
 =?utf-8?B?aFJYOXNRTHhSU0JnS1J6Z3c1TEUzYi9wY2EvZGw4cWZHOHJwcUpoVDJnN1Uy?=
 =?utf-8?B?cnpUdzIzSm13NUgyOU5hZ1hDS3h6QWxsL2VaQzZMZUpvMWhDcFlJR3M2aTdJ?=
 =?utf-8?B?RGdnQUNjKzZhS0JzdVkrS3dZZUNVSDFYMzNXZGdOa203eWREYkcwL0lMbmFu?=
 =?utf-8?B?RmJnaGtjQlVQVTBySGlmOUJyT3VMdEN1OHNLQ1lSbG1kVjF4c0VYcVZIeU5h?=
 =?utf-8?B?QUJsR0cxM0xWNi91ZHQvWkhtK1FRNkJxaEpHS3FZRk9WTnFINmN3M1psdnFO?=
 =?utf-8?B?dnpKMlNNMUxabmdHR3FYdzMvTnM1clA3M2M0eFJWbGlUMFN2V0Vrd1lLamdO?=
 =?utf-8?B?aTJ3bTd2ZWhWaXN1UExGM2FtcjhjbUgrSDNGNUpEVVQ0TjVxbzlNbmdmRndU?=
 =?utf-8?B?dThKd1p0ejJPVmtuMEc3RkJRWWhQcW9XUXB6UDBQVU5Xb2Qra25oQTJGckVy?=
 =?utf-8?B?Q0VHc3lveGpXV1lvS3U2eWVlRC8ycStuSmdzZ1U5czErNCtNNGpubWxmZWl3?=
 =?utf-8?B?anlIcHFrMzlVU3NKZ3hSMTJlR2VweUhXdEJLMkN2c3hja1ZTY2xtV2JpUVJj?=
 =?utf-8?B?c0c4Smw2ZW5yY0VERHU3Q2FnZ3hGZ0NSZVcwbHlEWFdVWm83OVFQOFBUMDBZ?=
 =?utf-8?B?ZTVLWnBydC9pQUpNWVdWMWFFNGRLNlc3V3FvS3BjU1c5aDIwYk9kNklXdHpj?=
 =?utf-8?B?UlFZbDMyeFh6Y2ZzMXBDb0VLSEV0cEd1b2JCa2h2d2ptU2lhRGlLNGpBUW1a?=
 =?utf-8?B?OUpHVXhKMCt1OTFUZVRtcUkvcFp5ZjR4a2dMZkFaSlZSM3pMS3BVUFJRb0RL?=
 =?utf-8?B?dVFvRjJEb09aVytIOXFMN1ZnaksrSFdLekRJangzdElCZWtYM1VoWStSMGFt?=
 =?utf-8?B?K3VzeU00cVh5N2pqRmNzNXZNeUJqeXI2WDZvQzBPTjUxSUNEQnJnaU9MWlJj?=
 =?utf-8?B?aXl4U2VHU28wUUg3VytQR1RDM0czNTcrelk0bTBZVUpZRUpxZ205TElGa0d0?=
 =?utf-8?B?S1dXMjVHM2wwUWRhZ1ZaUHFEbzVVeUJ1MzRacDhFaTRweWE0RHZRdjJWYVZp?=
 =?utf-8?B?NmZrVjg3eFhpOEcralE5eHNZV3FpbHBuY0xwU3NMcnFGcktISkZPbVMrTjhV?=
 =?utf-8?B?YmFEdU92U3dLTUVKL3JBVjVDWnVpMzV0WXVGTGEzNEdPKzFKS3JCZ0x6M0FR?=
 =?utf-8?Q?bmTI5T7pjaI3EGl6Xag2ANSby?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9f6621-ca33-4884-a448-08dde559f24e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 11:07:43.9289 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8AqElFQgQQ1r3Z1oeZscOgxweU1BcfGrv66a+l5DczUkp33818xgiuKYkKuc6npjsxEC2+DGba4MwL2wNyHTAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> Introduce a new structure VTDHostIOMMUDevice which replaces
> HostIOMMUDevice to be stored in hash table.
> 
> It includes a reference to HostIOMMUDevice and IntelIOMMUState,
> also includes BDF information which will be used in future
> patches.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/intel_iommu_internal.h |  7 +++++++
>   include/hw/i386/intel_iommu.h  |  2 +-
>   hw/i386/intel_iommu.c          | 15 +++++++++++++--
>   3 files changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 360e937989..c7046eb4e2 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -28,6 +28,7 @@
>   #ifndef HW_I386_INTEL_IOMMU_INTERNAL_H
>   #define HW_I386_INTEL_IOMMU_INTERNAL_H
>   #include "hw/i386/intel_iommu.h"
> +#include "system/host_iommu_device.h"
>   
>   /*
>    * Intel IOMMU register specification
> @@ -608,4 +609,10 @@ typedef struct VTDRootEntry VTDRootEntry;
>   /* Bits to decide the offset for each level */
>   #define VTD_LEVEL_BITS           9
>   
> +typedef struct VTDHostIOMMUDevice {
> +    IntelIOMMUState *iommu_state;
> +    PCIBus *bus;
> +    uint8_t devfn;
> +    HostIOMMUDevice *hiod;
> +} VTDHostIOMMUDevice;
>   #endif
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index e95477e855..50f9b27a45 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -295,7 +295,7 @@ struct IntelIOMMUState {
>       /* list of registered notifiers */
>       QLIST_HEAD(, VTDAddressSpace) vtd_as_with_notifiers;
>   
> -    GHashTable *vtd_host_iommu_dev;             /* HostIOMMUDevice */
> +    GHashTable *vtd_host_iommu_dev;             /* VTDHostIOMMUDevice */
>   
>       /* interrupt remapping */
>       bool intr_enabled;              /* Whether guest enabled IR */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index e3b871de70..512ca4fdc5 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -281,7 +281,10 @@ static gboolean vtd_hiod_equal(gconstpointer v1, gconstpointer v2)
>   
>   static void vtd_hiod_destroy(gpointer v)
>   {
> -    object_unref(v);
> +    VTDHostIOMMUDevice *vtd_hiod = v;
> +
> +    object_unref(vtd_hiod->hiod);
> +    g_free(vtd_hiod);
>   }
>   
>   static gboolean vtd_hash_remove_by_domain(gpointer key, gpointer value,
> @@ -4371,6 +4374,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>                                        HostIOMMUDevice *hiod, Error **errp)
>   {
>       IntelIOMMUState *s = opaque;
> +    VTDHostIOMMUDevice *vtd_hiod;
>       struct vtd_as_key key = {
>           .bus = bus,
>           .devfn = devfn,
> @@ -4387,7 +4391,14 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>           return false;
>       }
>   
> +    vtd_hiod = g_malloc0(sizeof(VTDHostIOMMUDevice));
> +    vtd_hiod->bus = bus;
> +    vtd_hiod->devfn = (uint8_t)devfn;
> +    vtd_hiod->iommu_state = s;
> +    vtd_hiod->hiod = hiod;

how about moving it after the below if branch? :)

>       if (!vtd_check_hiod(s, hiod, errp)) {
> +        g_free(vtd_hiod);
>           vtd_iommu_unlock(s);
>           return false;
>       }
> @@ -4397,7 +4408,7 @@ static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
>       new_key->devfn = devfn;
>   
>       object_ref(hiod);
> -    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, hiod);
> +    g_hash_table_insert(s->vtd_host_iommu_dev, new_key, vtd_hiod);
>   
>       vtd_iommu_unlock(s);
>   

LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

