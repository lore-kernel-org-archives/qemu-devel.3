Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9EC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 18:27:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMXLW-00076B-6h; Wed, 26 Jun 2024 14:26:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sMXLT-00074v-SO
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 14:26:16 -0400
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1sMXLR-0005dW-L6
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 14:26:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719426374; x=1750962374;
 h=message-id:date:subject:to:references:from:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=95SZMKEOhIHBsOFnBEx1VAPivbvzHoG0TvtFuQaafUw=;
 b=jCIk99k7OW6/nJRZR5XB+g25VVQPqk6yOSyJGDKd+3iNDiEcDD+I7CcX
 0nGbOV+uGxdj7uMcypjDT8kR/s+1lgNqCi7irSTvhzzq7cwXRTe99hwBE
 crtnJsj3/YR8UxIFLAifWhBNcoeEc+UoAIzyXLydFC1WglMFXlmHIF4Ge
 WhwHc+iS+HfjSYXc/p6wRSziyme6kHgKGi+HdI8xXSrUKqtPmlHeGNsML
 svCIyQ9WWdJB751MDlEsLe/eGX3TBElmTy/zemBVAZ+paN2c0fuLa7sbF
 B4j3QX/DCJw7/AplYDWDMt9EEBBNkaFQ/YHpDv/Ujy4duXvUX+JR3SOFH g==;
