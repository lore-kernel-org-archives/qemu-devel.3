Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C95C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 08:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urXsH-0006Yg-Vw; Thu, 28 Aug 2025 04:20:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urXsG-0006Xl-43
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:20:48 -0400
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urXsC-0005Ng-Qh
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 04:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756369245; x=1787905245;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=H0GY+1ip1IbxxmEwm8xzg3wD49M+z0+r3AuBrq7XqIc=;
 b=e2J7ZD7pQ+c79WTHw8VpzC6h6bRFq/6yfwz52aTNdLafoIPDcwc4EM5E
 W+v2Xgb8HOuWeAw7zp83J2ti6viyHtuBFe7/blbfR3qDQB1A7E4qyUW0l
 6yRBw3D11Fy0tOB7Pjx8g0GZFWGHUmuyyuh0qgGocOf78+EnJupIpK+QU
 nVQbBOVQaoGpyH4R0QCokzfbMQntGKoYni5r4eqgMcbd0t0gWovxantWy
 /ZlimIIihT2EhvBARev4jIfSgtu91v5/2AUUJPyX75Q7aNTLXBXaws9Zz
 dAFkpzwtQMhWr03dATn0KcsLSwfb7F+M5BjgrQslEPaTDa19LY4Gibc4T Q==;
X-CSE-ConnectionGUID: FGTy9x7LQxOBmd+eHMh6fg==
X-CSE-MsgGUID: hoZbQpORSeOEEN1y4OXMTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81224260"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="81224260"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 01:20:41 -0700
X-CSE-ConnectionGUID: IW3eP5DHQeyX755Zb6RDTQ==
X-CSE-MsgGUID: Okerye8LSJG+DmN8TwmR0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="175345476"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 01:20:41 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:20:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 01:20:40 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.52) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 01:20:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXiCb+F++gplPczPAw3pHd+RdwaP2XSce5Z8SJqnzKq6+qnxdEmtR7nj5G5mc99MKEs7WTrNxfeIHsfgw5wow9xK34/diPiDxbP/EVDfvo8pVawOZULZEMLN0v0Rnhjaf664HVp656O+SeXQsTO+sviTFw2eXfim2cMKpxscLoFJPIC6z8A4dyB6H/psxwPJ/Tvq8xeAoog4OziVQhLZdgi8A4vqYvKCcSasxKMY1hQXEQQrwYZ4FnI7GZOxdqd86dBOU3ccrUQi/f5srmqP1q7Fw0iHDJqp7rorQxFpBXFQS4E5pDwdAxpwxtzvBBbebuZrHqrd8NwhTzaZEMrXeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyoxT2ru3af5ZRmVlQiSwpied/yjzOtXN57lZ1EQbDg=;
 b=Tk7iw80xFODPAO4R07VyuFZus7VKjEDmZGkq44ui0bStFCk7pgsZBVrRAXudH45+B5zB2CiGQQs6r26C/CwuxZKfn1VmWlcxYY4leVPtAgWVqxi4n8H1g61RAcccSlhB0Q4WywXCWAe16dCnpHrA0mfSJIIRfmw2W8KzU+1jUg/N6oTl2b7qvo5ubNj9SzkAQVbDdTTEYmN24OprdyUs4Zic2sSwMqOrbiEXGF9lekNtWsjGK/BE/vA1ZRHN6Jt4KOKSu9sq10Jva/5jXlGi0Mo2pHRV1OQa9t0uFcs8lo4Y/A2T8YlL+PdHKfqH+yyqJAfDX+770bJRHpbvhASTRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by BY1PR11MB8053.namprd11.prod.outlook.com (2603:10b6:a03:525::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 08:20:29 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 08:20:29 +0000
Message-ID: <ecd95fc6-ce8f-484e-b685-d78a382f1705@intel.com>
Date: Thu, 28 Aug 2025 16:26:59 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/21] hw/pci: Introduce pci_device_get_viommu_cap()
To: Nicolin Chen <nicolinc@nvidia.com>, Eric Auger <eric.auger@redhat.com>
CC: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>,
 <alex.williamson@redhat.com>, <clg@redhat.com>, <mst@redhat.com>,
 <jasowang@redhat.com>, <peterx@redhat.com>, <ddutile@redhat.com>,
 <jgg@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-3-zhenzhong.duan@intel.com>
 <32c0a5e1-6529-4978-a0e1-32940e806dc0@intel.com>
 <e6300798-19a6-417b-902f-57fa7ae20355@redhat.com>
 <1ee98764-d57f-4ff9-9018-f07d8ee5d68d@intel.com>
 <153e1475-6678-415c-86bf-b7251cb59f3f@redhat.com>
 <aK8kqQOV28V36wtM@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <aK8kqQOV28V36wtM@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0020.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::7)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|BY1PR11MB8053:EE_
