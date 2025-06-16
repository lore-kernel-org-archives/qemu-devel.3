Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 188D2C71135
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Jun 2025 09:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uR6AS-0000Iu-Hb; Mon, 16 Jun 2025 05:30:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uR6AL-0000Ho-9F
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:30:09 -0400
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1uR6AH-0007XK-Ah
 for qemu-devel@nongnu.org; Mon, 16 Jun 2025 05:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750066205; x=1781602205;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=zb7dFLo9Je1Qu+bsCKhJCv38xOyD7UbSbWag2W7rU5Y=;
 b=K/u8qoDsDrfz0gqv3sowEqtJrhIQmyZmwhdWi2CDyL1FxvTEHrstZT3b
 /RmCAyuMM71NpAVosXQndgcPImt+boLrmrPlmaXANz2KwiTfQe9VtU9tO
 KW/YUVxWK9bGTyC6eY5M/z4r6z81Tm72fYdKoJ7MYpzsVigU2hhTZvOTz
 9WVIg9MkuPl7b/StVa0dZv4Z3BR89XLQpfexlR/RcGBFCf9c9VUphS3D9
 y6/UfjMP4GMkygUMQph46sisY1MBpKS17gXRdcomtoqrpnYnHPOxu27wH
 Cn5ZJxVtygjT0v1nc7598pOusVfy3Ardu2i18ZxA7AUTfoYkyLCyx9EBd A==;
X-CSE-ConnectionGUID: X0UwrE3uSfWUEjVgwh0WWQ==
X-CSE-MsgGUID: bh17QOtpSIC0AfP90Q6uEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11465"; a="52121837"
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="52121837"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 02:30:02 -0700
X-CSE-ConnectionGUID: 956rJ28JQQqbsRlWozyAfw==
X-CSE-MsgGUID: Q0kQq7PeSSeZ6dSoT9KWBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,240,1744095600"; d="scan'208";a="171638061"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2025 02:30:01 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 02:30:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 16 Jun 2025 02:30:00 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (40.107.95.46) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 16 Jun 2025 02:29:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hy20oxfWj40CyQvme+6intZ9X92xS35LZEguSFCZ3A5DS3CU134PObl3opI94r57VB8wtxz75HRKML+X3HvZFKUhipWkec8s2zScBlT5zGumE/cJQjk8n/xqGLx6nXMJQtdzxi7ouML7L7iyIHLZkzZUmMYIRRXEr3xZCX1/uoOPBuRR2lpQCkQxc0/x6Y63oikpJ2nnLhlWDf/sceebN3FhS1VzHmZeBfxU/bzGCJn7Ta/2xsEA0CvnrO5+LISZNYqFj1xAUK/6sMHMFM0nN5a10iIQU8RSgWUCZXoHQdP3vuKEPDKf37YuMZNf6FoCaNScCoZWlG+fyKtlfmtI6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGiIOT6AlH1RAjedVpJPlwD8WaVmhlCUEwGo6LD0XGc=;
 b=bf6GMX+n66qlmrLoConqS6R6Hr3BNo9g+NJ/u5a7JCKEn5aMZyoFSi0pu4jhhTrlE+5jlZhW6V0jGqMGeMVeFZ1TCDXw1k5/rCfp5rqsoY4rjrokkIIIQQgVvbyXCAYnMfKrRJ5gifj6X7T3IFeA/uUy9cHQswEfpgEvUHbDuZwMSWzP3Dt8bUPO08BUZkPl9DVnIQCpz+aq2iObAXiaGaKjythgHib7Q75+mFFXLoKvwgFdDopAa9tZ9cYZiqfibMu1WlW+hasezjxpTkwO1uJF142MT/6SqPMFLD7l1MFam6Bhp6v1nIQIKwDeZeEr9NH7ThbrM//dv1IkH2DCew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA0PR11MB7864.namprd11.prod.outlook.com (2603:10b6:208:3df::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 16 Jun
 2025 09:29:57 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 09:29:57 +0000
