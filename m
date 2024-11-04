Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47620D1119D
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 02:47:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7n6j-0003AE-OS; Sun, 03 Nov 2024 21:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n6e-0002ux-Ny
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:16 -0500
Received: from mgamail.intel.com ([192.198.163.17])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n6c-0000YB-Rd
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730688375; x=1762224375;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=49Vt4YNJgXQ5yELpWrN3sgi2TSj2Fiud9QEJuxUljmo=;
 b=iBrtktx9USZbGUd/dV4W9VBS+BSWDpHbGr16rjFtocdiiXz8RPCYTGwz
 VzIVw2Yhuo0Ro/7JDjynfKdKrD6Lql4esMFNZVz/DXB9oD2Ef4YQkI2Ab
 r/bx5w6H21qVeHI4pn7Hz3yM1FlOSpzBP8zYohs8Ruoz5MRYFS4JPcd3A
 RyW7GEOwsdAFmAAs09a4aP6CRR4nLEpF0q/I/v/zM8BPUFTQb9kmSSYIC
 t7EQxQQjUONkenCUhvEdDuCqpG6MJimf/aVt1RY3aTPrhDbsUqFMQGe/2
 IeWdq4veuYPy1UkIgxkxS99xOVLLDC3JZ9GFFzkTePPnPOIxqNrxQgrxL A==;
X-CSE-ConnectionGUID: hcYHG5hnSU6AXtOTc4fKNA==
X-CSE-MsgGUID: YnxGH/gNRAunEuvlNndtPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="30248019"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="30248019"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 18:46:10 -0800
X-CSE-ConnectionGUID: IVU+8gcVS8edCp4rLRT6/w==
X-CSE-MsgGUID: FPFu0d+hSi63DN19KHCPjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="88652671"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 18:46:10 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 18:46:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qdtbJjfuB0msN2EYTyQWvSU7f4ZiRzLDU583cizfFS2bjwbFhWmgqDmcG9WcNbj3jwZ9a6TmiHQXEEi6h6CUMkTBGFSF8xZEsRDuLqPNUwUjGVhKv6buaiE4la8HVzz3K9bNJkpqkM4HwjFQz0bCrMSHy2APma8K1cdmRsCkzzrFpF4wwDsVsorS28bGCfTMw6VT2utdfpgeVzAlrKE/hsSx45kBVTWO+0ddX/pxPOUlj6zp4/kQpU6dPRBXKiVXMuQQDraJXzzWZyhO8rVPKY5TfY7fYYaBksZ8cNt0/Xfsy3qvfN3zSMldZlX/sYh46uU7xgRAgRrx0evSXqzk5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f6aVFWjtESPVeTxd04WGP3jxJV/4ByTRTxG40wC9+pw=;
 b=sl76ktvJZukFGHKAXscDKh8MpWaJdiK3EdSuiCBd1hAO685jV86UFaLlOuVPIzl65/gg7Y9XGRKS+/k1vxnslHwfMgCIBhEntEbsxTV7TYE2rjM1fRQ5xfS9eD6TgilYuCLtzj9Wv+TgZWqdzZgKp9pR0fdtdvDSg64tQ7pXtZJwCkAHa+n7tJOBMrPZsi52T7n8F5lBZlpNBTX+b9NK6nW5kbDNGcZ6xsP26HBCdFULxVlbVnB/TMI+k+EaOP5FQ+08aKxVUqrjuongShD8FPWSASELPeDq52yFmgvMcH9+q1c3ne0t4R+2Ru3FGXi2yFAQIeEJ+ux4Q06ZbCIjNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 02:46:07 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:46:07 +0000
