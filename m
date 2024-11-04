Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71AB5D1119C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 02:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7n6n-0003Mu-87; Sun, 03 Nov 2024 21:46:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n6l-0003Ei-CB
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:23 -0500
Received: from mgamail.intel.com ([192.198.163.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1t7n6j-0000ZE-JG
 for qemu-devel@nongnu.org; Sun, 03 Nov 2024 21:46:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1730688381; x=1762224381;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MBeViNgfC4ilnLAS5PHZo1A4WCu6KPv4dn16T8Klz0g=;
 b=NWhvhp2sV0oI6SwNQM0GQ6DbCZNbaZAwki20mxNNWsZffvNd5yYxDJz6
 OKRITI5KSVRwEsWecr6rVk6d/uyVVTdYlXkmh1aTgUNJ/aqGg0Q0ovrpK
 13L3DgQ9KHL9ao3Bgn3iXvGWwFdTonGwFASFxuZnfw6lgKTrj/xxA1shP
 g13//jnYGqrEUzOF7zwVC88+92tXKc3F8KNCv8jfI87JhxEmp5g3lRcWO
 WBq4iuSny9Bg0PiGIcu+j52/SLfL4YL7qie+xvVyD8PWlmyQjyZZQBn1z
 LNnZM/lfWl4bA2z/gCnY9pK0yQobzxCanlsnq8x0dj/pc0mzqClKPo08P A==;
X-CSE-ConnectionGUID: sX08pu9yS2a/wkJ6pw6ejw==
X-CSE-MsgGUID: +2X4a8+ZQ4u+TxnLXQ8DqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="17989889"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="17989889"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2024 18:46:20 -0800
X-CSE-ConnectionGUID: m9JAoJK7T4OXOugbCTfUdg==
X-CSE-MsgGUID: kJK9q283Szeu+RC9AoV/9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; d="scan'208";a="83651161"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 03 Nov 2024 18:46:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:19 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 3 Nov 2024 18:46:19 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 3 Nov 2024 18:46:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEsK5kp5X9z0NngApe6ODHYJYepyf7KIXsfqu6qDIOBZ2FmR5yjDK44AcQ51EABUkv6cY5QQVRdBbLNhnyZVy4Zp2OEsF97hBusu2c8T1Y1yq2wsEDrP9wCg7jrttqN7BGFbQe2iKolR9sKEt5JJOsEEz4uykhizG2DNkxqEeKLA1aJQOmcNJbM25caIvmZ4QUZvowcoYY/OlmJWscTpMDSFwJyM4ypLzsW2G4aHXJy6rukXiSaaRgukXgGrnmEUqpQA9mqQlCGYl7UY33+Vr72z4eGnyHIlw+cDHaeUEoU3D5fVwFg2LmmeV+DYdCK5DBtN42ipKhygtbpHq4wc3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJADAps7ZuYRz6MQHv9h6Rj+beiN85tGDGRbp9Lj2GM=;
 b=eeKgXNdwufT4/Vy9fCJqCMJ2xRDgSMQHhQc3eLBRhrtMTUm7cm75Ts3l3OlG41Yhx5j02DF0tGAS/NxXhH7QY01bH/KmZxs5R3UIoGWFFPdV9x/xQdGdP0bqGawGz6/AnfdCkQRfJizqHIBnR2V2Br4U3iM/lv7kUDuz2CGqArx8wGfUjdZF0miw2Qu5AZxMphwJ0feGXhEXUzMAYBC5dvbyHiOBl1ZXjyi++9Tf2pfcQi5TapzhyM3A94R4eB0YR0GUeuagwP7U551YVPZMGyCVZJd2uWqb++VQ1//JykRmGBx2RZ1DjZ/TI0gPBY+UEjTj/qFOee4fAlqQXvDZjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB5070.namprd11.prod.outlook.com (2603:10b6:a03:2d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Mon, 4 Nov
 2024 02:46:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%6]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 02:46:17 +0000
Message-ID: <4e21d66d-a923-40c5-ac12-14a349e840c5@intel.com>
Date: Mon, 4 Nov 2024 10:50:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/17] intel_iommu: Add an internal API to find an
 address space with PASID
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, <qemu-devel@nongnu.org>
CC: <alex.williamson@redhat.com>, <clg@redhat.com>, <eric.auger@redhat.com>,
 <mst@redhat.com>, <peterx@redhat.com>, <jasowang@redhat.com>,
 <jgg@nvidia.com>, <nicolinc@nvidia.com>, <joao.m.martins@oracle.com>,
 <clement.mathieu--drif@eviden.com>, <kevin.tian@intel.com>,
 <chao.p.peng@intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Paolo Bonzini" <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Eduardo Habkost <eduardo@habkost.net>