Message-ID: <ca05ae62-d946-41d8-bd77-60be67a246cc@intel.com>
Date: Mon, 16 Jun 2025 17:36:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
 host
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>, Nicolin Chen
 <nicolinc@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, 
 "shameerali.kolothum.thodi@huawei.com"
 <shameerali.kolothum.thodi@huawei.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "clement.mathieu--drif@eviden.com"
 <clement.mathieu--drif@eviden.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20250521111452.3316354-1-zhenzhong.duan@intel.com>
 <20250521111452.3316354-16-zhenzhong.duan@intel.com>
 <aC5YjHrv5EMDixzZ@Asurada-Nvidia>
 <0f8087f4-0c97-440d-84d2-f3f017f81041@intel.com>
 <aDDk1NYwJXaAdUQI@Asurada-Nvidia>
 <29f5f434-1fe3-4b5e-91d1-f153e1e98602@intel.com>
 <aDSmcvZ08jNOSr05@Asurada-Nvidia>
 <SJ0PR11MB6744340B889FF65D3BD5B8459267A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <f6baaea1-a60c-41dc-a9a8-d2389ed14679@intel.com>
 <IA3PR11MB91365922FBD407DD25E382C39270A@IA3PR11MB9136.namprd11.prod.outlook.com>
 <aE+68E03aAXEynBd@nvidia.com>
 <IA3PR11MB91362B306AA38B1180E3FC5A9270A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <IA3PR11MB91362B306AA38B1180E3FC5A9270A@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA0PR11MB7864:EE_
