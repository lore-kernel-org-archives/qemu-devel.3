Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C820D1119C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 02:46:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7n5s-0002eK-0k; Sun, 03 Nov 2024 21:45:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n5l-0002cM-CF
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:45:23 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n5g-0000Id-3k
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:45:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730688316; x=1762224316;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=8Cuor3tITfTkg37XuZ7+JkftOnn+TF53PSwYScnLMhE=;
 b=YnMkEEBeqTNaIm1dBk23uxba2tWYwiYStVGIKuXQ/ikUig42ZxEEVBpe
 QXNsIyol/WFfg02duWG0VJpMXL5qgyXDbWCLao0htMl1Xw31HIXdVht3x
 PTo8hLjtWf7joU/BwRwDAK0dc22C6ZTvpXkK6TndRn178v33jnERiliB3
 NWKCHLvnFbbnA+BheI7Ek6ETB9WohQIJgGD/0ddffOjt7a8JHlHzMVY5z
 m3DB74nvO+JqDsX3Gf0qYHSz79uIMygCMNK903XhnOZWsv5msE4HiqWp6
 lDLIWs4TC0K3o+8QDVPe22DrPZp5DOAPnv3LOHyetjzuIZJYvTK/rde89 Q==;
X-CSE-ConnectionGUID: YVdM7T2rSNGT5hYo7+FCyQ==
X-CSE-MsgGUID: e1mVEBT9SxqRXwGdhdZDnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="17989795"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="17989795"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 18:45:09 -0800
X-CSE-ConnectionGUID: C5nU1yiaRlqEvZfECVLL/A==
X-CSE-MsgGUID: +gKVa1DDRJakNHxI5GEvqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83651020"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 18:45:09 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 18:45:08 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 18:45:08 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 18:45:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cs+cbMgP3XAT17MHYhiyf8fiI9g9jTZSvCLQifa/puUaKOf9SSM/zLq+2SxFUy9nGNkHVhyO/zUARQz9z2hMpaCKzyT1VVvncG1WA5ZwToQOLTHJ6pJcdJq7W73AlQeMZ0Kj3zDmp5Mjim4Fio0KeVx0Ex03dloktF/Zial6Tzn/qx8pqmBLudHBrezNopGIpREtA0kVe6+BQW5nW8wnD1TEZ0aE4jmGVVkk4xBpd1IaLo6N55CtKsqgs5NDL8sXy3DM5rkUe8q8vL+WmGxqdJdjkeiWHOQFTEDetpbW4ws5UqrvpR8tR+843Un0eI/zU6nvqTnlcMZqTJQzpKE+Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMGSIrDQ2a5jNhkv9Q8Vgq60G6bU4oBdMcu/JnhG0LQ=;
 b=FQKaKSCwzylGSPdvf9l3CSDGQen0QSXQyjapmAjUhJP2k36N3oBF8LnbFG6Uv8UTQxpglFG7CYu+qouAfbKl9ybGtAPno93iYh0hVYm/Hrfk/iP4gQxMmVqWJe6skAXaqvHUe34dQgSDQ/zsZaXoeFwNJrOYN4RnbNcWF8FZi6O286kAVraYY8WpqpX/Oi2U7Jtl5Svf3mr6NtK47XCj7eVomZnQjs5xcIFVMstwtHbWQ1UUZBgIEqfWckujmX+rNrCUiQe4upg1Meom9dHVixsN1g3ex32EL8TqOdsm3FFcntI2EU7MHuOvh3H/M/HKKZYXpID2INiT6NpFtIoMPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 02:45:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:45:06 +0000
