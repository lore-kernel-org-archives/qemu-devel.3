Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 953E9C3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 13:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOdZs-000888-7y; Tue, 02 Jul 2024 09:29:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdZq-000870-5t
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:29:46 -0400
Received: from mgamail.intel.com ([198.175.65.13])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1sOdZn-0007BF-RZ
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 09:29:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1719926984; x=1751462984;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7mNjyesgtPrDwR401k+pfSdG5RcAlNarydUBy8qvK78=;
 b=m6yd6+vUKWaemMZVAlUZrXbD79CYE7cUm21xUy+BIfG24egip5Bef/nn
 5fLMY9YniwYb3iYBm0QLSqjVhwNfs6JWmtZLY1d31XpetOVBGx8tsGQcG
 6gi4JBVfiX87shjeGbgtxIdb1ixgBKnMQJpuCmPQ1trrwF7w4jaOs8MY/
 bzwv2WrGhEvQCEhy15yS8P5k1vlxD4JLqs3eEmDaDDDab/TUutWCCG6JF
 dYhlxFDhvcBh5MzTWHIFIc+QgWPvsascmZwxm9JGCdR4HBjPIUf3BWQIl
 uIPJLgou1icM3lCG3vhz9oz+qhfT1zrnEvDiENzIxC9eUwXm2cmB2Moyy g==;
X-CSE-ConnectionGUID: 7+qwyWshSgiC4obzsWFaVw==
X-CSE-MsgGUID: raP+Y2CZRpSLUx7jfxaDBQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="28234053"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="28234053"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2024 06:29:41 -0700
X-CSE-ConnectionGUID: SyN9ndz5RMiFcwz8b8oAkQ==
X-CSE-MsgGUID: nNVPTHpmQ8yw/tgTAyKtsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; d="scan'208";a="45879114"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 02 Jul 2024 06:29:41 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:29:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 06:29:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 06:29:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 06:29:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frvsWeaLciAMF5OSHRwPuXV99HPjMfoR9a6GDUGaLe0JARcxfcMxc5f2mjkhjr50597OV1uaZbwxqUEGAa2ATZvLwGIs1gMkQjLsJaFPYcB2zFrXz1pnqWL8XdtNg4YHx4CwIdY+XY1jnc1lDCpSOb/X7iaiLevIFuQaieF5xzIuKosQXCzkZvQuKmhQxlSHAlfSU6jEVqEPT0VIsihCSQC1wj+u4OmM3rkiHnYAgWap7JgpVa2NSE2ybQanFK1NPIHBkgHnSEh6Rhx7KCnGelCCWM4pP2tFMcUclt0XRGCoAm5reVnklXUSMGvYJ1C9NIQlvVLlafQ7/fwgWQN7zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rcl2rzPq+g6gm1ftBJAAw96XO+PQnqFMCl2fR+3D2lc=;
 b=iBPf7RMQt75OWqCA7L94+usw+IHPfmwKY1RKbRyFa5/BEaIZMZkfPIHTtIBnFlJHH4y+YlesNtSeEN3WhrZcKJFnJ4NuWFS9qKHEUBtMza13av5zPXqwczkMeOkoEHW9+Q61EmdOpDoQ1XBbCdGNNNjyHQSu1Xr+ZNatcyWTbj3jm+KgyAiKsAr/Vv8tGOaqXJwA9bH1fYOz0lbDA1L6/blcxhceuhNQ7tOZC39brD/kYItzxS3mp11HQ6OCUqGEL91+FDvn040OGCXMTyZH4y9+WbKDg7XWiYSlwAFAfcUeibY0shUCDuI0FZYH4DdwVA7X0MTKQ5ssXJViJhdieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MN0PR11MB6229.namprd11.prod.outlook.com (2603:10b6:208:3c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Tue, 2 Jul
 2024 13:29:36 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.7719.022; Tue, 2 Jul 2024
 13:29:36 +0000
Message-ID: <655835f4-dd39-4360-9868-57abb8f9a3a3@intel.com>
Date: Tue, 2 Jul 2024 21:33:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ats_vtd v5 04/22] intel_iommu: do not consider wait_desc
 as an invalid descriptor
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "zhenzhong.duan@intel.com"
 <zhenzhong.duan@intel.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "joao.m.martins@oracle.com" <joao.m.martins@oracle.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "mst@redhat.com" <mst@redhat.com>
