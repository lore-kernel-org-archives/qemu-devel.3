Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0931D29DC4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 03:06:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfUj7-0007Gb-L1; Mon, 12 Jan 2026 22:05:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vfUj5-0007ET-AY
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:05:47 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1vfUj3-00069L-04
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:05:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768273545; x=1799809545;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=jqJUnkup8ffGI7jWbO0VG5Q5+43Z6HYAkpFh0TFTA1c=;
 b=SFmLhuwoZeptMr3r7k7sCIulP/EIU+GkbWLK7M5dunYrdIeDck2rUqSK
 qgLLcKSRjUwF6H+XO/ZIJpSae1fp8wNwvYPir+UqchGUdgVyvjpdVfr+6
 79eLf5dI54N7AT/oiefdLhZbircDUL88IhDBc1tNnfmDmR12Er0vwGgpB
 hb+jawL5YjTiCIZIhX+p2g8Kopq8KOSR+Tsgc5s3/9TmjbgLTUlVmPbjW
 +AMZNJfPZrCy0sQvpfA/j+ZBpWJptDG7z2zzgzoCe3DDSg0N4mlmGVJ7t
 UG4kEqmVzHFcx/i3+FI+mdFXFw2SXTi8PFsd+5pxffvVL355dD1bFnLF8 w==;
X-CSE-ConnectionGUID: JiZfaIooQ7+8W1m3BuzyTQ==
X-CSE-MsgGUID: ziOEF+ZVTHmLihTd39I85g==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="69632022"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="69632022"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 19:05:40 -0800
X-CSE-ConnectionGUID: Euh73E65TTCHkkRRKd7EYg==
X-CSE-MsgGUID: 5xcRvotnSQulzsONGm3HaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; d="scan'208";a="204352644"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jan 2026 19:05:40 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:05:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 19:05:39 -0800
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.32) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 19:05:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h56XZMzh5W0qJqk+P373EjyayIs01uI9X6sg0QgkYXNCH1j/7NAVLMRwuqPTmzENIn8GVaKdnu1gFnLJ3SfzCIDNK/b7Aovzl5prPtBq1O1IjdyxNP6IePh5pAi2oP7mRA4Cnynve+1aKkwqbgLe1Z8XKqi82HtJaPVG/gvtMJgHmjySpBT9q8q8PzB9uDf3uXYvaXcXEIe6T4uTsN2CdyKsik0m6KLNrI+UGjNvjzDTQTmsRT4dLFZuP1w3DmOdAjnIb0WLpiolCx4TYDiGz0DUqnNoL83rpwAnR3QC8wTuQ4cO8dZsiEZv+9qiVGsPIChvOQUS02sx9KiKfPLVvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trljA4x5sx9NeRVK0CXALfgVitAZoBHkZvwokbsC2Og=;
 b=pzK4LOy86BdYLUXMy+phN4wsoLpzgytK+ryYQ7Lg6Jz5gip74JyU+tBrSDcoeOl1JWVK20yyv13/RdHD/gfr1ePMxK9OtDo7J8uIE1IbxZcahug8zJI6X13+mFlY+KivSOeKlR8Y+QRug7iF4LFFy+Hgd5uv1G+4KyBz0lKTcLAy+6k23YxVt7Wa6bDf+Q6l7VNHO7DhGFQPTazVavhlP5Gv/vyWXP50vw21+/l/H8m+1VTsEp3nuHHcEdxkJOn3KLoqU/qm7YKFDVTk7PJn/t0dq2Mke8xvoCrBdx9RY/XDt59LlFUG40aphQFKV1BDkHnMQfEqXkm4IwTaTteN5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DM6PR11MB4530.namprd11.prod.outlook.com (2603:10b6:5:2a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 03:05:37 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::2e98:2a3a:ea82:c1bb%3]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 03:05:37 +0000
Message-ID: <b0f03396-217b-4d34-8677-9e541d3af7f4@intel.com>
Date: Tue, 13 Jan 2026 11:12:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 09/19] intel_iommu_accel: Check for compatibility with
 IOMMUFD backed device when x-flts=on
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex@shazbot.org>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <jasowang@redhat.com>, <peterx@redhat.com>,
 <ddutile@redhat.com>, <jgg@nvidia.com>, <nicolinc@nvidia.com>,
 <skolothumtho@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>
