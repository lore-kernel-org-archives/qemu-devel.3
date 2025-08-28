Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AEDC8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 12:00:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urbHj-0004Pv-6e; Thu, 28 Aug 2025 07:59:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urbHg-0004ON-TS
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:59:16 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1urbHe-0004Q2-4Y
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756382354; x=1787918354;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=GcpGTMJ2nvXHy4zA0dPWEjbk1W4EJ84bGoBRVWI2gBs=;
 b=DaW4+y/xn+fuBfOTSnc30KzZI+KptUiM/VXXpC4y5J/1dWKvT/uUmVrC
 z2mGthwn3fTxxz4lh4SMMQkgje1I9zRFI5I9J/H7aDfTpjjL2Z6zR0iY4
 iGSXC5xlk0cjN0/DFX0Pv08Z44LqYTJHwpoDe6jA1mTKAcsSld2xjXEhn
 EpVEiFZOPyaUR9bj+tFw1iXFOi1vB0lIEQoRRUUDbcBqDDzmT5YtBpR7A
 /4pLaqvNIODszCe/vTzk7dYLqyBiYeFmey9iukMnDCY1bSpdHtM1P+qW6
 ew3WILvlLt1WDkmgN6MxI7zrV1uFCrj8B3VKxs/DF1qquXw5Yt3749Coo w==;
X-CSE-ConnectionGUID: X6TpgkgdQMSmFm+qjvgGhg==
X-CSE-MsgGUID: k+ao4VlqRVOtSKR0HnIBxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="58573706"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; d="scan'208";a="58573706"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 04:59:11 -0700
X-CSE-ConnectionGUID: 4x+CjFNaRmm0XZN+VeFF1g==
X-CSE-MsgGUID: 8PjuSzxeRemGDi1sNNEJJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; d="scan'208";a="170483583"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Aug 2025 04:58:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:58:59 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 28 Aug 2025 04:58:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.89) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 28 Aug 2025 04:58:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UCQQsd07HiGkU7k2Z0qkQMeQMt815YEDXG/CvbDFsbxT6ItmYCZbS5r+yD7dSa4oGAny1INr4yBD/TR6MpIgvTlM65q1FYi2kyXL1lpwmE1cTBOEp5YpOj6xYpyNdcAr1nrGcNDGlPDUFaekcvf5LMU69mzZdSOfAFD+V4i8/P5ap5n3H4SI7PLA9H169hp8r+ebj70QoQy7IgEijgKBSAJrbHWlQImpGlE2TOvNxjSEt5zYzBMUFIv3zXZXben26WgJBXUFUu1Lbaw/ZKzjBFJvLtN6ss1p3isRqVuLOH8KecycUyRKxdxQmF8hlhp/F68zUlJGz7CTguU4kDGbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHsl5ETRBFXk001Qi6cYJcuaQzQIIAo0s3bNyry1m08=;
 b=lWsLCEK/UjPi7N4DJfYX44y4CjPlcMo3FqQfJGQ140haPcdXrRZju5ZJO3KtPt7yMlERIzox+b+mmb1yywmPQVvvOJFZrmsPgJiWx5ny07cMyziR1CUaLMbXSUFyVvpzzbhzGmBmlcFz1xQXBZqZoCvvfdZIkOrZOsz9FabrJfOtO1aKHTWAFvOjiXwIL+c9Y4gwjYxnl4YM26D9x6Z0muj89YbnZteqDMB151WsndpEteZS0vjzy+MlAeNb5owiOua0OhgGUFoLTewGlX1WJZfJKL16CNuVofu1JHssD/2/EGEBAUTysOkUZkrphiQ0flDh+SJQQC0tc/rh2D1jNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB3974.namprd11.prod.outlook.com (2603:10b6:a03:183::29)
 by SJ5PPF1A7C623DA.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::816) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 11:58:51 +0000
