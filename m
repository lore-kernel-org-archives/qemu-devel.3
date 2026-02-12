Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 499D3ECD6FE
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 00:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqKkE-0007sH-9G; Wed, 11 Feb 2026 19:39:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1vqKkC-0007nu-8y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 19:39:44 -0500
Received: from mgamail.intel.com ([192.198.163.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.j.williams@intel.com>)
 id 1vqKk9-0002Ck-7Y
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 19:39:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770856781; x=1802392781;
 h=from:date:to:cc:message-id:in-reply-to:references:
 subject:content-transfer-encoding:mime-version;
 bh=zyrhul+D0zktNhyfQDH4Egw5dTJ0PXQejQDHenL/ewQ=;
 b=hBzS+jrAVa/ULi0Ufk1k4iQKlfFuL/8I0SrP0tpJ596A/AXbf5s9w8ox
 prWRCNUsU3ET+gOqkjkUFBCKkpAdMUI1c7/DaIlBDa40n2LvVavmTgGuX
 mjTIHiQGhAz5apRRHxPWpuCPhEwsXLJusvAoDxd9qPq5O3RgykmH2OZd9
 Rzhl0w3vArLnAgsVKq6Dpb5HUx9XGyZm/s3g1RxhQAX3z2rMGEwn0aYMJ
 SwUTQRWeyJ9yg9eNRVBZ1mWNnjMA3X8PvNaAoabaXMqSpUPWMrEott7Gb
 +Fo3vXpo+RcYrUjfObQFOOcNUEP6Y1KUoDJAiwSuBdbe/JnkXbHrpiHL9 Q==;
X-CSE-ConnectionGUID: iRM90dpORlmtI5e3vIcnGQ==
X-CSE-MsgGUID: j4Jd4qClQF60i1JfUauV3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="72114959"
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="72114959"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 16:39:35 -0800
X-CSE-ConnectionGUID: mAw7n9z4TVyVQhJwc37txA==
X-CSE-MsgGUID: gH9yfNqbSci+QUotVmvjoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,285,1763452800"; d="scan'208";a="242103892"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 16:39:34 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 16:39:34 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 11 Feb 2026 16:39:34 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.33)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 11 Feb 2026 16:39:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YSKrPNchfV07fQxx6aArGp2fc3CWa5Sb0ZozP+CLZxklJzAG5j1hpm8xgpc7cv3Q1tEexM9fUmk8rB2WeoI9F/CYvhfz5qD7GMAlprQ1QJDIVdnARXpEZr/gas5LHW/FTWg+NKgB8FoUrtBU1R1LP7EpgFJSAi+9h2N2w/1VEPpmAkDltmc18UEZys7bO9JdYTSoenfTEhe/7sp87K8LLmea4EQVYGTWXLkEdcuvvSgxI2eW8hJDZ0pS62Vx3gDYrF8Qwa98kjTXk805EXP7m89YTCPOcu2A/RBNLPHTniVGt/lqtIZd+DvMg9+Yok4gGY710DIrazkdXG/D/uC+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Le4ERL3ypsraOAWf1b4OyC03ZcWp5uvWPKMZu04UskM=;
 b=buHvcEXQR3F1SSElAlTWdAN5xM7Pyj1Rc7EZukKbsJU/PN9RmK+ljfVyM2n2HWl5JVaShjmyok89tmUH9kyU5W1JQFmYD7KD4SxKQb4KLnWyopWbjeHjvpVKO/uUcGnNM1lbToE6wQlh4v6W6kKnjsBF6pY6tB5yCVv2mZY5acQa+X5gEOOjTJiyt5RCHk5NtYDSX3gno1GhLQaZeeQtFqT2sPIzTd+cE8/EQjLpa2Qs4Ou/IUAYSvZrxRpugLJ/5h+igAz1sLBH5SYGsWWO5Eswo/pYFk36rJb7234P2OF9xvydHqKSNSSzc4cJ6iWfA3QJmVofWv31530wMKCVHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA2PR11MB5163.namprd11.prod.outlook.com (2603:10b6:806:113::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 00:39:32 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::1ff:1e09:994b:21ff%5]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 00:39:32 +0000
From: <dan.j.williams@intel.com>
Date: Wed, 11 Feb 2026 16:39:30 -0800
To: Cui Chao <cuichao1753@phytium.com.cn>, Andrew Morton
 <akpm@linux-foundation.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Mike Rapoport
 <rppt@kernel.org>, Wang Yinfeng <wangyinfeng@phytium.com.cn>,
 <dan.j.williams@intel.com>, Pratyush Brahma
 <pratyush.brahma@oss.qualcomm.com>, Gregory Price <gourry@gourry.net>, "David
 Hildenbrand" <david@kernel.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
 <qemu-devel@nongnu.org>, Jonathan Cameron <jonathan.cameron@huawei.com>
Message-ID: <698d2142a8421_8c321003a@dwillia2-mobl4.notmuch>
In-Reply-To: <20260211103320.2064211-2-cuichao1753@phytium.com.cn>
References: <20260211103320.2064211-1-cuichao1753@phytium.com.cn>
 <20260211103320.2064211-2-cuichao1753@phytium.com.cn>
Subject: Re: [PATCH v3 1/1] mm: numa_memblks: Identify the accurate NUMA ID of
 CFMW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:a03:333::31) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA2PR11MB5163:EE_