X-MS-Office365-Filtering-Correlation-Id: 439f0665-2fb5-4ba3-2fe0-08ddacb85bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cU9QT0kwUzF6RW5FNEUxYXBLbnE1MVA0QWhocXpaZ1I2Z2d5ekNoQ2M1bmtj?=
 =?utf-8?B?ZFhMa1hxbjBDSzRJWkJ0ZUdEUTlybzUveHNUMTVjTU51NUlPdFNWSE54dWJH?=
 =?utf-8?B?MXh1ekg0d2JnSWxQZG13eEhSTDBpQk1EZ3ZJUVRxTmFHc2o3VHgzd015U2xn?=
 =?utf-8?B?VUxYakcwcXNmQ1BtYXhKUTg0c2lDR281dGxIanZwelpoMXl4YlFvSEZkMVBm?=
 =?utf-8?B?MGZEN1FCK3d6QVdUM0lDa1dSa0x4aTNNSHk0R3gvZFNuYVo1dS9MMVdpMkhI?=
 =?utf-8?B?bzZwb1VoYlBWTU9XWEZZa0YrMTlFVjgrL2F0bnBZN2Npam5oZ21HOEtKNDQ5?=
 =?utf-8?B?TmxIZVNzQi9JTTk4K0ZXcVZ1Sm1vNmtJUmNoOWxuZ2hWOXRIQkhhbHhZVmR3?=
 =?utf-8?B?SUUvdE1jUEtuVnFJZ1phbmdQQzFjSVcvVTJFc3ppUzZSMi9hK2dITUl3V04w?=
 =?utf-8?B?S1NpVmtyc2dSczZWVzBtdTl6QTJpVkpFa1FrdEVJV2dmc1lZVVdaTEF5M0Zx?=
 =?utf-8?B?L1BWMnpBRVo4ZEx4NXdVQjZrMTI1WEgxOVBwbTZ2OUlJejFRREhXdUkyNWxw?=
 =?utf-8?B?eXRDaXFzZWZrVUhDY0gxUnhtb1ZtRzQzcEx2bG9tQWE3VERwWk8zQ05vNDBl?=
 =?utf-8?B?NGxwdDNINkZ2RWh6UDU3UmVBY200OFBPS20zOG5zZ1AxeitzWTRPYlVEU1NM?=
 =?utf-8?B?V2R5eCtMVUxRZXFPZTl6OElYbVNHUEVjUnJYTURmWkx5UnFoT3g4Y0RaOVdI?=
 =?utf-8?B?c0M4aWE5Qjc4VURTM21SdWorbUtzRU5RZm1NUTdjVXY0MWZESU1LZHVFZUlm?=
 =?utf-8?B?OTVmVWFrUjhnSzBQZGk1R2dmczNRUTFQSHRoc05LVDJZb3l6bmZRTkVsZXZm?=
 =?utf-8?B?Q2ttTVFsa04yOUtHbVpUS1NVVUdEeW1TQ3NRdi92cDRBSDBqSXMvT2pCRjVu?=
 =?utf-8?B?UzM2TlZrUzNTTmJPRDhsTVRvYTFTSm5FVVZyOEljVGkzazIrTnpzQ2dGTEZY?=
 =?utf-8?B?T2dLaCtFdUNYZW5maGhKT082UTh0ODVraG5Gbkljb1Urd3F0R3lZNEZ6bXBY?=
 =?utf-8?B?L0gwRVRITVM2WUhpU1dkNm0xbGF4Q3hFaElrbHhRYU4wYXR3Ym53UW9NdG9D?=
 =?utf-8?B?MU14QXUwdmxvN3lneG8rQnhnMXdRbjFwdTFLMlp6dHNObHMvWjZjbzR5dnpN?=
 =?utf-8?B?WXV5VzRCNUR5T3RGRU9TWkdFd0dmMWdHajdqN1JtM0UvT3M0VUZ3N21ldHVa?=
 =?utf-8?B?bjVERGI3ZHhmTEVTUW03TEh2cjVxSFRGMld5eFhSTVRWZ1VNbk9UMjdLUDNZ?=
 =?utf-8?B?RGx3VWhIVWVMQ0ozb1ErcVdkL0xOYXFDZ25rVnZEUHNpT2xwRE5FbEIyK3pt?=
 =?utf-8?B?THVyZGhzamQwazJEUVRmSE45K1NXcEZaUk5RcGdhaTBSMFBIS2R1OUV5K0Jm?=
 =?utf-8?B?WlZFQTBjMmdIaXNJREpDNTFDcmlMQVhlVm1RTkFTblhKTmpaN3FhOFA3YUx6?=
 =?utf-8?B?Z3BFZ2FGMUZWMjNZT3NTM0o5UkhOVHp4QXI5UmI2TDhISEU1ZlB3TThVWUtZ?=
 =?utf-8?B?VVZFSGhLV1VvcmhXWVNodUV2eUVkTEl6OEt6YUdjRlJEUUZ5RW1yZHY0QXgx?=
 =?utf-8?B?VkNIczVab21GOVpNYTdxYTdRVjMxaWNIQThHMktyZVQ5ekxFU09lSUU2U3Rx?=
 =?utf-8?B?ZVBOcWtXVzRnRHNYMm1yTTZudEhINzh4YzJZZGExNW5hOVVSU0RsNGNPck84?=
 =?utf-8?B?ZGdEdnlUOEp5dnB3STgydldDMkZFNXdtV0NQdVhMMkh0aEVWUFhvVngxb2k4?=
 =?utf-8?B?Yk8wRU02RFN3RmVvVVU2aVJWRnQvOGYyaWluZUtaT29HbG1XQThNaktIK2Jk?=
 =?utf-8?B?azNhNGZ1bEpvSC8zZ01SV2RnYi9yMndmUFBSSWl2VDZQdGc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWUzdGNub2x3NHBBUGpWRzZtZVFQR1JPN1o3OWs1bTBhZjVUTHNLUXFrVFFH?=
 =?utf-8?B?TnV2NUJCbElzR0Joclc5ZUNzTkpBeTIyWk9WQmxRL1FSR2o1WFo0SzhOVjF1?=
 =?utf-8?B?ejZzdUlXTHNUeUZQd256OUk2QW1JcW1UcUhVbkx3QUpNRXhlSnQvYTQ4a21r?=
 =?utf-8?B?KzJkQVdrT2g1MEthTDFiOUNlaFVBQVA4Wm9PeHJGdUhWeXZjQ1lCKy8xZTV4?=
 =?utf-8?B?bTNPWVRpbHE2RGFQMzQ0NW40bjNHSGU5VWpSTVhPeG12RE5FZHRaa1h6RU1t?=
 =?utf-8?B?aGl6ZHVyVUQ3RGhIR25VWXJERGoyMmdKcjhhbkNUYXlLS1lnTnpwVFo4MVdw?=
 =?utf-8?B?UjlNR0JPcGdyamh1Y0l0NTlxcjZxUHJuV004YU1teXkrRTV4UUJ6SmwwTkw2?=
 =?utf-8?B?ekRrZitHQmJvemJlcWxQS0tiVjVXWjR4UE44TjI0dXFaYjJsZDJEWEtUSXJF?=
 =?utf-8?B?T21YMXE0THJkVFlUaUFBcFBQLzVjN0Y5ZXlIZEVYR2IvVEJVKy84WXpFRDdn?=
 =?utf-8?B?L2FUTzNOMEtxWlBCL2YyRlR3cEx0MGc1MFVucUZlM20vVDc1ZDgrTDlIVkNQ?=
 =?utf-8?B?ck1uMVJMTkFNRzNHWWUyc2t3NTdaOXUvNzJ6Z3ZRak1pVjRoSFBGeXA1Wkt4?=
 =?utf-8?B?T2diUm5WWnloVnNoVE11ZTJSL1VVUE1pUDRMMGFVRnUwRG5qQWZvTTY2cTR5?=
 =?utf-8?B?K3RlSEdOTzdtOW9ta1B3TC82d09DUmluWk5vYzhGK0VVODRmdmUzNlR5TTZX?=
 =?utf-8?B?eDJnSHNwWG9ZOXB6ZzZtQUh0enNrMEhNMlBoQ3dPMHluWFhteVA1eVlIWURW?=
 =?utf-8?B?NWdHaUE4bkpWSDkzM0NyRVYrYVZWU09VVlR4THU3T3NkZzdyVFpmRHlZbERn?=
 =?utf-8?B?UDQ4R2U2Q0UzdHVKNnNPcmRxT2p6MFhNekI3d3dOcW5yRm10SXdpM3RzcEda?=
 =?utf-8?B?S21FVUUrM1Vmbk1jbDc5a1Q4NG5JNXpTTkxWTklBUkkwY3NQVzdwamdoejQ4?=
 =?utf-8?B?NzFITkRpaS9iUEhZS2VySEVTY2RQWFBwV3NNY2hWS3lFamZkMk1Oc2VhMlNm?=
 =?utf-8?B?Ri9oU0lrZGlpY2c2MkRXVEUzUXJ5eXhRa0FRSmFxZ0RGcHh6N0d0NTQ1cHhj?=
 =?utf-8?B?bFpKNHZJMEVsUDQzTnp1NUFmbkhpUU5NU0NFVDlhQngrYnJrYkUzYSt6a2tP?=
 =?utf-8?B?OXFvMWVNMyswNkoxYVlxek5CNDFhVmlIN0xmWmFuQ3hIMVlXakVtYk9ta0JQ?=
 =?utf-8?B?YjdDYllDUWFOWEduWHJKU21MTC9BQVdrMVdTOXdqMnVIWW5nT2hHRjFsa0Vw?=
 =?utf-8?B?M0l4MmdCdjF1VTZnanVkT0FwQjJ5bllvOXJ1aXhsQWVaUVlLUTBmVHF5Vnhn?=
 =?utf-8?B?OVJpeDk0SVJFUFZWakZNWWNVL25ERUN6VGx6K3U0dHNHYlpIcDdoWG5pbDA0?=
 =?utf-8?B?L004YUhVYXpiSW54TDdKVzQwSDl2eWQ5aklLNG9BSzlYcFhSeFNjNVdtWXRQ?=
 =?utf-8?B?THZpaDdTZll2dkhWUGxlSHhHYzAzKytHbnM3TzNiOHV6cVFlbzltUHpCdjVi?=
 =?utf-8?B?QktoL1YycG5Bak5MWi9BZXpEa0RCaWFobkxoVmIxNG14MzJndjBJalA3SS91?=
 =?utf-8?B?U2F2S2s4cFJWRG5GT3VCU1RQcGcwL3Y2TkFXOVNpRkdvTyt2RnB0bTFXRjQy?=
 =?utf-8?B?UUwwK3JxRXVRMXRhRjlJVGU4aVNvRnd4QTZWa1FOSzVXNFIzMjgvc1ZHTXdX?=
 =?utf-8?B?MUZpM29kK2NCbjVlY21neTAxVWR6M2VWN3RiQUVGNE9EU3RLWG8vWlAzWUxJ?=
 =?utf-8?B?cDdKS1pHUkVtNXhIRzNiKzZMb3FFZ1Awcld6MW1FaUZoUDNNZ3NkSVBDZnlG?=
 =?utf-8?B?b0RaVFhlcTZQbE9SenBlUE41cHhBbElneVl2ZUwwajRSYTNadS81dzNmZUU1?=
 =?utf-8?B?ZTJwNzRsc2VKcFhRd2VCWTlsS0x0SWNuSHY1c1FTTEkvV2QwYzVUM1RQWjNh?=
 =?utf-8?B?YzU2aGZGcW9FOFdHZjcwR0hrZFQxMGtwZy9BRm5yVzNDSVFhWHJvZi9OME1W?=
 =?utf-8?B?SHUrUFVXVXJGS01ocDFYRjBpT0NLRmROOFEzOEFOdWV1T0FBVndxNEhGSjFt?=
 =?utf-8?Q?tHeGhDO01eZPRSbiJzaeUSFvL?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 439f0665-2fb5-4ba3-2fe0-08ddacb85bfc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 09:29:57.7314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HRHJjhQjzf+nmKbvuBbTICpKPOLe/JwDDPAQVjxkM5+MHJd0CCctO3/OLXXkd5MyvpX8ybThUaFcmIhyIU28qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7864
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
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