References: <20260106061304.314546-1-zhenzhong.duan@intel.com>
 <20260106061304.314546-10-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260106061304.314546-10-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:194::16) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DM6PR11MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: b76b7bfc-9904-46e5-eadc-08de5250a039
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|42112799006|376014|7416014|366016; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YmdSbDZ3L00wUC94aTZoZDJxaXo2RGt2eHRaMGNRRTN2cEhJTG5USG1IQzZF?=
 =?utf-8?B?cXdsWVpjcFFqdldaQTBzYTQyNjF6ZjZGWlI0U1JqajJKYTFjdlVtajA3Y3NQ?=
 =?utf-8?B?dVJ0eTJNZ2d0UDNKUks0TVg2eW9JeWFxczFZOGpVdGVtRlRscEF6elNsdEQx?=
 =?utf-8?B?dkc1aTdqbVJIUFRNNnFZaHpTSXNLTTNtYThNZ3ZuM3dKdzB2d0NNbFlXNGM0?=
 =?utf-8?B?Q3A2TFFxd2JtenF3UTU1Ly8yeHNkNTBvNmx5RURtUi9ua3k5eldGY016VUpn?=
 =?utf-8?B?bW1LRUFhSXE3MmZadXlQc0pjTXIwNHFSRWx0UTJLYmpUakl0dCt0aC9LVkJy?=
 =?utf-8?B?Unl0Tk5wYkRYdFk3QTNlVE1hQ3Z4dEczcUxEYlczNGU3a0FRRnNYSDZOdHJC?=
 =?utf-8?B?SEh3R3ViNUN0K05GNWt2ZG44Q0xNM2owVXZVeWZUeUx1a0ZyUU4yUjVsNGNW?=
 =?utf-8?B?OURQZFZFSysveDZQc3BBMktoWFZpVEpVTmRxL3dITDNrSFAvZTRzNEVoeXFB?=
 =?utf-8?B?MjFlSUNVMGM4K2tkQ3BqMUxMQ2Z3dDloMXUxNFdZYXZWNHFNakRSUFNnSGow?=
 =?utf-8?B?VWt6ZGpIN0p6SmtyTW9pQ3F1V1J2MzlMU3NHL3Q0aEp0V0NDbWdqQ010TU5D?=
 =?utf-8?B?ZzJWMzhKNk9majBIZzNvU2RMNUlLckxsNUVUMEd2ZUZhN3FpdS8vaGJuY0tM?=
 =?utf-8?B?SjRHQVo0c3Z2dGFGVm4za2RSZFl3UE9FMmZmKzk2eU10NEpGVytIMStzYWNP?=
 =?utf-8?B?UzdxYnBaenVnY1MwVjhLZ1hpUWdZRFRKR3NUS2ZqTFdYM2dUcnphcFFwT2pK?=
 =?utf-8?B?akdLZ2lSNWcwdnlsSllaVlMxbTNVSU9zTlpUUERhRks2TjUvamh1NUh4Nmxu?=
 =?utf-8?B?TUp5STRIYnBXZUlocFFGbXM1aVBuT1AwRVp2WjduRWlHMEVDbG9OT2R4bjIx?=
 =?utf-8?B?OTBSK20vRlVXSFBIakFBS0REeDhFR2o1MklTK3J2UHpzdHJkZGYzNmI1MkZZ?=
 =?utf-8?B?dEVnQW5WNVZmNXlLY3ZGR3duc3lOR05Xb2dlS3pFNTdhaCtremR3ejF1VHRR?=
 =?utf-8?B?L0xXNk9tT1JpRFI3dGtYQXQ5dzFTVzdPYVhIZVdReVJydHNjK1A3YzFMMGZO?=
 =?utf-8?B?N2kzTzhDbm5vL0RuQUF2S2xWR2ppNG90L09UL1plajlMbjBVeTQ3WUNIMlcx?=
 =?utf-8?B?RWczam9pQzM2Zy9wRW5raExlK0tQZ1R6WFBtMGc5V0oxMHhrdDgyaHprTXNZ?=
 =?utf-8?B?Y0ZmbE1KUGwxdWl0bGtReUVjYXZrcnJvUy9YakwzQnFkbXJydTJja1cwU0x1?=
 =?utf-8?B?QWRvUGlORkZmeldjTkFVQU1KSytaSHNIOGNBdlhsdW5rMU82czhmSWJzTzls?=
 =?utf-8?B?SFFGcTRCUFRNd3JlMzZTL1VsNjdMVDRzcjgrOEEzM0dFTUpaYUlwRzR3Zkhv?=
 =?utf-8?B?Y0dZc3Nkb0NCL2Z0R2lHVTZ5TEViazNwSloxTmY0d0hKNTlrS1pmTWpXZFE3?=
 =?utf-8?B?WGpyMWVMZWJoTk50cVdyR0xhdEhoNWNMc1VYTitOKzFNako0NUdmSDMvSk5R?=
 =?utf-8?B?Z0tac3dNbXVJVHArU1RUVDZPRnJHZ2RrM2F2Z3NMY1hMMXVacENzZUgxWUlh?=
 =?utf-8?B?SUd2MU53Ym96TmZlYWVLMGt2eGxlaVkvbG9hQXIrZzRWaXFSdnpqcnhxZ3E4?=
 =?utf-8?B?N0xrbWhmMWlnQ1VsODFseldveWdDbDlWRWdLUWNXenlTVGJxVTdma3J6ZExU?=
 =?utf-8?B?d2w3OXRpcDlyZUw4UytvSnBTY0xrZWtmMnFzZVdrL3pNVW5tckwxbWxsM29m?=
 =?utf-8?B?ZmdwRlJxMkx1VkUwUWxJR0QvdzBQVmdHTi9IdVppaWExREgxS3lDSTBVTVdD?=
 =?utf-8?B?WitjL2x4WTRKZ0dOK2t1N0pxb1hBKzI3TVJCL0dGclpkUzdDQVZiOWlRUXNo?=
 =?utf-8?Q?XaSgWNaelltp7AGBUzybX0uOOrcYHZIK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(42112799006)(376014)(7416014)(366016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0kzTWJ3ZVcrZUkrOEpReWJBVjB0RmZPK05qSVFaSEhicmVNSTdzWWJsVEI4?=
 =?utf-8?B?OVZ3K2U3RTMveFpvOCsvS3VYdy81TldEeERYaERlMmpHUTJxWUV5L3M0OWtn?=
 =?utf-8?B?andVL0NiQXJveU5LZThCQ3hXVjJvMmNRc1BLaUpjcUpTN0dKNG9raFBoT0Zv?=
 =?utf-8?B?MURVMzl4Tzk3dUljbnY2aWcrNXEwTkRNb1FSbVNlZ2JVQ05hK25SY2NGRjFT?=
 =?utf-8?B?VFpCbjA1OXlVZWZUOXdXM0phUms1aGpMc1FmTE5VbGdmZitUeC9GY3lqNFhs?=
 =?utf-8?B?NS9KMWZaTlVKeEZqY1JxYTg1R3hOT21pRklPcURvSVAzVERRQ2cycUxLdldY?=
 =?utf-8?B?YWN4RTVEbUd5NWkrcyttbVVPY29MR2Mvb1o1SnA3Y1k3SngvelY3aVFaUDZM?=
 =?utf-8?B?N0Y3OGhDR0t1TkRzOWZzZUQxY0NrYytCeWhVbVo5OE03enYwWldROHBNbVdY?=
 =?utf-8?B?L1pqSmVCOWl0dHJoRG1ZYTZaYjFpZFVTNGlBaHlFeW1PQ0lXcEF1b3Q2STRZ?=
 =?utf-8?B?QktPRnBuaXlDbmtsRWtwY1YzWCtEdUNNd1pMVXZEalFOaGVpN1JVSEtoZ3d3?=
 =?utf-8?B?a0srK3Y1eDFkaFlBbEhwRkNZczBBTU9EVWJhNjY3TjBVUjNkdTFKZ1ZudEMr?=
 =?utf-8?B?dXJnUlQvMi85aS9LYjZHNmQ5N2VheG4va20xbmpoTlhDWDE2c3IxY0ErQm5N?=
 =?utf-8?B?RzFnYUY0enhOcTYyWEtZSkthc1BNTkh3dE44dTl6cWwrOC9FWGhVclNOZUlp?=
 =?utf-8?B?MXhhcjhwTWNDYUFpZWJPM0dnd0NWOU16TTVKbWZpM3BNdngzaGx6c3pWeVVr?=
 =?utf-8?B?dFZxUGlDK3FWczd0Um5PVGtZWlBlRGVycWJjV2FmNE5VYjMybFgrSUpZYWpW?=
 =?utf-8?B?cFBCZXRvc2UwbWdLZ2xtVkRpWEpQaDVmOUdYTjh3RFR3dG12N2ZxcmRvd0Rt?=
 =?utf-8?B?bkxvYVhZcWFNdFpiS2lpM0VpZUZVVWtJekNEeWg2MFhvUlUvb0lDRXdYWVdZ?=
 =?utf-8?B?TXFKc3ZpV1dsSzZYYkFXTWk5VXcyK1huS0Y0bStIQ2lUWW1taVFNVkZIbWZz?=
 =?utf-8?B?aDA5VXdiMU5xNnpCTVgvcUNubWtQWTFVMCtudS9tY3p5VVNQZnE2TTVjNndU?=
 =?utf-8?B?MVpybHhueGkyY1BvVHh4QlhaQlpGUGsra2tWREVCMERxSFlKVkZXWlV1NGtB?=
 =?utf-8?B?MmR5OW11dEpvWFhXSjQ2dkNKVFlib2h6M0ZMQnhVY0c1Wk5FWU9EWExzaXFq?=
 =?utf-8?B?R08zbitKU2NFc1NEakxaOUJOaUdrM3lmNXVyekE3b3FiUS81VEhLK2lvYWdL?=
 =?utf-8?B?VWdKSGVuOTNaa3Z0UkZZM2lkQ1Q4QktRU3VwRmZzaVowOERpaVBWSkJCMFA5?=
 =?utf-8?B?d2FaK0tDTmFVY3ExNWpOejgwSDI5TENxNXlhZHVJYnpRaHRnRW9sU3p2SUNY?=
 =?utf-8?B?eCtHTjI2TVp5OWNlU1pvcmhsZGhDYTF3U3EvTmFCV2xGNU80b0dkUzRtcUNl?=
 =?utf-8?B?M1NsaE1RSVZXZGNSS1pMT1F1bllVSERyWkU1ZFpGaldmUXFpZmN0WlcxaUUw?=
 =?utf-8?B?dnlCZldRallhcVl1Z0RPZEY5T1NqdzRxL05BM3hEMTlmZ1NKeTR5QUFMNGd2?=
 =?utf-8?B?RG12RFBpVnRBbk5mTkVaT3o4eEd3T1JNUXlVVnFJbWYyaUZ3SEFxdXZ1TUVP?=
 =?utf-8?B?UVcwOWVqR1pPbDNxYWFKOUtGVEUzY0pwUU9WNGo3TUJ3S2pFUlhqQXBGV2xE?=
 =?utf-8?B?VTVaT25VMWx4Q0ppL3UrM3hwR09GMWtJclFZVXN1RmF6ZEY4eDRMcW9mV1Zj?=
 =?utf-8?B?Q2t3VGtPWXZYcjRDN1BaK1AycjZJbEp6VE5qVzJpWktQWEVHMDZIV3BPY2Ex?=
 =?utf-8?B?aFR5RVk0VmIvaTBOQk81VVNqM3F0UithL2NLcGk0UEtDY21BVXZMSDkvUGtN?=
 =?utf-8?B?MHJlU2ZQbW80elpmVjRtMjJTL2NTQm9OQ00waVZ6Y0pJV1cvMXo3UlNFSmk4?=
 =?utf-8?B?bXJaRkIzYisxNXpVOXZqQ0I5akZGeTZ4YjVMNGxUQWZPVGZWNFQ3M09RTHN6?=
 =?utf-8?B?ajJWb2sybWJIWlNmWlZ4VTc5U2RmRklUb0UxYk9ES1Q3MWEvSVRKRFZOUTc0?=
 =?utf-8?B?ckNKZDREdWpSTXpqMGlkTHJUVFB0RHJqY2xSY08zU2UwSDFhekwxN2FZQmNE?=
 =?utf-8?B?SCtLNkIvQzFHeFVmQUg0byt1aDR1RDN0em1KMER1M25nY0VXT3RWMVpBd2R5?=
 =?utf-8?B?WEVTcStycjFXeWdISWU3SUlmMFZxSDNxTVNqQ3psVDh5MUZOYXZUUnNzREx4?=
 =?utf-8?B?eW9idGEvRmZlNDFOelNoWnJzQkRnR3Ezc2FmeGo5VDM5S29zTFA3UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b76b7bfc-9904-46e5-eadc-08de5250a039
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 03:05:37.4570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zclW4YlliPkSJNfHVBTBl0jcXGo9xPAELbx/zZSQqa/ecgvRklHthnTOeqxiSj+mYqXspHks48qcRsTcNjy7oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4530
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15; envelope-from=yi.l.liu@intel.com;
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

On 2026/1/6 14:12, Zhenzhong Duan wrote:
> When vIOMMU is configured x-flts=on in scalable mode, first stage page table
> is passed to host to construct nested page table for passthrough devices.
> 
> We need to check compatibility of some critical IOMMU capabilities between
> vIOMMU and host IOMMU to ensure guest first stage page table could be used by
> host.
> 
> For instance, vIOMMU supports first stage 1GB large page mapping, but host does
> not, then this IOMMUFD backed device should fail.
> 
> Even of the checks pass, for now we willingly reject the association because
> all the bits are not there yet, it will be relaxed in the end of this series.
> 
> Note vIOMMU has exposed IOMMU_HWPT_ALLOC_NEST_PARENT flag to force VFIO core to

a nit:

s/IOMMU_HWPT_ALLOC_NEST_PARENT/VIOMMU_FLAG_WANT_NESTING_PARENT/

> create nesting parent HWPT, if host doesn't support nested translation, the
> creation will fail. So no need to check nested capability here.
> 
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---
>   MAINTAINERS                 |  1 +
>   hw/i386/intel_iommu_accel.h | 28 +++++++++++++++++++++++++
>   hw/i386/intel_iommu.c       |  5 ++---
>   hw/i386/intel_iommu_accel.c | 42 +++++++++++++++++++++++++++++++++++++
>   hw/i386/Kconfig             |  5 +++++
>   hw/i386/meson.build         |  1 +
>   6 files changed, 79 insertions(+), 3 deletions(-)
>   create mode 100644 hw/i386/intel_iommu_accel.h
>   create mode 100644 hw/i386/intel_iommu_accel.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ff0d3a4da..a00539e650 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3931,6 +3931,7 @@ R: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
>   S: Supported
>   F: hw/i386/intel_iommu.c
>   F: hw/i386/intel_iommu_internal.h
> +F: hw/i386/intel_iommu_accel.*
>   F: include/hw/i386/intel_iommu.h
>   F: tests/functional/x86_64/test_intel_iommu.py
>   F: tests/qtest/intel-iommu-test.c
> diff --git a/hw/i386/intel_iommu_accel.h b/hw/i386/intel_iommu_accel.h
> new file mode 100644
> index 0000000000..472ae109e2
> --- /dev/null
> +++ b/hw/i386/intel_iommu_accel.h
> @@ -0,0 +1,28 @@
> +/*
> + * Intel IOMMU acceleration with nested translation
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#ifndef HW_I386_INTEL_IOMMU_ACCEL_H
> +#define HW_I386_INTEL_IOMMU_ACCEL_H
> +#include CONFIG_DEVICES
> +
> +#ifdef CONFIG_VTD_ACCEL
> +bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +                          Error **errp);
> +#else
> +static inline bool vtd_check_hiod_accel(IntelIOMMUState *s,
> +                                        HostIOMMUDevice *hiod,
> +                                        Error **errp)
> +{
> +    error_setg(errp, "host IOMMU cannot be checked!");
> +    error_append_hint(errp, "CONFIG_VTD_ACCEL is not enabled");
> +    return false;
> +}
> +#endif
> +#endif
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 3a3725e489..b11798d4b7 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -26,6 +26,7 @@
>   #include "hw/core/sysbus.h"
>   #include "hw/core/iommu.h"
>   #include "intel_iommu_internal.h"
> +#include "intel_iommu_accel.h"
>   #include "hw/pci/pci.h"
>   #include "hw/pci/pci_bus.h"
>   #include "hw/core/qdev-properties.h"
> @@ -4595,9 +4596,7 @@ static bool vtd_check_hiod(IntelIOMMUState *s, HostIOMMUDevice *hiod,
>           return true;
>       }
>   
> -    error_setg(errp,
> -               "host device is uncompatible with first stage translation");
> -    return false;
> +    return vtd_check_hiod_accel(s, hiod, errp);
>   }
>   
>   static bool vtd_dev_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
> diff --git a/hw/i386/intel_iommu_accel.c b/hw/i386/intel_iommu_accel.c
> new file mode 100644
> index 0000000000..6846c6ec4d
> --- /dev/null
> +++ b/hw/i386/intel_iommu_accel.c
> @@ -0,0 +1,42 @@
> +/*
> + * Intel IOMMU acceleration with nested translation
> + *
> + * Copyright (C) 2025 Intel Corporation.
> + *
> + * Authors: Zhenzhong Duan <zhenzhong.duan@intel.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#include "qemu/osdep.h"
> +#include "system/iommufd.h"
> +#include "intel_iommu_internal.h"
> +#include "intel_iommu_accel.h"
> +
> +bool vtd_check_hiod_accel(IntelIOMMUState *s, HostIOMMUDevice *hiod,
> +                          Error **errp)
> +{
> +    struct HostIOMMUDeviceCaps *caps = &hiod->caps;
> +    struct iommu_hw_info_vtd *vtd = &caps->vendor_caps.vtd;
> +
> +    if (!object_dynamic_cast(OBJECT(hiod), TYPE_HOST_IOMMU_DEVICE_IOMMUFD)) {
> +        error_setg(errp, "Need IOMMUFD backend when x-flts=on");
> +        return false;
> +    }
> +
> +    if (caps->type != IOMMU_HW_INFO_TYPE_INTEL_VTD) {
> +        error_setg(errp, "Incompatible host platform IOMMU type %d",
> +                   caps->type);
> +        return false;
> +    }
> +
> +    if (s->fs1gp && !(vtd->cap_reg & VTD_CAP_FS1GP)) {
> +        error_setg(errp,
> +                   "First stage 1GB large page is unsupported by host IOMMU");
> +        return false;
> +    }
> +
> +    error_setg(errp,
> +               "host IOMMU is incompatible with guest first stage translation");
> +    return false;
> +}
> diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
> index 6a0ab54bea..12473acaa7 100644
> --- a/hw/i386/Kconfig
> +++ b/hw/i386/Kconfig
> @@ -150,8 +150,13 @@ config X86_IOMMU
>   
>   config VTD
>       bool
> +    imply VTD_ACCEL
>       select X86_IOMMU
>   
> +config VTD_ACCEL
> +    bool
> +    depends on VTD && IOMMUFD
> +
>   config AMD_IOMMU
>       bool
>       select X86_IOMMU
> diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> index 436b3ce52d..63ae57baa5 100644
> --- a/hw/i386/meson.build
> +++ b/hw/i386/meson.build
> @@ -21,6 +21,7 @@ i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
>   i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
>   i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
>   i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
> +i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_accel.c'))
>   i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
>                                   if_false: files('sgx-stub.c'))
>   