Received: from BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396]) by BY5PR11MB3974.namprd11.prod.outlook.com
 ([fe80::fe0b:26f7:75b4:396%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 11:58:51 +0000
Message-ID: <5ccc7892-2024-409b-b107-4ffa02e31b71@intel.com>
Date: Thu, 28 Aug 2025 20:05:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/21] intel_iommu: Handle PASID entry removal and
 update
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <joao.m.martins@oracle.com>, <clement.mathieu--drif@eviden.com>,
 <kevin.tian@intel.com>, <chao.p.peng@intel.com>, Yi Sun
 <yi.y.sun@linux.intel.com>
References: <20250822064101.123526-1-zhenzhong.duan@intel.com>
 <20250822064101.123526-12-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250822064101.123526-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To BY5PR11MB3974.namprd11.prod.outlook.com
 (2603:10b6:a03:183::29)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB3974:EE_|SJ5PPF1A7C623DA:EE_
X-MS-Office365-Filtering-Correlation-Id: f04f4643-add1-4eb3-6dda-08dde62a4104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|42112799006; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0tVcTlNU2plRVNzSmt5R0VmSVJRZGgzV005SXV0MWo2WCs0alp5NGllMldl?=
 =?utf-8?B?NFlzenE2WWsxRWlJTUlnVWloempHUXBxWC9YcEttOEpPRm1tQXArVzJvYUdq?=
 =?utf-8?B?TGFpQTFJUFNSdjl2K04wOGFnVytCc1RqVHF1Yzc5eWVac2RJMFBHanF4WTVk?=
 =?utf-8?B?cUxSOTVLN0JvN1JUT0hVR3lyWXFadExLZm9UbkFXZHRhSnB4RVBiSHdIU21L?=
 =?utf-8?B?eTBXSUdjbEZnbHg5dEk1cUdsa3g5STZOUmovbW04Zm1NK2llNllJblp4RCta?=
 =?utf-8?B?MGFhYk8vL3RqdmlIMUdLMEV6WXZIUDRibVdaOVJqc2ErZ2c5YVcyWTZQdVAx?=
 =?utf-8?B?S2F4K3NqNFR6VVhiK3dvN3NBNEtIeXFXY05rM3VWNFlYWXZxRVBveWxpM1lk?=
 =?utf-8?B?WGQ0MzVBcHUyRmtQYnNXV2pvclZ1TGJmVTF6ZE13TkFEWDArNzU4OU5NcDlI?=
 =?utf-8?B?OEMxTndPS0NQRW9PTGt0TkhlVjlKZFBLelNzVzFZRjE1UUF1UzltNmlIMkU2?=
 =?utf-8?B?TGI5YUJGM1k3ZHhsb0p5bjhabWhhZVRnam5iS2ppalRCNmtjMGpHZm9OeXJ1?=
 =?utf-8?B?aXE2TG1SbUJPSkh1YkJGMEZiK0xBSlppY3lTV0lxY1dremwwalAvZWoyRnI4?=
 =?utf-8?B?WlVNYWNIUmdEQ0pzNDJDU1pHNzBjWU04VWNNRFhEaHF5d0IxUExLUUdPOXRk?=
 =?utf-8?B?dThqTGd0VDhNa3RBQ014RU9vYVhQeDVCeUo1VVNuQ3ZSMHRUZ09DckRzUGpJ?=
 =?utf-8?B?ZE9aZ0tTbFpPOUJITm1QUTA5cjhRT050bVd2dFFaZjRYU3JrQ3NuU2J4WjNq?=
 =?utf-8?B?aXNsR2FXb1pqa0swTjYrWEFYaUJKWkY3bksvMFIrcWkwVmltK3hGcTZ2WStH?=
 =?utf-8?B?NnBWZmppQThmZTFWb244RWtZRXJDM3pxbDBzeGRWYnhJTU1VcUpoQnRBUVBC?=
 =?utf-8?B?MUhGK1RTR2ZjNnlHMGpmZER0aXdBSG9CeGxDMGd2N3BhSjNyNWRYUkpZTGln?=
 =?utf-8?B?d2ZmaVhBdXJ1YmN1Q1hNODFLUFNwWEUxMWkyTlRuYS8wc2t2ZU5oQ2NrdjhD?=
 =?utf-8?B?Y2svUkRPQzFoV2dxUjYvbnY1Q3U3VFBWVUUvcCtrMTJoTDQzS0VMQ1V6M3Vi?=
 =?utf-8?B?ZGYxek45M3dpNzFVNEV2QWNneXgwSmx1YThpaytISEFESFdXcy9hTWo0WU1h?=
 =?utf-8?B?RVowQllrUkZMSnIvNTVmRW0xNzFHUzF5TkQzRStwNTBiamlmQ2tZUklEbnZa?=
 =?utf-8?B?OFRUZnJDbHd0dTBGbElIUHU3NmRiY2h6QlJsUmRDakZCVjQzRHUzdkc4a2ZR?=
 =?utf-8?B?TTFHOWhGcDd5Y0VPSUtpMDgxWFZNT0R5YjU1bExjQ0szczl0dlpISkZIWnIy?=
 =?utf-8?B?ODdjcVl1NXU1WGxpRXNhemNJaHEzRW9IbTZEcVNuUTVva3o3a093ZURBMHl0?=
 =?utf-8?B?Vzl2N3JDenpzUzgreUN0S0UrVTNvSU9TYmg3eDNOSWNMUVlzUWpWQmwxNXBW?=
 =?utf-8?B?OEJjbVdMa21OQ2hXTE85N2w5M2h3T05nWEdaU3ZGOWtHVFRDVndlb0dPVWN2?=
 =?utf-8?B?ZGpNWEdOM2x0UnVrWmdsV1U5cUVKKytxYzhLcEVJTnJ0QWd3SExETktwMDBt?=
 =?utf-8?B?UXRmTmJ3L2c0VE1PQW1tTTZhT0Mvd3BFUnJ1VjBGWENoazZsdnVmSGNTY0Zv?=
 =?utf-8?B?cWszMmltNSt0K2VSTUdUbUdMaGhHQmdQTkhZS2ZjNnNDR1RFeXNnQjVrMStn?=
 =?utf-8?B?SUU4TVFEamFaamZURUFFRitEVGZMbTFnaW93eHhYM2xJZUU2L0grcDNmckxo?=
 =?utf-8?B?SS9XTjh1TWJCWUxPcXVscHR5Ym43OFpuVlE1Rm5oNW9hWGpnenBpdWZqMXpu?=
 =?utf-8?B?amZ4S1VQRGlQMnVDUEYrSGRpYk44TWNNS1NpODQ1TEF0NzljUGVUZzBOUEc5?=
 =?utf-8?Q?fzMcfzfivro=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR11MB3974.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(42112799006); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZRU29pUVVLREljMkVhZlUvamdCSERDZU1SVGh0SldHZ3RlU1I1VW5LOW13?=
 =?utf-8?B?YnNnSHZCQThjS0hjeGFWWW9TYS9FTzNqVVhmaERLbERHT3gxa0o4cytKM0hK?=
 =?utf-8?B?Um4zS1lXbXdiWG5za3F3bWx2a1l1WTNGb01KTlFTWE1aTnhaemFGaXgrMm9E?=
 =?utf-8?B?VGZ2YU5zSGZnQVV0R2NINnEyalplOXFHdmNqcG4zVzZlTkcwY0hKcUs0YmFX?=
 =?utf-8?B?eVprVDVmbUgvcFk2SjZ1VFhMdXRvUHBrUDlhZ2w2RXBqQ1FGUTYxbE1ET254?=
 =?utf-8?B?QTlHVFVVMEhNemhkVUtOTXprN3VMZHUraWViWkdSTHNYTHRENXlkM1lGZDFt?=
 =?utf-8?B?MjQvdW9kczlTeXNiKzJCUFNRYzl1aWR0TTJNc3NjZld1NzMxNXlNNFhtc2NS?=
 =?utf-8?B?L09vL2V5eXQ4NW9YRVVwNkNjTEpmUDhjSlJ1dEt2dCtiSkVBMVZrUGxQOGhr?=
 =?utf-8?B?aktvdXQ1eTV4ZHE1SkpQZlhyRVliRjhmbWlPOFVNTEQxdTA4b3ZxWXptaTNK?=
 =?utf-8?B?bThOTU5pS2tpOHcydlZQeFd6akhQU1hqZ2JUVlpOQ09va1d6dFUzWWRRNy9z?=
 =?utf-8?B?UnJwV3pMOWRxajN5WnltOS9OMmJrVUtQaU5kSE96SWkrS1lhUWxCNHhNNDM2?=
 =?utf-8?B?TXZjOVpPYjMxTFRuYVh2ZkRXQXFtQVc2TTZHOGZZcllTOWZqYTZwdVQzSE1w?=
 =?utf-8?B?Y1l6NHZkUVRmMFpPcCs4OGFXWHV2SjIzdnFmcXJqZVhBR1I2bDZQcTEvZWRn?=
 =?utf-8?B?UUFtVTBKK0dlMUZqZERpb0pwWjVESGlqMnhmWmc2dm1ZZXQ4bTBBbEY2cE5Q?=
 =?utf-8?B?WjBLbFowY1kzd2JuNHpESVlyY2s3UlN2UTdJdVFZRVZkM2M2NlJucTlPS01M?=
 =?utf-8?B?c2hiZ1djK3lSQjNRVVB4U2VpZHdPN0RxbElLSC9BeHp5bmNSVDBEOTQ3ZnUz?=
 =?utf-8?B?MDJ6R3lPMW5Ma3o5bVM4U2d3NENJeXMvSGRqNHBFU0FwemdJcnNxQmxoOGN5?=
 =?utf-8?B?S29ZYTJJOUJubTROOXlNWnA0amlyM0hIallKU1lscGw0cnN1MDB4WnVvWHpQ?=
 =?utf-8?B?M0g5TnJPaEx0UWovdFlCTHFyakJKOUoxZE9zdVRXQkFtbXpGWE9uV2JGYzFL?=
 =?utf-8?B?KzdUayt1aW9JcWd5YWlsT0xnNmFwMWpyaks4NkFNSlZPNUpvVFhwYzlCaVJE?=
 =?utf-8?B?Z2oxSU43VWpaZ2hGejZJUy9Jek8yZTB6amZDNVRZQXNYRGNVNkErZUlmME9y?=
 =?utf-8?B?YkcwRVlMcmNRcFduNi9IbUJHek5DNFlXTDY4SE5NdEJsdWxhcDY3VHNocW9F?=
 =?utf-8?B?anlsYld0WFA4UFQvV3BvbkppT3ViYkJIc1J2V1VlK0NQQzBVYTBLT3pGWU1v?=
 =?utf-8?B?N25jSWJvV281enRIdEppKzJ3T0UzWXZuT3kycWFONDZtSWFiaVpmcnF3VHY4?=
 =?utf-8?B?b3R6RzdXakVKbThsSUtiVTg0YmpibHUwNjgrUTlyb3R3TytOd1IvZFFEeFh6?=
 =?utf-8?B?UTM4R2RvajVCa0RDUThoRDVVS2JxenNNZmRsdXA5a0toS0JPOFR5bkI2dlhI?=
 =?utf-8?B?T1BmbjRvNFFKc0ZBTFlYVldRYVBoQXloWHhHZjJuVzNqc1d4R1BLZEQ3Z05p?=
 =?utf-8?B?Tkd1UnV3R01YbnhVTEU2Y29CcjdtSWJyQUgybkhFc21USURTSUxjMlB4OGFN?=
 =?utf-8?B?V3hQSGpoN1oyYk9IZGxPWXF6YitnMkgxME5ZZisyaFdhOXo4ZGo0akZUckRQ?=
 =?utf-8?B?VHl3T3R6M0Jzc2Vtci92dnQ5anZSZGlrRVpnNUhmY1BjQkZKNDk4bTZiRXBq?=
 =?utf-8?B?VnF3SXRHVjZnNFFXMkNjUTZ6S0R6UFVoSnVCcnVKS2svVmRNV1hlOW1WdW40?=
 =?utf-8?B?RHE3RzUwcmlpUm1IWE5wRGhkRmQ1V3JjZmhLOXl2NEFzTXpKRzBrZXpLSlVs?=
 =?utf-8?B?Rm9la3ljOWFoc29BSzBpQlFtYWFEeGtIcWlDWVcycHNMVUNLQm1uV1ZiMTBF?=
 =?utf-8?B?UjRuUWt1ZkMwNnJrelArK0l6RXNyUEdYT0dpbXBBWE9vTmMxM0wwRXFyelRs?=
 =?utf-8?B?WWQ4QnYxcktsbnlSUVJrZnMxL1JJQXVVeDZRWDVpVWIwNEw4L3hmTGE3VFlD?=
 =?utf-8?Q?SbV5PsGxKufc7NE/++WxJs1Cj?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f04f4643-add1-4eb3-6dda-08dde62a4104
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB3974.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 11:58:51.1435 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SsZ9IN6BkXr6IN0Ly99aJ2fHEPH8CHbEKnFrd/CyPkZ3haV8/sgAnPJDwDHPNM0Si2VdjRNmwwVINdCIkV6pDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF1A7C623DA
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
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

On 2025/8/22 14:40, Zhenzhong Duan wrote:
> This adds an new entry VTDPASIDCacheEntry in VTDAddressSpace to cache the
> pasid entry and track PASID usage and future PASID tagged DMA address
> translation support in vIOMMU.

Have you seen any extra code needed based on this series to support non 
rid_pasid PASIDs? If no, may just relax the scope of this series.
otherwise, you may need to tweak the patch a little bit. e.g. factor
out setting x-flts and x-pasid-mode at the same time.

> 
> VTDAddressSpace of PCI_NO_PASID is allocated when device is plugged and
> never freed. For other pasid, VTDAddressSpace instance is created/destroyed
> per the guest pasid entry set up/destroy.

> When guest removes or updates a PASID entry, QEMU will capture the guest pasid
> selective pasid cache invalidation, removes VTDAddressSpace or update cached
> PASID entry.
> 
> vIOMMU emulator could figure out the reason by fetching latest guest pasid entry
> and compare it with cached PASID entry.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  27 ++++-
>   include/hw/i386/intel_iommu.h  |   6 +
>   hw/i386/intel_iommu.c          | 196 +++++++++++++++++++++++++++++++--
>   hw/i386/trace-events           |   3 +
>   4 files changed, 220 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index f7510861d1..b9b76dd996 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -316,6 +316,7 @@ typedef enum VTDFaultReason {
>                                     * request while disabled */
>       VTD_FR_IR_SID_ERR = 0x26,   /* Invalid Source-ID */
>   
> +    VTD_FR_RTADDR_INV_TTM = 0x31,  /* Invalid TTM in RTADDR */
>       /* PASID directory entry access failure */
>       VTD_FR_PASID_DIR_ACCESS_ERR = 0x50,
>       /* The Present(P) field of pasid directory entry is 0 */
> @@ -493,6 +494,15 @@ typedef union VTDInvDesc VTDInvDesc;
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
>   /* Information about page-selective IOTLB invalidate */
>   struct VTDIOTLBPageInvInfo {
>       uint16_t domain_id;
> @@ -553,6 +563,21 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL0(aw)  (0x1e0ULL | ~VTD_HAW_MASK(aw))
>   #define VTD_SM_CONTEXT_ENTRY_RSVD_VAL1      0xffffffffffe00000ULL
>   
> +typedef enum VTDPCInvType {
> +    /* VTD spec defined PASID cache invalidation type */
> +    VTD_PASID_CACHE_DOMSI = VTD_INV_DESC_PASIDC_G_DSI,
> +    VTD_PASID_CACHE_PASIDSI = VTD_INV_DESC_PASIDC_G_PASID_SI,
> +    VTD_PASID_CACHE_GLOBAL_INV = VTD_INV_DESC_PASIDC_G_GLOBAL,
> +} VTDPCInvType;
> +
> +typedef struct VTDPASIDCacheInfo {
> +    VTDPCInvType type;
> +    uint16_t did;
> +    uint32_t pasid;
> +    PCIBus *bus;
> +    uint16_t devfn;
> +} VTDPASIDCacheInfo;
> +
>   /* PASID Table Related Definitions */
>   #define VTD_PASID_DIR_BASE_ADDR_MASK  (~0xfffULL)
>   #define VTD_PASID_TABLE_BASE_ADDR_MASK (~0xfffULL)
> @@ -574,7 +599,7 @@ typedef struct VTDRootEntry VTDRootEntry;
>   #define VTD_SM_PASID_ENTRY_PT          (4ULL << 6)
>   
>   #define VTD_SM_PASID_ENTRY_AW          7ULL /* Adjusted guest-address-width */
> -#define VTD_SM_PASID_ENTRY_DID(val)    ((val) & VTD_DOMAIN_ID_MASK)
> +#define VTD_SM_PASID_ENTRY_DID(x)      extract64((x)->val[1], 0, 16)
>   
>   #define VTD_SM_PASID_ENTRY_FLPM          3ULL
>   #define VTD_SM_PASID_ENTRY_FLPTPTR       (~0xfffULL)
> diff --git a/include/hw/i386/intel_iommu.h b/include/hw/i386/intel_iommu.h
> index 50f9b27a45..0e3826f6f0 100644
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
> index 1801f1cdf6..a2ee6d684e 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1675,7 +1675,7 @@ static uint16_t vtd_get_domain_id(IntelIOMMUState *s,
>   
>       if (s->root_scalable) {
>           vtd_ce_get_pasid_entry(s, ce, &pe, pasid);
> -        return VTD_SM_PASID_ENTRY_DID(pe.val[1]);
> +        return VTD_SM_PASID_ENTRY_DID(&pe);
>       }
>   
>       return VTD_CONTEXT_ENTRY_DID(ce->hi);
> @@ -3112,6 +3112,183 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>       return true;
>   }
>   
> +static inline int vtd_dev_get_pe_from_pasid(VTDAddressSpace *vtd_as,
> +                                            uint32_t pasid, VTDPASIDEntry *pe)
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
> +    return vtd_ce_get_pasid_entry(s, &ce, pe, pasid);
> +}
> +
> +static bool vtd_pasid_entry_compare(VTDPASIDEntry *p1, VTDPASIDEntry *p2)
> +{
> +    return !memcmp(p1, p2, sizeof(*p1));
> +}
> +
> +/*
> + * This function is a loop function which return value determines if
> + * vtd_as including cached pasid entry is removed.
> + *
> + * For PCI_NO_PASID, when corresponding cached pasid entry is cleared,
> + * it returns false so that vtd_as is reserved as it's owned by PCI
> + * sub-system. For other pasid, it returns true so vtd_as is removed.

also, this helper will always return true if this series does not
support non-rid_pasid PASID.

> + */
> +static gboolean vtd_flush_pasid_locked(gpointer key, gpointer value,
> +                                       gpointer user_data)
> +{
> +    VTDPASIDCacheInfo *pc_info = user_data;
> +    VTDAddressSpace *vtd_as = value;
> +    VTDPASIDCacheEntry *pc_entry = &vtd_as->pasid_cache_entry;
> +    VTDPASIDEntry pe;
> +    uint16_t did;
> +    uint32_t pasid;
> +    int ret;
> +
> +    if (!pc_entry->valid) {
> +        return false;
> +    }
> +    did = VTD_SM_PASID_ENTRY_DID(&pc_entry->pasid_entry);
> +
> +    if (vtd_as_to_iommu_pasid_locked(vtd_as, &pasid)) {
> +        goto remove;
> +    }
> +
> +    switch (pc_info->type) {
> +    case VTD_PASID_CACHE_PASIDSI:
> +        if (pc_info->pasid != pasid) {
> +            return false;
> +        }
> +        /* fall through */
> +    case VTD_PASID_CACHE_DOMSI:
> +        if (pc_info->did != did) {
> +            return false;
> +        }
> +        /* fall through */
> +    case VTD_PASID_CACHE_GLOBAL_INV:
> +        break;
> +    default:
> +        error_setg(&error_fatal, "invalid pc_info->type for flush");
> +    }
> +
> +    /*
> +     * pasid cache invalidation may indicate a present pasid entry to present
> +     * pasid entry modification. To cover such case, vIOMMU emulator needs to
> +     * fetch latest guest pasid entry and compares with cached pasid entry,
> +     * then update pasid cache.
> +     */
> +    ret = vtd_dev_get_pe_from_pasid(vtd_as, pasid, &pe);
> +    if (ret) {
> +        /*
> +         * No valid pasid entry in guest memory. e.g. pasid entry was modified
> +         * to be either all-zero or non-present. Either case means existing
> +         * pasid cache should be removed.
> +         */
> +        goto remove;
> +    }
> +
> +    /*
> +     * Update cached pasid entry if it's stale compared to what's in guest
> +     * memory.
> +     */
> +    if (!vtd_pasid_entry_compare(&pe, &pc_entry->pasid_entry)) {
> +        pc_entry->pasid_entry = pe;
> +    }
> +    return false;
> +
> +remove:
> +    pc_entry->valid = false;
> +
> +    /*
> +     * Don't remove address space of PCI_NO_PASID which is created for PCI
> +     * sub-system.
> +     */
> +    if (vtd_as->pasid == PCI_NO_PASID) {
> +        return false;
> +    }
> +    return true;
> +}
> +
> +/*
> + * For a PASID cache invalidation, this function handles below scenarios:
> + * a) a present cached pasid entry needs to be removed
> + * b) a present cached pasid entry needs to be updated
> + */
> +static void vtd_pasid_cache_sync(IntelIOMMUState *s, VTDPASIDCacheInfo *pc_info)
> +{
> +    if (!s->flts || !s->root_scalable || !s->dmar_enabled) {
> +        return;
> +    }
> +
> +    vtd_iommu_lock(s);
> +    /*
> +     * a,b): loop all the existing vtd_as instances for pasid cache removal
> +       or update.
> +     */
> +    g_hash_table_foreach_remove(s->vtd_address_spaces, vtd_flush_pasid_locked,
> +                                pc_info);
> +    vtd_iommu_unlock(s);
> +}
> +
> +static bool vtd_process_pasid_desc(IntelIOMMUState *s,
> +                                   VTDInvDesc *inv_desc)
> +{
> +    uint16_t did;
> +    uint32_t pasid;
> +    VTDPASIDCacheInfo pc_info;
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
> +
> +    switch (VTD_INV_DESC_PASIDC_G(inv_desc)) {
> +    case VTD_INV_DESC_PASIDC_G_DSI:
> +        trace_vtd_pasid_cache_dsi(did);
> +        pc_info.type = VTD_PASID_CACHE_DOMSI;
> +        pc_info.did = did;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_PASID_SI:
> +        /* PASID selective implies a DID selective */
> +        trace_vtd_pasid_cache_psi(did, pasid);
> +        pc_info.type = VTD_PASID_CACHE_PASIDSI;
> +        pc_info.did = did;
> +        pc_info.pasid = pasid;
> +        break;
> +
> +    case VTD_INV_DESC_PASIDC_G_GLOBAL:
> +        trace_vtd_pasid_cache_gsi();
> +        pc_info.type = VTD_PASID_CACHE_GLOBAL_INV;
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
> @@ -3274,6 +3451,13 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
> @@ -3309,16 +3493,6 @@ static bool vtd_process_inv_desc(IntelIOMMUState *s)
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
> diff --git a/hw/i386/trace-events b/hw/i386/trace-events
> index ac9e1a10aa..ae5bbfcdc0 100644
> --- a/hw/i386/trace-events
> +++ b/hw/i386/trace-events
> @@ -24,6 +24,9 @@ vtd_inv_qi_head(uint16_t head) "read head %d"
>   vtd_inv_qi_tail(uint16_t head) "write tail %d"
>   vtd_inv_qi_fetch(void) ""
>   vtd_context_cache_reset(void) ""
> +vtd_pasid_cache_gsi(void) ""
> +vtd_pasid_cache_dsi(uint16_t domain) "Domain selective PC invalidation domain 0x%"PRIx16
> +vtd_pasid_cache_psi(uint16_t domain, uint32_t pasid) "PASID selective PC invalidation domain 0x%"PRIx16" pasid 0x%"PRIx32
>   vtd_re_not_present(uint8_t bus) "Root entry bus %"PRIu8" not present"
>   vtd_ce_not_present(uint8_t bus, uint8_t devfn) "Context entry bus %"PRIu8" devfn %"PRIu8" not present"
>   vtd_iotlb_page_hit(uint16_t sid, uint64_t addr, uint64_t slpte, uint16_t domain) "IOTLB page hit sid 0x%"PRIx16" iova 0x%"PRIx64" slpte 0x%"PRIx64" domain 0x%"PRIx16