References: <20240702055221.1337035-1-clement.mathieu--drif@eviden.com>
 <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240702055221.1337035-5-clement.mathieu--drif@eviden.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0076.apcprd02.prod.outlook.com
 (2603:1096:4:90::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 918c8607-9a1b-4ce5-dab9-08dc9a9b0458
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3JQczBud0lTcDV3K0wzYTFvUzdXazkzQWJVRlBCb3VLUEJmTG8vLytOMytz?=
 =?utf-8?B?TEFxT3UzOUJHeUd6N2liLzdkRmJVblZqTFI0ajBKQnd0NkZ5YWtLc0YyZWFT?=
 =?utf-8?B?QVdhS2U4MGRQS1ZMOUdUamJ1ZC96QkY4VGN3Wnh1TGRPNUNCWW83b3VXb2Qx?=
 =?utf-8?B?M3NMdHpPTmVrdmFhSXFlMjZSZGwwa2grbTl2SG9YMEFtUkF6eWJpVmxNbDVw?=
 =?utf-8?B?VE9SbWV5aGJUcmR5RFMwK1lRRlFEWkxWM2lsYkgxcHVET2E1MThGTEwwalFU?=
 =?utf-8?B?dGxld2VYb2RUdkVZVVZhakkrLzdrUmsxbjFaais1VVVsQkpIbVhJQVljY0c3?=
 =?utf-8?B?ditSMEdHWTZqZm9KUHQxK0cxOUkxVWpZNjR5NEV5Umo4cSt2bEtMckFUSkxS?=
 =?utf-8?B?dHNSV0FKczIyYnAzZGRWNjN2Zm1yVTFmUTk2MERBVmc0MUxKc3gzUlFMVDJR?=
 =?utf-8?B?blIySlVzcytCZXAvci9qMzFkRmNIUTNGb3NGaXJwaTFHY0hoeEpSKzlmUk5S?=
 =?utf-8?B?MlJhdzc0U041cFB0YmFpelIxaGNaOTJBaytFRnJrU05RbDQ1RzJGQzZpR09K?=
 =?utf-8?B?Y3hJTWN3SWhLbWhFSVlyOEN5WFcyeXZZQXorcnlMRTA5Yk0vRFE5THY0bWxo?=
 =?utf-8?B?aHRzRTVMNnF2T2V0SDRoYkZha0NDWTBWRXRueHA1a3RzZnRjcmZMR2x4b3ov?=
 =?utf-8?B?d0hVSGNyZVdvSEQ1N0hDTThtN2g1MDQ5N2M1S2RHbVNvM1NnOXh4d3dpTDFa?=
 =?utf-8?B?ZzRWZUY5b0JDdSt3MlZiZ1hoRUc0TzEzTDJEWWZFYjZBclhLYlJJUW04STZQ?=
 =?utf-8?B?S3dXaWZPUXJPQ0hmNTdocWlsSzc4RG4rSkxhaGFPUjFuT1NPTFdkTitWZlNt?=
 =?utf-8?B?c0FxY2pTemhJejF4UTVQV2hGSldTc05FeDdRQWRWd1I4QWJDcnBJL1VQempS?=
 =?utf-8?B?UEpMMk9GTDVrM29sTFh6S1NWeEVTMGljcUw4YVljVWJtTHhZV0h2WmZRYUt4?=
 =?utf-8?B?SmcyWXNWcjdJT2VxeTNzSGFZZ2NWYkwrTEZpY3dGOXBzSEIrVksvRXJZWXZJ?=
 =?utf-8?B?NVhrTldpaXJzcStOSWtmMHpqUW94RnBqYWd4eFBEM0tmMkZwVzlOdnVwS1ls?=
 =?utf-8?B?cnVIb2piVnM5WkhKUEY2RjNKQ2RMeXFRZXFMT0s2VXRwYXZhcTBYdGhLOUZW?=
 =?utf-8?B?Sk5uZGdrZlVoQ0VraENtRkFjRFlnVVIyeFU4K0FaWE03Mm56dVU5OUtXdXpX?=
 =?utf-8?B?QmxGUE0zd3Y2eENqckY2MStnV256M01SK2pwL3hlUDdOeXRkczlxZmpWMHZ5?=
 =?utf-8?B?WmhadTU1ZFBpMDRVSDBybWRoUXpVNHl6QmZtOFljRC9GOWRSdjFRM1cwTnRK?=
 =?utf-8?B?Y0xnK1hUWVZTeG9uVXNHUEZXcFoxZE1sclJzdXpSeWY1Sm1zUHE4bzZSalpL?=
 =?utf-8?B?b3VwZCt5dmtFNTJ4K1dzS1ByclVDc1h6UTg1ZTRxZktReEtDNTkyWkx4NG1w?=
 =?utf-8?B?Q2x2TG5IZDJzYWQxOVc4QWR4N1FxdlVZYzFBd2FnamQ5azhTdkpZR3NPRi9s?=
 =?utf-8?B?UE02L09meVpVMFd4LzdEOGN3R3pzVWdqNm0xWGpXTmE3dHBWMEttd210Y1A2?=
 =?utf-8?B?ZDR1eitLd1VZNi9BdGJqZ0ZhNS93QUYwNDZJdjJGYjk2WVpDSUdGR1d1a3Ri?=
 =?utf-8?B?MFViMVZrUWpFbEdEMVhYVTByUmlCenczYkZGS1hJRkd2VDhzZjZRcGtWVFk0?=
 =?utf-8?B?TU5qNm45d3cxYnl4d0hxNVA5RVRqN0NpdVU0VDhvRG1EYVF4dGVwMEROVHRG?=
 =?utf-8?B?Z0g0SlkrZ1pidS9wWWt4QT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDZpRG5hRzdhd2tUbHhldU5DcVg4RGRxSzRlVkZLTkErcHYyM1RHenF3aXJk?=
 =?utf-8?B?KzRsQ25hVGlMVHFGYnJJOExQM2c5U0ppbDg5NTc4djlJN2JLK296NGEyTEJT?=
 =?utf-8?B?Vjg4alRPaURGOUo2cVRrVkFJM3RlUFFMTUxWT0x1UFpYVzdndVByK0c1OHZp?=
 =?utf-8?B?S2NIWnFNZEF4QWNOVVRIcnZWWC8vS0hNbzRiQ1QvbUd3dFRBSlhnbklSa2dH?=
 =?utf-8?B?azlyVkltc3BzdWtwdUdBMjNXaGtWRGpKM0xPSmcxYmhWV2Ryb2tsVzF2bER1?=
 =?utf-8?B?UzNVVElqR1MzaEFWaDVCMkxyTURXaXcyVm9SZXNDZDlDeFZTeXVNRWJ4SUNa?=
 =?utf-8?B?dmhhUDhYdDNWV0hMMjBqUWU2bzE1cld1VDk4cXNaeUduT2t2OGNFVlExOHhQ?=
 =?utf-8?B?VnFjNURMdlhEWStIWUtPV2J4WTVyVHF6d0t2WmdHck1EYzBIWmNZcnhod2FF?=
 =?utf-8?B?YS9OZkdnUXFYNUFrT3Y3dU94ZytHRG10R0E4TW8rMFlnalFQTDhMV3dyOGJy?=
 =?utf-8?B?Z0w4L3VqRDQxV3Vkd0lCMmI2dkptR1RXTFNUL3NlWUNUc2YwY2ZmdnYrOU9H?=
 =?utf-8?B?cUl1Nm1zRFlmV2p6aGJiVzFPbkpiWDZidFJ3clJpRVhWRVVtZHQ3VFBRQm5v?=
 =?utf-8?B?RGlLRS9Ddy9VSjMrNGhkaTRhdFdFVjdsNWNPTno2Sy9IR3d3ek9SL3duT3pv?=
 =?utf-8?B?V3h0YVN4MXRrdE1GRkxUSDdwNVpibDE3Z045Um1zZG01VUF2ZFM1a20xSUxm?=
 =?utf-8?B?b2xldElScGpLekJDcmNpUGtES3hmU01yM0pzSEs3MGt5RTQvdWFGNXkzRlkv?=
 =?utf-8?B?YzQ1K3N3S2hXdWFTOWdrNy93Sm5qUFpjdnVCTzh0NUtoSVRldkpCUVN3VTVm?=
 =?utf-8?B?NWluVERrY3VXVGhaczRFY3VHb0NTNXF0bndxUXNVVUZNbTVnbXR5MmlxdXhI?=
 =?utf-8?B?QWVJeXFHQ3FTMWE2c1dHdTRjWGRwKzF3VDNtZFl0d24vUkx5V25ibzVCc1dT?=
 =?utf-8?B?UXlXZGttSFMvRnQ3VFJCa2NVTVFtMnJ4cjA0MW5rbEJtaGRROFc2LzgwdnBt?=
 =?utf-8?B?MklvdXd5dGxsNWlQRkVuN0dSZWFVMUpSQWlSeEI5RjNXYUFHazR2Qk10MWhr?=
 =?utf-8?B?ayt4YWM0WDFDTVI4aGM1UkFuVUZHbzR4bWVacFpPTzgvdEUyWWNLMW5NZHNV?=
 =?utf-8?B?YmI4R1lDcUhQZXBxM0crWmtDdTRlamk4czN1Wk00NDV0VVhucmRJWERpRkZJ?=
 =?utf-8?B?L2ZxUmE1QUJqRXZEaVc5YmI0TzIyS3ZDZ3AxWk5xTnBJcTNqeWpaTFlTLzh4?=
 =?utf-8?B?aG1CMlprMHZyM1hhQm5Zd0MwQkp1TWhJMU5GWkp6eHNQQUdlNUs2dlQ3dkcz?=
 =?utf-8?B?dXlER3VXOE55Qll3b2liUWhnYjZPMXU4MmNOMkNOMDUvR0wrbUphaTI0WjE4?=
 =?utf-8?B?aFMrL1ExNEZBQjhyc1FiZjlwdkVQL2pGYTZIcm43Ulh5S3hxUHBhaDk4VmVP?=
 =?utf-8?B?NnRkMkNrT2o3NWptWmx3RXFUL3N6cnYyemg4NDFDQ2lvcTdrNlFZTXJqckFH?=
 =?utf-8?B?emJyOGE4RWt6NlpJUnpPK1kzQmk2aVA4WDIxZmtYVFFzNWF0RWxnU1lycmpB?=
 =?utf-8?B?bUY0cHoxcHdvcENtYVFSMWd4N05yY09GZTk1UVl0V0hKNHJGWElhZ25KMkg0?=
 =?utf-8?B?S3dOQU93eVZQd2xXNTJ4ZTREek9MRGp5ZGpUQkdmQU0yM1VzekRVd29OT3Y0?=
 =?utf-8?B?OEVicGJjeVVPL1JZcHJtK0ZDVk1UNkdoQllVR2V6S3BYUGJ2YUdLc0o0bkEv?=
 =?utf-8?B?ZGlOVktTalFDL2NsWUxkWSswSEEzUTN6OWtOT05mU2pLRGpPbDQ1QzBzZkFP?=
 =?utf-8?B?YmlzR3VHLzVPdG1ENlRRWW9KL0k1MFp6d3ZaSitCMTB0SmNWZngrR05vZi90?=
 =?utf-8?B?Y2tyUTVJYVp0ZlFnejZ5MndNMHFxTklDV05HcDRlMDRGYXcxWmZJWFViMTFa?=
 =?utf-8?B?ZWZXZC9KVWtZeHAydWlZZmlCa1FZSVlKdmllZzRpdEdFbG1nNzRjWTB4cDM0?=
 =?utf-8?B?bVltMy9INzFPc0FxVWtIUWRQVHRpVWNoRXp0U1R5ckt5ZkUxV0JFN2dleWFj?=
 =?utf-8?Q?/pFKYC36uKfMYhJj78+B/jqZW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 918c8607-9a1b-4ce5-dab9-08dc9a9b0458
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 13:29:36.6679 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwTf8nH19n3QXox7KioTq0vR57hX0KmfOeZgtRNrnGe2wFi/l3SU3mUlOUdgxnutq15QeRGy0hLfpKTfwMEStA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.13; envelope-from=yi.l.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 2024/7/2 13:52, CLEMENT MATHIEU--DRIF wrote:
> From: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/i386/intel_iommu.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 98996ededc..71cebe2fd3 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -3500,6 +3500,11 @@ static bool vtd_process_wait_desc(IntelIOMMUState *s, VTDInvDesc *inv_desc)
>       } else if (inv_desc->lo & VTD_INV_DESC_WAIT_IF) {
>           /* Interrupt flag */
>           vtd_generate_completion_event(s);
> +    } else if (inv_desc->lo & VTD_INV_DESC_WAIT_FN) {
> +        /*
> +         * SW = 0, IF = 0, FN = 1
> +         * Nothing to do as we process the events sequentially
> +         */

This code looks a bit weird. SW field does not co-exist with IF. But either 
SW or IF can co-exist with FN flag. Is it? Have you already seen a wait 
descriptor that only has FN flag set but no SW nor IF flag?

>       } else {
>           error_report_once("%s: invalid wait desc: hi=%"PRIx64", lo=%"PRIx64
>                             " (unknown type)", __func__, inv_desc->hi,

-- 
Regards,
Yi Liu

