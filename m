Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18F3E77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 08:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVnk3-0001dk-LO; Thu, 09 Jan 2025 03:18:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tVnk1-0001dL-0u
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 03:18:09 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chenyi.qiang@intel.com>)
 id 1tVnjw-000152-Al
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 03:18:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1736410684; x=1767946684;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HX+5jdjVUq2m/vJVCJUMJ26O980f8vvOe29rujjdGA4=;
 b=CP+brmwqi1fCo5n2bXA/mykOw9flIJ0qAHW0Dd8Sfd5771CTPobgXXMy
 6o0nbFy4gTnll4Ij1ao0twN/La/GkPWN8Q+r5Nxj54llchSri3jPUmXGm
 lCiva9F3/7VAmRsbSz0LNDeNU3OXskiE5XLXlxJo5VoPfTroWMQSEUpdW
 Hpd56zshl/1xVFD6sbyd3aTkaDlJVcxuSW+zS5S2NdWczBykOuwDPWg7z
 URSPet0juLWq4PO+ylLahwKGOGckiI83PafejkiLNRlqwQNt376zHHq+J
 5UUkEf+6piXXCRt4okz9VCCrDRN2Kn8AZmMYYp/uq3GQGohG+EWkTrgbc w==;
X-CSE-ConnectionGUID: Nm+eZvTHSnuT9Ed0PY5nBQ==
X-CSE-MsgGUID: zcQXnNAvR5+NpUc/JNkNHQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="36821364"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; d="scan'208";a="36821364"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2025 00:17:59 -0800
X-CSE-ConnectionGUID: dv3/r5wVQCSZVg3rkfQb4A==
X-CSE-MsgGUID: HphQpOA/RTq1R3cOpxC0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; d="scan'208";a="103836048"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jan 2025 00:17:59 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 00:17:58 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 00:17:58 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 00:17:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuCdg1V19Snv9YNoP8aRZIwCQI9s9+e+WfAZx36htfeR+vLlTbmhCBleMFywch+JuxYnrKkWLuxuiXpzAxn8GUNIBKgtazBlN80lH2gXf0OA0joPs/KzNfo30JqR22y44jpOgrHTjysVm7qjZWP+pE5F0rCEnP9/GewmsTGNxWmL5AOMQLs5fmstLEIog8b+Ze3cMuUG6amlLLhgEOb+ECjTEmJczgux2wCrPW6gn8oAhLs27oQWgNIHMf6ep3Buk4yIOBFp/PdFb7gaSQJX7Xeri9Lcf9U6ypXZEHBFOPhbjZE89s2k8c+Z7WHjtCOuj6KLHc6LJe1ziSEACpdj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zpl5+53eNH70hyL51Y1Rdr+kaM4Dmd+k8a2CgxJCXc=;
 b=JlcZtaKXGP2ViNLmUtIS3CesMEF+ak3snDOkc58n2lLz227bgw9ttCxcZaqFNJpGhynmGMUIowjJoW7DlBq/zmaSroKeP8zAi1cvKD0PK44hxydE8xfAyR5TrgaCHrcQRa8nrKHVxV66rCeWoiCYMWGXbjd/II7c4NagR139sIEHS6njSsMkM2xW0+AcnqkkXL8ojZumN/U9TEhoKsP0/CWzuJ+VoSngnxi15VMU22lfBsAyOl5H+Rd28PlpmDbuFzUoDcEkWfqvJLMhjjjEPVrWJtKLRpRqFD4N+6KfEG5Z6HRLWlkLIeUiEk245Xcp+mpWsY+LyBXRSw0StSI4jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYXPR11MB8729.namprd11.prod.outlook.com (2603:10b6:930:dc::17)
 by DM4PR11MB6066.namprd11.prod.outlook.com (2603:10b6:8:62::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 08:17:56 +0000
Received: from CYXPR11MB8729.namprd11.prod.outlook.com
 ([fe80::680a:a5bc:126d:fdfb]) by CYXPR11MB8729.namprd11.prod.outlook.com
 ([fe80::680a:a5bc:126d:fdfb%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 08:17:56 +0000
Message-ID: <99cb8fa0-b26c-4969-a203-466a082464d4@intel.com>
Date: Thu, 9 Jan 2025 16:17:47 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] memory: Register the RamDiscardManager instance upon
 guest_memfd creation
To: Zhao Liu <zhao1.liu@intel.com>
CC: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Michael Roth <michael.roth@amd.com>,
 <qemu-devel@nongnu.org>, <kvm@vger.kernel.org>, Williams Dan J
 <dan.j.williams@intel.com>, Peng Chao P <chao.p.peng@intel.com>, Gao Chao
 <chao.gao@intel.com>, Xu Yilun <yilun.xu@intel.com>
References: <20241213070852.106092-1-chenyi.qiang@intel.com>
 <20241213070852.106092-6-chenyi.qiang@intel.com> <Z3+FWW9v3QqL/gEw@intel.com>
From: Chenyi Qiang <chenyi.qiang@intel.com>
Content-Language: en-US
In-Reply-To: <Z3+FWW9v3QqL/gEw@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To CYXPR11MB8729.namprd11.prod.outlook.com
 (2603:10b6:930:dc::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYXPR11MB8729:EE_|DM4PR11MB6066:EE_
X-MS-Office365-Filtering-Correlation-Id: e418642b-e65f-4dfd-442f-08dd30861edf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bFVaaC9WZm1jMDZJNnVHL0lKK05nNTFYaFFEMUpQVi9RaUROMzNEZmRrekh0?=
 =?utf-8?B?Q0ZZY0hxTGpXV3A0SlU2NGhCbFJsMERHTHUvTlIvb0s1dEdNK2lWcWhqMU1Z?=
 =?utf-8?B?Q1V2QS9tNEFENVdmeWladHNGSHdraEJWZk56SmI3bjg3MGRsd1FzQUV4Y0Q5?=
 =?utf-8?B?dVBmWTI4SUJGd1VjMkZVQ2crN1dFVGxFNERUU1U0MlJvSHZyMVduSnVGTW9C?=
 =?utf-8?B?MVhkbGlZeWpkTGhRdm1XSFM3cFl3cjIxZlQyaWhNODZoR21jbjU3TlI5b0xa?=
 =?utf-8?B?RCtXYnYycWJROERWQS9LQXdQK1FMTzRJTHh3NzZuSldISGJLWVJ2R2xWYjVk?=
 =?utf-8?B?S0xveFIwelJscU8weXF4dFRmRlpRa2g3RVphYzBUcGFyL0VVeVNBN3M4K0Jr?=
 =?utf-8?B?TXJpbHhyeks0YzFDVmg3ekVoL2R0RXlkM2h0ZHBBVGExVlNMOVlJbHN0eVpI?=
 =?utf-8?B?UllkY0pYK3pPWjdCVTJCSkRCZnRDMlVlbng1R3lyMjhmY0h4bElLZFFYOEpX?=
 =?utf-8?B?MmdkaGttVUZzditCNS9GMWw5blZMRnRxM3dVa1RxQzA4eFdTZEQ3NnczaVZG?=
 =?utf-8?B?MmRoeU41SVU5TVBHQklWS0lkMnpCbis2MFZJdUM5TlU1UEdvWWtrMkt3amxF?=
 =?utf-8?B?WnhOQXlRREc0TzMrYnNrbEZDUWtOMEJhRXZwYkF2bEVMYnhMd0h5Y0JiU3Vq?=
 =?utf-8?B?WWZYeDd3S0xEeUJzbWtjZFd1YUlrekQ1aTZKa1Y1L1VLZ1drc0J6b0NTU0ND?=
 =?utf-8?B?bHYyYk1kR2NxVjBGZ3h0cmtqbnpYdHhDblZSa3FYTWRGSlk2cEp3Uk1zM1VW?=
 =?utf-8?B?WUtERTdacVpUYUdDTE96ek5SZk9xMzFUTXBJd3ZEbnFLZ3FhemNOL3dubG5N?=
 =?utf-8?B?REFqekpuamRoRGY5VmVUcml3K2ltc2RBOVF2WVBPM2JIQ3pyS1FkTjZoU240?=
 =?utf-8?B?enpwaFVHSGYyVC9uaE9Velc4K1p4TksxaGY4RytCV2pnMThWdEhCWGFrVDdh?=
 =?utf-8?B?dXllQUc3Q28wVHRjL01KZktZUjJrcHVKS3o1ei9XWDFaSDcwVkQySk9WSzR4?=
 =?utf-8?B?V3p6UUV4d2JWdWJycU1IRDFDckp1aHMzZGkxOE82VUt3eWZDazNLdUxZalc3?=
 =?utf-8?B?TWh3L2FQOHc0eTQ4RDhRSysrVG1FVmlEWjNKcVlYWFpEdDJ3bUZVakVUT1Nk?=
 =?utf-8?B?dWxaOFVzQWFZUlJLYnp0OWtUbGZWZVhMUFNsQ2JkZDhaWlBhdmlZcjJvd3N3?=
 =?utf-8?B?bXVoSGo0bld0TzI1cC83VzVRejlIMFBoUWJOd2IwRkYxbEl2aFlWdXM5KzM2?=
 =?utf-8?B?d1BxdTVqMlNObEp3MDR3VmtTK1VmTWVnSFJOL2pqQjMwWW9abTFOUDRoY1M4?=
 =?utf-8?B?L0c4WkszVWdrV3MrK0ZvZEVoMGYvdHcycGxrQ1Z6TW1WLzdZeTlhWkRacEZV?=
 =?utf-8?B?alFyVWNBVVBFY3UydTF1TWlUSm8xbkxmZzhRdGpTNHhaWlJCMEpxaDJGNVdn?=
 =?utf-8?B?cTVHc1ZKRmpjWFkwQzRsdjYvYm1nelZOaFhLTks4SUNVdWdGcVNKTkVRUklr?=
 =?utf-8?B?dTl3N3JDZXVFdHV4bGplWERUYkZtTlNic25IQTN1SmR0Y0NjMHZoSkE2TDRh?=
 =?utf-8?B?RTloWVBOSmRjWk1rR1RibE5waTJLYm5mWmswQUVSaExVN0UraXVkS3h5aW53?=
 =?utf-8?B?TmVybmZoVVNRMWNtSGlsVWxCaHRYUGNzbzBNU3Z1L0ZBVURpNjBNNUhhaHNz?=
 =?utf-8?B?N25heFIySCt1T1BQdzZpVDRRUFl6T2o1QlliWHBFbjBFMTJvZ2orRE1CTklx?=
 =?utf-8?B?VkJMeVRNYldmNE13VENqUDRhZmdOSXBmN092VnZhT1hvVy9qNHJZQ2xTVzNE?=
 =?utf-8?Q?kY5N3rXtHnNOw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYXPR11MB8729.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q3dzOHA0VEVrbnV3aTlOMmJyZkE0WW5VWFF1dGQ0b0dSYnlEQlRmNXQzNlV2?=
 =?utf-8?B?OEQ5a2ZCeWZXaDFmUUpacWdST1BrbXVSV3diUlJaV2ZRdGhIbmVKeVNvS1dN?=
 =?utf-8?B?R0V0VWgwLzRYaXhTV3c3dnpyMzU3aVhraVhJbFpwbnFiUlR5UkJabFk0VU1P?=
 =?utf-8?B?SEFsRXNNa1BWa3FNVkNiaHdXYU5paW1QUlpnVjNGd0JlaDF1dmVLdTZZVS90?=
 =?utf-8?B?ajZLYnVpVWEvTXFsRUJDdnZlQk9HT0pzWDlNSVVQc3QvbzNIdkdGMllHcnY5?=
 =?utf-8?B?cUQrSDBKZ1c0RnYweWNSTkg5d1VUcnpZNE1iRzMzOVZpS012WG5XZzF3NHBF?=
 =?utf-8?B?Q1N0WXdDUlYvTFh2UHhZck0xQlJzMkRTUjJjZlVPUWhKeXcyajdEQ3gxOWc0?=
 =?utf-8?B?UENnU1ZUNG5CdGRacHJPZnhLTCtNQ3IvUHVzUC9FN0N2VC8yYUFLWE5FdWIy?=
 =?utf-8?B?NThXb1BtU0dEdi9qa0ZDbUNuMUIxNlZBMDVvMU41NTFjL0x1ZmxhRFdkTlky?=
 =?utf-8?B?cEIwYmJjNDRWcmdNZHVZZEszdDFZZVVBRE1MRVpvbG1XQWYzdjhWeTFsQlVo?=
 =?utf-8?B?YlcvT0l0NXlSdXNXT0R1THJpMGdUQUk3WUxVQ3BLT21Da2s5ZkpEb2xVL2ta?=
 =?utf-8?B?K2FaNk1SdVlGZTBBTDQweml3b2Q4UVMxQlQwZk50QWdLQmZSY09GeW1jMDFF?=
 =?utf-8?B?RmJnNmF5bWlJRWgyQTNPMXBGODlnWXdOcDRqREh3SjJFZ1hyME1iWW5rT0h1?=
 =?utf-8?B?WmNYaGkzaG8yRFg5bkR5TjdDcU9XVG12SkVJWE83ZDVWcGdvdXl6eU03UWp3?=
 =?utf-8?B?cHpGZ1h6Zk53VW82NmdBbWFHNk5LeUxGQ2VPblF4MjVYMWRIdi94L052UHpD?=
 =?utf-8?B?Z2ZoMTgra0Z6NkJDZlQ1TkJPWWVQWnBORk1qSVdzdktDVG9oVnlTNmRDWWpD?=
 =?utf-8?B?dWFpYkNLKzNHMnEzczNSUGxYVEdyUDlMWWxtc1VCaEl4STl6QUVtdVo5a2Zw?=
 =?utf-8?B?NUtYb0RNU09OQ3RRc2ZPaWhTUFhYMG94emE2UUVVTm4rT3NWSnZSRCtaS3do?=
 =?utf-8?B?UUdlNzdyNk9NRnY1K1dnSmVDYVVZN3NQQjBTcW1FckhxODB0R25NSzRpTWQ3?=
 =?utf-8?B?VjhRbi9PZ0ZNL3Bqb28xWlZObUdVQlN0dm9wOXFHZHZSQWlkZmNkWDhXQXdx?=
 =?utf-8?B?ZklEcHZKMGZJb0V6NDFSSThCV0lnYlBKWndYeEUvOTFSUnR6SU45RzdTUEMr?=
 =?utf-8?B?QUswSTJmZm11aThqWHc4K3hSdzNIRXdHNDVJb3dmYUd6Z1RXK3hGUnJzOEZF?=
 =?utf-8?B?ZzhVTm1ISmN5eEgvOTFQVE12QVduQUhFVi93T2lsVkhRT083b2hDNGVBWFcw?=
 =?utf-8?B?UmRqUnhSWXZDS2ltdlBLUzhBMzlWdjFQMFIyTTVSelBVdWU0d0FlajJTOEpE?=
 =?utf-8?B?YUQ2aWdOWDR3Vmh1SHdPK3BFdnVZdkhxU3VBWkw2a1BMVjNYZ2ZtS2VpVTZu?=
 =?utf-8?B?d3REWHBQSnRYbDY1M2pwTzdZaDBjWWljYktnUnJmbkhGZjB4OWk2U0IyZHpB?=
 =?utf-8?B?QzZ3WlJ6c3IzaTA0WW5VUEJWVEpVNEt2S1RXUWk2aVB5QmRuR1dJQWhKZFE4?=
 =?utf-8?B?TXFJMkdQbW9BQ0F6VWxJMUp6Q2dZNVUzTmRaRWQ3SlF0UUpBV2lzM3ZHKyta?=
 =?utf-8?B?MkJEbXYrUHhtQThDQUFWZnRkdXJzZGdOTmovcFd5b0l1bUMra1FPeFhhUXRW?=
 =?utf-8?B?clh0OGlPd0tzaUlpaXZZdFBiYUM1R2RTQS9IQXlWZm83OXNiVHl0Q296SG5B?=
 =?utf-8?B?K0VVYlZJNkVTMUY1NmdxbXlrb1ZDSGQzYWQ5SXhDd0J2eUVOOEs2VTBOYm85?=
 =?utf-8?B?NlNoQkV4cXdmS1BjQVdHUzROUjdpd2E4NXZ5U0l3ejk5ejFtQnpXT3NpNlNJ?=
 =?utf-8?B?TG1DT3BqN1ZKanQwQUtCSFZ1WXFybnZrUllzTlF5Vi9nVitOQjJlQWlnYUxq?=
 =?utf-8?B?WkJjbnJ1QTBFaGVvd3NuWUdMWXBaOEFjMWQvdTZLRmYrRzhDN3pjdmRVWmJr?=
 =?utf-8?B?ZzU3V2t6WWd5QXJCOWVBQ2lYWnlJOFVTUFdHalBYMUN3VFVQS2UxMm51bUc3?=
 =?utf-8?B?YzR5UHNmeDE0a0kvZmhYRnNlc2t1NzRrRjl2Sy9KTS8wa1JkVVpBZDVpajFU?=
 =?utf-8?B?WEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e418642b-e65f-4dfd-442f-08dd30861edf
X-MS-Exchange-CrossTenant-AuthSource: CYXPR11MB8729.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 08:17:56.1015 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfaB/Z7/bDPrZDa6redmg5Q1qsO2mVQv+Y24a09L9SLoeiT4Nl0l/utD8Dlj1KdM+8R8UElnzdnW9KcysOexyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6066
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16;
 envelope-from=chenyi.qiang@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
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

Thanks Zhao for your review!

On 1/9/2025 4:14 PM, Zhao Liu wrote:
>>  #ifdef CONFIG_FALLOCATE_PUNCH_HOLE
>> @@ -1885,6 +1886,9 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
>>              qemu_mutex_unlock_ramlist();
>>              goto out_free;
>>          }
>> +
>> +        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(object_new(TYPE_GUEST_MEMFD_MANAGER));
>> +        guest_memfd_manager_realize(gmm, new_block->mr, new_block->mr->size);
> 
> realize & unrealize are usually used for QDev. I think it's not good to use
> *realize and *unrealize here.
> 
> Why about "guest_memfd_manager_attach_ram"?
> 
> In addition, it seems the third parameter is unnecessary and we can access
> MemoryRegion.size directly in guest_memfd_manager_realize().

LGTM. Will follow your suggestion if we still wrap the operations in one
function. (We may change to the HostMemoryBackend RDM then unpack the
operations).

> 
>>      }
>>  
>>      ram_size = (new_block->offset + new_block->max_length) >> TARGET_PAGE_BITS;
>> @@ -2139,6 +2143,9 @@ static void reclaim_ramblock(RAMBlock *block)
>>  
>>      if (block->guest_memfd >= 0) {
>>          close(block->guest_memfd);
>> +        GuestMemfdManager *gmm = GUEST_MEMFD_MANAGER(block->mr->rdm);
>> +        guest_memfd_manager_unrealize(gmm);
> 
> Similiarly, what about "guest_memfd_manager_unattach_ram"?

Ditto. thanks.

> 
>> +        object_unref(OBJECT(gmm));
>>          ram_block_discard_require(false);
>>      }
>>  
> 
> Regards,
> Zhao
> 


