Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9883E6F09E
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 14:18:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7bQM-0005bu-ED; Sun, 03 Nov 2024 09:17:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7bQK-0005bP-VE
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 09:17:48 -0500
Received: from mgamail.intel.com ([198.175.65.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7bQJ-0008Lj-63
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 09:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730643467; x=1762179467;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=bE/YYL6OkVqkSc2ch3ovln+nt6xpjQ2VC3WI7K4FfKU=;
 b=UoprSuj9Y4SJITpvtKB1S46AEY+hvcSTEBOvrKGnk9FqIGXYACpiCeTO
 uU2sT4GWoGRow6KcwpOtDdcPCzYzPK5FTplb91UtZ6CKKKc3K75qkigMW
 uwPBBqRfgDYh1QFQwYeERtptlZ1lIMf3unrK/V7G+JwYpVuxq7MWzOthd
 EC9EV2SD3n3zOt4CG9zeOwbcxGouE/L7dlAjrM7T+zsy6ulGJ/AtT1lit
 rOdRbRr2FHdNuWhCGovhFkiZk3+wlj+D0BHtL+Ww9LYu4zqBGgPPugIxi
 1Qvk6Y3E8vS3M5EC4UelULeGTJYEl1IzaqBo5J+u27AWHw5O6QWOuqH0I Q==;
X-CSE-ConnectionGUID: l9D/Jv4WSz+C7+Qn5MON3g==
X-CSE-MsgGUID: t+53cwm9Q9+O6L9Ro6ndMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="30506901"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; d="scan'208";a="30506901"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 06:17:43 -0800
X-CSE-ConnectionGUID: GxEbv6HGT9+xcSJN1ZdoOQ==
X-CSE-MsgGUID: vCOUlKhsQOiEJnlLh7Zsuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,255,1725346800"; d="scan'208";a="87345624"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 06:17:43 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 06:17:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 06:17:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 06:17:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CY/6UAbmEbPpI8mNYM9CKHPsDfVPuhHXc3Qb6LgdoRdl0E8/P574sa9ReQJFjnzBVbGlRhfI89HR7GlSSwLEbLI6RhhhHfe7p9QR8d63vuv2nwhTS3jESAHXg6cqPjbgH1nG8zMpYEIbQnqE6KTCFmkDaZsv5Exktsg3+aHf60ccAqCkET/woF7TaoAyFQVWSkfn37ucA1WZvmKGLLj3e30yKrv45fLmd5+QZ3m5E932B2PgZSPPPA/rSC8RoQou27PfsO7FoGNZSyzQ+9roGucWBRVeslp/U//gm7iiEQzWOi7CBOHsnIpFdoyZF4Rp2o84cZwMblv8H0CEAOHhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvdVtPk7WC3h3/CiCHirdLT0JQxd0Xka02c8YCde9Zk=;
 b=Gian33rO2/AuZh0U2ET6oYvQObRMgq62W7MZQWreHljXOAXtgUD2lpOpglHtAbPWmzM49dVr3/pQlh7mSif9v7uHdohdXhnfuKem11YveY71kdIewJ67fTcfubdfL8cI58h6Z8GkeV+z2qy9A/CwLljuzbM2XnAtlDRe/s6cL3ESwqDVt0dsMz2FWpWkaXEGgNlkbv3UOhphze4kv0tKPAXoKOkOBppc0DBlkoG2tJCvSKzX+Ydi1Jq5LmfZcXYrFPgYL5vkLsrD/H8x6WDsQJhJgMjBF7uJIT7hZA/JZ5rcn4iTgYoIjIclVjsDtG6/rUULkyI4r4GO33GNP+rR/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sun, 3 Nov
 2024 14:17:34 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Sun, 3 Nov 2024
 14:17:34 +0000
Message-ID: <55e80b9c-d35d-472e-b189-f83ceeec30cc@intel.com>
Date: Sun, 3 Nov 2024 22:22:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/17] intel_iommu: Check if the input address is
 canonical
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB5247:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c8d72f9-9138-462f-0eb6-08dcfc1242ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U215R3k5OGlMMG9PYmxZbDk2MFJsTEwwZlZHRXF2cGRBNHFIOS9JbUl4Yys2?=
 =?utf-8?B?UlZYNXgvalpYWjV5WHd2aXJyM1F2WDYyME0zc2pMVlliaGlRU2dFaEJZQjBw?=
 =?utf-8?B?T2dHcFpENGJxdW1GWllCV0NFQ2dWNFB6UFFqZFBkbHVQL0YySDhjNnBSbFpw?=
 =?utf-8?B?WWhWTzc2NGg3NHFqZFNxNWwwd1hLSTV6eFArOUpkMHNXS0VuV2FPcHZoSXdl?=
 =?utf-8?B?UEVINkp6RWczNmV4QkJDQnRybXVRRHZvOW45SzhFbHBiTjVIbUlJV1dja2J5?=
 =?utf-8?B?TXo0K002bis5VTBjdW9mZ3BXNUd6enpheWdPeThxWHVXMVgrUUw5MnVPbVNo?=
 =?utf-8?B?Vy9kaFQzRDEzVGFSV2gyU29LdTROOXlCYmF6TENBOGlRYVZLd01mazNoTWpp?=
 =?utf-8?B?cVNDMXAvVWF3bDhnSER3K0JxWXFkVUozWTYwUXVmZVFZenJqSWVmZXZvL0xv?=
 =?utf-8?B?TWptUHAwYkM4WVRTTWQ2VzlleGZDZURleXNqVXJDVlZIRTkyOGU1UDhGMjVm?=
 =?utf-8?B?Qi9uNklGTTJvM2l3TEVQN2tqdDhpRkE0M1c2UklwSXkzTE9QWUJsQStSekhw?=
 =?utf-8?B?ZDVJSS9FSW02WU40VFB1SmQzY3JwYU1rUmVMcXhLM3hRS1NCcDVOcDdHR1VS?=
 =?utf-8?B?VS81ZjYxQVB2RSttdERXU091TG56S1VGY3kvY1pZNCtyNmpDVnVIWTFXd1Zr?=
 =?utf-8?B?OUxSTUptQmRSTWU2dmdsY3FYaFcvUzFwQkgwajVRaDdKMzhpVlJFS2pxNHpi?=
 =?utf-8?B?QWV2R1dEVWVnRFRTYmkvaDFJMWw5b3BLbDFyc1Rla1NFZEF6QXUxRU4wZnNY?=
 =?utf-8?B?bUUxMW1ETkduRTc3TjZMMXc3TDA1VTl0OHdkM1FUa0o1R1h4VlpEZTBjL1Qy?=
 =?utf-8?B?RXAyZ3ptNGFZVzBqenk0d2ZmczdGZndiZlBlQUw0elZzZ3BqRW1TWWI1ZThm?=
 =?utf-8?B?eE5ySGpobDhtNmlaSi8xQjZudkF4R1VGNk1rRTF3WnI4c3dDS1N4MFRWUXNm?=
 =?utf-8?B?Z3crYmxZeGg2ajZpMG1qUlhFVXNIQnFrdkRZNFpLVS91TmFjUFN4NG1kT3kw?=
 =?utf-8?B?ZEJSOEZibjliR2dJVE5hNHZORC84dHRNb09UQy9URlVrN1FnSFFPSGdaUmhW?=
 =?utf-8?B?azJBb0lVOHgwZnFPcit2cGJBcmg5S29IRGVVcWhrUFZKUG1nRjB6dnQrdE1q?=
 =?utf-8?B?enUzNERQOWxhUlI2T29wQ2YyQm80NFVmYlp1akpGbWt2KzVLK1U3aUtiUGRo?=
 =?utf-8?B?UVdNb2F3Vi9jRnZBdVFxejFFVWU4eXhOT09NMitzL0FjOXgwWE1lNWtFS1Nn?=
 =?utf-8?B?bUxaRG5rdkEvVnd4WnkwUkJpd1dFd25xV0E3Si9rcU94RzVOeHRUVnpVVzFx?=
 =?utf-8?B?Vm8vUWtkT2NudWpEV2d6OCs2bEc3VVRzYkV3UVdVaVZMQndvMk85ajM3M25u?=
 =?utf-8?B?MUhnMjhKZlREcGhHdEdtNzIvL0pVKytMM0NyMFZIdlo3UUZrQnkwSjlqbUgz?=
 =?utf-8?B?SkltbFNDNFJYdWd3dGlNVitEUGZOdDRoTi9YVlg0T3pLYkJJc0FzWnI1RnVG?=
 =?utf-8?B?VVE1MHNGNEVMaGRDanNZUDJ4SytPS0xDZGxkS3hvcFpIbHNGd0RGTnAxSFI1?=
 =?utf-8?B?RFVpWDlDUkl1ZDhITXN0YWdDeVJ6UWt5RGxUWFROU0drQmh0OHFVcy9vcDJ0?=
 =?utf-8?B?bGNPVGJQY3FWZUxJUE1GT0lkNlNScWFkdmVORUJtVG9yc0ZOZjFqSU8rOU85?=
 =?utf-8?Q?SfF1/7H/ZEocTHJZzv5uR+kTuwZsKr2ccIR6suq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkNqUmxBL25uUmNvMWcrdFBFMlZHdEtrdnQvSUQ3ak9vbWZhQXJDQlJReTNX?=
 =?utf-8?B?dldqQ3NDbFVoVTNYZkJrTC9CRDliZVR6NUR5ZW9vRDNmYnQvM3NBNEEzQUVj?=
 =?utf-8?B?aURMaFVZY01pNnVvUE5OcFcvdnYzS1lKMkJZbjhSRnlnOFM5MXhpbzBJbVBE?=
 =?utf-8?B?Wmp0Tjd4RzBndU1hVUgrSVl1VUVxNWZsVmV3bFBNQktqVkt4S0dXMGlVK09o?=
 =?utf-8?B?WW1sRWRqQkEwRFNhUkhKdzRYczhTRm1DS0xMV29Xc215U2VSTXBKUG1mZ2hL?=
 =?utf-8?B?dlJub0ZhVHZXc3prVEtWa2l4T2RVVm1zTHEwalU2MmdRd09La2dEbnh4WkRw?=
 =?utf-8?B?ZEpTR0NMYjd3VnlWNmxOUFdqQ2g4eUtibGkrUkxBeWw5SFJWQ0JueEhKN2xF?=
 =?utf-8?B?QStLMDRlYXJKWlZOazZjcGlTanhtNHA4alBKTWR0eWlPd1RjakJ3d0xJWC9l?=
 =?utf-8?B?ajNEU0Y1YWtIMjVNVUlrWnpYN1F3elBwZkhFazltWXFDQXV3cDU3Y3RTY3dk?=
 =?utf-8?B?VS9nRlVKa3htUXFmTDBlWlMycHVQKzlDZDRrdHNlM254ejIwTkU1bm5EV3JF?=
 =?utf-8?B?MTZ3YXBUU1lzMFA3NThBNTA5UjllVDVmQ0phSnlXYXVSbElxYUlGREdGTGtF?=
 =?utf-8?B?QnczblExakwyYlZXTGk4N2Q3dFhoMUgwVDE0b1kzTWxtL0tsSzd0N0J3Q25W?=
 =?utf-8?B?QTBYYnM2QkpQR2VuMHJ3MkZGN203QXlFY3V5ZkNRV2JDdXgzK2U2YkQySVNB?=
 =?utf-8?B?M0lTeHM2T2F0alNuZ2xaTWlZRXRETlc0clRENXpqTUhsRFB1b2Z0ZEduRncw?=
 =?utf-8?B?OVd4WHhDeFd2RFFlMjlKQ0ZyTnNFcEZpMVhHZkNaU2VISWw2VHhKL1E3c1FP?=
 =?utf-8?B?aHY1WFNuWjdHVXFEczh3REZGNkVtOURCclVqaFVxZmhFTkRuTkFpdVpSMXA1?=
 =?utf-8?B?V0xXVXJGaTNBMkhYN0hRRFEwaWdGUDBlNmk2cTJYbUF0UWdsMzlyU2FXQkxW?=
 =?utf-8?B?Z2FjY1BIdmo1K2l5b3RDSmszaGFRVVFYaWxldVU4MFhoZ21kbytlU2QvR0Jq?=
 =?utf-8?B?Ym40dnRMMG14NDhkMVNnaER0VHBEbzRLNCtQMVIxTmxsMDV6ajUyZDR6dW1X?=
 =?utf-8?B?YTNlYzZNSlNJbVNLcURFOWd3VkpxYTZjVUdvc21qQmszYThnT3hsWEZSdHVo?=
 =?utf-8?B?dTdKOVZxcUlERnU5VFlWVHh5WHkybG15QjQ4YkloQ2U2NnZKL2hoWHRJMUJk?=
 =?utf-8?B?TmtHcmhVdU4xQzVBZVVlc09TN2pOUE5MODFCcU9aWmhqbldTRWRGbSs0aFhG?=
 =?utf-8?B?U01kRWRKaDd5WW1FUDBWQlNxS25QczVJS2V0ZW41aC94Qy91QlprbFp5SjVl?=
 =?utf-8?B?KzM0akR5YWNDbmd5RS9wU2I4VDM3NzdFMDcyTHhJTm1sdmx0aTZmOFNud0hy?=
 =?utf-8?B?SzZrMDBiWE4zakNwUERzRmNaeG9XWHN1MzJpWTZrK1hOZ0NsOVJlU3h4ak0w?=
 =?utf-8?B?K2I0U2pZemY1aXNyUUE4czJSOFkzbUVFV1Q4TGwvZnJ0RDdNb2dzTUYvbDNM?=
 =?utf-8?B?bFhqdU9ObUNRbXBwUU91NVZzSFdKNGM2eks1dEdqemkrdFBvL2g1dU5xdVdW?=
 =?utf-8?B?RHJaWXIzUnZSWHVyWFQ2NHBvMHdlRFZHNmlSc3gxWjYzSjFUN2UxZUllSjRJ?=
 =?utf-8?B?elJRc0lYS25ndkxwOTZ0Rmx6MVM3RXppTHZNN1dseHVlMnFaTlpQUGlxQkVk?=
 =?utf-8?B?Q0FLTHBuY3RNdXBqeVo1NUFnbDZQSG4rRDBHbEtGQ2JmTGJPNFB0R2hjb2w5?=
 =?utf-8?B?NEdtVmRTcW11Vmh0MXI4K2pQdktLQkdsbFIyUHYzdWdEd2dTV0lLNGtXU1dV?=
 =?utf-8?B?THpvbEh4dHhWNjRHcUdMelh3U3RMQlBlVnp4TXNqK0J2WDRLLzExSmFkQkRO?=
 =?utf-8?B?MS8yM29pK3IzUjZaV0daVDd0TDNuN1BGRldGQlVsZGNsQmxaUFJBV3hUeXo1?=
 =?utf-8?B?Y3MwbWx1R29Ga2oxUWxFYURPbnkzZ2tXWVNZV1lCeGtjY3hLMERDUzhTRGkx?=
 =?utf-8?B?Q0d6ZGFJRG1TUHlaaC8xZys0REF1OU95UGNSRXQwaGlGSkpER0RUd1NQYU5k?=
 =?utf-8?Q?DQ4nmY6iJKxZxCGiS5cXV7ARH?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c8d72f9-9138-462f-0eb6-08dcfc1242ae
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2024 14:17:33.9458 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /n6mMNldW2g5HM5vw0n1VCS1jXokoqwxT4xViKrnAkkpHmWkjVW2ctUq9Hbzz6+UlQbnuNfY6BU3oNO0kDTakA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.16; envelope-from=yi.l.liu@intel.com;
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
> First stage translation must fail if the address to translate is
> not canonical.
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/i386/intel_iommu_internal.h |  2 ++
>   hw/i386/intel_iommu.c          | 23 +++++++++++++++++++++++
>   2 files changed, 25 insertions(+)

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> index 38bf0c7a06..57c50648ce 100644
> --- a/hw/i386/intel_iommu_internal.h
> +++ b/hw/i386/intel_iommu_internal.h
> @@ -320,6 +320,8 @@ typedef enum VTDFaultReason {
>       VTD_FR_PASID_ENTRY_P = 0x59,
>       VTD_FR_PASID_TABLE_ENTRY_INV = 0x5b,  /*Invalid PASID table entry */
>   
> +    VTD_FR_FS_NON_CANONICAL = 0x80, /* SNG.1 : Address for FS not canonical.*/
> +
>       /* Output address in the interrupt address range for scalable mode */
>       VTD_FR_SM_INTERRUPT_ADDR = 0x87,
>       VTD_FR_MAX,                 /* Guard */
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 56d5933e93..ec0596c2b2 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -1821,6 +1821,7 @@ static const bool vtd_qualified_faults[] = {
>       [VTD_FR_PASID_ENTRY_P] = true,
>       [VTD_FR_PASID_TABLE_ENTRY_INV] = true,
>       [VTD_FR_SM_INTERRUPT_ADDR] = true,
> +    [VTD_FR_FS_NON_CANONICAL] = true,
>       [VTD_FR_MAX] = false,
>   };
>   
> @@ -1924,6 +1925,22 @@ static inline bool vtd_flpte_present(uint64_t flpte)
>       return !!(flpte & VTD_FL_P);
>   }
>   
> +/* Return true if IOVA is canonical, otherwise false. */
> +static bool vtd_iova_fl_check_canonical(IntelIOMMUState *s, uint64_t iova,
> +                                        VTDContextEntry *ce, uint32_t pasid)
> +{
> +    uint64_t iova_limit = vtd_iova_limit(s, ce, s->aw_bits, pasid);
> +    uint64_t upper_bits_mask = ~(iova_limit - 1);
> +    uint64_t upper_bits = iova & upper_bits_mask;
> +    bool msb = ((iova & (iova_limit >> 1)) != 0);
> +
> +    if (msb) {
> +        return upper_bits == upper_bits_mask;
> +    } else {
> +        return !upper_bits;
> +    }
> +}
> +
>   /*
>    * Given the @iova, get relevant @flptep. @flpte_level will be the last level
>    * of the translation, can be used for deciding the size of large page.
> @@ -1939,6 +1956,12 @@ static int vtd_iova_to_flpte(IntelIOMMUState *s, VTDContextEntry *ce,
>       uint32_t offset;
>       uint64_t flpte;
>   
> +    if (!vtd_iova_fl_check_canonical(s, iova, ce, pasid)) {
> +        error_report_once("%s: detected non canonical IOVA (iova=0x%" PRIx64 ","
> +                          "pasid=0x%" PRIx32 ")", __func__, iova, pasid);
> +        return -VTD_FR_FS_NON_CANONICAL;
> +    }
> +
>       while (true) {
>           offset = vtd_iova_level_offset(iova, level);
>           flpte = vtd_get_pte(addr, offset);

-- 
Regards,
Yi Liu