X-CSE-ConnectionGUID: 9udkLVcOTP2d3BLQoTRrfg==
X-CSE-MsgGUID: AD8+unf0TzaRBGv6hv/neg==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="27918481"
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; d="scan'208";a="27918481"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2024 11:26:10 -0700
X-CSE-ConnectionGUID: rmH7tXsYTDK/yNWSDZYEcQ==
X-CSE-MsgGUID: RS8GPVoAS1WEeySR3RfMRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,267,1712646000"; d="scan'208";a="43909902"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 26 Jun 2024 11:26:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 11:26:09 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 26 Jun 2024 11:26:09 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 26 Jun 2024 11:26:09 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Jun 2024 11:26:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jr6W3FmOX4gpnoDBd34amNlJy0+wXNP+GEmmiA8biHPXSbAc9JheyK+DNtXJburT1IzjIKpkiIflqSSf0uIHOYSns3E2n9fOPPmRPIZERAcEQgxaoF1yf8K8JdgdMwmPmaR3+CNrL9vmzmC/LhLIu9dN66yz+AocYsBDVPJt/DQHiqsQOI2FgrVH6ZLC5oV9/RbfKjMdiAh6FxfIniyvUBBWf4mbBT9265WoVxYsL5z/aR5KsJZljd88NTwi9qLJEhticHulGCpyRHpoY0sFpnfKI0VooSKCXFqPdVoUXeI/+B+QG89+NZTdx2W/eZCUoB8TBBKplAO3bm43gtIR7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWV1Rucqaei+ufTMvtO2VAmSZOB7L2bdf68TyyzVurw=;
 b=h6mwHI94Q5YygNRm4pzyd4/ZpC3o4LW1v0bb29AS/iqUr7X3eAVYsrPLIv87GkJMeSKG2ebDf9haZZnk4Lj3HYCEw8QD1Lp4zgFa6I+nBkucL14MLO6R2r6tIa5xUE8JpxgHpZ5BHU8lNn/VHtA9XQ+H0OXqGBoONVukwDPnKo6IWbfzVy9uk+zYEXyUPDdyUq4vWZndjnZxY00Z1TsKeLm6jtsLcI3B1LohOz0KvevT4oW4fbeNr6P6/uOY0sfZ8jxGNB+NaE1uoHUzn7/1z/+Ym88Zpc/ufqus63xBk8+jJQ4IAvzkiPV6HavbG4B1f9IF0G0YfbbNdpIdLQfJGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by BL1PR11MB5319.namprd11.prod.outlook.com (2603:10b6:208:31b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.33; Wed, 26 Jun
 2024 18:26:06 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::bd3d:59f2:9d29:346%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 18:26:06 +0000
Message-ID: <f296f5cc-3520-4966-a6ac-72ef2a344bc1@intel.com>
Date: Wed, 26 Jun 2024 11:26:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ui/gtk: Negative Page number is not valid
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
References: <20240626000835.248538-1-dongwon.kim@intel.com>
 <0399c37b-e4cc-441d-874b-ba3feb537dc4@linaro.org>
Content-Language: en-US
From: "Kim, Dongwon" <dongwon.kim@intel.com>
In-Reply-To: <0399c37b-e4cc-441d-874b-ba3feb537dc4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR08CA0018.namprd08.prod.outlook.com
 (2603:10b6:a03:100::31) To PH8PR11MB6879.namprd11.prod.outlook.com
 (2603:10b6:510:229::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB6879:EE_|BL1PR11MB5319:EE_
X-MS-Office365-Filtering-Correlation-Id: 653d2eff-82ca-4012-d257-08dc960d7135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|1800799022|376012;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WndRaTBXbWtReFgwWVlLTlZJa1Q4SC9pSVRvUlg1bHNUNHVPRFF3ejQ4U1hJ?=
 =?utf-8?B?UHRDbVF1dkgwUityTmdUTXIxNzN4WlZzaW1lSmFUUGkzamxIQmdRM1ZTN2Yr?=
 =?utf-8?B?bXZlRlNuTURGaVFFNkhXWTVkNTBSTnZySk5janJUMlhEQm9HWUo2RStFdE5y?=
 =?utf-8?B?S21hbnRwb3hBb2tJYVd4ZHhVUFV6eTBZZ3AvS2w2MzZRYXF2VG5raStQUnN3?=
 =?utf-8?B?bEZaOWlGc3BZa2Z6VEpsK2pWY0R6bzlZWVNtRDRuZk4rT09mejZOTkZNSm5N?=
 =?utf-8?B?b21pYWdadVlaN2s5VnlUdDhLYm9QMVFxLzdHOERXc0xRMXVaVUJaRUpBYm9u?=
 =?utf-8?B?elJIZTdQRlV4Ujd4ZWxLTHE5Z2lTR3l2RWZ2UUFsOGJjemVrWFh0VlYyRnAv?=
 =?utf-8?B?QWZlSU0rNGZWNzNwaXY3bVpZZWJjSUZiT3FqSU9mOHhGMjZaNXE0QTNpZ25X?=
 =?utf-8?B?MitOWmh2SWswdmhMWHNqRk9aTC92V2VqOFJoSDZRRHczR3k5Ni9VZzdqNUVV?=
 =?utf-8?B?NXhwaFRTM2pBdFNrV1NuMFYyWEt2RVREQmN4ZC9tcmFyWnpUNmVnRWx0Ullr?=
 =?utf-8?B?QWRKa1dRQlgzTE4zUEt3SWVlTkoxdklHbzB6cnovcTJldVVQYjZ6TjFkb1ps?=
 =?utf-8?B?c0ZZMFZvTXIzMWhZNDJyaFc4TjR5UXorQW9reDZ4TThvL0ZRY2JZbW9hYmJH?=
 =?utf-8?B?bFFDZlozS3JXT3gwZS9vcVQ1MXVMVWkyenNGcFlaMU9tbmVlL0hCTnJNUDFF?=
 =?utf-8?B?a0pncFg1UXh3REE0anFrVzNPcVVYTGtVVkFJQkhOZk95VTREajE0WXYwakE2?=
 =?utf-8?B?cGlRQmhtNGhaaktZTFI3ZHlVODdWbGw5ZDE4Z1FUTjMzenVwbnhBNGNvWHNs?=
 =?utf-8?B?ZjI1U0FYQ1F1Vksvazc4T1lvUnc2TmVEN2luaHB4ajZaWWNyZHFoYmI3aDdQ?=
 =?utf-8?B?YkUzL0R3N1hVU2x6V1ZNVStSYy8rckVnK0VpL1hPODgvaWIyN3lLZ1lxTWlG?=
 =?utf-8?B?TzZ6RndhN29IWnZ6aHZxUHJhdDJnNkZrUzlUcFhMNm8wbVlDaEhIUllkV2I2?=
 =?utf-8?B?cmY1NGhpMFRBdmVoN0pJcE9oNTNGMlNUVGZyckV0N0J0YmVxbEpHcWcwRy9U?=
 =?utf-8?B?ZnlZdmlOWDFsMmlxVU9rMmViWGxsM0pDTmYxQzBBTkIrbXpUd2cxNGFnK3py?=
 =?utf-8?B?NDZXb0JiWXZya0FUU2hWaHk3bzFPSzBFTjFRWDM3OXlwSXJCbE9sdmJ3Q2VH?=
 =?utf-8?B?ck52cFVBbTRJTDlTeUlZK0lNaXVjRC9ZMHFoU1FyTEpQT25lVDRGeHU5VzVk?=
 =?utf-8?B?Z1RBT1k1N20xRW9FRzlqeUlMSVdqMWFBeCs0UjIvZ0FSRVI2UHd6eXFyVS93?=
 =?utf-8?B?MXIvVDVLdGo0d1N3dWdkeHNVUDlDNmJEQUlJUDh2ekk3eHIwWHlEcFljekty?=
 =?utf-8?B?VDFQZm9tdDFMUFNiUUlBenZsL0JITTNXWkdIQzlhTDhLNkg5aklDWncwdmV1?=
 =?utf-8?B?ZytQM29CVVh2ZmozUDJPY3R6VnJVMnBDKzdIb0RQQXZjRS9XMm1ObUpVYkFp?=
 =?utf-8?B?c1BzL0JqWHZmUE9nVnVlNml1aGZkM1B6ak12Wm5YRC9HOEdFMzFad3FLTVd5?=
 =?utf-8?B?U3pzOUlyQndxWEZHVGdkb3l6Tlk4eW16Q1J6cFZrQVZMSkhrRXJEcm5JMHFL?=
 =?utf-8?B?a1BReUk1STQ2TWV5cU0xb0NTSW9RelNkQ2tLWEU1TkVZcStrZ1lDY2NEUGdz?=
 =?utf-8?B?WTlTVW9FUUJCRklZRXgxd3BydkNTdnJEM0s5QzBITVE1VXppMEhOVFdYMEEr?=
 =?utf-8?B?OFREZFFoa2tkc0I3c3ZYZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(1800799022)(376012); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkU3cFhyYzFaZWt2QnliNlhmbFhjRW8zZW5KSFNJNmNSamkxTW1PclFRUDM0?=
 =?utf-8?B?Vm0vc04wT090VTYzVTltT2pJSFBaSzdKOGNwVzMvbmlYb292ZXRtUTE0UHdr?=
 =?utf-8?B?bmpEdGZBcGt5R2RNZ0RzbGpBZGx0eHQyMThrN0Y2dlM1cGZXNWVmNGJRZ1BQ?=
 =?utf-8?B?T3NwQ1VaY2ZkWWhKUzZ1NmsvOU5BSFN2eFpRYkE3V29obVJjK1pKTnRmUzhS?=
 =?utf-8?B?N1YzVlE1V2dCaUEvU0FLNURJZWk1NGVNWk1lazlES24yMzdOMStCYUZVZU1m?=
 =?utf-8?B?Z09jUkRvVGVyaHFtNyt3N3V2bjAxemd0elo1TGFaMDZUUzEzRzV2Ky9zOG8y?=
 =?utf-8?B?MjdBd1ZINlU0T3lqTnk3WXdRK0RRd0ZnK2RvM2dKKytDNVI2Rm03Q2JIVVpv?=
 =?utf-8?B?MGsza2pBd2pHckdmU29TaVg4RUgxMDlFQ0NyTy9XeWxjak0rOUJDV2xVYUNI?=
 =?utf-8?B?eDg5RUtNWGRydGdMTkU0VG5kbFhYVmpVTGlGR2pFb0MwZnF6OUlNbllnZ3p5?=
 =?utf-8?B?KzBmNmtsWWFXVzc0UkZhNzR2Wk9JVWtPYmU1dTdVRk9WNHQzZ2IwZUJmbXhJ?=
 =?utf-8?B?TUNPY1hlTm5ydUl3M1hCZHRxZjV0N3BGTzdJTGNMUTBlYmZoQVVjb2FTUHZo?=
 =?utf-8?B?UkJsaDZPNlR1Y0NiTnFxMTZwTWREZ21PZ0hjNjhvbGR6U2h0VmdjTXZIUXph?=
 =?utf-8?B?WHBxRUpBNDFOYWxsbmwrS2I4WjJpc3ozZVVKc3pHZHNmTXdoRXZ0Sm9TN0xk?=
 =?utf-8?B?eGxtRzBqWitLdEdmZEIyY2twWXp1bWwyd1I4WGl4amhxekE4c2JRYzdjTDNq?=
 =?utf-8?B?NGNyU1MzNEk2aC9hNmpwTHI4Si9pdmhmQ2VEd2E1TDY3d1c0Zy8zajRiUXhD?=
 =?utf-8?B?MC9xNDFyRTdNSitaV0E4STU5UTEyUzAvcGJ6dHVUcUdvSHVhNUxaeFVLNG0w?=
 =?utf-8?B?S1hmeFRyMEwwQWhoL2ZqVG5SVUVCUThwN3VETjZlNHpVMWp6b2JJYzdDY1l4?=
 =?utf-8?B?WG5qcG1NZWFPT1VWR2hRdDZIbWM1R29ndGRseEMrK3IxeU5lbW4xYy9RR3ZC?=
 =?utf-8?B?dmYzRDd1aFdCcnYzNHF4YktFcThpaVlpQXVROVRZVlVqTFU3aEx0SFIwRHpp?=
 =?utf-8?B?cGVHdEIzOU43S3JLMHVWdVYzb0N3Y3hSMEFiRm9zWTBJbXE4VDlIZStZQnRu?=
 =?utf-8?B?K1pYT3pKSkZuQU5semtSbTBFNEhZUGYvb002VVRIS3FZc3p0K3BCWS9BQUYx?=
 =?utf-8?B?Wkh1MEJDR1h1T0RnWWNYUnVhWHZXd2VlVjZaaS9RMC95WVA5Z2dGTHoxZkt4?=
 =?utf-8?B?V3BNamJYUGhMS2ZRMmxOMnVXRmFZU1ZzTDhGNERsQnBVZnlJYkdVTFNNb3ZO?=
 =?utf-8?B?bElyZGM4OWRmN0VSUGUxNE1vZS9UN3JqR3QwQVVsbFlZZ1BuaVNrZE45aHNP?=
 =?utf-8?B?Vmxpdk5aWTRwdkc2aDdCTlNVZGVjbG1FNkx4OUxENG9JaVRpRklLcENacHh1?=
 =?utf-8?B?MVBoaEUybGpZclhiVm1sYm5VamxqVDB4d2ZCZ05OL3VCenFDenY0TTh3OUM1?=
 =?utf-8?B?TzRYaWhlVWlNWnpucCszaVZlM282VEhma1p1anlZdkxjaTd2cUlNWjY1OWhU?=
 =?utf-8?B?bXdrMjZ4eXZUblJFSGkwNHVyREdSMkI3cVNTbUtWVUVqWlRNbGZobm1acU1U?=
 =?utf-8?B?bFJQM2kvUngvbkxoZUJUM0JycDluRnhkd2RvUjE3RWozREJ4QVkwbXhBRW9I?=
 =?utf-8?B?S1QwcTQ4Qnc5VU4xNjliMUtxbkREOVg0SVhaWHZWTHRoWlVjbXU1cDMyMmRv?=
 =?utf-8?B?MkYxc1F6cGFmQUdLL1JwSjVwRUFmL3EvekwrQWZpZ2orZ2czajhXaHJDRWdV?=
 =?utf-8?B?aXF4UmxEQkNjK3lya3lpSXhjNEJzZmQ0ZGt3SG9iLytsazFrZVMyQjJNMGlS?=
 =?utf-8?B?dmZPMGx1Y0w1UGRqekdwS3FtRjFzU1BoT2pCcGZKNURqUWlBVTJEc3QwYmNp?=
 =?utf-8?B?dVVlOGNEeGJYMXF3RTFoYUVaYlRFQ0dydFNFRzAybGJKRU0rS3RqMWpvTkFm?=
 =?utf-8?B?bTVYcEZpR1RtOG5KRVhqcTU1eVZ0SysrQ0YvalBQdmIvdFJlWU54K0RRWkxC?=
 =?utf-8?Q?A9qjq0EqAQ0+s79mmze4MpE7/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 653d2eff-82ca-4012-d257-08dc960d7135
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 18:26:05.9117 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9JjHlYvvspN3zmfbAmdE8a1Twah1Ir2F5jQuxxtqOAHln0aiquguYGy/ghH3aOLfn7SETixU2bbVKOVf4JoPCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5319
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=dongwon.kim@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On 6/26/2024 10:06 AM, Philippe Mathieu-Daudé wrote:
> Hi Dongwon,
> 
> On 26/6/24 02:08, dongwon.kim@intel.com wrote:
>> From: Dongwon Kim <dongwon.kim@intel.com>
>>
>> Negative page number means the page with that number does not
>> belong to the notebook so it shouldn't be used as a valid page
>> number in gd_vc_find_by_page. This function should just return
>> null in such case.
>>
>> This change, however, will cause a segfault during detaching
>> /untabifying process in gtk_release_modifiers because the
>> current VC's page number suddenly becomes '-1' as soon as
>> the VC is detached, which makes gd_vc_find_by_page return
>> null. So gtk_release_modifiers should do the null check on
>> VC returned from gd_vc_find_by_page.
>>
>> Cc: Gerd Hoffmann <kraxel@redhat.com>
>> Cc: Marc-André Lureau <marcandre.lureau@redhat.com>
>> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
>> Signed-off-by: Dongwon Kim <dongwon.kim@intel.com>
>> ---
>>   ui/gtk.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/ui/gtk.c b/ui/gtk.c
>> index 93b13b7a30..1f8523fd81 100644
>> --- a/ui/gtk.c
>> +++ b/ui/gtk.c
>> @@ -164,7 +164,7 @@ static VirtualConsole 
>> *gd_vc_find_by_page(GtkDisplayState *s, gint page)
> 
> The caller should check gtk_notebook_get_current_page() != -1.
> 
> We might assert(page >= 0) here.

We could do that but it means there should be more checks in
other functions where gd_vc_find_by_page is called, like
gd_vc_find_current. And we just can't do assert in\
gd_vc_find_current because detached VC has the page number of -1.

> 
>>       for (i = 0; i < s->nb_vcs; i++) {
>>           vc = &s->vc[i];
>>           p = gtk_notebook_page_num(GTK_NOTEBOOK(s->notebook), 
>> vc->tab_item);
>> -        if (p == page) {
>> +        if (p > -1 && p == page) {
> 
> Then this is not necessary.
> 
>>               return vc;
>>           }
>>       }
>          return NULL;
> 
> I wonder about returning NULL, maybe just
> 
>         g_assert_not_reached();
> 
>> @@ -357,7 +357,7 @@ static void gtk_release_modifiers(GtkDisplayState *s)
>>   {
>>       VirtualConsole *vc = gd_vc_find_current(s);
>> -    if (vc->type != GD_VC_GFX ||
>> +    if (!vc || vc->type != GD_VC_GFX ||
> 
> Then this is not necessary.
> 
>>           !qemu_console_is_graphic(vc->gfx.dcl.con)) {
>>           return;
>>       }
> 