Message-ID: <ca5e5eed-ea6b-4e74-beaf-990ba8ca5f07@intel.com>
Date: Mon, 4 Nov 2024 10:50:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/17] intel_iommu: Process PASID-based iotlb
 invalidation
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-11-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-11-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: be0d1662-512a-42f0-3a97-08dcfc7ad4e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dHpja09NK1RyVk1aeEJrYlgwZGhNVzIwZk9odVpFL29HM2dsL0dtalNoYXBJ?=
 =?utf-8?B?WnlqMUszSEpqM3JybXhXZmhRQm42Yi8wNWJHbEJ6MjNOcVF1c1ROTkVkTFBU?=
 =?utf-8?B?YUxxNUZncXNlSHhudnhDb0NpN1BUb0NJYTczamRydGhSRHBISFpNNEtqcHNx?=
 =?utf-8?B?ZzBmazAyS0Z0eTZrMEtzb0UvaFpJR1oxa0ZBY2lKZXJzVUJ3eTJSancwZERj?=
 =?utf-8?B?dnhyTHJLMHNmRk8xK1hQN21DNHdGMXFVd0RiNy9xSUJsMUJkVVh4L3J1d0Zn?=
 =?utf-8?B?bEdzT1RVSk5JOEo3Q1liY3dlN1poMXhJeEhqVW1sblFTL1hnYkNMMmh0anQv?=
 =?utf-8?B?dmxRYXZPQWV3YkMrRWdxRlpya1E1U0d1UHRPcnplMkt2ODNuSmFqS21OUmph?=
 =?utf-8?B?QTRTVW93SklzVFRpNjAwUE5mUzNqZTEwazgrUHlCTHZZa2l0NDZtdlVsMkQx?=
 =?utf-8?B?L25NOXdZRXh6eVhtT1N6T0NhaHBodUhuSCtBNXpLWDZ2UFpIbUczYkdlbVlU?=
 =?utf-8?B?UnRvN2VSY3A5enJWOWExM1dvQ3hodUh4anhXYzJDY2tlSTNvWFZEUVNvOENY?=
 =?utf-8?B?MXpwaE00WXE4SnBGSm0zakpHQ1lsVG0zTlF6d0ZYY1hHSXQwL0FVVlgzdlVz?=
 =?utf-8?B?VlNCbS9VbUtoWkM1Yi81WENycmZuME1qdHNUeldGS3lPK1IzMWNyOFJXZ2RK?=
 =?utf-8?B?TEpSaHU4cUJQN3pNQ2xnSmYrOHdpSjN0RytQSFJSY2IrS0hESURJNzE1dCtP?=
 =?utf-8?B?VkhQbTQxczNvOEZhOVVFWU1mdkY5L2FPbEJENTl6OEw0M3NTWHM2RDVzZGVP?=
 =?utf-8?B?WDJ3MEY0bjZCUTdYbHRKUnB1ZHhqb0s5am5uS1N4QXpjaHpKY3oyTGpBUkFV?=
 =?utf-8?B?YnNwaXBabXpJaGxSVFU4NHJibXE5VUtUZHpzWDBTNzFnOFJhbGF3eUZYaTNK?=
 =?utf-8?B?OVlQYlhrNThRQ1daa3hOZGY1MkptRUNManRmalRpQXFyQjhCZ3dlU3pSU2J2?=
 =?utf-8?B?UnlJVWl4cWJSZnN3TXY4MDZka2M3YXJXb1BZVTM2dUlEVCtndXIvRko0WHZ4?=
 =?utf-8?B?L3FlVGZEcWxwOFZlZFZxVTEyU2NTaVdnS1BodXNIeDJVcEtaUmhtajJuWjhi?=
 =?utf-8?B?TWxJZHNzVE5FUU91SWQ3blVQMVB1SnliZDZxT013RlZadjJ0SWk5MUZZaWUx?=
 =?utf-8?B?SzlVOVlDYVBWUkh3U2tvOWJGYXNMdDVqcDJiT1JRSU5QTm9jVy8xc3I4bEtj?=
 =?utf-8?B?R0dLVEtESnNIRVVmazJIaTRJUFpNME1tNVZVdlpvZVE3RmxhaG1QVU5EekNF?=
 =?utf-8?B?bkJFb2xtbW9VSlhPcGEzMDJqYnJVVU9CaW5PUVdaMzVoeERKcTBsbUNObi9u?=
 =?utf-8?B?dW5zdnQzaVVpNk16ZnBnbElwTEcvMEhvQWFtMEJycnpsSFFPWUdHeU91YUsz?=
 =?utf-8?B?VitudUN6QThPUW9pRCthQUF1NEN4OS9HQkZqcGFFSlJkNkJKQUdMZ3BGVW9x?=
 =?utf-8?B?Y2IrdmlkMHlCR1VHaWZRc1N3WEwvRWpYaXo2cXdCNDZIK094azhiZ1ZnOHFC?=
 =?utf-8?B?Q0UxZkJJWk43S3Z3RTFZUUw5RmNNbmtMaXR2ZUJUNlJ2UVpteE1COVMxS0F0?=
 =?utf-8?B?cUZRUFFBMExYMlhmZ2hxMmVXTHpFNUx4cXdQd1luWnpYOHBtNWdVWVZhRjNT?=
 =?utf-8?B?MUxMWlI4MEpuUUJ2MzNUS1k5bzJvSGhGU1EwaEZ0ZXBRYS9wZWxoT1hlR1Nn?=
 =?utf-8?Q?NDnk4IJW8yGkHW2XkGZKC69y8ac13TJQFgh2Wa5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEFOOTh0OFBPeVhCWDRBOXNrSjkwNlZXa25YQ3BPL3FSY0k1UnhqS1U0clBr?=
 =?utf-8?B?L3NZNFMzbGk0cUVwZDE1Y1g2SEh2cFIvaTRKRGZkdjJCWHpub2ZwQjdzckdz?=
 =?utf-8?B?YlFOOUZXQjZCN0dic2wrSG10MTNIdkJpMEdwendCNUxDbDVZSmpXS3ZqT1gz?=
 =?utf-8?B?dUNueWhkVzVaVUhQNmpteDFoYVI5OVBmL1hTQ2tQZlN3TkFNMEdQQzF6dlNs?=
 =?utf-8?B?ZDVEZmhXQjJ5MmVkcnE3Q3haTEovUjdFYzhUaW9nenZnUm1pY3lTSEVXd04x?=
 =?utf-8?B?aWRjUjhVOG9ZVUhBMGZ1ZmxhMjkxSTdNRktDNXhsM0kxSHllRm1PbzRwaGho?=
 =?utf-8?B?aDR4TDhrbFYzZEpjSGhKeHJpd2xLVis1MDg5UGxCbjM1NVl5ZUxyc0hRUVJi?=
 =?utf-8?B?b2xHRWZPWHZwSUxzWW5wc1B1RmFNYVZvazRKMDNJUDErV1NLcTBQVFlPOFpi?=
 =?utf-8?B?K3pDUVlvVitWVy9GOXNzMmQ0M29OSTNacEExK1c0WTRxZ3hheVBYL2RXazcx?=
 =?utf-8?B?TGc2aWRSM1c2VGhPQ2x0OVNFUjIyV1RWMElKSlF4cS8wam5ybHdKYnY0WXRh?=
 =?utf-8?B?SDA5d3ovZTdqbllrVzNyRGV0OFgwWVB0TUVZc0xMM0daWTZ2b2hSd1Rlazdh?=
 =?utf-8?B?bXFWUE81dEN2U1RkVXF0TnBMRFhLWUJ3N2pTU0laSWYvTlV5SUlOYXJsUXlp?=
 =?utf-8?B?UlhvWUt0MXpKbXYwckFtWUZ5MmI2dW5qZENSYksva3kzbkdSaGw5NXRJa0Uy?=
 =?utf-8?B?OG01cmo1SVM2T21iUENFTjM5c000S2xXTHA5SHl2M1UxZlcydUtCQjVkL1Rw?=
 =?utf-8?B?TDRuWUxlMGtzWXE4QXlYQzU5MnByT2xNZjFsODNhTFpobzJFNnE5WDNQTXVK?=
 =?utf-8?B?ZFVQOFBxdjZEL1preVlTSDR4QjI2aXNPaVZtYmJMTHZlcTR0VWZUcWtKZ0Mw?=
 =?utf-8?B?Mjh5WkFvM1oyUUVUeUhoOFFQWkFuclhvYlAycVZEYzVEZzRQakpkVVlZTm9m?=
 =?utf-8?B?QzZtTWI5cnRZWEJoZ0FiQ2hETEZOcmhWS3oxdlZUdHkvODcxUlB0QkkvMlky?=
 =?utf-8?B?TGhkbDJMd3dDVTJoeXUzYjdTekk2UVhjUzcwSDM0V0FIRW9lRVAxOXZXYU1T?=
 =?utf-8?B?UVhXelRZeDNLOXlxSVdVeHdqMUw2V2M5aHlRZVI1NUUzNnhmS01YeVdZYnVC?=
 =?utf-8?B?WjJZS3pBQWROVEg1RjhLNVIvUXRZVlZ3aFI4aU5OMzU4TmFqMHFTRmJKaWpy?=
 =?utf-8?B?bTRSbzdrUzBLMWZ2MzdOREhrWGpoSllqY0hxNXE4UkFLUnB5L28zbzFjcnBa?=
 =?utf-8?B?VzZoNkZBUkRCNHYveGxBSzgxVHZ4Mm5BN21oWjdkOXZmM1dBelN1U21aOVlm?=
 =?utf-8?B?L2hiV0hSRXJMbFAzaGcyVkErcnZsUk02ZUQyeGFta3luajJncXh4cGFYTUJz?=
 =?utf-8?B?ak1iMm51a0pqb29ETE9ES0hPdmYxRUVuN1NaamtTK1hHa3RZMzlEQ24ySEsv?=
 =?utf-8?B?dDdoZWlyM2dmWmxvRHo5YWlZaXN5dTNNNVg0WHFyc1ZRdFhVL1psR29UVTBx?=
 =?utf-8?B?Sm5aRjg4SmZEV3RNclhVQWdKL3lYL0h2aGtIUWpzeWFuTWM1RUNxQXEvd0lx?=
 =?utf-8?B?eFVZaDlFQkVZeHliZmJZY1E1RW9rSHVBQm5yUGE2OG5rYm5oZzllVUNMYThz?=
 =?utf-8?B?aGs2TkNwOUg3cktCWGFKTVNaUVhGc213dTE3K1I4VzlpNXV3cDF3WU4xbDc3?=
 =?utf-8?B?ZjA4WElON2xaR0pDMHR2bHZXMTFhb2EzS2M2SmJmbXhVb3dFbFVxaFAxMFYz?=
 =?utf-8?B?SlphbGVDWnltK0ZTVGhhMmt0Nzd3NXQxclExTzJTTy9mU3I3bTdvWU5qVk55?=
 =?utf-8?B?L3U3Si95aXBFV052V1VVd3BWV3ZwVk9aZmZ2cG9mOEw0ZEQ2cnJVQit3UFd2?=
 =?utf-8?B?QnZDd3JteTJsYWFNZWF3ZHEvTmkreDlucys0Z1hoU0NQREYzRklRQTlRUWx0?=
 =?utf-8?B?RG1DR1FYQmd5djArdEYxbStoWmROdUZ3K3FOWkRlaHRIdSs3UStkU245TWhx?=
 =?utf-8?B?N3VuMFZQL09JQ0FtTnFQVDdGYm1HaytwSnp1SEpaZGFqemdOdHJjY21wM1Ba?=
 =?utf-8?Q?eo1scNyLDtFL1/ApCd9qPytko?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be0d1662-512a-42f0-3a97-08dcfc7ad4e0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 02:46:07.0510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mrqkw/c0JQUIgP2VIorGSq0pJcEvJhyZskOWJv7kpks1Ohn8Ov3ux0FvqOCWV33mRbthd4owcoSJ9FjvXqDNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5070
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.17; envelope-from=yi.l.liu@intel.com;
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
> PASID-based iotlb (piotlb) is used during walking Intel
> VT-d stage-1 page table.
> 
> This emulates the stage-1 page table iotlb invalidation requested
> by a PASID-based IOTLB Invalidate Descriptor (P_IOTLB).
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Reviewed-by: Clément Mathieu--Drif<clement.mathieu--drif@eviden.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/i386/intel_iommu_internal.h |  3 +++
>   hw/i386/intel_iommu.c          | 45 ++++++++++++++++++++++++++++++++++
>   2 files changed, 48 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 4c3e75e593..20d922d600 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -453,6 +453,9 @@ typedef union VTDInvDesc VTDInvDesc;
>   #define VTD_INV_DESC_PIOTLB_PSI_IN_PASID  (3ULL << 4)
>   #define VTD_INV_DESC_PIOTLB_DID(val)      (((val) >> 16) & VTD_DOMAIN_ID_MASK)
>   #define VTD_INV_DESC_PIOTLB_PASID(val)    (((val) >> 32) & 0xfffffULL)
> +#define VTD_INV_DESC_PIOTLB_AM(val)       ((val) & 0x3fULL)
> +#define VTD_INV_DESC_PIOTLB_IH(val)       (((val) >> 6) & 0x1)
> +#define VTD_INV_DESC_PIOTLB_ADDR(val)     ((val) & ~0xfffULL)
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL0     0xfff000000000f1c0ULL
>   #define VTD_INV_DESC_PIOTLB_RSVD_VAL1     0xf80ULL
>   
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 46bde1ad40..289278ce30 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -322,6 +322,28 @@ static gboolean vtd_hash_remove_by_page(gpointer key, gpointer value,
>       return (entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb;
>   }
>   
> +static gboolean vtd_hash_remove_by_page_piotlb(gpointer key, gpointer value,
> +                                               gpointer user_data)
> +{
> +    VTDIOTLBEntry *entry = (VTDIOTLBEntry *)value;
> +    VTDIOTLBPageInvInfo *info = (VTDIOTLBPageInvInfo *)user_data;
> +    uint64_t gfn = (info->addr >> VTD_PAGE_SHIFT_4K) & info->mask;
> +    uint64_t gfn_tlb = (info->addr & entry->mask) >> VTD_PAGE_SHIFT_4K;
> +
> +    /*
> +     * According to spec, PASID-based-IOTLB Invalidation in page granularity
> +     * doesn't invalidate IOTLB entries caching second-stage (PGTT=010b)
> +     * or pass-through (PGTT=100b) mappings. Nested isn't supported yet,
> +     * so only need to check first-stage (PGTT=001b) mappings.
> +     */
> +    if (entry->pgtt != VTD_SM_PASID_ENTRY_FLT) {
> +        return false;
> +    }
> +
> +    return entry->domain_id == info->domain_id && entry->pasid == info->pasid &&
> +           ((entry->gfn & info->mask) == gfn || entry->gfn == gfn_tlb);
> +}
> +
>   /* Reset all the gen of VTDAddressSpace to zero and set the gen of
>    * IntelIOMMUState to 1.  Must be called with IOMMU lock held.
>    */
> @@ -2884,11 +2906,30 @@ static void vtd_piotlb_pasid_invalidate(IntelIOMMUState *s,
>       }
>   }
>   
> +static void vtd_piotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> +                                       uint32_t pasid, hwaddr addr, uint8_t am,
> +                                       bool ih)