X-MS-Office365-Filtering-Correlation-Id: 28618236-da34-4d7d-dfdf-08dde60bbf83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|42112799006|7416014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RW9tTWQrcFFWTGk5VWFkUk45TjNxelpXM2hiWGRObDBkZVAzRzhNZEFmZ2JD?=
 =?utf-8?B?ekpMNWUyUDVDL2Rybk1zV0lmVWoxcWp4bWRFR2V3cXczellML2svYk9hU1B4?=
 =?utf-8?B?SHV4ZUh5QWh6YnhxUzRKZFh2MkltUUVMUVpXVlhTVThVYndGaDc2bmtZSnJP?=
 =?utf-8?B?OWJDa1RDekExUzVtLy9CUTBIRXFBZ1NqZzg5bm9NSnBlZ2ZtQ2JPTFhQM2JV?=
 =?utf-8?B?dElob04yOUJFTFIwZ0lHdFRZb2FhbDVudjNzZmNHakg1dnBpbjRYUER2aXZF?=
 =?utf-8?B?czl2OHdTWHpPbzZEdUovOU9Xb1ZGZUZSMDVQMUtlVkNmWHlrUEZnTE5JT0JV?=
 =?utf-8?B?VTNyRFM2b0ZZMGdYZHpPaDd6UWpnT3BCbUwvOStMVFQxL3ZEV2NzZ3FSUFQ0?=
 =?utf-8?B?Zi9oUlUybEpqMFlRalFHbm1SOTNZUysvSkhhMi9RSmM4NExPZWFlajY4dzdQ?=
 =?utf-8?B?bVZ5TE9hcTZJZ1RhaVFIQzNQbUFiZFljSlh5ai8wVlNuWlMxY1FUb09JZi9y?=
 =?utf-8?B?ZUNGa3gxamk5dUh5bG1mVXNSUStEUHlOend3eVhlaDUzbkZxUlM5ZDdEZGpR?=
 =?utf-8?B?MHo5dFJzYmRPSXFWbFJEa0Nrdk1xU1JhM3FobmNLZW0rMEFNRW5TTjY4MWU3?=
 =?utf-8?B?MjJmK0p5eEU3RnN5RERrOWdIL3F6TDdQRnExam5uVTBrR01rRlFOdTBScXor?=
 =?utf-8?B?OXhDYkx1cDBoTHVGcnd1YzdmQ1ZGTXVzZjY5MlNnU3AvZmZUNS9qVkdQdU90?=
 =?utf-8?B?L0RVV2tCUm8zOW5KN0puL3hnOEpBNmc2c2paUVFITCs5N2M5YXpBcTBZeFp1?=
 =?utf-8?B?NzRzM0RQWVpJbm9FZ2xZWjkzdnp2emFlOVBFNUV3czdhSjBFbEJKdStHV3Ns?=
 =?utf-8?B?STZFVzF2eVNXTzVaYXMxbzNLeEswTUlnMDBlS21sTWdmOFFFd3pXNzRCT0dL?=
 =?utf-8?B?ZitYZFFORS9sYnZqM3lWTFZNS292bEpGK3pGNHMvODNmMkp0QnRPeHU0blhX?=
 =?utf-8?B?TGgxY0I0ME9oTjlWNkFaVGR3NExTQmVHUE13anRsakRKbDZpcEVLTjFjczJB?=
 =?utf-8?B?bFZrWWE3a1lsWVlYbU9JZFpKNGxhdXF1Zko4S2NCdnRIa0VRVjNyVkhJZU9S?=
 =?utf-8?B?VjdVbWlGNFF0RE9ucW42T2tSVFRPc0R2UG82YzFvd3JyMjZCZUR1Vk0rVzFJ?=
 =?utf-8?B?b2wwWVIvQnk0Q2pCTWN5Z0d0dFFVR3hPUFJ1ZTVpa0Rnb0JmRVV2QnNCYjJy?=
 =?utf-8?B?OElQc3J0ME1pYkZwR1p4TFkyYi9pZEc4RStxYjEraFMvZEtBYUR0K2psaTla?=
 =?utf-8?B?d01xUlJJZEt0Mzk0U3lSanZyVnZlMnhJUnUwRFVDWHpRV1VROUp0WUZ6OFRO?=
 =?utf-8?B?VUxqdWFYcmI1YkVYRDNnSkptOGd5bDUrQmtBV2cwODFmSy9KTHBHUGdZK2Rx?=
 =?utf-8?B?QUoyTmxmdDhOTzJtQ1RPQ1BKSDR5ekFWa3dmVDN6WU13dm56YW5jbE9hVm1y?=
 =?utf-8?B?OGhOc2kyelZXc1hNTGQvWlhwZmQrN3VUZlpXZm9hQTBETGdvWXlnYmtNanp3?=
 =?utf-8?B?L2FvcFVoaFlUVHYrMjF4Q0NHdHplUE9COFRvNGlPOFc2bnVGaTF5L2hXd1Fl?=
 =?utf-8?B?YXNvdWpVUkhaQWFHbzlBUll0WGxBUDBWMk5mbVRjZlFSQjZBYVZYeVo0aVpj?=
 =?utf-8?B?QWM2UFN2QytuNXZVcjVaTklWUzY1MXBjMFM4RnFIbHZZb1E1UFhzaTBFaHVr?=
 =?utf-8?B?bjBqMlhwd2svejdBZUZ6Y0MzVEhYa1hqV2VsVFVxeVczekRVSVRDU0NONEFq?=
 =?utf-8?B?aWxBNTZRTEZXS2tFUmZObWxPMDNacG84ZEp6amNkOHdKRXd0cThUY2lrK1V4?=
 =?utf-8?B?RU9sWkFRVjRWYzA3dFFBM043NlhzYkhLUjZXcFZMdUtLSzgvZGRJekR0TTVF?=
 =?utf-8?Q?yupe4zGbDPk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(42112799006)(7416014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0hHMWY3aTNUMkNVZUJjUnY5bGJFWll2RjdVUVpuRHZoUzh0L3dQYmo2UnFn?=
 =?utf-8?B?elRscG9jSFFIMU9pU1ZheU85MVFNZ1lrdFh0ZE1xaS9rd3h4ZUpEU1lSdXE5?=
 =?utf-8?B?dVBoM0NNVStjNXl1MWhOclVBb3FZQmkxT0pzcXBhYXZxRnFxL2RUcllWYXZr?=
 =?utf-8?B?RW5vbCtwSlJFVWdtZmZaUHJOc0lJaTlJN09hWjFJMkdaR3pLdGxDdURNZ3Z1?=
 =?utf-8?B?SDFSVFJneXFmMGZvdHVvUFNoTEFybmZhVUhHZTcweE1nOHIzb0ZKSTRQZkJs?=
 =?utf-8?B?ZHN5bXQ4VytaSU5xYXNYcXRnNGl1MmcwSlRPdExvTUcyU2MvUEY0eXZ3cWZk?=
 =?utf-8?B?T1RranRhNVdmTHVpdjlDL21rK1Y4RXNFYUp4Q1c3emZnclJha2VZQ1d4SDNn?=
 =?utf-8?B?QkU5NjZEbkpvdTFiVDRZZ1FmeGVXOGF0cDBPeVdJR3czMDNEVTlJdFh2T1BS?=
 =?utf-8?B?LzJRNGxidXhqYlhiUUxHZkF5NEgyS0ZWQUlVK0w2aGdNdlBOTmxvU0NtMGtK?=
 =?utf-8?B?SnJnVlpZR3BpZTY0dmQ0aHRZTi91dUNHYVJ4LzV0cGxFR1lyUE1XM3VJTnpu?=
 =?utf-8?B?TjhhY1ZjWXV5TGUwVi9RYkVQREprS2FFQ1FYbFIrZUNBWGxPOGIrMjdNU3N1?=
 =?utf-8?B?dHZlbEdibCs3OEQyRzArOExLOEYzZXJsRXRpcDV1c2tkVy9uMHVKL2ZEbmt1?=
 =?utf-8?B?Zi9YekYxTzJuZ3Npdkt2MmYyaWpsZXJMVXdFeWE0clEzWUFaZVQwRmY2Rk4y?=
 =?utf-8?B?M1NONE8rMTVLTEFaNldjR0xId0ZuNFgyczlOZ3JkY3A1WGxORUQrL1ZEb0xt?=
 =?utf-8?B?eUZXZ3cvcm1nN1JCQ2Q1NnFrOFVNWG1RazFJaDh1cDM4ZlljMVAxcDBkb1Uv?=
 =?utf-8?B?SGl4QXRLbTNRNE9TbDJtQ3Y2WHdpRklpcmFzSXZDc0FiK3FWTFRqdE0rTlZ4?=
 =?utf-8?B?MzNyUllLenBLa0ZkMW5hc2pXQjhrWDVrVGN6NlA0S1FIL1RVLzRReGtEdG5S?=
 =?utf-8?B?TGxBQVUzbXIxc3A0RXBBTUZldWg0c2YxejFKazlWWUFSbEd3VTBQZ2ljSTYy?=
 =?utf-8?B?c1d2MlhsMkdzVTdMdXQwbHRSVmpoYUlibmRuUGM5dElKM1p0NlNUM3lTWUR5?=
 =?utf-8?B?TVM3MUhOVkM5MGF5NXVsVndxY3JjZjIzRmtyZEhJVERBUWNZSCtOY2Z3MXZD?=
 =?utf-8?B?bCtRVDVBMlRtcHRaeWZtSzJQMjZxNjZiekErUzNQNlRVMmR1NjBCeTJDMjk0?=
 =?utf-8?B?NHdZSXFBdDR4NG1kM0o1ckl3N0xCWmlYeG5FbEw5cWpxNm8wTUJ6OE83QXRu?=
 =?utf-8?B?K3NmdGVPTnFQN3ZvcVA5aWNHQnRpUlRTR09TcHo2OWpNLzE3QjVaRVYwUURl?=
 =?utf-8?B?RmpsSmx3TzBVcUI3blFTa0tSbUI3bnR2YWtORWtwZ1BZbXN3UXB6Z3U3YXhv?=
 =?utf-8?B?ZlZLdnk3TXhHSjc4VmtXTEhZL2pNTno4T3lVVi95bWFlS25BSmIxbUJmSkMx?=
 =?utf-8?B?NUV2dXVCRlZocFZPT2V2U0orOWpSQlZ5MThjUHFxU285QW81dUhkVE4vcCtw?=
 =?utf-8?B?K3RiQlNIb24ra1pSUDJlc3pJR0Y3RWd3b3JvN29FcjlmNXh6TE5sNXlsUFM0?=
 =?utf-8?B?MlpTQTFUeWR6YWJpMkM3SzUybkIra3d0Q0grWDNOQjlXTzlQVDJsVFJOUElN?=
 =?utf-8?B?VkJPeDlGMkN0N1QwWFJCa3VMOFVoK05BK25JWnlVVmlqMnVmSmVIblQ1aEVQ?=
 =?utf-8?B?TkhzTGptbk5aRTdTVCs3QXgzMkZUWFVvbE9GUjMyamxSTjdva1ZPdVczYVlE?=
 =?utf-8?B?bU1mK3hQMzlKMVF0eGlFcHVtSHdmcWlqYmlMcDg5alNVTjhxanZaZkkwSnFr?=
 =?utf-8?B?RVAyYi9lbEI2dkVKNWxjWHpDMkMvdWZEczdKRldnQUhiRjFSL1kwV1Z0OXQx?=
 =?utf-8?B?SzBDQTc1b3ZvV0ZMZGZpM1BRZ1RhSWk1MVVxWmFFZWVTaW43VzdHL1BmZ0xo?=
 =?utf-8?B?RVYwWGo4T0k5ZW5TYjZHVmNrUzAzK3hFQzV4dTFYcTUzME5GSnFxellCbk85?=
 =?utf-8?B?RkQwSEhEQWw1RmFkU3dQMzBWUWV1OFNxS0t6RlpLVDQweWlEd0JhU1ZDdGxh?=
 =?utf-8?Q?5juXDKBdbkj6LtU8Zu8U+AK5P?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 28618236-da34-4d7d-dfdf-08dde60bbf83
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 08:20:29.2487 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L5eIjrOEkrHz5C1l7JG+DI3NazIVH10TvLZU3ZkgFwyWVXx6xZuNcisNCXCLaVtFA2rrO8O4Sx3gEhVBBhTHzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8053
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 2025/8/27 23:30, Nicolin Chen wrote:
> On Wed, Aug 27, 2025 at 02:32:42PM +0200, Eric Auger wrote:
>> On 8/27/25 2:30 PM, Yi Liu wrote:
>>> On 2025/8/27 19:22, Eric Auger wrote:
>>>>> TBH. I'm hesitating to name it as get_viommu_cap. The scope is a little
>>>>> larger than what we want so far. So I'm wondering if it can be done
>>>>> in a
>>>>> more straightforward way. e.g. just a bool op named
>>>>> iommu_nested_wanted(). Just an example, maybe better naming. We can
>>>>> extend the op to be returning a u64 value in the future when we see
>>>>> another request on VFIO from vIOMMU.
>>>> personnally I am fine with the bitmask which looks more future proof.
>>>
>>> not quite sure if there is another info that needs to be checked in
>>> this "VFIO asks vIOMMU" manner. Have you seen one beside this
>>> nested hwpt requirement by vIOMMU?
>>
>> I don't remember any at this point. But I guess with ARM CCA device
>> passthrough we might have other needs
> 
> Yea. A Realm vSMMU instance won't allocate IOAS/HWPT. So it will
> ask the core to bypass those allocations, via the same op.
> 
> I don't know: does "get_viommu_flags" sound more fitting to have
> a clear meaning of "want"?
> 
>    VIOMMU_FLAG_WANT_NESTING_PARENT
>    VIOMMU_FLAG_WANT_NO_IOAS
> 
> At least, the 2nd one being a "cap" wouldn't sound nice to me..

this looks good to me.

Regards,
Yi Liu

