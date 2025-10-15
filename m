Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA96CCCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 12:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v90fr-0008U2-A0; Wed, 15 Oct 2025 08:32:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v90fm-0008Q6-CZ
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:32:06 -0400
Received: from mgamail.intel.com ([198.175.65.14])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1v90ff-0004RO-8G
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 08:32:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760531519; x=1792067519;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=aoBwPHbfLIayBm/sjWKC7oJ+ZgstUN65W8MYX6ZOikw=;
 b=KpwR8NFaMLgmOGfaTUMNA9aELik2AXxvVI3N81bdgOJC0L1EqFYKPerO
 JFruISj5ajdHNwlXMm5KdFrC0OcbXhcmdX5wFg6I3mh96Xfhx6ugejmtq
 HqvWitk4OQ6M3NDejhiFlZ1X48CsGk0qMy+7+OYcYNM6m3N+pbdv5WYVy
 hSwuAGleW0LIcG5xJHAFuisyu0E/vS+VSUZdYk4/dNSx1EPu0Lst5ivyU
 XA5+azC+yAC7zyJdS4xVyXMkbLC2W5FNQkFBn/RdnbNSFdQA2J0cPVEL7
 7CPa+GanE09K0ijdJdq+B3y+7euONGcgWIB95yQZcMXR254Xhfxxzq8ex g==;
X-CSE-ConnectionGUID: sI69CdkwTWm23ZDPZ80FYQ==
X-CSE-MsgGUID: 1j3fu22NTZy7N97tAhBriA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="66532905"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="66532905"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 05:31:53 -0700
X-CSE-ConnectionGUID: w7KRXpfRTvO7Pkt/Qe+lWQ==
X-CSE-MsgGUID: cVjVJtebQ/CjsYhmOdP6Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,231,1754982000"; d="scan'208";a="182154152"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2025 05:31:53 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:31:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Wed, 15 Oct 2025 05:31:52 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Wed, 15 Oct 2025 05:31:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6VAHxkKn2xgJo1NfYthp1WYDhPCx2gcVlg0h+SKR4m12fpI+3L0CvXQTWo52nFRdgBiwQb35AcO27NRvESmbCqEm44+/eaUfuK29PZ4FYWpguXdJBCWSL0Cz60nh9lZcL/zC0y4yvRIwYs8z1nH4kgBFPcIxDLuXoqHJEHaZQWcc8YyI9eeT3MWpP7L1gWFMFnUiOqTtrNzzI5vN/nHqeuPR6/XCJ/hv2mQTUmLvsSDzGX3jBW9aZV8xLKai6gLeKzpPfrnxA8g1hYjjGi9SnkoQOw5kM37ZB52eyhuGy4DAgY90cjHQl7nax1uOiGptAOPJ9HhWo05muh/riYpmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTAgyGkTgQb+FGBGfx18sN9CRit3ajfB4A7qTaTXbUI=;
 b=iatVXBBltUxzQE0cRXV0Tb5RXDNOfYObAlNcmDU+wPJhDebZo4VTw5Do/pA5CP/EQLR4HHfGFp+HgcvTBx3sf39iOPlieXk/N5vd36kT7RqG/69fcG/u0pmOsvTL26uABNw+t4ddlTal9MRkCKfk3n/96fhggil8eGCDH7oBD/6gUn3SmjYruoWgTmVUKRyD52zA/1OrTN7zIjAokpxm7NLZ91DRylQodQX70uupeLs/l3o5kbIb+NKNicnpX0Nf3VpjZ7jdES2BmezVBiSorOtexjCGxaYV3lGClvUMOrWMH/u7zA4bhY0VEehdUUs8a2pvZTeU+0hDFGxnab3dAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com (2603:10b6:a03:2d5::12)
 by PH7PR11MB8124.namprd11.prod.outlook.com (2603:10b6:510:237::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 12:31:49 +0000
Received: from SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e]) by SJ0PR11MB4798.namprd11.prod.outlook.com
 ([fe80::d946:6abf:6e7e:fd1e%7]) with mapi id 15.20.9228.010; Wed, 15 Oct 2025
 12:31:49 +0000