On 2025/6/16 16:54, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Nicolin Chen <nicolinc@nvidia.com>
>> Subject: Re: [PATCH rfcv3 15/21] intel_iommu: Bind/unbind guest page table to
>> host
>>
>> On Mon, Jun 16, 2025 at 03:24:06AM +0000, Duan, Zhenzhong wrote:
>>> Hi @Liu, Yi L @Nicolin Chen, for emulated/passthru devices
>>> behind the same pcie-pci bridge, I think of an idea, adding
>>> a new PCI callback:
>>>
>>> AddressSpace * (*get_address_space_extend)(PCIBus *bus,
>>> void *opaque, int devfn, bool accel_dev);
>>>
>>> which pass in real bus/devfn and a new param accel_dev which
>>> is true for vfio device.
>>
>> Just =y for all vfio (passthrough) devices?
>>

TBH. It's a bit hacky to me in concept. It may be more cleaner to detect
and block such topology.

BTW. @Nic, I suppose nesting vSMMUv3 does not have this concern since
you will put the passthru devices under a separate vIOMMU which should
ensure that the emulated devices won't share AS with passthrough device.
right?

>> ARM tentatively does this for get_address_space using Shameer's
>> trick to detect if the device is a passthrough VFIO one:
>>
>>     PCIDevice *pdev = pci_find_device(bus, pci_bus_num(bus), devfn);
>>     bool has_iommufd = !!object_property_find(OBJECT(pdev), "iommufd");
>>
>>     if (smmu->nested && ... && has_iommufd) {
>>         return &sdev->as_sysmem;
>>     }
>>
>> So, I guess "accel_dev" could be just:
>>     !!object_property_find(OBJECT(pdev), "iommufd")
>> ?
> 
> You are right, we don't need param accel_dev. Below should work:
> 
> object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)
> 
>>
>>> Vtd implements this callback and return separate AS for vfio
>>> device if it's under an pcie-pci bridge and flts=on;
>>> otherwise it fallback to call .get_address_space(). This way
>>> emulated devices and passthru devices behind the same pcie-pci
>>> bridge can have different AS.
>>
>> Again, if "vfio-device" tag with "iommufd" property is enough to
>> identify devices to separate their address spaces, perhaps the
>> existing get_address_space is enough.
> 
> We need get_address_space_extend() to pass real BDF.
> get_address_space pass group's BDF which made pci_find_device return wrong device.
>
>>
>>> If above idea is acceptable, then only obstacle is ERRATA_772415,
>>> maybe we can let VFIO check this errata and bypass RO mapping from
>>> beginning?
>>
>> Yes. There can be some communication between vIOMMU and the VFIO
>> core.
>>
>>> Or we just block this VFIO device running with flts=on if
>>> ERRATA_772415 and suggesting running with flts=off?
>>
>> That sounds like a simpler solution, so long as nobody complains
>> about this limitation :)
> 
> I plan to apply this simpler solution except there is objection, because
> I don't want to bring complexity to VFIO just for an Errata. I remember
> ERRATA_772415 exists only on old SPR, @Liu, Yi L can correct me if I'm wrong.

hmmm. I'm fine to pass some info to vfio hence let vfio skip RO mappings.
Is there other info that VFIO needs to get from vIOMMU? Hope start adding
such mechanism with normal requirement. :)

-- 
Regards,
Yi Liu

