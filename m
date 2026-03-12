Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E34FED2C0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 03:24:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Web-00044k-C6; Wed, 11 Mar 2026 23:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w0WeZ-00043o-2N
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:24:03 -0400
Received: from mgamail.intel.com ([198.175.65.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1w0WeV-00035A-VF
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 23:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773285840; x=1804821840;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=FhXLYBhVr3Nz4OyFNfIK4p5fks0B1CzZzzy/fFwHVX8=;
 b=aAh9dtr7GHTBPiAVrfKjPjwwjURihrErT1bgaRBh0RzcANeBJNT8YHM8
 OrWybNP7IZF9Kw/GnWV2bBsSHxVTaby/EYoj5spxxjzfJb6Hn3u8PL0Nb
 AUDPEZtrETsyqPEh31n6F1sHmE2+jixLLMHwThcdW4aInv47grZCzvmUS
 DiCZves51yQ8DiNkUkUaNHdF3r/5Czz9VDRYMXPRo/oxBKVOIZi+M+Ltu
 Z8dJWM9DHUaVl7L3CRKq2+10uRsxqT8If2E6D1PBHYPdptorNzqU2d/8e
 mFeEGMDkbVJ1OjByetMBf44LoE4W9EBvWSHxHsJEGhMiowpG4SP7w1Sjy Q==;
X-CSE-ConnectionGUID: IUhCvsD2QIG9OU7hKYG8Fw==
X-CSE-MsgGUID: 6oaLST4bTGqLIAZf08ZhYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="74262688"
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="74262688"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 20:23:49 -0700
X-CSE-ConnectionGUID: jrz9AVWlQ2yMkUpI257jwA==
X-CSE-MsgGUID: bDa1L+2mSJiY7RmHg7V6DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,115,1770624000"; d="scan'208";a="246139288"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Mar 2026 20:23:48 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 20:23:47 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 20:23:47 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.1) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 20:23:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUEK9qTCRsrAxU/x8RjBmx7hGSiltups3TT2aL2H2wkcJI4FBHqaR2rWMzdzj470Nu/v1SAcLGyRna2Q9Q/+LuSj4nWT16VgdruwjpVFi4Ufc0yoEb/P9uazVbZpaUyXJwF00xGpAWpozmpY/5LOgmEz0FDLUOuRpPEHLCoVaB9Mzv3cybqxQAhpeR2e8fiehw8YOM8kqktACoFG/vO1bJVytbIr9CgDJczjxahtgOP8sifS/O5nAoZimqGwGoGGwQ1RGWfw++lp2AbKlgPpJKJBhETfo/2mItcbHCWVy7g+Q8vyK61wrm1gfuBiZfmnvAqdJnvnEeUbKYZDb2bGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWYV79fNGH2STi+4k+Aqo6iMcqew4V4v8O6Q4bray8E=;
 b=FAv+AYohadME9W/fHmKO0/ictZo7byExLgSV53e0avJyo5OQDEBIOkwVXBhUQ4bGT5cjCYPmP//KYlscPXPd6m9Vmlp1CEZXhyciZi+1QpnhFdjcVb7huJ0gOM/apN8mt+tZHcibGfykMNUzgM/7Hfs9RbLbfdbtFfsMMxOVbZRex9TtrnmozOWH24NJybn/m/76+jvk6vSYn4d5ZV8qBj+QCTLFw9LnPstdCQB8SWb1+NVk6oW1Cjx4D1XuZ89a8bfWvFpYfxSN6B/uPf5O0kLvSX33K/swYQpf/s6BBe9O/fVNjz6ZJMRkDKrhM9t3ym4h8bsFKkipwExFAKmF2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 03:23:40 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9700.013; Thu, 12 Mar 2026
 03:23:40 +0000
Message-ID: <e809b716-f35b-4a97-afdc-0618675eb250@intel.com>
Date: Thu, 12 Mar 2026 11:31:24 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] intel_iommu: Always write all the flags passed to
 vtd_set_flag_in_pte
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@bull.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "eduardo@habkost.net" <eduardo@habkost.net>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>
References: <20260310065644.426838-1-clement.mathieu--drif@bull.com>
 <20260310065644.426838-2-clement.mathieu--drif@bull.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260310065644.426838-2-clement.mathieu--drif@bull.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0049.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::13) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e3400c2-d190-4d20-9ca5-08de7fe6c155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|42112799006|366016|1800799024|376014|7053199007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rp+NqST5RqAHXbcXCSPhwS59P0p3OPFvbDB+ri/V8nehDtetqTiv0rrGF0KUuJnREwCLBOBgBr9+b+sTKrvlPYnNCRZKH2PqI12DzJf7xPFaGpyCXZATHCE7duqqzQDAnmkL7/zAGH/PuX+qA79G1T7jf3LLqlPjb5q+3+5RXYLCWN7QAQWvwHjH/k0NafWd+vce0AHkjinsUs8FtEBWerzrKKmGjsdOzlDgO+WGLOgJDznGZzP4DSrqKvLMvi9U1sFxVMiC+a82HSzH2xK2CJKqqFiEozAp1+0f1xG9VMgR1yXJ/1m5ss23d6OHQwI+IXu6HF9YrwZRBZ2dolpyIWo5TMHEz/F90A4er3IEp3otHlHEpUxldC4ysQuTMQ7AuRDfS8UEGw7JXGZt/KI8778mhmPrnnnqFE3l8drMrk4VI9u7vAr8X6ujRjpoe/8xVwr5omCvks0isH8xCqjiLJ+8LNXnuTKhdZnUSrPAc71rW6U6eupK04EyvR2+NqMQSREV3B0jBnmhXP/zpFd7OV7h7ztaNmx9WhxlYuDqcY77QgyEG9rjqoDpVW47TomVpLMQ6ZHeL/uoNuVxsW39TIEkHnrg8Z+C3SW2KgupTgF6a87areiAa1ixxWIh0DVJOY0Q1zV5uW0NHE/dEJpTe7x+rg5l/YtfGXIFLkoFD7nxV0Q+BNy0SrGaDfecrmcT2cremi8Jsbv9vB2xPFmicJ42Tdnx48o8J3voUfAfJPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR11MB8509.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(42112799006)(366016)(1800799024)(376014)(7053199007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGMxRGxtUVRoQ1VLV250S2JYVk53Y0doSGc1RWJ6VHRJWmE1RDg3STZySHFN?=
 =?utf-8?B?RHdlZEU1Vy9Pcms0TjJrY1QzUWUwQ0VCTWNVbWduei9uZXJoTWU1NDBDYjNY?=
 =?utf-8?B?RitBZW1YNWdXT3ZQejNaMG56RmtPQWszdnpUckRYVlVvTVd5ZDhTNkQ3Ny9I?=
 =?utf-8?B?c1lsWTBCWVpSSVQwWlFvR2tJQ2VjcVk2bjNTbTRKaUdpNVZyaDRMYlhIczhX?=
 =?utf-8?B?Y0lRRWhsTjdncklqYWNkY09NZGs0bWFzcDU4NElQNDJjRWJrNUJIbjFHdkRO?=
 =?utf-8?B?aHRaODNnRit4QUNiQ3piNW1vRGVEY3lKV1JIRksvMUZpTzJqN2oxS010NTRz?=
 =?utf-8?B?T0NOcVJXNi9oaXg1cDFQLzR5ZDZ2dXVPcUd5a2dtWVNnUkZ6azhZM3NpZTUw?=
 =?utf-8?B?bHllcEJHSVY1a0pHOTQrOFRPckJrVHFSbnhjVGJ0bFhiNXhhU3p3SXFoNFJP?=
 =?utf-8?B?VmxSSDNac2dMZCsvYkFHT2xkVTlDQlNVb0trdkQ1bW9DTHZHQlNRRmZoWVZt?=
 =?utf-8?B?Q1JBRnltZnRvanNaL0pER3U5Unk3emZScGNQS1NLU2w0S1VobnFrazg3N0pC?=
 =?utf-8?B?MlQyZ0RyalNnaWUwQmgvelB3T3h4SytJRUVkc3pFV2VmZUdBMUN2YUc4dmQ3?=
 =?utf-8?B?OFNNVVhhOVJ4M2tuL3pDUHRFS1RqYTVFYjdOS1BPTUtJcGo3S1V1TjIwL3Rt?=
 =?utf-8?B?NnFXUVJkdEhPZUh2S29OUGZNNk1lN3h5SzM4N2VOUFozZW1Rb3BqeDhiQnZF?=
 =?utf-8?B?REJFZ2g3VmVqTXBzMG1YWDUvaVJZZGtlaWtxbzZyZXdZY1JWNmRrd05JczFk?=
 =?utf-8?B?WjBpb25FaFUzV0lhdml5V1ZsRkpIOGhvZ0VobXQ2cmIwcUpvaDFDMHoxY296?=
 =?utf-8?B?MzhHQ2oxRVZ3a2NWVWlhdDlaRThCdmRPM2d4eVNQb1FHMDlBZlRHdy9TdStF?=
 =?utf-8?B?WGJmYmtCVDV1SmozTUhIRG9aV2gzN3NmcTROUWp1Wm9nZTVaT2lYUTRVMFA0?=
 =?utf-8?B?ZnI4Z3FQcFY3RVlUODRUVVlFM0d5S3pqazJPU1FyT25WTVQ0M2UvRUxoMmVw?=
 =?utf-8?B?RjZRb0ExTGhrVlI4VnE0NVFnZXRVdllPTEQrSzVidC9kU054dWhtbHkyczRO?=
 =?utf-8?B?eStsR2ZsOGdmTGorcVdtUVVHZFNNR2MxWm53SVBkL3d2RitSYmo5UmI1MFc1?=
 =?utf-8?B?dzdXUlpwc0MzMHdid0hkaGk0U0czNVEyV3FXNTRJNHlXUVhGeERiWmkvdXlo?=
 =?utf-8?B?bXNGOFRUc3hxL0dUNUpoampJcjhrM2Vnc3Y0bklRTWhRSy9wTHRkVmd5am5C?=
 =?utf-8?B?WUhtYk1UdUpMSnYzZy9oeG9XKzAxVjhkcXQ0RjVJbDJmS1NscnRoZFdMdUZB?=
 =?utf-8?B?dk1xZHFNNVN4elVCdGh1MXp0d2c0UkozWWJDSTJzcG82VkZRVkJoY21rT21q?=
 =?utf-8?B?Z0J1cU5abWtkYkI4cXAwNW5XTTFHZC9ZeUpnRVJoSzJJRzNsZjJqVVd4a0wv?=
 =?utf-8?B?bU9iWjFMVlBWM2pZZ1p3c0RQL1lGZ2lQNzFLc2J3elBIOUk1K1ZMb21KV0w5?=
 =?utf-8?B?RTlpSTNsVUlsb0g0TTNjQ1R3TnJpaGtBcFBra1NvUHlzVzYyd1FIaC8xUXlw?=
 =?utf-8?B?Ukc1MDFxK2pYMHZ4NzNyQ21UQWhkYWluMjl6dmFEdHNNQTFiU25yQmYvMTZ6?=
 =?utf-8?B?NFd6amZZS3hSd3VDT0xFWkZ0amRFWEFVeElJbldqY1N3Zjc3bHhaUWF1VGVj?=
 =?utf-8?B?a1VBRHIwVjc2T0N6eCtNK2xWNStoRDd6eUZWekJDU3kyWUUyRkk5MjdJdzNB?=
 =?utf-8?B?WHRLK0hWR090QmxUSzBDK3Zzbi9FVFlvVUUwLzlxa3U5V1JLTitSL0xtR3E2?=
 =?utf-8?B?YnBJSWhoRVgxZ1QxcjJYOW83MEcvWTlzcjNKekFEMjIwZ1pNOHdQYTdpOUg0?=
 =?utf-8?B?SGxSSVlmYythUWg0enFvTHpucDR6K3FYeHlaRklNdmJzVFc4NDBBemIzSzJy?=
 =?utf-8?B?Z3E4c09Sbkh4Uy92Nksza3pMRzI0eUdFdGh3L2phZDZOMjdhempSeWpWOHR0?=
 =?utf-8?B?RzltcXc5TFF5dXFCUnJGRHh0RjFRQktFTzVvV3lDcHpIa2FNMjl5cXZiSzRY?=
 =?utf-8?B?bnJIVGlHaHRRYXhtcFRmd2lmaTh3VGVna01jcUdvRHlaWlJNZCtBNmgwQVFh?=
 =?utf-8?B?cEQycGNXeXVud09FSFlDUXZkbHVNMFYyU3kzV1BybitEWVA2bkNNM08rajBC?=
 =?utf-8?B?V2h3cVNrWGZxWkRxd0RrbzZXTnhCNVRUczFPdFRrNFFnZUtocUxsSjdDcVRX?=
 =?utf-8?B?RjI0ZHhPdkdzazlWblU1eUdkV0lHajR1K2xvY1FkZUlEZVBkWjFUdz09?=
X-Exchange-RoutingPolicyChecked: MweKABCeDFHaVNAUsICZpuEs7WUboYDrkZhSvVnDMgAl4GWjLW1dlDzHNwi+SGKtgRzHR6C8/hGhsLOTaMQ7dbo7GKGpqjbKH36h1S9RAD8+5kDoWQEuG+VB3tA8B8dzfJtI7Ih8VXQ/cp4OdtNypN2EsY65cRd/3VAGNUmNYyqJSYWQocccHt46b6WYdt+8YYVsogxQ8zyZhCv/k4oIJbBZ2IsPvfgYo9Rw+o2ZD2sLLNzapBDKN/lia3oc0U3pc6ICkLYb1zGX6+B/XoVeaAiVH+gNmNPMjMqH5g+/yyVmxnZwJc6IaByk+vTf+WS9pcWAqLgW3wqfTr/NO/Fg8A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e3400c2-d190-4d20-9ca5-08de7fe6c155
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 03:23:39.9641 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cdynUgvJwJMvLUDrgxIWr1Z5bc+cMlplxP01d7wKFUM4al+dbUjlNhzDMOx9ronyv8U32FAUTxXjllpWWNgOFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.19; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

On 3/10/26 14:57, CLEMENT MATHIEU--DRIF wrote:
> This function was initially designed to write a single flag in a pte.
> The current implementation expects it to set several flags.
> 
> Fixes: 65c4f0999991 ("intel_iommu: Set accessed and dirty bits during stage-1 translation")
> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@bull.com>
> ---
>   hw/i386/intel_iommu.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>