Message-ID: <8a18e210-9ea4-45a3-8d67-69cb1d167b69@intel.com>
Date: Wed, 15 Oct 2025 20:38:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] intel_iommu: Handle PASID cache invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <clement.mathieu--drif@eviden.com>
References: <20251015102003.279239-1-zhenzhong.duan@intel.com>
 <20251015102003.279239-2-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20251015102003.279239-2-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0048.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3c::18) To SJ0PR11MB4798.namprd11.prod.outlook.com
 (2603:10b6:a03:2d5::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4798:EE_|PH7PR11MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3e6939-4557-4341-7a76-08de0be6cfb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|366016|1800799024|42112799006|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cWd2VkV6eWFOajRCS2dTQXNHSk9xZXh4N2gvOFFDSjVNZWR4Z1FreDZYd3l0?=
 =?utf-8?B?bWZvRVVyZHg1dW51T1BoS0ZyaFloRGRuRnpuRkt6WHBjblNEQTRtWHp0NWtC?=
 =?utf-8?B?enp3Z1I2bnhmZzVPTEJmenZ5WGhuNmt6aWdBckJ1ZStxZ1E3ZHhsczZ5QTYz?=
 =?utf-8?B?WnlRVCtRNWEvOWc3ZE9BNm9XSXRKRlB6cGZQUEtWRndScTVuRVJwZG94eFkv?=
 =?utf-8?B?c243c0dSNXFrTC8rcGYzcUZZcVVsaVU5V1pWbXk3Z2dRMVpsM3U2N3A5cGFz?=
 =?utf-8?B?endlUVpBUmxoeEZhV1FYQzBZZzBXTGxVVTRwY0ZFaC80MTl6SmtVLzVFY0ZI?=
 =?utf-8?B?VGFsYnArSlZDd2FlWGZoTUVEY1ZTTUV1NHBLUHU2ZjVZUHhZUzdUR3Z6cU9p?=
 =?utf-8?B?OE1YRkYyRkNJb3FSNmpxZFFiQVVRSDRseHJHWStKRlBuMGZVVS9FNnpHK2NT?=
 =?utf-8?B?L0g5TGl3MU4ybW9BYzJtS2FTb2NubEprck9iTU4zTnRJdDFJZzcxSG1lMW1o?=
 =?utf-8?B?aExpc2NKUjR2SEpOR2g5Vkl5SWRPOTh2TUdDK1FVNXBTZDBHaEw5YlYwRHhv?=
 =?utf-8?B?dG9uWUdGd1ozaUN4ZVBQRm1jblZuaTZ2RUlOcmovTVVVTytSY0dGVGU5R1V5?=
 =?utf-8?B?Q2hVdno4cW1LQ3pFd05mVWFUc2tXR29TUkU1emNENEhjUHhzdTMvemFUb01m?=
 =?utf-8?B?RlBLYmk2ajU5aHJadjBmYS9Na2M2ZTZkY1V5NjErMFRURzVIczUxVGpNYzZ1?=
 =?utf-8?B?TDFod2FXWUhkR1lDemc4c1owMWxmdjFOaTNzemtCN0I2eS9CWUZZSG1wTStL?=
 =?utf-8?B?Y3pRbis1TzNyT0REV252U05mb2J6TldBTFA5UGJkMXBKWlNUUDNYYmVWalBU?=
 =?utf-8?B?UmxoRWVOSHJzbWNod09WZGo5Vi84N3BGcHIxUDZCc2tmeWIzZTB4aHVEQkN5?=
 =?utf-8?B?UThCNEloZDV1UmdkTm1DOC9qaGxZRStWeXJPeUs1OHN4SjhVeWM5M1lYNHIx?=
 =?utf-8?B?Um02TW1KbVkyUW8ycUNORjhMcjcwRkVESlNHT2hwZFFmT3FadzRPTkhEaEEz?=
 =?utf-8?B?VlBNMlUyYUt3MklmVk5NVm54RDdmNWhlSitoKzhYRlA0Ui9KZmthK2hKeUx2?=
 =?utf-8?B?bDBrOExLUVB3UnZNSmFCNWt3dmtkdHlhd0FsdjJleGpON0tEWjlNZkt2M3Nn?=
 =?utf-8?B?VU1sTnhKU1JNSHFFVkt2RGpGQzhqMm1iR0RUQ1I0d2hYNXlVcmljRC8vMWtU?=
 =?utf-8?B?dlFNTEN2OUhCSnd0SXY0d1BNSGEyand6cGswUjZCRE1XdG5GSWdWZGxzWC9J?=
 =?utf-8?B?cmZsTHVvM00vU21VenFDOXRDRFJ3OUdteEZFZlB0MFhBcGk2TkhMcTVqSXBj?=
 =?utf-8?B?anZiTU5DdXN1ZDdrLyt4cktEcTRLY3pwdkpaLzlZbXk1VUY1Z1FvR1dqUTd0?=
 =?utf-8?B?ZEtybUNKRXI1V0RCWEFKWDRJOENMTXdDSFpwU2dIK1MvRmk5Unl3eDNDSWR5?=
 =?utf-8?B?cmFjemlISVlVWGxLVVM0TWxacGxkdFBXMkdCdjNwdVBrbnZRT2JtZFJoVEI1?=
 =?utf-8?B?NnFnQzVsUjgxNHFQcERxdDNaK3VCTHcxR1FoK1NZU2tkUVJmUWx0UlVGMzBZ?=
 =?utf-8?B?UDZEWWY2cnA2d1dzZlFpYWpQdDZNeGlmeURqV1BXanB5ejNXRlNPUFhlUHlE?=
 =?utf-8?B?UnJ3VEY3ZUdZY3V0ZUdiSUt5M2MxTkFXenpDZHN3cWl4TDQ0OHoxTXFvaHN6?=
 =?utf-8?B?SGJ1SWt6NTdRQTRWdGI1Q2RZMkNxdjJnRlRMeFZDaDlvbzFlQzEyU2lobXQz?=
 =?utf-8?B?a0tMWlpRRjZMV3hmZFRhMlk2T0VzeC9GQTk3NU9jU3lvNGNkaTQzMXgyQ2ZZ?=
 =?utf-8?B?RUhjcHZPenNPZHVCellVczJLYURuaWNrNllYdVpsSXl3OTB3bzF0REZPWllL?=
 =?utf-8?Q?4uFSXkmavFR83fXN78uUm4nlNJkzQ3IO?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB4798.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(42112799006)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDc0Qk1BRFJvQXpNWi95V0Q1c1NmWHhJKzY1NW1oYWRlWmVpQzl3SlF4d3Br?=
 =?utf-8?B?Kzhrc2JUcjFTRDFzTEIrUlRkdXJJTWJSNU8wOENGMlJUbkkrVXZpVEpSYy9I?=
 =?utf-8?B?R1VvNldseUhXQXNRbWFldUNlc093alRJVlF5YWkvVFhwR250L2psNHpYenFn?=
 =?utf-8?B?SWo4R1pGV3hyd1FZT2x3dUREMnVWaUhGYVowZ3YvY2VkdVVBbTkrVkd1QS9Z?=
 =?utf-8?B?Z3dOS1FhVW02UW1CeXU5Wkc0VXcwRlpVeHl1VW9rVXdNbXNFZktBRDZkYnZ3?=
 =?utf-8?B?TmJVMExJTmJUMXhXRXNJN3Z3QjFHdXAvL1JZcmZvaVMyczBqTmo1UjhQZUhE?=
 =?utf-8?B?OTRZS1UyYk44dFZwNnJsQkJSa1ZxOGZLRmFYWXk0YnRoSjZ6NDd1YXVINWE3?=
 =?utf-8?B?bTViS3Q0UnJxWFZMcjBJelR0VlpTUDlXWG5PQUQrWWlUeVlDMGg1dGZRdG5Z?=
 =?utf-8?B?NS9lOVhySFNxWmkrVEd2SE9LOVlxKzRRcEVSUDFZRTVJMmNxYk9uMTV1ZkFN?=
 =?utf-8?B?WmxmVGswRUlmNTdBSTMvaXM0V29QcmEzcHV3OGU3YkpQdW5uV3NLbzBnQXIx?=
 =?utf-8?B?L0ZrVVVGRkFsWXp2NVlLc085SjF3NkNiYnltbTFseEU4S2JkZkM5eUpSZjJQ?=
 =?utf-8?B?cENiSHFSRWc3a01ucm55T2V4eHlTQ0ZLcDMxWWRnYkxKSW1NejJlTE13cEpS?=
 =?utf-8?B?L2diVjdBdGlXZlhDTVE0ZVQ4QzlYbldZSHZ5dCtqT2JUa0FjeDl0bm1RMEdw?=
 =?utf-8?B?dXZzaFZFOWliNFBpaVJsdkZqNVpYT0I0TGpvZ2VEY0J2RVpweEdiRGVsV3BX?=
 =?utf-8?B?MjBQMGdud2FDdEU3clUyUGloNkVKUVp0V0Y0REE3MmVRUjA4b0hWc3JtOVpN?=
 =?utf-8?B?Y2VhcG1sOXNmNWtGekI5R1hMcFREais4b3k0ZXNlNVJ1TGxROVEvcjI0RmEx?=
 =?utf-8?B?S3UyNjVhSjYrK3FCaGVaTmkzWUUxVzU5MUFLYlVkYXdTUndsYnpDdkplekNr?=
 =?utf-8?B?Q2Y1dFliK21DUi9uU1lJMHFvdy85ZElkTUgrZmwvWlFLMWEwREg1N3lhYXlP?=
 =?utf-8?B?MDVGMXlmaDlBdkJ1cjZKRnVaOGtRelZkejkzVkR5QlhaVXRSUWM5ZEFNWWtU?=
 =?utf-8?B?SzQ3M3pnbGlzU3k3NFpLM3VvVkxneFFvZVlNdGpPd2Y2c1JyeWxDOWpnSW1w?=
 =?utf-8?B?d3BMaEpGOEF0a0NpOUtxVWcwdWZtQnlSako1RVdmSG9HQUNMSG8xMEdPYnNS?=
 =?utf-8?B?UG9MNGcyYURVcjM2YzNQQzFtMGlDbDRpS29Cb09TR3gwSm5vZ1cxZU1zdGlH?=
 =?utf-8?B?WHlURXBOREtQeDJWODhnYjgvUnBWUDdPdks3YXJuWkJxdTZhS2VuaDBoclJJ?=
 =?utf-8?B?NElCV3QwYVhsVStxK1RJN1NxSkNSQ1ZCMXd2WEtmWTJtbHUzTjluZUgxTHdz?=
 =?utf-8?B?c0JsU21MQ3ZobU0vL3NkVUl3cVl3aTk2eklhbWljQlNjY29WWFQ3SVBMUXVC?=
 =?utf-8?B?VmIwSmc0Tmc2OGN6TEpuOWE5TzFGWFZWa3QyNlJVZDVHNk1iSDRlblU5eHA0?=
 =?utf-8?B?K1ZteGFObDRiTTFoU0dkUHlMMDNSWDBaZW4vTjBUSm84cE9OM0JlRk9KTVo1?=
 =?utf-8?B?dWtJeDVubWJlVlpJSy9vcUFLZkFPZFJYdDBvNWQ0azVKTzQ4VTlibVdoNkh6?=
 =?utf-8?B?VExqVTFKRG5xS1Z1cjZRTFJCRTQ2cnJvRjJOMjB5T1BLSjNnSmp5akxTVExh?=
 =?utf-8?B?YkVscEdjemdqWkRnYlNKdC92c201U2pHeTBORThPTktDbXNzNGJIbWx4V2M1?=
 =?utf-8?B?d091bDM1d25Sell3WG5MTFV5cUtZRFl3QTIvSU50VzlpcXp1Yy9uMklSNzIz?=
 =?utf-8?B?cE5WU2N2aFBJcEhMS05hektmM0d0MjJFbzNlOWhiNlFEeXJlUkdONHhaM2RG?=
 =?utf-8?B?NXVnTitCUlU0SjJUeFNuSXJ1eU5hYVJONzh1NTBtRVA3QUJ3VDZ2amFHVFYz?=
 =?utf-8?B?UkJFbS9NZWM5SGUzeU9BVU42SjE0MS9Za3BkVDVIaVdaZStqNHBSSVcxZWRH?=
 =?utf-8?B?OHpYbW5UMUxtMW91TEVNTzE5RFo1SnZHT0JvbEtVR3JZcWh4em8yVDVIbk9D?=
 =?utf-8?Q?4LcTc3yUahosqvMfvCaLdh0De?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3e6939-4557-4341-7a76-08de0be6cfb9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4798.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 12:31:49.1529 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x58SR27BAdIrSmRVpXv6bacYQgtGbySmdCa58OHVWYjdewL1E5Ids2/ZjqsDrmfIPOluDDdf79x+S4tsLRoH9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8124
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.14; envelope-from=yi.l.liu@intel.com;
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

On 2025/10/15 18:20, Zhenzhong Duan wrote:
> Adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the pasid
> entry and track PASID usage and future PASID tagged DMA address translation
> support in vIOMMU.
> 
> When guest triggers pasid cache invalidation, QEMU will capture it and
> update or invalidate pasid cache.
> 
> vIOMMU emulator could figure out the reason by fetching latest guest pasid
> entry in memory and compare it with cached PASID entry if it's valid.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  19 ++++-
>   include/hw/i386/intel_iommu.h  |   6 ++
>   hw/i386/intel_iommu.c          | 150 ++++++++++++++++++++++++++++++---
>   hw/i386/trace-events           |   3 +
>   4 files changed, 165 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 0f6a1237e4..80193ff28b 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -316,6 +316,8 @@ typedef enum VTDFaultReason {
>                                     * request while disabled */
>       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>   
> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
> +
>       VTD_FR_SM_PRE_ABS = 0x47,   /* SCT.8 : PRE bit in a present SM CE is 0 */
>   
>       /* PASID directory entry access failure */
> @@ -517,6 +519,15 @@ typedef union VTDPRDesc VTDPRDesc;
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>   
> +/* PASID-cache Invalidate Descriptor (pc_inv_dsc) fields */
> +#define VTD_INV_DESC_PASIDC_G(x)        extract64((x)->val[0], 4, 2)
> +#define VTD_INV_DESC_PASIDC_G_DSI       0
> +#define VTD_INV_DESC_PASIDC_G_PASID_SI  1
> +#define VTD_INV_DESC_PASIDC_G_GLOBAL    3
> +#define VTD_INV_DESC_PASIDC_DID(x)      extract64((x)->val[0], 16, 16)
> +#define VTD_INV_DESC_PASIDC_PASID(x)    extract64((x)->val[0], 32, 20)
> +#define VTD_INV_DESC_PASIDC_RSVD_VAL0   0xfff000000000f1c0ULL
> +
>   /* Page Request Descriptor */
>   /* For the low 64-bit of 128-bit */
>   #define VTD_PRD_TYPE            (1ULL)
> @@ -603,6 +614,12 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   #define VTD_SM_CONTEXT_ENTRY_PRE            0x10ULL
>   
> +typedef struct VTDPASIDCacheInfo {
> +    uint8_t type;
> +    uint16_t did;
> +    uint32_t pasid;
> +} VTDPASIDCacheInfo;
> +
>   /* PASID Table Related Definitions */
>   #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>   #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -624,7 +641,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>   
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)

I think this can be done in a separate patch.

>   
>   #define VTD_SM_PASID_ENTRY_FLPM          3ULL
>   #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 47730ac3c7..6e68734b3c 100644
> --- a/include/hw/i386/intel_iommu.h
> +++ b/include/hw/i386/intel_iommu.h
> @@ -95,6 +95,11 @@ struct VTDPASIDEntry {
>       uint64_t val[8];
>   };
>   
> +typedef struct VTDPASIDCacheEntry {
> +    struct VTDPASIDEntry pasid_entry;
> +    bool valid;
> +} VTDPASIDCacheEntry;
> +
>   struct VTDAddressSpace {
>       PCIBus *bus;
>       uint8_t devfn;
> @@ -107,6 +112,7 @@ struct VTDAddressSpace {
>       MemoryRegion iommu_ir_fault; /* Interrupt region for catching fault */
>       IntelIOMMUState *iommu_state;
>       VTDContextCacheEntry context_cache_entry;
> +    VTDPASIDCacheEntry pasid_cache_entry;
>       QLIST_ENTRY(VTDAddressSpace) next;
>       /* Superset of notifier flags that this address space has */
>       IOMMUNotifierFlag notifier_flags;
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 6a168d5107..66f45f89cb 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1607,7 +1607,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_rid2pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>       }
>   
>       return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -3051,6 +3051,135 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>       return true;
>   }
>   
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            VTDPASIDEntry *pe)
> +{
> +    IntelIOMMUState *s = vtd_as->iommu_state;
> +    VTDContextEntry ce;
> +    int ret;
> +
> +    if (!s->root_scalable) {
> +        return -VTD_FR_RTADDR_INV_TTM;
> +    }
> +
> +    ret = vtd_dev_to_context_entry(s, pci_bus_num(vtd_as->bus), vtd_as->devfn,
> +                                   &ce);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return vtd_ce_get_rid2pasid_entry(s, &ce, pe, vtd_as->pasid);
> +}
> +
> +/*
> + * Update or invalidate pasid cache based on the value in memory.

s/the value in memory./the pasid entry in guest memory.

> + */
> +static void vtd_pasid_cache_sync_locked(gpointer key, gpointer value,
> +                                        gpointer user_data)
> +{
> +    VTDPASIDCacheInfo *pc_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +
> +    if (vtd_dev_get_pe_from_pasid(vtd_as, &pe)) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
> +         * to be either all-zero or non-present. Either case means existing
> +         * pasid cache should be invalidated.
> +         */
> +        pc_entry->valid = false;
> +        return;
> +    }
> +
> +    /*
> +     * VTD_INV_DESC_PASIDC_G_DSI and VTD_INV_DESC_PASIDC_G_PASID_SI require
> +     * DID check. If DID doesn't match the value in cache or memory, then
> +     * it's not a pasid entry we want to invalidate.
> +     */
> +    switch (pc_info->type) {
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        if (pc_info->pasid != vtd_as->pasid) {
> +            return;
> +        }
> +        /* Fall through */
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        if (pc_entry->valid) {
> +            did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +            if (pc_info->did == did) {
> +                break;
> +            }
> +        }
> +        did = VTD_SM_PASID_ENTRY_DID(&pe);
> +        if (pc_info->did == did) {
> +            break;
> +        }

hmmm. how about below?

         /*
          * For newly set pasid entry, iommu driver is supposed to
          * invalidate pasid cache with the did configed in pasid entry
          * when caching-mode is reported. Oherwise qemu vIOMMU just skip
          * it.
          */
         if pc_entry->valid) {
             did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
         } else {
             did = VTD_SM_PASID_ENTRY_DID(&pe);
         }

         if (pc_info->did != did) {
             return;
         }