@ih is not used, perhaps you can drop it. Seems like we don't cache paging
structure, hence ih can be ignored so far. Besides this, the patch looks
good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> +{
> +    VTDIOTLBPageInvInfo info;
> +
> +    info.domain_id = domain_id;
> +    info.pasid = pasid;
> +    info.addr = addr;
> +    info.mask = ~((1 << am) - 1);
> +
> +    vtd_iommu_lock(s);
> +    g_hash_table_foreach_remove(s->iotlb,
> +                                vtd_hash_remove_by_page_piotlb, &info);
> +    vtd_iommu_unlock(s);
> +}
> +
>   static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>                                       VTDInvDesc *inv_desc)
>   {
>       uint16_t domain_id;
>       uint32_t pasid;
> +    uint8_t am;
> +    hwaddr addr;
>   
>       if ((inv_desc->val[0] & VTD_INV_DESC_PIOTLB_RSVD_VAL0) ||
>           (inv_desc->val[1] & VTD_INV_DESC_PIOTLB_RSVD_VAL1) ||
> @@ -2909,6 +2950,10 @@ static bool vtd_process_piotlb_desc(IntelIOMMUState *s,
>           break;
>   
>       case VTD_INV_DESC_PIOTLB_PSI_IN_PASID:
> +        am = VTD_INV_DESC_PIOTLB_AM(inv_desc->val[1]);
> +        addr = (hwaddr) VTD_INV_DESC_PIOTLB_ADDR(inv_desc->val[1]);
> +        vtd_piotlb_page_invalidate(s, domain_id, pasid, addr, am,
> +                                   VTD_INV_DESC_PIOTLB_IH(inv_desc->val[1]));
>           break;
>   
>       default:

-- 
Regards,
Yi Liu

