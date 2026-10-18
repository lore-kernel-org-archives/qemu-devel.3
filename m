Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFE8CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 13:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIRJb-0003FD-8J; Sun, 18 Oct 2026 09:52:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xIRJY-0003Ek-Oc
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:52:41 -0400
Received: from mgamail.intel.com ([192.198.163.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1xIRJV-0003cR-Ti
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 09:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792331558; x=1823867558;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=1e0TEUq87wQ4BBfXJwND1TD2NGkGZyCrjjKWRAYHoJM=;
 b=kTuaRNPQTZwvXGjsLR6hX3OGLxW3z5xY7QJ74XJxSs8V/UVUdARHJhrA
 pPSN4djyV69wq4wXk+N8Jk5R+9ZMe4Ta1gJgOJE3K3v4zV5F4FQR7J0Cp
 mCV2U6x75TmoDqaRnvK68A2ZjUBBhO+LU/QX+2s2qzqVL6BXfAfIcAmRG
 Uz0osgRMs3p5pUl0lyqJpHOBdr1R3nHZB1RT/fYoaTdonzbUXIZVijqOO
 r4pR9FYQqD0YfxSFv6IiPK6mXOFlzaVrghYRLjZs/0BfCH5NKBeWO9TcY
 eu35ADNx6z4lyjSD3kLMX0ERx62NWcod30BkxXRwMozAtZJv0PWHSgQG2 Q==;
X-CSE-ConnectionGUID: H+dBydp3RDCzkA5p1ffEEQ==
X-CSE-MsgGUID: nzC8oqAjToiCQkpZUM7bVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="934566"
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="934566"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 06:52:34 -0700
X-CSE-ConnectionGUID: j8efiNhrQeaOA+UCgA4zHg==
X-CSE-MsgGUID: 45d+HuoFQVSFOEIKDvtTQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,165,1787036400"; 
   d="scan'208";a="2413257"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Oct 2026 06:52:34 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 06:52:32 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Sun, 18 Oct 2026 06:52:32 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Sun, 18 Oct 2026 06:52:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pLjkV1ry5/Y2qrxqpCPY7m5pogOKYmFVp4OphKr05dl0EczMjXzKwrKhi8NcAtclV/EjUec6UimRvokVG5qd03u6UsJY62Ei8hedkZQzq6JHAAJ43MvJfOSaDPwJsWgWfw0spWsCdghdL9QmkK1bMGpSExZldIZr/ZhsV7rOK8TvtAB6TjfTwe2HluDuOVufLTK2EwGiwhFGIazimKS6tqUK32QtMgu23HgnClJSkr5Kc5Cvw1e2dt4i3WHj5pSeAhpA0KPxAc7ftE/QWdnOTOwytOqBwz138HPgNRLycQKIcz5NKEnrPwFotGh6LGdtPCRCSL5NkunvuqRiqQ6Dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ki+nYCEQL2ifzVlNz7J9FgK8S1ZYpOPgSv6bKiGOF6A=;
 b=anpHpQQcqd4CxjJa4ZwU8psZr/pIHUQDU1hiWAssMvbZa9eMkddZfkm1u/ONcPUb0z7WSFpQ/mDchlMfJ8jI1uDs/gdQxw5pCj0F149PQhKNTCfwCKSsxAwUfiejPLojvAzXcabHoaMHetjvGlGNqNLmDutOe4XBNnX6AAcX1slJluaxVBwlpSDfTcM3m1Mf5h32HBlwjcmpyXJKLN7hwqWZbTs9tSAEa30UhlFT+ra7NqLHsOL5WUB+FCnenfDrE35p3fwXi9BQnSxErEhDBQszD6VJAYgwNxtJWgb0MV6+mbWjDkVn/nmgoVOhFnyQHdYnShEoQMzqbtGBa9TUQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DM6PR11MB4562.namprd11.prod.outlook.com (2603:10b6:5:2a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Sun, 18 Oct
 2026 13:52:30 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0522.017; Sun, 18 Oct 2026
 13:52:29 +0000
Message-ID: <33c9b517-2fec-443e-be4d-c07ab4b65d54@intel.com>
Date: Sun, 18 Oct 2026 22:00:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/6] intel_iommu_accel: Add PRQ injection for
 passthrough device
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowangio@gmail.com>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <skolothumtho@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@bull.com>,
 <kevin.tian@intel.com>, Xudong Hao <xudong.hao@intel.com>
References: <20261009090737.3930000-1-zhenzhong.duan@intel.com>
 <20261009090737.3930000-5-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20261009090737.3930000-5-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0053.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::7) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DM6PR11MB4562:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dbae2da-8297-4dcb-c7d8-08df2d1f0cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|42112799006|366016|56012099006|260925021911599003|260925022911599003|260925021311599003|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: 9gRNCHbjA/X2AE6zphwcB2kiCVKeX0uPdhcp2ywyj8mreOxlp6k/QAFS5kdy/Z6UAFX2kpQUSGiSQnclhy4qWSFS86DU3x2MhabtFnYirU/b7wPRAuH0YyV/EziNfISLcgkSro8Z46zOo85mGcjPc2GbhCQKvgHJqfaqXlzNIyLUsB7INm7xEEK7Q1e7iVFDVkBZl4gvbHFikkXbLY95qKpS7Je2d7jK0IdiE85/9TdhlsKS8R6OCbzc/Mlh28G23q/N9bpgL0h1InjCuRgSqKAc11w+QWeBO8aqxTgdI9BJmVjTbPl3oelFGOVq0b4+++Y+CgYUOoUHDJQru1t1Evu2aMYTtYdrYgfRkQUXmSR5VYLwpNzoBCybYI+/VBSr6gGzdvSHp2fRwBWvhJs6AJ/ocdMQo1rwgYYLr6eudLGP4m55L5awUQOAyXFGj4z0wf+/TWuE90YzjsqoTokz21mI4L6VVpPC6fYv4VhAf04Qa+leZYQiOujDSJ9YZDDpI33vyiSrbuE+lCoQxkf0d9ZC89YR0zBAHHETU9jhF3bQOuwvN0devkI8j0J4EyWQnLavBGKFNUinNPG8HuJH8Sii8nCIuIf8rs/GxuroIhNCwqxq5T3uLd1+ODskxbNUOreXLmcORZ8Eo5+2TLDQn5yCQ3pTCExlE4SIi5M7590=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR11MB4527.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(42112799006)(366016)(56012099006)(260925021911599003)(260925022911599003)(260925021311599003)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXZRN1JpWVlRQTVnbGtncTR4b3c1ZmdHbEpUR2RhdmZrbWZNaXEwQURsY2Yr?=
 =?utf-8?B?SXFZZkloMUZocVIySU9INTQzVlN4OXc5M1V1bWZLKzZwZW4zOFZsNERCSUFr?=
 =?utf-8?B?ZHFLUmJhUFZveE1sdG1iNGZqYzJEMDFiRXR2bXRnT1hOa091bHZVdHNFM1Ni?=
 =?utf-8?B?NnM0NldCdGJHdlZjTUcybTY4M0FKaEJEb0s5TWNWNWlocFVHR2VWZXlxa1Ax?=
 =?utf-8?B?dHFlaytvcnJVU0I0R21objE3TFdSSFhobkhzTWZzQ0hkbkJBc21FcnRoQlZY?=
 =?utf-8?B?WGRLdDIvN2w1elcvc0NvL3k4U3hvUHEzb3B2dXhJbGJlelpkMzZyWGd1c1N5?=
 =?utf-8?B?TTNiNk1kMHBKeWJucjdJdkJQY1Z3QWZyMnBtdUdWZDNVOHM3UXZFNDh6dzRX?=
 =?utf-8?B?NDdHZDVIWU4zK2piNHhWelRNVnpzZTNEYlhLLzZLWThZZktJeHp3QlBvQm4x?=
 =?utf-8?B?TjQzdGN6bnh0aStCVHROcUdIRHRpWlpjSXlHNXBzM2JkM1pLMkdCVGVTNjJG?=
 =?utf-8?B?YlV3N0x3bmFyREFENjdad2w4UnBYckh2NnlqRi85SStMQXVhVzdrK1JUdGZU?=
 =?utf-8?B?YXNNRjFVTUJ1OWFUT3JFWVZvQmd0bUQwTkhOZGpKamN2Q3huKzJleU4wMm1N?=
 =?utf-8?B?TWxDaWVqMTdGTDAxMUtJZjVldW1lWVlQTmJpWUcyb2dOUnZCbVppQndlbmdn?=
 =?utf-8?B?WEpQSHdreXp1dGJkZG5iRkYrcjkwQXl4M21lekI5TkhWTHQ5K09XaWhMQ1NJ?=
 =?utf-8?B?MlRTVDAxb0YyQ1FkbHQ4bkV3MFk5WmMzVE4zZkdwQnZVYzVwTjI4SzBSQ0E4?=
 =?utf-8?B?U0hMUzMvNmxHdlZVUVlxT0dsUlRBUTBpYTBQb2dGTjY3YnlNMGFFaUxVSWpN?=
 =?utf-8?B?S1k5R3ZodkF0TmFDVEZNRTFMWGRSQVl5dVJmQXVrRHZEWFlGWFF1S0hSQ3Zy?=
 =?utf-8?B?K0JJNXhjbytHcStoYWFPcTFPWXlaV1lMUEs1UXVwanpoRWtDZ1VCRjJtdTRk?=
 =?utf-8?B?T0s5cHduZFkvOGFXWFhua3FxS1ZXS2oxZzRsZkRUNDZSQSs2ZWNNNVhMdlNS?=
 =?utf-8?B?eVJHZUxqb1RmM0JXZm1IVFdVT2RYcW5QNUw0SzhTT2JjdE1LR25LQTBmeTBZ?=
 =?utf-8?B?dm1JVjlQdThQRStXZ1JIQi9URXJONUh6N0htSEVaOXJmdkJaVWFlc3h3aTYy?=
 =?utf-8?B?R3FPNWxSOHJKK0hQaDVzRlZoMlJqTWJkZzZhWS90RnVTUFQ2ZkR2UjdTRHZw?=
 =?utf-8?B?L01nNzJydU5LUFZFRDBlQWFtZ3N3ZjRnUnQzdVpkUHdvaGNTeVRiL2VnYzk5?=
 =?utf-8?B?ZXZ2dEJJcTlqQ29QVUpjd1UyR2tpVVBGTmNEWkxZS2p3bGpzaVNmNWV0SG1q?=
 =?utf-8?B?Ui91cjY1SzRFKy9ObEsxNlpGR3VDeVBkL3Z4d2o4WDlwakQ0NVJhQ1dicHNx?=
 =?utf-8?B?SHhoOCtzeE5lT3ZzbFl6Ky9CTTN6WXVZNVk2N2tuZTdLWFhZd0x2ejRCQ2Ni?=
 =?utf-8?B?TVh5TzB6VFRDYmJUOXUyMGt3ZEtvTzQwNEZVaW9SL2dXYmdOaXc5cVpDLzBS?=
 =?utf-8?B?OEVLcnlQM2lmSlZWMGh3NWRJTzBNSXJDSVR2SFFuUHdqSVp1SFRNcXBHUDI5?=
 =?utf-8?B?N05GUGpPWTVtSHdqcy9pRHh4QTgrcHB1MUZPbVZ4dmY4Wi81a0lUbm9DdkdJ?=
 =?utf-8?B?cTAySW1oVkdoUUdEVFpvck5LMGRYTkpWd2k4eFRYeDBKK2JpVm5HK3NEOGZH?=
 =?utf-8?B?NCtlM3dnbkhBYm5uQ0Z4clE2OGY0bFVraDFwdHkxWFdQNnNNdlBFaGpOeTFo?=
 =?utf-8?B?bmdaTHgzRGYyMUxZVDdOTiswTlNIZHdLaWxMT1NqM2gxeklLbDZBRWd2NHYx?=
 =?utf-8?B?aThTN0lPRjNYYWd4clM3amt1cHFJclUvWVVvNS9lV0RVaTVaWncrbVhqSGYz?=
 =?utf-8?B?RUFReDJrZ3hTdVpPR3FEcWYwU0U3K0VuRUhpRFR3bVlMTk9VejVmN1Nsc3N3?=
 =?utf-8?B?N1B4WXV4TThURE5GY3BrOUlORlpqdFF3N1NuQTVyQ0VpK3ljY2JWTm10elBS?=
 =?utf-8?B?TFpyT3J1WjlwU3M1WXN2WUxlaU9rYkFDaDZiQXQ2aHM5SVFkYXkzdTRTbDVH?=
 =?utf-8?B?ZFp5UkRLOFBFeVZEVE83Z1E3cmFsYVlsWGNUN1hYVW1qbCtpQWl2L1NSM2RH?=
 =?utf-8?B?RzVQQlhQR0xieitnOGdXY25lMGgrRmNhT0NId3ljM0FBd2wzNGEwamdlOXdm?=
 =?utf-8?B?RTQ5akY0a0U4NVpCZ0hHQSt6RHRaQjRUUjAveG5ialV5RXFWdnVnb1BlaUNR?=
 =?utf-8?B?Rk5oZ3lZN1BVaG5EVXp2ZnAzNWkzSVZKU3lNZUtjK3JQQ3psV3dUUT09?=
X-Exchange-RoutingPolicyChecked: J95iY3ruFakkRoHLO+WfT9Vz3wdpV2/DpsK5TYsFzzxJCXx5RJTb07Vpn8UgKDADkMb//oGJ1I/7GUPMmg9w54ZSc70f8XgIk/fp5Zj+wzJ5G/WfN6KhcUarJBDO9YsUHE6BkeifI1hA+nZ7Dd+mMUXRk3USq3l5T+Kx7/Rlaq9pKLMFTlWCHLNlCsoWN6dePNIk1X3rm0JV/iA73LjXmJXQDbwgvdRW/kPbpOjQPmFps7hmHW+FO7TCJylSI0PPgfbAmdUqoqvNESdYkYZrLxwHYYVetYT1xOKcSAGo9DTgoH67640opmhGUH2y4wvhByNVjsXg5GTsaTN2qHJCuw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dbae2da-8297-4dcb-c7d8-08df2d1f0cf8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2026 13:52:29.6634 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5ZRKz7Pnx+NV/GxW7jKOzQv9d4TtIkMr1vs4rtF6+deGNaTvnoiaN5r0WLWq5xsJismS3pwc2Ug3JVdM8IjwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4562
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.10; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 10/9/26 17:07, Zhenzhong Duan wrote:
> When the guest enables the PRQ in vIOMMU, allocate a FAULTQ object so that
> host-side recoverable fault events can be received and propagated back to
> the guest.
> 
> Install an event handler on the FAULTQ fd to read and propagate host
> generated recoverable fault events to the guest.
> 
> The handler runs in QEMU's main loop, using a non-blocking fd registered
> via qemu_set_fd_handler().
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> Tested-by: Xudong Hao <xudong.hao@intel.com>
> ---
>   hw/i386/intel_iommu_accel.h    |   2 +
>   hw/i386/intel_iommu_internal.h |   3 +
>   hw/i386/intel_iommu.c          |  14 ++-
>   hw/i386/intel_iommu_accel.c    | 163 +++++++++++++++++++++++++++++++--
>   hw/i386/trace-events           |   1 +
>   5 files changed, 172 insertions(+), 11 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> index 46c1a29409..e0319749a5 100644
> --- a/hw/i386/intel_iommu_accel.h
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -18,6 +18,8 @@ typedef struct VTDAccelPASIDCacheEntry {
>       VTDPASIDEntry pasid_entry;
>       uint32_t pasid;
>       uint32_t fs_hwpt_id;
> +    uint32_t fault_id;
> +    int fault_fd;
>       QLIST_ENTRY(VTDAccelPASIDCacheEntry) next;
>   } VTDAccelPASIDCacheEntry;
>   
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index df7a0efa6e..4792035668 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -787,4 +787,7 @@ int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
>   VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid);
>   int vtd_dev_get_pe_from_pasid(IntelIOMMUState *s, PCIBus *bus, uint8_t devfn,
>                                 uint32_t pasid, VTDPASIDEntry *pe);
> +int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
> +                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
> +                         uint16_t prgi, bool is_read, bool is_write);
>   #endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 350d2b7753..81c53c6f5a 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -5383,11 +5383,15 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>       return ret;
>   }
>   
> -/* Page Request Descriptor : 7.4.1.1 */
> -static int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn,
> -                                uint32_t pasid, bool priv_req, bool exec_req,
> -                                hwaddr addr, bool lpig, uint16_t prgi,
> -                                bool is_read, bool is_write)
> +/*
> + * Page Request Descriptor : 7.4.1.1
> + *
> + * Because it is facing the emulated device models, so this should be PCI
> + * PASID instead of the pasids used within vIOMMU.
> + */
> +int vtd_pri_request_page(PCIBus *bus, void *opaque, int devfn, uint32_t pasid,
> +                         bool priv_req, bool exec_req, hwaddr addr, bool lpig,
> +                         uint16_t prgi, bool is_read, bool is_write)
>   {
>       IntelIOMMUState *s = opaque;
>       VTDAddressSpace *vtd_as;
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> index c8f2835204..7baefe30cc 100644
> --- a/hw/i386/intel_iommu_accel.c
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -9,6 +9,7 @@
>    */
>   
>   #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>   #include "system/iommufd.h"
>   #include "intel_iommu_internal.h"
>   #include "intel_iommu_accel.h"
> @@ -83,14 +84,141 @@ VTDHostIOMMUDevice *vtd_find_hiod_iommufd(VTDAddressSpace *as)
>       return NULL;
>   }
>   
> -static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
> -                               VTDPASIDEntry *pe, uint32_t *fs_hwpt_id,
> -                               Error **errp)
> +static void vtd_propagate_recoverable_faults(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                             struct iommu_hwpt_pgfault *fault,
> +                                             unsigned cnt)
> +{
> +    VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
> +    uint32_t pasid =
> +        vtd_pce->pasid == IOMMU_NO_PASID ? PCI_NO_PASID : vtd_pce->pasid;
> +
> +    for (; cnt--; fault++) {
> +        bool last_page = fault->flags & IOMMU_PGFAULT_FLAGS_LAST_PAGE;
> +
> +        vtd_pri_request_page(vtd_hiod->bus, vtd_hiod->iommu_state,
> +                             vtd_hiod->devfn, pasid,
> +                             fault->perm & IOMMU_PGFAULT_PERM_PRIV,
> +                             fault->perm & IOMMU_PGFAULT_PERM_EXEC,
> +                             fault->addr, last_page, fault->grpid,
> +                             fault->perm & IOMMU_PGFAULT_PERM_READ,
> +                             fault->perm & IOMMU_PGFAULT_PERM_WRITE);
> +    }
> +}
> +
> +/* Batch size per read(); remaining faults trigger another callback */
> +#define FAULTQ_BUF_SIZE 2048
> +
> +static void vtd_read_fs_faultq(void *opaque)
> +{
> +    VTDAccelPASIDCacheEntry *vtd_pce = opaque;
> +    struct iommu_hwpt_pgfault faults[FAULTQ_BUF_SIZE];
> +    uint32_t id = vtd_pce->fault_id;
> +    int fd = vtd_pce->fault_fd;
> +    ssize_t bytes, last_bytes;
> +
> +    bytes = read(fd, faults, sizeof(faults));
> +    trace_vtd_read_fs_faultq(id, fd, bytes);
> +    if (bytes < 0) {
> +        if (errno != EAGAIN && errno != EINTR) {
> +            error_report_once("FAULTQ(id %u): read failed (%m)", id);
> +        }
> +        return;
> +    } else if (!bytes) {
> +        error_report_once("FAULTQ(id %u): fault group empty unexpectedly", id);
> +        return;
> +    }
> +
> +    last_bytes = bytes % sizeof(faults[0]);
> +    if (last_bytes) {
> +        error_report_once("FAULTQ(id %u): discard partial fault data: %zd/%zu",
> +                          id, last_bytes, sizeof(faults[0]));
> +    }
> +
> +    vtd_propagate_recoverable_faults(vtd_pce, faults,
> +                                     bytes / sizeof(faults[0]));
> +}
> +
> +static void vtd_destroy_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                  uint32_t fault_id, int fault_fd)
> +{
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +
> +    if (fault_fd < 0) {
> +        return;
> +    }
> +
> +    close(fault_fd);
> +    iommufd_backend_free_id(hiodi->iommufd, fault_id);
> +}
> +
> +static bool vtd_create_fs_faultq(VTDHostIOMMUDevice *vtd_hiod,
> +                                 uint32_t *fault_id_p, int *fault_fd_p,
> +                                 Error **errp)
> +{
> +    HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
> +    uint32_t fault_id, fault_fd;
> +    int flags;
> +
> +    if (!iommufd_backend_alloc_faultq(hiodi->iommufd, &fault_id, &fault_fd,
> +                                      errp)) {
> +        return false;
> +    }
> +
> +    flags = fcntl(fault_fd, F_GETFL);
> +    if (flags < 0) {
> +        error_setg_errno(errp, errno, "Failed to get flags for FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    if (fcntl(fault_fd, F_SETFL, flags | O_NONBLOCK) < 0) {
> +        error_setg_errno(errp, errno, "Failed to set O_NONBLOCK on FAULTQ fd");
> +        goto free_faultq;
> +    }
> +
> +    *fault_id_p = fault_id;
> +    *fault_fd_p = fault_fd;
> +    return true;
> +
> +free_faultq:
> +    vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
> +    return false;
> +}
> +
> +static void vtd_destroy_old_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce)
> +{
> +    if (vtd_pce->fault_fd < 0) {
> +        return;
> +    }
> +
> +    qemu_set_fd_handler(vtd_pce->fault_fd, NULL, NULL, NULL);
> +    vtd_destroy_fs_faultq(vtd_pce->vtd_hiod, vtd_pce->fault_id,
> +                          vtd_pce->fault_fd);
> +    vtd_pce->fault_id = 0;
> +    vtd_pce->fault_fd = -1;
> +}
> +
> +static void vtd_setup_fs_faultq(VTDAccelPASIDCacheEntry *vtd_pce,
> +                                uint32_t fault_id, int fault_fd)
> +{
> +    if (fault_fd < 0) {
> +        return;
> +    }
> +
> +    vtd_pce->fault_id = fault_id;
> +    vtd_pce->fault_fd = fault_fd;
> +    qemu_set_fd_handler(fault_fd, vtd_read_fs_faultq, NULL, vtd_pce);
> +}
> +
> +static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod, VTDPASIDEntry *pe,
> +                               bool has_fault_id, uint32_t fault_id,
> +                               uint32_t *fs_hwpt_id, Error **errp)
>   {
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       struct iommu_hwpt_vtd_s1 vtd = {};
>       uint32_t flags = vtd_hiod->iommu_state->pasid ? IOMMU_HWPT_ALLOC_PASID : 0;
>   
> +    flags |= has_fault_id ? IOMMU_HWPT_FAULT_ID_VALID : 0;
> +
>       vtd.flags = (VTD_SM_PASID_ENTRY_SRE(pe) ? IOMMU_VTD_S1_SRE : 0) |
>                   (VTD_SM_PASID_ENTRY_WPE(pe) ? IOMMU_VTD_S1_WPE : 0) |
>                   (VTD_SM_PASID_ENTRY_EAFE(pe) ? IOMMU_VTD_S1_EAFE : 0);
> @@ -100,7 +228,7 @@ static bool vtd_create_fs_hwpt(VTDHostIOMMUDevice *vtd_hiod,
>       return iommufd_backend_alloc_hwpt(hiodi->iommufd, hiodi->devid,
>                                         hiodi->hwpt_id, flags,
>                                         IOMMU_HWPT_DATA_VTD_S1, sizeof(vtd), &vtd,
> -                                      0, fs_hwpt_id, errp);
> +                                      fault_id, fs_hwpt_id, errp);
>   }
>   
>   static void vtd_destroy_old_fs_hwpt(VTDAccelPASIDCacheEntry *vtd_pce)
> @@ -121,7 +249,8 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       VTDHostIOMMUDevice *vtd_hiod = vtd_pce->vtd_hiod;
>       HostIOMMUDeviceIOMMUFD *hiodi = HOST_IOMMU_DEVICE_IOMMUFD(vtd_hiod->hiod);
>       VTDPASIDEntry *pe = &vtd_pce->pasid_entry;
> -    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid;
> +    uint32_t hwpt_id = hiodi->hwpt_id, pasid = vtd_pce->pasid, fault_id = 0;
> +    int fault_fd = -1;
>       bool ret;
>   
>       /*
> @@ -136,7 +265,24 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       }
>   
>       if (vtd_pe_pgtt_is_fst(pe)) {
> -        if (!vtd_create_fs_hwpt(vtd_hiod, pe, &hwpt_id, errp)) {
> +        IntelIOMMUState *s = vtd_hiod->iommu_state;
> +        VTDContextEntry ce;
> +        uint8_t bus_n = pci_bus_num(vtd_hiod->bus);
> +        bool is_pre = false;
> +
> +        if (s->svm &&
> +            !vtd_dev_to_context_entry(s, bus_n, vtd_hiod->devfn, &ce)) {

if failed to fetch CE, should we fail this attach? Noramlly, if coming
to this place, CE fetch shall not fail. right? But fail it if fetch
fails should be reasonable. Also, there is vtd_check_pre_bit() which
validates the PRE bit, shall we consolidate with it? Other parts look
good to me.

> +            is_pre = !!VTD_CE_GET_PRE(&ce);
> +
> +            if (is_pre &&
> +                !vtd_create_fs_faultq(vtd_hiod, &fault_id, &fault_fd, errp)) {
> +                return false;
> +            }
> +        }
> +
> +        if (!vtd_create_fs_hwpt(vtd_hiod, pe, is_pre, fault_id, &hwpt_id,
> +                                errp)) {
> +            vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>               return false;
>           }
>       }
> @@ -146,11 +292,14 @@ static bool vtd_device_attach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>       if (ret) {
>           /* Destroy old fs_hwpt if it's a replacement */
>           vtd_destroy_old_fs_hwpt(vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_pce);
>           if (vtd_pe_pgtt_is_fst(pe)) {
>               vtd_pce->fs_hwpt_id = hwpt_id;
> +            vtd_setup_fs_faultq(vtd_pce, fault_id, fault_fd);
>           }
>       } else if (vtd_pe_pgtt_is_fst(pe)) {
>           iommufd_backend_free_id(hiodi->iommufd, hwpt_id);
> +        vtd_destroy_fs_faultq(vtd_hiod, fault_id, fault_fd);
>       }
>   
>       return ret;
> @@ -183,6 +332,7 @@ static bool vtd_device_detach_iommufd(VTDAccelPASIDCacheEntry *vtd_pce,
>   
>       if (ret) {
>           vtd_destroy_old_fs_hwpt(vtd_pce);
> +        vtd_destroy_old_fs_faultq(vtd_pce);
>       }
>   
>       return ret;
> @@ -282,6 +432,7 @@ static void vtd_accel_fill_pc(VTDHostIOMMUDevice *vtd_hiod, uint32_t pasid,
>       vtd_pce->vtd_hiod = vtd_hiod;
>       vtd_pce->pasid = pasid;
>       vtd_pce->pasid_entry = *pe;
> +    vtd_pce->fault_fd = -1;
>       QLIST_INSERT_HEAD(&vtd_hiod->pasid_cache_list, vtd_pce, next);
>   
>       if (!vtd_device_attach_iommufd(vtd_pce, &local_err)) {
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index a1a50d0910..ad84d106a4 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -77,6 +77,7 @@ vtd_reset_exit(void) ""
>   vtd_device_attach_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
>   vtd_device_detach_hwpt(uint32_t dev_id, uint32_t pasid, int ret) "dev_id %d pasid %d ret: %d"
>   vtd_device_reattach_def_hwpt(uint32_t dev_id, uint32_t pasid, uint32_t hwpt_id, int ret) "dev_id %d pasid %d hwpt_id %d, ret: %d"
> +vtd_read_fs_faultq(uint32_t fault_id, uint32_t fault_fd, ssize_t ret) "fault_id %d fault_fd %d ret: %zd"
>   
>   # amd_iommu.c
>   amdvi_evntlog_fail(uint64_t addr, uint32_t head) "error: fail to write at addr 0x%"PRIx64" +  offset 0x%"PRIx32