X-MS-Office365-Filtering-Correlation-Id: d29e010e-f2c6-4675-acad-08de69cf300b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q3F1N2c2WGxnR2tuYmZPQkRXWE9TQ3hiVXg1RGtPSHZxWlE2aVZNQXcwNHo1?=
 =?utf-8?B?K004Tno2SCtxM05lYmpkQjQyUHhNODFBLzhmQnFzbmhnNkhzNjhTcDJqMERW?=
 =?utf-8?B?ZlVKdldveGNXS1RuQ2syYThhZCtZeHNwVlAyUjZvOHFHbjVub1ZJTzBGbElw?=
 =?utf-8?B?bmV2ODVPcERzWVRnZThwR3dBR1lZU1dSWEhaT2YzS2NYTUlvTXFhQVNSRVZX?=
 =?utf-8?B?dk5MNGdwbEYyOFpwR2ZiQ3ZwejRJYS9uVXNwZnBBUHhRN2k5UHBjQnFuZzcz?=
 =?utf-8?B?eDBielNpTGszOUxFQ09HRmliUEVpb29zcDFzYVYwN3FrcnliS0xoRzRsSVQv?=
 =?utf-8?B?UnFlOGhaMU04YVdrY2pLaDBqN3VnckZOSXFGYlVVUHcrSHVPdDlRakhCd2pO?=
 =?utf-8?B?RFIxcTN4ZWorNFJmYndTS1M1dkNnam16YklDdGoxeFJ6d2hyUDhDZFNhbGVx?=
 =?utf-8?B?SFBCOGluSC9DdWtTQmN2YW5Eb1JndHpJd2c4VDBZWFJwd0JyTVZscDBTSHY0?=
 =?utf-8?B?THpBWUZqUks0ZzRTRTl6ZWdpNE1VSzUrWDhHRjh2Tm93clQ1bmRHbUdJVEMr?=
 =?utf-8?B?MUdjSkhOVHdwZGpxSUxiZno0UzN5dllMVlRta2tTS1k0NzhvV21sNytEeGVu?=
 =?utf-8?B?NnQrR3VqZWllcjlNUkVVSll5SGpUcjlXWDFSZzRxWFZJMFVSVndPN2JHZUhF?=
 =?utf-8?B?SS9WR1hXMXZtK200UXVZVytYcHpKV0hualBmMjZMSm8zTW01YmgzVHEvRWJh?=
 =?utf-8?B?T21kejFOYWpxeHFWM04rMjIwb01mNzhkRWVwbFRyMGg4VUk5ZnZNeDJUSVNR?=
 =?utf-8?B?SWptdmJRT2NqSG1MN3dBa2RLV1FRcnpKd1BBOTZaVTJYOTJIRklQN3RiOGEy?=
 =?utf-8?B?Q0lXYk5mUmhNRU5kQkJPdko5cVZUZHYrRXhFd3o1eFJlZ3owYW1FRUdRa3ZF?=
 =?utf-8?B?WWRsSkZrM0dieGduMlNvZGtXT3NqdDhablJ0WER2VCtsVnI4aHVnRFBONXo4?=
 =?utf-8?B?bG9WSmxGQnp6V2dyd0N0TjRyVFhuU0FMZlkwOGNLYWlJdUFPdXZEakd6SWI0?=
 =?utf-8?B?Y21XUHhkb0V3SDVqTS95dFNkZm9Ba1JLWkFWVnlNOG1pczY1QVAvYTgxSkpG?=
 =?utf-8?B?dkQxNEY5aVJJdjJFeWNzRGd2cllQOEdRNjNNeUhWdUpUUE5aYWJsbC8wTnMr?=
 =?utf-8?B?VDd4UkwwUUJ3RmVCSHFRbzVRWXJ4eWE0K3dXWHNNM1lrVmZPRUtRcGpvcXBv?=
 =?utf-8?B?Q0tJU21OTkV3c1FjbVBBSXhjTWRqcEVyR0xTYm42MWNycFpiVzR6SDI4S3JD?=
 =?utf-8?B?Z3BkeHRxWmFscDlVRFQxUmZoSUVwVnhzSGxNY0s5Y1VXcVdwQkhTMWxkMGQ1?=
 =?utf-8?B?dWFoRjZLa0xmdHBwc2Q5ays4WXZVaHpiU0JVZ3Z4dDNWTXgvMHhQbjlaeDhz?=
 =?utf-8?B?cHpxWU9QK1hxRDQwZ0JnVzhNZ3d4KzQ1MXVtQkNrczNRSEtJY1h3bklXbzdJ?=
 =?utf-8?B?eGdrZEtrU2dldXlBMkE5dlo5UERkSVpRUHErVXZlMnJiN09ndWJDbVo2Y0Er?=
 =?utf-8?B?R1NoWEJpWnNYQlM2dk9ETjc3SUthRFg5aDF3aG9GZFdYYzBpOWEyTjhvK01w?=
 =?utf-8?B?UlZPVm1OaFg2VlBJdHllT1Q4MkJoQkdzUmN6NTFjOWdsWFV3bm04S1RDcTVP?=
 =?utf-8?B?VVFxcFhkTjFyNng5VXZHRkFEazM2SFJKY0xXT3RCU2FobDJJQXJURDVJQjFS?=
 =?utf-8?B?em5kMEpuTjFBcEJWdHpSbGt0WWtXOEpyakRNMDVuUFJtOGY5QktXV2ZaN2xZ?=
 =?utf-8?B?SlYwZlRHbElDOHdZcUltaHgxbE1BKytWOE5lRlRBUDEyZlRIdFJPWHlRTDBQ?=
 =?utf-8?B?Z25OT2tsU1lFQ09wVmEvQ09yZnIxQXVEbXFRb0lBdWhPdm56YzBYcXdkL1NK?=
 =?utf-8?B?aGNsMFVJOTlsZXZJL0hpQWN0ZnNJYVBFaUxiK2RnMTdYWXBRY1ptRHVhc1V6?=
 =?utf-8?B?aC9HaW1JR2x0Z3JuVDdlaCtpNHdHM0xxVUNGTTh0TDJHc0NWRmNEWlhFc3lX?=
 =?utf-8?B?M2prUTNocUtYd3F3dkd5K1B2K3dTRzRsRVBLcXM3a2FJUWFoSXBTR0ttQ21x?=
 =?utf-8?Q?sorg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8107.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFlteW5wdnU4RHBxWVNPM3lJeTl4RUs3Zlp0aUUvd2llYXlwOTNYb0NUaXZM?=
 =?utf-8?B?U2RpN2VLL3EvUGVQSklkZ1BRTHB5MHFqVjdvcWlDT1p1SnV3d2o3UXJndkk5?=
 =?utf-8?B?SFNaUm5pTDJpUlVOcHh2ZFpiMUo1VlFlM0tnTU5KaGlTbWZ1RDdHQXNqbnNz?=
 =?utf-8?B?M2JFNGUxVWNkQm43VDlLcW1EbWhmQlV4RjQ1ZVhXMjRBOUZ1aStiYUVTaFhM?=
 =?utf-8?B?K1Ezb3R2VzFGYzhEdTdBckhsYjJqOEJYNXhJN1hlTVZqZXdmUHdTcHdDMEY1?=
 =?utf-8?B?VE9iT1BpUHlKKytaYmpBeGRBVjB6dGF2bm94OHkvTm9CN1YxbWJSOUx5ODl3?=
 =?utf-8?B?eC8yWEpYaHRRYmVtTDBzWDdyZGdYVXlvWm5aQnNnbXFQQm4rQUpnWWpnY0FI?=
 =?utf-8?B?enBmbkd4R3cxMTIzS0lIeStVK3MyQWJHRzMwTDkyWFgzQythR2o5WlNIVFlU?=
 =?utf-8?B?VmVFeE9OOU03VWlOQVlEQnk1b3E1djNoSUFnNENLd2UwZjcxc2RtbThPeGlz?=
 =?utf-8?B?RE1NV2xTUThQODBDaG1KMWluZ25ScC9VRlJuQ3VWZU1ZdGlKREpGZ1dQaW5z?=
 =?utf-8?B?MlhTcVphNlJIUVFXUnpTMXNKOHBCL013ZzNob3lLZEl0L1ZJamFCa0FPZU5x?=
 =?utf-8?B?S3cxdCsrNnNkK1V3WWE4Q1pHU0FvRmNzOWZaZTRjV1BheU53SXc2czc2QU0y?=
 =?utf-8?B?SzE4eURYazdqdlhzQjFOZjAwWUhZUXdDNkVvRnVLRXcxSkJZcndKZjU1MFRw?=
 =?utf-8?B?T0tHRm9lZ0hjZkRrc3dxT2dwd1BBWWh1QjRYRElVSWdBOGpKOVhjamRBaWMy?=
 =?utf-8?B?K2dac1YzV1VBLzZ5Tk92SmpvRnJBKzBCMExWdUNIUFdiaWxtN3p1Z1pyQ1Av?=
 =?utf-8?B?Q0FpTDZsNUdNVnhrYkpML2djc3hNdFB0byt3cldsVENWSWtoWmRiUGhBVUUw?=
 =?utf-8?B?OThaVnJuNFRaQUpCYjIvKzJ6TEZYbGExN1l0MTlPUGtoRXV0S0JxRDZaMTBW?=
 =?utf-8?B?cHFWdFBaSTJkeGNEVUk1bnM5RFNTQXJnYkJ3enlITHBPZ0hmQTBxMGR1WkpC?=
 =?utf-8?B?N2ZKOTFrYlpOa2htVGJUUHZXTTIyN2JETUdoYVh6NXk2d1pUN3BBWE1lNmRl?=
 =?utf-8?B?SGtOUmRsMUZvOHpsQmw2dUVYY0Q0MWcrNE9xdWhkZ2tTT0Nya0VVWWpnVFV0?=
 =?utf-8?B?N2srVVpkS0xaT3Zja1pKdWxnQlJsb2dVYVNQV1ZHYzFzMzBOUU5wTEhSQ3cz?=
 =?utf-8?B?NlpCL2g2VWsva3p1dHp5ZGU0QWduQnl3NG5HZ3JjaFhUN1Nucmt4bVpDMk9z?=
 =?utf-8?B?TEZxOFRxTzU3S1ZQVkFETXEzdmlDb3Z5VjduWkphd1RrZUpCaFJ2QTNqUnE2?=
 =?utf-8?B?TnFBNnJDaE1EOUJZdGNKYmpjcUlPVU5XRnIwMzJoMVZsZDEvVWdnRWkzMEZZ?=
 =?utf-8?B?RUtIZU5ibWVIb2l5a1dkOVlENjZwNUd5RytNWStReVZFMnVYVURFcWZYVGI0?=
 =?utf-8?B?YmZCODAzRnYrVTBreWVKN2RoVmRMTTB0ZnJPRzVPOGtnYS96L0xsamU2c3o1?=
 =?utf-8?B?dW4xQ3Vqc0F4RlUxaHhwM0VialhneGxmZCtmYXVmcC9RZCs1blRmb3FrNDB4?=
 =?utf-8?B?Mnh3aVdVOTh1THl4R0RjZ0NBWDg2Zjk1ajIwbGZ3eFpuL1pXWEVTUGkzY0tD?=
 =?utf-8?B?Y3hkbjNVQTY3UCtWbDNFN0VadGRpWFhIMWU2Z2ZCWmovcnNhR2lXV2JmZlZn?=
 =?utf-8?B?S2NFRjJPRnpFZHBBMzJyaGxCMDdIdkZnVG1SN3kwcUt6VzJjcHZHd21HRms4?=
 =?utf-8?B?N2RzN3dZUHRGczErMnpBdU5RVFI4TlY3S1lIdENMRFI3VDcyS29UQ2dKWC9U?=
 =?utf-8?B?VndmRy9kbUlMRG9WVHhuT2ZKTmc2TThnaXJTa3JWUCtrck9sYzI2V0N4bVNk?=
 =?utf-8?B?dnhQd25wZWdSdEgrQUlrVkdFZVA2aE1DQWNaMEVGbTFjVzllUXpYQlBGcUZG?=
 =?utf-8?B?cGE1NmtQV1l1OFlRUXhYVUZneGZVc0U4c1J2cEI3MEs5M2kyZHNPYTRPRGdy?=
 =?utf-8?B?RjR4ZFg3UVBsYmJoaDFGUmQ3SDY2Z1oyVFErWEV3UFJ3VkpFdllzVVpyeG1Y?=
 =?utf-8?B?QjE3Z2lpUUIwdkRJZXpoRTRvcHdhZ2l5eDM5eDUyUGxXTStoQWlEUEdUdVJ6?=
 =?utf-8?B?bTc3eUtUVDNMY0pQVnB6L3hUSXdlUnp2azNTbStkYWhxUkRkRURkcGpvS1N5?=
 =?utf-8?B?cU9SQXYvVEFHM2JqK1hJYTQrakE5ZUgvczk1aXBQR3dzb1Uzamtsa2c3TFhj?=
 =?utf-8?B?dnlzQ05YVkZtWFRVL2tOalczM01UZndYcmpXVDlUWmg2eHphTjNUeWhQWjhY?=
 =?utf-8?Q?Dl/q1LH2UWk97TGg=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d29e010e-f2c6-4675-acad-08de69cf300b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2026 00:39:31.9510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3F6EV5TbkO1XWNk7cPqIT+gHd3L5vpv7JZW6FvZA70dJfR1TOQlIU8KbfuqohECEq0ZlJbCft5Frqb/kFToCoIJL3oF9fOei+bDqFVROqrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5163
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.15;
 envelope-from=dan.j.williams@intel.com; helo=mgamail.intel.com
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