Message-ID: <aa20a879-1429-41b7-99af-3264fb62ec64@intel.com>
Date: Mon, 4 Nov 2024 10:49:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] intel_iommu: Set accessed and dirty bits during
 first stage translation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-9-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-9-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0228.apcprd06.prod.outlook.com
 (2603:1096:4:68::36) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe3b513-044d-445f-df84-08dcfc7ab02f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WmpKT2RyVkpOUDhXSStwNnlOVWNYT09Tek81OFB0MElwL1hQUDJEaXFiMDFy?=
 =?utf-8?B?VFpPcXBxYUI5NG5qajREV3BsWVFYMDVHRE5ZNlF0NlBwZythNEo4YUw4Q2VK?=
 =?utf-8?B?TjlSNm00eDAwWWhnelRlOVdnN2JQM2g0S2RLejhzQVFYL0ZZdDExVWw5bzZt?=
 =?utf-8?B?eXJQZlFVVFJmcEJzN1NCTmRCTTRJZlVQbkkxbURxYkk3Tm5YNHNhbVlQVW55?=
 =?utf-8?B?QS9HUVFmNkdlaklsblk1ZEl2cjlvY09pNWNBNzJOUk1oa0RBbURXUFU0Y1RP?=
 =?utf-8?B?bUg5eXQzYUJHRXJuM0JEb3RtWEJzK3puY2d2ZC8yNXNuRFZjWmFEQ2laVENo?=
 =?utf-8?B?S3o0VVFYZHFla0hBcnBJNFJ6NkEyU0tFMDJ0Ym1hMGFWdVQwMHVkZ1RiNzBp?=
 =?utf-8?B?UGJRMWZQOUZrb2NNbFViUG1TRDlxZWVvT1VZcjlMR3pPNnpqeDBLd1pnU0VY?=
 =?utf-8?B?ZDRWZ1BtcHJIdUVqWmd5YUJHUEZnMGU0b2c3UFc4WnhHZE9jY1VEUjdjb0JL?=
 =?utf-8?B?NFl5N2dzMERrcllGdUg1U2pVeTZBS0FUVzFaczFOMHZZUklkS3EzUkJvZUtT?=
 =?utf-8?B?dkdqZzlUVWFwSmlEVHdWUDhHUlQ2VTlTK0sra0lKY0FTMlN3UEJqcGw2U0Uv?=
 =?utf-8?B?UXhpRXF6VXFMTzJxZTRQZ1NpUHhLcWdRd3JQdWVGbENBd25oM3RXMzhnNS92?=
 =?utf-8?B?V2QzSk5ZelArc2l5elEwMnNrMkk4VFVMU1pKTHorSXhTeVBsZ3NvTGptN3NZ?=
 =?utf-8?B?Tk1MRzgvZGVac1lwQTFRUE1QL29rS1JaSVFCU0tIbC9CR005QUMwMEZPMHV1?=
 =?utf-8?B?WU1PMlV5aENVaWd3c2R2SVVYS3Z0SGtEelRPN1YyTFF1cS83UzlUL1FJQUZT?=
 =?utf-8?B?SlB6aHREaDc2WVlRMngwMHVYZGR0VFl6MVNxcUtmeStIYVNyUGgxOVlJWjBX?=
 =?utf-8?B?clpWYVhaeG56TGVpMWk0RUYvby9TRzBTZTFyTE55RDlHV0twRXlCRnl2eWJ6?=
 =?utf-8?B?cjZZOXVWU1FHMTl4YWtOWVhFcWhuWjNLNE4rRDlETjlkUlJOVU1EdGlwZ1gw?=
 =?utf-8?B?VEs2b2ZGb2NhUVNzRkl6MFFpZWEvR2YwR3FHbGdzams0eUVEL3JIQXAwOGE5?=
 =?utf-8?B?Zi8rRE9QczNDazQrTEljenhTNzhmeFVZdlNzcnFVQlRPUnU2Q0xYbUVxS2tq?=
 =?utf-8?B?QUlMek0xWk1oY0hVR2g3Ty8vWnN0bGdzY1R0WHV4Q2JON0tNUWdQQ1V4cnk3?=
 =?utf-8?B?WlFyaEdYQjVyQzFWTS9MVlZUMUFkdjJUU0VZQTJNZ0JkZCtzaVJjbEJBS0lw?=
 =?utf-8?B?dm1tRG0rOFRBOSt3cmxWcVVDK0grS2I2TTlVSVJaV1A2ck9kT01XdkNYeFpt?=
 =?utf-8?B?cGM1dGZrMUFqQjNiY1BpMThaTm1vTTVHRW1vVVc0M0dqYmxSdHUyRTNPY3kv?=
 =?utf-8?B?a3VxMDNzbmxqTThxLzdxYjBOWHdFTWFwT0IvZGRYVWQra0pIT1djZjh5Tk5Q?=
 =?utf-8?B?WHgzNjRXWmZpRWRmMm1yWUhGY2EzOHg1Y2VHb0Jja0hhY1pZVURONGNqdHRj?=
 =?utf-8?B?ZEtiOWxZQVpSdkJGcVpuSXF1dm44Qm42dEpFRkVMKzB6TUsyTmtrSGlmOGtz?=
 =?utf-8?B?SjVqK0l0Rlg1U2p1UHFaVUN6ek1FWFRGZ1d5L2Z5cnBwcWNqWUhubHQvY1Ir?=
 =?utf-8?B?aVBtZWhKd0hVL1BLZ2V2VFNDM0JLaHV1dFVuTFpDUDBjNGJIdUIzajNGL3o5?=
 =?utf-8?Q?gKir6654zr1N6oJXd52idTKf4JMbQ47a5cNOYyT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U01UTzZCNTYzMXV6cy9UZmwrNFFuaDR2cklWVHBPZEFPZ0lYSzNFSTlKTm9V?=
 =?utf-8?B?VEFFSFFWT05IRzRQbHN6MUFscit4U0hkYnBoN3pkOURRWncwbUovc0ZaOThi?=
 =?utf-8?B?dFlPaTN3bXVkMWNSNmJzV2xFdkZaWld4QkhhTFJOWVRJVDc3YWp3NWtMS2Vw?=
 =?utf-8?B?SHdLZWJ5Wk0wYVM0WHdqRmc5dmllS280Q3FXZ0lvT2QzRGw0azRXVldLa0xO?=
 =?utf-8?B?TDRheGNVZjJ1aittMzNnQTgrL3ZpNEVnWFk1a2RmRXVWTjBreTNhU0tpWmlD?=
 =?utf-8?B?V2lZaUhSYmVLZnR1Y2F0TDg4UytPNFVRTFNaZ3g4aUFjb1V6bUVlMlZBdllO?=
 =?utf-8?B?S2c0VnphYW9NbW1Jazh6N0c3SGFYT2RNeit5VGpmdWxnc1U0b2p0dEZIaWRw?=
 =?utf-8?B?QUgybWMwNlNOM01oSGhzTXozNVQ1WG9GVmVnZjJRcGxKVEdZQ0NVR1RqVWtM?=
 =?utf-8?B?WFBpUlMya2dJd04yWGlQSGZiU1RLb25DZG1GNlRZd1pDb1dDaVI5U3dsTEI2?=
 =?utf-8?B?ZFJvUVBJV01tbVgzcmlldEFDYzJrcEtnWFJLK2RxVkFuOWZXbVZ6Z1RBekJ2?=
 =?utf-8?B?YWFYYjdMMVVEdGdkT0R4eVhDa3VtYlo1N3N3bUdqSjE2OUwzYzdINHNpYnZ3?=
 =?utf-8?B?NUdhQW1BM2FpU3RnMkZEdFpSLzkrTlFuMG96QnJvaDVRdEpqSS9PdkZ0L3Fp?=
 =?utf-8?B?N2svNll6TlJUaHFKQU1hUkdScGtickNwcjY1M2I0TTlBTWJsYXE0YUFGaWRk?=
 =?utf-8?B?UWRmN1c5Vkx3MTVTRWFPNitibXRmckd0aTNreG9PQ0FNb0ErYXIwTk50Ny9G?=
 =?utf-8?B?c1h2V1FRaGloblVOSzkxeGJxaXdlcnBTNjBNaUtRL3N0dmZZd0dUWkE4dnYz?=
 =?utf-8?B?QmswSWxqR2hrSUFaWGl4QW82cnNyUGI4KzBWZlJLY2JFUk1vUzFhTk1NcGZN?=
 =?utf-8?B?OXpGNHpZVjg1d3F6WnVvUzg1RXlsNk9aWVU2Sm9xMk44TVNHSjJHSUo2YWEz?=
 =?utf-8?B?MUxEOGZja0hyV1FBYTBNVDhpZG02ZmJKdWxIcHIyU204VDNpM0M0OXFyTHlh?=
 =?utf-8?B?L0t5cVFVMlRYYXQ0cGtIMjFKQnlCdHU2VTIxbHJEeHJVYzNkNHJuUUxmNUQ3?=
 =?utf-8?B?UDNFd2QvRHlra1ZHeUNDbDdhMlk3TWJzc1A0YnNQUElLYzFmd2lUTml5VXYr?=
 =?utf-8?B?NWtUM1JnZlN2M2dEVnp4WFQwc2N6Y3VBZzdOTjFhTWhabG9qWEFVTmcrV2J0?=
 =?utf-8?B?cHhsM00rMXQ0bmlxQVV2TkZjeC9CTzdFUXpTalNkMU5oTERFK2JNSlg3MnFM?=
 =?utf-8?B?ZUNuWVFGSUJoL3BDOGdCdmZYQXlNL1U3SWx3b2R6c3cxVGhSMUx0QmR5RmRh?=
 =?utf-8?B?dERreUY2TlpCNWFtR0xxeWFPcHRrdlprU2ZOcVNBZEkzSkJLTVcweUp5TFlR?=
 =?utf-8?B?SUlka3dRMEJiUVdNUWNGWTdZbUdPQ3V3SElpMXJXOVZoVGdzMXJxZ3lVUWN0?=
 =?utf-8?B?aUJGME95RXc3V01CK2lrT1ZaUzNRZXJUUWJZTTd4RHBMNlNpZk5GT1BwV0Jn?=
 =?utf-8?B?K0hSaGdlM1NMKzNxYkZUdnlEMWNUR1hoTVpRaWc2a3dmR1hHZXJFMVhDSFN5?=
 =?utf-8?B?aGdZb2l3QzhwK0hmaXhxa2pDcU5LYlpDUjV6TVBHQ2JEL3VLUFJOK0FJNXNu?=
 =?utf-8?B?S2VSQmtNc29ZOCs4WEhRbnVtWFBMbERJbEplRFRpVmg3UE9Md0tSQjZLVjRN?=
 =?utf-8?B?WEl3Z25zVlY1bnMxTEd4ci9vaWRVK1J1SFhZK2t0b2V2RFVrb2Q2ZWZSVnQw?=
 =?utf-8?B?Z1FHaEhCZzBhQnptUzRxWll0Ykthdms2UHFQLzVtVjlqa1hrUVZXSmt0N1RW?=
 =?utf-8?B?SHNGdVBuUFZwNG9lbWVnSjFaUzUwNll2UDM4QU9uYW8vL09NUDRRVWcxUmtq?=
 =?utf-8?B?MzZpcHpNQzUxOStRQXF6eEp2WU54ZS8ySUhxcXozdXhUK2t3UlMzOE9XcHJH?=
 =?utf-8?B?TDBVa01ySm1mNUtleFdOMUJKbm9Rd1BTQjYrSDZVSEFTN2JnU21jUVljOGRj?=
 =?utf-8?B?Y3U5emhOWTZjZUhiaHVtVExkU2h0bWU2RjY2QTJuVm5ocG1ZcU4vVkdRU2hF?=
 =?utf-8?Q?b0q5NPZIisqfci8gpUt1006+L?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe3b513-044d-445f-df84-08dcfc7ab02f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 02:45:05.5064 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xHQZOhbP/1LRlyPVxwcZKBvrXhygkbydtbxrm9ndMeSWNxWsTSiV/gBcH8MhfpGFtqwuuA9X4DBVVQ9/ABW3Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.16; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
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