Regards,
Yi Liu
> +        return;
> +    }
> +
> +    pc_entry->pasid_entry = pe;
> +    pc_entry->valid = true;
> +}
> +
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    vtd_iommu_lock(s);
> +    g_hash_table_foreach(s->vtd_address_spaces, vtd_pasid_cache_sync_locked,
> +                         pc_info);
> +    vtd_iommu_unlock(s);
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t did;
> +    uint32_t pasid;
> +    VTDPASIDCacheInfo pc_info = {};
> +    uint64_t mask[4] = {VTD_INV_DESC_PASIDC_RSVD_VAL0, VTD_INV_DESC_ALL_ONE,
> +                        VTD_INV_DESC_ALL_ONE, VTD_INV_DESC_ALL_ONE};
> +
> +    if (!vtd_inv_desc_reserved_check(s, inv_desc, mask, true,
> +                                     __func__, "pasid cache inv")) {
> +        return false;
> +    }
> +
> +    did = VTD_INV_DESC_PASIDC_DID(inv_desc);
> +    pasid = VTD_INV_DESC_PASIDC_PASID(inv_desc);
> +    pc_info.type = VTD_INV_DESC_PASIDC_G(inv_desc);
> +
> +    switch (pc_info.type) {
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        trace_vtd_inv_desc_pasid_cache_dsi(did);
> +        pc_info.did = did;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        /* PASID selective implies a DID selective */
> +        trace_vtd_inv_desc_pasid_cache_psi(did, pasid);
> +        pc_info.did = did;
> +        pc_info.pasid = pasid ?: PCI_NO_PASID;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_GLOBAL:
> +        trace_vtd_inv_desc_pasid_cache_gsi();
> +        break;
> +
> +    default:
> +        error_report_once("invalid granularity field in PASID-cache invalidate "
> +                          "descriptor, hi: 0x%"PRIx64" lo: 0x%" PRIx64,
> +                           inv_desc->val[1], inv_desc->val[0]);
> +        return false;
> +    }
> +
> +    vtd_pasid_cache_sync(s, &pc_info);
> +    return true;
> +}
> +
>   static bool vtd_process_inv_iec_desc(IntelIOMMUState *s,
>                                        VTDInvDesc *inv_desc)
>   {
> @@ -3266,6 +3395,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> +    case VTD_INV_DESC_PC:
> +        trace_vtd_inv_desc("pasid-cache", inv_desc.val[1], inv_desc.val[0]);
> +        if (!vtd_process_pasid_desc(s, &inv_desc)) {
> +            return false;
> +        }
> +        break;
> +
>       case VTD_INV_DESC_PIOTLB:
>           trace_vtd_inv_desc("p-iotlb", inv_desc.val[1], inv_desc.val[0]);
>           if (!vtd_process_piotlb_desc(s, &inv_desc)) {
> @@ -3308,16 +3444,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
>           }
>           break;
>   
> -    /*
> -     * TODO: the entity of below two cases will be implemented in future series.
> -     * To make guest (which integrates scalable mode support patch set in
> -     * iommu driver) work, just return true is enough so far.
> -     */
> -    case VTD_INV_DESC_PC:
> -        if (s->scalable_mode) {
> -            break;
> -        }
> -    /* fallthrough */
>       default:
>           error_report_once("%s: invalid inv desc: hi=%"PRIx64", lo=%"PRIx64
>                             " (unknown type)", __func__, inv_desc.hi,
> @@ -5005,7 +5131,7 @@ static int vtd_pri_perform_implicit_invalidation(VTDAddressSpace *vtd_as,
>           return -EINVAL;
>       }
>       pgtt = VTD_PE_GET_TYPE(&pe);
> -    domain_id = VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +    domain_id = VTD_SM_PASID_ENTRY_DID(&pe);
>       ret = 0;
>       switch (pgtt) {
>       case VTD_SM_PASID_ENTRY_FLT:
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index ac9e1a10aa..298addb24d 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>   vtd_inv_qi_tail(uint16_t head) "write tail %d"
>   vtd_inv_qi_fetch(void) ""
>   vtd_context_cache_reset(void) ""
> +vtd_inv_desc_pasid_cache_gsi(void) ""
> +vtd_inv_desc_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
> +vtd_inv_desc_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
>   vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>   vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>   vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16