Cui Chao wrote:
> In some physical memory layout designs, the address space of CFMW (CXL
> Fixed Memory Window) resides between multiple segments of system memory
> belonging to the same NUMA node. In numa_cleanup_meminfo, these multiple
> segments of system memory are merged into a larger numa_memblk. When
> identifying which NUMA node the CFMW belongs to, it may be incorrectly
> assigned to the NUMA node of the merged system memory.
> 
> When a CXL RAM region is created in userspace, the memory capacity of
> the newly created region is not added to the CFMW-dedicated NUMA node.
> Instead, it is accumulated into an existing NUMA node (e.g., NUMA0
> containing RAM). This makes it impossible to clearly distinguish
> between the two types of memory, which may affect memory-tiering
> applications.
> 
> Example memory layout:
> 
> Physical address space:
>     0x00000000 - 0x1FFFFFFF  System RAM (node0)
>     0x20000000 - 0x2FFFFFFF  CXL CFMW (node2)
>     0x40000000 - 0x5FFFFFFF  System RAM (node0)
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> After numa_cleanup_meminfo, the two node0 segments are merged into one:
>     0x00000000 - 0x5FFFFFFF  System RAM (node0) // CFMW is inside the range
>     0x60000000 - 0x7FFFFFFF  System RAM (node1)
> 
> So the CFMW (0x20000000-0x2FFFFFFF) will be incorrectly assigned to node0.
> 
> To address this scenario, accurately identifying the correct NUMA node
> can be achieved by checking whether the region belongs to both
> numa_meminfo and numa_reserved_meminfo.

Looks good, thanks for the clear statement on why this matters. Going
forward, conciseness is valued. So here is a potential condensed
statement of impact:

---
While this issue is only observed in a QEMU configuration, and no known
end users are impacted by this problem, it is likely that some firmware
implementation is leaving memory map holes in a CXL Fixed Memory Window.
CXL hotplug depends on mapping free window capacity, and it seems to be
only a coincidence to have not hit this problem yet.
---

With that and adding:

Cc: <stable@vger.kernel.org>

You can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