On 2024/9/30 17:26, Zhenzhong Duan wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu_internal.h |  3 +++
>   hw/i386/intel_iommu.c          | 25 ++++++++++++++++++++++++-
>   2 files changed, 27 insertions(+), 1 deletion(-)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 57c50648ce..4c3e75e593 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -324,6 +324,7 @@ typedef enum VTDFaultReason {
>   
>       /* Output address in the interrupt address range for scalable mode */
>       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
> +    VTD_FR_FS_BIT_UPDATE_FAILED = 0x91, /* SFS.10 */
>       VTD_FR_MAX,                 /* Guard */
>   } VTDFaultReason;
>   
> @@ -545,6 +546,8 @@ typedef struct VTDRootEntry VTDRootEntry;
>   /* Masks for First Level Paging Entry */
>   #define VTD_FL_P                    1ULL
>   #define VTD_FL_RW                   (1ULL << 1)
> +#define VTD_FL_A                    (1ULL << 5)
> +#define VTD_FL_D                    (1ULL << 6)
>   
>   /* Second Level Page Translation Pointer*/
>   #define VTD_SM_PASID_ENTRY_SLPTPTR     (~0xfffULL)
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index ec0596c2b2..99bb3f42ea 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1822,6 +1822,7 @@ static const bool vtd_qualified_faults[] = {
>       [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>       [VTD_FR_SM_INTERRUPT_ADDR] = true,
>       [VTD_FR_FS_NON_CANONICAL] = true,
> +    [VTD_FR_FS_BIT_UPDATE_FAILED] = true,
>       [VTD_FR_MAX] = false,
>   };
>   
> @@ -1941,6 +1942,20 @@ static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
>       }
>   }
>   
> +static MemTxResult vtd_set_flag_in_pte(dma_addr_t base_addr, uint32_t index,
> +                                       uint64_t pte, uint64_t flag)
> +{
> +    if (pte & flag) {
> +        return MEMTX_OK;
> +    }
> +    pte |= flag;
> +    pte = cpu_to_le64(pte);
> +    return dma_memory_write(&address_space_memory,
> +                            base_addr + index * sizeof(pte),
> +                            &pte, sizeof(pte),
> +                            MEMTXATTRS_UNSPECIFIED);
> +}
> +
>   /*
>    * Given the @iova, get relevant @flptep. @flpte_level will be the last level
>    * of the translation, can be used for deciding the size of large page.
> @@ -1954,7 +1969,7 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>       dma_addr_t addr = vtd_get_iova_pgtbl_base(s, ce, pasid);
>       uint32_t level = vtd_get_iova_level(s, ce, pasid);
>       uint32_t offset;
> -    uint64_t flpte;
> +    uint64_t flpte, flag_ad = VTD_FL_A;
>   
>       if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
>           error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
> @@ -1992,6 +2007,14 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>               return -VTD_FR_PAGING_ENTRY_RSVD;
>           }
>   
> +        if (vtd_is_last_pte(flpte, level) && is_write) {
> +            flag_ad |= VTD_FL_D;
> +        }
> +
> +        if (vtd_set_flag_in_pte(addr, offset, flpte, flag_ad) != MEMTX_OK) {
> +            return -VTD_FR_FS_BIT_UPDATE_FAILED;
> +        }
> +
>           if (vtd_is_last_pte(flpte, level)) {
>               *flptep = flpte;
>               *flpte_level = level;

-- 
Regards,
Yi Liu

