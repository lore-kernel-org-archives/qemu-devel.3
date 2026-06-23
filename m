Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D29CDB470
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvS5-0007st-8S; Tue, 23 Jun 2026 03:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wbvS3-0007sc-GV; Tue, 23 Jun 2026 03:21:43 -0400
Received: from mgamail.intel.com ([198.175.65.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1wbvS1-000365-Rp; Tue, 23 Jun 2026 03:21:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1782199302; x=1813735302;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=+/uQZCUIrwRL8LatQciqWh3grwseihQVEtyAoAN76Xk=;
 b=lnrBvvmYWc5W6TWVsHbvkuKp2b3BGie9L9FuDTh67KBrOhI4xz830gKD
 qTUAVCDn4WWwocoYBF6sAOLcRb2bE5NE1hmyfBJRlbHd1GKOayC4VxDY/
 ahIXJF/u9D+UL2HQ98M6Cx/VOPbdLKdDucqXWNejMutmWsIOr6EHawvGM
 R+jtHR4sK6M0IquHH2PMhOtvReVlmeiepsgHkQhCaV89QjCy3ocm/AvBM
 T5mXN6oaIyfzCo2as+rbqEVLJHNEWn+D5i+MNWrM5q29YaKD0bJvHUsu1
 SpWuRnSTx7+UFO0iIKu34XR4kCbZjcG75UousNfxtlpDaFnySwZz5+WhB g==;
X-CSE-ConnectionGUID: 3Txg6qV0TzOxmczJ4jz30g==
X-CSE-MsgGUID: pPf9LRFWTGihHMhLpBn9Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="82820598"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="82820598"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 00:21:35 -0700
X-CSE-ConnectionGUID: j0KEzvPiQoqb+j2Pi3/qNw==
X-CSE-MsgGUID: vucLXBwVT8eNlMeEuaAYWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; d="scan'208";a="247099302"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jun 2026 00:21:35 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 00:21:34 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 23 Jun 2026 00:21:34 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 23 Jun 2026 00:21:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bt/rm9IUTWFKwSzj+LXYSujcMxWrUg+gy3RomQY9IsxYdsHDPnoBSB0RBufU75+Kpr+IhgKUEnc9OIPEvDGIfUXdxW33jTcC6ZPC4EwM+joaWzvtNGaWlmq8E19VUp3d90A9lW57l+Okt6hSimXbVAys4lSfZJYpFC9Y2CsDAowlMk4fm7qsm2lpXw8MuBE50qGQ+CqH4RjbKVIQQXtne8aBH45HuGL1mfI3pmaIW+VE+M0FZ3iAc9I3kaw0GLlq9UHbbVJSFtOZQkSmdmpfY0GFAhrIISARbpWJ79gnjGEbZ/4lmkVU+O1akT1X54Pd6o57pCy8vd4/gR/Vz8wMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dy5wRq+gqhCUDH8bOxnB+6JBfQBfEhQM7C6AQaIvqGw=;
 b=Ryrid1MP4QFeah9goM+wV+uBY56ja637M13m6lNUn0xoUR9VBsNcabHYmnJAXNJFbVpKCtPGE1y5ceYyPRsczrc0qun8EfSOVATJetT27vfJYnEw51jTknCTTZuqk5J5+JNqconvP8Txv/D43qgjlfCP6WT9YRESXaV0GJ5BsqynPYUiVRfsHlf1Hx4g7e19bVDZEiIX/6a/6EvT9V78vXDNyFF0c8ZF6sWGR0T3nlm7V7w+ATCWFBb/53OY9u58ql0KjUtW03zLNBIzVtU39zX+hAb/bmdbfF5j8ohX7qxpe+bFd8+PGEfExD7ydqB/NcvBDwGvSr5iuzWzA5afOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by CYXPR11MB8756.namprd11.prod.outlook.com (2603:10b6:930:d6::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:21:27 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 07:21:27 +0000
Message-ID: <139b3365-8a53-44b5-9f52-c5dcf44e902a@intel.com>
Date: Tue, 23 Jun 2026 15:29:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/x86-iommu: Correctly set pt bit in extended
 capability register
To: no92 <leo@managarm.org>, <qemu-devel@nongnu.org>
CC: <qemu-trivial@nongnu.org>, <qemu-stable@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Cl=C3=A9ment_Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>
References: <20260622162138.1045170-1-leo@managarm.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260622162138.1045170-1-leo@managarm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|CYXPR11MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 7df734ac-f23c-4a3c-ffcf-08ded0f809e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|42112799006|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: EmTH77Usf058Kum3lxT+BU9nlr5Bm7fyGCtjtlK2g3Us/3twMOh+0sBF0FLs6sTajGSRstBcDvExhXidxpKbRxsoMHmVALgQFQfPPCGuqDLUscx9BoalrVufNrYA1l/k5CPBPwUwq5ERr18FkAQItxkGH6ta8Dg+4dmwi+Xd2UtYVjK3dKZd87CcR7MfLd2PLL9BUBSOQ6yVMCPp7LrXf2xaB6KOciIH5G0aOogI22rKHxhI7O7B0UY68VWRgGbsEQz9Ej0bKtT8wwO7pMqiFpxF3CD0HRl9crgb6iG6GxptUDq8M49sZw0yEFamgRMXzacti9ox4z/2Ebl5vardiOFvsHD3MO0zSiWNtzhUyfJurriwRphUNMu+atVfSJs3j+dYrg0b5v9+O9VwBwBxrxU/mNDRNsJiae1mz2LlsSDExJOED6Lun2OZSpL7qWBhm09WiqM/Zwv9EO663X77IJyHi6Du/wP30N+zSaq7DnKgP9gILyPOYdE5EZXwP8mG3Z9FdipceEegbfVHJxWvQJqnhQcJpIURZlwmWqAILybVFDaUWitABvEczIP3KU2ynh0onXiv7wChvytHr7FGWUzYPHCRno49KUDi2SSVabyFa/E31qGrR/Ybq+j8RKHjWVv59MX9GSD/QytaqojyoEPQA/dDJN9YdJTOeoi5ZCU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(42112799006)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTJJWlB3RUxCQzJ4RXo3Y0JtcEs2aWtabEhOZSs2SkRBZEJjK25DU0Y2YXFW?=
 =?utf-8?B?MlV6a2VzcW92VW9adVczZm9Tb2x1UVdObnpqdDZBRGpUeGlWNjQ0Z3o2dVJM?=
 =?utf-8?B?UXc4UXI4SnY5ZmRlNVljaTNCNUxzK2RMRUloc0Q1RUFFZ3BiRGYvQ2tvdUlK?=
 =?utf-8?B?RUNKK0VvaXI4ZFc2VkI5T2ptd3NnVGUvaUNjNXJoZzhzQmJHOVFZZUp0VmVH?=
 =?utf-8?B?ak81UUUzUVJzQXIyWjYzd3RvM01oUzJLZnBzMmxXOWhXd2h3SFo4S0VCSDBX?=
 =?utf-8?B?czJlMnpiK3ovcFY0SGVUNjNWYjNJQWZpTE83L2ZZaC9WM1IrSGlOcTFRMnFV?=
 =?utf-8?B?dGZmM3F1UlZybTQrL0E3TFMwRnNEMSt1anZic0hibGxrVXJYMVMvQ3F5b1FP?=
 =?utf-8?B?MmN6RHY2elpwMi9BT0cwc3ViRlVwc0ZBbmVxTkxCQlN4RWRqaTU5NkdBc3Vj?=
 =?utf-8?B?OHZvWjlEVWl3dUZDd1Y4TWMrcDZjcTlqK0hQZ2pybXVjQVc0a3YzQ2VDcFB4?=
 =?utf-8?B?UjB0VC9CbURZNWlkenNYa1pwTXJ5M0dqVG1yZ21mZzJEZzBVa0t1aTJmT24v?=
 =?utf-8?B?S29PeUxtRFNPTG1GTHNYTEVnckw3bElzOUpXelpSRDY1eTVacUFyTDR0MDNR?=
 =?utf-8?B?Q3lYaFB6Q1UvTlVvRTJaT0J5bVBaWkcyRzFoMXJ4Z1EvRGhQSG1DK0xUbUlV?=
 =?utf-8?B?S1puaFZWUWJ3VGNGUFdyNFVtczY0VG1ZUTNna0tSRHFvbEZmdStuTjZHTGJz?=
 =?utf-8?B?Ym5MNERSMjZSdVFuWExlNGZTMVdZeFlGRkFkckFPNzlKMXZvekg0NGxzYlg3?=
 =?utf-8?B?bzAwSUN2Nlg1VUJzemV4clJxZG5RYWlXeUhEK3ZBQmI2anBnbG5jazk3MEhD?=
 =?utf-8?B?S2NkL3prQmZ2RGlTTy90YnR6WmRVK1hSSmxDeVpkNHBQMDlZNVNZQ0I1SS8w?=
 =?utf-8?B?NzdUVlRUdlNQdGZJV0RwNUsxUmJYZHYxbFc5LzN1bGdOM3lrUHUyMm1semJB?=
 =?utf-8?B?SlU3cnBMa3U2RWNMS1NrOEUwQlhFb3pZbExnZ05aTWVmcXFmN3NvR05vZlNm?=
 =?utf-8?B?dWh4Y2N0NTRaL2grem04aHJneDFROWhxL2M1cFRTeVAyamdkWEVBcHRpWW83?=
 =?utf-8?B?eG5aWHlnUVZDL25iNERURFdTanRyRFYzYytnR0I5enB4WTJCVmpFYnFkaWNw?=
 =?utf-8?B?ejNIcHFkdTZKOUpXNHA1cTNkWUZJK214WGRYRTlRTGhzdUpHZDQ3OHRkNVlZ?=
 =?utf-8?B?ZFI0dEo4VE9JcHJHYW04ZGtOa0Z0UjVGLzdhRWR3L2JSWE05TEVvNUQ4Q3NF?=
 =?utf-8?B?dlhWOEN5Rmt5OW5RbVZUSm9yTU8xK0Y1TDRDZ2dUQ2NFNGhkSmErSjJEYW45?=
 =?utf-8?B?QTZzZzlOYk9taVhKcGVRTlRzUVBIWXVOdXBiRDYybFRta3huWnQ0Vi9CZXhY?=
 =?utf-8?B?QmNBSjgvTnYwRUhZMDFHVWZBWDE4VG42aXhnZjJZQkNqV3NuZEtlSk1CL3hF?=
 =?utf-8?B?TjVFV1FGN2trYjBHMnN3Sm8vL3c0WVlRL09PcXNUdmxtbSt2V3U5UTZyQnl4?=
 =?utf-8?B?RlZ4UVJvbVFPc1IyMEVNZkdMUWlnZUNZUEdCNVA3YmhhekM5c2tHVlR0b3oy?=
 =?utf-8?B?cVVtaFB3ZlZkNVZ1UmVqYW44Rm1yQWpodCtvYzFCTkNCVmtkYXJxNEg5YlY4?=
 =?utf-8?B?RFB0RmZuNjRNbWowYjZjQVFLSExTMDV1WmMrbFByZCtmQXI3RVhMeGhYSFZi?=
 =?utf-8?B?aC9vWnl2VlFVc0VGMUdNVkR3Umxkd3gyVUxKM2JieGNMVkp1Tys3bzk5am5O?=
 =?utf-8?B?T2tnR3ZMMzBPa0JOK01LVDhUWHBBdEJISXBtaDdQdXRWS3BraHFyZEkyc0RV?=
 =?utf-8?B?QnR1RXlQVVFmRXlFWkFndlkzZ3NsSngweFN2TkZUVk9ld3NYSWlaNmIvcE53?=
 =?utf-8?B?NS9CM3FRNU1ndEhZUWdLMm42clA2Ny9Jcm01NDZJakJPTlEzb2o3VW5WZTJj?=
 =?utf-8?B?aXhiM3RFZm9JSngvYk9hdlJ2RTZxcktJR0VHVG5kSE1aMXdLbU55ZVNadFM2?=
 =?utf-8?B?MmFySmVDZXBFZkNSN0JwSGo1Ni9IR2VlVUNOMVlDRXZRZk16U2FwZU91MGYy?=
 =?utf-8?B?dE5ZOEMwUlkvSmxnWWpocDFtWjh0Z0hXNlpYeE5aWWtEaDdGQWFQU3NTa2Uv?=
 =?utf-8?B?Q1EvVFcrMEpNRlUxV1JJejlrd3pCeU9kMXc2ZytJajdva2Z4bFcvT0xZd2Zv?=
 =?utf-8?B?ejk4dFFWeFhGc0pZZFVWcGcyM3VYNWlNa3hrZENmTU5LbnZXc0ZVM0N1bnhD?=
 =?utf-8?B?SzlaeklHcnZCcjA1MS9rRjZkZVduU0QyM3ZPUzdFeHV2OUc5bTBBUT09?=
X-Exchange-RoutingPolicyChecked: PSq4tN5FP0Vovn5xXXjUYhKZG/Rx8JF+ZSIJgjarRD2i7BegWgd3jl0Ku2J7jSiM1Pd+mXrPY4VvievZlNu1vP9MiV9/mAyBaBzIpyDzx/qO9ZQiC/BBXoSVct96csFlZ+xqwppTR7k3ChyqFIBToxMkqPZngiBPP6NosQEEUfVcMwc3MjHppyFFOiM5ZqtOmm0eGgO7+R8O4quGayzzEOKEs9WE6l9yDYIFc0k9VTXyYQX3gr03aJeL0B5+Micv+Bw0xzEVZ2H2bo8kEMqZXMd7+MN3HrlETW0EFCaJObG4HhgWy6Zb/Ss6Yv65UEGzaa1ylS0X7UxqHvonx604WA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7df734ac-f23c-4a3c-ffcf-08ded0f809e3
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:21:27.1101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpnXgZd0z4KwMdKCo0xSHO1WYiJm2ml0bUbOEVQTdDcnCkpW4r8ySJLLM4nyonXbC/dqp6BmUQdHQvm4sDWxuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8756
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.21; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 6/23/26 00:21, no92 wrote:
> With the changes in c7b2e22bd957, the `pt` bit was set in the (wrong)
> capability register, instead of the (correct) extended capability
> register.
> 
> Fixes: c7b2e22bd95710e404c393e9f563cfe7404220c1 ("hw/i386/x86-iommu: Remove X86IOMMUState::pt_supported field")

nit: c7b2e22bd957 12bits

> Signed-off-by: no92 <leo@managarm.org>
> ---
>   hw/i386/intel_iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 744cdfd2e6..d1af7a3135 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -4988,7 +4988,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>   {
>       X86IOMMUState *x86_iommu = X86_IOMMU_DEVICE(s);
>   
> -    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND | VTD_ECAP_PT |
> +    s->cap = VTD_CAP_FRO | VTD_CAP_NFR | VTD_CAP_ND |
>                VTD_CAP_MAMV | VTD_CAP_PSI | VTD_CAP_SSLPS | VTD_CAP_DRAIN |
>                VTD_CAP_ESRTPS | VTD_CAP_MGAW(s->aw_bits);
>       if (x86_iommu->dma_translation) {
> @@ -4999,7 +4999,7 @@ static void vtd_cap_init(IntelIOMMUState *s)
>                       s->cap |= VTD_CAP_SAGAW_48bit;
>               }
>       }
> -    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO;
> +    s->ecap = VTD_ECAP_QI | VTD_ECAP_IRO | VTD_ECAP_PT;
>   
>       if (x86_iommu_ir_supported(x86_iommu)) {
>           s->ecap |= VTD_ECAP_IR | VTD_ECAP_MHMV;