References: <20240930092631.2997543-1-zhenzhong.duan@intel.com>
 <20240930092631.2997543-12-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20240930092631.2997543-12-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR06CA0208.apcprd06.prod.outlook.com
 (2603:1096:4:68::16) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB5070:EE_
X-MS-Office365-Filtering-Correlation-Id: c7160bf0-83c2-4860-4b56-08dcfc7adade
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aGFHTU5mQko2YUcyM2Ywa3FmK1Y0aTE2YnF3ODJyNnlUL3ZCcWxrQUYzTGx4?=
 =?utf-8?B?dVRNSkZOWDNUWkNTMVd5VXdObUNLbzN3MStVYXBXQmtLcWJpM1c4cTZBK205?=
 =?utf-8?B?TkhZYVJIU01RelgzWXU1Szg1SXBjWFJ3ejlmR2RuOVBtY1ZyaUltbkZnWThG?=
 =?utf-8?B?Y0hlazBQS3BJaU1sVzNzdi9GNFNab2pJdWdzRGgrVG1lNFBXaVN2dEtOL2t6?=
 =?utf-8?B?K0hjZmk0dWJtYXNmUldiNTdIa0hPcXBUUHlVclNicmZYVDFXR3BYcW96azVt?=
 =?utf-8?B?QlpTTExuNU9ZNGZ0OGc3MFlVbEhSTUNQdVFWeTBnamorcDdmUHJ4RWQvWmQv?=
 =?utf-8?B?VldveGdmOFl1aXAxaGN2SzE3d3NYVzRLSlg0ZVNoUjA0Y2k0MnBwUTMwd1Jz?=
 =?utf-8?B?VlZtdHVTYVRLY3NFbURTZjArMEE0ZXNiczF6OFhteWRtUThqQmhtNlVnMlRz?=
 =?utf-8?B?Mm04Sk13QmZUZGFQeGNRZTc0K1NHUzNsVFdtZlo5SURjc2pPTWEzVXh5dmpQ?=
 =?utf-8?B?ZHdvZWlZVEhRQVNxWTM1dHVZVkpYNUE1bFNMSE10bytyZi83Unh4UXI2VEpN?=
 =?utf-8?B?MDdIV1I3NkVQY1p5OUZNMEJOeERuYkQ1eGNpZTM1NWZGdmZqNjJMUUc0ZkdS?=
 =?utf-8?B?T1p6OVBRaE1KN2tidDFaTVlDd0Fpa0JBVzM1SW83MlpIVFRUVGtHanljemtD?=
 =?utf-8?B?TG5OLzEvdHhFSjEvcEhtSjc0S2FTaVZJTENjdmdTYVJXMVhQdTd0dTFoNnpN?=
 =?utf-8?B?TXJZVGwyUW9DdzFYY2dSNGJCZ1Z2NStsTHVGRy9HbExXVDhRSmlrUzlrVGFu?=
 =?utf-8?B?SGdxTHdiTzQxeUxLMGdTZVM3V2tTeSt6alE5cnNhVXlUL0Z0bTIva2NrTVk5?=
 =?utf-8?B?OWZvdFRKSFpNYXJKR0JTV2JITU81aXJnYU5LNTZYMXdwNlQzRlZ6WjcyTDBn?=
 =?utf-8?B?T29BWi9UY2VXaFIzU250REFOMFh4a2Z0RUlHR0xwaSttb2dlSTRTdHhvdUs2?=
 =?utf-8?B?M0Ezek5OUVhMYVp1Szh0MmFkc0NxSUdZUHlITFMvRU1zMkxtZGNRTHBRZm5u?=
 =?utf-8?B?SEp2Um5EWmpJcHE5Zm1MYU1YU1I4eWtGV0pURnBzNUlxallGUzRhbjdncDcy?=
 =?utf-8?B?cDlBWU00TGxCYTBSMEtZcllYZ0JXUFZxVllhZzE3MVZtR2hCNFNwaWhBdlkz?=
 =?utf-8?B?eFV2RjVWN1JhUjhNN3VPbWVYV0g3SzVUZVg0YUFpWUtwL1hrcmtSeUNkY3Na?=
 =?utf-8?B?WkVUZ25WZ1lUaVp3NHdiSng3NWlSRlYycFRiUkFudS92cGxmaXdaQVljaTFp?=
 =?utf-8?B?M0piYWJHdUF6bEJRTVh3SG0vMnM5Sjg0bEtLMlNvREZsY0RHOFBjTjdIclZv?=
 =?utf-8?B?R21wcGovUXZXWEVvTm5mM3loVDRPRXhYRUJnNmJwcTNIYkN5N1EvT2JnbmJG?=
 =?utf-8?B?OGFpOW1SV2FyU2s0ZVRJMWl2NHdQYTFiVmtKRHYvT1haZU5UMUErMndQOXVx?=
 =?utf-8?B?aktGY2dnc2NRQUNlbk5JY3RlUUV3VHVqNVRybW84TW04SDRoVXB6bzV2LzZG?=
 =?utf-8?B?SUU1MHF1MUN3eFVSYVB2S0p4Tmh6OXlOa1RFTi9BVFNkb0UzZU5ncXMwY1VB?=
 =?utf-8?B?b0xQcGFldmUwL1JKWDhtOGRTT3I0MlhwZ2hxNGxPWmRCM2x4aU1nc1pOaTdn?=
 =?utf-8?B?WUFSYlhvWGo0dFNTOEV1YnhpSXlpVzRqUnBaMXIzUTR4Uy9JY1BVRjhSbkR2?=
 =?utf-8?Q?e4ug0qrvByVJOTyhIVzK1dnohD5UHThLaEvDuW+?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjczcFpMUFRlbXFkZnQ3MnRZbnZEa0M1eUFtcU51RzFjQ3pQd1JwM1AxdGRM?=
 =?utf-8?B?YXpvUEZMZlZ4ckFBYlNkbGFWTXlJMDg0VFQ4KzNQTFFjOWU3Z2ZUbjkybUt2?=
 =?utf-8?B?ZFNSVTRHN1BtM0lwcks2cXhEditlWTF4Ynl0bE1tNXUwRUJtZkxmMjk5elRE?=
 =?utf-8?B?NHlGakg1aTUxQWxBMDhjOVdzUFBDM1NMcTl3Wjc2OU9VMi9kTU43eE12WURy?=
 =?utf-8?B?UWgyandqYkplMjFlNURUUWs2R09wbm84RG8rL3VjOHhhNHdnTmEveUl2bGpq?=
 =?utf-8?B?OG1nZTNwa3RqT0JOL0ZHVmVRc3hNb0htMkE0a1FFUVFNeHlVTS9LWkFrV0NY?=
 =?utf-8?B?bHh4Vk1BcVRIbDFES05RRWgrc05GUXgxeFQ4MktLMDN4bUh4Q3JCY2hUOFN6?=
 =?utf-8?B?VFQwZWxkRm1lYythU2JYMy9ldC9hYjdiUmh3OFdwakZ3SmVLTWY4L2JSMVlR?=
 =?utf-8?B?V3FnemZmQVpGek4wcGR0MzN4TlZ5SkwyOFVJRzI2U3BYRDcxOEluSG9CL21m?=
 =?utf-8?B?WmJ3R1NOdCsyWTkySm9iY1N4ZUJ4ZkUxSTV4aDRMYnNVVnJmb1QxY0ZtYkVs?=
 =?utf-8?B?WXQ5L2xUM1lLVmJWTjNDbnlJZENGTzdBM1o2QytobjF0d1UyazR6ajdvZjVB?=
 =?utf-8?B?MStmbmVrM2l1c0MzRW5Wc3hEa25lS0o5WGl4enRSZUZUVDljdVlRRWtVNkJ4?=
 =?utf-8?B?TkVPK05yUXhIZGFHNk9hK0dyZTNuMlRJWTJuMk5mMTVjQ083eXRIV1RtTGxu?=
 =?utf-8?B?YkhkaWRiOXZnb0Y1dVhiZzltMEh1RXgrbHl2VmRtSUFraTZRSGREczE2cDkx?=
 =?utf-8?B?WmNjNTViZjJESGpzaXVtdGJkRWhQcWZzYVc5VzNRUHBnWjM1VVROQ0JzSHBM?=
 =?utf-8?B?dFMzQVJGR2RUMENmZ0ZDSFJ1SXphMVZ6VHliVjRuTWQ4S1ptMnFCRzhWU0Nt?=
 =?utf-8?B?bGMycW9pVEpPQ2kxVUpkQ1dVWG5WTXh6bndjYVN5Z3NoZGV3Y2NlTXJVMFpa?=
 =?utf-8?B?bDVIOE81WC9xMXZXYUNsQjhoWVdYVUhQTGJ3aWFzUXJmL1RldWhZWXQxTFJP?=
 =?utf-8?B?dWlFWXF2cEVNTXgrWVpNNExQbHBYdjZVN281dUZSMnBpaXFrbWMralhsY3VX?=
 =?utf-8?B?SnpIV0g1WWVqeUc2ZVFTd3ZvRVc2ZW5nZ0ozU3hxa1JXWS9VQXlZNFU3STJs?=
 =?utf-8?B?bk5PdG1pSEt4UWhaUkdUaWVGR1NtZUpTNHV5dTdldU5VVWhlU241VHkxSGZr?=
 =?utf-8?B?b2Exa0lYMnh4cFNnSWVZdnRxa1BlRGtidldNV2VPT2tnaWU4Um1ZT1phV1Vm?=
 =?utf-8?B?Z2RXRndybkZwajRYRnNTZnY5QlA1a1MwZlFDSG1iek9wNjRHSHZrbTBwNkxn?=
 =?utf-8?B?bzdCeXdmdkZzVlVicTBSRHpsUE1HblhudTJQdXM5L3JYN0tzTW5QUzhLYldl?=
 =?utf-8?B?Y0JFWHd0cy9EQks3dVlwN0wzYXZrNzYyUmw4Z0p0MEZibGMrZUtXZEZ4U2Jr?=
 =?utf-8?B?dDRPeFRjeGg4RFUzVHEva3ZIdGhaWHJRbmc4VWVJS1Fqc0h3SUwwSFBWRjcw?=
 =?utf-8?B?Y2FHSk8xUTd2NksvVVBoamQwejhpT1h5dHh0V3dsZ0RGWnF0bGw0UFhNdEVq?=
 =?utf-8?B?alBibEo2bFIyZlhxaUFQR3pKcXFIa01xOExaWElMRjQ1SGtaQW1Uczk0cXRS?=
 =?utf-8?B?WnJ6L3hTZ2NXYWFTMEpNYXlCMDJxdmJZRXc3dFVWY0VKTjdvQXFZVkcxaVZq?=
 =?utf-8?B?MzhGc2JqZkNrMkErMTNHSkdBUmpITmVrVEZQWmhNaDBGLzRuMnlhbUl1RGVB?=
 =?utf-8?B?bHhUVEJVQ3c2TmwyMlhNN1NuQ3A0S0xNcUFGS3EyVzUxNHVuYWdrblN6TDZY?=
 =?utf-8?B?NGwzUm9WS1A5M0VMS0hSS25Zek5NYmhiT1VHNFJWakY0Z09KKzZVUy91NHJZ?=
 =?utf-8?B?dnE4MmhMZzRqMW9OaG1xczRSRFlmVVZ1MzVTa3lwb2dCQ1lJQzZxUDNoZWND?=
 =?utf-8?B?Yy9vMEV1YVF4NGtSR3ZVUEVjTm5yNGJ0NmNBUW90SWdhQ3NBc0llMzZqakM5?=
 =?utf-8?B?S1VBL3NKVSs4d0VlUE1zbURQNWZrdFhtY3VoMVBhNGlZcmJQWVVXS0g5QTVJ?=
 =?utf-8?Q?1skejZnQxVj22WZFNeyoNJvza?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7160bf0-83c2-4860-4b56-08dcfc7adade
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 02:46:17.1373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sCOA5qhiaATy/xX2yLBcTQKiI2YSZgiIxQyiL4t6IbSFDxIititZdXT+ClrvQC//gNwz7U+n+eQtmWYYgFVRWQ==
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
> This will be used to implement the device IOTLB invalidation
> 
> Signed-off-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Acked-by: Jason Wang <jasowang@redhat.com>
> ---
>   hw/i386/intel_iommu.c | 39 ++++++++++++++++++++++++---------------
>   1 file changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> index 289278ce30..a1596ba47d 100644
> --- a/hw/i386/intel_iommu.c
> +++ b/hw/i386/intel_iommu.c
> @@ -70,6 +70,11 @@ struct vtd_hiod_key {
>       uint8_t devfn;
>   };
>   
> +struct vtd_as_raw_key {
> +    uint16_t sid;
> +    uint32_t pasid;
> +};
> +
>   struct vtd_iotlb_key {
>       uint64_t gfn;
>       uint32_t pasid;
> @@ -1875,29 +1880,33 @@ static inline bool vtd_is_interrupt_addr(hwaddr addr)
>       return VTD_INTERRUPT_ADDR_FIRST <= addr && addr <= VTD_INTERRUPT_ADDR_LAST;
>   }
>   
> -static gboolean vtd_find_as_by_sid(gpointer key, gpointer value,
> -                                   gpointer user_data)
> +static gboolean vtd_find_as_by_sid_and_pasid(gpointer key, gpointer value,
> +                                             gpointer user_data)
>   {
>       struct vtd_as_key *as_key = (struct vtd_as_key *)key;
> -    uint16_t target_sid = *(uint16_t *)user_data;
> +    struct vtd_as_raw_key target = *(struct vtd_as_raw_key *)user_data;

why not just define target as a pointer?

>       uint16_t sid = PCI_BUILD_BDF(pci_bus_num(as_key->bus), as_key->devfn);
> -    return sid == target_sid;
> +
> +    return (as_key->pasid == target.pasid) &&
> +           (sid == target.sid);

hence using target->pasid and target->sid here. Otherwise, looks good to me.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

>   }
>   
> -static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
> +static VTDAddressSpace *vtd_get_as_by_sid_and_pasid(IntelIOMMUState *s,
> +                                                    uint16_t sid,
> +                                                    uint32_t pasid)
>   {
> -    uint8_t bus_num = PCI_BUS_NUM(sid);
> -    VTDAddressSpace *vtd_as = s->vtd_as_cache[bus_num];
> -
> -    if (vtd_as &&
> -        (sid == PCI_BUILD_BDF(pci_bus_num(vtd_as->bus), vtd_as->devfn))) {
> -        return vtd_as;
> -    }
> +    struct vtd_as_raw_key key = {
> +        .sid = sid,
> +        .pasid = pasid
> +    };
>   
> -    vtd_as = g_hash_table_find(s->vtd_address_spaces, vtd_find_as_by_sid, &sid);
> -    s->vtd_as_cache[bus_num] = vtd_as;
> +    return g_hash_table_find(s->vtd_address_spaces,
> +                             vtd_find_as_by_sid_and_pasid, &key);
> +}
>   
> -    return vtd_as;
> +static VTDAddressSpace *vtd_get_as_by_sid(IntelIOMMUState *s, uint16_t sid)
> +{
> +    return vtd_get_as_by_sid_and_pasid(s, sid, PCI_NO_PASID);
>   }
>   
>   static void vtd_pt_enable_fast_path(IntelIOMMUState *s, uint16_t source_id)

-- 
Regards,
Yi Liu

